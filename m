Return-Path: <linux-nfs+bounces-4197-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CB1B9115C5
	for <lists+linux-nfs@lfdr.de>; Fri, 21 Jun 2024 00:35:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B13F4B2113A
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Jun 2024 22:35:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B855F381AD;
	Thu, 20 Jun 2024 22:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WwJSYcGo"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93CDC36126
	for <linux-nfs@vger.kernel.org>; Thu, 20 Jun 2024 22:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718922940; cv=none; b=NzKvDyVWdyKUtalBTrXz/jWylaAfPfAr/bvfNFE36ag81TM7QHDixk7SPVcWlvYoBLxm6v5o9nFwqzAXgUSIQzejDXiK2p1On3iEUwTSG3/zNvnsSPoGLtlMDwck5WiRMaV2Tcv0IVRYMkLibXffg4EnruK98WsnDYuXzqFDQ8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718922940; c=relaxed/simple;
	bh=8XHyzzowKJ9rKC6rd3tCm483CJCgY66W0oFNSyMEpzs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OE7e2ecaUQeaBJ7kwu0gIVK/t31rEeIp8vVUbbAanAdoABYMEi032ey1FUbdYo8VsfYgwi2HM7sklSYTNUbxGc9PMzyOSc0YZhHc/t8LKZUT39tH60UPszTS2vtPmS49BhddyfraoKt6x7HEKv0/JF4z+X1dzDNAP3/aYItsqyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WwJSYcGo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED0C1C2BD10;
	Thu, 20 Jun 2024 22:35:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718922940;
	bh=8XHyzzowKJ9rKC6rd3tCm483CJCgY66W0oFNSyMEpzs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WwJSYcGoOcGK4E3JVmvUUH7tZh6XEZMvOpAy5ddasMQPGT0kSmth67DA0NT4JYnP1
	 jabjvOejD/gPBi8oxNdI0DVmKuWmq5CuzCuyjfGOzK35bUB+KCGxzHW7UABvMDiB+K
	 xQmZWfW3YW6BpWKMyvfJKII860Vlsb8BtCrB5ViTe2BLf9O80pLwzLtAftx1HDHHyO
	 aj20hLa9x50CpJ5yvpVnMJZpR3wlxWPRWCYY8QOnt6iNpYHGKruN8V/OiMiFjCd0l/
	 19i8LF27r1urFst06tjxNzrEH8qUctmcv4H9RAaF2Xh3/Xnzy9UAGyBfjkoewYu2S8
	 tlq4M9jD3wwrA==
Date: Thu, 20 Jun 2024 18:35:38 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: NeilBrown <neilb@suse.de>
Cc: Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org,
	Jeff Layton <jlayton@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>, snitzer@hammerspace.com
Subject: Re: [PATCH v6 17/18] nfs: add
 Documentation/filesystems/nfs/localio.rst
Message-ID: <ZnSuunNIgmhERwCm@kernel.org>
References: <>
 <ZnQ0FSQHJLPHxRsP@tissot.1015granger.net>
 <171892157698.14261.16357981881792326304@noble.neil.brown.name>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <171892157698.14261.16357981881792326304@noble.neil.brown.name>

On Fri, Jun 21, 2024 at 08:12:56AM +1000, NeilBrown wrote:
> On Thu, 20 Jun 2024, Chuck Lever wrote:
> > On Wed, Jun 19, 2024 at 04:40:31PM -0400, Mike Snitzer wrote:
> > > This document gives an overview of the LOCALIO auxiliary RPC protocol
> > > added to the Linux NFS client and server (both v3 and v4) to allow a
> > > client and server to reliably handshake to determine if they are on the
> > > same host.  The LOCALIO auxiliary protocol's implementation, which uses
> > > the same connection as NFS traffic, follows the pattern established by
> > > the NFS ACL protocol extension.
> > > 
> > > The robust handshake between local client and server is just the
> > > beginning, the ultimate usecase this locality makes possible is the
> > > client is able to issue reads, writes and commits directly to the server
> > > without having to go over the network.  This is particularly useful for
> > > container usecases (e.g. kubernetes) where it is possible to run an IO
> > > job local to the server.
> > > 
> > > Signed-off-by: Mike Snitzer <snitzer@kernel.org>
> > > ---
> > >  Documentation/filesystems/nfs/localio.rst | 148 ++++++++++++++++++++++
> > >  include/linux/nfslocalio.h                |   2 +
> > >  2 files changed, 150 insertions(+)
> > >  create mode 100644 Documentation/filesystems/nfs/localio.rst
> > > 
> > > diff --git a/Documentation/filesystems/nfs/localio.rst b/Documentation/filesystems/nfs/localio.rst
> > > new file mode 100644
> > > index 000000000000..a43c3dab2cab
> > > --- /dev/null
> > > +++ b/Documentation/filesystems/nfs/localio.rst
> > > @@ -0,0 +1,148 @@
> > > +===========
> > > +NFS localio
> > > +===========
> > > +
> > > +This document gives an overview of the LOCALIO auxiliary RPC protocol
> > > +added to the Linux NFS client and server (both v3 and v4) to allow a
> > > +client and server to reliably handshake to determine if they are on the
> > > +same host.  The LOCALIO auxiliary protocol's implementation, which uses
> > > +the same connection as NFS traffic, follows the pattern established by
> > > +the NFS ACL protocol extension.
> > > +
> > > +The LOCALIO auxiliary protocol is needed to allow robust discovery of
> > > +clients local to their servers.  Prior to this LOCALIO protocol a
> > > +fragile sockaddr network address based match against all local network
> > > +interfaces was attempted.  But unlike the LOCALIO protocol, the
> > > +sockaddr-based matching didn't handle use of iptables or containers.
> > > +
> > > +The robust handshake between local client and server is just the
> > > +beginning, the ultimate usecase this locality makes possible is the
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
> > > +The LOCALIO auxiliary RPC protocol consists of a single "GETUUID" RPC
> > > +method that allows the Linux nfs client to retrieve a Linux nfs server's
> > > +uuid.  This protocol isn't part of an IETF standard, nor does it need to
> > > +be considering it is Linux-to-Linux auxiliary RPC protocol that amounts
> > > +to an implementation detail.
> > > +
> > > +The GETUUID method encodes the server's uuid_t in terms of the fixed
> > > +UUID_SIZE (16 bytes).  The fixed size opaque encode and decode XDR
> > > +methods are used instead of the less efficient variable sized methods.
> > > +
> > > +The RPC program number for the NFS_LOCALIO_PROGRAM is currently defined
> > > +as 0x20000002 (but a request for a unique RPC program number assignment
> > > +has been submitted to IANA.org).
> > > +
> > > +The following approximately describes the LOCALIO in a pseudo rpcgen .x
> > > +syntax:
> > > +
> > > +#define UUID_SIZE 16
> > > +typedef u8 uuid_t<UUID_SIZE>;
> > > +
> > > +program NFS_LOCALIO_PROGRAM {
> > > +     version NULLVERS {
> > > +        void NULL(void) = 0;
> > > +	} = 1;
> > > +     version GETUUIDVERS {
> > > +        uuid_t GETUUID(void) = 1;
> > > +	} = 1;
> > > +} = 0x20000002;
> > > +
> > > +The above is the skeleton for the LOCALIO protocol, it doesn't account
> > > +for NFS v3 and v4 RPC boilerplate (which also marshalls RPC status) that
> > > +is used to implement GETUUID.
> > > +
> > > +Here are the respective XDR results for nfsd and nfs:
> > 
> > Hi Mike!
> > 
> > A protocol spec describes the on-the-wire data formats, not the
> > in-memory structure layouts. The below C structures are not
> > relevant to this specification. This should be all you need here,
> > if I understand your protocol correctly:
> > 
> > /* raw RFC 9562 UUID */
> > #define UUID_SIZE 16
> > typedef u8 uuid_t<UUID_SIZE>;
> > 
> > union GETUUID1res switch (uint32 status) {
> 
> I don't think we need a status in the protocol.  GETUUID always returns
> a UUID.  There is no possible error condition.

By having localio use NFS's XDR we're able to piggyback on a status
being returned by standard NFS RPC handling.

See:
nfs3svc_encode_getuuidres and nfs4svc_encode_getuuidres.
nfs3_xdr_dec_getuuidres and nfs4_xdr_dec_getuuidres (and note the
FIXME comment about abusing nfs_opnum4).

Not sure how the reality of piggbacking on NFS XDR should be captured
in the protocol spec here.

> I don't think we need the NULL procedure either, but that is such a
> deeply entrenched practice I won't argue the point.

The code required it be there, I unfortunately don't recall specifics
on what failed if it wasn't there (may have been rpc_bind_new_program).

> > case 0:
> >     uuid_t  uuid;
> > default:
> >     void;
> > };
> > 
> > program NFS_LOCALIO_PROGRAM {
> >     version LOCALIO_V1 {
> >         void
> >             NULL(void) = 0;
> > 
> >         GETUUID1res
> >             GETUUID(void) = 1;
> >     } = 1;
> > } = 0x20000002;
> > 
> > Then you need to discuss transport considerations:
> > 
> > - Whether this protocol is registered with the server's rpcbind
> >   service,
> > - Which TCP/UDP port number does it use? Assuming 2049, and that
> >   it will appear on the same transport connection as NFS traffic
> >   (just like NFACL).
> > 
> > Should it be supported on port 20049 with RDMA as well?
> 
> I don't think we should be that explicit.  We should way that requests
> are sent to the same destination as the associated NFS requests.  No
> mention of transports or addresses or ports.

OK, I agree.

Thanks,
Mike

