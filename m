Return-Path: <linux-nfs+bounces-6960-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E14B995835
	for <lists+linux-nfs@lfdr.de>; Tue,  8 Oct 2024 22:12:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFE4A28AB6E
	for <lists+linux-nfs@lfdr.de>; Tue,  8 Oct 2024 20:12:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85FB42141DA;
	Tue,  8 Oct 2024 20:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EJLaElJy"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF10B212644
	for <linux-nfs@vger.kernel.org>; Tue,  8 Oct 2024 20:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728418370; cv=none; b=Db6KW4uZH4jtjHjzJTVxk2tawffsgDx3r8xbNW3+n0uQdyDGNl1EN3u+tA5LtYGopyuoogfPPbyaHXpuCRYF85muJbXOA8B0rGLsoQj0u17QSFs3fliOSxAmYQJeyQRWTqokERIa79jEDyDxstWqiHm5cl8rujSVY9piRgkogX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728418370; c=relaxed/simple;
	bh=Mmm1nsgSwusmWQIhbN6dtt9xmktOtOPWg/wMOr5raJc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PtAqdLZ+WF69sZ/OtXLlXqs2wf3ojXnGNg3Uazjke52Kmez8DOYQdAQcqO73fuhtADITY57PfKYUYWh2KpFBZnoq8EG4vd/6A5w0w4f45GtkbmK+6J5M8JgcYrZg3vQoRvJZ5xPpdVLJuQzjPM33lukAspPzwYoJK2KTphgaeLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EJLaElJy; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728418368;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=a1XdYdPRRThJf04ZH2f39aR/lmOxVlk4KOGPuZXe+cg=;
	b=EJLaElJyLNZ6CVrr6VieO1W7bj3T7MeWC/NbmmTJ8Kx6NHGNXu82yKlodLchmwONJUjUpi
	vV25JCtbaC6Y3PdVWAuO2rSPwbDN0/xqF570GpCahR4GanrfuCWyHhZScs7cfEB+cdiFak
	SbUr4WVqBGgLQGYBPuFLoiPXf9v/dPU=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-306-l7TOBY8FMUyI7HXYjLT3lA-1; Tue,
 08 Oct 2024 16:12:44 -0400
X-MC-Unique: l7TOBY8FMUyI7HXYjLT3lA-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5694719560B4;
	Tue,  8 Oct 2024 20:12:43 +0000 (UTC)
Received: from [192.168.37.1] (unknown [10.22.48.10])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0ACAE19560A3;
	Tue,  8 Oct 2024 20:12:40 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: Alexander Aring <aahringo@redhat.com>
Cc: trondmy@kernel.org, anna@kernel.org, gregkh@linuxfoundation.org,
 rafael@kernel.org, akpm@linux-foundation.org, linux-nfs@vger.kernel.org,
 gfs2@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] nfs: kobject: use generic helpers and ownership
Date: Tue, 08 Oct 2024 16:12:38 -0400
Message-ID: <A81234BC-0E6D-42AE-BA2B-AF6004DE3C79@redhat.com>
In-Reply-To: <20241003151435.3753959-1-aahringo@redhat.com>
References: <20241003151435.3753959-1-aahringo@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On 3 Oct 2024, at 11:14, Alexander Aring wrote:

> Hi,
>
> I currently have pending patches for fs/dlm (Distributed Lock Manager)
> subsystem to introduce some helpers to udev. However, it seems it takes
> more time that I can bring those changes upstream. I put those out now
> and already figured out that nfs can also take advantage of those changes.
>
> With this patch-series I try to try to reduce my patch-series for DLM
> and already bring part of it upstream and nfs will be a user of it.
>
> The ownership callback, I think it should be set as the
> kset_create_and_add() sets this callback as default. I never had any
> issues with it, but there might be container corner cases that requires
> those changes?
>
> - Alex
>
> Alexander Aring (4):
>   kobject: add kset_type_create_and_add() helper
>   kobject: export generic helper ops
>   nfs: sysfs: use kset_type_create_and_add()
>   nfs: sysfs: use default get_ownership() callback
>
>  fs/nfs/sysfs.c          | 30 +++----------------
>  include/linux/kobject.h | 10 +++++--
>  lib/kobject.c           | 65 ++++++++++++++++++++++++++++++-----------
>  3 files changed, 60 insertions(+), 45 deletions(-)
>
> -- 
> 2.43.0

These look good to me, though patch 4/4 seems superfluous, I responded there.

For the series:
Reviewed-by: Benjamin Coddington <bcodding@redhat.com>

Ben


