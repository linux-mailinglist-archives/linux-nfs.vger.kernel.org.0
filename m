Return-Path: <linux-nfs+bounces-11948-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 720DEAC6B5F
	for <lists+linux-nfs@lfdr.de>; Wed, 28 May 2025 16:09:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C572F189887D
	for <lists+linux-nfs@lfdr.de>; Wed, 28 May 2025 14:08:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C2AE279331;
	Wed, 28 May 2025 14:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fDyzYY9l";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="JOuPNsAq"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71F0E38FB0
	for <linux-nfs@vger.kernel.org>; Wed, 28 May 2025 14:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748441278; cv=fail; b=qbLGmaLQVn/9CNW39fYQiMb0yYodyuzNMCzMSUgz5nXBDJuTRxQ2gTn05mYIHFhvXj0mljd0qtJ5slf0P8BFwDXtZkx0st3V0rFCHiWf7gi3EqzuJXFqY8GAcs/5IQkcrqsLMPzmJkieVCpAluheFgZA7xqy+zrfh7HQLHB6z1c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748441278; c=relaxed/simple;
	bh=sgocw6Q7kc20G2fVe7H03N6BUuguIeA38Hm5WE4i/5U=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=uEvM08d5ecNNYyLe9yYbY6pGcQB4iVnhzPYZB0r03UVSvHKd3C+gDqqQDwgEURMuPJ8p5FyO0rZWtAL5ynblOLWQsUZl2dbIpN3yz0pLyCY7mYfIUrRYvoSOoesv4QYiM3iW33Ir2jJiW85y7kneXfyqxU7FBJLYaW+uwdaneg0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=fDyzYY9l; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=JOuPNsAq; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54SCqMmN024357;
	Wed, 28 May 2025 14:07:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=v2emqBS4emMn5TA0Wzn+MJ3TMwUhH0p3bJzoQFYlDwc=; b=
	fDyzYY9lAKxLNTSvaeqC5BNXvBrVFc4n95f/TVZn/iG/mbp7Ujmq1c4tVYwQZ6WW
	L6HFGrsJ+GtO4nMhxLwcZkJL0mqT4nrdKRLv2gdTEvgTUHiPKS2A6LpvVakZf8uY
	9mCv0JS/G/FgHorw3yVvn3Xex7nHYgd0i9oyVgnrwQyg8Xgpi13Q72Bi7an8FbXO
	iHzRfFSz5TwCyCe+tFIOKPYXHrdy1Vk3BiXd+tEoGS6uD+r1NjLzJjyyhmELI5b5
	zgagmZxLFhq/qyGcC7WZ7xOhRbZya3bojPyx1w/dTrqXwOw03kT5B4Egz9qoDdLV
	rfJ4zDnMHGI5nSvLkR/Hpg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46v46twxmj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 28 May 2025 14:07:51 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54SE1w4V035716;
	Wed, 28 May 2025 14:07:50 GMT
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazon11012065.outbound.protection.outlook.com [40.93.200.65])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 46u4jbetb3-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 28 May 2025 14:07:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GcSSu5QUYag+mErc8Yqic2OBIi1z1va2Crgus8pTQOPMuBB5kZcLs74XR3INia/pRxRCanMQxaxJK22cILf+qIP7xibKYNWbDSYxqH9U2Q8Ekc3ftDpApXJ6+YvND6ke9gqeEEMc4NGJ1xmEn0h7vsgifXc1J9g5pGu3V+QdqdGR/K3GOjWZbnWc4CaZgrAZ0bcgvoN5LvThAraiXutpt6q39xXx52OI9vcCqFMnLoSzAAJGX9HhLzSE521H3joOIgxWS6iqwncm5FblNCYm9+NRhBHVRurnSRex68n3P0TZgRcOk/IhdDgZdG1uX9LotVPE4aNAb+jjw9ZeRGaNbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v2emqBS4emMn5TA0Wzn+MJ3TMwUhH0p3bJzoQFYlDwc=;
 b=XhkAIQ18VkIv/W7fmb+7boN2UQ5pOEq4luC+UP77eMUYQaD3W1AyBJjz4bikgyg6sTsodGT75/PVjOV5aSpOioC+d57ue6OvwYx7NgHMjA56PwGrphkweUho+Ut+bhVqjiWJjk22i0zj1iAc8uU47j+aXG6E2PBFSjwaLuM8NfJZ6EjkkOSpFFafsy5k585dATFdx1atePSeW1ED9HkCaojzJvAz+UEy86Y1c4Klixm1f3YtJsSzoFbtjMLlbHPmrw9pd+Bs9MKTM7+lK9QwOHOPuqWKCDuGbTni4LcYLiu2PL77R+BBp2zNvsWxGC3LiBHiuJryHSJCmvXDIHfJKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v2emqBS4emMn5TA0Wzn+MJ3TMwUhH0p3bJzoQFYlDwc=;
 b=JOuPNsAqnSImGOZ5AbkbRX4PmTXEpBVrXzUt4qWs1Y8H5Rhv0go2j+0liGJXFvhH6y7EvVViGFT2+sN6P6drFAwm1WX6fGxshvSmB+3uul2H7NrCmYM6jw30mGWAjXFrf9e6rrmRwHZLdjUDZeJeIgH2Mhpwe4D0fba6ljE5y+8=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SJ5PPF2BE4E177D.namprd10.prod.outlook.com (2603:10b6:a0f:fc02::798) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Wed, 28 May
 2025 14:07:16 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%5]) with mapi id 15.20.8746.035; Wed, 28 May 2025
 14:07:16 +0000
Message-ID: <411381bf-5bea-46ea-bd70-4ea76395ddef@oracle.com>
Date: Wed, 28 May 2025 10:07:13 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH nfs-utils] exportfs: make "insecure" the default for all
 exports
To: Benjamin Coddington <bcodding@redhat.com>
Cc: NeilBrown <neil@brown.name>, Rick Macklem <rick.macklem@gmail.com>,
        Jeff Layton <jlayton@kernel.org>, Steve Dickson <steved@redhat.com>,
        Tom Haynes <loghyr@gmail.com>, linux-nfs@vger.kernel.org
References: <> <d539c502-e776-460f-852c-8af9722ad9f8@oracle.com>
 <174821817646.608730.16435329287198176319@noble.neil.brown.name>
 <f679b62b-cbf3-4225-a163-870c65ff0c9b@oracle.com>
 <3DF74DD6-E300-4CDE-B8D9-EECD5F05BC8B@redhat.com>
 <e6daff16-2949-4413-b801-58393d9cb993@oracle.com>
 <93C75052-1CC8-4660-B760-F2FAAAA0393A@redhat.com>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <93C75052-1CC8-4660-B760-F2FAAAA0393A@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR19CA0005.namprd19.prod.outlook.com
 (2603:10b6:610:4d::15) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|SJ5PPF2BE4E177D:EE_
X-MS-Office365-Filtering-Correlation-Id: cb3ad4e4-3efa-4723-9793-08dd9df0f3bf
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?elZpRUU4bjIxTmF5c1laRW9FYXh0OWluajNzb2tJcmkzZGdSS2NNNHo3WVcx?=
 =?utf-8?B?Si9ock52cDdYWnlFTWZkMThIaHQwVmw4RGFtbVFiU01SSVU1R2FCN1JaYmxD?=
 =?utf-8?B?NjY2VzErVXFOSjc0cjVTQ09Pa25wR1JkWCtkQ0NTOGZOSDk3eXpmckVtWVRD?=
 =?utf-8?B?bk9LUUd3clBZTmtmMkZMTDBQdGFmeFgvNDRzcVRmRFF6N3FyVWc0cDE2eDFl?=
 =?utf-8?B?NDVrUmxTT0t2K3N4OEM4U3lvbEdhdDJFU3Y0OFJwV0IzdElLOTZVUitrS1E5?=
 =?utf-8?B?Sjl5dTFhTFZMcDhzYkJzYi9tL1k4b0dPTUNuZksrNjIwcHJ5UWhPUHZsOXll?=
 =?utf-8?B?d0d5bVRZdytrb3NpTk1VTnJ0NDBSR1Z6ZERVQWFDVUtLQ1JrdDdIYXdLQnYz?=
 =?utf-8?B?MmpoSnVCZ1ZpWXFwZzlVL0RjWXNMQnRsKzczSzFSazltdlNmSHJwNEJDSkQ3?=
 =?utf-8?B?cjg4ZXJuM1ZVYWRGZjdrQjVvb1h5Mm1BMU9LYmRYckxZOUw1MW1JNEhPZVJK?=
 =?utf-8?B?U0Fva0tMSHc3ZGVkODk5UTNTQWYzQ2NKRVp3R0greXlBbzJGOENHSXVhZzRs?=
 =?utf-8?B?U0REZXJ0UENEeWRwVGIxNDFSYlVYZXE1RXZMcXpsL0JwVjRFV3RjZlkvbmNK?=
 =?utf-8?B?RnNSeTExem1pcVNxOERVdVRSbHZ0MURnS0x1RjNIYnVBVEUxRytRMzdpZmpD?=
 =?utf-8?B?Q0lFQTJXWWowU1l2SHdkMWpJUHcyRzg4ZFJ6ZUd5WkltRnNKMWd4UUhqK1hL?=
 =?utf-8?B?RzN6S0lSRXpxNDVNUUcvcnROS1hLOEd2a1hiNWxjcnVBV3pNVTJkNnZONkcw?=
 =?utf-8?B?eUJRM0w0R0JWdXNENm4xdVlzQWY1WDAwR0tyV2hDTW9DSjJMdHVPNzZ3ZWwx?=
 =?utf-8?B?MWw5ZnFXWGErTTBpM3pEMTJ0SkpJdHNGQmFmbG5tbUlQZ2haRmQzUWd2eFhp?=
 =?utf-8?B?NFR0ZG9XRHJBT2dUNHBoL0FNbnI0M1pWSHVpTmgzOElPL3NpdkRGcXhSUGlk?=
 =?utf-8?B?QzFkNGhySWFIUDU4NmJqdlZUenV6WTFyR0NOdlk0Z0NxTGxtUEJ2cElPNnc4?=
 =?utf-8?B?amw2N3EzZEEwMTloVktrNjZkK201THNuQ3IybVJPZDRtWTZvRXZnU0pwL2RD?=
 =?utf-8?B?cHYvUVVZbmpGcnBjRUJBMXlRanQ5ZXBVOWdPVnBtYnA1VGdoNTZBRFNVQlNy?=
 =?utf-8?B?SHc5cnUrQkYvZlc2WHliOXpyaUVmOVlzMndKMDhpVmVaUENyajQ1bDdEWlJq?=
 =?utf-8?B?dk1hSXpGR0Z3M1hjMlBvRFVGTDhCS2xCckdUMFp0eStJRGM4M2dNVU5WRzhL?=
 =?utf-8?B?R0I4WUNLazJWY2VEcTlOMkZCZG94VklSYXF6QmV3VjJPcm1nWmZHUE4zYTRX?=
 =?utf-8?B?TUoyemUrclY2QWdVT050ak1vOWNZQTltRENNdnppcTFZbHlBMHBTdCtIejd3?=
 =?utf-8?B?QzJOTjZUWXQ2MGhhN1dQRzUrS09Fd09iR3hnZy9rZ2tCcnVzdWxmODF3TGtH?=
 =?utf-8?B?WHNWVDFRL0RFV3h3ZEpuTWMxRHEyVjVMWE5tKzUyYzNWS29OekkyQWdSRlFO?=
 =?utf-8?B?dVpqZ1RLNGR5VWdwMlk4SEptay9iVTkvTTdud0l6dFplSTBNUCttcXdHWUVr?=
 =?utf-8?B?UlFQajYxUkJDajh0Z1lkSSs2eThkeUVwUzFFQnUzYkUwTzIzUHB1bzVBVERz?=
 =?utf-8?B?MzhIbFFRclE4aEZRdmZhVXZod0NVKzhOeElJWDFLcUtMZnJkK2ZIZDhvaXRr?=
 =?utf-8?B?MzYyNFUxL0JFcnk3RHZBL04zUnBWWWVoZHBJYjAycVl5amlnSlZOMVlIN3cx?=
 =?utf-8?B?NVRTc2RKR3AvQ3Rwb1VLcVBoSWdXLzFpY21WTndta0VxTUFYSFczd0NMZmcx?=
 =?utf-8?B?R3F6UUIwVUt5TndNN2xKWU40TTJnYWI2ZHM2blc3dGVQTHZuK3hlS2txcENs?=
 =?utf-8?Q?N78XW8T8ing=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?TVZYUkt6ODZSelpncVNZb0tjaU51cVJDcGVUOUpaYVFVMklCV1BxVmdEOXVl?=
 =?utf-8?B?MDl5TlJhNDlSa3g5WTBQRUo2QVhkTnJSRkRydEMyQURJTUlDVGJOSHFZRDI0?=
 =?utf-8?B?RjkyWisrcFZXN285MWthOW41TXUzYlpBU0N0K0twMUFrTlNNb0pjS0VvUFM2?=
 =?utf-8?B?bHZETktLNlRmMDJ6RUk2dWtMcmdQZFUyM3RvMVVYN21Fc1FvazRnNCtrMHln?=
 =?utf-8?B?N0VFWkZYVzVYQ1ZVcmVLWUVxd2RVbnBWRzdrZ3E1dm91bzJ2eFdGSHhRSGUw?=
 =?utf-8?B?TnpyK0RXNjRQemhkSGlCd0p1cjZWcWt3UW1jUFRkQkFNM1YzN3A0UUlsbERV?=
 =?utf-8?B?MUNISStYWVBzMXB0Z2lhTFh4ZHFTVTJmcDdPR2Z2c0hTb1lpc3V0Y2ZqeTVD?=
 =?utf-8?B?UFdQQVY1TjA2U2Z6YVgycHVqOUJ6ZTRldEQ1MWxBd0EvRS9yRUxkeUg4Rk56?=
 =?utf-8?B?S2cxSGtFbkRrcUhzRHlYUVhkN2UralA3L29FYzNwd3VHTlNMZXhKTzRkcGth?=
 =?utf-8?B?MEw1TWY3MnNzbVU1S2NCNlJkTmtiMWh4ZVlwVnZlWXRaQ0ZYV0t3Rmo0UWs1?=
 =?utf-8?B?REgyY2Z2bnhOcEhTeCt1K3ZQS0NwVkxITDI5OWNocG0xTkNYZjhMNTc0T3NK?=
 =?utf-8?B?WDZjbXJlNGFRaDRtTkRqWWM4WlNrclI3aUJiYSswUWl1UjFWblVDdGp1UCt2?=
 =?utf-8?B?YzIrQnlSNTlBbnRDM3NPcmxYQnZoeFE5NWd6NHVNdXQ5R3o5OEFGQVRxM09G?=
 =?utf-8?B?dmNMRHIyVi9JVUNWTHY1cE1jL0dtWWwydWg5L3AyMG94aE55Ymdyb2EyaTJq?=
 =?utf-8?B?N25UeEtNWVNpaE1RZTdTVDZTcmFYK2lGd3hTS2Z6RzhtdzErUDF2cEtQZjBw?=
 =?utf-8?B?TFhtMmZEcGZPMXQwMjFGcHZLLzhCblN5Z0xRK2NlT0N0d1hvL3R6R095NjVR?=
 =?utf-8?B?ZjZUVTduMWZsdDd4akdvMW9iRXFkQVFwVGZnQWcySHkrY3VteDZvYWU2NWMr?=
 =?utf-8?B?VWs1VVF0aUhuQWoxMTFCZlhYM1dPTVlIZ1YvYW4yVG91eHl4b0I0blRZb2wy?=
 =?utf-8?B?b2hEeWtlT2lhcmlFWU9mYTZndnR1QVVHYjRjdnBzc1p2MXVkUTJYVjYzbElN?=
 =?utf-8?B?enYvVWtrN1FWVzNtMGxreWNkU0daT0RxQWUvalVEMDcrSm5VQlVwTGtka0Ra?=
 =?utf-8?B?KzJmWExpS2tPRTFUdzQ1RGJVTlY0VGx6Rm5lK1Z1MzErcmlmU2ZiQS9XT1hX?=
 =?utf-8?B?Y2l1MzVDbk1raFlEb3FVbUYzd1g3eHlYWGFFSzFybmZvUE1IVE1wc3NLbmxS?=
 =?utf-8?B?dmdzNGx6VWpBT1hGS0RCMzhEQncwTlhzVHFhV2o5RVB3RXp4TTlZenpNMHdz?=
 =?utf-8?B?eElWU0pXWlBscVhVU2xYNTNHeHl0VzI3R0ZENVhtUHlKeDFXWEhCUnRBb0E1?=
 =?utf-8?B?ckFtQ25NWGkzVVR6TlFxN091R0lmOForRTFrS3ExWit1bTB0cmlPUGpvSWFP?=
 =?utf-8?B?QUtJLzlxU0FOYi9adUNDSmNaZjlTamxpMUxpcG5kTlZmUkpQRWRIZTJTLzZH?=
 =?utf-8?B?eWtLM1VRd29xb2xIc2JjbUZPRlRIb0pWV2JvUTVORHBWYkh4OFdkQ2tSenFa?=
 =?utf-8?B?SjZWU3dLdTZJYW5jbjZYVkVnRlU3bXh5dXpIckU3NzNLSHdKQWV1Zm9abGRr?=
 =?utf-8?B?MjFvenBpdHBET1RLUUZBLzNBekczSzN5dncvQTlvNVNuQldNdGNDcWR5dHl2?=
 =?utf-8?B?eGd3dE93Z3crVkFCWFFLalVDbm1HS3laMi9UYWliQzVrdi9ONkQ2cmZ5S0Yr?=
 =?utf-8?B?ckFoZCtNakc5ZU1yNkY2cmhZMVU3ajgzWVhQZ0tTTlpueW5KbUFpOC9yQzZ4?=
 =?utf-8?B?eEU1NVNuajRrOWVqR0NxSmt4UXdiN2F2VjRKZ2lNdS9BYk5pS2RPcEJNa0Jt?=
 =?utf-8?B?WnBNcXVLR2FZazlJc1NsMTVsL3NCdFI3RTgrVFdkSVIxd2hkazBkT0xUdHlh?=
 =?utf-8?B?ZWpJNjNFdHo2cEFKVWhvVEpxZ1oySnNBYm1KMTVNUjJNQXZRcFNUS1R0KzEz?=
 =?utf-8?B?UzE4ZEtzaElPMHJwZjdZSEtBZ0NUUUhsK2pGcC9IRlY3djNyVlAzbVdCNDUy?=
 =?utf-8?Q?re924Kce3KI2yqs0iisooXQnS?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	QZGzM8PadkgqEe0u5rlGfYylOU3I6hq9GqKibBCzTr4amfE54hPmvbtgzKxksI2Nrp5q0JCz7iOBsHekcL4eh9DA6M33x+fMOkp2RJvQbCii0+83jqAyJw5RDf/Z6sb8kRhbUd+QdWf/BHKN55tgAbNq9wEs7hx+uM6I656Wd0MUP+xic44YgTZFS91O2x9o7LUJLrsPklRDEOCCeZNe57cVkmN2dqBy46QUzQFML0wmB3Q2LXDdeOyf0a+3BJgWV7N7iA/zaWkLMOAMR5rq+0o0K4AA9KsAAYfelQKUVpdQnpfZrKJfYGES5+JURGFATvYIXHOJXYoHp9W5+eed2nOJerf7XgCSnh3A/T6AM6CKL0K8CPeF4uFUggriQLeMjqWShPdeA1vXOIyg0feLjjRJbSkEwareiFt0LFqM7YWK2Rd94Ettr7NHWHyWKLpEZ4GSrpYi+wHuOLO4gZZsbQX4Z/b7tc+QPFvyv/7oly4e8hrNpXpFUzYzrLh+8EA+tZakQ10FaVqjcxoHlTd2asTA3u0ufmwSU2GSoNjQBSxtdex4KaRmZR/io5ILZun6od7qDxOid7WnTnBMUPClQI479zaZw9/NEag+QLljYFQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb3ad4e4-3efa-4723-9793-08dd9df0f3bf
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2025 14:07:16.6166
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S/IlVzgPY1UqX/Zwe3YfL2TAN3Gkkt9PC4CpcEPWAiV4zX6HTkPaddA+Yo6RAO2m0BAbLuK7iHc2qB0qXaNXyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF2BE4E177D
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-28_07,2025-05-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 phishscore=0 malwarescore=0 bulkscore=0 adultscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2505280123
X-Proofpoint-GUID: DhPHjqJePaiZN2HeWHQkBb1gLXg0t-ip
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI4MDEyMyBTYWx0ZWRfX4WYGICIOdToH krJzxsmQ6/HUdv5UmCvTj+yjTK3flbwiu2Ne05fFV7g8WscmP12G5o0bZUDGrFMjT1pVD9QNoki LCG0YND5dgCrBI/Ws/AEoJriniRG5Umb93xCdUs+U23S+uutQBkfqp+2ksd4lul9rfPotoN4kIk
 vBBDptAU6i7I3D2adUMi/oUJe4ZvEqC7dRb2ekRkqUjbLPpKdd457l49fHfzX5O9sosBaKbnJEq qPeMTeXQnJBI2AQW/7oeVUdmx+d5ZdWSzb3n+DdTMCmWeq16ktFH+SP5O5VQBcK3y83W33aiRs9 0p3OJgTGpbO99i85Ike2fL+X8Y6rjjruVZU5jjcwAkgzS55Divdg6JyqNStaY2xvOiKoFA9ysgp
 +J5lg5/9T42Zvy4bO4bdSzNsalfThA9+NG+aBvwn8baazjoixvoNKpqv+BIXMwHw1TcF20z8
X-Authority-Analysis: v=2.4 cv=VskjA/2n c=1 sm=1 tr=0 ts=683718b7 cx=c_pps a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=A1X0JdhQAAAA:8 a=mEza3si5AAAA:8 a=cAMBmxsg1OSceWQwfoIA:9 a=QEXdDO2ut3YA:10 a=rjRlSLlayDNRPJ6elN85:22
X-Proofpoint-ORIG-GUID: DhPHjqJePaiZN2HeWHQkBb1gLXg0t-ip

On 5/27/25 4:25 PM, Benjamin Coddington wrote:
> On 27 May 2025, at 15:41, Chuck Lever wrote:
> 
>> On 5/27/25 3:18 PM, Benjamin Coddington wrote:
>>> On 27 May 2025, at 11:05, Chuck Lever wrote:
>>>
>>>> On 5/25/25 8:09 PM, NeilBrown wrote:
>>>>> On Mon, 26 May 2025, Chuck Lever wrote:
>>>>>> On 5/20/25 9:20 AM, Chuck Lever wrote:
>>>>>>> Hiya Rick -
>>>>>>>
>>>>>>> On 5/19/25 9:44 PM, Rick Macklem wrote:
>>>>>>>
>>>>>>>> Do you also have some configurable settings for if/how the DNS
>>>>>>>> field in the client's X.509 cert is checked?
>>>>>>>> The range is, imho:
>>>>>>>> - Don't check it at all, so the client can have any IP/DNS name (a mobile
>>>>>>>>   device). The least secure, but still pretty good, since the ert. verified.
>>>>>>>> - DNS matches a wildcard like *.umich.edu for the reverse DNS name for
>>>>>>>>    the client's IP host address.
>>>>>>>> - DNS matches exactly what reverse DNS gets for the client's IP host address.
>>>>>>>
>>>>>>> I've been told repeatedly that certificate verification must not depend
>>>>>>> on DNS because DNS can be easily spoofed. To date, the Linux
>>>>>>> implementation of RPC-with-TLS depends on having the peer's IP address
>>>>>>> in the certificate's SAN.
>>>>>>>
>>>>>>> I recognize that tlshd will need to bend a little for clients that use
>>>>>>> a dynamically allocated IP address, but I haven't looked into it yet.
>>>>>>> Perhaps client certificates do not need to contain their peer IP
>>>>>>> address, but server certificates do, in order to enable mounting by IP
>>>>>>> instead of by hostname.
>>>>>>>
>>>>>>>
>>>>>>>> Wildcards are discouraged by some RFC, but are still supported by OpenSSL.
>>>>>>>
>>>>>>> I would prefer that we follow the guidance of RFCs where possible,
>>>>>>> rather than a particular implementation that might have historical
>>>>>>> reasons to permit a lack of security.
>>>>>>
>>>>>> Let me follow up on this.
>>>>>>
>>>>>> We have an open issue against tlshd that has suggested that, rather
>>>>>> than looking at DNS query results, the NFS server should authorize
>>>>>> access by looking at the client certificate's CN. The server's
>>>>>> administrator should be able to specify a list of one or more CN
>>>>>> wildcards that can be used to authorize access, much in the same way
>>>>>> that NFSD currently uses netgroups and hostnames per export.
>>>>>>
>>>>>> So, after validating the client's CA trust chain, an NFS server can
>>>>>> match the client certificate's CN against its list of authorized CNs,
>>>>>> and if the client's CN fails to match, fail the handshake (or whatever
>>>>>> we need to do).
>>>>>>
>>>>>> I favor this approach over using DNS labels, which are often
>>>>>> untrustworthy, and IP addresses, which can be dynamically reassigned.
>>>>>>
>>>>>> What do you think?
>>>>>
>>>>> I completely agree with this.  IP address and DNS identity of the client
>>>>> is irrelevant when mTLS is used.  What matters is whether the client has
>>>>> authority to act as one of the the names given when the filesystem was
>>>>> exported (e.g. in /etc/exports).  His is exacly what you said.
>>>>>
>>>>> Ideally it would be more than just the CN.  We want to know both the
>>>>> domain in which the peer has authority (e.g.  example.com) and the type
>>>>> of authority (e.g.  serve-web-pages or proxy-file-access or
>>>>> act-as-neilb).
>>>>> I don't know internal details of certificates so I don't know if there
>>>>> is some other field that can say "This peer is authorised to proxy file
>>>>> access requests for all users in the given domain" or if we need a hack
>>>>> like exporting to nfs-client.example.com.
>>>>>
>>>>> But if the admin has full control of what names to export to, it is
>>>>> possible that the distinction doesn't matter.  I wouldn't want the
>>>>> certificate used to authenticate my web server to have authority to
>>>>> access all files on my NFS server just because the same domain name
>>>>> applies to both.
>>>>
>>>> My thought is that, for each handshake, there would be two stages:
>>>>
>>>> 1. Does the NFS server trust the certificate? This is purely a chain-of-
>>>>    trust issue, so validating the certificate presented by the client is
>>>>    the order of the day.
>>>>
>>>> 2. Does the NFS server authorize this client to access the export? This
>>>>    is a check very similar to the hostname/netgroup/IP address check
>>>>    that is done today, but it could be done just once at handshake time.
>>>>    Match the certificate's fields against a per-export filter.
>>>>
>>>> I would take tlshd out of the picture for stage 2, and let NFSD make its
>>>> own authorization decisions. Because an NFS client might be authorized
>>>> to access some exports but not others.
>>>>
>>>> So:
>>>>
>>>> How does the server indicate to clients that yes, your cert is trusted,
>>>> but no, you are not authorized to access this file system? I guess that
>>>> is an NFS error like NFSERR_STALE or NFS4ERR_WRONGSEC.
>>>>
>>>> What certificate fields should we implement matches for? CN is obvious.
>>>> But what about SAN? Any others? I say start with only CN, but I'd like
>>>> to think about ways to make it possible to match against other fields in
>>>> the future.
>>>>
>>>> What would the administrative interface look like? Could be the machine
>>>> name in /etc/exports, for instance:
>>>>
>>>> *,OU="NFS Bake-a-thon",*   rw,sec=sys,xprtsec=mtls,fsid=42
>>>>
>>>> But I worry that will not be flexible enough. A more general filter
>>>> mechanism might need something like the ini file format used to create
>>>> CSRs.
>>>
>>> It might be useful to make the kernel's authorization based on mapping to a
>>> keyword that tlshd passes back after the handshake, and keep the more
>>> complicated logic of parsing certificate fields and using config files up in
>>> ktls-utils userspace.
>>
>> I agree that the kernel can't do the filtering.
>>
>> But it's not possible that tlshd knows what export the client wants to
>> access during the TLS handshake; no NFS traffic has been exchanged yet.
>> Thus parsing per-export security settings during the handshake is not
>> possible; it can happen only once tlshd passes the connected socket back
>> to the kernel.
>>
>> And remember that ktls-utils is shared with NVMe and now QUIC as well.
>> tlshd doesn't know anything about the upper layer protocols. Therefore
>> adding NFS-specific authorization policy settings to ktls-utils is a
>> layering violation.
> 
> Here tlshd doesn't need to know anything about the upper layer protocols, it
> merely uses its mapping rules to match the certificate to a keyword it
> passes back to the kernel in the successful handshake downcall.  The kernel
> then can decide what that keyword means.  If not implemented in-kernel it
> can merely be ignored.

Actually this sounds close to what I was imagining.

Following the NIS netgroups metaphor, some other user space system would
define groups, and then /etc/exports could use those to define security
policy. tlshd would know nothing of NFS, and mountd would know nothing
of certificates.

Here, tlshd would match a list of groups that the client certificate
belongs to, and return that list to the kernel as part of a successful
handshake. That list could be either passed to mountd, or mountd could
provide the group list on the export and let the kernel match on that.

I guess the TLS groups would be defined in /etc/tlshd.conf. Any upper
layer protocol can use or ignore them.

TLS groups would be wildcards that might include CN, SAN, certificate
serial no., etc. So NFSD could still filter by the IP or hostname in the
certificate presented by the client.

Then, would TLS groups be specified in the export entry's machine name,
like netgroups today, or would we add a new export option? I'm still
mulling Rick's suggestion about continuing to restrict mtls access by
actual IP.


>> What makes the most sense is that the handshake succeeds, then NFSD
>> permits the client to access any export resources that the server's
>> per-export security policy allows, based on the client's cert.
>>
>>
>>> I'm imagining something like this in /etc/exports:
>>>
>>> /exports *(rw,sec=sys,xprtsec=mtls,tlsauth=any)
>>> /exports/home *(rw,sec=sys,xprtsec=mtls,tlsauth=users)
>>>
>>> .. and then tlshd would do the work to create a map of authorized
>>> certificate identities mapped to a keyword, something like:
>>>
>>> CN=*                any
>>> CN=*.nfsv4bat.org   users
>>> SHA1=4EB6D578499B1CCF5F581EAD56BE3D9B6744A5E5   bob
>>
>> I think mountd is going to have to do that, somehow. It already knows
>> about netgroups, for example, and this is very similar.
> 
> That sounds.. complicated.
> 
> Ben
> 


-- 
Chuck Lever

