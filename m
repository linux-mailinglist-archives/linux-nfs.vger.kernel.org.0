Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E2BD6DA184
	for <lists+linux-nfs@lfdr.de>; Thu,  6 Apr 2023 21:37:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229600AbjDFThA (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 6 Apr 2023 15:37:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjDFTg7 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 6 Apr 2023 15:36:59 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AF2EE72
        for <linux-nfs@vger.kernel.org>; Thu,  6 Apr 2023 12:36:55 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 336FKHtv002731;
        Thu, 6 Apr 2023 19:36:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=Y4k8WeRWoQxmc4XO/c2U9agWLnAPU5UiFnbEgIgltwA=;
 b=d6FF+nY6F1uv7GEpHlCCewCSQcDSsFHrEf+E67c+iYvZpoU2uEHv47nPJUlpYT+3RUpl
 FCEYn5yq8mc+S2kURtfu5ywF47jR8+LShF3OGQa7SBX4/8knOIVFcFUPlxLtc1/vipO7
 Fu9xh7HUd0CBX66GVMBuKcMwcjuGR09wmBUQR1eMtdD5r/gH6XeTI898jRuzMTLEEriI
 mW7JuEjaMT4JPESpb2P2l9Sp7r1gK9xNZmiICB++vvV+eUwCusIFwdkXAho8kfN48vew
 MuetB3MHym0rAxG1WBatZ3Xp9oGulzphnjRb36A+6Xb+Nsyfzle+Zg8TVZ/QxhGHNFSI hQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ppcgaunrv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 06 Apr 2023 19:36:48 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 336Ie0s5008991;
        Thu, 6 Apr 2023 19:36:47 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2048.outbound.protection.outlook.com [104.47.74.48])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ppt3kfvmt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 06 Apr 2023 19:36:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DSozCkE93QFuhz2f/auWgHp6Fck+pYnsNeQa0tsXM1l1IMNl6a2ZHWhXd2o/zkZqMky5wQLNMqoXBgkiT1k5AR9GMzfMzouAFNmbww+h2wYMHE2W/oGbjHKIAoE1iYyHb8hSTAv0gA/0cKvZvGhQpP2SngC16Gs3Pd5KkcBypQSZMbbgpD1NIzSvHyk9bZ/rtEOZwIJpbfChmXEWUHVNBMWs999275TnJs4ZYo0LBllNzRFidFSUsLxLfhLcHvO6QoyB9CTTd78cHkypuBCJbKGZDC3GJEZZDRGHQyKjg9yC/DoyYtMZBbAFi7p26qEX5zKL/OjK6FSbYKIcNAfq4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y4k8WeRWoQxmc4XO/c2U9agWLnAPU5UiFnbEgIgltwA=;
 b=msIjJYGRl4I7JL80METrJpefxrsPGgAJP/IgdUCDSrwHutAj0EY1jUITC+AMdqfXHn7HWGNtdad1BmaRXYnQFLPCTNxBaXBkvKwJNxleouFlkhCmNPuwD0iMw4YxLQzPkQZSQsXOqB5Tv48/tdCqRYwc2YJWQoCjnifY+zDQR0Ml+u/rwoa2z9gVEbHJmQ23YwsM55N5BnWx+xeuxY23Yw6GPixDXfhg0qVkS5rsFowTLh3CC9JzOu4brJ1yzuHl5HAYCEiQB9gCafJxYz7xmGI2Gkaya51NJpp5ApyCR3apvMykOTbLS7d7yW7Bd4sTu4cbs02Z55CX9sXHcggx4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y4k8WeRWoQxmc4XO/c2U9agWLnAPU5UiFnbEgIgltwA=;
 b=vVIXNLqAL7qHvjFo/BKf/VyVCiUEK5O4olPzoWCdiHAkYSfiyyVWUN1TZ5pY9zndM3ENGb3mWhiahZENl8cq/CILlD39YywsMxuR3Eq3o9CpYswYzH43lHNWFl6+e9J2lpGz4eLSbt0JO5DzfVqdDD+L25ulHlqRogTfokssVG0=
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by SJ0PR10MB5694.namprd10.prod.outlook.com (2603:10b6:a03:3ed::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.34; Thu, 6 Apr
 2023 19:36:43 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::30dd:f82e:6058:a841]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::30dd:f82e:6058:a841%5]) with mapi id 15.20.6254.037; Thu, 6 Apr 2023
 19:36:42 +0000
Message-ID: <07d8f93d-c8f3-5ede-66a3-219eea0fdfe6@oracle.com>
Date:   Thu, 6 Apr 2023 12:36:40 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.1
Subject: Re: [PATCH] SUNRPC: remove the maximum number of retries in
 call_bind_status
Content-Language: en-US
To:     Jeff Layton <jlayton@kernel.org>,
        Chuck Lever III <chuck.lever@oracle.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Helen Chao <helen.chao@oracle.com>,
        Anna Schumaker <anna@kernel.org>,
        Trond Myklebust <trondmy@hammerspace.com>
References: <1678301132-24496-1-git-send-email-dai.ngo@oracle.com>
 <9D5A190A-333A-4470-8572-CF85EE9A8086@oracle.com>
 <182842b2-3de4-d64b-d729-f4f6c9c576d6@oracle.com>
 <ed870a33-0809-3cfd-2d5a-b97409568b97@oracle.com>
 <64c4e5c4e61962fd828bcbef79db1df6466a875d.camel@kernel.org>
 <f6c0553c49efd9e2f643240aacdea8dd1f728443.camel@kernel.org>
From:   dai.ngo@oracle.com
In-Reply-To: <f6c0553c49efd9e2f643240aacdea8dd1f728443.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR13CA0010.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::15) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4257:EE_|SJ0PR10MB5694:EE_
X-MS-Office365-Filtering-Correlation-Id: 61a9990d-05b4-4bc1-ee84-08db36d63fe1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jpYNw4MbT0CpGOOtBaHni/U5eKypMr0epcPgyPUkOk04u/H04j+p2f4P5ChLfbyI8HZ5Y46APVT3y/My2MGXFl4aVqbum1yyoO1WrYnjGoMPZKLa+FOBv2HDFb5R6AfcRzU3b/cFpOdcJ8tCjjyXY2Zc2EA/LjhsbiiNQZvdQr8e9+v1agpGCZQHiKGPt9ZxM0FjzOjfwsSWp/N1KY/05THhI93y7nJV5+Teyng96OV2Ntz2Z38hEXPROm0Z5VbRS5gzWSVBFtu887IaC42cEt3kUm58jvp9XcbAkvMegF8+qHaZ419dvZqWl2XGfEQlmI3liM+bgcLnlUVRMi+whnSr821FW57UB/K//lO7Kladdi0qeT7C/BkxkMSjxDxiERATNthwmggxkTlAkImBW+x4K7RrEQaQd5z4K64ckl0HNxYKv8tbkOm8HegAyYu6WuLR0CMHAD5MvIh9nv0qxGguXtKJkh7WiwFAZAiNzBWxuyYlB317K0IuCNYTcIla5xZlGyzqsIILOQvIg1LVJsOhZcsoR3ek/TwDmHeww5/at5asxUNxlhFjkLXKrv9yOFWaIgXKW3kccSFSIsb6Q6bZIobeEIhDAUaT5hycI5Taql4u0U3d3zcU93SQYM6p
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(346002)(136003)(396003)(376002)(39860400002)(451199021)(186003)(26005)(6506007)(6512007)(53546011)(9686003)(31696002)(110136005)(36756003)(478600001)(54906003)(316002)(5660300002)(6486002)(4326008)(2906002)(41300700001)(66556008)(86362001)(8676002)(38100700002)(66476007)(66946007)(8936002)(2616005)(31686004)(83380400001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YVFSZWVCdkx1MGxuYk12SkRLL3RzRnRZYjB0aExlcTBqZWFpbnZhMTh2N2Ju?=
 =?utf-8?B?QklqbFVEQXNKeFNFUFBWT04vUEVhd0grNzVIUElmNUp0U1dadCtSdHA5dHl0?=
 =?utf-8?B?cXFOYTJsKzdzNXUrRktHaEppT0tGV0xleGJJSkVHektXbWlwRDhqZUNwVU41?=
 =?utf-8?B?YWFDVDJZRVhzTFEvejBYbENXMjlXVTd3TXVjTGFZU2tLamZvWENKTHgvRHUv?=
 =?utf-8?B?VTNDOERSaFZWbXFDVGl3Um5tV0hpaXhzd1BDM0ZTYytwb3pGOEJaMUh6TUJW?=
 =?utf-8?B?TlI4ZEpURmZsQWQ2QVlRTWJteHF4d3J3RHlQQTd1YW95QWJNN1dDOUFiTFJa?=
 =?utf-8?B?dndaT1pxUTJRVFgrUVdGei9ybnFNU3B4YWVaMmhzZzNpRFZ4M1lxVENhSUEr?=
 =?utf-8?B?d2xkUldJUllXTmdhenNlMVoxdEdwV0lIbEQzYVpOc2tEK0RteFc2ajBmczI5?=
 =?utf-8?B?dnVHZmk3c3BOVHBhV0V2akY2L2lobTZNSk9vRGVabFpTd3dBR1lKc0NoMm5r?=
 =?utf-8?B?T0xtQWR5MVplMjFhRjFhRjIvcHlwKzVpNEdFRXVQRFNuUE9lYU9TTnB0bW9k?=
 =?utf-8?B?V3psZ3k0V3h1bGFuVkJoQjA0a25nSE9DeUhnbzdHTWZrRFE0OHdPRHJxbkRS?=
 =?utf-8?B?b2FmbURRODFGc0Uyc3RjK3lteEYyWlFXZUFqK2Exdk9tTExac05mbDluNGw3?=
 =?utf-8?B?dWVxYXpvdGV5Q3RrT29qNmZpa0EzYi8rM0pjTHZWLzNaVzRxZHVuVXc0OEVX?=
 =?utf-8?B?dVE0Z0tiU0UxM1Fub1FVYTFhNFJOZWE3SGt1eDJkTGlxRzlWU0QxNlM2bWJI?=
 =?utf-8?B?U0J2c2Q2L2ZRdmZuc1kvUmJhakZBcEs1bWRvWFE5ZE1KQkhGNndGdlhDQ1Z5?=
 =?utf-8?B?b2NRSWpaZW5QUGN0VDlxTlEzRWttS2w4NVpHUldxZUpBWjBKcDJhN1B5bHJu?=
 =?utf-8?B?TysvTnEwWkxoNW8zc1dKNXRlejlKZzF0ZGRUeVZIT0UxWTlTWEhpWTMvaXNS?=
 =?utf-8?B?cElVZDJxVTRzdHQyTmhpZHZ4NUVsUlU5SG9ZN3JaS1o5SWZSWGdvWElCdkZV?=
 =?utf-8?B?dDVycUtYdVFWenRyTThjamxkRDVJRzYyM2Njb3B2YUZEZnJFcHJVNG0vVm9C?=
 =?utf-8?B?SG1GTVlwTFlVa0ZGeFJZbmgyM3JrME9xcFE1aG03dlNUZEdodlFoaXBTSG5L?=
 =?utf-8?B?MnA4VDdTcjk5ejhRUHhDYUQ3UkNydjFjd3l2WnVCdVVhVnVTbnl2bzI1NU1O?=
 =?utf-8?B?OWhCOWlqbkVJb3lFbXM5Nzc5aTNuWDVyRFlmVGVyYUFEa0dQeDUzd0NNSGlV?=
 =?utf-8?B?VDlkNnM1YzB2c3h0b0dxZXhNM0dDQlUrQ05IZk1DWHlGaEplNE9TbzBnbzVT?=
 =?utf-8?B?d2VjMzJhdlRMSmY5WEVxL1RJYVVaSGVJSmVuRkZZU2NONHpPOWMyYnhxclp0?=
 =?utf-8?B?dERyQXdxRnJPcVJOanVWZGlWTkdpZVVzN0c2ZWovazZibkp0TnpXcnY3SlNN?=
 =?utf-8?B?QXpuaEJDcjErUnIwWENtK0RnRVF2YThoZDJzQmhwYmFuTG1Fckh2ajlENmdp?=
 =?utf-8?B?S3ZsZ3A0RHBvVWt4dkxIMDlZNy9WYmpRNmJ0S2FwbjcrY1FCV3Jwa1JQSWkv?=
 =?utf-8?B?NTR0cG1BLzRNLzFPR2pPNFRMTTNPUGxRTXhtVzhldWNSQ1BhcDlZb3diMWk4?=
 =?utf-8?B?Z3FjTGZ3cWhOcjIxaDduOGh4YmhHaVFjektwVDVrZUpoMnN6T2Y4WGNYTENo?=
 =?utf-8?B?dEwvUUJyUnN2VCtFcVE3QjJXdytycFdkUXlxaG9QMkdJV0dCL2dkMmxUemhE?=
 =?utf-8?B?elVZNWd6L1NVeExkTUgzbkl1VmFnYUhoOTdCaVFDclpuUnIxUi9JNTh2TVpN?=
 =?utf-8?B?UVJXZm5KNnkrQUNrSjhjaUl5emZORWQ2VzZac01KL1NJSGZLSDFqa2htWm0x?=
 =?utf-8?B?WXdGSXZjVU5uVGYwaFFxNEVQTmNGMSs3ZFBlSkxWaVJ3UDhQd1lDbXVQaURX?=
 =?utf-8?B?OEVRZzZaQklOYWtXRFM5YndhN2pUZHRlTk5EQlROWGNLejVwV3NZajhRQmdH?=
 =?utf-8?B?U2hqUkJTWE5aRjZSYlduOTVlUGViUHJFZklhaFlhUlQ5aERHa2pKTnp2S2RQ?=
 =?utf-8?Q?z8pvbuh9yVOqRTS8Ir5kREc/x?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: JQengTj+ARrOzo9J6T4zBeP53FsE30WMSF7wuqQtibwI3CLmVp0sdID79BWEesR0y+Y/nT02AhYtdWBSFA4rPFKkgnN4yvmtcXb+iUJXljNbzeJ0sDXGnTk1XJeQnUeWzaje0wUbhsUftDXsjf9vkHk5PihFAfKOKdafZ1zux76E3kCVRs66rHQi/lAOcJTZ3koFBJwEYnSZJZ7TPTbRpp9zADUtLxhuMU1df5sy5PM9Ag9ZJQwuzNNT8ASKLBn9Jgm4n3z5MJus82L5KfN85Y4GxLr5vGzqvICifsNFc83oWSbmI2EOq/qC4yaNyfSS1BRVSRUPogZTdSks5pMoGnXekcTyv51hef+7KmDtEqjHVRXPe6LKO0JtbuARzcYrhCgi4G002kJBq+h4Sisp4X86Q4ztkCxLMp7z18SdQAFZckBo/tCYsCi/Nv7E4+YVfLhlg/NtRGSGdXS1UNivgUnA2Mh3kdTnZZ4n2bYFniAmTpzz1T9Mr6FhSUnhTWkcjSSLq14JflpsEzP5nu1de/Mg36K22fc6bsg0IfXqk9jm6Dv8/wDhecs+2jjiwBfg0RlpGmScivT9anvfVtNrKe2XxzKmGDRhDxpat8rVwrfnVR0GehiRSEgXfsQPDf3luNh/gs7x1D1O2A2xCkJ8VNZubM3Yfgg6exdIk/WINqoJt8mVY2rl3YWKIhJy4Rz80+ixSB4NPW5B01bDwFlsnL17PShxZw13SUmqY9/efjN5gfcRgs09UKe/o/9zSIQTVJw0/kU8r6wJFtmNtFX+XBSkFm54hyOQ/+SFDIMFAnWE9YqqPq+hzlD7wkbZ6IprAqu9Bm2XvLkNdgMqvGVxew==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61a9990d-05b4-4bc1-ee84-08db36d63fe1
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2023 19:36:42.6805
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9Rbn2S98XuuWOqArJ8myYZzuE3gfNpljwNA7LGmzTZXboEjQjEKDdspPbNhqR3y5AU55mhnq+ct/N2OP5HMJGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5694
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-06_11,2023-04-06_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 adultscore=0
 suspectscore=0 spamscore=0 malwarescore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2304060173
X-Proofpoint-GUID: zNdrhexM1pnGmPbfYNR9kGVPxcnL3bTv
X-Proofpoint-ORIG-GUID: zNdrhexM1pnGmPbfYNR9kGVPxcnL3bTv
X-Spam-Status: No, score=-3.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Jeff,

Thank you for taking a look at the patch.

On 4/6/23 11:10 AM, Jeff Layton wrote:
> On Thu, 2023-04-06 at 13:33 -0400, Jeff Layton wrote:
>> On Tue, 2023-03-14 at 09:19 -0700, dai.ngo@oracle.com wrote:
>>> On 3/8/23 11:03 AM, dai.ngo@oracle.com wrote:
>>>> On 3/8/23 10:50 AM, Chuck Lever III wrote:
>>>>>> On Mar 8, 2023, at 1:45 PM, Dai Ngo <dai.ngo@oracle.com> wrote:
>>>>>>
>>>>>> Currently call_bind_status places a hard limit of 3 to the number of
>>>>>> retries on EACCES error. This limit was done to accommodate the
>>>>>> behavior
>>>>>> of a buggy server that keeps returning garbage when the NLM daemon is
>>>>>> killed on the NFS server. However this change causes problem for other
>>>>>> servers that take a little longer than 9 seconds for the port mapper to
>>>>>>
>>>>>>
>
> Actually, the EACCES error means that the host doesn't have the port
> registered.

Yes, our SQA team runs stress lock test and restart the NFS server.
Sometimes the NFS server starts up and register to the port mapper in
time and there is no problem but occasionally it's late coming up causing
this EACCES error.

>   That could happen if (e.g.) the host had a NFSv3 mount up
> with an NLM connection and then crashed and rebooted and didn't remount
> it.

can you please explain this scenario I don't quite follow it. If the v3
client crashed and did not remount the export then how can the client try
to access/lock anything on the server? I must have missing something here.

>   
>>>>>> become ready when the NFS server is restarted.
>>>>>>
>>>>>> This patch removes this hard coded limit and let the RPC handles
>>>>>> the retry according to whether the export is soft or hard mounted.
>>>>>>
>>>>>> To avoid the hang with buggy server, the client can use soft mount for
>>>>>> the export.
>>>>>>
>>>>>> Fixes: 0b760113a3a1 ("NLM: Don't hang forever on NLM unlock requests")
>>>>>> Reported-by: Helen Chao <helen.chao@oracle.com>
>>>>>> Tested-by: Helen Chao <helen.chao@oracle.com>
>>>>>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>>>>> Helen is the royal queen of ^C  ;-)
>>>>>
>>>>> Did you try ^C on a mount while it waits for a rebind?
>>>> She uses a test script that restarts the NFS server while NLM lock test
>>>> is running. The failure is random, sometimes it fails and sometimes it
>>>> passes depending on when the LOCK/UNLOCK requests come in so I think
>>>> it's hard to time it to do the ^C, but I will ask.
>>> We did the test with ^C and here is what we found.
>>>
>>> For synchronous RPC task the signal was delivered to the RPC task and
>>> the task exit with -ERESTARTSYS from __rpc_execute as expected.
>>>
>>> For asynchronous RPC task the process that invokes the RPC task to send
>>> the request detected the signal in rpc_wait_for_completion_task and exits
>>> with -ERESTARTSYS. However the async RPC was allowed to continue to run
>>> to completion. So if the async RPC task was retrying an operation and
>>> the NFS server was down, it will retry forever if this is a hard mount
>>> or until the NFS server comes back up.
>>>
>>> The question for the list is should we propagate the signal to the async
>>> task via rpc_signal_task to stop its execution or just leave it alone as is.
>>>
>>>
>> That is a good question.

Maybe we should defer the propagation of the signal for later. Chuck has
some concern since this can change the existing behavior of async task
for other v4 operations.

>>
>> I like the patch overall, as it gets rid of a special one-off retry
>> counter, but I too share some concerns about retrying indefinitely when
>> an server goes missing.
>>
>> Propagating a signal seems like the right thing to do. Looks like
>> rpcb_getport_done would also need to grow a check for RPC_SIGNALLED ?
>>
>> It sounds pretty straightforward otherwise.
> Erm, except that some of these xprts are in the context of the server.
>
> For instance: server-side lockd sometimes has to send messages to the
> clients (e.g. GRANTED callbacks). Suppose we're trying to send a message
> to the client, but it has crashed and rebooted...or maybe the client's
> address got handed to another host that isn't doing NFS at all so the
> NLM service will never come back.
>
> This will mean that those RPCs will retry forever now in this situation.
> I'm not sure that's what we want. Maybe we need some way to distinguish
> between "user-driven" RPCs and those that aren't?
>
> As a simpler workaround, would it work to just increase the number of
> retries here? There's nothing magical about 3 tries. ISTM that having it
> retry enough times to cover at least a minute or two would be
> acceptable.

I'm happy with the simple workaround by just increasing the number of
retries. This would fix the immediate problem that we're facing without
potential of breaking things in other areas. If you agree then I will
prepare the simpler patch for this.

Thanks,
-Dai

