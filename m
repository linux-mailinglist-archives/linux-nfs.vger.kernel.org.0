Return-Path: <linux-nfs+bounces-3377-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BF71C8CE913
	for <lists+linux-nfs@lfdr.de>; Fri, 24 May 2024 19:12:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EEDAA1C20BBA
	for <lists+linux-nfs@lfdr.de>; Fri, 24 May 2024 17:12:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9505F86AD6;
	Fri, 24 May 2024 17:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jYlOgk7f"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB8B48626C
	for <linux-nfs@vger.kernel.org>; Fri, 24 May 2024 17:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716570727; cv=none; b=HYMTHbj6GqFjTXXOcpXP2HxveTEgKdWJqT9/+TY6vUna4kTR8dNgOiUon7MRPtSAyHdI6C+mcL4sEru/ITVz78Wd/KmDuQrF7o8ttHq2SsAjl2Uc9rq/iyExehv/SwmE5AOhWQcY75HooXKI5wKkB2CdQs+LI+UoRJiUJPK6DBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716570727; c=relaxed/simple;
	bh=aX3rOk2BOlaOHiSQYF1jw0ckNLPXTU9Tk67dUiCDf9Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=ObN3lYW83Mz4NFF96lRMJhVNUM7LUS+L/PO0JQd0+COpc5cBhcdk+2ykzazUqP7sboMsFDu9zTf/s4TXDJlwv5zwU95z8vgttMJn/SoSYHEawsjl9hZ2D20u67AbD5hx7+UjXsR+URvbyAZ2Bu8mUkfuA1r6WhJ4TmsxKFlMnig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jYlOgk7f; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2e52181c228so89411501fa.0
        for <linux-nfs@vger.kernel.org>; Fri, 24 May 2024 10:12:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716570724; x=1717175524; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GvQxssz37+jXzMZK3yAYQPVUE0vldhVR/LdYenwuovU=;
        b=jYlOgk7f5xRSM71cU18wtVIkw+CRgDs8JVRLm8IejJtGS1ayFLVetztAsoFE2hLAp2
         7oNadLN8VBWv8O5QSn7MpdEmUa3/KN9uXVGHZoAJGqO43spmBDHUU7Tk+8EornC7XoF4
         LZl6xjUybO9SoBDdwjQvDzR6yJUIxwLFVl6fK+/j2f9ncjqZjUwzkEpK3bIE5IR/4KHx
         nfu636yuagFz2Wu8yZIoBDIAd0+moS+sAmr9nIoG/u+3/hekzBBMUzOktGNccasnSufZ
         Uz4qgCJGgA0yFTPI9HXciFMpv3vwetzVMHP7+gLlkg1kn1L4dvttcVJX7z6NnXCy0sxl
         bHDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716570724; x=1717175524;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GvQxssz37+jXzMZK3yAYQPVUE0vldhVR/LdYenwuovU=;
        b=YUKey8tEeqAkNdIEPFCUOXLwwnLSRFnDyuXwg6u2IN2TNQJ0IUUn7sh0suBZjNdETf
         mfue3biIeU98UVCG4ABmTGj7CCCQTU5dYKUFWih8LvhI5PeH9cKVeydY80mcQUFQ/GPm
         kBp/sKO+je+fl0m8mUx2CJ7Ws5bF0Tv7PLux3y38P7lz2YrspXgEkdQyNyabltbuuUz0
         Ng9kT/ifyB5UKSZ2RxAT2PPPKJHo4okyCBKoviavDkkiiaXf24ZGYD6K9e8MBOUSNbzp
         LCcO/VnHbrhBazo32SxcsJH030Bv1ceZF5E3p+IZA4vD6P4sg8uCPg6+dHt3T8TuNK3k
         Vfug==
X-Gm-Message-State: AOJu0YxwrihXBy8XP2CD5wCT7CWS5EpgfBDPHpHxbiWFVnV3C5WdPjT+
	R8bysHRukAMs37vlIvqJEjIh4AxqUjXN5mPBLixDhX1N4hzqapRH5pcJawdXq3zq5DykLkZqzkZ
	mRHJE6mHo6jQWQNv9IjGWYNawM+ttuA==
X-Google-Smtp-Source: AGHT+IEc8cJF8ZCzm6zg6Yku6n1UlERkoR+XgbPi4FrCphfamzi+9Gz45Q47IS8bQjTGrhNH2vrKsi18vaIyehELQqc=
X-Received: by 2002:a2e:8807:0:b0:2e9:5ad4:e22f with SMTP id
 38308e7fff4ca-2e95b3089e4mr18269851fa.53.1716570723827; Fri, 24 May 2024
 10:12:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAAvCNcCTWbU-ejURuUC0_xhcoU3GF+2jX28rV4+2cKgfO5Lqxg@mail.gmail.com>
 <619bbf23-dbfe-4c26-adb9-1cc89f3f22a2@redhat.com>
In-Reply-To: <619bbf23-dbfe-4c26-adb9-1cc89f3f22a2@redhat.com>
From: Dan Shelton <dan.f.shelton@gmail.com>
Date: Fri, 24 May 2024 19:11:37 +0200
Message-ID: <CAAvCNcCGhZ917yerEOMcEEj7+_Yz5by8en2F4Yr5zLk0iQEGjg@mail.gmail.com>
Subject: Re: RFC2224 support in Linux /sbin/mount.nfs4?
To: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 15 May 2024 at 23:46, Steve Dickson <steved@redhat.com> wrote:
>
> Hey!
>
> On 5/14/24 5:57 PM, Dan Shelton wrote:
> > Hello!
> >
> > Solaris, Windows and libnfs NFSv4 clients support RFC2224 URLs, which
> > provide platform-independent paths where resources can be mounted
> > from, i.e. nfs://myhost//dir1/dir2
> >
> > Could Linux /sbin/mount.nfs4 support this too, please?
> Why? What does it bring to the table that the Linux client
> does already do via v4... with the except, of course, public
> filehandles, which is something I'm pretty sure the Linux
> client will not support.

This is NOT for Linux only. Every OS has its own system to describe
shares, and not all are compatible. URLs are portable.

>
> So again why? WebNFS died with Sun... Plus RFC2224 talks
> about v2 and v3... How does it fit in a V4 world.

This is NOT about WebNFS or SUN, this is to make the job of admins easier.

Dan
-- 
Dan Shelton - Cluster Specialist Win/Lin/Bsd

