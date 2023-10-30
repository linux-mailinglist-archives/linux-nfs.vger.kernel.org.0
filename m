Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A1727DB1C8
	for <lists+linux-nfs@lfdr.de>; Mon, 30 Oct 2023 02:13:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231236AbjJ3BNJ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 29 Oct 2023 21:13:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjJ3BNI (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 29 Oct 2023 21:13:08 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79E80BD
        for <linux-nfs@vger.kernel.org>; Sun, 29 Oct 2023 18:13:06 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 5CF1821D49;
        Mon, 30 Oct 2023 01:13:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1698628384; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=ojZuCV534bTw0U7aBMJrNLnbj0icDQy3uMfdZr7uLyg=;
        b=kDtuDES/n2YZAqWyFclbJsVs9+zJ0qI/jjwbu7Df0M/eJxou8Q5io8G7CUZWYn6fJT6sE0
        asaGhZncr2XIuXp11JMPuVbJswZUml7XcyjpYkUAAlP6b2SMK0RjeMqQIOBiQaHmgWeqXG
        RJJxZZQbkubPkdE4HJJ46k8BMpP5t2s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1698628384;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=ojZuCV534bTw0U7aBMJrNLnbj0icDQy3uMfdZr7uLyg=;
        b=4TZjUeYN/xg2FIzlfhvbwI5SbcyccO1zm1mjC6rS3a2duvvBqyTLgoygC4WbJB1267Pn4l
        FUN7VEx6AER8+qBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2E3AB13460;
        Mon, 30 Oct 2023 01:13:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id wySMNB0DP2VORwAAMHmgww
        (envelope-from <neilb@suse.de>); Mon, 30 Oct 2023 01:13:01 +0000
From:   NeilBrown <neilb@suse.de>
To:     Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>
Cc:     linux-nfs@vger.kernel.org, Olga Kornievskaia <kolga@netapp.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>
Subject: [PATCH 0/5] sunrpc: not refcounting svc_serv
Date:   Mon, 30 Oct 2023 12:08:33 +1100
Message-ID: <20231030011247.9794-1-neilb@suse.de>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
        none
X-Spam-Level: 
X-Spam-Score: 0.55
X-Spamd-Result: default: False [0.55 / 50.00];
         ARC_NA(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         R_MISSING_CHARSET(2.50)[];
         MIME_GOOD(-0.10)[text/plain];
         BROKEN_CONTENT_TYPE(1.50)[];
         RCPT_COUNT_FIVE(0.00)[6];
         NEURAL_HAM_LONG(-3.00)[-1.000];
         DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
         NEURAL_HAM_SHORT(-1.00)[-1.000];
         MID_CONTAINS_FROM(1.00)[];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         RCVD_COUNT_TWO(0.00)[2];
         RCVD_TLS_ALL(0.00)[];
         BAYES_HAM(-0.35)[76.34%]
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

This patch set continues earlier work of improving how threads and
services are managed.  Specifically it drop the refcount.

The refcount is always changed under the mutex, and almost always is
exactly equal to the number of threads.  Those few cases where it is
more than the number of threads can usefully be handled other ways as
see in the patches.

The first patches fixes a potential use-after-free when adding a socket
fails.  This might be the UAF that Jeff mentioned recently.

The second patch which removes the use of a refcount in pool_stats
handling is more complex than I would have liked, but I think it is
worth if for the result seen in 4/5 of substantial simplification.

NeilBrown



