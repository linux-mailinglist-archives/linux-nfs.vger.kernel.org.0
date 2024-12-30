Return-Path: <linux-nfs+bounces-8846-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DB8D9FE79B
	for <lists+linux-nfs@lfdr.de>; Mon, 30 Dec 2024 16:34:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EA473A0F72
	for <lists+linux-nfs@lfdr.de>; Mon, 30 Dec 2024 15:34:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 259D4382;
	Mon, 30 Dec 2024 15:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NrLLLO+x";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Z0kkEcQ8"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FEC41AAA2F
	for <linux-nfs@vger.kernel.org>; Mon, 30 Dec 2024 15:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735572846; cv=fail; b=eKgRGYFJL9gyFrxzaEnfppg1pcXCgo5jl5dzJLLjfNhfmdvIT9T0AwDSqr/WjzC1DRMfHadNX1c3L2X/iAkE5vlz6KXjr3IE9rpxE6e7S/vmwoFEMxpku3NrxK+gxFU6Fw0qkCO6YU3M3NHpXB1L9PDrqBOQBMV08+tYXFNuY40=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735572846; c=relaxed/simple;
	bh=b6nLV0B5UnvCiUfcaagkXBI5WQETyC6LHousq6pMUZs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PoGJ/1R0rL8Lbi9jG7Oq+Pne95V5kpImxpJztgZM3qCB5/WtAJmJkZ9+lbTcrSOUfSeD3FxtFe5xoHIBAZ1zO1M2Zrn0rzj4aOava2V1BiUshyzT5+7Htc7C70GTTkA1YuuIw3ajxjtnlwPifG5TECc6xNUDiKwkpk+fYUgD47w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=NrLLLO+x; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Z0kkEcQ8; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BUChRan009769;
	Mon, 30 Dec 2024 15:34:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=QZ1n6PkHjeCAsBVjjQvKGkBxf7VZ61tNVgmjlx4VZZE=; b=
	NrLLLO+xSJzydAMDfZ4PSHBu6U3agRUEq2wbuxX7N2UbnsTomiM0PlIDSWhArBvK
	2LUbSdomC9OpYci3EXmQ3cg0tK9/06TqdSxift55Ac6CsxWzbIub/PmuuqJtU5YE
	EueRB3rFJBOJ8Q4fqUoUaLMve1S4+85gt4H/6sE5j60FgRdWpg06C/hY/mU7UBve
	PzUhM6nFXZdcaHvkawNrF8K+BhozNwbkcEOd/lDHeZMHzTJkiI0U1vj8eUpzEdyB
	W2MoI3anKo3ld100OTqtQVHfgYCl8dd+e0ruv5pDe5/ulF2rG/GmmUXfhlOFi8nn
	iHtUe0XbhSEFcV9sJDs/Ew==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43t88a27wv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 30 Dec 2024 15:34:01 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4BUF5OO4008470;
	Mon, 30 Dec 2024 15:34:00 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2048.outbound.protection.outlook.com [104.47.66.48])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 43t7s6rx2j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 30 Dec 2024 15:34:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lXAPrMMHiMa39NI4ue0q6EFXVYemN90SQMb4Ulhq+R2D0PZAcRJadzYjKQYcy41chga9+kUKsUdcBuwfr9EWS25HH5NcvZb7GImh4TyHFjvv9i3p1wYC4Sou1lcMPGbuKP9WALA4rwSBtcmdsELRek1kBdK7h5kZZWaOkLpa76m7fqLohc8cUTl04Z4UDfnP2/JtucFK0rOfSvpqqzMsm76PjoyuxjLIVHHjqeG7V3/AM5UY9rL3mNHrTtqRCtbe3sa4jukZgy6zJR2QxACMc+WCCY4Nc5/qvcWbCwQcW92Lcjo9qANiDvnDfkvx722ZciHbhqcYXwzyuThgXTEl1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QZ1n6PkHjeCAsBVjjQvKGkBxf7VZ61tNVgmjlx4VZZE=;
 b=vlqXuUKoXuuexlMn/h5tHfm/8FMIcSZ1SI6KWzY8XrT3FcBWFDKTtQ1WTmvf8ddg0RqE6QPcOW518QkQ4KbNWj0Vm1fVTfix0bJ1BVOUAQ6ziA6slr0e+tIXVM4NC9ww5vAUgpxonvznpqQFa+WYa+TOlL/qRY+kD/M8O0dbNn+PsDU04mMzha8DyyOQlOd+9ndswe2PtoCWlhW47hwgAP0n52b2sDI1cttldQshNCw5MpPzTm29iJK9GRVPu/iz8lTadTt4JC+OBhVRM2KyhiSqxBDFEg+WcRC7JEnL9VWo+LY5ux9uOGa/GVFgew6tkK1Oaf6gGBRYJoczawDQIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QZ1n6PkHjeCAsBVjjQvKGkBxf7VZ61tNVgmjlx4VZZE=;
 b=Z0kkEcQ8kSN0xKN2CEAAQ1aCLPTQCeuANywDVIlkQQ19KXyJ53higNw944CflqKMFCGRJHVB2vnON+RvbgXCYrSYeXMkc7yvOmonTgqahf54vfy3t2CZ1CppKVHCgV/4+F0kGLZmL5V880D4GI2kmn+wrH2anYcCW5U95T38VgU=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BL3PR10MB6211.namprd10.prod.outlook.com (2603:10b6:208:3bf::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8293.18; Mon, 30 Dec
 2024 15:33:54 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%3]) with mapi id 15.20.8293.000; Mon, 30 Dec 2024
 15:33:54 +0000
Message-ID: <24c6c65e-4e6e-423e-afea-b9f3407be4d5@oracle.com>
Date: Mon, 30 Dec 2024 10:33:53 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: fstests failures with NFSD attribute delegation support
To: Trond Myklebust <trondmy@hammerspace.com>,
        Thomas Haynes <loghyr@hammerspace.com>
Cc: "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
References: <b00b609b-13db-4404-8bdb-4550195362cf@oracle.com>
 <49f7f3ce-bcb3-462a-b1e3-a99ffb85f10b@oracle.com>
 <5056f1a4-cfce-4213-a605-1803c387e555@oracle.com>
 <a2ffc62e7698aa4b40712e11cf766d964a7cc646.camel@hammerspace.com>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <a2ffc62e7698aa4b40712e11cf766d964a7cc646.camel@hammerspace.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH2PR16CA0003.namprd16.prod.outlook.com
 (2603:10b6:610:50::13) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|BL3PR10MB6211:EE_
X-MS-Office365-Filtering-Correlation-Id: 86442b3c-6ba1-46f6-2d83-08dd28e75e93
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZFo2MmR6NkdhYTRNMjF3cC8xRFZjNnlnZUJ4eWRra0dhRHJNa1AwZEtrNjhC?=
 =?utf-8?B?Z1lFMDk3TkIreE1LcmxNY2QyM1ZwbFlCWU1xR0NSeHYwbVZFNkJTek5DM2dO?=
 =?utf-8?B?alMweW9Ib0RKeVNZaTBXL1o0UExGbFpCUGI4TVQ5WW5QaCtPQjFQS2NwMGlj?=
 =?utf-8?B?Y3RYcTlMV3RmYTBUS3pVUEM1LytFQTcxVVBuM0lHZld0RGc5K3lPOXVBMWVt?=
 =?utf-8?B?ZklwVHNpS25BSzI3b3JUYVdkKzZkeGZUU1JwbGRKeGJoMnVSMzlha0pYY0ZJ?=
 =?utf-8?B?K3B3SGlHT3o1VUowNG0weHhmNDluRDlmdGVaQnAzTmIzKzg4OUpxTUhPSXo0?=
 =?utf-8?B?Y3lpRXFYdUpaYU9tQ05HUGFWSktudWdPdzFGZzkvdWdaZHVDdWgyK3h6Tmlq?=
 =?utf-8?B?cUFoUmxyRW0rY2pFaWVNL1VBVUZxNWwwd3d5NzVQTTgzQkpQbkh0cVBMa3dP?=
 =?utf-8?B?RXpKcnhTZVR4ZEV6aHorcGhpMVlSUHdpRVNWekdUUWRGczM2b2Q0NjVObyty?=
 =?utf-8?B?MndEdDFmRTZ4ZWVXb2F3OXVPQ2JWL0hxNnEyOTFWZTNtcDZadTMvamdibmJm?=
 =?utf-8?B?ZkZjd3JrVFpERys3U2dkNWhYaGFsQWtiejkyWUt0VFBXblExOXJZT0N6UzZR?=
 =?utf-8?B?bXVRNTQzV0dBNjVvVjREQzdVZzU4Z25LcXFqT29UOC9pSm54Z2JGRWdZeEx6?=
 =?utf-8?B?OWRmMW5ZaWo3c1ZEUzJiUEZwQ0NGeW1QemwybEpkMzljVnRXRUhUNjVLMFcz?=
 =?utf-8?B?TEo4ekpGc0J2V0w1dUY0SzExOFRQNHRzUFNxZU5nZEJtdFlsNE1qK1hkbUV1?=
 =?utf-8?B?UHZhZllMRzlvRElDNUpqaW94WWljY2xtSEdlN2ZlYTYrSFcrWGtDNEQ3QUdx?=
 =?utf-8?B?anBjdzRNd3F3RlhwTUp0SU8rODcwaDBXUElybkJiSExORzZWaElpLzExTkdm?=
 =?utf-8?B?S3N0STV6U2VrZ0pRc2YyOHFFMStuNkVEdldWYXVjcmN0MmhEWklVcHhKdDFp?=
 =?utf-8?B?RDRuNXV4aWtzVGh3eFhMazg5MkJmWUdBTGpFb2twTzFSWm93QzcvU05QNEho?=
 =?utf-8?B?YTArZWVjKyt6RVc1aENGckppT1BtMyswU2JyZEJyOTBNc0VzYVJLM2tUb1Q1?=
 =?utf-8?B?VS9ER284RVlFWkVYekU5R25lM2tXN2FqMTJzQ0toVkthY2t3MjdCT21TTUJi?=
 =?utf-8?B?ZGFYdXF5SnJHL3U0emFTZFFvUVJTMXBscEFBK3ZGamsxNm9UNkJML0ZpQkVt?=
 =?utf-8?B?bVdkZWtGR3FNTXQzS3Z4ZDF1U1hrNExFQlNmdGovRzE3RGVNZ0U4YTZ6L2pT?=
 =?utf-8?B?Q0NLdW5WV0p5cERKMEM5L2JjcE1ZNE1FeXR4eFFDVy94bUt4c1hpVlpUKzlr?=
 =?utf-8?B?aWo4MG85Skk0RCtLa0dtdmh5WlhWV2pFem1pSjNnL0QwMTBZSTMveWVnbjBq?=
 =?utf-8?B?Yk9KUmxFYXpLWnhySDhOVm5QQjFCNlo2ckphSDFFTTA0Qk1mSDEva2hSbG1u?=
 =?utf-8?B?VjNjWElzazhvYWVRUHZWWTc3eDJ3VklQL1l1Qk5tT29UdG5tK3NsWlQ4R1dC?=
 =?utf-8?B?N0RmRlV3c09jeVp1VkQyZWdqMWppK2c5b3hvU1ZZUndvZ0UveVdVRThoelhl?=
 =?utf-8?B?dUlWa0I4VVJJSEJDa1JkdkthcE5MaXdkS0tVdUk5aFVKZmJjM0VGS081TFRY?=
 =?utf-8?B?S3dDYm5PVTBINVBVSjBka1BmTTF0SDVRV0NFYjFERDlkWFZzWitwcEI4dHhZ?=
 =?utf-8?B?R3UvbnRveUlWK3lHTm1RajZLdVVjdmc3eTRnU0tYbzA2K3p5bllEK2pYT1hR?=
 =?utf-8?B?aitJL1BRdHZoaDd2UHVuYldkdmx2eVpvbWwxdFJZL2Z5S2c5a2grYmVic2ZE?=
 =?utf-8?Q?uxfTM44IiWF/4?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OUpDR1didjJUTWtTdkk3dmFxOENLMCtMUnpZRVRSWjd0TzI2UnhTN3ZpQ1Q4?=
 =?utf-8?B?My90a2x0UlhNSGc3VEVFMFdRS2JtUHNLKzNRWGVWUXBaNVI1M29xc1dLS0No?=
 =?utf-8?B?U3RaQlFNZHIzUE1nTUM0QjV1T3o5T01EWjM0VENndVpPMGxUYkxvUGIwNWZY?=
 =?utf-8?B?YlIxSTVLTTNjc215SlFyZXN6dXVRdnhzTTZwMDllTTlsMzgzM3pyT2tRcVRm?=
 =?utf-8?B?VUlqVzUxTytEYW5NUklaNTBORysvNmNvaXlVSkJ4dytjN0h0MCtBVThoSkFp?=
 =?utf-8?B?QmFNbnFuVWU5dDlHQktJSXFKZzBqWjMxVTc4YzQ2dnlaTEhuZmQreThwd1Js?=
 =?utf-8?B?MjFYYTZJdlpSY1VBVndnL1ZYNFZsQ2cxWnluaFBFL2d5KzhjUmYzTnVEN1Aw?=
 =?utf-8?B?WHN2OEJpNUtvTk9lWDc4ejUzSml6UlE4L2hPQVAvaXRMR1pQa1M1Y3pnQzNB?=
 =?utf-8?B?QkdMNEYwM1JuRzBIUnVrQ0hwODQxbzVtekRicmtDU2x0OWhuQzlENXZlRlNM?=
 =?utf-8?B?WVlrTzJjZU9NdDJPYWVIeVlwL2ZVY28yaUJIZXZMU29MdDNlSWRJZkx6VXgz?=
 =?utf-8?B?WlpMMFl3QmlxbkR2ViswQmZNa0ZYanR0WjdJQlBqZVVJTStKYitTRGxtNVQw?=
 =?utf-8?B?dnF3YlFJVGVMN2ZQSzNQYWl1aUFQOGRNSjJ1ZTNHdWxtMVRUamtBTFpoNGdR?=
 =?utf-8?B?aTU5Y3dBTDFSZ2VGbkcxblJvNXpWYWJwbFRVQ0xKMlEycmNkMTF4SFhwRzVE?=
 =?utf-8?B?R0FUbGt5U28xRElaMjZkejdCK3dPZFo3cVk2QzlmelNpN0poWmNKaEJzR252?=
 =?utf-8?B?bHpnaThyTXp4MG81NjkveXJtNm5ZK1Z2V2RBdEt5ZkgwZFJoYTFPT2NwNERK?=
 =?utf-8?B?QmZUS1RzQVp6eExoRm40eWpFemdsTG94SVZURUovWkJiMXJaZFBPVC9TYTd0?=
 =?utf-8?B?VzdiV1FhUmZYR3JJc3RiaDhWVkxDTysvVnBKR1pCQURwcFl1bXMyclVOVS9N?=
 =?utf-8?B?SzZVMXVCZUQwbGl0RitEckI5Y1AvL2x6aFBvTmFwcmlsZnJyWlkwVXl4eWRO?=
 =?utf-8?B?eHlGNzFqN2JmVmF6OHJCcW9YYXdUWGxtWXFrZkIwNFlOQnZiYkU2S2lwcFNw?=
 =?utf-8?B?Tkd3Y2l2VE9DS0g4bnlFbmVzbS9pNThpbFNDbG5ZWXBKNnBNbUViK3IwNlcv?=
 =?utf-8?B?a1lQUWE4NUR4OGtTMjg4T3JNUFRyaHJ1Q1dhZjg1OXo0clZ3Rm1odFI2YlZr?=
 =?utf-8?B?UHBDSVhpTmdKMkNRN21tL1Z2enBpeUhDS1JZanZ3MEJqYzFSTEVkYXd6T3py?=
 =?utf-8?B?Wko1V3p4THE4T1J4bEdSZTFXcnVDeno0czhwWlBhUlpQQ2FZYkUwTCs1ZW9J?=
 =?utf-8?B?c1NCcEpwVzZKdlU2bU9maVBzT3NkR1ZYUWc5S20rSXBKamd1Y2NMUDFzSmRo?=
 =?utf-8?B?NFhPdTZYeVg3QmxkTWY2S1dBT3BaQVJtT2V6Mjd0UXVDVlAxQkpmbEQrNjNy?=
 =?utf-8?B?a1o2MXVOKzZKUnJtZ0dCTjZjRE5DY0tlVWdxY3Z6cGVGcUhueDZGbmxENVpL?=
 =?utf-8?B?eXY4UEpxVkhzbDk4NFZaZEp6TTU5WW4rbUNNZXVxRG5xZXpKcW1RcGlJSDcr?=
 =?utf-8?B?WGsydWhTb0dveGFyeWdSKzR6ZW9YWmN2UnYrM3k1UHNCT0FkL0l5cnFZakNp?=
 =?utf-8?B?U0ZTMThyUGE0L0hiN2lucGcrd0hHM0ZSRVVkSWwvN1ZMQmcxdE93M1hhNW5m?=
 =?utf-8?B?ZUUxVGN4SjRsdUZ2Q3lGTFBaZmJlNXcwYXNQYzJXbno5TFNGZXViMWVhVzls?=
 =?utf-8?B?YXhqY0srTnE5UEU4eHd0Z2VqVTU1TjIvV0FGVDJUdndWQVhMSWozYmRTVFZM?=
 =?utf-8?B?c1N5elJ5NVYxcmxtbWN0R2U5L3F0c1ZDOFRrQjN5R3U1M1pCc1Bxc2J0bzJH?=
 =?utf-8?B?akZvbEtOcWtsWHlVbnEvU09UZkF2bVpoRDE2Rmd6NHhMdm52QUpJNHpIQnNh?=
 =?utf-8?B?RUVYQ0xRWENRS1ZrUldzTEV1R2c0MXN4SXdhWVFMcDU0UjhLQVRnVk12Vk80?=
 =?utf-8?B?RVFBeTVFdmV0VkxwQkRoTnZEYmZCcDlENkI1Y0kvelFMck4vQ3I0Yks3UzFI?=
 =?utf-8?B?OUI0eXlDcVdvNFZjUHo0dGFpalVJMFAxWWlBSldnUXJRNVA0ZzFBOWlOWDNs?=
 =?utf-8?B?cEE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	tyEYFzwmyDzLZMvIcRYcJeI6+cFC3ylvTL0LeIGXX4oMGtGW5LkwsC/oc7MQj15VD5W3zWvDc8BHzsT17CjqffsaD2klNPmQS77ianC5QntGOM1dTsRZoxaZpEaJRgVCw2q9lNWMT2wjnIj7Osorldj6TL8PICwaQ1KPfIuO+4VUMtCWUooCRuNry1hAO0GIXC9rAB6kT9KUHgUtO2ZDanWtGgmEwDuWtiy+qnbpSAxDFvauKRfkZ6+flAL47/3NgKw1Mkg0473pTJDp/sHM86y3L5clPxR6dD3+aWBneaXWnpB3PaIG4I0xgmeEsLGvy5gfXVbFX/VqBWRFVlOqkmdT3+VrH5xIlTkY9RQ4lPvjMQh1+3vbbcK+0U6I2N5Rz7HaLgV07iMfofODkNP1df6ajagOHLTH8nO0dPWceCw/4fhcy3RZrJ0K8oIz5PPmv1R40lXsdcWuLEyeYZhByydUCQR+O+xrgUhYmqQjkpMM/8bE3rBrSci61tf/A52/6OMQaSg6YeHMNBUQc5wwp59KUjCpKgrJNd2cf7UXnmBPWiwQCSp7+H0Uig+LpzMuNquC5PAiiWZFacWXzuKBMPve/gxCrNm3zOmDrxoQTak=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86442b3c-6ba1-46f6-2d83-08dd28e75e93
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Dec 2024 15:33:54.7209
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +rU/CL1B3BXDPV53keOGbPk1TRP55Vezpm4YTe0Gq15vusaLs5/7Lei4LRF0E5xZslbAddh9QhZmMTD99WKpRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6211
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-30_06,2024-12-24_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 suspectscore=0
 mlxlogscore=900 phishscore=0 spamscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2412300135
X-Proofpoint-GUID: uLtG-RvgrZHaYFZfLAJ5zqmbebhMfSGm
X-Proofpoint-ORIG-GUID: uLtG-RvgrZHaYFZfLAJ5zqmbebhMfSGm

On 12/29/24 8:52 PM, Trond Myklebust wrote:
> On Sun, 2024-12-29 at 17:37 -0500, Chuck Lever wrote:
>> On 12/19/24 3:15 PM, Chuck Lever wrote:
>>> On 12/18/24 4:02 PM, Chuck Lever wrote:
>>>> Hi -
>>>>
>>>> I'm testing the NFSD support for attribute delegation, and seeing
>>>> these
>>>> two new fstests failures: generic/647 and generic/729. Both tests
>>>> emit
>>>> this error message:
>>>>
>>>>     mmap-rw-fault: pread /media/test/mmap-rw-fault.tmp (O_DIRECT):
>>>> 0 !=
>>>> 4096: Bad address
>>>>
>>>> This is 100% reproducible with the new patches applied to the
>>>> server,
>>>> and 100% not reproducible when they are not applied on the
>>>> server.
>>>>
>>>> The failure is due to pread64() (on the client) returning EFAULT.
>>>> On
>>>> the wire, the passing test does:
>>>>
>>>> SETATTR (size = 0)
>>>> WRITE (offset = 4096, len = 4096)
>>>> READ (offset = 0, len = 8192)
>>>> READ (offset = 4096, len = 4096)
>>>> SETATTR (size = 0)
>>>>    [ continues until test passes ]
>>>>
>>>> The failing test does:
>>>>
>>>> SETATTR (size = 0)
>>>> WRITE (offset = 4096, len = 4096)
>>>>    [ the failed pread64 seems to occur here ]
>>>> CLOSE
>>>>
>>>> In other words, in the failing case, the client does not emit
>>>> READs
>>>> to pull in the changed file content.
>>>>
>>>> The test is using O_DIRECT so I function-traced
>>>> nfs_direct_read_schedule_iovec(). In the passing case, this
>>>> function
>>>> generates the usual set of NFS READs on the wire and returns
>>>> successfully.
>>>>
>>>> In the failing case, iov_iter_get_pages_alloc2() invokes
>>>> get_user_pages_fast(), and that appears to fail immediately:
>>>>
>>>>      mmap-rw-fault-623256 [016] 175303.310394:
>>>> funcgraph_entry:
>>>>>         get_user_pages_fast() {
>>>>      mmap-rw-fault-623256 [016] 175303.310395:
>>>> funcgraph_entry:
>>>>>           gup_fast_fallback() {
>>>>      mmap-rw-fault-623256 [016] 175303.310395: funcgraph_entry:
>>>> 0.262
>>>> us   |          __pte_offset_map();
>>>>      mmap-rw-fault-623256 [016] 175303.310395: funcgraph_entry:
>>>> 0.142
>>>> us   |          __rcu_read_unlock();
>>>>      mmap-rw-fault-623256 [016] 175303.310396: funcgraph_entry:
>>>> 7.824
>>>> us   |          __gup_longterm_locked();
>>>>      mmap-rw-fault-623256 [016] 175303.310404: funcgraph_exit:
>>>> 8.967 us
>>>>>          }
>>>>      mmap-rw-fault-623256 [016] 175303.310404: funcgraph_exit:
>>>> 9.224 us
>>>>>        }
>>>>      mmap-rw-fault-623256 [016] 175303.310404:
>>>> funcgraph_entry:
>>>>>         kvfree() {
>>>>
>>>> My guess is the cached inode file size is still zero.
>>>
>>> Confirmed: in the failing case, the read fails because the cached
>>> file size is still zero. In the passing case, the cached file size
>>> is
>>> 8192 before the read.
>>>
>>> During the test, the client truncates the file, then performs an
>>> NFS
>>> WRITE to the server, extending the size of the file. When an
>>> attribute
>>> delegation is in effect, that size extension isn't reflected in the
>>> cached value of i_size -- the client ensures that INVALID_SIZE is
>>> always clear.
>>>
>>> But perhaps the NFS client is relying on the client's VFS to
>>> maintain
>>> i_size...? The NFS client has its own direct I/O implementation, so
>>> perhaps an i_size update is missing there.
>>
>> Because the client never retrieves the file's size from the server
>> during either the passing or failing cases, this appears to be a
>> client
>> bug.
>>
>> The bug is in nfs_writeback_update_inode() -- if mtime is delegated,
>> it
>> skips the file extension check, and the file size cached on the
>> client
>> remains zero after the WRITE completes.
>>
>> The culprit is commit e12912d94137 ("NFSv4: Add support for delegated
>> atime and mtime attributes"). If I remove the hunk that this commit
>> adds to nfs_writeback_update_inode(), both generic/647 and
>> generic/729
>> pass.
>>
>>
> 
> I'm confused... If O_DIRECT is set on open(), then the NFSv4.x (x>0)
> client will set NFS4_SHARE_WANT_NO_DELEG. Furthermore, it should not
> set either NFS4_SHARE_WANT_DELEG_TIMESTAMPS or
> NFS4_SHARE_WANT_OPEN_XOR_DELEGATION.

Examining wire captures...


In the passing test (done with NFSv4.1 to the same server), there is
indeed an OPEN with OPEN4_SHARE_ACCESS_WANT_NO_DELEG followed by the
WRITE to offset 4096 for 4096 bytes. The client returns this OPEN state
ID immediately (via CLOSE).

Then an OPEN that returns both an OPEN state ID and a WRITE delegation.
The client uses the delegation state ID for reading, enabling the test
to pass.


There are three OPENs on the wire during the failing test.

The first two set OPEN4_SHARE_ACCESS_WANT_NO_DELEG. For those, the
server returns an OPEN stateid, delegation type OPEN_DELEGATE_NONE_EXT,
and WND4_NOT_WANTED is set.

The third OPEN appears to request any kind of open. The share_access
field contains the raw value 00300003. The rightmost "3" is SHARE_BOTH.
I assume the leftmost "3" means WANT_DELEG_TIMESTAMPS and OPEN_XOR;
wireshark doesn't currently recognize those bits.

NFSD returns an OPEN_DELEGATE_WRITE_ATTRS_DELEG in response to this
request, with a delegation state ID and no OPEN state ID.

The client uses this delegation state ID for subsequent write
operations. The write completions fail to extend the cached file
size due to the presence of the delegation.


-- 
Chuck Lever

