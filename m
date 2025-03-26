Return-Path: <linux-nfs+bounces-10910-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1405AA71A7C
	for <lists+linux-nfs@lfdr.de>; Wed, 26 Mar 2025 16:36:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 809D47A5BDF
	for <lists+linux-nfs@lfdr.de>; Wed, 26 Mar 2025 15:32:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E1FB1DDC1E;
	Wed, 26 Mar 2025 15:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FqBa5GGe"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB0451F3FF8
	for <linux-nfs@vger.kernel.org>; Wed, 26 Mar 2025 15:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743003219; cv=none; b=FWBTjwk1pWYFgeq0S1VThtHOaYXxEaJNGBYoCHiOMZzw1/e1m7zPuKqrO2MYkkw1BPnpfF5QU4y8aJbPMz8KDwh7TZJ5Y0Z8GYspJSoyw0fxlZwZgKwOIqDoI5cYPCGWYKAvxr/d4dC5TufH90c5wvdaxtLJXgvRzVGomNOtPlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743003219; c=relaxed/simple;
	bh=Ip6QihwDmk+zrTphmTqQdxWd9SdenfEbn3ibBIW0+Ew=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OCW3re13u6l2KWYHqddMT5XSsQvCwbL1pt76KE89PYLyq4pdhUKsk9qsI+ZhRi4tcMfl21jQT30twqJpCr7zCSLMtZa3Xigd2cWhT7LhSzfIFAVjXj0t71VvTtzzfe+/cnF441f1qoOsW8CExOJfmR06X8JLtICYxqFfZW7zyio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FqBa5GGe; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52QF58o4029068
	for <linux-nfs@vger.kernel.org>; Wed, 26 Mar 2025 15:33:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	CgvDL4GE4qJYQ2lGrgGPmGEgmwBedjfTJpVC72pJqcA=; b=FqBa5GGe8+74zjOC
	ZXLnnZbuP1d72RucgriFC43gc/TG6B/WGgD30ay9ad23l85EaeuQh4sgF+oLEh1/
	yqGSfxJn3OhryMY8xmrz3HS2XxwLcRNZwWG7GEW+atJCruoTymb7y1hQt5OACc4E
	T4Ps8ddSkhSMpxr1qo5taLPfEZlivt1H/MS1xq+qAvtnwDWHgoT4Nk2C7zgYobNV
	jcmfkyLwwYppm0nPnkZ6kOHklK3sIkk0GefJHTcVpJvsLKPp0gGSCKFZm85w77Sk
	oIWh732R5iTuhzMHffVxSWV1+losXh0Q6AhSlhGeeZm9uiB2Vt89k9UC9Y9KL4fi
	chIAfw==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45ktenc9ra-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nfs@vger.kernel.org>; Wed, 26 Mar 2025 15:33:36 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2fec3e38c2dso18450797a91.2
        for <linux-nfs@vger.kernel.org>; Wed, 26 Mar 2025 08:33:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743003215; x=1743608015;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CgvDL4GE4qJYQ2lGrgGPmGEgmwBedjfTJpVC72pJqcA=;
        b=EU/b1Z9TUChNCxMYAxaQeuYxiHAZxWOSJ1wn4e+MTqFb1TX1qpzzdaNo8EZw/nUbOe
         LLOek+kh3el5DriHAvobcTFYlNuVIzYqnbiO/TUmw5nMxNO0Ol4o9LHfRCsctUm5iQij
         UOio53TtRgcWuFwpRQzAj/tNasvFnlaCWHmlxTgQ6jdoFI7wCdslD5WjnnEzsh/oJwiB
         0lHm1pdurVNtH2KRfi0E9RDxk4JBSWpwaDhgQTvS4OttzOwM0Haue/hXPYRL/tYSCCeH
         RgERpk07aYfhe6Xk9vo1ffQvKIgqnGoB0b+bfnzL8Cv6Q8KyVFrzdo5l0K7chdKoWyo2
         Wc6w==
X-Forwarded-Encrypted: i=1; AJvYcCV7Ljcf6ex8vKPB3kgu52Go6EwyWtGi7XHLepxqEh+6fwUdTEL+hKy6IzNmZIeZudM/Bn0zt6dWnvU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeZ236OtFix6gNMcDGWTn/KRMVr3dopJq/Nu/DKyi9A43xF/DT
	TnKmiJTkGoF77K0r/N+GUDwv8sl/uxW/rAqAUaOBjOowJQMoSqOT2vajMV1gU686+MIkmMAk4uL
	lUhxycdH2551dYq9SE2bnLiT28OesDtc9uBkDqmA43002JFfX5CjrnasQ/P4=
X-Gm-Gg: ASbGncsZKWq1K92hOVyTuYagiPObbtX2T5FYe+vlbjH2Q5dTKfMg11uJEA12EgI9ItR
	A7ESX54rNLfeLkAE8rtjs4a/w3i+ubUEaFnWklitU1ymiU/WhogCh+iCMpAfTOu1B4c9A4f8uDl
	s8HOITq4JFUTHbG/2wwVea5d+sLOJouqlItGKEdn3JUuF8Jini9/Jnj18Dx4gSBgUej3ueQrFVH
	Bs9P/4UcPzAQBdrKvePT6Pd/otXQhB4ylIJJ517/lXmcuQYJEOaCaJ01fZy+MwbS84W2/1YNVWD
	4hYQUi1engqntocAe3XwoL+f/OuyZjrubwFlFeNVQxb0avlcDHmIzNBdzT/9naxU3YrZHGo=
X-Received: by 2002:a17:90b:1f81:b0:2f2:a664:df20 with SMTP id 98e67ed59e1d1-303a7c5d290mr219757a91.7.1743003214813;
        Wed, 26 Mar 2025 08:33:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE+F9lZ2G1hAT9YN0+Eubnld+fbDglazfyzGUfZewFaC0nIe5wKtuQLdbtGsp5RPEJ/BrNIQg==
X-Received: by 2002:a17:90b:1f81:b0:2f2:a664:df20 with SMTP id 98e67ed59e1d1-303a7c5d290mr219697a91.7.1743003214256;
        Wed, 26 Mar 2025 08:33:34 -0700 (PDT)
Received: from [10.227.110.203] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3039e4109c1sm342981a91.40.2025.03.26.08.33.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Mar 2025 08:33:33 -0700 (PDT)
Message-ID: <eedc7b36-6ac1-498e-8e73-1608621d84f7@oss.qualcomm.com>
Date: Wed, 26 Mar 2025 08:33:32 -0700
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nfs: add dummy definition for nfsd_file
To: Mike Snitzer <snitzer@kernel.org>
Cc: =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org
References: <20250215120054.mfvr2fzs5426bthx@pali>
 <4c790142-7126-413d-a2f3-bb080bb26ce6@oracle.com>
 <20250215163800.v4qdyum6slbzbmts@pali>
 <a8e12721-721e-41d1-9192-940c01e7f0f0@oracle.com>
 <20250215165100.jlibe46qwwdfgau5@pali> <20250223182746.do2irr7uxpwhjycd@pali>
 <20250318190520.efwb45jarbyacnw4@pali>
 <e2ec5e8d-a004-42b7-81ad-05edb1365224@oss.qualcomm.com>
 <Z-QYjLJk8_ttf-kW@kernel.org>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <Z-QYjLJk8_ttf-kW@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=TuvmhCXh c=1 sm=1 tr=0 ts=67e41e50 cx=c_pps a=RP+M6JBNLl+fLTcSJhASfg==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=SEtKQCMJAAAA:8 a=GgER2Vr3mkqatUWNVjUA:9
 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22 a=kyTSok1ft720jgMXX5-3:22
X-Proofpoint-GUID: zId9exxAPfdY1JATDnsVLW27UqQVdl5X
X-Proofpoint-ORIG-GUID: zId9exxAPfdY1JATDnsVLW27UqQVdl5X
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-26_07,2025-03-26_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=836
 malwarescore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 suspectscore=0 adultscore=0 phishscore=0 clxscore=1015 lowpriorityscore=0
 mlxscore=0 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503260095

On 3/26/2025 8:09 AM, Mike Snitzer wrote:
> Add dummy definition for nfsd_file in both nfslocalio.c and localio.c
> so older gcc (e.g. EL8's 8.5.0) can be used.  Older gcc causes RCU
> code (rcu_dereference and rcu_access_pointer) to dereference what
> should just be an opaque pointer with its use of typeof.
> 
> So without the dummy definition compiling with older gcc fails.
> 
> Link: https://lore.kernel.org/all/Zsyhco1OrOI_uSbd@kernel.org/
> Fixes: 55a9742d02eff ("nfs: cache all open LOCALIO nfsd_file(s) in client")

I saw this issue using crosstools/gcc-13.3.0-nolibc and this patch fixes it.

Tested-by: Jeff Johnson <jeff.johnson@oss.qualcomm.com>

> Signed-off-by: Mike Snitzer <snitzer@hammerspace.com>

note this doesn't match the From: address



