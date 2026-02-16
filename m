Return-Path: <linux-nfs+bounces-18950-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WFTtC5Bjk2ka4QEAu9opvQ
	(envelope-from <linux-nfs+bounces-18950-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Feb 2026 19:36:00 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 71AC4146FF3
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Feb 2026 19:35:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6415B300A331
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Feb 2026 18:35:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0717B2D8393;
	Mon, 16 Feb 2026 18:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="rMFjw5x/"
X-Original-To: linux-nfs@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 764321C69D;
	Mon, 16 Feb 2026 18:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771266954; cv=none; b=aK60TOaSyhHZ06LyN9bz84dIG06qJDasxHL0m3An76tseiIuMsriOaF/xiliOL+0JwF8UXsjcrvXGZAVS+0xJO583sPDKRM3c3cbAxDYY4XT9JhzLvQvBqsSFkNGf9xa3GGOMbkLRcmdY2bOYACMd2yqDg2/LYo4C4ic4ryvTGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771266954; c=relaxed/simple;
	bh=3fOShnHRtTctEnxLf4uBaKv06v/xYArnWQiQOza72HE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GM8TSkrkNWE4RHA2U6dZYYZz83WsSKZlhtDKHpeW+P0iRA+yZqzv37U1F6Se6JoipbfKuGBHPHBHxMSUJx2H/0/n3e3pZEwa6CqJPYyrrPnILrwc2mWwet694Khy7Vc86aTj6mbW7fxLWeN4j/b9DtF1uPLd0hFhDKC/fw5iYdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=rMFjw5x/; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=2ArP2Cz+M7iDMv63GWguZWRJ8Jav2MeuNSfClvG4w+g=; b=rMFjw5x/m1huSnz2IXwb3pjL7/
	BIRW2jFEsOkWaNVq1Y/YPDcj0S3KYYzdYJqQ7s9ExgtGXlp2KYLrNeJ1cHh+te7tYwLJxHkOrFYo9
	t+WCkykS0JsWfkuE3SO1NWULCuMwePIRS1PV6tQ3q+25aHgs40FJLFuVSExNgoOH1knQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vs3Ra-007WxM-OT; Mon, 16 Feb 2026 19:35:38 +0100
Date: Mon, 16 Feb 2026 19:35:38 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Sean Chang <seanwascoding@gmail.com>
Cc: nicolas.ferre@microchip.com, claudiu.beznea@tuxon.dev,
	trond.myklebust@hammerspace.com, anna@kernel.org,
	netdev@vger.kernel.org, linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] net: macb: fix format-truncation warning
Message-ID: <f71cdfa7-25f8-487d-b727-39ae962401a4@lunn.ch>
References: <20260216174950.455244-1-seanwascoding@gmail.com>
 <20260216174950.455244-3-seanwascoding@gmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260216174950.455244-3-seanwascoding@gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18950-lists,linux-nfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 71AC4146FF3
X-Rspamd-Action: no action

On Tue, Feb 17, 2026 at 01:49:50AM +0800, Sean Chang wrote:
> Use a precision specifier in snprintf to ensure the generated
> string fits within the ETH_GSTRING_LEN (32 bytes) buffer.
> 
> Signed-off-by: Sean Chang <seanwascoding@gmail.com>
> ---
> v2:
> - Split the original treewide patch into subsystem-specific commits.
> - Added more detailed commit descriptions to satisfy checkpatch.
> 
>  drivers/net/ethernet/cadence/macb_main.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
> index 43cd013bb70e..26f9ccadd9f6 100644
> --- a/drivers/net/ethernet/cadence/macb_main.c
> +++ b/drivers/net/ethernet/cadence/macb_main.c
> @@ -3159,8 +3159,8 @@ static void gem_get_ethtool_strings(struct net_device *dev, u32 sset, u8 *p)
>  
>  		for (q = 0, queue = bp->queues; q < bp->num_queues; ++q, ++queue) {
>  			for (i = 0; i < QUEUE_STATS_LEN; i++, p += ETH_GSTRING_LEN) {
> -				snprintf(stat_string, ETH_GSTRING_LEN, "q%d_%s",
> -						q, queue_statistics[i].stat_string);
> +				snprintf(stat_string, ETH_GSTRING_LEN, "q%u_%.19s",
> +					 q, queue_statistics[i].stat_string);

These strings are special, in that they are fixed length, 32 bytes
long, and not \0 terminated. There are some helpers at the end of
linux/ethtool.h for dealing with these strings. You might want to use
them.

>  				memcpy(p, stat_string, ETH_GSTRING_LEN);

Also, it looks like stat_string might be one byte too
short. snprintf() will \0 terminate, so you need it big enough to hold
the \0, and then this memcpy() will discard it.

I also wounder, why is just one architecture complaining about this?

    Andrew

