Return-Path: <linux-nfs+bounces-22543-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id JEWgOPy9LWpBjQQAu9opvQ
	(envelope-from <linux-nfs+bounces-22543-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sat, 13 Jun 2026 22:30:52 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 47A1367FA2D
	for <lists+linux-nfs@lfdr.de>; Sat, 13 Jun 2026 22:30:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=ZfrdcjaY;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22543-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22543-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1F45B301CCC9
	for <lists+linux-nfs@lfdr.de>; Sat, 13 Jun 2026 20:30:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22CCE3385A1;
	Sat, 13 Jun 2026 20:30:50 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDA522EEE88;
	Sat, 13 Jun 2026 20:30:48 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781382650; cv=none; b=f9kWWaBn8vuJWIXCUknBYDNf/YknVtTPjQb+nbXkyfOLjbE4j6/zU6fW4L2F7M5WmIVYs5JvFpm58V70Fs5e3JBWX8yUWjksuqYyuZUJ1TGB6URgFxyPQyy6Ucwpw2IaCJvXbAl3X/IsTCBB/3nkTXveWZbaV/hMpqJXoAd2iPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781382650; c=relaxed/simple;
	bh=7KbKwxY+/052b+hFF6tlApC8vKJqva4fKTXyOSFCs3o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kUzTw0tegb2VXeqDc4TaP7bT2V043aNI5Bc4Gyqg4tDnF8WD/nZ5C0q8eHEL5qDsblJNMXTh2oe9FZ1MEZemYRk+yE08PDuCmvidjmJlo2WYRqsOfYClLrrx5DDArfuUCXgLP2IS7oQ+nxx5UYUR4JBH4Lj6zCBMYp7qSYX9qYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZfrdcjaY; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC1391F000E9;
	Sat, 13 Jun 2026 20:30:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781382648;
	bh=jsfoxDsfIMS0kvXx65KA4nfGwUIHSfmU4mRtxVOU7d8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZfrdcjaY4ZCsyhY7MCMssDKLcAOdLhIL3Hoze9dSr9DwZJe5SeqEudT5NiCvlSvTm
	 X31JGf8pL76PAQIKLlrO7LJu4odqCWzMyHSXlevaT3vmtWlzx0PaAA3UqWZG56+mKX
	 hHgUDsf9SdnxqE5jmJ0fTVvY9NIO3ePqnobs+1Rh/SNCoa0YGzuSkeVWoSi6AHtT68
	 EMQ7PU5BFDJLYkz398XCgXN7KBTlBhr/cFp4JwKxj+qSmuTFaAYP9ot5QFb8t/jgSo
	 GWA+5ONhougT0Pv6Si+pnVjiOIIZEnR30pIGO+Pnk3r9PaqMkAh6Su1XoUGCZ5fL0T
	 ZhZSpJxmB9rxg==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: Chris Mason <clm@meta.com>,
	linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 00/21] nfsd: more bugfixes
Date: Sat, 13 Jun 2026 16:30:45 -0400
Message-ID: <178138249723.1181088.2364860878285776489.b4-ty@b4>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260611-nfsd-testing-v2-0-5b90e276f2d9@kernel.org>
References: <20260611-nfsd-testing-v2-0-5b90e276f2d9@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:neil@brown.name,m:okorniev@redhat.com,m:Dai.Ngo@oracle.com,m:tom@talpey.com,m:jlayton@kernel.org,m:clm@meta.com,m:linux-nfs@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-22543-lists,linux-nfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	TAGGED_RCPT(0.00)[linux-nfs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 47A1367FA2D

On Thu, 11 Jun 2026 16:00:43 -0400, Jeff Layton wrote:
> This version is addresses review comments from Sashiko. There wasn't
> much in the way of regressions in v1, but it did notice a number of
> nearby problems that should also be fixed.
> 
> This adds 3 patches to fix those. I also dropped the localio patch from
> the series since that should probably go through the NFS client tree.
> I'll send it separately.
> 
> [...]

Dropped 08/21 - rejected in v1
Dropped 15/21 - will be replaced
Folded  20/21 into 03/21 to avoid a bisect hazard

Applied to nfsd-testing, thanks!

[01/21] nfsd: clear opcnt on compound arg release to prevent OOB read
        commit: ef6fe22ee7de0a016bd6b4ec6cf314b9f93cd816
[02/21] nfsd: add missing read barrier to rpc_status_get dumpit seqcount retry
        commit: 71a715232eff2ff9b8fbb7ad2f9f882187056ac8
[03/21] nfsd: fix netlink dumpit error handling for rpc_status_get
        commit: ef265c50d90fc7e92461668fab69f9a33e935092
[04/21] sunrpc: defer rq_argp and rq_resp free until after RCU grace period
        commit: 5d51eea254f4be0b146bd859384e10723d59bcf8
[05/21] nfsd: check nfsd4_acl_to_attr() return value in nfsd4_create()
        commit: 50c819a3406963f7935a62d81321984b947b5b97
[06/21] nfsd: add filehandle match check to nfsd4_delegreturn()
        commit: 35450eb04ec5718ef680062da9711f054cacfdb9
[07/21] nfsd: validate nseconds in TIME_DELEG decode paths
        commit: 387858689eb526681b3fca7d24d3fb18b353356a
[09/21] nfsd: fix version mismatch loops in nfsd_acl_init_request()
        commit: a6a22b9c4135f80b8b1b5c9f7629cddb677c5dad
[10/21] nfsd: fix FL_SLEEP being set unconditionally for all LOCK types
        commit: fd848bc2582871814762604f3675f1bd139e356e
[11/21] nfsd: add fh_want_write() for early-verified SETATTR in nfsd_proc_setattr()
        commit: 19a6dd09bf8d22d7af15ef068f57ec279f9051aa
[12/21] nfsd: fix clock domain mismatch in clients_still_reclaiming()
        commit: 0fecd3b7c474eedb60ec03716a13a61c93eadec6
[13/21] nfsd: use test_and_clear_bit for somebody_reclaimed to prevent lost update
        commit: 7f101efd236e14915bf35d5c2b62d10350a63b1c
[14/21] nfsd: reject reclaim LOCK after RECLAIM_COMPLETE
        commit: 7a02caf96fac6faa22a93b8bd06d29d6f90318cd
[16/21] lockd, nfsd: RCU-protect nlmsvc_ops dispatch
        commit: b601157bf2118094708689033921e996e3418e29
[17/21] nfsd: move nfsd_debugfs_init() after nfsd4_init_slabs() in init_nfsd()
        commit: bb483d4ed57fd52c21c0f64c126986489d51c9d5
[18/21] nfsd: initialize DRC hash table before registering shrinker
        commit: bec760bf8e868cb6e232b4760dac86c0172d17f5
[19/21] nfsd: restore rq_status_counter to even on all nfsd_dispatch() exit paths
        commit: f8b2bcada458865af99537ece2b5470417b0143b
[21/21] nfsd: drop the stateid, not the stateowner, on seqid_op replay retry
        commit: 402b9e49a8e5da556adbafd21871ea4e8a617372

--
Chuck Lever


