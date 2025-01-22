Return-Path: <linux-nfs+bounces-9496-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 518F2A19A57
	for <lists+linux-nfs@lfdr.de>; Wed, 22 Jan 2025 22:24:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 958163ACB05
	for <lists+linux-nfs@lfdr.de>; Wed, 22 Jan 2025 21:24:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DB751C5D4A;
	Wed, 22 Jan 2025 21:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IUbsm9R+"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59D741B6CE0
	for <linux-nfs@vger.kernel.org>; Wed, 22 Jan 2025 21:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737581083; cv=none; b=J5Xy4LSCBGx/ICUL4PnR4jLk0BeKmdmlIxm90Su+RR73UEBsaPpsqd9BcVKzoc53M8a7K2uOv/1mhF3T7sjtuXfTMw+fvd3SGcJW3PWUhgwETAoLBcJFVYORl7Wd5YcxFKq2AUVC9q7qxN184J/zYPPEYQ8Ez5uzcpWOo4jUFLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737581083; c=relaxed/simple;
	bh=zAiw+BbAfyzmXoes/FvpowLYiA5oXHcquPdp3flTfyo=;
	h=From:Date:MIME-Version:Content-Type:To:Message-ID:In-Reply-To:
	 References:Subject; b=Cv3GmSYirxlDSPW96eNXg1jHgys3TzZct5izHvoztPbFMpyKXR80T99WrfFX10P6T5aG4jo6tpM+gjEBQFAiluHpun+POZRUbGMNSxEjMcVwbC/KVU9/AJDRObDGXB1Y2oXo6izmfZlck6wFGtJ0zpac0Fk5VmiM88nsyGQkCOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IUbsm9R+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BFB0C4CED2;
	Wed, 22 Jan 2025 21:24:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737581083;
	bh=zAiw+BbAfyzmXoes/FvpowLYiA5oXHcquPdp3flTfyo=;
	h=From:Date:To:In-Reply-To:References:Subject:From;
	b=IUbsm9R+N49hZaHgCibeJIv6hcsW2hp9WoBB/0sM0hqVUUx9o8EHDXBwM7CTkZvBD
	 HG3giTR7YKUE2NIz55wyhBembIDImz9Wh7+ykyJwaMg1/ePPTK4+EpXc67+deaWBzh
	 ablfzuMmdxDo8TqEpU3SfUgMllpZ5YLdxLntD6b8wGJpxWRlux/mysIf5tBz5uUIPY
	 XWLgkZYAED4XNG0/QpxFqD997KVZGoxjkftq+szGtRYL0t9WFpl/hWrge58Syva1f3
	 otrmnITP89nChA7zjN1XSWaY7b7UbuLNXIPVnv34NFpHcJXxGtRR2gVvWv+c6r5t/N
	 6InTfyFDigHbQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B5237380AA62;
	Wed, 22 Jan 2025 21:25:08 +0000 (UTC)
From: JJ Jordan via Bugspray Bot <bugbot@kernel.org>
Date: Wed, 22 Jan 2025 21:25:22 +0000
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: trondmy@kernel.org, linux-mm@kvack.org, anna@kernel.org, 
 jlayton@kernel.org, cel@kernel.org, linux-nfs@vger.kernel.org, 
 chuck.lever@oracle.com
Message-ID: <20250122-b219535c18-618d5e0dc9ff@bugzilla.kernel.org>
In-Reply-To: <20241127-b219535c0-4d5445e74947@bugzilla.kernel.org>
References: <20241127-b219535c0-4d5445e74947@bugzilla.kernel.org>
Subject: Re: Possible memory leak on nfsd
X-Bugzilla-Product: File System
X-Bugzilla-Component: NFSD
X-Mailer: bugspray 0.1-dev

JJ Jordan added an attachment on Kernel.org Bugzilla:

Created attachment 307526
Logs and traces from Jan-18 pt2

Part 2, see previous description

File: nfs-traces-250118-pt2.tar.bz2 (application/octet-stream)
Size: 601.99 KiB
Link: https://bugzilla.kernel.org/attachment.cgi?id=307526
---
Logs and traces from Jan-18 pt2

You can reply to this message to join the discussion.
-- 
Deet-doot-dot, I am a bot.
Kernel.org Bugzilla (bugspray 0.1-dev)


