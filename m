Return-Path: <linux-nfs+bounces-1690-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C3CF845A0A
	for <lists+linux-nfs@lfdr.de>; Thu,  1 Feb 2024 15:21:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58B2A28E1A2
	for <lists+linux-nfs@lfdr.de>; Thu,  1 Feb 2024 14:21:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 043315D481;
	Thu,  1 Feb 2024 14:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jUVHaCAR"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D01355D473;
	Thu,  1 Feb 2024 14:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706797302; cv=none; b=uqraZ2kAajnHOdA6+pczspE4/W+pfDPM8zHuwOnbxOuLLADCIXYTWqUX51cWKYB4AFGSbnRbf4gkxAntIZeqQtnYkP0/L/5+FQEDulA1kedSKloLKpAmAJVYLWO3lts4xnPUNoPVkaSYW8PQrtOhUE1npsh2wzv7Icac8UULscA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706797302; c=relaxed/simple;
	bh=Oz6RaDZm9VL9jZcu+fBGFzPpumEBQEcrwn170ZLVWYE=;
	h=Subject:From:To:Cc:Date:Message-ID:MIME-Version:Content-Type; b=NvdR97D+fK9mCzHGHVXdJR8AjJSJ5YEnbMfTH6xvpyk8+F4JLwWtV5giXK5BvmIJS8IHu4OI06/si0tU6FK5ELOR/Gjs7aq8aKhxi29XA7hv2jE2JPwS8eQw4kpTVJOUHPaGTltVz7hyh4Tim0Xl7DeR6MFDTD0h6c/ir+oc/LY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jUVHaCAR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12B2EC433C7;
	Thu,  1 Feb 2024 14:21:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706797302;
	bh=Oz6RaDZm9VL9jZcu+fBGFzPpumEBQEcrwn170ZLVWYE=;
	h=Subject:From:To:Cc:Date:From;
	b=jUVHaCARmZ1OL685j+toc9ITj5e9Ny+TutaEEvtq8GEvTTR/4rEIf5bMx1FJXXbvT
	 g9RUYsr4k18WHnvFWh84m21wAlMCe4pXZT0VJSDZ0n+b6z1HBS8NrFysAw+Iy6TwRa
	 5ZkMDs7BJLYVQB63v/5WjD4orljQHIQYceoH9fNRno+8xCjdSsuTuTMZwBHQNarqCo
	 lt3rTH2h1FefGgPFQvt2b3TslxKczoqtMwBdfb09pl8fOxNUNfob2BB3EGSC0tqiy3
	 7BV8fM/GXOmluWe+DdhmYTFB6WgeGk+gmecHBabjygstC+XFIGibnz9BXVa9PBmvaP
	 ZgfTnU1IOW+pg==
Subject: [PATCH 0/3] Fix RELEASE_LOCKOWNER
From: Chuck Lever <cel@kernel.org>
To: stable@vger.kernel.org
Cc: linux-nfs@vger.kernel.org
Date: Thu, 01 Feb 2024 09:21:40 -0500
Message-ID: 
 <170679726132.13994.12738575104218499729.stgit@klimt.1015granger.net>
User-Agent: StGit/1.5
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Passes pynfs, fstests, and the git regression suite. Please apply
these to origin/linux-5.15.y.

---

Chuck Lever (3):
      NFSD: Modernize nfsd4_release_lockowner()
      NFSD: Add documenting comment for nfsd4_release_lockowner()
      From: NeilBrown <neilb@suse.de>


 fs/nfsd/nfs4state.c | 65 +++++++++++++++++++++++++--------------------
 1 file changed, 36 insertions(+), 29 deletions(-)

--
Chuck Lever


