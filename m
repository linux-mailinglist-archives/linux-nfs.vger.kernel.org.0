Return-Path: <linux-nfs+bounces-4151-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73372910878
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Jun 2024 16:34:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CC111B21EBB
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Jun 2024 14:34:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9CFA1AF6BC;
	Thu, 20 Jun 2024 14:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kB3DhDtN"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9653B1AF6B7
	for <linux-nfs@vger.kernel.org>; Thu, 20 Jun 2024 14:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718893997; cv=none; b=dwpcXR6Iql5El2QwOHE1d1wv8Ujg6gQtwjfvK4/bRQaVGlyosJw9ZBxiyQf761PCHT58uSLCOJgTE+iq8KyL7HCnZ55o0xJeBGQJSFTLeXB3wNzs8DRUKesG8Dcl51arj9a4CeV8oYLtgF7+dpYExGYDvRyooh//AtNtLqiOr2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718893997; c=relaxed/simple;
	bh=CurScG9XwYxnPrfRjbfgwrxXYqa9ry4JWV47FduOJLU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=reQYHE1hHrxb2qNLM7PCR3cyzWfbPwl2VGp4X4STAzIhmHhRpyCTQPyuXWs+YLwIwZwsEzIiSMdrSnXPDSrUTzT6WpHcqcjuFIpFyuiKDNDsTt6xjlABvKhg3Aoiedzkbe40/jLxBwu2JD+DHL1wdxQPKk2M0vYopafpZkIwAWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kB3DhDtN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD008C4AF0E;
	Thu, 20 Jun 2024 14:33:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718893997;
	bh=CurScG9XwYxnPrfRjbfgwrxXYqa9ry4JWV47FduOJLU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kB3DhDtN9P681o9Aux6QdgH3UsPeoPJLmwHijis1LC45GjKIo1IRyzr2lYXfVirso
	 +bGoyymukqXvf5B5hoRdjfo3cjQoalNpnzXFPk3BFAPBNOjtToQIPasgk36z3aO6Vl
	 uR/kiR3hXOlqgAgIoGC7Z33SYmGUAsN2ZCTPMjTgSngUu6/8kfDcRkyaK+CWubDCAB
	 FGpAKCJRpEnAd2blJ6YxQEg/SlS9+XYPxMmHw3OfTh9jyhyZS6lZ6JeDZedQ5tOcIg
	 tXLeDjAFNzOPjAGelMYAZVi06aSPXof/nnQbvzPeqAnMeOtXWcV/R1NahwksyLCSV8
	 CsI7FfQLJN1DA==
Date: Thu, 20 Jun 2024 10:33:15 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: linux-nfs@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>,
	NeilBrown <neilb@suse.de>, snitzer@hammerspace.com
Subject: Re: [PATCH v6 17/18] nfs: add
 Documentation/filesystems/nfs/localio.rst
Message-ID: <ZnQ9q9n1wJrBNRC9@kernel.org>
References: <20240619204032.93740-1-snitzer@kernel.org>
 <20240619204032.93740-18-snitzer@kernel.org>
 <ZnQ0FSQHJLPHxRsP@tissot.1015granger.net>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZnQ0FSQHJLPHxRsP@tissot.1015granger.net>

On Thu, Jun 20, 2024 at 09:52:21AM -0400, Chuck Lever wrote:
> On Wed, Jun 19, 2024 at 04:40:31PM -0400, Mike Snitzer wrote:
> > This document gives an overview of the LOCALIO auxiliary RPC protocol
> > added to the Linux NFS client and server (both v3 and v4) to allow a
> > client and server to reliably handshake to determine if they are on the
> > same host.  The LOCALIO auxiliary protocol's implementation, which uses
> > the same connection as NFS traffic, follows the pattern established by
> > the NFS ACL protocol extension.
> > 
> > The robust handshake between local client and server is just the
> > beginning, the ultimate usecase this locality makes possible is the
> > client is able to issue reads, writes and commits directly to the server
> > without having to go over the network.  This is particularly useful for
> > container usecases (e.g. kubernetes) where it is possible to run an IO
> > job local to the server.
> > 
> > Signed-off-by: Mike Snitzer <snitzer@kernel.org>
> > ---
> >  Documentation/filesystems/nfs/localio.rst | 148 ++++++++++++++++++++++
> >  include/linux/nfslocalio.h                |   2 +
> >  2 files changed, 150 insertions(+)
> >  create mode 100644 Documentation/filesystems/nfs/localio.rst
> > 
> > diff --git a/Documentation/filesystems/nfs/localio.rst b/Documentation/filesystems/nfs/localio.rst
> > new file mode 100644
> > index 000000000000..a43c3dab2cab
> > --- /dev/null
> > +++ b/Documentation/filesystems/nfs/localio.rst
> > @@ -0,0 +1,148 @@
> > +===========
> > +NFS localio
> > +===========
> > +
> > +This document gives an overview of the LOCALIO auxiliary RPC protocol
> > +added to the Linux NFS client and server (both v3 and v4) to allow a
> > +client and server to reliably handshake to determine if they are on the
> > +same host.  The LOCALIO auxiliary protocol's implementation, which uses
> > +the same connection as NFS traffic, follows the pattern established by
> > +the NFS ACL protocol extension.
> > +
> > +The LOCALIO auxiliary protocol is needed to allow robust discovery of
> > +clients local to their servers.  Prior to this LOCALIO protocol a
> > +fragile sockaddr network address based match against all local network
> > +interfaces was attempted.  But unlike the LOCALIO protocol, the
> > +sockaddr-based matching didn't handle use of iptables or containers.
> > +
> > +The robust handshake between local client and server is just the
> > +beginning, the ultimate usecase this locality makes possible is the
> > +client is able to issue reads, writes and commits directly to the server
> > +without having to go over the network.  This is particularly useful for
> > +container usecases (e.g. kubernetes) where it is possible to run an IO
> > +job local to the server.
> > +
> > +The performance advantage realized from localio's ability to bypass
> > +using XDR and RPC for reads, writes and commits can be extreme, e.g.:
> > +fio for 20 secs with 24 libaio threads, 64k directio reads, qd of 8,
> > +-  With localio:
> > +  read: IOPS=691k, BW=42.2GiB/s (45.3GB/s)(843GiB/20002msec)
> > +-  Without localio:
> > +  read: IOPS=15.7k, BW=984MiB/s (1032MB/s)(19.2GiB/20013msec)
> > +
> > +RPC
> > +---
> > +
> > +The LOCALIO auxiliary RPC protocol consists of a single "GETUUID" RPC
> > +method that allows the Linux nfs client to retrieve a Linux nfs server's
> > +uuid.  This protocol isn't part of an IETF standard, nor does it need to
> > +be considering it is Linux-to-Linux auxiliary RPC protocol that amounts
> > +to an implementation detail.
> > +
> > +The GETUUID method encodes the server's uuid_t in terms of the fixed
> > +UUID_SIZE (16 bytes).  The fixed size opaque encode and decode XDR
> > +methods are used instead of the less efficient variable sized methods.
> > +
> > +The RPC program number for the NFS_LOCALIO_PROGRAM is currently defined
> > +as 0x20000002 (but a request for a unique RPC program number assignment
> > +has been submitted to IANA.org).
> > +
> > +The following approximately describes the LOCALIO in a pseudo rpcgen .x
> > +syntax:
> > +
> > +#define UUID_SIZE 16
> > +typedef u8 uuid_t<UUID_SIZE>;
> > +
> > +program NFS_LOCALIO_PROGRAM {
> > +     version NULLVERS {
> > +        void NULL(void) = 0;
> > +	} = 1;
> > +     version GETUUIDVERS {
> > +        uuid_t GETUUID(void) = 1;
> > +	} = 1;
> > +} = 0x20000002;
> > +
> > +The above is the skeleton for the LOCALIO protocol, it doesn't account
> > +for NFS v3 and v4 RPC boilerplate (which also marshalls RPC status) that
> > +is used to implement GETUUID.
> > +
> > +Here are the respective XDR results for nfsd and nfs:
> 
> Hi Mike!
> 
> A protocol spec describes the on-the-wire data formats, not the
> in-memory structure layouts. The below C structures are not
> relevant to this specification. This should be all you need here,
> if I understand your protocol correctly:
> 
> /* raw RFC 9562 UUID */
> #define UUID_SIZE 16
> typedef u8 uuid_t<UUID_SIZE>;
> 
> union GETUUID1res switch (uint32 status) {
> case 0:
>     uuid_t  uuid;
> default:
>     void;
> };
> 
> program NFS_LOCALIO_PROGRAM {
>     version LOCALIO_V1 {
>         void
>             NULL(void) = 0;
> 
>         GETUUID1res
>             GETUUID(void) = 1;
>     } = 1;
> } = 0x20000002;

Thanks for this, nice to see I wasn't too far off.

> Then you need to discuss transport considerations:
> 
> - Whether this protocol is registered with the server's rpcbind
>   service,

It isn't, should it be?  Not familiar with what needs updating to do
it, but happy to work through it.

> - Which TCP/UDP port number does it use? Assuming 2049, and that
>   it will appear on the same transport connection as NFS traffic
>   (just like NFACL).

Correct.
 
> Should it be supported on port 20049 with RDMA as well?

Unless there is some additional code needed, I don't see why it
wouldn't.  But I haven't tested it (will look at NFS's RDMA support
and wrap my head around it).

> > +Testing
> > +-------
> > +
> > +The LOCALIO auxiliary protocol and associated NFS localio read, right
> > +and commit access have proven stable against various test scenarios but
> > +these have not yet been formalized in any testsuite:
> 
> Is there anywhere that describes what is needed to set up clients
> and a server to do local I/O? Then running the usual suite of NFS
> tests on that set up and comparing the nfsstat output on the local
> and remote clients should be a basic "smoke test" kind of thing
> that maintainers can use as a check-in test.

I just figured running nfsd and nfs client connecting to that
localhost was obvious.  But I can fill in more howto like info in this
section.

What is "the usual suite of NFS tests"?  I should run them ;)

(apologies if there is well established docs with pointers, still
learning to fish, thanks for your help!)

Mike

