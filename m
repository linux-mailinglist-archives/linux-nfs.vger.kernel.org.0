Return-Path: <linux-nfs+bounces-7829-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F1FC99C2FB7
	for <lists+linux-nfs@lfdr.de>; Sat,  9 Nov 2024 23:05:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4FADAB2120B
	for <lists+linux-nfs@lfdr.de>; Sat,  9 Nov 2024 22:05:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3393E145B24;
	Sat,  9 Nov 2024 22:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="aQKLerW5";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="hFb3AkYz"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6FF92BB09
	for <linux-nfs@vger.kernel.org>; Sat,  9 Nov 2024 22:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731189938; cv=fail; b=AT3ZoJ+1erXYYhubRKLTNdF1y6XP4cMwSn0JBruSlzgNmivUontLQ6/ygLpZwTjxDI3LuURBXoausS2B870O1vLp/D6E9rKBN7Z2jqjyAVDYI2fpd82EYV2SM7+x3eiEG91oPbP5Xf4iOazW8zAGqZhrpX42ZsHJ4EbrwTMvm9Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731189938; c=relaxed/simple;
	bh=mW8BK9vPVkBDVP8Qn4Dgeh9+mUh9zcPGw2sLhPgsdL0=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=oYYlut/z1IAQ1KpSgjWT/ixGAWq4UigO6+gf0RJNBDL+iWL84SMUKeBlIRokFWs2GZ2kLdiIa9XwMUh3gw/VlL4WKhhaR2EnYS5TFch8D8E0Jw3Wusz5S4q/51TiuW5D5Bn0eFsYSzt+pHk3Umk75jWYea2M6/k7i3O6BvqveQk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=aQKLerW5; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=hFb3AkYz; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A9LEmSg007369;
	Sat, 9 Nov 2024 22:05:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=5nuLLEhhwLvyoruMGJOtbvwOxbcplGdgOMxfZ2xdgPk=; b=
	aQKLerW5crA9P6WVKU0RwJI/utwIW/LFMgh2zlKqX5an/BALInetxsary0d/MV6N
	mNcLiJe0L+0IIEYke0HITEjrIXm08TmyEPDOn1c4nZXx7kS0cU6BOYi+QzXqlFqG
	UmlTko881PRcl1h+TaITBcoTG4Nn1v5wT2KtoZkjLdCLDh6BjPTFyRjtI3DKJv4c
	WCga97ObYjcce2ayvkSRZ8TncTGCHsVNKYnW7j9BwOV0VESscJ2s64aiCOisVZHU
	/qW+G5dGCqqRD2OA/KYbKkKeSQaRwvzPwelOTk63vev2/zQFTDW8JIc9c4y1D5bZ
	ZLfzY2y5LbnrV7xLQAsCcQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42t0n4rhpn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 09 Nov 2024 22:05:32 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4A9KFdTm037186;
	Sat, 9 Nov 2024 22:05:31 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2044.outbound.protection.outlook.com [104.47.55.44])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42sx65sfqm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 09 Nov 2024 22:05:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eyyOV5mAXvF2QZMlk+MKKXLKGI+yY9wdUTQWkulHaZwsTLvlYNti3Lzyj6dEYtrv4wc8/mzUhKFUzK4xQG7G7Le0wtVwleQT9xctFHx2a5eHhBs3hSxP0HwzlRRkZDSdSYJUj91eDYjrGypbkWm+1Os9UJGH788LFrIxQmv4nMteCbopwwt5Dhv1p2wWLdSG+w8gvvdfLN1PB9HRkW5TZMM+oyFVHmHz2/mX0ov0yI1TULpDiv6pMdSxXL8kwMKzPtgPwcnxrm5SbCOnk1v12BibWGHCL8cJ/dz3xbHmMXymjQ8f+WgN9IbCFPjcjI+lBQvzr2geoUzw/yGfNJ+nbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5nuLLEhhwLvyoruMGJOtbvwOxbcplGdgOMxfZ2xdgPk=;
 b=yLT6y3Zrk2DTZnq2ohPXUW34VI+96O6HB4xF21chtE+xj1b83WEH/GIdzQo+DqVbLBBmDCFt0nHCS5IejzIVVcEuUvmVHU0M6dvVix0oG6I+AHljXUPuEp72jU5EuI6AtmGPKmKiHES2s+BpI9viwk56+eezaeiQHkg169V4shXTU5p2myiKtj4fRFfwE6ybws/5HyLTT/jYxU3jTvcaGi3gHYhPT2DGAuZ6sBhvmxJCs39mYQFgw6TOykGkGIB7WUv4cJw78DlL/hMtdzEAgzvjyCpGhlCkOVzIn2lpP57LVn1qgsi81QaEh3BKX5KCdnZ8iz5mL0n4ju535m3m0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5nuLLEhhwLvyoruMGJOtbvwOxbcplGdgOMxfZ2xdgPk=;
 b=hFb3AkYzILEpt3pfVsvU7DzRrE0pYca/71Q/Yj8bV2j8V72scioKIh/oULb1kTYyMwTvUMtO5VtuLTWKUoZRdTXdclkZwSBxEsP/CeAVIMhI+DIVA9g85MvX6fZKmcHciyINHdYc4IyCfj9U3ia85vxYw+lAZPfM00flVLwl0DY=
Received: from MW6PR10MB7639.namprd10.prod.outlook.com (2603:10b6:303:244::14)
 by CY5PR10MB5913.namprd10.prod.outlook.com (2603:10b6:930:2f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.26; Sat, 9 Nov
 2024 22:05:29 +0000
Received: from MW6PR10MB7639.namprd10.prod.outlook.com
 ([fe80::69ee:3509:9565:9cd6]) by MW6PR10MB7639.namprd10.prod.outlook.com
 ([fe80::69ee:3509:9565:9cd6%6]) with mapi id 15.20.8137.021; Sat, 9 Nov 2024
 22:05:29 +0000
Message-ID: <ce035dc6-0fe5-46f1-a0bb-aff0f0f9d98d@oracle.com>
Date: Sat, 9 Nov 2024 14:05:25 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: extremely long cl_tasks list
To: Trond Myklebust <trondmy@hammerspace.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
References: <7536acf7-da4d-45c9-8e29-f72300bfd098@oracle.com>
 <c278cba3f388eafa578f82dfddb219ddbdd8c01b.camel@hammerspace.com>
 <cb3c663f10633368a7026de64fd147cc06d4d86f.camel@hammerspace.com>
Content-Language: en-US
From: Dai Ngo <dai.ngo@oracle.com>
In-Reply-To: <cb3c663f10633368a7026de64fd147cc06d4d86f.camel@hammerspace.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL0PR01CA0036.prod.exchangelabs.com (2603:10b6:208:71::49)
 To MW6PR10MB7639.namprd10.prod.outlook.com (2603:10b6:303:244::14)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR10MB7639:EE_|CY5PR10MB5913:EE_
X-MS-Office365-Filtering-Correlation-Id: b2f666a1-d5fb-406b-ea62-08dd010a9f36
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?N21nd01GV3dQOWRsa3JYOXNISXFVaHlHeDdYVjlndEZtam1wZ1FIOERlSk15?=
 =?utf-8?B?ZW1CSTBXcXhjdXhWWHVkeUROQ1J4YnA3dWs4UFRrdG9BRzBwSzNpYlc5SzFC?=
 =?utf-8?B?L1pRT2hvRXZnWjBFSWxBQWNyK1pSTlZNcC9kVlFFYmw3VlVaWmFLdElDd1Jo?=
 =?utf-8?B?YmFxcUZkUGNWUm5GbjVNUXNkdGh2eGVhM1VnZmpOandDNGcwUURQRWJVd1k5?=
 =?utf-8?B?N3pkTHZMcHlkQWdyZDFuUHkwNjJ1NGl6YjM5U09wN3Q0dEZDSnhCRitrczhK?=
 =?utf-8?B?MlU2ZTZ1WDlaMHZIMWc3c3JuYy9vdkV1dmZaVUk4OUY5SFVESDJOMitDTlhl?=
 =?utf-8?B?UGFDVkZ5SnRLcjZNWDZ4a0xEZlpYZ1FyZVRwUXZFUExoQWRjL0FFU0JpN0Ji?=
 =?utf-8?B?aW85M1hyVmJFcHRpRjRPaExBK0Roa0VzV1RrcFI4aDI0WEtIU0w0TjkvNmxN?=
 =?utf-8?B?MnRhNUlBTCtSWUhOTTZ5YlVrb3VBS2xTdXYxUmlteWQ3MjFkR0F2ZWlyQ2VE?=
 =?utf-8?B?VEJHdzRqbzZOZURJSmY0YW83ejE3ZnVBUk5CcE4vRDRnREtTTHlITFZiOGZP?=
 =?utf-8?B?cVdKdHVXOXVBOHFOSUo1blp2L3ZlZlk0U05OYzZlZjA4V2p5dEFYaEx1S0Vt?=
 =?utf-8?B?dG5kME9hU3VlOG83bkh5NkJ1aEZ5akNZWDZaS1FteGIraHFJeXVZOHVwYmVF?=
 =?utf-8?B?VkJ2SGtwcWQyNGpqdGhYMDk3QllHSTZKS2tEVnJ3RDdqVEEvUVB5WmFjT0M0?=
 =?utf-8?B?Z1lhKzVkTk13RnVIbGF6YXB5eXc3c005L2dRdDZpbnRBY2RKYzgvZTRjaHVE?=
 =?utf-8?B?OHZuOUhwRjZIeFRpTHdYUUpNTmd6ZXV3NFJETlpFSXFaQ2RVZEd4YTZmeE1a?=
 =?utf-8?B?Ym5VRGlTM2RZRThncW83alhwOHI4dGlsWTdaNGNDcEkrRU95WFJPOXpMYUdM?=
 =?utf-8?B?TnZJVnVtMzc4UHRtbjdTRnhGN1htNTJGQURJbzN2ODF3N2d3TUxsRUp1Y1Mv?=
 =?utf-8?B?Sm82dnhOam91UGJTWGc4ZFo4dlFIK0EzWjlTVDdrNnlKOFlCQW4wM0lPWTdO?=
 =?utf-8?B?TGZTd08xb1FyOFc5ajU0YmRQaW4wV2V1YlRIWWtYQXZEV0N4djBjMkdlQzBh?=
 =?utf-8?B?aTZKQVBBb3RkaFU0M3kzYzlaaFdWMkp0UkN1cGJ5MjZ0cEc5SmdOV0FJMGl5?=
 =?utf-8?B?NEtsVWJkbjhzUUFHVTUwWSs0eEhQMjk0VHRnd0tkaHUvclEwOGRUVDk1TS9C?=
 =?utf-8?B?WXp3RTBudk85WEt0WlM5ZkJ3TkcxZjNkU0g2TlN3UmRmVUdFQWo4MzNPdEtW?=
 =?utf-8?B?L2RFb0Y5MWxnMXYwaUVVUVlzRG93dWJlYTM3aTc0aG8xaXpveVVjd1FrcDhj?=
 =?utf-8?B?Z1dnTnFVaklCdVlCREF6U1RpSTZpMmVaRkJody9vZmFkM01YaCtZMzg5akh2?=
 =?utf-8?B?OXpwUTl3eU55Y3pRNmcwNmNsZTM0Mzdlc0ZNU09HU0pMUzkzUGhJSzg3SmNn?=
 =?utf-8?B?QVJYRkVld3Ftdnl3Qm9EZWczcUJUMXZrMXMyN0dKY0tQaUZhQmM5WVROeHhx?=
 =?utf-8?B?NFpkbm1qMEYwNE53aWk0enpkYTNvZ1EvNmw1a1hoQ3JIanFqREhzck1rbEIz?=
 =?utf-8?B?ZjViSXd2T1dGRDM1S0FTK1MvdytQajIrTTc5cENsNkc4ZE1vVTBacjU1MkVm?=
 =?utf-8?B?ajdWUTVWdEp3aXJwam5pZTVqSXR4aWNXZGNsZmttZzNDRmN1bmk0NUpSRGFQ?=
 =?utf-8?Q?5tk7E/3MSBSJ/7GE08TByjkLlVHkYZatObkRu74?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW6PR10MB7639.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UXpGWGF3eCtuV3dERTFGU01Pazh1SFFkQmhyV3BnSGhyMUJaOXNWWklCai9S?=
 =?utf-8?B?dHMxZWVJb3Zhc2hPZ24xcE45T0pBY3I3Ty85SWNmNTJIV2pyMThEaVJ6SDlv?=
 =?utf-8?B?UnF5RnhPVVYxZFRpbjh6b3VObitKMU85L2swYXNLdmlnbEZtNFcyT0IrL0g3?=
 =?utf-8?B?YkM0MGdxV3ZoTDIzai9QQ1Exa3VqWVpMeWJGU0ZGT1RjZ0ttM2NWSmRXb0hn?=
 =?utf-8?B?VGd6bHY0TFpzbGtyektmWjhWN3JDazd3eDNLazlTOFIyM3lCMDBCSGxJMWIv?=
 =?utf-8?B?NkUrVFMxZm1KMVFXYldaRkVLTTZudUhxV0lMQ3lYSlY5TzJjdm5QaER0ak53?=
 =?utf-8?B?M25qMGJGUituUE44RXE1UGhkcWxvbk1LRTNEQmkyQjA0WDNzaUtsY20wNHBR?=
 =?utf-8?B?N0QwWllZSVRwLytJbk00RlN1TmNCek5TbHdHMmVQVVpwbEFSS2lBa1R4MTlv?=
 =?utf-8?B?RUQyWG9CbUpWTkI1Q1ZiYS9wYStwbXhDeHRzelcrMXY0Tkk5dVRPMlFhNVlm?=
 =?utf-8?B?cUVmUEhlazNtRmdsRSttZzhCbWZ4WHRJZXdVOHJDN1FjL2YxbVl4ZHRxVDJE?=
 =?utf-8?B?M2R1cmVpY1JOQmdxMmZYKzFKTXFEd2s1MUJ4ZjVBNzR3WjFWR0p4NjZENk1k?=
 =?utf-8?B?TTJiUkplN2lLbXUwSFFVTTZNVUMwOExkL0hvelJMc0lxSno5SGdWZUhMQ0Uv?=
 =?utf-8?B?ckdrV00xVTRoK2VZODRid0M0azVWWDY2bHJaUmpDcVVoQWsyeTJPdHdiOTZz?=
 =?utf-8?B?N2U5VEt6Z0oxQ25uL1kxSHFqSEFIS2s5WlBPaWF6VUplQzJWMzU1TVRlejBS?=
 =?utf-8?B?TysrbjdNaTk5ZTJLSnIyZm1zR25OMU5wbGtKelY5MExyOHJJbVQ2ekpmckM2?=
 =?utf-8?B?YkFXeGcrMmNydGxsYW4wRUVlVHJiU3F5WnFEaFhxa05pbHNsTGRiOVBYMTNl?=
 =?utf-8?B?NnZCcFdlemtKZUtQcVdQNEp6bTNtcldaWTR3KzR4djluQmhnSGVOMFFEb1BU?=
 =?utf-8?B?a2taQ3hDa1hqRjFWOWc3Y1Q3TkNWUlBKQjBNWTR3TFNyakFPODd6MlZNSzF0?=
 =?utf-8?B?QTZ5WVE2TzM5L0UyNEdSWDBURDNqeEpiWFFzYkp1RmlPSW1sTm1zUG5jaHU5?=
 =?utf-8?B?RzJSNHdaNEVkZWp3ajJiSmRyRDByMFBvWk51c0hlOFdqSUZqT2ViWnRrcFFC?=
 =?utf-8?B?UUFKY3JDUkVlanR5TUZqNTdiZm5id1dRU0xEcnZyVm9KazZlR0tGdDZNa3Rh?=
 =?utf-8?B?TS9aNXA0K0NndWx1MmJDVXMyVjU3MWVzK2JGa1RLQm1jZE1nRU9FU0svcDQx?=
 =?utf-8?B?VXNqUm1nZUtrRjg1RXY3Y2NFUkhVdTRqZG9EUnBjQ0hWb25GaUJraGNHYnlt?=
 =?utf-8?B?bE1GKzdiRVFpQWJnRVhaeVdEMGVnL2pHajRzQXBYTTFWb3FLSTZ3SmFjd2J4?=
 =?utf-8?B?dWZ2Z05hcVZHOEdGeitSVEVBajBmWHhaYkh2c05zT1E0K3dwN0FLYW8yd2tz?=
 =?utf-8?B?cDc5dTFQa3EzZGdiRkdDbkhTL3ZMbFZvblpTRzFtYm03NmI4b2hTbmI4VE5z?=
 =?utf-8?B?OXpmaG4vZUUzSnY1SEVuMlpNc3ByMkZuWjhLNDhwN3M3a2lTTVREalJNOHI4?=
 =?utf-8?B?aFp6TzNkcUtJdzg1eklLNkRCT210a0R5amdsLytCdzJVTzVqK05sMU5LT1Yz?=
 =?utf-8?B?UHE1Yk56NU1mMFdoLzUwenBva3YvZEdJSFZONjg3YVEvbW1aaWQrWkJLdXNO?=
 =?utf-8?B?MDdFUWpCdmJiRkw2bmV2WU02eGJHZ0taaGp4TVVScjVsWEY0V1EwSTFDMWRo?=
 =?utf-8?B?RjJKcVMyNXFJdFd5UnpOU1YzOWxiMkVML3ErYS9HSlhrdTVpRC9tM1E3SHdo?=
 =?utf-8?B?OXVvMUVzUC95YUo4THBnaXlCZzJPVGdUL0UyZURaTks5SUtabHY3cEI2dU5q?=
 =?utf-8?B?bHUwakYzbHQ1OWQ1NlE1TjVFeG9yU0lmZ0dxWGtaOE9GTGpuaWJzUnNaYk9J?=
 =?utf-8?B?elVGZVI4N1NYRmVuTG5rbXlXZVJpcFhLc214WDFRNGhRNWIzckVzL1drbXFu?=
 =?utf-8?B?T2dxSk5pQnpjRHlORkQraDdnZXZ3c1ZZRTZJSFZ3QUJ0UytmaStPMlVXVEo4?=
 =?utf-8?B?WEQxQWEvYkExa1dlYmY0WXJ1QnpJcW83ZzU4ZGNGQnhjekpFT3pnRW5Xall2?=
 =?utf-8?B?TGc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	6p8WacKgMo0687RuEXrU8/V/Q2sD01ylPihlCVI4OAq4ioL1MUB6G+/rVJDrsMr0yeLILgWIkSv6UedOrCezXLQRYpfqvfE4UXSlhlMM5ngOgD2jy3d7E8mH7++EdCdqmO2ZbztFAcllXupqs2ZCJuzkHrN6U4YvYUSwRT3KoCxQ2G4BywFbTgj3di1c+WldcIDKA614HOyzKWqIMvIIP6KPju77422Px4DlWGWSs9hlv5Mmf8oxhok2N3iVbVu5tIo2/ci5o2RpM/OJc7zP4dig4L8OomMh6iudHQdAa0rsfp/Wco37hu6cvfHcw+qVFkwRNzf/ULNXgDCzspdzbbWUUIftz4H3YjGPtSePXp3lt1KAP470fd30k6J//f/5mZoS97X0YerkGglNlUEhWJBsI1qn8YtrI4e/YpitDq1aN+ilIvv9bo0zPHuQV6xu5baIHsu/dOOZC1SLzJvjL41aTTDOpkXjwA1i5dAmhGKtTqsj9ud9vFv5cTY2mbXxxwg3MTaUzvCsxAST7Ji+KWu+VLNHkHV2qBaxNGAoi8V4Ihfw8MWTPUgpY1PfNxs+q3yMPLKn+ADHgcxxPBudOM4TiFSFdV6SKkrWmnIfhGw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2f666a1-d5fb-406b-ea62-08dd010a9f36
X-MS-Exchange-CrossTenant-AuthSource: MW6PR10MB7639.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2024 22:05:29.0890
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eAhe0KDP8LAYbud/N9hjzk/voLOd6b9rlVdBN/Z1JW31c11YP9Phhf8XZm86l/JpJLYaDDyZIpZK0Yv2mY8lkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB5913
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-09_21,2024-11-08_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 phishscore=0 bulkscore=0 malwarescore=0 suspectscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2411090192
X-Proofpoint-ORIG-GUID: 6CwlDWNs4bkbClk50ZOYYl3f9weMgKju
X-Proofpoint-GUID: 6CwlDWNs4bkbClk50ZOYYl3f9weMgKju


On 11/8/24 4:40 PM, Trond Myklebust wrote:
> On Sat, 2024-11-09 at 00:03 +0000, Trond Myklebust wrote:
>> On Fri, 2024-11-08 at 15:20 -0800, Dai Ngo wrote:
>>> Hi Trond,
>>>
>>> Currently cl_tasks is used to maintain the list of all rpc_task's
>>> for each rpc_clnt.
>>>
>>> Under heavy write load, we've seen this list grows to millions
>>> of entries. Even though the list is extremely long, the system
>>> still runs fine until the user wants to get the information of
>>> all active RPC tasks by doing:
>>>
>>> #  cat /sys/kernel/debug/sunrpc/rpc_clnt/N/tasks
>>>
>>> When this happens, tasks_start() is called and it acquires the
>>> rpc_clnt.cl_lock to walk the cl_tasks list, returning one entry
>>> at a time to the caller. The cl_lock is held until all tasks on
>>> this list have been processed.
>>>        
>>> While the cl_lock is held, completed RPC tasks have to spin wait
>>> in rpc_task_release_client for the cl_lock. If there are millions
>>> of entries in the cl_tasks list it will take a long time before
>>> tasks_stop is called and the cl_lock is released.
>>>
>>> Under heavy load condition the rpc_task_release_client threads
>>> will use up all the available CPUs in the system, preventing other
>>> jobs to run and this causes the system to temporarily lock up.
>>>    
>>> I'm looking for suggestions on how to address this issue. I think
>>> one option is to convert the cl_tasks list to use xarray to
>>> eliminate
>>> the contention on the cl_lock and would like to get the opinion
>>> from the community.
>>
>> No. We are definitely not going to add a gravity-challenged solution
>> like xarray to solve a corner-case problem of list iteration.
>>
>> Firstly, this is really only a problem for NFSv3 and NFSv4.0 because
>> they don't actually throttle at the NFS layer.
> Actually. Let me correct that...
>
> NFSv4.1 does throttle at the NFS layer, but does so in the RPC prepare
> callback, so perhaps it is affected here too.

Yes, 4.1 is also effected even with throttling by session slots because
the RPC task is put on the cl_tasks list as soon as it is created.

> However we could reduce that problem by moving the addition of the
> rpc_task to the cl_tasks list to the call_start() function.

This should work for 4.1.

>   Doing so
> leads to less visibility into the full workings of the system, however
> the active tasks will still be fully documented by the list, and if we
> need to, we could supplement that information with a total number of
> queued tasks.

Yes, it's good to know the number of tasks existed in the system.

>
>> Secondly, having millions of entries associated with a single struct
>> rpc_clnt, means living in latency hell, where waking up a sleeping
>> task
>> can mean living on the rpciod queue for several 100ms before
>> execution
>> starts due to the shear volume of tasks in the queue.
> This is still not a major problem for NFSv4.1 since we do have
> throttling happening immediately once the RPC call starts, and the task
> is never awakened until it can be accommodated with a session slot.
>
>> So IMHO a better question would be: "What is a sensible throttling
>> scheme for NFSv3 and NFSv4.0?"
> Still a problem.

Perhaps we can put the task on the cl_tasks list in call_reserve
after the rpc_rqst is allocated?

Thank you Trond for your help!

-Dai

>

