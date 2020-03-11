Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F0E15182305
	for <lists+linux-nfs@lfdr.de>; Wed, 11 Mar 2020 21:00:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387445AbgCKUAD (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 11 Mar 2020 16:00:03 -0400
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:62469 "EHLO
        smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387426AbgCKUAB (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 11 Mar 2020 16:00:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1583956800; x=1615492800;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=LbJW0Zt8Sq9kif23K5B2AYAf81NCOkTuXMuqg14/4mo=;
  b=ZzD7ttOwZV3kTXgYQqUUlcUQED9dGBSEyvZgHk/FrIsDJi5EAKfDnduy
   WQKv1j40UC0NylxbW+uzT/XnMAGtr3epQOFXfMXLxi0lXbFV7vxW1jcK2
   4tN+O+6FQ3l2E8zWuify05ayPpWIN+9elNDxqKdBE2DYWM4YaZvqMVJUv
   k=;
IronPort-SDR: asw/sxJZKxONTyvRJ0+XpkX4hUE3e1c8JeqzHs8bSMoAcpWbuVp0f8NdOaM371B3inON2Z8LpH
 soKdqzo0BUzA==
X-IronPort-AV: E=Sophos;i="5.70,541,1574121600"; 
   d="scan'208";a="21101078"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-1e-c7c08562.us-east-1.amazon.com) ([10.43.8.2])
  by smtp-border-fw-out-2101.iad2.amazon.com with ESMTP; 11 Mar 2020 19:59:59 +0000
Received: from EX13MTAUWA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1e-c7c08562.us-east-1.amazon.com (Postfix) with ESMTPS id BCFDB248F59;
        Wed, 11 Mar 2020 19:59:57 +0000 (UTC)
Received: from EX13D13UWA002.ant.amazon.com (10.43.160.172) by
 EX13MTAUWA001.ant.amazon.com (10.43.160.118) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Wed, 11 Mar 2020 19:59:56 +0000
Received: from EX13MTAUEA002.ant.amazon.com (10.43.61.77) by
 EX13D13UWA002.ant.amazon.com (10.43.160.172) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 11 Mar 2020 19:59:55 +0000
Received: from dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com
 (172.23.141.97) by mail-relay.amazon.com (10.43.61.169) with Microsoft SMTP
 Server id 15.0.1236.3 via Frontend Transport; Wed, 11 Mar 2020 19:59:55 +0000
Received: by dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com (Postfix, from userid 6262777)
        id 04B4FDD8DB; Wed, 11 Mar 2020 19:59:54 +0000 (UTC)
From:   Frank van der Linden <fllinden@amazon.com>
To:     <bfields@fieldses.org>, <chuck.lever@oracle.com>,
        <linux-nfs@vger.kernel.org>
CC:     Frank van der Linden <fllinden@amazon.com>
Subject: [PATCH 00/14] server side user xattr support (RFC 8276)
Date:   Wed, 11 Mar 2020 19:59:40 +0000
Message-ID: <20200311195954.27117-1-fllinden@amazon.com>
X-Mailer: git-send-email 2.16.6
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

This patchset implements the server side for NFS user extended attributes,
as defined in RFC8726.

This was originally posted as an RFC in:

https://patchwork.kernel.org/cover/11143565/

Patch 1 is shared with the client side patch, posted
separately.

Most comments in there still apply, except that:

1. As per the discussion, user extended attributes are enabled if
   the client and server support them (e.g. they support 4.2 and
   advertise the user extended attribute FATTR). There are no longer
   options to switch them off on either the client or the server.
2. The code is no longer conditioned on a config option.
3. The number of patches has been reduced somewhat by merging
   smaller, related ones.

This has been tested as follows:

* Linux client and server:
	* Test all corner cases (XATTR_SIZE_*)
	* Test all failure cases (no xattr, setxattr with different or
	  invalid flags, etc).
	* Verify the content of xattrs across several operations.
	* Use KASAN and KMEMLEAK for a longer mix of testruns to verify
	  that there were no leaks (after unmounting the filesystem).

* Tested against the FreeBSD-current implementation as well, which works
  (after I fixed 2 bugs in that implementation, which I'm sending out to
  them too).

* Not tested: RDMA (I couldn't get a setup going).

Frank van der Linden (14):
  nfs,nfsd: NFSv4.2 extended attribute protocol definitions
  xattr: modify vfs_{set,remove}xattr for NFS server use
  nfsd: split off the write decode code in to a separate function
  nfsd: make sure the nfsd4_ops array has the right size
  nfsd: add defines for NFSv4.2 extended attribute support
  nfsd: define xattr functions to call in to their vfs counterparts
  nfsd: take xattr bits in to account for permission checks
  nfsd: add structure definitions for xattr requests / responses
  nfsd: use kvmalloc in svcxdr_tmpalloc
  nfsd: implement the xattr procedure functions.
  nfsd: add user xattr RPC XDR encoding/decoding logic
  nfsd: add xattr operations to ops array
  xattr: add a function to check if a namespace is supported
  nfsd: add fattr support for user extended attributes

 fs/nfsd/nfs4proc.c        | 141 +++++++++++-
 fs/nfsd/nfs4xdr.c         | 535 +++++++++++++++++++++++++++++++++++++++++++---
 fs/nfsd/nfsd.h            |   5 +-
 fs/nfsd/vfs.c             | 142 ++++++++++++
 fs/nfsd/vfs.h             |  10 +
 fs/nfsd/xdr4.h            |  31 +++
 fs/xattr.c                |  90 +++++++-
 include/linux/nfs4.h      |  22 +-
 include/linux/xattr.h     |   4 +
 include/uapi/linux/nfs4.h |   3 +
 10 files changed, 940 insertions(+), 43 deletions(-)

-- 
2.16.6

