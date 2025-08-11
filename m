Return-Path: <linux-nfs+bounces-13554-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A412B20C3E
	for <lists+linux-nfs@lfdr.de>; Mon, 11 Aug 2025 16:41:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF2C3164D81
	for <lists+linux-nfs@lfdr.de>; Mon, 11 Aug 2025 14:37:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB2D125742F;
	Mon, 11 Aug 2025 14:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tN8yaXd4"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4ED223A99D;
	Mon, 11 Aug 2025 14:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754923037; cv=none; b=eBzQO/jm00CDciudOwgJbm+m4wl/s74P+15qTuE3F7a27sbVSsUXhXcWzH266YADBjlG0Dpjq/GiCU5k5qsfaYSErq5v8J9cTE9ZUpCyRbcFVeI+/LqIlUBtR+1kPA+Xp2GA1UKNlclXfoAOG8x71/1GlKiTivp4aKkfZWekejg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754923037; c=relaxed/simple;
	bh=euU+Kt4bplakvq2oxZdYYWfUkAHRZSGKRoB38CitZtk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cYNVhzSnDd8vpUOMJlssSTXCQoyhpbo9MbmT0SMnmadV1CYJf+aIw4tGId1wzri9GsFhBQQFg9um5qsrkkg+OPCiYtpz0FO1TFX4r3HF9BKrbF6LKHdzYdHSB+lKMxMxTPHyTLJiPyZTI3pO9OeRs23ALhIShGjaS2I8JdhvNeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tN8yaXd4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F71AC4CEF5;
	Mon, 11 Aug 2025 14:37:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754923037;
	bh=euU+Kt4bplakvq2oxZdYYWfUkAHRZSGKRoB38CitZtk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=tN8yaXd4+/k9LgBhrngyxYlSD3gXtjSPQwyRNEzm/Aq0cyMoU//iGuvmjahsj7DIg
	 kiNcwH0S+W+1QMlAOrUCiiHxyVXjv9CeC8fVy2+fbeDfbfWLKvFI+9kELTUKquLP+i
	 MggL0isZ1CWxCxufuOQrOTXOH84yKYoHJXqZRSxZntjLO75R9USKnys8iGAY1fZt6U
	 vPtuYmvNwZMcdKzGJ3/mpFvoBmxGNAnO1VY4ZuceS3CWo0hKRDZL8sL+exAsyWP2cI
	 DwIoYE+4p71dRnkoYXB5/dpVtzhQi8lnYrIqTEr8K/vEtvCXD09lHGUO5q4LkU1lk8
	 TmfWnAC6FatYA==
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 11 Aug 2025 10:37:07 -0400
Subject: [PATCH 1/2] sunrpc: fix pr_notice in svc_tcp_sendto() to show
 correct length
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250811-nfsd-testing-v1-1-f9a21bbf238b@kernel.org>
References: <20250811-nfsd-testing-v1-0-f9a21bbf238b@kernel.org>
In-Reply-To: <20250811-nfsd-testing-v1-0-f9a21bbf238b@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>, 
 Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1235; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=euU+Kt4bplakvq2oxZdYYWfUkAHRZSGKRoB38CitZtk=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBomgAbE1MLjXCsGiF2ZAi99KsdTLsfnAV/38DXq
 g1q5+5JIC2JAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaJoAGwAKCRAADmhBGVaC
 FUWLD/0eZNRXPzf+jxJFFVQv97cHC9TkDauxGOtcBxm8Kih/T0sXvChLqx/Pt7S96oUuV3Hngwp
 hVy0pHk4NGnPsgqRQ8AHYLOu56kM9i4rm95FL4rG6CYZotsuR7WZficx3sM1Qy9kdVJqNFn4vNo
 SYENlR4xQu+Cltlzpl5Etzkcfv5sidEYS1sgqJ6mveWUQR2Cx1V2ISVRs3Wp7XhCKxl5M165fLH
 OjD+l3YlFDFMacV0dIeej1s+Mlg5kd73rxgXmQ/POJcbbIFf0l1EMVlP6gZEzL7x962XlqQsedw
 5Y76j1pAjqDpbeKkSTlU5jstFon/MCP3I3yDG9/KlZvFCHF+wcv8Z//Mm6iE/+WSAAHDCeMOSGN
 PlodgwQm7BnMlTc5S3jvBmqfFjB9lnRPVB5UX+AdU7y+t3O0WwGR91bfy1objluHV1j56yGFG17
 FGhzKv5yu6aLYEKQO/lUkBcU/cezF6aU4MtvbX0WmHcY4m+STQW00pRQgjEnvCM0kQ+DYRHHHnF
 0R+Pq1pc4vrjnvXLFbQ4kk3xv7MW9YBVQVFgtb0s9o3wz2szKzs6ic8aLRUZRh52y4+wBfNTKAe
 9sr7RYCq6wnR6bSMAaAiojOfAuP9M04DPWA5JVzRy0kuc2N5NZsUXqqviuSDtc+8C66mIQAzD2s
 bRgtq19vAkjeBgA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

This pr_notice() is confusing since it only prints xdr->len, which
doesn't include the 4-byte record marker.  That can make it sometimes
look like the socket sent more than was requested if it's short by just
a few bytes.

Add sizeof(marker) to the size and fix the format accordingly.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 net/sunrpc/svcsock.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/sunrpc/svcsock.c b/net/sunrpc/svcsock.c
index 46c156b121db43c1bd1806a08a3a9bf08b332699..22f59289fdcf17137fcac59e13975281ecf3e380 100644
--- a/net/sunrpc/svcsock.c
+++ b/net/sunrpc/svcsock.c
@@ -1266,10 +1266,10 @@ static int svc_tcp_sendto(struct svc_rqst *rqstp)
 	mutex_unlock(&xprt->xpt_mutex);
 	return -ENOTCONN;
 out_close:
-	pr_notice("rpc-srv/tcp: %s: %s %d when sending %d bytes - shutting down socket\n",
+	pr_notice("rpc-srv/tcp: %s: %s %d when sending %zu bytes - shutting down socket\n",
 		  xprt->xpt_server->sv_name,
 		  (err < 0) ? "got error" : "sent",
-		  (err < 0) ? err : sent, xdr->len);
+		  (err < 0) ? err : sent, xdr->len + sizeof(marker));
 	svc_xprt_deferred_close(xprt);
 	mutex_unlock(&xprt->xpt_mutex);
 	return -EAGAIN;

-- 
2.50.1


