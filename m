Return-Path: <linux-nfs+bounces-22309-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Jc3ZOcsJI2qwgwEAu9opvQ
	(envelope-from <linux-nfs+bounces-22309-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 05 Jun 2026 19:39:23 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F66564A3EC
	for <lists+linux-nfs@lfdr.de>; Fri, 05 Jun 2026 19:39:23 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=l+12JbrE;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22309-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22309-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BE0E730215B2
	for <lists+linux-nfs@lfdr.de>; Fri,  5 Jun 2026 17:35:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DAEA28D8D0;
	Fri,  5 Jun 2026 17:34:56 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D678337DEAB;
	Fri,  5 Jun 2026 17:34:51 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780680896; cv=none; b=ExgeUp19dxgra/+TKQtv6Lbarffrg1myhldHGvFKMReObzpYVU4HMUzIqjna0k0TuguAkmUc+AHnmEmQiGvx+TnZwWdWoUq5OM+mwbJ3GG4gE9MVgrmuDupIMMB5+qx2r9y5fMC+cNzrI6TM1s2X+5jc8sWAfZ5eUJthVIpmlnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780680896; c=relaxed/simple;
	bh=OU5zBppSLnS91P7kps/4144xT5hkW/xyj6u86zDuQvg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ixHxGiyoTJhOm5Mut4XT0YnZWblp7xkQkUvQAo471uiB63AMG7g0Vq9elUgaOOWvrQo2Ta39IZHeaRvTCRjwXFPwKXYWbhffNXCJiFfCa8uUagdx3Gey6Q2RD+t51GoKQmwgQBTjTye+gbXZqd3avSjD7oA6tnPQENjozxaXVmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l+12JbrE; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB7FD1F00899;
	Fri,  5 Jun 2026 17:34:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780680891;
	bh=V/dcJhXSKaE3n7NQ5xW19IGzVI9Vyk+9mFJYm98AOHQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=l+12JbrEkCWBdqMF9eTWMMYCgSE82Qc0yxlGvFV1iZoaUWNfZAmLLn0OayvFzRFEa
	 Yr5REj+IyRKJn9uSviNS31HwAsEK9fc3Q9+3xqC1rf6oGg8aCDSuY3R+V4IEOjvNXR
	 qyz6OUUibNyC05mpqNx8SZL/uApkYxrN0RBE31s2oq6coLf8xFfmJ5cXE2XyKLy9GR
	 eIlb3CmamIs1WNSQQGlqoJ0IrkNpg13PpRhl3FhSD4E7Agyp2p3ydX/xe15zM4C4xP
	 9SlHoQTSp8XcAJ6vkwJ9VRjPJa8xwFoPFZ0HNrxVNnXEOPeF+34cp6Awu/FCbqZt6H
	 JAsYjTwjvxqzw==
From: Chuck Lever <cel@kernel.org>
Date: Fri, 05 Jun 2026 13:34:36 -0400
Subject: [PATCH 2/9] handshake: Add tags to "done" downcall
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260605-tls-session-tags-v1-2-47bd1d94d552@oracle.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3940;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=raiD69EEfWXSUEQR4pc412efHZtvbS6Dgdf+27/Tio8=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBqIwi4JtdADUcQ2AMz0APvxhHntoYAxpgcEYf2H
 1mlLzsWsBWJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCaiMIuAAKCRAzarMzb2Z/
 l6+eEACFME0TL0R/99w5IVzPGLWaARo7vOHVyyESnJPoJIF4rFt9b+tZRS8IzbkZOtAgOQ/1Dqv
 Jb1w+yugVvRhfSdc9b0stYWMaO+iGOLvJWi8nHg/SE3+BLVq07VM3cbzxvZJAlkTepMB7SVCiUP
 evA2bhWqYNBwjGCgqJhk1FXyIKb1jboRoP/9r5wNmwcBoBDrNsT/ySn6uGfG+SkSjqznQqrEdRP
 /NbZPew88f3dQG/5IldOojbs7ePyCvmgl5w2zLszX/DV3EVwPu9vuLG5EqGbM93kIPav0uPdAc7
 BMtDeVX95U6Wx3u6ZCgpaTnVX5IiZo8eVUOFTjBT7GQM0U2/TnL8HnQEnaqD/fls4X8afHiM+9D
 qy4v89gVbyqqggyCZtKQvJTvt1SsaiALjgo0U6WQHvAmxhVp0njY+27OpaJoA8sbj2uRMMPTf6s
 Hl3Qj+0Mp7dzsj/gdGeJDMmu0DeM+uCaSC35zpP895U3aNzhY9vAhtd9yVBpKJ2c+fGfxt1Tn8c
 YkCKU8UjrIFuhVr3Fx/WA2KRykq0c5qcUnNRXlvwpjMBXLMdAHW3RVl/CgWLaOIDUBjwKX3Poqb
 d1uvtK5/fzw76SXL8aPn8jv4GEGU85Ekey50TXDmXvMsryG8cfsJO1BJCzZnge+shVjpIdmTJoa
 RWvbw6e0ce7jy0w==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
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
	TAGGED_FROM(0.00)[bounces-22309-lists,linux-nfs=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,oracle.com:mid,oracle.com:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8F66564A3EC

From: Chuck Lever <chuck.lever@oracle.com>

We'd like tlshd to tag certificates according to admin-defined
characteristics. The tag list is to be returned on a successful
handshake. Upper Layer Protocols (such as NFS) can then authorize
access based on the set of tags returned to the kernel.

For example, suppose NFSD wants to restrict access to an export to
only clients that present certificates whose issuer DN contains
"O=Oracle". tlshd can parse incoming certificates, and add an
"oraclegroup" tag to handshakes where a client presents a
certificate with "O=Oracle" somewhere in its Issuer field. NFSD can
then be configured to look for that tag and permit access only when
it is present. NFSD needs no knowledge of x.509 certificates.

This patch plumbs in the netlink protocol elements for tlshd to
return a list of tags to the kernel when a TLS or QUIC handshake
succeeds. Subsequent patches add tag extraction and storage in
the handshake layer.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 Documentation/netlink/specs/handshake.yaml | 11 +++++++++++
 include/uapi/linux/handshake.h             |  3 +++
 net/handshake/genl.c                       |  5 +++--
 3 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/Documentation/netlink/specs/handshake.yaml b/Documentation/netlink/specs/handshake.yaml
index 24f5a0ac5920..df36ff7da18f 100644
--- a/Documentation/netlink/specs/handshake.yaml
+++ b/Documentation/netlink/specs/handshake.yaml
@@ -12,6 +12,10 @@ protocol: genetlink
 doc: Netlink protocol to request a transport layer security handshake.
 
 definitions:
+  -
+    name: session-tag-max-len
+    type: const
+    value: 255
   -
     type: enum
     name: handler-class
@@ -87,6 +91,12 @@ attribute-sets:
         name: remote-auth
         type: u32
         multi-attr: true
+      -
+        name: tag
+        type: string
+        checks:
+          max-len: session-tag-max-len
+        multi-attr: true
 
 operations:
   list:
@@ -124,6 +134,7 @@ operations:
             - status
             - sockfd
             - remote-auth
+            - tag
 
 mcast-groups:
   list:
diff --git a/include/uapi/linux/handshake.h b/include/uapi/linux/handshake.h
index d7e40f594888..1ed309e475b4 100644
--- a/include/uapi/linux/handshake.h
+++ b/include/uapi/linux/handshake.h
@@ -10,6 +10,8 @@
 #define HANDSHAKE_FAMILY_NAME		"handshake"
 #define HANDSHAKE_FAMILY_VERSION	1
 
+#define HANDSHAKE_SESSION_TAG_MAX_LEN	255
+
 enum handshake_handler_class {
 	HANDSHAKE_HANDLER_CLASS_NONE,
 	HANDSHAKE_HANDLER_CLASS_TLSHD,
@@ -56,6 +58,7 @@ enum {
 	HANDSHAKE_A_DONE_STATUS = 1,
 	HANDSHAKE_A_DONE_SOCKFD,
 	HANDSHAKE_A_DONE_REMOTE_AUTH,
+	HANDSHAKE_A_DONE_TAG,
 
 	__HANDSHAKE_A_DONE_MAX,
 	HANDSHAKE_A_DONE_MAX = (__HANDSHAKE_A_DONE_MAX - 1)
diff --git a/net/handshake/genl.c b/net/handshake/genl.c
index 791c45671cd6..385583805e02 100644
--- a/net/handshake/genl.c
+++ b/net/handshake/genl.c
@@ -17,10 +17,11 @@ static const struct nla_policy handshake_accept_nl_policy[HANDSHAKE_A_ACCEPT_HAN
 };
 
 /* HANDSHAKE_CMD_DONE - do */
-static const struct nla_policy handshake_done_nl_policy[HANDSHAKE_A_DONE_REMOTE_AUTH + 1] = {
+static const struct nla_policy handshake_done_nl_policy[HANDSHAKE_A_DONE_TAG + 1] = {
 	[HANDSHAKE_A_DONE_STATUS] = { .type = NLA_U32, },
 	[HANDSHAKE_A_DONE_SOCKFD] = { .type = NLA_S32, },
 	[HANDSHAKE_A_DONE_REMOTE_AUTH] = { .type = NLA_U32, },
+	[HANDSHAKE_A_DONE_TAG] = { .type = NLA_STRING, .len = HANDSHAKE_SESSION_TAG_MAX_LEN, },
 };
 
 /* Ops table for handshake */
@@ -36,7 +37,7 @@ static const struct genl_split_ops handshake_nl_ops[] = {
 		.cmd		= HANDSHAKE_CMD_DONE,
 		.doit		= handshake_nl_done_doit,
 		.policy		= handshake_done_nl_policy,
-		.maxattr	= HANDSHAKE_A_DONE_REMOTE_AUTH,
+		.maxattr	= HANDSHAKE_A_DONE_TAG,
 		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
 	},
 };

-- 
2.54.0


