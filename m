Return-Path: <linux-nfs+bounces-4203-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 65EE49117BC
	for <lists+linux-nfs@lfdr.de>; Fri, 21 Jun 2024 02:36:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A0691C224FE
	for <lists+linux-nfs@lfdr.de>; Fri, 21 Jun 2024 00:36:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D72A257D;
	Fri, 21 Jun 2024 00:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VYjD62Kd"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 464AD1366
	for <linux-nfs@vger.kernel.org>; Fri, 21 Jun 2024 00:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718929806; cv=none; b=Dvo3ar4A0hO5v/vvsO0tQnSIQR36JfNESyI/ZEFk0FDB6RK9rj9EZUDo4hTVXEK2oQHkC5KNf9+zCmLOv8l6F/+p4vrhYx1/9km6j2DTaBqT2niTuY2nvaOjE0C669fMUc0f6B5dvUJTgjMRCw5HsWsVOOV/YzS7D1mwaRKFcGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718929806; c=relaxed/simple;
	bh=lj4TiKpaiDsw0+1A+Jy8MTOgd9cLTPBi6FKXi6eRX7s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tknVAS41bnjYaimKkpcZu6rSO9kAVu4YZ2XPSq+4CaFiE6NQhu0Q8dE9mlurw7vGMbeEmt6C+7CE8ou/oTTZjIQW/UwUn37d4PgVOz4THmYR9bo6GhoQrC/c+dfoCNeE1SnTSrVL1Q3Z0Poez6A2ZgpWmvH06mmX+qJLXHzdbTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VYjD62Kd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94DCCC2BD10;
	Fri, 21 Jun 2024 00:30:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718929805;
	bh=lj4TiKpaiDsw0+1A+Jy8MTOgd9cLTPBi6FKXi6eRX7s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VYjD62KdYCXCeZyG8So75m/Lrn3DiPBdQeTmd70O/GiIhxMpsJB0ZdBHWLldZDgDv
	 9dK3nE7Ou8T1+hA9hfYtdJNs0keBBwcwgFjawGUa3fYZAE4UHLx3t3t7MvyFjkyJ86
	 BpG4ZUesO1+ZQYMxT8HAMaV49HKNNiF2v6a2qPPEV86Ni4KVj1jMXXL9kHLqhWs9cO
	 QeWu0ZtIjEYyG5XFu9+fgP0zReXQwkvsPGo8id1NaOMv6XJM8XyGpbHngcWlc49Udl
	 n78KuzMXAI5ikXJ+hOCFnwJjCAsfBFnp/p1SzBVaNzH0T7TfZzvRaKMr8IWSVKEzL9
	 IJG23QA1aeLAA==
Date: Thu, 20 Jun 2024 20:30:04 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: NeilBrown <neilb@suse.de>
Cc: Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org,
	Jeff Layton <jlayton@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>, snitzer@hammerspace.com
Subject: Re: [PATCH v6 17/18] nfs: add
 Documentation/filesystems/nfs/localio.rst
Message-ID: <ZnTJjKRiAHLz9GxG@kernel.org>
References: <>
 <ZnS7DsnrW7OX0rJC@tissot.1015granger.net>
 <171892694669.14261.4243996786790353819@noble.neil.brown.name>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <171892694669.14261.4243996786790353819@noble.neil.brown.name>

On Fri, Jun 21, 2024 at 09:42:26AM +1000, NeilBrown wrote:
> On Fri, 21 Jun 2024, Chuck Lever wrote:
> > On Thu, Jun 20, 2024 at 06:35:38PM -0400, Mike Snitzer wrote:
> > > On Fri, Jun 21, 2024 at 08:12:56AM +1000, NeilBrown wrote:
> > > > On Thu, 20 Jun 2024, Chuck Lever wrote:
> > > > > On Wed, Jun 19, 2024 at 04:40:31PM -0400, Mike Snitzer wrote:
> > > > > > This document gives an overview of the LOCALIO auxiliary RPC protocol
> > > > > > added to the Linux NFS client and server (both v3 and v4) to allow a
> > > > > > client and server to reliably handshake to determine if they are on the
> > > > > > same host.  The LOCALIO auxiliary protocol's implementation, which uses
> > > > > > the same connection as NFS traffic, follows the pattern established by
> > > > > > the NFS ACL protocol extension.
> > > > > > 
> > > > > > The robust handshake between local client and server is just the
> > > > > > beginning, the ultimate usecase this locality makes possible is the
> > > > > > client is able to issue reads, writes and commits directly to the server
> > > > > > without having to go over the network.  This is particularly useful for
> > > > > > container usecases (e.g. kubernetes) where it is possible to run an IO
> > > > > > job local to the server.
> > > > > > 
> > > > > > Signed-off-by: Mike Snitzer <snitzer@kernel.org>
> > > > > > ---
> > > > > >  Documentation/filesystems/nfs/localio.rst | 148 ++++++++++++++++++++++
> > > > > >  include/linux/nfslocalio.h                |   2 +
> > > > > >  2 files changed, 150 insertions(+)
> > > > > >  create mode 100644 Documentation/filesystems/nfs/localio.rst
> > > > > > 
> > > > > > diff --git a/Documentation/filesystems/nfs/localio.rst b/Documentation/filesystems/nfs/localio.rst
> > > > > > new file mode 100644
> > > > > > index 000000000000..a43c3dab2cab
> > > > > > --- /dev/null
> > > > > > +++ b/Documentation/filesystems/nfs/localio.rst
> > > > > > @@ -0,0 +1,148 @@
> > > > > > +===========
> > > > > > +NFS localio
> > > > > > +===========
> > > > > > +
> > > > > > +This document gives an overview of the LOCALIO auxiliary RPC protocol
> > > > > > +added to the Linux NFS client and server (both v3 and v4) to allow a
> > > > > > +client and server to reliably handshake to determine if they are on the
> > > > > > +same host.  The LOCALIO auxiliary protocol's implementation, which uses
> > > > > > +the same connection as NFS traffic, follows the pattern established by
> > > > > > +the NFS ACL protocol extension.
> > > > > > +
> > > > > > +The LOCALIO auxiliary protocol is needed to allow robust discovery of
> > > > > > +clients local to their servers.  Prior to this LOCALIO protocol a
> > > > > > +fragile sockaddr network address based match against all local network
> > > > > > +interfaces was attempted.  But unlike the LOCALIO protocol, the
> > > > > > +sockaddr-based matching didn't handle use of iptables or containers.
> > > > > > +
> > > > > > +The robust handshake between local client and server is just the
> > > > > > +beginning, the ultimate usecase this locality makes possible is the
> > > > > > +client is able to issue reads, writes and commits directly to the server
> > > > > > +without having to go over the network.  This is particularly useful for
> > > > > > +container usecases (e.g. kubernetes) where it is possible to run an IO
> > > > > > +job local to the server.
> > > > > > +
> > > > > > +The performance advantage realized from localio's ability to bypass
> > > > > > +using XDR and RPC for reads, writes and commits can be extreme, e.g.:
> > > > > > +fio for 20 secs with 24 libaio threads, 64k directio reads, qd of 8,
> > > > > > +-  With localio:
> > > > > > +  read: IOPS=691k, BW=42.2GiB/s (45.3GB/s)(843GiB/20002msec)
> > > > > > +-  Without localio:
> > > > > > +  read: IOPS=15.7k, BW=984MiB/s (1032MB/s)(19.2GiB/20013msec)
> > > > > > +
> > > > > > +RPC
> > > > > > +---
> > > > > > +
> > > > > > +The LOCALIO auxiliary RPC protocol consists of a single "GETUUID" RPC
> > > > > > +method that allows the Linux nfs client to retrieve a Linux nfs server's
> > > > > > +uuid.  This protocol isn't part of an IETF standard, nor does it need to
> > > > > > +be considering it is Linux-to-Linux auxiliary RPC protocol that amounts
> > > > > > +to an implementation detail.
> > > > > > +
> > > > > > +The GETUUID method encodes the server's uuid_t in terms of the fixed
> > > > > > +UUID_SIZE (16 bytes).  The fixed size opaque encode and decode XDR
> > > > > > +methods are used instead of the less efficient variable sized methods.
> > > > > > +
> > > > > > +The RPC program number for the NFS_LOCALIO_PROGRAM is currently defined
> > > > > > +as 0x20000002 (but a request for a unique RPC program number assignment
> > > > > > +has been submitted to IANA.org).
> > > > > > +
> > > > > > +The following approximately describes the LOCALIO in a pseudo rpcgen .x
> > > > > > +syntax:
> > > > > > +
> > > > > > +#define UUID_SIZE 16
> > > > > > +typedef u8 uuid_t<UUID_SIZE>;
> > > > > > +
> > > > > > +program NFS_LOCALIO_PROGRAM {
> > > > > > +     version NULLVERS {
> > > > > > +        void NULL(void) = 0;
> > > > > > +	} = 1;
> > > > > > +     version GETUUIDVERS {
> > > > > > +        uuid_t GETUUID(void) = 1;
> > > > > > +	} = 1;
> > > > > > +} = 0x20000002;
> > > > > > +
> > > > > > +The above is the skeleton for the LOCALIO protocol, it doesn't account
> > > > > > +for NFS v3 and v4 RPC boilerplate (which also marshalls RPC status) that
> > > > > > +is used to implement GETUUID.
> > > > > > +
> > > > > > +Here are the respective XDR results for nfsd and nfs:
> > > > > 
> > > > > Hi Mike!
> > > > > 
> > > > > A protocol spec describes the on-the-wire data formats, not the
> > > > > in-memory structure layouts. The below C structures are not
> > > > > relevant to this specification. This should be all you need here,
> > > > > if I understand your protocol correctly:
> > > > > 
> > > > > /* raw RFC 9562 UUID */
> > > > > #define UUID_SIZE 16
> > > > > typedef u8 uuid_t<UUID_SIZE>;
> > > > > 
> > > > > union GETUUID1res switch (uint32 status) {
> > > > 
> > > > I don't think we need a status in the protocol.  GETUUID always returns
> > > > a UUID.  There is no possible error condition.
> > > 
> > > By having localio use NFS's XDR we're able to piggyback on a status
> > > being returned by standard NFS RPC handling.
> > > 
> > > See:
> > > nfs3svc_encode_getuuidres and nfs4svc_encode_getuuidres.
> > > nfs3_xdr_dec_getuuidres and nfs4_xdr_dec_getuuidres (and note the
> > > FIXME comment about abusing nfs_opnum4).
> > 
> > No, let's not piggyback like that. Please make it a separate
> > XDR implementation just like NFSACL is. Again, LOCALIO is not
> > an extension of the NFS protocol. Making that claim confuses
> > people for whom the term "extension" has a very precise meaning.
> > If we were extending NFS, then yes, adding the new procedures
> > to the NFS XDR implementation is appropriate, but that's not
> > what you are doing: you are adding a new side-band protocol.
> 
> I'm currently working through the LOCALIO protocol code to make it a
> single version rather than '3' and '4'.  In the process I'm making it
> completely separate from the NFS protocol implementation and cleaning up
> some other bits.  e.g. it shouldn't register with rpcbind.
> 
> I'll hopefully post patches in a few hours.  I writing this now to
> discourage Mike from starting work on this.

Cool, thanks Neil!

