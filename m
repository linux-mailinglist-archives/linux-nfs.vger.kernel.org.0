Return-Path: <linux-nfs+bounces-3135-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DED008BA0C0
	for <lists+linux-nfs@lfdr.de>; Thu,  2 May 2024 20:51:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E64F8B20FDE
	for <lists+linux-nfs@lfdr.de>; Thu,  2 May 2024 18:51:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2CB216FF2B;
	Thu,  2 May 2024 18:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="egGqIugO"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C793CFBF6
	for <linux-nfs@vger.kernel.org>; Thu,  2 May 2024 18:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714675891; cv=none; b=lCu6I8v0rLm9zDC6qMdm8I8UTcazInBkITb4qr/e/vsHHOBJy+CEvkk0fCreeeMIC7NFG465a3Cg+6McPQBED+r+9cwOu+7xAXGHqK91/U7kgCVACmagbeZargPbUBW0kjOovhcXttJI+Kh6LY/5NwdJ7jouP5qgEkayjZUacjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714675891; c=relaxed/simple;
	bh=Lu3Uh8vJM1SyTNuR2udkKhOpQHlqbBA8bHGUV9J2qwE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HarUqne75phYZ/4sfrlt/hU421uFEYNZNqGUAgZLhWyyd1IvWxGXyHcJ4og0EQfBEMbjVlza0lgWwNvoc4yUTfnxH3FV26w95PQt4ul15s2z7EYIF9lNV6D/SL22y/tJSm0MjknEeV+yebJgpxlx0MbcNj41WdFU+Ma3hBss49E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=egGqIugO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714675888;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QV1DRDGTqy3yo+E0HQmrAWetvZJOKOdrxnb1fhktJfc=;
	b=egGqIugOSBTFRil7pvMa+EDsRREP06Jw+8XKJ7I2qVp0DrBhAlDgCBLKfWFHqHK8ms6mHx
	v1M8Sc1BB5WJ4cURarqsZ/N8akbd7/2MS3tHkKzNMqTXuw402xfGyhjSx9TaASqRmj2rCY
	9g/2mVY1ZKTjQryjILxpi3UnjR/xfJ0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-621-aL6HSLLUNFy8zTO-KbYzHw-1; Thu, 02 May 2024 14:51:24 -0400
X-MC-Unique: aL6HSLLUNFy8zTO-KbYzHw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4EFD18943A1;
	Thu,  2 May 2024 18:51:24 +0000 (UTC)
Received: from aion.redhat.com (unknown [10.22.16.67])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 39121112131D;
	Thu,  2 May 2024 18:51:24 +0000 (UTC)
Received: by aion.redhat.com (Postfix, from userid 1000)
	id BCE4F14A06D; Thu,  2 May 2024 14:51:23 -0400 (EDT)
Date: Thu, 2 May 2024 14:51:23 -0400
From: Scott Mayhew <smayhew@redhat.com>
To: Chuck Lever III <chuck.lever@oracle.com>
Cc: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: NFSv3 and xprtsec policies
Message-ID: <ZjPgq-xA1G6Z2_aQ@aion>
References: <ZjO3Qwf_G87yNXb2@aion>
 <100A1A35-2B53-46CA-A448-F82A95CA1EFA@oracle.com>
 <ZjPPZmBZJZVmBuA6@aion>
 <38C9B493-2A43-4691-A19A-8998F0DFAED9@oracle.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <38C9B493-2A43-4691-A19A-8998F0DFAED9@oracle.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

On Thu, 02 May 2024, Chuck Lever III wrote:

>=20
>=20
> > On May 2, 2024, at 1:37=E2=80=AFPM, Scott Mayhew <smayhew@redhat.com> w=
rote:
> >=20
> > On Thu, 02 May 2024, Chuck Lever III wrote:
> >=20
> >>> On May 2, 2024, at 11:54=E2=80=AFAM, Scott Mayhew <smayhew@redhat.com=
> wrote:
> >>>=20
> >>> Red Hat QE identified an "interesting" issue with NFSv3 and TLS, in t=
hat an
> >>> NFSv3 client can mount with "xprtsec=3Dnone" a filesystem exported wi=
th
> >>> "xprtsec=3Dtls:mtls" (in the sense that the client gets the filehandl=
e and adds a
> >>> mount to its mount table - it can't actually access the mount).
> >>>=20
> >>> Here's an example using machines from the recent Bakeathon.
> >>>=20
> >>> Mounting a server with TLS enabled:
> >>>=20
> >>> # mount -o v4.2,sec=3Dsys,xprtsec=3Dtls oracle-102.chuck.lever.oracle=
=2Ecom.nfsv4.dev:/export/tls /mnt
> >>> # umount /mnt
> >>>=20
> >>> Trying to mount without "xprtsec=3Dtls" shows that the filesystem is =
not exported with "xprtsec=3Dnone":
> >>>=20
> >>> # mount -o v4.2,sec=3Dsys oracle-102.chuck.lever.oracle.com.nfsv4.dev=
:/export/tls /mnt
> >>> mount.nfs: Operation not permitted for oracle-102.chuck.lever.oracle.=
com.nfsv4.dev:/export/tls on /mnt
> >>>=20
> >>> Yet a v3 mount without "xprtsec=3Dtls" works:
> >>>=20
> >>> # mount -o v3,sec=3Dsys oracle-102.chuck.lever.oracle.com.nfsv4.dev:/=
export/tls /mnt
> >>> # umount /mnt
> >>>=20
> >>> and a mount with no explicit version and without "xprtsec=3Dtls" fall=
s back to
> >>> v3 and also "works":
> >>>=20
> >>> # mount -o sec=3Dsys oracle-102.chuck.lever.oracle.com.nfsv4.dev:/exp=
ort/tls /mnt
> >>> # grep ora /proc/mounts
> >>> oracle-102.chuck.lever.oracle.com.nfsv4.dev:/export/tls /mnt nfs
> >>> +rw,relatime,vers=3D3,rsize=3D524288,wsize=3D524288,namlen=3D255,hard=
,proto=3Dtcp,timeo=3D600,retrans=3D2,sec=3Dsys,mountaddr=3D100.64.0.49,moun=
tvers=3D3,mountport=3D20048,mountproto=3Dudp,local_lock=3Dnone,addr=3D100.6=
4.0.49 0 0
> >>>=20
> >>> Even though the filesystem is mounted, the client can't do anything w=
ith it:
> >>>=20
> >>> # ls /mnt
> >>> ls: cannot open directory '/mnt': Permission denied
> >>>=20
> >>> When krb5 is used with NFSv3, the server returns a list of pseudoflav=
ors in
> >>> mountres3_ok (https://datatracker.ietf.org/doc/html/rfc1813#section-5=
=2E2.1).
> >>> The client compares that list with its own list of auth flavors parse=
d from the
> >>> mount request and returns -EACCES if no match is found (see
> >>> nfs_verify_authflavors()).
> >>>=20
> >>> Perhaps we should be doing something similar with xprtsec policies?
> >>=20
> >> The problem might be in how you've set up the exports. With NFSv3,
> >> the parent export needs the "crossmnt" export option in order for
> >> NFSv3 to behave like NFSv4 in this regard, although I could have
> >> missed something.
> >=20
> > I was mounting your server though :)
>=20
> OK, then not the same bug that Olga found last year.
>=20
> We should find out what FreeBSD does in this case.

I thought about that.  Rick's servers from the BAT are offline, and I
don't think he was exporting v3 anyway.

>=20
>=20
> >>> Should
> >>> there be an errata to RFC 9289 and a request from IANA for assigned n=
umbers for
> >>> pseudo-flavors corresponding to xprtsec policies?
> >>=20
> >> No. Transport-layer security is not an RPC security flavor or
> >> pseudo-flavor. These two things are not related.
> >>=20
> >> (And in fact, I proposed something like this for NFSv4 SECINFO,
> >> but it was rejected).
> >=20
> > I thought it might be a stretch to try to use mountres3.auth_flavors for
> > this, but since RFC 9289 does refer to AUTH_TLS as an authentication
> > flavor and https://www.iana.org/assignments/rpc-authentication-numbers/=
rpc-authentication-numbers.xhtml
> > also lists TLS under the Flavor Name column I thought it might make
> > sense to treat xprtsec policies as if they were pseudo-flavors even
> > though they're not, if only to give the client a way to determine that
> > the mount should fail.
>=20
> RPC_AUTH_TLS is used only when a client probes a server to see if
> it supports RPC-with-TLS. At all other times, the client uses one
> of the normal, legitimate flavors. It does not represent a security
> flavor that can be used during regular operation.
>=20
> NFSv3 mount failover logic is still open for discussion (ie, incomplete).
>=20
> Would it help if rpc.mountd stuck RPC_AUTH_TLS in the auth_flavors
> list? I think clients that don't recognize it should ignore it,
> but I'm not sure. What should a client do if it sees that flavor in
> the list? It's not one that can be used for any other procedure than
> a NULL RPC.

Maybe?  After the client gets the filehandle it's calling FSINFO and
PATHCONF.  The latter get NFS3ERR_ACCES, but nfs_probe_fsinfo() isn't
checking for a negative return code from the PATHCONF operation.  If it
did, it could maybe use the -EACCES coupled with the knowledge that the
server had RPC_AUTH_TLS enabled to emit an error message saying to check
the xprtsec policies (but I don't think that would be as definitive as
what I had in mind) and to fail the mount.

-Scott
>=20
>=20
> >>> If not, this behavior should at least be documented in the man pages.
> >>=20
> >> "crossmnt", and it's kin "nohide", are explained in exports(5).
> >=20
> > rpc.mountd doesn't do any access checking based on xprtsec policies on
> > the export (or krb5 pseudo-flavors, for that matter), so I don't see how
> > "crossmount" or "nohide" would have any effect here.
>=20
> No, they don't, you are correct.
>=20
>=20
> --
> Chuck Lever
>=20
>=20


