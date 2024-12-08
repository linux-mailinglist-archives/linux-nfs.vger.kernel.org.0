Return-Path: <linux-nfs+bounces-8427-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 964C09E861F
	for <lists+linux-nfs@lfdr.de>; Sun,  8 Dec 2024 17:01:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 524552811FC
	for <lists+linux-nfs@lfdr.de>; Sun,  8 Dec 2024 16:01:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27B1C145B26;
	Sun,  8 Dec 2024 16:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VsOBQG27";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ENJfjj9J"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC69415B111
	for <linux-nfs@vger.kernel.org>; Sun,  8 Dec 2024 16:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733673694; cv=fail; b=rxq7DRgKPYHyUVftdi6kkBTaGhN7bV94M+Y9zMNq2snX8K6SBL3pnr7tLq4w5CZB662lhendJQmYgQM7Yj4lc6i0qPI37XT5bgWYn2fo6JGxyZGSqdRJ7pCdoyLkMf+zB9zQFsAyPHPpHTybvtyQS5yFMeKf1tiz/LT8wlWj4Z4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733673694; c=relaxed/simple;
	bh=yJ6js6fStrYRZ9L4eA1qmtlbvRWhawbHQzL3R16oD7I=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hjNM/nnC+ESTicmgE+/e9x4qP2DQEi9rrQsWkWTQxT8aI37RIMRk9Lg0L5qSLuSJ/rBr/El+PYXFfmnb8VlfzSZeyfWo0nO4v/WihGWMwucXz3CYaCBK0UuqP2F4GaES9VVgSaFaKXRHEhFxfiR8BCEL+bf+0I3sifKbmncY1XU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=VsOBQG27; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ENJfjj9J; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B8Ddur9002879;
	Sun, 8 Dec 2024 16:01:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=jqrH+QDmVkJbPK73xPYfHaFRPuWiLodJsuHPrvzyxLg=; b=
	VsOBQG27an8/EAzxOi6Ez0hf0hv3dMSy7RjtIXnlMmgULFgNDG5eoSAY4E0W+aJY
	u6/w3xSniKyR9kwZ4AgdLPZQBixaxj0ksx72q3iFzS2cRW10s0iqwIxSk+CMVmrv
	W3I5CFgdYPhEXUlEX9asFteX+r3RUeRGbGuzilvx8Fvt055KMThsTiQqFltrFHXy
	uMTxyvKbk551YeVp4WrB43LdUrMGS2NVXGj6fa9iOTezqoFSwwdZMqfZhWIhes1j
	3e4YzvbJkwt7wnPb1AXYm7z0FdX8vXO2wEkxQu8wwDXHXalcw7LnyAKhiNj7mSry
	aGSVBbdTk84kuHqgXhw7jA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43ccy01xgj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 08 Dec 2024 16:01:29 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4B8C21iO035603;
	Sun, 8 Dec 2024 16:01:20 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2043.outbound.protection.outlook.com [104.47.70.43])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 43cct6gfby-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 08 Dec 2024 16:01:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TYsv+pV7nUrPPCgqGqRCRsYUR3PJ6dW4hQPA+v4EcdR31j9VzEjYeqtxRxyRpqdSPVvogdhGMgcukidKgoTK2LTbI8hKJtV7Syim6/GetfATaej7TYKl1oMRylIRoBfbkLxLO84G4TXK1bMPs9sjZkxvZMMoho6oQyDGWE2xQYFOa5jbF1PTaoWoa1J9VpWu62K/OEnekn/2csuvSLA+J/DlwTnJ3IgURU5D3kQIRYMC2khwTMn/ev1wwkGGwC5tx0q3U223t1oGUehHsz1vXPMAZjidT+sFib0hbLwxdRm46Eb5i+p/tLAj3g55LnnwEOnAp4ODzIe8qEG5XiMo9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jqrH+QDmVkJbPK73xPYfHaFRPuWiLodJsuHPrvzyxLg=;
 b=kWioEVbOc5U6gMmqfQ8mHPO3XOZtAwOmdEY8oi/S0jlZbTS/CGPjMlScMh8Rdrnt3fdOfJZWqSxvrOuSxc3MRB381dwbjVd4T9nRcGWo1vg+Vclmvf56Tla8QB0gpRSLbV7PB+xrkhBc9TDq6b6P+4WFXW8NC1vLfIQQXAORqJtP9K0beDPXsvYEAUiqUCt9Z87+FkR8SrjwE7j6+P6TDZf+O1H9/Hq4+p3yNNEzRwtJXDIcKWRUWd3gvozwgOja4z08JCru4zNkvCrJNmsa44ysWsDc6VEApHIRcFaPp0e8/q0KqWnjVrYX9EbFgEmU7bTKx/EOJykrNKvO6xXdxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jqrH+QDmVkJbPK73xPYfHaFRPuWiLodJsuHPrvzyxLg=;
 b=ENJfjj9JZ4xXdlLwuxJ+IZuVZYGghOhgzuaMojkCWsE86m05bUerLG8IBT5csWc4qPxWB4ATc+ikRkqy7+SVFJ5H9eey+BNcVej/8sDEHoI0UOBq8FYVMJVbmr3BcfJ9J94SRCTGYj4YfIEqgyJ0TmCE3VIbmV0rPJLwx44Vc0Q=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CH0PR10MB5036.namprd10.prod.outlook.com (2603:10b6:610:dd::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Sun, 8 Dec
 2024 16:01:17 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%7]) with mapi id 15.20.8230.016; Sun, 8 Dec 2024
 16:01:17 +0000
Message-ID: <203f7399-8749-4553-9168-a287a11989c1@oracle.com>
Date: Sun, 8 Dec 2024 11:01:15 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: patchwork instance for linux-nfs patches?
To: Cedric Blancher <cedric.blancher@gmail.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
References: <CAKAoaQmaf7d01vK4TfR+=8k4CVN-CX3ESPFh88EaxvcOAQDWtQ@mail.gmail.com>
 <fb7bf50a-29d3-4543-90e8-617fdd205f76@oracle.com>
 <CALXu0Uf4fwVRR0n+-_+Yx53rj9omEjq7RVHmQ8PfVRGnxYSQbA@mail.gmail.com>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <CALXu0Uf4fwVRR0n+-_+Yx53rj9omEjq7RVHmQ8PfVRGnxYSQbA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0432.namprd03.prod.outlook.com
 (2603:10b6:610:10e::20) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|CH0PR10MB5036:EE_
X-MS-Office365-Filtering-Correlation-Id: f5ea60ce-50f0-4520-8551-08dd17a18ca5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MkpWZG95QVdUa3VLMGlYYzBQTDI3d3l4Z2NqRXJOT0hJSDg4ZTN1WWt1RGIv?=
 =?utf-8?B?SHQ5cTU0UEFFTXNSeTJlalZvMWNSVnJ3clhReWxSRkNYQzB5WlRoNW5YcDVh?=
 =?utf-8?B?ZmR0bW9RV3Z6ZUYvU1RIWnFKWUQycWRiVUFac0hOYlJBQW04Ylh3QmZVRmg3?=
 =?utf-8?B?bDM4M1dXckZVS1V1aVBZcDhyUEIxWWk2K3Y0SjNGeXVTMFE2THdaamU1MUR2?=
 =?utf-8?B?Qjd1Vnp0YjJaVll4N1dhNmR1OFBlSUVEZ24ybjdia1RJbzhPTld5Y1kxVDEz?=
 =?utf-8?B?cFlyYW42WkRZeUpnVEpxM3ZhbStyYWFZSElJcmJ0NEFpRzQxM0lEQ0kxTGR6?=
 =?utf-8?B?ZVI5Z0w3eUt0MEpBN3hLaENSUlRhNTNnSUY0YmtmUmVQTjQvcktPbVZNc3cw?=
 =?utf-8?B?bUVuRWw3WkhOd21tZEtLMU1QY1VKRjg3Rk5RcG1WSEU5Wk9zVGxZOFpBU0R3?=
 =?utf-8?B?RlNVQXBTcEFmMTdVSXdDcG53dXdMaU51czBmZ0RmWDEyWVNJaWExaUQyQmV0?=
 =?utf-8?B?czQwTEFCMlJqNEtXZ0FIa0o2WjhOTTRNQytFOWJEeG5oelY4MjRUTTRDWnc0?=
 =?utf-8?B?ellvMlNMR2plWHp5a1NjSlFRVEhDeHZUaTBNRFdZS2RMUEVMNXpWaGZQRzc4?=
 =?utf-8?B?Z3U0SEs5V3R0a3ZiZHVqYjBVQmo2dkNJejZwMXAyQXdzbi9rT2NqM0JUYkZS?=
 =?utf-8?B?YlhMS0dlUWNncnJsaEtOUWtUTXFGRGFibnFucENWZzV2eURTRWkySC9FblFo?=
 =?utf-8?B?bDlaakJmMVAwSG5raHFDV3ZORWFGcHA0MVYyNTRtWHhsZFJsaHJxalg1SE5M?=
 =?utf-8?B?L096djdBZk9MWktPUTRvcUxJYkRpdDkxU1Q3Ukc2eC9qV0hxaHFIUWc3b2FC?=
 =?utf-8?B?eEd0U3pPTlJqb0pHMGIwL3dtd3VjaGo3ZEV0TzBwSnJ1Rzl3V1M2VEhuUFRi?=
 =?utf-8?B?MXEvMHR3NjJzV3pkb1dmR0xKQVJSVVNJS240TUhLRlcrL09IeVFCTlZZUDZL?=
 =?utf-8?B?K3dQalhWQ3luM0xwc01hYTQ5bXIrS2RvaW9JSW5oY2U0WjdzMG52bml3Q3ZQ?=
 =?utf-8?B?YmZTMU1OOGx3QjI1emdNbmh2MmY4aW5tR0JCVWtpUXF1MmczNWtkYVAxYzlw?=
 =?utf-8?B?Q0prY3prZ3lNQ3BDOXB1c0NXNWQwYWgwaDFxVUNTZzJuWlArM01Ndm5scmZU?=
 =?utf-8?B?SGxaZVZ0cXZKV09ET1V1cFBJZytGaUc3SmtyUzJyR2Z6TVJDL1IyRU92TWgz?=
 =?utf-8?B?Ynl1SEtJVEhpbzBLWitCaElTYVpjYVcybWFzS0Yvb0pVQWxweGJDREdsZmhE?=
 =?utf-8?B?Rnd1MWpaR0NVdHYwd0xaVXVheC9kMkdYSVY5c2xsU20vRlJJbmxUak9Hb0Zu?=
 =?utf-8?B?MWlrRzR4OWFjbWQvTzNwMDRPOHdndUl3cERPYklFMFlwZ0NuYVJBWndoSHpC?=
 =?utf-8?B?V1NjaXU0N2duNi9UcEU0NDM4TjYxemxtemEwQy8rS1FCcEYxQkJzbjhuMFV3?=
 =?utf-8?B?NG1Qdm5Xdnc1QmZlQ2RGQUVwd216Q1JhTHlXeXZvS213T2tKR2N4SUlmQUky?=
 =?utf-8?B?dlRxQUkyMU9rdC9hOWlHb3pSVDRGaENoWDRTSm43YVArUVVjSmhCNEtnZUZz?=
 =?utf-8?B?aVZuMElSWityRlBCQ2VvdnZNVE9sUE9rQzdDd0Y1Y296TGswRjNIRFpJcmV6?=
 =?utf-8?B?c0tvWHM3cjMveTFRcE5GREhTK0w3dTJUaUFtbFlYZFQ3cUlrVFZhVkZYZDNO?=
 =?utf-8?B?VlFXUSt1SzBHcjZnazlWNVRaVVdsYVB4T0VqUWJxekc1dlZEWStsK3VrS0R1?=
 =?utf-8?Q?Xi1So+a+j0oh13ucey2LH3apX1rKAcLnu+NN4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VzQ1N0ZWNGNncDFsS3RmWFh1N1NzM0NIUVNXRzYvTDd0T1dWS0l3YnZlbUh4?=
 =?utf-8?B?VVV6Zkd4Q0dMZE16VGhkK0tZZmxoL3JVME9VTzIwbmJRMFVuRHgwQXZMM0Fy?=
 =?utf-8?B?dXJiVGhMR0FGVnhmNlF1YkJjdklyNHJBKzdXU0pmWkRSNzljUnpCU3ZXK2tq?=
 =?utf-8?B?OUV2U1NBdFUrRm5xQlozWUxoR0pWcWRFWDY4aUdmd1lVVytBMjZKUTB6ZE1T?=
 =?utf-8?B?ZlBnVE0yRHZYMjZLcVdrejh2dGQwb254bUN3V1FKUUd5VGt3Qk5YZllmcmZu?=
 =?utf-8?B?N0RSQXduM1lvMU5Rc0ExVjRXak5mUmNvcFhTdXRKK3p1ajJZaytmd0ZUVnQ1?=
 =?utf-8?B?WkpuNXVsNXZEV05oQUI0ZSt2RzhrOGFuUjdYWkg5bWk3bS9sRFZqK290VFlT?=
 =?utf-8?B?THRhamcxVDVQS1NJNWJUUEhuZmRuelVZY2tFVUMxUFdieVJxanBlNTI0UkdS?=
 =?utf-8?B?dEMyVFRGa2t3N0lHVldLNFBBZHRZVXNKVHBxU1NoTHc0Znk5SU9Dbzdsd0g0?=
 =?utf-8?B?QVFDMGQwOXdUdU1jUEtHeDFOck4xZTJRMWc5UHVMQjZQSlZKd1BaV1F2a0hy?=
 =?utf-8?B?OCttTzVOQnNPV3ZZUUNycFFmSjVibGQrWjlRSVZId21QMXBCbFl1Rm9MaFhy?=
 =?utf-8?B?aFFEcDZyTTdQejRiNGtZZ0x3UlovOEw3M2s0Q3U4a29SOUduVStkb05jK3V3?=
 =?utf-8?B?OFZRK2ZQYUcrODNEU2p1WmZrM2VxeUFGRU9yaTZvTXIrYnd2dXRBVVZuYmNy?=
 =?utf-8?B?VFkxVFhlVDY2NHBsb3pWRldESlZ2aXlrZkNGM2ptZFZRVk5QY3BRa3FRQzBP?=
 =?utf-8?B?dko4TUE4SC9sWXdIMzdBT1p4c0FtWDNWdGJaRWFCaHhIUnowdEpVOEM3WVNU?=
 =?utf-8?B?SWZzdFVlZEFvZTVFTW9hY0RnS0dqLytjM2l0U2dZZGZ5dFNJTjhwaTZyeWZF?=
 =?utf-8?B?bkM3d3NWRWF0ZlhwNXAxa25tQzhmRTlZOENSYzM4a3RzTTJDbXFJdGE0Wkxo?=
 =?utf-8?B?S3c3T25NVVBNYzUzTkxPVVdTY2xoL291QVNKbUlmWTYzUmd5Z2QvN2RncjVJ?=
 =?utf-8?B?bDRJM3BWcEdRR2ZvZTZCRHN5aU9EQlRiUnpIdHVwbHArN2Ixa1FtT2hvLzdO?=
 =?utf-8?B?RkRPSlJ1a1dvcnl0RWYzaVd4TjJqanBReWhqbC9NVnJBNkJjMHkxNnA2b29P?=
 =?utf-8?B?RWdmS1RqVVFUUVRJRWdIK2V6K0g4Uk9JY1ZsV2JCT2hjSGNhNHR0cFhvNjRM?=
 =?utf-8?B?RWhhMHZ4bEpwS21WUWRCZGJNWXQ4VUVXVlZuK3NTeHNWeGpId2lrSm1iQ3p3?=
 =?utf-8?B?UUhlS2dQMGVwQzVNUU05NVIxdXdBQ0UyVWVJc0JJM1Q4cVI4ZlZGZFBuTTZn?=
 =?utf-8?B?ZjkyVlhZSlFBTkpGU3RTL2VrRjcvVzRabXdBbnZXdEtJem1mUW1kanNmSWlY?=
 =?utf-8?B?ZVRRcUlWUXJHWW5XbUE2Ykx2Q0JPQi8rMDZPY3V1SFVqMmxSWXdFNWZQOEN2?=
 =?utf-8?B?NjZaNnE1RTBTak5UTFNQMFlqSE00RTg0VURIQnAvbGRuQ3IyVUo5Y1hhVllI?=
 =?utf-8?B?MXQ4TURvT3Nqdi9GZE1NUEhvbmJ2UlFZSUphbnlUTVdScEk5Mkh5NnBYRDJJ?=
 =?utf-8?B?bkpKdTA1S2Y2M1hHVGFGVGxJTUZZaVFaYS82cEFZakY1cUlOd1ZUU1E2OWl1?=
 =?utf-8?B?T29SR1E1Wmp4Zzh2ZmZvRHBUQk1TWWtXaERQQnc0bHFwZEh0NFVTeTc1M1Rv?=
 =?utf-8?B?VWdManJKekRLRFdCM3JNdGZRZEtDRExPN1YxdGpUbERTcmNSOXhCeER6MUI0?=
 =?utf-8?B?aDFmcUNVaDdtKzJpQk9lcmppbHlCTlZQQ1AzUGx3THlWTGVuSUFDalVEQjly?=
 =?utf-8?B?cm9WUXNPSVZmOWdXZm41dmw5S2ZjalVIcmdSK05hNXZ4Nko3dmZhaGhyRVJn?=
 =?utf-8?B?Z1BsZVFTYVdHZ3pQVHJOUVM0QjlUT0pVc0o3dVVoaGlUdHBneVBVZEhncUlk?=
 =?utf-8?B?S2FFRmMwTVF0eGw2K00wRTJBdk84eXppSm10R1VKbEtrUUp5V1JZNkdKdFRQ?=
 =?utf-8?B?Y0Ura3lhcmVzS1pUdzlZUGVJaW1WWlQvQW0xNys3bXZuY1FBcWZqZzRwdlBo?=
 =?utf-8?Q?zrb8Yy2c6ZQjgnbKds/jCc/Zt?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Pd4imeQhkf1dUHHWU8g+memrZiQWZnI4mBN3cZArC4ocLjJMCOLzqzpNPs3EONnKqCyi1uil3+XtmNB5ye8gxtY9mseYTT3TrQf1WosFvsE/2k3aa+Aj7FDZwqaYkToC6UUKmMYGfSo29PO17TNnFmcyyp7e2T9pkW9dSHAf587A27OEY7miMvEzhByddicGs5QWaLyyZpURELVqFlotq8kox96nmqGByX4/e6JDCEFq9OngnSbB6B4H6Ke2i1K6RWGhA5+qjsjJkymkylKnNMqAqSd8HEK+xEByNJGtpmluF/9Cgs3cWJsdJnLOYRbSvS8GnDYniR6687KYznbUU5anka+u3AoXdfOCdK4lgWIVwcON6ROxh2s9m1Xom2N2OdBgaRp2M+ytgUJ6OPCMr9b7pxpHVxN30BRzgfiZZmF9Whu5QJvq0oO2tCL9Gsy3UY/FgQlX16InM5hfekIXkdDo7weox9skGml2X0XA3RJ6NWgYGXMKBAqpISkltHtq04fGX6HuTySK6qi4lt9fGLtv7m6Fshz1nad8LZZw7lwO6kpUVlkjlk0cdji7uG5lmiRcLYs4upXtzgUrcbUPAEKaGh/UQXLdiPNDFeP9iN8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5ea60ce-50f0-4520-8551-08dd17a18ca5
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2024 16:01:17.5085
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: etMQzGn35kU6Tc9xMKQKnUQaTjjGpTA9iDuczURryBdpCLu+mUvC36EjB6tpig1U5tjn8fSHmWGNts7xhLckew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5036
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-08_07,2024-12-06_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 adultscore=0 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2412080133
X-Proofpoint-GUID: qJ-19v1n3CMzhunYzlq54G_aOpuvJMGQ
X-Proofpoint-ORIG-GUID: qJ-19v1n3CMzhunYzlq54G_aOpuvJMGQ

On 12/8/24 2:31 AM, Cedric Blancher wrote:
> On Fri, 6 Dec 2024 at 16:54, Chuck Lever <chuck.lever@oracle.com> wrote:
> ...
>> The white space below looks mangled. That needs to be fixed before
>> this patch can be applied.
> 
> Does linux-nfs have a patchworks instance, like
> https://patchwork.ozlabs.org/project/uboot/patch/20241120160135.28262-1-cniedermaier@dh-electronics.com/
> ?

Yes, currently unused:

   https://patchwork.kernel.org/project/linux-nfs/list/

You can also view patches that are posted on the mailing list
via the lore.kernel.org archive:

   https://lore.kernel.org/linux-nfs/

-- 
Chuck Lever

