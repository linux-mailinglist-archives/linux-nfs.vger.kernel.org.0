Return-Path: <linux-nfs+bounces-7613-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D94149B90B9
	for <lists+linux-nfs@lfdr.de>; Fri,  1 Nov 2024 12:55:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E9E228316B
	for <lists+linux-nfs@lfdr.de>; Fri,  1 Nov 2024 11:55:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 224AC19C54E;
	Fri,  1 Nov 2024 11:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JaRJzbu8"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED7B719B5AC;
	Fri,  1 Nov 2024 11:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730462117; cv=none; b=a/gU/XAv5FNGKr3DTyhcjgsLHggCZW57q4ej+ptijkxh0IGSAgOgdfefxpnAUtUxl9ATLm+DpI3jtz9ssWVHVKwA8EUFO1KYvUaCsk9MHIMs5S3HktqxqddcYK1+76clPp/2MOHGu6S5a6vkS/iUrOJqrxQFunNBbKeharXyOyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730462117; c=relaxed/simple;
	bh=iryXJWnHmoo3no8YL8DUUDBDCpyYCSB0IIdkl+Vwx+k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VXJy0qN7D36fXCv7A2MNp4hYrLTeKjXzcvvT/POsSLEMUojtZlxS4je2vsiL/FWSdCeOYp/+1q+az5jcSoISslOycxP06T6i7OGKZUlxLFWFPFa+r7Ryv2ZqZ3Es7Ke+aepOJ9NDjReganEIy5+KnGPr73pWzBN51aZYo7m0cEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JaRJzbu8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24B81C4CECD;
	Fri,  1 Nov 2024 11:55:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730462116;
	bh=iryXJWnHmoo3no8YL8DUUDBDCpyYCSB0IIdkl+Vwx+k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JaRJzbu86WONe/9WECGJQ0mQ/1aAgqSKZ5jv5e6yLZwY9ww9x3Kd5E5dcIOEfSsGl
	 45toOyCh09gNh2sa0y4wa9X+xUFQGyMvacYi32S50nCgwrbpAC632Z6hU8rtiNjseG
	 H68V7rPaRwAdlaHR5G/pXBjKzfPD0vBde2D/PU2iZ4LXpiWQKGguDi5+7AI3lGk+wl
	 TT2t3PkUZzYpPLBLAczKsb3d0jxP/7uu5aFVc4x2p4jbKIgUAhDoBCBrewNyAiVC9e
	 ICE9KeFg7TNTQwmpvSoD1EJqKVPDtcTtVBTLA76LTviuFM7oR4uVaFegiYnnDgvYhk
	 00r/grIPaGUUA==
Date: Fri, 1 Nov 2024 11:55:11 +0000
From: Simon Horman <horms@kernel.org>
To: Ye Bin <yebin@huaweicloud.com>
Cc: trondmy@kernel.org, anna@kernel.org, chuck.lever@oracle.com,
	jlayton@kernel.org, neilb@suse.de, okorniev@redhat.com,
	Dai.Ngo@oracle.com, tom@talpey.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	joel.granados@kernel.org, linux@weissschuh.net,
	linux-nfs@vger.kernel.org, netdev@vger.kernel.org,
	yebin10@huawei.com, zhangxiaoxu5@huawei.com
Subject: Re: [PATCH] svcrdma: fix miss destroy percpu_counter in
 svc_rdma_proc_init()
Message-ID: <20241101115511.GA1845794@kernel.org>
References: <20241024015520.1448198-1-yebin@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241024015520.1448198-1-yebin@huaweicloud.com>

On Thu, Oct 24, 2024 at 09:55:20AM +0800, Ye Bin wrote:
> From: Ye Bin <yebin10@huawei.com>
> 
> There's issue as follows:
> RPC: Registered rdma transport module.
> RPC: Registered rdma backchannel transport module.
> RPC: Unregistered rdma transport module.
> RPC: Unregistered rdma backchannel transport module.
> BUG: unable to handle page fault for address: fffffbfff80c609a
> PGD 123fee067 P4D 123fee067 PUD 123fea067 PMD 10c624067 PTE 0
> Oops: Oops: 0000 [#1] PREEMPT SMP KASAN NOPTI
> RIP: 0010:percpu_counter_destroy_many+0xf7/0x2a0
> Call Trace:
>  <TASK>
>  __die+0x1f/0x70
>  page_fault_oops+0x2cd/0x860
>  spurious_kernel_fault+0x36/0x450
>  do_kern_addr_fault+0xca/0x100
>  exc_page_fault+0x128/0x150
>  asm_exc_page_fault+0x26/0x30
>  percpu_counter_destroy_many+0xf7/0x2a0
>  mmdrop+0x209/0x350
>  finish_task_switch.isra.0+0x481/0x840
>  schedule_tail+0xe/0xd0
>  ret_from_fork+0x23/0x80
>  ret_from_fork_asm+0x1a/0x30
>  </TASK>
> 
> If register_sysctl() return NULL, then svc_rdma_proc_cleanup() will not
> destroy the percpu counters which init in svc_rdma_proc_init().
> If CONFIG_HOTPLUG_CPU is enabled, residual nodes may be in the
> 'percpu_counters' list. The above issue may occur once the module is
> removed. If the CONFIG_HOTPLUG_CPU configuration is not enabled, memory
> leakage occurs.
> To solve above issue just destroy all percpu counters when
> register_sysctl() return NULL.
> 
> Fixes: 1e7e55731628 ("svcrdma: Restore read and write stats")
> Fixes: 22df5a22462e ("svcrdma: Convert rdma_stat_sq_starve to a per-CPU counter")
> Fixes: df971cd853c0 ("svcrdma: Convert rdma_stat_recv to a per-CPU counter")
> Signed-off-by: Ye Bin <yebin10@huawei.com>
> ---
>  net/sunrpc/xprtrdma/svc_rdma.c | 18 +++++++++++++-----
>  1 file changed, 13 insertions(+), 5 deletions(-)
> 
> diff --git a/net/sunrpc/xprtrdma/svc_rdma.c b/net/sunrpc/xprtrdma/svc_rdma.c
> index 58ae6ec4f25b..11dff4d58195 100644
> --- a/net/sunrpc/xprtrdma/svc_rdma.c
> +++ b/net/sunrpc/xprtrdma/svc_rdma.c
> @@ -233,25 +233,33 @@ static int svc_rdma_proc_init(void)
>  
>  	rc = percpu_counter_init(&svcrdma_stat_read, 0, GFP_KERNEL);
>  	if (rc)
> -		goto out_err;
> +		goto err;
>  	rc = percpu_counter_init(&svcrdma_stat_recv, 0, GFP_KERNEL);
>  	if (rc)
> -		goto out_err;
> +		goto err_read;
>  	rc = percpu_counter_init(&svcrdma_stat_sq_starve, 0, GFP_KERNEL);
>  	if (rc)
> -		goto out_err;
> +		goto err_recv;
>  	rc = percpu_counter_init(&svcrdma_stat_write, 0, GFP_KERNEL);
>  	if (rc)
> -		goto out_err;
> +		goto err_sq;
>  
>  	svcrdma_table_header = register_sysctl("sunrpc/svc_rdma",
>  					       svcrdma_parm_table);
> +	if (!svcrdma_table_header)

Hi Ye Bin,

Should rc be set to a negative error value here,
as is the case for other error cases above?

Flagged by Smatch.

> +		goto err_write;
> +
>  	return 0;
>  
> -out_err:
> +err_write:
> +	percpu_counter_destroy(&svcrdma_stat_write);
> +err_sq:
>  	percpu_counter_destroy(&svcrdma_stat_sq_starve);
> +err_recv:
>  	percpu_counter_destroy(&svcrdma_stat_recv);
> +err_read:
>  	percpu_counter_destroy(&svcrdma_stat_read);
> +err:
>  	return rc;
>  }
>  
> -- 
> 2.34.1
> 

