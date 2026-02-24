Return-Path: <linux-nfs+bounces-19186-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iPwjDC7mnWlDSgQAu9opvQ
	(envelope-from <linux-nfs+bounces-19186-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 24 Feb 2026 18:55:58 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C6AE918ACF7
	for <lists+linux-nfs@lfdr.de>; Tue, 24 Feb 2026 18:55:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0846A303E6BB
	for <lists+linux-nfs@lfdr.de>; Tue, 24 Feb 2026 17:55:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1BC13A9628;
	Tue, 24 Feb 2026 17:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="TsOFVTHF"
X-Original-To: linux-nfs@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 631EC3A7F5F;
	Tue, 24 Feb 2026 17:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771955756; cv=none; b=fV63CPmLEgxLU6QJxdtaTymaiy2zJp7V/8VmrqiKspmtL4jvAboosRyI9EY9RTGP5u4B94p1mf+eJ5xPl1XMtVjVDwZ6Vvn6sgfXKb/smz6RdjhUGSBpw75nIPoIJbqtx6snRFuKVHRWkOHHDuowtNkqsj5O96M3+DGH3wkhUSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771955756; c=relaxed/simple;
	bh=98IuLBbUZjwROztS4gFmszZmMvMreP3SfmF0X5PeUb8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DqW0faxukprhJ67712h+7xqyNYJ/OrlWrwpTX2HOKLhEllgURv1p75e+YikF9ZCh7TgomcO+Fl8Sp+EFakZvlhIjks/mTHGC6bEF97atmeHKnI7PZSPfe36+7YoJyV/hDVUvSGqnf8SgPhRAyeFQs/A5/C1j1P9jViBAgLQB+bU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=TsOFVTHF; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=sd3o1yQOPLA4LCRvfJKT0MuX1lJbSN5LQG5t+uQCyLQ=; b=TsOFVTHFa3hMinSo01EQicgq6L
	1HeI5/nzl5bgK7QHoiQSxwPzSJ9a/BV0XIDwqYOFrvNHbKz4WKRswi7BECg+rpHmvXeCcuju1NpMP
	cfenXb3JL+IrIrO9si7PIeVES9DOjLv4Pi1IXXPWjCdmwhrloApsRQ6xc0fSt975V3gE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vuwdR-008dc0-BI; Tue, 24 Feb 2026 18:55:49 +0100
Date: Tue, 24 Feb 2026 18:55:49 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Sean Chang <seanwascoding@gmail.com>
Cc: nicolas.ferre@microchip.com, claudiu.beznea@tuxon.dev,
	trond.myklebust@hammerspace.com, anna@kernel.org,
	netdev@vger.kernel.org, linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] net: macb: use ethtool_sprintf to fill ethtool
 stats strings
Message-ID: <4cbcc1ba-7850-4dee-b563-22e8ac2ca0d0@lunn.ch>
References: <20260224165435.17648-1-seanwascoding@gmail.com>
 <20260224165435.17648-3-seanwascoding@gmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260224165435.17648-3-seanwascoding@gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-19186-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[lunn.ch:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lunn.ch:mid,lunn.ch:dkim,lunn.ch:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C6AE918ACF7
X-Rspamd-Action: no action

On Wed, Feb 25, 2026 at 12:54:35AM +0800, Sean Chang wrote:
> The RISC-V toolchain triggers a stringop-truncation warning when using
> snprintf() with a fixed ETH_GSTRING_LEN (32 bytes) buffer.
> 
> Convert the driver to use the modern ethtool_sprintf() API from
> linux/ethtool.h. This removes the need for manual snprintf() and
> memcpy() calls, handles the 32-byte padding automatically, and
> simplifies the logic by removing manual pointer arithmetic.
> 
> Signed-off-by: Sean Chang <seanwascoding@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

