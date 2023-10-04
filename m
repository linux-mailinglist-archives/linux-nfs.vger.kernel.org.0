Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A478F7B8129
	for <lists+linux-nfs@lfdr.de>; Wed,  4 Oct 2023 15:41:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233183AbjJDNlo (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 4 Oct 2023 09:41:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233066AbjJDNlo (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 4 Oct 2023 09:41:44 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAE189B
        for <linux-nfs@vger.kernel.org>; Wed,  4 Oct 2023 06:41:39 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5751FC433C8;
        Wed,  4 Oct 2023 13:41:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696426899;
        bh=XMsyQX/8tWuhjl7HpCKp6GnBkM1FKgkEPIsk60F3YzQ=;
        h=Subject:From:To:Cc:Date:From;
        b=pTIbVjB/a4t5JFH1LUWh+oKHPh9DOxYkRrWX/m2wMnDQ7LPYxF4vxt2wmz/zr3YeK
         chs4oM+T9EKk+ddWrtMtzuNduUxaYaOsZ5Tzeznvo1tbP28yLwu7coA74QcCZ2VilB
         7RXtRiigv4KfsKkLbK1Mf1DMYXM8zPDTu5DHdcWf05o60Ju29SLAk9FRX3gBT/O2Wn
         eyf5IlEa2uPAR+RH4fIh1yAnMGKZD79Fi9pdz+rOF551DfLN81ivAx0g7rNfpr+wC3
         2LErZdZwrXcFwvi3Ddj+mq9+unybknL3VPQ9GqfR6OGzeaWaWzAYiyRxhwH9XzmDxt
         d5zjrxZtCadVg==
Subject: [PATCH v1 0/5] Clean up XDR encoders for NFSv4 READDIR
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Cc:     Chuck Lever <chuck.lever@oracle.com>
Date:   Wed, 04 Oct 2023 09:41:38 -0400
Message-ID: <169642681764.7503.2925922561588558142.stgit@klimt.1015granger.net>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Tidy up the server-side XDR encoders for READDIR results and
directory entries. Series applies to nfsd-next. See topic branch
"nfsd4-encoder-overhaul" in this repo:

https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git

---

Chuck Lever (5):
      NFSD: Rename nfsd4_encode_dirent()
      NFSD: Clean up nfsd4_encode_rdattr_error()
      NFSD: Add an nfsd4_encode_nfs_cookie4() helper
      NFSD: Clean up nfsd4_encode_entry4()
      NFSD: Clean up nfsd4_encode_readdir()


 fs/nfsd/nfs4xdr.c | 200 +++++++++++++++++++++++-----------------------
 fs/nfsd/xdr4.h    |   3 +
 2 files changed, 104 insertions(+), 99 deletions(-)

--
Chuck Lever

