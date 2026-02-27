Return-Path: <linux-nfs+bounces-19427-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mEOtF4XeoWlcwgQAu9opvQ
	(envelope-from <linux-nfs+bounces-19427-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Feb 2026 19:12:21 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B6FCD1BBD2B
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Feb 2026 19:12:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 75C06321623A
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Feb 2026 17:59:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0196E374170;
	Fri, 27 Feb 2026 17:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="YCVfAgjx"
X-Original-To: linux-nfs@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 791B836E49F;
	Fri, 27 Feb 2026 17:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772215063; cv=none; b=C6wnnunA/uIxTVlFR1/xhe0rGmnllY5FPNFyaGwm77uo6mxTwVDK8EtddIh006iOjB6xHBJYM8AH7yt8iNHOs7zQoOHoKNpIo6Un2BhjkNmisD0XxjdyMkSGhyqKJ6opjtF5XeEtNVc541FVYtRsRq5lfejr39gEUrHNDpvA5jI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772215063; c=relaxed/simple;
	bh=usi2T1T0YOcyvYYWRmpM5fXC2gZIndsaCukB3jZXCM8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AjevEjYRDwEFVXA8f5fNGxuLTT1SH3mJDxwb6VMtk5iNcDeo6wc7EvRPUYiKFOiZjE4pS9WP0iAzhHyL+7okU7TZMCl5Fc6tgYbpzVluwYB3SPFG7hJ5U/UuEG41Q2xSEUWaFilBN0QRfqIWvu4euUQPjrQUC7ORB+6xxdiPbG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=YCVfAgjx; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=xtNLhO3XR3oV2Dg8dW6Z6wAcwkVPtwzyNqvQOj//EJU=; b=YCVfAgjxNc3t8ZeB6o1p7V79Z/
	jblSR+cvPHm8tbkd39xd22HfJ/dYamuSDFeNL55q6WWlaVofK4rn3zApyiKAaXc67rE3NWeUTeTHi
	zUKMDW4sWHpWBDorfKUpX+bUCFDS/u3tDOxMPPbm36bX4iO90mhMXN70d7OZal40nAG4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vw25l-0096S6-K8; Fri, 27 Feb 2026 18:57:33 +0100
Date: Fri, 27 Feb 2026 18:57:33 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: David Laight <david.laight.linux@gmail.com>
Cc: Sean Chang <seanwascoding@gmail.com>, nicolas.ferre@microchip.com,
	claudiu.beznea@tuxon.dev, trond.myklebust@hammerspace.com,
	anna@kernel.org, netdev@vger.kernel.org, linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] sunrpc: fix unused variable warnings by using
 no_printk
Message-ID: <c28cbfc2-208f-47db-9c5a-21b54b2be8c1@lunn.ch>
References: <20260227152624.164964-1-seanwascoding@gmail.com>
 <20260227152624.164964-2-seanwascoding@gmail.com>
 <20260227173814.2f928556@pumpkin>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260227173814.2f928556@pumpkin>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-19427-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[gmail.com,microchip.com,tuxon.dev,hammerspace.com,kernel.org,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lunn.ch:mid,lunn.ch:dkim]
X-Rspamd-Queue-Id: B6FCD1BBD2B
X-Rspamd-Action: no action

> >  # define ifdebug(fac)		if (0)
> > -# define dfprintk(fac, fmt, ...)	do {} while (0)
> > -# define dfprintk_rcu(fac, fmt, ...)	do {} while (0)
> > +# define dfprintk(fac, fmt, ...)	no_printk(fmt, ##__VA_ARGS__)
> > +# define dfprintk_rcu(fac, fmt, ...)	no_printk(fmt, ##__VA_ARGS__)
> 
> You can omit fmt, then you don't need the ##
> #define dfprintk(fac, ...)	no_printk(__VA_ARGS__)

/*
 * Dummy printk for disabled debugging statements to use whilst maintaining
 * gcc's format checking.
 */
#define no_printk(fmt, ...)				\
({							\
	if (0)						\
		_printk(fmt, ##__VA_ARGS__);		\
	0;						\
})

Without fmt, gcc cannot do format checking. Or worse, it takes the
first member of __VA_ARGS__ as the format, and gives spurious errors?

      Andrew

