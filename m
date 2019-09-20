Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B5BEB8888
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Sep 2019 02:22:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390329AbfITAWm (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 19 Sep 2019 20:22:42 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:33233 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390178AbfITAWm (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 19 Sep 2019 20:22:42 -0400
Received: by mail-io1-f65.google.com with SMTP id m11so12253437ioo.0;
        Thu, 19 Sep 2019 17:22:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=ix8+8PqWk+bszyMequ0IxNEn2cRf7X1LNLzbQO5hJo4=;
        b=gurInQH2B4KY12DNj9lcFFeLvCpBqLxJoud6HXK3Rj9HY2SbYEqDXEZClGMN8TEq+E
         mnjILhOcTSBSZthvriw44CDhpNFoyKCiIjQPyhJhqYZfAPf55FhqAfEUQebOitvbQDWL
         SN+2WBo6w47DTiGtKuN9dlmByarSuTghivQbqtICfOSCxtViQghnvN4jqz/RjiUwy43R
         CrQm7Vw/xxAKwVfJtKliNSdjp+/PkjHJ9B8O9+YXnBdYhdgMFdIg1UqLU7sGpkYGWKNu
         geJrhJM2W9iarTAU4B+nEcVV5f6bsr7Hlqd/1eR5786SsfQ9JokbltoMVfAx8IWzU3SE
         DcDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ix8+8PqWk+bszyMequ0IxNEn2cRf7X1LNLzbQO5hJo4=;
        b=dqanhWDHi6W4hK69riTbOfb5Qg7KC/6j9FrtCj81m7OUiAyzCXrgMrtRZNBeqrSFNG
         k3Q48IaqvaxCHb/p58Wg5v5EloYNUQ4GyqetKO7cbLOhmoDZE603vdcpiz+D/pBgDgl6
         VkuCWyqXOOtSuYlLgBUPv0zef64EKx50MD4dGWkRdejk+1DjGEZ90FcdjsN+bupIZDuU
         OEdMLxi3svCH77ZlDJY3vd2N7iSrpk5aAI35nh9BqbkNiDq6Qi53gFiE9f5GHT1+uQhn
         rR0YNbusCpMhEjTRXOAUgzJYr7it9rarn6f33QuFWwaECRPcfo6hLqNg7hOTzeeWljqE
         chwA==
X-Gm-Message-State: APjAAAVHt0Rr7ae6HPpyC6DGVUuyDbCZoTYPFi9gBRmqlrr9pL0lrUIV
        Eu/0PMupvC98S3sbSxjkcWs=
X-Google-Smtp-Source: APXvYqyW7ouuT933iTp+UETyFMPoSGZoiNKIG3UGPHONqZxhqdYc4m2YPkaQWTxriKp9zm/8pE7isA==
X-Received: by 2002:a05:6602:2543:: with SMTP id j3mr7504138ioe.29.1568938961424;
        Thu, 19 Sep 2019 17:22:41 -0700 (PDT)
Received: from cs-dulles.cs.umn.edu (cs-dulles.cs.umn.edu. [128.101.35.54])
        by smtp.googlemail.com with ESMTPSA id r138sm658005iod.59.2019.09.19.17.22.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Sep 2019 17:22:40 -0700 (PDT)
From:   Navid Emamdoost <navid.emamdoost@gmail.com>
Cc:     emamd001@umn.edu, smccaman@umn.edu, kjlu@umn.edu,
        Navid Emamdoost <navid.emamdoost@gmail.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] NFSv4: fix memory leak if nfs4_begin_drain_session fails
Date:   Thu, 19 Sep 2019 19:22:30 -0500
Message-Id: <20190920002232.27477-1-navid.emamdoost@gmail.com>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

In nfs4_try_migration, if nfs4_begin_drain_session fails the allocated
memory should be released.

Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
---
 fs/nfs/nfs4state.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfs/nfs4state.c b/fs/nfs/nfs4state.c
index cad4e064b328..124649f12067 100644
--- a/fs/nfs/nfs4state.c
+++ b/fs/nfs/nfs4state.c
@@ -2096,7 +2096,7 @@ static int nfs4_try_migration(struct nfs_server *server, const struct cred *cred
 
 	status = nfs4_begin_drain_session(clp);
 	if (status != 0)
-		return status;
+		goto out;
 
 	status = nfs4_replace_transport(server, locations);
 	if (status != 0) {
-- 
2.17.1

