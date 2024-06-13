Return-Path: <linux-nfs+bounces-3753-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A1074906F65
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Jun 2024 14:19:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F52A1F21BFD
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Jun 2024 12:19:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53F33145FFD;
	Thu, 13 Jun 2024 12:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lq5oDNTn"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 208D5145FF6;
	Thu, 13 Jun 2024 12:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718281016; cv=none; b=EUygJpU0bk86WvF6m98wzE9qlZMsFDKlDYzsddOpYnjfNxE2P6G8VOARh/0LgiZ0uEP7mjP5ql91rzBP1N1kc5kwVV2zz7qJXonmv0rSqbSCWKvzO1Oqi93y91WEisOZnZCeBiTO4NRmRIqJ/qTJnmq/v4cilC+br1wA0OD6S7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718281016; c=relaxed/simple;
	bh=tekr1M6Lsc3KhBXnhzbB36yW495Ts1ygNA+MzUsdHb0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=beVz5CmK+Xm/DIYLB79lTpz7rttUH5f37botuXo8OAxfxbny0J0q9qVo5aUmaW13iWiJ6l9h0c6OHolFjgN7oteWxm6161TBCoRcKLpJL9ioI9B1p5BrVHh6eFq1hNboYXCru9qMcmiS8b3+8kKpWjIJ9fGT5tTBRucnDcbFWMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lq5oDNTn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9439AC32786;
	Thu, 13 Jun 2024 12:16:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718281015;
	bh=tekr1M6Lsc3KhBXnhzbB36yW495Ts1ygNA+MzUsdHb0=;
	h=From:Subject:Date:To:Cc:From;
	b=lq5oDNTn+e1GkKZ2nErzc+Njjzk3f52tL6j9vfiYZlU8WgXI+UpcwQJxOKN/rk7Fm
	 qQdynARCd0DS6dac+uRLTrHLod7Q08bNUC/wUxbPvD85vTV4DK78xDBNFfULBYXbiP
	 cr8BS6tLMpX6+xu2ANvyxuXV7IOkPuD6xkNo84i4cxau3ETBA9xWPwBExsK0QwCcJ/
	 TKOosv2sMMdZsCMAMJLPAvTkNJw2SratzDmSk+15sGUz7ipTBUP7FiQi9plh0hqiTy
	 bM88EBFVkXdKc5NMZz3jSQS/RBCmem1xPVmk5jdPVfWtPaGkfh5fMYXzBllPlP/0hc
	 PJ5pq1lek8cww==
From: Jeff Layton <jlayton@kernel.org>
Subject: [PATCH v2 0/5] nfsd/sunrpc: allow starting/stopping pooled NFS
 server via netlink
Date: Thu, 13 Jun 2024 08:16:37 -0400
Message-Id: <20240613-nfsd-next-v2-0-20bf690d65fb@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACXjamYC/23MQQrDIBCF4auEWXeKERHTVe9RsrCZMZEWLRokI
 Xj32qy7/B+P74DMyXOGW3dA4uKzj6GFvHQwLTbMjJ5agxRSCS0UBpcJA28rPoWaBEkygx2g/T+
 Jnd9O6zG2XnxeY9pPuvS/9Z9SehRoyGmjLeue+P7iFPh9jWmGsdb6BWk77s2jAAAA
To: Chuck Lever <chuck.lever@oracle.com>, Neil Brown <neilb@suse.de>, 
 Olga Kornievskaia <kolga@netapp.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Trond Myklebust <trond.myklebust@hammerspace.com>, 
 Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1609; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=tekr1M6Lsc3KhBXnhzbB36yW495Ts1ygNA+MzUsdHb0=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBmauMwl+985IQvKqH1qc1BTaAnAhPDnAv2mUgCR
 fhb3t2xv0SJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZmrjMAAKCRAADmhBGVaC
 FfJgD/92YQiqGXFcQHYnJqPTc8bw/oPZQ01N6W5Re6kJaxOZIJfWD6wTMvt+qWDbkH3GX95e7wV
 LunethNs8AlRxEv21yEP+J+aOsxfHqZj8vVXdMFb9dtmwfKjKR0nEqTz72QvzfBrrNCQozm5k5m
 L+TeHAK+/RX/C/xHLhtinRe6Em8C1k3/wsWfFrDcn9yPaUngYVmJWFSqyVxipR0t+Gz3fYEwbpU
 yWVSl6o2U1VLvicPNiOGEK74plqqNbii3P+Fa6eWpWoCpaEaUF3EiGzz64xY/GTukm7WdawwsuV
 cm4g4LwsJ5iKkrF87H75YA/GG3edbW3cGXE8uWCkqTQcxIw3X6OMWbZAZz8dWy66hXOJGFEBcB+
 08utiAE/waDVmkoAfsjpS8MSqegcE5zMl+I97XVSg8krFlakqYrzIwCzLCwKU1y4qdgVjlEbUqZ
 kLwoCvrJOrq33AoV83TJEryOy4vDvO4UflzQOvaK0SWDpjJgjuFW7pGcqTa9V2SGaFJZBNSIO0g
 4gx7JN5g+I9bfawYzP29AMoV2bfUfQlfaotMfjP2OZzPzf+M2J6xdYx5EqLDN8w56troetwYTZy
 2K0B+VVBtCKX5nXgFlhvVdiNfDY4JTSbFwp9Esn3La7zF+9rWXdNQOgqrR/CcCknQQqxTJb1zze
 18NNpl9xiH9zMMg==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

This is a resend of the patchset I sent a little over a week ago, with
a couple of new patches that allow setting the pool-mode via netlink.

This patchset first attempts to detangle the pooled/non-pooled service
handling in the sunrpc layer, unifies the codepaths that start the
pooled vs. non-pooled nfsd, and then wires up the new netlink threads
interface to allow you to start a pooled server by specifying an
array of thread counts.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
Changes in v2:
- add new pool-mode set/get netlink calls

---
Jeff Layton (5):
      sunrpc: fix up the special handling of sv_nrpools == 1
      nfsd: make nfsd_svc call nfsd_set_nrthreads
      nfsd: allow passing in array of thread counts via netlink
      sunrpc: refactor pool_mode setting code
      nfsd: new netlink ops to get/set server pool_mode

 Documentation/netlink/specs/nfsd.yaml |  27 +++++++++
 fs/nfsd/netlink.c                     |  17 ++++++
 fs/nfsd/netlink.h                     |   2 +
 fs/nfsd/nfsctl.c                      | 102 +++++++++++++++++++++++++++++-----
 fs/nfsd/nfsd.h                        |   3 +-
 fs/nfsd/nfssvc.c                      |  30 +++++-----
 include/linux/sunrpc/svc.h            |   3 +
 include/uapi/linux/nfsd_netlink.h     |  10 ++++
 net/sunrpc/svc.c                      | 102 +++++++++++++++++++++-------------
 9 files changed, 225 insertions(+), 71 deletions(-)
---
base-commit: fec4124bac55ad92c47585fe537e646fe108b8fa
change-id: 20240604-nfsd-next-b04c0d2d89a9

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>


