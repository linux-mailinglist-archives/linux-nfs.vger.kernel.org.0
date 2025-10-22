Return-Path: <linux-nfs+bounces-15508-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 21B88BFB978
	for <lists+linux-nfs@lfdr.de>; Wed, 22 Oct 2025 13:18:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 240DC19A18F1
	for <lists+linux-nfs@lfdr.de>; Wed, 22 Oct 2025 11:18:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7965732E74A;
	Wed, 22 Oct 2025 11:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="d9dgilan"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5F0F339A8
	for <linux-nfs@vger.kernel.org>; Wed, 22 Oct 2025 11:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761131882; cv=none; b=qnvIZBh/vgG0aGFS50v2R6P81cGeVLPK9jJd+P+GTnDg8wk1IMMU+pwV7TZh9G49MOCzz1pwHiMd2w/OLT8ve3bwKnPKdpEFW95g0+c5DZC3xVqm82qsERZSrtrUmD2pA/fc90yUShLTDji3G5YsV2QkNUBqSEWmmzLXexfRRDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761131882; c=relaxed/simple;
	bh=4HqLHGPLDY1DNEX4Ff2d4AQFWEOeQnQF1Yqsnf4KDbs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L2cgKD/IbSR/Pt22sk3jK7w8A9VDc1RZ2gHjxGTWgc7TWcPArlCqpENHvFwrhgENB5J6jQzV0DK9oBX+sGTQz/z2g6aTQTm9douOx1AwNicaMAwspy2qQpnfnP2rjX6EvL/nLS8OAmx0zbL7lrcXN18mqwLudr6INrjVchasgfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=d9dgilan; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=mCffRK2PUwrNqXHxelp3tc71Mmymc8MJR9C74MpMwyw=; b=d9dgilanaLealda45VKfrJubrB
	xGiwOPkrEp+dqX9iQtQyh3xK2fz6fxEz6RP0qsvDKef1EPOhNJHImfzJdFKzLFwPRc7EUXRbd8RrH
	HDdUoMkRc063Hw2weV42Xt5SeDgPmANwAAQbwNhmcMsI1TAuJj/2ithlVt3seaY8ote0ExBc8M84+
	N+flF3lwQYC639hADSdRDutKfFLlBWMnpMfJ6/aEFjC49FqrjgExaFNXo727I2jDzICCOdjZ9VXV+
	uzPYU9dphhrZIltg9bzoXpafyQq+T9L/pUAfac3wsYF4y/7a9lUWDS/vzkPFvuYyPte7uMe4+Ky+W
	PvxOMInA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vBWqq-00000002cdk-1qe6;
	Wed, 22 Oct 2025 11:17:56 +0000
Date: Wed, 22 Oct 2025 04:17:56 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, Chuck Lever <cel@kernel.org>,
	NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org, Mike Snitzer <snitzer@kernel.org>
Subject: Re: [PATCH v4 2/3] NFSD: Implement NFSD_IO_DIRECT for NFS WRITE
Message-ID: <aPi9ZE96CYQFk5qC@infradead.org>
References: <20251018005431.3403-1-cel@kernel.org>
 <20251018005431.3403-3-cel@kernel.org>
 <aPXihwGTiA7bqTsN@infradead.org>
 <a5f3911ae6b65c70e1fd897bdd4f3e651decb196.camel@kernel.org>
 <aPhoow9Z-r94b5AL@infradead.org>
 <63a440d869e3f8a9ecf13537e2da6c6439933ed1.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <63a440d869e3f8a9ecf13537e2da6c6439933ed1.camel@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Oct 22, 2025 at 06:15:44AM -0400, Jeff Layton wrote:
> Cache coherency. If the timestamps roll back, some clients may not
> notice that data has changed after a write.
> 
> It's not the end of the world -- non-evident timestamp changes were
> typical prior to the multigrain timestamp patches going in, but it's
> not ideal.

Well, in that case nfsd_vfs_write needs to use IOCB_SYNC as well.
And both that and this code need a big fat comment about it.


