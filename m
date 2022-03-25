Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA9C84E6B88
	for <lists+linux-nfs@lfdr.de>; Fri, 25 Mar 2022 01:28:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240633AbiCYA3v (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 24 Mar 2022 20:29:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244440AbiCYA3u (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 24 Mar 2022 20:29:50 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17886403C1
        for <linux-nfs@vger.kernel.org>; Thu, 24 Mar 2022 17:28:15 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 698321F38D;
        Fri, 25 Mar 2022 00:28:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1648168094; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=NFHhbzKCWtvhRwd+sRlhHq7HZAyy7CuqhofoMJX18gs=;
        b=bwXDMV7OGMBtBd6ImRprMzQlc6Ufw/AUnIMdqUdqsKgjDZJYL7Mz6LZF9S7/rA3TwsHIYg
        jt2ccoQnrq1IFv5E/984206owMnPmtlEEKBCsgXwJNCCz1pGsfzpP03963BIPVEKUzr8c6
        ppiuS76+PWmn1eg7TyZrmkeU9Fdd2vY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1648168094;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=NFHhbzKCWtvhRwd+sRlhHq7HZAyy7CuqhofoMJX18gs=;
        b=q66lsjaKVHXQ5y4JQQk5fsTQ/hYbdgzB+dISM9CzVUU2onNgRu1NruXcpZ+14chuNmIza9
        41xXGr4vH9WebTCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CF358132E9;
        Fri, 25 Mar 2022 00:28:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id i48JI5wMPWIfXwAAMHmgww
        (envelope-from <neilb@suse.de>); Fri, 25 Mar 2022 00:28:12 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     Chuck Lever III <chuck.lever@oracle.com>,
        Benjamin Coddington <bcodding@redhat.com>,
        Steve Dickson <SteveD@RedHat.com>,
        Trond Myklebust <trondmy@hammerspace.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: [PATCH/RFC] mount.nfs: handle EADDRINUSE from mount(2)
Date:   Fri, 25 Mar 2022 11:28:09 +1100
Message-id: <164816808982.6096.11435363819568479436@noble.neil.brown.name>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


[[This is the followup to the kernel patch I recently posted.
  It changes the behaviour of incorrectly configured containers to
  get unique client identities - so lease stealing doesn't happen
  so data corruption is avoided - but does not provide stable
  identities, so reboot recovery is not ideal.
  What is best to do when configuration is wrong?  Provide best service
  possible despite it not being perfect, or provide no service so the
  config will not get fixed.  I could be swayed either way.
]]

When NFS filesystems are mounted in different network namespaces, each
network namespace must provide a different hostname (via accompanying
UTS namespace) or different identifier (via sysfs).

If the kernel finds that the identity that it constructs is already in
use in a different namespace it will fail the mount with EADDRINUSE.

This patch catches that error and, if the sysfs identifier is unset,
writes a random string and retries.  This allows the mount to complete
safely even when misconfigured.  The random string has 128 bits of
entropy and so is extremely likely to be globally unique.

A lock is taken on the identifier file, and it is only updated if no
identifier is set.  Thus two concurrent mount attempts will not generate
different identities.  The mount is retried in any case as a race may
have updated the identifier while waiting for the lock.

This is not an ideal solution as an unclean restart of the host cannot
be detected by the server except by a lease timeout.  If the identifier
is configured correctly and is stable across restarts, the server can
detect the restart immediately.  Consequently a warning message is
generated to encourage correct configuration.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 utils/mount/stropts.c | 54 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 53 insertions(+), 1 deletion(-)

diff --git a/utils/mount/stropts.c b/utils/mount/stropts.c
index dbdd11e76b41..84266830b84a 100644
--- a/utils/mount/stropts.c
+++ b/utils/mount/stropts.c
@@ -32,6 +32,7 @@
=20
 #include <sys/socket.h>
 #include <sys/mount.h>
+#include <sys/file.h>
 #include <netinet/in.h>
 #include <arpa/inet.h>
=20
@@ -749,6 +750,50 @@ out:
 	return ret;
 }
=20
+#define ENTROPY_BITS 128
+static void set_random_identifier(void)
+{
+	int fd =3D open("/sys/fs/nfs/net/nfs_client/identifier", O_RDWR);
+	int rfd =3D -1;
+	unsigned char rbuf[ENTROPY_BITS / 8];
+	char buf[sizeof(rbuf)*2 + 2];
+	int n, rn;
+	int cnt =3D 1000;
+
+	if (fd < 0)
+		goto out;
+	/* wait at most one second */
+	while (flock(fd, LOCK_EX | LOCK_NB) !=3D 0) {
+		cnt -=3D 20;
+		if (cnt < 0)
+			goto out;
+		usleep(20 * 1000);
+	}
+	n =3D read(fd, buf, sizeof(buf)-1);
+	if (n <=3D 0)
+		goto out;
+	buf[n] =3D 0;
+	if (n !=3D 7 || strcmp(buf, "(null)\n") !=3D 0)
+		/* already set */
+		goto out;
+	rfd =3D open("/dev/urandom", O_RDONLY);
+	if (rfd < 0)
+		goto out;
+	rn =3D read(rfd, rbuf, sizeof(rbuf));
+	if (rn < (int)sizeof(rbuf))
+		goto out;
+	for (n =3D 0; n < rn; n++)
+		snprintf(&buf[n*2], 3, "%02x", rbuf[n]);
+	strcpy(&buf[n*2], "\n");
+	lseek(fd, SEEK_SET, 0);
+	write(fd, buf, strlen(buf));
+out:
+	if (rfd >=3D 0)
+		close(rfd);
+	if (fd >=3D 0)
+		close(fd);
+}
+
 static int nfs_do_mount_v4(struct nfsmount_info *mi,
 		struct sockaddr *sap, socklen_t salen)
 {
@@ -844,7 +889,14 @@ static int nfs_do_mount_v4(struct nfsmount_info *mi,
 			progname, extra_opts);
=20
 	result =3D nfs_sys_mount(mi, options);
-
+	if (!result && errno =3D=3D EADDRINUSE) {
+		/* client id is not unique, try to create unique id
+		 * and try again
+		 */
+		set_random_identifier();
+		xlog_warn("Retry mount with randomized identifier. Please configure a stab=
le identifier.");
+		result =3D nfs_sys_mount(mi, options);
+	}
 	/*
 	 * If success, update option string to be recorded in /etc/mtab.
 	 */
--=20
2.35.1

