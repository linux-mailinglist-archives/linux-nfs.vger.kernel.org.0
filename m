Return-Path: <linux-nfs+bounces-21083-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +JFJLO7m62nNSgAAu9opvQ
	(envelope-from <linux-nfs+bounces-21083-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 24 Apr 2026 23:55:58 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 373354639DC
	for <lists+linux-nfs@lfdr.de>; Fri, 24 Apr 2026 23:55:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3DF463026C10
	for <lists+linux-nfs@lfdr.de>; Fri, 24 Apr 2026 21:55:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A28D63469E7;
	Fri, 24 Apr 2026 21:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q3iwOR6T"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FCA3336884;
	Fri, 24 Apr 2026 21:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777067709; cv=none; b=Ac2S98mkSKBQr98Ep2mKTgciGO6+lhN6pdf9G3hv6AxzlxvXNgxdytU2F01F6lVbjsbSxU9bwzCPlkjduNt1HA22Nv0ky3yMwJL1e7ztii5//VRRLuODF8UIgKgMoqiUuLEuZ/yLu9kQN10Mqnft43uFjhxTf9XzEl7EGOppmKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777067709; c=relaxed/simple;
	bh=WwqhaKRzyLwDBc/BmjTkLQS/GvJJj/6lkk1u5/uSd+o=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=P+GsIYinrtbYUr9tbJ7QHXBkPf6e5NhIpgiZJFAcFbmtJajoOR+hC6gEeWrH0sYMBSxPljK7xA9jBxY4QsNIID+UZ7/2DpwoZoatLg/ib9mSY13bg/ewfR37rFZFF/vlUodfCe8CpT+Zda+8PhgbwRNsaloaXIlmos1RyMbKq1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q3iwOR6T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DA72C19425;
	Fri, 24 Apr 2026 21:55:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777067709;
	bh=WwqhaKRzyLwDBc/BmjTkLQS/GvJJj/6lkk1u5/uSd+o=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=q3iwOR6TGN5HteTEZC864vjkDtVeB675//PhZka9LQNkJKQ/4V4xMKpEtnfoz3tnO
	 Yz+EdbyzSVlrQbtwxiZnlSJpP7P8vI6aGfDOSpoo20dKPAw8L9gpZD51hJeT0lN8IJ
	 eTcunibM8jaaUks/czQUm9G13q4TPo5eLG9HgnjOXPJp5gBHx6B53ZolgBRxvqOxpw
	 nzRBVC6YgbX/aZn3ftDjVYZCDBwhdjGoHWwrRiEb8TU3TZl7+g12j5dX1qshbzwWe+
	 AZ8MyJhY38yhDkSn+3W3dYuj/Ce9r4+xKKdwJ7VvZsTVW7kTotPfZqrcRvrT6cBwBx
	 sANpB0zdAtD5A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7D27538119C3;
	Fri, 24 Apr 2026 21:54:30 +0000 (UTC)
Subject: Re: [GIT PULL] Please pull NFS client updates for Linux 7.1
From: pr-tracker-bot@kernel.org
In-Reply-To: <b54851930d1daf66fabe718d0a02df850047ecd8.camel@kernel.org>
References: <b54851930d1daf66fabe718d0a02df850047ecd8.camel@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <b54851930d1daf66fabe718d0a02df850047ecd8.camel@kernel.org>
X-PR-Tracked-Remote: git://git.linux-nfs.org/projects/trondmy/linux-nfs.git tags/nfs-for-7.1-1
X-PR-Tracked-Commit-Id: e6614b88d59d110ee1a80ed0826e34f24dd35c96
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b85900e91c8402bedc1db14e6d293e26f25d30d4
Message-Id: <177706766918.1729850.18425767130401490527.pr-tracker-bot@kernel.org>
Date: Fri, 24 Apr 2026 21:54:29 +0000
To: Trond Myklebust <trondmy@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
X-Rspamd-Queue-Id: 373354639DC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21083-lists,linux-nfs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[linux-nfs];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pr-tracker-bot@kernel.org,linux-nfs@vger.kernel.org]

The pull request you sent on Fri, 24 Apr 2026 16:48:45 -0400:

> git://git.linux-nfs.org/projects/trondmy/linux-nfs.git tags/nfs-for-7.1-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b85900e91c8402bedc1db14e6d293e26f25d30d4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

