Return-Path: <linux-nfs+bounces-8978-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 60551A064E8
	for <lists+linux-nfs@lfdr.de>; Wed,  8 Jan 2025 19:52:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF675188A1BD
	for <lists+linux-nfs@lfdr.de>; Wed,  8 Jan 2025 18:52:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C40652036FB;
	Wed,  8 Jan 2025 18:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FxYEl9cM"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A7212036F6;
	Wed,  8 Jan 2025 18:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736362330; cv=none; b=Ul7B3um/yGcSbRbGOyKW3gkMH4b5NjlmC+PmZGKAClB/UwdGpvsFM06Wwqs6Suu419eca4tb5pZ0e91hl4JxDZSadtXJbDSj2ObVhML4z8IhFIaz0Bf7fK/RdIfI4xA6SGr9DAc/Ebci0HP+ps16HMZ8OI7Hl2Wb8VTNktYU49o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736362330; c=relaxed/simple;
	bh=6bKbrA3E1mihpOqUKCx8WHGCaXM6LJuSDdAiWto3gKg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U+xEVXNjw9hCY7R2kMyaquo3cbbCuAaQQy9k+6dGhtOxfBT5FvmEdJToVVIVi9L7a4Pv8EBy1rHzK2hgws5hu9t96sHccH/2wE5k9+R19Q2jLveaNdqYM7fqCto5VfNEyep3aZgvCdxHVOlwwmTbhYRYVNdC3w/MMWQuesufmvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FxYEl9cM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1056C4CEE1;
	Wed,  8 Jan 2025 18:52:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736362330;
	bh=6bKbrA3E1mihpOqUKCx8WHGCaXM6LJuSDdAiWto3gKg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FxYEl9cM1JZ17VNjUfdBl9wTXD7ZK03UhN8tb6gyvTJTjhyu5Z3goAKwK0c0WUbLv
	 4taq5izvzWlqeuRMx1CrlbjwwV9OpL4NmxBwCcLndTm4VWAjcasG9mY7H+rqT0+Qgh
	 Pd5i6DBmxwU2gVChzz/cY0BO7TOqgRRI55mr+JFPfuj26msItcwKZWP1GouD9J+vDo
	 CGHc7RqzFGaonKO/4XHrw3u40L4Hr4wLwlMgN/iI4XnrtgjmLjwuxPIFDaiW++TG6B
	 Jgoo18DL8AvuOxyc6IsKLxiDP+jz8RAxxfWzSxUyuWZKXLCe9+03o/SFAtDtYuPwOg
	 8KoHrmPTxC8OQ==
From: cel@kernel.org
To: jlayton@kernel.org,
	neilb@suse.de,
	okorniev@redhat.com,
	Dai.Ngo@oracle.com,
	tom@talpey.com,
	trondmy@kernel.org,
	anna@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	Yang Erkun <yangerkun@huawei.com>
Cc: Chuck Lever <chuck.lever@oracle.com>,
	linux-nfs@vger.kernel.org,
	netdev@vger.kernel.org,
	yangerkun@huaweicloud.com,
	liumingrui@huawei.com
Subject: Re: [PATCH v2 0/4] nfsd/sunrpc: cleanup resource with sync mode
Date: Wed,  8 Jan 2025 13:52:00 -0500
Message-ID: <173636224521.14442.15190072674801924828.b4-ty@oracle.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241225065908.1547645-1-yangerkun@huawei.com>
References: <20241225065908.1547645-1-yangerkun@huawei.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

On Wed, 25 Dec 2024 14:59:04 +0800, Yang Erkun wrote:
> After f8c989a0c89a ("nfsd: release svc_expkey/svc_export with
> rcu_work"), svc_export_put/expkey_put will call path_put with async
> mode. This can lead some unexpected failure:
> 
> mkdir /mnt/sda
> mkfs.xfs -f /dev/sda
> echo "/ *(rw,no_root_squash,fsid=0)" > /etc/exports
> echo "/mnt *(rw,no_root_squash,fsid=1)" >> /etc/exports
> exportfs -ra
> service nfs-server start
> mount -t nfs -o vers=4.0 127.0.0.1:/mnt /mnt1
> mount /dev/sda /mnt/sda
> touch /mnt1/sda/file
> exportfs -r
> umount /mnt/sda # failed unexcepted
> 
> [...]

Applied to nfsd-testing, thanks!

[1/4] SUNRPC: introduce cache_check_rcu to help check in rcu context
      commit: 2f55dbe4e2072c9e99298c6f37473778a98c9107
[2/4] nfsd: no need get cache ref when protected by rcu
      commit: c224edca7af028828e2ad866b61d731b5e72b46d
[3/4] SUNRPC: no need get cache ref when protected by rcu
      commit: 1b10f0b603c066d81327c163a23c19f01e112366
[4/4] nfsd: fix UAF when access ex_uuid or ex_stats
      commit: 2530766492ec7726582bcde44575ec3ff7487cd2

--
Chuck Lever


