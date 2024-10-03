Return-Path: <linux-nfs+bounces-6821-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2307098F249
	for <lists+linux-nfs@lfdr.de>; Thu,  3 Oct 2024 17:15:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C8FC283453
	for <lists+linux-nfs@lfdr.de>; Thu,  3 Oct 2024 15:15:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F3A219B59F;
	Thu,  3 Oct 2024 15:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Bu+FNi6q"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A28421A2C2A
	for <linux-nfs@vger.kernel.org>; Thu,  3 Oct 2024 15:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727968502; cv=none; b=rTo8upyT9+vshPwnc24jNlCxAJNhMh49WyZqgnnFoU80jhOAuI1pJTQ0r0QO+tcI711h8Q25Nswm1WMe77qGAZtitc8Zxd3HS0JgaPQxFXRpANtk1z1pXqq/cR5fEm7cvF+iEgiSeNV5eEj4CsCvEHfdktC/IK79bHAlesDejT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727968502; c=relaxed/simple;
	bh=/HOjq9X9X2KQMEsqDRneNuPn5l3Rhurp22TwSf3G5Sg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FbT1kBxKoIg+jGEkDR1otoN9+eoDIUtuey9nYenoiLq0dt3ucH9PlIvT5a1BhZUvXjCIHITfkZfs6BUUWj1DdcoFrVtV3VGAzxW2JiCijOuRML9rsBXWQAw7as5JQTl6abZ/kGgZPBukShK5dLFT1ojlOyHEKq8HOCh+jZpZtMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Bu+FNi6q; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727968499;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qhdi0ZWmWYR0MqvX3gdvffJxUEfr+B4dJmnDyHHBiGU=;
	b=Bu+FNi6qolxxaLXRSzWbRxH2+lmsfbUDPTDgP+K1F+CjtpYrmkp3OMpdt2pHGGmUcMPmJb
	vVySfQpGv/4+fuRHpKvVhKHOD7m2YWMPcFv5CZ7epe5vTmmfMdZTLViY7PJclV2T6OpbVr
	qmG4xpOtmG4xWn7vdoSYbd8VB7JKykY=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-460-OWZ8mrn_OIaGgW36qh4LDw-1; Thu,
 03 Oct 2024 11:14:55 -0400
X-MC-Unique: OWZ8mrn_OIaGgW36qh4LDw-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 07A62195608A;
	Thu,  3 Oct 2024 15:14:54 +0000 (UTC)
Received: from fs-i40c-03.mgmt.fast.eng.rdu2.dc.redhat.com (fs-i40c-03.mgmt.fast.eng.rdu2.dc.redhat.com [10.6.24.150])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id AACFC19560A3;
	Thu,  3 Oct 2024 15:14:52 +0000 (UTC)
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
Subject: [PATCH 2/4] kobject: export generic helper ops
Date: Thu,  3 Oct 2024 11:14:33 -0400
Message-ID: <20241003151435.3753959-3-aahringo@redhat.com>
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

This patch exports generic helpers like kset_release() and
kset_get_ownership() so users can use them in their own struct kobj_type
implementation instead of implementing their own functions that do the
same.

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Alexander Aring <aahringo@redhat.com>
---
 include/linux/kobject.h | 2 ++
 lib/kobject.c           | 6 ++++--
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/include/linux/kobject.h b/include/linux/kobject.h
index 7504b7547ed2..5fbc358e2be6 100644
--- a/include/linux/kobject.h
+++ b/include/linux/kobject.h
@@ -181,6 +181,8 @@ kset_type_create_and_add(const char *name, const struct kset_uevent_ops *u,
 struct kset * __must_check
 kset_create_and_add(const char *name, const struct kset_uevent_ops *u,
 		    struct kobject *parent_kobj);
+void kset_release(struct kobject *kobj);
+void kset_get_ownership(const struct kobject *kobj, kuid_t *uid, kgid_t *gid);
 
 static inline struct kset *to_kset(struct kobject *kobj)
 {
diff --git a/lib/kobject.c b/lib/kobject.c
index 09dd3d4c7f56..ccd2f6282c81 100644
--- a/lib/kobject.c
+++ b/lib/kobject.c
@@ -920,19 +920,21 @@ struct kobject *kset_find_obj(struct kset *kset, const char *name)
 }
 EXPORT_SYMBOL_GPL(kset_find_obj);
 
-static void kset_release(struct kobject *kobj)
+void kset_release(struct kobject *kobj)
 {
 	struct kset *kset = container_of(kobj, struct kset, kobj);
 	pr_debug("'%s' (%p): %s\n",
 		 kobject_name(kobj), kobj, __func__);
 	kfree(kset);
 }
+EXPORT_SYMBOL_GPL(kset_release);
 
-static void kset_get_ownership(const struct kobject *kobj, kuid_t *uid, kgid_t *gid)
+void kset_get_ownership(const struct kobject *kobj, kuid_t *uid, kgid_t *gid)
 {
 	if (kobj->parent)
 		kobject_get_ownership(kobj->parent, uid, gid);
 }
+EXPORT_SYMBOL_GPL(kset_get_ownership);
 
 static const struct kobj_type kset_ktype = {
 	.sysfs_ops	= &kobj_sysfs_ops,
-- 
2.43.0


