Return-Path: <linux-nfs+bounces-13178-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C0548B0D14A
	for <lists+linux-nfs@lfdr.de>; Tue, 22 Jul 2025 07:37:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B0601C20C4E
	for <lists+linux-nfs@lfdr.de>; Tue, 22 Jul 2025 05:37:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 586BE28851A;
	Tue, 22 Jul 2025 05:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="45yhPr5b"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 624741FF7D7;
	Tue, 22 Jul 2025 05:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753162622; cv=none; b=lXeheY9P5/Yxw4MZawoFY92iqR6x3TjO3q4sqqR8wcJp8FTXydPD3A++WW5QDgB5KD+VMPTOEFJD36vhQbMclZ0BezFzBWSOlJ5o27yY2auJxIZCIkz/my9Cq3G53vVsFZ3NjXdBtE4YR8NIYgKUChQh4owSnwsMiHazaUl4f/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753162622; c=relaxed/simple;
	bh=25d8HOgf582gUD8u5/RMkWEY6RdKvLTd/Cm2RBZgT8A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i9MnSoGTCNk1kQu/U+lQ+KamzcXbZDEan68yyjI22nFXle2hGHs85G5Qlq5/5Pvj2TB2C5a79w6vDQZ2ktAJRkRj/gEZEjLjfGjklwPr6ZXzvdT5JFvDtKOhv6ofKoCS4O2Iv2YTJNQO1kF0jvrGQ/IUNGfKgYt90QgHMQMj7d0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=45yhPr5b; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=25d8HOgf582gUD8u5/RMkWEY6RdKvLTd/Cm2RBZgT8A=; b=45yhPr5bR22O1qTH4U3XG4owkV
	Nz/XGJIBoitMMgSvFfM3TZ9boxlcHUBbbuAuKRGR26YgHWvXrNAly+5RPKren6NPtSaTQjjnZOlGJ
	a74qK0x9ps69g3jFzLjKyRlg7UT/88EANjZoCY80X9Et0bB9v/rJA7i24lpzvEOP1bbvKF1EhCfOa
	pLFf/vXtEmhhL6LJFPyYx99hjkPJF1+IUTC8L3UR8qtFhE9XXKzU/IX/WpfGgbSpTBaJtEatXvPgs
	hXmao2UkcmvsdK+WjnAWYvK/PXBsz0/rHDPwKWedHTdAw1lXrxonuJ7NE8PdV0seoWSv27CutE3gQ
	uc20J2Mw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ue5gO-00000001LYz-2q3H;
	Tue, 22 Jul 2025 05:36:56 +0000
Date: Mon, 21 Jul 2025 22:36:56 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Sergey Bashirov <sergeybashirov@gmail.com>
Cc: Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>,
	NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] NFSD: Rework encoding and decoding of nfsd4_deviceid
Message-ID: <aH8jeNFJFuxCugKZ@infradead.org>
References: <20250721145215.132666-1-sergeybashirov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250721145215.132666-1-sergeybashirov@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Jul 21, 2025 at 05:48:55PM +0300, Sergey Bashirov wrote:
> Compilers may optimize the layout of C structures,

By interpreting the standard in the most hostile way: yes.
In practice: no.

Just about every file system on-disk format and every network wire
protocol depends on the compiler not "optimizing" properly padded
C structures.


