Return-Path: <linux-nfs+bounces-11803-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A8364ABBE8C
	for <lists+linux-nfs@lfdr.de>; Mon, 19 May 2025 15:03:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DFD497A4199
	for <lists+linux-nfs@lfdr.de>; Mon, 19 May 2025 13:02:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 553A5136327;
	Mon, 19 May 2025 13:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RylGgC/D"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A27D2A8D0
	for <linux-nfs@vger.kernel.org>; Mon, 19 May 2025 13:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747659796; cv=none; b=aFQNFjjptTU/c6V9Sach11OCWy5p8KOeGuq+TSpn/Nb9gVBvU/EbvfcaPh9jZe25HYPelVmcXd+Dx5jt3P39imFRzJanc0WCfef/RebIbSSbob6Jl92mo1HXQ7p7EjtWK2Y6uaORcatOzNDuXfksPK1UFa/BU/e+y16MMviOTaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747659796; c=relaxed/simple;
	bh=dH6nmy0xv95+82EaUNpyEkooNgg+yuvjoY3gb5hePnw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=BVEg3bk4KgQfyc4/HUsGmPWbefa+W53pkkoktLynRge9UXzPocDfOlUaajFXLNzWA9tsTSQIb8R2DkUeuW/T++bLSDVOKu8iZ0KsOV41kOLgi47DFwvgMW46wqHOKVPoQOAYNq2WR/enj0pDmOJjqcHwhESDKCfHANdWVuBr45U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RylGgC/D; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-442ed8a275fso54993575e9.2
        for <linux-nfs@vger.kernel.org>; Mon, 19 May 2025 06:03:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747659792; x=1748264592; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dH6nmy0xv95+82EaUNpyEkooNgg+yuvjoY3gb5hePnw=;
        b=RylGgC/DIZnsRiK2P0pP7QVUeHDBJ9VVXlHzv5U2hSwEn1pkxF7Cnd9ZAuuG7sEHP4
         ahpOJfev3eaZgc23jJWr6yfdIO/2IhNNjmEo6xCLOpmThIOj0bNUl2UlkOY1DvYGNlZu
         rP4UOOfPC0xS3Al/zBE4KsjB0VCM0FmXa1U5F+1+TSandvJ+62wAbAcvoG/vW4SQz4qz
         +u0rhDjmdcHtyHARuiibkVUFC6QeXUxYW2RETokyyQp49wm/b7WBBLUHa3I8lkBtWKdg
         sEvy75zQbo7AVbiQSraWiKGQeikxRe3bBqUS1RLvPOWV1IjOcN+3GpLT1QJ+5pVkgqMY
         STXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747659792; x=1748264592;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dH6nmy0xv95+82EaUNpyEkooNgg+yuvjoY3gb5hePnw=;
        b=KTsjS7+hfADcDm3gep/75wU9ZeMQC1+Lr75IO37dgDJyqikvVYg4zeny9YZJsFlYXD
         KWUC1eqgUOx25ElKruM3BI2/UnjVB1rehEZAt22/LU0ZhwFPu7tQYghLVxoI1RBkijjf
         Ar0elulc+7h2fJK3DDbefeO/RkClFRNlyWe7bY5c7DwniBKQ7RhqyFUinW26d/nova/F
         dbtcGML4gOeGeWziIxoJ/flWzoCR9zF6eKiq8ShwrFZTH0eCTqkIEEGBs8C0NfVRJpKf
         mpMPl5ZUopLq0Jxw8wPROVBLDyoD2yjCCbld3eOZ3cHwSJFJL/LeKmEiwz1R9h4Pq5yh
         z9Xg==
X-Gm-Message-State: AOJu0YwZHCf/Rc1PjP3XmNusz3U8DLbPdi6/EvHVnUKsok7SkyC2isO7
	g3dkeQiIs8K8HfkmdauUHdfePol2Z1txc8Bt+Ta1jDQ5ypJIsZdmTzPcsXS9xtPrAt/+0i9xX0y
	HWzYxyHpN9IpiZvP1bizHvhOLYf7WUBnDeA==
X-Gm-Gg: ASbGncsWLchgX6mCI3RR+KFyD4B9s3BQv2jvwm2ueZ+SKn6d6IRQ7IK1b61c8pDidye
	u4dupMGOPhKb89LCSA8hQuu/8fUWYRdnL5jeotzNrZsopNu0KcIhfzIhYsS9B3rUT/O2fgY66Mg
	EW3rRPVaT2fJwjzFC3voc5J81mhvrZ1Vc=
X-Google-Smtp-Source: AGHT+IHuDAtmwYC0bQxHHdhwegiu4eOzpYCd3G2kMD64nz8w9jjbwpED1g1MQKjSKO4N8LNN2seHcYyvrZmwskS89qg=
X-Received: by 2002:a05:6000:188d:b0:3a3:6d2f:ed29 with SMTP id
 ffacd0b85a97d-3a36d2fee1dmr3606357f8f.23.1747659792152; Mon, 19 May 2025
 06:03:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANH4o6Pvc7wuB0Yh8sEQDRg59_=rUNtnpgJizZ5mmmGNgY5Qrg@mail.gmail.com>
 <CAM5tNy7MCKPgg7+fNJk3SkTp9Au6G=2XBK+8DfxKQQ8-GvaA=Q@mail.gmail.com>
In-Reply-To: <CAM5tNy7MCKPgg7+fNJk3SkTp9Au6G=2XBK+8DfxKQQ8-GvaA=Q@mail.gmail.com>
From: Lionel Cons <lionelcons1972@gmail.com>
Date: Mon, 19 May 2025 15:03:00 +0200
X-Gm-Features: AX0GCFvbVsd22ihJ9fjt9buW24yE2Bj4CJUq7dly5_OmR2ci-9-aFrVKQsjKlK8
Message-ID: <CAPJSo4VU8UP1bzT=FssnBU2EAtLmVoKg4icxLA6bXmNUNtVF_A@mail.gmail.com>
Subject: NFS/TLS situation on Windows - Re: Why TLS and Kerberos are not
 useful for NFS security Re: [PATCH nfs-utils] exportfs: make "insecure" the
 default for all exports
To: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 15 May 2025 at 04:09, Rick Macklem <rick.macklem@gmail.com> wrote:
>
> On Wed, May 14, 2025 at 2:51=E2=80=AFPM Martin Wege <martin.l.wege@gmail.=
com> wrote:
> What other clients are there out there? (Hummingbird's, now called
> OpenText's NFSv4.0 client. I was surprised to see it was still possible
> to buy it. And it probably can be put in the same category as the MacOS o=
ne.)

Situation on Windows:
1. OpenText NFSv4 client: We've talked to Opentext about TLS support,
and they do not know whether a market for NFS over TLS outside what
they call the "Linux bubble" will ever martialise. There is also risk,
both engineering and drastic performance degradation if the Windows
native TLS is used (this is a kernel driver, so only the Windows
native TLS can be used).
So this is not going to happen unless someone pays, and the
performance will not be great.

2. ms-nfs41-client NFSv4.2 client: I've talked to Roland Mainz, who is
working with Tigran Mkrtchyan on ms-nfs41-client (Windows NFSv4.2
client). Their RPC is based on libtirpc, and if steved-libtirpc gets
TLS support, then this can be easily ported. But Roland (didn't ask
Tigran yet) doesn't have time to implement TLS support in libtirpc.

3. Windows Server 20xx NFSv4.1 server: Other department went through a
cycle of meetings with Microsoft in 2024/2025, so far Microsoft wants
"market demand" (which doesn't seem to materialise), and cautions that
the performance might be below 50% of a similar SMB configuration,
because TLS is not considered to be a good match for network
filesystems.

Summary:
Forget about NFS/TLS on Windows.

Lionel

