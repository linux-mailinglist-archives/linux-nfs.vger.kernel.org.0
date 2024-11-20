Return-Path: <linux-nfs+bounces-8167-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AEF3A9D444D
	for <lists+linux-nfs@lfdr.de>; Thu, 21 Nov 2024 00:05:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B6281F2101E
	for <lists+linux-nfs@lfdr.de>; Wed, 20 Nov 2024 23:05:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AA9842048;
	Wed, 20 Nov 2024 23:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ef1lGVYn"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3D0818A944
	for <linux-nfs@vger.kernel.org>; Wed, 20 Nov 2024 23:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732143931; cv=none; b=ttJqEA3jlgMaxVgLjujX/ySQOmNwTZHr6qozYZwxnoxahtdGTA0wL06X+JoSuk7TiDMzPjS6p7Vqmf0ULtgXoVORzfQarUOneFW2mdGgLV11AO61Zxa6U2HFgg4LK0BBJRxBup7I4/2+gGRfe3uHuHMNEgctYfJ/nUBBjlkYt2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732143931; c=relaxed/simple;
	bh=mmNRVudXsDDtGfU0zM/4DhYsYG09vMLKh8/T4iWzRDc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=Yd5oEFrHA7WeYyr1EIirWjBrWpALj+yeRcdhVgEkJ/6D2SheuMoFD3SHjP26Ujyia8xXeAjOcfZO77CmYMhuD8wlFREsXtn9lAnj48s58k5xcR+SBz4waLkOWrlwhjwmHOyJU1+qx/3C1pyIup5yt/t7lTJmZcrA4qeDgYBR++Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ef1lGVYn; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3e5ffbc6acbso256064b6e.3
        for <linux-nfs@vger.kernel.org>; Wed, 20 Nov 2024 15:05:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732143928; x=1732748728; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BUhJhxYvPmKTydNIy6IhCrujrfQVDMYtFSsE5pxa99k=;
        b=Ef1lGVYndYPACR8PLBRMVLgIe07f9igRRlv5cgea0q0J3TU4J2PX41XzWwVVk52Ge5
         +Lulqu4yCQrt1QbvktiwzJWAyPV0zaCW6PFZXigr6jZDFE5PMrvytAs+QPwx7tz0yVAQ
         l/Axy2JJA+hTTziWYydHi/zsXUIauXmfJQDku+qjirWgnqKqXtrpxA8IQ6xjxmpHU6Cx
         nSTK6q8lGlsRK49aUpx8l2WqZQMHE4xPXJnl1awDc0J0NZJf2M8PrHibVIevnoT4Nyhr
         GC6VNzjXTPjZ4XfRDZJk+m1/mywUw3Io7Ej3vThfjeyjY9pIOnmadEGWa39I0/wBxCQa
         DhKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732143928; x=1732748728;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BUhJhxYvPmKTydNIy6IhCrujrfQVDMYtFSsE5pxa99k=;
        b=AYIlsyH1PwsA8bwrcQ0WpBMArYUnd/5YnhkFzvanOMYoJIYPUeJiDnKCksr0z9Lo8i
         rb+aSiCiXHWwmQXb1zsUtON6EW9r7a9s8p358dbGUPYVL+0qcGNQAy1V4tYYgiB4dxgs
         FccFtgLQKxc6M07HPhoNT6GdPONztXeQvnHIlcWXUSnzGKKrFilgSwObneDHu3BCHIM+
         N4r04vkpVoRjSIgQLVWYr1Pp+fSB6gHdTcLv6mXTxBuK8ARmz6BDtNZJSoSzvL8/FI8L
         PeroeV/PNvBq5b0KCkGsuJ+K6DCmmAwJ547TYeOAIwM2c67WOBDIZPEvc1i8y9kCP2S1
         3cbA==
X-Gm-Message-State: AOJu0Yz2umNYm0GfBzp0may1p4Xl9z/wG0F9hey6iQPDeSImjPD9jPF/
	XePM5kqWJbnKWRKMtrsydgApO3PI5nYKHlpDXT6HKwT96kGZtIgkFyV/v4vBVoVIAfuzpkrRoYE
	5vhy0Ad3EcnwAWF43R2tmZ+BvLdbnYg==
X-Google-Smtp-Source: AGHT+IGI+ooV2AjAzGlGwIv/LPh+HxFHULIFQUuDhmKeDBqhbAj/uMwHMpCCXusZ8tgu7P2X0L3e7AsGgG0E43RvRmw=
X-Received: by 2002:a05:6808:238c:b0:3e3:cd42:58b0 with SMTP id
 5614622812f47-3e7eb7f11f3mr3634351b6e.43.1732143928546; Wed, 20 Nov 2024
 15:05:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241119165942.213409-1-steved@redhat.com> <59ca2dd7-583f-4141-aef9-4acff857c957@redhat.com>
In-Reply-To: <59ca2dd7-583f-4141-aef9-4acff857c957@redhat.com>
From: Dan Shelton <dan.f.shelton@gmail.com>
Date: Thu, 21 Nov 2024 00:04:51 +0100
Message-ID: <CAAvCNcByu8MAmBRMw6U2a0pHiYQKrp361R9NpCnFp8A3om5hUQ@mail.gmail.com>
Subject: Re: [PATCH V2] nfs(5): Update rsize/wsize options
To: Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 20 Nov 2024 at 21:56, Steve Dickson <steved@redhat.com> wrote:
>
>
>
> On 11/19/24 11:59 AM, Steve Dickson wrote:
> > From: Seiichi Ikarashi <s.ikarashi@fujitsu.com>
> >
> > The rsize/wsize values are not multiples of 1024 but multiples of the
> > system's page size or powers of 2 if < system's page size as defined
> > in fs/nfs/internal.h:nfs_io_size().
> >
> > Signed-off-by: Steve Dickson <steved@redhat.com>
> Committed... (tag: nfs-utils-2-8-2-rc2)
>
> I know we are still discussing this but I think
> this version is better than what we have.

Nope. The code is IMO wrong, and the docs are buggy too.

>
> So update patches are welcome!

Solaris, HPUX, FreeBSD and Windows NFSv3/v4 implementations all count in bytes.

Why does Linux again have to be the oddball of the family and count in
pages? Not-invented-here-syndrome,
need-reason-why-companies-have-to-pay-for-Linux-admin-training?
My recommendation would be to fix the code to count in bytes, rounded
to the page size, and being a minimum of one page size. Will bite of
course if someone chooses 2M pages as default on x86-64.

Dan
-- 
Dan Shelton - Cluster Specialist Win/Lin/Bsd

