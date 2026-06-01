Return-Path: <linux-nfs+bounces-22171-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oKgXLHerHWq+cwkAu9opvQ
	(envelope-from <linux-nfs+bounces-22171-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 01 Jun 2026 17:55:35 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CA86E62220D
	for <lists+linux-nfs@lfdr.de>; Mon, 01 Jun 2026 17:55:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 592BD3019A3B
	for <lists+linux-nfs@lfdr.de>; Mon,  1 Jun 2026 15:52:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9180A3DB31A;
	Mon,  1 Jun 2026 15:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="K0M9gfpq"
X-Original-To: linux-nfs@vger.kernel.org
Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C3AC3DA7DD;
	Mon,  1 Jun 2026 15:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780329144; cv=none; b=theShPrHmmSsmh10KTZOT+N2UE+1jwAPgoJKXzFyutue4zejGaTfa27cMS67Zp6925qV5dr1rheJeEVnTYhTwfk8v+nvL+taLVEWfzUMf4MSTiDhKVGkOUjnTunUd6J6FrkbZaLps//leyxyx2VU9DVPEVT+Uyl2XFeN849ASIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780329144; c=relaxed/simple;
	bh=kzAfTuy7xHfinPrNExmwQf57GFjM6NfTK+K64JOdG9s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XRBrPPPzDvJjGsy2V2DISPkSVS7Sav0XAybe0TFX2X+0+Ehz6ekagvLQTdXQPZASz9z5ES5ILPn8Hc1OBG0ev0NJB3u+Yr1PAtWKW8P3FJIwTtgy5arIAoWN5tvpak5VUknbEpSZcBGW96h9z91Fg1ChLYfCezfU8KaHdcO7dEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=K0M9gfpq; arc=none smtp.client-ip=199.89.1.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4gTdkt27pcz1XM0nw;
	Mon,  1 Jun 2026 15:52:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1780329115; x=1782921116; bh=kmrEda0bQxPGtPcIxUwwakVA
	5hY4aI6ssTkbuwIHRjo=; b=K0M9gfpq3CIN5YDfH5BQ0f3gYo4/sVMeyTKg81B9
	mLmdrbPK3Tj5TCtTvZoQMvL2DZ3APPzvnShvE8CQXd5OSWuUaYb2SfXChPv+rqQc
	+Hxhglx9jn3YoSUEqEjbiXM0W/9JmmUvUcnA1XDNmT56eSK6lvjEC/yj0z0ui0I2
	g6YPc+WVhelP56EuEG3OxRFZC0g/mApe2NhLUaRSPG51BTzvd2MDMKWtMjakcUN1
	E2zW0GctQn4QgYIpkp5Dqd9kaHGD0GXxJzdokj+yxuK3UFMUO8S3L0XXuJHv7VhY
	rp7CVNgWS/23k2Zrm0ZHq4a4s/ELf6qJVQ4mU/3KQH+rsw==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id cIA1VVg0MIXx; Mon,  1 Jun 2026 15:51:55 +0000 (UTC)
Received: from [100.119.48.131] (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4gTdk61Xt2z1XM2FV;
	Mon,  1 Jun 2026 15:51:41 +0000 (UTC)
Message-ID: <5d3cac2b-4011-49c5-a142-55c85d38e90f@acm.org>
Date: Mon, 1 Jun 2026 08:51:40 -0700
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rdma-next v6] RDMA: Change capability fields in
 ib_device_attr from int to u32
To: Erni Sri Satya Vennela <ernis@linux.microsoft.com>,
 mkalderon@marvell.com, Jason Gunthorpe <jgg@ziepe.ca>,
 Leon Romanovsky <leon@kernel.org>, zyjzyj2000@gmail.com, sagi@grimberg.me,
 mgurtovoy@nvidia.com, haris.iqbal@ionos.com, jinpu.wang@ionos.com,
 kbusch@kernel.org, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>, kch@nvidia.com, smfrench@gmail.com,
 linkinjeon@kernel.org, metze@samba.org, tom@talpey.com,
 chuck.lever@oracle.com, jlayton@kernel.org, neil@brown.name,
 okorniev@redhat.com, Dai.Ngo@oracle.com, trondmy@kernel.org,
 anna@kernel.org, achender@kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 kees@kernel.org, andriy.shevchenko@linux.intel.com, ebadger@purestorage.com,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
 target-devel@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-cifs@vger.kernel.org, samba-technical@lists.samba.org,
 linux-nfs@vger.kernel.org, netdev@vger.kernel.org, rds-devel@oss.oracle.com
Cc: Jason Gunthorpe <jgg@nvidia.com>
References: <20260601092534.1764560-1-ernis@linux.microsoft.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20260601092534.1764560-1-ernis@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[acm.org,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64];
	R_DKIM_ALLOW(-0.20)[acm.org:s=mr01];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22171-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[linux.microsoft.com,marvell.com,ziepe.ca,kernel.org,gmail.com,grimberg.me,nvidia.com,ionos.com,kernel.dk,lst.de,samba.org,talpey.com,oracle.com,brown.name,redhat.com,davemloft.net,google.com,linux.intel.com,purestorage.com,vger.kernel.org,lists.infradead.org,lists.samba.org,oss.oracle.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[43];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[acm.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bvanassche@acm.org,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[acm.org:mid,acm.org:dkim,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: CA86E62220D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 6/1/26 2:25 AM, Erni Sri Satya Vennela wrote:
> diff --git a/drivers/infiniband/ulp/srp/ib_srp.c b/drivers/infiniband/ulp/srp/ib_srp.c
> index b58868e1cf11..dc30d069ab3d 100644
> --- a/drivers/infiniband/ulp/srp/ib_srp.c
> +++ b/drivers/infiniband/ulp/srp/ib_srp.c
> @@ -557,7 +557,7 @@ static int srp_create_ch_ib(struct srp_rdma_ch *ch)
>   	init_attr->cap.max_send_wr     = m * target->queue_size;
>   	init_attr->cap.max_recv_wr     = target->queue_size + 1;
>   	init_attr->cap.max_recv_sge    = 1;
> -	init_attr->cap.max_send_sge    = min(SRP_MAX_SGE, attr->max_send_sge);
> +	init_attr->cap.max_send_sge    = min_t(u32, SRP_MAX_SGE, attr->max_send_sge);
>   	init_attr->sq_sig_type         = IB_SIGNAL_REQ_WR;
>   	init_attr->qp_type             = IB_QPT_RC;
>   	init_attr->send_cq             = send_cq;
> diff --git a/drivers/infiniband/ulp/srpt/ib_srpt.c b/drivers/infiniband/ulp/srpt/ib_srpt.c
> index 9aec5d80117f..2ffa4f54cd4e 100644
> --- a/drivers/infiniband/ulp/srpt/ib_srpt.c
> +++ b/drivers/infiniband/ulp/srpt/ib_srpt.c
> @@ -1884,7 +1884,7 @@ static int srpt_create_ch_ib(struct srpt_rdma_ch *ch)
>   	 * both both, as RDMA contexts will also post completions for the
>   	 * RDMA READ case.
>   	 */
> -	qp_init->cap.max_send_wr = min(sq_size / 2, attrs->max_qp_wr);
> +	qp_init->cap.max_send_wr = min_t(u32, sq_size / 2, attrs->max_qp_wr);
>   	qp_init->cap.max_rdma_ctxs = sq_size / 2;
>   	qp_init->cap.max_send_sge = attrs->max_send_sge;
>   	qp_init->cap.max_recv_sge = 1;
> @@ -2298,7 +2298,7 @@ static int srpt_cm_req_recv(struct srpt_device *const sdev,
>   	 * depth to avoid that the initiator driver has to report QUEUE_FULL
>   	 * to the SCSI mid-layer.
>   	 */
> -	ch->rq_size = min(MAX_SRPT_RQ_SIZE, sdev->device->attrs.max_qp_wr);
> +	ch->rq_size = min_t(u32, MAX_SRPT_RQ_SIZE, sdev->device->attrs.max_qp_wr);
>   	spin_lock_init(&ch->spinlock);
>   	ch->state = CH_CONNECTING;
>   	INIT_LIST_HEAD(&ch->cmd_wait_list);
> @@ -3225,7 +3225,7 @@ static int srpt_add_one(struct ib_device *device)
>   
>   	sdev->lkey = sdev->pd->local_dma_lkey;
>   
> -	sdev->srq_size = min(srpt_srq_size, sdev->device->attrs.max_srq_wr);
> +	sdev->srq_size = min_t(u32, srpt_srq_size, sdev->device->attrs.max_srq_wr);
>   
>   	srpt_use_srq(sdev, sdev->port[0].port_attrib.use_srq);

min_t() shouldn't be used if there is an alternative available. For the
SRP drivers, please make sure that both arguments of min() are unsigned
instead of using min_t().

Thanks,

Bart.

