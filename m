Return-Path: <linux-nfs+bounces-22602-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id a5/pOjU8MWqSegUAu9opvQ
	(envelope-from <linux-nfs+bounces-22602-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Jun 2026 14:06:13 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9979B68F16D
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Jun 2026 14:06:13 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=XVURTfvx;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22602-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22602-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D048A318B0D3
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Jun 2026 11:59:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E83543D4E9;
	Tue, 16 Jun 2026 11:59:08 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AEE843D513;
	Tue, 16 Jun 2026 11:59:06 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781611148; cv=none; b=rabxqhvxGJZ0/Vub5E/afg9Ofcc9FEzYbDQjY7qnipVgHE6YveI8QyMfECK3HcYxJ8R590wCEYMvCRL+fKSR4vu6nnl01jrzSLn0hW4BJNZgeM+1vRyN4659QYS1hrpZn++ov3ZLvBvAufPdevqhkCU+nJoCBB1kU8MNpD6ZZIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781611148; c=relaxed/simple;
	bh=E4i48rrivnh7w1RXtqoUURH1R8BxQSt/ufLzraI71ck=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=nuDh0VKNKyzmMf7RFD0m4/8l9hPSY0895DMpJ7QSWIIQudTkrr5YDSDfwJkxLH7VhzwSq6nIDcXfVww9b5zpzplWYegwzVhvq1v7YC9BQ78LALwzuqVnPf+d77lc+BJNkRrvvTboKhfgrd+o7EbPk9YP2aepsIVutzpsQ40eXyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XVURTfvx; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CC2F1F000E9;
	Tue, 16 Jun 2026 11:59:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781611146;
	bh=D9Jf2xUbfYk9mtvc5yyUIb20L5JZOdqYsYTUac+NmSM=;
	h=From:Subject:Date:To:Cc;
	b=XVURTfvxPqnQDitW0gGXncfyJFrleYlmYabtsgB/CDJXGyVzpXxYA1lxYy0dHaCym
	 2F+B18EpDFYveN93Tyt7HvCUm9yyJwh7/h+uijvvGYVeisJb1pCI16AfowwSRakjm3
	 OpjoFfCfWYot/g1TgYvmTT9nLstNY6r6haGPkKXNPgjmoTZ5r0PNUO5Q5Dr0rumOVR
	 4MTU+QK/5h8hhEh+KyHFBv/n2SYos2OYjdggz01pDV5YTR9um4bVjlENReAb6kKUNt
	 kRMYXNEBAFOSpwHbqbcS8XQZdb09Pi3QsRb4zCmug5yvlaVlSuLaXYnI3MSj3Rs9Dl
	 +GvEr9eNiFGIg==
From: Jeff Layton <jlayton@kernel.org>
Subject: [PATCH v7 00/20] nfsd: add support for CB_NOTIFY callbacks in
 directory delegations
Date: Tue, 16 Jun 2026 07:58:43 -0400
Message-Id: <20260616-dir-deleg-v7-0-6cbc7eac0ade@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3XOwW7DIAwG4FepOI/JGDB0p73HtAMBk6JVTUWma
 FOVdx/pDmWKdvwtf799EzPXwrN4OdxE5aXMZbq04J4OIp7CZWRZUssCAQk0WplKlYnPPEqtj0C
 UkgLlRNu/Vs7l69719t7yqcyfU/2+Vy9qm/62GHBdy6IkyBAy+WicD0N6/eB64fPzVEex1SzYU
 UU9xUa9VQYpWAuZdlR3FH1PdaM2gPMwhGPivKPmQS1iT02jGOLgvQ6Rhrij9l9qt6sGY0o5JOv
 2D9ODklI9pUZNNBY8sM3678Pruv4A2RN9qsoBAAA=
X-Change-ID: 20260325-dir-deleg-339066dd1017
To: NeilBrown <neil@brown.name>, Olga Kornievskaia <okorniev@redhat.com>, 
 Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, 
 Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Chuck Lever <cel@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, 
 Alexander Aring <alex.aring@gmail.com>, Amir Goldstein <amir73il@gmail.com>, 
 Jan Kara <jack@suse.cz>, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, 
 Calum Mackay <calum.mackay@oracle.com>, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-nfs@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=5909; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=E4i48rrivnh7w1RXtqoUURH1R8BxQSt/ufLzraI71ck=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBqMTp+5AzViIkX93MBqKnibvmYfCJmbZNox6N4e
 93BOJ3EogqJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCajE6fgAKCRAADmhBGVaC
 FUQ/D/98/uKb2Qr5xSQiRDryJnaryLc0NngvjcwUEkIpJ+UbZEHzytf2CkvoGeFCp9JN+nAmRqy
 jDYBWgjtazRRozfigzr6mtkdTVm/3zMeIiTMaYZVGExXq8V+WO21hzkNNq0pD3OGIQqe2cqtGRB
 DTDZsDbI/otRANNg3DG0kLryltHHbtGxSigoccE88l47jWBF+s013EBELviC8EdyT4oUtkWET8d
 96R2AjLOSty9T5B36Cku/rdEblRBhV+5smSSO86eRGBuzfW1xevMd3Kg+am8zAO3PGyh/h+qzaM
 KardqI6d/exYERNXR4jI/1AFVRqeEeI9FH+XldcUaa31EDvLx+tE/Tnzyrr6XHpIX09hvmSg5ne
 RJFcwiq/unna8MRByv/Knzz1795PniO75X1eQt0tMDgIh9apUh0JGS6GUEGxb5H0YYVVRvh4JOp
 B81EulC1Ax6fRVNA0KxNhScTsIj7t3xVC22CHe2wwyBxD1YXNx2/i7Qb/LvW/3N/LBgHSejqrAE
 cAx8Lxw1UsZcg18KEqdG6OXANj3eYp5lp86/kn5iKlwNIdvDLT7yUMHBXD8Y6xoXmMe0xazFFFP
 JyMkmCkJyKVOuFX+tDYA23jUYay5b0pfNtUP2wZlOdIe1lo7IEPVKIyka6cb36SSRgak5PYGxut
 ZsF/N8Fu/tFrUFw==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-22602-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:neil@brown.name,m:okorniev@redhat.com,m:Dai.Ngo@oracle.com,m:tom@talpey.com,m:trondmy@kernel.org,m:anna@kernel.org,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:cel@kernel.org,m:rostedt@goodmis.org,m:alex.aring@gmail.com,m:amir73il@gmail.com,m:jack@suse.cz,m:viro@zeniv.linux.org.uk,m:brauner@kernel.org,m:calum.mackay@oracle.com,m:linux-kernel@vger.kernel.org,m:linux-doc@vger.kernel.org,m:linux-nfs@vger.kernel.org,m:jlayton@kernel.org,m:alexaring@gmail.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[20];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	FREEMAIL_CC(0.00)[goodmis.org,gmail.com,suse.cz,zeniv.linux.org.uk,kernel.org,oracle.com,vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9979B68F16D

This version of the patchset fixes up yet more problems that Sashiko
and Chuck flagged during review. Progress!

Please consider for v7.3. Original cover letter follows:

---------------------------------8<------------------------------------

This patchset builds on the directory delegation work we did a few
months ago to add support for CB_NOTIFY callbacks for some events. In
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
Changes in v7:
- Fixes for several bugs that Chuck pointed out in review
- Dropped fi_connectable flag (no longer needed with stid->sc_export)
- Ensure FH signing is done properly on returned filehandles
- Link to v6: https://lore.kernel.org/r/20260611-dir-deleg-v6-0-4c45080e5f3f@kernel.org

Changes in v6:
- fold earlier fix series into their respective patches
- tighten up RCU handling on fi_deleg_file
- move nfsd_fsnotify_recalc_mask() to filecache.c
- encoding failure now triggers deleg recall
- take snapshot of new dentry name when creating event
- Link to v5: https://lore.kernel.org/r/20260522-dir-deleg-v5-0-542cddfad576@kernel.org

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
Jeff Layton (20):
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
      nfsd: apply the notify mask to the delegation when requested
      nfsd: add helper to marshal a fattr4 from completed args
      nfsd: allow nfsd4_encode_fattr4_change() to work with no export
      nfsd: send basic file attributes in CB_NOTIFY
      nfsd: allow encoding a filehandle into fattr4 without a svc_fh
      nfsd: add the filehandle to returned attributes in CB_NOTIFY
      nfsd: fix reply size estimate for GET_DIR_DELEGATION
      nfsd: properly track requested child attributes
      nfsd: track requested dir attributes
      nfsd: add support to CB_NOTIFY for dir attribute changes

 Documentation/sunrpc/xdr/nfs4_1.x    | 258 ++++++++++++++-
 fs/nfsd/filecache.c                  | 122 ++++++-
 fs/nfsd/filecache.h                  |   3 +
 fs/nfsd/nfs4callback.c               |  94 +++++-
 fs/nfsd/nfs4layouts.c                |  10 +-
 fs/nfsd/nfs4proc.c                   |  30 +-
 fs/nfsd/nfs4state.c                  | 597 ++++++++++++++++++++++++++++++----
 fs/nfsd/nfs4xdr.c                    | 330 ++++++++++++++++---
 fs/nfsd/nfs4xdr_gen.c                | 600 ++++++++++++++++++++++++++++++++++-
 fs/nfsd/nfs4xdr_gen.h                |  17 +-
 fs/nfsd/nfsd.h                       |   9 +-
 fs/nfsd/nfsfh.c                      |  30 +-
 fs/nfsd/nfsfh.h                      |   3 +
 fs/nfsd/state.h                      |  84 ++++-
 fs/nfsd/trace.h                      |  24 ++
 fs/nfsd/xdr4.h                       |   5 +
 fs/nfsd/xdr4cb.h                     |  12 +
 include/linux/nfs4.h                 | 127 --------
 include/linux/sunrpc/xdrgen/nfs4_1.h | 290 ++++++++++++++++-
 include/uapi/linux/nfs4.h            |   2 -
 20 files changed, 2362 insertions(+), 285 deletions(-)
---
base-commit: 332e2f4f37b213f231be1ab5ddc17e2052383b60
change-id: 20260325-dir-deleg-339066dd1017

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>


