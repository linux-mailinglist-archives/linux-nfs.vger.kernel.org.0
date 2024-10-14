Return-Path: <linux-nfs+bounces-7175-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E43699D882
	for <lists+linux-nfs@lfdr.de>; Mon, 14 Oct 2024 22:50:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 601F01C210DB
	for <lists+linux-nfs@lfdr.de>; Mon, 14 Oct 2024 20:50:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DDB21D14E9;
	Mon, 14 Oct 2024 20:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c0ngvPFE"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A5401D1318
	for <linux-nfs@vger.kernel.org>; Mon, 14 Oct 2024 20:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728939041; cv=none; b=NRrtvSeKCFBu7xRYCZlkXyyT28XDeQxrmABpTrzG8WWflYrymJ5+mnmXsbKG1KkdMm9slQa5G5a+3uq8aRfZyQcyO+zODqTGvjEFVgvMruvEjXtkn0CZg3Lbb45RfLaieLCOW8kH7F4UfyQaYsjhHWuDP/qUqnuL4r5g7T9Ur7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728939041; c=relaxed/simple;
	bh=DcBIxLUMKz9pCB7+oirBDOJg6h1EsTbBogYnuIqyvbo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pDL62NyR90OpIP2PO5EgOUl1GeCllO3Y6QUXoHLkiN3hfhCKGAUC688EBOXo4XdUz8q5DNLQaAvwn6kb/3oMvyXWi86a0eB/pmGosBtugqXlgUV0jdWeFdlbitFjGBoyyPPq3STrXRWnXY71dr2549EkyWfhgZc4WDJT/sQruaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c0ngvPFE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DCEFC4CECF;
	Mon, 14 Oct 2024 20:50:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728939040;
	bh=DcBIxLUMKz9pCB7+oirBDOJg6h1EsTbBogYnuIqyvbo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=c0ngvPFEmi81Y+4b/0q4drveD1yETVVeOZV90pJ1MhQE9YVY8a5MZSGoRKGgbBe5z
	 wNQM2oBK3qPTWfXiGLP6ReNodvWYBuLMwyyFkGMha2hJvy3X1+lLVqsC6rFEjnsXNB
	 7I1pJnEFJd9uqCb5lHXMWQiKcy4NbPoHIeuYvDN/hmozNaiei5y8EmWVypSt6Sdpcw
	 Kw3bf80bGDgE5RPVQflDB++Q/PwKK17RN0u3FkQf8wfZPlnBQBrrUTeY6noXSB8yGo
	 8lQw42Z2mynvopgkjpzOmJgHpBJ92ExqdmatKDEbMNiLsT7VHfi5iNEngiSkyr/wVD
	 of8mudK1jPUTQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 14 Oct 2024 16:50:27 -0400
Subject: [PATCH pynfs v2 7/7] st_deleg: test delegated timestamps in
 CB_GETATTR
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241014-cb_getattr-v2-7-3782e0d7c598@kernel.org>
References: <20241014-cb_getattr-v2-0-3782e0d7c598@kernel.org>
In-Reply-To: <20241014-cb_getattr-v2-0-3782e0d7c598@kernel.org>
To: Calum Mackay <calum.mackay@oracle.com>
Cc: linux-nfs@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4470; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=DcBIxLUMKz9pCB7+oirBDOJg6h1EsTbBogYnuIqyvbo=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBnDYQcr/qCuMdmN/7/J0FYHj5ZUweI2i0uyf5D7
 WYi7OIPS4OJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZw2EHAAKCRAADmhBGVaC
 FXLiEACNN+XYwYNIxm009s2yKHZHkJi95e3pVTweMMRl6dxsNMxlkKaRfqyBpx4Qmx8NriUX54o
 1O0gPO4iByQjJQDFWy/oCibGaToX//YdOSo6bwAZ2Y2Pa1np5ExXA7y3P4LotmrLiiy/PWfeGUF
 8LY4m9eAC0CvruJdZaTLhqB8ZfWN8hJ66F9puibflyT2QQa2iJ5yeVIuKvFdddDsMFubyqkdnvQ
 3lI1pTsOGmzF9ZFrVm4IEYIBX6uhw3OJATfBStF0kSazaGPAsIrKzIVvqKP9acZn4pMHm2sj9B0
 pzaJDVtwIl1Aq5GnAMrO+ISbJfJsw5S9+KXEmBQGaA1aRyztJRN31OGizZrIegI98/0MqoMsSCX
 Zn9dePJ+Cvso8hEfQ+ksWVE5uMyxN5Npz7EuCm2r0QHjJdZXEG4X/CREqbyS4gklfD3YH26Dicp
 UeiEzrreB1ajKYEAZCGF5Z4LWRl7zCn2TiRkH0uPzsEukMeFU2xr807aIhcwehNTk5p8oCS3tiI
 kgV1d3Hk3eKS//OTeAVXqA4X1Qus0lKxsj+dy2RBz/9v0Tr2+aJkLPvW8OiOOFyNISZoJk93sdr
 Ndsjg5rMXG8ctLu4yf2tA0SZnFuAscee82DC4s5f/O9CADKHhfm0zL0XDP1OvYDPEatl/l0wCPd
 +neeVEPR2AsoHlA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

First, query the server to get the SUPPORTED_ATTRS and OPEN_ARGUMENTS,
and determine whether delegated timestamps are supported. If they are,
request them, and test whether they are as expected.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 nfs4.1/server41tests/st_delegation.py | 42 +++++++++++++++++++++++++++++------
 1 file changed, 35 insertions(+), 7 deletions(-)

diff --git a/nfs4.1/server41tests/st_delegation.py b/nfs4.1/server41tests/st_delegation.py
index 2aa73ba7acd0bd857a4fd5206b8857f980176d73..fc374e693cb4b9a9adaaf5ff15a64a02573113b0 100644
--- a/nfs4.1/server41tests/st_delegation.py
+++ b/nfs4.1/server41tests/st_delegation.py
@@ -301,22 +301,44 @@ def _testCbGetattr(t, env, change=0, size=0):
     sess1 = env.c1.new_client_session(b"%s_1" % env.testname(t))
     sess1.client.cb_post_hook(OP_CB_GETATTR, getattr_post_hook)
 
-    fh, deleg = __create_file_with_deleg(sess1, env.testname(t),
-                                                OPEN4_SHARE_ACCESS_READ  |
-                                                OPEN4_SHARE_ACCESS_WRITE |
-                                                OPEN4_SHARE_ACCESS_WANT_WRITE_DELEG)
+    res = sess1.compound([op.putrootfh(),
+                          op.getattr(nfs4lib.list2bitmap([FATTR4_SUPPORTED_ATTRS,
+                                                          FATTR4_OPEN_ARGUMENTS]))])
+    check(res)
+    caps = res.resarray[-1].obj_attributes
+
+    openmask = (OPEN4_SHARE_ACCESS_READ  |
+                OPEN4_SHARE_ACCESS_WRITE |
+                OPEN4_SHARE_ACCESS_WANT_WRITE_DELEG)
+
+    if caps[FATTR4_SUPPORTED_ATTRS] & FATTR4_OPEN_ARGUMENTS:
+        if caps[FATTR4_OPEN_ARGUMENTS].oa_share_access_want & OPEN_ARGS_SHARE_ACCESS_WANT_DELEG_TIMESTAMPS:
+            openmask |= 1<<OPEN_ARGS_SHARE_ACCESS_WANT_DELEG_TIMESTAMPS
+
+    fh, deleg = __create_file_with_deleg(sess1, env.testname(t), openmask)
     print("__create_file_with_deleg: ", fh, deleg)
-    attrs1 = do_getattrdict(sess1, fh, [FATTR4_CHANGE, FATTR4_SIZE])
-    cbattrs = dict(attrs1)
+    attrs1 = do_getattrdict(sess1, fh, [FATTR4_CHANGE, FATTR4_SIZE,
+                                        FATTR4_TIME_ACCESS, FATTR4_TIME_MODIFY])
+
+    cbattrs[FATTR4_CHANGE] = attrs1[FATTR4_CHANGE]
+    cbattrs[FATTR4_SIZE] = attrs1[FATTR4_SIZE]
 
     if change != 0:
         cbattrs[FATTR4_CHANGE] += 1
         if size > 0:
             cbattrs[FATTR4_SIZE] = size
 
+    if openmask & 1<<OPEN_ARGS_SHARE_ACCESS_WANT_DELEG_TIMESTAMPS:
+        cbattrs[FATTR4_TIME_DELEG_ACCESS] = attrs1[FATTR4_TIME_ACCESS]
+        cbattrs[FATTR4_TIME_DELEG_MODIFY] = attrs1[FATTR4_TIME_MODIFY]
+        if change != 0:
+            cbattrs[FATTR4_TIME_DELEG_ACCESS].seconds += 1
+            cbattrs[FATTR4_TIME_DELEG_MODIFY].seconds += 1
+
     # create a new client session and do a GETATTR
     sess2 = env.c1.new_client_session(b"%s_2" % env.testname(t))
-    slot = sess2.compound_async([op.putfh(fh), op.getattr(1<<FATTR4_CHANGE | 1<<FATTR4_SIZE)])
+    slot = sess2.compound_async([op.putfh(fh), op.getattr(1<<FATTR4_CHANGE | 1<<FATTR4_SIZE |
+                                                          1<<FATTR4_TIME_ACCESS | 1<<FATTR4_TIME_MODIFY)])
 
     # wait for the CB_GETATTR
     completed = cb.wait(2)
@@ -343,6 +365,9 @@ def testCbGetattrNoChange(t, env):
         fail("Bad size: %u != %u" % (attrs1[FATTR4_SIZE], attrs2[FATTR4_SIZE]))
     if attrs1[FATTR4_CHANGE] != attrs2[FATTR4_CHANGE]:
         fail("Bad change attribute: %u != %u" % (attrs1[FATTR4_CHANGE], attrs2[FATTR4_CHANGE]))
+    if FATTR4_TIME_DELEG_MODIFY in attrs2:
+        if attrs1[FATTR4_TIME_MODIFY] != attrs2[FATTR4_TIME_DELEG_MODIFY]:
+            fail("Bad modify time: ", attrs1[FATTR4_TIME_MODIFY], " != ", attrs2[FATTR4_TIME_DELEG_MODIFY])
 
 def testCbGetattrWithChange(t, env):
     """Test CB_GETATTR with simulated changes to file
@@ -359,3 +384,6 @@ def testCbGetattrWithChange(t, env):
         fail("Bad size: %u != 5" % attrs2[FATTR4_SIZE])
     if attrs1[FATTR4_CHANGE] == attrs2[FATTR4_CHANGE]:
         fail("Bad change attribute: %u == %u" % (attrs1[FATTR4_CHANGE], attrs2[FATTR4_CHANGE]))
+    if FATTR4_TIME_DELEG_MODIFY in attrs2:
+        if attrs1[FATTR4_TIME_MODIFY] == attrs2[FATTR4_TIME_DELEG_MODIFY]:
+            fail("Bad modify time: ", attrs1[FATTR4_TIME_MODIFY], " == ", attrs2[FATTR4_TIME_DELEG_MODIFY])

-- 
2.47.0


