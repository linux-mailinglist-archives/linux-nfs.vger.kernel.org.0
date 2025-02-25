Return-Path: <linux-nfs+bounces-10331-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 98E47A43C2D
	for <lists+linux-nfs@lfdr.de>; Tue, 25 Feb 2025 11:48:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F3793AF275
	for <lists+linux-nfs@lfdr.de>; Tue, 25 Feb 2025 10:47:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0ED32673B9;
	Tue, 25 Feb 2025 10:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=clip-os.org header.i=@clip-os.org header.b="kcInWPB3"
X-Original-To: linux-nfs@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C769E2206B1;
	Tue, 25 Feb 2025 10:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740480470; cv=none; b=t6/Zad3gNgu2pKHaxxhr0iStLZS+SBqRMFMTylDEvhP42oq+QoUNojC3063Uo3Z+DFOwgQGI3OHVhMPWTd7xHr2bnSE3YbRIMUqFJl/TfqftspYI4wiyH+JoIY/txrj0t4Av6Uu5U4psO83zrF/2muCrI3O9OG9orPGtJytlHm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740480470; c=relaxed/simple;
	bh=Ens5XgXC4MKgv2L9LSCoGm1j56Oge5R3ycKjE8QDjQs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FMP33er0wVQMb0uJP159jvKlGZ7XueJ7H5GT5F/oGdaRXzbsf7+ujZKv46s4hg0ULJFiNfvqHVahQNgNzFFgNXK3Okt4Tyy92ZbStLKEZr7rvJOnTlTMzcgY1sjn7Yrsxv1jF8LvdFlTZV1J4JezacgwespdSSluAY41mMCIJdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=clip-os.org; spf=pass smtp.mailfrom=clip-os.org; dkim=pass (2048-bit key) header.d=clip-os.org header.i=@clip-os.org header.b=kcInWPB3; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=clip-os.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=clip-os.org
Received: by mail.gandi.net (Postfix) with ESMTPSA id 6A874443D5;
	Tue, 25 Feb 2025 10:47:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=clip-os.org; s=gm1;
	t=1740480466;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/w8wVTRHE/xGj7ErqQjnktVc7tmwi8xBB602HEhKIQM=;
	b=kcInWPB3d6ED1aer/OXVITpGPrFrMZnE4f7xk9QJT4izYp/1IWL2qLjHXMnOenc19ukFbS
	mROPt5RSMsNzV1P1wyjOPXqp6VRQUMUfDSjSFMwIHZU81z+Qf3S8n+GGZcpseQIuph6V1x
	DXftMkvHLkgXI8H9PJHobC959CDRn1qGlKRcuHC7MLZDcSsflErnekQFyMYcu7bCoJiX7G
	RM74hv8rr5ika2NQqI0fShNgXX2Ap3DvTt5Y/I0znYS/5DLAVDyFPx7lJhBHXK+7yrnYUR
	WycIYcXmun2AO/01L9k8z6oqNZEIpSP4hDwjoUkNPXDR3GWOoaiAH3/2fISaGg==
Message-ID: <0a9869e0-d091-4568-a6e7-8d7d72b296a9@clip-os.org>
Date: Tue, 25 Feb 2025 11:47:42 +0100
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/6] sysctl: Fixes scsi_logging_level bounds
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-scsi@vger.kernel.org, codalist@coda.cs.cmu.edu,
 linux-nfs@vger.kernel.org, Nicolas Bouchinet
 <nicolas.bouchinet@ssi.gouv.fr>, Joel Granados <j.granados@samsung.com>,
 Clemens Ladisch <clemens@ladisch.de>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 Jan Harkes <jaharkes@cs.cmu.edu>, Chuck Lever <chuck.lever@oracle.com>,
 Jeff Layton <jlayton@kernel.org>, Neil Brown <neilb@suse.de>,
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>,
 Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>,
 Anna Schumaker <anna@kernel.org>, Bart Van Assche <bvanassche@acm.org>,
 Zhu Yanjun <yanjun.zhu@linux.dev>, Al Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>
References: <20250224095826.16458-1-nicolas.bouchinet@clip-os.org>
 <20250224095826.16458-5-nicolas.bouchinet@clip-os.org>
 <yq1y0xubz40.fsf@ca-mkp.ca.oracle.com>
Content-Language: en-US
From: Nicolas Bouchinet <nicolas.bouchinet@clip-os.org>
In-Reply-To: <yq1y0xubz40.fsf@ca-mkp.ca.oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekudehtdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtvdejnecuhfhrohhmpefpihgtohhlrghsuceuohhutghhihhnvghtuceonhhitgholhgrshdrsghouhgthhhinhgvthestghlihhpqdhoshdrohhrgheqnecuggftrfgrthhtvghrnheptdfggeejjefhleeuffetueektefhledukeegvefgteeugeeuhfekudffleehgfetnecukfhppeeltddrieefrddvgeeirddukeejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepledtrdeifedrvdegiedrudekjedphhgvlhhopegludelvddrudeikedrfeefrdeihegnpdhmrghilhhfrhhomhepnhhitgholhgrshdrsghouhgthhhinhgvthestghlihhpqdhoshdrohhrghdpnhgspghrtghpthhtohepvdejpdhrtghpthhtohepmhgrrhhtihhnrdhpvghtvghrshgvnhesohhrrggtlhgvrdgtohhmpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqrhgumhgrsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqshgtshhisehvghgvrhdrkhgvrhhnv
 ghlrdhorhhgpdhrtghpthhtoheptghouggrlhhishhtsegtohgurgdrtghsrdgtmhhurdgvughupdhrtghpthhtoheplhhinhhugidqnhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehnihgtohhlrghsrdgsohhutghhihhnvghtsehsshhirdhgohhuvhdrfhhrpdhrtghpthhtohepjhdrghhrrghnrgguohhssehsrghmshhunhhgrdgtohhm
X-GND-Sasl: nicolas.bouchinet@clip-os.org


On 2/25/25 02:20, Martin K. Petersen wrote:
> Hi Nicolas!
>
>> --- a/drivers/scsi/scsi_sysctl.c
>> +++ b/drivers/scsi/scsi_sysctl.c
>> @@ -17,7 +17,9 @@ static const struct ctl_table scsi_table[] = {
>>   	  .data		= &scsi_logging_level,
>>   	  .maxlen	= sizeof(scsi_logging_level),
>>   	  .mode		= 0644,
>> -	  .proc_handler	= proc_dointvec },
>> +	  .proc_handler	= proc_dointvec_minmax,
>> +	  .extra1	= SYSCTL_ZERO,
>> +	  .extra2	= SYSCTL_INT_MAX },
> scsi_logging_level is a bitmask and should be unsigned.
>

Hi Martin,

Thank's for your review.

Does `scsi_logging_level` needs the full range of a unsigned 32-bit 
integer ?
As it was using `proc_dointvec`, it was capped to an INT_MAX.

If it effectively need the full range of an unsigned 32-bit integer, the
`proc_handler` could be changed to `proc_douintvec` as suggested by Chuck.

Best regards,

Nicolas


