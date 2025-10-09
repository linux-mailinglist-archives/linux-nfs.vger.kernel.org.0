Return-Path: <linux-nfs+bounces-15089-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A5C75BC990B
	for <lists+linux-nfs@lfdr.de>; Thu, 09 Oct 2025 16:41:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DAAE24FB5FB
	for <lists+linux-nfs@lfdr.de>; Thu,  9 Oct 2025 14:40:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1F072EAD0D;
	Thu,  9 Oct 2025 14:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n2URae3k"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F660246774;
	Thu,  9 Oct 2025 14:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760020824; cv=none; b=lbe7XAAcrKEvxU9dcCcLDR2u8Ot1YOmiQZxa44STGX5bOmeBJbSRyyFYbUeXpeyp/btkOBLNlSyq+u3UiASsiUr+2TTsTPaMyPYhUS6Jww/6hV5tYQPMQbn37tyZIHBXTv3fAXm1mzRlRPxozFR6eIKaMI4qwHc8R606pnSXjzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760020824; c=relaxed/simple;
	bh=0YWfCUOzoKqIDrZJK6AE+oAiXVaz5LG+BF6wErhSLHM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=tCSZrhLsFvB3fnAF0q6/FQb/XVtKVnyFC8zX+o4r1jhqV7PP3y4dhGogOfcdhM3hcAnsMAxBqrnaz1aKTveUamHTviQVNcrgJ0wDTRH2A9MUtGsgigNLc9A/6jYvBrEpulob0YfvYEMFf/zwIs2g8L2HVtY+wK+5GKQwHBIYw7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n2URae3k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B1ECC4CEE7;
	Thu,  9 Oct 2025 14:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760020824;
	bh=0YWfCUOzoKqIDrZJK6AE+oAiXVaz5LG+BF6wErhSLHM=;
	h=From:Subject:Date:To:Cc:From;
	b=n2URae3kJvFnwVxQvynVIVknYXWCmwCpleHZ1Tlj6dO/AyJZQzCn4UALHGs3Xybee
	 sgDFJjcrCxTIFJVap5/Zh+kG74B8w/EUsBZ46hq2yZuV+7tuMtxvS/Tlvva35SeW7K
	 zN1DjU71OL93yvqpnSoDby24qCnLlDbXrofiHHBPXU6zddYjLAeL8QkByTLsyNUFoM
	 IdUGtvuS5cLV6Yct0UAh7IPIA+FeAyTxf7SwKhkYMVWU92AsG4RDQbSU0+A4tTggZ2
	 J4akRukA5Nftx0POIz9vwn7tnNIiwJ7m0wk7joQNgeaGrVd+EKi1qhwUdR05I2tFrN
	 1hVnaZpwF0/sQ==
From: Jeff Layton <jlayton@kernel.org>
Subject: [PATCH v3 0/2] sunrpc: fix handling of rq_bvec array in svc_rqst
Date: Thu, 09 Oct 2025 10:40:09 -0400
Message-Id: <20251009-rq_bvec-v3-0-57181360b9cb@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEnJ52gC/3WMywrCMBBFf6XM2kg6IW1x5X+ISB6TNiitTiQop
 f9u2p2Iy3O558yQiCMlOFQzMOWY4jQWULsK3GDGnkT0hQEl6lrKTvDjYjM5YZvGBC+Dt9ZCed+
 ZQnxtpdO58BDTc+L3Fs71uv42ci2kaAMqr9C3mvTxSjzSbT9xD2sk4x8Ri9ihctJ02mDrvsRlW
 T546oEk2AAAAA==
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1063; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=0YWfCUOzoKqIDrZJK6AE+oAiXVaz5LG+BF6wErhSLHM=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBo58lQ5n7a4yBH4qeooGEJWqwQLNqX5+hy3yUUO
 u+zMkoFCSaJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaOfJUAAKCRAADmhBGVaC
 FUlPD/0bOIgV1vW6mNIxP1ZZTHF6Mol+vbQ4AvF5ewS9/2TnkHgs+8bHwIj0w1Vbuk0LiECxohF
 XEcfMaJ0qxbLfNcUnEo6w9VUFavc5eu5gttlqTsIX8pFvDb4xlYjR6Ek08zamSTO70KR3xPz+Sg
 7KdIjuBN3au6VaDzuoszoWbfFqj4/WOaOcgFDUchy2sYAfmqCR3FVmlvsSUJg3gDu932vL97N1d
 yB+Rj1Q6vHiGtFWeqErfw+KVmnLTWcgUAwCtktg4mF73QSiQ5Dy44jSdKoi9R7Ncp4nBqzD7FFM
 ZGB4fZREtE8sq6JV8AOnSFrRMln2c2Xz39Au19Rs6Fr1YkM6LWfdLFngeXizLvNXN7znFbrhhp1
 AQe/vnw3t9OUcgbukrk44LHwBZjF5d6AwHPbhYn4WaZ3uSdweFe+6oOn32FdBwrzR3fm3yAz5dw
 WB0sSh5JmQ8A9WeP0X3HzLELKbjsJOrpdiaWBSNvV3tZ8JAOujrymZuA2gbon3Joc2w4HzvsjU0
 NoDfTmC6uzA8lVMlVkObcsIzjqKJJgXqRfjWfh4g8rLzujoxzXbt/92LLAZNbI+W/fNa3wvhLNS
 JHWHdKO93nXZWMoCMp+MCgq2RdhZ4c8G5UMV1Ir/3KuLloPD+4wkR49vLTmT8tr+4uDfTt2WzBN
 oQzH807R8lL0NwQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

This version of the series just changes the second patch to use a
separate rq_bvec_len field instead of rq_maxpages at the places where
it's iterating over the rq_bvec.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
Changes in v3:
- Add rq_bvec_len field and use it in appropriate places
- Link to v2: https://lore.kernel.org/r/20251008-rq_bvec-v2-0-823c0a85a27c@kernel.org

Changes in v2:
- Better changelog message for patch #2
- Link to v1: https://lore.kernel.org/r/20251008-rq_bvec-v1-0-7f23d32d75e5@kernel.org

---
Jeff Layton (2):
      sunrpc: account for TCP record marker in rq_bvec array when sending
      sunrpc: add a slot to rqstp->rq_bvec for TCP record marker

 fs/nfsd/vfs.c              | 6 +++---
 include/linux/sunrpc/svc.h | 1 +
 net/sunrpc/svc.c           | 4 +++-
 net/sunrpc/svcsock.c       | 4 ++--
 4 files changed, 9 insertions(+), 6 deletions(-)
---
base-commit: 177818f176ef904fb18d237d1dbba00c2643aaf2
change-id: 20251008-rq_bvec-b66afd0fdbbb

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>


