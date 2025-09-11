Return-Path: <linux-nfs+bounces-14307-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 552F5B53DC9
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Sep 2025 23:34:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2BF61C251C8
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Sep 2025 21:34:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1239D2D8791;
	Thu, 11 Sep 2025 21:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="aSxuiuzy"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AD4D2C21DD
	for <linux-nfs@vger.kernel.org>; Thu, 11 Sep 2025 21:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757626450; cv=none; b=mahSAo0sTfVknRzJUR9tTWauB6GahMOCbP7PjdC/1kLum9ubHptF1PRDht3859CSUQwdWey/FGZidXeba3ynwhoTMCP1t3LTpbehPUKdrIIChhwW6i3cf6WcGJUrEJZVlUeEjhQ6zobrvxWZ/K008fL10InmikN/VKxD7pSgVrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757626450; c=relaxed/simple;
	bh=d3j34i9sJCMncszw8YOjGibinHf2vnSqpHzXMc64EbI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sjUDTWAeUB1tL03HTfTDfIJwuO6JtyBT0Wqb55TViM1LLpt5KtVoJv71h0BUa9+Gslr4L0mGIM0bXCbFGDabJayz/8qHpUd4cuCqbov2DlcJo5czwdwQECdpK6H8z6D9dZATIyfIQpNK7BT025wYtbiX77KcQj4qOeIz2DFsPwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b=aSxuiuzy; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-337e1ce5dd1so11237161fa.3
        for <linux-nfs@vger.kernel.org>; Thu, 11 Sep 2025 14:34:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1757626445; x=1758231245; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RhENIYCfJpjMQi+doZ363SDoLipO9NvDyiRsphw1CrI=;
        b=aSxuiuzyosa71594M6Dhhmy8u6K2nefXC7yrG/SDhAtZJwfScBA8Wnl5Jw/fkZGnPC
         6iP+H0C2A3/YF/g6X9vySTqFeNJeqxlgOyVUZy3doYkxgF1RtafAwWnPXd0Gbf23732I
         hSQRX2XBVhXRkfpoff/cArQmPpDDmWf/BSiWMUX2ntXSsuKdPDVTNdhGjXLA5wiEX1RU
         jrAfxQO4UHMZdZQ6F91Y5ZzrROrJVRz1YJpclxx2cHTUO94Bp9oiWOvnfrcSBzU6YRtA
         w1JZl8N0drFB72/4CqxX/mOGqN8XTTJEVPgGZTFqFD7MTwrJI4tXwbF7PbO8Y0EI2+ua
         8Hrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757626445; x=1758231245;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RhENIYCfJpjMQi+doZ363SDoLipO9NvDyiRsphw1CrI=;
        b=tqIFGJ5UY4Uapu3BIazjdYi5AmbuHQvV1uewLLVfwMPuH4jES9zGqsQce60QBmGKrM
         7bKxDOtFrmBpul6D0cCv3ygyNCFF5fNsSCTxJb9Aix5viOyMz0uDwC2ckknBSZqDXLyH
         lZ+yM63KpXJoH1nVfTD8k1K+939bljUuXhMNBPFbgyEkVIa+kSOtm0N9OXxi1BnJxPpE
         Z2mErfvqRxxUl7kDlfqLBT+oPFwBI4Wythqp5NvxjFywvpsAWelIrInVrSPebJKN7P7u
         kMzDiO2sciXvOXJWiJcWeO460A+5ZV6QYbAUTgD+B9qcgsfVk0JYnxm838vpR79FwVo1
         H/PA==
X-Gm-Message-State: AOJu0YyOVoBSOpJAJv48Hqf2Anukl/rslJ2fqSqhh3+Ma6CwITRkqrn/
	AQH86BjtaTiae33YHHNse+09mVhSfT+9jYAcOPikhMvjP+2dh+sqyOk2zSwnCy+btYux+OTJPPs
	P4/g55aTNgFR5u6EyAiBFK0+RiYRy1m0=
X-Gm-Gg: ASbGncvU4IPimmBnSier10StVPB6/4Dt/qz7F6sC/Jj/1RyvIc25bzQRjNEJq6KkYUk
	E9AyvbgQjaqL9Sh6X5+a478aRNcVr6GmCONVu63D5uZQQRUo343I5kym0Bv//2b/+G3tfPBBgdL
	nCjhcsN3k7BlOwHDiXc5nl+9llC++5FIcJH+oH8GbL6886pu6QSMjaau96CUFXkAA/QQwDHBoB/
	cKSffQq8l/ykZuzrttSeNDBLPOs59jfoPIx3vsyPg==
X-Google-Smtp-Source: AGHT+IFue5dFMM1amLCgfzMNsuOfMEuvlxEFgVK7dkeLZhjRTlrmy8G/pIS9d9elJifiVKpk+MGnKvc+e+sAOiX/o6s=
X-Received: by 2002:a05:651c:2341:20b0:338:10c9:58a6 with SMTP id
 38308e7fff4ca-3513fc38b9dmr1514641fa.22.1757626444184; Thu, 11 Sep 2025
 14:34:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250821152254.8781-1-cel@kernel.org>
In-Reply-To: <20250821152254.8781-1-cel@kernel.org>
From: Olga Kornievskaia <aglo@umich.edu>
Date: Thu, 11 Sep 2025 17:33:52 -0400
X-Gm-Features: Ac12FXxkvY8h7thf6RJYPyEX_K6ZuJVCMnN58KMrVasRbZZYnK29lEnLz8iQ6RE
Message-ID: <CAN-5tyHxtn=KjR-A3jDU-3Y2B8w2S2pqus7McerCZVpaEG4hcA@mail.gmail.com>
Subject: Re: [RFC PATCH v3] svcrdma: Introduce Receive buffer arenas
To: Chuck Lever <cel@kernel.org>
Cc: linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org, 
	Chuck Lever <chuck.lever@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

When I have this patch it causes the following panic just from doing
"systemctl start nfs-server" followed by
"systemctl stop nfs-server"

[   69.705986] Unable to handle kernel paging request at virtual
address dfff800000000001
[   69.706706] KASAN: null-ptr-deref in range
[0x0000000000000008-0x000000000000000f]
[   69.707299] Mem abort info:
[   69.707514]   ESR =3D 0x0000000096000005
[   69.707787]   EC =3D 0x25: DABT (current EL), IL =3D 32 bits
[   69.708186]   SET =3D 0, FnV =3D 0
[   69.708415]   EA =3D 0, S1PTW =3D 0
[   69.708637]   FSC =3D 0x05: level 1 translation fault
[   69.708986] Data abort info:
[   69.709203]   ISV =3D 0, ISS =3D 0x00000005, ISS2 =3D 0x00000000
[   69.709604]   CM =3D 0, WnR =3D 0, TnD =3D 0, TagAccess =3D 0
[   69.709986]   GCS =3D 0, Overlay =3D 0, DirtyBit =3D 0, Xs =3D 0
[   69.710345] [dfff800000000001] address between user and kernel address r=
anges
[   69.710842] Internal error: Oops: 0000000096000005 [#1]  SMP
[   69.711207] Modules linked in: rpcrdma rdma_cm iw_cm ib_cm ib_core
nfsd nfs_acl lockd grace nfs_localio ext4 crc16 mbcache jbd2 overlay
isofs uinput snd_seq_dummy snd_hrtimer qrtr rfkill vfat fat uvcvideo
videobuf2_vmalloc videobuf2_memops snd_hda_codec_generic uvc
videobuf2_v4l2 videobuf2_common e1000e snd_hda_intel videodev
snd_intel_dspcfg snd_hda_codec mc snd_hda_core snd_hwdep snd_seq
snd_seq_device snd_pcm snd_timer snd soundcore sg auth_rpcgss loop
dm_multipath sunrpc dm_mod nfnetlink vsock_loopback
vmw_vsock_virtio_transport_common vmw_vsock_vmci_transport vmw_vmci
vsock xfs nvme sr_mod nvme_core cdrom ghash_ce nvme_keyring nvme_auth
vmwgfx drm_ttm_helper ttm fuse
[   69.715331] CPU: 2 UID: 0 PID: 204 Comm: kworker/2:1 Kdump: loaded
Not tainted 6.17.0-rc4+ #3 PREEMPT(voluntary)
[   69.716036] Hardware name: VMware, Inc. VMware20,1/VBSA, BIOS
VMW201.00V.24006586.BA64.2406042154 06/04/2024
[   69.716751] Workqueue: events __svc_rdma_free [rpcrdma]
[   69.717100] pstate: 01400005 (nzcv daif +PAN -UAO -TCO +DIT -SSBS BTYPE=
=3D--)
[   69.717483] pc : xas_start+0x74/0x260
[   69.717756] lr : xas_load+0x18/0x208
[   69.717972] sp : ffff800088287910
[   69.718182] x29: ffff800088287910 x28: 000000000000002c x27: ffff000098c=
a3c78
[   69.718625] x26: 1ffff00011050f62 x25: ffff800088287a08 x24: fffffffffff=
fffff
[   69.719067] x23: 0000000000000000 x22: ffff800088287a18 x21: 1ffff000110=
50f43
[   69.719504] x20: 0000000000000000 x19: ffff800088287a00 x18: 00000000000=
00000
[   69.719928] x17: 302e3a3a06000000 x16: 3670637404000000 x15: 03000000a38=
60100
[   69.720362] x14: 0000000000000000 x13: 0000003001000000 x12: ffff600015a=
36265
[   69.720800] x11: 1fffe00015a36264 x10: ffff600015a36264 x9 : ffff8000828=
78150
[   69.721241] x8 : ffff700011050f3c x7 : ffff8000882879e0 x6 : 00000000f3f=
3f3f3
[   69.721674] x5 : 0000000000000000 x4 : dfff800000000000 x3 : 1fffe000132=
01657
[   69.722112] x2 : 0000000000000001 x1 : dfff800000000000 x0 : 00000000000=
00008
[   69.722567] Call trace:
[   69.722733]  xas_start+0x74/0x260 (P)
[   69.722996]  xas_load+0x18/0x208
[   69.723193]  xas_find+0x288/0x440
[   69.723385]  xa_find+0x160/0x1a0
[   69.723572]  rpcrdma_pool_destroy+0xb0/0x480 [rpcrdma]
[   69.724164]  svc_rdma_recv_ctxts_destroy+0x54/0x78 [rpcrdma]
[   69.724550]  __svc_rdma_free+0xd0/0x288 [rpcrdma]
[   69.724842]  process_one_work+0x584/0x1050
[   69.725093]  worker_thread+0x4c4/0xc80
[   69.725295]  kthread+0x2f8/0x398
[   69.725468]  ret_from_fork+0x10/0x20
[   69.725666] Code: d2d00001 f2fbffe1 91002280 d343fc02 (38e16841)
[   69.725988] SMP: stopping secondary CPUs
[   69.727548] Starting crashdump kernel...
[   69.727781] Bye!

On Thu, Aug 21, 2025 at 11:35=E2=80=AFAM Chuck Lever <cel@kernel.org> wrote=
:
>
> From: Chuck Lever <chuck.lever@oracle.com>
>
> Reduce the per-connection footprint in the host's and RNIC's memory
> management TLBs by combining groups of a connection's Receive
> buffers into fewer IOVAs.
>
> I don't have a good way to measure whether this approach is
> effective.
>
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  include/linux/sunrpc/svc_rdma.h         |   3 +
>  include/trace/events/rpcrdma.h          |  99 ++++++++++
>  net/sunrpc/xprtrdma/Makefile            |   2 +-
>  net/sunrpc/xprtrdma/pool.c              | 241 ++++++++++++++++++++++++
>  net/sunrpc/xprtrdma/pool.h              |  20 ++
>  net/sunrpc/xprtrdma/svc_rdma_recvfrom.c |  45 ++---
>  6 files changed, 380 insertions(+), 30 deletions(-)
>  create mode 100644 net/sunrpc/xprtrdma/pool.c
>  create mode 100644 net/sunrpc/xprtrdma/pool.h
>
> Changes since v2:
> - Allocate the shard buffer with alloc_pages instead of kmalloc
> - Simplify the synopsis of rpcrdma_pool_create
> - rpcrdma_pool_buffer_alloc now initializes the RECV's ib_sge
> - Added a "sync_for_cpu" API
>
> Changes since v1:
> - Rename "chunks" to "shards" -- RPC/RDMA already has chunks
> - Replace pool's list of shards with an xarray
> - Implement bitmap-based shard free space management
> - Implement some naive observability
>
> diff --git a/include/linux/sunrpc/svc_rdma.h b/include/linux/sunrpc/svc_r=
dma.h
> index 22704c2e5b9b..b4f3c01f1b94 100644
> --- a/include/linux/sunrpc/svc_rdma.h
> +++ b/include/linux/sunrpc/svc_rdma.h
> @@ -73,6 +73,8 @@ extern struct percpu_counter svcrdma_stat_recv;
>  extern struct percpu_counter svcrdma_stat_sq_starve;
>  extern struct percpu_counter svcrdma_stat_write;
>
> +struct rpcrdma_pool;
> +
>  struct svcxprt_rdma {
>         struct svc_xprt      sc_xprt;           /* SVC transport structur=
e */
>         struct rdma_cm_id    *sc_cm_id;         /* RDMA connection id */
> @@ -112,6 +114,7 @@ struct svcxprt_rdma {
>         unsigned long        sc_flags;
>         struct work_struct   sc_work;
>
> +       struct rpcrdma_pool  *sc_recv_pool;
>         struct llist_head    sc_recv_ctxts;
>
>         atomic_t             sc_completion_ids;
> diff --git a/include/trace/events/rpcrdma.h b/include/trace/events/rpcrdm=
a.h
> index e6a72646c507..8bc713082c1a 100644
> --- a/include/trace/events/rpcrdma.h
> +++ b/include/trace/events/rpcrdma.h
> @@ -2336,6 +2336,105 @@ DECLARE_EVENT_CLASS(rpcrdma_client_register_class=
,
>  DEFINE_CLIENT_REGISTER_EVENT(rpcrdma_client_register);
>  DEFINE_CLIENT_REGISTER_EVENT(rpcrdma_client_unregister);
>
> +TRACE_EVENT(rpcrdma_pool_create,
> +       TP_PROTO(
> +               unsigned int poolid,
> +               size_t bufsize
> +       ),
> +
> +       TP_ARGS(poolid, bufsize),
> +
> +       TP_STRUCT__entry(
> +               __field(unsigned int, poolid)
> +               __field(size_t, bufsize)
> +       ),
> +
> +       TP_fast_assign(
> +               __entry->poolid =3D poolid;
> +               __entry->bufsize =3D bufsize;
> +       ),
> +
> +       TP_printk("poolid=3D%u bufsize=3D%zu bytes",
> +               __entry->poolid, __entry->bufsize
> +       )
> +);
> +
> +TRACE_EVENT(rpcrdma_pool_destroy,
> +       TP_PROTO(
> +               unsigned int poolid
> +       ),
> +
> +       TP_ARGS(poolid),
> +
> +       TP_STRUCT__entry(
> +               __field(unsigned int, poolid)
> +       ),
> +
> +       TP_fast_assign(
> +               __entry->poolid =3D poolid;),
> +
> +       TP_printk("poolid=3D%u",
> +               __entry->poolid
> +       )
> +);
> +
> +DECLARE_EVENT_CLASS(rpcrdma_pool_shard_class,
> +       TP_PROTO(
> +               unsigned int poolid,
> +               u32 shardid
> +       ),
> +
> +       TP_ARGS(poolid, shardid),
> +
> +       TP_STRUCT__entry(
> +               __field(unsigned int, poolid)
> +               __field(u32, shardid)
> +       ),
> +
> +       TP_fast_assign(
> +               __entry->poolid =3D poolid;
> +               __entry->shardid =3D shardid;
> +       ),
> +
> +       TP_printk("poolid=3D%u shardid=3D%u",
> +               __entry->poolid, __entry->shardid
> +       )
> +);
> +
> +#define DEFINE_RPCRDMA_POOL_SHARD_EVENT(name)                          \
> +       DEFINE_EVENT(rpcrdma_pool_shard_class, name,                    \
> +       TP_PROTO(                                                       \
> +               unsigned int poolid,                                    \
> +               u32 shardid                                             \
> +       ),                                                              \
> +       TP_ARGS(poolid, shardid))
> +
> +DEFINE_RPCRDMA_POOL_SHARD_EVENT(rpcrdma_pool_shard_new);
> +DEFINE_RPCRDMA_POOL_SHARD_EVENT(rpcrdma_pool_shard_free);
> +
> +TRACE_EVENT(rpcrdma_pool_buffer,
> +       TP_PROTO(
> +               unsigned int poolid,
> +               const void *buffer
> +       ),
> +
> +       TP_ARGS(poolid, buffer),
> +
> +       TP_STRUCT__entry(
> +               __field(unsigned int, poolid)
> +               __field(const void *, buffer)
> +       ),
> +
> +       TP_fast_assign(
> +               __entry->poolid =3D poolid;
> +               __entry->buffer =3D buffer;
> +       ),
> +
> +       TP_printk("poolid=3D%u buffer=3D%p",
> +               __entry->poolid, __entry->buffer
> +       )
> +);
> +
>  #endif /* _TRACE_RPCRDMA_H */
>
>  #include <trace/define_trace.h>
> diff --git a/net/sunrpc/xprtrdma/Makefile b/net/sunrpc/xprtrdma/Makefile
> index 3232aa23cdb4..f69456dffe87 100644
> --- a/net/sunrpc/xprtrdma/Makefile
> +++ b/net/sunrpc/xprtrdma/Makefile
> @@ -1,7 +1,7 @@
>  # SPDX-License-Identifier: GPL-2.0
>  obj-$(CONFIG_SUNRPC_XPRT_RDMA) +=3D rpcrdma.o
>
> -rpcrdma-y :=3D transport.o rpc_rdma.o verbs.o frwr_ops.o ib_client.o \
> +rpcrdma-y :=3D transport.o rpc_rdma.o verbs.o frwr_ops.o ib_client.o poo=
l.o \
>         svc_rdma.o svc_rdma_backchannel.o svc_rdma_transport.o \
>         svc_rdma_sendto.o svc_rdma_recvfrom.o svc_rdma_rw.o \
>         svc_rdma_pcl.o module.o
> diff --git a/net/sunrpc/xprtrdma/pool.c b/net/sunrpc/xprtrdma/pool.c
> new file mode 100644
> index 000000000000..87404f1fc5bc
> --- /dev/null
> +++ b/net/sunrpc/xprtrdma/pool.c
> @@ -0,0 +1,241 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2025, Oracle and/or its affiliates.
> + *
> + * Pools for RPC-over-RDMA Receive buffers.
> + *
> + * A buffer pool attempts to conserve both the number of DMA mappings
> + * and the device's IOVA space by collecting small buffers together
> + * into a shard that has a single DMA mapping.
> + *
> + * API Contract:
> + *  - Buffers contained in one rpcrdma_pool instance are the same
> + *    size (rp_bufsize), no larger than RPCRDMA_MAX_INLINE_THRESH
> + *  - Buffers in one rpcrdma_pool instance are automatically released
> + *    when the pool instance is destroyed
> + *
> + * Future work:
> + *   - Manage pool resources by reference count
> + */
> +
> +#include <linux/list.h>
> +#include <linux/xarray.h>
> +#include <linux/sunrpc/svc_rdma.h>
> +
> +#include <rdma/ib_verbs.h>
> +
> +#include "xprt_rdma.h"
> +#include "pool.h"
> +
> +#include <trace/events/rpcrdma.h>
> +
> +/*
> + * An idr would give near perfect pool ID uniqueness, but for
> + * the moment the pool ID is used only for observability, not
> + * correctness.
> + */
> +static atomic_t rpcrdma_pool_id;
> +
> +struct rpcrdma_pool {
> +       struct xarray           rp_xa;
> +       struct ib_pd            *rp_pd;
> +       size_t                  rp_shardsize;   // in bytes
> +       size_t                  rp_bufsize;     // in bytes
> +       unsigned int            rp_bufs_per_shard;
> +       unsigned int            rp_pool_id;
> +};
> +
> +struct rpcrdma_pool_shard {
> +       struct page             *pc_pages;
> +       u8                      *pc_cpu_addr;
> +       u64                     pc_mapped_addr;
> +       unsigned long           *pc_bitmap;
> +};
> +
> +/*
> + * For good NUMA awareness, ensure that the shard is allocated on
> + * the NUMA node that the underlying device is affined to.
> + *
> + * For the shard buffer, we really want alloc_pages_node rather
> + * than kmalloc_node.
> + */
> +static struct rpcrdma_pool_shard *
> +rpcrdma_pool_shard_alloc(struct rpcrdma_pool *pool, gfp_t flags)
> +{
> +       struct ib_device *device =3D pool->rp_pd->device;
> +       int numa_node =3D ibdev_to_node(device);
> +       struct rpcrdma_pool_shard *shard;
> +       size_t bmap_size;
> +
> +       shard =3D kmalloc_node(sizeof(*shard), flags, numa_node);
> +       if (!shard)
> +               goto fail;
> +
> +       bmap_size =3D BITS_TO_LONGS(pool->rp_bufs_per_shard) * sizeof(uns=
igned long);
> +       shard->pc_bitmap =3D kzalloc(bmap_size, flags);
> +       if (!shard->pc_bitmap)
> +               goto free_shard;
> +
> +       shard->pc_pages =3D alloc_pages_node(numa_node, flags,
> +                                          get_order(pool->rp_shardsize))=
;
> +       if (!shard->pc_pages)
> +               goto free_bitmap;
> +
> +       shard->pc_cpu_addr =3D page_address(shard->pc_pages);
> +       shard->pc_mapped_addr =3D ib_dma_map_single(device, shard->pc_cpu=
_addr,
> +                                                 pool->rp_shardsize,
> +                                                 DMA_FROM_DEVICE);
> +       if (ib_dma_mapping_error(device, shard->pc_mapped_addr))
> +               goto free_iobuf;
> +
> +       return shard;
> +
> +free_iobuf:
> +       __free_pages(shard->pc_pages, get_order(pool->rp_shardsize));
> +free_bitmap:
> +       kfree(shard->pc_bitmap);
> +free_shard:
> +       kfree(shard);
> +fail:
> +       return NULL;
> +}
> +
> +static void
> +rpcrdma_pool_shard_free(struct rpcrdma_pool *pool,
> +                       struct rpcrdma_pool_shard *shard)
> +{
> +       ib_dma_unmap_single(pool->rp_pd->device, shard->pc_mapped_addr,
> +                           pool->rp_shardsize, DMA_FROM_DEVICE);
> +
> +       __free_pages(shard->pc_pages, get_order(pool->rp_shardsize));
> +       kfree(shard->pc_bitmap);
> +       kfree(shard);
> +}
> +
> +/**
> + * rpcrdma_pool_create - Allocate an rpcrdma_pool instance
> + * @pd: RDMA protection domain to be used for the pool's buffers
> + * @bufsize: Size, in bytes, of all buffers in the pool
> + * @flags: GFP flags to be used during pool creation
> + *
> + * Returns a pointer to an opaque rpcrdma_pool instance, or NULL. If
> + * a pool instance is returned, caller must free the instance using
> + * rpcrdma_pool_destroy().
> + */
> +struct rpcrdma_pool *rpcrdma_pool_create(struct ib_pd *pd, size_t bufsiz=
e,
> +                                        gfp_t flags)
> +{
> +       struct rpcrdma_pool *pool;
> +
> +       pool =3D kmalloc(sizeof(*pool), flags);
> +       if (!pool)
> +               return NULL;
> +
> +       xa_init_flags(&pool->rp_xa, XA_FLAGS_ALLOC);
> +       pool->rp_pd =3D pd;
> +       pool->rp_shardsize =3D RPCRDMA_MAX_INLINE_THRESH;
> +       pool->rp_bufsize =3D bufsize;
> +       pool->rp_bufs_per_shard =3D pool->rp_shardsize / pool->rp_bufsize=
;
> +       pool->rp_pool_id =3D atomic_inc_return(&rpcrdma_pool_id);
> +
> +       trace_rpcrdma_pool_create(pool->rp_pool_id, pool->rp_bufsize);
> +       return pool;
> +}
> +
> +/**
> + * rpcrdma_pool_destroy - Release resources owned by @pool
> + * @pool: buffer pool instance that will no longer be used
> + *
> + * This call releases all buffers in @pool that were allocated
> + * via rpcrdma_pool_buffer_alloc().
> + */
> +void
> +rpcrdma_pool_destroy(struct rpcrdma_pool *pool)
> +{
> +       struct rpcrdma_pool_shard *shard;
> +       unsigned long index;
> +
> +       trace_rpcrdma_pool_destroy(pool->rp_pool_id);
> +
> +       xa_for_each(&pool->rp_xa, index, shard) {
> +               trace_rpcrdma_pool_shard_free(pool->rp_pool_id, index);
> +               xa_erase(&pool->rp_xa, index);
> +               rpcrdma_pool_shard_free(pool, shard);
> +       }
> +
> +       xa_destroy(&pool->rp_xa);
> +       kfree(pool);
> +}
> +
> +/**
> + * rpcrdma_pool_buffer_alloc - Allocate a buffer from @pool
> + * @pool: buffer pool from which to allocate the buffer
> + * @flags: GFP flags used during this allocation
> + * @cpu_addr: CPU address of the buffer
> + * @sge: OUT: an initialized scatter-gather entry
> + *
> + * Return values:
> + *   %true: @cpu_addr and @mapped_addr are filled in with a DMA-mapped b=
uffer
> + *   %false: No buffer is available
> + *
> + * When rpcrdma_pool_buffer_alloc() is successful, the returned
> + * buffer is freed automatically when the buffer pool is released
> + * by rpcrdma_pool_destroy().
> + */
> +bool
> +rpcrdma_pool_buffer_alloc(struct rpcrdma_pool *pool, gfp_t flags,
> +                         void **cpu_addr, struct ib_sge *sge)
> +{
> +       struct rpcrdma_pool_shard *shard;
> +       u64 returned_mapped_addr;
> +       void *returned_cpu_addr;
> +       unsigned long index;
> +       u32 id;
> +
> +       xa_for_each(&pool->rp_xa, index, shard) {
> +               unsigned int i;
> +
> +               returned_cpu_addr =3D shard->pc_cpu_addr;
> +               returned_mapped_addr =3D shard->pc_mapped_addr;
> +               for (i =3D 0; i < pool->rp_bufs_per_shard; i++) {
> +                       if (!test_and_set_bit(i, shard->pc_bitmap)) {
> +                               returned_cpu_addr +=3D i * pool->rp_bufsi=
ze;
> +                               returned_mapped_addr +=3D i * pool->rp_bu=
fsize;
> +                               goto out;
> +                       }
> +               }
> +       }
> +
> +       shard =3D rpcrdma_pool_shard_alloc(pool, flags);
> +       if (!shard)
> +               return false;
> +       set_bit(0, shard->pc_bitmap);
> +       returned_cpu_addr =3D shard->pc_cpu_addr;
> +       returned_mapped_addr =3D shard->pc_mapped_addr;
> +
> +       if (xa_alloc(&pool->rp_xa, &id, shard, xa_limit_16b, flags) !=3D =
0) {
> +               rpcrdma_pool_shard_free(pool, shard);
> +               return false;
> +       }
> +       trace_rpcrdma_pool_shard_new(pool->rp_pool_id, id);
> +
> +out:
> +       *cpu_addr =3D returned_cpu_addr;
> +       sge->addr =3D returned_mapped_addr;
> +       sge->length =3D pool->rp_bufsize;
> +       sge->lkey =3D pool->rp_pd->local_dma_lkey;
> +
> +       trace_rpcrdma_pool_buffer(pool->rp_pool_id, returned_cpu_addr);
> +       return true;
> +}
> +
> +/**
> + * rpcrdma_pool_buffer_sync - Sync the contents of a pool buffer after I=
/O
> + * @pool: buffer pool to which the buffer belongs
> + * @sge: SGE containing the DMA-mapped buffer address and length
> + */
> +void rpcrdma_pool_buffer_sync(struct rpcrdma_pool *pool, struct ib_sge *=
sge)
> +{
> +       ib_dma_sync_single_for_cpu(pool->rp_pd->device, sge->addr,
> +                                  sge->length, DMA_FROM_DEVICE);
> +}
> diff --git a/net/sunrpc/xprtrdma/pool.h b/net/sunrpc/xprtrdma/pool.h
> new file mode 100644
> index 000000000000..9c8ec8723884
> --- /dev/null
> +++ b/net/sunrpc/xprtrdma/pool.h
> @@ -0,0 +1,20 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (c) 2025, Oracle and/or its affiliates.
> + *
> + * Pools for RDMA Receive buffers.
> + */
> +
> +#ifndef RPCRDMA_POOL_H
> +#define RPCRDMA_POOL_H
> +
> +struct rpcrdma_pool;
> +
> +struct rpcrdma_pool *rpcrdma_pool_create(struct ib_pd *pd, size_t bufsiz=
e,
> +                                        gfp_t flags);
> +void rpcrdma_pool_destroy(struct rpcrdma_pool *pool);
> +bool rpcrdma_pool_buffer_alloc(struct rpcrdma_pool *pool, gfp_t flags,
> +                              void **cpu_addr, struct ib_sge *sge);
> +void rpcrdma_pool_buffer_sync(struct rpcrdma_pool *pool, struct ib_sge *=
sge);
> +
> +#endif /* RPCRDMA_POOL_H */
> diff --git a/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c b/net/sunrpc/xprtrdm=
a/svc_rdma_recvfrom.c
> index e7e4a39ca6c6..704f6d5fa3e6 100644
> --- a/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
> +++ b/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
> @@ -104,9 +104,9 @@
>  #include <linux/sunrpc/svc_rdma.h>
>
>  #include "xprt_rdma.h"
> -#include <trace/events/rpcrdma.h>
> +#include "pool.h"
>
> -static void svc_rdma_wc_receive(struct ib_cq *cq, struct ib_wc *wc);
> +#include <trace/events/rpcrdma.h>
>
>  static inline struct svc_rdma_recv_ctxt *
>  svc_rdma_next_recv_ctxt(struct list_head *list)
> @@ -115,14 +115,14 @@ svc_rdma_next_recv_ctxt(struct list_head *list)
>                                         rc_list);
>  }
>
> +static void svc_rdma_wc_receive(struct ib_cq *cq, struct ib_wc *wc);
> +
>  static struct svc_rdma_recv_ctxt *
>  svc_rdma_recv_ctxt_alloc(struct svcxprt_rdma *rdma)
>  {
>         int node =3D ibdev_to_node(rdma->sc_cm_id->device);
>         struct svc_rdma_recv_ctxt *ctxt;
>         unsigned long pages;
> -       dma_addr_t addr;
> -       void *buffer;
>
>         pages =3D svc_serv_maxpages(rdma->sc_xprt.xpt_server);
>         ctxt =3D kzalloc_node(struct_size(ctxt, rc_pages, pages),
> @@ -130,13 +130,10 @@ svc_rdma_recv_ctxt_alloc(struct svcxprt_rdma *rdma)
>         if (!ctxt)
>                 goto fail0;
>         ctxt->rc_maxpages =3D pages;
> -       buffer =3D kmalloc_node(rdma->sc_max_req_size, GFP_KERNEL, node);
> -       if (!buffer)
> +
> +       if (!rpcrdma_pool_buffer_alloc(rdma->sc_recv_pool, GFP_KERNEL,
> +                                      &ctxt->rc_recv_buf, &ctxt->rc_recv=
_sge))
>                 goto fail1;
> -       addr =3D ib_dma_map_single(rdma->sc_pd->device, buffer,
> -                                rdma->sc_max_req_size, DMA_FROM_DEVICE);
> -       if (ib_dma_mapping_error(rdma->sc_pd->device, addr))
> -               goto fail2;
>
>         svc_rdma_recv_cid_init(rdma, &ctxt->rc_cid);
>         pcl_init(&ctxt->rc_call_pcl);
> @@ -149,30 +146,15 @@ svc_rdma_recv_ctxt_alloc(struct svcxprt_rdma *rdma)
>         ctxt->rc_recv_wr.sg_list =3D &ctxt->rc_recv_sge;
>         ctxt->rc_recv_wr.num_sge =3D 1;
>         ctxt->rc_cqe.done =3D svc_rdma_wc_receive;
> -       ctxt->rc_recv_sge.addr =3D addr;
> -       ctxt->rc_recv_sge.length =3D rdma->sc_max_req_size;
> -       ctxt->rc_recv_sge.lkey =3D rdma->sc_pd->local_dma_lkey;
> -       ctxt->rc_recv_buf =3D buffer;
>         svc_rdma_cc_init(rdma, &ctxt->rc_cc);
>         return ctxt;
>
> -fail2:
> -       kfree(buffer);
>  fail1:
>         kfree(ctxt);
>  fail0:
>         return NULL;
>  }
>
> -static void svc_rdma_recv_ctxt_destroy(struct svcxprt_rdma *rdma,
> -                                      struct svc_rdma_recv_ctxt *ctxt)
> -{
> -       ib_dma_unmap_single(rdma->sc_pd->device, ctxt->rc_recv_sge.addr,
> -                           ctxt->rc_recv_sge.length, DMA_FROM_DEVICE);
> -       kfree(ctxt->rc_recv_buf);
> -       kfree(ctxt);
> -}
> -
>  /**
>   * svc_rdma_recv_ctxts_destroy - Release all recv_ctxt's for an xprt
>   * @rdma: svcxprt_rdma being torn down
> @@ -185,8 +167,9 @@ void svc_rdma_recv_ctxts_destroy(struct svcxprt_rdma =
*rdma)
>
>         while ((node =3D llist_del_first(&rdma->sc_recv_ctxts))) {
>                 ctxt =3D llist_entry(node, struct svc_rdma_recv_ctxt, rc_=
node);
> -               svc_rdma_recv_ctxt_destroy(rdma, ctxt);
> +               kfree(ctxt);
>         }
> +       rpcrdma_pool_destroy(rdma->sc_recv_pool);
>  }
>
>  /**
> @@ -307,6 +290,12 @@ bool svc_rdma_post_recvs(struct svcxprt_rdma *rdma)
>  {
>         unsigned int total;
>
> +       rdma->sc_recv_pool =3D rpcrdma_pool_create(rdma->sc_pd,
> +                                                rdma->sc_max_req_size,
> +                                                GFP_KERNEL);
> +       if (!rdma->sc_recv_pool)
> +               return false;
> +
>         /* For each credit, allocate enough recv_ctxts for one
>          * posted Receive and one RPC in process.
>          */
> @@ -962,9 +951,7 @@ int svc_rdma_recvfrom(struct svc_rqst *rqstp)
>                 return 0;
>
>         percpu_counter_inc(&svcrdma_stat_recv);
> -       ib_dma_sync_single_for_cpu(rdma_xprt->sc_pd->device,
> -                                  ctxt->rc_recv_sge.addr, ctxt->rc_byte_=
len,
> -                                  DMA_FROM_DEVICE);
> +       rpcrdma_pool_buffer_sync(rdma_xprt->sc_recv_pool, &ctxt->rc_recv_=
sge);
>         svc_rdma_build_arg_xdr(rqstp, ctxt);
>
>         ret =3D svc_rdma_xdr_decode_req(&rqstp->rq_arg, ctxt);
> --
> 2.50.0
>
>

