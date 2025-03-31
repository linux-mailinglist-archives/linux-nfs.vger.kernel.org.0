Return-Path: <linux-nfs+bounces-10963-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BD87A766E8
	for <lists+linux-nfs@lfdr.de>; Mon, 31 Mar 2025 15:32:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60608188B5ED
	for <lists+linux-nfs@lfdr.de>; Mon, 31 Mar 2025 13:32:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B2781E47B0;
	Mon, 31 Mar 2025 13:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hMVvz0sJ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="hW7Mw806"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D6F11DA62E
	for <linux-nfs@vger.kernel.org>; Mon, 31 Mar 2025 13:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743427950; cv=fail; b=MjUBfqUvWsXueTF0xQ3Hb4mydrKlK3+N3qgcKFlmC5SdsWP0eIn+nbpATKyNmlUa6oWU/EfZcPau3zPon3qBpP8U0mzNgJqqUVeQkAYQUb2pAEirlkOmLIhY3Sz6NvyDwyg6WpXjJaataHyJCxp6H0zTvA/qmKRw+1t7e+SeZ8Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743427950; c=relaxed/simple;
	bh=9P7RdavWSClVgZjHEy1tlGsW9g/o0UfnouwNdAPWbbw=;
	h=Message-ID:Date:Subject:To:References:From:Cc:In-Reply-To:
	 Content-Type:MIME-Version; b=DoX90rPEXocizTnnDQ0dD/LZ5hb+43Hvhw6JR2U0ZWTiV3WTKRui+RRrJw5mcbUaJ3bzA+DWIWU7uGjghD5SArWUwWSYMlJRZZZlNsydQiqbnRHGjgtYt9jckMblUrxlcWbXO2hC2w7Go98tz/gLFH/hnkuNaxiaXf0PEA5DGQU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=hMVvz0sJ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=hW7Mw806; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52VBu3FD007499;
	Mon, 31 Mar 2025 13:32:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=yBl6pjAxScG8uSysAT+ShXmIWuZl8ODQgw1V1xceMpA=; b=
	hMVvz0sJqhyLoOV+MRpC6aIEtVKrA9pIjm0LGzhgAHHg4TtEMh+cYD1uMfMtTwPX
	GRbmWGhWt3c9C9ZXf9Q6BZx1KNI5oLipeLXPsYnhcD6UBl7Ifpsy9s0Wwfey/h4T
	+ubw7f5EvKMK4ptsGyeli0mCzzqChR/qrqcBIl+BgyJ9B0uHp4CvwUqMR1BWSU8L
	4XUz/cszfUUycUcZaRpnMbvyU7f/eC5xcN2/KUU1i4EWKtfoBl5I1DsPHKcGNGro
	UmjWk9+frCgVXNRXR3e/yblsk5RzR5ywrprledmjWh80ug4DeboLeWZDVlGY7dgi
	LM4gaoEArWSi4Nxp7+J/PQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45p8r9b59a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 31 Mar 2025 13:32:26 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52VBnKrt033568;
	Mon, 31 Mar 2025 13:32:26 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2042.outbound.protection.outlook.com [104.47.51.42])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 45p7a7wf65-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 31 Mar 2025 13:32:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wn07dsN5AcIWJuNtjNv2mlpvOF+ABDnQUNAc2we5Uy3WvY29bNFWkLGkG2XEIrzMfNpazgQ7g3G80OWVj1UUYHKYK1mH1L0USE6N57Gh0E7csPUJF0LPJltcwgHKIPWgmjeYlejtqoA/0MPPL2vA8gue6vZ0tgxfAxoH0fov7vgFa1YYr87bvZkjrOA3/8W4mAdx74uPnaY+o4tgix8yA0pYhHYqI173qnqu6REhoGtFM/S6+gU2PY4r4Xor8ONvxxV4oFOT/5TKahdVRL3/O3e1ez/SqMdDR1PWNs5uV6rqD/o8Q9D2kudLoUF+rh8QuQLHMXmoQkNrf3MRRFgpmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yBl6pjAxScG8uSysAT+ShXmIWuZl8ODQgw1V1xceMpA=;
 b=vC9ZSQeL6NKJibDM9bKwpy0iBIFUOWoGbyrIFPGTlFuu13ZZ6NjcLjX+0l1o++xFwsHNRHXk91jIVPm4Wd5YX/uhV1vDLwxEjBhQB61nFpg2Y+FccUTSPjYIIJlF14aaJ98JOTth08VOvQMzpQM6GfGMQgTDkJUvzfH+QSZU8burduwI8f5twInXerZkpaDWrZRS27yCREPrrzNJwVfUm1KVDA6kAOrTu5QsBGryFQ356K9eGn57Ho0FLGBPGALJ8UqUF5CMgkcdqZpHfWtKjVc2I1lOpLZMIIjb0GeoqMyImjqKrDDWe57vSWm4tmAnNThq9TX9RsTOLhClKb/VIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yBl6pjAxScG8uSysAT+ShXmIWuZl8ODQgw1V1xceMpA=;
 b=hW7Mw806DyBfbexNpUuyDKdgP9ozlzmSm4UM+ZB1FVaSTCnBD5eS15Ub8saHZAGHHIyUfrmm0jy6It01Gi8MlyfLaT9zOL6kNhyNgvrhsFJUuiFAMOXwAfIWoDLyi0MRwqfu7HUfTperNQnHq2pCJ7GkCSmN7qytsVJUHO17xgo=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by LV8PR10MB7966.namprd10.prod.outlook.com (2603:10b6:408:202::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.38; Mon, 31 Mar
 2025 13:32:23 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%5]) with mapi id 15.20.8583.038; Mon, 31 Mar 2025
 13:32:23 +0000
Message-ID: <6c9ae5d5-aad4-47bb-8322-6ad628bd76d6@oracle.com>
Date: Mon, 31 Mar 2025 09:32:29 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: kernel.org CI NFSv4.1 RDMA testing / test coverage?
To: Lionel Cons <lionelcons1972@gmail.com>
References: <CAPJSo4WFWkrv8u6FSEy0JWZ7nR-KAA1YeRkce8dFbXARSGdrEw@mail.gmail.com>
 <06f68f5b-a9e1-4fb9-acf0-43c11b14efd9@oracle.com>
 <CAPJSo4Vn1WP__ihcxaDATn_z7EFdr1hPD54nZErY08_KO5sziQ@mail.gmail.com>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
Cc: linux-nfs <linux-nfs@vger.kernel.org>
In-Reply-To: <CAPJSo4Vn1WP__ihcxaDATn_z7EFdr1hPD54nZErY08_KO5sziQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH5PR04CA0020.namprd04.prod.outlook.com
 (2603:10b6:610:1f4::21) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|LV8PR10MB7966:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b7caba2-d410-4720-bb1b-08dd7058787d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TjFPa3FLMm9OSzB4VXVTdmV4TXRKaE85Um5kM09reDdmQzFJSFpXUGdoWDR0?=
 =?utf-8?B?dkxvTmIyY0s0Wjc4MGQzTHhUNmxmNCtnTEZ0VitnR3l2cXgwVWI2akt0NTBv?=
 =?utf-8?B?Nmw1V1lQRVZNNnpwSEtYcThkY2lJR3MrZDJHcE1FZzkrRkdBYmplV2tudlJu?=
 =?utf-8?B?RUU5UXVrY0NWRmk4WUhEK2RnbWt5OXFueFhRTjBJZ1dvbUtMZ3luR1d2eHhX?=
 =?utf-8?B?eGZuQWlGNkdnOXUyM0RFeWpqSGdTMXArYmdvczZaODRBNmFRdFRQM29SYXRv?=
 =?utf-8?B?R3l1WXkwYnByL1ZqbWFrUDBpZXlrRHI2QWdacGRVRTVqdmg0b2lBQ2lLTHdo?=
 =?utf-8?B?Y0x0OUoxNzc0YXRKREFLaWhYalRBcEZNTWdTdWc1d0tFc29sZklRSXNVSVpB?=
 =?utf-8?B?RTYrY2hYVmpab09XRll2Q2UvRHozNXk4WCtOQmdBNGUxVGxwMXlVdWVCTG5y?=
 =?utf-8?B?blg2OVVRN1B4MGdUZ1NVRjNkM0RZOW9DelRDeW80cFFYcFVQaDhMcE0wdFJI?=
 =?utf-8?B?N2w1bnJRUkhtODJoUEhpVUxjVnI5RHMybU9IRHlLQzBlMzZVOWpMNHRabk9Z?=
 =?utf-8?B?a0ZvV3FxMmYxWmxLQ2h5TG9MWTVxb1c4VHRIcWwycmRhVWxJaXZac28yc2M0?=
 =?utf-8?B?U2QzQ3kyOTF4UVBkZkVmMFRHOWM3VVNxaDFKb2txZi8vWGM4bE5lNVRoaGlr?=
 =?utf-8?B?L1Ivb1A5bDl0TWlMRXJLcTdLdFFuczNZOUhjT3JqN3NNVEZCdnRUeURDME1R?=
 =?utf-8?B?bXNaVHZwOE1kVDQycnBBYmxXZnJ5SHI1TkhpeUpjM3RTeEZBSlZYTEJXRHVk?=
 =?utf-8?B?N2FubXJCZkduelpkZ0RoUlVFZk1FRkIwaXVWQnZYVGZEZHpCY2RqMEJuUVBm?=
 =?utf-8?B?bXdPWDFZK0pvdEEvS0FoRit0allVSmVrZFh6M0I0QXJ0aml4MVEwRkR4R015?=
 =?utf-8?B?Y3BTWTIxYTBaeXdmVmptRzZaTlNMYmJVQ1ZhcFAwNmczU0VxSTY3Z00ySThN?=
 =?utf-8?B?dFp4aUtYUXIyc2xCTVl3aE5USThQRk1pZndITVZpcUR1VDNYaGUxSTdlZGly?=
 =?utf-8?B?UGxlbzNnc085eCtnbE5RUW1FUStXWktvOHBxYUhhcTBOUEtkMENha0dFcUlJ?=
 =?utf-8?B?VXk4UTZmcGxNNlJDbDFwWTkwMjZFMjBDR2h0WGE5MVhqUG1kL3JQUS83VjRW?=
 =?utf-8?B?aTZwdjlJNlNLRExKQzZpdENBcGVWcUlscFNobDB0ZXozTnE0TWw3V240NStX?=
 =?utf-8?B?K3piSG9rMndUa2tHOXVPaUZxVUR4cm8vdjJJRC84UDFCWWw1M09XNURTYkFj?=
 =?utf-8?B?emUrOHo1QlJSaHhWZlZXWHpOUHlQSFBwdDdEdnNHMmpmbU5OUHE3RVdKYXh2?=
 =?utf-8?B?Z2RvdkhtQWtBYUtja1pmUlQ0VU9jNEJjMFFUSnZ5UHVKd0IwR1Q4aUdMcUZz?=
 =?utf-8?B?ZzRscVRIVk51aFpSamJoUlA5UVdKOE0wcnByb2JzVzNNbHBVQXFsNEFZMmM3?=
 =?utf-8?B?eG5vcUtUZGJEdDV2ODRJdktMWVczRUI4Z2liOVY0UmpGVU50TmhCNUltam1Z?=
 =?utf-8?B?cHBpSUFXczFVUkwzWDJyeTl2MTF3bGNuSkxsb1kwRTBnNjNacVZUWjlSeVAv?=
 =?utf-8?B?Ty9OckRDRFIwckNoU1VzWWExbnZURnByNTlBVU1hSmVFc3VRK3J5UzdmMFJi?=
 =?utf-8?B?ZGUxVlNRSVY3SnRJMkxORGplczk5SVFxd0NUM01iZyt1MG50NGkvUFNNeTNp?=
 =?utf-8?B?Y0dyb29ONzFzeEM1eTJjMWNHYkFwcnNFNm9nbjdTSDFvMnlrREVQblhHSHRN?=
 =?utf-8?B?bEZ1djQ1NWtuOFhRUlJmemVBK09QdThnQU56Q2ZpM0lnOTQ5TTJaeW9sbTRa?=
 =?utf-8?B?UUVWZUhYSlZZRm84cCswRXlnbU9XejlTbi9TRnVKMytJa3FSaW16TmlEV05o?=
 =?utf-8?Q?bTyBRsu0ZHc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bjRCaUllcVcrSDJCOUxrU2hNM2ZtVVg1T2F6RXlVTHVGNkltd1ZlYy8vbldW?=
 =?utf-8?B?SFd5RHdqQXM3SldFUXZjVkdMVFo4RHBjQ3I5eU16VnJGNnlwNUlkaGVkK29o?=
 =?utf-8?B?ZXJIa0g3WTRWTk5oVmJ3Mmw0enE0d2hvTzBHNkszSHlRR2lxQkJFemRBb2tD?=
 =?utf-8?B?Um9MMVdabmFuYVBCUlp6dFErWWhEL29ZTnZ3WEY2b3hwOWVHb2VPb0NQSXBl?=
 =?utf-8?B?anVkclZZWmpnRGowRXE4TmJFMy83a3dDdGZ3RW9MQWRYek5UNkJIVTNhVGFH?=
 =?utf-8?B?QUxsTm10WlFLMEFyaHE0WXpkeUxHR0JZMG9Md3JzM0FkY29HZlpSN0t5a20z?=
 =?utf-8?B?TzZGRGpKV3dyOFkrekhLbjZsNDdtZzA1a2dYOFRyeDdwa0tZd1djT3M5Kzk2?=
 =?utf-8?B?aFYvSERXUmJwbVRpWURTSVI2M2dsN29kWGFUOXhpeCtadmc5S0RqbDlaeGxE?=
 =?utf-8?B?dFdzem9odllHYXByTWxGNU9IUnFId2tWUmpKNTdHZzYycTFaaU5FRkcyT3NO?=
 =?utf-8?B?c0VDZjZVSXJ1OWdEYk1kWmoyZXlIRmpNc0dOVTZNY3JEK09TOTNzV2plcmFi?=
 =?utf-8?B?OG5EV3pyYy9sWmtjTVYrMjhiSURVZFBXVThOSGV6eDJJUVRQSERqWTNuTWlC?=
 =?utf-8?B?NFFRUHZsL01zRWhMTHpJSW91UmpIWFFlV0VWS01WSzJscXNuRTV3ejQ0MjR6?=
 =?utf-8?B?enY5b2ZFVzRJUUJOTVdIVGVub3VaQUZZcUVsM1RpOS85ZlBVb3hxckdUckN2?=
 =?utf-8?B?aHhxSWpFSDBzVUVpSzFBTXFWOEtNMVBad0dvNWtBb3lnWXMwY08wL1duRnRR?=
 =?utf-8?B?RTRPVURSVlBuMUhkOFh6WG9IUkR5MGJnRU9hdlFvakxmeVpoTTVGWmpKNTBm?=
 =?utf-8?B?WkoyeGhRNkkrVWJDeG9LTnV1OVZRekpvVVpnOTdPZGpXWC9Va0Vva3pBRWpZ?=
 =?utf-8?B?TjdGYTJxL2E1UTdDRlQ0L3lHV1ZYT0hkN0czZTdEWGtodzFlYlUwblRISCtU?=
 =?utf-8?B?MjVWaXRHUWRxSGlRUWZnclUydzRMT24xdGt5Q21nK0oyMVU1SEJXK1B3RUI1?=
 =?utf-8?B?M1dDbjc4M1prMHBOUGQxa29WMDZRWEFFdE1NSm1iZ0Zxd0FuakVJTmxWOUhv?=
 =?utf-8?B?MENjZThxd2JvRWxwSWcwRm9INGh1ajcyM1M1K2VmRHhlWS9nU29QM1BCRXVK?=
 =?utf-8?B?UW9uaHpZWXRvWGFIWlU0TFBNK2lZRzdJTzlUYnE5K2ZaWXd0MXdlRHhOUTA2?=
 =?utf-8?B?QlZHRG52bGtUSUJRR0F6MmZXbW53bHdUbFVmd2tHVE1rSzZKRGY3UkhqZG13?=
 =?utf-8?B?a2lxTm5BcU1kRStUbFZyY0FFLy96eFpOMTB2RnNTWjFSVlVOdlp5SGRHcjJN?=
 =?utf-8?B?YlRJa0ZnY2RjZ1BHNnR0c0R3aWd5dXNSeE9uR2V2YmFCejZDM3o5UTFXeUtT?=
 =?utf-8?B?YzRFOU82K1lidE02TTQxMVlmRU12Rm5wSGtMOXVIVGxyUFd1a29mQUVhN1RE?=
 =?utf-8?B?ZHlhYW5mZUZ5SDRpVTU2VjgvY1RWV05jTUE4N0dpNXNSRUFqQkJaM2J6ckZJ?=
 =?utf-8?B?OXMzbDZTQkc4ZS93ay9FclBZdGl3SnlUMG5HcS95SDJkTjNrdG1wUzFZazB3?=
 =?utf-8?B?UHdscjJlQTlmcUJPMzJtRXRmeWlvU1BmQ0dGK1M1Zld6V21QVzJsZ05Nc0k0?=
 =?utf-8?B?N2lwZGs1RjlLa2oxNmZGMllhdWFERmdIYitmUnovTDJNcEN2eUY3MGcyaFBG?=
 =?utf-8?B?QmNQOFlQNkg5azlxaTZ0MlhSOHgzMDkvV1AwSVhaWkRWMmpTT1pnajVJaWVY?=
 =?utf-8?B?MU90VElQUEF5SWtNczZZODZwMUZwSWN2eW5sak9SR1BoUHZ4Z3ZWWkhLU0Qr?=
 =?utf-8?B?a0oyWE9TbEhSM3R3eGdmT3J6dUpySk5SbDg2TFdVQnhPekp3K0JoNGh4Yy9y?=
 =?utf-8?B?VUxUR3R3U1NHTTFLamVpYjZ2a3ZBSzVWZ2xxQ09YV0JqVkxxNkMzSzBFNWxy?=
 =?utf-8?B?OGhGNlZFTGQvV0lsOTBtU0g2blZKRUFvcVBuY3FYWmpyeUNpNHlaZ0xRQ3py?=
 =?utf-8?B?TjhQbVRCUmZsaXdveTlxckZuTHBmZlUwaTBIQ1czRGVTQ1ZZeGJYa3daQjAx?=
 =?utf-8?Q?FSt/SMsm4MAIqaXgc8WE0Bl4a?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	jWiou80lJijI8jOh1bZQE3xJHMzChs0AWmIpztNkhTiNf9XiS6hSr78dDm1is5yjeAdbiPQozXGg1IUitrjCu/V0troI8HPG2WzvVkvlqH201OZ6obQ+WJV/zerDo++ottRDd6+VGMISkFseXfCN2xsq9CTD/j7Sda3/dCZKbkhQLD43zjPVaRkfVcLL4ItRxuXS3OSiK0iXmoF7tZwCyPVXDRWhT19KisS8UNTUcmfH3HLD8L0RusLVBih2Hz6WRzzcDGrJN7sCnw7gzTonYmbWUsO9G3m1jARQuwkNRKUUPNGWj+UjmuXSitsOMkex7LUxEyPuBA0fOaz2I5HZwIRrH2X6bXqF7m5Enw1AoC2+StzQOC8sOEOAWY+um7/FYVz1aRlGF4YoeZl9QKMuba3Iuo4x4erbaOAs/GkfemQ2B5vIdK6jk1Fy26fwBdhug2H0w1atIJb5ckFTsWnbaxosF6iGuCWsku4zlIrhydvJQwSHzxDttsQ7FW6L++87OmGjKFIshUYKy8qMLJfsUW4bCGP6dGV/GlyWHTxWqbYgeRJcKnj0oWqN/4Icj1By35hDrf0jcpwaDWIID+Xk7Wbop9NqoaJLB+htfFewXAE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b7caba2-d410-4720-bb1b-08dd7058787d
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2025 13:32:23.8624
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ubV5YGvgm6k7vyHdNTAHJToi5ZXaLUyFSel00JYhQq8yuVjWNTMNHgi/g46Whn3GjxUqPwNC3NaQkS1T+ur2Vw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR10MB7966
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-31_05,2025-03-27_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 suspectscore=0 mlxscore=0 malwarescore=0 spamscore=0 bulkscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502280000 definitions=main-2503310096
X-Proofpoint-GUID: BbzlHjTIsO-dNy8eK7reD4TlToRpLnOl
X-Proofpoint-ORIG-GUID: BbzlHjTIsO-dNy8eK7reD4TlToRpLnOl

On 3/31/25 9:05 AM, Lionel Cons wrote:
> On Tue, 25 Mar 2025 at 20:13, Chuck Lever <chuck.lever@oracle.com> wrote:
>>
>> On 3/25/25 2:50 PM, Lionel Cons wrote:
>>> Does kernel.org have a bot (syzbot?) doing NFSv4.1 RDMA testing as part of CI?
>>>
>>> My feeling is that the current NFSv4.1 RDMA support is under-tested,
>>> and needs better test coverage.
>>
>> I run tests nightly. What makes you think there are testing gaps?
> 
> Because we're stuck with a Linux 5.x kernel, and so far every
> quick&dirty attempt to jump to Linux 6.6 LTS or 6.12 LTS resulted in a
> half or non-functional RDMA or pNFS.

I encourage you to report the details of the issues. There is nothing we
can do about bugs or testing gaps if we don't know there is a problem.

As I said, my nightly QA runs include NFS/RDMA on v4.1 with siw on
virtio net, and I run these tests on LTS 6.6, 6.12, and 6.13 in addition
to pre-release upstream kernels. (I also test the other LTS kernels, but
not with NFS/RDMA).

My lab is based on ConnectX-5 IB and RoCE cards where I do my primary
development work, on NFS/RDMA mounts.

I know Red Hat has NFS/RDMA testing, but perhaps other distributions do
not. Not sure.


-- 
Chuck Lever

