Return-Path: <linux-nfs+bounces-18926-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kEmdM1Soj2lgSQEAu9opvQ
	(envelope-from <linux-nfs+bounces-18926-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Feb 2026 23:40:20 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 35A9D139D2D
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Feb 2026 23:40:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E0FBE3034E11
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Feb 2026 22:40:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D08D284682;
	Fri, 13 Feb 2026 22:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P6dJDaqr"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 189B12673AA
	for <linux-nfs@vger.kernel.org>; Fri, 13 Feb 2026 22:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771022418; cv=none; b=IzabV3K3218Xu1MmkGiIK+579wmuMafLO/l0qXP9X473jXq5/mu2kFZgWPWOkzB6ab2zcDKh6hAw2bXyQyOGPMAcUEG7CldJOWUrcSFHBtuT6NhWEWTYwAd6hXLuZK+LlUzBFF1ZLmbFKL3b1Unec79DdANm1Bi+mNGCzFcG0ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771022418; c=relaxed/simple;
	bh=dqIMtJCJ7GNMtXQY20HJXaVDru8S5bP/OPwIQ1Dw1+c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ScUhziAMAWg7GUGWHdkq+Fh7lK3YvFM/muJhIHXYe1eFukWeuO0g0ng8ZhOf3+da0hPXL2hZjpLom1JRC9J3RsHfUp1in1h0iCMtjP21q3w8DVOu4dvKi0vKK2QvWpkHTQ8tK3zdedK5HK8E6FACMcdKz9H1a4C6o3YzBcX1RRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=P6dJDaqr; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1771022416;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sGHkZcwYJ3wY2NQXx8vjqueFea2kvhdBYfWeTRlBnmU=;
	b=P6dJDaqrX87ORjQBIAIdn7EBZemm7LmvtOK7Qh4rhonJCP25Hx7zBrccF4khZcM8iwG8KR
	yajsUUrkcYIBfdrUgE5IymGSJJ3lTY5lOc4zY4PbAL5jvBxoGSsFiIwBf9t/BK8pS/Tz1v
	0HW3IO9MaH/KFHN8pct3a8HHg0dzzmA=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-534-_hLJDnfAPGq1Sg9_rzX2lw-1; Fri,
 13 Feb 2026 17:40:14 -0500
X-MC-Unique: _hLJDnfAPGq1Sg9_rzX2lw-1
X-Mimecast-MFC-AGG-ID: _hLJDnfAPGq1Sg9_rzX2lw_1771022413
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C5798195608A;
	Fri, 13 Feb 2026 22:40:13 +0000 (UTC)
Received: from aion.redhat.com (unknown [10.22.88.127])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8AB771800286;
	Fri, 13 Feb 2026 22:40:13 +0000 (UTC)
Received: from aion.redhat.com (localhost [IPv6:::1])
	by aion.redhat.com (Postfix) with ESMTP id 587B26B69FD;
	Fri, 13 Feb 2026 17:40:12 -0500 (EST)
From: Scott Mayhew <smayhew@redhat.com>
To: steved@redhat.com
Cc: =carnil@debian.org,
	linux-nfs@vger.kernel.org
Subject: [nfs-utils PATCH RFC 3/4] gssd: get the permitted enctypes from the krb5 library on startup
Date: Fri, 13 Feb 2026 17:40:11 -0500
Message-ID: <20260213224012.2608126-4-smayhew@redhat.com>
In-Reply-To: <20260213224012.2608126-1-smayhew@redhat.com>
References: <20260213224012.2608126-1-smayhew@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18926-lists,linux-nfs=lfdr.de];
	RCPT_COUNT_THREE(0.00)[3];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[smayhew@redhat.com,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 35A9D139D2D
X-Rspamd-Action: no action

This will allow us to cross-reference the list of encryption types
sent in the upcall from the kernel as well as the list of encryption
types enabled via the allowed-enctypes option from nfs.conf with
the list permitted by the krb5 library.

Signed-off-by: Scott Mayhew <smayhew@redhat.com>
---
 utils/gssd/gssd.c      |  3 +++
 utils/gssd/krb5_util.c | 55 ++++++++++++++++++++++++++++++++++++++++++
 utils/gssd/krb5_util.h |  1 +
 3 files changed, 59 insertions(+)

diff --git a/utils/gssd/gssd.c b/utils/gssd/gssd.c
index 8a894b2e..1c901991 100644
--- a/utils/gssd/gssd.c
+++ b/utils/gssd/gssd.c
@@ -1222,6 +1222,9 @@ main(int argc, char *argv[])
 	daemon_init(fg);
 
 #ifdef HAVE_SET_ALLOWABLE_ENCTYPES
+	rc = get_krb5_library_permitted_enctypes();
+	if (rc)
+		exit(EXIT_FAILURE);
 	rc = get_allowed_enctypes();
 	if (rc)
 		exit(EXIT_FAILURE);
diff --git a/utils/gssd/krb5_util.c b/utils/gssd/krb5_util.c
index 2b2925fb..bc07f852 100644
--- a/utils/gssd/krb5_util.c
+++ b/utils/gssd/krb5_util.c
@@ -155,9 +155,15 @@ static struct gssd_k5_kt_princ *gssd_k5_kt_princ_list = NULL;
 static pthread_mutex_t ple_lock = PTHREAD_MUTEX_INITIALIZER;
 
 #ifdef HAVE_SET_ALLOWABLE_ENCTYPES
+/* Encryption types specified in nfs.conf */
 krb5_enctype *allowed_enctypes = NULL;
 int num_allowed_enctypes = 0;
 char *allowed_enctypes_string = NULL;
+
+/* Encryption types permitted by the krb5 library */
+int num_lib_enctypes = 0;
+krb5_enctype *lib_enctypes = NULL;
+char *lib_enctypes_string = NULL;
 #endif
 
 /*==========================*/
@@ -1676,6 +1682,55 @@ out:
 	return ret;
 }
 
+int
+get_krb5_library_permitted_enctypes(void)
+{
+	krb5_error_code code = 0;
+	krb5_context context;
+	char *k5err = NULL;
+	int ret = 0;
+
+	code = krb5_init_context(&context);
+	if (code) {
+		k5err = gssd_k5_err_msg(NULL, code);
+		printerr(2, "ERROR: %s: %s while initializing krb5 context\n",
+			 __func__, k5err);
+		ret = code;
+		goto out;
+	}
+
+	code = krb5_get_permitted_enctypes(context, &lib_enctypes);
+	if (code) {
+		k5err = gssd_k5_err_msg(context, code);
+		printerr(2, "ERROR: %s: %s while getting permitted enctypes\n",
+			 __func__, k5err);
+		ret = code;
+		goto out_free_context;
+	}
+
+	if (lib_enctypes != NULL)
+		while (lib_enctypes[num_lib_enctypes] != 0)
+			num_lib_enctypes++;
+
+	if (num_lib_enctypes > 0) {
+		if (enctypes_list_to_string(lib_enctypes, num_lib_enctypes,
+					    &lib_enctypes_string) != 0) {
+			printerr(2, "%s: warning: enctypes_list_to_string() failed\n",
+				 __func__);
+			goto out_free_context;
+		}
+		printerr(2, "krb5 library permitted enctypes: %s\n",
+			 lib_enctypes_string);
+	}
+
+out_free_context:
+	krb5_free_context(context);
+
+out:
+	free(k5err);
+	return ret;
+}
+
 /*
  * this routine obtains a credentials handle via gss_acquire_cred()
  * then calls gss_krb5_set_allowable_enctypes() to limit the encryption
diff --git a/utils/gssd/krb5_util.h b/utils/gssd/krb5_util.h
index a8e17ea2..e9d08567 100644
--- a/utils/gssd/krb5_util.h
+++ b/utils/gssd/krb5_util.h
@@ -30,6 +30,7 @@ int enctypes_list_to_string(krb5_enctype *enctypes, int num_enctypes,
 #ifdef HAVE_SET_ALLOWABLE_ENCTYPES
 int limit_krb5_enctypes(struct rpc_gss_sec *sec);
 int get_allowed_enctypes(void);
+int get_krb5_library_permitted_enctypes(void);
 #endif
 
 /*
-- 
2.52.0


