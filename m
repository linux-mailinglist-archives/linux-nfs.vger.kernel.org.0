Return-Path: <linux-nfs+bounces-12165-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9998DAD05B8
	for <lists+linux-nfs@lfdr.de>; Fri,  6 Jun 2025 17:45:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6EF3C179CB9
	for <lists+linux-nfs@lfdr.de>; Fri,  6 Jun 2025 15:45:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42D6C28B510;
	Fri,  6 Jun 2025 15:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I4taCrDB"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1790428B50B;
	Fri,  6 Jun 2025 15:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749224593; cv=none; b=BP+mX6tYnfTd/tIMbSUjBFNhP2UPbGXsUdiYlQylnWVeFIuKHdagNzzQjKyszIyIizzHKp3KcV15QP78PKrZPSGdMRIWT+dKpwMdOJp2nlcKA85uwep6Bq2GQpklAhdlaVFh07AJNN8vTB+9GGn/JT4bK5OUvaxrhjTBRP4bxJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749224593; c=relaxed/simple;
	bh=qtMNLbxpDM+LQNDs+IKPuZ8PAVJ9xiMwRcT1YiHUtc8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QLJrDrZW0DkTypRuCy8x1motT5dIMyOlftUy1pr4qFRCFsgrxh1vnssXI9/q0hHU1RezrxgfDmLYbKan/j9MbkowZcq9F7ilW81Uhtowh9ctzWgnO5vP6a7ZxpkQN3FzBBGqn18YTVdbkFVE3VyKVaFZx8lhynhRH6pPuxAwJRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I4taCrDB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6F6CC4CEEB;
	Fri,  6 Jun 2025 15:43:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749224592;
	bh=qtMNLbxpDM+LQNDs+IKPuZ8PAVJ9xiMwRcT1YiHUtc8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=I4taCrDBz9IGv/Pqw2vLxV6S6z8tkl3/mw4D2ERjYT45BZQ4ppR95vdlGDLAxX4/5
	 NFjGL9/lLWeGTf0fpo0mu05eNUYws3REg71EtNputP8kuE5fgnQP0TRsgwhjwybqiT
	 yFDQjO4f0QqnLlPZmxbRqo+jt6340+HBwST/ZlnqZ1uJBwGaWcKNU0Zhs/WM+aq+gJ
	 WKuGyvlzWMyNNbLKMZ1Y7Al943dJFNiOolBvx3h8CpUQGni3Mr1fzxcnurX9HGdpYs
	 P6J9RiKgQfGXBDYOq2eJllfevCOnuHE1POz3cnIXO+dOvBffNQUpanv+ci+4MZXxtY
	 2cuCrIhfD4Y8Q==
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
Subject: [PATCH AUTOSEL 6.12 09/15] sunrpc: don't immediately retransmit on seqno miss
Date: Fri,  6 Jun 2025 11:42:52 -0400
Message-Id: <20250606154259.547394-9-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250606154259.547394-1-sashal@kernel.org>
References: <20250606154259.547394-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.32
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
index 17a4de75bfaf6..e492655cb2212 100644
--- a/net/sunrpc/clnt.c
+++ b/net/sunrpc/clnt.c
@@ -2749,8 +2749,13 @@ rpc_decode_header(struct rpc_task *task, struct xdr_stream *xdr)
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


