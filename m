Return-Path: <linux-nfs+bounces-4088-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EBF790F60A
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Jun 2024 20:27:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1AD01C215A6
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Jun 2024 18:27:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09A6215698D;
	Wed, 19 Jun 2024 18:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ER3sIalh"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA1FB15252C
	for <linux-nfs@vger.kernel.org>; Wed, 19 Jun 2024 18:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718821638; cv=none; b=dBPdGyXCgT95M+i01udpuuimcOVDc+OTRYat9Vety37BVyUr6YkFth94qB+TMHTGRsFv+yvil2dBTLQ46Xd8eTebWUlvhrLGSq+WmopDEY5ZjAxHrwcGDC3esv2c9Q35OHd1N14zn9roUT74l9QySsgYAuO2xBvGaDXtGZ3nhJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718821638; c=relaxed/simple;
	bh=S60GYBN2p2y8Mn5gFO73cCsdNp/Y+R1egxZthLLsVG0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l9bd130h219beoeXn6YSm9OVStdtLRDUKMxAcB3BCyDNE11zo3vJIWXEx+ACNYczcROpewQNijlPjldSPiVgvHt6WHXFSw7ABHzZT3PzVQomtpCParG6porssGrRACGphHSvyt6cKaG7EQgLY9h2S/Q+jmhgc5sbumkp3o7cns8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ER3sIalh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 218D7C2BBFC;
	Wed, 19 Jun 2024 18:27:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718821638;
	bh=S60GYBN2p2y8Mn5gFO73cCsdNp/Y+R1egxZthLLsVG0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ER3sIalh1BuaA4TXMniA7TS3Vrk8QdxBYNxSm2Hwdk+NEOJfCE20FdAJitDwm5EKq
	 nk3OVJl714anglzp41s5DNlIb+zfdBs2gMjtLh8BOpolps2NijxS+Js4X1AmVvHsOI
	 ngP1Pv2Bj2QqfbolKQ6F8izdv3LppfNWsE54meVqknf/AJ8fnGbAfl+zno4eAbgzCv
	 M6Si29j5uhf5/aB7r9Y3SPQRUUXAcVuPlYWQc7DlzemsRrUR1xIbiSrPi2d76vxPB9
	 NXSVZR89dxZiJB+gtxXGeNqf1MruM/03mBdVI5OpyiHXDYnyHr7Y6bA5xPkLjBGhJR
	 qTPH5BwtSf0RA==
Date: Wed, 19 Jun 2024 14:27:17 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: NeilBrown <neilb@suse.de>
Cc: Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org,
	Jeff Layton <jlayton@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>, snitzer@hammerspace.com
Subject: Re: [PATCH v5 19/19] nfs: add
 Documentation/filesystems/nfs/localio.rst
Message-ID: <ZnMjBazCgoCd9jHh@kernel.org>
References: <>
 <ZnIAMJ0wqjcTBszm@tissot.1015granger.net>
 <171877602532.14261.15898737346476163897@noble.neil.brown.name>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <171877602532.14261.15898737346476163897@noble.neil.brown.name>

On Wed, Jun 19, 2024 at 03:47:05PM +1000, NeilBrown wrote:
> On Wed, 19 Jun 2024, Chuck Lever wrote:
> > On Tue, Jun 18, 2024 at 04:19:49PM -0400, Mike Snitzer wrote:
> > > This document gives an overview of the LOCALIO protocol extension
> > > added to the Linux NFS client and server (both v3 and v4) to allow a
> > > client and server to reliably handshake to determine if they are on
> > > the same host.  The LOCALIO protocol extension follows the well-worn
> > > pattern established by the ACL protocol extension.
> > > 
> > > The robust handshake between local client and server is just the
> > > beginning, the ultimate use-case this locality makes possible is the
> > > client is able to issue reads, writes and commits directly to the
> > > server without having to go over the network.
> > > 
> > > Signed-off-by: Mike Snitzer <snitzer@kernel.org>
> > > ---
> > >  Documentation/filesystems/nfs/localio.rst | 101 ++++++++++++++++++++++
> > >  include/linux/nfslocalio.h                |   2 +
> > >  2 files changed, 103 insertions(+)
> > >  create mode 100644 Documentation/filesystems/nfs/localio.rst
> > > 
> > > diff --git a/Documentation/filesystems/nfs/localio.rst b/Documentation/filesystems/nfs/localio.rst
> > > new file mode 100644
> > > index 000000000000..4b4595037a7f
> > > --- /dev/null
> > > +++ b/Documentation/filesystems/nfs/localio.rst
> > > @@ -0,0 +1,101 @@
> > > +===========
> > > +NFS localio
> > > +===========
> > > +
> > > +This document gives an overview of the LOCALIO protocol extension added
> > > +to the Linux NFS client and server (both v3 and v4) to allow a client
> > > +and server to reliably handshake to determine if they are on the same
> > > +host.  The LOCALIO protocol extension follows the well-worn pattern
> > > +established by the ACL protocol extension.
> > > +
> > > +The LOCALIO protocol extension is needed to allow robust discovery of
> > > +clients local to their servers.  Prior to this extension a fragile
> > > +sockaddr network address based match against all local network
> > > +interfaces was attempted.  But unlike the LOCALIO protocol extension,
> > > +the sockaddr-based matching didn't handle use of iptables or containers.
> > > +
> > > +The robust handshake between local client and server is just the
> > > +beginning, the ultimate use-case this locality makes possible is the
> > > +client is able to issue reads, writes and commits directly to the server
> > > +without having to go over the network.  This is particularly useful for
> > > +container usecases (e.g. kubernetes) where it is possible to run an IO
> > > +job local to the server.
> > > +
> > > +The performance advantage realized from localio's ability to bypass
> > > +using XDR and RPC for reads, writes and commits can be extreme, e.g.:
> > > +fio for 20 secs with 24 libaio threads, 64k directio reads, qd of 8,
> > > +-  With localio:
> > > +  read: IOPS=691k, BW=42.2GiB/s (45.3GB/s)(843GiB/20002msec)
> > > +-  Without localio:
> > > +  read: IOPS=15.7k, BW=984MiB/s (1032MB/s)(19.2GiB/20013msec)
> > > +
> > > +RPC
> > > +---
> > > +
> > > +The LOCALIO RPC protocol consists of a single "GETUUID" RPC that allows
> > > +the client to retrieve a server's uuid.  LOCALIOPROC_GETUUID encodes the
> > > +server's uuid_t in terms of the fixed UUID_SIZE (16 bytes).  The fixed
> > > +size opaque encode and decode XDR methods are used instead of the less
> > > +efficient variable sized methods.
> > 
> > I'm reading between the lines ("well-worn pattern established by
> > the [NFS]ACL protocol"). I'm guessing that the client and server
> > will exchange this protocol on the same connection as NFS traffic?
> > 
> > The use of the term "extension" in this Document might be atypical.
> > An /extension/ means that the base RPC program (NFS in this case)
> > is somehow modified. However, if LOCALIO is a distinct RPC program
> > then this isn't an extension of the NFS protocol, per se.
> > 
> > A protocol spec needs to include:
> > 
> > o The RPC program and version number
> > 
> > o A description of each its procedures, along with an XDR definition
> >   of its arguments and results
> > 
> > o Any related constants or bit mask values
> 
> Note that providing this information in the format of a ".x" file as
> understood by rpcgen is a good approach.

I've approximated that in an update for v6, but I'm sure it'll leave
you and Chuck wanting ;)
 
> It isn't clear to me why you implement both v3 and v4 of the LOCALIO
> program.  I don't see how they relate to the NFS protocol version.  Just
> implement v1 which simply returns the UUID.

Yeah, I'd love to pull it out to be standalone but in practice the
pattern I followed from NFS ACL (to use rpc_bind_new_program) took me
down the path of implementing it for both v3 and v4.  It did help to
put the endpoints to action by leveraging what NFS already provides
for encoding status though.

Would be nice to avoid it but it isn't immediately clear to me how.
Can be done as followup work but it'd take me some time to sort it
out -- might be you could cut through it more easily?

Only having a single LOCALIO protocol version would allow for
nfs_init_localioclient() to not need 'vers' to be specified. And it'd
remove the need for the .init_localioclient hook I added (as well as
the use of __always_inline to share nfs_init_localioclient between
fs/nfs/nfs[34]client.c)

Mike

