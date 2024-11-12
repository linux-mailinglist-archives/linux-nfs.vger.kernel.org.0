Return-Path: <linux-nfs+bounces-7892-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AC1EC9C50AC
	for <lists+linux-nfs@lfdr.de>; Tue, 12 Nov 2024 09:32:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0BE44B24505
	for <lists+linux-nfs@lfdr.de>; Tue, 12 Nov 2024 08:30:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5364C20B80E;
	Tue, 12 Nov 2024 08:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yWQMBO17"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22D3620B804;
	Tue, 12 Nov 2024 08:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731400186; cv=none; b=r40aAILESM6A/rfMGbmkoTsPAss3kCUUQ19C6xftvLQrN4YOvmoG5HRqyK00GW0jitUvP2RzIUJAUlwJnlPVyaYB+7FVjiZ/XLmw/QZRug8ch9V4O3fn7NBoCoQ/VzCP/swlaCIENo6pe5meIKfvBsCqM1FJgrpdcTXI62ovRa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731400186; c=relaxed/simple;
	bh=lewkLCFT5caOzo2eIz0/4MPy5k1mOTkPZn80H1AlMp0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lZKfnzv9HSFEy0BOSztnV9MqHICccOZ4dwk50oUw/KcXBC0WobllNIzQQkezQQd3ya/FOroQfITTg3ucu0+I7GGNvjt8eHRCV55yESVcXHy41o68B8sGI6Qn6BCVeaUtU9OyEhtYvc72RwvYV/PsjngiYcnoN6Hawt88FlX2Kzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yWQMBO17; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13E60C4CED4;
	Tue, 12 Nov 2024 08:29:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1731400185;
	bh=lewkLCFT5caOzo2eIz0/4MPy5k1mOTkPZn80H1AlMp0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=yWQMBO17MoNMueddZNh/DINix5Nh6/RihTz5Wi9Mq7I9ZwcgaNEyKaUqS2V9H/lEf
	 juXsJrWsRhA56g9mQR0Osdso+5zvjdLHIgEN9Ur9ziLC/D2xwqPUoQSIfoVgxLJ+gf
	 yHEED/tYKRoKVCNpF1C2IbaG1Iom732YWyD+dUt8=
Date: Tue, 12 Nov 2024 09:29:41 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: cel@kernel.org
Cc: stable@vger.kernel.org, Neil Brown <neilb@suse.de>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>,
	Cedric Blancher <cedric.blancher@gmail.com>,
	Dan Shelton <dan.f.shelton@gmail.com>,
	Roland Mainz <roland.mainz@nrubsig.org>
Subject: Re: [PATCH 5.4] NFSD: Fix NFSv4's PUTPUBFH operation
Message-ID: <2024111225-turmoil-tableware-933a@gregkh>
References: <20241110184510.20129-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241110184510.20129-1-cel@kernel.org>

On Sun, Nov 10, 2024 at 01:45:10PM -0500, cel@kernel.org wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
> 
> [ Upstream commit 202f39039a11402dcbcd5fece8d9fa6be83f49ae ]
> 
> According to RFC 8881, all minor versions of NFSv4 support PUTPUBFH.
> 
> Replace the XDR decoder for PUTPUBFH with a "noop" since we no
> longer want the minorversion check, and PUTPUBFH has no arguments to
> decode. (Ideally nfsd4_decode_noop should really be called
> nfsd4_decode_void).
> 
> PUTPUBFH should now behave just like PUTROOTFH.
> 
> Reported-by: Cedric Blancher <cedric.blancher@gmail.com>
> Fixes: e1a90ebd8b23 ("NFSD: Combine decode operations for v4 and v4.1")
> Cc: Dan Shelton <dan.f.shelton@gmail.com>
> Cc: Roland Mainz <roland.mainz@nrubsig.org>
> Cc: stable@vger.kernel.org
> [ cel: adjusted to apply to origin/linux-5.4.y ]
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  fs/nfsd/nfs4xdr.c | 10 +---------
>  1 file changed, 1 insertion(+), 9 deletions(-)
> 
> In response to:
> 
> https://lore.kernel.org/stable/2024100703-decorated-bodacious-fa3c@gregkh/

Now queued up, thanks.

greg k-h

