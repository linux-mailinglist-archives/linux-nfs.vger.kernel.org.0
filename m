Return-Path: <linux-nfs+bounces-3152-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 450388BB511
	for <lists+linux-nfs@lfdr.de>; Fri,  3 May 2024 22:53:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67C151C23063
	for <lists+linux-nfs@lfdr.de>; Fri,  3 May 2024 20:53:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DD15134B1;
	Fri,  3 May 2024 20:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Yy0pMO4E"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FF922C69D
	for <linux-nfs@vger.kernel.org>; Fri,  3 May 2024 20:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714769600; cv=none; b=GoQqaOHpcW/gQnoeOJSeB4nNh6GrtKMSBadU73yaw8XkZHqrx2xeJOVVgR1uF7y8T+ChjJHviG+2kWwF+6mG1j4Wa0oiIxHpvjMOwxrl03aARHVghmoj/2dugcyqafaxy0hqSBJPigL9/hj/3h4GILK30qimkW8cEMrsabg/3F0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714769600; c=relaxed/simple;
	bh=pvfPSXnH5C8wiXvEVbU8G1CZqhiUoUb+7DoGxvzn/3A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PRveaIyYFD5ivUntt/8ltjSVKQILCSWUkALLtaYOJcNuTaXedilv/inJoAq0HU2Tke+7ux53SIKcjs9ZxzIgMDQY/v/Dvtq3hGF+FnUhyh/Zz09hecUE8Pl/tcLrZ6guj9Hb9TGs3ni4urrPA9/ecLVbVWcqCfER7qZId+aNsZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Yy0pMO4E; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714769597;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FisC7etBEMeM6e5IOl8rqa3j3gRBQ2jx+qE8JgJSYfc=;
	b=Yy0pMO4EHIDIw+B9DkKFjOZJ/EnVF5WSo7iYkCJpFwIOfgVFZoeWiIhTxIX524jl4hecU/
	qqMTb3OUSCgdukPuD8uDtKbTyJy3KNz1JTL82w0mctId9BA7llShrPc5nuLO69RRivyCWq
	gtoFALHtJ6wxpwI/VjTEyNNabg2XY4U=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-664-w259o30KP9-Fc9HWpM7WEg-1; Fri,
 03 May 2024 16:53:15 -0400
X-MC-Unique: w259o30KP9-Fc9HWpM7WEg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 36CCB1C02D25;
	Fri,  3 May 2024 20:53:15 +0000 (UTC)
Received: from aion.redhat.com (unknown [10.22.16.67])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 244CC20296D3;
	Fri,  3 May 2024 20:53:15 +0000 (UTC)
Received: by aion.redhat.com (Postfix, from userid 1000)
	id C32E114A212; Fri,  3 May 2024 16:53:14 -0400 (EDT)
Date: Fri, 3 May 2024 16:53:14 -0400
From: Scott Mayhew <smayhew@redhat.com>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: NFSv3 and xprtsec policies
Message-ID: <ZjVOuo1A61TmyTbg@aion>
References: <ZjO3Qwf_G87yNXb2@aion>
 <100A1A35-2B53-46CA-A448-F82A95CA1EFA@oracle.com>
 <ZjPPZmBZJZVmBuA6@aion>
 <38C9B493-2A43-4691-A19A-8998F0DFAED9@oracle.com>
 <ZjPgq-xA1G6Z2_aQ@aion>
 <ZjUwmthoBkBLaW/I@tissot.1015granger.net>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <ZjUwmthoBkBLaW/I@tissot.1015granger.net>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4

On Fri, 03 May 2024, Chuck Lever wrote:

> On Thu, May 02, 2024 at 02:51:23PM -0400, Scott Mayhew wrote:
> > On Thu, 02 May 2024, Chuck Lever III wrote:
> >=20
> > >=20
> > >=20
> > > > On May 2, 2024, at 1:37=E2=80=AFPM, Scott Mayhew <smayhew@redhat.co=
m> wrote:
> > > >=20
> > > > On Thu, 02 May 2024, Chuck Lever III wrote:
> > > >=20
> > > >>> On May 2, 2024, at 11:54=E2=80=AFAM, Scott Mayhew <smayhew@redhat=
=2Ecom> wrote:
> > > >>>=20
> > > >>> Red Hat QE identified an "interesting" issue with NFSv3 and TLS, =
in that an
> > > >>> NFSv3 client can mount with "xprtsec=3Dnone" a filesystem exporte=
d with
> > > >>> "xprtsec=3Dtls:mtls" (in the sense that the client gets the fileh=
andle and adds a
> > > >>> mount to its mount table - it can't actually access the mount).
> > > >>>=20
> > > >>> Here's an example using machines from the recent Bakeathon.
> > > >>>=20
> > > >>> Mounting a server with TLS enabled:
> > > >>>=20
> > > >>> # mount -o v4.2,sec=3Dsys,xprtsec=3Dtls oracle-102.chuck.lever.or=
acle.com.nfsv4.dev:/export/tls /mnt
> > > >>> # umount /mnt
> > > >>>=20
> > > >>> Trying to mount without "xprtsec=3Dtls" shows that the filesystem=
 is not exported with "xprtsec=3Dnone":
> > > >>>=20
> > > >>> # mount -o v4.2,sec=3Dsys oracle-102.chuck.lever.oracle.com.nfsv4=
=2Edev:/export/tls /mnt
> > > >>> mount.nfs: Operation not permitted for oracle-102.chuck.lever.ora=
cle.com.nfsv4.dev:/export/tls on /mnt
> > > >>>=20
> > > >>> Yet a v3 mount without "xprtsec=3Dtls" works:
> > > >>>=20
> > > >>> # mount -o v3,sec=3Dsys oracle-102.chuck.lever.oracle.com.nfsv4.d=
ev:/export/tls /mnt
> > > >>> # umount /mnt
> > > >>>=20
> > > >>> and a mount with no explicit version and without "xprtsec=3Dtls" =
falls back to
> > > >>> v3 and also "works":
> > > >>>=20
> > > >>> # mount -o sec=3Dsys oracle-102.chuck.lever.oracle.com.nfsv4.dev:=
/export/tls /mnt
> > > >>> # grep ora /proc/mounts
> > > >>> oracle-102.chuck.lever.oracle.com.nfsv4.dev:/export/tls /mnt nfs
> > > >>> +rw,relatime,vers=3D3,rsize=3D524288,wsize=3D524288,namlen=3D255,=
hard,proto=3Dtcp,timeo=3D600,retrans=3D2,sec=3Dsys,mountaddr=3D100.64.0.49,=
mountvers=3D3,mountport=3D20048,mountproto=3Dudp,local_lock=3Dnone,addr=3D1=
00.64.0.49 0 0
> > > >>>=20
> > > >>> Even though the filesystem is mounted, the client can't do anythi=
ng with it:
> > > >>>=20
> > > >>> # ls /mnt
> > > >>> ls: cannot open directory '/mnt': Permission denied
> > > >>>=20
> > > >>> When krb5 is used with NFSv3, the server returns a list of pseudo=
flavors in
> > > >>> mountres3_ok (https://datatracker.ietf.org/doc/html/rfc1813#secti=
on-5.2.1).
> > > >>> The client compares that list with its own list of auth flavors p=
arsed from the
> > > >>> mount request and returns -EACCES if no match is found (see
> > > >>> nfs_verify_authflavors()).
> > > >>>=20
> > > >>> Perhaps we should be doing something similar with xprtsec policie=
s?
> > > >>=20
> > > >> The problem might be in how you've set up the exports. With NFSv3,
> > > >> the parent export needs the "crossmnt" export option in order for
> > > >> NFSv3 to behave like NFSv4 in this regard, although I could have
> > > >> missed something.
> > > >=20
> > > > I was mounting your server though :)
> > >=20
> > > OK, then not the same bug that Olga found last year.
> > >=20
> > > We should find out what FreeBSD does in this case.
> >=20
> > I thought about that.  Rick's servers from the BAT are offline, and I
> > don't think he was exporting v3 anyway.
> >=20
> > >=20
> > >=20
> > > >>> Should
> > > >>> there be an errata to RFC 9289 and a request from IANA for assign=
ed numbers for
> > > >>> pseudo-flavors corresponding to xprtsec policies?
> > > >>=20
> > > >> No. Transport-layer security is not an RPC security flavor or
> > > >> pseudo-flavor. These two things are not related.
> > > >>=20
> > > >> (And in fact, I proposed something like this for NFSv4 SECINFO,
> > > >> but it was rejected).
> > > >=20
> > > > I thought it might be a stretch to try to use mountres3.auth_flavor=
s for
> > > > this, but since RFC 9289 does refer to AUTH_TLS as an authentication
> > > > flavor and https://www.iana.org/assignments/rpc-authentication-numb=
ers/rpc-authentication-numbers.xhtml
> > > > also lists TLS under the Flavor Name column I thought it might make
> > > > sense to treat xprtsec policies as if they were pseudo-flavors even
> > > > though they're not, if only to give the client a way to determine t=
hat
> > > > the mount should fail.
> > >=20
> > > RPC_AUTH_TLS is used only when a client probes a server to see if
> > > it supports RPC-with-TLS. At all other times, the client uses one
> > > of the normal, legitimate flavors. It does not represent a security
> > > flavor that can be used during regular operation.
> > >=20
> > > NFSv3 mount failover logic is still open for discussion (ie, incomple=
te).
> > >=20
> > > Would it help if rpc.mountd stuck RPC_AUTH_TLS in the auth_flavors
> > > list? I think clients that don't recognize it should ignore it,
> > > but I'm not sure. What should a client do if it sees that flavor in
> > > the list? It's not one that can be used for any other procedure than
> > > a NULL RPC.
> >=20
> > Maybe?  After the client gets the filehandle it's calling FSINFO and
> > PATHCONF.  The latter get NFS3ERR_ACCES, but nfs_probe_fsinfo() isn't
> > checking for a negative return code from the PATHCONF operation.  If it
> > did, it could maybe use the -EACCES coupled with the knowledge that the
> > server had RPC_AUTH_TLS enabled to emit an error message saying to check
> > the xprtsec policies (but I don't think that would be as definitive as
> > what I had in mind) and to fail the mount.
>=20
> If Linux is the only implementation of NFSv3 with TLS so far, then
> we have some latitude for innovation.
>=20
> I would like to hear from the client maintainers about what they
> would prefer the client user experience to look like. Then NFSD's
> behavior can be adjusted to accommodate.
>=20
> In this case, Steve would have to sign off on an rpc.mountd change
> to return AUTH_TLS in the auth_flavors list.

Maybe instead of messing with the auth_flavors list, we just have the
client check the status from the PATHCONF operation and leave it at
that.

---8<---
diff --git a/fs/nfs/client.c b/fs/nfs/client.c
index 44eca51b2808..09d28dae0f06 100644
--- a/fs/nfs/client.c
+++ b/fs/nfs/client.c
@@ -867,8 +867,10 @@ static int nfs_probe_fsinfo(struct nfs_server *server,=
 struct nfs_fh *mntfh, str
 		pathinfo.fattr =3D fattr;
 		nfs_fattr_init(fattr);
=20
-		if (clp->rpc_ops->pathconf(server, mntfh, &pathinfo) >=3D 0)
-			server->namelen =3D pathinfo.max_namelen;
+		error =3D clp->rpc_ops->pathconf(server, mntfh, &pathinfo);
+		if (error < 0)
+			return error;
+		server->namelen =3D pathinfo.max_namelen;
 	}
=20
 	if (clp->rpc_ops->discover_trunking !=3D NULL &&
---8<---

That's sufficient to make the mount fail with EACCES, which should be
enough of a clue for someone that they should compare the client's mount
options with the server's export options.

[root@rawhide-client ~]# mount -o v3,sec=3Dsys oracle-102.chuck.lever.oracl=
e.com.nfsv4.dev:/export/tls /mnt
mount.nfs: access denied by server while mounting oracle-102.chuck.lever.or=
acle.com.nfsv4.dev:/export/tls

-Scott

>=20
>=20
> --=20
> Chuck Lever
>=20


