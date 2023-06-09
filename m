Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E84972A4D0
	for <lists+linux-nfs@lfdr.de>; Fri,  9 Jun 2023 22:40:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229956AbjFIUkf (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 9 Jun 2023 16:40:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjFIUke (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 9 Jun 2023 16:40:34 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2053.outbound.protection.outlook.com [40.107.243.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC7FA2D74;
        Fri,  9 Jun 2023 13:40:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bA3Z7l04WlpuyuqEkMITnfZEyjYEMBly/ajv34bEBEnU4EcMEXI6SoDMiVRgHYf5Z0iG1nsY6Wl47Xy2Uv/Xh0yzBHsKi3oCk02fzAoXfU9Kow0nWHdDulPq3g4v43LuY2VBs1XYUlia/Y1pzeUm4Nv8k6qkdqkD4HewdHy1dvLzMcN9IKy09Raa1fzz1KhUlARd9j4dUjW/wQLHDjfKC/YQsXIWVtrTjk+xrvumVaJbGYyuRNcHt0uUx1NEu2J+OA8uziPA9RaipjiTaoADan4fT9mdvWlupAMK5b6Z6Ox5H8F8889jvvlLms/SjbFKUJ+u416p4pFfXgwSlpyL2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uYR2nqm0Ic+I83cxZkupElMQLF7DJSqboB5XygW0Beg=;
 b=A7pa/AOW9z8Ya4n2WHCztNnbbeOWDs1VtEIUPeNglvF5BSsUVvSE4qoa10+PlxlBe+S83Y68UtMRavWKkV1IIvQ1WfhW6077HKOlj3McEky5PnYOKesu1EWEpHnFr6R+yabbXu4rOGPCmGLtS/yNbiCxu9QzScT33O2wuVjAn6xfmccjnC23xW4SqOnn7PC2knPW2zVpZt/hqvteOutejzXyvM2LCbERaT3tdpaLoNogqZdWC93ESvMV3qmmOvgWwht7CHuW/Xnf7aRFHbwP2zNuFCE1cM7FiyfCJT5HYvcoKL+xKabs4GbeqtrRY8JP12n0CnQZkUIGW+APi4z/bQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=talpey.com; dmarc=pass action=none header.from=talpey.com;
 dkim=pass header.d=talpey.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=talpey.com;
Received: from SN6PR01MB4445.prod.exchangelabs.com (2603:10b6:805:e2::33) by
 MW6PR01MB8599.prod.exchangelabs.com (2603:10b6:303:23e::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6455.33; Fri, 9 Jun 2023 20:40:28 +0000
Received: from SN6PR01MB4445.prod.exchangelabs.com
 ([fe80::17e9:7e30:6603:23bc]) by SN6PR01MB4445.prod.exchangelabs.com
 ([fe80::17e9:7e30:6603:23bc%5]) with mapi id 15.20.6455.039; Fri, 9 Jun 2023
 20:40:28 +0000
Message-ID: <3ed1ba55-0f59-0ab6-dc44-2d248a810f6c@talpey.com>
Date:   Fri, 9 Jun 2023 16:40:26 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v1 1/4] svcrdma: Allocate new transports on device's NUMA
 node
Content-Language: en-US
To:     Chuck Lever <cel@kernel.org>, linux-nfs@vger.kernel.org
Cc:     Chuck Lever <chuck.lever@oracle.com>, linux-rdma@vger.kernel.org
References: <168597050247.7694.8719658227499409307.stgit@manet.1015granger.net>
 <168597068439.7694.12044689834419157360.stgit@manet.1015granger.net>
From:   Tom Talpey <tom@talpey.com>
In-Reply-To: <168597068439.7694.12044689834419157360.stgit@manet.1015granger.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR01CA0023.prod.exchangelabs.com (2603:10b6:208:10c::36)
 To SN6PR01MB4445.prod.exchangelabs.com (2603:10b6:805:e2::33)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR01MB4445:EE_|MW6PR01MB8599:EE_
X-MS-Office365-Filtering-Correlation-Id: 57db6349-e603-46e9-cb6b-08db6929c285
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: J0Gs1GPaNT1+S2zlt4uO8mFse0IEmBIiu4kpm6fK+biRwHc9M6C0lSsRWPXgC/dBbykJy/Nv7f1m+6ZGJt+u3F2AVzVYCx3qeXPOpVrvEm3DVDjdbMD72ZVvsmF3S2A+OpQwNNXvgY7f9WgUoXXC8y8oZvwbwFsfjid89PBaWk891vFF19DRX2WNssXm7U9Op9m4Bu3DSOPWKXc+6FdH+R0ZvgixmCcuP6s9dT6sxA90ErcDSYrfnBDF1AjmBffRgSXNV5wjIJkUwZIdyl5ecRXK43zZ0FsoTirZwI4NfHHD17GMIAKAKyhM1X6mqic5/tkh3jHM+BbXoTMD9fmDER/mp0g2Fr2bLRsskARaSYzB/Y5+QxHHlHhLbt+PvVqLgIl3tM5zyLiJTVSAeFL4jnh+axdbBS1Fr21PpqGdQES3IWRr8xWArRFvX3Lf7jcZBDKfHfVW3VLj+q0mvZ9NPj8moL5ghx9zlMcB37Q1ehxpIg1FnCsWaC9pnMkK+AquP5ONxyWfI0E7LdbpW/4xbVkxCccNtVQ75pPCo0kxcRpUqrPLwpZ74BcMQIXslvxbtisXy7vTaR7fqpjiPo+P4DqMAGQ5WDSdiwZhV2BLCnM/llbrXDMIYT1/tC6yuGdGFyFrOW6vpluGANan0E0SiA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR01MB4445.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(346002)(39840400004)(396003)(376002)(366004)(451199021)(6486002)(52116002)(478600001)(186003)(31696002)(38100700002)(38350700002)(86362001)(2616005)(83380400001)(26005)(53546011)(6512007)(6506007)(36756003)(5660300002)(8936002)(8676002)(41300700001)(31686004)(2906002)(4326008)(316002)(66556008)(66476007)(66946007)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VlErTnVMeWFaWDJ2K0xkUnJWY2ZFUWZzSFIwcytLbzh4VlUzL2wydmlYNmgw?=
 =?utf-8?B?cUJnd1d0cytLb3F5ZHVQR2cwRktlbUNrTFdsU1l0Z3Y5Z0RJeHp5eEtTcUVw?=
 =?utf-8?B?QTB3cjMvZ1NUSUpKeCtFenMzakhCQ01wNGMzUHUzTUpnM3FmTTNHOVZhTUJm?=
 =?utf-8?B?MVQ0WHA3S2U0R3lua3phTzRyVWduNTdzWGxiL2ZtVXp1bVl1VEl1eTNKQUc3?=
 =?utf-8?B?NVppNU5MOS9yU0s2ekdSb2pzRzFGTzhUa25UdnJpYnZlckNrcXd5VUxCYVdw?=
 =?utf-8?B?WDFLdmFZaU1ONDhHaFVyTzJ3TjFSek9DVWkxREZhdEhPK1lqdmU5eDJqNFV0?=
 =?utf-8?B?SFBlTGUyYnpHMC85MWVXUUhNQUhDNGdBc1I4ajlRcFZUOUNlRWhTa2h6ZzN4?=
 =?utf-8?B?WnZHZlNuc0tTMU5yajYxdDYyN0x6ektqbnJ0ZCtGVHBSc3ZySlNOVlpQdWxw?=
 =?utf-8?B?L3VtcUJUUEplRURIWnExbFpWQS9SN0ZKYXZxRDNuN0VsTFVMV3ZvQVpZTjVm?=
 =?utf-8?B?UW43amY2OWs3a3J6NC82ZnAyWUpOUkxocnRKbHZ0S3VtOGt1a2hjRVhCc3hK?=
 =?utf-8?B?VzFmTmFZYmhXdlJJVEdSem5pQWtaRkovS3Q1Z0FrbDB6UmZvNDBtYnAxdmdE?=
 =?utf-8?B?L1lzUG0zL1RzTExYbFQ4aVl2UWxpbmIwMml6Q3dpQTZOYklHTHRHYWlCaDdj?=
 =?utf-8?B?SWxCbHJJZEVpREs4aEkvZU9wblpXaXQvKzd4SGtidFNEN21hZkcvWlVyRFVm?=
 =?utf-8?B?WDF6N2NzMGEzaW01Mlk5cEtVN2ZydE8wOWg0aVlCUzR0TDhKWjR1cTBqamMw?=
 =?utf-8?B?dFVSM09EVGlXV2xmR0RyV2J4Um9YT2VGbjBTcStTYVFyKzA0S0ZtT0ZEZEE0?=
 =?utf-8?B?alJidU1wOHVuSDBUQkFFZWxVOE1YYk41Y3diVjYyU0VDS1ZURHRrekpCb29I?=
 =?utf-8?B?SmxWaGVVRG1mS2k1T3NscWFYazU3aEE0T3U0S0lLUjZRY1NDeDg3MVR2S3Jp?=
 =?utf-8?B?Y2lzdm1COXl1R0pGTDlnYzVNMlA3d21XNzRNY3JXU3FEbWVHck9TMHhFV2hs?=
 =?utf-8?B?RmlqMlhwVkFQcUFaYTlBQ2dUdkhzTVVQbUhnTWNQSXB2UTRBTXJVR09jMkVF?=
 =?utf-8?B?TkF0dkhMZWJnNElzNDJUM0RSbWcxaVRjdno1b2dYWlhFSGIyb0VXTnd3NG4x?=
 =?utf-8?B?SHQ2M3pyMUYwc1hzZjllQmFlOG5BYzF3MGowaTY2TC9VSGxMdWdINWxGa3R2?=
 =?utf-8?B?bUNCbEN1MFFJNEl3Q0RvY0JoWXZjazVjbU1TNW9IZ2ZTRTB1dGhiWTRHWXUy?=
 =?utf-8?B?QmxBRkgvbmR3eFptN1BZSHNTQURuaVRpUXBkUTg1MnlUa21ic1R6M2lhZURo?=
 =?utf-8?B?dFhxK3lCek9PWVJsS2pncSs3cWpvbkxoeUgzaTBSa1BlZjZNM3ZlRWJpUUgx?=
 =?utf-8?B?RkxRRWxNcmVad1JKOEZLTnZrQm5mUmFOMCtZLytyRTFidTBmWTU1MGgzeWNI?=
 =?utf-8?B?NU56MmkrYi8zS1d5THpCTExlM1pGSVRHVXhVV3BJcEJDQmVTTDlxWnpjSm01?=
 =?utf-8?B?NXpVR290R2xaUk8vSkFvekJVVVJqays0VERRV09jbWJMd1hxNithbGZvQzJk?=
 =?utf-8?B?NEtEYTAyazZIMTdlMnlSV0wwRkhXRXRFQzhBZktUSkVTRUg5YzByQlNlZVpo?=
 =?utf-8?B?M1dZK29pRk9qZzZmK3JzUURGNCsxMHJKd3RJaWIxK04zVFlnUmVUQ0V5NGpJ?=
 =?utf-8?B?bEs2VVFoMGVkRmtKRndaV1ZZZFhObEZwSm1yTGppYUMwOUZGcndWSGd3Q04z?=
 =?utf-8?B?cUNPT2lEMy80S3FFK3VYRU4xbS81bURaaDZZSytsWTM3MnlHRTNSeGJoM1Bo?=
 =?utf-8?B?VGVKcURqY0hZcGVScEcveVIyV3F5WEg1a2h2NjVOU2kxekF1QUlRYmJQdmM1?=
 =?utf-8?B?emxwekZubGcwZ2puS0tmSWZlcmNKTCtJTkpoaHFkakVvWUZSdmt5S2R1OWR1?=
 =?utf-8?B?em94b093cFZTWDlmd3pTRFN5dlZOSVRFL0FyRnUvMGJ1VTg5MzJRWlFVZmNZ?=
 =?utf-8?B?S2ppTzN5M3RPNjAyaExOSmdOc0MrcDJQZ0plRlV2SC9hR0FiZGxtS2JiL1Bk?=
 =?utf-8?Q?hez+3ju22eauf7bszQJ2vpAoR?=
X-OriginatorOrg: talpey.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57db6349-e603-46e9-cb6b-08db6929c285
X-MS-Exchange-CrossTenant-AuthSource: SN6PR01MB4445.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2023 20:40:28.2579
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2b2dcae7-2555-4add-bc80-48756da031d5
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bvztgeTMiVXXlRsk0oH+7cpbSaxW8ZWrNEawewqaM2YlfHpXIqa4gdew58aJmV6Z
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR01MB8599
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 6/5/2023 9:11 AM, Chuck Lever wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
> 
> The physical device's NUMA node ID is available when allocating an
> svc_xprt for an incoming connection. Use that value to ensure the
> svc_xprt structure is allocated on the NUMA node closest to the
> device.

How is "closest" determined from the device's perspective? While I agree
that allocating DMA-able control structures on the same CPU socket is
good for signaling latency, it may or may not be the best choice for
interrupt processing. And, some architectures push the NUMA envelope
pretty far, such as presenting memory-only NUMA nodes, or highly
asymmetrical processor cores. How are those accounted for?

Would it make more sense to push this affinity down to the CQ level,
associating them with selected cores? One obvious strategy might be
to affinitize the send and receive cq's to different cores, and
carefully place send-side and receive-side contexts on separate
affinitized cachelines, to avoid pingponging.

I'm not against the idea, just wondering if it goes far enough. Do
you have numbers, and if so, on what platforms?

Tom.

> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>   net/sunrpc/xprtrdma/svc_rdma_transport.c |   18 +++++++++---------
>   1 file changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/net/sunrpc/xprtrdma/svc_rdma_transport.c b/net/sunrpc/xprtrdma/svc_rdma_transport.c
> index ca04f7a6a085..2abd895046ee 100644
> --- a/net/sunrpc/xprtrdma/svc_rdma_transport.c
> +++ b/net/sunrpc/xprtrdma/svc_rdma_transport.c
> @@ -64,7 +64,7 @@
>   #define RPCDBG_FACILITY	RPCDBG_SVCXPRT
>   
>   static struct svcxprt_rdma *svc_rdma_create_xprt(struct svc_serv *serv,
> -						 struct net *net);
> +						 struct net *net, int node);
>   static struct svc_xprt *svc_rdma_create(struct svc_serv *serv,
>   					struct net *net,
>   					struct sockaddr *sa, int salen,
> @@ -123,14 +123,14 @@ static void qp_event_handler(struct ib_event *event, void *context)
>   }
>   
>   static struct svcxprt_rdma *svc_rdma_create_xprt(struct svc_serv *serv,
> -						 struct net *net)
> +						 struct net *net, int node)
>   {
> -	struct svcxprt_rdma *cma_xprt = kzalloc(sizeof *cma_xprt, GFP_KERNEL);
> +	struct svcxprt_rdma *cma_xprt;
>   
> -	if (!cma_xprt) {
> -		dprintk("svcrdma: failed to create new transport\n");
> +	cma_xprt = kzalloc_node(sizeof(*cma_xprt), GFP_KERNEL, node);
> +	if (!cma_xprt)
>   		return NULL;
> -	}
> +
>   	svc_xprt_init(net, &svc_rdma_class, &cma_xprt->sc_xprt, serv);
>   	INIT_LIST_HEAD(&cma_xprt->sc_accept_q);
>   	INIT_LIST_HEAD(&cma_xprt->sc_rq_dto_q);
> @@ -193,9 +193,9 @@ static void handle_connect_req(struct rdma_cm_id *new_cma_id,
>   	struct svcxprt_rdma *newxprt;
>   	struct sockaddr *sa;
>   
> -	/* Create a new transport */
>   	newxprt = svc_rdma_create_xprt(listen_xprt->sc_xprt.xpt_server,
> -				       listen_xprt->sc_xprt.xpt_net);
> +				       listen_xprt->sc_xprt.xpt_net,
> +				       ibdev_to_node(new_cma_id->device));
>   	if (!newxprt)
>   		return;
>   	newxprt->sc_cm_id = new_cma_id;
> @@ -304,7 +304,7 @@ static struct svc_xprt *svc_rdma_create(struct svc_serv *serv,
>   
>   	if (sa->sa_family != AF_INET && sa->sa_family != AF_INET6)
>   		return ERR_PTR(-EAFNOSUPPORT);
> -	cma_xprt = svc_rdma_create_xprt(serv, net);
> +	cma_xprt = svc_rdma_create_xprt(serv, net, NUMA_NO_NODE);
>   	if (!cma_xprt)
>   		return ERR_PTR(-ENOMEM);
>   	set_bit(XPT_LISTENER, &cma_xprt->sc_xprt.xpt_flags);
> 
> 
> 
