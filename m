Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C41CD3E84EB
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Aug 2021 23:05:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233460AbhHJVGS (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 10 Aug 2021 17:06:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:57932 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232739AbhHJVGS (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 10 Aug 2021 17:06:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 13120603E7
        for <linux-nfs@vger.kernel.org>; Tue, 10 Aug 2021 21:05:56 +0000 (UTC)
Subject: [PATCH v2 0/4] SunRPC fault injection
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Tue, 10 Aug 2021 17:05:55 -0400
Message-ID: <162862940914.263874.10843184118571471892.stgit@klimt.1015granger.net>
User-Agent: StGit/1.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The following series (re)implements SunRPC disconnect injection
using the kernel's generic fault injection infrastructure under
the debugfs. It's partially a clean-up and partially a fresh
implementation of server-side disconnect injection, while also
enabling the straightforward addition of further types of fault
injection in the future.


Changes since v1:
- Now builds properly with various combinations of CONFIG options

---

Chuck Lever (4):
      SUNRPC: Add a /sys/kernel/debug/fail_sunrpc/ directory
      SUNRPC: Server-side disconnect injection
      SUNRPC: Move client-side disconnect injection
      SUNRPC: Add documentation for the fail_sunrpc/ directory


 .../fault-injection/fault-injection.rst       | 18 +++++
 include/linux/sunrpc/xprt.h                   | 18 -----
 net/sunrpc/debugfs.c                          | 73 +++++--------------
 net/sunrpc/fail.h                             | 24 ++++++
 net/sunrpc/svc.c                              |  8 ++
 net/sunrpc/xprt.c                             | 14 ++++
 6 files changed, 84 insertions(+), 71 deletions(-)
 create mode 100644 net/sunrpc/fail.h

--
Chuck Lever

