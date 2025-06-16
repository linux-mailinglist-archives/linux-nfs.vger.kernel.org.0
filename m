Return-Path: <linux-nfs+bounces-12470-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00709ADA9DF
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Jun 2025 09:51:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA7D116717D
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Jun 2025 07:51:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E044D1519B9;
	Mon, 16 Jun 2025 07:51:32 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtpbgbr1.qq.com (smtpbgbr1.qq.com [54.207.19.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D00242AB0;
	Mon, 16 Jun 2025 07:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.19.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750060292; cv=none; b=FNBf/X0iRKKGsoz6d5pVbzrberEnjwuqbCn8JXY+hObfjPkQDrCGzNQtFHGSpi+oE8r4eGpzaGmkRavsE11HeOWNISkrNWJogoiiwdxKuROt3R42MHo/tOOHRkGOx12juc+2XTE+6MFih4jUWaHHiJ4aRf4Cbg1+Rj4EVXbaRVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750060292; c=relaxed/simple;
	bh=YuyT1YyBuYG4wqa+Ht7aSBXnGvxZhhg7A9glic+jqSA=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=cT4flmaodmR6kiAdAODGp4cvtFVJOBc+eC6Zwj7OK2JaHxcq7fWokBA+CmxYzgWrQqgoukxdzANjgMSBuA8OpVnsIEu+OVPNekc80KTJpjZEvuWAVALB1iKSNUM8tdTCLSOxIk6I60zsbTrbKFv2ZkAbp8Ku9ZIZgnR3GDXX17M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chenxiaosong.com; spf=pass smtp.mailfrom=chenxiaosong.com; arc=none smtp.client-ip=54.207.19.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chenxiaosong.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chenxiaosong.com
X-QQ-mid: zesmtpsz8t1750060147t8ffa88a1
X-QQ-Originating-IP: TMyvGnHlVWeQP6sEE0T+5jBz56pJK9ZPBzZTiCvA75E=
Received: from [192.168.3.231] ( [116.128.244.171])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 16 Jun 2025 15:49:05 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 11962215163039328790
Message-ID: <6E9B7F9B8D47F98B+d6fd7e8f-de81-4ec3-b3ae-f85bbb744e66@chenxiaosong.com>
Date: Mon, 16 Jun 2025 15:49:05 +0800
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/5] nfsd: prevent callback tasks running concurrently
From: ChenXiaoSong <chenxiaosong@chenxiaosong.com>
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
In-Reply-To: <64E3DD4D765DEAD1+87aeb2d4-3732-4e57-ada6-098dbf0a7feb@chenxiaosong.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:chenxiaosong.com:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: Mnff/9wu0oJYO3GB4f1kHYl+nPZWrKexqFBNP0dLbyIHs4e2EHRAu3IJ
	d8XumO6/xxcQNeDtb2VGsc1xGnNPOBsPmyDlRPag1sOcV7TVoHgPpC5GTLFKghSqZaiW/xu
	iMgIxIjBYm2tFq4flEikrJ6FYo9GZQ3hu7pA0/jENXjwFrZXbPOEoeuCTiNADjpe2YorwNF
	nT4n2ucfJ54MGTAGI6mUvV6MtHTp+gB6wsbJIrZJX0hWJnK8cSDN2YSnNXnWm6bRaU86iv3
	EJhQEQ6PErpU5NhFwy1XGY5JFm4HcRTEHXMCUexpwi8whbELZXZmNyapyYO/3QN6enb3XNx
	Fc3D/g1POk43anjEqNnQ5xVQjDiE/3ythgw+6eCnx/Pl1pPVoOcSQjZfNHl1EHtx3cJpbWw
	EnPVAp5cKnIYObrHT5MlN5X+p6jToStMoHj9axaUcbi+dmObEu7D8F6X+INK3ZhZueqCQd4
	NfOPXmaYQX5RE5lUARch0YYyWzpEVG2vDv+Ewm61Wypf+SYuBVb3C2J55S7L/tdjpmJWSdR
	YF5lLHL1g7pywG0dSFebr07wZT//N9ZWpolxvIxunG4tYm4GcOTpVhMpUOja2u4y9qoRBZ4
	YCsIp//C/RvWFHA7hGGfpcyDQZLsyMTqyVbYZREX9/d5F1z+TDVSmfc9vuaNOt7wyqrX2kJ
	bYTKS+jb1LzyPZZPUI9KUbVrGcFRpK/fwJNzioqBx9LYNL3uT2X/IxyLMqkVCFVZi9/4B2V
	U3EiC7gsvaJT9XJy1YV0xtQtEB9H9QpyoN2uo2x/mehZUPNhmsVoUd0Wi2et9OgKlkTSVCN
	lPdJFVNUb+wAbmWEEPpLLBJlOTiKYEaND0H4SMYTtvH0Cj2N5rKfeUN+qSVpyNetYUM9i3U
	rbWXr33aSnWHz3KVDWVZjXHY6shQe6mdbJasuyVeX3Ouu5WswU4biBa/IXcjND4QevCh0TY
	iwA71jE9VSPqx7HzoCMjaucwobLpigbb1P5A0nHV8oiui5XEvt7vVPD9OXgK+qAud1cyp/5
	m9bQg1Zw==
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
X-QQ-RECHKSPAM: 0

Hi Jeff:

Do you have any suggestions for this null-ptr-deref issue?

Here is the link to the vmcore analysis:

https://chenxiaosong.com/en/nfs/en-null-ptr-deref-in-nfsd4_probe_callback.html

Thanks,
ChenXiaoSong.

在 2025/6/11 15:12, ChenXiaoSong 写道:
> 在 2025/6/10 19:09, Jeff Layton 写道:
>>
>> Synchronization was probably too strong a word. I remember looking over
>> this code and convincing myself that the probe callback wasn't subject
>> to the same races as the others, but I think that was mostly because
>> the outcome of those races was not harmful. Note that the probe itself
>> can actually be run at the start of a completely unrelated callback to
>> the same client.
>>
>> So you hit a NULL pointer in __queue_work()? The work_struct is
>> embedded in the nfs4_client so that would probably imply that that the
>> nfs4_client struct was corrupt?
>>
>> You may want to get a vmcore and analyze it if you can reproduce this.
> 
> Thanks for your reply.
> 
> I have already got a vmcore. Here is the link to the vmcore analysis:
> 
> https://chenxiaosong.com/en/nfs/en-null-ptr-deref-in- 
> nfsd4_probe_callback.html
> 
> Please let me know if you need any more detailed information.
> 
> Thanks,
> ChenXiaoSong.



