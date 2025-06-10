Return-Path: <linux-nfs+bounces-12253-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E756CAD390B
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Jun 2025 15:26:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB808189AFFA
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Jun 2025 13:20:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C320A2D027F;
	Tue, 10 Jun 2025 13:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BLkoTdIw"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5EC617736
	for <linux-nfs@vger.kernel.org>; Tue, 10 Jun 2025 13:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749561387; cv=none; b=BPIPdm9+CxUyK0Qp9QwU3jhDoydODQ6Nt9rQE/IUkrWncHN2HH0YuAZgLvuXGVMptyBiS7OHO6qVAnWHdIEURrYPqkGVSGYf7ch+lIwK2DE53vXazlDJRRa3jotwrsqHmO9yqcD0SzCJw59VxtaQVxnpH6+YUNfbRivTy39sbAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749561387; c=relaxed/simple;
	bh=TNRl3bozclOV3isWg4Id8sI45c8iEv8Fk34wz9uyEbM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K7E1M8y8pljyHJsmtMR8VB5yc8FavgeXD9q3yswgcuhk3fEvqLalZSR5bQKrvmfPjyDcCkwkFx/fkumZf+ydmdf/wlyFiQy7uL2yR1kK0GN1uSgku6ysqiBv0dFlXN0503Zk6tPwElpmgtgDNFIws6YrhklwdbhkfXdRPlN3O2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BLkoTdIw; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-606ddbda275so10018679a12.1
        for <linux-nfs@vger.kernel.org>; Tue, 10 Jun 2025 06:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749561384; x=1750166184; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x/zjMCH8tIfTyC0kacGN1Qwa9q1v93tfzU+V6kMsQf8=;
        b=BLkoTdIwMUweamvhu8lEWG7Edn0/LvC3XzAsbJUIUaPKJAGWSJ8qDH4/vqqLFSE2Nw
         F7sDMx4fxCNx+9G5rP6tZ0ZjMmaSTkYTT03vJ1wdAnzPlgdUXMc0my1vyrXrlSHIJiGv
         wZ9FK2pEfgy3xtG0YJyPQIdAD2Nj4WYc6TddShgf82J5qYHCalRRa35FWPe8sPy+yB0x
         yToYdmn60MTcTKHxh6v6rQK+DCTrE+N/Dkz1J687H0KssNHNr/L156XKlqwErA3KXolw
         Skp5QrkDi89/Tz1PRWiKALeO9wo15yuMntkob3tTiOBd04Kcs610yaUPfMia0FBoxiQY
         6iGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749561384; x=1750166184;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x/zjMCH8tIfTyC0kacGN1Qwa9q1v93tfzU+V6kMsQf8=;
        b=J0+tirOA6sOhXXjP8INW5NgTI8ThO6DTzhYfCqjt53VDRqdInU+NUxka3mg+wYThhN
         00HIBlv2p91BX9McjGt1x9c/44i2iGkz8N178mZ5xJde0MScF9Pf64YJR3t3gKCLm7ak
         ByjAysuPq6cYkX0iaBgLwnazdMNZQY5DVcaew7VD6OPDt62Xx+ksd1NNjwvx0EXGdopr
         qEJ0YMTv5xVLTSIaVl9Rplxo7C4s8S+bCqud5N1+uqJOqwp8F2xyTH56/CgmLg640UCt
         +ghauPrmrh2J+QM58PBVY/4DF07UOti+DNYSx5D7H4YQZblNjGCqxGUIgyuqZR1PwmM0
         /TjQ==
X-Forwarded-Encrypted: i=1; AJvYcCXO6vzbfO3i5mawChryf7v/1fzIFAGVm/JsCr1xrDY+6vdSnZAcacTIYlsuHIbyF4N5yAtdI+YBlBU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVxgoG3dHaSQSQJoOtSKW7ZqHD10ke94pDt9saxEcj5nFBStiy
	1vr84E300b2a+oxzDovyT5qTJmJMXQH+2ym7yANG30nItBPspi8s+rSewjQZKVgvH2rBtpgBd9H
	F5KITVZx+xci2f8yXSmle6vGNFQ+vImYT6kXdYw==
X-Gm-Gg: ASbGncsBjARFR2r0H+g6ZNdckji5zRE8QX+JaNrhVn2xpnAHbMVs983bpZCzcv8p/kf
	UPzgoRFL9DSNuURE3NDSA6z46gN/ReIF+6enNiZeoJ5VAV2qPHLgexEEPzVDJ/aGnwM0lgo0hsU
	qefObFr0cu9ENbIio4xweMjFnCe08iay/yNBqgCGOZ8/QkkJMefU0CKypmB8yh3kOf8GmseHm51
	ts=
X-Google-Smtp-Source: AGHT+IHgYpvoMwE6exqKEzkSdnt1pOQPIBJGNLDOss/g5ewdt0t2FKZVwZSBVFX1RerlXzWk5GrFQEbvBpToyHY/NqA=
X-Received: by 2002:a05:6402:1e92:b0:607:2417:6d04 with SMTP id
 4fb4d7f45d1cf-6077351442cmr14872778a12.14.1749561383625; Tue, 10 Jun 2025
 06:16:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAM5tNy7kfqToA8p4-=LOnhvZuk36vocy32U6kgT+561uOWR_iQ@mail.gmail.com>
 <f84bed7e-e96c-4a7e-95e6-2a28a574947c@oracle.com> <CAM5tNy5rBMrqfQ7S6fZNciWovkf8K9tc+cuV7q0MALocyzYV7A@mail.gmail.com>
 <3c60168c-630e-4253-a9c2-e88a3ed21696@oracle.com>
In-Reply-To: <3c60168c-630e-4253-a9c2-e88a3ed21696@oracle.com>
From: Rick Macklem <rick.macklem@gmail.com>
Date: Tue, 10 Jun 2025 06:16:10 -0700
X-Gm-Features: AX0GCFt2TGNJ7UZX7r9eN_kPyfTgkbNOScuLJ--Qkfyt2U8pSGWvjkxnCeFMF8M
Message-ID: <CAM5tNy5wssyrntPHQNreU3Au0aYUBRMUuTR0ixtcng5YmFq3iA@mail.gmail.com>
Subject: Re: simple NFSv4.1/4.2 test of remove while holding a delegation
To: Dai Ngo <dai.ngo@oracle.com>
Cc: NFSv4 <nfsv4@ietf.org>, Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 10, 2025 at 4:58=E2=80=AFAM Dai Ngo <dai.ngo@oracle.com> wrote:
>
>
> On 6/9/25 6:06 PM, Rick Macklem wrote:
> > On Mon, Jun 9, 2025 at 5:17=E2=80=AFPM Dai Ngo <dai.ngo@oracle.com> wro=
te:
> >> On 6/9/25 4:35 PM, Rick Macklem wrote:
> >>> Hi,
> >>>
> >>> I hope you don't mind a cross-post, but I thought both groups
> >>> might find this interesting...
> >>>
> >>> I have been creating a compound RPC that does REMOVE and
> >>> then tries to determine if the file object has been removed and
> >>> I was surprised to see quite different results from the Linux knfsd
> >>> and Solaris 11.4 NFSv4.1/4.2 servers. I think both these servers
> >>> provide FH4_PERSISTENT file handles, although I suppose I
> >>> should check that?
> >>>
> >>> First, the test OPEN/CREATEs a regular file called "foo" (only one
> >>> hard link) and acquires a write delegation for it.
> >>> Then a compound does the following:
> >>> ...
> >>> REMOVE foo
> >>> PUTFH fh for foo
> >>> GETATTR
> >>>
> >>> For the Solaris 11.4 server, the server CB_RECALLs the
> >>> delegation and then replies NFS4ERR_STALE for the PUTFH above.
> >>> (The FreeBSD server currently does the same.)
> >>>
> >>> For a fairly recent Linux (6.12) knfsd, the above replies NFS_OK
> >>> with nlinks =3D=3D 0 in the GETATTR reply.
> >>>
> >>> Hmm. So I've looked in RFC8881 (I'm terrible at reading it so I
> >>> probably missed something) and I cannot find anything that states
> >>> either of the above behaviours is incorrect.
> >>> (NFS4ERR_STALE is listed as an error code for PUTFH, but the
> >>> description of PUTFH only says that it sets the CFH to the fh arg.
> >>> It does not say anything w.r.t. the fh arg. needing to be for a file
> >>> that still exists.) Neither of these servers sets
> >>> OPEN4_RESULT_PRESERVE_UNLINKED in the OPEN reply.
> >>>
> >>> So, it looks like "file object no longer exists" is indicated either
> >>> by a NFS4ERR_STALE reply to either PUTFH or GETATTR
> >>> OR
> >>> by a successful reply, but with nlinks =3D=3D 0 for the GETATTR reply=
.
> >>>
> >>> To be honest, I kinda like the Linux knfsd version, but I am wonderin=
g
> >>> if others think that both of these replies is correct?
> >>>
> >>> Also, is the CB_RECALL needed when the delegation is held by
> >>> the same client as the one doing the REMOVE?
> >> The Linux NFSD detects the delegation belongs to the same client that
> >> causes the conflict (due to REMOVE) and skips the CB_RECALL. This is
> >> an optimization based on the assumption that the client would handle
> >> the conflict locally.
> > And then what does the server do with the delegation?
> > - Does it just discard it, since the file object has been deleted?
> > OR
> > - Does it guarantee that a DELEGRETURN done after the REMOVE will
> >    still work (which seems to be the case for the 6.12 server I am usin=
g for
> >    testing).
>
> The delegation remains valid but the file was removed from the namespace.
> This is why the PUTFH and GETATTR in your test did not fail. However, any
> lookup of the file will fail.
>
> >
> >> If the REMOVE was done by another client, the REMOVE will not complete
> >> until the delegation is returned. If the PUTFH comes after the REMOVE
> >> was completed, it'll  fail with NFS4ERR_STALE since the file, specifie=
d
> >> by the file handle, no longer exists.
> > Assuming the statement w.r.t. "fail with NFS4ERR_STALE" only applies to
> > "REMOVE done by another client" then that sounds fine.
>
> Correction: even if the REMOVE was done by the another client and the
> delegation was recalled from the 1st client, the open stateid of the file
> remains valid until the client sends the CLOSE. So the PUTFH won't fail
> regardless which client sends the REMOVE.
So, should your server be setting OPEN4_RESULT_PRESERVE_UNLINKED
in OPEN replies, given this semantic?
--> If the FH remains valid after REMOVE drops nlink to 0 semantic
were indicated by
     the OPEN4_RESULT_PRESERVE_UNLINKED flag, a client could check for
     this flag and handle in appropriately.

rick

>
> > However if the "fail with NFS4ERR_STALE is supposed for happen after
> > REMOVE for same client" then that is not what I am seeing.
> > If you are curious, the packet trace is here. (Look at packet#58).
> > https://urldefense.com/v3/__https://people.freebsd.org/*rmacklem/linux-=
remove.pcap__;fg!!ACWV5N9M2RV99hQ!IEcffaAAeLhuzaJUO5rQOv0jUUk4ltuMpfqT83lLF=
kRL9cqOZEvZ-8GGjvoqlVAQKi_FAAhsKEl5NjvS0OLJ$
> >
> > Btw, in case you are curious why I am doing this testing, I am trying
> > to figure out a good way for the FreeBSD client to handle temporary
> > files. Typically on POSIX they are done via the syscalls:
> >
> > fd =3D open("foo", O_CREATE ...);
> > unlink("foo");
> > write(fd,..), write(fd,..)...
> > read(fd,...), read(fd,...)...
> > close(fd);
> >
> > If this happens quickly and is not too much writing, the writes
> > copy data into buffers/pages, the reads read the data out of
> > the pages and then it all gets deleted.
> >
> > Unfortunately, the CB_RECALL forces the NFSv4.n client
> > to do WRITE, WRITE,..COMMIT and then DELEGRETURN.
> > Then the REMOVE throws all the data away on the NFSv4.n
> > server.
> > --> As such, I really like not doing the CB_RECALL for "same client".
> > My concern is "what happens to the delegation after the file object ("f=
oo")
> > gets deleted?
> > It either needs to be thrown away by the NFSv4.n server or the
> > PUTFH, DELEGRETURN needs to work after the REMOVE.
>
> The PUTFH and DELEGRETURN continue to work after the REMOVE. The open
> stateid and delegation stateid on the server are destroyed only after
> the client sends the DELEGRETURN and CLOSE.
>
> > Otherwise, the NFSv4.n server may get constipated by the delegations,
> > which might be called stale, since the file object has been deleted.
> >
> > --> I can do PUTFH, GETATTR after REMOVE in the same compound,
> >       to find out if the file object has been deleted. But then, if a
> >       PUTFH, DELEGRETURN fails with NFS4ERR_STALE, can I get
> >       away with saying "the server should just discard the delegation a=
s
> >       the client already has done so??.
>
> You can try your test but I believe the PUTFH and GETATTR won't fail
> after the REMOVE.
>
> -Dai
>
> >
> > Thanks for your comments, rick
> >
> >> -Dai
> >>
> >>> (I don't think it is, but there is a discussion in 18.25.4 which says
> >>> "When the determination above cannot be made definitively because
> >>> delegations are being held, they MUST be recalled.." but everything
> >>> above that is a may/MAY, so it is not obvious to me if a server reall=
y
> >>> needs to case?)
> >>>
> >>> Any comments? Thanks, rick
> >>> ps: I am amazed when I learn these things about NFSv4.n after all
> >>>         these years.
> >>>

