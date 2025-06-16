Return-Path: <linux-nfs+bounces-12472-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 76FFFADB00F
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Jun 2025 14:20:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B77FF188E053
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Jun 2025 12:20:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 778861EF36B;
	Mon, 16 Jun 2025 12:19:58 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CF731B423C;
	Mon, 16 Jun 2025 12:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750076398; cv=none; b=guFmPxV9AKgeM+sFDaIqpEqpBLuPvsxGWktuTHV1Nw5Y2E34g2w9BCPTkvZCcpR8yJVyxAK+IZHEsa/a96KjniIYtEt3758meMkNjgsh2WRv1m8cO6bjqbl386swCi9/wTWpVbyiftihwsmdV7Y40kS9rK+GFj23uXVxsaSdhrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750076398; c=relaxed/simple;
	bh=XBUQUl5X0u09lmuR1SyMfubEdRqK1CjXTD2YWQo7cfc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ROwIOdRAk3bnptI/F+aPL2mWdoToHi/y6ml3ZAdLuJK/ipa9A+6Ds4QA/ouHvGhpo/TMOCPhiyW0jrBFU74tBry0TrpsZceN4WAqnHodzpjSmXuU1BNuNPPm4FirjfAKx8kyQAfwtQvktk5Nqdmg8+qF9FmO6WAIzO4pCctwc6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chenxiaosong.com; spf=pass smtp.mailfrom=chenxiaosong.com; arc=none smtp.client-ip=54.254.200.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chenxiaosong.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chenxiaosong.com
X-QQ-mid: zesmtpsz7t1750076293td956bd47
X-QQ-Originating-IP: 03RhLdRfUOPiwpNEJ/mpxGYHz9gVNj8RAhDCUpNHyPg=
Received: from [192.168.3.231] ( [116.128.244.171])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 16 Jun 2025 20:18:11 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 9223697257232777345
Message-ID: <46AD5DEB9010FAAF+d05a1cd9-f287-4bb6-ad83-233db3ce9db4@chenxiaosong.com>
Date: Mon, 16 Jun 2025 20:18:11 +0800
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/5] nfsd: prevent callback tasks running concurrently
To: Jeff Layton <jlayton@kernel.org>
Cc: Olga Kornievskaia <okorniev@redhat.com>,
 Li Lingfeng <lilingfeng3@huawei.com>, Dai Ngo <Dai.Ngo@oracle.com>,
 Neil Brown <neilb@suse.de>, Chuck Lever <chuck.lever@oracle.com>,
 Tom Talpey <tom@talpey.com>, linux-nfs@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250220-nfsd-callback-v2-0-6a57f46e1c3a@kernel.org>
 <20250220-nfsd-callback-v2-1-6a57f46e1c3a@kernel.org>
 <23651194C61FBB9C+e2ddd3f5-f51f-44c0-8800-d2abb08a2447@chenxiaosong.com>
 <208bd615061231c035a5633b29190925f271bd4b.camel@kernel.org>
 <64E3DD4D765DEAD1+87aeb2d4-3732-4e57-ada6-098dbf0a7feb@chenxiaosong.com>
 <6E9B7F9B8D47F98B+d6fd7e8f-de81-4ec3-b3ae-f85bbb744e66@chenxiaosong.com>
 <219985d542d0eb765d917c0ab620b6af5c62f1af.camel@kernel.org>
From: ChenXiaoSong <chenxiaosong@chenxiaosong.com>
In-Reply-To: <219985d542d0eb765d917c0ab620b6af5c62f1af.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:chenxiaosong.com:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: ND42uzdxTIzroNiAdMmZCkjvDF4eVqqFz1aUCdLhaVFeSP7KlPtuM8c7
	TSNKjzdHcO/0aDORezsRaccX0IP5Crg1Y84Oc/cwjvKq2hnwzYxtQYgcjOVfvUIsWG8gNhI
	1Xcziq1Pue6UgOwVi1KHLxx6iYMqCsVdeKLTfVh6iugMoI21pUzKLv3FMHL4FifbH50YncQ
	Hqe3nXqqX4TrtUfgkcRpNEbsKysJZAlVrQUc6sQuhoR5cBfV41frMOAwVOPsxgdOnn9KBZ+
	Wk/6kgHsQ1H2wxP6rDtjMaHbLHzVINej5BPtMS/OatSlZQXCeVTYLWj5INoZDprbUtAxGwe
	pEKadlcdBE9XrR32GbYztLjE23IHfriPYr8yAuxacpagTPdT4/0vaTv4NcUfr3CeeOovu2W
	zI29+EKOhKqskg8/UhRKb9b/vnog6pd3ktiZyRtn3aqMmz3ViT/wmdchDm5ZG2qOQN138Ql
	767qCOZQGncKOvP6cCjdRC193dTxCKOKxY6nlpvVn39XquxmeXLC5dEuI5flNC5plvDgUDV
	oBqHWuT5195W7pWF15X8FvqyzOkDiyKJi3JZ/hUzbk1ZrpK2qrV2OXvSmRCRCpNfdrJMRRn
	odYC+tNGT2XO9/R8FYwcWQ5NkWOqXVRJT0T9HUy9IJyJboyjTd39x48nkWgAKoNQuwilcMy
	jP6AKY+3sjkspLD7b8I/je/LDlYh6FuArgMqPngmiyBwyRogGavItGw5EzpJvxRU9S2dULS
	o7fGSCIiU2ZYcf2dH971wWSTpVQlegx03z/XKFi4PzofrhZ3nVSSlmEzgsYSYqmG5wAftTu
	VKX/RsPsoKTsMZRSGewFjcMt1kwTk0pmQ7B8cNWBFBUyzpZK/Avy6DFgDpHddezd5KzQecY
	NcVZemlpxls+PKfCTL3V9fS1gDRnHNl3vbTHNA5iwEYIjNPmTW16+3nUSfReIFVT7bqioIZ
	BrDwBaJ5w/Ejn8+NzV6FdU+u84XqU7lduE3Cbl+lA7X6oYV6Vk8Ah+0sVDZduZPGqI7c=
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
X-QQ-RECHKSPAM: 0

OK, I'll try to reproduce it. Thanks for your reply.

在 2025/6/16 20:09, Jeff Layton 写道:
> Not right offhand. My first guess would be some sort of UAF. Maybe a
> nfs4_client refcounting issue? If this is reproducible then you may
> want to turn up KASAN which might give you more info.
> 
> That said, 4.19.90 is more than 6 years old at this point. You may want
> to consider moving to something more recent.


