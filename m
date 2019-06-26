Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E9F0656F3E
	for <lists+linux-nfs@lfdr.de>; Wed, 26 Jun 2019 19:03:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726006AbfFZRDC (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 26 Jun 2019 13:03:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33312 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726179AbfFZRDB (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 26 Jun 2019 13:03:01 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4091D308792E;
        Wed, 26 Jun 2019 17:03:01 +0000 (UTC)
Received: from f29-node1.dwysocha.net (dhcp145-42.rdu.redhat.com [10.13.145.42])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EE64B600CC;
        Wed, 26 Jun 2019 17:02:59 +0000 (UTC)
From:   Dave Wysochanski <dwysocha@redhat.com>
To:     chuck.lever@oracle.com, SteveD@RedHat.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH] mountstats: Fix nfsstat command to handle RPC iostats version >= 1.1
Date:   Wed, 26 Jun 2019 13:02:58 -0400
Message-Id: <20190626170259.8347-1-dwysocha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Wed, 26 Jun 2019 17:03:01 +0000 (UTC)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Later kernels with RPC iostats version >= 1.1 have an additional errors
count for each op.  Lengthen the array of values created inside
DeviceData and then in __parse_rpc_line just zero this value out for
prior kernels where this count is not present.  The count is not used
for nfsstat, but this keeps DeviceData consistent with the new count
as well as proper functioning of accumulate_iostats.

Before this patch, nfsstat will backtrace on a kernel with RPC iostats
version >= 1.1 due to the fixed array inside DeviceData.  This patch
fixes this backtrace and also allows nfsstat to work with these new
kernels.

Signed-off-by: Dave Wysochanski <dwysocha@redhat.com>
---
 tools/mountstats/mountstats.py | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/mountstats/mountstats.py b/tools/mountstats/mountstats.py
index c5e8f506..6ac83ccb 100755
--- a/tools/mountstats/mountstats.py
+++ b/tools/mountstats/mountstats.py
@@ -308,6 +308,8 @@ class DeviceData:
             op = words[0][:-1]
             self.__rpc_data['ops'] += [op]
             self.__rpc_data[op] = [int(word) for word in words[1:]]
+            if len(self.__rpc_data[op]) < 9:
+                self.__rpc_data[op] += [0]
 
     def parse_stats(self, lines):
         """Turn a list of lines from a mount stat file into a 
@@ -582,7 +584,7 @@ class DeviceData:
             self.__nfs_data['fstype'] = 'nfs4'
         self.__rpc_data['ops'] = ops
         for op in ops:
-            self.__rpc_data[op] = [0 for i in range(8)]
+            self.__rpc_data[op] = [0 for i in range(9)]
 
     def accumulate_iostats(self, new_stats):
         """Accumulate counters from all RPC op buckets in new_stats.  This is
-- 
2.20.1

