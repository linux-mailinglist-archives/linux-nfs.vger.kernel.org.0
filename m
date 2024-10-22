Return-Path: <linux-nfs+bounces-7358-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C6BDC9AB04A
	for <lists+linux-nfs@lfdr.de>; Tue, 22 Oct 2024 16:00:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 883DC2838C1
	for <lists+linux-nfs@lfdr.de>; Tue, 22 Oct 2024 14:00:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CC5B19B3ED;
	Tue, 22 Oct 2024 14:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RvoUCXuU"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC46C45945
	for <linux-nfs@vger.kernel.org>; Tue, 22 Oct 2024 14:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729605600; cv=none; b=GWH0UFUodHtd4+rATYoRVE2QICgDa0TG7BdXG10tj5u7eL5QippRhaFcQ59J5Vc+pqAGysEmGVKg05v/1AEH3CE8U+9u1HMuQyO2J8JKszEvHtAfq98UDW06Vqap7FIJQFr1gHys8u2OUdpTrWFJZviQHE6lbmLrJ2nEmyPP3HY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729605600; c=relaxed/simple;
	bh=8PSe4VExro2kCoLGzmhjvh90+bvGeMWqOYGXFk9jij8=;
	h=From:Date:MIME-Version:Content-Type:To:Message-ID:In-Reply-To:
	 References:Subject; b=cDSaWkzwN5cv5qGAz68wukcYNOhD8a2VXDqGOa2bI/AR5dJljUsQ9x7vN3ByZGilDU0h/OUpQi3KrAUgBo0RUYtZbZ1tpeUQs5D9v1goyuWlTNHHqO+GnyXmT+CL/VTkPEZPr5Bgn0j28/XK0vbpFQ7ar58HlH9QSZhgnxsiELI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RvoUCXuU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 771D6C4CEC3;
	Tue, 22 Oct 2024 14:00:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729605600;
	bh=8PSe4VExro2kCoLGzmhjvh90+bvGeMWqOYGXFk9jij8=;
	h=From:Date:To:In-Reply-To:References:Subject:From;
	b=RvoUCXuUSwCZzUtWPV63HHHJLE4DqE/jcI9+l84kMYCx1+RF2CC3it4HKVW5jfdck
	 /+aPAugflWN84NEwAPP1xTp/celjJXVi3hu7aohlpbHV4+sVYcjXSkxSzMJEWWJ2cY
	 M2ujtG2410R+nEbijWMbZo8GJgHGHALf4y720nTmsEDyjI8KXRb8SycnU3SxCvD/7Y
	 eRzngjog5n+GMMXa5Fd1wuRg308bJFMBb7OCqyK7Qp69bJ4U3YPEVbz5t73CoJPM3i
	 40+kpflxEcIlbPI6x61XPvtbebtS+NHH1i2mtWbH/VC1PzPC6lkytfjyei45kcKBvY
	 vYXXpNQgiGUPQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B65553822D22;
	Tue, 22 Oct 2024 14:00:07 +0000 (UTC)
From: Mike Snitzer via Bugspray Bot <bugbot@kernel.org>
Date: Tue, 22 Oct 2024 14:00:08 +0000
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: linux-nfs@vger.kernel.org, cel@kernel.org, trondmy@kernel.org, 
 jlayton@kernel.org, anna@kernel.org
Message-ID: <20241022-b219370c5-c7de7745e4a0@bugzilla.kernel.org>
In-Reply-To: <20241010-b219370c0-bd6df2a482ac@bugzilla.kernel.org>
References: <20241010-b219370c0-bd6df2a482ac@bugzilla.kernel.org>
Subject: Re: link error while compiling localio.c
X-Bugzilla-Product: File System
X-Bugzilla-Component: NFSD
X-Mailer: bugspray 0.1-dev

Mike Snitzer writes via Kernel.org Bugzilla:

This was fixed via v6.12-rc3 commit 009b15b57485 ("nfs_common: fix
Kconfig for NFS_COMMON_LOCALIO_SUPPORT")

In the provided kernel config:

CONFIG_NFS_FS=m
CONFIG_NFSD_V4=y
CONFIG_NFS_COMMON=y
CONFIG_NFS_COMMON_LOCALIO_SUPPORT=m
CONFIG_NFS_LOCALIO=y

My Kconfig fix will result in CONFIG_NFS_LOCALIO=m so that the symbols
are available to the nfs.ko kernel module.

But if you have any further issues, certainly let me know.

View: https://bugzilla.kernel.org/show_bug.cgi?id=219370#c5
You can reply to this message to join the discussion.
-- 
Deet-doot-dot, I am a bot.
Kernel.org Bugzilla (bugspray 0.1-dev)


