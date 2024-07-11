Return-Path: <linux-nfs+bounces-4797-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B33D92E4BE
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Jul 2024 12:30:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15BF7282A81
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Jul 2024 10:30:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B935158D94;
	Thu, 11 Jul 2024 10:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jg5MwVVA"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62003131E4B;
	Thu, 11 Jul 2024 10:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720693829; cv=none; b=RUGeeUVLoIC/OgTBo+I6gZAzizOb0vPUAHs0N7eu7FGeXXOP31GLGiV2sBVkxcqibL20utDrmP40wgvtkQrVMJ4KKAQyvKLqYM04Y7g0Q8ITqQkirFLASn3GUcRnpgg4Ty8nRU7fPBM4b84sTkEPa9cQo1j4PweQMmGz4xPXUsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720693829; c=relaxed/simple;
	bh=MWbxo5hX/d3HKrLdJECLxxEFxt+vVxRq//De0VGcD0Y=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=b1MKJdU1eDO+5hb2dP7KeTnEj3gzJP2poLHxj0eGsrQdYlQB+kjr92fK929EhjtsjvHdEr9IHsEui0INyGzrb0KBWWUBCPKwLRK5C/VLPp064a9gD2eptoBsmHYpjJz6y1zJxPatnnzpCN3P+3liBMzYIzhsbB035SZxSfKFubo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jg5MwVVA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id EADEEC4AF07;
	Thu, 11 Jul 2024 10:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720693829;
	bh=MWbxo5hX/d3HKrLdJECLxxEFxt+vVxRq//De0VGcD0Y=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=jg5MwVVA9aTov7OM4BsOV3kjfQxg4+01qXup6nnITs3NS6O8fBQ3zBoWgD3bnj41t
	 SVpynfUF+9q5D+n2GCvDJDQqnZuOboSH+z2rlHuMY1M5c1Ac5jqVOl6fF9zmvnoY1P
	 0JDZdnibMcomRTtUKt9j3ZJ1CJEKSrKdfk+Ce9X5mRrWjDo17PG1eZat4CylM7mAXX
	 r3jPj45uMHRlyZ9zYMypTkAsRe0ucOuI7S6LSjyzCWIu18JppsBZfMimGbG6ASo4RP
	 h4v29wNLjxgrUG6pjn61OzpgDnKLbsWyyNSwcD9sLKS7yZIqaFq2f1RN2aYDsWR+zU
	 RkGEC9u53L4eQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DA16DC43153;
	Thu, 11 Jul 2024 10:30:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3 resend] net,
 sunrpc: Remap EPERM in case of connection failure in xs_tcp_setup_socket
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172069382888.18320.4145482834911828098.git-patchwork-notify@kernel.org>
Date: Thu, 11 Jul 2024 10:30:28 +0000
References: <9069ec1d59e4b2129fc23433349fd5580ad43921.1720075070.git.daniel@iogearbox.net>
In-Reply-To: <9069ec1d59e4b2129fc23433349fd5580ad43921.1720075070.git.daniel@iogearbox.net>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: kuba@kernel.org, netdev@vger.kernel.org, linux-nfs@vger.kernel.org,
 usiegl00@gmail.com, neilb@suse.de, trondmy@kernel.org, anna@kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu,  4 Jul 2024 08:41:57 +0200 you wrote:
> When using a BPF program on kernel_connect(), the call can return -EPERM. This
> causes xs_tcp_setup_socket() to loop forever, filling up the syslog and causing
> the kernel to potentially freeze up.
> 
> Neil suggested:
> 
>   This will propagate -EPERM up into other layers which might not be ready
>   to handle it. It might be safer to map EPERM to an error we would be more
>   likely to expect from the network system - such as ECONNREFUSED or ENETDOWN.
> 
> [...]

Here is the summary with links:
  - [net,v3,resend] net, sunrpc: Remap EPERM in case of connection failure in xs_tcp_setup_socket
    https://git.kernel.org/netdev/net/c/626dfed5fa3b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



