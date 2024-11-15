Return-Path: <linux-nfs+bounces-8009-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EB3D9CF188
	for <lists+linux-nfs@lfdr.de>; Fri, 15 Nov 2024 17:33:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4AE41F21479
	for <lists+linux-nfs@lfdr.de>; Fri, 15 Nov 2024 16:33:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEF411D45F2;
	Fri, 15 Nov 2024 16:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MPyuO8dL"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 681531CF7AF;
	Fri, 15 Nov 2024 16:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731688412; cv=none; b=h4nLnCJvYjpdLk0fwfJolRle4NS6eBzukYYcpoVE0LVeOiyt0yvgdlbBwgPdMthd2QGanOWBLL4YrVbMkB2+BncIcyMwLXovJQogXVQRYpurz6NVuRlwOPyUgF2OHNQnz+ROHYD2tEBhFwVs58rpwgknL0/l2G5uiikLgVSizrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731688412; c=relaxed/simple;
	bh=6kg6AxmG1h0NKv0onN/itgPve8q9yXIYSjbA1PYl+ac=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ow4HV07GtjVEnlAEBSulz8u5pKg8Boh3M3rQpPox91Q4GnDSEeooAN9BM3Ie6jZIAIOwG3dUPk8jwS2qANNvCH7VOvrDfvOPHx2qw9WRE/MlsItx4GRUlpn7JSmLKKyIlbGQwRJ0tJQlvlM8S7HOAkmLpQApRXLgGqW2MTANq48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MPyuO8dL; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2e9b4a4182dso1515625a91.0;
        Fri, 15 Nov 2024 08:33:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731688411; x=1732293211; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8U8himfTzTS7djfc3WTmNDyMXUIp/NKYV3qaKrTSk5k=;
        b=MPyuO8dLyL0PBdw9H9VZrlBreqjSdrtcp1K+xwMytTzoI+PAe+Tg5GIvb4IZP6mrqo
         IMEgZaGg+9HH6iM9Hj8kMauzvyg7qjQGWYeRAH9fJmwK19E1/UdVaz/srRdFAiYBLarc
         HS/mSQpeEHXi4dJz3HY3TSIg/ksAzc9U0fpbWhHRsbtUqKJEe8vcTOeFohQKV41jXNDQ
         9JyhTSezP/qsV7qtB/EyEB0JXRTluMcKiT4Vq8pIE0WApXugxHRnIKLodumHQylCpj0S
         zLM8T2vYP1JUvZW3lNk5GW7sO0idrVU678zKODAecMKR5YPfR7E28WLQJZgx3dLJhtEk
         eFOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731688411; x=1732293211;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8U8himfTzTS7djfc3WTmNDyMXUIp/NKYV3qaKrTSk5k=;
        b=aZXeD9kgP1zH0R2QIUklOCWMC4Rj9Mr6ukPlEKDg1S0mst8zg4FOhlrnGPZ67glgVL
         DrsSnMPzgXGvfVa+ozZQs0082xrxP+zcq75MpKBT7Be2GuixMoPjARNAq3h6Ic7Ova02
         5508ZCLNh/byDwOohpKWqn+Nc72WCRg+ey2m0RiLMTJ+mqZBlS/9TkpDz6KVd51GYxXi
         day4pAvn4bcpjz34rRkRSkwSfawR7em3ue2VD3CLx/gFEfXF5/uPnA/4I1gFIh6rrH4t
         JNPTfnkMOTm/BuDv2lOfpbc9zHlgUScBTcajc1NpcnN4p85gmB3PYuW3pP1FaoZu6Tc2
         IT0g==
X-Forwarded-Encrypted: i=1; AJvYcCUwyrvPEKFsc3Tone9H4hCULrMjK3GUj3ECSRuhatECsMuVbJ0kItBFN5uPNfHBd80T4q2HbR8u@vger.kernel.org, AJvYcCXidn48+/S3+MrskJUn4fNsYAolII0iCjtKAXEXz5YZTemIDjBM5n1TlN0z1bD+EaD/isxX3hnF4cI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQOXQ1bWiTN/sIMRw28yhgM1ZrMUnm8+qT4B8dvCt2/LbY99bN
	DstpiGJSX5tJ7Ek6E0Vw3Ta7Dy4+cf9poT+8Kb8n/vISzfq9+S6UfSn0H/MYkYmiwgK3jTnU6yA
	svwMQ6IUd0rhA7wpUfYknxM1SDW+un/Scw9M=
X-Google-Smtp-Source: AGHT+IGkRZ3xRw0xtYeD55DnQArjKqX9xmOVQ0Ef1ludGjMKCJX0VwfKnX5tijUwSPrt/LyqqiiHSrklYowXrLscRS4=
X-Received: by 2002:a17:90b:1e03:b0:2d8:a744:a81c with SMTP id
 98e67ed59e1d1-2e9fe61200emr11880844a91.1.1731688410478; Fri, 15 Nov 2024
 08:33:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZzdxKF39VEmXSSyN@tissot.1015granger.net> <Zzd12OGPDnZTMZ6t@tissot.1015granger.net>
In-Reply-To: <Zzd12OGPDnZTMZ6t@tissot.1015granger.net>
From: Jeongjun Park <aha310510@gmail.com>
Date: Sat, 16 Nov 2024 01:33:19 +0900
Message-ID: <CAO9qdTGLn6QWJg71Ad2xcobiTHE5ovoUxSqvrDDrE_i1+uqUQw@mail.gmail.com>
Subject: Re: tmpfs hang after v6.12-rc6
To: Chuck Lever <chuck.lever@oracle.com>
Cc: akpm@linux-foundation.org, stable@vger.kernel.org, 
	regressions@lists.linux.dev, linux-nfs@vger.kernel.org, hughd@google.com, 
	yuzhao@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2024=EB=85=84 11=EC=9B=94 16=EC=9D=BC (=ED=86=A0) =EC=98=A4=EC=A0=84 1:25, =
Chuck Lever <chuck.lever@oracle.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> On Fri, Nov 15, 2024 at 11:04:56AM -0500, Chuck Lever wrote:
> > I've found that NFS access to an exported tmpfs file system hangs
> > indefinitely when the client first performs a GETATTR. The hanging
> > nfsd thread is waiting for the inode lock in shmem_getattr():
> >
> > task:nfsd            state:D stack:0     pid:1775  tgid:1775  ppid:2   =
   flags:0x00004000
> > Call Trace:
> >  <TASK>
> >  __schedule+0x770/0x7b0
> >  schedule+0x33/0x50
> >  schedule_preempt_disabled+0x19/0x30
> >  rwsem_down_read_slowpath+0x206/0x230
> >  down_read+0x3f/0x60
> >  shmem_getattr+0x84/0xf0
> >  vfs_getattr_nosec+0x9e/0xc0
> >  vfs_getattr+0x49/0x50
> >  fh_getattr+0x43/0x50 [nfsd]
> >  fh_fill_pre_attrs+0x4e/0xd0 [nfsd]
> >  nfsd4_open+0x51f/0x910 [nfsd]
> >  nfsd4_proc_compound+0x492/0x5d0 [nfsd]
> >  nfsd_dispatch+0x117/0x1f0 [nfsd]
> >  svc_process_common+0x3b2/0x5e0 [sunrpc]
> >  ? __pfx_nfsd_dispatch+0x10/0x10 [nfsd]
> >  svc_process+0xcf/0x130 [sunrpc]
> >  svc_recv+0x64e/0x750 [sunrpc]
> >  ? __wake_up_bit+0x4b/0x60
> >  ? __pfx_nfsd+0x10/0x10 [nfsd]
> >  nfsd+0xc6/0xf0 [nfsd]
> >  kthread+0xed/0x100
> >  ? __pfx_kthread+0x10/0x10
> >  ret_from_fork+0x2e/0x50
> >  ? __pfx_kthread+0x10/0x10
> >  ret_from_fork_asm+0x1a/0x30
> >  </TASK>
> >
> > I bisected the problem to:
> >
> > d949d1d14fa281ace388b1de978e8f2cd52875cf is the first bad commit
> > commit d949d1d14fa281ace388b1de978e8f2cd52875cf
> > Author:     Jeongjun Park <aha310510@gmail.com>
> > AuthorDate: Mon Sep 9 21:35:58 2024 +0900
> > Commit:     Andrew Morton <akpm@linux-foundation.org>
> > CommitDate: Mon Oct 28 21:40:39 2024 -0700
> >
> >     mm: shmem: fix data-race in shmem_getattr()
> >
> > ...
> >
> >     Link: https://lkml.kernel.org/r/20240909123558.70229-1-aha310510@gm=
ail.com
> >     Fixes: 44a30220bc0a ("shmem: recalculate file inode when fstat")
> >     Signed-off-by: Jeongjun Park <aha310510@gmail.com>
> >     Reported-by: syzbot <syzkaller@googlegroup.com>
> >     Cc: Hugh Dickins <hughd@google.com>
> >     Cc: Yu Zhao <yuzhao@google.com>
> >     Cc: <stable@vger.kernel.org>
> >     Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> >
> > which first appeared in v6.12-rc6, and adds the line that is waiting
> > on the inode lock when my NFS server hangs.
> >
> > I haven't yet found the process that is holding the inode lock for
> > this inode.
>
> It is likely that the caller (nfsd4_open()-> fh_fill_pre_attrs()) is
> already holding the inode semaphore in this case.

Thanks for letting me know!

It seems that the previous patch I wrote was wrong in how to prevent data-r=
ace.
It seems that the problem occurs in nfsd because nfsd4_create_file() alread=
y
holds the inode_lock.

After further analysis, I found that this data-race mainly occurs when
vfs_statx_path does not acquire the inode_lock, and in other filesystems,
it is confirmed that inode_lock is acquired in many cases, so I will send a
new patch that fixes this problem right away.

Regards,

Jeongjun Park

>
>
> > Because this commit addresses only a KCSAN splat that has been
> > present since v4.3, and does not address a reported behavioral
> > issue, I respectfully request that this commit be reverted
> > immediately so that it does not appear in v6.12 final.
> > Troubleshooting and testing should continue until a fix to the KCSAN
> > issue can be found that does not deadlock NFS exports of tmpfs.
> >
> >
> > --
> > Chuck Lever
> >
>
> --
> Chuck Lever

