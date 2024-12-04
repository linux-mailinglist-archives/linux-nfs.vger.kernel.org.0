Return-Path: <linux-nfs+bounces-8345-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D4EE9E4010
	for <lists+linux-nfs@lfdr.de>; Wed,  4 Dec 2024 17:50:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0EC5BB3D54A
	for <lists+linux-nfs@lfdr.de>; Wed,  4 Dec 2024 15:45:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1163720C475;
	Wed,  4 Dec 2024 15:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zmf7nUjU"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E13C220C473
	for <linux-nfs@vger.kernel.org>; Wed,  4 Dec 2024 15:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733327093; cv=none; b=iYeGCAK0DJc/0OiPcSczR9FUb6ikOQqJIf/nmj3yfsJo7ZhrXbhaPaW4nFhk3MmIQQcmxYuawo5o3bAd1QXnb7C5BUJ5RdzqAGsRnmVL/rqhm62HeiqbDoJyuo7e4ksPATdIpZ5oCVq8rXcvlNkTnVdq+fSE18S3xORmlst52ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733327093; c=relaxed/simple;
	bh=aIg7fJ5RRoGMNBqDyN5XWHbOwaVM4vi6cZgSa2beE6I=;
	h=From:Date:MIME-Version:Content-Type:To:Message-ID:In-Reply-To:
	 References:Subject; b=AWoGfto+jbCiQSvAJwxbxaUC+CxNcR/vTlua7OkJ3Fu4cCmn5HUh6BVkp+94A8q/SUcTA+SzvX8OZFE1EF3lk3aX5UPkwZ3suDyeJX21sfAbPvgrP3Sh9j2Ex+pjKgmstSdNcpn5gaaymiHZ3eRlmivXO2oHGbjsbhEwhJxSuiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zmf7nUjU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C562C4CECD;
	Wed,  4 Dec 2024 15:44:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733327092;
	bh=aIg7fJ5RRoGMNBqDyN5XWHbOwaVM4vi6cZgSa2beE6I=;
	h=From:Date:To:In-Reply-To:References:Subject:From;
	b=Zmf7nUjURMZOaQsr9ntC6/YCQ/DobdtqMlIiSeDyDvQBgP06rDpLcRb5uD1m5RhMZ
	 6vrG72Tfy8m3+SL0hqIzcnGNlNuE+7rY5wa1V9A47F11ixT0gVIH1shpgE9nF/3mQW
	 WcaZaBv/XWRAoqFTEDcXUmpC38Z76/MQR9hW5TlT8ZouQ60E4nhDyBx4W9VY6N4zi/
	 ys/mkJJE3h/5XYopBYmKKWZw+1a2gfSu5ZeDO2AaHLdGn80AnvKPataf9qUJrdPvat
	 JCOEMwc9AROf1dKZ9iVokOHNQxgnlF+QnEGsB8AYijDVjmuBtL5+Fx1XThhdEeZoQs
	 BP/7YvUaqNrtw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F021E3806658;
	Wed,  4 Dec 2024 15:45:07 +0000 (UTC)
From: Jeff Layton via Bugspray Bot <bugbot@kernel.org>
Date: Wed, 04 Dec 2024 15:45:07 +0000
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: linux-nfs@vger.kernel.org, jlayton@kernel.org, trondmy@kernel.org, 
 cel@kernel.org, anna@kernel.org
Message-ID: <20241204-b219550c4-eb90fb494c92@bugzilla.kernel.org>
In-Reply-To: <20241203-b219550c0-abf5589a5df5@bugzilla.kernel.org>
References: <20241203-b219550c0-abf5589a5df5@bugzilla.kernel.org>
Subject: Re: deploying both NFS client and server on the same machine
 trigger hungtask
X-Bugzilla-Product: File System
X-Bugzilla-Component: NFSD
X-Mailer: bugspray 0.1-dev

Jeff Layton writes via Kernel.org Bugzilla:

Li Lingfeng's analysis looks basically correct to me, though I think the nfsd_mutex is mostly a red-herring here.

The client holds the shrinker rwsem and is trying to write back data. The server is trying to unregister a shrinker as part of server shutdown and has almost certainly stopped responding to requests at that point. The client is using hard RPCs, so it's going to retry the writeback indefinitely while holding the shrinker mutex, which will block server shutdown.

I don't see a great way to fix this right offhand, though I wonder if localio might help mitigate this problem.

View: https://bugzilla.kernel.org/show_bug.cgi?id=219550#c4
You can reply to this message to join the discussion.
-- 
Deet-doot-dot, I am a bot.
Kernel.org Bugzilla (bugspray 0.1-dev)


