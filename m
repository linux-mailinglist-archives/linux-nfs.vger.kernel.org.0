Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE71A3005E2
	for <lists+linux-nfs@lfdr.de>; Fri, 22 Jan 2021 15:47:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728556AbhAVOrB (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 22 Jan 2021 09:47:01 -0500
Received: from p3plsmtpa12-01.prod.phx3.secureserver.net ([68.178.252.230]:43838
        "EHLO p3plsmtpa12-01.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728156AbhAVOqv (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 22 Jan 2021 09:46:51 -0500
X-Greylist: delayed 538 seconds by postgrey-1.27 at vger.kernel.org; Fri, 22 Jan 2021 09:46:50 EST
Received: from [192.168.0.116] ([71.184.94.153])
        by :SMTPAUTH: with ESMTPSA
        id 2xYdl9f168l7w2xYdlpRAx; Fri, 22 Jan 2021 07:37:04 -0700
X-CMAE-Analysis: v=2.4 cv=CdzNWJnl c=1 sm=1 tr=0 ts=600ae310
 a=vbvdVb1zh1xTTaY8rfQfKQ==:117 a=vbvdVb1zh1xTTaY8rfQfKQ==:17
 a=IkcTkHD0fZMA:10 a=yPCof4ZbAAAA:8 a=2kpoKP-xqDkaLSQT8pIA:9 a=QEXdDO2ut3YA:10
X-SECURESERVER-ACCT: tom@talpey.com
Subject: Re: [PATCH v1 2/2] svcrdma: DMA-sync the receive buffer in
 svc_rdma_recvfrom()
To:     Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org,
        linux-rdma@vger.kernel.org
References: <161126216710.8979.7145432546367265892.stgit@klimt.1015granger.net>
 <161126239239.8979.7995314438640511469.stgit@klimt.1015granger.net>
From:   Tom Talpey <tom@talpey.com>
Message-ID: <75a4edc8-791c-b98e-b943-0ebff8aa4b16@talpey.com>
Date:   Fri, 22 Jan 2021 09:37:02 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <161126239239.8979.7995314438640511469.stgit@klimt.1015granger.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfPh0Pu4tRy7A9AxbLO66VbWuW2JTaX0Ado1MdjJJkcYgwMTwkucdto7dwHmrqg2Phd45z7WP+3ys8VhTF8Hyps07ZeI39VsH2Glh9S8BDnxfIowdQUFl
 4mv+EE9saq+ZQGnZEyVO8DHQy46HNBThL04QC47+lLOgHeXy1Fytn0nvt/E7pR9y8j0lCiDmbF6leViaE+TvewBBZGJCA3piDe4wsOTmTEFqkow79MrgVrNy
 p3WLjuYL1N80Xuo1gew9Uia6rE37F8WZLo+dmla9EZE=
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Is there an asynchronous version of ib_dma_sync? Because it flushes
DMA pipelines, I'm wondering if kicking it off early might improve
latency, getting it done before svc_rdma_recvfrom() needs to dig
into the contents.

Tom.

On 1/21/2021 3:53 PM, Chuck Lever wrote:
> The Receive completion handler doesn't look at the contents of the
> Receive buffer. The DMA sync isn't terribly expensive but it's one
> less thing that needs to be done by the Receive completion handler,
> which is single-threaded (per svc_xprt). This helps scalability.
> 
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>   net/sunrpc/xprtrdma/svc_rdma_recvfrom.c |    6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c b/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
> index ab0b7e9777bc..6d28f23ceb35 100644
> --- a/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
> +++ b/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
> @@ -342,9 +342,6 @@ static void svc_rdma_wc_receive(struct ib_cq *cq, struct ib_wc *wc)
>   
>   	/* All wc fields are now known to be valid */
>   	ctxt->rc_byte_len = wc->byte_len;
> -	ib_dma_sync_single_for_cpu(rdma->sc_pd->device,
> -				   ctxt->rc_recv_sge.addr,
> -				   wc->byte_len, DMA_FROM_DEVICE);
>   
>   	spin_lock(&rdma->sc_rq_dto_lock);
>   	list_add_tail(&ctxt->rc_list, &rdma->sc_rq_dto_q);
> @@ -851,6 +848,9 @@ int svc_rdma_recvfrom(struct svc_rqst *rqstp)
>   	spin_unlock(&rdma_xprt->sc_rq_dto_lock);
>   	percpu_counter_inc(&svcrdma_stat_recv);
>   
> +	ib_dma_sync_single_for_cpu(rdma_xprt->sc_pd->device,
> +				   ctxt->rc_recv_sge.addr, ctxt->rc_byte_len,
> +				   DMA_FROM_DEVICE);
>   	svc_rdma_build_arg_xdr(rqstp, ctxt);
>   
>   	/* Prevent svc_xprt_release from releasing pages in rq_pages
> 
> 
> 
