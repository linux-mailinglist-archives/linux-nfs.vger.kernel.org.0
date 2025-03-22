Return-Path: <linux-nfs+bounces-10766-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD245A6CBC2
	for <lists+linux-nfs@lfdr.de>; Sat, 22 Mar 2025 19:06:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B9891756C0
	for <lists+linux-nfs@lfdr.de>; Sat, 22 Mar 2025 18:06:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAB8022D4F9;
	Sat, 22 Mar 2025 18:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Wqnuo05f";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Ef8sRnq9"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABF8C2E3384
	for <linux-nfs@vger.kernel.org>; Sat, 22 Mar 2025 18:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742666810; cv=fail; b=iY+xvmmco+NPx0Usg0gEoQkazJrJERxN8EmHymWOy1vexcNb65lrbAcywbHiypsDxlLo4XqNkqhSYzWAQgSb2VXOiD/R3q5ZnlZStEGbfDUSe7wYoc4MLwTqQ2VoU6YsMqn6sXy/ltRfeiJJVoFQ0RgRfUg6xqWQ2X9WW0qybog=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742666810; c=relaxed/simple;
	bh=irqvnCuf/AOz3l60aQuo5Mb9Gy/+luThtblK+712G00=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Petd4FOj9NjhUqjRcxHOB+rgg1hUMxyxhSdfQK6FB6c12g+EFpG7c0q5ecpasAr5/O2wQyU8WgA8sxLamkKcSkyloldLS+DMP1gAtN1izbSxBBuoeXfFVtSk2Qn7Zlb3lgGEk2ObG0eKMrXZGPe1gWrHZbQKPb9GgGuc41whtcc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Wqnuo05f; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Ef8sRnq9; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52M5CqE4030350;
	Sat, 22 Mar 2025 18:06:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=AHafPE1Zxavemur2CILRdphSFlx58X040C5YNHRibpI=; b=
	Wqnuo05f30e93ojTne0/m8gd8mgQRrvshchnDUcLgTODAYji3mm0M3Sn9kfMjvJJ
	JLDN3sjhDqh64a4tRSIB3AmwPpT0mrXZEtmQNv2WmiLfntbXDTUYH6NIc03KrHVQ
	PLEMFkE3uQ9xDZO8+kr+fjGqIQ73UTbvn7Qvt5sIJG8bb/qElCVLC8ItLgFR2wXZ
	E31ZsQh/jFOwhMDgWc4tDpsLGIu+bzDfDfmPilUZWo1ylaaCUBTAIulQD/mVS1MV
	ZDbUA3yZ7XAhjpmpdccsfDHmWvb5nVpsx8i+arb7N9ciA1KjKAHzJHcwz0cISm1Y
	h7QfD0VBK9AATZTI5mqnKg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45hncrgvkr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 22 Mar 2025 18:06:32 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52MGUloI007268;
	Sat, 22 Mar 2025 18:06:31 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 45hkn6f763-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 22 Mar 2025 18:06:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DxiqPvcw8VMgYpzVj3G3UZpyEam18mb5C9bKUzgYuA/8KypTtJg94zwRtkdZ5h63grLyC2W4suh0jxEfVNKDDo4csAsDb6rzjHLIJHvKbehvIRE7log3SJ+by5mogTIj9kCt3FJ+u2Jt2Dy3v4XN3nwENvd9EStvvjn/3Ob46FTrju2r5tskofdYLty9y4rNRCt+hfScGGPtqaFXAEBmHfvdG9CFlfBREKIaBPaq/8sskPuzy4O0S6tyDgrkIgThq4nuumCh7YSiPqY9cvmGZT2WJIYXk+AAPuoPWsBi03I6A+8QvMixt0TsdA44Gg7pSubvsehw6snJ0ovBis+WJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AHafPE1Zxavemur2CILRdphSFlx58X040C5YNHRibpI=;
 b=GZBrLi5FOTCG21FG05RNMQapaMB1i8q5xp/0/SeVLR1M8A27K8qGdl2oNAh/CsGUOnmwdrLb1DDgxY5GU+/qSKR3gRED9tDayyDpsWRgoT3+dvKH5+1EgRJL066+iWe1ft1TvUd9yzBeTTgETTU/ONeR5n92tIw44VydFtElSKLqva0LUTqL2Kv4V3JgIo4Otwb7ND0s9KtQOjBcVwIbcjpOnvgwTsOoVCIr1gI3Im1SYNv6HnHbvyFg2260c5GjCqVLitaQN6SFl5w8GKgDpG+A4sBijORv+FCIv/wLjr1KnEkxD15XUvJQbnIXVMLkuYdTNlmDKjKtHNk/uQORlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AHafPE1Zxavemur2CILRdphSFlx58X040C5YNHRibpI=;
 b=Ef8sRnq9ZRpv/hR1cJAD5SkjwSLQRBqjn/4ipsSp98lqlYykExr4ms1WR0oGxj0XxxrqRVw0hNHTxNTHAq+j9VhSTMmvlam019K1V4me0/3N2puWCQ8HDW+xxSPfj/6pd6hspPr4yMA6+ApVoLrlcgsLm0avXpKzWDW+r5pkqcE=
Received: from DS7PR10MB5134.namprd10.prod.outlook.com (2603:10b6:5:3a1::23)
 by SA2PR10MB4475.namprd10.prod.outlook.com (2603:10b6:806:118::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.38; Sat, 22 Mar
 2025 18:06:29 +0000
Received: from DS7PR10MB5134.namprd10.prod.outlook.com
 ([fe80::39b2:9b47:123b:fc63]) by DS7PR10MB5134.namprd10.prod.outlook.com
 ([fe80::39b2:9b47:123b:fc63%5]) with mapi id 15.20.8534.036; Sat, 22 Mar 2025
 18:06:29 +0000
Message-ID: <75ec06ad-7472-4e83-a20e-28543ec2909d@oracle.com>
Date: Sat, 22 Mar 2025 14:06:27 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: kernel panic when starting nfsd on OpenWrt with kernel 6.12.19
To: John <therealgraysky@proton.me>
Cc: "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
References: <xD3JWWvIeTEG7_-UtXFNOaGpYHZL9Dr4beYme8ebQZiBvaBcTu3u7Q9GxE7cJrGRYsfTjC2BPxBTuyl1TijqjUP8_nC4tpcfekVKuBtDp68=@proton.me>
 <0cd73138-baa7-4cd7-a6ed-7c5eefed495f@oracle.com>
 <yW5ewBN3-dAMHSq9KmbFRPRt_fK0FTmuqclUbu4K1kZPcfB6DmXRPOVC_OAwh1waQz2Of0qUDqxQ3YL-NBULF9H6-HMdVjixFAad20f5sUY=@proton.me>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <yW5ewBN3-dAMHSq9KmbFRPRt_fK0FTmuqclUbu4K1kZPcfB6DmXRPOVC_OAwh1waQz2Of0qUDqxQ3YL-NBULF9H6-HMdVjixFAad20f5sUY=@proton.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR04CA0099.namprd04.prod.outlook.com
 (2603:10b6:610:75::14) To DS7PR10MB5134.namprd10.prod.outlook.com
 (2603:10b6:5:3a1::23)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5134:EE_|SA2PR10MB4475:EE_
X-MS-Office365-Filtering-Correlation-Id: f4220b67-d0f5-4dad-6534-08dd696c4491
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aEFIeWNING00aGtHMGVNRjJpb2xaOHBReUtxY0xGZHZGSXZxRnFXMlVyUFRV?=
 =?utf-8?B?aGs3VGNjWS9wcDE0RXluTWFjT1Q2MGhjay9hLzk3Q0hSNmc1N01ucDkzQnV0?=
 =?utf-8?B?ZnNUMHNjb043YWRZSUNSVmtTUjRldFM4MzU5Z21kb3ZLZ2NBUlk0WlNWbHF0?=
 =?utf-8?B?OG5HWkdjcmpKZWJnOFpxb09JRWx3cVhqS2dOcnJUZUEvdS9WQkpIM2xtdE9P?=
 =?utf-8?B?azh6TFlZdVYyT0dQWEdqQWc5elNDNWZiTFU2WXFEK0kzTWw3YXZHVGh0dmdy?=
 =?utf-8?B?V1dPODlqODVMczg3alBhVFIwTFB3amRyUWJkcVJXK2FyanUydnB3UW9MRWE3?=
 =?utf-8?B?NmVnSEV4S25BL1hmZnJPMkxEZjZTWGRGRjdrRXJLSm52eEZPUW1aYlkzQ2Fq?=
 =?utf-8?B?VUlPY0dTQU5OVW9SR0N5NGtmZkxEZWFPQ014WUdDVkZyUzAyTzdVc21zUU00?=
 =?utf-8?B?dUtUTHRTc0VIc25qbXdsWEhaSlY5cmNYWWV5NHhjaGdqUVErVndHVko0RXRv?=
 =?utf-8?B?a1J4NlQ1cGZuK3lKYURzbDlZOTY1d3VWNjZXYnlrcVQzSnpXZ3dDSkdjOTVs?=
 =?utf-8?B?Uk5hMkw2V3Z0YUdSSTJoNTZGWk5NejV1dmJ0a24xMkN6cFlLZWl1NDkvV0Jq?=
 =?utf-8?B?NE8vRE9ET2NveVRMd2VXaVByRWM3ZSszTUd0VStWRjY4MHRnazBPOFV3WHV2?=
 =?utf-8?B?Tmt5WHdvSEM4TXVJQ2toRE9XM0dvWGxPUldicGNuQ0RCVzduT2R4L3JkZGJG?=
 =?utf-8?B?dnNoczh3YzlxL2l2bTRURHczbWljcDRvMzNSckFyMmpvOUdNQ0EwRkt4Ly9x?=
 =?utf-8?B?aDlJWFNDNUNpNUNvWDhKWXREenFpZUdXZ2NvYnZHQk1qSDRrQml2UkJRbEx3?=
 =?utf-8?B?c3hGcnhidFI4eGg4cHJEdkR4K0g4bWlQelFqQjVYTXhGWVpOTSszK1U3bGxM?=
 =?utf-8?B?L1A5eEhJMWQwTEZhaU5rS0x1emRzVi9NZGJMaUQvclZSQURCNHNrRy9nUmJU?=
 =?utf-8?B?YjV6ZURySnp0bCs0N1A1blFPMkczb3Q0OUFGb1lGY0h4cm5TUFRGODVMS2ts?=
 =?utf-8?B?SFVOeXlGVmFJTWlDMW1oaGlyR1QvcEdEWHhlUm1ZTHhBUWZJcDJDcm1PR1Vx?=
 =?utf-8?B?U0Fxc1FSZXFOL2E3UVBDQVpDbVI5VzZjRjk4R1FvR2VheW9LQ05zYU9rci90?=
 =?utf-8?B?NDZJaHJuYmRSRkdFTTN3cVZ4bjRXUlljVDh5ejhjN0wrNXZrT05xVyt0Z2lq?=
 =?utf-8?B?eUg3WUNYQ290bXczcTdtMURJbDJQT3FFK1UrVUpWMWk3MVFJR0NMWUtyMklJ?=
 =?utf-8?B?clQ3eUh0dFlNdHA4OUp2RDNxNGo3OXYwSU8zRGFhdkxFMmJjSlVKc3Z0YlhL?=
 =?utf-8?B?MDNpTE91eEhUTGdnTmFNWVNHemJZak5INlJXWmlOV3k3eXpsSjM2TEhEZjh5?=
 =?utf-8?B?M29ubkJ0Z3RUczNqQmcrbnBPUGI1K0ZiTzdSL3UxdVVVZDVucFhGQ1JFTUMy?=
 =?utf-8?B?QXU5YUQ2ODFEWThGb3dvMGlzdG5kN2tqSXd1QmMxRnNCT2daQWdHeHZ5MCtK?=
 =?utf-8?B?NkdqanRKNVFuaHFtNVZzaVlpb3Y0eFV3Y2hmaE1EclJRQTRDNCtzeHNWeThW?=
 =?utf-8?B?Z1BvYTA2VjZ6Zzh5U2lQVHd3NVRBaEJYVkpOWnlJVEErdkdwUks3ZlJSZC96?=
 =?utf-8?B?ZXdxNGpVYjc4WnFscG5LdDVJdjJyOEpDb2kxVUoxWHdHN2lLWE9wbExrVGxD?=
 =?utf-8?B?elhwMU12eXpldThFRElWaXg5aTV2NGluUzB3R2wxd21tQ1AxbngyeEpwKzhD?=
 =?utf-8?B?L2pDTjBKSlBzbVRNaGgyMU9EallCdEVWMVpGVjFXa3FuSFlLbExrNzJOUHRl?=
 =?utf-8?Q?dbrcQFnVPkvl/?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5134.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RFllbktndS9FaGNiY2NKUUtiYkRXUjNtT3B3S0x4UDV1WEJKamx1elNVQWFY?=
 =?utf-8?B?M0ppTjNuVlRZa2dSSjdCTzg3bGcrUmEzVFNtQ256YW1XS3JaZ211L2RTV1hX?=
 =?utf-8?B?MzRJVXZpTVp4ZWJRUC9EdHZIZ2MyRjVFVklFTThGZllkcmxlc2grTmliQkJB?=
 =?utf-8?B?ZERCZlc1TWRUdm53KzlJQ1NrNEt2ejBkb0RBaXJKc0tYVTRnaFhIbzNyem5R?=
 =?utf-8?B?eWJHZ1k2b0FSR1BKc1BCc3pmMmd1RXQ5cEVyU2duellWekpJNEFGRjdoVmFF?=
 =?utf-8?B?NjhqTFA4YkIrV2VudjhMQjJGTS9GR2hWSVVsKzV6dTVobTRTTEl5NkhEM2ds?=
 =?utf-8?B?byt6SDg1Vm9WWWN5cHEyaUZxL2toTDhpeEs1QS85dkNCSFJxMVZHdytvSjdu?=
 =?utf-8?B?cGlaazBsRzhhNXlBK0hYOXRIWXA4YWJSeEtaMTVtbWVDYkpUTllVRXNlNDNy?=
 =?utf-8?B?Zks3SE9oSjIwL2lLVHFxbzhaVEJkWWRhWUIvdWFlYys5MFhONHc5eWJGSHFU?=
 =?utf-8?B?c0d4QlNvZFBGdUU5TWZGTm5ucGhIVTN4eUFoandSSHY2dEFJUm5McFB3UlA1?=
 =?utf-8?B?V3BxKzhJRUp5WFNXMDJSOThvWDJiU2VQdFhzYTIveWxsTlBPUmI1empPSzhs?=
 =?utf-8?B?NGtzRUVKckxPM1JTRSs0TWxZSU45NkVjNy9vUzh1R3pINDVCamdlREF4MzVI?=
 =?utf-8?B?NWJSZWJubzQyZkJkcjc4Qm1PbmNZNC9LQ1dWNk1Nb2JPZHZsSVAzckJUbUg4?=
 =?utf-8?B?UERiUU1uYk96VFVMOTFoU09pV1MvUXdtMkh6RFB3ZTdhM2JPVEJJMUd1cUlT?=
 =?utf-8?B?TDk4ZnNSVitFcUhpRTNRMlBiMGxnOVVJbWo1c1QwV0lDeFFFWUhOSlp2ZW1z?=
 =?utf-8?B?VWJoYndNeFd6aXdIR0NrNWZhRlpDQmVLTVAxSEtvTFFnVjYzTkxqYjFDUmVu?=
 =?utf-8?B?VmV6TEg4VlNjSVMwZzJtbFp5emJKWWZST3JUbEI3Q2JoU3cvS004cWFXaHJB?=
 =?utf-8?B?T3lzU24ybFdSWTh5WHJNNDlOQ2YvK3dnVkRaVmcxYk1NWVlKNEU3aVF4c0VC?=
 =?utf-8?B?Q2MwTDI1NVRrTkwveVNIcU4wQnB5RlhmV2hjZk4wWjQwQ2JKblF3emdYZjhx?=
 =?utf-8?B?ZkpiREJURS9yeVRyYzQwMXRHV21LRWUxQ0FSQXNmL1hXb25tTldUU05CUGt5?=
 =?utf-8?B?RVBaZUdQUDZlcTNpYzlvL1YxdGdKRDJhaDQ0RVFrVVU3RE5ac2ZwbzdibS9X?=
 =?utf-8?B?cjdFRlNIa0pSS2orU3lCVVV6QTNVMmNiR2l0ckdiLzdOYkRxK3NDMndTZWpE?=
 =?utf-8?B?K251b2drQnhSNU1BMmlCalhVVEZpN3V6RnF2Rm94NGVDRlRoMDRCdmFBSzF5?=
 =?utf-8?B?UDdLKzlqRE1mRkZxd1E3U1pLc0lSakEzc3puaEZ0N2oyekg0Mm13VjY5WDZQ?=
 =?utf-8?B?Tm12WnVMR0M5RUx0TzUrVXQ4N2luMFJUdjZTMzJHU2RRR25VcFZYaTNXSS9S?=
 =?utf-8?B?OHlZcTFnQ0k5VmVvYTc0cko2UGFFU0hpNFRyS0tkV2NObmF3UkdBYm9SUkc1?=
 =?utf-8?B?U1BiYS9CSGprKzRuc1RpSmM5ejgyY0xLU0lweGhuaXlxdlRTUS9YaGpwTzFF?=
 =?utf-8?B?VysvU3phSlczTnVjdGpwSGM0dDBlbE5GRDAvSFdIdmZkR1I5emVwdFlBbTRq?=
 =?utf-8?B?UFhFaXREcE81akFwUzk0YVdNSkRORVVkSUlqK1FacXZaUUE3cDdaMlVEYS9z?=
 =?utf-8?B?YnU0TGNLT0NsT2hicmtPbUd4V0VPZjJKZHFpeVVZSU82SUQrV0ZCOXkxc1Z4?=
 =?utf-8?B?S3NJNUF0RlZwSTRIbXIzeFBQck0zeFZGdktCMTB1SU5vU2VzdW9qdHlEMU9l?=
 =?utf-8?B?Z2NCYkV3bjlRVmNGUlVzYVp0NkFudzdhOG5UVjlsYVlDOXRkcWw3cHpYM25p?=
 =?utf-8?B?d3UzdER4b3VYMldlNW9DeENNNlhkRjVIQXJWem95U2RSYndTZWdEdzk2VW56?=
 =?utf-8?B?TUx4L2piOXFldXU2Yitjc1ZrNnArQ2NxQmVtYTQ4K2FRL2ExUTA4bnJCOXkw?=
 =?utf-8?B?ejJUaXpCWVhHWkZpYnNnVWkya29BWkFDN294Z3BPQXNvY3poenBDcVRYai93?=
 =?utf-8?B?b0xORmZFaUo3K3RJWHFTWmhybWY1UnhvbWdaVkZxcnJXS2xKVmhqWHRveHVa?=
 =?utf-8?B?L2c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	rWo8CQcqtNg5+I5A/P7ZKgnvjdR1VL3oZlz4duUU8/Sj/1Ns02Fcdkovs8mmQjh2182xcOX3vFazf0VY8Wj4SUnNig5Z6UbXd8wJieAoo6u9OCMtWp7Nmqt4m0snzEGGShkx17sbDLnWFSXoGt+arBKK3ajAah8vTT5VCwZ7WzocvmbmCTTxV9HUUX7lAPd0HQ4HgQK/EmwIMkNFG2amnz/NwdX+AwgUgKiplJBxTy/asSD1iXi78ckRWcTVqCLgmJllW+7OyhmlQHucunSjQJRtPac1jBiXGVhz9/Gq4ReS71PbX13FIrZhbCnpcMZt8vhJ/yNeXwjKdtkvUGiaGZo14jS1umoAYQkWTY8AI2qIDKZtlyJWtsExYx2jlxxxApZUN70VqwLw/WeHhO66vryAVAKVzBYuBwEw/8XRtuGkfax7OwRNMdrdCOVUNbjm8Iqz/sb/mvWDJqM7+Ytzsw7WrobIqfW6iMwuxwcvrjTAq5w1F2afJqJZN9QpRdyLYyLpfeothb20YtxeUp4M/SWllP+Jci6m+ZQT72ROO0vwq0PydagCHPPWTJHul+gy7M7zqZdPEgypNjiIrFbsDduv+fTj67a74fDrubWgY4Y=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4220b67-d0f5-4dad-6534-08dd696c4491
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5134.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2025 18:06:29.2520
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UuODTPNr67Uwy8o8CAiOX7uYAzLUEK6R0CsY2hqu6PL3bhl8FrU9zZi5hMLOMETmfMgys1qhMBHmScD0yfou1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4475
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-22_07,2025-03-21_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 suspectscore=0
 malwarescore=0 bulkscore=0 mlxscore=0 phishscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2503220134
X-Proofpoint-GUID: W_mkUYuiIAPql6BlPZDaN0c2GSkaj9aT
X-Proofpoint-ORIG-GUID: W_mkUYuiIAPql6BlPZDaN0c2GSkaj9aT

On 3/22/25 1:20 PM, John wrote:
> 
> 
> On Saturday, March 22nd, 2025 at 10:49 AM, Chuck Lever <chuck.lever@oracle.com> wrote:
>>
>> I recommend bisecting between 6.6 and 6.12.19 to locate the culprit.
>>
>> When you have that information, open a bug on bugzilla.kernel.org under
>> Filesystems/NFSD and attach your information there.
> 
> Wish I could, but the way OpenWrt is designed, moving from one kernel branch to another is major undertaking often requiring months of tweaks 1,000s of patches, Makefiles, config files, etc.
> 
> I have been reading up on NFSv4 and am wondering if there is a way to simply disable the callback function. Could that work-around this crash?
> 
> Unfortunately, OpenWrt's nfs-kernel-server package does not ship nor use something like /etc/nfs.conf. At the link below you can see their init script to start nfsd. Many thank for any ideas.
> 
> https://github.com/openwrt/packages/blob/master/net/nfs-kernel-server/files/nfsd.init
> 

If this is a "product" kernel then you should approach the distributor
first. I do not have the hardware, the binaries, the .config, or a
cross compiler for whatever "Hardware name: iKOOLCORE R2Max/R2Max" is
(guessing RPi ?)

It would be helpful to get

$ scripts/faddr2line fs/nfsd/nfs4callback.c \
nfsd4_probe_callback_sync+0x1094

although, IME, +1094 means the crash happened far outside of the
nfs4callback.c source file.

This:

  nfsd4_client_tracking_init+0x39/0x150 [nfsd]

suggests that your distributor (or LTS) might be missing a fix
for recent crashes that are due to incorrectly setting
CONFIG_NFSD_LEGACY_CLIENT_TRACKING. I'm thinking of perhaps

  de71d4e211ed ("nfsd: fix legacy client tracking initialization")

in particular, which does not appear to have been applied to
v6.12.19.


-- 
Chuck Lever

