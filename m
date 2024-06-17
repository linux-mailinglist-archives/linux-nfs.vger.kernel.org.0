Return-Path: <linux-nfs+bounces-3887-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B3F390A80C
	for <lists+linux-nfs@lfdr.de>; Mon, 17 Jun 2024 10:03:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1627B1C2308B
	for <lists+linux-nfs@lfdr.de>; Mon, 17 Jun 2024 08:03:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACD49256A;
	Mon, 17 Jun 2024 08:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nQI0hlz+"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E1A5A48;
	Mon, 17 Jun 2024 08:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718611381; cv=none; b=BSu9R+XDp4zZEoggZCj9TAV6wR9Txoqug6mL/ikoWpj4imJV2np12cGaFGL5NgcTwRc0eqIw6zE01vwbnxw45SoWD251mAgBy71AXeMpnIr/JEV6ZL7mFjKy12AETdwi7+4e2mMHo8BpkApiCSyu4N/r8R+3tZR2QGkXKTia49U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718611381; c=relaxed/simple;
	bh=pjbVaR2b64izvPITN4SUEWPTdl8Xzyi9W1PmtyFeIOY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CBTcbIXUGBU5W1vX3UN14ajZZqM1dYmpYZcfmBH6SZhuiYFDQTWlfOWNvbo01Tikdhnhud390onNWWuqg0JRHVtosqxhgi5LoLIUkTlAFbKzLKYoyrPTcdHSJUFa6fleKaO6J3VaKyusagC/HBTtmxvy5oyUGy9qdcCq9B4sPng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nQI0hlz+; arc=none smtp.client-ip=209.85.222.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-80b76c5de79so1168213241.1;
        Mon, 17 Jun 2024 01:02:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718611379; x=1719216179; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E/uPRBGoZoLGCBkeZjiswy/3hxNMDxtntxyuCTrUh0g=;
        b=nQI0hlz+IAKG3ihXkT8N9aOPIYladPQbYr0dGpO+7YlMSLblovdU9XcouAXTYDFST5
         LXqcCMQt+HUhnIFQuGdXMk0wZ8s81FKM60uKPeT9zaFi0LCtOxVL61xZEexn2F6gYhKX
         pVejPSN6gWjS9j+uPqx1OtacEf131a2j3Mf9cTSQ6b85tMVr6dC0l8yA4YPGKINCBhYZ
         gDx+reasR9qWMMZc+ZOGcfJBfaLrCjeyBJmvX2TObFQhsTEydZBQt8N30IKRDetm/9aB
         If4WRAY8eRyWY1y/bbt1OOcd2g1E7WgPL8MSqZiUvSlxIVbJeOoXPS9M+kAhWNC8p40O
         OU0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718611379; x=1719216179;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E/uPRBGoZoLGCBkeZjiswy/3hxNMDxtntxyuCTrUh0g=;
        b=fa50qFJ2IQOZQjiqrE9IDz72gsdjH+FaOxaKwcQ2bzQsStGlkxMLuEWXsfy7Ma+2YH
         GoJWL2OqdXeBY7ntQANV2tzmE3fJt7ezpYrPxyibjoG4dABA2MU3l3pQd+8jy4PYNDgT
         MyZDNwlQlC15xH72zKCM/FW+hf57uPpVMb25Dx8Bo76urxoy1WiK1d1Ht+RXovoEgPT0
         OG3EVz23S5mWA+uIzE3yvUfWAuaD5H9A4AHC6r2GnEj16Sa7os2ym/O7Rz1/XNmYpBF+
         IsocH6eNibJUgOAjYZ9WRV/poAlH85XIj77sLlSR+ETwj+xdo7tawNprI71Y79+loPAn
         31uQ==
X-Forwarded-Encrypted: i=1; AJvYcCXEpOQrj+OdRdJ+17GvAr0my7x90d5FUUqkVtz2hzCKSV7Vi/hYoJstR9XQME8pTAewp1G2wV6ympRTDg/NIbZy39rR6Svdo5qRj+MlDJuhOnjaOaHXKw46vPCWA4o2JV+T1M7qcw==
X-Gm-Message-State: AOJu0YwWcXAINw8SKl5eD7A5TAmweLALbuwQ9S+ae5GTpdM9DOvzoWUd
	YJxRBEbquksSg1Xki9ejb4k6AA1pka72zYLzd5OxCsXZA6novz4emwoDvykXG4do+M8qXRBTg9b
	D85NzADIhcj681fgZRVbTz0Kb5fQ=
X-Google-Smtp-Source: AGHT+IGYSxUGXIMfY2cXE9b3X/EvwBDCMKoy45X4SyeBAvYyPm1woNYbiq0ynH0J2BI1QSk6xkRTrg8LkNeVCHvlx/Y=
X-Received: by 2002:a05:6102:c15:b0:48d:920a:bd40 with SMTP id
 ada2fe7eead31-48dae303badmr10876712137.15.1718611378877; Mon, 17 Jun 2024
 01:02:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240614100329.1203579-1-hch@lst.de> <20240614100329.1203579-2-hch@lst.de>
 <20240614112148.cd1961e84b736060c54bdf26@linux-foundation.org>
 <CAGsJ_4wnWzoScqO9_NddHcDPbe_GbAiRFVm4w_H+QDmH=e=Rsw@mail.gmail.com>
 <20240616085436.GA28058@lst.de> <CAGsJ_4ytrnXJbfVi=PpTw34iBDqEoAm3b16oZr2VQpVWLmh5zA@mail.gmail.com>
 <20240617053201.GA16852@lst.de>
In-Reply-To: <20240617053201.GA16852@lst.de>
From: Barry Song <21cnbao@gmail.com>
Date: Mon, 17 Jun 2024 20:02:47 +1200
Message-ID: <CAGsJ_4xQgY4kn46NO2=OWh2oDUj2F1-oYCRnKG4KCPJFfBT=Ng@mail.gmail.com>
Subject: Re: [PATCH] nfs: fix nfs_swap_rw for large-folio swap
To: Christoph Hellwig <hch@lst.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, Trond Myklebust <trondmy@kernel.org>, 
	Anna Schumaker <anna@kernel.org>, Steve French <sfrench@samba.org>, linux-nfs@vger.kernel.org, 
	linux-cifs@vger.kernel.org, linux-mm@kvack.org, 
	Barry Song <v-songbaohua@oppo.com>, Ryan Roberts <ryan.roberts@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 17, 2024 at 5:32=E2=80=AFPM Christoph Hellwig <hch@lst.de> wrot=
e:
>
> On Sun, Jun 16, 2024 at 06:23:16PM +0800, Barry Song wrote:
> > This is quite unusual. Could you share your setup and backtrace?
>
> Do this in an x86 kvm vm with 1G of memory:
>
> mkfs.xfs -f /dev/vdb
>
> mount /dev/vdb /mnt/nfs1
>
> # this requires the following line in /etc/exports to actually export the
> # file system: "/mnt/nfs2       localhost(rw,no_root_squash)"
> systemctl restart nfs-kernel-server
>
> mount -t nfs 127.0.0.1:/mnt/nfs1/ /mnt/test/
>
> cd /mnt/test
> dd if=3D/dev/zero of=3Dswapfile bs=3D1024 count=3D524288
> mkswap swapfile
> chmod 0600 swapfile
> swapon swapfile

I did everything the same as above,
but always got failure at the last step to swapon:
/mnt/test # swapon swapfile
swapon: /mnt/test/swapfile: swapon failed: Invalid argument

the mount status:
/dev/vdb on /mnt/nfs1 type xfs
(rw,relatime,attr2,inode64,logbufs=3D8,logbsize=3D32k,noquota)
127.0.0.1:/mnt/nfs1 on /mnt/test type nfs4
(rw,relatime,vers=3D4.2,rsize=3D1048576,wsize=3D1048576,namlen=3D255,hard,p=
roto=3Dtcp,timeo=3D600,retrans=3D2,sec=3Dsys,clientaddr=3D127.0.0.1,local_l=
ock=3Dnone,addr=3D127.0.0.1)

As long as the swapfile is not on nfs, I am ok to swapon:
/mnt # swapon swapfile
[ 1150.302641] Adding 65532k swap on /mnt/swapfile.  Priority:-2
extents:1 across:65532k

Anything I am missing?

>
> # xfstests-dev is a checked out and built xfstests repo
> ~/xfstests-dev/src/usemem 1024
>
> The backtrace is at the end of the mail.
>
> > I'd
> > like to reproduce the issue, as the mm code only supports mTHP
> > swapout on block devices. What is your swap device or swap file?
>
> The above swap f=D1=96le on NFS is the only swap in the system
>
> > Additionally, on what kind of filesystem is the executable file built
> > from usemem.c located?
>
> Doesn't matter.  I've tried xfs, ext4 and nfs itself.
>
> root@testvm:~# ./xfstests-dev/src/usemem 1024
> [   65.065292] ------------[ cut here ]------------
> [   65.065528] kernel BUG at fs/nfs/direct.c:144!
> [   65.065724] Oops: invalid opcode: 0000 [#1] PREEMPT SMP NOPTI
> [   65.065988] CPU: 0 PID: 71 Comm: kswapd0 Not tainted 6.10.0-rc3+ #2587
> [   65.066270] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIO=
S 1.16.3-debian-1.16.3-2 04/01/2014
> [   65.066683] RIP: 0010:nfs_swap_rw+0x3f/0x50
> [   65.066893] Code: 00 00 74 13 e8 e2 fb ff ff 31 d2 48 85 c0 48 0f 4f c=
2 c3 cc cc cc cc e8 9f f8 ff ff 31 0
> [   65.067698] RSP: 0018:ffffc900001b79c8 EFLAGS: 00010206
> [   65.067949] RAX: ffffffff8162afc0 RBX: ffff88800ca24c00 RCX: 000000000=
0000004
> [   65.068274] RDX: ffff88800ca24c30 RSI: ffffc900001b79d0 RDI: ffff88800=
ca24c00
> [   65.068588] RBP: ffff88800dd710e8 R08: 0000000000004000 R09: 000000000=
0000010
> [   65.068911] R10: 0000000000035a40 R11: 000000000000001d R12: ffffc9000=
01b7a78
> [   65.069225] R13: ffffc900001b7db0 R14: ffffc900001b7a68 R15: ffffea000=
03f1c40
> [   65.069542] FS:  0000000000000000(0000) GS:ffff88803ec00000(0000) knlG=
S:0000000000000000
> [   65.069904] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   65.070157] CR2: 00005606ddec4dd0 CR3: 000000000365a003 CR4: 000000000=
0770ef0
> [   65.070472] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 000000000=
0000000
> [   65.070784] DR3: 0000000000000000 DR6: 00000000ffff07f0 DR7: 000000000=
0000400
> [   65.071282] PKRU: 55555554
> [   65.071407] Call Trace:
> [   65.071519]  <TASK>
> [   65.071619]  ? die+0x31/0x80
> [   65.071754]  ? do_trap+0xd7/0x100
> [   65.071915]  ? do_error_trap+0x65/0x90
> [   65.072084]  ? nfs_swap_rw+0x3f/0x50
> [   65.072247]  ? exc_invalid_op+0x50/0x70
> [   65.072420]  ? nfs_swap_rw+0x3f/0x50
> [   65.072581]  ? asm_exc_invalid_op+0x1a/0x20
> [   65.072770]  ? __pfx_nfs_swap_rw+0x10/0x10
> [   65.072966]  ? nfs_swap_rw+0x3f/0x50
> [   65.073125]  swap_write_unplug+0x57/0x90
> [   65.073307]  shrink_folio_list+0x3a1/0xed0
> [   65.073500]  ? __mod_zone_page_state+0x61/0xa0
> [   65.073700]  ? isolate_lru_folios+0x2f3/0x400
> [   65.073902]  shrink_lruvec+0x587/0xb60
> [   65.074071]  ? shrink_slab+0x3ad/0x3c0
> [   65.074239]  ? shrink_slab+0x3ad/0x3c0
> [   65.074408]  shrink_node+0x2b7/0x7e0
> [   65.074569]  balance_pgdat+0x291/0x6f0

