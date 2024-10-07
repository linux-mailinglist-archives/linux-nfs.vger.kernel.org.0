Return-Path: <linux-nfs+bounces-6905-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B3D5A992987
	for <lists+linux-nfs@lfdr.de>; Mon,  7 Oct 2024 12:51:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E95E7B20BDD
	for <lists+linux-nfs@lfdr.de>; Mon,  7 Oct 2024 10:51:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 031021C878E;
	Mon,  7 Oct 2024 10:51:21 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from outgoing.selfhost.de (mordac.selfhost.de [82.98.82.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56C9918BC29
	for <linux-nfs@vger.kernel.org>; Mon,  7 Oct 2024 10:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.98.82.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728298280; cv=none; b=Im6QzHJYeK6akKUwTuY+Y/qkz82Vz9CPfD8hVhcpWqbRM6HmQJpK/fogkzYu1ijBJZHuJTvpX2kTVjdp/2UkNuuce3ZF9+h1DRggBWqjvI3hE6AnLJrsWSx3oyJJIkYip2qqWFbRVIGaySCARgkfxUGy8swACSKXPCu/tEuu9gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728298280; c=relaxed/simple;
	bh=1d8JLoQRD61CkcOxLfPwFcsNtrhpCjZRAd3zy6Z9s+I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oWCuntTjTaR7UiYH8NcBL7kKoCATEqhQ4GzwSnYpgx0mL5XMjIiZ+ia/k/N74bw+iTd83KFh6tXMppDfTC2eUWSM1WKSQcper76HrwMbYUO/c2HAsZPJosANA5Kc0An77oPlvF51xa4oz3Rg1b1pSzSZV5L1pAPJfk7oIgkGSek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=afaics.de; spf=none smtp.mailfrom=afaics.de; arc=none smtp.client-ip=82.98.82.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=afaics.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=afaics.de
Received: (qmail 19645 invoked from network); 7 Oct 2024 10:51:08 -0000
Received: from unknown (HELO mailhost.afaics.de) (postmaster@xqrsonfo.mail.selfhost.de@79.192.205.88)
  by mailout.selfhost.de with ESMTPA; 7 Oct 2024 10:51:08 -0000
Received: from [IPV6:2003:e3:1f39:3702:68fd:ffff:fe6f:e76] (p200300e31f39370268fdfffffe6f0e76.dip0.t-ipconnect.de [2003:e3:1f39:3702:68fd:ffff:fe6f:e76])
	by marvin.afaics.de (OpenSMTPD) with ESMTP id 8e62a2f0;
	Mon, 7 Oct 2024 12:51:08 +0200 (CEST)
Message-ID: <f1e538b5-fd93-46f7-a8b1-8c0c649f5a11@afaics.de>
Date: Mon, 7 Oct 2024 12:51:08 +0200
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Linux)
Subject: Re: [syzbot] [nfs?] INFO: task hung in nfsd_umount
To: NeilBrown <neilb@suse.de>
Cc: syzbot <syzbot+b568ba42c85a332a88ee@syzkaller.appspotmail.com>,
 Jeff Layton <jlayton@kernel.org>, Dai.Ngo@oracle.com,
 chuck.lever@oracle.com, kolga@netapp.com, linux-nfs@vger.kernel.org,
 syzkaller-bugs@googlegroups.com, tom@talpey.com
References: <> <d8e1e97f-997f-4dca-8b3f-0628a3783957@afaics.de>
 <172808507143.1692160.17519936392458356798@noble.neil.brown.name>
From: Harald Dunkel <harri@afaics.de>
Content-Language: en-US
In-Reply-To: <172808507143.1692160.17519936392458356798@noble.neil.brown.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Neil,

ACK. Debian provided a new kernel version 6.1.112 for Bookworm, anyway.
May I send you a task dump of the running system (before nfsd getting
stuck) after the reboot, just for verification?

Regards
Harri

