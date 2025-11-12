Return-Path: <linux-nfs+bounces-16289-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE8A6C50DB4
	for <lists+linux-nfs@lfdr.de>; Wed, 12 Nov 2025 08:07:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7CCA3A3EE9
	for <lists+linux-nfs@lfdr.de>; Wed, 12 Nov 2025 07:02:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BBA22E54A3;
	Wed, 12 Nov 2025 06:59:33 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF9082E4241;
	Wed, 12 Nov 2025 06:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762930773; cv=none; b=GPM/jIaVBe9FDtV+vMIbQseXNvkohf1nsdKQNw6zK8PQc83f6jBCUhSL0t9ZLdrbpUZobtLEU5ieDEpCjvw4yFZRWoDqrz6MWxQ9PhzBqx4PCfXBbkHrv+3ZSXaOuEbX0xMMMfOGRZUOO4r10k4461W3fnE7uWrM6x3+xhzRdOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762930773; c=relaxed/simple;
	bh=6WAA8VkM8DKbqn+wtCHrI9tmAu7RLU0991mm7cIwYm0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IR5A1dSVMcA3zX2qmlS8F6dPKMykX4sg6hWhrwHqaH5dGykBK2FV9Yb485e5WNgUnH0nuIBvEANdUNGFkSu8an+zif9CXJZQwd4NR8iyIqNwd16C/77rKYQUuLAAkM7lu5TKbFy6V2dilVTzGObmrCD+49rDHe7E6r6JMRsWLfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 0BE87227AA8; Wed, 12 Nov 2025 07:59:26 +0100 (CET)
Date: Wed, 12 Nov 2025 07:59:25 +0100
From: Christoph Hellwig <hch@lst.de>
To: alistair23@gmail.com
Cc: chuck.lever@oracle.com, hare@kernel.org,
	kernel-tls-handshake@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-nfs@vger.kernel.org,
	kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	kch@nvidia.com, hare@suse.de,
	Alistair Francis <alistair.francis@wdc.com>
Subject: Re: [PATCH v5 5/6] nvme-tcp: Support KeyUpdate
Message-ID: <20251112065925.GF4873@lst.de>
References: <20251112042720.3695972-1-alistair.francis@wdc.com> <20251112042720.3695972-6-alistair.francis@wdc.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251112042720.3695972-6-alistair.francis@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Nov 12, 2025 at 02:27:19PM +1000, alistair23@gmail.com wrote:
>  
>  		ret = sock_recvmsg(queue->sock, &msg, msg.msg_flags);
>  		if (ret < 0) {
> +			/* If MSG_CTRUNC is set, it's a control message,
> +			 * so let's read the control message.
> +			 */

This is not the normal kernel comment style, which would be:

			/*
			 * If MSG_CTRUNC is set, it's a control message, so
			 * let's read the control message.
+			 */

> +			if (msg.msg_flags & MSG_CTRUNC) {
> +				memset(&msg, 0, sizeof(msg));
> +				msg.msg_flags = MSG_DONTWAIT;
> +				msg.msg_control = cbuf;
> +				msg.msg_controllen = sizeof(cbuf);
> +
> +				ret = sock_recvmsg(queue->sock, &msg, msg.msg_flags);

Overly long line.  Also given that we're in the main receive handler
it would be nice to have this outside the main flow using a goto and
an unlikely label anyway.


