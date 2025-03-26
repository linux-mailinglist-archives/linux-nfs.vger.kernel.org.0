Return-Path: <linux-nfs+bounces-10917-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BEBFBA726BC
	for <lists+linux-nfs@lfdr.de>; Thu, 27 Mar 2025 00:00:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41A7417B2E7
	for <lists+linux-nfs@lfdr.de>; Wed, 26 Mar 2025 22:59:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18B7A25DB10;
	Wed, 26 Mar 2025 22:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nrmbl8bt"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E56561ACED5;
	Wed, 26 Mar 2025 22:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743029974; cv=none; b=a2RBRxYCspaOBNyXBMIrW9urzc1Subq6LZ1zpmTSrZ4+M9wud935MXTL5atxDPiadx+Xhngi3sxFckxhlgaMcgrpIuGKyBPRqu+b/JZLIcvkoVu110CTjERIuEo5mHA0KNbOD+mT8w/QxFEgacUyDDl2rLzjPSvMTqvcV9CybeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743029974; c=relaxed/simple;
	bh=7Z1Sy8/BIpWuTPkzsdsQjFdBeKjVUE4EoygIA7qX1O4=;
	h=From:Date:MIME-Version:Content-Type:To:Message-ID:In-Reply-To:
	 References:Subject; b=AQR7sOw411zxofvu6SibrYAVP2IMbJAbJxNfKZs1PeY7LrzMquHwaRzYn0U2cbYN9nHfBrP8mA22WDxhYRUvnIuERHV0SHk8CmV4io+2RP+SrYk7/o/aVuVBIg5gyHQCaq98azwYrPeyCtLsYyV5GhhqAeZCcr+MVtrDS9PCKdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nrmbl8bt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B045C4CEE5;
	Wed, 26 Mar 2025 22:59:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743029973;
	bh=7Z1Sy8/BIpWuTPkzsdsQjFdBeKjVUE4EoygIA7qX1O4=;
	h=From:Date:To:In-Reply-To:References:Subject:From;
	b=Nrmbl8btBtlIaF1jwy9h4HNBaSnUk9TnlM2Wb77X7hBXbY4PYbYieRbzzwOzg3OOY
	 euTGHiG64iR97S9pFsKIFt0WDHoJOzACQIq6zUMbPs/X3U3f68lH6SAxN6WmUIGhOo
	 zWUhaU7hoHECyEX+r8Kf8P3gC+aE9dEdCKNq/qGyex/T758uQnTKyOyK4l25OmVzJs
	 MU3O4eWNiX/pQICS+hQYb33V/qtz0+09tW7Yahp360xBbKHUm3Ntlzk24fHQfo9LIr
	 Fo4PZMET6ax8PeTo91JIISWn3Kr7CBGfpd+5VNQWWlXNhINxjsN0JzYpb79/74zjAC
	 vA7OvK6a0cv1A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B3FB2380AAF5;
	Wed, 26 Mar 2025 23:00:10 +0000 (UTC)
From: Lucas via Bugspray Bot <bugbot@kernel.org>
Date: Wed, 26 Mar 2025 23:00:12 +0000
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: linux-nfs@vger.kernel.org, trondmy@kernel.org, cel@kernel.org, 
 anna@kernel.org, iommu@lists.linux.dev, jlayton@kernel.org, 
 robin.murphy@arm.com, chuck.lever@oracle.com
Message-ID: <20250326-b219865c7-642149c69789@bugzilla.kernel.org>
In-Reply-To: <20250313-b219865c0-2a34cbc6e249@bugzilla.kernel.org>
References: <20250313-b219865c0-2a34cbc6e249@bugzilla.kernel.org>
Subject: Re: NFS Server Issues with RDMA in Kernel 6.13.6
X-Bugzilla-Product: File System
X-Bugzilla-Component: NFSD
X-Mailer: bugspray 0.1-dev

Lucas added an attachment on Kernel.org Bugzilla:

Created attachment 307898
logs with LOCK_STAT enabled

Hi

I was able to recompile the kernel with LOCK_STAT enabled and reproduce the issue. Logs are attached.

Logs attached.

File: logs-lock_stat.zip (application/zip)
Size: 139.49 KiB
Link: https://bugzilla.kernel.org/attachment.cgi?id=307898
---
logs with LOCK_STAT enabled

You can reply to this message to join the discussion.
-- 
Deet-doot-dot, I am a bot.
Kernel.org Bugzilla (bugspray 0.1-dev)


