Return-Path: <linux-nfs+bounces-4761-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E9C492CB26
	for <lists+linux-nfs@lfdr.de>; Wed, 10 Jul 2024 08:33:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9007D1C21F3E
	for <lists+linux-nfs@lfdr.de>; Wed, 10 Jul 2024 06:33:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 205714F602;
	Wed, 10 Jul 2024 06:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="2zfNgTcc"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E0FB1A28D
	for <linux-nfs@vger.kernel.org>; Wed, 10 Jul 2024 06:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720593191; cv=none; b=mLJpoN1AxB+fUWfR5CKPoj4D+pOjN0WdspemDnQEKHtOavwuHb3iBAn5P8NEA8rrOHeZjzXkIE9UC84qnGSqAZ9/BA83Nnf1iqDcc6AF4iiQgylaHQrJHef7yhylmHdmafebswIQ2wiDhvEURWARPxwz2lw+3LUYMOS8+fFRkGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720593191; c=relaxed/simple;
	bh=XXL6V/2xTU6RHc7uMF1/JmXaBga2KLYOGNbLEKOKX9I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P70QSkqCZ2hHjkMyFGAgsmu+PhfWwQ5MbFPJzwuzt9DB7eHKXav/vV7EKJvuOFhGtNdosMMDab8kZh9XB501uC3FXcaucfP6MqqX1y2TX6VdG1WfUuoIGCVS47cOlBf4j5jZT5aN9BKRQKwfveBLUYusleLLtOCIiS29Gmx8TNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=2zfNgTcc; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=eLt4Er+wlMKO+Et5W0aU0rMQaQ5QaWPZAvYRIdO1Ayw=; b=2zfNgTcc6wlYMV/SAETei54Np6
	1Vh7dpT+bm7ODJ8P/+wLjpO7spdijw1euSpmbM78TQLHlO3sakugtKDEXHPeDJShSEI3BA0Pxd8cL
	Wf4zZPMTcoDMu1yNAao0OEAAmALi9kMyVgCKhwE2PIYT478KuOpWwIGU/fjwr0z4kcKKqW4QcIf4Z
	kIorXZwGLT6LB3lzJPsgg/sDEhLJIyqoggYMg5Z9VbTPwYEvBDtMqa1kvLXlB17pk/mh+gdsvWXdO
	UtCcvrunnr/jeCdjJpCTaS2BBVbbGNL0b/XGeQtS3weDmX7eSl507Gd3R4My+MrDNYaVYpdUskc8z
	Z1VL4cuA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sRQsz-00000009cVI-1jXU;
	Wed, 10 Jul 2024 06:33:05 +0000
Date: Tue, 9 Jul 2024 23:33:05 -0700
From: Christoph Hellwig <hch@infradead.org>
To: David Wysochanski <dwysocha@redhat.com>
Cc: Christoph Hellwig <hch@infradead.org>,
	Chuck Lever III <chuck.lever@oracle.com>,
	Dave Wysochanski <wysochanski@pobox.com>,
	Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: BUG in nfs_read_folio() when tracing is enabled
Message-ID: <Zo4rIUgiaOOXJ_sw@infradead.org>
References: <C225EF84-ED3A-435F-B90D-7A5EF6AC8430@oracle.com>
 <CALF+zOkKf=5YcSZg6OyYHFzTqL3Fktzch95PQ9UOB0SDzqFZgg@mail.gmail.com>
 <DA939E32-2E25-4EDE-BC25-2D5E50F4B711@oracle.com>
 <CALF+zOkwYrZcen=xat9nQ_EhOcfRFdLji56nrXsqWh4w_3RAHg@mail.gmail.com>
 <ZoTc3-Bzfr-gY4-o@infradead.org>
 <FF24B77F-638E-4F31-ABB6-B07D48AF73B4@oracle.com>
 <Zof5c_eQE3bRn6PR@infradead.org>
 <CALF+zOmzGNrovLCojgXUku4dV8p1r9gz8EDUVvBa6DC2BRqY2Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALF+zOmzGNrovLCojgXUku4dV8p1r9gz8EDUVvBa6DC2BRqY2Q@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Jul 09, 2024 at 11:45:11AM -0400, David Wysochanski wrote:
> > > So Dave, I haven't tested the patch you posted a couple
> > > days ago, because there hasn't been a clear answer about
> > > whether nfs_read_folio() needs to protect itself against
> > > the ->mapping changing, in which case, that's probably
> > > a better fix.
> >
> > ->read_folio is called with the folio locked and only unlocks it
> > on I/O completion, so it doesn't really need any protection.  So the
> > patch to simply move the trace point to before unlocking the folio
> > should fix the issue.
> >
> I didn't see this so maybe you sent it privately or I missed a message.
> 
> > Alternatively we could just use the mapping from the inode variable
> > and pass it in.
> >
> I'm not sure I follow - are you suggesting fixing the tracepoint?

I'm suggesting to fix the tracepoint folio.  I though I had something
out, but I guess it never made it.

> Regardless of possible tracepoint movement or other fixes,
> nfs_folio_length() needs to be patched because it should
> handle folio->mapping == NULL.  Ditto for nfs_page_length().

nfs_page_length is completely unused and I've already sent a patch
to remove it.  nfs_folio_length is only sanely usable with the
folio either locked or under writeback.  So adding this random
check there is probably not a good idea, but an audit of the callers
would be very useful.

