Return-Path: <linux-nfs+bounces-8232-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 659A79DA0A6
	for <lists+linux-nfs@lfdr.de>; Wed, 27 Nov 2024 03:35:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ECB15B22C0C
	for <lists+linux-nfs@lfdr.de>; Wed, 27 Nov 2024 02:35:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96F9346447;
	Wed, 27 Nov 2024 02:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e+5OkDXZ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71F3945BE3
	for <linux-nfs@vger.kernel.org>; Wed, 27 Nov 2024 02:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732674907; cv=none; b=Zh3rrhXG+n7eOylKOR4hwOrqC5YGpeoTiDrzvFSYBXxqRpl0dMoWVlFIsKzwEpU19hRMNew3R0OUtNmW0aAFkajOFqhdpTBEz85WigKNAwPkPKu23oWoP6TZAnhyxPJ3Lu2d75vlxhWP5RpQJyjYXf1n1LeoL6wMHf3N1I7sQV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732674907; c=relaxed/simple;
	bh=gvfZq/LCbwODMiInWa75tfvbR/elyfq+/KwbbXASqqU=;
	h=From:Date:MIME-Version:Content-Type:To:Message-ID:In-Reply-To:
	 References:Subject; b=dPTlqV2LJFydz2LgD56ZpnjEGoafrVKfIEhxPIzgYu63Q0zZ7J5bbxsa27St1VjZWxK7Ur+5i7Qz6b7ZR7ci4OCDumrA/N7evUrsbtHfgip+MHaEQeU1RF+4Abci3YN3rZlt9/OtnI8TjgA2Vj3wcwKfGjztUR8BQfK1RSDsy+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e+5OkDXZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08EF7C4CECF;
	Wed, 27 Nov 2024 02:35:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732674907;
	bh=gvfZq/LCbwODMiInWa75tfvbR/elyfq+/KwbbXASqqU=;
	h=From:Date:To:In-Reply-To:References:Subject:From;
	b=e+5OkDXZOqt9hxG6rJtBnbnncvC+UFuJGwTC/hK0CCd31TulSp3kdC5WTU61f8X7U
	 UnkjanlgqPMCus/faXKWja5Bu6wf+XZipSg+hbvm+h93nl4FwiTTNGeuDI2r3sNAlW
	 mbeHKi+u9RdFF493LIHkknMZ4jrKGRas6JKtI6aRu+R9Pw1/tUsM3UubkcihMQjZOn
	 14GjfpOFG2O5Y9rshvBzpU2ukAR/JnR+BKURpjZtgvBx1GRWxP7fR/Gg8bNZRvpoKb
	 h/MUxJizeWiiDaFjcmt4hTU+AT+sc+jURmBq4+4Zd+39sAzF2yplbMnYguBtkfFY0R
	 Kt0KOTsq0fUHA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33E033809A00;
	Wed, 27 Nov 2024 02:35:21 +0000 (UTC)
From: Chen Chen via Bugspray Bot <bugbot@kernel.org>
Date: Wed, 27 Nov 2024 02:35:11 +0000
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: linux-nfs@vger.kernel.org, trondmy@kernel.org, jlayton@kernel.org, 
 anna@kernel.org, cel@kernel.org
Message-ID: <20241127-b219535c4-8ba59037c870@bugzilla.kernel.org>
In-Reply-To: <20241127-b219535c0-4d5445e74947@bugzilla.kernel.org>
References: <20241127-b219535c0-4d5445e74947@bugzilla.kernel.org>
Subject: Re: Possible memory leak on nfsd
X-Bugzilla-Product: File System
X-Bugzilla-Component: NFSD
X-Mailer: bugspray 0.1-dev

Chen Chen added an attachment on Kernel.org Bugzilla:

Created attachment 307287
systemctl status

File: systemctl_status (application/octet-stream)
Size: 4.06 KiB
Link: https://bugzilla.kernel.org/attachment.cgi?id=307287
---
systemctl status

You can reply to this message to join the discussion.
-- 
Deet-doot-dot, I am a bot.
Kernel.org Bugzilla (bugspray 0.1-dev)


