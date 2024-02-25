Return-Path: <linux-nfs+bounces-2080-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D36AA86670C
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Feb 2024 00:57:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52112281294
	for <lists+linux-nfs@lfdr.de>; Sun, 25 Feb 2024 23:57:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 535D41BC4A;
	Sun, 25 Feb 2024 23:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="gdNIlzRC";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="XVaBeJUI";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="gdNIlzRC";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="XVaBeJUI"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CD421BC46
	for <linux-nfs@vger.kernel.org>; Sun, 25 Feb 2024 23:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708905419; cv=none; b=FMJU07n6qPXsQY3fDn9Jb7gN+k9ubTl7G2GJjaWgfs1p8lIIhE0mKa7qCERtK3ZyI8oryvh8EIxScR6dwdclMAWsdZP7AgfCst3UmNkkUold+BjKvsfRLZGPloOkPsKpAFuy+IYzbWB87/vufjUQPIIFMrnUhJAKK8Skp5bisro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708905419; c=relaxed/simple;
	bh=l3aT9iuPDZ1r0hy5dm85cPlpM0up9llB/QqrN/tuNd4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a2EIC9J5GQme8REH8CYQG4YHEpAFzmHvAjphkk0f11M24IcA52loVpZrHXhXoqv3TEcmXo1D/LPlnMyadrjRW1U+RxCUX+mTH+y85oFMHCvA8qujA8eNPj7dvofhtQSukWGjCLpyXRYfPC2P5RWiFjt6GkbTNzcHP8giKrlx8PU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=gdNIlzRC; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=XVaBeJUI; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=gdNIlzRC; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=XVaBeJUI; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id BECFA1FD08;
	Sun, 25 Feb 2024 23:56:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708905415; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Udet3eoKQu5eenuByJlBzWkfdc96g3Rz8xG5V7rdWoM=;
	b=gdNIlzRC4NJwU40+va5S1ujsSWqY+aI3NYGuAjedHCOWcF3cAr5U5QKLpnySI6TU+O/dnd
	kHPKzlEZBKgL7Sfbwrnn2dEmhDQCO2YwCAyKtsfdsG8X+y93kpC9o3ERRnYnwIePpd9pcv
	w24eop3atNConEZITxKedOQBDfkM5Ro=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708905415;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Udet3eoKQu5eenuByJlBzWkfdc96g3Rz8xG5V7rdWoM=;
	b=XVaBeJUIpoj8urY35awTNd21pO/IGDNHj1g4pU0E3HeTwiJB9xpnh5AQPk5s6XSSKdZG7J
	EqkotKBOuyZzgnCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708905415; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Udet3eoKQu5eenuByJlBzWkfdc96g3Rz8xG5V7rdWoM=;
	b=gdNIlzRC4NJwU40+va5S1ujsSWqY+aI3NYGuAjedHCOWcF3cAr5U5QKLpnySI6TU+O/dnd
	kHPKzlEZBKgL7Sfbwrnn2dEmhDQCO2YwCAyKtsfdsG8X+y93kpC9o3ERRnYnwIePpd9pcv
	w24eop3atNConEZITxKedOQBDfkM5Ro=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708905415;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Udet3eoKQu5eenuByJlBzWkfdc96g3Rz8xG5V7rdWoM=;
	b=XVaBeJUIpoj8urY35awTNd21pO/IGDNHj1g4pU0E3HeTwiJB9xpnh5AQPk5s6XSSKdZG7J
	EqkotKBOuyZzgnCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4386313432;
	Sun, 25 Feb 2024 23:56:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id zHX5NcXT22W9JgAAD6G6ig
	(envelope-from <neilb@suse.de>); Sun, 25 Feb 2024 23:56:53 +0000
From: NeilBrown <neilb@suse.de>
To: Steve Dickson <steved@redhat.com>
Cc: linux-nfs@vger.kernel.org,
	Petr Vorel <pvorel@suse.cz>
Subject: [PATCH 2/4] rpcbind: allow broadcast RPC to be disabled.
Date: Mon, 26 Feb 2024 10:53:54 +1100
Message-ID: <20240225235628.12473-3-neilb@suse.de>
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
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=gdNIlzRC;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=XVaBeJUI
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-3.00)[100.00%];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 RCVD_DKIM_ARC_DNSWL_HI(-1.00)[];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[3];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 RCVD_IN_DNSWL_HI(-0.50)[2a07:de40:b281:104:10:150:64:97:from];
	 RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -3.01
X-Rspamd-Queue-Id: BECFA1FD08
X-Spam-Flag: NO

From: NeilBrown <neilb@suse.com>

Support for broadcast RPC involves binding a second privileged
port.  It is possible that rpcbind might choose a port that some
other service will need, and that can cause problems.

Having this port open increases the attack surface of rpcbind.  RPC
replies can be sent to it by any host, and they will only be rejected
once they have been parsed enough to determine that the xid doesn't
match.

Boardcast is not widely used.  It is not used at all for NFS.  For NIS
(previously yellow pages) it can be used to find a local NIS server,
though this can also be statically configured.

In cases where broadcast-RPC is not needed, it is best to disable the
port.  This patch adds a new "-b" option to disable broadcast RPC.

Signed-off-by: NeilBrown <neilb@suse.com>
---
 man/rpcbind.8 |  5 +++++
 src/rpcbind.c | 10 +++++++---
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/man/rpcbind.8 b/man/rpcbind.8
index 6ba318f5ff77..ba1b191b119d 100644
--- a/man/rpcbind.8
+++ b/man/rpcbind.8
@@ -103,6 +103,11 @@ With this option, the name-to-address translation consistency
 checks are shown in detail.
 .It Fl f
 Do not fork and become a background process.
+.It Fl b
+Do not support broadcast RPC and do not bind the extra port.
+This is useful if
+.Nm
+inadvertently binds a port that some other service needs to use.
 .It Fl h
 Specify specific IP addresses to bind to for UDP requests.
 This option may be specified multiple times and can be used to
diff --git a/src/rpcbind.c b/src/rpcbind.c
index ecebe97da435..4819d6e5ba41 100644
--- a/src/rpcbind.c
+++ b/src/rpcbind.c
@@ -87,6 +87,7 @@ int debugging = 0;	/* Tell me what's going on */
 int doabort = 0;	/* When debugging, do an abort on errors */
 int dofork = 1;		/* fork? */
 int createdsocket = 0;  /* Did I create the socket or systemd did it for me? */
+int dobroadcast = 1;	/* Support forwarding of broadcast RPC calls (CALLIT) */
 
 rpcblist_ptr list_rbl;	/* A list of version 3/4 rpcbind services */
 
@@ -801,7 +802,7 @@ got_socket:
 	/*
 	 * rmtcall only supported on CLTS transports for now.
 	 */
-	if (nconf->nc_semantics == NC_TPI_CLTS) {
+	if (dobroadcast && nconf->nc_semantics == NC_TPI_CLTS) {
 		status = create_rmtcall_fd(nconf);
 #ifdef RPCBIND_DEBUG
 		if (debugging) {
@@ -886,7 +887,7 @@ parseargs(int argc, char *argv[])
 {
 	int c;
 	oldstyle_local = 1;
-	while ((c = getopt(argc, argv, "adh:ilswf")) != -1) {
+	while ((c = getopt(argc, argv, "adh:ilswfb")) != -1) {
 		switch (c) {
 		case 'a':
 			doabort = 1;	/* when debugging, do an abort on */
@@ -921,8 +922,11 @@ parseargs(int argc, char *argv[])
 			warmstart = 1;
 			break;
 #endif
+		case 'b':
+			dobroadcast = 0;
+			break;
 		default:	/* error */
-			fprintf(stderr,	"usage: rpcbind [-adhilswf]\n");
+			fprintf(stderr,	"usage: rpcbind [-adhilswfb]\n");
 			exit (1);
 		}
 	}
-- 
2.43.0


