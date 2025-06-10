Return-Path: <linux-nfs+bounces-12229-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AFC8AD2B21
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Jun 2025 03:06:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BF2A1890DDA
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Jun 2025 01:07:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EF2D1A238D;
	Tue, 10 Jun 2025 01:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T5alh+bP"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAC90191F98
	for <linux-nfs@vger.kernel.org>; Tue, 10 Jun 2025 01:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749517598; cv=none; b=mAb64WMJyiNiIZV/0jqbmlnAtNLsUXJ8Bku5IbX5jbCaDl+BHpqt5AgaYBTuRd9fDiV+Ry7lg1PNvXijEc4Ch+/QT2txR1X2306t71tRD5mB98UsnpUqq5/RA1KZCh/NnOg488QqvrzFNy48iCMy8gtDVq9poeSQcs9GxGBFzdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749517598; c=relaxed/simple;
	bh=tNZtOzDzeMbzH6a6gg1doUQc3BD3o8RAPvGV4XCf9zs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jCqLyPP0aM0YsneT6HXLbXXtgNxBu3rKoowzEALNZ1tY+g7+F7DjQW4MlK7ixS9cVeRlbF+8X9+5CkN2BCqEmWfMVsz5SH3V28bP+hJzudF0e53ByWMN4DhuXd/uBMCjpBYf9JJD1YPg/+ln8jX1211fwf3fNEa6YYlBJmDp9L4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T5alh+bP; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-adb2bb25105so781321366b.0
        for <linux-nfs@vger.kernel.org>; Mon, 09 Jun 2025 18:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749517593; x=1750122393; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jV8aSpy44KLHBurM528leAPVAEqT/uIw4Dgt7B00SlQ=;
        b=T5alh+bPTmE6uLT3a2KrtlyaKm8lU4X3mEWDl3W9eUTkE4DOvzJIJrkbGAYjeCgk0S
         g5neewNr0UNa7JUnOvb2ZiuZpkj37FlYYXvh7jyiFafim/Oz6uMzuDZA4DIODt4hncJY
         gu6Gc+WZw4W2Fxoo0TFi6bQPMHfDr5KEJ9fOIVTTc4E1PlC39YLYyrk4Y6/zVuK2K3jS
         KM0PmHlGE94kPegD8FifEUcInRVJWDpQnAXw0lcMys5fAfkM3Hle5jHFGerbpvpSiLT9
         beNXy8RhTp+Zc6IJgmDGZPyagrB9HOPff7LBGaR6DvXwxjO8PJ12DeOM/7Agn7z5hz5p
         bXuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749517593; x=1750122393;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jV8aSpy44KLHBurM528leAPVAEqT/uIw4Dgt7B00SlQ=;
        b=ddH2tARxJo8QocNdbalBfQZ9ofZSFw97RwPeX5Kbg90VoHud7YFG9V3fXjX0onpMd4
         D3JBtjqPJBpJVfoMTzTXCSfADPFF8FPfD5tehlMXWpTr9kbGMzPPYMNS+sJwUQuKjOiF
         vQxUuDhzGjqd0yuGIxY/ftRuSkNl9xVn18fpRg9FOEMXpdC4z7KJZKZ00iVrit5m+vWn
         Py4gKI3LS0ffQVwu0g6nQEzVudw7XLp2JM9k6iz5JL/IDcjovKFRTsxdbRRgk5UG/5P4
         qrcKxBOCQ7cNXmYPpAqE0Ty7aHA1GpfsoTSr1cPDTVzP0obEK5JXnD2OYCgsoBK93lpY
         s6Iw==
X-Forwarded-Encrypted: i=1; AJvYcCX4rSRf6OTS4lTn/0cPWlYjfDxZhwwuo3gV4L2RJdsxqBANZZsKcd+oTvOD55Bs7DFKHn2nVXMKNAY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyq8albpDeKR430K0hoN+woT3DsSDl0gQY+ZVZWUm83NLlsXW5v
	LXCSUynf12DNa77084wQVQdq/FESwDlbPP8y4uevE01eMtwyxkU26N8dVJdkRLN26SHTig5bevQ
	qDnT0JEPLFdMzLDXp9x15LTzr5XZepQ==
X-Gm-Gg: ASbGncuce7V6wtH78AaHFzPWkJuij84WGL3JW27RJHtY7dZOceI+lFFcmQjAm2e5hk8
	DKV9cJPrMyDzDUycX/jWeZJpVcJq4y3sCZn/1NWrSogFF5gXetFEi5QbCpIMUgI7Uu5OB/THLAV
	bZcS0BJ2o+q/5Q8j8Sg5F7xQKHzGQUaStqVfHuW3ufqMIC6MLceLuYw5QddWejcu2ygVNt23CE5
	g4=
X-Google-Smtp-Source: AGHT+IFUaGSvadm1ry7vFgKuEgDrgEhE+ctDBVmA37/tH0Xv4rzntIaaytJWsz+FFLvtlBmueRTva6VzIkpmYzz2kSo=
X-Received: by 2002:a17:906:dc8d:b0:adb:2a66:85bc with SMTP id
 a640c23a62f3a-ade1aab9e47mr1302642366b.34.1749517593249; Mon, 09 Jun 2025
 18:06:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAM5tNy7kfqToA8p4-=LOnhvZuk36vocy32U6kgT+561uOWR_iQ@mail.gmail.com>
 <f84bed7e-e96c-4a7e-95e6-2a28a574947c@oracle.com>
In-Reply-To: <f84bed7e-e96c-4a7e-95e6-2a28a574947c@oracle.com>
From: Rick Macklem <rick.macklem@gmail.com>
Date: Mon, 9 Jun 2025 18:06:21 -0700
X-Gm-Features: AX0GCFtriKcKlbOU1DekRdP3aI-0Z3u5HVRa8tTOLS1AHLtogntt4kH6WGLPdvY
Message-ID: <CAM5tNy5rBMrqfQ7S6fZNciWovkf8K9tc+cuV7q0MALocyzYV7A@mail.gmail.com>
Subject: Re: simple NFSv4.1/4.2 test of remove while holding a delegation
To: Dai Ngo <dai.ngo@oracle.com>
Cc: NFSv4 <nfsv4@ietf.org>, Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 9, 2025 at 5:17=E2=80=AFPM Dai Ngo <dai.ngo@oracle.com> wrote:
>
> On 6/9/25 4:35 PM, Rick Macklem wrote:
> > Hi,
> >
> > I hope you don't mind a cross-post, but I thought both groups
> > might find this interesting...
> >
> > I have been creating a compound RPC that does REMOVE and
> > then tries to determine if the file object has been removed and
> > I was surprised to see quite different results from the Linux knfsd
> > and Solaris 11.4 NFSv4.1/4.2 servers. I think both these servers
> > provide FH4_PERSISTENT file handles, although I suppose I
> > should check that?
> >
> > First, the test OPEN/CREATEs a regular file called "foo" (only one
> > hard link) and acquires a write delegation for it.
> > Then a compound does the following:
> > ...
> > REMOVE foo
> > PUTFH fh for foo
> > GETATTR
> >
> > For the Solaris 11.4 server, the server CB_RECALLs the
> > delegation and then replies NFS4ERR_STALE for the PUTFH above.
> > (The FreeBSD server currently does the same.)
> >
> > For a fairly recent Linux (6.12) knfsd, the above replies NFS_OK
> > with nlinks =3D=3D 0 in the GETATTR reply.
> >
> > Hmm. So I've looked in RFC8881 (I'm terrible at reading it so I
> > probably missed something) and I cannot find anything that states
> > either of the above behaviours is incorrect.
> > (NFS4ERR_STALE is listed as an error code for PUTFH, but the
> > description of PUTFH only says that it sets the CFH to the fh arg.
> > It does not say anything w.r.t. the fh arg. needing to be for a file
> > that still exists.) Neither of these servers sets
> > OPEN4_RESULT_PRESERVE_UNLINKED in the OPEN reply.
> >
> > So, it looks like "file object no longer exists" is indicated either
> > by a NFS4ERR_STALE reply to either PUTFH or GETATTR
> > OR
> > by a successful reply, but with nlinks =3D=3D 0 for the GETATTR reply.
> >
> > To be honest, I kinda like the Linux knfsd version, but I am wondering
> > if others think that both of these replies is correct?
> >
> > Also, is the CB_RECALL needed when the delegation is held by
> > the same client as the one doing the REMOVE?
>
> The Linux NFSD detects the delegation belongs to the same client that
> causes the conflict (due to REMOVE) and skips the CB_RECALL. This is
> an optimization based on the assumption that the client would handle
> the conflict locally.
And then what does the server do with the delegation?
- Does it just discard it, since the file object has been deleted?
OR
- Does it guarantee that a DELEGRETURN done after the REMOVE will
  still work (which seems to be the case for the 6.12 server I am using for
  testing).

>
> If the REMOVE was done by another client, the REMOVE will not complete
> until the delegation is returned. If the PUTFH comes after the REMOVE
> was completed, it'll  fail with NFS4ERR_STALE since the file, specified
> by the file handle, no longer exists.
Assuming the statement w.r.t. "fail with NFS4ERR_STALE" only applies to
"REMOVE done by another client" then that sounds fine.
However if the "fail with NFS4ERR_STALE is supposed for happen after
REMOVE for same client" then that is not what I am seeing.
If you are curious, the packet trace is here. (Look at packet#58).
https://people.freebsd.org/~rmacklem/linux-remove.pcap

Btw, in case you are curious why I am doing this testing, I am trying
to figure out a good way for the FreeBSD client to handle temporary
files. Typically on POSIX they are done via the syscalls:

fd =3D open("foo", O_CREATE ...);
unlink("foo");
write(fd,..), write(fd,..)...
read(fd,...), read(fd,...)...
close(fd);

If this happens quickly and is not too much writing, the writes
copy data into buffers/pages, the reads read the data out of
the pages and then it all gets deleted.

Unfortunately, the CB_RECALL forces the NFSv4.n client
to do WRITE, WRITE,..COMMIT and then DELEGRETURN.
Then the REMOVE throws all the data away on the NFSv4.n
server.
--> As such, I really like not doing the CB_RECALL for "same client".
My concern is "what happens to the delegation after the file object ("foo")
gets deleted?
It either needs to be thrown away by the NFSv4.n server or the
PUTFH, DELEGRETURN needs to work after the REMOVE.
Otherwise, the NFSv4.n server may get constipated by the delegations,
which might be called stale, since the file object has been deleted.

--> I can do PUTFH, GETATTR after REMOVE in the same compound,
     to find out if the file object has been deleted. But then, if a
     PUTFH, DELEGRETURN fails with NFS4ERR_STALE, can I get
     away with saying "the server should just discard the delegation as
     the client already has done so??.

Thanks for your comments, rick

>
> -Dai
>
> > (I don't think it is, but there is a discussion in 18.25.4 which says
> > "When the determination above cannot be made definitively because
> > delegations are being held, they MUST be recalled.." but everything
> > above that is a may/MAY, so it is not obvious to me if a server really
> > needs to case?)
> >
> > Any comments? Thanks, rick
> > ps: I am amazed when I learn these things about NFSv4.n after all
> >        these years.
> >

