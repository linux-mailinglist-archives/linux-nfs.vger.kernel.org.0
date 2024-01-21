Return-Path: <linux-nfs+bounces-1214-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B0488357E4
	for <lists+linux-nfs@lfdr.de>; Sun, 21 Jan 2024 22:17:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D4311C208DA
	for <lists+linux-nfs@lfdr.de>; Sun, 21 Jan 2024 21:17:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48FB938DDE;
	Sun, 21 Jan 2024 21:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=venev.name header.i=@venev.name header.b="R4YwVzQ9"
X-Original-To: linux-nfs@vger.kernel.org
Received: from a1-bg02.venev.name (a1-bg02.venev.name [213.240.239.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E805538DDA
	for <linux-nfs@vger.kernel.org>; Sun, 21 Jan 2024 21:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.240.239.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705871862; cv=none; b=iLkzgdGKp1pYFA9hZ3eX/KNiSCtFvIuWUEbRNk7/dYu9ILv6p1nn8M98oHir2Krjsg6CTkSR+v1c5ta1nPcaqpF6el2SBdqe5FYEUOOeLsqIGUfu+uNxflDXR9jc2TmJF/LLDTutGuteKLX4aS1lERZhucwwOzd9eEuhQS6Yeao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705871862; c=relaxed/simple;
	bh=CNZO+BH7Te8sMffi0D9C1JwgkJdxkuEKO8Njy3ImQSo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AydmOiGikoXOSn8p8QM6Vu2lZVWF2fBcG+AV7PFakHYqcQI/ksMSYRUpNB0jne8UaqRG9YNqFOGl1Isnl7JFdxvgqOwMpYQ8p++BjH9Ibml4Eyukp/s2KW9CtUa1fZSQdDUIL6ZAmtbQaX9qkE9d8qwof0hBD+V2TMLLa2TSyvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=venev.name; spf=pass smtp.mailfrom=venev.name; dkim=pass (4096-bit key) header.d=venev.name header.i=@venev.name header.b=R4YwVzQ9; arc=none smtp.client-ip=213.240.239.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=venev.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=venev.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=venev.name;
	s=default; h=Content-Transfer-Encoding:Message-ID:Date:Subject:To:From:
	Content-Type:Reply-To:Sender; bh=2+Jsf8Tsk4H4St9LwupFlsi7Vnpr05wMgxvoffF7T34=
	; b=R4YwVzQ9YpXqOSvsrVLKIcteKjxdB5wBO4c+pa4SZrmCsb7xMZGMXMFhpZzfoKisZQvgjMP/3
	O4ZNhGCB49etRiX1vYZJwsOdnV/PHCyKfH/zmniVERh8A4uHHx4H4/rGZjQViSzs9ZIVWON9CvUrt
	RiNJCrKBsg78nLiuqIC6CUqmRnG1v1Yu4FQBFWJdiFxTY0FVthEjql1RiWiYlykH23u+xf84FUPuO
	un+QIuFt1TyuAbifj3oKkFtk0gPsP1a/d6p/tBNgdnWJKkJa6IMI1uZ8fnGkJXhO5RLKR8BMOBs3Q
	vTj9V9B6gJEtNbB9TOD0agN9RYPqSH604YX+aIwrJUnLKMBA3Nu8i4eaQiejgjXdxoUr+3mkwGIp0
	Vo0G24QXwc0D6NOnoSja02DDh1OTcpd8Mh9YyknTu9l2bzudX82tc6QsqPHLrz0aU2vcdWu94Amu9
	x2YAbcI6FLh39+J1xbC29riqQ6gzCMoTsiP+1yWJbQhdpQvlb4VeS+IvfFMuC2ur+0rEyhuZGBTKy
	qdfBwuw3ZoqTaf6KNH0vI0sSpdNy8o4+Ta9up8Duuni/LYhRDDUY7xkD3jYO0qRrcRPZ/cCq5FGlg
	m0i2gptnD3x8VPtDJRCf0cibaCJxKcRnMe4L6hmDISsr4NyjhGSooWIkxhJ8z1109XTvLws=;
Received: from a1-bg02.venev.name ([213.240.239.49] helo=pmx1.venev.name)
	by a1-bg02.venev.name with esmtps
	id 1rRew9-000000007tT-45XO
	(TLS1.3:TLS_AES_256_GCM_SHA384:256)
	(envelope-from <hristo@venev.name>);
	Sun, 21 Jan 2024 21:01:01 +0000
Received: from venev.name ([213.240.239.49])
	by pmx1.venev.name with ESMTPSA
	id Ab1SNQyGrWWHdgAAT9YxdQ
	(envelope-from <hristo@venev.name>); Sun, 21 Jan 2024 21:01:01 +0000
From: Hristo Venev <hristo@venev.name>
To: David Howells <dhowells@redhat.com>,
	linux-cachefs@redhat.com
Cc: Chris Chilvers <chilversc@gmail.com>,
	linux-nfs@vger.kernel.org,
	benmaynard@google.com,
	brennandoyle@google.com,
	tom@gunpowder.tech,
	daire@dneg.com,
	Chris Chilvers <chris.chilvers@appsbroker.com>,
	Hristo Venev <hristo@venev.name>
Subject: [PATCH] Fix random abort()
Date: Sun, 21 Jan 2024 22:57:39 +0200
Message-ID: <20240121205744.29575-1-hristo@venev.name>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CAAmbk-dAD65xUNQ5C004rc_AU4qXhYj5NTLzwm7khQr-KV1LYg@mail.gmail.com>
References: <CAAmbk-dAD65xUNQ5C004rc_AU4qXhYj5NTLzwm7khQr-KV1LYg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It is perfectly fine for the high nibble of the low 32 bits of a pointer
to be 6. Use NULL as a marker for missing entries.

Signed-off-by: Hristo Venev <hristo@venev.name>
---
 cachefilesd.c | 30 ++++++++++++------------------
 1 file changed, 12 insertions(+), 18 deletions(-)

diff --git a/cachefilesd.c b/cachefilesd.c
index d4d236f..851815d 100644
--- a/cachefilesd.c
+++ b/cachefilesd.c
@@ -30,6 +30,7 @@
 #define CACHEFILESD_VERSION "0.10.10"
 
 #define _GNU_SOURCE
+#include <assert.h>
 #include <stdarg.h>
 #include <stdbool.h>
 #include <stdio.h>
@@ -1092,7 +1093,6 @@ static void put_object(struct object *object)
 
 	parent = object->parent;
 
-	memset(object, 0x6d, sizeof(struct object));
 	free(object);
 
 	if (parent)
@@ -1213,7 +1213,7 @@ static void insert_into_cull_table(struct object *object)
 
 	/* newest object in table will be displaced by this one */
 	put_object(cullbuild[0]);
-	cullbuild[0] = (void *)(0x6b000000 | __LINE__);
+	cullbuild[0] = NULL;
 	object->usage++;
 
 	/* place directly in first slot if second is older */
@@ -1391,7 +1391,7 @@ next:
 
 			if (loop == nr_in_ready_table - 1) {
 				/* child was oldest object */
-				cullready[--nr_in_ready_table] = (void *)(0x6b000000 | __LINE__);
+				cullready[--nr_in_ready_table] = NULL;
 				put_object(child);
 				goto removed;
 			}
@@ -1400,7 +1400,7 @@ next:
 				memmove(&cullready[loop],
 					&cullready[loop + 1],
 					(nr_in_ready_table - (loop + 1)) * sizeof(cullready[0]));
-				cullready[--nr_in_ready_table] = (void *)(0x6b000000 | __LINE__);
+				cullready[--nr_in_ready_table] = NULL;
 				put_object(child);
 				goto removed;
 			}
@@ -1409,17 +1409,11 @@ next:
 				if (cullbuild[loop] == child)
 					break;
 
-			if (loop == nr_in_build_table - 1) {
-				/* child was oldest object */
-				cullbuild[--nr_in_build_table] = (void *)(0x6b000000 | __LINE__);
-				put_object(child);
-			}
-			else if (loop < nr_in_build_table - 1) {
-				/* child was somewhere in between */
+			if (loop < nr_in_build_table) {
 				memmove(&cullbuild[loop],
 					&cullbuild[loop + 1],
 					(nr_in_build_table - (loop + 1)) * sizeof(cullbuild[0]));
-				cullbuild[--nr_in_build_table] = (void *)(0x6b000000 | __LINE__);
+				cullbuild[--nr_in_build_table] = NULL;
 				put_object(child);
 			}
 
@@ -1531,7 +1525,7 @@ static void decant_cull_table(void)
 
 		n = copy * sizeof(cullready[0]);
 		memcpy(cullready, cullbuild, n);
-		memset(cullbuild, 0x6e, n);
+		memset(cullbuild, 0, n);
 		nr_in_ready_table = nr_in_build_table;
 		nr_in_build_table = 0;
 		goto check;
@@ -1558,8 +1552,9 @@ static void decant_cull_table(void)
 	memmove(&cullready[copy], &cullready[0], nr_in_ready_table * sizeof(cullready[0]));
 	nr_in_ready_table += copy;
 
-	memcpy(&cullready[0], &cullbuild[leave], copy * sizeof(cullready[0]));
-	memset(&cullbuild[leave], 0x6b, copy * sizeof(cullbuild[0]));
+	n = copy * sizeof(cullready[0]);
+	memcpy(&cullready[0], &cullbuild[leave], n);
+	memset(&cullbuild[leave], 0, n);
 	nr_in_build_table = leave;
 
 	if (copy + leave > culltable_size)
@@ -1567,8 +1562,7 @@ static void decant_cull_table(void)
 
 check:
 	for (loop = 0; loop < nr_in_ready_table; loop++)
-		if (((long)cullready[loop] & 0xf0000000) == 0x60000000)
-			abort();
+		assert(cullready[loop]);
 }
 
 /*****************************************************************************/
@@ -1645,6 +1639,6 @@ static void cull_objects(void)
 
 	if (cullready[nr_in_ready_table - 1]->cullable) {
 		cull_object(cullready[nr_in_ready_table - 1]);
-		cullready[--nr_in_ready_table] = (void *)(0x6b000000 | __LINE__);
+		cullready[--nr_in_ready_table] = NULL;
 	}
 }
-- 
2.43.0


