Return-Path: <linux-nfs+bounces-10216-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73CA7A3E1C0
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Feb 2025 18:05:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BB223BA085
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Feb 2025 16:56:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDB8C2139C9;
	Thu, 20 Feb 2025 16:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u7NbG292"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A993E2139C4
	for <linux-nfs@vger.kernel.org>; Thu, 20 Feb 2025 16:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740070470; cv=none; b=HqCPPjn1TVEWGMPP1RobptMhlYrrHFKAut7v8RBYr7GWBlp7tNR8Vlj1ijD7KSvtWRX9AYgMQOysbRuvBeT7X13HQS/ch4zxZ6m1LtnyFEoPloysy8JQbLW5afshcDcBGW5WWXvFcNtUJ8IeZFboiVPgrdWYssjR5Wdv8kn8lyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740070470; c=relaxed/simple;
	bh=6+B103kNrr4MzPGaD5gNElD5oCwHerLbmG6yeE1epJc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=XPEOc2RNs4rDlhwCnMuF7ULG6J3954SNWwfvDg9sNZuF22PW1Aj8SKnRTDZmDkE1d2G95agsno6iv0GEKOAaXNmIj2ztwk1LgeIktFROm8+N+//BP/6mtzWB+gz/lyyAmhy6evN2UB/PZge4R4o+8IAxj1yD7fnkcNoY3AwTVD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u7NbG292; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B01D3C4CED1;
	Thu, 20 Feb 2025 16:54:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740070470;
	bh=6+B103kNrr4MzPGaD5gNElD5oCwHerLbmG6yeE1epJc=;
	h=From:Date:Subject:To:Cc:From;
	b=u7NbG292bvKh6jq2VFP12Cqu+KavEZZJdbYmuWiwlRYMHXLZGj1tKyu+ylEF90jWo
	 KhOxxb8ZIVmbQ1CyOSRsa7u/SwwKH/hCYXS0ZWtgYksPmXre3/0oGgw8qDSKa4u7mj
	 9YWX3f42CTRnKDDvqRc+EtFgxbpVapAygDsbDBgKS4OcWJk27YPs6BxVdy5NqUASvF
	 w3RZQl0zQUn7m6z92YEfjXeKqD3SQNXa3Sz4ItpxovRSLGjwA48pe4LEyKPOzw6+nf
	 YCxCsb8tWJRgGoTUC49fjRBPIIWXQRFCuQI065YDbb3ckySt4WQCg3RXUfA7kl3bgG
	 En9h7OJf8d/jQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 20 Feb 2025 11:54:28 -0500
Subject: [PATCH pynfs RFC] pynfs: add v4.1+ st_delegation and st_xattr
 tests to "all" group
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250220-fixes-v1-1-92c4b1745be8@kernel.org>
X-B4-Tracking: v=1; b=H4sIAENet2cC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDIyMD3bTMitRiXZOkJEMDY0tDQ/OURCWg2oKiVLAEUGm0UkFlXlqxQpC
 bs1JsbS0AfGP4l2IAAAA=
X-Change-ID: 20250220-fixes-4bb1039117da
To: Calum Mackay <calum.mackay@oracle.com>
Cc: Frank Filz <ffilzlnx@mindspring.com>, linux-nfs@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=7463; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=6+B103kNrr4MzPGaD5gNElD5oCwHerLbmG6yeE1epJc=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBnt15F8ItG36mnIL3ffHaOd67Mw0skVuU9kEZz8
 sYsuSgGicGJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZ7deRQAKCRAADmhBGVaC
 FcnSD/0au/8j4NnmkeFRUQu7h9kZfxVTuFfPZe80XJ60W5z1dUYTeWEP1Kjt7PAP9W7N4DTOQpJ
 8AFEHvXomXIeAcRmE7gu+AoV94VNPFjNlGbf9Lx4zi8B1bXmGIUgWr/GTURv5Jn0rXfN5uDGy6s
 gxgUhR1lGI63qIt2zGnf0gKhb7oxPCsCnmx9b3SuTpk4g/1IKMyPAh/DDHPbvHHg8S/MDVYXau0
 IeV4mIZDN69JZkM0TaCmF+ioG0ytQRFwN5oQd9FLlCwToMjaEZ0QwsJSd444isI8p0PZIPx3ptr
 dokELON5hCAOoBo3jwM60RFS2Uycm8FGZ2WijSzzXMh3sp8esrW1svZDxDjaDSuaGUqlqvKuv2h
 y3+uJTiWHK14Ims5VKoc/djd2dhsuhBRDvWEengSh0m8lEjCYb0/bCpkyK3ohn+4x2TeNqVwRxx
 x/AnVq+eeMIYmZ5wCEg8Pc4tQGHFAyt+yN8SOsGB4vvSDJCZlz6/yx7n0rWPtgN/3IonrOItECr
 HAsfpVgeCu8O2GUOYRPE3rsvVrfDnFyCDxp55swBYt0oCbwtUJGr9/PmUo/YcnjrDl/h3tXr28Z
 yOCqb8v1Fc9QXop0xT37GhDLGoXd/gueSbgJwN+yGdfEPl+q2x703K4GAgDGIQqMSF01Z5PDu2z
 3wiUr1/s6607FEg==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

These tests all pass against a fully up-to-date Linux knfsd, and I think
should pass against ganesha as well. Add the "all" flag to these tests.

Cc: Frank Filz <ffilzlnx@mindspring.com>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
Should we add the "all" tag to these tests? It might also be good to
think about tagging out a release before this change, so that we can
tell people to use a specific version if they're hitting problems.
---
 nfs4.1/server41tests/st_delegation.py | 24 ++++++++++++------------
 nfs4.1/server41tests/st_xattr.py      | 22 +++++++++++-----------
 2 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/nfs4.1/server41tests/st_delegation.py b/nfs4.1/server41tests/st_delegation.py
index fc374e693cb4b9a9adaaf5ff15a64a02573113b0..fa9b4515dba25c6dd0bf11b409b6eacf5e783cbd 100644
--- a/nfs4.1/server41tests/st_delegation.py
+++ b/nfs4.1/server41tests/st_delegation.py
@@ -67,7 +67,7 @@ def _testDeleg(t, env, openaccess, want, breakaccess, sec = None, sec2 = None):
 def testReadDeleg(t, env):
     """Test read delegation handout and return
 
-    FLAGS: open deleg
+    FLAGS: open deleg all
     CODE: DELEG1
     """
     _testDeleg(t, env, OPEN4_SHARE_ACCESS_READ,
@@ -76,7 +76,7 @@ def testReadDeleg(t, env):
 def testWriteDeleg(t, env):
     """Test write delegation handout and return
 
-    FLAGS: writedelegations deleg
+    FLAGS: writedelegations deleg all
     CODE: DELEG2
     """
     _testDeleg(t, env, OPEN4_SHARE_ACCESS_READ|OPEN4_SHARE_ACCESS_WRITE,
@@ -85,7 +85,7 @@ def testWriteDeleg(t, env):
 def testAnyDeleg(t, env):
     """Test any delegation handout and return
 
-    FLAGS: open deleg
+    FLAGS: open deleg all
     CODE: DELEG3
     """
     _testDeleg(t, env, OPEN4_SHARE_ACCESS_READ,
@@ -94,7 +94,7 @@ def testAnyDeleg(t, env):
 def testNoDeleg(t, env):
     """Test no delegation handout
 
-    FLAGS: open deleg
+    FLAGS: open deleg all
     CODE: DELEG4
     """
     sess1 = env.c1.new_client_session(b"%s_1" % env.testname(t))
@@ -115,7 +115,7 @@ def testNoDeleg(t, env):
 def testCBSecParms(t, env):
     """Test auth_sys callbacks
 
-    FLAGS: create_session open deleg
+    FLAGS: create_session open deleg all
     CODE: DELEG5
     """
     uid = 17
@@ -131,7 +131,7 @@ def testCBSecParms(t, env):
 def testCBSecParmsNull(t, env):
     """Test auth_null callbacks
 
-    FLAGS: create_session open deleg
+    FLAGS: create_session open deleg all
     CODE: DELEG6
     """
     recall = _testDeleg(t, env, OPEN4_SHARE_ACCESS_READ,
@@ -144,7 +144,7 @@ def testCBSecParmsNull(t, env):
 def testCBSecParmsChange(t, env):
     """Test changing of auth_sys callbacks with backchannel_ctl
 
-    FLAGS: create_session open deleg backchannel_ctl
+    FLAGS: create_session open deleg backchannel_ctl all
     CODE: DELEG7
     """
     uid1 = 17
@@ -165,7 +165,7 @@ def testDelegRevocation(t, env):
     """Allow a delegation to be revoked, check that TEST_STATEID and
        FREE_STATEID have the required effect.
 
-    FLAGS: deleg
+    FLAGS: deleg all
     CODE: DELEG8
     """
 
@@ -220,7 +220,7 @@ def testDelegRevocation(t, env):
 def testWriteOpenvsReadDeleg(t, env):
     """Ensure that a write open prevents granting a read delegation
 
-    FLAGS: deleg
+    FLAGS: deleg all
     CODE: DELEG9
     """
 
@@ -249,7 +249,7 @@ def testServerSelfConflict3(t, env):
     That should succeed.  Then do a write open from a different client,
     and verify that it breaks the delegation.
 
-    FLAGS: deleg
+    FLAGS: deleg all
     CODE: DELEG23
     """
 
@@ -357,7 +357,7 @@ def testCbGetattrNoChange(t, env):
     client regurgitate back the same attrs (indicating no changes). Then test
     that the attrs that the second client gets back match the first.
 
-    FLAGS: deleg
+    FLAGS: deleg all
     CODE: DELEG24
     """
     attrs1, attrs2 = _testCbGetattr(t, env)
@@ -376,7 +376,7 @@ def testCbGetattrWithChange(t, env):
     attrs before sending them back to the server. Test that the second client
     sees different attrs than the original one.
 
-    FLAGS: deleg
+    FLAGS: deleg all
     CODE: DELEG25
     """
     attrs1, attrs2 = _testCbGetattr(t, env, change=1, size=5)
diff --git a/nfs4.1/server41tests/st_xattr.py b/nfs4.1/server41tests/st_xattr.py
index b3eb8a87465b9fd76121e846f9927bfc0867ffc8..f67df9517bdbac0ebd88c0c9f94244a96d5d2d3e 100644
--- a/nfs4.1/server41tests/st_xattr.py
+++ b/nfs4.1/server41tests/st_xattr.py
@@ -15,7 +15,7 @@ current_stateid = stateid4(1, b'\0' * 12)
 def testGetXattrAttribute(t, env):
     """Server with xattr support MUST support.
 
-    FLAGS: xattr
+    FLAGS: xattr all
     CODE: XATT1
     VERS: 2-
     """
@@ -37,7 +37,7 @@ def testGetXattrAttribute(t, env):
 def testGetMissingAttr(t, env):
     """Server MUST return NFS4ERR_NOXATTR if value is missing.
 
-    FLAGS: xattr
+    FLAGS: xattr all
     CODE: XATT2
     VERS: 2-
     """
@@ -53,7 +53,7 @@ def testGetMissingAttr(t, env):
 def testCreateNewAttr(t, env):
     """Server MUST return NFS4_ON on create.
 
-    FLAGS: xattr
+    FLAGS: xattr all
     CODE: XATT3
     VERS: 2-
     """
@@ -76,7 +76,7 @@ def testCreateNewAttr(t, env):
 def testCreateNewIfMissingAttr(t, env):
     """Server MUST update existing attribute with SETXATTR4_EITHER.
 
-    FLAGS: xattr
+    FLAGS: xattr all
     CODE: XATT4
     VERS: 2-
     """
@@ -99,7 +99,7 @@ def testCreateNewIfMissingAttr(t, env):
 def testUpdateOfMissingAttr(t, env):
     """Server MUST return NFS4ERR_NOXATTR on update of missing attribute.
 
-    FLAGS: xattr
+    FLAGS: xattr all
     CODE: XATT5
     VERS: 2-
     """
@@ -117,7 +117,7 @@ def testUpdateOfMissingAttr(t, env):
 def testExclusiveCreateAttr(t, env):
     """Server MUST return NFS4ERR_EXIST on create of existing attribute.
 
-    FLAGS: xattr
+    FLAGS: xattr all
     CODE: XATT6
     VERS: 2-
     """
@@ -138,7 +138,7 @@ def testExclusiveCreateAttr(t, env):
 def testUpdateExistingAttr(t, env):
     """Server MUST return NFS4_ON on update of existing attribute.
 
-    FLAGS: xattr
+    FLAGS: xattr all
     CODE: XATT7
     VERS: 2-
     """
@@ -165,7 +165,7 @@ def testUpdateExistingAttr(t, env):
 def testRemoveNonExistingAttr(t, env):
     """Server MUST return NFS4ERR_NOXATTR on remove of non existing attribute.
 
-    FLAGS: xattr
+    FLAGS: xattr all
     CODE: XATT8
     VERS: 2-
     """
@@ -183,7 +183,7 @@ def testRemoveNonExistingAttr(t, env):
 def testRemoveExistingAttr(t, env):
     """Server MUST return NFS4_ON on remove of existing attribute.
 
-    FLAGS: xattr
+    FLAGS: xattr all
     CODE: XATT9
     VERS: 2-
     """
@@ -204,7 +204,7 @@ def testRemoveExistingAttr(t, env):
 def testListNoAttrs(t, env):
     """Server MUST return NFS4_ON an empty list if no attributes defined.
 
-    FLAGS: xattr
+    FLAGS: xattr all
     CODE: XATT10
     VERS: 2-
     """
@@ -227,7 +227,7 @@ def testListNoAttrs(t, env):
 def testListAttrs(t, env):
     """Server MUST return NFS4_ON and list of defined attributes.
 
-    FLAGS: xattr
+    FLAGS: xattr all
     CODE: XATT11
     VERS: 2-
     """

---
base-commit: 81a4693305abb42ffd16e77a4808a1a607693476
change-id: 20250220-fixes-4bb1039117da

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>


