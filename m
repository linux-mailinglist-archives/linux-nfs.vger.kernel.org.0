Return-Path: <linux-nfs+bounces-8708-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CF849FA31D
	for <lists+linux-nfs@lfdr.de>; Sun, 22 Dec 2024 01:30:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3C6C188B1CB
	for <lists+linux-nfs@lfdr.de>; Sun, 22 Dec 2024 00:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13A9D8462;
	Sun, 22 Dec 2024 00:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dW76rvZy"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D589A17C79
	for <linux-nfs@vger.kernel.org>; Sun, 22 Dec 2024 00:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734827414; cv=none; b=qRR4zIelsJp98NUdSmGVz9d9x2aW+tVDKPz3QsovCQzQmgwNcyGz7DVWf5STwoCePcIFBM3gnSUbyFBFw++wSoig60KsdCl1GxJpqj8lIqkkYHJOVQYnoC8YODSWP32Gn1vhgbvVWqxGGkH+n9LsJWMWsj2dzN2cr5jOOeErRqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734827414; c=relaxed/simple;
	bh=uTXZC83jjjupSMopFL5GhrqM79hC0l4qQ3uX1VwVEOs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UUaUORiw3FUh5hp/S3KY2C9auW0b1XV64FR99ZUfxS8cD5vCCYtA+nraNuXXbFdjNDKYD55w8EbAnTljO/foH1algpFWBFBOmUYPXmbHyXLYmAuW87NHSOybBWUg0bbFdJsnvVdWya+LJpryCgA+qxKb//3BKpxfo0ocY5JP9aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dW76rvZy; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5ceb03aadb1so4226908a12.0
        for <linux-nfs@vger.kernel.org>; Sat, 21 Dec 2024 16:30:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734827410; x=1735432210; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ByKexfCUTBtnVP5ig487Z0snorzy5gAVBCQvHY//VUA=;
        b=dW76rvZyUmOAWVr+Ammk5quQxyEO2wGN8TdeLVUCq2fq18CNOvSzz5Gzjgz19tfoX4
         pCGwHroazuib9XH0vbPJzjwBEudAud0SgvyTutPXQy56ehtPRQe4GYs+XhonWUnHVDy4
         lpSp8jtdjCuba6fHBPcrMFeRChd9WJ0/PfMSIwNkkZqlR70fLpu/Z8vZ1oD3UTph0zWJ
         WIZ03d/4o68/Qobhl5X/fBFGyYyDiWvMu5GiMMqOTOvp8VNjNwdnO2D07aAaEJf7vtnP
         ZW3kPpmmVw6FMXwvL34wfLjX50+yTKRivHcoM4uKBClGY8cP3nQJ7W6QFuLLlj0BsRWW
         azXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734827410; x=1735432210;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ByKexfCUTBtnVP5ig487Z0snorzy5gAVBCQvHY//VUA=;
        b=ILY0pP33CtzuJ11GjRKJCB0qSK0gpfMVxwI6GK1R1YJm1hvpExwo+HySKAjzzQ6jrL
         4yw/0N3uecIq+Yge2/Qz/az2KZcUcKC0wYopn/pB7S/WQzwceT5osI0dTK2caIh1D0n2
         yBVbIPMfmRPKwNgjyx0JpwZ8/gwYmRrA/6PyMAJ53ZzEuTCkSlCwjI6yKf+ihWREup8E
         XhUWZeBt69hNR0JBjW5QSruHC4SMZ5Z0NJd0VfvRa8x5CjI6VgfBA2AcvREeGKeEXl7d
         1zFV/Y2Z1jb8zy4zv4sMqLbmiz/K3n2aLPrLhmWr6jRcBIPD9ydvhH0cViBK4qlf4Xbt
         NsZQ==
X-Forwarded-Encrypted: i=1; AJvYcCVlIWmDGtRLHQVf3aDXG/ubvO+r5Lsd43qCyoM2xNXusuOd6z91fzXbETFX9deMnOf+tsT9xtSwXE0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyV95cZI5WdwRYT+bhd0vYjK8mrDOOJEshCyGiGWNFzQVWmE+mG
	oTom/eYCdtDmzpqQO8T8sd5UdDGk1e1LvGWrN5TugJmbexAb8vkBq5O01Ll9LfziiZwKFRE0zV6
	iaj4d6vQtIfa1U4DqeukxZdjhZA==
X-Gm-Gg: ASbGncsLu3r7o0LtoYhuMmjMc7N2NooBDqAiqhPwZp0+gvxO7a2sDjyh7tG42rpFIH1
	GBAM/NDzzsbIa76WjCEM8VtCjqc753MEy1aM/mI7CWjpgEKnhRqHq7EzKgukOx/N43/kK0Q==
X-Google-Smtp-Source: AGHT+IFfhd/MVR+82I2SdqUT0OGvX0mImZleNApbMavZ4sm42n59hnKqVOi5pQI4tHrSsMlPMJMKGbJ4yrLY88MCV6E=
X-Received: by 2002:a05:6402:3482:b0:5d0:b879:fa36 with SMTP id
 4fb4d7f45d1cf-5d81dd63c57mr6825998a12.7.1734827409920; Sat, 21 Dec 2024
 16:30:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAM5tNy4-SNVD+zqgaJTmLtAQ+kKV_Ce4tRr2zqgjTq1KPM-rfQ@mail.gmail.com>
 <4804ce6a-fa67-4b50-bc31-715689d3c766@oracle.com> <CABXB=RQn8qU5TZsWyBpWNaDQpaMPhdi4RYVJ0D1qJAWiFuBAHQ@mail.gmail.com>
 <e4853faf-0836-4595-952b-69f71150bede@oracle.com> <CAM5tNy6tR96WrCeoLEfoA5cGs0AP=mR3q1nmYrqbFTTQB=G=Yw@mail.gmail.com>
 <CAM5tNy6dFBgAhkX_mBzXyRyb+WfukZT0egpt75XRgCYKHPsP3Q@mail.gmail.com>
In-Reply-To: <CAM5tNy6dFBgAhkX_mBzXyRyb+WfukZT0egpt75XRgCYKHPsP3Q@mail.gmail.com>
From: Rick Macklem <rick.macklem@gmail.com>
Date: Sat, 21 Dec 2024 16:29:59 -0800
Message-ID: <CAM5tNy4yozhOhThFfSELN3Xc8KWbSaaqqfuvV4_6wZXozxNY8w@mail.gmail.com>
Subject: Re: knfsd server bug when GETATTR follows READDIR
To: Chuck Lever <chuck.lever@oracle.com>
Cc: J David <j.david.lists@gmail.com>, 
	Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 21, 2024 at 3:53=E2=80=AFPM Rick Macklem <rick.macklem@gmail.co=
m> wrote:
>
> On Sat, Dec 21, 2024 at 3:27=E2=80=AFPM Rick Macklem <rick.macklem@gmail.=
com> wrote:
> >
> > On Sat, Dec 21, 2024 at 9:34=E2=80=AFAM Chuck Lever <chuck.lever@oracle=
.com> wrote:
> > >
> > > On 12/20/24 9:16 PM, J David wrote:
> > > > Hello,
> > > >
> > > > On Tue, Dec 17, 2024 at 8:51=E2=80=AFPM Chuck Lever <chuck.lever@or=
acle.com> wrote:
> > > >> If they can reproduce
> > > >> this issue with an "in tree" file system contained in a recent ups=
tream
> > > >> Linux kernel, then we can take a look. (Or you and J. David can gi=
ve it
> > > >> a try).
> > > >
> > > > Yes, I reproduced this behavior on ext4 with 6.11.5+bpo-amd64 from
> > > > Debian backports on completely different hardware.
> > > >
> > > > Then I set up another NFS server on Arch (running kernel 6.12.4), a=
nd
> > > > reproduced the issue there as well.
> > > >
> > > > Then, just to be sure, I went and found the instructions for buildi=
ng
> > > > the Linux kernel from source, built and tested both 6.12.6 and
> > > > 6.13-rc3 as downloaded directly from www.kernel.org, and the issue
> > > > occurs with those as well.
> > >
> > > Reproducing on v6.13-rc with ext4 is all that was necessary, thank yo=
u!
> > >
> > >
> > > > Additionally, I have tested every combination of FreeBSD, Linux and
> > > > OpenIndiana as client and server to confirm that FreeBSD client wit=
h
> > > > Linux server is the only case where this problem occurs.
> > >
> > > Interesting.
> > >
> > >
> > > > Does this count as reproducing the issue with an "in tree" file sys=
tem
> > > > contained in a recent upstream Linux kernel? I'm asking sincerely; =
I'm
> > > > so far out of my depth that I'm pretty sure there are sea monsters
> > > > swimming around down there. So I can't rule out the possibility tha=
t
> > > > I've done something wrong either in setup or testing.
> > > >
> > > > During the course of this, I've gotten the reproduction down to
> > > > extracting a 2k tar file and then running "du" on the resulting
> > > > directory from the client. Doesn't matter if the file is untarred o=
n
> > > > the FreeBSD client, the server, or another client. The tar file
> > > > contains a directory with a handful of random Javascript files from
> > > > Drupal. As far as I can tell, it has something to do with the numbe=
r,
> > > > size, or names of the files. The Drupal project has three separate
> > > > directories all structured like this with the same filenames, but t=
he
> > > > file contents vary. The issue occurs with all of them.
> > > >
> > > > The Linux /etc/exports file is just:
> > > >
> > > > /data 192.168.201.0/24(rw,sync)
> > > >
> > > > (The production case also uses crossmnt and no_subtree_check, anonu=
id,
> > > > and anongid, but I eliminated those one by one to make sure they
> > > > weren't responsible.)
> > > >
> > > > The corresponding fstab entry on the FreeBSD 14.2-RELEASE client is=
:
> > > >
> > > > 192.168.201.200:/data /data nfs rw,tcp,nfsv4,minorversion=3D2 0 0
> > >
> > > Out of curiosity, do you see the problem recur with nfsv3 or the othe=
r
> > > NFSv4 minor versions?
> > >
> > >
> > > > One additional thing I noticed that really blew my mind is that I c=
an
> > > > shutdown both the client and the server, wait, power them back on, =
and
> > > > the issue is still there. So it's not something in RAM.  That promp=
ted
> > > > me to try "touch x" in the directory to create a new 0-length file.
> > > > The issue then goes away. Then I can "rm x" and the issue comes bac=
k.
> > > > By contrast, I can write megabytes from /dev/random into one of the
> > > > files without affecting anything; the issue stays the same.
> > > >
> > > > I then tried it with all empty files using the same filenames. The
> > > > issue still occurred. Add or remove one file and the issue goes awa=
y.
> > > > I then renamed one of the files to zz.js. Issue still occurs. Renam=
ed
> > > > it to zzz.js. Problem still occurs. Kept going until I got to
> > > > zzzzzz.js and it worked.
> > > >
> > > > Finally, I got it to the point where running this in an empty mount=
ed
> > > > directory will create the issue:
> > > >
> > > > rm *.xx; for a in a b c d e f g h ; do for b in 1 2 3 4 5 6 7 ; do
> > > > touch $a$b.xx ; done; done; for a in 1 2 3 4 5; do touch x$a-xx.xx;
> > > > done; touch y0-xxxxxx.xx
> > > >
> > > > and this will not:
> > > >
> > > > rm *.xx; for a in a b c d e f g h ; do for b in 1 2 3 4 5 6 7 ; do
> > > > touch $a$b.xx ; done; done; for a in 1 2 3 4 5; do touch x$a-xx.xx;
> > > > done; touch y0-xxxxxxx.xx
> > > >
> > > > (The difference being one extra x in the last filename.)
> > > >
> > > > It works in the other direction as well. This causes the issue:
> > > >
> > > > rm *.xx; for a in a b c d e f g h ; do for b in 1 2 3 4 5 6 7 ; do
> > > > touch $a$b.xx ; done; done; for a in 1 2 3 4 5; do touch x$a-xx.xx;
> > > > done; touch y0-xxx.xx
> > > >
> > > > This does not:
> > > >
> > > > rm *.xx; for a in a b c d e f g h ; do for b in 1 2 3 4 5 6 7 ; do
> > > > touch $a$b.xx ; done; done; for a in 1 2 3 4 5; do touch x$a-xx.xx;
> > > > done; touch y0-xx.xx
> > > >
> > > > There's a four-character window involving the length of the filenam=
es
> > > > where 62 files in a directory causes this issue. There's a little m=
ore
> > > > to it than that; it doesn't look like you can just create 61
> > > > two-letter filenames and then one really long one and get the issue=
.
> > > >
> > > > So I haven't found the specifics yet, but perhaps due to pure chanc=
e
> > > > this directory structure is exactly right to provoke an incredibly
> > > > obscure edge case?
> > >
> > > Well it's likely that this is a problem with READDIR, so file content
> > > is not going to be an issue. The file name lengths are the problem.
> > >
> > > Also, I'm wondering what the FreeBSD client's directory readdir
> > > arguments are (how much does it request, what are the maximum limits =
it
> > > negotiates, and so on). Rick?
> > As you'll see in the packet trace:
> > Sequence: cache this: No
> > Putfh: directory fh
> > Readdir:
> >     cookie: 0
> >     cookie_verf: 0
> >     dircount: 8706
> >     maxcount: 8706
> >     attr: type, RDattr_error, fileid, mounted_on_fleid
> > Getattr: same attributes as requested for a previous GETATTR, mainly
> >               to keep the directory's attribute cache up to date.
> >
> > The session negotiates a max request/reply size of just over 1Mbyte and=
 a
> > maximum of something like 20 ops. (Can't recall, but definitely more th=
an 4.)
> >
> > If you are wondering where the 8706 comes from, it was an estimate of h=
ow
> > much would be needed to fill an 8K buffer with the XDR translated to UF=
S dirents
> > by adding 512 to 8K.
> >
> > I have not yet had a chance to see if I can reproduce the problem with
> > J. David's
> > reproducer. I will try that soon, and if I can reproduce it, I will
> > poke at it to try and
> > figure out what is going on.
> Just fyi, I have reproduced it. Once you use J. David's little shell scri=
pt to
> create the files in the directory, the Readdir RPC gets the junk reply
> to GETATTR
> (the count of words for the attribute bitmap in the reply is 0 instead of=
 2).
> You can unmount/remount it and still get the failure, assuming you do not
> mess with the directory contents.
>
> Good work finding the reproducer, J. David!
>
> I will start to poke around to see if I can figure out what the knfsd ser=
ver is
> doing.
>
> Chuck, I suspect any fairly recent FreeBSD client will be sufficient to
> reproduce this, just in case you are inspired to cross over to the dark
> side and install FreeBSD somewhere.
>
> I'll post when I have more info, rick
Here's a little more info...
(A) NFSv4.0 with the following ops in a compound works (as J. David noted)
PUTFH
READDIR
GETATTR

(B) NFSv4.1/4.2 with the following ops in a compound works
SEQUENCE
PUTFH
READDIR

(C) NFSv4.1/4.2 with the following ops in a compound does not work
SEQUENCE
PUTFH
READDIR
GETATTR

Note that all I did for (B) was remove the GETATTR from the compound
and that (A) uses the same PUTFH, READDIR and GETATTR as (C).
Btw J. David, the patch I sent you that removes GETATTR from the RPC
does seem to be a workaround.

rick


>
> >
> > rick
> >
> > >
> > > Since this isn't reproducible (yet) with a Linux client, let's try
> > > another set of network captures, and you can send these to me
> > > privately.
> > >
> > > Start the capture
> > > Mount
> > > Run one of the reproducers above
> > > Unmount
> > > Stop the capture
> > >
> > > I'd like to see one with v6.13-rc3 and ext4 that works as expected, a=
nd
> > > one with the same configuration that fails.
> > >
> > > --
> > > Chuck Lever

