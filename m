Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6E9A1DDD02
	for <lists+linux-nfs@lfdr.de>; Fri, 22 May 2020 04:03:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727069AbgEVCDt (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 21 May 2020 22:03:49 -0400
Received: from mx2.suse.de ([195.135.220.15]:47432 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726335AbgEVCDt (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 21 May 2020 22:03:49 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 7FEF8AD09;
        Fri, 22 May 2020 02:03:50 +0000 (UTC)
From:   NeilBrown <neilb@suse.de>
To:     "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>, kircherlike@outlook.com,
        Stephen Hemminger <stephen@networkplumber.org>
Date:   Fri, 22 May 2020 12:01:33 +1000
Subject: [PATCH 3/3] sunrpc: clean up properly in gss_mech_unregister()
Cc:     linux-nfs@vger.kernel.org
Message-ID: <159011289300.29107.18158467549734203675.stgit@noble>
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

gss_mech_register() calls svcauth_gss_register_pseudoflavor() for each
flavour, but gss_mech_unregister() does not call auth_domain_put().
This is unbalanced and makes it impossible to reload the module.

Change svcauth_gss_register_pseudoflavor() to return the registered
auth_domain, and save it for later release.

Cc: stable@vger.kernel.org (v2.6.12+)
Link: https://bugzilla.kernel.org/show_bug.cgi?id=206651
Signed-off-by: NeilBrown <neilb@suse.de>
---
 include/linux/sunrpc/gss_api.h        |    1 +
 include/linux/sunrpc/svcauth_gss.h    |    3 ++-
 net/sunrpc/auth_gss/gss_mech_switch.c |   12 +++++++++---
 net/sunrpc/auth_gss/svcauth_gss.c     |   12 ++++++------
 4 files changed, 18 insertions(+), 10 deletions(-)

diff --git a/include/linux/sunrpc/gss_api.h b/include/linux/sunrpc/gss_api.h
index bc07e51f20d1..bf4ac8a0268c 100644
--- a/include/linux/sunrpc/gss_api.h
+++ b/include/linux/sunrpc/gss_api.h
@@ -84,6 +84,7 @@ struct pf_desc {
 	u32	service;
 	char	*name;
 	char	*auth_domain_name;
+	struct auth_domain *domain;
 	bool	datatouch;
 };
 
diff --git a/include/linux/sunrpc/svcauth_gss.h b/include/linux/sunrpc/svcauth_gss.h
index ca39a388dc22..8983628b10ff 100644
--- a/include/linux/sunrpc/svcauth_gss.h
+++ b/include/linux/sunrpc/svcauth_gss.h
@@ -20,7 +20,8 @@ int gss_svc_init(void);
 void gss_svc_shutdown(void);
 int gss_svc_init_net(struct net *net);
 void gss_svc_shutdown_net(struct net *net);
-int svcauth_gss_register_pseudoflavor(u32 pseudoflavor, char * name);
+struct auth_domain *svcauth_gss_register_pseudoflavor(u32 pseudoflavor,
+						      char *name);
 u32 svcauth_gss_flavor(struct auth_domain *dom);
 
 #endif /* _LINUX_SUNRPC_SVCAUTH_GSS_H */
diff --git a/net/sunrpc/auth_gss/gss_mech_switch.c b/net/sunrpc/auth_gss/gss_mech_switch.c
index 69316ab1b9fa..fae632da1058 100644
--- a/net/sunrpc/auth_gss/gss_mech_switch.c
+++ b/net/sunrpc/auth_gss/gss_mech_switch.c
@@ -37,6 +37,8 @@ gss_mech_free(struct gss_api_mech *gm)
 
 	for (i = 0; i < gm->gm_pf_num; i++) {
 		pf = &gm->gm_pfs[i];
+		if (pf->domain)
+			auth_domain_put(pf->domain);
 		kfree(pf->auth_domain_name);
 		pf->auth_domain_name = NULL;
 	}
@@ -59,6 +61,7 @@ make_auth_domain_name(char *name)
 static int
 gss_mech_svc_setup(struct gss_api_mech *gm)
 {
+	struct auth_domain *dom;
 	struct pf_desc *pf;
 	int i, status;
 
@@ -68,10 +71,13 @@ gss_mech_svc_setup(struct gss_api_mech *gm)
 		status = -ENOMEM;
 		if (pf->auth_domain_name == NULL)
 			goto out;
-		status = svcauth_gss_register_pseudoflavor(pf->pseudoflavor,
-							pf->auth_domain_name);
-		if (status)
+		dom = svcauth_gss_register_pseudoflavor(
+			pf->pseudoflavor, pf->auth_domain_name);
+		if (IS_ERR(dom)) {
+			status = PTR_ERR(dom);
 			goto out;
+		}
+		pf->domain = dom;
 	}
 	return 0;
 out:
diff --git a/net/sunrpc/auth_gss/svcauth_gss.c b/net/sunrpc/auth_gss/svcauth_gss.c
index 49bb346a6215..46027d0c903f 100644
--- a/net/sunrpc/auth_gss/svcauth_gss.c
+++ b/net/sunrpc/auth_gss/svcauth_gss.c
@@ -809,7 +809,7 @@ u32 svcauth_gss_flavor(struct auth_domain *dom)
 
 EXPORT_SYMBOL_GPL(svcauth_gss_flavor);
 
-int
+struct auth_domain *
 svcauth_gss_register_pseudoflavor(u32 pseudoflavor, char * name)
 {
 	struct gss_domain	*new;
@@ -832,17 +832,17 @@ svcauth_gss_register_pseudoflavor(u32 pseudoflavor, char * name)
 			name);
 		stat = -EADDRINUSE;
 		auth_domain_put(test);
-		kfree(new->h.name);
-		goto out_free_dom;
+		goto out_free_name;
 	}
-	return 0;
+	return test;
 
+out_free_name:
+	kfree(new->h.name);
 out_free_dom:
 	kfree(new);
 out:
-	return stat;
+	return ERR_PTR(stat);
 }
-
 EXPORT_SYMBOL_GPL(svcauth_gss_register_pseudoflavor);
 
 static inline int


