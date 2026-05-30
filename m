Return-Path: <linux-nfs+bounces-22108-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qqjPEAVHG2qwAgkAu9opvQ
	(envelope-from <linux-nfs+bounces-22108-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sat, 30 May 2026 22:22:29 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 892EC61333D
	for <lists+linux-nfs@lfdr.de>; Sat, 30 May 2026 22:22:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 13075301DBAB
	for <lists+linux-nfs@lfdr.de>; Sat, 30 May 2026 20:21:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21ED625CC57;
	Sat, 30 May 2026 20:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mvqGqbX0"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 200A222A80D
	for <linux-nfs@vger.kernel.org>; Sat, 30 May 2026 20:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780172481; cv=none; b=OPgz53cYq0f9E+oGMDVXEp5vxHUqjfZ23aX8XJdLzEpO2DUkZOPEvmzfzrsNb4h6XikxPLKZe1kqTvG7dregl+jE1LgN50rx43Y9NhD6u7gjwkUqZWzkd6+XfuAx9zx9NxB5xqHgZl+raoRwmHd0Knu4luh8iwCKpsVXE53rx94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780172481; c=relaxed/simple;
	bh=mWsKishejfrlZqB6K0EdB5fvlWKRFoTGTUqpWTdYId8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=SAq724yTb25bD+aFo8RNK+2J1MoswWED2rXG8GFxEXjVgteKcbQkN8E8j9bMnxkGMQBFuZfutcv/oYuNm77AqK1NqKQpUJjenUuh/89JFnYgajR2UaQjem4n9Eoht+u7QEwV9n1GmjFuwJ0bXJCZ1Bvwl9sD8NxumhpiH+rRLhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mvqGqbX0; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27D561F00893;
	Sat, 30 May 2026 20:21:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780172479;
	bh=ueG1/kA0dVclyi9n5Nwd/Nlxs7rhNRlXxqa+gvkiGbs=;
	h=From:Subject:Date:To:Cc;
	b=mvqGqbX0ksJH347V3W671QQmw04fnasKqj8ZFmjqlxPP0GYRweyOiuFEgxLW+7QoL
	 otDpVy/kX67yeSDukliV11ZndeGH8rKWJzdTC1KF0CukA+M7Xg14wZ4kKnPZWvSjkj
	 2U4FynMrfDHGcfgjNSwDc/bfC1/VW7JVFze3iMHxQ+zvt6gqSd0waWaX3W0a7TdUkR
	 F9c2HycKSzh+oVTBaJTlFXn0CFGADMxQh5I9ixH9wqDOQocTgfGVvdmg288hd8GYCg
	 6z3kGJkHm/XkATwu1fz4Ta7zSim3Guhjd1pdIosV5yaVs2pSnkwFgCloQtwkE1hEOM
	 7c8X2oSKPJ8JA==
From: Chuck Lever <cel@kernel.org>
Subject: [PATCH 0/2] Fix two latent server-side initialization bugs
Date: Sat, 30 May 2026 16:21:06 -0400
Message-Id: <20260530-tier2-local-v1-0-fc294d34848a@oracle.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWMyw7CIBBFf6WZtUQEWx+/YlzAMG3HEGoYNCZN/
 13Q5bm556wglJkErt0Kmd4svKQKh10HOLs0keJQGYw2g+6tVoUpGxUXdFH1Z/Q0hOPF2hNU45l
 p5M+vdrv/WV7+QVhaoj28E1I+u4Rzm5DiPo0SVCEpnCbYti9K0DlbkgAAAA==
X-Change-ID: 20260530-tier2-local-58cbe6d49337
To: Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org, Chris Mason <clm@meta.com>, 
 Chuck Lever <chuck.lever@oracle.com>
X-Mailer: b4 0.16-dev-da966
X-Developer-Signature: v=1; a=openpgp-sha256; l=2055;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=mWsKishejfrlZqB6K0EdB5fvlWKRFoTGTUqpWTdYId8=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBqG0a2tae/XpqhCyfn2ApV98tRUcIFClXmVDvMJ
 ufqL6UeeQqJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCahtGtgAKCRAzarMzb2Z/
 l66xD/wKFCTp/8XNMstKwWC6ba55c7x96T6ZOWxeRqwWEum3Q/DwIpugsXEPJ3u1RMPnsgJCmrx
 zdhlRu9npFAbEbgVubA29DVHpHy2KDLX6eBZ59Jk4sf6zgwAoTu5ticXe3EEVZwktCXE6++e+EM
 fjocjHdBQyR/ioaF2HbCmwo3BmKIpb0yyg3p1kISq/NmyDZu0HPXSG8p0dyBonQHOcL5pRYEBER
 FITt5nx+EWCfptrp8D062szslc2u1F3TV0gn4T7xEP6Hm9zEgxyz9W7r+kJTszF0FD5ed5dHOp1
 Nd8qin2fprhD4Nf7gl1NJkjIlX5PbeOLVMhZQCkY3508+FqI/T2u6BAoaYZtYsTsvO2owme9iTY
 lMbrj7FQEyXqv6iJbZizvsknvC2roHUeZVMTQO+DR3jEhTtljBAcAsgw18A59Q8F0p5oqY/NMCI
 QWU8adKx3NUW/+wmEV/tC7NMNsFo+x9A0NpXGS3QABWIp9c6ozJ4enn1j2l4wSnvyJYDpjWhh83
 m2cUIVBdr/KFyByqmutEY3YCAPWil0M91hr8SILu47rUUMcDu7oTZWsl7Duy0gQ+vY/l/Sri3dF
 raxkY9GfvAP3wfeTEi3H1nGLfepreYA42PVYYHFrcPFkwQVmzSkcvX6+zQtS33ZmY5kVkfc6OPA
 zM2Mv2ef79YRuhA==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22108-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,oracle.com:mid,oracle.com:email]
X-Rspamd-Queue-Id: 892EC61333D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Both patches fix the same bug shape in the SUNRPC server: an object
becomes reachable by a consumer while a field it depends on is still
invalid. The use-gss-proxy proc entry is published before its mutex
is initialized; a half-allocated svc_serv whose per-pool percpu
counters never got backing storage is returned to its caller. In
each case the common path hides the flaw, and only a narrow trigger
exposes it -- a preemption-timed write to /proc/net/rpc/use-gss-proxy,
or a percpu allocation failure under memory pressure during RPC server
startup.

Each fix rests on an argument that no consumer observes the object
mid-initialization, and the two arguments differ. For the proc entry,
the guarantee comes from module load order: sunrpc.ko is a build-time
dependency of auth_rpcgss.ko, so sunrpc_init_net() has initialized
gssp_lock on every net namespace before auth_gss pernet init can
publish the file. Moving the init there ties the lock's lifetime to
the sunrpc_net it lives in and lets the lazy init_gssp_clnt() helper
go away. For the svc_serv, the guarantee is local: the percpu
allocation failure is caught and unwound inside __svc_create(), so a
half-constructed service never reaches nfsd, lockd, or the NFS
callback service. Both arguments are worth checking against the diffs.

The two fixes are independent, touch different files, and may be
applied in any order.

---
Chris Mason (1):
      sunrpc: init gssp_lock before publishing proc entry

Chuck Lever (1):
      SUNRPC: Check svc pool percpu counter allocation

 net/sunrpc/auth_gss/gss_rpc_upcall.c |  6 ------
 net/sunrpc/auth_gss/gss_rpc_upcall.h |  1 -
 net/sunrpc/auth_gss/svcauth_gss.c    |  1 -
 net/sunrpc/sunrpc_syms.c             |  1 +
 net/sunrpc/svc.c                     | 32 ++++++++++++++++++++++++++------
 5 files changed, 27 insertions(+), 14 deletions(-)
---
base-commit: 4d4d6605de5f91a40335729b6a7cc15e83b280f3
change-id: 20260530-tier2-local-58cbe6d49337

Best regards,
--  
Chuck Lever <chuck.lever@oracle.com>


