Return-Path: <linux-nfs+bounces-2082-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A59A986670E
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Feb 2024 00:57:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0FFBEB2119E
	for <lists+linux-nfs@lfdr.de>; Sun, 25 Feb 2024 23:57:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FCBA1B96E;
	Sun, 25 Feb 2024 23:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="1w0TkBSn";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="mWVJ/QZj";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="1w0TkBSn";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="mWVJ/QZj"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD5D21BC53
	for <linux-nfs@vger.kernel.org>; Sun, 25 Feb 2024 23:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708905434; cv=none; b=jfk0EUU8JIz+yFsUByMBIw3EGgxgUc82uHGNX0nKBWFAX8blMnmPaAhftZtBFcbIwRNhFyVJehIbG34hFzOqzDsorrRiRf33vPXVGgc1FZ7NEyhF/Q1yfYQiPoQ0qwKV4kumwmXVHnAg7prTIi5dd/y8d6DnvWogwLQtGzpZAI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708905434; c=relaxed/simple;
	bh=PBoK0ictngehnCw+nI2XNGAUlUnWVC5aX6T5lmr/4uc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u3sJPa9XKGyTFUcX+pb2e3VB9QnlGn2vErwLCJ7CzuYWxOr6oX6PZQCxtqa2jjvfCn8KPMeVV+GRozGSEJmnNgfczI5d/iBUuB+HkftTuvn7hd9k3xyai/kODVfQWUq6D6BeQYiDnohFR3J5q7lMfTEbebBG4yh4xbJp1Q5yiFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=1w0TkBSn; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=mWVJ/QZj; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=1w0TkBSn; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=mWVJ/QZj; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2E7C2224A6;
	Sun, 25 Feb 2024 23:57:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708905431; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PQk+j2UTs1NqVIXymPFcFYSoNQ3WPS/GzE2zlPXW7Nc=;
	b=1w0TkBSnT/2Lk3AHrMxBaPWXNUe/RE4G6syJdalvrnn42pimWF8fYLMGw0K7jNN1rlfnr5
	Rxrufu8KH24Di3mgrdUjxtQAqmZqC7sHzZaXmYgdEEoOAqYLlLwKVBh6sJk/i2cM5/hVA3
	sK0lKpWr9CHFApdHTqPmBKbvgZCGsLM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708905431;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PQk+j2UTs1NqVIXymPFcFYSoNQ3WPS/GzE2zlPXW7Nc=;
	b=mWVJ/QZjxwN/r5UuuyStzOCvoxZ/MKoNJ3GixMzIKS6gk6yl4Rk1sdiIiLInqXpifOxX8X
	qq+V5Y8i8un1beBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708905431; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PQk+j2UTs1NqVIXymPFcFYSoNQ3WPS/GzE2zlPXW7Nc=;
	b=1w0TkBSnT/2Lk3AHrMxBaPWXNUe/RE4G6syJdalvrnn42pimWF8fYLMGw0K7jNN1rlfnr5
	Rxrufu8KH24Di3mgrdUjxtQAqmZqC7sHzZaXmYgdEEoOAqYLlLwKVBh6sJk/i2cM5/hVA3
	sK0lKpWr9CHFApdHTqPmBKbvgZCGsLM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708905431;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PQk+j2UTs1NqVIXymPFcFYSoNQ3WPS/GzE2zlPXW7Nc=;
	b=mWVJ/QZjxwN/r5UuuyStzOCvoxZ/MKoNJ3GixMzIKS6gk6yl4Rk1sdiIiLInqXpifOxX8X
	qq+V5Y8i8un1beBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A8F4413432;
	Sun, 25 Feb 2024 23:57:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id QAhSE9XT22XMJgAAD6G6ig
	(envelope-from <neilb@suse.de>); Sun, 25 Feb 2024 23:57:09 +0000
From: NeilBrown <neilb@suse.de>
To: Steve Dickson <steved@redhat.com>
Cc: linux-nfs@vger.kernel.org,
	Petr Vorel <pvorel@suse.cz>
Subject: [PATCH 4/4] rpcinfo: try connecting using abstract address.
Date: Mon, 26 Feb 2024 10:53:56 +1100
Message-ID: <20240225235628.12473-5-neilb@suse.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240225235628.12473-1-neilb@suse.de>
References: <20240225235628.12473-1-neilb@suse.de>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: ***
X-Spam-Score: 3.70
X-Spamd-Result: default: False [3.70 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[3];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 TO_DN_SOME(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-0.999];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.00)[24.90%]
X-Spam-Flag: NO

rpcinfo doesn't use library calls to set up the address for rpcbind.  So
to get to it try the new abstract address, we need to explicitly
teach it how.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 src/rpcinfo.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/src/rpcinfo.c b/src/rpcinfo.c
index 0e14f78ad2de..4464cbc0941b 100644
--- a/src/rpcinfo.c
+++ b/src/rpcinfo.c
@@ -311,6 +311,13 @@ main (int argc, char **argv)
   return (0);
 }
 
+/* Evaluate to actual length of the `sockaddr_un' structure, whether
+ * abstract or not.
+ */
+#include <stddef.h>
+#define SUN_LEN_A(ptr) (offsetof(struct sockaddr_un, sun_path)	\
+			+ 1 + strlen((ptr)->sun_path + 1))
+
 static CLIENT *
 local_rpcb (rpcprog_t prog, rpcvers_t vers)
 {
@@ -334,6 +341,7 @@ local_rpcb (rpcprog_t prog, rpcvers_t vers)
   endnetconfig(localhandle);
   return clnt;
 #else
+  CLIENT *clnt;
   struct netbuf nbuf;
   struct sockaddr_un sun;
   int sock;
@@ -344,12 +352,26 @@ local_rpcb (rpcprog_t prog, rpcvers_t vers)
     return NULL;
 
   sun.sun_family = AF_LOCAL;
+
+#ifdef _PATH_RPCBINDSOCK_ABSTRACT
+  memcpy(sun.sun_path, _PATH_RPCBINDSOCK_ABSTRACT,
+         sizeof(_PATH_RPCBINDSOCK_ABSTRACT));
+  nbuf.len = SUN_LEN_A (&sun);
+  nbuf.maxlen = sizeof (struct sockaddr_un);
+  nbuf.buf = &sun;
+
+  clnt = clnt_vc_create (sock, &nbuf, prog, vers, 0, 0);
+  if (clnt)
+    return clnt;
+#endif
+
   strcpy (sun.sun_path, _PATH_RPCBINDSOCK);
   nbuf.len = SUN_LEN (&sun);
   nbuf.maxlen = sizeof (struct sockaddr_un);
   nbuf.buf = &sun;
 
-  return clnt_vc_create (sock, &nbuf, prog, vers, 0, 0);
+  clnt = clnt_vc_create (sock, &nbuf, prog, vers, 0, 0);
+  return clnt;
 #endif
 }
 
-- 
2.43.0


