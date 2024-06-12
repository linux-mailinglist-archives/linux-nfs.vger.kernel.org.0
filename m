Return-Path: <linux-nfs+bounces-3676-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ACAEA9049B5
	for <lists+linux-nfs@lfdr.de>; Wed, 12 Jun 2024 05:41:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F1791F23E5A
	for <lists+linux-nfs@lfdr.de>; Wed, 12 Jun 2024 03:41:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B01E317C77;
	Wed, 12 Jun 2024 03:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kJP5UOUD"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 889821799B
	for <linux-nfs@vger.kernel.org>; Wed, 12 Jun 2024 03:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718163714; cv=none; b=HJfToMyANoNWP724w1/Rou7wxURii+Ynj9uRUoFFSdeo1KFBKMzwL1J8mtvQSRIz3eE8mu62hBozjzCuHLbpoxMsjUrIKp8SDUCve/OnBm+Qc4kWVb88VlDilp4ogsjHouEDYXks+2fmx15XbIyE1ydz4K5SRoO9C3VO/GrRBSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718163714; c=relaxed/simple;
	bh=ga/MqvU3cJ12Z0Xy0eMQNUSeR6ri4EDCii7QV3c1On4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OXIgrlPhcTRp7EbVnrsoKslhCXb1lRCV3kqF2TOrcGhfOmVuUeCgSvnzKD2WREQBk/pXpFxwvAqYC8cPThSYB0niF98J8LkkEIX9McIyrrkqu2XTcTAX/fMnYYi3GwMhuHnAh0FC76pjhpv/UfW+kI7xS33GIU7bI3IvZVmaCVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kJP5UOUD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8CA2C2BD10;
	Wed, 12 Jun 2024 03:41:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718163714;
	bh=ga/MqvU3cJ12Z0Xy0eMQNUSeR6ri4EDCii7QV3c1On4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kJP5UOUDxTIvMJRMYU335fTF4dwnRrexS/sraxn8URKcVQzHkgsUh64RM1lriQ3E+
	 JBy7vtG4RgjrgPf/VOGLTCsWkCC7451/DmbtyEV1C+naguGz6ZJT/OuOVnRPOLerde
	 nRmTtATT/4OuwlnU9Y23+gRGP6qRxqIIdzSdvBgNWxCU5uFzRhFqG41gOw43YCq9rJ
	 SnMTO0Otzax7nVXZ38f1bNv+Oz4Ou/23+Lbb7Apk0rdGUWFY41Q1TeVw6uFqFCgLfC
	 2U5dlvX7VV6r+KzqHXa13nxJjc+kzUGiX8BrPmyx+i4uneSRIjh5jaNMIygXCWjT5L
	 UhY8iSu2uRzwA==
Date: Tue, 11 Jun 2024 23:41:52 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: NeilBrown <neilb@suse.de>
Cc: Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org,
	Chuck Lever <chuck.lever@oracle.com>,
	Trond Myklebust <trondmy@hammerspace.com>, snitzer@hammerspace.com
Subject: Re: [for-6.11 PATCH 10/29] nfs/nfsd: add "local io" support
Message-ID: <ZmkZAJtd3MhlXM7O@kernel.org>
References: <>
 <ZmkHNr5jtGHDpko_@kernel.org>
 <171816222529.14261.9832643931623454806@noble.neil.brown.name>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <171816222529.14261.9832643931623454806@noble.neil.brown.name>

On Wed, Jun 12, 2024 at 01:17:05PM +1000, NeilBrown wrote:
> On Wed, 12 Jun 2024, Mike Snitzer wrote:
> > 
> > SO I looked, and I'm saddened to see Neil's 6.8 commit 1e3577a4521e
> > ("SUNRPC: discard sv_refcnt, and svc_get/svc_put").
> > 
> > [the lack of useful refcounting with the current code kind of blew me
> > away.. but nice to see it existed not too long ago.]
> > 
> > Rather than immediately invest the effort to revert commit
> > 1e3577a4521e for my apparent needs... I'll send out v2 to allow for
> > further review and discussion.
> > 
> > But it really does feel like I _need_ svc_{get,put} and nfsd_{get,put}
> 
> You are taking a reference, and at the right time.  But it is to the
> wrong thing.

Well, that reference is to ensure nfsd (and nfsd_open_local_fh) is
available for the duration of a local client connected to it.

Really wasn't trying to keep nn->nfsd_serv around with this ;)

> You call symbol_request(nfsd_open_local_fh) and so get a reference to
> the nfsd module.  But you really want a reference to the nfsd service.
> 
> I would suggest that you use symbol_request() to get a function which
> you then call and immediately symbol_put().... unless you need to use it
> to discard the reference to the service later.

Getting the nfsd_open_local_fh symbol once when client handshakes with
server is meant to avoid needing to do so for every IO the client
issues to the local server.

> The function would take nfsd_mutex, check there is an nfsd_serv, sets a
> flag or whatever to indicate the serv is being used for local_io, and
> maybe returns the nfsd_serv.  As long as that flag is set the serv
> cannot be destroy.
>
> Do you need there to be available threads for LOCAL_IO to work?  If so
> the flag would cause setting the num threads to zero to fail.
> If not ....  that is weird.  It would mean that setting the number of
> threads to zero would not destroy the service and I don't think we want
> to do that.
> 
> So I think that when LOCAL_IO is in use, setting number of threads to
> zero must return EBUSY or similar, even if you don't need the threads.

Yes, but I really dislike needing to play games with a tangential
characteristic of nfsd_serv (that threads are what hold reference),
rather than have the ability to keep the nfsd_serv around in a cleaner
way.

This localio code doesn't run in nfsd context so it isn't using nfsd's
threads. Forcing threads to be held in reserve because localio doesn't
want nfsd_serv to go away isn't ideal.

Does it maybe make sense to introduce a more narrow svc_get/svc_put
for this auxillary usecase?

Thanks,
Mike

