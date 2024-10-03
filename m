Return-Path: <linux-nfs+bounces-6822-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 91C3198F24B
	for <lists+linux-nfs@lfdr.de>; Thu,  3 Oct 2024 17:15:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28C842822EF
	for <lists+linux-nfs@lfdr.de>; Thu,  3 Oct 2024 15:15:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28BEB1A4F03;
	Thu,  3 Oct 2024 15:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cL2nDCyL"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E6401A3A9A
	for <linux-nfs@vger.kernel.org>; Thu,  3 Oct 2024 15:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727968503; cv=none; b=fPtrRj0Dss9yBWtHdABC/OftQ9sijbkqAAJLripRfAqKUV6d0u84z06JHp0S4+BunDikn3FPD+UZKBlFZHWONko0ZIPBUDOUON+47ajjbLMP2DPtI78iulsS+Q4MZSfyn3TH7LXcHAyadzsBvBlKDqTjYUG+0pNeczCViKg/X8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727968503; c=relaxed/simple;
	bh=08J95sym7EbUZ5ed1aHKrIi1SAvmbhccq003fACym88=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MQXZnOs5UN1Z9vvJses/mbO50uvih0L4OCaKi/cIHH4McszmLafSq/Tvq/xpNVlIgSVDfCYv0ISoaXCtjqSDG0EkvxbWBQsr6UJ04/lH+3vGr8sORR8pXvsIJlp/EqM/9ORPlNEtdq4lA8ar9okShqvxX5XEQG4VTppd/b6yk2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cL2nDCyL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727968500;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wvSMEY8HtROR8gklRwCjr4mxN3nmXaS9GGq94vmCN2k=;
	b=cL2nDCyLKN2kdAfNmRpAZ8NrfFwUs9C9NanM3rFzPskMNqhTRsRvCKhN+XW1BZa7hgQNSg
	7wuP/8re+9yUE1Zgzw2yDzulSOE8B4y/1auCzhx4Coe3w/2L8C2p5PO/MlTr+N7U9PDk3H
	ns1qD+uVaprKNrv5sr3DTyFsyKv+7Jo=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-169-b9oxfTZsPkqb320o_NbS0Q-1; Thu,
 03 Oct 2024 11:14:57 -0400
X-MC-Unique: b9oxfTZsPkqb320o_NbS0Q-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B01D71955E84;
	Thu,  3 Oct 2024 15:14:55 +0000 (UTC)
Received: from fs-i40c-03.mgmt.fast.eng.rdu2.dc.redhat.com (fs-i40c-03.mgmt.fast.eng.rdu2.dc.redhat.com [10.6.24.150])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 35C351955E8F;
	Thu,  3 Oct 2024 15:14:54 +0000 (UTC)
From: Alexander Aring <aahringo@redhat.com>
To: trondmy@kernel.org
Cc: anna@kernel.org,
	bcodding@redhat.com,
	gregkh@linuxfoundation.org,
	rafael@kernel.org,
	akpm@linux-foundation.org,
	linux-nfs@vger.kernel.org,
	gfs2@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] nfs: sysfs: use kset_type_create_and_add()
Date: Thu,  3 Oct 2024 11:14:34 -0400
Message-ID: <20241003151435.3753959-4-aahringo@redhat.com>
In-Reply-To: <20241003151435.3753959-1-aahringo@redhat.com>
References: <20241003151435.3753959-1-aahringo@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Since we have the new udev helper kset_type_create_and_add() helper we
can use it as it allows to have an own kobj_type ktype that is necessary
for nfs for the nfs_netns_object_child_ns_type() kset type callback.

We lose some errno information related to kset_register() in probably
non-existing cases. We return always -ENOMEM as other uses of
kset_create_and_add() does.

The nfs_kset_release() can be replaced by the default udev helper
kset_release() as it does the same functionality.

Signed-off-by: Alexander Aring <aahringo@redhat.com>
---
 fs/nfs/sysfs.c | 29 +++--------------------------
 1 file changed, 3 insertions(+), 26 deletions(-)

diff --git a/fs/nfs/sysfs.c b/fs/nfs/sysfs.c
index bf378ecd5d9f..a6584203b7ff 100644
--- a/fs/nfs/sysfs.c
+++ b/fs/nfs/sysfs.c
@@ -20,12 +20,6 @@
 
 static struct kset *nfs_kset;
 
-static void nfs_kset_release(struct kobject *kobj)
-{
-	struct kset *kset = container_of(kobj, struct kset, kobj);
-	kfree(kset);
-}
-
 static const struct kobj_ns_type_operations *nfs_netns_object_child_ns_type(
 		const struct kobject *kobj)
 {
@@ -33,35 +27,18 @@ static const struct kobj_ns_type_operations *nfs_netns_object_child_ns_type(
 }
 
 static struct kobj_type nfs_kset_type = {
-	.release = nfs_kset_release,
+	.release = kset_release,
 	.sysfs_ops = &kobj_sysfs_ops,
 	.child_ns_type = nfs_netns_object_child_ns_type,
 };
 
 int nfs_sysfs_init(void)
 {
-	int ret;
-
-	nfs_kset = kzalloc(sizeof(*nfs_kset), GFP_KERNEL);
+	nfs_kset = kset_type_create_and_add("nfs", NULL, fs_kobj,
+					    &nfs_kset_type);
 	if (!nfs_kset)
 		return -ENOMEM;
 
-	ret = kobject_set_name(&nfs_kset->kobj, "nfs");
-	if (ret) {
-		kfree(nfs_kset);
-		return ret;
-	}
-
-	nfs_kset->kobj.parent = fs_kobj;
-	nfs_kset->kobj.ktype = &nfs_kset_type;
-	nfs_kset->kobj.kset = NULL;
-
-	ret = kset_register(nfs_kset);
-	if (ret) {
-		kfree(nfs_kset);
-		return ret;
-	}
-
 	return 0;
 }
 
-- 
2.43.0


