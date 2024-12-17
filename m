Return-Path: <linux-nfs+bounces-8635-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 26FB59F5716
	for <lists+linux-nfs@lfdr.de>; Tue, 17 Dec 2024 20:45:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FA96164D6A
	for <lists+linux-nfs@lfdr.de>; Tue, 17 Dec 2024 19:45:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D03131F9AAC;
	Tue, 17 Dec 2024 19:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="i5PLuV7E";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="gj6hENS6"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF5E91F941F
	for <linux-nfs@vger.kernel.org>; Tue, 17 Dec 2024 19:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734464685; cv=fail; b=VtibcMVR14/E6vyTDZp+fld8WjgjEzyua0t1HvCqCsvhC7uzdwso0+/Qnc2oCB1K4qxeiiysrwBav5Ist8rYF/sCWrAIGmqaeoZyxe97NgxotJV8zY3o/qoC2sW1kDj3GRnLgvi8g0hH31bh9kR1R0OJJRlI86trZC8sbDADOGE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734464685; c=relaxed/simple;
	bh=/DiL0NzByqeilHZpXkPZkMz1z15VcHb6WxtP01RTCqI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=h6ualy7YAsF+aY1DtweXxCmtj5QIHwSWzbVRBlhClBgOe0JOjSFdyOLNiEIL+5BoDE01nUXIK7RJnpEaX9+F7pSZjsmyAdzHrhsZXCn5Om3vMjuDtLZhPxNqYgxmYwPxQl+r4VH/YaNcZmzlDyLJIKqWp99AMTc40AZJReOpYSc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=i5PLuV7E; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=gj6hENS6; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BHCuQ4p012368;
	Tue, 17 Dec 2024 19:44:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=l1SlBLrRRsRxTJZQ8EkzVoDmLQfdU6yaBTqtXjwZCOI=; b=
	i5PLuV7E+d1eruyAyP+JqC10USuL3mEinA1lhJEbHOgPdKkpvJe7Ds9TJCoWNN/w
	EMtPRPXAh8yAAL4LMmHpwaYiNaeKQSMMe+FEvMEIa+0Ww4vbXuxxk+H+JNedCH7R
	jxhha8SbPbZLHzRBxfbmBybUzbgpmghjLvp5bP1Lk5vvOi57EBz7k1mAyb0EZQug
	lwz9UrLDbxZvbiuVyelpfKc2yNCwVO3i1oUlxdQ5SBqcxwiI6o31bi+eS/TboVDa
	ywWzJYdGAwBMP0N2KhC7eXWuDzxhfhVaBKfdR0hu5DQCm0QKcyeaEVvPAfypoFqz
	wA/YhXDt+TrtcRe/f1JoZg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43h0ec6wab-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 17 Dec 2024 19:44:38 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4BHJLawL011058;
	Tue, 17 Dec 2024 19:44:36 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 43h0f8t23r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 17 Dec 2024 19:44:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uGlI8vFWC7ipc/F/lEMazjpo9/j9Lg9NA19hmGoX6MHjlO3SD5kRxOApw1kY/BumOLb4eCNUG9xkbj87BvPpPS6gvpBO93mL6rZGhndT4tNaOwava0gS0hBdLj8MA8cSJg4WuEJaDGakAFa1mMEV32J5BV/JKoYqA78JfwMmPR28e22Vk58VsXMgLYciunq5nLu/UW8vSOf3s0LbF4z+5h+AzY25PLVMPpf7pkLLlEZ+zkJJBE240Avh2kdLynjhhtubZ7fkg2aKlBoXETAkvgalfHXdYTSEFc3fw/nSDu0UZDF4M/Z7RlnP2ozDZQnD2GFtBEppKG9sFdwJLvaqqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l1SlBLrRRsRxTJZQ8EkzVoDmLQfdU6yaBTqtXjwZCOI=;
 b=pseKO8dEawLiKAXf1lFvNHJRJRhQ0V/A6oR78I/zy3wjhkAuMW6nsUf9VLy/L3z/N+lZRpZbCUIpYGPc4/zl7MnvquWZGwXuEw+O9vIhZfrSlq4JflgAGlVd4Zvc2idC9Ks9tPrb7YEYEnIFTGCmPd0g06l/fKkQPdH+vCGBKEZfEWOshESQEUZLTTovTDOkk9xKPodjBUoCxWY4LQtZe1jGTPSzd0M83RGx+nQmIhCHvR3n5wvAz2/3VTFFzVq9Qt3+0Pi5GDFRO+CbwjWa2/iJup1bkaV0Bp3tRA2cHYgIwiFoJrgXHR8sIZPpdEO3Npyfxyh/8xd/88ofT7H19w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l1SlBLrRRsRxTJZQ8EkzVoDmLQfdU6yaBTqtXjwZCOI=;
 b=gj6hENS6ZTsc7GbiLPnM3wCDgUD1kYxbA1mMjYi1qkD07jpx0us4ZcdW77bj4jW2BOtBTzk9+5masObAHLgN6rxdkClMHlZmAYxiOFIvG4b6+p3kW9XPT7W+B4D/2ZM9Cl/9tOcnBV/uCmlvA96KyoDMYPQGtW73+QHXytrOL5A=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CH2PR10MB4326.namprd10.prod.outlook.com (2603:10b6:610:78::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.22; Tue, 17 Dec
 2024 19:44:34 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%7]) with mapi id 15.20.8272.005; Tue, 17 Dec 2024
 19:44:34 +0000
Message-ID: <91943f72-aaa3-4431-aaa1-a6d9a6f13b3f@oracle.com>
Date: Tue, 17 Dec 2024 14:44:32 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] NFSD: fix management of pending async copies
To: Olga Kornievskaia <okorniev@redhat.com>, jlayton@kernel.org
Cc: linux-nfs@vger.kernel.org
References: <20241217192742.97306-1-okorniev@redhat.com>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20241217192742.97306-1-okorniev@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR04CA0007.namprd04.prod.outlook.com
 (2603:10b6:610:76::12) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|CH2PR10MB4326:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b39aec3-c737-4837-eab2-08dd1ed33b99
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SUx3VUJYci9Qb256cnlvenBFbk1OVHQ4aGNKUWI4d2RKdVVsb0R3cGltem9G?=
 =?utf-8?B?dlI4R0paRTZqcFpERmdINXZ5YmxoenM5My9tNU03YlltRytPOGhMSGFKVVEr?=
 =?utf-8?B?c3ZsY0tDemhTSlJkMjlhME9IcFVQTkNYQU5SNXNNdTkwMk5xSlJUU0Z2Q05H?=
 =?utf-8?B?VVRxQURET0NyRHdUYUhENGc2VGd3YWtId0FncEpCWndtb280clNodDlTOFVN?=
 =?utf-8?B?U2svSWtkM09ZYm1PNUhubjFuUGV4eVlqS0oyNzJjTTcyS3J0SHJiWjdnRUhC?=
 =?utf-8?B?SC9QZ0VseUswRVBaNmpZVWxqWERqRGZHSDYwY0VvdUdnWTVZRGJyMCtUSmtz?=
 =?utf-8?B?SXd3V1VNWE4rWVFnckZsdXNaekVueXNicEo2NnR1Z0cvQmxSWmcyRG96bGEz?=
 =?utf-8?B?Q0ZvejJlQURKSFVSSTI5bEREdW1hdEE5eGNZQlVjNEZ2SnUrUUZoamROV2lX?=
 =?utf-8?B?VU9qOXl5MUd6czBaR2ZNenJnUldYczRpUnY5bVMwQVhvN3YrT0ZNem0vZHJG?=
 =?utf-8?B?N0l1aC9lbWNPK2hHc1AreW1lbDc4OWRRckJuSjlzdXdJRmxYN04yMmF5TlJU?=
 =?utf-8?B?czQ2RGhvY2E0a2VYY1BTalNRYWlhRFEwUVZCaW9iRWVsdmI3d0NQY0lKcWhh?=
 =?utf-8?B?USt2WFo1SUhNUW5uU0pYaHB4V3JpTlVqazVTUGZFKzNjUkpVUW5uTWNoc2ZN?=
 =?utf-8?B?MmtqNW1XbE5DS2tVc3lCTmZSUjZ2YWtDQ3ZydkY2Uzh3ZmRJYytrSlcvKzVS?=
 =?utf-8?B?WTVDRkhCR2RTVjlGMjFlY0tBWWluWFpnOVVmelV3ZTh1V1hWM291TmhUbEtL?=
 =?utf-8?B?aGw3WklNR1QrQ1FvUDFFT0hVY09OZUQzVTdTMlJ1YXRFc3lwZC9pSEZ3SDIw?=
 =?utf-8?B?MlZoVXlSb2F0SFkrUCswMUFYN3BPR2tyM3JISzRnVk9adGR1cXJTT0l4ZExC?=
 =?utf-8?B?ekYrR0pGbmMzMGNWTUllcUpaZXlCdmw3TXpoOW4vemd1WEVtU1REaDc4aEdI?=
 =?utf-8?B?VS9COG9MVEoyUkUxY3RacnNKcnNMbmFFZUdjVk85WmxmNEMxQzFJVHdqK2xp?=
 =?utf-8?B?bnd6YTFIN0FSUVovdkVyM1dBUkJVcWt1OHh4TXRsdFNFMk1xaTdBdFc2M3FZ?=
 =?utf-8?B?RTFjOHhUS3U4aDNWeFk5NUo3eUczQTQ2RjhETGxDaDZhNUc0a09tTlNkamVy?=
 =?utf-8?B?TjJSMmZzNzFKSitLVisxV3ViY0hWMmtTRDZmdVVpQ3M3a3hvU3JiaTdkWlJL?=
 =?utf-8?B?ZnpDVzd4cDRJTHRnOVBDTEpMenRkZjlNODlUQlNOUFVqYkJLQ2dHeFJKV29K?=
 =?utf-8?B?cmhiMlJaTkx0Y0habnZicnV4Yk9mZUpQSVErYWNHdWQ4OEZDWTgxZlpydHc1?=
 =?utf-8?B?cnNJdG9KTUNWTElpNFdhUFgvak02VlhXdUpVc3ZSVlJ6UDhMcTI1bzU1dzla?=
 =?utf-8?B?eXhGMnVSUVNuUXp5bWhZOGk1OHE5ZmxlZ25uT21RU1ZBMFNEcGdYTGhDRzFp?=
 =?utf-8?B?YXgxTzRHWGFuZ20rL1VWU0ZuZzBzUUY3OGF2OGUrSGJ6ZlQ4eWcrWWxZbGFB?=
 =?utf-8?B?TlhBcmJicmd0VUd3WmEwejJpeGJadVc5SHFiVFp4dVBONEY5dDVxVE5xUDFP?=
 =?utf-8?B?ZHdVOHRPVDJwQmpSblVpMTNmT1Y2emJvakpWRGRLTkZibUZMTTNBVWFlTFd0?=
 =?utf-8?B?amJvUVZGNHdkRktLbkk4OEdZcG51Q0tUZU1IVHR1UTk2SWZ6N1F4alkxRStz?=
 =?utf-8?B?MkFXZUpjSHFpc3pZczI2OXNkL2dmSUJsWDVNVTdKOTBpMG01elN4ZkZqeUtQ?=
 =?utf-8?B?WkNtTndRblc4WENkTVJCempiOEJETTlMRXpMZU5xa2IxVWl4QlhXMzR3dG1K?=
 =?utf-8?Q?attwDfHUFSK/S?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VElPd0pkYUJweUJESmxiQUZ1UUl0VjFDcnZuSXdUWVl2b2FoMGtybnRoVXVZ?=
 =?utf-8?B?S1EvNkFYR2J1S1BzY1JBMVM0UkhxbXVlbFREWWF2djYwUnZJeHpaeHdrWU5s?=
 =?utf-8?B?NUlXYmh6TlllUExoUzBjb1dNemRVMUF4YVJDbE5obnJaaEJ3ckFweHc2VGc5?=
 =?utf-8?B?bjJFVTdYekl4blRGRmdHd0xKa0grQmh0cDkzZEF4ZVcyZDdUSk5yd0dKalQz?=
 =?utf-8?B?QzA3NDZ0Zm1LbEdvaXUzMXR6VHlYMFpzR3AvZUlaWTZNRFFGTVd5WEVEYmQy?=
 =?utf-8?B?U2Z5QzBTTy9IZHV6dmRaeUkwREdTMk5VWWd4VlF5OWZVOUk5cXJxOFRGVmRm?=
 =?utf-8?B?Y1p3bDJ1MnZkaDkySTVOTjF1K3hzbWhtVkZkTXJtZjBKcFBXSkVSWnpvU21H?=
 =?utf-8?B?dis4dFNaMEszSzdCTU5JS0FZb0xpTHNkVDFYRUNHQ2tUUlBCMmMzM2VLK2NK?=
 =?utf-8?B?cDQ1eXM5dngvOVd5WUxuOWlDMlpHVVhSYmQ2bUVyNXRDKzdUZ3F4YTQzSVVy?=
 =?utf-8?B?SHd1RGQ5b2liOGRTeTVJcmxOTWRHSVY1QVVCQlJFRUpPWXJacjVEQmp3WDBM?=
 =?utf-8?B?Q0FuYmd2YWFDWXZ3Y2Npa1h3MVdWdWJkQW9jMXhhOXlHQVpSb1Q4ci9hUkph?=
 =?utf-8?B?QmM2WmVFa3Y3cGlJWFFncFlKbDdmM1dxWEVmY2prMGo2dElQRmE5cEI2TFJs?=
 =?utf-8?B?dVI4OGo3VEZhZ0xGVTZEVkQ5dTRVMDlkbHZRZjNsRXVWWTRTa3ZzREFGdjVU?=
 =?utf-8?B?UzNyTGsvSCtlWnBERDhNazI3Z0s3TVVPVjN4K0VNM2ZwSmpRN1ArdjZWMUo3?=
 =?utf-8?B?RU5BM05NY3ZCc3RrMnRScDJJM01IZzF3dCtVQ2tjb21rL0dNYWhqOFozNlRT?=
 =?utf-8?B?ZFp4S01pUUc4L0I0M0lQOWllalEvemEzUnRkeHRYYndwdHU3NFJiV0dVYlkx?=
 =?utf-8?B?aTU4NE13OFRYU2RFdW8yT2hzaG9mV0E3Rnh3TjRFYzNZUGdrSnRVc3ZWbGJO?=
 =?utf-8?B?VXpGbGlJY2hYdUZHWTlTWnZMejhXLzF3ZnVMNnpydWNiWE1DbmtsZTZKWkQ2?=
 =?utf-8?B?VUxMMWw0SldaL0RoTGRLWTg2UFFEQW0yQy9wbkZYeDNJZmt3MHR2andwRUI0?=
 =?utf-8?B?N2w0NUVQcmNkVVRXRHpPZE9ObVYyMXNWYnh1TUNnREdKd2JuVytvSktJUlh3?=
 =?utf-8?B?ajIvMXBEY0xNU3pxMVVnMjh6Tk5sK0hGS0NMdEIxYTRuQ2NwaFBGL1k0OTY5?=
 =?utf-8?B?NkJ3UXRmK3ptcUxRS2xGMlMvSGc3Skt0TG9tdUdXTnllSGliSzJsSG0zSDE2?=
 =?utf-8?B?ZUNxM1lNKyttMkIrUy92TE9QSjZCZ0dvY2lLOUYrUk9ndDJjallmSjZSNmF6?=
 =?utf-8?B?MDVVTVZiM28ramhsMVFjSWQzaEw5eWxGQy9Qa3R6KzdMYnVkM2NrUzUvVWhG?=
 =?utf-8?B?YmQveE1HU2ExbmJHZ0crWWxVUjdoVy9MWEdQU2VBMlp5T1hLWkVsOTQ4V095?=
 =?utf-8?B?bWtLNHN4cStWTzhkeEpwdDB0b1c4b0IxN3lQbTVpM2s5dExWRE1FTlVNUkFB?=
 =?utf-8?B?djQxdTcwaWQxdWRwWHZCeW5QSThGSTZOT2E2YmkyOTI5eTllTVowQ3FiZlY3?=
 =?utf-8?B?NVJUd2c2MDh0OWczQ2tEVDNXTTZYNnZNNnZPWFR5TW1TRFZ0UFdJaTBpZUxH?=
 =?utf-8?B?OGprNDhBdDJqNWIveWJMdUhST2drZDhVWDZkZ0drWlN1OXNwVndZN0Z1NGpY?=
 =?utf-8?B?cjJpd3RIM2NGclNRREwrZnhyRmxQSWQ4ZVRqYkhaUUdXRzBGdStSUUdidm14?=
 =?utf-8?B?elFuak50NnFLWXd6YU1wM3FkVGxSenVuZ1g4YlhnVmc3TVdDRXdTR1pkaUFH?=
 =?utf-8?B?MVZqZnRUUjE1amdKcURMU01PRW9xTHY4ckdtTkNRMk1rZjBJdWNDMFFodE53?=
 =?utf-8?B?SGZCLzRwTWVZUHRWblovMEExOCs0cmlmbTV2VlJyNzdMNWh2Q0xTNHBMN3di?=
 =?utf-8?B?cTcxVTcvVXlKd3ZNbEpQbDBpRmtEaW5XSkVqcHdKNFl3NW9KRHlGQ0czL1cw?=
 =?utf-8?B?a1BFOG5tQmViSnh3dFNmalhwMEFKN1VQT3F4Rm1Tbk5iOTZiVmV2KzJiMVRt?=
 =?utf-8?B?NEF4TGxqNDIrNkpoc0t2dGRUQ1lwVzA1VDFwWktGcktvT1pvV1BhdU1EYlZ4?=
 =?utf-8?B?dWc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	TxOGr+YixBe9RJLo0jE7h78INslQVQF4LGVgq36K6D8zLafSoRghL1pdSHd2OfBtN0qho2M94wG8efPLfJyVYCmvdahQHgUzkwP6HimaPXJiycVWtgdpD+j3adNKJlm15DXxzcoC3p631RMWCEqq5hxuzRBdWgdgP1TeEl1Ern0i2bQfCd/bQQAlnwbABHrZ9j6q3Z7e53tNpIia14SXUZ4t3OXrnQJqpXmQgNq003zNyQzS4TIewBGgJ7c3bfvRswS+eBO+cQTURU8WfluTywVgo6OQX4eClK4/d6KGzQCFehBDdE+b2grcMHgZuzTEHkCJ2CxnFJksKAGyTg+Avg7Z6RhlKzR2SmRERjKHKAZrfu6X5AIS8N9cD8+aTTELoq/MKKJyg+Bd9WJ9cx1FOSzuxUo7Tq/Asq6A6Hq5p8lTUbCvT43Yjx66ceviWqDZflQJD4F3mj7M2f04hQGVh2/7ozUVWmZ8nlrDRNY6yBu2QdPUSc411ELlXI57wO9rhdi1+iUz4lLFru0MDm+C/1peFcr1mYphmKXiUF8ZzzhYxYbn3TXs3b5e3SYKv0hPtCybdJCp5fl8DaUNDYBHf9uDlOCEqPD4Vcb5fw4dOZA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b39aec3-c737-4837-eab2-08dd1ed33b99
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2024 19:44:34.4596
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pYwVDTu4S56xqWtGX1AWpiefRLDDESJoUOVGVaXpf3UjVsQRIgigBddv7atg3y2EiBawR9sSACFSaMVW/I3rAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4326
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-17_11,2024-12-17_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0 mlxscore=0
 spamscore=0 mlxlogscore=999 phishscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2412170148
X-Proofpoint-GUID: 44wnvg9FdmCf3mLuCFC_EYaq-tuq8J1j
X-Proofpoint-ORIG-GUID: 44wnvg9FdmCf3mLuCFC_EYaq-tuq8J1j

On 12/17/24 2:27 PM, Olga Kornievskaia wrote:

Needs a problem statement. I suggest something like:

"Currently the pending_async_copies count is decremented just before
a struct nfsd4_copy is destroyed. But now that nfsd4_copy structures
stick around for 10 lease periods after the COPY itself has completed,
the pending_async_copies count stays high for a long time. This causes
NFSD to avoid the use of background copy even though the actual
background copy workload might no longer be running."


> Consider async copy done once it's done processing the copy work.

Doesn't nfsd4_stop_copy() need to decrement as well, if it finds that
the kthread is still running?


> Fixes: aa0ebd21df9c ("NFSD: Add nfsd4_copy time-to-live")
> Signed-off-by: Olga Kornievskaia <okorniev@redhat.com>
> ---
>   fs/nfsd/nfs4proc.c | 13 ++++++++-----
>   1 file changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> index f8a10f90bc7a..ad44ad49274f 100644
> --- a/fs/nfsd/nfs4proc.c
> +++ b/fs/nfsd/nfs4proc.c
> @@ -1347,7 +1347,6 @@ static void nfs4_put_copy(struct nfsd4_copy *copy)
>   {
>   	if (!refcount_dec_and_test(&copy->refcount))
>   		return;
> -	atomic_dec(&copy->cp_nn->pending_async_copies);
>   	kfree(copy->cp_src);
>   	kfree(copy);
>   }
> @@ -1870,6 +1869,7 @@ static int nfsd4_do_async_copy(void *data)
>   	set_bit(NFSD4_COPY_F_COMPLETED, &copy->cp_flags);
>   	trace_nfsd_copy_async_done(copy);
>   	nfsd4_send_cb_offload(copy);
> +	atomic_dec(&copy->cp_nn->pending_async_copies);
>   	return 0;
>   }
>   
> @@ -1927,19 +1927,19 @@ nfsd4_copy(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>   		/* Arbitrary cap on number of pending async copy operations */
>   		if (atomic_inc_return(&nn->pending_async_copies) >
>   				(int)rqstp->rq_pool->sp_nrthreads)
> -			goto out_err;
> +			goto out_dec_async_copy_err;
>   		async_copy->cp_src = kmalloc(sizeof(*async_copy->cp_src), GFP_KERNEL);
>   		if (!async_copy->cp_src)
> -			goto out_err;
> +			goto out_dec_async_copy_err;
>   		if (!nfs4_init_copy_state(nn, copy))
> -			goto out_err;
> +			goto out_dec_async_copy_err;
>   		memcpy(&result->cb_stateid, &copy->cp_stateid.cs_stid,
>   			sizeof(result->cb_stateid));
>   		dup_copy_fields(copy, async_copy);
>   		async_copy->copy_task = kthread_create(nfsd4_do_async_copy,
>   				async_copy, "%s", "copy thread");
>   		if (IS_ERR(async_copy->copy_task))
> -			goto out_err;
> +			goto out_dec_async_copy_err;
>   		spin_lock(&async_copy->cp_clp->async_lock);
>   		list_add(&async_copy->copies,
>   				&async_copy->cp_clp->async_copies);
> @@ -1954,6 +1954,9 @@ nfsd4_copy(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>   	trace_nfsd_copy_done(copy, status);
>   	release_copy_files(copy);
>   	return status;
> +out_dec_async_copy_err:
> +	if (async_copy)
> +		atomic_dec(&nn->pending_async_copies);
>   out_err:
>   	if (nfsd4_ssc_is_inter(copy)) {
>   		/*


-- 
Chuck Lever

