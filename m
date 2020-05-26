Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C735F1DC58E
	for <lists+linux-nfs@lfdr.de>; Thu, 21 May 2020 05:23:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728064AbgEUDXG (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 20 May 2020 23:23:06 -0400
Received: from mx2.suse.de ([195.135.220.15]:59054 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727825AbgEUDXG (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 20 May 2020 23:23:06 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 2BDE4B141;
        Thu, 21 May 2020 03:23:08 +0000 (UTC)
From:   NeilBrown <neilb@suse.de>
To:     "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>, kircherlike@outlook.com,
        Stephen Hemminger <stephen@networkplumber.org>
Date:   Thu, 21 May 2020 13:21:41 +1000
Subject: [PATCH 2/3] sunrpc: svcauth_gss_register_pseudoflavor must reject
 duplicate registrations.
Cc:     linux-nfs@vger.kernel.org
Message-ID: <159003130169.24897.13093682450013271796.stgit@noble>
In-Reply-To: <159003086409.24897.4659128962844846611.stgit@noble>
References: <159003086409.24897.4659128962844846611.stgit@noble>
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
Cc: stable@vger.kernel.org
Signed-off-by: NeilBrown <neilb@suse.de>
---
 net/sunrpc/auth_gss/svcauth_gss.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/sunrpc/auth_gss/svcauth_gss.c b/net/sunrpc/auth_gss/svcauth_gss.c
index 50d93c49ef1a..4aaaad794edb 100644
--- a/net/sunrpc/auth_gss/svcauth_gss.c
+++ b/net/sunrpc/auth_gss/svcauth_gss.c
@@ -826,9 +826,12 @@ svcauth_gss_register_pseudoflavor(u32 pseudoflavor, char * name)
 	new->h.flavour = &svcauthops_gss;
 	new->pseudoflavor = pseudoflavor;
 
-	stat = 0;
 	test = auth_domain_lookup(name, &new->h);
 	if (test != &new->h) { /* Duplicate registration */
+		printk(KERN_WARNING
+		       "SUNRPC:svcauth_gss: duplicate pseudo flavour registration of %s\n",
+		       name);
+		stat = -EALREADY;
 		auth_domain_put(test);
 		kfree(new->h.name);
 		goto out_free_dom;


