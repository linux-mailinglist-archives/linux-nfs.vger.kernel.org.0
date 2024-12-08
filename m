Return-Path: <linux-nfs+bounces-8430-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCDC29E880D
	for <lists+linux-nfs@lfdr.de>; Sun,  8 Dec 2024 22:19:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3EF732810BD
	for <lists+linux-nfs@lfdr.de>; Sun,  8 Dec 2024 21:19:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34DD814F12D;
	Sun,  8 Dec 2024 21:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZdRdTaTA"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C0D8211C
	for <linux-nfs@vger.kernel.org>; Sun,  8 Dec 2024 21:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733692792; cv=none; b=R6JhF2pnQ4xvO0edQBaozZcUbxZ4pE5yQkRWj/Bha/EkXFzVCrAUTOX1cBgfqd0EF6xK0Cc7at8FbOwFXGx6Kd8c2dks4IQudN7sdvp+8somnz5wEZdZyc9cJdle+eWarbuf0H5SuXs65yvK99MSnM01jURedHvfNxD9LHdAmm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733692792; c=relaxed/simple;
	bh=2KwikblR+MIO6o1uhiWoEYRdkpIRduy42qoYz1ffsZE=;
	h=From:Date:MIME-Version:Content-Type:To:Message-ID:In-Reply-To:
	 References:Subject; b=tG6Vps6p45i3JVe6VFoVVkiPSpdzCJ0ZrkmXkzD1NJnbxb+rpSmkQ95FRvOZc1vTFukc5P27YEJ5x9k0d183DBILKddlDAcWN1HeABQY+IYWl8SxeELodJ4ktluDGZoTo8Ws8HcgjIMS9hmpxDgJL7L/6uA55ojx8MI+OAzBWzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZdRdTaTA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B22DC4CED2;
	Sun,  8 Dec 2024 21:19:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733692791;
	bh=2KwikblR+MIO6o1uhiWoEYRdkpIRduy42qoYz1ffsZE=;
	h=From:Date:To:In-Reply-To:References:Subject:From;
	b=ZdRdTaTA9EyD+tLvRBz8NTyVAsPI5nToJajOJpJZmaQVnkupRP/77Y0TAAgzZP3PA
	 u1dcuIDF8zJfwhnmmoM92ek5m19cBXBI9ft7AD4DKCOPafrzvGY9tCzSWUlFNz42WG
	 mI+ah4uoDXcoJoPDhwgU+eUwVe+Cwj0eXhO4urDFs38N6qmy/18/DTJ1TYh3j45yVe
	 WXrsbnfYuG9G9INdCBoxnB6bxivd3mzK2OLCN2dm4WRp03nb62aFKMtraq98VR5Kvv
	 Q7tCY6ZfWyhaxIoE/dA7Cw4OS3l5G/BDpI7IYyh9WZQT/j16nKjt7cvWpi+D++UKP9
	 zHOEAZac2GXBw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F0625380A95D;
	Sun,  8 Dec 2024 21:20:07 +0000 (UTC)
From: Neil Brown via Bugspray Bot <bugbot@kernel.org>
Date: Sun, 08 Dec 2024 21:20:10 +0000
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: trondmy@hammerspace.com, jlayton@kernel.org, anna@kernel.org, 
 linux-nfs@vger.kernel.org, cel@kernel.org, trondmy@kernel.org
Message-ID: <20241208-b219550c6-03553d0a9ee6@bugzilla.kernel.org>
In-Reply-To: <20241203-b219550c0-abf5589a5df5@bugzilla.kernel.org>
References: <20241203-b219550c0-abf5589a5df5@bugzilla.kernel.org>
Subject: Re: deploying both NFS client and server on the same machine
 trigger hungtask
X-Bugzilla-Product: File System
X-Bugzilla-Component: NFSD
X-Mailer: bugspray 0.1-dev

Neil Brown writes via Kernel.org Bugzilla:

I think this bug was fixed in Linux v6.7 by

Commit ca1d36b82394 ("mm: shrinker: make global slab shrink lockless")

The shrinker_rwsem has been replaced by shrinker_mutex and is no longer held while shrinking slabs.  So if nfs4_evict_inode() blocks on a non-responsive server it may block one vmscan thread, but shouldn't cause any blockage outside of that filesystem.

You were using v5.10 which is 4 years old next week.  Please re-test with a newer kernel.

(And I think we *should* consider loop-back NFS to be supported in the sense that we will make a reasonable effort to fix any problems that are reported)

View: https://bugzilla.kernel.org/show_bug.cgi?id=219550#c6
You can reply to this message to join the discussion.
-- 
Deet-doot-dot, I am a bot.
Kernel.org Bugzilla (bugspray 0.1-dev)


