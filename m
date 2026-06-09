Return-Path: <linux-nfs+bounces-22400-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 3zIRLsZDKGojBQMAu9opvQ
	(envelope-from <linux-nfs+bounces-22400-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 09 Jun 2026 18:48:06 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 309A266293D
	for <lists+linux-nfs@lfdr.de>; Tue, 09 Jun 2026 18:48:06 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="Oa/F8oqd";
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22400-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22400-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9638B32043A0
	for <lists+linux-nfs@lfdr.de>; Tue,  9 Jun 2026 16:16:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7435635200C;
	Tue,  9 Jun 2026 16:16:02 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DA64390CAC;
	Tue,  9 Jun 2026 16:16:01 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781021762; cv=none; b=rSfMSFzbFv3FQZc5SdYM4P0PDjNkfJpmzdoIAvEVe05SG5U0oeClDhRh7BuzU8vFe/sAcpHzc7IizGtElbvzdDLoa6S8vL8KfSQkm1T5YuUsn4RftBaDfCim8yvkbIT8hLrTWufjFWMgbJYWuBw6wz8ubZCQ/pVSKY670om6dp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781021762; c=relaxed/simple;
	bh=3KungVxbjQWfjMxrQlSIl5zGe8ZXPbJMySEG7glE30c=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=LVUZLcTMU9kT97rkafdYeljhPj0LtUfUZg1D0C/Ev203uG0PzuUBtpDQKxQZqLJjD4MAczRSaS64uY9KD7Q100/Btt3DHAbcNp2vB1Uel1jS2jXx4B/zv/nPg5QTId8GGUC1vytj2dHE6aEqYKltQmkGRzf0k5JfjgjhKdPH7jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Oa/F8oqd; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 522FD1F00898;
	Tue,  9 Jun 2026 16:16:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781021761;
	bh=ypC8mfd5XefW7v0C8A2RKdRRWPdBiXPtW1AfjvUhiQI=;
	h=From:Subject:Date:To:Cc;
	b=Oa/F8oqdOGFbYfIfcHDmSpypnT8gRk8O8KxIEidZl9OtHfhwVVGttopPdlLVMENnk
	 Tzd9AKf35BOpZDzuUlRmGHcI5cp9DFQhLTGmjKE73Q1GQCGlZsPez2PVKCfzz6ZIz/
	 lLXeAMKEGtHR64jDlK4SLNAbBWY4M6nEVkfwiQliNbde3YxOkdOvd+7CG4orVplbDB
	 D95FypRfn+A/7Bpc5m5pWp6WrnAfqI+9Dc8KDfdXiZ1kzbzF2+/pZ47FBokHrQYS76
	 Ny91wEUFH1fIlccCLQSyW+aQEfCcLPxshBUnYxOs9vE7MknzoBNd8TNw6DRSR6DjGS
	 Pb51tN+RhWdPQ==
From: Jeff Layton <jlayton@kernel.org>
Subject: [PATCH v3 0/4] nfsd/sunrpc: convert nfsstat server-side interfaces
 to use netlink
Date: Tue, 09 Jun 2026 12:15:53 -0400
Message-Id: <20260609-exportd-netlink-v3-0-aa5508a5bb1d@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3XNQQrDIBCF4asE17XoGIV01XuULhqdJJKgZQySE
 nL3mmxKKV3+A/O9lSUkj4ldqpURZp98DCXUqWJ2eIQeuXelGQgwQknDcXlGmh0POE8+jFzapms
 1aGVQsfL1JOz8coi3e+nBpznS6xjIcr/+t7LkghsJ2lkDbaP1dUQKOJ0j9WzHMnyAsvkLQAFqI
 YTq0NVa2C9g27Y3BvvokfAAAAA=
X-Change-ID: 20260316-exportd-netlink-1c9fb52536e3
To: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>
Cc: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
 Steve Dickson <steved@redhat.com>, linux-nfs@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2908; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=3KungVxbjQWfjMxrQlSIl5zGe8ZXPbJMySEG7glE30c=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBqKDw+teO41PdprRnbVsPSz28PKCa1+v0fX9H7q
 YednM5ZrgqJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaig8PgAKCRAADmhBGVaC
 FWNYD/9cVkGz2qkOhXIcAy2cD1c07xyARwFYESy0vEoAxkyzVdfjhhl9SCNGyRI7cAUYVg5wpyo
 FJkoErjmDAc1W2Oo8JwsMfopnhm0Vn6iiqdoQXADRj9y4tR0IyzO7c97kUsTnj0/I4FrOV7hcXZ
 RzIBHWbEJ96lgNuECI8OhPqVE0GK6KsR/dlrApiLlYFt3i7MZW1RNntMx6CYPNG8E0B4/TqMgcp
 PRA11p7Fp4pgZtoA4nBwWTladFuGH54JaVusqD7BBcUIGV50KNkTcSfeF9eyipyRUwkisL65g6k
 /VQKzYKsiQxsd8sePNJ+g5OZWq9U8DdFj96dNnw6SD/Zm+VqwoYCKkfcin5gBYnzL1wLR4J01pm
 mvoMR3ks25HPXiCXW/vLMUHUpuopAONpBhS+CgdRiFGtahQ3R4kDtu1AiocyyeV3x7x4sFVuZSS
 pP8SRcaodaS4abHBL21Ohvj/1xBImUHrNjpP622KXdK4x+tkuICuXWLMGsxVmQlWDMeS2FGn+Rs
 LxwEXk+g2jvEZ6RD1WxaJ0y8StRyKcVvdcpBiwkz7iHICBWCX6U1ovfmKz10C6oihMkpfXGjq+Z
 f/72eWdjNZQP/08QJEJ9GEJRa3ciEpFCgmLu209tJyjEnivL6OHuLKmRrnBwNCW8sK/+S4HEqpU
 Fyw9UIDVGRbXMBg==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22400-lists,linux-nfs=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:chuck.lever@oracle.com,m:neil@brown.name,m:okorniev@redhat.com,m:Dai.Ngo@oracle.com,m:tom@talpey.com,m:trondmy@kernel.org,m:anna@kernel.org,m:steved@redhat.com,m:linux-nfs@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:jlayton@kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 309A266293D

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
Changes in v3:
- Only increment per-net stats for the "primary" program
- Link to v2: https://lore.kernel.org/r/20260525-exportd-netlink-v2-0-40003fed450c@kernel.org

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
 net/sunrpc/svc.c                      |   9 +-
 18 files changed, 435 insertions(+), 40 deletions(-)
---
base-commit: dd886cc1628e04a21a34016635b2b833916a1003
change-id: 20260316-exportd-netlink-1c9fb52536e3

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>


