Return-Path: <linux-nfs+bounces-5864-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 74933962A0B
	for <lists+linux-nfs@lfdr.de>; Wed, 28 Aug 2024 16:20:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2AA981F237BF
	for <lists+linux-nfs@lfdr.de>; Wed, 28 Aug 2024 14:20:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5E0C16B386;
	Wed, 28 Aug 2024 14:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J7rq3Do3"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A062D42A8E
	for <linux-nfs@vger.kernel.org>; Wed, 28 Aug 2024 14:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724854796; cv=none; b=m6NffcR89WnvmGTS2w2CR80RwK3mk+DZLSDQqxTk+9PLt7fMlibbG1Iakb3oYiI6UfvtVn+V5ZPMSEVuSpzngXkKNUiptZD+ePBaF4pu+YDgRWc1s5bzNtOECq3DJrcjHOwd1P8DNvGhQ5IGNRPCk7X7SyrFoOL59WcoHCnIkm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724854796; c=relaxed/simple;
	bh=meck+Yrb18hLyEg96DYOcelsEk9TLFJ9bdJhLwTNr7g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L9vMaggNe4EgdIPDA9u88jtbZ1DvNLFItQv8VpIcYAuqQ+u9+OKaeiDeHjwYoq0bPvfwNR6bvUw4eB2oLJCHnC5zdUXyo40qTM9PUsyel269ymxDAGRWxQb1EMw81mVJO4XJ7hv3Ro4Tl2schZ8RTUOKJatyWbt00pxRZVFsDBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J7rq3Do3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD268C4FE0B;
	Wed, 28 Aug 2024 14:19:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724854796;
	bh=meck+Yrb18hLyEg96DYOcelsEk9TLFJ9bdJhLwTNr7g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=J7rq3Do3cIqXL5o4yWGHGox6JcZ7xoCpGciS6xCwEtun03YwY0zLzDWZQTr4T51se
	 z0jvVNEKSShT/r+Bzrv3OmK3oHT4g6HlUHrzqQdLZ5ts4pNRTUitytr2HE2QYIC9sb
	 nP7n+T1co7g+qsfGy7ZCudmpWoqQF+buJ6hkmtWhXJ3mwOE2LuyRyVYDP0ZgY0Knbb
	 daCFTQA4WnREQsF+YxJl1Zz1df79//pRl/fKrOOGHrlSv2pXFYVvBIBsTmX/hLYjG3
	 16jb1Vix++smm/yCaaW0iakNfZU2ZMt+P+k0/IwL6GsPOjX4Q7osT0e/9BhcsPFa6Z
	 7OkP3/J1M9/gA==
Date: Wed, 28 Aug 2024 10:19:54 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: NeilBrown <neilb@suse.de>, cel@kernel.org, linux-nfs@vger.kernel.org
Subject: Re: [RFC PATCH 3/6] NFSD: Avoid using rqstp->rq_vers in
 nfsd_set_fh_dentry()
Message-ID: <Zs8yCtJptJJLt_t5@kernel.org>
References: <20240828004445.22634-1-cel@kernel.org>
 <20240828004445.22634-4-cel@kernel.org>
 <172482136244.4433.13629516052198910622@noble.neil.brown.name>
 <Zs8p+yuLeCZbQ8ht@tissot.1015granger.net>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zs8p+yuLeCZbQ8ht@tissot.1015granger.net>

On Wed, Aug 28, 2024 at 09:45:31AM -0400, Chuck Lever wrote:
> On Wed, Aug 28, 2024 at 03:02:42PM +1000, NeilBrown wrote:
> > On Wed, 28 Aug 2024, cel@kernel.org wrote:
> > > From: Chuck Lever <chuck.lever@oracle.com>
> > > 
> > > Currently, fh_verify() makes some daring assumptions about which
> > > version of file handle the caller wants, based on the things it can
> > > find in the passed-in rqstp. The about-to-be-introduced LOCALIO use
> > > case sometimes has no svc_rqst context, so this logic won't work in
> > > that case.
> > > 
> > > Instead, examine the passed-in file handle. It's .max_size field
> > > should carry information to allow nfsd_set_fh_dentry() to initialize
> > > the file handle appropriately.
> > > 
> > > lockd appears to be the only kernel consumer that does not set the
> > > file handle .max_size when during initialization.
> > > 
> > > write_filehandle() is the other question mark, as it looks possible
> > > to specify a maxsize between NFS_FHSIZE and NFS3_FHSIZE here.
> > 
> > The file handle used by lockd and the one created by write_filehandle
> > never need any of the version-specific fields.
> > Those fields affect things like write requests and getattr requests and
> > pre/post attributes.
> 
> Then we could simply drop the "case 0:" arm and maybe the lockd hunk
> from this patch.

OK, will do.

