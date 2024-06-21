Return-Path: <linux-nfs+bounces-4202-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A27FB9117B9
	for <lists+linux-nfs@lfdr.de>; Fri, 21 Jun 2024 02:35:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4EB81C21B62
	for <lists+linux-nfs@lfdr.de>; Fri, 21 Jun 2024 00:35:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6290C625;
	Fri, 21 Jun 2024 00:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="En1CFkXE"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D1B3A34
	for <linux-nfs@vger.kernel.org>; Fri, 21 Jun 2024 00:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718929709; cv=none; b=mRbFkiO4VT0Aa/MAAMtVV44Tl0ykMsgTGKvBYyTRQfLTWDp5JG9zDyMrj5YqDkKI2F2m0EAkI7iW8KnvXkjKBzgMVr9rzWqHLgtIVFyu7cuyd2J8Q6EKmHYTH8Fsf4r2cOaZRjRY7Z+B4FdNze2jwaDn3cvWlgFGpyBp+242z3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718929709; c=relaxed/simple;
	bh=NDKSz6kz9heKy9APQVgLjLg0LXsp7+24WmubN4oDD60=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qFdV6I1BpFX8QUK2b4WtumO9+SBMoeOFUGFduS4a2kOG6fsU5siDDDwxttNNKtkQ+0PiPNKh/t9WobkboTEr6cOHeARTQ3gXsyLvTZi/y+2EuYYJjZKIqIexqQmRILytePumgjJ/wgBfTbsaQNy8DthVUr0c+qAX8MHgZJ3jYwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=En1CFkXE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4B5CC32781;
	Fri, 21 Jun 2024 00:28:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718929708;
	bh=NDKSz6kz9heKy9APQVgLjLg0LXsp7+24WmubN4oDD60=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=En1CFkXEIzLPaBOZIXXpRVWwS+4LtGZ/kJ1TUdLIb13Qmu5cLkfmB3T+e5C2cSiVW
	 0V5P+UGHsZP+cXbHKailfl7RpvGLjNyQKyF4cZzbXbLK9ssBBtGPOCY6f/lOBSgIfM
	 +s/nXq3k9A5y7jOJK7Qq43kHS2Rf70FISUuVEAFA6ZmZTkFESt0Hy+B/ShzE8VJ4X5
	 PM2eplHDAJQTU76Q0vrH5N2PoZnD0TVuogDCSxx/lrM6ZZYQUlsg1Q1p8x8ehk29L+
	 ciaTUX62I4ALdTCjMVvykQGDLH0NGX/COEHkCQSUEQL6yxrbFqHzl1Gt22AQL7HMUi
	 Co6HXUbxR7ZZw==
Date: Thu, 20 Jun 2024 20:28:27 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: NeilBrown <neilb@suse.de>, linux-nfs@vger.kernel.org,
	Jeff Layton <jlayton@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>, snitzer@hammerspace.com
Subject: Re: [PATCH v6 17/18] nfs: add
 Documentation/filesystems/nfs/localio.rst
Message-ID: <ZnTJK9xp7ZRoiYAt@kernel.org>
References: <>
 <ZnQ0FSQHJLPHxRsP@tissot.1015granger.net>
 <171892157698.14261.16357981881792326304@noble.neil.brown.name>
 <ZnSuunNIgmhERwCm@kernel.org>
 <ZnS7DsnrW7OX0rJC@tissot.1015granger.net>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZnS7DsnrW7OX0rJC@tissot.1015granger.net>

On Thu, Jun 20, 2024 at 07:28:14PM -0400, Chuck Lever wrote:
> On Thu, Jun 20, 2024 at 06:35:38PM -0400, Mike Snitzer wrote:
> > On Fri, Jun 21, 2024 at 08:12:56AM +1000, NeilBrown wrote:
> > > On Thu, 20 Jun 2024, Chuck Lever wrote:
> > > > On Wed, Jun 19, 2024 at 04:40:31PM -0400, Mike Snitzer wrote:
> > > > > This document gives an overview of the LOCALIO auxiliary RPC protocol
> > > > > added to the Linux NFS client and server (both v3 and v4) to allow a
> > > > > client and server to reliably handshake to determine if they are on the
> > > > > same host.  The LOCALIO auxiliary protocol's implementation, which uses
> > > > > the same connection as NFS traffic, follows the pattern established by
> > > > > the NFS ACL protocol extension.
> > > > > 
> > > > > The robust handshake between local client and server is just the
> > > > > beginning, the ultimate usecase this locality makes possible is the
> > > > > client is able to issue reads, writes and commits directly to the server
> > > > > without having to go over the network.  This is particularly useful for
> > > > > container usecases (e.g. kubernetes) where it is possible to run an IO
> > > > > job local to the server.
> > > > > 
> > > > > Signed-off-by: Mike Snitzer <snitzer@kernel.org>
> > > > > ---
> > > > >  Documentation/filesystems/nfs/localio.rst | 148 ++++++++++++++++++++++
> > > > >  include/linux/nfslocalio.h                |   2 +
> > > > >  2 files changed, 150 insertions(+)
> > > > >  create mode 100644 Documentation/filesystems/nfs/localio.rst
> > > > > 
> > > > > diff --git a/Documentation/filesystems/nfs/localio.rst b/Documentation/filesystems/nfs/localio.rst
> > > > > new file mode 100644
> > > > > index 000000000000..a43c3dab2cab
> > > > > --- /dev/null
> > > > > +++ b/Documentation/filesystems/nfs/localio.rst
> > > > > @@ -0,0 +1,148 @@
> > > > > +===========
> > > > > +NFS localio
> > > > > +===========
> > > > > +
> > > > > +This document gives an overview of the LOCALIO auxiliary RPC protocol
> > > > > +added to the Linux NFS client and server (both v3 and v4) to allow a
> > > > > +client and server to reliably handshake to determine if they are on the
> > > > > +same host.  The LOCALIO auxiliary protocol's implementation, which uses
> > > > > +the same connection as NFS traffic, follows the pattern established by
> > > > > +the NFS ACL protocol extension.
> > > > > +
> > > > > +The LOCALIO auxiliary protocol is needed to allow robust discovery of
> > > > > +clients local to their servers.  Prior to this LOCALIO protocol a
> > > > > +fragile sockaddr network address based match against all local network
> > > > > +interfaces was attempted.  But unlike the LOCALIO protocol, the
> > > > > +sockaddr-based matching didn't handle use of iptables or containers.
> > > > > +
> > > > > +The robust handshake between local client and server is just the
> > > > > +beginning, the ultimate usecase this locality makes possible is the
> > > > > +client is able to issue reads, writes and commits directly to the server
> > > > > +without having to go over the network.  This is particularly useful for
> > > > > +container usecases (e.g. kubernetes) where it is possible to run an IO
> > > > > +job local to the server.
> > > > > +
> > > > > +The performance advantage realized from localio's ability to bypass
> > > > > +using XDR and RPC for reads, writes and commits can be extreme, e.g.:
> > > > > +fio for 20 secs with 24 libaio threads, 64k directio reads, qd of 8,
> > > > > +-  With localio:
> > > > > +  read: IOPS=691k, BW=42.2GiB/s (45.3GB/s)(843GiB/20002msec)
> > > > > +-  Without localio:
> > > > > +  read: IOPS=15.7k, BW=984MiB/s (1032MB/s)(19.2GiB/20013msec)
> > > > > +
> > > > > +RPC
> > > > > +---
> > > > > +
> > > > > +The LOCALIO auxiliary RPC protocol consists of a single "GETUUID" RPC
> > > > > +method that allows the Linux nfs client to retrieve a Linux nfs server's
> > > > > +uuid.  This protocol isn't part of an IETF standard, nor does it need to
> > > > > +be considering it is Linux-to-Linux auxiliary RPC protocol that amounts
> > > > > +to an implementation detail.
> > > > > +
> > > > > +The GETUUID method encodes the server's uuid_t in terms of the fixed
> > > > > +UUID_SIZE (16 bytes).  The fixed size opaque encode and decode XDR
> > > > > +methods are used instead of the less efficient variable sized methods.
> > > > > +
> > > > > +The RPC program number for the NFS_LOCALIO_PROGRAM is currently defined
> > > > > +as 0x20000002 (but a request for a unique RPC program number assignment
> > > > > +has been submitted to IANA.org).
> > > > > +
> > > > > +The following approximately describes the LOCALIO in a pseudo rpcgen .x
> > > > > +syntax:
> > > > > +
> > > > > +#define UUID_SIZE 16
> > > > > +typedef u8 uuid_t<UUID_SIZE>;
> > > > > +
> > > > > +program NFS_LOCALIO_PROGRAM {
> > > > > +     version NULLVERS {
> > > > > +        void NULL(void) = 0;
> > > > > +	} = 1;
> > > > > +     version GETUUIDVERS {
> > > > > +        uuid_t GETUUID(void) = 1;
> > > > > +	} = 1;
> > > > > +} = 0x20000002;
> > > > > +
> > > > > +The above is the skeleton for the LOCALIO protocol, it doesn't account
> > > > > +for NFS v3 and v4 RPC boilerplate (which also marshalls RPC status) that
> > > > > +is used to implement GETUUID.
> > > > > +
> > > > > +Here are the respective XDR results for nfsd and nfs:
> > > > 
> > > > Hi Mike!
> > > > 
> > > > A protocol spec describes the on-the-wire data formats, not the
> > > > in-memory structure layouts. The below C structures are not
> > > > relevant to this specification. This should be all you need here,
> > > > if I understand your protocol correctly:
> > > > 
> > > > /* raw RFC 9562 UUID */
> > > > #define UUID_SIZE 16
> > > > typedef u8 uuid_t<UUID_SIZE>;
> > > > 
> > > > union GETUUID1res switch (uint32 status) {
> > > 
> > > I don't think we need a status in the protocol.  GETUUID always returns
> > > a UUID.  There is no possible error condition.
> > 
> > By having localio use NFS's XDR we're able to piggyback on a status
> > being returned by standard NFS RPC handling.
> > 
> > See:
> > nfs3svc_encode_getuuidres and nfs4svc_encode_getuuidres.
> > nfs3_xdr_dec_getuuidres and nfs4_xdr_dec_getuuidres (and note the
> > FIXME comment about abusing nfs_opnum4).
> 
> No, let's not piggyback like that. Please make it a separate
> XDR implementation just like NFSACL is. Again, LOCALIO is not
> an extension of the NFS protocol. Making that claim confuses
> people for whom the term "extension" has a very precise meaning.
> If we were extending NFS, then yes, adding the new procedures
> to the NFS XDR implementation is appropriate, but that's not
> what you are doing: you are adding a new side-band protocol.

I reworded yesterday, when you seized on my saying "extension" in the
Documentation before and I changed it to "auxilliary" (I used
"extension" because that's how NFS ACL was framed, I had no idea it
was a loaded or nuanced term).  localio the protocol amounts to a
single RPC, no idea why I need to implement/duplicate a bunch of
boilerplate code to add a single GETUUID RPC. Localio as submitted
isn't concerned with some weird hijacking/extension of the NFS
protocol, it is enabling the NFS client and server to be more
efficient with how it fulfills IO.  Localio has no tie to NFS other
than it serves as connective glue between the NFS client and server
to optimize reads, writes, and commits.
 
> I have a long-term goal to ensure we can generate the source
> code of the XDR layer of all the kernel RPC protocols via an
> rpcgen like tool. A code generator can ensure that the
> marshalling and unmarshalling code is memory-safe.

The code doesn't show itself to be developed with such code generation
at all.  If anything it all feels very open-coded.

> By piggybacking, you are building LOCALIO into another
> protocol's XDR implementation, which makes it a special case,
> and thus harder to implement via code that is generated
> automatically from unmodified XDR language specs.

GETUUID really couldn't be simpler.  I'll do whatever you think best,
but I just want to be clear: when told to implement a side-band
protocol to coordinate I distilled it down to "I need a unique UUID
from the server" (hence GETUUID). When implementing it I set out to
work with what I saw in the existing code -- not reinvent boilerplate
code.  NFS ACL did that.  If I went further by (ab)using NFS xdr
helpers it was because I didn't want to write that code. If asked to
decouple, I'm just going to factor out cleaner code that LOCALIO and
NFS share to do what I already have it doing.

> Maybe the client side maintainers don't care about that, but
> please don't piggyback LOCALIO onto the NFSD's NFS XDR
> implementation.
> 
> Then, if it's a separate implementation, you can remove the status
> code. I was wondering why the server would reply with an error. If
> LOCALIO/GETUUID is not supported, then an RPC level error occurs
> anyway.

In my extensive discovery by trial and error I found that the NFS
status codes and infrastructure necessary. Otherwise basic/advanced
connectivity issues with sunrpc et al aren't accounted for properly.
NFS is pretty tightly coupled to sunrpc, and vice-versa.  Not
following why things have all of a sudden gotten "heightened", guess I
chose the wrong word ("piggybacking") when being very clear about what
the LOCALIO protocol does: piggyback on NFS XDR methods. I'm really
caught out for that being viewed as so bad (but my FIXME in
nfs4_xdr_dec_getuuidres really does need fixing).

> If you think you need an error like "Yes, I recognize that program
> and procedure, but this file system doesn't allow local access
> in any case" then that needs to be added to the protocol XDR
> specification.

The NFS status baked into NFS RPCs offer utility.

LOCALIO is not a standard, and we all agreed it doesn't need to be.
But it obviously cannot be fragile, etc.  SO I'm the new guy, happy to
"suffer".. however I would like to suffer less for being an open-book
about the code I've written and submitted ;)

> > Not sure how the reality of piggbacking on NFS XDR should be captured
> > in the protocol spec here.
> 
> It's an implementation choice, so it doesn't belong in the protocol
> spec that, again, lays out only on-the-wire behavior,.
> 
> Implementation specifics can be discussed in another section of the
> document.
> 
> 
> > > I don't think we need the NULL procedure either, but that is such a
> > > deeply entrenched practice I won't argue the point.
> > 
> > The code required it be there, I unfortunately don't recall specifics
> > on what failed if it wasn't there (may have been rpc_bind_new_program).
> 
> Please leave the NULL procedure where it is. Note that the NFS
> program's NULL procedure is used in two rather significant ways:
> 
>  - As a carrier for GSSAPI messages
>  - As a probe for the RPC-with-TLS capability
> 
> The latter might be significant if a client sends a LOCALIO
> operation as the first RPC procedure when contacting an unfamiliar
> server -- if it wants TLS protection for that procedure, then it
> will need to send a NULL(RPC_AUTH_TLS) as the very first RPC
> transaction.
> 
> Since LOCALIO/GETUUID is going over the network sometimes, it's
> reasonable to expect that these security measures could be used.

LOCALIO's GETUUID goes over the network all the time.  And it
literally needs to, and does, clone the NFS rpc client with:
rpc_bind_new_program(clp->cl_rpcclient

Mike

