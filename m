Return-Path: <linux-nfs+bounces-15964-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9D77C2E1D7
	for <lists+linux-nfs@lfdr.de>; Mon, 03 Nov 2025 22:14:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B3611895D28
	for <lists+linux-nfs@lfdr.de>; Mon,  3 Nov 2025 21:15:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CCB326F2BB;
	Mon,  3 Nov 2025 21:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZBDR/Ces"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67D8934D3A5
	for <linux-nfs@vger.kernel.org>; Mon,  3 Nov 2025 21:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762204488; cv=none; b=tyMQz8Gu4wzgWvTt7YW1Pw9FeMjMVbWx2XECY3hgnp1l38BJacCxrFaHsPE8Mt1NYD1A3ZSaMpRWXj2W7kI0F7Hb/MhjXs6FxNK3co+dwDGFH6UTf2LTxVofN8PQHwnhVBMOOrBr9m++KH6ZfyCaemST9BZ01/zeS6ZcSSNrHtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762204488; c=relaxed/simple;
	bh=mmAnXhqwEZNmcPtxkCU+JrTYnk2GAwIgi92sq6IKMdg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hj4Ze/hEM7uL8t6nBySksWFxJL70FNujgP7tVVMQLeM+IBcco3GYwEOF/hJlr5SJfWQteyGooKDrJMOsyIMA5lsLOMLjcBj5qr3VY5OlZiUKiUrFNZSHZoTKSpaGA1di8BnRtJSR29nUfQGmgyj7m6lwCfKEoJQqYkweXTs97Rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZBDR/Ces; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6E05C4CEE7;
	Mon,  3 Nov 2025 21:14:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762204488;
	bh=mmAnXhqwEZNmcPtxkCU+JrTYnk2GAwIgi92sq6IKMdg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZBDR/CesWCsxcTkCsPMRv/2OQCmxNuA+2UFNrJeYAWU5Xk2vdv9r0tr4Ix+Zl7M73
	 vQD3dYOtGqkT7wx13aDIfeGmopOEeGOmHu/Dd0zQUavrmo7qwtYEanNqXFsUKOI1D7
	 TaT6uana7msnWRxZOAlqm9B4RWlrQa5Hsvu2IFsO7FU1+lxt9T/FUDbiqqnWCnyKn2
	 mRzWYIKuxLK7vawWt/WvZwFfx0a5xSyLXffcGbI+SJ9xShb9cjNc9ro4uxWeUYDcyq
	 J989BvgioohZ4Aiy9HTakeM+NQBSmtInGGLnok4q1ZR5MgZ/BcvnYi1t9B8id/HKvM
	 n6YxoOOkHVV0Q==
Date: Mon, 3 Nov 2025 16:14:46 -0500
From: Mike Snitzer <snitzer@kernel.org>
To: Chuck Lever <cel@kernel.org>
Cc: NeilBrown <neil@brown.name>, Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v9 10/12] NFSD: Handle kiocb->ki_flags correctly
Message-ID: <aQkbRmSbDjtCn28Q@kernel.org>
References: <20251103165351.10261-1-cel@kernel.org>
 <20251103165351.10261-11-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251103165351.10261-11-cel@kernel.org>

On Mon, Nov 03, 2025 at 11:53:49AM -0500, Chuck Lever wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
> 
> Christoph says:
> > > +	if (file->f_op->fop_flags & FOP_DONTCACHE)
> > > +		kiocb->ki_flags |= IOCB_DONTCACHE;
> > IOCB_DONTCACHE isn't defined for IOCB_DIRECT.  So this should
> > move into a branch just for buffered I/O.
> 
> and
> 
> > > Promoting all NFSD_IO_DIRECT writes to FILE_SYNC was my idea,
> > > based on the assumption that IOCB_DIRECT writes to local file
> > > systems left nothing to be done by a later commit. My assumption
> > > is based on the behavior of O_DIRECT on NFS files.
> > >
> > > If that assumption is not true, then I agree there is no
> > > technical reason to promote NFSD_IO_DIRECT writes to FILE_SYNC,
> > > and I can remove that built-in assumption for v8 of this series.
> >
> > It is not true, or rather only true for a tiny subset of use cases
> > (which NFS can't even query a head of time).
> 
> So, observe the existing setting of ki_flags rather than forcing
> persistence unconditionally, and ensure that DONTCACHE is not set
> for IOCB_DIRECT writes.
> 
> Suggested-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Jeff Layton <jlayton@kernel.org>
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>

Reviewed-by: Mike Snitzer <snitzer@kernel.org>

