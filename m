Return-Path: <linux-nfs+bounces-12924-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92338AFC84A
	for <lists+linux-nfs@lfdr.de>; Tue,  8 Jul 2025 12:25:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B00EC3A501C
	for <lists+linux-nfs@lfdr.de>; Tue,  8 Jul 2025 10:25:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 830D822DFA4;
	Tue,  8 Jul 2025 10:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bIjb1WIf"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B023921767A
	for <linux-nfs@vger.kernel.org>; Tue,  8 Jul 2025 10:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751970323; cv=none; b=hTvSiAoJN149DmEIaSlNSG2XXsSYsadeEhgm8Ip1vgUhsqUMUEdNnb613zbTjJoZATVDaluhoJB1Kjw9JorRrIlunAmrgaVncXawA4Y6dXUZZcBcmDUuznxpC7h73HnqXilUd3dddsTs+jmm9K0kOgw/xn2ru3pvGLONuofXQQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751970323; c=relaxed/simple;
	bh=adxrwvHH9jGA3rnCawcVdF/L4S3UTXsY1TjDr0W1ZqA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lMlbBGyLnft7koYNGAM3WT/ShOBZGcHyRU29jGEbjRLIM1f/U99XcCH9QF2bejTFznZ3E4vNI+EQ/uAuVl2YAxtTaATdr4wnycGVgxYO0Tu7tbqSWUqNvMNGy3Z3lJ75kmYBqduPYrU7a2k8wGvMZyKat8M1s0iNlB9ckzks24Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bIjb1WIf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751970320;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hqVqXPKx/cgWhIOEtnql2P3i8N6AT9IoowaK1wcPp6w=;
	b=bIjb1WIfE5ZBq9LSsyWkgW+QEhWlSBYVEGZnNGB4/8esjJrjSkQ2QNjzUZ4HVmOM/Qk+hi
	4Kzr8bMtuAEbT0zJVUafmQBP7cOArDXJtG7Pnl6QTJMMTt9iPG/dFMzntCl2XouB8Ob9vC
	nPd4HstvDWNH5yp6FZf5z55WLVk8BAg=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-114-3qkajHaYP0eP_EFym3SV_g-1; Tue,
 08 Jul 2025 06:25:17 -0400
X-MC-Unique: 3qkajHaYP0eP_EFym3SV_g-1
X-Mimecast-MFC-AGG-ID: 3qkajHaYP0eP_EFym3SV_g_1751970316
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 26F7A18002ED;
	Tue,  8 Jul 2025 10:25:16 +0000 (UTC)
Received: from [192.168.37.1] (unknown [10.22.74.5])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C94F7180045B;
	Tue,  8 Jul 2025 10:25:13 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: Tejun Heo <tj@kernel.org>
Cc: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>,
 Lai Jiangshan <jiangshanlai@gmail.com>, linux-nfs@vger.kernel.org,
 linux-kernel@vger.kernel.org, djeffery@redhat.com, loberman@redhat.com
Subject: Re: [PATCH 1/2] workqueue: Add a helper to identify current workqueue
Date: Tue, 08 Jul 2025 06:25:11 -0400
Message-ID: <8732DDAB-026F-49F8-9B10-8D25C4732CA9@redhat.com>
In-Reply-To: <aGygp-3mtsLxtGT3@slm.duckdns.org>
References: <cover.1751913604.git.bcodding@redhat.com>
 <baad3adf8ea80b65d83dd196ab715992a0f1b768.1751913604.git.bcodding@redhat.com>
 <aGygp-3mtsLxtGT3@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On 8 Jul 2025, at 0:37, Tejun Heo wrote:

> On Mon, Jul 07, 2025 at 02:46:03PM -0400, Benjamin Coddington wrote:
>> Introduce a new helper current_workqueue() which returns the current task's
>> workqueue pointer or NULL if not a workqueue worker.
>>
>> This will allow the NFS client to recognize the case where writeback occurs
>> within the nfsiod workqueue or is being submitted directly.  NFS would like
>> to change the GFP_ flags for memory allocation to avoid stalls or cycles in
>> memory pools based on which context writeback is occurring.  In a following
>> patch, this helper detects the case rather than checking the PF_WQ_WORKER
>> flag which can be passed along from another workqueue worker.
>
> There's already current_work(). Wouldn't that be enough for identifying
> whether the current work item?

NFS submits different work items to the same workqueue, so comparing the
workqueue instead of the work items made more sense.

After discussion on patch 2 yesterday, I think we're going to try to fix
this in NFS using a different approach that won't need this helper now.

Thanks for the look Tejun.
Ben


