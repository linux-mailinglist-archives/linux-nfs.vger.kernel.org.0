Return-Path: <linux-nfs+bounces-22206-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id LraFI9EDH2qidAAAu9opvQ
	(envelope-from <linux-nfs+bounces-22206-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 02 Jun 2026 18:24:49 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F254E6302B0
	for <lists+linux-nfs@lfdr.de>; Tue, 02 Jun 2026 18:24:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="n/BskQOT";
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22206-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22206-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E3BD33010BA9
	for <lists+linux-nfs@lfdr.de>; Tue,  2 Jun 2026 16:23:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 058D83630A5;
	Tue,  2 Jun 2026 16:23:29 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2B073019C8;
	Tue,  2 Jun 2026 16:23:27 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780417408; cv=none; b=qlvS6POxJRqcQAee20OfAUZTO+KcuL1v8ON1+u7FO3Vw03//lz7H4GNL8aEov2xDkrAeyeuejweTq00qiKkWNfxg4Mkqzks0hYfJXcygmexwYQ+lx2nYrgBvzWG4K5Bq+lCSyrzEW9hGMEFIcB3PqtqxuNFsNZT3hBUv9Qaid08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780417408; c=relaxed/simple;
	bh=vuYEpJJOGtjuvv4cnVwxiWWNBECDLvmCTPU4mt3Kzds=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=g9RAi07yJxVeGQJmrzJY8ZeZAz7Ww7kzww97QSInUNVLfvDrhLAGoUgBm6D1VxfWPUre/qROsfwiuM6vHZrcTgMldX3++HejSVDEiEmAqIFFIKOGzMdv6lbuZl12BcLHpWd3ze+4pFljBlCas4paEnxuO0rib5TXLcqHKu8IoPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n/BskQOT; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 326AF1F00893;
	Tue,  2 Jun 2026 16:23:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780417407;
	bh=WIEV5sVFxSJwTMmvxp3SldQ8HifstGpFzIjIQcXd/+0=;
	h=From:Subject:Date:To:Cc;
	b=n/BskQOTSih2SKOiqmA6OZzDO1Bkqi/HmwoEpyQ3IpY1TOTvo87ujdFEDQJqfOisI
	 XSPo12wTC/ePNIHAufvNQ10Y3yBny6VEXYGWeP9CPEGWexPTcNVzQiUC4dsFNyMOjB
	 R5AC118tHjFRcNYdGwIDTjIP3yk3QC4QHIdivAuC3tfZ548x0zkx4z9nQ8If5/2IRF
	 Gn4q4taqlZ+bp+RCA6975SLLPqYcouM6cOWfAvo8Qv2WoAVb3YnMsCI7UKCYUGWCN+
	 0Jy33l5DGpDiTkv0kzeVah2K3BiTM2XQ7VSdMixtcreud21PEktnMiwmbpd8q1MCcc
	 i+JWd9bz05fig==
From: Jeff Layton <jlayton@kernel.org>
Subject: [PATCH v2 0/9] nfsd: fixes for locally-triggerable bugs
Date: Tue, 02 Jun 2026 12:23:12 -0400
Message-Id: <20260602-nfsd-testing-v2-0-e4ea62e3cd5c@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3XMwQoCIRSF4VcZ7jrjqijVqvcYZhF5dS6FhooUg
 ++ezb7lf+B8GxTKTAUu0waZGhdOcYQ6THBfbzGQYDcaFCqLFqWIvjhRqVSOQZA2eHaGUBuCcXl
 l8vzeuXkZvXKpKX92vcnf+gdqUqBw6K0ko63zp+uDcqTnMeUAS+/9C004h8KpAAAA
X-Change-ID: 20260601-nfsd-testing-e3509d5e035e
To: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Lorenzo Bianconi <lorenzo@kernel.org>, 
 Anna Schumaker <anna.schumaker@oracle.com>, 
 Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
 Mike Snitzer <snitzer@kernel.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Chris Mason <clm@meta.com>, 
 linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Trond Myklebust <trond.myklebust@hammerspace.com>, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2054; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=vuYEpJJOGtjuvv4cnVwxiWWNBECDLvmCTPU4mt3Kzds=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBqHwN3Tn/fQ0Cq3QfWIvw2kxmYdMs9rEG8kTmPs
 9Rr/TAWdRiJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCah8DdwAKCRAADmhBGVaC
 FRPBEACH8I+aL0Oo5CfqdAcOR99bZPRPgfsJT3ZpeR5MwYrAA9nX48rXg5cdckX0hQi1fX4at9h
 HkdtMXeAYsUlnU6dv4bIFfLEyNkt3drFENRNarji4rFwTYVkvqW9FVERTKjj/gAZeQ44VsrInDO
 wtMTtEpUVsokimtNKkdcxOSDuvQgJ9OOPRypEitpY8ELrQNsedmyT09ZoNdu5mVtytLlaVzQMNq
 GVno0zfcoze+El1V+eV86DG2iQdw6spFJtQj/9E3vTwETPTo2evtf1fV4NFoF1ZGaOBTuCG6Gb7
 pzzdVCYv3R8Gen8EmaGRk/hkcd1BAnV037TUns1Xcku5VbJGYMCNBaYfW1/P6mW7+LMT6OVvuy9
 Cz8GZY++Pll1ZMoX73Jh5+L87565WOSxUFjKRQc+LYtvlzEKAoktQzvZM0OuqBFlafaFm87uy8w
 9IyCsc6EUqBU2aVCq9PxQ3Y33NZy74WAInf/t/Yvl64ZzqBGuYmkBCaUQ87FJShrQ+As3hqJk/f
 ImrmV3/KTcNi+N5+jB7SXiHGdBLxqcw4J0BnhtfJDXcM1u/8rj6kgxQQIvhXrlaSRxsb97CSsai
 O6YSSFuEtV1w4mHgqkefORQPIcBQ85cgCp0wG8sASvtQtVVUJ8K127w9QF/YSwB00VER2arxBs4
 LtAoNqDFr4MTBwQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:chuck.lever@oracle.com,m:neil@brown.name,m:okorniev@redhat.com,m:Dai.Ngo@oracle.com,m:tom@talpey.com,m:lorenzo@kernel.org,m:anna.schumaker@oracle.com,m:trondmy@kernel.org,m:anna@kernel.org,m:snitzer@kernel.org,m:viro@zeniv.linux.org.uk,m:clm@meta.com,m:linux-nfs@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:trond.myklebust@hammerspace.com,m:jlayton@kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	TAGGED_FROM(0.00)[bounces-22206-lists,linux-nfs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: F254E6302B0

Just some minor changes in this version, plus a cleanup patch from Al.

These are bugs that Claude classified as locally-triggerable. A couple
can be triggered by an unprivileged user, but the rest require admin
access.

The last 3 patches fix one bug. I originally had a more targeted fix
that kres generated, but I think it's better to simplify the filecache
disposal mechanism to get rid of the bug rather than add more
complexity.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
Changes in v2:
- rework filecache patch to only take net ref at disposal time
- fix ordering of operations in nfsd4_release_compoundargs()
- add Al's patch to simplify nfsd_cross_mnt() cleanup
- Link to v1: https://lore.kernel.org/r/20260601-nfsd-testing-v1-0-d0f61e536df8@kernel.org

---
Al Viro (1):
      nfsd: unify cleanups in nfsd_cross_mnt() exits

Chris Mason (3):
      nfsd: hold rcu across localio cmpxchg retry
      nfs/localio: fix ref leak on nfs_uuid_add_file failure
      nfsd: guard nfsd_serv deref in nfsd_file_net_dispose

Jeff Layton (5):
      nfsd: defer vfree of compound ops to fix rpc_status UAF
      nfsd: widen nfsd_genl_rqstp address fields to sockaddr_storage
      nfsd: fix refcount leak in nfsd_file_lru_add on insertion failure
      nfsd: fix fcache_disposal UAF by inlining dispose state into nfsd_net
      nfsd: hold net namespace reference for delayed-dispose nfsd_files

 fs/nfs_common/nfslocalio.c |  14 ++++-
 fs/nfsd/filecache.c        | 130 ++++++++++++++++++++-------------------------
 fs/nfsd/filecache.h        |   3 +-
 fs/nfsd/localio.c          |  12 +++--
 fs/nfsd/netns.h            |   3 +-
 fs/nfsd/nfs4xdr.c          |   4 +-
 fs/nfsd/nfsctl.c           |  12 ++---
 fs/nfsd/vfs.c              |  17 +++---
 include/linux/nfslocalio.h |   9 +---
 9 files changed, 101 insertions(+), 103 deletions(-)
---
base-commit: e7ca66ba17f1b5e4ecbb29b9c3c4a31aa062bed0
change-id: 20260601-nfsd-testing-e3509d5e035e

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>


