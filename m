Return-Path: <linux-nfs+bounces-4708-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B5138929F79
	for <lists+linux-nfs@lfdr.de>; Mon,  8 Jul 2024 11:46:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A7E028876F
	for <lists+linux-nfs@lfdr.de>; Mon,  8 Jul 2024 09:46:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B7B676035;
	Mon,  8 Jul 2024 09:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rAgfpfON"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06A9A48CCD
	for <linux-nfs@vger.kernel.org>; Mon,  8 Jul 2024 09:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720431990; cv=none; b=XjzCVzQgYDLNUngIKUKvPIxTg8wMGi/ey11H2f3vdPwTIf2BmjikdLnhhh5sskrSQabfHez6Xi3sEEX2DuPYfq31UAvIpOBJ0YQnxEjCrKIvfHRi+tViAxmRkxrtIEpi+tTQppQ5q55TD6cadLPUXQ877U8uazolDDiZ68gQNZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720431990; c=relaxed/simple;
	bh=P4ziMl20SrW0eVyx/NAMrDnECQCvjVz91NxZgZYFyeE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=liGeKqJjYW2xAI28BZewD7lMY/ySLnKqjk3TEbiyjxkENkrd2gv8CHqHpvhHYK6HaZsl6qA3SFzs7WLTcv7K5uKoXaacn/WjyjhG0MLg6TLU7f/ShtEXCD0OjHocs172YyDKhcd7jfQx4OQiD3Cszmc68kxe1myGIySGmIAazYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=rAgfpfON; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=jotL4rJNlKkYDLC8bFNtf4GHTaxkMccE2CdS1vborQo=; b=rAgfpfONd2El3qpnh/S9LQfcOP
	2pkRlZnORgLd4fJ5Fc2qFGpO9RBR2BdKiRFH29fyy/0IVpSWDjzhSSUWz8+IfKTpJ2aJuRUblIvcL
	qCAqkS5lN2QTeG3WRbTZKoWJR16fcGzwIc31GqfSAc5XBQkkIgptURCMkcEYNKnxOOphMZn5n8IRt
	2bgsDt/zDamOetptp66RkGK8C8w8PnjAst1yN/ccDyQrotwAwmAJ1H2YNKRhgvBrKQTDw+OIzMl5U
	DwMYzl4Lv3TDqsP1tasMrBdTOUHK2fW3qr8L6jHbj563ceuMTLzhjjZmDOndCVKitHTA5uT0irV28
	xdlYEg2w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sQkx2-00000003M9e-1Tou;
	Mon, 08 Jul 2024 09:46:28 +0000
Date: Mon, 8 Jul 2024 02:46:28 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Mike Snitzer <snitzer@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>,
	Chuck Lever III <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>,
	Neil Brown <neilb@suse.de>, Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH v11 00/20] nfs/nfsd: add support for localio
Message-ID: <Zou1dMVdni9hyPvR@infradead.org>
References: <ZobqkgBeQaPwq7ly@kernel.org>
 <ZoeCFwzmGiQT4V0a@infradead.org>
 <57C1CB2B-3B46-48F3-A095-417845001C3E@oracle.com>
 <ZogAEqYvJaYLVyKj@kernel.org>
 <ZogAtVfeqXv3jgAv@infradead.org>
 <ZogFBqv0z7Rnh4_p@kernel.org>
 <990C712E-99B0-4227-B67D-0DBAA2B2B72E@oracle.com>
 <ZojBAC3XYIee9wN2@kernel.org>
 <Zojc-v8C2ChEOMjq@infradead.org>
 <ZolCzHWhJN-R4Kvg@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZolCzHWhJN-R4Kvg@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Sat, Jul 06, 2024 at 09:12:44AM -0400, Mike Snitzer wrote:
> If you'd like reasonable people to not get upset with you, you might
> try treating them with respect rather than gaslighting them.

Let me just repeat the calm down offer.  I'll do my side of it by
stopping from replying to these threads for this week now, after that
I'll forget all the accusations you're throwing at me, and we restart
a purely technical discussion, ok?

