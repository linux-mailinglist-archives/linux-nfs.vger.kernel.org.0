Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FFC0206756
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Jun 2020 00:44:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387930AbgFWWoN (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 23 Jun 2020 18:44:13 -0400
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:57642 "EHLO
        smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387795AbgFWWoL (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 23 Jun 2020 18:44:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1592952251; x=1624488251;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=CrBCDZQjGdOs5I6IY9zym4LKELwTe7yZISPi1DF8ptQ=;
  b=OUgegeaMX+rFB+kW2kyD/e2qL2Audn/3FK3uUeySBnFKTy0qeNo8a/E6
   gbeMaXQongff6eT4QCCK+oQ3+zVaYv+AD2lJswV2t5YxaXm5H56+vZLaK
   bu917qZLlU2kfNDOJzlUMiMMv6VopMwInfaDAT0sTtgPtjHC1r6msUcV9
   8=;
IronPort-SDR: 7n9XDBLyhDX6f5PeDljA90SU+XdqLMs+jYobfzT00c3nZiazt0v+xcS4IZhx/T+pnQT79xBjgG
 n+cE/4fEaHfw==
X-IronPort-AV: E=Sophos;i="5.75,272,1589241600"; 
   d="scan'208";a="46390764"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-1e-62350142.us-east-1.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9101.sea19.amazon.com with ESMTP; 23 Jun 2020 22:39:08 +0000
Received: from EX13MTAUWA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1e-62350142.us-east-1.amazon.com (Postfix) with ESMTPS id D785CA246F;
        Tue, 23 Jun 2020 22:39:06 +0000 (UTC)
Received: from EX13D13UWA001.ant.amazon.com (10.43.160.136) by
 EX13MTAUWA001.ant.amazon.com (10.43.160.118) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 23 Jun 2020 22:39:06 +0000
Received: from EX13MTAUEA001.ant.amazon.com (10.43.61.82) by
 EX13D13UWA001.ant.amazon.com (10.43.160.136) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 23 Jun 2020 22:39:05 +0000
Received: from dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com
 (172.23.141.97) by mail-relay.amazon.com (10.43.61.243) with Microsoft SMTP
 Server id 15.0.1497.2 via Frontend Transport; Tue, 23 Jun 2020 22:39:04 +0000
Received: by dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com (Postfix, from userid 6262777)
        id AE950C378B; Tue, 23 Jun 2020 22:39:04 +0000 (UTC)
From:   Frank van der Linden <fllinden@amazon.com>
To:     <linux-nfs@vger.kernel.org>, <anna.schumaker@netapp.com>,
        <trond.myklebust@hammerspace.com>
CC:     Frank van der Linden <fllinden@amazon.com>
Subject: [PATCH v3 00/13] client side user xattr (RFC8276) support
Date:   Tue, 23 Jun 2020 22:38:51 +0000
Message-ID: <20200623223904.31643-1-fllinden@amazon.com>
X-Mailer: git-send-email 2.16.6
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

v3:
   * Rebase to v5.8-rc2

v2:
   * Move nfs4 specific definitions to nfs_fs4.h
   * Squash some patches together to avoid unused function warnings
     when bisecting.
   * Made determining server support a two-step process. First,
     the extended attribute FATTR is verified to be supported, then
     the value of the attributed is queried in fsinfo to determine
     support.
   * Fixed up Makefile to remove an unneeded extra line.

v1:
   * Client side caching is now included in this patch set.
   * As per the discussion, user extended attributes are enabled if
     the client and server support them (e.g. they support 4.2 and
     advertise the user extended attribute FATTR). There are no longer
     options to switch them off on either the client or the server.
   * The code is no longer conditioned on a config option.
   * The number of patches has been reduced somewhat by merging
     smaller, related ones.


Original combined client/server RFC:
https://patchwork.kernel.org/cover/11143565/

In general, these patches were, both server and client, tested as
follows:
        * stress-ng-xattr with 1000 workers
        * Test all corner cases (XATTR_SIZE_*)
        * Test all failure cases (no xattr, setxattr with different or
          invalid flags, etc).
        * Verify the content of xattrs across several operations.
        * Use KASAN and KMEMLEAK for a longer mix of testruns to verify
          that there were no leaks (after unmounting the filesystem).
        * Interop run against FreeBSD server/client implementation.
        * Ran xfstests-dev, with no unexpected/new failures as compared
          to an unpatched kernel. To fully use xfstests-dev, it needed
          some modifications, as it expects to either use all xattr
          namespaces, or none. Whereas NFS only suppors the "user."
          namespace (+ optional ACLs). I will send the changes in
          seperately.
	* Test the memory shrinker for the client side cache by running
	  the client inside a 1G KVM VM, filling up the cache by running
	  an agressive multi-threaded xattr workload, and tracing the
	  shrinker when it kicked in. No memory allocation problems were
	  seen.

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

