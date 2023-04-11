Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADA386DDAA1
	for <lists+linux-nfs@lfdr.de>; Tue, 11 Apr 2023 14:18:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229588AbjDKMSk (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 11 Apr 2023 08:18:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229707AbjDKMSj (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 11 Apr 2023 08:18:39 -0400
X-Greylist: delayed 412 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 11 Apr 2023 05:18:37 PDT
Received: from redcrew.org (redcrew.org [37.157.195.192])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9101D2D4E
        for <linux-nfs@vger.kernel.org>; Tue, 11 Apr 2023 05:18:37 -0700 (PDT)
Received: from server.danny.cz (85-71-161-19.rce.o2.cz [85.71.161.19])
        by redcrew.org (Postfix) with ESMTP id 07C902C49;
        Tue, 11 Apr 2023 14:11:44 +0200 (CEST)
Received: from talos.danny.cz (unknown [IPv6:2001:470:5c11:160:47df:83f6:718e:218])
        by server.danny.cz (Postfix) with ESMTP id 6BE1C11AA3F;
        Tue, 11 Apr 2023 14:11:43 +0200 (CEST)
From:   =?UTF-8?q?Dan=20Hor=C3=A1k?= <dan@danny.cz>
To:     libtirpc-devel@lists.sourceforge.net
Cc:     linux-nfs@vger.kernel.org, Rob Riggs <rob+redhat@pangalactic.org>
Subject: [PATCH] allow TCP-only portmapper
Date:   Tue, 11 Apr 2023 14:11:42 +0200
Message-Id: <20230411121142.23312-1-dan@danny.cz>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.0 required=5.0 tests=SPF_HELO_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Code that works in GLIBC's runrpc implementation fails with libtirpc.
libtirpc forces the RPC library to talk to the portmapper via UDP,
even when the client specifies TCP.  This breaks existing code which
expect the protocol specified to be honored, even when talking to
portmapper.

This is upstreaming of an old patch by Rob Riggs reported in Fedora.

Resolves: https://bugzilla.redhat.com/show_bug.cgi?id=1725329
Signed-off-by: Rob Riggs <rob+redhat@pangalactic.org>
Signed-off-by: Dan Horák <dan@danny.cz>
---
 src/rpcb_clnt.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/src/rpcb_clnt.c b/src/rpcb_clnt.c
index 9a9de69..d178d86 100644
--- a/src/rpcb_clnt.c
+++ b/src/rpcb_clnt.c
@@ -496,11 +496,7 @@ getpmaphandle(nconf, hostname, tgtaddr)
 	CLIENT *client = NULL;
 	rpcvers_t pmapvers = 2;
 
-	/*
-	 * Try UDP only - there are some portmappers out
-	 * there that use UDP only.
-	 */
-	if (nconf == NULL || strcmp(nconf->nc_proto, NC_TCP) == 0) {
+	if (nconf == NULL) {
 		struct netconfig *newnconf;
 
 		if ((newnconf = getnetconfigent("udp")) == NULL) {
@@ -509,7 +505,8 @@ getpmaphandle(nconf, hostname, tgtaddr)
 		}
 		client = getclnthandle(hostname, newnconf, tgtaddr);
 		freenetconfigent(newnconf);
-	} else if (strcmp(nconf->nc_proto, NC_UDP) == 0) {
+	} else if (strcmp(nconf->nc_proto, NC_UDP) == 0 ||
+	    strcmp(nconf->nc_proto, NC_TCP) == 0) {
 		if (strcmp(nconf->nc_protofmly, NC_INET) != 0)
 			return NULL;
 		client = getclnthandle(hostname, nconf, tgtaddr);
-- 
2.40.0

