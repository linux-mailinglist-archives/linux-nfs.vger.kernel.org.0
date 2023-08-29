Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4F0978CFD8
	for <lists+linux-nfs@lfdr.de>; Wed, 30 Aug 2023 01:05:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241067AbjH2XFL (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 29 Aug 2023 19:05:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240815AbjH2XEi (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 29 Aug 2023 19:04:38 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B43471BE;
        Tue, 29 Aug 2023 16:04:34 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id E2ED91F88D;
        Tue, 29 Aug 2023 23:04:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1693350272; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=XGKcOlxSAVAgG3RJ4LeN/UnSyuPJ54+BZFYnVmOyyAM=;
        b=hbDv47V3yhEvkSS1KfdYBaR46TSVUTLNd8AzlgBttUU6zP1V7Zz6HwZSXwF6kF+NAbSxdu
        7dINesW5WMsCgQQUw814fymHkY0OSxn6FXn766tVXfO6916nlLmLzYqlJAi64vywyvs/WQ
        rJXn8tUxeze3ri8JfRq84BR5bxqJ/5A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1693350272;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=XGKcOlxSAVAgG3RJ4LeN/UnSyuPJ54+BZFYnVmOyyAM=;
        b=n+/TBOM6Okc8IT+SQjTQ+nRWPjsKpd7DECTYyYyK7sMIPI9JpzAu2HxNNFZ1FL9/3+bIRP
        v7gvqp+balvTRnBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 82A6113301;
        Tue, 29 Aug 2023 23:04:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id oONeDXx57mRqbQAAMHmgww
        (envelope-from <neilb@suse.de>); Tue, 29 Aug 2023 23:04:28 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   NeilBrown <neilb@suse.de>
Subject: [PATCH] sched: report correct state for TASK_IDLE | TASK_FREEZABLE
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>,
        linux-nfs@vger.kernel.org
Date:   Wed, 30 Aug 2023 09:04:19 +1000
Message-id: <169335025927.5133.4781141800413736103@noble.neil.brown.name>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


task_state_index() ignores uninteresting state flags (such as
TASK_FREEZABLE) for most states, but for TASK_IDLE and TASK_RTLOCK_WAIT
it does not.
So if a task is waiting TASK_IDLE|TASK_FREEZABLE it gets incorrectly
reported as TASK_UNINTERRUPTIBLE or "D".  (it is planned for nfsd to
change to use this state).

Fix this by only testing the interesting bits and not the irrelevant
bits in __task_state_index()

Signed-off-by: NeilBrown <neilb@suse.de>
---
 include/linux/sched.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 177b3f3676ef..c0a21a3b106c 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1671,7 +1671,7 @@ static inline unsigned int __task_state_index(unsigned =
int tsk_state,
=20
 	BUILD_BUG_ON_NOT_POWER_OF_2(TASK_REPORT_MAX);
=20
-	if (tsk_state =3D=3D TASK_IDLE)
+	if ((tsk_state & TASK_IDLE) =3D=3D TASK_IDLE)
 		state =3D TASK_REPORT_IDLE;
=20
 	/*
@@ -1679,7 +1679,7 @@ static inline unsigned int __task_state_index(unsigned =
int tsk_state,
 	 * to userspace, we can make this appear as if the task has gone through
 	 * a regular rt_mutex_lock() call.
 	 */
-	if (tsk_state =3D=3D TASK_RTLOCK_WAIT)
+	if (tsk_state & TASK_RTLOCK_WAIT)
 		state =3D TASK_UNINTERRUPTIBLE;
=20
 	return fls(state);
--=20
2.41.0

