Return-Path: <linux-nfs+bounces-20716-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YEivEUoq1Wli1wcAu9opvQ
	(envelope-from <linux-nfs+bounces-20716-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 07 Apr 2026 18:01:14 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 65D533B1722
	for <lists+linux-nfs@lfdr.de>; Tue, 07 Apr 2026 18:01:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 47A46307D0A0
	for <lists+linux-nfs@lfdr.de>; Tue,  7 Apr 2026 15:54:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1BB23C7E15;
	Tue,  7 Apr 2026 15:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b="OIT+/iZa"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtpcmd02101.aruba.it (smtpcmd02101.aruba.it [62.149.158.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B740B3C7E13
	for <linux-nfs@vger.kernel.org>; Tue,  7 Apr 2026 15:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.149.158.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775577247; cv=none; b=Dfk5nucpc1t+5GRPhuu3P1ANAp0v4jkG+TYLXZUOQj9F+k6liuiJuTeeMAujh/mMx2OWftvuYAF/Apsn2CvbM1+y33DZZNu9AR9nJw+j3CFUULyJNfshBRqVsDBYr9q5Rg0Czw1A5uWDnmlBWq/fql7pklt4PXOAauzQUvZ4eq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775577247; c=relaxed/simple;
	bh=SMveeEyuhmNWz7ZZpYlQ4cRSEs7uBdXbB0F28W6vFMA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eMB84dfvBxJicJ9EDRylUDWqkJPJA67vpViutwSSy3h/l7qfiyvF/nB5FAaXUUkxsRQf6+qhOXrzmGBkUyh2E/mRaveSfUlv8AKGYFz2W5KjJ5Luc6RSo5Po56U9I79GoixGvEDWAqojdPYpjzZJa4I5cNHWSzQdWJMioxK5TQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=benettiengineering.com; spf=pass smtp.mailfrom=benettiengineering.com; dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b=OIT+/iZa; arc=none smtp.client-ip=62.149.158.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=benettiengineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=benettiengineering.com
Received: from localhost.localdomain ([84.33.84.190])
	by Aruba SMTP with ESMTPSA
	id A8hSwU1DaxFXLA8hSwnxEO; Tue, 07 Apr 2026 17:50:46 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
	t=1775577046; bh=SMveeEyuhmNWz7ZZpYlQ4cRSEs7uBdXbB0F28W6vFMA=;
	h=From:To:Subject:Date:MIME-Version;
	b=OIT+/iZaJli3SxSEs1Rz7KfMHR+oUmx1jUo/VaXL+jNIqzdpksEm/LNu1UEeakcsi
	 3T21LI1UnvBJLk2X0Zub82umKjspWhI99AUZ11ZdO5FRk1l1igLdB927QQ5gZTY83j
	 9xE6YsxqIi4l4tkJPBsK698EAF2wDseid7I8wcAakYpoNofrpteh2xrgPia0FM/WWF
	 Kt0Hd0SEF5C+3l4iLCGy49C+YU3gcUd87eVtYlG1xouULua0NBcpIsF4UIgZsEE9w4
	 jYNmW9q09ZlDwEfwouqWsRs/xTwQ2IF7qLzEFgtGrZ15n7XJZjmgRPqQdcICGj0vbj
	 ZC80nHYZ5tMGg==
From: Giulio Benetti <giulio.benetti@benettiengineering.com>
To: linux-nfs@vger.kernel.org
Cc: Giulio Benetti <giulio.benetti@benettiengineering.com>
Subject: [PATCH] Introduce compat.h file to deal with old Linux api and fix build failure due to missing NETLINK_EXT_ACK
Date: Tue,  7 Apr 2026 17:50:45 +0200
Message-ID: <20260407155045.1176993-1-giulio.benetti@benettiengineering.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfN4d1BUqjjXbQ8aqT40HXPfZC6HNFLwumeW4sLvk0LJ9r2zaCdPz95eduyJSmUkb6jI7FgtEQyAaNHvd10JlfiBZJ6VbZN+03V7VBCJ3UTg2/SHIcOAm
 QfahcZ1xcxRbzapytKmK2keFC7IcTkYkmU5gmjglCiDBR4K4RfB60NOe46m9e6lJivb8OrEx8ZbGlW2fn+9LY/VYYz2Jn0q2qu5jmFqyBiPlp5ZvEvsdmYkc
 E+hJFwW2f20nnGoANRmJ+Q1KE2m49F2mebZ0Yyh8nNJn6FV5QVO0wFkpqjuf+gjF
X-Spamd-Result: default: False [-0.06 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[aruba.it:s=a1];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[benettiengineering.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-20716-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,aruba.it:dkim,benettiengineering.com:email,benettiengineering.com:mid]
X-Rspamd-Queue-Id: 65D533B1722
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Check if NETLINK_EXT_ACK exists, otherwise define it to fix build
failure.

Signed-off-by: Giulio Benetti <giulio.benetti@benettiengineering.com>
---
 support/export/cache.c       |  2 ++
 support/export/cache_flush.c |  2 ++
 support/include/compat.h     | 10 ++++++++++
 utils/nfsdctl/nfsdctl.c      |  1 +
 4 files changed, 15 insertions(+)
 create mode 100644 support/include/compat.h

diff --git a/support/export/cache.c b/support/export/cache.c
index 2f128d7d..ca75a1ce 100644
--- a/support/export/cache.c
+++ b/support/export/cache.c
@@ -58,6 +58,8 @@
 #include "blkid/blkid.h"
 #endif
 
+#include "compat.h"
+
 enum nfsd_fsid {
 	FSID_DEV = 0,
 	FSID_NUM,
diff --git a/support/export/cache_flush.c b/support/export/cache_flush.c
index ed7b964f..2a24dec7 100644
--- a/support/export/cache_flush.c
+++ b/support/export/cache_flush.c
@@ -38,6 +38,8 @@ extern int no_netlink;
 #include "sunrpc_netlink.h"
 #endif
 
+#include "compat.h"
+
 static int nl_send_flush(struct nl_sock *sock, int family, int cmd)
 {
 	struct nl_msg *msg;
diff --git a/support/include/compat.h b/support/include/compat.h
new file mode 100644
index 00000000..83229b65
--- /dev/null
+++ b/support/include/compat.h
@@ -0,0 +1,10 @@
+#ifndef COMPAT_H
+#define COMPAT_H
+
+#include <linux/netlink.h>
+
+#ifndef NETLINK_EXT_ACK
+#define NETLINK_EXT_ACK 11
+#endif
+
+#endif /* COMPAT_H */
diff --git a/utils/nfsdctl/nfsdctl.c b/utils/nfsdctl/nfsdctl.c
index 016dd2eb..fb326640 100644
--- a/utils/nfsdctl/nfsdctl.c
+++ b/utils/nfsdctl/nfsdctl.c
@@ -45,6 +45,7 @@
 
 #include "nfslib.h"
 #include "nfsdctl.h"
+#include "compat.h"
 #include "conffile.h"
 #include "xlog.h"
 
-- 
2.47.3


