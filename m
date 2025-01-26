Return-Path: <linux-nfs+bounces-9635-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E41CA1CDE7
	for <lists+linux-nfs@lfdr.de>; Sun, 26 Jan 2025 20:01:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D20553A7722
	for <lists+linux-nfs@lfdr.de>; Sun, 26 Jan 2025 19:01:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FE1319CC34;
	Sun, 26 Jan 2025 18:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NtP3JkSc"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 461A919CC0E;
	Sun, 26 Jan 2025 18:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737917951; cv=none; b=hrInWXdaTnL0DFdRlb8AAd65cNa8HHTXO41MV7eP8kXXceWOM02s4dBOvPyNlfQxufK3o8ssTvmArld+84+MKjutXe61xLsxPe0fm/t9h4FCNOvcbRHmPNSiYiykpHgtI3+0Z1uMs1gf+fPlhvlO1g1P5gxnjlTOCJML5RyDhBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737917951; c=relaxed/simple;
	bh=9PrvMRy79bRpb9GeV722iPZCaEFyv14luhBHqpsMDqk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dVGPlfMeFOL3Pi6lnAhW461eaWSUbD93vcTTwbBbPgCXbqTCcEKSASUfwbQxDNJevzg19PiuU2/BakJSZQuQB1IX/pZvM9Tu4/n2bAU80cp9SXPl5wmWTS35unIiQAgDuTLpjr+qztIasS9mUcV/kKOOoMmI5sAegVRwzjOOmqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NtP3JkSc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55103C4CED3;
	Sun, 26 Jan 2025 18:59:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737917950;
	bh=9PrvMRy79bRpb9GeV722iPZCaEFyv14luhBHqpsMDqk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NtP3JkSc6CJ2mdG5mZozIDnglmA+9Z5BQXftRvNPw6Am3tHYU5Sa6TULQahk1D6b3
	 4c++0egZSOvVMYSyrvLIJHicYsKubxZrUxWKVtTmF5yd5jDQSR5+k5GOU7dIRRu5xg
	 TrmegPKmuQ9MCEq+MvSr9oPGVubtSfD/0zTxM+Q3+QnJa+2ohZWFeakl9qFbOgj0MF
	 7VjYK7jYlzENKJVl3MxwSdiMDSlOi8AUohX1o5fqbRKRzflJx+MZU5VuqykqUYi4j7
	 ft1pwm+86E/DFBN/XA11Z0YgLsYCBKWqn9LIHI++VH8qAc/PtrPYMv7IduvayrmSrJ
	 g+XlWBRj3dg0w==
From: cel@kernel.org
To: jlayton@kernel.org,
	neilb@suse.de,
	okorniev@redhat.com,
	Dai.Ngo@oracle.com,
	tom@talpey.com,
	Trond.Myklebust@netapp.com,
	rick.macklem@gmail.com,
	zhangjian496@huawei.com,
	linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Li Lingfeng <lilingfeng3@huawei.com>
Cc: Chuck Lever <chuck.lever@oracle.com>,
	yukuai1@huaweicloud.com,
	houtao1@huawei.com,
	yi.zhang@huawei.com,
	yangerkun@huawei.com,
	lilingfeng@huaweicloud.com
Subject: Re: [PATCH v2] nfsd: clear acl_access/acl_default after releasing them
Date: Sun, 26 Jan 2025 13:59:06 -0500
Message-ID: <173791790453.1645.17131731130789235526.b4-ty@oracle.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250126094722.738358-1-lilingfeng3@huawei.com>
References: <20250126094722.738358-1-lilingfeng3@huawei.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

On Sun, 26 Jan 2025 17:47:22 +0800, Li Lingfeng wrote:
> If getting acl_default fails, acl_access and acl_default will be released
> simultaneously. However, acl_access will still retain a pointer pointing
> to the released posix_acl, which will trigger a WARNING in
> nfs3svc_release_getacl like this:
> 
> ------------[ cut here ]------------
> refcount_t: underflow; use-after-free.
> WARNING: CPU: 26 PID: 3199 at lib/refcount.c:28
> refcount_warn_saturate+0xb5/0x170
> Modules linked in:
> CPU: 26 UID: 0 PID: 3199 Comm: nfsd Not tainted
> 6.12.0-rc6-00079-g04ae226af01f-dirty #8
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
> 1.16.1-2.fc37 04/01/2014
> RIP: 0010:refcount_warn_saturate+0xb5/0x170
> Code: cc cc 0f b6 1d b3 20 a5 03 80 fb 01 0f 87 65 48 d8 00 83 e3 01 75
> e4 48 c7 c7 c0 3b 9b 85 c6 05 97 20 a5 03 01 e8 fb 3e 30 ff <0f> 0b eb
> cd 0f b6 1d 8a3
> RSP: 0018:ffffc90008637cd8 EFLAGS: 00010282
> RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffffff83904fde
> RDX: dffffc0000000000 RSI: 0000000000000008 RDI: ffff88871ed36380
> RBP: ffff888158beeb40 R08: 0000000000000001 R09: fffff520010c6f56
> R10: ffffc90008637ab7 R11: 0000000000000001 R12: 0000000000000001
> R13: ffff888140e77400 R14: ffff888140e77408 R15: ffffffff858b42c0
> FS:  0000000000000000(0000) GS:ffff88871ed00000(0000)
> knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000562384d32158 CR3: 000000055cc6a000 CR4: 00000000000006f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> 
> [...]

Applied to nfsd-testing, thanks!

[1/1] nfsd: clear acl_access/acl_default after releasing them
      commit: d5595d284a1c022b341bab2f66a631ae13eaee14

--
Chuck Lever


