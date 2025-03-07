Return-Path: <linux-nfs+bounces-10528-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B369A56D34
	for <lists+linux-nfs@lfdr.de>; Fri,  7 Mar 2025 17:09:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 163267A8308
	for <lists+linux-nfs@lfdr.de>; Fri,  7 Mar 2025 16:08:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A859A226D0F;
	Fri,  7 Mar 2025 16:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F4WjY/dM"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9ED7226D11;
	Fri,  7 Mar 2025 16:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741363776; cv=none; b=nlxHBjq8tOi2B82zYL0urfWI0ilDPab0Fr+/1lAJvPJTIS1j6hVo/nUm67wj9Weg0bobe2GcVWrSrcS32CzR0nYqB+CVS9fEKeRppsUGcZjavkltc4Gglb0ewS4GRS17ma4dkDXELzJzum4OavEytrn0UbX0qc9DrchD37L8SjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741363776; c=relaxed/simple;
	bh=vJ+jf3Jx0DsxFUkCZwqaWfUCJ9ZSvn+hNc14SICc9g8=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=fLzopKC8FUJ8P7i5NjkR3RdTiMUwY2pCTaxuFpDZTIdvJTPsROUITYHxW8IpE1V9gB2XXQuL4pTTNRjyxh0qrC2wvs3vf/yD+WnBnRDabrpJYRL2vItEffj/T7E7eIdxSKzptlEfZrepafMRxIiMKwP/NUDdv5sgRR/CEeA5qfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F4WjY/dM; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-30bee1cb370so15632641fa.1;
        Fri, 07 Mar 2025 08:09:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741363773; x=1741968573; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Y2wGs5UXG2ODNyJagCD7ka8U4DqPW7/dd5bx6dOjGVc=;
        b=F4WjY/dMxo5Ii5ki82NQEOvDQtaaD/nb0dzwJJSCUrJn1oJ2AImX6IpctvlnC6r2+y
         vB3+ghQRbhuJ94DTYydKMWReUNoArMg9H9htyFIv0Ulo8yolxiPy4Sa1ExWXadndMFJL
         /X8U1WJj0+FPwLwH/TFdi8TCxDHMR7pQlUlfKWZgaLKK4Y/yIzFdGGJtL6ortvo0fUdW
         ws0jceHNPACBx85DzOaScHmBbVsIWSa4r4NzbBCmYLw9uGIM67zlURfe//JMS5VkIQUt
         RE3f+XywLQn8ywT4sfD+QDA+9ln5wX783pqiKLHQ/EGYEKTA1gYbwfvSVbPpMofibkiR
         DmGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741363773; x=1741968573;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Y2wGs5UXG2ODNyJagCD7ka8U4DqPW7/dd5bx6dOjGVc=;
        b=LeaAuob0J+GzyT3+BsomwV8Y163VjREb8YflHDmwq7akL4ycmRr2JSiGKSCdyvoRbv
         fmQZ/ZRMyNjDZe+JgSI5vDv1JnGvyqyVVjHEyR4ZwVQR41N9jcmRm4I+Vu9pbD4EgwBE
         rT4N/f4Iz3o0RTUSvwBFXFiGef9CMN3oex9GUhp5a6kSLXfbcLrpX5lmDi1odzVG8xDb
         DRPGbvDn1+5iLKgrVM9aA7bH/wq/q/QhUR8jEEBgpV4uLg9HRiAmExBm4AdS+cUmbamP
         6m5c2v1cCdU3LlNu3/GOHY2rIIVFaEajRss/ssAXSIx6UHjHH37xA8keF76Dtfk8gMpO
         bu3g==
X-Forwarded-Encrypted: i=1; AJvYcCVptrWoZuFqkPmJMLx3vteJRCvBjBUH/lQcuMQ2kaHecZ5wQb2iA0gnpxbJMrlxFbKslsstRAWQBUMJ@vger.kernel.org, AJvYcCXynBWMiA6J2lOZJwSf65Ppyy/7eTOYldDI9VjL4aibAysm1/SvwqZa0LVDktELumy6Hkpi3cmMpuoyKMM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyE8ZUHF5M5nJEUPSD2Lo2pC5Exxg5QQHqOYNFINwUvt4i4aZ7I
	dLu2zpwCAmL3ZT3Xbvd9jcLHL4rb3iTCz+H/hhY82m3cNDz4+zv567gz8HSwJIWzLEAr2kKgCfk
	6nd0AAySJvTtLDJtagtUdHf7ZKw0=
X-Gm-Gg: ASbGncuSYtdjxdz7FJK6JslyQhO8ni4gMQxPHhSs6Q+yUPTpVaa5Y2ON3S1RT24JOyH
	Pydl+8NObeOeF31Osz+WwYN5m0UNwhml2WY2lbp768osDNYO66EtWW62vq71x46vUHJy9n/y+42
	nJxMWOTvg7+UVYQ8pBD4cUAK6fNfudufXX9gNSLjzQtgq3X6ghY8U5Z+EPt0GK
X-Google-Smtp-Source: AGHT+IEGAo38UAEc4cQfuVmq5Jdsr88KuRMq/DhEusWgz0mo46DhAi2VuEH+tMH8CPg0BPgNIUeczUEJI+CaQB5LfZA=
X-Received: by 2002:a2e:99d3:0:b0:30b:f15f:1c02 with SMTP id
 38308e7fff4ca-30bf452c908mr14816111fa.18.1741363772920; Fri, 07 Mar 2025
 08:09:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Norbert Lange <nolange79@gmail.com>
Date: Fri, 7 Mar 2025 17:09:21 +0100
X-Gm-Features: AQ5f1Jrwvs7RoPwaNoYn3qlQZNg0CL7a1KYAB6ll61sjH1XcH0LjlfcPMcIjohc
Message-ID: <CADYdroOnqNT4uWz=XAfr1iuaaLmWMzSyciXzFSoMP+CoxMPDpw@mail.gmail.com>
Subject: Re: [PATCH] fs/netfs/read_collect: add to next->prev_donated
To: max.kellermann@ionos.com
Cc: Salvatore Bonaccorso <carnil@debian.org>, dhowells@redhat.com, gregkh@linuxfoundation.org, 
	linux-kernel <linux-kernel@vger.kernel.org>, linux-nfs@vger.kernel.org, 
	netfs@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

I reproduced with the available versions in debian:

linux-image-6.12.12-amd64  6.12.12-1 -> segfault
linux-image-6.12.17-amd64  6.12.17-1 -> segfault
linux-image-6.13-amd64  6.13.5-1~exp1 -> 'kernel BUG at
fs/netfs/read_collect.c:316!'

Then I took the debian 6.12.17-1 kernel (latest LTS), added those 3 patches:

https://lore.kernel.org/netfs/20250211093432.3524035-1-max.kellermann@ionos.com/
https://lore.kernel.org/netfs/20250210223144.3481766-1-max.kellermann@ionos.com/
https://lore.kernel.org/netfs/20250210191118.3444416-1-max.kellermann@ionos.com/

The resulting kernel apparently fixed the issue, I just testet in Qemu
so far (no signed kernel for secure boot).

Tested-by: Norbert Lange <nolange79@gmail.com>

