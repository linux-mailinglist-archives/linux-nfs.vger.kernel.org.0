Return-Path: <linux-nfs+bounces-8233-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D1559DA0A8
	for <lists+linux-nfs@lfdr.de>; Wed, 27 Nov 2024 03:35:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B9B26B22D27
	for <lists+linux-nfs@lfdr.de>; Wed, 27 Nov 2024 02:35:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 551DE4964D;
	Wed, 27 Nov 2024 02:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hMn5DQ5N"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30DFA49641
	for <linux-nfs@vger.kernel.org>; Wed, 27 Nov 2024 02:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732674910; cv=none; b=qk1Xvv5l+vcbmBbFjZHMiqcBQLJ8pwQuAMD23y+T9hrcvigQmuxJU01K4VmcmKYup9/s1IXF31fAg+dqLzRyOml650V5Ik8rFiR0muBmlKOFE/673NEvY43HEzEoiXblbDi2Vr/p2tjHPMGf6xNJax/uc87zrJN1+1g481PL8lQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732674910; c=relaxed/simple;
	bh=1qQhkfiNEetT7WViLyvi3M9lg0nzitaGplFeOgDQw0A=;
	h=From:Date:MIME-Version:Content-Type:To:Message-ID:In-Reply-To:
	 References:Subject; b=ssduY2mNRP67TmBhNwuq75AsEToBfJb8IRK68H9rFpDvwH8gZQhnxo2OfGwgjc2cVmS9nIBPq21xm3I9sXIjrSkskwmiw+TeOAEIozSwAaZrtQOHhq3vj7UfEwuivo1Mffc5p53tFx9WDXv+5SEwzZMU02HeoPDhm212wzvZS2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hMn5DQ5N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9B27C4CECF;
	Wed, 27 Nov 2024 02:35:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732674909;
	bh=1qQhkfiNEetT7WViLyvi3M9lg0nzitaGplFeOgDQw0A=;
	h=From:Date:To:In-Reply-To:References:Subject:From;
	b=hMn5DQ5NNlpeWYYNGLRh4ENV60BcGyTl7gqeP4WBmAUx7r0PdwM3SHBpcvN7x3Hfz
	 JRC6UE4Emb9ncBKHH8+SKWS/iatTyE5PchqqqPCYBARiL+KFvYOWfDz3lpRKFlYG5A
	 0aDte8HFSgfJU5DzMocYIASHtP3wwvto1+Ei2Z+xz/UdzzcwakYt7BJSoCKzYnX3WP
	 2jydfg1oYUcJCbQpYdx5LgBTRFVTroWDSwGmlGUda7/lHqLc/+BqexFHXVh4SNJh8v
	 pbt0uvSfV7I8XKbg2Px5IiIaX1h4JEZcrwq4TvP/4cc+M/Eg4jQ9q5t5IXqtA2p/Z5
	 mFDa9eqd0aVFQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB1A63809A00;
	Wed, 27 Nov 2024 02:35:23 +0000 (UTC)
From: Chen Chen via Bugspray Bot <bugbot@kernel.org>
Date: Wed, 27 Nov 2024 02:35:12 +0000
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
Message-ID: <20241127-b219535c5-1e10f03baa3e@bugzilla.kernel.org>
In-Reply-To: <20241127-b219535c0-4d5445e74947@bugzilla.kernel.org>
References: <20241127-b219535c0-4d5445e74947@bugzilla.kernel.org>
Subject: Re: Possible memory leak on nfsd
X-Bugzilla-Product: File System
X-Bugzilla-Component: NFSD
X-Mailer: bugspray 0.1-dev

Chen Chen added an attachment on Kernel.org Bugzilla:

Created attachment 307288
/proc/vmallocinfo

File: vmallocinfo (text/plain)
Size: 170.08 KiB
Link: https://bugzilla.kernel.org/attachment.cgi?id=307288
---
/proc/vmallocinfo

You can reply to this message to join the discussion.
-- 
Deet-doot-dot, I am a bot.
Kernel.org Bugzilla (bugspray 0.1-dev)


