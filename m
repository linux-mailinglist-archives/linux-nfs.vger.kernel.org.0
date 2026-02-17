Return-Path: <linux-nfs+bounces-18963-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6LoSLIzQlGlGIAIAu9opvQ
	(envelope-from <linux-nfs+bounces-18963-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 17 Feb 2026 21:33:16 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3092614FFD0
	for <lists+linux-nfs@lfdr.de>; Tue, 17 Feb 2026 21:33:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F40AE303DF63
	for <lists+linux-nfs@lfdr.de>; Tue, 17 Feb 2026 20:33:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C96E8377556;
	Tue, 17 Feb 2026 20:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="yJ8cJPFD"
X-Original-To: linux-nfs@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FE0C36D4FD;
	Tue, 17 Feb 2026 20:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771360393; cv=none; b=KEFqBk5wci7vrxVhn79RnPaZCLY/iIPJge7lrlOc4mX/Jk8AF1DlH9ly/EsRu9mOx4IaQhyoLGYuqlihkQqVqQwBzuoOqVf8cK04es66wd3AVpwFklvTzBhjv6QPQT5Eju+IMRbXEbHG8Z6zMwZQbrK1s9FaC8Sl2t/xgdrILjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771360393; c=relaxed/simple;
	bh=43B6XmtzDGAWF3Xd6saMMFffYNdk83aSU20f6R+Xc/0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d8ssQ5Whj4sBIpoRrzaOzDcVIGAN+aNL1BNDLjtxLxcCCNoP7JYpNFBwerCPKExExENGr8ThIyaBgLFNqQpvUQikEyBOnlPrEQZtMoGi55TWMJSP/Lw/jEeb/zWckU19et2J0kL2KPFYsF7ThEkyZ7cXLF1Ly/C0z9VYhTWesRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=yJ8cJPFD; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=bJHG+po9PhXw7VdzEGhe39mL295EOkH8AvwSWrIOACM=; b=yJ
	8cJPFDYgpQMDMAD9Vo1Ep/qF2qtfkzmKDBwNXEXAt0WSom8cnEw0KWc4b3rjN1o5jEvBLbnf/O/WJ
	b/wiwHB/C5liNarkPE2E8O0XAHMcxZhX6SB4N8LzZ8mtzPkP5hVZbrevIDjIchJc+6uD2fwcNBwYq
	w3ehYE2NWoQbs5Q=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vsRkl-007gbs-P8; Tue, 17 Feb 2026 21:33:03 +0100
Date: Tue, 17 Feb 2026 21:33:03 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Sean Chang <seanwascoding@gmail.com>
Cc: nicolas.ferre@microchip.com, claudiu.beznea@tuxon.dev,
	trond.myklebust@hammerspace.com, anna@kernel.org,
	netdev@vger.kernel.org, linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] net: macb: fix format-truncation warning
Message-ID: <a7c960af-ad60-4aef-93ef-f79657dbe4e5@lunn.ch>
References: <20260216174950.455244-1-seanwascoding@gmail.com>
 <20260216174950.455244-3-seanwascoding@gmail.com>
 <f71cdfa7-25f8-487d-b727-39ae962401a4@lunn.ch>
 <CAAb=EJWNSvTHuUX862vLmA2s1uKO0vy_x9OSZ6VXqY9X-+JNsg@mail.gmail.com>
 <00ebdd77-d6ef-48f2-a25d-8d8b3c7dc7a8@lunn.ch>
 <CAAb=EJXQjraL=VEod0N8Pm5tuQ5UE9UbrdxdZQ+ArKVhDUT83w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAb=EJXQjraL=VEod0N8Pm5tuQ5UE9UbrdxdZQ+ArKVhDUT83w@mail.gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18963-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,lunn.ch:mid,lunn.ch:dkim,lunn.ch:email]
X-Rspamd-Queue-Id: 3092614FFD0
X-Rspamd-Action: no action

On Wed, Feb 18, 2026 at 03:14:08AM +0800, Sean Chang wrote:
> On Wed, Feb 18, 2026 at 1:46 AM Andrew Lunn <andrew@lunn.ch> wrote:
> >
> > Given the other patches in there series, i have to wounder, is the
> > diagnostic analysis correct? Or is the RISC-V toolchain buggy?
> >
> 
> I retry the different methods, I found that when I directly compile
> the macb_main.c, it can trigger the same error, and I already prove
> the different compiler will reach the same result, so it is not a bug
> of the compiler.
> 
> I also found that the x86_64 defconfig does not enable CONFIG_MACB
> because it requires CONFIG_COMMON_CLK (which is also disabled by
> default on x86), whereas the RISC-V defconfig has both enabled.

arm and arm64 are much more similar to risc-v than x86. You should
test with those compilers. However, make allmodconfig will get you the
common clk code on x86. Most build testing is done with this
configuration, including the netdev CI.

> > I do agree ethtool_sprintf() is better. But we want the commit message
> > to reflect why we are making this change. Is it because
> > ethtool_sprintf() is better, or are we working around toolchain bugs?
> >
> 
> according to the content I mentioned upon, I think the commit will
> something like "ethtool_sprintf() is better to prevent data truncation
> and properly fill the 32-byte ethtool string boundary.'"

O.K.

	Andrew

