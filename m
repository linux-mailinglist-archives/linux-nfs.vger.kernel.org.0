Return-Path: <linux-nfs+bounces-15762-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 43A8BC1D039
	for <lists+linux-nfs@lfdr.de>; Wed, 29 Oct 2025 20:31:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D42204E0350
	for <lists+linux-nfs@lfdr.de>; Wed, 29 Oct 2025 19:31:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07441277023;
	Wed, 29 Oct 2025 19:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EfFvDSoh"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41EC32749C4
	for <linux-nfs@vger.kernel.org>; Wed, 29 Oct 2025 19:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761766305; cv=none; b=jTE3BEm8v9xaXMI7G218TkKyA/VTlkOX8PjNE+y4IkvPRCHWYcOug22Y5LbSaMHm6E+tO8lWT9wudOxEidS4NWiHL80tlfFF5x0okBmWbS7UObX4yOUA+cMtKX3dmYBa6cjqoE/busN+8SR1Hs7SzfI7VJaKe4g2En4HumnwcAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761766305; c=relaxed/simple;
	bh=Cs4vQ/ChzaKqtOX28gMAacNi7xm+nZcDpsfKAW6Ti7U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Fac/GHOuoVJkPiH/bdfE/1aBTfG5Xvflt8wbhgIwyT9RsxH7CfC77B0p0duab1oW4Kk+xKWKY0cWmG7vQer0W1RKn+pILzgqTExsNM9TzGxFf29xasXG7zGTgzlRl2VraAPyTohG/XpBwNwNcm3NZ7ihD8fbvDQULvP/tEDGBf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EfFvDSoh; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761766303;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=aht1nsMdFA9WEtHLhYq1VzGO9WPluE83Vx/ytKnmLWU=;
	b=EfFvDSohyW8lqC8vDAhaK8ZAT1jyeTetJLQLRXijCF2ksvRqBMhlTQjyMoGAmd6YY25uTd
	ybNh0K5rCm23mF/zyd5ukf+DxEC8MEssCbjhDfXVUPnJf4E959MYRESb9mPZ0dijl7g5+i
	4VgBTK+PkKYQ3EBbwjGfT9APCTzirNY=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-313-8eRJ0F6aO1CjeiWcQsg5nw-1; Wed,
 29 Oct 2025 15:31:38 -0400
X-MC-Unique: 8eRJ0F6aO1CjeiWcQsg5nw-1
X-Mimecast-MFC-AGG-ID: 8eRJ0F6aO1CjeiWcQsg5nw_1761766297
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7255418001E4;
	Wed, 29 Oct 2025 19:31:37 +0000 (UTC)
Received: from aion.redhat.com (unknown [10.22.88.126])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 41BC3180057C;
	Wed, 29 Oct 2025 19:31:37 +0000 (UTC)
Received: from aion.redhat.com (localhost [IPv6:::1])
	by aion.redhat.com (Postfix) with ESMTP id 38B124DB4BE;
	Wed, 29 Oct 2025 15:31:35 -0400 (EDT)
From: Scott Mayhew <smayhew@redhat.com>
To: trondmy@kernel.org,
	anna@kernel.org
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH] NFSv4: ensure the open stateid seqid doesn't go backwards
Date: Wed, 29 Oct 2025 15:31:35 -0400
Message-ID: <20251029193135.1527790-1-smayhew@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

We have observed an NFSv4 client receiving a LOCK reply with a status of
NFS4ERR_OLD_STATEID and subsequently retrying the LOCK request with an
earlier seqid value in the stateid.  As this was for a new lockowner,
that would imply that nfs_set_open_stateid_locked() had updated the open
stateid seqid with an earlier value.

Looking at nfs_set_open_stateid_locked(), if the incoming seqid is out
of sequence, the task will sleep on the state->waitq for up to 5
seconds.  If the task waits for the full 5 seconds, then after finishing
the wait it'll update the open stateid seqid with whatever value the
incoming seqid has.  If there are multiple waiters in this scenario,
then the last one to perform said update may not be the one with the
highest seqid.

Add a check to ensure that the seqid can only be incremented, and add a
tracepoint to indicate when old seqids are skipped.

Signed-off-by: Scott Mayhew <smayhew@redhat.com>
---
 fs/nfs/nfs4proc.c  | 7 +++++++
 fs/nfs/nfs4trace.h | 1 +
 2 files changed, 8 insertions(+)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 411776718494..840ec732ade4 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -1780,6 +1780,13 @@ static void nfs_set_open_stateid_locked(struct nfs4_state *state,
 		if (nfs_stateid_is_sequential(state, stateid))
 			break;
 
+		if (nfs4_stateid_match_other(stateid, &state->open_stateid) &&
+		    !nfs4_stateid_is_newer(stateid, &state->open_stateid)) {
+			trace_nfs4_open_stateid_update_skip(state->inode,
+							    stateid, status);
+			return;
+		}
+
 		if (status)
 			break;
 		/* Rely on seqids for serialisation with NFSv4.0 */
diff --git a/fs/nfs/nfs4trace.h b/fs/nfs/nfs4trace.h
index 9776d220cec3..6285128e631a 100644
--- a/fs/nfs/nfs4trace.h
+++ b/fs/nfs/nfs4trace.h
@@ -1353,6 +1353,7 @@ DEFINE_NFS4_INODE_STATEID_EVENT(nfs4_setattr);
 DEFINE_NFS4_INODE_STATEID_EVENT(nfs4_delegreturn);
 DEFINE_NFS4_INODE_STATEID_EVENT(nfs4_open_stateid_update);
 DEFINE_NFS4_INODE_STATEID_EVENT(nfs4_open_stateid_update_wait);
+DEFINE_NFS4_INODE_STATEID_EVENT(nfs4_open_stateid_update_skip);
 DEFINE_NFS4_INODE_STATEID_EVENT(nfs4_close_stateid_update_wait);
 
 DECLARE_EVENT_CLASS(nfs4_getattr_event,
-- 
2.51.0


