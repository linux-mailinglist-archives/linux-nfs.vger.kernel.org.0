Return-Path: <linux-nfs+bounces-21781-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +E9ULAFREGrgWAYAu9opvQ
	(envelope-from <linux-nfs+bounces-21781-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 22 May 2026 14:50:09 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A887F5B477A
	for <lists+linux-nfs@lfdr.de>; Fri, 22 May 2026 14:50:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 70B9E302DC44
	for <lists+linux-nfs@lfdr.de>; Fri, 22 May 2026 12:29:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1605B27E045;
	Fri, 22 May 2026 12:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b0cK8M3k"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD20B366561;
	Fri, 22 May 2026 12:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779452950; cv=none; b=MV08GT4RHNoEE/6FWY1QDGnZpS91ixrEEzX889nmJw43lnyNTxgFqQOin0Q0wy4Pw63PhI7Np7xrXtNRmWWLVVh/fC+PswgM6rx+AUaE/n/KEGIGZB2Kyjs0TuHWeoaZymGQbm1VGfvM5Um632CJh3l0DjAIHM5vOA6OvksUHeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779452950; c=relaxed/simple;
	bh=lNl5z5Ma6sw3hy9wxYDtRfRMvNqdHbsms0LARkyN/Vk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=cbz81+aTV2LBcv1FMgsdrmi5Dm6RwYyXQQuI99yQygXP5v4dGuWAGv3CNSVgpKSfP0J+p7PL3ig7JVrPSUxgP2YGI/kxUzr9LXIMw9n73QKZGF1CfdzKC+wkrQqihZFg7vs6Cjmv6vfWr26uw0lP1aIJbNEujDabecWdaWCAAMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b0cK8M3k; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B35E41F000E9;
	Fri, 22 May 2026 12:29:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779452949;
	bh=L++/Km9f2VRc7WBIAbz9ObbGOE3nnDdseAVYye60ct8=;
	h=From:Subject:Date:To:Cc;
	b=b0cK8M3kmmBpLrbgzK8p5ovQMmYPSp2CtSbz5VmofrqqkmYY7fULgnFSSU7hlm4D/
	 SfBixBl74wV7aXt8jJcCK8HTpSyf0yubpKxyJjNEKftehSYu4iH6mU7E0UMZtQWDBf
	 QvTK8V6zSba/GRT5TnMxk4Uls/ri0bXoTNctRPyuMfL/d6ZEodinad4fJLofuKSxY5
	 MB9FvhgdVOdRpAOBjNwsPUT48KrKEnYCRNZ572EdkpC7EPUa+Jp6cB6AEdLl2rNvez
	 Uuieg7zY4pQJca9vvNUWwR9+p/9eaVUpBqxiNXNDYMpG4GPEseU8tlaIcPaI3JIcFL
	 nhnMd2HJawyoA==
From: Jeff Layton <jlayton@kernel.org>
Subject: [PATCH v4 00/21] nfsd: add support for CB_NOTIFY callbacks in
 directory delegations
Date: Fri, 22 May 2026 08:28:49 -0400
Message-Id: <20260522-dir-deleg-v4-0-2acb883ac6bc@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/2XMTQ6CMBCG4auYrq2Z/hdX3sO4KHSARgKmNURDu
 LsFNzUuv8k870ISxoCJnA8LiTiHFKYxD3k8kKZ3Y4c0+LwJB65BcEV9iNTjgB0VogKtvWfADMn
 /j4hteO2t6y3vPqTnFN97embb9VuRYIrKzChQ51ptG2msq/3ljnHE4TTFjmyZmReU6ZLyTK1ik
 munFLT6j4qCcltSkalyYCzUrvLY/tB1XT+QnZKRGQEAAA==
X-Change-ID: 20260325-dir-deleg-339066dd1017
To: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>, 
 Anna Schumaker <anna@kernel.org>
Cc: Alexander Aring <alex.aring@gmail.com>, 
 Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, 
 Calum Mackay <calum.mackay@oracle.com>, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-nfs@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>, 
 "Steven Rostedt (Google)" <rostedt@goodmis.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=4678; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=lNl5z5Ma6sw3hy9wxYDtRfRMvNqdHbsms0LARkyN/Vk=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBqEEwMAHM+1AXUDxeKkCwsIYxDTOoteZ/QAd2CK
 vK0JwQJRU+JAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCahBMDAAKCRAADmhBGVaC
 FQLqEACxeIAVSzomJ3fMrLueJ9v3uBCMK/cGRmqZXvD1+eqqs8CIJ3yA9Ku95S+cansiTOlFswT
 eDzKyiafMB8/486rS6F7luGOYG3f/0PHIJIfOPgFLsVSJS+swXJU557/zIrGqmwCinbL5mN91V9
 hhhbk8vRgiz/7smWphtchcet43y1huwjCp9jT2nsSTbrdyrueWoWsAgHtXoWj+4YwYbJDGy+G/x
 wQgKmQVSf5EmeNQR73yV4UHWIPAWwmjWpBmQEsYeJ3G5+2YbggpsfgtmbSgigfe3nGtFzmcU7jA
 nOfqxv1uvqwcb41TeUf56uaBSGkTeFln8myy+QEkdXqZx7DvwyK1/PELJAnfG43Ho1Kai7KrYa7
 ms47dLl2TzIc7fTZibPWzjI3SMEo6fPka9cZ4Tn1lJcEZxdTABV/GSXm5dnqSlHzMqurmNSFIiy
 cbI9TvjKkMwDd76BA4J33g6qfLphpfuP6WpP/eCfAsW0mQ254bIF0dl7qw7gFFqFwchKxwShIg8
 RKtFbSuLygo0oROe1rL22MPNL3DYY7Wrewomk+DqsRRD7aZyvNq1lkRDBqhCAD2uN2laNuMOQJQ
 vwHpqpLdLa2EpZuJZoizupNOvLqQnjzxA6bjvjocLY5Q0ArX84fLe/vtZSCrbjay2BfF/jggU8y
 wSFd3aod9B4ptkw==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21781-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,suse.cz,zeniv.linux.org.uk,kernel.org,oracle.com,vger.kernel.org,goodmis.org];
	RCPT_COUNT_TWELVE(0.00)[18];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: A887F5B477A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This repost is just a rebase of the series on top of Chuck's
nfsd-testing branch. That branch is now based on Christian's
v7.2.directory.delegations branch, so this part contains the nfsd
bits.

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
 fs/nfsd/nfs4state.c                  | 551 ++++++++++++++++++++++++++++----
 fs/nfsd/nfs4xdr.c                    | 324 +++++++++++++++++--
 fs/nfsd/nfs4xdr_gen.c                | 601 ++++++++++++++++++++++++++++++++++-
 fs/nfsd/nfs4xdr_gen.h                |  20 +-
 fs/nfsd/state.h                      |  72 ++++-
 fs/nfsd/trace.h                      |  23 ++
 fs/nfsd/xdr4.h                       |   5 +
 fs/nfsd/xdr4cb.h                     |  12 +
 include/linux/nfs4.h                 | 127 --------
 include/linux/sunrpc/xdrgen/nfs4_1.h | 291 ++++++++++++++++-
 include/uapi/linux/nfs4.h            |   2 -
 16 files changed, 2184 insertions(+), 260 deletions(-)
---
base-commit: 33e9ab952a864ae00bce7e47c3e9add1c4b3d3a3
change-id: 20260325-dir-deleg-339066dd1017

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>


