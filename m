Return-Path: <linux-nfs+bounces-372-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 347A0807A83
	for <lists+linux-nfs@lfdr.de>; Wed,  6 Dec 2023 22:33:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D94041F21A3C
	for <lists+linux-nfs@lfdr.de>; Wed,  6 Dec 2023 21:33:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84E3A7097A;
	Wed,  6 Dec 2023 21:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XeMaQGm8"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B34BBD4B
	for <linux-nfs@vger.kernel.org>; Wed,  6 Dec 2023 13:33:36 -0800 (PST)
Received: by mail-qk1-x732.google.com with SMTP id af79cd13be357-77f3c8fb126so1124585a.0
        for <linux-nfs@vger.kernel.org>; Wed, 06 Dec 2023 13:33:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701898416; x=1702503216; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0OGTR2attaRq9HgZ/r5yNcQl5SlG230w3Em/r6CZfd4=;
        b=XeMaQGm8J594oEnYq03l706YGzQAwQdS3kPR5DpDbi2triWm50r9AgU78HG+Z4AUql
         cfr0jiyUJYqKXUtpY1PguFYOCfsn/0U+T5Ewo1iag8Q4E1U5KRQj89A0hEoNQHK/MC7B
         4ZdfcWH0dFu6XQ5VZOkQ0EBtVcI2ZrWOD0IRCwE+DYLgREfY5jzgRtPaaYC6JIGo7yTY
         wrXL3RuK2ttq7UKShsNWDAkHbGEtPGp/dnhLxyXIzYiYeK7r1T0JjOLblVw5lz0NXt7N
         dpyew92dtVfHBteO9SGvUXIyX7IRdX7BbFZYsthnC5dQBk8xw6s0NAM2gC0+P0pCoOXu
         pU1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701898416; x=1702503216;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0OGTR2attaRq9HgZ/r5yNcQl5SlG230w3Em/r6CZfd4=;
        b=CjFGy9hmxpVr4exESTl35A1wh7TunS3bbseXae8cm1+mOd9f8S3TAYtG5l4J0iMKpo
         DbpIwJzgsVT/2w9IvXoFhCqwjw5WHcJUT4jOAqwbwwDaNuLoT37C8UsU2LGJ5lzBX9s0
         lLloFY83InuSVSlrm0Fhkff0pVj3Lh4sMu2RdtPQ5WnYIOaC9424o9u/SEGWTAQaR4fL
         SkXEJeQMJP4lFHY+npXZOvnj7225S63KeQQfhrALV/f7fH39fF4r3PCiqVr1rEtIfR1r
         QrTbTR7oTvxQHwsVXKdMdjMankkgUG0WfLktuFBNh3iF4Evc0tQPg6XiLW6Z/Z+wdrq0
         +ixA==
X-Gm-Message-State: AOJu0YxXAV43abfCGNEXbv4BYeIvVk+wEn6wWoJ9mZMdG1ws3f1Tl9Jg
	Wd538gmhoRKQ/5qjsONR3vQ=
X-Google-Smtp-Source: AGHT+IGVq6je1saKrJ6OwUxEIYR/miUBiVtcqSRVey1EoEQE5X1niQ1GB8WkWL5AB5w4HMWsL72cSQ==
X-Received: by 2002:a05:620a:4141:b0:77d:cf5d:1bce with SMTP id k1-20020a05620a414100b0077dcf5d1bcemr3239989qko.4.1701898415723;
        Wed, 06 Dec 2023 13:33:35 -0800 (PST)
Received: from kolga-mac-1.attlocal.net ([2600:1700:6a10:2e90:b4ac:108b:be40:79b])
        by smtp.gmail.com with ESMTPSA id ro3-20020a05620a398300b0077da601f06csm256435qkn.10.2023.12.06.13.33.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 13:33:34 -0800 (PST)
From: Olga Kornievskaia <olga.kornievskaia@gmail.com>
To: steved@redhat.com
Cc: linux-nfs@vger.kernel.org,
	chuck.lever@oracle.com
Subject: [PATCH 1/6] gssd: revert commit a5f3b7ccb01c
Date: Wed,  6 Dec 2023 16:33:27 -0500
Message-Id: <20231206213332.55565-2-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20231206213332.55565-1-olga.kornievskaia@gmail.com>
References: <20231206213332.55565-1-olga.kornievskaia@gmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Olga Kornievskaia <kolga@netapp.com>

In preparation for using rpc_gss_seccreate() function, revert commit
a5f3b7ccb01c "gssd: handle KRB5_AP_ERR_BAD_INTEGRITY for user
credentials"

Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
---
 utils/gssd/gssd_proc.c |  2 --
 utils/gssd/krb5_util.c | 42 ------------------------------------------
 utils/gssd/krb5_util.h |  1 -
 3 files changed, 45 deletions(-)

diff --git a/utils/gssd/gssd_proc.c b/utils/gssd/gssd_proc.c
index a96647df..e5cc1d98 100644
--- a/utils/gssd/gssd_proc.c
+++ b/utils/gssd/gssd_proc.c
@@ -419,8 +419,6 @@ create_auth_rpc_client(struct clnt_info *clp,
 			if (cred == GSS_C_NO_CREDENTIAL)
 				retval = gssd_refresh_krb5_machine_credential(clp->servername,
 					"*", NULL, 1);
-			else
-				retval = gssd_k5_remove_bad_service_cred(clp->servername);
 			if (!retval) {
 				auth = authgss_create_default(rpc_clnt, tgtname,
 						&sec);
diff --git a/utils/gssd/krb5_util.c b/utils/gssd/krb5_util.c
index 6f66ef4f..f6ce1fec 100644
--- a/utils/gssd/krb5_util.c
+++ b/utils/gssd/krb5_util.c
@@ -1553,48 +1553,6 @@ gssd_acquire_user_cred(gss_cred_id_t *gss_cred)
 	return ret;
 }
 
-/* Removed a service ticket for nfs/<name> from the ticket cache
- */
-int
-gssd_k5_remove_bad_service_cred(char *name)
-{
-        krb5_creds in_creds, out_creds;
-        krb5_error_code ret;
-        krb5_context context;
-        krb5_ccache cache;
-        krb5_principal principal;
-        int retflags = KRB5_TC_MATCH_SRV_NAMEONLY;
-        char srvname[1024];
-
-        ret = krb5_init_context(&context);
-        if (ret)
-                goto out_cred;
-        ret = krb5_cc_default(context, &cache);
-        if (ret)
-                goto out_free_context;
-        ret = krb5_cc_get_principal(context, cache, &principal);
-        if (ret)
-                goto out_close_cache;
-        memset(&in_creds, 0, sizeof(in_creds));
-        in_creds.client = principal;
-        sprintf(srvname, "nfs/%s", name);
-        ret = krb5_parse_name(context, srvname, &in_creds.server);
-        if (ret)
-                goto out_free_principal;
-        ret = krb5_cc_retrieve_cred(context, cache, retflags, &in_creds, &out_creds);
-        if (ret)
-                goto out_free_principal;
-        ret = krb5_cc_remove_cred(context, cache, 0, &out_creds);
-out_free_principal:
-        krb5_free_principal(context, principal);
-out_close_cache:
-        krb5_cc_close(context, cache);
-out_free_context:
-        krb5_free_context(context);
-out_cred:
-        return ret;
-}
-
 #ifdef HAVE_SET_ALLOWABLE_ENCTYPES
 /*
  * this routine obtains a credentials handle via gss_acquire_cred()
diff --git a/utils/gssd/krb5_util.h b/utils/gssd/krb5_util.h
index 7ef87018..62c91a0e 100644
--- a/utils/gssd/krb5_util.h
+++ b/utils/gssd/krb5_util.h
@@ -22,7 +22,6 @@ char *gssd_k5_err_msg(krb5_context context, krb5_error_code code);
 void gssd_k5_get_default_realm(char **def_realm);
 
 int gssd_acquire_user_cred(gss_cred_id_t *gss_cred);
-int gssd_k5_remove_bad_service_cred(char *srvname);
 
 #ifdef HAVE_SET_ALLOWABLE_ENCTYPES
 extern int limit_to_legacy_enctypes;
-- 
2.39.1


