Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40CAC72A548
	for <lists+linux-nfs@lfdr.de>; Fri,  9 Jun 2023 23:21:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231916AbjFIVVf (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 9 Jun 2023 17:21:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231634AbjFIVVe (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 9 Jun 2023 17:21:34 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2082.outbound.protection.outlook.com [40.107.96.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 245F335A7;
        Fri,  9 Jun 2023 14:21:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E6sra3cOmcCbp5hF0zEXH9D/lz1EReD8MrbG+jdxjb/8xjmnKtW99/Z6+1XszLbOy22SQ4KrOP1lURLkx8ODoIk5sge7b/R/xVtSV0GCVDu/gjL7TVzW48yLmSoRx9DIgyQnJm2aRuZnknZPGzOuFSxqZ95rohlk0vKkribLpgPnBgA9RB+s99jahpKDHkja+LDeXRCxVNG0+8CZCBeCrQp7XeDHMlCbN3fOl8T+WaRqluxuXC24dfKyuOvkyK18jnmfyBH2Sb9wp/dY7maOFJwPy9Z3/9V2optr4GXdlMNnkfPeyErzHHOaNVGL5NDEX0vUKusQ8F0/71+anao18Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GA0+Mfrvoxpk1B3pjy44xesQl6U/M6+CgoDYL5+e3Lc=;
 b=Ygm48w5jgO5+3DziSxqTHXcbSGQnBCCdLNRuAVWHDhxgok+Jpzcj0r7U+Nj5i46xcoLhWdU++JyZvmQUZwVGRwWRsp0cgKj3QZuuPQgTGPxPhgzM6o2g3Qb7HwDiwMbwtyoibgQAu7kBKP52KIAHRbfCci6coeA2gswFVDp35fRc4q0Fz8ovISA1GSqg0Ka3qg+fKl4l+o5w706yAgbhSkliAG6h5tKViVkjAG1R4g+iRTJt/d3yaT1wEKa+ELveEXE57Kz/HXaRCWMISeizCZggYr8vp8XtRC6f3+RcUrJmhde7TmLZHwRT6u/zSfVN9H/H7LT3k8sBtdicNSgFWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=talpey.com; dmarc=pass action=none header.from=talpey.com;
 dkim=pass header.d=talpey.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=talpey.com;
Received: from SN6PR01MB4445.prod.exchangelabs.com (2603:10b6:805:e2::33) by
 IA0PR01MB8586.prod.exchangelabs.com (2603:10b6:208:489::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6477.19; Fri, 9 Jun 2023 21:21:29 +0000
Received: from SN6PR01MB4445.prod.exchangelabs.com
 ([fe80::17e9:7e30:6603:23bc]) by SN6PR01MB4445.prod.exchangelabs.com
 ([fe80::17e9:7e30:6603:23bc%5]) with mapi id 15.20.6455.039; Fri, 9 Jun 2023
 21:21:29 +0000
Message-ID: <4ef23425-f624-2bd4-4720-c17f898660b9@talpey.com>
Date:   Fri, 9 Jun 2023 17:21:28 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v1 4/4] SUNRPC: Optimize page release in svc_rdma_sendto()
Content-Language: en-US
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Chuck Lever <cel@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
References: <168607259937.2076.15447551371235387735.stgit@manet.1015granger.net>
 <168607282316.2076.15999420482159168604.stgit@manet.1015granger.net>
 <7ae922eb-511b-f5af-04fe-f68cd5b19237@talpey.com>
 <17F60F35-FA54-459B-BE48-07522D951675@oracle.com>
From:   Tom Talpey <tom@talpey.com>
In-Reply-To: <17F60F35-FA54-459B-BE48-07522D951675@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0166.namprd13.prod.outlook.com
 (2603:10b6:208:2bd::21) To SN6PR01MB4445.prod.exchangelabs.com
 (2603:10b6:805:e2::33)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR01MB4445:EE_|IA0PR01MB8586:EE_
X-MS-Office365-Filtering-Correlation-Id: 9eb6dcde-170f-46c6-d020-08db692f7db3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bDhb0TGH/x2Eg7KdT3MPRmJf+JjMgVAkV323TkiD5ahrg0Yg4SyLJOKmbttUYlyzmZJ/By276lynw5Kvf0rdsIICzQsH59iSsc2hkpqaj/yQyE0L3WnluPfW2te3Yg4Thoi1O+oTjp3XS4vWznCFxT5kLZhvFvke0pkSN8soUIaGiiD8PSIwniqXMw5ODv7vdmGnycI3X5+xW/CDTwid8jUpbX20hkGWQ/8hUy6PbLjP9Jl2A8SGNFwlg8KdW2KHW8/JlFlQgg/5zxu05GSw1j5qCMHtwYeuztFn8iGxE3MlvpjpwVvE6EX2S6nqv0AI5Yj7/FGHlwANmMWnWVDug1dqGo2xe5BLsV6fAxuTs/5/viNvo+kVsGPvo6OecyNNneoyopILwj3m7uyQTWq/dBvGXkoSHBjHK7FbZwtrEAXdDSpV7f5iWmgremi5MaAhMrXVMrlP3YmHvduPUqZBlQOtBFFrG0T7KM4Lpr1fvjrGT/keiODCaSGTFWF3W39L/mgBq+oJXmxkI0E4+WmtUcI/Zpro8LNt3EeuNfzIiuTzySo4tl1IFAvxlD1mnCBLcG/JSdoOqySzSSEKqowsFs2wiQtKlNBbb6QerSLAyODf8EeKESye7yx66pxcMlM2FZ550R0uvHt/I4XUSq/O1A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR01MB4445.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(136003)(376002)(346002)(39840400004)(396003)(451199021)(186003)(36756003)(2906002)(86362001)(83380400001)(66476007)(66946007)(6916009)(66556008)(4326008)(2616005)(31696002)(6512007)(26005)(6506007)(53546011)(31686004)(8936002)(8676002)(5660300002)(41300700001)(38350700002)(6486002)(38100700002)(316002)(52116002)(478600001)(54906003)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QUluV05JSisxMnZneDl4VTBObU16elJockZmNUxEUjdvbDQ3bXliOWpLNUJF?=
 =?utf-8?B?S0V3UXZSU21JU2haNDB6QzZwQTZyRDhzWUUrUTRuN3NEaXZScXdSTGhJNmlk?=
 =?utf-8?B?NThVZXFDTWlMR2JSbjA2MXJNODJRYjNQcVFtTjIxM3RsTFlQZ1N2U3duRkhl?=
 =?utf-8?B?SFNNMGFnVDlBeXRENjVlRGV6aUlyWVFWZGZPblhLYXQ0QlhOZUZpY3RrUkk1?=
 =?utf-8?B?OVNnclBWTldCSGdERlFlOTNrVmtHbFhrU0ZnTFJaQXZVWkNmVHRPUy9GRk81?=
 =?utf-8?B?TFdwYlFLQ2k0M1B0dzFVd3lSQlh2aGhPcDRWZFFRcU50elRNTCtXd1M5dnJY?=
 =?utf-8?B?d1Y0Y1d3ZTR2ZXcrL05UbFl3OFBqM0FHT3FlYUplb1NoNER6cXRjc090cTIr?=
 =?utf-8?B?MGJQSDZ3bVZzTGlPVUdpY3pyN1ViYkhOYXlHd3B6S2hzUTNFMnlpdnFBaTk4?=
 =?utf-8?B?RUVHYXNjS2ppT0IyRGcwaXRyWmFmT0s1UE05MVlMR1NLbGpURHAxbXlLZTdn?=
 =?utf-8?B?TWQyTjlXbWVRbllibzBCYjJjSitJVE0vY1FIeXNNN21HQ3hxdzRnVHBLUll4?=
 =?utf-8?B?TFQwOU1SbGdxaDlxYTkwUEhXVUc5cVJNd2ZSY01wMnpDRlJYOU1CMDNPeEw5?=
 =?utf-8?B?MXF6NjdDbTNsenRKbER1bjFUVmtmMVBBaUJ4WXJ6MW1oR3ZrRXpnK0tncFVY?=
 =?utf-8?B?OElUekVpQWtFUEp2VE91dk1mMm9PdTRldThLSW5PalJXYkpDU1A1OFFwL1Ix?=
 =?utf-8?B?SnNYL1kvQXZueCtHSjVoWllJNElCUXdOZGNoTHduUW9ITEtpM0FPbU5mMmFl?=
 =?utf-8?B?bFczZnJxRSszS2tVQmxHQy92T0d6dm9rc0ZDQVIycis5N1NTR1E0MDI3YWx1?=
 =?utf-8?B?aDNSK1gwMVhUdDhuUjFZSGIzNG53K1FPTEZaaWlKN3lmak8rU3lMSjlEdHRx?=
 =?utf-8?B?eWo0dndPRzRaem5WM3hMU0svRXB0NVRWVWlMdHlyOGNzTy92VjRPMjZmamFK?=
 =?utf-8?B?ZDJoZU45VVI5WkV6dEhqcUhWU3dWUXZhcGZ6dVdFVWl1cmlSSklaN3pXT3lC?=
 =?utf-8?B?Q2ZCdTFSTGRyRDhXQlpKUHRPeU5JYjV1YXRReU4rdHBPSTB3L2Q0VXJ4bzhE?=
 =?utf-8?B?dE1zN0M2UVdCR3JlZHhNem5ZdUFFU2JwUWU1QTBGNlhKOEJhWHNMK1hFaytJ?=
 =?utf-8?B?TU9Xd0tLUURhc3E4bG1rS2dhdytoeElXbldFT0ZLY3R5N3Bocm9JM2hTNzdm?=
 =?utf-8?B?cTVJQ3hlZ2NzNkxpT1hvM1hwZGJ4Rzl5aWNVTnVSYjNWbStxOHhXeE4rZUJn?=
 =?utf-8?B?MUFJMWlJaVpZajNRT3VZR0lzKzllbWM4SmJjaTJuVWYvMFdna0t3NDFPNCtM?=
 =?utf-8?B?ZmdBdktoNGpPcGlVM2IzN3lic044ck1jM2xuMFJSNVQxeTcrNGVEVjJqNVdz?=
 =?utf-8?B?OGJlMnNhR1BIQjhDcklDaFkyazRMRWFlaVVmQ1VpMTB4MXNBNXNvL1l4NVVv?=
 =?utf-8?B?dlh0QlMvZHFSRyszRDlFc1hiU2t2ZUo0ODJRbkZiYjBZRzFZSGlPVHNpQ1Fn?=
 =?utf-8?B?cW9ZRUxDTDIrdWJYaEoyamJ0NlVBbmFuU1p1MVVmMnlaL1J1YVRydHB2SDJY?=
 =?utf-8?B?ODdyay9MRjUrcldLR2pVbDBFM3lkdndVcUtaaldBb0xybkxmejFZYUN0cmk3?=
 =?utf-8?B?bGliNCtjZmIxbEpHWUZRQVZBOEJlcjVrN29XOFc2aEVhdzRkWXRvYkRxN1c1?=
 =?utf-8?B?eTZGZi9qQVFtNEd5QklIWWk0ZEd4MERxNkRTdnFZQ0tIZ2xRWVZBdGxqa0Vk?=
 =?utf-8?B?ZFBYa3c2QldxSG1ydVBIVk5weFVjbGdTdWJRcTE2cmU3YlBVR0EyYnp2Yitz?=
 =?utf-8?B?RFhmQlNNNVpyV2JiSHMwcXlXNXBPdTdVY1BmQk9pQUduend2bkJ1Z05CeUo4?=
 =?utf-8?B?V1E4SFB2ZHo4RUhDWnFQYmdIVVhjY2pXUU8wM3pjMXErbDJNR2RYT3JwN0xM?=
 =?utf-8?B?SE45eTQ2TnJwL2lCbTNQV1lqVnJVVWtOK3FwdDJnYk1jSUdBNUQ5YnEvdVZX?=
 =?utf-8?B?K0lrMkw5TmhTVVEwZFN4N1ZkV1dDVTFpZFJvejM0ZkxaZElBb1JDemowUmNh?=
 =?utf-8?Q?kmOx/t8Y25/E7D4Et8NgU7Um0?=
X-OriginatorOrg: talpey.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9eb6dcde-170f-46c6-d020-08db692f7db3
X-MS-Exchange-CrossTenant-AuthSource: SN6PR01MB4445.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2023 21:21:29.8258
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2b2dcae7-2555-4add-bc80-48756da031d5
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JEUI4TBCGfIMlFBrwhIi4J594X7/9SL8OBqWErcc6AiKk+eFBr654YwPVEJB55BQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR01MB8586
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 6/9/2023 4:49 PM, Chuck Lever III wrote:
> 
> 
>> On Jun 9, 2023, at 4:31 PM, Tom Talpey <tom@talpey.com> wrote:
>>
>> On 6/6/2023 1:33 PM, Chuck Lever wrote:
>>> From: Chuck Lever <chuck.lever@oracle.com>
>>> Now that we have bulk page allocation and release APIs, it's more
>>> efficient to use those than it is for nfsd threads to wait for send
>>> completions. Previous patches have eliminated the calls to
>>> wait_for_completion() and complete(), in order to avoid scheduler
>>> overhead.
>>
>> Makes sense to me. Have you considered changing the send cq arming
>> to avoid completion notifications and simply poll them from the cq
>> at future convenient/efficient times?
> 
> That doesn't work for Read completions: those need to wake a new
> nfsd as soon as they complete.
> 
> Send and Write completion don't need timely handling unless the
> SQ is out of SQEs. It would be nice to move that processing out
> of the CQ handler.

Yes of course. That's my point, the receive cq and send cq have
very different requirements, and even more with this change.

> Otherwise, no, I haven't considered leaving the Send CQ disarmed.
> I assumed that, at least on mlx5 hardware, there is some interrupt
> mitigation that helps in this regard.

You definitely do not want interrupt mitigation, it will kill IOPS.
Say the hardware pauses 10us before delivering an interrupt, in case
another comes in shortly after. Ok, in a single-threaded workload
you now have a max 100K IOPS throughput.

Interrupt management needs to be done from the upper layer. Which is
what cq arming is all about.

Food for thought.

Tom.

>> Reviewed-by: Tom Talpey <tom@talpey.com>
>>
>> Tom.
>>
>>> Now release pages-under-I/O in the send completion handler using
>>> the efficient bulk release API.
>>> I've measured a 7% reduction in cumulative CPU utilization in
>>> svc_rdma_sendto(), svc_rdma_wc_send(), and svc_xprt_release(). In
>>> particular, using release_pages() instead of complete() cuts the
>>> time per svc_rdma_wc_send() call by two-thirds. This helps improve
>>> scalability because svc_rdma_wc_send() is single-threaded per
>>> connection.
>>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>>> ---
>>>   net/sunrpc/xprtrdma/svc_rdma_sendto.c |    4 ++--
>>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>> diff --git a/net/sunrpc/xprtrdma/svc_rdma_sendto.c b/net/sunrpc/xprtrdma/svc_rdma_sendto.c
>>> index 1ae4236d04a3..24228f3611e8 100644
>>> --- a/net/sunrpc/xprtrdma/svc_rdma_sendto.c
>>> +++ b/net/sunrpc/xprtrdma/svc_rdma_sendto.c
>>> @@ -236,8 +236,8 @@ void svc_rdma_send_ctxt_put(struct svcxprt_rdma *rdma,
>>>    struct ib_device *device = rdma->sc_cm_id->device;
>>>    unsigned int i;
>>>   - for (i = 0; i < ctxt->sc_page_count; ++i)
>>> - put_page(ctxt->sc_pages[i]);
>>> + if (ctxt->sc_page_count)
>>> + release_pages(ctxt->sc_pages, ctxt->sc_page_count);
>>>      /* The first SGE contains the transport header, which
>>>    * remains mapped until @ctxt is destroyed.
> 
> --
> Chuck Lever
> 
> 
> 
