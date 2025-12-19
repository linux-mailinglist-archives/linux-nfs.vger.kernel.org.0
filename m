Return-Path: <linux-nfs+bounces-17242-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 58728CD1445
	for <lists+linux-nfs@lfdr.de>; Fri, 19 Dec 2025 19:00:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AD1AA300C8D5
	for <lists+linux-nfs@lfdr.de>; Fri, 19 Dec 2025 18:00:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BD83350A2D;
	Fri, 19 Dec 2025 18:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ot4+5G+O"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53505350A29
	for <linux-nfs@vger.kernel.org>; Fri, 19 Dec 2025 18:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766167205; cv=none; b=L7vCV7Op4AsAIi7bs4uazv/dBJcclYBZ+vgLWvruNkt4W28wiFCbmCL2a9XleoZ4gI9PPTpy9BB1LeQfwkciZyaXgqDx3gxXH8nH5ztOccie0g3bXIr70vVm//cm7PkaVo5pekEAnJy9p6Cv4SXJOh3xBWB7OgN4ckEXUthANbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766167205; c=relaxed/simple;
	bh=aAwONkQ5usYr8QJAo2vJ3zLWTwIr1JfcQLyqOfVDVg8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HMy0USli1veLKbQ6k0K4TfO8XG5NyKA9+dA+DkXZp+0Cj2reO++yPIpVGac5QGh6dIOcqif2TaZWPYK1ILjZC1jvq3N8AQG+lxYNTWCc6/pGboEzaLPTb4yJJJfp03ePGt+ylqKkecErrwIft7tjPQAEPgWFijJaf8lqRavNxEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ot4+5G+O; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766167202;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=1MUHaRvuCsqhTh93OGsxslD0oVXIpPV9rRaVEr0zQSE=;
	b=Ot4+5G+OSlaCn+WhJWXt7cjKIxTcgzGDiY6+VU1/E3dzHkQXeOSGHfBEDsBeHBXndoOMvu
	oVIqOMOW2Ej1ELpRrzvVQlqHWdxzjQDO9pfNTQxCAQ8jR+sNtThZ1KM4RshmdQXTdzqVWo
	kP5kHcjf9TIK275ruodHMqMkco6P5KA=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-401-Nm4zIMHmPEOIoxTTL_f9dg-1; Fri,
 19 Dec 2025 12:59:58 -0500
X-MC-Unique: Nm4zIMHmPEOIoxTTL_f9dg-1
X-Mimecast-MFC-AGG-ID: Nm4zIMHmPEOIoxTTL_f9dg_1766167197
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 68F0D19560B2;
	Fri, 19 Dec 2025 17:59:57 +0000 (UTC)
Received: from okorniev-mac.redhat.com (unknown [10.22.88.102])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2FC3130001A2;
	Fri, 19 Dec 2025 17:59:56 +0000 (UTC)
From: Olga Kornievskaia <okorniev@redhat.com>
To: chuck.lever@oracle.com,
	jlayton@kernel.org
Cc: linux-nfs@vger.kernel.org,
	neilb@brown.name,
	Dai.Ngo@oracle.com,
	tom@talpey.com
Subject: [PATCH 1/1] NFSD: fix setting FMODE_NOCMTIME in nfs4_open_delegation
Date: Fri, 19 Dec 2025 12:59:55 -0500
Message-ID: <20251219175955.4480-1-okorniev@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

fstests generic/215 and generic/407 were failing because the server
wasn't updating mtime properly. When deleg attribute support is not
compiled in and thus no attribute delegation was given, the server
was skipping updating mtime and ctime because FMODE_NOCMTIME was
uncoditionally set for the write delegation.

Fixes: e5e9b24ab8fa ("nfsd: freeze c/mtime updates with outstanding WRITE_ATTRS delegation")
Signed-off-by: Olga Kornievskaia <okorniev@redhat.com>
---
 fs/nfsd/nfs4state.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 808c24fb5c9a..d64650c47f79 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -6327,7 +6327,8 @@ nfs4_open_delegation(struct svc_rqst *rqstp, struct nfsd4_open *open,
 		dp->dl_ctime = stat.ctime;
 		dp->dl_mtime = stat.mtime;
 		spin_lock(&f->f_lock);
-		f->f_mode |= FMODE_NOCMTIME;
+		if (deleg_ts)
+			f->f_mode |= FMODE_NOCMTIME;
 		spin_unlock(&f->f_lock);
 		trace_nfsd_deleg_write(&dp->dl_stid.sc_stateid);
 	} else {
-- 
2.47.1


