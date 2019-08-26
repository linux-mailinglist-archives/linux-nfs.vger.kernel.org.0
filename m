Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 182DF9D1B9
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Aug 2019 16:34:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731765AbfHZOeZ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 26 Aug 2019 10:34:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54204 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726484AbfHZOeZ (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 26 Aug 2019 10:34:25 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id AA4F8307CDE7
        for <linux-nfs@vger.kernel.org>; Mon, 26 Aug 2019 14:34:24 +0000 (UTC)
Received: from madhat.boston.devel.redhat.com (ovpn-116-35.phx2.redhat.com [10.3.116.35])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 66113100197A
        for <linux-nfs@vger.kernel.org>; Mon, 26 Aug 2019 14:34:24 +0000 (UTC)
From:   Steve Dickson <steved@redhat.com>
To:     Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Subject: [PATCH 2/2] nfs-utils: Removed a number of Coverity Scan USE_AFTER_FREE errors
Date:   Mon, 26 Aug 2019 10:34:21 -0400
Message-Id: <20190826143421.13712-2-steved@redhat.com>
In-Reply-To: <20190826143421.13712-1-steved@redhat.com>
References: <20190826143421.13712-1-steved@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Mon, 26 Aug 2019 14:34:24 +0000 (UTC)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Signed-off-by: Steve Dickson <steved@redhat.com>
---
 utils/gssd/krb5_util.c | 4 +++-
 utils/idmapd/idmapd.c  | 6 ++++--
 utils/statd/monitor.c  | 5 ++++-
 utils/statd/notlist.c  | 9 +++++++--
 4 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/utils/gssd/krb5_util.c b/utils/gssd/krb5_util.c
index f68be85..0474783 100644
--- a/utils/gssd/krb5_util.c
+++ b/utils/gssd/krb5_util.c
@@ -1016,6 +1016,8 @@ query_krb5_ccache(const char* cred_cache, char **ret_princname,
 	char *str = NULL;
 	char *princstring;
 
+	*ret_princname = *ret_realm = NULL;
+
 	ret = krb5_init_context(&context);
 	if (ret) 
 		return 0;
@@ -1050,7 +1052,7 @@ err_princ:
 	krb5_cc_close(context, ccache);
 err_cache:
 	krb5_free_context(context);
-	return found;
+	return (*ret_princname && *ret_realm);
 }
 
 /*==========================*/
diff --git a/utils/idmapd/idmapd.c b/utils/idmapd/idmapd.c
index 267acea..c187e7d 100644
--- a/utils/idmapd/idmapd.c
+++ b/utils/idmapd/idmapd.c
@@ -520,14 +520,16 @@ static void
 clntscancb(int UNUSED(fd), short UNUSED(which), void *data)
 {
 	struct idmap_clientq *icq = data;
-	struct idmap_client *ic;
+	struct idmap_client *ic, *ic_next;
 
-	TAILQ_FOREACH(ic, icq, ic_next)
+	for (ic = TAILQ_FIRST(icq); ic != NULL; ic = ic_next) { 
+		ic_next = TAILQ_NEXT(ic, ic_next);
 		if (ic->ic_fd == -1 && nfsopen(ic) == -1) {
 			close(ic->ic_dirfd);
 			TAILQ_REMOVE(icq, ic, ic_next);
 			free(ic);
 		}
+	}
 }
 
 static void
diff --git a/utils/statd/monitor.c b/utils/statd/monitor.c
index 9400048..20c8ebd 100644
--- a/utils/statd/monitor.c
+++ b/utils/statd/monitor.c
@@ -66,7 +66,7 @@ sm_mon_1_svc(struct mon *argp, struct svc_req *rqstp)
 			*my_name  = argp->mon_id.my_id.my_name;
 	struct my_id	*id = &argp->mon_id.my_id;
 	char		*cp;
-	notify_list	*clnt;
+	notify_list	*clnt = NULL;
 	struct sockaddr_in my_addr = {
 		.sin_family		= AF_INET,
 		.sin_addr.s_addr	= htonl(INADDR_LOOPBACK),
@@ -177,6 +177,7 @@ sm_mon_1_svc(struct mon *argp, struct svc_req *rqstp)
 	 * We're committed...ignoring errors.  Let's hope that a malloc()
 	 * doesn't fail.  (I should probably fix this assumption.)
 	 */
+	clnt = NULL;
 	if (!existing && !(clnt = nlist_new(my_name, mon_name, 0))) {
 		free(dnsname);
 		xlog_warn("out of memory");
@@ -223,6 +224,7 @@ sm_mon_1_svc(struct mon *argp, struct svc_req *rqstp)
 
 failure:
 	xlog_warn("STAT_FAIL to %s for SM_MON of %s", my_name, mon_name);
+	free(clnt);
 	return (&result);
 }
 
@@ -242,6 +244,7 @@ load_one_host(const char *hostname,
 	clnt->dns_name = strdup(hostname);
 	if (clnt->dns_name == NULL) {
 		nlist_free(NULL, clnt);
+		free(clnt);
 		return 0;
 	}
 
diff --git a/utils/statd/notlist.c b/utils/statd/notlist.c
index 0341c15..45879a4 100644
--- a/utils/statd/notlist.c
+++ b/utils/statd/notlist.c
@@ -210,7 +210,6 @@ nlist_free(notify_list **head, notify_list *entry)
 	if (NL_MON_NAME(entry))
 		free(NL_MON_NAME(entry));
 	free(entry->dns_name);
-	free(entry);
 }
 
 /* 
@@ -219,8 +218,14 @@ nlist_free(notify_list **head, notify_list *entry)
 void 
 nlist_kill(notify_list **head)
 {
-	while (*head)
+	notify_list *next;
+
+	while (*head) {
+		next = (*head)->next;
 		nlist_free(head, *head);
+		free(*head);
+		*head = next;
+	}
 }
 
 /*
-- 
2.21.0

