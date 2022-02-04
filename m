Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1F744AA048
	for <lists+linux-nfs@lfdr.de>; Fri,  4 Feb 2022 20:42:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231808AbiBDTm2 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 4 Feb 2022 14:42:28 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:42294 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232169AbiBDTm1 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 4 Feb 2022 14:42:27 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A445461D00
        for <linux-nfs@vger.kernel.org>; Fri,  4 Feb 2022 19:42:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E65E1C004E1;
        Fri,  4 Feb 2022 19:42:25 +0000 (UTC)
Subject: [PATCH] Permit COMMIT operations to return NFS4_OK
From:   Chuck Lever <chuck.lever@oracle.com>
To:     bfields@fieldses.org
Cc:     linux-nfs@vger.kernel.org
Date:   Fri, 04 Feb 2022 14:42:24 -0500
Message-ID: <164400374422.1026143.17746475126462213720.stgit@morisot.1015granger.net>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

RFC 7530 permits COMMIT to return NFS4ERR_INVAL, but RFC 5661 and
later do not. Allow INVAL as a legacy behavior, but test for OK
also.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 nfs4.0/servertests/st_commit.py |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/nfs4.0/servertests/st_commit.py b/nfs4.0/servertests/st_commit.py
index 12a0dffa061f..4ef87e69c5d7 100644
--- a/nfs4.0/servertests/st_commit.py
+++ b/nfs4.0/servertests/st_commit.py
@@ -160,4 +160,4 @@ def testCommitOverflow(t, env):
     res = c.write_file(fh, _text, 0, stateid, how=UNSTABLE4)
     check(res, msg="WRITE with how=UNSTABLE4")
     res = c.commit_file(fh, 0xfffffffffffffff0, 64)
-    check(res, NFS4ERR_INVAL, "COMMIT with offset + count overflow")
+    check(res, [NFS4_OK, NFS4ERR_INVAL], "COMMIT with offset + count overflow")


