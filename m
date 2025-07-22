Return-Path: <linux-nfs+bounces-13185-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AB6F5B0E01B
	for <lists+linux-nfs@lfdr.de>; Tue, 22 Jul 2025 17:13:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C3BA17A4F22
	for <lists+linux-nfs@lfdr.de>; Tue, 22 Jul 2025 15:11:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DC5E1C84DE;
	Tue, 22 Jul 2025 15:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d8Dc+MrA"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83F1128A1EA
	for <linux-nfs@vger.kernel.org>; Tue, 22 Jul 2025 15:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753197186; cv=none; b=ESGh1JK15CQGuMJNu2tIQMmjiNL7FK8ZQysxA008uD1jdV9qct0OmIgPjkZRVaIjY0CmHTqdW5MD8D8GaCZ6nC/F4ZRc643RuQjAZQYXl7vfTb6KHvqzGg0sb73DI+FjNDKtADEKc//eigyMiXGm9iDTUpR4FfH0WUb0/9x61LM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753197186; c=relaxed/simple;
	bh=jWRuxfsCH5trOeU3YbGYfVITvNEnt57i+X2yCHxLeqE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dHOWhuz4GYvcqFfHJjHw6lKZZYAQU+nDW9VLF+EMGyuFg8n0UQsFXm8b0WHKa3JIgpvpJcTIOSHwqtzJRv1aO2cFNA6c2jkFnlAeBGpBu8WZr4EytH/2bbPhIdLnETGt9quc6x1ZI9/iP3QbUSyr7jDi3aShW7GWCAZgwO9tPEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=d8Dc+MrA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753197183;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zsT9YUfB4TQbSuR6h8dYsaFfEiXDrUH9Zy2B0wO6l0k=;
	b=d8Dc+MrAF5lLifeqt1FVShQgrILUg7Xiu2Uc7GwNCKGuARehGdP0GEmJ2oFJhFX1yAffVN
	ABik7sbYsfcxVyg5QVXmSPil3pSktwtw971+TR22JMnV12NGnZDnaMOezEmyTkf3bGZlp0
	OKmTzErez5x8wJ76cptudWPbXfSYGHc=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-278-E16bIlZ0NUGhZBPTRnytqA-1; Tue,
 22 Jul 2025 11:13:00 -0400
X-MC-Unique: E16bIlZ0NUGhZBPTRnytqA-1
X-Mimecast-MFC-AGG-ID: E16bIlZ0NUGhZBPTRnytqA_1753197179
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 515A319541A7;
	Tue, 22 Jul 2025 15:12:58 +0000 (UTC)
Received: from [192.168.37.1] (unknown [10.22.76.8])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B0BE618016F9;
	Tue, 22 Jul 2025 15:12:50 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 Laurence Oberman <loberman@redhat.com>, Jeff Layton <jlayton@kernel.org>,
 Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v3] NFS: Fixup allocation flags for nfsiod's __GFP_NORETRY
Date: Tue, 22 Jul 2025 11:12:48 -0400
Message-ID: <315CF087-770E-464A-A4D5-70FA658357BA@redhat.com>
In-Reply-To: <f83ac1155a4bc670f2663959a7a068571e06afd9.1752111622.git.bcodding@redhat.com>
References: <f83ac1155a4bc670f2663959a7a068571e06afd9.1752111622.git.bcodding@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Gentle ping on this one - let me know if anyone has further review or
critique.

Ben

On 9 Jul 2025, at 21:47, Benjamin Coddington wrote:

> If the NFS client is doing writeback from a workqueue context, avoid using
> __GFP_NORETRY for allocations if the task has set PF_MEMALLOC_NOIO or
> PF_MEMALLOC_NOFS.  The combination of these flags makes memory allocation
> failures much more likely.
>
> We've seen those allocation failures show up when the loopback driver is
> doing writeback from a workqueue to a file on NFS, where memory allocation
> failure results in errors or corruption within the loopback device's
> filesystem.
>
> Suggested-by: Trond Myklebust <trondmy@kernel.org>
> Fixes: 0bae835b63c5 ("NFS: Avoid writeback threads getting stuck in mempool_alloc()")
> Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
> Reviewed-by: Laurence Oberman <loberman@redhat.com>
> Tested-by: Laurence Oberman <loberman@redhat.com>
> Reviewed-by: Jeff Layton <jlayton@kernel.org>
> ---
>
> 	On V3: fix ugly return (Thanks Paulo), add Jeff's R-b
> 	On V2: add missing 'Fixes' and Laurence's R-b T-b
>
>  fs/nfs/internal.h | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
> index 69c2c10ee658..d8f768254f16 100644
> --- a/fs/nfs/internal.h
> +++ b/fs/nfs/internal.h
> @@ -671,9 +671,12 @@ nfs_write_match_verf(const struct nfs_writeverf *verf,
>
>  static inline gfp_t nfs_io_gfp_mask(void)
>  {
> -	if (current->flags & PF_WQ_WORKER)
> -		return GFP_KERNEL | __GFP_NORETRY | __GFP_NOWARN;
> -	return GFP_KERNEL;
> +	gfp_t ret = current_gfp_context(GFP_KERNEL);
> +
> +	/* For workers __GFP_NORETRY only with __GFP_IO or __GFP_FS */
> +	if ((current->flags & PF_WQ_WORKER) && ret == GFP_KERNEL)
> +		ret |= __GFP_NORETRY | __GFP_NOWARN;
> +	return ret;
>  }
>
>  /*
> -- 
> 2.47.0


