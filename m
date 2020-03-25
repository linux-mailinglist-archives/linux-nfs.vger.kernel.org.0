Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C66F0193443
	for <lists+linux-nfs@lfdr.de>; Thu, 26 Mar 2020 00:11:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727486AbgCYXLI (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 25 Mar 2020 19:11:08 -0400
Received: from smtp-fw-6002.amazon.com ([52.95.49.90]:40828 "EHLO
        smtp-fw-6002.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727487AbgCYXLI (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 25 Mar 2020 19:11:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1585177867; x=1616713867;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=njHYg5IBfxigZMQpTlelWlI9ARc5mEgd9mXi449OG1A=;
  b=k8Ek+H1bZNJpOCnOK0CcCdyJ3NVADDWD6F4jBfJJ/JeMSS/AMthN95CN
   yXogKa9LRkhv6ttRqCl25VkGbFB6HZ0P7qvauoDq1NHE+LKIELIFO4tVP
   mcEkxmCrB83pWgGMv7q3iFU2Aw6oIRCZHvCFRtHOSjwQgMvXjPqKwY3O3
   c=;
IronPort-SDR: 9XcHhEf3FqrEJfURWhpPsC+RfVheREnRe3j25fB4bsEM7ce7hMx4KnBObwOjNQoz5y097M5aMT
 Lfq5nq/wlk5Q==
X-IronPort-AV: E=Sophos;i="5.72,306,1580774400"; 
   d="scan'208";a="22761098"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1e-a70de69e.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-6002.iad6.amazon.com with ESMTP; 25 Mar 2020 23:10:54 +0000
Received: from EX13MTAUWB001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1e-a70de69e.us-east-1.amazon.com (Postfix) with ESMTPS id CD25AA239C;
        Wed, 25 Mar 2020 23:10:53 +0000 (UTC)
Received: from EX13D13UWB001.ant.amazon.com (10.43.161.156) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.207) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Wed, 25 Mar 2020 23:10:52 +0000
Received: from EX13MTAUEA002.ant.amazon.com (10.43.61.77) by
 EX13D13UWB001.ant.amazon.com (10.43.161.156) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 25 Mar 2020 23:10:52 +0000
Received: from dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com
 (172.23.141.97) by mail-relay.amazon.com (10.43.61.169) with Microsoft SMTP
 Server id 15.0.1236.3 via Frontend Transport; Wed, 25 Mar 2020 23:10:51 +0000
Received: by dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com (Postfix, from userid 6262777)
        id 46F23D92AA; Wed, 25 Mar 2020 23:10:51 +0000 (UTC)
From:   Frank van der Linden <fllinden@amazon.com>
To:     <linux-nfs@vger.kernel.org>, <anna.schumaker@netapp.com>,
        <trond.myklebust@hammerspace.com>
CC:     Frank van der Linden <fllinden@amazon.com>
Subject: [PATCH v2 00/13] NFS client user xattr (RFC8276) support
Date:   Wed, 25 Mar 2020 23:10:38 +0000
Message-ID: <20200325231051.31652-1-fllinden@amazon.com>
X-Mailer: git-send-email 2.16.6
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

v1 is here: https://www.spinics.net/lists/linux-nfs/msg76740.html

v2:

* Move nfs4 specific definitions to nfs_fs4.h
* Squash some patches together to avoid unused function warnings
  when bisecting.
* Made determining server support a two-step process. First,
  the extended attribute FATTR is verified to be supported, then
  the value of the attributed is queried in fsinfo to determine
  support.
* Fixed up Makefile to remove an unneeded extra line.

This was tested as before (using my own stress tests), but also
with xfstests-dev. No issues were found, but xfstests needs some
fixes to correctly run the applicable xattr tests on NFS. I
have those changes, but need to send them out.

I also tested stress-ng-xattr with 1000 workers on the client
side, running for 8 hours without problems (except for noting
that the session tbl_lock can become quite hot when doing
NFS operations by 1000 threads, but that's a separate issue).


Frank van der Linden (13):
  nfs,nfsd:  NFSv4.2 extended attribute protocol definitions
  nfs: add client side only definitions for user xattrs
  NFSv4.2: define limits and sizes for user xattr handling
  NFSv4.2: query the server for extended attribute support
  NFSv4.2: add client side XDR handling for extended attributes
  nfs: define nfs_access_get_cached function
  NFSv4.2: query the extended attribute access bits
  nfs: modify update_changeattr to deal with regular files
  nfs: define and use the NFS_INO_INVALID_XATTR flag
  nfs: make the buf_to_pages_noslab function available to the nfs code
  NFSv4.2: add the extended attribute proc functions.
  NFSv4.2: hook in the user extended attribute handlers
  NFSv4.2: add client side xattr caching.

 fs/nfs/Makefile             |    2 +-
 fs/nfs/client.c             |   22 +-
 fs/nfs/dir.c                |   24 +-
 fs/nfs/inode.c              |   16 +-
 fs/nfs/nfs42.h              |   24 +
 fs/nfs/nfs42proc.c          |  248 ++++++++
 fs/nfs/nfs42xattr.c         | 1083 +++++++++++++++++++++++++++++++++++
 fs/nfs/nfs42xdr.c           |  438 ++++++++++++++
 fs/nfs/nfs4_fs.h            |   35 ++
 fs/nfs/nfs4client.c         |   31 +
 fs/nfs/nfs4proc.c           |  237 +++++++-
 fs/nfs/nfs4super.c          |   10 +
 fs/nfs/nfs4xdr.c            |   31 +
 fs/nfs/nfstrace.h           |    3 +-
 include/linux/nfs4.h        |   25 +
 include/linux/nfs_fs.h      |   12 +
 include/linux/nfs_fs_sb.h   |    6 +
 include/linux/nfs_xdr.h     |   60 +-
 include/uapi/linux/nfs4.h   |    3 +
 include/uapi/linux/nfs_fs.h |    1 +
 20 files changed, 2269 insertions(+), 42 deletions(-)
 create mode 100644 fs/nfs/nfs42xattr.c

-- 
2.17.2

