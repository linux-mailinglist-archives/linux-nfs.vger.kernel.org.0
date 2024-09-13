Return-Path: <linux-nfs+bounces-6469-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ED37978942
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Sep 2024 22:05:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38C7E1F24360
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Sep 2024 20:05:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11F18126F2A;
	Fri, 13 Sep 2024 20:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HCibiBAm"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E26881482E3
	for <linux-nfs@vger.kernel.org>; Fri, 13 Sep 2024 20:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726257911; cv=none; b=BHdvXyVPfAKPuhclKyyd24lbqU/2PV6ybZYJE5QVQJifDwi2XyZFJPNNEkIogk8b7hL8rAM6pY4Pzh86sAP4wAFa/CeEpB4Xm0HNv/PwnTmUH9jOA3nutn3ZSbbX9ZbnLh8waecpwE0RnvZ2PvmYMOW2GudWmKIHSQUYG1rs95Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726257911; c=relaxed/simple;
	bh=hCB3L7c17ZkvX9mNM578Jsl2XF7PE09giSbTrbcsz2c=;
	h=Date:MIME-Version:Content-Type:From:To:Message-ID:In-Reply-To:
	 References:Subject; b=sjI0d+K3sSYklpXZevBSW3KiYneh+SANq4UCtbglVSjKQuhs34EvNHRZuqwjATygG8cZE/m2RmjhcZ0UzgqcloCvcWmqFoS7vtzMSMeDhF4ltF1OJuadzM9t1vfd9Sc2ju9u7uRt6UedIOsdHgJbz/O/IvFuQCzPM1Zm1pvGqck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HCibiBAm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6ABCCC4CEC0;
	Fri, 13 Sep 2024 20:05:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726257910;
	bh=hCB3L7c17ZkvX9mNM578Jsl2XF7PE09giSbTrbcsz2c=;
	h=Date:From:To:In-Reply-To:References:Subject:From;
	b=HCibiBAmp+XdZCFYiepbKM68WidMMhpB+YtZVUfAK4N+x8aS0R5jEU3RVrN/kf+7Z
	 2E4rzxozg52N5fMRg0U1H5Y2gPS9eeL6BmF7gK4962VhUo9G/qEnSp8aPZztpbwKbP
	 8ZWKrSTCQVufFhIFKa/Ea422Dwr8YZmd3Hikbfo7KzXrSl39C9jKI3V226kETVRTku
	 KBiWKH3H6HkW7kflmaLgwyetLlHeX94OaFhnhmW1y5tHyJmPayMarEWV/PySKFK3M8
	 KWrjKa7PhdWV70OcuG9H9NPsmPiLenmqFTvDMO72F0puVYASJbpqccPx7f6eQrDUQ9
	 z6r0DX4t7odiQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EBDA13806655;
	Fri, 13 Sep 2024 20:05:12 +0000 (UTC)
Date: Fri, 13 Sep 2024 20:05:09 +0000
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
Message-ID: <20240913-b218735c2-f9020ea78cae@bugzilla.kernel.org>
In-Reply-To: <20240913-b218735c0-12465843fe68@bugzilla.kernel.org>
References: <20240913-b218735c0-12465843fe68@bugzilla.kernel.org>
Subject: Re: NFSD callback operations block everything when clients are
 unresponsive
X-Bugzilla-Product: File System
X-Bugzilla-Component: NFSD
X-Mailer: bugspray 0.1-dev

jlayton writes via Kernel.org Bugzilla:

The retry loop in this case is requeueing the work using queue_delayed_work. That shouldn't be blocking jobs with shorter delays that are sitting on the same queue. Are you certain that's the case? That sounds like a bug in the workqueue implementation if so.

View: https://bugzilla.kernel.org/show_bug.cgi?id=218735#c2
You can reply to this message to join the discussion.
-- 
Deet-doot-dot, I am a bot.
Kernel.org Bugzilla (bugspray 0.1-dev)


