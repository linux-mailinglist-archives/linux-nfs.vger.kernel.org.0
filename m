Return-Path: <linux-nfs+bounces-16719-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A4B44C86DAD
	for <lists+linux-nfs@lfdr.de>; Tue, 25 Nov 2025 20:49:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C035B4E9DB8
	for <lists+linux-nfs@lfdr.de>; Tue, 25 Nov 2025 19:49:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F36EE33AD82;
	Tue, 25 Nov 2025 19:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WRGGw+uf"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF0ED33AD88
	for <linux-nfs@vger.kernel.org>; Tue, 25 Nov 2025 19:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764100182; cv=none; b=Ssy6DT9b/EirlwlgD22+aUtaPfXQVDDl0trqHfpww9s2mzRzGlGpPOnvc86a9GSJNX090yLLL7636hNE9M1B5zWH6JV2EWXMz0teFZPhIKmktrqGEscfB6iMr6AYt3L44yi+LPlHrnhdY3PnM0nQ6yec6Kw0C8wwOG387a67LKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764100182; c=relaxed/simple;
	bh=z/Lxe2ac7RgZOW5mUUYrkTNkVqbUIUQLAbnMgu4BKzo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ikEcFRVGA157o/6TlOT77Ckdkq7XgLFw6ePndJlTOd/P9vmFKwJi5Mz79PoBGUoU9NUAQAlp+uWX4QQs38kH5FI5e+8S6bL0r3XxfgjxyvXQlqxetwTqgbQW/mlEvxIWNv08JIUta2fB5KXSABtgyQB5BsHXyWGtSSG4mVWpLqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WRGGw+uf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11A5AC4CEF1;
	Tue, 25 Nov 2025 19:49:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764100182;
	bh=z/Lxe2ac7RgZOW5mUUYrkTNkVqbUIUQLAbnMgu4BKzo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WRGGw+ufBWkyVobs7HC+d0h5c4u+MOswddAwXYCTraFMSMxeydO06Xq5XeZeTmxU9
	 k3SEYPSeUGP9Y0oPizoElY3hBMJS0yERcla94JeIfrs5ZmhiHOOimsL7D+amUi/JJN
	 p/DnolEnghtUxGUUF4F4QH+1EnA90pHET1NgemBSAKmDyl756BYcLwqbXIwGMl/pmO
	 GGOk2PTYbD5xKe4yUUPRaCtWaTaczVInHiC+V81NTPUG5lufS4cNSq3SPM32jKo3Kt
	 AP4CBlC2BPI/AQLS0ay7t2l0MOmOUEMoNjZ5W713+GAfoirvS0YNzUcYS2PWiVBaEw
	 jGkNqgxNCb48g==
From: Chuck Lever <cel@kernel.org>
To: <linux-nfs@vger.kernel.org>
Cc: Calum Mackay <calum.mackay@oracle.com>,
	aurelien.couderc2002@gmail.com,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v2 4/9] Add access_mask_to_str() helper to nfs4.0/nfs4acl.py
Date: Tue, 25 Nov 2025 14:49:29 -0500
Message-ID: <20251125194936.770792-5-cel@kernel.org>
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

I'm about to add several new ACL-related tests. Introduce
access_mask_to_str() to convert ACE access_mask values to human-
readable symbolic strings for the display output in these new
tests.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 nfs4.0/nfs4acl.py | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/nfs4.0/nfs4acl.py b/nfs4.0/nfs4acl.py
index 62193123ef7c..0fabd0860cff 100644
--- a/nfs4.0/nfs4acl.py
+++ b/nfs4.0/nfs4acl.py
@@ -268,6 +268,26 @@ def acl2mode_rfc8881(acl):
 
     return mode
 
+def access_mask_to_str(mask):
+    """Convert an ACE access_mask to a symbolic string representation"""
+    perms = [
+        (ACE4_READ_DATA, "READ_DATA"),
+        (ACE4_WRITE_DATA, "WRITE_DATA"),
+        (ACE4_APPEND_DATA, "APPEND_DATA"),
+        (ACE4_READ_NAMED_ATTRS, "READ_NAMED_ATTRS"),
+        (ACE4_WRITE_NAMED_ATTRS, "WRITE_NAMED_ATTRS"),
+        (ACE4_EXECUTE, "EXECUTE"),
+        (ACE4_DELETE_CHILD, "DELETE_CHILD"),
+        (ACE4_READ_ATTRIBUTES, "READ_ATTRIBUTES"),
+        (ACE4_WRITE_ATTRIBUTES, "WRITE_ATTRIBUTES"),
+        (ACE4_DELETE, "DELETE"),
+        (ACE4_READ_ACL, "READ_ACL"),
+        (ACE4_WRITE_ACL, "WRITE_ACL"),
+        (ACE4_WRITE_OWNER, "WRITE_OWNER"),
+        (ACE4_SYNCHRONIZE, "SYNCHRONIZE"),
+    ]
+    return " | ".join(name for bit, name in perms if mask & bit) or "(none)"
+
 def printableacl(acl):
     type_str = ["ACCESS", "DENY"]
     out = ""
-- 
2.51.1


