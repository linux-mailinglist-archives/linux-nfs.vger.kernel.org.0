Return-Path: <linux-nfs+bounces-3551-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C674A8FBDBF
	for <lists+linux-nfs@lfdr.de>; Tue,  4 Jun 2024 23:08:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E5DF285327
	for <lists+linux-nfs@lfdr.de>; Tue,  4 Jun 2024 21:08:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F08FA142905;
	Tue,  4 Jun 2024 21:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gei8Uz0w"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1F0712D215;
	Tue,  4 Jun 2024 21:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717535292; cv=none; b=P4hqaHYMIPkU54A5/epUvljyBKG4OEDCoQtjpY0lH581cluwNzbcUfugmKJdwJor/97inX26meDMPf07p8ZB1DnkQMa1Isx/RWRQeNJRiYe8YPxCwUvlfeqhizB/8MtDu5keiQnq5SfLRGMSHYYWtOHGHcWC8Dy7ITf15/H4gAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717535292; c=relaxed/simple;
	bh=1FN2QRadM5mT3+earethOmd6uU3BHoCh2blqMdZ4Qxw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=B8Hb0Gff8lSKG1r6S5ZJCc08QFsvIK9JbxE2PpNOHI8CkPXqot49ELpVrKZfKK/VT85FfcPI14neqOsWLohw4ExDAbI8K8/CP8J4El3aYFHcxaZNb3Wp8SVQ47zE9fkwaYdF+Y0mqbnfJOVLTqV1yyuHTs7CcjSmcUBOyutIfbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gei8Uz0w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E90F2C2BBFC;
	Tue,  4 Jun 2024 21:08:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717535292;
	bh=1FN2QRadM5mT3+earethOmd6uU3BHoCh2blqMdZ4Qxw=;
	h=From:Subject:Date:To:Cc:From;
	b=gei8Uz0wkgNfnGOYuBMY8G9c5of3Yla5SL/lbbGTO7+2NYsONCxbZsGQZFJb6Isft
	 WD+MO/8Ur9i+CQoMX5KZjXCiYfA87Qfprl1y8t4Vrd/1HNfZXa9BrIEGVg4J48RmPw
	 4ddBUu8Xc6my3Jo9dgLvqJvG0ePXv2hkw81jcVgb7YHBs24XorPa9q+TNqnUCQxQVz
	 WUnD5KmZae92kw+kQMv/gnJLi3KMWCcz/EB0VYrAcvHbnM30O6siz2zAt9KIXTskOh
	 3Hm9QlvSIUqmvz59D8jzXQDa3dgkzndvG1vmbY0L5nS4b9Ma0Dv+4Hag9USQRxCSuZ
	 /iZS+KS2ryHSg==
From: Jeff Layton <jlayton@kernel.org>
Subject: [PATCH 0/3] nfsd/sunrpc: allow starting/stopping pooled NFS server
 via netlink
Date: Tue, 04 Jun 2024 17:07:53 -0400
Message-Id: <20240604-nfsd-next-v1-0-8df686ae61de@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACqCX2YC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDMwMT3by04hTdvNSKEt0kA5NkgxSjFAvLREsloPqCotS0zAqwWdGxtbU
 ADSPhKFsAAAA=
To: Chuck Lever <chuck.lever@oracle.com>, Neil Brown <neilb@suse.de>, 
 Olga Kornievskaia <kolga@netapp.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: Trond Myklebust <trond.myklebust@hammerspace.com>, 
 Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1437; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=1FN2QRadM5mT3+earethOmd6uU3BHoCh2blqMdZ4Qxw=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBmX4I6Mg6kDJgTvgCa215s6PzG4olxHCy87aFKg
 fjWrwCWjkSJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZl+COgAKCRAADmhBGVaC
 FcbqEACzLJWevA7cs6b7KiusGWyXVUOcwplB5Do/rty7ZZZU+PaCgRzTjW/D79KEcRGLUW+w56t
 ZrrIGdIC1Adp+4dIK/VjjAWo1XYLlWIhtSvRSwkMKxR0jnjvmlzaXYwTXfc/kzkgMoplD/VB8hO
 kTErr92/jCGKw3f1aJDTTk4Nx2aG4RTgTbPy5XSfsRQSV8G79XBWGPvx63QdE1qNXAEJu3WiJoq
 MZDxbIIBUPVbeE7zNv8sgDrkgka7YtmWRnB2oUjH5bJYNhSTBRBDlXHk+48tH5fLD/Tn+Nznebt
 7do3+L+ZSBgLgwo8yiAHhmgPKM8ICTt+dQ9IeLSb3CryidMPpiiw8hnQqsam3QlpozL4mRW2zPv
 +hI2y1zdUaerjKVl1LDOgILsLlNOo2vjm6YzxpBsxAitNtjvx6asN47FMk6ydJuA767WR+++2Wu
 DGqPAk7t6rF6kuoI/fFOZI0lYiCYANcac2esQfgzQMefNz8mRO50NhsiyMA1sgn7XM8GD841VJi
 +XAP3iYXIfUo4zCByJb24Wsa5gfXibImwr9w+TxGSPHSqhtLeSDQrjRtFOT8qjQzFGOt8S4/Sfm
 qV/5+DSE/SXvyyrOWuZCJ++84PMqNwsp7LFEgxHhldcga+VHcv74zEvzV6tEXmr76vhRXn1ZW5Y
 lTwvNaMwvfy2fXw==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

This patchset first attempts to detangle the pooled/non-pooled service
handling in the sunrpc layer, unifies the codepaths that start the
pooled vs. non-pooled nfsd, and then wires up the new netlink threads
interface to allow you to start a pooled server by specifying an
array of thread counts.

FWIW, eventually I'd like to wire up the pool_mode setting to netlink as
well. I took a stab at adding a pool_mode parameter to the set_threads
interface, but I think that's the wrong approach. By the time we call
set_threads, we've usually already allocated the serv. I think pool_mode
setting has to be done with new netlink call. I'll probably tackle that
in a later patchset.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
Jeff Layton (3):
      sunrpc: fix up the special handling of sv_nrpools == 1
      nfsd: make nfsd_svc call nfsd_set_nrthreads
      nfsd: allow passing in array of thread counts via netlink

 fs/nfsd/nfsctl.c           | 45 ++++++++++++++++++++++++++++++++-------------
 fs/nfsd/nfsd.h             |  3 ++-
 fs/nfsd/nfssvc.c           | 30 +++++++++++++-----------------
 include/linux/sunrpc/svc.h |  1 +
 net/sunrpc/svc.c           | 26 +++++++-------------------
 5 files changed, 55 insertions(+), 50 deletions(-)
---
base-commit: fec4124bac55ad92c47585fe537e646fe108b8fa
change-id: 20240604-nfsd-next-b04c0d2d89a9

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>


