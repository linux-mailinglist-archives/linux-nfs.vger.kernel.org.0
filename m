Return-Path: <linux-nfs+bounces-13840-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 568C1B300DB
	for <lists+linux-nfs@lfdr.de>; Thu, 21 Aug 2025 19:19:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D6FF3AA638
	for <lists+linux-nfs@lfdr.de>; Thu, 21 Aug 2025 17:17:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB4BC2E3718;
	Thu, 21 Aug 2025 17:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b/UP3wml"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 802482D0638;
	Thu, 21 Aug 2025 17:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755796630; cv=none; b=FT0H8F9yRmlvYk6QetnVIXgng6rWeOZRV5VozRC+vQYxI6kFA8MLV5YxCeyuNh7C+4EWg090HkQOvQQhd2yuL3SMOt+buPP3pnk86xJD5MCPbw0+SNG7Y0wGykpi2jk5zgezzw1FnMkQ0KdmoodMIpmKr2+qO5GE61B8lhFA1tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755796630; c=relaxed/simple;
	bh=WGhiuC8Crc/UzLl1IpIQpx1PRP3gGMcaGIqU0j6+iqo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=n6+eP026O4s2OZiCa8+xg3Bbds9yGHCfCbvZr1RgYzcz4qbJRVYQ9/wyj5fQVY9xFcOPp9kSu0KF+H9DHpRHTKWG7Ns9zHz1iqRm7KX4SpyQNojnUr5BrCuYe0/BDUVSikTwcXCkD7qBf7yyhRd6XU4qj7NAZHk5XPDWwLejDnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b/UP3wml; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8122BC4CEEB;
	Thu, 21 Aug 2025 17:17:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755796629;
	bh=WGhiuC8Crc/UzLl1IpIQpx1PRP3gGMcaGIqU0j6+iqo=;
	h=From:Subject:Date:To:Cc:From;
	b=b/UP3wmlTwyGmPjgtngrumnazxKZvzFLjsLbn/MbGdWAxTSvzH6ak1GwheXRVmJdF
	 ywFd6y8s5HVbqhCvWM7ragFJAzX1X36ZiXQE3NLId1lbXUeILHvoaq6ZLyCx2MIUBV
	 CPukduAbIsYva13EgqcW/cZc9xFv4FHhssQGCGZMFf9G8U5SONK6FlEWc2WC/8WtY8
	 V/VscZ3eAvmCTtMjDFO3lu9QKfrKaonwQWhmJFBnmjwMMiRO4TpMfMSqJH2QJVhulo
	 PWFLGPzwHwzOCEV+Q3jHmlQ8VkPM8aTeIzhnGpaufuxhimvztGOTKcvrkoCMdNmBcF
	 oKQUIzdk6KWSA==
From: Jeff Layton <jlayton@kernel.org>
Subject: [PATCH 0/2] sunrpc: allow dprintk() to go to the trace buffer
 instead of console
Date: Thu, 21 Aug 2025 13:16:52 -0400
Message-Id: <20250821-nfs-testing-v1-0-f06099963eda@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIVUp2gC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDCyND3by0Yt2S1OKSzLx0XaMkI0MDcwNLU6MUEyWgjoKi1LTMCrBp0bG
 1tQAk/nRiXQAAAA==
X-Change-ID: 20250821-nfs-testing-2b21070952d4
To: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
 Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1032; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=WGhiuC8Crc/UzLl1IpIQpx1PRP3gGMcaGIqU0j6+iqo=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBop1STSucDQuLHQTR3p5j8FuR0uQaaLs/OYO0bI
 eNVnks+SNmJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaKdUkwAKCRAADmhBGVaC
 FQJ8D/9c68VsTp1l5hsGrGIp4c3GSzvV4OeAdWL7EjtMKPgOAGYSsCaR81G+4TkP7oVryMYv9Q7
 lG25blljcj2p5vojF6hiMA6xjgyPzLBzs6nXPDC0ninhqKN09h7zerphnH7DGLPRzMqduSRUxNy
 8KbMoACnD6zfFT8xlPyXSj47qtRbyNHXc12L2kzgAE+I6w85M1EKHA78/y30+YQZ30OwB4xj+9f
 sbQDGgCUvx9eM8J9mrgwGJ23rq/Vygpxg1qR2vxKdLGY4L5iFLTqO0CA/XMizAI6LA5NeCDXhGm
 szR5h0aAmSYLwmkC3u+kKf8+5B12elWk/gqU8bfLATxLguKqabeKK349QOhWH55r1D/VE3DRMky
 +FVPi4l932fIpJEJVthLcy+7JDWOhtDqFaXcbEpSFxCoQkU29ZzM10y8twMyTrS0KXdZQe8C7GI
 71X+KH/EJ16dvHrN6ailGwOcSJgTTf1jNhk6ko0oKWFFlSohoMsTNzYRIasGN1s0NFVnA6Jfrhq
 rAfjefvLtTAljwjBp64tqp66CY1IJNFH1jYD3YQ/BeEXAO1xgLorvdCG9efSIKC8aJaH/wOLXp2
 vweepTMTnuRAyWw79uNstry4I92k6elqoGmC8I8bTNgcmhP1dqT1ISmGNNe6eGey6x0AqyOoU0y
 LcXUYMpRxFZUWgQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

While we have added a lot of static tracepoints in the last few years,
we still have a load of dprintks in place at all levels of the
NFS/NLM/RPC stack. At the same time, they're pretty useless under any
significant load.

This adds a new Kconfig switch to allow those to go to the trace buffer
instead. In addition to being more efficient, that allows us to enable
static tracepoints alongside dprintk() and get a unified log.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
Jeff Layton (2):
      sunrpc: remove dfprintk_cont() and dfprintk_rcu_cont()
      sunrpc: add a Kconfig option to redirect dfprintk() output to trace buffer

 fs/nfs/write.c               |  6 +++---
 include/linux/sunrpc/debug.h | 30 ++++++++----------------------
 net/sunrpc/Kconfig           | 14 ++++++++++++++
 3 files changed, 25 insertions(+), 25 deletions(-)
---
base-commit: 80a1bea0cd81de70c56b37a8292c23d57419776f
change-id: 20250821-nfs-testing-2b21070952d4

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>


