Return-Path: <linux-nfs+bounces-19423-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OPupE1jBoWkVwQQAu9opvQ
	(envelope-from <linux-nfs+bounces-19423-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Feb 2026 17:07:52 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 05C931BA8CB
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Feb 2026 17:07:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 63B303083CCD
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Feb 2026 16:00:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5BE544B695;
	Fri, 27 Feb 2026 16:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="4Heaodxu"
X-Original-To: linux-nfs@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADAEB44B68E;
	Fri, 27 Feb 2026 16:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772208024; cv=none; b=reIbf0KLvabRG4RuGYAgo+npNeX391Ltn6RMidlSUQQGDewTAmUhwTW3bKUntFYHLNsRY9dRNlXs1kdF1J+kly88KAO/EolHLdvdb5ljJZ9gCHC0YmxS7LRZBJAqNh8BfdVLlCSOkPSEE1tYIFvnz/PQ9rOPRIweXpXQeUw/Xd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772208024; c=relaxed/simple;
	bh=dPA+WXcY7sGuPINjzI6FReh02wYffVjtqFc7RwoNWyo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s4W6vBYFCXFH/h5xmPuGbdKX8ToeLJxVzrYGTiTzGVMECy1NL4Y+wgsr/dkezT8Nh2H/ISmpUrVUajMpqk1XU0dbbdsf11lGAUuifCHH2S4FS1mpbm8Ta3CYexbxrKclMaKqzoa3R9UDFPoAgSp2S+cmYBRCFaP0DgTuQ1usifU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=4Heaodxu; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=SPbtJfAuFczarejQRcybinbapZA+VaGJ2yNWkwdMtwM=; b=4HeaodxuYe+xrWO6pSwj6FR2Qj
	IB5PpyM55uhu9alpnqhw2F92Cc9uWePiQIxoVMSOjoYd9xgMyoprIjm7m/j2lNXDrICBib+PgIsXz
	HRDEvGt+G7EELHF4xTPgdHSZyZfioYtCTLPJ/Z0/x1Tdtl/79L+6AHgz0ignlRsOSYHQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vw0GD-0095kB-HK; Fri, 27 Feb 2026 17:00:13 +0100
Date: Fri, 27 Feb 2026 17:00:13 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Sean Chang <seanwascoding@gmail.com>
Cc: nicolas.ferre@microchip.com, claudiu.beznea@tuxon.dev,
	trond.myklebust@hammerspace.com, anna@kernel.org,
	netdev@vger.kernel.org, linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] sunrpc: fix unused variable warnings by using
 no_printk
Message-ID: <2e9b78ad-a31a-400b-b1dc-f90eee9e6e33@lunn.ch>
References: <20260227152624.164964-1-seanwascoding@gmail.com>
 <20260227152624.164964-2-seanwascoding@gmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260227152624.164964-2-seanwascoding@gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-19423-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[lunn.ch:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,lunn.ch:mid,lunn.ch:dkim,lunn.ch:email]
X-Rspamd-Queue-Id: 05C931BA8CB
X-Rspamd-Action: no action

On Fri, Feb 27, 2026 at 11:26:23PM +0800, Sean Chang wrote:
> When CONFIG_SUNRPC_DEBUG is disabled, the dfprintk() macros currently
> expand to empty do-while loops. This causes variables used solely
> within these calls to appear unused, triggering -Wunused-variable
> warnings.
> 
> Instead of marking every affected variable with __maybe_unused,
> update the dfprintk and dfprintk_rcu stubs to use no_printk().
> This allows the compiler to see the variables and perform type
> checking without emitting any code, thus silencing the warnings
> globally for these macros.
> 
> Suggested-by: Andrew Lunn <andrew@lunn.ch>
> Signed-off-by: Sean Chang <seanwascoding@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

