Return-Path: <linux-nfs+bounces-22690-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id KaH+AMNfNWqOuQYAu9opvQ
	(envelope-from <linux-nfs+bounces-22690-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 19 Jun 2026 17:26:59 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ED5516A6A98
	for <lists+linux-nfs@lfdr.de>; Fri, 19 Jun 2026 17:26:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Jh87h9sb;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22690-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22690-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1311E3008D1D
	for <lists+linux-nfs@lfdr.de>; Fri, 19 Jun 2026 15:26:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E89A53B14CD;
	Fri, 19 Jun 2026 15:26:51 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D26E638333B;
	Fri, 19 Jun 2026 15:26:50 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781882811; cv=none; b=jNqF7qsc8NYHLcozJMIdVqbnI0Gdx1NpbEnQ6OrqI7NQk68HCOBMaRIYGZKLo2BALOm9/2IB3RZ5Ed7TBXnxvg5AjdROE/JcbmxhxppzgfdzbGiXh/HaMY//aT74ywx/DJIqDtiU6bFbradvzoVi5OcX1fOyGq6bmhClIVlCmsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781882811; c=relaxed/simple;
	bh=rvjCKFYkFseMTPydjLjQIWcQI0oexJoeRLq9U5afKNw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=r26fV4wQioGWRBVvQXr2/qlgYMOPHqnHd+Pwu+M0FnkZJox7+U86cI3sSWvcUeCWqNk3YPSOqcHh+fGbGtfCq6z3MntkMwzbA18ja9fF/joYxr6TsQxfadHzXoSbMkFp+URda5uoli5ArR7CtMK6BKJxwm+RGFbSA8EJJkXqjG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jh87h9sb; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 611401F000E9;
	Fri, 19 Jun 2026 15:26:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781882810;
	bh=6h3QbmsQbFQ1r2+0gw9ISDeQbv8yNavrCOXBxqFoZ8c=;
	h=From:Subject:Date:To:Cc;
	b=Jh87h9sb7VXkzcFWHn2f01hNghcfhClx1qOA+xVsHj1BA++NPZGax/TtmIT2RYylr
	 L4QixRXo9jaLAnG5/5NvJVAuhpRzAQ1UuKXMkQf0FoAUleSbRAqvCQeAI4cIiwUApD
	 VCZfbC5KNxFcHKo3m7zctvdxs2tblcER0lvnDUwQFFlqCkoKrZzmhQ/cLj3qZO/1tq
	 NFKvCGOmclUsfg70WJrSe4JoiAE5C+F0KaFMlBdmCGHSJy1VO78JXo3Dqu8Isbyal1
	 de6P+BZ0K5uFLNsySwRK6uWq3knfd7miHHtG3kmPhoS9oLhwby7qulbZKwxFHwd1ta
	 fpBNeHrOMCMGg==
From: Jeff Layton <jlayton@kernel.org>
Subject: [PATCH v6 0/6] nfsd/sunrpc: convert nfsstat server-side interfaces
 to use netlink
Date: Fri, 19 Jun 2026 11:26:35 -0400
Message-Id: <20260619-exportd-netlink-v6-0-ddef3499793c@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3XPwW7CMAwG4FdBOS/IieOs2WnvMXFIGwciUIrSq
 mJCfXcCF0DZjr8lf799FROXxJP42lxF4SVNacw12I+NGA4+71mmULPQoC2gspIv57HMQWaeTyk
 fpRpc7EkTWkZRt86FY7o8xJ9dzYc0zWP5fRQs6j7931qUBGmVpjBY3Tui7yOXzKftWPbiji36C
 dTOFtAVMACAkYMhGBoAn4AF1wJYAe+JoPPU9yo0gHkB/nrBVACQgDwzdh02AL0CXQtQBdh5js5
 8+ojvF6zregNi2a2LswEAAA==
X-Change-ID: 20260316-exportd-netlink-1c9fb52536e3
To: NeilBrown <neil@brown.name>, Olga Kornievskaia <okorniev@redhat.com>, 
 Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, 
 Chuck Lever <cel@kernel.org>
Cc: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
 Steve Dickson <steved@redhat.com>, linux-nfs@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3449; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=rvjCKFYkFseMTPydjLjQIWcQI0oexJoeRLq9U5afKNw=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBqNV+y4elUfYxSPT5pamCALkG6JD//cr8bcVbVe
 BkJ6hRnGjuJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCajVfsgAKCRAADmhBGVaC
 FRs+D/9H4s5tZ3cTmRZZmqYFC4RvxkSUhheQB8uJ4lBEw38ssQYuWs86AefaBOykOI8o2fgg62Y
 pko9zVNayiAQ6EjUJdi2wTTt+44oiBC19wsGNd/JTvnyIUpsvlRzw+osJZNYXZDOqhBSr5rcTk8
 r8rnDm+TSvdKEt9DcUIZP7slZEazMc/7sPdxn17Yi1kE5I7oc1l9OoZ1JcTe0LJ93XorAPZ4a23
 R7+2y7nrHv/h2aRhZTo+Zp+cBc4/Dunb3rs234HCWr/j7dnxcqzQ9UVHTrcPhUfxPkJC3adYTvW
 hh82ZDaKAthgUhViu/Z/AjCre63CRANJSmHLhfd1vVQwW/g33Pd21tMzFHRm+0Wb38TxwSSr26B
 0GFm0EEqvRrptyfRb5uzA7QHvL3l+cQm6uUNmxnGp3SPVJhgDXmdHyiBnmJxj+H2xyJYBk1H1ej
 L2qgCnSQM1aYTXzxhhaRGA8xgHDQofRn1YA9ah5pBQlDhA/C7b0B4wZWdizVgWDadS1gtInusXH
 t9PduwTDN65O4+GrBKIUPG6xU0/4y7NBYXMXdv7jC+oPPrHgKzCWIHYQEHMtBCVPY/jC8H5ap8F
 U9POSHWtNvNVan7itBY5D0Baw+iMUIU/xfrue1MueeV4sJV9LuwNQcflJVYZsSBNeT7JM04sEt6
 t0S8r+YFAGfP9sA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22690-lists,linux-nfs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:neil@brown.name,m:okorniev@redhat.com,m:Dai.Ngo@oracle.com,m:tom@talpey.com,m:cel@kernel.org,m:trondmy@kernel.org,m:anna@kernel.org,m:steved@redhat.com,m:linux-nfs@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:jlayton@kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[linux-nfs];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: ED5516A6A98

This version fixes a few problems that Chuck and Sashiko pointed
out in review.

The nfsstat tool currently scrapes /proc/net/rpc/nfsd for server
statistics. This procfs interface has several limitations: the
counters are global (not network-namespace-aware), the format is
fragile to parse, and it cannot be extended without breaking
existing parsers.

This series adds per-network-namespace procedure call counts to
the sunrpc layer and exposes them through a new netlink handler
in the nfsd generic netlink family, allowing nfsstat to retrieve
server statistics via netlink with a procfs fallback for older
kernels. The nfs-utils patch for that part is already merged.

Additionally, this version adds tracking of callback operation counts.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
Changes in v6:
- Emit the entire server-stats object in a single netlink dump message
- Count CB_SEQUENCE on v4.1+ callbacks, for parity with the forechannel SEQUENCE count
- Fix a use-after-free in nfsd4_run_cb() by snapshotting the opcode, net, and minorversion
- Link to v5: https://lore.kernel.org/r/20260618-exportd-netlink-v5-0-e9aef947af3d@kernel.org

Changes in v5:
- Add NFSv4 callback call counts to nfsstat upcall
- Link to v4: https://lore.kernel.org/r/20260616-exportd-netlink-v4-0-03505aee3883@kernel.org

Changes in v4:
- Ensure error is returned when nla_put_*() calls fail
- Link to v3: https://lore.kernel.org/r/20260609-exportd-netlink-v3-0-aa5508a5bb1d@kernel.org

Changes in v3:
- Only increment per-net stats for the "primary" program
- Link to v2: https://lore.kernel.org/r/20260525-exportd-netlink-v2-0-40003fed450c@kernel.org

---
Jeff Layton (6):
      sunrpc: add per-netns per-procedure call counts to svc_stat
      sunrpc: use per-net counts in svc_seq_show()
      nfsd: implement server-stats-get netlink handler
      sunrpc: remove unused svc_version vs_count field
      nfsd: count NFSv4 callback operations per netns
      nfsd: export NFSv4 callback op stats via netlink

 Documentation/netlink/specs/nfsd.yaml | 111 +++++++++++++++++
 fs/lockd/svc4proc.c                   |   4 -
 fs/lockd/svcproc.c                    |   7 --
 fs/nfs/callback_xdr.c                 |   6 -
 fs/nfsd/localio.c                     |   3 -
 fs/nfsd/netlink.c                     |   5 +
 fs/nfsd/netlink.h                     |   2 +
 fs/nfsd/netns.h                       |  12 +-
 fs/nfsd/nfs2acl.c                     |   3 -
 fs/nfsd/nfs3acl.c                     |   3 -
 fs/nfsd/nfs3proc.c                    |   3 -
 fs/nfsd/nfs4callback.c                |  22 +++-
 fs/nfsd/nfs4proc.c                    |   3 -
 fs/nfsd/nfs4state.c                   |   2 -
 fs/nfsd/nfsctl.c                      | 222 +++++++++++++++++++++++++++++++++-
 fs/nfsd/nfsproc.c                     |   3 -
 fs/nfsd/stats.c                       |   2 +-
 fs/nfsd/stats.h                       |   5 +-
 include/linux/sunrpc/stats.h          |   6 +
 include/linux/sunrpc/svc.h            |   1 -
 include/uapi/linux/nfsd_netlink.h     |  36 ++++++
 net/sunrpc/stats.c                    |   2 +-
 net/sunrpc/svc.c                      |  63 +++++++++-
 23 files changed, 479 insertions(+), 47 deletions(-)
---
base-commit: 6f90c7618528b5ca5887f8c6057f26dcc7a27a99
change-id: 20260316-exportd-netlink-1c9fb52536e3

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>


