Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8C6C72E41A
	for <lists+linux-nfs@lfdr.de>; Tue, 13 Jun 2023 15:29:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242107AbjFMN3K (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 13 Jun 2023 09:29:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242022AbjFMN3J (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 13 Jun 2023 09:29:09 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2076.outbound.protection.outlook.com [40.107.95.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 505151B2
        for <linux-nfs@vger.kernel.org>; Tue, 13 Jun 2023 06:29:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fzttr+06gJ36iqw4tLSCsImTRxdwSAmdX6k+YRu9FxZ0TuG1EzHPUDet+8P+3dcugAvYE/R1DQH/o58+EtKlvEgl/5FfoLpl7GoAJ9cufBRFCoy6VBbt8TPuB2HfoPIgPAc+N96R+6n5U6n3AGacgkRCTyhGSYXvRWKM1kR+UGlMD7Sy44BMo/61GZRZEj81XLW0UPdWEwZO1vnILe6l40bu5Xd3hFx4htt0TMd9TtRH/QPljjboaZfdnMz/Ue9xc3L8ptLVmP3V7o3tsuoyhx8FttrxctmgeaY1F/RXJMrFDYYJIqh47hSUuQnddMH1G47XDPX9AKivGKTUQWdOsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kLWmY5YxpJqdatWk7yxQKLiHfAdfNsOY/MyFmbjHFy4=;
 b=ha05bCcN7p7z8Mh1PpiL6oOrtxinxP8hdcmeWhkhKk+aKW109Zlo58zM0purGuUi2Rhf3Mnfzg/xe3tB53AUuSBPOJHOHXZron/YWq3OGjokRtKqIDx4H4uOLSMYLz/aJTfBANPaovUlb1x0Y7JdjlbK4cu+4qviDIwh0z5vQhUSsHspmq2VGe5sjQ9tj20OthwtiL/If2tPOMZBkagI9zRvifT+N1X5MQLGUa54UZZfyLmOm1yyFLz0l4h3winWhOqx0WLOsCsa/XrQWbCNoAIoPuc2ozHVAS3MH0NxTEWuZhelxUYvE4UZgGqQ6WzWB5ZQako0NRuiig5Pyb29fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=talpey.com; dmarc=pass action=none header.from=talpey.com;
 dkim=pass header.d=talpey.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=talpey.com;
Received: from SN6PR01MB4445.prod.exchangelabs.com (2603:10b6:805:e2::33) by
 SA3PR01MB8545.prod.exchangelabs.com (2603:10b6:806:39d::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6455.33; Tue, 13 Jun 2023 13:29:06 +0000
Received: from SN6PR01MB4445.prod.exchangelabs.com
 ([fe80::17e9:7e30:6603:23bc]) by SN6PR01MB4445.prod.exchangelabs.com
 ([fe80::17e9:7e30:6603:23bc%5]) with mapi id 15.20.6455.039; Tue, 13 Jun 2023
 13:29:06 +0000
Message-ID: <1a7ba06a-3b53-777f-dc2b-73c8797d2fd8@talpey.com>
Date:   Tue, 13 Jun 2023 09:29:04 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v1 0/7] Several minor NFSD clean-ups
Content-Language: en-US
To:     Jeff Layton <jlayton@kernel.org>, Chuck Lever <cel@kernel.org>,
        linux-nfs@vger.kernel.org
Cc:     Chuck Lever <chuck.lever@oracle.com>
References: <168657912781.5674.12501431304770900992.stgit@manet.1015granger.net>
 <0946f8f0d8d1901ade3396b84931110d6dea5785.camel@kernel.org>
From:   Tom Talpey <tom@talpey.com>
In-Reply-To: <0946f8f0d8d1901ade3396b84931110d6dea5785.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR12CA0006.namprd12.prod.outlook.com
 (2603:10b6:208:a8::19) To SN6PR01MB4445.prod.exchangelabs.com
 (2603:10b6:805:e2::33)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR01MB4445:EE_|SA3PR01MB8545:EE_
X-MS-Office365-Filtering-Correlation-Id: 325daf4f-a32b-4a9c-c12d-08db6c12288c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Hstv0tjUIjTRaRJkSvrVYUYWWjncBVJf2clutlUOuD4/YFUsDTOq99P5yFqt9vLRX0qjb0hK/OoOnvzGOJpeBzY2XTu7cXrcNgG9WpIZOiD+Tb+LUl8JbcgviZY+oryShI4/QvUVfVK2QxGS6y3i/mxrSQhqVGjwMVoG/5NMSCMnkrjTjDLXJr0aRFxYdv7hFc9n2Qq1rf2cqDV+hcGITq8C4hP4A3w3FJvIh2yMocgvtHegoTPf7LyYt+osdZTkKZ2GkzRUJ8xWJmbsbHEhMNEclTw+MjcTk4rBSZUHxyEsyJXKt7+QS1L2HS6CYcg8g27C4jtNndyI3ZYrseCjRIK+ss1SlmHsLjD57NZayAv/OAllqjLI640EDvlO1LwF5Uzge2ix/UgGXiW5zgzkmvm3Ym+zWyQf3ZUBpn7WoDxh13U+YsvkSEeYuOV07w16HD0cQedcnnji92ImxbhohlV9wwlOAYTI5GLq5yXbLrHxKFNRPrp/wYlxRU/1J2pU8F/B8vL/9GD7YMKTVR3rINso+pD/UA6aXiij9fZL4JfCKeuYCWo7JsFJM4F45LqaNdhqzzLdxAo+MTA7PUyPW+FEDEOdC30SlZ37UhD97e127y5KFz3npfiG/8rR1RaeTVkcbDyBL7ZAG/ny3Bm52w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR01MB4445.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(346002)(39840400004)(366004)(136003)(396003)(451199021)(66556008)(66476007)(83380400001)(66946007)(478600001)(6486002)(53546011)(26005)(52116002)(6506007)(6512007)(2616005)(5660300002)(186003)(110136005)(2906002)(31696002)(8676002)(86362001)(8936002)(4326008)(38350700002)(41300700001)(38100700002)(36756003)(316002)(31686004)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eE1rd0g5aEJjb0FNb0NJNStLc1YxeHF4aGdLOGovZ0Ztc0NUd2x5U1BoaHE5?=
 =?utf-8?B?UGNNbmJQN1FWZ29yUUwvb0lPTC9rdjJsdC9maW9PdmNPS1FVeTFKT2Y1c05W?=
 =?utf-8?B?UVRDZmNvOW9XalptUlQ4NjVlbWNXZHlsTGlaekxzQWh3ZVhDVlRXQko2S0kv?=
 =?utf-8?B?cnp5dFNRQ2VIb0lEMlBtNE84QjQ1MFMzbVdvR21JSnFHUjFwOGUvL1NYN2pi?=
 =?utf-8?B?bENwVDdvZ3JQVFFFdlg1TmRWeFVadThXdDV0akljTFZLUXJ1NmdTVjdZV2Rn?=
 =?utf-8?B?bEVzS2pyang1SExZT1YvY2FqdXRsY0dKSWR3bndnb3B4UkRuM0lKYVZReUtr?=
 =?utf-8?B?SHBSSW5SKzEzcS9yQlg0MzhtcFl3UjFSWlQvdVY3bDJPeE8vbkkvSEI2d3M4?=
 =?utf-8?B?Y1dqL0R4KzQ4TEw3SVNES1dBcWthelZoRmtwQ25rSDZqaUEyM21FSStPZmoy?=
 =?utf-8?B?d3E5MmxjKzJzQS9PTlRkaHBCRkZQOHBOcnpra1QxMWJnTVl5SmVtaXAyZzVp?=
 =?utf-8?B?dmt0SVdjckxLSDl5NmZ2VjZxWkoxQVlpOXgyT0c4LzdLU2lCWTZ3VHZWNnJa?=
 =?utf-8?B?ZHA2Q01leFFwZlJxZ3hDd0o3S0lHb3R1ckNDOVF3THVrRzlZVmtkQm5jWllR?=
 =?utf-8?B?UW9LTmFTYlc5M0x0bEZrcXRjUjdPY0FPTWZOWjkyNzE5ak1vQXJRZDhqOUZT?=
 =?utf-8?B?cFJET0tmZHhYWEo5Kzl0cERsWkhpWGFLdzVDSFB0YUtnR3ZrcXVIbXc4SWdN?=
 =?utf-8?B?VnhEZWsveUhRWXg5WHdFOHF2ZDBiUUpZaDJOZ0FDc04rNXZnb3dvWTRMa1Z0?=
 =?utf-8?B?NnhZWjRkd2pXZ2JqenY5cmN0YXF3R2pOenJHNHNwMU1XRXE2ckVqVTI3eHdJ?=
 =?utf-8?B?djF6QjBRYVBxa3hKc081U09IMkRuMjRVSmR6UWJxWE9ONDZzZEZ0U3pPd0tz?=
 =?utf-8?B?Y29iN1QwTHNGUzFpOEd6NnF2TjZHblRJUEhBYXh1ZzBVdVE3V1RJYmFtNzdD?=
 =?utf-8?B?M0NrZk43QzRsWG9WTHNmLzY4UFN4YW5TcytqS0t1d0ZnamxSYXd0RWFqY1Nt?=
 =?utf-8?B?K1JxUW5lcXR0a05tRDkwa2Z1aGdFc3IxU3VXRysxWUpJOTc0b2FwQ2VNUEtl?=
 =?utf-8?B?d3h3SCtocVRFZjdyNGY4UHVyeGRvY3BnczROWVE2SFZwU2RMbkF0VXpoaDYx?=
 =?utf-8?B?OEpVa1I4K3lFWDNVUHZ2UVRNWjNuRHlMRXRxTkJOOTBvcEpScGp5QTN5akhm?=
 =?utf-8?B?ZlNERmJndCs4UkZ3eW5zZVFIZHZ5V29ZOFU4NnFvNi9wVEhIT081N3FaK0ho?=
 =?utf-8?B?UXYzbThLRFRpb1c5SlpSSDdxVnZIOFpPYzkva1JCengwdE9sdTYvMEV0TUNn?=
 =?utf-8?B?S3FyWVRaa3FCSEZrc2hDdmpESzc1dWF3VTE2RnlTNG5IU2tTdFVaeXlPakFJ?=
 =?utf-8?B?YzJBcmpNbzNZMk1WRitpNW42ZitVRmNpWGZIRHpJWk45NjdudWV0OWE3RDRE?=
 =?utf-8?B?bDMyUHoyQkZEMlh4eUhDWit4aWE4MGpaV3lsb0lEWUJqV3N1MDNqQ3dLQ09w?=
 =?utf-8?B?RUtLOUh2Yk9ZZXA3YlhVME9wcjdHYXVkcGFzQ0tidkhybVkxbktGRmdSTlRF?=
 =?utf-8?B?WUdjK0dPVmZ6NHlBWnN0ZVRTZlNGdjVDOUFpVmluQnlpS0lwM3Q1Vlo3RjRJ?=
 =?utf-8?B?bkRsazhOcGVRd2lrV1BtTVdUTTR3TEJBdUloRTFmWFpUeGpiVVA5czFRK2dm?=
 =?utf-8?B?dThzUHJiRU53dTlFamtGeE1JcExIMEg0MzFTbStoV2VjVlgvRFZpV01pc1Rn?=
 =?utf-8?B?WWllYW9MUm5sYXRUZEhQYzlPMXZMM3ljMklxd3NQL0liMFdzMDBxNlNwWFFP?=
 =?utf-8?B?YnZZV05XQkFLcER4VEErN2VCYXBJTEZ6amN2SE9xZm84OUErNE1GOCtDdnZo?=
 =?utf-8?B?bEJ0OU5OaVhybElxZGFWaTJENmw4VTdJdlN5TnNiQkhWTElKQUoyd3BYQ24w?=
 =?utf-8?B?aVRlNTAxc3VOaGplNUFEalVuN3V1TndUUmlPU2FtK0I5V1ErallyakljZkVT?=
 =?utf-8?B?aWk4VW9TRXhrNlVwTnlaRlRtcW85WHNiN0ZsUXZpOGIvNlJ5SmxEZlIvOXM5?=
 =?utf-8?Q?0DIfe6/mQvSSZt7PC1a73E4IJ?=
X-OriginatorOrg: talpey.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 325daf4f-a32b-4a9c-c12d-08db6c12288c
X-MS-Exchange-CrossTenant-AuthSource: SN6PR01MB4445.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2023 13:29:06.0590
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2b2dcae7-2555-4add-bc80-48756da031d5
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MAfhGmgIa34geFIQ129rRgThgqSVUhAS2kviqYhyb6D7LJQSUWpGSvpYIwSSuMY8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR01MB8545
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 6/12/2023 10:27 AM, Jeff Layton wrote:
> On Mon, 2023-06-12 at 10:13 -0400, Chuck Lever wrote:
>> These are not strongly related to each other, but there was a whole
>> collection such that I didn't feel like posting each individually.
>>
>> ---
>>
>> Chuck Lever (7):
>>        SUNRPC: Move initialization of rq_stime
>>        NFSD: Add an nfsd4_encode_nfstime4() helper
>>        svcrdma: Convert "might sleep" comment into a code annotation
>>        svcrdma: trace cc_release calls
>>        svcrdma: Remove an unused argument from __svc_rdma_put_rw_ctxt()
>>        SUNRPC: Fix comments for transport class registration
>>        SUNRPC: Remove transport class dprintk call sites
>>
>>
>>   fs/nfsd/nfs4xdr.c                     | 46 +++++++++++++++------------
>>   include/trace/events/rpcrdma.h        |  8 +++++
>>   net/sunrpc/svc_xprt.c                 | 18 ++++++++---
>>   net/sunrpc/xprtrdma/svc_rdma_rw.c     | 14 ++++----
>>   net/sunrpc/xprtrdma/svc_rdma_sendto.c |  2 ++
>>   5 files changed, 58 insertions(+), 30 deletions(-)
>>
>> --
>> Chuck Lever
>>
> 
> This all looks good to me:
> 
> Reviewed-by: Jeff Layton <jlayton@kernel.org>
> 

Ditto.

Acked-by: Tom Talpey <tom@talpey.com>
