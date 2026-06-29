Return-Path: <linux-nfs+bounces-22878-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id nsn1IfSwQmos/wkAu9opvQ
	(envelope-from <linux-nfs+bounces-22878-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Jun 2026 19:52:52 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 856256DDE4E
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Jun 2026 19:52:51 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=YNNqG3WM;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22878-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22878-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8AE8E300720F
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Jun 2026 17:48:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E19837F8B1;
	Mon, 29 Jun 2026 17:48:26 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7B712C2360;
	Mon, 29 Jun 2026 17:48:24 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782755305; cv=none; b=kzlrHFGkgZTtnq7VUvrxh/Debma/V7T+Arj8JDibHi0MtHMUpFbBBehprA/IdEKVZKcXm2rqnqb9DCObTXTVT4xm5S356k1+zXbctOAXAK2QXbDR3ozRUGcN/Jihx40mbIEDsydDWNYJPwWftaVD6IO9Cn5r7EHtcSWvki4vPAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782755305; c=relaxed/simple;
	bh=rVwwBj0IXKRGpyPzpLQLuQHJcowq+zOrIyiLcDEaG6E=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=f4ccVrCIXJ6crXWAifp3zti78Ue8N5VZsABiAcm5CZDFr6LDIKiUf1G7m22SKyS6MEuNWxLQKCPKx/y45H2/lY9MIWf5O2w6l1PdJC4EMBEyfLClFs/QIa3A7ppHLCD+4r8m+PccQSO+oI23H3gURcMMtZnjNMosGsUy4v3/ikM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YNNqG3WM; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D65F1F000E9;
	Mon, 29 Jun 2026 17:48:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782755304;
	bh=0Zp0WPQwfxwHO4YDczUn9V6N0XXYiebdEzrw2p7iYKA=;
	h=From:Subject:Date:To:Cc;
	b=YNNqG3WM6lDLFsfF+XqhGz31D5CfmD8Uthft6MYAdvC7Vrt5743twx8osnA7PiDdi
	 /XpYVg79MRXXwQPfCg6gQsHMJCdRwKEg4exGvn6OIy7u0xhaXLOwHYej2WZ+mA2Yub
	 3/EKWIpQZBjZw0f+FbEjAP5X/WQUAfNnXdiP0M5pcy/RHSSep7L2OyZ0d+ImbU+to8
	 lm6vZ6hJ3N1EggxR+0f7nHjcOMp9VbMe+TW+Oq6h2Uk2d93P2SLbRFxMBAkU+GPMt4
	 5I0tjF9/I5NLQJlO/2P4nV5aWk/mkgEkix/iG9gb4aqkywm4zJuB6CYpiEPgUUZGy5
	 nboU/Z2KHKgGA==
From: Jeff Layton <jlayton@kernel.org>
Subject: [PATCH v3 0/4] sunrpc: hardcode pool_mode to pernode, remove other
 modes
Date: Mon, 29 Jun 2026 13:48:04 -0400
Message-Id: <20260629-sunrpc-pool-mode-v3-0-d92676606dfd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/33NTQ7CIBCG4as0rMXA8FN15T2MC2mnLbECASWap
 neXdmNMjMv3S+aZiSSMFhM5VBOJmG2y3pUQm4o0w8X1SG1bmgADzSQImh4uhoYG70d68y1Sgdo
 oLYC1jSTlLETs7HMlT+fSg013H1/rh8yX9Q+WOeXU1B0wFKqWe3O8YnQ4bn3syaJl+Aga1A8Bi
 iA7xcFo5Ii7L2Ge5zeEI8Gn8wAAAA==
X-Change-ID: 20260423-sunrpc-pool-mode-3e6b56320dc4
To: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
 NeilBrown <neil@brown.name>, Olga Kornievskaia <okorniev@redhat.com>, 
 Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, 
 Chuck Lever <cel@kernel.org>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2145; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=rVwwBj0IXKRGpyPzpLQLuQHJcowq+zOrIyiLcDEaG6E=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBqQq/hN7DgGqiQA18hCjxxhEtkSxZAipGSgUBN1
 scK0nqhIfmJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCakKv4QAKCRAADmhBGVaC
 FQZAD/9xMysJUREkw6raXU599PhGgakYF7mklPC9MukreN0EjVcJ37WtQioKQpWEqaL83uSbAJt
 i+Qg5Vj8K6ZAJDghat9BXOT3UK5AC3NDofaAudyAFVEYxtccdyPQ9qhsBRBw5r67ge5cdGziG4f
 b2YT5yJQOzbJpv/JuCx7Zzc4Af8pw40B0gSUY8+q/EIku8HJYmRvkYMmCiwQaTkNR3i1kP+srfE
 OrsvT46+52PAASCcaP7ZYj2NLCwsHLuhpPaYS1W469+RMxN3wgLZzMct777+pyWeDR6PR9ih+YR
 +mvTOziDoKQg8kLagBLJVNnpU+GwZoV++MSazUxXBu2TOqWtoUEEYhrCyDd1zBzaTHTArYX++K3
 +IFfilX6GaRN38eS1gXsQk7FreNy0dZ9i+B0Ilyjr4vzJWkS/YOOWci1tvVz6hu/i9fzzMHB8Tz
 EgrsqKlcnwIg7yKWH/YpM1YXy/CETgas6roJaotqxTlxl0iU5v3b3+i64yLz1bgf+gWROBHGq/U
 l8olFlazgLinw4bwY4G6yiXKxYyQ9TwrkcE1ho6cfNs0eCSNHQuIaxylsLkqvHPHat29E/8aHJx
 X2Dt0kZgI7EzLzKX93/gvVUgvpxnpyei7gZDJKmfpg5m8WrsPakQTscOPVrlvFASaIsxU4NOr/F
 5r/6LFNtV5NCUVA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22878-lists,linux-nfs=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:trondmy@kernel.org,m:anna@kernel.org,m:neil@brown.name,m:okorniev@redhat.com,m:Dai.Ngo@oracle.com,m:tom@talpey.com,m:cel@kernel.org,m:linux-nfs@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:jlayton@kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[linux-nfs];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 856256DDE4E

The second patch is basically the same as v2, aside from some changes
that Neil suggested.

The other three patches address what is a shortcoming of the existing
code -- namely that the server can be configured to schedule RPCs to
pools with no threads in them. The first patch addresses this problem:
if the chosen pool has no threads, then choose another that does.

The third patch tries to prevent this situation in the thread
auto-placement case by ensuring that each node has at least one thread.

The last patch is a performance micro-optimization. The old code used a
modulus (actually two) to determine the pool (and prevent potentially
overrunning the array). This trades that for a less cpu-intensive method
of finding the pool to use.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
Changes in v3:
- Add patch to ensure that we don't route requests to empty pools
- When auto-distributing threads, always create at least one thread per populated pool
- Use sysfs_match_string for the module parameter
- Reword deprecation printk to be more vague about removal
- Explicitly set m_count == 0 in svc_pool_map_get()
- Optimize svc_pool_for_cpu() by eliminating modulus ops
- Link to v2: https://lore.kernel.org/r/20260625-sunrpc-pool-mode-v2-1-4f512b6e1ee8@kernel.org

Changes in v2:
- Accept any previously-accepted setting for pool_mode
- Link to v1: https://lore.kernel.org/r/20260423-sunrpc-pool-mode-v1-1-b7f20e35749b@kernel.org

---
Jeff Layton (4):
      sunrpc: route to a populated pool in svc_pool_for_cpu()
      sunrpc: hardcode pool_mode to pernode, remove other modes
      sunrpc: guarantee a thread per CPU-bearing node when auto-distributing
      sunrpc: eliminate a modulus operation from the enqueueing codepath

 Documentation/admin-guide/kernel-parameters.txt |  20 +-
 net/sunrpc/svc.c                                | 281 +++++++-----------------
 2 files changed, 88 insertions(+), 213 deletions(-)
---
base-commit: f8eb95335cc219493427f976460cf4b7e9641e92
change-id: 20260423-sunrpc-pool-mode-3e6b56320dc4

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>


