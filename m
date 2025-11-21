Return-Path: <linux-nfs+bounces-16645-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 33197C78228
	for <lists+linux-nfs@lfdr.de>; Fri, 21 Nov 2025 10:25:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C9161343347
	for <lists+linux-nfs@lfdr.de>; Fri, 21 Nov 2025 09:23:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6546342532;
	Fri, 21 Nov 2025 09:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HRiQS1/b"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AA5C33F8B4
	for <linux-nfs@vger.kernel.org>; Fri, 21 Nov 2025 09:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763716826; cv=none; b=jGckprRBpLyc/FwYDNfqnn8ZogbgrkXxyVOrptORtX1RmYKC7njgsl3MlEC1jfNywCwtcA9go40H+daPfk+j0OqhFXb6yxDXrS/nE8bS+TdV6uq2TMeXUW/xvN2ZK4DkZqmtC+hOhdHD0Gu2KC7vXin82Mc0ka49LR95OFG8kxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763716826; c=relaxed/simple;
	bh=jDzPnXsAcrWJ6827o6/zByB4qjKEdXy4ClFgclKRLrs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lYGWqLSoC0MaGKovQgH+DdYiQ8wmUf1jB3vPfMKWryd6Gb58/NrQIiawV8XQzFmjLoIui6LJM99KFrRWS7dV2W7oWFyNM3dPMU2BvkjHUxz4jSxqFD0jdWfmH8RcXVEVaA8ZMyTLR7Bwd3y91n92ehiNHIPF6nkE8AdBVSgE+iI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HRiQS1/b; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b713c7096f9so290723266b.3
        for <linux-nfs@vger.kernel.org>; Fri, 21 Nov 2025 01:20:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763716823; x=1764321623; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=szpgBIBgsaLz6eiBUSfZt06vD62hmWvhuPoyx2+xahQ=;
        b=HRiQS1/bCoG8nuy6Sj2Dadem05M00ALndxMf+7l58MZ3buNr0wVbgpYX6DqyxUWtn9
         wyeAu4kHIjl9pOZ0cA/CGBoxBZVSUtqz9M8gEVC4rSglZKv/6Emlti1qxGBqZQikx+s6
         NxTlqNqwLxWzYo4Kdec0ztXLwhmPq4DL5zakghngnlTFSXRuDRk7cUhAmt2cs24ieed/
         fEM+M1Bf32IfBsioJfkM7P2L1E4QS1WY7j0TZ+NyMuJIkJPHc1fx7R79/9JReGVCZvC3
         uVC2Gsspc8ilAzWOFAekbtmpPHUOkhEAFLrXaiXGvUaqrWdw1xKNrgIU/e6anzZGRvXf
         7cmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763716823; x=1764321623;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=szpgBIBgsaLz6eiBUSfZt06vD62hmWvhuPoyx2+xahQ=;
        b=QzKxx2cKt0yEa+uCSxtPkm53l4SH+bo/IYZ3sJYrQaNlBBMGLoRC83c8UbOWgXa8sn
         Wx0aHBiufG2h6snYWvTAN4qYAa9IVrI6iXmbz59hEGL3PEzkGteQA0IJ3GtV7ijc5iSu
         kj9pqB51wU1afC/2mMI17xXFgjQEodr4aATdcFjlugVnQDglY4CwBKJHcZbxq0NYXzru
         a8Abj2nBtg01yG2wxBfEemTVAcknajLs/q68TnU0BRjsOLP9ABCUloOsHSNbOPManjlL
         NCpRkv0hPcFG1CF+UG4l6SGfz6+jvs1p2ozOg1/As1ywPRR5zxB4OZB3HIEWi9PiYrRO
         v5Mg==
X-Forwarded-Encrypted: i=1; AJvYcCUGM58MhLXHGkd6bG6TEmJgUccbuAh/COYyO6DnA9b4D/6j/qimmUiPHXFUaiVLAD5KWkFojgLt3P8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZWK5d22yqDr6OUAJANN9nMkCEBmduUQf+4eFvGy602Zu/hWCG
	+fmhqvdwXJ6BLeT6EuA2vlexWd5Aa2erEzpbfawtqSH7c8HZUaqjuERxsiQJFqbwPcev3PF6wvf
	3cLdaeQR/+N/+9GgQROOZO8P0MKN1DG4=
X-Gm-Gg: ASbGnctFVSsYzkVk4CFxnswPkf7P1T5BQZpC6g+ZpFN6aSWEviAog6SYKrp/We+Xnn5
	JDi2wPVQPxAu2EWCUPanqqfhmexbgrUL3otTEVCZoj8PDHV8/q16NBdZpGqq2o8TlFvKSLMHybB
	qmao9WmvjntJXbQT+bmjgWQgYVw2Ms2U9jEUFDUNNwailZDCmujKA8Ywt11i0jqb/06qa8yxpnQ
	qHFYtUJNP1K6cKxytI3YRr3grcUO7NQdf0nsxbA8IQRxb7X8IM9Wzg/dEl/Joaa5YSWx9Pa
X-Google-Smtp-Source: AGHT+IFh1S/U6tzBt1cINd8qAe3t+spvP5+Tro7AKiZmiuxBtTSP83Fl5DNJiuAk1r9oqLBk6FflyjszzM/O+lERnGQ=
X-Received: by 2002:a17:907:3f1b:b0:b73:544d:b963 with SMTP id
 a640c23a62f3a-b767159e21amr157078466b.13.1763716822363; Fri, 21 Nov 2025
 01:20:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251111145932.23784-1-cel@kernel.org> <20251111145932.23784-4-cel@kernel.org>
In-Reply-To: <20251111145932.23784-4-cel@kernel.org>
From: Anton Gavriliuk <antosha20xx@gmail.com>
Date: Fri, 21 Nov 2025 11:20:11 +0200
X-Gm-Features: AWmQ_blMKlxhomnsM5b2pwVw0OtB4JDe9vJmMKjr7Jp-vGZNx79HgsLEata8gKQ
Message-ID: <CAAiJnjrE2TOxFvkGiq3g17795nFvA+wFZTddOpu4KiUz2_7i8Q@mail.gmail.com>
Subject: Re: [PATCH v12 3/3] NFSD: add Documentation/filesystems/nfs/nfsd-io-modes.rst
To: Chuck Lever <cel@kernel.org>
Cc: NeilBrown <neil@brown.name>, Jeff Layton <jlayton@kernel.org>, 
	Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>, 
	linux-nfs@vger.kernel.org, Mike Snitzer <snitzer@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> +If you experiment with NFSD's IO modes on a recent kernel and have
> +interesting results, please report them to linux-nfs@vger.kernel.org

Hello

There are two physical boxes - NFS server and client, directly
connected via 4x200 Gb/s ConnectX-7 ports.
Rocky Linux 10 on both boxes, on NFS server kernel 6.18.0-rc6, on NFS
client kernel 6.12.0-55.41.1.el10_0.x86_64
Both boxes have 192 GB DRAM.
On the NFS server there are 6 x CM7-V 5.0 NVMe SSD in mdadm raid0.
Thanks to DMA, locally I'm able to read the file 87 GB/s,

[root@memverge4 ~]# fio --name=3Dlocal_test --ioengine=3Dlibaio --rw=3Dread
--bs=3D3072K --numjobs=3D1 --direct=3D1 --filename=3D/mnt/testfile
--iodepth=3D32
local_test: (g=3D0): rw=3Dread, bs=3D(R) 3072KiB-3072KiB, (W)
3072KiB-3072KiB, (T) 3072KiB-3072KiB, ioengine=3Dlibaio, iodepth=3D32
fio-3.41-41-gf5b2
Starting 1 process
Jobs: 1 (f=3D1): [R(1)][100.0%][r=3D81.2GiB/s][r=3D27.7k IOPS][eta 00m:00s]
local_test: (groupid=3D0, jobs=3D1): err=3D 0: pid=3D14009: Fri Nov 21 09:5=
5:00 2025
  read: IOPS=3D27.7k, BW=3D81.1GiB/s (87.1GB/s)(512GiB/6313msec)
    slat (usec): min=3D4, max=3D1006, avg=3D 6.56, stdev=3D 5.34
    clat (usec): min=3D275, max=3D4653, avg=3D1148.62, stdev=3D32.32
     lat (usec): min=3D300, max=3D5659, avg=3D1155.19, stdev=3D33.71

On the NFS client share mounted with the next options,

[root@memverge3 ~]# mount -t nfs -o proto=3Drdma,nconnect=3D16,vers=3D3
1.1.1.4:/mnt /mnt

All caches (on server and client) are cleared using "sync; echo 3 >
/proc/sys/vm/drop_caches".
On the NFS server /sys/kernel/debug/nfsd/io_cache_read default value 0.

[root@memverge3 ~]# fio --name=3Dlocal_test --ioengine=3Dlibaio --rw=3Dread
--bs=3D3072K --numjobs=3D1 --direct=3D1 --filename=3D/mnt/testfile
--iodepth=3D32
local_test: (g=3D0): rw=3Dread, bs=3D(R) 3072KiB-3072KiB, (W)
3072KiB-3072KiB, (T) 3072KiB-3072KiB, ioengine=3Dlibaio, iodepth=3D32
fio-3.41-45-g7c8d
Starting 1 process
Jobs: 1 (f=3D1): [R(1)][100.0%][r=3D2865MiB/s][r=3D955 IOPS][eta 00m:00s]
local_test: (groupid=3D0, jobs=3D1): err=3D 0: pid=3D141930: Fri Nov 21 10:=
04:08 2025
  read: IOPS=3D1723, BW=3D5170MiB/s (5421MB/s)(512GiB/101408msec)
    slat (usec): min=3D84, max=3D528, avg=3D147.91, stdev=3D29.89
    clat (usec): min=3D950, max=3D116978, avg=3D18419.36, stdev=3D11746.45
     lat (usec): min=3D1082, max=3D117116, avg=3D18567.27, stdev=3D11729.90

All caches (on server and client) are cleared using "sync; echo 3 >
/proc/sys/vm/drop_caches".
On the NFS server /sys/kernel/debug/nfsd/io_cache_read default value 2.

[root@memverge3 ~]# fio --name=3Dlocal_test --ioengine=3Dlibaio --rw=3Dread
--bs=3D3072K --numjobs=3D1 --direct=3D1 --filename=3D/mnt/testfile
--iodepth=3D32
local_test: (g=3D0): rw=3Dread, bs=3D(R) 3072KiB-3072KiB, (W)
3072KiB-3072KiB, (T) 3072KiB-3072KiB, ioengine=3Dlibaio, iodepth=3D32
fio-3.41-45-g7c8d
Starting 1 process
Jobs: 1 (f=3D1): [R(1)][100.0%][r=3D16.9GiB/s][r=3D5770 IOPS][eta 00m:00s]
local_test: (groupid=3D0, jobs=3D1): err=3D 0: pid=3D142151: Fri Nov 21 10:=
07:36 2025
  read: IOPS=3D5803, BW=3D17.0GiB/s (18.3GB/s)(512GiB/30111msec)
    slat (usec): min=3D58, max=3D468, avg=3D171.72, stdev=3D15.26
    clat (usec): min=3D264, max=3D9284, avg=3D5340.71, stdev=3D141.85
     lat (usec): min=3D455, max=3D9748, avg=3D5512.42, stdev=3D145.54

3+x times improvement!!

Now let's take a look at NFS client side, why can't I exceed 20 GB/s ?

It looks that the fio thread most of time spends on the cpu executing
next kernel functions,

    HARDCLOCK entries
       Count     Pct  State  Function
         384  38.40%  SYS    nfs_page_create_from_page
         142  14.20%  SYS    nfs_get_lock_context
         109  10.90%  SYS    __nfs_pageio_add_request
          70   7.00%  SYS    refcount_dec_and_lock
          64   6.40%  SYS    nfs_page_create
          58   5.80%  SYS    nfs_direct_read_schedule_iovec
          39   3.90%  SYS    nfs_pageio_add_request
          38   3.80%  SYS    kmem_cache_alloc_noprof
          13   1.30%  SYS    rpc_execute
          12   1.20%  SYS    nfs_generic_pg_pgios
          10   1.00%  SYS    get_partial_node.part.0
          10   1.00%  SYS    rmqueue_bulk
          10   1.00%  SYS    nfs_generic_pgio
           8   0.80%  SYS    gup_fast_fallback
           6   0.60%  SYS    xprt_iter_next_entry_roundrobin
           4   0.40%  SYS    allocate_slab
           4   0.40%  SYS    nfs_file_direct_read
           3   0.30%  SYS    rpc_task_set_transport
           2   0.20%  SYS    __get_random_u32_below
           2   0.20%  SYS    nfs_pgheader_init

       Count     Pct  HARDCLOCK Stack trace
       =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
         384  38.40%  nfs_page_create_from_page
nfs_direct_read_schedule_iovec  nfs_file_direct_read  aio_read
io_submit_one  __x64_sys_io_submit  do_syscall_64
entry_SYSCALL_64_after_hwframe  |  syscall
         141  14.10%  nfs_get_lock_context  nfs_page_create_from_page
nfs_direct_read_schedule_iovec  nfs_file_direct_read  aio_read
io_submit_one  __x64_sys_io_submit  do_syscall_64
entry_SYSCALL_64_after_hwframe  |  syscall
         109  10.90%  __nfs_pageio_add_request  nfs_pageio_add_request
 nfs_direct_read_schedule_iovec  nfs_file_direct_read  aio_read
io_submit_one  __x64_sys_io_submit  do_syscall_64
entry_SYSCALL_64_after_hwframe  |  syscall
          70   7.00%  refcount_dec_and_lock  nfs_put_lock_context
nfs_page_create_from_page  nfs_direct_read_schedule_iovec
nfs_file_direct_read  aio_read io_submit_one  __x64_sys_io_submit
do_syscall_64  entry_SYSCALL_64_after_hwframe  |  syscall
          64   6.40%  nfs_page_create  nfs_page_create_from_page
nfs_direct_read_schedule_iovec  nfs_file_direct_read  aio_read
io_submit_one  __x64_sys_io_submit  do_syscall_64
entry_SYSCALL_64_after_hwframe  |  syscall
          58   5.80%  nfs_direct_read_schedule_iovec
nfs_file_direct_read  aio_read  io_submit_one  __x64_sys_io_submit
do_syscall_64  entry_SYSCALL_64_after_hwframe  |  syscall
          39   3.90%  nfs_pageio_add_request
nfs_direct_read_schedule_iovec  nfs_file_direct_read  aio_read
io_submit_one  __x64_sys_io_submit  do_syscall_64
entry_SYSCALL_64_after_hwframe  |  syscall
          36   3.60%  kmem_cache_alloc_noprof  nfs_page_create
nfs_page_create_from_page  nfs_direct_read_schedule_iovec
nfs_file_direct_read  aio_read  io_submit_one  __x64_sys_io_submit
do_syscall_64  entry_SYSCALL_64_after_hwframe  |  syscall

Even if I created and added 2M huge pages as fio's backing page size
(adding --mem=3Dmmaphuge --hugepage-size=3D2m), there is still
distribution as shown above.

I might be wrong, but even with fio's huge pages, the standard
upstream NFS client creates a struct nfs_page for every 4K chunk
(page_size), regardless of the backing page size.

Could 2M huge pages be implemented for NFS client ??, it would even
more improve performance using NFSD direct reads.

Anton

=D0=B2=D1=82, 11 =D0=BD=D0=BE=D1=8F=D0=B1. 2025=E2=80=AF=D0=B3. =D0=B2 17:0=
9, Chuck Lever <cel@kernel.org>:
>
> From: Mike Snitzer <snitzer@kernel.org>
>
> This document details the NFSD IO modes that are configurable using
> NFSD's experimental debugfs interfaces:
>
>   /sys/kernel/debug/nfsd/io_cache_read
>   /sys/kernel/debug/nfsd/io_cache_write
>
> This document will evolve as NFSD's interfaces do (e.g. if/when NFSD's
> debugfs interfaces are replaced with per-export controls).
>
> Future updates will provide more specific guidance and howto
> information to help others use and evaluate NFSD's IO modes:
> BUFFERED, DONTCACHE and DIRECT.
>
> Signed-off-by: Mike Snitzer <snitzer@kernel.org>
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  .../filesystems/nfs/nfsd-io-modes.rst         | 144 ++++++++++++++++++
>  1 file changed, 144 insertions(+)
>  create mode 100644 Documentation/filesystems/nfs/nfsd-io-modes.rst
>
> diff --git a/Documentation/filesystems/nfs/nfsd-io-modes.rst b/Documentat=
ion/filesystems/nfs/nfsd-io-modes.rst
> new file mode 100644
> index 000000000000..e3a522d09766
> --- /dev/null
> +++ b/Documentation/filesystems/nfs/nfsd-io-modes.rst
> @@ -0,0 +1,144 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +NFSD IO MODES
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Overview
> +=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +NFSD has historically always used buffered IO when servicing READ and
> +WRITE operations. BUFFERED is NFSD's default IO mode, but it is possible
> +to override that default to use either DONTCACHE or DIRECT IO modes.
> +
> +Experimental NFSD debugfs interfaces are available to allow the NFSD IO
> +mode used for READ and WRITE to be configured independently. See both:
> +- /sys/kernel/debug/nfsd/io_cache_read
> +- /sys/kernel/debug/nfsd/io_cache_write
> +
> +The default value for both io_cache_read and io_cache_write reflects
> +NFSD's default IO mode (which is NFSD_IO_BUFFERED=3D0).
> +
> +Based on the configured settings, NFSD's IO will either be:
> +- cached using page cache (NFSD_IO_BUFFERED=3D0)
> +- cached but removed from page cache on completion (NFSD_IO_DONTCACHE=3D=
1)
> +- not cached stable_how=3DNFS_UNSTABLE (NFSD_IO_DIRECT=3D2)
> +
> +To set an NFSD IO mode, write a supported value (0 - 2) to the
> +corresponding IO operation's debugfs interface, e.g.:
> +  echo 2 > /sys/kernel/debug/nfsd/io_cache_read
> +  echo 2 > /sys/kernel/debug/nfsd/io_cache_write
> +
> +To check which IO mode NFSD is using for READ or WRITE, simply read the
> +corresponding IO operation's debugfs interface, e.g.:
> +  cat /sys/kernel/debug/nfsd/io_cache_read
> +  cat /sys/kernel/debug/nfsd/io_cache_write
> +
> +If you experiment with NFSD's IO modes on a recent kernel and have
> +interesting results, please report them to linux-nfs@vger.kernel.org
> +
> +NFSD DONTCACHE
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +DONTCACHE offers a hybrid approach to servicing IO that aims to offer
> +the benefits of using DIRECT IO without any of the strict alignment
> +requirements that DIRECT IO imposes. To achieve this buffered IO is used
> +but the IO is flagged to "drop behind" (meaning associated pages are
> +dropped from the page cache) when IO completes.
> +
> +DONTCACHE aims to avoid what has proven to be a fairly significant
> +limition of Linux's memory management subsystem if/when large amounts of
> +data is infrequently accessed (e.g. read once _or_ written once but not
> +read until much later). Such use-cases are particularly problematic
> +because the page cache will eventually become a bottleneck to servicing
> +new IO requests.
> +
> +For more context on DONTCACHE, please see these Linux commit headers:
> +- Overview:  9ad6344568cc3 ("mm/filemap: change filemap_create_folio()
> +  to take a struct kiocb")
> +- for READ:  8026e49bff9b1 ("mm/filemap: add read support for
> +  RWF_DONTCACHE")
> +- for WRITE: 974c5e6139db3 ("xfs: flag as supporting FOP_DONTCACHE")
> +
> +NFSD_IO_DONTCACHE will fall back to NFSD_IO_BUFFERED if the underlying
> +filesystem doesn't indicate support by setting FOP_DONTCACHE.
> +
> +NFSD DIRECT
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +DIRECT IO doesn't make use of the page cache, as such it is able to
> +avoid the Linux memory management's page reclaim scalability problems
> +without resorting to the hybrid use of page cache that DONTCACHE does.
> +
> +Some workloads benefit from NFSD avoiding the page cache, particularly
> +those with a working set that is significantly larger than available
> +system memory. The pathological worst-case workload that NFSD DIRECT has
> +proven to help most is: NFS client issuing large sequential IO to a file
> +that is 2-3 times larger than the NFS server's available system memory.
> +The reason for such improvement is NFSD DIRECT eliminates a lot of work
> +that the memory management subsystem would otherwise be required to
> +perform (e.g. page allocation, dirty writeback, page reclaim). When
> +using NFSD DIRECT, kswapd and kcompactd are no longer commanding CPU
> +time trying to find adequate free pages so that forward IO progress can
> +be made.
> +
> +The performance win associated with using NFSD DIRECT was previously
> +discussed on linux-nfs, see:
> +https://lore.kernel.org/linux-nfs/aEslwqa9iMeZjjlV@kernel.org/
> +But in summary:
> +- NFSD DIRECT can significantly reduce memory requirements
> +- NFSD DIRECT can reduce CPU load by avoiding costly page reclaim work
> +- NFSD DIRECT can offer more deterministic IO performance
> +
> +As always, your mileage may vary and so it is important to carefully
> +consider if/when it is beneficial to make use of NFSD DIRECT. When
> +assessing comparative performance of your workload please be sure to log
> +relevant performance metrics during testing (e.g. memory usage, cpu
> +usage, IO performance). Using perf to collect perf data that may be used
> +to generate a "flamegraph" for work Linux must perform on behalf of your
> +test is a really meaningful way to compare the relative health of the
> +system and how switching NFSD's IO mode changes what is observed.
> +
> +If NFSD_IO_DIRECT is specified by writing 2 (or 3 and 4 for WRITE) to
> +NFSD's debugfs interfaces, ideally the IO will be aligned relative to
> +the underlying block device's logical_block_size. Also the memory buffer
> +used to store the READ or WRITE payload must be aligned relative to the
> +underlying block device's dma_alignment.
> +
> +But NFSD DIRECT does handle misaligned IO in terms of O_DIRECT as best
> +it can:
> +
> +Misaligned READ:
> +    If NFSD_IO_DIRECT is used, expand any misaligned READ to the next
> +    DIO-aligned block (on either end of the READ). The expanded READ is
> +    verified to have proper offset/len (logical_block_size) and
> +    dma_alignment checking.
> +
> +Misaligned WRITE:
> +    If NFSD_IO_DIRECT is used, split any misaligned WRITE into a start,
> +    middle and end as needed. The large middle segment is DIO-aligned
> +    and the start and/or end are misaligned. Buffered IO is used for the
> +    misaligned segments and O_DIRECT is used for the middle DIO-aligned
> +    segment. DONTCACHE buffered IO is _not_ used for the misaligned
> +    segments because using normal buffered IO offers significant RMW
> +    performance benefit when handling streaming misaligned WRITEs.
> +
> +Tracing:
> +    The nfsd_read_direct trace event shows how NFSD expands any
> +    misaligned READ to the next DIO-aligned block (on either end of the
> +    original READ, as needed).
> +
> +    This combination of trace events is useful for READs:
> +    echo 1 > /sys/kernel/tracing/events/nfsd/nfsd_read_vector/enable
> +    echo 1 > /sys/kernel/tracing/events/nfsd/nfsd_read_direct/enable
> +    echo 1 > /sys/kernel/tracing/events/nfsd/nfsd_read_io_done/enable
> +    echo 1 > /sys/kernel/tracing/events/xfs/xfs_file_direct_read/enable
> +
> +    The nfsd_write_direct trace event shows how NFSD splits a given
> +    misaligned WRITE into a DIO-aligned middle segment.
> +
> +    This combination of trace events is useful for WRITEs:
> +    echo 1 > /sys/kernel/tracing/events/nfsd/nfsd_write_opened/enable
> +    echo 1 > /sys/kernel/tracing/events/nfsd/nfsd_write_direct/enable
> +    echo 1 > /sys/kernel/tracing/events/nfsd/nfsd_write_io_done/enable
> +    echo 1 > /sys/kernel/tracing/events/xfs/xfs_file_direct_write/enable
> --
> 2.51.0
>
>

