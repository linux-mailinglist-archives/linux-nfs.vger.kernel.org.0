Return-Path: <linux-nfs+bounces-12267-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 16128AD3B89
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Jun 2025 16:45:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C72F31884686
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Jun 2025 14:45:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E4631C68F;
	Tue, 10 Jun 2025 14:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ddSsSeNk"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 414471A3154
	for <linux-nfs@vger.kernel.org>; Tue, 10 Jun 2025 14:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749566716; cv=none; b=g8Md1GsXPN24ShosXRM8ZBZrZfLXvHAghPnCp5sgkyDXOuYV/zIfE4H7n5kiFurXPw0IPy+3TP0JKPfK38dRL4Gk7CC3d/qX136ja5Js8tl9fluK5jebCfMiES3qcSK1hFmPdsXBbLvHPNcHCQC6rVGuX8ig88V4JmGJBiUfXiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749566716; c=relaxed/simple;
	bh=hjLw+krPCwrHc2vTZOkL8JYhk+2MCuTi3TSDPACe2Ak=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DFAwGjK2/QPhyMypAdlOAdcFaWEU33zcHW45VY6g5Eqx57Bj7wE8mUpYrW96wywQZAUVEisev7bkdVOSpCo/xWlXuVw9R0hC8W2or+LlmuLzNONe2slBs0WhqWaSV6ZntGvSvcaJPAb6kB+GLJBbLEg0JwnUREYaELwRCKZEB3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ddSsSeNk; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-606fdbd20afso10930265a12.1
        for <linux-nfs@vger.kernel.org>; Tue, 10 Jun 2025 07:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749566712; x=1750171512; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+PzXA3IGhM0sf+MdX2K+E8tiTTXwA8NXps9c6QhP4PI=;
        b=ddSsSeNktQ4VVTsTDy//i+W+cOINpQPg2R+Ygz8EXK10INBI3/NWhEi5CLhxOU/Y17
         fv74P4kIPB0HINEzmHyGif+sLjKkzE2UxH3AQSFKaWr1/b16LXQ1w90Ib6VRMY6dd1gE
         igrPYtyipitMSaSpT8KJaAW/0DHiIAaT+8uHVNZ6qho3nIMLo/S+3fMan5IfJckTg1px
         6Sc7srzxAlvzxjMkct2VXBTx00q2VtOjcGzr/wrOhp/gD/rHWlyIhpoizIJcNhA4l8+v
         KtlMmRlYTQNvc5Qm1bKb1SjlEEOgb6TWBe0aFMTuUPdP1GMYNy6YJM7cmrWzKfk7eZUI
         cspw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749566712; x=1750171512;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+PzXA3IGhM0sf+MdX2K+E8tiTTXwA8NXps9c6QhP4PI=;
        b=gbdcvNrzfX5BZB7Tb/fxF0QTr18yNAFF2S/XQXeFGjwwnqFgR1mGsNfxs+CvAmwPmZ
         X2R/gtqFI6RB1SWwRKA+ZfK7gKxAbaJ4WqbtyBS0a5UXBNv1GO+IWLFcbOEou946tZBi
         y2TL3+DL/w4dSsdQhw2hO840ujnlSNzrCN4meW+NzPg+d/blJd2qWZ14w+8sCd8vdVEJ
         /+rz9G7KbT8oDWxd7Bmp3UQHVeB9hhxU+B1kQsQKepqrenXKyJzP0cUAwTeAXwuCJSah
         h7GCWL4Qttr+misR7BJCXrGcqks9aPC4fFLmXbFcRlhW8Qp2lXKtHz+Id/JO1wej9Wee
         IoMg==
X-Forwarded-Encrypted: i=1; AJvYcCWORb7o4PQX5GAUxLWYpOANfwco7zMb/NlxbWqYW0+cx0Oh52seHEOfPmR7zd6vMH3S9OpVJX2UJEU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7GboXNIbRfsSatcohjMhxy+GSWqx0r0jKdzrxLrYGkUjjoTav
	PMtEIv3pHgrmn4h2jRGh0VjKYrFhJC6J8bmZpw8Go5fiv18Rush6NJJJI8sudHYj6jOVQjg36dt
	rEuce8mTq3zqR+dL9UP1DZjaNzT1HE3W7JJlSCg==
X-Gm-Gg: ASbGncvkYbv3PetkDF4+0ZI0Wuq+enQz8SEz7U7G95dLviz98eue6WJXZ1OunB5DuMq
	WV2fv606n+d5M8JK04y7hYLpbTh+Bez8lOfx7MPijBexxUPn9/Gge6fmmlw8YKZvvsrPYZjVD2D
	1JEQrCI1C23ArpL6c/fsubrCiecukWpBGWNd9UqBbASvGWNIeMRVvrrDVQKdvxAzflaRAnsS2zq
	PE=
X-Google-Smtp-Source: AGHT+IHePvx1S/OeyxjfugqebGcfo2Q1dwyOOt8UKu5ZDSBOst+lNJCMLZODuBIOdITRBwD81dM14Geq2Ur6xchLT6M=
X-Received: by 2002:a17:907:bb49:b0:adb:428f:f748 with SMTP id
 a640c23a62f3a-ade1aa06c95mr1426363666b.21.1749566712207; Tue, 10 Jun 2025
 07:45:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAM5tNy7kfqToA8p4-=LOnhvZuk36vocy32U6kgT+561uOWR_iQ@mail.gmail.com>
 <f84bed7e-e96c-4a7e-95e6-2a28a574947c@oracle.com> <CAM5tNy5rBMrqfQ7S6fZNciWovkf8K9tc+cuV7q0MALocyzYV7A@mail.gmail.com>
 <3c60168c-630e-4253-a9c2-e88a3ed21696@oracle.com> <CAM5tNy5wssyrntPHQNreU3Au0aYUBRMUuTR0ixtcng5YmFq3iA@mail.gmail.com>
 <42531e1a-850c-4d6a-aa8c-95910fde3190@oracle.com>
In-Reply-To: <42531e1a-850c-4d6a-aa8c-95910fde3190@oracle.com>
From: Rick Macklem <rick.macklem@gmail.com>
Date: Tue, 10 Jun 2025 07:44:57 -0700
X-Gm-Features: AX0GCFsPLg-uxcuMYEXAPEfIyFfmNCgPSLO9ByvvJM_vFd5aubIY_-Nz0uUUgSY
Message-ID: <CAM5tNy7uBmmFb2nUFuUgtZO12jbZ56ZU+3ZtwNWMwjzCgTZc-A@mail.gmail.com>
Subject: Re: simple NFSv4.1/4.2 test of remove while holding a delegation
To: Dai Ngo <dai.ngo@oracle.com>
Cc: NFSv4 <nfsv4@ietf.org>, Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 10, 2025 at 6:28=E2=80=AFAM Dai Ngo <dai.ngo@oracle.com> wrote:
>
>
> On 6/10/25 6:16 AM, Rick Macklem wrote:
>
> On Tue, Jun 10, 2025 at 4:58=E2=80=AFAM Dai Ngo <dai.ngo@oracle.com> wrot=
e:
>
> On 6/9/25 6:06 PM, Rick Macklem wrote:
>
> On Mon, Jun 9, 2025 at 5:17=E2=80=AFPM Dai Ngo <dai.ngo@oracle.com> wrote=
:
>
> On 6/9/25 4:35 PM, Rick Macklem wrote:
>
> Hi,
>
> I hope you don't mind a cross-post, but I thought both groups
> might find this interesting...
>
> I have been creating a compound RPC that does REMOVE and
> then tries to determine if the file object has been removed and
> I was surprised to see quite different results from the Linux knfsd
> and Solaris 11.4 NFSv4.1/4.2 servers. I think both these servers
> provide FH4_PERSISTENT file handles, although I suppose I
> should check that?
>
> First, the test OPEN/CREATEs a regular file called "foo" (only one
> hard link) and acquires a write delegation for it.
> Then a compound does the following:
> ...
> REMOVE foo
> PUTFH fh for foo
> GETATTR
>
> For the Solaris 11.4 server, the server CB_RECALLs the
> delegation and then replies NFS4ERR_STALE for the PUTFH above.
> (The FreeBSD server currently does the same.)
>
> For a fairly recent Linux (6.12) knfsd, the above replies NFS_OK
> with nlinks =3D=3D 0 in the GETATTR reply.
>
> Hmm. So I've looked in RFC8881 (I'm terrible at reading it so I
> probably missed something) and I cannot find anything that states
> either of the above behaviours is incorrect.
> (NFS4ERR_STALE is listed as an error code for PUTFH, but the
> description of PUTFH only says that it sets the CFH to the fh arg.
> It does not say anything w.r.t. the fh arg. needing to be for a file
> that still exists.) Neither of these servers sets
> OPEN4_RESULT_PRESERVE_UNLINKED in the OPEN reply.
>
> So, it looks like "file object no longer exists" is indicated either
> by a NFS4ERR_STALE reply to either PUTFH or GETATTR
> OR
> by a successful reply, but with nlinks =3D=3D 0 for the GETATTR reply.
The nlink =3D=3D 0 case does not work, since another client can do a LINK.
It does imply that the WRITE, WRITE,...COMMIT, DELEGRET can
be done asynchronously from the unlink(2) or close(2) that is causing
the REMOVE.

>
> To be honest, I kinda like the Linux knfsd version, but I am wondering
> if others think that both of these replies is correct?
>
> Also, is the CB_RECALL needed when the delegation is held by
> the same client as the one doing the REMOVE?
>
> The Linux NFSD detects the delegation belongs to the same client that
> causes the conflict (due to REMOVE) and skips the CB_RECALL. This is
> an optimization based on the assumption that the client would handle
> the conflict locally.
>
> And then what does the server do with the delegation?
> - Does it just discard it, since the file object has been deleted?
> OR
> - Does it guarantee that a DELEGRETURN done after the REMOVE will
>    still work (which seems to be the case for the 6.12 server I am using =
for
>    testing).
>
> The delegation remains valid but the file was removed from the namespace.
> This is why the PUTFH and GETATTR in your test did not fail. However, any
> lookup of the file will fail.
>
> If the REMOVE was done by another client, the REMOVE will not complete
> until the delegation is returned. If the PUTFH comes after the REMOVE
> was completed, it'll  fail with NFS4ERR_STALE since the file, specified
> by the file handle, no longer exists.
>
> Assuming the statement w.r.t. "fail with NFS4ERR_STALE" only applies to
> "REMOVE done by another client" then that sounds fine.
>
> Correction: even if the REMOVE was done by the another client and the
> delegation was recalled from the 1st client, the open stateid of the file
> remains valid until the client sends the CLOSE. So the PUTFH won't fail
> regardless which client sends the REMOVE.
>
> So, should your server be setting OPEN4_RESULT_PRESERVE_UNLINKED
> in OPEN replies, given this semantic?
> --> If the FH remains valid after REMOVE drops nlink to 0 semantic
> were indicated by
>      the OPEN4_RESULT_PRESERVE_UNLINKED flag, a client could check for
>      this flag and handle in appropriately.
>
> I believe the Linux NFSD currently does not support OPEN4_RESULT_PRESERVE=
_UNLINKED.
Yes, if the server will throw away the file object when it reboots, you
cannot set this flag.

Thanks for all your comments, rick

>
> -Dai
>
> rick
>
> However if the "fail with NFS4ERR_STALE is supposed for happen after
> REMOVE for same client" then that is not what I am seeing.
> If you are curious, the packet trace is here. (Look at packet#58).
> https://urldefense.com/v3/__https://people.freebsd.org/*rmacklem/linux-re=
move.pcap__;fg!!ACWV5N9M2RV99hQ!IEcffaAAeLhuzaJUO5rQOv0jUUk4ltuMpfqT83lLFkR=
L9cqOZEvZ-8GGjvoqlVAQKi_FAAhsKEl5NjvS0OLJ$
>
> Btw, in case you are curious why I am doing this testing, I am trying
> to figure out a good way for the FreeBSD client to handle temporary
> files. Typically on POSIX they are done via the syscalls:
>
> fd =3D open("foo", O_CREATE ...);
> unlink("foo");
> write(fd,..), write(fd,..)...
> read(fd,...), read(fd,...)...
> close(fd);
>
> If this happens quickly and is not too much writing, the writes
> copy data into buffers/pages, the reads read the data out of
> the pages and then it all gets deleted.
>
> Unfortunately, the CB_RECALL forces the NFSv4.n client
> to do WRITE, WRITE,..COMMIT and then DELEGRETURN.
> Then the REMOVE throws all the data away on the NFSv4.n
> server.
> --> As such, I really like not doing the CB_RECALL for "same client".
> My concern is "what happens to the delegation after the file object ("foo=
")
> gets deleted?
> It either needs to be thrown away by the NFSv4.n server or the
> PUTFH, DELEGRETURN needs to work after the REMOVE.
>
> The PUTFH and DELEGRETURN continue to work after the REMOVE. The open
> stateid and delegation stateid on the server are destroyed only after
> the client sends the DELEGRETURN and CLOSE.
>
> Otherwise, the NFSv4.n server may get constipated by the delegations,
> which might be called stale, since the file object has been deleted.
>
> --> I can do PUTFH, GETATTR after REMOVE in the same compound,
>       to find out if the file object has been deleted. But then, if a
>       PUTFH, DELEGRETURN fails with NFS4ERR_STALE, can I get
>       away with saying "the server should just discard the delegation as
>       the client already has done so??.
>
> You can try your test but I believe the PUTFH and GETATTR won't fail
> after the REMOVE.
>
> -Dai
>
> Thanks for your comments, rick
>
> -Dai
>
> (I don't think it is, but there is a discussion in 18.25.4 which says
> "When the determination above cannot be made definitively because
> delegations are being held, they MUST be recalled.." but everything
> above that is a may/MAY, so it is not obvious to me if a server really
> needs to case?)
>
> Any comments? Thanks, rick
> ps: I am amazed when I learn these things about NFSv4.n after all
>         these years.
>

