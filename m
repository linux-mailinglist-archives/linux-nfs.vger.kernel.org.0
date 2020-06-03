Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B67D1ED7BF
	for <lists+linux-nfs@lfdr.de>; Wed,  3 Jun 2020 23:03:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726635AbgFCVDt (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 3 Jun 2020 17:03:49 -0400
Received: from mx2.suse.de ([195.135.220.15]:44308 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726645AbgFCVDt (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 3 Jun 2020 17:03:49 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id DE42EAB5C;
        Wed,  3 Jun 2020 21:03:51 +0000 (UTC)
From:   Petr Vorel <pvorel@suse.cz>
To:     linux-nfs@vger.kernel.org
Cc:     Petr Vorel <pvorel@suse.cz>, Steve Dickson <SteveD@RedHat.com>
Subject: [rpcbind 1/1] security: Fix typos in debug messages and comments
Date:   Wed,  3 Jun 2020 23:03:41 +0200
Message-Id: <20200603210341.11641-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 src/rpcbind.c  | 4 ++--
 src/security.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/src/rpcbind.c b/src/rpcbind.c
index 73daa1c..25d8a90 100644
--- a/src/rpcbind.c
+++ b/src/rpcbind.c
@@ -505,7 +505,7 @@ init_transport(struct netconfig *nconf)
 					hints.ai_flags |= AI_NUMERICHOST;
 				} else {
 					/*
-					 * Skip if we have an AF_INET6 adress.
+					 * Skip if we have an AF_INET6 address.
 					 */
 					if (inet_pton(AF_INET6,
 					    hosts[nhostsbak], host_addr) == 1)
@@ -518,7 +518,7 @@ init_transport(struct netconfig *nconf)
 					hints.ai_flags |= AI_NUMERICHOST;
 				} else {
 					/*
-					 * Skip if we have an AF_INET adress.
+					 * Skip if we have an AF_INET address.
 					 */
 					if (inet_pton(AF_INET, hosts[nhostsbak],
 					    host_addr) == 1)
diff --git a/src/security.c b/src/security.c
index 8a12019..329c53d 100644
--- a/src/security.c
+++ b/src/security.c
@@ -145,7 +145,7 @@ is_loopback(struct netbuf *nbuf)
 #ifdef RPCBIND_DEBUG
 		if (debugging)
 			  xlog(LOG_DEBUG,
-				  "Checking caller's adress (port = %d)\n",
+				  "Checking caller's address (port = %d)\n",
 				  ntohs(sin->sin_port));
 #endif
 	       	return (sin->sin_addr.s_addr == htonl(INADDR_LOOPBACK));
@@ -157,7 +157,7 @@ is_loopback(struct netbuf *nbuf)
 #ifdef RPCBIND_DEBUG
 		if (debugging)
 			  xlog(LOG_DEBUG,
-				  "Checking caller's adress (port = %d)\n",
+				  "Checking caller's address (port = %d)\n",
 				  ntohs(sin6->sin6_port));
 #endif
 		return (IN6_IS_ADDR_LOOPBACK(&sin6->sin6_addr) ||
-- 
2.26.2

