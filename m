Return-Path: <linux-nfs+bounces-14072-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 70DEEB45A62
	for <lists+linux-nfs@lfdr.de>; Fri,  5 Sep 2025 16:27:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13E8B3BE664
	for <lists+linux-nfs@lfdr.de>; Fri,  5 Sep 2025 14:27:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3489736CDF8;
	Fri,  5 Sep 2025 14:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XalE1XVn"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B0D03629B8;
	Fri,  5 Sep 2025 14:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757082382; cv=none; b=BL8sK8i97Rev9b0gABs7bxzeOwiqLyQRst64ywLrCOBoI9qGyZvpDEVmZl3Q2eu2Q1JnIB69KXknaovSv5k2+MvHuZkiGrS9IMshw8AGwp4Z0fxErlFaPR2F18oK6wJeK+pN1xYDYWrg2GesebUWoM/ePNh12t9hnmrWT+ydSss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757082382; c=relaxed/simple;
	bh=UjqAYKJTSYSj3/lVMgkdEEl0+WopBrOjmB8AwU9ymY0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GJ88eHs5uOQz2wPXplqjfFKqLgjaPXgyu1Ej4GfLweXwJ6oWaaU9BQl94aSPZmobP6fXroBEax+nxC1FbYswBoOpJNPpjd7DprMPZ7CC4XOZe4buPqDaY+GloIcg01pkUVmsd4wDuPi6soBgU/NJEhuBqtJouR4kioaN3jERYd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XalE1XVn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 796F8C4CEF1;
	Fri,  5 Sep 2025 14:26:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757082380;
	bh=UjqAYKJTSYSj3/lVMgkdEEl0+WopBrOjmB8AwU9ymY0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XalE1XVnpR5VFhAIFEp/lUNwlPzCs6O20clpy1LbUbf1IvYX71iHau5NUkm62tV5f
	 faWESd16uGdQMmoGvgBCSFNkNnVhiob/+0tNyYAfj3sdkJpqod4xDcL996Zy98Sjwi
	 1/VC3p3mPLnYneNygijYsdyRT0ivJ/HbgGzZbRvS8hCqot4/PzclbhXK3DQbtDn4xg
	 EWYz+FoqR2vd4Wsf2Ft6Yxoxwdy7ZFrjBuxuPgGjtHQDr6JUNakCfi2IcVPgZcWd0F
	 kvn38f0jTfad251kKDOqnU7gcGzXTV7UCOrk+I6B3zq51gRAp+Xr9Lf5H4a7wReHbr
	 TwoEtGWLq4ThQ==
From: Chuck Lever <cel@kernel.org>
To: jlayton@kernel.org,
	neil@brown.name,
	okorniev@redhat.com,
	Dai.Ngo@oracle.com,
	tom@talpey.com,
	linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Li Lingfeng <lilingfeng3@huawei.com>
Cc: Chuck Lever <chuck.lever@oracle.com>,
	yukuai1@huaweicloud.com,
	houtao1@huawei.com,
	yi.zhang@huawei.com,
	yangerkun@huawei.com,
	lilingfeng@huaweicloud.com,
	zhangjian496@huawei.com,
	bcodding@redhat.com
Subject: Re: [PATCH v3] nfsd: remove long-standing revoked delegations by force
Date: Fri,  5 Sep 2025 10:26:16 -0400
Message-ID: <175708235655.5954.1163796165892461013.b4-ty@oracle.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250905024823.3626685-1-lilingfeng3@huawei.com>
References: <20250905024823.3626685-1-lilingfeng3@huawei.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

On Fri, 05 Sep 2025 10:48:23 +0800, Li Lingfeng wrote:
> When file access conflicts occur between clients, the server recalls
> delegations. If the client holding delegation fails to return it after
> a recall, nfs4_laundromat adds the delegation to cl_revoked list.
> This causes subsequent SEQUENCE operations to set the
> SEQ4_STATUS_RECALLABLE_STATE_REVOKED flag, forcing the client to
> validate all delegations and return the revoked one.
> 
> [...]

Applied to nfsd-testing, thanks!

[1/1] nfsd: remove long-standing revoked delegations by force
      commit: 5f5838c5e1b399371e3e4f45a79ce822eb6ee4cc

--
Chuck Lever


