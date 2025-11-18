Return-Path: <linux-nfs+bounces-16483-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D3F1CC6979E
	for <lists+linux-nfs@lfdr.de>; Tue, 18 Nov 2025 13:52:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 92E422ACF8
	for <lists+linux-nfs@lfdr.de>; Tue, 18 Nov 2025 12:52:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D0DA25485A;
	Tue, 18 Nov 2025 12:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OuJk0wgd"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB6071FE44A
	for <linux-nfs@vger.kernel.org>; Tue, 18 Nov 2025 12:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763470330; cv=none; b=lAHVDS7JI66EsEPovH03LBdmb4xDvN204GmxpRPk6BSEsuKqlJZqjD9jacHyq+ZMJ6E4mE8etQIPIypYxqmT2y3EW0LzaWQozLya6YWMQ8XBLOfpmxDDR2ZxM8KVWhh1jQVTiiG/tYJ672Vq97i3/SfWH7Kf7nnaELrY3beC0oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763470330; c=relaxed/simple;
	bh=luI4WKqJYNdFKP19bJvHtc2JpuVl/pMU7Yt03k9f8cA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F4nEixODEmkYqEHIxoWsk9xa0pXrda6VHuPdfT1YMBstxLRST63ejuRBpaG2idA/MHddurUnIM2ounG7VrWqXMxWE7uYVCbBeXxTpGBm+FERTzk0+o2SKZr1jKcDHD+59+uvZyr1Cnx6gQQHZWNyW6d0plSdybKgk0FWEJ5Lfpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=OuJk0wgd; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Transfer-Encoding
	:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=m9+rDdJgk42uYMdlnChTSOtOPuJj5EyxsryA0lCExfk=; b=OuJk0wgdjfR3PyN+DhFlSxeKIC
	UqfFzFk62cHnPWOIzSgLc0ARAlbfYSD+RZwxbBLOffL0Qzw2Vk0n7XzmzMUPHqngaUsAWZYXHf9+b
	gMMrHBS3peHs7WNkdkzvcBTyu25FRJFTVV2AoUl1sNbxPelD0hd/pSt+LNgoKtGiRM07voog3LR55
	mtskrFTP9QQfxTI1Bmk+1xDa8+5O5kAIin1it6NeCW44+3VEL88OSe1jsL5x3wdmI39gZMNJSbdFH
	K25qmS4UGYk0hHd980yodAPaBnrcxosg3NXnFDrx1euaLwpAAyrneiu6G/FbxDAxo3XPCmLIFnjeM
	r5LS477w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vLLBm-00000000RYy-3HCE;
	Tue, 18 Nov 2025 12:52:06 +0000
Date: Tue, 18 Nov 2025 04:52:06 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: =?iso-8859-1?Q?Aur=E9lien?= Couderc <aurelien.couderc2002@gmail.com>,
	linux-nfs@vger.kernel.org
Subject: Re: FATTR4_MODE_SET_MASKED support in Linux nfsd?
Message-ID: <aRxr9sTi7GrUlPEI@infradead.org>
References: <CA+1jF5pYFVb0=ToyPtGrtPYoZds1=mpHCZaFFR5hS-AfbP_RDg@mail.gmail.com>
 <e37a9b324b818191ed31d27adfeb9328924b2bff.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e37a9b324b818191ed31d27adfeb9328924b2bff.camel@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Nov 18, 2025 at 07:30:00AM -0500, Jeff Layton wrote:
> On Tue, 2025-11-18 at 10:32 +0100, Aurélien Couderc wrote:
> > Does the Linux nfsd support FATTR4_MODE_SET_MASKED?
> > 
> > Aurélien
> 
> No, not currently:

And Aurélien really needs to learn the basics of grep or code search
in general.


