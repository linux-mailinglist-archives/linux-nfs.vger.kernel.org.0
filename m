Return-Path: <linux-nfs+bounces-6470-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A014978943
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Sep 2024 22:05:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 039591F24900
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Sep 2024 20:05:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78BC61482E3;
	Fri, 13 Sep 2024 20:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vtcv92TR"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 551EE1487C1
	for <linux-nfs@vger.kernel.org>; Fri, 13 Sep 2024 20:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726257912; cv=none; b=bZ1h0TDCbTpucHqwux2dhMhA/u1mv5X6iaeb6N4owMyCMGYZP7dmnwT3vzbQPY18vTQlA3YSezEjSNn6fV6Ea7iPO7AwQvteuE46y5fmPr/gcUlORDaG3yM1BOXG/SJOHUrS5EPvHHXgBBbp+YewQNnmKrBi895hsgIdi13VWg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726257912; c=relaxed/simple;
	bh=relOxu7i0yYjnbvGV6WmZlxTBzNEizQxN8MogBXQDAc=;
	h=Date:MIME-Version:Content-Type:From:To:Message-ID:In-Reply-To:
	 References:Subject; b=tBsYFtmFuj86s/xftrsOhL8MMZNGceCSfFwP09QQien9TvdssDfuHzUF+xgW9FgPKZQMUN42SuFnSnBOP9GmfWg7jR4XzDRtTmCd717FNDpwqDhP/6CtqxrwLWtA942/G/tye02opZh3TlvlBZGQ5mYYA58hcj/ffI9w4LIbItU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vtcv92TR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBEADC4CEC0;
	Fri, 13 Sep 2024 20:05:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726257912;
	bh=relOxu7i0yYjnbvGV6WmZlxTBzNEizQxN8MogBXQDAc=;
	h=Date:From:To:In-Reply-To:References:Subject:From;
	b=Vtcv92TRuhXKDaSKkK7PU4FdOb5BNuKmuxlVHKy6ZPC7wz/XiW2WVgi9cM27F417C
	 8eI5Wa9ajGhXsPsHH1Z90R1wdlP5/BbQblzS71/brhnKenhZE3a/POIydk96RWwBOR
	 ubwnqOjDkweDKeBZKjVWWa39EOIfouGvVP/eXOTEo/1zX/lz6R1YyWTa0JfgXS829u
	 3AuaGXQewVibOQMClSZiIRIzQl3Mm+erSRMZzznCbBGACR1FvUYw+bprbzzkUkG8yD
	 ersp4n73yUKK87W0HIupnfuHXgiQo+VZDpdt8tHWXuMqrHja7xLX2Yc2Zm5+L/ITyP
	 N4csQiZyCZGoQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7140A3806655;
	Fri, 13 Sep 2024 20:05:14 +0000 (UTC)
Date: Fri, 13 Sep 2024 20:05:10 +0000
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
From: Bugspray Bot <bugbot@kernel.org>
To: trondmy@kernel.org, cel@kernel.org, jlayton@kernel.org, 
 linux-nfs@vger.kernel.org, anna@kernel.org
Message-ID: <20240913-b218735c3-fa22f53ea4da@bugzilla.kernel.org>
In-Reply-To: <20240913-b218735c0-12465843fe68@bugzilla.kernel.org>
References: <20240913-b218735c0-12465843fe68@bugzilla.kernel.org>
Subject: Re: NFSD callback operations block everything when clients are
 unresponsive
X-Bugzilla-Product: File System
X-Bugzilla-Component: NFSD
X-Mailer: bugspray 0.1-dev

cel writes via Kernel.org Bugzilla:

Agreed, the queue_delayed_work() isn't working the way I expected, but it may behave differently with an ordered work queue than it does with a bog standard work queue instance.

In any event, some CB operations can be "fire and forget" while others will want some recourse on failure-to-send, and at least CB_OFFLOAD needs to be as reliable as we can make it. Thus having specific retry handlers for each CB operation seems like the best long-term approach.

View: https://bugzilla.kernel.org/show_bug.cgi?id=218735#c3
You can reply to this message to join the discussion.
-- 
Deet-doot-dot, I am a bot.
Kernel.org Bugzilla (bugspray 0.1-dev)


