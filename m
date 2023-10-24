Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A071B7D4742
	for <lists+linux-nfs@lfdr.de>; Tue, 24 Oct 2023 08:19:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232572AbjJXGS6 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 24 Oct 2023 02:18:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232470AbjJXGS5 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 24 Oct 2023 02:18:57 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB3B8C0;
        Mon, 23 Oct 2023 23:18:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Type:MIME-Version:
        Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=X1BeEIUyP17Oc9/0An+VaavshAKOs04P4D2EreDhKvc=; b=CORXTW5x4gbqjM5cBxVaG0J30z
        3I20kBgT+earPcSSpcv9EBDHv4PCVBDJl1ORE3v/5qtO1bOqiyaoiiX+SW0JI6KwvE7IWacrucQSz
        Ujstk3J7ZB7jIUb/bt8g/0P5EqsbA+Tw63X/madTNBecf0c8bkAJ1Z75sZ/y/3bSqAr7cNnh29cnD
        R7ZX7VhM0D1yNobnGpGlUR3t1tKcAfLPhSOoLy0LrPMPGuWJIveGFDLdFl40VIfAjh7QIO9JXkwHJ
        gf5jm3srib3kfacHoFcrTttv6smsKSAxrdIJSQE4Qt7QahYnyRapUqResrQSSrsV6L8H2FFXZNoDO
        jQT/2V0Q==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qvAkf-004nKI-25;
        Tue, 24 Oct 2023 06:18:53 +0000
Date:   Tue, 24 Oct 2023 07:18:53 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-nfs@vger.kernel.org
Subject: [git pull] nfsd fix
Message-ID: <20231024061853.GG800259@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Catch from lock_rename() audit; nfsd_rename() checked that both directories
belonged to the same filesystem, but only after having done lock_rename().
Trivial fix, tested and acked by nfs folks.  Sat in -next for a while...

The following changes since commit 94f6f0550c625fab1f373bb86a6669b45e9748b3:

  Linux 6.6-rc5 (2023-10-08 13:49:43 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-nfsd-fix

for you to fetch changes up to 1aee9158bc978f91701c5992e395efbc6da2de3c:

  nfsd: lock_rename() needs both directories to live on the same fs (2023-10-17 00:24:35 -0400)

----------------------------------------------------------------
fix for lock_rename() misuse in nfsd

----------------------------------------------------------------
Al Viro (1):
      nfsd: lock_rename() needs both directories to live on the same fs

 fs/nfsd/vfs.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)
