Return-Path: <linux-nfs+bounces-4158-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2750910A4F
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Jun 2024 17:45:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00F1D1C23175
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Jun 2024 15:45:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC9D91CAAD;
	Thu, 20 Jun 2024 15:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I//zqTLZ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A08C1EA8F
	for <linux-nfs@vger.kernel.org>; Thu, 20 Jun 2024 15:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718898320; cv=none; b=j9P5XQMkTcMlmzR8bS9EmWPT1jCO/X0D90IuH4f0nxlGONo7F2VT9KLOv7uateJQe8/s7UdvBasQhetTDbPeB7jAf3IOE25ti2d7O8m+1nmADYrM8Y+S4WFjLty1LaVzgtEFHcHBs1lnTv6UgMFPHZoW2ywF32GJoBXG+8laM6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718898320; c=relaxed/simple;
	bh=tPUN57YVtjaXYWG3OHoI9UU+f8cGb7hiIHsNCsqSTZ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ntVzRogjKzD9aS2qaRkReXpyiJKeupwkaVv+fKEFCyXNzCYy++d6eog6nQFaSIV0Gcmcu5fibASzJSnU19nF0PnNFQ8paa59ajIVMeGXMbvBccXG/Z9fzZYJszerWPTCCi5u6j3PaA9fSfIdUIWJ4mpKseCV8xsWdrDcC/SIZw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=I//zqTLZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718898318;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hOnz+PGbi5KmoyOeNDBotra5gcvWZ/ZmkA8qhMPKGOk=;
	b=I//zqTLZuVXZKTRExnDbhHiM6VRlUpZGnPGa8pEE84GFgk9E8TNKwC+MsVbVb5iY4yOfnM
	vllAfnEbt3sZ9fVi7gi0EHchCsb/wyyoiQcaj2g7Y9NoA947kr8+1uohGJNteE81kamSRa
	cB8cKZkaH62PbpugI4WOn7mfso9xvPc=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-142-LcfUVZpxPVK1UIz21YuDWA-1; Thu,
 20 Jun 2024 11:45:14 -0400
X-MC-Unique: LcfUVZpxPVK1UIz21YuDWA-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 554E11977020;
	Thu, 20 Jun 2024 15:45:06 +0000 (UTC)
Received: from [192.168.37.1] (unknown [10.22.48.4])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E84D8196BC09;
	Thu, 20 Jun 2024 15:45:04 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: cel@kernel.org, linux-nfs@vger.kernel.org,
 Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [RFC PATCH 3/4] nfs/blocklayout: Fix premature PR key
 unregistration
Date: Thu, 20 Jun 2024 11:45:02 -0400
Message-ID: <DC39D637-E108-4D24-808F-7AEF29440263@redhat.com>
In-Reply-To: <20240620141519.GB20135@lst.de>
References: <20240619173929.177818-6-cel@kernel.org>
 <20240619173929.177818-9-cel@kernel.org> <20240620050614.GE19613@lst.de>
 <3859730C-40EC-4818-9058-D74E4153623B@redhat.com>
 <20240620141519.GB20135@lst.de>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On 20 Jun 2024, at 10:15, Christoph Hellwig wrote:

> On Thu, Jun 20, 2024 at 09:52:59AM -0400, Benjamin Coddington wrote:
>> On 20 Jun 2024, at 1:06, Christoph Hellwig wrote:
>>
>>> On Wed, Jun 19, 2024 at 01:39:33PM -0400, cel@kernel.org wrote:
>>>> -	if (test_bit(NFS_DEVICEID_UNAVAILABLE, &node->flags) == 0)
>>>> +	if (test_bit(NFS_DEVICEID_UNAVAILABLE, &node->flags) == 0) {
>>>
>>> It might be worth to invert this and keep the unavailable handling in
>>> the branch as that's the exceptional case.   That code is also woefully
>>> under-documented and could have really used a comment.
>>
>> The transient device handling in general, or just this bit of it?
>
> Basically the code behind this NFS_DEVICEID_UNAVAILABLE check here.

How about..


diff --git a/fs/nfs/blocklayout/blocklayout.c b/fs/nfs/blocklayout/blocklayout.c
index 6be13e0ec170..665c054784b4 100644
--- a/fs/nfs/blocklayout/blocklayout.c
+++ b/fs/nfs/blocklayout/blocklayout.c
@@ -564,25 +564,30 @@ bl_find_get_deviceid(struct nfs_server *server,
                gfp_t gfp_mask)
 {
        struct nfs4_deviceid_node *node;
-       unsigned long start, end;

 retry:
        node = nfs4_find_get_deviceid(server, id, cred, gfp_mask);
        if (!node)
                return ERR_PTR(-ENODEV);

-       if (test_bit(NFS_DEVICEID_UNAVAILABLE, &node->flags) == 0)
-               return node;
+       /* Transient devices are left in the cache with a timeout to minimize
+        * sending GETDEVINFO after every LAYOUTGET */
+       if (test_bit(NFS_DEVICEID_UNAVAILABLE, &node->flags)) {
+               unsigned long start, end;

-       end = jiffies;
-       start = end - PNFS_DEVICE_RETRY_TIMEOUT;
-       if (!time_in_range(node->timestamp_unavailable, start, end)) {
-               nfs4_delete_deviceid(node->ld, node->nfs_client, id);
-               goto retry;
+               end = jiffies;
+               start = end - PNFS_DEVICE_RETRY_TIMEOUT;
+
+               /* Maybe the device is back, let's look for it again */
+               if (!time_in_range(node->timestamp_unavailable, start, end)) {
+                       nfs4_delete_deviceid(node->ld, node->nfs_client, id);
+                       goto retry;
+               }
+               nfs4_put_deviceid_node(node);
+               return ERR_PTR(-ENODEV);
        }

-       nfs4_put_deviceid_node(node);
-       return ERR_PTR(-ENODEV);
+       return node;
 }

 static int


