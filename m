Return-Path: <linux-nfs+bounces-22432-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id lGznI8AlKWoTRgMAu9opvQ
	(envelope-from <linux-nfs+bounces-22432-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 10 Jun 2026 10:52:16 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 09053667704
	for <lists+linux-nfs@lfdr.de>; Wed, 10 Jun 2026 10:52:16 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=samba.org header.s=42 header.b=OfNsxpF9;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22432-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22432-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=samba.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A55BD3130248
	for <lists+linux-nfs@lfdr.de>; Wed, 10 Jun 2026 08:46:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 580FB3B5DED;
	Wed, 10 Jun 2026 08:45:16 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from hr2.samba.org (hr2.samba.org [144.76.82.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F9093B52E6;
	Wed, 10 Jun 2026 08:45:11 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781081116; cv=none; b=uL0CZ3fq/ji4PCwdhhj3wJD4yGipyPHLrS2VpcDk8srFu/ipd92NeEF1iRO9RnttvPYBkbL5TCvWNrhLMZJRyKTQFC2lPyY223VhlqIg/TczHmAMfwa8FYdBIW36OSBpKmvGcaAnGCoCznLTYOWBHHCTm8oFGzc52jQ7Rt68ysA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781081116; c=relaxed/simple;
	bh=3GpvE9sy1NPo5Th2Pm6Ut/szLr6JqPXIlzEAK2Ztm2I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nCZyuHKamkSfZrj+gOlEXLfyYLQ5Bwyzu1XjAtydTkUh35lO0jblVN041KTsDNgSNIG/BoXE4iNwnim6WfW0MXI8qsFoalAViBveClpopY3dBiIdLxTxQOCCD/LcXb8YJxO6qol13t28HiLE3sOfTbz87c/ypQ7giVx/UqeSo+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=samba.org; spf=pass smtp.mailfrom=samba.org; dkim=pass (3072-bit key) header.d=samba.org header.i=@samba.org header.b=OfNsxpF9; arc=none smtp.client-ip=144.76.82.148
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=samba.org;
	s=42; h=From:Cc:To:Date:Message-ID;
	bh=rjPJQkM0fLk8gYwjAGYei/TCZcpAauv07XZFNpzHPC8=; b=OfNsxpF9+NS6EnvAw3LrRN4MYk
	TscG52hSzQTtzwQ0GDX+3Jkad+GQvqJyax19KbAUFAZG6JhiOzxO+AeutzctfO+aOSz8F7GEltP+e
	NveACjQ1S3caoQ8J5/V0zuP2woD9H5Z0FhVHAvKZ5ovujpMkx5HnUIIleyEYjTh/OgkRPLdBQDtCu
	d1auYNOAdWzI2t+yvnZk6XGQ6t7NuK47aQ8U9WbZkS/aGcUIIb+VyK+lcBc3tPzM7PlF1iyM+n/oq
	Dq4b+T+/RUVCUhKzEP7tBYv+mKTLG7XEdeDibZyShJ6GxdSALI0baX983m7Rg9j9qCkuQFQYRxbEM
	0+aaG9w27NQR1srXf1kuc51VNv8QAfgHa02TWKdf7oNRMldGcr1I5Jk/MrYm+Z4/U+fU+KzcZfdkD
	Zun6uplYCq5m9zMS9gd2JZd2Us0ay3WIXnPBvQWD40Jmn+C9FDZsAW6nPV4UwNaCvZHOXpL3Ea/yA
	VbIsbcej6XidTcEsuN6h3Fbh;
Received: from [127.0.0.2] (localhost [127.0.0.1])
	by hr2.samba.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__ECDSA_SECP256R1_SHA256__CHACHA20_POLY1305:256)
	(Exim)
	id 1wXEYV-0000000FFf5-2R6t;
	Wed, 10 Jun 2026 08:44:59 +0000
Message-ID: <c62b32d0-1469-4204-9af9-5ef3b47e3996@samba.org>
Date: Wed, 10 Jun 2026 10:44:57 +0200
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rdma-next v7] RDMA: Change capability fields in
 ib_device_attr from int to u32
To: Erni Sri Satya Vennela <ernis@linux.microsoft.com>,
 mkalderon@marvell.com, Jason Gunthorpe <jgg@ziepe.ca>,
 Leon Romanovsky <leon@kernel.org>, zyjzyj2000@gmail.com, sagi@grimberg.me,
 mgurtovoy@nvidia.com, haris.iqbal@ionos.com, jinpu.wang@ionos.com,
 bvanassche@acm.org, kbusch@kernel.org, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>, kch@nvidia.com, smfrench@gmail.com,
 linkinjeon@kernel.org, tom@talpey.com, trondmy@kernel.org, anna@kernel.org,
 chuck.lever@oracle.com, jlayton@kernel.org, neil@brown.name,
 okorniev@redhat.com, Dai.Ngo@oracle.com, achender@kernel.org,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, kees@kernel.org,
 andriy.shevchenko@linux.intel.com, ebadger@purestorage.com,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
 target-devel@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-cifs@vger.kernel.org, samba-technical@lists.samba.org,
 linux-nfs@vger.kernel.org, netdev@vger.kernel.org, rds-devel@oss.oracle.com
Cc: Jason Gunthorpe <jgg@nvidia.com>
References: <20260606070735.2163063-1-ernis@linux.microsoft.com>
Content-Language: en-US
From: Stefan Metzmacher <metze@samba.org>
In-Reply-To: <20260606070735.2163063-1-ernis@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[samba.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[samba.org:s=42];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:ernis@linux.microsoft.com,m:mkalderon@marvell.com,m:jgg@ziepe.ca,m:leon@kernel.org,m:zyjzyj2000@gmail.com,m:sagi@grimberg.me,m:mgurtovoy@nvidia.com,m:haris.iqbal@ionos.com,m:jinpu.wang@ionos.com,m:bvanassche@acm.org,m:kbusch@kernel.org,m:axboe@kernel.dk,m:hch@lst.de,m:kch@nvidia.com,m:smfrench@gmail.com,m:linkinjeon@kernel.org,m:tom@talpey.com,m:trondmy@kernel.org,m:anna@kernel.org,m:chuck.lever@oracle.com,m:jlayton@kernel.org,m:neil@brown.name,m:okorniev@redhat.com,m:Dai.Ngo@oracle.com,m:achender@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:kees@kernel.org,m:andriy.shevchenko@linux.intel.com,m:ebadger@purestorage.com,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:target-devel@vger.kernel.org,m:linux-nvme@lists.infradead.org,m:linux-cifs@vger.kernel.org,m:samba-technical@lists.samba.org,m:linux-nfs@vger.kernel.org,m:netdev@vger.kernel.org,m:rds-devel@oss.oracle.com,m:jgg@nvi
 dia.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[metze@samba.org,linux-nfs@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-22432-lists,linux-nfs=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[43];
	FREEMAIL_TO(0.00)[linux.microsoft.com,marvell.com,ziepe.ca,kernel.org,gmail.com,grimberg.me,nvidia.com,ionos.com,acm.org,kernel.dk,lst.de,talpey.com,oracle.com,brown.name,redhat.com,davemloft.net,google.com,linux.intel.com,purestorage.com,vger.kernel.org,lists.infradead.org,lists.samba.org,oss.oracle.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[metze@samba.org,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[samba.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 09053667704

Am 06.06.26 um 09:07 schrieb Erni Sri Satya Vennela:
> diff --git a/fs/smb/smbdirect/accept.c b/fs/smb/smbdirect/accept.c
> index 529740005838..44b681a20725 100644
> --- a/fs/smb/smbdirect/accept.c
> +++ b/fs/smb/smbdirect/accept.c
> @@ -32,8 +32,9 @@ int smbdirect_accept_connect_request(struct smbdirect_socket *sc,
>   	/*
>   	 * First set what the we as server are able to support
>   	 */
> - sp->initiator_depth = min_t(u8, sp->initiator_depth,
> - sc->ib.dev->attrs.max_qp_rd_atom);
> + sp->initiator_depth = min3(sp->initiator_depth,
> + sc->ib.dev->attrs.max_qp_rd_atom,
> + U8_MAX);
>   
>   	peer_initiator_depth = param->initiator_depth;
>   	peer_responder_resources = param->responder_resources;
> diff --git a/fs/smb/smbdirect/connect.c b/fs/smb/smbdirect/connect.c
> index cd726b399afe..34a3e72c38fb 100644
> --- a/fs/smb/smbdirect/connect.c
> +++ b/fs/smb/smbdirect/connect.c
> @@ -182,8 +182,9 @@ static int smbdirect_connect_rdma_connect(struct smbdirect_socket *sc)
>   	if (sc->ib.dev->attrs.kernel_cap_flags & IBK_SG_GAPS_REG)
>   		sc->mr_io.type = IB_MR_TYPE_SG_GAPS;
>   
> - sp->responder_resources = min_t(u8, sp->responder_resources,
> - sc->ib.dev->attrs.max_qp_rd_atom);
> + sp->responder_resources = min3(sp->responder_resources,
> + sc->ib.dev->attrs.max_qp_rd_atom,
> + U8_MAX);
>   	smbdirect_log_rdma_mr(sc, SMBDIRECT_LOG_INFO,
>   		"responder_resources=%d\n",
>   		sp->responder_resources);
> diff --git a/fs/smb/smbdirect/connection.c b/fs/smb/smbdirect/connection.c
> index 8adf58097534..690acb84e1b5 100644
> --- a/fs/smb/smbdirect/connection.c
> +++ b/fs/smb/smbdirect/connection.c
> @@ -287,7 +287,7 @@ int smbdirect_connection_create_qp(struct smbdirect_socket *sc)
>   	    qp_cap.max_send_wr > sc->ib.dev->attrs.max_qp_wr) {
>   		pr_err("Possible CQE overrun: max_send_wr %d\n",
>   		       qp_cap.max_send_wr);
> - pr_err("device %.*s reporting max_cqe %d max_qp_wr %d\n",
> + pr_err("device %.*s reporting max_cqe %u max_qp_wr %u\n",
>   		       IB_DEVICE_NAME_MAX,
>   		       sc->ib.dev->name,
>   		       sc->ib.dev->attrs.max_cqe,
> @@ -302,7 +302,7 @@ int smbdirect_connection_create_qp(struct smbdirect_socket *sc)
>   	     max_send_wr >= sc->ib.dev->attrs.max_qp_wr)) {
>   		pr_err("Possible CQE overrun: rdma_send_wr %d + max_send_wr %d = %d\n",
>   		       rdma_send_wr, qp_cap.max_send_wr, max_send_wr);
> - pr_err("device %.*s reporting max_cqe %d max_qp_wr %d\n",
> + pr_err("device %.*s reporting max_cqe %u max_qp_wr %u\n",
>   		       IB_DEVICE_NAME_MAX,
>   		       sc->ib.dev->name,
>   		       sc->ib.dev->attrs.max_cqe,
> @@ -316,7 +316,7 @@ int smbdirect_connection_create_qp(struct smbdirect_socket *sc)
>   	    qp_cap.max_recv_wr > sc->ib.dev->attrs.max_qp_wr) {
>   		pr_err("Possible CQE overrun: max_recv_wr %d\n",
>   		       qp_cap.max_recv_wr);
> - pr_err("device %.*s reporting max_cqe %d max_qp_wr %d\n",
> + pr_err("device %.*s reporting max_cqe %u max_qp_wr %u\n",
>   		       IB_DEVICE_NAME_MAX,
>   		       sc->ib.dev->name,
>   		       sc->ib.dev->attrs.max_cqe,
> @@ -328,7 +328,7 @@ int smbdirect_connection_create_qp(struct smbdirect_socket *sc)
>   
>   	if (qp_cap.max_send_sge > sc->ib.dev->attrs.max_send_sge ||
>   	    qp_cap.max_recv_sge > sc->ib.dev->attrs.max_recv_sge) {
> - pr_err("device %.*s max_send_sge/max_recv_sge = %d/%d too small\n",
> + pr_err("device %.*s max_send_sge/max_recv_sge = %u/%u too small\n",
>   		       IB_DEVICE_NAME_MAX,
>   		       sc->ib.dev->name,
>   		       sc->ib.dev->attrs.max_send_sge,

Acked-by: Stefan Metzmacher <metze@samba.org> for the smbdirect changes.

Thanks!
metze

