Return-Path: <linux-nfs+bounces-13731-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 42419B2AC34
	for <lists+linux-nfs@lfdr.de>; Mon, 18 Aug 2025 17:13:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 605671897627
	for <lists+linux-nfs@lfdr.de>; Mon, 18 Aug 2025 15:09:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D21A3233133;
	Mon, 18 Aug 2025 15:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X6b2Gt49"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 323F5248F7C
	for <linux-nfs@vger.kernel.org>; Mon, 18 Aug 2025 15:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755529728; cv=none; b=ZwYx8Ujy8wCkR2g9q5jRJD7I/29DoAvpsAzUTWJduVZoclSD7EspfJEJdQOcv0Gtcoajm65JdjyjMbYA2VcggdemtYLNoAbD0R3zMYR7gK7n60++jBuGQXLzE+213Ib4THT90LDgr1JlffT9v5J0eKxHjCcsiPQjKGzE5AV0N7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755529728; c=relaxed/simple;
	bh=VsXOc1S4ap0B42nAyjWEeWqOQ+Gec9oY/uBK21jhEz4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rdKrGvVD6KqV7Aw/HegOvsoFKSnsHoS/ogmc8Gg8m6SBvya0v6e+AMqtpAazSxNbt1BJ4eqZKb3U2zy+FKdPjsRP1CMVnCp03iv6Q+KVV0dd8R+KfJ/0pQDZgIizumqHaj0sIe6PnHYODmrTTPRDXTJoBsuPN3brVqCzstJHB/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=X6b2Gt49; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755529726;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6jKrMmmjaF5f4Ut7LCPyvP+C7XbkD8LpIfSPKWAXHuY=;
	b=X6b2Gt4997myudJWS7177NrGEG+N6I3TgTKeQVLSgFf6WO35+c13IdO3i1HhaOwtbM3uYj
	oSOsuRnc4DLVmkHbdySRbecH/zVPsVJKqSdEyrCwQaVueTwp725U33t6Ck0usjMztNBCTC
	F8R9oZ/NQPifFOMvNgDAW/W5bkjwAbY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-228-zfQAYFVUNRe_vKhA09d3Pg-1; Mon,
 18 Aug 2025 11:08:42 -0400
X-MC-Unique: zfQAYFVUNRe_vKhA09d3Pg-1
X-Mimecast-MFC-AGG-ID: zfQAYFVUNRe_vKhA09d3Pg_1755529721
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AB07B19560A6;
	Mon, 18 Aug 2025 15:08:41 +0000 (UTC)
Received: from dobby.home.dicksonnet.net (unknown [10.22.64.4])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id F2A6430001A8;
	Mon, 18 Aug 2025 15:08:40 +0000 (UTC)
From: Steve Dickson <steved@redhat.com>
To: Libtirpc-devel Mailing List <libtirpc-devel@lists.sourceforge.net>
Cc: Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Subject: [PATCH 08/12] Convert old-style function definitions into modern-style definitions
Date: Mon, 18 Aug 2025 11:08:25 -0400
Message-ID: <20250818150829.1044948-9-steved@redhat.com>
In-Reply-To: <20250818150829.1044948-1-steved@redhat.com>
References: <20250818150829.1044948-1-steved@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

With newer compilers (gcc 15.1.1) -Wold-style-definition
flag is set by default which causes warnings for
most of the functions in these files.

    warning: old-style function definition [-Wold-style-definition]

The warnings are remove by converting the old-style
function definitions into modern-style definitions

Signed-off-by: Steve Dickson <steved@redhat.com>
---
 src/key_call.c | 58 +++++++++++++++++++++++---------------------------
 1 file changed, 27 insertions(+), 31 deletions(-)

diff --git a/src/key_call.c b/src/key_call.c
index 43f990e..e33e444 100644
--- a/src/key_call.c
+++ b/src/key_call.c
@@ -79,8 +79,7 @@ des_block *(*__key_gendes_LOCAL)(uid_t, char *) = 0;
 static int key_call( u_long, xdrproc_t, void *, xdrproc_t, void *);
 
 int
-key_setsecret(secretkey)
-	const char *secretkey;
+key_setsecret(const char *secretkey)
 {
 	keystatus status;
 
@@ -122,10 +121,10 @@ key_secretkey_is_set(void)
 }
 
 int
-key_encryptsession_pk(remotename, remotekey, deskey)
-	char *remotename;
-	netobj *remotekey;
-	des_block *deskey;
+key_encryptsession_pk(
+	char *remotename,
+	netobj *remotekey,
+	des_block *deskey)
 {
 	cryptkeyarg2 arg;
 	cryptkeyres res;
@@ -146,10 +145,10 @@ key_encryptsession_pk(remotename, remotekey, deskey)
 }
 
 int
-key_decryptsession_pk(remotename, remotekey, deskey)
-	char *remotename;
-	netobj *remotekey;
-	des_block *deskey;
+key_decryptsession_pk(
+	char *remotename,
+	netobj *remotekey,
+	des_block *deskey)
 {
 	cryptkeyarg2 arg;
 	cryptkeyres res;
@@ -170,9 +169,9 @@ key_decryptsession_pk(remotename, remotekey, deskey)
 }
 
 int
-key_encryptsession(remotename, deskey)
-	const char *remotename;
-	des_block *deskey;
+key_encryptsession(
+	const char *remotename,
+	des_block *deskey)
 {
 	cryptkeyarg arg;
 	cryptkeyres res;
@@ -192,9 +191,9 @@ key_encryptsession(remotename, deskey)
 }
 
 int
-key_decryptsession(remotename, deskey)
-	const char *remotename;
-	des_block *deskey;
+key_decryptsession(
+	const char *remotename,
+	des_block *deskey)
 {
 	cryptkeyarg arg;
 	cryptkeyres res;
@@ -214,8 +213,7 @@ key_decryptsession(remotename, deskey)
 }
 
 int
-key_gendes(key)
-	des_block *key;
+key_gendes(des_block *key)
 {
 	if (!key_call((u_long)KEY_GEN, (xdrproc_t)xdr_void, NULL,
 			(xdrproc_t)xdr_des_block, key)) {
@@ -225,8 +223,7 @@ key_gendes(key)
 }
 
 int
-key_setnet(arg)
-struct key_netstarg *arg;
+key_setnet(struct key_netstarg *arg)
 {
 	keystatus status;
 
@@ -245,9 +242,9 @@ struct key_netstarg *arg;
 
 
 int
-key_get_conv(pkey, deskey)
-	char *pkey;
-	des_block *deskey;
+key_get_conv(
+	char *pkey,
+	des_block *deskey)
 {
 	cryptkeyres res;
 
@@ -286,8 +283,7 @@ key_call_destroy(void *vp)
  * Keep the handle cached.  This call may be made quite often.
  */
 static CLIENT *
-getkeyserv_handle(vers)
-int	vers;
+getkeyserv_handle(int vers)
 {
 	void *localhandle;
 	struct netconfig *nconf;
@@ -396,12 +392,12 @@ int	vers;
 /* returns  0 on failure, 1 on success */
 
 static int
-key_call(proc, xdr_arg, arg, xdr_rslt, rslt)
-	u_long proc;
-	xdrproc_t xdr_arg;
-	void *arg;
-	xdrproc_t xdr_rslt;
-	void *rslt;
+key_call(
+	u_long proc,
+	xdrproc_t xdr_arg,
+	void *arg,
+	xdrproc_t xdr_rslt,
+	void *rslt)
 {
 	CLIENT *clnt;
 	struct timeval wait_time;
-- 
2.50.1


