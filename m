Return-Path: <linux-nfs+bounces-10330-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0C83A43BF6
	for <lists+linux-nfs@lfdr.de>; Tue, 25 Feb 2025 11:42:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D1BB169C80
	for <lists+linux-nfs@lfdr.de>; Tue, 25 Feb 2025 10:38:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ED2526389C;
	Tue, 25 Feb 2025 10:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=clip-os.org header.i=@clip-os.org header.b="lCgQQNZx"
X-Original-To: linux-nfs@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F2C0260A26;
	Tue, 25 Feb 2025 10:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740479894; cv=none; b=nk4YoyNut7Pz86r4E7X12hGb737VJpEx420OgEJjUCxyvchTT5X3SQOw/KDQEgxpxg1IjUbhAVbzCjmup+d2CygGsHi851fLrSdcf72mTnI7pyYNfYF1Bq8zvZ1eVY1rzATIdf/XiQiedyLpqw+p4cVPKs8HLMF2wqF8ILcwVMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740479894; c=relaxed/simple;
	bh=nmaIuLRIXhpvBAWF936BZrE5FfGSBBkqykB3EbSstac=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dNZ0U25NCF0t3y9u0aFBDDH8fgIw7WqBv12a1qjAgkbt++ch1qvwhX1iRmAHuM72JJWyBfoKfbwI1SfrkcVDWWihazfvU4TgTBcjd+Jfk/PWGzhjAB3rqmvwdLBbuUYwP14TqJoaCFIdpNpuPqT57FAz6PXSlZcoQ0DVulPp4MM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=clip-os.org; spf=pass smtp.mailfrom=clip-os.org; dkim=pass (2048-bit key) header.d=clip-os.org header.i=@clip-os.org header.b=lCgQQNZx; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=clip-os.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=clip-os.org
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3B271204D4;
	Tue, 25 Feb 2025 10:37:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=clip-os.org; s=gm1;
	t=1740479884;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Wt3UxvctVd0CM5VFAarheDiBUupuORfHc7HMZ4s/FLg=;
	b=lCgQQNZxgWHBrWHRXrEHHn19LxurT/Plb8hRCvHTTWige0RFmZ/KJOTYVNyKDpDb6AJ4K4
	nYFvnl11++m+d/uqjmxPOu/xMzyhRFpSv4O4ECi8FpgR3UWUQ/DcLoXv/EPudBIR4UFxL2
	BzzhDlxbasTrOu9sZiVpkF7Wmt8FkYZgTM+8PuFyLSF+VNqTYalQ11fnprlOwCIUw0xJvd
	COFFHYosuNm7nUlxHvl3WqywBR+W3Itsq6DvwDY93XvF18WP2jxD86glHZDDI5LzP1E64R
	esdbFQCIQ8uAff9pRqX6LaIfKnRKKCpVkild1mAomruSExHmuhbtbrfZ6ElHGQ==
Message-ID: <ac5742e1-7a2b-4d74-889c-0a0c434c16e5@clip-os.org>
Date: Tue, 25 Feb 2025 11:37:57 +0100
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/6] sysctl: Fixes nsm_local_state bounds
To: Chuck Lever <chuck.lever@oracle.com>, linux-kernel@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-scsi@vger.kernel.org,
 codalist@coda.cs.cmu.edu, linux-nfs@vger.kernel.org
Cc: Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>,
 Joel Granados <j.granados@samsung.com>, Clemens Ladisch
 <clemens@ladisch.de>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Jan Harkes <jaharkes@cs.cmu.edu>, Jeff Layton <jlayton@kernel.org>,
 Neil Brown <neilb@suse.de>, Olga Kornievskaia <okorniev@redhat.com>,
 Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
 Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>,
 Bart Van Assche <bvanassche@acm.org>, Zhu Yanjun <yanjun.zhu@linux.dev>,
 Al Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>
References: <20250224095826.16458-1-nicolas.bouchinet@clip-os.org>
 <20250224095826.16458-3-nicolas.bouchinet@clip-os.org>
 <da418443-a98b-4b08-ad44-7d45d89b4173@oracle.com>
Content-Language: en-US
From: Nicolas Bouchinet <nicolas.bouchinet@clip-os.org>
In-Reply-To: <da418443-a98b-4b08-ad44-7d45d89b4173@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekudegjecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtvdejnecuhfhrohhmpefpihgtohhlrghsuceuohhutghhihhnvghtuceonhhitgholhgrshdrsghouhgthhhinhgvthestghlihhpqdhoshdrohhrgheqnecuggftrfgrthhtvghrnheptdfggeejjefhleeuffetueektefhledukeegvefgteeugeeuhfekudffleehgfetnecukfhppeeltddrieefrddvgeeirddukeejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepledtrdeifedrvdegiedrudekjedphhgvlhhopegludelvddrudeikedrfeefrdeihegnpdhmrghilhhfrhhomhepnhhitgholhgrshdrsghouhgthhhinhgvthestghlihhpqdhoshdrohhrghdpnhgspghrtghpthhtohepvdejpdhrtghpthhtoheptghhuhgtkhdrlhgvvhgvrhesohhrrggtlhgvrdgtohhmpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqrhgumhgrsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqshgtshhisehvghgvrhdrkhgvrhhnvghlrdhor
 hhgpdhrtghpthhtoheptghouggrlhhishhtsegtohgurgdrtghsrdgtmhhurdgvughupdhrtghpthhtoheplhhinhhugidqnhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehnihgtohhlrghsrdgsohhutghhihhnvghtsehsshhirdhgohhuvhdrfhhrpdhrtghpthhtohepjhdrghhrrghnrgguohhssehsrghmshhunhhgrdgtohhm
X-GND-Sasl: nicolas.bouchinet@clip-os.org


On 2/24/25 15:38, Chuck Lever wrote:
> On 2/24/25 4:58 AM, nicolas.bouchinet@clip-os.org wrote:
>> From: Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>
>>
>> Bound nsm_local_state sysctl writings between SYSCTL_ZERO
>> and SYSCTL_INT_MAX.
>>
>> The proc_handler has thus been updated to proc_dointvec_minmax.
>>
>> Signed-off-by: Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>
>> ---
>>   fs/lockd/svc.c | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/lockd/svc.c b/fs/lockd/svc.c
>> index 2c8eedc6c2cc9..984ab233af8b6 100644
>> --- a/fs/lockd/svc.c
>> +++ b/fs/lockd/svc.c
>> @@ -461,7 +461,9 @@ static const struct ctl_table nlm_sysctls[] = {
>>   		.data		= &nsm_local_state,
>>   		.maxlen		= sizeof(int),
>>   		.mode		= 0644,
>> -		.proc_handler	= proc_dointvec,
>> +		.proc_handler	= proc_dointvec_minmax,
>> +		.extra1		= SYSCTL_ZERO,
>> +		.extra2		= SYSCTL_INT_MAX,
>>   	},
>>   };
>>   
> Hi Nicolas -
>
> nsm_local_state is an unsigned 32-bit integer. The type of that value is
> defined by spec, because this value is exchanged between peers on the
> network.
>
> Perhaps this patch should replace proc_dointvec with proc_douintvec
> instead.
>
>

Hi Chuck,

Thank's for your review.

If `nsm_local_state` should be set to the
full range of an uint32_t by a user writing in the sysctl, then yes it 
should
use `proc_douintvec` instead of limiting it to SYSCTL_INT_MAX value 
(INT_MAX).

I've used `proc_dointvec_minmax` since it already used `proc_dointvec` 
and thus
was already capped at INT_MAX.

Best regards,

Nicolas


