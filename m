Return-Path: <linux-nfs+bounces-12314-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B341AD5942
	for <lists+linux-nfs@lfdr.de>; Wed, 11 Jun 2025 16:51:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 292DC189A7D3
	for <lists+linux-nfs@lfdr.de>; Wed, 11 Jun 2025 14:51:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E1632BB04;
	Wed, 11 Jun 2025 14:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AVtccQVI"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D79D21C19C
	for <linux-nfs@vger.kernel.org>; Wed, 11 Jun 2025 14:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749653481; cv=none; b=Po8O2JhNoN2scY9XqbtcPii50YHD1fGdoPsqxld3RXZj2Zi5OeA/s7oCVZhN/Pem+w3y0m46RiM6xUkIlp1Z0eAmsedIoKlYyKLo9FTtIOR2pG+7GVLuJBBWNSoBh1d5ke0HNoHPeRhRWh5ekAwvwVFT5j5O+yZRr/8KkqKIfTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749653481; c=relaxed/simple;
	bh=4l9SMb4iq1c3GWDDDf2UCPm2zYyFIdsBrk4vMcdhJiQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XmiJsVTUITuRUr2mff8+1V0mzLlv2cwQuA/O0t680LPSmnXk+dr169LFKiWeh+liiSUTzFcAYL6lg6EWaQO9K/HqFQvs6JJOirUdS6p0GSFahElRpz2MDAKFmfjGkCjZZ2OUdy4izZYhdzB15i9iBXWcRuvOUtZhMqko/xrJIHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AVtccQVI; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-60727e46168so11620589a12.0
        for <linux-nfs@vger.kernel.org>; Wed, 11 Jun 2025 07:51:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749653478; x=1750258278; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zywT1Fxgoesra6/lpIFyTZffNH5zECHlC5INg6AWQ8k=;
        b=AVtccQVIv16aG1Cli6t+b3xcOWVMiZxJAHdShTF7uCm8q2ucam76lX3aA1oIwZ/TFD
         ggl9zm4MZopaBDuEnWyxzNk8zx+axUEEEiIf72fHDTjT3GAdA9RsMxHutfQ01llDHki/
         PmNS9AFnf/PEqtxY114AQvgEckFGNkqcyv5zkWY/PXq4yZXT/7/Iuoez6LwLs/lECNgb
         QC8F6S14F+wPRGsa9h/lymXi3pqnXX8izP9CMOQ7HuXchzRAX35zrJKkBYwXKzUBVJ/6
         5S8rM5vF0o2LGaHJiPjD0bHwcZWv/fA/vKinTjhrIlxSf1s5MpqSZEMy9oAjpXK93cju
         xdxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749653478; x=1750258278;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zywT1Fxgoesra6/lpIFyTZffNH5zECHlC5INg6AWQ8k=;
        b=KxCaOO0rqvojEu4YZ5hgfmyN1TS5wkO/l3TgtN+1yAjX6TD5H0uI+XCL1vrD2rcbOf
         ZdI0N9h5bEpUwgWMsxhjYwqpwLaJu3rzt16nvUkdKVgharRU9YmeEMFmPq+4P38AlAja
         JYNHWIZK+lEdCPh2wkyChVB0JQJSMPcIO3SV7RYJh9MQf/z5h7QxreRrWXySysprL9s/
         fSjS2REHMb5O92TNZqsyXBdSvTpl8NR6yyWG/ZJS4SJ7jlVkrPDVIBMQJlU4v4bwNJsY
         1plLaWVZ2RlMygkXddhPp7MPhtq8pXM+S6I34yjNjMKPVsRe65pE7eKj18uRbhg63ij0
         S4rg==
X-Gm-Message-State: AOJu0YzTOsK1SQ/NyEPfAzZhJCKz6J8eSOrPFkTFbH3DplO+4uLDiS3/
	pis+bM49mK8nFHOE+RSq/dYfgTpUmLBv03g7aMUDEHZgWyPAVoJsp0n1j777jsedWMcEi2PCYKU
	ztkRzXrJsLIw5g0oZbjn2uaPWtn0ZRuaTnMZdUg==
X-Gm-Gg: ASbGncvXZScx+4JwzEHbnW2CevY2TBGQjuzXBRUcicTzoVSohvhT+GWbCkYeJKz8cji
	7RfdoGXKiVKevbpOtlpeURMmxmuPIoBypEQN2CNZD/cmDm2S7B5NE6XdGBkdsOUYcGlbpmyZXnn
	odscujatf/vkXT6ouxpW/YsVCces3obx37cIWGJDoPHKLPNpE7inBFXCJwN/s5EFoBx0esySEc0
	KA=
X-Google-Smtp-Source: AGHT+IG66qQTctsDsukqHQAjhzRhqJdjAy84MBH5oPndeBFIpymce+GZ0lWInLfpLlSHWiR8dpWw1UwGeowe6dluE3k=
X-Received: by 2002:a05:6402:27cd:b0:604:5a87:d6c with SMTP id
 4fb4d7f45d1cf-60863820f15mr130287a12.7.1749653477292; Wed, 11 Jun 2025
 07:51:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAM5tNy7kfqToA8p4-=LOnhvZuk36vocy32U6kgT+561uOWR_iQ@mail.gmail.com>
 <f84bed7e-e96c-4a7e-95e6-2a28a574947c@oracle.com> <CAM5tNy5rBMrqfQ7S6fZNciWovkf8K9tc+cuV7q0MALocyzYV7A@mail.gmail.com>
 <3c60168c-630e-4253-a9c2-e88a3ed21696@oracle.com> <CAM5tNy5wssyrntPHQNreU3Au0aYUBRMUuTR0ixtcng5YmFq3iA@mail.gmail.com>
 <42531e1a-850c-4d6a-aa8c-95910fde3190@oracle.com> <03d846e0-cbf5-4393-b1d7-6117964aebc3@oracle.com>
In-Reply-To: <03d846e0-cbf5-4393-b1d7-6117964aebc3@oracle.com>
From: Rick Macklem <rick.macklem@gmail.com>
Date: Wed, 11 Jun 2025 07:51:05 -0700
X-Gm-Features: AX0GCFscFywgIeg8oeUWJk4Jpsm9T4kk2fvhomGNY3xSh_IJtHcRNvp1qn2v1Ws
Message-ID: <CAM5tNy7uWHBHV9mtN2NvQU-WkV-Ed+nBJZH_3aq-O-u_VLbLmw@mail.gmail.com>
Subject: Re: [nfsv4] Re: simple NFSv4.1/4.2 test of remove while holding a delegation
To: Dai Ngo <dai.ngo=40oracle.com@dmarc.ietf.org>
Cc: Linux NFS Mailing List <linux-nfs@vger.kernel.org>, NFSv4 <nfsv4@ietf.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 10, 2025 at 6:38=E2=80=AFAM Dai Ngo
<dai.ngo=3D40oracle.com@dmarc.ietf.org> wrote:
>
>
> On 6/10/25 6:28 AM, Dai Ngo wrote:
> >
> >
> > On 6/10/25 6:16 AM, Rick Macklem wrote:
> >> On Tue, Jun 10, 2025 at 4:58=E2=80=AFAM Dai Ngo<dai.ngo@oracle.com> wr=
ote:
> >>> On 6/9/25 6:06 PM, Rick Macklem wrote:
> >>>> On Mon, Jun 9, 2025 at 5:17=E2=80=AFPM Dai Ngo<dai.ngo@oracle.com> w=
rote:
> >>>>> On 6/9/25 4:35 PM, Rick Macklem wrote:
> >>>>>> Hi,
> >>>>>>
> >>>>>> I hope you don't mind a cross-post, but I thought both groups
> >>>>>> might find this interesting...
> >>>>>>
> >>>>>> I have been creating a compound RPC that does REMOVE and
> >>>>>> then tries to determine if the file object has been removed and
> >>>>>> I was surprised to see quite different results from the Linux knfs=
d
> >>>>>> and Solaris 11.4 NFSv4.1/4.2 servers. I think both these servers
> >>>>>> provide FH4_PERSISTENT file handles, although I suppose I
> >>>>>> should check that?
> >>>>>>
> >>>>>> First, the test OPEN/CREATEs a regular file called "foo" (only one
> >>>>>> hard link) and acquires a write delegation for it.
> >>>>>> Then a compound does the following:
> >>>>>> ...
> >>>>>> REMOVE foo
> >>>>>> PUTFH fh for foo
> >>>>>> GETATTR
> >>>>>>
> >>>>>> For the Solaris 11.4 server, the server CB_RECALLs the
> >>>>>> delegation and then replies NFS4ERR_STALE for the PUTFH above.
> >>>>>> (The FreeBSD server currently does the same.)
> >>>>>>
> >>>>>> For a fairly recent Linux (6.12) knfsd, the above replies NFS_OK
> >>>>>> with nlinks =3D=3D 0 in the GETATTR reply.
> >>>>>>
> >>>>>> Hmm. So I've looked in RFC8881 (I'm terrible at reading it so I
> >>>>>> probably missed something) and I cannot find anything that states
> >>>>>> either of the above behaviours is incorrect.
> >>>>>> (NFS4ERR_STALE is listed as an error code for PUTFH, but the
> >>>>>> description of PUTFH only says that it sets the CFH to the fh arg.
> >>>>>> It does not say anything w.r.t. the fh arg. needing to be for a fi=
le
> >>>>>> that still exists.) Neither of these servers sets
> >>>>>> OPEN4_RESULT_PRESERVE_UNLINKED in the OPEN reply.
> >>>>>>
> >>>>>> So, it looks like "file object no longer exists" is indicated eith=
er
> >>>>>> by a NFS4ERR_STALE reply to either PUTFH or GETATTR
> >>>>>> OR
> >>>>>> by a successful reply, but with nlinks =3D=3D 0 for the GETATTR re=
ply.
> >>>>>>
> >>>>>> To be honest, I kinda like the Linux knfsd version, but I am wonde=
ring
> >>>>>> if others think that both of these replies is correct?
> >>>>>>
> >>>>>> Also, is the CB_RECALL needed when the delegation is held by
> >>>>>> the same client as the one doing the REMOVE?
> >>>>> The Linux NFSD detects the delegation belongs to the same client th=
at
> >>>>> causes the conflict (due to REMOVE) and skips the CB_RECALL. This i=
s
> >>>>> an optimization based on the assumption that the client would handl=
e
> >>>>> the conflict locally.
> >>>> And then what does the server do with the delegation?
> >>>> - Does it just discard it, since the file object has been deleted?
> >>>> OR
> >>>> - Does it guarantee that a DELEGRETURN done after the REMOVE will
> >>>>     still work (which seems to be the case for the 6.12 server I am =
using for
> >>>>     testing).
> >>> The delegation remains valid but the file was removed from the namesp=
ace.
> >>> This is why the PUTFH and GETATTR in your test did not fail. However,=
 any
> >>> lookup of the file will fail.
> >>>
> >>>>> If the REMOVE was done by another client, the REMOVE will not compl=
ete
> >>>>> until the delegation is returned. If the PUTFH comes after the REMO=
VE
> >>>>> was completed, it'll  fail with NFS4ERR_STALE since the file, speci=
fied
> >>>>> by the file handle, no longer exists.
> >>>> Assuming the statement w.r.t. "fail with NFS4ERR_STALE" only applies=
 to
> >>>> "REMOVE done by another client" then that sounds fine.
> >>> Correction: even if the REMOVE was done by the another client and the
> >>> delegation was recalled from the 1st client, the open stateid of the =
file
> >>> remains valid until the client sends the CLOSE. So the PUTFH won't fa=
il
> >>> regardless which client sends the REMOVE.
> >> So, should your server be setting OPEN4_RESULT_PRESERVE_UNLINKED
> >> in OPEN replies, given this semantic?
> >> --> If the FH remains valid after REMOVE drops nlink to 0 semantic
> >> were indicated by
> >>       the OPEN4_RESULT_PRESERVE_UNLINKED flag, a client could check fo=
r
> >>       this flag and handle in appropriately.
> > I believe the Linux NFSD currently does not support OPEN4_RESULT_PRESER=
VE_UNLINKED.
>
> The Linux NFSD does not guarantee that opened-but-deleted files were
> kept over reboots.
One final note...
Given the above, I suspect that the PUTFH, GETATTR after the REMOVE could
get a NFS4ERR_STALE if a server reboot were to happen right after the
REMOVE.

Thanks for all the comments, rick

>
> -Dai
>
> >
> > -Dai
> >> rick
> >>
> >>>> However if the "fail with NFS4ERR_STALE is supposed for happen after
> >>>> REMOVE for same client" then that is not what I am seeing.
> >>>> If you are curious, the packet trace is here. (Look at packet#58).
> >>>> https://urldefense.com/v3/__https://people.freebsd.org/*rmacklem/lin=
ux-remove.pcap__;fg!!ACWV5N9M2RV99hQ!IEcffaAAeLhuzaJUO5rQOv0jUUk4ltuMpfqT83=
lLFkRL9cqOZEvZ-8GGjvoqlVAQKi_FAAhsKEl5NjvS0OLJ$
> >>>>
> >>>> Btw, in case you are curious why I am doing this testing, I am tryin=
g
> >>>> to figure out a good way for the FreeBSD client to handle temporary
> >>>> files. Typically on POSIX they are done via the syscalls:
> >>>>
> >>>> fd =3D open("foo", O_CREATE ...);
> >>>> unlink("foo");
> >>>> write(fd,..), write(fd,..)...
> >>>> read(fd,...), read(fd,...)...
> >>>> close(fd);
> >>>>
> >>>> If this happens quickly and is not too much writing, the writes
> >>>> copy data into buffers/pages, the reads read the data out of
> >>>> the pages and then it all gets deleted.
> >>>>
> >>>> Unfortunately, the CB_RECALL forces the NFSv4.n client
> >>>> to do WRITE, WRITE,..COMMIT and then DELEGRETURN.
> >>>> Then the REMOVE throws all the data away on the NFSv4.n
> >>>> server.
> >>>> --> As such, I really like not doing the CB_RECALL for "same client"=
.
> >>>> My concern is "what happens to the delegation after the file object =
("foo")
> >>>> gets deleted?
> >>>> It either needs to be thrown away by the NFSv4.n server or the
> >>>> PUTFH, DELEGRETURN needs to work after the REMOVE.
> >>> The PUTFH and DELEGRETURN continue to work after the REMOVE. The open
> >>> stateid and delegation stateid on the server are destroyed only after
> >>> the client sends the DELEGRETURN and CLOSE.
> >>>
> >>>> Otherwise, the NFSv4.n server may get constipated by the delegations=
,
> >>>> which might be called stale, since the file object has been deleted.
> >>>>
> >>>> --> I can do PUTFH, GETATTR after REMOVE in the same compound,
> >>>>        to find out if the file object has been deleted. But then, if=
 a
> >>>>        PUTFH, DELEGRETURN fails with NFS4ERR_STALE, can I get
> >>>>        away with saying "the server should just discard the delegati=
on as
> >>>>        the client already has done so??.
> >>> You can try your test but I believe the PUTFH and GETATTR won't fail
> >>> after the REMOVE.
> >>>
> >>> -Dai
> >>>
> >>>> Thanks for your comments, rick
> >>>>
> >>>>> -Dai
> >>>>>
> >>>>>> (I don't think it is, but there is a discussion in 18.25.4 which s=
ays
> >>>>>> "When the determination above cannot be made definitively because
> >>>>>> delegations are being held, they MUST be recalled.." but everythin=
g
> >>>>>> above that is a may/MAY, so it is not obvious to me if a server re=
ally
> >>>>>> needs to case?)
> >>>>>>
> >>>>>> Any comments? Thanks, rick
> >>>>>> ps: I am amazed when I learn these things about NFSv4.n after all
> >>>>>>          these years.
> >>>>>>
> >
> > _______________________________________________
> > nfsv4 mailing list -- nfsv4@ietf.org
> > To unsubscribe send an email to nfsv4-leave@ietf.org
>
> _______________________________________________
> nfsv4 mailing list -- nfsv4@ietf.org
> To unsubscribe send an email to nfsv4-leave@ietf.org

