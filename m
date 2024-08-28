Return-Path: <linux-nfs+bounces-5839-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B360961C21
	for <lists+linux-nfs@lfdr.de>; Wed, 28 Aug 2024 04:32:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E32FC1F245A8
	for <lists+linux-nfs@lfdr.de>; Wed, 28 Aug 2024 02:32:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3678125BA;
	Wed, 28 Aug 2024 02:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kIlnOSEL"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EE9A8F49
	for <linux-nfs@vger.kernel.org>; Wed, 28 Aug 2024 02:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724812348; cv=none; b=mdMDxlD2RjoF5gL33bw7T0+76ckPngeEVLNxVqHpsU1uNzH3EglOleY8RqplF6Gc5WA2PI5hjibh165+a1UW4ZEqEFf6tIPjjEUJmBdQJAvtSxwbalI3oRC/mAYHAYz/7DBlS2j9lAEuW88oF4/zFcLc7jKSP0Ky/Z00gwI3/eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724812348; c=relaxed/simple;
	bh=36rmzC3pwgsOTT+SWLT5JNyX5FHrXjutAo21/rtMGew=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JEIslPDoaCEZBRZpH90FSoKVON2wyA2w1O5RrVrNs7fkmiwWqrd2MDfk4xbPJvF9FoldUAatEOx0YVWEcOvdjleNfY2NhkMNRgdYXb0Y0hysfv0Wy97RBhXdztVSiAf/sWsWbtsms6Ubg1OIJlO2gRasde6qsLvE7aGUcxkRbi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kIlnOSEL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6D22C32782;
	Wed, 28 Aug 2024 02:32:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724812348;
	bh=36rmzC3pwgsOTT+SWLT5JNyX5FHrXjutAo21/rtMGew=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kIlnOSELpHOPpQnoyF7N/WhXNmxWlWKu4vMm66rxsHGaBZmNFjgYvIC44pAfWHC4b
	 wwXzEf3e+NTLwj95giGevzryz/tTGPAYikEiCOeqAcyllo513dvtc2JtKjP9DH1Va9
	 Wzmq2hcrtgnOUDb25Dm7l0G6Rpfg5tL5YjSEefdi1Inu6H56xiXmBo0c12F6FS0f3E
	 zotvxjm9SpDPbKwvk//xsoUSRyBTFmz8fyH4r6lPiX7XrEiECD/js3tUUJclVL+G+q
	 cfrgwlbOZ+Z8fZdEwtE5TePZ/c79MkszeuT/Snp2VNrIwHLDL88E8ZaqnwHgrfLEWr
	 C35QFONOjYl7Q==
Date: Tue, 27 Aug 2024 22:32:26 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: cel@kernel.org
Cc: Neil Brown <neilb@suse.de>, linux-nfs@vger.kernel.org,
	Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [RFC PATCH 0/6] Split up refactoring of fh_verify()
Message-ID: <Zs6MOlIHcm6CoEX1@kernel.org>
References: <20240828004445.22634-1-cel@kernel.org>
 <Zs54kI1KA407SDqQ@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zs54kI1KA407SDqQ@kernel.org>

On Tue, Aug 27, 2024 at 09:08:32PM -0400, Mike Snitzer wrote:
> On Tue, Aug 27, 2024 at 08:44:39PM -0400, cel@kernel.org wrote:
> > From: Chuck Lever <chuck.lever@oracle.com>
> > 
> > These six patches are meant to replace:
> > 
> >   nfsd: factor out __fh_verify to allow NULL rqstp to be passed
> >   nfsd: add nfsd_file_acquire_local()
> > 
> > I've removed the @nfs_vers parameter to __fh_verify(), and tried
> > something a little different with the trace points. Please check
> > my math.
> > 
> > These have been compile-tested, but no more than that. Interested in
> > comments.
> 
> Reviewed quickly just now, nicely done!
> 
> I'll go over it very carefully now by replacing the 2 patches you
> noted and updating the localio patches thaa follow.  I noticed some
> typos and mentioning nfs_vers usage in a header despite you having
> removed the need to pass it. So I'll fix up those nits along the way.
> 
> But I just wanted to immediately say: thanks!

I reviewed and incorporated your 6 patches and successfully tested the
result (by issuing IO with and without LOCALIO enabled with both NFS
v3 and NFS v4.2).

I've pushed the latest code to my branch:
https://git.kernel.org/pub/scm/linux/kernel/git/snitzer/linux.git/log/?h=nfs-localio-for-next

I'm approaching the end of addressing all the v13 review feedback, but
still have to sort through a couple issues that Neil pointed out about
nfs_local_disable() racing with nfsd_open_local_fh().

But in case you're curious here is a preview of the changelog for
what'll be in v14 (hopefully will post by end of day tomorrow):

- Extended the nn->nfsd_serv reference lifetime to be identical to the
  nfsd_file (until after localio's IO is complete), suggested by Neil.
  This is made easier by introducing a 'struct nfs_localio_ctx' that
  contains both the 'nfsd_file' and 'nfsd_net' associated with
  localio.

- Switched nfs_common's 'nfs_to' symbol management locking from using
  mutex to spinlock, suggested by Neil.

- Eliminated nfs_local_file_open() by folding it into
  nfs_local_open_fh(), suggested by Neil.

- Update nfs_uuid_is_local() to get reference on the net, drop it in
  nfs_local_disable(), suggested by Neil.

- Pushed saving/restoring of client's cred down from
  nfsd_open_local_fh() to nfsd_file_acquire_local(), suggested by
  Neil.

- Updated NFSD_LOCALIO in fs/nfsd/Kconfig to explicitly 'default n'
  and improve description, suggested by Chuck. Also made the same
  updates to NFS_LOCALIO in fs/nfs/Kconfig.

- Split out a separate preliminary patch that introduces
  nfsd_serv_try_get() and nfsd_serv_put() and the associated
  percpu_ref, suggested by Chuck.

- Improved "Always allow LOCALIO" comment in check_nfsd_access() and
  added Kdoc above check_nfsd_access(), suggested by Chuck.

- Moved rpcauth_map_clnt_to_svc_cred_local from net/sunrpc/auth.c to
  net/sunrpc/svcauth.c and renamed it to
  svcauth_map_clnt_to_svc_cred_local. Also added kdoc. Suggested by
  Chuck.

- Added Chuck's Acked-by to 2 patches

- Incorporated Chuck's 6 patches that split up and improved the
  __fh_verify and nfsd_file_acquire_local patches.

