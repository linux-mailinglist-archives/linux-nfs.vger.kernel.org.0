Return-Path: <linux-nfs+bounces-15691-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A2716C0EFF7
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Oct 2025 16:38:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C622D1883241
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Oct 2025 15:38:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2185C2FF17F;
	Mon, 27 Oct 2025 15:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IicYkU4X"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CA6B137923
	for <linux-nfs@vger.kernel.org>; Mon, 27 Oct 2025 15:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761579501; cv=none; b=rQYkg4P+uD7ZtO99K6tdcsM6LLmMRuTP4mlRKl0uehUIH4L+QK3hQg2px2LTCwJorfpwVkPH2r4FfmAbhz/9LA/txvRISpzAHj2YSp1PAHvvtlvxUgFCa0vUlkMQKV1n1TDaH401ydEWbCuO5gPjvZTPbjf576SAteIwsYybcoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761579501; c=relaxed/simple;
	bh=UQhUCzj8VgfS6UKcRYJes+MCBVze4czcLPSOfhz7gqM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NWVMc3KqYXh6aNAGDkX1YCGeyuDp2FWd0FunwVHFq+r/S+STXQXAfCnKJUkFWNPvWRmJ6l9BX8hHTuGjTXvgWYVXUOSSFLz32BneATNI1GiDJV649VqcKgCS/YtUdzWzHj+FTavtzKOTXILhoRFrjOBf3wcY4W0eX31WzRPZOOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IicYkU4X; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761579498;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=6AS3A7sm4o+hAdePQVfesYm71aZ2+f2Hr/eNyDxhxDo=;
	b=IicYkU4XQlHTFVoMnX50Q/NgJCBVW8tFsGad6/BXJeLxz/BBvqmtY+9PBSb6QAJTwcaDxQ
	8czf4MnbIzw8TSU4sKrR4NkrupbjW/Wqsx552TW4+YuNJtyqxX6JTaf6Xk8/Hy8dCPPOpp
	QyrMYzXHV4Vj2f+JoL6WBM+eoVtAIl8=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-626-RP372UuUN_eJKWGP-wOePw-1; Mon,
 27 Oct 2025 11:38:15 -0400
X-MC-Unique: RP372UuUN_eJKWGP-wOePw-1
X-Mimecast-MFC-AGG-ID: RP372UuUN_eJKWGP-wOePw_1761579493
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CB18919541B5
	for <linux-nfs@vger.kernel.org>; Mon, 27 Oct 2025 15:38:13 +0000 (UTC)
Received: from okorniev-mac.redhat.com (unknown [10.22.89.72])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2682D30001A7;
	Mon, 27 Oct 2025 15:38:12 +0000 (UTC)
From: Olga Kornievskaia <okorniev@redhat.com>
To: steved@redhat.com
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH 1/1] gssd: protect kerberos ticket cache access
Date: Mon, 27 Oct 2025 11:38:12 -0400
Message-ID: <20251027153812.80887-1-okorniev@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

gssd_get_single_krb5_cred() is a function that's will (for when needed)
send a TGT request to the KDC and then store it in a credential cache.
If multiple threads (eg., parallel mounts) are making an upcall at the
same time then getting creds and storing creds need to be serialized due
to do kerberos API not being concurrency safe.

Signed-off-by: Olga Kornievskaia <okorniev@redhat.com>
---
 utils/gssd/krb5_util.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/utils/gssd/krb5_util.c b/utils/gssd/krb5_util.c
index 09625fb9..137cffda 100644
--- a/utils/gssd/krb5_util.c
+++ b/utils/gssd/krb5_util.c
@@ -456,12 +456,14 @@ gssd_get_single_krb5_cred(krb5_context context,
 	krb5_get_init_creds_opt_set_tkt_life(opts, 5*60);
 #endif
 
+	pthread_mutex_lock(&ple_lock);
 	if ((code = krb5_get_init_creds_opt_set_out_ccache(context, opts,
 							   ccache))) {
 		k5err = gssd_k5_err_msg(context, code);
 		printerr(1, "WARNING: %s while initializing ccache for "
 			 "principal '%s' using keytab '%s'\n", k5err,
 			 pname ? pname : "<unparsable>", kt_name);
+		pthread_mutex_unlock(&ple_lock);
 		goto out;
 	}
 	if ((code = krb5_get_init_creds_keytab(context, &my_creds, ple->princ,
@@ -470,10 +472,10 @@ gssd_get_single_krb5_cred(krb5_context context,
 		printerr(1, "WARNING: %s while getting initial ticket for "
 			 "principal '%s' using keytab '%s'\n", k5err,
 			 pname ? pname : "<unparsable>", kt_name);
+		pthread_mutex_unlock(&ple_lock);
 		goto out;
 	}
 
-	pthread_mutex_lock(&ple_lock);
 	ple->endtime = my_creds.times.endtime;
 	pthread_mutex_unlock(&ple_lock);
 
-- 
2.47.0


