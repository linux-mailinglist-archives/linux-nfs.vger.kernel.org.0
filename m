Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9735C5456A1
	for <lists+linux-nfs@lfdr.de>; Thu,  9 Jun 2022 23:42:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239775AbiFIVmn (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 9 Jun 2022 17:42:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239526AbiFIVmi (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 9 Jun 2022 17:42:38 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5360E66CAA
        for <linux-nfs@vger.kernel.org>; Thu,  9 Jun 2022 14:42:35 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id D4B4A22091;
        Thu,  9 Jun 2022 21:42:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1654810953; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1hrv4TBYgQiiDQzAMJuRcEJYK6Fsk+bBkGixpkqTdrg=;
        b=beFHBqPDfNmv747aSXkHCkv1rumqF8ZzGLOCggc1TQP6YWlWzjVR2mB/uTf04fMC7CWR6u
        l8LItaUc3nLgfWJS4V9igdNN3ktjW1O38YDftqJjikN3Icj5ELdwyjpsAJzEtkYsS/+dqI
        NJM+UhMOaMN7Ipl54WmI7rqIQfdt3c4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1654810953;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1hrv4TBYgQiiDQzAMJuRcEJYK6Fsk+bBkGixpkqTdrg=;
        b=sdF0lNGtPoLZUjeDpeuleInQvcctbpC9vXZmgVbZ+yCiyZYwz+UowM4ly0ZcU1o/xnn0ti
        A+SUpuIL+jS9CEBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3CD0E13A8C;
        Thu,  9 Jun 2022 21:42:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id aAa2DUlpomIQDgAAMHmgww
        (envelope-from <pvorel@suse.cz>); Thu, 09 Jun 2022 21:42:33 +0000
From:   Petr Vorel <pvorel@suse.cz>
To:     ltp@lists.linux.it
Cc:     Petr Vorel <pvorel@suse.cz>, Steve Dickson <steved@redhat.com>,
        linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>,
        "J . Bruce Fields" <bfields@fieldses.org>,
        Trond Myklebust <trondmy@hammerspace.com>,
        Alexey Kodanev <aleksei.kodanev@bell-sw.com>
Subject: [PATCH v2 7/9] tst_device: Add clear command
Date:   Thu,  9 Jun 2022 23:42:21 +0200
Message-Id: <20220609214223.4608-8-pvorel@suse.cz>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220609214223.4608-1-pvorel@suse.cz>
References: <20220609214223.4608-1-pvorel@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

clearing block device will be needed for TST_ALL_FILESYSTEMS
implementation in shell API. Now we clear device during acquire,
but we will reuse this device for each tested filesystem, thus we need a
separate command for it.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/lib/tst_device.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/testcases/lib/tst_device.c b/testcases/lib/tst_device.c
index d6b74a5ff..45f77a38b 100644
--- a/testcases/lib/tst_device.c
+++ b/testcases/lib/tst_device.c
@@ -18,8 +18,10 @@ static struct tst_test test = {
 
 static void print_help(void)
 {
-	fprintf(stderr, "\nUsage: tst_device acquire [size [filename]]\n");
-	fprintf(stderr, "   or: tst_device release /path/to/device\n\n");
+	fprintf(stderr, "\nUsage:\n");
+	fprintf(stderr, "tst_device acquire [size [filename]]\n");
+	fprintf(stderr, "tst_device release /path/to/device\n");
+	fprintf(stderr, "tst_device clear /path/to/device\n\n");
 }
 
 static int acquire_device(int argc, char *argv[])
@@ -72,6 +74,17 @@ static int release_device(int argc, char *argv[])
 	return tst_detach_device(argv[2]);
 }
 
+static int clear_device(int argc, char *argv[])
+{
+	if (argc != 3)
+		return 1;
+
+	if (tst_clear_device(argv[2]))
+		return 1;
+
+	return 0;
+}
+
 int main(int argc, char *argv[])
 {
 	/*
@@ -94,6 +107,9 @@ int main(int argc, char *argv[])
 	} else if (!strcmp(argv[1], "release")) {
 		if (release_device(argc, argv))
 			goto help;
+	} else if (!strcmp(argv[1], "clear")) {
+		if (clear_device(argc, argv))
+			goto help;
 	} else {
 		fprintf(stderr, "ERROR: Invalid COMMAND '%s'\n", argv[1]);
 		goto help;
-- 
2.36.1

