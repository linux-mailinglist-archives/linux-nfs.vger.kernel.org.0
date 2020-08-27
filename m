Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F0A625502E
	for <lists+linux-nfs@lfdr.de>; Thu, 27 Aug 2020 22:47:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726794AbgH0UrB (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 27 Aug 2020 16:47:01 -0400
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:19973 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726147AbgH0UrA (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 27 Aug 2020 16:47:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1598561221; x=1630097221;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=hpgRb2h0mN8Kij2faQnLoL0JK9k38SapLWHE1AtWvi4=;
  b=bHWv5+11QFpFwkGjYI6JU0sYNxAaeC0xRahr/LkRh+mcMUlmDSW05FO4
   uI+HS/HCEMhyfnFg2M5OH8FQlq/+spvfkmGlBHpWtHBz51TtnbN3W7Eqt
   WwcWWJ7UV+dxrM9mRw1llguwiLIIS0GrGXMMMw3Ap7GUvUkR5mjsqyGB9
   o=;
X-IronPort-AV: E=Sophos;i="5.76,361,1592870400"; 
   d="scan'208";a="71482355"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-2a-538b0bfb.us-west-2.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP; 27 Aug 2020 20:46:58 +0000
Received: from EX13MTAUWB001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan3.pdx.amazon.com [10.170.41.166])
        by email-inbound-relay-2a-538b0bfb.us-west-2.amazon.com (Postfix) with ESMTPS id 9E1C6A1EC3;
        Thu, 27 Aug 2020 20:46:57 +0000 (UTC)
Received: from EX13D13UWB001.ant.amazon.com (10.43.161.156) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.249) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Thu, 27 Aug 2020 20:46:57 +0000
Received: from EX13MTAUEA002.ant.amazon.com (10.43.61.77) by
 EX13D13UWB001.ant.amazon.com (10.43.161.156) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Thu, 27 Aug 2020 20:46:56 +0000
Received: from dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com
 (172.23.141.97) by mail-relay.amazon.com (10.43.61.169) with Microsoft SMTP
 Server id 15.0.1497.2 via Frontend Transport; Thu, 27 Aug 2020 20:46:56 +0000
Received: by dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com (Postfix, from userid 6262777)
        id C5754C153F; Thu, 27 Aug 2020 20:46:55 +0000 (UTC)
From:   Frank van der Linden <fllinden@amazon.com>
To:     <linux-nfs@vger.kernel.org>, <anna.schumaker@netapp.com>,
        <trond.myklebust@hammerspace.com>
CC:     Frank van der Linden <fllinden@amazon.com>
Subject: [PATCH] NFSv4.2: xattr cache: remove unused cache struct field
Date:   Thu, 27 Aug 2020 20:46:55 +0000
Message-ID: <20200827204655.1581-1-fllinden@amazon.com>
X-Mailer: git-send-email 2.16.6
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The hash_lock field of the cache structure was a leftover
of a previous iteration of the code. It is now unused,
so remove it.

Signed-off-by: Frank van der Linden <fllinden@amazon.com>
---
 fs/nfs/nfs42xattr.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/nfs/nfs42xattr.c b/fs/nfs/nfs42xattr.c
index 86777996cfec..22396a7eebe1 100644
--- a/fs/nfs/nfs42xattr.c
+++ b/fs/nfs/nfs42xattr.c
@@ -67,7 +67,6 @@ struct nfs4_xattr_bucket {
 
 struct nfs4_xattr_cache {
 	struct kref ref;
-	spinlock_t hash_lock;	/* protects hashtable and lru */
 	struct nfs4_xattr_bucket buckets[NFS4_XATTR_HASH_SIZE];
 	struct list_head lru;
 	struct list_head dispose;
-- 
2.17.2

