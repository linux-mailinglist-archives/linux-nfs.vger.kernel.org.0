Return-Path: <linux-nfs+bounces-11086-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 945C2A84670
	for <lists+linux-nfs@lfdr.de>; Thu, 10 Apr 2025 16:33:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 413304E1890
	for <lists+linux-nfs@lfdr.de>; Thu, 10 Apr 2025 14:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C110B28C5DA;
	Thu, 10 Apr 2025 14:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="naz1anVW"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97DEE28CF50;
	Thu, 10 Apr 2025 14:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744295414; cv=none; b=PKrWw9ducsUisujq0dtQnpiYj8hMQX6hFsAqS0cPLHfxScb3lhBOuBPlfYvknLjcrWZotC6YsWRticDxZiy8J8jJZVHwPni5V5SEnR+0GvysQhysp9yuHINfI4aGkeuMJvkwmtgW3ZGC7HIJr/bqTnTTGvEGIpCkYHTVnD4E+Co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744295414; c=relaxed/simple;
	bh=j/AQnvVQF+q4DRTfwVD8GyFNToLS8aNgxm6x8L78Myc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=geSxtO8+aqIvGMXsXI/MuXPq5+bgO8zrvCLGxYXu4czzOXemIbqP/cGRtyQ5DVbCjGI285Fn+7rEcAi9NI4tvgru8MdwlPOtUriYHaYppt3OYzTizwwGYnO+4prJmdC7sEjqqOr8nGOpNVsH3rRNBbYh0CF1htR8dLbkPGDjiko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=naz1anVW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0854C4CEDD;
	Thu, 10 Apr 2025 14:30:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744295414;
	bh=j/AQnvVQF+q4DRTfwVD8GyFNToLS8aNgxm6x8L78Myc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=naz1anVWOzUgUm+ykoHNe8H/cpW/VSy0kDgPQuJaxQ0HAuOFWWrBWw8esDHgtuxQK
	 MvbLXiekM+K4wXtwuutcH129Sak2wVXvqL0LtEtn8DhsUtcXEm4ussvzoEsnyNMvMG
	 ip/J96QgzgTvEoKri7AfNwtTEh3R9y+q2AZlN4TJZBHi0Ra+kZmS9amm6fChZwIfww
	 ccISLVPpHPIUW+iKxdIOi0qViNhSOGpkcp1Wx8PBJT0L07p2c3f7a2Mz0225XMrQaM
	 tbAL1bb1KwUmITpaxIy3Y9IBjF5j66pO8TxOBe8rP4QHJn8Za7DnocEvGLCP2Ofz7c
	 V1uIfG8bNi7YA==
From: cel@kernel.org
To: jlayton@kernel.org,
	neilb@suse.de,
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
	lilingfeng@huaweicloud.com
Subject: Re: [PATCH] nfsd: decrease sc_count directly if fail to queue dl_recall
Date: Thu, 10 Apr 2025 10:30:10 -0400
Message-ID: <174429540114.22824.14246125911839557664.b4-ty@oracle.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250410015708.2036236-1-lilingfeng3@huawei.com>
References: <20250410015708.2036236-1-lilingfeng3@huawei.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

On Thu, 10 Apr 2025 09:57:08 +0800, Li Lingfeng wrote:
> A deadlock warning occurred when invoking nfs4_put_stid following a failed
> dl_recall queue operation:
>             T1                            T2
>                                 nfs4_laundromat
>                                  nfs4_get_client_reaplist
>                                   nfs4_anylock_blockers
> __break_lease
>  spin_lock // ctx->flc_lock
>                                    spin_lock // clp->cl_lock
>                                    nfs4_lockowner_has_blockers
>                                     locks_owner_has_blockers
>                                      spin_lock // flctx->flc_lock
>  nfsd_break_deleg_cb
>   nfsd_break_one_deleg
>    nfs4_put_stid
>     refcount_dec_and_lock
>      spin_lock // clp->cl_lock
> 
> [...]

Applied to nfsd-testing, thanks!

[1/1] nfsd: decrease sc_count directly if fail to queue dl_recall
      commit: e8f1e5f463b88ce923eefac447abc2079075f921

--
Chuck Lever


