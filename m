Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0049A430571
	for <lists+linux-nfs@lfdr.de>; Sun, 17 Oct 2021 00:46:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235575AbhJPWss (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 16 Oct 2021 18:48:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:53172 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235339AbhJPWsr (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Sat, 16 Oct 2021 18:48:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DE72E6115C;
        Sat, 16 Oct 2021 22:46:38 +0000 (UTC)
From:   Chuck Lever <chuck.lever@oracle.com>
To:     bfields@redhat.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v1 03/14] SUNRPC: Remove dprintk call site from svc_authenticate()
Date:   Sat, 16 Oct 2021 18:46:37 -0400
Message-Id:  <163442439776.1001.18137715700141574657.stgit@bazille.1015granger.net>
X-Mailer: git-send-email 2.33.0.113.g6c40894d24
In-Reply-To:  <163442364683.1001.4500967510037013459.stgit@bazille.1015granger.net>
References:  <163442364683.1001.4500967510037013459.stgit@bazille.1015granger.net>
User-Agent: StGit/1.1+62.ged16
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=808; h=from:subject:message-id; bh=7EIP0G9xPuUXh9nESbCA3CNwHCw1TpXUMT4jbRXlakI=; b=owEBbQKS/ZANAwAIATNqszNvZn+XAcsmYgBha1ZNLr3LWAcRWZ/1gRu9zQcaYJtWaULL5jKexHIF BLbHZryJAjMEAAEIAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCYWtWTQAKCRAzarMzb2Z/l7x3EA C7zPqLWc0Ewrx72Try1BSfU6yCv0dWdllxiEeEeZeMCB1UeVUaR7GL7U97uT2uFJxl/V4grgt5O52J zphVK3TlpAqj8KUCYZXIf8wY46oarzcHmPhoQADTynC74uckpy3B6MO5+Sy0XGW7rEwHmXZfE4YdzR rsvKqhx+w7Q+mvwmGkUepfbqAjhrchSH6Qpv/epzvJLlXRxjw96cjm9oRbChZ7/kBoUj65YrIZWZCs pSCO4a6oFYLIvZ2JKDFXoVPnQSW1I4SWKgJjXSNtL/vskTdUNKa70N7OcOX1sU35lBUFzL+QnlmDy1 xcSLaBglpl5/kN/psuItlR4gd/sgxsQJCljOauK3Ps+cFMIkpFm7A2HD7+FLKOrv2eLq4YvRzH+kQ8 ja8UV9yV2y8HJoTWK5us0W+FcSwcDPQLeMwQTmCJkDLsM0LAJlz6/y/EYJd/or1vCrclNZaL/s/mmW /Td0ik+GArnKBSdE8RPCsiSmjxLw/alMPRNo/FqXDUEBV2d2glnfK6j9xnCcbJCT/ZdfGK1uomMA7p kqfCXTXAsjX0V+fC5lOu91FxYHJ+dCbZM92B31VWVPcA0EWP/hYkBkAbHdCMbF4gaWT2dvjz1EEUGK v6LI7TaGROimMzyC5r4Jv7MNGz1SAVagcTqcEbGWsE8B1+XoJUU/LT0iIvBQ==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp; fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Deprecation. This dprintk call site has been replaced by the
svc_authenticate tracepoint invoked in svc_process_common().

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/svcauth.c |    4 ----
 1 file changed, 4 deletions(-)

diff --git a/net/sunrpc/svcauth.c b/net/sunrpc/svcauth.c
index 5a8b8e03fdd4..829eb8920ea3 100644
--- a/net/sunrpc/svcauth.c
+++ b/net/sunrpc/svcauth.c
@@ -23,8 +23,6 @@
 
 #include "sunrpc.h"
 
-#define RPCDBG_FACILITY	RPCDBG_AUTH
-
 
 /*
  * Table of authenticators
@@ -68,8 +66,6 @@ svc_authenticate(struct svc_rqst *rqstp)
 
 	flavor = svc_getnl(&rqstp->rq_arg.head[0]);
 
-	dprintk("svc: svc_authenticate (%d)\n", flavor);
-
 	aops = svc_get_auth_ops(flavor);
 	if (aops == NULL) {
 		rqstp->rq_auth_stat = rpc_autherr_badcred;

