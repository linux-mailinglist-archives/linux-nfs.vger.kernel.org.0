Return-Path: <linux-nfs+bounces-10228-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 01FA3A3E4F6
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Feb 2025 20:21:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D99CE17FE84
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Feb 2025 19:21:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33CD020B1F1;
	Thu, 20 Feb 2025 19:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KH2Tdof4"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DCEC15A858;
	Thu, 20 Feb 2025 19:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740079280; cv=none; b=ncmtyvGoce7QNF7fChgNyJjGRs01yO/Reom957tcYUfSz5yLUQwbVWgkNTL1nOYVBJg2NYz4YNng4F1vmapeY+soD9X3WXQDeSV9LoE60DhKyfGQWnkJ3kDCYTJhgMIZ08BTDV3/12IWyjLNxhLBArS3K/2RvRFOK/JHCuCi7x0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740079280; c=relaxed/simple;
	bh=xijanZ/YLwO40IngxhirU15paKuTo6pFuPDfECza+w0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EAk5F064Lzh9OyTEZPatXwovchR6damyyaqweC1hD1fqH/0hA8QWwl0bmsg28STsU7X6lX69c7gg+HJO9L6Z+S82XuKivbxu+s0hd5bA3BVqcwu/SE5QDywiYFjRuZ1YxcmLC2nOpsFgD7mcAS32MaUL5wtA8JTqfmKFrFi9ovo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KH2Tdof4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A395AC4CED1;
	Thu, 20 Feb 2025 19:21:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740079279;
	bh=xijanZ/YLwO40IngxhirU15paKuTo6pFuPDfECza+w0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KH2Tdof45LYDDz/wAUkn438Yb+egn8SQ53QcjMgQm895HOBsId/GD21f/iNKLLmo9
	 Z3O9lE5gtKcTPlY/Rdw84Ja54wkEkssdLPtHtMpNM9cGBW+U+W7J5EPrr5lHfRKOpk
	 i4ZBBWQsSa4LiGRBkzd3PwOXvX2F9ryhFwDiznYfKbLmbQXY40o99PnlkpZhmjVZzY
	 xojaPhu6NS+g4BxLvKojkXGo2E8kP+y4HmDbMkG95nmMSGQPWN2Wr0sAsqZ2T8yDlm
	 JGI9jowaEcPKxXKo8muqMyTQ9fZshxFcei7l2F8T0Y0VHeb5WLrGsCGlBodUkb/Vtk
	 uYS0gFZt+bDbA==
From: cel@kernel.org
To: Neil Brown <neilb@suse.de>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>,
	Li Lingfeng <lilingfeng3@huawei.com>,
	linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/5] nfsd: don't allow concurrent queueing of workqueue jobs
Date: Thu, 20 Feb 2025 14:21:15 -0500
Message-ID: <174007920440.104075.11286565001428092466.b4-ty@oracle.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250220-nfsd-callback-v2-0-6a57f46e1c3a@kernel.org>
References: <20250220-nfsd-callback-v2-0-6a57f46e1c3a@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

On Thu, 20 Feb 2025 11:47:12 -0500, Jeff Layton wrote:
> While looking at the problem that Li Lingfeng reported [1] around
> callback queueing failures, I noticed that there were potential
> scenarios where the callback workqueue jobs could run concurrently with
> an rpc_task. Since they touch some of the same fields, this is incorrect
> at best and potentially dangerous.
> 
> This patchset adds a new mechanism for ensuring that the same
> nfsd4_callback can't run concurrently with itself, regardless of where
> it is in its execution. This also gives us a more sure mechanism for
> handling the places where we need to take and hold a reference on an
> object while the callback is running.
> 
> [...]

Applied to nfsd-testing, thanks! This series replaces:

https://lore.kernel.org/linux-nfs/20250218135423.1487309-1-lilingfeng3@huawei.com/

Review is still open.

[1/5] nfsd: prevent callback tasks running concurrently
      commit: 9a03a9d82410bdb758a6b342689e0c235bba94f1
[2/5] nfsd: eliminate cl_ra_cblist and NFSD4_CLIENT_CB_RECALL_ANY
      commit: 743fda103062626c828dbac774716e718a74f81b
[3/5] nfsd: replace CB_GETATTR_BUSY with NFSD4_CALLBACK_RUNNING
      commit: d2d94554567f486eba111e953e75745eca09bee3
[4/5] nfsd: move cb_need_restart flag into cb_flags
      commit: 355f1ec5ce21ab324d9b3978d2d5abe6d0c84024
[5/5] nfsd: handle errors from rpc_call_async()
      commit: d0f1ba5ed270fbda06248ef8af822a9e14708ee1

--
Chuck Lever


