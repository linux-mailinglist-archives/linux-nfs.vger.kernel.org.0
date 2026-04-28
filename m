Return-Path: <linux-nfs+bounces-21212-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eC4WOWBd8GlJSQEAu9opvQ
	(envelope-from <linux-nfs+bounces-21212-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Apr 2026 09:10:24 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E868647E7E8
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Apr 2026 09:10:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 946EA300370A
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Apr 2026 07:10:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17E6F399013;
	Tue, 28 Apr 2026 07:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pKhk+L6W"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5B6D346E5A;
	Tue, 28 Apr 2026 07:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777360219; cv=none; b=Q025l4EVMcjx/tE8JbsOno1/n+o6p580zdsnaOkymdSq1QB5sp6E2f0DeJpIb2yjPEJrw1/eb8jLFJO1yfpOksoVe0QailTNfcCIUbbw8BMTdJIMZ7zIRox9nJqRhy26mZiJBawIS/QjDZQkt5Vs1Wj+2R6Ve0skYEbuq0wX1Ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777360219; c=relaxed/simple;
	bh=AmYIhqMveqzQKfRQ+Tso/XDGewsUSIByDx6eftf4/Vw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=uWuaEm5RemKBuhwGkX9i5QHofn59p+aNbUKrsJOC9JisCfJJn4qVOp8bdprmlPQB75U5zVPdmQvnfvcH4tQ7zqitpTjyLzHe8WSeswNhnvO8CRTVwJy5S2JWflq4nieUEwyucuPS00Fb84z1j8+9wzTgijcsL8xob4gXfNHAhXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pKhk+L6W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E67A0C2BCB5;
	Tue, 28 Apr 2026 07:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777360218;
	bh=AmYIhqMveqzQKfRQ+Tso/XDGewsUSIByDx6eftf4/Vw=;
	h=From:Subject:Date:To:Cc:From;
	b=pKhk+L6W9knf/V1b4vj/m7DngqW5ab3qjYiseiIOeflGSJS/CC+T7vJHjH24dehDo
	 VtgjE0dIUc/TJo+/rr+pdWJfRG8m/RYHKgNvaVkJqusCQqMQYQ+RV/oyGBgJ7S7pGJ
	 q1JduBcxOrp11Nw9tRTaP1/BwyDfSyNyhoGjUYOCvjyhSqxuN/nSkC+nEcRFHXLiPD
	 9eil8Hb25lFSToGw2N9eFXtwNiEqNuTAyMx4RONZ6VxLm55+TPTc/2Bg/R9rpN/KuS
	 eqwzPIOUnlm3uJxCEYsXvHQCJYis0tXsogSrLvSrfIcTjDIQ3YIb8DRsVVtN408LWw
	 FK2Jl4uKjutbQ==
From: Jeff Layton <jlayton@kernel.org>
Subject: [PATCH v3 00/28] vfs/nfsd: add support for CB_NOTIFY callbacks in
 directory delegations
Date: Tue, 28 Apr 2026 08:09:44 +0100
Message-Id: <20260428-dir-deleg-v3-0-5a0780ba9def@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/1WMQQ6CMBBFr0K6tmba0gFdeQ/jotIBGgmYqWk0h
 LtbcIPL9/Pfm0UkDhTFuZgFUwoxTGMGcyhE07uxIxl8ZqFBIxhtpQ8sPQ3USWNOgOi9AlWJ/H8
 yteG9ta63zH2Ir4k/Wzqpdf1VSqh2laQkSOdarJuyqt3dXx7EIw3HiTuxZpLeqQr3qs5qbVWp0
 VkLLf6py7J8AWSEhgjeAAAA
X-Change-ID: 20260325-dir-deleg-339066dd1017
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Chuck Lever <chuck.lever@oracle.com>, 
 Alexander Aring <alex.aring@gmail.com>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 NeilBrown <neil@brown.name>, Olga Kornievskaia <okorniev@redhat.com>, 
 Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, 
 Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
 Amir Goldstein <amir73il@gmail.com>
Cc: Calum Mackay <calum.mackay@oracle.com>, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-nfs@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=5576; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=AmYIhqMveqzQKfRQ+Tso/XDGewsUSIByDx6eftf4/Vw=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBp8F1INoeAqKEOdsnNsnGaOqmUtfQ1yWu/eeh+v
 NsM9tZi91iJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCafBdSAAKCRAADmhBGVaC
 FcqvD/99cz9n7VDbUshwQR3u8R9CsITwbjKfXJXjFp/Bs6bbjdyWhurp/T1wHIlMEe8HD3xBx/y
 ogBQFbB8QytByjy5k7bZ2VYglnlKHiZwcGtihNHaByewTxZg/dODFwQeaPuc3+cz5N0R4lpxOZ9
 GTOOGZmZH/sh+tGEq+GKDdITduBS353XVR7EmP5Pn9ftBvbSe/x2ZeAFeixGVWVVC0SdKQZQxsW
 vyN9yC9MhkrGVjVxiAgncA1Vjc2w2BQjkYucaarxBUo9d6JtoYsIIUZH1e/HnpXc72bF+mtdDW3
 Tu+zc9b3oF5ARtEZluDbLQINsVvz/c64ctp6de4a5fI0VCm+j5mJXVn39t2fYAwiTwUhWQeDm9e
 JkNEMF59JLcNsh4sw4WEg40kVY04TVO1QtrUGQiCTUVzmCbrVHeFma7PhUFzTDSfIUcOQHaPOVL
 HehwoAc/6lmJ0yY6hgEPr0vieCcI0KgdqVxhRat6hReqVKZg+OfyunDAVTf7Ra1+zz7K72fCgur
 u7mE4G5sNVkxX8urd5Mx6h1eHaAhRX2q1RYB3KMmNB2fURNq4eAUfFYiGAGeAN2b/gClEffk0eq
 R2bJVzLWcfCUwhdU+Qp4bUmyvbuf8wmLopjd1/CLr9/K+SihbIerEERMucxsW65uB/f65FL5ljB
 LeBQnJ5lZ7PJcww==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Rspamd-Queue-Id: E868647E7E8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21212-lists,linux-nfs=lfdr.de];
	FREEMAIL_TO(0.00)[zeniv.linux.org.uk,kernel.org,suse.cz,oracle.com,gmail.com,goodmis.org,efficios.com,lwn.net,linuxfoundation.org,brown.name,redhat.com,talpey.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

Re-posting the set per Christian's request. The only difference in this
version is a small error handling fix in alloc_init_dir_deleg(). The old
version could crash since release_pages() can't handle an array with
NULL pointers in it.

---------------------------------8<------------------------------------

This patchset builds on the directory delegation work we did a few
months ago, to add support for CB_NOTIFY callbacks for some events. In
particular, creates, unlinks and renames. The server also sends updated
directory attributes in the notifications. With this support, the client
can register interest in a directory and get notifications about changes
within it without losing its lease.

The series starts with patches to allow the vfs to ignore certain types
of events on directories. nfsd can then request these sorts of
delegations on directories, and then set up inotify watches on the
directory to trigger sending CB_NOTIFY events.

This has mainly been tested with pynfs, with some new testcases that
I'll be posting soon. They seem to work fine with those tests, but I
don't think we'll want to merge these until we have a complete
client-side implementation to test against.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
Changes in v3:
- Fix error handling in alloc_init_dir_deleg()
- Link to v2: https://lore.kernel.org/r/20260416-dir-deleg-v2-0-851426a550f6@kernel.org

Changes in v2:
- Fix __break_lease handling with different lease types on flc_lease list
- Add FSNOTIFY_EVENT_RENAME data type to properly handle cross-directory rename events
- Display fsnotify mask symbolically in tracepoints
- New tracepoint in fsnotify()
- Recalc fsnotify mask after unlocking lease instead of before
- Don't notify client that is making the changes
- After sending CB_NOTIFY, requeue if new events came in while running
- Document removal of NFS4_VERIFIER_SIZE/NFS4_FHSIZE from UAPI headers
- Properly release nfsd_dir_fsnotify_group on server shutdown
- Link to v1: https://lore.kernel.org/r/20260407-dir-deleg-v1-0-aaf68c478abd@kernel.org

---
Jeff Layton (28):
      filelock: pass current blocking lease to trace_break_lease_block() rather than "new_fl"
      filelock: add support for ignoring deleg breaks for dir change events
      filelock: add a tracepoint to start of break_lease()
      filelock: add an inode_lease_ignore_mask helper
      fsnotify: new tracepoint in fsnotify()
      fsnotify: add fsnotify_modify_mark_mask()
      fsnotify: add FSNOTIFY_EVENT_RENAME data type
      nfsd: check fl_lmops in nfsd_breaker_owns_lease()
      nfsd: add protocol support for CB_NOTIFY
      nfs_common: add new NOTIFY4_* flags proposed in RFC8881bis
      nfsd: allow nfsd to get a dir lease with an ignore mask
      nfsd: update the fsnotify mark when setting or removing a dir delegation
      nfsd: make nfsd4_callback_ops->prepare operation bool return
      nfsd: add callback encoding and decoding linkages for CB_NOTIFY
      nfsd: use RCU to protect fi_deleg_file
      nfsd: add data structures for handling CB_NOTIFY
      nfsd: add notification handlers for dir events
      nfsd: add tracepoint to dir_event handler
      nfsd: apply the notify mask to the delegation when requested
      nfsd: add helper to marshal a fattr4 from completed args
      nfsd: allow nfsd4_encode_fattr4_change() to work with no export
      nfsd: send basic file attributes in CB_NOTIFY
      nfsd: allow encoding a filehandle into fattr4 without a svc_fh
      nfsd: add a fi_connectable flag to struct nfs4_file
      nfsd: add the filehandle to returned attributes in CB_NOTIFY
      nfsd: properly track requested child attributes
      nfsd: track requested dir attributes
      nfsd: add support to CB_NOTIFY for dir attribute changes

 Documentation/sunrpc/xdr/nfs4_1.x    | 264 ++++++++++++++-
 fs/attr.c                            |   2 +-
 fs/locks.c                           | 118 +++++--
 fs/namei.c                           |  31 +-
 fs/nfsd/filecache.c                  |  70 +++-
 fs/nfsd/nfs4callback.c               |  60 +++-
 fs/nfsd/nfs4layouts.c                |   5 +-
 fs/nfsd/nfs4proc.c                   |  17 +
 fs/nfsd/nfs4state.c                  | 551 ++++++++++++++++++++++++++++----
 fs/nfsd/nfs4xdr.c                    | 323 +++++++++++++++++--
 fs/nfsd/nfs4xdr_gen.c                | 601 ++++++++++++++++++++++++++++++++++-
 fs/nfsd/nfs4xdr_gen.h                |  20 +-
 fs/nfsd/state.h                      |  72 ++++-
 fs/nfsd/trace.h                      |  23 ++
 fs/nfsd/xdr4.h                       |   5 +
 fs/nfsd/xdr4cb.h                     |  12 +
 fs/notify/fsnotify.c                 |   5 +
 fs/notify/mark.c                     |  29 ++
 fs/posix_acl.c                       |   4 +-
 fs/xattr.c                           |   4 +-
 include/linux/filelock.h             |  54 +++-
 include/linux/fsnotify.h             |   8 +-
 include/linux/fsnotify_backend.h     |  21 ++
 include/linux/nfs4.h                 | 127 --------
 include/linux/sunrpc/xdrgen/nfs4_1.h | 291 ++++++++++++++++-
 include/trace/events/filelock.h      |  38 ++-
 include/trace/events/fsnotify.h      |  51 +++
 include/trace/misc/fsnotify.h        |  35 ++
 include/uapi/linux/nfs4.h            |   2 -
 29 files changed, 2519 insertions(+), 324 deletions(-)
---
base-commit: f4d71dd7fd9cec357c32431fa55c107b96008312
change-id: 20260325-dir-deleg-339066dd1017

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>


