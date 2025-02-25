Return-Path: <linux-nfs+bounces-10348-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E63CA44F25
	for <lists+linux-nfs@lfdr.de>; Tue, 25 Feb 2025 22:46:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 035AC1898CC0
	for <lists+linux-nfs@lfdr.de>; Tue, 25 Feb 2025 21:46:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B15CA3209;
	Tue, 25 Feb 2025 21:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B15WYxMR"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB5791C860C
	for <linux-nfs@vger.kernel.org>; Tue, 25 Feb 2025 21:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740519980; cv=none; b=al386zJqqGRmsAdX3+BOu35mCA0+OYuYRCoX1x8g33I/pC1OI+I3oJpOdcEbJeyYCRH3LyrP8kgKufyc3iRZr5ZNkDSV6D1ULDw+MDBSt896r2m7FbUwjDhISvQg6yOmQiDnKCLIWumyVMFRaICs1Ql87/5wZkflYZ1qpSixuLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740519980; c=relaxed/simple;
	bh=O7PkOBq5ogC5mVzTjoZU+cByussiFO7S9FKfPJy+Qlg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sa2j/dlnWWLE4QZrXg8r7iKAQlYWZgrQd64FLGBbV84BBsGb2ENBuBWQCIXJmIl948Ixj5/kBFO9Wz38XLaxyEdyIu6kyilhM/woSUhuOwbl7oafCD3Wjkws66p1otjQVqmAulscLO8UkM6DoCG/IccRgtV4jj+SQ/8A2xkSr6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=B15WYxMR; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740519977;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aK8edOGSBnvm+xwGhXSX/X0+bvFvkck0MCMhl1Rkq28=;
	b=B15WYxMR95FGCDTeXxlHaZEs89XB2JtwDLmELkSF1EpbX+7BFzquP/KmKwenbkfoe4u+UD
	YMI+5TDu8XM2VJ6WUDZyTlxTgkJCjYVxhuOiUD9jTuc7mutfR/0QcB1xfwpFXJLXlBNjvr
	uihiuUBIZcdaavF09/fH0FsOWaXW/mw=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-627-slFeUiXEOzevjZrPutRTFw-1; Tue,
 25 Feb 2025 16:46:15 -0500
X-MC-Unique: slFeUiXEOzevjZrPutRTFw-1
X-Mimecast-MFC-AGG-ID: slFeUiXEOzevjZrPutRTFw_1740519975
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2AEA8193578F
	for <linux-nfs@vger.kernel.org>; Tue, 25 Feb 2025 21:46:15 +0000 (UTC)
Received: from okorniev-mac.redhat.com (unknown [10.22.82.53])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 54B101800357;
	Tue, 25 Feb 2025 21:46:14 +0000 (UTC)
From: Olga Kornievskaia <okorniev@redhat.com>
To: steved@redhat.com
Cc: linux-nfs@vger.kernel.org,
	Olga Kornievskaia <okorniev@redhat.com>
Subject: [PATCH 2/2] nfs-utils: gssd: do not use krb5_cc_initialize
Date: Tue, 25 Feb 2025 16:46:07 -0500
Message-Id: <20250225214607.20449-3-okorniev@redhat.com>
In-Reply-To: <20250225214607.20449-1-okorniev@redhat.com>
References: <20250225214607.20449-1-okorniev@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

When gssd refreshes machine credentials, it uses the
krb5_get_init_creds_keytab() and then to save the received credentials
in a ticket cache, it proceeds to initialize the credential cache via
a krb5_cc_initialize() before storing the received credentials into it.

krb5_cc_initialize() is not concurrency safe. two gssd upcalls by
uid=0, one for krb5i auth flavor and another for krb5p, would enter
into krb5_cc_initialize() and one of them would fail, leading to
an upcall failure and NFS operation error.

Instead it was proposed that gssd changes its design to do what
kinit does and forgo the use of krb5_cc_initialize and instead setup
the output cache via krb5_get_init_creds_opt_set_out_cache() prior
to calling krb5_get_init_creds_keytab() which would then store
credentials automatically.

https://mailman.mit.edu/pipermail/krbdev/2025-February/013708.html

Signed-off-by: Olga Kornievskaia <okorniev@redhat.com>
---
 utils/gssd/krb5_util.c | 103 ++++++++++++++++++++---------------------
 1 file changed, 50 insertions(+), 53 deletions(-)

diff --git a/utils/gssd/krb5_util.c b/utils/gssd/krb5_util.c
index 201585ed..560e8be1 100644
--- a/utils/gssd/krb5_util.c
+++ b/utils/gssd/krb5_util.c
@@ -168,7 +168,8 @@ static int select_krb5_ccache(const struct dirent *d);
 static int gssd_find_existing_krb5_ccache(uid_t uid, char *dirname,
 		const char **cctype, struct dirent **d);
 static int gssd_get_single_krb5_cred(krb5_context context,
-		krb5_keytab kt, struct gssd_k5_kt_princ *ple, int force_renew);
+		krb5_keytab kt, struct gssd_k5_kt_princ *ple, int force_renew,
+		krb5_ccache ccache);
 static int query_krb5_ccache(const char* cred_cache, char **ret_princname,
 		char **ret_realm);
 
@@ -395,16 +396,14 @@ static int
 gssd_get_single_krb5_cred(krb5_context context,
 			  krb5_keytab kt,
 			  struct gssd_k5_kt_princ *ple,
-			  int force_renew)
+			  int force_renew,
+			  krb5_ccache ccache)
 {
 	krb5_get_init_creds_opt *opts = NULL;
 	krb5_creds my_creds;
-	krb5_ccache ccache = NULL;
 	char kt_name[BUFSIZ];
-	char cc_name[BUFSIZ];
 	int code;
 	time_t now = time(0);
-	char *cache_type;
 	char *pname = NULL;
 	char *k5err = NULL;
 	int nocache = 0;
@@ -457,6 +456,14 @@ gssd_get_single_krb5_cred(krb5_context context,
 	krb5_get_init_creds_opt_set_tkt_life(opts, 5*60);
 #endif
 
+	if ((code = krb5_get_init_creds_opt_set_out_ccache(context, opts,
+							   ccache))) {
+		k5err = gssd_k5_err_msg(context, code);
+		printerr(1, "WARNING: %s while initializing ccache for "
+			 "principal '%s' using keytab '%s'\n", k5err,
+			 pname ? pname : "<unparsable>", kt_name);
+		goto out;
+	}
 	if ((code = krb5_get_init_creds_keytab(context, &my_creds, ple->princ,
 					       kt, 0, NULL, opts))) {
 		k5err = gssd_k5_err_msg(context, code);
@@ -466,61 +473,18 @@ gssd_get_single_krb5_cred(krb5_context context,
 		goto out;
 	}
 
-	/*
-	 * Initialize cache file which we're going to be using
-	 */
-
 	pthread_mutex_lock(&ple_lock);
-	if (use_memcache)
-	    cache_type = "MEMORY";
-	else
-	    cache_type = "FILE";
-	snprintf(cc_name, sizeof(cc_name), "%s:%s/%s%s_%s",
-		cache_type,
-		ccachesearch[0], GSSD_DEFAULT_CRED_PREFIX,
-		GSSD_DEFAULT_MACHINE_CRED_SUFFIX, ple->realm);
 	ple->endtime = my_creds.times.endtime;
-	if (ple->ccname == NULL || strcmp(ple->ccname, cc_name) != 0) {
-		free(ple->ccname);
-		ple->ccname = strdup(cc_name);
-		if (ple->ccname == NULL) {
-			printerr(0, "ERROR: no storage to duplicate credentials "
-				    "cache name '%s'\n", cc_name);
-			code = ENOMEM;
-			pthread_mutex_unlock(&ple_lock);
-			goto out;
-		}
-	}
 	pthread_mutex_unlock(&ple_lock);
-	if ((code = krb5_cc_resolve(context, cc_name, &ccache))) {
-		k5err = gssd_k5_err_msg(context, code);
-		printerr(0, "ERROR: %s while opening credential cache '%s'\n",
-			 k5err, cc_name);
-		goto out;
-	}
-	if ((code = krb5_cc_initialize(context, ccache, ple->princ))) {
-		k5err = gssd_k5_err_msg(context, code);
-		printerr(0, "ERROR: %s while initializing credential "
-			 "cache '%s'\n", k5err, cc_name);
-		goto out;
-	}
-	if ((code = krb5_cc_store_cred(context, ccache, &my_creds))) {
-		k5err = gssd_k5_err_msg(context, code);
-		printerr(0, "ERROR: %s while storing credentials in '%s'\n",
-			 k5err, cc_name);
-		goto out;
-	}
 
 	code = 0;
-	printerr(2, "%s(0x%lx): principal '%s' ccache:'%s'\n", 
-		__func__, tid, pname, cc_name);
+	printerr(2, "%s(0x%lx): principal '%s' ccache:'%s'\n",
+		__func__, tid, pname, ple->ccname);
   out:
 	if (opts)
 		krb5_get_init_creds_opt_free(context, opts);
 	if (pname)
 		k5_free_unparsed_name(context, pname);
-	if (ccache)
-		krb5_cc_close(context, ccache);
 	krb5_free_cred_contents(context, &my_creds);
 	free(k5err);
 	return (code);
@@ -1147,10 +1111,12 @@ gssd_refresh_krb5_machine_credential_internal(char *hostname,
 {
 	krb5_error_code code = 0;
 	krb5_context context;
-	krb5_keytab kt = NULL;;
+	krb5_keytab kt = NULL;
+	krb5_ccache ccache = NULL;
 	int retval = 0;
-	char *k5err = NULL;
+	char *k5err = NULL, *cache_type;
 	const char *svcnames[] = { "$", "root", "nfs", "host", NULL };
+	char cc_name[BUFSIZ];
 
 	/*
 	 * If a specific service name was specified, use it.
@@ -1209,7 +1175,38 @@ gssd_refresh_krb5_machine_credential_internal(char *hostname,
 			goto out_free_kt;
 		}
 	}
-	retval = gssd_get_single_krb5_cred(context, kt, ple, force_renew);
+
+	if (use_memcache)
+		cache_type = "MEMORY";
+	else
+		cache_type = "FILE";
+	snprintf(cc_name, sizeof(cc_name), "%s:%s/%s%s_%s",
+		 cache_type,
+		 ccachesearch[0], GSSD_DEFAULT_CRED_PREFIX,
+		 GSSD_DEFAULT_MACHINE_CRED_SUFFIX, ple->realm);
+
+	pthread_mutex_lock(&ple_lock);
+	if (ple->ccname == NULL || strcmp(ple->ccname, cc_name) != 0) {
+		free(ple->ccname);
+		ple->ccname = strdup(cc_name);
+		if (ple->ccname == NULL) {
+			printerr(0, "ERROR: no storage to duplicate credentials "
+				    "cache name '%s'\n", cc_name);
+			code = ENOMEM;
+			pthread_mutex_unlock(&ple_lock);
+			goto out_free_kt;
+		}
+	}
+	pthread_mutex_unlock(&ple_lock);
+	if ((code = krb5_cc_resolve(context, cc_name, &ccache))) {
+		k5err = gssd_k5_err_msg(context, code);
+		printerr(0, "ERROR: %s while opening credential cache '%s'\n",
+			 k5err, cc_name);
+		goto out_free_kt;
+	}
+
+	retval = gssd_get_single_krb5_cred(context, kt, ple, force_renew, ccache);
+	krb5_cc_close(context, ccache);
 out_free_kt:
 	krb5_kt_close(context, kt);
 out_free_context:
-- 
2.47.1


