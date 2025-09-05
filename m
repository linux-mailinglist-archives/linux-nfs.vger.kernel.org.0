Return-Path: <linux-nfs+bounces-14067-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6952BB458F7
	for <lists+linux-nfs@lfdr.de>; Fri,  5 Sep 2025 15:29:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4EDAF5C2FAF
	for <lists+linux-nfs@lfdr.de>; Fri,  5 Sep 2025 13:27:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6E2F34F49F;
	Fri,  5 Sep 2025 13:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E76NbuJN"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F88034F497;
	Fri,  5 Sep 2025 13:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757078749; cv=none; b=ic46IZO3nfl19X4JVl9W/KKE6HeDcmZtosEakv2o+uxJR86jMnOkSLNM/NU0zl2spEEL26/WlbnuoQLIwwjijpvSlmUFDSUpK093NHhJGBQaF587lfo/+sJh0RMlTfcHa9rdif0v0TF+TLjoN/gj2sGP7h1b5H7JyMqu2wLk0Wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757078749; c=relaxed/simple;
	bh=R1AXq4tboKPDj02j8ZcSeexsVBxOm5DIaVF9xRR7bfc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H2hSTCkd2RDnVARzebGaIOGukbO9+DUxRrr7MZ5ECLQIo5+r0/5irdtPPDvWcsqmKRXu2cI0sr02wngp28Chr6qVvTkh9K25GongxOqFHYUfYKm2hOq5tnWAr0wNXjD7rLPxrxDg/f0+qlE7LVyJA2EtNSbXKxLvDz9+Fue1U6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E76NbuJN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05128C4CEF1;
	Fri,  5 Sep 2025 13:25:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757078749;
	bh=R1AXq4tboKPDj02j8ZcSeexsVBxOm5DIaVF9xRR7bfc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=E76NbuJNf2kf/BhoQi8TEL7Ic7QymW5CnnfRYMvFmXpr+XLkXtiGilA67T0x+s7sg
	 wtyEutZKLD8/Ic7i3+8R1apz+fRu7epFv5eJXPPhjkyaCi+/aUjYUAs/mosVetyXyc
	 RtO5uq37ljl0z60pPUcXStrqibWbqTJyjEovcGiBdRDawKVDz9lZVmx3Wi5tsW6DaP
	 M495girntXe/+L65UtPi+bCimkM0OFEGJvJHhELPfPtsgDX7ufkdswodcbZDtqzwav
	 1q5wEcTUKnXLVjzn007IM7GSw0dlMO+qKSucwLafbMUfHLqUFYPEYEXDJCZsdgptC5
	 FDbTmIE4R15fg==
Date: Fri, 5 Sep 2025 14:25:43 +0100
From: Simon Horman <horms@kernel.org>
To: alistair23@gmail.com
Cc: chuck.lever@oracle.com, hare@kernel.org,
	kernel-tls-handshake@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-nfs@vger.kernel.org,
	kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	kch@nvidia.com, Alistair Francis <alistair.francis@wdc.com>
Subject: Re: [PATCH v2 7/7] nvmet-tcp: Support KeyUpdate
Message-ID: <20250905132543.GG553991@horms.kernel.org>
References: <20250905024659.811386-1-alistair.francis@wdc.com>
 <20250905024659.811386-8-alistair.francis@wdc.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250905024659.811386-8-alistair.francis@wdc.com>

On Fri, Sep 05, 2025 at 12:46:59PM +1000, alistair23@gmail.com wrote:

...

> diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c

...

>  static int nvmet_tcp_tls_record_ok(struct nvmet_tcp_queue *queue,
>  		struct msghdr *msg, char *cbuf)
>  {
>  	struct cmsghdr *cmsg = (struct cmsghdr *)cbuf;
> -	u8 ctype, level, description;
> +	u8 ctype, htype, level, description;

nit: htype is unused in this function

Flagged by W=1 builds.

>  	int ret = 0;
>  
>  	ctype = tls_get_record_type(queue->sock->sk, cmsg);

...

