Return-Path: <linux-nfs+bounces-6749-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 965E498B93B
	for <lists+linux-nfs@lfdr.de>; Tue,  1 Oct 2024 12:21:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7CFC1C2157F
	for <lists+linux-nfs@lfdr.de>; Tue,  1 Oct 2024 10:21:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D16F192D74;
	Tue,  1 Oct 2024 10:21:24 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from outgoing.selfhost.de (mordac.selfhost.de [82.98.82.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBAAF3209
	for <linux-nfs@vger.kernel.org>; Tue,  1 Oct 2024 10:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.98.82.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727778084; cv=none; b=ixLmCsstf9PqQ7Ss7dNvAOrncFYQnlSo3RW0Anehd6UDbSW9hD3mRnpLC9PF3C1pTLj0rk+4K9uWNT0cGPctYJIEA5ZHcKyaXgqGkzSRBbbI0TemDhCNrWsVKhSSSZ84s2F49kESedZmwTCP65RGpaAS/LAL0QxQx797qEdzhDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727778084; c=relaxed/simple;
	bh=nIEJCd6r8jdHG3hiQ/EJecnFYUPovPF+1NeAbP9Srhg=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=maMGVKqKdJbRDLDA+hmO83y6ccG7xNg9EZxvlILj611qJJBJJZ7sMcaXZIGmPV9DuzTmLVYSpNTXvyDUyx38UDMl3Hwsef9ZG6XD+K1XG3ODEPC5pnVPoZz6KCBJKX5worAx/FeXWd0pgXcfLDAeMhpWQ6LbwslNvN+HTCSZeF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=afaics.de; spf=none smtp.mailfrom=afaics.de; arc=none smtp.client-ip=82.98.82.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=afaics.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=afaics.de
Received: (qmail 6889 invoked from network); 1 Oct 2024 10:21:12 -0000
Received: from unknown (HELO mailhost.afaics.de) (postmaster@xqrsonfo.mail.selfhost.de@87.160.249.214)
  by mailout.selfhost.de with ESMTPA; 1 Oct 2024 10:21:12 -0000
Received: from cecil.afaics.de (p200300e31f1da20268fdfffffe6f0e76.dip0.t-ipconnect.de [2003:e3:1f1d:a202:68fd:ffff:fe6f:e76])
	by marvin.afaics.de (OpenSMTPD) with ESMTP id 1560a3b7;
	Tue, 1 Oct 2024 12:21:12 +0200 (CEST)
Subject: Re: [syzbot] [nfs?] INFO: task hung in nfsd_umount
To: NeilBrown <neilb@suse.de>
Cc: syzbot <syzbot+b568ba42c85a332a88ee@syzkaller.appspotmail.com>,
 Jeff Layton <jlayton@kernel.org>, Dai.Ngo@oracle.com,
 chuck.lever@oracle.com, kolga@netapp.com, linux-nfs@vger.kernel.org,
 syzkaller-bugs@googlegroups.com, tom@talpey.com
References: <> <90750d21-61fa-4243-8c6b-dbf6fa185ae4@afaics.de>
 <172760397625.470955.13033558054733497181@noble.neil.brown.name>
From: Harald Dunkel <harri@afaics.de>
Message-ID: <f1dc781f-d047-8d56-74b0-0af5484118db@afaics.de>
Date: Tue, 1 Oct 2024 12:21:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 SeaMonkey/2.53.18.2
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <172760397625.470955.13033558054733497181@noble.neil.brown.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

NeilBrown wrote:
> On Sun, 29 Sep 2024, Harald Dunkel wrote:
>>
>> I just learned that kernel.hung_task_panic = 1 should have been set, too.
>> Sorry for that. Currently I have
>>
>> 	kernel.hung_task_panic = 1
>> 	kernel.hung_task_all_cpu_backtrace = 1
>>
>> Please confirm.
> 
> You DON'T want hung_task_panic in this case.  If the system panics, it
> might do so before the watchdog you mention below fires.  We really need
> the sysrq-trigger output and the panic might interfere with that.
> 

Fixed. hung_task_panic has been reset to 0. Thank you for your reply.

Regards
Harri

