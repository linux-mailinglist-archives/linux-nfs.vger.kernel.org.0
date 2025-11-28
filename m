Return-Path: <linux-nfs+bounces-16783-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BDF53C93494
	for <lists+linux-nfs@lfdr.de>; Sat, 29 Nov 2025 00:16:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6A52E3463C7
	for <lists+linux-nfs@lfdr.de>; Fri, 28 Nov 2025 23:16:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1DD52E62A6;
	Fri, 28 Nov 2025 23:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hpD+YD84"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11FD9233704
	for <linux-nfs@vger.kernel.org>; Fri, 28 Nov 2025 23:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764371815; cv=none; b=BLjxDBXjXDZcu8u+2vAhdkF7ljW1NwhDp0FS6n7s+k7e/54YFaBccIZHlNCvGE1l9BYtUVNfr2lqxOEqTL9beZl0Al2dlbYIgbz2oMpeyUIn6D+fu88VAJjrbhf6WOLMRx3D0lpXljcP7bXtu6uHkpDlBwrGxlPC9RUjF6MVfsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764371815; c=relaxed/simple;
	bh=tFBSzm3ziSX2HnGlD7Fylufo2XH3JRCTl+cbouDgK54=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gv9XmcgOAsqM+wAWw5VNjHEu5aM/vARDPxqBCj9BpNZNQFZMZYQeNRSNImfZWRCYjhdu1F/4jvjg0d+fwjP57D0fcwUntj/3OMufXXi6rUWjTlQ1+h7ELK3ib0RJQcqYuFkb6ywtkipTUOi/H7uYfoJb5tOaeAjEdfZ8evMa6O4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hpD+YD84; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b7380f66a8bso362700166b.2
        for <linux-nfs@vger.kernel.org>; Fri, 28 Nov 2025 15:16:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764371812; x=1764976612; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tFBSzm3ziSX2HnGlD7Fylufo2XH3JRCTl+cbouDgK54=;
        b=hpD+YD84V9WGog0uv/iYvQCZTti9DXpeGTsGfiTscIHaZxQtWpZx35q/hUU2YL/Pbr
         KxcLt67n34Uq9O+nlk9DtXTIsQiJkzcWQVWgRdShF0nlRRCgrw8VeBwLN5TB+pw1bO2v
         T0XSYtN2SXHyk/Bj4HGBU3AiIGCUnn1KfrFNj+fsrXBfsFPzGIRRcn6S98WLLkT4WiPu
         6SmCELy6tZnpJ3fG9pD7SpShyCSjfy44QIFDyT/NcGVlY4HsjVoNPCVLW1wK6nyD7h1+
         xCNVyHH+lcUu6GI+eTrjxsbIB7mf3LwLuO9EwEB6ZBt39iuABTplOpPpBuMSt6X3y3W0
         p/eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764371812; x=1764976612;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tFBSzm3ziSX2HnGlD7Fylufo2XH3JRCTl+cbouDgK54=;
        b=ZwgIdM5sKlZgZ2FDd3mGDSu6A8s5O2ILCVI83/dbQnU8jSmWvIzOIw5E7xcgZQJ8hi
         kIvp23g7nA9ZX0alSqGlZ6uV3Ei4oBx/J939ABJ7/kd7AN/nsZb2PrnoVWLqhmHdKlzP
         6snaUqIbhvw6uSScTSr5eJQSZgcQQlwig03yNEwRLkJHxI7tDjFpxgxW8J95TU/yydS8
         vC9lW7t+CMrAJZtd0DatFPs1ODgpPIJX10RPYaSiRM8P2mRq7Dfpy+53xrowUNNSFNOJ
         roBT8lsO3KgpgpMrFf7PK4K0Raoc5sNtuvWkzEaGiKHgpZSb7h/k7n/RF6NQZg5A6nH/
         pa2g==
X-Forwarded-Encrypted: i=1; AJvYcCVJaU7L/sSFwUTZRGHl8E9juPzlrX23imM54JPGQSDmIRSNnHU8Pq4CUTyXspK2fTL9UvwPFAwArS8=@vger.kernel.org
X-Gm-Message-State: AOJu0YweV3ClS/q8QQxkSmLVLq0acJFuiAfRSN6/ypsVNpYrJ1RdrcN3
	zM7ucaf/HTW6RlVKt5g0LHUcUxqQVuPTfcqG+rl+R1tLHQSs3mkLRSH1cEEsgxajTrTbjNXQEj/
	/QO3qHciQefIcEIk6bbfEWFMwq+qiog==
X-Gm-Gg: ASbGnct3RC4qD2yPwmv8+FbQ3jRWCmqcZPD9/A7B/xgicrqyeinQnPoO34MrT/mc+Bo
	QYA8oeoyzM2U/p+hrUZJ8xSXzrmRrNxWmZhkq1+K8JxhtAnAjakzFUcXu8aLQQVmXp5TRaHeKgu
	UHJlHpATt7u0haKIpGOs6sYYOsA1MFnacFf0c/7Hscq//ionUOZQcWViWvjOaLg/6qFm+FkgGzz
	2vqr+D+dxAG24jEMqAPKDAtzS69lzM2EfFjzIaV3/7rGS/ILoYPnd/NH3r1p68evPjnrrj4Dsu6
	9+NVZQ66dUBUICkDffMKgXJCOdk=
X-Google-Smtp-Source: AGHT+IHeeYyNlhMBLcvKlxoLv5vSDViLpxq3LPnvUJ8i1uefHukfvsgCv8wWMFxUnlfmKlHkimPgQMKwGXw/XFBpvwA=
X-Received: by 2002:a17:906:b052:b0:b76:8cda:c936 with SMTP id
 a640c23a62f3a-b768cdad168mr1929424366b.36.1764371812092; Fri, 28 Nov 2025
 15:16:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <tencent_780E66F24A209F467917744D@qq.com> <5e1b3d07-fd80-47d0-bbf8-726d1f01ba54@app.fastmail.com>
 <CAHnbEGLi--K9R_JHhROR4YfY4gbD3NmyO3MwX2xrdX8fxxAAdA@mail.gmail.com> <d0bcf5cd-bfa2-4f91-b1ea-1159639303c7@app.fastmail.com>
In-Reply-To: <d0bcf5cd-bfa2-4f91-b1ea-1159639303c7@app.fastmail.com>
From: Rick Macklem <rick.macklem@gmail.com>
Date: Fri, 28 Nov 2025 15:16:39 -0800
X-Gm-Features: AWmQ_bmUWTMYIIK9yb0Bh70AJcaYyrEK9Azt6mCdOZMGeIxiOHzavTL7KzSIp-E
Message-ID: <CAM5tNy6jjeoN0H_JcD=8Ci4X8hU=4oyn3ZxRJrhpxJgApZUCcQ@mail.gmail.com>
Subject: Re: LAYOUT4_NFSV4_1_FILES supported? Re: Can the PNFS blocklayout of
 the Linux nfsd server be used in a production environment?
To: Chuck Lever <cel@kernel.org>
Cc: Sebastian Feld <sebastian.n.feld@gmail.com>, linux-nfs <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 28, 2025 at 8:24=E2=80=AFAM Chuck Lever <cel@kernel.org> wrote:
>
>
>
> On Fri, Nov 28, 2025, at 3:57 AM, Sebastian Feld wrote:
> > On Thu, Nov 27, 2025 at 5:41=E2=80=AFPM Chuck Lever <cel@kernel.org> wr=
ote:
> >>
> >> On Wed, Nov 26, 2025, at 9:14 PM, Zhou Jifeng wrote:
> >> > Hello everyone, I learned through ChatGPT that the PNFS blocklayout =
of Linux
> >> > nfsd cannot be used for production environment deployment. However, =
I saw
> >> > a technical sharing conference video on YouTube titled "SNIA SDC 202=
4 - The
> >> > Linux NFS Server in 2024" where it was mentioned that the PNFS block=
layout
> >> > of nfsd has been fully maintained, which is contrary to the result g=
iven by
> >> > ChatGPT.
> >> >
> >> > My question is: Can the PNFS blocklayout of nfsd be used for
> >> > production environment deployment? If yes, from which kernel version=
 can it
> >> > be used in the production environment?
> >>
> >> Responding as the presenter of the SNIA SDC talk:
> >>
> >> There's a difference between "maintained" and "can be deployed in a
> >> production environment". "Maintained" means there are developers
> >> who are active and can help with bugs and new features. "Production
> >> ready" means you can trust it with significant workloads.
> >>
> >> The pNFS block layout type has several subtypes. Pure block, iSCSI,
> >> SCSI, and NVMe.
> >
> > What about the LAYOUT4_NFSV4_1_FILES layout type? Is that still support=
ed?
>
> Above, we're talking about the Linux NFS server... IIRC NFSD never
> supported the NFSv4.1 file layout type. It has a simple experimental
> implementation of the flexfile layout type (the MDS and DS are the
> same server).
Once upon a time Benny Halevy had a single server (in the Linux
kernel) that did file layout. (I remember because that is what I used
for testing the FreeBSD client side.) It even knew how to do striping.

However, it was a "single server" (MDS and DS in the same Linux kernel nfsd=
),
so it was only useful for testing purposes.

I have no idea if it is still around somewhere, but unless someone wants
to do a lot of work on it, it is definitely not useful for production sites=
.

rick

>
> The Linux NFS client fully implements the file, flexfile, and all
> the block layout types.
>
>
> --
> Chuck Lever
>

