Return-Path: <linux-nfs+bounces-15100-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AD53CBCA66D
	for <lists+linux-nfs@lfdr.de>; Thu, 09 Oct 2025 19:38:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8CD764E2957
	for <lists+linux-nfs@lfdr.de>; Thu,  9 Oct 2025 17:38:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63CD3242D83;
	Thu,  9 Oct 2025 17:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Sw6cP+9e"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1EBC224AF9
	for <linux-nfs@vger.kernel.org>; Thu,  9 Oct 2025 17:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760031527; cv=none; b=qOuiL2gCrVWgrWjqRAxwEJnNQduYPNJVR0wXdx/BJccBzLWyyGhGRQuCNxVXLJxedfDXxtiZdP0+GfhRErxCPSJ/vrtL/8h6HMj2rMPxAXUyJ2id5IlS4BqkXyhsXmFUZFoD9E4J8g+uhjQzZ5YAu5c3EsJsorcX8cgcwo+tZkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760031527; c=relaxed/simple;
	bh=roeXVIlX6ysEBrlesFIutvufHvDT+ybynWPy0rHofhs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IOM/1+JtQ1ijxT6AAWuBta5hezzmQ/r3Py7/ZLuRxdJZ4fEPiTYhlGhe1nGObgiEuGi6C1PmcoV4Iq2rhlhUmO6Rk85JggZTqwTkAMBgpHdwsRExs9opN3zINYG/uuW3bxAsca2T5W3X+lwrcBQTkhwowd9ZuNSZOvnGvvXo1cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Sw6cP+9e; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760031524;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=1GPHJJm8zZDMN8Lupp7Aq/isZJW6okLE68juCLj/EaE=;
	b=Sw6cP+9eG/CWfv1z48hnd3lgnxCyPMGrnLUsWyizacNE3bUPWQ+OOU6tzzGxpitwDYETHX
	pCoMOUTLDlQN2zsjEhbiIp2hUXAIdYIShzkDL5kPJtfdCF7kz0agrjoV2h1j0FeWVoPyvw
	BaSAQ06nZIzbDPyRku8Ue3sVcP1M+RA=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-88-jem1u9-WP3SpezBgqWer0Q-1; Thu,
 09 Oct 2025 13:38:39 -0400
X-MC-Unique: jem1u9-WP3SpezBgqWer0Q-1
X-Mimecast-MFC-AGG-ID: jem1u9-WP3SpezBgqWer0Q_1760031517
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A4A8C1956087;
	Thu,  9 Oct 2025 17:38:37 +0000 (UTC)
Received: from okorniev-mac.redhat.com (unknown [10.22.89.109])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 31D7930001B7;
	Thu,  9 Oct 2025 17:38:36 +0000 (UTC)
From: Olga Kornievskaia <okorniev@redhat.com>
To: chuck.lever@oracle.com,
	jlayton@kernel.org
Cc: linux-nfs@vger.kernel.org,
	neilb@suse.de,
	Dai.Ngo@oracle.com,
	tom@talpey.com
Subject: [PATCH v2] nfsd: add missing FATTR4_WORD2_CLONE_BLKSIZE from supported attributes
Date: Thu,  9 Oct 2025 13:38:35 -0400
Message-ID: <20251009173835.83690-1-okorniev@redhat.com>
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
index ea87b42894dd..9ae5fd1d081a 100644
--- a/fs/nfsd/nfsd.h
+++ b/fs/nfsd/nfsd.h
@@ -456,6 +456,7 @@ enum {
 	(NFSD4_1_SUPPORTED_ATTRS_WORD2 | \
 	FATTR4_WORD2_MODE_UMASK | \
 	NFSD4_2_SECURITY_ATTRS | \
+	FATTR4_WORD2_CLONE_BLKSIZE | \
 	FATTR4_WORD2_XATTR_SUPPORT | \
 	FATTR4_WORD2_TIME_DELEG_ACCESS | \
 	FATTR4_WORD2_TIME_DELEG_MODIFY | \
-- 
2.47.3


