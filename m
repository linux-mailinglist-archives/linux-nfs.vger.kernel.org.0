Return-Path: <linux-nfs+bounces-10753-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 30E3BA6C69D
	for <lists+linux-nfs@lfdr.de>; Sat, 22 Mar 2025 01:13:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B110C189FFF7
	for <lists+linux-nfs@lfdr.de>; Sat, 22 Mar 2025 00:13:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3409173;
	Sat, 22 Mar 2025 00:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HkLf3s7q"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 120CE1372
	for <linux-nfs@vger.kernel.org>; Sat, 22 Mar 2025 00:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742602402; cv=none; b=uCvlPj/xC4hFWbLM10m8cji2GLtWDtAlaH87sssco5DiGhVkPEUkugWrNbhWAz5SpzSVrfRMob6EmkeMwyzA6JvKrP+OT1ClMxz+vsMnjiVIp3BhBcvNDs8ztX3KZMYmhCfEusDiW+iO1/G/091kyVHhyPWS8pdi3h18G7PrdC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742602402; c=relaxed/simple;
	bh=1asiAw1ri2UWtE20KHscvm9P09T/V+kTqFH4FeHo/Dg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=G4INrqWezqECoCoMNVoFcxHl7yfewDd6Sw4n1+8dr3F0XjYbimY0O8aSWoQ/hjpUKmVyMykQ/oGXv7qZpdJpEM7XaAhrN2toKIRHk+SoYgs8uFM0buCUstWhRhKDqP3ekFpCfAmlBdqA9UxXZ2ZKRFRheyxYzEgyMRcZrsaHDBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HkLf3s7q; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742602400;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=45hLfyuBD/lS8WUvn+1KftJK5CXmdLmMv7j8pBaYo4c=;
	b=HkLf3s7qUvpHqn1aihJIB9ozRg/g5wTO5rZB7qZfH3NkkiwfXLrQY79iOdTgOLctAVCyxo
	KHWqoOkL24hsP6IS4C+jnRTdoSAj6R/WjKBdftpmxMJEriAtA+eKSc0BWAUCpoM4bkSwCf
	c5/x/gzMnznrCzbdsBDYcltbFhWIe1Y=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-150-1HwaIsOBN_aytdznGGa7mg-1; Fri,
 21 Mar 2025 20:13:16 -0400
X-MC-Unique: 1HwaIsOBN_aytdznGGa7mg-1
X-Mimecast-MFC-AGG-ID: 1HwaIsOBN_aytdznGGa7mg_1742602394
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C444A18007E1;
	Sat, 22 Mar 2025 00:13:14 +0000 (UTC)
Received: from okorniev-mac.redhat.com (unknown [10.22.64.19])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0EB6E19560AF;
	Sat, 22 Mar 2025 00:13:12 +0000 (UTC)
From: Olga Kornievskaia <okorniev@redhat.com>
To: chuck.lever@oracle.com,
	jlayton@kernel.org
Cc: linux-nfs@vger.kernel.org,
	neilb@suse.de,
	Dai.Ngo@oracle.com,
	tom@talpey.com,
	Olga Kornievskaia <okorniev@redhat.com>
Subject: [PATCH 1/3] nfsd: fix access checking for NLM under XPRTSEC policies
Date: Fri, 21 Mar 2025 20:13:04 -0400
Message-Id: <20250322001306.41666-2-okorniev@redhat.com>
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

When an export policy with xprtsec policy is set with "tls"
and/or "mtls", but an NFS client is doing a v3 xprtsec=tls
mount, then NLM locking calls fail with an error because
there is currently no support for NLM with TLS.

Until such support is added, allow NLM calls under TLS-secured
policy.

Fixes: 4cc9b9f2bf4d ("nfsd: refine and rename NFSD_MAY_LOCK")
Signed-off-by: Olga Kornievskaia <okorniev@redhat.com>
---
 fs/nfsd/export.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/nfsd/export.c b/fs/nfsd/export.c
index 0363720280d4..88ae410b4113 100644
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
-- 
2.47.1


