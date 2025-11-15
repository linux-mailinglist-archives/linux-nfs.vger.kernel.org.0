Return-Path: <linux-nfs+bounces-16419-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FFF6C6037B
	for <lists+linux-nfs@lfdr.de>; Sat, 15 Nov 2025 12:01:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFF2F3B949F
	for <lists+linux-nfs@lfdr.de>; Sat, 15 Nov 2025 11:01:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 409CF273D9F;
	Sat, 15 Nov 2025 11:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FYWYhynG"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1144121C16E;
	Sat, 15 Nov 2025 11:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763204462; cv=none; b=nCSmkbuJjIvHeqFVHWGW33WBIG8K8NRfgYYFS2ac13aPEEdh4NRadZXG8CQBCzjiDW0rbOfat9e/hgSr9VLQLsL90U98/eM4wf6XsATPxoVx5PrgoBxI8pbycWnq1APOTT//j/p28wEAGjGc9rV65JnA0poVGG0GvTi/lrCBklo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763204462; c=relaxed/simple;
	bh=AbHFb84qDKWSF9Rz7oMGNfRLJIP+8yj5k4Jpw+KFhXU=;
	h=From:Date:MIME-Version:Content-Type:To:Message-ID:In-Reply-To:
	 References:Subject; b=TYN07nRzXZ3VPNXpXVKOcCzTVFP11H03UbNHk7sSHMe7tX6M0KxEDpbGmAJR21Up+Aa48F0lbYRoGBXB9OCZYYlSArUA72DEr0FyRKXm779a6bDo32P0hXl8Ly7ORVkc6pDWLHEQp061MVFK9rwxB09KoDXFv1PR5kJSqgcNqCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FYWYhynG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84A61C4CEF5;
	Sat, 15 Nov 2025 11:01:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763204461;
	bh=AbHFb84qDKWSF9Rz7oMGNfRLJIP+8yj5k4Jpw+KFhXU=;
	h=From:Date:To:In-Reply-To:References:Subject:From;
	b=FYWYhynG+s24nTWOBfs5NC3O9C7uutVZlcFpyMztgB13baOdeWgb5YgS7rq08FIzV
	 Mg8e4SGVFh4TE5ZxARrH5StPpmGbIJKm7XDGqQyl/WjAsNeKz27vSB/wiDTrPlFGpO
	 AGMtNfzQ79tyGgMTKRfB1chITAcne2CgktvPqhPxzfGUVboY/P64Z5pCI5DshC3/kY
	 PMqrqo2yDgXt83mA5OqthpblIWtKXXGZ8ofyBpuv0dzpNFA6hc6xXa045wvEkehiH6
	 c5lmPh0gMLBbQS9wDousf9AuZIA4yO/fJT+SWXZMjPer1VczNpafRk3Bel74+iu6jK
	 DK99Rtu5VAVRQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B22713A78A65;
	Sat, 15 Nov 2025 11:00:30 +0000 (UTC)
From: Mike-SPC via Bugspray Bot <bugbot@kernel.org>
Date: Sat, 15 Nov 2025 11:00:30 +0000
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: neilb@ownmail.net, anna@kernel.org, linux-kernel@vger.kernel.org, 
 david.laight@aculab.com, linux-nfs@vger.kernel.org, 
 david.laight.linux@gmail.com, jlayton@kernel.org, speedcracker@hotmail.com, 
 stable@vger.kernel.org, akpm@linux-foundation.org, cel@kernel.org, 
 neil@brown.name, trondmy@kernel.org, neilb@brown.name
Message-ID: <20251115-b220745c17-d79a0b4d3866@bugzilla.kernel.org>
In-Reply-To: <20251104-b220745c0-91170b3b3642@bugzilla.kernel.org>
References: <20251104-b220745c0-91170b3b3642@bugzilla.kernel.org>
Subject: Re: Compile Error fs/nfsd/nfs4state.o - clamp() low limit slotsize
 greater than high limit total_avail/scale_factor
X-Bugzilla-Product: File System
X-Bugzilla-Component: NFSD
X-Mailer: bugspray 0.1-dev

Mike-SPC writes via Kernel.org Bugzilla:

Hi there,

at first: Thanks for patching and investigation.
I've tested the patch mentioned in
https://lkml.org/lkml/2025/11/10/12
and it works (for me).

Thanks again and regards,
Michael

View: https://bugzilla.kernel.org/show_bug.cgi?id=220745#c17
You can reply to this message to join the discussion.
-- 
Deet-doot-dot, I am a bot.
Kernel.org Bugzilla (bugspray 0.1-dev)


