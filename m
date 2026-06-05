Return-Path: <linux-nfs+bounces-22307-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id VXS1OKoJI2qrgwEAu9opvQ
	(envelope-from <linux-nfs+bounces-22307-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 05 Jun 2026 19:38:50 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A269164A3D4
	for <lists+linux-nfs@lfdr.de>; Fri, 05 Jun 2026 19:38:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=WubdgHpX;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22307-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22307-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C56EA303EA64
	for <lists+linux-nfs@lfdr.de>; Fri,  5 Jun 2026 17:34:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55119386C1C;
	Fri,  5 Jun 2026 17:34:52 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E4992ECEB9;
	Fri,  5 Jun 2026 17:34:49 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780680892; cv=none; b=Pr5RMxwtILABC5QluVTkW3JcRY1sj2ztMADE4604f3KCLXjO4tSxGV6yaMmNXuFJkzGaIkHZnv1V8DcwNHP212bfd5i6z4AVIhWn6n8lwpKhC1LA1P23nh5+IZuO0R294U6m806rWC19KorVx1Dq6Waxr6oDxuMDSQdfEuIGsPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780680892; c=relaxed/simple;
	bh=AOY7jew2s0vv83qulKa7jUQDx/LLrW5jw2CNNhrGoIE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=rbGrNSeUumsn4kMlOx241xwNaoogh/eqwYG3YX85ZXAO4N3T/ogc9Zii16t5GlFvXWz1WVkxWjUBghRd++/Vj8yUkMVDoDzNcxWG6QCKTOJxt1bY/bUMkZi/SoMN7PdOdOP0ppc4UbYanI1Dk7bhI36/kAy4mixx15XGGb7O4U8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WubdgHpX; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 056A71F00893;
	Fri,  5 Jun 2026 17:34:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780680889;
	bh=dFe/Z+3EtDNNukIoQsxiCqihyu44aA+wIuaTVhBapcA=;
	h=From:Subject:Date:To:Cc;
	b=WubdgHpXl/wPnCcnUfQOSk+VwOuZHDE7rROnKC/7mWMKpWORDH56JQ/aww/R+tj2w
	 QUqrN8XqmiTlc8PhnFYtAC8BJKzdxus4OUDBg+1gE4LdtShF+HEG3TvtDDjeJfD+Pq
	 UcH+Beagz7bV4XlCbGZcKFt8vw/4zi0NG0KbzmGrtg++HjwXcuQRbH+FhuV+mBDDag
	 Xpl/8Ibg7a96jedeSMiE/dvF6ClTqbEp/JLHp2yhZkEnrSKPNLR42VZ65QTtNDwbJ9
	 u2vSIEeT6IIbGoazPk2TTOs7Rxe8eDDL4xHauB10D70lnfOkewZrAQUPaPoAEYnwjW
	 A5Pvs4UDwg57A==
From: Chuck Lever <cel@kernel.org>
Subject: [PATCH 0/9] Deliver TLS session tags to upper-layer consumers
 (NFSD)
Date: Fri, 05 Jun 2026 13:34:34 -0400
Message-Id: <20260605-tls-session-tags-v1-0-47bd1d94d552@oracle.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWMywrCMBBFf6XM2sE0pqL+irjIY5KOlCiZKELpv
 5vo8lzOPSsIFSaBy7BCoTcLP3KDcTeAn21OhBwag1b6qKZRY10EhaR7WG0SPAeljJ5Oh2gMtNu
 zUOTPL3m9/Vle7k6+9k43nBVCV2z2c588LfscJWAlqZwTbNsXoMZd95cAAAA=
X-Change-ID: 20260512-tls-session-tags-9d0042583f44
To: Donald Hunter <donald.hunter@gmail.com>, 
 Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Sabrina Dubroca <sd@queasysnail.net>, Keith Busch <kbusch@kernel.org>, 
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>, 
 Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>, 
 Anna Schumaker <anna@kernel.org>
Cc: kernel-tls-handshake@lists.linux.dev, netdev@vger.kernel.org, 
 linux-nvme@lists.infradead.org, linux-nfs@vger.kernel.org, 
 Chuck Lever <chuck.lever@oracle.com>
X-Mailer: b4 0.16-dev-da966
X-Developer-Signature: v=1; a=openpgp-sha256; l=4609;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=AOY7jew2s0vv83qulKa7jUQDx/LLrW5jw2CNNhrGoIE=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBqIwivHy/0foophi6P8xjfFkcgLXLw4wr9vH8ii
 IScrp0uNZ6JAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCaiMIrwAKCRAzarMzb2Z/
 l4RaD/42OQWIPmEYtGo7JJufQ6n/cYRM3z1qCs67r5J4TXL0G+XCz6H5RPAEIMYaK/Gm+uOu/wa
 DrnW7oWUCSdIJts8574Yi+eeRDAtQMCJJaFcuarPEjRe1UvYZIPQQuc0UrVJelLAdYhwo805Pn+
 fmtcLn0wWprXuE7pISGV5bl7HGIBMfinskspDkfLusTBrWuPwBTjz7Sr0QAO3y82ags5q2iYj1i
 NOOGlGN32nPfOlS6pMagMHCIXhQ+XzNoHkV2CeXsrDJOMzsdJR2TY2ef7OVjiW2AI/8Fm5kmxag
 q77YIdm+/lWqvD0AKsu2luwkdLYddr4wq/i/nTx4fQH3JmsGrY8Meoah6VWooIdeRENwXjuKc7l
 xwc7VryGekDxOt3/JiTPa2XlTxeNiEejv3RCwB3y7sRBAM3lv5abRHxnMDx1ejbsGu8UGKqCTXJ
 +dXU/CIOF900EOs/5NOUBgmPwiw86ZqyUPgYL/RfJfeOYTResAo4Es8u5IIKPV6E+qP0O+41QNf
 vdPNw2jan9c8QpnvKP6GIMk6WBTSsCZWKDMz0yWZ9wouzUGidgT6dbID0ki8f5b9bjzmjGjLTrO
 cr8gHOl4w+9p1kf1etnmKWelnr28ovwhYnaQybTb1Wmy7Zj+wIlaXPqVun45p1DIYjrmPpAwvdi
 qu5QgtQw5m25PjA==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:donald.hunter@gmail.com,m:kuba@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:akpm@linux-foundation.org,m:john.fastabend@gmail.com,m:sd@queasysnail.net,m:kbusch@kernel.org,m:axboe@kernel.dk,m:hch@lst.de,m:sagi@grimberg.me,m:kch@nvidia.com,m:jlayton@kernel.org,m:neil@brown.name,m:okorniev@redhat.com,m:Dai.Ngo@oracle.com,m:tom@talpey.com,m:trondmy@kernel.org,m:anna@kernel.org,m:kernel-tls-handshake@lists.linux.dev,m:netdev@vger.kernel.org,m:linux-nvme@lists.infradead.org,m:linux-nfs@vger.kernel.org,m:chuck.lever@oracle.com,m:donaldhunter@gmail.com,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,davemloft.net,google.com,redhat.com,lwn.net,linuxfoundation.org,linux-foundation.org,queasysnail.net,kernel.dk,lst.de,grimberg.me,nvidia.com,brown.name,oracle.com,talpey.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[28];
	FORGED_SENDER(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-22307-lists,linux-nfs=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp,oracle.com:mid,oracle.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A269164A3D4

NFSD and similar upper-layer services want access-control decisions
based on TLS peer-certificate characteristics, but in-kernel x.509
parsing would duplicate work mature userspace libraries already do.
This series gives tlshd a way to evaluate certificates against
admin-defined policy and report matching policies back to the kernel
as opaque string tags. The handshake layer plumbs the tags through to
the upper-layer consumer's completion callback; intersection against
per-resource tag sets stays the consumer's problem.

Four architectural choices shape the series, only one of which is
visible in any single patch.

The tagging vocabulary is opaque to the kernel. tlshd decides what
each tag means; the handshake layer and its consumers only test
membership. This keeps x.509 out of the kernel and lets policy evolve
at userspace speed. Any future attribute the kernel wants to gate on
must be expressed as a tag rather than as a new netlink field per
attribute.

DONE gains a privilege check (patch 1) as a prerequisite, not as
cleanup. Without it, an unprivileged process guessing a sockfd could
submit a forged DONE and effectively grant or deny tag membership
for a real handshake. Once tags carry authorization weight, that
pre-existing gap becomes load-bearing. The fix predates tags in
principle and carries a Fixes: tag, but it sits at the head of this
series so the rest of the work has a trustworthy foundation.

HANDSHAKE_MAX_SESSIONTAGS is advertised on every ACCEPT reply as
HANDSHAKE_A_ACCEPT_MAX_TAGS (patch 6), so tlshd can size its
DONE-side tag list against the kernel's runtime limit rather than
guessing from header constants. If a daemon overruns anyway, the
DONE handler truncates and logs one pr_warn_once rather than
returning -E2BIG: tearing down a handshake the operator almost
certainly wants to keep is a worse outcome than dropping a few
tags. The truncation path is defense-in-depth for a buggy or
stale agent, not the primary signal.

The tagset helper (patch 3) is split out as a generic library so
NFSD export tagging (patches 8 and 9) can use it without further
churn in net/handshake/.

---
Chuck Lever (9):
      handshake: Require admin permission for DONE command
      handshake: Add tags to "done" downcall
      lib: Add a "tagset" data structure
      handshake: Pick up session tags passed during the DONE downcall
      handshake: Add a kunit test for the completion gate
      handshake: advertise the session-tag cap to user space
      SUNRPC: Copy the TLS session tags when they are available
      NFSD: Implement export tagging
      NFSD: Add allow_tags to the netlink export interface

 Documentation/core-api/index.rst           |   1 +
 Documentation/core-api/tagset.rst          | 225 +++++++++++++++++++++++++++++
 Documentation/netlink/specs/handshake.yaml |  16 ++
 Documentation/netlink/specs/nfsd.yaml      |  10 ++
 Documentation/networking/tls-handshake.rst |  63 +++++++-
 drivers/nvme/host/tcp.c                    |   3 +-
 drivers/nvme/target/tcp.c                  |   3 +-
 fs/nfsd/export.c                           | 141 +++++++++++++++++-
 fs/nfsd/export.h                           |  11 ++
 fs/nfsd/netlink.c                          |   4 +-
 fs/nfsd/netlink.h                          |   3 +-
 fs/nfsd/trace.h                            |  19 +++
 include/linux/sunrpc/svc_xprt.h            |   2 +
 include/linux/tagset.h                     | 187 ++++++++++++++++++++++++
 include/net/handshake.h                    |  30 +++-
 include/uapi/linux/handshake.h             |   4 +
 include/uapi/linux/nfsd_netlink.h          |   1 +
 lib/Makefile                               |   1 +
 lib/tagset.c                               | 174 ++++++++++++++++++++++
 net/handshake/genl.c                       |   7 +-
 net/handshake/handshake-test.c             |  72 +++++++++
 net/handshake/handshake.h                  |   6 +
 net/handshake/netlink.c                    | 109 +++++++++++++-
 net/handshake/request.c                    |  68 ++++++++-
 net/handshake/tlshd.c                      |  10 +-
 net/sunrpc/svc_xprt.c                      |  11 +-
 net/sunrpc/svcauth_unix.c                  |  12 ++
 net/sunrpc/svcsock.c                       |  38 ++++-
 net/sunrpc/xprtsock.c                      |   5 +-
 29 files changed, 1205 insertions(+), 31 deletions(-)
---
base-commit: 4d4d6605de5f91a40335729b6a7cc15e83b280f3
change-id: 20260512-tls-session-tags-9d0042583f44

Best regards,
--  
Chuck Lever <chuck.lever@oracle.com>


