Return-Path: <linux-nfs+bounces-11741-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F2E8AB8590
	for <lists+linux-nfs@lfdr.de>; Thu, 15 May 2025 14:02:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E4DD9E078A
	for <lists+linux-nfs@lfdr.de>; Thu, 15 May 2025 12:02:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BA3D298CA2;
	Thu, 15 May 2025 12:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jdbh/dMt";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="LPQl3HDm"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86898298C29
	for <linux-nfs@vger.kernel.org>; Thu, 15 May 2025 12:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747310523; cv=fail; b=d/d3XLHehSwQVKIYGTBmpV+qr+V0XSye3g1roV/gpsdgAPAl18m9Yy4WOpbm/vxtHHwyPfWX+AaubFgfTgQ/tPjQUs7RYnYhKmxhxOEGZLGFO9K83PbzGM3r9U0WL1e+QQihoIF2FTZstxfzVXPZPIVhTZD/CAS5UOy7yANGsYI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747310523; c=relaxed/simple;
	bh=nK9oEQ+sTWnQv9aqJIDjQv4jg0qn+nK2njwzxoTEbSc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=TW95Fg5I+CftMoEDc3Tyfl3fWYdGWUv9B+1vqag16ELbbgYMKnbhrs1FRp7QvocazuxkAWr52B9dRCkDvVpwrvAlrI0CdJqwEGEdj9L2NQ55CEHeyrqmkboc+RHotul9V1Elq+NeCFfMfmvN8vECjV+VXJbCtTVqj49FozvnMN8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=jdbh/dMt; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=LPQl3HDm; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54F7Bt6b016011;
	Thu, 15 May 2025 12:01:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=SZVOtm0mDP21W6OBr4ETOJj168in255deNSARadrl8w=; b=
	jdbh/dMto903Q/F9ae9rakD4h2yKewBthiYdXV+HQtYi/aGYybR9HR0uHrqgnEU3
	xp0Yh0pUSDL2kgeQFCS8oOSO0EkK+72SWidqTdI+Wa/bm9VkKViIzIjBpJvCkNT9
	qfDj+Wc/bG0Dqigr/CAKIErDVSdc/DSahm9abR2clk238zM2dRL/j4UQMoyhIRcn
	IAZt1HOIwb4QHMeesnuN9dSAgiSL56KbIHkarRwDX+5O1TJyhLmcsLv7CVjNSXmQ
	ITsQb7E9hwyVD11zN8DRz4OzlXhPa7hwA3hEC1+0ivHI1z8v1NfAPGhfnD6MWX0L
	Ug2v3RWBv0AYlkJmmDDH/Q==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46ms7btm43-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 May 2025 12:01:48 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54FBrXpv004721;
	Thu, 15 May 2025 12:01:47 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2045.outbound.protection.outlook.com [104.47.55.45])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 46mqmda2s0-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 May 2025 12:01:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iVzXUBPSeMO9Nnu3BZkLvdFLyb7GeijbQRooSp7XrJzl5TIqDlaKRIqJNJg4sZ+Ws1NXkUE5vexxZH+DBnWpQic5C4njiPO+z6sitErpUw0uhb3Wo+uMqokwHTNUycZY/h1pPAvj8s3aRAhPk7W6z78HmYdBHQ8Qze545S9/4fTRsQJgHXFtzUcptI9hU96lOoq9KEsEAqVP4nTMmC+1c10TgOrZMcd1oTJoyHEr6O/kQouYKo3JKdR+c1Sto5hQCr+qvhD1qYOQGfOrY55ivE2YfKnB30BId6d2fuN0uZrUHwGJXUjjIWdv5msturFlApfNjHm7ndL1vS6gH5Sjww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SZVOtm0mDP21W6OBr4ETOJj168in255deNSARadrl8w=;
 b=uhSxlkCqdeshLwbapShEa7Sr7LUZptliU9p7W/t10fdmc/PvhjKRjq2Dydt8GybTXJY8aH5zF2DqwqJ8fLV8S9d5P+fOSW+NBeHclAYNYRedM4jzElPCEwzRCwr/Ty8rbsEObzDKANDwKE7X+9+pxigtSXZWK3wMG7zgRys1w/FEVNNodasDDRUZQ2KzwtfDXvY3OsClHXGRtFo5amMkN1WjZDpOYp358ESyIyq0Yd7zwOZO13m9Pk1+CI6J4BS82vnwTqUrfz4aoMz6QXQYTjFCMAXxOeMOATtdTM/2OKNIh9NjBJmCox7Jy2AP2zuzVeiPeezHvDIKkEttN64fMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SZVOtm0mDP21W6OBr4ETOJj168in255deNSARadrl8w=;
 b=LPQl3HDm3wBvAKjIjF58t2za3Xo82e8Bj1Z6r906w8i9mh6KOwKyO38/ruLdhGh6uMsLfm1sb/DYhOCA9+OcGHNxwG/46vwFu9rHH7bWUo4o/1j4QDemQPFT+8/FAqP7wU9IgR/RmZlHUfYMHniXeqlQGIFdiCTUKdiLPCTRZ58=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DS7PR10MB7180.namprd10.prod.outlook.com (2603:10b6:8:ed::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8722.29; Thu, 15 May 2025 12:01:44 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%5]) with mapi id 15.20.8699.022; Thu, 15 May 2025
 12:01:43 +0000
Message-ID: <500d0c27-c332-41b3-803d-488b8f5ca92c@oracle.com>
Date: Thu, 15 May 2025 08:01:41 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH nfs-utils] exportfs: make "insecure" the default for all
 exports
To: NeilBrown <neil@brown.name>
Cc: Jeff Layton <jlayton@kernel.org>, Steve Dickson <steved@redhat.com>,
        Tom Haynes <loghyr@gmail.com>, linux-nfs@vger.kernel.org
References: <> <9a75be59-fd60-4183-8853-f7fe541c4f14@oracle.com>
 <174725922736.62796.10035875212639959992@noble.neil.brown.name>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <174725922736.62796.10035875212639959992@noble.neil.brown.name>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR04CA0067.namprd04.prod.outlook.com
 (2603:10b6:610:74::12) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|DS7PR10MB7180:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b3ed081-fcd8-452c-6e0c-08dd93a84229
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?OVA0RnFMRE5iT013K1FxZ0Zpd0lCbGg4UEFuTko0UUc4Ky9GMCtJbzNTSmxq?=
 =?utf-8?B?VWdQdnkvR2JORzZmRGQ5QnhqeGI0ZGt4WW5GaFZWc1hBd3k0dnlwMDZmSjQ0?=
 =?utf-8?B?ZFkrUnF0TnEydmtFN3h6bUtlV3lLUXI2cmRtUkhQK3NDNDlvWUo5SUJJNk1S?=
 =?utf-8?B?aDZLem5sSUNWak0rc0ZPVUFRYUlBRmM3cGtDNW5CMUxXbExZTmNhSlRBRXdK?=
 =?utf-8?B?VFVFSVRmV2lJTjRmcjR2TXQzT1FXRkZEMmFsNjJuWExzcjltd3lJeVRqUitG?=
 =?utf-8?B?Z2RxV2YwMUFzY3RRTlJZbGxLUVhRMGFkMFZWRXVOZEhZQ0lKUG5MTEJJZFR0?=
 =?utf-8?B?NElia3BLV25LMERSU0xNMytUWlI5K0xBellPL0Q5V1NXcjZYTi9HZFVub3dR?=
 =?utf-8?B?K3RzZzVpK05kTW1TVysxVnhyT3dJKytiNDlnOXdoODZ5M2R0RVgxZ290eGpN?=
 =?utf-8?B?MmduY2ZRaVNtbVlOTWMzaW9NRVQyajZrQTBlQXdNNzMzR1ptT1VsaEVEQzRB?=
 =?utf-8?B?Qm0wUnRYaCtmNWx5Rm1LVlRxeERSSEtZTERCcVRINVVod0JQazZ5b3hQRGUw?=
 =?utf-8?B?QXFCY0JPdXVxVjMzNVhOM2E0RlIvaWJFekdnTy9ZeUhXay9lNUlqSFNFZTdj?=
 =?utf-8?B?UDY2cHBnR3F1ejliYjhXM2FnQzBaZ0dZVjN6djQ0TG1TVjA4KzE2cEVqaVFB?=
 =?utf-8?B?Ukhmb01id0wzQjNjcWF2SDdnbWk4NmZVc25hak9ESHNqTllVanBuR2V5ZWg0?=
 =?utf-8?B?S3NvNWZTcG9pM0xVYmlQVzZDMFNEUHREaUFpZDRYK1Z4ZFJOdWJBekh1YjdN?=
 =?utf-8?B?K0lYcEYwQVBQR1k1YXhFQTNURTBRM2VIenRmd1ZaOEJmNXBGTFcyaUd6eTBG?=
 =?utf-8?B?VHdCZ092ODVGYTkweDJ2Q2d3cm8yZVdQb0FCSjFMTzVHM2dRdFBMMm9WRjQ2?=
 =?utf-8?B?aGg0R1hOUEdGWm9nQ3ZNd3FvdTBtd2hYTGp1aWUzcUZvMWxvOG1kTmxOcjVC?=
 =?utf-8?B?dFRidFAzRFV5RE4rNzZuTUVuTkZjcEFZOVFlN0IyVDBqZ0R3ekFtNTlTOTU4?=
 =?utf-8?B?cGE4TW5GdXVMVDMyWk8vd2phTWhVZzNjd2pleTRRQVI4bjdUVlRsZ3hoakpu?=
 =?utf-8?B?YXBmVnduT0Y3SXRpbDViTThxcDNHZW5WQlMwZUwrQ2RkbmtzaDJsQjZHelZl?=
 =?utf-8?B?NUdPSWVjZTZUa1J4VGlNNC9mMFBvY3IvdDZOU2ZOc3JJb2pFM08wVk1lWHdL?=
 =?utf-8?B?NzFXTFVJWnA5cEplZXhhdnRMTlRCMmJEV3JPUWdjdkpvd08zc2FYTm5Db1o0?=
 =?utf-8?B?NWl0KzkycTBlTUtoQjY0aHAwc1U3ZjZoOStCdVZzd0UvNEVqY3RaV1BIbnhC?=
 =?utf-8?B?K2pENEdUalY0Wm91QlBQQmdVb1ZHTjkyYldIUEJiME0xaU54MDY5bEV1WVdx?=
 =?utf-8?B?UXRZMEhqQzJiaWVMc3JEQ2YzeDVTclJQZjNua1RuZEp0bkNtUERYdzd1QTZO?=
 =?utf-8?B?QjRvMC9sa1Y4eGdnbGh6MEt1cHlRY1RneDBjSnFWUWtPYjlxd1R6cHRDRFls?=
 =?utf-8?B?VUUyYXYzb29SQlhhNUdpZ2lnQk5ab0ovQzJCWXU5U0d1ZWM1U1k0RDJoVTRn?=
 =?utf-8?B?REd6b0xYS3ZaQlpSVngrb2lkUVBadE9xWURjYlZDOUdRbTF3LzZ4b1NFdnha?=
 =?utf-8?B?dkVuZ2Y5Nm5BWE83K043OVJPRC9oLzEvMFB0aWwvMnJ3MmltcVZmaTdtVVZW?=
 =?utf-8?B?VlB0cVAzeUlMaGRTZHR4YkgxdWRsQVhMekNrVFJYQVpqbXdGSjN6b2hWYWEx?=
 =?utf-8?B?SkV1WW1uZ0UwWVMrclErWnJzYVp2UkRuUW4wVTlBTFZNRlBFRllUbVBhRWVM?=
 =?utf-8?B?Z1ErMWhLL3dtclpMclpjSnpKZjdhMElCbkkxeCtxcTJmZS9HUUpPclg3WDVi?=
 =?utf-8?Q?fwwJ3KRh/yI=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?L0JURVZTR0FDREFLM3djK21GTkFwYnFBSWhMa3ZXc1QwTDdXcVE5OEhZZFhm?=
 =?utf-8?B?Q2hHdFd5NWpHaXY0aks5RUR4bzlGMTFyZjEwSktNelQ3cHdVWEE4QnI0Tzd5?=
 =?utf-8?B?U0ZpY01jQ2wxWlB0N1hsSmkwWnltS1ZOQ3BYUGdNY3ZhY1F2RlhIbHQzS2g2?=
 =?utf-8?B?djE1VS9LSlFPM3RwSnFqVjV6S1VuS1A4VS9KUUsrendNZ1JhSHZGbzdWeVh3?=
 =?utf-8?B?cTBhOVJ3Ni9uUDE2M3lMQnBEUG1WNEtNa04vRkFKSnhNZnJMWlhwMDdRSkxk?=
 =?utf-8?B?OEpNTmpsVjQvdURvYjRjZE1ZanlPTHlEUVNlSndYUndrR2F4S3BhVUoxbSs1?=
 =?utf-8?B?Y3N4ZXZJRUN6THMvck9xY3N5T0RPZTlKSzZuR3JreWorcFMxb2FZbVlLK1Fy?=
 =?utf-8?B?WkJyS2xSVE1OM3RyanBCaHNmeVl0N0VBZlRnRWdFbEVpZG80UXVGSkNoMjZo?=
 =?utf-8?B?RUdoVVQ1Q256bTNRRzZXcWdZYk40aGI4WTdHY2NCcElyc2pyaG52VGF4S0VK?=
 =?utf-8?B?N0phZXVTckt1Nm9jemhCeGN4OTNUSUtqYStEV3BUbC9yQXV1dytWN1hCR2FJ?=
 =?utf-8?B?QWx0MXJCdEMvVmNlVlBVV0ZITWkrRkx4em5Dd1BsR3VkMHpPSlFYN1NrUjVF?=
 =?utf-8?B?MEUrZXYycDBQUXdLYVkyeWZMeW9HUTF0VzMyWmZvbHRxM1crVzY0dGVCWith?=
 =?utf-8?B?TS9vNWVtankzeTh2U1pINWRCaDNCSTNLbUFkVlY2aDk3TjdWWWRNR3dQZ0Z0?=
 =?utf-8?B?OVRnV1ROR1BPKzUrMW1URzRySXh6N2lJbEN2VlZiSTgyQlM1RHlSZXVxbVI5?=
 =?utf-8?B?QTFzdFh6VmJoaDhMamZKUkk4czR5VXA5aTVoRW5NM2NnZGtxaUxkK3dmd3Z5?=
 =?utf-8?B?NitzS3ZSNVByV0lxa0lSTEZOUkI4OE0xZURyVTgwWHJPdFZiRmd4bDNhTFdm?=
 =?utf-8?B?T0gvZ0pvZjJ4RFhVendDNWxWaXRRL3hZa0JhQUpUWWxVZk5mVUx5TVlOZ09t?=
 =?utf-8?B?aFlESXJiR1VmNTQyYTExcXp1aldGZisxYngyL2xUbmM0NFdrY2RYSnJTeEpL?=
 =?utf-8?B?T2V3dS9lMmM2SVA4QTBjcXpKY0ovZjJjZktYaWNoeGxkYU5NOUQrSjdSNFND?=
 =?utf-8?B?OWMwSVlwbTNWaGFhOHFKbHZDaFFOYXprcnhIZ0Qwc2swTk1VRHB4STNCM0dj?=
 =?utf-8?B?SEd6OEZDWWV2d29sZkRORXBPTEI0UU01eENMbTNCS2FHeU5maG9qdEVSQndw?=
 =?utf-8?B?L3hjMzdPWFI4blZXRjlTN3V2MHQ5bld1a1VJdmpTRnF5ZTNTdzB1QjdRU0ho?=
 =?utf-8?B?T05WQWx4RFMwRXM4OFZzKzRtRmdMS0xRaUtERWwwMzYwcUFtY0FWV2tGWGNX?=
 =?utf-8?B?VjYrLzFlNGs5d1ltbU1taWdUaWp4T0hsNEdnTFl5TFF2czlwK3lXM0s1a3oz?=
 =?utf-8?B?ckcydmRKSWpwYW5UK0JBWW02TVZ3aXptN2llZGVKeVAwS2Z2VXpaQXp1Wjlr?=
 =?utf-8?B?MTBFcE93d0hoN2NxYng0eCtSaW9Xd09ab3pYMUdxa1NvZlZZVzRFbnRiL2xC?=
 =?utf-8?B?djdlMFdrRFNWU3RDZ3lWeHRqMERtd1ROZ24vTmVZcXV2bXA1UUdUS3ZQTTRY?=
 =?utf-8?B?Vi9uMXBpNDZuL1Y0azI3ZWVzaU1xK1drYUxnbWxqTHRtWExvSUczWEk4T2tR?=
 =?utf-8?B?c1BkL2JHM2wwMU02TUVRamVXaGZGa1BKeE5GemdwN2Q1R2NSRmxod3pQamNk?=
 =?utf-8?B?ODNFMVlDMEcwYm9MYlNWUTNkV1dCUVJUVFV3bjAxZ0RkMDBNcldaZkpmSWZV?=
 =?utf-8?B?aTdSK29RS0todXlKM0FJM0sxZTlERjdSaWFvV3gxMW5hdDdVYS9VVnhnWHpi?=
 =?utf-8?B?WElRUUlLcjUxVlUwamdhNDVXczZjWHRFMG5WWEYxazg0MDlGbnlDUkNISTFh?=
 =?utf-8?B?QjNUSjQwTjRMcXQzY2oyMC9aT2pyNWhndWNEK0t3TGJLS2FNOWE3OWEzSlJE?=
 =?utf-8?B?QW5RaGorNG1CQXorZXN6SlRoV0o4dllyMUxGL08xd242UzF4Q1QwaWF4Q0V1?=
 =?utf-8?B?TTN5YmxHdHJQaG1sRGI5dXdTdGJkaTRPNXlORy9kYkp2WVMrSENNVVB6SHBB?=
 =?utf-8?B?WDlFZVVZaHE1a0ZpdjdoMlUyUkt0Y3lKRVR2VExEYm80dmhQakRuWktxV1ZG?=
 =?utf-8?B?a1E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	QEsHMu1SnwCPXgqu+x/mIe7oaqqXnwNnuiIcjnBbpUI8MlAC0EAfWpl3kgLM+u5eJ77sxpNXrtqrp14Brq811yMp0iVZGOV9MhxYl5IM3/tbsV1w0dktxniealH3v0mutT3mFuPyldTGmQaZG5iNcdQGYQryAsBtTFXepNy3lhrtNmX9HtvlGZwEHqhRoikP69Dl0d3ktp+bpNUizgfGGy98YSD2TGVBgEdvPf0Mi7PMQDN2z8jvwN2gU2+YFewrGxr6i9F6Z8Sx5eUyAGHeF1nzvvmI6tKQjRPn9QxCqg8EGoM7ZWBAyX09GvC4xe+ubC/gjvdiRfnxEFQiB8iDQtBiedGrUsdUpsEgfgpNUCxPAZTMLli1i8wrd9kTE7YRAp2arvGaU03SAkp+oKmasy4A5TlboUL2vf0pzsfdNQYKZDRDqjBnrmi3Or0U/TZEU4+/waGndyyAB9VvPf4CdSsxfoBfFU2xnb59onYLi440YKY8XqXIihs0z84RaxscCfbn2OhmNHfEae08Zq7sCO3UPLgGZqAa+HIzpjhmeKqNXDfFNsPJFdjn0vjh/6XQLPtreo5IDdTh8meZ2QBwZUiRdvC47Cr79ALHcEtNt+E=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b3ed081-fcd8-452c-6e0c-08dd93a84229
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2025 12:01:43.2332
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lckME18JXRw9GOI0RHyMAkNZX251Vo+G1UqvXT7Gb0DbiczmzJMx497WowZToQYPc30amGkQGOmF0RMrn+NQUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7180
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-15_05,2025-05-14_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 mlxscore=0 adultscore=0 spamscore=0 phishscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505070000 definitions=main-2505150117
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE1MDExOCBTYWx0ZWRfX4tYUyQczxY2y IJvGrLGo9/jt8B0nW6vqUm7k0TrmyrRaSgAZbiCIMi+I/1ZqGz5tvXa8nmJdpqMZ9FUpWdsczyl QZfij8gPoEbSjsULIv/S969nkaR5w5B7Pus1FV+BQsf0ifEYdFeHPzbT+bCLQfTuBsJkR3kmhs2
 ot9sAkd9xPgfpUE4s78VTN/Wk6A5enRVghmHDx5A61KWlLbpRX85036r0J0slRE3sLfQVocdnXF TguwrRz6RRef+C+6JDbS2IJqPSLone2ECj2d3LbBZgsz8ireMTwHLcqsbgd2VkRNvFHptJ0mil2 gOMSKwNUF2Gml8fvI8797UyioWZ7RdyT13T7zP43uwgbuvborzFybgZwIP30pMCwrQqXE2qc8vP
 l5BQlhHlgpEyP2MAFR+dITsLipgUQlA+SIVB3l0QeN1Ai7O4plhmItdcQn6VT1HwtSGOavns
X-Proofpoint-ORIG-GUID: OWg2TXAOq2MHnwC71U1EnPE4BuPmodit
X-Proofpoint-GUID: OWg2TXAOq2MHnwC71U1EnPE4BuPmodit
X-Authority-Analysis: v=2.4 cv=P846hjAu c=1 sm=1 tr=0 ts=6825d7ac cx=c_pps a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=riIdQ0R3UnnIPRBIx54A:9 a=QEXdDO2ut3YA:10

On 5/14/25 5:47 PM, NeilBrown wrote:
> On Wed, 14 May 2025, Chuck Lever wrote:
>> On 5/14/25 7:43 AM, NeilBrown wrote:
>>> On Wed, 14 May 2025, Jeff Layton wrote:
>>>> On Wed, 2025-05-14 at 12:28 +1000, NeilBrown wrote:
>>
>>>> True. Anyone relying on this "protection" is fooling themselves though.
>>>
>>> As above: in some circumstances with physically secure networks
>>> (entirely in a locked room, or entire in a virtualisation host, or a
>>> VPN) it makes perfect sense.
>>
>> On a physically secure network where all the hosts are also known to be
>> secure, source port checking is wholly superfluous. It makes no sense
>> there.
> 
> No, that is the only place that it makes sense.
> 
> If you have a secure network of secure machines running a secure
> configuration of secure software managed by secure administrators, then
> you can trust that a low port number comes from secure software and,
> in particular, that the UID in the AUTH_SYS credential is reliable.
> 
> If you don't have that security, then you cannot trust the port number
> or the uid and should not be accepting AUTH_SYS at all.
> 
> If you *Do* have that security, then we can discuss if the "secure" or
> "insecure" flag is appropriate.  If you know that all processes running
> on all nodes in the network are secure, and will only do what the admins
> let them do, then there is no need for "secure" with its restrictions,
> and "insecure" is perfectly fine.  However if you allow lower-privileged
> processes - maybe you have a login server, or you let people upload their
> own cgi scripts to the web server - then "secure" is important to ensure
> users only access file that their uid has access to.
> 
>>
>>
>>>>>> I don't see any really motivation for this change.  Could you provide it
>>>>>> please?
>>>>>
>>>>> Or to put it another way: who benefits?
>>>>>
>>>>
>>>> Anyone running NFS clients behind NAT?
>>>
>>> Maybe that should have been in the commit message?
>>
>> Agreed, the commit message should have more beef (sorry, vegetarians).
>>
>> The commit message should also mention that NFS clients frequently
>> exhaust their privileged source port range, causing new mount
>> operations to fail sporadically. This is a well-documented problem
>> and the main reason we started moving Kerberized mounts to ephemeral
>> ports.
>>
>> Generally that's a situation that is sticky for a couple of minutes
>> while TCP sockets proceed through TIME_WAIT until the source port can
>> be re-used by another connection.
>>
>>
>>>> The main discussion came about when we were testing against a
>>>> hammerspace deployment. They were using knfsd as their DS's, and had
>>>> forgotten to add "insecure" to the export options. When the (NAT'ed)
>>>> client tried to talk to the DS's, it got back NFSERR3_PERM because of
>>>> this. It took a little while to ascertain the cause.
>>>
>>> "Change default to fix configuration problem"....???
>>> The default must always be the more secure.  "fail safe".
>>
>> Sure, but this option, although it's name is "secure", offers very
>> little real security. So we are actively promoting a mythological level
>> of security here, and that is a Bad Thing (tm).
> 
> "very little" is not zero.  "mythological" is unfair.  There is real
> security is certain specific situations.

We can argue about "mythological", but it is totally fair to say that
calling this mechanism "secure", and its inverse "insecure" is an
overreach and a gross misrepresentation. It is relevant only for
AUTH_UNIX and only then when there are other active forms of security
in place.

So I think our fundamental point is that the balance has changed. These
days, in most situations, source port checking is not relevant and is
actively inconvenient for many common usage scenarios.

Before changing the default behavior of NFSD, we can survey other common
network storage protocol implementations (iSCSI, NVMe, SMB) to see if
those protocols also use this form of authorizing access.

In the meantime, do you object to moving forward with the other two
suggestions I made:

 - Updating the description of the "secure" export option in exports(5)

 - Adding a warning to exportfs when an export has neither "secure" or
   "insecure" set and allows access via sec=sys ?


-- 
Chuck Lever






