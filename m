Return-Path: <linux-nfs+bounces-3174-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E8948BD30B
	for <lists+linux-nfs@lfdr.de>; Mon,  6 May 2024 18:47:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5491828436A
	for <lists+linux-nfs@lfdr.de>; Mon,  6 May 2024 16:47:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3D20156F28;
	Mon,  6 May 2024 16:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Nm0q+Now"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31225156962
	for <linux-nfs@vger.kernel.org>; Mon,  6 May 2024 16:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715014035; cv=none; b=r0jmb+NzAaKP7OL8/QvEhmJreQmO3mQzI1nE9s2UFX3nfUsf3UOk2BhMfzRZBlbNbWXxwQD9gwAc8jV7kxNALpoAG4+c5IThjLE6fsN9Dr0JBFmnOGQU2nANmjHt1hrHlomaEJceLTiZpSdP6UQQi9jZfvY8DQy6EEFINqVwCL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715014035; c=relaxed/simple;
	bh=8Ws9Sbik0n8sCBEIAFqTATMF4a0+lqU3ZLRICj88l0M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NPV0U3lvncZndGnYPat0JYLAu9DcK7zpfhs9StkBKcSYqCUPE5sINciHCQZ2dDiAEuDz8KLtIGm1cWt2/uOjHrn1rz7xebci4ckZxr0XEvzsUifJx3BZM6BXLck/2t+LHz5q0GCdlmo4xXZkbEP+xN7eM3y4muWGzJvWockRvic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Nm0q+Now; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715014033;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DbxpLNCzJZCS9TV+aCZvnvKqPZonRsqfP6dQl825LUY=;
	b=Nm0q+NowfeW19aQR8axVExXqVOODChAlRYvQQwczwN+5CU7VKQ3I50d6XMMb+L9GRc71bK
	rhormEvyXIe77XknhC1XjDHO7aoEXoREOjQjaeANRKbFY8fydDPNiJS4BwQaRboS+CJ4fB
	skC4p1UM5OHT58tXC07g2TxrwAE7I98=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-387-KvCK0s4AOL6LvVfXaBhm4Q-1; Mon, 06 May 2024 12:47:10 -0400
X-MC-Unique: KvCK0s4AOL6LvVfXaBhm4Q-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 55A8318065AA;
	Mon,  6 May 2024 16:47:10 +0000 (UTC)
Received: from aion.redhat.com (unknown [10.22.16.67])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 3CDF01C060D1;
	Mon,  6 May 2024 16:47:10 +0000 (UTC)
Received: by aion.redhat.com (Postfix, from userid 1000)
	id A1B3314A456; Mon,  6 May 2024 12:47:09 -0400 (EDT)
Date: Mon, 6 May 2024 12:47:09 -0400
From: Scott Mayhew <smayhew@redhat.com>
To: Rick Macklem <rick.macklem@gmail.com>
Cc: Chuck Lever <chuck.lever@oracle.com>,
	Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: NFSv3 and xprtsec policies
Message-ID: <ZjkJjbO3cEQqdobs@aion>
References: <ZjO3Qwf_G87yNXb2@aion>
 <100A1A35-2B53-46CA-A448-F82A95CA1EFA@oracle.com>
 <ZjPPZmBZJZVmBuA6@aion>
 <38C9B493-2A43-4691-A19A-8998F0DFAED9@oracle.com>
 <ZjPgq-xA1G6Z2_aQ@aion>
 <ZjUwmthoBkBLaW/I@tissot.1015granger.net>
 <CAM5tNy5aUEBqVRkFqCLqh-8_1cDHv3tz12m1LiaAAdwD-QY2Mw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAM5tNy5aUEBqVRkFqCLqh-8_1cDHv3tz12m1LiaAAdwD-QY2Mw@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7

On Fri, 03 May 2024, Rick Macklem wrote:

> On Fri, May 3, 2024 at 11:45=E2=80=AFAM Chuck Lever <chuck.lever@oracle.c=
om> wrote:
> >
> > On Thu, May 02, 2024 at 02:51:23PM -0400, Scott Mayhew wrote:
> > > On Thu, 02 May 2024, Chuck Lever III wrote:
> > >
> > > >
> > > >
> > > > > On May 2, 2024, at 1:37=E2=80=AFPM, Scott Mayhew <smayhew@redhat.=
com> wrote:
> > > > >
> > > > > On Thu, 02 May 2024, Chuck Lever III wrote:
> > > > >
> > > > >>> On May 2, 2024, at 11:54=E2=80=AFAM, Scott Mayhew <smayhew@redh=
at.com> wrote:
> > > > >>>
> > > > >>> Red Hat QE identified an "interesting" issue with NFSv3 and TLS=
, in that an
> > > > >>> NFSv3 client can mount with "xprtsec=3Dnone" a filesystem expor=
ted with
> > > > >>> "xprtsec=3Dtls:mtls" (in the sense that the client gets the fil=
ehandle and adds a
> > > > >>> mount to its mount table - it can't actually access the mount).
> > > > >>>
> > > > >>> Here's an example using machines from the recent Bakeathon.
> > > > >>>
> > > > >>> Mounting a server with TLS enabled:
> > > > >>>
> > > > >>> # mount -o v4.2,sec=3Dsys,xprtsec=3Dtls oracle-102.chuck.lever.=
oracle.com.nfsv4.dev:/export/tls /mnt
> > > > >>> # umount /mnt
> > > > >>>
> > > > >>> Trying to mount without "xprtsec=3Dtls" shows that the filesyst=
em is not exported with "xprtsec=3Dnone":
> > > > >>>
> > > > >>> # mount -o v4.2,sec=3Dsys oracle-102.chuck.lever.oracle.com.nfs=
v4.dev:/export/tls /mnt
> > > > >>> mount.nfs: Operation not permitted for oracle-102.chuck.lever.o=
racle.com.nfsv4.dev:/export/tls on /mnt
> > > > >>>
> > > > >>> Yet a v3 mount without "xprtsec=3Dtls" works:
> > > > >>>
> > > > >>> # mount -o v3,sec=3Dsys oracle-102.chuck.lever.oracle.com.nfsv4=
=2Edev:/export/tls /mnt
> > > > >>> # umount /mnt
> > > > >>>
> > > > >>> and a mount with no explicit version and without "xprtsec=3Dtls=
" falls back to
> > > > >>> v3 and also "works":
> > > > >>>
> > > > >>> # mount -o sec=3Dsys oracle-102.chuck.lever.oracle.com.nfsv4.de=
v:/export/tls /mnt
> > > > >>> # grep ora /proc/mounts
> > > > >>> oracle-102.chuck.lever.oracle.com.nfsv4.dev:/export/tls /mnt nfs
> > > > >>> +rw,relatime,vers=3D3,rsize=3D524288,wsize=3D524288,namlen=3D25=
5,hard,proto=3Dtcp,timeo=3D600,retrans=3D2,sec=3Dsys,mountaddr=3D100.64.0.4=
9,mountvers=3D3,mountport=3D20048,mountproto=3Dudp,local_lock=3Dnone,addr=
=3D100.64.0.49 0 0
> > > > >>>
> > > > >>> Even though the filesystem is mounted, the client can't do anyt=
hing with it:
> > > > >>>
> > > > >>> # ls /mnt
> > > > >>> ls: cannot open directory '/mnt': Permission denied
> > > > >>>
> > > > >>> When krb5 is used with NFSv3, the server returns a list of pseu=
doflavors in
> > > > >>> mountres3_ok (https://datatracker.ietf.org/doc/html/rfc1813#sec=
tion-5.2.1).
> > > > >>> The client compares that list with its own list of auth flavors=
 parsed from the
> > > > >>> mount request and returns -EACCES if no match is found (see
> > > > >>> nfs_verify_authflavors()).
> > > > >>>
> > > > >>> Perhaps we should be doing something similar with xprtsec polic=
ies?
> > > > >>
> > > > >> The problem might be in how you've set up the exports. With NFSv=
3,
> > > > >> the parent export needs the "crossmnt" export option in order for
> > > > >> NFSv3 to behave like NFSv4 in this regard, although I could have
> > > > >> missed something.
> > > > >
> > > > > I was mounting your server though :)
> > > >
> > > > OK, then not the same bug that Olga found last year.
> > > >
> > > > We should find out what FreeBSD does in this case.
> > >
> > > I thought about that.  Rick's servers from the BAT are offline, and I
> > > don't think he was exporting v3 anyway.
> If you want me to leave the FreeBSD server up on tailscale configured to
> allow NFSv3/RPC-with-TLS mounts, just email.
>=20
> I did a quick test using the FreeBSD client and the mount fails, but I kn=
ow
> that failure happens when it tries to access the server file system in
> the kernel.
> The replies fail with RPC Msg_denied.
> (I've attached a packet trace, in case you are interested.)

Thanks, Rick.  Looking at that trace, freebsd is rejecting the GETATTR
and FSINFO requests at the RPC layer, whereas Linux knfsd isn't.

Digging a little further, both nfsd3_proc_fsinfo() and nfsd3_proc_getattr()
are calling fh_verify() with a flag called NFSD_MAY_BYPASS_GSS_ON_ROOT

---8<---
        resp->status =3D fh_verify(rqstp, &resp->fh, 0,
                                 NFSD_MAY_NOP | NFSD_MAY_BYPASS_GSS_ON_ROOT=
);
---8<---

and fh_verify() has

---8<---
        /*
         * Clients may expect to be able to use auth_sys during mount,
         * even if they use gss for everything else; see section 2.3.2
         * of rfc 2623.
         */
        if (access & NFSD_MAY_BYPASS_GSS_ON_ROOT
                        && exp->ex_path.dentry =3D=3D dentry)
                goto skip_pseudoflavor_check;

        error =3D check_nfsd_access(exp, rqstp);
---8<---

so it's skipping check_nfsd_access(), which is where the xprtsec policy
checking occurs.

Looking at RFC 2623 section 2.3.2, it basically says a server can choose
to not require authentication for GETATTR and FSINFO.  Obviously, RFC
2623 predates RPC-with-TLS by 20+ years, so there's nothing there to
dictate what to do here...  but as Chuck reiterated, TLS isn't a security
flavor so maybe knfsd shouldn't be bypassing those xprtsec policy checks
at all.

-Scott


>=20
> I haven't done anything with the userspace mountd daemon, which means it
> will allow a Mount protocol RPC without TLS and does not return any diffe=
rent
> info (such as a new pseudo flavour).  Adding a pseudo-flavour wouldn't be=
 hard,
> but I have tried hard to avoid adding RPC-with-TLS to the userspace
> RPC libraries.
> (Mainly avoiding the need to link the userspace stuff to the OpenSSL libr=
aries.)
>=20
> > >
> > > >
> > > >
> > > > >>> Should
> > > > >>> there be an errata to RFC 9289 and a request from IANA for assi=
gned numbers for
> > > > >>> pseudo-flavors corresponding to xprtsec policies?
> > > > >>
> > > > >> No. Transport-layer security is not an RPC security flavor or
> > > > >> pseudo-flavor. These two things are not related.
> > > > >>
> > > > >> (And in fact, I proposed something like this for NFSv4 SECINFO,
> > > > >> but it was rejected).
> > > > >
> > > > > I thought it might be a stretch to try to use mountres3.auth_flav=
ors for
> > > > > this, but since RFC 9289 does refer to AUTH_TLS as an authenticat=
ion
> > > > > flavor and https://www.iana.org/assignments/rpc-authentication-nu=
mbers/rpc-authentication-numbers.xhtml
> > > > > also lists TLS under the Flavor Name column I thought it might ma=
ke
> > > > > sense to treat xprtsec policies as if they were pseudo-flavors ev=
en
> > > > > though they're not, if only to give the client a way to determine=
 that
> > > > > the mount should fail.
> > > >
> > > > RPC_AUTH_TLS is used only when a client probes a server to see if
> > > > it supports RPC-with-TLS. At all other times, the client uses one
> > > > of the normal, legitimate flavors. It does not represent a security
> > > > flavor that can be used during regular operation.
> > > >
> > > > NFSv3 mount failover logic is still open for discussion (ie, incomp=
lete).
> > > >
> > > > Would it help if rpc.mountd stuck RPC_AUTH_TLS in the auth_flavors
> > > > list? I think clients that don't recognize it should ignore it,
> > > > but I'm not sure. What should a client do if it sees that flavor in
> > > > the list? It's not one that can be used for any other procedure than
> > > > a NULL RPC.
> > >
> > > Maybe?  After the client gets the filehandle it's calling FSINFO and
> > > PATHCONF.  The latter get NFS3ERR_ACCES, but nfs_probe_fsinfo() isn't
> > > checking for a negative return code from the PATHCONF operation.  If =
it
> > > did, it could maybe use the -EACCES coupled with the knowledge that t=
he
> > > server had RPC_AUTH_TLS enabled to emit an error message saying to ch=
eck
> > > the xprtsec policies (but I don't think that would be as definitive as
> > > what I had in mind) and to fail the mount.
> >
> > If Linux is the only implementation of NFSv3 with TLS so far, then
> > we have some latitude for innovation.
> At this point, FreeBSD can change to whatever you guys think works best,
> although I'd like to avoid adding RPC-with-TLS support to the Mount proto=
col.
>=20
> Have fun with it, rick
>=20
> >
> > I would like to hear from the client maintainers about what they
> > would prefer the client user experience to look like. Then NFSD's
> > behavior can be adjusted to accommodate.
> >
> > In this case, Steve would have to sign off on an rpc.mountd change
> > to return AUTH_TLS in the auth_flavors list.
> >
> >
> > --
> > Chuck Lever
> >



