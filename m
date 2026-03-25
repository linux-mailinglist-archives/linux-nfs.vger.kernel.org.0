Return-Path: <linux-nfs+bounces-20374-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sF5pHoT1w2lZvAQAu9opvQ
	(envelope-from <linux-nfs+bounces-20374-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Mar 2026 15:47:32 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 166F632711F
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Mar 2026 15:47:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 23D49309DCBA
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Mar 2026 14:42:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A36D03ED5AA;
	Wed, 25 Mar 2026 14:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gMX6BZnt"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D72E3E5EC1;
	Wed, 25 Mar 2026 14:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774449650; cv=none; b=or9DAVvS2VdekAV3UV2QpSwkiAWVkGCUSTIvYRaszRwKmySbqyBY07gbzJNvmbHlhGo44FM6kl9/qF158kiySUNFJejKjEf5vgJvHuKl28+sjUAWdNdRKT2ce1T6BRBb8ksx6/ZiEy7WQgxAJfWw9GcECI2lo6W5TxeV6A+to1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774449650; c=relaxed/simple;
	bh=cAAOA+Ib++sfZfQFqGE0pWVQoWWdGsHOX+ELRTbhc8I=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=CLo0ZIZ0E7shb8B0jZ32xBT9y+p86L7vmb74XcTr5SmVN/E4+Yw0RqmOjpN17JUf96HvausEuF9DFP+gkM+VSyd6izmT8mtkx5nWpW3Z1Q8KJUt1xzb6kshwvqN4Im9v7E2zcqJJj4AUVQDv2KtfcCj4say0ncApiYdH7fXZur4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gMX6BZnt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A64DCC2BCB2;
	Wed, 25 Mar 2026 14:40:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774449650;
	bh=cAAOA+Ib++sfZfQFqGE0pWVQoWWdGsHOX+ELRTbhc8I=;
	h=From:Subject:Date:To:Cc:From;
	b=gMX6BZntjr9TUNHqgHx7hCTNA7HV7lblIC8krhE5ybClaJ2VX2xe2ebuAyj/0M/pP
	 44AAGV5z/8/x1Oei05Pohmh9s/l4cjqAQj7VYYk8fMF4w+f37pY0L8oHqqkZIqn4XG
	 rdznFUPDHQ4F48G32i5RZSrMjzVtsch+H+9Nqb2lcstidzGjpo/cC8FZVyQIWXyDhT
	 8tT0s9zX6lCoByhWasq0ZrjpYSos878eAE9wZUFlexL9AuwjqpYtzYe48cYGphDHIV
	 oVo9G/hm0FSpwp1nv9UcGCpbwaEfGzHo/U+plF5SFxrxq0gy34a5gSjzwTxteLs1QQ
	 8Bt+nJQIjgd8w==
From: Jeff Layton <jlayton@kernel.org>
Subject: [PATCH v2 00/13] nfsd/sunrpc: add support for netlink upcalls for
 mountd/exportd
Date: Wed, 25 Mar 2026 10:40:21 -0400
Message-Id: <20260325-exportd-netlink-v2-0-067df016ea95@kernel.org>
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
 Tom Talpey <tom@talpey.com>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Donald Hunter <donald.hunter@gmail.com>
Cc: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
 linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3895; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=cAAOA+Ib++sfZfQFqGE0pWVQoWWdGsHOX+ELRTbhc8I=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpw/Poud+JpHknVbcIs8VRMM6RnDaBSukcrZm/n
 AVO5NAD3lKJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCacPz6AAKCRAADmhBGVaC
 FXRuEADVXyq2swDQQZ6zPzpDuym5nTSQpkfjwQ0fc8hct2xKrTFpyBmMVwgCJ9Szxgp+f803bq6
 PfMavZkNcZTUItQy/CMxvL+ULkf1jBG5pXitgIk3qYTGV+vbsnWGbY4XXAYCNOY7IBA7Y1Y0vWG
 gVwmnU2OSf8nORwMW0EnfLbqB3uiy+9lRzHIQyDYAw5F2brdC+p5dhbmA0GwW3fikmQxrND5qB9
 mdennZZl7Hh1mbO2QF+ARTOH9cmQZOW035W4Cpu2BF5ebj5B1CgzGsNqiNsMCrbL1qq3ugePjze
 yUGLXriK3hYPD5NzGvTNHwj4UTeo4SFoAPZFEhYZ0xChveoRUmGdPIs2vVR3D5axpZtfU2XGZyN
 5UWAjcg1sVeZn/1s5vth9Yra/88roUAwtS3vjVBx4g+VhGPKXIQJMMFiA2wDHnaUueYIdqxO/ce
 SdpYoB+4f/R7VJ13LnmXuEXMroeRMqURnI1h50wBihxaXHwFhgC8cnqAihtYilbMTVOhqcAvLPY
 dtcBvnjZVnH6n09of2Fxz2GSPRPn4s1bKws94qJ97HgMkdCA71VB3ycaprCdXONj7pxH1055gF7
 5GogbmabS+uuqisj7N/QnTdZuwvo473wegV9gXN1REMgkXwbs8pP4vbAiIAuCqHGldfeRTUVNsp
 DAkyeXvcRQKWutQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20374-lists,linux-nfs=lfdr.de];
	FREEMAIL_TO(0.00)[oracle.com,brown.name,redhat.com,talpey.com,davemloft.net,google.com,kernel.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[17];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 166F632711F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This version should address most of Chuck's review comments. The
userland patch series is unchanged. I've added the netdev folks this
time too in order to get more experienced eyes on the netlink bits.

Original cover letter follows:

mountd/exportd use the sunrpc cache mechanism for some of its internal
caches that are populated by userland. These currently use some very
antiquated interfaces in /proc to handle upcalls and downcalls. While it
has worked well for decades and is relatively stable, it has some
problems.

Most notably, it's very difficult to extend to add support for new
export options. There is also the matter of requiring /proc which is not
always desirable in a container.

This patchset adds new netlink-based interfaces for handling the sunrpc
cache upcalls. The basic idea is to add a new "cache_notify" operation
to struct cache_detail. That causes the kernel to send a notification to
userland which then fetches any outstanding cache_requests and then
responds to them via netlink.

There is also a companion patchset for nfs-utils that adds the necessary
support for these interfaces to mountd/exportd and exportfs.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
Changes in v2:
- Reword comment above cache_do_upcall()
- Delay adding include of genetlink.h until needed
- Implement proper netlink dump continuation support in all downcalls
- Only ->cache_notify if request is still PENDING
- Add comments to svc_export netlink flag enums
- Shrink size passed to genlmsg_new for notify requests to sizeof(u32)
- move nfsd_cache_notify() out of autogenerated file
- Link to v1: https://lore.kernel.org/r/20260316-exportd-netlink-v1-0-6125dc62b955@kernel.org

---
Jeff Layton (13):
      nfsd: move struct nfsd_genl_rqstp to nfsctl.c
      sunrpc: rename sunrpc_cache_pipe_upcall() to sunrpc_cache_upcall()
      sunrpc: rename sunrpc_cache_pipe_upcall_timeout()
      sunrpc: rename cache_pipe_upcall() to cache_do_upcall()
      sunrpc: add a cache_notify callback
      sunrpc: add helpers to count and snapshot pending cache requests
      sunrpc: add a generic netlink family for cache upcalls
      sunrpc: add netlink upcall for the auth.unix.ip cache
      sunrpc: add netlink upcall for the auth.unix.gid cache
      nfsd: add netlink upcall for the svc_export cache
      nfsd: add netlink upcall for the nfsd.fh cache
      sunrpc: add SUNRPC_CMD_CACHE_FLUSH netlink command
      nfsd: add NFSD_CMD_CACHE_FLUSH netlink command

 Documentation/netlink/specs/nfsd.yaml         | 241 +++++++++
 Documentation/netlink/specs/sunrpc_cache.yaml | 149 ++++++
 fs/nfs/dns_resolve.c                          |   2 +-
 fs/nfsd/export.c                              | 713 +++++++++++++++++++++++++-
 fs/nfsd/netlink.c                             | 107 ++++
 fs/nfsd/netlink.h                             |  18 +
 fs/nfsd/nfs4idmap.c                           |   4 +-
 fs/nfsd/nfsctl.c                              |  79 +++
 fs/nfsd/nfsd.h                                |  17 +-
 include/linux/sunrpc/cache.h                  |  15 +-
 include/uapi/linux/nfsd_netlink.h             | 141 +++++
 include/uapi/linux/sunrpc_netlink.h           |  84 +++
 net/sunrpc/Makefile                           |   2 +-
 net/sunrpc/auth_gss/svcauth_gss.c             |   2 +-
 net/sunrpc/cache.c                            | 127 ++++-
 net/sunrpc/netlink.c                          | 111 ++++
 net/sunrpc/netlink.h                          |  35 ++
 net/sunrpc/sunrpc_syms.c                      |  10 +
 net/sunrpc/svcauth_unix.c                     | 516 ++++++++++++++++++-
 19 files changed, 2332 insertions(+), 41 deletions(-)
---
base-commit: e111174758bddc84136446ae283c741d855c7f8f
change-id: 20260316-exportd-netlink-1c9fb52536e3

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>


