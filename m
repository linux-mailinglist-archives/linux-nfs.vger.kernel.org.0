Return-Path: <linux-nfs+bounces-8976-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36D7AA064E1
	for <lists+linux-nfs@lfdr.de>; Wed,  8 Jan 2025 19:52:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EAFB3A70E8
	for <lists+linux-nfs@lfdr.de>; Wed,  8 Jan 2025 18:52:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ABDC1F37BB;
	Wed,  8 Jan 2025 18:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TJ5u6syE"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C6981A23B7;
	Wed,  8 Jan 2025 18:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736362327; cv=none; b=L3EQX1BcTUbg1eg4kP8vdAChfIt7/+0iqShfJ0y+HBWWVq3G2QLLmL4ksBbcuPeddXpYdkZvh8t+EIOJbfgo+HbSrLp/AsOx5MguLzt0T6lDfwOKPbdQDDHh7QzRgajs/hwVw7BTDvUVHslddnXLz12t4U0szQ+PGX6dlLKmxxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736362327; c=relaxed/simple;
	bh=0HvcmNnJXWX8ZP5yUzIJuodN6QVVSsF8K+F4vvQA5NQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gPP1wV7IdIrk5kd0OWT8HnHpZI46nZZsl3GBf2afvKzSo8YTZyFOX8vK7Ro0dWe0zCCfVsexMbrNvMeLx37PG1Fpzmwi/hp5MIaGK6/lrKUEKBm6tJGorhS+X3TT57LxXqUeHkjbT6Fs48q8sxrxfQhBvNJQuMhFu5bhcsIbbEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TJ5u6syE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB7ACC4CED3;
	Wed,  8 Jan 2025 18:52:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736362326;
	bh=0HvcmNnJXWX8ZP5yUzIJuodN6QVVSsF8K+F4vvQA5NQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TJ5u6syEbwO3g4EXk7nzJZzyr6alDqPxdEPwNCgNprtZAfL0bCVz3IZIPJUYQFt3e
	 k3Z3ibcMla3ZU8m2xiGY544RpWO4IW527ZiKl2UebF4Oofho21bDPPRm9wUJIX76Os
	 KCuia6tquR3TWn5PmXOYOqdD5d4N4LPMu6wIs7vx313X3SDdP33Grnc+NnZiTKJMM3
	 wW88h7nwKhm6nMgIkK8VQt0ROO9nc9vz3MusOjuM1Ezhfz+MPHakY+Pt7Q0k8vctWA
	 2ipDNG+s8hdn9m+Rjp7KzCAaMULYkPf15PuH0gqiu/oENmc5zFEuiht88pOPfiR5ZJ
	 Z6u3HVc3STrBg==
From: cel@kernel.org
To: trondmy@kernel.org,
	anna@kernel.org,
	jlayton@kernel.org,
	neilb@suse.de,
	okorniev@redhat.com,
	Dai.Ngo@oracle.com,
	tom@talpey.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	Li Lingfeng <lilingfeng3@huawei.com>
Cc: Chuck Lever <chuck.lever@oracle.com>,
	linux-nfs@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	liujian56@huawei.com,
	yukuai1@huaweicloud.com,
	houtao1@huawei.com,
	yi.zhang@huawei.com,
	yangerkun@huawei.com,
	lilingfeng@huaweicloud.com
Subject: Re: [PATCH] sunrpc: clean cache_detail immediately when flush is written frequently
Date: Wed,  8 Jan 2025 13:51:58 -0500
Message-ID: <173636224524.14442.18042606814897132165.b4-ty@oracle.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241227083353.4125224-1-lilingfeng3@huawei.com>
References: <20241227083353.4125224-1-lilingfeng3@huawei.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

On Fri, 27 Dec 2024 16:33:53 +0800, Li Lingfeng wrote:
> We will write /proc/net/rpc/xxx/flush if we want to clean cache_detail.
> This updates nextcheck to the current time and calls cache_flush -->
> cache_clean to clean cache_detail.
> If we write this interface again within one second, it will only increase
> flush_time and nextcheck without actually cleaning cache_detail.
> Therefore, if we keep writing this interface repeatedly within one second,
> flush_time and nextcheck will keep increasing, even far exceeding the
> current time, making it impossible to clear cache_detail through the flush
> interface or cache_cleaner.
> If someone frequently calls the flush interface, we should immediately
> clean the corresponding cache_detail instead of continuously accumulating
> nextcheck.
> 
> [...]

Applied to nfsd-testing, thanks!

[1/1] sunrpc: clean cache_detail immediately when flush is written frequently
      commit: 33c4c54ed3b912edca4c2cd9ae3dd0492ab9fc4c

--
Chuck Lever


