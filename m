Return-Path: <linux-nfs+bounces-16686-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 45E62C7E311
	for <lists+linux-nfs@lfdr.de>; Sun, 23 Nov 2025 16:56:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 18E0A4E34B7
	for <lists+linux-nfs@lfdr.de>; Sun, 23 Nov 2025 15:56:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B69DB2D7393;
	Sun, 23 Nov 2025 15:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nGewsaN6"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 927552D7DE2
	for <linux-nfs@vger.kernel.org>; Sun, 23 Nov 2025 15:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763913390; cv=none; b=mdCXRvm91ZTPK+u1cY2GMIZQz5z8zeyFdAJdCQFrmF8DSASswvICe/3l4VpHv3m6jaQCilv49CfppLCGc1v0b5McoDzWwgPy+FmkZpuPis0O2uxR2zZ2KTa1izlnLgRRsMuuka7vH+fb0wFvS+GK8NlWPNvyDEHUs59CnNJliLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763913390; c=relaxed/simple;
	bh=pozccoRuP0WVXf1daWbSg/Q9P95SxKo+qTIysxdfDpc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=etm4nEaJ545Yv25BgnmnE4Ncy79QY213ruK0ZkjBrlCvdCNv9tKlADcPoavQUXZXUY0+gpSu8+26HsFKiC/sWREW3C54+Xdin4o2JwE5kpllIuENqE6rHqj5slL4vx0diiqUTCU5oj37CpGpDcrKwBIFn+cmObkWZJw3VgKtFrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nGewsaN6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC7CDC113D0;
	Sun, 23 Nov 2025 15:56:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763913390;
	bh=pozccoRuP0WVXf1daWbSg/Q9P95SxKo+qTIysxdfDpc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nGewsaN6sc3yRxUrGjv/dg/gdmr/5hBL5WRxDc6l95rRsHs5CMsziwZ+kfDXYOuH4
	 PYjF1QiyXXZc94d64SlFKRjN5bSoKnu0ril2TBirdQGDaJ+vmce1AcB16YLizqpRtv
	 ky93n2bwl82XuBTs+6PfRG9/AYTBvb1Ad7SEe3qkPQVEHUsMu43ueHkKuv2NrX9HSg
	 I6G6xk2n8brZlpLvmzDbsBZyMAmX0hhc9RZbQYYew3hhCaWOa8qvl+MQnArTrCDwDf
	 LwDswUv4xJP5D619OF2zBJM4+H23srv+5U032RV+KAY8yXVnhBILPOgZY2dgNUAG36
	 YtKxzpHEqiYRw==
From: Chuck Lever <cel@kernel.org>
To: Calum Mackay <calum.mackay@oracle.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [RFC PATCH 06/10] Add access_mask_to_str() helper to nfs4.0/nfs4acl.py
Date: Sun, 23 Nov 2025 10:56:14 -0500
Message-ID: <20251123155623.514129-7-cel@kernel.org>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251123155623.514129-1-cel@kernel.org>
References: <20251123155623.514129-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 nfs4.0/nfs4acl.py | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/nfs4.0/nfs4acl.py b/nfs4.0/nfs4acl.py
index 329be01f9fd6..41b69c049410 100644
--- a/nfs4.0/nfs4acl.py
+++ b/nfs4.0/nfs4acl.py
@@ -290,6 +290,26 @@ def acl2mode_rfc8881(acl):
 
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


