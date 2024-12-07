Return-Path: <linux-nfs+bounces-8415-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB4A69E8166
	for <lists+linux-nfs@lfdr.de>; Sat,  7 Dec 2024 18:49:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFF98165AFA
	for <lists+linux-nfs@lfdr.de>; Sat,  7 Dec 2024 17:49:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C79D64315A;
	Sat,  7 Dec 2024 17:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Ne0gYuJ1";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="LduPKmzE"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAB9F1AAC4
	for <linux-nfs@vger.kernel.org>; Sat,  7 Dec 2024 17:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733593777; cv=fail; b=YkWJNMPDcY9+GsEbhLuuSfH4eIb3rI5ccY8H7/+Ptp+Hb1jNhpIMEItxC2a9uJ2/rwmXbvVitatXIJm+oMfcfiZZcRA/bSJnh8JTqiLm0rtvyXUcXSBsxyzZ6pm+Fa++ra+AYYcWKaVcJBvVKIivQqcYc1BtvoFD2C7UNQNJ9A0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733593777; c=relaxed/simple;
	bh=IdTLCFHvliugjfavZxIX4nwsYCW/SaHkM2835E5ImQ0=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=W/puTutWk4/MohQ5e6+FXKrP+QxpIN8KkThw/CkUXR3kmQnzV0H/To5yhzUi2JyaBAgeie5J/F6CWzoghhQn2uGS99RbTSJG2UnUaCQ7Sryf72jQansL9aJg7BI4hs3OE3JQIyyFt22/YWeoEjovYdE0to0grSiinCayXuDA9Mc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Ne0gYuJ1; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=LduPKmzE; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B7CSZf1000399;
	Sat, 7 Dec 2024 17:49:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=4kBiUpd1P+VB0bphIIWOeDEPGJMjLFSaCIQN6BR7JAM=; b=
	Ne0gYuJ1boGgRcQrf5Et97BAsUBup1V1RLRjA8kSP4+uUvJ3tb42OETeAESl7I1o
	EzA/FcWOCwQrEDZcchz0Gm2zHNYyiXKeDP006/fHcSSiEHiyGyXKaAqQ71FKwPRT
	nVmvZb7gjaWuPuklJoGwyl8TwKYT7Lq8XpSRBvjycyJRVuZJDSYuWnbUTmn+C1N3
	g+uQ3HD7qOHBhe1plizopZ3mdWjkkEgxNdhFSLqzHHRv2vcKFOLWF9M6sdru0v3h
	U+mKVgn9r4r010hXGfOfWq9G/u7blAwC3yW1hUXiDQ531++O9pc7HpY4sdkKm5D9
	DPnyV27EmX5h+cM5T6kVog==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43ccy00rrg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 07 Dec 2024 17:49:27 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4B7FmHSI009482;
	Sat, 7 Dec 2024 17:49:27 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2177.outbound.protection.outlook.com [104.47.56.177])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 43cct5nfem-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 07 Dec 2024 17:49:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZLSTJQ/Jw3RnnYHB86AAl4cxuwraH+tlfPdM+dZNH15vUp0AorxsEccn/pBAesfai+CCpfPWJ2+Y7GlG9bEhCELU9hnmOObyZE8xaFsb3P1GibtF8NBKQg9YMfTQFHG9nDb0fhmGL3u0KPB3jTTG3Z0rFQDLeMWEJevGFV4jNRdAhQSNdch2fYkSXn12q3y+2XHhP21ZDI2TIGBQ7DnGjATMM1IDuLGUMp+MkYl6zioYKrDViCVydnpiIYhbmnfggx/E7BkHeC5y0BGHlNVoCMc9L3F8eILwBkrouAicc6V9dbXXUuPWBfHE7u+F9dB2kIwtOOkkB19skPlilMsw9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4kBiUpd1P+VB0bphIIWOeDEPGJMjLFSaCIQN6BR7JAM=;
 b=a0DMNYF6AzmybhQqXnm10mGgkOgzyU1jmLmhqz2JjRxBPCr7p02HtcMq1zWNJojf2+r228+mwtl/ORLMWBQo2aUNwXXdgTEGzkHNCfqID07Dui83tq8QfUPqnnstAenzpxbU7MzzySxgU1SYMKW+A8d3E1jvFi5REZd5Mz+JDtHXmgTz95DgmUX9N4R87z23Vz+0narzGH3a+zvaz4fY3gdXeiz56XdzWzNkkX0PIg+nF59/kaXe8dihhNkPXoMr13DpwugVYlfAS58guvqf+snRANoO6wOiiAr2Hh2P9y9laG4dKLBcE/us81ArTdjeMJvOo6IE3qzRuHQvzc+o8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4kBiUpd1P+VB0bphIIWOeDEPGJMjLFSaCIQN6BR7JAM=;
 b=LduPKmzEQbxbJcJL838V7tkZVllR9gRifCtlAEIZET+/1tQz5c61xeCNp6hGm0//E5tr69HTgoN5xp7z9oeXIj7wwLFmm+2/wOj7Qov6zOu19KqWH/5xU6hvjnmGWKQy/+0ffWuPULl9lLMg9zmhWoKhM9PjpERWwvCNPrA4QBk=
Received: from DS7PR10MB5134.namprd10.prod.outlook.com (2603:10b6:5:3a1::23)
 by DS0PR10MB8102.namprd10.prod.outlook.com (2603:10b6:8:202::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.11; Sat, 7 Dec
 2024 17:49:24 +0000
Received: from DS7PR10MB5134.namprd10.prod.outlook.com
 ([fe80::39b2:9b47:123b:fc63]) by DS7PR10MB5134.namprd10.prod.outlook.com
 ([fe80::39b2:9b47:123b:fc63%5]) with mapi id 15.20.8230.016; Sat, 7 Dec 2024
 17:49:24 +0000
Message-ID: <005d46bf-d017-4419-8f03-8c68cecb1e27@oracle.com>
Date: Sat, 7 Dec 2024 12:49:22 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [patch v2] mount.nfs: Add support for nfs://-URLs ...
To: Takeshi Nishimura <takeshi.nishimura.linux@gmail.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
References: <CAKAoaQk-T=yBU2jJ=E_WcSmbPPkKk78N_tkTacL7Nu=udUDNFg@mail.gmail.com>
 <CALWcw=GHZe4_9BejU8xzNOcMxY42DVChcKysFfYHQns5uH238g@mail.gmail.com>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <CALWcw=GHZe4_9BejU8xzNOcMxY42DVChcKysFfYHQns5uH238g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR04CA0051.namprd04.prod.outlook.com
 (2603:10b6:610:77::26) To DS7PR10MB5134.namprd10.prod.outlook.com
 (2603:10b6:5:3a1::23)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5134:EE_|DS0PR10MB8102:EE_
X-MS-Office365-Filtering-Correlation-Id: 52031cda-1b5f-4c86-5d8f-08dd16e77cde
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NFZhTmdZM1dJUjRocXhtZUw2S0NFbmUvVE9xMGZFVjczemZnS1ljYWlzWk4z?=
 =?utf-8?B?R01PeTlqNnNOQi9vQS8xbWFCUUhxQWdXQ1hiTEtyeW5FMVhncUJGYlcwSGMw?=
 =?utf-8?B?M0k0WjJTd0wzSWFieDVOUVZ1bitNOE9WeHlzaGhaaitoSVBicG5yNjU1UW5s?=
 =?utf-8?B?ZzVFUmFrWWRYVExzMmJYVWdOeldjWjlNc2ZjTmdmWHpWNTQ3T2xoM3d6d2k2?=
 =?utf-8?B?TTFoZEROTW1Od3o5YWNqbWRXR3RKckFhMHI3T2xNSXdHRkNsME5zKytCYnZO?=
 =?utf-8?B?MkxJUXl3VlIxQWRTdTN6bTcwTTA3WmxaOGpJMVUybTNHcTZjUG16NzlvVjdQ?=
 =?utf-8?B?OVJua093Q2hVZFcyd2dpQm9aRU1wMjVUMGVLYkIwSFJQdjhkOGo3VUZGZ2ZE?=
 =?utf-8?B?bStZMEhDY3F5Q24rakZMTzArM2xlRms2VWpmdXZBNUNGN0xtQTgyNUI3R1V2?=
 =?utf-8?B?ZmxSc3pNVjdBS1ZxSUR5WTRDbldFcGlHcUl4YU9KbUh5bHJkbWx2VkVmcEh6?=
 =?utf-8?B?VlpIQjBGQW91a3JoZXNXcU05YmhEMTZJUlZlK1E1THIzTTB6em5GYUhlOEVh?=
 =?utf-8?B?OW1sOXV3M0FDWnJPaUMxZTl5TWpoZTFGTEsyN2JDQmdlM0puRElKazhsdVVK?=
 =?utf-8?B?cWNQb0t4cW1nMUJ1ZzZ6dVBrZ2dCMkJCNFVUaHNSTXllaTdwTzg3ejd6UmtG?=
 =?utf-8?B?cmdWL05zem5QUjdDN2ltNHUrQnJrQnpiczRiSVA0NjhSZjJSY3Q3bm9scVYr?=
 =?utf-8?B?QzZLQ0NFT2Q4aUt2SE9ML0tOb3gvN2VCMytZMGRFM1Btb0JwN0ZTV0ZZQXg0?=
 =?utf-8?B?MkZJR1lzbGI4TzRMMDFXSTFmeXliMVlsRjJzQmF5RTBmUkNhTWF2ZVNWdDln?=
 =?utf-8?B?emxtY3VMRzRVSDFCK1Y3Q3VyVVBKeTlEb0c3dW1xa29LMjM4bGJDdlRsTXNN?=
 =?utf-8?B?cm1jc2tWN3F3Q2RSMGFIL2NnYjlYSUJPcXhJeDR4YWxkOFdSZ2tsNlVFSkVw?=
 =?utf-8?B?VFREbTJaeDNzRENpQWRwM3l2ZU5qUzRWRllPelM4bC82dk8vanlFNm1DblJT?=
 =?utf-8?B?OXFIemdPbFJUOUtQUGJkSks0V2hESVpVWGJ5QkoyaU5LWWdRTXpsekpadVE2?=
 =?utf-8?B?bTNYMzlPWEI1MHh3WEVTanBwblF1WVZYNHViY25OcGdkSTdhWU9tdDU4SlhZ?=
 =?utf-8?B?dFA3UWwwa3FaWDlzR05zY010N1RtRXo3aDVRV3EzUXNadFRMYmxkcE52VDJO?=
 =?utf-8?B?UGY2MnlhVWdiWjQzcTBQNlhRL0FrRVplZ3k3WTM5T3d6djJ3WHI5aHMzdDZo?=
 =?utf-8?B?WDdBNldjQUExR0o0dnF0SWozNmtnbUNNS1FOZm56dHArUVRReE45eE01Sk1M?=
 =?utf-8?B?MGhtRGQ0cnZYZzJabEhKd3BOcTBmeGorVW5qbUJhV0dTWTcydVpIZFNBZ2dk?=
 =?utf-8?B?SjVUUkFpWkZ5TWFmeHFhd00wanhBNlV3c0x5djBnazVmZzFqZmlSWWR0M2Q5?=
 =?utf-8?B?LzdzTXdpQ2RiMEhSaTlCeTQyMkJENkErOXZRS2JuWUYxTEhwU1I3eTY2K1R0?=
 =?utf-8?B?cXJPQlZhY2JiUktIdlBwak9rbFFSOFNQU3p4SEY2NGFmMElaWGErVDVFVC92?=
 =?utf-8?B?WmJRamxtYUduUnMwcmpoVlpiTlF2SnpqamxQWXRELzF3aUV2MW51dHNnUU5z?=
 =?utf-8?B?Y1BndjlPYXovTHo1bmVmclRFR04wTjVkYlFKbnZSeVR2d3BocVVuSXFyTzVP?=
 =?utf-8?Q?XgnlIDUD0D2Ha4Zx4s=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5134.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NXI2MDV2YWh3VDhVRWg1V1VuRmNadWQwR01wV0FSQVgwMkUyQlpnQy9abnJO?=
 =?utf-8?B?bWFjUHlXbmJXR0ZKU2w5UGZWWjNpNHZNUlNZMTBZQXNoQzJZVmtETnNLaUdi?=
 =?utf-8?B?bFVRQy8vOFRaNkJVRW5Ia0ZUVlVOM2VCQzNNbGdDSU5kTVJxdVdoTkdJa1lK?=
 =?utf-8?B?TCs1VmR4WEtVUDlBVGxaNkNVOXhKcVZTaGVjR21MWEJzNE52QWRXSWk0Vmtn?=
 =?utf-8?B?di9IWXJUb0JYL0t6aXlDNHhFRWgyK0J5eStjdmhiZDdieS9FdGEyMTd6bytx?=
 =?utf-8?B?ZDBlSHo2MzZWVm1McGU0N3gxbi8wRWUyaWZZR1dDVEUxb084dUp3RmpKTGlx?=
 =?utf-8?B?RGJ3VEVra1RpMWt6QzhucnptekNmNUhObXd3YWVMY01Fd2RjTzMvOWFXY2Fk?=
 =?utf-8?B?U2ZzOGhjenZCTlZCNis5NjdIbVgxZzNIalgxL2tYN1FOWi9aL0RIYkVuQUN5?=
 =?utf-8?B?MHhFdTA4c09PTk5PamdvQlBiZGEwa1U2TTVqSGVCT1RyTlp6Y0Q2VUxUT3hD?=
 =?utf-8?B?SDREenBHdTVGNFN4VnMxVm5FdWdlelhPKzFlbGpmd3N5MFJTYi9uamhjdTZl?=
 =?utf-8?B?NnNZd2dvTkx3cm1nQWpJS016a1VrdHpOTjhYaXRDSUZsSG5xd2c1UG9oMWkx?=
 =?utf-8?B?eUVnMU1XckZTSW1tdXhSaUk1Wng3NTRNckQ4TWdCbXZIVlB6TVVlYm50L0Zl?=
 =?utf-8?B?eU9pSS92eUw4dEdUcmxiakw2RXN6ZWtkWGFQSmdjbWhFUmtiQWIySEZseFhz?=
 =?utf-8?B?VXZIM1YzdXZuMVk0bHovMnFxTi81SDVaT3RkdnpYdkxCTUJuZGlpY0lZZlBw?=
 =?utf-8?B?K3JCVlpYSDZFbGRVR0FLQmNVMnA2QVZTYlE3aDVqb0Z3bnJqSzNoMXJHUEVv?=
 =?utf-8?B?M2ZEek9nMGJLMS9ZQXVqc2tnWGlJK2tqazJOMFh1bDc5dEN6RmJNdUFrdndF?=
 =?utf-8?B?dWpmUzd4Ui9VSlFib1ludG5sTk9tamVZZDYwNXYvRjhOV1l4RFFVM0ZGbWp2?=
 =?utf-8?B?bSt3SlFiTDdveVV1WGJwMFBtanlIbk5aYlBxam5aWEx1VEU4ZEhvT0hWRHJp?=
 =?utf-8?B?OGxpQllEYVdDU3h6TWNTdFlzVmJvc25SZENJUWI4bEw2ZDFweFN5aUVydHRr?=
 =?utf-8?B?dUF2b0NuRDFHdisxVmZacmx6WG5ocGtzQ0puVStsWk1jMFpIRzU5OUJlZnV1?=
 =?utf-8?B?aDlTZDA3U3JVSlhJT3hGNWM1dEtQTWZIVFREUTIxNkUxeldvbmhmK0ZRVDNr?=
 =?utf-8?B?ZmRCT2ZXRm9TMDhwbVVwdWY2YjhRd3NYSGNiYm1GTHBHMTBod3grZFB6VTJG?=
 =?utf-8?B?bjRtd2o2Y09BTlVNN1ZZdEt2RnF3eXg4VnpTL3U2YW1YVzN6WllvclVuR2F1?=
 =?utf-8?B?NHhuc3lHOXAvZ2EyZGpueXVmbThZeHNuN05IMHNSemdscDE4Q0k4MmIzNVVK?=
 =?utf-8?B?V1NlN3VhbDJMelV3cXZ0RE9HK1Z5cHpocmpjSGR0WVVlaG9Odk0vWld2VmRo?=
 =?utf-8?B?c2ppV1pBdVVzS0F5cDU3WEQ0eFJZNXI5RUlSTVB3eVhDTHhhNXIxSllDaUM4?=
 =?utf-8?B?ZEVsOWovc0lRcE01QW11UXhKTXJnZnZyNGpnamJNcEtxSEd0WEc4d0szbXQz?=
 =?utf-8?B?OEpXeTdtaG5CTnc2TTJ3RzVnNHpHN1RMMjJEc0R1Wm0xak1wdTJyaXhDTEY2?=
 =?utf-8?B?K3JGdDZsNExMWEYxRWFWZTNvOVdXazViMVIrd0hlaS8zVHRQM0hYZ1M0SmNk?=
 =?utf-8?B?L2laMHpGRmViUjcwUHFTZ3dRaUYreTIrNWVQd1dkSGdsSHYxYm92amwwbFRq?=
 =?utf-8?B?YVlUSjk5KzFWSkhPOWJpaGxxMmJMNzlTellJc0g4d3NHT1Y3Yi91dE8xaEZa?=
 =?utf-8?B?bW9Tbm5tVXQrQnZMRlpwbjVDYXNJZU1Wa3ZlTkJjSkZrczU2Y1ZxZ1Z5MzRy?=
 =?utf-8?B?R3lUbGM4bW8xWkJOWktyRkdTM3M2OUdGem41UVBUSUh1UC9NMWhub1NJQnJN?=
 =?utf-8?B?c2VESnhyVTNPd29hWmtsT29SL0VVSGdYM1Z5STlBNnRhNUsySnFUSG1vYzRa?=
 =?utf-8?B?U0pWV3N0K0tEMGg1TlU3ZGtsTldtY0Q5Y0Z1YVVCbFMyYVc2aE4wcXBIL0o1?=
 =?utf-8?Q?Scrb/3eUZDUzXbHhbChXwtkvo?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	jZyUKi1pAT5couOBbb44uuaRR1bH49/6hrREFBLc9ni25vt1jWO/VLffehVdPdHyoqwAj40niqDHp/YZ5PTvimlcWC+Lk2qtDOUKS45X4llbtysC46XhXSDPEZKUYyMm2AUq0fBZffds47wNAfJTBWgDk+nFqu1OEDFI6F4YsDs0DZ4+fI1pzPEbewGDq8+/g/GY7TrZjffVRfjUSuB6VNzNXAat5f0kzA2AYjpvE/dpKWXE2Ps+AzjMeQsxlEY3dR8DNKy6k8Vg07JDCnHCubIgGvhLA7mXOM3DeUeKt6lKMRAj1I4AanwJ26QM96tJLBr0diTgfuPHgbxQP10dVBHBIqsX2jlq0/rsldZ0yz+PWrLD77dCgxkv3mh5sJYs2TxXIiIPapMmEZX/Cl4i7zX4e2rUVgMAqJ0xCXKXoQj+ycUbm2i8wnHl2xpArrKF3zSL1WrZ5+CHfIiq6LfHzVI7/+8ylaAT6hfEE/jNlhL0D9V2PIxrzDldPYsOR6EdeF7UoWIN3OVNcZs/w8nrVgoKIZmkk4icdUp9GuWRNSmEDF0uWzZbnZyfQeFLWc4Aawtwe6bbtZ7m6aYXNHCxBHBJVBZ1jYR9ztJm3cgwkBY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52031cda-1b5f-4c86-5d8f-08dd16e77cde
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5134.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2024 17:49:24.6237
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NMR8i4wuIv3n5+eC31sX15CBbEzuNn0yPAnWyfUK+t7jjo0Fzuan6nDEWXcEgMYyV9lwb/EPyMtIdusN3H3kbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB8102
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-07_02,2024-12-06_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 adultscore=0
 malwarescore=0 mlxlogscore=999 bulkscore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2412070149
X-Proofpoint-GUID: GucZozJJPUlFoe-q2GKdwL0toFTXA3ng
X-Proofpoint-ORIG-GUID: GucZozJJPUlFoe-q2GKdwL0toFTXA3ng

On 12/7/24 12:14 PM, Takeshi Nishimura wrote:
> On Fri, Dec 6, 2024 at 10:55 PM Roland Mainz <roland.mainz@nrubsig.org> wrote:
>>
>> Hi!
>>
>> ----
>>
>> Below (also attached as
>> "0001-mount.nfs4-Add-support-for-nfs-URLs_v2.patch" and available at
>> https://nrubsig.kpaste.net/e8c5cb) is version 2 of the patch which
>> adds support for nfs://-URLs in mount.nfs4, as alternative to the
>> traditional hostname:/path+-o port=<tcp-port> notation.
>>
>> * Main advantages are:
>> - Single-line notation with the familiar URL syntax, which includes
>> hostname, path *AND* TCP port number (last one is a common generator
>> of *PAIN* with ISPs) in ONE string
>> - Support for non-ASCII mount points, e.g. paths with CJKV (Chinese,
>> Japanese, ...) characters, which is typically a big problem if you try
>> to transfer such mount point information across email/chat/clipboard
>> etc., which tends to mangle such characters to death (e.g.
>> transliteration, adding of ZWSP or just '?').
> 
> - Server
> mkdir '/nfsroot11/アーカイブ'
> - Convert path at https://www.urlencoder.org/
> '/nfsroot11/アーカイブ' ---->
> '/nfsroot11/%E3%82%A2%E3%83%BC%E3%82%AB%E3%82%A4%E3%83%96'
> - Client
> mount.nfs -o rw
> 'nfs://133.1.138.101//nfsroot11//%E3%82%A2%E3%83%BC%E3%82%AB%E3%82%A4%E3%83%96'
> /mnt
> 
> Works - (◕‿◕) - 素晴らしい
> 
> @Roland Mainz Thank you!!
> 
>> - URL parameters are supported, providing support for future extensions
>> * Notes:
>> - Similar support for nfs://-URLs exists in other NFSv4.*
>> implementations, including Illumos, Windows ms-nfs41-client,
>> sahlberg/libnfs, ...
>> - This is NOT about WebNFS, this is only to use an URL representation
>> to make the life of admins a LOT easier
>> - Only absolute paths are supported
>> - This feature will not be provided for NFSv3
> 
> NFSv3 does not do Unicode, so this is not going to work anyway

There are two purposes for adding an NFS URL mechanism to mount.nfs:
one is having a common way to express a server hostname and export
path; the other is to add support for percent escape.

We still should consider NFS URLs on NFSv3 with the code points
that NFSv3 servers can support.


-- 
Chuck Lever

