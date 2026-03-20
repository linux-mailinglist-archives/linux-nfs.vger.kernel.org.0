Return-Path: <linux-nfs+bounces-20289-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SIjtBUn9vGn15AIAu9opvQ
	(envelope-from <linux-nfs+bounces-20289-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Mar 2026 08:54:49 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D2B02D6D93
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Mar 2026 08:54:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0B84C30045BE
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Mar 2026 07:54:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 827653603DE;
	Fri, 20 Mar 2026 07:53:56 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0489C35F8B2;
	Fri, 20 Mar 2026 07:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773993236; cv=none; b=rVeHBv2XBG17gNefKJY1sFIZ5MmtUb9YHvA5Y1GzDPpoeqwrwWG3lu8bUL30+euef/DnTtI5sBaLDMzBddJu7TwZyuFDOtuQanr7Wsj9lb2Z7ZAix8oLIkI6Cay8aKo8lVU4+THv4ailqe+w8s/ojLrXDTMS5phGes/c+LurcKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773993236; c=relaxed/simple;
	bh=3RFvoi5Ht5aX49NW/Q/r7sHDm6oU7s0JuLpK3Hhp0tI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=upMdPuOTgu5Q7/pNZunlhztO0r7eggPwC8LJNu1370XUIuouyvzK5GdrqZOTEVYW6duOiHIhURxxyLRacWYTwHUwM9uk0u2TGW5egoTb5z5++t4sqUwIWgpYBErys8KSeInHbW7xWnHWOqRipsDondBMxqJMOT6NKFNty6lGs/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 8E26A6732A; Fri, 20 Mar 2026 08:53:48 +0100 (CET)
Date: Fri, 20 Mar 2026 08:53:48 +0100
From: Christoph Hellwig <hch@lst.de>
To: alistair23@gmail.com
Cc: chuck.lever@oracle.com, hare@kernel.org,
	kernel-tls-handshake@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-nfs@vger.kernel.org,
	kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	kch@nvidia.com, hare@suse.de,
	Alistair Francis <alistair.francis@wdc.com>
Subject: Re: [PATCH v7 5/5] nvmet-tcp: Support KeyUpdate
Message-ID: <20260320075348.GC14616@lst.de>
References: <20260304053500.590630-1-alistair.francis@wdc.com> <20260304053500.590630-6-alistair.francis@wdc.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260304053500.590630-6-alistair.francis@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[lst.de : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20289-lists,linux-nfs=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@lst.de,linux-nfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.892];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lst.de:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7D2B02D6D93
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

>  static void nvmet_tcp_free_cmd_buffers(struct nvmet_tcp_cmd *cmd);
> +#ifdef CONFIG_NVME_TARGET_TCP_TLS
> +static int nvmet_tcp_tls_handshake(struct nvmet_tcp_queue *queue,
> +				   enum handshake_key_update_type keyupdate);
> +#endif

Can we find a way to just avoid the ifdefered here and just rely on
compiler dead code elimination?

> +#ifdef CONFIG_NVME_TARGET_TCP_TLS
> +static bool nvmet_tls_key_expired(struct nvmet_tcp_queue *queue, int ret)
> +{
> +	return ret == -EKEYEXPIRED &&
> +		queue->state != NVMET_TCP_Q_DISCONNECTING &&
> +		queue->state != NVMET_TCP_Q_TLS_HANDSHAKE;
> +}
> +#else
> +static bool nvmet_tls_key_expired(struct nvmet_tcp_queue *queue, int ret)
> +{
> +	return false;
> +}
> +#endif

This is a pretty clear candidate for IS_ENABLED().

> +	spin_lock_bh(&queue->state_lock);
> +	if (queue->state == NVMET_TCP_Q_TLS_HANDSHAKE) {
> +		/* Socket closed during handshake */
> +		tls_handshake_cancel(queue->sock->sk);
> +	}
> +	if (queue->state != NVMET_TCP_Q_DISCONNECTING) {
> +		queue->state = NVMET_TCP_Q_DISCONNECTING;
> +		kref_put(&queue->kref, nvmet_tcp_release_queue);
> +	}

switch on the queue state?

> +	ret = nvmet_tcp_tls_handshake(queue, HANDSHAKE_KEY_UPDATE_TYPE_RECEIVED);

Overly lone line.

>  		if (unlikely(ret < 0)) {
> +			if (nvmet_tls_key_expired(queue, ret))
> +					goto done;

This has extra indentation.


