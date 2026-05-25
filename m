Return-Path: <linux-nfs+bounces-21916-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yMAWKe9CFGqmLQcAu9opvQ
	(envelope-from <linux-nfs+bounces-21916-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 25 May 2026 14:39:11 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EAFD5CA975
	for <lists+linux-nfs@lfdr.de>; Mon, 25 May 2026 14:39:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1A4763004D26
	for <lists+linux-nfs@lfdr.de>; Mon, 25 May 2026 12:39:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3846381AE0;
	Mon, 25 May 2026 12:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kuk7YWnU"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0D843770B;
	Mon, 25 May 2026 12:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779712739; cv=none; b=dfc9uF+q/c2QOChx1u8bZENaRbvgIYk6s46JRoZRsPcMhYkp760tqNZS00ui0+XryZ9Yqsd1ryQXmV2ItGXS2jL5g3jm5+Cf8F8avhflTHMkMvSMHu3IgV7YKNAU68hgT3mxZIy9I8R4bwyR+Tf9Nc0O+GWMXtkb+AKJDjr/3k0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779712739; c=relaxed/simple;
	bh=qJevWjhUpwFMhmq63XR9DqZRc+HAf2aq6b3ndw1s8cQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=O3d+QQiuTBpxEKwhD3hh7XgBW5m4ekD4pttzkE6yKkoC/HnCkeu7uwaF9Wz90tl9L/uju2JyvCtguWdpBOPeD6rPSB7R3BUSaQF1QZmTSUg9oySBk73yW0+yr7Cwp0wj4iozAQgBLJBgQHsJqiHEHX2rfHJy4I+mx352ZLdqVhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kuk7YWnU; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66F291F00A3A;
	Mon, 25 May 2026 12:38:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779712738;
	bh=8lgb9Ngn5FdzHWyrcZVupSqGIGO/Ib2PndiFN45dwAo=;
	h=From:Subject:Date:To:Cc;
	b=kuk7YWnUeM/nCIXwrG2F9OmYPh0gFcDusHjnCddvMKoBkFXoa4ij/AI8LM3/xX56y
	 kHMNq4j2FiYH4p9Fi/LGqTWand4e9je6rT2BnnFyyhDCJnZMPhCUFeeIzAkjeMTOi1
	 14/squkc6yNk398ncpb2wiT4YhUDKD7T4c1Lh7G2PSZX6StrTwrv8bbtkiNKXQ1DZk
	 /E6Up/bI5jSJC7zqpk2iKIVVbu/0Zs0VD1+lhjwoDtUhnYjfKIxUZFwVwgEqAw19wB
	 V18Cm468n/52EBn4XEyvpsd7OIqV8w7Xt4PKC/6qAioQwDAZTI49/jDwIHECZq5pvQ
	 nwntsdkq3TV1A==
From: Jeff Layton <jlayton@kernel.org>
Subject: [PATCH v2 0/4] nfsd/sunrpc: convert nfsstat server-side interfaces
 to use netlink
Date: Mon, 25 May 2026 08:38:46 -0400
Message-Id: <20260525-exportd-netlink-v2-0-40003fed450c@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3WNQQqDMBBFryKzbopJSMCueo/ioiajDkoikxAs4
 t2buu/yPfjvH5CQCRM8mgMYCyWKoYK6NeDmd5hQkK8MqlW21dIK3LfI2YuAeaWwCOm6cTDKaIs
 a6mpjHGm/iq++8kwpR/5cB0X+7P9WkaIVVirjnVVDZ8xzQQ643iNP0J/n+QVmXzhKrwAAAA==
X-Change-ID: 20260316-exportd-netlink-1c9fb52536e3
To: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>
Cc: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
 Steve Dickson <steved@redhat.com>, linux-nfs@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2732; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=qJevWjhUpwFMhmq63XR9DqZRc+HAf2aq6b3ndw1s8cQ=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBqFELg+qRtwtIxgosv+Rm0xXn9r9+NrXdVuHfTK
 8Lpl/Sk7fOJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCahRC4AAKCRAADmhBGVaC
 FfqKD/93kQw9x2K3LTfPuvjkZjWjKvUaWS0qPB8DSb7RVzZwhBkkhCiADQzqf1O13TcTHaba8Hu
 5WW04yuoC+TaADDnSxmUysONVNraWJVAac9kjRgvxoNyBqIbkLLkvu3xHzAY6W9sOuuqgsy/ywg
 HDqDGXhWZI6UXpCDEfaPvb6BJ5CDwuAKGYQmmQ4JopTeBjiRcZUkHtuGnvpDKvOSfvI7oVqmvcm
 H1wk96jXbn7swbDxM4w8wZ4SAnDyv9fyDjpx9vgM1mEqNWjroUummtL511MiSrQEgdV1WGfga0D
 la5lJxEWJoLJK5XPklJsc8fkJowfosqogMVbUvQAjoFojvYtvSNQ4mb5rVO0AAQx26U/R7rOQb2
 e0uxmiDEjllk6rcLS4TPPZhSOzjaAJrbrwB7eo8L5gOHBWMg97C2m/9PogCfyzfgFB0/5IDdtxl
 rKLIZJ8HlkYZtYG1RwFt7gLW1nt/wHBydx9wJCrfBXwUdr+licxTV8QOQyz6IiQdiqafwZ0ghMv
 +Dc47Pt2hzTtQusDjDE/0Y6CGRiNTaXXrwdqfVWGsVldGe0WOEOhchjYHDlz32xU0/XtHipcqJQ
 aQqu3NT6DJcTfJPcyMYDOyeEYRv79KDQfGxnn+0Q6kMO87Edt4kbPpZKjBokUZ7uMAYhW1afIcC
 OKDUHmKOQHQXq9g==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21916-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 9EAFD5CA975
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The nfsstat tool currently scrapes /proc/net/rpc/nfsd for server
statistics. This procfs interface has several limitations: the
counters are global (not network-namespace-aware), the format is
fragile to parse, and it cannot be extended without breaking
existing parsers.

This series adds per-network-namespace procedure call counts to
the sunrpc layer and exposes them through a new netlink handler
in the nfsd generic netlink family, allowing nfsstat to retrieve
server statistics via netlink with a procfs fallback for older
kernels.

Patch 1 adds per-netns per-procedure percpu call count arrays to
struct svc_stat, allocated alongside the nfsd_net lifecycle.

Patch 2 switches svc_seq_show() to read from the per-netns
counters, making /proc/net/rpc/nfsd namespace-aware. Note that this
is a behavior change, but I think it's a desirable one.

Patch 3 implements the server-stats-get netlink dump handler,
streaming reply-cache, filehandle, IO, network, and RPC
statistics plus per-version and per-operation procedure counts.

Patch 4 removes the now-unused global svc_version vs_count
percpu arrays from nfsd, lockd, and the NFS client callback
service.

I'll also be sending an nfs-utils patch to convert nfsstat to use the
new interfaces.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
Jeff Layton (4):
      sunrpc: add per-netns per-procedure call counts to svc_stat
      sunrpc: use per-net counts in svc_seq_show()
      nfsd: implement server-stats-get netlink handler
      sunrpc: remove unused svc_version vs_count field

 Documentation/netlink/specs/nfsd.yaml | 105 ++++++++++++++++
 fs/lockd/svc4proc.c                   |   4 -
 fs/lockd/svcproc.c                    |   7 --
 fs/nfs/callback_xdr.c                 |   6 -
 fs/nfsd/localio.c                     |   3 -
 fs/nfsd/netlink.c                     |   5 +
 fs/nfsd/netlink.h                     |   2 +
 fs/nfsd/nfs2acl.c                     |   3 -
 fs/nfsd/nfs3acl.c                     |   3 -
 fs/nfsd/nfs3proc.c                    |   3 -
 fs/nfsd/nfs4proc.c                    |   3 -
 fs/nfsd/nfsctl.c                      | 221 +++++++++++++++++++++++++++++++++-
 fs/nfsd/nfsproc.c                     |   3 -
 include/linux/sunrpc/stats.h          |   6 +
 include/linux/sunrpc/svc.h            |   1 -
 include/uapi/linux/nfsd_netlink.h     |  35 ++++++
 net/sunrpc/stats.c                    |  56 ++++++++-
 net/sunrpc/svc.c                      |   8 +-
 18 files changed, 434 insertions(+), 40 deletions(-)
---
base-commit: 887d478bb2115cec0be8caae58bad4d4b3109b1a
change-id: 20260316-exportd-netlink-1c9fb52536e3

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>


