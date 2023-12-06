Return-Path: <linux-nfs+bounces-376-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0C00807A87
	for <lists+linux-nfs@lfdr.de>; Wed,  6 Dec 2023 22:33:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5AE4E28258A
	for <lists+linux-nfs@lfdr.de>; Wed,  6 Dec 2023 21:33:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E81D7097C;
	Wed,  6 Dec 2023 21:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Use2PMQu"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A23DBD4B
	for <linux-nfs@vger.kernel.org>; Wed,  6 Dec 2023 13:33:42 -0800 (PST)
Received: by mail-qv1-xf32.google.com with SMTP id 6a1803df08f44-67a9a51663fso446586d6.1
        for <linux-nfs@vger.kernel.org>; Wed, 06 Dec 2023 13:33:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701898422; x=1702503222; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KQXA9vl98I9LBhtCOa0q1mlMwf+h5U4kRSy7ybOBDhw=;
        b=Use2PMQuCR0KE1iJlK1X0dCU+RgbC2vQS8lVxdTIgWBRk7o+0jcJXCWiG+yFUAHx5u
         lgqoPaDnp/2CwnRdfjePxc5TyxkI0QIzmaRSlzcGZo5xgAandAA2dveaJODyXGJIa0uC
         v9ALVv1LptNiqFPrISoHtdPbYDxLoyDcb2RW15QOmv5z6uWdzF46gI6ZSrIPmEXavRZk
         jDkKV6PUuf2zHcVtVgxblStVr4Ln/rDm9NZBdq3G/qhY4Ukj7WSjk2Y7QfRhqFDqK+5J
         NauIsUnhBpEeBnDAdyCRXJ4aY3BpRdUd5hq+qI4zcVkUwOYd0cZlTQmLk62BA8UDP8/j
         7qmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701898422; x=1702503222;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KQXA9vl98I9LBhtCOa0q1mlMwf+h5U4kRSy7ybOBDhw=;
        b=r7Gnd5IFu9J6yK+xx/pCjILQlnOoHV4eoOKIEDfaIstVEjlRazzgf1SOOiLNqyFTdE
         MMsd4HJKIgVZo/bY0YthVkilmMXcFOSJXsnIGhW8ARC3v4UXupJywhzqMSbEEx54JrNB
         eZLaIislPbw0Pdjw8nOt33jBVRK+QQSFYGB7vgRktoKb4hBme68sK5m6b3giki2cLY7E
         O84aZS3MaHI12MGORl41y+lFXm2gvy0Ivmds0p7n9kvQng9ixvQOAQarZ1hjbWDxCWu+
         Mvq1lAP13L9QC1HS7eMpbW00DUU4cuxky//63P7ecvbRfVoMIycaVeq0sNgLH1RUxthK
         I8VA==
X-Gm-Message-State: AOJu0YzcM/BhnMVufpn7Qo1PSu4G2sLUz0jrtuttkb51b6lpoON4QdWK
	MzNjaWzxIjTkXEsPdt0r3Nc=
X-Google-Smtp-Source: AGHT+IH8d636+oRZE92e/BStqQKx44Nnl9KPptQpxNtY2VT6uaaw7e/BuQQcGgwbUxNpXTSKokgoLQ==
X-Received: by 2002:a05:620a:172c:b0:77d:a5d0:edb3 with SMTP id az44-20020a05620a172c00b0077da5d0edb3mr3342618qkb.6.1701898421701;
        Wed, 06 Dec 2023 13:33:41 -0800 (PST)
Received: from kolga-mac-1.attlocal.net ([2600:1700:6a10:2e90:b4ac:108b:be40:79b])
        by smtp.gmail.com with ESMTPSA id ro3-20020a05620a398300b0077da601f06csm256435qkn.10.2023.12.06.13.33.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 13:33:40 -0800 (PST)
From: Olga Kornievskaia <olga.kornievskaia@gmail.com>
To: steved@redhat.com
Cc: linux-nfs@vger.kernel.org,
	chuck.lever@oracle.com
Subject: [PATCH 5/6] gssd: handle KRB5_AP_ERR_BAD_INTEGRITY for user credentials
Date: Wed,  6 Dec 2023 16:33:31 -0500
Message-Id: <20231206213332.55565-6-olga.kornievskaia@gmail.com>
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

Unlike the machine credential case, we can't throw away the ticket
cache and use the keytab to renew the credentials. Instead, we
need to remove the service ticket for the server that returned
KRB5_AP_ERR_BAD_INTEGRITY and try again.

Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
---
 utils/gssd/gssd_proc.c |  2 ++
 utils/gssd/krb5_util.c | 42 ++++++++++++++++++++++++++++++++++++++++++
 utils/gssd/krb5_util.h |  1 +
 3 files changed, 45 insertions(+)

diff --git a/utils/gssd/gssd_proc.c b/utils/gssd/gssd_proc.c
index 29600a3f..7629de0b 100644
--- a/utils/gssd/gssd_proc.c
+++ b/utils/gssd/gssd_proc.c
@@ -435,6 +435,8 @@ create_auth_rpc_client(struct clnt_info *clp,
 			if (cred == GSS_C_NO_CREDENTIAL)
 				retval = gssd_refresh_krb5_machine_credential(clp->servername,
 					"*", NULL, 1);
+			else
+				retval = gssd_k5_remove_bad_service_cred(clp->servername);
 			if (!retval) {
 				auth = rpc_gss_seccreate(rpc_clnt, tgtname,
 						mechanism, rpcsec_gss_svc_none,
diff --git a/utils/gssd/krb5_util.c b/utils/gssd/krb5_util.c
index f6ce1fec..6f66ef4f 100644
--- a/utils/gssd/krb5_util.c
+++ b/utils/gssd/krb5_util.c
@@ -1553,6 +1553,48 @@ gssd_acquire_user_cred(gss_cred_id_t *gss_cred)
 	return ret;
 }
 
+/* Removed a service ticket for nfs/<name> from the ticket cache
+ */
+int
+gssd_k5_remove_bad_service_cred(char *name)
+{
+        krb5_creds in_creds, out_creds;
+        krb5_error_code ret;
+        krb5_context context;
+        krb5_ccache cache;
+        krb5_principal principal;
+        int retflags = KRB5_TC_MATCH_SRV_NAMEONLY;
+        char srvname[1024];
+
+        ret = krb5_init_context(&context);
+        if (ret)
+                goto out_cred;
+        ret = krb5_cc_default(context, &cache);
+        if (ret)
+                goto out_free_context;
+        ret = krb5_cc_get_principal(context, cache, &principal);
+        if (ret)
+                goto out_close_cache;
+        memset(&in_creds, 0, sizeof(in_creds));
+        in_creds.client = principal;
+        sprintf(srvname, "nfs/%s", name);
+        ret = krb5_parse_name(context, srvname, &in_creds.server);
+        if (ret)
+                goto out_free_principal;
+        ret = krb5_cc_retrieve_cred(context, cache, retflags, &in_creds, &out_creds);
+        if (ret)
+                goto out_free_principal;
+        ret = krb5_cc_remove_cred(context, cache, 0, &out_creds);
+out_free_principal:
+        krb5_free_principal(context, principal);
+out_close_cache:
+        krb5_cc_close(context, cache);
+out_free_context:
+        krb5_free_context(context);
+out_cred:
+        return ret;
+}
+
 #ifdef HAVE_SET_ALLOWABLE_ENCTYPES
 /*
  * this routine obtains a credentials handle via gss_acquire_cred()
diff --git a/utils/gssd/krb5_util.h b/utils/gssd/krb5_util.h
index 62c91a0e..7ef87018 100644
--- a/utils/gssd/krb5_util.h
+++ b/utils/gssd/krb5_util.h
@@ -22,6 +22,7 @@ char *gssd_k5_err_msg(krb5_context context, krb5_error_code code);
 void gssd_k5_get_default_realm(char **def_realm);
 
 int gssd_acquire_user_cred(gss_cred_id_t *gss_cred);
+int gssd_k5_remove_bad_service_cred(char *srvname);
 
 #ifdef HAVE_SET_ALLOWABLE_ENCTYPES
 extern int limit_to_legacy_enctypes;
-- 
2.39.1


