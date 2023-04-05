Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 604766D8926
	for <lists+linux-nfs@lfdr.de>; Wed,  5 Apr 2023 22:59:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229541AbjDEU7W (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 5 Apr 2023 16:59:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjDEU7V (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 5 Apr 2023 16:59:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3081D46B0
        for <linux-nfs@vger.kernel.org>; Wed,  5 Apr 2023 13:59:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BEECA62810
        for <linux-nfs@vger.kernel.org>; Wed,  5 Apr 2023 20:59:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C49BCC433EF;
        Wed,  5 Apr 2023 20:59:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680728360;
        bh=hOFLN4Jka1h3g/ABDejYruRfQ/KGXWvzOK4t7ugUKng=;
        h=From:To:Cc:Subject:Date:From;
        b=PwoTmzrLgt6szECUA2QXCUDts1HFHvVYdyeiZxknSd9GKPVYtuKXGcPthDyGXcDjE
         ai1Za8IQxDk/PTHnXFnbfnWL30iVJIvGCM0xqjxthNL3d8/9v0CLSdYsgjNjnz2Agn
         XLHJYTfGuW6VRK1PcmmjdNdT46tv0Ap4nRdDuPAxaNz+FRH7tZr4v+++HvEQBl1Vmy
         NhcNRRpk9FWTpThjVfmwLx0qLrd4D7v7Lea70CCL0jv25ot+146EKS4OmyrzmcS6QH
         qBevvgOojKoJpgjpK621nm0Nv9XkGoJin25fTT4sEF8twRXbCt8sDv9YXPLbB3Xb1J
         hG1VPIOCTeBkA==
From:   Anna Schumaker <anna@kernel.org>
To:     linux-nfs@vger.kernel.org, trond.myklebust@hammerspace.com
Cc:     anna@kernel.org
Subject: [PATCH 0/2] NFS: Convert readdir to use folios
Date:   Wed,  5 Apr 2023 16:59:16 -0400
Message-Id: <20230405205918.228394-1-anna@kernel.org>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Anna Schumaker <Anna.Schumaker@Netapp.com>

This is a 1-1 update of the readdir code to folios instead of pages
during decode. One thing I'm still thinking about is converting the
array-of-folios into a single compound-page folio, but this would
involve a larger rewrite due to how the current code is structured
around grabbing cache pages as needed (and as far as I know, the
pagecache is still oriented around single pages, not compound pages).

Thoughts?
Anna

Anna Schumaker (2):
  NFS: Convert the readdir array-of-pages into an array-of-folios
  NFS: Convert readdir page array functions to use a folio

 fs/nfs/dir.c | 300 +++++++++++++++++++++++++--------------------------
 1 file changed, 149 insertions(+), 151 deletions(-)

-- 
2.40.0

