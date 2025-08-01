Return-Path: <linux-nfs+bounces-13373-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A146DB182A5
	for <lists+linux-nfs@lfdr.de>; Fri,  1 Aug 2025 15:44:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFFC9562D3E
	for <lists+linux-nfs@lfdr.de>; Fri,  1 Aug 2025 13:44:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D68E20F098;
	Fri,  1 Aug 2025 13:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iZL2SsX+"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94CA413E02A
	for <linux-nfs@vger.kernel.org>; Fri,  1 Aug 2025 13:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754055843; cv=none; b=if9anqs3FnRCAoMfDohFZDOSgZwkpNotcqYbxKIJrFcHYflHIUur3cJYLZFZAKiTI87CzLGBhziU5NPyjIGYFlQ5zPSqbwgCU8u5MCdsi2ny9To0VwWGXdDBeFLcn83F1UvWcJsb0gedmX3PJm/NVbEihDo6pu032r9c8wqDo+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754055843; c=relaxed/simple;
	bh=YAPfx6koaniV191xcDovtyE7JXcb0BK52HODMTRO2sU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ibnYjOQiDAL5zQDwlLKLHZToENjkHJoFbPObxNNlYDZcIVO0jJ1l91ku3aP7N0fFrny1CpIrvdLLJ1N3t65KIIIcSRhXmz/fFU2Jv0J7KAlhkNt6iMtdZlwVVQcuMuz0c3C7NsahRT0dHQqhQzkfmU7ZPLiGgyGoU4sOUGa3zlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iZL2SsX+; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-e8da9b7386dso2377881276.1
        for <linux-nfs@vger.kernel.org>; Fri, 01 Aug 2025 06:44:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754055840; x=1754660640; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s+PPo22hIcOWVGzFLR+YoQU+WYvXyebXyF1eegDmfkk=;
        b=iZL2SsX+lI8Govuh6Q4+0QYNStCzwwTrwYYQP8pYMeAvUToNo89ahlcMOWi/gobR/s
         CgkVuGfpzNvU6RAOB7stpKnWM1pcjxABd0TtbwWhpvfMXApwqsgw2Xn4zR4A0FpuLiQ+
         4gu7RB1JLENdQ5yRvWup2Drn+8+pZsntdQOPPVYZiz5THN5BPxo6h80PMuwnjhBWxwSs
         AgP8t2h0uE6MwVgDm9NWKVaDzWP/nfOzDjL8qlOt4l4ZihTIuWDreprxewcVH6rgMf85
         GEywoMruPUBfeclC0RFW9N42er7s86bIehaMJ4NruCHJGcHmM4GaogFP/bprmf72Q9hR
         9hdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754055840; x=1754660640;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s+PPo22hIcOWVGzFLR+YoQU+WYvXyebXyF1eegDmfkk=;
        b=fEGTeIRxoqUKyfKH/mZE/g+w8dj9yLPfI3qTmTyxA0npOC7wMigBlMzMJIRHeQeq5e
         KZiBj6Xzo2qjbwGi2WNrveFO5i4xqOyoDRGmEZUWEJwZZM/MStnWWc7YEcXhgypocSNt
         ufPTOc0U2ea4c2JH4ZXBXXKxV8zsATh1ZMFaSTM/70yXtpaMiljm+s3T++JGyfpStDK/
         H/c55RygoQJJgXM3YkdSClvcyOejra+l/VlrzUOvAdKMiDamilxJJ3zP6/aSAF702XgE
         RBFMLFgZOXZNoMnWqgMMaeZeGH1HSigkaQS63iyPIWCbM7e2lor3EQoL1QhJ5MH1ub7n
         GPEQ==
X-Gm-Message-State: AOJu0Yzd5HrDDVYONFn3mPjHW5e/2egbIU16gsyb4DMz7dNGlVQ+wUXc
	MYc6d2U1nZ0J7/zy1DTMWoocMTmBqCNiqyWGAk056OJPiZUxifM5/NhuMZmRktsZpkuxLKZAfhB
	6cduLzLlIkP3owz6nLNrV3mPU8oGmiKnODChh
X-Gm-Gg: ASbGncs6+X5kjBkimiymR1w12GAyh3ZrLKQzbt+qSP1PDPEBQ5Vt/Oc9knqgTrQndib
	JJJaPPB8rl2lV3pN5mEqQcU9FQaOBNgT7juPM6tJIPxO5e47hcMfbfdtRbHyACjlU8aOLtW2VY2
	KGcqB32tukTEy13QUVBZrQphauSyjfMQEBombgzdu7tqF2k0wyxfBPbVeb1nKB24Vwep3+AXjuu
	jxoVj8t
X-Google-Smtp-Source: AGHT+IFiWKtKEVPGTzA/miCQosvq2CP8O0bjJJgfX73uNkFKgOEkClI5fA/zyKc/gyGpertug4N3LJ4ZY7D5KYDx1P8=
X-Received: by 2002:a25:1306:0:b0:e8e:d61:a665 with SMTP id
 3f1490d57ef6-e8fd5302e54mr5239170276.5.1754055840439; Fri, 01 Aug 2025
 06:44:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAAiJnjoNd37p6kqSZSOPzYup_fWaHZgJv3gEpfThpxn--MqpqA@mail.gmail.com>
 <aIuux1V2l5jNaikF@kernel.org>
In-Reply-To: <aIuux1V2l5jNaikF@kernel.org>
From: Anton Gavriliuk <antosha20xx@gmail.com>
Date: Fri, 1 Aug 2025 16:43:46 +0300
X-Gm-Features: Ac12FXxLIk1vPiVrgcRXGpGSEvCSFC4CkqcJa-ABdFv3i-qb8-HafOePLK5BYAc
Message-ID: <CAAiJnjpfn0whn_RBzZ7br85JJjXpyOy2cpUTfw6AJ-UYw+K-3A@mail.gmail.com>
Subject: Re: mount NFS with localio
To: Mike Snitzer <snitzer@kernel.org>
Cc: linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> But for simple loopback NFS mount that
> doesn't use pnfs flexfiles it _should_ work, e.g.:
>
>  # cat /sys/fs/nfs/0\:46/localio
>  1

Yes, it works, thank you.  For NFS localio single thread sequential
read with enabled localio_O_DIRECT_semantics, performance improved 3.5
times!

I'm also looking for non-localio NFS performance improvements,
interested in end-to-end O_DIRECT.

How to enable non-localio end-to-end O_DIRECT ?

Anton

=D1=87=D1=82, 31 =D0=B8=D1=8E=D0=BB. 2025=E2=80=AF=D0=B3. =D0=B2 20:58, Mik=
e Snitzer <snitzer@kernel.org>:
>
> On Wed, Jul 30, 2025 at 03:43:00PM +0300, Anton Gavriliuk wrote:
> > Hi
> >
> > How to mount NFS with localio on Fedora Server 42 (6.15.8 kernel) ?
> >
> > Localio enabled in kernel
> >
> > [root@23-127-77-5 ~]# cat /boot/config-6.15.8-200.fc42.x86_64 | grep -i=
 localio
> > CONFIG_NFS_COMMON_LOCALIO_SUPPORT=3Dm
> > CONFIG_NFS_LOCALIO=3Dy
> >
> > [root@23-127-77-5 ~]# lsmod | grep -i localio
> > nfs_localio            36864  2 nfsd,nfs
> > sunrpc                925696  30
> > nfs_localio,nfsd,rpcrdma,nfsv4,auth_rpcgss,lockd,rpcsec_gss_krb5,nfs_ac=
l,nfs
> >
> > [root@23-127-77-5 ~]# mount -t nfs 127.0.0.1:/mnt /mnt1
> > [root@23-127-77-5 ~]#
> > [root@23-127-77-5 ~]# mount | grep -i mnt1
> > 127.0.0.1:/mnt on /mnt1 type nfs4
> > (rw,relatime,vers=3D4.2,rsize=3D1048576,wsize=3D1048576,namlen=3D255,ha=
rd,fatal_neterrors=3Dnone,proto=3Dtcp,timeo=3D600,retrans=3D2,sec=3Dsys,cli=
entaddr=3D127.0.0.1,local_lock=3Dnone,addr=3D127.0.0.1)
> >
> > So /mnt1 is mounted with localio ?
>
> Should be.
>
> One way to tell, albeit less ironclad, is that performance improves
> (reduced use of network/sunrpc is also a tell-tale).
>
> But see commit 62d2cde203def ("NFS: add localio to sysfs")
> It adds semi-useful exposure of whether LOCALIO is active for a given
> rpc client.  I say "semi-useful" because I'm left wanting on the
> reliability of this interface (particularly when pnfs flexfiles is
> used, the separate NFS client that is established to connect to the
> local NFSD over v3 isn't getting added to sysfs for some reason.. not
> put time to fixing that yet).  But for simple loopback NFS mount that
> doesn't use pnfs flexfiles it _should_ work, e.g.:
>
>   # cat /sys/fs/nfs/0\:46/localio
>   1
>
> I've found that the best way to _know_ LOCALIO enabled is to use trace
> points, but yeah that is kind of obscure and certainly not common in
> production.
>
> These tracepoints really showcase LOCALIO is being used:
>
>  echo 1 > /sys/kernel/tracing/events/sunrpc/svc_process/enable
>  echo 1 > /sys/kernel/tracing/events/nfs_localio/nfs_localio_enable_clien=
t/enable
>  echo 1 > /sys/kernel/tracing/events/nfs_localio/nfs_localio_disable_clie=
nt/enable
>  echo 1 > /sys/kernel/tracing/events/nfs/nfs_local_open_fh/enable
>
> (NOTE: it is only with this patch applied that the nfs_local_open_fh
> tracepoint is made much more useful, otherwise it'd only show if the
> function failed to open the fh.. unfortunately not yet picked up for
> upstream:
> https://lore.kernel.org/linux-nfs/20250724193102.65111-9-snitzer@kernel.o=
rg/
> )
>
>  echo nop > /sys/kernel/debug/tracing/current_tracer
>  echo 1 > /sys/kernel/debug/tracing/tracing_on
>
> With these enabled, mounting NFS via loopback and doing a simple dd
> shows the following in: cat /sys/kernel/debug/tracing/trace
>
>             nfsd-10448   [024] .....  4316.520916: svc_process: addr=3D19=
2.168.1.106 xid=3D0xcf2cdbdf service=3Dnfslocalio vers=3D1 proc=3DUUID_IS_L=
OCAL
>   kworker/u194:0-9772    [042] .....  4316.520951: nfs_localio_enable_cli=
ent: server=3D192.168.1.106 NFSv3
>   kworker/u194:0-9772    [042] .....  4316.647334: nfs_local_open_fh: fha=
ndle=3D0x4d34e6c1 mode=3DREAD|WRITE result=3D0
>
> Also, enabling various nfsd tracepoints and seeing the absence of them
> is telling.  Similarly, enabling tracepoints for NFSD's underlying
> filesystem (e.g. xfs) and seeing the process that is triggering the
> trace isn't nfsd showcases LOCALIO being used, e.g.:
>
> with LOCALIO:
>
>   kworker/u194:3-9540    [027] .....  5155.011380: xfs_file_direct_write:=
 dev 259:16 ino 0x3e00008f disize 0xb7a0 pos 0xc000 bytecount 0xa000
>
> without LOCALIO:
>
>             nfsd-10448   [034] .....  5730.314274: xfs_file_direct_write:=
 dev 259:16 ino 0x3e00008f disize 0xb7a0 pos 0xc000 bytecount 0xa000
>
> Hope this helps,
> Mike

