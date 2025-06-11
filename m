Return-Path: <linux-nfs+bounces-12299-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80ABBAD4C62
	for <lists+linux-nfs@lfdr.de>; Wed, 11 Jun 2025 09:15:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10DC717D94C
	for <lists+linux-nfs@lfdr.de>; Wed, 11 Jun 2025 07:15:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3E6B35958;
	Wed, 11 Jun 2025 07:15:22 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B881DF49;
	Wed, 11 Jun 2025 07:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.92.39.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749626122; cv=none; b=K5skIv9i9mw3ggC+jntRpEFy8SR99OcMMLWbrwNQHfBrnyhXbVIqLr9ZE0YraZRIxciCcGx9CuWFtI4+VsoNlUKIauX/ojwqCR4DNXotHjXpMPR4DbmhPgZQNekIKm9sMBKiIf1yqMLYr9qey/voglKoEFqcI9TR4sCfj/2y4YY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749626122; c=relaxed/simple;
	bh=jE0EBi15MBtvYNaWUv4wm2axETcih/Dq++16RHoTjkA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JuV959NazJOK1RMXbAnxfY31r+kbI/zRK6As9qE7AUixRZmHVfSBJwOBLzdCXgQO2Zxuln/AonpuGH19Da6tmz2WVtaAGYRi1IW9UDPdKmVkcGcUON8GwavTUvOEm5AYwi661kqEqddm8kbQOwpj7e6pdZlZ5k9f9i5YdkLRZ7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chenxiaosong.com; spf=pass smtp.mailfrom=chenxiaosong.com; arc=none smtp.client-ip=54.92.39.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chenxiaosong.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chenxiaosong.com
X-QQ-mid: esmtpgz15t1749625977td58cbd24
X-QQ-Originating-IP: BjPrTujgt+MKPQLp2kCNn3caEZrKE+yYJdXGdJujjho=
Received: from [192.168.3.231] ( [116.128.244.171])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 11 Jun 2025 15:12:55 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 4787782174800291874
Message-ID: <64E3DD4D765DEAD1+87aeb2d4-3732-4e57-ada6-098dbf0a7feb@chenxiaosong.com>
Date: Wed, 11 Jun 2025 15:12:55 +0800
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
From: ChenXiaoSong <chenxiaosong@chenxiaosong.com>
In-Reply-To: <208bd615061231c035a5633b29190925f271bd4b.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:chenxiaosong.com:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: MxdW4jxL6NvXRnxzmeQgeLzPXk4N7vJp66MXQrAuToDEyVib/jZXL7QU
	w947ezEOYZQ9NngNm/RwkP17xnzoFTEbo3wB2f1du/Fd5jcUI9yUQYM/88Z/F/xUsDt2VXf
	5GOMEb4fCuQ6w+D7CupHJ0at8lk39ow3O5hsaWqk/FGkU9F1CjaRVZRKuzSci96vVXoCYiw
	LUMTdNO97yJe/5x9mBIWz6glJQ06RQrPEqpgxJgSSGseT0ZPh3CAsuTXow7B9h2oAu2VHI0
	H6vCBmysYpunClwT1ZQ0wB0jd30jezNaqWHEiInxgrZWT6SwtG4Ikx4leeGVYTQLaggUUUw
	+zB5gEGedzbzFVplqbjKyrHTbN2pOxvslqUZ3ryG8HAXcm8HaTZYKuOBrpzxTu/cGkWTv/A
	YSOe9loIncO8TE0hd1/t3fZmIJBc/cUIjpNraKq3b6MdotmIX13m6fdnhJZAnmNxId/28uk
	IVwfryc1kNg3AMmEUGV5MXUCrgtLPSgGfdKKj2jQNvoNXc8ke9KHrOZ9+I3XIbP8WoRwRP/
	uv0sXvF/YtouzPLA5V9YxTGjV7Y92sEZ+AWOnLq/k5to2lNSJpdALSzFUH8n2MNdqA8J9O/
	dTRx0SCfkXUgl6riSsDcb/TyfNy0vxr42owU/aXcWsCzfSCjKbRhRzZymAWERJHvp079ZvV
	Amoeh/EetSVaja38NgNIKLPS28y6bEQb0lbRrPlzIvANKiDfuQYfr5IdPx/xjFXl02QfMtx
	MBMvzc8rXQixJQQYh01Qr9Gpa3MknSr3ZtotU7qpRk7CiYNlPH9k/LHu2I+x74GD9t6PEqe
	2V6YcEFOXFUdhXkny3LGqSEreq6EKXWqrb6+0EIklErUohFt+cMhZH04dTmPoRT5MgiMqTf
	HgTegMserqqvQNvZ1NQjO6ome+H4hv0FGDjWKNEbNkprJYQjYta65N2fJp0CS+ZnAox9/4j
	Il+UWkQd6Cg/eZJtcdFYXiJhWoh5wJceHhr6fFdE/09EW/vfrvoOUxD1XD+W0BxYCZau4IP
	DIFyHZ9A==
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
X-QQ-RECHKSPAM: 0

在 2025/6/10 19:09, Jeff Layton 写道:
> 
> Synchronization was probably too strong a word. I remember looking over
> this code and convincing myself that the probe callback wasn't subject
> to the same races as the others, but I think that was mostly because
> the outcome of those races was not harmful. Note that the probe itself
> can actually be run at the start of a completely unrelated callback to
> the same client.
> 
> So you hit a NULL pointer in __queue_work()? The work_struct is
> embedded in the nfs4_client so that would probably imply that that the
> nfs4_client struct was corrupt?
> 
> You may want to get a vmcore and analyze it if you can reproduce this.

Thanks for your reply.

I have already got a vmcore. Here is the link to the vmcore analysis:

https://chenxiaosong.com/en/nfs/en-null-ptr-deref-in-nfsd4_probe_callback.html

Please let me know if you need any more detailed information.

Thanks,
ChenXiaoSong.

