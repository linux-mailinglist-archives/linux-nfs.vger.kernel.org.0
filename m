Return-Path: <linux-nfs+bounces-6493-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6876979684
	for <lists+linux-nfs@lfdr.de>; Sun, 15 Sep 2024 13:45:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D91851C20DA5
	for <lists+linux-nfs@lfdr.de>; Sun, 15 Sep 2024 11:45:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D58771C57A1;
	Sun, 15 Sep 2024 11:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dinrJRa/"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE3711C6F53
	for <linux-nfs@vger.kernel.org>; Sun, 15 Sep 2024 11:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726400708; cv=none; b=i/Py8WrDCsohP6gY8zqWurS/P+eo6mLcHkpB/VyTRIyjrAMpvFcyuJ2npFnDSi8R7xTnk7wazU/zEoQmVpYmJXp+c7fzyZ0EUJukXVY1JvWKTG7lg/Ewel/9m3OpLR2HLvLEW2hA7SqIN/j6xRBsHTnAH4v9SO/J/lJewWDHYDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726400708; c=relaxed/simple;
	bh=bnY/h/6PyBz2C/BtCnXPpEM/llvY0zKVi+aVzEgfxtk=;
	h=From:Date:MIME-Version:Content-Type:To:Message-ID:In-Reply-To:
	 References:Subject; b=YWQOPpqvm9CwIYbm2CRI0OFzGjuSkumJDakMsIsm4fiXxXyA9hEvcz5U/YV0j1TlyPnetjCxBsK3FwuYibwQHlKXBQSn093ADW/h3sgZx8qCn7+FTKWfgu+sXwapTy3gbcH2i61B9Pm3kY0PHhQBTyqwSKl3UzgWeD/PFMl8ZUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dinrJRa/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34079C4CECF;
	Sun, 15 Sep 2024 11:45:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726400708;
	bh=bnY/h/6PyBz2C/BtCnXPpEM/llvY0zKVi+aVzEgfxtk=;
	h=From:Date:To:In-Reply-To:References:Subject:From;
	b=dinrJRa/2KuLpTATyOAGZJRSuFAuDssZnDpJSXzkwY0h+6vlV3UOEIR4eO3RESAmT
	 gZD3vIciC3LwygKKsNz/jN3srnEVTUQDEE90oYCyuJC3oa6EEs+en5WmyJKegEhosV
	 ZAFnAdNHPpHc9C7izFADu1bBevrzK49vGh6jqJQ0Gxqs1ITC6PXqqkJ4JwONsk/0Og
	 8r8Gx7z62SPtul/a5AecWJOIRhEx1ISC4+93IqH8D71jaZ6qWwVVTz6vaJW50ztfWO
	 YJJ+t7nDAPqu3N627yV0Aj5AWd9/H8t703Bt8mkxatpE1/fAHBgzxROz2MwhW7e0nv
	 ZnsnEVNSzUxrg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B52C83822D1B;
	Sun, 15 Sep 2024 11:45:10 +0000 (UTC)
From: Max via Bugspray Bot <bugbot@kernel.org>
Date: Sun, 15 Sep 2024 11:45:05 +0000
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: anna@kernel.org, cel@kernel.org, linux-nfs@vger.kernel.org, 
 jlayton@kernel.org, trondmy@kernel.org
Message-ID: <20240915-b219278c1-8afd87715402@bugzilla.kernel.org>
In-Reply-To: <20240914-b219278c0-d3a919d16eb1@bugzilla.kernel.org>
References: <20240914-b219278c0-d3a919d16eb1@bugzilla.kernel.org>
Subject: Re: >=linux-6.6.0: Resource temporarily unavailable when reading
 file attributes the first time
X-Bugzilla-Product: File System
X-Bugzilla-Component: NFSD
X-Mailer: bugspray 0.1-dev

Max writes via Kernel.org Bugzilla:

I have succesfully reproduced the bug, I will try to fix it.

View: https://bugzilla.kernel.org/show_bug.cgi?id=219278#c1
You can reply to this message to join the discussion.
-- 
Deet-doot-dot, I am a bot.
Kernel.org Bugzilla (bugspray 0.1-dev)


