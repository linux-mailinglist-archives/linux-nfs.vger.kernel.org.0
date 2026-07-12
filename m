Return-Path: <linux-nfs+bounces-23266-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id lcQDDHn6U2osggMAu9opvQ
	(envelope-from <linux-nfs+bounces-23266-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sun, 12 Jul 2026 22:35:05 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F970745D90
	for <lists+linux-nfs@lfdr.de>; Sun, 12 Jul 2026 22:35:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=P08I5+K2;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-23266-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-nfs+bounces-23266-lists+linux-nfs=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AC05630041FD
	for <lists+linux-nfs@lfdr.de>; Sun, 12 Jul 2026 20:35:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9A893B4EA9;
	Sun, 12 Jul 2026 20:34:57 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FFF1346784
	for <linux-nfs@vger.kernel.org>; Sun, 12 Jul 2026 20:34:54 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783888496; cv=none; b=GP5Z46r5wF3hcFrrPAA3eTluJ+n+N13+nCU+as5JufmviQ1rUNVtLcszeXQNqXsRDUpibSMlQBZp5LUBHMpIyRiiEQp9YwwNmJesATWUFIT0BjLB7vMzBfI9HgWI7g0sKLKqCIHaPqtoRH0kIuSYIV3Z/kDcVj+QRvx9Mg4rvoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783888496; c=relaxed/simple;
	bh=oRBIIOtbhtZpW/AWBg744OVhC1Dr/1jvtIlRb++JUCM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YnHauadadcLeZBAuwuUB2k0voOjy2wbZ6NR5AaeMJX9jl2y4VNa7+4qmDOE1yhip3+JmCe60wrNFlh7oK9roXgB8Ky4DDTf+VFtIgkoLr3Ut4TfDxQ7ZC598Bnk/AqYCDTAGNsEky7Ey8Jf/tqMOc2D/vEHENjAIoGKHWE/iFsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P08I5+K2; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54A731F00A3D;
	Sun, 12 Jul 2026 20:34:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783888492;
	bh=pC8+rW3o0ovY1i9TOictWVegS4kPYoX6HpOb2rdlods=;
	h=From:To:Cc:Subject:Date;
	b=P08I5+K2de3uj91VCAcwASMCF5hpXrDs6qU+OAc9Mm3nrl85JfYnCVAVpKsK6M/JX
	 cpEUBBvsmmrQoRUE1MybxdILZQ8EjWgCd/ceOCN12Kr4kMMUR5mLWHZMUX4xpTgRbg
	 eQdkk705NqUhgqtQD3NWVeZE/i2nt7zuu52Unymk/GhJ7ILSghqj84uc+xxhApwrjn
	 8fr5TrVSAOaDiynAMwhZIQBpowdxiG9/zI2iz8LhroxTLUfO73rMBDPq4ZofK155QB
	 PwTAGBoOOFdpC9TaQN8YvaCYMElNzMUFSQ7F7lw6esfRIN+IO0PwnuEvDUD+8I7bXn
	 LGozLDBBEDa6g==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>
Subject: [PATCH 0/5] xdrgen: Improve diagnostic reporting
Date: Sun, 12 Jul 2026 16:34:46 -0400
Message-ID: <20260712203451.124902-1-cel@kernel.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-23266-lists,linux-nfs=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:neil@brown.name,m:jlayton@kernel.org,m:okorniev@redhat.com,m:dai.ngo@oracle.com,m:tom@talpey.com,m:linux-nfs@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9F970745D90

Add missing detection and reporting for semantic errors specified in
RFCs 4506 and 5531.

Chuck Lever (5):
  xdrgen: Align the error caret under tab-indented source
  xdrgen: Record the source position of each declared identifier
  xdrgen: Reject specifications that define a name twice
  xdrgen: Enforce RFC 5531 name and number scoping for RPC programs
  xdrgen: Reject out-of-range program, version, and procedure numbers

 .../net/sunrpc/xdrgen/subcmds/declarations.py |  10 +-
 .../net/sunrpc/xdrgen/subcmds/definitions.py  |   7 +-
 tools/net/sunrpc/xdrgen/subcmds/lint.py       |   7 +-
 tools/net/sunrpc/xdrgen/subcmds/source.py     |   7 +-
 .../tests/bad-procedure-number-negative.x     |  20 ++
 .../tests/bad-procedure-number-too-large.x    |  20 ++
 .../tests/bad-program-number-negative.x       |  19 ++
 .../tests/bad-program-number-too-large.x      |  19 ++
 .../tests/bad-version-number-negative.x       |  19 ++
 .../tests/bad-version-number-too-large.x      |  19 ++
 tools/net/sunrpc/xdrgen/xdr_ast.py            | 290 +++++++++++++++---
 tools/net/sunrpc/xdrgen/xdr_parse.py          |  46 ++-
 12 files changed, 428 insertions(+), 55 deletions(-)
 create mode 100644 tools/net/sunrpc/xdrgen/tests/bad-procedure-number-negative.x
 create mode 100644 tools/net/sunrpc/xdrgen/tests/bad-procedure-number-too-large.x
 create mode 100644 tools/net/sunrpc/xdrgen/tests/bad-program-number-negative.x
 create mode 100644 tools/net/sunrpc/xdrgen/tests/bad-program-number-too-large.x
 create mode 100644 tools/net/sunrpc/xdrgen/tests/bad-version-number-negative.x
 create mode 100644 tools/net/sunrpc/xdrgen/tests/bad-version-number-too-large.x

-- 
2.54.0


