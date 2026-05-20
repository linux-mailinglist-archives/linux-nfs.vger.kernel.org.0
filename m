Return-Path: <linux-nfs+bounces-21744-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eFW1E1slDmr26QUAu9opvQ
	(envelope-from <linux-nfs+bounces-21744-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 20 May 2026 23:19:23 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A7F859AB40
	for <lists+linux-nfs@lfdr.de>; Wed, 20 May 2026 23:19:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 93C3C3089B67
	for <lists+linux-nfs@lfdr.de>; Wed, 20 May 2026 18:10:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FBD13E5ECF;
	Wed, 20 May 2026 18:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BNSD8Nvl"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7427F331220;
	Wed, 20 May 2026 18:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779300653; cv=none; b=V7RGLIDJucmExxEQAQW2+xs0NmxstEpF4Xykbp6rcn0hh4UnxwlkdSWzOwY4HFAf/CRjp9ORHvqPMMCfaPTKluHNl8CdUy2ZJQ8PUgCgQQOEDulIQmevYI8t6mM2xEH7gmI9onakG4y29gNeaVB9DTf0HMfTfw6EBX7qBAR9L3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779300653; c=relaxed/simple;
	bh=9NB8iBCMLb6WMljvi9t2zQ8S1JE0iKrQ12TFlCoFjV8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=pVb/OKR+gP1CD4hxJ+QGECdgSsbQzZXkx7k0w8dkEBHvoHW6Gw3hqUVp6s2S4BpxFxWp3tNkEurqHZNGPIGDm/3BE0zn5keq9KXx6Zn4kasfRqL7H+buZBQFVYSy3ni/K0+dD+MGXQyrgeBZh+VPg2roigsMQ7RVDsA8zY1EKn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BNSD8Nvl; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAF461F00893;
	Wed, 20 May 2026 18:10:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779300652;
	bh=uMgNsZHHGhq0vm7lGFdiIF74J4CVM01doQlgu8okr6o=;
	h=From:Date:Subject:To:Cc;
	b=BNSD8NvlBGWMNCcnXibPB3Zt3AuDd1X+MpCNIp2Ox5CQMEecADYmdOfNAxDfIJWQJ
	 OXnsFSwpj6xk3KVuRCQ/6UBdBB0Z8yZ9zfkGfJx4TFCioIT/ni8tvVXfCtrApr5Wou
	 KWeaWPqnbPLKVWT260zUNgkhB/aluStcQyMjBRKFbBO4hBnjYEYO5MmgQq65IHZ2JY
	 kgJaVwpfuvBRpOYCs+fO2W6YOsIymTNVSwLA4mjmkW43zRCMBE3qb4dOKpS7Ui0+lH
	 YA+8Kv8mQ7S/ZXJV7v4Ydbj+U36Hjm+pN6HsNRJPmBDVqXIhn63al4OvIYdhLGeibQ
	 7eiS9uHYl19og==
From: Jeff Layton <jlayton@kernel.org>
Date: Wed, 20 May 2026 14:10:35 -0400
Subject: [PATCH] sunrpc: use kref_get_unless_zero in auth_domain_lookup
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260520-nfsd-fixes-v1-1-664ba702d698@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x2LQQqAIBAAvyJ7TlgtM/pKdIhcay8WLkQg/j3pO
 MxMAaHMJDCrApkeFr5SA9Mp2M8tHaQ5NAaLdkRnUacoQUd+SXQ0vXfeBhwmhDbcmX7R+mWt9QN
 kt2AAXAAAAA==
X-Change-ID: 20260520-nfsd-fixes-f137572d0480
To: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
 Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: Chris Mason <clm@meta.com>, linux-nfs@vger.kernel.org, 
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1998; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=9NB8iBCMLb6WMljvi9t2zQ8S1JE0iKrQ12TFlCoFjV8=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBqDfkkXJn1U6bk1VvSTPQsVYUjH0wjcf4Iu9Fng
 DT4cUCIsJGJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCag35JAAKCRAADmhBGVaC
 FVgPEACDpsnHtz1IGcR79opTalJVgwPussUMl+JJS45+1YCJL3jJudQSxuAs4VCBpAGtrdnfKz7
 AHc/be1saLNx70fmIaXoiu/rWwnISgUnPc2scOIi4gVIHGfjnLHaJ1pTyOVqZtKlelai2bnGQBZ
 OodNAOBg9UO3g+2OWFugzQXfWipr28ehwo1pQgcXQUmp9rDCtkIX+MCcgiArKr0c1CNjhS1/MTs
 a10DwYO7t0UMaP/XgaVVchJFztEynEM//B67pBypo5Cj9T9dIT0qEZjDexshn7uuK0TKrLVLesW
 5jbjfGDDSox1dBAbZO6pxSTRTvbq8MCwuI1OtgS8Unihi86MwnNcfpyU/vAbIcUxQclK7wQpB3A
 kQ3PidIyNCpHjgbDvdLoWe73Z0axQ1IL+aV7lSiA2OUPzmRVWp8B/h+SvUaZ6NC2nFdEQeU0mIQ
 HJScJZNSmL7+n1vCuAwzlEhxOUVIRbz6l03ub/8GNRWOVyuDp4hNcwOCL2FIlJ61HOpItRT+DU4
 Q4ReH+Q1REOALfelv3tTdsYKM8ldX4gmOWWCzrSe+UXq5zzhq3fARqCRh3AhgJ7BeJ/IFPrrQMP
 Y3AFnUoeZA+iB66+3OqRbXfIIQxWiTZBRY/bb6s8LLuJbUEaCe2CljnFBc4nKZmWrxGaz5S7aku
 RUxnqnamg8BGVHQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21744-lists,linux-nfs=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[meta.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 8A7F859AB40
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

auth_domain_put() uses kref_put_lock(), which atomically decrements the
refcount before acquiring auth_domain_lock. This creates a window where
an auth_domain entry is still linked on the hash list with refcount == 0.

auth_domain_lookup() walks the hash under auth_domain_lock but uses plain
kref_get() to acquire a reference. If it finds an entry in this transient
zero-refcount state, refcount_inc() triggers a WARN and refuses to
increment (saturating refcount_t semantics), but the function returns the
pointer anyway. The caller then holds a dangling reference: when the
concurrent auth_domain_put() finally acquires the lock and runs
auth_domain_release(), the object is freed while the lookup caller still
has a pointer to it.

The sibling function auth_domain_find() already handles this correctly
using kref_get_unless_zero(). Apply the same pattern in
auth_domain_lookup(): treat a zero-refcount entry as absent and continue
searching. The loop then either finds another live entry or falls through
to insert the new domain, preserving existing semantics.

Reported-by: Chris Mason <clm@meta.com>
Assisted-by: kres:claude-opus-4-6
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 net/sunrpc/svcauth.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/sunrpc/svcauth.c b/net/sunrpc/svcauth.c
index 55b4d2874188..8e01f0626759 100644
--- a/net/sunrpc/svcauth.c
+++ b/net/sunrpc/svcauth.c
@@ -245,8 +245,10 @@ auth_domain_lookup(char *name, struct auth_domain *new)
 	spin_lock(&auth_domain_lock);
 
 	hlist_for_each_entry(hp, head, hash) {
-		if (strcmp(hp->name, name)==0) {
-			kref_get(&hp->ref);
+		if (strcmp(hp->name, name) == 0) {
+			if (!kref_get_unless_zero(&hp->ref))
+				continue;
+
 			spin_unlock(&auth_domain_lock);
 			return hp;
 		}

---
base-commit: 508c9eaa7e0b952c4fe019880796e6207e3cd201
change-id: 20260520-nfsd-fixes-f137572d0480

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>


