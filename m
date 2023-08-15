Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EE5277C578
	for <lists+linux-nfs@lfdr.de>; Tue, 15 Aug 2023 03:55:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233945AbjHOBzK (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 14 Aug 2023 21:55:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233982AbjHOByp (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 14 Aug 2023 21:54:45 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E06CB0
        for <linux-nfs@vger.kernel.org>; Mon, 14 Aug 2023 18:54:44 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 32A731F37C;
        Tue, 15 Aug 2023 01:54:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1692064483; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=teMA0PXuF81oqeIk8cYc2kL6yhhUS9ST0NiGATI7T7M=;
        b=GGI3wrwuJh6rtNiSrRF0c0GrhwOqY+zmraUVTazU1GK3EmwWVQ7X67pgTjg+XZyhNsUoOF
        Vqgt9igcITUMkJ1+FTS7VNe/5jbTehT0U8skq6y7ZhDCtk02baUYcoJRrEb7A/ozoDphGm
        yCYbwM90oAfrOS7O3jAdB3XyQFPmaFw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1692064483;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=teMA0PXuF81oqeIk8cYc2kL6yhhUS9ST0NiGATI7T7M=;
        b=2Sd9+4MWOMaiRqYx/rR/lm/e0iA37qloPX6zh8QZ7wgce7i1kX0mDReVsNeUuNfsBgGOMb
        Oea3Em+fojVzQbCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E94301353E;
        Tue, 15 Aug 2023 01:54:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ubPGJuHa2mSjCgAAMHmgww
        (envelope-from <neilb@suse.de>); Tue, 15 Aug 2023 01:54:41 +0000
From:   NeilBrown <neilb@suse.de>
To:     Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 00/10] SUNRPC: remainder of srv queueing work
Date:   Tue, 15 Aug 2023 11:54:16 +1000
Message-Id: <20230815015426.5091-1-neilb@suse.de>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

This series is on top of topic-sunrpc-thread-scheduling (4fa42add1a7)

It includes a fixup for an earlier patch in that topic, revised versions
of patches that have been sent but are yet to land, and the remainder of
what I have been working on.

With the full set enqueueing and dequeueing of the list of idle threads
is completely lockless following a LIFO discipline.  Threads are woken
gradually without the possibility of a thundering herd.  If lots of work
becomes ready only one thread is woken and once it dequeues the first
work item, it will dequeue another thread if there is more work to do.

Queueing and dequeueing for work-items for these threads is partially
lockless following a FIFO discipline.  Enqueueing, which can happen in
bh context, is lockless. Dequeueing in the server threads still
requires a spinlock, but does not need to disable 'bh'.

NeilBrown

 [PATCH 01/10] SQUASH: SUNRPC: rename and refactor svc_get_next_xprt()
 [PATCH 02/10] SUNRPC: add list of idle threads
 [PATCH 03/10] SUNRPC: discard SP_CONGESTED
 [PATCH 04/10] SUNRPC: change service idle list to be an llist
 [PATCH 05/10] SUNRPC: only have one thread waking up at a time
 [PATCH 06/10] SUNRPC/svc: add light-weight queuing mechanism.
 [PATCH 07/10] SUNRPC: use lwq for sp_sockets - renamed to sp_xprts
 [PATCH 08/10] SUNRPC: change sp_nrthreads to atomic_t
 [PATCH 09/10] SUNRPC: discard sp_lock
 [PATCH 10/10] SUNRPC: change the back-channel queue to lwq

