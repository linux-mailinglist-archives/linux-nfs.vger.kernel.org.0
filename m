Return-Path: <linux-nfs+bounces-22235-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id zFpvIAtIIGpQ0AAAu9opvQ
	(envelope-from <linux-nfs+bounces-22235-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 03 Jun 2026 17:28:11 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B3696392DF
	for <lists+linux-nfs@lfdr.de>; Wed, 03 Jun 2026 17:28:10 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=hammerspace.com header.s=google header.b=Iw+zEvIf;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22235-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22235-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=hammerspace.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7BF2330DBCF8
	for <lists+linux-nfs@lfdr.de>; Wed,  3 Jun 2026 15:09:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 395ED38AC8D;
	Wed,  3 Jun 2026 15:09:48 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75F57399354
	for <linux-nfs@vger.kernel.org>; Wed,  3 Jun 2026 15:09:46 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780499388; cv=none; b=atcpZLAI3QgEkpXKrlvyXdK38Yxfd31U/Xk2vw8bSYBOQN00n2jw0YNWZjVIAOBf+h07EfKsDbzUwsB/aD2J6oGIbR5dMPEWqNutZjrEh0huaG66spNAB7nJMqiUzOqDrq7M4bRafhOmbTcrDkhdN7CCUr36xhZxJQdYgFtSSlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780499388; c=relaxed/simple;
	bh=2PxKA5LecMMhbsKrTH/C+pdpgOQ8LY8gTofFm+cN49c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FU1sWyqdmTJwilzPdUHQKy1Keu/dChov0oStJnKUzRPauPgRSsBtrmTpw2ENmQYQd/whO0mFRGtrnZXI3rd5KBEMJFdk6GgcLouhIeONJMu2854Hg9DKFPFYfwO3H6gETVNtoWA0+UhBt0yCZR4+b/EWcFTNI+mhP9iRqHD2YMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hammerspace.com; spf=fail smtp.mailfrom=hammerspace.com; dkim=pass (2048-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=Iw+zEvIf; arc=none smtp.client-ip=209.85.160.41
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-43b7e186a0cso3915606fac.0
        for <linux-nfs@vger.kernel.org>; Wed, 03 Jun 2026 08:09:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hammerspace.com; s=google; t=1780499385; x=1781104185; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tMPgs6f1YKa0Md4obtYmNfwn1FChqETfWiF+VgB8h50=;
        b=Iw+zEvIf2+3zaHiWNua+BLwQsAfJOXqcrti6g3nUZSf8GZ89zLuy7Q0ueDBdrCPPfh
         ABF6C/P0wKYidbseLQ4W+NRZKYDDcnG2w/o5LpNAuBwtr3OGQQFWtZxzn0SVfwvYwZCM
         qMFQ/3aTYqkUqQAr0d5vyM0292lqb6V2p/f64tKLR3TBERfwjesz9zg6jjpb9oZ5inyF
         RhtFcXLWUDJK7Wz69Fd5NZL6ZSg9QaWECIaNzncWlEHJVi5xcLJXAQlS6jdLYPgl+FYI
         Hsr8cCMY698b9C9iS8gpM0atBasl9EUJP4BuiMRlOf8l1oGD4Tsr2Np756MWdU2HosnS
         JrZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780499385; x=1781104185;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tMPgs6f1YKa0Md4obtYmNfwn1FChqETfWiF+VgB8h50=;
        b=jv5G3xinztzMRi32Dkj1fTCygQHBDgFFBT/Q2dKRIlAva0WEmzqTAlsYbiHDLd6Gos
         MfQxZTOLOB7D+8nMo+8Jc1PFSLVrTTCMs8lHsJ726hGbd+ZOJGD8KfQ97mawIA6bocgv
         WY+XOIynIGOoA/9SsMWOIa5s5ErFI0CU79k6h06LH9egB6dnv/raEwyodGsoh8Tcnyqm
         guRmQ5MUCrrNubTVeEUk9KYWeYpRhnzzC/+RLzuNeOye8k3ZfR1oQXVrB2XPE/gP4lzh
         RenTaOhCOXWHdm613rpcFbwZ0TiuC6b6lIC0DZWxJ0zzB6tb79FkZfKJkXemloPbHmWx
         IqSQ==
X-Gm-Message-State: AOJu0YyrerdBsPEh6eMIMfw5Gcehgb2NKokO8LQGA8RREnrPSCcIfz5S
	+FVgh40C16DlwSKPA6qfoI9iuRItL/C0SNbfJTo0fhtJZn8MNYe9eR/9YUHIHkLuwJAVYfg9Oa7
	t7Aum
X-Gm-Gg: Acq92OGal10oHgXNGjGCsY7f7m2BXy/7GX7wkzoSFeUQhr8em1vt+aiCPyf2UIkqfsz
	CJgb7W4+Rmu8YwR5ND9kmty7zDLv6HZMVjQoOt4VxwQ+CHldYtgHJvuBmnGXkjBTF/XQzk9vw/y
	Ghvnf8Pk5OtDaiPtB/RczBdZvpG+84AciPIU4yicT7rn6Q61A/+W3bNlaKiMYHryBYFDj1mhW1F
	5i/x1M6W59AroZ2yKINirvlVT08RUJDGuK5+qYO+ULIQWc6uDDlM/G81VtLPt32JICoOS2IHLqs
	BL+eUulg2PsKzYfAU2jnErx9JQxBPLD5bsV04H7ia0QHS15xnwvyroIeI4NNz9nxzkD7DtF3F/N
	LI1uiPA+GWSH8+CXm70SI1uQTX90AJ1F5rtRUMz0iQ1AoUXc64qP4u7Z+t5ZasP6gWsXDP9PWs3
	9TNb0VhFBtikEnpIAGjcKk5Xj3wEb4OJV9Y1WuorhmALxqGgtSvkU/OFfYDLw+di3rtsXwOg==
X-Received: by 2002:a05:6870:8e0c:b0:42c:1a2f:bd15 with SMTP id 586e51a60fabf-440dba0f995mr2485819fac.32.1780499385216;
        Wed, 03 Jun 2026 08:09:45 -0700 (PDT)
Received: from bcodding.csb.hammerspace.com ([66.97.168.37])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-440d84c0ce2sm2917634fac.16.2026.06.03.08.09.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 08:09:44 -0700 (PDT)
From: Benjamin Coddington <ben.coddington@hammerspace.com>
X-Google-Original-From: Benjamin Coddington <bcodding@hammerspace.com>
To: Chuck Lever <cel@kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	NeilBrown <neilb@ownmail.net>
Cc: linux-nfs@vger.kernel.org,
	Daire Byrne <daire@brahma.io>
Subject: [PATCH RFC 0/4] nfsd: per-client fair-queue dispatch
Date: Wed,  3 Jun 2026 11:09:38 -0400
Message-ID: <cover.1780498019.git.bcodding@hammerspace.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[hammerspace.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[hammerspace.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:cel@kernel.org,m:jlayton@kernel.org,m:neilb@ownmail.net,m:linux-nfs@vger.kernel.org,m:daire@brahma.io,s:lists@lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,ownmail.net];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22235-lists,linux-nfs=lfdr.de];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[ben.coddington@hammerspace.com,linux-nfs@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ben.coddington@hammerspace.com,linux-nfs@vger.kernel.org];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	DKIM_TRACE(0.00)[hammerspace.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8B3696392DF

knfsd dispatches ready transports from a single per-pool FIFO, so a
client's share of nfsd service scales with the number of connections it
holds rather than being shared per client.  A client that opens many
connections (nconnect, or a farm of data movers) starves other clients
on the same server purely by out-numbering them in sockets.

I measured this with a load generator that pins each request to a fixed
service time and does no filesystem work, so that nfsd thread-time is the
only scarce resource (8 threads, 10ms/op, ~648 ops/s pool ceiling).  A
greedy client opens K connections alongside one single-connection
interactive client.

NFSv3, dispatch as it is today:

  greedy K   greedy share   interactive ops/s
     1           50%              241
     4           80%              129
     8           89%               72
    16           94%               38

The interactive client's share tracks 1/(K+1) and its throughput falls
roughly 6x while it does nothing different.  NFSv4.1 behaves identically
(89% greedy at K=8) even when the greedy connections are bound to a
single session, because the dispatch decision is below the NFS version.

The same NFSv4.1 workload with fair queueing enabled:

  greedy K   greedy share   interactive ops/s
     8           72%              182
    16           73%              177
    32           70%              193

The greedy client's share no longer climbs with its connection count and
the interactive client recovers (72 -> 182 ops/s at K=8).  Aggregate
throughput is unchanged: the T/D pool ceiling is the same with fair
queueing on and off.  The split does not reach 50/50 because a single
interactive connection is bounded by its request window and by XPT_BUSY
serialising one transport; with a deeper window it reaches ~59/41.

The approach:

  - sunrpc grows an opaque per-transport fairness key (patch 1), with a
    default derived from the source address (the source port is excluded
    so a client's several connections share one key), and an opt-in
    per-pool scheduler that buckets ready transports by that key and
    dispatches round-robin across keys (patch 2).  When it is disabled,
    which is the default, the existing lockless FIFO path is unchanged.

  - nfsd gains a "fairq" module parameter to turn it on (patch 3) and
    stamps the NFSv4.1 clientid as the key when a connection binds to a
    session (patch 4), so all of a client's connections share one key.
    NFSv3 uses the source-address default.

This is an RFC; a few questions for the list:

  - Unit of fairness: clientid (used here) or session?  Earlier
    discussion leaned toward exploring per-session.

  - Mechanism: a fixed bucket hash under a per-pool spinlock taken only
    on the opt-in path, versus a lockless or per-flow structure.

  - Would a per-client in-flight cap be preferable to proportional fair
    queueing?

The measurement used a debug-only filehandle-latency hook that is not
part of this series.

Benjamin Coddington (4):
  sunrpc: add a per-transport fairness key to svc_xprt
  sunrpc: dispatch ready transports fairly per client
  nfsd: add a fairq module parameter
  nfsd: key NFSv4.1 connections by clientid for fair queueing

 fs/nfsd/nfs4state.c             |  17 +++
 fs/nfsd/nfssvc.c                |  19 +++
 include/linux/sunrpc/svc.h      |   5 +
 include/linux/sunrpc/svc_xprt.h |  46 ++++++-
 net/sunrpc/svc.c                |   2 +
 net/sunrpc/svc_xprt.c           | 216 +++++++++++++++++++++++++++++++-
 6 files changed, 302 insertions(+), 3 deletions(-)


base-commit: e7ca66ba17f1b5e4ecbb29b9c3c4a31aa062bed0
-- 
2.53.0


