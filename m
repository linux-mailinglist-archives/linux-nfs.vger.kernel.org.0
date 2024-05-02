Return-Path: <linux-nfs+bounces-3131-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9956E8B9FA0
	for <lists+linux-nfs@lfdr.de>; Thu,  2 May 2024 19:37:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BB12CB20F8A
	for <lists+linux-nfs@lfdr.de>; Thu,  2 May 2024 17:37:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20DA2155350;
	Thu,  2 May 2024 17:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MmD4+uLM"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 777E215CD67
	for <linux-nfs@vger.kernel.org>; Thu,  2 May 2024 17:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714671469; cv=none; b=jIZbv3xnm//EetdgRNeWj7WVHWKsEWfPKwqwbrjiMlL73Zh+lYfOj/Qyh2ZkI+VXBPtL5uBdwOmgt2sajH4IA1bjzQo8cObtnJeEnuoRoH8+FcYUYyaHL6LbSmP94iJiLa5Wb34ekTdGeWIQGlmSG9XDLTBvNxp3LZ1QeqIVZCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714671469; c=relaxed/simple;
	bh=mRD+bu/J+bUGgWbCM6kmNoxREutv3eqlR+x3Q1U3tnQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D2ZRvIuu4+dOaUkcUr2o5d1A268A2PIO8I+UQ5FOJXC0KQk4CLMvMJDRzX6dRZ1JuPkSNTUbAQXmfuwutpWJ7dRantuhmub1VFwBv+CRMraJUzTz6PLDaZLOfstbV3tJhTTAm8ymTEDL1m1c1DZkYvxFq//VDcwO66N/ltyUwIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MmD4+uLM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714671466;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mRD+bu/J+bUGgWbCM6kmNoxREutv3eqlR+x3Q1U3tnQ=;
	b=MmD4+uLMfLq9j/AFyiC16z+geY42TpMR37dkRFA3u8uc5l0h7b5n0dx898/N6SpTtvMlXF
	NYkbxi3OuFRhfOGJZDxZuewnvOy3B43/cWc6iwRIb64WAZj/8u5vvjpkBY2trG2rAJHp+B
	n6NHwmm/hdWtIQ2VKUJ04j69Y4RSAG8=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-484-vvLcG-n0NxOmg9ysmcgBTA-1; Thu,
 02 May 2024 13:37:43 -0400
X-MC-Unique: vvLcG-n0NxOmg9ysmcgBTA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C768A1C03154;
	Thu,  2 May 2024 17:37:42 +0000 (UTC)
Received: from aion.redhat.com (unknown [10.22.16.67])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id BA5FF112131D;
	Thu,  2 May 2024 17:37:42 +0000 (UTC)
Received: by aion.redhat.com (Postfix, from userid 1000)
	id 681FE14A069; Thu,  2 May 2024 13:37:42 -0400 (EDT)
Date: Thu, 2 May 2024 13:37:42 -0400
From: Scott Mayhew <smayhew@redhat.com>
To: Chuck Lever III <chuck.lever@oracle.com>
Cc: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: NFSv3 and xprtsec policies
Message-ID: <ZjPPZmBZJZVmBuA6@aion>
References: <ZjO3Qwf_G87yNXb2@aion>
 <100A1A35-2B53-46CA-A448-F82A95CA1EFA@oracle.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <100A1A35-2B53-46CA-A448-F82A95CA1EFA@oracle.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

On Thu, 02 May 2024, Chuck Lever III wrote:

>=20
>=20
> > On May 2, 2024, at 11:54=E2=80=AFAM, Scott Mayhew <smayhew@redhat.com> =
wrote:
> >=20
> > Red Hat QE identified an "interesting" issue with NFSv3 and TLS, in tha=
t an
> > NFSv3 client can mount with "xprtsec=3Dnone" a filesystem exported with
> > "xprtsec=3Dtls:mtls" (in the sense that the client gets the filehandle =
and adds a
> > mount to its mount table - it can't actually access the mount).
> >=20
> > Here's an example using machines from the recent Bakeathon.
> >=20
> > Mounting a server with TLS enabled:
> >=20
> > # mount -o v4.2,sec=3Dsys,xprtsec=3Dtls oracle-102.chuck.lever.oracle.c=
om.nfsv4.dev:/export/tls /mnt
> > # umount /mnt
> >=20
> > Trying to mount without "xprtsec=3Dtls" shows that the filesystem is no=
t exported with "xprtsec=3Dnone":
> >=20
> > # mount -o v4.2,sec=3Dsys oracle-102.chuck.lever.oracle.com.nfsv4.dev:/=
export/tls /mnt
> > mount.nfs: Operation not permitted for oracle-102.chuck.lever.oracle.co=
m.nfsv4.dev:/export/tls on /mnt
> >=20
> > Yet a v3 mount without "xprtsec=3Dtls" works:
> >=20
> > # mount -o v3,sec=3Dsys oracle-102.chuck.lever.oracle.com.nfsv4.dev:/ex=
port/tls /mnt
> > # umount /mnt
> >=20
> > and a mount with no explicit version and without "xprtsec=3Dtls" falls =
back to
> > v3 and also "works":
> >=20
> > # mount -o sec=3Dsys oracle-102.chuck.lever.oracle.com.nfsv4.dev:/expor=
t/tls /mnt
> > # grep ora /proc/mounts
> > oracle-102.chuck.lever.oracle.com.nfsv4.dev:/export/tls /mnt nfs
> > +rw,relatime,vers=3D3,rsize=3D524288,wsize=3D524288,namlen=3D255,hard,p=
roto=3Dtcp,timeo=3D600,retrans=3D2,sec=3Dsys,mountaddr=3D100.64.0.49,mountv=
ers=3D3,mountport=3D20048,mountproto=3Dudp,local_lock=3Dnone,addr=3D100.64.=
0.49 0 0
> >=20
> > Even though the filesystem is mounted, the client can't do anything wit=
h it:
> >=20
> > # ls /mnt
> > ls: cannot open directory '/mnt': Permission denied
> >=20
> > When krb5 is used with NFSv3, the server returns a list of pseudoflavor=
s in
> > mountres3_ok (https://datatracker.ietf.org/doc/html/rfc1813#section-5.2=
=2E1).
> > The client compares that list with its own list of auth flavors parsed =
=66rom the
> > mount request and returns -EACCES if no match is found (see
> > nfs_verify_authflavors()).
> >=20
> > Perhaps we should be doing something similar with xprtsec policies?
>=20
> The problem might be in how you've set up the exports. With NFSv3,
> the parent export needs the "crossmnt" export option in order for
> NFSv3 to behave like NFSv4 in this regard, although I could have
> missed something.

I was mounting your server though :)
>=20
>=20
> > Should
> > there be an errata to RFC 9289 and a request from IANA for assigned num=
bers for
> > pseudo-flavors corresponding to xprtsec policies?
>=20
> No. Transport-layer security is not an RPC security flavor or
> pseudo-flavor. These two things are not related.
>=20
> (And in fact, I proposed something like this for NFSv4 SECINFO,
> but it was rejected).

I thought it might be a stretch to try to use mountres3.auth_flavors for
this, but since RFC 9289 does refer to AUTH_TLS as an authentication
flavor and https://www.iana.org/assignments/rpc-authentication-numbers/rpc-=
authentication-numbers.xhtml
also lists TLS under the Flavor Name column I thought it might make
sense to treat xprtsec policies as if they were pseudo-flavors even
though they're not, if only to give the client a way to determine that
the mount should fail.

>=20
>=20
> > If not, this behavior should at least be documented in the man pages.
>=20
> "crossmnt", and it's kin "nohide", are explained in exports(5).

rpc.mountd doesn't do any access checking based on xprtsec policies on
the export (or krb5 pseudo-flavors, for that matter), so I don't see how
"crossmount" or "nohide" would have any effect here.

-Scott
>=20
>=20
> --
> Chuck Lever
>=20
>=20


