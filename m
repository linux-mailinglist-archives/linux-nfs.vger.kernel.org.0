Return-Path: <linux-nfs+bounces-20872-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id INWfAdwe4WlbpQAAu9opvQ
	(envelope-from <linux-nfs+bounces-20872-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Apr 2026 19:39:40 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 98B71412FD0
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Apr 2026 19:39:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 84C3631AA888
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Apr 2026 17:35:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5493532FA14;
	Thu, 16 Apr 2026 17:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VqknubNt"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C5F9319859;
	Thu, 16 Apr 2026 17:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776360938; cv=none; b=Q1SLMfJny9PKYsJV+WzotYsJMym6J9eYmW5DKSh4hcsPjJBOBp4JSbs7SH9nQSsVJgUXFZfWWejF5S4FnGneEJ5CgcZvNONXGETE7wOXn3FTCuQLFnBQgeN/MuU2kkHgF+WJuWIP1kKSny1q0Bn0TWLrKSzhxZK3BSDzjgvhXO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776360938; c=relaxed/simple;
	bh=ZMJ9Xnu76zh1FcJDGNc7266fgt3wsBrqVQWFIiaQUYw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=rWKD7C5owRi8IY1alD+8hqsqGVxL/KCGG50CnwW7351FAx9LlV5vvEzJRbRouiRdKRFG+z77fZuwwbW5yzIT4NRsghyQh117hi8cKmm3SgP6FIEheudUyd/7HBzwJC7hXrw08VFzo6cf9/KXWHAscyHZNCiOkM4uxGax0G8v38A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VqknubNt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E686C2BCAF;
	Thu, 16 Apr 2026 17:35:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776360937;
	bh=ZMJ9Xnu76zh1FcJDGNc7266fgt3wsBrqVQWFIiaQUYw=;
	h=From:Subject:Date:To:Cc:From;
	b=VqknubNtzXJyFrW5LJK5/SW7UrFUXGe5jZAOHaVNF4rjLa6Jvf++OCn2+wcQ+Roif
	 JKR0Ie4QZbu+/iMxnuagcKN1o5DyzAByGM4Tzq3uqgVAFWkiqfPx2HbQUEoHgMoKtf
	 fk09EgMLMUAIacd4hAAIzz27s6vAfzrn5eI8cSo16YMMtWwK1o4FuHXpLoMRaw7ZlM
	 kQ0NpfkqJUz9H/gS3/ozv5Fm7LZcxRGBR3gvTMgipWheoPgRWaQD/rjyYNO9cpAOUH
	 +C4/xrB62YwgBRYCxK/Vj2Jg+GEWWpnuuEgNdFUz8b3ynVMnO+9qavMNWWMfalZTWw
	 +Z69IULM04xPw==
From: Jeff Layton <jlayton@kernel.org>
Subject: [PATCH v2 00/28] vfs/nfsd: add support for CB_NOTIFY callbacks in
 directory delegations
Date: Thu, 16 Apr 2026 10:35:01 -0700
Message-Id: <20260416-dir-deleg-v2-0-851426a550f6@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/03Myw6CMBCF4Vchs7amFyzoyvcwLCodykRCydQQD
 em7W3Hj8j85+TZIyIQJLtUGjCslinMJfaigH90cUJAvDVpqK40+CU8sPE4YhDFnaa33SqoGyn9
 hHOi1W7eu9EjpGfm906v6rj+lls2fsiohhXODbfu6ad3dXx/IM07HyAG6nPMHwkSrl6MAAAA=
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5741; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=ZMJ9Xnu76zh1FcJDGNc7266fgt3wsBrqVQWFIiaQUYw=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBp4R3hqdkTWiwXaASaUE5C397HFMJi0Kb1Wbq8u
 lcfEsYFK5uJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaeEd4QAKCRAADmhBGVaC
 FWndD/4ijjNk2wDtNM4Tkdzi7aRdevt03CMujpIjxgnmC60xt7VH7o4YNAkZrhwhks+lkUPnc25
 FSCfYmohUC7E1zx4atyJRxp/5sFifcTof7UE7SwDHHm7prz0lYO51i9ZqjXvaBzXEUlZIeSIPGK
 ctP0nbU4Z9/UKiN350wE2KxwRVHPgIb1E+diswe0WYZN9JiZZGb95gF4TD+UyfpjCRS6XDh1Hmo
 qqAaKfj/yHXqgSksYvH3OgAujX7J5/JYBSwp3N7Bxh/4xaNYwMRskDrQAwaSvUa0jGAwWQXWwSU
 ys5Ltdd7adD5BLBHwLh/Ff2AcVXbbSx+QQEOng37u3ew3g+FX3w37YcQtP6DmQRtAvbSdleKwst
 R9lKXKn+Bn7WglFOmRtob96tkSx6Qs5cGr3VDEBK1I1qcf9vQaH2oAsOuriDpvWLHPHuqEJJdxE
 v2rZmMbsVY+7Ey24s4VvYd7z6ST/mmgnKBWTWt/4iobCSSjonlb8S8B3ugpJLBtCz1pUOpja6MT
 cZMZuhwbJPPW2N8D7p+aQDrs9ZaM61Q6nsv3wOZMBoXy8lp/wv3HAJ2KKxaH6a9tk+2sisZ1CFj
 SqmGI/rwo+bmhUDKs4gRMS19WXXhPqXP2JGzQ79n1tfXF18vuTpKAj6lWbB8ic8j2OO7wlF4Us7
 VN5ayZjt7gPUK3g==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20872-lists,linux-nfs=lfdr.de];
	FREEMAIL_TO(0.00)[zeniv.linux.org.uk,kernel.org,suse.cz,oracle.com,gmail.com,goodmis.org,efficios.com,lwn.net,linuxfoundation.org,brown.name,redhat.com,talpey.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 98B71412FD0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This version has a number of significant changes from the last. I
dropped some of the R-b's for this reason.

Of particular interest to the fsnotify maintainers will be the
FSNOTIFY_EVENT_RENAME data type. This combines the FSNOTIFY_EVENT_DENTRY
and FSNOTIFY_EVENT_INODE event types so that the fsnotify event can
additionally send information about a file that was unlinked as a result
of being replaced via rename().

There are also a host of other bugfixes, and a new tracepoint. Please
consider this for v7.2.

Original cover letter follows:

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
 fs/nfsd/nfs4state.c                  | 550 ++++++++++++++++++++++++++++----
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
 29 files changed, 2518 insertions(+), 324 deletions(-)
---
base-commit: f4d71dd7fd9cec357c32431fa55c107b96008312
change-id: 20260325-dir-deleg-339066dd1017

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>


