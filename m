Return-Path: <linux-nfs+bounces-9957-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 62AA4A2D01E
	for <lists+linux-nfs@lfdr.de>; Fri,  7 Feb 2025 22:55:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4BE577A2A5E
	for <lists+linux-nfs@lfdr.de>; Fri,  7 Feb 2025 21:54:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 574071CAA8A;
	Fri,  7 Feb 2025 21:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KnVnhOBh"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EC1C1DE2CC;
	Fri,  7 Feb 2025 21:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738965256; cv=none; b=r9unPYrkMNqNZqDMiANR1Ly6kq7akDRGBC7plky6qulyktnTrDy1wI49/n/mpmtVZ9/xwW8g1Z5lenaQAAcsGq5Dzb9tMttpQfn9ekfjiYy+wWaNDnzhyugcWtYA1vc8BYyolyQ9fuog1w9xDR4o9kqmPZ4p4sdSEWcE9sK4Dzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738965256; c=relaxed/simple;
	bh=oPws4x3e9piLVyLvn8I4bBJFo9KyftEBuoX9giMl7eg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ACi7WPx7b0Nfe4UoYNfUIA0aWzGTvZuhsO+itb4wuxEs0EMl5fv4QyirFdJYwp3Osj/K0opvHpuFva+D5VwbfIOaiJCZxRmc2bXEKq1JSTU00h1KuzobgenpNRmi9hHYVPY+iqerY3BrsZdcYix3RcEoFIFUELarwk+/m+appug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KnVnhOBh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48D45C4CEE7;
	Fri,  7 Feb 2025 21:54:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738965256;
	bh=oPws4x3e9piLVyLvn8I4bBJFo9KyftEBuoX9giMl7eg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=KnVnhOBhlpsBUbEXx1PxgU8XbOC9lt1O/obDk7iCqxLgQnIT7mB1H4Wt8tD+uZBD7
	 0AzPT/cgkN1m6RtQzF1IIzqBl4FKv6utjX2yNYUjnRTGEoIDN++AFuTeoKbLDGKq6t
	 njDW+j5mtQ1JPSNQ+sdqndhRWFhcM4mRwwqEXbrzotFaG14vyzwgWbLTtnsvFwFbbr
	 zYirx8JQ+IXEvVy9+WrRVtpPPi8ooUKfjwjMyYBAerBBfB6P+L4OEEl3S4PmyjKBov
	 0jZg/MsQgGwVqXwl7ogrfr9B2oT4JU+yB2xzExjtid+c/sG7mBJOAdfZp6yiFndr5w
	 rur0VXuPcwgPQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Fri, 07 Feb 2025 16:53:53 -0500
Subject: [PATCH v5 6/7] nfsd: handle CB_SEQUENCE NFS4ERR_SEQ_MISORDERED
 error better
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250207-nfsd-6-14-v5-6-f3b54fb60dc0@kernel.org>
References: <20250207-nfsd-6-14-v5-0-f3b54fb60dc0@kernel.org>
In-Reply-To: <20250207-nfsd-6-14-v5-0-f3b54fb60dc0@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, Neil Brown <neilb@suse.de>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, "J. Bruce Fields" <bfields@fieldses.org>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1495; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=oPws4x3e9piLVyLvn8I4bBJFo9KyftEBuoX9giMl7eg=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBnpoEAM6gcDh42VCq9WBeoZ3WOXXJr5RN0tMove
 5VQ/ObI2VuJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZ6aBAAAKCRAADmhBGVaC
 Fb2eD/9FT2EJBK5nqGrUEqiPYmYUNQXMSjKpKwKTNbERWHnpDXbpZ3p+FJS4kgKQJWg7mewg8UJ
 VpKeRkqnfTz7c6ftwgK14OhSbrd6xmeSeMByodd8tX1ivP3W7IfwDS4RCr876+dCaFJaE4t/Wsu
 YgsXz+defvJUIxq5uVmW0jxLbK4UZd0Owqx7+O0lee6DqzSCBHICdq+dYQ+juTB41/Q6Qvb/jle
 jJTbOX8DX5XexEeHgTIKD9GDbWq/de30lGNfoGDbgg52wU++E9Fw07heZUVj2oMRo0KNEfUuG3E
 glVCOwVXy7PPaatmFghY7Zts//SwTIPaDitk6XGT+03prTGgTRWPRu67NRpQJMmzpjIRT6Q3PQB
 pUGLBReQ0fDsB0xEBKDw+rSr80ETIcF4+Vtoq6P8jT6Wzn62Q1xj7HiF+qoKLTEeTRqAq/fFfpY
 7CeLZAO7rwwGc9i9/1F0VJzKq0+MmHqFWaaZvWYFioVcrVj/GJc6gH6E/R31FqrHRQBYBAviMVk
 qqXrij2lxJr6p5JhwlGwkYfRTFpDBToWV3PgMhOFZ1ihpkBZV8vlNyhaQHdZLRTeQBd++a053Bl
 nDgTYWKOm6upmx3WLEhNpDIFx2boYV/jXLtxD57+Vi9WvqVsFq0o+pweKcJnj3Dpz3fvopwHwWY
 JkAjD5Sw0pu38gw==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

For NFS4ERR_SEQ_MISORDERED, do one attempt with a seqid of 1, and then
fall back to treating it like a BADSLOT if that fails.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfs4callback.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
index 10067a34db3afff8d4e4383854ab9abd9767c2d6..d6e3e8bb2efabadda9f922318880e12e1cb2c23f 100644
--- a/fs/nfsd/nfs4callback.c
+++ b/fs/nfsd/nfs4callback.c
@@ -1393,6 +1393,16 @@ static bool nfsd4_cb_sequence_done(struct rpc_task *task, struct nfsd4_callback
 			goto requeue;
 		rpc_delay(task, 2 * HZ);
 		return false;
+	case -NFS4ERR_SEQ_MISORDERED:
+		/*
+		 * Reattempt once with seq_nr 1. If that fails, treat this
+		 * like BADSLOT.
+		 */
+		if (session->se_cb_seq_nr[cb->cb_held_slot] != 1) {
+			session->se_cb_seq_nr[cb->cb_held_slot] = 1;
+			goto retry_nowait;
+		}
+		fallthrough;
 	case -NFS4ERR_BADSLOT:
 		/*
 		 * BADSLOT means that the client and server are out of sync
@@ -1403,12 +1413,6 @@ static bool nfsd4_cb_sequence_done(struct rpc_task *task, struct nfsd4_callback
 		nfsd4_mark_cb_fault(cb->cb_clp);
 		cb->cb_held_slot = -1;
 		goto retry_nowait;
-	case -NFS4ERR_SEQ_MISORDERED:
-		if (session->se_cb_seq_nr[cb->cb_held_slot] != 1) {
-			session->se_cb_seq_nr[cb->cb_held_slot] = 1;
-			goto retry_nowait;
-		}
-		break;
 	default:
 		nfsd4_mark_cb_fault(cb->cb_clp);
 	}

-- 
2.48.1


