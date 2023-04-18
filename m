Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFD746E5D7D
	for <lists+linux-nfs@lfdr.de>; Tue, 18 Apr 2023 11:34:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231247AbjDRJeb (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 18 Apr 2023 05:34:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231384AbjDRJeX (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 18 Apr 2023 05:34:23 -0400
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2F2E1BCA
        for <linux-nfs@vger.kernel.org>; Tue, 18 Apr 2023 02:34:21 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 960B964548A2;
        Tue, 18 Apr 2023 11:34:14 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id WqJz7wN4xyni; Tue, 18 Apr 2023 11:34:14 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 3094564548AF;
        Tue, 18 Apr 2023 11:34:14 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id oiLpZsNiUCZH; Tue, 18 Apr 2023 11:34:14 +0200 (CEST)
Received: from blindfold.corp.sigma-star.at (unknown [82.150.214.1])
        by lithops.sigma-star.at (Postfix) with ESMTPSA id A2CDA6431C51;
        Tue, 18 Apr 2023 11:34:13 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     linux-nfs@vger.kernel.org
Cc:     david@sigma-star.at, david.oberhollenzer@sigma-star.at,
        luis.turcitu@appsbroker.com, david.young@appsbroker.com,
        trond.myklebust@hammerspace.com, anna.schumaker@netapp.com,
        steved@redhat.com, chris.chilvers@appsbroker.com,
        Richard Weinberger <richard@nod.at>
Subject: [PATCH 5/8] exports.man: Document reexport= option
Date:   Tue, 18 Apr 2023 11:33:47 +0200
Message-Id: <20230418093350.4550-6-richard@nod.at>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20230418093350.4550-1-richard@nod.at>
References: <20230418093350.4550-1-richard@nod.at>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 utils/exportfs/exports.man | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/utils/exportfs/exports.man b/utils/exportfs/exports.man
index 83dd6807..b7582776 100644
--- a/utils/exportfs/exports.man
+++ b/utils/exportfs/exports.man
@@ -468,6 +468,37 @@ will only work if all clients use a consistent secur=
ity policy.  Note
 that early kernels did not support this export option, and instead
 enabled security labels by default.
=20
+.TP
+.IR reexport=3D auto-fsidnum|predefined-fsidnum
+This option helps when a NFS share is re-exported. Since the NFS server
+needs a unique identifier for each exported filesystem and a NFS share
+cannot provide such, usually a manual fsid is needed.
+As soon
+.IR crossmnt
+is used manually assigning fsid won't work anymore. This is where this
+option becomes handy. It will automatically assign a numerical fsid
+to exported NFS shares. The fsid and path relations are stored in a SQLi=
te
+database. If
+.IR auto-fsidnum
+is selected, the fsid is also autmatically allocated.
+.IR predefined-fsidnum
+assumes pre-allocated fsid numbers and will just look them up.
+This option depends also on the kernel, you will need at least kernel ve=
rsion
+5.19.
+Since
+.IR reexport=3D
+can automatically allocate and assign numerical fsids, it is no longer p=
ossible
+to have numerical fsids in other exports as soon this option is used in =
at least
+one export entry.
+
+The association between fsid numbers and paths is stored in a SQLite dat=
abase.
+Don't edit or remove the database unless you know exactly what you're do=
ing.
+.IR predefined-fsidnum
+is useful when you have used
+.IR auto-fsidnum
+before and don't want further entries stored.
+
+
 .SS User ID Mapping
 .PP
 .B nfsd
--=20
2.31.1

