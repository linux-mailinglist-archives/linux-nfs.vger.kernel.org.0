Return-Path: <linux-nfs+bounces-15320-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A6793BE64F8
	for <lists+linux-nfs@lfdr.de>; Fri, 17 Oct 2025 06:30:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29B3F1889870
	for <lists+linux-nfs@lfdr.de>; Fri, 17 Oct 2025 04:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72DB730BB9A;
	Fri, 17 Oct 2025 04:30:07 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BF5530B525;
	Fri, 17 Oct 2025 04:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760675407; cv=none; b=D16R0A5KpjtajLExlH8wtXakkGNqccvPMpo9+Fx9yGAwRda1Xm21IqAyA7l2egkYsOPSn0jbKXtFZaTtr4IjtlVh0r5VDOaz/mmGVEwfYrykO83rHszB4rLZyNjlrHo+gUrKjzXYkj3p09ZGdcnlu1BnqJB9T9XjmJ64X9xhLD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760675407; c=relaxed/simple;
	bh=I/Bep9Gu6JYMo2nmAbWQIn0Ojy74IiaczacxPmDthiQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LOwSeU9pp2poSB7VnqtrcZ9fJaBDi1FP20guY9NYPSnfkrsPKKvpd5dnyTTR7fRafJSMikAxbUisl9w5wg+ryap8CjR4UucKP3EmLOAZ1lKyipoKmWS68dvd9GmO8sfkdGaaaDBS1K0ZU2cKUFKmDnlcx63Yr1zxatynUzwnLfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id EAB54227A87; Fri, 17 Oct 2025 06:29:54 +0200 (CEST)
Date: Fri, 17 Oct 2025 06:29:54 +0200
From: Christoph Hellwig <hch@lst.de>
To: alistair23@gmail.com
Cc: chuck.lever@oracle.com, hare@kernel.org,
	kernel-tls-handshake@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-nfs@vger.kernel.org,
	kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	kch@nvidia.com, hare@suse.de,
	Alistair Francis <alistair.francis@wdc.com>
Subject: Re: [PATCH v4 5/7] nvme-tcp: Support KeyUpdate
Message-ID: <20251017042954.GA30271@lst.de>
References: <20251017042312.1271322-1-alistair.francis@wdc.com> <20251017042312.1271322-6-alistair.francis@wdc.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251017042312.1271322-6-alistair.francis@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, Oct 17, 2025 at 02:23:10PM +1000, alistair23@gmail.com wrote:
> From: Alistair Francis <alistair.francis@wdc.com>
> 
> If the nvme_tcp_try_send() or nvme_tcp_try_recv() functions return
> EKEYEXPIRED then the underlying TLS keys need to be updated. This occurs
> on an KeyUpdate event.
> 
> If the NVMe Target (TLS server) initiates a KeyUpdate this patch will
> allow the NVMe layer to process the KeyUpdate request and forward the
> request to userspace. Userspace must then update the key to keep the
> connection alive.
> 
> This patch allows us to handle the NVMe target sending a KeyUpdate
> request without aborting the connection. At this time we don't support
> initiating a KeyUpdate.
> 
> Link: https://datatracker.ietf.org/doc/html/rfc8446#section-4.6.3

Totally independent of the current Link-tag flamewar, spec reference
should be in the free flowing commit text.

> +	if (result == -EKEYEXPIRED) {
> +		return -EKEYEXPIRED;
> +	} else if (result == -EAGAIN) {
> +		return -EAGAIN;
> +	} else if (result < 0) {

returns do not need and should not be followed by else statements.

>  		dev_err(queue->ctrl->ctrl.device,
>  			"receive failed:  %d\n", result);
>  		queue->rd_enabled = false;
>  		nvme_tcp_error_recovery(&queue->ctrl->ctrl);
> +	}
>  
>  	return result < 0 ? result : (queue->nr_cqe = nr_cqe);

Also the overall flow here, but old and newly added feels really odd,
up to the point of intentional obfuscation in the last return line.

I'd expect this to be more something like:

	if (result < 0) {
		if (result != -EKEYEXPIRED && result != -EAGAIN) {
	 		dev_err(queue->ctrl->ctrl.device,
	 			"receive failed:  %d\n", result);
	 		queue->rd_enabled = false;
	  		nvme_tcp_error_recovery(&queue->ctrl->ctrl);
		}
		return result;
	}

	queue->nr_cqe = nr_cqe;
	return nr_cqe;
}

