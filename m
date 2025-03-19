Return-Path: <linux-nfs+bounces-10693-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 55605A695C8
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Mar 2025 18:06:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE1441887035
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Mar 2025 17:04:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC09D202979;
	Wed, 19 Mar 2025 17:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OtV/xx/H"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B820C1F8730;
	Wed, 19 Mar 2025 17:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742403795; cv=none; b=oEGB1kt5iVBsB7uczlicZyFz8reZpz2CxLsnGGw+8Rn40N4vfJryBYDRdGzi2KjHmtCDJp4SSs1H2pcFg2NKBeKXpHq09/cssdiILHgv+c9AwKT5Pzld3j3/+4sj0Dsfn3iiaDUfFZqOtfjZmVi73XevceEkzkO47jG9XLk6vIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742403795; c=relaxed/simple;
	bh=c+f4b1ppS6dCDcnJUUtX6zpDtn8BdV+JApqNvx4B6dQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gY/NikG5GbL+5J2E0AETrzkD8wgzAPexs0TBvtvgbfQog4SrlcpGqWbTRMNd5AF43UBNKuBrU8gy7gHjdtOwNvymBnf2Ug8nw1IXQIGclnR9L9nP/rXoMl7m5kh0XpLee7895s3YffKIxHaKhhrKk2YAqQwHKCE39zBH6xPWWHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OtV/xx/H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 297BDC4CEEE;
	Wed, 19 Mar 2025 17:03:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742403795;
	bh=c+f4b1ppS6dCDcnJUUtX6zpDtn8BdV+JApqNvx4B6dQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=OtV/xx/HxjCdMBGo+gLm4nwrqbUpTw1q6g9W13lkGUBNC0PyuDMkI1Gc83301xGLZ
	 Dp1ojGL0YeWc8Y6IS/cEy2qgzS+UXpGlouwpKPCFp31cDd76pu+NHGLOCVzhf9WGjE
	 /1dSCWpFL6PxO/39CexNSq6R13lnGeyqom43YMxhAxXeM0kZsA0TQneAPi3hJG71oZ
	 WCOt6lmNNDCB2FyWn93D2aB7J40O4JM/PZ88FSlXCMcCOkkhSc0iNG/xNRLB0SUOdB
	 0ZHBsrQqmq/UetcQElPP6QhBGPIZ270ZKvk7YPO/Jv4H0j2R2+IYAzyAKx/P4BANJX
	 p0YovzVezn+5Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D001C35FFA;
	Wed, 19 Mar 2025 17:03:15 +0000 (UTC)
From: Nikhil Jha via B4 Relay <devnull+njha.janestreet.com@kernel.org>
Date: Wed, 19 Mar 2025 13:02:40 -0400
Subject: [PATCH v2 2/2] sunrpc: don't immediately retransmit on seqno miss
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250319-rfc2203-seqnum-cache-v2-2-2c98b859f2dd@janestreet.com>
References: <20250319-rfc2203-seqnum-cache-v2-0-2c98b859f2dd@janestreet.com>
In-Reply-To: <20250319-rfc2203-seqnum-cache-v2-0-2c98b859f2dd@janestreet.com>
To: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
 Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>, 
 Neil Brown <neilb@suse.de>, Olga Kornievskaia <okorniev@redhat.com>, 
 Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
 Nikhil Jha <njha@janestreet.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1742403794; l=1835;
 i=njha@janestreet.com; s=20250314; h=from:subject:message-id;
 bh=BUY6rJprONjD4kvNKWmmzFeJCgyo6ppGGxibOm8/Kxc=;
 b=xdX2yxAJ/6/gUy68y6Q9cvESRYHhyp5Lpb4S5e+WaYic8JxfVG7+vTuPjx6Py8ArM1tFBwawI
 LNh8oa3AoLGCNQmi/ZEwy7FJYnAsDDey9LdNm+FHLGHn8/GiRCaQvPz
X-Developer-Key: i=njha@janestreet.com; a=ed25519;
 pk=92gWYi0ImmcatlW+pFEFh9viqpRf/PE8phYeWuNeGaA=
X-Endpoint-Received: by B4 Relay for njha@janestreet.com/20250314 with
 auth_id=360
X-Original-From: Nikhil Jha <njha@janestreet.com>
Reply-To: njha@janestreet.com

From: Nikhil Jha <njha@janestreet.com>

RFC2203 requires that retransmitted messages use a new gss sequence
number, but the same XID. This means that if the server is just slow
(e.x. overloaded), the client might receive a response using an older
seqno than the one it has recorded.

Currently, Linux's client immediately retransmits in this case. However,
this leads to a lot of wasted retransmits until the server eventually
responds faster than the client can resend.

Client -> SEQ 1 -> Server
Client -> SEQ 2 -> Server
Client <- SEQ 1 <- Server (misses, expecting seqno = 2)
Client -> SEQ 3 -> Server (immediate retransmission on miss)
Client <- SEQ 2 <- Server (misses, expecting seqno = 3)
Client -> SEQ 4 -> Server (immediate retransmission on miss)
... and so on ...

This commit makes it so that we ignore messages with bad checksums
due to seqnum mismatch, and rely on the usual timeout behavior for
retransmission instead of doing so immediately.

Signed-off-by: Nikhil Jha <njha@janestreet.com>
---
 net/sunrpc/clnt.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
index 2fe88ea79a70c134e58abfb03fca230883eddf1f..98c0880ec18a8b80371e20f65e7a57a8d9244f7f 100644
--- a/net/sunrpc/clnt.c
+++ b/net/sunrpc/clnt.c
@@ -2760,8 +2760,13 @@ rpc_decode_header(struct rpc_task *task, struct xdr_stream *xdr)
 	case -EPROTONOSUPPORT:
 		goto out_err;
 	case -EACCES:
-		/* Re-encode with a fresh cred */
-		fallthrough;
+		/* possible RPCSEC_GSS out-of-sequence event (RFC2203),
+		 * reset recv state and keep waiting, don't retransmit
+		 */
+		task->tk_rqstp->rq_reply_bytes_recvd = 0;
+		task->tk_status = xprt_request_enqueue_receive(task);
+		task->tk_action = call_transmit_status;
+		return -EBADMSG;
 	default:
 		goto out_garbage;
 	}

-- 
2.43.5



