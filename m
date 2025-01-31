Return-Path: <linux-nfs+bounces-9814-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A43DA24446
	for <lists+linux-nfs@lfdr.de>; Fri, 31 Jan 2025 21:59:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AEB1316660E
	for <lists+linux-nfs@lfdr.de>; Fri, 31 Jan 2025 20:59:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A35F01B87E9;
	Fri, 31 Jan 2025 20:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eddydhFm"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EBAA154420
	for <linux-nfs@vger.kernel.org>; Fri, 31 Jan 2025 20:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738357181; cv=none; b=t0XsgvXTOON09t2O9m2m74inXWEDj7LMYsIHDlTsHAbIK0K7pyL9sXJq9w2r88OoZm1AM7Y7FnFrEuukBVTDxwDtBb4XJPnyYEsn7LJiorNfzOg7UnUW36fHSKkNEptNw0nFVh8dvNgnRmQPYpF71I6YDdQYKIIymi/JcyFY7Fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738357181; c=relaxed/simple;
	bh=AV2gsHIfBX0M6Yuyvq9r/LV5AK88O2U3tpt/xEcBBYc=;
	h=From:Date:MIME-Version:Content-Type:To:Message-ID:In-Reply-To:
	 References:Subject; b=Id9w7+QmSEmCpfl4VK3V/Eju0NjRFXgJd0g1nlujNd/gpbVQ9KlAQONrhQSU7U+fpfseAsyEEQghvVzYyPY6YczqtDhTJlPgi/jpm2a09hZVyGae3ymSzLX3pu2HDqno1vAH11ekH+gmb5Egyl7lQrRNT57i4HRpB0tUrR+a2BI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eddydhFm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0E51C4CED1;
	Fri, 31 Jan 2025 20:59:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738357180;
	bh=AV2gsHIfBX0M6Yuyvq9r/LV5AK88O2U3tpt/xEcBBYc=;
	h=From:Date:To:In-Reply-To:References:Subject:From;
	b=eddydhFmMs9ebcSamnP9UDABolzQBRny+xxr/lUnjSdZfMJfrLavmAxDtRNzbDik+
	 +wJvP9mKdzJUd7sg0I2BvVpsjOVFdLqjlJapTkObSO5YMh9a4obDkWwUOk++IxYNnS
	 1ec+oFT22Mr589tw1gRDXpZ3mdNO1HxAw4VzRzIni2NXNaPiBRNox2ZKpbujuJIf99
	 NKmPt7FlfDUS8tlHJ8PeFmDiiqWYMpwt/uGlgR0ledo0JmtldVDXCW8KHJlSYWWxXX
	 By/Rw6Et0v/gelMvAm69+KpAbF+IZsrN8OoLFQcBFOQV5dSFy6lbYRVgqLsrRcB2Pg
	 lIVrf9vKUTulw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 77A4E380AA7D;
	Fri, 31 Jan 2025 21:00:08 +0000 (UTC)
From: Chuck Lever via Bugspray Bot <bugbot@kernel.org>
Date: Fri, 31 Jan 2025 21:00:08 +0000
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: trondmy@kernel.org, cel@kernel.org, jlayton@kernel.org, 
 linux-nfs@vger.kernel.org, anna@kernel.org
Message-ID: <20250131-b217973c4-73c4d9937b47@bugzilla.kernel.org>
In-Reply-To: <20250131-b217973c3-c25737af37f7@bugzilla.kernel.org>
References: <20250131-b217973c3-c25737af37f7@bugzilla.kernel.org>
Subject: Re: CFI failure at nfsd4_encode_operation+0xa2/0x210 [nfsd]
X-Bugzilla-Product: File System
X-Bugzilla-Component: NFSD
X-Mailer: bugspray 0.1-dev

Chuck Lever writes via Kernel.org Bugzilla:

(In reply to Rin Cat from comment #3)
> I no longer had this issue when I moved to LTS 6.6 kernel from LTS 6.1, so I
> am not sure where it was fixed.

If you want to find the specific commit that resolved the issue, the best you can do is bisect between v6.1 and v6.13, applying the flow integrity check at each step. That shouldn't be more than two dozen steps.

I don't think we would have explicitly fixed a flow integrity bug, our current tooling does not point those out.

 
> And for Jeff, CFI (Control Flow Integrity) is LLVM/clang supported runtime
> type check.
> If a pointer or function argument is different or incompatible with the
> declared type, a kernel warning or panic will be triggered depending on the
> configuration.
> 
> https://clang.llvm.org/docs/ControlFlowIntegrity.html
> 
> A CFI failure most likely means some runtime bugs.

If v6.1.127 still triggers a CFI warning, it would help if you could bisect as described above and report the result here.

Are you able to regularly test upstream kernels or even this branch:

https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git/log/?h=nfsd-testing

View: https://bugzilla.kernel.org/show_bug.cgi?id=217973#c4
You can reply to this message to join the discussion.
-- 
Deet-doot-dot, I am a bot.
Kernel.org Bugzilla (bugspray 0.1-dev)


