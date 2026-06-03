Return-Path: <linux-nfs+bounces-22259-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id cj9wAe2OIGo35AAAu9opvQ
	(envelope-from <linux-nfs+bounces-22259-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 03 Jun 2026 22:30:37 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 8849963B207
	for <lists+linux-nfs@lfdr.de>; Wed, 03 Jun 2026 22:30:36 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=nqlxKHsU;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22259-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22259-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0188D3063A8F
	for <lists+linux-nfs@lfdr.de>; Wed,  3 Jun 2026 20:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 180A239EF27;
	Wed,  3 Jun 2026 20:30:33 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F823320A14;
	Wed,  3 Jun 2026 20:30:32 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780518633; cv=none; b=VdB7r7y2bIHixAkfZ0kfaKrT0yi7joyJK3b0l2i+APJuEHw1Azm3RQVhgBt/58sj4kNYooxbFsbSr0gJpEq3SafilxqLAAtddKu4T/vf+C7O5kqsoUroKMy6JF373GHd0+0sXDNPsz4xqPB69zN7Z4NIbbAlAUJA6xWMUoT5i70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780518633; c=relaxed/simple;
	bh=y1916kQf1v2uwTC9fT91OsgQ2orprynqFrfaRMVCMoM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PNqALfaRfefYOQziei8bBNvuhi+sv124EY6wHpov0sPeEVcWEMmFokUsEpEEJ2WEDY1DN/lZ/rV6GOkpeVU8IHMmaBrhfowXYpdlmrcZa2a61Kq0Gbc0zYhkKhr/MbaLIysskj4HY2rdVIZx9DuuvnyyUoMUQXwdPrW/2hfdISE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nqlxKHsU; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A06C1F00893;
	Wed,  3 Jun 2026 20:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780518632;
	bh=VlXlBPddPAkr6EjbYMR7vH6hYHaxH44eYtqPiDct89A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nqlxKHsU4r7J9XV6pyykqPWCpIGYKhcvDPJffdcW7hOZJ5fpTPyDmIQAUzBFt1DQN
	 zCvq11J5NjS0XuFecuoz8OTXg7PTgQNIwcf0IoP14wp/ITGM+QGt8iMIxE1EMwGvnI
	 1TMmymz8iIcaOVlyNfC5bqa3u8kTfalqhYFgtTtHpZIYTpr7mkOIVCQ8ERs5J2poRv
	 5V1wM5WcI3yvr0IYdHg6dgHSAuu+DZdzNO2LPGj0VFdNLmq/u1XbsaCUM3SXARXbSX
	 vfk8a4Jq3nJZTpG7FgPaiu66AV0lDoft5H2cqffb2UXN1MHIszuSRC+bx54AunjRzv
	 n6t9D9Cjx3U1A==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Anna Schumaker <anna.schumaker@oracle.com>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Mike Snitzer <snitzer@kernel.org>,
	Jeff Layton <jlayton@kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Chris Mason <clm@meta.com>,
	linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Trond Myklebust <trond.myklebust@hammerspace.com>
Subject: Re: [PATCH v2 0/9] nfsd: fixes for locally-triggerable bugs
Date: Wed,  3 Jun 2026 16:30:28 -0400
Message-ID: <178051856666.140576.1367986078304916981.b4-ty@b4>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260602-nfsd-testing-v2-0-e4ea62e3cd5c@kernel.org>
References: <20260602-nfsd-testing-v2-0-e4ea62e3cd5c@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORGED_RECIPIENTS(0.00)[m:neil@brown.name,m:okorniev@redhat.com,m:Dai.Ngo@oracle.com,m:tom@talpey.com,m:lorenzo@kernel.org,m:anna.schumaker@oracle.com,m:trondmy@kernel.org,m:anna@kernel.org,m:snitzer@kernel.org,m:jlayton@kernel.org,m:chuck.lever@oracle.com,m:viro@zeniv.linux.org.uk,m:clm@meta.com,m:linux-nfs@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:trond.myklebust@hammerspace.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-22259-lists,linux-nfs=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8849963B207

From: Chuck Lever <chuck.lever@oracle.com>

On Tue, 02 Jun 2026 12:23:12 -0400, Jeff Layton wrote:
> Just some minor changes in this version, plus a cleanup patch from Al.
> 
> These are bugs that Claude classified as locally-triggerable. A couple
> can be triggered by an unprivileged user, but the rest require admin
> access.
> 
> The last 3 patches fix one bug. I originally had a more targeted fix
> that kres generated, but I think it's better to simplify the filecache
> disposal mechanism to get rid of the bug rather than add more
> complexity.
> 
> [...]

Applied to nfsd-testing, thanks!

[1/9] nfsd: defer vfree of compound ops to fix rpc_status UAF
      commit: 45bdeda0ff0e26e43b5c84ead5a8859696df4a24
[2/9] nfsd: hold rcu across localio cmpxchg retry
      commit: 3132933172044d02951470c99c8cbbe54756ae45
[3/9] nfs/localio: fix ref leak on nfs_uuid_add_file failure
      (no commit info)
[4/9] nfsd: guard nfsd_serv deref in nfsd_file_net_dispose
      commit: a6dfbd5e70527b91d610bd4864d9de725b06c5ba
[5/9] nfsd: widen nfsd_genl_rqstp address fields to sockaddr_storage
      commit: a9a83f4a2b3d065f26efb7dd8153fecd55f10622
[6/9] nfsd: fix refcount leak in nfsd_file_lru_add on insertion failure
      commit: d72ae7cbbf14e2f0bc4bc5fecc06c12180fd5b66
[7/9] nfsd: fix fcache_disposal UAF by inlining dispose state into nfsd_net
      commit: fcafdda0423b27637a27594ec81b9b07ab6069e1
[9/9] nfsd: unify cleanups in nfsd_cross_mnt() exits
      commit: 3275806873389963d81e9ddd17d047e7c1812f3b

--
Chuck Lever <chuck.lever@oracle.com>

