Return-Path: <linux-nfs+bounces-845-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DDBA820931
	for <lists+linux-nfs@lfdr.de>; Sun, 31 Dec 2023 01:05:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C4641C21A11
	for <lists+linux-nfs@lfdr.de>; Sun, 31 Dec 2023 00:05:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FC6BFBE4;
	Sun, 31 Dec 2023 00:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UuxMEl2G"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 753E4FBE1
	for <linux-nfs@vger.kernel.org>; Sun, 31 Dec 2023 00:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-50e7abe4be4so5761639e87.2
        for <linux-nfs@vger.kernel.org>; Sat, 30 Dec 2023 16:05:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703981112; x=1704585912; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qiyr38qmifxx1aQmxn655X+sCh+0mjiw+eHzRMWxTG8=;
        b=UuxMEl2Gn8A5CsvwqWRq7z8lWEeTEfwr2IooXLApWGf3zIuwfjNjnjoSE0zTrOM5+5
         St3d67/3CK/sh1cvrr2y6i6HEbz70alwzl2NyeVf4iJOWJNiuNdYO43PK1A4TZhhcb2r
         ZIyh4innFCJkZ8InMrvlUKRP6XZ/Y/2Yw69Rpy7FD6QnWD85h4e6ZJCb6nRQXmijzuvP
         DwHnpggbhl9Q6g2ZokA8Swr2KZHsXZD+qjzvuqUmv+pcYv3zWSiSu4J3M2h7knVTRz/e
         tC0iGh25zS7EC+z+lQEJjfiBAewqKC6O82ovdLL5RXhh+RIiMJpWGzny03Qde5uOJaB9
         Ne3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703981112; x=1704585912;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qiyr38qmifxx1aQmxn655X+sCh+0mjiw+eHzRMWxTG8=;
        b=xMAgd6M/KKj/0qDVBnbHgNst2g5THF2VGIX+DE9vL8r3kATfaNztNICdD4G/Ki4B4q
         9lOn29Q7R0CGlbWj8KwE45sT3IS6ZJ+hdlYkNm/zUAESPaE5tlu50MsoOBLYu2qkZDN3
         WDpzyc7pJz7RKkS3AXQrNQd1yhfUN8n59sN11BhLWRAf4YBns/E3DT2gGuHFZIwpqxH6
         ZD5mMOd1k56eCg9/S13McUHXxveC9vKFsx/qDUau7S+V4KojSOrzbty6nDKpoIOt+3tB
         0qyZus+XDoPkjZyEfNiGzeTHVCPksFIGuLjsofv7nL+VVBuhORf9N18vmr6OZCln75up
         oldw==
X-Gm-Message-State: AOJu0YzCbNUgd7SEhIlZsIwIm3ciN4JC08McCFGtAJN8IrPxReTFP79m
	DD2POugaUoVIcWcdlkwSZBugJL9yeEYKRQ6QoDFdhJ+U
X-Google-Smtp-Source: AGHT+IHVwtw2t1xgGLDovEdo/SQ2rUP+pNDZCxbC5uXkk50EyV/M2bTLjAjf7An1Ov2X0QdJdpLw4OjMuVses3fmNmU=
X-Received: by 2002:ac2:55b8:0:b0:50e:554a:5254 with SMTP id
 y24-20020ac255b8000000b0050e554a5254mr5346536lfg.13.1703981112193; Sat, 30
 Dec 2023 16:05:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAKAoaQkVgYiSYhJDhRm5KY5TA6Q8chtwh5PpP=tt-o-TZoRF8w@mail.gmail.com>
 <CANH4o6N2kBSa7sb72O93N0_twAgXZWqXW659e21YxqLyxQn_aw@mail.gmail.com>
In-Reply-To: <CANH4o6N2kBSa7sb72O93N0_twAgXZWqXW659e21YxqLyxQn_aw@mail.gmail.com>
From: Dan Shelton <dan.f.shelton@gmail.com>
Date: Sun, 31 Dec 2023 01:04:45 +0100
Message-ID: <CAAvCNcA9WK2xdGMdUgVFC588F67it-1HHCN+yYzNjOfXE85RNg@mail.gmail.com>
Subject: Re: [Ms-nfs41-client-devel] ANN: NFSv4.1 Windows driver binaries for
 Windows 10 for testing, 2023-12-30 ...
To: ms-nfs41-client-devel@lists.sourceforge.net, 
	Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 30 Dec 2023 at 22:25, Martin Wege <martin.l.wege@gmail.com> wrote:
>
> Hello,
>
> Please test the binaries
>
> Thanks,
> Martin
>
> ---------- Forwarded message ---------
> From: Roland Mainz <roland.mainz@nrubsig.org>
> Date: Sat, Dec 30, 2023 at 4:34=E2=80=AFPM
> Subject: [Ms-nfs41-client-devel] ANN: NFSv4.1 Windows driver binaries
> for Windows 10 for testing, 2023-12-30 ...
> To: <ms-nfs41-client-devel@lists.sourceforge.net>
>
>
> Hi!
>
> ----
>
> I've created a set of test binaries for the NFSv4.1 filesystem driver
> for Windows, based on https://github.com/kofemann/ms-nfs41-client
> (commit id #43852f547ce80b3b33bb05c2e993e322d2264dfa), for testing and
> feedback (download URL below).
> Please send comments, bugs, test reports, complaints etc. to
> https://sourceforge.net/projects/ms-nfs41-client/lists/ms-nfs41-client-de=
vel
>
> # 1. Requirements:
> - Windows 10 (64bit, without SecureBoot!!)
> - Cygwin 3.5.0
> (Install in Cygwin setup.exe, Install with checkboxes "Testing" and "Sync=
")
>     - Packages:
>         cygwin
>         cygwin-devel
>         cygrunsrv
>         cygutils
>         cygutils-extra
>         bash
>         bzip2
>         coreutils
>         getent
>         gdb
>         grep
>         hostname
>         less
>         pax
>         pbzip2
>         procps-ng
>         sed
>         tar
>         time
>         util-linux
>         wget
>
>
> # 2. Installation (as "Administrator"):
> $ mkdir -p ~/download
> $ cd ~/download
> $ wget 'http://www.nrubsig.org/people/gisburn/work/msnfs41client/releases=
/testing/msnfs41client_cygwin_binaries_20231230_14h12m_git43852f5.tar.bz2'
> $ (cd / && tar -xf
> ~/download/msnfs41client_cygwin_binaries_20231230_14h12m_git43852f5.tar.b=
z2
> )
> $ /sbin/msnfs41client install

This fails on Windows 11, because two DLLs are missing:
VCRUNTIME140D.dll
ucrtbased.dll

Could you please package these DLLs too?

The workaround is to install Visual Studio 19.

>
>
> # 3. Deinstallation:
> $ (set -x ; cd / && tar -tf
> ~/download/msnfs41client_cygwin_binaries_20231230_14h12m_git43852f5.tar.b=
z2
> | while read i ; do [[ -f "$i" ]] && rm "$i" ; done)
>
>
> ##
> ## Usage
> ##
>
> # Run the NFSv4 client daemon:
> # - run this preferably as "Adminstrator", but this is not a requirement
> # - requires separate terminal
> $ /sbin/msnfs41client run_daemon

This fails because the script wants cdb.exe (is this WinDBG command
line?). I added a # to that line, and then the script runs.

It would be nice if you could add this to Cygwin cygrunserv to run
msnfs41client run_daemon as Windows service

>
> # Mount a filesystem and use it
> $ /sbin/nfs_mount -o rw N 10.49.20.110:/net_tmpfs2
> Successfully mounted '10.49.20.110@2049' to drive 'N:'
> $ cd /cygdrive/n/

This fails too, until I figured out that the Linux nfs server needs
the export line "insecure". Could you please fix this?

So after fixing all this, nfs_mount succeeded. HURRAY!!

So, permissions/ownership seems to be an issue, so I created a tmp/
dir, and did a chmod a=3Du tmp, so everyone can r/w to that dir. And
then Windows can even WRITE there.

Quick test, Word and Excel can read and write files.
Moving big and small files works.
Watching videos from NFS filesystem work
Overwriting/replacing files created on Linux fails with a permission
error, which is correct.
clang can compile on the NFS filesystem a hello world application
wget on NFS filesystem works

So far it looks VERY good :)
--=20
Dan

