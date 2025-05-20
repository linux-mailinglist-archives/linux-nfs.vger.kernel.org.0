Return-Path: <linux-nfs+bounces-11833-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B383AABCC66
	for <lists+linux-nfs@lfdr.de>; Tue, 20 May 2025 03:38:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B67B11B605ED
	for <lists+linux-nfs@lfdr.de>; Tue, 20 May 2025 01:38:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B7C44B1E5C;
	Tue, 20 May 2025 01:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SMfu9FpK"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8202B253F35
	for <linux-nfs@vger.kernel.org>; Tue, 20 May 2025 01:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747705093; cv=none; b=kcD3f8KoB4E+5spF6QjNRx9oirunsvX3OKqwuDdE+j+wr2N6O/sBC0NjtkQLDqMUspqCUsG9Fyew/+fRhJYCOzCBwMuk14RtMIyBBQxWrlHwB1ln5XOvjsnj4SeNLt+f1XSyyxjJustEojiZBlN47TQW78A3xsEuZhj4kfo6ocM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747705093; c=relaxed/simple;
	bh=eljU35hDbEAdHwRTu2RNu6BR2B97PG01DTj/9T+KyAs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eSflGqMW7HhYpsGHI7CiWCPhI6U6XFxrzIFXMoCecAS2byGkLyC3tv6EJ7dDRHHFIouIOKrpVlxiy2vrMcMiQpJruKdIiwhqxfvkFpakp+KXhg4f7Z4tiS+iraEFcu2pRLyPtKqchgvez/Qjw4YfaYrKXwHDMMauChpR9r+T2I8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SMfu9FpK; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-708ac7dfc19so47388127b3.3
        for <linux-nfs@vger.kernel.org>; Mon, 19 May 2025 18:38:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747705090; x=1748309890; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eljU35hDbEAdHwRTu2RNu6BR2B97PG01DTj/9T+KyAs=;
        b=SMfu9FpKITBYEZFa0zrWsjc3X1vDnsgoB1AzhD9lsUrFk5EtDksXmZ2FsjlddpngCr
         F5eAHwnBsk/vGK2k2ME7OzFySBmIuIX8js58jaix1Hhi8W+zXU+vg3tf8tUV1qb8GWFi
         w6BbyoEssYYtzpOC/WZ0Lcm/kgWtRlduUvXVfxgjJzn+hFB7+R4mfcRojy/+YiGid2e+
         iCDy8zcYHpOxg8CnpWmd47NtMbabKrGMAP9AS3gEbPI7q0uYCnb0N2p+oniqyN1IQdDh
         VwYLjd+LTE2Rg4ROkJ+es/AT3LPSdTIdrLaOB8JBRcupiBUGc0iaMBaGgbJRSlR1XHiv
         UPuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747705090; x=1748309890;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eljU35hDbEAdHwRTu2RNu6BR2B97PG01DTj/9T+KyAs=;
        b=HCiGPOBC4SlTQ4czLnW57+pDi7fsjmI4fEr3DYe6jxJ2auio5BIhZ6Hci13ZodUw4u
         D7jqHcGnki1mxx009HXql8m8dboi8N2gnBl1rRgsPSTGPaC+cxMXlwUiXyDr1OZNTiWx
         k8qifiggMuanxP8TnL3Cqn0moA3OiAt1ID+ZbWrUqqK7sf/aa6QMtqRegFq3Wkux/kMD
         b6Toi4sa5nnM52ZwXYSzSjNJssTfoqHmpaJ0ss2U/zADzzva1pxR2zF0VQC8+vMkdi5i
         qmdzuQZOgAm58Ah4uNjbtT7C1K0inLGqed4AJZ0O5M1E4HDw5BZ2fcMj34QHuj1rlGS3
         sw8Q==
X-Gm-Message-State: AOJu0Yymt4mZk+tI4DK4slbGDvOP2rNH9KvewKcIlaGGMPLLcrO1pPhi
	wXn3NP5nsUVBcr9YecmO3Qs9JrTP68Lfr7pwAy7Xn9+p8w6vbf0b0DXCzx7yZn9704qd+VxWcUm
	xPcYSvvydn+sk2PJPGPLc3US4c8rUPRO4afIk0/y0
X-Gm-Gg: ASbGncvrRtllfwMeYiKxNe/9YwsJNaH0u9nAaypTA+oUxxblC7K6sPsU0XuUIbYYsLZ
	nKpuv+a9LE4QUseU00KhnF1U8LYre/V5gvkeRdzjc2CPBRrz0NMLbXG+JfzMZxVf0VvCN2uBbak
	9eCpfyYz+kjLc/AVPmgwTOxwoEEnTzlsI=
X-Google-Smtp-Source: AGHT+IHo44Qw6QfyUmKw7ToIxUqepSj+0BXlq/f6qhssc3gQ3YSk/2rzf+8pthr/U4koqcgbyYGSKtPJLvbHoS3R4Qg=
X-Received: by 2002:a05:690c:d0d:b0:708:100a:57b0 with SMTP id
 00721157ae682-70ca797ae55mr186602297b3.8.1747705089992; Mon, 19 May 2025
 18:38:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANH4o6Pvc7wuB0Yh8sEQDRg59_=rUNtnpgJizZ5mmmGNgY5Qrg@mail.gmail.com>
 <CAM5tNy7MCKPgg7+fNJk3SkTp9Au6G=2XBK+8DfxKQQ8-GvaA=Q@mail.gmail.com> <CAPJSo4VU8UP1bzT=FssnBU2EAtLmVoKg4icxLA6bXmNUNtVF_A@mail.gmail.com>
In-Reply-To: <CAPJSo4VU8UP1bzT=FssnBU2EAtLmVoKg4icxLA6bXmNUNtVF_A@mail.gmail.com>
From: Rick Macklem <rick.macklem@gmail.com>
Date: Mon, 19 May 2025 18:37:23 -0700
X-Gm-Features: AX0GCFu4aYglNnpXVKkbhzoQu97uDx0wrM3owjTq15UiKQMAxcVFXO_t9YxmIYI
Message-ID: <CAM5tNy61mcXY8LoP-Ve2L7Qpb8pmtb=+MyfC5Q=otq7_Bc19CA@mail.gmail.com>
Subject: Re: NFS/TLS situation on Windows - Re: Why TLS and Kerberos are not
 useful for NFS security Re: [PATCH nfs-utils] exportfs: make "insecure" the
 default for all exports
To: Lionel Cons <lionelcons1972@gmail.com>
Cc: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 19, 2025 at 6:03=E2=80=AFAM Lionel Cons <lionelcons1972@gmail.c=
om> wrote:
>
> CAUTION: This email originated from outside of the University of Guelph. =
Do not click links or open attachments unless you recognize the sender and =
know the content is safe. If in doubt, forward suspicious emails to IThelp@=
uoguelph.ca.
>
>
> On Thu, 15 May 2025 at 04:09, Rick Macklem <rick.macklem@gmail.com> wrote=
:
> >
> > On Wed, May 14, 2025 at 2:51=E2=80=AFPM Martin Wege <martin.l.wege@gmai=
l.com> wrote:
> > What other clients are there out there? (Hummingbird's, now called
> > OpenText's NFSv4.0 client. I was surprised to see it was still possible
> > to buy it. And it probably can be put in the same category as the MacOS=
 one.)
>
> Situation on Windows:
> 1. OpenText NFSv4 client: We've talked to Opentext about TLS support,
> and they do not know whether a market for NFS over TLS outside what
> they call the "Linux bubble" will ever martialise. There is also risk,
> both engineering and drastic performance degradation if the Windows
> native TLS is used (this is a kernel driver, so only the Windows
> native TLS can be used).
> So this is not going to happen unless someone pays, and the
> performance will not be great.
>
> 2. ms-nfs41-client NFSv4.2 client: I've talked to Roland Mainz, who is
> working with Tigran Mkrtchyan on ms-nfs41-client (Windows NFSv4.2
> client). Their RPC is based on libtirpc, and if steved-libtirpc gets
> TLS support, then this can be easily ported. But Roland (didn't ask
> Tigran yet) doesn't have time to implement TLS support in libtirpc.
>
> 3. Windows Server 20xx NFSv4.1 server: Other department went through a
> cycle of meetings with Microsoft in 2024/2025, so far Microsoft wants
> "market demand" (which doesn't seem to materialise), and cautions that
> the performance might be below 50% of a similar SMB configuration,
> because TLS is not considered to be a good match for network
> filesystems.
>
> Summary:
> Forget about NFS/TLS on Windows.
Well, for #1 and #3 I'm not surprised and would agree.
I would like to find a way forward for #2.
I will take a look at the libtirpc sources and try and cobble to-gether
a prototype using the OpenSSL libraries.

I am not sure how helpful that will be for Roland, but it might be a
starting point. (It depends upon what Microsoft provides in the kernel
w.r.t. TLS and whether the driver uses a libtirpc library built from source=
s.

I do plan on posting to the mailing list for #2, since I did a short
test drive of the driver.

rick

>
> Lionel
>

