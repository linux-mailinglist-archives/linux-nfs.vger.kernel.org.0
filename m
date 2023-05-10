Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 184286FE6F6
	for <lists+linux-nfs@lfdr.de>; Thu, 11 May 2023 00:09:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236396AbjEJWII (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 10 May 2023 18:08:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236339AbjEJWID (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 10 May 2023 18:08:03 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6289E3A92
        for <linux-nfs@vger.kernel.org>; Wed, 10 May 2023 15:07:59 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 13F3121923;
        Wed, 10 May 2023 22:07:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1683756478; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=Fgj92GNXnWn6vyGg4Se7Z7jElWjro1mKUqstrauxKp8=;
        b=uKJy+zl8UBVaXKE8RQaakKdOrLZRcUzi3Z4gfLFHn/0vrKpVNs5+lC2R5wrjXM8Ch3KX0u
        riwkvyr6jz+7bV14Wyr/HN7NELF7Xby7qXpU4QKElEQEnVBx7qgqlagzqTYEwRwtEoAiQB
        gSrTEhecDe/6Q6gHmVDewD5u5ZwWtt4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1683756478;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=Fgj92GNXnWn6vyGg4Se7Z7jElWjro1mKUqstrauxKp8=;
        b=gF7YW/xPMst0h1hMqZoX7IYuQYx73e23V8wqgHuGSWTrYz7KEUqx7z/6cYfBPbK/j+AF5v
        P8bumXRTjky3RyDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EAA6413519;
        Wed, 10 May 2023 22:07:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id h69QJ7sVXGTcBAAAMHmgww
        (envelope-from <neilb@suse.de>); Wed, 10 May 2023 22:07:55 +0000
Subject: [PATCH 0/2] Support abstract address for rpcbind in kernel
From:   NeilBrown <neilb@suse.de>
To:     Jeff Layton <jlayton@kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>
Cc:     linux-nfs@vger.kernel.org, Petr Vorel <pvorel@suse.cz>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Steve Dickson <steved@redhat.com>
Date:   Thu, 11 May 2023 08:06:24 +1000
Message-ID: <168375610447.26246.3237443941479930060.stgit@noble.brown>
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

These two patches cause the SUNRPC layer in Linux to attempt to contact
rpcbind using an AF_UNIX socket with an abstract address before
the existing attempts of AF_UNIX to a socket in the filesystem, and IP
to a well known port.

This allows the benefits of an AF_UNIX connection combined with the
benefits of honouring the network namespace when connection rpcbind.

For this to be useful, rpcbind must listed on that name, and user-space
tools must also connect to the same address.  This requires changes to
rpcbind and too libtirpc.  libtirpc currently has a bug which causes
sockets bountd to abstract addresses to appear to be unbound, so asking
systemd to pass rpcbind an abstract socket doesn't work - rpcbind
rejects it.

Patches for rpcbind and libtirpc will follow.

NeilBrown


---

NeilBrown (2):
      SUNRPC: support abstract unix socket addresses
      SUNRPC: attempt to reach rpcbind with an abstract socket name


 net/sunrpc/clnt.c      |  8 ++++++--
 net/sunrpc/rpcb_clnt.c | 39 +++++++++++++++++++++++++++++++--------
 net/sunrpc/xprtsock.c  |  9 +++++++--
 3 files changed, 44 insertions(+), 12 deletions(-)

--
Signature

