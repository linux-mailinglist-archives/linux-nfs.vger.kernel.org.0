Return-Path: <linux-nfs+bounces-22308-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id wDEoD04KI2rWgwEAu9opvQ
	(envelope-from <linux-nfs+bounces-22308-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 05 Jun 2026 19:41:34 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AE92E64A441
	for <lists+linux-nfs@lfdr.de>; Fri, 05 Jun 2026 19:41:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=IGlgUUsp;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22308-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22308-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9E1A9304149D
	for <lists+linux-nfs@lfdr.de>; Fri,  5 Jun 2026 17:34:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96CCC38F658;
	Fri,  5 Jun 2026 17:34:52 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCCDE22173D;
	Fri,  5 Jun 2026 17:34:50 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780680892; cv=none; b=tIFTfjVtRFZAErtzDbi3ljbEqQDrKpI0+q/HiBcj7zsr4yBDy31m+YNQZ8SL8fYuskufBzFuNMUH04SIqcO5GomZ7wNTtvA21kcazZ53iesJtDqUHHEBLFo+W45TviXtzk50mnu9YpBMAe6O6EnEdU4CR2/4PkJwGtmc57V5dEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780680892; c=relaxed/simple;
	bh=fNpIS/lFvSh+3wzoQvGJJ+wp+0atIwin0LGBxADHr1M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NKT3XZ196d69NqXU23Yw7l7h7HJRkkmoeaikyZkR7RlgfMFqc/kmA+hiq5Y1bxhRYCTw6BRIt3sHZ1l0diT6JS7Du5A7N7Ts9C6z0HTb7A/L7xHPRKl0dPUDqRTwYsS2B+oZrkCZG20lsHdDEodi4p8TWOAlqVaVYomuv3gOxF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IGlgUUsp; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC81E1F00898;
	Fri,  5 Jun 2026 17:34:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780680890;
	bh=l0e2I4tkaafPAjonkJxsN6/NkvKVwejZuO/gjLANoso=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=IGlgUUspO0HkcQCR8RpKHrm5IDBTU7rc9jWEa7i8gQQiwKbg/gFfwCGe4WnbX08FK
	 o3nkOGL1L+Y11p8WD9tvn0yKzE+FJ9Pw5hMoN2v5452HrHU6V07mgbiT/YN2jGRNJt
	 4ubwWEPu9F7PUfVFhmonLdbhC8pbP6hN/2zbRgHNP3L6SSxHcGfbKnlB9RhAs83V+h
	 THZ4GF7oBEMjegqPYeEJZZXZgZ2HvAoIZutd6nP0tyiNyGwoqBRmZ1N6v1FNtoftw6
	 3NxS8xrRc9KTEFL8ZJTnb9YXVJybd0+w2agQynmqwTo9aL9GIFkPXS8rYe6a8DmT2H
	 gssu1hloaby4w==
From: Chuck Lever <cel@kernel.org>
Date: Fri, 05 Jun 2026 13:34:35 -0400
Subject: [PATCH 1/9] handshake: Require admin permission for DONE command
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260605-tls-session-tags-v1-1-47bd1d94d552@oracle.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2122;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=DNAMIdDfV+uLF7PeWYf87UtTJOGIrmRsnmjy9i973y8=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBqIwi4Az2KTdoVCyPvGZ4ycXQh/Il93XVV9ycmF
 jvrHR5hMRKJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCaiMIuAAKCRAzarMzb2Z/
 l/O+D/wOb3gZ0A1U3RE3xEbfWf2GRVFyXrkpcW9z3P0lQgdbZq4G+ZNuu3V/vekhR89gUSRq6+D
 XFobOpJJO0I70xO9wv3Sqto0S8kl3PnyEHVjYa07G8LjHaAPHGiYHoqP3WKOrXPoUeywnXIz+fZ
 Ths6SLB1lwVgRBLM3wj7qDwq5qSS8qu/6W/E1LO1NJDCT6JoKMssFjqDRWpc7mAVyN+bJk7TAEt
 OjkX+eDaDYUgbQUyOIlbe9tKgF9GSJfpDppY4Q/Sh2uxyEuByjCNzN1f0Sp3N8Vo18uGx3ljUhi
 oINRYZ4JbRBBDsl71tfdbeE52pX73GVugi8txVqWPNcIkVG1ZFevCWII0fDuPX2H44rnbTkIeCe
 bXYpf7hi8o6DWP3Bpgt8QJKEoAq71u9/b7PdHMiVkHrFgRJp6vZAAAlTDqZ+UlPUH0Miqgjb4Mo
 W8xAQdEUTP+tLyPLhHcLuVBrSLrmcwcseceO95hLqiNeYKd5hklAdvjLD12Li+XQ1IQvKWVJE/J
 lU9FxFNtKlUw8XttBExjVK+0CPOhPCkJXPdNpz4xxPsM6I4q/ZkwxMpZKDYxYX9Z1A+Nj27hORo
 XcLn4iajMiQDF/2kkR1KRANMx9iXx0BBCM9tGWGe9XLSbNwcf1R7o1H76sSaBWBpZXpgFazkxbk
 thKgTu21rljSEIg==
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
	TAGGED_FROM(0.00)[bounces-22308-lists,linux-nfs=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:mid,oracle.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AE92E64A441

From: Chuck Lever <chuck.lever@oracle.com>

ACCEPT and DONE are the two downcalls of the handshake genl
family, both intended for use by the trusted handshake agent
(tlshd). ACCEPT already requires GENL_ADMIN_PERM; DONE has
no privilege check at all.

The fd-lookup in handshake_nl_done_doit() only confirms that
some pending handshake request exists for the supplied sockfd;
it does not authenticate the sender. An unprivileged process
that guesses or observes a valid sockfd can therefore submit
a DONE with HANDSHAKE_A_DONE_STATUS == 0, leaving the kernel
consumer to proceed as if the handshake succeeded. A non-zero
status on a forged DONE tears down a legitimate in-flight
handshake before tlshd can report its real result.

A subsequent patch teaches the DONE handler to carry session
tags consumed for access control. That work makes closing the
existing gap a prerequisite, but the gap itself predates tags.

Fixes: 3b3009ea8abb ("net/handshake: Create a NETLINK service for handling handshake requests")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 Documentation/netlink/specs/handshake.yaml | 1 +
 net/handshake/genl.c                       | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/netlink/specs/handshake.yaml b/Documentation/netlink/specs/handshake.yaml
index 95c3fade7a8d..24f5a0ac5920 100644
--- a/Documentation/netlink/specs/handshake.yaml
+++ b/Documentation/netlink/specs/handshake.yaml
@@ -117,6 +117,7 @@ operations:
       name: done
       doc: Handler reports handshake completion
       attribute-set: done
+      flags: [admin-perm]
       do:
         request:
           attributes:
diff --git a/net/handshake/genl.c b/net/handshake/genl.c
index 870612609491..791c45671cd6 100644
--- a/net/handshake/genl.c
+++ b/net/handshake/genl.c
@@ -37,7 +37,7 @@ static const struct genl_split_ops handshake_nl_ops[] = {
 		.doit		= handshake_nl_done_doit,
 		.policy		= handshake_done_nl_policy,
 		.maxattr	= HANDSHAKE_A_DONE_REMOTE_AUTH,
-		.flags		= GENL_CMD_CAP_DO,
+		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
 	},
 };
 

-- 
2.54.0


