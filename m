Return-Path: <linux-nfs+bounces-18833-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kE89Ls5ai2ljUAAAu9opvQ
	(envelope-from <linux-nfs+bounces-18833-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Feb 2026 17:20:30 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 5590C11D0D6
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Feb 2026 17:20:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id ACCDF3006685
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Feb 2026 16:20:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFFE231B114;
	Tue, 10 Feb 2026 16:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JGWl5LRN"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CEFF2E7BCC
	for <linux-nfs@vger.kernel.org>; Tue, 10 Feb 2026 16:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770740428; cv=none; b=TlO8bVvThND9uxP2qdlZtuNUr112vu5Y9MVjcxMYOFhce7ulkPAxGuNKxt3Bt4BMIUj6iJENal7m+0aAa7fgr0PX/XhlXYb0QzFx90Zs3q545n23RxPXRWZE+PXOoyJ7SyVN4HwXSZ5Nz2NRC8mkPHATFRHpzRTpoZhXtyuostQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770740428; c=relaxed/simple;
	bh=ZUU+6o0Z7S3ir6OJcZI9IMhntCuIvrOP3jhp7OiNbo4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=k9yQ9Hl1B/44EguVPFzzF7YtLs5PuYdtlzoE4+aqlE4kHuRdeasLWUopUOyC2iA/TMV/t+dOBgPRcVncC/zFsdVbbUnGhCHDBLZLTZtcgbibsntwxFJUXiN37B3RIEe+iachMFo8Yx5yjVZJlZUfeIWa9L8ERMRcyqCYl+wIQgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JGWl5LRN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6595C116C6;
	Tue, 10 Feb 2026 16:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770740428;
	bh=ZUU+6o0Z7S3ir6OJcZI9IMhntCuIvrOP3jhp7OiNbo4=;
	h=From:To:Cc:Subject:Date:From;
	b=JGWl5LRNSnX36/cTCEZ+6vKvqg4DOPzZQv8xtrscF0V6u3ovkP/ThmRDBE1xG4qOa
	 WHI+gclfuscieR74OHlZ0ZuxbHax29fjupCpmSpUZjJxa4MqRRkhdvAyrkQIqv9NLx
	 1XSc664SiJFIN7OYJ0omgNTzvMAoQkeg6/bcq7yedF4FBnLEmTnG3Em4gD6EYFOZ1Z
	 BknBZ1oDtTFjFUQ7NI6ivkiTYQ3UoN3Wz+HgLQsWnr6Fh9PFQsBfaTi2T/5ixJZSGL
	 BbxUZGFOtfzoVm3cdgcwAsFGU1GVxJHKAOleWkpsOsi5O3iM9ZJzIPb2nU5T/pjkb1
	 FO7jdqjwOx03Q==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neilb@ownmail.net>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v2 0/8] sunrpc: Reduce lock contention for NFSD TCP sockets
Date: Tue, 10 Feb 2026 11:20:17 -0500
Message-ID: <20260210162025.2356389-1-cel@kernel.org>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[ownmail.net,kernel.org,redhat.com,oracle.com,talpey.com];
	TAGGED_FROM(0.00)[bounces-18833-lists,linux-nfs=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5590C11D0D6
X-Rspamd-Action: no action

From: Chuck Lever <chuck.lever@oracle.com>

High-throughput NFSD workloads exhibit significant lock contention on
TCP connections. Worker threads compete for the socket lock during
receives and serialize on xpt_mutex during sends, limiting scalability.

This series addresses both paths:

 - Receive: A dedicated kernel thread per TCP connection owns all
   sock_recvmsg() calls and queues complete RPC messages for workers
   via lock-free llist. This eliminates socket lock contention among
   workers.

 - Transmit: Flat combining allows one thread to send on behalf of
   multiple waiters. Threads enqueue requests; the mutex holder
   ("combiner") processes the batch, amortizing lock acquisition and
   enabling TCP segment coalescing via MSG_MORE.

Supporting changes include a page recycling pool for receive buffers,
and explicit TCP buffer sizing for high bandwidth-delay product
networks.

Base commit: v6.19
URL: https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git/log/?h=svctcp-next

---

Changes since RFC:
- Drop the affinity scope patch
- Skip user memory hardening for kernel-to-kernel copies
- Avoid invoking wake_up when the receive is already running
- Refactor svc_tcp_receiver_thread() for legibility
- Do not set MSG_MORE during batched sends

Chuck Lever (8):
  sunrpc: Add XPT flags missing from SVC_XPRT_FLAG_LIST
  net: datagram: bypass usercopy checks for kernel iterators
  sunrpc: split svc_data_ready into protocol-specific callbacks
  sunrpc: add per-transport page recycling pool
  sunrpc: add dedicated TCP receiver thread
  sunrpc: implement flat combining for TCP socket sends
  sunrpc: unify fore and backchannel server TCP send paths
  sunrpc: Set explicit TCP socket buffer sizes for NFSD

 include/linux/sunrpc/svc.h      |   1 +
 include/linux/sunrpc/svc_xprt.h |  32 ++
 include/linux/sunrpc/svcsock.h  |  40 ++
 include/trace/events/sunrpc.h   |   7 +-
 net/core/datagram.c             |  15 +-
 net/sunrpc/svc.c                |  13 +
 net/sunrpc/svc_xprt.c           | 151 ++++++
 net/sunrpc/svcsock.c            | 802 +++++++++++++++++++++++++++++---
 net/sunrpc/xprtsock.c           |  60 +--
 9 files changed, 999 insertions(+), 122 deletions(-)

-- 
2.52.0


