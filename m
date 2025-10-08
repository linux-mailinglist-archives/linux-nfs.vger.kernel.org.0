Return-Path: <linux-nfs+bounces-15071-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8E67BC6915
	for <lists+linux-nfs@lfdr.de>; Wed, 08 Oct 2025 22:23:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9403C40804F
	for <lists+linux-nfs@lfdr.de>; Wed,  8 Oct 2025 20:23:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1939428C866;
	Wed,  8 Oct 2025 20:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EcCGtqnr"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFD0B27AC45;
	Wed,  8 Oct 2025 20:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759955015; cv=none; b=IcMWaN0mmIVI53ymBxDE9cb6yccEkeYZD0ybgpdGrc9tjggYCyILxlePs2ISTYPiWi/FnAv3LXOBmHNvUGyof0/tjbAUAlMsuWutCnwv/NeoZ64kPyL9LyrR0jlbPtJUw2lbOnOhBHmNlIW+X5T65G/OfHZ3MKFKOZyAP0WzVio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759955015; c=relaxed/simple;
	bh=fbzRb9SPBILmdn78G4DhEwTZPvO9DQAxsQnJDWgmBwk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Mp8V7kl4dmTJLhlh8OJ++xtjkRSCbjdlKCPJE0RAAZ99a4wMGzg3eGa/b8F9WdbhJvk1k3uiWsmT4ZYBAWKu75QQTBiHtDXcxd0e5OlfBt7mVUGc6nYry6bAWbi3Kjc2Z/ekFuveK423dQcM19RVk6dkhDUAix06hqFdl+tTe3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EcCGtqnr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 888B3C4CEE7;
	Wed,  8 Oct 2025 20:23:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759955014;
	bh=fbzRb9SPBILmdn78G4DhEwTZPvO9DQAxsQnJDWgmBwk=;
	h=From:Subject:Date:To:Cc:From;
	b=EcCGtqnrbCHXFJ2M86kLRcywMcCjW6YsOmT4O5tJ1PlKGYbyJ0pR/ZLmdjdVfuKlO
	 PuSAvkLDBYxUIjSD01fajv9kxbDuXmqXfxFjDXzW7HFr8iSzQyAoLwYml+tar0Wcj7
	 2bm10eyYYgOfetwbW2L9xfrO6MAL3R2eDrlGfyFdeJiF/1GOXwVeK2fftQxEsS0ukf
	 1AYi5s+4FCsiLtvpqYO+9mo6vAMZF0eIwe9Qxx02DPMGoYKa65YeDlnduWPwIwHEm4
	 IpSNo7fC0eRkChx0mELhiKaqKZAGQva9mKMCEVMf/sho3Nv2CbzZvrULM3koshJpeV
	 //Chh07Kvifdw==
From: Jeff Layton <jlayton@kernel.org>
Subject: [PATCH v2 0/2] sunrpc: fix handling of rq_bvec array in svc_rqst
Date: Wed, 08 Oct 2025 16:23:27 -0400
Message-Id: <20251008-rq_bvec-v2-0-823c0a85a27c@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAD/I5mgC/2XMQQrCMBCF4auUWRtJUtKKK+8hRZpm0g5KUicSl
 JK7G7t1+T8e3wYJmTDBudmAMVOiGGroQwPTMoYZBbnaoKU2SsqT4OfNZpyE7brRO+mdtRbqe2X
 09N6l61B7ofSK/NnhrH7rv5GVkKL3unWtdr1Bc7kjB3wcI88wlFK+A0Sm1p8AAAA=
X-Change-ID: 20251008-rq_bvec-b66afd0fdbbb
To: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>, 
 Anna Schumaker <anna@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 David Howells <dhowells@redhat.com>
Cc: Brandon Adams <brandona@meta.com>, linux-nfs@vger.kernel.org, 
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1129; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=fbzRb9SPBILmdn78G4DhEwTZPvO9DQAxsQnJDWgmBwk=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBo5shDltqAB/k9572Hwata/lcqPAcC8iRySb2B+
 3ncrVTSiDSJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaObIQwAKCRAADmhBGVaC
 FaYEEADJXxENs21dRYQgc4fIEbiyvkTep5NvksJozKxVfHz2uS75nCZ3ge3KY/ZwoHsT6pTrJGs
 xeikziE8ST0GhC0/ZYVL1eloasO9xx/kFjgmaC7gh2dwq3TfWF+WV/ts6r+ChValKyh+SalYMzj
 VKca+JaRlSR7AYU5XWuINA2oOo33CYH0oqoSlYuF6s8ofjXAgI5Za0Kl3lzcquiyHxR4uNv9m0q
 Sox30gfcORbaTQufRiJvOSlkmD4IjAGeT3NSngGWYUI0t9JsACtmsPOElUa0OLRCcED3hz7FlTW
 DKm5ZvdxgiEBvIV14eWDEWApeyZ/MjN0qssnHPKsqfzmMnxd9CJCSX7d6youMIx6VagY0aX2JbF
 9M35oWTZf1rTj2jtXrgUaMU122zYkF2vKhgMhhO11oF+F9dh9lM1aFILaFxMSgMGF5Wsaj1EQRY
 KBUIgiu71tqtuLrg0Qp7SDZOa7/6moLP5I2ookTnDU+PWaHMSuLRIf2jlB8WC4Bhy43Q8bYfd4F
 CxsJeg9m7wj2Dry58Q7zRtUNuU6ZqAuWGY8o3gZiMS5b5NJGVAQI2v9xDWCyaPgRUi4/5QlWu+B
 K8/UStPtxAT4xzPFDIZkBh4QXQhzmKcdPOeHOqdAmgzlKLHHUzB24KY2HybTHJfIBw1CJ1tCpoo
 Nnm2obybVI+zKHw==
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
Changes in v2:
- Better changelog message for patch #2
- Link to v1: https://lore.kernel.org/r/20251008-rq_bvec-v1-0-7f23d32d75e5@kernel.org

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


