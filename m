Return-Path: <linux-nfs+bounces-10549-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 52D52A59942
	for <lists+linux-nfs@lfdr.de>; Mon, 10 Mar 2025 16:12:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E28C67A6C6F
	for <lists+linux-nfs@lfdr.de>; Mon, 10 Mar 2025 15:11:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E507822B5AB;
	Mon, 10 Mar 2025 15:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=janestreet.com header.i=@janestreet.com header.b="ETqv2oof"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mxout5.mail.janestreet.com (mxout5.mail.janestreet.com [64.215.233.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8175D22A4EF
	for <linux-nfs@vger.kernel.org>; Mon, 10 Mar 2025 15:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.215.233.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741619522; cv=none; b=A4ygXI9AeLFkay2CIkyrtRtPRqu1yrreqlCQYsVnlenf3TGW5b13c2tCT8pjJIRg3/OvVnazuwXTKBGmLXfI9d0OsxO0GPdnDtHu9VLWxnfzgcLcmb4agZTUh4EA+YHR/TM8TTaukuq8yL6SyFyaFEr7xfW7ztJ3CRwXBKOlFJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741619522; c=relaxed/simple;
	bh=aC1WZpKLRFcw6C3Yoq4mlJ6IVSw/ZFetb0HMgzKuXq4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=oW4ypRV/gHJlEyyJhhm+nIZ3T8uB3/vssc+w6CWJsjK6elIZFA8A+XPF4SQCzXLFYFmMEZG86yvELUMCz7qIcoHG/edr5Wb8I26F+WOkS24ZoDzvkdJprcbMQRCA7j1IBTdvp3d7Sn2GkVTlNFYAeoQ+0MFApABipbWonq+GhyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=janestreet.com; spf=pass smtp.mailfrom=janestreet.com; dkim=pass (2048-bit key) header.d=janestreet.com header.i=@janestreet.com header.b=ETqv2oof; arc=none smtp.client-ip=64.215.233.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=janestreet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=janestreet.com
Date: Mon, 10 Mar 2025 11:12:00 -0400
From: Nikhil Jha <njha@janestreet.com>
To: njha@janestreet.com
Cc: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>,
 	Chuck Lever <chuck.lever@oracle.com>,
 	Jeff Layton <jlayton@kernel.org>, Neil Brown <neilb@suse.de>,
 	Olga Kornievskaia <okorniev@redhat.com>,
 	Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
 	linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] sunrpc: don't immediately retransmit on seqno miss
Message-ID: <20250310A151200f3e81240.njha@janestreet.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=janestreet.com;
  s=waixah; t=1741619520;
  bh=Fmvdhh3fJaX+urLlyidyKgMDOPuqM+7a5igeSlveYkM=;
  h=Date:From:To:Cc:Subject;
  b=ETqv2oofRU0FTvjN51JIH1RW3lL6WFxw542r3ifzN94cp+cP409xhaXoghkOyMtEP
  Y+JBQutf6eNVz4kjWbhWAiKYFtbpi9eG7WYgSZyHvfaONzD8zwm6zfNV0fmTCPsOrZ
  HFZrPnbe1k9EF+k/ioAshPLiDahZQT6u1bAwnu3RiJIhpOmrx0Z4XvkCnYpMrYKsiZ
  oCNIhCCquWLk0b/27xCTgSKUlVqFty08m2N8DG011FqdDvh9VP6mJU8YIGa5rrTO5Y
  Q8H9Ke5g30fCEstYTOh6Sl/bup+4Otawp867fJny3V07fXP7mdTeTv9+Pkwvll1PGB
  dli/Oddswbuvg==

RFC2203 requires that retransmitted messages use a new gss sequence
number, but the same XID. This means that if the server is just slow
(e.x. overloaded), the client might receive a response using an older
seqno than the one it has recorded.

Currently, Linux's client immediately retransmits in this case. However,
this could lead to a lot of wasted retransmits until the server
eventually responds faster than the client.

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
index 2fe88ea79a70..74bbd050e6d9 100644
--- a/net/sunrpc/clnt.c
+++ b/net/sunrpc/clnt.c
@@ -2760,8 +2760,13 @@ rpc_decode_header(struct rpc_task *task, struct xdr_stream *xdr)
 	case -EPROTONOSUPPORT:
 		goto out_err;
 	case -EACCES:
-		/* Re-encode with a fresh cred */
-		fallthrough;
+		/* probable RPCSEC_GSS out-of-sequence event (RFC2203),
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
2.39.3


