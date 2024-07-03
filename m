Return-Path: <linux-nfs+bounces-4601-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 045009264F6
	for <lists+linux-nfs@lfdr.de>; Wed,  3 Jul 2024 17:36:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 85354B26508
	for <lists+linux-nfs@lfdr.de>; Wed,  3 Jul 2024 15:36:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CA3D181BB8;
	Wed,  3 Jul 2024 15:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mNpEHdjo"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6820217B50D
	for <linux-nfs@vger.kernel.org>; Wed,  3 Jul 2024 15:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720020962; cv=none; b=Ri0epdTd4xm1jMw01T2S8mzUbbQ1ag5yfG0ODbvmCh7hcDDsJTIqcSjZWwhtzzh0rkYMLVf26yNMfabXbXsB9YhZFEbpG00U6xXlWtdJ2THJgVS9qfIc+drRw2JHpO1sWrg8gZtvodQmaUzd3j+pxPpat7Ep5tf4rnpvlaD8bh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720020962; c=relaxed/simple;
	bh=HXlU5Zp9TWBdYHHHGXvtCkST7g0yf008Crmky/6iYwk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HJq9w6fXt2loKBxJMxgSfovSIOrVevzdVADlWl682bhPWLFqRJi3kyZuj/kxrDdSd2yYw+zhetk5nfsnvUBdBPupe9P/WEc2U1I5oXAY3m0ObALUSRJ8ktyHVMUTVjxZ+nR1mLFia4YCVjwmZfzWTJifPVVkANJcm+M9/bA6s/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mNpEHdjo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE6CFC2BD10;
	Wed,  3 Jul 2024 15:36:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720020961;
	bh=HXlU5Zp9TWBdYHHHGXvtCkST7g0yf008Crmky/6iYwk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mNpEHdjoOx9VNbmUNdPVmZ7oUmCx80F9VZu6z3zSepfo3inZyyZyX+uZFQhE+Z5kI
	 3qa7PHSneQeqF6EATCXbyrn0zhNVdWis/e3VTFtj+nGVCrJ5Gq4uYxr9XODjBjeVIO
	 Mn8TEC5DlRmsBRek0jgu2MrrMGF5BP+pgB8BFiCJEtNGHngT+tWux2Q8ZvUtX1VJ62
	 G+dH0UbJFQxZYl9KmVIID25a5Ff4JYchs8UFsZAtKytruV7wOHSapLHBgs5KQQzIjE
	 Z6TzbkgPjhRaiPJOsmFzGmqqP1KfKQUDgDFQNP3X0eU/eonxXtal1ZfKOg8sdGDAtG
	 o+jxMUkp4DQJA==
Date: Wed, 3 Jul 2024 11:36:00 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Chuck Lever III <chuck.lever@oracle.com>
Cc: Christoph Hellwig <hch@infradead.org>,
	Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
	Jeff Layton <jlayton@kernel.org>, Anna Schumaker <anna@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>,
	Neil Brown <neilb@suse.de>, Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH v11 00/20] nfs/nfsd: add support for localio
Message-ID: <ZoVv4IVNC2dP1EaM@kernel.org>
References: <20240702162831.91604-1-snitzer@kernel.org>
 <3A583EDC-519C-4820-87E9-F4DC164656DB@oracle.com>
 <ZoTb-OiUB5z4N8Jy@infradead.org>
 <ZoURUoz1ZBTZ2sr_@kernel.org>
 <ZoVdP-S01NOyZqlQ@infradead.org>
 <ZoVqN7J6vbl0BzIl@kernel.org>
 <ZoVrqp-EpkPAhTGs@infradead.org>
 <F1585F6E-8C41-4361-B4FA-F9BD6E26F3A9@oracle.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <F1585F6E-8C41-4361-B4FA-F9BD6E26F3A9@oracle.com>

On Wed, Jul 03, 2024 at 03:24:18PM +0000, Chuck Lever III wrote:
> 
> 
> > On Jul 3, 2024, at 11:18 AM, Christoph Hellwig <hch@infradead.org> wrote:
> > The actual way
> > to find the file struct still would be nasty, but I'll try to think of
> > something good for that.
> 
> It is that very code that I've asked to be replaced before this
> series can be merged. We have a set of patches for improving
> that aspect that Neil is working on now.
> 
> When Mike presented LOCALIO to me at LSF, my initial suggestion
> was to use pNFS. I think Jeff had the same reaction.

No, Jeff suggested using a O_TMPFILE based thing for localio
handshake.  But he had the benefit of knowing NFSv3 important for the
intended localio usecase, so I'm not aware of him having pNFS design
ideas.

> IMO the design document should, as part of the problem statement,
> explain why a pNFS-only solution is not workable.

Sure, I can add that.

I explained the NFSv3 requirement when we discussed at LSF.

> I'm also concerned about applications in one container being
> able to reach around existing mount namespace silos into the
> NFS server container's file systems. Obviously the NFS protocol
> has its own authorization that would grant permission for that
> access, but via the network.

Jeff also had concerns there (as did I) but we arrived at NFS having
the ability to do it over network, so doing it with localio ultimately
"OK".  That said, localio isn't taking special action to escape mount
namespaces (that I'm aware of) and in practice there are no
requirements to do so.

