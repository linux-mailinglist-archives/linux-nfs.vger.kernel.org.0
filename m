Return-Path: <linux-nfs+bounces-10496-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E534A54819
	for <lists+linux-nfs@lfdr.de>; Thu,  6 Mar 2025 11:41:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02FD53B16E5
	for <lists+linux-nfs@lfdr.de>; Thu,  6 Mar 2025 10:40:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EFF92040BD;
	Thu,  6 Mar 2025 10:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=clip-os.org header.i=@clip-os.org header.b="lOUD7UmF"
X-Original-To: linux-nfs@vger.kernel.org
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E12562036E3;
	Thu,  6 Mar 2025 10:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741257613; cv=none; b=qROeI+n0SaezLc+H4RJ0Jo8N05i0IGQRSmHKw8uXIBxLZhJJVPT8P1aovD9GAmnaXgSWQVvXfzAu/Haw0IXb+dgVZCG+bT2iQLg9WWhYrKMlSnU8ObBId/fokuKvsRNpKuw3FlhKFIBclqKvQlCAqOXE3akCQd+6Pq9Nc/eWx6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741257613; c=relaxed/simple;
	bh=3JBdFCiYrIC+RNOrHoqq7a8iUKdN0ZQ9gy4GJ7lxkLk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sWbEXu4tBVvZV9ZefJtmxIgSu9Kme2NaI9kjYR2wrKTX4M8krl1D0XwjTjLhswWRrcqmaHVhf8f2gwUBdzVFDxaeTt1GYl6qrBygV4XIndz9aRlAL+TPpzG33c1eZyLa9Ul0mZ8UJ7vfkAFP3lgZCKLEF9GmSnlXWP2Xj5TLgSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=clip-os.org; spf=pass smtp.mailfrom=clip-os.org; dkim=pass (2048-bit key) header.d=clip-os.org header.i=@clip-os.org header.b=lOUD7UmF; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=clip-os.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=clip-os.org
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8AD7944298;
	Thu,  6 Mar 2025 10:40:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=clip-os.org; s=gm1;
	t=1741257607;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6wbUiKVMo+ilWlUo2t+dlVeBduqmoy102Za6yfVmUbI=;
	b=lOUD7UmFH4D9eg9UusCKx4HU1ChMUUVggiAkzFpMX8L4ZgWA87DKsA2dHER5Q2yZZ9gMHg
	y2Pu6kRs7grKmmqZHpCHdVKU5DMQMlXqY5Lv1yxr4y9+N32bH5ULpu75Xx+c+tAiKk0Job
	m/ImXuBLgnK3iw4KFI7b2jD8CC+JojaEzmNO/54eiJPeCmqHSQswd2kgbNQDaWNhF+hFDK
	WdQjtHMWWPHosx5Q10ChVDX00jxZbJzCZ2IflhfEDSlD9N+D55o0THw/IbYq9ijVZeUAgr
	JDpUYIsMlqiwfy4zmLub5df+eACBJWPBoJ4/8OFs3r/HvcTeWG1WzzrGGYfMBw==
Message-ID: <dd7946d8-edc7-4ee6-a5da-75d15654bc42@clip-os.org>
Date: Thu, 6 Mar 2025 11:40:03 +0100
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/6] sysctl/coda: Fixes timeout bounds
To: Joel Granados <joel.granados@kernel.org>, Jan Harkes <jaharkes@cs.cmu.edu>
Cc: linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-scsi@vger.kernel.org, linux-nfs@vger.kernel.org,
 Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>,
 Joel Granados <j.granados@samsung.com>, Clemens Ladisch
 <clemens@ladisch.de>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
 "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>,
 Neil Brown <neilb@suse.de>, Olga Kornievskaia <okorniev@redhat.com>,
 Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
 Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>,
 Bart Van Assche <bvanassche@acm.org>, Zhu Yanjun <yanjun.zhu@linux.dev>,
 Al Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>
References: <20250224095826.16458-1-nicolas.bouchinet@clip-os.org>
 <20250224095826.16458-4-nicolas.bouchinet@clip-os.org>
 <u7q5rpzw6mohtnnhpa2j3u4photckmgllsl3noafnyfttepbui@rzmndu533xcv>
 <20250303143937.etzv7idjbenugsgw@cs.cmu.edu>
 <ukkrk6tcf4peempwyutpruupqjkyrbeizrqz2ymjsjpmj6tds5@zb5vp5rh7qoe>
Content-Language: en-US
From: Nicolas Bouchinet <nicolas.bouchinet@clip-os.org>
In-Reply-To: <ukkrk6tcf4peempwyutpruupqjkyrbeizrqz2ymjsjpmj6tds5@zb5vp5rh7qoe>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddutdejheefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfevfhfhjggtgfesthejredttddvjeenucfhrhhomheppfhitgholhgrshcuuehouhgthhhinhgvthcuoehnihgtohhlrghsrdgsohhutghhihhnvghtsegtlhhiphdqohhsrdhorhhgqeenucggtffrrghtthgvrhhnpedtgfegjeejhfelueffteeukeethfeludekgeevgfetueeguefhkeduffelhefgteenucfkphepledtrdeifedrvdegiedrudekjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeeltddrieefrddvgeeirddukeejpdhhvghloheplgduledvrdduieekrdeffedrieehngdpmhgrihhlfhhrohhmpehnihgtohhlrghsrdgsohhutghhihhnvghtsegtlhhiphdqohhsrdhorhhgpdhnsggprhgtphhtthhopedvjedprhgtphhtthhopehjohgvlhdrghhrrghnrgguohhssehkvghrnhgvlhdrohhrghdprhgtphhtthhopehjrghhrghrkhgvshestghsrdgtmhhurdgvughupdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqrhgumhgrsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrt
 ghpthhtoheplhhinhhugidqshgtshhisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqnhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehnihgtohhlrghsrdgsohhutghhihhnvghtsehsshhirdhgohhuvhdrfhhrpdhrtghpthhtohepjhdrghhrrghnrgguohhssehsrghmshhunhhgrdgtohhm
X-GND-Sasl: nicolas.bouchinet@clip-os.org

Hi Jan and Joel,

Thanks for your review,

I'll update coda_timeout type to an unsigned int and push back the patchset
without patches that has moved in their subsystems.

Best regards,

Nicolas

On 3/5/25 15:47, Joel Granados wrote:
> On Mon, Mar 03, 2025 at 09:39:37AM -0500, Jan Harkes wrote:
>> On Mon, Mar 03, 2025 at 09:16:10AM -0500, Joel Granados wrote:
>>> On Mon, Feb 24, 2025 at 10:58:18AM +0100, nicolas.bouchinet@clip-os.org wrote:
>>>> From: Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>
>>>>
>>>> Bound coda timeout sysctl writings between SYSCTL_ZERO
>>>> and SYSCTL_INT_MAX.
>>>>
>>>> The proc_handler has thus been updated to proc_dointvec_minmax.
>>>>
>>>> Signed-off-by: Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>
>>>> ---
>>>>   fs/coda/sysctl.c | 4 +++-
>>>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/fs/coda/sysctl.c b/fs/coda/sysctl.c
>>>> index 0df46f09b6cc5..d6f8206c51575 100644
>>>> --- a/fs/coda/sysctl.c
>>>> +++ b/fs/coda/sysctl.c
>>>> @@ -20,7 +20,9 @@ static const struct ctl_table coda_table[] = {
>>>>   		.data		= &coda_timeout,
>>> I noticed that coda_timeout is an unsigned long. With that in mind I
>>> would change it to unsigned int. It seems to be a value that can be
>>> ranged within [0,INT_MAX]
>> That seems fine by me.
>>
>> It is a timeout in seconds and it is typically set to some value well
>> under a minute.
>>
> Thx for the confirmation. I'll let nicolas take care of the change
> Best
>

