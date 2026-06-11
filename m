Return-Path: <linux-nfs+bounces-22447-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id BG8dMHoWKmoxigMAu9opvQ
	(envelope-from <linux-nfs+bounces-22447-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Jun 2026 03:59:22 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 197A566DBA6
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Jun 2026 03:59:22 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=iUIz9z94;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22447-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22447-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CBA893047BCD
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Jun 2026 01:59:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 613FA18787A;
	Thu, 11 Jun 2026 01:59:20 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A33217A2EA
	for <linux-nfs@vger.kernel.org>; Thu, 11 Jun 2026 01:59:19 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781143160; cv=none; b=lr/CAdPbsPz9qK7vPE60A4g0kz1RA2V8PBcKhzZBhfob4RYCQAcGeJdspbeSBhAgyY744qFHO4Jcu/3JGlXDdUHq6TQ324nSrICGGjQYgLc37PWfMjvpEWF6zy/FijTWB+MdVYd2B3I8UrKQx0N/Iv+lgzWlqdOziE+ykVamrUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781143160; c=relaxed/simple;
	bh=ztWTTfGfMMhSMrfWvVr2lW1KXj4PVIX/9vRpY3URXFI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=sASXzCUo0hpeG0XfaI/vYWSrPV8YriJBT87WH4bm+bZhDNLIhecO8aG314CurdrpcldZkFkR+vyiaMeuHKtzF1MT/Fx9hWqmRgIgqe07yk+crhO9GSXSrCBS5y7LDPAlaF3XS7NSyleEJy39JYoyd6aupglilA9pp1kd6eFHjzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iUIz9z94; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 469D11F00893;
	Thu, 11 Jun 2026 01:59:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781143158;
	bh=tNQhLrD3oqSMjYV0g3oWfkGSuCdXNGBkWVwqywo5uGo=;
	h=From:Subject:Date:To:Cc;
	b=iUIz9z94yfI19TpOiJRRHyw92z0QaIy+5YRiOHpOYfm9kBrFAkCfLdCx06IV5QlAW
	 5WG42zIOOoaZVgtkK8WyjjZuoqouTQ8eFMcAGBjPP+l/GNwiJS4hxCuYSRfFSFg6VB
	 DbBFAgX33T0js9GnD1TbCpPiodDgVkkvdo7lq7ImY53KaOjRGbtmUqccMjh+KhzSQc
	 6QCbrbQsafrcWyogTLtciAIPYEeO7ZeU5+zUBnG4xAj8ewbv3N1DOKI5UmTwn1Xwes
	 rSzUZVtWuEiR3oU1ODLbkpRUvCc+7peKjo5eJY2LTG5+D/bdjezvEkTpmCM7sC85ps
	 +21/VfABNzc/g==
From: Chuck Lever <cel@kernel.org>
Subject: [PATCH 0/5] RFC: Stop NFSv4.1 slot-growth heuristic from rewarding
 busy clients
Date: Wed, 10 Jun 2026 21:58:52 -0400
Message-Id: <20260610-nfsd-slot-growth-clamp-v1-0-7b966700df0b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWMQQqDMBBFryKz7kA0kEqvUrpIxtGkaJRMbAvi3
 Zu0y/f57x0gnAIL3JoDEr+ChDUWaC8NkLdxYgxDYehUZ5RpFcZRBpR5zTil9Z090myXDckqzVr
 35toTFHlLPIbPL3x//Fl292TKtVYfzgqjSzaSr9NiJXOC8/wCdffY25MAAAA=
X-Change-ID: 20260610-nfsd-slot-growth-clamp-ca03e338678c
To: Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>
Cc: Benjamin Coddington <bcodding@hammerspace.com>, 
 Jonathan Flynn <jonathan.flynn@hammerspace.com>, linux-nfs@vger.kernel.org, 
 Chuck Lever <chuck.lever@oracle.com>
X-Mailer: b4 0.16-dev-da966
X-Developer-Signature: v=1; a=openpgp-sha256; l=3301; i=cel@kernel.org;
 h=from:subject:message-id; bh=ztWTTfGfMMhSMrfWvVr2lW1KXj4PVIX/9vRpY3URXFI=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBqKhZsnZ+rj8Jrb4/w6jwP+nczBggtuYUBQBJjl
 8IvuH9tQlCJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCaioWbAAKCRAzarMzb2Z/
 l6gcD/9I60Q3YnfFGygt7cRDhWMvkN3U7tXrXx/C4D3Ande2matIIKAbXDJtQUh5sShd7SGqEmw
 GbqkK7dKfag1dAm3wMdbLSRAN6b6nTb61SdjEugSmcX36kvrD7bzmTjHFUHjpdkpz4SNrD5SOOt
 y8EedXAOzYD36p2NNjuBoBD4yv+AEFr6pq7dWcHdHvRl3fhiOAM40a/6dlOevuxmC31HHLxPZg+
 YC/RGNPIKlN7rm+HjPfqqKRewPYYRuAMNQGzJ+EZ7Vt81uCc97vlgSF/ifwKUbbOMPc4+N/Pg4W
 483bGoefkPviLK8QNYbf6NCHkOuAo1MQUvGlkduL2hIE5JBQsKTvORyFLoayCVGC3G1eH8+sSDe
 CryEPZHlJ/if+WOs21qTISwFV40sTEJzo1JoKXCN0efxS7xPpOWK2PvSvx5bSXq04OrA5AUY8k0
 5cIDbWhGMcftP2nOV12FR9HbAqDwIlHnIM6V1n3AgfuMgLm/BHaadZ1Hv3x5EM0bPCPUwPAqXCd
 mSn3HJ9f/gL50vdTK8D/iHHOUCR1CARezz14IrhTplMgJZYdgvIwrJJQ19NSfwD1xIQyNeyf1ZI
 ijalz24TucUN5VDkElSHWni4KLYfJU8ZZjudh0T2r6lIWCyHrJ9RnwbnDrn70E5jClk0UOItwiP
 ZKQG7PAAby9Gdqw==
X-Developer-Key: i=cel@kernel.org; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22447-lists,linux-nfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:jlayton@kernel.org,m:neil@brown.name,m:okorniev@redhat.com,m:Dai.Ngo@oracle.com,m:tom@talpey.com,m:bcodding@hammerspace.com,m:jonathan.flynn@hammerspace.com,m:linux-nfs@vger.kernel.org,m:chuck.lever@oracle.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[linux-nfs];
	MID_RHS_MATCH_FROM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 197A566DBA6

This series grew out of Ben Coddington's fair-queueing RFC and the
discussion it prompted with Neil Brown: a single busy NFSv4.1 client,
opening many connections against a large slot table, can keep enough
requests in flight to monopolize the nfsd thread pool and starve its
peers [1]. Where fair queueing itself belongs is still being worked
out. One change, though, holds no matter which design wins -- the
server should not actively widen the gap, and today it does.

nfsd4_sequence() grows a session's slot table by 20% every time the
client reaches its highest slot, so it hands the client already
keeping the most threads busy a still larger table; one session can
climb toward 2048 slots on a server with far fewer threads to run
them. This series caps that growth where added slots stop buying
concurrency, and leaves the dynamic-slot machinery otherwise intact.

Two design points are worth checking against the diffs.

The cap is per session, not per namespace, and deliberately so. A
budget shared across a namespace's sessions breaks at the floor:
every active session permanently holds slot 0, which the shrinker
never reclaims, so once the session count alone reaches the thread
ceiling those floors exhaust a shared budget and pin the one busy
client small while the pool sits idle. Making that floor explicit is
a self-contained accounting cleanup -- nfsd_total_target_slots gains
the full-target meaning its name implies, and the never-reclaim-slot-0
correction moves to the one place that reads it, the shrinker's count
callback. Since a session cannot use another's slots, capping each
independently against the ceiling is the natural choice.

The ceiling is a sunrpc-owned quantity. Maximum sustainable
concurrency is a property of svc_serv and svc_pool, so
svc_serv_maxthreads() lives in sunrpc, and nfsd_nrthreads()'s
open-coded sum is converted to it rather than nfsd carrying a second
copy. It sums each pool's configured maximum, not the running thread
count: nfsd sizes its pool dynamically, and gating on the live count
would deny a client resuming from idle the slots it needs before the
pool scales back up.

This removes a perverse incentive; it is not slot admission control.
A client still sizes its sessions at CREATE_SESSION, and per-client
fairness against thread starvation belongs in the dispatch layer,
where the larger discussion continues.

[1] https://lore.kernel.org/linux-nfs/cover.1780498019.git.bcodding@hammerspace.com/

---
Chuck Lever (5):
      SUNRPC: Add svc_serv_maxthreads() to report the thread ceiling
      NFSD: Count slot 0 in nfsd_total_target_slots
      NFSD: Clean up documenting comment for reduce_session_slots()
      NFSD: Document and rename the NFSv4.1 session slot shrinker callbacks
      NFSD: Bound on-demand DRC slot growth by the thread ceiling

 fs/nfsd/nfs4state.c        | 115 +++++++++++++++++++++++++++++++--------------
 fs/nfsd/nfssvc.c           |  12 +++--
 include/linux/sunrpc/svc.h |   1 +
 net/sunrpc/svc.c           |  23 +++++++++
 4 files changed, 113 insertions(+), 38 deletions(-)
---
base-commit: 4549871118cf616eecdd2d939f78e3b9e1dddc48
change-id: 20260610-nfsd-slot-growth-clamp-ca03e338678c

Best regards,
--  
Chuck Lever <cel@kernel.org>


