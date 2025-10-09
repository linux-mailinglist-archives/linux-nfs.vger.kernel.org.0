Return-Path: <linux-nfs+bounces-15097-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 87252BCA5E7
	for <lists+linux-nfs@lfdr.de>; Thu, 09 Oct 2025 19:26:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8522F1A63CF7
	for <lists+linux-nfs@lfdr.de>; Thu,  9 Oct 2025 17:26:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C056C23817E;
	Thu,  9 Oct 2025 17:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="M6rqK5Ee";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="KL0qXD/Q"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FBE3A31
	for <linux-nfs@vger.kernel.org>; Thu,  9 Oct 2025 17:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760030773; cv=fail; b=eUypHFQCX7O7uqllp/37n1NO1dJ84HUShmgC3gcx4+2oqNfqOutrq1aQS5OxSkcrEQly5yYfjXwm3kr2Adf+BUfhg5stW7yIXkDKMwlpA1G0DD9m7wgUMhDVk04dWfX7M2gqQu+ZnpePtTkgjRgsPtDGALjad/CUJNUwHvivzbI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760030773; c=relaxed/simple;
	bh=Q8FSxZx98+uXwCmFOYTqGllHkwKFlLjjytVULcv5sCo=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JbVVfv+4T8haLQeQBeypAGEV8oxUDrQx+vi0y8XgYbttbAp09hyZSG/egPKib+QWZ+3Ctj9JZvIGttPR0cVmywacYu13rLQIrIrYmfsntgXpAy16hbXFWQo8L3qfqfC7Sl0Ge6yEhL7v5SwDj0g15And6ZYpzLXrLy9ZQqiVnGg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=M6rqK5Ee; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=KL0qXD/Q; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 599GCHGr005568;
	Thu, 9 Oct 2025 17:26:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=LrAQoGvfNErk6fPQL/IAny7ZmqgnVvjqWW77kzqY73Q=; b=
	M6rqK5EeuIkit4kjL8rNarpLeEqLjejI2qvOvlMeZeBEJ6z8ONYUStClfgmBxV3S
	PeQomay9ag6+Pna5nxrzdn0CyYUoXGx582nNLmGldMPG4EESgzz4Lp6WYIDp3bxq
	/jgr0IVBowHZRJvhOpVjh/3lGRBeZdLG9PDIMrkx7n59ImhNFqXbrNc3o6BLfABV
	sVDQB+XAWOsiAxUgRpv9adDhNkYZbjx4+Q9wCoSmSvyzNjMB7AXCelqLWVB1hHYv
	vBWq+I7QUWJ5PP2vJL4vguN8UeQyX6hPfI09hhx1zV01jX4k1t4BoXviSuQXgIxZ
	IArOHvofBR5Q3i+o9yvzhg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49nv6d253j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 09 Oct 2025 17:26:03 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 599G4APJ036736;
	Thu, 9 Oct 2025 17:26:02 GMT
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazon11013069.outbound.protection.outlook.com [40.93.196.69])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 49nv67yknx-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 09 Oct 2025 17:26:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zNu/YmDcXN5f7i1j/CW6jaAwfMH1sW/zGtvhYM2FHfleqBILUa7ep+s8YraBxUYuRv41jRrvLGRhKJXGWdruNg5u5EeYoOtMcnYywh7xJus+J2vjuJgddSnNvPn+Gi4qql9Y3QF7mKStVTaTz/tKAOSZzErdiR5QUcPm5/3Xr+uN/Ep9e8W5rIgTVAD7qWa8ezm0TrWVgP4dnf5uFGNL4gVWS58jPKumhkNcseKR117/nOzkq+irHZAYmd70EGNW5MJaodEADCbCD8/TvDOo0jtLjSmPRpQNyUdsmVBmHM1GO+qvrDmsHnMDTwb4D3TpKSMW8DOMoM13Nfmr1XlIOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LrAQoGvfNErk6fPQL/IAny7ZmqgnVvjqWW77kzqY73Q=;
 b=Z4ZAs07wdaMSj+BtG6hGV/g1Xkfg8bQFgssDx1wmJ/zUUUTvEeiZy1oCGsbdr3apc1/2ep6ieN4/0Xc79+3SrTrGbWaWQCbHnKaKhEwMKGqI8cEP/j5j00gVI8+PciMjgBzg+UuSQ3GXykC0eUbZrgWyz8VUR2M5gQO0soL8vVmYXRurUzr2912qHH4IMJnsXTl2Lbd0yFZOZp71O2+vXZapsvfCtaX258V+X3Lf7ZEtHydYXqDufwf7fnqYKpukLXfDVDrt8Iqv0xh3N3t0r31R8wD8pb3qJWGsl6dC15Qbjp1s3ohxyP4jxzSNoR7uacJVEMazxoiTML+UEftq/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LrAQoGvfNErk6fPQL/IAny7ZmqgnVvjqWW77kzqY73Q=;
 b=KL0qXD/QHHlp5dpIPjeJGafhKR7ZNm2z67BI47yC5LsvUuWZUHwegKOlcvQ5PprB+j1abIw+/7Vp0Q4xERadf1mselWK3TdH6ELiVH5wzd37/GKBooqAdT4AHT3XFLPpiZ4Anx270+CAmmZDm1q2nvDp8UD5KJecIpjH3k1DOrk=
Received: from DS7PR10MB5134.namprd10.prod.outlook.com (2603:10b6:5:3a1::23)
 by PH0PR10MB6984.namprd10.prod.outlook.com (2603:10b6:510:288::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Thu, 9 Oct
 2025 17:25:57 +0000
Received: from DS7PR10MB5134.namprd10.prod.outlook.com
 ([fe80::39b2:9b47:123b:fc63]) by DS7PR10MB5134.namprd10.prod.outlook.com
 ([fe80::39b2:9b47:123b:fc63%4]) with mapi id 15.20.9203.007; Thu, 9 Oct 2025
 17:25:56 +0000
Message-ID: <fcb54c42-0eac-4e6b-9c47-0dbf8266ac4a@oracle.com>
Date: Thu, 9 Oct 2025 13:25:54 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] nfsd: add missing FATTR4_WORD2_CLONE_BLKSIZE from
 supported attributes
From: Chuck Lever <chuck.lever@oracle.com>
To: Olga Kornievskaia <okorniev@redhat.com>, jlayton@kernel.org
Cc: linux-nfs@vger.kernel.org, neilb@suse.de, Dai.Ngo@oracle.com,
        tom@talpey.com
References: <20251009160653.81261-1-okorniev@redhat.com>
 <8c4c1602-c180-44cb-b1e6-782f0fe3f8b0@oracle.com>
Content-Language: en-US
In-Reply-To: <8c4c1602-c180-44cb-b1e6-782f0fe3f8b0@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BLAPR03CA0133.namprd03.prod.outlook.com
 (2603:10b6:208:32e::18) To DS7PR10MB5134.namprd10.prod.outlook.com
 (2603:10b6:5:3a1::23)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5134:EE_|PH0PR10MB6984:EE_
X-MS-Office365-Filtering-Correlation-Id: 047d05e2-939d-42c8-8751-08de0758e799
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?QmZxS3M5Mlh0UzkyczU5WFlpYXVjTXdtZUltd0dmNUQzN1ZJdEllWHIyaTNq?=
 =?utf-8?B?ZFhmS1dzTUxFMzZKZUpTbUVyT013VnBjMzBJUlVFTERXQmVwQ1BFTlFXalNy?=
 =?utf-8?B?cFNzamdmOVNCMzIyMTlySTdwb3M0VHJpeDNRME5MVHpIQngyaUliYzNSMU1G?=
 =?utf-8?B?K1JxOXo0c2pkQTZaczBMWE1EbkdDQVIzK0ZEWjRieUx4cWJ5djdjOGthbUJt?=
 =?utf-8?B?VFZGK09NcTZlWFc5WkFGcGIxMVBsU3hTL1BxMWJrVVVrZFBPVkVXY2lkUG5z?=
 =?utf-8?B?U0w4cXJObmhJNWhxY0JraC9nV3FYVS90anJ6UlhUdXBwOFVzeWsxVGRKNk1S?=
 =?utf-8?B?bFNRbXhzZExXR0xGWG9wZENaajFwWkxLYUNYQjZZclFMMG9QOWRSMHcxNkVK?=
 =?utf-8?B?bDhWQWRKRFg1bnJ3bVBWbEJWWVBBdGpLQzZqQ04vZnZLem9QYkMrTUNqSU5M?=
 =?utf-8?B?NFFYOUhxcW9BMmh3V21jWE80azZyb3pJdHRlVEkraTJzUSt5dk11YWJVS2d5?=
 =?utf-8?B?eTIwZ0NIQ0FNYStJNFI1WndHbnljQ3ZadFRHTnB2T2J0Qlk4b2VxVS9rTWFq?=
 =?utf-8?B?RXhmUHdpZTJHVm5DeCtiN2Z0cU1RbW95RXVOVHVvY2JoL2tFVERjV2F0eE8r?=
 =?utf-8?B?ajd1R1Jkb3VXTU5ET3dCWEdzWW50b0Mza3VBUW5XVCtNK3NJeHpicWZRKzNS?=
 =?utf-8?B?dGRrSUg3UUhXN2pBeHlQVlVhQ083cmdZU1FLeWVQdzltRWx0Uk9jcjB5cThF?=
 =?utf-8?B?UDhJbTNtWldpR2gxYjJ0NWpYbTlVbFB5QW84bHJ0L01IVnBaVDhsR3h4Y3Uy?=
 =?utf-8?B?TytBUTE5d3U5eUpvNmp6WFpvMkdhelBybVdSNnJZZmVCT2FsejQzL2c5S21H?=
 =?utf-8?B?WkJwS2Nad1kyOVo4N2ZwaU11QzlQanRRbDRpMUNtV1kvMkwrOVZadzMvNmVL?=
 =?utf-8?B?Z0xFY3prQXMxNGN0NkF6UjZ0TmZOVkpzQ0FNSnFjcHhVYnFsQi92dS9IMzdY?=
 =?utf-8?B?K051M3hEbG5UdjlNc1Z0UXBkS205anRyNHV0WUQ0Rk9BeUIwQnR3cjhLNTlq?=
 =?utf-8?B?SzgrWC9laHQxT1JROStPQlpVZHVIWnBCYzlLVWd5YWZFZm9WV1JsaFhZSGU3?=
 =?utf-8?B?QW1sNGNNMFk5Y0hDNzdwUXZXeTZ3WmFhNHA0RmJUbmFZNVluUVJaY2ZlMEx6?=
 =?utf-8?B?d3FuOHY2cVdSV2dkSFFiTTVkQWZCTmtTbGVUZDljaXFueUtPUU84VllBMlVI?=
 =?utf-8?B?UE5zR01XNm52MEZlSURoK28vbUhaNkNCTWRZQjJ2VGdEaXBRTzV3UWw1a2ZG?=
 =?utf-8?B?dy9FanRhWlBrNTcyZkN4bUpJY1lUbkdQWDF6RUVKdkx5ZFZjdUJvaTMrbUkv?=
 =?utf-8?B?RWRIVHdMZHZVSXZGMko5T2h0MVdmWm5hMndaTWFGams4djFacVNyMGY4S2xm?=
 =?utf-8?B?MEF6WXl4c0tHWWh5cldLRkdUWFlBMzduTHBIUlVDR0pMVXlXdUhKcVBsenFM?=
 =?utf-8?B?OUNCRFhFQkQ4SFNoOHZtRkFhL0ZucFF5aFpzWmI0ajd2c2d3VTZEQTRaejBr?=
 =?utf-8?B?cThRSkg0MnBCbzh4b0h6NnBYVUNIcHZETmIvMkJRR1F6ajBSZURtdG9tMVhi?=
 =?utf-8?B?ZmNWT0x4YnNKNi9jMUp2by9sSDhJbUVzTnRjQm5rc1prUUpMZE9iMk1sQlhZ?=
 =?utf-8?B?Z0RpL1huUjRJa3JDT0tTZDJ6V0o0VFR6RzR1emdpamszZnZtWkd4N1RxYWVV?=
 =?utf-8?B?OTNKSS9JbWwydlQydzFUZytQYjFac0x2V0c2Ly84UHVzRXZiR2YzUmo0blYw?=
 =?utf-8?B?dUpZKzN0eVVxb3FraWFoV3FUSDFyZzFnaUxxM0tlS2FSUlBqOFZJbVlCenRL?=
 =?utf-8?B?c2t4MW13M2I0VStmVFBzak1FYXZPNHMyS2FrODB6ZlBFTUZqMDJ2ZXVpWDl2?=
 =?utf-8?Q?cYQ3QHP7kGiY9i5xDuaBv7zhyNibt8wM?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5134.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?dENIOEpxTll5OXAzUDF2Q25vTVdtcHUzaW84ZEdEK2ozS2ZlR3FJSG1JQ3hX?=
 =?utf-8?B?eHJGQUpFTFBpK2c3ZEJKc3FuSjQ3VEw1enFPblRjVEUxNE9EeGRGUi94VXEv?=
 =?utf-8?B?c2tpWmRTZjluZzEzNDVSZXJUM3Vab0VjdGNFdXNPVmVHOHlXdkpKUzBHNE45?=
 =?utf-8?B?NzRtZzlFOHI1c2xvL0dmaHVZNFA0R1Q3c2kxMEYrb250MVJJMncyclNKWXY5?=
 =?utf-8?B?bW5aN1AvZTNKSHpjYkRkYTFuT1N6YzZtSGhKVFVORVlvTU5zN1dDWDlMZ2Fr?=
 =?utf-8?B?UXg3TFZobHZSQmlJQVRkbnNXU01wYkJBSzUxRjUrVEhDbC91ZEY4MG9NTG11?=
 =?utf-8?B?Tzk1YWdlYmFza0dtcHVnYkJ6QVpEbURFdENHZ0pUaEdBWjFUMEFkWHdHZWdq?=
 =?utf-8?B?TFR1cFpPZCtnZmFic2IvZlVEeDNTUExJSWRZeXNIWFVaWWlybWE3S21lTVlw?=
 =?utf-8?B?VnNSQUdCeWQzd1JDZmR6SWxVYTFmMFVpa2JDdlRGVnZhVE1obmxycXR1c2Z0?=
 =?utf-8?B?NmpESWdCd1NhZVU3K0kxd1ZPd3c3Ym56VWJkVTJHR09DS1ZNbWJUYTQ3cEFJ?=
 =?utf-8?B?SFdvdjRFWDdOL3R6YjRybCtXeXM4SW9XeW1GWTE0YVRHNGV1KzdrNFNYQ0t4?=
 =?utf-8?B?MEdaZ3BNMVZLemlIYnlPTVA5dndVYVRMK1BIb0xIM3BoSUx0SVJGVG5Nd0h3?=
 =?utf-8?B?N3BnZWkwbHN1UENFdjVzOVptM3JNQzFzNzZ6U0NVNUZrZko5RHNIQTh5TTI3?=
 =?utf-8?B?dHlnUWh3QTRWbVVva1U5UzdHVmlhaFA2dHZxY0hWYU04L01uQ3MzYUMySkMv?=
 =?utf-8?B?N092bFI0RURnOWh3NmFabHlOUldoeTJlOE9VR3RuSVBWNmI3TCtWc0lzQWlj?=
 =?utf-8?B?U01qdzZGa0FRQ0hLUEU0QlBYdDF0QTdRYUxOVXhIeHFUYU84bXQ5bjBacW0r?=
 =?utf-8?B?b0VtWVpORm5Sa3lxOVZCd0hOWFlWQkNvRUN3NGVEbExEQ21OSUFXNlFtaVJK?=
 =?utf-8?B?NEEyV2VPcUtGK0RUWDlJOWFiVzZ2UnVacnMyZzZybVNTZnY5RXZ5ME92dnEw?=
 =?utf-8?B?Qi91RmphQU9SK0NSQ21WRm1reXRSNUxNdDV0bW90WFRyYStneHlCZ1RBZFB4?=
 =?utf-8?B?Y3VzaDh0NmxHZGlqVk9vdHFxRjN1d2dMaVBCYWdjOXkzRW1UYm85MitEUWhv?=
 =?utf-8?B?WnprcUg3bHhpbHQ2N1JmdDJ3QU02VVhhYVcwUWtRWjlVMFlHYnFhZjhMcFZp?=
 =?utf-8?B?bzdqUHNicUV4SVRQaldYTVlyLzIxT2hQckRHT29LZThteGZNN0hSNE10ZHpI?=
 =?utf-8?B?UzlpaTZJeGZjZjZCVzRTdG5OaDJkb2ROWE9uaFlCSHpOeDJ5Tk9uNzFzSmlU?=
 =?utf-8?B?eHkvL0tBckZMSkwyMHhScEZkL2draTN6THVYdGdwMWtJdkM0eC9tMnZFeEhR?=
 =?utf-8?B?a3I2Yk10NzQyWUhxT0doQ3IyRWgyZE9IeWMxRjFiVUtlUHZSeW9wbWdJSDQ0?=
 =?utf-8?B?dDBVUGNJL202ejNhdk5qRVFLTFRFNGFNZ25qN001UkZCWmpZZytPdXBBanhR?=
 =?utf-8?B?MDUxYThyempPS1FZeUpya2FxYldhQkhaa0JyN2tGbWUxeW82YmtMcm5EYm1D?=
 =?utf-8?B?cThwcnFCK2Jxcjg5R3pGODZQZnlHSktXUDNxNWQ0bWdIZGdqczZnTm9PVnZP?=
 =?utf-8?B?NjN3UmhhTDhxaS8rYUpsRTg1bWE1ZmhpaDg5bjJab0RmZ054K00wSjRuVWk4?=
 =?utf-8?B?SGUvWHBWMnRIN3lFd1FYSU9YTVVocCtyeWVXMDdmUHQ1TThmUENjYzRYdVN0?=
 =?utf-8?B?SUd3b3RXR0Ryd2ZtdkFCLzNiM2Q4ODhxVnR5R2pMQUg5N3Jzc0kvK2pKOWFQ?=
 =?utf-8?B?Q2ZFY1VBM3o2dUd5QWdHWnQ3QzB2MVhFSzh3ckpKTHlPRVhsVEZjbEZXZGFK?=
 =?utf-8?B?REN5N1IyZTNTVWRNTkVhTjR0eFFrVDZ0UkdPenUwOW5nTXZ6eTNaMi9DQWYv?=
 =?utf-8?B?dEJFZ2VFanRORzR6MmM2VytTai9zY0JYSERXQk1QNXZwekh6T0ZHeENlTTc4?=
 =?utf-8?B?b0p4cXhUTnlqZmluYmc3TmVsbUkyc2RLVEpnSngwazJYWlU4b3V6UldUcjA5?=
 =?utf-8?B?Syt3SjBzdkdpcGc1dkJkbHBFM2wxTDJETHRlOFg5WTNYTk1qdTRlK2J5clJx?=
 =?utf-8?B?NGc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	f5+FF7OGUIKb0y6OHoMvmknGaZ7LOVjCTC1C/qkSQE9UEQs78RRKo9x+LapYFWnrqxp1xKXABW6VO4KbEfJBK1imMprepoF/1H4rMbkMg55uy4zONai2Cq84s73RrWJZ054FJNSs3Uje+L8djYK4o5czLg5XwsDOKTs/vfX4GLJvZP2Yho+Sfg0BtLXcSQyX5jOZ7eWj8MVG87gmK1F3ARP9p5j4YCEWid5lvGRFwkLQV52hH/zng4i3//h1GpJoOTpP2sO8VjJigfaWpWvdcwEK5oAUJN3ibH4lY3VDMk9nxKbVHA7cCYcURii5HD5K/QRq8tOzfRR1kNNKztPuh6tyfzJDvmcBmV73rxdZAm30UDmFQaUZF9UOL4pntJaKwPXI0SpM87R40gPFWCjG/gTlDegh/W1hAOYxPYEk9clfBXIsXOh72y6SJhy45ZjbMJhooApKnSuMxWG7M/D0nbHQqNciP7Z9s95bcyIb0QXE5Wa9qWQnjckIcuml3madunMjRYV0KpMv8jzah3tWTLDpskYK/gC3CKNTbh/FNSZ3bRvLZNOiLqBfnKX1QyZGtFF6TYwcB5+nZEParG2+xyXmDuRPzH2GAqhke8eVUx4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 047d05e2-939d-42c8-8751-08de0758e799
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5134.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2025 17:25:55.8764
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CRDZ5UgDlIzgctLMtuu8cGum4wy/KKln0hjYqLikf90tjRTECFdZ7ezzTHvgwfYqHn8/U92fJrIHbJkCu7Stvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB6984
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-09_06,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 phishscore=0 spamscore=0 bulkscore=0 mlxscore=0 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510020000 definitions=main-2510090106
X-Proofpoint-ORIG-GUID: y5cdAW30yUJslhz_gk2cMZsQghZpM1rS
X-Authority-Analysis: v=2.4 cv=bK4b4f+Z c=1 sm=1 tr=0 ts=68e7f02b b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=20KFwNOVAAAA:8 a=0PBavCl-0dfLCe-xG8IA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: y5cdAW30yUJslhz_gk2cMZsQghZpM1rS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA4MDEyMSBTYWx0ZWRfX98iiqvZmkKCf
 1mdcJK247ElWoHdLCQP2E80AiuPHqHHEGNNHFog1zsdvwOGxnwEosj42Cw2B1AAGfOo3DhS2FzD
 +veWbov0+ihM1PGwEoSotMY/pHh4nqT9ku6uXvr+VbjX8CPKc4XUZuOVP6PiQQlFXu2+JS5CotU
 6NljQuQaslOytEz5mARHdSf36x8ra/OMD6monsxgOMFgfkgadvlv/G/S6Bf4d73ef3H1CgVBRpB
 FMs/UUKSwepkrCSOiDxdvC9PS9xXCimdmBlk1TxLWOdBcBkQyj9HRWxr/33oZOMdFeC3VbRTmXU
 RLov1XVrqUF54zULvfbTaKU9jX5tLJ3o3heanTTctAUqb3dsMQ6PZLhVSwT5qV5QtKHWyL6oyRo
 Vi+AGT0E2BOpOcLJBrjaDCdmr/IRHw==

On 10/9/25 1:13 PM, Chuck Lever wrote:
> On 10/9/25 12:06 PM, Olga Kornievskaia wrote:
>> RFC 7862

And, let's add Section 4.1.2 here.


> says that if the server supports CLONE it must support
> 
> MUST   << BCP14
> 
> 
>> clone_blksize attribute.
> 
> Fixes: d6ca7d2643ee ("NFSD: Implement FATTR4_CLONE_BLKSIZE attribute")

I will add a Cc: stable here.


>> Signed-off-by: Olga Kornievskaia <okorniev@redhat.com>
>> ---
>>  fs/nfsd/nfsd.h | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
>> index ea87b42894dd..8cda8cd0f723 100644
>> --- a/fs/nfsd/nfsd.h
>> +++ b/fs/nfsd/nfsd.h
>> @@ -459,7 +459,8 @@ enum {
>>  	FATTR4_WORD2_XATTR_SUPPORT | \
>>  	FATTR4_WORD2_TIME_DELEG_ACCESS | \
>>  	FATTR4_WORD2_TIME_DELEG_MODIFY | \
>> -	FATTR4_WORD2_OPEN_ARGUMENTS)
>> +	FATTR4_WORD2_OPEN_ARGUMENTS | \
>> +	FATTR4_WORD2_CLONE_BLKSIZE)

Nit: shall we keep these in numeric order? CLONE_BLKSIZE should be added
before XATTR_SUPPORT.


>>  
>>  extern const u32 nfsd_suppattrs[3][3];
>>  
> 
> 


-- 
Chuck Lever

