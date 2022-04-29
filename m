Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53A67514E6E
	for <lists+linux-nfs@lfdr.de>; Fri, 29 Apr 2022 16:54:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377983AbiD2O5Z (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 29 Apr 2022 10:57:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377980AbiD2O5Y (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 29 Apr 2022 10:57:24 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2072F7938E
        for <linux-nfs@vger.kernel.org>; Fri, 29 Apr 2022 07:54:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C83F3B835C2
        for <linux-nfs@vger.kernel.org>; Fri, 29 Apr 2022 14:54:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83429C385A7
        for <linux-nfs@vger.kernel.org>; Fri, 29 Apr 2022 14:54:03 +0000 (UTC)
Subject: [PATCH 5/6] NFSD: Clean up the show_nf_flags() macro
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Fri, 29 Apr 2022 10:54:02 -0400
Message-ID: <165124404263.1060.15280510253087331495.stgit@bazille.1015granger.net>
In-Reply-To: <165124376329.1060.17013198516228928515.stgit@bazille.1015granger.net>
References: <165124376329.1060.17013198516228928515.stgit@bazille.1015granger.net>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The flags are defined using C macros, so TRACE_DEFINE_ENUM is
unnecessary.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/trace.h |    6 ------
 1 file changed, 6 deletions(-)

diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
index feb6e6f834b6..a60ead3b227a 100644
--- a/fs/nfsd/trace.h
+++ b/fs/nfsd/trace.h
@@ -692,12 +692,6 @@ DEFINE_CLID_EVENT(confirmed_r);
 /*
  * from fs/nfsd/filecache.h
  */
-TRACE_DEFINE_ENUM(NFSD_FILE_HASHED);
-TRACE_DEFINE_ENUM(NFSD_FILE_PENDING);
-TRACE_DEFINE_ENUM(NFSD_FILE_BREAK_READ);
-TRACE_DEFINE_ENUM(NFSD_FILE_BREAK_WRITE);
-TRACE_DEFINE_ENUM(NFSD_FILE_REFERENCED);
-
 #define show_nf_flags(val)						\
 	__print_flags(val, "|",						\
 		{ 1 << NFSD_FILE_HASHED,	"HASHED" },		\


