Return-Path: <linux-nfs+bounces-15840-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24BA9C2532A
	for <lists+linux-nfs@lfdr.de>; Fri, 31 Oct 2025 14:11:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DB694636B9
	for <lists+linux-nfs@lfdr.de>; Fri, 31 Oct 2025 13:10:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71CA334A789;
	Fri, 31 Oct 2025 13:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="J8ngl2bq";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="FDSRZQWA"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA40432AACC
	for <linux-nfs@vger.kernel.org>; Fri, 31 Oct 2025 13:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761916196; cv=fail; b=cKUEgi4rbanevir9c8/t1jqCNFjdCM5AU8o20sesWQ2+SARVjeLAnzABJARkZP5ykTdzOJo5cx+uCGJ2fCjNhKUJwCYv5IQQpX8kFWDs2xFpcYuwjuvWa22vTZHjMEy0dtWO4YTZWFhHr5vScgHGs/0564HSnJ1IhOPVIPDeZ58=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761916196; c=relaxed/simple;
	bh=Hr4eGY2gSeXmvhIqpWBhWm9YTtaBVrtRI5f8jSUKAlM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JUtL3aiLW0mhe/KULNivELqcynXpJiobp/xzMl8HDcxqeaW7KpDuWKmX0/ADtJhmIH5S+YlERw3mH88jKgHsg1ajPP3y+xhiK/NeTIUdPxj1MB1HGLhBI4/Nm7t9bwkEAu+kSPuBup//yg1cuLIMTudJ2WcXSdvW18YKGp0+h8Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=J8ngl2bq; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=FDSRZQWA; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59VD4FBo027471;
	Fri, 31 Oct 2025 13:09:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=dQ78p6+n6/pCW1jQw1UyWse0EG/yGI8kBD6RIB/pvto=; b=
	J8ngl2bqtMy9a9shPZwmmacY0EIZZH6HGIsakDzEFiYAHUL//AoF1Gar+8sNoOj9
	BL1XZ9uyefN9Ya5MMTrAv0ber9rBOdt43M+z5Gf1vIEbWN+8UvPXOXZRkyCiJSQd
	iASGKpRKWNN2OFwZqljiE1wGnI9Drqd8Tx53ps7l6cOadl4T+NLaXMa2e4d5pfRp
	OpAzAvKrcjKFDP8ZGwMJegWokrqx89fW7ZCXAB9Zclq/Oi/aP3n6vnGWVUtJFnQE
	84qOoTaHquubGJt3H3OONbIKXCaVpMt9TTVfjxCeZeOJuugXyufe6w6i2X6+lYiU
	jrJeuBQV88emcSD+6kX81w==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a4wp300j2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 31 Oct 2025 13:09:48 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59VCunsE007790;
	Fri, 31 Oct 2025 13:09:47 GMT
Received: from mw6pr02cu001.outbound.protection.outlook.com (mail-westus2azon11012048.outbound.protection.outlook.com [52.101.48.48])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4a359wna9j-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 31 Oct 2025 13:09:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kJS5K1rnsFC/8Aza7igO9aC5p/jIhFcmLJRUcxlR9sRa6xeF0vZYYJ4r/dckiMa6tPvfNisJaAwt3BX1IYUQQQJfGaFnYjr6gelVWy7gAJOEsmx10zPlVTb51hvnmCOKiHZAqeSDWJy8qko2sPwHjjIi9ipnKddoNgbUGrSfS+3Qa66hPbunniEcpEJWP8DD6p/Fei4pJyECnjHZPvOrFOd3UAEhR9fElFmI+n3kJPTSQGYB47Y8ViBSssqRk+djU3REDTMvC8E/R+K8UqHWw+RX9IA11Fgqr6vtualdhYNEniZHe6NcPPcQ6UT5L4+9cjhz/yWYu4nnBJ+XKoGGAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dQ78p6+n6/pCW1jQw1UyWse0EG/yGI8kBD6RIB/pvto=;
 b=Kh8x/WlVCVZR6mgi60i4FyymRCmBn2F2O3DgvnGG++lgawwlTnezvbmgjtQZfdfNuT9NR/1Xy3Zf95ZhyREq70Lfky50snEr6iTOKuO3m9qNRNVQJFbSV4hVfK6AycGM2L3tedd2i22Nw/unCBblO7DLtBQm5H/6bd+f5LCDI7gSXqbI0lCmPFYpJhpjkEkr9fPaUZwTKVBug3NS4jvHC3nQkWO6SvzoTM+AIFImIklxY8Tkmh4Qsl+aXHSjn4bEeRmtOsjnNawENrZll9RrIBYE810r1G5R8lFSkFMMNGoiaF5hbVGf0+ul42jqg+A+734xuPVjWNlos8RQX+N8Gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dQ78p6+n6/pCW1jQw1UyWse0EG/yGI8kBD6RIB/pvto=;
 b=FDSRZQWAEPP/DzNjCAGhEyOaB6O7d6lGnKtW6kw5rh8qzVTRrF2xK1OYpOgRdv88Af6+t2DIdUYwJIEmg0gJzwoIxuXjJlmemQiUTJuboHCH/F13qo0PlYljrV2XxJAPe8pkOaeYg+t0/0/zVtNv/9Z7HC/abogBicYjzajgayo=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DS0PR10MB6198.namprd10.prod.outlook.com (2603:10b6:8:c2::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.12; Fri, 31 Oct
 2025 13:09:41 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.9253.017; Fri, 31 Oct 2025
 13:09:41 +0000
Message-ID: <3da1bf9e-12eb-4f5b-9ece-5433839564d0@oracle.com>
Date: Fri, 31 Oct 2025 09:09:40 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 04/10] nfsd: clear fh_foreign in fh_put().
To: NeilBrown <neil@brown.name>, Jeff Layton <jlayton@kernel.org>
Cc: Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>, linux-nfs@vger.kernel.org
References: <20251031032524.2141840-1-neilb@ownmail.net>
 <20251031032524.2141840-5-neilb@ownmail.net>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20251031032524.2141840-5-neilb@ownmail.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR13CA0023.namprd13.prod.outlook.com
 (2603:10b6:610:b1::28) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|DS0PR10MB6198:EE_
X-MS-Office365-Filtering-Correlation-Id: 893879f8-31a7-453e-3a64-08de187ec0fe
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?TmJnUGtuYlJURjZHVjJGdGJQczlFTWJ4RjBxNTRnUHVUdDYwMzZTVmFMRzFJ?=
 =?utf-8?B?bmgxNEZuWHdTMXBZQk9Ud3ZyYU5MTGxxMjFOaEYvUjlVZFpHcm9jNE9TQXBB?=
 =?utf-8?B?SXk1RUo0NldYK1YxcmE4WjVZcU5WbVVYUWorSERXQWFzTzVkN1Q4SUxXaUNh?=
 =?utf-8?B?c2lacTA2M3p0ZldOZHlsUjRwMnRualY3UGZHZW9OdVErbzNET0lEaE1vK3lU?=
 =?utf-8?B?NGNNSjR0WEZKWWdURlhmd2xvNTFkM2dPcFQyL29QbG1kT0JXZVM0ZlZOUCsw?=
 =?utf-8?B?cUVyeGVJUThSYmZrUTl1ZlpqM2lENDFJZEN4dktrSGtBZ2FvbVpKY3ZNQkJQ?=
 =?utf-8?B?TkVqY2tpbHl6Z1FvM0ZNcmIxMk9iQ25EczZ3MUdjWndzSFJLR1RGTFBBeEs1?=
 =?utf-8?B?NlFrRFFPSmN1VTZ3N0E1RnhsaUJFMk5vVk90MEdRcHFpNkJMTmNCQXZzZE5X?=
 =?utf-8?B?cUVMbzJiRFBLekR2UVBNTFNFVnEwWFRObEJzd2dnM0d2YjdWRjdyVXZaQmtt?=
 =?utf-8?B?NFRwWit6QlZiL0Y1Y2dqaktPdlBUT1hJdUpGUDBva1VEOGo3cWRrdXVtYlhK?=
 =?utf-8?B?aEJYbEFrVmRtV0hvZDUrZDVob0oyMlVmTWpVQ21MZDFmS2xHOHlvak8rNVZJ?=
 =?utf-8?B?b05qU1hxeFlnVTBWdGsrWWlBQlhSZlExVDlCdVJ0RHdFZkVOamZPUzFVK2lH?=
 =?utf-8?B?R0J5bjB0Y2s1eUN1RjVnb3JjanZaKzlVZ1ZsVlYvUVlqYnRiTjRJNlRpU0Jo?=
 =?utf-8?B?OVhMRWxvUC9vb3lXYXdCMFpuQWVROFVBeGZCZXQxM2MvZnRkSDZFUnJkMlZr?=
 =?utf-8?B?ZDRvTCs4QmQrYzV2QW0yUjA0NDVvczN4bnhtVFVDQU1lOEx3cHF3RUQ2WGM5?=
 =?utf-8?B?cVIva3RKT1lLUHNtSVlXVVFjNTNDQkxPcWdCcWlBZjBZY1lmVk1yYjluUWJU?=
 =?utf-8?B?aUVzNzAzbEVkOTZxYTZCeVg3NnlGQTl6cWVKMTlGeEltQmlsY0pmdm95NENT?=
 =?utf-8?B?ZDBPRXdldHFYcGNOdVcyUW9iZDBjY0xVMEVCL1ZyYzBjVjA2MnVGQWlHaEk2?=
 =?utf-8?B?ZzVRQVJZYkEwaG0zZEp0aGMzNk0xUys4Nm45MTFkd1hDVDJoUDA3cUcrcXVw?=
 =?utf-8?B?dGNyZkh2dVIrSW5icmxQZjJ6bWlxUEN4TmlZdzVjZ1JMYno2cDRQaUVUTTVL?=
 =?utf-8?B?Vm5rWGpoa0ZaM2c5WXpEWlk2QnR3QUJ1eXhyUlU5SVZlZDM4dEd2UFcveGI1?=
 =?utf-8?B?c1p4bFBMQU5rcjBNVllDVTFaL21kenU2ZHFhUm5jUU9xSDl1NzBGVjFxTEZu?=
 =?utf-8?B?OVFDRTFqbnJRc3JZSTJPOUtZK1FUNlQ4S1Zla0t2RUpIekxGRCs2SWZadHNh?=
 =?utf-8?B?SVlpVVhCZStTcW85K1ZGcmwzYU5IbXJXcE05M2s2ZHZwSnVNd1dDQXg1SkEy?=
 =?utf-8?B?UERla21ncUkxUGdSUmhkWDcrZkIweThhT2p3M0txcis4YzZNOG9RSE1FWkM2?=
 =?utf-8?B?QW92VjlUOFFDZ3E5bDFLb3UwMVhmbWh6bjNieElHQ0RSUXVKNEx5bkNsVTNV?=
 =?utf-8?B?em5ZWDB3V2dpcHdGeTMxbU4rYUprbDNPNk1IWU1uL3lDUFIyNm9xVHNBUm9O?=
 =?utf-8?B?K0tkMi9mVlFYbW90UkQ5Mm9ZK2dNbXVWcU94aDk4U2ZwWXNSWXAzTmlDYzlh?=
 =?utf-8?B?YW9qUW1sdFVsQ1U3Y2daVWNGWHFXTjJ1N3gwM2dhbVVHaXI0WCtpcHExdFJK?=
 =?utf-8?B?dmdVbGRZYzNaQldSd0VaMlduT29PT0ZPRkVYeEtsc2ZUWkJuN0lrYjA4T1Ar?=
 =?utf-8?B?RFE1RmJRd2dWV1MwYWhLcm5pOFZNUVRRTmNyRjQ2YkhRODlRN1E2RHU2RzJO?=
 =?utf-8?B?OVEwb0I0aTVsY3dGU1lPVHNtNVg0eFNwM2Y0Q3FRUitBdWFQRlorQXB4K3Jt?=
 =?utf-8?Q?5tNGowU96HF5F9C45BfBHLP8eNenx8PY?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?RXJlMkFyZytxZ0tRSEQ2c3IvK1BZbjIxT3VIZ0UzMjNNRlNoWnNzUVJ2Y1h1?=
 =?utf-8?B?NlVPRm4wVVBTZGFQb0MrUFFxTDlRME9tMFVmQUdZeUhJcjJjS3JHaTRiS2V4?=
 =?utf-8?B?dEdQYW5tT2NUNlZ5ZlNmZlByUlRRTWhRV3JGaDkyYXErS2g4ck10SEFTMENM?=
 =?utf-8?B?UUsyMXJIT2RvM0VXWXl5dG9wZFRYRGZWRHZ2dWVGbXVzc3Z0cGFveFAvb2l0?=
 =?utf-8?B?UjAyS1FvNmFUZ3o2V2J2bjNiK1BYTDNLWWRoRURzNzhhTysrU0VubjlCYWRl?=
 =?utf-8?B?RTZRWk1xYmFHQzVVUnNrcU1TbFhBRitONXJvQitYQ1Qzc0phVjdYQVB5VU1p?=
 =?utf-8?B?cjF3ZjhqU0RyaG5uQWh1blZvd2ZzcUlKWDNFQjArNHZQSXNTdnVFYnRQZEQ1?=
 =?utf-8?B?Uk5OamVtK2dwN3dMRHZzOEZvUU14R1E2elROY1ZnQlFHUGhWRmhtaU4xK2dP?=
 =?utf-8?B?TFhibHA3TURrZzVESllseENTR1VBMy9xczh1NDFMQ2gyMWUvMkRyOVl1KzQx?=
 =?utf-8?B?TTlFbXFhZGl3aTl0Q3pEYmRQekNNYlJPK3haek5NRklBY0VGN0c2T3p2Z3li?=
 =?utf-8?B?TThZWEwveVNIeFRlbFp0bTAyMUkzRWM4ZjZJRU5ZMHRYcVlmYkU1NHBLbFRh?=
 =?utf-8?B?UUhzRG4vU2ZDV2M0WDFFMTBVOUF0cmU0OVkvUW1yUi9nRCtqN2VqTzFwWld1?=
 =?utf-8?B?U0FoODAxd2RLQlNXb3V2Q0F4cWVqZTdyVE92L3ZYY3RpZC9YZ0Y1MDhTejV6?=
 =?utf-8?B?c3pTSDVFSnQ0aSs1S25TUDcyK1pPZGNlVXBNbnA4T1Z4VWN5bXEwbml1Qzd4?=
 =?utf-8?B?czVoU2RtK3BaTzFhQnJWbTNTakUrQVpoRnIzTHo1eDlyanVpUGdIZTJXbTgx?=
 =?utf-8?B?Q3NqaUFNdFRTZXhGNmxqdHl0KzJRbnFiZmF0ZXZKSENDUERmRG5hTUpxZEFz?=
 =?utf-8?B?dnZjVDRXbmlVQnBNRTNWampZWXdOeXpHeGYxTTAwTEdNbDhyM3lSajdkNll0?=
 =?utf-8?B?SnQwV25hZm80NyswYy9wN0xoRmtYY1pNamdUaDdvQktnb3N2RzFJRUl5Ui95?=
 =?utf-8?B?MUdNbFNSRDNKVTNSV1lrdjRhVmZSb1d3SlJZWDl2NTJwUHFWb3RDZHc4anda?=
 =?utf-8?B?dGtGK2h3bGtPUTl3SFVCRjdvY2t3RDRlTy9pb1BGZlg5V0tsb3ZnZ01TSC9n?=
 =?utf-8?B?QnBGTTc0a0xkUTVqbnlyM0dVMmU2aENTN1EvaDM3Q3VPYW0rVnRRRVJFOU8r?=
 =?utf-8?B?alIvMUJqTmRhcEJITkdCQWlFTEcvVENwcUJDWXZTaFhSU0pEd3ErSWFwQWZ6?=
 =?utf-8?B?WEdNTUxad0E3aExkRTVBQkdRanY3RDJlSk56U1lSV1hXT1hYVTVEZGNFZDJx?=
 =?utf-8?B?WVgvMEJWdHdNdjJaRHBnLzlKOTBQdmxvZTd3TmhrS0hqWGxWV0JaZjkzTXVi?=
 =?utf-8?B?RWJEZTdUR1dnVnhsVnovMkg0Z0E1eDRwbmpmRGl2VFJMYVdOWXVwTzczbktQ?=
 =?utf-8?B?NllrN0xxWFptcjMvUVZaMU4vbXppMDZRZ3JwNldLcHNxMkIvMVJ4elJTaHFl?=
 =?utf-8?B?eFZhVDZzMVBYdVFjbm5kSXJhZmZFbEpDb0RaNCt1dFdMdm9TMHV6azdqam80?=
 =?utf-8?B?K2FrVVkyck1qYkswNmNEeFpZWGpBeG5nNEU1T3JkM29kQnNCVVJWS29xM01V?=
 =?utf-8?B?YUEyUkF4ekRqK3RaUm4yR0FtalhXV0JDd2I3bDI2VUw5OFhIS2VmTzRTbDBH?=
 =?utf-8?B?UVdiazdyOWhXVU84OXRFR3Bxa3YrVVNNUlUzTzVGazhpNFF1WkFOdFNzc1pR?=
 =?utf-8?B?Wld6c2FMYmhaUkcxbGhTaFB6WXhDTXJjUnorUFp0QUJZemowSnJ5UnRrVTVN?=
 =?utf-8?B?SW9ZZ2Z1MmpscXJwNWtscENmSzlnOEVXS1YvSUhwWE5IcXRBd3g1ZktrU3Fy?=
 =?utf-8?B?ZGx0ajlVejNyNGJ1Y3JNdkVXS2tuWlBTTVFQL1hENmUxQjV1VWNxbDNEQS92?=
 =?utf-8?B?VnRTTGMxYk50am5Tblo3ZHF0eWJNUWlEd25wLzhBTkFzRXQ2aTJ1NkhCQXR4?=
 =?utf-8?B?c3QxOFZQbzNOejRaVWxZWmIrNXZtZUM3VnUyV0E5K2lxcVVBUzJteVE4TXNk?=
 =?utf-8?B?czVaYmpSNDRuRHFtMWhYa0l0KytiRFpjeVlwTlZJQVNzb1JGT0cxVnZTTEpn?=
 =?utf-8?B?QlE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	1TyeNcH4x5PzOmU4B12JEsol2/VNeURdDjSUxPllJoJ24IqhyK9ueWI7q2jwdDywJt6AAiLhYVkvxy3VK3mMHjGeP6aY2FHn7jfs69VutRA+16uUcVxq0FlS33TXMl2R4h4yPc0ztDzDbMDUfnQ/TMBj9lXACoz0gyOUnpk9NZ65b0WYWB7MA11cKs2WDf+NzQvYTgk0P2SG+tUsm7xGK3bPs12sJX0BxwQRejan2wSYL416ix2929aRswIMYwv+qYztGtdVr/TomfKVjfJv1+eh09eKNVMaFchDOa7Z6yzFLfWSQfHJ1Jz3wrNuZnPcksq/7T/99W6JLF86e2vh4H9H2Wx0RTw+VFK+tMFt8QIiPnMddb4udSDx9LAEOXeVM+wrQ7rVe79RfkPTTALFEawB8KrfowrmNFjGNsL+cEM16BeJFwofKDexBdytuW4mGjswMhceSsCWlS7S3q0DQit3oTBjhuHP5SS0f2kLabWLv/Nm+6ANt7i5WYH0VNZlF9gfkd1pcQZb+JHuH8xo/8/SS3fVmPfpl9HHglk+3AsTKBan/XGV7O9BUWe6YvnwPtbwhe8gSjvDDdglw0rKad8ETDGZNUlV20zKBMqADbk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 893879f8-31a7-453e-3a64-08de187ec0fe
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2025 13:09:41.7375
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ve4MF/sZT8y1WwJyfci2/vORiVBC/5BK/i9VGifiWQGO1obau5kNlSf1ChN7Kd2ZuCGJeV0LN6c/sTINhtoypw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6198
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-31_04,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 malwarescore=0 bulkscore=0 suspectscore=0 phishscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510240000 definitions=main-2510310118
X-Proofpoint-GUID: KnF24enA2crdvbclUHX1Y5Xjc6HdN6Cg
X-Proofpoint-ORIG-GUID: KnF24enA2crdvbclUHX1Y5Xjc6HdN6Cg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMxMDExNyBTYWx0ZWRfXyMyC2XfmZqjD
 VHctRtICPJUYsFK2aNvzgoh1vMiqxXIMGSSy7LgvYg011JM2LNKgxT3wi66eKWlBuxiWTA6AiA6
 Cvt+9koVQHlbrrEmyhTwsLo33tqocnVeHjjKEcsRX4rfMfIngdA4g15wJ1qmYKcYE0dImvEuKTk
 5D4t/hHDc37DxeXbkFQQxoRe002vNgh0WEZB3DzPsCsazf2CwlxmCP5IX7NXXqKin/tPeXKfX6p
 MfdeGffoX6TqnnrKw2cWWfXdL4LkWHiClukDn2nSoTTptAYm7JFjU7oZeBE+x4CsgeqUSJuKxJB
 tp1IbxExTxUM7Cy7jRrq0v9TjlQcs3g0u87azowtGepQU1a2ohnAZPEPDaDGobaKDJ7YJshOqzR
 +i+2PWOvxDu/72uLqsVayuf4NZ9vQd+BB15YWZ54nJ+35Elrotg=
X-Authority-Analysis: v=2.4 cv=BcPVE7t2 c=1 sm=1 tr=0 ts=6904b51d b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=QPc70tb1kuHs_Xgy7VEA:9 a=QEXdDO2ut3YA:10 cc=ntf awl=host:12123

On 10/30/25 11:16 PM, NeilBrown wrote:
> From: NeilBrown <neil@brown.name>
> 
> Nothing currently clears fh_foreign, so a PUTFH which sets it followed
> by a PUTFH which doesn't set it will leave it set.
> 
> As we always call fh_put() before installing a new fh, use that function
> to reliably clear fh_foreign.

Hi Neil,

Do you feel this change needs to be backported to LTS kernels?


> Signed-off-by: NeilBrown <neil@brown.name>
> ---
>  fs/nfsd/nfsfh.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
> index 16182936828f..41de882ba839 100644
> --- a/fs/nfsd/nfsfh.c
> +++ b/fs/nfsd/nfsfh.c
> @@ -805,6 +805,7 @@ fh_put(struct svc_fh *fhp)
>  		fhp->fh_export = NULL;
>  	}
>  	fhp->fh_no_wcc = false;
> +	fhp->fh_foreign = false;
>  	return;
>  }
>  


-- 
Chuck Lever

