Return-Path: <linux-nfs+bounces-8707-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E5F649FA2F9
	for <lists+linux-nfs@lfdr.de>; Sun, 22 Dec 2024 00:53:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D795E18832EA
	for <lists+linux-nfs@lfdr.de>; Sat, 21 Dec 2024 23:53:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD0D41CF8B;
	Sat, 21 Dec 2024 23:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dvnB3vbx"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEF52193403
	for <linux-nfs@vger.kernel.org>; Sat, 21 Dec 2024 23:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734825218; cv=none; b=tmEak40vv4awSZZY8nWpPcXVPibPrpKTOTSWo1Cy94nDGBs24GDU1V0HTvYfn57szw793SK7vcIzEH3NwyyOuFq4bJFxaYv5DduamtoAp/c8Tt5R3ufT1pxOhuqs6lyGgg0ZO3FivMjvEhC5l2Z4A3G2K5YuYG+31Xux9+IwJBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734825218; c=relaxed/simple;
	bh=JeqsjSCRzMdafQd2S7s9HxNMe7s4qMRxTK09RAAc5vw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PWyh14rh0WM4LBHqELIg3I7S2bsHGEaVlHSQcvOm/o8leH58e901M8oUZqcLsB8peWG71Al4WFLbp/dg1grrt2EqZdS5X3Mrrgg1z8Zl0fHNoVE2ms0mT+6qBticuT5Lm8VnjZG764orb7Rj1gytHm82c2QLPie25faZVR2aeRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dvnB3vbx; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5d41848901bso5804223a12.0
        for <linux-nfs@vger.kernel.org>; Sat, 21 Dec 2024 15:53:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734825215; x=1735430015; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=agNNNyAkVCK7+wxRb6HMg0rJIcRWmSDqVQeZ9Qk3x40=;
        b=dvnB3vbxEL2U0WbB7pjBH6etTqU7peZzPn1PB3kuZEkSdBboLYgi5VGi9uUi3C2tcK
         WDbfYWqdF8fMWcgOgmg2fg6GegIr6FaWC3MmnzQPNsB58LYIKEgtOldK87h5oGR//wI/
         5nkUxOm+iwUvyYhv2PZRc3+A651J61vZvHM2zplX73goZ+rk1NPi94tM68Qjo2rhuXt2
         UcBxfP43AN/VpA8c2EBmFQ6EoTpzM2/+mplErrPjalXdhn5qcj54TEFOYeN+Sl4Baa8D
         jxIroW+lM0qbO5jy4xh3e5aswb3kB1hYJ+iEcyKg25T4UG0Wr62dwZka5nH9Fr7jMbEt
         QzPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734825215; x=1735430015;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=agNNNyAkVCK7+wxRb6HMg0rJIcRWmSDqVQeZ9Qk3x40=;
        b=vVW0/cVKcco3+5llKNp1yYcYPOaKvdnCpNevP1+DKUvPDdwQE56yuB8FfRDNfuhr/M
         weSc81w3tqC1mwR1s0SW3urfMaym9mvm6DGLxTS7uyDoBbPKdv5+l+8dL9zLfzCs8kcr
         1ICm6l6u1h1vZbBxZXkqW5F/9Z3tw36xIQl8sYawnyzHxSmqOHprqdl/2YrfZ7IHCZ0N
         ZAzLh1CRGrYQ+LXIhR0Ak0LCddhiq05kaeZz4vsbzXvELMPdaBNXtHe91McTXKY+GEB9
         cZz6dL1BrvRy3YHQ405N/cafpU81RNyEjOZnimsLqxWQ/X4baEVVpCw5k+zrXmV8lo9E
         RFwA==
X-Forwarded-Encrypted: i=1; AJvYcCXIriOMwVx5C5B9NMcHX9eYhk0GHNHovNuBC983A54dAjINxk1nIPMqGZ2QCYnbeDwbFz5sxbhPRKY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxleFWM/mnoOIVOrKFFO+aveUqMeYboRW4lLciWaS3ZLldMdp7s
	Gy75UNBivhJ2mwyoKAPZHwt7ED6MnA4uMuRCntuGVIfcIcZgKhycW5Is8d3givNlgkj3FoJftuJ
	ggr70OVDMT5+3R3bti5kr2Ph85g==
X-Gm-Gg: ASbGncv+ec2twtFvQg+Jr39C/+dqgoZOQDIYfRFJDup/BxZLixsGk5ZnycmU4Z/CZVs
	7HT0J03uCtxaCjoIK+oCt6dG+Q7EGjTlqJ/VxSqC9p7nfrJpHf+HN6rB5eZupB1dM7DPj7g==
X-Google-Smtp-Source: AGHT+IHdTGrOhExf4si7vbglgL8a98eiP3xmKTm4l0dZuwADVtmP2BC5pFCrEWCNUs69iY+CegEHOYrZQIj4minm9os=
X-Received: by 2002:a05:6402:4315:b0:5d4:c0c:70f9 with SMTP id
 4fb4d7f45d1cf-5d80239616cmr11770652a12.6.1734825214759; Sat, 21 Dec 2024
 15:53:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAM5tNy4-SNVD+zqgaJTmLtAQ+kKV_Ce4tRr2zqgjTq1KPM-rfQ@mail.gmail.com>
 <4804ce6a-fa67-4b50-bc31-715689d3c766@oracle.com> <CABXB=RQn8qU5TZsWyBpWNaDQpaMPhdi4RYVJ0D1qJAWiFuBAHQ@mail.gmail.com>
 <e4853faf-0836-4595-952b-69f71150bede@oracle.com> <CAM5tNy6tR96WrCeoLEfoA5cGs0AP=mR3q1nmYrqbFTTQB=G=Yw@mail.gmail.com>
In-Reply-To: <CAM5tNy6tR96WrCeoLEfoA5cGs0AP=mR3q1nmYrqbFTTQB=G=Yw@mail.gmail.com>
From: Rick Macklem <rick.macklem@gmail.com>
Date: Sat, 21 Dec 2024 15:53:23 -0800
Message-ID: <CAM5tNy6dFBgAhkX_mBzXyRyb+WfukZT0egpt75XRgCYKHPsP3Q@mail.gmail.com>
Subject: Re: knfsd server bug when GETATTR follows READDIR
To: Chuck Lever <chuck.lever@oracle.com>
Cc: J David <j.david.lists@gmail.com>, 
	Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 21, 2024 at 3:27=E2=80=AFPM Rick Macklem <rick.macklem@gmail.co=
m> wrote:
>
> On Sat, Dec 21, 2024 at 9:34=E2=80=AFAM Chuck Lever <chuck.lever@oracle.c=
om> wrote:
> >
> > On 12/20/24 9:16 PM, J David wrote:
> > > Hello,
> > >
> > > On Tue, Dec 17, 2024 at 8:51=E2=80=AFPM Chuck Lever <chuck.lever@orac=
le.com> wrote:
> > >> If they can reproduce
> > >> this issue with an "in tree" file system contained in a recent upstr=
eam
> > >> Linux kernel, then we can take a look. (Or you and J. David can give=
 it
> > >> a try).
> > >
> > > Yes, I reproduced this behavior on ext4 with 6.11.5+bpo-amd64 from
> > > Debian backports on completely different hardware.
> > >
> > > Then I set up another NFS server on Arch (running kernel 6.12.4), and
> > > reproduced the issue there as well.
> > >
> > > Then, just to be sure, I went and found the instructions for building
> > > the Linux kernel from source, built and tested both 6.12.6 and
> > > 6.13-rc3 as downloaded directly from www.kernel.org, and the issue
> > > occurs with those as well.
> >
> > Reproducing on v6.13-rc with ext4 is all that was necessary, thank you!
> >
> >
> > > Additionally, I have tested every combination of FreeBSD, Linux and
> > > OpenIndiana as client and server to confirm that FreeBSD client with
> > > Linux server is the only case where this problem occurs.
> >
> > Interesting.
> >
> >
> > > Does this count as reproducing the issue with an "in tree" file syste=
m
> > > contained in a recent upstream Linux kernel? I'm asking sincerely; I'=
m
> > > so far out of my depth that I'm pretty sure there are sea monsters
> > > swimming around down there. So I can't rule out the possibility that
> > > I've done something wrong either in setup or testing.
> > >
> > > During the course of this, I've gotten the reproduction down to
> > > extracting a 2k tar file and then running "du" on the resulting
> > > directory from the client. Doesn't matter if the file is untarred on
> > > the FreeBSD client, the server, or another client. The tar file
> > > contains a directory with a handful of random Javascript files from
> > > Drupal. As far as I can tell, it has something to do with the number,
> > > size, or names of the files. The Drupal project has three separate
> > > directories all structured like this with the same filenames, but the
> > > file contents vary. The issue occurs with all of them.
> > >
> > > The Linux /etc/exports file is just:
> > >
> > > /data 192.168.201.0/24(rw,sync)
> > >
> > > (The production case also uses crossmnt and no_subtree_check, anonuid=
,
> > > and anongid, but I eliminated those one by one to make sure they
> > > weren't responsible.)
> > >
> > > The corresponding fstab entry on the FreeBSD 14.2-RELEASE client is:
> > >
> > > 192.168.201.200:/data /data nfs rw,tcp,nfsv4,minorversion=3D2 0 0
> >
> > Out of curiosity, do you see the problem recur with nfsv3 or the other
> > NFSv4 minor versions?
> >
> >
> > > One additional thing I noticed that really blew my mind is that I can
> > > shutdown both the client and the server, wait, power them back on, an=
d
> > > the issue is still there. So it's not something in RAM.  That prompte=
d
> > > me to try "touch x" in the directory to create a new 0-length file.
> > > The issue then goes away. Then I can "rm x" and the issue comes back.
> > > By contrast, I can write megabytes from /dev/random into one of the
> > > files without affecting anything; the issue stays the same.
> > >
> > > I then tried it with all empty files using the same filenames. The
> > > issue still occurred. Add or remove one file and the issue goes away.
> > > I then renamed one of the files to zz.js. Issue still occurs. Renamed
> > > it to zzz.js. Problem still occurs. Kept going until I got to
> > > zzzzzz.js and it worked.
> > >
> > > Finally, I got it to the point where running this in an empty mounted
> > > directory will create the issue:
> > >
> > > rm *.xx; for a in a b c d e f g h ; do for b in 1 2 3 4 5 6 7 ; do
> > > touch $a$b.xx ; done; done; for a in 1 2 3 4 5; do touch x$a-xx.xx;
> > > done; touch y0-xxxxxx.xx
> > >
> > > and this will not:
> > >
> > > rm *.xx; for a in a b c d e f g h ; do for b in 1 2 3 4 5 6 7 ; do
> > > touch $a$b.xx ; done; done; for a in 1 2 3 4 5; do touch x$a-xx.xx;
> > > done; touch y0-xxxxxxx.xx
> > >
> > > (The difference being one extra x in the last filename.)
> > >
> > > It works in the other direction as well. This causes the issue:
> > >
> > > rm *.xx; for a in a b c d e f g h ; do for b in 1 2 3 4 5 6 7 ; do
> > > touch $a$b.xx ; done; done; for a in 1 2 3 4 5; do touch x$a-xx.xx;
> > > done; touch y0-xxx.xx
> > >
> > > This does not:
> > >
> > > rm *.xx; for a in a b c d e f g h ; do for b in 1 2 3 4 5 6 7 ; do
> > > touch $a$b.xx ; done; done; for a in 1 2 3 4 5; do touch x$a-xx.xx;
> > > done; touch y0-xx.xx
> > >
> > > There's a four-character window involving the length of the filenames
> > > where 62 files in a directory causes this issue. There's a little mor=
e
> > > to it than that; it doesn't look like you can just create 61
> > > two-letter filenames and then one really long one and get the issue.
> > >
> > > So I haven't found the specifics yet, but perhaps due to pure chance
> > > this directory structure is exactly right to provoke an incredibly
> > > obscure edge case?
> >
> > Well it's likely that this is a problem with READDIR, so file content
> > is not going to be an issue. The file name lengths are the problem.
> >
> > Also, I'm wondering what the FreeBSD client's directory readdir
> > arguments are (how much does it request, what are the maximum limits it
> > negotiates, and so on). Rick?
> As you'll see in the packet trace:
> Sequence: cache this: No
> Putfh: directory fh
> Readdir:
>     cookie: 0
>     cookie_verf: 0
>     dircount: 8706
>     maxcount: 8706
>     attr: type, RDattr_error, fileid, mounted_on_fleid
> Getattr: same attributes as requested for a previous GETATTR, mainly
>               to keep the directory's attribute cache up to date.
>
> The session negotiates a max request/reply size of just over 1Mbyte and a
> maximum of something like 20 ops. (Can't recall, but definitely more than=
 4.)
>
> If you are wondering where the 8706 comes from, it was an estimate of how
> much would be needed to fill an 8K buffer with the XDR translated to UFS =
dirents
> by adding 512 to 8K.
>
> I have not yet had a chance to see if I can reproduce the problem with
> J. David's
> reproducer. I will try that soon, and if I can reproduce it, I will
> poke at it to try and
> figure out what is going on.
Just fyi, I have reproduced it. Once you use J. David's little shell script=
 to
create the files in the directory, the Readdir RPC gets the junk reply
to GETATTR
(the count of words for the attribute bitmap in the reply is 0 instead of 2=
).
You can unmount/remount it and still get the failure, assuming you do not
mess with the directory contents.

Good work finding the reproducer, J. David!

I will start to poke around to see if I can figure out what the knfsd serve=
r is
doing.

Chuck, I suspect any fairly recent FreeBSD client will be sufficient to
reproduce this, just in case you are inspired to cross over to the dark
side and install FreeBSD somewhere.

I'll post when I have more info, rick

>
> rick
>
> >
> > Since this isn't reproducible (yet) with a Linux client, let's try
> > another set of network captures, and you can send these to me
> > privately.
> >
> > Start the capture
> > Mount
> > Run one of the reproducers above
> > Unmount
> > Stop the capture
> >
> > I'd like to see one with v6.13-rc3 and ext4 that works as expected, and
> > one with the same configuration that fails.
> >
> > --
> > Chuck Lever

