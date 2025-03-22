Return-Path: <linux-nfs+bounces-10754-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8B20A6C69F
	for <lists+linux-nfs@lfdr.de>; Sat, 22 Mar 2025 01:13:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EC88F7A6BF1
	for <lists+linux-nfs@lfdr.de>; Sat, 22 Mar 2025 00:12:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC23A800;
	Sat, 22 Mar 2025 00:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ayn9rDcx"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD5C92E3371
	for <linux-nfs@vger.kernel.org>; Sat, 22 Mar 2025 00:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742602404; cv=none; b=f2s+AHzWM3EiGlJ98a0o1h6kfGjmCVRMVDveF1ycBcBqT45+VADjlTSqIlJYACw/eIaLv4YLp1ZNy/IcNf+PI39T5Mejpmveb62dX/YKVc3LCPil8M8TwV11wE72dDqwbMZzzNu3AS/8YtKuQiktAtPbKUJbc+HZRtrhpaEtc/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742602404; c=relaxed/simple;
	bh=kmj1nyCRII/tS6gbX/G5Ycz12ZOx/v58rNByfUQ/gqw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=If7YyyiSeGSq7j7jcour6KWkGUBKojyRWm0uVC/i0mCiup2PdjABLCs4QBTnOpCB8UDRrSoztGPfm6rDXD++h7k48Fmsd7ggyHd1QdMOaw7KTXY51CMuSfh11nQ+P0WeQzI4ayrQlwWC8XT5ne5bR1pxahFHquMjGWRo19XzQb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ayn9rDcx; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742602402;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YDiO4WQUSD1u8H75do5m+dIMRG7CpKjmHiZjR5AkofE=;
	b=Ayn9rDcxA8oA3wQY5GGucbZ2D8hJMBaPAZgOduDFH6yunB8+iAp5xeGetXmM5NDxouP0GV
	B2S3wWO4ch9I2Er+0q+xqWMueY+hheuTEKUrnTFd2tfUaDu0OacPL0wxVMpodcrzjyuuuk
	Cy1sep6nMtDu+KGBHMwB/IAvTcizFo4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-653-VodmJoAqPsSdQaZnuzA0_Q-1; Fri,
 21 Mar 2025 20:13:18 -0400
X-MC-Unique: VodmJoAqPsSdQaZnuzA0_Q-1
X-Mimecast-MFC-AGG-ID: VodmJoAqPsSdQaZnuzA0_Q_1742602397
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 307F9180049D;
	Sat, 22 Mar 2025 00:13:17 +0000 (UTC)
Received: from okorniev-mac.redhat.com (unknown [10.22.64.19])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id CC1561955DCE;
	Sat, 22 Mar 2025 00:13:15 +0000 (UTC)
From: Olga Kornievskaia <okorniev@redhat.com>
To: chuck.lever@oracle.com,
	jlayton@kernel.org
Cc: linux-nfs@vger.kernel.org,
	neilb@suse.de,
	Dai.Ngo@oracle.com,
	tom@talpey.com,
	Olga Kornievskaia <okorniev@redhat.com>
Subject: [PATCH 2/3] nfsd: adjust nfsd4_spo_must_allow checking order
Date: Fri, 21 Mar 2025 20:13:05 -0400
Message-Id: <20250322001306.41666-3-okorniev@redhat.com>
In-Reply-To: <20250322001306.41666-1-okorniev@redhat.com>
References: <20250322001306.41666-1-okorniev@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Prior to this patch, some non-4.x NFS operations such as NLM
calls have to go thru export policy checking would end up
calling nfsd4_spo_must_allow() function and lead to an
out-of-bounds error because no compound state structures
needed by nfsd4_spo_must_allow() are present in the svc_rqst
request structure.

Instead, do the nfsd4_spo_must_allow() checking after the
may_bypass_gss check which is geared towards allowing various
calls such as NLM while export policy is set with sec=krb5:...

Fixes: 4cc9b9f2bf4d ("nfsd: refine and rename NFSD_MAY_LOCK")
Signed-off-by: Olga Kornievskaia <okorniev@redhat.com>
---
 fs/nfsd/export.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/fs/nfsd/export.c b/fs/nfsd/export.c
index 88ae410b4113..02f26cbd59d0 100644
--- a/fs/nfsd/export.c
+++ b/fs/nfsd/export.c
@@ -1143,15 +1143,6 @@ __be32 check_nfsd_access(struct svc_export *exp, struct svc_rqst *rqstp,
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
@@ -1168,6 +1159,14 @@ __be32 check_nfsd_access(struct svc_export *exp, struct svc_rqst *rqstp,
 				return 0;
 		}
 	}
+	/* If the compound op contains a spo_must_allowed op,
+	 * it will be sent with integrity/protection which
+	 * will have to be expressly allowed on mounts that
+	 * don't support it
+	 */
+	if (nfsd4_spo_must_allow(rqstp))
+		return nfs_ok;
+
 
 denied:
 	return nfserr_wrongsec;
-- 
2.47.1


