Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE2DD4A2AA5
	for <lists+linux-nfs@lfdr.de>; Sat, 29 Jan 2022 01:44:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233942AbiA2AoT (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 28 Jan 2022 19:44:19 -0500
Received: from vmicros1.altlinux.org ([194.107.17.57]:47468 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232089AbiA2AoT (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 28 Jan 2022 19:44:19 -0500
Received: from mua.local.altlinux.org (mua.local.altlinux.org [192.168.1.14])
        by vmicros1.altlinux.org (Postfix) with ESMTP id A64F772C8FA;
        Sat, 29 Jan 2022 03:44:17 +0300 (MSK)
Received: by mua.local.altlinux.org (Postfix, from userid 508)
        id 7ED837CCA9C; Sat, 29 Jan 2022 03:44:17 +0300 (MSK)
Date:   Sat, 29 Jan 2022 03:44:17 +0300
From:   "Dmitry V. Levin" <ldv@altlinux.org>
To:     Steve Dickson <steved@redhat.com>
Cc:     libtirpc-devel@lists.sourceforge.net, linux-nfs@vger.kernel.org
Subject: [PATCH] rpcbind: fix double free in init_transport
Message-ID: <20220129004417.GA10610@altlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

$ rpcbind -h 127.0.0.1
free(): double free detected in tcache 2
Aborted

Fixes: a6889bba949b ("Removed resource leaks from src/rpcbind.c")
Resolves: https://sourceforge.net/p/rpcbind/bugs/6/
Signed-off-by: Dmitry V. Levin <ldv@altlinux.org>
---
 src/rpcbind.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/src/rpcbind.c b/src/rpcbind.c
index 25d8a90..ecebe97 100644
--- a/src/rpcbind.c
+++ b/src/rpcbind.c
@@ -552,8 +552,10 @@ init_transport(struct netconfig *nconf)
 				syslog(LOG_ERR, "cannot bind %s on %s: %m",
 					(hosts[nhostsbak] == NULL) ? "*" :
 					hosts[nhostsbak], nconf->nc_netid);
-				if (res != NULL)
+				if (res != NULL) {
 					freeaddrinfo(res);
+					res = NULL;
+				}
 				continue;
 			} else
 				checkbind++;
-- 
ldv
