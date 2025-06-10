Return-Path: <linux-nfs+bounces-12261-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB43AAD3A05
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Jun 2025 15:55:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DC7E174652
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Jun 2025 13:55:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 568AC28B3FF;
	Tue, 10 Jun 2025 13:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KzuegkKs"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 329952918F1
	for <linux-nfs@vger.kernel.org>; Tue, 10 Jun 2025 13:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749563750; cv=none; b=f+MJX047PQ31BAcz9mmDqlRWsaGJQD+oWBqPjKzoarKssF/rdSL0JSc1iwmcMByBcV+Vw7WfsYdLnab3G9/feG+bzxuDLxc99Qgb43LMNGN7hoMmV6cF71zKpVVXXa2/hNqyvDcqSglq/Pxm8cIRcuZNVw9BdiOFNqreHpqlIuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749563750; c=relaxed/simple;
	bh=Mj+qdGcr62vvhbLDvExetn2L5opJGPeEDT4Hjl0L33g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h30FyGe3t7RT7KELJCUtVrL0FoWfrPwM2RRX4LBCrpzF+zbaGle/8r2fl4g/i6cDE8SX3zRAJc8yCeq/Ch7tQ0/+o2E1/q3vs1Wx1iNpD8IchLxYyYuLu6hXFfhDUOe6XZs9zB9Kq24qhhAQIFytlgM4agDK3d/Z925szUZWB24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KzuegkKs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF33EC4CEED;
	Tue, 10 Jun 2025 13:55:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749563749;
	bh=Mj+qdGcr62vvhbLDvExetn2L5opJGPeEDT4Hjl0L33g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KzuegkKsOE/Zd4eVs0ENqhFjQ6aoQOxHeb3mKcFeGtNsYJC3EZ6ztn6WHIWVk9Gwq
	 bK3DYUZOmKA96zOFPTc9AecDu4ZWZESWoPRJbpnHG56vV0CPzyOcaZ0jUQvs/sZjBa
	 YdUr3enUUh5boaFKIXF49f+oVUA8oZWrp4uRyJ44PL6ouKantmEIVnQLxIwej1K0zg
	 XQeXAe0Byfsw72DirD62WU7hhT7mV6BCgrrrSwy3uv8cV4Tlwty6FCC3wLvyQTTzVY
	 WK+mj6npMlV5EyyyEFcLa+lOdrKzaZLRw1dxp/IbRJL42pURK28WXAnWhWTYd/VysD
	 Ls8ByabREEGlw==
From: Chuck Lever <cel@kernel.org>
To: trondmy@kernel.org,
	anna@kernel.org,
	jlayton@kernel.org,
	NeilBrown <neil@brown.name>,
	Benjamin Coddington <bcodding@redhat.com>
Cc: Chuck Lever <chuck.lever@oracle.com>,
	linux-nfs@vger.kernel.org
Subject: Re: [PATCH v2] SUNRPC: Cleanup/fix initial rq_pages allocation
Date: Tue, 10 Jun 2025 09:55:45 -0400
Message-ID: <174956369120.56520.67858762469032950.b4-ty@oracle.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <151437c300ca8eb4d8d9a842c9caf167cb32b6ea.1749489592.git.bcodding@redhat.com>
References: <151437c300ca8eb4d8d9a842c9caf167cb32b6ea.1749489592.git.bcodding@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

On Mon, 09 Jun 2025 13:21:56 -0400, Benjamin Coddington wrote:
> While investigating some reports of memory-constrained NUMA machines
> failing to mount v3 and v4.0 nfs mounts, we found that svc_init_buffer()
> was not attempting to retry allocations from the bulk page allocator.
> Typically, this results in a single page allocation being returned and
> the mount attempt fails with -ENOMEM.  A retry would have allowed the mount
> to succeed.
> 
> [...]

Applied to nfsd-testing, thanks!

[1/1] SUNRPC: Cleanup/fix initial rq_pages allocation
      commit: 543bcdc076918b65fe697835314fdd6993b3816e

--
Chuck Lever


