Return-Path: <linux-nfs+bounces-18961-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id E7KYG5eplGl7GQIAu9opvQ
	(envelope-from <linux-nfs+bounces-18961-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 17 Feb 2026 18:47:03 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1932414EB92
	for <lists+linux-nfs@lfdr.de>; Tue, 17 Feb 2026 18:47:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8EC793033278
	for <lists+linux-nfs@lfdr.de>; Tue, 17 Feb 2026 17:47:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7466033CE80;
	Tue, 17 Feb 2026 17:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="iJO4nic4"
X-Original-To: linux-nfs@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EE0D259CBD;
	Tue, 17 Feb 2026 17:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771350418; cv=none; b=md53slAJLa1MJ18iAvunyUWH99t60beAp91UDaKgNm7fqKSglog5JnShwKBxBDKtINX4aQaiisT+7nnZCefeNufR6HQfQ4QKn2M3G/oKZTmEBEfbjSrpwSuDy6VPcSX4q9bDNgd1msJl1CGLdP5mroYJw9bkKlu1QMgMPckAhV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771350418; c=relaxed/simple;
	bh=/YOvvGm5oBmVJ+yh9mfJfOeXrCW7z2EefpQ61ojKo4M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D1WKL/gB7aI8yWktF9VE4QkW2kwOJPLxr2LXvvFmHm7+PxRp6szuC9t1f5UQyS/QtzVC1mDKXCUoEfISbtoJw5uE4wdXitAlC4Cxw8Y7WRAp6oKyd0sxgaWN1USV39mId36cya76Rw+IhgfddEySiTbltYHvjRVBr78NPov9iik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=iJO4nic4; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=x+IMn6ekNyuPUJq7ANKTeXzNCQrAnc/yvZ6lcfaucaE=; b=iJO4nic4vu9Ma78zZn3OSVlf8+
	evgOVNOyWxAV2rQr1GMnR4ch47xfoeHNnfrqxi76PoGpBdzgNLnYMEzNn5cHMQttRBtUqcpWtbjmk
	uBukBZizwQWptKTyrNsjYzU3utsFOF5xKi1A8yLJjP4lYm3ssBEzlZdYDRz62ieMBBNA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vsP9r-007fho-KE; Tue, 17 Feb 2026 18:46:47 +0100
Date: Tue, 17 Feb 2026 18:46:47 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Sean Chang <seanwascoding@gmail.com>
Cc: nicolas.ferre@microchip.com, claudiu.beznea@tuxon.dev,
	trond.myklebust@hammerspace.com, anna@kernel.org,
	netdev@vger.kernel.org, linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] net: macb: fix format-truncation warning
Message-ID: <00ebdd77-d6ef-48f2-a25d-8d8b3c7dc7a8@lunn.ch>
References: <20260216174950.455244-1-seanwascoding@gmail.com>
 <20260216174950.455244-3-seanwascoding@gmail.com>
 <f71cdfa7-25f8-487d-b727-39ae962401a4@lunn.ch>
 <CAAb=EJWNSvTHuUX862vLmA2s1uKO0vy_x9OSZ6VXqY9X-+JNsg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAb=EJWNSvTHuUX862vLmA2s1uKO0vy_x9OSZ6VXqY9X-+JNsg@mail.gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18961-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lunn.ch:mid,lunn.ch:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1932414EB92
X-Rspamd-Action: no action

> Regarding the architecture-specific nature of the warning: I have verified that
> this warning is not triggered on x86_64, even with W=1. It appears to
> be specific
> to the RISC-V toolchain's diagnostic analysis.

Given the other patches in there series, i have to wounder, is the
diagnostic analysis correct? Or is the RISC-V toolchain buggy?

> Regardless, converting to ethtool_sprintf() is the correct approach
> which does not throw any warning on the both platforms.

I do agree ethtool_sprintf() is better. But we want the commit message
to reflect why we are making this change. Is it because
ethtool_sprintf() is better, or are we working around toolchain bugs?

	Andrew

