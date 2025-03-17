Return-Path: <linux-nfs+bounces-10642-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 18B8FA6600F
	for <lists+linux-nfs@lfdr.de>; Mon, 17 Mar 2025 22:04:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 596EF19A0FFC
	for <lists+linux-nfs@lfdr.de>; Mon, 17 Mar 2025 21:02:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58ACD206F2C;
	Mon, 17 Mar 2025 21:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mzh6aZRq"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D7B4206F23;
	Mon, 17 Mar 2025 21:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742245223; cv=none; b=EhpzXlfKR0ptggqGmbed/qKE2Cw2kjPibz68Dz1D5cDZDei5ccGnoAPcXXdX989/02ff3TKzTgCm+UrZgdfeO5Yx5gGlpJRXwsEv7PghQ/RrSOBF7mwm74hagr9mjmaTz+i5DGyjgowVPHVn6TKi3hiMNvNNmFE4V3jZxK6+BVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742245223; c=relaxed/simple;
	bh=jM6hQB3KxGdlYpqgDDu0LJlP7dZIsC6hRFDyQ4A1hPY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KLtXACSiooIdZxDabxaVQwOhEOkhkAn+tm3jZtSdDN77Fg8p7YqSbKigvXF162Y9bHSH+BvgGiy09Uum70NqK5ZWjfMmuqRQVVwtM53u3Gq2P9nRVBWRcoxHwtdAmNTV7SOQyA8+dHCIih4OXPZcWlURh9r3Vd9hWODCImTLHt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mzh6aZRq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D932C4CEF1;
	Mon, 17 Mar 2025 21:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742245223;
	bh=jM6hQB3KxGdlYpqgDDu0LJlP7dZIsC6hRFDyQ4A1hPY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Mzh6aZRqfG2krE4LFAsF5dbxEUJR/6aFy43gZb/TkEhAnrPhiE/1zyVDd//CMXpYo
	 TDj79lvKSYgNPMG+ntWnAajFOytb1DiQrLBmVMMQbjwClptCJ1wCerUMpuVAwlFfJd
	 FRduzxhz0ddp6nV6UGvf41pTXFNerhc+owBa2yWFnnpL3eJhfwu6+tzxtNYhdqeB3K
	 aQUXHEWFQkML+0ulD5USiomVOUlL+TZZExzyfFVKcEGgZb5Yz4FnBn5g7JJRnKo6Gl
	 8oeAlwjaLfE7b9wL3gMxJquV7R1JoV/QBzW7PgXD24frNOSZAU+DCHuug4R/ojrGiO
	 mqiMsF3BVDPlQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 17 Mar 2025 17:00:01 -0400
Subject: [PATCH RFC 9/9] sunrpc: don't upgrade passive net reference in
 xs_create_sock
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250317-rpc-shutdown-v1-9-85ba8e20b75d@kernel.org>
References: <20250317-rpc-shutdown-v1-0-85ba8e20b75d@kernel.org>
In-Reply-To: <20250317-rpc-shutdown-v1-0-85ba8e20b75d@kernel.org>
To: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
 Chuck Lever <chuck.lever@oracle.com>, Neil Brown <neilb@suse.de>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: Josef Bacik <josef@toxicpanda.com>, 
 Benjamin Coddington <bcodding@redhat.com>, linux-nfs@vger.kernel.org, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=836; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=jM6hQB3KxGdlYpqgDDu0LJlP7dZIsC6hRFDyQ4A1hPY=;
 b=kA0DAAgBAA5oQRlWghUByyZiAGfYjVWiRKkxD6qwL79Bm7MvXbKxaKqHN3zIajad3pvAqXM3c
 4kCMwQAAQgAHRYhBEvA17JEcbKhhOr10wAOaEEZVoIVBQJn2I1VAAoJEAAOaEEZVoIV3loQAJMI
 HnR/zomdrtqt3k0IG0M7q9Bqe8M8FtP8izUB5Ny0WlY84to4WT+HXgXxubH6hWDwv6swdi0MJQA
 ztwnokr7fU3GNLmWGFgv7xRqezpOyThr8FgAD1F4MOcsSlOhIZC/0V3SqwfeQkHJjidtw2gC5Ks
 ZzdynlUOq133ZKMOKi9P5Stq8T6wf5uaLIwYoutrhOWzGSHmes1wZOi58tJMYHKa9oBQVxsA0VH
 ng818IoePQgBlKHzDxwD+Zzp9TO/SWND26I2/+kJB8mCt6oLXNoKPRD/65OOfPEZRQb9486I7J+
 NBs/23felh7QEI85hAsSjM7C1lN4EUmTf91sRc9YaELlMa0dE/JNIolnox/6kco6FTeqLIGVkAU
 W7Qy2e8dE89db2fdqQRt48vMwqIcezz+fcsLC4Y/t0foS9HMNoi29HaLQMfGXdgfi8l0Ym1/xUT
 EOzW2WOc+m6791GGn+eDU8rIbXassJbZOYLpNJothbIQSZ+H1fEZoOeAMc3lNpaR/Qj/m3eNkY3
 Kk9S8fGwTzgTrfS00vaFBnoXyyAafdelCEtmKIWGTbJ1VZfANRLIFa7No00bIlQkH8ZTWXwqyC5
 mzn2923EPj+reJUqzhKS3pVeOIySpZtpyulq42I/v/GdyxLuuFMQhiz83/3n76GLvZgsmMXOlTj
 zJeXK
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

With the move to having sunrpc client xprts not hold active references
to the net namespace, there is no need to upgrade the socket's reference
in xs_create_sock. Just keep the passive reference instead.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 net/sunrpc/xprtsock.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/net/sunrpc/xprtsock.c b/net/sunrpc/xprtsock.c
index 83cc095846d356f24aed26e2f98525662a6cff1f..0c3d7552f772d6f8477a3aed8f0c513b62cdf589 100644
--- a/net/sunrpc/xprtsock.c
+++ b/net/sunrpc/xprtsock.c
@@ -1941,9 +1941,6 @@ static struct socket *xs_create_sock(struct rpc_xprt *xprt,
 		goto out;
 	}
 
-	if (protocol == IPPROTO_TCP)
-		sk_net_refcnt_upgrade(sock->sk);
-
 	filp = sock_alloc_file(sock, O_NONBLOCK, NULL);
 	if (IS_ERR(filp))
 		return ERR_CAST(filp);

-- 
2.48.1


