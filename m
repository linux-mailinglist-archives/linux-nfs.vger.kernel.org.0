Return-Path: <linux-nfs+bounces-15109-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CB68BCAD0E
	for <lists+linux-nfs@lfdr.de>; Thu, 09 Oct 2025 22:38:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE176423D84
	for <lists+linux-nfs@lfdr.de>; Thu,  9 Oct 2025 20:38:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FA011632DD;
	Thu,  9 Oct 2025 20:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QshXhCEF"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CBE943ABC
	for <linux-nfs@vger.kernel.org>; Thu,  9 Oct 2025 20:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760042289; cv=none; b=epBSoB/vIG5/fewVHQDm1lIi2mcAZvxwghVmp7LXtr2Tig/9m0QMLK1k8k/LgayLcj+OOnscqx/w9tMhdEpxUJuYiV9b9jIirIiCXc9mEuB5jSWs1LQrhy+6+j47w1oWHTrv/7cUMG5lQ3WJH7G638l3cEQTNYVLhK+LWjbjQ84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760042289; c=relaxed/simple;
	bh=DjRECO4S5B29M8Gj9fmbO9fIykQwfuCH1QNYQHLYsPc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TBUqu1WsMh9QntGeFWosdvjtT8JFjsAaBlnqpIgXa246lgvVccHypnTG5nKM+12oWt2AeIst6SJ/wiOys//YfScRZZQxQwWq5XSTeLLiCkDLLHXfMUr6NflWNRh2ogcpWP4ZtvTDoCVl09pphdptRDglHoKml557+tY++6tGUJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QshXhCEF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760042286;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=F7vbsg/T4gv5vmAkrwkfU8xnWv+zlKQTbjxWI5xLS4Y=;
	b=QshXhCEFUDPR8uUwZu1GbjSvXRYIAiYylIC8GBIfG6WkCTFClCSxTTjE+UkQDmHXJqtDyu
	DqrbT+84rmaT+OSZv258NrvPQ56zEMyF2scGfKTtzZKtcKJ++TtPvyPC9MTYN2k+BNHsIH
	/V4BrcfLdIJ6tsKWlscy2wuiq8lghbc=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-302-4KYM8waSNiW0i5laMZYA8A-1; Thu,
 09 Oct 2025 16:38:03 -0400
X-MC-Unique: 4KYM8waSNiW0i5laMZYA8A-1
X-Mimecast-MFC-AGG-ID: 4KYM8waSNiW0i5laMZYA8A_1760042282
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D3A191955F26;
	Thu,  9 Oct 2025 20:38:01 +0000 (UTC)
Received: from okorniev-mac.redhat.com (unknown [10.22.89.109])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 54EC230002D0;
	Thu,  9 Oct 2025 20:38:00 +0000 (UTC)
From: Olga Kornievskaia <okorniev@redhat.com>
To: chuck.lever@oracle.com,
	jlayton@kernel.org
Cc: linux-nfs@vger.kernel.org,
	neilb@suse.de,
	Dai.Ngo@oracle.com,
	tom@talpey.com
Subject: [PATCH v3] nfsd: add missing FATTR4_WORD2_CLONE_BLKSIZE from supported attributes
Date: Thu,  9 Oct 2025 16:37:59 -0400
Message-ID: <20251009203759.87870-1-okorniev@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

RFC 7862 Section 4.1.2 says that if the server supports CLONE it MUST
support clone_blksize attribute.

Fixes: d6ca7d2643ee ("NFSD: Implement FATTR4_CLONE_BLKSIZE attribute")
Signed-off-by: Olga Kornievskaia <okorniev@redhat.com>
---
 fs/nfsd/nfsd.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
index ea87b42894dd..c48fbc6679eb 100644
--- a/fs/nfsd/nfsd.h
+++ b/fs/nfsd/nfsd.h
@@ -455,6 +455,7 @@ enum {
 #define NFSD4_2_SUPPORTED_ATTRS_WORD2 \
 	(NFSD4_1_SUPPORTED_ATTRS_WORD2 | \
 	FATTR4_WORD2_MODE_UMASK | \
+	FATTR4_WORD2_CLONE_BLKSIZE | \
 	NFSD4_2_SECURITY_ATTRS | \
 	FATTR4_WORD2_XATTR_SUPPORT | \
 	FATTR4_WORD2_TIME_DELEG_ACCESS | \
-- 
2.47.3


