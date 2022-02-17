Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B01C4BACC3
	for <lists+linux-nfs@lfdr.de>; Thu, 17 Feb 2022 23:39:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238033AbiBQWjs (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 17 Feb 2022 17:39:48 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343922AbiBQWjr (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 17 Feb 2022 17:39:47 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7651169223
        for <linux-nfs@vger.kernel.org>; Thu, 17 Feb 2022 14:39:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 231FCCE30B7
        for <linux-nfs@vger.kernel.org>; Thu, 17 Feb 2022 22:39:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C9DCC340E8
        for <linux-nfs@vger.kernel.org>; Thu, 17 Feb 2022 22:39:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645137569;
        bh=tluS2rb1XiGRzaXLn7227m0+fFMcuHkbuh+VTqqGE68=;
        h=From:To:Subject:Date:From;
        b=vOCTu626yGkBwCTsiHEKEAS2pxq80NoaTQdFz5I59zk9f+PfARjET3Hcg9M9oPt/s
         eMKEL86ZVyywKgBE0y3j3FTu7TUZF9pBdXlnuxps8D3HLua+8TR0KBFul9r+wG1Wtd
         xkblOwFQWl3CX2ICdrewFgmvK+5LW0L+UmCsnH/GHBgffChJgpo/uN8uZB9nELDjo8
         xZNGqYm8X6iDaO49Z/sma3h7fiAydUF6KS9WaImnjCN2wBBI7oB0KTmfbRfeRgUBkD
         fPLeLgF/Nvxq0blNA8ZX5uNihvj9GncaWr3m/G63hBoPNUEyOyAZoZB0W9T0MVIAjr
         c+TGUCPeRPaaQ==
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH v4 0/5] Readdir improvements
Date:   Thu, 17 Feb 2022 17:33:18 -0500
Message-Id: <20220217223323.696173-1-trondmy@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

The current NFS readdir code will always try to maximise the amount of
readahead it performs on the assumption that we can cache anything that
isn't immediately read by the process.
There are several cases where this assumption breaks down, including
when the 'ls -l' heuristic kicks in to try to force use of readdirplus
as a batch replacement for lookup/getattr.

--
v2: Remove reset of dtsize when NFS_INO_FORCE_READDIR is set
v3: Avoid excessive window shrinking in uncached_readdir case
v4: Track 'ls -l' cache hit/miss statistics
    Improved algorithm for falling back to uncached readdir
    Skip readdirplus when files are being written to

Trond Myklebust (5):
  NFS: Adjust the amount of readahead performed by NFS readdir
  NFS: Simplify nfs_readdir_xdr_to_array()
  NFS: Improve algorithm for falling back to uncached readdir
  NFS: Improve heuristic for readdirplus
  NFS: Don't ask for readdirplus if files are being written to

 fs/nfs/dir.c           | 210 ++++++++++++++++++++++++++---------------
 fs/nfs/inode.c         |  17 ++--
 fs/nfs/internal.h      |   4 +-
 fs/nfs/nfstrace.h      |   1 -
 include/linux/nfs_fs.h |   7 +-
 5 files changed, 153 insertions(+), 86 deletions(-)

-- 
2.35.1

