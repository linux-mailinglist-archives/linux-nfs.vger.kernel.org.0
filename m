Return-Path: <linux-nfs+bounces-18927-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8HUuL1eoj2lgSQEAu9opvQ
	(envelope-from <linux-nfs+bounces-18927-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Feb 2026 23:40:23 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 68458139D42
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Feb 2026 23:40:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 660A4303CE08
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Feb 2026 22:40:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A955930B525;
	Fri, 13 Feb 2026 22:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QXqGHq/+"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F65F27FD49
	for <linux-nfs@vger.kernel.org>; Fri, 13 Feb 2026 22:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771022418; cv=none; b=mYItQC5yqAJSSWhXxfj+plqdzyiefKyi7BoxWP95yjT0Iw0U30i2HQBrCyireR8+Z+JGPsh5Ut2rQYByr9H4By9mN4KdUtvr1nQi5TECI2+Kg4LTkKyz3MFOcqkEXzPpD04H+OpHwZuKURbozBRdVzI0Mcqr4opFz2wq98MmWdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771022418; c=relaxed/simple;
	bh=sgPzHG7dImjRgqmyPcjJVOKlq1Ncuhgcz9f5Dj7ouew=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tz0twZcyFfWV4VUGhQX+sk6rlUtARbePPn+s96o31toaQAkNmMaL8Wapfjh90hgQr1JZD0S6Sv5NkMzSKT1LzyAmVKXo17K5dx2u2CSjTfewndjqUOQU8Zs2c99SLLHgMur9hoj5KTzVn+tHNVr8dtqFCvhdvPtYi/Au8O84xwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QXqGHq/+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1771022416;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RIU74tPduPbvEmCTbjtNPkvjhXNiAn2wBH7VKHEdzjI=;
	b=QXqGHq/+6xeya/SlVcfWKJElg/UO4pQCwD97+zCEVBmoDWwUawogkzd4VE7AOGd30/fmkf
	Rg9K/4fNHgLzrOKcKohOQexftJsahPFStHW9/YOlW1pQ1eyQeP1xM66a7skLrnhFQa13e0
	UkQJ11+ZisBE/F+uNmnKMq75/hS2gUs=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-536-viRFHN3yMGSu_co-YR4DCA-1; Fri,
 13 Feb 2026 17:40:14 -0500
X-MC-Unique: viRFHN3yMGSu_co-YR4DCA-1
X-Mimecast-MFC-AGG-ID: viRFHN3yMGSu_co-YR4DCA_1771022414
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C99061956052;
	Fri, 13 Feb 2026 22:40:13 +0000 (UTC)
Received: from aion.redhat.com (unknown [10.22.88.127])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7F13430001B9;
	Fri, 13 Feb 2026 22:40:13 +0000 (UTC)
Received: from aion.redhat.com (localhost [IPv6:::1])
	by aion.redhat.com (Postfix) with ESMTP id 3E3126B69FB;
	Fri, 13 Feb 2026 17:40:12 -0500 (EST)
From: Scott Mayhew <smayhew@redhat.com>
To: steved@redhat.com
Cc: =carnil@debian.org,
	linux-nfs@vger.kernel.org
Subject: [nfs-utils PATCH RFC 1/4] gssd: remove the limit-to-legacy-enctypes option
Date: Fri, 13 Feb 2026 17:40:09 -0500
Message-ID: <20260213224012.2608126-2-smayhew@redhat.com>
In-Reply-To: <20260213224012.2608126-1-smayhew@redhat.com>
References: <20260213224012.2608126-1-smayhew@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
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
	TAGGED_FROM(0.00)[bounces-18927-lists,linux-nfs=lfdr.de];
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
X-Rspamd-Queue-Id: 68458139D42
X-Rspamd-Action: no action

This option allowed the admin to restrict the client to using single-DES
encryption types, which were deprecated by RFC 6649 in July 2012.
Support for single-DES encryption types was removed from the MIT KRB5
library in May 2019, and from kernel's RPCSEC_GSS KRB5 mechanism in June
2023.

Signed-off-by: Scott Mayhew <smayhew@redhat.com>
---
 nfs.conf               |  1 -
 systemd/nfs.conf.man   |  2 +-
 utils/gssd/gssd.c      | 13 +------------
 utils/gssd/gssd.man    | 30 +++++-------------------------
 utils/gssd/krb5_util.c | 38 ++++++++++++++++----------------------
 utils/gssd/krb5_util.h |  1 -
 6 files changed, 23 insertions(+), 62 deletions(-)

diff --git a/nfs.conf b/nfs.conf
index 3cca68c3..222447dd 100644
--- a/nfs.conf
+++ b/nfs.conf
@@ -22,7 +22,6 @@
 # use-machine-creds=1
 # use-gss-proxy=0
 # avoid-dns=1
-# limit-to-legacy-enctypes=0
 # allowed-enctypes=aes256-cts-hmac-sha384-192,aes128-cts-hmac-sha256-128,camellia256-cts-cmac,camellia128-cts-cmac,aes256-cts-hmac-sha1-96,aes128-cts-hmac-sha1-96
 # context-timeout=0
 # rpc-timeout=5
diff --git a/systemd/nfs.conf.man b/systemd/nfs.conf.man
index ecdc4fc9..80c4f34e 100644
--- a/systemd/nfs.conf.man
+++ b/systemd/nfs.conf.man
@@ -266,7 +266,7 @@ Recognized values:
 .BR use-machine-creds ,
 .BR use-gss-proxy ,
 .BR avoid-dns ,
-.BR limit-to-legacy-enctypes ,
+.BR allowed-enctypes ,
 .BR context-timeout ,
 .BR rpc-timeout ,
 .BR keytab-file ,
diff --git a/utils/gssd/gssd.c b/utils/gssd/gssd.c
index 01ce7d18..8a894b2e 100644
--- a/utils/gssd/gssd.c
+++ b/utils/gssd/gssd.c
@@ -1034,10 +1034,6 @@ read_gss_conf(void)
 	root_uses_machine_creds = conf_get_bool("gssd", "use-machine-creds",
 						root_uses_machine_creds);
 	avoid_dns = conf_get_bool("gssd", "avoid-dns", avoid_dns);
-#ifdef HAVE_SET_ALLOWABLE_ENCTYPES
-	limit_to_legacy_enctypes = conf_get_bool("gssd", "limit-to-legacy-enctypes",
-						 limit_to_legacy_enctypes);
-#endif
 	context_timeout = conf_get_num("gssd", "context-timeout", context_timeout);
 	rpc_timeout = conf_get_num("gssd", "rpc-timeout", rpc_timeout);
 	upcall_timeout = conf_get_num("gssd", "upcall-timeout", upcall_timeout);
@@ -1084,7 +1080,7 @@ main(int argc, char *argv[])
 	verbosity = conf_get_num("gssd", "verbosity", verbosity);
 	rpc_verbosity = conf_get_num("gssd", "rpc-verbosity", rpc_verbosity);
 
-	while ((opt = getopt(argc, argv, "HDfvrlmnMp:k:d:t:T:R:U:C")) != -1) {
+	while ((opt = getopt(argc, argv, "HDfvrmnMp:k:d:t:T:R:U:C")) != -1) {
 		switch (opt) {
 			case 'f':
 				fg = 1;
@@ -1123,13 +1119,6 @@ main(int argc, char *argv[])
 			case 'R':
 				preferred_realm = strdup(optarg);
 				break;
-			case 'l':
-#ifdef HAVE_SET_ALLOWABLE_ENCTYPES
-				limit_to_legacy_enctypes = 1;
-#else 
-				errx(1, "Encryption type limits not supported by Kerberos libraries.");
-#endif
-				break;
 			case 'D':
 				avoid_dns = false;
 				break;
diff --git a/utils/gssd/gssd.man b/utils/gssd/gssd.man
index f81b24cd..57ad30cf 100644
--- a/utils/gssd/gssd.man
+++ b/utils/gssd/gssd.man
@@ -165,23 +165,15 @@ no keytab), NFSv4 operations that require machine credentials will fail.
 A realm administrator can choose to add keys encoded in a number of different
 encryption types to the local system's keytab.
 For instance, a host/ principal might have keys for the
-.BR aes256-cts-hmac-sha1-96 ,
-.BR aes128-cts-hmac-sha1-96 ,
-.BR des3-cbc-sha1 ", and"
-.BR arcfour-hmac " encryption types."
+.BR aes256-cts-hmac-sha384-192 ,
+.BR aes128-cts-hmac-sha256-128 ,
+.BR aes256-cts-hmac-sha1-96 ", and"
+.BR aes128-cts-hmac-sha1-96 " encryption types."
 This permits
 .B rpc.gssd
 to choose an appropriate encryption type that the target NFS server
 supports.
-.P
-These encryption types are stronger than legacy single-DES encryption types.
-To interoperate in environments where servers support
-only weak encryption types,
-you can restrict your client to use only single-DES encryption types
-by specifying the
-.B -l
-option when starting
-.BR rpc.gssd .
+
 .SH OPTIONS
 .TP
 .B \-D
@@ -225,14 +217,6 @@ to obtain machine credentials.
 The default value is
 .IR /etc/krb5.keytab .
 .TP
-.B -l
-When specified, restricts
-.B rpc.gssd
-to sessions to weak encryption types such as
-.BR des-cbc-crc .
-This option is available only when the local system's Kerberos library
-supports settable encryption types.
-.TP
 .BI "-p " path
 Tells
 .B rpc.gssd
@@ -342,10 +326,6 @@ is equivalent to providing the
 .B -D
 flag.
 .TP
-.B limit-to-legacy-enctypes
-Equivalent to
-.BR -l .
-.TP
 .B allowed-enctypes
 Allows you to restrict
 .B rpc.gssd
diff --git a/utils/gssd/krb5_util.c b/utils/gssd/krb5_util.c
index 137cffda..9c1016b3 100644
--- a/utils/gssd/krb5_util.c
+++ b/utils/gssd/krb5_util.c
@@ -155,7 +155,6 @@ static struct gssd_k5_kt_princ *gssd_k5_kt_princ_list = NULL;
 static pthread_mutex_t ple_lock = PTHREAD_MUTEX_INITIALIZER;
 
 #ifdef HAVE_SET_ALLOWABLE_ENCTYPES
-int limit_to_legacy_enctypes = 0;
 krb5_enctype *allowed_enctypes = NULL;
 int num_allowed_enctypes = 0;
 #endif
@@ -1661,10 +1660,6 @@ int
 limit_krb5_enctypes(struct rpc_gss_sec *sec)
 {
 	u_int maj_stat, min_stat;
-	krb5_enctype enctypes[] = { ENCTYPE_DES_CBC_CRC,
-				    ENCTYPE_DES_CBC_MD5,
-				    ENCTYPE_DES_CBC_MD4 };
-	int num_enctypes = sizeof(enctypes) / sizeof(enctypes[0]);
 	extern int num_krb5_enctypes;
 	extern krb5_enctype *krb5_enctypes;
 	extern int num_allowed_enctypes;
@@ -1679,26 +1674,25 @@ limit_krb5_enctypes(struct rpc_gss_sec *sec)
 			return -1;
 	}
 
-	/*
-	 * If we failed for any reason to produce global
-	 * list of supported enctypes, use local default here.
-	 */
-	if (krb5_enctypes == NULL || limit_to_legacy_enctypes ||
-			allowed_enctypes) {
-		if (allowed_enctypes) {
-			printerr(2, "%s: using allowed enctypes from config\n",
-				 __func__);
-			num_set_enctypes = num_allowed_enctypes;
-			set_enctypes = allowed_enctypes;
-		} else {
-			printerr(2, "%s: using legacy enctypes\n", __func__);
-			num_set_enctypes = num_enctypes;
-			set_enctypes = enctypes;
-		}
-	} else {
+	if (allowed_enctypes) {
+		printerr(2, "%s: using allowed enctypes from config\n",
+			 __func__);
+		num_set_enctypes = num_allowed_enctypes;
+		set_enctypes = allowed_enctypes;
+	} else if (krb5_enctypes) {
 		printerr(2, "%s: using enctypes from the kernel\n", __func__);
 		num_set_enctypes = num_krb5_enctypes;
 		set_enctypes = krb5_enctypes;
+	} else {
+		/*
+		 * If we didn't get a list of enctypes from the kernel, that
+		 * would mean it did a v0 upcall which is for older gssd's.
+		 * That would indicate a serious problem, so we shouldn't
+		 * continue.
+		 */
+		printerr(0, "%s: no enctypes received from the kernel, and "
+			 "allowed-enctypes not set in the config\n", __func__);
+		return -1;
 	}
 
 	maj_stat = gss_set_allowable_enctypes(&min_stat, sec->cred,
diff --git a/utils/gssd/krb5_util.h b/utils/gssd/krb5_util.h
index 40ad3233..af5f30be 100644
--- a/utils/gssd/krb5_util.h
+++ b/utils/gssd/krb5_util.h
@@ -25,7 +25,6 @@ int gssd_acquire_user_cred(gss_cred_id_t *gss_cred);
 int gssd_k5_remove_bad_service_cred(char *srvname);
 
 #ifdef HAVE_SET_ALLOWABLE_ENCTYPES
-extern int limit_to_legacy_enctypes;
 int limit_krb5_enctypes(struct rpc_gss_sec *sec);
 int get_allowed_enctypes(void);
 #endif
-- 
2.52.0


