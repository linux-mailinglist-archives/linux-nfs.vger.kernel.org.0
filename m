Return-Path: <linux-nfs+bounces-8234-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C75B9DA0A7
	for <lists+linux-nfs@lfdr.de>; Wed, 27 Nov 2024 03:35:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC8CA168C20
	for <lists+linux-nfs@lfdr.de>; Wed, 27 Nov 2024 02:35:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8D6D558A5;
	Wed, 27 Nov 2024 02:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b5DKndDA"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84A7654F8C
	for <linux-nfs@vger.kernel.org>; Wed, 27 Nov 2024 02:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732674912; cv=none; b=AA6BL53QQUrb1TCa0hsMv6wrGWuudI4Q9VcBZNNjg/bCljmMetY8ql0pDKmoyMaQbVpb97L0D4R9dcSiWVdXuV+tKQJQ63QFRR3x2ddFZl4Ez2YE5WI+RoB982/3oOSZpqBOW+cm/t739Xj72YL40ajXt83fmCfmsHcfHSfRuwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732674912; c=relaxed/simple;
	bh=bza4C01K9SmErLWecfHlK1vUmU88j02DBYLRkJmec8A=;
	h=From:Date:MIME-Version:Content-Type:To:Message-ID:In-Reply-To:
	 References:Subject; b=ZCT/eITvHM3s4wUUHzMEoNaOb6WdCSQg0+FUgBd65d2UhFHR5jJyKRhgB1NeTW0BdnHJKsprFInfhUNUpM0vyRipm/ZoVnS8r364/ulmN40dEEzlSGj4xByoeTgrtdBM9VsU1k01gTWTHnDyzrSg2R36tstO1p5sFjMSjkhygo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b5DKndDA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57979C4CECF;
	Wed, 27 Nov 2024 02:35:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732674912;
	bh=bza4C01K9SmErLWecfHlK1vUmU88j02DBYLRkJmec8A=;
	h=From:Date:To:In-Reply-To:References:Subject:From;
	b=b5DKndDAUyGLyJFaHX/bJ6P2bWNJ1vRPcFVaCrkWYICm0IyFw9YildwbQbYH8+qR0
	 uqm2UUr2fNwkMLBj20TmSdmCGVhhfZwWTgIwnrSKc1QATGvuJPcMxd1BiDJSnx9gPO
	 fB58ZwcIpUCGVMpNbU4CUKk6EzfD8mdEld6aACVkrkBTZcADl0uJrfOz5NIFoo/nr1
	 xUAw8WCcHDYVGVRmK4NmteK+m59KT6USoSld3qnOtZMtXVq0FOzlzvHxVR8+6X6DNh
	 G2P63aPE19KeIkq0Y6jlmq/bISJbcr695unKZiHAS0LiY6P/5MxGCOpr5FsUf1UiT9
	 0LnGR+VvJ0vdg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70DBF3809A00;
	Wed, 27 Nov 2024 02:35:26 +0000 (UTC)
From: Chen Chen via Bugspray Bot <bugbot@kernel.org>
Date: Wed, 27 Nov 2024 02:35:13 +0000
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
Message-ID: <20241127-b219535c6-7870885cef87@bugzilla.kernel.org>
In-Reply-To: <20241127-b219535c0-4d5445e74947@bugzilla.kernel.org>
References: <20241127-b219535c0-4d5445e74947@bugzilla.kernel.org>
Subject: Re: Possible memory leak on nfsd
X-Bugzilla-Product: File System
X-Bugzilla-Component: NFSD
X-Mailer: bugspray 0.1-dev

Chen Chen added an attachment on Kernel.org Bugzilla:

Created attachment 307289
/proc/vmstat

File: vmstat (text/plain)
Size: 3.65 KiB
Link: https://bugzilla.kernel.org/attachment.cgi?id=307289
---
/proc/vmstat

You can reply to this message to join the discussion.
-- 
Deet-doot-dot, I am a bot.
Kernel.org Bugzilla (bugspray 0.1-dev)


