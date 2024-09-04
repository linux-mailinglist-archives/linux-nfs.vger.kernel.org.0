Return-Path: <linux-nfs+bounces-6210-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5710196C83A
	for <lists+linux-nfs@lfdr.de>; Wed,  4 Sep 2024 22:17:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 908A01C22741
	for <lists+linux-nfs@lfdr.de>; Wed,  4 Sep 2024 20:17:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43FFA6BFA3;
	Wed,  4 Sep 2024 20:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="esnClwNT"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D657C84A35
	for <linux-nfs@vger.kernel.org>; Wed,  4 Sep 2024 20:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725481047; cv=none; b=pgeX8oNEUcWiqRtK05UiVMSwDyq4ceu2l8eFBmKKXR8B7FIHFCqmVZbMskYJ2qeejjPFOJZSH+8aRjH60OLAvbOjv34QuTLjWqnI/MwMrs70LHSaOAKSrChV/BtNfuwvQyGCszzpP5T8U/SRD7PgC2Lv1OZTnNzXMoThQ8z87Hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725481047; c=relaxed/simple;
	bh=kN77uES7krIHceZJXFUO3VsplbgbcwVzi4vHeN3M96s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YUOlK1cjVaFM2y9ZFNXSdzchmSt6xhlq/A+EpQ0MMTp6yC1/SFsN14a6/YwVw7cLb0Tkd5v8UxLMXW9stjIUCcm6tkf5Pf6WVUO+yGYQI62rzePE+dbLSZ9MavSsGcqpjVpYhC6fecULUqa3lVii+63b/cXHGAXFg3RFdyNEWtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=esnClwNT; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2054e22ce3fso325935ad.2
        for <linux-nfs@vger.kernel.org>; Wed, 04 Sep 2024 13:17:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725481045; x=1726085845; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HR+FFiZQgpD/Sziha5QpXEtjEu4jMsVet8t1zQDRXJw=;
        b=esnClwNT1C+iBvtv6wwyIuxo0Jn5BGDaFo0Ydac1tCjPCaVjelzP9IId5CIZu4ARKz
         2XIGvDqyqmS4NGG2nbAsdJFARnSW9qGYZlH7A3R2UEBul1wiii8oOOrJX/MqGO+Gh5HM
         seyrN/1InsDGi9sLjlsxLqxLUYjQ9S/WXMkbLb42m6Jkr2hqHwlRQIP+iDzUrpTAZnB6
         +IyErTCiQo3Q0uBf4MG7vur/+LFekQsuuPO5c/4pundtw4NRnDpa8UQEgBAtPt7oDvfa
         yvtWHbxOv/8WoPl8CXEblblymo1IK6KwYpmANSlrVP99ZoR+xdcwcNbWFkVat08E5ZSq
         5anQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725481045; x=1726085845;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HR+FFiZQgpD/Sziha5QpXEtjEu4jMsVet8t1zQDRXJw=;
        b=hJcICk2nFjBiRMs6gaAYP/1vQM4q4y3/Dg/zO/5SYVYQdc2vXhDlFx4XBuZb+1nvIq
         szMZDKPKr2FqWEjqaE2shuiInu9Z+jutVmO6x0TPWoYmY71+BLYTFl+FHip/1FKqkBNv
         HIFtH4bEc8cG81ZlbLeRpsgCNrz4AbXK49YwQqNih7yVK2yCGRhdp0mRk7Ww3i6VTvvS
         XNF6F1hOVuGGbkj5ZEWL8fogahlyyarUyTVjadNhCcGI+9wtr65jg6TR7GyviZ8DLELY
         2lvfjDRhksWuxWcWmEs/SDuV/Vyy3TWvqgjB8Qja1ZsY41WH0ycr5gTgVYVAMZ4jffSb
         MQRQ==
X-Gm-Message-State: AOJu0Ywb3wsZSCccKEr+9/Qj4pwU4nlHISlDrMbIRcqE9/1Bqf5kSoCx
	mzTADjG1bB6SX1hF+aDEvovYn6Hw5Esx4jCTiHCmjgVz5RzSweVG9XvVcaazIdpCGvlEEQ5Ugyh
	m+5+dwiRHizMa5k5A10h5Q8zXkA==
X-Google-Smtp-Source: AGHT+IEV49E4jSwUTFkkQSZnfFInWx3nggePWe2f31WFJGYhUjBMVSsnDGMNAQKdBfqNH6R5TO9Tj5eo90RWiAKfzCc=
X-Received: by 2002:a17:902:d4cf:b0:206:8d6e:cff9 with SMTP id
 d9443c01a7336-20699acb75amr65550145ad.4.1725481044865; Wed, 04 Sep 2024
 13:17:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAM5tNy7SQuiAb7ieDsJ2vNGb5mw=zvMYaeu+Q14cJf-YZgrD_g@mail.gmail.com>
 <bd4dfaa2b92ee75818405db70f34fd99aa617f7b.camel@kernel.org>
In-Reply-To: <bd4dfaa2b92ee75818405db70f34fd99aa617f7b.camel@kernel.org>
From: Rick Macklem <rick.macklem@gmail.com>
Date: Wed, 4 Sep 2024 13:17:14 -0700
Message-ID: <CAM5tNy7Aq87on6QbpFrGsK7e-sap1jP97ekC==etRYdfAH7_6g@mail.gmail.com>
Subject: Re: How big can an array be on a kernel stack?
To: Jeff Layton <jlayton@kernel.org>
Cc: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 4, 2024 at 3:26=E2=80=AFAM Jeff Layton <jlayton@kernel.org> wro=
te:
>
> On Tue, 2024-09-03 at 13:32 -0700, Rick Macklem wrote:
> > Hi,
> >
> > Subject line says it all. As a newbie to the Linux
> > kernel, I am wondering if an array of 70 pointers
> > is too big for the kernel stack?
> > (I assumed it is and kmalloc_array()d it, but thought
> > I'd check.)
> >
> > Thanks for any comments, rick
> >
>
> In the old days, we had 4k stacks and it was quite easy to blow it out
> putting big stuff there. These days, stacks are 16k (on most arches) so
> you're probably fine with a 560 byte array there in most cases.
>
> Still, with something that large, I usually do a kmalloc, just to be
> sure.
Yea, I was thinking the same thing. And then I came across this comment
in the NFSv3 acl code...
/* Avoid the use of posix_acl_alloc().  nfsacl_encode() is
* invoked in contexts where a memory allocation failure is
* fatal.  Fortunately this fake ACL is small enough to
* construct on the stack. */

So, now I have the array on the stack and it seems to work.
(Mind you, I am testing on 32bit, so I'm not sure what will happen for
others. Yea, believe it or not, my only Linux box is i686.;-(

Thanks for the help, rick

> --
> Jeff Layton <jlayton@kernel.org>

