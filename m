Return-Path: <linux-nfs+bounces-9784-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EFB0A22F33
	for <lists+linux-nfs@lfdr.de>; Thu, 30 Jan 2025 15:19:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 097BD3A2774
	for <lists+linux-nfs@lfdr.de>; Thu, 30 Jan 2025 14:19:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E8701E8835;
	Thu, 30 Jan 2025 14:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QfK1Lo4p"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF05D1E3DC8
	for <linux-nfs@vger.kernel.org>; Thu, 30 Jan 2025 14:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738246782; cv=none; b=grcLC55Se4zhzclkzx3xol6XECUvtqdTxieuiYmXp3nx0AOjvTc+EOzLt40Gv+c2pWC6rbgpiiMWZ1hIrLJVBXcj3NMUXbLyXiVhSo+uAVpI+tTDNbOIrYyNRgwmH7c5MjlefK7Lxegtzgi6tKSfFtYJVvNhHK/jM/Zjx0Wqxyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738246782; c=relaxed/simple;
	bh=DNGAbnnwkHH+H+/+7a7emOrwAN/j5XKvNcjErYxulZA=;
	h=From:Date:MIME-Version:Content-Type:To:Message-ID:In-Reply-To:
	 References:Subject; b=KyZEJ6PO/Wom9dgM+RqSY0NPr52peuWuBIMR4b2N5NTGVRwr7/7XtiMmGUvIi+HRhej/4slz0TLBTBAeXsRqCJqF79UFPKiWrVaPqUomrpBijXMzED1BjBrHj1VnaPNGKxleEsUTgCTan+sj+86mZ8hwW+mKJHc0ZGD4Lm6ccuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QfK1Lo4p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5E26C4CED2;
	Thu, 30 Jan 2025 14:19:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738246781;
	bh=DNGAbnnwkHH+H+/+7a7emOrwAN/j5XKvNcjErYxulZA=;
	h=From:Date:To:In-Reply-To:References:Subject:From;
	b=QfK1Lo4pDmu7lJ30cmyF/5AjT6b/w/YJChn7XiH19xkCyaht7QtRehE/xfgZ3/HPw
	 6nzM+IDe7hHZKUQzgAzgn2X0aUrVm1wRmnmKTMZ5icwclB6TFctIz6A/9Filnh76Ao
	 PJO6UVWgj6fgWhnU21P38sQONpwIAFO3WUnfTH5QfJTWN5IlGPpSd4PF7ASWkuwin9
	 dTssgxw23CSlGD1b8Qczj3DCAoXnqQp5KqVLux/QP11wxcaJbUlzt/3ZIyrY32ePcm
	 MUxCZIcu5TRvvA8sIU9ruomVqooGoQapUbLBxZSWZFrnPsoLGypJf7YII3O3tFXoyX
	 9k3SX/FjmEBXQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 03816380AA66;
	Thu, 30 Jan 2025 14:20:08 +0000 (UTC)
From: "rik.theys via Bugspray Bot" <bugbot@kernel.org>
Date: Thu, 30 Jan 2025 14:20:07 +0000
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: trondmy@kernel.org, anna@kernel.org, linux-nfs@vger.kernel.org, 
 cel@kernel.org, jlayton@kernel.org
Message-ID: <20250130-b219737c2-b4f8114c4919@bugzilla.kernel.org>
In-Reply-To: <20250130-b219737c0-091f27de8b7a@bugzilla.kernel.org>
References: <20250130-b219737c0-091f27de8b7a@bugzilla.kernel.org>
Subject: Re: warning in nfsd4_cb_done
X-Bugzilla-Product: File System
X-Bugzilla-Component: NFSD
X-Mailer: bugspray 0.1-dev

rik.theys writes via Kernel.org Bugzilla:

Hi,

It seems I've cloned the wrong bug. It should have been https://bugzilla.kernel.org/show_bug.cgi?id=219710 instead.

As mentioned by Chuck in https://bugzilla.kernel.org/show_bug.cgi?id=219710#c25 there are multiple events in the trace, but there is only a single WARNING logged? So is there still something different between the various events, or is the warning only logged once?

Regards,
Rik

View: https://bugzilla.kernel.org/show_bug.cgi?id=219737#c2
You can reply to this message to join the discussion.
-- 
Deet-doot-dot, I am a bot.
Kernel.org Bugzilla (bugspray 0.1-dev)


