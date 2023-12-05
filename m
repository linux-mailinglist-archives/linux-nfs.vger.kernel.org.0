Return-Path: <linux-nfs+bounces-349-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D2138061C7
	for <lists+linux-nfs@lfdr.de>; Tue,  5 Dec 2023 23:35:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E9AECB21134
	for <lists+linux-nfs@lfdr.de>; Tue,  5 Dec 2023 22:35:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 403EB6EB61;
	Tue,  5 Dec 2023 22:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="mCQmQKua";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="M7fzFSot"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2a07:de40:b251:101:10:150:64:1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 710B1194
	for <linux-nfs@vger.kernel.org>; Tue,  5 Dec 2023 14:35:49 -0800 (PST)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E528D21F3E;
	Tue,  5 Dec 2023 22:35:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1701815747; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=fjpsNlROAUnmDPsSzAkWstikyUpHVYa2cGtfuDBcaFQ=;
	b=mCQmQKuaGl/TFEPD+WW7Z7wl7JJgLFtBRWFYEz0aGZmib5t6224ZOc7Tnp8JroKN+OpXv+
	2nYX/oIwH4joYmM1X4TrlW3Xuz4ejpTLbUBKCYIt2ypkZ+oyrZXJsFe5wKP9DtpsqDbmgB
	Z4i6nAblneXE5bSS/76vkGyYMeBzJTs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1701815747;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=fjpsNlROAUnmDPsSzAkWstikyUpHVYa2cGtfuDBcaFQ=;
	b=M7fzFSotxt+HoPgSy7cD6xFeEYS+EFB8S7FvXwTAxTMSddK/kJKUKJIrWL9RDyeiMrkfFh
	R2vLUp4NF3+EBqDg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id C271213924;
	Tue,  5 Dec 2023 22:35:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id GVHeLcOlb2UnEgAAn2gu4w
	(envelope-from <pvorel@suse.cz>); Tue, 05 Dec 2023 22:35:47 +0000
From: Petr Vorel <pvorel@suse.cz>
To: linux-nfs@vger.kernel.org
Cc: Petr Vorel <pvorel@suse.cz>,
	Steve Dickson <steved@redhat.com>,
	Giulio Benetti <giulio.benetti@benettiengineering.com>
Subject: [PATCH v2] reexport/{fsidd,reexport}.c: Re-add missing includes
Date: Tue,  5 Dec 2023 23:35:42 +0100
Message-ID: <20231205223543.31443-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [4.70 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[4];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 TO_DN_SOME(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-0.994];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[]
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Score: 4.70

Older uClibc-ng requires <unistd.h> for close(2), unlink(2) and write(2),
<sys/un.h> for struct sockaddr_un.

Fixes: 1a4edb2a ("reexport/fsidd.c: Remove unused headers")
Fixes: bdc79f02 ("support/reexport.c: Remove unused headers")
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Changes v1->v2:
* Add also <sys/un.h>

 support/reexport/fsidd.c    | 2 ++
 support/reexport/reexport.c | 1 +
 2 files changed, 3 insertions(+)

diff --git a/support/reexport/fsidd.c b/support/reexport/fsidd.c
index 8a70b78f..51750ea3 100644
--- a/support/reexport/fsidd.c
+++ b/support/reexport/fsidd.c
@@ -7,6 +7,8 @@
 #include <dlfcn.h>
 #endif
 #include <event2/event.h>
+#include <sys/un.h>
+#include <unistd.h>
 
 #include "conffile.h"
 #include "reexport_backend.h"
diff --git a/support/reexport/reexport.c b/support/reexport/reexport.c
index 0fb49a46..c7bff6a3 100644
--- a/support/reexport/reexport.c
+++ b/support/reexport/reexport.c
@@ -7,6 +7,7 @@
 #endif
 #include <sys/types.h>
 #include <sys/vfs.h>
+#include <unistd.h>
 #include <errno.h>
 
 #include "nfsd_path.h"
-- 
2.43.0


