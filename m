Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B35A36B75E5
	for <lists+linux-nfs@lfdr.de>; Mon, 13 Mar 2023 12:24:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229877AbjCMLYH (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 13 Mar 2023 07:24:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229795AbjCMLYG (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 13 Mar 2023 07:24:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E94A23C51
        for <linux-nfs@vger.kernel.org>; Mon, 13 Mar 2023 04:24:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CF39261044
        for <linux-nfs@vger.kernel.org>; Mon, 13 Mar 2023 11:24:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7FB2C433D2;
        Mon, 13 Mar 2023 11:24:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678706644;
        bh=UalLtbEUXRlAxkm63nC35oHQ+IYrk9ag7KeY+8BixDg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QmlnyXyLE2IYbcu6IUv+gltldLYlWy0k+MFbCPDUdPyEENMOipbZBTJz2lOZDSA+T
         +iKrybNu1xVb8m+uxoSlCBLeKksEwa3l4HHsAcPX+7UikG632MEm69S2668gse/cAY
         QwLYSDO+vfUV8OX6J1wo9VgoCZO1r05C4Jhwmh5U69K5Y4HCYN4lDEBPRtNPLGmtRi
         RVC+EZu+srxAgsXSEhmTIlHKepoGeL/x9xP8sZetjdjZ2jh1xGJIbChunmSKK/7wNZ
         Cs1zvcUHa3baRe+lAK+us59LfqmYM8geelUMpKKaXDlpUwa/VFpk+oMn4GYLj97xNd
         hRZ2U1+XXXkZQ==
From:   Jeff Layton <jlayton@kernel.org>
To:     calum.mackay@oracle.com
Cc:     bfields@fieldses.org, ffilzlnx@mindspring.com,
        linux-nfs@vger.kernel.org, Dai Ngo <dai.ngo@oracle.com>
Subject: [pynfs PATCH v2 1/5] nfs4.0: add a retry loop on NFS4ERR_DELAY to compound function
Date:   Mon, 13 Mar 2023 07:23:57 -0400
Message-Id: <20230313112401.20488-2-jlayton@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230313112401.20488-1-jlayton@kernel.org>
References: <20230313112401.20488-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The latest knfsd server is "courteous" in that it will not revoke a
lease held by an expired client until there is competing access for it.
When there is competing access, it can now return NFS4ERR_DELAY until
the old client is expired. I've seen this happen when running pynfs in
a loop against a server with only 4g of memory.

The v4.0 compound handler doesn't retry automatically on NFS4ERR_DELAY
like the v4.1 version does. Add support for it using the same timeouts
as the v4.1 compound handler.

Cc: Dai Ngo <dai.ngo@oracle.com>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 nfs4.0/nfs4lib.py | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/nfs4.0/nfs4lib.py b/nfs4.0/nfs4lib.py
index 9b074f02b91f..eddcd862bc2f 100644
--- a/nfs4.0/nfs4lib.py
+++ b/nfs4.0/nfs4lib.py
@@ -338,12 +338,21 @@ class NFS4Client(rpc.RPCClient):
         un_p = self.nfs4unpacker
         p.reset()
         p.pack_COMPOUND4args(compoundargs)
-        res = self.call(NFSPROC4_COMPOUND, p.get_buffer())
-        un_p.reset(res)
-        res = un_p.unpack_COMPOUND4res()
-        if SHOW_TRAFFIC:
-            print(res)
-        un_p.done()
+        res = None
+
+        # NFS servers can return NFS4ERR_DELAY at any time for any reason.
+        # Just delay a second and retry the call again in that event. If
+        # it fails after 10 retries then just give up.
+        for i in range(1, 10):
+            res = self.call(NFSPROC4_COMPOUND, p.get_buffer())
+            un_p.reset(res)
+            res = un_p.unpack_COMPOUND4res()
+            if SHOW_TRAFFIC:
+                print(res)
+            un_p.done()
+            if res.status != NFS4ERR_DELAY:
+                break
+            time.sleep(1)
 
         # Do some error checking
 
-- 
2.39.2

