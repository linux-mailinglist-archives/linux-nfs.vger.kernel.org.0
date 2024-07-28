Return-Path: <linux-nfs+bounces-5105-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A0ABF93E41A
	for <lists+linux-nfs@lfdr.de>; Sun, 28 Jul 2024 10:34:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9137DB20D6B
	for <lists+linux-nfs@lfdr.de>; Sun, 28 Jul 2024 08:33:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 551F82BAE5;
	Sun, 28 Jul 2024 08:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vastdata.com header.i=@vastdata.com header.b="Yc4S7Lwb"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 834632BAE3
	for <linux-nfs@vger.kernel.org>; Sun, 28 Jul 2024 08:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722155635; cv=none; b=ZSyTiHSF1qGXO2YIRDQYqA/v3Lm7rEVcI4ZswFGoo3txyWZgBz78DO8EeqnCl6DijFUcw6+4W+VdbBpe7s0+NnGcaLH0gJRNwMg1z8PW3HoloFb3lf7rVwRtPJBU9YF2sspD0AgjhFoRxlnmLhK2S+9hL2jnErm5Rdx/BnKjpMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722155635; c=relaxed/simple;
	bh=1J/AEM4tDF3p4U2mQ5zzZ1VfQXaq9hC6xhl7/TRkzrU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a4Bjxfiei1B3GNu62WQOJiWZ8y58QuE6avUeZ13hvVyf8pAGxpw0GaqmQDeUBfc5ByILoCDYIsQbMJIamCNHrMbwRhI7E0yGtpseUG5jju9R30KV+XWU9eJHhB89lbH6uF//CVZz+sGgkt6favG4cbzdApbu112XfucX1yYh9GI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vastdata.com; spf=pass smtp.mailfrom=vastdata.com; dkim=pass (2048-bit key) header.d=vastdata.com header.i=@vastdata.com header.b=Yc4S7Lwb; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vastdata.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vastdata.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-428141be2ddso7898895e9.2
        for <linux-nfs@vger.kernel.org>; Sun, 28 Jul 2024 01:33:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vastdata.com; s=google; t=1722155627; x=1722760427; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vYIkRGNr8+mMpOAq4cBUFg4tFNRm/w0P6T7fPHST9xg=;
        b=Yc4S7LwbjdPyfFW4VTKZraHL4lt08qD0vqGUR4I61Yx6oICUCThzp4sVmf+VH83YKr
         5qOp/6I4eKp+SWcYu7jy6A5emgESWUk3IXlUXW8mDZIRas19wkMjGc03Klo4K6Bxuvjj
         EpzSv+UcDs/wwPyzK55T4Mw+hL+tYFVTkWMyst1lwJCdhLrFkgeFCEpPbSL9longpRBG
         V9aSxgXY+bcRrJG5+5ucWMsJO97vHrmDKeG5Rcyi5dyThhex7wyKTteJ3B5qKTszuZUl
         pg3xGvWTgzcw2sUeiW3LHt0/ma54pbO6N07mAK/KEu/38+deHUZPs00uYMIcF4TicDYr
         55xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722155627; x=1722760427;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vYIkRGNr8+mMpOAq4cBUFg4tFNRm/w0P6T7fPHST9xg=;
        b=RUSb7WKzGj/zxriBX4ymc+kL/6DX/XXbKVVSb269gXrhnw3G7ntdD9SXUgpG84ugYG
         h9w7w6Zh4Ll3Wd2XaAEXmYaWL/TwKMGCZwKyiwE0Xm+36CvxQ+GMowwqgRtud0Ud3Zca
         yGoHymOJ4Jdv4KJkNPOoodKk8hTI3xWTDgieseHY9mxCHvPvjbQg+duRihbmJEA6skra
         Z/uTeo3jbVenQyOP2m6JZMJbWlLErlhxBhq49MY8l8YfJkUF7jqpT4NVdO1Smiw/uaTa
         65GiQDsqNsrSfTonWh5j55iBjLa3HVk7ZUarz0+cxwYXd64O+A0iM+mYAazVGY0ItpDY
         UPsg==
X-Forwarded-Encrypted: i=1; AJvYcCU7Mts7KXDNN1dzSm8RgDR7T8GdBzBMJh3BXLB3HlobvOH5fL3Y6mfobBvL/Ul1mu/ehoG6l4FZ9Mk6P6ZW/z1V0FWgJP8YUYHd
X-Gm-Message-State: AOJu0YwQk3SA06OhTmbCkY3GOQo7Ie0fOkMk5u+6KR+OxKO8/o83XODZ
	IAeDbUGl1pGbEU4SiFEOYX+aaXnQhy7i3uINQpLwnoGPh5h7B3URKotfv2DXLa4CZWh36dK/1Q2
	CJIE=
X-Google-Smtp-Source: AGHT+IFIYAmDSJfkz6jRYib+xG8+ppr/xScgIrX//pYIhdCpJEEYoz4JAgW3ltxpNYmonNyHZUlLyw==
X-Received: by 2002:a05:600c:1d1f:b0:424:ad14:6b79 with SMTP id 5b1f17b1804b1-42811d6dbfbmr28464125e9.8.1722155626648;
        Sun, 28 Jul 2024 01:33:46 -0700 (PDT)
Received: from gmail.com ([176.230.79.17])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36b36801828sm9271255f8f.65.2024.07.28.01.33.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jul 2024 01:33:46 -0700 (PDT)
Date: Sun, 28 Jul 2024 11:33:43 +0300
From: Dan Aloni <dan.aloni@vastdata.com>
To: Hristo Venev <hristo@venev.name>
Cc: Trond Myklebust <trondmy@hammerspace.com>, 
	David Howells <dhowells@redhat.com>, "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>, 
	"blokos@free.fr" <blokos@free.fr>
Subject: Re: kernel 6.10
Message-ID: <sl7cfmykqthhjss3qxeg2aweykff2gurcjqczfry62ne6edrfa@oocwcci6im3o>
References: <b78c88db-8b3a-4008-94cb-82ae08f0e37b@free.fr>
 <3feb741cb32edd8c48a458be53d6e3915e6c18ed.camel@hammerspace.com>
 <zyclq4jtvvtz6vamljvfiw6cgnr763yvycl3ibydybducivhqh@lj2hgweowpsa>
 <3bd0bfc1fced855902c8963d03e8041f4452b291.camel@hammerspace.com>
 <47219e1df5edbfaf7e8a64ebf543a908511ace85.camel@venev.name>
 <5412f22e497b11c1cd3fc8b8d8f30d372b68cd03.camel@venev.name>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5412f22e497b11c1cd3fc8b8d8f30d372b68cd03.camel@venev.name>

On 2024-07-28 02:57:42, Hristo Venev wrote:
> On Sun, 2024-07-28 at 02:34 +0200, Hristo Venev wrote:
> > On Sun, 2024-07-21 at 16:40 +0000, Trond Myklebust wrote:
> > > On Sun, 2024-07-21 at 14:03 +0300, Dan Aloni wrote:
> > > > On 2024-07-16 16:09:54, Trond Myklebust wrote:
> > > > > [..]
> > > > > 	gdb -batch -quiet -ex 'list
> > > > > *(nfs_folio_find_private_request+0x3c)' -ex quit nfs.ko
> > > > > 
> > > > > 
> > > > > I suspect this will show that the problem is occurring inside
> > > > > the
> > > > > function folio_get_private(), but I'd like to be sure that is
> > > > > the
> > > > > case.
> > > > 
> > > > I would suspect that `->private_data` gets corrupted somehow.
> > > > Maybe
> > > > the folio_test_private() call needs to be protected by either the
> > > > &mapping->i_private_lock, or folio lock?
> > > > 
> > > 
> > > If the problem is indeed happening in "folio_get_private()", then
> > > the
> > > dereferenced address value of 00000000000003a6 would seem to
> > > indicate
> > > that the pointer value of 'folio' itself is screwed up, doesn't it?
> > 
> > The NULL dereference appears to be at the `WARN_ON_ONCE(req->wb_head
> > !=
> > req);` check.
> > 
> > On my kernel the offset inside `nfs_folio_find_private_request` is
> > +0x3f, but the address is again 0x3a6, meaning that `req` is for some
> > reason set to 0x356 (the crash is on `cmp %rbp,0x50(%rbp)`).
> 
> ... and 0x356 happens to be NETFS_FOLIO_COPY_TO_CACHE. Maybe the
> NETFS_RREQ_USE_PGPRIV2 flag is lost somehow?

Seems NETFS_FOLIO_COPY_TO_CACHE relates to fscache use, you are
activating that, right?

Also in addition to my suggestion earlier, I think perhaps we need to
use `folio_attach_private` and `folio_detach_private` instead of
directly using `folio_set_private`, for which the NFS client seems to be
the only direct user.

-- 
Dan Aloni

