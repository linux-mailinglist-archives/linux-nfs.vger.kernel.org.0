Return-Path: <linux-nfs+bounces-7351-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8135B9AA034
	for <lists+linux-nfs@lfdr.de>; Tue, 22 Oct 2024 12:40:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C6B41F2198E
	for <lists+linux-nfs@lfdr.de>; Tue, 22 Oct 2024 10:40:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEC9515574F;
	Tue, 22 Oct 2024 10:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EZUS9/Qi"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 850E6199E8D
	for <linux-nfs@vger.kernel.org>; Tue, 22 Oct 2024 10:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729593602; cv=none; b=U8gz9/4kEXq722/Mgm3C0LImhEL1EtFccFzj6L3NO2TrAVKKp6VXCWnVscsHrp7vHqSObhw7ygDG47ZxYST1bxqxWHmgro7thibrwPcjo3zGr5DltWPuQofQ8yq5yFw/Q7l65mzdNT/ELtzNYDVagX9+vT7smUfAyyU8i7IrAhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729593602; c=relaxed/simple;
	bh=8R/MMq6V9ckkfIhiRkSX6J05NLbTXzrznaj5h0GL+vg=;
	h=From:Date:MIME-Version:Content-Type:To:Message-ID:In-Reply-To:
	 References:Subject; b=rgelzAC+XuehNhhpbBT91VP1Vlx6CsEmDdFNANSVSB97E0CvhzjpJz+V5ktewVohHuoS3x5Gm+NbIEaWnPA5NwocHBJ1HjX/Z+RGY9TjyG4A27hRf/MuRXeQrb+5Ub+903QXrmT3A7dginBF7hvj3XftZ6NoTA+2fD2v+4+YbMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EZUS9/Qi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BEEEC4CEC3;
	Tue, 22 Oct 2024 10:40:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729593602;
	bh=8R/MMq6V9ckkfIhiRkSX6J05NLbTXzrznaj5h0GL+vg=;
	h=From:Date:To:In-Reply-To:References:Subject:From;
	b=EZUS9/Qi5hgxsg47VclkBb1+e5xyOB66S/X79TB+747XMRa7swbaIftYUGqRnHMxk
	 Z9DVUw6CmkmsZQxF2how7EoipLCz6kuKdOFpvfWQe6y0KXDHUc+XwxpgjhFyEAjy+G
	 e6H6DbkZ4ZpXVWblTCUCdejwLNrf0PjL8M4MFkVd1LoLmKKlnRqg9ZFm8JV81HQdof
	 uyCI7JOKJ6pJp7NjG43RHVsSUrF9YofVUbmmgd/wkGWwmxpGOr6AQXnETspP1kC7/k
	 aNM4tq16zXDNVECcOq8VV2Xs5F2XwWQwYT/YZb/syuSOXayaLmINXfQmDpE/0GTOQC
	 //xJ1bVdk4m8g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 39B153809A8A;
	Tue, 22 Oct 2024 10:40:09 +0000 (UTC)
From: "The Linux kernel's regression tracker (Thorsten Leemhuis) via Bugspray Bot" <bugbot@kernel.org>
Date: Tue, 22 Oct 2024 10:40:08 +0000
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: jlayton@kernel.org, linux-nfs@vger.kernel.org, cel@kernel.org, 
 trondmy@kernel.org, anna@kernel.org
Message-ID: <20241022-b219370c4-87086f1d9b96@bugzilla.kernel.org>
In-Reply-To: <20241010-b219370c0-bd6df2a482ac@bugzilla.kernel.org>
References: <20241010-b219370c0-bd6df2a482ac@bugzilla.kernel.org>
Subject: Re: link error while compiling localio.c
X-Bugzilla-Product: File System
X-Bugzilla-Component: NFSD
X-Mailer: bugspray 0.1-dev

The Linux kernel's regression tracker (Thorsten Leemhuis) writes via Kernel.org Bugzilla:

Was the problem resolved in between? 

And can I CC you on a lkml mail? This would expose your email address to the public.

View: https://bugzilla.kernel.org/show_bug.cgi?id=219370#c4
You can reply to this message to join the discussion.
-- 
Deet-doot-dot, I am a bot.
Kernel.org Bugzilla (bugspray 0.1-dev)


