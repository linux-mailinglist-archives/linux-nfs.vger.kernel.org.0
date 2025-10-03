Return-Path: <linux-nfs+bounces-14945-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B8503BB6250
	for <lists+linux-nfs@lfdr.de>; Fri, 03 Oct 2025 09:11:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 832844E3A6B
	for <lists+linux-nfs@lfdr.de>; Fri,  3 Oct 2025 07:11:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BB5D22A807;
	Fri,  3 Oct 2025 07:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="h6/0+5bc"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43B111A3165
	for <linux-nfs@vger.kernel.org>; Fri,  3 Oct 2025 07:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759475470; cv=none; b=AzOdZ/buYYIbR9H31gGMZ/FD7PawNn2a3HE5gSarSqiYExGXFrk/W4BAmZjfP961d3jz4SvrnoiKuXNdBLgj6yskCNFlQfwpJ4tQ2e2xxXaGTM67pGYKksWDLosxO5Z6WsamdR/HdJ5M490pMS6kB+9bGNS+0kmTT6g6FQKwSZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759475470; c=relaxed/simple;
	bh=073F3x5FsmqCQaMrTtiAPGp6oYG4gawighobG1aFJq4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=REGuqikcj/b/E3uszlwzXGfaIoKy9p3h8XVL6O2KR7xSGMFLgEt9p1+9Ow8SqFyIjpNjUWZT7QDrzDU6Z5LCY2ukziHB45709f/Xfxn4ETXgFhijLkKIzpKsd0ASoFokS0mLwYGNIhhl/pbmUFOFSgEfoi2NP1J3RCvLHYajSKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=h6/0+5bc; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=p7c51HJPQl5UA2fnUSh1f8uMVYvRbRLDr8jsZxhyO8Y=; b=h6/0+5bc1QoS6Qekd41n04Dr97
	heISAqI7p4alWUrKGgXJiEz6USyW+itqmyXcNph3opYr0JhGR/ljzelPj3QbiIOEaUrvoN38veM8x
	VmwHTzVbl2Q4o2tEelge3fyEKSfwaMp148gvqIcKZjr+VGgnjfdVEMOLyqk3rTqC5i91F8Tqu6FIb
	F8ioNinQcDdumtdjGHbKrQCzSyflFbPI9wiCvBbYW2l6RN91Y0QoetXIZDJWn3dMFKghFV2wS+45/
	IyStedkzNMJI2zzkBEA2hqd8p9YI0DOw6pXX538TXxY98dyhmmX8wYvM9pTKdS5la+Wyy9bwH180+
	D2mms6Ow==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v4ZwZ-0000000BnOL-1xej;
	Fri, 03 Oct 2025 07:11:07 +0000
Date: Fri, 3 Oct 2025 00:11:07 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Chuck Lever <cel@kernel.org>
Cc: NeilBrown <neil@brown.name>, Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [PATCH v5 5/6] NFSD: Prevent a NULL pointer dereference in
 fh_getattr()
Message-ID: <aN93CyFBPTnmAePM@infradead.org>
References: <20250929155646.4818-1-cel@kernel.org>
 <20250929155646.4818-6-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250929155646.4818-6-cel@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Sep 29, 2025 at 11:56:45AM -0400, Chuck Lever wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
> 
> In general, fh_getattr() can be called after the target dentry has
> gone negative. For a negative dentry, d_inode(p.dentry) will return
> NULL. S_ISREG() will dereference that pointer.
> 
> Avoid this potential regression by using the d_is_reg() helper
> instead.
> 
> Suggested-by: NeilBrown <neil@brown.name>
> Fixes: bc70aaeba7df ("NFSD: filecache: add STATX_DIOALIGN and STATX_DIO_READ_ALIGN support")

Fixed for existing bugs should usually go first and/or be split into a
separate prep series.

Otherwise:

Reviewed-by: Christoph Hellwig <hch@lst.de>


