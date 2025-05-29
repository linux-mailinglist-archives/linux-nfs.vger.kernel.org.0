Return-Path: <linux-nfs+bounces-11966-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FCAFAC75BE
	for <lists+linux-nfs@lfdr.de>; Thu, 29 May 2025 04:15:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D47234E185D
	for <lists+linux-nfs@lfdr.de>; Thu, 29 May 2025 02:15:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E51BA242D9C;
	Thu, 29 May 2025 02:15:15 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail.nfschina.com (unknown [42.101.60.213])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 15571242D9A;
	Thu, 29 May 2025 02:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=42.101.60.213
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748484915; cv=none; b=XvlvjmJGW6HO2mhow6ip6lnUJc2bIIue8kSNICgYHZEV95GYT2yOP7pEKk6q9lcKgiDQp0xVMjFwrsAcVrFoZXVrnQFFZkgUCZvcUCxzNsahtZoENNv/7GjLnNHcy5OR7oE3VCuFza/81vr0dQ/dpjgWgTCbeeg03hLcHZGpV3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748484915; c=relaxed/simple;
	bh=uoBnjQGDJBMrwE64/t5MJuxLnRT/ZFE3O1Xziv5h7ZA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type; b=qvmIBooPeUjj1qsq5I2Yasnb3RsKw7hRxTxRyYj/gN21ld77PKUO0nrT6TpMKvq2Bw2Wx107I6OK+xZBV/UbleMcdIez3TF7egZ0yfwNp7qBy2m34XwuNLrEfb8WwKD53arD8C7AXzzRUagi7bVdD51jGmhhysCUafKgshLTHcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com; spf=pass smtp.mailfrom=nfschina.com; arc=none smtp.client-ip=42.101.60.213
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nfschina.com
Received: from [172.30.20.101] (unknown [180.167.10.98])
	by mail.nfschina.com (MailData Gateway V2.8.8) with ESMTPSA id ACD75601708EE;
	Thu, 29 May 2025 10:15:06 +0800 (CST)
Message-ID: <9d99618a-28a9-4ada-aba7-907f814bca76@nfschina.com>
Date: Thu, 29 May 2025 10:15:06 +0800
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nfsd: Replace simple_strtoul with kstrtoint in
 expkey_parse
To: NeilBrown <neil@brown.name>
Cc: chuck.lever@oracle.com, jlayton@kernel.org, okorniev@redhat.com,
 Dai.Ngo@oracle.com, tom@talpey.com, linux-nfs@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
 Su Hui <suhui@nfschina.com>
Content-Language: en-US
X-MD-Sfrom: suhui@nfschina.com
X-MD-SrcIP: 180.167.10.98
From: Su Hui <suhui@nfschina.com>
In-Reply-To: <174839190520.608730.15461813542926388395@noble.neil.brown.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2025/5/28 08:25, NeilBrown wrote:
> On Tue, 27 May 2025, Su Hui wrote:
>> kstrtoint() is better because simple_strtoul() ignores overflow and the
>> type of 'fsidtype' is 'int' rather than 'unsigned long'.
> Thanks for the patch.
>
> Reviewed-by: NeilBrown <neil@brown.name>
>
> The valid values for fsidtype are actually 0-7 so it might be nice to
> change the type to u8 everywhere and make this kstrtou8() but that isn't
> really needed and shouldn't stop this patch landing.

Thanks for your suggestion.

  I can try this next week in a new patch because this has been merged
into nfsd-testing and I need some time to view code.

Su Hui


