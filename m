Return-Path: <linux-nfs+bounces-15060-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01BAFBC6655
	for <lists+linux-nfs@lfdr.de>; Wed, 08 Oct 2025 21:00:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4121C3C39CC
	for <lists+linux-nfs@lfdr.de>; Wed,  8 Oct 2025 18:59:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEA452C0F96;
	Wed,  8 Oct 2025 18:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZiTf3N5b"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96A0B2BF007;
	Wed,  8 Oct 2025 18:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759949949; cv=none; b=LQyiW/8dtwTe63xbcCltblPtJoFvWmrW9mAtOH/bRFAIQS8Y2rif8wK+8m9LVc8TmmfVCAUfR0zySbg7plfudWR80ekI81C2qHUE4WwgDCUYYJbdeaqhzw1H/1qfKGuXxzWEaX1CTQrN4iR3xjDViww//yGbf3i92QlHKW5UR1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759949949; c=relaxed/simple;
	bh=YSyZBJECDSmrU4kIHok2IV023tjoiVhUqQtuyV5mAsY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=LGk9khDvhcwKNcD5nUj5KhMDVwmNf5Shp2yZJRO61obPxqmiQtVEbmsVDbmvYV5HjwSivxwe29j3xct/6WkYzMMf6xoGbaiSfV31YLVmSD/nJ5xBY2R+NPyIOIkxjywph7IFH02JcgV+HoN5cdPLha8b3o2ASR8dUPQA8YIKsKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZiTf3N5b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AD8FC4CEE7;
	Wed,  8 Oct 2025 18:59:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759949948;
	bh=YSyZBJECDSmrU4kIHok2IV023tjoiVhUqQtuyV5mAsY=;
	h=From:Subject:Date:To:Cc:From;
	b=ZiTf3N5bmDRQblnGI98Td+IDGhGYS28iTdW+07k8RdgdAwbvs1catpyng9lSiedGO
	 kUaunCWa2JOj8wT0EN/3in20/KXeZ537KLnJeNS+STWSvzABfrIzik22GZhI9kzyFS
	 uCd6HU3yDOvVAPFEdbDZE3Hv6LpSfHSOqInYG1LhixBXh9t1s+6bz//SrpBeP3Uw3e
	 znWhSXfNwsw4g0NQnxxT5K8SCM7CjYmI3yn4OaJt5/qYORsRmBUvlEgMmkJDzGO8Be
	 XBp/ZxloEQQeURChB5qf86kgn4CRrvpJQxA3vkzKfkgTPhkjzrC/zeuoHge4qekLi7
	 4fTIN6z+3V+aQ==
From: Jeff Layton <jlayton@kernel.org>
Subject: [PATCH 0/2] sunrpc: fix handling of rq_bvec array in svc_rqst
Date: Wed, 08 Oct 2025 14:58:51 -0400
Message-Id: <20251008-rq_bvec-v1-0-7f23d32d75e5@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGu05mgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1NDAwML3aLC+KSy1GTdJDOzxLQUg7SUpKQkJaDqgqLUtMwKsEnRsbW1AC2
 djwJZAAAA
X-Change-ID: 20251008-rq_bvec-b66afd0fdbbb
To: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>, 
 Anna Schumaker <anna@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 David Howells <dhowells@redhat.com>
Cc: linux-nfs@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=978; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=YSyZBJECDSmrU4kIHok2IV023tjoiVhUqQtuyV5mAsY=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBo5rR01tFFxc/ntjUL5ltP3NUhB3x2sJrDJstMP
 MC/0kGw+VOJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaOa0dAAKCRAADmhBGVaC
 FUXnEADGSA/HBvDdXPr07rXYcmcPBFpnhPnB16CLXzsGUrcKjWamHm48ZqU0AKCf7TD4974WZfc
 PEmdZ9o7P0W1zMfJSueENxhtLEqxdWtEMiIQgdtJ7E4TLdIB9LpMHalmZo3dCSVnhuuAWmKFKcY
 YVduNkrhQEDKur47t1u5pn3CWUFE+Dh9FzVJCtUBDg3d/hj6v9dgk17Uf76Vv6b/5YR4CN8BL8U
 dzO35wxsfjVx7EzSTXf+mcAWlugsRyzWd+ik/3WBd8ryZVabj01NaAwVaWFn5RuPz7txHe04PQn
 mU7PtBVlq0JgBmTVdTw7AWhbY0b9o8fBUtsUlqNkKHuCDM0Cwi6InLpWHxELyUUkZEv/2yiCSxi
 Z9EjyVlfQGCXKNVwMZMQy3Ldyvh3f73JAC8NnNpKftDzwVk25rnxMSh8LGrZ/F7W34kykFPfHoE
 KaWDiUd+pcx6igBLHApJlk/qspYwEzIBxJRuTuy2vDKe25VoZZMBEI5s6qA89oXsqO4bPrJx7Bt
 I7gr7veITqt5Jdj39d5O0QXk76a8SDWOJRB29r3xveP3jMzB30slBlBoPGFRLlAZ/RsOpfFiikD
 yMRN/UGblPzNr3rq7ndZ7plXg6GacXMtUzAw4N6SIaR3OJX0BYWYxFFBp15LRnw5qhIOpDh2yBj
 9KcLQSxexT6vQ1g==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

I've seen this message pop intermittently on some knfsd servers:

    rpc-srv/tcp: nfsd: sent 1045870 when sending 1045868 bytes - shutting down socket

Unfortunately, I've not been able to reproduce this on my own, but I've
noticed a bug that could cause this.

The first patch in this series fixes a bug in rq_bvec handling I noticed
by inspection. The second patch adds a slot to rq_bvec to account for
the slot used for the TCP record marker.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
Jeff Layton (2):
      sunrpc: account for TCP record marker in rq_bvec array when sending
      sunrpc: add a slot to rqstp->rq_bvec for TCP record marker

 fs/nfsd/vfs.c        | 6 +++---
 net/sunrpc/svc.c     | 3 ++-
 net/sunrpc/svcsock.c | 2 +-
 3 files changed, 6 insertions(+), 5 deletions(-)
---
base-commit: 177818f176ef904fb18d237d1dbba00c2643aaf2
change-id: 20251008-rq_bvec-b66afd0fdbbb

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>


