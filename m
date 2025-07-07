Return-Path: <linux-nfs+bounces-12920-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BA6FEAFBC53
	for <lists+linux-nfs@lfdr.de>; Mon,  7 Jul 2025 22:13:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 589D717ECA7
	for <lists+linux-nfs@lfdr.de>; Mon,  7 Jul 2025 20:13:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34C6121ABB7;
	Mon,  7 Jul 2025 20:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SbcGn/SN"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 365F62153D3
	for <linux-nfs@vger.kernel.org>; Mon,  7 Jul 2025 20:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751919194; cv=none; b=iAJ1/eCHVvNdErjFXo5F2zNLD9I4Ts78DYvNAuvP3ZmrzHbnMJlkuHMTd4hk1oaSK9TVfXUbZwza0XodNwL5HlHZoe6k4+fwNosu0vX+8Pb8VcLPjvycd8cdCwiQi8I5VeXKALvPp1h34vSlEHNExFqS87P94cWs4f8I3//NVCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751919194; c=relaxed/simple;
	bh=q3K5zYLbdA5plN32sHr9UfVIGAwMhRwtmU4fY3iHsmY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KSRMyb3CtNzJXPo3SDiV7uunylZH/v6UAFYrDHaUKM1eZUh9Hp45I4/lS1CrE4UfGMn6N9jlaIlSvkRzRyotic23WFKrox1XryF7VEAvO2Sa75jHxgt8hFYZN8yeGZOpujHvzTnzwzVx0IIciYJoePEGTZ3LCW0HJHC3ufMVcGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SbcGn/SN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751919191;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bEr/uej+QZpmr1IiUP4AUT4Ey988/b6ZD3IjxFTPv7A=;
	b=SbcGn/SNzZnOSfyWXfBEVeiBqYGtxuzXah1q+E+x2rYhxnv9Kp6y47F0mXpryojn1N58FC
	VyVqttJk58Zv2uwo7v4fBpS55QCUwtDjg0DtB23dZvUNWVtIwy1JNNbVgwiOxeyu6OxMOe
	rONIKu0ojW/ExQfM7nPPtKv99FIPSdQ=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-381-bz2rGaBgOT2lXJG0JiDwLg-1; Mon,
 07 Jul 2025 16:13:05 -0400
X-MC-Unique: bz2rGaBgOT2lXJG0JiDwLg-1
X-Mimecast-MFC-AGG-ID: bz2rGaBgOT2lXJG0JiDwLg_1751919184
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B89BE180028A;
	Mon,  7 Jul 2025 20:13:04 +0000 (UTC)
Received: from [192.168.37.1] (unknown [10.22.74.5])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 160D718003FC;
	Mon,  7 Jul 2025 20:13:01 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: Trond Myklebust <trondmy@kernel.org>
Cc: Anna Schumaker <anna@kernel.org>, Tejun Heo <tj@kernel.org>,
 Lai Jiangshan <jiangshanlai@gmail.com>, linux-nfs@vger.kernel.org,
 linux-kernel@vger.kernel.org, djeffery@redhat.com, loberman@redhat.com
Subject: Re: [PATCH 2/2] NFS: Improve nfsiod workqueue detection for
 allocation flags
Date: Mon, 07 Jul 2025 16:12:59 -0400
Message-ID: <B3C40644-332F-415A-98A0-875C230A709D@redhat.com>
In-Reply-To: <a7621e726227260396291e82363d2b82e5f2ad73.camel@kernel.org>
References: <cover.1751913604.git.bcodding@redhat.com>
 <a4548815532fb7ad71a4e7c45b3783651c86c51f.1751913604.git.bcodding@redhat.com>
 <a7621e726227260396291e82363d2b82e5f2ad73.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On 7 Jul 2025, at 15:25, Trond Myklebust wrote:

> On Mon, 2025-07-07 at 14:46 -0400, Benjamin Coddington wrote:
>> The NFS client writeback paths change which flags are passed to their
>> memory allocation calls based on whether the current task is running
>> from
>> within a workqueue or not.  More specifically, it appears that during
>> writeback allocations with PF_WQ_WORKER set on current->flags will
>> add
>> __GFP_NORETRY | __GFP_NOWARN.  Presumably this is because nfsiod can
>> simply fail quickly and later retry to write back that specific page
>> should
>> the allocation fail.
>>
>> However, the check for PF_WQ_WORKER is too general because tasks can
>> enter NFS
>> writeback paths from other workqueues.  Specifically, the loopback
>> driver
>> tends to perform writeback into backing files on NFS with
>> PF_WQ_WORKER set,
>> and additionally sets PF_MEMALLOC_NOIO.  The combination of
>> PF_MEMALLOC_NOIO with __GFP_NORETRY can easily result in allocation
>> failures and the loopback driver has no retry functionality.  As a
>> result,
>> after commit 0bae835b63c5 ("NFS: Avoid writeback threads getting
>> stuck in
>> mempool_alloc()") users are seeing corrupted loop-mounted filesystems
>> backed
>> by image files on NFS.
>>
>> In a preceding patch, we introduced a function to allow NFS to detect
>> if
>> the task is executing within a specific workqueue.  Here we use that
>> helper
>> to set __GFP_NORETRY | __GFP_NOWARN only if the workqueue is nfsiod.
>>
>> Fixes: 0bae835b63c5 ("NFS: Avoid writeback threads getting stuck in
>> mempool_alloc()")
>> Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
>> ---
>>  fs/nfs/internal.h | 12 +++++++++++-
>>  1 file changed, 11 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
>> index 69c2c10ee658..173172afa3f5 100644
>> --- a/fs/nfs/internal.h
>> +++ b/fs/nfs/internal.h
>> @@ -12,6 +12,7 @@
>>  #include <linux/nfs_page.h>
>>  #include <linux/nfslocalio.h>
>>  #include <linux/wait_bit.h>
>> +#include <linux/workqueue.h>
>>  
>>  #define NFS_SB_MASK (SB_NOSUID|SB_NODEV|SB_NOEXEC|SB_SYNCHRONOUS)
>>  
>> @@ -669,9 +670,18 @@ nfs_write_match_verf(const struct nfs_writeverf
>> *verf,
>>  		!nfs_write_verifier_cmp(&req->wb_verf, &verf-
>>> verifier);
>>  }
>>  
>> +static inline bool is_nfsiod(void)
>> +{
>> +	struct workqueue_struct *current_wq = current_workqueue();
>> +
>> +	if (current_wq)
>> +		return current_wq == nfsiod_workqueue;
>> +	return false;
>> +}
>> +
>>  static inline gfp_t nfs_io_gfp_mask(void)
>>  {
>> -	if (current->flags & PF_WQ_WORKER)
>> +	if (is_nfsiod())
>>  		return GFP_KERNEL | __GFP_NORETRY | __GFP_NOWARN;
>>  	return GFP_KERNEL;
>>  }
>
>
> Instead of trying to identify the nfsiod_workqueue, why not apply
> current_gfp_context() in order to weed out callers that set
> PF_MEMALLOC_NOIO and PF_MEMALLOC_NOFS?
>
> i.e.
>
>
> static inline gfp_t nfs_io_gfp_mask(void)
> {
> 	gfp_t ret = current_gfp_context(GFP_KERNEL);
>
> 	if ((current->flags & PF_WQ_WORKER) && ret == GFP_KERNEL)
> 		ret |= __GFP_NORETRY | __GFP_NOWARN;
> 	return ret;
> }

This would fix the problem we see, but we'll also end up carrying the flags
from the layer above NFS into the client's current allocation strategy.
That seems fragile to part of the original intent - we have static known
flags for NFS' allocation in either context.

On the other hand, perhaps we want to honor those flags if the upper layer
is setting them, because it should have a good reason -- to avoid deadlocks.

We originally considered your suggested flag-checking approach, but went the
"is_nfsiod" way because that seems like the actual intent of checking for
PF_WQ_WORKER.  The code then clarifies what's actually wanted, and we don't
end up with future problems (what if nfsiod changes its PF_ flags in the
future but the author doesn't know to update this function?)

Do you prefer this approach?  I can send it with your Suggested-by or
authorship.

The other way to fix this might be to create a mempool for nfs_page - which
is the one place that uses nfs_io_gfp_mask() that doesn't fall back to a
mempool.  We haven't tested that.

Thanks for the look.

Ben


