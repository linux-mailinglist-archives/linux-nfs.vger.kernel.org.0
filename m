Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 93211182308
	for <lists+linux-nfs@lfdr.de>; Wed, 11 Mar 2020 21:00:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387463AbgCKUAS (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 11 Mar 2020 16:00:18 -0400
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:56670 "EHLO
        smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387447AbgCKUAS (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 11 Mar 2020 16:00:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1583956817; x=1615492817;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=4THswT0o52ovnlzrXKlcAZT1YB714M/0FcpslE4Pfsw=;
  b=Tiki7QWEQHqXwsTDaEgr6Z56X+2seMlA4dQFA2D1FOvtazs76ONQDpst
   SlTGE1CEZRjiRCH25U2KqzI61jcCqiSxUdki+rsEUa3NqmNOyaeCb90nE
   k7EqWBV5+EAYFe2QNt0DyPogS//0UieqR+V+9WaAV8FDrz+jgW0O4lOLk
   E=;
IronPort-SDR: OPsR8adRoXxDdGxbP1UpIoarxi54t1P3vm6FT2w+4BVLTOIo0Zay+FQymQymFZe2emu5vfRdG0
 ZQCSaduazOng==
X-IronPort-AV: E=Sophos;i="5.70,541,1574121600"; 
   d="scan'208";a="22302158"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-1e-303d0b0e.us-east-1.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9101.sea19.amazon.com with ESMTP; 11 Mar 2020 20:00:16 +0000
Received: from EX13MTAUWB001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1e-303d0b0e.us-east-1.amazon.com (Postfix) with ESMTPS id BC635A3059;
        Wed, 11 Mar 2020 20:00:15 +0000 (UTC)
Received: from EX13D13UWB001.ant.amazon.com (10.43.161.156) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.207) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Wed, 11 Mar 2020 19:59:56 +0000
Received: from EX13MTAUEA002.ant.amazon.com (10.43.61.77) by
 EX13D13UWB001.ant.amazon.com (10.43.161.156) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 11 Mar 2020 19:59:56 +0000
Received: from dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com
 (172.23.141.97) by mail-relay.amazon.com (10.43.61.169) with Microsoft SMTP
 Server id 15.0.1236.3 via Frontend Transport; Wed, 11 Mar 2020 19:59:55 +0000
Received: by dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com (Postfix, from userid 6262777)
        id 0E5E9DEC0F; Wed, 11 Mar 2020 19:59:55 +0000 (UTC)
From:   Frank van der Linden <fllinden@amazon.com>
To:     <bfields@fieldses.org>, <chuck.lever@oracle.com>,
        <linux-nfs@vger.kernel.org>
CC:     Frank van der Linden <fllinden@amazon.com>
Subject: [PATCH 04/14] nfsd: make sure the nfsd4_ops array has the right size
Date:   Wed, 11 Mar 2020 19:59:44 +0000
Message-ID: <20200311195954.27117-5-fllinden@amazon.com>
X-Mailer: git-send-email 2.16.6
In-Reply-To: <20200311195954.27117-1-fllinden@amazon.com>
References: <20200311195954.27117-1-fllinden@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The nfsd4_ops was initialized by initializing individual indices (op
numbers). So, the size of the array was determined by the largest
op number.

Some operations are enabled conditionally, based on config options.
If a conditionally enabled operation were to be the highest numbered
operation, the code (through OPDESC) would attempt to access memory
beyond the end of the array. This currently can't happen, since the
highest numbered op is not conditional, but it might in the future.

So, always size the array with LAST_NFS4_OP + 1.

Signed-off-by: Frank van der Linden <fllinden@amazon.com>
---
 fs/nfsd/nfs4proc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 0e75f7fb5fec..5de6449e6ff8 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -2699,7 +2699,7 @@ static inline u32 nfsd4_seek_rsize(struct svc_rqst *rqstp, struct nfsd4_op *op)
 	return (op_encode_hdr_size + 3) * sizeof(__be32);
 }
 
-static const struct nfsd4_operation nfsd4_ops[] = {
+static const struct nfsd4_operation nfsd4_ops[LAST_NFS4_OP + 1] = {
 	[OP_ACCESS] = {
 		.op_func = nfsd4_access,
 		.op_name = "OP_ACCESS",
-- 
2.16.6

