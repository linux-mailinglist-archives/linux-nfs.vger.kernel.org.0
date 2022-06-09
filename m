Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AF2654475D
	for <lists+linux-nfs@lfdr.de>; Thu,  9 Jun 2022 11:26:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238638AbiFIJ0U (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 9 Jun 2022 05:26:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238397AbiFIJ0T (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 9 Jun 2022 05:26:19 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 543F8C7E00
        for <linux-nfs@vger.kernel.org>; Thu,  9 Jun 2022 02:26:18 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 12E4921D41;
        Thu,  9 Jun 2022 09:26:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1654766777; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=+AyFd6Tl+niJw37GxkJfEE4as18iwOkzGevUuZmdwRg=;
        b=H8CJGzr5jMRH46EYUX+mTlyQstIXjvtpA0sqpPeosT4T2vDjQ7hTxoi+lupeC6N/IMWLNS
        AGasCKvfhBpDfHWOLXBdI121Um3jaRwwwKBMFEljMrwPd0IPCJKSo08VPkpbxQ3cSnDNQn
        DLdz7n4d9I+8B3i2+hHxI6Gv7TZyw2I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1654766777;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=+AyFd6Tl+niJw37GxkJfEE4as18iwOkzGevUuZmdwRg=;
        b=Hm6D8ZzAu2i/b4Siac4ArdMGeApr68UfO5NwcBJNKp0OzzbFwreMKIFgLA0aBx3yzOmzsP
        WL11Tu+29rNMaaBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E328C13456;
        Thu,  9 Jun 2022 09:26:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id tWn9Nbi8oWI3aAAAMHmgww
        (envelope-from <ohollmann@suse.cz>); Thu, 09 Jun 2022 09:26:16 +0000
Message-ID: <1654766776.2720.14.camel@suse.cz>
Subject: [PATCH] binddynport.c honor ip_local_reserved_ports
From:   Otto Hollmann <ohollmann@suse.cz>
To:     libtirpc-devel@lists.sourceforge.net
Cc:     linux-nfs@vger.kernel.org, Thomas Blume <thomas.blume@suse.com>
Date:   Thu, 09 Jun 2022 11:26:16 +0200
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Read reserved ports from /proc/sys/net/ipv4/ip_local_reserved_ports,
store them into bit-wise array and before binding to random port check
if port is not reserved.


Currently, there is no way how to reserve ports so then will not be
used by rpcbind.

Random ports are opened by rpcbind because of rmtcalls. There is
compile-time flag for disabling them, but in some cases we can not
simply disable them.

One solution would be run time option --enable-rmtcalls as already
discussed, but it was rejected. So if we want to keep rmtcalls enabled
and also be able to reserve some ports, there is no other way than
filtering available ports. The easiest and clearest way seems to be
just respect kernel list of ip_reserved_ports.

Unfortunately there is one known disadvantage/side effect - it affects
probability of ports which are right after reserved ones. The bigger
reserved block is, the higher is probability of selecting following
unreserved port. But if there is no reserved port, impact of this patch
is minimal/none.

Signed-off-by: Otto Hollmann <otto.hollmann@suse.com>
---
 src/binddynport.c | 107 ++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 99 insertions(+), 8 deletions(-)

diff --git a/src/binddynport.c b/src/binddynport.c
index 062629a..6f78ebe 100644
--- a/src/binddynport.c
+++ b/src/binddynport.c
@@ -37,6 +37,7 @@
 #include <unistd.h>
 #include <errno.h>
 #include <string.h>
+#include <syslog.h>
 
 #include <rpc/rpc.h>
 
@@ -56,6 +57,84 @@ enum {
 	NPORTS		= ENDPORT - LOWPORT + 1,
 };
 
+/*
+ * This function decodes information about given port from provided array and
+ * return if port is reserved or not.
+ *
+ * @reserved_ports an array of size at least "NPORTS / (8*sizeof(char)) + 1".
+ * @port port number within range LOWPORT and ENDPORT
+ *
+ * Returns 0 if port is not reserved, non-negative if port is reserved.
+ */
+int is_reserved(char *reserved_ports, int port) {
+	port -= LOWPORT;
+	if (port < 0 || port >= NPORTS)
+		return 0;
+	return reserved_ports[port/(8*sizeof(char))] & 1<<(port%(8*sizeof(char)));
+}
+
+/*
+ * This function encodes information about given *reserved* port into provided
+ * array. Don't call this function for ports which are not reserved.
+ *
+ * @reserved_ports array TODO .
+ * @port port number within range LOWPORT and ENDPORT
+ *
+ */
+void set_reserved(char *reserved_ports, int port) {
+	port -= LOWPORT;
+	if (port < 0 || port >= NPORTS)
+		return;
+	reserved_ports[port/(8*sizeof(char))] |= 1<<(port%(8*sizeof(char)));
+}
+
+/*
+ * Parse local reserved ports obtained from
+ * /proc/sys/net/ipv4/ip_local_reserved_ports into bit array.
+ *
+ * @reserved_ports a zeroed array of size at least
+ * "NPORTS / (8*sizeof(char)) + 1". Will be used for bit-wise encoding of
+ * reserved ports.
+ *
+ * On each call, reserved ports are read from /proc and bit-wise stored into
+ * provided array
+ *
+ * Returns 0 on success, -1 on failure.
+ */
+
+int parse_reserved_ports(char *reserved_ports) {
+	int from, to;
+	char delimiter = ',';
+	int res;
+	FILE * file_ptr = fopen("/proc/sys/net/ipv4/ip_local_reserved_ports","r");
+	if (file_ptr == NULL) {
+		(void) syslog(LOG_ERR,
+			"Unable to open open /proc/sys/net/ipv4/ip_local_reserved_ports.");
+		return -1;
+	}
+	do {
+		if ((res = fscanf(file_ptr, "%d", &to)) != 1) {
+			if (res == EOF) break;
+			goto err;
+		}
+		if (delimiter != '-') {
+			from = to;
+		}
+		for (int i = from; i <= to; ++i) {
+			set_reserved(reserved_ports, i);
+		}
+	} while ((res = fscanf(file_ptr, "%c", &delimiter)) == 1);
+	if (res != EOF)
+		goto err;
+	fclose(file_ptr);
+	return 0;
+err:
+	(void) syslog(LOG_ERR,
+		"An error occurred while parsing ip_local_reserved_ports.");
+	fclose(file_ptr);
+	return -1;
+}
+
 /*
  * Bind a socket to a dynamically-assigned IP port.
  *
@@ -81,7 +160,8 @@ int __binddynport(int fd)
 	in_port_t port, *portp;
 	struct sockaddr *sap;
 	socklen_t salen;
-	int i, res;
+	int i, res, array_size;
+	char *reserved_ports;
 
 	if (__rpc_sockisbound(fd))
 		return 0;
@@ -119,21 +199,32 @@ int __binddynport(int fd)
 		gettimeofday(&tv, NULL);
 		seed = tv.tv_usec * getpid();
 	}
+	array_size = NPORTS / (8*sizeof(char)) + 1;
+	reserved_ports = malloc(array_size);
+	if (!reserved_ports) {
+		goto out;
+	}
+	memset(reserved_ports, 0, array_size);
+	parse_reserved_ports(reserved_ports);
+
 	port = (rand_r(&seed) % NPORTS) + LOWPORT;
 	for (i = 0; i < NPORTS; ++i) {
-		*portp = htons(port++);
-		res = bind(fd, sap, salen);
-		if (res >= 0) {
-			res = 0;
-			break;
+		*portp = htons(port);
+		if (!is_reserved(reserved_ports, port++)) {
+			res = bind(fd, sap, salen);
+			if (res >= 0) {
+				res = 0;
+				break;
+			}
+			if (errno != EADDRINUSE)
+				break;
 		}
-		if (errno != EADDRINUSE)
-			break;
 		if (port > ENDPORT)
 			port = LOWPORT;
 	}
 
 out:
+	free(reserved_ports);
 	mutex_unlock(&port_lock);
 	return res;
 }
-- 
2.26.2
