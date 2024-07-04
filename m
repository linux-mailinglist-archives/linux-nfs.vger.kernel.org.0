Return-Path: <linux-nfs+bounces-4626-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 58FEA927D10
	for <lists+linux-nfs@lfdr.de>; Thu,  4 Jul 2024 20:31:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC5D31F2475C
	for <lists+linux-nfs@lfdr.de>; Thu,  4 Jul 2024 18:31:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F1E312E1D2;
	Thu,  4 Jul 2024 18:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P7otdryn"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B25074BF5
	for <linux-nfs@vger.kernel.org>; Thu,  4 Jul 2024 18:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720117908; cv=none; b=m22rKVUN8m/jEXvzEyfxtF/+qV/Uetb+mOiVORL1phhrI+aYkY8YxhYA01lgJEvUiEDFcRR3i5Pg9RtlFUkv988tFFmg4RVhBCJcOYHwGRcPA8h3gqZuYNKTXiT0bLyA1aMbjm6S/PRiyiMRUTpu8QLJh/9XxH2K5D1j1CvxFXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720117908; c=relaxed/simple;
	bh=TPYqVYa1MPItBLwBZ0F+UvGN+uN64z5ybgqK8flHX4w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gL+VFf6vXoJD2xstf+tuKc/gatPLpFSQwP6gkAiHzRtvZU764vxVgwDtCAV/z6NZ8xxrLcGQTI5h/uDTaXtAkjMjpnXRYNyx9m/VZyF28Jcjl1jObNuFoA4/c9I3UqGmaDtKsSh4cziSb2artU/PKPVmn+5GGMvrtyWIRer4zJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P7otdryn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF6D9C3277B;
	Thu,  4 Jul 2024 18:31:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720117907;
	bh=TPYqVYa1MPItBLwBZ0F+UvGN+uN64z5ybgqK8flHX4w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=P7otdrynja5Dgexb+u2FBwlaiTGPfVb27rXozQU6xORXEvgJEr2HG4KPtOnrLuTNt
	 YhyBawFe238g8EoyBcK6j75Zeb2NkWxcpEzOU/vdA3xi5JeqgTyd0e2lV/L4VcOTN1
	 NO23JD5iP4WlfLgecUmCZR0oHmvBcIxzX6GaXlVDoKG13zEnAI13LeWCVCg7kqf/VM
	 nGJfac4cmcm7eI6+9Zc8wKeATVAJ4430rr8zUIme1hY2CEO5GCfKZnp+2oXt62J/fO
	 MTAUnFM2BGg7rXVa4q6+LY+KVvDDWt52NK0IQonfOOVwI60x4mhkw3WmSI3fqFMRnK
	 0YuTNEztEN+zg==
Date: Thu, 4 Jul 2024 14:31:46 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever III <chuck.lever@oracle.com>,
	Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>,
	Neil Brown <neilb@suse.de>, Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH v11 00/20] nfs/nfsd: add support for localio
Message-ID: <ZobqkgBeQaPwq7ly@kernel.org>
References: <3A583EDC-519C-4820-87E9-F4DC164656DB@oracle.com>
 <ZoTb-OiUB5z4N8Jy@infradead.org>
 <ZoURUoz1ZBTZ2sr_@kernel.org>
 <ZoVdP-S01NOyZqlQ@infradead.org>
 <ZoVqN7J6vbl0BzIl@kernel.org>
 <ZoVrqp-EpkPAhTGs@infradead.org>
 <F1585F6E-8C41-4361-B4FA-F9BD6E26F3A9@oracle.com>
 <ZoVv4IVNC2dP1EaM@kernel.org>
 <4486ee80a487c174ec88c7e12705d99e22ae812a.camel@kernel.org>
 <ZoY6e-BmRJFLkziG@infradead.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZoY6e-BmRJFLkziG@infradead.org>

On Wed, Jul 03, 2024 at 11:00:27PM -0700, Christoph Hellwig wrote:
> On Wed, Jul 03, 2024 at 01:06:51PM -0400, Jeff Layton wrote:
> > The other problem with doing this is that if a server is running in a
> > container, how is it to know that the client is in different container
> > on the same host, and hence that it can give out a localio layout? We'd
> > still need some way to detect that anyway, which would probably look a
> > lot like the localio protocol.

(NOTE, Jeff's message above was him stating flaws in his O_TMPFILE
idea that we discussed at LSF, his idea wasn't pusued for many
reasons. And Jeff has stated he believes localio better)

> We'll need some way to detect that client and server are capable
> of the bypass.  And from all it looks that's actually the hard and
> complicated part, and we'll need that for any scheme.

Yes, hence the localio protocol that has wide buyin.  To the point I
ran with registering an NFS Program number with iana.org for the
effort.  My doing the localio protocol was born out of the requirement
to support NFSv3.

Neil's proposed refinement to add a a localio auth_domain to the
nfsd_net and his proposed risk-averse handshake within the localio
protocol will both improve security.

> And then we need a way to bypass the server for I/O, which currently is
> rather complex in the patchset and would be almost trivial with a new
> pNFS layout.

Some new layout misses the entire point of having localio work for
NFSv3 and NFSv4.  NFSv3 is very ubiquitous.

And in this localio series, flexfiles is trained to use localio.
(Which you apparently don't recognize or care about because nfsd
doesn't have flexfiles server support).

> > Can the client use its localio access to bypass that since it's not
> > going across the network anymore? Maybe by using open_by_handle_at on
> > the NFS share on a guessed filehandle? I think we need to ensure that
> > that isn't possible.
> 
> If a file system is shared by containers and users in containers have
> the capability to use open_by_handle_at the security model is already
> broken without NFS or localio involved.

Containers deployed by things like podman.io and kubernetes are
perfectly happy to allow containers permission to drive knfsd threads
in the host kernel.  That this is foreign to you is odd.

An NFS client that happens to be on the host should work perfectly
fine too (if it has adequate permissions).

> > I wonder if it's also worthwhile to gate localio access on an export
> > option, just out of an abundance of caution.
> 
> export and mount option.  We're speaking a non-standard side band
> protocol here, there is no way that should be done without explicit
> opt-in from both sides.

That is already provided my existing controls.  With both Kconfig
options that default to N, and the ability to disable the use of
localio entirely even if enabled in the Kconfig:
echo N > /sys/module/nfs/parameters/localio_enabled

And then ontop of it you have to loopback NFS mount.


