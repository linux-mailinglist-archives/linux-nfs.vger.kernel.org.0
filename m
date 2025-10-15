Return-Path: <linux-nfs+bounces-15265-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E27FBDD8CE
	for <lists+linux-nfs@lfdr.de>; Wed, 15 Oct 2025 10:55:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D46CC3B23A8
	for <lists+linux-nfs@lfdr.de>; Wed, 15 Oct 2025 08:55:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12CAD3064B1;
	Wed, 15 Oct 2025 08:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hDVrwX78"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62DAB302CC9
	for <linux-nfs@vger.kernel.org>; Wed, 15 Oct 2025 08:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760518513; cv=none; b=n5XdHe5m0VRUaSHDOoVJLVSlBWwrTaGTyLk1stCUSqiOlCKkEBaBh53T/t62t/BuXixIc5KopY0R/wZurXX4a8Txcuh8y2UO9qnzUlTmjmOhTTBbHhqRALUN7EbbA3rQFxPSdY479BC248IAYIGDKvey3wHYctQhLbNflS5BvgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760518513; c=relaxed/simple;
	bh=PnZYoZixlZe2UBYMbO2OeSihGeWSGTpgJH47W2yN5lE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U5WWt+uDsFMreYgqcDQY98R6ibuF+2fxyWjNgOJ8PH96KxDMHCI3lRbBwFzC/pqbGLP7bli6sNaoqWEMPiLSmmCUMGEX/X1oOMtaxMakV2cZw3qVmOpNZykUwOa+9e++KF+ggpepRIQvzTDdxTHuuSyHQJGlVN0Vu36wnpmI+dY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hDVrwX78; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-631787faf35so12651448a12.3
        for <linux-nfs@vger.kernel.org>; Wed, 15 Oct 2025 01:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760518510; x=1761123310; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fgEqnrxX4R0u2xnG7ixfV3NvX2lvrI5nPU8w2RGCEiE=;
        b=hDVrwX788HazW20XAu5qXC7mRNc5tjfz+7Ar4WRwjCw9A6W0MtWF6SAdjAsy4R6AMT
         I8zqj2O+e/BAMD3M1uvKSWKiDaHcsAl7QE40ZCg293FW8UrFE1slH4ZF9OOVqhhHR3PI
         /8QbZOFTlQG38mQNpFfOmEXqLUGmNsMT7F478QM9cs8PvxlB9kUNVzq0nUYeWOszXaM5
         L8RskbqL/IrIIjciUMCn3qYI3ODe1/yLZX3iXMVCZi0WSEgzVfWqUxlKtbdzd//j+lwD
         BnktJeQFkjOAUoMc9CmAc3C5ozjU2H1NXaTn/uXA3pzsgXqgOZmzNwj5XoSxVxweUuf0
         21HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760518510; x=1761123310;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fgEqnrxX4R0u2xnG7ixfV3NvX2lvrI5nPU8w2RGCEiE=;
        b=TuEAVd+d9pmwQ29XH/Z3uMyH6NrUpy5msUDUCCdVBq2PiRZCT74liBKaK3T0IOfyFg
         YvJhD4fpAg6aojd46HHxtiP6C2jvPgZ6YG+vztgu7ifrlPYMnrjxXglkxNP5mdyOj/3p
         qr25nex6Y6B0lbzzVBkWL1YVcbW0aOth9gzwZv657R1ADO3sdotujA0/BgWR9NMBwPkv
         0EvClk0/HQhtsmEm+54XcSMa+2g97gvwuYVtMcpKtaNThB49cFxI4l4+A2CNzLsr+3H6
         aLxyTd3WgVB6oLq3guyvAXLqjhNDMDvXRPFvVmSS10rU/CoLhhWmamKZIMvZH45sjwyN
         J14w==
X-Forwarded-Encrypted: i=1; AJvYcCVtJq1zYORS0Y9J0QlE5FQBv8NFe9gAnxX1zvUXfPb5/kku+U0pWV+2gIJ6aw/zW5ImWwBPU8dTGAE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQxXeIU7DjfeBGoBiJXXoSpxuAJocXnsZ51lqcqEFGh66IMQd4
	SsE190MPh6GXxp6VPxweDQV7HGw7SnrcBURJYSUfMNuv3hubkc2ylHpcP5j/sb+rc7jTt/d0ni/
	z6sBqiuaS+jD9YpuNaUHr4K4HpHswg7M=
X-Gm-Gg: ASbGnctrEn65n+NLCnqydYjBHq5sbIH/UwUckyOI4bnBLenPN64FW4G+9HeW3Mvp9NE
	hecE+a7oyWAg0ZKQwyMcE5aXwA5WHUJP921+0P9TFvE/o7Y5Vi5z8ihC8LgyzV4Re0tsQ+2msFa
	AJyGWU2GKRh/ldl4DXPImNssvGuzvTvfeiNnuQm8iO5LE0sENtV5c0SDRfjjor5gaczT8eZ9kjQ
	qjjiQNARhWThkmAPWGaYUQmvlleFj/AzspGBls19WpqyhAp
X-Google-Smtp-Source: AGHT+IFTcVXJ2k4Io0gR55B+LOiUs0D6lc9nA2FkAagSET75wVrURhguyB7dmaTVjRb2yFF3HFNEaUx2J8d6K4IUlfA=
X-Received: by 2002:a17:907:9448:b0:b40:a71b:151f with SMTP id
 a640c23a62f3a-b50ac1c4e7cmr3185549666b.30.1760518509261; Wed, 15 Oct 2025
 01:55:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CGME20251014120958epcas5p267c3c9f9dbe6ffc53c25755327de89f9@epcas5p2.samsung.com>
 <20251014120845.2361-1-kundan.kumar@samsung.com> <20251014180312.6917d7bd5681d4c8ca356691@linux-foundation.org>
In-Reply-To: <20251014180312.6917d7bd5681d4c8ca356691@linux-foundation.org>
From: Kundan Kumar <kundanthebest@gmail.com>
Date: Wed, 15 Oct 2025 14:24:57 +0530
X-Gm-Features: AS18NWBrpUjyPc8mxzcKZ88p2FW9F32bwQuz9_BbcqcNCJwm-Zl4oTpr4byxBk0
Message-ID: <CALYkqXp9Wewk=P79r+Q8HjngUOSWq71ZA6NBm5fPSj9EZHh1Ng@mail.gmail.com>
Subject: Re: [PATCH v2 00/16] Parallelizing filesystem writeback
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Kundan Kumar <kundan.kumar@samsung.com>, jaegeuk@kernel.org, chao@kernel.org, 
	viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, miklos@szeredi.hu, 
	agruenba@redhat.com, trondmy@kernel.org, anna@kernel.org, willy@infradead.org, 
	mcgrof@kernel.org, clm@meta.com, david@fromorbit.com, amir73il@gmail.com, 
	axboe@kernel.dk, hch@lst.de, ritesh.list@gmail.com, djwong@kernel.org, 
	dave@stgolabs.net, wangyufei@vivo.com, linux-f2fs-devel@lists.sourceforge.net, 
	linux-fsdevel@vger.kernel.org, gfs2@lists.linux.dev, 
	linux-nfs@vger.kernel.org, linux-mm@kvack.org, gost.dev@samsung.com, 
	anuj20.g@samsung.com, vishak.g@samsung.com, joshi.k@samsung.com
Content-Type: text/plain; charset="UTF-8"

>
> Nice results.  Is testing planned for other filesystems?
>

The changes currently improve the writeback performance for XFS only.
We have introduced a callback that other filesystems can implement to
decide which writeback context an inode should be affined to.

This is because the decision to affine an inode to a particular
writeback context depends on the FS geometry. For example, in XFS
inodes belonging to the same allocation group should be affined to the
same writeback context. Arbitrarily distributing inodes across
different writeback contexts can lead to contention of FS resources,
which can degrade performance.

I conducted a sanity check on the performance of EXT4, BTRFS, and F2FS
with the current changes, and the results show no performance impact.

