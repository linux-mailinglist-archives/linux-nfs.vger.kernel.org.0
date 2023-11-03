Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 818D87E011A
	for <lists+linux-nfs@lfdr.de>; Fri,  3 Nov 2023 11:31:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347767AbjKCKLB (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 3 Nov 2023 06:11:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347633AbjKCKLA (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 3 Nov 2023 06:11:00 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D13A5D45;
        Fri,  3 Nov 2023 03:10:57 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EBCBC433C9;
        Fri,  3 Nov 2023 10:10:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699006257;
        bh=6vgNTfCui7BrBTIbjiewHjd4liJmt8Js2DbVuOdSPNc=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=Pr/+UMMo3widSwR/E2RhKMvQdy0g+u8eYZ5pDbSleoJNlsVJssQ2eJwK/Vhn36rdf
         kHMyOCMg9D7xRhd9AgblnGewW7Wrljaqnx6aAVftHn3f+RHwH05MTU5OiXsJZ4vOHi
         8em9nMvibEJwHzdUGqaXA5Kw7QtYNU9cGxWk1nUUctQz5/76h94sfWOFHpUlkJ0Ee0
         /znZF583bxlFBeceADWukhQ1V4DS5M/SG9YWKc9++nHx2yrHN2cCNeWeFxjvHkpEuI
         dRSSw3cckINqBQXfsHr2i/i1K0vgOt4et6oYB6rQspNbxT08jAJEVjUHh8gW9SYnBy
         cbHcBsxHGfFdA==
From:   Jeff Layton <jlayton@kernel.org>
Date:   Fri, 03 Nov 2023 06:10:49 -0400
Subject: [PATCH 1/3] nfs: add new tracepoint at nfs4 revalidate entry point
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231103-nfs-6-8-v1-1-a2aa9021dc1d@kernel.org>
References: <20231103-nfs-6-8-v1-0-a2aa9021dc1d@kernel.org>
In-Reply-To: <20231103-nfs-6-8-v1-0-a2aa9021dc1d@kernel.org>
To:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>
Cc:     linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=615; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=6vgNTfCui7BrBTIbjiewHjd4liJmt8Js2DbVuOdSPNc=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBlRMcvWyZSnjgAhr2+BctpREsmfKGQG1+F9up9O
 xNgMC3H1NOJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZUTHLwAKCRAADmhBGVaC
 FfB0EADAJjnkLertPKMP/l4lTa1wgOPY3WVPvWGgVyA04ET9B2EbEp/P7Y6PEjpJCD1vro+ADrR
 dTd0haeO+SLPPeSTFr4Gx0CJ37C+0B3IlcsGF1pheUVTZvYLLfsOat7/8kfn5iCn2svae7NZAP1
 8oWkUef7Q1E5W8rlEzat0A7T+xVg7ozd/pPXu9jjjZFzUXA6uhYr3d7KEc0KqJdfFxTkHd+RCHN
 A98x73L4FITriS5HIUxQ9KXZey0RAFLIcLuBIuI/e59xHz1ZzPTVclSOhmU8Oi8VNulBQtRGzQE
 NHmi0pODpVqQNXU5I2vIORE2xhtGVkzD6WMYM9hqeUJB6yFVCcmK09WTecyKP21WGpdf+/wh8FA
 9JKMl1z81TyoZqHObtP407noFZX4PeF7f4oENY7IP5guobH5C5SoxdlEhuL5aq5ry0yfsN4Hku+
 n3qCfD7oD5onaseNSFYkvLsc56pee9ywbNL2e8sr8us1yQRg6nNInFkv5JaYqWI9S6DqyhnKjza
 mGR7GvTPAwf87fQ2+MENNp6X2bsFBxtEVFwy+7ISTQFk3owjOGHOpTPEH6XmvY4drF8rfaiNjtG
 hPzu3X8gGr4M8jaUFTGfaA49sOBGqjRKu+P5yYqAUeAo/pKBlRRnAdmniesH/cozLGvE9sS31jc
 MkTq8PeC71kdZxQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Add a call to the v4 d_revalidate entrypoint, just like the v3 one.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfs/dir.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index e6a51fd94fea..ccb6f5d85a68 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -2194,6 +2194,8 @@ nfs4_do_lookup_revalidate(struct inode *dir, struct dentry *dentry,
 {
 	struct inode *inode;
 
+	trace_nfs_lookup_revalidate_enter(dir, dentry, flags);
+
 	if (!(flags & LOOKUP_OPEN) || (flags & LOOKUP_DIRECTORY))
 		goto full_reval;
 	if (d_mountpoint(dentry))

-- 
2.41.0

