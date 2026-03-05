Return-Path: <linux-nfs+bounces-19795-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OF80FrKQqWkSAAEAu9opvQ
	(envelope-from <linux-nfs+bounces-19795-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 05 Mar 2026 15:18:26 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BB136213222
	for <lists+linux-nfs@lfdr.de>; Thu, 05 Mar 2026 15:18:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B8AC130210E6
	for <lists+linux-nfs@lfdr.de>; Thu,  5 Mar 2026 14:18:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5296181724;
	Thu,  5 Mar 2026 14:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="seNtH8CH"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52D2C3A1CD
	for <linux-nfs@vger.kernel.org>; Thu,  5 Mar 2026 14:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772720297; cv=none; b=dgY8FCgQcQTKQOO+mf/ELOzh7JVd9Dq7X1g8Hka4GCdF7857WdMLSqRfiSvbu1iAkQY17dyYPFHNb/Lh81IzAlNxLNeMdlyfX0ogaPGXMxRXzZO5UDnvbAAbgssCCaOZvldZnTfosynvqQHwQG0U21GoWEaYY+bcmZIcIcXokjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772720297; c=relaxed/simple;
	bh=PGMJLZg/uaS/YvjvztAkJanOzVG/LKjC09RAcC/MLH4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ulfLYpy3Phoh1ulRXti+5jhj6y789lqYz1qjNZbqQ+cznFCGM/DOqJN6G8FRxrCG+YIsgfj9w/M+jBKVQcJ2a9uMz74Qf0IAJjz8rTAMnBKahoO3a8/4QqxlPSG86w9qoAIVuAlmL/qdKZYbe/6MYKZ1P2X0IP7sbHzZN8PwEqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=seNtH8CH; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=6dkw7FHbJG5BFbVLjaaEK25FZfTzNvSAZZCByXREpcg=; b=seNtH8CHAKeyJuS/llyMYfko+t
	7Cc0tMLvIiqaBleWSrmh8Uk6LOsUi58iT3Q9jfu30SymvdhmloASxYR+6kwCw+miqF/o/IimpxqFa
	nWY9/f6uD8zPMwTXMiN6k4gqNMxjfEligZS0pnqRCYn9F9V6ce3i6MrsRCCvEyKbujro/U4RXcM+E
	GZilLDc5bwqnNeYid5kIOO3TEImoNdISuaz7w845Qfc37o29lZvzTf6NDk9R69MVxRMCGK5n1IgjG
	1MQ4AIHmd6IVfKce9KnjTpwVuIOCnQzUk1dSEJvje4yxbxQQ6KOfAJIjNlRNIyGMp0dzw6kSckFFD
	EBGf0mjA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vy9Wq-00000001w15-03iF;
	Thu, 05 Mar 2026 14:18:16 +0000
Date: Thu, 5 Mar 2026 06:18:15 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Dai Ngo <dai.ngo@oracle.com>
Cc: trondmy@kernel.org, anna@kernel.org, linux-nfs@vger.kernel.org
Subject: Re: [PATCH v2 1/1] pNFS: Serialize SCSI PR registration to avoid
 reservation conflicts
Message-ID: <aamQp47da-soFtuB@infradead.org>
References: <20260304194931.2592156-1-dai.ngo@oracle.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260304194931.2592156-1-dai.ngo@oracle.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Rspamd-Queue-Id: BB136213222
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=bombadil.20210309];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[infradead.org:+];
	TAGGED_FROM(0.00)[bounces-19795-lists,linux-nfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@infradead.org,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,infradead.org:dkim,infradead.org:mid]
X-Rspamd-Action: no action

> -	if (test_and_set_bit(PNFS_BDEV_REGISTERED, &dev->flags))
> +	mutex_lock(&dev->pbd_registration_mutex);
> +	if (dev->flags & BIT(PNFS_BDEV_REGISTERED)) {

dev->flags can now become a simple unsigned int, and you can
define PNFS_BDEV_REGISTERED as an actual value instead of using
BIT everywhere.

Otherwise this looks good.


