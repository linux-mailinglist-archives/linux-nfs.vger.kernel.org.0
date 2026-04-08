Return-Path: <linux-nfs+bounces-20767-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CDGvA9iS1mmiGQgAu9opvQ
	(envelope-from <linux-nfs+bounces-20767-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 08 Apr 2026 19:39:36 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 565F23BFB27
	for <lists+linux-nfs@lfdr.de>; Wed, 08 Apr 2026 19:39:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 28B8B301AA5C
	for <lists+linux-nfs@lfdr.de>; Wed,  8 Apr 2026 17:38:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0F782F39C2;
	Wed,  8 Apr 2026 17:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b="hG/83mNo"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtpcmd0756.aruba.it (smtpcmd0756.aruba.it [62.149.156.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECB7F3D565F
	for <linux-nfs@vger.kernel.org>; Wed,  8 Apr 2026 17:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.149.156.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775669928; cv=none; b=GjMkMlGN+9/vwjD/ltd8/UAfNB6qXdG3dBDTqht1TAzPpOkyANFdLzL5XOJiTzdcSC6aK+QJruH9qoGW1zfa/c8VoLZX0V9NRdS5i78kkHBDTWFNeIXf331xR6Nzxaix2qhRVwxn/wCju003zG4L+0JGqHL99QioKW1UabXee/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775669928; c=relaxed/simple;
	bh=OE4bGBsC/6m3rPeRKR9QkW5yZGvz2Tmkuk6fyZjTb8k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XE2m1GDGTDGZ8AcEQ4OKkF0RMXovrqf2nB4VU55TV8tjA228rWrJ+A6LKxYXPFZCPSAt8GUAKuIuxd2gQk8sj+k/GlnNkyfMMF+U0M/t4T/IB1be+ZIPsvBO97yyG17cDDHC4l5KLlBQAWyLVMc1DtdrOjm0ayj1QkdbvZD4Fos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=benettiengineering.com; spf=pass smtp.mailfrom=benettiengineering.com; dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b=hG/83mNo; arc=none smtp.client-ip=62.149.156.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=benettiengineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=benettiengineering.com
Received: from localhost.localdomain ([84.33.84.190])
	by Aruba SMTP with ESMTPSA
	id AWoRwcrFktpTfAWoSwriPH; Wed, 08 Apr 2026 19:35:36 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
	t=1775669736; bh=OE4bGBsC/6m3rPeRKR9QkW5yZGvz2Tmkuk6fyZjTb8k=;
	h=From:To:Subject:Date:MIME-Version;
	b=hG/83mNozOsDP9P6uatbreG87llyvbiZ7erKi9HXKd4KXKX5GDEc11diYyULOhlz/
	 Mm+M/3tXZi0z6kJKqvjXzP3bdkLCY2N0NqPOqh5RSUySPfewrMbtLwzNX3OrdAgkgT
	 QvOMIc9oQo/bsxdzx3WKcR0ybW8VbYuXqK2+fcbckwmYIiusp2Xch5CGdnt3vzhiTQ
	 SI4yV3XXpNPEQUSbrOZ5jJikR5yp0FZbRapJPYN+GYt6Ws6YFcoFltPeTFxW8HngjP
	 d5MvTiyj9VZhkuWbfpiK941FZLiMjp/FenMxMvhuwqA47YVozknlNMSxV/rzWdm5ts
	 I/xbFL/w/zGwQ==
From: Giulio Benetti <giulio.benetti@benettiengineering.com>
To: linux-nfs@vger.kernel.org
Cc: Giulio Benetti <giulio.benetti@benettiengineering.com>
Subject: [PATCH v2 2/3] Introduce compat.h file to deal with old Linux api and fix build failure due to missing NETLINK_EXT_ACK
Date: Wed,  8 Apr 2026 19:35:34 +0200
Message-ID: <20260408173535.3992116-2-giulio.benetti@benettiengineering.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[aruba.it:s=a1];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[benettiengineering.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-20767-lists,linux-nfs=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[benettiengineering.com:email,benettiengineering.com:mid,aruba.it:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 565F23BFB27
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

In "compat.h" check if NETLINK_EXT_ACK exists, otherwise define it to fix
build failure and where at the moment <linux/netlink.h> is included
let's include "compat.h"

Signed-off-by: Giulio Benetti <giulio.benetti@benettiengineering.com>
---
V1->V2:
* include "compat.h" in place of <linux/netlink.h>
---
 support/export/cache.c       |  2 +-
 support/export/cache_flush.c |  2 ++
 support/include/compat.h     | 10 ++++++++++
 utils/nfsdctl/nfsdctl.c      |  1 +
 4 files changed, 14 insertions(+), 1 deletion(-)
 create mode 100644 support/include/compat.h

diff --git a/support/export/cache.c b/support/export/cache.c
index 2f128d7d..65008f51 100644
--- a/support/export/cache.c
+++ b/support/export/cache.c
@@ -40,7 +40,7 @@
 #include <netlink/genl/ctrl.h>
 #include <netlink/msg.h>
 #include <netlink/attr.h>
-#include <linux/netlink.h>
+#include "compat.h"
 
 #ifdef USE_SYSTEM_NFSD_NETLINK_H
 #include <linux/nfsd_netlink.h>
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
index 016dd2eb..c7126748 100644
--- a/utils/nfsdctl/nfsdctl.c
+++ b/utils/nfsdctl/nfsdctl.c
@@ -26,6 +26,7 @@
 #include <netlink/msg.h>
 #include <netlink/attr.h>
 #include <linux/netlink.h>
+#include "compat.h"
 
 #include <readline/readline.h>
 #include <readline/history.h>
-- 
2.47.3


