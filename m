Return-Path: <linux-nfs+bounces-11224-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D1E5FA97F8E
	for <lists+linux-nfs@lfdr.de>; Wed, 23 Apr 2025 08:49:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9035E3A70C5
	for <lists+linux-nfs@lfdr.de>; Wed, 23 Apr 2025 06:49:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1C8B1E47C5;
	Wed, 23 Apr 2025 06:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="mykjDivW"
X-Original-To: linux-nfs@vger.kernel.org
Received: from out.smtpout.orange.fr (out-70.smtpout.orange.fr [193.252.22.70])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12EBF2676D5
	for <linux-nfs@vger.kernel.org>; Wed, 23 Apr 2025 06:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.22.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745390961; cv=none; b=XuDOfPqbRFKXP3ZochR8jofDsJ9AdcHDyn9pi8cDLUfHaO+x7/esLDtiUxM1KnAhkeAhnuoxpS6UNSxF9nGT011KeO/xU3oZDeZ18JAVu2+lTjDo9gqCAq3kgh3hBRGo0SBOOxdyfByWzW66chfFY2aTcP/+q9sGthv2SjBetF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745390961; c=relaxed/simple;
	bh=J94UdOy+URG0llfJ2vo+R69UB36BEDE2iZtaRefabew=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Rjd+WXrdvXP9za2kj1dSn/GseICv9DGm7djsq+ebbRwBYSEqJv7suxlu6dmmSE5lTqgBgPqb6BZadP6lvU7XoQNs/JC6U9Fca85aXYNTMQ1CHsHiJLGV9e4mBefLn0I7G8lTcEoaF/MucUFGEdfCXnpGbW68+Ddlx1QLeIGneP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=mykjDivW; arc=none smtp.client-ip=193.252.22.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [172.16.82.72] ([124.33.176.97])
	by smtp.orange.fr with ESMTPA
	id 7TtmuTh5F5k817TtquMKgL; Wed, 23 Apr 2025 08:48:07 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1745390887;
	bh=+EKREV3L/L0Eu5q9rdAhYaLjHeWbUg34NalARwPzRtk=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=mykjDivWBOA4gPDa+Pk/qc9nELYidYpaT+0Tvmj8z9zoZpn48FZXSpnuJd9Q+Hvzj
	 Y2mJZmQ2ciuklnWnLTevZhI8JNViDiIBFTk9BU9RZKqh314lFvN2pkwdeDbrn7kAcY
	 EASJJIJWDjW+GrGKcCMlxAnGWe4tDE3YbDfNXeK5wsjVZhVJ43qxk8C/iTy/thUntL
	 oNG3k7PpahK22JwLIP5Tt7QLsGmj+Z269l0EuO1+fPgFc9/2yXONx4j0LaWi366U64
	 LExUk4tJxlIKtO+hqsqr3HOiWUmCT4IjxvuU+LXbOt8ER2+inBcnrmqNw3tC/mWQIk
	 AIZDc9I7SeN4Q==
X-ME-Helo: [172.16.82.72]
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Wed, 23 Apr 2025 08:48:07 +0200
X-ME-IP: 124.33.176.97
Message-ID: <96bff204-4cdc-426c-981d-29912243b5d1@wanadoo.fr>
Date: Wed, 23 Apr 2025 15:47:58 +0900
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] nfs: add dummy definition for nfsd_file
To: NeilBrown <neilb@suse.de>, =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>
Cc: Mike Snitzer <snitzer@kernel.org>, Chuck Lever <chuck.lever@oracle.com>,
 Trond Myklebust <trond.myklebust@hammerspace.com>,
 Anna Schumaker <anna.schumaker@oracle.com>, linux-nfs@vger.kernel.org,
 Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
 Jeff Layton <jlayton@kernel.org>, Olga Kornievskaia <okorniev@redhat.com>,
 Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
 Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>
References: <> <20250422220200.otabh5q7efh63rjh@pali>
 <174536837419.500591.6789771877874461689@noble.neil.brown.name>
Content-Language: en-US
From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Autocrypt: addr=mailhol.vincent@wanadoo.fr; keydata=
 xjMEZluomRYJKwYBBAHaRw8BAQdAf+/PnQvy9LCWNSJLbhc+AOUsR2cNVonvxhDk/KcW7FvN
 LFZpbmNlbnQgTWFpbGhvbCA8bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI+wrIEExYKAFoC
 GwMFCQp/CJcFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AWIQTtj3AFdOZ/IOV06OKrX+uI
 bbuZwgUCZx41XhgYaGtwczovL2tleXMub3BlbnBncC5vcmcACgkQq1/riG27mcIYiwEAkgKK
 BJ+ANKwhTAAvL1XeApQ+2NNNEwFWzipVAGvTRigA+wUeyB3UQwZrwb7jsQuBXxhk3lL45HF5
 8+y4bQCUCqYGzjgEZx4y8xIKKwYBBAGXVQEFAQEHQJrbYZzu0JG5w8gxE6EtQe6LmxKMqP6E
 yR33sA+BR9pLAwEIB8J+BBgWCgAmFiEE7Y9wBXTmfyDldOjiq1/riG27mcIFAmceMvMCGwwF
 CQPCZwAACgkQq1/riG27mcJU7QEA+LmpFhfQ1aij/L8VzsZwr/S44HCzcz5+jkxnVVQ5LZ4B
 ANOCpYEY+CYrld5XZvM8h2EntNnzxHHuhjfDOQ3MAkEK
In-Reply-To: <174536837419.500591.6789771877874461689@noble.neil.brown.name>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 23/04/2025 at 09:32, NeilBrown wrote:
> On Wed, 23 Apr 2025, Pali Rohár wrote:
>> On Wednesday 23 April 2025 07:54:40 NeilBrown wrote:
>>> On Wed, 23 Apr 2025, Pali Rohár wrote:
>>> Actually I do object to this fix (though I've been busy and hadn't had
>>> much change to look at it properly).
>>> The fix is ugly.  At the very least it should be wrapping in an 
>>>    #if  GCC_VERSION  < whatever
>>
>> The problem is that this compile issue happens also with some builds of
>> gcc 13.3.0 as was discussed in the email thread.
>>
>> So is not clear what is that "whatever". For me it looks like that it
>> would be more than the version, probably also some build characteristics
>> of gcc. But I have not been investigating it deeper.
> 
> Fair enough - let's skip that idea then.

If someone wants to investigate, here is a minimal reproducer:

  https://godbolt.org/z/sxvYPzY6b

(personnally, I have no plans to further investigate).


Yours sincerely,
Vincent Mailhol


