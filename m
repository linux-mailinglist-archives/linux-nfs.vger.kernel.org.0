Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7936B6611EC
	for <lists+linux-nfs@lfdr.de>; Sat,  7 Jan 2023 23:04:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232124AbjAGWEv (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 7 Jan 2023 17:04:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230170AbjAGWEt (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 7 Jan 2023 17:04:49 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96E6F3D1DD
        for <linux-nfs@vger.kernel.org>; Sat,  7 Jan 2023 14:04:46 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 307K6vqe009389;
        Sat, 7 Jan 2023 22:04:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : references : from : to : cc : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=H7pCpbTPkdXTEEfeRCDPfGVEXeH+ayKQuyPt2hbHwys=;
 b=t8t6PrvC0lz8IWIfJERh4++WjiLmEqDx6V0uFr+glBwKJzmPllkLl+LxOscx68Bvkxj2
 YYM3buJrGACtjFEmWSWALkw9bcQ9gyu6EfKJrl//pREEruqKYXqdy/9aBUHYyzlQww2L
 1nvBxXCijGReK6IdlA+CTUm6GVG5gXRp9Q5+QuwaO2uP8X6i3pLTCcuTbKO9flCnhENr
 0dIwE47mlx6q2W0/97uDetllIflAogcAwZctKs20ezkH7z82523TJUgu8387Hrajy/ip
 VIhOMBJSfRNnFDmi7uX7g3Ov+oTKFiZAV19KWcIwFq8dNrrIARlxn5+uqKH89DcyBcma nA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3mydxm833p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 07 Jan 2023 22:04:40 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 307H0Xnk013346;
        Sat, 7 Jan 2023 22:04:39 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2106.outbound.protection.outlook.com [104.47.55.106])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3mxy62m8k1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 07 Jan 2023 22:04:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eCz4B7iZ8L0Yos9rkge3uGChVsEUilNPZtzEgB3lBQ1tQzS/H5K1suGRAdXST3mpqI2XhysonPftvibxGYo4RiqPKiGdUowHV1JCrX35l1gL1bod5qwvkStoiGAMXhaoXZw8gokObYvw3ac8Mo0AiYWwPOOICA7pNbMJacoUdcCeDNEBmbU9HD+Ayr1P85YHuBtM4mSCU6YUQoJHZvPxzD6Ec1+9L+2DRQm4AFfC1d89BBN7VG354m2Mf6mcSjY0VEozCTPSl4NzC3g4DUbXRkNdNlA7xGR/uYxsveapMbuAO52qgZVWzr4qgMmvZMvxdQkH7dSab3UVd7C78LBHRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H7pCpbTPkdXTEEfeRCDPfGVEXeH+ayKQuyPt2hbHwys=;
 b=FcbsldUwipgvbt0MqqZsdIG92IMPwI7buoeYPDBO/c9qe0Nx3MbVCt8dB9xOKKHgUOpUisZO1/373gnUknZ2iDmbHWXgjkpXiryIva2JOwXMBXtCtAAnx0lTk4QaBSuQGAwDJiYbzbUq/cLHjsbiO0ko8sX/8XJhaHFz4xhWypCRlmv0GjZ/7wjSkfEcyVVi96qGASuM2UaZc74RpzerzUUUyPUzFpqWuSeYQstUd1CvLIX3yjv8lFCfVBY/rFJZbwLTJJuBLd+H0eluv6X40nYzt6MxJxn3tqOGAtxy0JRqy6qemzxOVDw1ZLVLAt+q+kAzw/XQ7P6E70ZrJax2tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H7pCpbTPkdXTEEfeRCDPfGVEXeH+ayKQuyPt2hbHwys=;
 b=A0ysLHWO8W1d2qRaTw2aJEo/K96PLK//tad4be7Ud0ZH7uQHfyULoRTrI7iMmGnTB1zKH27JqvTbQwRAqfAqU2QQMmTMrgOFIWBFApiWKuliLFEiMnJ7BdG9V7VMnxV+gANupB18/yi5hMIuTZNhAhI2TbbkpXsrUaGH0NX9m6k=
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by CH0PR10MB5084.namprd10.prod.outlook.com (2603:10b6:610:dc::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Sat, 7 Jan
 2023 22:04:37 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::940c:19a:12c5:e152]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::940c:19a:12c5:e152%6]) with mapi id 15.20.6002.010; Sat, 7 Jan 2023
 22:04:37 +0000
Message-ID: <830543ab-10e0-3a62-c683-8bd95292db4b@oracle.com>
Date:   Sat, 7 Jan 2023 14:04:35 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: NFSD: refcount_t: underflow; use-after-free from nfsd_file_free
Content-Language: en-US
References: <3c525b04-ef64-2bee-efc9-9a43069306f7@oracle.com>
From:   dai.ngo@oracle.com
To:     Chuck Lever III <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@redhat.com>
Cc:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
In-Reply-To: <3c525b04-ef64-2bee-efc9-9a43069306f7@oracle.com>
X-Forwarded-Message-Id: <3c525b04-ef64-2bee-efc9-9a43069306f7@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0281.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::16) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4257:EE_|CH0PR10MB5084:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e2cf83e-449c-4cc2-fd90-08daf0fb2a91
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cmPolDisPyFZT2vRp/+yRBY59uaOdYxyk4Ku76iY0RdmS1SsIqtC33iOxwFBxvxnc39LSb76EazavEDEWmQIlf7obkMaI2vJOU7GkIGID72184qwt0XF3Bik+wII5/VWKadcqBi7xadTld400MTETnHJUnpJDQoN7cHHK3qajY/O9FRH5TpmuTaTStBvSGAVuu1EOPAWwLP6+hElxsme7eDqUwwVOVjEVOoRgan4zIiIJRrHDwguUBIZW4vZ/xbcoKHg2FGY4+VX5Y4YiLAODZeE1ugTaPZPZl24VMmsEk6FCNiFJMWFlRnGy7RAls+50xJsHr1o6OvarLW3q6E92Cla1dK9sv5OgwDcpusbgHo1epdmL0ACAwVVFTyrS76u7x/8c7s2Ykv6RmptRlI9oUrAJrJCvBf7K7mYKEBJjCFHg59QNYBd5Va1KQ4FFGkYAQrBOjzPz7y5QVz2ke81PeHQedeATPbUdbgxE09HVY7r9jWf0kBV1+xCGLSoigGWmlvVdejN5DjjrsO32Uz2fyTPriqnkHGqs8W+54+B/M6V1lG84HFuRNaJ72v1jPxHxalZ3P2Px5eRY6qrP28Ug+V6upiB6dfV0dph94P1nFNqSFjI9ojIn8nmB3AZRKtqXILwz3/kr34U9gAOLzkC8Y+XFZbkHsRNwNA52ikgbdJdYI7fMZ36JHJnhvQkYCYc
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(39860400002)(396003)(136003)(346002)(366004)(451199015)(5660300002)(2906002)(8936002)(41300700001)(478600001)(4326008)(316002)(8676002)(66556008)(66476007)(110136005)(66946007)(45080400002)(6486002)(31686004)(26005)(6506007)(9686003)(83380400001)(6512007)(38100700002)(2616005)(186003)(31696002)(86362001)(36756003)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dEI3SkV1eXl0Yk4zVkdFYnZsd0p2Skc0VDZWQWhCNjV2NFFNdFNWaDZ2b3FD?=
 =?utf-8?B?MEVKa1dHNVpIQTdMdjNHOGs4d3JPeUhMOGNSNUtIbW05MWNQUFdncjViUWQx?=
 =?utf-8?B?M2gzYjBCbkNXRm5VSTl5cEMxSUxOM3NBRCtWSXQyYUZPV2U5QkVJeUNKTVM5?=
 =?utf-8?B?NmxXQ0dGZ2hOcGZrYnNDdTFvc2M0cHJnY1A5OHg5VEEvdXRxaEhEbnVYVzUr?=
 =?utf-8?B?YVNiaUQ2RVF6bFpLNjNtMmJpZ2xsK2U3S0RvYktTZTdRVEkrOXE4V0NudDAx?=
 =?utf-8?B?NTNFME1OT1hVTDRhTTJMQXlMSldQL0tLWkVwZERlYzlkUVFyNjhvMFh6b0h3?=
 =?utf-8?B?QzFEQnAzS3RDeFNOUjh4ZFdYU1V4YlVnYnpwR2s4TDQ4ckRRb1QySGkwcjcy?=
 =?utf-8?B?bENYUUtsQVM1blkzMWR3dkFjUnhoUEFUNVpQWWFzeDZ5R1UrbThzYVVOTC9R?=
 =?utf-8?B?aFJFcVBaZXpnVGhqa0RsQmg5dWxQSmZyaEcvdlNPemgyMzAvekg2VUI2dWxL?=
 =?utf-8?B?QmVNZ2xwdjJGbGlGU24rajMyaXk5R3RQNkZYQldUN2FYOUxMRlh4RUFGNnNw?=
 =?utf-8?B?aGZQTis4Q0xoTGhJdUNUMlRGQTl5SWNTY3kvTXU4Nno0OFlrdXZqNlpzaXhs?=
 =?utf-8?B?L0ZxZ1BwT0xnUmU2dnByUHZ3aVNxQndRSFVzdkMrcTdQSU40UWp5SFVZM3Zo?=
 =?utf-8?B?UEMwdWluOFVEeHhhekt6bHprSU5wOHU5ZjJGckxBemlsNk0zY0phUzdUVFJF?=
 =?utf-8?B?WmJscUZBNFppSlpocXZHNm9ONHZwaUw4WjQvQ2tsNzhkaFgyOHdqZ0pPN3Vi?=
 =?utf-8?B?WGNGbklrbEFxRG9jYWFMNjZveTZOYnljeE9DaSt5bjhYSWVOVlkyQ1lyUGE5?=
 =?utf-8?B?dE5XVmVTeUFHSkQzdnNHWnpVNFhmVnVIYmU0MWkrNkZSU1FWSGRrc3VNR2hT?=
 =?utf-8?B?MkZwTUszbkRvb3JnZ3N2QUpYdU55YVJGWFhFMnJzbzY4dnVpV2xwNGc5UVph?=
 =?utf-8?B?QXRpZXVUVkxUZ3Q4KzJGVE5CdGNOMDVQeUx5WUtlZ1c4Ykk1ZU9qemxUUFlq?=
 =?utf-8?B?YVJabmhzZFp6eW5Gb0hQa0RqRHpTMUNhbGt5dGtsTVk2SHFidzJWY0pYdFU1?=
 =?utf-8?B?WUxmYmRsNm54WktCNE4yNDhRRk9EOHJlV3dJTlVYMGdSUGhwWCtwVy9LQ2sv?=
 =?utf-8?B?dXd1cXhnTlZ1QWxxNWV6ekdpTmpOQ25sK1Y5TVVkQ3RvRDJvVVhXNnphRGth?=
 =?utf-8?B?N0UvTXNndmV5eUk5WmYrdWV5WHdGa3hyeFJDcXV3RkdUMnJ6ZEtEOVExbmcr?=
 =?utf-8?B?c1RHUGJmYUl4b01sSGEvaXM4T29zUjF6WnpZWG9CU1ZlaHMrU05NQU9jMG1F?=
 =?utf-8?B?N1N2dWE4VFJrWHByOEVZZ1FXRnFtQm92TUtDV2t6MnlaaUk5WXBkOUR3RlNp?=
 =?utf-8?B?QjlxOHh0SW9nMXpXUE1wVnI0YVpGUW1NVHBIVGV1YjU2NFZQNVljZEJKU1l4?=
 =?utf-8?B?L2wxVFlwMHh4NDh2S0V5K0RWK3JuaENSTlZ0QTZrbGVLSTJ2Qm9JM0xCSERI?=
 =?utf-8?B?TTRSdDNCSGxIS3lPQndJSFpyanRyUytmejhCOWZKVTZjbXdISERRVk5QZ0xy?=
 =?utf-8?B?WnpPMXVjOFFYZHZaL0hhR2I0ZDBmU2F1UkV3YkFWQmtuZEk5bE9EYlFWVm8x?=
 =?utf-8?B?ZXRENk0xUHBtU1ZKVkx2V0hscHFiaEZ1cDZqc2lPcjBvdTA1QlZBVlV4OWI3?=
 =?utf-8?B?ZDNKb3J2QUNSRkNDQ1MxMzhWNHM3TEtNcURYQTJhTHFCK0RvbjJ5eDlOY2Vn?=
 =?utf-8?B?eTFZRTBHM29JOTJjTFRHWlpJS0xTNC9iNElhdlZGZkoyY01mT3ZaY3JjRnUy?=
 =?utf-8?B?NCtWNC9kdUV2S2FWYnc3dzIwR2NRRTdIZklsVGgydkg1VTJPVnpBckZjWWk3?=
 =?utf-8?B?S1dzNEhPOENIZTRFVUJjemhXTit5VlkyRWw4SmdWYkFwaHZTcTcvRm5tSXB1?=
 =?utf-8?B?NmFPakg1VnJhWTQ2WjhDUHpwNXR5U244SXYyR1hFdm9Ya09ZeVFWQTdXM3hK?=
 =?utf-8?B?S0tRMUo4alpPOVhLSmJZYlliT21tSUd5U3BCSkVBTTFjbStDSHZIRk8wWStR?=
 =?utf-8?Q?f3JX07STs6jl1bTmu/GXAk3zD?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: wmOjWdYLRGDkP260y1mUa44zAzQouGmyer3Z9eg29jsM4c5JsIQoBX1a/U7Xz5Z/E3IMA9A5ClbutEcbUCdnIzQQtORVMXfGgt2TX1S98WI3r5uZFiviCnsCCnEVvDPPIvALuJ0ovwZtZvNGYqnYPNIzO8mqgh6iwkBuJc6VI8f0KdJHWoD/1XrjVFj1IhRYu1tf4YW1Bu8gexvJkvD2zZ0lGJ7FbDuxpl++tt51BOdxH/SxQk+eLCiuvToM454CUYmNHtdEw2U4RxX9ofyZpBq4qTt5xb2NhWI3m8Lnq7Lv3ZwWQq/wgqdUUCWEv4emmNApdWM4AwowvKuR8IfNk7r6gnregXtupnGOl9wpJTSWVmJ+znZoAu7a8NuNgtg2aqOFLyEt7rqSdqmmXgXRw/d1iFtZDnA8tbAC6clde2AMADgpwWkh47YdP6fN/QTjrXHlhgmxC4wPeER4QsBQ6lymvJYfNF+G+XQ2szSyJPDbBfka7y4oVKhIhFeShDxT/fiMHqUkVXs8yeOgZtZJYEtu8VnAp/G1MZxxW8AQ0SuSHaAkDczivlg8/MGbqX5EQDRHc7d8xPJW4ujkz2ImtZGdXV+MRZwPgVo20FksvJn1L0Eh9sAxzm8fAFRGVDWHBl/lge1P6h1NMcJnZzH2w9h8/rpw1304/K2PL03cxxO3/8tE1rggHiVrxoXrsrAMFzajgXA+oKKK4PBMT9mQ6u9bP4yqADEb+g7TxNj/FPZi8+qlFcXAOo+qiDgHkE3srJeE810a72hfZ9KVJaavNoJSkkSDnidqM9CTVxKwBYg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e2cf83e-449c-4cc2-fd90-08daf0fb2a91
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2023 22:04:36.9576
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r71sFOD/R77c4uocH1PAxw3+m1Ko/RkS0cHVPLytLU/Dpo2ZtOhj064rOl8V2g9F6SOGfX85CHZb4uJCckO/rg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5084
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-07_11,2023-01-06_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999
 suspectscore=0 adultscore=0 phishscore=0 mlxscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301070173
X-Proofpoint-ORIG-GUID: WSVZ1a4EYspghh7EjQgcxM02WIpyfuNY
X-Proofpoint-GUID: WSVZ1a4EYspghh7EjQgcxM02WIpyfuNY
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi,

This is a regression in 6.2.0-rc1.

The problem can be reproduced with a simple test:
. client mounts server's export using 4.1
. client cats a file on server's export
. on server stop nfs-server service

Bisect points to commit ac3a2585f018 (nfsd: rework refcounting in filecache)

-Dai

Jan  7 12:15:56 nfsvmf14 kernel: ------------[ cut here ]------------
Jan  7 12:15:56 nfsvmf14 kernel: refcount_t: underflow; use-after-free.
Jan  7 12:15:56 nfsvmf14 kernel: WARNING: CPU: 0 PID: 10420 at lib/refcount.c:28 refcount_warn_saturate+0xb3/0x100
Jan  7 12:15:56 nfsvmf14 kernel: Modules linked in: rpcsec_gss_krb5 btrfs blake2b_generic xor raid6_pq zstd_compress intel_powerclamp sg nfsd nfs_acl auth_rpcgss lockd grace sunrpc xfs dm_mirror dm_region_hash dm_log dm_mod
Jan  7 12:15:56 nfsvmf14 kernel: CPU: 0 PID: 10420 Comm: rpc.nfsd Kdump: loaded Tainted: G        W          6.2.0-rc1 #1
Jan  7 12:15:56 nfsvmf14 kernel: Hardware name: innotek GmbH VirtualBox/VirtualBox, BIOS VirtualBox 12/01/2006
Jan  7 12:15:56 nfsvmf14 kernel: RIP: 0010:refcount_warn_saturate+0xb3/0x100
Jan  7 12:15:56 nfsvmf14 kernel: Code: 01 01 e8 3f 21 65 00 0f 0b c3 cc cc cc cc 80 3d f5 d1 4a 01 00 75 5b 48 c7 c7 c3 4b 22 82 c6 05 e5 d1 4a 01 01 e8 1c 21 65 00 <0f> 0b c3 cc cc cc cc 80 3d d1 d1 4a 01 00 75 38 48 c7 c7 eb 4b 22
Jan  7 12:15:56 nfsvmf14 kernel: RSP: 0018:ffffc9000078fc98 EFLAGS: 00010282
Jan  7 12:15:56 nfsvmf14 kernel: RAX: 0000000000000000 RBX: ffff88810e8a9930 RCX: 0000000000000027
Jan  7 12:15:56 nfsvmf14 kernel: RDX: 00000000ffff7fff RSI: 0000000000000003 RDI: ffff888217c1c640
Jan  7 12:15:56 nfsvmf14 kernel: RBP: ffff88810cbd7870 R08: 0000000000000000 R09: ffffffff827d9f88
Jan  7 12:15:56 nfsvmf14 kernel: R10: 00000000756f6366 R11: 0000000063666572 R12: ffff888111c9c000
Jan  7 12:15:56 nfsvmf14 kernel: R13: ffff88810fb5fa00 R14: ffff88810f980058 R15: ffff88810e6d68b0
Jan  7 12:15:56 nfsvmf14 kernel: FS:  00007fa614d16840(0000) GS:ffff888217c00000(0000) knlGS:0000000000000000
Jan  7 12:15:56 nfsvmf14 kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
Jan  7 12:15:56 nfsvmf14 kernel: CR2: 0000559a53e66908 CR3: 0000000110c72000 CR4: 00000000000406f0
Jan  7 12:15:56 nfsvmf14 kernel: Call Trace:
Jan  7 12:15:56 nfsvmf14 kernel: <TASK>
Jan  7 12:15:56 nfsvmf14 kernel: __refcount_sub_and_test.constprop.0+0x2b/0x36 [nfsd]
Jan  7 12:15:56 nfsvmf14 kernel: nfsd_file_free+0x119/0x182 [nfsd]
Jan  7 12:15:56 nfsvmf14 kernel: destroy_unhashed_deleg+0x65/0x8e [nfsd]
Jan  7 12:15:56 nfsvmf14 kernel: __destroy_client+0xc3/0x1ea [nfsd]
Jan  7 12:15:56 nfsvmf14 kernel: nfs4_state_shutdown_net+0x12c/0x236 [nfsd]
Jan  7 12:15:56 nfsvmf14 kernel: nfsd_shutdown_net+0x35/0x58 [nfsd]
Jan  7 12:15:56 nfsvmf14 kernel: nfsd_put+0xbf/0x117 [nfsd]
Jan  7 12:15:56 nfsvmf14 kernel: nfsd_svc+0x2d0/0x2f2 [nfsd]
Jan  7 12:15:56 nfsvmf14 kernel: write_threads+0x6d/0xb9 [nfsd]
Jan  7 12:15:56 nfsvmf14 kernel: ? write_versions+0x333/0x333 [nfsd]
Jan  7 12:15:56 nfsvmf14 kernel: nfsctl_transaction_write+0x4f/0x6b [nfsd]
Jan  7 12:15:56 nfsvmf14 kernel: vfs_write+0xdb/0x1e5
Jan  7 12:15:56 nfsvmf14 kernel: ? kmem_cache_free+0xf1/0x186
Jan  7 12:15:56 nfsvmf14 kernel: ? do_sys_openat2+0xcd/0xf5
Jan  7 12:15:56 nfsvmf14 kernel: ? __fget_light+0x2d/0x78
Jan  7 12:15:56 nfsvmf14 kernel: ksys_write+0x76/0xc3
Jan  7 12:15:56 nfsvmf14 kernel: do_syscall_64+0x56/0x71
Jan  7 12:15:56 nfsvmf14 kernel: entry_SYSCALL_64_after_hwframe+0x63/0xcd
Jan  7 12:15:56 nfsvmf14 kernel: RIP: 0033:0x7fa6142efa00
Jan  7 12:15:56 nfsvmf14 kernel: Code: 73 01 c3 48 8b 0d 70 74 2d 00 f7 d8 64 89 01 48 83 c8 ff c3 66 0f 1f 44 00 00 83 3d bd d5 2d 00 00 75 10 b8 01 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 31 c3 48 83 ec 08 e8 ee cb 01 00 48 89 04 24
Jan  7 12:15:56 nfsvmf14 kernel: RSP: 002b:00007ffc79bf4748 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
Jan  7 12:15:56 nfsvmf14 kernel: RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007fa6142efa00
Jan  7 12:15:56 nfsvmf14 kernel: RDX: 0000000000000002 RSI: 000055d4cb8093e0 RDI: 0000000000000003
Jan  7 12:15:56 nfsvmf14 kernel: RBP: 000055d4cb8093e0 R08: 0000000000000000 R09: 00007fa61424d2cd
Jan  7 12:15:56 nfsvmf14 kernel: R10: 0000000000000004 R11: 0000000000000246 R12: 0000000000000000
Jan  7 12:15:56 nfsvmf14 kernel: R13: 0000000000000000 R14: 0000000000000000 R15: 000000000000001f
Jan  7 12:15:56 nfsvmf14 kernel: </TASK>
Jan  7 12:15:56 nfsvmf14 kernel: ---[ end trace 0000000000000000 ]---

