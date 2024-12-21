Return-Path: <linux-nfs+bounces-8706-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 955DD9FA2EB
	for <lists+linux-nfs@lfdr.de>; Sun, 22 Dec 2024 00:27:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 331E67A2403
	for <lists+linux-nfs@lfdr.de>; Sat, 21 Dec 2024 23:27:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A8D61D9A66;
	Sat, 21 Dec 2024 23:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HgiLYeMo"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BE4C144D21
	for <linux-nfs@vger.kernel.org>; Sat, 21 Dec 2024 23:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734823667; cv=none; b=knLPm5gzvBF2MUD/RbiUdvNDWiZVQn+F3eM8phIb5gWDQAx9GpXDAzDco+c0vNqgrDNwCcJPHwLAPlO7XFT7Ty2AAHJigEKR5dvjTzL5ekgJW5BSG6HmfqNcUlI2OJoG27uHS5Nqpw0LxHsjQCCd0Jth7CiwEdHLZLsvpvtJM/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734823667; c=relaxed/simple;
	bh=Sk2xv0CZB7U0VTp5zodX5+XguAnV55Yd0OvaK5Ey6ps=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NXGc3YXZs5bLSU4tyHxxCwebx0ekrrFuv79TeOu0NVnv/v3AIEWgBqFlwwz7CLq7qaPfdSYOTa0RN6Y71n1Xvbt6MxGGQ+wQV1hsYQpywQQWOvajb98WrWQomDJ24qlWGDy89qSPduu4HlTGkcylsS+3AdeLTD42V5O6tkZ+pR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HgiLYeMo; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5cecbddb574so4973739a12.1
        for <linux-nfs@vger.kernel.org>; Sat, 21 Dec 2024 15:27:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734823663; x=1735428463; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dyRX6wQrosLQMAJOnDN3WZ+uZR4fh7yuOmKlU/byThw=;
        b=HgiLYeMovWZsYlrty/KMMhuTrhaSJxeXWJG3xvwcc10JiMmn115ccyNrsdEY1Wj6vl
         oOBPxv+36uAkA76tuNTygfYGG8oRAc+/PQqw3igc/YOiMCETMObhN9K4WTdFDUbDExq4
         NpyFJG2DU66nuLTmQElaHSUEi34/U96yLGMSor90HItvFnyDy5DzyogxZ0ndClEuRqiM
         XyZSuV7fi1qby9MSwCgPlqThdHn/Nfiyr5JWC85PGCGpXw64UOgUize74enkQ14wJ9U5
         lFHoa3rcATDQUcWEZ+QCD9Z9OiXuT4VSEhs/V3ipsZv5Kh8vUlp3NtqR3qOKtPFAvV9g
         Ifpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734823663; x=1735428463;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dyRX6wQrosLQMAJOnDN3WZ+uZR4fh7yuOmKlU/byThw=;
        b=ok80W8zrGHnDBeR3Q5KBPAh4JgKsoi22BWxMoNoSLl9wu5eyeMwLo2BNj3iqe0aWMm
         oX6WD7g+ANMzadDkmYL3N0Qcc351bwbOOxRqmXBUqzgzjwKe4wgbFQBBU/+O99fZ/CU0
         DSMku9rWChgLueYOwxTEnKAM9TctFk9iAdNF99TVCDvNp7xW3qx3KpWw+rcFYtEVVpVg
         fJPfJmUCHWYHD6IMM8kD4Vqxrvj2/2vZbiDsAzILNBf7YDcN1ma85VhlrTBVOznLQcgK
         8Gj0L2njUaNUZ2dMl64U33yE0ur5yF/aruATgXKQqcv0Hn6PAEI8szkCb94jwmHNS6eh
         zAbQ==
X-Forwarded-Encrypted: i=1; AJvYcCW8GPAKqjPXG98/IVgcMwLB0IpThzUpuB+/TyCCZBuFTu8V7sGXTmigkumdiQh5N07llp27FGkljMc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5GNgvhSLxclc67yCGUbcGxUAM/44lb0jXiHihPUybI9iokzsv
	hBzl2qitD6L+01iiz6juw1wngDZeok/hU2T5Gq1zpczkMdSHCfHq6knwDOnjTQxA3p7yABDU2Tu
	/Tn4VIS3vwgdH0PzbVK/xPicDlQ==
X-Gm-Gg: ASbGncvsWtxKnsFHowu5hrXsI4MTmVBujfoUuS9B7HTaMtI+OMbC2Gse0x5rNNnlG1x
	FOxChCVMzauzBQffzctX1OartPdoGVTUeS7UrgidbqMnGSvXY5x3u4Xh7k8jp84ZAPtYDMQ==
X-Google-Smtp-Source: AGHT+IFpC5BYeLaeZLHaDvZwErC6hsNHux/C9p4bGZMAvbTAlybNfn5/PIwWkSAbpvGtWHgIyM2bhkMkAIjufpDWjt0=
X-Received: by 2002:a05:6402:34c2:b0:5d1:1f2:1143 with SMTP id
 4fb4d7f45d1cf-5d81ddfe32bmr7893862a12.18.1734823663093; Sat, 21 Dec 2024
 15:27:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAM5tNy4-SNVD+zqgaJTmLtAQ+kKV_Ce4tRr2zqgjTq1KPM-rfQ@mail.gmail.com>
 <4804ce6a-fa67-4b50-bc31-715689d3c766@oracle.com> <CABXB=RQn8qU5TZsWyBpWNaDQpaMPhdi4RYVJ0D1qJAWiFuBAHQ@mail.gmail.com>
 <e4853faf-0836-4595-952b-69f71150bede@oracle.com>
In-Reply-To: <e4853faf-0836-4595-952b-69f71150bede@oracle.com>
From: Rick Macklem <rick.macklem@gmail.com>
Date: Sat, 21 Dec 2024 15:27:32 -0800
Message-ID: <CAM5tNy6tR96WrCeoLEfoA5cGs0AP=mR3q1nmYrqbFTTQB=G=Yw@mail.gmail.com>
Subject: Re: knfsd server bug when GETATTR follows READDIR
To: Chuck Lever <chuck.lever@oracle.com>
Cc: J David <j.david.lists@gmail.com>, 
	Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 21, 2024 at 9:34=E2=80=AFAM Chuck Lever <chuck.lever@oracle.com=
> wrote:
>
> On 12/20/24 9:16 PM, J David wrote:
> > Hello,
> >
> > On Tue, Dec 17, 2024 at 8:51=E2=80=AFPM Chuck Lever <chuck.lever@oracle=
.com> wrote:
> >> If they can reproduce
> >> this issue with an "in tree" file system contained in a recent upstrea=
m
> >> Linux kernel, then we can take a look. (Or you and J. David can give i=
t
> >> a try).
> >
> > Yes, I reproduced this behavior on ext4 with 6.11.5+bpo-amd64 from
> > Debian backports on completely different hardware.
> >
> > Then I set up another NFS server on Arch (running kernel 6.12.4), and
> > reproduced the issue there as well.
> >
> > Then, just to be sure, I went and found the instructions for building
> > the Linux kernel from source, built and tested both 6.12.6 and
> > 6.13-rc3 as downloaded directly from www.kernel.org, and the issue
> > occurs with those as well.
>
> Reproducing on v6.13-rc with ext4 is all that was necessary, thank you!
>
>
> > Additionally, I have tested every combination of FreeBSD, Linux and
> > OpenIndiana as client and server to confirm that FreeBSD client with
> > Linux server is the only case where this problem occurs.
>
> Interesting.
>
>
> > Does this count as reproducing the issue with an "in tree" file system
> > contained in a recent upstream Linux kernel? I'm asking sincerely; I'm
> > so far out of my depth that I'm pretty sure there are sea monsters
> > swimming around down there. So I can't rule out the possibility that
> > I've done something wrong either in setup or testing.
> >
> > During the course of this, I've gotten the reproduction down to
> > extracting a 2k tar file and then running "du" on the resulting
> > directory from the client. Doesn't matter if the file is untarred on
> > the FreeBSD client, the server, or another client. The tar file
> > contains a directory with a handful of random Javascript files from
> > Drupal. As far as I can tell, it has something to do with the number,
> > size, or names of the files. The Drupal project has three separate
> > directories all structured like this with the same filenames, but the
> > file contents vary. The issue occurs with all of them.
> >
> > The Linux /etc/exports file is just:
> >
> > /data 192.168.201.0/24(rw,sync)
> >
> > (The production case also uses crossmnt and no_subtree_check, anonuid,
> > and anongid, but I eliminated those one by one to make sure they
> > weren't responsible.)
> >
> > The corresponding fstab entry on the FreeBSD 14.2-RELEASE client is:
> >
> > 192.168.201.200:/data /data nfs rw,tcp,nfsv4,minorversion=3D2 0 0
>
> Out of curiosity, do you see the problem recur with nfsv3 or the other
> NFSv4 minor versions?
>
>
> > One additional thing I noticed that really blew my mind is that I can
> > shutdown both the client and the server, wait, power them back on, and
> > the issue is still there. So it's not something in RAM.  That prompted
> > me to try "touch x" in the directory to create a new 0-length file.
> > The issue then goes away. Then I can "rm x" and the issue comes back.
> > By contrast, I can write megabytes from /dev/random into one of the
> > files without affecting anything; the issue stays the same.
> >
> > I then tried it with all empty files using the same filenames. The
> > issue still occurred. Add or remove one file and the issue goes away.
> > I then renamed one of the files to zz.js. Issue still occurs. Renamed
> > it to zzz.js. Problem still occurs. Kept going until I got to
> > zzzzzz.js and it worked.
> >
> > Finally, I got it to the point where running this in an empty mounted
> > directory will create the issue:
> >
> > rm *.xx; for a in a b c d e f g h ; do for b in 1 2 3 4 5 6 7 ; do
> > touch $a$b.xx ; done; done; for a in 1 2 3 4 5; do touch x$a-xx.xx;
> > done; touch y0-xxxxxx.xx
> >
> > and this will not:
> >
> > rm *.xx; for a in a b c d e f g h ; do for b in 1 2 3 4 5 6 7 ; do
> > touch $a$b.xx ; done; done; for a in 1 2 3 4 5; do touch x$a-xx.xx;
> > done; touch y0-xxxxxxx.xx
> >
> > (The difference being one extra x in the last filename.)
> >
> > It works in the other direction as well. This causes the issue:
> >
> > rm *.xx; for a in a b c d e f g h ; do for b in 1 2 3 4 5 6 7 ; do
> > touch $a$b.xx ; done; done; for a in 1 2 3 4 5; do touch x$a-xx.xx;
> > done; touch y0-xxx.xx
> >
> > This does not:
> >
> > rm *.xx; for a in a b c d e f g h ; do for b in 1 2 3 4 5 6 7 ; do
> > touch $a$b.xx ; done; done; for a in 1 2 3 4 5; do touch x$a-xx.xx;
> > done; touch y0-xx.xx
> >
> > There's a four-character window involving the length of the filenames
> > where 62 files in a directory causes this issue. There's a little more
> > to it than that; it doesn't look like you can just create 61
> > two-letter filenames and then one really long one and get the issue.
> >
> > So I haven't found the specifics yet, but perhaps due to pure chance
> > this directory structure is exactly right to provoke an incredibly
> > obscure edge case?
>
> Well it's likely that this is a problem with READDIR, so file content
> is not going to be an issue. The file name lengths are the problem.
>
> Also, I'm wondering what the FreeBSD client's directory readdir
> arguments are (how much does it request, what are the maximum limits it
> negotiates, and so on). Rick?
As you'll see in the packet trace:
Sequence: cache this: No
Putfh: directory fh
Readdir:
    cookie: 0
    cookie_verf: 0
    dircount: 8706
    maxcount: 8706
    attr: type, RDattr_error, fileid, mounted_on_fleid
Getattr: same attributes as requested for a previous GETATTR, mainly
              to keep the directory's attribute cache up to date.

The session negotiates a max request/reply size of just over 1Mbyte and a
maximum of something like 20 ops. (Can't recall, but definitely more than 4=
.)

If you are wondering where the 8706 comes from, it was an estimate of how
much would be needed to fill an 8K buffer with the XDR translated to UFS di=
rents
by adding 512 to 8K.

I have not yet had a chance to see if I can reproduce the problem with
J. David's
reproducer. I will try that soon, and if I can reproduce it, I will
poke at it to try and
figure out what is going on.

rick

>
> Since this isn't reproducible (yet) with a Linux client, let's try
> another set of network captures, and you can send these to me
> privately.
>
> Start the capture
> Mount
> Run one of the reproducers above
> Unmount
> Stop the capture
>
> I'd like to see one with v6.13-rc3 and ext4 that works as expected, and
> one with the same configuration that fails.
>
> --
> Chuck Lever

