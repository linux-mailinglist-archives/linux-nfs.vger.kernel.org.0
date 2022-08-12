Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA3AF591610
	for <lists+linux-nfs@lfdr.de>; Fri, 12 Aug 2022 21:43:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235221AbiHLTnl (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 12 Aug 2022 15:43:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230519AbiHLTnj (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 12 Aug 2022 15:43:39 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CFDAB284C
        for <linux-nfs@vger.kernel.org>; Fri, 12 Aug 2022 12:43:38 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27CJUfw6016715;
        Fri, 12 Aug 2022 19:43:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=SG7TTokmgri5NUA5zKQX3ef5RjUAkvt5/uGRtxQxXZk=;
 b=A9dmLpzmhyFofKRrY0Y8i94Vb6GNtcjtB9sMmWxfC6/yFccDRzjRnEiLTjwXR7ZZWrrH
 +hZYFFq+ftxYtvqskFIMOGBbhJkfVjY2yeN2Vuf2P4QlDGK9zlGXAsZxnqh+9GqJiP/x
 KPUjFjjYz85vMmrEQNKdH2L3gcJypVbXZ71u+2ZjpnGvb7Kn6YjnMoHrKLg6Q14tkBjL
 8eZf5SsNmXTvGF6QVrAL5K/MslxoVoPDV3nuyfzPb59POLZHYt8SB4jQN+bOEeAqDm0g
 wgP+zZDXX4r0rVFf3f3TlxJmX8iAmB/hiqBWtiyxtiPry3u7z+CeSMVs5FeNXkLSPVbw pg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3huwq98gf8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Aug 2022 19:43:28 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27CJ37mf018997;
        Fri, 12 Aug 2022 19:43:27 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2047.outbound.protection.outlook.com [104.47.56.47])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3huwqmcaqt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Aug 2022 19:43:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=STI+TDgUNn3NNpHYJQYIT/48fuFYVf+UJkNkkF01KcTBVhvIdv1SLB7qKFSmz9uPvu5mUyitoPWCqqhZ2/3HqkegoUGuOFxeJ0uT7C1C2onMmlWzqwffrPXTfNAQXx7UkIUb/KHCobbATc9sCPCcbnahPJseD2NPi9MUXnzb86IVi9Ll15ACz71L1CVOV2LnPtn1vHPS9cekzi4RfM1neNiiyFEZieUI4WiVv89Exiu5imP1lZx7FO6qTdWblwW/t5Zbz3OGuqftB/3TiO4FwYVT4fVmzCuN4NFJmMh0hQtvOF3Px9dvRvGkPYDirpBYcpQUco/HIUVGMVTwbjJDKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SG7TTokmgri5NUA5zKQX3ef5RjUAkvt5/uGRtxQxXZk=;
 b=XHb/GXsVWT6+h5IQjTkhyDg1HD9X5t6gBbJwx5L0Y62SOv+p73ys/uUfCbT8mSzCGuFS2j+72o3dUBsRb5sQkJnkOVX4/qK/85L+Xzg1LnydYL60B20mwV+pZSkwDXxWuSO2M2p0u/8B1THicKRJFpHX8yA6pt6TDPE7D7Bbx73HX/kEMfkTKJT65hhq4B8Psr+r/PlnzrCNjFmKDpwNMJaGkrmJ7WVjp512MvBjL51Rf5MdbcoUggo18wEh7wYz57FvRCDyv7xMdEs5TIFBT/2F0oQtbWqUI73NT+0UxG6Sjtpk1b+WXNObYP7eOxygQQVxltzzLKDoC1mek4DtfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SG7TTokmgri5NUA5zKQX3ef5RjUAkvt5/uGRtxQxXZk=;
 b=e1T3AkWrKY5XWUIPoazK/IdUGQbPF2dL3U6EvhrlFHvCWaf9DOY3f8Dvv9D0Hgx0oiT4fHj5YyLj7FbvRmlZ8btnbtAhW3rdg+8IqVKLr92EfXHeTi2G7FI0Al7MXuyGKd0IqT5KnGUt2I9cwQrf7r9rNz+SY0wmvjPeZJylIEs=
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by BN6PR10MB1521.namprd10.prod.outlook.com (2603:10b6:404:3f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.10; Fri, 12 Aug
 2022 19:43:25 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::d90f:4bba:3e6c:ebfd]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::d90f:4bba:3e6c:ebfd%4]) with mapi id 15.20.5525.010; Fri, 12 Aug 2022
 19:43:24 +0000
Message-ID: <e86bf23c-2260-5b2b-f6fc-7be22ec6d9d5@oracle.com>
Date:   Fri, 12 Aug 2022 12:43:21 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.12.0
Subject: Re: help with nfsd kernel oops
Content-Language: en-US
To:     Olga Kornievskaia <aglo@umich.edu>
Cc:     Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>,
        linux-nfs <linux-nfs@vger.kernel.org>
References: <CAN-5tyFLDrUMaTTi8ECTrKkAxxSdXGPEweGj8sQk5yW-vkmJ5g@mail.gmail.com>
 <ac641c57-2153-b2a3-a48b-0433dc6102da@oracle.com>
 <CAN-5tyFv+fPQ4T1HzWUAs7OcGvz_FyrAsAWwK8X=yu6yxP+Tcw@mail.gmail.com>
From:   dai.ngo@oracle.com
In-Reply-To: <CAN-5tyFv+fPQ4T1HzWUAs7OcGvz_FyrAsAWwK8X=yu6yxP+Tcw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS7PR05CA0087.namprd05.prod.outlook.com (2603:10b6:8:56::9)
 To BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3bf73267-d356-45d3-d846-08da7c9aeba5
X-MS-TrafficTypeDiagnostic: BN6PR10MB1521:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f+SQyfFCaui7TFN7uOrheZgKoauZ4A4TSA8D798/D9zQ5ACO7JYnga3lUDAEJNP+JeVRJAJM/q2Zx2Ac8aLNbCeWoHJv6JdFCy2CdNcyCOVRE5/jPUYq/MpRdHSvzQzrzxa33wWI5f+gVYtiAm0kL59sA76wp20WHA5xno2OCR6Yp8Azf9c9CD8nGwlIkNthA3B2eh7NBcOqB+dmIWc2KMHFJj5J1Y+9jR1wH5uKuS83ccPk9FMfhYj9x8qfTsH2ABoEzOcQR7knoQOMkwT3RHcNZJ47Oj4tLKZOQYRB7Q5h/ZzSeIzOUG1H0znLo07vfmPy794hQ0ggOdJ7HQOzN85MvJtKSSq6c9MF/inpr/5nqezOxzJJZ6J8Q681FCTLr/H5uvD9cAA5Q7LBbtp/YQuingZE/9i1Beff5zzTJvtsRAuHnWceglOuU1jG88zkwZz7IeraLcbzu0FxPTwPMFlEQCfQ1f8KNwlYeZldgdzFppEdZwUOiYckCYa4A6PbWoUPRfgVf8oVaXjGW7ttX7HJNk/aETLI14+76HaveYeXiUYsVPkyuULWaSYdFbCeXzRvqsIiIbwpNRiioLu9702IXWMhpNf6w0sdAB365jL5j9Y/cmxC9GLuMnXJ4RNRGo/KlHsXAa+FRztACzvooNMTyXXrVk6IkvE3V2hLgiSVzz6YG4pkYJd/Xy5ZSYvpdVvcv+Vl04TQxe/bzA3SmA8aRTsrdNVRpHEz0i6tYobbi9CPNyulXlCZZ1r8EHC8eKG5B1LJnyvcRbHR0iAf6m9WRXRnb3olIGHJ/mCvk94=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(39860400002)(346002)(136003)(366004)(376002)(316002)(41300700001)(66946007)(66476007)(66556008)(2906002)(53546011)(6666004)(8676002)(4326008)(26005)(38100700002)(6512007)(9686003)(5660300002)(186003)(31686004)(83380400001)(31696002)(478600001)(54906003)(6916009)(8936002)(86362001)(36756003)(6506007)(6486002)(2616005)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YjB1YjVSMU9McThwQ0hoQ1VVWitMdm9NQStjZVE4dXpVb0p5dnAvODhlQ2xL?=
 =?utf-8?B?Z01xRmxXck16Qk55TXQxL3Y5OUdDKzMrVHFyVzZha0g3RDJWYkNhdjZ5aUFp?=
 =?utf-8?B?czhWa2pjYnBMbG1TbUp5ZkdzUHdrMnE5dkNqNG1LYzhabC92VXFucnhCYy91?=
 =?utf-8?B?cjExckJnVTVRLzVhOGJBYUw4ZUR5QUFhclJKZjhNeUllczBHUUI5UlFtYkx0?=
 =?utf-8?B?T2VtNVBhVFFLeFRUSlZXemRXZWJNNmxMWEZJb3BTS0xGV1pRdVFWTFY2TnFL?=
 =?utf-8?B?cVY5WExON1ZEOFR5M0xpZlFQaURYRVh0dzZHM3E3YVk3bkRjQUJ1em9vQnFz?=
 =?utf-8?B?cUNDeGJWZzJzREdNZHVSZDNEK0xmUjhPVmZsTFdlNWt6MVY1WkRva0svSWs1?=
 =?utf-8?B?d2lqR2lFVkxBYjhDc3Vmek1XZWZYdm5JTlZqV1ArOGpQVTZ3eHFYbkdOMFNB?=
 =?utf-8?B?d3lwQkd1L0wvNG1oLzFTVXpySXFEZ0QyRGprTE9TS0tsS1ppT0g4N1ozeFVH?=
 =?utf-8?B?MmdCbkNrb0VjRlRBSC9NZjd3cDNoTEJKYUV2c3ltY0g5RnRNNjNIeENYTFc4?=
 =?utf-8?B?bXJEOGp5TlFyQ0d6Y1BScG04UDkvN3NhUVpaOHVNeE1mMTdCTS9GRzgwc3k2?=
 =?utf-8?B?aWI2VzYxeTJ0TVRROGZ5RDJpSHdObU54aldPZ0NIb0pvTk9KSk9IOTJlR1hV?=
 =?utf-8?B?Tisrbkx0Ymk3NUoySHVSK3ZLZTBBWE1yUTJ0eTNSSklUS1RpdkJ1N09IZTYv?=
 =?utf-8?B?WndXbkJXWENiYzdrS0laWmNJOUlaUVVPRFdjUy9ENitlNTJtVXNtZVA3NG8r?=
 =?utf-8?B?Q3ZWNXpyUG1Ld2pzcmJ5NWgyNTVZS0J6RzR6Q0prNk0yR1RsRDZoN0Z3WU1V?=
 =?utf-8?B?dEJxYUVqaktHN1drVWNyc04xQ21ac1ZvRzV1ZURNWVh0L1VkQWljcm9yU1FY?=
 =?utf-8?B?VTR0dmxrTG9KbVNEUEtCNHNxOFQwU09mSGNlSHFVMURsUmcvc2tpdGtvcGxC?=
 =?utf-8?B?emZpanpOSGVzZ01XcXNDNVVoN2Y4aUpXTjc2WVFLVlNJRkI3VmJDNFJISnJT?=
 =?utf-8?B?VW44RUVsYzk2Rkx2Wm45UlpuZ0dDVXhrVGtqY1l5YnBQZ1JTTmd2YmtrZGNV?=
 =?utf-8?B?aWxkUExMN2RPMVZ1ZG9VMnkybDk2cy9qVlVSSHdKMVVUdlQ1RFFhY1o3R2hh?=
 =?utf-8?B?R0I3M2tRb2dDdVRXQlR3YllFVTd0V0FUQ3pKdVdiTUpicG1NUFlOaG1QWUM1?=
 =?utf-8?B?cndISEdkdkgzK2pMSEhTMlo2ZlRVSnYzQ3hFSUkrWTFKOTJ0QVUrNkVIRFVo?=
 =?utf-8?B?SVRBWlZPa3E3UFZoSENYVVZYdzhvVWJKL3A4eGlvdVhaSW1vTkM3Z1lseTVG?=
 =?utf-8?B?bGc2OTVUa2VFdW1NWVpQZkduRE9OdjZVM2lPbFFhUEd2QTJ4MU5mRXRLUHFj?=
 =?utf-8?B?aUV0SXBxUmtrczR0ZnFuVGVaTnRzcG9IQzFTSWJWQzlQSXYzYXNjWlMwSHdh?=
 =?utf-8?B?eUhWdXJxYU9BNmpQSDh4aHBXSnNOWHRaMGRJM3pxUmFJdFUvK29YS1BPdWtV?=
 =?utf-8?B?OFo0ak1PUHFWSHhnMjBhdUxuZTNxV3IwbFpTVFVPeVBlVmJJMjQvMTBTMFlU?=
 =?utf-8?B?R1B2MUg4VE1mTmtRd3ZjdDcvVVVYeEpvZHoyS3JzVUdpQi8xSXZJR24vRFVD?=
 =?utf-8?B?WC9palVOOE9OSWtuaENZVmdONVhEUDdMN25WcXI4a3gyL2t4ZEtFWUJWMjhL?=
 =?utf-8?B?WmRkU00wVkFUa01peXBLT0xvMXRISnNYZU41a1U1VEZlektGZXlsMEo4N3Zt?=
 =?utf-8?B?Z3p3VG1yTWd5UWFrODNxb213SFFndWNHRm1mbUpqVlJMdkl2QTFmd0dEYmVw?=
 =?utf-8?B?Y21rSU4xajdjTVpFZlhsbTFiSkJOVDROYUY0YzdkQXBXNUlMMWI5cGt3VDh6?=
 =?utf-8?B?UDBOZHJ3Rms4TkkvTEs2eG1nWVVtbHZmajhKaytSbDRjNStWWmFkdHplSmJp?=
 =?utf-8?B?VnUzdmRZcXBvQlAwV3I2UWY1TVR2UExVeXJrbGIzV3EzSXpXOVdSajVBZkdT?=
 =?utf-8?B?Z3llRnQ4TTd3WUpxaXVyM1RNZmdzcUtScmY5bkt1T2p1NzcvZE81bHhIZkpP?=
 =?utf-8?Q?AZlyWv0Fe2MXeq/gkezQOoQ+T?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: yiz+W02emCLXghqNgk9z3FvlxQ0OgkGKZ9jCIRYsxbfAH6g9bvNc/2Lu6RBYsRgBQ17spWX4eB++YSSSwrr2KblFgLyAeX7yBRWvEIdGt2uwwVCFszmmHFrGPLC0SooFjG6eRPV/c6wLSEav63DkK43Lbyq6nJ8bOf1RKZlvDXIV6mJ5UqMv5tyq/+2Cnv8C3t8Yjv2Di3FPq30vXHK2l0ruFMs2VKXQJSxUGFtw0Dl9cy3rxeH47gX5JELKfbBreV+DrV5WcTM7lsXdggL0hH+GWw23IfR45YggCaO57EXkGuLwWPjxn0sPKiwneAHRlhCnkAA7TJJfwI4tCxyXmKs9GO9tWyPOVL1VSnpHQLndJDXG68RGEyTixh4rdUlrtN7EFiAZ64FtTDVShhzYPY+DqM2MlaewUttbEqCf/c/saFlF1tRrlL8+xTMQ2bK13ZlsHevyof6i5h8NL7kHzBk/iMyPo33a0Z013U4TRT3wh1bkT8SbnNN4lQiLHjSHj+dLwhS/uNJLAkqoxH2vCnZtmyoh8dG2WMjhKKBhngMKCgxrgnsHFLv5RZY3lrLsANryyxEZvZQ4NconKAOhCleeZ+NzltT0H16kogA0reknUK0XM8GI/p/DNui5Yn2mgJ/9GxdZn+WAo701LRSlx/3/fsSZZ55D9b7RoWG5WOC8Auy/veyS53VtDw4wmsYu5M1BU01FGo6z863TLlfZjvL6lkEXKykkay/OU3ttejmTvIM1DVBrTzzq3cQb4cCA+si8U/NDx5L/oOrarQwSpzgI3r0kLIwdaSKg3JLAShh9x0pHq6ejMUhVKaVmtCax
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bf73267-d356-45d3-d846-08da7c9aeba5
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2022 19:43:24.8087
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XsLDyBYVQS8whJ9pnx2sKQXTBhQT+Fqr8i+3NO0QRTjDmR5sMKCt+gmP00YjFSJ9GKu8A3oiJDa3XXxWtikrTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR10MB1521
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-12_10,2022-08-11_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 spamscore=0 phishscore=0 adultscore=0 mlxscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208120052
X-Proofpoint-GUID: _I6r2bzsTF9pyXEidAWiIH7_H-z5EJTm
X-Proofpoint-ORIG-GUID: _I6r2bzsTF9pyXEidAWiIH7_H-z5EJTm
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


On 8/12/22 7:23 AM, Olga Kornievskaia wrote:
> On Thu, Aug 11, 2022 at 9:34 PM <dai.ngo@oracle.com> wrote:
>> On 8/10/22 5:50 PM, Olga Kornievskaia wrote:
>>> Hi folks (Chuck/Jeff specifically),
>>>
>>> We've had this outstanding kernel oops that happens (infrequently) in
>>> copy_offload testing (stack trace in the end). I've been trying to
>>> debug it for a while, added printks and such. I can hand-wavey explain
>>> what I'm seeing but I need help (a) nailing down exactly the problem
>>> and (b) get a helpful hint how to address it?
>>>
>>> Ok so what happens. Test case: source file is opened, locked,
>>> (blah-blah destination file), copy_notify to the source server, copy
>>> is done (src dest), source file unlocked (etc dest file), files
>>> closed. Copy/Copy_notify, uses a locking stateid.
>>>
>>> When unlocking happens it triggers LOCKU and FREE_STATEID. Copy_notify
>>> stateid is associated with the locking stateid on the server. When the
>>> last reference on the locking stateid goes nfs4_put_stateid() also
>>> calls nfs4_free_cpntf_statelist() which deals with cleaning up the
>>> copy_notify stateid.
>>>
>>> In the laundry thread, there is a failsafe that if for some reason the
>>> copy_notify state was not cleaned up/expired, then it would be deleted
>>> there.
>>>
>>> However in the failing case, where everything should be cleaned up as
>>> it's supposed to be, instead I see calling to put_ol_stateid_locked()
>>> (before FREE_STATEID is processed) which cleans up the parent but
>>> doesn't touch the copy_notify stateids so instead the laundry thread
>>> runs and walks the copy_notify list (since it's not empty) and tries
>>> to free the entries but that leads to this oops (since part of the
>>> memory was freed by put_ol_stateid_locked() and parent stateid)?.
>>>
>>> Perhaps the fix is to add the  nfs4_free_cpntf_statelist() to
>>> put_ol_stateid_locked() which I tried and it seems to work. But I'm
>>> not confident about it.
>>>
>>> Thoughts?
>>>
>>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
>>> index fa67ecd5fe63..b988d3c4e5fd 100644
>>> --- a/fs/nfsd/nfs4state.c
>>> +++ b/fs/nfsd/nfs4state.c
>>> @@ -1408,6 +1408,7 @@ static void put_ol_stateid_locked(struct
>>> nfs4_ol_stateid *stp,
>>>           }
>>>
>>>           idr_remove(&clp->cl_stateids, s->sc_stateid.si_opaque.so_id);
>>> +       nfs4_free_cpntf_statelist(clp->net, s);
>>>           list_add(&stp->st_locks, reaplist);
>>>    }
>>>
>>>
>> In the use-after-free scenario, the copy_state is inserted on the
>> sc_cp_list of the lock state.
>>
>> So when put_ol_stateid_locked is called from nfsd4_close_open_stateid,
>> with your proposed patch, nfs4_free_cpntf_statelist does not remove
>> any copy_state since 's' is the open state.
> i dont know about all the cases but i'm 100% certain that "s" is there
> a locking state (in linux client using nfstest_ssc). Since i've tested
> it and it works and i have heavy debugging added to knfsd tracking all
> the pointers of copy_notify stateids and its parents.

The fix for this problem requires the copy state to be freed when
nfsd4_close_open_stateid is called. With your patch, the copy state
is freed from:

	nfsd4_close_open_stateid
		unhash_open_stateid
			release_open_stateid_locks
				put_ol_stateid_locked
					nfs4_free_cpntf_statelist
					
with your patch, nfs4_free_cpntf_statelist is also called for v4.0
client which is unnecessary.

in addition, there are 5 places that call put_ol_stateid_locked:

release_open_stateid_locks
release_open_stateid
release_openowner
nfsd4_close_open_stateid
nfsd4_release_lockowner

only the call to put_ol_stateid_locked from release_open_stateid_locks
is needed. The over 4 are unnecessary overhead.

My patch frees the copy state only from nfsd4_close_open_stateid and
only for v4.x client.

-Dai

  		

>
>> Also put_ol_stateid_locked can return without calling idr_remove
>> and nfs4_free_cpntf_statelist (your proposed fix).
>>
>> -Dai
>>
>>>
>>> [  338.681529] ------------[ cut here ]------------
>>> [  338.683090] kernel BUG at lib/list_debug.c:53!
>>> [  338.684372] invalid opcode: 0000 [#1] PREEMPT SMP KASAN PTI
>>> [  338.685977] CPU: 1 PID: 493 Comm: kworker/u256:27 Tainted: G    B
>>>             5.19.0-rc6+ #104
>>> [  338.688266] Hardware name: VMware, Inc. VMware Virtual
>>> Platform/440BX Desktop Reference Platform, BIOS 6.00 11/12/2020
>>> [  338.691019] Workqueue: nfsd4 laundromat_main [nfsd]
>>> [  338.692224] RIP: 0010:__list_del_entry_valid.cold.3+0x3d/0x53
>>> [  338.693626] Code: 0b 4c 89 e1 4c 89 ee 48 c7 c7 e0 1a e3 8f e8 5b
>>> 60 fe ff 0f 0b 48 89 e9 4c 89 ea 48 89 de 48 c7 c7 60 1a e3 8f e8 44
>>> 60 fe ff <0f> 0b 48 89 ea 48 89 de 48 c7 c7 00 1a e3 8f e8 30 60 fe ff
>>> 0f 0b
>>> [  338.697651] RSP: 0018:ffff88800d03fc68 EFLAGS: 00010286
>>> [  338.698762] RAX: 000000000000006d RBX: ffff888028a14798 RCX: 0000000000000000
>>> [  338.700442] RDX: 0000000000000000 RSI: dffffc0000000000 RDI: ffffffff917e9240
>>> [  338.702257] RBP: ffff88801bb0ae90 R08: ffffed100a795f0e R09: ffffed100a795f0e
>>> [  338.704016] R10: ffff888053caf86b R11: ffffed100a795f0d R12: ffff88801bb0ae90
>>> [  338.705703] R13: d9c0013300000a39 R14: 000000000000005a R15: ffff88801b9f5800
>>> [  338.707510] FS:  0000000000000000(0000) GS:ffff888053c80000(0000)
>>> knlGS:0000000000000000
>>> [  338.709319] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>> [  338.710715] CR2: 00005640baab74d0 CR3: 0000000017574005 CR4: 00000000001706e0
>>> [  338.712282] Call Trace:
>>> [  338.712898]  <TASK>
>>> [  338.713430]  _free_cpntf_state_locked+0x6b/0x120 [nfsd]
>>> [  338.714806]  nfs4_laundromat+0x8ef/0xf30 [nfsd]
>>> [  338.716013]  ? dequeue_entity+0x18b/0x6c0
>>> [  338.716970]  ? release_lock_stateid+0x60/0x60 [nfsd]
>>> [  338.718169]  ? _raw_spin_unlock+0x15/0x30
>>> [  338.719064]  ? __switch_to+0x2fa/0x690
>>> [  338.719879]  ? __schedule+0x67d/0xf20
>>> [  338.720678]  laundromat_main+0x15/0x40 [nfsd]
>>> [  338.721760]  process_one_work+0x3b4/0x6b0
>>> [  338.722629]  worker_thread+0x5a/0x640
>>> [  338.723425]  ? process_one_work+0x6b0/0x6b0
>>> [  338.724324]  kthread+0x162/0x190
>>> [  338.725030]  ? kthread_complete_and_exit+0x20/0x20
>>> [  338.726074]  ret_from_fork+0x22/0x30
>>> [  338.726856]  </TASK>
