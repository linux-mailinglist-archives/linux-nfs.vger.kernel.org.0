Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C9A9768C4E
	for <lists+linux-nfs@lfdr.de>; Mon, 31 Jul 2023 08:51:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229980AbjGaGvg (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 31 Jul 2023 02:51:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230048AbjGaGvg (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 31 Jul 2023 02:51:36 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A06231704
        for <linux-nfs@vger.kernel.org>; Sun, 30 Jul 2023 23:51:17 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 61CD71F460;
        Mon, 31 Jul 2023 06:51:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1690786276; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=zMyh9ZGe/sv5Jk9HJii6wpiLlyvIUtf5eYz3RaIY2ak=;
        b=AKIf1uPwcM1TUIdMk/TXZTbKC7a26i3YLtqomR4PsENfgeQIqyW053iQjE7TPaFvGDOlDL
        qh+iCVFVluTkYvAXL9CVr0vJi4Tn6AKCfvOUqQ0quMjVqFC0sG+/adFf7bZxxBTYr589FF
        65ZRDhEM9jBHRVwMIjwONmytNn3ldUM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1690786276;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=zMyh9ZGe/sv5Jk9HJii6wpiLlyvIUtf5eYz3RaIY2ak=;
        b=kUPGznEU2fyd+M5jps2B36dP5R1JqAioMZzUo6J6rPNVnsZhCnJrkPTFKyCeDIglwCuMMx
        5OjOnTNUuB6rmzAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1F8AE1322C;
        Mon, 31 Jul 2023 06:51:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id AXueMOJZx2SDbwAAMHmgww
        (envelope-from <neilb@suse.de>); Mon, 31 Jul 2023 06:51:14 +0000
From:   NeilBrown <neilb@suse.de>
To:     Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 00/12] SUNRPC: various thread management improvements
Date:   Mon, 31 Jul 2023 16:48:27 +1000
Message-Id: <20230731064839.7729-1-neilb@suse.de>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

This patch set is against topic-sunrpc-thread-scheduling.
The series contains 2 fix-ups that I suggest be merged into earlier patches 
in the topic branch with matching name.
For the first to work, patch 01/12 needs to be inserted before the first
fixed patch.
Remaining 9 patches can go at the end.

An end result of this is that waking up an idle thread no longer
searches the list of all threads.  However it does requiring taking a
spinlock, though it has a very short hold time.

If/when these successfully land in the topic branch (or earlier if you
like) I can post a further collection of patches which removes that new
locking and reduces locking for the queueing of transports and NFSv4.1
callback requests.

Thanks,
NeilBrown


