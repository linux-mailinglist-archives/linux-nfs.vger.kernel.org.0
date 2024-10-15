Return-Path: <linux-nfs+bounces-7179-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 17C0799E072
	for <lists+linux-nfs@lfdr.de>; Tue, 15 Oct 2024 10:10:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B99841F21075
	for <lists+linux-nfs@lfdr.de>; Tue, 15 Oct 2024 08:10:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8D341BFDF4;
	Tue, 15 Oct 2024 08:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sTG0LUgW"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C44161BF804
	for <linux-nfs@vger.kernel.org>; Tue, 15 Oct 2024 08:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728979803; cv=none; b=k0z0IJYhTEn9HyTG/BG418Dbj3VlcRydjwg4I64CyFOz72HLHWCSQzvZoQdOex8hnEt5/jkqdOzYTCKFOzxdsiW3wGjfNQMRR5ffcBs3cBRd0f2Mq4Nf0A9E0X5MMaNFOBCtKYalUVm9J72S3sxm5P3LfHE5qHZHMt8YdE92k0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728979803; c=relaxed/simple;
	bh=tyQn3xQ8ksNn65iW1j3yeuUc/ELtRO1a9iqrm3kwu1I=;
	h=From:Date:MIME-Version:Content-Type:To:Message-ID:In-Reply-To:
	 References:Subject; b=FAQ9Q7bF+0ObbxFO6QrSQXUQAKVZwZLq2Rj4r0QnWnvPgcJF9TjE1PgC2YJ4WOHifUmfRB2FTyvDx4MtfZNV6e1yKmepnmciUN/xyBptEtCsLyqpFBXulv4HD4jQiJS1hyDKpHoaSuwV/cpzJ31Nx9rnshFMoDG2SpLlMmSdXVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sTG0LUgW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46379C4CEC7;
	Tue, 15 Oct 2024 08:10:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728979803;
	bh=tyQn3xQ8ksNn65iW1j3yeuUc/ELtRO1a9iqrm3kwu1I=;
	h=From:Date:To:In-Reply-To:References:Subject:From;
	b=sTG0LUgWt7gy+678Kcp8Psv6vAs64nZkU39ixyLYvJ5eXXSm4q43u2PbVi8wQn2Gr
	 oeg2J2AFnciurW8lQxGkG5B2XkGKHH87mNJRf3jiHwgnIjcSQ+PTD5x9TNjzSU8lGH
	 FXIkapI727J4RyVHibEx09DYjySxRAk+tyWjik/Cm+VFhQmSoOH9TEV895KzuOdvXo
	 knsJywnq4ziQKNDaLq94H0eYUTJqk82qsinqRAULC822tKV6D4oNYGPxlQBxaihtgX
	 ui+8xqAezjnWjqxIyP0/yLo6yov4rxJhpLnDF+7xo/iWiQ2y20GmFp2pcK/1FG2VUH
	 TtfXE21SOLjSQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 764823809A8A;
	Tue, 15 Oct 2024 08:10:09 +0000 (UTC)
From: Jan via Bugspray Bot <bugbot@kernel.org>
Date: Tue, 15 Oct 2024 08:10:06 +0000
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: cel@kernel.org, trondmy@kernel.org, anna@kernel.org, jlayton@kernel.org, 
 linux-nfs@vger.kernel.org
Message-ID: <20241015-b219278c2-f2ca1dbdb546@bugzilla.kernel.org>
In-Reply-To: <20240914-b219278c0-d3a919d16eb1@bugzilla.kernel.org>
References: <20240914-b219278c0-d3a919d16eb1@bugzilla.kernel.org>
Subject: Re: >=linux-6.6.0: Resource temporarily unavailable when reading
 file attributes the first time
X-Bugzilla-Product: File System
X-Bugzilla-Component: NFSD
X-Mailer: bugspray 0.1-dev

Jan writes via Kernel.org Bugzilla:

A workaroud is to force version 4.0 in fstab like this

/etc/fstab
---------------------------------------------------------------------
localhost:/mnt/test/local   /mnt/test/shared  nfs   rw,noatime,vers=4.0   0 0
---------------------------------------------------------------------

View: https://bugzilla.kernel.org/show_bug.cgi?id=219278#c2
You can reply to this message to join the discussion.
-- 
Deet-doot-dot, I am a bot.
Kernel.org Bugzilla (bugspray 0.1-dev)


