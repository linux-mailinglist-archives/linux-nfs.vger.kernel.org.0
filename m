Return-Path: <linux-nfs+bounces-1205-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6300683277F
	for <lists+linux-nfs@lfdr.de>; Fri, 19 Jan 2024 11:13:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95D2D1C2252F
	for <lists+linux-nfs@lfdr.de>; Fri, 19 Jan 2024 10:13:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FF433C463;
	Fri, 19 Jan 2024 10:13:46 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A6313CF4B;
	Fri, 19 Jan 2024 10:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705659226; cv=none; b=OQpsBmZrMHr983c9ZhyqxdAPm+RQuVF42Ppg4yJHVCwv6Y6QncOrk98giowHE2aezxOnFso1JF8jFiF9bZ1sqF3fSkRl5k1bWNHKFy43Q2uLgDqUjeYBOdBBlDk29ivQuIW6ELS/Hn4uSrvuTqOWrGFRW180ScY/b5jBPTUqxEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705659226; c=relaxed/simple;
	bh=fyaI7QjyqAD2QONVkKww5YnWgFmNlPSIUVF2RxNi8Ho=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pt5O4CDxOp0F2i4ygPJZXI/84z/+DCdgOBUgrWSQKPtMnB5Y9sDMefRJFiMBwK+oNe6kIYfGIvMkPFPkiRl/ObGbCQQ2PwO5hsD+xf7ed9L/Pc6rX4dWZsdxu4v/NAzklxT1/n8bIIVqP1ZzuhqlRZK2EFbEQTPYauKIJHyNIV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1rQlsc-0003OF-BQ; Fri, 19 Jan 2024 11:13:42 +0100
Message-ID: <7b8841eb-eb5e-4518-b5a8-d94e163fd203@leemhuis.info>
Date: Fri, 19 Jan 2024 11:13:42 +0100
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] After kernel upgrade 6.1.70 to 6.1.71, the computer
 hangs during shutdown
Content-Language: en-US, de-DE
To: regressions@lists.linux.dev
Cc: stable@vger.kernel.org, linux-nfs@vger.kernel.org
References: <58ac38ae-4d64-4a53-81e0-35785961c41c.ref@yahoo.com>
 <58ac38ae-4d64-4a53-81e0-35785961c41c@yahoo.com>
From: "Linux regression tracking #update (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <58ac38ae-4d64-4a53-81e0-35785961c41c@yahoo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1705659224;35e35129;
X-HE-SMSGID: 1rQlsc-0003OF-BQ

On 11.01.24 09:20, email200202 wrote:
> 
> #regzbot introduced: v6.1.70..v6.1.71
> 
> 
> After kernel upgrade 6.1.70 to 6.1.71, the computer hangs during shutdown.
> 
> The problem is related to NFS service. Stopping NFS service hangs:
> 
> # /etc/init.d/nfs  stop
>  * Caching service dependencies ... [ ok ]
>  * Stopping NFS mountd ... [ ok ]
>  * Stopping NFS daemon ... [ ok ]
> [...]

#regzbot fix: b2c545c39877408a2fe2
#regzbot ignore-activity

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
That page also explains what to do if mails like this annoy you.

