Return-Path: <linux-nfs+bounces-14946-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 27256BB625C
	for <lists+linux-nfs@lfdr.de>; Fri, 03 Oct 2025 09:13:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D655F1AE05B2
	for <lists+linux-nfs@lfdr.de>; Fri,  3 Oct 2025 07:13:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9347622D9EB;
	Fri,  3 Oct 2025 07:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HN3tjZC0"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5103522D4DD
	for <linux-nfs@vger.kernel.org>; Fri,  3 Oct 2025 07:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759475593; cv=none; b=TxV/DoME/agCsBu/e03PuuTDuVxuO2gkfwJOjDzWiiR3dhh59ewuX3jpodOUFlsphJQGwGEoPsNIn54r/G9BPz18WZs2jL58YLglFezfUX43ymZbHxRblOGTeDb96K7vCFzua2EihQT/45dMeY7PgUioJt4JhW3OvVEOQvrCCuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759475593; c=relaxed/simple;
	bh=VrVEAgNI1X2/Murjn7QgowGze8U52UFeXBY4EjtYw4s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fETS872IZaATEAmmnhtbLx/i+n2+hH3VdbtM+rW+YRIuRZSvxNjPJoacROBq5dP0AcfTmCQzSJ+ZP7t0xn/w6YeVLXyXY5qFlNiKWZRRQRh8tcU5DC6HBjpl+0ZfGtXbYXLwEnfy15UFLS+E5Bqr0lOm9+dKozl6D58+q0NGc2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=HN3tjZC0; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=mPOTvmAdGgEwMsEEcRHA0lgX6j9W+z21eeBzZSFB7mM=; b=HN3tjZC0ukjjbwdz88Jp07uHc0
	CSJzR3jSZrMtTXfE724FO3XnO8TbsXI3NqXHkexEytJFvYvH/x/vVxAU1m8mbLFRM+bz2OQjrHS1d
	1KOnJGx4/AyXpTfo6DOqWm1uoP2PsmBDCrRD/H0YtTYSrdGSJ4IhjBxjjcrVz+SX9+StQQmhUJxo6
	qgSvqSdKxfO+1ZW+M/2cx7FHiw7Wp6Sge9cB1RL829/veHbZFEeyEXF8f5JcGpdGH2wWnnGfGcs1J
	3a8HvJa1zmUiysR4ZTKyrIK+g95oVYYT7miDGO4QyAuliXXhSfL1k+hRzCjOOdQBwLlKUUqnY2GOL
	0sngzpKQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v4ZyX-0000000BnUU-3gge;
	Fri, 03 Oct 2025 07:13:09 +0000
Date: Fri, 3 Oct 2025 00:13:09 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Chuck Lever <cel@kernel.org>
Cc: NeilBrown <neil@brown.name>, Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [PATCH v5 6/6] NFSD: Ignore vfs_getattr() failure in
 nfsd_file_get_dio_attrs()
Message-ID: <aN93he8osC9r6oKR@infradead.org>
References: <20250929155646.4818-1-cel@kernel.org>
 <20250929155646.4818-7-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250929155646.4818-7-cel@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Sep 29, 2025 at 11:56:46AM -0400, Chuck Lever wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
> 
> A vfs_getattr() failure is rare but not totally impossible.
> 
> There's no recovery logic in that case; nfsd_do_file_acquire()'s
> caller will fail but the wonky nfsd_file is left in the file cache.
> 
> It doesn't seem necessary for nfsd_file_do_acquire() to fail
> outright if it successfully opened the file but some problem
> prevented the collection of the dio alignment parameters.

The only remotely likely case for this is a file system shutdown.
There's no real way it could fail but I/O later on will work.

I think just failing serves everyone here much better than try to
keep going.

> Fixes: bc70aaeba7df ("NFSD: filecache: add STATX_DIOALIGN and STATX_DIO_READ_ALIGN support")

Same comment about fixes being first/separate as for the previous
patch.


