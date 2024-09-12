Return-Path: <linux-nfs+bounces-6413-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 704AE976EC9
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Sep 2024 18:33:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A977B24C1F
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Sep 2024 16:33:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF9B0186E53;
	Thu, 12 Sep 2024 16:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JOM5TRfb"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F6D71865ED;
	Thu, 12 Sep 2024 16:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726158794; cv=none; b=W0ziwlSp1SPyQg4S8W68Zexgr+DKSHjp6SQdpkbGsJI4qnzUB3SNk7/f5gx/EfhxjAU9vim2+le2FlW3g5gzi/Ut9jEpp7zC24ETxMjYvZc0Yl+77ZiIaF1aOtwarU0WsKTTclU6ZpP/HOXdXL7H8DEbSpeR+9oGolCI3uYGtSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726158794; c=relaxed/simple;
	bh=RJ/rsTqfJsi7HX8JrXAOqj7jxzrHlUkrE0IsT+BeVyA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=CrIxc7RMfiocu1qsb3YNv3nrtR4bVgAEajgy4D90Ji9o5QG5XaLp9i/tGQF5yLjY2rpRlNknYA1vpecCpE88YIg0VvLjkh1N3GE64i+H9FAVWQcjKi6xD+uigb3iwJPFWGJ4S/ChLiDrBv4XbbRnfc4YZWy1/kZFFOW90HLUuX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JOM5TRfb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18877C4CEC3;
	Thu, 12 Sep 2024 16:33:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726158794;
	bh=RJ/rsTqfJsi7HX8JrXAOqj7jxzrHlUkrE0IsT+BeVyA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=JOM5TRfbOc71NFRgtcbZxpD33gcCjGOVLAuzmdJJEW/yma+eULX1K8/epnJsyqQsk
	 EJWk155bp7m2fzvv8OioW24quF768VahV8l5cMA5wsS1sE/eg8wyAath9HrtCQQHlb
	 JbNW84AvpCU/6D1BR1hbYitHTjeNPrLVoyZnKVfaQ3NdDvDDWuAimeVMiwhjfEkj0S
	 tmrO2VgyRFUfnpHQpN2lxlDb50RP6zmOOBdctgWtW9DKT/DYdhk68w+fGM1ZFAMYwq
	 Y145sncCVHNeUW4xPJHhUwFsttlj6x1fktg5572C8FAswQ5vt57VDqRn0ACWI3lDax
	 pjtMy2JmtOeqQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70D233822D1B;
	Thu, 12 Sep 2024 16:33:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/8] Some modifications to optimize code readability
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <172615879499.1648954.6225809739644290566.git-patchwork-notify@kernel.org>
Date: Thu, 12 Sep 2024 16:33:14 +0000
References: <20240822133908.1042240-1-lizetao1@huawei.com>
In-Reply-To: <20240822133908.1042240-1-lizetao1@huawei.com>
To: Li Zetao <lizetao1@huawei.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, marcel@holtmann.org, johan.hedberg@gmail.com,
 luiz.dentz@gmail.com, idryomov@gmail.com, xiubli@redhat.com,
 dsahern@kernel.org, trondmy@kernel.org, anna@kernel.org,
 chuck.lever@oracle.com, jlayton@kernel.org, neilb@suse.de,
 okorniev@redhat.com, Dai.Ngo@oracle.com, tom@talpey.com, jmaloy@redhat.com,
 ying.xue@windriver.com, linux@treblig.org, jacob.e.keller@intel.com,
 willemb@google.com, kuniyu@amazon.com, wuyun.abel@bytedance.com,
 quic_abchauha@quicinc.com, gouhao@uniontech.com, netdev@vger.kernel.org,
 linux-bluetooth@vger.kernel.org, ceph-devel@vger.kernel.org,
 linux-nfs@vger.kernel.org, tipc-discussion@lists.sourceforge.net

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 22 Aug 2024 21:39:00 +0800 you wrote:
> This patchset is mainly optimized for readability in contexts where size
> needs to be determined. By using min() or max(), or even directly
> removing redundant judgments (such as the 5th patch), the code is more
> consistent with the context.
> 
> Li Zetao (8):
>   atm: use min() to simplify the code
>   Bluetooth: use min() to simplify the code
>   net: caif: use max() to simplify the code
>   libceph: use min() to simplify the code
>   net: remove redundant judgments to simplify the code
>   ipv6: mcast: use min() to simplify the code
>   tipc: use min() to simplify the code
>   SUNRPC: use min() to simplify the code
> 
> [...]

Here is the summary with links:
  - [net-next,1/8] atm: use min() to simplify the code
    (no matching commit)
  - [net-next,2/8] Bluetooth: use min() to simplify the code
    (no matching commit)
  - [net-next,3/8] net: caif: use max() to simplify the code
    https://git.kernel.org/bluetooth/bluetooth-next/c/b4985aa8e312
  - [net-next,4/8] libceph: use min() to simplify the code
    (no matching commit)
  - [net-next,5/8] net: remove redundant judgments to simplify the code
    (no matching commit)
  - [net-next,6/8] ipv6: mcast: use min() to simplify the code
    https://git.kernel.org/bluetooth/bluetooth-next/c/26549dab8a46
  - [net-next,7/8] tipc: use min() to simplify the code
    https://git.kernel.org/bluetooth/bluetooth-next/c/a18308623ce3
  - [net-next,8/8] SUNRPC: use min() to simplify the code
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



