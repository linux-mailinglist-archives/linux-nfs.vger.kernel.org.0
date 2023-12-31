Return-Path: <linux-nfs+bounces-846-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A164C8209E5
	for <lists+linux-nfs@lfdr.de>; Sun, 31 Dec 2023 07:19:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53EB8283117
	for <lists+linux-nfs@lfdr.de>; Sun, 31 Dec 2023 06:19:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C52E17D3;
	Sun, 31 Dec 2023 06:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RjvvNyl9"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E39217C2
	for <linux-nfs@vger.kernel.org>; Sun, 31 Dec 2023 06:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-55569b59f81so3585166a12.1
        for <linux-nfs@vger.kernel.org>; Sat, 30 Dec 2023 22:19:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704003562; x=1704608362; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lq2pVnlTxnM/IgvpzJ/1i31ZNPIbv/YUPJ1RTGVoYaw=;
        b=RjvvNyl9uYzyPD9fvBC7FEN0V6sfqQXLNNhu5iVXHl+h8cXImiOyODTqYkuBOT9ZHn
         qss7ctKzBfdYqN2sLSy+AfTLV2N9ltKAw9aYeYb9VeR4+oUg0KH0p+J3q2geiVfA1COB
         2Cc+XX26g3D+I9MJ3FvmrysZxEWq7T3JygOV0oNJFSy75Llwup00Zv4Flqt54c+k+tJs
         QBD3bFtR4tR5uUHzitLSpuLHeOfJn3/0QgmwldzsUh6ascE/KYfX8HqAuXS/wzcH+62Z
         tDQeZLZDrutHN3eHRE6U76H6Z6knfGSinKQLlGit7PAQokZ1EoL/TwNTYTDB9Q4fCAtF
         yoyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704003562; x=1704608362;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lq2pVnlTxnM/IgvpzJ/1i31ZNPIbv/YUPJ1RTGVoYaw=;
        b=YWXQMMj4h1HBKBNIGS9k3qy3S/1JCPci1OziUITEeW6wf0jfSmTwZdXcAyHdqVwo6X
         RvKthCZnOK/vsRKRf1GXUw+t4nAyRQj0SK0nLz8PEay5X4aJpLVE+TTr/nyw9ayyqz3H
         qiwhRyl7fAKdPiCIaB7tLiksgOwmUM8iRJAk0x9VFvgjxcP4R+8iYvRf2xU4O20JEHwY
         q+/sUhgn01UdY34QswvFF/zmDe3VTlh4WjbRfXfAXBXNk/Z1/k+n7QQqmpx4UodavoH8
         JSO9tdc6ZuQlDYMZ+ZvOxUoCgL8fEoChxLh9HNnFPG0TJCq0knZlHCFew0uIdLI94MR+
         cr/g==
X-Gm-Message-State: AOJu0YySjNXg5/IpSzMuD5v2iKbhbYLkcUGti3H93D78EfA73i0LFHHz
	PNq9Hp9ZzITk6E4cSkS4lHv+jlWTV7rHDrq/A80usI7eXLc=
X-Google-Smtp-Source: AGHT+IEtOb4C00jQfdr8lTgEjVXuxR/rtf2tX4+tZNUH4HMI91W7+jJZbKscAGPjgYPxPUBhoPy/WBLq/3fZUZJTC3Q=
X-Received: by 2002:a05:6402:3083:b0:556:346a:16e6 with SMTP id
 de3-20020a056402308300b00556346a16e6mr154990edb.66.1704003562208; Sat, 30 Dec
 2023 22:19:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAKAoaQkVgYiSYhJDhRm5KY5TA6Q8chtwh5PpP=tt-o-TZoRF8w@mail.gmail.com>
 <CANH4o6N2kBSa7sb72O93N0_twAgXZWqXW659e21YxqLyxQn_aw@mail.gmail.com> <CAAvCNcA9WK2xdGMdUgVFC588F67it-1HHCN+yYzNjOfXE85RNg@mail.gmail.com>
In-Reply-To: <CAAvCNcA9WK2xdGMdUgVFC588F67it-1HHCN+yYzNjOfXE85RNg@mail.gmail.com>
From: Cedric Blancher <cedric.blancher@gmail.com>
Date: Sun, 31 Dec 2023 07:19:00 +0100
Message-ID: <CALXu0UcDVz5reM1XnZ0pFPU9sKer7E2g=kFY-FBH-UTW5frVGA@mail.gmail.com>
Subject: Re: [Ms-nfs41-client-devel] ANN: NFSv4.1 Windows driver binaries for
 Windows 10 for testing, 2023-12-30 ...
To: ms-nfs41-client-devel@lists.sourceforge.net, 
	Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Sun, 31 Dec 2023 at 01:05, Dan Shelton <dan.f.shelton@gmail.com> wrote:
>
> On Sat, 30 Dec 2023 at 22:25, Martin Wege <martin.l.wege@gmail.com> wrote:
[[CUT--CUT--CUT]]
> > I've created a set of test binaries for the NFSv4.1 filesystem driver
> > for Windows, based on https://github.com/kofemann/ms-nfs41-client
> > (commit id #43852f547ce80b3b33bb05c2e993e322d2264dfa), for testing and
> > feedback (download URL below).
> > Please send comments, bugs, test reports, complaints etc. to
> > https://sourceforge.net/projects/ms-nfs41-client/lists/ms-nfs41-client-devel
[[CUT--CUT--CUT]]
> > # 2. Installation (as "Administrator"):
> > $ mkdir -p ~/download
> > $ cd ~/download
> > $ wget 'http://www.nrubsig.org/people/gisburn/work/msnfs41client/releases/testing/msnfs41client_cygwin_binaries_20231230_14h12m_git43852f5.tar.bz2'
> > $ (cd / && tar -xf
> > ~/download/msnfs41client_cygwin_binaries_20231230_14h12m_git43852f5.tar.bz2
> > )
> > $ /sbin/msnfs41client install
>
> This fails on Windows 11, because two DLLs are missing:
> VCRUNTIME140D.dll
> ucrtbased.dll
>
> Could you please package these DLLs too?

Or just link them statically.

[[CUT--CUT--CUT]]
> > # Mount a filesystem and use it
> > $ /sbin/nfs_mount -o rw N 10.49.20.110:/net_tmpfs2
> > Successfully mounted '10.49.20.110@2049' to drive 'N:'
> > $ cd /cygdrive/n/
>
> This fails too, until I figured out that the Linux nfs server needs
> the export line "insecure". Could you please fix this?

Not sure whether this can be fixed at all. The nfsd server requires
that nfs clients connect from a TCP port < 1024, and Windows just
doesn't allow a bind() to a port < 1024. I had that debate with
Roland, and for now its "under investigation" what could be done.

>
> So after fixing all this, nfs_mount succeeded. HURRAY!!
>
> So, permissions/ownership seems to be an issue, so I created a tmp/
> dir, and did a chmod a=u tmp, so everyone can r/w to that dir. And
> then Windows can even WRITE there.
>
> Quick test, Word and Excel can read and write files.
> Moving big and small files works.
> Watching videos from NFS filesystem work
> Overwriting/replacing files created on Linux fails with a permission
> error, which is correct.
> clang can compile on the NFS filesystem a hello world application
> wget on NFS filesystem works

BUG: Windows 11 Explorer shows  the NFS mount as "disconnected"

> So far it looks VERY good :)

Agreed.

Many thanks go to Roland Mainz and Tigran Mkrtchyan for working on this

Ced
-- 
Cedric Blancher <cedric.blancher@gmail.com>
[https://plus.google.com/u/0/+CedricBlancher/]
Institute Pasteur

