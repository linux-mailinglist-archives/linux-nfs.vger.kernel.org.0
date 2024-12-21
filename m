Return-Path: <linux-nfs+bounces-8705-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB2BF9FA28E
	for <lists+linux-nfs@lfdr.de>; Sat, 21 Dec 2024 21:52:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 383E7166493
	for <lists+linux-nfs@lfdr.de>; Sat, 21 Dec 2024 20:52:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 490BD1D5CF1;
	Sat, 21 Dec 2024 20:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FV6EuKVC"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9B4A1714A5
	for <linux-nfs@vger.kernel.org>; Sat, 21 Dec 2024 20:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734814360; cv=none; b=ZL+3oe4jBDTsVr5bE3ruFHTXHcxp3oZOwV2jd9pkTzf1GWBOjVVUCP/hNTgXbVay0xZBMj1bCqFMVU2kgg1CMVqNZ3+/ARfSCoQ1EykdkS7ncrNKoW4ecgRvCiWroK2+/kblkdLl8vB45BxECoH4NPE1Rh93dCEODkgqnq/O7Qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734814360; c=relaxed/simple;
	bh=xRPuLJymB/k3CL5p8daTg1/Zfl/VDO6MrYim5xpqcfU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ehzDlkjdSXAX9d7OOjWLdKzKYG6FhJl/Inq9y9DsF6pkv5Fezs0di6j0zfNYCeu6rds3eIjP1VwyD1GeY7KrL5FWdSGzQYdMkU5UCdLcIauZY6tdprRyRoKj1wd3bpPedmmAfHlx8L0jgaWZNg1Cz6QhB8oskQ7aXmxS8pGm6fQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FV6EuKVC; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2eed82ca5b4so2610963a91.2
        for <linux-nfs@vger.kernel.org>; Sat, 21 Dec 2024 12:52:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734814358; x=1735419158; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xRPuLJymB/k3CL5p8daTg1/Zfl/VDO6MrYim5xpqcfU=;
        b=FV6EuKVCAZE2ccOMU6RKfZBMWbMVlzLxOd6+1u2b30NYXpcOYWQQvxY32uOBLBzmG8
         xHP1fJehb7HrXlKeg8pl5PgH4zBA0eigrV6jTV6C8Wg0klX6ZJ+3eRDYyJshGLHzZaGp
         +i3wd72XhQtBl4HMfNTWXJXjnTNj4YvwIGTn10mFKnfNk6vH/8BK5SIERPxpaEgOvOwO
         Bh+wH80tm+Meq8cm3Xk/bb5ikkQlKrZEWWwd0X2cFjo/XqmV+OnElZMKXtT8PnDyE4Gq
         /WZqUZmYk7lRgN0H7bO9753QSfG02TbBbUSkt0g67v7mVKrOnRVRcnPEYadmNjviDOmV
         Uk+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734814358; x=1735419158;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xRPuLJymB/k3CL5p8daTg1/Zfl/VDO6MrYim5xpqcfU=;
        b=rmhxA7vdYw5ZoZk3tg8tJHSdLfsG6i9sMnnpvcUZD6xyK4hKu69BVvAXxMqNwLn3yk
         J29Zpd+7/DwPQpSIKF6goQfBRlqNmnYn7zbV0y4tlI3KS08l84LZZnNgLAF41YEy+bJd
         wJ8gQW+fNole5AWXZoElvF+gX7pz3hINg0BGMlheXPBvbsT7b8PNKNOeGnjTf6CGTPGU
         J7MNIjfS+oryx94O6etcDlwDU09fkoQhF0DU7wMdWrA3RbMGyZL55QV66uZ+twHO8TBV
         nbzcznRRo7TMlZltcJPFx0rOcN2KUv8aAvcVVCDrcBj2pv/vmdrBHfmllPfkDmg5a+7H
         acww==
X-Forwarded-Encrypted: i=1; AJvYcCWjsHmRmDzfDmX15Y89D7Uzx45JxPAoBZd8UuDVa2AjZgl4bF/gLI5Vc6yfc9ifOmBTJIU8t2Wut2E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8g9x79VoG9wFtXdM4JRHsp1BoQkXLUF4epMUIIzSUnzquCdoU
	z28+qK0+JCbiPKVRtWUJgJpn50LDQ512VGECBD/IBwwsVJv+8EKIVUePiYdyOL4f9uWy1umJhpZ
	H8YM/aYzEG0lPAuOwx32j7geewis=
X-Gm-Gg: ASbGncvj8Y+QbRt0uD9E69gIJMbSeZXQnBm4CeFBzUk+cKUG4+l4K9liIZxl2Mpq9Wh
	Ajw9vuuCbUu38+4xnlY2+FT0reu3HmvYnkTeb
X-Google-Smtp-Source: AGHT+IGjv3igKpUC0/G8xNbY/liXw+00eRlUCoZ21nd924Jwr3vwYMt5LYypB+DJOPRie/jogHM4SKFXjJIvUQ500Eg=
X-Received: by 2002:a17:90b:520e:b0:2ee:c9b6:c266 with SMTP id
 98e67ed59e1d1-2f452e22592mr11511001a91.13.1734814358191; Sat, 21 Dec 2024
 12:52:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAM5tNy4-SNVD+zqgaJTmLtAQ+kKV_Ce4tRr2zqgjTq1KPM-rfQ@mail.gmail.com>
 <4804ce6a-fa67-4b50-bc31-715689d3c766@oracle.com> <CABXB=RQn8qU5TZsWyBpWNaDQpaMPhdi4RYVJ0D1qJAWiFuBAHQ@mail.gmail.com>
 <e4853faf-0836-4595-952b-69f71150bede@oracle.com>
In-Reply-To: <e4853faf-0836-4595-952b-69f71150bede@oracle.com>
From: J David <j.david.lists@gmail.com>
Date: Sat, 21 Dec 2024 15:52:26 -0500
Message-ID: <CABXB=RRE-wJ_q6v-Qq3FDb_sz8+AOsg_AQhZt7pYt1qCQjph5g@mail.gmail.com>
Subject: Re: knfsd server bug when GETATTR follows READDIR
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Rick Macklem <rick.macklem@gmail.com>, 
	Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 21, 2024 at 12:34=E2=80=AFPM Chuck Lever <chuck.lever@oracle.co=
m> wrote:
> Out of curiosity, do you see the problem recur with nfsv3 or the other
> NFSv4 minor versions?

Great question. I tested this today. The issue also occurs with
NFSv4.1, but *not* with NFSv4.0. (And, not surprisingly, does not
occur with v3.)

Since I believe OpenIndiana only implements up to v4.0 that might
eliminate it as a useful third point of comparison. I'm not sure if
there are any other open implementations of NFS v4.1/v4.2.

> Since this isn't reproducible (yet) with a Linux client, let's try
> another set of network captures, and you can send these to me
> privately.

Will follow up on this as soon as possible.

Thanks!

