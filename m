Return-Path: <linux-nfs+bounces-8758-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E97B49FB9FB
	for <lists+linux-nfs@lfdr.de>; Tue, 24 Dec 2024 07:52:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64A87164734
	for <lists+linux-nfs@lfdr.de>; Tue, 24 Dec 2024 06:52:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34F7B16DEB1;
	Tue, 24 Dec 2024 06:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SpbM+p77"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CE3345BE3
	for <linux-nfs@vger.kernel.org>; Tue, 24 Dec 2024 06:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735023169; cv=none; b=ckwEOfL1U8z+6+e6uLaEXF04WEgrxyAcyCrRC3arZmNJZYnAMbuzFeD4kBmTVtXWaOblWclV7KYEVUbH8+TeGq7UuTh5tQ1slvfAHcG80nQLQTpfxZ9rjBrNYi4/iUZ8vHK5w96JN05WXUVW9luZLzJ+ErLfeTsktbx1ZKCiWKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735023169; c=relaxed/simple;
	bh=l0nDw8dqCp3l6h3gTazA+iU6GhZCaBg4ngOSbWQywfk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=QWw7BUIkKWX1ZR6yc0XdmNorV5DEgGsUWgkkaniq7JPpYNkDxkfqxWo9OUFNE/eVSkoK6pqAThw798EAoq/Ot1G/c6R7Id245s5JwHUnMrSDeA7lvL1MH/TJ5bYKh5QAMA5sC0sOwUpWnoZFTkKlTnHgHHJf00tUb+vLz77AYis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SpbM+p77; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5ceb03aadb1so6748816a12.0
        for <linux-nfs@vger.kernel.org>; Mon, 23 Dec 2024 22:52:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735023165; x=1735627965; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7id4LPusEbPX2ZA5/P1ErY6IpIwRW8RN+BgIb5mhs00=;
        b=SpbM+p77gACtHLAiZPe+/ElLNOsSKIfuYc4QTJdLcpEmJUULK6yy0aHf/fZUtu9yma
         W0/4j6vPgd9J57EYsXtWd9gGjGq+7dTlc/YsDDa4swtJncCUpEXi0RFAAVtS6ok9FTcC
         gzmaG+W5tMeAJJBBpN1XXY3adhbXaZoqKEJxbPXs+n7IsajDUaLKciIW0Rqo6I9CW0Eb
         /PwzWqW16QPiwDX+tDyrs2xQCNkRjk9bKsVdwpgaXKc9oPTh6QsPn1J0tSPW4nfUDQ38
         S2OLFEA5tx9DVFgVN54mm+rnkwAOAZ2oByNCPK7P6JXdtdOEUpajHEeEaJiXZM8tIBOs
         4/2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735023165; x=1735627965;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7id4LPusEbPX2ZA5/P1ErY6IpIwRW8RN+BgIb5mhs00=;
        b=syRxJvzW+ikr62AyRKQXT7D79lwyg7yeZjKAuCO8yxu8sTFD6z836U33C8x/eVkRoR
         95s1KAKIuGG2FQRi13HcMnMQ2re1WWJ2rfNwQUchlY73HXC6jyG2oQ7mabEFzHCkMs9h
         bB0pqRKqiC4EANQyFp6H8eGO3LFAWh6qGTAuyZgs2GcL3rtPMeDnI7SbNogYaCl9x+qs
         x6cK10uiieWajQBLowAHkwsqNf486/LojRjT4Zy0SxejJ4UjONZKZ1bblxnkXRcOpN1b
         gWKdN+oLXlxn9lzKeh2cKbEkJ2S3U1v3G+XLla4vYAIGSANkFloL06szCBneq8gBrOuN
         O3qQ==
X-Gm-Message-State: AOJu0YyRhV3ADsgw3FfG9WcjwakiOEf06OwHfKGuaqZhyyIm+fVMyINB
	JXwPKxgDCEbmInG06H+s0CUMyVYjrpmmOrAl3OuxYXxb+4AgzscejJOwSmmtY98GksiAD+MMpku
	LQp6BeHA5ov4UyA4VZzExrx1g8lsfMzVa
X-Gm-Gg: ASbGncs+JMg7lqtoU2ecMjw0WZJgT6vRyKO9N8sjBFetglcdnqcacpob3y1W9iOpP2x
	CTot52E09kj8OvinR1/28mxwSMFMpTjA+oJxIXEY=
X-Google-Smtp-Source: AGHT+IFkSE5WoCAu2mH138Eev+PpnfTVXxiSi60mGSeLaVDlODBVOBeJx7k6nG4R+pkoQ4VjEQf2Cq5BoJU5HibLHWc=
X-Received: by 2002:a05:6402:3549:b0:5d3:ce7f:abee with SMTP id
 4fb4d7f45d1cf-5d81ddffac3mr12795735a12.25.1735023164961; Mon, 23 Dec 2024
 22:52:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAM5tNy4-SNVD+zqgaJTmLtAQ+kKV_Ce4tRr2zqgjTq1KPM-rfQ@mail.gmail.com>
 <4804ce6a-fa67-4b50-bc31-715689d3c766@oracle.com> <CABXB=RQn8qU5TZsWyBpWNaDQpaMPhdi4RYVJ0D1qJAWiFuBAHQ@mail.gmail.com>
 <e4853faf-0836-4595-952b-69f71150bede@oracle.com> <CAM5tNy6tR96WrCeoLEfoA5cGs0AP=mR3q1nmYrqbFTTQB=G=Yw@mail.gmail.com>
 <CAM5tNy6dFBgAhkX_mBzXyRyb+WfukZT0egpt75XRgCYKHPsP3Q@mail.gmail.com> <3998d739-c042-46b4-8166-dbd6c5f0e804@oracle.com>
In-Reply-To: <3998d739-c042-46b4-8166-dbd6c5f0e804@oracle.com>
From: Cedric Blancher <cedric.blancher@gmail.com>
Date: Tue, 24 Dec 2024 07:51:00 +0100
Message-ID: <CALXu0UfSYhcTm6TN28WU9+FCzQMQkKXMZxGp2PHb3kFi3jb6-A@mail.gmail.com>
Subject: Re: knfsd server bug when GETATTR follows READDIR
To: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, 22 Dec 2024 at 21:19, Chuck Lever <chuck.lever@oracle.com> wrote:
>
> On 12/21/24 6:53 PM, Rick Macklem wrote:
> > On Sat, Dec 21, 2024 at 3:27=E2=80=AFPM Rick Macklem <rick.macklem@gmai=
l.com> wrote:
> >>
> >> On Sat, Dec 21, 2024 at 9:34=E2=80=AFAM Chuck Lever <chuck.lever@oracl=
e.com> wrote:
> >>>
> >>> On 12/20/24 9:16 PM, J David wrote:
> >>>> Hello,
> >>>>
> >>>> On Tue, Dec 17, 2024 at 8:51=E2=80=AFPM Chuck Lever <chuck.lever@ora=
cle.com> wrote:
> >>>>> If they can reproduce
> >>>>> this issue with an "in tree" file system contained in a recent upst=
ream
> >>>>> Linux kernel, then we can take a look. (Or you and J. David can giv=
e it
> >>>>> a try).
> >>>>
> >>>> Yes, I reproduced this behavior on ext4 with 6.11.5+bpo-amd64 from
> >>>> Debian backports on completely different hardware.
> >>>>
> >>>> Then I set up another NFS server on Arch (running kernel 6.12.4), an=
d
> >>>> reproduced the issue there as well.
> >>>>
> >>>> Then, just to be sure, I went and found the instructions for buildin=
g
> >>>> the Linux kernel from source, built and tested both 6.12.6 and
> >>>> 6.13-rc3 as downloaded directly from www.kernel.org, and the issue
> >>>> occurs with those as well.
> >>>
> >>> Reproducing on v6.13-rc with ext4 is all that was necessary, thank yo=
u!
> >>>
> >>>
> >>>> Additionally, I have tested every combination of FreeBSD, Linux and
> >>>> OpenIndiana as client and server to confirm that FreeBSD client with
> >>>> Linux server is the only case where this problem occurs.
> >>>
> >>> Interesting.
> >>>
> >>>
> >>>> Does this count as reproducing the issue with an "in tree" file syst=
em
> >>>> contained in a recent upstream Linux kernel? I'm asking sincerely; I=
'm
> >>>> so far out of my depth that I'm pretty sure there are sea monsters
> >>>> swimming around down there. So I can't rule out the possibility that
> >>>> I've done something wrong either in setup or testing.
> >>>>
> >>>> During the course of this, I've gotten the reproduction down to
> >>>> extracting a 2k tar file and then running "du" on the resulting
> >>>> directory from the client. Doesn't matter if the file is untarred on
> >>>> the FreeBSD client, the server, or another client. The tar file
> >>>> contains a directory with a handful of random Javascript files from
> >>>> Drupal. As far as I can tell, it has something to do with the number=
,
> >>>> size, or names of the files. The Drupal project has three separate
> >>>> directories all structured like this with the same filenames, but th=
e
> >>>> file contents vary. The issue occurs with all of them.
> >>>>
> >>>> The Linux /etc/exports file is just:
> >>>>
> >>>> /data 192.168.201.0/24(rw,sync)
> >>>>
> >>>> (The production case also uses crossmnt and no_subtree_check, anonui=
d,
> >>>> and anongid, but I eliminated those one by one to make sure they
> >>>> weren't responsible.)
> >>>>
> >>>> The corresponding fstab entry on the FreeBSD 14.2-RELEASE client is:
> >>>>
> >>>> 192.168.201.200:/data /data nfs rw,tcp,nfsv4,minorversion=3D2 0 0
> >>>
> >>> Out of curiosity, do you see the problem recur with nfsv3 or the othe=
r
> >>> NFSv4 minor versions?
> >>>
> >>>
> >>>> One additional thing I noticed that really blew my mind is that I ca=
n
> >>>> shutdown both the client and the server, wait, power them back on, a=
nd
> >>>> the issue is still there. So it's not something in RAM.  That prompt=
ed
> >>>> me to try "touch x" in the directory to create a new 0-length file.
> >>>> The issue then goes away. Then I can "rm x" and the issue comes back=
.
> >>>> By contrast, I can write megabytes from /dev/random into one of the
> >>>> files without affecting anything; the issue stays the same.
> >>>>
> >>>> I then tried it with all empty files using the same filenames. The
> >>>> issue still occurred. Add or remove one file and the issue goes away=
.
> >>>> I then renamed one of the files to zz.js. Issue still occurs. Rename=
d
> >>>> it to zzz.js. Problem still occurs. Kept going until I got to
> >>>> zzzzzz.js and it worked.
> >>>>
> >>>> Finally, I got it to the point where running this in an empty mounte=
d
> >>>> directory will create the issue:
> >>>>
> >>>> rm *.xx; for a in a b c d e f g h ; do for b in 1 2 3 4 5 6 7 ; do
> >>>> touch $a$b.xx ; done; done; for a in 1 2 3 4 5; do touch x$a-xx.xx;
> >>>> done; touch y0-xxxxxx.xx
> >>>>
> >>>> and this will not:
> >>>>
> >>>> rm *.xx; for a in a b c d e f g h ; do for b in 1 2 3 4 5 6 7 ; do
> >>>> touch $a$b.xx ; done; done; for a in 1 2 3 4 5; do touch x$a-xx.xx;
> >>>> done; touch y0-xxxxxxx.xx
> >>>>
> >>>> (The difference being one extra x in the last filename.)
> >>>>
> >>>> It works in the other direction as well. This causes the issue:
> >>>>
> >>>> rm *.xx; for a in a b c d e f g h ; do for b in 1 2 3 4 5 6 7 ; do
> >>>> touch $a$b.xx ; done; done; for a in 1 2 3 4 5; do touch x$a-xx.xx;
> >>>> done; touch y0-xxx.xx
> >>>>
> >>>> This does not:
> >>>>
> >>>> rm *.xx; for a in a b c d e f g h ; do for b in 1 2 3 4 5 6 7 ; do
> >>>> touch $a$b.xx ; done; done; for a in 1 2 3 4 5; do touch x$a-xx.xx;
> >>>> done; touch y0-xx.xx
> >>>>
> >>>> There's a four-character window involving the length of the filename=
s
> >>>> where 62 files in a directory causes this issue. There's a little mo=
re
> >>>> to it than that; it doesn't look like you can just create 61
> >>>> two-letter filenames and then one really long one and get the issue.
> >>>>
> >>>> So I haven't found the specifics yet, but perhaps due to pure chance
> >>>> this directory structure is exactly right to provoke an incredibly
> >>>> obscure edge case?
> >>>
> >>> Well it's likely that this is a problem with READDIR, so file content
> >>> is not going to be an issue. The file name lengths are the problem.
> >>>
> >>> Also, I'm wondering what the FreeBSD client's directory readdir
> >>> arguments are (how much does it request, what are the maximum limits =
it
> >>> negotiates, and so on). Rick?
> >> As you'll see in the packet trace:
> >> Sequence: cache this: No
> >> Putfh: directory fh
> >> Readdir:
> >>      cookie: 0
> >>      cookie_verf: 0
> >>      dircount: 8706
> >>      maxcount: 8706
> >>      attr: type, RDattr_error, fileid, mounted_on_fleid
> >> Getattr: same attributes as requested for a previous GETATTR, mainly
> >>                to keep the directory's attribute cache up to date.
> >>
> >> The session negotiates a max request/reply size of just over 1Mbyte an=
d a
> >> maximum of something like 20 ops. (Can't recall, but definitely more t=
han 4.)
> >>
> >> If you are wondering where the 8706 comes from, it was an estimate of =
how
> >> much would be needed to fill an 8K buffer with the XDR translated to U=
FS dirents
> >> by adding 512 to 8K.
> >>
> >> I have not yet had a chance to see if I can reproduce the problem with
> >> J. David's
> >> reproducer. I will try that soon, and if I can reproduce it, I will
> >> poke at it to try and
> >> figure out what is going on.
> > Just fyi, I have reproduced it. Once you use J. David's little shell sc=
ript to
> > create the files in the directory, the Readdir RPC gets the junk reply
> > to GETATTR
> > (the count of words for the attribute bitmap in the reply is 0 instead =
of 2).
> > You can unmount/remount it and still get the failure, assuming you do n=
ot
> > mess with the directory contents.
> >
> > Good work finding the reproducer, J. David!
> >
> > I will start to poke around to see if I can figure out what the knfsd s=
erver is
> > doing.
> >
> > Chuck, I suspect any fairly recent FreeBSD client will be sufficient to
> > reproduce this, just in case you are inspired to cross over to the dark
> > side and install FreeBSD somewhere.
>
> I see the same malformed GETATTR result in the attachments.
>
> Linux doesn't trip on this issue because it's NFS client doesn't ever
> append a GETATTR operation after a READDIR.

Windows ms-nfs41-client driver also does GETATTR after READDIR, and
trips over bogus return values on a regular basis. Solaris 11.4 nfsd
and nfs4j do not exhibit such problems.

Another garbage value that client gets from Linux nfsd is
FATTR4_WORD0_CHANGE, which sometimes returns absurdly high values.
Maybe add some WARN_ONCE() to Linux nfsd if unexpected crazy values
are sent over the wire?

Ced
--=20
Cedric Blancher <cedric.blancher@gmail.com>
[https://plus.google.com/u/0/+CedricBlancher/]
Institute Pasteur

