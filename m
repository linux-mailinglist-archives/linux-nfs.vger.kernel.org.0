Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 30C4859B93
	for <lists+linux-nfs@lfdr.de>; Fri, 28 Jun 2019 14:37:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726694AbfF1MhB (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 28 Jun 2019 08:37:01 -0400
Received: from mx3.molgen.mpg.de ([141.14.17.11]:53975 "EHLO mx1.molgen.mpg.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726578AbfF1MhB (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 28 Jun 2019 08:37:01 -0400
Received: from theinternet.molgen.mpg.de (theinternet.molgen.mpg.de [141.14.31.7])
        by mx.molgen.mpg.de (Postfix) with ESMTP id 01DFB20225BF6;
        Fri, 28 Jun 2019 14:37:00 +0200 (CEST)
From:   Donald Buczek <buczek@molgen.mpg.de>
To:     linux-nfs@vger.kernel.org, trond.myklebust@hammerspace.com,
        anna.schumaker@netapp.com
Cc:     Donald Buczek <buczek@molgen.mpg.de>
Subject: [PATCH 1/4 RESEND] nfs: Fix copy-and-paste error in debug message
Date:   Fri, 28 Jun 2019 14:36:37 +0200
Message-Id: <20190628123640.8715-2-buczek@molgen.mpg.de>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190628123640.8715-1-buczek@molgen.mpg.de>
References: <20190628123640.8715-1-buczek@molgen.mpg.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The debug message of decode_attr_lease_time incorrectly
says "file size". Fix it to "lease time".

Signed-off-by: Donald Buczek <buczek@molgen.mpg.de>
---
 fs/nfs/nfs4xdr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfs/nfs4xdr.c b/fs/nfs/nfs4xdr.c
index 602446158bfb..06aaf017e1c6 100644
--- a/fs/nfs/nfs4xdr.c
+++ b/fs/nfs/nfs4xdr.c
@@ -3427,7 +3427,7 @@ static int decode_attr_lease_time(struct xdr_stream *xdr, uint32_t *bitmap, uint
 		*res = be32_to_cpup(p);
 		bitmap[0] &= ~FATTR4_WORD0_LEASE_TIME;
 	}
-	dprintk("%s: file size=%u\n", __func__, (unsigned int)*res);
+	dprintk("%s: lease time=%u\n", __func__, (unsigned int)*res);
 	return 0;
 }
 
-- 
2.22.0

