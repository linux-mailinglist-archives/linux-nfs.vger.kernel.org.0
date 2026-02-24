Return-Path: <linux-nfs+bounces-19185-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gFl/M+blnWlDSgQAu9opvQ
	(envelope-from <linux-nfs+bounces-19185-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 24 Feb 2026 18:54:46 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E6D918ACA5
	for <lists+linux-nfs@lfdr.de>; Tue, 24 Feb 2026 18:54:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 26C4C303900F
	for <lists+linux-nfs@lfdr.de>; Tue, 24 Feb 2026 17:54:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5C663A7F5F;
	Tue, 24 Feb 2026 17:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="FJx2QJD7"
X-Original-To: linux-nfs@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2741F3A9D8D;
	Tue, 24 Feb 2026 17:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771955684; cv=none; b=pTZH7618R20J0N3kcrtxt7bdIujqORuZloy6MCAett/IiUcLfEcYUsXvXRcr6QVq7DAb9cwte8CH8STxIv4uz4upAWnlvPz2Rjx/ri87dc9ndX7eRmo+2x/6LN2SEK20pA45kzcqfSMfA5hmFthHGESg+HD1stvYomAEv9LSrK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771955684; c=relaxed/simple;
	bh=sRojY1dmgu1SyxAfQQtY2z7zl3cRmyWOWNS/bWU3SAc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZcQV8WhVFq9AaIBmoN0vRIfOYvgrrwLBcu/Hx/1qLExZLuhRaudngHW4whdyP6EIE66K20Jriy5/Fim5+p+SiUa26mKjF6OeVrSaEsnsWiL1w9UjT1MB5Ej1IOUvsJmhckOgZN4FdaQu6FS+7fKq6noM0FajDOD1QerZu2hkP44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=FJx2QJD7; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=QXigi2nK3SDfHh3A5lurODPTPbH1RaxAQPTqnpmP9o8=; b=FJx2QJD7ypH2/wfmwtUXNWGJ8s
	FgtvcOhUqzTU+pJbur60tTSCjHqi/SXLaGUFg75X4KtCWcjkXW0zwjuOek2MTFs1HZISfuz8T4Nrq
	fHtKNOQJZe2QirywIEtz0eZo6usDLMjbOtdVZ9LrlDB/Xi0HNFmyq315djUaQLvUy4bs=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vuwcF-008dan-Ir; Tue, 24 Feb 2026 18:54:35 +0100
Date: Tue, 24 Feb 2026 18:54:35 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Sean Chang <seanwascoding@gmail.com>
Cc: nicolas.ferre@microchip.com, claudiu.beznea@tuxon.dev,
	trond.myklebust@hammerspace.com, anna@kernel.org,
	netdev@vger.kernel.org, linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] nfs: fix unused variable warning when
 CONFIG_SUNRPC_DEBUG is disabled
Message-ID: <55375148-e26f-4d62-8690-c0eae8bb1b39@lunn.ch>
References: <20260224165435.17648-1-seanwascoding@gmail.com>
 <20260224165435.17648-2-seanwascoding@gmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260224165435.17648-2-seanwascoding@gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-19185-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[lunn.ch:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,bootlin.com:url,lunn.ch:mid,lunn.ch:dkim]
X-Rspamd-Queue-Id: 9E6D918ACA5
X-Rspamd-Action: no action

On Wed, Feb 25, 2026 at 12:54:34AM +0800, Sean Chang wrote:
> When CONFIG_SUNRPC_DEBUG is disabled, the dprintk() macro expands to
> an empty do-while loop. This causes variables used solely within
> dprintk() calls to appear unused to the compiler, triggering
> -Wunused-variable warnings.
> 
> Fix this by adding __maybe_unused to the affected variables. This
> ensures the code builds cleanly across different configurations,
> including RISC-V, ARM, and ARM64 allmodconfig, as verified in the
> mailing list discussion.
> 
> Signed-off-by: Sean Chang <seanwascoding@gmail.com>
> ---
>  fs/nfs/flexfilelayout/flexfilelayout.c    | 2 +-
>  fs/nfs/flexfilelayout/flexfilelayoutdev.c | 3 ++-
>  fs/nfs/nfs4proc.c                         | 2 +-
>  3 files changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/nfs/flexfilelayout/flexfilelayout.c b/fs/nfs/flexfilelayout/flexfilelayout.c
> index 9056f05a67dc..de9e8bad6af2 100644
> --- a/fs/nfs/flexfilelayout/flexfilelayout.c
> +++ b/fs/nfs/flexfilelayout/flexfilelayout.c
> @@ -1502,7 +1502,7 @@ static void ff_layout_io_track_ds_error(struct pnfs_layout_segment *lseg,
>  {
>  	struct nfs4_ff_layout_mirror *mirror;
>  	u32 status = *op_status;
> -	int err;
> +	int err __maybe_unused;

Sorry, but this is ugly. There must be a better way to fix this.

Maybe look at no_printk().

https://elixir.bootlin.com/linux/v6.19.3/source/drivers/video/fbdev/core/fbmon.c#L50

#ifdef DEBUG
#define DPRINTK(fmt, args...) printk(fmt,## args)
#else
#define DPRINTK(fmt, args...) no_printk(fmt, ##args)
#endif

    Andrew

---
pw-bot: cr


