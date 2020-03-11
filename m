Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 749591822DF
	for <lists+linux-nfs@lfdr.de>; Wed, 11 Mar 2020 20:56:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387426AbgCKT42 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 11 Mar 2020 15:56:28 -0400
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:55622 "EHLO
        smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387431AbgCKT41 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 11 Mar 2020 15:56:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1583956587; x=1615492587;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=yfXh2w/OKPknFxU4iOy/8+o53zsg/Rx3jg8syMClXT4=;
  b=gMchsK4c2Os8hgAb0FKcBMZXhznnXMD1ykFPVEXnIXm9plRIxiTw1jhr
   lCLWOVTF/XecM4Ez0S5PzAYy1G6SDtY7a7uJPLM3iDORK2fuMuPCh9uX0
   ag6tgh0LEW9ZpW+H0c+1HWVDBmxwispqCQjcKGAEAf1zkHBDcAKZ2DI0H
   I=;
IronPort-SDR: x7c8eQWhdRbviGsfwfXzR8kp2ji56qWkLmOEZPgIN8ug/Yv2VcOpCEw2rYUHhhkg7+fNdlRGqz
 9eGg/PBNIYNA==
X-IronPort-AV: E=Sophos;i="5.70,541,1574121600"; 
   d="scan'208";a="22301188"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-1e-27fb8269.us-east-1.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9101.sea19.amazon.com with ESMTP; 11 Mar 2020 19:56:25 +0000
Received: from EX13MTAUWB001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1e-27fb8269.us-east-1.amazon.com (Postfix) with ESMTPS id CB43BA23F3;
        Wed, 11 Mar 2020 19:56:24 +0000 (UTC)
Received: from EX13D13UWB004.ant.amazon.com (10.43.161.218) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.249) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Wed, 11 Mar 2020 19:56:24 +0000
Received: from EX13MTAUWB001.ant.amazon.com (10.43.161.207) by
 EX13D13UWB004.ant.amazon.com (10.43.161.218) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 11 Mar 2020 19:56:23 +0000
Received: from dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com
 (172.23.141.97) by mail-relay.amazon.com (10.43.161.249) with Microsoft SMTP
 Server id 15.0.1367.3 via Frontend Transport; Wed, 11 Mar 2020 19:56:23 +0000
Received: by dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com (Postfix, from userid 6262777)
        id E3330DD8DB; Wed, 11 Mar 2020 19:56:23 +0000 (UTC)
From:   Frank van der Linden <fllinden@amazon.com>
To:     <trond.myklebust@hammerspace.com>, <anna.schumaker@netapp.com>,
        <linux-nfs@vger.kernel.org>
CC:     Frank van der Linden <fllinden@amazon.com>
Subject: [PATCH 00/13] client side user xattr (RFC8276) support
Date:   Wed, 11 Mar 2020 19:56:00 +0000
Message-ID: <20200311195613.26108-1-fllinden@amazon.com>
X-Mailer: git-send-email 2.16.6
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

This patchset implements the client side for NFS user extended attributes,
as defined in RFC8726.

This was originally posted as an RFC in:

https://patchwork.kernel.org/cover/11143565/

Patch 1 is shared with the server side patch, posted
separately.

Most comments in there still apply, except that:

1. Client side caching is now included in this patch set.
2. As per the discussion, user extended attributes are enabled if
   the client and server support them (e.g. they support 4.2 and
   advertise the user extended attribute FATTR). There are no longer
   options to switch them off on either the client or the server.
3. The code is no longer conditioned on a config option.
4. The number of patches has been reduced somewhat by merging
   smaller, related ones.

The client side caching is implemented through a per-inode hash table,
which is allocated on demand. See fs/nfs/nfs42xattr.c for details.

This has been tested as follows:

* Linux client and server:
	* Test all corner cases (XATTR_SIZE_*)
	* Test all failure cases (no xattr, setxattr with different or
	  invalid flags, etc).
	* Verify the content of xattrs across several operations.
	* Use KASAN and KMEMLEAK for a longer mix of testruns to verify
	  that there were no leaks (after unmounting the filesystem).
	* Stress tested caching, trying to run the client out of memory.

* Tested against the FreeBSD-current implementation as well, which works
  (after I fixed 2 bugs in that implementation, which I'm sending out to
  them too).

* Not tested: RDMA (I couldn't get a setup going).

Frank van der Linden (13):
  nfs,nfsd:  NFSv4.2 extended attribute protocol definitions
  nfs: add client side only definitions for user xattrs
  NFSv4.2: query the server for extended attribute support
  NFSv4.2: define limits and sizes for user xattr handling
  NFSv4.2: add client side XDR handling for extended attributes
  nfs: define nfs_access_get_cached function
  NFSv4.2: query the extended attribute access bits
  nfs: modify update_changeattr to deal with regular files
  nfs: define and use the NFS_INO_INVALID_XATTR flag
  nfs: make the buf_to_pages_noslab function available to the nfs code
  NFSv4.2: add the extended attribute proc functions.
  NFSv4.2: hook in the user extended attribute handlers
  NFSv4.2: add client side xattr caching.

 fs/nfs/Makefile             |    1 +
 fs/nfs/client.c             |   19 +-
 fs/nfs/dir.c                |   24 +-
 fs/nfs/inode.c              |   16 +-
 fs/nfs/internal.h           |   28 ++
 fs/nfs/nfs42.h              |   24 +
 fs/nfs/nfs42proc.c          |  248 ++++++++++
 fs/nfs/nfs42xattr.c         | 1083 +++++++++++++++++++++++++++++++++++++++++++
 fs/nfs/nfs42xdr.c           |  442 ++++++++++++++++++
 fs/nfs/nfs4_fs.h            |    5 +
 fs/nfs/nfs4client.c         |   31 ++
 fs/nfs/nfs4proc.c           |  248 ++++++++--
 fs/nfs/nfs4super.c          |   10 +
 fs/nfs/nfs4xdr.c            |   29 ++
 fs/nfs/nfstrace.h           |    3 +-
 include/linux/nfs4.h        |   25 +
 include/linux/nfs_fs.h      |   12 +
 include/linux/nfs_fs_sb.h   |    6 +
 include/linux/nfs_xdr.h     |   60 ++-
 include/uapi/linux/nfs4.h   |    3 +
 include/uapi/linux/nfs_fs.h |    1 +
 21 files changed, 2276 insertions(+), 42 deletions(-)
 create mode 100644 fs/nfs/nfs42xattr.c

-- 
2.16.6

