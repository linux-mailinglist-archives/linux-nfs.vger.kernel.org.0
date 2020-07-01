Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E89842112AE
	for <lists+linux-nfs@lfdr.de>; Wed,  1 Jul 2020 20:28:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728586AbgGAS2M (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 1 Jul 2020 14:28:12 -0400
Received: from ny018.relay.arandomserver.com ([172.96.188.180]:40159 "EHLO
        ny018.relay.arandomserver.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732891AbgGAS2M (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 1 Jul 2020 14:28:12 -0400
Received: from nyc006.hawkhost.com ([172.96.186.142])
        by se004.arandomserver.com with esmtps (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.92)
        (envelope-from <nazard@nazar.ca>)
        id 1jqhSq-0007XN-MW
        for linux-nfs@vger.kernel.org; Wed, 01 Jul 2020 13:28:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nazar.ca;
         s=default; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=makIRtyyQRiEFPQXgKNeRHxEjRir5TVeRJPQFQ2pYrg=; b=mGCZUACNinWH4Yl6GARX1N1W1a
        ZWbJH5VHhsE9fid5/BB+di0PM4BbmY20hWT87TaieJNRKS7j0d/azSsXaNtm9UWbYjiqKUJSrbTE5
        OCjsb8x5pZHq1SHVndtyhKaIN8xQH+tZ/EQ61YAXUDZfSzl1m+LtbSmAwizGRTUckQqRZIHtPmiOo
        k4v1M0RCWb26N3BIejBJ9SI5WN5ad1F3AG0MfrkmY/HAfi/Y3iCszYbyTbNuDFdqfCTFHG7/vzM3j
        ajrxjyof5TaJdyoio/sWTGg3zzC6ewk/wNYb5LrY1K5XyxP9MXatT02RxhsKi3s7g13R1GMdZ8oJy
        +/h+X8Eg==;
Received: from [174.119.114.224] (port=43594 helo=wraith.dragoninc.ca)
        by nyc006.hawkhost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <nazard@nazar.ca>)
        id 1jqhSq-0003Oc-Gk
        for linux-nfs@vger.kernel.org; Wed, 01 Jul 2020 14:28:08 -0400
From:   Doug Nazar <nazard@nazar.ca>
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 03/10] gssd: Cleanup on exit to support valgrind.
Date:   Wed,  1 Jul 2020 14:27:54 -0400
Message-Id: <20200701182803.14947-4-nazard@nazar.ca>
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
X-SpamExperts-Outgoing-Evidence: SB/global_tokens (0.000620416882963)
X-Recommended-Action: accept
X-Filter-ID: Mvzo4OR0dZXEDF/gcnlw0f6LF1GdvkEexklpcFpSF5apSDasLI4SayDByyq9LIhVEydl3tCI1sk5
 tvCV/LubpETNWdUk1Ol2OGx3IfrIJKywOmJyM1qr8uRnWBrbSAGDoHt0IcOGwKCbMuu8Bh1PoO2W
 aaJF459Au8f7ARCz5dKx9FdTKiy7OeswhZp5MHAOngqo6HTfPcmeXUhusULdbHXpGCeulZALlD2V
 AvpAcEdNy48VCLWq/B04EaMIT1z9KJ9I7HJckiqd4uUgfyUDbi0mNlctu/ZLaOH13A3s9cVWgxmT
 epC+rmMtfXSN6UccbEYBdMHLz8fdZytxBPvQ/tfm/6ZhrBvMHqGRRS2yqrTz7IssKbNSm6Aylrz7
 vRRedYGRJ5j/qgI5gfjNk3Q1FcO1wjmeb9RCa+YI49T4kOuq00YljRCkN7s2SRETCBXfmpMlsQfU
 CJBMRaGGGXrzQwzEEJbreAQRsbSZZ9fXoUEifL76GD10kuo3nOZaoX+gsjENmEszkjZCjfYHwrdv
 NOzx52pqgFKULzmTh7lC+C1OB0fQQI8VICRbS6zGNgmk2+y1r/Jt2+QI0NYgZu+YDGDmnroh/8hH
 WR/Etfk4HCQTo4dLz8XEDoyijq2CEGKcGplHcpVCCoX989hgB8R+yHz6Wz8d/Pp/n7kUT3MNKWyV
 mI6ol8ojWV/XK6LQktrhhtH8/hSNjvdRHIsKlL+W/n9nMre3YEbkuALmW8gN9RXH3DI0NOgo6/Ab
 vYB8YDlEEBksfbu9yLQMc7lcHkHFV/djzQ6YC7Heg3Xf7O1TOd4Lp6/mezP3/ta7RoBl7TSj8Cd1
 02D1/PxWBdanhqFXVGIDtlyyGhtxMdqa3CaFDS3PACAxjVpvW3oFn0Fi2vFlZjEa/sNl+vcoDGoY
 k0DAXQsuA+ZOE6ZCLBhP3Kw7GhP6DxWSEoQUnaVSVuR240Ewmn4rjkt/ing/Kst6lT+FgU1vUJm2
 lwcjBA1nf30dydyo/g58MkufxisELuuE3bZK19QhM8um7L9VndMW7hyljAQWfxYdU0gXE07BZ9Ya
 Ke+gc5LamkkGaPkiMxmyjA0L/Ub/yrYgxwwQmd72Iri+RjEvuGslKTrRIXcXpFg5ivY=
X-Report-Abuse-To: spam@se001.arandomserver.com
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Signed-off-by: Doug Nazar <nazard@nazar.ca>
---
 utils/gssd/gssd.c      | 46 +++++++++++++++++++++++++++++++------
 utils/gssd/krb5_util.c | 52 ++++++++++++++++++++++++------------------
 utils/gssd/krb5_util.h |  2 +-
 3 files changed, 70 insertions(+), 30 deletions(-)

diff --git a/utils/gssd/gssd.c b/utils/gssd/gssd.c
index f8f21f74..54d9b5de 100644
--- a/utils/gssd/gssd.c
+++ b/utils/gssd/gssd.c
@@ -91,6 +91,7 @@ char *ccachedir = NULL;
 static bool avoid_dns = true;
 static bool use_gssproxy = false;
 pthread_mutex_t clp_lock = PTHREAD_MUTEX_INITIALIZER;
+static bool signal_received = false;
 static struct event_base *evbase = NULL;
 
 TAILQ_HEAD(topdir_list_head, topdir) topdir_list;
@@ -872,10 +873,16 @@ found:
 static void
 sig_die(int signal)
 {
-	if (root_uses_machine_creds)
-		gssd_destroy_krb5_machine_creds();
+	if (signal_received)
+	{
+		gssd_destroy_krb5_principals(root_uses_machine_creds);
+		printerr(1, "forced exiting on signal %d\n", signal);
+		exit(0);
+	}
+
+	signal_received = true;
 	printerr(1, "exiting on signal %d\n", signal);
-	exit(0);
+	event_base_loopexit(evbase, NULL);
 }
 
 static void
@@ -932,6 +939,7 @@ main(int argc, char *argv[])
 	int rpc_verbosity = 0;
 	int opt;
 	int i;
+	int rc;
 	extern char *optarg;
 	char *progname;
 	struct event *sighup_ev;
@@ -1109,9 +1117,33 @@ main(int argc, char *argv[])
 	gssd_scan();
 	daemon_ready();
 
-	event_base_dispatch(evbase);
+	rc = event_base_dispatch(evbase);
 
-	printerr(0, "ERROR: event_dispatch() returned!\n");
-	return EXIT_FAILURE;
-}
+	printerr(0, "event_dispatch() returned %i!\n", rc);
 
+	gssd_destroy_krb5_principals(root_uses_machine_creds);
+
+	while (!TAILQ_EMPTY(&topdir_list)) {
+		struct topdir *tdi = TAILQ_FIRST(&topdir_list);
+		TAILQ_REMOVE(&topdir_list, tdi, list);
+		while (!TAILQ_EMPTY(&tdi->clnt_list)) {
+			struct clnt_info *clp = TAILQ_FIRST(&tdi->clnt_list);
+			TAILQ_REMOVE(&tdi->clnt_list, clp, list);
+			gssd_destroy_client(clp);
+		}
+		free(tdi);
+	}
+
+	event_free(inotify_ev);
+	event_free(sighup_ev);
+	event_base_free(evbase);
+
+	close(inotify_fd);
+	close(pipefs_fd);
+	closedir(pipefs_dir);
+
+	free(preferred_realm);
+	free(ccachesearch);
+
+	return rc < 0 ? EXIT_FAILURE : EXIT_SUCCESS;
+}
diff --git a/utils/gssd/krb5_util.c b/utils/gssd/krb5_util.c
index 8c73748c..c49c6672 100644
--- a/utils/gssd/krb5_util.c
+++ b/utils/gssd/krb5_util.c
@@ -1226,7 +1226,7 @@ gssd_free_krb5_machine_cred_list(char **list)
  * Called upon exit.  Destroys machine credentials.
  */
 void
-gssd_destroy_krb5_machine_creds(void)
+gssd_destroy_krb5_principals(int destroy_machine_creds)
 {
 	krb5_context context;
 	krb5_error_code code = 0;
@@ -1238,33 +1238,41 @@ gssd_destroy_krb5_machine_creds(void)
 	if (code) {
 		k5err = gssd_k5_err_msg(NULL, code);
 		printerr(0, "ERROR: %s while initializing krb5\n", k5err);
-		goto out;
+		free(k5err);
+		return;
 	}
 
-	for (ple = gssd_k5_kt_princ_list; ple; ple = ple->next) {
-		if (!ple->ccname)
-			continue;
-		if ((code = krb5_cc_resolve(context, ple->ccname, &ccache))) {
-			k5err = gssd_k5_err_msg(context, code);
-			printerr(0, "WARNING: %s while resolving credential "
-				    "cache '%s' for destruction\n", k5err,
-				    ple->ccname);
-			krb5_free_string(context, k5err);
-			k5err = NULL;
-			continue;
-		}
+	pthread_mutex_lock(&ple_lock);
+	while (gssd_k5_kt_princ_list) {
+		ple = gssd_k5_kt_princ_list;
+		gssd_k5_kt_princ_list = ple->next;
 
-		if ((code = krb5_cc_destroy(context, ccache))) {
-			k5err = gssd_k5_err_msg(context, code);
-			printerr(0, "WARNING: %s while destroying credential "
-				    "cache '%s'\n", k5err, ple->ccname);
-			krb5_free_string(context, k5err);
-			k5err = NULL;
+		if (destroy_machine_creds && ple->ccname) {
+			if ((code = krb5_cc_resolve(context, ple->ccname, &ccache))) {
+				k5err = gssd_k5_err_msg(context, code);
+				printerr(0, "WARNING: %s while resolving credential "
+					    "cache '%s' for destruction\n", k5err,
+					    ple->ccname);
+				free(k5err);
+				k5err = NULL;
+			}
+
+			if (!code && (code = krb5_cc_destroy(context, ccache))) {
+				k5err = gssd_k5_err_msg(context, code);
+				printerr(0, "WARNING: %s while destroying credential "
+					    "cache '%s'\n", k5err, ple->ccname);
+				free(k5err);
+				k5err = NULL;
+			}
 		}
+
+		krb5_free_principal(context, ple->princ);
+		free(ple->ccname);
+		free(ple->realm);
+		free(ple);
 	}
+	pthread_mutex_unlock(&ple_lock);
 	krb5_free_context(context);
-  out:
-	krb5_free_string(context, k5err);
 }
 
 /*
diff --git a/utils/gssd/krb5_util.h b/utils/gssd/krb5_util.h
index b000b444..e127cc84 100644
--- a/utils/gssd/krb5_util.h
+++ b/utils/gssd/krb5_util.h
@@ -27,7 +27,7 @@ int gssd_setup_krb5_user_gss_ccache(uid_t uid, char *servername,
 				     char *dirname);
 int  gssd_get_krb5_machine_cred_list(char ***list);
 void gssd_free_krb5_machine_cred_list(char **list);
-void gssd_destroy_krb5_machine_creds(void);
+void gssd_destroy_krb5_principals(int destroy_machine_creds);
 int  gssd_refresh_krb5_machine_credential(char *hostname,
 					  struct gssd_k5_kt_princ *ple, 
 					  char *service, char *srchost);
-- 
2.26.2

