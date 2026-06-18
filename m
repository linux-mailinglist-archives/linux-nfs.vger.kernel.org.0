Return-Path: <linux-nfs+bounces-22671-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id iAdvAK0jNGo8PgYAu9opvQ
	(envelope-from <linux-nfs+bounces-22671-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Jun 2026 18:58:21 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 935906A1B5D
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Jun 2026 18:58:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=SLRuora7;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22671-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22671-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DBA8E30117AC
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Jun 2026 16:58:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E54E232B128;
	Thu, 18 Jun 2026 16:58:18 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5905292B2E;
	Thu, 18 Jun 2026 16:58:17 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781801898; cv=none; b=EDfZy7yUIpl+CovYbBrVGDPtjmOuEryp34bj7dsq86jbXteMCzRc5j8IdV5OZjhvKfsx2dfFyAC0t6egmqEXoZex4NUVJdtU3UaE9WH23IbaL+BjngdNJC7DJ8LKm4u2H4CuAvom/4WRRJAdcZYxQKY0BVQ44E9SDSfTwAZ2f4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781801898; c=relaxed/simple;
	bh=+vRNg/vB88tsr9ajwBBbvFTItz8uF6l4IN0qGYGdBFY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=KRH9OQiQZxgeQ2/8C+P5T8Qb1NlUtMbIuoZIdjDLJCZpV+R9yfHcxtwD+8ivoTZARFYZ6MqAJwGEEhS5amPhWdvg1vJsCO11sL4HXca13DUhViWhvoKBPULoRaDdQQps/q3h/Vg+DEpKnQKkES3zwDfw1pXOBCxMwYtbX/stviY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SLRuora7; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 808E81F000E9;
	Thu, 18 Jun 2026 16:58:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781801897;
	bh=3lit7TWbOMU4PURJ2KRg50uobsepI1W7z4i2B/762E4=;
	h=From:Subject:Date:To:Cc;
	b=SLRuora7TAZ30bBG8cSExrGqfNcA980yYwsSY0g9+HLTrYA9n4jThiaMoNULiRLtC
	 g9KDPlJQ7C2QN/E2PMSMXT1a4WT1Xu8ruGdJ8YGZYJD/UETGBVAxxXjapHZdh4UBoM
	 noVzJiPj37RVbDDGxqr+thEj7eCaArhpSN5YYbe2GsXrm/iI74eET76TEzzEPwC2bx
	 rcM+G+YREMPRuikam8YUHdjmY1k+2uKkRFPXl/unqNAI0d3fKfFXyLhgNJ2dieRSCt
	 3FpYI16Hnbr2NJtdIt8e6O4a3KdOtxCfacJXb7BoQLOSX/h/y+WmPMYLw6qnTdRmv3
	 MHiJ+8l3YXynw==
From: Jeff Layton <jlayton@kernel.org>
Subject: [PATCH v5 0/6] nfsd/sunrpc: convert nfsstat server-side interfaces
 to use netlink
Date: Thu, 18 Jun 2026 12:57:54 -0400
Message-Id: <20260618-exportd-netlink-v5-0-e9aef947af3d@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3XPQQ6CMBAF0KuQrq2ZdpgGXHkP46LQQRtJIYUQD
 OHuVjdq0OX/ybyfWcTA0fMgDtkiIk9+8F1IgXaZqK82XFh6l7LQoA2gMpLnvoujk4HH1oebVHX
 ZVKQJDaNIV33kxs8v8XRO+eqHsYv318Cknu1/a1ISpFGaXG10VRIdbxwDt/suXsQTm/QbSJtbQ
 CcgBwBs2OUE9QbAN2Cg3AKYAGuJoLBUVcptgPwD+PVCngBAArLMWBT4Bazr+gAbnqmtcgEAAA=
 =
X-Change-ID: 20260316-exportd-netlink-1c9fb52536e3
To: NeilBrown <neil@brown.name>, Olga Kornievskaia <okorniev@redhat.com>, 
 Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, 
 Chuck Lever <cel@kernel.org>
Cc: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
 Steve Dickson <steved@redhat.com>, linux-nfs@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3175; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=+vRNg/vB88tsr9ajwBBbvFTItz8uF6l4IN0qGYGdBFY=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBqNCOfT94gUhQYFmnzKEXokuSJQCbfwcvArPY0B
 ucWxrOfSH+JAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCajQjnwAKCRAADmhBGVaC
 FXcbD/sHHwCsCAodk/L/HfLOC0SRvYomeo5Z5EKlg401g5vwujA4wygthKlr40rbVJe8nMyZX1X
 ImzbDtMMQGOZht9jBGHx32qI602Y92A4OftO5CBC3vEnYFpdcNF0IAG7kTCRk7wuPrgTUYiScLy
 vHqr/GUZbyRjp+VZc45M/kxSRmChzLFPP3HQwM4Vq0TJgKDuvSJvAheEEFUy/yLVXTyp+Sd9Bsp
 lgqOoD30aHp5s02X2UNvRGFIhCgw6KX6N1EVSql9zKaWLSpXudITUUUpX2XY6hmJ/r6yDq7xgkx
 4psMarre3yixfesaxZfnt1erKAyMuNWXIEHRrTLvVOBsfseoSMpAj3pWwzjz/Wsj9DOSJ8V+GjO
 Oy4RNBH1D+oigNyumkvlqK1QOLu/DzGwdpiZAaY6CFo4IJdAhjEkaxFr2f69XMukN2nZ4BQaohu
 cgtfVSsX/y4vASv0X80jAzugrLNszQoTo4qJXmim7LASAWK8AIVfyQlTXPAvjy7OBcdnD19KJk7
 Cp08cGbbbNbfgs/Qz7fsc2ObpJXuapOw5AfmLpxPEyP7Klic4ONRLtd4jKUxPdrJ9kYPmOFHQ2X
 vaOz9LczAA/m1H7s1JrbjxHgXXzRRtmeWLpad1zjo0A49VYc2oeC+JdbnldUkdH2WE2Eo9EXh9S
 O4M8O6oobdp92aA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22671-lists,linux-nfs=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:neil@brown.name,m:okorniev@redhat.com,m:Dai.Ngo@oracle.com,m:tom@talpey.com,m:cel@kernel.org,m:trondmy@kernel.org,m:anna@kernel.org,m:steved@redhat.com,m:linux-nfs@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:jlayton@kernel.org,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 935906A1B5D

The main difference in this version is the addition of server callback
operation counts. I'll be sending another nfs-utils patch to add support
for displaying those in nfsstat.

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

 Documentation/netlink/specs/nfsd.yaml | 111 +++++++++++++++
 fs/lockd/svc4proc.c                   |   4 -
 fs/lockd/svcproc.c                    |   7 -
 fs/nfs/callback_xdr.c                 |   6 -
 fs/nfsd/localio.c                     |   3 -
 fs/nfsd/netlink.c                     |   5 +
 fs/nfsd/netlink.h                     |   2 +
 fs/nfsd/netns.h                       |  12 +-
 fs/nfsd/nfs2acl.c                     |   3 -
 fs/nfsd/nfs3acl.c                     |   3 -
 fs/nfsd/nfs3proc.c                    |   3 -
 fs/nfsd/nfs4callback.c                |   7 +-
 fs/nfsd/nfs4proc.c                    |   3 -
 fs/nfsd/nfs4state.c                   |   2 -
 fs/nfsd/nfsctl.c                      | 250 +++++++++++++++++++++++++++++++++-
 fs/nfsd/nfsproc.c                     |   3 -
 fs/nfsd/stats.c                       |   2 +-
 fs/nfsd/stats.h                       |   5 +-
 include/linux/sunrpc/stats.h          |   6 +
 include/linux/sunrpc/svc.h            |   1 -
 include/uapi/linux/nfsd_netlink.h     |  36 +++++
 net/sunrpc/stats.c                    |   2 +-
 net/sunrpc/svc.c                      |  63 ++++++++-
 23 files changed, 492 insertions(+), 47 deletions(-)
---
base-commit: 6f90c7618528b5ca5887f8c6057f26dcc7a27a99
change-id: 20260316-exportd-netlink-1c9fb52536e3

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>


