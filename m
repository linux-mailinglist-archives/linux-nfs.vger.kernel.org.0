Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF30C3248F1
	for <lists+linux-nfs@lfdr.de>; Thu, 25 Feb 2021 03:45:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236802AbhBYCn5 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 24 Feb 2021 21:43:57 -0500
Received: from mx2.suse.de ([195.135.220.15]:41946 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234384AbhBYCn4 (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 24 Feb 2021 21:43:56 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 227B2AE05;
        Thu, 25 Feb 2021 02:43:15 +0000 (UTC)
From:   NeilBrown <neilb@suse.de>
To:     Steve Dickson <SteveD@RedHat.com>
Date:   Thu, 25 Feb 2021 13:42:47 +1100
Subject: [PATCH 1/5] mountd: reject unknown client IP when !use_ipaddr.
Cc:     Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Message-ID: <161422096786.28256.16255172827545591674.stgit@noble>
In-Reply-To: <161422077024.28256.15543036625096419495.stgit@noble>
References: <161422077024.28256.15543036625096419495.stgit@noble>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: NeilBrown <neil@brown.name>

When use_ipaddr is not in effect, an auth_unix_ip lookup request from
the kernel for an unknown client will be rejected.
When it IS in effect, these requests are always granted with the IP
address being mapped to a string form of the address, preceded by a '$'.

This is inconsistent behaviour and could present a small information
leak.
It means that, for example, a SETCLIENT NFSv4 request may or may not
succeed depending on an internal setting in rpc.mountd.

This is easily rectified by always checking if the client is known.

Signed-off-by: NeilBrown <neil@brown.name>
---
 support/export/cache.c |   17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/support/export/cache.c b/support/export/cache.c
index f1569afb558c..156ebfd4087c 100644
--- a/support/export/cache.c
+++ b/support/export/cache.c
@@ -114,6 +114,7 @@ static void auth_unix_ip(int f)
 	char class[20];
 	char ipaddr[INET6_ADDRSTRLEN + 1];
 	char *client = NULL;
+	struct addrinfo *ai = NULL;
 	struct addrinfo *tmp = NULL;
 	char buf[RPC_CHAN_BUF_SIZE], *bp;
 	int blen;
@@ -139,21 +140,17 @@ static void auth_unix_ip(int f)
 
 	auth_reload();
 
-	/* addr is a valid, interesting address, find the domain name... */
-	if (!use_ipaddr) {
-		struct addrinfo *ai = NULL;
-
-		ai = client_resolve(tmp->ai_addr);
-		if (ai) {
-			client = client_compose(ai);
-			nfs_freeaddrinfo(ai);
-		}
+	/* addr is a valid address, find the domain name... */
+	ai = client_resolve(tmp->ai_addr);
+	if (ai) {
+		client = client_compose(ai);
+		nfs_freeaddrinfo(ai);
 	}
 	bp = buf; blen = sizeof(buf);
 	qword_add(&bp, &blen, "nfsd");
 	qword_add(&bp, &blen, ipaddr);
 	qword_adduint(&bp, &blen, time(0) + DEFAULT_TTL);
-	if (use_ipaddr) {
+	if (use_ipaddr && client) {
 		memmove(ipaddr + 1, ipaddr, strlen(ipaddr) + 1);
 		ipaddr[0] = '$';
 		qword_add(&bp, &blen, ipaddr);


