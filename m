Return-Path: <linux-nfs+bounces-7192-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3B4C99FD20
	for <lists+linux-nfs@lfdr.de>; Wed, 16 Oct 2024 02:29:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 313261C242D4
	for <lists+linux-nfs@lfdr.de>; Wed, 16 Oct 2024 00:29:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5844B673;
	Wed, 16 Oct 2024 00:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rmV1IpK7"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A86AFB641;
	Wed, 16 Oct 2024 00:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729038575; cv=none; b=dysIJ5vBtnyMYO0S50FKDc6IFEEYVrrAlRWQWwhZ0CL2UwRhQYJj5dVW0FrvUAYWE787eMEHSz+xGbzIFE+eVHNZ+Gvh1k9SnCnh14ec5+ed72rL9s9+Xa+fq3P3YWR1M9CyJbMcf6UvyG4LTlX0hQmDtjieQSHKnNNs210fSGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729038575; c=relaxed/simple;
	bh=UX50Uuxyl6KpeCZ9V3FN/RT0FMfn23uteQZUQF7qX3w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eCbl8wwZ4DJIt9O0wO54bplr2uwVm0km/XznQfFmmyWC7LzmjrUENRUCAwZUK0zIZohI12dHg7N8CG6gD5oBirb89Ul8J+48/CCABgsiCJCkJIevCpj82SQft7FDm5TG6PuF9r61Vf/LT+RfxbmMdvE5jnyu6rHY52fTgPNT24Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rmV1IpK7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1550C4CEC6;
	Wed, 16 Oct 2024 00:29:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729038575;
	bh=UX50Uuxyl6KpeCZ9V3FN/RT0FMfn23uteQZUQF7qX3w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rmV1IpK7eC0ZkRA9iAfkT4ehVfQmWr/FMidbJ6A0Ua6XWquSP1/uz2h4etMyqXMXU
	 CJc6ms0TTFw5KgWfNb/Ou8cMEDodCNEejrvib/NL+AfLYZQVyZ+FFg/kvJne0hiCtB
	 bSw5AmObtOsM31cU47axeglWnUnWfk1EQcaWImPrl3cqkOjKfa/hhzvFTms586Z/zT
	 JdTTgIinlVvliFxvIdEIfidTA9NVb82pVBB5omfCoVBBp/Qn4z9jlhv9W071EG3xE/
	 svnhpuPwU+QIDpBhHr9dryqi9xIkT/xjxp1toZ0//rJRyc8oDN9PpxQEVZCUB7pBdk
	 YHMNaKt5SoZ3g==
Date: Tue, 15 Oct 2024 18:29:31 -0600
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>,
	Neil Brown <neilb@suse.de>, Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org, Kees Cook <kees@kernel.org>
Subject: [PATCH 2/5][next] nfsd: avoid -Wflex-array-member-not-at-end warnings
Message-ID: <9a04f3f766b2f8438887f6a003cf288d0f366fb8.1729037131.git.gustavoars@kernel.org>
References: <cover.1729037131.git.gustavoars@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1729037131.git.gustavoars@kernel.org>

-Wflex-array-member-not-at-end was introduced in GCC-14, and we are
getting ready to enable it, globally.

Address the following warnings by changing the type of the middle struct
members in `struct nfsd_genl_rqstp`, which are currently causing trouble,
from `struct sockaddr` to `struct sockaddr_legacy`. Note that the latter
struct doesn't contain a flexible-array member.

fs/nfsd/nfsd.h:74:33: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
fs/nfsd/nfsd.h:75:33: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]

Also, update some related code, accordingly.

No binary differences are present after these changes.

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 fs/nfsd/nfsctl.c | 4 ++--
 fs/nfsd/nfsd.h   | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index 3adbc05ebaac..884bfdc7a255 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -1599,9 +1599,9 @@ int nfsd_nl_rpc_status_get_dumpit(struct sk_buff *skb,
 			genl_rqstp.rq_stime = rqstp->rq_stime;
 			genl_rqstp.rq_opcnt = 0;
 			memcpy(&genl_rqstp.rq_daddr, svc_daddr(rqstp),
-			       sizeof(struct sockaddr));
+			       sizeof(struct sockaddr_legacy));
 			memcpy(&genl_rqstp.rq_saddr, svc_addr(rqstp),
-			       sizeof(struct sockaddr));
+			       sizeof(struct sockaddr_legacy));
 
 #ifdef CONFIG_NFSD_V4
 			if (rqstp->rq_vers == NFS4_VERSION &&
diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
index 004415651295..44be32510595 100644
--- a/fs/nfsd/nfsd.h
+++ b/fs/nfsd/nfsd.h
@@ -71,8 +71,8 @@ struct readdir_cd {
 #define NFSD_MAX_OPS_PER_COMPOUND	50
 
 struct nfsd_genl_rqstp {
-	struct sockaddr		rq_daddr;
-	struct sockaddr		rq_saddr;
+	struct sockaddr_legacy	rq_daddr;
+	struct sockaddr_legacy	rq_saddr;
 	unsigned long		rq_flags;
 	ktime_t			rq_stime;
 	__be32			rq_xid;
-- 
2.34.1


