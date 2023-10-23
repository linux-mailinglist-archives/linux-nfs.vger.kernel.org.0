Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E0767D2851
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Oct 2023 04:12:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233057AbjJWCMN (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 22 Oct 2023 22:12:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233094AbjJWCMM (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 22 Oct 2023 22:12:12 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB137E6
        for <linux-nfs@vger.kernel.org>; Sun, 22 Oct 2023 19:12:07 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 4F69821A80;
        Mon, 23 Oct 2023 02:12:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1698027126; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GDCSGpqzzQCPsWJnFwARKruyZ2iXRyLzv259sJdXiwE=;
        b=afeTQ7mXkyYdbgtEKuSYzWrtRlNWK/cTAVgg3QXY+LYjaNo4xCXFPkYSK2V4Rwfst/3EWS
        F8k88gQQEi3oqvogw940iZR/Iaw5AuZ/gSxXe1Y0r9JXa2yDT6n+g34S4uXDhdT0kT1UE3
        odzgtxr4/mMlD09hds9cRYZR+GQfh7k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1698027126;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GDCSGpqzzQCPsWJnFwARKruyZ2iXRyLzv259sJdXiwE=;
        b=twdbu0D/g6tyU74HoZ17i88eIkkID54jA378UPB7mgSkhwcE2cK8QML9HJ4tCyL4SF0YSS
        Rv8GEnVuMpcfVxBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 23A19132FD;
        Mon, 23 Oct 2023 02:12:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id VccwM3TWNWWTbwAAMHmgww
        (envelope-from <neilb@suse.de>); Mon, 23 Oct 2023 02:12:04 +0000
From:   NeilBrown <neilb@suse.de>
To:     Steve Dickson <steved@redhat.com>
Cc:     linux-nfs@vger.kernel.org,
        Trond Myklebust <trond.myklebust@hammerspace.com>
Subject: [PATCH 6/6] cache: periodically retry requests that couldn't be answered.
Date:   Mon, 23 Oct 2023 12:58:36 +1100
Message-ID: <20231023021052.5258-7-neilb@suse.de>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231023021052.5258-1-neilb@suse.de>
References: <20231023021052.5258-1-neilb@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
        none
X-Spam-Level: 
X-Spam-Score: -2.10
X-Spamd-Result: default: False [-2.10 / 50.00];
         ARC_NA(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         FROM_HAS_DN(0.00)[];
         RCPT_COUNT_THREE(0.00)[3];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         R_MISSING_CHARSET(2.50)[];
         BROKEN_CONTENT_TYPE(1.50)[];
         NEURAL_HAM_LONG(-3.00)[-1.000];
         DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
         NEURAL_HAM_SHORT(-1.00)[-1.000];
         MID_CONTAINS_FROM(1.00)[];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         RCVD_COUNT_TWO(0.00)[2];
         RCVD_TLS_ALL(0.00)[];
         BAYES_HAM(-3.00)[100.00%]
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Requests from the kernel to map the fsid from a filehandle to a path
name sometimes cannot be answered because the filesystems isn't
available now but might be available later.

This happens if an export is marked "mountpoint" but the mountpoint
isn't currently mounted.  In this case it might get mounted in the
future.

It also happens in an NFS filesystem is being re-exported and the server
is unresponsive.  In that case (if it was mounted "softerr") we get
ETIMEDOUT from a stat() attempt and so cannot give either a positive or
negative response.

These cases are currently handled poorly.  No answer is returned to the
kernel so it will continue waiting for an answer - and never get one
even if the NFS server comes back or the mountpoint is mounted.

We cannot report a soft error to the kernel so much retry ourselves.

With this patch we record the request when the lookup fails with
dev_missing or similar and retry every 2 minutes.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 support/export/cache.c | 121 +++++++++++++++++++++++++++++++++++------
 1 file changed, 103 insertions(+), 18 deletions(-)

diff --git a/support/export/cache.c b/support/export/cache.c
index a01eba4f6619..6c0a44a3a209 100644
--- a/support/export/cache.c
+++ b/support/export/cache.c
@@ -759,7 +759,15 @@ static struct addrinfo *lookup_client_addr(char *dom)
 	return ret;
 }
 
-static void nfsd_fh(int f)
+#define RETRY_SEC 120
+struct delayed {
+	char *message;
+	time_t last_attempt;
+	int f;
+	struct delayed *next;
+} *delayed;
+
+static int nfsd_handle_fh(int f, char *bp, int blen)
 {
 	/* request are:
 	 *  domain fsidtype fsid
@@ -777,21 +785,13 @@ static void nfsd_fh(int f)
 	nfs_export *exp;
 	int i;
 	int dev_missing = 0;
-	char buf[RPC_CHAN_BUF_SIZE], *bp;
-	int blen;
+	char buf[RPC_CHAN_BUF_SIZE];
 	int did_uncover = 0;
-
-	blen = cache_read(f, buf, sizeof(buf));
-	if (blen <= 0 || buf[blen-1] != '\n') return;
-	buf[blen-1] = 0;
-
-	xlog(D_CALL, "nfsd_fh: inbuf '%s'", buf);
-
-	bp = buf;
+	int ret = 0;
 
 	dom = malloc(blen);
 	if (dom == NULL)
-		return;
+		return ret;
 	if (qword_get(&bp, dom, blen) <= 0)
 		goto out;
 	if (qword_get_int(&bp, &fsidtype) != 0)
@@ -893,8 +893,10 @@ static void nfsd_fh(int f)
 		/* The missing dev could be what we want, so just be
 		 * quiet rather than returning stale yet
 		 */
-		if (dev_missing)
+		if (dev_missing) {
+			ret = 1;
 			goto out;
+		}
 	} else if (found->e_mountpoint &&
 	    !is_mountpoint(found->e_mountpoint[0]?
 			   found->e_mountpoint:
@@ -904,7 +906,7 @@ static void nfsd_fh(int f)
 		   xlog(L_WARNING, "%s not exported as %d not a mountpoint",
 		   found->e_path, found->e_mountpoint);
 		 */
-		/* FIXME we need to make sure we re-visit this later */
+		ret = 1;
 		goto out;
 	}
 
@@ -933,7 +935,68 @@ out:
 		free(found_path);
 	nfs_freeaddrinfo(ai);
 	free(dom);
-	xlog(D_CALL, "nfsd_fh: found %p path %s", found, found ? found->e_path : NULL);
+	if (!ret)
+		xlog(D_CALL, "nfsd_fh: found %p path %s",
+		     found, found ? found->e_path : NULL);
+	return ret;
+}
+
+static void nfsd_fh(int f)
+{
+	struct delayed *d, **dp;
+	char inbuf[RPC_CHAN_BUF_SIZE];
+	int blen;
+
+	blen = cache_read(f, inbuf, sizeof(inbuf));
+	if (blen <= 0 || inbuf[blen-1] != '\n') return;
+	inbuf[blen-1] = 0;
+
+	xlog(D_CALL, "nfsd_fh: inbuf '%s'", inbuf);
+
+	if (nfsd_handle_fh(f, inbuf, blen) == 0)
+		return;
+	/* We don't have a definitive answer to give the kernel.
+	 * This is because an export marked "mountpoint" isn't a
+	 * mountpoint, or because a stat of a mountpoint fails with
+	 * a strange error like ETIMEDOUT as is possible with an
+	 * NFS mount marked "softerr" which is being re-exported.
+	 *
+	 * We cannot tell the kernel to retry, so we have to
+	 * retry ourselves.
+	 */
+	d = malloc(sizeof(*d));
+
+	if (!d)
+		return;
+	d->message = strndup(inbuf, blen);
+	if (!d->message) {
+		free(d);
+		return;
+	}
+	d->f = f;
+	d->last_attempt = time(NULL);
+	d->next = NULL;
+	dp = &delayed;
+	while (*dp)
+		dp = &(*dp)->next;
+	*dp = d;
+}
+
+static void nfsd_retry_fh(struct delayed *d)
+{
+	struct delayed **dp;
+
+	if (nfsd_handle_fh(d->f, d->message, strlen(d->message)+1) == 0) {
+		free(d->message);
+		free(d);
+		return;
+	}
+	d->last_attempt = time(NULL);
+	d->next = NULL;
+	dp = &delayed;
+	while (*dp)
+		dp = &(*dp)->next;
+	*dp = d;
 }
 
 #ifdef HAVE_JUNCTION_SUPPORT
@@ -1512,7 +1575,7 @@ static void nfsd_export(int f)
 			 * This will cause it not to appear in the V4 Pseudo-root
 			 * and so a "mount" of this path will fail, just like with
 			 * V3.
-			 * And filehandle for this mountpoint from an earlier
+			 * Any filehandle for this mountpoint from an earlier
 			 * mount will block in nfsd.fh lookup.
 			 */
 			xlog(L_WARNING,
@@ -1610,6 +1673,7 @@ int cache_process(fd_set *readfds)
 {
 	fd_set fdset;
 	int	selret;
+	struct timeval tv = { 24*3600, 0 };
 
 	if (!readfds) {
 		FD_ZERO(&fdset);
@@ -1618,8 +1682,29 @@ int cache_process(fd_set *readfds)
 	cache_set_fds(readfds);
 	v4clients_set_fds(readfds);
 
-	selret = select(FD_SETSIZE, readfds,
-			(void *) 0, (void *) 0, (struct timeval *) 0);
+	if (delayed) {
+		time_t now = time(NULL);
+		time_t delay;
+		if (delayed->last_attempt > now)
+			/* Clock updated - retry immediately */
+			delayed->last_attempt = now - RETRY_SEC;
+		delay = delayed->last_attempt + RETRY_SEC - now;
+		if (delay < 0)
+			delay = 0;
+		tv.tv_sec = delay;
+	}
+	selret = select(FD_SETSIZE, readfds, NULL, NULL, &tv);
+
+	if (delayed) {
+		time_t now = time(NULL);
+		struct delayed *d = delayed;
+
+		if (d->last_attempt + RETRY_SEC <= now) {
+			delayed = d->next;
+			d->next = NULL;
+			nfsd_retry_fh(d);
+		}
+	}
 
 	switch (selret) {
 	case -1:
-- 
2.42.0

