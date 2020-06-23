Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA95F206766
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Jun 2020 00:44:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388031AbgFWWoX (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 23 Jun 2020 18:44:23 -0400
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:57655 "EHLO
        smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388036AbgFWWoR (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 23 Jun 2020 18:44:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1592952257; x=1624488257;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=/fUpx/Fv9ePxYufS7yljPTvAo0DofduAJYfjMdxrK8M=;
  b=gQtcz3IW07/gnIWMGgkAD1iQR2ituhUf+nk/Ld5JbeL3p0CE7UkXruW1
   SnXHAur4UfXrquQd1Z1z++jcf54OEWMiF2N+IM2Cw35Uk3wTugltkeyDg
   Z07QQRKbHXRyJG8r7c0E3+zBCnzIJhqd4tWJ+iUPfMGd/ARlSdLiro74D
   Y=;
IronPort-SDR: D/4UG0xyUIy4ecgjsN/WnvhOskjo2EkPmPWOHelIL/gQyE9RptXp22wQRmWoz0g4tugPIf820z
 jAdEonAeq6Iw==
X-IronPort-AV: E=Sophos;i="5.75,272,1589241600"; 
   d="scan'208";a="46390838"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-2b-81e76b79.us-west-2.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9101.sea19.amazon.com with ESMTP; 23 Jun 2020 22:39:34 +0000
Received: from EX13MTAUWB001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan3.pdx.amazon.com [10.170.41.166])
        by email-inbound-relay-2b-81e76b79.us-west-2.amazon.com (Postfix) with ESMTPS id 3FB1AA1F4E;
        Tue, 23 Jun 2020 22:39:33 +0000 (UTC)
Received: from EX13D13UWB002.ant.amazon.com (10.43.161.21) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.249) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 23 Jun 2020 22:39:28 +0000
Received: from EX13MTAUWB001.ant.amazon.com (10.43.161.207) by
 EX13D13UWB002.ant.amazon.com (10.43.161.21) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 23 Jun 2020 22:39:28 +0000
Received: from dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com
 (172.23.141.97) by mail-relay.amazon.com (10.43.161.249) with Microsoft SMTP
 Server id 15.0.1497.2 via Frontend Transport; Tue, 23 Jun 2020 22:39:27 +0000
Received: by dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com (Postfix, from userid 6262777)
        id F389BC378B; Tue, 23 Jun 2020 22:39:27 +0000 (UTC)
From:   Frank van der Linden <fllinden@amazon.com>
To:     <bfields@fieldses.org>, <chuck.lever@oracle.com>,
        <linux-nfs@vger.kernel.org>
CC:     Frank van der Linden <fllinden@amazon.com>
Subject: [PATCH v3 00/10] server side user xattr support (RFC 8276)
Date:   Tue, 23 Jun 2020 22:39:17 +0000
Message-ID: <20200623223927.31795-1-fllinden@amazon.com>
X-Mailer: git-send-email 2.16.6
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

v3:
  * Rebase to v5.8-rc2
  * Use length probe + allocate + query for the listxattr and setxattr
    operations to avoid allocating unneeded space.
  * Because of the above, drop the 'use kvmalloc for svcxdr_tmpalloc' patch,
    as it's no longer needed.

v2:
  * As per the discussion, user extended attributes are enabled if
    the client and server support them (e.g. they support 4.2 and
    advertise the user extended attribute FATTR). There are no longer
    options to switch them off.
  * The code is no longer conditioned on a config option.
  * The number of patches has been reduced somewhat by merging
    smaller, related ones.
  * Renamed some functions and added parameter comments as requested.

v1:

  * Split in to client and server (changed from the original RFC patch).

Original RFC combined set is here:

https://www.spinics.net/lists/linux-nfs/msg74843.html

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


Frank van der Linden (10):
  xattr: break delegations in {set,remove}xattr
  xattr: add a function to check if a namespace is supported
  nfs,nfsd: NFSv4.2 extended attribute protocol definitions
  nfsd: split off the write decode code in to a separate function
  nfsd: add defines for NFSv4.2 extended attribute support
  nfsd: define xattr functions to call in to their vfs counterparts
  nfsd: take xattr bits in to account for permission checks
  nfsd: add structure definitions for xattr requests / responses
  nfsd: implement the xattr functions and en/decode logic
  nfsd: add fattr support for user extended attributes

 fs/nfsd/nfs4proc.c        | 128 ++++++++-
 fs/nfsd/nfs4xdr.c         | 531 +++++++++++++++++++++++++++++++++++---
 fs/nfsd/nfsd.h            |   5 +-
 fs/nfsd/vfs.c             | 239 +++++++++++++++++
 fs/nfsd/vfs.h             |  10 +
 fs/nfsd/xdr4.h            |  31 +++
 fs/xattr.c                | 111 +++++++-
 include/linux/nfs4.h      |  22 +-
 include/linux/xattr.h     |   4 +
 include/uapi/linux/nfs4.h |   3 +
 10 files changed, 1044 insertions(+), 40 deletions(-)

-- 
2.17.2

