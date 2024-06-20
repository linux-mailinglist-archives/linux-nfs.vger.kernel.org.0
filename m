Return-Path: <linux-nfs+bounces-4199-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11EC09116FD
	for <lists+linux-nfs@lfdr.de>; Fri, 21 Jun 2024 01:42:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37BAB1C2098F
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Jun 2024 23:42:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4040E14B973;
	Thu, 20 Jun 2024 23:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="DRwErGDW";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="x5OLPVes";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="DRwErGDW";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="x5OLPVes"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62F07143865
	for <linux-nfs@vger.kernel.org>; Thu, 20 Jun 2024 23:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718926966; cv=none; b=ryPPzkSy+Gzq56bn1rBuByFYwQC7+N4Ekx1088PTPjZqbXOWTZneQ0AvvtyLug/lYPCqbLXpgOpqDmrdBV14LCwG5WfAUn2vloejATusYkvOX1k4mrgCo3gOpfwHk9vuoBQqiEOsTkiBgYOnk7rQYg4zC+9h6vtyZtoAD8zY5U0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718926966; c=relaxed/simple;
	bh=j0gj3lzcZNZYIZ9McC6eJV81LAEzH2apSPytJQoLhvg=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=NaIqCl6WNCygYUNvzRrpGJgo0skPOwsa+T1n+E4pho+8TQ+OjtUCGJp8W/viAcUqEOCayQYkqhHb+j133IOqB+SZT65JTydIplhl0gC4P7oiCXKNJ9izCXDzoEnMxKBqT/Mn3TxKYFKqGDvc2kTIu0i/uqFknFYVfpGkzv+sqbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=DRwErGDW; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=x5OLPVes; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=DRwErGDW; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=x5OLPVes; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1419A21AF2;
	Thu, 20 Jun 2024 23:42:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718926961; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+5FVMETmJzLxqKirleiiR/RUQwuroGHset0+GpP1GwI=;
	b=DRwErGDW/1xLPoH4xsdhx7YZiDNccxpdpIg/gIK+KM4zOHR0Fee+ykzxciZ+9OoBZHKvK9
	x5jhhKpc6rQqH6PCp+vJV3sYodIO5Gwe24fAP1gVv1uEj7h74eeUB2WwBp9uT/ysxr+Cfx
	dwwTTOnXpFZhE14uNUayWPdldN+Ku9Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718926961;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+5FVMETmJzLxqKirleiiR/RUQwuroGHset0+GpP1GwI=;
	b=x5OLPVesv1wWl5oEdqybBODXCNJ4ieRfpXd2/0pHqqZOm+hiT2ruGXUKJInX7XF9Ra01Kh
	49SUmiMuDCD1VrBA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=DRwErGDW;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=x5OLPVes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718926961; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+5FVMETmJzLxqKirleiiR/RUQwuroGHset0+GpP1GwI=;
	b=DRwErGDW/1xLPoH4xsdhx7YZiDNccxpdpIg/gIK+KM4zOHR0Fee+ykzxciZ+9OoBZHKvK9
	x5jhhKpc6rQqH6PCp+vJV3sYodIO5Gwe24fAP1gVv1uEj7h74eeUB2WwBp9uT/ysxr+Cfx
	dwwTTOnXpFZhE14uNUayWPdldN+Ku9Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718926961;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+5FVMETmJzLxqKirleiiR/RUQwuroGHset0+GpP1GwI=;
	b=x5OLPVesv1wWl5oEdqybBODXCNJ4ieRfpXd2/0pHqqZOm+hiT2ruGXUKJInX7XF9Ra01Kh
	49SUmiMuDCD1VrBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 71BDD13AC1;
	Thu, 20 Jun 2024 23:42:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Yx5nBW6+dGYGCQAAD6G6ig
	(envelope-from <neilb@suse.de>); Thu, 20 Jun 2024 23:42:38 +0000
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
In-reply-to: <ZnS7DsnrW7OX0rJC@tissot.1015granger.net>
References: <>, <ZnS7DsnrW7OX0rJC@tissot.1015granger.net>
Date: Fri, 21 Jun 2024 09:42:26 +1000
Message-id: <171892694669.14261.4243996786790353819@noble.neil.brown.name>
X-Rspamd-Queue-Id: 1419A21AF2
X-Spam-Score: -6.51
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-6.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

On Fri, 21 Jun 2024, Chuck Lever wrote:
> On Thu, Jun 20, 2024 at 06:35:38PM -0400, Mike Snitzer wrote:
> > On Fri, Jun 21, 2024 at 08:12:56AM +1000, NeilBrown wrote:
> > > On Thu, 20 Jun 2024, Chuck Lever wrote:
> > > > On Wed, Jun 19, 2024 at 04:40:31PM -0400, Mike Snitzer wrote:
> > > > > This document gives an overview of the LOCALIO auxiliary RPC protoc=
ol
> > > > > added to the Linux NFS client and server (both v3 and v4) to allow a
> > > > > client and server to reliably handshake to determine if they are on=
 the
> > > > > same host.  The LOCALIO auxiliary protocol's implementation, which =
uses
> > > > > the same connection as NFS traffic, follows the pattern established=
 by
> > > > > the NFS ACL protocol extension.
> > > > >=20
> > > > > The robust handshake between local client and server is just the
> > > > > beginning, the ultimate usecase this locality makes possible is the
> > > > > client is able to issue reads, writes and commits directly to the s=
erver
> > > > > without having to go over the network.  This is particularly useful=
 for
> > > > > container usecases (e.g. kubernetes) where it is possible to run an=
 IO
> > > > > job local to the server.
> > > > >=20
> > > > > Signed-off-by: Mike Snitzer <snitzer@kernel.org>
> > > > > ---
> > > > >  Documentation/filesystems/nfs/localio.rst | 148 ++++++++++++++++++=
++++
> > > > >  include/linux/nfslocalio.h                |   2 +
> > > > >  2 files changed, 150 insertions(+)
> > > > >  create mode 100644 Documentation/filesystems/nfs/localio.rst
> > > > >=20
> > > > > diff --git a/Documentation/filesystems/nfs/localio.rst b/Documentat=
ion/filesystems/nfs/localio.rst
> > > > > new file mode 100644
> > > > > index 000000000000..a43c3dab2cab
> > > > > --- /dev/null
> > > > > +++ b/Documentation/filesystems/nfs/localio.rst
> > > > > @@ -0,0 +1,148 @@
> > > > > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > > > +NFS localio
> > > > > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > > > +
> > > > > +This document gives an overview of the LOCALIO auxiliary RPC proto=
col
> > > > > +added to the Linux NFS client and server (both v3 and v4) to allow=
 a
> > > > > +client and server to reliably handshake to determine if they are o=
n the
> > > > > +same host.  The LOCALIO auxiliary protocol's implementation, which=
 uses
> > > > > +the same connection as NFS traffic, follows the pattern establishe=
d by
> > > > > +the NFS ACL protocol extension.
> > > > > +
> > > > > +The LOCALIO auxiliary protocol is needed to allow robust discovery=
 of
> > > > > +clients local to their servers.  Prior to this LOCALIO protocol a
> > > > > +fragile sockaddr network address based match against all local net=
work
> > > > > +interfaces was attempted.  But unlike the LOCALIO protocol, the
> > > > > +sockaddr-based matching didn't handle use of iptables or container=
s.
> > > > > +
> > > > > +The robust handshake between local client and server is just the
> > > > > +beginning, the ultimate usecase this locality makes possible is the
> > > > > +client is able to issue reads, writes and commits directly to the =
server
> > > > > +without having to go over the network.  This is particularly usefu=
l for
> > > > > +container usecases (e.g. kubernetes) where it is possible to run a=
n IO
> > > > > +job local to the server.
> > > > > +
> > > > > +The performance advantage realized from localio's ability to bypass
> > > > > +using XDR and RPC for reads, writes and commits can be extreme, e.=
g.:
> > > > > +fio for 20 secs with 24 libaio threads, 64k directio reads, qd of =
8,
> > > > > +-  With localio:
> > > > > +  read: IOPS=3D691k, BW=3D42.2GiB/s (45.3GB/s)(843GiB/20002msec)
> > > > > +-  Without localio:
> > > > > +  read: IOPS=3D15.7k, BW=3D984MiB/s (1032MB/s)(19.2GiB/20013msec)
> > > > > +
> > > > > +RPC
> > > > > +---
> > > > > +
> > > > > +The LOCALIO auxiliary RPC protocol consists of a single "GETUUID" =
RPC
> > > > > +method that allows the Linux nfs client to retrieve a Linux nfs se=
rver's
> > > > > +uuid.  This protocol isn't part of an IETF standard, nor does it n=
eed to
> > > > > +be considering it is Linux-to-Linux auxiliary RPC protocol that am=
ounts
> > > > > +to an implementation detail.
> > > > > +
> > > > > +The GETUUID method encodes the server's uuid_t in terms of the fix=
ed
> > > > > +UUID_SIZE (16 bytes).  The fixed size opaque encode and decode XDR
> > > > > +methods are used instead of the less efficient variable sized meth=
ods.
> > > > > +
> > > > > +The RPC program number for the NFS_LOCALIO_PROGRAM is currently de=
fined
> > > > > +as 0x20000002 (but a request for a unique RPC program number assig=
nment
> > > > > +has been submitted to IANA.org).
> > > > > +
> > > > > +The following approximately describes the LOCALIO in a pseudo rpcg=
en .x
> > > > > +syntax:
> > > > > +
> > > > > +#define UUID_SIZE 16
> > > > > +typedef u8 uuid_t<UUID_SIZE>;
> > > > > +
> > > > > +program NFS_LOCALIO_PROGRAM {
> > > > > +     version NULLVERS {
> > > > > +        void NULL(void) =3D 0;
> > > > > +	} =3D 1;
> > > > > +     version GETUUIDVERS {
> > > > > +        uuid_t GETUUID(void) =3D 1;
> > > > > +	} =3D 1;
> > > > > +} =3D 0x20000002;
> > > > > +
> > > > > +The above is the skeleton for the LOCALIO protocol, it doesn't acc=
ount
> > > > > +for NFS v3 and v4 RPC boilerplate (which also marshalls RPC status=
) that
> > > > > +is used to implement GETUUID.
> > > > > +
> > > > > +Here are the respective XDR results for nfsd and nfs:
> > > >=20
> > > > Hi Mike!
> > > >=20
> > > > A protocol spec describes the on-the-wire data formats, not the
> > > > in-memory structure layouts. The below C structures are not
> > > > relevant to this specification. This should be all you need here,
> > > > if I understand your protocol correctly:
> > > >=20
> > > > /* raw RFC 9562 UUID */
> > > > #define UUID_SIZE 16
> > > > typedef u8 uuid_t<UUID_SIZE>;
> > > >=20
> > > > union GETUUID1res switch (uint32 status) {
> > >=20
> > > I don't think we need a status in the protocol.  GETUUID always returns
> > > a UUID.  There is no possible error condition.
> >=20
> > By having localio use NFS's XDR we're able to piggyback on a status
> > being returned by standard NFS RPC handling.
> >=20
> > See:
> > nfs3svc_encode_getuuidres and nfs4svc_encode_getuuidres.
> > nfs3_xdr_dec_getuuidres and nfs4_xdr_dec_getuuidres (and note the
> > FIXME comment about abusing nfs_opnum4).
>=20
> No, let's not piggyback like that. Please make it a separate
> XDR implementation just like NFSACL is. Again, LOCALIO is not
> an extension of the NFS protocol. Making that claim confuses
> people for whom the term "extension" has a very precise meaning.
> If we were extending NFS, then yes, adding the new procedures
> to the NFS XDR implementation is appropriate, but that's not
> what you are doing: you are adding a new side-band protocol.

I'm currently working through the LOCALIO protocol code to make it a
single version rather than '3' and '4'.  In the process I'm making it
completely separate from the NFS protocol implementation and cleaning up
some other bits.  e.g. it shouldn't register with rpcbind.

I'll hopefully post patches in a few hours.  I writing this now to
discourage Mike from starting work on this.

NeilBrown


>=20
> I have a long-term goal to ensure we can generate the source
> code of the XDR layer of all the kernel RPC protocols via an
> rpcgen like tool. A code generator can ensure that the
> marshalling and unmarshalling code is memory-safe.
>=20
> By piggybacking, you are building LOCALIO into another
> protocol's XDR implementation, which makes it a special case,
> and thus harder to implement via code that is generated
> automatically from unmodified XDR language specs.
>=20
> Maybe the client side maintainers don't care about that, but
> please don't piggyback LOCALIO onto the NFSD's NFS XDR
> implementation.
>=20
> Then, if it's a separate implementation, you can remove the status
> code. I was wondering why the server would reply with an error. If
> LOCALIO/GETUUID is not supported, then an RPC level error occurs
> anyway.
>=20
> If you think you need an error like "Yes, I recognize that program
> and procedure, but this file system doesn't allow local access
> in any case" then that needs to be added to the protocol XDR
> specification.
>=20
>=20
> > Not sure how the reality of piggbacking on NFS XDR should be captured
> > in the protocol spec here.
>=20
> It's an implementation choice, so it doesn't belong in the protocol
> spec that, again, lays out only on-the-wire behavior,.
>=20
> Implementation specifics can be discussed in another section of the
> document.
>=20
>=20
> > > I don't think we need the NULL procedure either, but that is such a
> > > deeply entrenched practice I won't argue the point.
> >=20
> > The code required it be there, I unfortunately don't recall specifics
> > on what failed if it wasn't there (may have been rpc_bind_new_program).
>=20
> Please leave the NULL procedure where it is. Note that the NFS
> program's NULL procedure is used in two rather significant ways:
>=20
>  - As a carrier for GSSAPI messages
>  - As a probe for the RPC-with-TLS capability
>=20
> The latter might be significant if a client sends a LOCALIO
> operation as the first RPC procedure when contacting an unfamiliar
> server -- if it wants TLS protection for that procedure, then it
> will need to send a NULL(RPC_AUTH_TLS) as the very first RPC
> transaction.
>=20
> Since LOCALIO/GETUUID is going over the network sometimes, it's
> reasonable to expect that these security measures could be used.
>=20
>=20
> > > > case 0:
> > > >     uuid_t  uuid;
> > > > default:
> > > >     void;
> > > > };
> > > >=20
> > > > program NFS_LOCALIO_PROGRAM {
> > > >     version LOCALIO_V1 {
> > > >         void
> > > >             NULL(void) =3D 0;
> > > >=20
> > > >         GETUUID1res
> > > >             GETUUID(void) =3D 1;
> > > >     } =3D 1;
> > > > } =3D 0x20000002;
> > > >=20
> > > > Then you need to discuss transport considerations:
> > > >=20
> > > > - Whether this protocol is registered with the server's rpcbind
> > > >   service,
> > > > - Which TCP/UDP port number does it use? Assuming 2049, and that
> > > >   it will appear on the same transport connection as NFS traffic
> > > >   (just like NFACL).
> > > >=20
> > > > Should it be supported on port 20049 with RDMA as well?
> > >=20
> > > I don't think we should be that explicit.  We should way that requests
> > > are sent to the same destination as the associated NFS requests.  No
> > > mention of transports or addresses or ports.
> >=20
> > OK, I agree.
>=20
>=20
> --=20
> Chuck Lever
>=20


