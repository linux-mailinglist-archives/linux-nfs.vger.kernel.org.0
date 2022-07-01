Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58BF956360B
	for <lists+linux-nfs@lfdr.de>; Fri,  1 Jul 2022 16:44:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230308AbiGAOo2 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 1 Jul 2022 10:44:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229998AbiGAOo1 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 1 Jul 2022 10:44:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 27DDA13DF7
        for <linux-nfs@vger.kernel.org>; Fri,  1 Jul 2022 07:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656686666;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=h7SXxbvBdKgkV0Y07gNFvEYBimc5aPt6PlyHKYYqNKE=;
        b=L99i9ib6qbIInZ8t2BL0rcP6f6CUBtuyiB/7+MxhUuPxYowtv/+TswWNFBiJpL+DXbCUL8
        u1QTikhm5znsRyQnlpb2VV4nkxRDSXQHAgal2joHq2eg8agreVBbqkAmQrfxZ/01+4do9J
        6SRCpyBp2Z5d3NpnfkXurdqWE0MSZpY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-191-8kHir0_gM0-_eL972fWiRQ-1; Fri, 01 Jul 2022 10:44:25 -0400
X-MC-Unique: 8kHir0_gM0-_eL972fWiRQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CF1581019C86;
        Fri,  1 Jul 2022 14:44:24 +0000 (UTC)
Received: from idlethread.redhat.com (unknown [10.40.194.217])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 11C8040336E;
        Fri,  1 Jul 2022 14:44:23 +0000 (UTC)
From:   Roberto Bergantinos Corpas <rbergant@redhat.com>
To:     libtirpc-devel@lists.sourceforge.net
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH] rpcb_clnt.c add mechanism to try v2 protocol first
Date:   Fri,  1 Jul 2022 16:44:22 +0200
Message-Id: <20220701144422.328923-1-rbergant@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.10
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

There have been previous attempts to revert protocol tryout
algorithm from v4,v3,v2 to previous v2,v4,v3 :

https://www.spinics.net/lists/linux-nfs/msg89228.html

Apart from GETADDR/NAT issue originating that proposed change,
its possible that some legacy custom applications still use
v2 of protocol with libtirpc.

The change proposed here, introduces an environment variable
"RPCB_V2FIRST" so that, if defined, old behaviour is used.
This is more flexible and allow us to selectively pick what
application reverts to old behaviour instead of a system-wide
change.

Example :

$ tcpdump -s0 -i ens3 port 111 -w /tmp/capture.pcap &> /dev/null &
[1] 13016
$ rpcinfo -T tcp 172.23.1.225 100005 &> /dev/null
$ RPCB_V2FIRST=1 rpcinfo -T tcp 172.23.1.225 100005 &> /dev/null
$ pkill tcpdump
$ tshark -tad -nr /tmp/capture.pcap -Y portmap -T fields -e _ws.col.Info
V4 GETADDR Call
V4 GETADDR Reply (Call In 4)
V2 GETPORT Call MOUNT(100005) V:0 TCP
V2 GETPORT Reply (Call In 14) Port:20048

Signed-off-by: Roberto Bergantinos Corpas <rbergant@redhat.com>
---
 man/rpcbind.3t        |  2 ++
 src/rpcb_clnt.c       | 27 ++++++++++++++++++++++++---
 tirpc/rpc/pmap_prot.h |  2 ++
 3 files changed, 28 insertions(+), 3 deletions(-)

diff --git a/man/rpcbind.3t b/man/rpcbind.3t
index ec492cc..4cb271b 100644
--- a/man/rpcbind.3t
+++ b/man/rpcbind.3t
@@ -187,6 +187,8 @@ in
 .El
 .Sh AVAILABILITY
 These functions are part of libtirpc.
+.Sh ENVIRONMENT
+If RPCB_V2FIRST is defined, rpcbind protocol version tryout algorithm changes from v4,v2,v3 to v2,v4,v3.
 .Sh SEE ALSO
 .Xr rpc_clnt_calls 3 ,
 .Xr rpc_svc_calls 3 ,
diff --git a/src/rpcb_clnt.c b/src/rpcb_clnt.c
index 0c34cb7..db3799e 100644
--- a/src/rpcb_clnt.c
+++ b/src/rpcb_clnt.c
@@ -818,7 +818,8 @@ error:
  * The algorithm used: If the transports is TCP or UDP, it first tries
  * version 4 (srv4), then 3 and then fall back to version 2 (portmap).
  * With this algorithm, we get performance as well as a plan for
- * obsoleting version 2.
+ * obsoleting version 2. This behaviour is reverted to old algorithm
+ * if RPCB_V2FIRST environment var is defined
  *
  * For all other transports, the algorithm remains as 4 and then 3.
  *
@@ -839,6 +840,10 @@ __rpcb_findaddr_timed(program, version, nconf, host, clpp, tp)
 #ifdef NOTUSED
 	static bool_t check_rpcbind = TRUE;
 #endif
+
+#ifdef PORTMAP
+	static bool_t portmap_first = FALSE;
+#endif
 	CLIENT *client = NULL;
 	RPCB parms;
 	enum clnt_stat clnt_st;
@@ -895,8 +900,18 @@ __rpcb_findaddr_timed(program, version, nconf, host, clpp, tp)
 		parms.r_addr = (char *) &nullstring[0];
 	}
 
-	/* First try from start_vers(4) and then version 3 (RPCBVERS) */
+	/* First try from start_vers(4) and then version 3 (RPCBVERS), except
+	 * if env. var RPCB_V2FIRST is defined */
+
+#ifdef PORTMAP
+	if (getenv(V2FIRST)) {
+		portmap_first = TRUE;
+		LIBTIRPC_DEBUG(3, ("__rpcb_findaddr_timed: trying v2-port first\n"));
+		goto portmap;
+	}
+#endif
 
+rpcbind:
 	CLNT_CONTROL(client, CLSET_RETRY_TIMEOUT, (char *) &rpcbrmttime);
 	for (vers = start_vers;  vers >= RPCBVERS; vers--) {
 		/* Set the version */
@@ -944,10 +959,16 @@ __rpcb_findaddr_timed(program, version, nconf, host, clpp, tp)
 	}
 
 #ifdef PORTMAP 	/* Try version 2 for TCP or UDP */
+	if (portmap_first)
+		goto error; /* we tried all versions if reached here */
+portmap:
 	if (strcmp(nconf->nc_protofmly, NC_INET) == 0) {
 		address = __try_protocol_version_2(program, version, nconf, host, tp);
 		if (address == NULL)
-			goto error;
+			if (portmap_first)
+				goto rpcbind;
+			else
+				goto error;
 	}
 #endif		/* PORTMAP */
 
diff --git a/tirpc/rpc/pmap_prot.h b/tirpc/rpc/pmap_prot.h
index 75354ce..7718b8b 100644
--- a/tirpc/rpc/pmap_prot.h
+++ b/tirpc/rpc/pmap_prot.h
@@ -84,6 +84,8 @@
 #define PMAPPROC_DUMP		((u_long)4)
 #define PMAPPROC_CALLIT		((u_long)5)
 
+#define V2FIRST		"RPCB_V2FIRST"
+
 struct pmap {
 	long unsigned pm_prog;
 	long unsigned pm_vers;
-- 
2.31.1

