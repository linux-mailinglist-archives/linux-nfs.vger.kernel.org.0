Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0744F7E2BC5
	for <lists+linux-nfs@lfdr.de>; Mon,  6 Nov 2023 19:18:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232348AbjKFSSl (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 6 Nov 2023 13:18:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231739AbjKFSSk (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 6 Nov 2023 13:18:40 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B5DAD61
        for <linux-nfs@vger.kernel.org>; Mon,  6 Nov 2023 10:18:36 -0800 (PST)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A6FkZC7022018;
        Mon, 6 Nov 2023 18:18:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=VBTW3Hfp5lRNgo7Euitr0DZUsm6Ns4UgGtNPUzwi90E=;
 b=zIQlq9eu5ZtiQYLc5DX7ZgPkLgeATFINHIOHqtmn8/BV+whOA3mEKc/I8Pl/QMN4RJU5
 2fzzrOEkWtu4I+0Y/NzMy9xgwV8okLDfqSt1F3R2koIonbGh/TkZwatetL8oVk0u4rDf
 sqVe/anjPGJUic40JYRBLcys/p3tDu1v877fGfqP8KgYNEecvGmlGpV5n1nfI5Bgn68y
 neXHO1+XK9VxE7BBgxpkQwwTIkhPWs2WafDa9Kns3Qj9AfE+7Y69uJzKpyt665SDDTys
 YCBel6o0siKJg84vPgFFdcaG/4HfsWwbwWrLT8gZicNijigIId58k0NgFhA5QIK1HdG5 Yw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u5e0dv20g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 06 Nov 2023 18:18:33 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3A6ID3G8023579;
        Mon, 6 Nov 2023 18:18:32 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2041.outbound.protection.outlook.com [104.47.74.41])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3u5cd5a38u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 06 Nov 2023 18:18:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K3CJMqrBgaE3a6QrpUG/OOefNZl1nvbgGVmFluLOhGH/decW4x6UqXeDzV7YrzJR0joJYbzcYZuAAJfBWqzIBS2UbBBF65473TilglgrIauqvcbJ6K3bv6FM6IWX9iq7fN4AMqhAn+I0N/dHX8eAz/o6RKYf8W1j2VzUntFyyBxAykUr0YsBAtmmCIKSVPK8V7JKeEzM0mPhAXhhHO9/0F4U53fRelQVc1CXKXbg1adFy3yujy5nyE6cnKnRpW4pRuAuhBxks1oKehIsvy7+MmBiHrezmyGj62WcJ4DDBVRkTYUVVkZ67ZjT/mqb2nGy/BWSLzbi9At/CkjlQKJsUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VBTW3Hfp5lRNgo7Euitr0DZUsm6Ns4UgGtNPUzwi90E=;
 b=JpAHuCC+Jv2jdwRUGgfebZC4EmRCG4FFSiKjmwUd69OM0lf86hqsxNFwnYoTKXugowFBS0ahaAKkvIPzQIDWNfuATOdYFE+wJW2cQ4NdM0yzH43FEeWfOR8f+jzeAXc/11DVP4XHQL/ipE7qhl4g64pD3ccMIA+30IJNHEISx9iSsShNxKBtf5UwW1/bku6VweSB82yDnn0CNGFajNzLRbPPHuJL7FVzFfyDmIyC5mrYAFsKTvB3kXCPzsVy+aXj4mxle0oZTBdR+Df9O0ypcokQF9EYS69zRNSqkmT5Ao8G/bsI2KHKP1sCQF9z/sNIEsrOvGfPgCTJ6et5SsHGww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VBTW3Hfp5lRNgo7Euitr0DZUsm6Ns4UgGtNPUzwi90E=;
 b=Ke0sBuPccb5nxJjMpc6FrbP57itrJblCTLcH7XF1/eN24/73yBJ06/ngFgRZQA9Nkwgn2f2a+e5/LrNXd1/9yk8llY6IInb9R6eALmPF0AHrU81goGwa4h5BdYcOlFC7FbpD+d0N9+UyHu98egGBKTzUNE5pvlUgf20quwRtHPs=
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by IA1PR10MB7310.namprd10.prod.outlook.com (2603:10b6:208:3ff::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.27; Mon, 6 Nov
 2023 18:18:30 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::195d:7231:581b:2c92]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::195d:7231:581b:2c92%6]) with mapi id 15.20.6954.028; Mon, 6 Nov 2023
 18:18:30 +0000
Message-ID: <c53af0da-58f4-4981-9006-a6acbf404de4@oracle.com>
Date:   Mon, 6 Nov 2023 10:18:27 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: General protection fault in nfs4_setup_sequence caused by
 delegation return task
Content-Language: en-US
To:     Trond Myklebust <trondmy@hammerspace.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
References: <151d80cb-33dc-4266-a3ba-4b89ea80e49f@oracle.com>
 <971e0321c1637fa4bb8625b618734fa8b229b0e0.camel@hammerspace.com>
From:   dai.ngo@oracle.com
In-Reply-To: <971e0321c1637fa4bb8625b618734fa8b229b0e0.camel@hammerspace.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PH7PR10CA0015.namprd10.prod.outlook.com
 (2603:10b6:510:23d::17) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4257:EE_|IA1PR10MB7310:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c0638ae-08e6-4dae-5e1f-08dbdef4c769
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GwnJTr5tg+fbjFoto/7HByLLuWhOnz/BBeHZeZIqlzwr51bgbzn/L7ricwlxpZBvoScaJONSLHu56FmEjzYVCkw4x/YO7IQm+P/4m0zHqR65bFO1cJ1TPwIff5kg3nGYM88NvrKrrHwfNhqGSgj4sQ/LLvuQM9u3ATu3jp+SrrPs+8S5sPjp3A8Xqj7+fO2K42E3kX5AOLJB0RjEHIrKHL1iZo0Waq4HMPMaacrvjz8eriuzflFq8eNNNt08LwEIAp+2Pg3maolCpJiWcdw0ID8MWjrynbLxuX1PNfO0olp0hUolaCUgAEuwF5L5k9oGV9OI4H8XYRACRdaqKJVWCpkMCM6yS+rrWHDm/fKoLjJ0IoMx9WNamhcApyVRPVHr6YhbGH88C3RILjQ1taG00znKGxLgsF4/ToIZzgEg5OTxhXC6NcmAZx8e2KXS29np83EE4u5WmEsbzCiAkCG5CZ7m+DKx5wXxzd0o5GRy2Yi0aoDcxd4Kim5EcwlmYBWQyTKHhWU4+6hUEYkf0K092TF2TEZVdtXXB0v65gjWOyuw30YCbW1qUuOWipULC2d1whb+Ure+pOsBabGumuJfFOBzuEUkTiI3BkU45MBHNqjjkGGkKOh9lGVuczEvQ9JD
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(136003)(376002)(39860400002)(396003)(230922051799003)(186009)(451199024)(64100799003)(1800799009)(31686004)(36756003)(31696002)(86362001)(2616005)(26005)(9686003)(5660300002)(6512007)(6506007)(6666004)(110136005)(6486002)(316002)(2906002)(66476007)(53546011)(66946007)(66556008)(478600001)(41300700001)(38100700002)(8676002)(8936002)(83380400001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M09IWjduQ0pHaFFQRWJJSzllYzRidjlXNXZvQkpob3ZIU2pMRFJXakxMLzR1?=
 =?utf-8?B?blMwV1dZem5JZmJCLzJJYUlLU0Nmd0l1eURoK0RuWlBtWUFQQkRKbnlIOUs3?=
 =?utf-8?B?em8yZkFHcEFEWTI1bTc4RnJRU29qN0ptUjZKNE9ha2E0MWxDQ05rUGVyZmZW?=
 =?utf-8?B?UExMYytMcnlxOWFkTU5ZcGY0VExZMWVzMG1NaDFZTUFLN0llZytRWGFMOGlG?=
 =?utf-8?B?YUwyUDNyZVVxSGVOY090TE1yUGxJb2U1RC9udDFzeG5VMTB1RzNJazdZb3dh?=
 =?utf-8?B?dFdYU0ZhVHJBQVFEUzZPWHphNzJ2TjhwZzVpTStoMjVKMmY0TTgzS2dIR0k5?=
 =?utf-8?B?d2JpbkxqVlRRczEyV3V1SkdWYkxacWNSL0RwWXVlSWxtbkl3QlhNRXRCUmFZ?=
 =?utf-8?B?alhXcFJIQnp2bjFYTU9KQzNmNGJ3T0E5YU1udGJMVmk3TWxYdDVnbVMwOW40?=
 =?utf-8?B?b0ZOdVRGcUV3Z1F2ZDVsMDJOc29FNE9DTndKTXR3bVZuei9NY3ptOHpOUjhX?=
 =?utf-8?B?cTcrY1lKeEtPdW1pWVcvdThvYmk4TEppNE5aWUhSK2Y1cTFKSis1NWh1Zis3?=
 =?utf-8?B?Z3hPTnNxQzEzUE04cTl1VkdvVmJCMmZ0Ry9mTzg5aWlEWCtTeTlvK3RPaTVD?=
 =?utf-8?B?VWZjS0JMay9xWTk4MHdSaWVYb1ZPVndyOWloRXQ2dDRzbm54c3hsdFJiS1NV?=
 =?utf-8?B?M0ZUVmczeVVmbzJvOHlEcEc0enY2SHJRL3N5dmt5blFlZEJ5cE04NmNEMmJJ?=
 =?utf-8?B?T29IODE2dTR1azU2VEEwMXdGWGFmV0Nqd25UVXhaeUZEQ2UyWVpvZVdQQlA5?=
 =?utf-8?B?bnVBaldESUNMTmpIakp2MnFyQnY5eUR6YXR3UmNncVo2T2g5YmZpNmsvTWw2?=
 =?utf-8?B?NTk0K2FXY1ZrTTEvSEg5S1I4M1VEMnl3a1l2SWNlMFJhYVZkN2FKbTJWUEky?=
 =?utf-8?B?ckxGQ2ozQ1M1YnZSUUQ4QW5Pa0NXMjNNMzBDZUM2UnN3dFlBWnhnZXdFRDVi?=
 =?utf-8?B?cjhyWVFJYXpscmlSR1R5TkNqMzUrZ1JnSFZ5QmlWelpueTNkbjh1MmdsZjJh?=
 =?utf-8?B?dGhyMEFxbDkvWlBkU1YwNmY4cGZvUGFtNTZxeFJIOUdmY3lPbWJzdkVnZHp6?=
 =?utf-8?B?R1dGd3doUVNQN0lCVlNrRzF6WXhUZklOdG5QOUhTUHFabW9WZHBQU2EwOEpo?=
 =?utf-8?B?T2FZSXhDVGRHNEtReS94VzR2VDB4QWxFcW45Y2FGZlZYb2VCWGtWWHVJcmJS?=
 =?utf-8?B?dlErWUtGRGRDLzk5UEtlbjZ1OHhscDNXYmNVSTNxT2xtREJycDZTNDhrcnZI?=
 =?utf-8?B?VVh4cTNLQ2cyWWhMWDMvZWRtTTdFQjM4eSs1MjI4N01kL092dWRWbVozY1l4?=
 =?utf-8?B?L1pGZXFtME85UFR0WHNQSFpQM2lpVHZCSyt3YnNNUGNCV21jdk1NNjQ0Wklj?=
 =?utf-8?B?ajVmWkpYRnlHa2RjNDM5MDNDVUlpZE1Kd1JLdGVINzJpVUdQQzgrZzR4RHdD?=
 =?utf-8?B?eklGSWdsbDZseXRpbkppRFJpR012SjMzcTBYWG55YmFjTm9Vd24yb2xLMFdH?=
 =?utf-8?B?THc5bk16WG5DZExGUW5IZTE1ZlA3Z01jcFJ5Wm1ab1U4c1pjZjZiNjV3K1Vm?=
 =?utf-8?B?QnV6cnRhUTVkM09yTUdWUlBROW52Y09NMk5IOVd4MzBDY1BPbnIybTlBdDZm?=
 =?utf-8?B?dXFrVGk3WUNRT09CdkJKdmI4QlhZR3pGVmUvVVZpUElMVkVzSGJ4Z3lXTVVM?=
 =?utf-8?B?Q01lWE1xSkIzUzBxWURjQ1RMaUViaktrN2xCdmZhQTRsaHp2RmQ4T2hXeEdL?=
 =?utf-8?B?SnhxNGdPUEJRWHZmRDkrVE5mcFMwWHpqOEUxQm5rclpuL3ZudFFZKzBPWEhv?=
 =?utf-8?B?YlFEa0tYaW1QRUh6OXVGZDhrTnF4NGVMN1RqYXpKWENQL0hZeTRWUktMOFFt?=
 =?utf-8?B?ZERSS2E1UDNkT09VWGN3UmNiMUREaXAvaml3UlE1MVVZRTBweHl6TzJUZTRL?=
 =?utf-8?B?eGVrNWUxNHR1dk9lYUh3Z3owOXJNYjlFbnlseFd3MVlIUG8xdFBDSlhxRW01?=
 =?utf-8?B?Y3dvaGgxTFUwSXBhYS9oRk9CTmRjd3dEcVNQWGNXTTNZZ0JIQTR5VXhhb2Er?=
 =?utf-8?Q?p7zKlh8JDbyvOhw7UDTDmZDUH?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 5XCmlizES1mfuESbg3WW/4xaAldu0o2KqNE5/vhHNEKEqq0FgSFOPm7MTqxb8XXhDv3B7jYf0K//k6GSPW8/GvC1cG1BOoBGdnJ5wpWG7FfYvE9aiY1zi+wO/QIhhKBubQlLQMfrawMvUz0gy1v4NT4FFmhA5CK8YNC9SzCQQIvGJZJnLWF2ynV8RipZrY1Pmzl2/K1Yt89o3OkX+sw+kDin8t3Qg39k3wmsXphyKWEFH9358TA5Oen3JHGRZW2SRg4UXkSqzo14UpByFYMKKJGF3eWkWZIApi9crFgDAGD1QcsHXZwi2a+7OgUuKawfkEQwOEB8yctMuQ0dGONuZNBMiw+ZtbTpzfqwoNhZUJtqL3zxDmAfW0L6H0okM7LuH63KIPgdjIGpPp7WqUPadVypu2md7+Bvza+PjpBSeXKiEQaeXjEHB7lKd+ZP+kWYIBl3Jv85OBAJDjcN1yBWaRHoj9FXhDUbQYl6cqSX11ZQn0jQmfuX66HljeMBRJ3fFfobq5oWHBluhwNmySNCbGI/J0SgcfjgLVXL3ignBDsG7xREq037F10bC/0yfxN0fc8xpE8VtUSZYztHm3T8+JYpO/gWnNQ2cLnmPeO/Cv0DIeFkQUe3q0rBul6MK0kdE8g9rRPa6FLMLjvmU984vuOhyJe6YUkAwoD9WUl0B9cRErKEBgarL9lMBmvPZdxY7DXtSQacISStYr1X9K0hcS5to7jRgKhuN7jrTJrsMFxHnHn9aXZZX08OX8OlpDYy268T0dzkjF/jTaC/fNCTyc7yQxahCwcDmGXsEQ/O5wVItcSYeBvSsok59yUNPEec
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c0638ae-08e6-4dae-5e1f-08dbdef4c769
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2023 18:18:30.3509
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EAs4/yEFSV7sm+gkRpk6l1oBFHT1KRtZbMxfnjWOtqn6VWTU3jck77TLNEmRmGpAmGsPwU5w0Y+fPc+oxvX0tA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7310
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-06_14,2023-11-02_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 adultscore=0
 suspectscore=0 phishscore=0 spamscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310240000
 definitions=main-2311060150
X-Proofpoint-GUID: mTVVLLR9Yh9qBS7iEF-N9gYGA8Ad62Ma
X-Proofpoint-ORIG-GUID: mTVVLLR9Yh9qBS7iEF-N9gYGA8Ad62Ma
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


On 11/6/23 8:30 AM, Trond Myklebust wrote:
> Hi Dai,
>
> On Sun, 2023-11-05 at 11:27 -0800, dai.ngo@oracle.com wrote:
>> Hi Trond,
>>
>> When unmonting a NFS export, nfs_free_server is called. In
>> nfs_free_server,
>> we call rpc_shutdown_client(server->client) to kill all pending RPC
>> tasks
>> and wait for them to terminate before continue on to call
>> nfs_put_client.
>> In nfs_put_client, if the refcounf is drecemented to 0 then we call
>> nfs_free_client which calls rpc_shutdown_client(clp->cl_rpcclient) to
>> kill all pending RPC tasks that use nfs_client->cl_rpcclient to send
>> the
>> request.
>>
>> Normally this works fine. However, due to some race conditions, if
>> there are
>> delegation return RPC tasks have not been executed yet when
>> nfs_free_server
>> is called then this can cause system to crash with general protection
>> fault.
>>
>> The conditions that can cause the crash are: (1) there are pending
>> delegation
>> return tasks called from nfs4_state_manager to return idle
>> delegations and
>> (2) the nfs_client's au_flavor is either RPC_AUTH_GSS_KRB5I or
>> RPC_AUTH_GSS_KRB5P
>> and (3) the call to nfs_igrab_and_active, from
>> _nfs4_proc_delegreturn, fails
>> for any reasons and (4) there is a pending RPC task renewing the
>> lease.
>>
>> Since the delegation return tasks were called with 'issync = 0' the
>> refcount on
>> nfs_server were dropped (in nfs_client_return_marked_delegations
>> after RPC task
>> was submited to the RPC layer) and the nfs_igrab_and_active call
>> fails, these
>> RPC tasks do not hold any refcount on the nfs_server.
>>
>> When nfs_free_server is called, rpc_shutdown_client(server->client)
>> fails to
>> kill these delegation return tasks since these tasks using
>> nfs_client->cl_rpcclient
>> to send the requests. When nfs_put_client is called, nfs_free_client
>> is not
>> called because there is a pending lease renew RPC task which uses
>> nfs_client->cl_rpcclient
>> to send the request and also adds a refcount on the nfs_client. This
>> allows
>> the delegation return tasks to stay alive and continue on after the
>> nfs_server
>> was freed.
>>
>> I've seen the NFS client with 5.4 kernel crashes with this stack
>> trace:
>>
>> !# 0 [ffffb93b8fbdbd78] nfs4_setup_sequence [nfsv4] at
>> ffffffffc0f27e40 fs/nfs/nfs4proc.c:1041:0
>>    # 1 [ffffb93b8fbdbdb8] nfs4_delegreturn_prepare [nfsv4] at
>> ffffffffc0f28ad1 fs/nfs/nfs4proc.c:6355:0
>>    # 2 [ffffb93b8fbdbdd8] rpc_prepare_task [sunrpc] at
>> ffffffffc05e33af net/sunrpc/sched.c:821:0
>>    # 3 [ffffb93b8fbdbde8] __rpc_execute [sunrpc] at ffffffffc05eb527
>> net/sunrpc/sched.c:925:0
>>    # 4 [ffffb93b8fbdbe48] rpc_async_schedule [sunrpc] at
>> ffffffffc05eb8e0 net/sunrpc/sched.c:1013:0
>>    # 5 [ffffb93b8fbdbe68] process_one_work at ffffffff92ad4289
>> kernel/workqueue.c:2281:0
>>    # 6 [ffffb93b8fbdbeb0] worker_thread at ffffffff92ad50cf
>> kernel/workqueue.c:2427:0
>>    # 7 [ffffb93b8fbdbf10] kthread at ffffffff92adac05
>> kernel/kthread.c:296:0
>>    # 8 [ffffb93b8fbdbf58] ret_from_fork at ffffffff93600364
>> arch/x86/entry/entry_64.S:355:0
>>           
>> Where the params of nfs4_setup_sequence:
>>        client = (struct nfs_client *)0x4d54158ebc6cfc01
>>        args = (struct nfs4_sequence_args *)0xffff998487f85800
>>        res = (struct nfs4_sequence_res *)0xffff998487f85830
>>        task = (struct rpc_task *)0xffff997d41da7d00
>>
>> The 'client' pointer is invalid since it was extracted from d_data-
>>> res.server->nfs_client
>> and the nfs_server was freed.
>>
>> I've reviewed the latest kernel 6.6-rc7, even though there are many
>> changes
>> since 5.4 I could not see any any changes to prevent this scenario to
>> happen
>> so I believe this problem still exists in 6.6-rc7.
>>
>> I'd like to get your opinion on this potential issue with the latest
>> kernel
>> and if the problem still exists then what's the best way to fix it.
>>
> nfs_inode_evict_delegation() should be calling
> nfs_do_return_delegation() with the issync flag set, whereas
> nfs_server_return_marked_delegations() should be holding a reference to
> the inode before it calls nfs_end_delegation_return().
>
> So where is this combination no inode reference + issync=0 originating
> from?

The inode reference was dropped in nfs_server_return_marked_delegations
after returning from nfs_end_delegation_return.

I don't quite understand why do we continue on with the delegation return
in _nfs4_proc_delegreturn after nfs_igrab_and_active fails and issync = 0?

-Dai

>
