Return-Path: <linux-nfs+bounces-21873-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yK8pDjTdEWq+rQYAu9opvQ
	(envelope-from <linux-nfs+bounces-21873-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sat, 23 May 2026 19:00:36 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 394415BFF65
	for <lists+linux-nfs@lfdr.de>; Sat, 23 May 2026 19:00:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 708AB300847E
	for <lists+linux-nfs@lfdr.de>; Sat, 23 May 2026 17:00:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48DB633F588;
	Sat, 23 May 2026 17:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ViGMJGZP"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4FF231AF2D;
	Sat, 23 May 2026 17:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779555609; cv=none; b=pS+CGZlTDL8U5CdlHNMpKGp3rei88CHA/h01GJfdNFcKz1rGyhu6OaE3HDmUWBmJ/s+x3xxhDLSqE0d0BuiwjxXSvCFOOOLFHsl6sG+mrNqM1EpTzQiXVlkZ5geqOSGUNJYrLrJ/hKh4Abn1zCDtWGkgyk0rFySF0dO8hVAYFWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779555609; c=relaxed/simple;
	bh=lUzKLMZj8MsL+y7pHox+0ri4OgWIAwWmb8p4bETu5t4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FD3cdtwvOutJNBGl0ZeGnZwnLGMCGe3eAceSKTROT/NdUIIfkVlteW/Huyj/Gpd2DTOc2D2c4h6vOrzhWOHINfDxcKsnqqbwiJlhGFMf2rPsURZeVb9aNPO6Uz7HEywMnRhxwneaHySf+MmTHL3qWlhyE6kjKq7SZm61/yQvb3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ViGMJGZP; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 488F71F000E9;
	Sat, 23 May 2026 17:00:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779555605;
	bh=tUz/r2x3Ay9kJJTJGPtGiAVFYhnbDs4b1fzpZC1g9s0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ViGMJGZPqTn9uMBo/AUvQ2VVsdNkbnTCgGVGIYsgB5aDU57iXuJEAljNCGvYDmtup
	 q1soLrsW8XSyLZriEwWDkIrAoy94MFL0g3uDvemIGJyNpMsXEF+37fjalopfMnox8b
	 xZXJweHQMMH+4LkUOjq3IY4Qo1XSwMTCvmd9dWyCQhv2FN/9BshaPQNZRivLOaDf1m
	 0/VtIHrW2dmsA2cz1TwV6MT3DFAepdE+IaSJoVMcDWd6hz9b/FGlgz6w3ZXgg7LJvp
	 ghw+w7kt5jf+hNGyq09apRJyaFWMNPuykfQMV8RMcrNjTJConb/diuiyjeD4Dq49vW
	 G7NupIwD9DgyA==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Jeff Layton <jlayton@kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Alexander Aring <alex.aring@gmail.com>,
	Amir Goldstein <amir73il@gmail.com>,
	Jan Kara <jack@suse.cz>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Calum Mackay <calum.mackay@oracle.com>,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-nfs@vger.kernel.org
Subject: Re: [PATCH v5 00/21] nfsd: add support for CB_NOTIFY callbacks in directory delegations
Date: Sat, 23 May 2026 13:00:01 -0400
Message-ID: <177955559084.514471.1679258468809800547.b4-ty@b4>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260522-dir-deleg-v5-0-542cddfad576@kernel.org>
References: <20260522-dir-deleg-v5-0-542cddfad576@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21873-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FREEMAIL_CC(0.00)[oracle.com,goodmis.org,gmail.com,suse.cz,zeniv.linux.org.uk,kernel.org,vger.kernel.org];
	TAGGED_RCPT(0.00)[linux-nfs];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 394415BFF65
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Chuck Lever <chuck.lever@oracle.com>

On Fri, 22 May 2026 15:42:05 -0400, Jeff Layton wrote:
> This patchset builds on the directory delegation work we did a few
> months ago, to add support for CB_NOTIFY callbacks for some events. In
> particular, creates, unlinks and renames. The server also sends updated
> directory attributes in the notifications. With this support, the client
> can register interest in a directory and get notifications about changes
> within it without losing its lease.
> 
> [...]

Applied to nfsd-testing, thanks!

[01/21] nfsd: check fl_lmops in nfsd_breaker_owns_lease()
        commit: 106d7871db32223d589617d9be914ff2ba51727a
[02/21] nfsd: add protocol support for CB_NOTIFY
        commit: 06688aedf70b8da555a5c1d9f7feb786eb329eb4
[03/21] nfs_common: add new NOTIFY4_* flags proposed in RFC8881bis
        commit: 1bdad6b6988d15ae56c97a94802cb2a603492a30
[04/21] nfsd: allow nfsd to get a dir lease with an ignore mask
        commit: 6d767c6080b49d8c3d0a4971d5c30d0ad9345622
[05/21] nfsd: update the fsnotify mark when setting or removing a dir delegation
        commit: b8d98337e97ca91b057abf2374dbd2a846663f68
[06/21] nfsd: make nfsd4_callback_ops->prepare operation bool return
        commit: 35b3e3c47909fba5ad04349fb6ba3287c2c70d81
[07/21] nfsd: add callback encoding and decoding linkages for CB_NOTIFY
        commit: 920a750c30c51ac7a884fbe93e9dc42b2ba37992
[08/21] nfsd: use RCU to protect fi_deleg_file
        commit: 1b21b493326b3a782c7f0ede6d8cd47b9af662d1
[09/21] nfsd: add data structures for handling CB_NOTIFY
        commit: c1810ecdb4e5c9205a6c88c86cf61689115d696f
[10/21] nfsd: add notification handlers for dir events
        commit: e38c39f77041388190ebdcde9230371c180769a0
[11/21] nfsd: add tracepoint to dir_event handler
        commit: cc1687d186b0542390badca86c6a87e17c95b378
[12/21] nfsd: apply the notify mask to the delegation when requested
        commit: 552de5c66f1cd234bff61b5afc802cbb58928e36
[13/21] nfsd: add helper to marshal a fattr4 from completed args
        commit: c452947ca425c5e5bb21382f58db015df37bb007
[14/21] nfsd: allow nfsd4_encode_fattr4_change() to work with no export
        commit: ae845b96ebda28672ae1ea1ade51954cea62c2c8
[15/21] nfsd: send basic file attributes in CB_NOTIFY
        commit: 259bcf6151f873f5476412140fd423a96dca7302
[16/21] nfsd: allow encoding a filehandle into fattr4 without a svc_fh
        commit: 772fb85f866cb7e90a1603052416122ccdd48403
[17/21] nfsd: add a fi_connectable flag to struct nfs4_file
        commit: 465b30cd8c24b04f2dcdf1e644ecae87cf847e8b
[18/21] nfsd: add the filehandle to returned attributes in CB_NOTIFY
        commit: b146f3a075b320e76fccecc0dcebef7cd894364f
[19/21] nfsd: properly track requested child attributes
        commit: 8a5ceb0668d694dd8370ee1d702800e730c862b7
[20/21] nfsd: track requested dir attributes
        commit: 824c7f03f1fbeea6f92d0f4da7dca3ecad27cc3a
[21/21] nfsd: add support to CB_NOTIFY for dir attribute changes
        commit: 9e0982d08e135a46aab2bd6d7fe8609c27a8806e

--
Chuck Lever <chuck.lever@oracle.com>

