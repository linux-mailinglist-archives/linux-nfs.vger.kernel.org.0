Return-Path: <linux-nfs+bounces-21667-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UO2MJupvC2pXHwUAu9opvQ
	(envelope-from <linux-nfs+bounces-21667-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 18 May 2026 22:00:42 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D3AA5732E4
	for <lists+linux-nfs@lfdr.de>; Mon, 18 May 2026 22:00:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 97AB73024A61
	for <lists+linux-nfs@lfdr.de>; Mon, 18 May 2026 19:55:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D03F43254A2;
	Mon, 18 May 2026 19:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DyfNYWSH";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="MSdgwJVn"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0931838B7C4;
	Mon, 18 May 2026 19:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779134143; cv=fail; b=KbXz90rfIuApW4/AB6EfuA886CzvgkWU7hbQSgCz+aeGC+xC8kFcLaxKeug9+cDnmdtnWPJv8OWVuu/gp55lv1Nhkh7VAq4hTcogNcTBu/o93Q+D05/69XjYKTPMRZhebyVHE8oJTDa2X82/pJOnCjz1JoRrqQy5TzhgTaNPAFA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779134143; c=relaxed/simple;
	bh=gAmQpW3LSyKhFD5G1H0R5Wejoi+zq2RE61pTvk3E7KM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Yuyau3yUcEQlojmQsbivmPL0wqTnbEy0YMZyRLw1I5gV8PkuOewXenkqlGMo5hIXJv2PeEjnMI1yB5jlNXvJe5KQVJOmJZSxUI1t87MN0ks8T/g0BXBVrU+SkhehPAVB0VX8ihyxG/5j8ytyrrVO3LIocWB8VEOBVN765v0f7gk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=DyfNYWSH; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=MSdgwJVn; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64IEmgON1696594;
	Mon, 18 May 2026 19:55:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=VrsFmkoG9IjmbyoPV4XgfG9IFh7wxg/fiWhwWV0UYEU=; b=
	DyfNYWSHJNCthLd7JNBZB4PdVHPaGkr8bl8Invn/R2YrJVkDU74X9bGnttnSz56r
	PVzXDK3dTEJPsTUNr8IL9PKxajYuaHEb58idla+BRC968Cr/laGevM98i4ArOYOi
	pxSunU2N2/mnXRenOosemfkKdvmW0L9tAxwJ+juXXq1ccNCjCKOTPH+GtcvyZgmw
	jhHD/PibDyxB4LZiOXrg/U09W+QwauIX8s33/R5NzfvGqWKWE5BWBS9bntcu2Cbg
	wonwgws4yDl17TMGxlFnAGAOhW7O7R33TViHVEEtC6jk68TwFhNv+CBsTWO5eet+
	xncVKv0h0d8a7HBfQHU1tg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4e6h86ty1x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 May 2026 19:55:24 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 64IJns0W019951;
	Mon, 18 May 2026 19:55:23 GMT
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11010052.outbound.protection.outlook.com [52.101.56.52])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4e6f19vxjf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 May 2026 19:55:23 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yeTyxj9z3JmXdpYUElY6W/j9vRXLc2Omnel2kT6bl7Li02Cxb9v5Y4slHjw2MKPA8XVwqzU4ZziPSTWBnVQVBHfIqL/StQtRP/B73PwFD+fSpysDl7AZ4d4OMoTLJteFc+1fBUwFk13XppQXBy8yMgg2EFQTKz47U+unDj4HrDtWsYujlyV7icB3xf0jgGd2JDfrfyisSC93+ExDPKag1xiuVve+t3ECOLEuoIRelfhNX4UQhPaVb0OabAnRZ9TBekYHHJT9baC7HhABiw3+j4rURpK1BF3Wp0jl0adFTIDTIDnr698b/VUanagzJhEvIQkDtcE9ZtPcwiw+4PkNoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VrsFmkoG9IjmbyoPV4XgfG9IFh7wxg/fiWhwWV0UYEU=;
 b=dFN70/+bfa7Z4moLE4nDCosb6g4/kUIxtJdGBMrL9l/3BLlVMDz2GFXxGM5dSrY+LNj9B9WKb2D7iXMVVi9jGWrQTgCcxFtgMiMdG9qngakRv8uggo+j1HJgswJc8KlD5Dv8iEhIty4jc5qQo77NTB9baE5M3TeThxz/Rjz28Sf6LkBibCmG75YYBlYKgr2OjrHQb/+q7ti2ZJW5d1lECWvFtDBwgjNfUKkW1xC3gTTsMHTT9bGVJcnU5Q7m9pdPx2qIVEe3qg12U8MK16MsaKhjVchC4P9MCdaCPvi1I2KwZke11BVVKAK+i6YOahFHOFlgdup9jPG2euM/fV+/cQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VrsFmkoG9IjmbyoPV4XgfG9IFh7wxg/fiWhwWV0UYEU=;
 b=MSdgwJVnwsFjG35h9X2i4QrK/BcbgeqDHF1lENgKIs/aWAz3lXVQH1I9dOmmyLK7GyuGjm6WOgVfgP16JmdCPw+rsNwZD/AF9DM55cWtVfgLasoUSh889BVxuSmAW2hVBfjcxpjUBuEnd/tK+kl94Nv/idtiKJbz8dejNzhQ37c=
Received: from MW6PR10MB7639.namprd10.prod.outlook.com (2603:10b6:303:244::14)
 by IA3PR10MB8275.namprd10.prod.outlook.com (2603:10b6:208:577::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.13; Mon, 18 May
 2026 19:55:20 +0000
Received: from MW6PR10MB7639.namprd10.prod.outlook.com
 ([fe80::8386:1d11:46b2:b163]) by MW6PR10MB7639.namprd10.prod.outlook.com
 ([fe80::8386:1d11:46b2:b163%6]) with mapi id 15.20.9913.009; Mon, 18 May 2026
 19:55:19 +0000
Message-ID: <606c4cea-70d2-4601-9db2-611cd35c3687@oracle.com>
Date: Mon, 18 May 2026 12:55:17 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] xfs: fix overlapping extents returned for pNFS
 LAYOUTGET
To: Christoph Hellwig <hch@infradead.org>
Cc: Dave Chinner <dgc@kernel.org>, "Darrick J. Wong" <djwong@kernel.org>,
        cem@kernel.org, linux-xfs@vger.kernel.org, linux-nfs@vger.kernel.org
References: <20260512172238.2495085-1-dai.ngo@oracle.com>
 <agQhzg-0aeISwOGW@infradead.org>
 <961eb355-2f52-47a0-9399-e050a4e535a2@oracle.com>
 <06d9b1ae-e46f-459c-bcb4-1a5ca4ded4b0@oracle.com>
 <20260514002513.GQ9555@frogsfrogsfrogs>
 <26365a46-bdac-4e8a-a951-de904c3e5606@oracle.com> <ageSguSyf2kBY33a@dread>
 <b9860332-7b1e-448e-869a-ad59d8d5b7c0@oracle.com>
 <agqfBPRWXQDR2ImG@infradead.org>
Content-Language: en-US
From: Dai Ngo <dai.ngo@oracle.com>
In-Reply-To: <agqfBPRWXQDR2ImG@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH8P222CA0024.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:510:2d7::14) To MW6PR10MB7639.namprd10.prod.outlook.com
 (2603:10b6:303:244::14)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR10MB7639:EE_|IA3PR10MB8275:EE_
X-MS-Office365-Filtering-Correlation-Id: 3afe26cf-4d2e-40a1-b566-08deb51763be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|18002099003|22082099003|56012099003|4143699003;
X-Microsoft-Antispam-Message-Info:
	l2fNJgaBSXXGLSMGzO0MMHCBuVPyWE8nuzj3RhxL1kk7qHOBDty4av2LhYi98SGMlpLWzTYthBOcMHyochl+TZ3sb1MW+mpi9zOeKT3rZCMDAt+PmJ6WfZ45qx9azj/P3P6m9SjxBItUZNpxhdggYslCFPD40Fk/0XTiJLGSthgw+6kbd30XrYh92kgOui/DNzeBqYKkoFtPhGwwC38itIk/xxXPAWG6RhgJ0au5yJlyt63sCz+6W9CqTidg5pD5+wT9X72uoVmhQIntbKH5D68FJK2qkJOXoW/KEOW6m18PNnujIhSBywwB8iWFObQnrAI1WEweds6V6x18avR8wISHV6Bb2UYPVw4gIcxic166VsV/n4Qo1/bCQ4QKWsgXj1Sp6BltCz/LVrUVQJCFTxKtptbi/88DUdqjo5eLgJ75ExorU9p+XBPhM011WCnh7vR59hawSyTNrEhcuoVb3TrWRgsVk5WIb8Pz+mR7MmOCchAQOEVkmROdKYNZokVIUEkvr+qOB+4Tpu/fskopHIm73U+5Gmfr+nkr3ptapcuaAjvvmpoxA1Zr/9424lrW4htNlCdm4+MGGiQlstSPJbXgSw5ZbNLUuz4Z/Qos9H2nR+/X9hicP69GNN+W22oHs06ezIvfs2T8QTgBQSktTfbxpDpJVbh08PLexDdKl6TtRAsZ0W/8q//VAChKpxVL
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW6PR10MB7639.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(18002099003)(22082099003)(56012099003)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bG1SNTdGZ1RvWmFYanJlMFFPL2pRNzVlaGYwY3FzRTZqUE1rZTNBcjFFZGIx?=
 =?utf-8?B?ZnVuWHVxNWpnbHFCMnZ1eVFvWnJzUVRoQ05kNDBlazlMWWdHQ1kwaVZaMjRT?=
 =?utf-8?B?VVMwTUlrV0hxMEthQzVoNGgxY1hzeEE0MFZQdTRqZ0pmVmd1dmNnbCsxUzR1?=
 =?utf-8?B?R29rUmhLb2NKYWt3RStUK2F0QnFmcVd3cGYxMVN1NUNxc3NUZGlCait0b3Ns?=
 =?utf-8?B?UkUzOWsrVFRweGNBYk1Fek1ady9FVjhNWTFrWlpzdEYwTUR6TXlTQTdoaUJR?=
 =?utf-8?B?ZnRpWGxRdW1aSDdrekhBZ1F5T3A5dUErL3lBRzhWQnRPcU5SVEQ5akFhZzBw?=
 =?utf-8?B?SGRneXA5OFpRY09NWHJLV1Axc3BDZU8rLzNBSGNpYkNBUTJDVWdPQllEU3Bk?=
 =?utf-8?B?bjZvVmpYdmUrb1NBdEZENit6WkNNQjdBMG5KQkcxQVRNRFdLWGFxSXlYQjgr?=
 =?utf-8?B?WDhma1ZNV2IwbTlkRkI4bDVJTUhSLzlzMmowQ21PaEJBNXpEVjU3MngyMDdC?=
 =?utf-8?B?aGpNb0lBaFRiWXNUcS9NRW9VdFlGcUlmakxRQWczOHpaLzlCWGk5SndEOUNQ?=
 =?utf-8?B?KzRwUWNFM3NLd2d1clVDaDg4N0toQkpackIvcklhcU5KN0t5U1MrS1E1QUNz?=
 =?utf-8?B?RmFNR2xOV29VQUtFOFdTRVhxZGxmYkRsVHZZN1UybTZEYXZ6SEJNNFlzbWZE?=
 =?utf-8?B?eDB6WGF5WUpXM0s4NDBMbGVRN1g0RGpXalZINURxeEtBUU91WVNxV0U4Uys4?=
 =?utf-8?B?MEdmTGloUUptcHR4NmRKbzE0Rmo2T1NOYjU0dnFTbVg5S3paa3ZjdkZOMWtn?=
 =?utf-8?B?UWlQT1NKTk5YeUFtRU1Fcm5DOGpNWlVLejVGMUw0dmV2QWZYTEtPbkFPdTdP?=
 =?utf-8?B?d2ZUdkNjbUpkcXdGaWhkSnFaekJZd0JVZE5UWEYza21ZMGNuVHhqdWh1RUpL?=
 =?utf-8?B?akdSZk9obCtSaFRtalhlbjJGanRGY2lqK291bm1VbjRjR0xhNll5Y1dncmhZ?=
 =?utf-8?B?TTJhRFdHTHdVNkxSb0JuRmtJaFBUWUNjcGk1bTJVaDNseG04akhtQ3ZER3lD?=
 =?utf-8?B?djhHV28vV3NNbzArWnVqSzlTamxmM1FzU0Q5a1ZaUFVjbS91L0plSkFWQ21a?=
 =?utf-8?B?NStYZkl1OUlHSUxia29tZFBsZE4zc3kvRHh2RzgzQUVBTUdDelI5L0Q0RmJh?=
 =?utf-8?B?NHVOM3h4c0hIbXhmQmErdHBOZFRjb3k4Q0ZXcVlPYzk3Z2s3SEcvZGNzaENB?=
 =?utf-8?B?QzRsTDhpNlpyU1J1M284M2VrWlI3QTM3Sy8ydHA1Y3F3Um9NdituSmt4VTlo?=
 =?utf-8?B?T1VBUW51TllqcHJjN1lVZGlIZU9ueG13M0tqSnUvanJCWGRabzRjZit2ZVR5?=
 =?utf-8?B?cklPQkljTktjazF3K1d3VjQrdnNsRXVuNlBPRm5jRDRSejdqZExZUkhYcDBW?=
 =?utf-8?B?ZEsvUzgrTTRQSEVWbEhMbU9iUHFNQnhuMnplWGtBVml3NFcwU0ZjVWZHbmNZ?=
 =?utf-8?B?djJRVXJTd2dsL1ZIb3Y2aU8wRW8zWklvTThhTWYwMElPazY5cVBKMytnTjRh?=
 =?utf-8?B?MVZvZVVQVFdVaFdGRWRtOTRJUEVPYW5XamlJTmJ6K1BhVHFjSEtkTTR1cVoy?=
 =?utf-8?B?alpNREI1bG9xbFV3U2llRFd2aDdWWEFQZEVnbEVqVUZ3NVdSUms4TlU3WVpa?=
 =?utf-8?B?QTZJRXBRZlhFaGwvY2NzQUphazVJK3Y3R0ZYa3N5ZHY3NVlxQmxyb29lVnRJ?=
 =?utf-8?B?dG52YmxiekkwSm5Ma3RqN0tFSm9YbTR0M0xKeERmbEROTVRMbHRCS0thVkFQ?=
 =?utf-8?B?akova1JsNGRpYkJjREFsMDRENHYyN05YL1lWZVBFaENmS2pWZ1JseGRnV0xR?=
 =?utf-8?B?U2g1MDFKVHgrR0taM1hQelZ6dFRLLzlqUVdKL29OZ29XUnZRdjh1a1JEaisz?=
 =?utf-8?B?cVh3SkZUWDZ4enNQc05BbFNMN0swTDdGcDVaUlpUM09yVUJvbTZqckRqUnFa?=
 =?utf-8?B?aWlpVTQ4NnlaNkZUeUE1emlBWENSck54cDM0Q1lKejN2RDN0RlFsRzVkYjdl?=
 =?utf-8?B?NHFpR3FWaEJqVFVNQk1zNXNsNXp5UytMNVVZMS9jTHNzWEIzTDlLZGZReWo5?=
 =?utf-8?B?dTFsdTZjZFRTMllHem0zc3A1YmZsd2JjbjZoakpTU1NBTDQ0Y1N2NEt5NEZl?=
 =?utf-8?B?a21RVXJUclh4MXZaODJiazZqdHMrbEsrVXlSQkM4RUxhN0l4aGFYN05hZzl5?=
 =?utf-8?B?aEFWek1OOVdnUWlvWk5sNHV1Q2diU3dDNWRaSERtQkFjRVJrbkYyUWdwWEtn?=
 =?utf-8?B?dE1wVkl5WG5Db2crZ1ZQS2tha2tRZ1hxRzlZUitaVythL25uL1pqdz09?=
X-Exchange-RoutingPolicyChecked:
	IZljdqjHXYx4j2kkvKVRCrfJ0Jy4hGJ2BiedNADjPi13k3lhC3+stDI8eouM0aC/2D+OimvO8RLZ6EdRl1mIlw/moewnVNl/gUNnYtqtgG9I/It2jXGZUBIOriPB8R3VDVBOMjJ+Ml4vjOrlX4puA6Q5a92DaVYBXjk95q8zSLpiLR3Q0+j0mjg6xTDmyBAI/tNQ+Q9zpYZjxYY9Wz9Mpis9oB6SstnQdMZf1dRpZsLRjo0toIrnmNRfj/3QJQKHSa1ZUCdaj1051QUUThk5TRi2GdlSW9XMgCXTQScJZxdojiob4Widw5abZXVZVg0288jK3NKjQ1OmGSrKRiOmlg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	HeT5xVELqpaBDcR2n4k5yNz8ANWSKrDraTVrSGKWbDoD/FjiPYi+4JGasMvaMf4XzrPWC0s4f8HrXDUkbr4uHdiASctBhPiV9L68YLBnXhqW5e/WbIXyD9K6K/bh5h9d5vYIjGlcx3Yt/dPXasEeXpztdAyywWPIm8wpmLhwHvI92yge0Fu6FvYXhg9KMAQXwYPRZdQ9kRJ72FAxsuOKgqhBpdKVMMCq2gVTQX3fnU6WZXftJzjMlF63+VLwFHKXOYhsFqEsjoPRwi4dR9L4Dws4QiKsbK62wlIaPbLFtBxFDOBd3RpGSukTABxNSnoYhSEN0qg/ZQl78tu9BlQadCCV0aMrUsuY13Ip73774bJJgRCSw9qqGjTEpaNLCyTp0cj1v4gKLvbPUkKwa4rJgUsO+yDqXgmYiAwd7vPetuqTB8SIbyLfwL5mwUDhAKPEJws5oAMwAZilHwgLwXn5t1IzxWv3lbSf5Mikf7DWFtX2uN32LKlBerz0mQK6c2LBGBFbDh6AH3peOH1L1KPo6yabLJSRqyG7U/eJ5HooXYxeqGpYnniI9CMsXc8vG0EsKH2Em9i9lvxpCjHgvbyF+vlWKsIUzvuSikWN6kC22Yk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3afe26cf-4d2e-40a1-b566-08deb51763be
X-MS-Exchange-CrossTenant-AuthSource: MW6PR10MB7639.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 19:55:19.7234
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r33ggTke0m4hWUVEJYOy0+bFYRKC5Y6dirs6nGBoRIcslUDX0EV6mbS+x/qu+U9s/wW6aCFNkPyXO6pgOjN5mg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB8275
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-18_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 bulkscore=0 lowpriorityscore=0 adultscore=0 mlxscore=0 suspectscore=0
 spamscore=0 malwarescore=0 mlxlogscore=811 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2605130000 definitions=main-2605180197
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE4MDE5NyBTYWx0ZWRfX9wpxbHYCpQsP
 sTRc6ykkcI3gbO7iyAsKA8xUF7U6W3KmEe3gWxyKElMvq5hpd+ZzalamZwJDVccVbQ5cRyIRaSK
 5WAIro2wR8+yQyhzU2+E0gKt0R7sCIh2XfU8SwxDbKo2hWWd9lBu33i56fDJor40xsKDd/C2QXb
 sJmMdgZD4gEdFAPXEx9rmsF+8xWje5NHqgoA1YjqW7Qo8TiYuoPElxoPi95hh+XYvAt4Xy3L8+F
 mURbgxaArABiXsCOfg7Mi6yThJyiyOjvZ5zeNdJbY4HOTf+w02CvkxgNQIvERoqpcljPPVFwHCV
 lV3S0bpGGKVulaq80Mp69mxg8s8SgEEIgOS2MYuE5IKunoe99emB8HNiOdahGI+hTQJMBxQKRxJ
 oTtEQLzbXsW80/heyTSdFvG1laEE4k3D70BJL4cLEraK2p4gEGzHKUF3Jh2sgAyiiUONHnrIfba
 1rTHnP5EkfiF/sZAJ3Q==
X-Proofpoint-GUID: C_muauJHYLgTtg2LfVWTJlKxk1xn3tS_
X-Proofpoint-ORIG-GUID: C_muauJHYLgTtg2LfVWTJlKxk1xn3tS_
X-Authority-Analysis: v=2.4 cv=TLN1jVla c=1 sm=1 tr=0 ts=6a0b6eac cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=x0eKOSpe3m1H3M0S9YoZ:22 a=DM-OpEZoHi3-lEBqjJ8A:9
 a=QEXdDO2ut3YA:10
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,oracle.onmicrosoft.com:dkim];
	RCVD_COUNT_SEVEN(0.00)[9];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[dai.ngo@oracle.com,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-21667-lists,linux-nfs=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+]
X-Rspamd-Queue-Id: 1D3AA5732E4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On 5/17/26 10:09 PM, Christoph Hellwig wrote:
> On Fri, May 15, 2026 at 07:14:29PM -0700, Dai Ngo wrote:
>> Currently the map_blocks() API between the NFS server and XFS does not
>> provide a way to specify whether XFS should use XFS_BMAPI_ENTIRE or '0'.
>> xfs_fs_map_blocks() just uses XFS_BMAPI_ENTIRE.
> And that is a good thing.
>
>> On the first mapping call, NFS server always specify the whole file
>> range that requested by the client in the LAYOUTGET.
>>
>> So if xfs_fs_map_blocks() can not return the requested mapping range
>> with '0' on the first mapping call then I think using XFS_BMAPI_ENTIRE
>> in the first mapping call makes any different.
> Yes.  Still not sure why we get a second call that overlaps with the
> first one in a single layoutget operation, though.

I added debug code to dump the mapping of the file before and after
NFSD calls to xfs_fs_map_blocks() completed:

May 18 18:03:59 dngo kernel: XFS (sdb): pNFS inode 3846447 iomap dump
May 18 18:03:59 dngo kernel: xfs_pnfs_dump_inode_iomaps: off[28672] len[12288] addr[1957031936] type[3] flags[0x0] state[1]
May 18 18:03:59 dngo kernel: xfs_pnfs_dump_inode_iomaps: off[73728] len[65536] addr[1957076992] type[2] flags[0x0] state[0]
May 18 18:03:59 dngo kernel: xfs_pnfs_dump_inode_iomaps: off[139264] len[4096] addr[1957142528] type[3] flags[0x0] state[1]
May 18 18:03:59 dngo kernel: xfs_pnfs_dump_inode_iomaps: off[143360] len[16384] addr[1957146624] type[2] flags[0x0] state[0]
May 18 18:03:59 dngo kernel: xfs_pnfs_dump_inode_iomaps: off[159744] len[4096] addr[1957163008] type[3] flags[0x0] state[1]
May 18 18:03:59 dngo kernel: xfs_pnfs_dump_inode_iomaps: off[163840] len[8192] addr[1957167104] type[2] flags[0x0] state[0]    /* type_2: IOMAP_MAPPED */
May 18 18:03:59 dngo kernel: xfs_pnfs_dump_inode_iomaps: off[172032] len[12288] addr[1957175296] type[3] flags[0x0] state[1]   <<= entry# 7 & 8 will merge
May 18 18:03:59 dngo kernel: xfs_pnfs_dump_inode_iomaps: off[188416] len[32768] addr[1957191680] type[3] flags[0x0] state[1]   <<= into entry# 7 below
May 18 18:03:59 dngo kernel: xfs_pnfs_dump_inode_iomaps: off[258048] len[4096] addr[1957261312] type[3] flags[0x0] state[1]

May 18 18:03:59 dngo kernel: nfsd4_block_proc_layoutget: i[1] seg->offset[184320] seg->length[65536] seg->iomode[2] bex->foff[172032] offset[188416]
May 18 18:03:59 dngo kernel: Ext[0] foff[184320] len[4096] es[2] soff[1957187584]   /* es_2: PNFS_BLOCK_INVALID_DATA */
May 18 18:03:59 dngo kernel: Ext[1] foff[172032] len[49152] es[2] soff[1957175296]
May 18 18:03:59 dngo kernel: Ext[2] foff[221184] len[28672] es[2] soff[1957224448]

May 18 18:03:59 dngo kernel: XFS (sdb): pNFS inode 3846447 iomap dump
May 18 18:03:59 dngo kernel: xfs_pnfs_dump_inode_iomaps: off[28672] len[12288] addr[1957031936] type[3] flags[0x0] state[1]
May 18 18:03:59 dngo kernel: xfs_pnfs_dump_inode_iomaps: off[73728] len[65536] addr[1957076992] type[2] flags[0x0] state[0]
May 18 18:03:59 dngo kernel: xfs_pnfs_dump_inode_iomaps: off[139264] len[4096] addr[1957142528] type[3] flags[0x0] state[1]
May 18 18:03:59 dngo kernel: xfs_pnfs_dump_inode_iomaps: off[143360] len[16384] addr[1957146624] type[2] flags[0x0] state[0]
May 18 18:03:59 dngo kernel: xfs_pnfs_dump_inode_iomaps: off[159744] len[4096] addr[1957163008] type[3] flags[0x0] state[1]
May 18 18:03:59 dngo kernel: xfs_pnfs_dump_inode_iomaps: off[163840] len[8192] addr[1957167104] type[2] flags[0x0] state[0]  /* type_2: IOMAP_MAPPED */
May 18 18:03:59 dngo kernel: xfs_pnfs_dump_inode_iomaps: off[172032] len[77824] addr[1957175296] type[3] flags[0x0] state[1] /* type_3: IOMAP_UNWRITTEN */
May 18 18:03:59 dngo kernel: xfs_pnfs_dump_inode_iomaps: off[258048] len[4096] addr[1957261312] type[3] flags[0x0] state[1]

As shown, the file map changes. Entry# 7 and 8 before the NFSD calls
merged into entry#7 after the calls. So there must be some activities
that cause the map to change. I don't know whether the activities were
triggered by NFS or something in XFS or the block device layer.

However, based on this data I think it's better to change the bmapi_flags
from XFS_BMAPI_ENTIRE to '0' to address the overlap issue.

-Dai


