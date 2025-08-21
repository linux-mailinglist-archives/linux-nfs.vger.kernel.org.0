Return-Path: <linux-nfs+bounces-13862-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 024A4B30815
	for <lists+linux-nfs@lfdr.de>; Thu, 21 Aug 2025 23:12:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83FF8640F57
	for <lists+linux-nfs@lfdr.de>; Thu, 21 Aug 2025 21:06:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD58226A0C7;
	Thu, 21 Aug 2025 21:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VlKWILi8";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="LRgZdAWv"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1522F222581;
	Thu, 21 Aug 2025 21:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755810150; cv=fail; b=ONvrricXK+OTBX2uC7M2q8z+9zGeKbkJkOXq1oT3+V6uDtiiiRpDmdX01q8lFNwdpF08QvQBsFpbPeYjJ4h6fLjAnuao4c8hkDKlKQDt6NjShKuuhrepAJCmNW5Xm+oe7WJwX8YsBnP3/eAFfHEuTAWZyG/Hh4OsR7oNkNUF750=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755810150; c=relaxed/simple;
	bh=q6Z4gGBFPRBVxljVky8CqguPK3cypoS0jHvoaGdBY30=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rioe5Ifz8HnsNtUWm1/BG6giv1W38RI4tSzZnd2NkXM4+DNMplRPQfWynXII7h1wi5egUz0qpJFMbRGqOlvZW1AXK7UB7us3jQKZOTHbjNONY5mAaHkYh1UiaegfHsIYVYV+/HVAWHKB/N5nCW63QjTO1+7E3g5vydntxUgrbjI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=VlKWILi8; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=LRgZdAWv; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57LL15Cn004657;
	Thu, 21 Aug 2025 21:02:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=nQzyM6HzxEqWKippQXL1O8bh+fStigB92koHbbbjzFk=; b=
	VlKWILi8PIu3bI6zBByQ/uj6xlpTNlaYVAr6pTi6VWGNpoJCY4PzUINdz+t69qFt
	LvK0omSB2yBb/Z9eYeB7UNvgWDOZzntVpxfFhX+vtB+h/Uy9nggzLjLk3cL1KYc3
	wmWIopVCKRIUp6qGhtBKweHHU0J5TipaSOguzXmy76oc8uFpLZ3lJr3YeAvnSBjw
	BW2TVu3zZTgb6+uZkzicvCnmvHl7Cdlxc7ieyvtdolhf0aU7z7aRfKJ5BUE9kToC
	/bXEJt5Jywm3dfv8gd6raVuA/EPqupkFBwyb/PCITjL/ugw9ZfZNI7Aopi8jZzLU
	WF6D8pyrjVHXZBsEThi/+w==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48n0tqvjf1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 Aug 2025 21:02:11 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57LKwKmO030246;
	Thu, 21 Aug 2025 21:02:11 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10on2085.outbound.protection.outlook.com [40.107.94.85])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48my3vw7rk-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 Aug 2025 21:02:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TrWWbA89HihXgT2/c/IVO5EkONvsVZx4hSClJNEChrxxW4Tqf+YednggmXsKAIsdfRtBqNupOqZYLv/NFuNVNWneXuV6/ha4tMcL/fGSLdE9Pxpj/ZMxEZJD/Nmf+oY8bIqKuHd46gol9n7YpBAZa3A7TKvGWZKWql1YDK9rZr4avmM/BocQrSpimg8RlCoAq8hLn8ueZF+qX9NAxk77bbc3+IomIQQgDqR6fpp19kRZI8mON80Rt3QpdGxh+QIaYUE1wV5SGorA27RFJhBwdfAcD/PbHvr8N0t/cW66Ua8iHx+xcSIt8jpN/Hg3knqOooOwmyQ/E0pg2ttIbD0bHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nQzyM6HzxEqWKippQXL1O8bh+fStigB92koHbbbjzFk=;
 b=DbxbsZFhm/raLrMS0M7WdoBCle9K66SymX1oDhdBzUQUv2CkU51mwW6uNZSYGEosHlCUx48OISYkkEdAFsjEJ09WUj85WquHv2w13EQBcA3ew6+QjdHi9gjB2M6N1bsnV4hSxTVHc3hOR1n9FW5LmJQm198O6qtDRE/tJIQMqlPRRgR8gixteG9CIsS7amjAr1XO6akKRSj7wRilkgC9o/XXWN6yzJLZAA9ZbDi6aW+/IVMzPotpd6oxjEh6xJBo8m0+hG6Ws1uV7ru/NVnGsdMGwxonFDNaRdWaAUv61myrm2RLIPrWMUrG8XUriJVkmGR0vy9/+FUZTlSpYXFh6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nQzyM6HzxEqWKippQXL1O8bh+fStigB92koHbbbjzFk=;
 b=LRgZdAWvEsSOF3f7+RIGI6qvwtEr49e+kZ2E0bricjvpzWm57lyjPEYUtYnJ0IyEFFsn+9biDPzSy94g/4jM9zcLN/5oGA0gDOvsoVHh6s4au2NkPbfl44L+W6gcAhH+tjiieB9+W3bfEVdzA7Bh+qCf3Np2TJlczTHHzJEAzFU=
Received: from BY5PR10MB4290.namprd10.prod.outlook.com (2603:10b6:a03:203::15)
 by PH0PR10MB4632.namprd10.prod.outlook.com (2603:10b6:510:34::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.15; Thu, 21 Aug
 2025 21:02:07 +0000
Received: from BY5PR10MB4290.namprd10.prod.outlook.com
 ([fe80::8c24:37e7:b737:8ba5]) by BY5PR10MB4290.namprd10.prod.outlook.com
 ([fe80::8c24:37e7:b737:8ba5%2]) with mapi id 15.20.9052.013; Thu, 21 Aug 2025
 21:02:07 +0000
Message-ID: <7f5112ca-63b3-4f02-8d7f-fc7e760fd64d@oracle.com>
Date: Thu, 21 Aug 2025 17:02:04 -0400
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
 <af5751f3-6bb4-41ca-968d-78e8a766b668@oracle.com>
 <3bbe56ff1312c5afbdbe3de91c0ddb57d836f30f.camel@kernel.org>
Content-Language: en-US
From: Anna Schumaker <anna.schumaker@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <3bbe56ff1312c5afbdbe3de91c0ddb57d836f30f.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0291.namprd03.prod.outlook.com
 (2603:10b6:610:e6::26) To BY5PR10MB4290.namprd10.prod.outlook.com
 (2603:10b6:a03:203::15)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4290:EE_|PH0PR10MB4632:EE_
X-MS-Office365-Filtering-Correlation-Id: 43f9be4b-d00c-4f91-f12b-08dde0f5fd00
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|921020|7053199007;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?NTg2VWNyK0kyRERlWnZLS2JRenhROVoxTlpicU90alhhMko0MDdVZUlNTyth?=
 =?utf-8?B?eTNLbTJzZWtaaHMwKy8zWm1LQmpmNWtIWGVLQUpaT3pYcERvaTY3TkRoZEhn?=
 =?utf-8?B?TjB4TkhaZ0kwOUMyeVVvYkhpZG1lenpsUWhibWtOcWVTc2FKZjZWZHAzT1lz?=
 =?utf-8?B?M2RDSEZWREJybFdlNVBrdlZPSk1Udm9yZ092em1UTjZpdFRZUlNIT0FQOGw1?=
 =?utf-8?B?WmttVmFMOC9sY0VVQjlMSWoxVERRVVQzMlpGSGQzWE1CRStDQ2MvcjNWZ3Zy?=
 =?utf-8?B?WTc3ZmZoMktBNkFDWisyUFhIaHMzdzBQOXhjY1p1WkJkV2ZQLzdBVFJUbnVU?=
 =?utf-8?B?OFl3NlJaT1F0WHkwOFF5TDZpRXNsMVNrN3Vack5JVFU3L1B4dVBxbWcrcWhj?=
 =?utf-8?B?QU5DRGdrRDFoSTNxQ1k2UnkrYmhuc3ViZmVDV2VOYldhcTJpcC9TVnhjMVJ1?=
 =?utf-8?B?VkhYakxKM0gwVXNoZW1YTW9nVm1JYlJJbzAyWldVeU9NbmZQWmlVQ1pnMnVN?=
 =?utf-8?B?WlZ2d0Q1dmJubVhVYisyWFY3UXpkRXd4aklpNmJLSU02Q0kyeGNZSnZlSnh0?=
 =?utf-8?B?OFFwK3Nzdk42dEtWTTgrbkhYMVpqY3FJQXBPNUF6djFBYnRpNTdKa2x6VTg5?=
 =?utf-8?B?NzlIUUZqUjFQYnlUdEN4K2g0S1Q2bllRRFphVW02ZVF1bmxEdVVkTXF0WnVz?=
 =?utf-8?B?Z3hHSG9zV1YzRTVDaE54UHRKQmt3S0d6T3FDR3J6bGRhWkVoNzNnakRKWksz?=
 =?utf-8?B?L3BQZ1dyRkVmR3Rja0dkMFU3cEM3Wm5mQUNmbVJvNG9sUnVCUDhzZ3hMcjhl?=
 =?utf-8?B?U0l3WDV3NWtUYURLblVGK3JzeXFIR1NNaUZCa2ZVQ29FdzJVSFRmbktxQ2tK?=
 =?utf-8?B?WlN3V0thenpLc3JEayt0Q2FTS0JkNXB5OG5pZFFHaDBaMk0wVzZPY3pVUyt3?=
 =?utf-8?B?KzBNall5UjZhdmh4QXNUcjhiU3RTdXNlUzhRWDVNMGNSUStDSS9tZW5pRHRL?=
 =?utf-8?B?cWJrNGhYaWtia0NZV2dmeUVTaXBUVzd6QmMyWUZkRXJESkp2ZjdxWUdlMDU4?=
 =?utf-8?B?dHhlTHpGWllRNWFCWS9VWjI3V3VDZ0Q1OG05R2tTOCtVbmdpQWdxd2hlZER3?=
 =?utf-8?B?UnNjYkFROTdGU013cnZoYkF6b282YnAwd3hIQ25PY3A5NGtzMjUxVWdDT2N6?=
 =?utf-8?B?ZjVodjNRQ1I1Wjd6R3U2MGNTWDB3Ly84L0ZsUUJnOVF2TUEwMWpYbXQzb1U5?=
 =?utf-8?B?NkdaYVoyaDFiUUgzbWtnNjZEQVl5eGtCbDJhR1hDeUdUR0hzbGY3cmptMlhM?=
 =?utf-8?B?YS83aDZpTmhqNVB5cXVtOTFWNHZJMmh6bGttQW5ZNGhPck1GSG9KRjF2bHJ2?=
 =?utf-8?B?YnhjcEpqRjc5c3NVdVZIN2xOeFkzODk1SzU1SWYxeUxnZmxSbGUwcnlMVFAy?=
 =?utf-8?B?d1o4cXlCL2JmNHBVWU1kVXM2aTE5ZWhPSlMzZmxqVWJreGdwWTdveWlaeHNx?=
 =?utf-8?B?dlFhRmpqd0F6aCtoRkw4ZldOYllRSkVaZXdtQU4zdUdPYkd3SUNsa0p3bGZT?=
 =?utf-8?B?TFFQMjU2WVZCVGwrWURBRVVzTjJmNUJsN3FNU0ltZDBXWVU0Zko5R0l4dFJv?=
 =?utf-8?B?b1ovb0JyWFhPVXRJbURYVVF2bFlaT3ZGa0drMlJvbFNTdERqMHNtaDJ3a3lD?=
 =?utf-8?B?bzJKeGYyMWl4RHZYVHpzK2Nxck0xUnlyZzM2QnRSWTI4cGRaM3Vkb2Y2M3Jm?=
 =?utf-8?B?RHA3eW5ZWDkwcDFUWHFXK2M0dFE3R2ZoemtoVWpWbS9mK0NyWEpib2VEUUNZ?=
 =?utf-8?B?ZWhpN1dMaEtLRFMwMVdudisxN1lQbWxRSTlTcDloY1JyT01qSUlrRmlwYXJv?=
 =?utf-8?B?RW4vV21pbEdoV052OG1aQjNzMnBQdC9NTnVaNlF5K2pnSUJ2R0VxSTRmanB0?=
 =?utf-8?B?c0JXNGRLenpjUTFpMGNiTUVmdjZ2LzEvQXpRdkVDNTZLTXlIY1VPZGlnWlFz?=
 =?utf-8?B?T0RUaG5mempRPT0=?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4290.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?d2M4dTFKRDBYckxsSG5vekRsNUQ2Z2pQRC82NkJna2oxT3BwcGJCdityaEM5?=
 =?utf-8?B?djFSdDMyVUtDczVObmd1S21TcGJaN3JwSCtheGdBNEY3MHEzQ0ord2FXVkJY?=
 =?utf-8?B?WGhBcHVhREwyemhqNVBiZFArdDk1YnRkQkQzYVQxaHVZdmd3aVFXRFJXZVVB?=
 =?utf-8?B?Z0tmcitsMytudkJqZEQ5dDNRdk5UcWNLNmF2Q05rV2dTTTRaSm9GUmNKcVRk?=
 =?utf-8?B?NTJLblQ1VzZWTUZsMWlHTmE3NHRTS3RxVGx0aUw2MnhGYjgwWTBjZGg3MDNT?=
 =?utf-8?B?ZVY3ak52VXF6SnR0TEVJL0pOaFlST3VHQ0V5bW1qT2pZcFNzYmVjcUlqNkRF?=
 =?utf-8?B?WFNlUnJkK0s4YzhuTmY3OXRwZ3l4aUkxN2owWVlpeE5Rb2Fmdk9oc3g2ZzJr?=
 =?utf-8?B?NGtjQXVabzJZblE4cEhJR0lndUdjRG4wbzQ5cThjdy94OFZWbXAxeHc2TFly?=
 =?utf-8?B?MkE2T284MTNYYVRWcTdFZE5JSk1WMVFnN09haklZNUY4THVPQm9rNENhenhB?=
 =?utf-8?B?MjcxN1NoSlhqdENrbk9BVUtiSUdlLzR1MWxZdGtOUHZjMWZkK0Vrb2o3MFF5?=
 =?utf-8?B?M0p4eEptdG1meDg0aVRTbjcvWjJaRGtxUWRLN0xkb1ZRRENtek04Tk9Pc3Vl?=
 =?utf-8?B?eGJFYVVOTDVmR0VFZVR5M1BOekdRZFV3cnVvODZUVFBlSStDQ0NLQzBjdjZM?=
 =?utf-8?B?UUR1QVh5VFpDZjM4Nnc1NGlDOGU4MldjZ1JNMXNEc3hMVWM0VDhaYnBOYlpo?=
 =?utf-8?B?THR1Y0l2TDZFZEpLS1dDTmdhNURsMTlvN2tBcjRxdlIrTXFzem5vb0ZkNmtz?=
 =?utf-8?B?bVBHN0Y5cUNtODcxRWd1RDFURXQ5TnVwcnJjQ2o1SXAvVGUvU3N3V2trM3g1?=
 =?utf-8?B?TVlJYitmYTBGaGJBb0Raa3BOR0taWlp0UFJqd1VUbUFCS0h1bS9OWWtqSmI5?=
 =?utf-8?B?ZUh6Ti8rY2J0cVZuWU1CbWRlUWo0NTZoOUY5MEFBVlFNZCt4Rk1kNnB1SzdJ?=
 =?utf-8?B?ZUtJdVZTKy9jdmpiL3hMaWNQYUlNZzhkckFkMldwNWxIWHVtNzZCZmNpaU8w?=
 =?utf-8?B?bnNlcHdWaWVyUGZFMTVRcjJHTWhpQ0FUVVZvbVRGcGlMZEJHRGFEdGRTWHIr?=
 =?utf-8?B?NklneUNTRWdlWGlYaFpuTXlIOWgvZnd1bFBLZmxFaXNJTzRuZm9HME1PbC9J?=
 =?utf-8?B?ZUtLTGNGc0Naa2Q3eHgzMi96eDF5V3hQdjk3OC9zdFhmZzFMMlVBVmpJSmxy?=
 =?utf-8?B?eEpZK00xNkxYdEttY0ZHRGo5QUF5NVhpODlIYVg1UDNTd1B6MnBYa0x0VFR4?=
 =?utf-8?B?Z0NHa1FHdDZENGVDWHlCdUVXNy9WMDZtS2d2Zk5SdHNiZU1IZzQzWE80R3FI?=
 =?utf-8?B?K0dlYmJSUzlyWFZnTTU5dlk2dlNzd2JPNlJuTzZDUm5XWXpmNDV2MXNKYnhV?=
 =?utf-8?B?ZEJnMUhQMTg3THRscDlPSmR2YXp2Y3N3d050UzVKOGJNdmhLdmxBU2lmSmVI?=
 =?utf-8?B?SHdJQXRZcXZCS2VFRkxiTHFiQkhRdFVnelRFdDhMbG00K2FqYW5MZ3FYWGkw?=
 =?utf-8?B?U1ZVOXFtcFljdElWOTRweHY2V0lIN0d1aTVuMndQRVhuWk0xTnhhUi9jQTZW?=
 =?utf-8?B?aFcyQy9YSHBGWG12N3RuVXgzQXh2czJEWDdTUnJwdkR2eEMrU3lZUXRhTjZt?=
 =?utf-8?B?RVhQQjkvczVoaERleHJxajJtUzc2RGNNbW0wT08xM3JPSXNpd2d2MW81aWk4?=
 =?utf-8?B?NE1vOUh4ZjZ2NkhBTUpIWVphd0Z4czcvNmdDNlBHbi9ldGdLTFZ0MTJ2R2Vn?=
 =?utf-8?B?Mko4Y0pqa1Bpdm1sMEpTYlFlT1FqSUR6R2xyYkFWK3JTR0lydEphRmNFNkNh?=
 =?utf-8?B?SVBTR3djd3dTMUU1dDdnbm45QUpFRGltaUNGdHNkejNWN2thZS9HcDBnUTZl?=
 =?utf-8?B?UXFpKzZyNGN0MUJUUmUyU3pBRzNYcU5IWEhMYWh2WENDY2N2aHprWm1uWHVK?=
 =?utf-8?B?WTVudFBSTjhrQTlpR2ZNcEF2WFV1TCtQbjY4Z01lc1E2ZEdiYm1YRFc3c3d6?=
 =?utf-8?B?RC96SjVQZHBWYUZnWTY3Q050Tk1oNENYb0x5Q0JVNmRza0MrdnAxRkR0dEJB?=
 =?utf-8?B?NGdQOXFkNXlYVHd2VXRSR2hBOU1EZFJhd0xGWTB6M1Y1R1l1NGlIR3BYakl0?=
 =?utf-8?B?M0E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	IQfULSgcTF6/qlYou391Oq3ndbTxC4ZZ/e+07PBj5tKcPxXdlP/cWiN7b/xI/UlMCphK8KzSjsBamfeZSqwPjuN0oEul9+8+6imTi2sXdLeRyPGBuu6SPFE5tHF98RXzlhGXj5/j3RWLmnL0Zs7QCzj1+1a83MM464iUrfypp6M0U6fyWsmiToddLZExjdTYSFQVokzxTr2N1EJPfZTYeu3wGN7yBnFlftGsMDP/iZy58vCja9eUTotdBBx8y8osPTeWYO51QKFgNCdt299TtyCFyBcOkKyuV3VRr4yjWm5owF/HmF74eICV4S9xcFA+T47RimqO9c9EXO5OGudxG63cp3m+KeJG0irug13zH2/zciiFobdJkOvNxjmqy/FfqsDA//p+TCgU7VH+lDfKqDRUiaqZJdh19v5Byn7hC3VfNlLpL01C9202yJ4cWmHOdxtXuJHzFnlGxjnVQJNlpwZnFAmfJ3CK/qgmGxdDq02N7IDyaQix3Daf/4IKnm3Wz0E5KWw4g9EMdOh7QCUJv54Oc7HXQpvaC8hwAXIRL/OROOKC371YyBwIjS4yICXDAncAvN+HOZ/0DheRVnj9fvJmSt8wYG2nOXIM58ICuAc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43f9be4b-d00c-4f91-f12b-08dde0f5fd00
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4290.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2025 21:02:07.5996
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NPQs0P3PZmpIE/Pf8pj6nKp4CWChSG/HVMyPWj9qENFNQBzomQpKZN3xIY3y3S7DhAyiLzB4GUw3lqmp5+WjVqiNjp2YYfkIbbBLh5AAaaE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4632
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-21_04,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 phishscore=0
 mlxscore=0 adultscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2508210179
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE5MDE5NyBTYWx0ZWRfX/AstLZPOwNsp
 EcSl97SpXYgjF/IB3V6lv1S1TJX26uIgXz+hPA2P6hibfWte1rJRTKBbLgV5UKfSKBCU0M2b1V8
 lpj+5UyqVr/IK1LydTja6CRbbInCXVU/Sw71LfK+tNhNDmG/BLJQonv3mtPzaa8xEZ8+sMXoNsZ
 uTarHC2n8X5F7/2oLTJo1PyouGa9SSv+bVBAOREPDdddp20d5dhJ+cyIDyZoMLDYKQcBx+ySJKq
 2rUXvY333Z8AH16gSPFWNqocJ+paFyaWKCVv05t+5izEIOnR4pbrijZLQxG01fId8i5WmrLPbst
 jvih85N673XKjqAIWt90ru1rO/Kpv4B4ST2eHNbo017iMX4DD+zVo5sSuJZxS5JJ4Y7H11oYLPj
 RGU8SzdbqMdzBOt5gTIZaC56SuP2CEEIXphNGqw7RJ+T2766XKM=
X-Proofpoint-ORIG-GUID: 8I1xqCZ2nxUY7DiT5nD_fRKcnhSuKWbN
X-Proofpoint-GUID: 8I1xqCZ2nxUY7DiT5nD_fRKcnhSuKWbN
X-Authority-Analysis: v=2.4 cv=K/p73yWI c=1 sm=1 tr=0 ts=68a78953 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=31Eso4XJF8IbyAiIa-oA:9
 a=QEXdDO2ut3YA:10 cc=ntf awl=host:13600



On 8/21/25 3:51 PM, Jeff Layton wrote:
> On Thu, 2025-08-21 at 15:44 -0400, Anna Schumaker wrote:
>> Hi Jeff,
>>
>> On 8/21/25 1:16 PM, Jeff Layton wrote:
>>> We have a lot of old dprintk() call sites that aren't going anywhere
>>> anytime soon. At the same time, turning them up is a serious burden on
>>> the host due to the console locking overhead.
>>>
>>> Add a new Kconfig option that redirects dfprintk() output to the trace
>>> buffer. This is more efficient than logging to the console and allows
>>> for proper interleaving of dprintk and static tracepoint events.
>>>
>>> Since using trace_printk() causes scary warnings to pop at boot time,
>>> this new option defaults to "n".
>>>
>>> Signed-off-by: Jeff Layton <jlayton@kernel.org>
>>> ---
>>>  include/linux/sunrpc/debug.h | 10 ++++++++--
>>>  net/sunrpc/Kconfig           | 14 ++++++++++++++
>>>  2 files changed, 22 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/include/linux/sunrpc/debug.h b/include/linux/sunrpc/debug.h
>>> index 99a6fa4a1d6af0b275546a53957f07c9a509f2ac..fd9f79fa534ef001b3ec5e6d7e4b1099843b64a4 100644
>>> --- a/include/linux/sunrpc/debug.h
>>> +++ b/include/linux/sunrpc/debug.h
>>> @@ -30,17 +30,23 @@ extern unsigned int		nlm_debug;
>>>  #if IS_ENABLED(CONFIG_SUNRPC_DEBUG)
>>>  # define ifdebug(fac)		if (unlikely(rpc_debug & RPCDBG_##fac))
>>>  
>>> +# if IS_ENABLED(CONFIG_SUNRPC_DEBUG_TRACE)
>>> +#  define __sunrpc_printk(fmt, ...)	trace_printk(fmt, ##__VA_ARGS__)
>>> +# else
>>> +#  define __sunrpc_printk(fmt, ...)	pr_default(fmt, ##__VA_ARGS__)
>>
>> This is the only reference I can find to "pr_default()" in my tree, and my compiler isn't
>> very happy about it. Am I missing a patch somewhere?
>>
>> Thanks,
>> Anna
>>
> 
> No, my apologies. I had made a change in my test branch and didn't pick
> it back into my send branch. That should be:
> 
> #  define __sunrpc_printk(fmt, ...)	printk(KERN_DEFAULT fmt, ##__VA_ARGS__)
> 
> I can resend if you are amenable to this patch.

Yes, please do resend!

Thanks,
Anna

> 
>>> +# endif
>>> +
>>>  # define dfprintk(fac, fmt, ...)					\
>>>  do {									\
>>>  	ifdebug(fac)							\
>>> -		printk(KERN_DEFAULT fmt, ##__VA_ARGS__);				\
>>> +		__sunrpc_printk(fmt, ##__VA_ARGS__);			\
>>>  } while (0)
>>>  
>>>  # define dfprintk_rcu(fac, fmt, ...)					\
>>>  do {									\
>>>  	ifdebug(fac) {							\
>>>  		rcu_read_lock();					\
>>> -		printk(KERN_DEFAULT fmt, ##__VA_ARGS__);				\
>>> +		__sunrpc_printk(fmt, ##__VA_ARGS__);			\
>>>  		rcu_read_unlock();					\
>>>  	}								\
>>>  } while (0)
>>> diff --git a/net/sunrpc/Kconfig b/net/sunrpc/Kconfig
>>> index 2d8b67dac7b5b58a8a86c3022dd573746fb22547..a570e7adf270fb8976f751266bbffe39ef696c6a 100644
>>> --- a/net/sunrpc/Kconfig
>>> +++ b/net/sunrpc/Kconfig
>>> @@ -101,6 +101,20 @@ config SUNRPC_DEBUG
>>>  
>>>  	  If unsure, say Y.
>>>  
>>> +config SUNRPC_DEBUG_TRACE
>>> +	bool "RPC: Send dfprintk() output to the trace buffer"
>>> +	depends on SUNRPC_DEBUG && TRACING
>>> +	default n
>>> +	help
>>> +          dprintk() output can be voluminous, which can overwhelm the
>>> +          kernel's logging facility as it must be sent to the console.
>>> +          This option causes dprintk() output to go to the trace buffer
>>> +          instead of the kernel log.
>>> +
>>> +          This will cause warnings about trace_printk() being used to be
>>> +          logged at boot time, so say N unless you are debugging a problem
>>> +          with sunrpc-based clients or services.
>>> +
>>>  config SUNRPC_XPRT_RDMA
>>>  	tristate "RPC-over-RDMA transport"
>>>  	depends on SUNRPC && INFINIBAND && INFINIBAND_ADDR_TRANS
>>>
> 


