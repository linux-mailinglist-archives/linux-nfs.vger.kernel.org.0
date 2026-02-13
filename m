Return-Path: <linux-nfs+bounces-18930-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kJjmNmGoj2lgSQEAu9opvQ
	(envelope-from <linux-nfs+bounces-18930-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Feb 2026 23:40:33 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6088A139D49
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Feb 2026 23:40:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EC174303B4C0
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Feb 2026 22:40:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5ABB2673AA;
	Fri, 13 Feb 2026 22:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hbENWlHh"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C969E3101A8
	for <linux-nfs@vger.kernel.org>; Fri, 13 Feb 2026 22:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771022420; cv=none; b=mrbypu36cm+lreARh/oqm/qfjlOWhQQT/jTvg3lSiQeaYhpB76CttH0wX5mmH4oOiZ03mcIOWX3geKOUEJ4ignzjov3Og1YX9jLBNYAz7yOee2IhB/IxS7XxsZE2IxLDOafdHu340JXnR45pY9Zkhura7wjGHNNFxNuMrpc614Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771022420; c=relaxed/simple;
	bh=I+i+kg1NPfjFXj23OPYN8UfCH44cPHeXV37bvSvQVq0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cxN+VeIcWeys14JUbBPpC4xdqjbjRzyR2FfrEcwUMZxfwoHax5P6LToNfnFC4j3oKoF29jd+Lo09znTyk9O0WlkDYtr5tUP7dr5qWEaPWKyeMZwNclI0i39jt7apptaDV3W8N7xzE67eR5y3a6Vf9X+UOmofL17ZqxKtc195LMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hbENWlHh; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1771022417;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JZFbbDyBAaRYkvm1IqQJhKrf/YekT2OGUcMyD+NUuRQ=;
	b=hbENWlHhtYlRFpEwPxLWg9ZqiEl+RevTrWQksOa2TGDS9yIe03VqB+NVydUZv0lgKeU6dY
	MWvz3/oNXZ+/iKd3VKZGlL3PwBh5cVaf99IZySaCaFYnQ/DSKWVIsnMPL81A4e/gM8oPls
	rgcZtFRCFRi2x55SkRmzFV6Az4jsMmo=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-384-iRd1tzgFMNSgYOvUKXnVzQ-1; Fri,
 13 Feb 2026 17:40:14 -0500
X-MC-Unique: iRd1tzgFMNSgYOvUKXnVzQ-1
X-Mimecast-MFC-AGG-ID: iRd1tzgFMNSgYOvUKXnVzQ_1771022413
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C7E1D1800473;
	Fri, 13 Feb 2026 22:40:13 +0000 (UTC)
Received: from aion.redhat.com (unknown [10.22.88.127])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 881D11800464;
	Fri, 13 Feb 2026 22:40:13 +0000 (UTC)
Received: from aion.redhat.com (localhost [IPv6:::1])
	by aion.redhat.com (Postfix) with ESMTP id 66D8C6B69FE;
	Fri, 13 Feb 2026 17:40:12 -0500 (EST)
From: Scott Mayhew <smayhew@redhat.com>
To: steved@redhat.com
Cc: =carnil@debian.org,
	linux-nfs@vger.kernel.org
Subject: [nfs-utils PATCH RFC 4/4] gssd: add a helper to determine the set of encryption types to pass to limit_krb5_enctypes()
Date: Fri, 13 Feb 2026 17:40:12 -0500
Message-ID: <20260213224012.2608126-5-smayhew@redhat.com>
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
	TAGGED_FROM(0.00)[bounces-18930-lists,linux-nfs=lfdr.de];
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
X-Rspamd-Queue-Id: 6088A139D49
X-Rspamd-Action: no action

When the MIT kerberos library does a TGS request it initially does so
with referrals enabled, using its default enctype list instead of the
application-provided one.  It still ensures that the resulting ticket is
using an enctype from the application-provided list, it just might not
be the highest priority enctype from the application-provided list.

That can result in the machine cred's service ticket using a different
enctype than a user cred's service ticket (particularly in the case of
contrained delegation with gssproxy), which will lead to XDR decoding
failures in the kernel.  See https://bugs.debian.org/1120598.

The best way to combat this to configure the krb5 library's
permitted_enctypes list to have the same order as the kernel's
gss_krb5_prepare_enctype_priority_list (which is set at build time), but
not all distros do that.  The second best way is to make sure our list
is ordered according to the krb5 library's list, which can be
accomplished via the helper function added by this patch.

The list will be the intersection of:

1. allowed_enctypes - If allowed-enctypes is defined in nfs.conf, this
   is processed via get_allowed_enctypes() during gssd startup.
2. krb5_enctypes - This is the list of enctypes passed in the upcall
   from the kernel, and is processed via handle_gssd_upcall() ->
   parse_enctypes().
3. lib_enctypes - Processed via get_krb5_library_permitted_enctypes()
   during gssd startup.

Signed-off-by: Scott Mayhew <smayhew@redhat.com>
---
 utils/gssd/krb5_util.c | 172 ++++++++++++++++++++++++++++++++++-------
 1 file changed, 143 insertions(+), 29 deletions(-)

diff --git a/utils/gssd/krb5_util.c b/utils/gssd/krb5_util.c
index bc07f852..bc063a8b 100644
--- a/utils/gssd/krb5_util.c
+++ b/utils/gssd/krb5_util.c
@@ -164,6 +164,14 @@ char *allowed_enctypes_string = NULL;
 int num_lib_enctypes = 0;
 krb5_enctype *lib_enctypes = NULL;
 char *lib_enctypes_string = NULL;
+
+/*
+ * The final set of encryption types that will be used in
+ * limit_krb5_enctypes().  See determine_enctypes() below.
+ */
+int num_set_enctypes = 0;
+krb5_enctype *set_enctypes = NULL;
+char *set_enctypes_string = NULL;
 #endif
 
 /*==========================*/
@@ -1731,6 +1739,128 @@ out:
 	return ret;
 }
 
+/*
+ * Helper to determine the final set of enctypes that will be passed to
+ * gss_set_allowable_enctypes() in limit_krb5_enctypes().
+ *
+ * It will be the intersection of:
+ *
+ * 1. allowed_enctypes - If allowed-enctypes is defined in nfs.conf, this is
+ *    processed via get_allowed_enctypes() during gssd startup.
+ * 2. krb5_enctypes - This is the list of enctypes passed in the upcall from
+ *    the kernel, and is processed via handle_gssd_upcall() -> parse_enctypes().
+ * 3. lib_enctypes - Processed via get_krb5_library_permitted_enctypes() during
+ *    gssd startup.
+ *
+ * It will be ordered according to lib_enctypes.  This is necessary because when
+ * the MIT kerberos library does a TGS request it initially does so with
+ * referrals enabled, using its default enctype list instead of the application-
+ * provided one.  It still ensures that the resulting ticket is using an enctype
+ * from the application-provided list, it just might not be the highest priority
+ * enctype from the application-provided list.
+ *
+ * That can result in the machine cred's service ticket using a different
+ * enctype than a user cred's service ticket (particularly in the case of
+ * contrained delegation with gssproxy), which will lead to XDR decoding
+ * failures in the kernel.
+ *
+ * The best way to combat this to configure the krb5 library's
+ * permitted_enctypes list to have the same order as the kernel's
+ * gss_krb5_prepare_enctype_priority_list (which is set at build time), but not
+ * all distros do that.  The second best way is to make sure our list is ordered
+ * according to the krb5 library's list, hence this helper function.
+ */
+static int
+determine_enctypes(krb5_enctype **set_enctypes, int *num_set_enctypes,
+		   char **set_enctypes_string)
+{
+	extern int num_allowed_enctypes, num_krb5_enctypes, num_lib_enctypes;
+	extern krb5_enctype *allowed_enctypes, *krb5_enctypes, *lib_enctypes;
+	extern char *allowed_enctypes_string, *krb5_enctypes_string,
+	       *lib_enctypes_string;
+	krb5_enctype *enctypes;
+	int num_enctypes = 0;
+	char *enctypes_string;
+	int i, j, k;
+
+	if (krb5_enctypes) {
+		printerr(2, "%s: kernel enctypes: %s\n",
+			 __func__, krb5_enctypes_string);
+	} else {
+		printerr(2, "%s: kernel enctype list is empty\n",
+			 __func__);
+		return -1;
+	}
+
+	if (lib_enctypes) {
+		printerr(2, "%s: krb5 library enctypes: %s\n",
+			 __func__, lib_enctypes_string);
+	} else {
+		printerr(2, "%s: krb5 library enctype list is empty\n",
+			 __func__);
+		return -1;
+	}
+
+	if (allowed_enctypes) {
+		printerr(2, "%s: config allowed enctypes: %s\n",
+			 __func__, allowed_enctypes_string);
+	}
+
+	if (allowed_enctypes) {
+		enctypes = (krb5_enctype *) calloc(num_allowed_enctypes,
+						   sizeof(krb5_enctype));
+		if (enctypes == NULL)
+			return ENOMEM;
+		for (i = 0; i < num_lib_enctypes; i++) {
+			for (j = 0; j < num_krb5_enctypes; j++) {
+				if (lib_enctypes[i] == krb5_enctypes[j]) {
+					for (k = 0; k < num_allowed_enctypes; k++) {
+						if (lib_enctypes[i] == allowed_enctypes[k]) {
+							enctypes[num_enctypes++] = lib_enctypes[i];
+							break;
+						}
+					}
+					break;
+				}
+			}
+		}
+	} else {
+		enctypes = (krb5_enctype *) calloc(num_krb5_enctypes,
+						   sizeof(krb5_enctype));
+		if (enctypes == NULL)
+			return ENOMEM;
+		for (i = 0; i < num_lib_enctypes; i++) {
+			for (j = 0; j < num_krb5_enctypes; j++) {
+				if (lib_enctypes[i] == krb5_enctypes[j]) {
+					enctypes[num_enctypes++] = lib_enctypes[i];
+					break;
+				}
+			}
+		}
+	}
+
+	if (num_enctypes > 0) {
+		if (enctypes_list_to_string(enctypes, num_enctypes,
+					    &enctypes_string) != 0) {
+			printerr(2, "%s: warning: enctypes_list_to_string() failed\n",
+				 __func__);
+			return -1;
+		}
+		printerr(2, "%s: result enctypes: %s\n",
+			 __func__, enctypes_string);
+	} else {
+		printerr(2, "%s: no result enctypes\n",
+			 __func__);
+		free(enctypes);
+		return -1;
+	}
+
+	*set_enctypes = enctypes;
+	*num_set_enctypes = num_enctypes;
+	*set_enctypes_string = enctypes_string;
+	return 0;
+}
+
 /*
  * this routine obtains a credentials handle via gss_acquire_cred()
  * then calls gss_krb5_set_allowable_enctypes() to limit the encryption
@@ -1743,19 +1873,13 @@ out:
  *	0 => all went well
  *     -1 => there was an error
  */
-
 int
 limit_krb5_enctypes(struct rpc_gss_sec *sec)
 {
 	u_int maj_stat, min_stat;
-	extern int num_krb5_enctypes;
-	extern krb5_enctype *krb5_enctypes;
-	extern char *krb5_enctypes_string;
-	extern int num_allowed_enctypes;
-	extern krb5_enctype *allowed_enctypes;
-	extern char *allowed_enctypes_string;
-	int num_set_enctypes;
-	krb5_enctype *set_enctypes;
+	extern int num_set_enctypes;
+	extern krb5_enctype *set_enctypes;
+	extern char *set_enctypes_string;
 	int err = -1;
 
 	if (sec->cred == GSS_C_NO_CREDENTIAL) {
@@ -1764,28 +1888,18 @@ limit_krb5_enctypes(struct rpc_gss_sec *sec)
 			return -1;
 	}
 
-	if (allowed_enctypes) {
-		printerr(2, "%s: using allowed enctypes from config: %s\n",
-			 __func__, allowed_enctypes_string);
-		num_set_enctypes = num_allowed_enctypes;
-		set_enctypes = allowed_enctypes;
-	} else if (krb5_enctypes) {
-		printerr(2, "%s: using enctypes from the kernel: %s\n",
-			 __func__, krb5_enctypes_string);
-		num_set_enctypes = num_krb5_enctypes;
-		set_enctypes = krb5_enctypes;
-	} else {
-		/*
-		 * If we didn't get a list of enctypes from the kernel, that
-		 * would mean it did a v0 upcall which is for older gssd's.
-		 * That would indicate a serious problem, so we shouldn't
-		 * continue.
-		 */
-		printerr(0, "%s: no enctypes received from the kernel, and "
-			 "allowed-enctypes not set in the config\n", __func__);
-		return -1;
+	if (set_enctypes == NULL) {
+		err = determine_enctypes(&set_enctypes, &num_set_enctypes,
+					 &set_enctypes_string);
+		if (err) {
+			printerr(2, "%s: failed to determine set_enctypes\n",
+				 __func__);
+			return -1;
+		}
 	}
 
+	printerr(2, "%s: %s\n", __func__, set_enctypes_string);
+
 	maj_stat = gss_set_allowable_enctypes(&min_stat, sec->cred,
 				&krb5oid, num_set_enctypes, set_enctypes);
 
-- 
2.52.0


