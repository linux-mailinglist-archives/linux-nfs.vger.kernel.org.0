Return-Path: <linux-nfs+bounces-12121-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 964E9ACE98E
	for <lists+linux-nfs@lfdr.de>; Thu,  5 Jun 2025 08:01:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5141F175E56
	for <lists+linux-nfs@lfdr.de>; Thu,  5 Jun 2025 06:01:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60C802AF19;
	Thu,  5 Jun 2025 06:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="y7byHI2H";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="WPEUnXzH";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="y7byHI2H";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="WPEUnXzH"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0DCC1FC8
	for <linux-nfs@vger.kernel.org>; Thu,  5 Jun 2025 06:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749103261; cv=none; b=up4mgXSjFXvJDuZegW/0yu/QPdOvQzWYYpLLJDbQ/1Mc7nOalE4hPodF7yf8V1h9qX0tNjiCVRlCw04yfnUNVFXUFV+Qh26dzE8WLrA3fjsLSj6z8EulcFOdcJKKionOBNTsaznzsgG3UK9grITrlhb8/YdntZ/r/y4/WMCQfXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749103261; c=relaxed/simple;
	bh=qpJta258FnYw/PTHsnKQB7WmOXXuKGOfTCyY1BFsEbs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FXwzCa+4m62UVOf9Ii13vMEtDuUcWjRZt9e3oVSOhDhuW7LtT13JGCVML6ExCjy8pIvdaxYe2lk9HYl+qsbGyjJ6BiSWbYHQdbf4tTTDJYsEeSG8XNgDosfWeeRSowCV/e1KbE1Vz2pBCxu2YRLeA5a+E2QWZAFRM9dpXxDMq3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=y7byHI2H; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=WPEUnXzH; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=y7byHI2H; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=WPEUnXzH; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C32B82297B;
	Thu,  5 Jun 2025 06:00:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1749103251; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1udr9o1Wl9M7CCzXP/mRpdiA3MBWHZyaoxaMRyP+Fc4=;
	b=y7byHI2HIhf+kI7jnkro5WbetD3ohsVPGOF0bEB51E56/jLXO8G/KHjBuk2nH3kXSsvlYn
	f5SYtHCjsOeyrrVKrgrS6oqzbne/dkcy2jMMZ8rTcDN+d+5cS1o/N8TZ1sqOXiUiOT8MDC
	xhkb+NZ3WAioy/kqG65enEufJ0ViZno=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1749103251;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1udr9o1Wl9M7CCzXP/mRpdiA3MBWHZyaoxaMRyP+Fc4=;
	b=WPEUnXzHq+2gTRs+DzhGPFYldhQGSd9CoGzLvna1v3W1TBQFygNopUTR4gJUBooOMpu+0p
	XKVJh28qeYkCGGBA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1749103251; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1udr9o1Wl9M7CCzXP/mRpdiA3MBWHZyaoxaMRyP+Fc4=;
	b=y7byHI2HIhf+kI7jnkro5WbetD3ohsVPGOF0bEB51E56/jLXO8G/KHjBuk2nH3kXSsvlYn
	f5SYtHCjsOeyrrVKrgrS6oqzbne/dkcy2jMMZ8rTcDN+d+5cS1o/N8TZ1sqOXiUiOT8MDC
	xhkb+NZ3WAioy/kqG65enEufJ0ViZno=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1749103251;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1udr9o1Wl9M7CCzXP/mRpdiA3MBWHZyaoxaMRyP+Fc4=;
	b=WPEUnXzHq+2gTRs+DzhGPFYldhQGSd9CoGzLvna1v3W1TBQFygNopUTR4gJUBooOMpu+0p
	XKVJh28qeYkCGGBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9046C139CB;
	Thu,  5 Jun 2025 06:00:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id MDZ3IpMyQWicEQAAD6G6ig
	(envelope-from <pvorel@suse.cz>); Thu, 05 Jun 2025 06:00:51 +0000
From: Petr Vorel <pvorel@suse.cz>
To: linux-nfs@vger.kernel.org
Cc: libtirpc-devel@lists.sourceforge.net,
	Petr Vorel <pvorel@suse.cz>,
	Steve Dickson <SteveD@RedHat.com>,
	=?UTF-8?q?Ricardo=20B=20=2E=20Marli=C3=A8re?= <rbm@suse.com>
Subject: [PATCH rpcbind 2/2] rpcbind: Add -v flag to print version and config
Date: Thu,  5 Jun 2025 08:00:42 +0200
Message-ID: <20250605060042.1182574-2-pvorel@suse.cz>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250605060042.1182574-1-pvorel@suse.cz>
References: <20250605060042.1182574-1-pvorel@suse.cz>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:mid,imap1.dmz-prg2.suse.org:helo];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -2.80

This helps to see compiled time options, e.g. remote calls enablement.

$ ./rpcbind -v
rpcbind 1.2.7
debug: no, libset debug: no, libwrap: no, nss modules: files, remote calls: no, statedir: /run/rpcbind, systemd: yes, user: root, warm start: no

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 man/rpcbind.8 |  6 +++-
 src/rpcbind.c | 81 +++++++++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 83 insertions(+), 4 deletions(-)

diff --git a/man/rpcbind.8 b/man/rpcbind.8
index cd0f817..15b70f9 100644
--- a/man/rpcbind.8
+++ b/man/rpcbind.8
@@ -11,7 +11,7 @@
 .Nd universal addresses to RPC program number mapper
 .Sh SYNOPSIS
 .Nm
-.Op Fl adfhilsw
+.Op Fl adfhilsvw
 .Sh DESCRIPTION
 The
 .Nm
@@ -141,6 +141,10 @@ to use non-privileged ports for outgoing connections, preventing non-privileged
 clients from using
 .Nm
 to connect to services from a privileged port.
+.It Fl v
+Print
+.Nm
+version and builtin configuration and exit.
 .It Fl w
 Cause
 .Nm
diff --git a/src/rpcbind.c b/src/rpcbind.c
index 122ce6a..bf7b499 100644
--- a/src/rpcbind.c
+++ b/src/rpcbind.c
@@ -96,10 +96,11 @@ char *rpcbinduser = RPCBIND_USER;
 char *rpcbinduser = NULL;
 #endif
 
+#define NSS_MODULES_DEFAULT "files"
 #ifdef NSS_MODULES
 char *nss_modules = NSS_MODULES;
 #else
-char *nss_modules = "files";
+char *nss_modules = NSS_MODULES_DEFAULT;
 #endif
 
 /* who to suid to if -s is given */
@@ -143,6 +144,76 @@ static void rbllist_add(rpcprog_t, rpcvers_t, struct netconfig *,
 static void terminate(int);
 static void parseargs(int, char *[]);
 
+static void version()
+{
+	fprintf(stderr, "%s\n", PACKAGE_STRING);
+
+	fprintf(stderr, "debug: ");
+#ifdef RPCBIND_DEBUG
+	fprintf(stderr, "yes");
+#else
+	fprintf(stderr, "no");
+#endif
+
+	fprintf(stderr, ", libset debug: ");
+#ifdef LIB_SET_DEBUG
+	fprintf(stderr, "yes");
+#else
+	fprintf(stderr, "no");
+#endif
+
+	fprintf(stderr, ", libwrap: ");
+#ifdef LIBWRAP
+	fprintf(stderr, "yes");
+#else
+	fprintf(stderr, "no");
+#endif
+
+	fprintf(stderr, ", nss modules: ");
+#ifdef NSS_MODULES
+	fprintf(stderr, "%s", NSS_MODULES);
+#else
+	fprintf(stderr, "%s", NSS_MODULES_DEFAULT);
+#endif
+
+	fprintf(stderr, ", remote calls: ");
+#ifdef RMTCALLS
+	fprintf(stderr, "yes");
+#else
+	fprintf(stderr, "no");
+#endif
+
+	fprintf(stderr, ", statedir: ");
+#ifdef RPCBIND_STATEDIR
+	fprintf(stderr, "%s", RPCBIND_STATEDIR);
+#else
+	fprintf(stderr, "");
+#endif
+
+	fprintf(stderr, ", systemd: ");
+#ifdef SYSTEMD
+	fprintf(stderr, "yes");
+#else
+	fprintf(stderr, "no");
+#endif
+
+	fprintf(stderr, ", user: ");
+#ifdef RPCBIND_USER
+	fprintf(stderr, "%s", RPCBIND_USER);
+#else
+	fprintf(stderr, "");
+#endif
+
+	fprintf(stderr, ", warm start: ");
+#ifdef WARMSTART
+	fprintf(stderr, "yes");
+#else
+	fprintf(stderr, "no");
+#endif
+
+	fprintf(stderr, "\n");
+}
+
 int
 main(int argc, char *argv[])
 {
@@ -888,7 +959,7 @@ parseargs(int argc, char *argv[])
 {
 	int c;
 	oldstyle_local = 1;
-	while ((c = getopt(argc, argv, "adh:ilswf")) != -1) {
+	while ((c = getopt(argc, argv, "adfh:ilsvw")) != -1) {
 		switch (c) {
 		case 'a':
 			doabort = 1;	/* when debugging, do an abort on */
@@ -918,13 +989,17 @@ parseargs(int argc, char *argv[])
 		case 'f':
 			dofork = 0;
 			break;
+		case 'v':
+			version();
+			exit(0);
+			break;
 #ifdef WARMSTART
 		case 'w':
 			warmstart = 1;
 			break;
 #endif
 		default:	/* error */
-			fprintf(stderr,	"usage: rpcbind [-adhilswf]\n");
+			fprintf(stderr,	"usage: rpcbind [-adfhilsvw]\n");
 			exit (1);
 		}
 	}
-- 
2.49.0


