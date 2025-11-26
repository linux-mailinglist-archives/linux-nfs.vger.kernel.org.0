Return-Path: <linux-nfs+bounces-16725-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D0D22C8801A
	for <lists+linux-nfs@lfdr.de>; Wed, 26 Nov 2025 05:01:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5CCC8352A4D
	for <lists+linux-nfs@lfdr.de>; Wed, 26 Nov 2025 04:01:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4CA430E0FD;
	Wed, 26 Nov 2025 04:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e/yDTgjQ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8031E30DECE;
	Wed, 26 Nov 2025 04:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764129663; cv=none; b=qqLww9XXZHMdI+cqL+a+m8nqLTUtznRIYQZh+jFJNmDB1Ak4fcxzTBnuktjkY6co25Q/9XfFvy5JdpWuckG7m/ax8e5iWALvNZiMOLl7CKzGiF3m9/QkNUDKLO+q/+wu1XxQLPTBTX9HTLdVozyxP9ANkXpUnucYba29aMTAnEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764129663; c=relaxed/simple;
	bh=u7WhcPoQgtAyom6NzBpHZKJ3S3T/moATUT+y2VUtn54=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=iEqG11iZOF0+ZD8gwofKR0tQilCuIi+1CwU89HcLxfmVZQOREx5j1js2I6o+CFz3abOUZ4yyp53vHQqYVOxy0Xki2HE9iDEQUb3Im0obVrC2AY6M8my4jv3S9POhnIrC5qybre1NURZ5b2xsXwVo7VmT9jvZ0ckLgu7KGi64/Co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e/yDTgjQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1B69C116C6;
	Wed, 26 Nov 2025 04:01:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764129662;
	bh=u7WhcPoQgtAyom6NzBpHZKJ3S3T/moATUT+y2VUtn54=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=e/yDTgjQbXQSTAwyvE7FgkPAE2NIAdDvmLJBzvDj2W4EsmGcJ1JBQOVZielSccaMJ
	 p19DNUWBtAWq3Yd1PWsRpkeFy4K8CankCXsikmYaNgOZuLfXirt5L+c6pr739oOFIR
	 HQJsf/uiDkobuySu0JXq16xpvXr8XkvIWMiZjt40xaj0p8lzbM3r5iPuYH7WRNr7MI
	 eKWylT03jbRbrXXBhBJs1o74rHp1RdRXPPGLEl5gxZ2RI+/GDMXi+lfU/zjPXWYvwr
	 JLL5nOydA1W7L8+CIeb4NrwLOnZaY60R3CDjK2f9Jyk3gxx959tMwpfDT5iMbwVE2B
	 BLLbukuAI37MQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33D99380AA73;
	Wed, 26 Nov 2025 04:00:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/2] tools: ynl-gen: regeneration comment +
 function
 prefix
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176412962400.1513924.8908884768543220332.git-patchwork-notify@kernel.org>
Date: Wed, 26 Nov 2025 04:00:24 +0000
References: <20251120174429.390574-1-ast@fiberby.net>
In-Reply-To: <20251120174429.390574-1-ast@fiberby.net>
To: =?utf-8?b?QXNiasO4cm4gU2xvdGggVMO4bm5lc2VuIDxhc3RAZmliZXJieS5uZXQ+?=@codeaurora.org
Cc: donald.hunter@gmail.com, kuba@kernel.org, Jason@zx2c4.com,
 andrew+netdev@lunn.ch, anna@kernel.org, antonio@openvpn.net,
 arkadiusz.kubalewski@intel.com, arve@android.com, cmllamas@google.com,
 brauner@kernel.org, chuck.lever@oracle.com, Dai.Ngo@oracle.com,
 daniel.zahka@gmail.com, dsahern@kernel.org, davem@davemloft.net,
 dw@davidwei.uk, edumazet@google.com, geliang@kernel.org,
 gregkh@linuxfoundation.org, hare@kernel.org, jacob.e.keller@intel.com,
 jlayton@kernel.org, jiri@resnulli.us, jdamato@fastly.com,
 joelagnelf@nvidia.com, kernel-tls-handshake@lists.linux.dev,
 dualli@google.com, linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org,
 maco@android.com, martineau@kernel.org, matttbe@kernel.org,
 almasrymina@google.com, mptcp@lists.linux.dev, neil@brown.name,
 netdev@vger.kernel.org, okorniev@redhat.com, pabeni@redhat.com,
 sd@queasysnail.net, skhawaja@google.com, horms@kernel.org, sdf@fomichev.me,
 surenb@google.com, tkjos@android.com, tom@talpey.com, trondmy@kernel.org,
 vadim.fedorenko@linux.dev, willemb@google.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 20 Nov 2025 17:44:25 +0000 you wrote:
> It looks like these two patches are the last ones needed
> for YNL, before the WireGuard patches can go in.
> 
> These patches was both requested by Jason, during review
> of the WireGuard YNL conversion patchset[1].
> 
> [1] https://lore.kernel.org/r/20251105183223.89913-1-ast@fiberby.net/T/#u
> 
> [...]

Here is the summary with links:
  - [net-next,1/2] tools: ynl-gen: add function prefix argument
    https://git.kernel.org/netdev/net-next/c/17fa6ee35bd4
  - [net-next,2/2] tools: ynl-gen: add regeneration comment
    https://git.kernel.org/netdev/net-next/c/68e83f347266

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



