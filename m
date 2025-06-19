Return-Path: <linux-nfs+bounces-12571-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D3456ADFE6A
	for <lists+linux-nfs@lfdr.de>; Thu, 19 Jun 2025 09:12:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D37C3AD635
	for <lists+linux-nfs@lfdr.de>; Thu, 19 Jun 2025 07:12:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 170F52472BC;
	Thu, 19 Jun 2025 07:12:29 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtpbg151.qq.com (smtpbg151.qq.com [18.169.211.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 437333085D3;
	Thu, 19 Jun 2025 07:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.169.211.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750317149; cv=none; b=YIdjGDTbL5prjsFjWDFxfmPMpKi3hE58KUNIt031HfZXoWqSvp33WlP7pi0G+XKoh5FL1IQhDFwNCOxMWd4FkZwvSiDvVoTB18HDNVhjR82gFVF0YKb3D6UWxhr0djl/37oxGCnzaiSbUbFroP38RPuGyBifID4VqUKvjeZ/YH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750317149; c=relaxed/simple;
	bh=V3imZF6UNU74btzqmMqKebm/23xac0lFB6v3lNG6xh0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bFw3vHg7FF4iG2+veEkMWVn55Lx0XoBrlXVJkQjldgLlS0mXB3pszHfjKzi5PyQS+v6aIcPXxDWmLVJ2YrBld05hz1nbob1Is8TgKYhlVJf5HgI3/q5lhOINhwmCvSID6v3MB6PWIe2MpD7HXqUSN56pY1eEmgJW0PO2P7ENGdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chenxiaosong.com; spf=pass smtp.mailfrom=chenxiaosong.com; arc=none smtp.client-ip=18.169.211.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chenxiaosong.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chenxiaosong.com
X-QQ-mid: zesmtpsz2t1750317035tbaf4f31b
X-QQ-Originating-IP: u6g0KYz0xwxR6Veyp07lpRmHTzkjeSVteaUPdzjxhww=
Received: from [192.168.3.231] ( [116.128.244.171])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 19 Jun 2025 15:10:33 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 11891332971441617108
Message-ID: <16608EA06321C225+af69d39b-61e7-4e9a-b382-ecf1e7f2d519@chenxiaosong.com>
Date: Thu, 19 Jun 2025 15:10:33 +0800
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] nfsd: convert the nfsd_users to atomic_t
To: Jeff Layton <jlayton@kernel.org>, chuck.lever@oracle.com, neilb@suse.de,
 okorniev@redhat.com, Dai.Ngo@oracle.com, tom@talpey.com
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 huhai@kylinos.cn, ChenXiaoSong <chenxiaosong@kylinos.cn>
References: <20250618104123.398603-1-chenxiaosong@chenxiaosong.com>
 <197b15028aa942d2812b1746aff453c4e791aa00.camel@kernel.org>
From: ChenXiaoSong <chenxiaosong@chenxiaosong.com>
In-Reply-To: <197b15028aa942d2812b1746aff453c4e791aa00.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:chenxiaosong.com:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: MAC7MeOsTVc2RwVFMb2wjRd+0wDgH1I4iR0tmJ3I7/zm1R8LUN4r4AT3
	LpVunoB9Wd2IF0l3GKqPJdmzaD8BE7ONiTfTHA8TnMi2adHAF3t7RgPMytzWME6bQs3SYvt
	Ie52wnHXvrUZnpstvW5hHSeHhbf+3VOqv55JEFwrKa26iIFznvP9+aQkNzmWLn/vSs4DLuO
	SYpy7DSCVhXr0KrBpFaml9MhULgiZAuXtbOkN9+0FFnoEoJBJ0RTPE0srreoUyPCyVsH1l4
	XJp3JO33/KAkj+XbUeRM180ctAIuQIoW0tfJVkoYWQ8aazbBOULErQu8+Vg5aplSA7E2MPg
	U/7YsDA2FEfxFHtHvABUzkSoJrwSkKWAKYh/Ifu58y8eNSFlX5YTr+wrofSMP4sb5yOtNew
	ZwSPAVZBWshaz6JMixTHUIwti2CIXVrlHeHZSe3OX+myU5JmVXbGGnADV0afHJf25O95Gm+
	fhoN1P89aUvr1OKP4wnPTFMOMCITBTznr67d84O4gt9bj79A2t6Qbp0+Gx5LwN+s71NDm8M
	gI0/8nDKOePuzd3dMTCAufQXqY7TuaQhPIjh0ByVdAr+1gxQ7YFSTx0KZ8g3heVYDdXXGO9
	iX6JL52f0GMhANEhsZM9sutJ3WUe0xWbpHOxZJCZfIvrYk/N9tYkGtwnhZiC5z8JvjHRDPI
	efA12Ty3wF+UjCnZ6uW8ptYNY7ClnoVuvNjiRODhkWgEuX+0eY6cpvDZbswDwt7kKhzciCW
	l+8y16N2PDQCQIySWAuKIkR1y+bIlf7WM5cV9+etcUv3qUVhRFpc7YWJGA8phzTG7t4Az10
	7qEQbjycZ4u0WqvPrgZgsawnhTUhwAg9VnANZ1wBbos7pDUIOHl29K3wFMynyPMqgXfzH6q
	9xWb2giHB4UJPBbVuLf4EbKq1pl/epRxbk8CrXSws7fmMEfyOwEsJUonJa25t4JiFgqFIpT
	lW2de8bQDVkTiCRRhPRhL1lYg8GFpPOtJtFpp22mZoO4lsMbuPnpyFzn1nIfXZ7JaE41mOE
	rsq60Otk0/M6ksCNLGZh/CdR4ioSmG2cb6XlRq6g==
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
X-QQ-RECHKSPAM: 0

Yes, nfsd_users is protected by the nfsd_mutex. But the following log 
confuse me, why were they printed in a very short period when crash?

     [24225.575708] nfsd: last server has exited, flushing export cache
     [24225.580242] NFSD: starting 90-second grace period (net f0000030)
     ...
     [24225.807458] NFSD: starting 90-second grace period (net f0000030)

Why was callback_wq queued that it had already been freed? And a new 
callback_wq was created. I’ve added some new vmcore analysis to the link:

https://chenxiaosong.com/en/nfs/en-null-ptr-deref-in-nfsd4_probe_callback.html


在 2025/6/18 19:50, Jeff Layton 写道:
> Isn't nfsd_users protected by the nfsd_mutex? It looks like it's held
> in all of the places this counter is accessed.
> 



