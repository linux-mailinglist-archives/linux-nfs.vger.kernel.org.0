Return-Path: <linux-nfs+bounces-16334-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A19DC5568D
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Nov 2025 03:17:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C73D3A781E
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Nov 2025 02:16:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 743582F5A22;
	Thu, 13 Nov 2025 02:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dUjVfOvl"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13CC92F49E5
	for <linux-nfs@vger.kernel.org>; Thu, 13 Nov 2025 02:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763000209; cv=none; b=D4tmd6REkxWBQpO1pBjRlN1AfyBkeG9qouyX+SVzFDtrg19ELmHhHWcfCePYJYemjnRlQOfabJDdPMXpoegk4CMtJWQyctXdJwjrHa6CLoeQAq7Y/fH8WQ+vAax+KNmrFcD+DPnflBm0cNDdaNNaqPCNDalhe4UDm8w9cZz1PEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763000209; c=relaxed/simple;
	bh=ZRaD/fmerrjCeoqkuiGO/IO5MiZ5XDL7oIGJfPfg9Ao=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mFc6e5jN/vp0p+44nK+XTHhk6TsAJQ1RWj4a+ueryXUoEo7bRth+Va+1wVmkKtp6sg5nCuG/yHSrV3OpNLOSjJQ7ij6pFmp7wSTmBpdDU9hfGCCtUCglLp2ReKK6BsR7e+UuYf5gUuBKl0fWm6fO/CwTjbZUO1UvdBE08DZxaYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dUjVfOvl; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-787da30c53dso3257827b3.0
        for <linux-nfs@vger.kernel.org>; Wed, 12 Nov 2025 18:16:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763000206; x=1763605006; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZRaD/fmerrjCeoqkuiGO/IO5MiZ5XDL7oIGJfPfg9Ao=;
        b=dUjVfOvl5mUO87tZtRc81Twq5ZvwfdO7PA8zJenEtNbv22JWMiROpkY6iNKzPwwdWo
         kk/IFPOFdyrZhuXogOBTqNaf4xn8U9Pwa6iSt1k6uAgTmVPiP7f/f8zHFcwlz2J4FqRS
         v9DXpPki6a82nS1TDFR/LnDnGGMowihGxAsY3CvdWXIkTYNtIkoOtGJJbVzCr1DyCE6L
         tJVxdKSkeHDAg1WCH5amh3BfQsdnx+0qWpelocUvNV5JDkJhizghjORUkWWhJtnC9c/P
         zCzzHP31HyEU/SKDzxPQNlE2lfaxKaPMYhMmA3XbkCVYI5anA7Pm77NrIxDV4k/nYEyN
         H3xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763000206; x=1763605006;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZRaD/fmerrjCeoqkuiGO/IO5MiZ5XDL7oIGJfPfg9Ao=;
        b=H4VgJ6wL0CTB5tLJ07llx+lpgeqGp5PM4r5+tL8Z2TyTxoqBqVrcCroYLCZ/olU/mC
         IlnkNd3iaeyc+jHMugmWrsv+ysyQvzZms7zl+hvNYO5D7WhcocAtKhfsCZ4E3n39WPwA
         hXto9BbBvXkvWPftERfPZojBJhw/tr3FWu0ahJi0FlZcKsUvrCxMWT7fCkaauVQMU8D0
         bA0j+efHCwQOV8rzv/5NP3dMaYQqc03ApmbUypg1Vk0zZEFlX4TbYO5YC7tCvI2Pz1mH
         29Kp6Sr5AXbszpJl9+wx4kjSgdGJJ9MPN8eOVO62MzSePhsAixUM+sbl1UE+BIUHV1Z2
         WswQ==
X-Forwarded-Encrypted: i=1; AJvYcCXLkcouiT1RNS2i9jg5Gtww5r7SpLNJZJM3mmtEc3QOAlOioKddVk2odPYb2qCwVl9JFiXKkuPwP7c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzx5VGI9/jykFVTR9YJBI+ypCrQw4KD3m6VkNqlpsZKc671y5We
	6s4KhGkMgJJnMvXWPSuf5WErTAjpFcmfxKbDtj9/+jePxz5lWP1ACrIhifbOuewg0P5v3+IBN4T
	dE9rxj39QtLGFbL868S/OOc4zDFcHXF0=
X-Gm-Gg: ASbGncvw4/mpOAjW+QIM5IcWhlFesYp7L4Fw2MV9jq2lCAjtRwjUzxSGKzLV3riN6YI
	fyrnAaCGnSVTKbAojxbD0J7glHj3W4qlah8nqb26QRjcO9LwbMC6sA+z3piztj/79xd3eijIJ8I
	6GftFV6in9PtOX1gwAEweLpxlBeBl+2wMIpxS/wn3JJNsB9pxpLTGEShWI0l7U8sd9Oap33cOOV
	13k6DsReYC8S/kEw2RxtjWVtiqn2BWAS5PYaj2b5zHR/Qlm3l4/VazNVe7NfsRvce3dVOiLu1v9
	Le4+wDexU2VbT26McG4foJMh5A==
X-Google-Smtp-Source: AGHT+IEoQGXbDOXpCMV0uLppel/d5OJBdh/BTOE0WrwFdCg3bNRboPUEkEHpLZDtG4hlmvXsyGaHqhvMoipnvR4oKDg=
X-Received: by 2002:a05:690c:5301:b0:787:f72d:2a57 with SMTP id
 00721157ae682-78813626ef9mr34068247b3.15.1763000205991; Wed, 12 Nov 2025
 18:16:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251112042720.3695972-1-alistair.francis@wdc.com>
 <20251112042720.3695972-5-alistair.francis@wdc.com> <3438a873-bda2-4a1c-af8c-76e31a200c79@oracle.com>
In-Reply-To: <3438a873-bda2-4a1c-af8c-76e31a200c79@oracle.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 13 Nov 2025 12:16:18 +1000
X-Gm-Features: AWmQ_bmGVjeLJyvzqCH0oIhjJJEC9KDxsd28wVqF9yRjrr2nfAiVpGZrrJdTjQw
Message-ID: <CAKmqyKOj_vB3dwy2CO2JacL-w6WSm-2HYHuikndsLfYCQvwZNA@mail.gmail.com>
Subject: Re: [PATCH v5 4/6] net/handshake: Support KeyUpdate message types
To: Chuck Lever <chuck.lever@oracle.com>
Cc: hare@kernel.org, kernel-tls-handshake@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-nvme@lists.infradead.org, 
	linux-nfs@vger.kernel.org, kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, 
	sagi@grimberg.me, kch@nvidia.com, hare@suse.de, 
	Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 13, 2025 at 1:49=E2=80=AFAM Chuck Lever <chuck.lever@oracle.com=
> wrote:
>
> On 11/11/25 11:27 PM, alistair23@gmail.com wrote:
> > From: Alistair Francis <alistair.francis@wdc.com>
> >
> > When reporting the msg-type to userspace let's also support reporting
> > KeyUpdate events. This supports reporting a client/server event and if
> > the other side requested a KeyUpdateRequest.
> >
> > Link: https://datatracker.ietf.org/doc/html/rfc8446#section-4.6.3
> > Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
>
> I was not able to apply this to either v6.18-rc5, nfsd-testing, or
> netdev-next, so I can't adequately review or test it. Is this series
> available on a public git branch?

You might have missed Hanne's "nvme-tcp: Implement recvmsg() receive
flow" patch that is required, it's mentioned in the cover letter.

You can find this series, Hanne's patch, a few other patches that
are all on list and some extra patches I'm using for testing and debugging =
here:
https://github.com/alistair23/linux/tree/alistair/tls-keyupdate

Just remove the top commits from that branch to get just this series

Alistair

>

>
> --
> Chuck Lever

