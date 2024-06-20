Return-Path: <linux-nfs+bounces-4196-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 27328911575
	for <lists+linux-nfs@lfdr.de>; Fri, 21 Jun 2024 00:13:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 78B0EB21416
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Jun 2024 22:13:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D5157E58D;
	Thu, 20 Jun 2024 22:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="C1DYVeRt";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="XADg07lB";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="C1DYVeRt";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="XADg07lB"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FA7843ABC
	for <linux-nfs@vger.kernel.org>; Thu, 20 Jun 2024 22:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718921588; cv=none; b=rC3bfzUY5emRL+O5dP5aO8MuYC4fnIjvThL+1B6HsNPOuY6PH3vrndzzdtMHdX8Qxhyc7cPzaXbG46aNx0Lq8LmJLCPAlAHXEEP9LRVSCMYAzmmTCQUMCj4P5BJj7XIQV5ZI3A6sZx7QtUIdxSV7E928XGT90TLzGq50lqCyjus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718921588; c=relaxed/simple;
	bh=L8OSHlBlV3w9aUGLMiNSCiTsrWEF6GQDKRc6JTXzvOo=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=q0vquGhqwodei7Zr5009hQLFP3og2QGAkEBVoLxX0H07mzcKehTigtxwa0tlBIb1h0gfA27lKXw0mi4nuR1fKDZQOYjm51FRVP8Fdh4+qf8MmN5Res1w7b8wocMbId2yzQxsEe6jvkKTfCTNDEThT3bO4mvJ7RqN06y91LW1HN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=C1DYVeRt; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=XADg07lB; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=C1DYVeRt; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=XADg07lB; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 203E71F8BD;
	Thu, 20 Jun 2024 22:13:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718921584; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FQCt6YQMnS7ZcfkN3VqjYpNapaFbfQWJkhhrTEK4Q3A=;
	b=C1DYVeRtWJi2Ai95KDT401Ahz5pSL74l6rcbSoiwpAmNrmY3v63TBnXCUCr6aNeRr95Jno
	svN5uDnvmi1g+6b9XLSEq42yBTFPTjXgJS+TQvkQJBnHLk9zcPrCBH2HeMUlVQhn11jD/V
	DtAgP/qK4Dg+h9+YLQhyEhr1jFEHquw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718921584;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FQCt6YQMnS7ZcfkN3VqjYpNapaFbfQWJkhhrTEK4Q3A=;
	b=XADg07lBBMT2/InrTpybSSIioZWFgiA0DmUK0L5RL2oIjbQUHaipN9b4rQnCrLFfyVbClx
	RiT9t0eP67wBeqBQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718921584; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FQCt6YQMnS7ZcfkN3VqjYpNapaFbfQWJkhhrTEK4Q3A=;
	b=C1DYVeRtWJi2Ai95KDT401Ahz5pSL74l6rcbSoiwpAmNrmY3v63TBnXCUCr6aNeRr95Jno
	svN5uDnvmi1g+6b9XLSEq42yBTFPTjXgJS+TQvkQJBnHLk9zcPrCBH2HeMUlVQhn11jD/V
	DtAgP/qK4Dg+h9+YLQhyEhr1jFEHquw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718921584;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FQCt6YQMnS7ZcfkN3VqjYpNapaFbfQWJkhhrTEK4Q3A=;
	b=XADg07lBBMT2/InrTpybSSIioZWFgiA0DmUK0L5RL2oIjbQUHaipN9b4rQnCrLFfyVbClx
	RiT9t0eP67wBeqBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1B2E813AC1;
	Thu, 20 Jun 2024 22:13:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 1M0ILGypdGYSbwAAD6G6ig
	(envelope-from <neilb@suse.de>); Thu, 20 Jun 2024 22:13:00 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Chuck Lever" <chuck.lever@oracle.com>
Cc: "Mike Snitzer" <snitzer@kernel.org>, linux-nfs@vger.kernel.org,
 "Jeff Layton" <jlayton@kernel.org>,
 "Trond Myklebust" <trondmy@hammerspace.com>, snitzer@hammerspace.com
Subject:
 Re: [PATCH v6 17/18] nfs: add Documentation/filesystems/nfs/localio.rst
In-reply-to: <ZnQ0FSQHJLPHxRsP@tissot.1015granger.net>
References: <>, <ZnQ0FSQHJLPHxRsP@tissot.1015granger.net>
Date: Fri, 21 Jun 2024 08:12:56 +1000
Message-id: <171892157698.14261.16357981881792326304@noble.neil.brown.name>
X-Spam-Score: -4.30
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6]

On Thu, 20 Jun 2024, Chuck Lever wrote:
> On Wed, Jun 19, 2024 at 04:40:31PM -0400, Mike Snitzer wrote:
> > This document gives an overview of the LOCALIO auxiliary RPC protocol
> > added to the Linux NFS client and server (both v3 and v4) to allow a
> > client and server to reliably handshake to determine if they are on the
> > same host.  The LOCALIO auxiliary protocol's implementation, which uses
> > the same connection as NFS traffic, follows the pattern established by
> > the NFS ACL protocol extension.
> >=20
> > The robust handshake between local client and server is just the
> > beginning, the ultimate usecase this locality makes possible is the
> > client is able to issue reads, writes and commits directly to the server
> > without having to go over the network.  This is particularly useful for
> > container usecases (e.g. kubernetes) where it is possible to run an IO
> > job local to the server.
> >=20
> > Signed-off-by: Mike Snitzer <snitzer@kernel.org>
> > ---
> >  Documentation/filesystems/nfs/localio.rst | 148 ++++++++++++++++++++++
> >  include/linux/nfslocalio.h                |   2 +
> >  2 files changed, 150 insertions(+)
> >  create mode 100644 Documentation/filesystems/nfs/localio.rst
> >=20
> > diff --git a/Documentation/filesystems/nfs/localio.rst b/Documentation/fi=
lesystems/nfs/localio.rst
> > new file mode 100644
> > index 000000000000..a43c3dab2cab
> > --- /dev/null
> > +++ b/Documentation/filesystems/nfs/localio.rst
> > @@ -0,0 +1,148 @@
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +NFS localio
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
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
> > +  read: IOPS=3D691k, BW=3D42.2GiB/s (45.3GB/s)(843GiB/20002msec)
> > +-  Without localio:
> > +  read: IOPS=3D15.7k, BW=3D984MiB/s (1032MB/s)(19.2GiB/20013msec)
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
> > +        void NULL(void) =3D 0;
> > +	} =3D 1;
> > +     version GETUUIDVERS {
> > +        uuid_t GETUUID(void) =3D 1;
> > +	} =3D 1;
> > +} =3D 0x20000002;
> > +
> > +The above is the skeleton for the LOCALIO protocol, it doesn't account
> > +for NFS v3 and v4 RPC boilerplate (which also marshalls RPC status) that
> > +is used to implement GETUUID.
> > +
> > +Here are the respective XDR results for nfsd and nfs:
>=20
> Hi Mike!
>=20
> A protocol spec describes the on-the-wire data formats, not the
> in-memory structure layouts. The below C structures are not
> relevant to this specification. This should be all you need here,
> if I understand your protocol correctly:
>=20
> /* raw RFC 9562 UUID */
> #define UUID_SIZE 16
> typedef u8 uuid_t<UUID_SIZE>;
>=20
> union GETUUID1res switch (uint32 status) {

I don't think we need a status in the protocol.  GETUUID always returns
a UUID.  There is no possible error condition.

I don't think we need the NULL procedure either, but that is such a
deeply entrenched practice I won't argue the point.

> case 0:
>     uuid_t  uuid;
> default:
>     void;
> };
>=20
> program NFS_LOCALIO_PROGRAM {
>     version LOCALIO_V1 {
>         void
>             NULL(void) =3D 0;
>=20
>         GETUUID1res
>             GETUUID(void) =3D 1;
>     } =3D 1;
> } =3D 0x20000002;
>=20
> Then you need to discuss transport considerations:
>=20
> - Whether this protocol is registered with the server's rpcbind
>   service,
> - Which TCP/UDP port number does it use? Assuming 2049, and that
>   it will appear on the same transport connection as NFS traffic
>   (just like NFACL).
>=20
> Should it be supported on port 20049 with RDMA as well?

I don't think we should be that explicit.  We should way that requests
are sent to the same destination as the associated NFS requests.  No
mention of transports or addresses or ports.

NeilBrown


>=20
>=20
> > +
> > +From fs/nfsd/xdr.h
> > +
> > +struct nfsd_getuuidres {
> > +	__be32			status;
> > +	uuid_t			uuid;
> > +};
> > +
> > +From include/linux/nfs_xdr.h
> > +
> > +struct nfs_getuuidres {
> > +	__u8 *			uuid;
> > +};
> > +
> > +The client ultimately decodes this XDR using:
> > +xdr_stream_decode_opaque_fixed(xdr, result->uuid, UUID_SIZE);
> > +
> > +NFS Common and Server
> > +---------------------
> > +
> > +First use is in nfsd, to add access to a global nfsd_uuids list in
> > +nfs_common that is used to register and then identify local nfsd
> > +instances.
> > +
> > +nfsd_uuids is protected by the nfsd_mutex or RCU read lock and is
> > +composed of nfsd_uuid_t instances that are managed as nfsd creates them
> > +(per network namespace).
> > +
> > +nfsd_uuid_is_local() and nfsd_uuid_lookup() are used to search all local
> > +nfsd for the client specified nfsd uuid.
> > +
> > +The nfsd_uuids list is the basis for localio enablement, as such it has
> > +members that point to nfsd memory for direct use by the client
> > +(e.g. 'net' is the server's network namespace, through it the client can
> > +access nn->nfsd_serv with proper rcu read access).  It is this client
> > +and server synchronization that enables advanced usage and lifetime of
> > +objects to span from the host kernel's nfsd to per-container knfsd
> > +instances that are connected to nfs client's running on the same local
> > +host.
> > +
> > +NFS Client
> > +----------
> > +
> > +fs/nfs/localio.c:nfs_local_probe() will retrieve a server's uuid via
> > +LOCALIO protocol and check if the server with that uuid is known to be
> > +local.  This ensures client and server 1: support localio 2: are local
> > +to each other.
> > +
> > +See fs/nfs/localio.c:nfs_local_open_fh() and
> > +fs/nfsd/localio.c:nfsd_open_local_fh() for the interface that makes
> > +focused use of nfsd_uuid_t struct to allow a client local to a server to
> > +open a file pointer without needing to go over the network.
> > +
> > +The client's fs/nfs/localio.c:nfs_local_open_fh() will call into the
> > +server's fs/nfsd/localio.c:nfsd_open_local_fh() and carefully access
> > +both the nfsd network namespace and the associated nn->nfsd_serv in
> > +terms of RCU.  If nfsd_open_local_fh() finds that client no longer sees
> > +valid nfsd objects (be it struct net or nn->nfsd_serv) it return ENXIO
> > +to nfs_local_open_fh() and the client will try to reestablish the
> > +LOCALIO resources needed by calling nfs_local_probe() again.  This
> > +recovery is needed if/when an nfsd instance running in a container were
> > +to reboot while a localio client is connected to it.
> > +
> > +Testing
> > +-------
> > +
> > +The LOCALIO auxiliary protocol and associated NFS localio read, right
> > +and commit access have proven stable against various test scenarios but
> > +these have not yet been formalized in any testsuite:
>=20
> Is there anywhere that describes what is needed to set up clients
> and a server to do local I/O? Then running the usual suite of NFS
> tests on that set up and comparing the nfsstat output on the local
> and remote clients should be a basic "smoke test" kind of thing
> that maintainers can use as a check-in test.
>=20
>=20
> > +
> > +-  Client and server both on localhost (for both v3 and v4.2).
> > +
> > +-  Various permutations of client and server support enablement for
> > +   both local and remote client and server.  Testing against NFS storage
> > +   products that don't support the LOCALIO protocol was also performed.
> > +
> > +-  Client on host, server within a container (for both v3 and v4.2)
> > +   The container testing was in terms of podman managed containers and
> > +   includes container stop/restart scenario.
> > diff --git a/include/linux/nfslocalio.h b/include/linux/nfslocalio.h
> > index c9592ad0afe2..a9722e18b527 100644
> > --- a/include/linux/nfslocalio.h
> > +++ b/include/linux/nfslocalio.h
> > @@ -20,6 +20,8 @@ extern struct list_head nfsd_uuids;
> >   * Each nfsd instance has an nfsd_uuid_t that is accessible through the
> >   * global nfsd_uuids list. Useful to allow a client to negotiate if loca=
lio
> >   * possible with its server.
> > + *
> > + * See Documentation/filesystems/nfs/localio.rst for more detail.
> >   */
> >  typedef struct {
> >  	uuid_t uuid;
> > --=20
> > 2.44.0
> >=20
>=20
> --=20
> Chuck Lever
>=20


