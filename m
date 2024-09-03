Return-Path: <linux-nfs+bounces-6132-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 160EE969166
	for <lists+linux-nfs@lfdr.de>; Tue,  3 Sep 2024 04:21:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 790CEB226DA
	for <lists+linux-nfs@lfdr.de>; Tue,  3 Sep 2024 02:21:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE6971A3AAE;
	Tue,  3 Sep 2024 02:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="Sd7GYykZ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from esa6.hc1455-7.c3s2.iphmx.com (esa6.hc1455-7.c3s2.iphmx.com [68.232.139.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B145213D8B2;
	Tue,  3 Sep 2024 02:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.139.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725330044; cv=none; b=gdCyYxRyh6KquKBtFKXYURqqrO0FVbyWv2rmw1RsFiIixMGqM9PTgt8PIoglJHcBpjzA6fr3oH23uU40n51uHba+Zf5qRRdqbw3ZYVq4RLvJ74UNdRvf41AZmG0nS5L4+mc9KsFFqqthIMg6C/9or/qhyPx7XgcfV+cvqWgeooQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725330044; c=relaxed/simple;
	bh=yuPHtis7CJ7jgf9ECOLC4vtELlpTMDGof3D4qz9m/PU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=h3p7QRpkoZq2XDTPhimJsV3e2ALODnG6Avn7iHE+m+x81XUj4fIkVvxXpPXHA8+HW6QuyeBdhr3hX9o3QsIho9liCeEwtHUWF4G+/o2noQPE4LWI88NhlYjmmuqCoClPFw4mcbed+BVxTMhewgd2uXV4QtE1PiSEp6q2Tu4+4m4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=Sd7GYykZ; arc=none smtp.client-ip=68.232.139.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1725330042; x=1756866042;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=yuPHtis7CJ7jgf9ECOLC4vtELlpTMDGof3D4qz9m/PU=;
  b=Sd7GYykZGrbJIbrO6Cf8rgZ2x4Db6mnL4OYwHa+He1G6bFfrLsalcm/s
   WINsZTW1Ns9LlZmBVtq/+MHaJIS39KxhY9O+ocsM4bGS9dDOC5tUHhl8J
   2PipY6ato8RgtGQXaU7ujjQJVZuzHDwMXCSAoRZE+OGqr7bVSR31bBNOC
   nHPXGQuvZCNO9BIhKjZSksut1/IL5zkl5E3dQoLzR8obTC1pvZBXU2e7F
   W6ohczOOK0teIwYzN/y9CpD1A2XAa+JwZo2lUR8R5msEBTbyX7lxJZo3H
   BzZu+FEeEm7AJR/yAScJbRecS2Mkve9S8osV7hXkQkWu/jkddHi/RCYYa
   Q==;
X-CSE-ConnectionGUID: P7GXPCNIRLCgmwPWQwyZkQ==
X-CSE-MsgGUID: PTirvS0MQqqlaZpXXOVZ1g==
X-IronPort-AV: E=McAfee;i="6700,10204,11183"; a="174525965"
X-IronPort-AV: E=Sophos;i="6.10,197,1719846000"; 
   d="scan'208";a="174525965"
Received: from unknown (HELO oym-r2.gw.nic.fujitsu.com) ([210.162.30.90])
  by esa6.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2024 11:19:29 +0900
Received: from oym-m1.gw.nic.fujitsu.com (oym-nat-oym-m1.gw.nic.fujitsu.com [192.168.87.58])
	by oym-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id E4480D7AD2;
	Tue,  3 Sep 2024 11:19:26 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com [192.51.206.22])
	by oym-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id 3016CD8B8F;
	Tue,  3 Sep 2024 11:19:26 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id B03466BD57;
	Tue,  3 Sep 2024 11:19:25 +0900 (JST)
Received: from G08FNSTD200033.g08.fujitsu.local (unknown [10.167.135.89])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id 3F5751A0002;
	Tue,  3 Sep 2024 10:19:25 +0800 (CST)
From: Chen Hanxiao <chenhx.fnst@fujitsu.com>
To: fstests@vger.kernel.org
Cc: linux-nfs@vger.kernel.org
Subject: [xfstests PATCH] generic/362: skip test on NFS mount
Date: Tue,  3 Sep 2024 10:18:09 +0800
Message-ID: <20240903021918.2491-1-chenhx.fnst@fujitsu.com>
X-Mailer: git-send-email 2.45.2.windows.1
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28638.004
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28638.004
X-TMASE-Result: 10--4.446100-10.000000
X-TMASE-MatchedRID: xI3RMDI2TqqXC3sMAGu+nyZm6wdY+F8Kh6nwisY6+c3ssozRObR7SwED
	/uSVdVZa5/gG8CUYdiud6Lv9qI8wHwH3QVwvWrgwxi///JpaHQMjoYO/ya1mOgbxceezd6S1sqh
	SzMv5Wabg8q4Y37zKTaau4JLYI3mtpdSzuQPv1Taqm5TddPf7vphqxsBO7lrLLEzDQUyQGVlzIc
	rfc0JQo2GEv7zMAMZrgDLqnrRlXrZ8nn9tnqel2MZW5ai5WKlyVQtMKTIrBwvv/BHIrck6yd7di
	4MEmwNPzNU6oUVjyvBgMEaqaCqEWratQ/iTpZoCAtCfevCRwJtADb4T7dccHJiCRWqMnRAuEWW0
	bEJOTAVAdUD6vW8Z1mZAMQMIyK6zB8/x9JIi8hKhgLRzA45JPQ==
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0

xfstests complains:

# ./check -d generic/362
FSTYP         -- nfs
PLATFORM      -- Linux/x86_64 r95b-1 5.14.0-496.el9.x86_64 #1 SMP PREEMPT_DYNAMIC Mon Aug 12 18:50:44 EDT 2024
MKFS_OPTIONS  -- 192.168.122.42:/nfsscratch
MOUNT_OPTIONS -- -o vers=4.2 192.168.122.42:/nfsscratch /mnt/scratch

generic/362       QA output created by 362
Failed to open/create file: Invalid argument
Silence is golden
- output mismatch (see /var/lib/xfstests/results//generic/362.out.bad)
    --- tests/generic/362.out   2024-09-02 14:27:09.162636093 -0400
    +++ /var/lib/xfstests/results//generic/362.out.bad  2024-09-02 14:33:36.167636093 -0400
    @@ -1,2 +1,3 @@
     QA output created by 362
    +Failed to open/create file: Invalid argument
     Silence is golden
    ...
    (Run 'diff -u /var/lib/xfstests/tests/generic/362.out /var/lib/xfstests/results//generic/362.out.bad'  to see the entire diff)
Ran: generic/362
Failures: generic/362
Failed 1 of 1 tests

NFS commit 9597c13b forbade open with O_APPEND|O_DIRECT

strace show that dio-append-buf-fault use (O_APPEND|O_DIRECT):

 mount -o vers=4.2 192.168.122.42:/nfstest /mnt/scratch/
 strace ./src/dio-append-buf-fault /mnt/scratch/111
..
  openat(AT_FDCWD, "/mnt/scratch/111", O_WRONLY|O_CREAT|O_TRUNC|O_APPEND|O_DIRECT, 0666) = 3

So skip generic/362 on NFS

Signed-off-by: Chen Hanxiao <chenhx.fnst@fujitsu.com>
---
 tests/generic/362 | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tests/generic/362 b/tests/generic/362
index f5b4ed06..d7bb0125 100755
--- a/tests/generic/362
+++ b/tests/generic/362
@@ -18,6 +18,8 @@ _require_test_program dio-append-buf-fault
 	_fixed_by_kernel_commit 939b656bc8ab \
 	"btrfs: fix corruption after buffer fault in during direct IO append write"
 
+test $FSTYP == "nfs"  && _notrun "NFS forbade open with O_APPEND|O_DIRECT"
+
 # On error the test program writes messages to stderr, causing a golden output
 # mismatch and making the test fail.
 $here/src/dio-append-buf-fault $TEST_DIR/dio-append-buf-fault
-- 
2.43.5


