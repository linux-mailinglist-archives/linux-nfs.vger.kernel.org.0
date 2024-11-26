Return-Path: <linux-nfs+bounces-8227-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D71569D9FAB
	for <lists+linux-nfs@lfdr.de>; Wed, 27 Nov 2024 00:32:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7438C16617C
	for <lists+linux-nfs@lfdr.de>; Tue, 26 Nov 2024 23:32:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A607D17591;
	Tue, 26 Nov 2024 23:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UY/FPzNO"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22E4D199FBB
	for <linux-nfs@vger.kernel.org>; Tue, 26 Nov 2024 23:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732663941; cv=none; b=NmBh1lo4S9m3x5Ca5BxUOHtOMYw/Jb7KjucV9bBY4RGo40WuBMRCGSmlUW3hvJCq5kbpE05W7HVpngEAX8ytUZ8sxS7LX19yLhr0gfTrA15uBKPPrrA/HeTdGnBsGwOpPUc5zMf91XWl9Umbc6m8VKgg0U7Meq30RnFGIlLLkeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732663941; c=relaxed/simple;
	bh=mI0joIgWUeOG82fqFknzYB48P3qdYsWJyaACdmwSoAg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DGQdSc6ptPEPCf3zs9cioSvwYLhpU3OKLExyXBlepnsPCvbBR7aNvSGcoe3hfGr980vaGA52BD56lxEtP2yNRjEv4dR2u5W2IFsZRip5vLXFNc3ILvW9SRz1Zk0YGXKl6mEf6q2Olxkxl+jCo/WqIQ2AAoKxYfNmclc4EP0FjE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UY/FPzNO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732663936;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=nR4XoofQtmTaT1ML9eucezntKdNKYu4SA7j8WJk5b5M=;
	b=UY/FPzNOCkx9uoUoCEhJ67ctrGtz9fsB4jVH6KqBe7j7CzczjTeqzJ9GhjS1A+svPYA1mF
	sJ2nLRNYQSavtJ4lVWtZObrjdp6EJUZ8dzES8HGjlL04ca0zOJwKPrZHK5XHLk6rhzjE5f
	OiSXZOni//Kb/ccMEgnbg7HNq7t1xKM=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-136-BoZN7hw3N16wiMG4dhAYEQ-1; Tue,
 26 Nov 2024 18:32:15 -0500
X-MC-Unique: BoZN7hw3N16wiMG4dhAYEQ-1
X-Mimecast-MFC-AGG-ID: BoZN7hw3N16wiMG4dhAYEQ
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8D5201955F42
	for <linux-nfs@vger.kernel.org>; Tue, 26 Nov 2024 23:32:14 +0000 (UTC)
Received: from bcodding.csb.redhat.com (unknown [10.22.74.7])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E5C0B1955F43;
	Tue, 26 Nov 2024 23:32:13 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: Steve Dickson <steved@redhat.com>
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH] libnsm: fix the safer atomic filenames fix
Date: Tue, 26 Nov 2024 18:32:12 -0500
Message-ID: <7463bba8aea785f7614e169e8cdfb3d8f1e1e64a.1732663909.git.bcodding@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Commit 9f7a91b51ffc ("libnsm: safer atomic filenames") messed up the length
arguement to snprintf() in nsm_make_temp_pathname such that the length is
longer than the computed string.  When compiled with "-O
-D_FORTIFY_SOURCE=3", __snprintf_chk will fail and abort statd.

The fix is to correct the original size calculation, then pull one from the
snprintf length for the final "/".

Fixes: 9f7a91b51ffc ("libnsm: safer atomic filenames")
Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
---
 support/nsm/file.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/support/nsm/file.c b/support/nsm/file.c
index e0804136ccbe..6663cac3fb0c 100644
--- a/support/nsm/file.c
+++ b/support/nsm/file.c
@@ -187,7 +187,7 @@ nsm_make_temp_pathname(const char *pathname)
 	char *path, *base;
 	int len;
 
-	size = strlen(pathname) + sizeof(".new") + 3;
+	size = strlen(pathname) + sizeof(".new") + 1;
 	if (size > PATH_MAX)
 		return NULL;
 
@@ -199,7 +199,7 @@ nsm_make_temp_pathname(const char *pathname)
 	strcpy(path, pathname);
 
 	len = base - pathname;
-	len += snprintf(path + len + 1, size-len, ".%s.new", base+1);
+	len += snprintf(path + len + 1, size - len - 1, ".%s.new", base+1);
 	if (error_check(len, size)) {
 		free(path);
 		return NULL;

base-commit: eb5abb5c60ab60f3c2f22518d513ed187f39bd9b
-- 
2.47.0


