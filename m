Return-Path: <linux-nfs+bounces-14803-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A976BACB60
	for <lists+linux-nfs@lfdr.de>; Tue, 30 Sep 2025 13:38:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7C8307AB142
	for <lists+linux-nfs@lfdr.de>; Tue, 30 Sep 2025 11:36:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BEA3261B9A;
	Tue, 30 Sep 2025 11:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BqdfG3PE"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67B9E2609D0
	for <linux-nfs@vger.kernel.org>; Tue, 30 Sep 2025 11:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759232266; cv=none; b=AaKLExPJTSTvRuJP1qR6EPRtGSRNxGhO2TX5Ao3bVcMC9l39fQJ9nKbJ5RVhI/ccQwKhIiFa5r8cAI9SwJYAIruUOUHAVysAuat3JAu8yy6TQDTXSQPYUWzmo7wioqskKeBiDZuUEKv+V6fdgL21kohtg+96+oZAPCCs6wjwqvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759232266; c=relaxed/simple;
	bh=82xW1aKl877Ig5JNydd6LVBlskZlU/g/RlhYzhEXPpI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PgWTFawtnm3oFjAsj1bOUmpNfyXAgjX39XQ9v35GCoXqTBtvcGUVL7CvjS+xMhEbLy7d5nvl84T/wB8dhSqbB0k22WNdXhCVyz87eKumL/TrsICJsGVdl4uF/vYZfeoxw+6gn1ZWqEg0JhNnF5KkjK3fZM9ivxZtCiFJGTE+6Rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BqdfG3PE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0316DC4CEF0;
	Tue, 30 Sep 2025 11:37:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759232266;
	bh=82xW1aKl877Ig5JNydd6LVBlskZlU/g/RlhYzhEXPpI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=BqdfG3PE9LBasj+Q+oOVbX/UsKrkRNaTVF+YCVDNeUpXvs55Mf2qcHbmWexi88tVJ
	 b37SX7a9VcL4vwLdfw3hT9CFbGbrF5eY8ZNGI2bc8P8i+kX3z5kHvCeb8SVXXuqpF5
	 Gvb8962O9pjzusmWekC5uYu0/30uIFAn8bM3lk/rOWQSaPXBGilfDbEbsbrY4ylRJ8
	 z+2h4xknG9qZJmZQ74hmgOn/j/khIGoRyn2u4DWOBwxcMMzRV1yHmP6YAlWhuQrDvF
	 h90GBnFO6/B/beITnHNoBbrkt4CTk8KTBo5alXxCKG3cW1o7dmlJra1DzoNKgOCAdq
	 2L1tPuLcQ4nwQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Tue, 30 Sep 2025 07:37:38 -0400
Subject: [PATCH pynfs 4/7] server41tests: add a test for duplicate
 GET_DIR_DELEGATION requests
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250930-dir-deleg-v1-4-7057260cd0c6@kernel.org>
References: <20250930-dir-deleg-v1-0-7057260cd0c6@kernel.org>
In-Reply-To: <20250930-dir-deleg-v1-0-7057260cd0c6@kernel.org>
To: Calum Mackay <calum.mackay@oracle.com>
Cc: linux-nfs@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1620; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=82xW1aKl877Ig5JNydd6LVBlskZlU/g/RlhYzhEXPpI=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBo28EHQXV/pgF1R/sKs+GULBorlzdSKmjmMhUs4
 l54QcEagZqJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaNvBBwAKCRAADmhBGVaC
 Fa1kD/4gXc1iYVznKO6gowhN4XhRMNceoqCJxE7wqfxcMOE/y+Ivr9VgRX6yF72GyUFfnd8JngO
 Hz9sV8T6Y+/ummsF5ATnGN9l9mG3wnAku5/Ymcunm0KPS36p9NWzYyhvkswqG/9+Usy8m6iLtV4
 476hGW999/jHHVsEHP3x4WhC2PhlPeTXF6e0K5BMmKMjRTyQSKGYUYRv9QkuSm86UtUopEx2slq
 CYA0rsROjUuMOij10G6ldxLzZ5gXqKtxKs/J380v3XMqkXaznCDwnyRH1sGALVtlrZpMhLFvRih
 KASAA+8Nb2az4qwm2mrnm7ekag9bJOs4BekO2R85rH1PMUklrLLLTfTHe9GeGGEZ0w4psBtF3xH
 JViMhZ6DcLpej54CHxPTJ3YtA5+WBw7NebMqAnoW/NTmosC58tm6LXs+cxe1pSIy0OwmhtqxvO3
 duINvMtCv1u6BXYKMprKhFxNhch5fupTNGFIzB9yZjfawBIi+aPFKFD0ZNWcgKA/7A+uN9HshAl
 xEN6/CwmnJrZqrQ+D6t5ynf/zHyZMkELUtbmhjSXIhIlzY4MQnR3+u8YQiL7PN6rcGPqRX2xWEf
 FDa85JglhQxKlszXe3SZ8+bXNa1tA9n0vwBDab3SwwHxkK3nAnyM0mA+Rp0kkyy+y4/WYwlYLsu
 zdSnoTWmrdu+iaw==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 nfs4.1/server41tests/st_dir_deleg.py | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/nfs4.1/server41tests/st_dir_deleg.py b/nfs4.1/server41tests/st_dir_deleg.py
index d63a16e06edd4515033ad81986cf1e84871ee7ad..ccf7eca8bcbe3401aaa8561e10db02d0836ca493 100644
--- a/nfs4.1/server41tests/st_dir_deleg.py
+++ b/nfs4.1/server41tests/st_dir_deleg.py
@@ -75,3 +75,29 @@ def testDirDelegSimple(t, env):
     ops = [ op.putfh(fh), op.delegreturn(deleg) ]
     res = sess1.compound(ops)
     check(res)
+
+def testDirDelegDuplicate(t, env):
+    """Test that server returns GDD4_UNAVAIL on duplicate GDD4 request
+
+    FLAGS: dirdeleg all
+    CODE: DIRDELEG2
+    """
+    c = env.c1
+    recall = threading.Event()
+    sess1, fh, deleg = _getDirDeleg(t, env, [], recall)
+
+    # get a dir deleg with no notifications
+    ops = [ op.putfh(fh), op.get_dir_delegation(False,
+                                                nfs4lib.list2bitmap([]),
+                                                zerotime, zerotime,
+                                                nfs4lib.list2bitmap([]),
+                                                nfs4lib.list2bitmap([]))]
+    res = sess1.compound(ops)
+    check(res)
+    nfstatus = res.resarray[-1].gddr_res_non_fatal4.gddrnf_status
+    if (nfstatus != GDD4_UNAVAIL):
+        fail("Server replied to duplicate request with %d" % nfstatus)
+
+    ops = [ op.putfh(fh), op.delegreturn(deleg) ]
+    res = sess1.compound(ops)
+    check(res)

-- 
2.51.0


