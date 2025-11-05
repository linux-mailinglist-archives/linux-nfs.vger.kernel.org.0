Return-Path: <linux-nfs+bounces-16044-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DAE5C35A30
	for <lists+linux-nfs@lfdr.de>; Wed, 05 Nov 2025 13:25:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EE72D4E4366
	for <lists+linux-nfs@lfdr.de>; Wed,  5 Nov 2025 12:25:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73E3730FF28;
	Wed,  5 Nov 2025 12:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jLHlJmeM"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F6CF3081AF
	for <linux-nfs@vger.kernel.org>; Wed,  5 Nov 2025 12:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762345533; cv=none; b=UvZnEtZMd0ydgJVcchD35RFNc44gXDt3WYQuavaGXrHLzJabH4kPrIhUr/+OUedMRA0afGolCTcOEVToL+8GTs2YEIlxobm6R/VZlkFhxDCD9BS8M0Oh1tbyLWrJ+sqRnv94oMRWm5GgtzaUQNh7x4+SkR580bveLPP7MjwUg3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762345533; c=relaxed/simple;
	bh=vKqJ3CMrc1x1tDuJLcoC4bHbW74L3nNAr1IO0GHjls4=;
	h=From:Date:MIME-Version:Content-Type:To:Message-ID:In-Reply-To:
	 References:Subject; b=jlMPTiNusC6O9i3GVCc3sLM8vqAUm3ft2CUhg2W3Bl5zGga5Ne2YP+PKJl9IB3CpzHIGAlwZ1UY8ogjm+rQsfVVtNnVAGLHdOywLrdS0t/Tl5fYZstBxaJoYXEsOOBFEG1SK9hQIHWFu5t3VuQZ5ZdJ9PPg7jvJeDKjNe8namGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jLHlJmeM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBE20C4CEF8;
	Wed,  5 Nov 2025 12:25:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762345532;
	bh=vKqJ3CMrc1x1tDuJLcoC4bHbW74L3nNAr1IO0GHjls4=;
	h=From:Date:To:In-Reply-To:References:Subject:From;
	b=jLHlJmeMoH0dFkzbRohnxGkDq1CaLa1ZZByqVSpepOlQub+hT22V08hPc27auvRCW
	 IE/Ae7B9GMozpiyLvaAjcyfv308uvaNpHj0d90XrSe0zgxRJGAwNyiDHuykOmRbgXz
	 wIkEpClwXXmJ6vtocG/5OrG+R2B7v97cPJvHThvANBFdbSFsqyP8uwhqfsS+H2NVMR
	 2WmFZAn9z6OC4Y1ZAw9fDCTXf7T9JFLs5Zukspce4JwYbBFgBGUWSqhq6rMXJRlCBS
	 8s2UJhn8x5F7toCgu6zR6GdOxRGIz0oYtzn9b40a4KNiD/KdKPPlvi2LuRGO4RRgGA
	 uQEUHIUe5y9KA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 74A9B380AA7D;
	Wed,  5 Nov 2025 12:25:07 +0000 (UTC)
From: Mike-SPC via Bugspray Bot <bugbot@kernel.org>
Date: Wed, 05 Nov 2025 12:25:07 +0000
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: linux-nfs@vger.kernel.org, trondmy@kernel.org, neilb@brown.name, 
 anna@kernel.org, neilb@ownmail.net, cel@kernel.org, jlayton@kernel.org
Message-ID: <20251105-b220745c4-f9376314d23f@bugzilla.kernel.org>
In-Reply-To: <20251104-b220745c0-91170b3b3642@bugzilla.kernel.org>
References: <20251104-b220745c0-91170b3b3642@bugzilla.kernel.org>
Subject: Re: Compile Error fs/nfsd/nfs4state.o - clamp() low limit slotsize
 greater than high limit total_avail/scale_factor
X-Bugzilla-Product: File System
X-Bugzilla-Component: NFSD
X-Mailer: bugspray 0.1-dev

Mike-SPC writes via Kernel.org Bugzilla:

> Have you found a 6.1.y kernel for which the build doesn't fail?

Yes. Compiling Version 6.1.155 works without problems.
Versions >= 6.1.156 aren't.

Regards,
Michael

View: https://bugzilla.kernel.org/show_bug.cgi?id=220745#c4
You can reply to this message to join the discussion.
-- 
Deet-doot-dot, I am a bot.
Kernel.org Bugzilla (bugspray 0.1-dev)


