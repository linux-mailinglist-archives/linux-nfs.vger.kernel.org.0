Return-Path: <linux-nfs+bounces-7000-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FB77998438
	for <lists+linux-nfs@lfdr.de>; Thu, 10 Oct 2024 12:55:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A76F928490B
	for <lists+linux-nfs@lfdr.de>; Thu, 10 Oct 2024 10:55:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EC791BF324;
	Thu, 10 Oct 2024 10:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LlM+ZMIL"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69DD71BD027
	for <linux-nfs@vger.kernel.org>; Thu, 10 Oct 2024 10:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728557704; cv=none; b=t4+GuCaGImGE9JSPzUh2Gz2vy6bVw7fniL2zIXnCbC2oAPzjvRQLKbW/Dr41SVZjLweJLrRl6wwMU07FqW96j+exIoQWem6lpNCa/J4RH6i5+t445lbM+nmmUWg5SqGGGarfj0DuFSGLOOmuT4BRVV5oCmbvj+I+WPvYlB70tt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728557704; c=relaxed/simple;
	bh=dg/3emVtSgysgforZXh2l883gxppKTGQYOtxdDlLHvA=;
	h=From:Date:MIME-Version:Content-Type:To:Message-ID:In-Reply-To:
	 References:Subject; b=D28cqiNTaJHVRCfJhoulIbEn0iWlMTrOd1sh4/lS6fBpusSJFlEPvU8hJQSAWliB09nOf1xu/lAST2OUNi4mrzCHVN7+1BwPhxIkB2vYTDv9QHFvjaBHAK5C2sF0lJN4oPDqroSkDfumhnSF2NxWwNy0FUO/ZjsmVxgWt8wr4Ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LlM+ZMIL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D86DC4CEC5;
	Thu, 10 Oct 2024 10:55:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728557704;
	bh=dg/3emVtSgysgforZXh2l883gxppKTGQYOtxdDlLHvA=;
	h=From:Date:To:In-Reply-To:References:Subject:From;
	b=LlM+ZMILK6hcGLi6ojE7Sf383S2jmFShcDGBqvN5lvo281oa53HCMWc4U2/CHtjnv
	 zFmgtqhLgqxY7kQX2giVTw3aW9FOgrlqNajHOMYs6BZxNgha/vPCh2aevlCimEKV02
	 bbKs1YlvsPJ+RkDZz8SWy8GkffRmNapeIRxrYrwfGvgAzzrEWAJHzLD34tXIv7WTTJ
	 X/sWYYu8biJKxIbomaCPOVwSsyFvun1/ZlUp1RXVK8e9hTRLHCnCOFLm5qQUF+K4GG
	 WC3aSn2ClCMV6KnII+f8F8xP3qpnHC2a/5/4s3jEhqfg2OPNOWrSJVwvKnfNd7Eiaz
	 TByAi7HWLJfsQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 785EB3803263;
	Thu, 10 Oct 2024 10:55:09 +0000 (UTC)
From: "The Linux kernel's regression tracker (Thorsten Leemhuis) via Bugspray Bot" <bugbot@kernel.org>
Date: Thu, 10 Oct 2024 10:55:08 +0000
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: anna@kernel.org, linux-nfs@vger.kernel.org, jlayton@kernel.org, 
 trondmy@kernel.org, cel@kernel.org
Message-ID: <20241010-b219370c3-aca1c896e307@bugzilla.kernel.org>
In-Reply-To: <20241010-b219370c0-bd6df2a482ac@bugzilla.kernel.org>
References: <20241010-b219370c0-bd6df2a482ac@bugzilla.kernel.org>
Subject: Re: link error while compiling localio.c
X-Bugzilla-Product: File System
X-Bugzilla-Component: NFSD
X-Mailer: bugspray 0.1-dev

The Linux kernel's regression tracker (Thorsten Leemhuis) writes via Kernel.org Bugzilla:

FWIW, another report with similar symptoms can be found here:
https://lore.kernel.org/all/D4OUJRP8YWRM.ATQ7KASTYX5H@mbosch.me/T/#u

View: https://bugzilla.kernel.org/show_bug.cgi?id=219370#c3
You can reply to this message to join the discussion.
-- 
Deet-doot-dot, I am a bot.
Kernel.org Bugzilla (bugspray 0.1-dev)


