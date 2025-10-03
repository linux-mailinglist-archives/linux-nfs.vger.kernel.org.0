Return-Path: <linux-nfs+bounces-14955-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A904BB6682
	for <lists+linux-nfs@lfdr.de>; Fri, 03 Oct 2025 11:55:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C808C4E1733
	for <lists+linux-nfs@lfdr.de>; Fri,  3 Oct 2025 09:55:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4858E2E8DFC;
	Fri,  3 Oct 2025 09:54:42 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 776982E8B83;
	Fri,  3 Oct 2025 09:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759485282; cv=none; b=k28v/YEGS4mUjqzaxV59a8eTRQDw7VqTQm+ypFumHTHK4sw30/GXpwJnVY5BczFncat9OBSj+/eTlaZ1+seHdC67kUOpfxkMA2uycSIo8n9+4iRRkGy+dymd1f8sqWG3D7LhYHuuQlN14oiERHUOQ1iUSS7w0a0EMZ1VHF78Xgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759485282; c=relaxed/simple;
	bh=2WZUeKVDfC335msd+Bd9qMK6RYmQrB0O9LN0WZblAc8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VXhH+n8KILVRKHvJ31NHrz96R2r9XcdYelfyan1VRX1teQDVZ15v23U+wbLDihEAc4CSvTtERAGKQBrtRjdYFIhlATQOqyEw5hRwWvHMySefz2ikxwu/jaQoy7Pnei294z7FlT8WZt227BdgiWFY1tjwwicHhls439PpGfldZM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 2102F227AAC; Fri,  3 Oct 2025 11:54:34 +0200 (CEST)
Date: Fri, 3 Oct 2025 11:54:34 +0200
From: Christoph Hellwig <hch@lst.de>
To: alistair23@gmail.com
Cc: chuck.lever@oracle.com, hare@kernel.org,
	kernel-tls-handshake@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-nfs@vger.kernel.org,
	kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	kch@nvidia.com, hare@suse.de,
	Alistair Francis <alistair.francis@wdc.com>
Subject: Re: [PATCH v3 7/8] nvmet-tcp: Support KeyUpdate
Message-ID: <20251003095434.GB15497@lst.de>
References: <20251003043140.1341958-1-alistair.francis@wdc.com> <20251003043140.1341958-8-alistair.francis@wdc.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251003043140.1341958-8-alistair.francis@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, Oct 03, 2025 at 02:31:38PM +1000, alistair23@gmail.com wrote:
> +#ifdef CONFIG_NVME_TARGET_TCP_TLS
> +static int nvmet_tcp_try_peek_pdu(struct nvmet_tcp_queue *queue);
> +static void nvmet_tcp_tls_handshake_timeout(struct work_struct *w);
> +#endif

Can we find a way to structure the code to do without forward declarations
and either without ifdefs or with stubs when you need them?

> +#ifdef CONFIG_NVME_TARGET_TCP_TLS
> +			if (ret == -EKEYEXPIRED &&
> +				queue->state != NVMET_TCP_Q_DISCONNECTING &&
> +				queue->state != NVMET_TCP_Q_TLS_HANDSHAKE) {
> +					goto done;
> +			}

Wrong indentation and superflous braces here.

> +	ret = nvmet_tcp_tls_handshake(queue, HANDSHAKE_KEY_UPDATE_TYPE_RECEIVED);
> +
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = wait_for_completion_interruptible_timeout(&queue->tls_complete, 10 * HZ);

Please avoid the overly long lines.

> +
> +	if (ret <= 0) {
> +		tls_handshake_cancel(queue->sock->sk);
> +		return ret;
> +	}
> +
> +	queue->state = NVMET_TCP_Q_LIVE;
> +
> +	return ret;

This should be a unconditional ret 0, or am I missing something?

> +#ifdef CONFIG_NVME_TARGET_TCP_TLS
> +			if (ret == -EKEYEXPIRED &&
> +				queue->state != NVMET_TCP_Q_DISCONNECTING &&
> +				queue->state != NVMET_TCP_Q_TLS_HANDSHAKE) {
> +					goto done;
> +			}

Same as above.  And given that we have multiple instances of this
check I suspect we want a little helper for it.

> +#ifdef CONFIG_NVME_TARGET_TCP_TLS
> +			if (ret == -EKEYEXPIRED)
> +				update_tls_keys(queue);
> +			else
> +#endif
> +				return;
> +		}

If you provide a proper stub for update_tls_keys this becomes much
saner:

		if (ret != -EKEYEXPIRED)
			return;
		update_tls_keys(queue);

> +#ifdef CONFIG_NVME_TARGET_TCP_TLS
> +			if (ret == -EKEYEXPIRED)
> +				update_tls_keys(queue);
> +			else
> +#endif
> +				return;

Same here.


