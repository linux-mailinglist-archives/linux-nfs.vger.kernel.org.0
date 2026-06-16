Return-Path: <linux-nfs+bounces-22624-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id w9k7AapGMWq3fwUAu9opvQ
	(envelope-from <linux-nfs+bounces-22624-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Jun 2026 14:50:50 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6851468F9A1
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Jun 2026 14:50:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=i+Il4u2Q;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22624-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22624-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 398B530F56EC
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Jun 2026 12:45:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1031364935;
	Tue, 16 Jun 2026 12:45:45 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 922FA361DC1;
	Tue, 16 Jun 2026 12:45:44 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781613945; cv=none; b=tDrjVKEVIPmpF8c5LB1jFg8GnlAooLN8oSRl0wx5b7YWAJSe5tWu81tPrmNyU4f0rj2CtGvbYQ+sjjeKMEx1d6EssBP1wsuEJXxraz595ThsUsJRhjqjGW8nfshIccGrhB6ucy1FZw/GD0DTjEIopKdzB3VHeWbJB8ukF5B8ohI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781613945; c=relaxed/simple;
	bh=SU588Ddhmdv+YXFmCAMaBHMoHCVStYke3nsxHP1Un/I=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=P0EOZ5roxaU4bx1o+oRkBvpK7/DCJRpyW7rZbcF2GM6o8Fh/bEKMzUd9cWe1fUpytT1DItomZSKcOpw4ApWBqWGoeIs2L1jW8FFX49ZUb8AW3pKCv0vqxxEBj14qmJppthURn1uhKu3ScuWwCpGshKc7kWffErteaYzB/VLWO9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i+Il4u2Q; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 308BC1F000E9;
	Tue, 16 Jun 2026 12:45:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781613944;
	bh=VibCMmMyMPZngYdyfZtfnJclhsXq6OvS2LdbVXsOnAA=;
	h=From:Subject:Date:To:Cc;
	b=i+Il4u2QCX9QGhTPFyJb/3z+dBTMCrXl6K0jbijhq9uYwf5RfR2FaQ2eWSTnGbEZq
	 quVjdxk/gl47vIEs0HGOJxvqN+TMi4OUIACOFVaFsfgwczu4hZsHqHYlYJSHUfBeI9
	 UExyfVkl2Zp5/NaXbZcQQJ5Zob4SBjBWeFaFMF61Jje8rPd9z+440tcTYU2n3CZwFO
	 DKZ7Iti1RlLm/+OOcLugl2kIGd1LV8zG7fGhzfEoNYjZog7oqiWjMClQudBmJ+rwZw
	 EglWG8wA9MNMSPcA9WsysSKKfqDE4bDmcjZE2Q7IvWmjxnHbB9SbkS5eFBUFyblZs2
	 /D+RL12OhIvLA==
From: Jeff Layton <jlayton@kernel.org>
Subject: [PATCH v4 0/4] nfsd/sunrpc: convert nfsstat server-side interfaces
 to use netlink
Date: Tue, 16 Jun 2026 08:45:32 -0400
Message-Id: <20260616-exportd-netlink-v4-0-03505aee3883@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3XNQQqDMBCF4auUrJsySZxQu+o9ShdqRg1KlESCR
 bx7oxsp0uU/MN9bWCBvKbDHZWGeog12cCmy64VVbeEa4takZhKkBiU0p3kc/GS4o6m3ruOiyus
 SJSpNiqWv0VNt5118vVO3NkyD/+wDUWzX/1YUHLgWEk2lZZkjPjvyjvrb4Bu2YVEeQNo8AzIBG
 QComkyGUJ0AdQAa8jOgElAUiHAvsCyF+QHWdf0C9apcXjEBAAA=
X-Change-ID: 20260316-exportd-netlink-1c9fb52536e3
To: NeilBrown <neil@brown.name>, Olga Kornievskaia <okorniev@redhat.com>, 
 Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, 
 Chuck Lever <cel@kernel.org>
Cc: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
 Steve Dickson <steved@redhat.com>, linux-nfs@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3149; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=SU588Ddhmdv+YXFmCAMaBHMoHCVStYke3nsxHP1Un/I=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBqMUVwh9V2K7slM7lWH/tLwW8FIpyJ8SA+Bky14
 Ovn5uXlYV6JAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCajFFcAAKCRAADmhBGVaC
 FYc6EADD3bjU/EoGWvIlhccq7PnUsi0ziPhEGD6XDqE8TNN1gv7IeL92n1L0fjJV/QvU2AW668u
 HPisw4xGoR8/F9JMQ5SnnvBGgVsXG25bZr0ytVAbnIeZlUXOV2F6M0ox/5mXJ4b95kdq4EfD0vK
 ICP8/fMKofigDaTz/dTeXWnARQtzTCzXlRTrSUI+MOLAcOIytm7aPz5BQehZUFbflToKYL47fq6
 jzkTL5Dib4WyjnOG1rnX4iJt2LnfHHQO+0AqM06H6hzEH9x/IHWu92J9f5LU3ihAk4N0ayrIVXB
 SBbMoGAqnynzldmX06XpwoVwcZRoYQdBAI2EbjCvCCUJlLeUADzzdZkSC31OoIVdt3/+yvU8jAz
 hUE1WF7s18QVVpN0bOOgH/81pL4+9kY5dgSqxiLsQfasPLvdo+MBdF1PAJz111hhJvko+JfV05N
 l9mGkF2+bVbXzIjGYv9SiILXQk8k4nKixayaC6RNtyQcwDm0plhpioZYemAeK9IlXuxe7V4qXUJ
 TzFMF/wmplBkBfOCun+ufDLJOxtGAF7ISehYzNXaj9EZ+RuZFqdbV3B2JA9M70Z93zOcwG2Xh8d
 /KvBLfJkvnLdni6CxFDYbVqOs3e8Ywx/BC6Z5Ikcyjl81J4XHZI4wPZgvuLlaIljyZX6NtnaKDk
 Xt4SMSPnQKU2QGg==
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
	TAGGED_FROM(0.00)[bounces-22624-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6851468F9A1

This version just fixes an error handling bug that Sashiko noticed.

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
Changes in v4:
- Ensure error is returned when nla_put_*() calls fail
- Link to v3: https://lore.kernel.org/r/20260609-exportd-netlink-v3-0-aa5508a5bb1d@kernel.org

Changes in v3:
- Only increment per-net stats for the "primary" program
- Link to v2: https://lore.kernel.org/r/20260525-exportd-netlink-v2-0-40003fed450c@kernel.org

---
Jeff Layton (4):
      sunrpc: add per-netns per-procedure call counts to svc_stat
      sunrpc: use per-net counts in svc_seq_show()
      nfsd: implement server-stats-get netlink handler
      sunrpc: remove unused svc_version vs_count field

 Documentation/netlink/specs/nfsd.yaml | 105 +++++++++++++++++
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
 fs/nfsd/nfsctl.c                      | 214 +++++++++++++++++++++++++++++++++-
 fs/nfsd/nfsproc.c                     |   3 -
 include/linux/sunrpc/stats.h          |   6 +
 include/linux/sunrpc/svc.h            |   1 -
 include/uapi/linux/nfsd_netlink.h     |  35 ++++++
 net/sunrpc/stats.c                    |  56 ++++++++-
 net/sunrpc/svc.c                      |   9 +-
 18 files changed, 428 insertions(+), 40 deletions(-)
---
base-commit: c13952992d5459add7732eb4876eebfeec03af58
change-id: 20260316-exportd-netlink-1c9fb52536e3

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>


