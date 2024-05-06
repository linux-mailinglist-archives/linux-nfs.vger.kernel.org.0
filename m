Return-Path: <linux-nfs+bounces-3186-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CBA58BD7AB
	for <lists+linux-nfs@lfdr.de>; Tue,  7 May 2024 00:41:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1FE35B21422
	for <lists+linux-nfs@lfdr.de>; Mon,  6 May 2024 22:41:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C71DC13D2A7;
	Mon,  6 May 2024 22:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GAwDGzuO"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DB6F1E492
	for <linux-nfs@vger.kernel.org>; Mon,  6 May 2024 22:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715035300; cv=none; b=bpQuTSxt/08wJAm3l19hBkyeywK8sTzdmfJwFWQAxcUtgtlhSeJOiNWM6UnQVuxlATP6oRze8KNdoJn0tAlxdqLsUy0LxZKagBov1XcShsh+6ZyQPQ4vNpB+g5wUOnY0BM1lczHL9Fjg8VXMR/pLU3ClQdpM1XQR2wE5TkKQ5uQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715035300; c=relaxed/simple;
	bh=H1CPCDwRnC4bZrcJwJOQX2N1rN9lbCSASJ4ni1HblOA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V5wnnOcUzISPFHHnQjxZwqWupyfjjEN4ULWesdK5PFCs67cLmcadpZMqj8UGcNFm5MEMhNLMKYeAyiMo7HtszAxPKZZtnrGaeIBN0NilqrJOvL3tffrV4raJaKRvmrdfEiIXow2BYkOVH/YAl4mnZa4DA6Mtr/00Ui8t9rNjLOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GAwDGzuO; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-620e30d8f37so2145909a12.2
        for <linux-nfs@vger.kernel.org>; Mon, 06 May 2024 15:41:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715035298; x=1715640098; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KZ2b4vCL+BFKPOoPemwl3oDylEw1udt2LDjfxdtno/I=;
        b=GAwDGzuO7Hlfg+4VPIBmnqCB4ffzrvuvn1Jyt6X7ddkAjDWUZQ0W+/LsOxl+YbrlUR
         cXfY8J34JlXpszOBMGzEvdhQwd3sMLoX0AyDrBTHxeyk4Fw4dXGRmBecYivZ7sskqugg
         bd482yKgZVagV+abZiip7A0uD5bHxUa0gp/L5G26T4PC5GIf/bDc4OSm/2jvr99EizF8
         eNBeYbOiWapo9uAaQHQmD6w2GL7fLTsmtJ4/eJ2zt+nP65UImqu6UY3ULg3Rtt9SphI8
         eXTQc+VzhqlpnmjwHr+COFv7vQxZjiDFsz/4TfCLm4vMVNsOhFABHp0QpZGVFkanic7x
         qbsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715035298; x=1715640098;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KZ2b4vCL+BFKPOoPemwl3oDylEw1udt2LDjfxdtno/I=;
        b=MVUvaAWSBCJJGHrmyfQNakxxgn+zxP8PzPTbWmOEcHwqWfi/J7n1X4ojZCkoUmvbnQ
         r67Ck/VcfmfucsdrTJW8dN2IxQfV9LnbElrwHl9o+qkMwPbu4AbRYFjLLQaNPAaANoGR
         udzLZYmR139extr8ewxf0uV8KsxDEuVlOZLEN2RJNiAa5RUnm64Cp2gK/VrqyrLXugZj
         ip9wMNceiZjz1nv/G9dtrFobElQHPcgjFdv4wJsXOmeUNb+T5yVJcpSwTHb1QHiSIvX9
         pxpQELLBC6bnNGk5WRojXHybJvV9A7bB7wo4gf2ZHXLuDHeyXGiHPzzrPcdA2kKkfa3q
         N3sw==
X-Forwarded-Encrypted: i=1; AJvYcCWWbt9onV9FXwHQ8M8si+K+J6mLOK0dISX6PfIEf1N235LdjZFq29qOM/EB119x2Pt73eHrU/e4RZltHlZqZSTKckkURPv/Uo39
X-Gm-Message-State: AOJu0YxiHDYDfF/AjL5iLnLwIv3Ef/uDxJ5EfZ9vkfnHla90Tqy9hs5J
	7IlMzafzJsTE3pEIl8BFUsc7y+kiC++wdF97Zhtjxs/avPUjvVQUL2GbjDTs1sgxPjNOj8AfWNi
	QFpHDPjRPT/dDE016LzfQJG1Ong==
X-Google-Smtp-Source: AGHT+IFooNYEDTYWQMrNDOOfufOSRXVvUaT0tDOzaXeA3NrZetUyCLrpB5vL3dwzLFMP6aii/Tr3E4hpbAVvwfL5vgs=
X-Received: by 2002:a05:6a21:920d:b0:1a8:e79a:2b0a with SMTP id
 tl13-20020a056a21920d00b001a8e79a2b0amr15295772pzb.0.1715035298080; Mon, 06
 May 2024 15:41:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZjO3Qwf_G87yNXb2@aion> <100A1A35-2B53-46CA-A448-F82A95CA1EFA@oracle.com>
 <ZjPPZmBZJZVmBuA6@aion> <38C9B493-2A43-4691-A19A-8998F0DFAED9@oracle.com>
 <ZjPgq-xA1G6Z2_aQ@aion> <ZjUwmthoBkBLaW/I@tissot.1015granger.net>
 <CAM5tNy5aUEBqVRkFqCLqh-8_1cDHv3tz12m1LiaAAdwD-QY2Mw@mail.gmail.com> <ZjkJjbO3cEQqdobs@aion>
In-Reply-To: <ZjkJjbO3cEQqdobs@aion>
From: Rick Macklem <rick.macklem@gmail.com>
Date: Mon, 6 May 2024 15:41:27 -0700
Message-ID: <CAM5tNy4rxQ7noUwF+mQ9=W=aVYvhyFE5JvH69j98rnhUz4PYWw@mail.gmail.com>
Subject: Re: NFSv3 and xprtsec policies
To: Scott Mayhew <smayhew@redhat.com>
Cc: Chuck Lever <chuck.lever@oracle.com>, 
	Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 6, 2024 at 9:47=E2=80=AFAM Scott Mayhew <smayhew@redhat.com> wr=
ote:
>
> On Fri, 03 May 2024, Rick Macklem wrote:
>
> > On Fri, May 3, 2024 at 11:45=E2=80=AFAM Chuck Lever <chuck.lever@oracle=
.com> wrote:
> > >
> > > On Thu, May 02, 2024 at 02:51:23PM -0400, Scott Mayhew wrote:
> > > > On Thu, 02 May 2024, Chuck Lever III wrote:
> > > >
> > > > >
> > > > >
> > > > > > On May 2, 2024, at 1:37=E2=80=AFPM, Scott Mayhew <smayhew@redha=
t.com> wrote:
> > > > > >
> > > > > > On Thu, 02 May 2024, Chuck Lever III wrote:
> > > > > >
> > > > > >>> On May 2, 2024, at 11:54=E2=80=AFAM, Scott Mayhew <smayhew@re=
dhat.com> wrote:
> > > > > >>>
> > > > > >>> Red Hat QE identified an "interesting" issue with NFSv3 and T=
LS, in that an
> > > > > >>> NFSv3 client can mount with "xprtsec=3Dnone" a filesystem exp=
orted with
> > > > > >>> "xprtsec=3Dtls:mtls" (in the sense that the client gets the f=
ilehandle and adds a
> > > > > >>> mount to its mount table - it can't actually access the mount=
).
> > > > > >>>
> > > > > >>> Here's an example using machines from the recent Bakeathon.
> > > > > >>>
> > > > > >>> Mounting a server with TLS enabled:
> > > > > >>>
> > > > > >>> # mount -o v4.2,sec=3Dsys,xprtsec=3Dtls oracle-102.chuck.leve=
r.oracle.com.nfsv4.dev:/export/tls /mnt
> > > > > >>> # umount /mnt
> > > > > >>>
> > > > > >>> Trying to mount without "xprtsec=3Dtls" shows that the filesy=
stem is not exported with "xprtsec=3Dnone":
> > > > > >>>
> > > > > >>> # mount -o v4.2,sec=3Dsys oracle-102.chuck.lever.oracle.com.n=
fsv4.dev:/export/tls /mnt
> > > > > >>> mount.nfs: Operation not permitted for oracle-102.chuck.lever=
.oracle.com.nfsv4.dev:/export/tls on /mnt
> > > > > >>>
> > > > > >>> Yet a v3 mount without "xprtsec=3Dtls" works:
> > > > > >>>
> > > > > >>> # mount -o v3,sec=3Dsys oracle-102.chuck.lever.oracle.com.nfs=
v4.dev:/export/tls /mnt
> > > > > >>> # umount /mnt
> > > > > >>>
> > > > > >>> and a mount with no explicit version and without "xprtsec=3Dt=
ls" falls back to
> > > > > >>> v3 and also "works":
> > > > > >>>
> > > > > >>> # mount -o sec=3Dsys oracle-102.chuck.lever.oracle.com.nfsv4.=
dev:/export/tls /mnt
> > > > > >>> # grep ora /proc/mounts
> > > > > >>> oracle-102.chuck.lever.oracle.com.nfsv4.dev:/export/tls /mnt =
nfs
> > > > > >>> +rw,relatime,vers=3D3,rsize=3D524288,wsize=3D524288,namlen=3D=
255,hard,proto=3Dtcp,timeo=3D600,retrans=3D2,sec=3Dsys,mountaddr=3D100.64.0=
.49,mountvers=3D3,mountport=3D20048,mountproto=3Dudp,local_lock=3Dnone,addr=
=3D100.64.0.49 0 0
> > > > > >>>
> > > > > >>> Even though the filesystem is mounted, the client can't do an=
ything with it:
> > > > > >>>
> > > > > >>> # ls /mnt
> > > > > >>> ls: cannot open directory '/mnt': Permission denied
> > > > > >>>
> > > > > >>> When krb5 is used with NFSv3, the server returns a list of ps=
eudoflavors in
> > > > > >>> mountres3_ok (https://datatracker.ietf.org/doc/html/rfc1813#s=
ection-5.2.1).
> > > > > >>> The client compares that list with its own list of auth flavo=
rs parsed from the
> > > > > >>> mount request and returns -EACCES if no match is found (see
> > > > > >>> nfs_verify_authflavors()).
> > > > > >>>
> > > > > >>> Perhaps we should be doing something similar with xprtsec pol=
icies?
> > > > > >>
> > > > > >> The problem might be in how you've set up the exports. With NF=
Sv3,
> > > > > >> the parent export needs the "crossmnt" export option in order =
for
> > > > > >> NFSv3 to behave like NFSv4 in this regard, although I could ha=
ve
> > > > > >> missed something.
> > > > > >
> > > > > > I was mounting your server though :)
> > > > >
> > > > > OK, then not the same bug that Olga found last year.
> > > > >
> > > > > We should find out what FreeBSD does in this case.
> > > >
> > > > I thought about that.  Rick's servers from the BAT are offline, and=
 I
> > > > don't think he was exporting v3 anyway.
> > If you want me to leave the FreeBSD server up on tailscale configured t=
o
> > allow NFSv3/RPC-with-TLS mounts, just email.
> >
> > I did a quick test using the FreeBSD client and the mount fails, but I =
know
> > that failure happens when it tries to access the server file system in
> > the kernel.
> > The replies fail with RPC Msg_denied.
> > (I've attached a packet trace, in case you are interested.)
>
> Thanks, Rick.  Looking at that trace, freebsd is rejecting the GETATTR
> and FSINFO requests at the RPC layer, whereas Linux knfsd isn't.
>
> Digging a little further, both nfsd3_proc_fsinfo() and nfsd3_proc_getattr=
()
> are calling fh_verify() with a flag called NFSD_MAY_BYPASS_GSS_ON_ROOT
>
> ---8<---
>         resp->status =3D fh_verify(rqstp, &resp->fh, 0,
>                                  NFSD_MAY_NOP | NFSD_MAY_BYPASS_GSS_ON_RO=
OT);
> ---8<---
>
> and fh_verify() has
>
> ---8<---
>         /*
>          * Clients may expect to be able to use auth_sys during mount,
>          * even if they use gss for everything else; see section 2.3.2
>          * of rfc 2623.
>          */
>         if (access & NFSD_MAY_BYPASS_GSS_ON_ROOT
>                         && exp->ex_path.dentry =3D=3D dentry)
>                 goto skip_pseudoflavor_check;
>
>         error =3D check_nfsd_access(exp, rqstp);
> ---8<---
>
> so it's skipping check_nfsd_access(), which is where the xprtsec policy
> checking occurs.
>
> Looking at RFC 2623 section 2.3.2, it basically says a server can choose
> to not require authentication for GETATTR and FSINFO.
My guess would be that this was done to allow root to do a mount without
having a TGT. I don't think the concept of a host/fqdn@realm keytab entry
was invented until NFSv4 came along.

>  Obviously, RFC
> 2623 predates RPC-with-TLS by 20+ years, so there's nothing there to
> dictate what to do here...  but as Chuck reiterated, TLS isn't a security
> flavor so maybe knfsd shouldn't be bypassing those xprtsec policy checks
> at all.
I'd agree with Chuck and do not see why a mount being done by root cannot
do GETATTR/FSINFO after doing a TLS handshake.
But, obviously, it is up to you guys.

Have fun with it, rick

>
> -Scott
>
>
> >
> > I haven't done anything with the userspace mountd daemon, which means i=
t
> > will allow a Mount protocol RPC without TLS and does not return any dif=
ferent
> > info (such as a new pseudo flavour).  Adding a pseudo-flavour wouldn't =
be hard,
> > but I have tried hard to avoid adding RPC-with-TLS to the userspace
> > RPC libraries.
> > (Mainly avoiding the need to link the userspace stuff to the OpenSSL li=
braries.)
> >
> > > >
> > > > >
> > > > >
> > > > > >>> Should
> > > > > >>> there be an errata to RFC 9289 and a request from IANA for as=
signed numbers for
> > > > > >>> pseudo-flavors corresponding to xprtsec policies?
> > > > > >>
> > > > > >> No. Transport-layer security is not an RPC security flavor or
> > > > > >> pseudo-flavor. These two things are not related.
> > > > > >>
> > > > > >> (And in fact, I proposed something like this for NFSv4 SECINFO=
,
> > > > > >> but it was rejected).
> > > > > >
> > > > > > I thought it might be a stretch to try to use mountres3.auth_fl=
avors for
> > > > > > this, but since RFC 9289 does refer to AUTH_TLS as an authentic=
ation
> > > > > > flavor and https://www.iana.org/assignments/rpc-authentication-=
numbers/rpc-authentication-numbers.xhtml
> > > > > > also lists TLS under the Flavor Name column I thought it might =
make
> > > > > > sense to treat xprtsec policies as if they were pseudo-flavors =
even
> > > > > > though they're not, if only to give the client a way to determi=
ne that
> > > > > > the mount should fail.
> > > > >
> > > > > RPC_AUTH_TLS is used only when a client probes a server to see if
> > > > > it supports RPC-with-TLS. At all other times, the client uses one
> > > > > of the normal, legitimate flavors. It does not represent a securi=
ty
> > > > > flavor that can be used during regular operation.
> > > > >
> > > > > NFSv3 mount failover logic is still open for discussion (ie, inco=
mplete).
> > > > >
> > > > > Would it help if rpc.mountd stuck RPC_AUTH_TLS in the auth_flavor=
s
> > > > > list? I think clients that don't recognize it should ignore it,
> > > > > but I'm not sure. What should a client do if it sees that flavor =
in
> > > > > the list? It's not one that can be used for any other procedure t=
han
> > > > > a NULL RPC.
> > > >
> > > > Maybe?  After the client gets the filehandle it's calling FSINFO an=
d
> > > > PATHCONF.  The latter get NFS3ERR_ACCES, but nfs_probe_fsinfo() isn=
't
> > > > checking for a negative return code from the PATHCONF operation.  I=
f it
> > > > did, it could maybe use the -EACCES coupled with the knowledge that=
 the
> > > > server had RPC_AUTH_TLS enabled to emit an error message saying to =
check
> > > > the xprtsec policies (but I don't think that would be as definitive=
 as
> > > > what I had in mind) and to fail the mount.
> > >
> > > If Linux is the only implementation of NFSv3 with TLS so far, then
> > > we have some latitude for innovation.
> > At this point, FreeBSD can change to whatever you guys think works best=
,
> > although I'd like to avoid adding RPC-with-TLS support to the Mount pro=
tocol.
> >
> > Have fun with it, rick
> >
> > >
> > > I would like to hear from the client maintainers about what they
> > > would prefer the client user experience to look like. Then NFSD's
> > > behavior can be adjusted to accommodate.
> > >
> > > In this case, Steve would have to sign off on an rpc.mountd change
> > > to return AUTH_TLS in the auth_flavors list.
> > >
> > >
> > > --
> > > Chuck Lever
> > >
>
>

