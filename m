Return-Path: <linux-nfs+bounces-15039-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AB4FBC2B19
	for <lists+linux-nfs@lfdr.de>; Tue, 07 Oct 2025 22:48:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id BC7F2346E81
	for <lists+linux-nfs@lfdr.de>; Tue,  7 Oct 2025 20:48:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99BB223D2A3;
	Tue,  7 Oct 2025 20:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bJESUY5k"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7599B23C513
	for <linux-nfs@vger.kernel.org>; Tue,  7 Oct 2025 20:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759870089; cv=none; b=HlAOeGqWEen2vz7iIHFImhVXGSQ49Z1iMohc/lE458G8pvld75fDS1tS9oDT+0oPNIbugQByoAgpw2T725beyeMnxomza0UIWG35EhURaVyWJyYOR4K0yvmuzgKEI5S7miCMhboXCh3Fh8wdYQf7eQIkcKJAc0F8NlgxC0MWooE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759870089; c=relaxed/simple;
	bh=r2H8M0SLPj7cNqxx+dIG3n5h/VX85k2rw3KaP6HpcT8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Iok7TDqQGSj4PUJq5mlZCQ1DyHiWDf72nAW5ls1sJ37sE5p3ocfJh3+SWpuGIz/ujMackJlbw8+IiLNHn5uu5cdrWE7HjQv+96WMmlnCoY73NDF1HCiUN4TFopEebIKyGGu3DIAI8sEWVQTRNFdkKh86jMZSqEl+8bj+7iAFOxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bJESUY5k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63FAFC4CEF1;
	Tue,  7 Oct 2025 20:48:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759870088;
	bh=r2H8M0SLPj7cNqxx+dIG3n5h/VX85k2rw3KaP6HpcT8=;
	h=From:To:Cc:Subject:Date:From;
	b=bJESUY5kzXwGteix2H5d5riK5IIs7xZGuEHeytyKjrHLgWn8jS5pzNovbEJH3QdfY
	 4xA32oYiWUnIAd9AoBdclQg9Moao6CuMb0kBcnQSBc08O/iYN0RkNJseqny1V+db44
	 i9lbFnAmhBr569hj8r7SKLnRYzrT2obkXiV1+/JC09+Yo1nRqGIrVCTJPXr4C8sSCu
	 IR3SoBon6yqcfwrYz8XqVf9IB2QbUidibOwF96fsi/ajGnaAyG5rOpmqJ1kL6jszEL
	 Xtb1NjHKN6JEYiw3ecEXGXKSiJuq77zsXfA7IMVIAHoPL853W7fwYy18zN5DbVnd57
	 ko7rmGdKsjcCQ==
From: Chuck Lever <cel@kernel.org>
To: Calum Mackay <calum.mackay@oracle.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH] SEQ_FALSE_RETRY is allowed for a solo SEQUENCE replay
Date: Tue,  7 Oct 2025 16:48:06 -0400
Message-ID: <20251007204806.15560-1-cel@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

RFC 8881 Section 2.10.6.1.3 appears to permit servers to reply
with NFS4ERR_SEQ_FALSE_RETRY for a replayed solo SEQUENCE. Update
the test to allow it to pass in that case.

See also commit d4604ee1fdf1 ("SEQ9f: make sure replied SEQUENCE is
really the same").

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 nfs4.1/server41tests/st_sequence.py | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/nfs4.1/server41tests/st_sequence.py b/nfs4.1/server41tests/st_sequence.py
index 9be1096b9e8e..759fcd2b8d78 100644
--- a/nfs4.1/server41tests/st_sequence.py
+++ b/nfs4.1/server41tests/st_sequence.py
@@ -209,10 +209,11 @@ def testReplayCache006(t, env):
     res1 = sess.compound([], cache_this=True)
     check(res1)
     res2 = sess.compound([], cache_this=True, seq_delta=0)
-    check(res2)
+    check(res2, [NFS4_OK, NFS4ERR_SEQ_FALSE_RETRY])
     res1.tag = res2.tag = b""
-    if not nfs4lib.test_equal(res1, res2):
-        fail("Replay results not equal")
+    if res2.status == NFS4_OK:
+        if not nfs4lib.test_equal(res1, res2):
+            fail("Replay results not equal")
 
 def testReplayCache007(t, env):
     """Send two successful non-idempotent compounds with same seqid and False cache_this
-- 
2.51.0


