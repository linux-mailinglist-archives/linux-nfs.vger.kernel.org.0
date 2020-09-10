Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3CE5264F79
	for <lists+linux-nfs@lfdr.de>; Thu, 10 Sep 2020 21:44:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725965AbgIJToP (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 10 Sep 2020 15:44:15 -0400
Received: from smtp-fw-4101.amazon.com ([72.21.198.25]:64168 "EHLO
        smtp-fw-4101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725372AbgIJToI (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 10 Sep 2020 15:44:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1599767048; x=1631303048;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=JdeE5S5BkzjhhMMAdlB7SxXk6Vsu4NC+W7hi2SgDYDU=;
  b=QIQZaKK+4+JwnNliDlBcpq1mzOaC9QXwZpo09Fh5Bz0XhgTAA5vZnKY5
   6pJ7KtVqp61hDCezbX+X5+L/rRw6rSYMsaDQzIYBYZhLdFqIdwqrYa67e
   z7LsJ6GYxnEBTnXsMWMwDW0F9sCQ3rqTDflWl5Wo6E0/OLmVWRkAf3LME
   g=;
X-IronPort-AV: E=Sophos;i="5.76,413,1592870400"; 
   d="scan'208";a="53318928"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1a-e34f1ddc.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-4101.iad4.amazon.com with ESMTP; 10 Sep 2020 19:43:57 +0000
Received: from EX13MTAUWB001.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan3.iad.amazon.com [10.40.163.38])
        by email-inbound-relay-1a-e34f1ddc.us-east-1.amazon.com (Postfix) with ESMTPS id 848CDA1E05;
        Thu, 10 Sep 2020 19:43:56 +0000 (UTC)
Received: from EX13D13UWB002.ant.amazon.com (10.43.161.21) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.249) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Thu, 10 Sep 2020 19:43:55 +0000
Received: from EX13MTAUWC001.ant.amazon.com (10.43.162.135) by
 EX13D13UWB002.ant.amazon.com (10.43.161.21) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Thu, 10 Sep 2020 19:43:55 +0000
Received: from dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com
 (172.23.141.97) by mail-relay.amazon.com (10.43.162.232) with Microsoft SMTP
 Server id 15.0.1497.2 via Frontend Transport; Thu, 10 Sep 2020 19:43:55 +0000
Received: by dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com (Postfix, from userid 6262777)
        id 9AE52C1429; Thu, 10 Sep 2020 19:43:55 +0000 (UTC)
From:   Frank van der Linden <fllinden@amazon.com>
To:     <fstests@vger.kernel.org>
CC:     <linux-nfs@vger.kernel.org>,
        Frank van der Linden <fllinden@amazon.com>
Subject: [PATCH 2/3] common/attr: set MAX_ATTR values correctly for NFS
Date:   Thu, 10 Sep 2020 19:43:54 +0000
Message-ID: <20200910194355.5977-2-fllinden@amazon.com>
X-Mailer: git-send-email 2.16.6
In-Reply-To: <20200910194355.5977-1-fllinden@amazon.com>
References: <20200910194355.5977-1-fllinden@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Now that NFS can handle user xattrs, set the MAX_ATTR
and MAX_ATTRVAL_SIZE to reflect the applicable limits
for that filesystem.

Signed-off-by: Frank van der Linden <fllinden@amazon.com>
---
 common/attr | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/common/attr b/common/attr
index c60cb6ed..fb856449 100644
--- a/common/attr
+++ b/common/attr
@@ -251,7 +251,7 @@ _getfattr()
 
 # set maximum total attr space based on fs type
 case "$FSTYP" in
-xfs|udf|pvfs2|9p|ceph)
+xfs|udf|pvfs2|9p|ceph|nfs)
 	MAX_ATTRS=1000
 	;;
 *)
@@ -271,7 +271,7 @@ xfs|udf|btrfs)
 pvfs2)
 	MAX_ATTRVAL_SIZE=8192
 	;;
-9p|ceph)
+9p|ceph|nfs)
 	MAX_ATTRVAL_SIZE=65536
 	;;
 *)
-- 
2.16.6

