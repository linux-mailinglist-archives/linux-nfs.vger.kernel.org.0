Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95E5C7B86A1
	for <lists+linux-nfs@lfdr.de>; Wed,  4 Oct 2023 19:32:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243630AbjJDRcw (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 4 Oct 2023 13:32:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243498AbjJDRcw (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 4 Oct 2023 13:32:52 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A82CA7
        for <linux-nfs@vger.kernel.org>; Wed,  4 Oct 2023 10:32:49 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id e9e14a558f8ab-34f69780037so101805ab.1
        for <linux-nfs@vger.kernel.org>; Wed, 04 Oct 2023 10:32:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696440768; x=1697045568; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5D5Kvm1BHqxw7OkRLtU/qxcvETM83IthKpPkvjPcRF4=;
        b=WiFKTPaCvJrB09Ff32MaSqomuUibmLr5dRxW8ODodnt4MKn+lBYNMIrfWdY6g2tp22
         ZdJ9wLPI9dFQsqf8N7bP5WcBbZAkxqpoaHyokvIAViFmpSukPpSrZNGAEj0QnxvS5a1S
         4DkH9ixsRiURCoCXgv+xcz+3ok5jJBHKmo4Ay8Sh/AY0jed1F3L6VSWJ3GbJbklZfgDw
         +57xyMtLjPCMaf/oVWr3azZcVgR+HtUEcmA7m81eXpUzzGDV73rMURpd/jpbwoS0BGKg
         mEFfH2VWZnEfBR/uV17orMhFbSGsmKhzReDZtMCpxPzJAENBWfHPKoUV3kmysBzUQts8
         XF8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696440768; x=1697045568;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5D5Kvm1BHqxw7OkRLtU/qxcvETM83IthKpPkvjPcRF4=;
        b=uPRTMPnBHlq4+bgYzaPdDMstsYJAFUmeR9XkXVYBt4WtkUBbvo82s+w7ZF9LyRH35Y
         36GJ7ILOfyAewU8UXWIHHNFPoINJJAhd+27alG4aCwb95WP0CfZprxXkYHAq7QV21U6X
         kLD71AbFY63EobkWLKb+SW7M7k+aFjc2bOKQZ6C9GAMyuj6Dt21dfegQamnRu6q4U51J
         RSuuIQLGUNCO9MhocFmb98n1EH5WnSr8XhQObI1u8stzdU71Y1Ez3bHf5shWjSZbkl7U
         bHnjwyP3jT62ZlQEJxBnj5IqNi4dfwe1oolzQzonVPQUBi2Edkp/7VBc7rJ+ZniXhf1n
         DmEA==
X-Gm-Message-State: AOJu0YzfxWC8ovG9A8W4mTJO8q09WxLYE52a8quiEX7sjQkQ7edxGk3G
        KfrzBlxLuAXQPXZF2/VMuCLEx7f62pQ=
X-Google-Smtp-Source: AGHT+IFiAs8kNDhmNjSDrfNxEgCTYoAvtPVxjDH4Amk0Lyvfg3DVMVwFtFlAstg7nFRWmtHielv75Q==
X-Received: by 2002:a05:6602:368c:b0:792:7c78:55be with SMTP id bf12-20020a056602368c00b007927c7855bemr2906412iob.0.1696440768408;
        Wed, 04 Oct 2023 10:32:48 -0700 (PDT)
Received: from kolga-mac-1.attlocal.net ([2600:1700:6a10:2e90:d99c:94dd:ccd6:fb22])
        by smtp.gmail.com with ESMTPSA id u23-20020a6be417000000b007870289f4fdsm1066598iog.51.2023.10.04.10.32.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Oct 2023 10:32:47 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     steved@redhat.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 3/3] nfs-utils: gssd: handle KRB5_AP_ERR_BAD_INTEGRITY for user credentials
Date:   Wed,  4 Oct 2023 13:32:40 -0400
Message-Id: <20231004173240.46924-6-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20231004173240.46924-1-olga.kornievskaia@gmail.com>
References: <20231004173240.46924-1-olga.kornievskaia@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

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
index e5cc1d98..a96647df 100644
--- a/utils/gssd/gssd_proc.c
+++ b/utils/gssd/gssd_proc.c
@@ -419,6 +419,8 @@ create_auth_rpc_client(struct clnt_info *clp,
 			if (cred == GSS_C_NO_CREDENTIAL)
 				retval = gssd_refresh_krb5_machine_credential(clp->servername,
 					"*", NULL, 1);
+			else
+				retval = gssd_k5_remove_bad_service_cred(clp->servername);
 			if (!retval) {
 				auth = authgss_create_default(rpc_clnt, tgtname,
 						&sec);
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

