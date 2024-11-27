Return-Path: <linux-nfs+bounces-8231-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 287609DA0A5
	for <lists+linux-nfs@lfdr.de>; Wed, 27 Nov 2024 03:35:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 90B4DB22F2F
	for <lists+linux-nfs@lfdr.de>; Wed, 27 Nov 2024 02:35:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E411142AB3;
	Wed, 27 Nov 2024 02:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BBlnyndw"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEB4D1BC3F
	for <linux-nfs@vger.kernel.org>; Wed, 27 Nov 2024 02:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732674904; cv=none; b=DGeXnPdZE2fQRo4I8AqYL9Mmj/Ch7XJntt0sVJkw88lxL+gtKnPI/gAQrVbHIkGjLUiC+++rQPfcA6nyMSy37OaPPtTy1a2v/F0jSo/mHYJ7ACp+LchJgzcSiPa5gXc8blZaadqfPrkmbhNILKJ0/60XnHhcxtmRsn4xq156094=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732674904; c=relaxed/simple;
	bh=jLcJve4aQH0PNx7yBQ139sSsH7wigewx71De/8JxtpQ=;
	h=From:Date:MIME-Version:Content-Type:To:Message-ID:In-Reply-To:
	 References:Subject; b=kPgmoSWsqEVJ852ePscs/nx/aO35VkDLA6kgerWwTFySUWsc/Teype4/lSJRrnSF1a4KFfLJ1rAgi3yAsaDYCjSj1xjp11ufv8p2DDgXh47sEI/umVqYHaYqRE6r+owvrYQYdVwGDFJkpPNoTfoLOMjoJmV5KPtMvBuF2azSlus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BBlnyndw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E84CC4CECF;
	Wed, 27 Nov 2024 02:35:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732674904;
	bh=jLcJve4aQH0PNx7yBQ139sSsH7wigewx71De/8JxtpQ=;
	h=From:Date:To:In-Reply-To:References:Subject:From;
	b=BBlnyndwq4WqLHlSms3F587/6GrDI9UxyGBINzPsliZPmJHkAfPtnudElaf3l89Dm
	 7PtlyrtFLHBGwXCxcDCGntLtbnrmC+bXHcn1CQB1qkevhBvq0Ag+zZBo6Uf/GXhbhF
	 KGmkbMR8YQeNWTm2VM9omxiFIjQ+QYuO1EdiishMBOqtJhMi+KaXXGx0dMpTaxSdtP
	 GOXP5H3gVOs6Y78Ruc6dAAl16KYmnCr2XToJG928AgjpCBvt+ch1glT6USyplnfLUu
	 JIGYxvK6PFYrvQGfi3NxxccT5Rcaq9M/DnnvyC5yowyY6xc9Nyj34wSET+L1f4deTd
	 vtoKlRZjJZsdQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70C7D3809A00;
	Wed, 27 Nov 2024 02:35:18 +0000 (UTC)
From: Chen Chen via Bugspray Bot <bugbot@kernel.org>
Date: Wed, 27 Nov 2024 02:35:10 +0000
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
Message-ID: <20241127-b219535c3-d2227a485a20@bugzilla.kernel.org>
In-Reply-To: <20241127-b219535c0-4d5445e74947@bugzilla.kernel.org>
References: <20241127-b219535c0-4d5445e74947@bugzilla.kernel.org>
Subject: Re: Possible memory leak on nfsd
X-Bugzilla-Product: File System
X-Bugzilla-Component: NFSD
X-Mailer: bugspray 0.1-dev

Chen Chen added an attachment on Kernel.org Bugzilla:

Created attachment 307286
/proc/slabinfo

File: slabinfo (text/plain)
Size: 30.92 KiB
Link: https://bugzilla.kernel.org/attachment.cgi?id=307286
---
/proc/slabinfo

You can reply to this message to join the discussion.
-- 
Deet-doot-dot, I am a bot.
Kernel.org Bugzilla (bugspray 0.1-dev)


