Return-Path: <linux-nfs+bounces-10691-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0462EA695C3
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Mar 2025 18:06:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F7021884F7B
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Mar 2025 17:04:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3A981F8750;
	Wed, 19 Mar 2025 17:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G1Hm0lqv"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 940881E8323;
	Wed, 19 Mar 2025 17:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742403795; cv=none; b=C6j+wAgUKAjWQIb/8Tj0y0XkOUWizGit2NknZSvzNbsBYwSSDvVu5P7rme69SXOeN11d6Okvi9NIN/OoEYywWmgeW2xKfWBnybQXxTK9Lda99lYZczE3BxTjCnF38V5e5qAYeg+Oibe69BICPbg9ebN3vLk0XyMYVp/qynxMOm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742403795; c=relaxed/simple;
	bh=aEenN2rtAVG/y027IH9IeDfb7ILU1h7EudrieTStR2Y=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=OyyroKmehIkr+UM1JzaMcTT4hlIvXERc2gUN1xSni6uvcQm/XC4eO2RwVzODcvmRjdVmgCNLjA77ryGvbMitDrZWE5RHO6liuSOzbcE0qfJaGzzuOlDDGOcQQCdBrmrw+1RLjDE8KSTu2FSQW+7VzC9xcO0uYI7Q+/CFM62AQrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G1Hm0lqv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id F0DA9C4CEE8;
	Wed, 19 Mar 2025 17:03:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742403795;
	bh=aEenN2rtAVG/y027IH9IeDfb7ILU1h7EudrieTStR2Y=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=G1Hm0lqvzcrldNm8t0q8Yyp1HHlcXN+LswnBSDG+goqXb3oDNX+2DSsueT6K1ebSd
	 0bqX4igggEjCsykDiLk+6IufR1JE7uhfHauet1xoRdvQKW88zY4zIlvJ23GbqYMZqT
	 qjpQGmYSzGajgpTgYv4he/dXb1RzlhssK7Z5yb3IEH90304sS/X5+2q1galfInLKxo
	 e4tzYU4/4EBYOsdVS1r9a7iZUhNmTtQXFOqBtNe4p+THxsXsLTeJOnzT6HZCN1tLb3
	 0+pI1+bBAUKxaPP0pt3Ro7U5C7V8Syuq82xzuqfmD7iK8RuQu29lc7WgExVvHQ8Ugb
	 jMUlewwp0FhrQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0FA7C35FFC;
	Wed, 19 Mar 2025 17:03:14 +0000 (UTC)
From: Nikhil Jha via B4 Relay <devnull+njha.janestreet.com@kernel.org>
Subject: [PATCH v2 0/2] fix gss seqno handling to be more rfc-compliant
Date: Wed, 19 Mar 2025 13:02:38 -0400
Message-Id: <20250319-rfc2203-seqnum-cache-v2-0-2c98b859f2dd@janestreet.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAK742mcC/x3MTQ5AMBBA4avIrE1SU/V3FbGQmjILRRsiEXfXW
 H6L9x6IHIQjdNkDgS+JsvkEyjOwy+hnRpmSgRQZpYsSg7NESmPkw58r2tEujIZ0005F6UxVQ0r
 3wE7uf9sP7/sBx9CHy2YAAAA=
X-Change-ID: 20250314-rfc2203-seqnum-cache-52389d14f567
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1742403794; l=2309;
 i=njha@janestreet.com; s=20250314; h=from:subject:message-id;
 bh=aEenN2rtAVG/y027IH9IeDfb7ILU1h7EudrieTStR2Y=;
 b=G5nQT809qbEmXwOvoaSrMtCSMogF7ODItEYkYescwgV3YjoixFzV6RzTnGWdsI8AjlXkLzyJq
 FZ0MZHZGAuwBJf4+nCLEaL8KvzVKIsmuwHkHlGD4X1DapwUl28dpjkT
X-Developer-Key: i=njha@janestreet.com; a=ed25519;
 pk=92gWYi0ImmcatlW+pFEFh9viqpRf/PE8phYeWuNeGaA=
X-Endpoint-Received: by B4 Relay for njha@janestreet.com/20250314 with
 auth_id=360
X-Original-From: Nikhil Jha <njha@janestreet.com>
Reply-To: njha@janestreet.com

When the client retransmits an operation (for example, because the
server is slow to respond), a new GSS sequence number is associated with
the XID. In the current kernel code the original sequence number is
discarded. Subsequently, if a response to the original request is
received there will be a GSS sequence number mismatch. A mismatch will
trigger another retransmit, possibly repeating the cycle, and after some
number of failed retries EACCES is returned.

RFC2203, section 5.3.3.1 suggests a possible solution... “cache the
RPCSEC_GSS sequence number of each request it sends” and "compute the
checksum of each sequence number in the cache to try to match the
checksum in the reply's verifier." This is what FreeBSD’s implementation
does (rpc_gss_validate in sys/rpc/rpcsec_gss/rpcsec_gss.c).

However, even with this cache, retransmits directly caused by a seqno
mismatch can still cause a bad message interleaving that results in this
bug. The RFC already suggests ignoring incorrect seqnos on the server
side, and this seems symmetric, so this patchset also applies that
behavior to the client.

These two patches are *not* dependent on each other. I tested them by
delaying packets with a Python script hooked up to NFQUEUE. If it would
be helpful I can send this script along as well.

Signed-off-by: Nikhil Jha <njha@janestreet.com>
---
Changes since v1:
 * Maintain the invariant that the first seqno is always first in
   rq_seqnos, so that it doesn't need to be stored twice.
 * Minor formatting, and resending with proper mailing-list headers so the
   patches are easier to work with.

---
Nikhil Jha (2):
      sunrpc: implement rfc2203 rpcsec_gss seqnum cache
      sunrpc: don't immediately retransmit on seqno miss

 include/linux/sunrpc/xprt.h    | 17 +++++++++++-
 include/trace/events/rpcgss.h  |  4 +--
 include/trace/events/sunrpc.h  |  2 +-
 net/sunrpc/auth_gss/auth_gss.c | 59 ++++++++++++++++++++++++++----------------
 net/sunrpc/clnt.c              |  9 +++++--
 net/sunrpc/xprt.c              |  3 ++-
 6 files changed, 64 insertions(+), 30 deletions(-)
---
base-commit: 7eb172143d5508b4da468ed59ee857c6e5e01da6
change-id: 20250314-rfc2203-seqnum-cache-52389d14f567

Best regards,
-- 
Nikhil Jha <njha@janestreet.com>



