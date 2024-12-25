Return-Path: <linux-nfs+bounces-8779-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CD979FC602
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Dec 2024 17:13:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DC35188316A
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Dec 2024 16:13:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6C19136345;
	Wed, 25 Dec 2024 16:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HAD+kPeL"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C95EC133;
	Wed, 25 Dec 2024 16:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735143227; cv=none; b=cwzHDFvHsGVUxKvCvEzQSsqUqfq+gGHUKWzJ+bVNibj4+efyz3rM2CHG7tRHyxDHtBDiwlTUNtdnHC5nx+gIAxwwBL+FZHY4VO66Z2o6grhTJilIRCz5C+4LmiMOkVt+D1BBycsXw5yNaxWeXJG0DV21NWV+Rb4cKa+U5mPcgbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735143227; c=relaxed/simple;
	bh=PUH0feLN6gqVKJ4LGtINXDg83RtvQRvU98FutZOhZZw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Au8pCyU0eaCAcJJB8i7eC31exAE3qxaPTWYeDkw0uyWUCs95zibcoiU3l2YGrGU3kSwezsNqZaDWkRRP1UIJpyIa8jN2VRr/sawVjiSLN7Priz2G/1mWJq14LZdOd605NKScThenM24mXYH5YMFFB23bmKUQchvNuBLHcpUfqNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HAD+kPeL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CF58C4CECD;
	Wed, 25 Dec 2024 16:13:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735143227;
	bh=PUH0feLN6gqVKJ4LGtINXDg83RtvQRvU98FutZOhZZw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HAD+kPeLMcKly5lPiJxDXCSDUIyvvA+XlW2gL6DUyRxu20T4X7Z7+rOZyq3v1UoW2
	 SgJ8z9SF1N/FRZQ2mVfA8BRPnx0L9p2cikfQYnh2bnUbhmG+Prrn0KVGfhv4kRSpQJ
	 7oYovGUnSmM+m3p5B+85NissBbTH7WsRxeOeFWnGYb9Tfk1C07mIVH738hnrd+RU82
	 13juTrylHTE7FZ3bZWeTHbX0dt6B/aHu6X3vb5zTDMp8XCDW3JCAJeXfMbd4ci5uLZ
	 cs69NliLPhvFDtpIeFlVpF4lbVirGj2zRf9eR6YjsQiVjiO/OcNpoZKxk+M/KPzEws
	 IERf0H04L0hsQ==
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
Date: Wed, 25 Dec 2024 11:13:41 -0500
Message-ID: <173514289446.295832.15514335628536963233.b4-ty@oracle.com>
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

Applied to nfsd-testing for v6.14, thanks!

I'm unsure whether 2/4 and 3/4 need Fixes: tags. Based on the patch
descriptions, these appear to be pre-requisite patches rather than
actual fixes.

However, I'm guessing that 4/4 will apply and build without 2/4 and
3/4 applied, but there will be operational problems. So explicit
Fixes: tags in 2/4 and 3/4 are probably necessary to get a properly
working backport.

This is a case where I would rather have manual backporting with
a full CI run rather than just slapping these patches on the LTS
kernels and hoping for the best.

[1/4] SUNRPC: introduce cache_check_rcu to help check in rcu context
      commit: 401fd94cb21c978403077d611bdc311dc8376f9d
[2/4] nfsd: no need get cache ref when protected by rcu
      commit: 3d32486aa35bf4b99edbfc27538b24fadebd7f75
[3/4] SUNRPC: no need get cache ref when protected by rcu
      commit: 9f5fc67903b5709c4334bf33764d6fbf0ceb05b4
[4/4] nfsd: fix UAF when access ex_uuid or ex_stats
      commit: 8fa5adbee5ab904ea282da183ece664a67db2b2b

--
Chuck Lever


