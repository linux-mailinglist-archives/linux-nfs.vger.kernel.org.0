Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5401F1DDD01
	for <lists+linux-nfs@lfdr.de>; Fri, 22 May 2020 04:03:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727065AbgEVCDm (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 21 May 2020 22:03:42 -0400
Received: from mx2.suse.de ([195.135.220.15]:47192 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726335AbgEVCDm (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 21 May 2020 22:03:42 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 453AAB007;
        Fri, 22 May 2020 02:03:44 +0000 (UTC)
From:   NeilBrown <neilb@suse.de>
To:     "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>, kircherlike@outlook.com,
        Stephen Hemminger <stephen@networkplumber.org>
Date:   Fri, 22 May 2020 12:01:33 +1000
Subject: [PATCH 2/3] sunrpc: svcauth_gss_register_pseudoflavor must reject
 duplicate registrations.
Cc:     linux-nfs@vger.kernel.org
Message-ID: <159011289297.29107.15128425916228317497.stgit@noble>
In-Reply-To: <159011265914.29107.13764997801950546826.stgit@noble>
References: <159011265914.29107.13764997801950546826.stgit@noble>
User-Agent: StGit/0.21
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

There is no valid case for supporting duplicate pseudoflavor
registrations.
Currently the silent acceptance of such registrations is hiding a bug.
The rpcsec_gss_krb5 module registers 2 flavours but does not unregister
them, so if you load, unload, reload the module, it will happily
continue to use the old registration which now has pointers to the
memory were the module was originally loaded.  This could lead to
unexpected results.

So disallow duplicate registrations.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=206651
Cc: stable@vger.kernel.org (v2.6.12+)
Signed-off-by: NeilBrown <neilb@suse.de>
---
 net/sunrpc/auth_gss/svcauth_gss.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/sunrpc/auth_gss/svcauth_gss.c b/net/sunrpc/auth_gss/svcauth_gss.c
index 50d93c49ef1a..49bb346a6215 100644
--- a/net/sunrpc/auth_gss/svcauth_gss.c
+++ b/net/sunrpc/auth_gss/svcauth_gss.c
@@ -826,9 +826,11 @@ svcauth_gss_register_pseudoflavor(u32 pseudoflavor, char * name)
 	new->h.flavour = &svcauthops_gss;
 	new->pseudoflavor = pseudoflavor;
 
-	stat = 0;
 	test = auth_domain_lookup(name, &new->h);
-	if (test != &new->h) { /* Duplicate registration */
+	if (test != &new->h) {
+		pr_warn("svc: duplicate registration of gss pseudo flavour %s.\n",
+			name);
+		stat = -EADDRINUSE;
 		auth_domain_put(test);
 		kfree(new->h.name);
 		goto out_free_dom;


