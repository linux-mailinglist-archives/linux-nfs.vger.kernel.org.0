Return-Path: <linux-nfs+bounces-10703-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FEBBA69B29
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Mar 2025 22:47:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B36338A7B9B
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Mar 2025 21:46:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A7EC1E520D;
	Wed, 19 Mar 2025 21:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ClwDKXzf"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78770213235
	for <linux-nfs@vger.kernel.org>; Wed, 19 Mar 2025 21:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742420814; cv=none; b=LBhDZi7UoA8pbhkGiKXEV6YUWprBkydQ6N4iZ5vOIDKh3IwX+v1Qv0Y66qHD8Eibdwmc/yO8M3qF8lZIDc3HkNCYq8+6ruKpPdRyeFyAyZllbOC2HXc7cAZLH4qx3NUZlR3m5ksQL96xpbW4mZS9SzmUKI5s6yMFthHr8bKFn1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742420814; c=relaxed/simple;
	bh=xkd3ExdNDUXClktLVKtBpNGXV74PtQP0snzmq41GVtI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=q+n4L7e2CSpElo8S7fajgKgopzwv6+J4Ct3G7nfEbuLADZQLV1ihr6yFTOAIHa8sZinjidFMtyM0JwfHNoIUWENav10N+2miNK9FQ2PXY6PINEtyno5ftAYPahDKKFMc2rIQvNrdFnwhVpS8VpUVnX2drRGi/t8BFkUKi8TU8jU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ClwDKXzf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742420811;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=F2YT91mHWQscwxZm5pqWAN3/c4B3mqHQ/2m5wVL5GVU=;
	b=ClwDKXzfJHNEA/Xwt52AOTqtLE/icPMceImK3x1rRRseMEAiNal5DMRQBUkyNysWmzzf0Z
	eQv3X9CxM3Ck8YI7Ufa7n8Z5VA3RBzcb38hUFOnvksctFm8eu9wdg2X5cOCMdkws6bE2OH
	STkDEHhyCD189VXENjTr9yxetrxIflA=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-692-XbVdzDUCOyenvYx3qpS11g-1; Wed,
 19 Mar 2025 17:46:47 -0400
X-MC-Unique: XbVdzDUCOyenvYx3qpS11g-1
X-Mimecast-MFC-AGG-ID: XbVdzDUCOyenvYx3qpS11g_1742420806
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4E25319560B2;
	Wed, 19 Mar 2025 21:46:46 +0000 (UTC)
Received: from okorniev-mac.redhat.com (unknown [10.22.81.201])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 79CE91956095;
	Wed, 19 Mar 2025 21:46:44 +0000 (UTC)
From: Olga Kornievskaia <okorniev@redhat.com>
To: chuck.lever@oracle.com,
	jlayton@kernel.org
Cc: linux-nfs@vger.kernel.org,
	neilb@suse.de,
	Dai.Ngo@oracle.com,
	tom@talpey.com,
	Olga Kornievskaia <okorniev@redhat.com>
Subject: [PATCH 1/1] nfsd: fix NLM access checking
Date: Wed, 19 Mar 2025 17:46:41 -0400
Message-Id: <20250319214641.27699-1-okorniev@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Since commit 4cc9b9f2bf4df ("nfsd: refine and rename NFSD_MAY_LOCK")
for export policies with "sec=krb5:..." or "xprtsec=tls:.." NLM
locking calls on v3 mounts fail. And for "sec=krb5" NLM calls it
also leads to out-of-bounds reference while in check_nfsd_access().

This patch does 3 fixes. 2 problems are related to sec=krb5.
First is fixing what "access" content is being passed into
the inode_permission(). Prior to 4cc9b9f2bf4df, the code would
explicitly set access to be read/ownership. And after is passes
access that's set in nlm_fopen but it's lacking read access.
Second is because previously for NLM check_nfsd_access() was
never called and thus nfsd4_spo_must_allow() function wasn't
called. After the patch, this lead to NLM call which has no
compound state structure created trying to dereference it.
This patch instead moves the call to after may_bypass_gss
check which implies NLM and would return there and would
never get to calling nfsd4_spo_must_allow().

The last problem is related to TLS export policy. NLM dont
come over TLS and thus dont pass the TLS checks in
check_nfsd_access() leading to access being denied. Instead
rely on may_bypass_gss to indicate NLM and allow access
checking to continue.

Fixes: 4cc9b9f2bf4df ("nfsd: refine and rename NFSD_MAY_LOCK")
Signed-off-by: Olga Kornievskaia <okorniev@redhat.com>
---
 fs/nfsd/export.c | 23 +++++++++++++----------
 fs/nfsd/vfs.c    |  4 ++++
 2 files changed, 17 insertions(+), 10 deletions(-)

diff --git a/fs/nfsd/export.c b/fs/nfsd/export.c
index 0363720280d4..4cbf617efa7c 100644
--- a/fs/nfsd/export.c
+++ b/fs/nfsd/export.c
@@ -1124,7 +1124,8 @@ __be32 check_nfsd_access(struct svc_export *exp, struct svc_rqst *rqstp,
 		    test_bit(XPT_PEER_AUTH, &xprt->xpt_flags))
 			goto ok;
 	}
-	goto denied;
+	if (!may_bypass_gss)
+		goto denied;
 
 ok:
 	/* legacy gss-only clients are always OK: */
@@ -1142,15 +1143,6 @@ __be32 check_nfsd_access(struct svc_export *exp, struct svc_rqst *rqstp,
 			return nfs_ok;
 	}
 
-	/* If the compound op contains a spo_must_allowed op,
-	 * it will be sent with integrity/protection which
-	 * will have to be expressly allowed on mounts that
-	 * don't support it
-	 */
-
-	if (nfsd4_spo_must_allow(rqstp))
-		return nfs_ok;
-
 	/* Some calls may be processed without authentication
 	 * on GSS exports. For example NFS2/3 calls on root
 	 * directory, see section 2.3.2 of rfc 2623.
@@ -1168,6 +1160,17 @@ __be32 check_nfsd_access(struct svc_export *exp, struct svc_rqst *rqstp,
 		}
 	}
 
+	/* If the compound op contains a spo_must_allowed op,
+	 * it will be sent with integrity/protection which
+	 * will have to be expressly allowed on mounts that
+	 * don't support it
+	 */
+	/* This call must be done after the may_bypass_gss check.
+	 * may_bypass_gss implies NLM(/MOUNT) and not 4.1
+	 */
+	if (nfsd4_spo_must_allow(rqstp))
+		return nfs_ok;
+
 denied:
 	return nfserr_wrongsec;
 }
diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 4021b047eb18..95d973136079 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -2600,6 +2600,10 @@ nfsd_permission(struct svc_cred *cred, struct svc_export *exp,
 	    uid_eq(inode->i_uid, current_fsuid()))
 		return 0;
 
+	/* If this is NLM, require read or ownership permissions */
+	if (acc & NFSD_MAY_NLM)
+		acc = NFSD_MAY_READ | NFSD_MAY_OWNER_OVERRIDE;
+
 	/* This assumes  NFSD_MAY_{READ,WRITE,EXEC} == MAY_{READ,WRITE,EXEC} */
 	err = inode_permission(&nop_mnt_idmap, inode,
 			       acc & (MAY_READ | MAY_WRITE | MAY_EXEC));
-- 
2.47.1


