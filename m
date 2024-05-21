Return-Path: <linux-nfs+bounces-3300-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B2288CAB51
	for <lists+linux-nfs@lfdr.de>; Tue, 21 May 2024 11:56:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15C0A281E47
	for <lists+linux-nfs@lfdr.de>; Tue, 21 May 2024 09:56:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4878560EC4;
	Tue, 21 May 2024 09:56:39 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1451156763
	for <linux-nfs@vger.kernel.org>; Tue, 21 May 2024 09:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716285399; cv=none; b=GJ9sxBV1GLiY4f26/rMbR9MraKBzffspEIrTBnhnq8FQwY7I9GEifuE/Kfn5XItIKwxIgHUOS0FsuWeLZQzDtiAIz4HzZw3ptkC/iVcrjK+3+0K8tDzDaNcT9bYCZdvTRr5mOBaS5dK+7HAou40SIAJ924ene1+bUHz/ZaEJl0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716285399; c=relaxed/simple;
	bh=9jYYJdwBIuzSRXYa6nEqZlNQpMtFqpFi+iSpT3gqCAM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=B6f8Chu2kLsdi843pApjp+NnbW+3WfM86st/ro/oLHM8PmIBRJRNwOE1ssjWkeumsOQYl3rMOEZ46bPJbjoyXxunrB4RYgUuE1ecCw2nNTLEP9IvUU8ZgD0YBFYXHC6iS1jqM4NaMp2bX8drK2RqbUXqTYSY0gA773IdFcgmyDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [141.14.220.56] (g56.guest.molgen.mpg.de [141.14.220.56])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 0DD9961E5FE06;
	Tue, 21 May 2024 11:55:35 +0200 (CEST)
Message-ID: <e8ab863e-18a5-4c16-b0c8-a3ab6440a9f6@molgen.mpg.de>
Date: Tue, 21 May 2024 11:55:34 +0200
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: NFSD: Unable to initialize client recovery tracking! (-110)
From: Paul Menzel <pmenzel@molgen.mpg.de>
To: Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org, regressions@lists.linux.dev,
 it+linux-nfs@molgen.mpg.de
References: <aaeae060-2be0-4b9f-818c-1b7d87e41a5f@molgen.mpg.de>
Content-Language: en-US
In-Reply-To: <aaeae060-2be0-4b9f-818c-1b7d87e41a5f@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

#regzbot ^introduced: 74fd48739d04

Dear Jeff,


Am 19.04.24 um 18:50 schrieb Paul Menzel:

> Since at least Linux 6.8-rc6, Linux logs the warning below:
> 
>      NFSD: Unable to initialize client recovery tracking! (-110)
> 
> I haven’t had time to bisect yet, so if you have an idea, that’d be great.

74fd48739d0488e39ae18b0168720f449a06690c is the first bad commit
commit 74fd48739d0488e39ae18b0168720f449a06690c
Author: Jeff Layton <jlayton@kernel.org>
Date:   Fri Oct 13 09:03:53 2023 -0400

     nfsd: new Kconfig option for legacy client tracking

     We've had a number of attempts at different NFSv4 client tracking
     methods over the years, but now nfsdcld has emerged as the clear winner
     since the others (recoverydir and the usermodehelper upcall) are
     problematic.

     As a case in point, the recoverydir backend uses MD5 hashes to encode
     long form clientid strings, which means that nfsd repeatedly gets 
dinged
     on FIPS audits, since MD5 isn't considered secure. Its use of MD5 
is not
     cryptographically significant, so there is no danger there, but 
allowing
     us to compile that out allows us to sidestep the issue entirely.

     As a prelude to eventually removing support for these client tracking
     methods, add a new Kconfig option that enables them. Mark it deprecated
     and make it default to N.

     Acked-by: NeilBrown <neilb@suse.de>
     Signed-off-by: Jeff Layton <jlayton@kernel.org>
     Signed-off-by: Chuck Lever <chuck.lever@oracle.com>

  fs/nfsd/Kconfig       | 16 +++++++++
  fs/nfsd/nfs4recover.c | 97 
+++++++++++++++++++++++++++++++++------------------
  fs/nfsd/nfsctl.c      |  6 ++++
  3 files changed, 85 insertions(+), 34 deletions(-)

`NFSD_LEGACY_CLIENT_TRACKING` is not set:

     # CONFIG_NFSD_LEGACY_CLIENT_TRACKING is not set


Kind regards,

Paul

