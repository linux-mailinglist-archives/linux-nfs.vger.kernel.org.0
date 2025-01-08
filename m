Return-Path: <linux-nfs+bounces-8967-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FB21A05058
	for <lists+linux-nfs@lfdr.de>; Wed,  8 Jan 2025 03:13:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42909162FB7
	for <lists+linux-nfs@lfdr.de>; Wed,  8 Jan 2025 02:13:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DEB21802AB;
	Wed,  8 Jan 2025 02:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RXy+QmPT"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA43D17A586;
	Wed,  8 Jan 2025 02:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736302213; cv=none; b=hPFIEh6kOMFYTmj9n7Ap7u8Nexk9OYRuJkwnC9qtdK0JbvLdk19eplwCIe0anP8p56ZBP4HkSMmYlyoMN6LzQ4sHypliPJYQUDG7q0EGYD/p2p0YYDoulql8N9sNHa2z2u0DcrOwyi6ErLQJm/PHwq3sxGREfET2VozdaPLWDHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736302213; c=relaxed/simple;
	bh=PyNLGb87fM5j3RwEvBHNOpHM0ei0XHaeqk5+XtqhgdA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=RLihVNIhGGcxpt+VgNYKzOgpmsk+w9dgUijnBddUxjXyX7Dh2Slgy7UteQ2RCtv8v9Kmtj9qvWlWAXwArkHo5iRlxFGX4CCxBLEL5+vtajp5lE48dC99WSfQf1sfBadKp3im7VxGuDgJdNPOVdV6ps0/2sEmVxdrVDt0Ep2MxE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RXy+QmPT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76462C4AF49;
	Wed,  8 Jan 2025 02:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736302212;
	bh=PyNLGb87fM5j3RwEvBHNOpHM0ei0XHaeqk5+XtqhgdA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=RXy+QmPTu1A2P19gR1ZZEPSPTuTs7lSo/7yBYZyocJMOErKz6Cy+lTFEXPEd/Qyq/
	 EVnbbU9u8qwNxtfwFWX5SVCDVA+uWqEZ4QaDEeaTJOPVragsHfLnrdT/yzsKYbXNxk
	 nXEIEvLBM9d/9NVnYDJJD8OiOcblHmgHTo0xRWVjgJ35XE2WQ+Co3fIgCaco94xqFF
	 sYVmvqtn/0FG+oPkNzza+17XA7GGUmWRUghPj4fdpwKuOwIVNs32rYhi3CSgvOmhJE
	 pS5YPPajmLP01mQI8W6kTKaF2R6yO6B8X3GPWCOqmIhYue2j9hDSFJRPTLcpudFUNJ
	 gfsvCCZfVbDTg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAE58380A97E;
	Wed,  8 Jan 2025 02:10:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] tls: Fix tls_sw_sendmsg error handling
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173630223374.165659.14185740433768228798.git-patchwork-notify@kernel.org>
Date: Wed, 08 Jan 2025 02:10:33 +0000
References: <9594185559881679d81f071b181a10eb07cd079f.1736004079.git.bcodding@redhat.com>
In-Reply-To: <9594185559881679d81f071b181a10eb07cd079f.1736004079.git.bcodding@redhat.com>
To: Benjamin Coddington <bcodding@redhat.com>
Cc: borisp@nvidia.com, john.fastabend@gmail.com, kuba@kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 horms@kernel.org, netdev@vger.kernel.org, linux-nfs@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat,  4 Jan 2025 10:29:45 -0500 you wrote:
> We've noticed that NFS can hang when using RPC over TLS on an unstable
> connection, and investigation shows that the RPC layer is stuck in a tight
> loop attempting to transmit, but forever getting -EBADMSG back from the
> underlying network.  The loop begins when tcp_sendmsg_locked() returns
> -EPIPE to tls_tx_records(), but that error is converted to -EBADMSG when
> calling the socket's error reporting handler.
> 
> [...]

Here is the summary with links:
  - tls: Fix tls_sw_sendmsg error handling
    https://git.kernel.org/netdev/net/c/b341ca51d267

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



