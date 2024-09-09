Return-Path: <linux-nfs+bounces-6357-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AE759723A8
	for <lists+linux-nfs@lfdr.de>; Mon,  9 Sep 2024 22:29:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0E2C1F23EEF
	for <lists+linux-nfs@lfdr.de>; Mon,  9 Sep 2024 20:29:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7AB518A6A8;
	Mon,  9 Sep 2024 20:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZP4Tj2wy"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C85918A6B1
	for <linux-nfs@vger.kernel.org>; Mon,  9 Sep 2024 20:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725913744; cv=none; b=eqh7F8xcc4yOjeT2cueGzvJ5Qple3brK4t1JG2hzZTKGW6+AL9BMXl44PiGsuCq5YIj0FodF2fnbUGVCOgTR5c60OeZSOF2smuW6Ev7e6NPOqyqm3e66qVhI7qFNPWlL/eBF/FR2gIvb3i9wYpTseaNz7bEVzBisML5P4fvl3Lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725913744; c=relaxed/simple;
	bh=PLGmTHeak5rtqpGOpHIDl67tVZND1o4A0lZUh6mzuqg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DINhsXYtRjjFHsMYAkvPj63wP/L2Sc9hubzR0eQk53GWrirDZ5JpAq2U4FiWwVyNCQg54bADZsCN7CIXVkLINQxp0HR2+TgbjFPUHQ6ClwsQTWLLu/mvi6c7+K4UT5PuQk8NBsCM8I8GvFLR9MDdB6qvTQ4MDGeTQrOt3WiTue8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZP4Tj2wy; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725913742;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yRKU/pnBHsaxBqErMRJNWoYxGzvNed8h/5Xs/aijsB4=;
	b=ZP4Tj2wyZnRUaavulIzvf6+OxaCpYtNVNeoicn7Af01WYp76/lDd3LbZ1/FFCHpb7mtAG+
	+3HyEI5ujJKwTOB2mJOuvG78AZtuJ1v0GbISG8WImQP2K75mTzntcZ3fDVyXIOW9TvloNe
	IpOoxW6w3Suni7xubMcx/RNDnIvcyZA=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-247-CJirobAEM5iPPV_m6YSwbg-1; Mon,
 09 Sep 2024 16:28:58 -0400
X-MC-Unique: CJirobAEM5iPPV_m6YSwbg-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 94B101944DE5;
	Mon,  9 Sep 2024 20:28:57 +0000 (UTC)
Received: from aion.redhat.com (unknown [10.22.64.160])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 05DFA3001476;
	Mon,  9 Sep 2024 20:28:56 +0000 (UTC)
Received: from aion.redhat.com (localhost [IPv6:::1])
	by aion.redhat.com (Postfix) with ESMTP id 193D51F1B66;
	Mon,  9 Sep 2024 16:28:55 -0400 (EDT)
From: Scott Mayhew <smayhew@redhat.com>
To: chuck.lever@oracle.com
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH 0/1] nfsd: enforce upper limit for namelen in __cld_pipe_inprogress_downcall()
Date: Mon,  9 Sep 2024 16:28:53 -0400
Message-ID: <20240909202855.510399-1-smayhew@redhat.com>
In-Reply-To: <Zt8BuA4gxVMpBUcW@tissot.1015granger.net>
References: <Zt8BuA4gxVMpBUcW@tissot.1015granger.net>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

This patch is intended to go on top of "nfsd: return -EINVAL when
namelen is 0" from Li Lingfeng.  Li's patch checks for 0, but we should
be enforcing an upper bound as well.

Note that if nfsdcld somehow gets an id > NFS4_OPAQUE_LIMIT in its
database, it'll truncate it to NFS4_OPAQUE_LIMIT when it does the
downcall anyway... so to test, I had to run nfsdcld with that check
removed:

---8<---
diff --git a/utils/nfsdcld/sqlite.c b/utils/nfsdcld/sqlite.c
index 03016fb9..fb900c7b 100644
--- a/utils/nfsdcld/sqlite.c
+++ b/utils/nfsdcld/sqlite.c
@@ -1335,8 +1335,6 @@ sqlite_iterate_recovery(int (*cb)(struct cld_client *clnt), struct cld_client *c
 
                id = sqlite3_column_blob(stmt, 0);
                id_len = sqlite3_column_bytes(stmt, 0);
-               if (id_len > NFS4_OPAQUE_LIMIT)
-                       id_len = NFS4_OPAQUE_LIMIT;
 
                memset(&cmsg->cm_u, 0, sizeof(cmsg->cm_u));
 #if UPCALL_VERSION >= 2
---8<---

I ran the following python script to add some dummy records of varying
lengths (0, 1, 1024, 1025) to the sqlite db:

---8<---
import sqlite3

NFS4_OPAQUE_LIMIT=1024
con = sqlite3.connect("/var/lib/nfs/nfsdcld/main.sqlite")
con.row_factory = sqlite3.Row
for row in con.execute("select * from grace"):
    epoch = int(row['current'])
query = 'insert into "rec-{:016x}" (id) values (?)'.format(epoch)
w = None
x = 'x'.encode()
y = ('y' * NFS4_OPAQUE_LIMIT).encode()
z = ('z' * (NFS4_OPAQUE_LIMIT + 1)).encode()
con.execute(query, (w,))
con.execute(query, (x,))
con.execute(query, (y,))
con.execute(query, (z,))
con.commit()
con.close()
---8<---

Additionally, I ensured I had a record from a valid client in the db and
that that client had a file open.  I enabled NFSDDBG_PROC, restarted
nfsd, and checked for the following messages:

Sep 09 15:30:27 rhel9.smayhew.redhat.com.nfsv4.dev kernel: __cld_pipe_inprogress_downcall: invalid namelen (0)
Sep 09 15:30:27 rhel9.smayhew.redhat.com.nfsv4.dev kernel: __cld_pipe_inprogress_downcall: invalid namelen (1025)

I also verified in wireshark that my actual client was able to reclaim
its open file.

-Scott

Scott Mayhew (1):
  nfsd: enforce upper limit for namelen in
    __cld_pipe_inprogress_downcall()

 fs/nfsd/nfs4recover.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

-- 
2.46.0


