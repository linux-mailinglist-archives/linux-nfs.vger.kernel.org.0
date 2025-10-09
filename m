Return-Path: <linux-nfs+bounces-15095-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 70F23BCA240
	for <lists+linux-nfs@lfdr.de>; Thu, 09 Oct 2025 18:21:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 041984FDCE6
	for <lists+linux-nfs@lfdr.de>; Thu,  9 Oct 2025 16:13:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F2FF202960;
	Thu,  9 Oct 2025 16:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c+bkN2Wb"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E62651CAA7D
	for <linux-nfs@vger.kernel.org>; Thu,  9 Oct 2025 16:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760026038; cv=none; b=PlFG9/dHoi4jK+IMjG9hERmqVRYgZ9NVhuCTwMscvFkfieO0r34oAPzhPNLC4ddAt9/D0gmGpciduMmBZWzYjE1OpJDpGuYSx7176hiSsnN2uUy9GTDSg4P//j/brJ/9lAU1DeH9LGPb8kePXBJ3kYSmEkX0ewy0KaEESHPZ+YM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760026038; c=relaxed/simple;
	bh=un9ziClOk2Ktid6pNaK8HW7AFGwWXi5oGdgz5iqNDm8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FEEgVnsjfWCo4yLHGOacrMQlCyRDYmxPFdXltT581c0xrufz9G34zY5eUVGOb60GWoQ+O/jfX1a+Fihxhiw3DOgETDVhAK/VTd2N1SWTaRboiK68JCdYz/xO3YeMve8lE1EE66TRQowqlU6KtAE8FTyhPgM1YN88eu7HL9tZSXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=c+bkN2Wb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760026035;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=XXDL/vZ4FRb88GOllAuRMbBtSZBAeOIsGXKeTz4Qzo0=;
	b=c+bkN2WbNzyttPTZPaDL86APdpqVRkC9ZTKrnBUeuqApb32FQsCNpyB5HLoTX2PeJX+ZmT
	JFrnzkCYUletg+G2jzsbzLFDW/+kZVyhn7V9XoS08lIbm1zSwp47q0unraxZdHoDgPNuXR
	kojKQYMWR2S/eY5T+bAYXLg1oiBS1Ww=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-370-ty4c1aWPOXOUJniTGAvngw-1; Thu,
 09 Oct 2025 12:07:08 -0400
X-MC-Unique: ty4c1aWPOXOUJniTGAvngw-1
X-Mimecast-MFC-AGG-ID: ty4c1aWPOXOUJniTGAvngw_1760026027
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 023341805A09;
	Thu,  9 Oct 2025 16:06:56 +0000 (UTC)
Received: from okorniev-mac.redhat.com (unknown [10.22.89.109])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8B22719560BB;
	Thu,  9 Oct 2025 16:06:54 +0000 (UTC)
From: Olga Kornievskaia <okorniev@redhat.com>
To: chuck.lever@oracle.com,
	jlayton@kernel.org
Cc: linux-nfs@vger.kernel.org,
	neilb@suse.de,
	Dai.Ngo@oracle.com,
	tom@talpey.com
Subject: [PATCH 1/1] nfsd: add missing FATTR4_WORD2_CLONE_BLKSIZE from supported attributes
Date: Thu,  9 Oct 2025 12:06:53 -0400
Message-ID: <20251009160653.81261-1-okorniev@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

RFC 7862 says that if the server supports CLONE it must support
clone_blksize attribute.

Signed-off-by: Olga Kornievskaia <okorniev@redhat.com>
---
 fs/nfsd/nfsd.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
index ea87b42894dd..8cda8cd0f723 100644
--- a/fs/nfsd/nfsd.h
+++ b/fs/nfsd/nfsd.h
@@ -459,7 +459,8 @@ enum {
 	FATTR4_WORD2_XATTR_SUPPORT | \
 	FATTR4_WORD2_TIME_DELEG_ACCESS | \
 	FATTR4_WORD2_TIME_DELEG_MODIFY | \
-	FATTR4_WORD2_OPEN_ARGUMENTS)
+	FATTR4_WORD2_OPEN_ARGUMENTS | \
+	FATTR4_WORD2_CLONE_BLKSIZE)
 
 extern const u32 nfsd_suppattrs[3][3];
 
-- 
2.47.3


