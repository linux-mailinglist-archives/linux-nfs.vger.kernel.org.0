Return-Path: <linux-nfs+bounces-17551-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AD2BCFC720
	for <lists+linux-nfs@lfdr.de>; Wed, 07 Jan 2026 08:49:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A138D3007C64
	for <lists+linux-nfs@lfdr.de>; Wed,  7 Jan 2026 07:45:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B7DF26F471;
	Wed,  7 Jan 2026 07:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kakaocorp.com header.i=@kakaocorp.com header.b="YEM88NXp"
X-Original-To: linux-nfs@vger.kernel.org
Received: from spam3.kakaowork.com (spam3.kakaowork.com [61.109.238.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 194D82C21C2
	for <linux-nfs@vger.kernel.org>; Wed,  7 Jan 2026 07:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=61.109.238.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767771896; cv=none; b=tymbmAhBCKsQ8/1G0FeNT5ntCidkYknzU10hdOPGzV5z1EmbseaVAGF/1UMihNqqJ5bZdpns/aQtZd/lgIwbsJ0XJE3/GI/rjoXEjbA8apjhi396o87Oz/8pmwPBRObTmfp1ny/MWJm8E87w7S9rP1HvZeedxwqrVP9QWkl2NOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767771896; c=relaxed/simple;
	bh=mUTZYRRte2cRwL9Fk7d31UXjrJrXduQsdWNMxtlP5+A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OvdDGEznOwaMJOjXK9aySqhOeJTGJMgz24CYG2pon0FPQ8TDEzzlfhEmKKaQuZ9yzbLG5kqGIdGAF2Sh87NRiAVezKcj5mtLu6dSd8tsGK7E/CUQiBrxjDND0IAHCno/k1X2Wbfgzef7TTnFgbUEua+AygKbrEeZSHS7eOh6yPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kakaocorp.com; spf=pass smtp.mailfrom=kakaocorp.com; dkim=pass (1024-bit key) header.d=kakaocorp.com header.i=@kakaocorp.com header.b=YEM88NXp; arc=none smtp.client-ip=61.109.238.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kakaocorp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kakaocorp.com
Received: from unknown (HELO cloudmail-prod-was1) (10.111.0.147)
	by 10.111.0.133 with ESMTP; 7 Jan 2026 16:44:50 +0900
X-Original-SENDERIP: 10.111.0.147
X-Original-SENDERCOUNTRY: unknown
X-Original-MAILFROM: dylan.ka@kakaocorp.com
X-Original-RCPTTO: linux-nfs@vger.kernel.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple; t=1767771846;
	s=s20240318; d=kakaocorp.com;
	h=from:to:cc:subject:date:message-id:mime-version:content-transfer-encoding;
	bh=mUTZYRRte2cRwL9Fk7d31UXjrJrXduQsdWNMxtlP5+A=;
	b=YEM88NXpBR/1s2KTbFm+j8o5fi3EQ3TvGWfgQqYfTBPeoJHzZ5LhC+C4V+8uW5GE
	lBeiQd7OMLmhVM/qKTbNKAl81Cby18l5R131ENYSjMaMeCsuyjqDK3vM2cpkLrf5Nnj
	8ho1CQLC2vuYFBQdyIRac1C2tlq/OrzTQcky8aJM=
Received: from kakaocorp.com (211.41.105.40)(permitted)
	by kakaowork.com with ESMTP kakaowork SmtpServer 
	id <7cf4a59b48b64c5990d6b6c5a52f77ca> from <dylan.ka@kakaocorp.com> authenticated with <dylan.ka@kakaocorp.com>;
	Wed, 07 Jan 2026 16:43:47 +0900
From: Wonju Ka <dylan.ka@kakaocorp.com>
To: linux-nfs@vger.kernel.org
Cc: trond.myklebust@hammerspace.com,
	anna@kernel.org
Subject: [BUG] NFS4.1 migration: in-flight RPCs retried with stale session credentials to new server
Date: Wed,  7 Jan 2026 16:44:30 +0900
Message-ID: <20260107074430.84482-1-dylan.ka@kakaocorp.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

I've encountered a kernel panic during NFS4.1 transparent state migration
where in-flight RPC requests are retransmitted with stale session
credentials to the new (target) server after migration completes.

Environment:
- Kernel: 5.15.0-121-generic (Ubuntu)
- Protocol: NFSv4.1
- Scenario: Transparent state migration with heavy I/O load

Problem Description:
-------------------
During migration, when many WRITE operations are in-flight (16 slots fully
utilized), the following sequence occurs:

1. Client detects LEASE_MOVED flag from source server
2. Client performs migration recovery (FS_LOCATIONS, CREATE_SESSION on target)
3. Migration completes - nfs_server now points to target server's nfs_client
4. rpc_xprt is switched to target server connection
5. In-flight RPCs on source connection receive NFS4ERR_BADSESSION
6. These RPCs are retried using the NEW transport (target server)
   but with OLD session credentials (source server's session ID)
7. Target server receives requests with foreign session ID -> "client not found"
8. Eventually leads to use-after-free panic

The core issue is that when migration switches the transport via
rpc_switch_client_transport(), the pending RPC tasks retain their original
session credentials. When these tasks are retried after the source connection
fails, they're sent to the target server with the source server's session ID.

Timeline from logs:
------------------
07:28:57.069  LEASE_MOVED flag detected (source server)
07:28:58.251  CREATE_SESSION on target (new ClientID: 2:1767652138)
07:28:58.252  RECLAIM_COMPLETE
07:28:58.5xx  WRITEs still processing on source (session 5:1767650393:0:1)
07:28:58.5xx  New WRITEs on target (session 2:1767652138:0:1)
07:28:59.248  Target receives request with SOURCE session ID!
              ERROR: client not found {"clientId": "5:1767650393",
                                       "sessionId": "5:1767650393:0:1"}
07:28:59.489  PANIC: "refcount_t: addition on 0; use-after-free"

Evidence from target server logs:
--------------------------------
The target server (ClientID 2:1767652138) received requests with the
source server's session ID (5:1767650393:0:1):

  2026-01-06 07:28:59.248 ERROR client not found
      {"clientId": "5:1767650393", "sessionId": "5:1767650393:0:1"}
  2026-01-06 07:28:59.650 ERROR client not found
      {"clientId": "5:1767650393", "sessionId": "5:1767650393:0:2"}

These requests arrived on port 59244 (target connection), not port 56768
(source connection), confirming that the transport was updated but session
credentials were not.

Kernel panic trace:
------------------
refcount_t: addition on 0; use-after-free.
WARNING: CPU: 7 PID: 33665 at lib/refcount.c:25 refcount_warn_saturate+0x9f/0x150
Workqueue: rpciod rpc_async_schedule [sunrpc]
Call Trace:
 nfs4_schedule_state_manager+0x...
 nfs4_schedule_session_recovery+0x...
 nfs41_sequence_process+0x...
 nfs4_sequence_done+0x...
 nfs4_write_done+0x...

Analysis:
--------
In fs/nfs/nfs4state.c, nfs4_try_migration() switches the nfs_server to
point to the new nfs_client and updates the RPC transport. However,
RPC tasks that are already in-flight retain references to the old session.

When these tasks fail on the old connection and are retried, they use:
- New transport (target server) - correct
- Old session credentials - incorrect

The session ID in the SEQUENCE operation comes from the rpc_task's
credentials which were set up before migration occurred.

Possible fix directions:
-----------------------
1. Drain all in-flight RPCs before completing migration
2. When retrying failed RPCs after migration, refresh session credentials
3. Mark pending RPCs for re-authentication after transport switch

This issue is related to the previously reported problem:
https://lore.kernel.org/all/CAHrBo4v_arroQ5pC2xS9PK2xsAm4O-X75zinDgKSBDSitbWuYw@mail.gmail.com/T/

I can provide full logs and additional details if needed.

Thanks,
Wonjun



