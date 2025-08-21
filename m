Return-Path: <linux-nfs+bounces-13856-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81DBDB30324
	for <lists+linux-nfs@lfdr.de>; Thu, 21 Aug 2025 21:45:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 501CBAE0CB2
	for <lists+linux-nfs@lfdr.de>; Thu, 21 Aug 2025 19:45:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA69334DCD6;
	Thu, 21 Aug 2025 19:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="V3g8+IPJ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="WvcA7Gal"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44B8E34DCE3;
	Thu, 21 Aug 2025 19:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755805508; cv=fail; b=iZLGVuoWySJkZNwxwtptUenENLuc65QVH+6/8sIbbtvI3NF+WD5OMNRgLHxDK8UR4V57Y2RGKr9p/DfBX5oRpmspv3T7DXRKSGebJKcydHK1YlzF24+6ipyekSEWAF8WY5SvDuTHj6CVnWVGIKCz+Fir7816ebvWl4yezoGtsig=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755805508; c=relaxed/simple;
	bh=jzoMTNhj4BxXoP64nROmPInfDPP6LItp006XEx9lk60=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZFJDtJRV8CeorgA7DQHaQENHM8sHP2L/xehFCOEJOFT94MNgwML36VVphHxIEElXAFqCgfYyQ/poNXwZoX/aymhN5+3CjTjcOUpo1Qt4O8qTXdgfklev0QSryKpTYDuH2p5ubtYSZC0wTP/5rV0LrpJHHzTPSPt7TpyG08gHCEA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=V3g8+IPJ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=WvcA7Gal; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57LJhFGf017334;
	Thu, 21 Aug 2025 19:44:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=auPLtvASyqHfoX5efoXyOjanM1Hvzu1HQ/OqrCEDsIE=; b=
	V3g8+IPJ9/1DeLmvRaWHH6P1Sf16iuV0KmI9MLzSDLbZ/gPcYDGlwAUHW5Uliuc+
	3WuoxMFbL7TIlpKHh5JLy3tilNN8RBqqtpR6XJDUAod40uvnM+hi5hniYa64EHpX
	j4G98/2hcyrmHXAKi11H4Y/9b8mY3abnbWAsQzSP0Jq56WRhkWDgqOnXrH5859ed
	WSH4d241NTaQ9M7Oess9e1TCebVIlwpqh6JOkOHlfP19QCDrIF9kmxk96dIR+41P
	MvwuTn00SlYCLDvmBraYU9TauPUxX5vGQsBw+5EV/5Bt7Gre+EpmY9PxTdeACWV8
	O8rX2W5dBejiNZ7EUECW1Q==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48n0tscb0a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 Aug 2025 19:44:58 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57LJd9Wf039486;
	Thu, 21 Aug 2025 19:44:57 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10on2077.outbound.protection.outlook.com [40.107.92.77])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48my3shajc-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 Aug 2025 19:44:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gLPcZ/VY5hrVyK17kAt1Q6w80whfwFs9UhPh+AY9IT4rdUctvY+4nCHop7Ghl/0gaE8dB0+RE6f0huAcOB3WqyQlbCfkwVs5rHzu5qFl99W68NDEnFRX8qAzyIM04VaD4dk2Ty8q1aitC93EFlq9gO1k6LkAwaqXRRYnIMIDX5hjOJAr+w8FINT9mZTB6HNt57GQ9FjnllJY+VXTeEbS0tZcL9DKHskxCP+6hp/I1/3BNPTfzcSL4luxNkbD5tZ4u+JTYKAXrjbhOdgnFQDgFIhsIIteCTcS8Z3YnMEFegqjZrJk0c4/4QMAZVePcu0iVWGtnOspuQ2kzOY8Nwv8wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=auPLtvASyqHfoX5efoXyOjanM1Hvzu1HQ/OqrCEDsIE=;
 b=o4V2jVntAHvsRrordI14PYDq/ZmbtKdcvZ9I2WUmp3N/jdgZyOEzwUeFtSSHiYmbqRpBSjeVZDTdBnPfQcyM0zPVq4p947MkSLaE/GPUhIOrWtApqoLlb8F6dljoXk/cZtB7vNHMhssYEv/guCd30BT1H4zztxpynfuP74OpUT8fF5HzaJmXdBSlAu0H7055Cuahq4HCGLoY86olww90KwfPkOU6LrcunbR5o3qbxyPMqs4G8hbH3YQXl3i22ruFAqqAN5ETqd/BtUmW/7KlUrCVnwWb7YEA4OI26bMj70d6v1R8c/Y12d7dSSqrZsfpj6ORzyXrSZFcUQd4Y8eUdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=auPLtvASyqHfoX5efoXyOjanM1Hvzu1HQ/OqrCEDsIE=;
 b=WvcA7Galz4jbCzcKH90zVSPG9C59rHUFbKoma8kKOWv3WxbzyAG4jAFvXMQAhRmqqoe1X8GP6zfQJrFn8JLxrYFvNOP/MPu2R2B5RsHHZwitS+5iYqk9EyEkXbVFbZA5zS1iHjgT4NVoiVg/rR1XAw2tRqcyR2PaT/8pVOttpSY=
Received: from BY5PR10MB4290.namprd10.prod.outlook.com (2603:10b6:a03:203::15)
 by CH3PR10MB7234.namprd10.prod.outlook.com (2603:10b6:610:128::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.25; Thu, 21 Aug
 2025 19:44:54 +0000
Received: from BY5PR10MB4290.namprd10.prod.outlook.com
 ([fe80::8c24:37e7:b737:8ba5]) by BY5PR10MB4290.namprd10.prod.outlook.com
 ([fe80::8c24:37e7:b737:8ba5%2]) with mapi id 15.20.9052.013; Thu, 21 Aug 2025
 19:44:54 +0000
Message-ID: <af5751f3-6bb4-41ca-968d-78e8a766b668@oracle.com>
Date: Thu, 21 Aug 2025 15:44:50 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] sunrpc: add a Kconfig option to redirect dfprintk()
 output to trace buffer
To: Jeff Layton <jlayton@kernel.org>, Trond Myklebust <trondmy@kernel.org>,
        Anna Schumaker <anna@kernel.org>, Chuck Lever <chuck.lever@oracle.com>,
        NeilBrown <neil@brown.name>, Olga Kornievskaia <okorniev@redhat.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
References: <20250821-nfs-testing-v1-0-f06099963eda@kernel.org>
 <20250821-nfs-testing-v1-2-f06099963eda@kernel.org>
Content-Language: en-US
From: Anna Schumaker <anna.schumaker@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20250821-nfs-testing-v1-2-f06099963eda@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR18CA0024.namprd18.prod.outlook.com
 (2603:10b6:806:f3::33) To BY5PR10MB4290.namprd10.prod.outlook.com
 (2603:10b6:a03:203::15)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4290:EE_|CH3PR10MB7234:EE_
X-MS-Office365-Filtering-Correlation-Id: 308932e7-fa24-4751-47c7-08dde0eb3342
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|1800799024|921020|7053199007;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?eGJNNDFHNFAveXQ1ZFRIMWJhb1dldUNEU0ZSVWNBb2pmUTlSbzU3QXlNc3FZ?=
 =?utf-8?B?RDg2NW52N3ZjQ2dHYkgyYTVZQzlzUlNsbjBJdlBkVnh5dlZyWVFyMEU4RmZC?=
 =?utf-8?B?VEozTzdRdkhZNGM0Tkd1RElCdjgvOXJxYWVHdnlLOFF0TVpiOExmdDJJOEhM?=
 =?utf-8?B?UGNQUGREenRUc2N2bWRVZW5VaENQY0MxSXErTGx1VjNiMTNnL2Z2YjRsV0RD?=
 =?utf-8?B?cS9tTkpnb2dsVGZScGpQWHExUmwzN0p3aldabXRMazd3NXVXTk1OYVdaMWVk?=
 =?utf-8?B?UncvQ3BIVE1IeUIvVXNJRFlyZWZZU3pNZ3BGbzNweGNMRzlMUjRXUzJnVHRj?=
 =?utf-8?B?ZlRIU2lCQ3VpSllGVk8zcFRObEl3RjYwYjlWeVdEL0JSdUpOT29TNXlveisr?=
 =?utf-8?B?ajhmSmFnaUhJdldYbi9URWw2cnhVTVBLZFY2YVVKWStISVJFcjJIQVlSY3d1?=
 =?utf-8?B?MDlRK3NZdWZmY1NjbTFpZUo1WlRYQkVicGFjZzhTaE94K1pHejFkZlZMVHp4?=
 =?utf-8?B?RjBkLy9CSnF4YVdIQ2xIVTM0NDFJNHIwNmM5OXl5VkVUOFFYdGI3ckRzWDlI?=
 =?utf-8?B?ek5RT2hqSlNSaFRDalc3aGQweUdJTDM5RTd3dEkrdXljNW91a1BLeE5WdHF3?=
 =?utf-8?B?bkhFaDNjc2h3QzJYUXg3RlJPWHRBY3ZFWGJMQWNpWlVpZ1RQYTY3SlJCbGkr?=
 =?utf-8?B?Q2xqcXdubDVLcG1QcS9zeUQvQWhpa3ExZjlZZDkvT1FON1k3T0Q2bldSUzdi?=
 =?utf-8?B?THlXTmJzU3YzUENna1M4T21MeFZzYytNWWd5TkVIcW85WDFRT0l2bjhJdDJJ?=
 =?utf-8?B?Y2tXNmszTGVmc0ZVMUltREpJSVB3dndDUzRnaVhXaGN6UGlIbko2NFFnRC9j?=
 =?utf-8?B?ZmtxYjQ5bFU4OStsc041NEJWL1B4Z0lNMHgwQUM1VTFJWkxNZHZXQkVkeEl6?=
 =?utf-8?B?R1JQT3h4RVMzd202NEhoay9JMFlaWXhGeTRUaGd3b2xHNEZOVFFNRjVQV0h4?=
 =?utf-8?B?MXg1YVlsdSt5Zm9Sd1llVUEwQnQ5UlFnbDkrcTZlbmVnT0ZiOXpseHlVUnFZ?=
 =?utf-8?B?SS9CbjBTN2JlWlBmR3V3N1BuU2Y4WEp3QXI5OU56bnJtT2xxdzZvSnEwTmhx?=
 =?utf-8?B?UFpZbEF3MDl1bUdsaUhRbERmVFBxWFdNclVkck1Fa2lCcEhIZlFSVmVwZ1NC?=
 =?utf-8?B?L3BhTkJwbjFydXlCQkxTVWgzdHhYMmQ2N1hOVzZCSDZBc2ZXMGJJM0ZEZWJp?=
 =?utf-8?B?UDNhUDh6dS9IRDVtdkxOT3NtN1pwekdDaVRJbGZneFRVYTl0RXhYRHBlMUY2?=
 =?utf-8?B?bVlYYjMyRXlqdkE5M1BHZHhjVkhwcnN5djEwWnpBQVpnaFRMZU4xZzYwdDZ0?=
 =?utf-8?B?WEF0bmlJNE55dUxPV1MybjNBNW5wSFpKT0FSRXp0dWhPWGkzVUtIZUtodnBy?=
 =?utf-8?B?U05lSUtHK1Y4VmNvZjBLLzVqcTVWM2hjMm9jblE2Z29oWVZFWWdiRjYxWk5N?=
 =?utf-8?B?T2dwQkIrOFJvTW9FV29oSE1zaTNrRHRPUHBvU1dhR3YyVXlsZVZINjJhb2FH?=
 =?utf-8?B?dVBwOGN2RGNBWlRra3IvRkYxQkdSdElnSWg2WmxRVWZWMi9EaHN5d1pWblZx?=
 =?utf-8?B?R3JvQVduYTg0b3FVQTRrSjVoODhVeVMwdDhzUE1JLzNEOEE0eDgvSm9zblVa?=
 =?utf-8?B?VStUWjZEVzNwdzMrNmR1SEpGb29ZWFVMN3FQMUhibW1jSm9VRnlmU0pMOThP?=
 =?utf-8?B?SHdLYTNiYUdyelNKVGFzZUlCTTJkaWpwUS9FNWxxMFVGMW4rUGxlVjZMdTJB?=
 =?utf-8?B?eWZhcTBBbEpzTjlzMExVV1ljeS9rNGJIYkJiNmUrbVpNK0orZkI5V1ZaZ25n?=
 =?utf-8?B?Nmt1OTEvQVB3VUlBR095OThXbVNNV1RsdE9MSFd2WFlTTEJEMHBKaGRXOW5L?=
 =?utf-8?B?R0UvQWxtSDFOOEV4R1FYOHFmVzJaYThPaXB2cDZKWExwdUFFUU9aZzVaK2ZJ?=
 =?utf-8?B?elBBcVZZUHlnPT0=?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4290.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?YWxJYmI1cUdrZmc2WStjOHRvSVlnaEZ1ZXJ4UktnaVU5STBFOFJzVjdYTEd0?=
 =?utf-8?B?Q0cyUnVVL2ExQmlWaWxqeWd6ZllLbVh1TWZGUEpEWjcyNDZNcGU3NEIzbEdV?=
 =?utf-8?B?QU03NUdLVDJaUExzYkU3L3dHU3FFZVRWcWhjNWN0VHpEblA1VEkzSjQ5T01k?=
 =?utf-8?B?eWM5KzZVekdzTGZ2R3JmcmI5cjJzRy9kdXMyMlZHb3RkRnRTWk5VL3pRVUZq?=
 =?utf-8?B?TytLdjJvc25PNVdPRkZyNUtKNndCV1NyMUJtYXFmM2QxOWVxZ2xLSGU0dFhD?=
 =?utf-8?B?Tm4yUmNiVDQ5RzlON0NHNEx3YzBYKzFiYWRVSDBmYmFibWtLcmRsV0tHWTNo?=
 =?utf-8?B?YUl1WW4vRTFldGJBZGxqcm05blJldmNVaHh6SHJMS3EwL3AwcjVrbnhaMDFB?=
 =?utf-8?B?di9MRHZneWpCT3dXcC9PWjhHVGZJd0dJRjdrOFkwTVFkYmh5dkhWSjI4L3N4?=
 =?utf-8?B?NE14VTdKTktuVSt4N1h1Y2t3M0FoWVBIQ1pSc3RHcHJkMGplV2YyV1k2dGVE?=
 =?utf-8?B?THc2WXFtTlNSZVp0NkU2TmhObHM1T2xzZXBSWTZ6dnByU2h4cjdRMzhqS3VX?=
 =?utf-8?B?dkFRZWQ5Z3lFdWloaFI1aVB6TDhkSHVvekFuM2VsOGQyMmRFQTY0aDZDZEd4?=
 =?utf-8?B?VTRFbzVZci9JVkNVZUVwQldhdDZCKzBZTGdLTEN4TmRlYmE3TEh3ZGx3c1lK?=
 =?utf-8?B?ZUZVejYrSE0vZEl1c0JsUUhyaGZ5WUdhUE15MytKd3BWcmxGUGhGTC9QQm8x?=
 =?utf-8?B?czd6Z3FIbm9ZMk85WGZUMkx3NXV5WHR2MnpFeHZ5K293YUJ3aVFka2VsZm1a?=
 =?utf-8?B?TDJLRUd3RTltNk0yYTQ5UFJSTFV1UkRmaXVnOFZpeTdzWXBvS1A5c0NrTWNn?=
 =?utf-8?B?YlR1aEtuZDlrdmwzdFp5ampHNHg2Sm42RnJaakZodm93UnFtYUsycklLWm9v?=
 =?utf-8?B?Z2ZXV0UzV3BBVGEvOVd4enNYVVJoM01JZmE5ZXRCc3A3NlF2WHJmRmYxRkdV?=
 =?utf-8?B?czJMSHBqSm5Hd0Mxblc4VDNMUXk4Z1g3eHVCSWNYeWlhWjNKVTVCelgxZHM0?=
 =?utf-8?B?dlVHblN2UGlOYytxUEdQUnhHNCsxVVJnbTZ0eG9BUjJmNko2ZnJzcUpyNWl2?=
 =?utf-8?B?ZWc1V0FkdHp5OVBuNHJzeWVIKzViQUpSb2F1TTVheFRGNkM0TktJVEFxUFBx?=
 =?utf-8?B?YlJta29GN3d2Y3dkVXZOK28rZXE2TVpJY2paekV6WUlzU0VLNnUrUHY5c3N0?=
 =?utf-8?B?bDYvSGJKV0VsREsrdWFwMGJPSnM1eGlpbW9waExVNG9jUURrYWQ0akVCSXRW?=
 =?utf-8?B?WjZBUXdpdjdXSDl2VVo1TkFnYVIvL04yYzJxNGEwbVo3VjVBbzVmdVlwTXZq?=
 =?utf-8?B?UDFKbUdkQkpUWHliRGEvRmVLYmgxd0ZjUjRER2FPZUZFVjFiZytuTDVOaDJN?=
 =?utf-8?B?Ujh0ZURxRTkxUE0wM0cvQWtORlBGZTV6cWdjNGx0a0daTlE4d1lxZlA2aUVo?=
 =?utf-8?B?b1JncDF2Rm0yTERuYitBYnRoZ0YrMEZOR2diK29KdDQrOEt4UENPK0JGdFBV?=
 =?utf-8?B?azVYdkRXdjJIMFRWbTRtNjFyWUxNQUJydDQycXYyYTRvRGpvT1QvRmFQVDVH?=
 =?utf-8?B?bEU5aitvaFJHRnNaTVNaWFA2UDVHMW5HR2ZBV2ZsQlU4Z2c4eHRmeDJvdFZT?=
 =?utf-8?B?OW16bGpJT2pNaHlHL0hBRG8vTEkzVVEyMHBkbGgycXVQam1Pbm1MNThHRFpG?=
 =?utf-8?B?VGJweEdVK290RU9oaXo2S0VVQXdrYlAyMytpcEdHVjkvdDlOVmpOaGwvYllv?=
 =?utf-8?B?MlJqcXpCYU9QdFNQNGpKTzhEOG1yeXl6anVxMzI3Sk5idE55clhiTG5IM0w5?=
 =?utf-8?B?YjJDN3VkQzY1SGxieUhjZ0hIcGxyOUpPaGNZY1UwWHJoWGhDUFlnK28xQUcw?=
 =?utf-8?B?anZMN09WcFdoMUdNU0xES090SVRxT3djemJHNWNkK3V1N25IaUNFdGVwS2pL?=
 =?utf-8?B?RlJWbFFsYnZ1NGZyUW4rbUNOTjQvK1NPbCtmcXV2MnlhQkFtb01lU2RIZjdp?=
 =?utf-8?B?TUxOWmdIRXZYNmNJUTRHQVFIRTVCSTZKOWJVOWM3NFJJSFhrUG1FQmdTamF3?=
 =?utf-8?B?aVJ1Y0tzS0Z5UEc3SUkvdDh5akdGaS9GVHZCNjRhRWxBQmx4eElVaThwV2Vo?=
 =?utf-8?B?Q0E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	9Qlh1mvsjJvqGcafpIXYxgg9+qKkYzsRb2n9XBbCe8wrIZDvEA/aSuH9l5BxruGsrk1hAY5T/8ZyW1nKEKp4d4mYHAu/+jBkXdZiVosZXzETyfjp2gSzIsPgjWvwXol96JQt/Hcni70MqCY6aZdm00s1O999tioNJRVHEgRZ3QNf8IUr6K+aFz8a6P7zPdORHjaZmMcHvI08MHA7bc4hSHfAeXMMMwbL+hB2oiYDTWXVzO822VIVAyfPDqpcF6rr+ETPCy15rf6FMiuqSExGsxRY4dHIDl7fRkNLH3+GgqpRLfALIdfKw8ATH4pqS6WlC4fDnrMHH+omDPvMqqPemqnsMZvoy9CmVC9KWe7GEbJXU+kuJfmzjk2wlLLQdPmnl9HtyjsdICjDSYuNlVMat6ZxJdjZMRNj9sobRUh4rCaPsOIyp1RQvLpG/LQOvhmhRx7Wj4zOtrGHZwnQyC8eH0WOfEbil23jAoOAW6LpwbmpZVFPN9ji0bXxZEWQoU1+hDpTASyeS1PJ80kEmNOBYkIs8YKMOjCYo034YZstpDZcL6cop7jl42IOD2QbpVIX1TLbbwFeh5ABymerRnKppDKDwfDHbbMAJduUNNQjT9I=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 308932e7-fa24-4751-47c7-08dde0eb3342
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4290.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2025 19:44:54.3631
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i2Tj/s4ibrFbLnaDN1f6iMwY1OPp/vu2Iphb1U7hT/3YyXpsDC6sE7o+yVPbVGkv+xQwuAmTwfjMc2zoiQJ+Oyirz23ju/xKJcTBk/HW3IQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7234
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-21_03,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 adultscore=0 mlxscore=0 bulkscore=0 spamscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2508210166
X-Proofpoint-GUID: -TcroOiw4pB5Ghl_3FuhQj8DyiBwnj7k
X-Proofpoint-ORIG-GUID: -TcroOiw4pB5Ghl_3FuhQj8DyiBwnj7k
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE5MDE5NyBTYWx0ZWRfX1v+SMnrdWPnM
 F7vgxGcjX1fOrUc1oVvaaEV76bqdbpUe6pesxqcrrDdd8+gdYf3oAVbUw5DHDbKtfoL8h8V5d6P
 i35SH0faMqYuVrCK2ziYgDZ3WmAJ1c3Pvy9T2ukNhw1x/Ji3smwMsB+xGvw0iEXh1nmNALiqN/V
 zzy+05G67NunmDcr5Bs3mUxKdKm3nfE26e4gcPB1CQZ8s87D3Xrs25RuiDLS1fgff5Dsj4Ib+4s
 iDbRonuzP53h/aX2pPpr+wBJCFU5Duir1Hwjpr227xkwn/LlkjwBBU0t+7B+q9Eu7wjLWf7w/1m
 nW2lZNKZ6/plwNu3+PbeLrwSgT0HU9+/ov6fdFKRBShcFMUw4Csi/jiZFaXYSl18SDgah+na6vb
 6zxZhDS8f9s8V/RPe+6nKTAQIY/PQQ==
X-Authority-Analysis: v=2.4 cv=HKOa1otv c=1 sm=1 tr=0 ts=68a7773a b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=6cR6c4hVAyXGbzQBJkAA:9
 a=QEXdDO2ut3YA:10

Hi Jeff,

On 8/21/25 1:16 PM, Jeff Layton wrote:
> We have a lot of old dprintk() call sites that aren't going anywhere
> anytime soon. At the same time, turning them up is a serious burden on
> the host due to the console locking overhead.
> 
> Add a new Kconfig option that redirects dfprintk() output to the trace
> buffer. This is more efficient than logging to the console and allows
> for proper interleaving of dprintk and static tracepoint events.
> 
> Since using trace_printk() causes scary warnings to pop at boot time,
> this new option defaults to "n".
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  include/linux/sunrpc/debug.h | 10 ++++++++--
>  net/sunrpc/Kconfig           | 14 ++++++++++++++
>  2 files changed, 22 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/sunrpc/debug.h b/include/linux/sunrpc/debug.h
> index 99a6fa4a1d6af0b275546a53957f07c9a509f2ac..fd9f79fa534ef001b3ec5e6d7e4b1099843b64a4 100644
> --- a/include/linux/sunrpc/debug.h
> +++ b/include/linux/sunrpc/debug.h
> @@ -30,17 +30,23 @@ extern unsigned int		nlm_debug;
>  #if IS_ENABLED(CONFIG_SUNRPC_DEBUG)
>  # define ifdebug(fac)		if (unlikely(rpc_debug & RPCDBG_##fac))
>  
> +# if IS_ENABLED(CONFIG_SUNRPC_DEBUG_TRACE)
> +#  define __sunrpc_printk(fmt, ...)	trace_printk(fmt, ##__VA_ARGS__)
> +# else
> +#  define __sunrpc_printk(fmt, ...)	pr_default(fmt, ##__VA_ARGS__)

This is the only reference I can find to "pr_default()" in my tree, and my compiler isn't
very happy about it. Am I missing a patch somewhere?

Thanks,
Anna

> +# endif
> +
>  # define dfprintk(fac, fmt, ...)					\
>  do {									\
>  	ifdebug(fac)							\
> -		printk(KERN_DEFAULT fmt, ##__VA_ARGS__);				\
> +		__sunrpc_printk(fmt, ##__VA_ARGS__);			\
>  } while (0)
>  
>  # define dfprintk_rcu(fac, fmt, ...)					\
>  do {									\
>  	ifdebug(fac) {							\
>  		rcu_read_lock();					\
> -		printk(KERN_DEFAULT fmt, ##__VA_ARGS__);				\
> +		__sunrpc_printk(fmt, ##__VA_ARGS__);			\
>  		rcu_read_unlock();					\
>  	}								\
>  } while (0)
> diff --git a/net/sunrpc/Kconfig b/net/sunrpc/Kconfig
> index 2d8b67dac7b5b58a8a86c3022dd573746fb22547..a570e7adf270fb8976f751266bbffe39ef696c6a 100644
> --- a/net/sunrpc/Kconfig
> +++ b/net/sunrpc/Kconfig
> @@ -101,6 +101,20 @@ config SUNRPC_DEBUG
>  
>  	  If unsure, say Y.
>  
> +config SUNRPC_DEBUG_TRACE
> +	bool "RPC: Send dfprintk() output to the trace buffer"
> +	depends on SUNRPC_DEBUG && TRACING
> +	default n
> +	help
> +          dprintk() output can be voluminous, which can overwhelm the
> +          kernel's logging facility as it must be sent to the console.
> +          This option causes dprintk() output to go to the trace buffer
> +          instead of the kernel log.
> +
> +          This will cause warnings about trace_printk() being used to be
> +          logged at boot time, so say N unless you are debugging a problem
> +          with sunrpc-based clients or services.
> +
>  config SUNRPC_XPRT_RDMA
>  	tristate "RPC-over-RDMA transport"
>  	depends on SUNRPC && INFINIBAND && INFINIBAND_ADDR_TRANS
> 


