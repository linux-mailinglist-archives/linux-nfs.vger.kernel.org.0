Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A226763DCF2
	for <lists+linux-nfs@lfdr.de>; Wed, 30 Nov 2022 19:18:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230156AbiK3SSc (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 30 Nov 2022 13:18:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230173AbiK3SSL (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 30 Nov 2022 13:18:11 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C35A18B184
        for <linux-nfs@vger.kernel.org>; Wed, 30 Nov 2022 10:15:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6D2D6B81C9D
        for <linux-nfs@vger.kernel.org>; Wed, 30 Nov 2022 18:15:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABBAFC433D6;
        Wed, 30 Nov 2022 18:15:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669832129;
        bh=8jF1vgKRCb+QRwGb6evUrsz3ZuHKcMT1cygCoD2VWS4=;
        h=From:To:Cc:Subject:Date:From;
        b=TD4orS8+j3ZaO+6iiGXeG39DjgT6NZnBIFCoUw8Wtntd3hk9FY520qQQuAc5El7Nb
         gqZQDs6QzMb2Q0mN4zN0rhGssFy+eY3l4JZWrEwlMp49cy5rPKtbTpF4sm+F2aDBJc
         HmzqRwYpKwf43mSyQQbSuIcY+PGXw6pR+YlY0q3X0z8RwMQ6LiA1+A6GAHsmuT8yD1
         Q0xPT3Fx50Gj/6LByeOYH9WfztRUAUx7VJfK+XagftfKjcnR6bjaVavfz1R1BfAUUZ
         H0KI3P88qKBBBij7t0ealK+vrfD1kegLO0BYRggAWI3FkokBmJ/xusz3+FWLqeld+Y
         hi3mc8i86C8iA==
From:   Anna Schumaker <anna@kernel.org>
To:     linux-nfs@vger.kernel.org, trond.myklebust@hammerspace.com
Cc:     anna@kernel.org
Subject: [PATCH 1/3] NFSv4.2: Set the correct size scratch buffer for decoding READ_PLUS
Date:   Wed, 30 Nov 2022 13:15:25 -0500
Message-Id: <20221130181527.766485-1-anna@kernel.org>
X-Mailer: git-send-email 2.38.1
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

From: Anna Schumaker <Anna.Schumaker@Netapp.com>

The scratch_buf array is 16 bytes, but I was passing 32 to the
xdr_set_scratch_buffer() function. Fix this by using sizeof(), which is
what I probably should have been doing this whole time.

Fixes: d3b00a802c84 ("NFS: Replace the READ_PLUS decoding code")
Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
---
 fs/nfs/nfs42xdr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfs/nfs42xdr.c b/fs/nfs/nfs42xdr.c
index fe1aeb0f048f..2fd465cab631 100644
--- a/fs/nfs/nfs42xdr.c
+++ b/fs/nfs/nfs42xdr.c
@@ -1142,7 +1142,7 @@ static int decode_read_plus(struct xdr_stream *xdr, struct nfs_pgio_res *res)
 	if (!segs)
 		return -ENOMEM;
 
-	xdr_set_scratch_buffer(xdr, &scratch_buf, 32);
+	xdr_set_scratch_buffer(xdr, &scratch_buf, sizeof(scratch_buf));
 	status = -EIO;
 	for (i = 0; i < segments; i++) {
 		status = decode_read_plus_segment(xdr, &segs[i]);
-- 
2.38.1

