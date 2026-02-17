Return-Path: <linux-nfs+bounces-18983-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ED8AKaDmlGmjIgIAu9opvQ
	(envelope-from <linux-nfs+bounces-18983-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 17 Feb 2026 23:07:28 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 6503C15149E
	for <lists+linux-nfs@lfdr.de>; Tue, 17 Feb 2026 23:07:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C953030039BF
	for <lists+linux-nfs@lfdr.de>; Tue, 17 Feb 2026 22:07:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D778C31328B;
	Tue, 17 Feb 2026 22:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rnfyfH6g"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5785313276
	for <linux-nfs@vger.kernel.org>; Tue, 17 Feb 2026 22:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771366046; cv=none; b=brVX5dxLS9FSe0cQG3IEJkhMVVfOX2lqyx/z17hR7K8ytOxp3Fc7oXuMa9vPdLmvA01BzWsez83m4CStjsCoTJEOum+x2I45bFBSRJf8boNrkmz6KpH1/1BI0ujHzeEneKddNcC2jOKjlcfAyf+6Jcs4+5LIYmG+fJnEbRI8UBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771366046; c=relaxed/simple;
	bh=eMlcK0Jqf3u8gXsSPN0q/Y2ywQB2hmXqqOT0tKd+io0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=umh2R0YN12PM0qQaAkgtsgHRZ6t/4Izr1erqryuQlpck/aFgmb1IeMPFr2jcgM56yx0xLe5s8VlklFOtLqTfY1UMpLdctoOXPdeCldMKOSFq1MsbxKDhI/y/P6h5cs+++72ikqRr4vh3MNmYSEuhRoMhG5a87q49WfPfnLm5K8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rnfyfH6g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B990BC4CEF7;
	Tue, 17 Feb 2026 22:07:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771366046;
	bh=eMlcK0Jqf3u8gXsSPN0q/Y2ywQB2hmXqqOT0tKd+io0=;
	h=From:To:Cc:Subject:Date:From;
	b=rnfyfH6gfLNEtLrixjPTZ68sVwA9GE37yqt3Z9b28ImWCBNiRd393cNWNzcihkQPw
	 IFWEWgeF2fr77ZITY9aIjoY0i05weMp2JR5YSmJ6QKE5M2LZt1rG+DcILAiLNroSy9
	 JvvyteYH0WH82+QLlI3T9FQwJYCnesWQts1LDodGHKs01RLZ6pZWChiahydhYzH2N0
	 kHnA9TIeNGsCQoS407zROifEVXfKFauX9LFxtFbX/Cs79jsWYG11y3VZtwa4Eh/MgF
	 wVT6v7aH4yceVLjb0EfOzdrlklZLT9aNrvBGoTnbvEvn3WGe9IdGmv+kD9OXFSGNN7
	 /mU7RvFNz3O2g==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neilb@ownmail.net>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v3 00/29] Convert lockd to use xdrgen for NLMv4
Date: Tue, 17 Feb 2026 17:06:52 -0500
Message-ID: <20260217220721.1928847-1-cel@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[ownmail.net,kernel.org,redhat.com,oracle.com,talpey.com];
	TAGGED_FROM(0.00)[bounces-18983-lists,linux-nfs=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6503C15149E
X-Rspamd-Action: no action

From: Chuck Lever <chuck.lever@oracle.com>

This series modernizes the NLMv4 XDR layer using XDR generated by
the xdrgen tool.

Based on the public nfsd-testing branch.

---

Changes since v2:
- Pre-requisite changes have been applied to nfsd-testing

Chuck Lever (29):
  Documentation: Add the RPC language description of NLM version 4
  lockd: Use xdrgen XDR functions for the NLMv4 NULL procedure
  lockd: Use xdrgen XDR functions for the NLMv4 TEST procedure
  lockd: Use xdrgen XDR functions for the NLMv4 LOCK procedure
  lockd: Use xdrgen XDR functions for the NLMv4 CANCEL procedure
  lockd: Use xdrgen XDR functions for the NLMv4 UNLOCK procedure
  lockd: Use xdrgen XDR functions for the NLMv4 GRANTED procedure
  lockd: Refactor nlm4svc_callback()
  lockd: Use xdrgen XDR functions for the NLMv4 TEST_MSG procedure
  lockd: Use xdrgen XDR functions for the NLMv4 LOCK_MSG procedure
  lockd: Use xdrgen XDR functions for the NLMv4 CANCEL_MSG procedure
  lockd: Use xdrgen XDR functions for the NLMv4 UNLOCK_MSG procedure
  lockd: Use xdrgen XDR functions for the NLMv4 GRANTED_MSG procedure
  lockd: Use xdrgen XDR functions for the NLMv4 TEST_RES procedure
  lockd: Use xdrgen XDR functions for the NLMv4 LOCK_RES procedure
  lockd: Use xdrgen XDR functions for the NLMv4 CANCEL_RES procedure
  lockd: Use xdrgen XDR functions for the NLMv4 UNLOCK_RES procedure
  lockd: Use xdrgen XDR functions for the NLMv4 GRANTED_RES procedure
  lockd: Use xdrgen XDR functions for the NLMv4 SM_NOTIFY procedure
  lockd: Convert server-side undefined procedures to xdrgen
  lockd: Hoist file_lock init out of nlm4svc_decode_shareargs()
  lockd: Prepare share helpers for xdrgen conversion
  lockd: Use xdrgen XDR functions for the NLMv4 SHARE procedure
  lockd: Use xdrgen XDR functions for the NLMv4 UNSHARE procedure
  lockd: Use xdrgen XDR functions for the NLMv4 NM_LOCK procedure
  lockd: Use xdrgen XDR functions for the NLMv4 FREE_ALL procedure
  lockd: Add LOCKD_SHARE_SVID constant for DOS sharing mode
  lockd: Remove C macros that are no longer used
  lockd: Remove dead code from fs/lockd/xdr4.c

 Documentation/sunrpc/xdr/nlm4.x    |  211 ++++
 fs/lockd/Makefile                  |   30 +-
 fs/lockd/clnt4xdr.c                |    2 -
 fs/lockd/lockd.h                   |    7 +
 fs/lockd/nlm4xdr_gen.c             |  724 ++++++++++++
 fs/lockd/nlm4xdr_gen.h             |   32 +
 fs/lockd/share.h                   |   11 +-
 fs/lockd/svc4proc.c                | 1773 +++++++++++++++++++---------
 fs/lockd/svcproc.c                 |    7 +-
 fs/lockd/svcshare.c                |   35 +-
 fs/lockd/xdr.c                     |    3 +-
 fs/lockd/xdr4.c                    |  337 ------
 fs/lockd/xdr4.h                    |   33 -
 include/linux/sunrpc/xdrgen/nlm4.h |  233 ++++
 14 files changed, 2474 insertions(+), 964 deletions(-)
 create mode 100644 Documentation/sunrpc/xdr/nlm4.x
 create mode 100644 fs/lockd/nlm4xdr_gen.c
 create mode 100644 fs/lockd/nlm4xdr_gen.h
 delete mode 100644 fs/lockd/xdr4.c
 delete mode 100644 fs/lockd/xdr4.h
 create mode 100644 include/linux/sunrpc/xdrgen/nlm4.h

-- 
2.53.0


