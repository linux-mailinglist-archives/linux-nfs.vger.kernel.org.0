Return-Path: <linux-nfs+bounces-8515-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B61579EB898
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Dec 2024 18:47:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 217DC2830BE
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Dec 2024 17:47:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 852E2204692;
	Tue, 10 Dec 2024 17:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=janestreet.com header.i=@janestreet.com header.b="GrxhS15T"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mxout1.mail.janestreet.com (mxout1.mail.janestreet.com [38.105.200.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4915204689
	for <linux-nfs@vger.kernel.org>; Tue, 10 Dec 2024 17:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=38.105.200.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733852810; cv=none; b=DUPjiGjmOI0YHepbIJUQr55XDyIL/+c1s8cg3J50ut6tJRJskxZ2CdE5bSbACgvcX1269QIE0y8a2Quz9cmHRz4DvV7EUZi7fEI9pfHpRRbsoSGmgcEhYN2zaltKyc7BCLsqigXZJBGe3GBYTsfKZ9mVLznabNo9GzoVOSARrOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733852810; c=relaxed/simple;
	bh=mjpKp8aoAbzfqqhP97e9sGN9ZenFgvLAh6N1pRKakXk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qbT4RRP1l09lTnUvf4rtq7EIyVdljg2cQfxXheWGNgRStx6JJ9zF1CXepvh5hwy9k1wqfmuzNrZ84Tleekd3Zf5STx6LQP0Jhl54LycEtQvZQC4PehSq+BDMufIJY8ez9dmT+iL6q9khC9x5Ba/C/Ni8KJ3znC/Zo4OUq6OuF3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=janestreet.com; spf=pass smtp.mailfrom=janestreet.com; dkim=pass (2048-bit key) header.d=janestreet.com header.i=@janestreet.com header.b=GrxhS15T; arc=none smtp.client-ip=38.105.200.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=janestreet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=janestreet.com
Date: Tue, 10 Dec 2024 12:46:41 -0500
From: Nikhil Jha <njha@janestreet.com>
To: Trond Myklebust <trondmy@hammerspace.com>
Cc: "bcodding@redhat.com" <bcodding@redhat.com>,
 	"anna@kernel.org" <anna@kernel.org>,
 	"linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
 	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] nfs: propagate fileid changed errors back to syscall
Message-ID: <20241210A17464116d3ea34.njha@janestreet.com>
References: <Z1cra8/5H5HvJ5Sw@igm-qws-u22929a.delacy.com>
  <C71642EC-B9F9-4A7D-AD11-D169268460FE@redhat.com>
  <20241210A1712306692debd.njha@janestreet.com>
  <16e5f609599e29b49c81a1a8edd721a5daabc1bb.camel@hammerspace.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <16e5f609599e29b49c81a1a8edd721a5daabc1bb.camel@hammerspace.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=janestreet.com;
  s=waixah; t=1733852802;
  bh=fiXnKZb29PFl+Y28EOA2ftTGAElzxCe4suLa+MEHshc=;
  h=Date:From:To:Cc:Subject:References:In-Reply-To;
  b=GrxhS15TtlesZhXdTZbbWtklybcInfnhKPnh0Z/ieE5bndt1lNXJYP/7O8zrFlexT
  /iNSavR4y6LQUqTt5kb4DJDBZRVk6H0cU7P3xYypB7E3t/bh7P0KMXesPmx1rQ3m11
  JKjrPZuR37pxFEedzKVaFG5atsRlsmtVe4H6aq8jlNniFxnmP7FW633iWaPovUnO1o
  4DYsthITvq/Xp+NCjnV6zEWOLFQwTA338olnede1IGBtwLj+xnFe6qHvDbNcG/cz+0
  uc0G5VaZyDy3iPDTAFsYdD+tgnAho6qAHST0Gv8vZwcCjpdxxBYvMdUHFCLA+4CXEz
  UH6aIK4HKVikg==

On Tue, Dec 10, 2024 at 05:33:14PM +0000, Trond Myklebust wrote:
> On Tue, 2024-12-10 at 12:12 -0500, Nikhil Jha wrote:
> > On Tue, Dec 10, 2024 at 07:11:43AM -0500, Benjamin Coddington wrote:
> > > On 9 Dec 2024, at 12:39, Nikhil Jha wrote:
> > > 
> > > > Hello! This is the first kernel patch I have tried to upstream.
> > > > I'm
> > > > following along with the kernel newbies guide but apologies if I
> > > > got
> > > > anything wrong.
> > > > 
> > > > Currently, if there is a mismatch in the request and response
> > > > fileids in
> > > > an NFS request, the kernel logs an error and attempts to return
> > > > ESTALE.
> > > > However, this error is currently dropped before it makes it all
> > > > the way
> > > > to userspace. This appears to be a mistake, since as far as I can
> > > > tell
> > > > that ESTALE value is never consumed from anywhere.
> > > > 
> > > > Callstack for async NFS write, at time of error:
> > > > 
> > > >         nfs_update_inode <- returns -ESTALE
> > > >         nfs_refresh_inode_locked
> > > >         nfs_writeback_update_inode <- error is dropped here
> > > >         nfs3_write_done
> > > >         nfs_writeback_done
> > > >         nfs_pgio_result <- other errors are collected here
> > > >         rpc_exit_task
> > > >         __rpc_execute
> > > >         rpc_async_schedule
> > > >         process_one_work
> > > >         worker_thread
> > > >         kthread
> > > >         ret_from_fork
> > > > 
> > > > We ran into this issue ourselves, and seeing the -ESTALE in the
> > > > kernel
> > > > source code but not from userspace was surprising.
> > > > 
> > > > I tested a rebased version of this patch on an el8 kernel
> > > > (v6.1.114),
> > > > and it seems to correctly propagate this error.
> > > > 
> > > > > 8------------------------------------------------------8<
> > > > 
> > > > If an NFS server returns a response with a different file id to
> > > > the
> > > > response, the kernel currently prints out an error and attempts
> > > > to
> > > > return -ESTALE. However, this -ESTALE value is never surfaced
> > > > anywhere.
> > > 
> > > Hi Nikhil Jha,
> > > 
> > > Will this cause us to return -ESTALE to the application even if the
> > > WRITE
> > > was successful?
> > > 
> > > Ben
> > > 
> > 
> > Hi Ben,
> > 
> > Hmm.. I'm not sure how to answer that question exactly. A fileid is
> > only
> > mismatched between a request RPC and response RPC when something
> > really
> > weird is going on (i.e. a bug in the NFS server), so it's hard to
> > reason
> > about if a WRITE was successful or not.
> > 
> > The `return -ESTALE` was already in the kernel code, but this
> > particular
> > codepath seems to have accidentally dropped that error.
> > 
> > Nikhil
> > 
> 
> I'm not keen on taking any client changes to paper over what appears to
> be a major server bug. We simply can't support broken servers that
> reuse filehandles across files.
> 
> -- 
> Trond Myklebust
> Linux NFS client maintainer, Hammerspace
> trond.myklebust@hammerspace.com
> 

Right, this patch *doesn't* alleviate any server bug from the client. I
don't think it would make sense to try to fix a buggy server from the
Linux NFS client. What I'm thinking about is...

1. We're already detecting this problem, printing an error message, and 
   trying to return ESTALE.
2. That ESTALE is not propagated anywhere. It just gets dropped.

If we don't want this ESTALE to be visible, should it just get removed
entirely? The value does not appear to be consumed from anywhere in the
kernel code.


