Return-Path: <linux-nfs+bounces-13679-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DB95B28498
	for <lists+linux-nfs@lfdr.de>; Fri, 15 Aug 2025 19:02:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 43C1BB62D8F
	for <lists+linux-nfs@lfdr.de>; Fri, 15 Aug 2025 17:00:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 952453112B4;
	Fri, 15 Aug 2025 17:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SzQO6p9f"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6381E31078D;
	Fri, 15 Aug 2025 17:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755277340; cv=none; b=jkQcnntS7Fi3Ob0cLMZZPD9EtklgMNG4RRb/L9F6PHvmVY8XhEVjAanX6yQE/0Lv5rXGz7naOdjqheEe7Z4RGfzyIDzBw0XD9bHHJW7to3znYwNNsvV4Wq5olC6l4GkwB7DCEgRoewvA1WKGWrL3RDr6Wg1ChEmpy0OvN5h/vZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755277340; c=relaxed/simple;
	bh=XmIS/WI/DfVdgXw6f9J2hDX2XYrlFBTAGBPWIoj10f4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PNJR4OvMuDn41xvAchrTXFoKSFHE/1/BNPPxBwGn6Ehkskix3+uD3isYYf0RxnmpJMufJc7Q8YYWTVtSe0j9gHn2jJ6DIrTvyAiXJFG2G5P7kt/whWAupNtnoUEGGz2AbP14TMX0hU+NcuPW/r5T5R6n97fif5u0Y2IN8+d6fHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SzQO6p9f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 809ACC4CEEB;
	Fri, 15 Aug 2025 17:02:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755277340;
	bh=XmIS/WI/DfVdgXw6f9J2hDX2XYrlFBTAGBPWIoj10f4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SzQO6p9fpOVIuh2yhufraOPMrNzXlYONg07s8+J9gTIW3/zS1xAUSGzoC+j4WvIhj
	 /WbguKtyh7Ip+rusYtcHDHmEp1zrNh0AjN9O3rZOx4TBysINtGCng6YxLxB6labKWF
	 /Zv2a7pLybRrU7xovT4n17Rnh8gi4Hh760N7eICMTOcv5h9ngibiG3zvnNTnQx3DXB
	 wZzQh773PYjW1AyxOP/QOzZ3DlO0cp3VWzGc7pUE4POKCSjJLp/4cuTRk0lQm8UhfK
	 Qha6yaZk+nAjRjLdZQKK25bGUZ1VYisX0GvwCcMI5EFh6uteY6TYxznG9MbsOKpOtJ
	 Z6V4qnUkWVWjw==
Date: Fri, 15 Aug 2025 10:02:18 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: alistair23@gmail.com
Cc: chuck.lever@oracle.com, hare@kernel.org,
 kernel-tls-handshake@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-nfs@vger.kernel.org,
 kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
 kch@nvidia.com, Alistair Francis <alistair.francis@wdc.com>
Subject: Re: [PATCH 4/8] tls: Allow callers to clear errors
Message-ID: <20250815100218.4a492986@kernel.org>
In-Reply-To: <20250815050210.1518439-5-alistair.francis@wdc.com>
References: <20250815050210.1518439-1-alistair.francis@wdc.com>
	<20250815050210.1518439-5-alistair.francis@wdc.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 15 Aug 2025 15:02:06 +1000 alistair23@gmail.com wrote:
> As part of supporting KeyUpdate we are going to pass errors up to the
> callers of TLS to indaicate a KeyUpdate. Those layers will need to handle
> the KeyUpdate and as part of that clear the error.

> +static inline void tls_clear_err(struct sock *sk)
> +{
> +	WRITE_ONCE(sk->sk_err, 0);
> +	/* Paired with smp_rmb() in tcp_poll() */
> +	smp_wmb();

Please explain how the key error ends up recorded on the socket.

