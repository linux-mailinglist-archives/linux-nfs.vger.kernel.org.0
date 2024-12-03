Return-Path: <linux-nfs+bounces-8328-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C15159E22C4
	for <lists+linux-nfs@lfdr.de>; Tue,  3 Dec 2024 16:28:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 07A42B24604
	for <lists+linux-nfs@lfdr.de>; Tue,  3 Dec 2024 14:49:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E94722AF05;
	Tue,  3 Dec 2024 14:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gJ1fztW0"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C50E41F12E0
	for <linux-nfs@vger.kernel.org>; Tue,  3 Dec 2024 14:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733237393; cv=none; b=VhmdCExR4a9USbGpLx0qSLX1tOX93Td0J0VGA7FE17Q77SykRj091xuM2OppzHBi8KoKuHkI9FkXX2HA/+RphQdXh9b7i7G3tFZz7QoCBHJvXmR6SJpIbTz/hjXF+HADjQVpaj6vaGqoddcmmhrt+aDX0Z9iBwir5nYa0psaBVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733237393; c=relaxed/simple;
	bh=HaeVAv7x/mxFjWpSAoXAaOzy6HTH3nl/0XtkMY3/sP0=;
	h=From:Date:MIME-Version:Content-Type:To:Message-ID:In-Reply-To:
	 References:Subject; b=sfSLjC9LyaRwRMMaskT4is3yPHbLzCU8ewyVPHDocFdDij3Au+04PN8YajsrTIU/cMwjGnSbwrEq5YGcbkvjEnbzw9APjn5moM7zaHPeTOucmdG8xS3im3xMT0dqefMXVxeKV3yI2lhqrGym+hMlYthpfC0zUmvrJiurWEDp/VU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gJ1fztW0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B003C4CECF;
	Tue,  3 Dec 2024 14:49:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733237393;
	bh=HaeVAv7x/mxFjWpSAoXAaOzy6HTH3nl/0XtkMY3/sP0=;
	h=From:Date:To:In-Reply-To:References:Subject:From;
	b=gJ1fztW0red8IyekvKTVPUD1lrrtv79rVy4ljUZ+f2YY6dlX9KYJKp5S3XNdUj+HI
	 7rieghbRR9ZPgbVfMM6pE5Pn4MMJVz/zOYLMV/9x84UCZ1jSD+2CKRY9DWe21+5LWF
	 2d1ZaQn8AMWpioEIRK9fhFH70gSnrjBbn+LeGTDJ/YQXsJDmt6iqgxBzBzvqGaNBRM
	 1zhXkGF9CysI09xETfcIFxixOqUXieiwoydIcxRpFpaYWXbFdqGNiAo1oTOz7XJyLt
	 YMJ7qNTDhr8HjnVVjZxS8Uumj1qxYF6XgdBfdanb1uoDsOsJfLfqotbuNv/YS17Vve
	 VMc8iHtiRBdQw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7A3C63806656;
	Tue,  3 Dec 2024 14:50:08 +0000 (UTC)
From: Chuck Lever via Bugspray Bot <bugbot@kernel.org>
Date: Tue, 03 Dec 2024 14:50:06 +0000
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: anna@kernel.org, trondmy@kernel.org, cel@kernel.org, 
 linux-nfs@vger.kernel.org, jlayton@kernel.org
Message-ID: <20241203-b219550c2-39095e50bfcb@bugzilla.kernel.org>
In-Reply-To: <3fd8e0681020f95832fadf9da7fa4de4d51efaed.camel@kernel.org>
References: <3fd8e0681020f95832fadf9da7fa4de4d51efaed.camel@kernel.org>
Subject: Re: deploying both NFS client and server on the same machine
 trigger hungtask
X-Bugzilla-Product: File System
X-Bugzilla-Component: NFSD
X-Mailer: bugspray 0.1-dev

Chuck Lever writes via Kernel.org Bugzilla:

(In reply to Bugspray Bot from comment #1)
> Jeff Layton <jlayton@kernel.org> writes:
> 
> On Tue, 2024-12-03 at 02:30 +0000, Li Lingfeng via Bugspray Bot wrote:
> > Li Lingfeng writes via Kernel.org Bugzilla:
> > 
> > We deployed the client and server on the same machine for some testing,
> which
> > caused some processes to trigger hungtask.

Thanks for the report.


> Note that this is really an unsupported configuration. It's very
> difficult to prevent a situation where the server needs memory in order
> to handle an RPC from the local client, and then tries to write back
> dirty NFS client pages in order to get it. Instant deadlock.
> 
> That kind of configuration is fine for basic functionality testing, but
> once you start getting into memory pressure, it can fall over pretty
> quickly.

Historically, yes, this configuration is officially unsupported. We treat this configuration as best effort only because it is not possible to close all possible writeback deadlocks, as you said above.

However, Neil has mentioned that it is an important usage scenario for one or more of SuSE's customers. And, it is quite broadly deployed for automated testing.

This particular bug appears to be locking related, not writeback related. IMO, deeper investigation is warranted.

View: https://bugzilla.kernel.org/show_bug.cgi?id=219550#c2
You can reply to this message to join the discussion.
-- 
Deet-doot-dot, I am a bot.
Kernel.org Bugzilla (bugspray 0.1-dev)


