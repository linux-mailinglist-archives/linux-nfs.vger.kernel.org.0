Return-Path: <linux-nfs+bounces-9120-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35A9DA09C7F
	for <lists+linux-nfs@lfdr.de>; Fri, 10 Jan 2025 21:35:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47D8D3AAEFC
	for <lists+linux-nfs@lfdr.de>; Fri, 10 Jan 2025 20:35:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 162B62135AD;
	Fri, 10 Jan 2025 20:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mr69cqvC";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="DNhmymcb"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4396417F4F2
	for <linux-nfs@vger.kernel.org>; Fri, 10 Jan 2025 20:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736541336; cv=fail; b=Wa2tBneymJqQHB4ScOL21711gQpiI5ue9/h9KOLS6ClGsrzbMdnIiDV3+AEcW1hTQJo11K02HXABPBEsgVe6IXz4NKQBicIHH90i4sRgA7o5HyTcT32tvM/5usCM9lpTAnWND9pxP0ZhcRs1NQpYXCuT+cSHhU1tfU5awMLDaCM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736541336; c=relaxed/simple;
	bh=SjwOgbSE09UNVzECcvE4Gs1M17YOvMEiTJBKKyAcrSo=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ORfpIOd9hIVYoz4BfuIyARowNCDQNNldwoDF5OB/BknsU6o6AEv4IlA1jqShErQTceKulFc/fPXshB2SrNZPvhHqePehytAkTM9GhQpin8qzf+nyfPSHED1vaihjOIYfBIJGb8eEIEonB26rXfflD0pg49wny+uXzrblHgPOCt0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=mr69cqvC; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=DNhmymcb; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50AItmw2030833;
	Fri, 10 Jan 2025 20:35:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=06tIAwa8S545HYONQ2wAbvdj1wnkXIseIdV8sasiKIU=; b=
	mr69cqvCxSrxQQQZUeLPq93R8ltHsrIMaF9iaP7Ze1B8lUzFMUuhzo0YYK0k+eFT
	LHGCVCtXXZ8bgzqVTuMBUPaJi9YqkAZYMvBFIk3n0f9BgnWspMsutUa7VwZpy+Wh
	9KYiGKPJMbWZfX974OWcFMUa5LC42sS7sIrh5b43I8twCHwobS7YWgvSb1iD2K1W
	vunlHdhRqKpw5RrLS+/1SDctujsH6kFbimPvgT/ATqVDE8Rqqk6JvL1+ZUbhMk1e
	k/QWPAoK1JbqTKeoaiUCrNQyDDkzGdU770JRCl4XoNFnnyXwlKxm2QGagm9gf5j2
	LsRNAhM30/xyEaBWR7vVEg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 442kcxa9h6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 10 Jan 2025 20:35:24 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 50AIJtKB011806;
	Fri, 10 Jan 2025 20:35:24 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2046.outbound.protection.outlook.com [104.47.74.46])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 43xuecrad5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 10 Jan 2025 20:35:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YevnR7lFF6sjm3w7JohH5dXTzkhv4bl0hrePSNMLP1rL7mjK4QvXzDlemH34+oct0ZcuVDvBQSbA8gGb42AWNWnzmZxCSaP9Y2MpNPQF8wQb96X8CWx8lEwwtJeLIbWT/IfjV5S+zRhtwslHandvfhYYEJoAEwPT+R1DvD0zbl4cDGeuJEu2ICyc4ogXsJLIn2aRMZE8EZAoanks4gJoX9yrLPgqGU2tTAqwU3ZwAxsV2Y8rEDu0i7iFFIiYT+v0Map6LwxcTRv2URLyXfFyF6yLyXmhKVMYWiqruHWS5E662V9OnlaJHnxO2P2531oh9yn9GzkLCx+0EY26FcEdDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=06tIAwa8S545HYONQ2wAbvdj1wnkXIseIdV8sasiKIU=;
 b=U2VwnGbuAUlVqCkxDDMpIQXD/JJhpe7SKvlPSIjjPCU2X8oFXfXmSuohaCbSSds7YcocWJc120vbyJPv0vb0xh1/ijvpGl0ySR/zMbb+KNHCINvft8Imz0l9Ln+cLxB9PkihaJj+ww9uwT2UovgnhQfyl41arqInNXPsx2X77IY/YWbRQpGG1RW0N51CBm1hg1PGfSR8Wd44ViFvHMynAH17xOhkkd3vlAYksUJxbtoGti/lUPHA3vHott29dtPme0B2j/TbvS1yitUR3eMdpiJCEIRBbe4SLeOsmNTRRIQfo2uF9bf9WeoKaMtgddE9vzbSjO603SCUKguIQ7YbBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=06tIAwa8S545HYONQ2wAbvdj1wnkXIseIdV8sasiKIU=;
 b=DNhmymcbHF2CgdaIUYYfKQwiQX2skxsXBTzz6nZmZBh+XbXXPihi4YpZ0Mx5M0pak8XvVgww8lCYxnjxUzSUfs1NT75OkHjEEXF0w12Ivt923lTm5BFmIDKeluOKah0ykTRELFRx+fxcW9uja7KXIhspriQaQDesbHnJ/pvthZU=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DS7PR10MB5950.namprd10.prod.outlook.com (2603:10b6:8:85::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.10; Fri, 10 Jan
 2025 20:35:22 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%3]) with mapi id 15.20.8335.011; Fri, 10 Jan 2025
 20:35:21 +0000
Message-ID: <463b4513-5c5a-4394-8a93-58c0feef3149@oracle.com>
Date: Fri, 10 Jan 2025 15:35:20 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: Possible memory leak on nfsd
To: Chen Chen via Bugspray Bot <bugbot@kernel.org>, anna@kernel.org,
        linux-nfs@vger.kernel.org, linux-mm@kvack.org, jlayton@kernel.org,
        cel@kernel.org, trondmy@kernel.org
References: <20241127-b219535c0-4d5445e74947@bugzilla.kernel.org>
 <20250110-b219535c15-7cebc629b312@bugzilla.kernel.org>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20250110-b219535c15-7cebc629b312@bugzilla.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH5PR02CA0018.namprd02.prod.outlook.com
 (2603:10b6:610:1ed::20) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|DS7PR10MB5950:EE_
X-MS-Office365-Filtering-Correlation-Id: 112c6040-f0d4-4a78-e00e-08dd31b64de5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dmE3eS82T1lNTHNtYlhqRDZxMDhRMVZBMVpVTHBNcm1ZcStNYVVwaC9RamhF?=
 =?utf-8?B?VGFrSDRRZ2d3T0NWZllvcTBndVBQQnFnM2RRbmdRSFNKcytzQ2R1OUVoWElm?=
 =?utf-8?B?N1ZadStTYU5MQXE1eUZEK3VHYlErZ3Fsd2ZXdzFsQjV0dFd3Z1lDTHVHSG5u?=
 =?utf-8?B?dnBWcVhZbnRvODRoTE5BMUlWNFVxTWdHN3pLWWZIUXMyVUtISksrbnhjV0hZ?=
 =?utf-8?B?NCt3b2tKcVUza2laWlJwUWkzRjZQdVRSTHhpckZsSElzZ1d2YzhoY09mUGl2?=
 =?utf-8?B?b1JpNkZZZ2IzTFRQYVpFKytaMFhOaFROOXFVTk9zRmtQU0hOQzBlN05NNW1h?=
 =?utf-8?B?VVR3K1cydHhMaHVLQnlyQWNUVFNEN0I1c2Z5QmRCTGNkY2YzU3pJWnRaZHgz?=
 =?utf-8?B?bDI1alF3ZUsyYUlNdDlzUEpUUVB6VnZlZ0QrQjhaTitIZHZKRXNjQkZTTkQz?=
 =?utf-8?B?TU9WWTJ4WkpjTVZ6QU1vSktuMGlCb1VBZnhLV0t5dGFzYUFHaWlDVFBYY0Q3?=
 =?utf-8?B?bGVnVDJyVXppM1BhVnNpSzNzQTk1WWgrbDRKMlJBL3pHemN5bHVKM2MzYXZC?=
 =?utf-8?B?NTFyZE83cmVYQWRNVy9HWksrbk5JajZqQk1sQlQramY5c2U3NGxDRVZ1dXdE?=
 =?utf-8?B?SXFET0h3UzZZZTNZL0l0RUdhTHpJZWJqTy9RUTMvR2h4aHczcDMvUG1oaUNx?=
 =?utf-8?B?VFlEUFY5dSt5VWdmUWJnd2ZSc3pRcTBVaUpyYTV3dk04TUhTV3g5MG82VUZY?=
 =?utf-8?B?KzR1Z3MxZWtQSWlaZGZpODU4eHhFOUorWVpMOWFWaFlBYUpoUEwya2d4UEFK?=
 =?utf-8?B?SmtId3FKNXJ4MzN0Y0p6M25kczlGZDNOUVpHeG9ORzQ2NnRwQkZmUG1TeGRK?=
 =?utf-8?B?dDV4aFdXclpTNVlKM1BrRll2TU9GSWhPTWtqUGU1eEJyNHkrc3EyeFNWMFBa?=
 =?utf-8?B?UENFUm12UmhWSDVENVd5OGh4Zml4V00rWjBLYkMrL2E2NzllR1RJRnVLSWl6?=
 =?utf-8?B?NlkyL1l2cy85ME13TDFjcE1NTStPYUtMeFhNWTFxUVV5a0N5ZEREQVQyQTZW?=
 =?utf-8?B?cGRUOTZtZU1URUJ5eFprWG9Ha1E5aEN2aUV4ZVl3OE93MlVmWjNYZjhKN0Jx?=
 =?utf-8?B?NW1QSTZyMlJScGM2NVhxdDJscXFBeEtiS3NFekdSYnhrSEtMUTBiYnBiYXBW?=
 =?utf-8?B?eW1zbm1ZR0wwUENVUDhvRmdMUEVHTWpIcnY5Lys0cWhwYXExTzdtSXZzM05x?=
 =?utf-8?B?dVI2bGdFM1R1UTF3VjJTWEpnQjQ3L0Q0ckxRS1FUNk5jUUhKZTdpRlhoYnVJ?=
 =?utf-8?B?N1lVOXBLSGRtdTYybzFKaUdraURFeGNkTmZSNEFYbkNocXZQbkI3NHVvZFBI?=
 =?utf-8?B?a2dRb3ptWHNOZEdRT3J6aVQvbUwvVGZlT2ltQ0hQbm84ZGU2YlFUU3FKOSts?=
 =?utf-8?B?dW1hQlNRczZiZHk2bU5KY0w4VWttVTQrWFU2YWhJcHZLTVRsWld3MXErYnpM?=
 =?utf-8?B?ZVkzckdWUjRtTDBaRGJpcXZyeHE1N2JmS0FCaUVkY1FlVWkzem55cWNJUDI1?=
 =?utf-8?B?SzFMR0dRWVpiZzR2RUJ0YWN4N0pNWGd4YXgxV1dneStrREJHbE1XSDk2SHFj?=
 =?utf-8?B?N3FkQ1oyajBrbjF0RDF6YU42czNkSERjdWh2WkRzWWt2UlowNkUwL1llcW1H?=
 =?utf-8?B?V0FOWkkyV3FiL3BnOVh5R2MyR25pRUlHNVBaUXpEdG9sWlFwMm5oNnVTLzFq?=
 =?utf-8?B?ZWVQTENpR2ZyS0RPQWhSN29GaDdhL09EaUgrV2xrN1puZkJTY1RPVlhVVVRF?=
 =?utf-8?B?SnlJQkdSeWdsV1VDVldHSG9KdlVLNWZidE1LN3RpNW1EaFA5ZzcvWVQ5OURY?=
 =?utf-8?Q?IYbPdYdlD5spo?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UFpqMTU0QW1ObjVqdHJxc2FQbjZOQUlkakxXMC9vUWdEbDZxd3N3S1J5V1Yr?=
 =?utf-8?B?OTFZY0ttb29GZ0J3bGR6K1EzMkNaK2RzSGltLzNxZ1lEeSttSWhHVHNFRG90?=
 =?utf-8?B?Smg1bWNZRC9hRDVqWjV5aFJoM0doenV2U214dlo5dGpNRXg3WHlITGNYMnBD?=
 =?utf-8?B?YUo0SmlRd1QyNGh6Y2o5MHNxaysrVHJxUlQ2SmhvQ0ZTdU9kc2s0a3JSSkNV?=
 =?utf-8?B?ODRreWEyZzBpd1Q0UDlITHhKWko4Q3RaL2dpMzhsWkN1Wm1sNUpZMWZzeVVX?=
 =?utf-8?B?QnlwSGs4NjM2c0FJQUxXbktsQlBlU2Q5ZWQ0bkgreWlxdWNZSStCd3NacHZL?=
 =?utf-8?B?bS84ZXBncWEwK3hrenVoZm51QU4zUVIwTnNlSlBwODhzL21BQ1Q0b1JUb0Ey?=
 =?utf-8?B?Sm5VTDZEUWVrT0Y1S3crZHVybzBKdG9uVndvVGZsZXVOUmxybElKYnpvUU13?=
 =?utf-8?B?ckhGTEF5cmZOaVFrbm1RZ0pxSldZQjUxeVNFL0tsVnNhcmVFT2dNNForUXZh?=
 =?utf-8?B?S1pjZ1Q4Ri91bmFuYVFSVjB5UWhKWERLM1pNV2JHTGh4WHdWU1hpZlMrbnZ4?=
 =?utf-8?B?T0VPcjNZamg3T3UyeGd2N1BqSTFFTXNoaWw5bnkvRVdaN3Z5SW0ramRVK3Rs?=
 =?utf-8?B?czV4VXVEYTkya2pNWVpud0RtZldYSjhWVTB2ZUM0b3krWWNCbWJOcVhYQW1r?=
 =?utf-8?B?T3I4bWprTUhVYzVRM1FyaHZVMmUxNXhrUTRSWTAwWTZWNUtMSkM5eWxuMDBk?=
 =?utf-8?B?K0JjTzdPdkZhcHZObU1xRlRpZDlSVHV5MFF3dHZQSitxMWNyci9qUC9EWlk0?=
 =?utf-8?B?ZGxEd1pWbi9oa3hnQjI0eWlReWFqVGNtY0ExNEhhM3J4ZDhqbjY1dkFKRzk5?=
 =?utf-8?B?enBVendiTkxMekZRZ3Z3RFFIWVhYRExTdGc1RXRVREtpL1pKRDF6ZzVEUHZ5?=
 =?utf-8?B?YUpha0w5RGVSZFZLSFZNbTJFYWhSS1FzRHh0emhEQWpYc0JFUTJTYlE1WG5F?=
 =?utf-8?B?OWxMSmVuaVRZdy8wVnRkZ28yWnhIb2ptQlAvOXdaOS8wcTJhbGRPWHQ0R0Jr?=
 =?utf-8?B?UEx0SnN3ZUw0SUNKa2tHbzJzQmpRQWhNSTlJdWY3WmkyMkkrM3BOaFk3QTJ2?=
 =?utf-8?B?Y1dCY1c3eURMb2VHakRqMk9ZdHo4ZEtzRmhqR0ZqSkFyVFYyWVNSRjA0VzBv?=
 =?utf-8?B?V2l0OVpMd3MvdUFpL2x5Z0FMNlllK2pHekMyc2h3TExUSHRRb2Z6SGU1d1dQ?=
 =?utf-8?B?M0hRdmlRR2U2WEhKdSt4MUQ5djF1WUlMcjM5d0hjMk9pRUpNTHpBV3UvMG9s?=
 =?utf-8?B?NHQwdFVSNGNVZ245UHh0Vk1LbmNFVDF3bWFSSVRQaEhuVE5QYWdxZVpDQUZT?=
 =?utf-8?B?bUZWeUZNZzFsemFoSllLd0tMT05zcGY2T0pOL3NTYW5sUStNeEV5TS9KMHhr?=
 =?utf-8?B?dmFITXo0ek9Fc3ZNa1loZGZ0ZFZ6c3V1ZVdkVytwbXZxSjZiY0dtMkFwRDNU?=
 =?utf-8?B?UC92N05meFRoeUFaczNOcmNkUFFWQzNPVXdCWkJxaVpacy9IZWJCMkdTY3Iy?=
 =?utf-8?B?SHRRTkxYbnBmMUxRbXNkUkk1UnI0MG1jaFlHZkR4RXlPL0NuU3BlQWF6N1Uz?=
 =?utf-8?B?dlZJQ1BVRnRjaWo0dEgyVGxOcDBZbCsySUtGRnI4dVZHZzBBcGFWeVpja3Y5?=
 =?utf-8?B?WCs0OVZMRDI0dXVaUzBXQmNBSG9aR0p4MFkrM0R0SkJjSjFCeHZVcWw2bDA4?=
 =?utf-8?B?blZWT2Y2cU1IdzJQM1pXNnB5MDdTOGh6S2dSTFRqUEFROTg1U0t2WWFnOEhK?=
 =?utf-8?B?ZTdhbis3SlNNYVpzTjdUZmczSEtOcHFSZ0NQRW5wWm1JcGIvOUhuZU5VbUZD?=
 =?utf-8?B?ZEFLQjFZaStjNmk1eFBTN3RITkdsQUY0QWNLMzF2TFViZkdUQmtYc0Z4OXBq?=
 =?utf-8?B?bGVsUWVCWEFoNmszWHpyWHdSdDlqc24xYlV2OXZFdlpWVTh2NWpRVHBOSFox?=
 =?utf-8?B?TjgvMXlxR25YQlE1dHZ5cGJyTkFic1FoVTFWM0htK2E0aGZEczdySFc1S2R1?=
 =?utf-8?B?dG5yUDdWc2VuUm9MRXNOK2doNjYzNXV5azF1RitLK3EvRWFWcjNBV3poazg4?=
 =?utf-8?B?L0o5ZExBV0J6S1BabS9ITjlqMWd5eHhDK0JjRmtrN0xSWXhEK0QwMElyZCt5?=
 =?utf-8?B?UEE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	DClNzWtf4OJDyh+kYFLjGbSz96cRB7pYaK2cVSAMcIY9Sqvn3bCAgYMvN6ic9ISdz7oXNKcJV9gZP4b+QlwqfJsXs4AcheBftA+9X6k2prpyB4ejUEKUYC5QbjfbjLGbSeWObe3PaA/Qg8X3SN5hxyP3hPpGA0OS/YdnHjazKRe80DVtPIjTpmZLQt2hOuNk9AxCylzJNvZjnCEDRn0Kfg+TaKgH/Yx2m2VF3T1/+mESN4dn6Mo9pAQ+Rsppi6g3/KfGoMXmUGtTyqIK66C7DVnYYGN1fuFWdUvoA3em3pTtcdxAImY2zPWyNE6HvA2D/OcNf+TmjkjZdU2gV3fosSOv8tIzGwvbsbx5W5FkA+pgTPYRtl32yyQ6u4JOwdoAFJ5zZzua9qAi5AdGDvQcWSZHHt9BtbGYlIKV/PWACcd42JiR5rVN9JeloN1kePJ06ajRMmrMenAw45vTa5JAkfL6j5AcWf2gNQxZD5KufKoPxVwUkuscU/KoiXzSOYYpzdmAlm62O7bf7eUt6YZGp4AY+4j+k2WN1K+3OBK4zVS3tJw7s/EfFGstsEAi2eHb78Ccq2J/Uykdy3EArQUqMT5/H9aKjxJeB/6g2HV8bYA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 112c6040-f0d4-4a78-e00e-08dd31b64de5
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2025 20:35:21.8436
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iS3pxBwiVVoOprVXBn3SYLrdz90ENYCKV/25hFVN+4IcWWjE/AT6tnVYqEiSXa1GQcaMK8wZ4ZDY6snik6FcBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5950
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-10_09,2025-01-10_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 adultscore=0 mlxlogscore=983 suspectscore=0 mlxscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2411120000 definitions=main-2501100158
X-Proofpoint-ORIG-GUID: LZJ8aD8aCNMCBRtpAC2Xtl2dpsHTFk_f
X-Proofpoint-GUID: LZJ8aD8aCNMCBRtpAC2Xtl2dpsHTFk_f

On 1/10/25 11:50 AM, Chen Chen via Bugspray Bot wrote:
> Chen Chen writes via Kernel.org Bugzilla:
> 
> Sorry for my rudeness in my previous discussion.
> 
> After switching to 6.12.4, the server stayed stable for 30 days.

That's good news!


> So whatever caused the memleak should have been resolved between 6.1.119 to 6.12.

That's tens of thousands of commits over two years. Unfortunately that
doesn't really tell us what the problem is.


> You might want to close this bug if backport is not worthwhile.

We need to know the exact commit that contains the fix before it can
be determined whether a backport is feasible.

Are you able to bisect between v6.1 and v6.12 ? If not, do you have
a simple, narrow reproducer that we can use to explore this ourselves?


-- 
Chuck Lever

