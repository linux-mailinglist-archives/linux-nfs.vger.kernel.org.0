Return-Path: <linux-nfs+bounces-10183-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DD84A3AAD7
	for <lists+linux-nfs@lfdr.de>; Tue, 18 Feb 2025 22:29:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 107097A3D47
	for <lists+linux-nfs@lfdr.de>; Tue, 18 Feb 2025 21:28:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BB411C8622;
	Tue, 18 Feb 2025 21:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eG7mWBDh"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5182214A09E;
	Tue, 18 Feb 2025 21:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739914149; cv=none; b=BGBWH+/LeerAdLV/WvOYkKU9XZxN0BDd3qbHIVMRgUJauBVFoJFV5erFr2tCExTavCm59Wcq9n3oOFJShLWCS3tkXYJhruYflCAXNEitRmORC8USiQgs5pWd8WDyFK1XIx5V88eADQ8WHjeZEHgd84LgcvfzxjE7Ka8UyNIyGWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739914149; c=relaxed/simple;
	bh=iaKnmnqucKWny/xF0IvZsLpUd2J1oUe1+FoSA6prv3g=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=e4LrOfirOWJqVNyUZeTBYtECuVa0mJDJ1sIczzN8WSYIupYCxbJYHGNwocYXjE4BXuuCVChh8O0Z1Y1iwOh+3PEyTooUyekDoRYFisHR+5dbkkwbS51Ud3VoCx+iItbcSyFcGF3VwJHtkRCrbMvQm4PBoJFxUzB6eJJbOxkJ84o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eG7mWBDh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 179F4C4CEE2;
	Tue, 18 Feb 2025 21:29:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739914148;
	bh=iaKnmnqucKWny/xF0IvZsLpUd2J1oUe1+FoSA6prv3g=;
	h=From:Subject:Date:To:Cc:From;
	b=eG7mWBDhSF2AZU7ifc3grfoOqd5PsiusVh+DsFX9KPM4uuTr+3oCD0I0Peu4kcy2J
	 A2AlXYROdWlIb+35rAQN5JYhSkhQg+Ftr3wSgjjzexnPE/svFCW4C/+zUepp2Z60x8
	 l30Qzv+60/bcBxvgmM4DoaMq/gza4Z9cOmoMJpLleprEusEf/A6IeQ4Zfa4XQPxRYZ
	 6Zo8llhuy0ikLyeTe4vzcdUOW3Zspgko9CfF4wdqy9DQNCXTy6i3/ICxlJLjepGz/p
	 A0/fq0v9ZHJ8KCqhfHOb6tanBSM+k5jTmSdRftoxVEyI9pGeNiEDqiCCehE3lLotp0
	 4/6/+RrNaPsaA==
From: Jeff Layton <jlayton@kernel.org>
Subject: [PATCH 0/3] nfsd: don't allow concurrent queueing of workqueue
 jobs
Date: Tue, 18 Feb 2025 16:28:56 -0500
Message-Id: <20250218-nfsd-callback-v1-0-14f966967dd8@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJj7tGcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDI0ML3by04hTd5MScnKTE5GzdNHMj4yQLE0uLZHMLJaCegqLUtMwKsHn
 RsbW1AFCb0WBfAAAA
X-Change-ID: 20250218-nfsd-callback-f723b8498c78
To: Chuck Lever <chuck.lever@oracle.com>, Neil Brown <neilb@suse.de>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>
Cc: Li Lingfeng <lilingfeng3@huawei.com>, linux-nfs@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1693; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=iaKnmnqucKWny/xF0IvZsLpUd2J1oUe1+FoSA6prv3g=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBntPufszyF2GTK3r+3bnWEfFol5ARK2vCPq8BoA
 1Goav/fS7mJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZ7T7nwAKCRAADmhBGVaC
 Fde0D/4n6D28rxUndkBqG6Ku/xmqvbF6BD37225ao5GNmxcyoAC1DKuYtFC1tXS4rxDJaysp2jA
 Nmled7GQLfTZSM5okGFsZuhjy6gbmCf5WIzTReqxOImyFsnCWdCFeruH4JufjmfHY96qZSPiDJ/
 gElDO5uLYeW8TqIYMnrNLafjvvjQR4T9W4BhjxrdWmqpD8AYVtqtHoapStZ8UDHY92+/In1Q8Wg
 GaWB3hIzh+hbXnkiz5DY7+UD2BE/2mIk6qDOgHsPKW0GqOeCE9e0vO2jhmWQ0yx2GUEg35vfF2S
 cR6K4eHvG0uyJ3Fbj24fD5I1jDT4hcnDND9B38t7yzfIJe1e/gGwWGz7r4KZEIYfdNewKtXa7ge
 D0wp7D7cJkhvL0B5v+rWSzjlGtLfHHUgqhOSnKPKrDLOwsUI7KRhTJEwXRvm12ZcSxkt9f0nMGZ
 s1hi9VgJEdt3eO56dqAjZQF87z3hqo0PvKjFH8FUwcDvNc09ju4P5Vxie8iecfVO5pkaMBytemp
 RGdymmcurs2TEDxfno0ZK6Mj69vXFPJow2a121uhlWZ8UDD0l4ZK3GSSRI0dqGtsyKgRDKb51V/
 iUVTVpNOw/cZmF3SVLUV0PDhYvIn39DrTK7HPWg3UhBwjlreE+JYYIg/JAC5GpO3PyxUeRcbrnK
 bXIgitBowNcqjBg==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

While looking at the problem that Li Lingfeng reported [1] around
callback queueing failures, I noticed that there were potential
scenarios where the callback workqueue jobs could run concurrently with
an rpc_task. Since they touch some of the same fields, this is incorrect
at best and potentially dangerous.

This patchset adds a new mechanism for ensuring that the same
nfsd4_callback can't run concurrently with itself, regardless of where
it is in its execution. This also gives us a more sure mechanism for
handling the places where we need to take and hold a reference on an
object while the callback is running.

This should also fix the problem that Li Lingfeng reported, since
queueing the work from nfsd4_cb_release() should never fail. Note that
the patch they sent earlier (fdf5c9413ea) should be dropped from
nfsd-testing before this will apply cleanly.

[1]: https://lore.kernel.org/linux-nfs/20250218135423.1487309-1-lilingfeng3@huawei.com/

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
Jeff Layton (3):
      nfsd: prevent callback tasks running concurrently
      nfsd: eliminate cl_ra_cblist and NFSD4_CLIENT_CB_RECALL_ANY
      nfsd: move cb_need_restart flag into cb_flags

 fs/nfsd/nfs4callback.c | 12 ++++++------
 fs/nfsd/nfs4layouts.c  |  7 ++++---
 fs/nfsd/nfs4proc.c     |  2 +-
 fs/nfsd/nfs4state.c    | 26 +++++++++++---------------
 fs/nfsd/state.h        | 13 ++++++++++---
 fs/nfsd/trace.h        |  2 +-
 6 files changed, 33 insertions(+), 29 deletions(-)
---
base-commit: 4a52e5e49d1b50fcb584e434cced6d0547ddea42
change-id: 20250218-nfsd-callback-f723b8498c78

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>


