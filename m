Return-Path: <linux-nfs+bounces-10905-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EAC6A7173D
	for <lists+linux-nfs@lfdr.de>; Wed, 26 Mar 2025 14:17:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF3B53BC2F0
	for <lists+linux-nfs@lfdr.de>; Wed, 26 Mar 2025 13:16:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51A911E1E0D;
	Wed, 26 Mar 2025 13:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mcG3Pbf0";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="qZGfNb8D"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56E7A2A1B2
	for <linux-nfs@vger.kernel.org>; Wed, 26 Mar 2025 13:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742994949; cv=fail; b=t9CjuHc+l3nAccmToBiB65DzNzJXbBQfZcYWWkbm4aJWAEEZ1BvxiPdBlJGGxCnn98ydWGWIGGQOHuIr68Hrl4kBmgJNQ16JFztmhveRFX3vJ4r/efxPyTmMpUGA2ck0RnOaY0JiBaX+31O+zvWByvfww2rVrvEv+bq5LjolXfs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742994949; c=relaxed/simple;
	bh=CbgyeA/pGZ0X49d2lLiwatMspl53rS+Gb93aF//go48=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DzRTkJB1MMWAiwsU9LPoBxX8oUvKUYMRvNemVh1leCDNK/YG8+jCYBW8AlfAgwZGBBfHAnV2BDCccUhV7WgnzM0tWU7soy9l3jZseJRKn0n0nYRULMkHVUTv90TAmmefMH1hPGIOWoN8VPA62ZAx9BP4FV/0Yvdm/pkNm+flx90=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=mcG3Pbf0; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=qZGfNb8D; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52QD26aQ030107;
	Wed, 26 Mar 2025 13:15:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=2aRDy7gbe5IPZRiBek6PDqksbvC01iRhFvrmQv5E47w=; b=
	mcG3Pbf0UteT7tsROOAo8HTO22qJBLqSSSTws928/gMxiZqQzbZoZBDJIWLfwMsF
	GTxkALfvYFPFkQgGBfmuIOzyUU6emq7s7OemxT1A9hWrs4ZnYadTm972hugTzFYi
	2UklEwcxfT4yhXooYcxxvVC6wRp9FPcuAyMLRT3yDFPkFO5Zi/XQl9Il6E7Zgz8O
	f0YNt6+vT3XPEXkdj67N6Ym8dStWGzgJpusfw6osX76N/eAdeUnsxtgp1f17soGm
	RHcSrNhZJ7culw5QsBE42+XOqzHM9F44FWOOesm4mxjEqWPs/p+fLBfCUhgKeQeV
	EBMA+w5zCzKtL4Lo8MoLLg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45hn5m9f9e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Mar 2025 13:15:36 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52QClp1s015201;
	Wed, 26 Mar 2025 13:15:35 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2174.outbound.protection.outlook.com [104.47.58.174])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 45jj93e3tk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Mar 2025 13:15:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JpTfTjWNk9y7W/w8UUF8myWNBo0xluDEb7RTq3haI4dEqSim3KF2WYxDUI99wVbcgSvWwd3LkTCAIdfXyXLXctyDzB88Vi4IjNmnwTS7qm7X9v90iAsjilCvAUmVwgu0FmaKVzibyTDSUGKBK9e7nwx2n2HqvU89uTAYfrSSfouYjQvs7UJ4Mb5cZqLv/UNnX7+ucH3yV30Lu0EOEYj++X9CBs00EA/b8osL2Sl/5UVZh5IkozGQ1CfA7nWljrNwgjmjhtmWQ1UQTBKDNIrTwQL7WzcBS6LIVooOvKYtxXBS1FL/7csmCv3+do4FJUChsyit4fcXOzYkpkTyj1gJpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2aRDy7gbe5IPZRiBek6PDqksbvC01iRhFvrmQv5E47w=;
 b=YnYbqgI6L8B0F8ttPMQFIDK+t/Hc7IUzfyLJI18bcHgzfoJn3O3Q58Krv2+FxHnWr5TwuSsUAtzg3zZHnfooPW2dW264EDrFsuZfKYbDbQe9sWFs/AGYjTRqWXx/80NwCRrdyC4dpf6+/Z5IbPd1YTjRpwvIv3wFSk4fnnfxa/D0OLiC6wly6LNtXgvIqlr3V+K9z2TEkKd2BmEyi4/JpqJGIKKddikzpljoyYaJLpksVr5jfNiGR80vJn+HTxHfaFF+Z424wELtglCiMqMQuJDcUzLEfcCfR7l+HUDHNwYLekjcm9gGURXzTwxZ8t6L6kqQws5sBNmhj1lI1xc/Tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2aRDy7gbe5IPZRiBek6PDqksbvC01iRhFvrmQv5E47w=;
 b=qZGfNb8DPfXbla68wAMOMeE+v7WR8Y/9YsM2DPPNDEWYKuQm04nnN068+LcKG1p7pJDYOcWLET0+uxDWJuLY3RDyL2b9YFACPGNPacySU12i2Iq6Q+5Nbvozg/AniemwsQSshyZCCGhz3A5vhJnAMAQ4TUO7lMunBHC04msDqwU=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SA1PR10MB7683.namprd10.prod.outlook.com (2603:10b6:806:386::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.43; Wed, 26 Mar
 2025 13:15:32 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%5]) with mapi id 15.20.8534.043; Wed, 26 Mar 2025
 13:15:32 +0000
Message-ID: <92dc63d6-802e-48c4-9f4c-eae8051fa065@oracle.com>
Date: Wed, 26 Mar 2025 09:15:30 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: NFSD automatically releases all states when underlying file
 system is unmounted
To: NeilBrown <neilb@suse.de>, Dai Ngo <dai.ngo@oracle.com>
Cc: Benjamin Coddington <bcodding@redhat.com>,
        Jeff Layton <jlayton@kernel.org>,
        Olga Kornievskaia <okorniev@redhat.com>, Tom Talpey <tom@talpey.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
References: <> <8787b756-2003-4a2c-a56c-8f8c626756a1@oracle.com>
 <174296051697.9342.18114262068417505490@noble.neil.brown.name>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <174296051697.9342.18114262068417505490@noble.neil.brown.name>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1P223CA0027.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:208:2c4::32) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|SA1PR10MB7683:EE_
X-MS-Office365-Filtering-Correlation-Id: ec4658e7-998e-4b9d-bdce-08dd6c684978
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bzZIOTdQZnVLTUlnb1ZDQm9VQjNVdHBQOG9UOFhiYlZGZ3RqclhGZTg4UzhP?=
 =?utf-8?B?aFc3d3JPZzZXQnJJSjdWMktjRmovbTRGSXgzZ08vd1AxSlNBLyszUnBjTjRo?=
 =?utf-8?B?LzU3ODZ6NWF4ZSt4ZFpGTk5iSmFBQTBYRVpobnowcTlXWUJpL3dYT1ovT0E3?=
 =?utf-8?B?d1c1YlJxK21kVWM3NnpYR1VHZjM3c1AzVElBbzJiUlNHYVV2L0RpVjBTN2Nl?=
 =?utf-8?B?dGcrUjI4NmUzNG5iVnZxMTllVFZQdVRCTXhmRU5vWG5sVEU0eG9UWTExcnBX?=
 =?utf-8?B?RDltTFU5RTdiOFJuUkQ4bUFsVVMxeXg3dVZJYzNRVDRoRk52S3JMaDRCOGk5?=
 =?utf-8?B?aXJjMmZVQk0yNWJaSGd0aUxpV0NrUWE3LzNsRWxpRTlTeWkyT0F0MWZrTGFE?=
 =?utf-8?B?bUlza1VJR3dhNFZ5THA0RnFmOFlDZXVjMXZNZFhtc0NDMTY2ZXk2QXBCVURz?=
 =?utf-8?B?ZXgvN1daWndjYlNvZjI3dllTcW5leVMyTzJVN05vQWxtWk9nYlNYNHEybUV2?=
 =?utf-8?B?SnRMR3JvZXBZQklFL0tsTy85OGZoMmduOXdCQy9tTERDcmJ2eFlaSUlDei9U?=
 =?utf-8?B?T1VGY2NIaFBxNUJQWnIrUWo3WktFOURBNWVkd2xtYmxSemIrWkdDZEVDbzFX?=
 =?utf-8?B?Nk1oMXBvRnREQUpCekxaWlY4TUJkdFUvbUpmTFpBc2IzcHNNRWd4aExITzV3?=
 =?utf-8?B?cWxhc1IxYWZSb09rYmhub1RuVkRackU0eWc2TEpHUGNXU2g0eVQ2bGFmVkJh?=
 =?utf-8?B?bmdDZ3NqbjVKR1VSK1dNbUlOOVhZek83Rzd3T2FybTZSVWNuZEtnS2srTFl6?=
 =?utf-8?B?aTdqdm1IUlVadmFoNzN6NUtOc3lGT0NYRCthN3Q3ZnB5YUJIS2x2Y1RlNHNL?=
 =?utf-8?B?cENMUklURFNUL0g0L1Jkb1B6VUJkSUNtZjhITVBkZ2dlT1A5ZDVRZFAzaUlh?=
 =?utf-8?B?Z2RiUWRqMTdId3FGZEdhNTZLLzNaeEJiUTZGL3BUYXpIMm9JOG83Wmw1Rlpy?=
 =?utf-8?B?aWJQVlZmazc1b0JWKy8vajFPZzdRTmNweE5KcklIS3pCcWdFYnphY3M0Z1NN?=
 =?utf-8?B?bzY3Mkx1NEI2U2gwSXhqV2RaRXpOZ0NBZGFKVXdxUk1LZ1RKSCtERHgwU2Mr?=
 =?utf-8?B?NVRKWVJraHlxTmNaK2NjTXNtRjdQRDgxVVhFMTJVeTBPV1AzeERvaFBuc0V1?=
 =?utf-8?B?Q0RFYllIVTltRjdQc3IwUWUvWTZyaG9TUGJkTXFES1Exa24zeE5IRlBjZGRC?=
 =?utf-8?B?SjI0T21PbDdYU1hHVExjc29VMkVjOTBoejhpQ0lMeGlhSCtVN1VFOGEyKzBP?=
 =?utf-8?B?b3RyNVBRcE55anFKZGFpM2JHRy9pajRFL1JRcW95UFV5S013aFBTc3d4c2Qx?=
 =?utf-8?B?OU01c2QyRU4rV21FTC90ZHBNanVGMDVOUkU4aFd3OTNORWJFYzhUQ2xIamNO?=
 =?utf-8?B?WXFUS1hhSDF6SGJMRU9VbW40Y3VEZC9HM2YwYnhNdjhqaGlvMHZyV0p6M1BL?=
 =?utf-8?B?K29SVmhVN1k5dk1FNkg4VUg4NEE5OXhPZjdVQ0lzM2ZuaGZKeGJvN0VQVkpt?=
 =?utf-8?B?ZG5RUTZ6djFyRWlTWHJFNDRpZ29VMlNjMVMyWWM1VGdNYWFtOFplNnh5L1l5?=
 =?utf-8?B?QldvSm1OU2NHQXpORzNvczV3QktlZjJLbXg4bmdUN1B2ZTRxZGh1a3ZQZTJC?=
 =?utf-8?B?ZlJiSG40amlPZ2xQV2oyd2FGNENOeUlLVUNMbTlpYVowNVdWbk5oeCtYbzFX?=
 =?utf-8?B?SGlFTFQrYmdnb1ZnVTJVR21JakRuZlpoUk93OTN1bjBRRTYxV0lQREYwYzND?=
 =?utf-8?B?dFJ2UVdZeFhIZE8zbG8xUllJN0lMOGVtK1lOd0VGSkd2N2dBMExwMEE5ako0?=
 =?utf-8?Q?MkF6eODO2sfKE?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RTE5U3RTSXE5OG9wVXYxcVZnQmRrM09RNDhWVmVnK2lSUE5XQW1PNGU5Rm9U?=
 =?utf-8?B?Ni9SNTNzWmlUU29mcFNxeURKcmRyQ0xaNUlENlJRYytCRkFUaUJZUy96cjJF?=
 =?utf-8?B?VjBuOTRLb1p4VFlVaGVLUCt4TjI5Y2Ric1ozaVpYNzRPaVh6dVFTMEYvTUh6?=
 =?utf-8?B?elIrb1BnOGs3aGtRL2U3eUxza0VvZU1iWENsbFlibE1uaG44VE9nRUc5NFdV?=
 =?utf-8?B?ODI1VGxYTG9acWY4MzJFSnpNM1U3cVQrQXNxVHZxbitLTlpKZ1JkYWcwZXB6?=
 =?utf-8?B?Z0NVcHJkVG1QVS9oRGRteWQrQUU4a0N4YmNjYWVja0x4eWIyRXVCYlp0S1JB?=
 =?utf-8?B?ZzBxMEVOTUpialk4TVFFaW9RcHE2RlVia0U2ZngrNy9DZ01PQlp5UU1LV1NU?=
 =?utf-8?B?Q05CYXhmRGg1V3Zia0xKbE5GbU5oek5oNzhaZzVNOG9hMnp3RVNrWHNKOWpL?=
 =?utf-8?B?TlZHZHQ5U21TcWVWN3QxK002dEIxM2ZyVFlXUkhORS9CN29JVGJqKzVUVTU3?=
 =?utf-8?B?eS9NdzQybmxHYVpnV3I2dEUzckR5U0N4S2s0UFRzcHg5a3hlZEcybTFsWGda?=
 =?utf-8?B?cFd6WWpCTFNmb2tKM09LUi8yc0tvbTRzY1o5dG40WmIyUjI5ZTJQbE8xL05Q?=
 =?utf-8?B?MXBvNWc4cUhJZWJ5YUY2MDMrRjJlQzhWUDluZW84eGcxMzBDVDNhc0ZDYnpy?=
 =?utf-8?B?V0g5ZHc2NFRKcXZpNEtDSGcrZ201Ym1uclhKSHlONmNzUFV1KzRWM1U4RDlz?=
 =?utf-8?B?YUFkWW5GZVJMSDFBNStaV3RyL2RHSTdJbWJCb09tL09vM1YzcThDcG1WZEVF?=
 =?utf-8?B?VFRkNzNWbTd4bWNYcXVUb29FZ2w3dlQ3bEJIbDhZeEhWQ0Rwb2cwSUlrdXJl?=
 =?utf-8?B?OHV5czRVNkF5UDE2R2VoSDJSbzVCdmZOQ3lXdnk5ZzdodmtlelphbXpKZjRP?=
 =?utf-8?B?OCtKSHJPcmQyZzU2UEtDeHEvQjFjcEFnQnUwUVB2SmRHbGNINDNyQkFnVXRw?=
 =?utf-8?B?UkdPVWlkSi80VUJqOTQ4UG1Zd1AxVkpjamFiLzlBckZtTk8wdG81UmlzMmpF?=
 =?utf-8?B?Z2JLc1NoMVpENFNkNmJoNXhtYTRmdHY4MDc4d3dOSnlQbE84MWh4N0djNHV1?=
 =?utf-8?B?bzEwMzFmRXdQNE56ZTZabS9TaUhSTisxa0V2VDN1ejJWWFRSWWxFQXNjZ2Jl?=
 =?utf-8?B?Sld6T0l5R3oyWC96RFZuc3JiMEF5WDd1ckN3eFo2bGdab1lxMkV5RXdlVkVC?=
 =?utf-8?B?SDdxc2NWZThjdm05QkZVbVlpK2t4b3lwclQxYXdKQmZseGxuMlI1RzUwSzl5?=
 =?utf-8?B?Y084VUo1eXEyTlhiVGRYZ2E5SWQxRWREeWsvUnNrQnVPbk92QktEVko2MGRJ?=
 =?utf-8?B?VjZ0ekFFNFlKclpDdVJGY1FXRE5NdVI4b05PVHdpRXA5Wnp2SmdzRVVtL0Yy?=
 =?utf-8?B?bFVqKzFJQ2hOWWFKUFltRHRXRlI3TjQyOXJXM3pMUTJSYnVDRXg4U3AwMStU?=
 =?utf-8?B?bnlDTlM4QzdrUkpua0N2OEdSeHM2VGdDZEYwbml5S0RSaXRONzFVV2V0WDVn?=
 =?utf-8?B?RzlxQW5lMjFEajgyNmhSRUVrNEswTndpbGZXOHVLL2pLc05Qb0hFYWRob2dH?=
 =?utf-8?B?ci9SVXlUQWRhSWZrNUdBNThlYmt0c0xFemxXOEw1cXhiaVo3Mm42TDg3eUEv?=
 =?utf-8?B?NTBzZU5DcUtGSFFvbVlSU2Y0RUJJcW9PUDhsUUtBdlRJejVseFdQL3I0eFE1?=
 =?utf-8?B?WnZFMWFTOHcxOGZIT1V5SzQ0bE0xRHJobmlkd2tydTRzTHUvQmpzMTJ6OCs1?=
 =?utf-8?B?b08rajRyUnBMMXVGOVBkdWFkcHQrZ2kxUGZSemQxT080dWZKS2YxSVpSWlc3?=
 =?utf-8?B?bDRZM0ZQbWNyM2RVYnRFUVZhazFBUU5MOWFSektDLytKTHhvWWFkdDRlaHNQ?=
 =?utf-8?B?ZlR2SzFMd0J2QXd1ZElDK0dQeUZFZk1vWjhpMnRlZ2dMZFp4bHg4OEZBNysy?=
 =?utf-8?B?V1NCaU1ya2IrWkJ4UXJjN1AzOEt2RlBnbzdscC96eEpzVkRkMGZYcFZCU01C?=
 =?utf-8?B?Y3VGREI1bHFkSUVVK2gwKzFZeTFSczUxNWRLTzRURCtScSt0aFV4M1lIMXph?=
 =?utf-8?Q?T7Wlsp7lks15nqUXmB5yaXynf?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	s0AtGYLYzYGpciyXT+2w+FiBV+jiq/+0k9LdyIqGmjbcH38ab1fDw9lx2lgMoXTjvH1dKnCvQV3lw6/PE1mYF99dtvalJM2X+glFhQ+DlC0TfuP57CeMVXsJ8eZJBgjQVuGKL/BDfQoGaae64PWKInmr1QDcjIFlfz9tDjLO2U5sY3DQNI5RYpV0nap8smi3HBKkjof7mKjPguPCTqXhFMBzUi6xggeTjKRq8A+PkxW19Lhdx8blgbktpwcQf+XfMkewFMc0g3HqtFdQMECrAHqv51nOa2iTmchES/hfGxeABNPq3EmzyJbReTI29f0ysnjCR5L7LtNFfJZA+horlcsLJFlg9j5j3LkDXQIaTwIrgeMKH0gCUugWCV8ZlgFHkd4lX4+s7gVQTJEWWGQPTJlAaSdZ0dXcfD2x2sQpBlAPsK7Jyy3WcjqKpCMu7NdUQIu1m4y4rMLIECvwL5W3staYx+iQQq7yHlbU8XdOpXdmGZbiBEaZm5c55uq+OLmjiXTuLQldf2seO/cgP7LTtQD3L1bP9j4AOql9IGvnWJc0Ixn/ukHJJAAioT1kgkFiYb1NGgeqX5/DskvO9zXd1YxjmF/I/7fg2WpYwmiX6Fc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec4658e7-998e-4b9d-bdce-08dd6c684978
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2025 13:15:32.3746
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kf7MYH4Vb+qWUq4sGhWQdNAG6mBHx2LlFflFxfLul7YXA0A/JOilsLVKWc4mIhIsH6HNrtBbZzfB1kMcIvS/qQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB7683
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-26_06,2025-03-26_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 adultscore=0
 mlxlogscore=999 mlxscore=0 phishscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2503260081
X-Proofpoint-GUID: WOQ8ickS0vTeffQpIzvZyQZxtXnO0GkK
X-Proofpoint-ORIG-GUID: WOQ8ickS0vTeffQpIzvZyQZxtXnO0GkK

On 3/25/25 11:41 PM, NeilBrown wrote:
> On Wed, 26 Mar 2025, Dai Ngo wrote:
>> On 3/25/25 5:23 PM, NeilBrown wrote:
>>> On Sat, 22 Mar 2025, Chuck Lever wrote:
>>>> On 3/21/25 10:36 AM, Benjamin Coddington wrote:
>>>>> On 20 Mar 2025, at 13:53, Chuck Lever wrote:
>>>>>
>>>>>> On 3/19/25 5:46 PM, NeilBrown wrote:
>>>>>>> On Thu, 20 Mar 2025, Dai Ngo wrote:
>>>>>>>> Hi,
>>>>>>>>
>>>>>>>> Currently when the local file system needs to be unmounted for maintenance
>>>>>>>> the admin needs to make sure all the NFS clients have stopped using any files
>>>>>>>> on the NFS shares before the umount(8) can succeed.
>>>>>>> This is easily achieved with
>>>>>>>    echo /path/to/filesystem > /proc/fs/nfsd/unlock_filesystem
>>>>>>>
>>>>>>> Do this after unexporting and before unmounting.
>>>>>> Seems like administrators would expect that a filesystem can be
>>>>>> unmounted immediately after unexporting it. Should "exportfs" be changed
>>>>>> to handle this extra step under the covers? Doesn't seem like it would
>>>>>> be hard to do, and I can't think of a use case where it would be
>>>>>> harmful.
>>>>> No. I think that admins don't expect to lose all their NFS client's state if
>>>>> they're managing the exports.  That would be a really big and invisible change
>>>>> to existing behavior.
>>>> To be clear, I mean that a file system should be unlocked only when it
>>>> is specifically unexported. IMO, unexport is usually an administrator
>>>> action that means "I want to stop remote access to this file system now"
>>>> and that's what unlock_filesystem does.
>>> A problem with that position is that "unexport" isn't a well defined
>>> operation.
>>> It is quite possible to edit /etc/exports then run "exportfs -r".  This
>>> may implicit unexport things.
>>>
>>> The kernel certainly doesn't have a concept of "unexport".  You can run
>>> "exportfs -f" at any time quite safely.  That tells the kernel to forget
>>> all export information, but allows the kernel to ask mountd for anything
>>> it find that it needs.
>>>
>>>> IMO administrators would be surprised to learn that NFS clients may
>>>> continue to access a file system (via existing open files) after it
>>>> has been explicitly unexported.
>>> They can't access those file while it remains unexported.  But if it is
>>> re-exported, the access they had can continue seamlessly.
>>>
>>> The origin model is NLM which is separate from NFS.  Unexporting to NFS
>>> doesn't close the locks held by NLM.  That can be done separately by the
>>> client with a STATMON request.  In fact NLM never drops locks unless
>>> explicitly asked to by the client or forced by the server admin.  So it
>>> isn't a good model, but it is what we had.
>>>
>>>> The alternative is to document unlock_filesystem in man exportfs(8).
>>> Another alternative is to provide new functionality in exportfs.  Maybe
>>> a --force flag or a --close-all flag.
>>> It could examine /proc/fs/nfsd/clients/*/states to determine which
>>> filesystems had active state, then examine the export tables
>>> (/var/lib/nfs/etab) to see what was currently exported, then write
>>> something appropriate to unlock_filesystem for any active filesystems
>>> which are no longer exported.
>>
>> Is it possible that at the time of cache_clean/svc_export_put the kernel
>> makes an upcall to rpc.mountd to check if svc_export.ex_path is still
>> exported?. If it's not then release all the states that use that super_block.
> 
> I suspect that could be done, but then you would hit Ben's concern.
> Temporarily unexported a filesystem would change from the client getting
> ESTALE if it happens to access a file while the filesystem is not
> exported, to the client definitely getting ADMIN_REVOKED (probably -EIO)
> then next time it accesses a file even if the filesystem has been
> exported again.
> 
> I agree with Ben that there needs to be a deliberate admin action to
> revoke state, not just a side-effect of unexport which historically has
> not revoked state.

I'm not religiously attached to expunging open/lock state on a simple
unexport operation. But I think it is critical to document the fact that
NFSv4 state remains and that will prevent an unmount (I'm not sure we've
identified any possible security exposures).

Neil, do you happen to know if unlock_filesystem and unlock_ip are
mentioned in man pages? If so, then exportfs(8) should refer to them.


> NeilBrown
> 
> 
> 
>>
>> -Dai
>>
>>>
>>> If we did that we would want to find NLM locks in /proc/locks too and
>>> ensure those were discarded if necessary.
>>>
>>> There is also the possibility that a filesystem is still exported to
>>> some clients but not to all.  In that case writing something to
>>> unlock_ip might be appropriate - though that doesn't revoke v4 state
>>> yet.
>>>
>>> Thanks,
>>> NeilBrown
>>>
>>>
>>>> And perhaps we need a more surgical mechanism that can handle the case
>>>> where the file system is still exported but the security policy has
>>>> changed. Because this does feel like a real information leak.
>>>>
>>>>
>>>> -- 
>>>> Chuck Lever
>>>>
>>
> 


-- 
Chuck Lever

