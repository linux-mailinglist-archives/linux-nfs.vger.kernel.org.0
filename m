Return-Path: <linux-nfs+bounces-16722-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC14FC86DB9
	for <lists+linux-nfs@lfdr.de>; Tue, 25 Nov 2025 20:49:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DA923B50B3
	for <lists+linux-nfs@lfdr.de>; Tue, 25 Nov 2025 19:49:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A23AB33AD9C;
	Tue, 25 Nov 2025 19:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="poOzEf9q"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DF9632B9A6
	for <linux-nfs@vger.kernel.org>; Tue, 25 Nov 2025 19:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764100184; cv=none; b=Nf7Oh3PVpmcyd7IuEoIodwkf/O27hRKm0CUSBWh7sZyqQNhpu+wNDwNpcncP6SG6UJ/OfEDNFmVJHyMNTEU32LmakpTiddGraEg8fJF8G/Z/5hfUakpe+Glqs25L2bOHAlQ7mPRn6ff5wpiG15DvxTYwW+bKicBwtQZq/pLAveM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764100184; c=relaxed/simple;
	bh=38smlGlzGGFeXnqk5VOoTgHDCp5Dii0VEbiWIZAFatQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=guqIcfCPpR21cE3m2w9eDgibieRQOuijhA/9OetYUWKf61FvlLZcH0fgfhqKafoTG2d0czD3rB81a4p6CYYL560D8TwGINozLeJ5Vg9erpmaFiwNAe3OFiOHcJqPGBMNEP6kmVEIye6Y7G5eqq3Qk8m4mb/94eCh+KTcG1C/eb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=poOzEf9q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC500C116D0;
	Tue, 25 Nov 2025 19:49:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764100184;
	bh=38smlGlzGGFeXnqk5VOoTgHDCp5Dii0VEbiWIZAFatQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=poOzEf9qLTTYhIlOzdZ5kA2f2keD3cnW//+4WaHRYj5Wj3l+UcK3lWAfBa9sTDiEf
	 n+mGIfCMdIK39Xkddm1u9MSZcLtdSv4oNJlc707cI07xsqCgWvbKJ4nun5c7Rs1oKN
	 MWCW6+3RSYoIjcB2kS3/Ru9kRu/MiqIMHM38NRz9hKfyfbefMCdJiQeqRdeqbpi7k4
	 D5oxoK6tt3aEfTlu7+GpLPmmOK84GfuGfHqd6wo57DgsJqrXKQ1iG8iIVWBtS7+FfX
	 6W89eBBzjBI8VVZGtEbBLt/ya3d95UTlh8hG4xNpcWl4rzAoSkpck4XAvJ6QVMHqlB
	 6Fk7WB9lUxYdQ==
From: Chuck Lever <cel@kernel.org>
To: <linux-nfs@vger.kernel.org>
Cc: Calum Mackay <calum.mackay@oracle.com>,
	aurelien.couderc2002@gmail.com,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v2 7/9] Add verify_mode_and_acl() helper to nfs4acl modules
Date: Tue, 25 Nov 2025 14:49:32 -0500
Message-ID: <20251125194936.770792-8-cel@kernel.org>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251125194936.770792-1-cel@kernel.org>
References: <20251125194936.770792-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

I'm about to add new tests that set a test ACL and mode bits
simultaneously. This is common code for the new tests, so introduce
a utility function to verify the ACL and mode bits.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 nfs4.0/nfs4acl.py | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/nfs4.0/nfs4acl.py b/nfs4.0/nfs4acl.py
index 5197b1238ea8..f33fdb0752bc 100644
--- a/nfs4.0/nfs4acl.py
+++ b/nfs4.0/nfs4acl.py
@@ -349,6 +349,45 @@ def verify_acl(returned_acl, expected_acl):
                  access_mask_to_str(returned_ace.access_mask),
                  access_mask_to_str(missing)))
 
+def verify_mode_and_acl(attrs_dict, expected_acl, operation="operation"):
+    """Verify that MODE and ACL attributes match expectations
+
+    This helper encapsulates the common pattern of verifying both ACL
+    and mode derivation per RFC 8881 Section 6.3.2.
+
+    Args:
+        attrs_dict: Dictionary of attributes (must contain FATTR4_ACL and FATTR4_MODE)
+        expected_acl: The ACL that should be present
+        operation: Name of operation for error messages (default: "operation")
+
+    Returns:
+        tuple: (returned_mode, expected_mode) - both as integers with low 9 bits
+
+    Raises:
+        AssertionError: If verification fails
+    """
+    # Check that both attributes are present
+    if FATTR4_ACL not in attrs_dict:
+        raise AssertionError(
+            "ACL attribute not returned after %s" % operation)
+    if FATTR4_MODE not in attrs_dict:
+        raise AssertionError(
+            "MODE attribute not returned after %s" % operation)
+
+    # Verify ACL matches expected
+    verify_acl(attrs_dict[FATTR4_ACL], expected_acl)
+
+    # Verify mode matches RFC 8881 derivation from ACL
+    returned_mode = attrs_dict[FATTR4_MODE] & 0o777
+    expected_mode = acl2mode_rfc8881(attrs_dict[FATTR4_ACL])
+
+    if returned_mode != expected_mode:
+        raise AssertionError(
+            "MODE (0%o) does not match RFC 8881 §6.3.2 derivation "
+            "from ACL (expected 0%o)" % (returned_mode, expected_mode))
+
+    return returned_mode, expected_mode
+
 def printableacl(acl):
     type_str = ["ACCESS", "DENY"]
     out = ""
-- 
2.51.1


