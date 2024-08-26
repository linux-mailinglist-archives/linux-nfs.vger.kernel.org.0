Return-Path: <linux-nfs+bounces-5780-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F3F695F744
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Aug 2024 19:00:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F024B282F11
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Aug 2024 17:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EB063B782;
	Mon, 26 Aug 2024 17:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a2by0JeI"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F068E10A0D;
	Mon, 26 Aug 2024 17:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724691629; cv=none; b=TIchx5atzOEZgCAxayyGkJei1JKD6RjX/LIUlf9dE9c2xOmj706griKEtWYq/Kz8wcsaXwXw9wRsq+/mBJgz1FeplMyk555RYoO+FHHonSdx2lePyEnKICYCfpzJpCml5GdxxyUYGSaCSP3NFpbhLk5veB0HRJK184MC7VY5E2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724691629; c=relaxed/simple;
	bh=doOdWMqY3vxQVLC7/mSNh1GfH3I58afGjOrUy2ZiPgQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=pPzoeg2A9ivVpkQ9ccDlfN+rP/KUe360qQ5piEQbD6oVYLgCNqhtBMh6bOU5JB4Qqa1O6icEadAqZo3kEo2uYyoQK89P9685PjaHyIiM6NRcFLjyJ7wsl7s3nJH7aI0VoPX/U3ykN4wDNZit699FdFUTW2W4FhdsKGvwl/vNoA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a2by0JeI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77687C4FF67;
	Mon, 26 Aug 2024 17:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724691628;
	bh=doOdWMqY3vxQVLC7/mSNh1GfH3I58afGjOrUy2ZiPgQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=a2by0JeIDJ6W8C4t3xO65+9lLCYq4kKhcVyr4oGl+oWFKZ461G9FttZHaP5Xm9Nst
	 +cukq2A8+WuWA2+jNnt4++zeBYU3r7r0pb0OUtSFakBksDi4vidJTSQESL1AzYwAvs
	 RIrYW8zKiPuhUN8N6e7uvvtHsVz6F2JxWANtTxgOumpzYtZyLVrYehp30Wng1pfFV8
	 JjhefHCT2M2i/jr1sa3ppsACgT43Jjl+5cSeOcUPLqp3s0Shl/FRuqaae5LjNV+MaP
	 fAnZ+edWM6LAW5CbhVxbfeZOs1Jstcnd5wOGvJOHkihnFjPSLx8DMQH6w44WYhVzzo
	 FYF6b9Y1FJcTQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE38B3822D6D;
	Mon, 26 Aug 2024 17:00:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/8] Some modifications to optimize code readability
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172469162851.70473.1457098908791177308.git-patchwork-notify@kernel.org>
Date: Mon, 26 Aug 2024 17:00:28 +0000
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

This series was applied to netdev/net-next.git (main)
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
    https://git.kernel.org/netdev/net-next/c/b4985aa8e312
  - [net-next,4/8] libceph: use min() to simplify the code
    (no matching commit)
  - [net-next,5/8] net: remove redundant judgments to simplify the code
    (no matching commit)
  - [net-next,6/8] ipv6: mcast: use min() to simplify the code
    https://git.kernel.org/netdev/net-next/c/26549dab8a46
  - [net-next,7/8] tipc: use min() to simplify the code
    https://git.kernel.org/netdev/net-next/c/a18308623ce3
  - [net-next,8/8] SUNRPC: use min() to simplify the code
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



