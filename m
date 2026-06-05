Return-Path: <linux-nfs+bounces-22315-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id zO7WOB4KI2rFgwEAu9opvQ
	(envelope-from <linux-nfs+bounces-22315-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 05 Jun 2026 19:40:46 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DA4F64A426
	for <lists+linux-nfs@lfdr.de>; Fri, 05 Jun 2026 19:40:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=LkO2tZUl;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22315-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22315-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1AEB23081C0F
	for <lists+linux-nfs@lfdr.de>; Fri,  5 Jun 2026 17:35:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5BC43A9611;
	Fri,  5 Jun 2026 17:35:00 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 093D63955C2;
	Fri,  5 Jun 2026 17:34:57 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780680900; cv=none; b=RFg2RkQm5rtdAEM2iSJNd9tsXxJ/XUNjHkjUw0pjqRL5a5Yhq8lGw0ON1HxcH2Jb5TnFtqso+L2JA1ffahbI2WL3DyTQeMrt+OR5aIgosEC5SmZwfQ0AuZW2vBcYfEkQBN0dVX2s4l/2TP7El2vSucmcwzaFw1iNV3/QqZny0zI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780680900; c=relaxed/simple;
	bh=HglIQ44p1JzkW1OqmDE1lRj49/YnGPGkbvZzp5Eibe4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EPQaPYddJrAFesh4h5QHouk2HU4qzwE8/oEreB7l1CK2PaBGGIMZiu20ONAUrb6YO97ilT2XIe9UZjX2ZIJkqG3T137JJ+9VPKx/zYBBPQdcxHgm2zceG8EYgSDpIeqgrQbVgGtMAdqG3EmJvx9eHUKtPdb1d/s7hbp5mH3RoyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LkO2tZUl; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12A541F008A3;
	Fri,  5 Jun 2026 17:34:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780680896;
	bh=oZKcraY4fYn3iL2WHNgFlTxWUm2e+tse+u94FQr20p0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=LkO2tZUlT3zq3SjHqemsziwAl5v+69o+TMgQZZnw/TXLIEKZ2Wy5NMM3I3/bGrhWs
	 /oxBEq+b1elB2rFgPZk708R3YgabQ7xbQ69n4fZOERmrFwlGrqSJ4471s49CDCgMFL
	 6wuOtH0i5Jt1iftK9vzrl/yWfHw8Kgdo/kZTmXOmVzCYGJtI2dDYwV7T35ycfUYoeO
	 A9NlRAq65KGZq85UgoKzZP1h+BPE+OL71MgVFk+gg72n5kEn6gI6z8O9edPeXjSFU1
	 wA1FxJ1iSkfN0ZojiJNhG+iYsy+nDhWh8JsZIGncpUj9HZGXV5MqYRYZtDdpmmYCsr
	 THIOjfhq0T4sQ==
From: Chuck Lever <cel@kernel.org>
Date: Fri, 05 Jun 2026 13:34:42 -0400
Subject: [PATCH 8/9] NFSD: Implement export tagging
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260605-tls-session-tags-v1-8-47bd1d94d552@oracle.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=8660;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=Z75fXKsUCBZJlp5fCL7NzCAaYRegS68EyPjbIYJwBig=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBqIwi4OvmlCP7Vn3va2SYgyCbWSYdaDK3VvGP+K
 lv6OPkRVZ2JAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCaiMIuAAKCRAzarMzb2Z/
 lwZhEACb0EOdUZ6XEuzudfS4S0GxC56MqZ+6GUAeOElrZlj5iXW+3QU/bRewGyEWYfDdSj0wI6Q
 C0N/iHLG2UCQUr9IdOyldlUWSpqIk+Xn7AndVus80SH+hntOH/9giBChz+TjzTgzLR2J5hu7dRW
 bhLzkB1SiyYsIwGS8prfgaXBfIM7jWjfutQODmzj+ZdhF3i3iSDMf5DijEoS4dFcs+nZcM0h+hM
 KppfMtM5QlrNmSSIcMEs9SGM7NnnuDH+k3farNgpEb2JY/IR3tMifghByHdpg5UBYlplyu1/CBd
 Yb6raSXkkXOhSxSeVGVYqrkBOpQCuuRo2nPoQG1TDoC0YQPS+FWp4PZH/W5RpA8afwq36C83Oiv
 w9M81h9n4EJCmkrcNygcr8BblYab1k5SfICxzs/C0S3qpLpRmCq9ZT1HrCQOHLkOT96RIl6e8GX
 lIPBTP2XSA+vqIbR9zw6IXhI958QakZaTK7bycjacgmxGC2avsvra9amNNpV0Er8ufZD/bXihcv
 Lq+fNZRDT6PxfQC0JcOyZQOVv1NgIl9yoKj3GPsPFLUs+jqb7uvII3RDJ5m58H/X7+yvhXPU25p
 di7bEaufLTnI1sDUUI9Wv71dZLrU48cmZvq/bZu5qL32/Z1nO+I4huMb9J+1vG1rCoQYOTLa0uF
 ve7Ttq+Tcwd8Hiw==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
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
	TAGGED_FROM(0.00)[bounces-22315-lists,linux-nfs=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,oracle.com:mid,oracle.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7DA4F64A426

From: Chuck Lever <chuck.lever@oracle.com>

Today NFSD treats TLS client peer identity as a boolean: either a
peer is identified (authenticated) or it is not. Some deployments
need finer authorization than that. A single certificate may
authenticate several distinct actors, and an administrator may
wish to grant different levels of access to different peers
presenting the same certificate.

Once a TLS handshake completes, tlshd hands the kernel a list of
tags associated with the session. For exports with an allow_tags
list configured, NFSD tests the handshake tags against that list
and grants access only when the session carries at least one
matching tag. Exports with no allow_tags list continue to grant
access to any authenticated peer, preserving existing behavior.

Tags accompany only mTLS sessions, so allow_tags is meaningful
only when xprtsec resolves to mtls alone. svc_export_parse()
rejects an allow_tags list paired with any other xprtsec mode,
making the administrator state the combination explicitly rather
than allowing a default xprtsec setting to silently expose the
export to plaintext or anonymous-TLS peers.

Tags are parsed from exportfs during cache fill and freed when
the export cache entry is released. Tagset ownership transfers
to the cache entry on update so memory is managed correctly
across the cache lifecycle.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/export.c        | 73 +++++++++++++++++++++++++++++++++++++++++++++++--
 fs/nfsd/export.h        | 11 ++++++++
 fs/nfsd/trace.h         | 19 +++++++++++++
 include/net/handshake.h |  4 +++
 4 files changed, 105 insertions(+), 2 deletions(-)

diff --git a/fs/nfsd/export.c b/fs/nfsd/export.c
index a47c90f40422..a2aaa3cd6c52 100644
--- a/fs/nfsd/export.c
+++ b/fs/nfsd/export.c
@@ -18,6 +18,7 @@
 #include <linux/exportfs.h>
 #include <linux/sunrpc/svc_xprt.h>
 #include <net/genetlink.h>
+#include <net/handshake.h>
 #include <uapi/linux/nfsd_netlink.h>
 
 #include "nfsd.h"
@@ -627,6 +628,7 @@ static void svc_export_release(struct rcu_head *rcu_head)
 	struct svc_export *exp = container_of(rcu_head, struct svc_export,
 			ex_rcu);
 
+	tagset_destroy(&exp->ex_allow_tags);
 	nfsd4_fslocs_free(&exp->ex_fslocs);
 	export_stats_destroy(exp->ex_stats);
 	kfree(exp->ex_stats);
@@ -1285,6 +1287,55 @@ static int xprtsec_parse(char **mesg, char *buf, struct svc_export *exp)
 	return 0;
 }
 
+static int tags_parse(char **mesg, char *buf, struct tagset *tags)
+{
+	unsigned int i, listsize;
+	int err;
+
+	/* more than one allow_tags */
+	if (tags->ts_finalized)
+		return -EINVAL;
+
+	err = get_uint(mesg, &listsize);
+	if (err)
+		return -EINVAL;
+	if (listsize == 0 || listsize > NFSD_MAX_ALLOW_TAGS)
+		return -EINVAL;
+	if (!tagset_alloc(tags, listsize, GFP_KERNEL))
+		return -ENOMEM;
+
+	for (i = 0; i < listsize; i++) {
+		int len;
+
+		len = qword_get(mesg, buf, PAGE_SIZE);
+		if (len <= 0 || len > HANDSHAKE_SESSION_TAG_MAX_LEN)
+			return -EINVAL;
+		if (strlen(buf) != len)
+			return -EINVAL;
+		if (!tagset_add_dup(tags, buf, GFP_KERNEL))
+			return -ENOMEM;
+	}
+	tagset_finalize(tags);
+
+	return 0;
+}
+
+/*
+ * Session tags are issued only with an mTLS handshake, so an
+ * allow_tags list is meaningful only when xprtsec resolves to
+ * mtls alone. Reject combinations that would otherwise let
+ * plaintext or anonymous-TLS peers reach the export without
+ * ever consulting the tag list. Every producer of a svc_export
+ * must apply this check after it has resolved both fields.
+ */
+static int check_allow_tags(const struct svc_export *exp)
+{
+	if (!tagset_is_empty(&exp->ex_allow_tags) &&
+	    exp->ex_xprtsec_modes != NFSEXP_XPRTSEC_MTLS)
+		return -EINVAL;
+	return 0;
+}
+
 static inline int
 nfsd_uuid_parse(char **mesg, char *buf, unsigned char **puuid)
 {
@@ -1346,6 +1397,7 @@ static int svc_export_parse(struct cache_detail *cd, char *mesg, int mlen)
 	exp.cd = cd;
 	exp.ex_devid_map = NULL;
 	exp.ex_xprtsec_modes = NFSEXP_XPRTSEC_ALL;
+	tagset_init(&exp.ex_allow_tags);
 
 	/* expiry */
 	err = get_expiry(&mesg, &exp.h.expiry_time);
@@ -1389,6 +1441,8 @@ static int svc_export_parse(struct cache_detail *cd, char *mesg, int mlen)
 				err = secinfo_parse(&mesg, buf, &exp);
 			else if (strcmp(buf, "xprtsec") == 0)
 				err = xprtsec_parse(&mesg, buf, &exp);
+			else if (strcmp(buf, "allow_tags") == 0)
+				err = tags_parse(&mesg, buf, &exp.ex_allow_tags);
 			else
 				/* quietly ignore unknown words and anything
 				 * following. Newer user-space can try to set
@@ -1399,6 +1453,10 @@ static int svc_export_parse(struct cache_detail *cd, char *mesg, int mlen)
 				goto out4;
 		}
 
+		err = check_allow_tags(&exp);
+		if (err)
+			goto out4;
+
 		err = check_export(&exp.ex_path, &exp.ex_flags, exp.ex_uuid);
 		if (err)
 			goto out4;
@@ -1441,6 +1499,7 @@ static int svc_export_parse(struct cache_detail *cd, char *mesg, int mlen)
 	} else
 		err = -ENOMEM;
 out4:
+	tagset_destroy(&exp.ex_allow_tags);
 	nfsd4_fslocs_free(&exp.ex_fslocs);
 	kfree(exp.ex_uuid);
 out3:
@@ -1568,6 +1627,8 @@ static void export_update(struct cache_head *cnew, struct cache_head *citem)
 		new->ex_flavors[i] = item->ex_flavors[i];
 	}
 	new->ex_xprtsec_modes = item->ex_xprtsec_modes;
+	new->ex_allow_tags = item->ex_allow_tags;
+	tagset_init(&item->ex_allow_tags);
 }
 
 static struct cache_head *svc_export_alloc(void)
@@ -1588,6 +1649,8 @@ static struct cache_head *svc_export_alloc(void)
 		return NULL;
 	}
 
+	tagset_init(&i->ex_allow_tags);
+
 	return &i->h;
 }
 
@@ -1815,8 +1878,14 @@ __be32 check_xprtsec_policy(struct svc_export *exp, struct svc_rqst *rqstp)
 	}
 	if (exp->ex_xprtsec_modes & NFSEXP_XPRTSEC_MTLS) {
 		if (test_bit(XPT_TLS_SESSION, &xprt->xpt_flags) &&
-		    test_bit(XPT_PEER_AUTH, &xprt->xpt_flags))
-			return nfs_ok;
+		    test_bit(XPT_PEER_AUTH, &xprt->xpt_flags)) {
+			if (tagset_is_empty(&exp->ex_allow_tags))
+				return nfs_ok;
+			if (tagset_intersection(&xprt->xpt_handshake_tags,
+						&exp->ex_allow_tags))
+				return nfs_ok;
+			trace_nfsd_export_tags_denied(exp);
+		}
 	}
 	return nfserr_wrongsec;
 }
diff --git a/fs/nfsd/export.h b/fs/nfsd/export.h
index d2b09cd76145..c315cb4f0538 100644
--- a/fs/nfsd/export.h
+++ b/fs/nfsd/export.h
@@ -7,6 +7,7 @@
 
 #include <linux/sunrpc/cache.h>
 #include <linux/percpu_counter.h>
+#include <linux/tagset.h>
 #include <uapi/linux/nfsd/export.h>
 #include <linux/nfs4.h>
 
@@ -47,6 +48,15 @@ struct exp_flavor_info {
 	u32	flags;
 };
 
+/*
+ * Cap on the number of tags in an export's allow_tags list. This
+ * is an export policy limit, independent of the per-handshake cap
+ * on session tags (HANDSHAKE_MAX_SESSIONTAGS). It bounds the cost
+ * of the tagset_intersection() that check_xprtsec_policy() runs
+ * per request against a tagged export.
+ */
+#define NFSD_MAX_ALLOW_TAGS	64
+
 /* Per-export stats */
 enum {
 	EXP_STATS_FH_STALE,
@@ -78,6 +88,7 @@ struct svc_export {
 	struct rcu_head		ex_rcu;
 	unsigned long		ex_xprtsec_modes;
 	struct export_stats	*ex_stats;
+	struct tagset		ex_allow_tags;
 };
 
 /* an "export key" (expkey) maps a filehandlefragement to an
diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
index d01496aa3cf8..a426da9efebf 100644
--- a/fs/nfsd/trace.h
+++ b/fs/nfsd/trace.h
@@ -467,6 +467,25 @@ TRACE_EVENT(nfsd_export_update,
 	)
 );
 
+TRACE_EVENT(nfsd_export_tags_denied,
+	TP_PROTO(
+		const struct svc_export *exp
+	),
+	TP_ARGS(exp),
+	TP_STRUCT__entry(
+		__string(path, exp->ex_path.dentry->d_name.name)
+		__string(auth_domain, exp->ex_client->name)
+	),
+	TP_fast_assign(
+		__assign_str(path);
+		__assign_str(auth_domain);
+	),
+	TP_printk("path=%s domain=%s",
+		__get_str(path),
+		__get_str(auth_domain)
+	)
+);
+
 DECLARE_EVENT_CLASS(nfsd_io_class,
 	TP_PROTO(struct svc_rqst *rqstp,
 		 struct svc_fh	*fhp,
diff --git a/include/net/handshake.h b/include/net/handshake.h
index fa43b108c2a8..d7411dbf5253 100644
--- a/include/net/handshake.h
+++ b/include/net/handshake.h
@@ -11,10 +11,14 @@
 #define _NET_HANDSHAKE_H
 
 #include <linux/tagset.h>
+#include <uapi/linux/handshake.h>
 
 /*
  * Per-handshake cap on session tags. Bounds the cost of
  * tagset_intersection() in consumer authorization checks.
+ * The per-tag byte limit is HANDSHAKE_SESSION_TAG_MAX_LEN,
+ * generated from Documentation/netlink/specs/handshake.yaml
+ * and enforced by the netlink policy at the kernel boundary.
  */
 #define HANDSHAKE_MAX_SESSIONTAGS	64
 

-- 
2.54.0


