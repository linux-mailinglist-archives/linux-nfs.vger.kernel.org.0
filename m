Return-Path: <linux-nfs+bounces-12545-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29720ADDC14
	for <lists+linux-nfs@lfdr.de>; Tue, 17 Jun 2025 21:14:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00F1A4021A3
	for <lists+linux-nfs@lfdr.de>; Tue, 17 Jun 2025 19:14:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D67228C2C3;
	Tue, 17 Jun 2025 19:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="KwKo1FOS"
X-Original-To: linux-nfs@vger.kernel.org
Received: from omta038.useast.a.cloudfilter.net (omta038.useast.a.cloudfilter.net [44.202.169.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1819C28C03C
	for <linux-nfs@vger.kernel.org>; Tue, 17 Jun 2025 19:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750187670; cv=none; b=lBMxgOEPcln5cdwMAVVIT1utWHKu+URdnO9EKIdXDXQysjKxXeTWqVRocUS3rZNZPl3fxahQUiprxUiO8nhQRfCxpFUrX18wBB1jRkZX/OzA2YqX0nmXxHPVnbjZr1cR52nf2M6sgydgsRuMgsxlk+tuDI2UusR1yXaWriXnGE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750187670; c=relaxed/simple;
	bh=YZQsR/vrm9KwNtY9qhhnv6KAi9m5QWxGrRlriI9aHjs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VH0v32wpMcllIe1bX03XXNUn5cPOlNTWOJRBjLcfFCeUHfQoIb2aqPbkCk2etjd0++5oZW3Jb26ReqjNX9QoESCLjlj49gQ7bhj6Lg6lX6+IUxZt+kouG620/W4wxq00qTtnjOWXzypa7i61AyPJMucCgUg6+E5nU1LrrcVmZ2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=KwKo1FOS; arc=none smtp.client-ip=44.202.169.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Received: from eig-obgw-6003a.ext.cloudfilter.net ([10.0.30.151])
	by cmsmtp with ESMTPS
	id RX0ju1TkeiuzSRblMuoJAD; Tue, 17 Jun 2025 19:14:28 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id RblLul2zAh9ZxRblLuiDuI; Tue, 17 Jun 2025 19:14:27 +0000
X-Authority-Analysis: v=2.4 cv=GODDEfNK c=1 sm=1 tr=0 ts=6851be93
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=y7jUFFJD1EYPe7d4fIfORw==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=7T7KSl7uo7wA:10
 a=s59UEcVVmHqeHvMsZSAA:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
 a=xYX6OU9JNrHFPr8prv8u:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Ml2cmUz1N0aegwv2OFWm6Cc4XAe9xVhUfpcEF1NMAkM=; b=KwKo1FOSScYpU222dDvwRVZtQ3
	at5J1dW6mkQLxY5Mdy/kE5lod9IJ/7GhDnbIRi1rVqv8TWxfaZBpFUkUKVTZpg/4pVyYJwY2pIiAH
	iHBfPItS6t6t+CA2GJBcxzDl5/Gd3LQ6jiaTOG7zG6zZdt7UtqvSWdqn0GgHvK8evr57/S9EhaKLV
	AMTw93q8qqHdeSodT/SoQ+nLMCCj8NTeCPiP+XJYpnsTSb2QCntVUvfxrvufwsC7EWpSsdJwuzgzz
	aJQHe1vvipHYOvQmAEcHwp0/pkEvP23Jlp/6gPlUUTGHM75nBW1SllvWJCamUZO9WUE5YmAkrCQcv
	hp+5HEHA==;
Received: from [177.238.16.137] (port=52432 helo=[192.168.0.27])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.1)
	(envelope-from <gustavo@embeddedor.com>)
	id 1uRblJ-00000002Kme-3VPm;
	Tue, 17 Jun 2025 14:14:26 -0500
Message-ID: <1717f455-a38e-4df6-8b4a-284ed48c110a@embeddedor.com>
Date: Tue, 17 Jun 2025 13:14:08 -0600
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3][next] NFSD: Avoid multiple
 -Wflex-array-member-not-at-end warnings
To: Chuck Lever <cel@kernel.org>, Jeff Layton <jlayton@kernel.org>,
 NeilBrown <neil@brown.name>, Olga Kornievskaia <okorniev@redhat.com>,
 Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <aFCbJ7mKFOzJ8VZ6@kspp>
 <175016808512.336273.15483620286888395120.b4-ty@oracle.com>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <175016808512.336273.15483620286888395120.b4-ty@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 177.238.16.137
X-Source-L: No
X-Exim-ID: 1uRblJ-00000002Kme-3VPm
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.0.27]) [177.238.16.137]:52432
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 3
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfMxtlwLkQBKNVdeWhzPhylp43FJC+AfydHvElbnYv9NdJJTDvc2yFnmySTWr7RQ1VhSmN0oynIicjVqNlnHqUMxStwWL33N6UbX2FVXyuIVB3u6fLN4k
 YG1QhCu00aPWRdUtpljEGGicbGWViTbvHMmz/T+f/F/zNnLacH5CvWqoCf/mt0ddLAFPPxAPLwj+fUu3ba3f16NTXvvgY+hCVkk=


> Applied to nfsd-testing, thanks!
> 
> [1/1] NFSD: Avoid multiple -Wflex-array-member-not-at-end warnings
>        commit: 9aa83533d2e694c84d7d09f9c8eab29ad9f2adef
> 

Thank you, folks! :)

-Gustavo

