Return-Path: <linux-nfs+bounces-18929-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QPzkAVaoj2lgSQEAu9opvQ
	(envelope-from <linux-nfs+bounces-18929-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Feb 2026 23:40:22 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C60D139D3B
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Feb 2026 23:40:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 970D33006137
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Feb 2026 22:40:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4324B284682;
	Fri, 13 Feb 2026 22:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AiuBmmNi"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C94A930C361
	for <linux-nfs@vger.kernel.org>; Fri, 13 Feb 2026 22:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771022420; cv=none; b=Abo1dVJpX2r2q4BPkTVogMzyAaMCO7pmQe0gFmnDTX35HDPmToz7UowKvM2Tz1+T6Camaur8u0VMAnv/PvVmhesl5esprJj0FhaCsmlEXAud5HhGyIgt6c/DbUTKTpaR888DTNDtOAaFXWG5jwSycsW9jKs0PNfqPAjRvzfX/pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771022420; c=relaxed/simple;
	bh=5Fg2tMnPGpTePMDOWFafFUSGpTbY6JCLZzGm0y0rWD0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GBqCMWNJYySeAtZ5mLWfdR5JNJKguoIBVXgbSyblNgPc78hDJFkKYoXEhWU04628EvfvWB6xHwuerWWnW8Wv4RsLonulnZB27JrAqpTckTTMixOnUTTMwgfi07FuR/WzjcLPTlxI3wEa8Rte6SvmsKc/uVmHCdFL/7o3v7N0aA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AiuBmmNi; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1771022418;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DYpg1Ar4lDhTFJTbPAsScGhbM30VkZ7v3z9hGFiswMM=;
	b=AiuBmmNilVqQYEeUe5dvJ2NZkThhT9+cvU4slN5vRzBq5HGJPMLSskzGW2yu7+Z/pb1oc3
	zz8Cj1oFM2VOrsCdiqh8D/qsJy936x+hQnh5W0gND0WSX6SC+U3JHZjzgQK+6fsVHsm6Tl
	4HqeB9WFD2UciPND0uKKq3dvzZXvl+8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-169-H8quSfc_MV-08G-Y34FXYg-1; Fri,
 13 Feb 2026 17:40:14 -0500
X-MC-Unique: H8quSfc_MV-08G-Y34FXYg-1
X-Mimecast-MFC-AGG-ID: H8quSfc_MV-08G-Y34FXYg_1771022413
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B33EC1800464;
	Fri, 13 Feb 2026 22:40:13 +0000 (UTC)
Received: from aion.redhat.com (unknown [10.22.88.127])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6AA7A1800465;
	Fri, 13 Feb 2026 22:40:13 +0000 (UTC)
Received: from aion.redhat.com (localhost [IPv6:::1])
	by aion.redhat.com (Postfix) with ESMTP id 4B8356B69FC;
	Fri, 13 Feb 2026 17:40:12 -0500 (EST)
From: Scott Mayhew <smayhew@redhat.com>
To: steved@redhat.com
Cc: =carnil@debian.org,
	linux-nfs@vger.kernel.org
Subject: [nfs-utils PATCH RFC 2/4] gssd: add enctypes_list_to_string()
Date: Fri, 13 Feb 2026 17:40:10 -0500
Message-ID: <20260213224012.2608126-3-smayhew@redhat.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18929-lists,linux-nfs=lfdr.de];
	RCPT_COUNT_THREE(0.00)[3];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[smayhew@redhat.com,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 9C60D139D3B
X-Rspamd-Action: no action

Add enctypes_list_to_string() to produce a human-friendly string that
can be used in debug messages.  The logic was mostly factored out of
get_allowed_enctypes().

Signed-off-by: Scott Mayhew <smayhew@redhat.com>
---
 utils/gssd/gssd_proc.c | 15 +++++++
 utils/gssd/krb5_util.c | 94 +++++++++++++++++++++++++++++-------------
 utils/gssd/krb5_util.h |  3 ++
 3 files changed, 83 insertions(+), 29 deletions(-)

diff --git a/utils/gssd/gssd_proc.c b/utils/gssd/gssd_proc.c
index 01331485..e060bee3 100644
--- a/utils/gssd/gssd_proc.c
+++ b/utils/gssd/gssd_proc.c
@@ -91,6 +91,7 @@ extern TAILQ_HEAD(active_thread_list_head, upcall_thread_info) active_thread_lis
 /* Encryption types supported by the kernel rpcsec_gss code */
 int num_krb5_enctypes = 0;
 krb5_enctype *krb5_enctypes = NULL;
+char *krb5_enctypes_string = NULL;
 
 /* Args for the cleanup_handler() */
 struct cleanup_args  {
@@ -121,6 +122,8 @@ parse_enctypes(char *enctypes)
 		free(krb5_enctypes);
 		krb5_enctypes = NULL;
 		num_krb5_enctypes = 0;
+		free(krb5_enctypes_string);
+		krb5_enctypes_string = NULL;
 	}
 
 	/* count the number of commas */
@@ -156,6 +159,18 @@ parse_enctypes(char *enctypes)
 	if ((cached_types = malloc(strlen(enctypes)+1)))
 		strcpy(cached_types, enctypes);
 
+	if (num_krb5_enctypes > 0) {
+		if (enctypes_list_to_string(krb5_enctypes, num_krb5_enctypes,
+					    &krb5_enctypes_string) != 0) {
+			printerr(2, "%s: warning: enctypes_list_to_string() failed\n",
+				 __func__);
+			goto out;
+		}
+		printerr(2, "kernel supported enctypes: %s\n",
+			 krb5_enctypes_string);
+	}
+
+out:
 	return 0;
 }
 
diff --git a/utils/gssd/krb5_util.c b/utils/gssd/krb5_util.c
index 9c1016b3..2b2925fb 100644
--- a/utils/gssd/krb5_util.c
+++ b/utils/gssd/krb5_util.c
@@ -157,6 +157,7 @@ static pthread_mutex_t ple_lock = PTHREAD_MUTEX_INITIALIZER;
 #ifdef HAVE_SET_ALLOWABLE_ENCTYPES
 krb5_enctype *allowed_enctypes = NULL;
 int num_allowed_enctypes = 0;
+char *allowed_enctypes_string = NULL;
 #endif
 
 /*==========================*/
@@ -1580,14 +1581,60 @@ out_cred:
         return ret;
 }
 
+int
+enctypes_list_to_string(krb5_enctype *enctypes, int num_enctypes,
+		        char **enctype_string)
+{
+	char tmp[100], *buf = NULL, *old = NULL;
+	int i, len, ret;
+
+	for (i = 0; i < num_enctypes; i++) {
+		ret = krb5_enctype_to_name(enctypes[i], true, tmp, sizeof(tmp));
+		if (ret == 0) {
+			if (buf == NULL) {
+				len = asprintf(&buf, "%s (%d)", tmp,
+					       enctypes[i]);
+				if (len < 0) {
+					ret = ENOMEM;
+					goto out_err;
+				}
+			} else {
+				old = buf;
+				len = asprintf(&buf, "%s, %s (%d)", old, tmp,
+					       enctypes[i]);
+				if (len < 0) {
+					ret = ENOMEM;
+					goto out_err;
+				}
+				free(old);
+				old = NULL;
+			}
+		} else {
+			printerr(0, "%s: invalid enctype %d",
+				 __func__, enctypes[i]);
+			goto out_err;
+		}
+	}
+	goto out;
+
+out_err:
+	free(buf);
+
+out:
+	if (old != buf)
+		free(old);
+	if (ret == 0)
+		*enctype_string = buf;
+	return ret;
+}
+
 #ifdef HAVE_SET_ALLOWABLE_ENCTYPES
 int
 get_allowed_enctypes(void)
 {
 	struct conf_list *allowed_etypes = NULL;
 	struct conf_list_node *node;
-	char *buf = NULL, *old = NULL;
-	int len, ret = 0;
+	int ret = 0;
 
 	allowed_etypes = conf_get_list("gssd", "allowed-enctypes");
 	if (allowed_etypes) {
@@ -1606,38 +1653,24 @@ get_allowed_enctypes(void)
 					 __func__, node->field);
 				goto out_err;
 			}
-			if (get_verbosity() > 1) {
-				if (buf == NULL) {
-					len = asprintf(&buf, "%s(%d)", node->field,
-						       allowed_enctypes[num_allowed_enctypes]);
-					if (len < 0) {
-						ret = ENOMEM;
-						goto out_err;
-					}
-				} else {
-					old = buf;
-					len = asprintf(&buf, "%s,%s(%d)", old, node->field,
-						       allowed_enctypes[num_allowed_enctypes]);
-					if (len < 0) {
-						ret = ENOMEM;
-						goto out_err;
-					}
-					free(old);
-					old = NULL;
-				}
-			}
 			num_allowed_enctypes++;
 		}
-		printerr(2, "%s: allowed_enctypes = %s", __func__, buf);
+	}
+	if (num_allowed_enctypes > 0) {
+		if (enctypes_list_to_string(allowed_enctypes, num_allowed_enctypes,
+					    &allowed_enctypes_string) != 0) {
+			printerr(2, "%s: warning: enctypes_list_to_string() failed\n",
+				 __func__);
+			goto out;
+		}
+		printerr(2, "%s: config allowed enctypes: %s\n", __func__,
+			 allowed_enctypes_string);
 	}
 	goto out;
 out_err:
 	num_allowed_enctypes = 0;
 	free(allowed_enctypes);
 out:
-	free(buf);
-	if (old != buf)
-		free(old);
 	if (allowed_etypes)
 		conf_free_list(allowed_etypes);
 	return ret;
@@ -1662,8 +1695,10 @@ limit_krb5_enctypes(struct rpc_gss_sec *sec)
 	u_int maj_stat, min_stat;
 	extern int num_krb5_enctypes;
 	extern krb5_enctype *krb5_enctypes;
+	extern char *krb5_enctypes_string;
 	extern int num_allowed_enctypes;
 	extern krb5_enctype *allowed_enctypes;
+	extern char *allowed_enctypes_string;
 	int num_set_enctypes;
 	krb5_enctype *set_enctypes;
 	int err = -1;
@@ -1675,12 +1710,13 @@ limit_krb5_enctypes(struct rpc_gss_sec *sec)
 	}
 
 	if (allowed_enctypes) {
-		printerr(2, "%s: using allowed enctypes from config\n",
-			 __func__);
+		printerr(2, "%s: using allowed enctypes from config: %s\n",
+			 __func__, allowed_enctypes_string);
 		num_set_enctypes = num_allowed_enctypes;
 		set_enctypes = allowed_enctypes;
 	} else if (krb5_enctypes) {
-		printerr(2, "%s: using enctypes from the kernel\n", __func__);
+		printerr(2, "%s: using enctypes from the kernel: %s\n",
+			 __func__, krb5_enctypes_string);
 		num_set_enctypes = num_krb5_enctypes;
 		set_enctypes = krb5_enctypes;
 	} else {
diff --git a/utils/gssd/krb5_util.h b/utils/gssd/krb5_util.h
index af5f30be..a8e17ea2 100644
--- a/utils/gssd/krb5_util.h
+++ b/utils/gssd/krb5_util.h
@@ -24,6 +24,9 @@ void gssd_k5_get_default_realm(char **def_realm);
 int gssd_acquire_user_cred(gss_cred_id_t *gss_cred);
 int gssd_k5_remove_bad_service_cred(char *srvname);
 
+int enctypes_list_to_string(krb5_enctype *enctypes, int num_enctypes,
+			    char **enctype_string);
+
 #ifdef HAVE_SET_ALLOWABLE_ENCTYPES
 int limit_krb5_enctypes(struct rpc_gss_sec *sec);
 int get_allowed_enctypes(void);
-- 
2.52.0


