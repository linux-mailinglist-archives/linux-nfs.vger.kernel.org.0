Return-Path: <linux-nfs+bounces-4436-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 33F5991D37D
	for <lists+linux-nfs@lfdr.de>; Sun, 30 Jun 2024 21:44:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7B6C281207
	for <lists+linux-nfs@lfdr.de>; Sun, 30 Jun 2024 19:44:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C041154C00;
	Sun, 30 Jun 2024 19:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o8HHb186"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F1B239855
	for <linux-nfs@vger.kernel.org>; Sun, 30 Jun 2024 19:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719776678; cv=none; b=Vs3FWF8pl9M/MadldP0NuWd1RAwUH1sQCHeA9KegW4MCZpKKXdffAdlefE4W9ehkWblBcAuPpl93tniLDrxo+W5zZ1SE40LTLzglSrousKcr8P4f591bBJ7umcGtJtT8GbB6Awh1qlB1Zjje5GueIXGLTUDrn9cKyGAawNf0Ga8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719776678; c=relaxed/simple;
	bh=/n0fIUoaliPJhEIYXjr0e/UtZbsUE0uRw5nhpicjbYE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F2ShR6kXYNjKDZoIKwaYTYu3Vl+jLV3lryo5U43/ZfgZhee93TsTnW5JDjuLqIzT6SI/d1rTYo9E5F267aahN4RQWB3jx9gKvdzyDiv1iQWsvOlu5brx/Nhr/shN/eBLxdHOb2tqG9yRgX3mjP1svmfm2PvBfWDKwsGZDkNI/nI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o8HHb186; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63B88C2BD10;
	Sun, 30 Jun 2024 19:44:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719776677;
	bh=/n0fIUoaliPJhEIYXjr0e/UtZbsUE0uRw5nhpicjbYE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=o8HHb186gy1wq2mBmkVMAYYMDF5TBf8ORIYVNIpAOElH3FmVxrmfAUH8UuQq1QR+C
	 46HWqSAY4wV1w6/ddyzEArMwEr2Hb4av27OCe7uFrxrqmp0KfFlVnMFVaresyPmMm2
	 s7yt0BUjAqHJwi5gLko7PwWRmzUVWEqvQWGibbFac6Dv2Wms9Qc0oFkNGqB0eWMML2
	 BPe/Q5pq77rUanb5o4nnUvMkCSY1VEbWnKorM59mUecnodxjWxNTO1ZYM8yGevPvJL
	 d+Rt03wNEOxQ5EjYr9z4ySd4ieOyhLLn2XI8UPyulkBluzs9bRWaF4X9SDevWQTDV6
	 tQ08Sj5Yq0Ctw==
Date: Sun, 30 Jun 2024 15:44:36 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: linux-nfs@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>,
	NeilBrown <neilb@suse.de>, snitzer@hammerspace.com
Subject: Re: [PATCH v9 13/19] nfsd: add "localio" support
Message-ID: <ZoG1pF_sgAUDoH-n@kernel.org>
References: <20240628211105.54736-1-snitzer@kernel.org>
 <20240628211105.54736-14-snitzer@kernel.org>
 <ZoCIQjxougYwplsp@tissot.1015granger.net>
 <ZoFwj0gkBf3Pr1RI@tissot.1015granger.net>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZoFwj0gkBf3Pr1RI@tissot.1015granger.net>

On Sun, Jun 30, 2024 at 10:49:51AM -0400, Chuck Lever wrote:
> On Sat, Jun 29, 2024 at 06:18:42PM -0400, Chuck Lever wrote:
> > > +
> > > +	/* nfs_fh -> svc_fh */
> > > +	if (nfs_fh->size > NFS4_FHSIZE) {
> > > +		status = -EINVAL;
> > > +		goto out;
> > > +	}
> > > +	fh_init(&fh, NFS4_FHSIZE);
> > > +	fh.fh_handle.fh_size = nfs_fh->size;
> > > +	memcpy(fh.fh_handle.fh_raw, nfs_fh->data, nfs_fh->size);
> > > +
> > > +	if (fmode & FMODE_READ)
> > > +		mayflags |= NFSD_MAY_READ;
> > > +	if (fmode & FMODE_WRITE)
> > > +		mayflags |= NFSD_MAY_WRITE;
> > > +
> > > +	beres = nfsd_file_acquire(rqstp, &fh, mayflags, &nf);
> > > +	if (beres) {
> > > +		status = nfs_stat_to_errno(be32_to_cpu(beres));
> > > +		goto out_fh_put;
> > > +	}
> > 
> > So I'm wondering whether just calling fh_verify() and then
> > nfsd_open_verified() would be simpler and/or good enough here. Is
> > there a strong reason to use the file cache for locally opened
> > files? Jeff, any thoughts?
> 
> > Will there be writeback ramifications for
> > doing this? Maybe we need a comment here explaining how these files
> > are garbage collected (just an fput by the local I/O client, I would
> > guess).
> 
> OK, going back to this: Since right here we immediately call 
> 
> 	nfsd_file_put(nf);
> 
> There are no writeback ramifications nor any need to comment about
> garbage collection. But this still seems like a lot of (possibly
> unnecessary) overhead for simply obtaining a struct file.

Easy enough change, probably best to avoid the filecache but would like
to verify with Jeff before switching:

diff --git a/fs/nfsd/localio.c b/fs/nfsd/localio.c
index 1d6508aa931e..85ebf63789fb 100644
--- a/fs/nfsd/localio.c
+++ b/fs/nfsd/localio.c
@@ -197,7 +197,6 @@ int nfsd_open_local_fh(struct net *cl_nfssvc_net,
        const struct cred *save_cred;
        struct svc_rqst *rqstp;
        struct svc_fh fh;
-       struct nfsd_file *nf;
        __be32 beres;

        if (nfs_fh->size > NFS4_FHSIZE)
@@ -235,13 +234,12 @@ int nfsd_open_local_fh(struct net *cl_nfssvc_net,
        if (fmode & FMODE_WRITE)
                mayflags |= NFSD_MAY_WRITE;

-       beres = nfsd_file_acquire(rqstp, &fh, mayflags, &nf);
+       beres = fh_verify(rqstp, &fh, S_IFREG, mayflags);
        if (beres) {
                status = nfs_stat_to_errno(be32_to_cpu(beres));
                goto out_fh_put;
        }
-       *pfilp = get_file(nf->nf_file);
-       nfsd_file_put(nf);
+       status = nfsd_open_verified(rqstp, &fh, mayflags, pfilp);
 out_fh_put:
        fh_put(&fh);
        nfsd_local_fakerqst_destroy(rqstp);

Mike

