Return-Path: <linux-nfs+bounces-8182-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ABE09D4F7D
	for <lists+linux-nfs@lfdr.de>; Thu, 21 Nov 2024 16:11:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07D571F21B04
	for <lists+linux-nfs@lfdr.de>; Thu, 21 Nov 2024 15:11:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44EE71D9329;
	Thu, 21 Nov 2024 15:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VJCXSLWb"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 852F61ABEB4
	for <linux-nfs@vger.kernel.org>; Thu, 21 Nov 2024 15:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732201906; cv=none; b=u5LXP9a34weUwVAMU7R5F1WUz8tlXttv3O6ApbSa+6RIKmEfQiwDAhx5+fcdbSh0KvnPdkqTXb9QTcrjcYDdrqjIC4hzMvnEVFjfZTem2noG0J/Jk3DVmjI6FXQAontotmiJKSOKyuuLud4PgLL6cILqnD0Zx1X4ZwlOj4YRB2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732201906; c=relaxed/simple;
	bh=CdOIvr7HSZq5NjuQtJdpoEDTI6rFxBrvraKUALHoG8E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=REXzDBgQvG6jJamrGIvDmaqGLHRT6ixTJqRovd3+4sxojlf0axXJQMuW/6U7MMQQZmVdDBQ3GMwh7L2nUcY2p7F9AJOHtFk67IhoN74yhJGuBnWjFOqNjqbznynAJFcn2UQC86shlYkYYcq/37iFiqsapWu+8BlDnCfMvGLTyx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VJCXSLWb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732201903;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AAU5tspYcdCNEP7up2zgoXRaM3KJXFMONMxQMY8ZH2k=;
	b=VJCXSLWbYAyQBBQIc90W/XGLbZ/JCL1LW/hyMW2d+E1RJHFjKej/BOIuPrrE56qmNoLC/m
	+icuOPsf97hP8PTJuJyBZ2bgKge/FY0pENf9VQPCiTnUqPK7isk7RpqmUhW24T/BpU7F6W
	29wZ3RFzN0GH7Ba0TAE5fGfFwMo7eeM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-668-JYyy3iZsMlmkA76rTkVtaQ-1; Thu,
 21 Nov 2024 10:11:39 -0500
X-MC-Unique: JYyy3iZsMlmkA76rTkVtaQ-1
X-Mimecast-MFC-AGG-ID: JYyy3iZsMlmkA76rTkVtaQ
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6C8C819560AF;
	Thu, 21 Nov 2024 15:11:37 +0000 (UTC)
Received: from [192.168.37.1] (unknown [10.22.74.7])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D97711955E99;
	Thu, 21 Nov 2024 15:11:35 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>,
 linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 2/2] nfs/blocklayout: Limit repeat device registration on
 failure
Date: Thu, 21 Nov 2024 10:11:33 -0500
Message-ID: <B0CDB911-D9F2-4513-A4A0-403508BF4E0A@redhat.com>
In-Reply-To: <Zz3+rNnvxE2TRT0v@tissot.1015granger.net>
References: <cover.1732111502.git.bcodding@redhat.com>
 <d156fbaf743d5ec2de50a894170f3d9c7b7a146c.1732111502.git.bcodding@redhat.com>
 <Zz3+rNnvxE2TRT0v@tissot.1015granger.net>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On 20 Nov 2024, at 10:22, Chuck Lever wrote:

> On Wed, Nov 20, 2024 at 09:09:35AM -0500, Benjamin Coddington wrote:
>> If we're unable to register a SCSI device, ensure we mark the device as
>> unavailable so that it will timeout and be re-added via GETDEVINFO.  This
>> avoids repeated doomed attempts to register a device in the IO path.
>>
>> Add some clarifying comments as well.
>>
>> Fixes: d869da91cccb ("nfs/blocklayout: Fix premature PR key unregistration")
>> Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
>> Reviewed-by: Christoph Hellwig <hch@lst.de>
>> ---
>>  fs/nfs/blocklayout/blocklayout.c | 12 +++++++++++-
>>  1 file changed, 11 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/nfs/blocklayout/blocklayout.c b/fs/nfs/blocklayout/blocklayout.c
>> index 0becdec12970..b36bc2f4f7e2 100644
>> --- a/fs/nfs/blocklayout/blocklayout.c
>> +++ b/fs/nfs/blocklayout/blocklayout.c
>> @@ -571,19 +571,29 @@ bl_find_get_deviceid(struct nfs_server *server,
>>  	if (!node)
>>  		return ERR_PTR(-ENODEV);
>>
>> +	/*
>> +	 * Devices that are marked unavailable are left in the cache with a
>> +	 * timeout to avoid sending GETDEVINFO after every LAYOUTGET, or
>> +	 * constantly attempting to register the device.  Once marked as
>> +	 * unavailable they must be deleted and never reused.
>> +	 */
>>  	if (test_bit(NFS_DEVICEID_UNAVAILABLE, &node->flags)) {
>>  		unsigned long end = jiffies;
>>  		unsigned long start = end - PNFS_DEVICE_RETRY_TIMEOUT;
>>
>>  		if (!time_in_range(node->timestamp_unavailable, start, end)) {
>> +			/* Force a new GETDEVINFO for this LAYOUT */
>
> Or perhaps: "Uncork subsequent GETDEVINFO operations for this device"
> <shrug>

Sure, ok!

>>  			nfs4_delete_deviceid(node->ld, node->nfs_client, id);
>>  			goto retry;
>>  		}
>>  		goto out_put;
>>  	}
>>
>> -	if (!bl_register_dev(container_of(node, struct pnfs_block_dev, node)))
>> +	/* If we cannot register, treat this device as transient */
>
> How about "Make a negative cache entry for this device"

Hmm - that's closer to the dentry language rather than how we refer to
temporary error cases in device land.  For me the "transient" has some
hopeful meaning as in we expect this might work in the future - but I'm ok
changing this comment.  There will be some NFS clients that might try to do
pNFS SCSI but will never actually have the devices locally, and so that's
not a "transient" situation.  This can only fixed today with export policy.

>
>> +	if (!bl_register_dev(container_of(node, struct pnfs_block_dev, node))) {
>> +		nfs4_mark_deviceid_unavailable(node);
>>  		goto out_put;
>> +	}
>>
>>  	return node;
>>
>> -- 
>> 2.47.0
>>
>
> It took me a bit to understand what this patch does. It is like
> setting up a negative dentry so the local device cache absorbs
> bursts of checks for the device. OK.

Yes, its like the layout error handling, but for devices.

Its not obvious at this layer, but every IO wants to do LAYOUTGET, then
figure out which device GETDEVINFO, then here we need to prep the device
with a reservation.  Its a lot of slow work that makes a mess of IO
latencies if one of the later steps is going to fail for awhile.

> Just an observation: Negative caching has some consequences too.
> For instance, there will now be a period where, if the device
> happens to become available, the layout is still unusable. I wonder
> if that's going to have some undesirable operational effects.

It sure does, but I don't think there's a simple way to get notified that a
SCSI device has re-appeared or has started supporting persistent
reservations.

Ben


