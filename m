Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7250C2112B4
	for <lists+linux-nfs@lfdr.de>; Wed,  1 Jul 2020 20:28:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732932AbgGAS2P (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 1 Jul 2020 14:28:15 -0400
Received: from ny018.relay.arandomserver.com ([172.96.188.180]:40975 "EHLO
        ny018.relay.arandomserver.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732911AbgGAS2N (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 1 Jul 2020 14:28:13 -0400
Received: from nyc006.hawkhost.com ([172.96.186.142])
        by se004.arandomserver.com with esmtps (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.92)
        (envelope-from <nazard@nazar.ca>)
        id 1jqhSr-0007Xx-4O
        for linux-nfs@vger.kernel.org; Wed, 01 Jul 2020 13:28:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nazar.ca;
         s=default; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=tJtgcxn2WLnlRoJEpZV1QI88BoE9fHL4hkO1OhATZw4=; b=DBAEIsJrJvtxVdx28AyYbQZ6Dy
        8bY334AQWvZWDjmryn1qvmPLCQOFn9yKVAPQffYOTsHCydYVc+6sh2SWACipjjnnqg654cCloheAo
        pNSCDKHHuYTwgCQ6a/qk2dqUNmS7PFYL6uN5K79O6qiS/Zj26DHXh+wGaKLfDb4z8myHEaAabdWLM
        LxyHA9vLBEkAPoPsK7xaC9AuBvwinnScgD6rNNm8VC1MwSTallYy03Sv8XKJDGxMyBkCDDG8k7Imi
        GwCIdBDquc7GLcIumhWMos7Uk2Qf6/TvFJFx5ru0qi6c9artrYyhQDtBFVlc4O22kiG3k+peDwiWm
        mHjRblsQ==;
Received: from [174.119.114.224] (port=43594 helo=wraith.dragoninc.ca)
        by nyc006.hawkhost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <nazard@nazar.ca>)
        id 1jqhSq-0003Oc-SS
        for linux-nfs@vger.kernel.org; Wed, 01 Jul 2020 14:28:08 -0400
From:   Doug Nazar <nazard@nazar.ca>
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 05/10] gssd: Fix locking for machine principal list
Date:   Wed,  1 Jul 2020 14:27:56 -0400
Message-Id: <20200701182803.14947-6-nazard@nazar.ca>
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
X-SpamExperts-Outgoing-Evidence: SB/global_tokens (0.000116780796775)
X-Recommended-Action: accept
X-Filter-ID: Mvzo4OR0dZXEDF/gcnlw0f6LF1GdvkEexklpcFpSF5apSDasLI4SayDByyq9LIhVOzAGdtonuilX
 Asy+5f+fcETNWdUk1Ol2OGx3IfrIJKywOmJyM1qr8uRnWBrbSAGDoHt0IcOGwKCbMuu8Bh1PoO2W
 aaJF459Au8f7ARCz5dIGnw3fnBVwbANSDXCAm7gxi2sibrzdSn5PTXNogGonT3XpGCeulZALlD2V
 AvpAcEdNy48VCLWq/B04EaMIT1z9KJ9I7HJckiqd4uUgfyUDbi0mNlctu/ZLaOH13A3s9cVWgxmT
 epC+rmMtfXSN6UccbEYBdMHLz8fdZytxBPvQ/tfm/6ZhrBvMHqGRRS2yqrTz7IssKbNSm6Aylrz7
 vRRedYGRJ5j/qgI5gfjNk3Q1FcO1wjmeb9RCa+YI49T4kOuq00YljRCkN7s2SRETCBXfmpMlsQfU
 CJBMRaGGGXrzQwzEEJbreAQRsbSZZ9fXoUEifL76GD10kuo3nOZaoX+gsjENmEszkjZCjfYHwrdv
 NOzx52pqgFKULzmTh7lC+C1OB0fQQI8VICRbS6zGNgmk2+y1r/Jt2+QI0NYgZu+YDGDmnroh/8hH
 WR/Etfk4HCQTo4dLz8XEDoyijq2CEGKcGplHcpVCCoX989hgB8R+yHz6Wz8d/Pp/n7kUT3MNKWyV
 mI6ol8ojWV/XK6LQktrhnfswMR/axFVOdYi6ksE7I39nMre3YEbkuALmW8gN9RXH3DI0NOgo6/Ab
 vYB8YDlEEBksfbu9yLQMc7lcHkHFV/djzQ6YC7Heg3Xf7O1TOd4Lp6/mezP3/ta7RoBl7TSj8Cd1
 02D1/PxWBdanhqFXVM7CC2z6Dgs2SNe1BxOjU9hmQJDFHtRs+GS9wTn4jevFZjEa/sNl+vcoDGoY
 k0DAXQsuA+ZOE6ZCLBhP3Kw7GhP6DxWSEoQUnaVSVuR240Ewmn4rjkt/ing/Kst6lT+FgU1vUJm2
 lwcjBA1nf30dydyo/g58MkufxisELuuE3bZK19QhM8um7L9VndMW7hyljAQWfxYdU0gXE07BZ9Ya
 Ke+gc5LamkkGaPkiMxmyjA0L/Ub/yrYgxwwQmd72Iri+RjEvuGslKTrRIXcXpFg5ivY=
X-Report-Abuse-To: spam@se001.arandomserver.com
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Add missing locking for some scans of the global list. There was
also no prevention of ple->ccname being changed concurrently so
use the same lock to protect that. Reference counting was also added
to ensure that the ple is not freed out from under us in the few
places we now drop the lock while doing work.

Signed-off-by: Doug Nazar <nazard@nazar.ca>
---
 utils/gssd/gssd.h      |   1 -
 utils/gssd/gssd_proc.c |   2 +-
 utils/gssd/krb5_util.c | 294 ++++++++++++++++++++++++++---------------
 utils/gssd/krb5_util.h |  14 --
 4 files changed, 185 insertions(+), 126 deletions(-)

diff --git a/utils/gssd/gssd.h b/utils/gssd/gssd.h
index ae0355bb..1e8c58d4 100644
--- a/utils/gssd/gssd.h
+++ b/utils/gssd/gssd.h
@@ -62,7 +62,6 @@ extern int			root_uses_machine_creds;
 extern unsigned int 		context_timeout;
 extern unsigned int rpc_timeout;
 extern char			*preferred_realm;
-extern pthread_mutex_t ple_lock;
 
 struct clnt_info {
 	TAILQ_ENTRY(clnt_info)	list;
diff --git a/utils/gssd/gssd_proc.c b/utils/gssd/gssd_proc.c
index 05c1da64..addac318 100644
--- a/utils/gssd/gssd_proc.c
+++ b/utils/gssd/gssd_proc.c
@@ -548,7 +548,7 @@ krb5_use_machine_creds(struct clnt_info *clp, uid_t uid,
 		uid, tgtname);
 
 	do {
-		gssd_refresh_krb5_machine_credential(clp->servername, NULL,
+		gssd_refresh_krb5_machine_credential(clp->servername,
 						     service, srchost);
 	/*
 	 * Get a list of credential cache names and try each
diff --git a/utils/gssd/krb5_util.c b/utils/gssd/krb5_util.c
index b1e48241..7908c10f 100644
--- a/utils/gssd/krb5_util.c
+++ b/utils/gssd/krb5_util.c
@@ -130,9 +130,28 @@
 #include "gss_util.h"
 #include "krb5_util.h"
 
+/*
+ * List of principals from our keytab that we
+ * will try to use to obtain credentials
+ * (known as a principal list entry (ple))
+ */
+struct gssd_k5_kt_princ {
+	struct gssd_k5_kt_princ *next;
+	// Only protect against deletion, not modification
+	int refcount;
+	// Only set during creation in new_ple()
+	krb5_principal princ;
+	char *realm;
+	// Modified during usage by gssd_get_single_krb5_cred()
+	char *ccname;
+	krb5_timestamp endtime;
+};
+
+
 /* Global list of principals/cache file names for machine credentials */
-struct gssd_k5_kt_princ *gssd_k5_kt_princ_list = NULL;
-pthread_mutex_t ple_lock = PTHREAD_MUTEX_INITIALIZER;
+static struct gssd_k5_kt_princ *gssd_k5_kt_princ_list = NULL;
+/* This mutex protects list modification & ple->ccname */
+static pthread_mutex_t ple_lock = PTHREAD_MUTEX_INITIALIZER;
 
 #ifdef HAVE_SET_ALLOWABLE_ENCTYPES
 int limit_to_legacy_enctypes = 0;
@@ -150,6 +169,18 @@ static int gssd_get_single_krb5_cred(krb5_context context,
 static int query_krb5_ccache(const char* cred_cache, char **ret_princname,
 		char **ret_realm);
 
+static void release_ple(krb5_context context, struct gssd_k5_kt_princ *ple)
+{
+	if (--ple->refcount)
+		return;
+
+	printerr(3, "freeing cached principal (ccname=%s, realm=%s)\n", ple->ccname, ple->realm);
+	krb5_free_principal(context, ple->princ);
+	free(ple->ccname);
+	free(ple->realm);
+	free(ple);
+}
+
 /*
  * Called from the scandir function to weed out potential krb5
  * credentials cache files
@@ -377,12 +408,15 @@ gssd_get_single_krb5_cred(krb5_context context,
 	 * 300 because clock skew must be within 300sec for kerberos
 	 */
 	now += 300;
+	pthread_mutex_lock(&ple_lock);
 	if (ple->ccname && ple->endtime > now && !nocache) {
 		printerr(3, "INFO: Credentials in CC '%s' are good until %d\n",
 			 ple->ccname, ple->endtime);
 		code = 0;
+		pthread_mutex_unlock(&ple_lock);
 		goto out;
 	}
+	pthread_mutex_unlock(&ple_lock);
 
 	if ((code = krb5_kt_get_name(context, kt, kt_name, BUFSIZ))) {
 		printerr(0, "ERROR: Unable to get keytab name in "
@@ -435,6 +469,7 @@ gssd_get_single_krb5_cred(krb5_context context,
 	 * Initialize cache file which we're going to be using
 	 */
 
+	pthread_mutex_lock(&ple_lock);
 	if (use_memcache)
 	    cache_type = "MEMORY";
 	else
@@ -444,15 +479,18 @@ gssd_get_single_krb5_cred(krb5_context context,
 		ccachesearch[0], GSSD_DEFAULT_CRED_PREFIX,
 		GSSD_DEFAULT_MACHINE_CRED_SUFFIX, ple->realm);
 	ple->endtime = my_creds.times.endtime;
-	if (ple->ccname != NULL)
+	if (ple->ccname == NULL || strcmp(ple->ccname, cc_name) != 0) {
 		free(ple->ccname);
-	ple->ccname = strdup(cc_name);
-	if (ple->ccname == NULL) {
-		printerr(0, "ERROR: no storage to duplicate credentials "
-			    "cache name '%s'\n", cc_name);
-		code = ENOMEM;
-		goto out;
+		ple->ccname = strdup(cc_name);
+		if (ple->ccname == NULL) {
+			printerr(0, "ERROR: no storage to duplicate credentials "
+				    "cache name '%s'\n", cc_name);
+			code = ENOMEM;
+			pthread_mutex_unlock(&ple_lock);
+			goto out;
+		}
 	}
+	pthread_mutex_unlock(&ple_lock);
 	if ((code = krb5_cc_resolve(context, cc_name, &ccache))) {
 		k5err = gssd_k5_err_msg(context, code);
 		printerr(0, "ERROR: %s while opening credential cache '%s'\n",
@@ -490,6 +528,7 @@ gssd_get_single_krb5_cred(krb5_context context,
 
 /*
  * Given a principal, find a matching ple structure
+ * Called with mutex held
  */
 static struct gssd_k5_kt_princ *
 find_ple_by_princ(krb5_context context, krb5_principal princ)
@@ -506,6 +545,7 @@ find_ple_by_princ(krb5_context context, krb5_principal princ)
 
 /*
  * Create, initialize, and add a new ple structure to the global list
+ * Called with mutex held
  */
 static struct gssd_k5_kt_princ *
 new_ple(krb5_context context, krb5_principal princ)
@@ -557,6 +597,7 @@ new_ple(krb5_context context, krb5_principal princ)
 			p->next = ple;
 	}
 
+	ple->refcount = 1;
 	return ple;
 outerr:
 	if (ple) {
@@ -575,13 +616,14 @@ get_ple_by_princ(krb5_context context, krb5_principal princ)
 {
 	struct gssd_k5_kt_princ *ple;
 
-	/* Need to serialize list if we ever become multi-threaded! */
-
 	pthread_mutex_lock(&ple_lock);
 	ple = find_ple_by_princ(context, princ);
 	if (ple == NULL) {
 		ple = new_ple(context, princ);
 	}
+	if (ple != NULL) {
+		ple->refcount++;
+	}
 	pthread_mutex_unlock(&ple_lock);
 
 	return ple;
@@ -746,6 +788,8 @@ gssd_search_krb5_keytab(krb5_context context, krb5_keytab kt,
 				retval = ENOMEM;
 				k5_free_kt_entry(context, kte);
 			} else {
+				release_ple(context, ple);
+				ple = NULL;
 				retval = 0;
 				*found = 1;
 			}
@@ -1078,6 +1122,93 @@ err_cache:
 	return (*ret_princname && *ret_realm);
 }
 
+/*
+ * Obtain (or refresh if necessary) Kerberos machine credentials
+ * If a ple is passed in, it's reference will be released
+ */
+static int
+gssd_refresh_krb5_machine_credential_internal(char *hostname,
+				     struct gssd_k5_kt_princ *ple,
+				     char *service, char *srchost)
+{
+	krb5_error_code code = 0;
+	krb5_context context;
+	krb5_keytab kt = NULL;;
+	int retval = 0;
+	char *k5err = NULL;
+	const char *svcnames[] = { "$", "root", "nfs", "host", NULL };
+
+	printerr(2, "%s: hostname=%s ple=%p service=%s srchost=%s\n",
+		__func__, hostname, ple, service, srchost);
+
+	/*
+	 * If a specific service name was specified, use it.
+	 * Otherwise, use the default list.
+	 */
+	if (service != NULL && strcmp(service, "*") != 0) {
+		svcnames[0] = service;
+		svcnames[1] = NULL;
+	}
+	if (hostname == NULL && ple == NULL)
+		return EINVAL;
+
+	code = krb5_init_context(&context);
+	if (code) {
+		k5err = gssd_k5_err_msg(NULL, code);
+		printerr(0, "ERROR: %s: %s while initializing krb5 context\n",
+			 __func__, k5err);
+		retval = code;
+		goto out;
+	}
+
+	if ((code = krb5_kt_resolve(context, keytabfile, &kt))) {
+		k5err = gssd_k5_err_msg(context, code);
+		printerr(0, "ERROR: %s: %s while resolving keytab '%s'\n",
+			 __func__, k5err, keytabfile);
+		goto out_free_context;
+	}
+
+	if (ple == NULL) {
+		krb5_keytab_entry kte;
+
+		code = find_keytab_entry(context, kt, srchost, hostname,
+					 &kte, svcnames);
+		if (code) {
+			printerr(0, "ERROR: %s: no usable keytab entry found "
+				 "in keytab %s for connection with host %s\n",
+				 __FUNCTION__, keytabfile, hostname);
+			retval = code;
+			goto out_free_kt;
+		}
+
+		ple = get_ple_by_princ(context, kte.principal);
+		k5_free_kt_entry(context, &kte);
+		if (ple == NULL) {
+			char *pname;
+			if ((krb5_unparse_name(context, kte.principal, &pname))) {
+				pname = NULL;
+			}
+			printerr(0, "ERROR: %s: Could not locate or create "
+				 "ple struct for principal %s for connection "
+				 "with host %s\n",
+				 __FUNCTION__, pname ? pname : "<unparsable>",
+				 hostname);
+			if (pname) k5_free_unparsed_name(context, pname);
+			goto out_free_kt;
+		}
+	}
+	retval = gssd_get_single_krb5_cred(context, kt, ple, 0);
+out_free_kt:
+	krb5_kt_close(context, kt);
+out_free_context:
+	if (ple)
+		release_ple(context, ple);
+	krb5_free_context(context);
+out:
+	free(k5err);
+	return retval;
+}
+
 /*==========================*/
 /*===  External routines ===*/
 /*==========================*/
@@ -1171,37 +1302,56 @@ gssd_get_krb5_machine_cred_list(char ***list)
 		goto out;
 	}
 
-	/* Need to serialize list if we ever become multi-threaded! */
-
+	pthread_mutex_lock(&ple_lock);
 	for (ple = gssd_k5_kt_princ_list; ple; ple = ple->next) {
-		if (ple->ccname) {
-			/* Make sure cred is up-to-date before returning it */
-			retval = gssd_refresh_krb5_machine_credential(NULL, ple,
-								      NULL, NULL);
-			if (retval)
-				continue;
-			if (i + 1 > listsize) {
-				listsize += listinc;
-				l = (char **)
-					realloc(l, listsize * sizeof(char *));
-				if (l == NULL) {
-					retval = ENOMEM;
-					goto out;
-				}
-			}
-			if ((l[i++] = strdup(ple->ccname)) == NULL) {
+		if (!ple->ccname)
+			continue;
+
+		/* Take advantage of the fact we only remove the ple
+		 * from the list during shutdown. If it's modified
+		 * concurrently at worst we'll just miss a new entry
+		 * before the current ple
+		 *
+		 * gssd_refresh_krb5_machine_credential_internal() will
+		 * release the ple refcount
+		 */
+		ple->refcount++;
+		pthread_mutex_unlock(&ple_lock);
+		/* Make sure cred is up-to-date before returning it */
+		retval = gssd_refresh_krb5_machine_credential_internal(NULL, ple,
+								       NULL, NULL);
+		pthread_mutex_lock(&ple_lock);
+		if (gssd_k5_kt_princ_list == NULL) {
+			/* Looks like we did shutdown... abort */
+			l[i] = NULL;
+			gssd_free_krb5_machine_cred_list(l);
+			retval = ENOMEM;
+			goto out_lock;
+		}
+		if (retval)
+			continue;
+		if (i + 1 > listsize) {
+			listsize += listinc;
+			l = (char **)
+				realloc(l, listsize * sizeof(char *));
+			if (l == NULL) {
 				retval = ENOMEM;
-				goto out;
+				goto out_lock;
 			}
 		}
+		if ((l[i++] = strdup(ple->ccname)) == NULL) {
+			retval = ENOMEM;
+			goto out_lock;
+		}
 	}
 	if (i > 0) {
 		l[i] = NULL;
 		*list = l;
 		retval = 0;
-		goto out;
 	} else
 		free((void *)l);
+out_lock:
+	pthread_mutex_unlock(&ple_lock);
   out:
 	return retval;
 }
@@ -1266,10 +1416,7 @@ gssd_destroy_krb5_principals(int destroy_machine_creds)
 			}
 		}
 
-		krb5_free_principal(context, ple->princ);
-		free(ple->ccname);
-		free(ple->realm);
-		free(ple);
+		release_ple(context, ple);
 	}
 	pthread_mutex_unlock(&ple_lock);
 	krb5_free_context(context);
@@ -1280,83 +1427,10 @@ gssd_destroy_krb5_principals(int destroy_machine_creds)
  */
 int
 gssd_refresh_krb5_machine_credential(char *hostname,
-				     struct gssd_k5_kt_princ *ple, 
 				     char *service, char *srchost)
 {
-	krb5_error_code code = 0;
-	krb5_context context;
-	krb5_keytab kt = NULL;;
-	int retval = 0;
-	char *k5err = NULL;
-	const char *svcnames[] = { "$", "root", "nfs", "host", NULL };
-
-	printerr(2, "%s: hostname=%s ple=%p service=%s srchost=%s\n",
-		__func__, hostname, ple, service, srchost);
-
-	/*
-	 * If a specific service name was specified, use it.
-	 * Otherwise, use the default list.
-	 */
-	if (service != NULL && strcmp(service, "*") != 0) {
-		svcnames[0] = service;
-		svcnames[1] = NULL;
-	}
-	if (hostname == NULL && ple == NULL)
-		return EINVAL;
-
-	code = krb5_init_context(&context);
-	if (code) {
-		k5err = gssd_k5_err_msg(NULL, code);
-		printerr(0, "ERROR: %s: %s while initializing krb5 context\n",
-			 __func__, k5err);
-		retval = code;
-		goto out;
-	}
-
-	if ((code = krb5_kt_resolve(context, keytabfile, &kt))) {
-		k5err = gssd_k5_err_msg(context, code);
-		printerr(0, "ERROR: %s: %s while resolving keytab '%s'\n",
-			 __func__, k5err, keytabfile);
-		goto out_free_context;
-	}
-
-	if (ple == NULL) {
-		krb5_keytab_entry kte;
-
-		code = find_keytab_entry(context, kt, srchost, hostname,
-					 &kte, svcnames);
-		if (code) {
-			printerr(0, "ERROR: %s: no usable keytab entry found "
-				 "in keytab %s for connection with host %s\n",
-				 __FUNCTION__, keytabfile, hostname);
-			retval = code;
-			goto out_free_kt;
-		}
-
-		ple = get_ple_by_princ(context, kte.principal);
-		k5_free_kt_entry(context, &kte);
-		if (ple == NULL) {
-			char *pname;
-			if ((krb5_unparse_name(context, kte.principal, &pname))) {
-				pname = NULL;
-			}
-			printerr(0, "ERROR: %s: Could not locate or create "
-				 "ple struct for principal %s for connection "
-				 "with host %s\n",
-				 __FUNCTION__, pname ? pname : "<unparsable>",
-				 hostname);
-			if (pname) k5_free_unparsed_name(context, pname);
-			goto out_free_kt;
-		}
-	}
-	retval = gssd_get_single_krb5_cred(context, kt, ple, 0);
-out_free_kt:
-	krb5_kt_close(context, kt);
-out_free_context:
-	krb5_free_context(context);
-out:
-	free(k5err);
-	return retval;
+    return gssd_refresh_krb5_machine_credential_internal(hostname, NULL,
+							 service, srchost);
 }
 
 /*
diff --git a/utils/gssd/krb5_util.h b/utils/gssd/krb5_util.h
index e127cc84..2415205a 100644
--- a/utils/gssd/krb5_util.h
+++ b/utils/gssd/krb5_util.h
@@ -9,19 +9,6 @@
 #include "gss_oids.h"
 #endif
 
-/*
- * List of principals from our keytab that we
- * will try to use to obtain credentials
- * (known as a principal list entry (ple))
- */
-struct gssd_k5_kt_princ {
-	struct gssd_k5_kt_princ *next;
-	krb5_principal princ;
-	char *ccname;
-	char *realm;
-	krb5_timestamp endtime;
-};
-
 
 int gssd_setup_krb5_user_gss_ccache(uid_t uid, char *servername,
 				     char *dirname);
@@ -29,7 +16,6 @@ int  gssd_get_krb5_machine_cred_list(char ***list);
 void gssd_free_krb5_machine_cred_list(char **list);
 void gssd_destroy_krb5_principals(int destroy_machine_creds);
 int  gssd_refresh_krb5_machine_credential(char *hostname,
-					  struct gssd_k5_kt_princ *ple, 
 					  char *service, char *srchost);
 char *gssd_k5_err_msg(krb5_context context, krb5_error_code code);
 void gssd_k5_get_default_realm(char **def_realm);
-- 
2.26.2

