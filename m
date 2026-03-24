Return-Path: <linux-nfs+bounces-20344-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sCHiDy4YwmkgZgQAu9opvQ
	(envelope-from <linux-nfs+bounces-20344-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 24 Mar 2026 05:50:54 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 88157302160
	for <lists+linux-nfs@lfdr.de>; Tue, 24 Mar 2026 05:50:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 37EE33042B6C
	for <lists+linux-nfs@lfdr.de>; Tue, 24 Mar 2026 04:50:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51589274B4D;
	Tue, 24 Mar 2026 04:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="GMGmbIq9"
X-Original-To: linux-nfs@vger.kernel.org
Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5B44241690;
	Tue, 24 Mar 2026 04:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774327851; cv=none; b=W4lpA4xHvUAjE8A9rH6OkAI7UYN7dGg2ly5XuUDZfwP6WEzcJZSllqFFcCDK2iTOuBXtl3fJzVeYb2tOXHsJvFzsiHqJJrpBB5fK3f1Tupmig6Bov4+0rL6xAfRm7Fqjj4/C/2a2BGWAv7HHuYTqbPrUPlh1BBtwF6/Ds82EKWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774327851; c=relaxed/simple;
	bh=DiB0f7hBkm4xTl0rCXcgjzj3hVLAwEfZ1qgUHaZNGgE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q2fP+5W9MzhqII8xZ+1q0TS7dTR1LIVlp7wrdMFdeK4eUYDeJ1Z/JaeYz0rpJBVfJgql5n0gzMrL3mijHjW1frPnuszLU5AyaVeLyIXSgVt4d+ZcX4nUhr8ZKjfy7XJHTNV5ECmLXsr+CYirRXwzzHEdUaw7ynyppGz517ynb78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=GMGmbIq9; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id 711FC14C2D6;
	Tue, 24 Mar 2026 05:50:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1774327839;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AywlPwBr7VbBdaTZBe7nUDkqgnRgV0ycrC7PoFcyewk=;
	b=GMGmbIq9QBV7dHSUbUKsyAs7J7UJP3XKLoQD/dixlUxixPk8cWtrjhw+K5uzUgEim7Kjvb
	XOsiu77UVEfk6en6P4kNtvMtNqSTWroJQOnQ1TTOJryRuWZi6PcNlM84e78Fiep/LXtTaU
	cgB4eA+SVIA23pKAAwl4c1DvathaMMGPCyKAsI/OBwzl/DkrvpiORbyPJVP+htGzBVoSPg
	SzFm2CnWxx6oPtFdhKZfsuUK6g0vck8ajPuzbtHhXI7tU/h34G1qSm+IjfOL1v2pjzeuw1
	ReM6EQvJtmBDJx6Zt6PTBTMIzKE5eSI00+LO1BU/WuwHwMEcbb6ZrCzRQihVIA==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id 47767c77;
	Tue, 24 Mar 2026 04:50:33 +0000 (UTC)
Date: Tue, 24 Mar 2026 13:50:18 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Eric_Terminal <ericterminal@gmail.com>
Cc: Simon Horman <horms@kernel.org>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, v9fs@lists.linux.dev,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Nikolay Aleksandrov <razor@blackwall.org>, bridge@lists.linux.dev,
	Anna Schumaker <anna@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH v2 0/4] net: replace deprecated simple_strto* parsers
 with kstrto*
Message-ID: <acIYCkdaaXPRreZA@codewreck.org>
References: <20260225010853.15916-1-ericterminal@gmail.com>
 <20260225033840.33000-1-ericterminal@gmail.com>
 <aaRbWCeu-wNdWGzB@horms.kernel.org>
 <CAKNPVZA2sFv7k=wyf5iBGyOUQcHkAdpVLVNjuqr+7XBXDKxNbg@mail.gmail.com>
 <CAKNPVZAtH59NRqDscaBPgFYhxOB=KzTY=Y+FA9WBkDo_um33tQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKNPVZAtH59NRqDscaBPgFYhxOB=KzTY=Y+FA9WBkDo_um33tQ@mail.gmail.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[codewreck.org,none];
	R_DKIM_ALLOW(-0.20)[codewreck.org:s=2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20344-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[codewreck.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[asmadeus@codewreck.org,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,amd.com:email,codewreck.org:dkim,codewreck.org:mid]
X-Rspamd-Queue-Id: 88157302160
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Eric_Terminal wrote on Tue, Mar 24, 2026 at 12:27:50PM +0800:
> Hi Simon and maintainers,
> 
> Just a gentle ping on this patch series.
> 
> Following up on my previous email regarding the testing methodology
> (using virtme-ng, verifying the Oops fix in Patch 1, and confirming
> the strictness of strsep + kstrtouint).
> 
> Does the provided testing information address the concerns? Please let
> me know if there's anything else I should clarify, or if a v3 is
> needed to move this forward.

Part of the problem is that you've mixed a semi-complex 9p patch with
other net patches, I think it'd be easiser to move forward if you'd
split this (I can't take non-9p patches, and I'm not sure the -net tree
wants the 9p patches as we're a small world appart sometimes...)


For 9p, I can't (easily) test xen, so I'd appreciate if you could resend
with Stefano Stabellini <stefano.stabellini@amd.com> in Ccs as he has
been looking after this transport; I can have a quick look but don't
have the time for a proper review

Thanks,
-- 
Dominique Martinet | Asmadeus

