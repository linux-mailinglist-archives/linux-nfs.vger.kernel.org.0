Return-Path: <linux-nfs+bounces-10775-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CA125A6E276
	for <lists+linux-nfs@lfdr.de>; Mon, 24 Mar 2025 19:36:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B979E170453
	for <lists+linux-nfs@lfdr.de>; Mon, 24 Mar 2025 18:35:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4FDA264A9C;
	Mon, 24 Mar 2025 18:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZM4oro6E"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBB512627E9;
	Mon, 24 Mar 2025 18:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742841272; cv=none; b=rXll7NLrQhN8R+Ommvn8oB7g20oAgGTHz7xz37Gm+Fx6dG39Nuv8ysAe8eg6PudR6jqnudKSFt2QF8fZERY37GAG+vSVJD/Ov0Bz3QA8UhalHzbtvG+tRPtbWGdI8+mFpNXiywk6Rs5fvdxLxUNGM26cnNKqXLZBNYdRHk/RqRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742841272; c=relaxed/simple;
	bh=E7wE7Zfr2UgeP/wCoYmCqCYllLwld537lZmNxxG1V1c=;
	h=From:Date:MIME-Version:Content-Type:To:Message-ID:In-Reply-To:
	 References:Subject; b=JfURNQbHyvLVeL2qRIRfA49CWH2KIsfrouriT02oEKv4Ebi164Vg35lApCoD7Qa3RyVNUBJBepcPnfsWecAIqrxwXnZh+sQDRQ8FA1vyOqL+D4gj/wbCdVNV3tQdHplfxep6C2pZ1/zpXUGxYoVccY7rt5Lps+qRIGHdYfBd2+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZM4oro6E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3521BC4CEDD;
	Mon, 24 Mar 2025 18:34:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742841272;
	bh=E7wE7Zfr2UgeP/wCoYmCqCYllLwld537lZmNxxG1V1c=;
	h=From:Date:To:In-Reply-To:References:Subject:From;
	b=ZM4oro6Ek6cStq+liiajJ5k13TJbNXvgKC0BMcqVkFlOVknjdmgKjnzt9FDDwQ0y4
	 aXg5sxNrRRGt2+AcmKIx1C3AlvZsytEJmtufHntefnM+qvG+wJwf3VfG5NQu1Epk0l
	 O/TsebgdnIlq84ftnLKPmGM6j84CvlAPOARj7ANfKAQ7L9P1skOlO8iiqHHyXQPm6t
	 X+T3fKbOkq04zPDQvajuPhHNBsKg71BPjrRIsDIlcTkm4OtxGJJh7Y4BO/CV/rIpBa
	 Qcw8Fg2WlXG6cOUSpPPU15j4b79yWjgyWAp4Jbh1TofHHMN+aBh99lMWpl4vsAjwl3
	 +6vaFudaUp4Lw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 761E1380664D;
	Mon, 24 Mar 2025 18:35:09 +0000 (UTC)
From: Chuck Lever via Bugspray Bot <bugbot@kernel.org>
Date: Mon, 24 Mar 2025 18:35:11 +0000
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: iommu@lists.linux.dev, robin.murphy@arm.com, anna@kernel.org, 
 chuck.lever@oracle.com, jlayton@kernel.org, trondmy@kernel.org, 
 linux-nfs@vger.kernel.org, cel@kernel.org
Message-ID: <20250324-b219865c6-abed7f2a8789@bugzilla.kernel.org>
In-Reply-To: <20250313-b219865c0-2a34cbc6e249@bugzilla.kernel.org>
References: <20250313-b219865c0-2a34cbc6e249@bugzilla.kernel.org>
Subject: Re: NFS Server Issues with RDMA in Kernel 6.13.6
X-Bugzilla-Product: File System
X-Bugzilla-Component: NFSD
X-Mailer: bugspray 0.1-dev

Chuck Lever writes via Kernel.org Bugzilla:

No progress. It looks like a long term structural problem that we won't be able to address quickly.

It would be good to confirm that the issue is indeed contention in the IOVA allocator. Compiling with LOCK_STAT enabled and looking in /proc/lock_stat would give some indication that Robin's theory in on the right track.

Meanwhile I plan to ask the RDMA gurus if there is an improvement that can be made in the svcrdma implementation to help address the problem. If you need immediately relief, reducing the NFSD thread count might help.

View: https://bugzilla.kernel.org/show_bug.cgi?id=219865#c6
You can reply to this message to join the discussion.
-- 
Deet-doot-dot, I am a bot.
Kernel.org Bugzilla (bugspray 0.1-dev)


