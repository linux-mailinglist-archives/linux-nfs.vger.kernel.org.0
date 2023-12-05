Return-Path: <linux-nfs+bounces-350-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 306B48061C8
	for <lists+linux-nfs@lfdr.de>; Tue,  5 Dec 2023 23:35:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A4F99B211C2
	for <lists+linux-nfs@lfdr.de>; Tue,  5 Dec 2023 22:35:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AED16EB5A;
	Tue,  5 Dec 2023 22:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ka4C13ss";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="FzOixefS"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91A2D196
	for <linux-nfs@vger.kernel.org>; Tue,  5 Dec 2023 14:35:49 -0800 (PST)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 1AB741FBEF;
	Tue,  5 Dec 2023 22:35:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1701815748; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HpcMQxURZMSxKL2GbAyCHw1cQtJ0fdfi7l5T0BEriVY=;
	b=ka4C13ssZ9kDTfAKeRRrRu7qyXVR2IC9sYEoXqryIur1qnzVtzbN5OmeCr1fuJueXvWmdm
	4dUYsDbpVbVwzZry8bKnFgc9jnpjp8A7U9j14Et344hyDwjMHt+DlpR9eEUDR5PCuPJzJS
	P1ysoDxkFAJw2sPn1ZicjG8UN6m4AXw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1701815748;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HpcMQxURZMSxKL2GbAyCHw1cQtJ0fdfi7l5T0BEriVY=;
	b=FzOixefSUsuRIz8hzzwzsoIOgs9jNAGHd3k1lNyCfHDeLln8WuxaGkNY+PlZu2lb/iE4Tu
	5u7QRojzDA4Og4CA==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id E87A413A3D;
	Tue,  5 Dec 2023 22:35:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id gLcEN8Olb2UnEgAAn2gu4w
	(envelope-from <pvorel@suse.cz>); Tue, 05 Dec 2023 22:35:47 +0000
From: Petr Vorel <pvorel@suse.cz>
To: linux-nfs@vger.kernel.org
Cc: Petr Vorel <petr.vorel@gmail.com>,
	Steve Dickson <steved@redhat.com>,
	Giulio Benetti <giulio.benetti@benettiengineering.com>,
	Petr Vorel <pvorel@suse.cz>
Subject: [PATCH v2] support/backend_sqlite.c: Add missing <sys/syscall.h>
Date: Tue,  5 Dec 2023 23:35:43 +0100
Message-ID: <20231205223543.31443-2-pvorel@suse.cz>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231205223543.31443-1-pvorel@suse.cz>
References: <20231205223543.31443-1-pvorel@suse.cz>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Score: 2.24
X-Spamd-Result: default: False [2.24 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 BAYES_HAM(-0.00)[19.04%];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 R_MISSING_CHARSET(2.50)[];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLY(-4.00)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCPT_COUNT_FIVE(0.00)[5];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.16)[-0.821];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[gmail.com,redhat.com,benettiengineering.com,suse.cz];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]

From: Petr Vorel <petr.vorel@gmail.com>

This fixes build on systems which actually needs getrandom()
(to get SYS_getrandom).

Fixes: f92fd6ca ("support/backend_sqlite.c: Add getrandom() fallback")
Fixes: http://autobuild.buildroot.net/results/c5fde6099a8b228a8bdc3154d1e47dfa192e94ed/
Reported-by: Giulio Benetti <giulio.benetti@benettiengineering.com>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Changes v1->v2:
* New commit

I'm sorry for these errors.

 support/reexport/backend_sqlite.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/support/reexport/backend_sqlite.c b/support/reexport/backend_sqlite.c
index 0eb5ea37..54dfe447 100644
--- a/support/reexport/backend_sqlite.c
+++ b/support/reexport/backend_sqlite.c
@@ -7,6 +7,7 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
+#include <sys/syscall.h>
 #include <unistd.h>
 
 #ifdef HAVE_GETRANDOM
-- 
2.43.0


