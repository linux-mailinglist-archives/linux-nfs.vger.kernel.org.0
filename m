Return-Path: <linux-nfs+bounces-8552-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F6EF9F12F0
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Dec 2024 17:53:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30296280FCB
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Dec 2024 16:53:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEEAD1E491B;
	Fri, 13 Dec 2024 16:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gVgNrjg3"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06A611E4937
	for <linux-nfs@vger.kernel.org>; Fri, 13 Dec 2024 16:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734108733; cv=none; b=Gk9rCgji6RjH1wBsrv9/iQijcnWeSxmVwGSgOHYhAwsagsQwOnwFjsKpNJ80kYULqd80tSbaB5R4wKqyhm/OEC8RJ6FXtPedU2OJkKit7zCniCAyP60ZK0UzoztATVgCRxVmKJo6W/FhRiSlKp6QvGIpVua5g1ZXMocbulbFqXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734108733; c=relaxed/simple;
	bh=G1lfwr4aCNaY/INoz+IsSCrjqp9gKQInzo6dhXbnGcw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ROJ4vzdYuVjHmTL4sstfOuGlPHYT8jlcgzwLnI9YRm8oxXDRFq9lSW1iAybFuWxmRLXtW1Lsqt9o9k9qbD2pWIv5YLoY2O7BDEzADSuP/LupuzHZsmAf/MAXkVEVJArkn8YC+AWB8cLCfBo7l5GHlJPQwBNZpD7gbUGNQm5oxj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gVgNrjg3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734108730;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=zMX/P4L942Glkor9coXSsz4Hz4Px1zCCgFk5hcXyFTE=;
	b=gVgNrjg3+xNtMeaFSX0HlQ+3LAQt+sfbDzQWIWcnMJfi4Nv+RCMB6A8fT/wZVhP8kDJAj8
	sVdRvOmlDJs+HGWayAmC4LIkIL1dZaNaOW58ww03RrxetWOHavh3f9H93+BYAiQIf/RQL9
	LMy0vMBNRgr1kyrJLxFd8soHR9TJcd0=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-390--PM3YXK7NRW98k3xmkbf5w-1; Fri,
 13 Dec 2024 11:52:07 -0500
X-MC-Unique: -PM3YXK7NRW98k3xmkbf5w-1
X-Mimecast-MFC-AGG-ID: -PM3YXK7NRW98k3xmkbf5w
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 740851955EAB;
	Fri, 13 Dec 2024 16:52:06 +0000 (UTC)
Received: from okorniev-mac.redhat.com (unknown [10.22.82.26])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 658B3195605A;
	Fri, 13 Dec 2024 16:52:05 +0000 (UTC)
From: Olga Kornievskaia <okorniev@redhat.com>
To: trondmy@kernel.org,
	anna@kernel.org
Cc: linux-nfs@vger.kernel.org,
	Olga Kornievskaia <okorniev@redhat.com>
Subject: [PATCH] NFSv4.2: fix COPY_NOTIFY xdr buf size calculation
Date: Fri, 13 Dec 2024 11:52:00 -0500
Message-Id: <20241213165202.78785-1-okorniev@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

We need to include sequence size in the compound.

Fixes: 0491567b51ef ("NFS: add COPY_NOTIFY operation")
Signed-off-by: Olga Kornievskaia <okorniev@redhat.com>
---
 fs/nfs/nfs42xdr.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/nfs/nfs42xdr.c b/fs/nfs/nfs42xdr.c
index a928b7f90e59..b1b663468249 100644
--- a/fs/nfs/nfs42xdr.c
+++ b/fs/nfs/nfs42xdr.c
@@ -157,9 +157,11 @@
 					 decode_putfh_maxsz + \
 					 decode_offload_status_maxsz)
 #define NFS4_enc_copy_notify_sz		(compound_encode_hdr_maxsz + \
+					 encode_sequence_maxsz + \
 					 encode_putfh_maxsz + \
 					 encode_copy_notify_maxsz)
 #define NFS4_dec_copy_notify_sz		(compound_decode_hdr_maxsz + \
+					 decode_sequence_maxsz + \
 					 decode_putfh_maxsz + \
 					 decode_copy_notify_maxsz)
 #define NFS4_enc_deallocate_sz		(compound_encode_hdr_maxsz + \
-- 
2.43.5


