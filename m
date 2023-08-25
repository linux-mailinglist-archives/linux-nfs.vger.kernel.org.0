Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 475BB7880C0
	for <lists+linux-nfs@lfdr.de>; Fri, 25 Aug 2023 09:17:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233389AbjHYHQg (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 25 Aug 2023 03:16:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243167AbjHYHQT (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 25 Aug 2023 03:16:19 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CF4EE6B;
        Fri, 25 Aug 2023 00:16:16 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37P5BOmL032496;
        Fri, 25 Aug 2023 07:15:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=6YWzcdABFG6xzqU3YwL+czI2k498tKhvtBrgz4rZuuU=;
 b=CfjG99wVgPuibgft9anqG4R9Vwt5cd2WVrQcWHyeFVX88Hx5vlq2Hz2TwDpE5AZJvCoi
 rZfg3kft100nHQgw7ykQxKFjvsEamxoDBTnt4gal6VrzvmdhjeH/Egj1FDUMFxSuHa1E
 VcqkdWoJsaBxn9E611PQVUjDJDcDtwhmM87QxYiy4MVQ+Wc5O29K8kseJbmKuOQh08TD
 03fa2oWpIGDRgzlkeXJ+j15+EPq5U1L37cgejZhyJpx9RimQjGAcgmbKYSZkk4LePPt/
 9kQqhqXXGsM6pVN/KD0LwF/LMjI4TY8epi7JXqgLbI7d81UnzH/LpK8kxu/OSq/bJng5 EA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sn1yvwut0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Aug 2023 07:15:34 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37P7ADh8002133;
        Fri, 25 Aug 2023 07:15:33 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3sn1yxry3y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Aug 2023 07:15:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L+OiuX5vRTeHapLtlSN+5SDObQ5uXZass7qZaZJJBgNeuIpEvU1WY5W3WdFJzXzHx1dnFC3CjM7cdv/ugfp68l7B5QbisHY2sslgj3/QdgXvIFY/iQ4vs+teWwWS0cr+G+6yT1yoMZJJzS4TShdHMAkgvOnNqD3S/3AGo9UEkGtbISzEebBKztPkOlEGNw6qjLC24s9BJ40gLfB7KQ8zjmDzbVkclPU30/U8EM1f8n9K7Y/Q31ZPBQ+AwIim1Y48ihG6mc2u5pEDPMgj7e802exHdaE2MlJAe7VJoSDEQlgxWrK2U+d/gTTIeRanbjdCkiPaR/nBBd+qFhB60hlCTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6YWzcdABFG6xzqU3YwL+czI2k498tKhvtBrgz4rZuuU=;
 b=i1JZCURn9k2vh7+zI9ReUxZfFvx/iKyiVjkrDMU5JQOXDJ2mAb1dD9oxnJW8KonDZq6hSVfEyNdNaafkX8pFl9JWit6mgLWWY5SBy75fjahlU6DJmyKAGA8iqC4V/a34QhiIueqw+5W6YU1+OZW7anSewCYFXERRzH5SHONt42SkMiJs3ySZMqnBB3z15/MyVzNFdCZPKIdbCz7vGEMLtJkoIaIAa+fJTs4lbNT3Kq65veho/VBEYjrdkSX5waJVm3iqNp8jK2Oa9fNJCj+HW+c9zMdY5G5PD7DY0DI/WhKin0PWBbe/ayApzc91F5D7l1rBbYbWgG/z1i0RAhd8mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6YWzcdABFG6xzqU3YwL+czI2k498tKhvtBrgz4rZuuU=;
 b=ev4M3QtKtBljli+QjiEhiIJ6lhPNcX6wunb0mxjREN++M5sPSKr0OSoiDZya52ILb1HQFinQP6bXBzGl5nf6VGL2vztxv46crRTD6L/0iaInPPau35XNp7ukaTGnaSSWIV6ntTvAKzckAjFXUTGZcCoHAII8NFmkkds3iKXEKXg=
Received: from PH8PR10MB6290.namprd10.prod.outlook.com (2603:10b6:510:1c1::7)
 by CH0PR10MB4859.namprd10.prod.outlook.com (2603:10b6:610:da::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.30; Fri, 25 Aug
 2023 07:15:30 +0000
Received: from PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::3ec2:5bfc:fb8e:3ff4]) by PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::3ec2:5bfc:fb8e:3ff4%4]) with mapi id 15.20.6699.027; Fri, 25 Aug 2023
 07:15:30 +0000
Message-ID: <6ea665b1-766c-64a2-218f-aace326604b8@oracle.com>
Date:   Fri, 25 Aug 2023 12:45:18 +0530
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH 6.1 00/15] 6.1.48-rc1 review
To:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christian Brauner <brauner@kernel.org>,
        Jeff Layton <jlayton@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org, Sherry Yang <sherry.yang@oracle.com>,
        LTP List <ltp@lists.linux.it>,
        Vegard Nossum <vegard.nossum@oracle.com>
References: <20230824141447.155846739@linuxfoundation.org>
 <CA+G9fYsPPpduLzJ4+GZe_18jgYw56=w5bQ2W1jnyWa-8krmOSw@mail.gmail.com>
Content-Language: en-US
From:   Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
In-Reply-To: <CA+G9fYsPPpduLzJ4+GZe_18jgYw56=w5bQ2W1jnyWa-8krmOSw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYWPR01CA0005.jpnprd01.prod.outlook.com
 (2603:1096:400:a9::10) To PH8PR10MB6290.namprd10.prod.outlook.com
 (2603:10b6:510:1c1::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6290:EE_|CH0PR10MB4859:EE_
X-MS-Office365-Filtering-Correlation-Id: 975d6038-213d-44e6-d1c0-08dba53b10a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 56dRF5F11pnuxosDNBWQBhVzKnnHacZv215hZgmjIIQqlFqN2iVlL+2yc+65N9Il2zI8NcA7s0N+VP6m2Q9Rc7nXHKRXgU3Ix8WADdPdrcjcSBsqVNMSehrloJwoEdV18hBg1M2L7MrMQ3//U1/X18Jn5/CASnZdVtWuFt1rsbWru36+JyP4J6xh1t/OstM7hpEMYdb3eyaiItBz7+9aSiyXv6xuX16KVEDEaIKlrrsyqFBnis85pDBCmdl7MD/hq+kQIOUbZGfBJA94k4gkD6a+/A1BPRxQp/+s3DbG+HpCIOK9TNoiDKxfL6Weh4OyTRJFdJBD2GDec6jO8WI7zCcTNoygNVaCEf6yMG8NOQjrqlujwNBUelzrbbiztXEwCEqngNJ0f7npl8jBxuWZp+lk4Sth5C0Y1dB+fwToI23eIWmI5yfteM9MFDfNmp3FGBGaVnBFAFg/5Ou9TT4jTCJL9+Y3WySb6CwyL8qhVBXgHkEyMKDRHsfr+uPWE3TTBS+g18wJokXP+dRIFomYydY71vY+NzDLPkTvGxUba74OGD8lilKiYdzzNdIXw11I9MLcLSCq8T9/j91vv2T9i1OJ3Nblrvr3qWjjdiAHxYUa5IUTTyS3Gmk2kF1jRKZjSLJU8ctb1PCo/AXVwA5dR8WavLUMJ9gy08AALQBsjHS6mpZxH1WUqree8MxVjp05
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR10MB6290.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(366004)(396003)(136003)(346002)(451199024)(1800799009)(186009)(38100700002)(8676002)(4326008)(8936002)(54906003)(31696002)(41300700001)(6486002)(53546011)(6506007)(316002)(6666004)(36756003)(66476007)(66556008)(110136005)(66946007)(86362001)(6512007)(26005)(478600001)(83380400001)(7416002)(31686004)(966005)(2906002)(2616005)(107886003)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UG5icHlRdmVaaTd5R3FET3EwVHBtZFRuMnJoOTVxTWhBUGFrUEpmaGdJZ1pi?=
 =?utf-8?B?WFovZVVFWUdIaVlBMUNLNXc1ZHA2RXpoZ0YrYnFLWlVnQzR5ZlovUzVPZFFy?=
 =?utf-8?B?L3phaEtyRGZlZ01kTHE3VnZnWXJQSEs4UmhHZ05YUGVrME5DbXV1MU92VUtL?=
 =?utf-8?B?RjhId2ZINlJzUXVuN0hxSWIyamd2dVRzdHRjODJyeGp1OGRQMHVWSm5qRjNv?=
 =?utf-8?B?SlZBamQ2UituRzQ1ajBHckpnRjQ4aGV5Q2pqM2xkRXdjSklBenFnSWV2T1J2?=
 =?utf-8?B?dmkvMTNPSjZxRy96dVJRZmtvbW1aZHI5bXRSSUFYeENVbXFqT1ZnWFVZVldM?=
 =?utf-8?B?KzFFSlczOTJHOVpsbzN2UjNoTXh2MDdzNWNoWjZrTkkwNXE4dlFFaHplWmwz?=
 =?utf-8?B?ZDZQczQrckl5ekNLVTBOQTY4NlNnZzI3UUltT05YVEpZSU9kaGNqM1BJRnNQ?=
 =?utf-8?B?S3Zua09xSk96dGVsNWZrWTY1WklUWjZYN2F2TllxZlNybVNOclJVcGMwM21N?=
 =?utf-8?B?QlR2aXozZUdld2JldmsrbUw0YU8wS3JMcHZOZVROekx2ZkI0MmliWWdHN0Nh?=
 =?utf-8?B?dzU1ckx3M3N2cHBub2lpL1dueDB0cE1Ec21wVndvd2NnbmF3cW5qUkI3L1RT?=
 =?utf-8?B?bTRxUGl1VzVYZ1ZGV2NJOXVrdE1wbzhnMEhPUjRwb3Y3cDhndWhwOUxWaUhM?=
 =?utf-8?B?UFZFMFdlTTVVdXRSb3NvNDFmL1pPL2FXVVJIZnVabVZ1U2d5RlNCTFVaWGVs?=
 =?utf-8?B?YTZIS0RMWHp4UTVoZ0FnZS9waGNjUXBIK3BxR0RxUlNFbXU4WHJsd0ZEc1lk?=
 =?utf-8?B?em5XQVZjU3Y2dmhjZjB5bWhBWnBQN0xqekUyTDJOS1dMM2l4UHMzOHhzc1RL?=
 =?utf-8?B?dGM1WEZLZnVwTXFzc3BQTWk0cXlJL2NKdGdhUjJOWXZMVUJnKzRlbHd6dnA3?=
 =?utf-8?B?ckZNeUhpNEphME5YVEFvYlJlcCtZTFNjbWI2azk4SHdKK0ZhaHdXeUNwK21P?=
 =?utf-8?B?TGxDbEtpOEJ1YVRWdklYSFRndWZVdkZUcTg1cWVUeGIvMFZMd2dIY2RXcnhm?=
 =?utf-8?B?YzZNcUliY3JmTXB6dnM0SUQwYUk1cjVEa0FzNXhUZW1HbmNKOUFiYWwyQVhF?=
 =?utf-8?B?azVZeU5WdUdsNk0xbVpheFNhRmI3Uzd6QzlyZ2llNE1vUUVwQW0yUUc2TXNP?=
 =?utf-8?B?WnhzU3R1cmpURXVBUGdlaUVDUkk2aXZiZDZIS2o0MXdRMnJYZ2tPVVlEMlJk?=
 =?utf-8?B?SjJMN041S0dRRXpSd1N4dWVSNDdEcGhqU1hMdnVnT0ViVVFFWndxSEFkTG8z?=
 =?utf-8?B?MkYxTnBZZ0RTWXBqOU1OblFGSE1LVnJtTVd6NngvbGlOV3M3blBERzFXb1lh?=
 =?utf-8?B?dlFCbVRNQXE4bkdiUkltc1h5MW9LVTBHM250d0J0NUpJTmV4Y3pzbnA3WEkw?=
 =?utf-8?B?UlNpcVVvYjB1cGV5V2k1RGd2NXl5TmROMVZDMUJxakdMcm1zYVU5MHBpZFF1?=
 =?utf-8?B?Y1ljVE9zWVl0ZVRqZ016L21KTyt4T3B2YU1vRk40Y1daam93aU9zbTZFSmY3?=
 =?utf-8?B?WkVqYk1KNENNdkVnZVE1TjBrWURuZ1JKMzRaNmJDR21JcW01QTUyK0JQckMy?=
 =?utf-8?B?QkVxTUpWbksvczJIazc5dFNxWVFGMWhldGhUQmZQRTVvb1NYeWp4Rm1LMy90?=
 =?utf-8?B?SWxxODdtN1Mxb3B3VitNbUZXRk12Vk5nUjVFNS8zdEZsVWs5VTBWS0tINys1?=
 =?utf-8?B?aXRkaTF4ZzVsbXFFWkF5QUExR2NkbWZoMDFBeXdzVk1IZS9DL29GcVUrYXR4?=
 =?utf-8?B?NXZTaWhQQVVQTEwwRi95Y2s1eGdXMHBnYVpqTGZkZjNya0tydzQ5elVpZC9G?=
 =?utf-8?B?VThNTWpzYTkvTzlPNmNpQ21MUyt5akNBQ2tRWUxUNFV4U0szTWNpVXBDMVZY?=
 =?utf-8?B?WnZmSUk5MWxpdTl1Y0N6bnk4Y1llSk5KQko5S01tanRDcEZLZjhtemc5bUF1?=
 =?utf-8?B?TThjWStUakV3ODA1alhmNmRVU0FFNzhhMzY0SjB6WTM0bmRWeVlXS3JYZDIw?=
 =?utf-8?B?aDFKa2ViWDZ0Kzl3S0xEZzcxRFZ1eDlmQzE2YXBDdXQ2NW5KVGI2Y00xWElG?=
 =?utf-8?B?TnFRbno0MEZtL0I1ZW1QQzlQZjBFRHcyaVdtRzFCM3lBL1p6d3Nwc3owMnNH?=
 =?utf-8?Q?5Avive22EOkON7QTJFtpLUA=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?aEk5cFRjUWJLeUx4TlBJM2krU3RhQkc4bEFNYUM1R2hRQS9Gb2t1THNsWmt2?=
 =?utf-8?B?dENMQTNxcFR0K3MyL3Q1a3ZpQUoxWXlIZHA2a1RlaWtDT1BjcVRjNUY1NGN0?=
 =?utf-8?B?RzNvYldnbGJSTWJjQUs1UXQ5WU11K21yNzFCMktiNSt5dmIvZkw5Yk9WbjVi?=
 =?utf-8?B?Ni9ES3VJVHVJOHJEaGJScHRxYnF6aHJpcmFOYWNGS0hUV3BCblJrcTM4V05G?=
 =?utf-8?B?WFpxYmxrdDNtUW4rRUlmVTVuT3V2WUNHY3Nhakp6KzlOZmpRZTJCSHlVQWhS?=
 =?utf-8?B?aklhQkt1RUdoT2I4bE5pSVY1Y3BMUUtsU0Yvc1JMRFJON1dudmZLOVlBeEM4?=
 =?utf-8?B?L1pJOXpwRlZtejRrNWxMcUhuSUFsM0F1T2t5SXkzVzg1SFVYSHZib0x6Wk9V?=
 =?utf-8?B?UTNtZGJzbEJoR0J5QnhMNGlWZlVLR3l0NDRRaGNtQURCc1hRdCsyM2c1NUJU?=
 =?utf-8?B?VW5XbUo0QVd4U0wzeCtXamJUQkdtaWg5MGxyRFFKQ2x2VTQraXJwckhnWUVB?=
 =?utf-8?B?MkdqeGNDdFc5M2VqcDRqNkJsQXk0NFlMcDNwUGR1Z29IalJiakl0WXdjamlZ?=
 =?utf-8?B?Vno1bXhDSnRIZjVKV0l4T3BxbmhJcklsc05HVkhSaXMvY1pXRHF3T1llck1X?=
 =?utf-8?B?WGxNaFBqd2QzVTM1YmdwRkdpeVN6SkxXTkJ3RnhQNWx1OGVZMVRMVTUxZW9D?=
 =?utf-8?B?bVJIYmdhVk1nWkJ2T1pveERlWCtTUm83cjQ3ZVlpakg5ZVVvU2E4cmRCYTdL?=
 =?utf-8?B?NW1jTnZSdkh5ZkNISUk2RjZodUV0ekZVRGdONnBvMW5EVzVnZUFCTU5sOTV2?=
 =?utf-8?B?Z3JKdHErNXp5d2FZemN0dE9mMm0wMlczMXh2R2kraEkwajR3Qjdha0hPVVFx?=
 =?utf-8?B?b2V5MjFrVE95Q0VscDRHODNla3pzNjA4dnE0eEoyV2phS1pVWEkxWlBsUE13?=
 =?utf-8?B?YzZRS2JvZ3pEYUVSU2VvOTg3dUpLTkppa3VZNndoSG0wZFdPRy9Mc21VYXhE?=
 =?utf-8?B?dVFRK1Rzb1lEeVZDU2QrbUtUWXpQenRGcVZnMEIrdU5qUTg0YjdkTC9YeWFw?=
 =?utf-8?B?ZTJwbjMwRkl2dzhEcUltWkJVSkc2Zlp3NWF1enJ1V1dxcHFVU2lWenY3RC85?=
 =?utf-8?B?aWRoSGx3SHVYWmNnWitvaE5XM1hRSjdHSG9BOUlrRlB0VTZ0c0tjNy9ISzlS?=
 =?utf-8?B?ZkJtNmVBd0VTY2xVRlVjM3g2QldGNHBKQlFRZGNtRnBnRUI2dnJrWDltVDB5?=
 =?utf-8?B?NEVObnJPY1ZqWEpYcGlWS2plQmtXdmdtbHlVaGZjelhIVzBLZGRlU0NDNWJv?=
 =?utf-8?B?aXN2eWtYMTZmMEJRTFRZY29JalBOTjVqVzJTT0d5clYyOXIxdG1xbDBBTjAw?=
 =?utf-8?B?NFZPQncxZk13dFdSMWh5U2FLSmQ2OTRvWXdjWDVGTkFyUDM1V0IrTnpMdnZ1?=
 =?utf-8?B?T1ZQZEdMNlh1bDc4SVZ4dzEyT2lOeDcyU0tlM2xja3dITWxEd2FIMlNwVnov?=
 =?utf-8?B?aG53WGJrcEg5eEwydk4wdmF3SGlsN3NXRkl5dFlVVkNsb0Jlam8vb2pDazQ0?=
 =?utf-8?B?Rkw4SnFqWm52cGY2WENrZFM1YUJGRm5scGJYa29kRmJXWnhrTVloU05BZFp4?=
 =?utf-8?B?L0Z6MWp2NEkzYVVWZWRacFNGbGp5eG82NEkzVzZKU0s0N0k3WUpvS3VrTjhX?=
 =?utf-8?Q?onHGEQ7KCP3GRoKIllnJ?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 975d6038-213d-44e6-d1c0-08dba53b10a6
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6290.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2023 07:15:30.7282
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JBQwf7sadXo9k5b0ecBZA1qAD0sJjlFgwwlfFJPUkQevlTcBMHKMt5dvEBjEl+ZJArLY2VxC9MSQyJ02Co2MR8UWFG34nG1XAkgG+Ecp3BdE+H3HEr+lou8LCzCI7NrU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4859
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-25_04,2023-08-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 mlxscore=0
 bulkscore=0 malwarescore=0 phishscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2308250061
X-Proofpoint-GUID: LMGNzcSEypdSAhnL90uZbw51fd4NclmE
X-Proofpoint-ORIG-GUID: LMGNzcSEypdSAhnL90uZbw51fd4NclmE
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi,

On 25/08/23 12:35 pm, Naresh Kamboju wrote:
> + linux-nfs and more
> 
> On Thu, 24 Aug 2023 at 19:45, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
>>
>> This is the start of the stable review cycle for the 6.1.48 release.
>> There are 15 patches in this series, all will be posted as a response
>> to this one.  If anyone has any issues with these being applied, please
>> let me know.
>>
>> Responses should be made by Sat, 26 Aug 2023 14:14:28 +0000.
>> Anything received after that time might be too late.
>>
>> The whole patch series can be found in one patch at:
>>          https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.48-rc1.gz
>> or in the git tree and branch at:
>>          git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
>> and the diffstat can be found below.
>>
>> thanks,
>>
>> greg k-h
> 
> 
> Following test regression found on stable-rc 6.1.
> Rpi4 is using NFS mount rootfs and running LTP syscalls testing.
> chown02 tests creating testfile2 on NFS mounted and validating
> the functionality and found that it was a failure.
> 
> This is already been reported by others on lore and fix patch merged
> into stable-rc linux-6.4.y [1] and [2].
> 
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> 
> Test log:
> --------
> chown02.c:46: TPASS: chown(testfile1, 0, 0) passed
> chown02.c:46: TPASS: chown(testfile2, 0, 0) passed
> chown02.c:58: TFAIL: testfile2: wrong mode permissions 0100700, expected 0102700
> 
> fchown02.c:57: TPASS: fchown(3, 0, 0) passed
> fchown02.c:57: TPASS: fchown(4, 0, 0) passed
> fchown02.c:67: TFAIL: testfile2: wrong mode permissions 0100700,
> expected 0102700
> 

Note:
These both test cases are failing in 5.15.128 as well.

> 
> ## Build
> * kernel: 6.1.48-rc1
> * git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
> * git branch: linux-6.1.y
> * git commit: c079d0dd788ad4fe887ee6349fe89d23d72f7696
> * git describe: v6.1.47-16-gc079d0dd788a
> * test details:
> https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1.y/build/v6.1.47-16-gc079d0dd788a
> 
> ## Test Regressions (compared to v6.1.46)
> * bcm2711-rpi-4-b, ltp-syscalls
>    - chown02
>    - fchown02
> 
> * bcm2711-rpi-4-b-64k_page_size, ltp-syscalls
>    - chown02
>    - fchown02
> 
> * bcm2711-rpi-4-b-clang, ltp-syscalls
>    - chown02
>    - fchown02
> 
> 
> 
> 
> Do we need the following patch into stable-rc linux-6.1.y ?
> 
> I see from mailing thread discussion, says that
> 
> the above commit is backported to LTS kernels -- 5.10.y,5.15.y and 6.1.y.
> 
> 
> ----
> 
> nfsd: use vfs setgid helper
> commit 2d8ae8c417db284f598dffb178cc01e7db0f1821 upstream.
> 
> We've aligned setgid behavior over multiple kernel releases. The details
> can be found in commit cf619f891971 ("Merge tag 'fs.ovl.setgid.v6.2' of
> git://git.kernel.org/pub/scm/linux/kernel/git/vfs/idmapping") and
> commit 426b4ca2d6a5 ("Merge tag 'fs.setgid.v6.0' of
> git://git.kernel.org/pub/scm/linux/kernel/git/brauner/linux").
> Consistent setgid stripping behavior is now encapsulated in the
> setattr_should_drop_sgid() helper which is used by all filesystems that
> strip setgid bits outside of vfs proper. Usually ATTR_KILL_SGID is
> raised in e.g., chown_common() and is subject to the
> setattr_should_drop_sgid() check to determine whether the setgid bit can
> be retained. Since nfsd is raising ATTR_KILL_SGID unconditionally it
> will cause notify_change() to strip it even if the caller had the
> necessary privileges to retain it. Ensure that nfsd only raises
> ATR_KILL_SGID if the caller lacks the necessary privileges to retain the
> setgid bit.
> 
> Without this patch the setgid stripping tests in LTP will fail:
> 
>> As you can see, the problem is S_ISGID (0002000) was dropped on a
>> non-group-executable file while chown was invoked by super-user, while
> 
> [...]
> 
>> fchown02.c:66: TFAIL: testfile2: wrong mode permissions 0100700, expected 0102700
> 
> [...]
> 
>> chown02.c:57: TFAIL: testfile2: wrong mode permissions 0100700, expected 0102700
> 
> With this patch all tests pass.
> 
> Reported-by: Sherry Yang <sherry.yang@oracle.com>
> Signed-off-by: Christian Brauner <brauner@kernel.org>
> Reviewed-by: Jeff Layton <jlayton@kernel.org>
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> 
> [1] https://lore.kernel.org/linux-nfs/20230502-agenda-regeln-04d2573bd0fd@brauner/
> [2] https://lore.kernel.org/all/202210091600.dbe52cbf-yujie.liu@intel.com/
> --
> Linaro LKFT
> https://lkft.linaro.org
