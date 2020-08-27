Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88096254A38
	for <lists+linux-nfs@lfdr.de>; Thu, 27 Aug 2020 18:08:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726147AbgH0QII (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 27 Aug 2020 12:08:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726087AbgH0QIH (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 27 Aug 2020 12:08:07 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E5FEC061264
        for <linux-nfs@vger.kernel.org>; Thu, 27 Aug 2020 09:08:07 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id DCE716EED; Thu, 27 Aug 2020 12:08:05 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org DCE716EED
From:   "J. Bruce Fields" <bfields@redhat.com>
To:     linux-nfs@vger.kernel.org
Cc:     "J. Bruce Fields" <bfields@redhat.com>
Subject: [PATCH 1/2] MAINTAINERS: Add Documentation/ to files we maintain
Date:   Thu, 27 Aug 2020 12:08:02 -0400
Message-Id: <1598544483-14296-1-git-send-email-bfields@redhat.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: "J. Bruce Fields" <bfields@redhat.com>

It struck me while watching Jon Corbet ask how to keep kernel
Documentation up to date, that it might help if we were actually cc'd on
Documentation/filesystems/nfs/ changes.

Signed-off-by: J. Bruce Fields <bfields@redhat.com>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index deaafb617361..5fd2b9990fa6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9482,6 +9482,7 @@ F:	include/linux/sunrpc/
 F:	include/uapi/linux/nfsd/
 F:	include/uapi/linux/sunrpc/
 F:	net/sunrpc/
+F:	Documentation/filesystems/nfs/
 
 KERNEL SELFTEST FRAMEWORK
 M:	Shuah Khan <shuah@kernel.org>
@@ -12233,6 +12234,7 @@ F:	include/linux/sunrpc/
 F:	include/uapi/linux/nfs*
 F:	include/uapi/linux/sunrpc/
 F:	net/sunrpc/
+F:	Documentation/filesystems/nfs/
 
 NILFS2 FILESYSTEM
 M:	Ryusuke Konishi <konishi.ryusuke@gmail.com>
-- 
2.26.2

