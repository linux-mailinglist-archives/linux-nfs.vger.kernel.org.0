Return-Path: <linux-nfs+bounces-10772-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A2C92A6E044
	for <lists+linux-nfs@lfdr.de>; Mon, 24 Mar 2025 17:54:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4FD63ABB74
	for <lists+linux-nfs@lfdr.de>; Mon, 24 Mar 2025 16:54:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F365E263F20;
	Mon, 24 Mar 2025 16:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u+9CaZxF"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB5B433C5;
	Mon, 24 Mar 2025 16:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742835272; cv=none; b=m3OfNlQjhblkruAG/2MeA/2NpllQpAufk3Gf+bSZZe7+t/6CgFATd4P7ph7+7setRR63JoGBOPgYwqEGS5u1vtlFPCmnH1zUY20gKCXeAJBVIMf32xjDgcXxsqI2AnAspq9YoNTMAmE/gqlSttX4NIY7mHX6uV2lMf24gUV8P3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742835272; c=relaxed/simple;
	bh=5I9LbMBxstUgKyeIA6cfBMkjqUMcx4Rgcbe/l4wXkfY=;
	h=From:Date:MIME-Version:Content-Type:To:Message-ID:In-Reply-To:
	 References:Subject; b=nS3UbaFFtao+zYk3i9rYx0IH6x7yhrXOHbIO2JzReOEDkxQ4QDz9itHGT51cnHfY/IA5N7dVfHiODU1dGzssvaLvTqczA44P9UIDGyfSM1hEpXVxUKSHbdDsnt6oOQe3LhE5dgzb7L1snf3Mq0wkNSkxV+Ak5ZmdwinRCZDiDvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u+9CaZxF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 404DAC4CEE9;
	Mon, 24 Mar 2025 16:54:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742835272;
	bh=5I9LbMBxstUgKyeIA6cfBMkjqUMcx4Rgcbe/l4wXkfY=;
	h=From:Date:To:In-Reply-To:References:Subject:From;
	b=u+9CaZxFsNJ3y8Whwh3pNSyZ57Z1Hr/gF3ubLtx1xUAJyg+y71oIQYA7XDLVe+DrI
	 zETkGcXi0AAbP3SUgVEGGDu+A9q4SrCJYYTLHDCSDlQrCheLkwlViGxar3vrm2jQwv
	 m6SgwgGp+uk6FS6gikhY3UyIUKhvFlOTv7LkE25ADyhNH6tTcUdB5E3I1tcXnZxIt2
	 fYfisORcsUdNcBs44SP1JSckgsG+Bx/uBndoGNKqeRJkqFyFtW+cFByjFL19uzlV+t
	 Sr/SzcGkxlOReWLnrnigosRR1vDK3iPcP83TRvqp8RxnGloawhhkDAQsK5MxRPc0Hy
	 9baItlu4v213A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7B923380664D;
	Mon, 24 Mar 2025 16:55:09 +0000 (UTC)
From: Lucas via Bugspray Bot <bugbot@kernel.org>
Date: Mon, 24 Mar 2025 16:55:10 +0000
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: linux-nfs@vger.kernel.org, iommu@lists.linux.dev, trondmy@kernel.org, 
 chuck.lever@oracle.com, cel@kernel.org, robin.murphy@arm.com, 
 anna@kernel.org, jlayton@kernel.org
Message-ID: <20250324-b219865c5-7644f6e6d9a5@bugzilla.kernel.org>
In-Reply-To: <20250313-b219865c0-2a34cbc6e249@bugzilla.kernel.org>
References: <20250313-b219865c0-2a34cbc6e249@bugzilla.kernel.org>
Subject: Re: NFS Server Issues with RDMA in Kernel 6.13.6
X-Bugzilla-Product: File System
X-Bugzilla-Component: NFSD
X-Mailer: bugspray 0.1-dev

Lucas writes via Kernel.org Bugzilla:

Apologies for the silly question, I’m not a kernel developer. Is there any update on this issue, or is the fix included in the latest 6.14 kernel? If there’s anything I can do to help, such as running more tests, please let me know.

View: https://bugzilla.kernel.org/show_bug.cgi?id=219865#c5
You can reply to this message to join the discussion.
-- 
Deet-doot-dot, I am a bot.
Kernel.org Bugzilla (bugspray 0.1-dev)


