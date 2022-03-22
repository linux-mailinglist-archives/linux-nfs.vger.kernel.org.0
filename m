Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B01064E47FE
	for <lists+linux-nfs@lfdr.de>; Tue, 22 Mar 2022 22:00:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230204AbiCVVCW (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 22 Mar 2022 17:02:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235087AbiCVVCS (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 22 Mar 2022 17:02:18 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28A794C40A
        for <linux-nfs@vger.kernel.org>; Tue, 22 Mar 2022 14:00:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BC96AB81DAA
        for <linux-nfs@vger.kernel.org>; Tue, 22 Mar 2022 21:00:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B6A5C340EC
        for <linux-nfs@vger.kernel.org>; Tue, 22 Mar 2022 21:00:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647982847;
        bh=wBRzPra9km6xMO1tlBTlUaBG4W56cAP7LMraUQp3gSE=;
        h=From:To:Subject:Date:From;
        b=qrMdeTMkiNI/BnhOUjUcAMuleGcm64v73mxcP+g8YOGq/DsbjWqAzbqAktF1DCft2
         kCrVnQ6loRM/bkwUaPTBIZKc9X3EwAT/W7r9LtOmwLi3b7Odzt1haGR3IbmZPc4wxd
         Gy0HIBU0g0WU2Jyo0wA1Yr34bh37N2sVqrOqfXSNhaTCN1wKZfsxby87pUA1Ne43HY
         NfCwOvGn/jfjKjocWVYBB71aFsRGopeasaCqoC2v9ExOvY+o9u/JX8+fgNGGtAW2xW
         zNVvgxSALq4WAjr8IzNZL3Fcyd7uT6QTayAd+/oy6UoWOccuvbJ1ZX46mWzbPexnI+
         d1T1m45gBKehg==
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 0/2] Readdir fixes
Date:   Tue, 22 Mar 2022 16:54:19 -0400
Message-Id: <20220322205421.726627-1-trondmy@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

Two fixes that apply on top of the linux-next branch. The first one
fixes a potential deadlock due to hash collisions. The second fixes a
validation issue.

Trond Myklebust (2):
  NFS: Don't deadlock when cookie hashes collide
  NFS: Fix revalidation of empty readdir pages

 fs/nfs/dir.c | 38 +++++++++++++++++++++++++-------------
 1 file changed, 25 insertions(+), 13 deletions(-)

-- 
2.35.1

