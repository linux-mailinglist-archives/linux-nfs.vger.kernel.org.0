Return-Path: <linux-nfs+bounces-22124-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mCVXOyWEG2owDwkAu9opvQ
	(envelope-from <linux-nfs+bounces-22124-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sun, 31 May 2026 02:43:17 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id EF5D16140A2
	for <lists+linux-nfs@lfdr.de>; Sun, 31 May 2026 02:43:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DAE713008FC7
	for <lists+linux-nfs@lfdr.de>; Sun, 31 May 2026 00:43:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7583F2566E9;
	Sun, 31 May 2026 00:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aMTYJt4Z"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86DC8244667
	for <linux-nfs@vger.kernel.org>; Sun, 31 May 2026 00:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780188190; cv=none; b=OWk9fIW+PocEIq5VZKsOB8cyZDnBnCrigVLZehJVc0U9BrtflFN9jaWMoH5QVSoc7qyufJ9+IDDjxbgzfxNomdvry1LKFgSj3ZRmR7DnfRavHFh5Gylrl5YPC8FC5Pw5J8y2vkq7XRJ3CsEHposHeDeRS2B/ggka4ZHBl0sN5CE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780188190; c=relaxed/simple;
	bh=m8CUaK+CSoTmEgWV3EZZt2uns/yql2nwDRYhqsagTak=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=AWTyLxnJdRKCFVR48SoWSwRTD92VkrkBQJ4YtZrtacJ/tcCbzZvTioaYBteKNRQWUgkroeYh1JIECDNtqAJ+n5eT+avhdMfYRthOfJQlGSgZCLd6xCybj2f8xHLnD3YURqkddkzxCr/5BiLLsBxI4z/+AQhKJP9k4ePO1YfcPv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aMTYJt4Z; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93BD21F00898;
	Sun, 31 May 2026 00:43:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780188188;
	bh=NE15yQWGb7g3d2KlrWrJVZSHnCIV/okKS8B9Vd4T+8A=;
	h=From:Subject:Date:To:Cc;
	b=aMTYJt4Z/tgzK1WSR9xgyy6dbuZKJ3gUNei8yRG0UqnOAOYndPnXBE6MAFOwp1Rjd
	 aQXBoutqbbe0c6kPkTr1yu51cQNxorR3jlvmBkh5/XLNzbYyCc+vhd013NxX7NDw8l
	 LdtFupv4eNPQZV6iDhGs5zovIwFclD8e9rHZslLIYkmp2ecu2jPDvAd4P0dnhGUT+C
	 FhNsmYKJ9QnW1hKX4oKJMJORLrufqlRdc9xNXPhzHWHBiMUvjHZ/PhZKcUVVnyVxh6
	 3LRJ7NxIRtv860OdYmpfEbSs60UISmNV2kM1DXm6h3DrC7kGQ+9uNDtUA28COKgQGg
	 kcnhG1aWIuGWQ==
From: Chuck Lever <cel@kernel.org>
Subject: [PATCH v2 0/2] Fix two latent server-side initialization bugs
Date: Sat, 30 May 2026 20:42:51 -0400
Message-Id: <20260530-tier2-local-v2-0-5a0fd532db57@oracle.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/22OwRKCIBRFf8VhHYWApq36j8YFPJ5KY9AAOTWO/
 57YtuV5c9+5dyERg8VILsVCAs42Wu824IeCwKjcgNSajQlnvGaVYDRZDJxOHtREqwY01ka2Qpz
 J9vEM2Nv3brt1P44vfUdIWZETWkWkOigHYz4BTifXR0MTxmTdkCOjjcmHz75oLrPqf/lcUkZ74
 K00QjayUVcfFEx4BP8g3bquX0eIdgTcAAAA
X-Change-ID: 20260530-tier2-local-58cbe6d49337
To: Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org, Chris Mason <clm@meta.com>, 
 Chuck Lever <chuck.lever@oracle.com>
X-Mailer: b4 0.16-dev-da966
X-Developer-Signature: v=1; a=openpgp-sha256; l=2302;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=m8CUaK+CSoTmEgWV3EZZt2uns/yql2nwDRYhqsagTak=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBqG4QPrR/HAVvlHzg7NlBqNpYJ24Z/VhpK+YFaa
 burl/ahvsOJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCahuEDwAKCRAzarMzb2Z/
 l1vBEAC9PDZn3ompckkWmqqldyXYrTpfd71jrQNGMrRzDk6vxlnFf07SqWE1BnXuG1V14GVi2bm
 hZwYUr6P4MMvttaHlwqJwCtwGXEkK6YgiF8Y4hJvH9OIZI+h86BKCWMbLrSCp4SLdW/Jxy/FJh2
 iMutZjd/5VaSFtKTf3FaoyF0ryILYh6zFAP7IllNABrzLQ66hzSfEL1rjWgp2UYHcgfye7vWyu3
 3bUX/jTg4p34ma4kA5cytNITPsCRF3DFpIKUDqTHr/cHqS/1OhZ8WR1MLPAtdNjaVgWnqp7xjgc
 05/t/oBNETJeMdIKePnHmMgsgotyDr7Ta0sRyk/Yaa/NFiGV05DldCiuYldlFOvq8gD6lDEjjZy
 QsNNCdndmlKP06jPsLeCQiCk8k9eMQcwWP3ho9SZO+aQ4J46FNeHVL8qxFXS3kwhQk0k52ob4Xd
 i4R7GPZoYvJdPfT+bHWuAz2CM9m4Hk/3YEQSR6vbR9G/niIRzD7xHXC3fz7pu6/zlxcKVAsVsCm
 P4DljCO2CTqQPqOgY2hd2kDztpxoUppJMgdBSNv6xyVW6Q2imhDrisftkgPn7ugo/wAP5pj0E7+
 YMphaKRAFIklqEoSzkUxbpl5VaiiN7rjVz4CpDlJM8I2T7ZgZr8TOsHsB7+/i98mSsqkP8FRHJK
 FrXQ3m0sjVFZEfQ==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22124-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.997];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,oracle.com:mid,oracle.com:email]
X-Rspamd-Queue-Id: EF5D16140A2
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
Changes in v2:
- Reverted the percpu_counter_init_many() consolidation back to
  discrete percpu_counter_init()/percpu_counter_destroy() calls.
- Link to v1: https://patch.msgid.link/20260530-tier2-local-v1-0-fc294d34848a@oracle.com

---
Chris Mason (1):
      sunrpc: init gssp_lock before publishing proc entry

Chuck Lever (1):
      SUNRPC: Check svc pool percpu counter allocation

 net/sunrpc/auth_gss/gss_rpc_upcall.c |  6 -----
 net/sunrpc/auth_gss/gss_rpc_upcall.h |  1 -
 net/sunrpc/auth_gss/svcauth_gss.c    |  1 -
 net/sunrpc/sunrpc_syms.c             |  1 +
 net/sunrpc/svc.c                     | 45 +++++++++++++++++++++++++++++++-----
 5 files changed, 40 insertions(+), 14 deletions(-)
---
base-commit: 4d4d6605de5f91a40335729b6a7cc15e83b280f3
change-id: 20260530-tier2-local-58cbe6d49337

Best regards,
--  
Chuck Lever <chuck.lever@oracle.com>


