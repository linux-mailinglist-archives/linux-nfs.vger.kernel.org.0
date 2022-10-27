Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7608E6104C8
	for <lists+linux-nfs@lfdr.de>; Thu, 27 Oct 2022 23:52:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237115AbiJ0VwW (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 27 Oct 2022 17:52:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237102AbiJ0VwR (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 27 Oct 2022 17:52:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 969DB7B5B1
        for <linux-nfs@vger.kernel.org>; Thu, 27 Oct 2022 14:52:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 35CF762529
        for <linux-nfs@vger.kernel.org>; Thu, 27 Oct 2022 21:52:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 348F4C433D6;
        Thu, 27 Oct 2022 21:52:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666907535;
        bh=Ldnh4CzMPar1bojs2BnJNrUiCKGXesB8l3uFOG2n87U=;
        h=From:To:Cc:Subject:Date:From;
        b=mtBNzZZXgfeKF9HfvK+rabaPff3dgtnobOo30TzhDJh+VCvNelxSpU1FFrjcBTaAk
         HLxV4yEuA2nXtj0Ll+NjFxYY6Y23SgR2nPIoo8RbodgHJUEbrh/SmyQc3hJZhIekpa
         RZWz1wSBMYvnrCf0Y2o84fctcDM2cgFbZpA1p0f0hnyg4UpLZaTZriEagHO2NCKxFj
         9Gd+w7AMI6Z6pCzI4o87qizpuu1LNjNmw0ELegprqfdMdZXM1+gxaR7FeN3kK8rCN4
         wH2m62KCe6FP8zokYWEBeHIZXoz38mktkPYBFFvviniKp4g/DStjJS8YcxwTRdYDG6
         l6yYvR1G+U0Kg==
From:   Jeff Layton <jlayton@kernel.org>
To:     chuck.lever@oracle.com
Cc:     linux-nfs@vger.kernel.org, neilb@suse.de
Subject: [PATCH v2 0/3] nfsd: clean up refcounting in filecache
Date:   Thu, 27 Oct 2022 17:52:10 -0400
Message-Id: <20221027215213.138304-1-jlayton@kernel.org>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

This patchset should bring the filecache into closer alignment with what
Neil had mentioned here. The first patch cleans up the refcounting, and
the second two optimize the "gc" entry handling.

This should apply cleanly on top of Chuck's current for-next branch.

Jeff Layton (3):
  nfsd: rework refcounting in filecache
  nfsd: only keep unused entries on the LRU
  nfsd: start non-blocking writeback after adding nfsd_file to the LRU

 fs/nfsd/filecache.c | 331 ++++++++++++++++++++++++--------------------
 fs/nfsd/trace.h     |   5 +-
 2 files changed, 185 insertions(+), 151 deletions(-)

-- 
2.37.3

