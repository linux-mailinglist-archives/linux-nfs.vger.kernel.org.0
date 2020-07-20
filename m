Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75B142265CA
	for <lists+linux-nfs@lfdr.de>; Mon, 20 Jul 2020 17:58:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731889AbgGTP5P (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 20 Jul 2020 11:57:15 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:58982 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731879AbgGTP5P (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 20 Jul 2020 11:57:15 -0400
From:   "Ahmed S. Darwish" <a.darwish@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1595260632;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gjBiJEwyrXxSA52xQ4637SX/LhV+HHIgWPKRBeE4gMY=;
        b=JskSG97Z/unX95AAX1Jjm8Ns2OCTdph2TdGmq7EjoOMw1O61ho5o8HCe/PmnmOfdOiwR2G
        BAsE7ccRZJ7pWjZ3VdLhvEECDsBDRViQVWGtpX4InMXunbRn5Tg3NmEaJRgAm9hGMkOLxe
        JeHcLNVy4dFf3lCaiG8fzYzTppDSBz9h7raXMnteivQLU1PBq+U5Qc7wJbCZD88zLiEdpy
        X5qNp0CIf/qFUSd8YsJ5sEizCPj4nbe1u2L//pv0VGFAQiRdzVbOhcqXUxFxZA+ySe451Y
        H8nZGMewmjzoYpUAuAhrk4nN523cJpX5kaF+tK8c73MzKJtO54oleP2UVbnzdw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1595260632;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gjBiJEwyrXxSA52xQ4637SX/LhV+HHIgWPKRBeE4gMY=;
        b=jdzmhHQAFG9KA3OF557zjFKSsF37vGbpIRGkC/fQGHD705Uf+6rpXA+JGWNNl1GCAuSa5c
        fRs+2KqfTW/5LyDg==
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "Sebastian A. Siewior" <bigeasy@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Ahmed S. Darwish" <a.darwish@linutronix.de>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        linux-nfs@vger.kernel.org
Subject: [PATCH v4 21/24] NFSv4: Use sequence counter with associated spinlock
Date:   Mon, 20 Jul 2020 17:55:27 +0200
Message-Id: <20200720155530.1173732-22-a.darwish@linutronix.de>
In-Reply-To: <20200720155530.1173732-1-a.darwish@linutronix.de>
References: <20200519214547.352050-1-a.darwish@linutronix.de>
 <20200720155530.1173732-1-a.darwish@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

A sequence counter write side critical section must be protected by some
form of locking to serialize writers. A plain seqcount_t does not
contain the information of which lock must be held when entering a write
side critical section.

Use the new seqcount_spinlock_t data type, which allows to associate a
spinlock with the sequence counter. This enables lockdep to verify that
the spinlock used for writer serialization is held when the write side
critical section is entered.

If lockdep is disabled this lock association is compiled out and has
neither storage size nor runtime overhead.

Signed-off-by: Ahmed S. Darwish <a.darwish@linutronix.de>
---
 fs/nfs/nfs4_fs.h   | 2 +-
 fs/nfs/nfs4state.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/nfs/nfs4_fs.h b/fs/nfs/nfs4_fs.h
index 2b7f6dcd2eb8..210e590e1f71 100644
--- a/fs/nfs/nfs4_fs.h
+++ b/fs/nfs/nfs4_fs.h
@@ -117,7 +117,7 @@ struct nfs4_state_owner {
 	unsigned long	     so_flags;
 	struct list_head     so_states;
 	struct nfs_seqid_counter so_seqid;
-	seqcount_t	     so_reclaim_seqcount;
+	seqcount_spinlock_t  so_reclaim_seqcount;
 	struct mutex	     so_delegreturn_mutex;
 };
 
diff --git a/fs/nfs/nfs4state.c b/fs/nfs/nfs4state.c
index a8dc25ce48bb..b1dba24918f8 100644
--- a/fs/nfs/nfs4state.c
+++ b/fs/nfs/nfs4state.c
@@ -509,7 +509,7 @@ nfs4_alloc_state_owner(struct nfs_server *server,
 	nfs4_init_seqid_counter(&sp->so_seqid);
 	atomic_set(&sp->so_count, 1);
 	INIT_LIST_HEAD(&sp->so_lru);
-	seqcount_init(&sp->so_reclaim_seqcount);
+	seqcount_spinlock_init(&sp->so_reclaim_seqcount, &sp->so_lock);
 	mutex_init(&sp->so_delegreturn_mutex);
 	return sp;
 }
-- 
2.20.1

