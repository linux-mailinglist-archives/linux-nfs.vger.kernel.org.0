Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38A74430570
	for <lists+linux-nfs@lfdr.de>; Sun, 17 Oct 2021 00:46:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235558AbhJPWsm (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 16 Oct 2021 18:48:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:53108 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235339AbhJPWsl (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Sat, 16 Oct 2021 18:48:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 59FA761101;
        Sat, 16 Oct 2021 22:46:32 +0000 (UTC)
From:   Chuck Lever <chuck.lever@oracle.com>
To:     bfields@redhat.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v1 02/14] SUNRPC: Remove dprintk call sites from svcauth_unix.c
Date:   Sat, 16 Oct 2021 18:46:31 -0400
Message-Id:  <163442439122.1001.10617673230038475043.stgit@bazille.1015granger.net>
X-Mailer: git-send-email 2.33.0.113.g6c40894d24
In-Reply-To:  <163442364683.1001.4500967510037013459.stgit@bazille.1015granger.net>
References:  <163442364683.1001.4500967510037013459.stgit@bazille.1015granger.net>
User-Agent: StGit/1.1+62.ged16
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=962; h=from:subject:message-id; bh=GZNDM3jpBypJG+U0xaR6DkeQ1BEAD4BpPWIJHUAPz+o=; b=owEBbQKS/ZANAwAIATNqszNvZn+XAcsmYgBha1ZHdnshHOvz2MLRoXkYUeXk2ggnsstSGA6vQavt QOBZORSJAjMEAAEIAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCYWtWRwAKCRAzarMzb2Z/l+oAD/ 9r0G7xBbNjPZUTcRZy69ED+eBeaa/ZqkUNl2VJTjqidxy+32rdV4XzFbx/p8ukmg7oGejmQ1QN23kD XJr5LCitXL6kSufgocUpv++CHTU5UGVG1ZdE8yAlyoivEYRxcYd2HoOCeRtZDCscSEGJiL7UiUIYPJ BJig3QAHUjmlfdMZznVbtArioarVZK2JDOSRU7Jy2rdLg8H7ivZ5kZ3xBrowukJhvvMpQRgta1PaVn FBBaHSbsR804z8SnghHnvkX9Dxnih54SSuO9s7PlTqGIRP6tfRGIEA+Z/M9FfGwRBOrFDBM+/fgzWw 2T7mt5lma7SZ6/SEb0FGhkIsW9gryhVKCPmxsha14jE02n57KgX0LtiIFkjC7FvAnmJ8LNxmayxY7R 5GorbeaUBnXUANnZ+D6IjKIAXMu/3oz2ao3/yryvWyz08jgZttxmsEkL/BtJ0ypDUZqcvUC3Mi+jlf JNgJ7den2dOHQUkYuXvCJiJ5crqnaquD2EH1VAD/3xXSEPq+zFh+ilzgn2AxOVZVO23Pvf6zZl/yhK kCaTY/Oe1I3SbEEO3cjZLhBV4EZiEmr1hg3baNyWOuIlxZv2uKebiz4Ypjypcy5jpQ902igmKRwfDe Ajq4faM3kkksqthvQaii/ZGgYzX7DdrnUU5EYHboVnF2FilJUgjjMpcOgcwQ==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp; fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Deprecation. Remove low-value dprintk call sites.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/svcauth_unix.c |    4 ----
 1 file changed, 4 deletions(-)

diff --git a/net/sunrpc/svcauth_unix.c b/net/sunrpc/svcauth_unix.c
index d7ed7d49115a..225845035e0e 100644
--- a/net/sunrpc/svcauth_unix.c
+++ b/net/sunrpc/svcauth_unix.c
@@ -17,8 +17,6 @@
 #include <net/ipv6.h>
 #include <linux/kernel.h>
 #include <linux/user_namespace.h>
-#define RPCDBG_FACILITY	RPCDBG_AUTH
-
 
 #include "netns.h"
 
@@ -739,12 +737,10 @@ svcauth_null_accept(struct svc_rqst *rqstp)
 		return SVC_GARBAGE;
 
 	if (svc_getu32(argv) != 0) {
-		dprintk("svc: bad null cred\n");
 		rqstp->rq_auth_stat = rpc_autherr_badcred;
 		return SVC_DENIED;
 	}
 	if (svc_getu32(argv) != htonl(RPC_AUTH_NULL) || svc_getu32(argv) != 0) {
-		dprintk("svc: bad null verf\n");
 		rqstp->rq_auth_stat = rpc_autherr_badverf;
 		return SVC_DENIED;
 	}

