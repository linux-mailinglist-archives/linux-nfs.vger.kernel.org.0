Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBF456FE72D
	for <lists+linux-nfs@lfdr.de>; Thu, 11 May 2023 00:27:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231313AbjEJW1z (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 10 May 2023 18:27:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232231AbjEJW1y (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 10 May 2023 18:27:54 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3FC6E53
        for <linux-nfs@vger.kernel.org>; Wed, 10 May 2023 15:27:52 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 687681FD72;
        Wed, 10 May 2023 22:27:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1683757671; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=yZtzmoDaVFZHPDzIQg8NofrbYCWGhiDyPuVFLjKA3qA=;
        b=NynIjwvZFbSaZAOGC5WxexyruzM2dnBHGw51jushxqRbjduThtXqNB7sWyyY4n2sR2s7ms
        OztDYxuXVqb8ZKqrUDm2o0Nv74ePBIIaCUVxMhYPl2NvL+38rlPmcxnfQq8jPsx13wPyuB
        CWS0hTeh1ogX+4cZbmmnsIV6KRJRO8Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1683757671;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=yZtzmoDaVFZHPDzIQg8NofrbYCWGhiDyPuVFLjKA3qA=;
        b=XYBrX+X/1O0uoc1DHWzBGErIxsOYxHDP3k8jrxURUQ33bIv59Qy7Bq9Hp3etWZ5X9vyO/5
        fUNnwR3Q59OjRTDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6146813519;
        Wed, 10 May 2023 22:27:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id OXJRBmUaXGRnDAAAMHmgww
        (envelope-from <neilb@suse.de>); Wed, 10 May 2023 22:27:49 +0000
Subject: [PATCH 0/2] Support abstract addresses for rpcbind in rpcbind
From:   NeilBrown <neilb@suse.de>
To:     Jeff Layton <jlayton@kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>
Cc:     linux-nfs@vger.kernel.org, Petr Vorel <pvorel@suse.cz>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Steve Dickson <steved@redhat.com>
Date:   Thu, 11 May 2023 08:27:36 +1000
Message-ID: <168375751051.30997.11634044913854205425.stgit@noble.brown>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

If the previous patch sets to the kernel and the libtirpc are accepted,
we need rpcbind to listen on the new abstract address.

We could unconditionally listen, but as current libtirpc rejects sockets
bound to abstract addresses, this would result in unsightly errors.

So only add the new ListenStream to rpcbind.socket if it is likely to
work.

Also enhance rpcinfo to use the new abstract address if possible.

NeilBrown

---

NeilBrown (2):
      Listen on an AF_UNIX abstract address if supported.
      rpcinfo: try connecting using abstract address.


 configure.ac              | 13 ++++++++++++-
 src/rpcinfo.c             | 24 +++++++++++++++++++++++-
 systemd/rpcbind.socket    | 18 ------------------
 systemd/rpcbind.socket.in | 19 +++++++++++++++++++
 4 files changed, 54 insertions(+), 20 deletions(-)
 delete mode 100644 systemd/rpcbind.socket
 create mode 100644 systemd/rpcbind.socket.in

--
Signature

