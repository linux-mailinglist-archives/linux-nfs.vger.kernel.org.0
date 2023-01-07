Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A4C5661096
	for <lists+linux-nfs@lfdr.de>; Sat,  7 Jan 2023 18:42:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232422AbjAGRmL (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 7 Jan 2023 12:42:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232156AbjAGRmK (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 7 Jan 2023 12:42:10 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4210B240
        for <linux-nfs@vger.kernel.org>; Sat,  7 Jan 2023 09:42:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 94CAD60B8C
        for <linux-nfs@vger.kernel.org>; Sat,  7 Jan 2023 17:42:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3E6EC433D2
        for <linux-nfs@vger.kernel.org>; Sat,  7 Jan 2023 17:42:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673113328;
        bh=EzSUmHPV0LS68WNrtNR1zMjdiuWsl5OOzjPLx81V0Ps=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=lPdFfycDS+z6w36naE7TZdgqlXWWgfSa5DMWJLTWqkefmDdw+daWlM9OcgjC9HZs+
         /HBPAqmSyPIjCkMrB+Am/xkJuQbUGDj9GLFn578zXBq6oo4uDKx2VUsKlfFFDuVpNo
         O5Jksoxo3nxTn5ltyn4XQYwexqawymxtoftaVsEtgMpOEFu6X2bglwvkGp4GjAjWEC
         l7B7aKesYSHBc3lhq99KypbjVYBEhtIxyozOvprSR109sHVQ07DJyv0jlPyf9N3zmY
         vhkVAH6WdV7Z+wzL7daQmk7VVpHdI+15uB5SbyyafV3plAXGe0aSKILYKPVFkC0zfD
         OC/XHClQO/rkQ==
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 01/17] NFS: Fix for xfstests generic/208
Date:   Sat,  7 Jan 2023 12:36:19 -0500
Message-Id: <20230107173635.2025233-2-trondmy@kernel.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230107173635.2025233-1-trondmy@kernel.org>
References: <20230107173635.2025233-1-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

If the same page and data is being used for multiple requests,
then ignore that when the request indicates we're reading from the start
of the page.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/pagelist.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/nfs/pagelist.c b/fs/nfs/pagelist.c
index 317cedfa52bf..b4b3e80e64cd 100644
--- a/fs/nfs/pagelist.c
+++ b/fs/nfs/pagelist.c
@@ -920,6 +920,9 @@ int nfs_generic_pgio(struct nfs_pageio_descriptor *desc,
 		req = nfs_list_entry(head->next);
 		nfs_list_move_request(req, &hdr->pages);
 
+		if (req->wb_pgbase == 0)
+			last_page = NULL;
+
 		if (!last_page || last_page != req->wb_page) {
 			pageused++;
 			if (pageused > pagecount)
-- 
2.39.0

