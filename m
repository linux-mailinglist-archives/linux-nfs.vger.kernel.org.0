Return-Path: <linux-nfs+bounces-9497-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E87BA19A56
	for <lists+linux-nfs@lfdr.de>; Wed, 22 Jan 2025 22:24:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4017816B751
	for <lists+linux-nfs@lfdr.de>; Wed, 22 Jan 2025 21:24:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC4491C5F01;
	Wed, 22 Jan 2025 21:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h4C00ur9"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C61531C5D68
	for <linux-nfs@vger.kernel.org>; Wed, 22 Jan 2025 21:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737581085; cv=none; b=tilDSVUzZPyDpal2FJHIamfpLFcs9Mt96HievA0mPmP72knES/MqzhtdSgU3uLQEl9fP6l/Mok2b4Jzew2IOeSYstfa+79Ttg0XfQ4IEee3UjIJfaa8Rh9x2SLRl3DEJTY2K2HLVJdxhkssNryza64M3S2J3FXydzzNBk2f79KQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737581085; c=relaxed/simple;
	bh=JditsQGpsTcHBmT5HwllP0NWv/x0JXSbPUB9AYV82L4=;
	h=From:Date:MIME-Version:Content-Type:To:Message-ID:In-Reply-To:
	 References:Subject; b=LLsB3ZQ3aEQYUgGSQY1CpI+HXDvK19N7oZM1/rTDDcEgg3bLbIwNVDJr/u9GR5Ai8wPBQ2QgRS8g7/gqZ7+Aeqdzp2oedDbbpfRmOW/prxcOfxI7MT3pOtGGkSy3jby8JuFhn0hWtHRSFaX6qeeyoBeLtLB7oBCChRErqK73JeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h4C00ur9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45380C4CED2;
	Wed, 22 Jan 2025 21:24:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737581085;
	bh=JditsQGpsTcHBmT5HwllP0NWv/x0JXSbPUB9AYV82L4=;
	h=From:Date:To:In-Reply-To:References:Subject:From;
	b=h4C00ur9oO9PmYeYPOYs5ng4pkuCNobL6Tmb4tlkiZLfGZsLRvhwnqqA3eIGb05re
	 LEFMnoaBj1CuaWLykG2A+JhyBfAWC10MzzjF3ZNWvmA5HNxjF7c9nzOz+jNqB+EVyZ
	 zRZ7F90oam2kDi08US5VJnODc5SBbX362aQ6k6XGeaitDhhZ5Ph+1R/FgCURpm019K
	 87Gc5NZuA0C7chzjfSXV5fujqB4AvhE2FQW9EY0jUbVW53RDrYYyZy7XbT+2nwDvyt
	 YRuJ/XzTUaLT8VO+FoxB5lxvrvZIqPgMkP7+MbjdUoQ2DmfgzY2vrUArI8k0vqK6CI
	 YYPKPzF8aNuxg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EC699380AA62;
	Wed, 22 Jan 2025 21:25:10 +0000 (UTC)
From: JJ Jordan via Bugspray Bot <bugbot@kernel.org>
Date: Wed, 22 Jan 2025 21:25:23 +0000
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
Message-ID: <20250122-b219535c19-1281dbcb424c@bugzilla.kernel.org>
In-Reply-To: <20241127-b219535c0-4d5445e74947@bugzilla.kernel.org>
References: <20241127-b219535c0-4d5445e74947@bugzilla.kernel.org>
Subject: Re: Possible memory leak on nfsd
X-Bugzilla-Product: File System
X-Bugzilla-Component: NFSD
X-Mailer: bugspray 0.1-dev

JJ Jordan added an attachment on Kernel.org Bugzilla:

Comment on attachment 307525
Logs and traces from Jan-18 pt1

This was submitted in error, apologies.

File: nfs-traces-250118-pt1.tar.bz2 (application/octet-stream)
Size: 4.61 MiB
Link: https://bugzilla.kernel.org/attachment.cgi?id=307525
---
Logs and traces from Jan-18 pt1

You can reply to this message to join the discussion.
-- 
Deet-doot-dot, I am a bot.
Kernel.org Bugzilla (bugspray 0.1-dev)


