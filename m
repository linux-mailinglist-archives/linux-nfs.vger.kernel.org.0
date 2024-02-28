Return-Path: <linux-nfs+bounces-2118-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C03086BAAD
	for <lists+linux-nfs@lfdr.de>; Wed, 28 Feb 2024 23:23:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBC70287989
	for <lists+linux-nfs@lfdr.de>; Wed, 28 Feb 2024 22:23:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68E111361DC;
	Wed, 28 Feb 2024 22:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i268dFL9"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 794ED3FBBE
	for <linux-nfs@vger.kernel.org>; Wed, 28 Feb 2024 22:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709158979; cv=none; b=sLHgfr/3fY9+gimnYFGx82C0i/5evxzX76RZkk/cQxVSkIsHV9ipZmkfERIzJltuBC/rtc3/D36q/YWXp2gKzbpTLhPFwXRihfNhoVxJ4tXYLb3p0EwDjRFHav1I0Dj70YrtrJWM2p4Cn7fKf+V9u/qvF1aKP4nYIXhfmpobuuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709158979; c=relaxed/simple;
	bh=gQPbN78l0G5UhYzzNio6aDA8pJOtwD2QcGS5oS4sQV0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gGUXZfmhFu+VqFZ9CgsttViRvczcE6CQ+jYv1upE0kwB9R0gofZV3ucPidwTXtRrK/YdAvvyAsIMhRUMu8iVxonKcIPOU/Y0grOE1GZBxuE5Q4Uvg3SmCfMfMVSz6QfaEkLu9349hig7zpkjJV96GlShzeHoxiGqlYti3RGjJPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=i268dFL9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709158976;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=88zbIXTngUBi8lmvyV3GlfyN3qReZppAhoBY6z+1TI4=;
	b=i268dFL9JTcrU4HyEwofdrihfA9I+jtGNOTwXKvDP1y2D0NiW1nKPX4eVugA6i4UFWOktn
	iuOh1sy3Ve2N8YBxir1D8aRd8UhtEoyrNpxPMB2J6J/cEyJsnWWw84f45IBtMz2hnO5gW3
	RAGOMxazniuw9C1+qZkNmRsFFUC4aoM=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-265-mMbkOgkRNuuiyV1hPD_YTw-1; Wed,
 28 Feb 2024 17:22:54 -0500
X-MC-Unique: mMbkOgkRNuuiyV1hPD_YTw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7AAE93C108C4
	for <linux-nfs@vger.kernel.org>; Wed, 28 Feb 2024 22:22:54 +0000 (UTC)
Received: from aion.redhat.com (unknown [10.22.16.176])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 6736AF63F1;
	Wed, 28 Feb 2024 22:22:54 +0000 (UTC)
Received: from aion.redhat.com (localhost [IPv6:::1])
	by aion.redhat.com (Postfix) with ESMTP id 0FE8512BBBC;
	Wed, 28 Feb 2024 17:22:54 -0500 (EST)
From: Scott Mayhew <smayhew@redhat.com>
To: steved@redhat.com
Cc: linux-nfs@vger.kernel.org
Subject: [nfs-utils PATCH 2/2] gssd: add a "backoff" feature to limit_krb5_enctypes()
Date: Wed, 28 Feb 2024 17:22:53 -0500
Message-ID: <20240228222253.1080880-3-smayhew@redhat.com>
In-Reply-To: <20240228222253.1080880-1-smayhew@redhat.com>
References: <20240228222253.1080880-1-smayhew@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1

If the NFS server reset the connection when we tried to create a GSS
context with it, then there's a good chance that we used an encryption
type that it didn't support.

Add a one time backoff/retry mechanism, where we adjust the list of
encryption types that we set via gss_set_allowable_enctypes().  We can
do this easily because the list of encryption types should be ordered
from highest preference to lowest.  We just need to find the first entry
that's not one of the newer encryption types, and then use that as the
start of the list.

Signed-off-by: Scott Mayhew <smayhew@redhat.com>
---
 utils/gssd/gssd_proc.c | 15 +++++++++++++--
 utils/gssd/krb5_util.c | 40 +++++++++++++++++++++++++++++++++++++++-
 utils/gssd/krb5_util.h |  2 +-
 3 files changed, 53 insertions(+), 4 deletions(-)

diff --git a/utils/gssd/gssd_proc.c b/utils/gssd/gssd_proc.c
index 7629de0b..0da54598 100644
--- a/utils/gssd/gssd_proc.c
+++ b/utils/gssd/gssd_proc.c
@@ -337,6 +337,10 @@ create_auth_rpc_client(struct clnt_info *clp,
 	rpc_gss_options_req_t	req;
 	rpc_gss_options_ret_t	ret;
 	char			mechanism[] = "kerberos_v5";
+#endif
+#ifdef HAVE_SET_ALLOWABLE_ENCTYPES
+	bool			backoff = false;
+	struct rpc_err		err;
 #endif
 	pthread_t tid = pthread_self();
 
@@ -354,14 +358,14 @@ create_auth_rpc_client(struct clnt_info *clp,
 		goto out_fail;
 	}
 
-
 	if (authtype == AUTHTYPE_KRB5) {
 #ifdef HAVE_SET_ALLOWABLE_ENCTYPES
+again:
 		/*
 		 * Do this before creating rpc connection since we won't need
 		 * rpc connection if it fails!
 		 */
-		if (limit_krb5_enctypes(&sec)) {
+		if (limit_krb5_enctypes(&sec, backoff)) {
 			printerr(1, "WARNING: Failed while limiting krb5 "
 				    "encryption types for user with uid %d\n",
 				 uid);
@@ -445,6 +449,13 @@ create_auth_rpc_client(struct clnt_info *clp,
 					goto success;
 			}
 		}
+#endif
+#ifdef HAVE_SET_ALLOWABLE_ENCTYPES
+		clnt_geterr(rpc_clnt, &err);
+		if (err.re_errno == ECONNRESET && !backoff) {
+			backoff = true;
+			goto again;
+		}
 #endif
 		/* Our caller should print appropriate message */
 		printerr(2, "WARNING: Failed to create krb5 context for "
diff --git a/utils/gssd/krb5_util.c b/utils/gssd/krb5_util.c
index 57b3cf8a..5502e74e 100644
--- a/utils/gssd/krb5_util.c
+++ b/utils/gssd/krb5_util.c
@@ -1675,7 +1675,7 @@ out:
  */
 
 int
-limit_krb5_enctypes(struct rpc_gss_sec *sec)
+limit_krb5_enctypes(struct rpc_gss_sec *sec, bool backoff)
 {
 	u_int maj_stat, min_stat;
 	krb5_enctype enctypes[] = { ENCTYPE_DES_CBC_CRC,
@@ -1689,6 +1689,17 @@ limit_krb5_enctypes(struct rpc_gss_sec *sec)
 	int num_set_enctypes;
 	krb5_enctype *set_enctypes;
 	int err = -1;
+	int i, j;
+	bool done = false;
+
+	if (backoff && sec->cred != GSS_C_NO_CREDENTIAL) {
+		printerr(2, "%s: backoff: releasing old cred\n", __func__);
+		maj_stat = gss_release_cred(&min_stat, &sec->cred);
+		if (maj_stat != GSS_S_COMPLETE) {
+			printerr(2, "%s: gss_release_cred() failed\n", __func__);
+			return -1;
+		}
+	}
 
 	if (sec->cred == GSS_C_NO_CREDENTIAL) {
 		err = gssd_acquire_krb5_cred(&sec->cred);
@@ -1718,6 +1729,33 @@ limit_krb5_enctypes(struct rpc_gss_sec *sec)
 		set_enctypes = krb5_enctypes;
 	}
 
+	if (backoff) {
+		j = num_set_enctypes;
+		for (i = 0; i < j && !done; i++) {
+			switch (*set_enctypes) {
+			case ENCTYPE_AES128_CTS_HMAC_SHA256_128:
+			case ENCTYPE_AES256_CTS_HMAC_SHA384_192:
+			case ENCTYPE_CAMELLIA128_CTS_CMAC:
+			case ENCTYPE_CAMELLIA256_CTS_CMAC:
+				printerr(2, "%s: backoff: removing enctype %d\n",
+					 __func__, *set_enctypes);
+				set_enctypes++;
+				num_set_enctypes--;
+				break;
+			default:
+				done = true;
+				break;
+			}
+		}
+		printerr(2, "%s: backoff: %d remaining enctypes\n",
+			 __func__, num_set_enctypes);
+		if (!num_set_enctypes) {
+			printerr(0, "%s: no remaining enctypes after backoff\n",
+				 __func__);
+			return -1;
+		}
+	}
+
 	maj_stat = gss_set_allowable_enctypes(&min_stat, sec->cred,
 				&krb5oid, num_set_enctypes, set_enctypes);
 
diff --git a/utils/gssd/krb5_util.h b/utils/gssd/krb5_util.h
index 40ad3233..0be0c500 100644
--- a/utils/gssd/krb5_util.h
+++ b/utils/gssd/krb5_util.h
@@ -26,7 +26,7 @@ int gssd_k5_remove_bad_service_cred(char *srvname);
 
 #ifdef HAVE_SET_ALLOWABLE_ENCTYPES
 extern int limit_to_legacy_enctypes;
-int limit_krb5_enctypes(struct rpc_gss_sec *sec);
+int limit_krb5_enctypes(struct rpc_gss_sec *sec, bool backoff);
 int get_allowed_enctypes(void);
 #endif
 
-- 
2.43.0


