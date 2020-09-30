import 'package:dio/dio.dart';
import 'api.dart';
import 'dart:convert';
import 'package:oktoast/oktoast.dart';


class Http {
    // 创建单例
    static Http instance;
    Dio dio;
    BaseOptions options;

    static Http getInstance() {
        if(null == instance) instance = Http();
        return instance;
    }

    // config it as create
    // 构造函数
    Http(){
        // BaseOptions、Options、RequestOptions 都可以配置参数，优先级别依次递增，且可以根据优先级别覆盖参数
        options = BaseOptions(
            // 请求根地址
            baseUrl: Api.BASE_URL,
            // 连接服务器超时时间
            connectTimeout: 10000,
            // 响应流上前后两次接受到数据的间隔
            receiveTimeout: 5000,
            // Http请求头
            headers: {
                "version": '1.0.0'
            },
            // 请求的Content-Type，默认值是"application/json; charset=utf-8",Headers.formUrlEncodedContentType会自动编码请求体.
            contentType: Headers.formUrlEncodedContentType,
            // 表示期望以那种格式(方式)接受响应数据。接受四种类型 `json`, `stream`, `plain`, `bytes`. 默认值是 `json`,
            responseType: ResponseType.json,
        );
        dio = Dio(options);

        // Cookie管理
        // dio.interceptors.add(CookieManager(CookieJar()));

        // 添加拦截器
        dio.interceptors.add(InterceptorsWrapper(
            // 请求拦截
            onRequest: (RequestOptions options){
                // print('请求拦截...');
                return options;
            },
            // 响应拦截
            onResponse: (Response response){
                // print('响应拦截...');
                return response;
            },
            // 错误拦截
            onError: (DioError e){
                // print('错误拦截...');
                // return e;
                return {'msg':'服务器通讯故障','errorCode': 0};
            }
        ));
    }
    // git请求封装
    get(url, {data, options}) async {
        Response response;
        try {
            response = await dio.get(url, queryParameters:data, options:options);
            // print('git请求成功-------${response.statusCode}');
            // print(response);
            Map<String, dynamic> result = json.decode(response.toString());
            // print(result.runtimeType.toString());
            // print(result['msg'].runtimeType.toString());
            // print(result['errorCode'].runtimeType.toString());
            // print(result.containsKey('errorCode'));
            if(result.containsKey('errorCode')){ //判断map中是否存在某个key,返回bool类型
                showToast(result['msg']??'服务器通讯故障');
            }
            // print(result.length);
            return result;
            
        } on DioError catch (e){
            // print('请求出错------$e');
            formatError(e);
            showToast("服务器通讯故障");
            return {'msg':'服务器通讯故障','errorCode': 0};
        }
    }

    // post请求封装
    post(url, {data, options}) async {
        Response response;
        try {
            response = await dio.post(url, queryParameters:data, options:options);
            print('post请求成功---------${response.data}');
        } on DioError catch (e){
            print('post请求失败------$e');
            formatError(e);
        }
        Map<String, dynamic> result = json.decode(response.toString());
        return result;
    }

    // 下载文件
    downloadFile(urlPath, savePath) async {
        Response response;
        try {
            response = await dio.download(urlPath, savePath,onReceiveProgress: (int count, int total) {
                //进度
                print("$count $total");
            });
            print('downloadFile success---------${response.data}');
        } on DioError catch (e) {
            print('downloadFile error---------$e');
            formatError(e);
        }
        return response.data;
    }

    // error统一处理
    void formatError(DioError e){
        if(e.type == DioErrorType.CONNECT_TIMEOUT){
            print("连接超时");
        }else if(e.type == DioErrorType.SEND_TIMEOUT){
            print("请求超时");
        }else if(e.type == DioErrorType.RECEIVE_TIMEOUT){
            print("响应超时");
        }else if(e.type == DioErrorType.RESPONSE){
            print("出现异常");
        }else if(e.type == DioErrorType.CANCEL){
            print("请求取消");
        }else{
            print("未知错误");
        }
    }
}