Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04A71575623
	for <lists+linux-nfs@lfdr.de>; Thu, 14 Jul 2022 22:04:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239720AbiGNUEk (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 14 Jul 2022 16:04:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238087AbiGNUEi (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 14 Jul 2022 16:04:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BFFF46D87
        for <linux-nfs@vger.kernel.org>; Thu, 14 Jul 2022 13:04:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B92026221B
        for <linux-nfs@vger.kernel.org>; Thu, 14 Jul 2022 20:04:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAA59C34114;
        Thu, 14 Jul 2022 20:04:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657829076;
        bh=9Tf4yhzPdnMNP4EqbK9j4rFDRMn4zNtDaFY6ndl4gxo=;
        h=From:To:Cc:Subject:Date:From;
        b=svKboFdOjVUe0hg9b8il5/Oh/3vjk7IG2jkqCuNhCpL0VgFQMW0H3FlSjMo5FHITS
         JDlsrzbbOX/SfdTbbd05mQ0leQojA7zQov4TPVSBPHmiL25bTXSvofmVg023S2sj3f
         KRXUjTWr5+3zuyeDcIMUNVz3rTVQrxpDgINka1upIrYDUfwZTJEh492yd15arjtFUA
         nqKB410rkTx2RIcuNS3Z/c2G7xDDSbpsOUzlhjuQqnJMPfIACx9Nfyjq9FbmiVw969
         8kmQ3RNp3iw2p3EprziLdptIT2sBuAmwW5LSEMhIGvHGEkPkQRgs/VISKOlTfHkndC
         B98CSdjDR0thA==
From:   Jeff Layton <jlayton@kernel.org>
To:     chuck.lever@oracle.com
Cc:     neilb@suse.de, linux-nfs@vger.kernel.org
Subject: [PATCH 0/2] nfsd: close potential race between open and delegation
Date:   Thu, 14 Jul 2022 16:04:32 -0400
Message-Id: <20220714200434.161818-1-jlayton@kernel.org>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

This is a respin of the patchset that I sent earlier today. I hit a
deadlock with that one because of the ambiguous locking.

This series is based on top of Neil's set entitled:

    [PATCH 0/8] NFSD: clean up locking.

His patchset makes the locking in the nfsd4_open codepath much more
consistent, and this becomes a lot simpler to fix. Without that set
however, the state of the parent's i_rwsem is unclear after nfsd_lookup
is called, and I don't see a way to determine it reliably.

Jeff Layton (2):
  nfsd: drop fh argument from alloc_init_deleg
  nfsd: vet the opened dentry after setting a delegation

 fs/nfsd/nfs4state.c | 54 +++++++++++++++++++++++++++++++++++++--------
 1 file changed, 45 insertions(+), 9 deletions(-)

-- 
2.36.1

