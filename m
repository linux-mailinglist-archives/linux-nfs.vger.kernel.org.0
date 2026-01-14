Return-Path: <linux-nfs+bounces-17838-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C15B9D1CB04
	for <lists+linux-nfs@lfdr.de>; Wed, 14 Jan 2026 07:36:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1C93E3005330
	for <lists+linux-nfs@lfdr.de>; Wed, 14 Jan 2026 06:36:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0640436C5BB;
	Wed, 14 Jan 2026 06:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HVTl721x"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 916CE34EEE9
	for <linux-nfs@vger.kernel.org>; Wed, 14 Jan 2026 06:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768372607; cv=none; b=QBf68hhd0WUEQlQBdowVS4OyQ2Rfy7u/6Mx1Ocx0SP+bJUWzRX1dE6NEB+HDKM1Xid07nE0kHbTT91cx0HvjkVCxnJrBuK7LjvA8wHgK8tLU7fFUcu2kAV8/iV1tDGroEIQ2pRUAe99ujxHnOocWimwTHBR4i4RgdQLaEpdriO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768372607; c=relaxed/simple;
	bh=gOddiM/RYNEj8xeB5fVgnpB/qfxeFoDvqvp6uHH5XhQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TCeAz8sAgXiwMps7kH1hDuJQNBE2SGrgXWBjhgHjcxT3bnlygawL8JkLgsowDJywvJ8PlmKFWs6CeNSk88S04upd2PsL0rY2wNi3Bnf5yq6+/b7tXqa+meKazmlZRxRfYvreaiUXgA+26qGDZ0f5tw+vvPxZS7RdmeF3op53aSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=HVTl721x; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Dx2HUVtJZRdPfe8OtWpCvhSu3rlECLRjwqsGj7mWx8s=; b=HVTl721xiB9QtjykpHpG5P7dD6
	rN8h23/9xlMXLP8s4dS0lp3i9IhyEr6kcH2TPYPSv3/1DGTLoaG5KykB00LlF8a3N/WCumZ7qjMff
	VfpN9R8FNHzvs9pPclIMa4Lxiv4zUT/Cvzjcg+u27OiUC0oUpO/8a+alhCd8orMWQ3pWvYLtyE8lJ
	F6pcK6xexEiLLDRLm4vkZ7oj11bmKhoTaArOBP7PYYp2Ci83arAbyYw213MGvfNs1u/5TyekZi4eE
	F0M+SpKxWJUfmKM0Xsfv1aysCQrFsEAhtegr5BiXY/fSEXxQP+uUyq7/o0qrfb5q6qm8bFkHPvXXd
	9LFdizbw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vfuUe-00000008868-1xr9;
	Wed, 14 Jan 2026 06:36:36 +0000
Date: Tue, 13 Jan 2026 22:36:36 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Salvatore Bonaccorso <carnil@debian.org>
Cc: linux-nfs@vger.kernel.org, Scott Mayhew <smayhew@redhat.com>,
	Steve Dickson <steved@redhat.com>
Subject: Re: [nfs-utils] "blkmapd open pipe file
 /run/rpc_pipefs/nfs/blocklayout failed" and handling of nfs-blkmap.service
 service
Message-ID: <aWc5dO3fP4J67x0H@infradead.org>
References: <176814099134.689475.12160936392296863650@eldamar.lan>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <176814099134.689475.12160936392296863650@eldamar.lan>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Sun, Jan 11, 2026 at 03:17:24PM +0100, Salvatore Bonaccorso wrote:
> For Debian purposes at least I would like to make things bit less
> irritating for users, keep ideally the service enabled by default, so
> that administraors whant to make use of pNFS setup with the
> blocklayout layout protocol, they just need to make the module load.

The original blocklayout is deprecated because there is almost no
way to use it safely.   So I'd argue for not enabling blkmapd by
default, and maybe even splitting it into a separate binary package.

Note that none of this affects the revised scsi/nvme layouts that are
safe to use, and don't require blkmapd.

