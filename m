Return-Path: <linux-nfs+bounces-23260-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id DOhwGTvsU2r0gAMAu9opvQ
	(envelope-from <linux-nfs+bounces-23260-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sun, 12 Jul 2026 21:34:19 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A8AA1745C5F
	for <lists+linux-nfs@lfdr.de>; Sun, 12 Jul 2026 21:34:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=a4lKNVsr;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-23260-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-nfs+bounces-23260-lists+linux-nfs=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 310E7300C02C
	for <lists+linux-nfs@lfdr.de>; Sun, 12 Jul 2026 19:31:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B72F12FFF89;
	Sun, 12 Jul 2026 19:31:25 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A47D623ABB9
	for <linux-nfs@vger.kernel.org>; Sun, 12 Jul 2026 19:31:24 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783884685; cv=none; b=PkTM5Mx19TP+4yGjFEbNDsFhAuDNHcFdwiHK8xhKZBYMPifvVv8YxMdsGxiTo6eUPbuSe8ER8jCqO0WcttdphY906jEuOYQUSxRtSCpOsVPJ9WuP5qpF6fYhGoXVts2rogfqAG53Pi0hMuDsGRMpU/MSmYoqsSXN16dUQkXIJnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783884685; c=relaxed/simple;
	bh=b5D/zaYe4qSe+A+FLcjhzvcpUVgvT9DwxZeRNzuxCxo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uJ+limnPUgVcMs9WNnNNo8ATdEQ2/ocKA14oFrh+EFaGDpa0XuRTd4pun2iuFCsYjpvlu6JV3JdnUh7jc/P4hm0NUBcZGtCH+3CqLAmqkZTSxuVtiHx/n4OxfyTy8giVx5Exfgy6IK+PvimVp+lgnoDbpuEi22VQW1QYarIWSp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a4lKNVsr; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3E111F000E9;
	Sun, 12 Jul 2026 19:31:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783884684;
	bh=99QzLRXRdiOcmXZlgFFZPtcDco3EFK6oXdwJ2NOC9LY=;
	h=From:To:Cc:Subject:Date;
	b=a4lKNVsrc2yzYp2+s3WDwrgMmMV6jLgIL/HA8yujPjR7/cKNO/bqRiEkPjiYcQ3N/
	 svzTkn/kFxkN/e7ffEIui1NWaqHHwVisg4ch+8MYwl+oX5v0VJEqvpQt0CRS/oSTUc
	 UIU+PssHi9I0MwacwvA7EoymadTnKLOSs7qLeefG/GNUKbuiaxAwHQJ0MaROKLODYw
	 wt3V4l5l0R6JubIspqg1oOMJQRPNPnmv+K3DsHbE68FjGbfpIdtQCRlpwkbnGZyLPn
	 26/d/lR5HIhlJPnoYNNfKaiRWt6gwwIzqjVfhkU4W3C57z/gYL858krX2PY0aK/txB
	 dQOEYjj0wYY0w==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>
Subject: [PATCH 0/5] Minor fixes for xdrgen
Date: Sun, 12 Jul 2026 15:31:17 -0400
Message-ID: <20260712193122.116845-1-cel@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-23260-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A8AA1745C5F

While working on server-side xdrgen conversion for NFSv2 and NFSv3,
I found several unrelated minor issues with the xdrgen tool. They
are collected here in this series.

Chuck Lever (5):
  xdrgen: Emit a blank line ahead of enum declarations
  xdrgen: Share void RPC procedure handlers across programs
  xdrgen: Do not declare union XDR functions in the definitions header
  xdrgen: Add XDR width macros for short integer types
  xdrgen: Fix opaque and string encoders for unbounded members

 fs/lockd/nlm3xdr_gen.c                        | 30 +-------------
 fs/lockd/nlm3xdr_gen.h                        |  4 +-
 fs/lockd/nlm4xdr_gen.c                        | 30 +-------------
 fs/lockd/nlm4xdr_gen.h                        |  4 +-
 fs/lockd/svc4proc.c                           | 40 +++++++++----------
 fs/lockd/svcproc.c                            | 40 +++++++++----------
 fs/nfsd/nfs4xdr_gen.c                         |  2 +-
 fs/nfsd/nfs4xdr_gen.h                         |  5 ++-
 include/linux/sunrpc/xdrgen/_builtins.h       | 32 +++++++++++++++
 include/linux/sunrpc/xdrgen/_defs.h           |  2 +
 include/linux/sunrpc/xdrgen/nfs4_1.h          |  2 +-
 include/linux/sunrpc/xdrgen/nlm3.h            |  2 +-
 include/linux/sunrpc/xdrgen/nlm4.h            |  2 +-
 tools/net/sunrpc/xdrgen/generators/program.py |  8 ++++
 .../templates/C/enum/declaration/enum.j2      |  1 +
 .../templates/C/pointer/encoder/string.j2     |  2 +
 .../pointer/encoder/variable_length_opaque.j2 |  2 +
 .../templates/C/program/decoder/argument.j2   |  4 --
 .../templates/C/program/encoder/result.j2     |  4 --
 .../templates/C/struct/encoder/string.j2      |  2 +
 .../struct/encoder/variable_length_opaque.j2  |  2 +
 .../templates/C/union/definition/close.j2     |  6 ---
 22 files changed, 103 insertions(+), 123 deletions(-)

-- 
2.54.0


