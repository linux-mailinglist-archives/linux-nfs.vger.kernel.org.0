Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56394672501
	for <lists+linux-nfs@lfdr.de>; Wed, 18 Jan 2023 18:32:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230360AbjARRcW (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 18 Jan 2023 12:32:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230448AbjARRcF (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 18 Jan 2023 12:32:05 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6A6D47092
        for <linux-nfs@vger.kernel.org>; Wed, 18 Jan 2023 09:31:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 816406193C
        for <linux-nfs@vger.kernel.org>; Wed, 18 Jan 2023 17:31:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F3BAC433D2;
        Wed, 18 Jan 2023 17:31:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674063100;
        bh=Xd8ou09l3DDVjyZDTjIKKeN5vyLL0rnhNehxGW0qIrY=;
        h=From:To:Cc:Subject:Date:From;
        b=LjxY9GhmxXIO/zymfEyhHwd+EcBE85J7V10q0cOoSQBk0hxNXDkOegj+1y95HGV1C
         TfeC25Gm8wQhMM5YLbnpvix2mAVcJ56q/PheNiSKob4NElUuVxhBEoiFEIZOFFwfW7
         cfYrbqn4H4x2opYO+lH1pdT7iEOjI2wWoAZKbou+zVltLWjgTS7xzVxA7Cq7XpiVRe
         utXcj73r5hzOAsIOMkm8bA+DINrUq+GGOlICa0hukB1J49YYT+UskYAQiVYtacNNWA
         IniFAnnlZ1NWBbEhBXTP9etxOkqM4La5wWRTUnY+OxbwSOn6+K6WuOGdLRdHbQvjEC
         6E7givayZpZfQ==
From:   Jeff Layton <jlayton@kernel.org>
To:     chuck.lever@oracle.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 0/6] nfsd: random cleanup and doc work
Date:   Wed, 18 Jan 2023 12:31:33 -0500
Message-Id: <20230118173139.71846-1-jlayton@kernel.org>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Just a pile of cleanup and doc patches. None of these fix noticeable
bugs, but a couple of them should make things slightly more efficient
and (hopefully) more clear for developers.

These are probably v6.3 material.

Jeff Layton (6):
  nfsd: don't take nfsd4_copy ref for OP_OFFLOAD_STATUS
  nfsd: eliminate find_deleg_file_locked
  nfsd: simplify the delayed disposal list code
  nfsd: don't take/put an extra reference when putting a file
  nfsd: add some kerneldoc comments for stateid preprocessing functions
  nfsd: eliminate __nfs4_get_fd

 fs/nfsd/filecache.c | 68 +++++++++++++++------------------------------
 fs/nfsd/nfs4proc.c  | 35 +++++++++++++++--------
 fs/nfsd/nfs4state.c | 60 +++++++++++++++++++++------------------
 fs/nfsd/state.h     |  2 --
 4 files changed, 79 insertions(+), 86 deletions(-)

-- 
2.39.0

