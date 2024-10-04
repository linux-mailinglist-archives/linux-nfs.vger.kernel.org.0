Return-Path: <linux-nfs+bounces-6854-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4B799902D5
	for <lists+linux-nfs@lfdr.de>; Fri,  4 Oct 2024 14:21:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03A132831EF
	for <lists+linux-nfs@lfdr.de>; Fri,  4 Oct 2024 12:21:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4090156861;
	Fri,  4 Oct 2024 12:21:44 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from outgoing.selfhost.de (mordac.selfhost.de [82.98.82.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D5392747B
	for <linux-nfs@vger.kernel.org>; Fri,  4 Oct 2024 12:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.98.82.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728044504; cv=none; b=W0m1B5J/u1a9eLLCLMm9refxvrqooD9rnJzzbGLgxoDA75C/ej4txAYzbzG8nn9ZPZQuGffwFrGGd6HbAlb6sgWJX9e9R+zvIZHIUbWuTWf+CFV5IgxC177gLyd9u5TViOjjzsPxRBlBZntdfpBHlgGKZaA/qN8nncPs+RGi0pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728044504; c=relaxed/simple;
	bh=s/LaVHXwuHUNd1OX8vU824ork30oPokoiBWJHSBXTDU=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=a/ELXOpq7h/IXPn46qrngyDEwbagd5XCEjpGcYkemL86PIW4Axjv0ujzHoqtOOh3hp3eqQy3ydQsNPzLPFydOSthXN4euep1C9zbGGIctbapcLe0Ysj22KZ5xyHTnboAJ7874XDgPA3819PRT0MZCk2ispfqAhfD0MKc42qFUZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=afaics.de; spf=none smtp.mailfrom=afaics.de; arc=none smtp.client-ip=82.98.82.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=afaics.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=afaics.de
Received: (qmail 28031 invoked from network); 4 Oct 2024 12:21:33 -0000
Received: from unknown (HELO mailhost.afaics.de) (postmaster@xqrsonfo.mail.selfhost.de@62.158.97.45)
  by mailout.selfhost.de with ESMTPA; 4 Oct 2024 12:21:33 -0000
Received: from [IPV6:2003:e3:1f17:8802:68fd:ffff:fe6f:e76] (p200300e31f17880268fdfffffe6f0e76.dip0.t-ipconnect.de [2003:e3:1f17:8802:68fd:ffff:fe6f:e76])
	by marvin.afaics.de (OpenSMTPD) with ESMTP id e7278ad2;
	Fri, 4 Oct 2024 14:21:32 +0200 (CEST)
Message-ID: <0c765314-3e78-4c2f-8280-9ae337ff0bf6@afaics.de>
Date: Fri, 4 Oct 2024 14:21:32 +0200
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Linux)
Subject: Re: [syzbot] [nfs?] INFO: task hung in nfsd_umount
From: Harald Dunkel <harri@afaics.de>
To: NeilBrown <neilb@suse.de>
Cc: syzbot <syzbot+b568ba42c85a332a88ee@syzkaller.appspotmail.com>,
 Jeff Layton <jlayton@kernel.org>, Dai.Ngo@oracle.com,
 chuck.lever@oracle.com, kolga@netapp.com, linux-nfs@vger.kernel.org,
 syzkaller-bugs@googlegroups.com, tom@talpey.com
References: <> <90750d21-61fa-4243-8c6b-dbf6fa185ae4@afaics.de>
 <172760397625.470955.13033558054733497181@noble.neil.brown.name>
 <f1dc781f-d047-8d56-74b0-0af5484118db@afaics.de>
 <70fafc6b-333b-45b7-a355-51f3115fafec@afaics.de>
 <d8e1e97f-997f-4dca-8b3f-0628a3783957@afaics.de>
Content-Language: en-US
In-Reply-To: <d8e1e97f-997f-4dca-8b3f-0628a3783957@afaics.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-10-02 16:06:14, Harald Dunkel wrote:
> PS: dmesg -T attached as well.

PPS: I learned another thing today: I have to disable kernel
logging in the containers. Sorry about that. The nfsd died
again today, but I doubt that the new log files are very useful.
Please mail if you are interested.

The NFS server has been rebooted (without imklog syslog module
in the containers) and the watchdog has been started again.


Regards

Harri

