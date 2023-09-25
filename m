Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF9AC7AD90C
	for <lists+linux-nfs@lfdr.de>; Mon, 25 Sep 2023 15:27:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231160AbjIYN1l (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 25 Sep 2023 09:27:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230260AbjIYN1k (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 25 Sep 2023 09:27:40 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3984510A
        for <linux-nfs@vger.kernel.org>; Mon, 25 Sep 2023 06:27:34 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C060C433C7;
        Mon, 25 Sep 2023 13:27:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695648453;
        bh=bR891B5H/TkKkuMjA9M1E1ueoc1jMi59saEQfL1YZWs=;
        h=Subject:From:To:Cc:Date:From;
        b=ep7NivGTDy+yePWBb8aGjiVSgDoOBaF5lNNWGeFezHsn/kKWAvfc3ABNFyuc5a7xC
         6lC4GrDAW48nnQaOeW7n9/CNaQs1FpYj4fsRIDmnlgmnsEAprrc6xG8tQs7aKP0bDb
         7O1bkZNTme74gInS6ETqXFkanmZNwvbZzJUCGebc51H60IEWr6GA2JszQ4MY5N4E8t
         Bd/jgx5VZ3Uvfy2Nw+/9+w1Q9xb3O8XlwCr98V2db5S15bFkEw2K5qP7uabIsJKNw5
         4I+ykYoHVJB4lnWWjxDYqYWjKCOwoO8mqum27twkM6IyUd/3aXqrY4/rYMPJ1XSLOP
         RKR6VJw9+s1Kg==
Subject: [PATCH v1 0/8] Clean up XDR encoders for pNFS operations
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Cc:     Chuck Lever <chuck.lever@oracle.com>
Date:   Mon, 25 Sep 2023 09:27:32 -0400
Message-ID: <169564827064.6013.5014460767978657478.stgit@klimt.1015granger.net>
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

Tidy up the server-side XDR encoders for pNFS-related operations.
Note that this does not touch the layout driver code; that can be
done later.

Series applies to nfsd-next. See topic branch
"nfsd4-encoder-overhaul" in this repo:

https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git

---

Chuck Lever (8):
      NFSD: Add nfsd4_encode_count4()
      NFSD: Clean up nfsd4_encode_stateid()
      NFSD: Make @lgp parameter of ->encode_layoutget a const pointer
      NFSD: Clean up nfsd4_encode_layoutget()
      NFSD: Clean up nfsd4_encode_layoutcommit()
      NFSD: Clean up nfsd4_encode_layoutreturn()
      NFSD: Make @gdev parameter of ->encode_getdeviceinfo a const pointer
      NFSD: Clean up nfsd4_encode_getdeviceinfo()


 fs/nfsd/blocklayoutxdr.c    |   6 +-
 fs/nfsd/blocklayoutxdr.h    |   4 +-
 fs/nfsd/flexfilelayoutxdr.c |   6 +-
 fs/nfsd/flexfilelayoutxdr.h |   4 +-
 fs/nfsd/nfs4layouts.c       |   6 +-
 fs/nfsd/nfs4proc.c          |   4 +-
 fs/nfsd/nfs4xdr.c           | 206 ++++++++++++++++++++----------------
 fs/nfsd/pnfs.h              |   6 +-
 fs/nfsd/xdr4.h              |   7 +-
 9 files changed, 135 insertions(+), 114 deletions(-)

--
Chuck Lever

