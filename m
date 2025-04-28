Return-Path: <linux-nfs+bounces-11305-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06F2EA9EE87
	for <lists+linux-nfs@lfdr.de>; Mon, 28 Apr 2025 13:06:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63A0D16FDCB
	for <lists+linux-nfs@lfdr.de>; Mon, 28 Apr 2025 11:06:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 659BA19047A;
	Mon, 28 Apr 2025 11:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wl1+BMel"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9D6B4A35
	for <linux-nfs@vger.kernel.org>; Mon, 28 Apr 2025 11:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745838373; cv=none; b=Bt9meosW8KBTooFTxcirD7o03TQ6+aivBG4sgPisjgdFjW0u0AVfxhQn5WjSnnFo1po4SLkdc3fDiRVz2mEslxN4dMSjFMNw25MvhFZBAniCTzBh54gMOioM/nbX08FImr2Hj1Lby8YlHm/c0tGfcusQ43F2hlOBhQFPGB3g7rY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745838373; c=relaxed/simple;
	bh=+8TuJ20Mzl6tK0yupSAMk+Pv/fc+sJpiixQxIBc22GM=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=t5LHe/1KJ9cqmP8eY/Fz9HhXc5j16EzOZ/rnydtH1uc8JE7lp95ZrwFZYo9bx8kEeNiZGPcJcHHSggqYsMeH214laPAt4NAXKfIZ8yUkGGkiwj5JMic3lC3fuhp3crlCRMzfkTRY21cvYdQ01SrWT03i6bO7dzuPx6ipH/3pOn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wl1+BMel; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5e5e8274a74so7269768a12.1
        for <linux-nfs@vger.kernel.org>; Mon, 28 Apr 2025 04:06:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745838368; x=1746443168; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PKBcblGH3u+2nyJvdvBCJlgjV21i+jMa/x8wO81yGiM=;
        b=Wl1+BMelVZu7X/MDL/Pd0w1+fHDEBPFgktqNmi4aMTdg2Cu4Rs0aBPRm0Mj20L0CnY
         E9si7mA4beuOHIZD85bSUpztvo1GUB1HFfvLFm2TEX7Ng9x18dWhIPu52673JP0mhFbY
         iGt3wss/g66z0Hm/vkLAdKM1dGxCMeHiGSyd09OnMSshw3fNs27vz1LhGk7wgAJr45xR
         s2QqIFKynePM4/6+LoYUENeVUA297h+G3z1mEJGGhEOwleVreUBNq9MupJkdgf5TKI/1
         GuTAKJQwqN7FQMgQFq7vIloKYvs8t4A12ZAgahnKGXITUv8Kcy+3VPKVbIo2R8hEN08+
         FJ9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745838368; x=1746443168;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PKBcblGH3u+2nyJvdvBCJlgjV21i+jMa/x8wO81yGiM=;
        b=TRvYFLdk1PRKeKuKY5osD4yqHH0Ft3DfuqbDczzXQJqgbY8BecweiJ/L2yIm+eZE3G
         YfBJAVqHj++qHi3fHM+EvElJPoQ3nvjimilz16U1gN3D1RVLWwQKp9cdRbPEHquli+94
         2zIMx2t4UWLOFuzPEFOFPmEcpthSk/J70yXuLQ3/rMdXJb0hbcTs6ZuqxoApjxfNIiA8
         WFqJg+hEpVgiLSfmUGtHNWUfClaKHcE1o9GAIQKGpHN69YXt80C4JZZ5VGM2ZtuP3GCg
         C+CupOx+TBsxDpJiFF+KyKv2bBmuOnKqB5C/DKl3ZtVS1GFrM7jfvZwaPRfvX9ldsvip
         rCTA==
X-Gm-Message-State: AOJu0YxFSYVnTTcm/jJZ26Zb1eJ2Wky1AtPzhPJDtH9zwI1xaTALCuD+
	1OhsGTgK80D3X1X6J99HGWkXhHDYuYXMCrlDYAjq0oV08eRCfVvNRpblVdHcJa2zVNpF1OgGy9b
	DJBM4U6MNmY1aJPNH/FMf/mIUD9/UDSNh
X-Gm-Gg: ASbGncvUcWuKauDjXf5gfLO3HGYG9lfgX4Fe8lZVbbxobLOrN5nh919Dcz0rY8F7nm0
	acrAhaH3E6zjwZuLr7EEylQzUJIEE4frHU7UBvHRWNN3SMo/QQFEW0idjkpQ56TlALgDR0/GnZ5
	oOiHC1YQtH+QSSPNJMsF3pnQ==
X-Google-Smtp-Source: AGHT+IFWXh0yFO7z3L63g2nBFj2oceDmKgi5YFAC9j7XRPJepA6ioWim9ydy1BDijgGa2Z1ESKlcjls3qaIJWFmsWGs=
X-Received: by 2002:a17:907:7da1:b0:ac1:e6bd:a568 with SMTP id
 a640c23a62f3a-ace84a7fe91mr698641766b.37.1745838368225; Mon, 28 Apr 2025
 04:06:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Sebastian Feld <sebastian.n.feld@gmail.com>
Date: Mon, 28 Apr 2025 13:06:00 +0200
X-Gm-Features: ATxdqUHJx7yDICJ9jtHK_SbVkFDyNVwxl7x3kzknwJJTcW3105g89wB9Q2C5F9s
Message-ID: <CAHnbEGLHGX2rMnf=S6CasoNyc939DTe-whcsjt9WhSWG920OoA@mail.gmail.com>
Subject: fattr4_hidden and fattr4_system r/w attributes in Linux NFSD?
To: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

I've been debating with Opentext support about their Windows NFS4.0
client about a problem that the Windows attributes HIDDEN and SYSTEM
work with a Solaris NFSD, but not with a Linux NFSD.

Their support said it's a known bug in LInux NFSD that "fattr4_hidden
and fattr4_system, specified in RFC 3530, are broken in Linux NFSD".

Is there a fix, or workaround?

Sebi
-- 
Sebastian Feld - IT security consultant

