Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA7666F9FB0
	for <lists+linux-nfs@lfdr.de>; Mon,  8 May 2023 08:20:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232161AbjEHGUV (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 8 May 2023 02:20:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232546AbjEHGUU (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 8 May 2023 02:20:20 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 471BA1FEA
        for <linux-nfs@vger.kernel.org>; Sun,  7 May 2023 23:20:19 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id D80371FD9F;
        Mon,  8 May 2023 06:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1683526817; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=Ve1c6/jYtA0PHTK5NzLGxLdTU53SFWk5zk+igbF0mic=;
        b=SIZpo5jUA2/V6xwbht0g2ca3BVLV9aDS/oATfX14spICoBTrs66V5lO0L1bBkK5VSy5soD
        8oIOStgBDziGa2K7cXfm5hQJ/MaZEQ7C+xpYevo5A0MUVBMfZeAfJgbAj3Qai63WM55dGI
        0o4BvhG0BQ8RbjpAxxUjnuCVaQk6Z5w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1683526817;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=Ve1c6/jYtA0PHTK5NzLGxLdTU53SFWk5zk+igbF0mic=;
        b=2NBtVLUqIJA8tmHxE0YkXTZg2iQSvhy+be4CFrCT9qrFVcu6H4s+/lZ3Sll7tPXLtrtm6C
        ayrjvsAiIT3LK+AQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A054F13499;
        Mon,  8 May 2023 06:20:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id D0wzFaCUWGRMGAAAMHmgww
        (envelope-from <neilb@suse.de>); Mon, 08 May 2023 06:20:16 +0000
Subject: [PATCH 0/2] Minor improvements for fsidd in nfs-utils
From:   NeilBrown <neilb@suse.de>
To:     Steve Dickson <steved@redhat.com>,
        Richard Weinberger <richard@nod.at>
Cc:     linux-nfs@vger.kernel.org
Date:   Mon, 08 May 2023 16:19:11 +1000
Message-ID: <168352657591.17279.393573102599959056.stgit@noble.brown>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

nfs-utils in openSUSE was recently updated to a version with fsidd and a
routine security audit was performed.  No real security issues were
found but a couple of oddities were highlighted.  The follow two patches
propose ways to clean up these oddities.

NeilBrown


---

NeilBrown (2):
      fsidd: don't use assert() on expr with side-effect.
      fsidd: provide better default socket name.


 support/reexport/fsidd.c    | 38 +++++++++++++++++++++----------------
 support/reexport/reexport.c |  3 +++
 support/reexport/reexport.h |  2 +-
 3 files changed, 26 insertions(+), 17 deletions(-)

--
Signature

