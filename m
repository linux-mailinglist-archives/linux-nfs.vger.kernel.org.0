Return-Path: <linux-nfs+bounces-2041-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C5E1585D266
	for <lists+linux-nfs@lfdr.de>; Wed, 21 Feb 2024 09:20:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F855284AE4
	for <lists+linux-nfs@lfdr.de>; Wed, 21 Feb 2024 08:20:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76C873BB34;
	Wed, 21 Feb 2024 08:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=smartx-com.20230601.gappssmtp.com header.i=@smartx-com.20230601.gappssmtp.com header.b="Yg7xS3CF"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lj1-f194.google.com (mail-lj1-f194.google.com [209.85.208.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 401E13BB21
	for <linux-nfs@vger.kernel.org>; Wed, 21 Feb 2024 08:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708503620; cv=none; b=TUGFi0FYkk4Ci+8S0Af4awsTbU0JgntGhLTWQMSIZkTSQOR0tnV8oZILDFbLKzCEJVGjlkXSmFfD2CZogz+Ya76bzfpvJHKiJeVqfSLvTRp6Fu4/2b5t+rLInPALWt96Y9ZRmQEGHN1k94f43gOyU8H6FdeImstHI0we98dmzVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708503620; c=relaxed/simple;
	bh=Um5+f0FrZXtSaIH4pDGP51HZ/k5cYcZctwOZ85WPZXI=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=hKrMGVxinJLeA67UJq54c9ef+px2qkMfp+hZdrnuxbfAAhTlCWfFZZmAEfe3KAS1dakGfxQqvfjhT08YfnM6/aw0eAJ61S7+ODGTmfqZSdUzvBVXbrE+UzsHIpg7+dzOwpoutT7E9ArS9qHP26DZQgHHGcrmcHcwXmBQKYANm0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=smartx.com; spf=none smtp.mailfrom=smartx.com; dkim=pass (2048-bit key) header.d=smartx-com.20230601.gappssmtp.com header.i=@smartx-com.20230601.gappssmtp.com header.b=Yg7xS3CF; arc=none smtp.client-ip=209.85.208.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=smartx.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=smartx.com
Received: by mail-lj1-f194.google.com with SMTP id 38308e7fff4ca-2d0a4e1789cso3424871fa.3
        for <linux-nfs@vger.kernel.org>; Wed, 21 Feb 2024 00:20:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1708503616; x=1709108416; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MysAWxNbCc//vI31BIPucjF70SlQY+heO/NoaZw6Ql0=;
        b=Yg7xS3CFYTRmwGdoznfV03gBYlzWeVYBuJDYIY9p++62+//JEA/piPCIEZc1ywA/5L
         QTBELrLGL/kmhsGf+l3s1vjd/WIsswkDl/MO2Oyq/moNjsDK7kfptQBV8LLbaxZ03wrT
         vRldgqVmkP98M9MSr1gy2/z4A/pSxJ0gKfqerV93pAxhY0ssd/eT4mLXTr1cUwk6+r+T
         AR+cng8Os3grgQjVy8mnXz3i+vD+d36KPQBrnNgJRwbidqCOIhMkkQvLzz4JMCBX1rjj
         UWUoMj6xXjMXCQzheqzxs6J4l+hFEENDssvngNU17ksbHgkVfKdTLabhvkLa8GwrmRYH
         fo3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708503616; x=1709108416;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MysAWxNbCc//vI31BIPucjF70SlQY+heO/NoaZw6Ql0=;
        b=Vhz4rN7abKc674QBsWFR8LsK8poGMs0iah80pg91Vao4qNDEsSSM1tRrAbaG5be3Kx
         T6spNzzmdiHe8V6NT7O6gt/wIJAAQrQKLoRBeoJ6lbaOBtf56z9EATkYUgls1Vv2Zw+A
         NAy2EfaawrpoeKtuPZTHZIv6gfss7jCqrB2r/qDGKFe1zeB8e+JwkrPG/Ia/mEsb3NcX
         Y+D+8Jh4fAe0ZpBNqUt37SpkBmUY4XpJmEHwupv4Luf1KSRTTvwxq8+iv3Ngk0ZCePgw
         CixeJnHpfrzGKW0Anbrhm8MKeJ+pqE/3FVS8F0Zxj6aDkRn7sT4U6s6bnAyp+YgJ289+
         MTbg==
X-Gm-Message-State: AOJu0YzIwutzKRWVFg6UR6zyVd4316/7ld0O+y4/TAi4/ujr4UvORGmO
	ANxfnZb0qTvEG5Jvo5zJ7eSaL4abNYq3wa/hUvNZf6k5OyzzpQ+pyt6FdHD3V9/g6jQHiB9L+T8
	XDgFsHd9HGObjeehcWeBQvaNpTvJAqzj+2JZSqA==
X-Google-Smtp-Source: AGHT+IG8BAQ2Gu7OHNA4ftEbbbJU0FZLf8ClOhtXCEcoK/cXoZTQ08otPgZ5OHMjQYFAHngVnpgUaRS9PGRBqGW2S08=
X-Received: by 2002:a2e:9790:0:b0:2d2:3db6:b168 with SMTP id
 y16-20020a2e9790000000b002d23db6b168mr4391133lji.14.1708503615614; Wed, 21
 Feb 2024 00:20:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Zhitao Li <zhitao.li@smartx.com>
Date: Wed, 21 Feb 2024 16:20:02 +0800
Message-ID: <CAPKjjnrYvzH8hEk9boaBt-fETX3VD2cjjN-Z6iNgwZpHqYUjWw@mail.gmail.com>
Subject: PROBLEM: NFS client IO fails with ERESTARTSYS when another mount
 point with the same export is unmounted with force [NFS] [SUNRPC]
To: Trond Myklebust <trond.myklebust@hammerspace.com>, Anna Schumaker <anna@kernel.org>, 
	Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>, Neil Brown <neilb@suse.de>, 
	Olga Kornievskaia <kolga@netapp.com>, Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Ping Huang <huangping@smartx.com>
Content-Type: text/plain; charset="UTF-8"

Hi, everyone,

- Facts:
I have a remote NFS export and I mount the same export on two
different directories in my OS with the same options. There is an
inflight IO under one mounted directory. And then I unmount another
mounted directory with force. The inflight IO ends up with "Unknown
error 512", which is ERESTARTSYS.

OS: Linux kernel v6.7.0
NFS mount options: vers=4.1


- My speculation:
When the same export is mounted on different directories with the same
options, superblock and sunrpc_client will be shared. Unmount with
force will kill all rpc_tasks with ERESTARTSYS in rpc_killall_tasks().
However, no signal gets involved in this case. So ERESTARTSYS is not
handled before entering user mode.

I think there are two unexpected points here:
1. The inflight IO should not fail when I unmount another directory,
though the two directories share the same export.
2. "ERESTARTSYS" should not be seen in user space. EIO may be better.


- Reproduction:
1. Prepare some NFS export, nfsd or nfs-ganesha. For example, the
export is "ip:/export_path".
2. On the latest stable mainstream Linux kernel v6.7.0, mount the
export into two different directories with the same options:
      mount -t nfs -o vers=4.1 ip:/export_path  /mnt/test1
      mount -t nfs -o vers=4.1 ip:/export_path  /mnt/test2
3. Start an inflight IO in "/mnt/test1":
      dd if=/dev/urandom of=/mnt/test1/1G bs=1M count=1024 oflag=direct
4. Umount "/mnt/test2" with force when IO in step 3 is going:
      umount -f /mnt/test2
5. The "dd" is expected to fail with following information:
       # dd if=/dev/urandom of=/mnt/test1/1G bs=1M count=1024 oflag=direct
       dd: error writing '/mnt/test1/1G': Unknown error 512
       214+0 records in
       213+0 records out
       223346688 bytes (223 MB, 213 MiB) copied, 7.87017 s, 28.4 MB/s.


- Helpful links
1. v6.7.0 rpc_killall_tasks():
https://elixir.bootlin.com/linux/v6.7/source/net/sunrpc/clnt.c#L869
2. COMMIT "SUNRPC: Fix up task signalling v5.2-rc1" changes the error
code of rpc_tasks in rpc_killall_tasks() from EIO to ERESTARTSYS. The
link is https://github.com/torvalds/linux/commit/ae67bd3821bb0a54d97e7883d211196637d487a9?diff=split&w=0


Looking forward to your early reply :)

Best regards,
Zhitao Li, in SmartX.

