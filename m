Return-Path: <linux-nfs+bounces-22316-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 3ocRF+cKI2r/gwEAu9opvQ
	(envelope-from <linux-nfs+bounces-22316-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 05 Jun 2026 19:44:07 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ABA1164A483
	for <lists+linux-nfs@lfdr.de>; Fri, 05 Jun 2026 19:44:06 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Y81iZ0nn;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22316-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22316-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E106E3063812
	for <lists+linux-nfs@lfdr.de>; Fri,  5 Jun 2026 17:35:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B93423AB5B7;
	Fri,  5 Jun 2026 17:35:01 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1B6539A06B;
	Fri,  5 Jun 2026 17:34:57 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780680901; cv=none; b=tqKRpY46+ixV9C51wFSMZEJ1KcCRPcezEKvN/3UFAPO0TjMVvsn31z/203PdTZgjFpF1kDhUj1bhVS9kP46tcANyFaMKWTqWH13Fmb+JDrm+BYAnJhOmBtjKuIoAgnkGwrHCjp6HWo2/qeOB403UJz2uX16OJIUF8WsvFkjpk9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780680901; c=relaxed/simple;
	bh=Ows39zTI9n7wAPEQiw6Xs3MR4cdzRkAjhnHBxY84dn8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ctw1DegS/xKuJl1Rb6d0hMhmkJhRyN+/kvcyeQQviylMpE126buqfvz5Mh2UP911obvRSby1XR1pkO3aKoNUlLsmcTVmufxPx2Y1OfZZtZJUpXrzE2KzatLoPtp1evwTGBZMB02DykkU+znX3v9qPpqumUfw875A0WqcCeikBtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y81iZ0nn; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AA331F0089D;
	Fri,  5 Jun 2026 17:34:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780680897;
	bh=GdAp+BOi7Bw5Wcr+RoPktPL/Tov2J8OBkbGvYCENpiM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Y81iZ0nn9VUhH8TWtV8RhxanmGmZ10cPFgUdxRsQ3UuGNxCyP9s9UMniTjZGEs4D/
	 RLM5GxecIR281agf9qynX6k/B4J4eOw/dwAJSEoDzDTHxsIeIBQHrnf3vurcI+O33r
	 bEMQ5j62lq7wGAnSE745j79jYTwS+RRcqh4XnJn0S64uclZhcn0tq/uHA6/5Puiso3
	 mP1hLiaSfLzxMqqQVII4yQAae88Gcxq3P6cZLnTWkIWdDYnJsHMgUw+XIcBoN1YqRe
	 f9A/IX+iBkEBcFfsZxyc+d8jw0MWXrmDjW4Q4il+VS4qoq9XPR1aNAnv902X7v9BK7
	 nIT8pVoY82Maw==
From: Chuck Lever <cel@kernel.org>
Date: Fri, 05 Jun 2026 13:34:43 -0400
Subject: [PATCH 9/9] NFSD: Add allow_tags to the netlink export interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260605-tls-session-tags-v1-9-47bd1d94d552@oracle.com>
References: <20260605-tls-session-tags-v1-0-47bd1d94d552@oracle.com>
In-Reply-To: <20260605-tls-session-tags-v1-0-47bd1d94d552@oracle.com>
To: Donald Hunter <donald.hunter@gmail.com>, 
 Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Sabrina Dubroca <sd@queasysnail.net>, Keith Busch <kbusch@kernel.org>, 
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>, 
 Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>, 
 Anna Schumaker <anna@kernel.org>
Cc: kernel-tls-handshake@lists.linux.dev, netdev@vger.kernel.org, 
 linux-nvme@lists.infradead.org, linux-nfs@vger.kernel.org, 
 Chuck Lever <chuck.lever@oracle.com>
X-Mailer: b4 0.16-dev-da966
X-Developer-Signature: v=1; a=openpgp-sha256; l=8031;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=tLFpkkm/QOrTFF11jxLqkjXfpcq+yXBPGCWn24fWr1g=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBqIwi440EJq0B9b65Z9WgUj8Gibd8eTyplP+COc
 TmFQCjXnGWJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCaiMIuAAKCRAzarMzb2Z/
 lzpND/9vWqMhbLSNjgXvdrKtIk0jAC8XIQGGqwaWCvSV3UhtfFdefN6f4yqojRytq4SedfLgcPy
 neZ/tA+gSdmlHdWx4V6a7JQP5kBY+lbAwXAL226Z4xzgAPP1Wr7o+RsbLc6wGfhIpVWeaXbOkXc
 Z/pIp5fxoGZA0Jfn3DXsVOY2hSJb+Gf45VMjBhCu1DtyoKrT9DRHALGQ9LULXIhn3BPtLHM1qyF
 BYRfce9GcaTaGdDr9bWgvINgQmeXZ5hH24pInpsZR6P8tsBD1DmS18NwxdMzEfpBJQSI9xbI7G3
 CydN55SuleclaD6nIYd5p1WNFYcAj9aM70PLSavwMIlo8TG086xF3S8QLF8/5GLisW+aLUNBykM
 iNkwYnpuiBnIYlfE4LdUYWfsVqzkCIyOSy9nd1JtG+QStmgXKmGuZvdatkBifaYoacI3DndDSHE
 YwQ1OheOdD+/kzZihRt/MY9x8tqbZx02+I2YdWjencI2m0N2+K+9WziYpSTLtPGA61K7u2zCWxm
 VXT5cMNAZG4EyXOQpw6sMSollVttnhPgwxiUMfqC96KL/8sNoPjEgYYtQrAcKPzJoSEkgamaN3U
 igLEIMxrgDPAWYbqczuUFJdb9+O/UlVaQj2qTuAAKAi1dj2dDM8oxWi1559ZknbF8NUSKpS4BoF
 xQ46UDlF71lhhEA==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:donald.hunter@gmail.com,m:kuba@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:akpm@linux-foundation.org,m:john.fastabend@gmail.com,m:sd@queasysnail.net,m:kbusch@kernel.org,m:axboe@kernel.dk,m:hch@lst.de,m:sagi@grimberg.me,m:kch@nvidia.com,m:jlayton@kernel.org,m:neil@brown.name,m:okorniev@redhat.com,m:Dai.Ngo@oracle.com,m:tom@talpey.com,m:trondmy@kernel.org,m:anna@kernel.org,m:kernel-tls-handshake@lists.linux.dev,m:netdev@vger.kernel.org,m:linux-nvme@lists.infradead.org,m:linux-nfs@vger.kernel.org,m:chuck.lever@oracle.com,m:donaldhunter@gmail.com,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,davemloft.net,google.com,redhat.com,lwn.net,linuxfoundation.org,linux-foundation.org,queasysnail.net,kernel.dk,lst.de,grimberg.me,nvidia.com,brown.name,oracle.com,talpey.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[28];
	FORGED_SENDER(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-22316-lists,linux-nfs=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oracle.com:mid,oracle.com:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: ABA1164A483

From: Chuck Lever <chuck.lever@oracle.com>

The legacy exportfs cache path accepts an allow_tags clause that
restricts an export to mTLS sessions carrying at least one matching
session tag. The netlink-based svc_export interface had no such
attribute, so administrators configuring exports via netlink could
not request tag enforcement: nfsd_nl_parse_one_export() always
left ex_allow_tags empty, and check_xprtsec_policy() then granted
any authenticated peer.

Extend the svc-export attribute set with allow-tags and parse it
in nfsd_nl_parse_one_export(). Apply the same xprtsec=mtls
consistency check as svc_export_parse() so the netlink path
refuses contradictory security policy rather than silently exposing
a tagged export to plaintext or anonymous-TLS peers.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 Documentation/netlink/specs/nfsd.yaml | 10 ++++++
 fs/nfsd/export.c                      | 68 +++++++++++++++++++++++++++++++++--
 fs/nfsd/netlink.c                     |  4 ++-
 fs/nfsd/netlink.h                     |  3 +-
 include/uapi/linux/nfsd_netlink.h     |  1 +
 5 files changed, 82 insertions(+), 4 deletions(-)

diff --git a/Documentation/netlink/specs/nfsd.yaml b/Documentation/netlink/specs/nfsd.yaml
index 8f36fadd68f7..5cbdc1dab7e3 100644
--- a/Documentation/netlink/specs/nfsd.yaml
+++ b/Documentation/netlink/specs/nfsd.yaml
@@ -7,6 +7,10 @@ uapi-header: linux/nfsd_netlink.h
 doc: NFSD configuration over generic netlink.
 
 definitions:
+  -
+    name: handshake-session-tag-max-len
+    type: const
+    header: uapi/linux/handshake.h
   -
     type: flags
     name: cache-type
@@ -253,6 +257,12 @@ attribute-sets:
       -
         name: fsid
         type: s32
+      -
+        name: allow-tags
+        type: string
+        checks:
+          max-len: handshake-session-tag-max-len
+        multi-attr: true
   -
     name: svc-export-reqs
     attributes:
diff --git a/fs/nfsd/export.c b/fs/nfsd/export.c
index a2aaa3cd6c52..25802de2de40 100644
--- a/fs/nfsd/export.c
+++ b/fs/nfsd/export.c
@@ -831,6 +831,7 @@ static struct svc_export *svc_export_update(struct svc_export *new,
 static struct svc_export *svc_export_lookup(struct svc_export *);
 static int check_export(const struct path *path, int *flags,
 			unsigned char *uuid);
+static int check_allow_tags(const struct svc_export *exp);
 
 /**
  * nfsd_nl_parse_one_export - parse one svc_export entry from a netlink message
@@ -845,14 +846,14 @@ static int check_export(const struct path *path, int *flags,
 static int nfsd_nl_parse_one_export(struct cache_detail *cd,
 				    struct nlattr *attr)
 {
-	struct nlattr *tb[NFSD_A_SVC_EXPORT_FSID + 1];
+	struct nlattr *tb[NFSD_A_SVC_EXPORT_ALLOW_TAGS + 1];
 	struct auth_domain *dom = NULL;
 	struct svc_export exp = {}, *expp;
 	struct nlattr *secinfo_attr;
 	struct timespec64 boot;
 	int err, rem;
 
-	err = nla_parse_nested(tb, NFSD_A_SVC_EXPORT_FSID, attr,
+	err = nla_parse_nested(tb, NFSD_A_SVC_EXPORT_ALLOW_TAGS, attr,
 			       nfsd_svc_export_nl_policy, NULL);
 	if (err)
 		return err;
@@ -993,6 +994,68 @@ static int nfsd_nl_parse_one_export(struct cache_detail *cd,
 			}
 		}
 
+		/* allow-tags (multi-attr string) */
+		if (tb[NFSD_A_SVC_EXPORT_ALLOW_TAGS]) {
+			struct nlattr *tag_attr;
+			unsigned int count = 0;
+
+			/*
+			 * The NLA_STRING policy does not guarantee a
+			 * terminating NUL, so each tag is copied with
+			 * the length-aware nla_strdup(). Embedded NUL
+			 * bytes are rejected here because the policy
+			 * cannot express that check; a tag containing
+			 * one could never match a handshake-supplied
+			 * tag, which net/handshake rejects the same
+			 * way.
+			 */
+			nla_for_each_nested_type(tag_attr,
+						 NFSD_A_SVC_EXPORT_ALLOW_TAGS,
+						 attr, rem) {
+				const char *src = nla_data(tag_attr);
+				size_t srclen = nla_len(tag_attr);
+
+				if (srclen > 0 && src[srclen - 1] == '\0')
+					srclen--;
+				if (srclen == 0 ||
+				    memchr(src, '\0', srclen)) {
+					err = -EINVAL;
+					goto out_uuid;
+				}
+				count++;
+			}
+			if (count > NFSD_MAX_ALLOW_TAGS) {
+				err = -EINVAL;
+				goto out_uuid;
+			}
+			if (!tagset_alloc(&exp.ex_allow_tags, count,
+					  GFP_KERNEL)) {
+				err = -ENOMEM;
+				goto out_uuid;
+			}
+			nla_for_each_nested_type(tag_attr,
+						 NFSD_A_SVC_EXPORT_ALLOW_TAGS,
+						 attr, rem) {
+				char *tag;
+
+				tag = nla_strdup(tag_attr, GFP_KERNEL);
+				if (!tag) {
+					err = -ENOMEM;
+					goto out_uuid;
+				}
+				if (!tagset_add(&exp.ex_allow_tags, tag)) {
+					kfree(tag);
+					err = -ENOMEM;
+					goto out_uuid;
+				}
+			}
+			tagset_finalize(&exp.ex_allow_tags);
+		}
+
+		err = check_allow_tags(&exp);
+		if (err)
+			goto out_uuid;
+
 		err = check_export(&exp.ex_path, &exp.ex_flags,
 				   exp.ex_uuid);
 		if (err)
@@ -1026,6 +1089,7 @@ static int nfsd_nl_parse_one_export(struct cache_detail *cd,
 	}
 
 out_uuid:
+	tagset_destroy(&exp.ex_allow_tags);
 	kfree(exp.ex_uuid);
 out_fslocs:
 	nfsd4_fslocs_free(&exp.ex_fslocs);
diff --git a/fs/nfsd/netlink.c b/fs/nfsd/netlink.c
index fbee3676d253..4db094b1021f 100644
--- a/fs/nfsd/netlink.c
+++ b/fs/nfsd/netlink.c
@@ -10,6 +10,7 @@
 #include "netlink.h"
 
 #include <uapi/linux/nfsd_netlink.h>
+#include <uapi/linux/handshake.h>
 
 /* Common nested types */
 const struct nla_policy nfsd_auth_flavor_nl_policy[NFSD_A_AUTH_FLAVOR_FLAGS + 1] = {
@@ -41,7 +42,7 @@ const struct nla_policy nfsd_sock_nl_policy[NFSD_A_SOCK_TRANSPORT_NAME + 1] = {
 	[NFSD_A_SOCK_TRANSPORT_NAME] = { .type = NLA_NUL_STRING, },
 };
 
-const struct nla_policy nfsd_svc_export_nl_policy[NFSD_A_SVC_EXPORT_FSID + 1] = {
+const struct nla_policy nfsd_svc_export_nl_policy[NFSD_A_SVC_EXPORT_ALLOW_TAGS + 1] = {
 	[NFSD_A_SVC_EXPORT_SEQNO] = { .type = NLA_U64, },
 	[NFSD_A_SVC_EXPORT_CLIENT] = { .type = NLA_NUL_STRING, },
 	[NFSD_A_SVC_EXPORT_PATH] = { .type = NLA_NUL_STRING, },
@@ -55,6 +56,7 @@ const struct nla_policy nfsd_svc_export_nl_policy[NFSD_A_SVC_EXPORT_FSID + 1] =
 	[NFSD_A_SVC_EXPORT_XPRTSEC] = NLA_POLICY_MASK(NLA_U32, 0x7),
 	[NFSD_A_SVC_EXPORT_FLAGS] = NLA_POLICY_MASK(NLA_U32, 0x3ffff),
 	[NFSD_A_SVC_EXPORT_FSID] = { .type = NLA_S32, },
+	[NFSD_A_SVC_EXPORT_ALLOW_TAGS] = { .type = NLA_STRING, .len = HANDSHAKE_SESSION_TAG_MAX_LEN, },
 };
 
 const struct nla_policy nfsd_version_nl_policy[NFSD_A_VERSION_ENABLED + 1] = {
diff --git a/fs/nfsd/netlink.h b/fs/nfsd/netlink.h
index af41aa0d4a65..133e99a0a3fc 100644
--- a/fs/nfsd/netlink.h
+++ b/fs/nfsd/netlink.h
@@ -11,6 +11,7 @@
 #include <net/genetlink.h>
 
 #include <uapi/linux/nfsd_netlink.h>
+#include <uapi/linux/handshake.h>
 
 /* Common nested types */
 extern const struct nla_policy nfsd_auth_flavor_nl_policy[NFSD_A_AUTH_FLAVOR_FLAGS + 1];
@@ -18,7 +19,7 @@ extern const struct nla_policy nfsd_expkey_nl_policy[NFSD_A_EXPKEY_PATH + 1];
 extern const struct nla_policy nfsd_fslocation_nl_policy[NFSD_A_FSLOCATION_PATH + 1];
 extern const struct nla_policy nfsd_fslocations_nl_policy[NFSD_A_FSLOCATIONS_LOCATION + 1];
 extern const struct nla_policy nfsd_sock_nl_policy[NFSD_A_SOCK_TRANSPORT_NAME + 1];
-extern const struct nla_policy nfsd_svc_export_nl_policy[NFSD_A_SVC_EXPORT_FSID + 1];
+extern const struct nla_policy nfsd_svc_export_nl_policy[NFSD_A_SVC_EXPORT_ALLOW_TAGS + 1];
 extern const struct nla_policy nfsd_version_nl_policy[NFSD_A_VERSION_ENABLED + 1];
 
 int nfsd_nl_rpc_status_get_dumpit(struct sk_buff *skb,
diff --git a/include/uapi/linux/nfsd_netlink.h b/include/uapi/linux/nfsd_netlink.h
index f5b75d5caba9..23a42c26ede0 100644
--- a/include/uapi/linux/nfsd_netlink.h
+++ b/include/uapi/linux/nfsd_netlink.h
@@ -165,6 +165,7 @@ enum {
 	NFSD_A_SVC_EXPORT_XPRTSEC,
 	NFSD_A_SVC_EXPORT_FLAGS,
 	NFSD_A_SVC_EXPORT_FSID,
+	NFSD_A_SVC_EXPORT_ALLOW_TAGS,
 
 	__NFSD_A_SVC_EXPORT_MAX,
 	NFSD_A_SVC_EXPORT_MAX = (__NFSD_A_SVC_EXPORT_MAX - 1)

-- 
2.54.0


