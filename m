Return-Path: <linux-nfs+bounces-10735-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 88172A6B9EB
	for <lists+linux-nfs@lfdr.de>; Fri, 21 Mar 2025 12:32:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0908F3AB224
	for <lists+linux-nfs@lfdr.de>; Fri, 21 Mar 2025 11:31:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 349A11F03FD;
	Fri, 21 Mar 2025 11:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rnfNpswd";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="94vHGfq8"
X-Original-To: linux-nfs@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FCC8155753
	for <linux-nfs@vger.kernel.org>; Fri, 21 Mar 2025 11:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742556719; cv=none; b=ogcDAPjazonDKKYYRn2xpuw5s0bkMOc6JKfawxJ8ds3ciodTAJMjvWrYgzWNFmp4IBtkVKgzi3fB6VDCgmkE8xblSZkbiqa0A3SQQEA5m1X1Tiglx6hV8SQCryUnHJYqw8MFFu+1CeNBPSz/+5c+IbFnyKcWXPEdm/Y5LtCfcqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742556719; c=relaxed/simple;
	bh=hyHI8u7xiNuyQPPfCOP0vQjJYDWYZHRIdZX3Y4vlZP4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=IN6i+3DEDMXWFoVX6bAee1K2KchXdH5YFbYhkI+HeYRDy7MQ3a5RE36GlHcE3D4EJuizdq0HREvCtSt9s9VXTbV/G12nfMvVGzQ5IeGYRSemLOYM3GIYUyWjU1EOdY43z81JjTlpOz8k8m+RgXW7b6VJ/IVFsC1R/IkrvkcuaPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rnfNpswd; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=94vHGfq8; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Alexander Kanavin <alex@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742556715;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=/UJmU3B2RJWZCTNraR2gQ2nrlvSwU2d55IbMSe5aijw=;
	b=rnfNpswd4Kca61c7q2mPot+sCOgWdqpZlCe9rgikMFzd+P2bjbx+JvB/xIrwpI8y5uJWpu
	VlgdKoO/VYsVfi7OW8/6Nk8oEa2c4ol2VA0JviJD5g0fSEjU5O2rRQyz0ZiYI6cHYKlr6z
	fVabZKB4cMMWM/JixovdSsBeJ/P99Vcei2rQMnUeIt9N8ahNWb8nGyDhtCwpdTOc1CXdsq
	1S78bFsfLlf+0na541LKAdniuut3+2gFQnWytT0c7yoOaqyUWGijcwc3ZjZPHXIbmMX3M3
	nRXOwA+8639JUl9nHSORLOdsqU9NZi4jpWbZFZXDWd1FCmKUoH5ulqGZt2CadA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742556715;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=/UJmU3B2RJWZCTNraR2gQ2nrlvSwU2d55IbMSe5aijw=;
	b=94vHGfq8OYhm1nNomzruakwpZEbFp7s2Euo7rOKwUyc0N/MMcLW9+5nt94zxydq+JV1EIA
	dAvsTk233Aha5GBA==
To: steved@redhat.com,
	linux-nfs@vger.kernel.org
Cc: Alexander Kanavin <alex@linutronix.de>
Subject: [nfs-utils][PATCH] support/nfs/xcommon.c: fix a formatting error with clang
Date: Fri, 21 Mar 2025 12:31:47 +0100
Message-Id: <20250321113147.3477702-1-alex@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Specifically, this happens:

| xcommon.c:101:24: error: format string is not a string literal [-Werror,-Wformat-nonliteral]
|   101 |      vfprintf (stderr, fmt2, args);
|       |                        ^~~~

A similar approach (print \n seprately) is already used elsewhere in
the same file.

Signed-off-by: Alexander Kanavin <alex@linutronix.de>
---
 support/nfs/xcommon.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/support/nfs/xcommon.c b/support/nfs/xcommon.c
index 3989f0bc..1d04dd11 100644
--- a/support/nfs/xcommon.c
+++ b/support/nfs/xcommon.c
@@ -94,13 +94,11 @@ xstrconcat4 (const char *s, const char *t, const char *u, const char *v) {
 void
 nfs_error (const char *fmt, ...) {
      va_list args;
-     char *fmt2;
 
-     fmt2 = xstrconcat2 (fmt, "\n");
      va_start (args, fmt);
-     vfprintf (stderr, fmt2, args);
+     vfprintf (stderr, fmt, args);
+     fprintf (stderr, "\n");
      va_end (args);
-     free (fmt2);
 }
 
 /* Make a canonical pathname from PATH.  Returns a freshly malloced string.
-- 
2.39.5


