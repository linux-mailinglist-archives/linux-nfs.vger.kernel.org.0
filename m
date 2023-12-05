Return-Path: <linux-nfs+bounces-341-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01D0B805F3D
	for <lists+linux-nfs@lfdr.de>; Tue,  5 Dec 2023 21:16:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 72DA7B20F59
	for <lists+linux-nfs@lfdr.de>; Tue,  5 Dec 2023 20:16:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43C026DCF7;
	Tue,  5 Dec 2023 20:16:06 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11C9C183
	for <linux-nfs@vger.kernel.org>; Tue,  5 Dec 2023 12:16:01 -0800 (PST)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id DED1A21FA2;
	Tue,  5 Dec 2023 20:15:59 +0000 (UTC)
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 6129C13924;
	Tue,  5 Dec 2023 20:15:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id cOkwEf+Eb2VjcAAAn2gu4w
	(envelope-from <pvorel@suse.cz>); Tue, 05 Dec 2023 20:15:59 +0000
From: Petr Vorel <pvorel@suse.cz>
To: linux-nfs@vger.kernel.org
Cc: Petr Vorel <pvorel@suse.cz>,
	Steve Dickson <steved@redhat.com>
Subject: [PATCH 1/1] reexport/{fsidd,reexport}.c: Add missing <unistd.h>
Date: Tue,  5 Dec 2023 21:15:55 +0100
Message-ID: <20231205201556.5477-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: 4.96
X-Spamd-Result: default: False [4.96 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 ARC_NA(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[3];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 DMARC_NA(0.00)[suse.cz];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 TO_DN_SOME(0.00)[];
	 R_SPF_SOFTFAIL(0.00)[~all];
	 RCVD_COUNT_THREE(0.00)[3];
	 NEURAL_SPAM_SHORT(0.07)[0.022];
	 MX_GOOD(-0.01)[];
	 MID_CONTAINS_FROM(1.00)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 R_DKIM_NA(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.00)[19.79%]
X-Spamd-Bar: ++++
X-Rspamd-Server: rspamd1
Authentication-Results: smtp-out1.suse.de;
	dkim=none;
	dmarc=none;
	spf=softfail (smtp-out1.suse.de: 2a07:de40:b281:104:10:150:64:98 is neither permitted nor denied by domain of pvorel@suse.cz) smtp.mailfrom=pvorel@suse.cz
X-Rspamd-Queue-Id: DED1A21FA2

uClibc-ng requires this header for close(2), unlink(2) and write(2).

Fixes: 1a4edb2a ("reexport/fsidd.c: Remove unused headers")
Fixes: bdc79f02 ("support/reexport.c: Remove unused headers")
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Hi Steve,

I'm sorry to introduce a regression. Here is a fix, tested on glibc,
musl and uClibc-ng.

 support/reexport/fsidd.c    | 1 +
 support/reexport/reexport.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/support/reexport/fsidd.c b/support/reexport/fsidd.c
index 8a70b78f..307e73e5 100644
--- a/support/reexport/fsidd.c
+++ b/support/reexport/fsidd.c
@@ -7,6 +7,7 @@
 #include <dlfcn.h>
 #endif
 #include <event2/event.h>
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


