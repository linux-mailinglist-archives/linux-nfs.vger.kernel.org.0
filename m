Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 567BD7B55B3
	for <lists+linux-nfs@lfdr.de>; Mon,  2 Oct 2023 17:01:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237877AbjJBOvR (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 2 Oct 2023 10:51:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237860AbjJBOvQ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 2 Oct 2023 10:51:16 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AECABD
        for <linux-nfs@vger.kernel.org>; Mon,  2 Oct 2023 07:51:13 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B646C433C8;
        Mon,  2 Oct 2023 14:51:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696258272;
        bh=iy3t2H6hTVFCHJNcNBMzMbebfb78XCObSHIUkdaRgl8=;
        h=Subject:From:To:Cc:Date:From;
        b=FgrdypueB9jre7ICo8fSfPFlBjtoGrvn7RCYZ15JrJnXKkIbzyCYSB6HrCIMJv+za
         Ax66upoaZJK17wZa0fW9/hPjEswTK2zt+lBbBtc2BIOXRA+jzrPGbXQdiicT9n3w5y
         1SUiUdhMKDy2VtyM2t1ab9R2sUFFEcyOM1HvEEJ1m+yyw/lSt3Y0upz8dqjNE2O2kG
         9l/bqvmjkLejZoav5fSd01A1B1S48irrIXpgho7wam5ZZog+ENxPL415UNDcHBgInm
         Rv0VBNrYL4xTeoeMAv0GmFRFTFffGVIwI2TU4B7Vh/VhuLsDAncEfqp03f6Y32IIuC
         phK7wsqqn/BSw==
Subject: [PATCH v1 0/4] Clean up XDR encoders for NFSv4.1 utility operations
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Cc:     Chuck Lever <chuck.lever@oracle.com>
Date:   Mon, 02 Oct 2023 10:51:11 -0400
Message-ID: <169625819958.1640.14102064750083176117.stgit@klimt.1015granger.net>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Tidy up the server-side XDR encoders for CREATE_SESSION and
SEQUENCE results. Series applies to nfsd-next. See topic branch
"nfsd4-encoder-overhaul" in this repo:

https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git

---

Chuck Lever (4):
      NFSD: Add a utility function for encoding sessionid4 objects
      NFSD: Add nfsd4_encode_channel_attr4()
      NFSD: Restructure nfsd4_encode_create_session()
      NFSD: Clean up nfsd4_encode_sequence()


 fs/nfsd/nfs4xdr.c | 163 +++++++++++++++++++++++++++-------------------
 fs/nfsd/xdr4.h    |   2 +
 2 files changed, 99 insertions(+), 66 deletions(-)

--
Chuck Lever

