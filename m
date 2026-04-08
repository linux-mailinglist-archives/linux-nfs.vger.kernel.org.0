Return-Path: <linux-nfs+bounces-20765-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KP98AcqS1mmiGQgAu9opvQ
	(envelope-from <linux-nfs+bounces-20765-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 08 Apr 2026 19:39:22 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 616B53BFB09
	for <lists+linux-nfs@lfdr.de>; Wed, 08 Apr 2026 19:39:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7371B3016905
	for <lists+linux-nfs@lfdr.de>; Wed,  8 Apr 2026 17:38:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0112D3537FC;
	Wed,  8 Apr 2026 17:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b="NnE9w3lS"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtpcmd0756.aruba.it (smtpcmd0756.aruba.it [62.149.156.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECAEB3446CE
	for <linux-nfs@vger.kernel.org>; Wed,  8 Apr 2026 17:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.149.156.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775669927; cv=none; b=Nh97tSZJ4stifXLUVqytx9gZDu0AvnCkgOK5erprFrHnHCg2D7Jf5uMt6Wbw/4QowtBL+TBVY2/tBRwbhJ6FuCDTTc66+CtQz7qB0Jdrq/ZcVHN+MfY9o1L5NKzTiArEZ8qf5XXpVgJrj9HDJTevuAQY5gKpa2LzEujZyb/eE44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775669927; c=relaxed/simple;
	bh=XqJttA/CVUCC3we680kokyd4tJBlBGCHpQX35evpxTU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PUHAZ05yn23Ij7OwVv04WexPaY9QPKFMLfRTEujDj90Vg+iHkguceOTI5U6kXytDKSZVLAuwoxK1s0lIArA7yrc659U1htBVBnV5DIz1+GbJqbXN1BA62qEYppLVvhe2UxvlK7/cxmtm7gksA26IjdeOTkKREXHkqoobkzIor8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=benettiengineering.com; spf=pass smtp.mailfrom=benettiengineering.com; dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b=NnE9w3lS; arc=none smtp.client-ip=62.149.156.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=benettiengineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=benettiengineering.com
Received: from localhost.localdomain ([84.33.84.190])
	by Aruba SMTP with ESMTPSA
	id AWoRwcrFktpTfAWoSwriPL; Wed, 08 Apr 2026 19:35:36 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
	t=1775669736; bh=XqJttA/CVUCC3we680kokyd4tJBlBGCHpQX35evpxTU=;
	h=From:To:Subject:Date:MIME-Version;
	b=NnE9w3lSqa7EyiTCE0PU46mD+WHZqM3cgdZ14+aORX57UrgjSj5BQQyFj+alXRMJZ
	 h53Fa1t3yN+YjrOqIq76TVvXShLil0EXXbWKGVTAwXFrZjdsfhZUv3GtASGJxz6IIf
	 5uYVI3iazho9kHIfuqAEoBJ3yQABwOGMjJ5LiOOeQh63Gvuh2zF0RtTUTR9FL4KKsw
	 dhxK4c5OynHRUiwFPPeVQA8LpFr6a+rY2A1vbkC9G9IpGG/2bRtdF41Nk4q+T2aZM4
	 gHoLvUU27E7aFsmiNYp1kj3+CRA6bHCpNrZzW7CdeyRPxF0lHU+RNB1IfJO2ZZVfI3
	 9iGlUoXlwlWmg==
From: Giulio Benetti <giulio.benetti@benettiengineering.com>
To: linux-nfs@vger.kernel.org
Cc: Giulio Benetti <giulio.benetti@benettiengineering.com>
Subject: [PATCH v2 3/3] support/backend_sqlite.c: fix getrandom() fallback
Date: Wed,  8 Apr 2026 19:35:35 +0200
Message-ID: <20260408173535.3992116-3-giulio.benetti@benettiengineering.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260408173535.3992116-1-giulio.benetti@benettiengineering.com>
References: <20260408173535.3992116-1-giulio.benetti@benettiengineering.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfAjrBg0BUJCKmUxMEiH5mL8ZtcXEoGQBwUT7zcvYngf+3AjddKmuTmX92KYDd5zc7tW5vKgoa+Svv8Inx5dhr2cIov/N92tYSM6AiLfysDRpj4/6TQEJ
 wgNDRlrcgb0R9JT2oDJpXuJMkcv9aziBEg3KT2/kWX6Fw7vzN8ReTxUWvD9iUxgItmP5RDUD86L9T2ybsqSPXGfa4XdcK+wwJMYw+dMqxuA+KY6bT8xLsW82
 /cIIeHyOPAz0qFDfyxmTnZyj77xSy9vVLy0ApoZfxkHiAPL+643mys/uVDeXfag/
X-Spamd-Result: default: False [-0.06 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[aruba.it:s=a1];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[benettiengineering.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-20765-lists,linux-nfs=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[giulio.benetti@benettiengineering.com,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[aruba.it:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[benettiengineering.com:email,benettiengineering.com:mid,aruba.it:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 616B53BFB09
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

In old Linux/Glibc versions __NR_getrandom is defined in <sys/random.h>
so let's add it to fix build failure.

Signed-off-by: Giulio Benetti <giulio.benetti@benettiengineering.com>
---
V1->V2
* added patch
---
 support/reexport/backend_sqlite.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/support/reexport/backend_sqlite.c b/support/reexport/backend_sqlite.c
index 0eb5ea37..a1e981e4 100644
--- a/support/reexport/backend_sqlite.c
+++ b/support/reexport/backend_sqlite.c
@@ -9,6 +9,8 @@
 #include <string.h>
 #include <unistd.h>
 
+#include <sys/syscall.h>
+
 #ifdef HAVE_GETRANDOM
 # include <sys/random.h>
 # if !defined(SYS_getrandom) && defined(__NR_getrandom)
-- 
2.47.3


