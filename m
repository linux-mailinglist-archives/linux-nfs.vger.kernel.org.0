Return-Path: <linux-nfs+bounces-21608-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ePuOB1DgBGpuQAIAu9opvQ
	(envelope-from <linux-nfs+bounces-21608-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 13 May 2026 22:34:24 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B135753A7E1
	for <lists+linux-nfs@lfdr.de>; Wed, 13 May 2026 22:34:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BB005301AA44
	for <lists+linux-nfs@lfdr.de>; Wed, 13 May 2026 20:34:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C35437472A;
	Wed, 13 May 2026 20:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AD9fcV9D"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28D0C34F24A
	for <linux-nfs@vger.kernel.org>; Wed, 13 May 2026 20:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778704458; cv=pass; b=iv3PEa3EXvnTW7QmnjTZ6jVJ3sLYa/0wSjoO5SUM7gIvP5eSj5iaW10dmZrzFDMrSQfecp4NrfeQP2ul7elGqyER9boz/q3JC3zqVrvNT+fQNCEl8W1w7AGp7AIjmtp2nMRkFydSLKrNWuY7hNfdJwYDYqGwdbfTeg58K/Kezko=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778704458; c=relaxed/simple;
	bh=QqaIYA8X3X6Tew9rng99hk3rmPCslU/eWwD53qMGzFE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MRJndSIKAIqmM9iyokNuOaNdCBfk4G601cIPRvguc0lG3FZGFcRZxkKq35byWZqfv+JkHzpLibnlZ+hkJImwWay0FkY+8qbVIWB4M4m1b+vog5NbIfK0zmnOwfep9UQ7XS8GdyzrfCK1aKGRGxMj3p5Cdduec//DnWCd5dudtis=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AD9fcV9D; arc=pass smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-8b98482b253so96271616d6.1
        for <linux-nfs@vger.kernel.org>; Wed, 13 May 2026 13:34:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778704455; cv=none;
        d=google.com; s=arc-20240605;
        b=CYo3AddXwP2hjzA07tgPqRf/3Z9/HtHNaX2a1cg2N5rM+ooENldVPVOFp6ztlT+hWB
         N22SewTZlTyp7OM8DJTfrkHL2tgla5p1ouIvE3XUMLUfhYCoah4pOhPa2RBuUp7TyFru
         cow099jnxZhO/fB6P+NM4n6AyDhwGk9KZAm0KN/fQH/85BVejEm1nm9TJyxA1/l3Lock
         rUGFrDajAZiV+GCZXbSBtinwHB9k5dgIlxKJuSSrte2aYCwGXC05d1YOZzrStp07S1HV
         4jnViBljPaPAeCcv9+uGNS/3r8vjn1x/vbOxmikbyK3MF1PVX4tE71rqtN3BoAz64JWP
         dyoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=YffvRc4ueiaHAv5vxRd/K/yTD1qBPNZn3LhENW3N4xg=;
        fh=yqcDW2tPnsaln2UC/ZH3swcwlXjjaOwA0L23BAk+n9M=;
        b=HkhL9XJZSH/R5mwf7En1aQXytZjFpLE6FaftLt2CtodlIobYsD0Tj2MKlzkVHkMVOP
         MDYRPfmgG6sOJqWbHdvXZXiUbzaYBYYiJm89s8gmw816BXanS5WakTokv6lBB2NzeMVb
         68RIJArIdYoQkgG0RcYwFFw4snAElFc/Gg1a1P8FEzStQib3O/1drCzW/24R3T+oGuCR
         ZndlsF+jJnPEXlF7iwvsbUq2+WiDXT4scovC5qdwjyv0Yyalz45JZDlkYyp27gbr8rhf
         OHroZ2btOg7/DmGSVFOiLe/a74R1nCiCMXHQwY/wsJgEzm/gS2d7p5oWtP7o3TIh/5BS
         RI2Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778704455; x=1779309255; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YffvRc4ueiaHAv5vxRd/K/yTD1qBPNZn3LhENW3N4xg=;
        b=AD9fcV9DHYgDCefhJ2zSXZDp5IsgxaGD+U0MOWxRyeVB9HxtlwiRupMCngACCv3gN3
         DM2QnrQXjV+sYmnB7buk4J5Dt6tGrh1OPZBWVQB8b9fCQmOKih3ywWgVh1komLd2T6S9
         Iw0vFCUrddNFBUe65lmXniDofheSzrnXitWFheF975H4HOv5OAkzK3mkvFZBQzbbEFO5
         3CBUV04Gi5ikM28vxU2ZcJDeIaaPgXBzn1SOf42ImQdPsuYoVzWX98ke8U7+4SKfTYHq
         rgiLecCrmAZpjPBD/RK6amLrzQARySCD79r299h/pV/nX/61R2SXk8dj58MY+M4wHe8N
         AnCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778704455; x=1779309255;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YffvRc4ueiaHAv5vxRd/K/yTD1qBPNZn3LhENW3N4xg=;
        b=E6az/V+IcIj7YJVzlzvq5AM3OU9s62WJ7O+vzmqe5puz9JKmelJNv1SDVnFoBe4LHj
         WBSuT97DzPDongn3urYPxBT2cK9wfrVaF26kQdHVZqM+DZ5QLR0PDnzTUb2jcEbXnO5/
         pUBBXlhN4ev7Ia/EovnsYgExgvu+q8qPLN9LxgYpMLgC6K9c3xZFCldvwS2lniQ4tU3g
         Xolca+ZV33XASeL04alptne4XBpN6gLkoAPlSRNfHWEwwcclpr1KIuwXLXssjVw0dzy8
         XKzPUi5eS+XnuOA5wFefhS9vObYX9wjYnCIAqxMnTfkLk2Um6w2QBie4NShCfddLfzR+
         NQ7g==
X-Forwarded-Encrypted: i=1; AFNElJ/eKdC5ra2JOQhOlSUVddPAMsjMkV4Lq3Pc2YkYQHgWKPvAG1PPGZu8Cu3tM0SHVz+ic8WqlDoK3yc=@vger.kernel.org
X-Gm-Message-State: AOJu0YySHGvxR2QRA685aQMKw9rttsu04Bm5NNq4pdPyserXmdPj4uF9
	cq1Dr4Iorn1Pu1d3rQFXJe5v8PIcMrDl3E4PY1MgrC5oC+tb+lqMp+BUYEF5jdVuZtzibh59Az/
	1aVtus4mBNo4ZRz9MtFwqv9GKvTVesT0=
X-Gm-Gg: Acq92OH9BCXp0OC0FkR7iUkxPN7AMGijWXx1FnTRaBOTJRX3aP9rfGV3wYY/4pH9YB0
	g6Ux0jzWE4YXfV+7niYNaFlrOl2uswhBIhTeia5jbneBfnRHGE0DeWJ2ud3qBnAiPz0Uisu88VM
	8nXulehjTjnx6/7mJl2VEEBH4NRpUkN5qXspnC8hn20LE/JZYIOkjn2BG22meqgXuIFpY6S1Dc9
	JkAAyYlKkGBEqMOauMcs+h8OtDXtBC8x8twpGjxvyBxMuTK1ypUNruOymD6eOr/ObPrc7jWW0WF
	ZXh4wi4277syiax1lET1xPuTCioMfRFa8dx8NDX2vDaFUFGez1IL/uNREBiudWunDdlDh8g4U3q
	1qWiFcKbwioY4RjSRPuKuFAwv/vdET5tV7yyeF5npo2ZttG7iIunJz5tIq7JaQbo4doggAgB6Hi
	8IWn2kJNRy+yQxO3f6owwwHw==
X-Received: by 2002:a05:6214:8009:b0:8a0:846e:8850 with SMTP id
 6a1803df08f44-8c7b9d6a34dmr79395336d6.20.1778704455206; Wed, 13 May 2026
 13:34:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260512053625.2950900-1-hch@lst.de>
In-Reply-To: <20260512053625.2950900-1-hch@lst.de>
From: Steve French <smfrench@gmail.com>
Date: Wed, 13 May 2026 15:34:03 -0500
X-Gm-Features: AVHnY4LdSaGvyovg6RvG5pKhPWnEZkoZnNgrzQdw3V-htIBym1ah9EOHikjxM8Q
Message-ID: <CAH2r5msnYVb3hhXHwqDVHGGC1h4E6mLCRS4ktCrQoD9zdUW81g@mail.gmail.com>
Subject: Re: improve the swap_activate interface
To: Christoph Hellwig <hch@lst.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, Chris Li <chrisl@kernel.org>, 
	Kairui Song <kasong@tencent.com>, Christian Brauner <brauner@kernel.org>, 
	"Darrick J . Wong" <djwong@kernel.org>, Jens Axboe <axboe@kernel.dk>, David Sterba <dsterba@suse.com>, 
	"Theodore Ts'o" <tytso@mit.edu>, Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>, 
	Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
	Namjae Jeon <linkinjeon@kernel.org>, Hyunchul Lee <hyc.lee@gmail.com>, 
	Steve French <sfrench@samba.org>, Paulo Alcantara <pc@manguebit.org>, Carlos Maiolino <cem@kernel.org>, 
	Damien Le Moal <dlemoal@kernel.org>, Naohiro Aota <naohiro.aota@wdc.com>, linux-xfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, 
	linux-block@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, 
	linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: B135753A7E1
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21608-lists,linux-nfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[30];
	FREEMAIL_CC(0.00)[linux-foundation.org,kernel.org,tencent.com,kernel.dk,suse.com,mit.edu,gmail.com,samba.org,manguebit.org,wdc.com,vger.kernel.org,kvack.org,lists.sourceforge.net];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[smfrench@gmail.com,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-nfs];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,lst.de:email]
X-Rspamd-Action: no action

I just tried this on 7.1-rc3 with the swap patches (full kernel build,
on Ubuntu 25,10) and boot failed with out of memory which I had never
seen before.  Any idea how to workaround this with the swap patch
series, or is there a fix for this in the swap series already?

On Tue, May 12, 2026 at 12:41=E2=80=AFAM Christoph Hellwig <hch@lst.de> wro=
te:
>
> Hi all,
>
> Darrick recently posted iomap support for fuse-iomap, which was trivial
> but a bit ugly, which triggered me into looking how this could be done
> in a cleaner way.  The result of that is this fairly big series that
> reworks how the MM code calls into the file system to activate swap
> files to make it much cleaner and easier to use.
>
> I've tested this with swap devices manually, and using the swap tests
> in xfstests on btrfs, ext3, ext4, f2fs and xfs to exercise the different
> implementation.  Out of those all passed, but f2fs actually notruns all
> tests even in the baseline as it requires special preparation for
> swapfiles which never got wired up in xfstests.
>
> Diffstat:
>  Documentation/filesystems/iomap/operations.rst |    3
>  Documentation/filesystems/locking.rst          |   35 +--
>  Documentation/filesystems/vfs.rst              |   40 ++--
>  block/fops.c                                   |   15 +
>  fs/btrfs/btrfs_inode.h                         |    3
>  fs/btrfs/file.c                                |    4
>  fs/btrfs/inode.c                               |   72 -------
>  fs/ext4/file.c                                 |    6
>  fs/ext4/inode.c                                |   11 -
>  fs/f2fs/data.c                                 |   50 -----
>  fs/f2fs/f2fs.h                                 |    2
>  fs/f2fs/file.c                                 |    4
>  fs/iomap/swapfile.c                            |  165 +++---------------
>  fs/nfs/direct.c                                |    1
>  fs/nfs/file.c                                  |   21 --
>  fs/nfs/nfs4file.c                              |    3
>  fs/ntfs/aops.c                                 |    8
>  fs/ntfs/file.c                                 |    6
>  fs/smb/client/cifsfs.c                         |   18 +
>  fs/smb/client/cifsfs.h                         |    3
>  fs/smb/client/file.c                           |   16 -
>  fs/xfs/xfs_aops.c                              |   48 -----
>  fs/xfs/xfs_file.c                              |   39 ++++
>  fs/zonefs/file.c                               |   30 +--
>  include/linux/fs.h                             |   11 -
>  include/linux/iomap.h                          |    5
>  include/linux/nfs_fs.h                         |    3
>  include/linux/swap.h                           |  129 +-------------
>  mm/page_io.c                                   |   45 ----
>  mm/swap.h                                      |   92 ++++++++++
>  mm/swapfile.c                                  |  227 ++++++++++++++----=
-------
>  31 files changed, 471 insertions(+), 644 deletions(-)
>


--=20
Thanks,

Steve

