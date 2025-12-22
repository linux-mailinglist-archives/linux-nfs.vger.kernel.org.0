Return-Path: <linux-nfs+bounces-17250-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C9E92CD48AA
	for <lists+linux-nfs@lfdr.de>; Mon, 22 Dec 2025 03:04:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6D49B30056DD
	for <lists+linux-nfs@lfdr.de>; Mon, 22 Dec 2025 02:03:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C90332264C7;
	Mon, 22 Dec 2025 02:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="RDNr8EOP";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="CiRQtNId"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E8762D47F6
	for <linux-nfs@vger.kernel.org>; Mon, 22 Dec 2025 02:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766369031; cv=fail; b=buO//nEtGSt22JqsGo/OjY2ODf9y6P8OG3PnHR5/pmoUIiWX3pMZ7EbcjkAzK23+k1COzTn19EuPvlcEEae8YXp5XNkZhaH6RMVEo1bbkpzo3rzC4XinKNvuceOZPyjT76XYZmfFYsozHMhnHR9Ovi5F8T15k0fwS+VGH7OxvLc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766369031; c=relaxed/simple;
	bh=ryDp/Dp2XlAdibrhb+T5/koMZTCg1BO7heZDfJMijsA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WsSBME8PMQCnf+ZASg/fefORqFJ0QlM6MpjGadl+CnWVMcrZHftnnNuK8KXo0lSNaAWq1Teo9mXuvk6/f7mWKE8v4gsJW60n8532Rhb0ZsyTI1Xu0qBHPZtAqmhj31ErEAfVQwfqyZ3eHIt2knJB/6UIr2Up3xbN0W1PrUwWHYE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=RDNr8EOP; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=CiRQtNId; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BM1U2GJ1144044;
	Mon, 22 Dec 2025 02:03:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=XHJ5NjvuMBzQeMTnA/GN2zGhscdyI1475Gv+BxvHtvs=; b=
	RDNr8EOPkxFYmGW+83oJT0IxcdUZsq5wBljifj9pyYUms1djsN6PbNZrrilOrACR
	P6WN5Y82MbC6BDi9uuH97TdaEzZLgaKsrTKs4UbEE5Sb59p/w+w603tDFzD6uGFS
	Q58ztyUUkACM5Al11sh/AdNonhCvSKbT1UUCL8OPNHTFo89Fg51X89BgdX8qqkO4
	F+lmTv+551p0FEHvoLuCPvmsxhTKM29r84Mfk0oGtdo9+yl5j45BckBu06Jx/OEK
	1Tp0H11TqI+WtPjTzgZD8rmM9DKmh2/SWfA66orBfI70hu2WLtDv14sbkB10AOk1
	7Pepd4VuJoWXiYyjdC2Prg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4b6vcc80rq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Dec 2025 02:03:22 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5BLL8LCc039913;
	Mon, 22 Dec 2025 02:03:21 GMT
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11011047.outbound.protection.outlook.com [40.107.208.47])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4b5j86tuvb-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Dec 2025 02:03:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LKLTXgW7esraB8CShV4pvUTDza70ocYYD2ooAMVnHayJRlE3yXc1XAcz/xgR1odgjplcQ9hnxALS6OYsG1SrpQDoASP+8BVV+b59lzKJjXiOcdZUuL1RMK/LVSu65hAge3QDj1DxN9g1XSmReGeA7SlwW2k6K1diWfhMekybU8zpjpMj+jj5McAyvblwJ+DfT64lvBRNFLY/XFQC3Q9XLXRFiyxLjj7Xny8XJEMoynXlhBuH/Jcn8JSFzyWPYFA0kjKZMaNYPZonX+ivpwTusEMJ4ms6KG+znx8GgF9vuDtiL2nhoONLCwIy5xkxM17CTvyZgezfLLtgQKxw4GfNew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XHJ5NjvuMBzQeMTnA/GN2zGhscdyI1475Gv+BxvHtvs=;
 b=pE3xFxQCjXInjHFvWwPE3ZZDpC3fb/r0pvayYuKzxN0YcWdbT2Ph8o925YLxv9GOc7N2ig6tKfOLEL4xuqjGH8JA0Y5Bqo/SmmDFrT9iMXpzrV5IlIBEHOiJjk88dI23Rur28/XaZdH+1OjGih+VZNvkb3esy1j/7lYEsg+5DYxWqiR5lKAavkkheDM4gweJPa6dV40il4DPEbw5omDBhT4KT6YMmNKrQr6Y6/ZOHBWV6UpWmv9YAuegwAPi3q30z7FkVYnwFZeqfmdd97Yg3q9epB7iTIFGKK0DytaVzIMb/a5MfTW5KwCrta41YO78hc6Gze6x+sO0DhqDSGVpvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XHJ5NjvuMBzQeMTnA/GN2zGhscdyI1475Gv+BxvHtvs=;
 b=CiRQtNIdj4W3TzvaMlc+BR3vi+Y0ya8BBCbRYSLp9R4zyEzYwgoe+BDO6R6LiVbGsrCGFt/isCBTUmd3KV3hHIZYPh6iJI458r+Oq/WYryAbT/jluWBI8L7Q1j/ICQF3dXP0D1EekFzu2cuDG5lGsLwVRhkJLUEsEQ38WTvBuRs=
Received: from MW6PR10MB7639.namprd10.prod.outlook.com (2603:10b6:303:244::14)
 by MW6PR10MB7686.namprd10.prod.outlook.com (2603:10b6:303:24a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.10; Mon, 22 Dec
 2025 02:03:18 +0000
Received: from MW6PR10MB7639.namprd10.prod.outlook.com
 ([fe80::69ee:3509:9565:9cd6]) by MW6PR10MB7639.namprd10.prod.outlook.com
 ([fe80::69ee:3509:9565:9cd6%5]) with mapi id 15.20.9434.009; Mon, 22 Dec 2025
 02:03:18 +0000
Message-ID: <61e5bb3c-9001-4af0-93cc-cb9099c80295@oracle.com>
Date: Sun, 21 Dec 2025 18:03:16 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] NFSD: Track SCSI Persistent Registration Fencing per
 Client with xarray
To: Chuck Lever <cel@kernel.org>, Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>, neilb@ownmail.net,
        Olga Kornievskaia <okorniev@redhat.com>, Tom Talpey <tom@talpey.com>,
        Christoph Hellwig <hch@lst.de>
Cc: linux-nfs@vger.kernel.org
References: <20251220231816.31848-1-dai.ngo@oracle.com>
 <0788a953-b5d8-4468-8db3-b1afa00ab844@app.fastmail.com>
Content-Language: en-US
From: Dai Ngo <dai.ngo@oracle.com>
In-Reply-To: <0788a953-b5d8-4468-8db3-b1afa00ab844@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PH8PR22CA0012.namprd22.prod.outlook.com
 (2603:10b6:510:2d1::8) To MW6PR10MB7639.namprd10.prod.outlook.com
 (2603:10b6:303:244::14)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR10MB7639:EE_|MW6PR10MB7686:EE_
X-MS-Office365-Filtering-Correlation-Id: e3a40bcc-fa28-4cea-a481-08de40fe46c7
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?aXd2UWpxbXJ5YmNjNTJ1K0c0cDFTbVF1VTMrWi9kZlVUOEh2VDhqbWlEM2tv?=
 =?utf-8?B?RFpUUzRvZDdEdGhOMll6OEhsa05QK0tXZElhWHV4c0dxaHlFU2ozeDgvTWhz?=
 =?utf-8?B?ZWdyZ0FYcEtUUmE4OFRpeTZKd1hTZFJ2b01TdldrRUIxMWFpL2FvYmh0QThl?=
 =?utf-8?B?UnhTdHU4dTJ6TGVIdjZNbmJLaXN6UGt2NEQ2bVVzVHNRR2FUSWFWbDJycVZJ?=
 =?utf-8?B?Y3dCc0c3aEtqRG1WcDZ6ZlRyMkhISHBDb2xDY1hiUWhZOUh5Qk8vWG9TTGcy?=
 =?utf-8?B?bkdtcjFVeUdIWkg5Y1BlVG8xWGJDR0sxSVhNQlBzeHkyUmJLS212VnNzQ094?=
 =?utf-8?B?S2lxdjRQQTg4NHVwSmxsbTNmU0J6VVIvSnlEU29rMUh4aFlrdzVEWXJYUmN6?=
 =?utf-8?B?SjJHc2ljZmFIK21YUDA1QnNqdERlTnpIejdqcjFlYytpL09rVStUUTJZVDcv?=
 =?utf-8?B?U09RWnFLVGxQK1FrVVEzeVhIY1pEaWpTdnY4NXJ6NnY5UWNEcGluMWV5cHRT?=
 =?utf-8?B?Z3FTbktEMzNLRW92UjkrMGcrZmRDUzJNaFRMUHdmVWNJR0gvQlJtSTRrUUtK?=
 =?utf-8?B?VGVsTzdvWHpiNTNUci8xQUthRS92aVpoNGhId05HOXZsOVlONzd4YUt0MXdC?=
 =?utf-8?B?U3RaVExlZC9YWnd0dlcvVEdCVUxJMmV3T0x5Rkt2ajUxd3VqZVkrTUpBaTZ4?=
 =?utf-8?B?OFp6YlMrc3BjblM2eDdHa2xwKzdoekxiZG00YWFodHBWOE9SYUFFSUpNYUtI?=
 =?utf-8?B?SUxQTzZrMW1Ya0thdGJwN0FDQVFhS2srWVNFeWU1c1hwS21oVitDSUpHSUNm?=
 =?utf-8?B?a1RWdXMwTjJGUWF6WlA4TzlGd0lZUk1sMVhOaDBIUUVyY2VhMTJ3RkEyRG9F?=
 =?utf-8?B?b1I4N0s3akJsRWlhZWx5RG5nYm0rSGphYVpSNDIxRHZZZGl4UUZlc3dwTWU0?=
 =?utf-8?B?VFo3cXcxRzUxaHcxeThDbWRQanZLRWI3WGZmeTZ1TlVUbmlYeTJ6UnJzR2xM?=
 =?utf-8?B?UnB0Vy9ldmNCcy90T3ZVejEweXpKSWtNcEptTEljbk9HWk9rOXA4NkswQmNC?=
 =?utf-8?B?TkF2eVIydEFhZHRYQkYzS010ZnBPbGJFalVXUTRsalZZU2huSzZvbzFOSWg4?=
 =?utf-8?B?VVFnQnd4SXl1aW9sTTZ5dWlYcEV5eVo0ZXpPNGtHQkVQaGEzL0RNU1hYb0dx?=
 =?utf-8?B?eDJEaVQ3V3FPMGxzK3krOFVidm1YRmNZNFREU3ZYTlp4ckxudTBYQUxIVHdj?=
 =?utf-8?B?VXNCZ25Rc1NjYk02NEFpR1kzaFZMUFZ0VUZGOGhOQmRZY0VDSVpIQ1Z3TTFT?=
 =?utf-8?B?YmhsRWp0TkNacFRJQ1lPN0hpWDhDSWR3VGNCWXQvMVNkaHdtaFRnVXc4N3Z3?=
 =?utf-8?B?bngvRzdlNGFvQS9ROFNRYzhrNmhoUGRWbGF2ZkhtdmVGMTRkbXREQU5HMnI1?=
 =?utf-8?B?STZqU1hpd3lmUFVQcy9ZSkVaeU9nczVicituTnNKWjlucVVqT3lweWc0c3pG?=
 =?utf-8?B?Q2JOMklRZFhDb3JueUg3OHFIZzc5NG8vREpJRy9Hd0sxNmhxVGFQZlQ1aHB5?=
 =?utf-8?B?Vm9mZ1ZRYXN1T2lWRWFiOVJZKzJ6Nld3L1lPTmhjQWJDNzJlOXNZaHlPTjhT?=
 =?utf-8?B?VHBaOUNmdmx4Q3NRK2IycjVzUXVDTEZoVExlQ2VOczVsd1VYWmh5K005WjZX?=
 =?utf-8?B?eXVMblhnUmRKUWVESTRxcyswWWVoaEgzdkIveXh0VUtsZ2s0RitzUnJmb1B1?=
 =?utf-8?B?TndVZmlMQUdvWFN2bTIxM0IzL2FlNStLNzhhMXFJbTZYS0xBU0ltMWFqTmJ0?=
 =?utf-8?B?S2hjcDRlOThVai9BZ1Q3aHhDY2t6YWloTVkyWTNqenF1SGNYWEdLanlsU2l4?=
 =?utf-8?B?ejFzUGlTMzRMMGFzbU9sSTdRL1RmUDhab1RlOE1xbCtPY3VxNWd0SlhJYVYr?=
 =?utf-8?Q?VzLzm1BtfOJe9T1dMEsEhFcuzyHD1MK4?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW6PR10MB7639.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?bUN5d0dUZXpyTTQ5L2h4YkdlRzJpZ3BLRWI2ZlhmaWlMWmY4UTd3d2Q5aWht?=
 =?utf-8?B?UVRPQ0p6UC9GSURUWDZtZGdRSmxMYStiaG1mRGhjbCs2cFdqTHZYd1l4UWNa?=
 =?utf-8?B?L2FoS0VrbmNYdzVwYlhONkF1VEVIZk1WeGd6RkYwTUdXd1JOdGNtYWpEODhr?=
 =?utf-8?B?RzFOSUU3QXBVcjhZUUxia2VMd2ppZTRJTTlMWHVQcDZiamNUTGxMY0xQUDVP?=
 =?utf-8?B?STYwcnVUUkFHeUlieXc0aHU4RXdRMmV2ckFtSmtjNjErVVR1ekJuRk9MRk9I?=
 =?utf-8?B?cXl2cnVCMHB1T003dm1QSWxRWE1KK3YzdlI2c0JTVGkraG9NYXlFQVZnbE8y?=
 =?utf-8?B?ejdqSHp1MEdjL2FYTmJtNHU4N1lTYXRBaGk1MXpCVVB0azQyWXRlcDh3cGtp?=
 =?utf-8?B?ZDdlSU8wWVU5YkxvUWhHb01KeCtuU3NaSmNua20yd0ViSmdEbmp3bFJCN3U1?=
 =?utf-8?B?cUk2NXZsdmVKdHVWeVhvcmsxeit3b0JLMS9tekc2SlUvaUFCaU0zRnlZQUhY?=
 =?utf-8?B?T0hTU2VkU0R0ZGE2OW9BNlIva2IybTZ6ZmJuWjl1RGpYcUdwaW80WWRoMi9V?=
 =?utf-8?B?MStKUGk5S05JUE9FMGs0d2ZIUk10U3NVbXBic0N3S2tOVWRwTzdVaXQ4bzhz?=
 =?utf-8?B?eEdWeW91TlcxRkxOeXR0QUJlcUIzT09RVlVCMURNOVdUdzRhdWhrOEh2VjBJ?=
 =?utf-8?B?R1g2UDY2dE1zYkZwc3FJTzY1SHFhbEtiWjhGUktZTi84TEN2cWVmbXFORDFQ?=
 =?utf-8?B?SVJSQVVTOUt4ck9kcDllOTIvRER6WFVKaXh3SG5ITVhMaU8yTmlobExjcjBW?=
 =?utf-8?B?bUM4bVhRbVd0WXNqRjN3WUgvTXJQN0ZEaTcxWSs4MjVWK1hUdkc3emllc1R5?=
 =?utf-8?B?Y2IrdTQ2VVpxcGlKTi9UNnBFbW5HUEltK0JlVVlWUFNEZ1NiT0dMOHV2MFps?=
 =?utf-8?B?dDhqUFJqRk40TlFPYlVtSFdlMmZrYXZ1V210Qk1rajNyZzZ3VUFZZ2tDVGds?=
 =?utf-8?B?M0RJb3RKekk4S2FTRllMWnFQdVdKbzBsUTlEeEpRNWM2NUlvQzZBS2ZVd3g1?=
 =?utf-8?B?OUpvR3kwaWJNYzhEUzVSYTBzZGJoSHQ1SmxNbXFnMDdsemhtdkxzOUlVRTlw?=
 =?utf-8?B?LzYwUGZKdnpBVzNrMWZwYXYxOGFCbFZtWmJBME1ITVVMT21jYjJsQjBmbW5q?=
 =?utf-8?B?WHZOLzRxbHhsYkJobXIvN3lOckFXdXY2YWZzbHRDN2daQ0M3VXdudENpM3Fh?=
 =?utf-8?B?MzRTV3gzR1AxYTFoanc3S1l5eWJHM3RlQ3hRZFE1YUg3OVdFM0NMQVJxbjlE?=
 =?utf-8?B?cWk0clVRZXNjRDBJRFp4TG94ZjhPeFNkczVTeGhCWW1LZDVoaWo4K24wcXJk?=
 =?utf-8?B?eGdiM1VNR1FKTGs0ZUlkNVhmZGdEMkM2bkgwQTFYTkdjczVYYlRDZjVpeGxq?=
 =?utf-8?B?THlNRDhhdStFNmFNb1RGNWdkZVpsOCtuMVREdDlMWFlDL3hNbFg4SzRkZ3lR?=
 =?utf-8?B?RXZ6QU1hNTFzYjhqUnk0REhySExPOTg5aWVtbFhDeFpvMzJua0p1WTFFTlJL?=
 =?utf-8?B?ZWR6VHF6Wng1dCtrYlh3MlcwdzJIUWxVWlR4VHN0ZE1ldCthcmxGUSsxTi90?=
 =?utf-8?B?QXhKcCs2dDJpeVVEN3Rvc0p3R2tyR1crOGtSc21FRUVkQUJuNUZCQUozbWJL?=
 =?utf-8?B?K1hJTk41Y053NUJCN2VkV3ZYVzFwcjBHS3VraWl1dXUrTUw5cGlYOFdxbGRh?=
 =?utf-8?B?SlJKN3RDbWhkSVljNmlCRTdobi9TMHRsNXhtaDlDeG1kT3gvQkd2b0RjTmY1?=
 =?utf-8?B?RjhSN200OHFETE54Sys2QjZuNWtuRGhkN0JxTGhTZjcyOVJBempzTmRaMWRW?=
 =?utf-8?B?cWc4b0xFMEJWY2xQZmRSYTNvaGpEREtDQTExZWdBbmlSUHRuNWFNalkzN01u?=
 =?utf-8?B?SmNDTnR0N2haaUpSTUxGeDIyZXV4ZHNzOTZrNnB1bStFUVhBRlF0aTl3Wnor?=
 =?utf-8?B?M20rQ3hxOVR3c3FGL3RqWUJzT1B4MVZZTkdWdUFWWWw0WUVDYWdHenRueitU?=
 =?utf-8?B?OEUxelNEQjB2cGNxblRzMHZBbCt3MGVDZzZ3UHd2WVlPQU54M3ZCL2VXZXhP?=
 =?utf-8?B?STdncmYxZGhISURYU0ZNcEtBMFBBSlkyaVVvWmIxWUVmc0VvS0lodU1RUElq?=
 =?utf-8?B?bjk0YXVtY2hwOWxNeXhUWWVZTkZTTmthZnJDSGRSWmNpUXVrTzdnT1BQcUl4?=
 =?utf-8?B?RTEyOWF4ZjYzc1lVQXlhZnVlM3RzbFBWWm9LbWFyRWpSUElOd0ozK2pYSWVI?=
 =?utf-8?B?VnRkazdoVDJaUFZ0VHpJbVMwMVJtTUk5TlM0a3pMRGtHVXFZL2RvZz09?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	VMmOq5oXHwi+zXm6G+/FQ3ZilEsa7DnjJ61cy1F9f9q1PfTiu0EuPowpjMXma/fQ5CPyVmSfhRs2HPJR43WxD2Vp8Kj3/SGaN3udlMt9stAq/IagORMCuajbqq9Pm5GvK5OpGNUuHMt+TWcs9b/N1oXoIwFra1rg6Aac+faravZmjnRcPvn0t67cFhDYQNBjvqueyZb+L/5lVVUFCgQtY5Zo5umRHDZucSEsMM/kmlZ38AbQrDMknUvd37KIuaqVWcXjAQ0zbYEwsn3il8U9Ei/JWhcstCXxkWU3Zg9bZD4ohRCAZwkun1xrexiuPcD+KnR4NHh0PppnOhDznLkECogjouYJZdY5M6nr4mlI4hxWAJqYoj998tHqYyLynNwo4+8Q+14HKclC86bZL0i0MV4ZFfQYpA18kv1uHOQ1ozQAjL9hLWoXAOdfJm4fSYbj9TiynA9q8qHd0kFERl3ALtUlVCdSzyw0k//9ECRPkQDv/34ccuTRmjLoTvhKjqawkzDV54Rg1pcaFL/AFHMXJDE4Fy4C6HabkZneiMG082UlOf3gx2L4Rlx4HWKAB+wzZ5KauCRc25aoAsG6atZJ6oZ2sSfH+lgXiSx40kk8+xU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3a40bcc-fa28-4cea-a481-08de40fe46c7
X-MS-Exchange-CrossTenant-AuthSource: MW6PR10MB7639.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Dec 2025 02:03:18.8020
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SmtbNiJJa33b8Xm5uiwCkS39gDmoGgf6KEHnJKvTR9lxAyCrwSutDR+EBtEcfZ0cJARM3gAYikgcW7t5kRGbKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR10MB7686
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-21_05,2025-12-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 bulkscore=0
 mlxlogscore=999 phishscore=0 malwarescore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2512120000
 definitions=main-2512220016
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjIyMDAxNiBTYWx0ZWRfXx5OWQzM7+l9l
 C7NmIC6zXgeVj6ImZZ8iD9Sg+YUKfQpgV62O382CM7d6E4nhgGrkBzTecPucAdy0v8QDVNp+FGl
 H1Wta9AsfTiS0JcGws30BRnY6jPN4lmceJK01RDUV+4KJQiYr4HNjKVHI5oSXqePYUvZ7YrgdYX
 3dwXqvrj9r3F8OaaxltbqDu4biFiwQ/DYq5hShc9gMR8imwSvYFm/egU5yo+vH0ndaVExw10RQZ
 +WPoJ0GE3GK/BsuTQjnmSNjP4P6V0gr1Ft8jnJtatG5knC0wDOg4q5bQ0hFHfBagGJbiRCoR78B
 L9hjoarHox4yHR1f61/r2DjqGtdHmXAVMIrNR5L9T7uRnDzTJchYM7nmFNsvH4ITwE1QM9EpQnp
 canImBiXafaBwDl5aVgPqUVB+PU+Yook4o/dIxK8Umi7nk2xXql1KExPWT5FOwhIy2hXeKE941n
 3y5H9OHLeencnYPbx7Q==
X-Authority-Analysis: v=2.4 cv=XPE9iAhE c=1 sm=1 tr=0 ts=6948a6ea b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=wP3pNCr1ah4A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=yPCof4ZbAAAA:8 a=YxGzacpMCmkCX8OQg9gA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: N5cVPgzoGGhSAJGXrSYGs6BWzvcFIT8I
X-Proofpoint-ORIG-GUID: N5cVPgzoGGhSAJGXrSYGs6BWzvcFIT8I


On 12/21/25 9:21 AM, Chuck Lever wrote:
>
> On Sat, Dec 20, 2025, at 6:17 PM, Dai Ngo wrote:
>> Update the NFS server to handle SCSI persistent registration fencing on
>> a per-client and per-device basis by utilizing an xarray associated with
>> the nfs4_client structure.
>>
>> Each xarray entry is indexed by the dev_t of a block device registered
>> by the client. The entry maintains a flag indicating whether this device
>> has already been fenced for the corresponding client.
>>
>> When the server issues a persistent registration key to a client, it
>> creates a new xarray entry at the dev_t index with the fenced flag
>> initialized to 0.
>>
>> Before performing a fence via nfsd4_scsi_fence_client, the server
>> checks the corresponding entry using the device's dev_t. If the fenced
>> flag is already set, the fence operation is skipped; otherwise, the
>> flag is set to 1 and fencing proceeds.
>>
>> All entries in the xarray, as well as the xarray itself, are freed
>> when the nfs4_client is released in __destroy_client.
>>
>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>> ---
>>   fs/nfsd/blocklayout.c | 27 ++++++++++++++++++++++++++-
>>   fs/nfsd/nfs4state.c   |  7 +++++++
>>   fs/nfsd/state.h       |  3 +++
>>   3 files changed, 36 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/nfsd/blocklayout.c b/fs/nfsd/blocklayout.c
>> index afa16d7a8013..f619de53eec6 100644
>> --- a/fs/nfsd/blocklayout.c
>> +++ b/fs/nfsd/blocklayout.c
>> @@ -357,6 +357,9 @@ nfsd4_block_get_device_info_scsi(struct super_block *sb,
>>   		goto out_free_dev;
>>   	}
>>
>> +	/* create a record for this client with the fenced flag set to 0 */
>> +	xa_store(&clp->cl_fenced_devs, (unsigned long)sb->s_bdev->bd_dev,
>> +				xa_mk_value(0), GFP_KERNEL);
>>   	return 0;
>>
>>   out_free_dev:
>> @@ -400,10 +403,31 @@ nfsd4_scsi_fence_client(struct
>> nfs4_layout_stateid *ls, struct nfsd_file *file)
>>   	struct nfs4_client *clp = ls->ls_stid.sc_client;
>>   	struct block_device *bdev = file->nf_file->f_path.mnt->mnt_sb->s_bdev;
>>   	int status;
>> -
>> +	void *val;
>> +
>> +	spin_lock(&clp->cl_fence_lock);
>> +	val = xa_load(&clp->cl_fenced_devs, bdev->bd_dev);
>> +	if (xa_is_value(val) && xa_to_value(val)) {
>> +		/* device already fenced */
>> +		spin_unlock(&clp->cl_fence_lock);
>> +		return;
>> +	}
>> +	/*
>> +	 * Set the fenced flag for this device.
>> +	 *
>> +	 * A record for this device should already exist, so no memory
>> +	 * allocation is required. The GFP_ATOMIC flag is specified for
>> +	 * safety, as the spinlock cl_fence_lock is held.
>> +	 */
>> +	xa_store(&clp->cl_fenced_devs, (unsigned long)bdev->bd_dev,
>> +				xa_mk_value(1), GFP_ATOMIC);
>> +	spin_unlock(&clp->cl_fence_lock);
>>   	status = bdev->bd_disk->fops->pr_ops->pr_preempt(bdev,
>> NFSD_MDS_PR_KEY,
>>   			nfsd4_scsi_pr_key(clp),
>>   			PR_EXCLUSIVE_ACCESS_REG_ONLY, true);
>> +	if (status)
>> +		xa_store(&clp->cl_fenced_devs, (unsigned long)bdev->bd_dev,
>> +				xa_mk_value(0), GFP_KERNEL);
>>   	trace_nfsd_pnfs_fence(clp, bdev->bd_disk->disk_name, status);
>>   }
>>
>> @@ -426,4 +450,5 @@ const struct nfsd4_layout_ops scsi_layout_ops = {
>>   	.proc_layoutcommit	= nfsd4_scsi_proc_layoutcommit,
>>   	.fence_client		= nfsd4_scsi_fence_client,
>>   };
>> +
>>   #endif /* CONFIG_NFSD_SCSILAYOUT */
>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
>> index 808c24fb5c9a..44e6222ad9e5 100644
>> --- a/fs/nfsd/nfs4state.c
>> +++ b/fs/nfsd/nfs4state.c
>> @@ -2381,6 +2381,10 @@ static struct nfs4_client *alloc_client(struct
>> xdr_netobj name,
>>   	INIT_LIST_HEAD(&clp->cl_revoked);
>>   #ifdef CONFIG_NFSD_PNFS
>>   	INIT_LIST_HEAD(&clp->cl_lo_states);
>> +#ifdef CONFIG_NFSD_SCSILAYOUT
>> +	spin_lock_init(&clp->cl_fence_lock);
>> +	xa_init(&clp->cl_fenced_devs);
>> +#endif
>>   #endif
>>   	INIT_LIST_HEAD(&clp->async_copies);
>>   	spin_lock_init(&clp->async_lock);
>> @@ -2537,6 +2541,9 @@ __destroy_client(struct nfs4_client *clp)
>>   		svc_xprt_put(clp->cl_cb_conn.cb_xprt);
>>   	atomic_add_unless(&nn->nfs4_client_count, -1, 0);
>>   	nfsd4_dec_courtesy_client_count(nn, clp);
>> +#ifdef CONFIG_NFSD_SCSILAYOUT
>> +	xa_destroy(&clp->cl_fenced_devs);
>> +#endif
>>   	free_client(clp);
>>   	wake_up_all(&expiry_wq);
>>   }
>> diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
>> index b052c1effdc5..db6980f112ce 100644
>> --- a/fs/nfsd/state.h
>> +++ b/fs/nfsd/state.h
>> @@ -527,6 +527,9 @@ struct nfs4_client {
>>
>>   	struct nfsd4_cb_recall_any	*cl_ra;
>>   	time64_t		cl_ra_time;
>> +
> #ifdef CONFIG_NFSD_SCSILAYOUT
>
>> +	spinlock_t		cl_fence_lock;
>> +	struct xarray		cl_fenced_devs;
> #endif
>
>>   };
>>
>>   /* struct nfs4_client_reset
>> -- 
>> 2.47.3
> Hey Dai -
>
> This version looks narrower and cleaner. Kudos!
>
> But notice that xarray has the ability to mark and unmark the items
> it stores. I asked Claude Code if that mechanism might be used here:
>
>> Using marks would be a significant improvement. Here's why:
>>
>>   Current Approach (Value Entries)
>>
>>   xa_store(..., xa_mk_value(0), GFP_KERNEL);   // not fenced
>>   xa_store(..., xa_mk_value(1), GFP_ATOMIC);   // fenced (under spinlock!)
>>
>>   Problems:
>>   - xa_store() may allocate memory even when replacing a value
>>   - Requires GFP_ATOMIC under spinlock with uncertain allocation behavior
>>   - Must check return value for errors
>>
>>   Marks Approach
>>
>>   // Registration (GETDEVICEINFO):
>>   xa_store(&clp->cl_fenced_devs, dev, xa_mk_value(0), GFP_KERNEL);
>>
>>   // Fence check-and-set (using xarray's internal lock):
>>   xa_lock(&clp->cl_fenced_devs);
>>   entry = xas_load(&xas);
>>   if (entry && xas_get_mark(&xas, XA_MARK_0)) {
>>       xa_unlock(&clp->cl_fenced_devs);
>>       return;  // already fenced
>>   }
>>   xas_set_mark(&xas, XA_MARK_0);
>>   xa_unlock(&clp->cl_fenced_devs);
>>
>>   // On fence failure:
>>   xa_clear_mark(&clp->cl_fenced_devs, dev, XA_MARK_0);
>>
>>   Benefits:
>>
>>   1. No memory allocation - xas_set_mark() and xas_clear_mark() just flip bits in existing nodes (see lib/xarray.c:884-901)
>>   2. Eliminates GFP_ATOMIC concern - No allocation means no GFP flags needed for mark operations
>>   3. Can remove cl_fence_lock - Use xarray's built-in xa_lock()/xa_unlock() instead of a separate spinlock
>>   4. Cleaner semantics:
>>     - Entry presence → device registered
>>     - XA_MARK_0 set → device fenced
>>   5. No error returns to check - Mark operations are void functions
>>   6. Defines available - Could use XA_MARK_0 directly or define #define NFSD_SCSI_FENCED XA_MARK_0 for clarity
>>
>>   The only xa_store() that needs error checking would be the initial registration in nfsd4_block_get_device_info_scsi(), which already uses GFP_KERNEL in a sleepable context.
> This approach should make remembering fences more reliable.
> Would you consider using XA_MARK ?

Thank you Chuck! I'll switch over to using xarray mark and unmark.

-Dai

>
>

