Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E7E4742A6D
	for <lists+linux-nfs@lfdr.de>; Thu, 29 Jun 2023 18:16:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232103AbjF2QQR (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 29 Jun 2023 12:16:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232425AbjF2QQL (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 29 Jun 2023 12:16:11 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9975170F
        for <linux-nfs@vger.kernel.org>; Thu, 29 Jun 2023 09:15:59 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35TE7hJF013903;
        Thu, 29 Jun 2023 16:15:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=2TE393OzsIykOf34GJhQeEzm3D9nNOl+choyXouI4AQ=;
 b=LyIFt6R2OHNPRdK522RLT/tMIO0arQLS2glflQp6BZgEWa+IfagsoD3x4gX7Pkgb3+VK
 wBit4GFdhOuFQgTJRXrLLx8FTzbM5aRCygvwhpjxaqFD0p2G8kmUH0unmofY2QfYdqh9
 ILvcgzmLvL5hd4Y3xJVX/b4oWVRE46khmPFFeS1sLDtdTQNDOs2VtrFBmiYlRGW0H1XI
 N7XXlbbbpL3+zWr7/Qn+13GeFk+RKJiP6FXPQKvGs9jtANJ8RpNpG65ZpcWUyMvGwI2l
 2XT+RqSFX751gb4DD5ZKaKMhg6DZCn8q5x2wGBwBCNQ43x4aeZFelPMWZxPz4ulHLo6i Jw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rdq93cx8m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 29 Jun 2023 16:15:55 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35TF0wVN003986;
        Thu, 29 Jun 2023 16:15:54 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2046.outbound.protection.outlook.com [104.47.66.46])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3rdpxdmuux-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 29 Jun 2023 16:15:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lQH4q9Wn/a9kvMnksv8GTvnLQoPmFLt+VTp1kzhDwp1/unvKMRHmEhXzPU0to7ZqpWpukcHNiHlb7yUu/BwdNa0cKkkM0NauB41Lh15pWTEW/FT/rRy834JB1C/itFB+gumC0cZ9JVpJf7DIf2ofvcAm5yrC0HZK/94BhnDVOR+QKtiDozgnC26Q/cxAW2tkanP4idp1A8d/hTvqEoNtigCEU/qeHy+thI0l25vN2mFtxJVpL7PtXE6+jRUzd8ciluQtQw63cdMxqsK01u6+G+gxmrOrXpyYwspRwDKX/gURLH0jspPFBo303lrmZETsgS4GfUVnzeI3CZxuf4WvjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2TE393OzsIykOf34GJhQeEzm3D9nNOl+choyXouI4AQ=;
 b=nc154a/MBN9MVe/HUmrzFpx+npenZ4DxeHLXnpQi0Gu9UKjk3ddatGOjI6fMIh9MS79GNPTcuzUpiVgYw2FS7rTFuJqwChdWF4G8avGhrXf34/UD1RG4nMZBlPekH84An2ZXbE4zgMjNL5F+uwsXAwsYRY1ntQ3l9PiHR9vv1lR/QI4yberX0J/lCSJzHq567iBtvyHMXVC1sDE+cOInRAZ8DFbbglJcTdA86y//KKMzIUB3DihEXnt1pCdoIbzbrD4JyL3Va/8S37WwWkN4r3qhj+tQqqYJaT0unofyP8He1Ec1B+Na1xMS6jhgsoeTk6qKYU/B08ylFrVLkkpxZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2TE393OzsIykOf34GJhQeEzm3D9nNOl+choyXouI4AQ=;
 b=Vn56i/qmJ8QeW0voJvCSFwd+Ii97RbkV5zb1pJfPfapsPGuoOUYidypywShmPsMWp2ID7fcaPk+U3v3B64lwehn0erAhPxr2fDhKhhzhVOaJCGo0Ws0thhpjWcn0Rpf7AqTJBagPJKVAIAlPeUj2YomtAn9ZHoYJ1OfRdaLOX1k=
Received: from MN2PR10MB4270.namprd10.prod.outlook.com (2603:10b6:208:1d6::21)
 by MW4PR10MB6632.namprd10.prod.outlook.com (2603:10b6:303:227::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Thu, 29 Jun
 2023 16:15:51 +0000
Received: from MN2PR10MB4270.namprd10.prod.outlook.com
 ([fe80::1b0f:fad9:3eb1:95e8]) by MN2PR10MB4270.namprd10.prod.outlook.com
 ([fe80::1b0f:fad9:3eb1:95e8%7]) with mapi id 15.20.6521.024; Thu, 29 Jun 2023
 16:15:51 +0000
Message-ID: <eed1d4f3-dfa4-204e-c318-bef162f6b788@oracle.com>
Date:   Thu, 29 Jun 2023 09:15:48 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.2
Subject: Re: [PATCH v6 3/5] NFSD: handle GETATTR conflict with write
 delegation
Content-Language: en-US
To:     Chuck Lever <cel@kernel.org>
Cc:     chuck.lever@oracle.com, jlayton@kernel.org,
        linux-nfs@vger.kernel.org
References: <1688006176-32597-1-git-send-email-dai.ngo@oracle.com>
 <1688006176-32597-4-git-send-email-dai.ngo@oracle.com>
 <ZJ2cgj9QzrgHExLG@manet.1015granger.net>
From:   dai.ngo@oracle.com
In-Reply-To: <ZJ2cgj9QzrgHExLG@manet.1015granger.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0336.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::11) To MN2PR10MB4270.namprd10.prod.outlook.com
 (2603:10b6:208:1d6::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4270:EE_|MW4PR10MB6632:EE_
X-MS-Office365-Filtering-Correlation-Id: db0c81cf-ae1f-43e8-e219-08db78bc1bad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yxiikfpjGtftMEoxLqC9M0fh93y5ZAQf7ELcwcPE48NY1hfZqgL6w5BRqs6DSm4ZHAiKzGGOsz9IDaGuOZUxGLkg9Enag3yRBPPkknvKE2wOKojrAb6UogqSgAThduor/SPmBmHifZZF7qT0BLUYMTxjyV757CBOsNqoy45yDUhNQ6r9VVaI3qZAc6yQaSE/d9T2OnQ4XPoU5MyOmQ0ZF8wPiNPWlQMmIVBnW8luCWDzaFbrY5sqQXOiFA34agPjgKEHakWnP68n/Poy3GUjUTek9ApGHpryRwI6w2uEtg4usdgPvfN1qTXXpy0u3x/XkMkz3Wc+UaFfCbV7VYMX7clSngP13fncDYYpDw3uG/soetnlFPjEM0Ym3bTutBc/TUaCP7rKptZ0twfrFzRoSsKRyH5sppliOzNVbLvwG8XmLw44Y4RBTf/HlwLK3qBjTb3YFExXdHsw9gblLsf9NtZnDrl9kFu8UhapvBDmQuXSPTkCvi1QuOHMKKbysLWLUuJRNQjqN5ehMGHd6lQ+vwGg6CTKfbOkati1NI2krSIDS6G6n/aCI0TLMCEv0ynS7vp2bvs+bNIx1O/rhGL+CXvNs5dH0Y5Je3ILQBBy/RHBwGy+sFl46lBQqavSgzMi
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4270.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(366004)(136003)(376002)(39860400002)(346002)(451199021)(2906002)(8936002)(8676002)(6506007)(316002)(53546011)(66946007)(4326008)(66476007)(66556008)(6916009)(31686004)(41300700001)(6512007)(9686003)(186003)(26005)(6486002)(86362001)(38100700002)(31696002)(83380400001)(6666004)(2616005)(5660300002)(478600001)(36756003)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RGlzQXhWaGQ1Yk5uaWEveSs0elhUT1ZKcTdTUUdlckUveGk5eGcrdWdFbExV?=
 =?utf-8?B?WUk2WDJxem5NalZabmVaMm5WcmczZ3JNUHZXc0szbXBOSzJvSTFFNlBDNXBu?=
 =?utf-8?B?U2Z1Zlh0djFybFE5bnNUV056TmJkLzBQVDYyVjBwVFVpZnNRYnpqRnlNbEp4?=
 =?utf-8?B?azVjSTErMXNSV0g0Zy9ubXk4NE1uQzlXenBrWUdpTmZOS1Q1Nm1yWHVWQ1h4?=
 =?utf-8?B?Y0JPajY0UWdnMHV0RkJsK0hxSUhiL2kvQUFHcWV4cFhDVVE5ZzBWNkNveXZ4?=
 =?utf-8?B?Ky9aSUJ1SE40SWlHZlhPWXQvU3lDWUx3Y2djNmE5Q1VKbnRWQlBSYlV1ODhk?=
 =?utf-8?B?OXhPMXMyNjJGRGhWTWVFaUp3SUZXOTNkZmlyQUVVYVRsSjhVaXZDaXcycHBY?=
 =?utf-8?B?MnBObzV5cTJzanpSUStQUEdTeXNEcW9pdktWN3hIbU4yckNQd25wM3RlU2ZL?=
 =?utf-8?B?SHgyMnk3UFVZYmI3WGN3VktJUURJczdpTjdSTmFoMmZIOWNLNDBvODhXYS9Q?=
 =?utf-8?B?eFNPUVJSOElyRmkrVHNuZUlNaHJrQTNtenViQitSTEc3ZDlxS1h3YlNtdVU3?=
 =?utf-8?B?SmpGNjJHRkJlZUNPVkF2MGVJSWhwbnYyYkZnd3FSZEpUWkJwaWMxTUp4MW8y?=
 =?utf-8?B?aWhlYXh6QXArMHgzSUVockJySk0rcEZNQjBpcDR4akpjelEvMGZOdjYyb0tq?=
 =?utf-8?B?Y0NPTHBlYjNGeEtEYkFXYno2VDlzZzFQRW9BSlVPQjkwYmcvUXp2ZHFJdVh1?=
 =?utf-8?B?VUVVb3FiaEhwZVZ1UVdHaGJ1N2ZGb05NTUF4enJ1aHhBRVdRYzkxM0hFYVVp?=
 =?utf-8?B?cXZQdkt0bkV0WUZrUVBuZmNDTEpmNmpzREIyL3NCR3REemRMR3BZMzByeW41?=
 =?utf-8?B?Rk1RVWlOeEhIa0h1WGZWZ2NPNTR3OW1HRjVxTm9RZEI2NmM2T2FVUzRKVUdz?=
 =?utf-8?B?bzlDWkIzZGNZR0hjYko1M3FoRWI2ckRkRkl6U1FlR1RRZm9aL3loUm8xbGFi?=
 =?utf-8?B?ajRHRzBTeVVDSU5JblBXWnh4NEVTMGNaMElNM21idlJaRG1ydnBZc25aTytu?=
 =?utf-8?B?UGxic1ZqZlBMcjNJOWNPRkFxUkg2b1RiU3IwUXozV1hFc0NNczdPSWYxWHRq?=
 =?utf-8?B?SjltdW9lQmYxU3p3akdRbzJaZkJKN2NiRWxTUkY3dkpsdE9aYzdzRVRqY29i?=
 =?utf-8?B?TTdYaE5ERTRId2pvakR2SEFwN1BIeUZkYlVjYlVXSWxwYTY2RXltTnBudUZs?=
 =?utf-8?B?a054MHl5dDFUN0x5Tjc1OURYbWJZUUVRaW95c2V4ZnBMUWFWeFhDODZCcGMy?=
 =?utf-8?B?LzB5ZUgyVXNDRFZWZGxUSTNoN0RJRWQxbkZkTGU5YmlZcDlLNDgxWkF6NVlo?=
 =?utf-8?B?QXlFNWd1czB5MnA5U0hsMWpWclZkajhybkVSNU5pRWxDRW51cWxvSnh3bk5T?=
 =?utf-8?B?YmNrSDV4a0pZV2FycU8yRUFHQXlzamVTekpmaWV5elFFRnl3elZjRFc3V2dO?=
 =?utf-8?B?QWViU09qTzBtb0M0RHI2dDQ5TmxUam5LbXRUam4yLzVLTDJUYnFMcTkrdTVR?=
 =?utf-8?B?T3BYV0pIK0NEU1l6TUptUTlEd0RIUUJrd0dTSWZCU01jSThLaHVrSjc0U3Jv?=
 =?utf-8?B?d3pPM08yemtUNTJiejRMLy9wZnArMjFlblRYVlB6VXNEeDEzclFLM2s4dytL?=
 =?utf-8?B?bjBvWlFvKzdqLzNvNUF3cVVoNDBzNjFXM2NONk00U0VHOG5LRFdXRXRqQzhy?=
 =?utf-8?B?R3dIek14M0x0R3JTZ3Y3Z29meWFmamxlU2VjajFyRis5T0RWKzI5Qm5GUlZL?=
 =?utf-8?B?NTZWanVpVzR2bThQT3VOVzNjcllxclpwV1AwYW9NTnFiaDI1TGdLWUJyY1dI?=
 =?utf-8?B?VUV4TDNETG9sM3RHMlA4cmdIWkRoaXY5TERTdm1pdnNNY0xlY2svOTFyWWVI?=
 =?utf-8?B?blRMM2Z5MFNVTlBxSkcrd0tqMkdjNEVkcnkxUkNFRCszeW9JMkxoOUpCeC8z?=
 =?utf-8?B?cGhpSXBtUkIyWGxaMVJSNlRmTFI0ZjZNcVppVkcxbjZteG5KRWJyUFlGaXBv?=
 =?utf-8?B?WG9DejlROFc1bTdDTHBJRjBDWDZZN3JQQkluTStCMEExQVJBMExsWTNWeUxy?=
 =?utf-8?Q?SRh5HoI68iUDr6hFznpGa9MpY?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: I1DPcsTytvIr3xxkXXCBtIRBnMZu1nTfF1PDDkbV6CiQnNsF6w11tT5IQfN9qildsO9KI8Huubk4Qkplf7P/T5RCI92bh9HVQt4R8N9BjXmDDu1lzNvlWg1bumeaobEwQwAfhzCSdXo5v9DEc6CJkmS4zsgZhiDBQjUufFoMBXBlyGnc7uM/ZuXmDGbhO7wt/Hl83cgq7f37PxzdRsz0iYlVcaaovQFjYPjCUys7HarNeRhR/T6skFrXflyC4tgT0DphI1SnLq3OVtSADbWF1YTyhPrjPc0QPKIh6sGYajeEeleK6ZbkDVF9uH6n/ISKWVsulL5+Tq34xNYxuIaHvl0ULbKPv/CLrHfsJaGAVCGC8ZTSNfPON7qGMIgYf7pIXAeTv+lzb2jHr8izVgM8HZOGQQh9iW7ShQFhbsaKlDyE85HcYGx6pgUN+bmXcfU6GBLxbrdOez6+u44pq8ui1Yvpmu/VcmQhsNguv6JFLetWTIxJBEXzjJdH8F3PktwXwyqeDQrBeZUFOgkshmbMFWxJ7qNdejeQM8p72h+cLF6YA06u7Fj1eS5aEQlSIStaDiwV4h1DcAJIwigq/l5lXtRnVI1VnSGDZt4/oSEYRHFb9GNQBtbaTaX3I9qNOVIhOhWixvaDlslUsnNcA/2WnYNHonI6xPaWR2SCZ7homchRa+r3rinO4sHOrvqcMxve+uR6TCibO2ZrAn0xW+0s8BK6gpu6WeSQYXiB8pnD2QJj8Qc3p99bqngffcLp/Rr6bFYdAQDg07CEPE2jD7mZ75dhgrTPq6mLSlYTEHH+6v4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db0c81cf-ae1f-43e8-e219-08db78bc1bad
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4270.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2023 16:15:51.8001
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E+gw1/PBD0RDmdqSvXh6j1hyZSa0I2dJlHMHa4dCL8EVfiy2ehPUR9OKdTL7Lk2M7txHUY2qG+CPVFRsD2ztSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6632
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-29_03,2023-06-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 mlxscore=0
 mlxlogscore=999 bulkscore=0 spamscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306290147
X-Proofpoint-ORIG-GUID: SGzMmVLKRNzDFgL8N6XF9LOdmI8uERrU
X-Proofpoint-GUID: SGzMmVLKRNzDFgL8N6XF9LOdmI8uERrU
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


On 6/29/23 8:00 AM, Chuck Lever wrote:
> On Wed, Jun 28, 2023 at 07:36:14PM -0700, Dai Ngo wrote:
>> If the GETATTR request on a file that has write delegation in effect and
>> the request attributes include the change info and size attribute then
>> the write delegation is recalled. If the delegation is returned within
>> 30ms then the GETATTR is serviced as normal otherwise the NFS4ERR_DELAY
>> error is returned for the GETATTR.
>>
>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>> ---
>>   fs/nfsd/nfs4state.c | 60 +++++++++++++++++++++++++++++++++++++++++++++
>>   fs/nfsd/nfs4xdr.c   |  5 ++++
>>   fs/nfsd/state.h     |  3 +++
>>   3 files changed, 68 insertions(+)
>>
>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
>> index f971919b04c7..2d2656c41ffb 100644
>> --- a/fs/nfsd/nfs4state.c
>> +++ b/fs/nfsd/nfs4state.c
>> @@ -8361,3 +8361,63 @@ nfsd4_get_writestateid(struct nfsd4_compound_state *cstate,
>>   {
>>   	get_stateid(cstate, &u->write.wr_stateid);
>>   }
>> +
>> +/**
>> + * nfsd4_deleg_getattr_conflict - Trigger recall if GETATTR causes conflict
>> + * @rqstp: RPC transaction context
>> + * @inode: file to be checked for a conflict
>> + *
>> + * This function is called when there is a conflict between a write
>> + * delegation and a change/size GETATR from another client. The server
> /GETATR/GETATTR/

will fix.

>
>> + * must either use the CB_GETATTR to get the current values of the
>> + * attributes from the client that hold the delegation or recall the
>> + * delegation before replying to the GETATTR. See RFC 8881 section
>> + * 18.7.4.
> Since you have mentioned CB_GETATTR here, you should also clarify
> that our implementation currently does not use it, but eventually we
> might implement CB_GETATTR to avoid recalling the delegation due to
> this kind of conflict.

will do.

-Dai

>
> Thanks for the thorough comments!
>
>
>> + *
>> + * Returns 0 if there is no conflict; otherwise an nfs_stat
>> + * code is returned.
>> + */
>> +__be32
>> +nfsd4_deleg_getattr_conflict(struct svc_rqst *rqstp, struct inode *inode)
>> +{
>> +	__be32 status;
>> +	struct file_lock_context *ctx;
>> +	struct file_lock *fl;
>> +	struct nfs4_delegation *dp;
>> +
>> +	ctx = locks_inode_context(inode);
>> +	if (!ctx)
>> +		return 0;
>> +	spin_lock(&ctx->flc_lock);
>> +	list_for_each_entry(fl, &ctx->flc_lease, fl_list) {
>> +		if (fl->fl_flags == FL_LAYOUT)
>> +			continue;
>> +		if (fl->fl_lmops != &nfsd_lease_mng_ops) {
>> +			/*
>> +			 * non-nfs lease, if it's a lease with F_RDLCK then
>> +			 * we are done; there isn't any write delegation
>> +			 * on this inode
>> +			 */
>> +			if (fl->fl_type == F_RDLCK)
>> +				break;
>> +			goto break_lease;
>> +		}
>> +		if (fl->fl_type == F_WRLCK) {
>> +			dp = fl->fl_owner;
>> +			if (dp->dl_recall.cb_clp == *(rqstp->rq_lease_breaker)) {
>> +				spin_unlock(&ctx->flc_lock);
>> +				return 0;
>> +			}
>> +break_lease:
>> +			spin_unlock(&ctx->flc_lock);
>> +			status = nfserrno(nfsd_open_break_lease(inode, NFSD_MAY_READ));
>> +			if (status != nfserr_jukebox ||
>> +					!nfsd_wait_for_delegreturn(rqstp, inode))
>> +				return status;
>> +			return 0;
>> +		}
>> +		break;
>> +	}
>> +	spin_unlock(&ctx->flc_lock);
>> +	return 0;
>> +}
>> diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
>> index 76db2fe29624..b35855c8beb6 100644
>> --- a/fs/nfsd/nfs4xdr.c
>> +++ b/fs/nfsd/nfs4xdr.c
>> @@ -2966,6 +2966,11 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, struct svc_fh *fhp,
>>   		if (status)
>>   			goto out;
>>   	}
>> +	if (bmval0 & (FATTR4_WORD0_CHANGE | FATTR4_WORD0_SIZE)) {
>> +		status = nfsd4_deleg_getattr_conflict(rqstp, d_inode(dentry));
>> +		if (status)
>> +			goto out;
>> +	}
>>   
>>   	err = vfs_getattr(&path, &stat,
>>   			  STATX_BASIC_STATS | STATX_BTIME | STATX_CHANGE_COOKIE,
>> diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
>> index d49d3060ed4f..cbddcf484dba 100644
>> --- a/fs/nfsd/state.h
>> +++ b/fs/nfsd/state.h
>> @@ -732,4 +732,7 @@ static inline bool try_to_expire_client(struct nfs4_client *clp)
>>   	cmpxchg(&clp->cl_state, NFSD4_COURTESY, NFSD4_EXPIRABLE);
>>   	return clp->cl_state == NFSD4_EXPIRABLE;
>>   }
>> +
>> +extern __be32 nfsd4_deleg_getattr_conflict(struct svc_rqst *rqstp,
>> +				struct inode *inode);
>>   #endif   /* NFSD4_STATE_H */
>> -- 
>> 2.39.3
>>
