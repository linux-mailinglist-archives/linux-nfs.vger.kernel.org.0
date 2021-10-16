Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C69D430575
	for <lists+linux-nfs@lfdr.de>; Sun, 17 Oct 2021 00:47:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237304AbhJPWtO (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 16 Oct 2021 18:49:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:53458 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235339AbhJPWtN (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Sat, 16 Oct 2021 18:49:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 107EE604DB;
        Sat, 16 Oct 2021 22:47:04 +0000 (UTC)
From:   Chuck Lever <chuck.lever@oracle.com>
To:     bfields@redhat.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v1 07/14] SUNRPC: Remove redundant dprintk call sites from svc_process_common()
Date:   Sat, 16 Oct 2021 18:47:04 -0400
Message-Id:  <163442442393.1001.12217935588511299594.stgit@bazille.1015granger.net>
X-Mailer: git-send-email 2.33.0.113.g6c40894d24
In-Reply-To:  <163442364683.1001.4500967510037013459.stgit@bazille.1015granger.net>
References:  <163442364683.1001.4500967510037013459.stgit@bazille.1015granger.net>
User-Agent: StGit/1.1+62.ged16
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1243; h=from:subject:message-id; bh=rrc7v8g9IYSfpHmooktsReZAp4HOdcoIf0HVfQpfpc4=; b=owEBbQKS/ZANAwAIATNqszNvZn+XAcsmYgBha1ZoDwKxwF9OX+/sKZn4pTKDjn3jj1I6iRkqwcVz RxFRIASJAjMEAAEIAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCYWtWaAAKCRAzarMzb2Z/l8woEA DA13WRGbdIyUajSC64NTFVogYDsIOoRS1qe4JvoOD+OuBCGSYhx3U5EhVJ21OW9vv1bfqyeljUl54x hKVGnPXUqkO0BdbGMO3fdzy6qwofdhJu1boYOLrSPNtf2RaD8LMQR1MLszQtYjTeW1/SXmcUFCYSbD 4Q2MRHfWgmkurUAHB0pqHKhltM14A8+yxXsUnrMo7gXEwt+mclCtqq3zDDfVFGkCDDY0u4YzyUq8Dn uSQmmWTKFqZZngYyNj3B12ohEVRe4Yf8Kxjt+RFYWhHXh5PRrADXaKMBlNr2kMgEmMqb36hPsnBwVn XeB2sWIXkzqbpCbeoXpPNSWQWJxdVF2MKs58VmVx97HNHicc8HqCBnKxWDeziSsbw7FSkAQmbORoho zfFCHFdEEmWbCwMRpZpbQufC/zaCt0R8LUhj96oSLB/U6dku6kvxyzjIVY+yBxkAdP1fzZ//Esoy1E yXHH3FyeMMMGiEYfOT3kndstKa/zCx4WPmygB0U0TTRgKOFhNtJtexFqDzRCCFlAGj2AYOc3fEQ7FK NyRqTU6aHJZvBzErLWrYHKpOpPEPvxgrCok8TNgKNxJS5+YARgAblOS6l3eVXZTYPBhxrch+/4P2f7 I8X+gUGaj6IJoxY08rafBfF7ITyuHaosTLOZ2omAJfg426sKh9Z/2fRZdxbg==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp; fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Deprecation. There are already tracepoints that cover these cases.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/svc.c |    4 ----
 1 file changed, 4 deletions(-)

diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
index dbc44178daac..5cfbda94e759 100644
--- a/net/sunrpc/svc.c
+++ b/net/sunrpc/svc.c
@@ -1369,7 +1369,6 @@ svc_process_common(struct svc_rqst *rqstp, struct kvec *argv, struct kvec *resv)
 
  dropit:
 	svc_authorise(rqstp);	/* doesn't hurt to call this twice */
-	dprintk("svc: svc_process dropit\n");
 	return 0;
 
  close:
@@ -1377,7 +1376,6 @@ svc_process_common(struct svc_rqst *rqstp, struct kvec *argv, struct kvec *resv)
 close_xprt:
 	if (rqstp->rq_xprt && test_bit(XPT_TEMP, &rqstp->rq_xprt->xpt_flags))
 		svc_close_xprt(rqstp->rq_xprt);
-	dprintk("svc: svc_process close\n");
 	return 0;
 
 err_short_len:
@@ -1394,8 +1392,6 @@ svc_process_common(struct svc_rqst *rqstp, struct kvec *argv, struct kvec *resv)
 	goto sendit;
 
 err_bad_auth:
-	dprintk("svc: authentication failed (%d)\n",
-		be32_to_cpu(rqstp->rq_auth_stat));
 	serv->sv_stats->rpcbadauth++;
 	/* Restore write pointer to location of accept status: */
 	xdr_ressize_check(rqstp, reply_statp);

