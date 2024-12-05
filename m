Return-Path: <linux-nfs+bounces-8347-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F097B9E4C1A
	for <lists+linux-nfs@lfdr.de>; Thu,  5 Dec 2024 03:04:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96A971881567
	for <lists+linux-nfs@lfdr.de>; Thu,  5 Dec 2024 02:04:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EC737E782;
	Thu,  5 Dec 2024 02:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hyub.org header.i=@hyub.org header.b="W7X4k78R"
X-Original-To: linux-nfs@vger.kernel.org
Received: from hyub.org (hyub.org [45.33.94.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCC144C96
	for <linux-nfs@vger.kernel.org>; Thu,  5 Dec 2024 02:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.33.94.86
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733364266; cv=none; b=eLtXbJS0VnkD4wzRYqOnL+eXCK+gO5xGfhhD1ciHV323JsG5/BUYDPbtZlk8kj0Wd0GTHMLbDR8L+EV/2O/h9nS2XyWp0gjoCTOl7OhzcTt+j19WG+wtJj02sPsMMJhLlBkuGxUAm8TEGZ3lg+LnNgGbk6hmxnu3AIMl5wfP3/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733364266; c=relaxed/simple;
	bh=oZUjEt1nAp88r7ZXD9ohmf6+l/gVxKkb0aT/NmBpH9I=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=WNnojYBvMeiDeTLFTpp9auJ68PQJzA8jMkHix55X4Chr0lT8rmMyc4oLmHtl2vd7uMHYkX64r+xUBXQd0/DgjiP+OoStS+4Bzn8BWHs4OrZG3GO9RWDd4lSxNQxZDd+yF/esZGcnox+yIOHnMitxhYvnSIuiQQg2B93+xb2Fx1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hyub.org; spf=pass smtp.mailfrom=hyub.org; dkim=pass (2048-bit key) header.d=hyub.org header.i=@hyub.org header.b=W7X4k78R; arc=none smtp.client-ip=45.33.94.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hyub.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hyub.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hyub.org; s=dkim;
	t=1733364260;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=9m/CTvspUXjyBkKUm8pU+9Dowbxk9sI4aH5MM6NAKTA=;
	b=W7X4k78RjSSOV6525PNFCq3Ge82KpdHBYiGJyarR8EhJ/sQTtGmb8lUyOgoIlZqbEty86u
	4g8Mtn/29j6dFzbKjONZZnFI9Vu84WxXLATng2S1JlFM4f9z9YkqClHmBfNysKs1NYr2lq
	d3sVeJB2ut0H7XJCRroznMTtD/dAI5Z5luHNag4br3Y7CRz+QRJ12HaMg6jig2Dnjdgft9
	m1L3N3Zdyg0CmlScqh5FFrZDCh0mq3TfM43f/EBzTvnFyZoUkSDux1uTdR+aCX2XsIgS81
	ycKAqozR0aJAt+Gz38SNKMLjGLSPA4QO8eTVpNzzR2+RaxVLVRgxRh51jSwdlA==
Message-ID: <ccb8fb74-7b8d-418b-bbbc-9848aeb8a6c8@hyub.org>
Date: Thu, 5 Dec 2024 02:04:00 +0000
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Christopher Bii <christopherbii@hyub.org>
Subject: [PATCH 0/2] nfsd symlink vulnerability patch
To: steved@redhat.com
Cc: linux-nfs@vger.kernel.org
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

It is hinted in the configuration files that an attacker could gain 
access to arbitrary folders by guessing symlink paths that match 
exported dirs, but this is not the case. They can get access to the root 
export with certainty by simply symlinking to "../../../../../../../", 
which will nearly* always return "/".

This is due to realpath() being called in the main thread which isn't 
chrooted, concatenating the result with the export root to create the 
export entry's final absolute path which the kernel then exports.

Also, a linker issue arose so I have added another small hack just to 
get it compiled correctly.


Christopher Bii (2):
   Exportfs changes - When a export rootdir is present, nfsd_realpath()
     wrapper is used to   avoid symlink exploits. - Removed
     canonicalization of rootdir paths. Export rootdir must now be   an
     absolute path. - Implemented nfsd_path.h
   Temporary fix for build issue for mount util.

  support/export/export.c     |  24 +--
  support/include/nfsd_path.h |   9 +-
  support/misc/nfsd_path.c    | 362 ++++++++++++------------------------
  support/nfs/exports.c       |  59 +++---
  utils/exportfs/exportfs.c   |   8 +-
  5 files changed, 170 insertions(+), 292 deletions(-)

-- 
2.47.1


