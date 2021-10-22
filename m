Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFC22437F3C
	for <lists+linux-nfs@lfdr.de>; Fri, 22 Oct 2021 22:16:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234295AbhJVUTJ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 22 Oct 2021 16:19:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:33200 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234133AbhJVUTJ (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 22 Oct 2021 16:19:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4CE96610CB;
        Fri, 22 Oct 2021 20:16:51 +0000 (UTC)
From:   Chuck Lever <chuck.lever@oracle.com>
To:     kolga@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v2 0/2] Refactor trace macro helpers
Date:   Fri, 22 Oct 2021 16:16:49 -0400
Message-Id:  <163493357334.45814.12809635386158569619.stgit@bazille.1015granger.net>
X-Mailer: git-send-email 2.33.0.113.g6c40894d24
User-Agent: StGit/1.1+62.ged16
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=885; h=from:subject:message-id; bh=C6m1Ue0v8hPAHRjfdSc9WMTivs2u7BvkMalyK17UlBw=; b=owEBbQKS/ZANAwAIATNqszNvZn+XAcsmYgBhcxwrXn9ucfeoBKyvb+Qfp0gtgP88oyeY4V3dEZAX EdFgSd+JAjMEAAEIAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCYXMcKwAKCRAzarMzb2Z/lxP1D/ 9ickAh3tXUpL65ujtF79xXlsULwe7+b/5ST/f1dey4X09Xsh4UcG1P1ER4j+OMFo3USl4nqhSxp8Qe KQkgoAmvUyWos1wD0s7gYnUaW/r0NQAjcZBAr6h9h5d9GHfS4NVpPAdHSg8XH7bk3C8+11T0UsEiLv WaFdfxmLRkdC1gDpUqkN/wQ9ORnVqfjGYa1Aezvbr4lCURjJyZLhCcxnWV+P/5r+yqDaKiIldKnOMp d2Z+h7g+ehy7FhJLpU/g1W1XdZfqlqCdSO7v1SNI3rIjb4ZmthyL6McVq3tar8nPuahTO06PrEgZu2 znX5mXJrx3kStR7NVvfXkf3Vs87A+Zs9dxwbyUkJJJKG7BksL3I8SOujV56YLddT67QsTFNlIcCH9l CJ+H0JykQxw8O7XvtrLxjwOduRwnVPb80oZmfMiySTU+yK0H8eOeIZaJW5MTcm7NkhlrTfZWg0Sb99 Etu5uNH2ozoVZDqlEPkdmdF9NG88ektLpuv5IX+trFFV8BHddCsytbh9acbJJb4bFc4nutoS2+LsLL SWYm3dUzvVyWzdgZvc+fzA//IVziI0kuVfKDNeN7r8dFKadiWwGgP5E+2b8Sm0OgwgicQQv7hjvk2x v31XcoPM/ZYVg7eQsWINkAwuvy8wcRstmOXewrZGTAuZo0+I63F+sl5wSBfw==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp; fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Changes since v1:
- Rebased on Trond's current "testing" branch
- Shortened show_fs_fmode macro to prevent pre-processor overflow

Note that these changed patches compile, but haven't otherwise been
tested again.

---

Chuck Lever (2):
      NFS: Move generic FS show macros to global header
      NFS: Move NFS protocol display macros to global header


 fs/nfs/nfs4trace.h         | 468 +++++--------------------------------
 fs/nfs/nfstrace.h          | 197 +++-------------
 fs/nfs/pnfs.h              |   4 -
 fs/nfsd/trace.h            |   1 +
 include/linux/nfs4.h       |   4 +
 include/trace/events/fs.h  | 122 ++++++++++
 include/trace/events/nfs.h | 375 +++++++++++++++++++++++++++++
 7 files changed, 588 insertions(+), 583 deletions(-)
 create mode 100644 include/trace/events/fs.h
 create mode 100644 include/trace/events/nfs.h

--
Chuck Lever
