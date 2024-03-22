Return-Path: <linux-nfs+bounces-2442-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BDA888869BD
	for <lists+linux-nfs@lfdr.de>; Fri, 22 Mar 2024 10:53:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4236A285387
	for <lists+linux-nfs@lfdr.de>; Fri, 22 Mar 2024 09:53:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEAD521370;
	Fri, 22 Mar 2024 09:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kuleuven.be header.i=@kuleuven.be header.b="JU8x7Dyr";
	dkim=pass (2048-bit key) header.d=esat.kuleuven.be header.i=@esat.kuleuven.be header.b="YiG4Cwp/"
X-Original-To: linux-nfs@vger.kernel.org
Received: from icts-p-cavuit-3.kulnet.kuleuven.be (icts-p-cavuit-3.kulnet.kuleuven.be [134.58.240.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBFAA2E648
	for <linux-nfs@vger.kernel.org>; Fri, 22 Mar 2024 09:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.58.240.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711101221; cv=none; b=Ymf5nGrMcC9pbfD/TjVzc6DpZdQXPuagQQYMD/qX0un0A1nowUcod4iGz8YCWoEVkHOc8WPGxldBBWdn6bebnPSpsUdOqAgWDK9pKzaEGhFIzJVQI35LL8mtsEOXEnvbndRQ/eJaxD+0OWPy/XQazN1Cj5RDklhxg6/aShpVz+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711101221; c=relaxed/simple;
	bh=GbUXZ3qE7TVckZyVwwWMrIez7XlZa3pqSwAwEHfpR4c=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Opeto7je45kZHOfBT4XfbeiF+/HsIjAUJ+uYpzNzXDVJVltN4az76GnioB0Nt912HmSEgraKpaSTB3zPmv9XTbrJ2ZcIxy0dxN3t3u7iyIEucIzWLUk7esouuUju3lkzcsAn6mueCHGp3iuCRsqg2+WnLMpOoEW11YdTo+HcUP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=esat.kuleuven.be; spf=pass smtp.mailfrom=esat.kuleuven.be; dkim=pass (2048-bit key) header.d=kuleuven.be header.i=@kuleuven.be header.b=JU8x7Dyr; dkim=pass (2048-bit key) header.d=esat.kuleuven.be header.i=@esat.kuleuven.be header.b=YiG4Cwp/; arc=none smtp.client-ip=134.58.240.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=esat.kuleuven.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=esat.kuleuven.be
X-KULeuven-Envelope-From: rik.theys@esat.kuleuven.be
X-KULeuven-Scanned: Found to be clean
X-KULeuven-ID: 2B6272029F.A106B
X-KULeuven-Information: Katholieke Universiteit Leuven
Received: from icts-p-ceifnet-smtps-1.kuleuven.be (icts-p-ceifnet-smtps.service.icts.svcd [IPv6:2a02:2c40:0:51:133:242:ac11:1c])
	by icts-p-cavuit-3.kulnet.kuleuven.be (Postfix) with ESMTP id 2B6272029F;
	Fri, 22 Mar 2024 10:53:28 +0100 (CET)
BCmilterd-Mark-Subject: no
BCmilterd-Errors: 
BCmilterd-Report: SA-HVU#DKIM_VALID_AU#0.00,SA-HVU#DKIM_SIGNED#0.00,SA-HVU#DKIM_VALID#0.00,SA-HVU#OURIPS#-35.00
X-CAV-Cluster: smtps
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kuleuven.be;
	s=kuleuven-cav-1; t=1711101208;
	bh=JWL6eJ8TMa7UQ4AOVTbAWuCvsBgh0suVZaVdfMFH1SY=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To;
	b=JU8x7Dyr31Dm+ERVEfZhUAlpzHQrYiO61nj6DXmakkzUUjVcBB0iv/gz0jHfzJWmD
	 /PMO6aqtKPd9bZKz1t0JevRtd2DnebtNZKykOsnb+rVpciW8qD0NvHYrU9B8j/balF
	 YRTPHVYBHrSPXx22xV4U3Y4irFHFsNAV80I3i31Z2ypxexaeUK+niZflsryDVkfc6N
	 3xaVFkl6Lsex3uYvdi8DF9nUbDNbHXgGX6MryvG/N9vARCHVrt2Rg7JxWd1q4hxKzQ
	 2L75FdunkjJzK4di7N1PIIztijyPdQCsRNhbqr6yxN2+sFzcVnw7eJdwSYOtBSttT0
	 nql3E6WwobpCg==
Received: from hydrogen.esat.kuleuven.be (hydrogen.esat.kuleuven.be [134.58.56.153])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by icts-p-ceifnet-smtps-1.kuleuven.be (Postfix) with ESMTPS id 05093D4F4A6EF;
	Fri, 22 Mar 2024 10:53:28 +0100 (CET)
X-KULeuven-ESAT-Envelope-Sender: rik.theys@esat.kuleuven.be
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=esat.kuleuven.be;
	s=esat20220324; t=1711101207;
	bh=JWL6eJ8TMa7UQ4AOVTbAWuCvsBgh0suVZaVdfMFH1SY=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
	b=YiG4Cwp//Vw6AbUGjuEg5k0WGbTN7govP2p1zpEShqxZzW2Vux3KRrS6/xDBdyjTx
	 ttkzaojSp3tTppDWtDSD0rYRiBtlnA2f5Z32hgzlLPZtkOrYZ7wiXxDe6J20BW6Av6
	 flRNY1Cp6SNiwg/h+fQuCxNdQkq/5Jom0WMTuO5R20Y8SK5DvzagrD6VEJhUNIDEA+
	 FeohNLSeMyA2fhkGK3jdBE5/nZHxoBQy5WU/qs3E9S9DBm/lgSO9kbbTRVUp1zie2U
	 trJIozC49nkfnymo8hhrzAMoGA9pZ3Yl/cTuafnswJCAqD0a2cUIYTkUJKnA8bvD6X
	 Z6DglDtkTuhBg==
X-KULeuven-ESAT-Envelope-Sender: rik.theys@esat.kuleuven.be
Received: from [192.168.1.178] (d54c12615.access.telenet.be [84.193.38.21])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (3072 bits) server-digest SHA256)
	(No client certificate requested)
	by hydrogen.esat.kuleuven.be (Postfix) with ESMTPSA id CC14B6000E;
	Fri, 22 Mar 2024 10:53:27 +0100 (CET)
Message-ID: <1be78aa6-f8b6-45c5-a800-7af07ad532ef@esat.kuleuven.be>
Date: Fri, 22 Mar 2024 10:53:24 +0100
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
X-Kuleuven: This mail passed the K.U.Leuven mailcluster
From: Rik Theys <Rik.Theys@esat.kuleuven.be>
Subject: Re: RPCSEC_GSS_KRB5_ENCTYPES backported to some older long-term
 kernels, but not 6.1?
To: Chuck Lever III <chuck.lever@oracle.com>
Cc: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
References: <ff131330-9f1c-493c-bfe2-8732a2730bf9@esat.kuleuven.be>
 <F2ED9EC7-3A5E-41B2-B225-FBF28C99132A@oracle.com>
Content-Language: en-US
In-Reply-To: <F2ED9EC7-3A5E-41B2-B225-FBF28C99132A@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

On 3/21/24 14:33, Chuck Lever III wrote:
>
>> On Mar 21, 2024, at 2:28 AM, Rik Theys<Rik.Theys@esat.kuleuven.be>  wrote:
>>
>> Hi,
>>
>> When booting the 6.1.82 kernel on an EL9 system, the gssproxy daemon started to consume a lot of cpu, and clients using krb5 NFS could no longer connect. When comparing the kernel config between these two kernels, it seemed like the following config items were not set in the 6.1 kernel:
>>
>> CONFIG_RPCSEC_GSS_KRB5_ENCTYPES_AES_SHA1=y
>> CONFIG_RPCSEC_GSS_KRB5_ENCTYPES_CAMELLIA=y
>> CONFIG_RPCSEC_GSS_KRB5_ENCTYPES_AES_SHA2=y
>>
>> I'm not 100% sure, but I assume this is why the clients can no longer connect.
> gssd is supposed to work fine on kernels that don't have AES_SHA2;
> for one thing, AES_SHA1 is always enabled in those kernels. For
> another, the kernel exports a list of supported enctypes to user
> space, so gssd should be able to detect and adapt.
>
> Can you dig into this a little more? The connection here is tenuous
> at best.

I'm trying to reproduce it on two test systems, but for some reason I 
can't reproduce it yet.

I will let you know when I can reproduce it.

>> Looking at the net/sunrpc/Kconfig file, these entries don't exist yet in the 6.1 series, but according tohttps://www.kernelconfig.io/config_rpcsec_gss_krb5_enctypes_aes_sha2?q=&kernelversion=4.19.310&arch=x86  they do exist in some older long-term kernels?
>>
>> Looking at CONFIG_RPCSEC_GSS_KRB5_ENCTYPES_AES_SHA2, it seems it exists for 4.19.310, 5.4.272, 5.15.152, but not for 5.10.213 or 6.1.82.
>>
>> I assume it was backported to some older kernels, but not 6.1? Would it be possible to backport these config items to the 6.1 series?
> I don't understand why AES_SHA2 would have been backported to
> those earlier kernels in the first place. I'll have to look
> into it.

Thanks.

Regards,

Rik


-- 
Rik Theys
System Engineer
KU Leuven - Dept. Elektrotechniek (ESAT)
Kasteelpark Arenberg 10 bus 2440  - B-3001 Leuven-Heverlee
+32(0)16/32.11.07
----------------------------------------------------------------
<<Any errors in spelling, tact or fact are transmission errors>>


