Return-Path: <linux-nfs+bounces-21815-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CO5QGFayEGpWcgYAu9opvQ
	(envelope-from <linux-nfs+bounces-21815-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 22 May 2026 21:45:26 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F394B5B9949
	for <lists+linux-nfs@lfdr.de>; Fri, 22 May 2026 21:45:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 99BC3300B06D
	for <lists+linux-nfs@lfdr.de>; Fri, 22 May 2026 19:42:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECCA535DA7B;
	Fri, 22 May 2026 19:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZH5nDMZK"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2F3937B02A;
	Fri, 22 May 2026 19:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779478951; cv=none; b=dPP+s4l7COhgyHcYUHNZ+gvxIAqOV88PclnKQwU3/QuCCP4np+tfDqjuLZtEttWWjgROo7vPNSy3ZdxRmPJu8KruC2l4vG7tBTg63moDaoYqyloUnqS/VeNX5sKLL3nzbQqZ9E8MNzF8hQdxUiy1lleFPuBBX1gvdXECRcCpQFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779478951; c=relaxed/simple;
	bh=V/3jhDz9yvHhQjNMKc+GJplMK6oBdfcHdQYxFI1Vp5A=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=tExZXFZHtjFCNODbK++dFfuBYTuJVnsjXqJUK6n2UUjSndZSh2/OrNALphhrTxjb32cnW/jZkTzDPxxmhED6rrbqJ/kaZa82N+B97+/P0vwHkbZP+abaTbH/38ziONdQZPBuhhXZ54IbEytJ+8lKPi56AEawbFgcaCqQV/SX/jE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZH5nDMZK; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 558CD1F000E9;
	Fri, 22 May 2026 19:42:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779478950;
	bh=DCGzkA15CbTvWIyqNJ41qlbMg7gM/6JHQ5Rz7k1eBYA=;
	h=From:Subject:Date:To:Cc;
	b=ZH5nDMZK2/FbEqeIClZCS0im8yljug/Q9FjP8vhPsfEgf8RWp3rky3yTk19NGoN1B
	 ZBw4zl0J0unpzUKAl2Vvttk3vcceOdDvfdeo2rmQejM19mKkofV4yNImiP0N39KMwt
	 48N5P8dGOzXdV8cU3EhW2BnfgT/C+E26lnxhtqbZdlPRzcQ/WFORffyS9UUN9KA1s5
	 edUeo4uiBNrI+3YqGabmoq3e2aVJkMzEMXZ/fIDqrA6zzXhyzcx6AIIwynLJzneGCH
	 MGwlqnNB5CpX8XIvL9A2GbvoTpMY/bHsBRj5CXlVyPNLL6jFjwLiW3iMWESm4cRYPk
	 easrqlut8bV+Q==
From: Jeff Layton <jlayton@kernel.org>
Subject: [PATCH v5 00/21] nfsd: add support for CB_NOTIFY callbacks in
 directory delegations
Date: Fri, 22 May 2026 15:42:05 -0400
Message-Id: <20260522-dir-deleg-v5-0-542cddfad576@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/2XMTW7CMBCG4asgr2s0Hv/EsOIeqIuJPUmsogQ5K
 AKh3L2GLmqU5Tea532KmXPiWRx3T5F5SXOaxjLs106EgcaeZYplCwR0oNHKmLKMfOFean0A52J
 UoBpR/q+Zu3R/t87fZQ9pvk358U4v6nX9qxhoqsqiJEiizvlgGk9tPP1wHvmyn3IvXpkFK6pcT
 bFQb5VBR9ZC5zZUVxR9TXWhlqDx0NIhcreh5p9axJqaQpFC672m4NrwQdd1/QV5j31QVAEAAA=
 =
X-Change-ID: 20260325-dir-deleg-339066dd1017
To: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>, 
 Anna Schumaker <anna@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, 
 Alexander Aring <alex.aring@gmail.com>, Amir Goldstein <amir73il@gmail.com>, 
 Jan Kara <jack@suse.cz>, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, 
 Calum Mackay <calum.mackay@oracle.com>, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-nfs@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=5050; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=V/3jhDz9yvHhQjNMKc+GJplMK6oBdfcHdQYxFI1Vp5A=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBqELGXLuS86Ajj7BoYNWeQ52gEVUq+k1Mv49BDO
 KobZnNRcyuJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCahCxlwAKCRAADmhBGVaC
 FYeXEACONGN/ypBxRvyJ7xKwk825vPnTISF71Dn/1JY8jl9o59WxGBYN4iQTdIdM3WKcyQ4mV1p
 pcTgiEdhUqiWuvzsArYXQnFhhMk0cWPYBDpbBea8YPuXcEJdI1eUIX23k24Q+70vMbxmeIemOxB
 J+U/XBo4v/whrzAzayqbvlavDkoI76PfDdHfut2x9DbnWS9T4G0JOunsP8T9nh+siVvIAREfzu8
 On+ltHpJQ1Hup9MfFSjtjHJclLVzIW2bolCwZzDaNV++6V1r23wub1H61xQxTwaCaxCaQ3gwNm5
 psUmWE3qJ4rcDTPigXxCArRT8QPEnGIQw66WQdpKcUiJE/12ezJIuNL/pOwOSyqlpYu1EVIgb5n
 gUFn8BxHxBW/d4ElvFKuUDrNxrR6PFZX2l+fCOGFb8QKc8ssS4YZLSW6N1xFJpeJUEL/0oFATFX
 YxhwPA8eBZA/s1nzQJ9UzRSLtwmbDa6I3ovUYhs6L3SyWfgt1DMcrpxl4ud6NvRmJRGy2iKFESP
 tomeRXcqhXGhrgqh8w8mEhlBr9SUEutK1njvwbcp+2y7y19i5/fz/GWrd8jkAAXXxT3ogeRWtR4
 p5IGZ53Cvh+yAN+XC9W6XCve9BUTscIB7+7LMk+cDzM3K49oHTaPAJeuG+FRL8I4HSIAuf/s9TU
 HbRf+VXG3tZ+ePw==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21815-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[goodmis.org,gmail.com,suse.cz,zeniv.linux.org.uk,kernel.org,oracle.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[20];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: F394B5B9949
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This version of the patchset fixes up some problems that Sashiko flagged
during review.

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
Changes in v5:
- properly free dir delegation when alloc_pages_bulk() fails
- handle nfsd_file with no mark in nfsd_fsnotify_recalc_mask()
- nfsd_get_dir_deleg() should use stable nf pointer instead of
  depending on fi_deleg_file
- use GFP_NOFS in alloc_nfsd_notify_event() since it's called with locks
  held
- nfsd_handle_dir_event() tracepoint now handles NULL pointers safely
- Link to v4: https://lore.kernel.org/r/20260522-dir-deleg-v4-0-2acb883ac6bc@kernel.org

Changes in v4:
- Rebase onto Chuck's nfsd-testing branch. Minor contextual fixups.
- Link to v3: https://lore.kernel.org/r/20260428-dir-deleg-v3-0-5a0780ba9def@kernel.org

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
Jeff Layton (21):
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
 fs/nfsd/filecache.c                  |  70 +++-
 fs/nfsd/nfs4callback.c               |  60 +++-
 fs/nfsd/nfs4layouts.c                |   5 +-
 fs/nfsd/nfs4proc.c                   |  17 +
 fs/nfsd/nfs4state.c                  | 554 ++++++++++++++++++++++++++++----
 fs/nfsd/nfs4xdr.c                    | 324 +++++++++++++++++--
 fs/nfsd/nfs4xdr_gen.c                | 601 ++++++++++++++++++++++++++++++++++-
 fs/nfsd/nfs4xdr_gen.h                |  20 +-
 fs/nfsd/state.h                      |  72 ++++-
 fs/nfsd/trace.h                      |  24 ++
 fs/nfsd/xdr4.h                       |   5 +
 fs/nfsd/xdr4cb.h                     |  12 +
 include/linux/nfs4.h                 | 127 --------
 include/linux/sunrpc/xdrgen/nfs4_1.h | 291 ++++++++++++++++-
 include/uapi/linux/nfs4.h            |   2 -
 16 files changed, 2188 insertions(+), 260 deletions(-)
---
base-commit: 33e9ab952a864ae00bce7e47c3e9add1c4b3d3a3
change-id: 20260325-dir-deleg-339066dd1017

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>


