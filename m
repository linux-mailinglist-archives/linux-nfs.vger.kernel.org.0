Return-Path: <linux-nfs+bounces-11295-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD3C3A9DC4A
	for <lists+linux-nfs@lfdr.de>; Sat, 26 Apr 2025 18:46:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2300E3B02C2
	for <lists+linux-nfs@lfdr.de>; Sat, 26 Apr 2025 16:45:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC45B1FC0F0;
	Sat, 26 Apr 2025 16:46:11 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from outgoing.selfhost.de (mordac.selfhost.de [82.98.82.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 643822628D
	for <linux-nfs@vger.kernel.org>; Sat, 26 Apr 2025 16:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.98.82.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745685971; cv=none; b=LaB/AgzZG6JQiPqtxM+6B73toC835/M+DJTvGYVF1xgff5z2eDSUHmDq5lbmky9JXxRXY3oh+D5XgDXWp4Db7MHUFfR9PAapln1HTQLibqkazEW6cOXveuFNtVJHr3aymSV2ajgwR492mle4+G+AvjzfZbpVWmLgqX4jr33DWj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745685971; c=relaxed/simple;
	bh=lEjaKtgUKg6eVqHfBbDBbBg270OpNTl2g7WtKotxR3s=;
	h=To:From:Subject:Message-ID:Date:MIME-Version:Content-Type; b=iODzse8yIApsn6hWqfOqyTdbwKmax4CSN2jrbE2SxBIDydiqDY8PU8JhXk2Mnf4rpikLsFxFzceMTagQBd+3oQOGl45PaMgJoT9a5ZQfx1nS0picJ+TJzNPh0txl0I2YQuQLJJROeuTZTs7Gm+6CXcuAJirJAhMgxyePK7Je2qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=afaics.de; spf=none smtp.mailfrom=afaics.de; arc=none smtp.client-ip=82.98.82.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=afaics.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=afaics.de
Received: (qmail 11974 invoked from network); 26 Apr 2025 16:39:24 -0000
Received: from unknown (HELO mailhost.afaics.de) (postmaster@xqrsonfo.mail.selfhost.de@62.158.99.252)
  by mailout.selfhost.de with ESMTPA; 26 Apr 2025 16:39:24 -0000
X-Spam-Level: 
X-Spam-Report: 
	*  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
	*  0.0 DMARC_MISSING Missing DMARC policy
	*  0.4 KHOP_HELO_FCRDNS Relay HELO differs from its IP's reverse DNS
Received: from cecil.afaics.de (p200300e31f37680268fdfffffe6f0e76.dip0.t-ipconnect.de [2003:e3:1f37:6802:68fd:ffff:fe6f:e76])
	by marvin.afaics.de (OpenSMTPD) with ESMTP id 77240c1a;
	Sat, 26 Apr 2025 18:39:20 +0200 (CEST)
To: linux-nfs@vger.kernel.org
From: Harald Dunkel <harri@afaics.de>
Subject: rpc-statd.service: State 'stop-sigterm' timed out. Killing.
Message-ID: <506d5e52-87dd-038e-7a52-7dcc1b8c3427@afaics.de>
Date: Sat, 26 Apr 2025 18:39:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:128.0) Gecko/20100101
 Firefox/128.0 SeaMonkey/2.53.20
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi folks,

Sometimes restarting rpc-statd.service runs into a timeout:

:
Apr 26 18:18:22 lola.afaics.de systemd[1]: Stopping rpc-statd.service - NFS status monitor for NFSv2/3 locking....
Apr 26 18:19:52 lola.afaics.de systemd[1]: rpc-statd.service: State 'stop-sigterm' timed out. Killing.
Apr 26 18:19:52 lola.afaics.de systemd[1]: rpc-statd.service: Killing process 1688 (rpc.statd) with signal SIGKILL.
Apr 26 18:19:52 lola.afaics.de systemd[1]: rpc-statd.service: Main process exited, code=killed, status=9/KILL
Apr 26 18:19:52 lola.afaics.de systemd[1]: rpc-statd.service: Failed with result 'timeout'.
Apr 26 18:19:52 lola.afaics.de systemd[1]: Stopped rpc-statd.service - NFS status monitor for NFSv2/3 locking..
Apr 26 18:19:52 lola.afaics.de systemd[1]: Starting rpcbind.service - RPC bind portmap service...
Apr 26 18:19:52 lola.afaics.de systemd[1]: Started rpcbind.service - RPC bind portmap service.
Apr 26 18:19:52 lola.afaics.de systemd[1]: Starting rpc-statd.service - NFS status monitor for NFSv2/3 locking....
Apr 26 18:19:52 lola.afaics.de rpc.statd[26501]: Version 2.8.3 starting
Apr 26 18:19:52 lola.afaics.de rpc.statd[26501]: Flags: TI-RPC
Apr 26 18:19:52 lola.afaics.de systemd[1]: Started rpc-statd.service - NFS status monitor for NFSv2/3 locking..
:

nfs-utils is version 2.8.3, as provided in Debian Sid. Restart
is done by a tool "needrestart", which might restart several
services in parallel.

Is this a known problem? I had reported this initially on the Debian
bug tracker, see https://bugs.debian.org/1067006

Regards
Harri

