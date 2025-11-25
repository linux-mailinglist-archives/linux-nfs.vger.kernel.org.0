Return-Path: <linux-nfs+bounces-16716-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13DF2C86DA4
	for <lists+linux-nfs@lfdr.de>; Tue, 25 Nov 2025 20:49:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59EA63B3DFE
	for <lists+linux-nfs@lfdr.de>; Tue, 25 Nov 2025 19:49:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 393362528FD;
	Tue, 25 Nov 2025 19:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DlT0C2y9"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15907332ED3
	for <linux-nfs@vger.kernel.org>; Tue, 25 Nov 2025 19:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764100181; cv=none; b=poBNtBJwyjyAXdpexVxiZW46DBCoHnyt/U+JLZ8Gb3ZAOoK61+tqBUMAJtyuEOVEfM0yLoZ6iacUo+kVaYl9CayHJGNW5IbblWfbjAVjk+fWVycUiI3zRrbfYqh08g9PR9ng6YnlRdKPQjCm/QfqokLGTs6dTKXit7hcvN0R5ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764100181; c=relaxed/simple;
	bh=nPKmF6QGr6o6RUbbxJQ/jZPOSlCz35S/2O645qTAnc8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BHdbrieJfK1hJ4br0JCRYzK/oPF0v4rBg9p1iWocRiKEsWfnSqtcSKKJ9+hTskAXlQtqK53FJ883IIBtDsjeXgQngBdH/x/HHnwHtW0gy6AVBcwdHAcmsCrBicw5AUB57dYkPWPmimuNTCVpIdyqlZRyeE/WGcGQyViYoa7vReI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DlT0C2y9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E8D9C116B1;
	Tue, 25 Nov 2025 19:49:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764100180;
	bh=nPKmF6QGr6o6RUbbxJQ/jZPOSlCz35S/2O645qTAnc8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DlT0C2y9+ss8oqmq9Xstbi+MBro+fEks99BCQGNpPCotFifY3gNIKnAlvOqISdEiw
	 VtGlfoSG4x3vOwkinE/E6XCmAtOp+CAPIWb+U6kBZJmpU6SJKI5u/xvoocWYZglDMT
	 PF8q+yivUS+fqHWhAVuzqXKfbdnbpGRwynw5J7DMIsSOX+eXz5KkcMhk2W+JZZjeYl
	 rbi1irLhJRa6ZcxdL8qmpwxKssItKQwwjWbN8bcWFQECYbuzs/ocHa27l4AH45A+zA
	 BPXJX0QGr7EksDdx4vlojspv0Hr01/6FrOsTcqzkG5Sgeh1gwcd++LGoXoQ4zKAszi
	 DSgsjrQY5ipzg==
From: Chuck Lever <cel@kernel.org>
To: <linux-nfs@vger.kernel.org>
Cc: Calum Mackay <calum.mackay@oracle.com>,
	aurelien.couderc2002@gmail.com,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v2 1/9] Add helper to report unsupported protocol features
Date: Tue, 25 Nov 2025 14:49:26 -0500
Message-ID: <20251125194936.770792-2-cel@kernel.org>
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

In some cases, specifications permit a server to not implement
a feature (or part of a feature) being tested. That should not
count as a test failure. The helper added here can be used to
indicate that the test did not pass or fail, but that the server
under test does not support the tested feature.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 nfs4.1/server41tests/environment.py | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/nfs4.1/server41tests/environment.py b/nfs4.1/server41tests/environment.py
index 48284e029634..2914cd7ddb1e 100644
--- a/nfs4.1/server41tests/environment.py
+++ b/nfs4.1/server41tests/environment.py
@@ -277,6 +277,9 @@ debug_fail = False
 def fail(msg):
     raise testmod.FailureException(msg)
 
+def unsupported(msg):
+    raise testmod.UnsupportedException(msg)
+
 def check(res, stat=NFS4_OK, msg=None, warnlist=[]):
 
     if type(stat) is str:
-- 
2.51.1


