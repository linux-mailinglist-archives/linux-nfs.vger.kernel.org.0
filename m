Return-Path: <linux-nfs+bounces-7572-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D067E9B6531
	for <lists+linux-nfs@lfdr.de>; Wed, 30 Oct 2024 15:05:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BA671F25804
	for <lists+linux-nfs@lfdr.de>; Wed, 30 Oct 2024 14:05:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFA991EE032;
	Wed, 30 Oct 2024 14:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FyTSGCzR"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61DE31EABDA
	for <linux-nfs@vger.kernel.org>; Wed, 30 Oct 2024 14:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730297118; cv=none; b=hUloaAiBhXJeKxqiezXlgSFRLCrosdPas7z/o2kdGFUpHYMHb2C6k3+aSJCZH1Qm82AIFf3JFick0PA0GdUMVy39Lev8FWCutsveIkVzmS6HxLgOqbKtJ1m3hJWORbKdy4MeCuSs2+Z83BXXrkZdTJT26A80h55ZCZK+4XrH4Ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730297118; c=relaxed/simple;
	bh=w0NT6Gk0ur0HD2UoBG3r5/KsmROJOBMgV8sb7u9f5Ts=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m0kEqYejRanXxf3lu3EAgGQA/Fac1K48I4GGxOxGRYKWWjmVwvmgSplKPUMUewo6eBGvT2kkh+wYXVgZVV+VGEXQCy0E6Jg6EQfooy8buEN0lDl4Y8Du09ry7zl4/hrHh9osS3ydVv+jdv0pJpFr70/mVjZqAeHqzo/YY+Y9BTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FyTSGCzR; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730297115;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zUCtEJ6E0lawO/E3+W9tg8ydSZ4TRJH53ZybSbExGkc=;
	b=FyTSGCzROxE5F9ANUPrMYs+vmWY1Cgd42SZpVEDtJRzSN17SE0ftoQG6ZdBk3Meu5XgwHp
	cft22abBZ9xVvW2SlvGGXJcMS1tFUuP2EQnXlC/oTuS+qld96zGJSCTOP5EY80fex5nDvf
	hircQGKBGw7Ry59TkT2cYKBl1hsAAAk=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-195-PztfLul5P8-LA1cmRN9zmQ-1; Wed,
 30 Oct 2024 10:05:11 -0400
X-MC-Unique: PztfLul5P8-LA1cmRN9zmQ-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DD32A1978C8F;
	Wed, 30 Oct 2024 14:05:07 +0000 (UTC)
Received: from [192.168.37.1] (unknown [10.22.58.17])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DADC11955F45;
	Wed, 30 Oct 2024 14:05:05 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>,
 Mikulas Patocka <mpatocka@redhat.com>, dm-devel@lists.linux.dev,
 linux-nfs@vger.kernel.org
Subject: Re: [PATCH] dm: add support for get_unique_id
Date: Wed, 30 Oct 2024 10:05:03 -0400
Message-ID: <ABD563AE-C7F3-43C2-A698-479C7D5924BF@redhat.com>
In-Reply-To: <20241030135214.GA28166@lst.de>
References: <f3657efae72f9abb93d3169308052e77bf0dbad6.1730292757.git.bcodding@redhat.com>
 <20241030135214.GA28166@lst.de>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On 30 Oct 2024, at 9:52, Christoph Hellwig wrote:

> On Wed, Oct 30, 2024 at 08:57:56AM -0400, Benjamin Coddington wrote:
>> This adds support to obtain a device's unique id through dm, similar to the
>> existing ioctl and persistent resevation handling.  We limit this to
>> single-target devices.
>>
>> This enables knfsd to export pNFS SCSI luns that have been exported from
>> multipath devices.
>
> Is there anything that ensures that the underlying IDs actually
> match?

Match each other in a multipath device you mean?  No, this will just return
the first one where get_unique_id returns non-zero.  Can they actually be
different, and if so should we return an error?

>
>> +	struct dm_unique_id *dmuuid = data;
>> +	const struct block_device_operations *fops = dev->bdev->bd_disk->fops;
>> +
>> +	if (fops->get_unique_id)
>> +		return fops->get_unique_id(dev->bdev->bd_disk, dmuuid->id, dmuuid->type);
>> +
>> +	return 0;
>
> Overly long line here.  Also maybe just personal, but I find code easier
> to read when the exit early condition is in the branch, e.g.
>
> 	strut gendisk *disk = dev->bdev->bd_disk
>
> 	if (!disk->fops->get_unique_id)
> 		return 0;
> 	return disk->fops->get_unique_id(disk, dmuuid->id, dmuuid->type);

That is nicer, will do.

Ben


