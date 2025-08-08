Return-Path: <linux-nfs+bounces-13509-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D6E3B1E880
	for <lists+linux-nfs@lfdr.de>; Fri,  8 Aug 2025 14:38:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3DE607B198F
	for <lists+linux-nfs@lfdr.de>; Fri,  8 Aug 2025 12:37:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D67122797B1;
	Fri,  8 Aug 2025 12:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ctgeD3oq"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15AB5279334
	for <linux-nfs@vger.kernel.org>; Fri,  8 Aug 2025 12:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754656714; cv=none; b=I3kvmrQz8Ef1paFXKyCnMECl3g5YULGbS7BKUzooD413e820WiCEmoUksV4gRBvxr93IBm6qzJXmvjF5KcnjMjFC79LvEl6YwTInmRtMV/ZB2wdiQ05QMs/kSt4lC7HmU/r+5OEZojPUC7oKR8/CDSiOSSQnvsS/RkNjWiSNiTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754656714; c=relaxed/simple;
	bh=+z1SARUox8cV+m8+0oqKQI8N2ni6j8C28ZvZfwIMiVw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J9EcBFu0rglgQfcCwa9xEK4PXT2baqo26IFn6vPLBsDMx4zzjr77uBRKAD2gkJ7Jv9qYch9FH6KYK4ZTFNXLmWmUoirLfGZxVeYC+cDTVRaQGIXL5UypfWmIJqjdE7vAoN0Qyf1/O0AQ2WWWgfMGKJyid8GI4H6bbooRoem7Z6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ctgeD3oq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754656711;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2c5qQSEQJ04PpUTVBYvGevi1pSNfV7Q71bDlXVhAWyw=;
	b=ctgeD3oqSmNiuBYU9rH/IjzQpPOspQOCBoyeObQkkUjhZChlpSwKF1lCEYdmLXK49TA6Oh
	bsMoG3QRfeM21naJsr5CZZQQp25bfCNtFst3z1v77LAnKVFPCbUEPgfLq5zKqfjVZVmCDH
	iBEEHxpWnbsrN9DdD4p7y/WYAkNiwYs=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-650-Lvq33mHbNX2NeCDMkBqKYQ-1; Fri,
 08 Aug 2025 08:38:28 -0400
X-MC-Unique: Lvq33mHbNX2NeCDMkBqKYQ-1
X-Mimecast-MFC-AGG-ID: Lvq33mHbNX2NeCDMkBqKYQ_1754656707
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8D6AE1800561;
	Fri,  8 Aug 2025 12:38:27 +0000 (UTC)
Received: from [192.168.37.1] (unknown [10.22.74.8])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7488930002C0;
	Fri,  8 Aug 2025 12:38:26 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: Jeff Layton <jlayton@kernel.org>
Cc: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>,
 linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] nfs: more client side tracepoints in write and
 writeback codepaths
Date: Fri, 08 Aug 2025 08:38:24 -0400
Message-ID: <620922BE-915F-4987-8AD6-3D62D4749FB6@redhat.com>
In-Reply-To: <20250808-nfs-tracepoints-v1-0-f8fdebb195c9@kernel.org>
References: <20250808-nfs-tracepoints-v1-0-f8fdebb195c9@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On 8 Aug 2025, at 7:40, Jeff Layton wrote:

> This is a pile of tracepoint additions and cleanups. Most of these I
> plumbed in while tracking down the recent client-side corruption I've
> been hunting. Please consider for v6.18.
>
> Thanks,
>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
> Jeff Layton (5):
>       nfs: remove trailing space from tracepoint
>       nfs: add tracepoints to nfs_file_read() and nfs_file_write()
>       nfs: new tracepoints around write handling
>       nfs: more in-depth tracing of writepage events
>       nfs: add tracepoints to nfs_writepages()
>
>  fs/nfs/file.c     |  20 ++++++--
>  fs/nfs/nfstrace.h | 135 +++++++++++++++++++++++++++++++++++++++++++++++++++++-
>  fs/nfs/write.c    |  22 +++++++--
>  3 files changed, 168 insertions(+), 9 deletions(-)
> ---
> base-commit: 0919a5b3b11c699d23bc528df5709f2e3213f6a9
> change-id: 20250807-nfs-tracepoints-f1d84186564d
>
> Best regards,
> -- 
> Jeff Layton <jlayton@kernel.org>


These look great.

Reviewed-by: Benjamin Coddington <bcodding@redhat.com>

Ben


