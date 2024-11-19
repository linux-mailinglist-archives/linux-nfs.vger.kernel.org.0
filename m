Return-Path: <linux-nfs+bounces-8113-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A1B69D273B
	for <lists+linux-nfs@lfdr.de>; Tue, 19 Nov 2024 14:47:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 501E3284959
	for <lists+linux-nfs@lfdr.de>; Tue, 19 Nov 2024 13:47:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88D5F7F460;
	Tue, 19 Nov 2024 13:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fGMYDQDO"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF6161F602
	for <linux-nfs@vger.kernel.org>; Tue, 19 Nov 2024 13:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732024028; cv=none; b=SfVYOT7c3bsZr1z/7SviMci/g2v1P7IVNXULmydbEjHA+97U5VnDDpwrOmuXcLIfmczyE0PWn0kmTvlCmGi7p+dJfE7LmAmVTaOOlF175bl1TbmehH5EyNomvYY1AnkftGKp0cts8+0AxLYxHeL65lhONlk1eyc2id5FNakGMiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732024028; c=relaxed/simple;
	bh=vYLXBhq+RwUXf2MBThxTY34Js+qKl5mXiqkXSYCQYy8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U+LpMQJsAbMjBMDYW7ATFvAu68KgKVlwRZr6lN3q7p3FuYtDMeoKGod0q8JoNt3r9ZDbL1TozAUcsdoa//eWc7Dy+8AbfsaNJuN7vJl0u1qUII2kdFZaNMIcJmO885UX9anfDRAxiDisuCMPib0JXwzvJhdcNiJgI3QeDDFc/BM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fGMYDQDO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732024025;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=W7hUDV8BiUp8vLc5D60REkj6ahc41y654Y2duC4Zur8=;
	b=fGMYDQDOMZEIWa8g6O9BvSN1ByQaBq/BMhbfiXCGTazad7SZmwkJZfXDxZsXOMFliLDoPm
	sVxaV4khDS+o/oIcKvU1do4MPpBYEhi6M5grLhC3FIy+ZLQ5QyvNoGVWmiNFQCRub6KaTK
	pUuhzLTE8DmrFPbX1W7ApG6nzV4tlrQ=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-665-VAx_xVPdNjOxdADTzdsxZA-1; Tue,
 19 Nov 2024 08:47:04 -0500
X-MC-Unique: VAx_xVPdNjOxdADTzdsxZA-1
X-Mimecast-MFC-AGG-ID: VAx_xVPdNjOxdADTzdsxZA
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D3E1A1954B23;
	Tue, 19 Nov 2024 13:47:02 +0000 (UTC)
Received: from [192.168.37.1] (unknown [10.22.74.7])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 83A79195E480;
	Tue, 19 Nov 2024 13:47:01 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>,
 Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] nfs/blocklayout: Don't attempt unregister for invalid
 block device
Date: Tue, 19 Nov 2024 08:46:58 -0500
Message-ID: <93DD6022-E5FC-44CB-9DAF-67DEFF58CB1C@redhat.com>
In-Reply-To: <ZzyHqEDt8UXoAUyh@infradead.org>
References: <cover.1731969260.git.bcodding@redhat.com>
 <eeb62d9260f2e9b61ff5e186eec0048e51bc8758.1731969260.git.bcodding@redhat.com>
 <ZzyHqEDt8UXoAUyh@infradead.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On 19 Nov 2024, at 7:42, Christoph Hellwig wrote:

> On Mon, Nov 18, 2024 at 05:40:40PM -0500, Benjamin Coddington wrote:
>> Since commit d869da91cccb, an unmount of a pNFS SCSI layout-enabled NFS
>
> Please also spell out the commit subject in the commit log body, similar
> to to the Fixes tag.

Will do.

>> index 6252f4447945..7ae79814f4ff 100644
>> --- a/fs/nfs/blocklayout/dev.c
>> +++ b/fs/nfs/blocklayout/dev.c
>> @@ -16,13 +16,16 @@
>>
>>  static void bl_unregister_scsi(struct pnfs_block_dev *dev)
>>  {
>> -	struct block_device *bdev = file_bdev(dev->bdev_file);
>> -	const struct pr_ops *ops = bdev->bd_disk->fops->pr_ops;
>> +	struct block_device *bdev;
>> +	const struct pr_ops *ops;
>>  	int status;
>>
>>  	if (!test_and_clear_bit(PNFS_BDEV_REGISTERED, &dev->flags))
>>  		return;
>>
>> +	bdev = file_bdev(dev->bdev_file);
>> +	ops = bdev->bd_disk->fops->pr_ops;
>> +
>
> Hmm.  Just moving the test_and_clear_bit to the caller would
> feel cleaner than this to me.

We can do this too - I'll send another version.  I didn't go this way
because I felt the bit test and clear was an important part of the function
that could be lost if we ever had another caller.

> But either way the change looks good:
>
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Thanks for the review.

Ben


