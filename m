Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 187606FE71F
	for <lists+linux-nfs@lfdr.de>; Thu, 11 May 2023 00:21:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232071AbjEJWVJ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 10 May 2023 18:21:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbjEJWVI (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 10 May 2023 18:21:08 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81992198
        for <linux-nfs@vger.kernel.org>; Wed, 10 May 2023 15:21:04 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 3F4921FD72;
        Wed, 10 May 2023 22:21:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1683757263; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=PAmJSmidmu2ZrpzdtjiVp9n0VBi1WvWtG9Dt6sCh2FI=;
        b=qLR8rUlRlmtjixFsQ3up5G4jxySW5j/pG+HrbC+UJPqDQxfJuRbaP2y/TwlVSrDl7e/cSr
        loAB1lzlKeAZmm6sa58451jn8PzeAhOhzHEh5+6z4LIZvdTMlEBZITylKzqktN/QjuJcuy
        Y0RPsy0wUJb0lt0/VkW/17uKSWLLrxc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1683757263;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=PAmJSmidmu2ZrpzdtjiVp9n0VBi1WvWtG9Dt6sCh2FI=;
        b=GAwKYun8H1FoUW+rsOEcnTuyaDpIgQ+Dumk743ep0Fsem2SZlQlQaAO+JfFwHyWHuZhCgn
        25vQzvxhNODRRYBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 36D7413519;
        Wed, 10 May 2023 22:21:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id nlrcN8wYXGQNCgAAMHmgww
        (envelope-from <neilb@suse.de>); Wed, 10 May 2023 22:21:00 +0000
Subject: [PATCH 0/3] Support abstract addresses for rpcbind in libtirpc
From:   NeilBrown <neilb@suse.de>
To:     Jeff Layton <jlayton@kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>
Cc:     linux-nfs@vger.kernel.org, Petr Vorel <pvorel@suse.cz>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Steve Dickson <steved@redhat.com>
Date:   Thu, 11 May 2023 08:20:45 +1000
Message-ID: <168375715312.25049.2010665843445641504.stgit@noble.brown>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

To accompany the kernel patches, these patches enhance libtirpc to work
with abstract addresses, and to attempt to reach rpcbind using the
proposed new abstract address: "\0/run/rpcbind.sock"

NeilBrown


---

NeilBrown (3):
      Allow working with abstract AF_UNIX addresses.
      Change local_rpcb() to take a targaddr pointer.
      Try using a new abstract address when connecting rpcbind


 src/rpc_com.h         |   6 +++
 src/rpc_generic.c     |  18 ++++---
 src/rpc_soc.c         |   6 ++-
 src/rpcb_clnt.c       | 112 ++++++++++++++++++++++--------------------
 tirpc/rpc/rpcb_prot.h |   1 +
 tirpc/rpc/rpcb_prot.x |   1 +
 6 files changed, 85 insertions(+), 59 deletions(-)

--
Signature

