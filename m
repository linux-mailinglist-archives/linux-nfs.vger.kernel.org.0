Return-Path: <linux-nfs+bounces-16717-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0054CC86DAA
	for <lists+linux-nfs@lfdr.de>; Tue, 25 Nov 2025 20:49:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69FC03B4013
	for <lists+linux-nfs@lfdr.de>; Tue, 25 Nov 2025 19:49:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D682033A705;
	Tue, 25 Nov 2025 19:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eBOtElrR"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B003A332ED3
	for <linux-nfs@vger.kernel.org>; Tue, 25 Nov 2025 19:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764100181; cv=none; b=oySLpEux/YSxZCIi4U7C8rKulHEDJatxpaPElMq0ATiH6sp+OA0BnO7hgG67olHuUJAxF/pyR9B4KF3/3FZnufIq7xFGuQuw++jRRglMHQun8cHV7XsHR1cvilVQYOWhxyR/Q5aZvrGfh23worYnh6CC0LSufs/z4ejYzJhpyz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764100181; c=relaxed/simple;
	bh=PaROjV6NddiCKk55pIH2lYxmEFWzio4gRUyKRiTtLMQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=myVm2BsObmGcly2Dp1v/Z8Xyu7pfGrTQTddHCtTT2adS9sKYtGr8dK6sU17Es6LTkXCoIBVlWhmXULILvYklfIohFfwKnm6mTRMtx6dzVwCryKMCp8QYx6YZ3zmuExIkfegZbfp7ZU0/NM3Y8nEKMaZF+heGjb1UXkUQ4imihUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eBOtElrR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E825EC16AAE;
	Tue, 25 Nov 2025 19:49:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764100181;
	bh=PaROjV6NddiCKk55pIH2lYxmEFWzio4gRUyKRiTtLMQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eBOtElrRyRC4W1ZyBNkfMMQCictIS7Z+zwUwArKAIhdaBFfO9Bdv5f6JkRj6Zz+9h
	 BavhdIVlZsND35mP65E7XEiQP2bC/giI5rppq2cd+mabHAzZEXy+oG/ZA2i6Cz7u9G
	 NYwpNN0gCkna4sV6si0hwxozL4bdvTYNf+xFfajMi7+G0PQp/xnLAjK4Z6dEKzFNJX
	 aeuIXt46M6go1qNKJmobmbkASYoK9c3RmFnlVEcY/889b4pyV9YIW3w3j6HJ4y7v1J
	 vTIUQbhULkxIS9ADi2uDbmrGrHdESXX5oJjWY8TWpj9L4y2vt6idEeUI9QzZFJH9zT
	 /T0Sa9PyaNsCA==
From: Chuck Lever <cel@kernel.org>
To: <linux-nfs@vger.kernel.org>
Cc: Calum Mackay <calum.mackay@oracle.com>,
	aurelien.couderc2002@gmail.com,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v2 2/9] Add helper to format attribute bitmaps
Date: Tue, 25 Nov 2025 14:49:27 -0500
Message-ID: <20251125194936.770792-3-cel@kernel.org>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251125194936.770792-1-cel@kernel.org>
References: <20251125194936.770792-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

I'm about to add several new attribute-related tests. Introduce
attr_bitmap_to_str() in nfs4lib.py to convert attribute bitmaps to
human-readable symbolic strings.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 nfs4.1/nfs4lib.py | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/nfs4.1/nfs4lib.py b/nfs4.1/nfs4lib.py
index d3a1550f1ce1..9652cf41bef4 100644
--- a/nfs4.1/nfs4lib.py
+++ b/nfs4.1/nfs4lib.py
@@ -564,6 +564,14 @@ def attr_name(bitnum):
     """Returns string corresponding to attr bitnum"""
     return bitnum2attr.get(bitnum, "unknown_%r" % bitnum)
 
+def attr_bitmap_to_str(bitmap):
+    """Convert an attribute bitmap to a symbolic string representation"""
+    bits = bitmap2list(bitmap)
+    if not bits:
+        return "(none)"
+    names = [bitnum2attr.get(bit, "unknown_%d" % bit).upper() for bit in bits]
+    return ", ".join(names)
+
 class NFS4Error(Exception):
     def __init__(self, status, attrs=0, lock_denied=None, tag=None, check_msg=None):
         self.status = status
-- 
2.51.1


