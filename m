Return-Path: <linux-nfs+bounces-14804-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6709ABACB61
	for <lists+linux-nfs@lfdr.de>; Tue, 30 Sep 2025 13:38:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD07D19270FE
	for <lists+linux-nfs@lfdr.de>; Tue, 30 Sep 2025 11:38:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37E2034BA29;
	Tue, 30 Sep 2025 11:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X8NdrA+k"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 122AF2609D0
	for <linux-nfs@vger.kernel.org>; Tue, 30 Sep 2025 11:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759232267; cv=none; b=lCcojqN5YjC43V4Siqfz5DdhNCE2Qs0X7NOYo5JeSwPqCAdi5v/M0RdA3tquqPWa0F9lW8BH88FbrScMt06mKlggQUIJHzUeM8hRD2pMw3Isp8Dw4bO8jQBFl+CJEZdIQFxVQVOv1cLNxbF/jI+iesHYDul/fVDdK0llohHmbSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759232267; c=relaxed/simple;
	bh=rs4C17R7AR4vjwl2Bkqb3S0JSqjRenTuhcEIuDMCcpw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LTkshp8aexi39IQjA/n85vvbn7aX95NXdP1uJM0X8BBYdKXJzoEz6AJXQVg6MP2gq8j/7QvsCh+9h3OET75eeK1ceE8Xvlh1cCUyJtb8B40o48aihGXziRO+e03UiSqGNHh2I/jtZHnUwgtJqqmcYLYCItdwfyhLoEf3cH7VHN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X8NdrA+k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75C58C113D0;
	Tue, 30 Sep 2025 11:37:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759232266;
	bh=rs4C17R7AR4vjwl2Bkqb3S0JSqjRenTuhcEIuDMCcpw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=X8NdrA+kEkqXwvp0RjV4C3WfAudqSSJN6j01Hx22jN7g+pwWOItDavOK/un0fdu0e
	 mlHeq1CkxaqEJmmHthqYrzTm9Xzej7Xg6QzduxdQRTXvKAINc5vl5Q3cbIaj0V+qJn
	 KSqUiTOLv+BpaSTAo6V7M+Jt7Sjaa7c3nzCy6p1xRimXqcUvTVrxPj+gM1WwFzUOmE
	 11pNtMJX1JdKdIuW5PSvQkxuMi+I6bazBXJBDrMuMZ00sI3ZGHcNYBMOEJVu2HZ1JK
	 faULTCPCwqL1SkoTCeyRn5QAR7Mpxp5kt2EinE+7rJ2KCLYLyCjVZMk/ATIDWiqIaR
	 ghRrYnWbKup1A==
From: Jeff Layton <jlayton@kernel.org>
Date: Tue, 30 Sep 2025 07:37:39 -0400
Subject: [PATCH pynfs 5/7] server41tests: add a test for removal from dir
 with dir delegation
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250930-dir-deleg-v1-5-7057260cd0c6@kernel.org>
References: <20250930-dir-deleg-v1-0-7057260cd0c6@kernel.org>
In-Reply-To: <20250930-dir-deleg-v1-0-7057260cd0c6@kernel.org>
To: Calum Mackay <calum.mackay@oracle.com>
Cc: linux-nfs@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4192; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=rs4C17R7AR4vjwl2Bkqb3S0JSqjRenTuhcEIuDMCcpw=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBo28EH36L7IC7Ev0TDG+YF3KUNAJU7rx0Sqz39q
 enl4OZusJiJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaNvBBwAKCRAADmhBGVaC
 FenaD/41xYmsNED4Eu+DrMAbMYBo7kfqju1c5h+RMg7dMXmGcFG5kQLRxSW5H5f65XtiIU9ip1/
 ajXN22LZZ/ZgQwELy1BeAkNH8oxJXVcBuRKHByItxGXxDC/MvF9J9IQxw3iimNeKjVt5h5S3t/Z
 BgYkaDkyX27uOIrcGuuVl6AVBCo672aBkBScFRzdse92N2tnMUfQpW7HB/7FKgYZgMRGJwGfxJr
 9n8pjIEb7+D9+m94MmXJTVqaP7BFyPFnSvBZ5eLObXks3fZSqjDaDSnIMQIYqYH/F7IZ2ghywtz
 mn9NkfRV1rGWhxnPEQoVJkdjgkm2u42z+WlrWP1iZPxj+7hCYNvKKlDBnNWSDLIQw/LlZiLpE1Z
 eEdaXUAedtRbpmQ25iwnanodxDcw8gX1vSO4Dn+xLmbzHGFsD7z5hAAgyTDC/C1MMKjmoogYd0L
 2NYqHwXpHMU5Z4A4AYr0w+5dwqzFwZPlqyJaJqwMwUDg4sOToUF13cfh8dYtCuBEvaK9Aja4f7D
 QyBtKPqwFQOSEp0CTa14BG0wqT0WZyNhFBmYHsdYiv8dV4GRKmX+bhrYnWwlkNOa8UcI1e6XaPC
 mQxC9o/dYbP6qkQgR4eLOpioXYg1QsZUtr4j1iXkmCBAfTq66B85ypuKxmsgpYx/hWaZPEbp7Hu
 Aih6lSlAfrkQ5cg==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

...and actually request attributes in the GET_DIR_DELEGATION request.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 nfs4.1/server41tests/st_dir_deleg.py | 53 ++++++++++++++++++++++++++++++++++--
 1 file changed, 51 insertions(+), 2 deletions(-)

diff --git a/nfs4.1/server41tests/st_dir_deleg.py b/nfs4.1/server41tests/st_dir_deleg.py
index ccf7eca8bcbe3401aaa8561e10db02d0836ca493..f44a8f10738b1e6d5868f4496ba4bda1c5be810d 100644
--- a/nfs4.1/server41tests/st_dir_deleg.py
+++ b/nfs4.1/server41tests/st_dir_deleg.py
@@ -43,8 +43,26 @@ def _getDirDeleg(t, env, notify_mask, cb):
     ops = [ op.putfh(fh), op.get_dir_delegation(False,
                                                 nfs4lib.list2bitmap(notify_mask),
                                                 zerotime, zerotime,
-                                                nfs4lib.list2bitmap([]),
-                                                nfs4lib.list2bitmap([]))]
+                                                nfs4lib.list2bitmap([FATTR4_TYPE,
+                                                                     FATTR4_CHANGE,
+                                                                     FATTR4_SIZE,
+                                                                     FATTR4_FILEID,
+                                                                     FATTR4_FILEHANDLE,
+                                                                     FATTR4_MODE,
+                                                                     FATTR4_NUMLINKS,
+                                                                     FATTR4_RAWDEV,
+                                                                     FATTR4_SPACE_USED,
+                                                                     FATTR4_TIME_ACCESS,
+                                                                     FATTR4_TIME_METADATA,
+                                                                     FATTR4_TIME_MODIFY,
+                                                                     FATTR4_TIME_CREATE]),
+                                                nfs4lib.list2bitmap([FATTR4_CHANGE,
+                                                                     FATTR4_SIZE,
+                                                                     FATTR4_NUMLINKS,
+                                                                     FATTR4_SPACE_USED,
+                                                                     FATTR4_TIME_ACCESS,
+                                                                     FATTR4_TIME_METADATA,
+                                                                     FATTR4_TIME_MODIFY]))]
     res = sess1.compound(ops)
     check(res)
     deleg = res.resarray[-1].gddrnf_resok4.gddr_stateid
@@ -101,3 +119,34 @@ def testDirDelegDuplicate(t, env):
     ops = [ op.putfh(fh), op.delegreturn(deleg) ]
     res = sess1.compound(ops)
     check(res)
+
+def testDirDelegRemove(t, env):
+    """Create a dir_deleg that accepts notification of REMOVE events
+
+    FLAGS: dirdeleg all
+    CODE: DIRDELEG3
+    """
+    c = env.c1
+    cb = threading.Event()
+    sess1, fh, deleg = _getDirDeleg(t, env, [NOTIFY4_CHANGE_DIR_ATTRS, NOTIFY4_REMOVE_ENTRY], cb)
+
+    claim = open_claim4(CLAIM_NULL, env.testname(t))
+    owner = open_owner4(0, b"owner")
+    how = openflag4(OPEN4_CREATE, createhow4(GUARDED4, {FATTR4_SIZE:0}))
+    open_op = [ op.putfh(fh), op.open(0,
+                                      OPEN4_SHARE_ACCESS_WRITE | OPEN4_SHARE_ACCESS_WANT_NO_DELEG,
+                                      OPEN4_SHARE_DENY_NONE, owner, how, claim) ]
+    res = sess1.compound(open_op)
+    check(res)
+
+    sess2 = c.new_client_session(b"%s_2" % env.testname(t))
+    remove_op = [ op.putfh(fh), op.remove(env.testname(t)) ]
+    res = sess2.compound(remove_op)
+    check(res)
+
+    completed = cb.wait(5)
+    ops = [ op.putfh(fh), op.delegreturn(deleg) ]
+    res = sess1.compound(ops)
+
+    if (not completed or not cb.got_notify):
+        fail("Didn't receive a CB_NOTIFY from the server!")

-- 
2.51.0


