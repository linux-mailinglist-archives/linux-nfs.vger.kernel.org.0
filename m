Return-Path: <linux-nfs+bounces-9812-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7441EA24310
	for <lists+linux-nfs@lfdr.de>; Fri, 31 Jan 2025 19:59:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E27BB167D1F
	for <lists+linux-nfs@lfdr.de>; Fri, 31 Jan 2025 18:59:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D950C1F03F5;
	Fri, 31 Jan 2025 18:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E1G751gl"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B493A1F94A
	for <linux-nfs@vger.kernel.org>; Fri, 31 Jan 2025 18:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738349982; cv=none; b=SDbdksVemdE+eQzblHrDAscNPJSM+2REWgGpSEKftirB2YKCYVf1FaYqKjZFkTDrNjEwMBQ42Q4mw8/6HC3z4/OqHPo8zIAbU5aZZRXXqy08D8r3OTUvwi73GD4Kb7b1uEu7A/cZm3RvQooMvQaX9KMKEbIyeMcL6Q9VeZrZvXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738349982; c=relaxed/simple;
	bh=Apaz8U8Ducddg5DtLdn4yfXO4P15D5HRctHrCBGq290=;
	h=From:Date:MIME-Version:Content-Type:To:Message-ID:In-Reply-To:
	 References:Subject; b=ZP+Ku0oLSuzkAFMUa2BgROR3vxnaMo1rFMql0gKSDAHF/yFKwDQeXQ5EVZIsgBGTJk6XG44k3Pe5tXexVD4DlUK8qL9sDwls2Yg/yAH4HyKgXJMVj49mCOVVwgzAeY5O9+sTaMiEAAGdwXLdR6ZXxwPf8j5F+m5UYqYlJN2Hjjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E1G751gl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B15BC4CED1;
	Fri, 31 Jan 2025 18:59:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738349982;
	bh=Apaz8U8Ducddg5DtLdn4yfXO4P15D5HRctHrCBGq290=;
	h=From:Date:To:In-Reply-To:References:Subject:From;
	b=E1G751glX3oy30Rx81w8FFt/3stspUBwyXAnCPM2z6gTXADY/JAcq7eQYplL0Dm3+
	 HmUZc4MG7itLDQxsrsREUjd+KgW4wGrgVSp7qZesddbDq5JhBDVdOZVq8sPcsK3UA9
	 lYZox6F/h21wAPNLaBMqZgaDxCbeaym0wvMLCvyVLHmbVt+/xm1AGJRZe3tZDloete
	 O6F+Qci/qw2gxl1d0YybPcUXmaL9Es9H7pOtDvEt0l4gxR6eteJ6oBxDq+EI8BHeG7
	 Etz5ExBRCJ8CB+13i7F+PncVaid2R0s6rHFnyH24jZqYSy1nGkDJt35puYha+gtryU
	 xAGNV/DZsaosQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B3406380AA7D;
	Fri, 31 Jan 2025 19:00:09 +0000 (UTC)
From: Jeff Layton via Bugspray Bot <bugbot@kernel.org>
Date: Fri, 31 Jan 2025 19:00:06 +0000
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: linux-nfs@vger.kernel.org, jlayton@kernel.org, cel@kernel.org, 
 trondmy@kernel.org, anna@kernel.org
Message-ID: <20250131-b217973c2-d0433ff901d2@bugzilla.kernel.org>
In-Reply-To: <20250131-b217973c0-a2ac608a1bf9@bugzilla.kernel.org>
References: <20250131-b217973c0-a2ac608a1bf9@bugzilla.kernel.org>
Subject: Re: CFI failure at nfsd4_encode_operation+0xa2/0x210 [nfsd]
X-Bugzilla-Product: File System
X-Bugzilla-Component: NFSD
X-Mailer: bugspray 0.1-dev

Jeff Layton writes via Kernel.org Bugzilla:

Also, I'm unfamiliar with CFI. What does a CFI failure mean?

View: https://bugzilla.kernel.org/show_bug.cgi?id=217973#c2
You can reply to this message to join the discussion.
-- 
Deet-doot-dot, I am a bot.
Kernel.org Bugzilla (bugspray 0.1-dev)


