Return-Path: <linux-nfs+bounces-22314-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id BijEIdcKI2r+gwEAu9opvQ
	(envelope-from <linux-nfs+bounces-22314-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 05 Jun 2026 19:43:51 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E054364A47E
	for <lists+linux-nfs@lfdr.de>; Fri, 05 Jun 2026 19:43:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="bS/abJK3";
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22314-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22314-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 083423057D69
	for <lists+linux-nfs@lfdr.de>; Fri,  5 Jun 2026 17:35:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7A633A7D74;
	Fri,  5 Jun 2026 17:34:59 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B70483939A6;
	Fri,  5 Jun 2026 17:34:53 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780680899; cv=none; b=Xybs0jYoTjqctBKWCpfJ0znl6shp7xDssPfq6M6Z8rSGr9sN9fh45QX1jKLT2hszKF1d0HCm31UgKKXZRBmzrFgkljseDB8sTnwECkEnsz4rPNM+WdQSGAMCL/I0LU2RiqUQuR4JCd6O3VKpr6yIowsu6+/+MUqTUQ+eHyk8NJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780680899; c=relaxed/simple;
	bh=xWRQbnt+CbREWWd/JeVlyE+DmVpyST9DLEbgrEei0/w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=V2gIAFlGzp82Q00i8T+9FCaPNA0wkobzWJlhtRVtcumNuIddxKw0sjmtfg+1xdQCm5UVEE4vskBA7avuumTWUajqpRuW2Xmu5+8C8xls90EaYbxrYhYQVh9hkbZr+u8kx8rtUiF0RVE46dTd0TMhMHw8h/98BcIKj8y/nlA2Tjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bS/abJK3; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 929591F00893;
	Fri,  5 Jun 2026 17:34:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780680893;
	bh=S8NVT3n+DweLg9Rp9IYbrAlVDuzEAGo6ikCfN4z9l48=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=bS/abJK3/EQH758AAy8FW2SKDIVUKuC0eYrtld246gBP+a+TFyNrORnWWUnhkNhac
	 ZCgBgfTjuIrK2IuLKu7TtBsPO9ynCD5bCmnxxo5sEh/RHmmXQuTyN46aDPUMBAZZYz
	 i1EmFSezf+g5z4VeAF+Ndon5Vx5qQRjDkPNLVkRr924NUlwQ9RsuMEY9XA7tdwMHl6
	 SNVgRJn/oeJaJqAUB8YiEnTqr18SWtdNqAWD64i/ylvtewhUhQPgyvPDasVDn4SBuf
	 S6Izw7uGbqMsUsGC7nHt3pydr2ShZ5xK3KMMCfo2DiF06mx8T+aBldCM98QNk7tMNN
	 PeoJB2sw5KvJw==
From: Chuck Lever <cel@kernel.org>
Date: Fri, 05 Jun 2026 13:34:38 -0400
Subject: [PATCH 4/9] handshake: Pick up session tags passed during the DONE
 downcall
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260605-tls-session-tags-v1-4-47bd1d94d552@oracle.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=20590;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=8YNJPgqohKIpWPKyqoRsZhuhz9Bl90i2LRAkaZSXs8U=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBqIwi47+Dh1C80GkL/+wcN6T4/VblscRT8ylrwH
 GX5Sb5s1bKJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCaiMIuAAKCRAzarMzb2Z/
 l9lED/0Tyw3JzGduvpjJ4cNBqVndHr2YzoD0flUj2hwURJC3++RpTi38fx2EjOoBNMQIamteM4/
 ewRl0Pr9mOFSvcMhgjGbZHA3wTfbCZ22eogDI4EAR9DBytG1Tmi0/Tzp6yWINHninsenQwdalo+
 7tRE4uCp2HQf2hfIoLv7n+MsdxjthBrC1hdt4TMCgV3wB6zOHxy7Z2+1MTVYxrMUqh+brH8nql0
 mOE887ebGhfq571AhHcq2/jcR4DHweiX2o4mj/62TiXV4s4d3tjFO8J2Wyi1Z3mgHarTPaqz930
 WD0kKCrTcFZJmGix7cA2cXt4UmOwtXihPrgWCmgixsNV2F0vmMwLlNjDXxEqUzOxx6mwpj4pHpC
 gwnXi9EVjS+TVYchr7tKlaYZ2JNvrFHCo0aV4iRAONEzeHRNtrVulDdrOOPhcrl3b/Gb3b8zsPT
 RPHYvkvMlByjos+BuPXF2vzyEupI9FX9EPsR38hs09277HiTytVpmhULNFHrDyP7BRhjcFDXu39
 iDPRy6VyVvqLvew3/nU8AS1qjX/v2Y26IZvFB45uhIqBULTzNTUz/tAdIcKtZeC+mCY21d5NqO6
 G0gIMxBjk2rXshRbj6bpjEYsHxLMTwXJqSwZOiFGVEue0+x4kEEWQjIgdb0xwHBF7dTyRnfk3QR
 hidaB4KRp1oEyow==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
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
	TAGGED_FROM(0.00)[bounces-22314-lists,linux-nfs=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oracle.com:mid,oracle.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E054364A47E

From: Chuck Lever <chuck.lever@oracle.com>

Upper Layer Protocols such as NFS require access control based on
TLS certificate characteristics. Parsing x.509 in the kernel
duplicates work mature userspace libraries already do. The tlshd
daemon can evaluate certificates against administrator-defined
policies and assign tags indicating which policies a certificate
satisfies.

This change collects session tags from the DONE netlink downcall
and passes them to handshake consumers via their completion
callback. Consumers can then make authorization decisions based on
tag membership without certificate parsing. For example, NFSD can
restrict export access to connections whose certificate earned a
particular tag, delegating certificate policy to tlshd
configuration.

The tagset is populated by iterating HANDSHAKE_A_DONE_TAG attributes
from the netlink message and finalized before delivery to consumers.

The genl family runs DONE with parallel_ops, so duplicate or
concurrent DONE downcalls for the same socket can both reach the
same handshake_req. Each handler collects into a private local
tagset, takes a one-completion gate, and on winning publishes the
set into req->hr_tags by struct assignment. Keeping the gate
region free of GFP_KERNEL allocations preserves the cancel
contract: handshake_req_cancel() returning false means the
consumer callback has run or is about to, with no sleeping work
remaining. Otherwise a concurrent svc_sock_free() observing the
gate as taken would free callback data while the delayed callback
is still pending. Split handshake_complete() into a try/finish
pair so the netlink handler can collect tags before the gate and
publish them after winning, refusing duplicates with -EBUSY.

When the count exceeds HANDSHAKE_MAX_SESSIONTAGS, the handler
truncates the list, logs a single pr_warn_once(), and returns
success. Failing the DONE with -E2BIG would signal the daemon
definitively but would also tear down a handshake the operator
almost certainly wants to keep; the trade-off favors session
continuity and treats overrun as a misconfiguration to fix in
tlshd. A subsequent patch advertises the cap on every ACCEPT
reply so tlshd can avoid overrunning in the first place.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 Documentation/networking/tls-handshake.rst |  56 ++++++++++++++-
 drivers/nvme/host/tcp.c                    |   3 +-
 drivers/nvme/target/tcp.c                  |   3 +-
 include/net/handshake.h                    |  26 ++++++-
 net/handshake/handshake.h                  |   6 ++
 net/handshake/netlink.c                    | 109 ++++++++++++++++++++++++++++-
 net/handshake/request.c                    |  66 ++++++++++++++---
 net/handshake/tlshd.c                      |   5 +-
 net/sunrpc/svcsock.c                       |   5 +-
 net/sunrpc/xprtsock.c                      |   5 +-
 10 files changed, 266 insertions(+), 18 deletions(-)

diff --git a/Documentation/networking/tls-handshake.rst b/Documentation/networking/tls-handshake.rst
index 4f7bc1087df9..352842a74e6b 100644
--- a/Documentation/networking/tls-handshake.rst
+++ b/Documentation/networking/tls-handshake.rst
@@ -169,7 +169,8 @@ The synopsis of this function is:
 .. code-block:: c
 
   typedef void	(*tls_done_func_t)(void *data, int status,
-                                   key_serial_t peerid);
+                                   key_serial_t peerid,
+                                   const struct tagset *tags);
 
 The consumer provides a cookie in the @ta_data field of the
 tls_handshake_args structure that is returned in the @data parameter of
@@ -200,6 +201,10 @@ The @peerid parameter contains the serial number of a key containing the
 remote peer's identity or the value TLS_NO_PEERID if the session is not
 authenticated.
 
+The @tags parameter points to a tagset containing session metadata
+assigned by the handshake agent. See the "Session Tags" section
+below for details on lifetime and safe access patterns.
+
 A best practice is to close and destroy the socket immediately if the
 handshake failed.
 
@@ -220,3 +225,52 @@ received message data is TLS record data or session metadata.
 See tls.rst for details on how a kTLS consumer recognizes incoming
 (decrypted) application data, alerts, and handshake packets once the
 socket has been promoted to use the TLS ULP.
+
+
+Session Tags
+============
+
+When a TLS handshake completes successfully, the handshake agent may
+assign metadata tags to the session. These tags enable kernel consumers
+to make authorization decisions based on certificate characteristics
+without parsing x.509 certificates directly.
+
+The handshake agent evaluates the peer's certificate against
+administrator-defined policies and assigns tags indicating which
+policies the certificate satisfies. For example, an administrator
+might configure the agent to assign an "internal-servers" tag when a
+certificate's Issuer DN matches a particular corporate CA.
+
+Tags are delivered to the consumer via the @tags parameter of the
+completion callback. The tagset is valid only for the duration of the
+callback. Consumers needing persistent access must copy the tagset
+using tagset_copy() before returning.
+
+To check whether a session has a particular tag:
+
+.. code-block:: c
+
+  if (tagset_is_member(tags, "internal-servers")) {
+          /* Certificate matched the internal-servers policy */
+  }
+
+To check whether a session has any tag from a small fixed set:
+
+.. code-block:: c
+
+  if (tagset_is_member(tags, "admin") ||
+      tagset_is_member(tags, "operator")) {
+          /* Certificate matched admin or operator policy */
+  }
+
+When the required set is dynamic (e.g., parsed from an export option),
+construct a tagset and use tagset_intersection() to test for any
+overlap. See Documentation/core-api/tagset.rst for the
+initialization, add, and finalize sequence.
+
+If the handshake failed or no tags were assigned, the tagset is
+empty. The handshake layer always delivers a finalized tagset to
+the callback, so consumers may call tagset_is_member() and
+tagset_intersection() unconditionally without a separate guard.
+
+See Documentation/core-api/tagset.rst for the complete tagset API.
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 15d36d6a728e..d08c03f89661 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1691,7 +1691,8 @@ static void nvme_tcp_set_queue_io_cpu(struct nvme_tcp_queue *queue)
 		qid, queue->io_cpu);
 }
 
-static void nvme_tcp_tls_done(void *data, int status, key_serial_t pskid)
+static void nvme_tcp_tls_done(void *data, int status, key_serial_t pskid,
+			      const struct tagset *tags)
 {
 	struct nvme_tcp_queue *queue = data;
 	struct nvme_tcp_ctrl *ctrl = queue->ctrl;
diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index 20f150d17a96..7e0132b8ac93 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -1821,7 +1821,8 @@ static int nvmet_tcp_tls_key_lookup(struct nvmet_tcp_queue *queue,
 }
 
 static void nvmet_tcp_tls_handshake_done(void *data, int status,
-					 key_serial_t peerid)
+					 key_serial_t peerid,
+					 const struct tagset *tags)
 {
 	struct nvmet_tcp_queue *queue = data;
 
diff --git a/include/net/handshake.h b/include/net/handshake.h
index 8ebd4f9ed26e..fa43b108c2a8 100644
--- a/include/net/handshake.h
+++ b/include/net/handshake.h
@@ -10,6 +10,14 @@
 #ifndef _NET_HANDSHAKE_H
 #define _NET_HANDSHAKE_H
 
+#include <linux/tagset.h>
+
+/*
+ * Per-handshake cap on session tags. Bounds the cost of
+ * tagset_intersection() in consumer authorization checks.
+ */
+#define HANDSHAKE_MAX_SESSIONTAGS	64
+
 enum {
 	TLS_NO_KEYRING = 0,
 	TLS_NO_PEERID = 0,
@@ -17,8 +25,24 @@ enum {
 	TLS_NO_PRIVKEY = 0,
 };
 
+/**
+ * typedef tls_done_func_t - TLS handshake completion callback
+ * @data: opaque context pointer set via tls_handshake_args.ta_data
+ * @status: zero on success, otherwise a negative errno
+ * @peerid: serial number of peer identity key, or TLS_NO_PEERID
+ * @tags: session tags assigned by the handshake agent
+ *
+ * Invoked when a TLS handshake completes, either successfully or with
+ * an error. The @tags parameter points to session metadata assigned
+ * by the handshake agent based on certificate policy evaluation. The
+ * tagset is empty when the handshake failed or no policies matched.
+ *
+ * The @tags pointer is valid only for the duration of this callback.
+ * Callers requiring persistent access must copy via tagset_copy().
+ */
 typedef void	(*tls_done_func_t)(void *data, int status,
-				   key_serial_t peerid);
+				   key_serial_t peerid,
+				   const struct tagset *tags);
 
 struct tls_handshake_args {
 	struct socket		*ta_sock;
diff --git a/net/handshake/handshake.h b/net/handshake/handshake.h
index a48163765a7a..3b32c7971682 100644
--- a/net/handshake/handshake.h
+++ b/net/handshake/handshake.h
@@ -10,6 +10,8 @@
 #ifndef _INTERNAL_HANDSHAKE_H
 #define _INTERNAL_HANDSHAKE_H
 
+#include <linux/tagset.h>
+
 /* Per-net namespace context */
 struct handshake_net {
 	spinlock_t		hn_lock;	/* protects next 3 fields */
@@ -34,6 +36,7 @@ struct handshake_req {
 	const struct handshake_proto	*hr_proto;
 	struct sock			*hr_sk;
 	void				(*hr_odestruct)(struct sock *sk);
+	struct tagset			hr_tags;
 
 	/* Always the last field */
 	char				hr_priv[];
@@ -86,6 +89,9 @@ struct handshake_req *handshake_req_hash_lookup(struct sock *sk);
 struct handshake_req *handshake_req_next(struct handshake_net *hn, int class);
 int handshake_req_submit(struct socket *sock, struct handshake_req *req,
 			 gfp_t flags);
+bool handshake_try_complete(struct handshake_req *req);
+void handshake_finish_complete(struct handshake_req *req, unsigned int status,
+			       struct genl_info *info);
 void handshake_complete(struct handshake_req *req, unsigned int status,
 			struct genl_info *info);
 bool handshake_req_cancel(struct sock *sk);
diff --git a/net/handshake/netlink.c b/net/handshake/netlink.c
index b989456fc4c5..0c2e68360a73 100644
--- a/net/handshake/netlink.c
+++ b/net/handshake/netlink.c
@@ -16,6 +16,7 @@
 
 #include <net/sock.h>
 #include <net/genetlink.h>
+#include <net/handshake.h>
 #include <net/netns/generic.h>
 
 #include <kunit/visibility.h>
@@ -133,11 +134,83 @@ int handshake_nl_accept_doit(struct sk_buff *skb, struct genl_info *info)
 	return err;
 }
 
+/*
+ * Pick up session tags from the DONE downcall payload into a
+ * caller-owned tagset. No handshake_req fields are mutated here:
+ * concurrent DONE handlers each populate a private tagset, and
+ * the winner of the completion gate publishes its set into
+ * req->hr_tags by struct assignment.
+ *
+ * Return: 0 if tags were processed (some may have been dropped on
+ * per-tag or bulk allocation pressure, or truncated at
+ * HANDSHAKE_MAX_SESSIONTAGS); a negative errno if the payload was
+ * rejected and no tags collected.
+ */
+static int handshake_get_sessiontags(struct tagset *tags,
+				     struct genl_info *info)
+{
+	unsigned int count = 0;
+	struct nlattr *nla;
+	int rem;
+
+	/*
+	 * Reject embedded NUL bytes only. NLA_STRING payloads may
+	 * arrive with or without a trailing NUL, and nla_strdup()
+	 * appends the terminator when copying into the tagset.
+	 * NLA_NUL_STRING would accept a NUL at any offset, and the
+	 * YAML schema cannot express "no NUL except as terminator,"
+	 * so the check belongs here.
+	 */
+	nlmsg_for_each_attr_type(nla, HANDSHAKE_A_DONE_TAG, info->nlhdr,
+				 GENL_HDRLEN, rem) {
+		const char *src = nla_data(nla);
+		size_t srclen = nla_len(nla);
+
+		if (srclen > 0 && src[srclen - 1] == '\0')
+			srclen--;
+		if (srclen == 0 || memchr(src, '\0', srclen))
+			return -EINVAL;
+		count++;
+	}
+	if (count == 0)
+		return 0;
+	if (count > HANDSHAKE_MAX_SESSIONTAGS) {
+		pr_warn_once("handshake: too many session tags (%u > %u)\n",
+			     count, HANDSHAKE_MAX_SESSIONTAGS);
+		count = HANDSHAKE_MAX_SESSIONTAGS;
+	}
+	if (!tagset_alloc(tags, count, GFP_KERNEL)) {
+		pr_warn_once("handshake: dropping session tags under memory pressure\n");
+		return 0;
+	}
+
+	nlmsg_for_each_attr_type(nla, HANDSHAKE_A_DONE_TAG, info->nlhdr,
+				 GENL_HDRLEN, rem) {
+		char *tag;
+
+		/*
+		 * The first pass may have clamped count to
+		 * HANDSHAKE_MAX_SESSIONTAGS. Stop here to avoid
+		 * alloc/free churn on excess attributes.
+		 */
+		if (tagset_count(tags) >= count)
+			break;
+
+		tag = nla_strdup(nla, GFP_KERNEL);
+		if (!tag)
+			continue;
+		if (!tagset_add(tags, tag))
+			kfree(tag);
+	}
+	return 0;
+}
+
 int handshake_nl_done_doit(struct sk_buff *skb, struct genl_info *info)
 {
 	struct net *net = sock_net(skb->sk);
 	struct handshake_req *req;
 	struct socket *sock;
+	DEFINE_TAGSET(tags);
 	int fd, status, err;
 
 	if (GENL_REQ_ATTR_CHECK(info, HANDSHAKE_A_DONE_SOCKFD))
@@ -161,10 +234,42 @@ int handshake_nl_done_doit(struct sk_buff *skb, struct genl_info *info)
 	status = -EIO;
 	if (info->attrs[HANDSHAKE_A_DONE_STATUS])
 		status = nla_get_u32(info->attrs[HANDSHAKE_A_DONE_STATUS]);
+	err = 0;
+	if (!status) {
+		int ret = handshake_get_sessiontags(&tags, info);
 
-	handshake_complete(req, status, info);
+		if (ret < 0) {
+			err = ret;
+			trace_handshake_cmd_done_err(net, req, sock->sk, err);
+			status = -EIO;
+		}
+	}
+
+	/*
+	 * Take the unique-completer gate after collection so the gate
+	 * region contains no GFP_KERNEL allocations. handshake_req_cancel()
+	 * observers must not see the gate as taken while sleeping work
+	 * remains here, or they will free callback data while the consumer
+	 * callback is still pending.
+	 */
+	if (!handshake_try_complete(req)) {
+		trace_handshake_cmd_done_err(net, req, sock->sk, -EBUSY);
+		tagset_destroy(&tags);
+		sockfd_put(sock);
+		return -EBUSY;
+	}
+
+	/*
+	 * Publish the locally-collected tagset. req->hr_tags was
+	 * initialized empty by handshake_req_alloc() and no other writer
+	 * can reach it past the gate, so a struct assignment cleanly
+	 * transfers ownership of the heap-allocated tag array.
+	 */
+	req->hr_tags = tags;
+
+	handshake_finish_complete(req, status, info);
 	sockfd_put(sock);
-	return 0;
+	return err;
 }
 
 static unsigned int handshake_net_id;
diff --git a/net/handshake/request.c b/net/handshake/request.c
index 2829adbeb149..2215a9916727 100644
--- a/net/handshake/request.c
+++ b/net/handshake/request.c
@@ -79,6 +79,7 @@ static void handshake_req_destroy(struct handshake_req *req)
 		req->hr_proto->hp_destroy(req);
 	rhashtable_remove_fast(&handshake_rhashtbl, &req->hr_rhash,
 			       handshake_rhash_params);
+	tagset_destroy(&req->hr_tags);
 	kfree(req);
 }
 
@@ -124,6 +125,7 @@ struct handshake_req *handshake_req_alloc(const struct handshake_proto *proto,
 		return NULL;
 
 	INIT_LIST_HEAD(&req->hr_list);
+	tagset_init(&req->hr_tags);
 	req->hr_proto = proto;
 	return req;
 }
@@ -284,19 +286,67 @@ int handshake_req_submit(struct socket *sock, struct handshake_req *req,
 }
 EXPORT_SYMBOL(handshake_req_submit);
 
-void handshake_complete(struct handshake_req *req, unsigned int status,
-			struct genl_info *info)
+/**
+ * handshake_try_complete - Take the unique-completer gate
+ * @req: handshake request being completed
+ *
+ * The DONE netlink op runs with parallel_ops, so duplicate or
+ * concurrent DONE downcalls for the same socket can both reach
+ * the same @req. The gate ensures that exactly one caller drives
+ * completion to the consumer.
+ *
+ * The gate is also observable via handshake_req_cancel(): once
+ * taken, cancel returns %false to indicate completion is in
+ * flight. Callers must therefore not perform sleeping work
+ * between handshake_try_complete() and handshake_finish_complete(),
+ * or a concurrent cancel will see the gate taken while the
+ * consumer callback has not yet run, and may free callback data
+ * out from under it.
+ *
+ * Return: %true if the caller has won the gate and is now
+ * responsible for calling handshake_finish_complete(); %false
+ * otherwise.
+ */
+bool handshake_try_complete(struct handshake_req *req)
+{
+	return !test_and_set_bit(HANDSHAKE_F_REQ_COMPLETED, &req->hr_flags);
+}
+
+/**
+ * handshake_finish_complete - Deliver completion to the consumer
+ * @req: handshake request being completed
+ * @status: completion status to deliver
+ * @info: netlink message context, or NULL
+ *
+ * Caller must have won the gate via handshake_try_complete().
+ * Finalizes hr_tags, invokes the consumer's done callback, and
+ * drops the sock reference taken at submit.
+ */
+void handshake_finish_complete(struct handshake_req *req, unsigned int status,
+			       struct genl_info *info)
 {
 	struct sock *sk = req->hr_sk;
 	struct net *net = sock_net(sk);
 
-	if (!test_and_set_bit(HANDSHAKE_F_REQ_COMPLETED, &req->hr_flags)) {
-		trace_handshake_complete(net, req, sk, status);
-		req->hr_proto->hp_done(req, status, info);
+	trace_handshake_complete(net, req, sk, status);
+	/*
+	 * Finalize unconditionally so consumers may call
+	 * tagset_is_member() and tagset_intersection() without
+	 * tripping the !ts_finalized WARN on paths where no DONE
+	 * tags were collected.
+	 */
+	tagset_finalize(&req->hr_tags);
+	req->hr_proto->hp_done(req, status, info);
 
-		/* Handshake request is no longer pending */
-		sock_put(sk);
-	}
+	/* Handshake request is no longer pending */
+	sock_put(sk);
+}
+
+void handshake_complete(struct handshake_req *req, unsigned int status,
+			struct genl_info *info)
+{
+	if (handshake_try_complete(req))
+		handshake_finish_complete(req, status, info);
 }
 EXPORT_SYMBOL_IF_KUNIT(handshake_complete);
 
diff --git a/net/handshake/tlshd.c b/net/handshake/tlshd.c
index 8f9532a15f43..9bcaeba74f8c 100644
--- a/net/handshake/tlshd.c
+++ b/net/handshake/tlshd.c
@@ -26,7 +26,8 @@
 
 struct tls_handshake_req {
 	void			(*th_consumer_done)(void *data, int status,
-						    key_serial_t peerid);
+						    key_serial_t peerid,
+						    const struct tagset *tags);
 	void			*th_consumer_data;
 
 	int			th_type;
@@ -105,7 +106,7 @@ static void tls_handshake_done(struct handshake_req *req,
 		set_bit(HANDSHAKE_F_REQ_SESSION, &req->hr_flags);
 
 	treq->th_consumer_done(treq->th_consumer_data, -status,
-			       treq->th_peerid[0]);
+			       treq->th_peerid[0], &req->hr_tags);
 }
 
 #if IS_ENABLED(CONFIG_KEYS)
diff --git a/net/sunrpc/svcsock.c b/net/sunrpc/svcsock.c
index 50e5e7f5b762..b4ad84910687 100644
--- a/net/sunrpc/svcsock.c
+++ b/net/sunrpc/svcsock.c
@@ -453,13 +453,16 @@ static void svc_tcp_kill_temp_xprt(struct svc_xprt *xprt)
  * @data: address of xprt to wake
  * @status: status of handshake
  * @peerid: serial number of key containing the remote peer's identity
+ * @tags: session tags assigned by the handshake agent; valid only for
+ *        the duration of this callback
  *
  * If a security policy is specified as an export option, we don't
  * have a specific export here to check. So we set a "TLS session
  * is present" flag on the xprt and let an upper layer enforce local
  * security policy.
  */
-static void svc_tcp_handshake_done(void *data, int status, key_serial_t peerid)
+static void svc_tcp_handshake_done(void *data, int status, key_serial_t peerid,
+				   const struct tagset *tags)
 {
 	struct svc_xprt *xprt = data;
 	struct svc_sock *svsk = container_of(xprt, struct svc_sock, sk_xprt);
diff --git a/net/sunrpc/xprtsock.c b/net/sunrpc/xprtsock.c
index 2e1fe6013361..b5e88ad64d63 100644
--- a/net/sunrpc/xprtsock.c
+++ b/net/sunrpc/xprtsock.c
@@ -2590,9 +2590,12 @@ static int xs_tcp_tls_finish_connecting(struct rpc_xprt *lower_xprt,
  * @data: address of xprt to wake
  * @status: status of handshake
  * @peerid: serial number of key containing the remote's identity
+ * @tags: session tags assigned by the handshake agent; valid only for
+ *        the duration of this callback
  *
  */
-static void xs_tls_handshake_done(void *data, int status, key_serial_t peerid)
+static void xs_tls_handshake_done(void *data, int status, key_serial_t peerid,
+				  const struct tagset *tags)
 {
 	struct rpc_xprt *lower_xprt = data;
 	struct sock_xprt *lower_transport =

-- 
2.54.0


