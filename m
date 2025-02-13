Return-Path: <linux-nfs+bounces-10088-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 583E4A34231
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Feb 2025 15:33:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABC5C3A27D8
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Feb 2025 14:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CA2328137F;
	Thu, 13 Feb 2025 14:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NAcmDLI4"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33A16281360;
	Thu, 13 Feb 2025 14:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739457108; cv=none; b=jzjrtjgMA0zpDQOrhx1Fl/YcvRoYpTAmDtkyzqElqtG04sDrJAztKY+6/YZ/EJAVC/dmHoLvfNbU8NFwz2SEURL8AXPS84Alv2FTk5PwhCMRkN4nFrN0WC6FkpTxLvKZcicWESd1uEsxfK99pNt4rRvb/W95/FDpQ2tIjfGYCE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739457108; c=relaxed/simple;
	bh=OA53EvUVXv1GhM5nFaZwYKdlhJhq0PlyQ6nM6WoxQ5k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cJtyWu65pryRRB5IFQCyfk+d47obdEI2V0ztKuP0sYyHs7WKPpWJqUUI7oOScquUrL52po2Wl+AbQ4pXHpvv93GGKs26fbYpsQjOt3de+Yd78sXPnhRJ5M7WlgDmkzbX153Bc59FTa05nzrcne50lum3Qh/1Onzd978Qc+3aV0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NAcmDLI4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 654C1C4CEE8;
	Thu, 13 Feb 2025 14:31:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739457107;
	bh=OA53EvUVXv1GhM5nFaZwYKdlhJhq0PlyQ6nM6WoxQ5k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NAcmDLI49tnhWxwzXDphQWUBEilB0AbJCqZ9K6H6jvIOO8naxJwJtPt9cM3IfrzWm
	 GtGGHbCU9ER3G7KV2zY65oplYowGGiD+XVwvhsB2aBpz2M6MP3U+Ota0H2CnnJ+BNk
	 g0QoaZCKCXEW+nsO2pMweI5bMFk0JCBih2oipLuVaDa/HTF9e0shquxyZ+HW51KCpX
	 9rsNEkya68f+EHItQFVFLJszS9loxH/1JvBczkJXL8Ks598xN6sL4FjihPURumLbRD
	 qRd+EPVprlcVbdGEF9Zf0Ldw3GZ+cukfo+yN8aGNUD1FRsjwJw8qn0XyT4nZsHBh5Z
	 krPQ+swBN9oog==
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
Subject: Re: [PATCH v2] nfsd: put dl_stid if fail to queue dl_recall
Date: Thu, 13 Feb 2025 09:31:43 -0500
Message-ID: <173945704787.138332.16372203572251102866.b4-ty@oracle.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250213144220.156089-1-lilingfeng3@huawei.com>
References: <20250213144220.156089-1-lilingfeng3@huawei.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

On Thu, 13 Feb 2025 22:42:20 +0800, Li Lingfeng wrote:
> Before calling nfsd4_run_cb to queue dl_recall to the callback_wq, we
> increment the reference count of dl_stid.
> We expect that after the corresponding work_struct is processed, the
> reference count of dl_stid will be decremented through the callback
> function nfsd4_cb_recall_release.
> However, if the call to nfsd4_run_cb fails, the incremented reference
> count of dl_stid will not be decremented correspondingly, leading to the
> following nfs4_stid leak:
> unreferenced object 0xffff88812067b578 (size 344):
>   comm "nfsd", pid 2761, jiffies 4295044002 (age 5541.241s)
>   hex dump (first 32 bytes):
>     01 00 00 00 6b 6b 6b 6b b8 02 c0 e2 81 88 ff ff  ....kkkk........
>     00 6b 6b 6b 6b 6b 6b 6b 00 00 00 00 ad 4e ad de  .kkkkkkk.....N..
>   backtrace:
>     kmem_cache_alloc+0x4b9/0x700
>     nfsd4_process_open1+0x34/0x300
>     nfsd4_open+0x2d1/0x9d0
>     nfsd4_proc_compound+0x7a2/0xe30
>     nfsd_dispatch+0x241/0x3e0
>     svc_process_common+0x5d3/0xcc0
>     svc_process+0x2a3/0x320
>     nfsd+0x180/0x2e0
>     kthread+0x199/0x1d0
>     ret_from_fork+0x30/0x50
>     ret_from_fork_asm+0x1b/0x30
> unreferenced object 0xffff8881499f4d28 (size 368):
>   comm "nfsd", pid 2761, jiffies 4295044005 (age 5541.239s)
>   hex dump (first 32 bytes):
>     01 00 00 00 00 00 00 00 30 4d 9f 49 81 88 ff ff  ........0M.I....
>     30 4d 9f 49 81 88 ff ff 20 00 00 00 01 00 00 00  0M.I.... .......
>   backtrace:
>     kmem_cache_alloc+0x4b9/0x700
>     nfs4_alloc_stid+0x29/0x210
>     alloc_init_deleg+0x92/0x2e0
>     nfs4_set_delegation+0x284/0xc00
>     nfs4_open_delegation+0x216/0x3f0
>     nfsd4_process_open2+0x2b3/0xee0
>     nfsd4_open+0x770/0x9d0
>     nfsd4_proc_compound+0x7a2/0xe30
>     nfsd_dispatch+0x241/0x3e0
>     svc_process_common+0x5d3/0xcc0
>     svc_process+0x2a3/0x320
>     nfsd+0x180/0x2e0
>     kthread+0x199/0x1d0
>     ret_from_fork+0x30/0x50
>     ret_from_fork_asm+0x1b/0x30
> Fix it by checking the result of nfsd4_run_cb and call nfs4_put_stid if
> fail to queue dl_recall.
> 
> [...]

I replaced the Fixes: tag with Cc: stable.

Applied to nfsd-testing, thanks!

[1/1] nfsd: put dl_stid if fail to queue dl_recall
      commit: d520b70859e0fb6d62ca12eee601a3d6ff4a11b6

--
Chuck Lever


