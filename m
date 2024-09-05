Return-Path: <linux-nfs+bounces-6287-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 50DAE96E34C
	for <lists+linux-nfs@lfdr.de>; Thu,  5 Sep 2024 21:36:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D04B1B21B3C
	for <lists+linux-nfs@lfdr.de>; Thu,  5 Sep 2024 19:36:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B84818E772;
	Thu,  5 Sep 2024 19:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SfWI5gE/"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76E0918D65A
	for <linux-nfs@vger.kernel.org>; Thu,  5 Sep 2024 19:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725564991; cv=none; b=gMG9WNJorKpYO6MDsCufxkwriHNfNzsr8vMqRkYiij2zqFYGbhc+saTviL/F1ba1aRQ/NZeBM26e89IX63ri1UvH09wfMOOWj8GPGSBdwM6+WoQkGirLgrEmiJrsL+ZgNJbx4D+F6E3pZa1RdZvzXujamzS91JkSKsN6EsJ9KZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725564991; c=relaxed/simple;
	bh=wVo8DNjNnRS3F0bpWvDYKrDTxW3NwKqbLbm69zaECys=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=O7KOPp2cMD+CbKGjtXcJa3bGv7OH0tJMfSzpi7VkvsSgn7V5TTj2E+Mk8ClnV0CsMsIA3n89LcLzUsQ33CG6t9g+fRqK6oFHj7sGbV+E7IXjqk8bJ1pirTI8Ya8AwLJ5y04e2qWBxxir2wjNlQqG2RCF59cy/NPwlpb/0AbtETg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SfWI5gE/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725564988;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=LlD8ZExYJIriHzGl3O7wBbIEPrR8DkWY3ePlUz87r0s=;
	b=SfWI5gE/HvK54fU5Dw1LarN6YmRe7AOxN4aAD5PrCHVgakb1EOy0fcoMDHuRUppoNMCHbj
	LqY0Uwv12vksbBTCekeApRGoAZVsrd4WYjOZ6uTuU0Xsc9P1RHbn6CAlrF5Ru+xE1DyYWQ
	hUubdsH1FYIhyLci09ihIwflNZCzFw0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-671-p22by-3RPZyvLUGig131nA-1; Thu,
 05 Sep 2024 15:36:27 -0400
X-MC-Unique: p22by-3RPZyvLUGig131nA-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 316171955F65
	for <linux-nfs@vger.kernel.org>; Thu,  5 Sep 2024 19:36:26 +0000 (UTC)
Received: from aion.redhat.com (unknown [10.22.9.161])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CD1FF30001AB;
	Thu,  5 Sep 2024 19:36:25 +0000 (UTC)
Received: from aion.redhat.com (localhost [IPv6:::1])
	by aion.redhat.com (Postfix) with ESMTP id DEDE11F15E3;
	Thu,  5 Sep 2024 15:36:23 -0400 (EDT)
From: Scott Mayhew <smayhew@redhat.com>
To: steved@redhat.com
Cc: linux-nfs@vger.kernel.org
Subject: [nfs-utils PATCH] nfsdcld: don't send null client ids to the kernel
Date: Thu,  5 Sep 2024 15:36:23 -0400
Message-ID: <20240905193623.408531-1-smayhew@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

It's apparently possible for the sqlite database to get corrupted and
cause one or more rows to have null in the id column.

The knfsd fix was posted here:
https://lore.kernel.org/linux-nfs/20240903111446.659884-1-lilingfeng3@huawei.com/

nfsdcld should have a similar fix.  If we encounter a client record with
a null id, just skip it instead of sending it to the kernel.

Signed-off-by: Scott Mayhew <smayhew@redhat.com>
---
 utils/nfsdcld/sqlite.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/utils/nfsdcld/sqlite.c b/utils/nfsdcld/sqlite.c
index 03016fb9..88636848 100644
--- a/utils/nfsdcld/sqlite.c
+++ b/utils/nfsdcld/sqlite.c
@@ -1337,6 +1337,11 @@ sqlite_iterate_recovery(int (*cb)(struct cld_client *clnt), struct cld_client *c
 		id_len = sqlite3_column_bytes(stmt, 0);
 		if (id_len > NFS4_OPAQUE_LIMIT)
 			id_len = NFS4_OPAQUE_LIMIT;
+		if (id_len == 0) {
+			xlog(L_ERROR, "%s: Skipping client record with null id",
+				__func__);
+			continue;
+		}
 
 		memset(&cmsg->cm_u, 0, sizeof(cmsg->cm_u));
 #if UPCALL_VERSION >= 2
-- 
2.46.0


