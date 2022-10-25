Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BAC760D7F6
	for <lists+linux-nfs@lfdr.de>; Wed, 26 Oct 2022 01:35:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231351AbiJYXfW (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 25 Oct 2022 19:35:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229875AbiJYXfV (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 25 Oct 2022 19:35:21 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE2ED4C2D8
        for <linux-nfs@vger.kernel.org>; Tue, 25 Oct 2022 16:35:16 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29PLmwD5017604;
        Tue, 25 Oct 2022 23:35:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=tubj2isq9oiF7CxQ9JSDuju1lSMiQhpMXGoIWuJxMhA=;
 b=cAC8BP1ChUhwtMdDpUB4mSILEeD3vwMm1UYaaIqrXvvnwaP7MUa6BT6L+fveTJjWlgvK
 B9D2sxqHKAJOfd0qc7XjVrjzI9akcFlYGQsiiYvL1/pVmBUCa79fjaOKivX6EVH/6WHk
 NeZyzBAwdcc1pmyqdI3JQ+paTazWtLqsgtdO07DPggOSJ6bsyMD9SpALNyqLB5PeG55u
 bnbzF1oc44J4LbpYD6p+6IoNA+zMUUe7gJL+ktsqU+3y7Au4dOBNnjAQkUE3tl7b2unr
 vzJ/rrnhIz1kVJXA/P1gj+P6N5EmWT6vA6kamu3DGvwipWn8i+LHQwummfMWNzUEjXDQ fA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kc939dmwe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Oct 2022 23:35:10 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29PLrWKQ017167;
        Tue, 25 Oct 2022 23:35:10 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2044.outbound.protection.outlook.com [104.47.57.44])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3kc6y5cbcj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Oct 2022 23:35:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d3h43S0FPmWaULKxdNwBjvFfQKP282RFsom5Gg2elGgo/PgpbatGFxg/AdvsgGfrliP9L+8txacXuhuKKqleCoM27tEPsXg7CdThkq3sce+m+pMcrFqJ8Zz19EtrSTNzXIhnNlqi1on+GTTEs1DVnETbsKQoTyGyx19XnCByj89T2s7YPD2lz/j7YPQ32LvLYJpomzl32Zo0cgShoYgnM4SrjbNnZMZE2gAUYQF9dsbQkNctMgAyTAJa6khAhSOeo5pH6XX7xoE6Gwa/rSvlL4G4q67oOdoDPWdnFG8RqqwXZ2z59Za+Ox5+HgVrHjiT+tWvfwtStS6BHWtc55+ZDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tubj2isq9oiF7CxQ9JSDuju1lSMiQhpMXGoIWuJxMhA=;
 b=N8HCB4/SBCw5tUiyL+qvz8VXDX9t2mj6Lu2rFancaBD5KpDO8s91h8o4haDA5TQyGEfjQ8jbh+Ggb/usTC3QL2tA9dzqJzIk9R+TBnlH+F66/hLr/vG3a60jyY00osXqDpmcmM6lUWKYWv4loZboxWTRtfsvUQHhxBwoW4TnJo7e//9muDH6QyjTOgkrJ7df72ygp4aO24mBILGdSOngwVg84bZ/7kMLzGTOvVGfqIcZOEjJsYQ2ox7rbpkRKSG9718rrTvorQXmfh89/HvyvvctBKdYXPCsF+LiIGgqCNXGaz4ggVsOWg4C+CdyV9EYDYesqHoBhyRFu0MGcwfUmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tubj2isq9oiF7CxQ9JSDuju1lSMiQhpMXGoIWuJxMhA=;
 b=dGDJoS2gpeUZP/VZq34eFXO4AsouUZ8jRH2xULGK7LSqeK3zj757ixv8r7Y+ONBWETZ3JL5Tl3J13eMqR5PZFYeVtBpc37uztCR6wXLcJiMTBI5ht1ACys3dmVG/XeTl6xF+SdeH/qU4UfeamdvYK59ZSpILLhqyuxNp1R7pDGo=
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by PH0PR10MB4534.namprd10.prod.outlook.com (2603:10b6:510:30::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.23; Tue, 25 Oct
 2022 23:35:08 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::21ec:d1ee:2a59:a1d0]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::21ec:d1ee:2a59:a1d0%6]) with mapi id 15.20.5746.023; Tue, 25 Oct 2022
 23:35:08 +0000
Message-ID: <dd1b822b-6742-12c9-4275-4972b6f2eac6@oracle.com>
Date:   Tue, 25 Oct 2022 16:35:04 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.0
Subject: Re: [PATCH v2 1/2] NFSD: add support for sending CB_RECALL_ANY
Content-Language: en-US
To:     Jeff Layton <jlayton@kernel.org>, chuck.lever@oracle.com
Cc:     linux-nfs@vger.kernel.org
References: <1666462150-11736-1-git-send-email-dai.ngo@oracle.com>
 <1666462150-11736-2-git-send-email-dai.ngo@oracle.com>
 <d43a3dac01f8c4211ec7634a0d78dae70468f39b.camel@kernel.org>
 <efbea8dd-1998-fe2a-1a94-6becc5ea691f@oracle.com>
 <342dd03eea9a1eccf1848c1e2f5f92791c4c42f2.camel@kernel.org>
 <ffcf7b71-8afd-bea1-9757-e7e0dc36f187@oracle.com>
 <df4ee39e5cda843416e7a88addabcba25594d618.camel@kernel.org>
From:   dai.ngo@oracle.com
In-Reply-To: <df4ee39e5cda843416e7a88addabcba25594d618.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN0PR04CA0084.namprd04.prod.outlook.com
 (2603:10b6:408:ea::29) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4257:EE_|PH0PR10MB4534:EE_
X-MS-Office365-Filtering-Correlation-Id: ed81be33-5b94-4b4f-55eb-08dab6e18d30
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: c1bom5iapz67dUsWiBQ/aSJMy2N1ChoppPuYfxsLurzNcneb2ibrOB28/ae4U3J0kxjGklT6pp71VeZhu+igfMtS+3phiQpuG7NQUyvdJ4efIWmglNC+DEN0UM7eUnVDlWulSwsON67z4qxBB5nUpHq7FiSQeVd/w4rIqT05+xdaJTXi0uWfLyvOcooNPQwAcSFgd2nQ/ONEY/9u44UsEVklGZKs+WsLbnKft+wnYcdd/23gKUoYM011LcmExw7luYHmlpTIUALY2aqeZQW+4UrqCBUzEqetyFNltBAu8wkyS1aI8as+iHjCKg8rJ/1oS2WbwhE2drHg0Cky8+tK3KIDONSj4RiG1diToc3y0TnpQYAnJPJPG9ihODlkYfpXmof9cXqm3msZ6fR6v9c9MEEoUKfC0KoQHSwPSGu2Hvc4tuehWhl65RVFlGOp4trmnNC5gGzdL9IFz2yIKPWevKwLxsWKmZsp54RwueEao5LL+Cj5AqSNnb/F2F5wsSj9fPwInagugFyyr8Yg1i41lngsluIhVeFUaN8R9rFylojsT3dMCpZhnMJ3BliGBnksiYXuvm/FVzeBG2KVizk6RLGjQFbJB4KVC2ixwBNmqRi2IuEsHnhkbfykUgkLgpV1op/8Wcx+Rp5by93jMryGgYbtdNSAwVjXmaAFUQTJfcobZw1NhnRcixjyohgyjh1H+D8YpQJZsqSYct/rbqULUsyZH884rH8CSZxuMyPNd5QeKTa+mBjvfXH5VUZyFlGz
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(396003)(346002)(136003)(39860400002)(376002)(451199015)(31686004)(66946007)(6512007)(36756003)(86362001)(4001150100001)(2906002)(38100700002)(31696002)(186003)(83380400001)(2616005)(6666004)(8676002)(6486002)(4326008)(53546011)(26005)(6506007)(316002)(66476007)(66556008)(9686003)(5660300002)(30864003)(478600001)(41300700001)(8936002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aGcrZUppL1gyTExIT092Ni9qWnZocy9OYk5KM0lrUlBhc3V1b3dKZVhZRFFN?=
 =?utf-8?B?OWNSQW0vNTZiRXZnaFFEYzNzZ3Y3VW1Ka0N1TXA5RmRCSTdvWUFGZ2t4bDV5?=
 =?utf-8?B?SWtWZzJSeldWMTl2ZnJxSWtUU29VR1BkOENlZUlkWG4rY1dWdFR1TExFYzIv?=
 =?utf-8?B?ZFVqbG1XMDF6Tm41NE1mWlFLNTVLc2ZzcnZveDE0Ym9SMkI2UFBOV3Nvdk1P?=
 =?utf-8?B?NStqY2ZmZGNybzM4R0oxNDRnc1dPUXRVRnJPakVLenNraUdmUTRENW1TMGtx?=
 =?utf-8?B?WTQ5RE5QSnhJazQ2Q3BNSCtBK3JxdWlYY0hLeFNJVndBZjV5c1R5MVMwbjFE?=
 =?utf-8?B?bCtzMXRsSGkvdDYzRnZ3eHpKVG1EclZQdU9tdmxweHFhVlE2N25HT2dlVjkx?=
 =?utf-8?B?OTg5OUxCak1SQ1h6L0pJeE1tTk00M0tnbXcwaWFKRTJ6OUhoeTlYVnRYZVZz?=
 =?utf-8?B?NUI1elhlc3Iwa2lMU3UvTHh5NUg0RXNYZTUrYlJudmY2OGJUUTJCbGlETkdT?=
 =?utf-8?B?RVBaYXdXVW9hVmxLSEloME4vblg1WGxoallBOVFWRUhSaHZ3UDlGTVY1aWpS?=
 =?utf-8?B?M0JjODV2b3BVTHNyWkRZR0ZzdzBYakcwaXhLUHE0VFJ0eGtySlNKQm5hUSti?=
 =?utf-8?B?bXRUMERGaDVoalBZUzUvZ1BXUUZIMURBanU3Z09nK2JkQ3VsYXV4MWluT0V2?=
 =?utf-8?B?d3g1UWhNRVh6K2hoY0dxS05hd3k0bHpGQ3o0NjJwSlhDSXJuUmhiNncxQWE5?=
 =?utf-8?B?cjJEZ1JGZ1ZMemFBVXFOTE5jSFMvNElMMWc0VEQ2S3hFemZZUEZrNXB6Mmg0?=
 =?utf-8?B?K3FSMGtOTlBMT0txSXpQOFBEVk5FVFIvWHB6cmJnZ1hOcEI5a0QrZUpvOVVw?=
 =?utf-8?B?L2dPOU1wZlZxNnZpUGgrZTVEOGZRaDZVTVE5bC9veTNob2Qyc0VZcmlvbVB1?=
 =?utf-8?B?T3Y0b1pFTFpKNTNrY1BMbjJvVHRlUWFiSEs0RU5vdFBXU29QaGM3UGx3aFYy?=
 =?utf-8?B?Qitzd0Z2OGo0b2NqM2U0L3dqOHdsZkNuRVNUaHhNS2R1dXdnVjVDanVLVmha?=
 =?utf-8?B?c09vZ1JaS1lMV1JUUDhuSXRnUDYxeEV5NFpnbjlJT0FlRzJYYk1wZnV6dVF2?=
 =?utf-8?B?aXJmalhtbm0xNmtxUWJyMzdPZ2pHNUtiOUxmNVhwSEVPc1FJbFNzR0Zzb2U4?=
 =?utf-8?B?U1Z6aHNlL2V0VTBDTjRWS1Blc3BPSHBsNU53VjBsNWFNRHJLa2ZqYmthVnZK?=
 =?utf-8?B?UjZKcCtPQmwxUWlrOEQ2K29yVHlVWXdCWi9jM0lpdUV0VGQ2dXhmaHpEN3dZ?=
 =?utf-8?B?TzZ4M3pHMnFrYzVxZ1d2RDYwZ0FGWmxDZ3kzM1BMdlVRVjQvbFBtK0lQOEp2?=
 =?utf-8?B?NzkyNWdwaXhYT2hTcEt6T3lEU1EvTWpkZXNiT0Q2NzFKZmk5cDdHN3VGZkRH?=
 =?utf-8?B?NHF4OVZ1L0Z2SlVMYy9USnlPTHY3bDY5MlVGQ0tkT1lpbWVqUW15dlBoa2U3?=
 =?utf-8?B?b2o0bnBXTFNWTmt4dzFqWEUzVUNLODdlNW9mbmhkdlpZNnZKeWZUTkNJOVY2?=
 =?utf-8?B?c3JZQWVaMTZ2Nmpnbm9WdmI3VmtvZDNKMUQ4c3Y1TmVTWmVNWGM1K1RYdVRv?=
 =?utf-8?B?R1JnN21VcU15ZndwWEt3SjFBM2xUeFNmaXljRjd6MGlIYUVQaXIwWE1CQS9R?=
 =?utf-8?B?NmxaVExaVHBOVjBacEdwNGYrNXBWV1lQWi81VjgzNDZaaERPWDlpOUZOMkZz?=
 =?utf-8?B?Wk4xY0lIVFBoaklObkN0UWZBUnZla1pobHRqTHFyckd4am5nWVhZK2pMMmtp?=
 =?utf-8?B?TFp3MXNrR05qUHhGOVdVRXVuRERreHZvWGlNOHQxcm1oTXlINWJCZHJRaHhC?=
 =?utf-8?B?K2pvdmNFdjRQZnE5eGw2OHFHblEvaTBQaFVRNWY3RVZzQ25SK2pITVRHT0dk?=
 =?utf-8?B?bWYvTXBhM0VWV0RkdGpFWkF4cGtQcGd4cmJlODR6TksxaDZkak82b2IvYjJ6?=
 =?utf-8?B?aVBUWFZnVm1OSW5UYjlxVWJKTXZhSTUybThtLzRNT0VYZUdnTFBjSjNMaldJ?=
 =?utf-8?B?bWZMWk9SSEo1b25ieUdmandZTjBXRnFma09CMGI3aHlQTEd4dmZ2ZEJ3RVNJ?=
 =?utf-8?Q?KGDheLl8UyP3u/UII0yMh4qgb?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed81be33-5b94-4b4f-55eb-08dab6e18d30
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2022 23:35:08.0873
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZYDQdJQX8Z3fVLujvhrWrWQGSqw3uMdpepH3BbeAhVXbYMYDS5b/18yEHKtAXe3tJZcSuyxFZkpZjFpLRRfqUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4534
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-25_13,2022-10-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 phishscore=0
 mlxlogscore=999 adultscore=0 malwarescore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2210250130
X-Proofpoint-GUID: e8W9irqh-wtXPx6vrqhW4t5g1ORhPgin
X-Proofpoint-ORIG-GUID: e8W9irqh-wtXPx6vrqhW4t5g1ORhPgin
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


On 10/25/22 2:33 AM, Jeff Layton wrote:
> On Mon, 2022-10-24 at 18:30 -0700, dai.ngo@oracle.com wrote:
>> On 10/24/22 2:09 PM, Jeff Layton wrote:
>>> On Mon, 2022-10-24 at 12:44 -0700, dai.ngo@oracle.com wrote:
>>>> On 10/24/22 5:16 AM, Jeff Layton wrote:
>>>>> On Sat, 2022-10-22 at 11:09 -0700, Dai Ngo wrote:
>>>>>> There is only one nfsd4_callback, cl_recall_any, added for each
>>>>>> nfs4_client. Access to it must be serialized. For now it's done
>>>>>> by the cl_recall_any_busy flag since it's used only by the
>>>>>> delegation shrinker. If there is another consumer of CB_RECALL_ANY
>>>>>> then a spinlock must be used.
>>>>>>
>>>>>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>>>>>> ---
>>>>>>     fs/nfsd/nfs4callback.c | 64 ++++++++++++++++++++++++++++++++++++++++++++++++++
>>>>>>     fs/nfsd/nfs4state.c    | 27 +++++++++++++++++++++
>>>>>>     fs/nfsd/state.h        |  8 +++++++
>>>>>>     fs/nfsd/xdr4cb.h       |  6 +++++
>>>>>>     4 files changed, 105 insertions(+)
>>>>>>
>>>>>> diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
>>>>>> index f0e69edf5f0f..03587e1397f4 100644
>>>>>> --- a/fs/nfsd/nfs4callback.c
>>>>>> +++ b/fs/nfsd/nfs4callback.c
>>>>>> @@ -329,6 +329,29 @@ static void encode_cb_recall4args(struct xdr_stream *xdr,
>>>>>>     }
>>>>>>     
>>>>>>     /*
>>>>>> + * CB_RECALLANY4args
>>>>>> + *
>>>>>> + *	struct CB_RECALLANY4args {
>>>>>> + *		uint32_t	craa_objects_to_keep;
>>>>>> + *		bitmap4		craa_type_mask;
>>>>>> + *	};
>>>>>> + */
>>>>>> +static void
>>>>>> +encode_cb_recallany4args(struct xdr_stream *xdr,
>>>>>> +			struct nfs4_cb_compound_hdr *hdr, uint32_t bmval)
>>>>>> +{
>>>>>> +	__be32 *p;
>>>>>> +
>>>>>> +	encode_nfs_cb_opnum4(xdr, OP_CB_RECALL_ANY);
>>>>>> +	p = xdr_reserve_space(xdr, 4);
>>>>>> +	*p++ = xdr_zero;	/* craa_objects_to_keep */
>>>>>> +	p = xdr_reserve_space(xdr, 8);
>>>>>> +	*p++ = cpu_to_be32(1);
>>>>>> +	*p++ = cpu_to_be32(bmval);
>>>>>> +	hdr->nops++;
>>>>>> +}
>>>>>> +
>>>>>> +/*
>>>>>>      * CB_SEQUENCE4args
>>>>>>      *
>>>>>>      *	struct CB_SEQUENCE4args {
>>>>>> @@ -482,6 +505,24 @@ static void nfs4_xdr_enc_cb_recall(struct rpc_rqst *req, struct xdr_stream *xdr,
>>>>>>     	encode_cb_nops(&hdr);
>>>>>>     }
>>>>>>     
>>>>>> +/*
>>>>>> + * 20.6. Operation 8: CB_RECALL_ANY - Keep Any N Recallable Objects
>>>>>> + */
>>>>>> +static void
>>>>>> +nfs4_xdr_enc_cb_recall_any(struct rpc_rqst *req,
>>>>>> +		struct xdr_stream *xdr, const void *data)
>>>>>> +{
>>>>>> +	const struct nfsd4_callback *cb = data;
>>>>>> +	struct nfs4_cb_compound_hdr hdr = {
>>>>>> +		.ident = cb->cb_clp->cl_cb_ident,
>>>>>> +		.minorversion = cb->cb_clp->cl_minorversion,
>>>>>> +	};
>>>>>> +
>>>>>> +	encode_cb_compound4args(xdr, &hdr);
>>>>>> +	encode_cb_sequence4args(xdr, cb, &hdr);
>>>>>> +	encode_cb_recallany4args(xdr, &hdr, cb->cb_clp->cl_recall_any_bm);
>>>>>> +	encode_cb_nops(&hdr);
>>>>>> +}
>>>>>>     
>>>>>>     /*
>>>>>>      * NFSv4.0 and NFSv4.1 XDR decode functions
>>>>>> @@ -520,6 +561,28 @@ static int nfs4_xdr_dec_cb_recall(struct rpc_rqst *rqstp,
>>>>>>     	return decode_cb_op_status(xdr, OP_CB_RECALL, &cb->cb_status);
>>>>>>     }
>>>>>>     
>>>>>> +/*
>>>>>> + * 20.6. Operation 8: CB_RECALL_ANY - Keep Any N Recallable Objects
>>>>>> + */
>>>>>> +static int
>>>>>> +nfs4_xdr_dec_cb_recall_any(struct rpc_rqst *rqstp,
>>>>>> +				  struct xdr_stream *xdr,
>>>>>> +				  void *data)
>>>>>> +{
>>>>>> +	struct nfsd4_callback *cb = data;
>>>>>> +	struct nfs4_cb_compound_hdr hdr;
>>>>>> +	int status;
>>>>>> +
>>>>>> +	status = decode_cb_compound4res(xdr, &hdr);
>>>>>> +	if (unlikely(status))
>>>>>> +		return status;
>>>>>> +	status = decode_cb_sequence4res(xdr, cb);
>>>>>> +	if (unlikely(status || cb->cb_seq_status))
>>>>>> +		return status;
>>>>>> +	status =  decode_cb_op_status(xdr, OP_CB_RECALL_ANY, &cb->cb_status);
>>>>>> +	return status;
>>>>>> +}
>>>>>> +
>>>>>>     #ifdef CONFIG_NFSD_PNFS
>>>>>>     /*
>>>>>>      * CB_LAYOUTRECALL4args
>>>>>> @@ -783,6 +846,7 @@ static const struct rpc_procinfo nfs4_cb_procedures[] = {
>>>>>>     #endif
>>>>>>     	PROC(CB_NOTIFY_LOCK,	COMPOUND,	cb_notify_lock,	cb_notify_lock),
>>>>>>     	PROC(CB_OFFLOAD,	COMPOUND,	cb_offload,	cb_offload),
>>>>>> +	PROC(CB_RECALL_ANY,	COMPOUND,	cb_recall_any,	cb_recall_any),
>>>>>>     };
>>>>>>     
>>>>>>     static unsigned int nfs4_cb_counts[ARRAY_SIZE(nfs4_cb_procedures)];
>>>>>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
>>>>>> index 4e718500a00c..c60c937dece6 100644
>>>>>> --- a/fs/nfsd/nfs4state.c
>>>>>> +++ b/fs/nfsd/nfs4state.c
>>>>>> @@ -2854,6 +2854,31 @@ static const struct tree_descr client_files[] = {
>>>>>>     	[3] = {""},
>>>>>>     };
>>>>>>     
>>>>>> +static int
>>>>>> +nfsd4_cb_recall_any_done(struct nfsd4_callback *cb,
>>>>>> +			struct rpc_task *task)
>>>>>> +{
>>>>>> +	switch (task->tk_status) {
>>>>>> +	case -NFS4ERR_DELAY:
>>>>>> +		rpc_delay(task, 2 * HZ);
>>>>>> +		return 0;
>>>>>> +	default:
>>>>>> +		return 1;
>>>>>> +	}
>>>>>> +}
>>>>>> +
>>>>>> +static void
>>>>>> +nfsd4_cb_recall_any_release(struct nfsd4_callback *cb)
>>>>>> +{
>>>>>> +	cb->cb_clp->cl_recall_any_busy = false;
>>>>>> +	atomic_dec(&cb->cb_clp->cl_rpc_users);
>>>>>> +}
>>>>> This series probably ought to be one big patch. The problem is that
>>>>> you're adding a bunch of code to do CB_RECALL_ANY, but there is no way
>>>>> to call it without patch #2.
>>>> The reason I separated these patches is that the 1st patch, adding support
>>>> CB_RECALL_ANY can be called for other purposes than just for delegation such
>>>> as to recall pnfs layouts, or when the max number of delegation is reached.
>>>> So that was why I did not combined this patches. However, I understand your
>>>> concern about not being able to test individual patch. So as Chuck suggested,
>>>> perhaps we can leave these as separate patches for easier review and when it's
>>>> finalized we can decide to combine them in to one big patch.  BTW, I plan to
>>>> add a third patch to this series to send CB_RECALL_ANY to clients when the
>>>> max number of delegations is reached.
>>>>
>>> I think we should get this bit sorted out first,
>> ok
>>
>>>    but that sounds
>>> reasonable eventually.
>>>
>>>>> That makes it hard to judge whether there could be races and locking
>>>>> issues around the handling of cb_recall_any_busy, in particular. From
>>>>> patch #2, it looks like cb_recall_any_busy is protected by the
>>>>> nn->client_lock, but I don't think ->release is called with that held.
>>>> I don't intended to use the nn->client_lock, I think the scope of this
>>>> lock is too big for what's needed to serialize access to struct nfsd4_callback.
>>>> As I mentioned in the cover email, since the cb_recall_any_busy is only
>>>> used by the deleg_reaper we do not need a lock to protect this flag.
>>>> But if there is another of consumer, other than deleg_reaper, of this
>>>> nfsd4_callback then we can add a simple spinlock for it.
>>>>
>>>> My question is do you think we need to add the spinlock now instead of
>>>> delaying it until there is real need?
>>>>
>>> I don't see the need for a dedicated spinlock here. You said above that
>>> there is only one of these per client, so you could use the
>>> client->cl_lock.
>>>
>>> But...I don't see the problem with doing just using the nn->client_lock
>>> here. It's not like we're likely to be calling this that often, and if
>>> we do then the contention for the nn->client_lock is probably the least
>>> of our worries.
>> If the contention on nn->client_lock is not a concern then I just
>> leave the patch to use the nn->client_lock as it current does.
>>
> Except you aren't taking the client_lock in ->release. That's what needs
> to be added if you want to keep this boolean.

ok, will do, see below.

>
>>> Honestly, do we need this boolean at all? The only place it's checked is
>>> in deleg_reaper. Why not just try to submit the work and if it's already
>>> queued, let it fail?
>> There is nothing in the existing code to prevent the nfs4_callback from
>> being used again before the current CB_RECALL_ANY request completes. This
>> resulted in se_cb_seq_nr becomes out of sync with the client and server
>> starts getting NFS4ERR_SEQ_MISORDERED then eventually NFS4ERR_BADSESSION
>> from the client.
>>
>> nfsd4_recall_file_layout has similar usage of nfs4_callback and it uses
>> the ls_lock to make sure the current request is done before allowing new
>> one to proceed.
>>
> That's a little different. The ls_lock protects ls_recalled, which is
> set when a recall is issued. We only want to issue a recall for a
> delegation once and that's what ensures that it's only issued once.
>
> CB_RECALL_ANY could be called more than once per client. We don't need
> to ensure "exactly once" semantics there. All of the callbacks are run
> out of workqueues.
>
> If a workqueue job is already scheduled then queue_work will return
> false when called. Could you just do away with this boolean and rely on
> the return code from queue_work to ensure that it doesn't get scheduled
> too often?

I think once a job is executed by nfsd4_run_cb_work and while the server
has not replied yet, nfsd4_queue_cb can be called successfully with the
same 'cb_work' resulting in this request being sent with the same se_cb_seq_nr
as in the previous request (se_cb_seq_nr is incremented when the reply is
received). This causes the client to return NFS4ERR_RETRY_UNCACHED_REP to
the second request which is OK.

However, in my stress testing, eventually the client starts replying with
NFS4ERR_SEQ_MISORDERED. I think the reason for the NFS4ERR_SEQ_MISORDERED
errors is because the 'se_cb_seq_nr' on the server is out of sync.

>
>>>>> Also, cl_rpc_users is a refcount (though we don't necessarily free the
>>>>> object when it goes to zero). I think you need to call
>>>>> put_client_renew_locked here instead of just decrementing the counter.
>>>> Since put_client_renew_locked() also renews the client lease, I don't
>>>> think it's right nfsd4_cb_recall_any_release to renew the lease because
>>>> because this is a callback so the client is not actually sending any
>>>> request that causes the lease to renewed, and nfsd4_cb_recall_any_release
>>>> is also alled even if the client is completely dead and did not reply, or
>>>> reply with some errors.
>>>>
>>> What happens when this atomic_inc makes the cl_rpc_count go to zero?
>> Do you mean atomic_dec of cl_rpc_users?
>>
> Yes, sorry.
>
>>> What actually triggers the cleanup activities in put_client_renew /
>>> put_client_renew_locked in that situation?
>> maybe I'm missing something, but I don't see any client cleanup
>> in put_client_renew/put_client_renew_locked other than renewing
>> the lease?
>>
>>
>          if (!is_client_expired(clp))
>                  renew_client_locked(clp);
>          else
>                  wake_up_all(&expiry_wq);
>
>
> ...unless the client has already expired, in which case you need to wake
> up the waitqueue. My guess is that if the atomic_dec you're calling here
> goes to zero then any tasks on the expiry_wq will hang indefinitely.

I see, I will make the change to call put_client_renew to decrement
cl_rpc_users.

Thanks,
-Dai

>
>>>>>> +
>>>>>> +static const struct nfsd4_callback_ops nfsd4_cb_recall_any_ops = {
>>>>>> +	.done		= nfsd4_cb_recall_any_done,
>>>>>> +	.release	= nfsd4_cb_recall_any_release,
>>>>>> +};
>>>>>> +
>>>>>>     static struct nfs4_client *create_client(struct xdr_netobj name,
>>>>>>     		struct svc_rqst *rqstp, nfs4_verifier *verf)
>>>>>>     {
>>>>>> @@ -2891,6 +2916,8 @@ static struct nfs4_client *create_client(struct xdr_netobj name,
>>>>>>     		free_client(clp);
>>>>>>     		return NULL;
>>>>>>     	}
>>>>>> +	nfsd4_init_cb(&clp->cl_recall_any, clp, &nfsd4_cb_recall_any_ops,
>>>>>> +			NFSPROC4_CLNT_CB_RECALL_ANY);
>>>>>>     	return clp;
>>>>>>     }
>>>>>>     
>>>>>> diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
>>>>>> index e2daef3cc003..49ca06169642 100644
>>>>>> --- a/fs/nfsd/state.h
>>>>>> +++ b/fs/nfsd/state.h
>>>>>> @@ -411,6 +411,10 @@ struct nfs4_client {
>>>>>>     
>>>>>>     	unsigned int		cl_state;
>>>>>>     	atomic_t		cl_delegs_in_recall;
>>>>>> +
>>>>>> +	bool			cl_recall_any_busy;
>>>>>> +	uint32_t		cl_recall_any_bm;
>>>>>> +	struct nfsd4_callback	cl_recall_any;
>>>>>>     };
>>>>>>     
>>>>>>     /* struct nfs4_client_reset
>>>>>> @@ -639,8 +643,12 @@ enum nfsd4_cb_op {
>>>>>>     	NFSPROC4_CLNT_CB_OFFLOAD,
>>>>>>     	NFSPROC4_CLNT_CB_SEQUENCE,
>>>>>>     	NFSPROC4_CLNT_CB_NOTIFY_LOCK,
>>>>>> +	NFSPROC4_CLNT_CB_RECALL_ANY,
>>>>>>     };
>>>>>>     
>>>>>> +#define RCA4_TYPE_MASK_RDATA_DLG	0
>>>>>> +#define RCA4_TYPE_MASK_WDATA_DLG	1
>>>>>> +
>>>>>>     /* Returns true iff a is later than b: */
>>>>>>     static inline bool nfsd4_stateid_generation_after(stateid_t *a, stateid_t *b)
>>>>>>     {
>>>>>> diff --git a/fs/nfsd/xdr4cb.h b/fs/nfsd/xdr4cb.h
>>>>>> index 547cf07cf4e0..0d39af1b00a0 100644
>>>>>> --- a/fs/nfsd/xdr4cb.h
>>>>>> +++ b/fs/nfsd/xdr4cb.h
>>>>>> @@ -48,3 +48,9 @@
>>>>>>     #define NFS4_dec_cb_offload_sz		(cb_compound_dec_hdr_sz  +      \
>>>>>>     					cb_sequence_dec_sz +            \
>>>>>>     					op_dec_sz)
>>>>>> +#define NFS4_enc_cb_recall_any_sz	(cb_compound_enc_hdr_sz +       \
>>>>>> +					cb_sequence_enc_sz +            \
>>>>>> +					1 + 1 + 1)
>>>>>> +#define NFS4_dec_cb_recall_any_sz	(cb_compound_dec_hdr_sz  +      \
>>>>>> +					cb_sequence_dec_sz +            \
>>>>>> +					op_dec_sz)
