Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB1EE42C3E2
	for <lists+linux-nfs@lfdr.de>; Wed, 13 Oct 2021 16:47:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233744AbhJMOte (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 13 Oct 2021 10:49:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:53196 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230385AbhJMOtd (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 13 Oct 2021 10:49:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1C29F60E09;
        Wed, 13 Oct 2021 14:47:30 +0000 (UTC)
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-rdma@vger.kernel.org, linux-nfs@vger.kernel.org
Subject: [PATCH v1 6/6] svcrdma: Remove include/linux/sunrpc/debug.h
Date:   Wed, 13 Oct 2021 10:47:29 -0400
Message-Id:  <163413644893.6408.14362581680618135243.stgit@bazille.1015granger.net>
X-Mailer: git-send-email 2.33.0.113.g6c40894d24
In-Reply-To:  <163413628188.6408.17033105928649076434.stgit@bazille.1015granger.net>
References:  <163413628188.6408.17033105928649076434.stgit@bazille.1015granger.net>
User-Agent: StGit/1.1+62.ged16
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1071; h=from:subject:message-id; bh=SU2fc6xO44rJcYeJ7Q/XgB3v712PexCLQSi7NQz1QL8=; b=owEBbQKS/ZANAwAIATNqszNvZn+XAcsmYgBhZvGBtEQPMImssMNu5v1sxxG36HWwUubl8xCyZ0kq P/OYz5mJAjMEAAEIAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCYWbxgQAKCRAzarMzb2Z/lyFPEA CvLeNHVKaoFGOfwKgoEPq7KrLUkimqqTnrujOdA3ICP5csH+3ZKykBuaetl6wUOIwf3xchQ3t8HR5a SXvOgdtaN+4LNC9eJH8DLNLcKcZM8cvT+wLwo1n9nwHMHrXQOLAi8jnuw/w97MgkhD1EPDwM1JlWeK iaUJHUcABCgtBy5udCW5z5mBEzGdzugnZpFrzZuCy6d9kROy9tkUcJ92MO+cgd7EEzBZmNLWshHXV9 Xhe/XeI6NrU1QVojiV+1KMcwyiW2U1EUud0vbGiOr3yzEHur1FcfN8uceApdbs2oClYBHeCg/Nln6M l/H2LYTtMQ5ul7WzF8wd6GpYIVV6sodAk16/sz6IC+YgmC7GrBsgDMg4x/br4uO9F27Bfmf6XNuFy0 aCj+eYzsMpG6ExaQlH1Q7Lch25Maagwgq9+/d2FTLQO8Un+gq3ea5Khi/11at79TuDKitTUtklISoh //oUGAnxiAMGaGIH+DBFD7cKaJP/S3KeHtPMkje0qUXDLy5mrDVODj4OiztBxdIwr2RBpHrNkNju0B ELXNqcfdlIpN7h71boyemrKs3orMLjo5Cheg1ZDeOOrriy1SC97d6jltxpcXqrdq6jztveig22MWyN 3rn8Y8/u3YTUHbgRYDM6t7C52x8al7r5d5pty8Crat6g7LziDI0tKU5cBFyw==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp; fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Deprecation. svcrdma no longer uses dprintk.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/xprtrdma/svc_rdma_recvfrom.c |    1 -
 net/sunrpc/xprtrdma/svc_rdma_sendto.c   |    1 -
 2 files changed, 2 deletions(-)

diff --git a/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c b/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
index cf76a6ad127b..3be39fc5cec4 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
@@ -99,7 +99,6 @@
 #include <rdma/rdma_cm.h>
 
 #include <linux/sunrpc/xdr.h>
-#include <linux/sunrpc/debug.h>
 #include <linux/sunrpc/rpc_rdma.h>
 #include <linux/sunrpc/svc_rdma.h>
 
diff --git a/net/sunrpc/xprtrdma/svc_rdma_sendto.c b/net/sunrpc/xprtrdma/svc_rdma_sendto.c
index 22a871e6fe4d..e973e5b3ce08 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_sendto.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_sendto.c
@@ -105,7 +105,6 @@
 #include <rdma/ib_verbs.h>
 #include <rdma/rdma_cm.h>
 
-#include <linux/sunrpc/debug.h>
 #include <linux/sunrpc/svc_rdma.h>
 
 #include "xprt_rdma.h"

