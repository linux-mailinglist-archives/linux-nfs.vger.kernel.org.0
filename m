Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCD68780377
	for <lists+linux-nfs@lfdr.de>; Fri, 18 Aug 2023 03:46:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357025AbjHRBpj (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 17 Aug 2023 21:45:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357114AbjHRBp3 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 17 Aug 2023 21:45:29 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA1C12713
        for <linux-nfs@vger.kernel.org>; Thu, 17 Aug 2023 18:45:27 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 52E452186E;
        Fri, 18 Aug 2023 01:45:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1692323126; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=VrlkNmGef/51IWqt8n+j+RNq6DXiSIUKyZQ7CCuKVcU=;
        b=y15pBWimd1k/IjDQh2vle//jgWvvXavnS6gV/AWywRz90J92L0khNqjzUgN/B82hX0CZya
        0tsZ9W+0S76YTaL500JJg+lfJVWNpB0qo/fX+AB22WCkdwDpdkxZSsIL7C7LGSW/115UYt
        HM9JZZme9HuuG8rNKVsEeGs0J0bquws=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1692323126;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=VrlkNmGef/51IWqt8n+j+RNq6DXiSIUKyZQ7CCuKVcU=;
        b=odFDdX3m+9xvU9z+SlhD2uRzndvfXUvBsrMIpAyyBIUFczsqkfgJRKzwAufsFY+keSpwwO
        WdHN1n1CK5gdzKAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 137651353E;
        Fri, 18 Aug 2023 01:45:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id vA7wLTTN3mRkZAAAMHmgww
        (envelope-from <neilb@suse.de>); Fri, 18 Aug 2023 01:45:24 +0000
From:   NeilBrown <neilb@suse.de>
To:     Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 0/7] SUNRPC - queuing improvements.
Date:   Fri, 18 Aug 2023 11:45:05 +1000
Message-Id: <20230818014512.26880-1-neilb@suse.de>
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

This series is against topic-sunrpc-thread-scheduling (7fddd9be200c).
There are two changes since last post (other than dropping patches
that have been included in the topic branch.

1/ When I dropped the test on freezing(current), need needed to
   add TASK_FREEZABLE to the wait state.  I could keep testing
   freezing(current) before calling schedule, but TASK_FREEZABLE
   is cleaner and seems to be prefered ... except ...

   /proc/PID/stat reports a status for "D" for tasks that are
      TASK_IDLE | TASK_FREEZABLE
   instead of the correct "I".  I've included a fix for that in
   the relevant patch.  I should probably post is separately
   to the scheduler team.

2/ There was a bug in lwq_dequeue().  It tested lwq_empty() without
   taking the spinlock.  This could result in call-positive results
   if it raced with another lwq_dequeue(). So lwq_dequeue() now
   ensure the queue never looks transiently empty.
   lwq_empty() is also more careful about memory ordering.

NeilBrown

 [PATCH 1/7] SUNRPC: change service idle list to be an llist
 [PATCH 2/7] SUNRPC: only have one thread waking up at a time
 [PATCH 3/7] SUNRPC/svc: add light-weight queuing mechanism.
 [PATCH 4/7] SUNRPC: use lwq for sp_sockets - renamed to sp_xprts
 [PATCH 5/7] SUNRPC: change sp_nrthreads to atomic_t
 [PATCH 6/7] SUNRPC: discard sp_lock
 [PATCH 7/7] SUNRPC: change the back-channel queue to lwq

