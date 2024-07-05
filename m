Return-Path: <linux-nfs+bounces-4636-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 76B6A9289E5
	for <lists+linux-nfs@lfdr.de>; Fri,  5 Jul 2024 15:39:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31F5D2837B8
	for <lists+linux-nfs@lfdr.de>; Fri,  5 Jul 2024 13:39:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB8EF13CFAA;
	Fri,  5 Jul 2024 13:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="aJhFEtpr"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4670613C8F9
	for <linux-nfs@vger.kernel.org>; Fri,  5 Jul 2024 13:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720186744; cv=none; b=e6Ps+CO9S0dVfqvunURLPJZJe0MHYTyj/ynp6pKzLmrebSm/VRRNZRMWK1I2xFE7Ht1KwipfDvLh0DHWyKOOZKveNwALTCqdHC/zxI355ewH82kcteWI2kJRlPwzPLIwoV+to3eBUIlMEBzRUiVzvIiKDUsi1Bb4EDa2U4dlciw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720186744; c=relaxed/simple;
	bh=9bXHFty0OfxLO+kYEneXjFYDhsYjcWWiXZSDsOX1yek=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AzPgdo6SWmO1F2uDXJrHIKlg0bdLgVfV9YMBPpaInytuzdLGm/ZgTKcAO9hnGEuszt3SAlYUj50lUUf7LPKdTdm0RqwZxa3+4aZAGJvvZDFDXKDWc4E4f2kStp8DsUv/BBndbx0SpWyIy+Cl0Vo/C3sGU4M3M7IQZXvnHoBNzLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=aJhFEtpr; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=rIem0ZYwGt4dbVCnugmzgp3TRR0GBGP9mNZTLF3OqNo=; b=aJhFEtprsMvxJeCW+wwnWVDdl6
	VYPeKpKLRBAn9jyUFK2MvIwbfetpcsLKv2W/rbRST/cunWQDA5pH12RvBiKfrXtNnumsXPrlXF7SQ
	vvfZb63XoVLhAtPA5DVWnRr3wO28tAWJEWgWhWg4idild1tLyHQEoQm1/itDiId0Im2C8SV4+/wRo
	HeNqET5qlw1tukglfwhrz7E7Ja5an8owY7yqNLaLDd2zNiGhaEyF8d1SJI8P0uEmd9lYW5ar/eZcW
	FIhtvrscU6ssM+xb4cLlmUUZ1BoSKX9k0SMOwbJasQuqis2byC9vXYzv312g1J/Bdfpd+SaMhJ11P
	z23DuMeg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sPj9R-0000000G5Pw-3kFb;
	Fri, 05 Jul 2024 13:39:01 +0000
Date: Fri, 5 Jul 2024 06:39:01 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Chuck Lever III <chuck.lever@oracle.com>
Cc: Christoph Hellwig <hch@infradead.org>,
	Mike Snitzer <snitzer@kernel.org>, Jeff Layton <jlayton@kernel.org>,
	Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>,
	Neil Brown <neilb@suse.de>, Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH v11 00/20] nfs/nfsd: add support for localio
Message-ID: <Zof3dQODVAt4R4Bu@infradead.org>
References: <ZoVdP-S01NOyZqlQ@infradead.org>
 <ZoVqN7J6vbl0BzIl@kernel.org>
 <ZoVrqp-EpkPAhTGs@infradead.org>
 <F1585F6E-8C41-4361-B4FA-F9BD6E26F3A9@oracle.com>
 <ZoVv4IVNC2dP1EaM@kernel.org>
 <4486ee80a487c174ec88c7e12705d99e22ae812a.camel@kernel.org>
 <ZoY6e-BmRJFLkziG@infradead.org>
 <ZobqkgBeQaPwq7ly@kernel.org>
 <ZoeCFwzmGiQT4V0a@infradead.org>
 <57C1CB2B-3B46-48F3-A095-417845001C3E@oracle.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <57C1CB2B-3B46-48F3-A095-417845001C3E@oracle.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Fri, Jul 05, 2024 at 01:35:18PM +0000, Chuck Lever III wrote:
> I agree: I think the requirement for NFSv3 in this situation
> needs a clear justification. Both peers are recent vintage
> Linux kernels; both peers can use NFSv4.x, there's no
> explicit need for backwards compatibility in the use cases
> that have been provided so far.

More importantly both peers are in fact the exact same Linux kernel
instance.  Which is the important point here - we are doing a bypass
for a kernel talking to itself, although a kernel suffering from
multiple personality (dis)order where the different sides might
expose very different system views.


