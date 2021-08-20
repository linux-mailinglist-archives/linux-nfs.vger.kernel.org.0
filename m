Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16ED33F2E70
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Aug 2021 16:54:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240926AbhHTOyv (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 20 Aug 2021 10:54:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:47418 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240879AbhHTOyu (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 20 Aug 2021 10:54:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9EF6861102
        for <linux-nfs@vger.kernel.org>; Fri, 20 Aug 2021 14:54:12 +0000 (UTC)
Subject: [PATCH v3 4/4] SUNRPC: Add documentation for the fail_sunrpc/
 directory
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Fri, 20 Aug 2021 10:54:11 -0400
Message-ID: <162947125194.3311.5357193814131649591.stgit@klimt.1015granger.net>
In-Reply-To: <162947112222.3311.9483898011770198455.stgit@klimt.1015granger.net>
References: <162947112222.3311.9483898011770198455.stgit@klimt.1015granger.net>
User-Agent: StGit/1.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 Documentation/fault-injection/fault-injection.rst |   18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/Documentation/fault-injection/fault-injection.rst b/Documentation/fault-injection/fault-injection.rst
index f47d05ed0d94..4a25c5eb6f07 100644
--- a/Documentation/fault-injection/fault-injection.rst
+++ b/Documentation/fault-injection/fault-injection.rst
@@ -24,6 +24,10 @@ Available fault injection capabilities
 
   injects futex deadlock and uaddr fault errors.
 
+- fail_sunrpc
+
+  injects kernel RPC client and server failures.
+
 - fail_make_request
 
   injects disk IO errors on devices permitted by setting
@@ -151,6 +155,20 @@ configuration of fault-injection capabilities.
 	default is 'N', setting it to 'Y' will disable failure injections
 	when dealing with private (address space) futexes.
 
+- /sys/kernel/debug/fail_sunrpc/ignore-client-disconnect:
+
+	Format: { 'Y' | 'N' }
+
+	default is 'N', setting it to 'Y' will disable disconnect
+	injection on the RPC client.
+
+- /sys/kernel/debug/fail_sunrpc/ignore-server-disconnect:
+
+	Format: { 'Y' | 'N' }
+
+	default is 'N', setting it to 'Y' will disable disconnect
+	injection on the RPC server.
+
 - /sys/kernel/debug/fail_function/inject:
 
 	Format: { 'function-name' | '!function-name' | '' }


