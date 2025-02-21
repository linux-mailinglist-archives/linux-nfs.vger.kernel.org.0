Return-Path: <linux-nfs+bounces-10273-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 80096A3FAA6
	for <lists+linux-nfs@lfdr.de>; Fri, 21 Feb 2025 17:18:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DE4988034B
	for <lists+linux-nfs@lfdr.de>; Fri, 21 Feb 2025 16:06:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FBD421505F;
	Fri, 21 Feb 2025 15:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YSVsLDY6"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19DC6215068
	for <linux-nfs@vger.kernel.org>; Fri, 21 Feb 2025 15:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740153577; cv=none; b=Ox0KOCnhyzxmkEfULZ4z4RyS73mePc0k0yDr7HDLbfg3gniBcPBGqJ79NonU0epw1gATTiVzIWcfcEfWgVDyAfLuVys9X6Qvk4gY3nS2q/a3UCtb+SLrHoGb9cddxmviABxTKv7Zw9qLql/DLIkyvMt3UF5E1UYp9/fXk128w34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740153577; c=relaxed/simple;
	bh=n0jF/j+mywMBUT0PErvXB3Zxie09TU9q8D93fb/8S/I=;
	h=From:Date:MIME-Version:Content-Type:To:Message-ID:In-Reply-To:
	 References:Subject; b=qAqEIwbgcUNe5i38vjsR4sUwxOfor+f1tujPKytXkAWpbF0LBZKyFGiEzcbd/ltqq+O3QTiTsgzCYYGVsEpQYjt03849LerQggSqh/DWBJRaxT66j9H36bEEp+uqcbAPNNbUHmM5LSLToiwmdnSy+VBy5FJFO2j/PXfrXULTKZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YSVsLDY6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81685C4CED6;
	Fri, 21 Feb 2025 15:59:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740153576;
	bh=n0jF/j+mywMBUT0PErvXB3Zxie09TU9q8D93fb/8S/I=;
	h=From:Date:To:In-Reply-To:References:Subject:From;
	b=YSVsLDY6SHQFpg+kwgREXXvckcg5/AzV3O7ZPIcuxzQaDZGN5poSnu3juIhwVorWu
	 UjSklKqyFi6pB3+zG076kmM1ZLKEYsGUvlZeOAnay12b0CNj97tCOzHn2F6rOD55UE
	 26uF06ktS0md0374e9iQ5BNaLJBlNAomHCH297Op4efpoRTSUDg5Iubkhp1o8PZ6z8
	 xLIiHXcz/d/B7EKs6DQyJ8fblQAtqHBT045j/4hxpHTNHmW1TCdXD8ejKLPWs3KQ8A
	 q1ALdazIWoVKAHAd0YMhgTNk3j0ZFK4hYBFTktjchjCUuwRP+wqQ3dBrZf42mxdgI5
	 wsOzeJmZJSx6g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 77B89380CEEE;
	Fri, 21 Feb 2025 16:00:08 +0000 (UTC)
From: Chuck Lever via Bugspray Bot <bugbot@kernel.org>
Date: Fri, 21 Feb 2025 16:00:39 +0000
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: tom@talpey.com, benoit.gschwind@minesparis.psl.eu, herzog@phys.ethz.ch, 
 trondmy@kernel.org, carnil@debian.org, jlayton@kernel.org, 
 chuck.lever@oracle.com, baptiste.pellegrin@ac-grenoble.fr, 
 harald.dunkel@aixigo.com, cel@kernel.org, anna@kernel.org, 
 linux-nfs@vger.kernel.org
Message-ID: <20250221-b219710c35-1dad5fc2b192@bugzilla.kernel.org>
In-Reply-To: <Z7iC42RF-7Qj2s4d@eldamar.lan>
References: <Z7iC42RF-7Qj2s4d@eldamar.lan>
Subject: Re: NFSD threads hang when destroying a session or client ID
X-Bugzilla-Product: File System
X-Bugzilla-Component: NFSD
X-Mailer: bugspray 0.1-dev

Chuck Lever writes via Kernel.org Bugzilla:

(In reply to Bugspray Bot from comment #29)
> So I see the backport of 961b4b5e86bf NFSD: Reset cb_seq_status after
> NFS4ERR_DELAY landed in the just released 6.1.129 stable version.
> 
> Do we consider this to be sufficient to have stabilized the situation
> about this issue? (I do  realize much other work has dne as well which
> partially has flown down to stable series already).
> 
> This reply is mainly in focus of https://bugs.debian.org/1071562

Since we do not have a reproducer, it's difficult to ascertain with certainty that the issue has been addressed. Thus I feel it is up to the various original reporters to decide if they are happy with the solution above.

I'm comfortable leaving this bug open for a while.

View: https://bugzilla.kernel.org/show_bug.cgi?id=219710#c35
You can reply to this message to join the discussion.
-- 
Deet-doot-dot, I am a bot.
Kernel.org Bugzilla (bugspray 0.1-dev)


