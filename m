Return-Path: <linux-nfs+bounces-8513-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A87109EB7EE
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Dec 2024 18:16:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A601D1628BA
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Dec 2024 17:15:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50E6B230247;
	Tue, 10 Dec 2024 17:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=janestreet.com header.i=@janestreet.com header.b="hahVgA0T"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mxout5.mail.janestreet.com (mxout5.mail.janestreet.com [64.215.233.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAB84230245
	for <linux-nfs@vger.kernel.org>; Tue, 10 Dec 2024 17:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.215.233.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733850754; cv=none; b=dmdGWiZ10a8n0Grv6K2wWATVVyMBgXovLvNcYVI/FC8Q8Zgdwrd2m7SwMio+7FwSnAIAyiFGQ0An91qNazu8vpjOQvLyEpVpE+/3o3O2FuZcBbZHG+Z2rdP4PhNxmdsvTi/n22lwj9eIwZxWuimbKOz+dhbtyKU5ZtNEsFGnhGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733850754; c=relaxed/simple;
	bh=3oFTMiR1Jda2131qBxt33N+IF3sGk7jD/jaRHajpzFM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tLLCvM1QW3sl8LJH8TDYOZvenF+OXTQtc0OptRGsCwJOVnJgLbSIvaz1u9lZ+pUEE90hW31S41lsNI/ATEviKx6gC8NY5YF7oWJgrWq5bNFmnzfOtdfCTTpBVvYBS12qUS0pxvQ9lnEzEk5Xqyflq6mTUqRnG4HTrsIFQqCa0Cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=janestreet.com; spf=pass smtp.mailfrom=janestreet.com; dkim=pass (2048-bit key) header.d=janestreet.com header.i=@janestreet.com header.b=hahVgA0T; arc=none smtp.client-ip=64.215.233.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=janestreet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=janestreet.com
Date: Tue, 10 Dec 2024 12:12:30 -0500
From: Nikhil Jha <njha@janestreet.com>
To: Benjamin Coddington <bcodding@redhat.com>
Cc: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>,
 	linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nfs: propagate fileid changed errors back to syscall
Message-ID: <20241210A1712306692debd.njha@janestreet.com>
References: <Z1cra8/5H5HvJ5Sw@igm-qws-u22929a.delacy.com>
  <C71642EC-B9F9-4A7D-AD11-D169268460FE@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <C71642EC-B9F9-4A7D-AD11-D169268460FE@redhat.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=janestreet.com;
  s=waixah; t=1733850750;
  bh=rWqs/6mT7CMgk2PnjqVe5Pu7979o27uZXxcsQ9TbmfY=;
  h=Date:From:To:Cc:Subject:References:In-Reply-To;
  b=hahVgA0TrQ+62p05KfdC/jd5zXie3T9hy1yJHBjfeG0PO0RnPvHd04QE4vUzcT31V
  vWDwPV4pcpMySOE+8yczSKT29W8teOxqI/SYqde5NyC4tHLK8VtUx2NU+7FMgRDkFD
  IbdDmGOU/ZLgwyWpVusbTiUqr+tvhOnegejJmsXMqtXWd8kN0SCSHISFSRttaWczx7
  CQMOJiWM2dopeniXvFu4e7p+kcLXtqxUwod/ElHTImUQqJiRPWCt9C10MNznKZi9PA
  djhtVylxiEpKTi0Z/9MrSocH86eRWChNJf2uC6RWaFPp1aOnbQCSfT56fStVZQpnOc
  R6yyxLz+QaVdg==

On Tue, Dec 10, 2024 at 07:11:43AM -0500, Benjamin Coddington wrote:
> On 9 Dec 2024, at 12:39, Nikhil Jha wrote:
> 
> > Hello! This is the first kernel patch I have tried to upstream. I'm
> > following along with the kernel newbies guide but apologies if I got
> > anything wrong.
> >
> > Currently, if there is a mismatch in the request and response fileids in
> > an NFS request, the kernel logs an error and attempts to return ESTALE.
> > However, this error is currently dropped before it makes it all the way
> > to userspace. This appears to be a mistake, since as far as I can tell
> > that ESTALE value is never consumed from anywhere.
> >
> > Callstack for async NFS write, at time of error:
> >
> >         nfs_update_inode <- returns -ESTALE
> >         nfs_refresh_inode_locked
> >         nfs_writeback_update_inode <- error is dropped here
> >         nfs3_write_done
> >         nfs_writeback_done
> >         nfs_pgio_result <- other errors are collected here
> >         rpc_exit_task
> >         __rpc_execute
> >         rpc_async_schedule
> >         process_one_work
> >         worker_thread
> >         kthread
> >         ret_from_fork
> >
> > We ran into this issue ourselves, and seeing the -ESTALE in the kernel
> > source code but not from userspace was surprising.
> >
> > I tested a rebased version of this patch on an el8 kernel (v6.1.114),
> > and it seems to correctly propagate this error.
> >
> >> 8------------------------------------------------------8<
> >
> > If an NFS server returns a response with a different file id to the
> > response, the kernel currently prints out an error and attempts to
> > return -ESTALE. However, this -ESTALE value is never surfaced anywhere.
> 
> Hi Nikhil Jha,
> 
> Will this cause us to return -ESTALE to the application even if the WRITE
> was successful?
> 
> Ben
> 

Hi Ben,

Hmm.. I'm not sure how to answer that question exactly. A fileid is only
mismatched between a request RPC and response RPC when something really
weird is going on (i.e. a bug in the NFS server), so it's hard to reason
about if a WRITE was successful or not.

The `return -ESTALE` was already in the kernel code, but this particular
codepath seems to have accidentally dropped that error.

Nikhil


