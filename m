Return-Path: <linux-nfs+bounces-8936-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 91792A02EFB
	for <lists+linux-nfs@lfdr.de>; Mon,  6 Jan 2025 18:30:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 184353A3CC3
	for <lists+linux-nfs@lfdr.de>; Mon,  6 Jan 2025 17:30:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C57C11DE8B8;
	Mon,  6 Jan 2025 17:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HJDaUW45";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="FDvJD8Dv"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 545CD1DE8A3
	for <linux-nfs@vger.kernel.org>; Mon,  6 Jan 2025 17:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736184650; cv=fail; b=ZW3PRiNfsgcqv5s5hZfRaeAPSxEx7/6Z0PNgaElhjFXUu1JFFVVwpFPY21XcIWLBd7XQ7mqzXWpPbUBxrjEcKbbbfbWht3CKMyPFj6/Utjp68PMvVSb9RYjXS2Ooefu+NsYNrr2S6SIf910x5PsMw5srz99R43ldwJsIqGZwFmQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736184650; c=relaxed/simple;
	bh=zczol/wB7vMWyAMLI+wP2rEyI3v1WncYqc7/8hei/vI=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cK+n5iVBhw4EUJojie6LVY1ymRFGkqjC9bCliPY0zSDI/eB+Rc0beamJU1b/rUNPcBQaeclbv6npK5ecAARkvFU6g/x67wgovZGaE3DyHVAxL3X24liVK3eI2rEER9dxsGQCJ+mvQKTDJDFV8GT7cC2/NyppZKxJlGVGl8Ub0MA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=HJDaUW45; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=FDvJD8Dv; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 506HC0tr020750;
	Mon, 6 Jan 2025 17:30:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=zczol/wB7vMWyAMLI+wP2rEyI3v1WncYqc7/8hei/vI=; b=
	HJDaUW45sdiF8Bemr02PuqjTCLlgz20rtD2T4YzUOCR5hdyQSkXYomHNEXbdYbz5
	YIzIARz9MGIom2PzuSIpfUosiy2pFekL2pNcWKgFf04KY3xoXF80JFSrYkGjfwjE
	WoDKU6SvpfXEnJLMizEBEfMhGy1Fy58shp06ZJuVybJaUcFv0XP0a7Si1YF2bbMw
	pSz1h7KBC4Ltl9A60ThVlzY5P/LHJvV09YEHF0dhbJzcN1jre/KCpIOPQ+jJoZ+C
	7EfG8f262u4L4AoDCHHnl1pCGsNR5UtGpyztIBN3qqxJeaQ8fzuzi6/sOjexVGVC
	1vkTlu9xbvw4tSvKimiEJg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43xuwb3232-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 06 Jan 2025 17:30:46 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 506HSJI7022542;
	Mon, 6 Jan 2025 17:30:45 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2042.outbound.protection.outlook.com [104.47.51.42])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 43xue7h43n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 06 Jan 2025 17:30:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qLf1TbiN5pYDE7OKE4l8NG7XSseu7k6ODQQpivduGeh3cbqdI1Ek5gdnZ9JUN/BDsG4Sqk08Jlmqa7F+1q9NJsdT3hUoIVZukHBCo4hdQ0ELq8+qWk0dT49Btyo2qB1HlPqw5sP/TEHMmbzlNwNT0Sq4UnCSx27OavkvZNfBUZiNAR3qg5olqLXG8UpTP/lLT1F18dTTC89ItI/iVZDJYF/9A9ikOJDaWEjZo/F3iNk9gnkMwNEpwnEW8p9FuHAhaUjMGoPNHn53kbaekdB2RiNF9xzw6Xo+p63B+JUYfA7JsoQrEwTVRLWC6bM96g6zQpO7CKm2ULeOejL31cXxDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zczol/wB7vMWyAMLI+wP2rEyI3v1WncYqc7/8hei/vI=;
 b=HdFna8CtxffyXMJzb1KKP5nzk4C0b6EKxUOLxF1iIJ3tUzujzJ4oWv9Udwgv7vUJXd6a+I6xu9bWH25ZRxEhr9peJ+mVeudgSLrRdc7C2SORdXHDGrXQ+ZYqFzkKjVmS/eVirkZGIojFke/oQoEp2nrDFVzIrmcE3AusT2BP2qfUi/3HEl9Lx+1MbRO+O7pX/9BKt0dS07y5M9m+AGj2f0gG4xJVl+G6SYgr9gljDWXa9UrpaqFHbUYqDSuP8cHoyjHhFh8baFORACErZACLFfNt6jJg1guIp7F7+9GUvGplMJzBh48PG5XdKOO1cnH1onpEMcJiA6E18pSPCfpeug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zczol/wB7vMWyAMLI+wP2rEyI3v1WncYqc7/8hei/vI=;
 b=FDvJD8DvfH5vVoquBr0k7HM6EcoroVWzc2vee5HfkRXJHE4jLh7dz9oAml/i34N1CdG8GFlEG7qGooTa4AAxlpju9F6ovNagquMObi3oAL7AgZWRfoq4lIrRrT0baeIBhtHXOtPD5eBVJwCwzNey2BSw931+cZfLenimhZjSNCA=
Received: from MW6PR10MB7639.namprd10.prod.outlook.com (2603:10b6:303:244::14)
 by LV3PR10MB7916.namprd10.prod.outlook.com (2603:10b6:408:218::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.17; Mon, 6 Jan
 2025 17:30:39 +0000
Received: from MW6PR10MB7639.namprd10.prod.outlook.com
 ([fe80::69ee:3509:9565:9cd6]) by MW6PR10MB7639.namprd10.prod.outlook.com
 ([fe80::69ee:3509:9565:9cd6%5]) with mapi id 15.20.8314.015; Mon, 6 Jan 2025
 17:30:39 +0000
Message-ID: <948ffb91-caa5-4244-b0fd-19f460ebd7a6@oracle.com>
Date: Mon, 6 Jan 2025 09:30:37 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: cp(1) using NFS4.2 CLONE?
To: Cedric Blancher <cedric.blancher@gmail.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
References: <CALXu0UcAfYN4z9Wmr0SA6DRUt7RmasN2qq9wSZTt50yBs4hP9A@mail.gmail.com>
Content-Language: en-US
From: Dai Ngo <dai.ngo@oracle.com>
In-Reply-To: <CALXu0UcAfYN4z9Wmr0SA6DRUt7RmasN2qq9wSZTt50yBs4hP9A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0063.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::8) To MW6PR10MB7639.namprd10.prod.outlook.com
 (2603:10b6:303:244::14)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR10MB7639:EE_|LV3PR10MB7916:EE_
X-MS-Office365-Filtering-Correlation-Id: 26e08a64-2763-4094-7ef4-08dd2e77d694
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bzYxREJhWjM1SENoaytLNlZDVk53Y3BzYjRTZ2hGT2NoSEM0cEZOOWlTYmN5?=
 =?utf-8?B?SE1ZWG5heXZvZFgvL3VWK1BEWDVjT2FpRXVRN2dQVlp6Y0Z4UmFsQncvT1lu?=
 =?utf-8?B?N0RqdWhJNFh6MFV3Y0J4WnZtQ3VWR3ZoeGFKTkFCM1JwUmo3RFNKTXZnaEQv?=
 =?utf-8?B?bE03RENXWnRaTlI0Rk52SEcyRHlRd3g2SzNzdzJpMWFWaExUQ282ZWd0d201?=
 =?utf-8?B?ZWtKcGg0TWY2UTVzN0Y0R3dKR1ltNU51M3ByOWh2NFp6OExRY3Z6YXczdlR1?=
 =?utf-8?B?RTFheDFVcDlWNVVoZXBpNkhEZGp1Vjd0QklaM09TKzFYUnd1M2ZNYVBSdXZV?=
 =?utf-8?B?QVZpRkgwcTdIZUJEcXdhc0ltcy9yQXNrbUpwcGFVVGpqbUV2dHRJQjB1eDc5?=
 =?utf-8?B?TmZScFBGaHV2ejVvSHdTbUZNVkNLKzVITWQrc1plSC9Hdkg0cDdGc1hEUngy?=
 =?utf-8?B?Q0trb0NYNHBHWWt3SEdYcW92eGFTdmRMM0d2b1YreVhLanlxbGFjcjNKVkt2?=
 =?utf-8?B?enpxL0Z4YmI0OWZkYXRSRE1YcExWNVRRTng4MEg1YkhWcEw5ZUk1MVZ0OXZE?=
 =?utf-8?B?aHk3Y3JNYm1mM0Nqc05VQWY1RTNpZERLWGY4bHFwWEtxMFEvZnhmOXNaeWRx?=
 =?utf-8?B?SWs1eXVKSTY1K0NENTFLS2wxT2dHSkhDeGp3N0RPY2U2SGdYVnhVb25qeW11?=
 =?utf-8?B?Y2grUnd5dFY4UUFJd1p3SUQzWlZYNzN1a3VrZTZQMXZRVDFYbERpWmpGU29k?=
 =?utf-8?B?aFNPd25xZXlFQUdlMUwvVzVHZU5tUGVBY2sxamtES2RvUUtqRXAxRlhxRHZk?=
 =?utf-8?B?bms1aDBEQXlsQzFDNHg2MzQzZzZPN1dEdUNJMGpVQlNQaGYwRUtVbDhNTHNC?=
 =?utf-8?B?emFqS296N1M1SDFNeE9VWWJuelhXMjdCZGFVNm84WkNkSWNiZlR2eThLTDVj?=
 =?utf-8?B?cFByV1NENXJmQWh6aGxmM29pWm9OcUw2ekhjclRzdzdCY2NmWFZrZUlOYjQy?=
 =?utf-8?B?T1RDSHkvM0E4ejRFT0lndXk5eG56N3pIT2lYeVh2alBKdDd0b2JiUVFDVW03?=
 =?utf-8?B?WTRQbFJJSHpnZWh3R3Juci9sYkRwTFpWQTN4VXUzNEhOL0hFODhMSE5KQmR4?=
 =?utf-8?B?WGx1Y0VaSkxRWUtrVk9XeHVDMklEWjkyTiswcGFhcGtFUWowNm9iOHBlYkww?=
 =?utf-8?B?VTcxMUxsczFqblV3TjhsNkx5MGx2WUQ2UVJaY0NqZmlGVUhTdjJDeWhDQzlr?=
 =?utf-8?B?REZTRWt6STFiZ01oblp1eWhRa1hJWmhmVjB1WGJJTGpNNXFuNTVaZG4vdTMw?=
 =?utf-8?B?dmZuQTJ1QlFjQU83V0FUTm1vZm45eWtXNkh4WFcrdndQb3hoWFJTVloxNFFw?=
 =?utf-8?B?Z3JzQTZueWNpOVgvTDZDbldDTHdHUllTVEVxWmNRTFRrZWdESFd6Z0xBdHFN?=
 =?utf-8?B?LzN0Qll3OFMxSjduYW15OHZaK1BGY3lEeHpQVmw1clR3QkYyK2JZMWZFSUFt?=
 =?utf-8?B?NnhmMXpWdWIyMjM3a1crTklyOHBUdGhNT0xpMVp2Mjh0eTBiaW1OL0Z0dG5R?=
 =?utf-8?B?WUxidWg4TUozN0U4UWxtbW1jaFZ5NzNSd1BFaWlBQ3VHUGhlbmpNdjJnOFVt?=
 =?utf-8?B?bkp4YXBkQllnQ01GYVQ1SzBEM2xSa1V4Q0RoSXBQanlkMUdINnpVaXc5TndC?=
 =?utf-8?B?UEtySm8rZ0pPdGRwbVBwZmVVdXYyL2hyWkNTb1pKYlp1ZDROMzFhTkErRHN6?=
 =?utf-8?B?MGpiSGtBNWdqalM5TFNuS0Z5RjNBNjZUZlBWb3MyeGlrZkVMQ3h5TElzcmVR?=
 =?utf-8?B?TWZsVlVCeFYzNmExQjc0U1d0eFFtOGI5V2JncXc1Q2dhMDZtVWhwTTFPa28z?=
 =?utf-8?Q?q4b4WpJFZwWBL?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW6PR10MB7639.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Ty9hb3NRbE1nSEo4WFhmOEsyejRQc29sYjZMUFZBblU5MWF0UlR1emZBRHYw?=
 =?utf-8?B?QzBBb1h1aXBiQzFJdVZXMUdxNHhzY29QK013OFNVVTBNN2tDUEZ0dThDWU1t?=
 =?utf-8?B?aEZ4eWJaSHQvMFl0ZlEwVkdqLzdTbGk3dmpjNEl3blFkWFEwWWx0UFZoMktD?=
 =?utf-8?B?T1haZFp4UWJxZjFpQTNiaFVhU3hscUw2YjRUUHYvSUs2ODQrS0huTXArSVNT?=
 =?utf-8?B?VGcycnh4NkN3NXczVzBSLy9ETUdhajdDQVVYWHZUTW5wU0dLdStiSHFBNkFx?=
 =?utf-8?B?cG5hRG54Vk1LL3VjTE5uRmxQNkplbURJVWwvS2owZ0I4ZTM5ODhNV3pJd3Ry?=
 =?utf-8?B?OUtHUTJ0aUxZc2svaVZXNFhKWVk3L2ZUQjM4ZHdUVmxEYVZ5aEZ0NWxFTU0w?=
 =?utf-8?B?dlEwL1ZpcHIwK2VSanlvcWVqRlpKZ25EU29OS2o5Q2hEYk9PTWFVcU53VlRU?=
 =?utf-8?B?dFVBcERYcmtDbktwT1M3enh4Q1ZCK2ZyZVlJdWk4cUZ5cWVyZmZGbDNPZVFx?=
 =?utf-8?B?UnVEVU45RTdwSWl5S2R6RFdsYmJMQVA5SWVzSlQvb1NtVVl1YkVGV2JIN1Ax?=
 =?utf-8?B?ZWRzWXU0ZTlWdkpDclc3RnE4VTZxbWNzNUVYdXRHZjNTaDRiN2ljUkVBdi9F?=
 =?utf-8?B?TUNydE03bldFL0pSOWRwdForUytPZDJJTXVoOVQ3bFdPVWh2V2FGdEJub3Iv?=
 =?utf-8?B?VDVJY25uTzNiL0traTJ1QlJXRHRRbXJMSFJGRUE4VHN0ZW5lTDJjWGk5anov?=
 =?utf-8?B?VHJ2eFhQVHJIVmE2cDZ4dmNYZjJieWJaazJQKzgzYnphQWFOUysrL3MyZGJ6?=
 =?utf-8?B?a0R4MFZWTDFMZTlzajBQblJLTGxlVXVRdkJZWEJCdXkwZnNVTENSUGVaQjc2?=
 =?utf-8?B?NCsxN0FKNnJDSGVreWI0WDJScDFYMHVxL2l1bDk0dlczS2ZwOFd4MUdFUkY2?=
 =?utf-8?B?VUdQc1l6TGliZzBUWDB1VTNpazlhb2RwZXUrZHBjM3JhK2kxL3FHVk1oSVkw?=
 =?utf-8?B?MTZ1UnZUSGZuTVBNSElrQTZjUFRGZ0lSeE5VZWZIaCs0T2o1RDMwaXQ0VWY4?=
 =?utf-8?B?ZEdwY2NSdGppamJSRU9YdjBxUzFNWFM0bGZLNFZnelRiRCswSlBncjZZTjZE?=
 =?utf-8?B?L1cweTFvNE1TSmtiRWgxNmN1MTU0eWJib28xN1NobkpXcnkrcjRuRURSdjBl?=
 =?utf-8?B?bWxVbDIwWHMzbm1nZ0F2QUZwWGl2T0FvaTVXYURCQm15ZTRrUi9DUGkzaWVa?=
 =?utf-8?B?ZTRSZnF4d081Q3lUVCs0ZEs3dGVFY0U3ZDIzUW5tLzJDdlc1MWlIMkFhVHJR?=
 =?utf-8?B?blZ3VHdmVFZYVlNVbzNlWlJwWlpOM1NwQkNpWXFLWEJaaHRXbDYrZkFGUys4?=
 =?utf-8?B?UnYzeDZDVXpFelhid1JZOGNGdDdISFNNSk1YU1g0OGpaSEhYVVg4MUp4ZU10?=
 =?utf-8?B?R1BHd3hyTXQ1V1ZaS0JSZ1M4QXd3ZTFJSktDaUZua2ZPMC9IVklYTm9WTUdD?=
 =?utf-8?B?L3VicXN1c1dKaUt2OFQ3SWFnbGVzUjA0eFdUU0ZLM3ZuenNWM0pMWFpiZUVH?=
 =?utf-8?B?THhzcTJrYkM4amppNWVCclhIWnpTaklubkdONlFkU2RxeStRNVVwM0ZhakxZ?=
 =?utf-8?B?VFhnZzhjbDF5UHVUSHZCRVd0SldSVUVSUjFEemRXbGRaQVVCWiswbDVFOVhJ?=
 =?utf-8?B?R1VTOS9aN2FpUThqcXRENkl4ZitTQ0tEOTRQekwwS3N6bllVaElLcjZsRERj?=
 =?utf-8?B?Snp1S2tYOGx5SXYwUEhzRnlIdXB1dDhtNmE3S3FYRU5STFB3eURuZGo5N0xM?=
 =?utf-8?B?VWs1cFZTUlQ2NW5sWFdOL1RQckxRbHYzWkRmdTRRQWFEN0h5Uzd3VFRzTWNZ?=
 =?utf-8?B?dWVyd3ljRjc5VnhlbHhOazg4RTFwazFCcU1JeEVJUldCbXVBcEZ4bkUwY1Ru?=
 =?utf-8?B?TTU4aE1WN0RmTnRTWFFGOFpacllyYWdsd25mVU93dk9kRWtpQ2UyVG9EVTlH?=
 =?utf-8?B?YXRkaGkyYkRqRXNYdWJoME54WnU2MndyN0o0aTNZeUNsZGFpcWtMd3FOZ2R3?=
 =?utf-8?B?QjBOb3hOTWJpMzVreTkra3Z1d0pLcGF0MXpNczRTdFd6eTNDNzQvbFF3a3J4?=
 =?utf-8?B?c2c3Z1lESENUWHRCNTJubDE4Um5UMFd6N1RxMlV5ZlBtbHQ1WUhteEV1RFJl?=
 =?utf-8?B?QlE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	A7Bc47urLmRih+3I04hpVS+WmeOhmtpwM7Bq3YE2QfuhMJbaWhrkDKFTJVuWCEoUu9Sr7aaAwyX6kHOdlRo5MPjUIC69NlLiKvTdCUsDJab0jd0iCWcmQ7/w0+4hIZdz1ndftTRMESqbQIBK4GWC4e8WLX2Ss03Rbn7otPT89aNK9zA9CYlS4UQJqtwVh1lcQqfwFi+x3G2h/8Fhs2d5umV6nROYYOew5MpwMCA/F1tNXR29gevgkJ6eGnfSpY+/v1TUfYBE1LQ0bmNgJmf2mc4eh8R9Jgv48FlHQ45afbzPGro6/n0AN9ilkL6TWsI3ziSigMfS0pdgnnNZf1LUAYbD5uhUwKt7sPApO/OHN75k2nP22y0w3dDbxhlxizhy3gqX7iqTMSNjhRLx9ZK6B/FkPoreNDPtpyxDxbPpSVZ7m1qK1XO2pOUb1MlkBrgrBUZLaPrw0k0hD3sdbjIFkYzkawT7l4Y4djPF6VJwvgBCWrT+lIAbEk4Ga0oiBDnAZQlOPSuTpdhAeXMNwNSatsYR8XGYbEs2Uz4EhNP/iwj6Wf9k1oCeecEn9K8o3nH9UAUUtz7kKGp5crIQJBZ/Vpm8Zi4M1WInipe++Berbtk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26e08a64-2763-4094-7ef4-08dd2e77d694
X-MS-Exchange-CrossTenant-AuthSource: MW6PR10MB7639.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2025 17:30:39.4476
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XX5tg4DBVaIRDUs0kg2ARLrxdCKe+G5iN4NGs57ZCx/j6LyHBj8iWMwXGPbk4FD/XetDGRptnRMsB+w7rAlGzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB7916
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-02_03,2025-01-06_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 bulkscore=0
 malwarescore=0 mlxscore=0 adultscore=0 mlxlogscore=880 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501060154
X-Proofpoint-GUID: Q-LJuWkMHLh8TbkvvwZxhlSnOJMdK1Y_
X-Proofpoint-ORIG-GUID: Q-LJuWkMHLh8TbkvvwZxhlSnOJMdK1Y_


On 1/4/25 10:44 PM, Cedric Blancher wrote:
> Good morning!
>
> Can standard Linux cp(1) use NFS4.2 CLONE?

yes, use option '--reflink=auto'

-Dai

>
> Ced

