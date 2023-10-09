Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D31C7BE944
	for <lists+linux-nfs@lfdr.de>; Mon,  9 Oct 2023 20:29:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376281AbjJIS3k (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 9 Oct 2023 14:29:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377192AbjJIS3j (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 9 Oct 2023 14:29:39 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83784AF
        for <linux-nfs@vger.kernel.org>; Mon,  9 Oct 2023 11:29:38 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE737C433C7;
        Mon,  9 Oct 2023 18:29:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696876178;
        bh=2W/TZUoEX0Nkof+Svi68y8wQS4wcmXHgd6fSYo1wF10=;
        h=Subject:From:To:Cc:Date:From;
        b=Ouz1n41RGg88CAfoIAOnI15RaE1fEs7j7KtBwLXZysBl9bs8Ako3UKprbnHYxMi5A
         8uZEoaDELEK8xRSaeRWo+tuMie+f7mw1WHTsXNFhQHgPAGxa+aeoI8qpuBlv7hlAqk
         ctb1/mlDKjvHZrfQEXtWc707leeqAi7wlE8UFOhqcIVMgOeOx4uH8FPQwb/KdEogvX
         cGj8yAKUZ6XqgmeubCK4UI7wSIVTdHQ9t/PnrIi+1+92AcgaqL/U3+1Rt8cUXOX61w
         Yt+epN1AlRn/dBMNrzC/YqfNzxF65Hw8CxFS/Vx5vwL+F4/Bh8N5kM1OTRA1iECInr
         RP9XCMweFaETQ==
Subject: [PATCH v1 0/8] Clean up miscellaneous NFSv4 XDR encoders
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Cc:     Chuck Lever <chuck.lever@oracle.com>
Date:   Mon, 09 Oct 2023 14:29:36 -0400
Message-ID: <169687606447.41382.568611605570999245.stgit@oracle-102.nfsv4bat.org>
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

Tidy up the server-side XDR result encoders for remaining
miscellanous NFSv4 operations. Series applies to nfsd-next. See
topic branch "nfsd4-encoder-overhaul" in this repo:

https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git

---

Chuck Lever (8):
      NFSD: Clean up nfsd4_encode_access()
      NFSD: Clean up nfsd4_do_encode_secinfo()
      NFSD: Clean up nfsd4_encode_exchange_id()
      NFSD: Clean up nfsd4_encode_test_stateid()
      NFSD: Clean up nfsd4_encode_copy()
      NFSD: Clean up nfsd4_encode_copy_notify()
      NFSD: Clean up nfsd4_encode_offset_status()
      NFSD: Clean up nfsd4_encode_seek()


 fs/nfsd/nfs4proc.c |   4 +-
 fs/nfsd/nfs4xdr.c  | 419 ++++++++++++++++++++++++---------------------
 fs/nfsd/xdr4.h     |   4 +-
 3 files changed, 225 insertions(+), 202 deletions(-)

--
Chuck Lever

