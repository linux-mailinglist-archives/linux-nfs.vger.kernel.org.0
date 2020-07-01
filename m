Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B1332112AD
	for <lists+linux-nfs@lfdr.de>; Wed,  1 Jul 2020 20:28:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732920AbgGAS2M (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 1 Jul 2020 14:28:12 -0400
Received: from ny018.relay.arandomserver.com ([172.96.188.180]:46869 "EHLO
        ny018.relay.arandomserver.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732869AbgGAS2L (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 1 Jul 2020 14:28:11 -0400
Received: from nyc006.hawkhost.com ([172.96.186.142])
        by se004.arandomserver.com with esmtps (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.92)
        (envelope-from <nazard@nazar.ca>)
        id 1jqhSq-0007Wy-C4
        for linux-nfs@vger.kernel.org; Wed, 01 Jul 2020 13:28:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nazar.ca;
         s=default; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=QC8TwmTiKZOOMl2vR/0eStdENFnTU/a8dux5XXItAj8=; b=PbTd9r4LFmmxo0PA/JjTbM0Ckh
        RUFHsA1o6Pewq64TLa9tw8Rz8cN9ij/6hUNajQPhrkmqKCSJhjStT8/NR4YN/T/gQRFgHDEaRKey4
        uHRDde6SYFfloNw+tgGtuTwzlMpPJ0w3IVT8bJ85lAV4eQqqP9tUsIi+dtyD6J1VJxLawHRphkA6U
        XAkl5tZd3CuvR/AOPpPxo2d6B5J1bEvhvY3ONNa5Y0tDzt/Hh1npn4scYSRPj8FfcccdO/3Kz7pmQ
        Lk2lTTm1woOE6tz9rtDwu7Gm5PMyZxiWlfd+0PklKm9ILayK8TzhIPkoYslNJNfCcAqkHZ71n4l4Q
        +oqqhI4Q==;
Received: from [174.119.114.224] (port=43594 helo=wraith.dragoninc.ca)
        by nyc006.hawkhost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <nazard@nazar.ca>)
        id 1jqhSq-0003Oc-5c
        for linux-nfs@vger.kernel.org; Wed, 01 Jul 2020 14:28:08 -0400
From:   Doug Nazar <nazard@nazar.ca>
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 01/10] gssd: Refcount struct clnt_info to protect multithread usage
Date:   Wed,  1 Jul 2020 14:27:52 -0400
Message-Id: <20200701182803.14947-2-nazard@nazar.ca>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200701182803.14947-1-nazard@nazar.ca>
References: <20200701182803.14947-1-nazard@nazar.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Get-Message-Sender-Via: nyc006.hawkhost.com: authenticated_id: nazard@nazar.ca
X-Authenticated-Sender: nyc006.hawkhost.com: nazard@nazar.ca
X-Originating-IP: 172.96.186.142
X-SpamExperts-Domain: nyc006.hawkhost.com
X-SpamExperts-Username: 172.96.186.142
Authentication-Results: arandomserver.com; auth=pass smtp.auth=172.96.186.142@nyc006.hawkhost.com
X-SpamExperts-Outgoing-Class: ham
X-SpamExperts-Outgoing-Evidence: SB/global_tokens (9.16360745756e-06)
X-Recommended-Action: accept
X-Filter-ID: Mvzo4OR0dZXEDF/gcnlw0f6LF1GdvkEexklpcFpSF5apSDasLI4SayDByyq9LIhV3wiWmWOaZr8Q
 /V7KnXOcLkTNWdUk1Ol2OGx3IfrIJKywOmJyM1qr8uRnWBrbSAGDoHt0IcOGwKCbMuu8Bh1PoO2W
 aaJF459Au8f7ARCz5dLoVhUqwDWHElVqSMaHzWJBegfeKReIk6lNHL724UlzkXXpGCeulZALlD2V
 AvpAcEdNy48VCLWq/B04EaMIT1z9KJ9I7HJckiqd4uUgfyUDbi0mNlctu/ZLaOH13A3s9cVWgxmT
 epC+rmMtfXSN6UccbEYBdMHLz8fdZytxBPvQ/tfm/6ZhrBvMHqGRRS2yqrTz7IssKbNSm6Aylrz7
 vRRedYGRJ5j/qgI5gfjNk3Q1FcO1wjmeb9RCa+YI49T4kOuq00YljRCkN7s2SRETCBXfmpMlsQfU
 CJBMRaGGGXrzQwzEEJbreAQRsbSZZ9fXoUEifL76GD10kuo3nOZaoX+gsjENmEszkjZCjfYHwrdv
 NOzx52pqgFKULzmTh7lC+C1OB0fQQI8VICRbS6zGNgmk2+y1r/Jt2+QI0NYgZu+YDGDmnroh/8hH
 WR/Etfk4HCQTo4dLz8XEDoyijq2CEGKcGplHcpVCCoX989hgB8R+yHz6Wz8d/Pp/n7kUT3MNKWyV
 mI6ol8ojWV/XK6LQktrhOa4kf6FEEzbkVFDeVFPT839nMre3YEbkuALmW8gN9RXH3DI0NOgo6/Ab
 vYB8YDlEEBksfbu9yLQMc7lcHkHFV/djzQ6YC7Heg3Xf7O1TOd4Lp6/mezP3/ta7RoBl7TSj8Cd1
 02D1/PxWBdanhqFXVGIDtlyyGhtxMdqa3CaFDS09w5ikrZkgUlHVfPZEuFEfZjEa/sNl+vcoDGoY
 k0DAXQsuA+ZOE6ZCLBhP3Kw7GhP6DxWSEoQUnaVSVuR240Ewmn4rjkt/ing/Kst6lT+FgU1vUJm2
 lwcjBA1nf30dydyo/g58MkufxisELuuE3bZK19QhM8um7L9VndMW7hyljAQWfxYdU0gXE07BZ9Ya
 Ke+gc5LamkkGaPkiMxmyjA0L/Ub/yrYgxwwQmd72Iri+RjEvuGslKTrRIXcXpFg5ivY=
X-Report-Abuse-To: spam@se001.arandomserver.com
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Struct clnt_info is shared with the various upcall threads so
we need to ensure that it stays around even if the client dir
gets removed.

Reported-by: Sebastian Kraus <sebastian.kraus@tu-berlin.de>
Signed-off-by: Doug Nazar <nazard@nazar.ca>
---
 utils/gssd/gssd.c      | 67 ++++++++++++++++++++++++++++++++----------
 utils/gssd/gssd.h      |  5 ++--
 utils/gssd/gssd_proc.c |  4 +--
 3 files changed, 55 insertions(+), 21 deletions(-)

diff --git a/utils/gssd/gssd.c b/utils/gssd/gssd.c
index 588da0fb..b40c3220 100644
--- a/utils/gssd/gssd.c
+++ b/utils/gssd/gssd.c
@@ -90,9 +90,7 @@ char *ccachedir = NULL;
 /* Avoid DNS reverse lookups on server names */
 static bool avoid_dns = true;
 static bool use_gssproxy = false;
-int thread_started = false;
-pthread_mutex_t pmutex = PTHREAD_MUTEX_INITIALIZER;
-pthread_cond_t pcond = PTHREAD_COND_INITIALIZER;
+pthread_mutex_t clp_lock = PTHREAD_MUTEX_INITIALIZER;
 
 TAILQ_HEAD(topdir_list_head, topdir) topdir_list;
 
@@ -359,20 +357,28 @@ out:
 	free(port);
 }
 
+/* Actually frees clp and fields that might be used from other
+ * threads if was last reference.
+ */
 static void
-gssd_destroy_client(struct clnt_info *clp)
+gssd_free_client(struct clnt_info *clp)
 {
-	if (clp->krb5_fd >= 0) {
+	int refcnt;
+
+	pthread_mutex_lock(&clp_lock);
+	refcnt = --clp->refcount;
+	pthread_mutex_unlock(&clp_lock);
+	if (refcnt > 0)
+		return;
+
+	printerr(3, "freeing client %s\n", clp->relpath);
+
+	if (clp->krb5_fd >= 0)
 		close(clp->krb5_fd);
-		event_del(&clp->krb5_ev);
-	}
 
-	if (clp->gssd_fd >= 0) {
+	if (clp->gssd_fd >= 0)
 		close(clp->gssd_fd);
-		event_del(&clp->gssd_ev);
-	}
 
-	inotify_rm_watch(inotify_fd, clp->wd);
 	free(clp->relpath);
 	free(clp->servicename);
 	free(clp->servername);
@@ -380,6 +386,24 @@ gssd_destroy_client(struct clnt_info *clp)
 	free(clp);
 }
 
+/* Called when removing from clnt_list to tear down event handling.
+ * Will then free clp if was last reference.
+ */
+static void
+gssd_destroy_client(struct clnt_info *clp)
+{
+	printerr(3, "destroying client %s\n", clp->relpath);
+
+	if (clp->krb5_fd >= 0)
+		event_del(&clp->krb5_ev);
+
+	if (clp->gssd_fd >= 0)
+		event_del(&clp->gssd_ev);
+
+	inotify_rm_watch(inotify_fd, clp->wd);
+	gssd_free_client(clp);
+}
+
 static void gssd_scan(void);
 
 static int
@@ -416,11 +440,21 @@ static struct clnt_upcall_info *alloc_upcall_info(struct clnt_info *clp)
 	info = malloc(sizeof(struct clnt_upcall_info));
 	if (info == NULL)
 		return NULL;
+
+	pthread_mutex_lock(&clp_lock);
+	clp->refcount++;
+	pthread_mutex_unlock(&clp_lock);
 	info->clp = clp;
 
 	return info;
 }
 
+void free_upcall_info(struct clnt_upcall_info *info)
+{
+	gssd_free_client(info->clp);
+	free(info);
+}
+
 /* For each upcall read the upcall info into the buffer, then create a
  * thread in a detached state so that resources are released back into
  * the system without the need for a join.
@@ -438,13 +472,13 @@ gssd_clnt_gssd_cb(int UNUSED(fd), short UNUSED(which), void *data)
 	info->lbuflen = read(clp->gssd_fd, info->lbuf, sizeof(info->lbuf));
 	if (info->lbuflen <= 0 || info->lbuf[info->lbuflen-1] != '\n') {
 		printerr(0, "WARNING: %s: failed reading request\n", __func__);
-		free(info);
+		free_upcall_info(info);
 		return;
 	}
 	info->lbuf[info->lbuflen-1] = 0;
 
 	if (start_upcall_thread(handle_gssd_upcall, info))
-		free(info);
+		free_upcall_info(info);
 }
 
 static void
@@ -461,12 +495,12 @@ gssd_clnt_krb5_cb(int UNUSED(fd), short UNUSED(which), void *data)
 			sizeof(info->uid)) < (ssize_t)sizeof(info->uid)) {
 		printerr(0, "WARNING: %s: failed reading uid from krb5 "
 			 "upcall pipe: %s\n", __func__, strerror(errno));
-		free(info);
+		free_upcall_info(info);
 		return;
 	}
 
 	if (start_upcall_thread(handle_krb5_upcall, info))
-		free(info);
+		free_upcall_info(info);
 }
 
 static struct clnt_info *
@@ -501,6 +535,7 @@ gssd_get_clnt(struct topdir *tdi, const char *name)
 	clp->name = clp->relpath + strlen(tdi->name) + 1;
 	clp->krb5_fd = -1;
 	clp->gssd_fd = -1;
+	clp->refcount = 1;
 
 	TAILQ_INSERT_HEAD(&tdi->clnt_list, clp, list);
 	return clp;
@@ -651,7 +686,7 @@ gssd_scan_topdir(const char *name)
 		if (clp->scanned)
 			continue;
 
-		printerr(3, "destroying client %s\n", clp->relpath);
+		printerr(3, "orphaned client %s\n", clp->relpath);
 		saveprev = clp->list.tqe_prev;
 		TAILQ_REMOVE(&tdi->clnt_list, clp, list);
 		gssd_destroy_client(clp);
diff --git a/utils/gssd/gssd.h b/utils/gssd/gssd.h
index f4f59754..d33e4dff 100644
--- a/utils/gssd/gssd.h
+++ b/utils/gssd/gssd.h
@@ -63,12 +63,10 @@ extern unsigned int 		context_timeout;
 extern unsigned int rpc_timeout;
 extern char			*preferred_realm;
 extern pthread_mutex_t ple_lock;
-extern pthread_cond_t pcond;
-extern pthread_mutex_t pmutex;
-extern int thread_started;
 
 struct clnt_info {
 	TAILQ_ENTRY(clnt_info)	list;
+	int			refcount;
 	int			wd;
 	bool			scanned;
 	char			*name;
@@ -94,6 +92,7 @@ struct clnt_upcall_info {
 
 void handle_krb5_upcall(struct clnt_upcall_info *clp);
 void handle_gssd_upcall(struct clnt_upcall_info *clp);
+void free_upcall_info(struct clnt_upcall_info *info);
 
 
 #endif /* _RPC_GSSD_H_ */
diff --git a/utils/gssd/gssd_proc.c b/utils/gssd/gssd_proc.c
index 8fe6605b..05c1da64 100644
--- a/utils/gssd/gssd_proc.c
+++ b/utils/gssd/gssd_proc.c
@@ -730,7 +730,7 @@ handle_krb5_upcall(struct clnt_upcall_info *info)
 	printerr(2, "\n%s: uid %d (%s)\n", __func__, info->uid, clp->relpath);
 
 	process_krb5_upcall(clp, info->uid, clp->krb5_fd, NULL, NULL, NULL);
-	free(info);
+	free_upcall_info(info);
 }
 
 void
@@ -830,6 +830,6 @@ handle_gssd_upcall(struct clnt_upcall_info *info)
 out:
 	free(upcall_str);
 out_nomem:
-	free(info);
+	free_upcall_info(info);
 	return;
 }
-- 
2.26.2

