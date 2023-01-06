Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6C0B660375
	for <lists+linux-nfs@lfdr.de>; Fri,  6 Jan 2023 16:39:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235241AbjAFPjP (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 6 Jan 2023 10:39:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235844AbjAFPjI (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 6 Jan 2023 10:39:08 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C23D7F460
        for <linux-nfs@vger.kernel.org>; Fri,  6 Jan 2023 07:39:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 35C14B81DC2
        for <linux-nfs@vger.kernel.org>; Fri,  6 Jan 2023 15:39:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C091C433F0;
        Fri,  6 Jan 2023 15:39:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673019543;
        bh=4BZlXNOFSR+B6EGGY0R3CpgiUDa+lsaE0q/K6mOZtmQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Alj5o+MT3ynpQK21LU0e1mGxyKcKPLk2nM6AXBL1KDd0rAMuFH/9f+XDv+pr2dcVz
         EbQ6LBSmvVlZGGpmKFYgVjC0/E9ueHhjemOh9sAOV47m4yQcEujEZFpi+QJXUVA8oe
         yyCJprR7dLoAC92gUWbCb5jkPXn2n+MzRstepznB7othIOp3HCj/EffEsJWmcCc4OX
         dAuxyZKyOOpcLZv7frtSGraQooqlCaUEzLSYq+nb0KF8xO3D1Y9yBBUphTD4/MFnhI
         ohr9UnBJQ9eff1ZdR4p/utoHmi2+saiwViA0s3YkApUG8pvhjksfWc8qQALPYNiRn1
         //uqT8id6JuQw==
From:   Jeff Layton <jlayton@kernel.org>
To:     chuck.lever@oracle.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v2] nfsd: simplify test_bit return in NFSD_FILE_KEY_FULL comparator
Date:   Fri,  6 Jan 2023 10:39:01 -0500
Message-Id: <20230106153901.105230-2-jlayton@kernel.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230106153901.105230-1-jlayton@kernel.org>
References: <20230106153901.105230-1-jlayton@kernel.org>
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

test_bit returns bool, so we can just compare the result of that to the
key->gc value without the "!!".

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/filecache.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
index 3b52c1888421..2e9576ab9478 100644
--- a/fs/nfsd/filecache.c
+++ b/fs/nfsd/filecache.c
@@ -189,7 +189,7 @@ static int nfsd_file_obj_cmpfn(struct rhashtable_compare_arg *arg,
 			return 1;
 		if (!nfsd_match_cred(nf->nf_cred, key->cred))
 			return 1;
-		if (!!test_bit(NFSD_FILE_GC, &nf->nf_flags) != key->gc)
+		if (test_bit(NFSD_FILE_GC, &nf->nf_flags) != key->gc)
 			return 1;
 		if (test_bit(NFSD_FILE_HASHED, &nf->nf_flags) == 0)
 			return 1;
-- 
2.39.0

