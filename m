Return-Path: <linux-nfs+bounces-22172-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MJWPCgfCHWrPdQkAu9opvQ
	(envelope-from <linux-nfs+bounces-22172-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 01 Jun 2026 19:31:51 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C6D662343B
	for <lists+linux-nfs@lfdr.de>; Mon, 01 Jun 2026 19:31:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8F0D8301F170
	for <lists+linux-nfs@lfdr.de>; Mon,  1 Jun 2026 17:31:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56D263DDDD7;
	Mon,  1 Jun 2026 17:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d2v7njXN"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 549E12C08BB;
	Mon,  1 Jun 2026 17:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780335089; cv=none; b=ffdLh5oSZzBKO0OE6qQx8srM7asBFqqT43gb/Fd3xG9GA+ymi4Hx/jP6QRyUMHf8wPWEblxi5r7Xgat2AVbszgGCAFpBQFusLG67qCOogRjMNT7Djbw1ZxlQo23rBPLJAbbgu5S3l3V7TXYorHII0YOPLTWyIiCx0fch7JJh39U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780335089; c=relaxed/simple;
	bh=wfnkeJUzLd8k2urmKijV/vQWV8uUvqPxYDRTjXF+FWQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Gt+gYbp/iGFxujzd3TlCvqWzLCwlbUw4aEZnhz0tFJOKfFjsa0Pg7E9Zkn/EduB4XCeZWkvTv/f4rUBHXBtdbVcB7Ikc8vnhs59KPrThG5FgzQaMlfse4CS3/q2Uegc8JhWB/gS5z4JIy+otup/J5RhZx4fFnskMd6oTIz2bXgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d2v7njXN; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A94391F00893;
	Mon,  1 Jun 2026 17:31:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780335088;
	bh=bB30zQdGG8R9Cn5b8pWRoQxRSI+miLRVlNce/6iBh/w=;
	h=From:Subject:Date:To:Cc;
	b=d2v7njXNXXVisViz078uUDfnEsHxEfwarZCFcmYcT99NOw7uQRG2vnr+XSEhSTIj5
	 fBGjZOukIw1a3OxvLRJ+yUqbdCK5ydznOwwDbQuL21D7EekceTfA9GqTDbP5ekXl8K
	 igEs9rnEONVYi3qMtrul2WnVrPTkSIl16nmJE1RLtFDemBioPYiCuy3AAbKvBf6Im+
	 9muZgdtVgV9FcmZi6dhJsoDPU/xF4O+XNmW0UOcsSYuucRSNUCdvNnzdG/DVt9t/pm
	 zZojK6GbflTBzlC0ADXXqALjjoCaUpGLeySiYC0LMd2FGT2krvJwD5Pvn/1b5vo3PY
	 aykGh0nLGjMTg==
From: Jeff Layton <jlayton@kernel.org>
Subject: [PATCH 0/8] nfsd: fixes for locally-triggerable bugs
Date: Mon, 01 Jun 2026 13:31:03 -0400
Message-Id: <20260601-nfsd-testing-v1-0-d0f61e536df8@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MQQqAIBBG4avIrBPGwqCuEi0i/2o2Fk5EIN49a
 fkt3sukSAKl0WRKeETljBWuMbQeS9xhJVRTy23PPTsbNw32ht4Sd4vO8xA8uPOgmlwJm7z/bpp
 L+QC+wBZkXgAAAA==
X-Change-ID: 20260601-nfsd-testing-e3509d5e035e
To: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Lorenzo Bianconi <lorenzo@kernel.org>, 
 Anna Schumaker <anna.schumaker@oracle.com>, 
 Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
 Mike Snitzer <snitzer@kernel.org>
Cc: Chris Mason <clm@meta.com>, linux-nfs@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Trond Myklebust <trond.myklebust@hammerspace.com>, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1553; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=wfnkeJUzLd8k2urmKijV/vQWV8uUvqPxYDRTjXF+FWQ=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBqHcHmHrwpLzVgQUCxo9GjAbKTjQA9g564+JF3I
 wzLgTTh4mmJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCah3B5gAKCRAADmhBGVaC
 FVYJD/4ksca7d/DV3JaTJPCknO4ioEUIeM3cTSkOGm6kfgPmvJni3RmVXJb3/VXY2NKMUUEf9T0
 vTGn9UciKo/IEVqnsybjzsl547NMqh2cdaLHtRBuuAHHEiVkZy/M8/8aeirqrHU+L++DoBgecAY
 rUYh7Z34Cr+6BKizsBqAq2WJ4GRUfQE3S3mhZQiJS8p4n2SDsRwx+kwu6Rk0n344SwuwibhGJ2/
 g/sdilRgpJ8DDIa+oVGjQlKNxyoQi1vm9lGUa/7ewyc6Ev5AEoSBRKfFEUjS/0SO2N84G95w45N
 vDzXPAv6eJljePh4QpEwTjKzh5yrV3369WUWsJgoKtu15TZ2R2gnRWvUnIfsU2hneJO87ZDBVcm
 zracQpiufS8gcUHnKwQe3Qud4acUwXNauO/rIsUTSc1eqYZg0RtWCC4wSBQzQerB6Vhh5utZGbw
 ewtsFS4lhyjn26pFq/3eZu509EaIuI9Ahkai8XpEnNdIu7FVRVU309c5BmdgaP5pFoveu+6v+Fr
 y1+1qy2XW9uA4/Yjfe4y0/gDiMd6aBZ8ja6b6MEaSfdcaSQCBTJPRjYweAQgEW2FgmJ3xJwOlk9
 xKBhrcBsgWgduSgwAKqkGt8RH96hIgCsp7RKamI/Fp9pbjH2QqOM0e7h8mW/iw1Tdz6RXqZRptX
 Q5Akv5FWO8Sw+zA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22172-lists,linux-nfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 9C6D662343B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

These are bugs that Claude classified as locally-triggerable. A couple
can be triggered by an unprivileged user, but the rest require admin
access.

The last 3 patches fix one bug. I originally had a more targeted fix
that kres generated, but I think it's better to simplify the filecache
disposal mechanism to get rid of the bug rather than add more
complexity.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
Chris Mason (3):
      nfsd: hold rcu across localio cmpxchg retry
      nfs/localio: fix ref leak on nfs_uuid_add_file failure
      nfsd: guard nfsd_serv deref in nfsd_file_net_dispose

Jeff Layton (5):
      nfsd: defer vfree of compound ops to fix rpc_status UAF
      nfsd: widen nfsd_genl_rqstp address fields to sockaddr_storage
      nfsd: fix refcount leak in nfsd_file_lru_add on insertion failure
      nfsd: fix fcache_disposal UAF by inlining dispose state into nfsd_net
      nfsd: hold net namespace reference in nfsd_file

 fs/nfs_common/nfslocalio.c |  14 +++++-
 fs/nfsd/filecache.c        | 120 +++++++++++++++++----------------------------
 fs/nfsd/filecache.h        |   2 +-
 fs/nfsd/localio.c          |  12 +++--
 fs/nfsd/netns.h            |   3 +-
 fs/nfsd/nfs4xdr.c          |   2 +-
 fs/nfsd/nfsctl.c           |  12 ++---
 include/linux/nfslocalio.h |   9 +---
 8 files changed, 80 insertions(+), 94 deletions(-)
---
base-commit: d7203affbe85baad683cef946f661c5541966d97
change-id: 20260601-nfsd-testing-e3509d5e035e

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>


