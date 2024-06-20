Return-Path: <linux-nfs+bounces-4166-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9240F910D8F
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Jun 2024 18:51:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 383C8282774
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Jun 2024 16:51:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D4D71B29BB;
	Thu, 20 Jun 2024 16:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="SR9S5Ux0"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CEDF17545;
	Thu, 20 Jun 2024 16:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718902285; cv=none; b=otaDUPEnPcdXcN+UWHYmv6ULxA/L9wBeX3zsAZ6QK7523ZYhvwlYqGZhqJPNXf+xSqFaPan00FUfRPNkOuzu+Uuzw8/iMusRL2tRe5OVfPX+pqLRH98HUgv/9UBIDbJN5/jswP1GLOp/cpu8N3cZs0B6kN5J2Lym9CwfdyDphk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718902285; c=relaxed/simple;
	bh=MeliXT5KED5LejV7TsrW5cNoTiGDZuWdQFvaVIeCEJ4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ndA2daTJU0GycgX9KAhsQIvRAk0HYkHdRFC2bqau/RqXSzmiiLXCeIrk9Gphyv9Id8qwzNVmlYjc1IwGGX7NJI9pzTuLU23HZBVZhZcPoUCRZdE5e6s5E3cu6G5G9vf91/ZMV7W3gCmUbXSbfqS7NBPt31lamTUzg59zcjshTME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=SR9S5Ux0; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45K9v5IY028296;
	Thu, 20 Jun 2024 16:51:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	4ZjUbYHQGmQ5Ple2LZPQoQcCC6f2MCBqlTdQhDqkWbo=; b=SR9S5Ux0DZmkRmMP
	FkCO5KuwLQqaxE7t5MZ2TMmGstZARPCMKQjovlUoN08bF9iGoCkv3wlGyqZCIPTC
	ijlOH/ys0riPgbR8gwBBEiceVll7AdbplgckkrOeExcpT6S+uRYYAuxdxgIxe+ep
	MjhdfKs3RDJtbpiqIY0LLcuES8ttx124CeKS9v9rT44Wa0aQ9xHRo7uyFwCtZLrm
	RJ6oF6tLRYZFsV3rX8lL664wJZF1KtHfuwJz3Vds/X0Gsu+nmoNRi8CCtmgvJEzg
	y2BucUOX/cRc2kZsfyMbR56ZPrLNC9sX60JLQh91zAG73J7HJulmUfv8Q9PkzeKp
	Cb9aVA==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yv7jejbcs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Jun 2024 16:51:07 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45KGp6cn011269
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Jun 2024 16:51:06 GMT
Received: from [10.48.244.93] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 20 Jun
 2024 09:51:05 -0700
Message-ID: <41eb004c-c7d2-407e-b324-2332aa400c72@quicinc.com>
Date: Thu, 20 Jun 2024 09:51:03 -0700
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fs: nfs: add missing MODULE_DESCRIPTION() macros
Content-Language: en-US
To: Jeff Layton <jlayton@kernel.org>,
        Trond Myklebust
	<trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>,
        Chuck
 Lever <chuck.lever@oracle.com>, Neil Brown <neilb@suse.de>,
        Olga Kornievskaia
	<kolga@netapp.com>, Dai Ngo <Dai.Ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>
CC: <linux-nfs@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>
References: <20240527-md-fs-nfs-v1-1-64a15e9b53a6@quicinc.com>
 <a7e7b2a3e9898225836d8263aff9e01e60390f37.camel@kernel.org>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <a7e7b2a3e9898225836d8263aff9e01e60390f37.camel@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: qiTPOXVP4hKmalFaq6vKQ4vc5j3tHFQe
X-Proofpoint-ORIG-GUID: qiTPOXVP4hKmalFaq6vKQ4vc5j3tHFQe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-20_08,2024-06-20_04,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxlogscore=991
 clxscore=1015 priorityscore=1501 impostorscore=0 mlxscore=0 malwarescore=0
 lowpriorityscore=0 adultscore=0 bulkscore=0 suspectscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2405170001
 definitions=main-2406200121

On 6/20/2024 9:33 AM, Jeff Layton wrote:
> On Mon, 2024-05-27 at 10:58 -0700, Jeff Johnson wrote:
...
>> diff --git a/fs/nfs_common/grace.c b/fs/nfs_common/grace.c
>> index 1479583fbb62..8f034aa8c88b 100644
>> --- a/fs/nfs_common/grace.c
>> +++ b/fs/nfs_common/grace.c
>> @@ -139,6 +139,7 @@ exit_grace(void)
>>  }
>>  
>>  MODULE_AUTHOR("Jeff Layton <jlayton@primarydata.com>");
>> +MODULE_DESCRIPTION("lockd and nfsv4 grace period control");
> 
> This module has some code that does other things too. It's basically
> some core infrastructure shared by the NFS client and server. Maybe
> this should read "NFS client and server infrastructure" ?

thanks, will update in v2

/jeff


