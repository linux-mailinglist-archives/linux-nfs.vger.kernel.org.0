Return-Path: <linux-nfs+bounces-12169-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CE6CAD05C9
	for <lists+linux-nfs@lfdr.de>; Fri,  6 Jun 2025 17:46:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B46193B2F7E
	for <lists+linux-nfs@lfdr.de>; Fri,  6 Jun 2025 15:46:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0BE728BAB3;
	Fri,  6 Jun 2025 15:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cr+T8SC0"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85049EEB5;
	Fri,  6 Jun 2025 15:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749224619; cv=none; b=VcxxCNCXT30iQ350JI0nUp2n5R4k1gKtry7LC+ft5llAWGOAOdwjNOTdGQRn/8wltEcUApQvNZZ67ixH2G/b+890GdA3N/NYpZveMNDzOya2ntn+RKwWjLG0fBKnMbTOACD4HYn+IK4T/jxETQDrrZLpGIkM9yXWi1Arrapa0kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749224619; c=relaxed/simple;
	bh=D4mv15+bKBKTXf2d9mpoxjl7U8HbYfnSO+CrHkGP0yU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Yiv71qrs2UqQIbYMcFNnLE4JxvnT6b8af7NBKq8EOwnRIFiUsKTmHBYN1YcG3iVreeBMInaI6cZOss37ScG3kLlQvky7JgSJmQcblsyXAE5TG8bk+4FazILe5qV/xBnnN1TsCOf/ceZdBLNQm/px7urcBeyTX0PmR7d9LxB7254=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cr+T8SC0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EDCAC4CEED;
	Fri,  6 Jun 2025 15:43:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749224619;
	bh=D4mv15+bKBKTXf2d9mpoxjl7U8HbYfnSO+CrHkGP0yU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Cr+T8SC0qQZuKDRGCf1sk6IoY02dV+fJbSGbzAiNT9KQ8+QMOUNlEXwsvpKL/ieRH
	 QNgnOAEqEyIhNEvE+Sw4caYWwzeRI717SFjfPvJwI3hlRXMuD9e7LDH+Ks/5KeSDgN
	 7NWI2shDRYs1OVLCxSthgJIMw7Wgbg7XgUqTS8G6J8TyyhW3tR19aX8BUSvN8m0+vC
	 mX43R/vnIEMBmJnxdSF0fEQFgx4jrYBJ8QqeHiF8ELJk8Y06MAKwjWzgvJhpiLnADv
	 tn3ugCzpEO+5Vc5+NgfRXO7Chb0iE2TcKtcJEyVNKF7okaWLB5AmKYCKIs7si22aLq
	 n64ZV3tLhC7bQ==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Nikhil Jha <njha@janestreet.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Anna Schumaker <anna.schumaker@oracle.com>,
	Sasha Levin <sashal@kernel.org>,
	trondmy@kernel.org,
	anna@kernel.org,
	jlayton@kernel.org,
	linux-nfs@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 08/13] sunrpc: don't immediately retransmit on seqno miss
Date: Fri,  6 Jun 2025 11:43:21 -0400
Message-Id: <20250606154327.547792-8-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250606154327.547792-1-sashal@kernel.org>
References: <20250606154327.547792-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.93
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Nikhil Jha <njha@janestreet.com>

[ Upstream commit fadc0f3bb2de8c570ced6d9c1f97222213d93140 ]

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
Acked-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Anna Schumaker <anna.schumaker@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

Based on my analysis of the commit and the similar backported commits as
reference, here is my assessment:

**YES**

This commit should be backported to stable kernel trees. Here's my
detailed analysis:

## Key Analysis Points:

### 1. **Bug Fix Nature**:
This commit addresses a clear performance bug in SUNRPC's RPCSEC_GSS
sequence number handling. The current code immediately retransmits when
it receives a response with an older sequence number than expected,
leading to excessive and wasteful retransmissions when the server is
simply slow.

### 2. **Alignment with RFC2203**:
The commit correctly implements RFC2203 requirements, which state that
retransmitted messages should use new GSS sequence numbers but keep the
same XID. The current behavior creates a retransmission storm that
violates the spirit of this requirement.

### 3. **Code Changes Analysis**:
The modification in `rpc_decode_header()` at the `out_verifier` label is
minimal and targeted:

**Before** (lines 2773-2776):
```c
case -EACCES:
    /* Re-encode with a fresh cred */
    fallthrough;
default:
    goto out_garbage;
```

**After**:
```c
case -EACCES:
    /* possible RPCSEC_GSS out-of-sequence event (RFC2203),
     - reset recv state and keep waiting, don't retransmit
     */
    task->tk_rqstp->rq_reply_bytes_recvd = 0;
    task->tk_status = xprt_request_enqueue_receive(task);
    task->tk_action = call_transmit_status;
    return -EBADMSG;
default:
    goto out_garbage;
```

### 4. **Risk Assessment - LOW**:
- **Scope**: Changes are confined to a specific error handling path in
  SUNRPC client code
- **Behavioral change**: Instead of immediate retransmission, it now
  waits for normal timeout-based retransmission
- **Fallback**: The normal timeout mechanism still provides
  retransmission if needed
- **Error handling**: Uses existing infrastructure
  (`xprt_request_enqueue_receive`, `call_transmit_status`)

### 5. **Comparison with Similar Backported Commits**:
This commit shares characteristics with successful backports:
- **Similar Commit #1**: Also fixed SUNRPC verifier handling by changing
  `goto out_err` to `goto out_garbage`
- **Similar Commit #2**: Fixed incomplete RPC message handling with
  proper state management
- **Similar Commit #5**: Fixed RPCSEC_GSS sequence number limit handling

All these were backported because they fixed protocol compliance issues
with minimal risk.

### 6. **User Impact**:
- **Performance improvement**: Significantly reduces unnecessary
  retransmissions under server load
- **Network efficiency**: Reduces wasted bandwidth and server load
- **No breaking changes**: Maintains compatibility while improving
  behavior

### 7. **Stability Criteria Compliance**:
✅ **Important bugfix**: Fixes performance degradation and protocol
compliance
✅ **Minimal risk**: Small, localized change to error handling path
✅ **No new features**: Pure bugfix, no architectural changes
✅ **Subsystem-contained**: Changes only affect SUNRPC client verifier
handling
✅ **Clear benefit**: Reduces retransmission storms in production
environments

The commit follows the stable tree rules perfectly: it's a targeted fix
for a real-world performance problem with minimal risk of regression,
affecting only the specific error case of RPCSEC_GSS sequence number
mismatches.

 net/sunrpc/clnt.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
index 4ffb2bcaf3648..63756607f6327 100644
--- a/net/sunrpc/clnt.c
+++ b/net/sunrpc/clnt.c
@@ -2733,8 +2733,13 @@ rpc_decode_header(struct rpc_task *task, struct xdr_stream *xdr)
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
2.39.5


