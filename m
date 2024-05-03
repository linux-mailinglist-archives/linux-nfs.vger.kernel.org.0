Return-Path: <linux-nfs+bounces-3153-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C13F48BB713
	for <lists+linux-nfs@lfdr.de>; Sat,  4 May 2024 00:31:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E41361C21569
	for <lists+linux-nfs@lfdr.de>; Fri,  3 May 2024 22:31:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 263A42AE83;
	Fri,  3 May 2024 22:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UmS/ot0E"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F6CF290F
	for <linux-nfs@vger.kernel.org>; Fri,  3 May 2024 22:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714775516; cv=none; b=fn4XckzN9ML2YqpgUH8ntU8re1Pxou1FyDosagXivx7MPfq/WheDTq57IZNxbxRV/TnBFagLwkZa97PfNy4xpX1ygQcUbcgh/GvZx4krQHwjbw/qvDYmNsyPhmhG15v6ou9qJdc9yxUkJ8l8NqsUWzuQleurqUMbjus9AXXZ7x0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714775516; c=relaxed/simple;
	bh=Cbu6q79fTFdc7vXeFUDi82o8S+0itUAEzjJdmevm9hU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FMB+IXXyCtKwpLRSLnKrGwmI7NP+42cNJTXflzC25PrhcxhSzqBVGCUK48umgJzO5ezJXRpETreO4pWQz3dzBGcn1MOCZDtyhvvS1xX8pLb7KepjiexJR+irJMebtDT8JORC25Axa915Sbbiz9zFNIVtUjGLp6A7SSMLSef5lqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UmS/ot0E; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2a6fa7773d3so147637a91.3
        for <linux-nfs@vger.kernel.org>; Fri, 03 May 2024 15:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714775514; x=1715380314; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XgB0xYSvxKgZRjmBtfdGpGLFcuc7WFw/gerbRuOe/hc=;
        b=UmS/ot0EFM/bPr9/Hkk7KJSch0vUqFb/uOeP1nflw45p6W+mYQxn42taC/rY8Vyxx4
         n4mIvNgbveOgM+R33IN6bXTYnc+mzAU38QfzjU0DtKiLj2gg1IPhRj2cWKCOrczCV2lp
         Mm5F+LrK3lGiJ3E8BCPPWHxEBnGxckye9eJzD6fta3TJjimcYKAoIfsJ4xCvm93n5oE1
         1nVa3tNREjzVTp9biI1hZRzMtwIfwVEiDOOkXKeOzKg4FQ3rkHc/kiZ3auq+lYbyUf+Q
         s9uRDQ3qfR9xGsrnQC6061ttU//cRyZC3dx8Gt2hJD78kHoNIpQxdq439AzQQ+/ii+Ik
         7Xdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714775514; x=1715380314;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XgB0xYSvxKgZRjmBtfdGpGLFcuc7WFw/gerbRuOe/hc=;
        b=Z9sk3Q3iSMjMNIexroVRegl0sLlbnMpreoFDl9un8b/lwwwkzNoDXZcY4MMGruwM45
         isb+7w6bTz2acBuvY+3w09vA1kn43nIKN9DX5WpqGe4JT2SDzFOKKYmTycpRHdeN4/VA
         RVPr0TefbOO7RLjyeV9lgrLuvH+oowQSZTsgVPOPkRN3qicq4kBnrFn4dpHxF0W2m6EC
         GmtMHTESN1VuFzT8zBjGo3aKhINUSUjP3FRkRbu7c0n0ndQCdn6hL3mEC2xy94RNxR36
         h1y/qRkMBUI3vufM7iyuqkaqao1FM3dboaONBe+e3aGxnsCMp3WzY91A5KHNX+v/NbNW
         he0w==
X-Forwarded-Encrypted: i=1; AJvYcCXkkDAG/km/1pchArznUtsqSKDAMTOhI/NDX70hJjKrP5KcZS9hLP477t80I5IV9yP5v7fnBTJV+fCBF1rQE+eaD6NN7yzvMRCR
X-Gm-Message-State: AOJu0YwRNQW0spgLwBH1vz8bnpFbldh/uucTaFVPdb778Pb4GOVS6ERX
	+QfI1wBNLEGlG4aObyPxFd1yliSRTVXBj7eWTNBiqUb+1WGpE5BmwREllH7wEfyekPX/W6hSu1u
	5l6Kw+7FNIv1Awtz0GYX93CgwWOJW
X-Google-Smtp-Source: AGHT+IFK7DgHScu4fsEeA3BFwXwiHyd0kbaFuwPsLiGJn5r1beJlBivz60EtxDlaqNxzgeZY1TWeJuBTtEDiiEMmG3s=
X-Received: by 2002:a17:90a:ab92:b0:2b3:ed2:1a77 with SMTP id
 n18-20020a17090aab9200b002b30ed21a77mr4107097pjq.10.1714775513577; Fri, 03
 May 2024 15:31:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZjO3Qwf_G87yNXb2@aion> <100A1A35-2B53-46CA-A448-F82A95CA1EFA@oracle.com>
 <ZjPPZmBZJZVmBuA6@aion> <38C9B493-2A43-4691-A19A-8998F0DFAED9@oracle.com>
 <ZjPgq-xA1G6Z2_aQ@aion> <ZjUwmthoBkBLaW/I@tissot.1015granger.net>
In-Reply-To: <ZjUwmthoBkBLaW/I@tissot.1015granger.net>
From: Rick Macklem <rick.macklem@gmail.com>
Date: Fri, 3 May 2024 15:31:43 -0700
Message-ID: <CAM5tNy5aUEBqVRkFqCLqh-8_1cDHv3tz12m1LiaAAdwD-QY2Mw@mail.gmail.com>
Subject: Re: NFSv3 and xprtsec policies
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Scott Mayhew <smayhew@redhat.com>, Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: multipart/mixed; boundary="0000000000005b5c96061794497b"

--0000000000005b5c96061794497b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 3, 2024 at 11:45=E2=80=AFAM Chuck Lever <chuck.lever@oracle.com=
> wrote:
>
> On Thu, May 02, 2024 at 02:51:23PM -0400, Scott Mayhew wrote:
> > On Thu, 02 May 2024, Chuck Lever III wrote:
> >
> > >
> > >
> > > > On May 2, 2024, at 1:37=E2=80=AFPM, Scott Mayhew <smayhew@redhat.co=
m> wrote:
> > > >
> > > > On Thu, 02 May 2024, Chuck Lever III wrote:
> > > >
> > > >>> On May 2, 2024, at 11:54=E2=80=AFAM, Scott Mayhew <smayhew@redhat=
.com> wrote:
> > > >>>
> > > >>> Red Hat QE identified an "interesting" issue with NFSv3 and TLS, =
in that an
> > > >>> NFSv3 client can mount with "xprtsec=3Dnone" a filesystem exporte=
d with
> > > >>> "xprtsec=3Dtls:mtls" (in the sense that the client gets the fileh=
andle and adds a
> > > >>> mount to its mount table - it can't actually access the mount).
> > > >>>
> > > >>> Here's an example using machines from the recent Bakeathon.
> > > >>>
> > > >>> Mounting a server with TLS enabled:
> > > >>>
> > > >>> # mount -o v4.2,sec=3Dsys,xprtsec=3Dtls oracle-102.chuck.lever.or=
acle.com.nfsv4.dev:/export/tls /mnt
> > > >>> # umount /mnt
> > > >>>
> > > >>> Trying to mount without "xprtsec=3Dtls" shows that the filesystem=
 is not exported with "xprtsec=3Dnone":
> > > >>>
> > > >>> # mount -o v4.2,sec=3Dsys oracle-102.chuck.lever.oracle.com.nfsv4=
.dev:/export/tls /mnt
> > > >>> mount.nfs: Operation not permitted for oracle-102.chuck.lever.ora=
cle.com.nfsv4.dev:/export/tls on /mnt
> > > >>>
> > > >>> Yet a v3 mount without "xprtsec=3Dtls" works:
> > > >>>
> > > >>> # mount -o v3,sec=3Dsys oracle-102.chuck.lever.oracle.com.nfsv4.d=
ev:/export/tls /mnt
> > > >>> # umount /mnt
> > > >>>
> > > >>> and a mount with no explicit version and without "xprtsec=3Dtls" =
falls back to
> > > >>> v3 and also "works":
> > > >>>
> > > >>> # mount -o sec=3Dsys oracle-102.chuck.lever.oracle.com.nfsv4.dev:=
/export/tls /mnt
> > > >>> # grep ora /proc/mounts
> > > >>> oracle-102.chuck.lever.oracle.com.nfsv4.dev:/export/tls /mnt nfs
> > > >>> +rw,relatime,vers=3D3,rsize=3D524288,wsize=3D524288,namlen=3D255,=
hard,proto=3Dtcp,timeo=3D600,retrans=3D2,sec=3Dsys,mountaddr=3D100.64.0.49,=
mountvers=3D3,mountport=3D20048,mountproto=3Dudp,local_lock=3Dnone,addr=3D1=
00.64.0.49 0 0
> > > >>>
> > > >>> Even though the filesystem is mounted, the client can't do anythi=
ng with it:
> > > >>>
> > > >>> # ls /mnt
> > > >>> ls: cannot open directory '/mnt': Permission denied
> > > >>>
> > > >>> When krb5 is used with NFSv3, the server returns a list of pseudo=
flavors in
> > > >>> mountres3_ok (https://datatracker.ietf.org/doc/html/rfc1813#secti=
on-5.2.1).
> > > >>> The client compares that list with its own list of auth flavors p=
arsed from the
> > > >>> mount request and returns -EACCES if no match is found (see
> > > >>> nfs_verify_authflavors()).
> > > >>>
> > > >>> Perhaps we should be doing something similar with xprtsec policie=
s?
> > > >>
> > > >> The problem might be in how you've set up the exports. With NFSv3,
> > > >> the parent export needs the "crossmnt" export option in order for
> > > >> NFSv3 to behave like NFSv4 in this regard, although I could have
> > > >> missed something.
> > > >
> > > > I was mounting your server though :)
> > >
> > > OK, then not the same bug that Olga found last year.
> > >
> > > We should find out what FreeBSD does in this case.
> >
> > I thought about that.  Rick's servers from the BAT are offline, and I
> > don't think he was exporting v3 anyway.
If you want me to leave the FreeBSD server up on tailscale configured to
allow NFSv3/RPC-with-TLS mounts, just email.

I did a quick test using the FreeBSD client and the mount fails, but I know
that failure happens when it tries to access the server file system in
the kernel.
The replies fail with RPC Msg_denied.
(I've attached a packet trace, in case you are interested.)

I haven't done anything with the userspace mountd daemon, which means it
will allow a Mount protocol RPC without TLS and does not return any differe=
nt
info (such as a new pseudo flavour).  Adding a pseudo-flavour wouldn't be h=
ard,
but I have tried hard to avoid adding RPC-with-TLS to the userspace
RPC libraries.
(Mainly avoiding the need to link the userspace stuff to the OpenSSL librar=
ies.)

> >
> > >
> > >
> > > >>> Should
> > > >>> there be an errata to RFC 9289 and a request from IANA for assign=
ed numbers for
> > > >>> pseudo-flavors corresponding to xprtsec policies?
> > > >>
> > > >> No. Transport-layer security is not an RPC security flavor or
> > > >> pseudo-flavor. These two things are not related.
> > > >>
> > > >> (And in fact, I proposed something like this for NFSv4 SECINFO,
> > > >> but it was rejected).
> > > >
> > > > I thought it might be a stretch to try to use mountres3.auth_flavor=
s for
> > > > this, but since RFC 9289 does refer to AUTH_TLS as an authenticatio=
n
> > > > flavor and https://www.iana.org/assignments/rpc-authentication-numb=
ers/rpc-authentication-numbers.xhtml
> > > > also lists TLS under the Flavor Name column I thought it might make
> > > > sense to treat xprtsec policies as if they were pseudo-flavors even
> > > > though they're not, if only to give the client a way to determine t=
hat
> > > > the mount should fail.
> > >
> > > RPC_AUTH_TLS is used only when a client probes a server to see if
> > > it supports RPC-with-TLS. At all other times, the client uses one
> > > of the normal, legitimate flavors. It does not represent a security
> > > flavor that can be used during regular operation.
> > >
> > > NFSv3 mount failover logic is still open for discussion (ie, incomple=
te).
> > >
> > > Would it help if rpc.mountd stuck RPC_AUTH_TLS in the auth_flavors
> > > list? I think clients that don't recognize it should ignore it,
> > > but I'm not sure. What should a client do if it sees that flavor in
> > > the list? It's not one that can be used for any other procedure than
> > > a NULL RPC.
> >
> > Maybe?  After the client gets the filehandle it's calling FSINFO and
> > PATHCONF.  The latter get NFS3ERR_ACCES, but nfs_probe_fsinfo() isn't
> > checking for a negative return code from the PATHCONF operation.  If it
> > did, it could maybe use the -EACCES coupled with the knowledge that the
> > server had RPC_AUTH_TLS enabled to emit an error message saying to chec=
k
> > the xprtsec policies (but I don't think that would be as definitive as
> > what I had in mind) and to fail the mount.
>
> If Linux is the only implementation of NFSv3 with TLS so far, then
> we have some latitude for innovation.
At this point, FreeBSD can change to whatever you guys think works best,
although I'd like to avoid adding RPC-with-TLS support to the Mount protoco=
l.

Have fun with it, rick

>
> I would like to hear from the client maintainers about what they
> would prefer the client user experience to look like. Then NFSD's
> behavior can be adjusted to accommodate.
>
> In this case, Steve would have to sign off on an rpc.mountd change
> to return AUTH_TLS in the auth_flavors list.
>
>
> --
> Chuck Lever
>

--0000000000005b5c96061794497b
Content-Type: application/octet-stream; 
	name="freebsd-tls-with-rpc-v3-mount-failure.pcap"
Content-Disposition: attachment; 
	filename="freebsd-tls-with-rpc-v3-mount-failure.pcap"
Content-Transfer-Encoding: base64
Content-ID: <f_lvr8znef0>
X-Attachment-Id: f_lvr8znef0

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
dPdVjmqAEAEQniUAAAEBCAocr3pMX1sQKg==
--0000000000005b5c96061794497b--

