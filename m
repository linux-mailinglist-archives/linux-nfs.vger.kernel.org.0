Return-Path: <linux-nfs+bounces-8698-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CF839F9DE4
	for <lists+linux-nfs@lfdr.de>; Sat, 21 Dec 2024 03:16:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9CC167A288D
	for <lists+linux-nfs@lfdr.de>; Sat, 21 Dec 2024 02:16:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41B1F225D7;
	Sat, 21 Dec 2024 02:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eT1Osw7T"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB3DB1799B
	for <linux-nfs@vger.kernel.org>; Sat, 21 Dec 2024 02:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734747408; cv=none; b=twTStxJ/HwFPs6/wte8JZuQKG87ELyKeh6Ks8NzOFTZWzm9ioW11ccYiZ8MZ5ty5Orbx0t7TnUxGyYpbp1WL1bb1loTXd5UIQ+HfSCHCSIBXCxJc21raba9+1SyLitePIeVUv1c1+oY/6R99ZMc/ancYDMeGgOuCqJtqkJspImw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734747408; c=relaxed/simple;
	bh=x/UsBW7+HkVZaj1LOfbE4/Mfp8YP30NdiYzfELlBPuQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fLPPdXjXkJJVUj2QAAUIY8ofeoCIpsb3InaFT5x/TDH/CGrL8ygx/WXjTQtGu2Wxr2wl4U5XlzN0Lffvz0G+v6fpFbm+2g0Fsjv3IO7l1ex9plhyYWnARjyp8X/ZooLfqrJG0DVs+saPH9dePKOyLllxcN7Obs4LYKJni7IHAiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eT1Osw7T; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-7fd5248d663so1921683a12.0
        for <linux-nfs@vger.kernel.org>; Fri, 20 Dec 2024 18:16:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734747406; x=1735352206; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TjTZUprqBIakbAvGGwLQMzXQKXDx2asBM8wx8aqKnlA=;
        b=eT1Osw7TGm1rtH8k5trZQStj0MLWCY4qEi3nL6/nsOmaSYznkFsgXe1N5ivBXg22t5
         3TE0riNGm6Sr2S8n7UBZ5GTky/dCtovKyBt5+ktBg5Xk9ZT0kdy589Lsff6mA5J0naCX
         M0QAFzRIejAKoy8oSj3VPiR15qMPGYqSijZai7KC+mDuV4wVTeW8HHPWmbrPcWT+GQrU
         jwewd46JNiFus9fxPCjncOCWbZznZ7Qka9Xx5EuuTthRmdzMT9QXY5iimhMfpVyMvG71
         WfZP6HqS+zRXBtOY1hNe1DWC3jyo8rejJOWr/rgAL2pOGUy7ydQyavSJcVl+IKyU4Rr3
         OYfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734747406; x=1735352206;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TjTZUprqBIakbAvGGwLQMzXQKXDx2asBM8wx8aqKnlA=;
        b=UQvWrtj12RJbAHOfQYLISdon8AuFva+0yUdK1Rdw711BWwHhR3XFKz/XBKj+F4M3TS
         JVoPYj+KtZArAu6koQX/HD9I55HhTZ2/91anleA/YMZZlIzzHqOPvlCTRTbn0w0CPyg7
         tOlercDx5qdRRtD+EVgN07UTH6aRV5wg3TMMkiasflA+Za2fEs8rHGzn3mquUaYj/z2W
         /DQv1ylh7eP3k89xMptuDFMeynQcMdfyAtGmleNqtUcXiDxaQ4gQ2u5tGiMCcSAIv2ZP
         WpdfyoMfNS9yyDwzoPGNiLMdI42RAXj6YbR7V8jdMhKV/W6zNRAKruTwxb2rgeteX4vO
         IAsQ==
X-Forwarded-Encrypted: i=1; AJvYcCWri7glIopvWsz5F4ByU2xIUaVPV5PA5FWHp3p2fQGJi3M11+tJZRrBPR/ZqbbzrRwzWxHmhk/GutI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9LEeMTwQqS600doWwEeeu7hJoJD178/OC05n7TDCTNiOD64NY
	5sRJF9GiDwRDdk3RQzyz43AITgH/f7ON9SEmfarcfpuojLCFvmU15+809jfHaRTsd25IVmIx24/
	2ia7UK6jtJo4IACOP2x/vGd2WaeA=
X-Gm-Gg: ASbGncs5g92mNcvBIbvFXIXG1Vo9ro++qZ932R4/kc/JTvPma0DcoxN+g/6Jlm2qAFT
	vEquO2Fj8VeMCBbxZ1AbTZl3DjZbL7yR4oYpR
X-Google-Smtp-Source: AGHT+IEChv0EE2rdTHoo0ynORPaMr6xfzeKuwl25AuJa1551vqqpZqeztnJiL7ephwMS47Ecx1nRfGb/07+GYYItdAw=
X-Received: by 2002:a17:90a:e706:b0:2ee:cd83:8fd3 with SMTP id
 98e67ed59e1d1-2f452ee931amr8021649a91.33.1734747405847; Fri, 20 Dec 2024
 18:16:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAM5tNy4-SNVD+zqgaJTmLtAQ+kKV_Ce4tRr2zqgjTq1KPM-rfQ@mail.gmail.com>
 <4804ce6a-fa67-4b50-bc31-715689d3c766@oracle.com>
In-Reply-To: <4804ce6a-fa67-4b50-bc31-715689d3c766@oracle.com>
From: J David <j.david.lists@gmail.com>
Date: Fri, 20 Dec 2024 21:16:34 -0500
Message-ID: <CABXB=RQn8qU5TZsWyBpWNaDQpaMPhdi4RYVJ0D1qJAWiFuBAHQ@mail.gmail.com>
Subject: Re: knfsd server bug when GETATTR follows READDIR
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Rick Macklem <rick.macklem@gmail.com>, 
	Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

On Tue, Dec 17, 2024 at 8:51=E2=80=AFPM Chuck Lever <chuck.lever@oracle.com=
> wrote:
> If they can reproduce
> this issue with an "in tree" file system contained in a recent upstream
> Linux kernel, then we can take a look. (Or you and J. David can give it
> a try).

Yes, I reproduced this behavior on ext4 with 6.11.5+bpo-amd64 from
Debian backports on completely different hardware.

Then I set up another NFS server on Arch (running kernel 6.12.4), and
reproduced the issue there as well.

Then, just to be sure, I went and found the instructions for building
the Linux kernel from source, built and tested both 6.12.6 and
6.13-rc3 as downloaded directly from www.kernel.org, and the issue
occurs with those as well.

Additionally, I have tested every combination of FreeBSD, Linux and
OpenIndiana as client and server to confirm that FreeBSD client with
Linux server is the only case where this problem occurs.

Does this count as reproducing the issue with an "in tree" file system
contained in a recent upstream Linux kernel? I'm asking sincerely; I'm
so far out of my depth that I'm pretty sure there are sea monsters
swimming around down there. So I can't rule out the possibility that
I've done something wrong either in setup or testing.

During the course of this, I've gotten the reproduction down to
extracting a 2k tar file and then running "du" on the resulting
directory from the client. Doesn't matter if the file is untarred on
the FreeBSD client, the server, or another client. The tar file
contains a directory with a handful of random Javascript files from
Drupal. As far as I can tell, it has something to do with the number,
size, or names of the files. The Drupal project has three separate
directories all structured like this with the same filenames, but the
file contents vary. The issue occurs with all of them.

The Linux /etc/exports file is just:

/data 192.168.201.0/24(rw,sync)

(The production case also uses crossmnt and no_subtree_check, anonuid,
and anongid, but I eliminated those one by one to make sure they
weren't responsible.)

The corresponding fstab entry on the FreeBSD 14.2-RELEASE client is:

192.168.201.200:/data /data nfs rw,tcp,nfsv4,minorversion=3D2 0 0

One additional thing I noticed that really blew my mind is that I can
shutdown both the client and the server, wait, power them back on, and
the issue is still there. So it's not something in RAM.  That prompted
me to try "touch x" in the directory to create a new 0-length file.
The issue then goes away. Then I can "rm x" and the issue comes back.
By contrast, I can write megabytes from /dev/random into one of the
files without affecting anything; the issue stays the same.

I then tried it with all empty files using the same filenames. The
issue still occurred. Add or remove one file and the issue goes away.
I then renamed one of the files to zz.js. Issue still occurs. Renamed
it to zzz.js. Problem still occurs. Kept going until I got to
zzzzzz.js and it worked.

Finally, I got it to the point where running this in an empty mounted
directory will create the issue:

rm *.xx; for a in a b c d e f g h ; do for b in 1 2 3 4 5 6 7 ; do
touch $a$b.xx ; done; done; for a in 1 2 3 4 5; do touch x$a-xx.xx;
done; touch y0-xxxxxx.xx

and this will not:

rm *.xx; for a in a b c d e f g h ; do for b in 1 2 3 4 5 6 7 ; do
touch $a$b.xx ; done; done; for a in 1 2 3 4 5; do touch x$a-xx.xx;
done; touch y0-xxxxxxx.xx

(The difference being one extra x in the last filename.)

It works in the other direction as well. This causes the issue:

rm *.xx; for a in a b c d e f g h ; do for b in 1 2 3 4 5 6 7 ; do
touch $a$b.xx ; done; done; for a in 1 2 3 4 5; do touch x$a-xx.xx;
done; touch y0-xxx.xx

This does not:

rm *.xx; for a in a b c d e f g h ; do for b in 1 2 3 4 5 6 7 ; do
touch $a$b.xx ; done; done; for a in 1 2 3 4 5; do touch x$a-xx.xx;
done; touch y0-xx.xx

There's a four-character window involving the length of the filenames
where 62 files in a directory causes this issue. There's a little more
to it than that; it doesn't look like you can just create 61
two-letter filenames and then one really long one and get the issue.

So I haven't found the specifics yet, but perhaps due to pure chance
this directory structure is exactly right to provoke an incredibly
obscure edge case?

Thanks!

