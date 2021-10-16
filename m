Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40B3C430573
	for <lists+linux-nfs@lfdr.de>; Sun, 17 Oct 2021 00:46:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237248AbhJPWtB (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 16 Oct 2021 18:49:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:53290 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235339AbhJPWtA (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Sat, 16 Oct 2021 18:49:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F17A861184;
        Sat, 16 Oct 2021 22:46:51 +0000 (UTC)
From:   Chuck Lever <chuck.lever@oracle.com>
To:     bfields@redhat.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v1 05/14] SUNRPC: Remove dprintk call site from __svc_create()
Date:   Sat, 16 Oct 2021 18:46:51 -0400
Message-Id:  <163442441084.1001.10088717913950127839.stgit@bazille.1015granger.net>
X-Mailer: git-send-email 2.33.0.113.g6c40894d24
In-Reply-To:  <163442364683.1001.4500967510037013459.stgit@bazille.1015granger.net>
References:  <163442364683.1001.4500967510037013459.stgit@bazille.1015granger.net>
User-Agent: StGit/1.1+62.ged16
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=688; h=from:subject:message-id; bh=xpqdmf6TarONifaliLkbknCM7Xrw91J3ukUxJPSohHc=; b=owEBbAKT/ZANAwAIATNqszNvZn+XAcsmYgBha1ZaSXOelGNf8f95bg12etMyjDzazvf0nYVMs8Ks HXrMDO6JAjIEAAEIAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCYWtWWgAKCRAzarMzb2Z/l5v9D/ YiHl1SQcaXL1hv3k4TsHpzT9E0qxhA3j8U4hCwpukJBHfjl/mMfo3Zve+T8aWMopjpD2kIvgn0dU2p OBk97LPeAwUJsMry/qM1sR3COBKpoqJV/2Yu+uSxkjV+vErNj6jl5IEj51RDxxFI6Dc1cd04NRUYW7 hGBCcd2xNw+lSIHGTjOkMTtQuRxyzbH/H8tIA7db0rLvwF/Rp58rDhdR4aNckU8rQ5bRVpAnA/TfMm Tgp308IxI5f0GbJK3/rrI3Gv49LKGXORzAuLxmTbfmXRkU+O72Vvky3mOS6Q/woMalu1MeMDmhAk7K E0jDkx7cz52a/egCV6fSHLf/4URzf6ZeLnPkpg2FquckPPIRY3TaLwFPMLIdhHP2LwsnsPcLJc4kRT swEZMuLEUmUFaGIdPBLEgZAmOdEZggSca824SrZYMNJdlWZG6IZ3/cW/lw275oS+zpX22oVnhYJDKj dRXZn7sCxuVY5nxI5lca+Gs2o2O3pKIwHp3Kje19tbPR3G80LHjHd78ILKbKYwh7VBdmLaeIajxJ9+ 00H3+KtHyadcX3oPdX8NpIXiptLwkYZk0m+YeCc6Vj8IgcoQK0p+mS1K4saGK1OULo6huTbi6Q8X+M 2ZLgAZB2D5tI5sLe34Q9p+tr5Ci2G9+YXDiAW6TWT2m0vZYODB7MGFe5G1
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp; fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Deprecation. This appears to be a low-value dprintk.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/svc.c |    3 ---
 1 file changed, 3 deletions(-)

diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
index f7d8401d97ac..8ca60bfaa073 100644
--- a/net/sunrpc/svc.c
+++ b/net/sunrpc/svc.c
@@ -475,9 +475,6 @@ __svc_create(struct svc_program *prog, unsigned int bufsize, int npools,
 	for (i = 0; i < serv->sv_nrpools; i++) {
 		struct svc_pool *pool = &serv->sv_pools[i];
 
-		dprintk("svc: initialising pool %u for %s\n",
-				i, serv->sv_name);
-
 		pool->sp_id = i;
 		INIT_LIST_HEAD(&pool->sp_sockets);
 		INIT_LIST_HEAD(&pool->sp_all_threads);

