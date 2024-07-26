Return-Path: <linux-nfs+bounces-5061-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E714493CD09
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Jul 2024 05:38:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8038E1F21415
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Jul 2024 03:38:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 401F220DC3;
	Fri, 26 Jul 2024 03:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nh2.me header.i=@nh2.me header.b="gy/vG5Va"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail.nh2.me (mail.nh2.me [116.202.188.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AFB123A8
	for <linux-nfs@vger.kernel.org>; Fri, 26 Jul 2024 03:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.202.188.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721965086; cv=none; b=UX6KqbF5bdyRtNPm1nrZeCASyZWzg9KbWhoXK8Q2vC7o4Pkoy73z+sZ02hI+tpY0TcPTdex6o8pG9X9cY0mCI8O4D2A97hHMQbmKxJOA72jF3zziUbzhqRlvGsc97gucK+h/Q9ataJ7wpwN11oDuW/OrXC49pT9n8AI2hgC9R5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721965086; c=relaxed/simple;
	bh=oY1PKGHtwIdUGkQqhG/YXKNQG7iLaFp5E70MWLZGoIQ=;
	h=Message-ID:Date:MIME-Version:From:To:Subject:Content-Type; b=iKLjJJvv5EGVa+OjU/mC6MhX5k/dYk8TeroEUDGXFrfrQn7Jn+KUZsPWGH2YzgnhRPBxMJPwnt3wUVhUXX2NJ+OuWScJRTDnwYDWPODmM5iVE06cW7LbHbbpGUufurIwBug3xmwIc9wAtBARVBS5CMnxZtDn21VzT97uiETSSa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nh2.me; spf=pass smtp.mailfrom=nh2.me; dkim=pass (2048-bit key) header.d=nh2.me header.i=@nh2.me header.b=gy/vG5Va; arc=none smtp.client-ip=116.202.188.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nh2.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nh2.me
Message-ID: <dfcca43f-0dad-4188-b092-0176cfaab2c8@nh2.me>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nh2.me; s=mail;
	t=1721964751; bh=oY1PKGHtwIdUGkQqhG/YXKNQG7iLaFp5E70MWLZGoIQ=;
	h=Date:From:To:Subject;
	b=gy/vG5Vala0D71uIJ80SH5st/hV2VNfzREWlfHneUnM76IRBLj3CcIYHappCrupBd
	 HSiB1nJ13e0fiZ1cVGxk7bzOUibqKv7HFefm560lv30EOSoCCbFHjMA+GKlvWvP55l
	 el3NDFyxI1UgiIGx3JwRpN0916lcUORWRubeNayOQ7qj35PAPQAy6DO0LQUeHl0vbg
	 1LXfRgKriTi3dZ+2fJCZRz+bqL3TrLb73tJybSm42KIZGLcQiDcfAvo8wWA7J6f93P
	 P/lTv5onMhYUI87bgIcSOrI29VMT77ZVkL5ebyJYqW0gsRIFThWxsHvvixpYtTezZJ
	 H14a3sGiqF9uQ==
Date: Fri, 26 Jul 2024 05:32:30 +0200
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: =?UTF-8?Q?Niklas_Hamb=C3=BCchen?= <mail@nh2.me>
Content-Language: en-US
To: linux-nfs@vger.kernel.org
Subject: Can rpc.mountd NOT be hardcoded to listen on 0.0.0.0?
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

I found that `rpc.mountd` is hardcoded to listen on NULL == INADDR_ANY == 0.0.0.0:

https://serverfault.com/questions/1110431/how-to-specify-a-specific-bind-address-for-nfs-kernel-server-on-debian-11-4/1163083#1163083

This makes it impossible to reduce the attack surface by e.g. restricting it to a VPN IP address.

Is there a technical reason for that (while other NFS daemons support `--host` flags and `host` config options), or is that just historical?

Thanks!

