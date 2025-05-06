Return-Path: <linux-nfs+bounces-11523-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 44432AAC84F
	for <lists+linux-nfs@lfdr.de>; Tue,  6 May 2025 16:41:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BBD707BBB2F
	for <lists+linux-nfs@lfdr.de>; Tue,  6 May 2025 14:39:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01D372836A4;
	Tue,  6 May 2025 14:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XZCJ8KN0"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A850283149;
	Tue,  6 May 2025 14:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746542408; cv=none; b=IEHbw2h/uGqEcIQROJf+oUbcY/PMT4gj0gGtSewKEVqBQUD4Gk7S0JGj3LmA/o38cgUWbZ9Ut7aHjSU0d6gXu5WmIWTbsLhrYF8JVpyfjk9R1seyTVCpIEuFHt9SFoJe1bYlhhQWclD0nWu2ZEktfeRXEuGkh3fGxPHr8Nlw4dA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746542408; c=relaxed/simple;
	bh=N6OpjI9UmJDmffvEWKizQaJrm9AMiPM14a7O/8g7Rbo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gQYG7My14LMD4/cqpbNpAf1bjF55LYskPi7XvCGrSiyrpb2weruRxRyQgm0itC9b8LZ2mpZMZSmG7wQAztCH0nDokv8Zmm9j6TiqmmMObGiWtTHi39peF/XhXDv1ySJC1Eu7pQk+azVEmIjPMc6aMFyDVukDsdV8s4kxy/jzwCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=XZCJ8KN0; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=yLfgEo5e51dsFgpTvqr2VoDFtYP7Qypd0vMn4KluLlk=; b=XZCJ8KN0GcAs39DaupFs+RjOT7
	yy0+Hj1jrkmwUwoDkMUqMeXyJgm/vPDjY9WWajdyP0BzWy3Ajx7nTgs7p4ir82nZRdl29b9E0w0Tv
	XY4INcZUd+zroO6u0pMD5oxLcW8VZ/uk4M3AI6LvfXvqvoY+/Qp8e104WZrSdkBlyrQZ9ow9NJ/ky
	e1RggdIiEV7eJHxBkRMaV9yoi/2oB4w8BVq2tUwq10wKfbj2OkhJ3w98GhuIIanpHimohdSMaA1qn
	mvY3CQEVbnx0asZy5w/BRKxmXfcGo4L3+/O5YbZ52liRwxnlrT4t8RjdefkflDZmDFYxMAEwCPouf
	3xNjBNcw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCJSp-0000000CMA8-0KDx;
	Tue, 06 May 2025 14:40:07 +0000
Date: Tue, 6 May 2025 07:40:07 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Christoph Hellwig <hch@infradead.org>,
	kernel-tls-handshake <kernel-tls-handshake@lists.linux.dev>,
	Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
	linux-nvme@lists.infradead.org
Subject: Re: kernel TLS configuration, was: Re: [ANNOUNCE] ktls-utils 1.0.0
Message-ID: <aBofRwc5u-sqFgPY@infradead.org>
References: <oracle/ktls-utils/push/refs/tags/ktls-utils-1.0.0/000000-c787cd@github.com>
 <32e4bd99-a85f-4f53-94bd-b8c3ecf2c66f@oracle.com>
 <aBoCELZ_x-C4talt@infradead.org>
 <63b16277-d651-4f37-9e32-965dc6d1e7b0@oracle.com>
 <aBoYDS84d8N5STLq@infradead.org>
 <fb8862b6-97aa-43d0-882f-f0ab9f873e16@oracle.com>
 <aBocWAKRbttPeStt@infradead.org>
 <8094c0f2-3f83-45c0-9b1f-0cee682997d4@oracle.com>
 <aBoddkwEbyqGllOh@infradead.org>
 <8ad8cced-c5eb-45b9-b3d1-7409b3ae507c@oracle.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8ad8cced-c5eb-45b9-b3d1-7409b3ae507c@oracle.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, May 06, 2025 at 10:39:00AM -0400, Chuck Lever wrote:
> On 5/6/25 10:32 AM, Christoph Hellwig wrote:
> > On Tue, May 06, 2025 at 10:31:04AM -0400, Chuck Lever wrote:
> >> I do. I can't burn that bridge and stay employed. So calm yourself,
> >> sir. Let me ask around.
> > 
> > No one expects you to support this.
> 
> That's just the kind of detail we need to decide before we can "just
> fork it" -- who will be the maintainer going forward?
> 
> 
> > But you should also not expect
> > much support for a project with a silly CLA.
> 
> I respect my employer enough that I think they deserve your feedback
> first before the rug is yanked. The best outcome would be that we have
> their permission to move this project somewhere more open.

That would be extremely helpful.  In the meantime I'm happy to host a
development branch freed from the CLA pains.


