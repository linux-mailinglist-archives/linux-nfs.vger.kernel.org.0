Return-Path: <linux-nfs+bounces-20283-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ALARG5NFvGkJwQIAu9opvQ
	(envelope-from <linux-nfs+bounces-20283-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 19 Mar 2026 19:50:59 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E1B382D157F
	for <lists+linux-nfs@lfdr.de>; Thu, 19 Mar 2026 19:50:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0A2CF300D46A
	for <lists+linux-nfs@lfdr.de>; Thu, 19 Mar 2026 18:47:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FFD42DF3FD;
	Thu, 19 Mar 2026 18:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="RV/C9rA/";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Feu8bgMZ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E752815CD74;
	Thu, 19 Mar 2026 18:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773946054; cv=fail; b=GgUfISjJBEn/suXKlZzsg8nSBTrZjXol7XAOC0PxwJzGGhxp4W+QpwQArcKEDShJkuVPPR4MPEqsExf646zlsnk3RjiSnNvgg/Df4hULx57AVQK9S2iD/KYOOC8Uz12jJrZzPbEFwIlOH122jBAkOMrtMxXy4iVrnjTQ8VxperA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773946054; c=relaxed/simple;
	bh=r7I3s7lKndcOqUetbTekoRzhGDwfJAE1KFwLxfEkj6s=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=eWZtyMPOblpURgguN5fPOYpT4KKCl8ioV3t1wRd2XiKGMFs0GCH73awa+o5VOBM4SAzpXJyqn2SYVX4y+GIxE3YA1paFhfkAk0agbp4gv5vjYFMIx6nte07geC4ONtRnFf7iwVijA7bZRM2w0Tap+OT/hksVPUuvqMDHAYLGF3g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=RV/C9rA/; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Feu8bgMZ; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62JHC5CL2707518;
	Thu, 19 Mar 2026 18:47:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=cOD/QhFdf5H05hs/T+R92d+F19hZlsIlYT6jyHlGKZc=; b=
	RV/C9rA/LbQYFs5xQJlMbSbFthuc2mOveJ0PA1C/gPh01V6owPlKF04dF9w3rGap
	/+JrD3nhTFJ/crFcI8uzHivh2uXfXrplwLa4EES4ZkR2MGN+9TSL54fBRXWNV+9l
	Iev1rLPIDTkLZbKzQExMHvBNfmJqZhEfB0qIIvQUL50LYDKp7LM6vKM4fHSTuhN8
	qb3R7ykxLoJ9V+7UT2DBYBv1VqYXC0g9etBRTO8Ci3vxNcO0ZKRnxggGTQ2aBtF8
	shn/n+4q6+zmTri03LsF71nsIO3bpRdvNPPPMzHGKpS2Mm5wZnYa2gFyjEsbRcp4
	fr7caLijGyxavFcyOa8UVQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cvxf48d2y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 19 Mar 2026 18:47:25 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 62JHkQhk039677;
	Thu, 19 Mar 2026 18:47:25 GMT
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazon11010031.outbound.protection.outlook.com [52.101.193.31])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4cvx4rmt9d-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 19 Mar 2026 18:47:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LCOCT/i8MVvrkRxJmEwDJ9klI8sRbmqe+wWXHqkbHQkqH8VaE9WlQFQPIxcxg/h0dALV00+lqeVOolkiJKt8peI+EFgQCuvn4rwUZ6fGcuiQrRQx4t/8kFQf5Bbm+WVszbJW82CkiWOSnC49c3X7Isl/5GOHDkc1d9UcjuD1LP9KRAW8V4TCHFKGlj5MV+5gqH8VaG2Lx37Se4QeuVU2hgDSU2zwuVtMr2v7eBwVn42cp5cAuowyQ9tiofs310C137s64ITHkOAEVxadSyDS7hjj5xAoG8wJJZ7ALoC+0jsCB/jGrSznfqLJwCD0Nv5dbXQzfyTfUSaFfngtqX8r3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cOD/QhFdf5H05hs/T+R92d+F19hZlsIlYT6jyHlGKZc=;
 b=tAjMcRZpR6Gw897tVZJBRZa2z1/dzAZ4cDgnRYX5U6D4tu4wROxD+0GrcYgo8dsqKJGECSLCWI6GUDxzr5jQQiATJSn3TuJrswd4UiCq8QkeG0aaDmDZAvk9s1NtTupuHj9J5ILKKHfweg+6zMyTO0E+Y504tExexniqb3Wr3ssASqClZWAs/7DmwO5Llb+MF2UeuHM6zVOefboAJvQ1NVxBwyKXRPEe9/WfORHlo6HqsB5xw49yKnuM0w02d7iHg63eIoGcK7vAEnAbKLLws0JizJV7o7GU4Wrl0N4DDpRgGfvGiMyZRKg7+r498Y+n6H8QgTTEdPJmx2aCm5ENVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cOD/QhFdf5H05hs/T+R92d+F19hZlsIlYT6jyHlGKZc=;
 b=Feu8bgMZGRIgXtyNPwzWmQgaOoSKvXmpf1UYBJGuv1+MC2wwScG909SYZau2rtW90jgqA9gZ5VovMNiPnHjqbKtqH1ve+7Cl3KNvV0vnLr/uSgaUXsysGUK1Gbs0eAbX4NVMDZNW3ACS7ZAMjjbV1dhQRfN238ha26uABta1LX0=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH7PR10MB5829.namprd10.prod.outlook.com (2603:10b6:510:126::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Thu, 19 Mar
 2026 18:47:22 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::4083:91ab:47a4:f244]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::4083:91ab:47a4:f244%4]) with mapi id 15.20.9723.019; Thu, 19 Mar 2026
 18:47:21 +0000
Message-ID: <163efbf2-5e1a-4dde-b6c8-787c9b68e878@oracle.com>
Date: Thu, 19 Mar 2026 14:47:20 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/14] sunrpc: add helpers to count and snapshot pending
 cache requests
To: Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>,
        Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>
Cc: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>,
        linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260316-exportd-netlink-v1-0-6125dc62b955@kernel.org>
 <20260316-exportd-netlink-v1-6-6125dc62b955@kernel.org>
 <0908b7ac-658f-491b-89be-f5a1d97e991e@oracle.com>
 <579b0239abbbb0b95d619e6b400bb919fedab60d.camel@kernel.org>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <579b0239abbbb0b95d619e6b400bb919fedab60d.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH3P221CA0026.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:610:1e7::27) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|PH7PR10MB5829:EE_
X-MS-Office365-Filtering-Correlation-Id: d8f2b4e2-536f-40d6-2780-08de85e7f46e
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|7053199007|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
 R+DNm1jXez8qRUE+Ps/x74dRgVaIExDZMFsgrqok7V7EhKIeiOg8+pMDdvrmCspKuELBF6O8pmrEDevCk/Oh/jKw+H3/DOmEvwaMOLHuzDSnzqCeustG4cff0bAqbDBxCzoYXJVDBm21tSGvqnKAQAbRkr9lAROB/g3rmciqrdoH7iKkZYXgi0G2HQI5cWeO2dWrP+PSCeJALr3od2pipBdZvT83/wci072Fg+TZg20xCcHAsmxuNDRnGfuKGbWKnveD3zl7AVIn8fL0b6anDxZsu3QiEKDYhmiYTCcBeFGdVevsJ8RzVb77HDqsCoF0JQnZOrrwkJC8C97WM7xzGozzFsyRIdo/mVmXco1HlkOoPXOArq9I0xUjvYyUWk/wII5B/t0jO2sU7Q8AS2KavrRQlduPg+CNHXosI0b/BjmCpKc/qvRyxtcSvdaVnEtEiXgCeQMqdfEPPTp29a8VIy5PQIqZwvMjveYh9OINjo1WaERLB1tP0yuJ5lBziJpcqJGzB2SCLUd+4261YMhEIL31xeluWIOkIK3iMB+cUHPH4AiXzFGvRW5mqkuQZDdEyp8AaHo7M8jypxLlMzZZ+Hgp0XKUx6HuBfdBRo4KkUAYVBUqgzBVuc/tgY/uQT1dGUTGXADOn35Y7w1+tpakImD++uont5UCQ2iicoO83DaoM++h7G8qF1J2PGbQXb/epsO3OIgqTUxxj6sMhT6t3jX5S7veDNDc7rohMME8ykU=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?TFB4WmtNRythdnd2RGZmR09kaENrRWdWTjREZk5QV1FxT0FVYnVmWUNlQzFZ?=
 =?utf-8?B?a0FqMXVhN0J3akZLOU40b0FzQk5IRjYyajdEazJXQmFvRmpiQ2NqaEYrdUJF?=
 =?utf-8?B?KzFNS2FBaTBWb0pUWlZDQWczWkMxc2N3TVVuRnAxL2cwRG4xTElkcmpYTTA2?=
 =?utf-8?B?R0hMc0p1R3o0MGRsbi82ZGpmRE0xK0pRTDcvbDJCNmQwSmRobTcyaUV1Z2Fo?=
 =?utf-8?B?Nlk2THRZdUcvK0d1MUdOTVFOUUg4TEhreW1NMldiZEh0SlRIeUxtZFNqYXdJ?=
 =?utf-8?B?bVZra3VHais0QjBzdFBVemN0TWhUZXBwZEkrOXd6ZiszQnZnUHUyZGs3c2FG?=
 =?utf-8?B?S2h2T2oyb3VldkFEc3dmSGxJRERvT0R4WUtMVGErNHViREdhaWR3WEdvNFpW?=
 =?utf-8?B?UEk4VTFaTndVd3I2RjVpVW1ycVpWMmFtOXQ1bDdrREE3U3JNMTcxc2htSGNn?=
 =?utf-8?B?eDRlb1NxSFd4SVIvTUxkRG9oQVc1bUUwZHZ2RXQ0NXVHaTh6ekRxMFE4RVM5?=
 =?utf-8?B?OHdtWlZrcVQzdzVKNkdxS202eElBOVhaRHdPRW85MXd0bFR5ZXRGenc2QUpi?=
 =?utf-8?B?bk1OK0M3OWRVTTkzRDZOd1IrYmg4U29raXdacTVOVXF0U0IrYXpsclZDbHRK?=
 =?utf-8?B?cGJFSUhYVjVGT1Q5N2NyQXJabUhtTHhWSUhHZEE5RzVURzBjdVp1Z1BPREM5?=
 =?utf-8?B?SkxoUmI4ZE03cnZlVXRYWXJnVWw5cFcyNmQ5YVExS1VNWElFcDBNNjc2K2Vl?=
 =?utf-8?B?cjFXTnh5YUdybjdBMWpqbnQ3M0RUYmx2ZWtnRlEwOHFhNXNrR1Y2SlM3UUd1?=
 =?utf-8?B?QlpmV0x6K0hzV3dyckxaQlhMNUxGbkJ6UFJQS29Cb2x2UzlYeExEMURJZlBa?=
 =?utf-8?B?czZCYklnbmQ2SlBEVzc3Nys5amFHaURlblBQd2hXZ042OWtMOEMzVExkM3Fv?=
 =?utf-8?B?b2VyS2JZdHRGQ214Ri9QejhjSndqWjk3MDhGK0FwWVNFOUg1TGV4TFFIS0ph?=
 =?utf-8?B?Q005TUFCdWdicW9VbTl1NFR6Y3k1emJlMWZGbDR2M0xBcENzcTRCaS9RZCtB?=
 =?utf-8?B?b2YwbEhFNHdtMWtPeGN2dkVIdDVIeHlGc094OXN2aGNhSjZDZ00zUWpUcGRY?=
 =?utf-8?B?VUdEVmpHQmcxOFhXbFA1ZHdLcDdSWG5GZUpXdjJhTmNTaUp6OVl1TVpjM29k?=
 =?utf-8?B?MUYvTmhlOXV4MEtXT2pQcUFXakJBZ0Y2dnlSUDJKZkZNOVZXcUFKSE9sbFZw?=
 =?utf-8?B?dmZYenBmOXoyYk1SOGJUOEJjNEY4N0dTYjA5QVhJelVLdmZqQWVUR0N4WjAv?=
 =?utf-8?B?NlU4eG1mVXFKOFcveUFIWFdka2sycUkrOVRMYkk3UFlNTS9QcE5wdFkwRUZF?=
 =?utf-8?B?SzhsUkp2R0xrdUk5bWJuT1hobTZFYnRVZmIzZmYybkdRZHFOSnNiWkpHRmFx?=
 =?utf-8?B?RzUvbUwycmZFWXk0ZlI0dzJhS2Znc2VPaVNXWW1WZllpMUd4Qkt1bFlSK0Vu?=
 =?utf-8?B?Q2pUeXc2amVKYlF5ZHd4Njl4V0ZoZ1ZIYmJOVzgyVURSSXk3SjA1R2xZaXQ1?=
 =?utf-8?B?NEZFelFreEhmbzhIczlWUko4NVJ3R0JLdUh0TUVOWHdGVkR3SGU5dHM5eURx?=
 =?utf-8?B?Z1JuNjBtaTBjVGtGdThDT055cW9JUW1oSkV4aXNOUnUvbXVpYWI0d2FncHRK?=
 =?utf-8?B?N2Z1T3FZREpTaEdIZDlIc0ZFQit5ejBTTW5PSWtlNXhSL1BwcnQ0MUszdk5L?=
 =?utf-8?B?dXUvbzgzeWFyT1Q3RjFuNldRVEVIbUxhUm9XdUxCN04wMW5sZStVMGFqUW11?=
 =?utf-8?B?bG1xaDJSUlR1bjIzV0ZBbFlud2YyVTNqejBhZXRyY2kvSzNVaXVpVUNvVElC?=
 =?utf-8?B?MjN6UDVvd0g1Y0ZveUd2cEt5Qys2b0RsblVCSmhoT3ZwRGx1OWtSNzBsUnAz?=
 =?utf-8?B?UURmUHM4TVBUSXQzUG9IcGhEYWZmdXBMSHVVRkRRcjBWaTNDeXlxaVE1WFho?=
 =?utf-8?B?Wm1lNFR5dkQvQktFM2RCZ3IyelBMUE05aXZNYUgvWHlEcFBaY2F5UDlmTUtM?=
 =?utf-8?B?bUhhMk9oUHkwRDRMKy9ZM2NJU2pIang5MDdhSG5lanBOTlNTWDBnLzZVbUZ2?=
 =?utf-8?B?MnBQZzRZUWc3d0Q0RUsyK0tMVUJoZVhvNUtCdWxKTjF3VjNpdWVIczdQTi9t?=
 =?utf-8?B?SUlONmRIR2szUHhPYUJhMVhoQ3VmUzhQODhTMlo1TEl6eTZEZjF4MHVQdVUx?=
 =?utf-8?B?R0V3MERzV05rN1J2NjJYZWxjT0NsMDFhWmlQemkrc3lYRjJOTkxHcWZtUU9p?=
 =?utf-8?B?clVjL0tqMU5MSHM5aG4ySzVlRnhGa1N6dTJRQ2Y5VlNhbmorSDRXdz09?=
X-Exchange-RoutingPolicyChecked:
	tTepF0xLqh6xMMLkHrujVVQLAHLKc4wb8jnkxr/GceEDoQioy7IAIOkSYuFt/IpvN9aRBO0iknZ5M5Q/hZ/+/ScY/4dk+jtZTH/rjgpHDBKAjX5iQJ6vurjrCkQFYRCfi4evdJpEZBRWRdf+yW24vquf+W/f56JI4IPQuB7oGjvdgLIIF0n8qcDqeRyMnsJBeCEuiEJGEiBL/Xly28HbZjRFWND+JqKoYxCcuCOmRp47pRWyRVTE8FIwymJ49AUUG46XqS9QFBaUARDX+ZiNhA18PAXCXuavqomVuSgOWTBYlE8Vd6E+tDQ490o5w5A5QTBt70or7MlVa1IdveEbyA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	FL+tVTa3KVLOReFeWFYkEc1tVJKgiIHA7QSgfoGHfBTaJlW12mjb4ijwszKF+j6r8bNQ1ad4f3APKWDsQHE5o5Ri+z71nFsql2Ib8QUgg4ij1FwWsmGOI43ojbnm6N6kOKZfHiWS/1TMW2o1CgaiXg8gZ+McL5MRA8getGglBrxgB3EHyBVvABx+Yn4XvXF8G8IlmQ4upXhGbUPn9SSpcdZbzc88hXP/Gg5zN6vM66UTeqzsiIYQSrZpfGPTur+wRZnM7ILcqbUFcLavrtu0qruLmWxP8r29NVTLUx8yN6RJFWw9x8+fwknH8ihZa2RRjmbGVqqE2gUxYE1E+Eo1ghT1LTaeydPJd6rsKZfbl+3KHPXi/9I1JomYIYaiZoovJgApvdxqNNBn35GxGWf2KTmiJJGq3stWnb2UooRSahOHdUqG5dyX8PqfZUeikZ7G7+uiqatWpfAaK97V7pelEg6z14i/EJDfd0sB7M6HOM3ra/s7UBIorYTn8wFPoyfUWNiDxBVs8u7NKgY3lRgElXUrBPXj20M7EAnDTKIQcGTL/l1MEBtSNzZQU0sdgPp8tudPkhmtdkNWZ1L9Qv26Hn1c9catghbF1p0jfR/e1Z8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8f2b4e2-536f-40d6-2780-08de85e7f46e
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2026 18:47:21.9070
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7nmgcUDOag+OxowDBzB3ApZm8kc2xxo4BGpYf7PPwSGkbUPfTTLzNFk9u+IPg5m6ZuUdslxFFOF+jNJISBSmrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB5829
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-19_03,2026-03-19_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 adultscore=0 malwarescore=0 spamscore=0 mlxscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2603050001 definitions=main-2603190150
X-Authority-Analysis: v=2.4 cv=ftrRpV4f c=1 sm=1 tr=0 ts=69bc44bd b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=o5oIOnhZENCTenyL_yNV:22 a=VwQbUJbxAAAA:8
 a=6I8DzfMZM9Um3I8gS4kA:9 a=QEXdDO2ut3YA:10 cc=ntf awl=host:13824
X-Proofpoint-GUID: IklfaeR4WBJ-32j2My820wde_ZevMBvQ
X-Proofpoint-ORIG-GUID: IklfaeR4WBJ-32j2My820wde_ZevMBvQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE5MDE1MCBTYWx0ZWRfX5PuXOeyaPvHU
 3a0VCy1/qRs+EsCUL7qj7PVO9jomTFcTuSYO8JIHl9Th4BW7oP/1IuHgi3/8HP5R1Ef+Y3FCDnB
 pjsaDSTZ7hNHvRcM646rY2NRuTHuE55L7zZtgRBMJTvceDHhXAeHTRlI/4K0T3tzBr6IODmjjnT
 K581o6grRnsZ7i4Qqzi7Gok8wrvXsTiyCd/5D9mAQbEj9em98cNw8uNSw9kILUkYxgODMb+MV2G
 +Q4TCfp9UXYwD3+xasNj8AuO97mT+1o2DBdb794juAVzSJNvlmouWzdRWoEfUHdIoVo/0wrSjaU
 dgmiA6LwWJ5V3EFw+b3D5F5HZXVO5E8mT8B9aD0qaMUsXOQQGie1gluWiavNeEEsDMJBK0wtf+z
 EHuVmAAyHf70Ys6rOk+nt9l6JnPB7B6Z/36Cmyxy81ladnryrU6nq/DUfW1bxOLQrR2MIf59RdG
 D6+VGWii/sy6m6PJpn/NZ/qr4QHAeTpm0ujJFtEQ=
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-20283-lists,linux-nfs=lfdr.de];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oracle.com:dkim,oracle.com:mid,oracle.onmicrosoft.com:dkim];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chuck.lever@oracle.com,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: E1B382D157F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/19/26 2:22 PM, Jeff Layton wrote:
> On Thu, 2026-03-19 at 14:07 -0400, Chuck Lever wrote:
>> On 3/16/26 11:14 AM, Jeff Layton wrote:
>>> Add sunrpc_cache_requests_count() and sunrpc_cache_requests_snapshot()
>>> to allow callers to count and snapshot the pending upcall request list
>>> without exposing struct cache_request outside of cache.c.
>>>
>>> Both functions skip entries that no longer have CACHE_PENDING set.
>>>
>>> The snapshot function takes a cache_get() reference on each item so the
>>> caller can safely use them after the queue_lock is released.
>>>
>>> These will be used by the nfsd generic netlink dumpit handler for
>>> svc_export upcall requests.
>>>
>>> Signed-off-by: Jeff Layton <jlayton@kernel.org>
>>> ---
>>>  include/linux/sunrpc/cache.h |  5 ++++
>>>  net/sunrpc/cache.c           | 57 ++++++++++++++++++++++++++++++++++++++++++++
>>>  2 files changed, 62 insertions(+)
>>>
>>> diff --git a/include/linux/sunrpc/cache.h b/include/linux/sunrpc/cache.h
>>> index c358151c23950ab48e83991c6138bb7d0e049ace..343f0fb675d761e019989e47e03645484e0aa30f 100644
>>> --- a/include/linux/sunrpc/cache.h
>>> +++ b/include/linux/sunrpc/cache.h
>>> @@ -251,6 +251,11 @@ extern int sunrpc_cache_register_pipefs(struct dentry *parent, const char *,
>>>  extern void sunrpc_cache_unregister_pipefs(struct cache_detail *);
>>>  extern void sunrpc_cache_unhash(struct cache_detail *, struct cache_head *);
>>>  
>>> +int sunrpc_cache_requests_count(struct cache_detail *cd);
>>> +int sunrpc_cache_requests_snapshot(struct cache_detail *cd,
>>> +				   struct cache_head **items,
>>> +				   u64 *seqnos, int max);
>>> +
>>>  /* Must store cache_detail in seq_file->private if using next three functions */
>>>  extern void *cache_seq_start_rcu(struct seq_file *file, loff_t *pos);
>>>  extern void *cache_seq_next_rcu(struct seq_file *file, void *p, loff_t *pos);
>>> diff --git a/net/sunrpc/cache.c b/net/sunrpc/cache.c
>>> index 819f12add8f26562fdc6aaa200f55dec0180bfbc..2a78560edee5ca07be0fce90f87ce43a19df245f 100644
>>> --- a/net/sunrpc/cache.c
>>> +++ b/net/sunrpc/cache.c
>>> @@ -1906,3 +1906,60 @@ void sunrpc_cache_unhash(struct cache_detail *cd, struct cache_head *h)
>>>  		spin_unlock(&cd->hash_lock);
>>>  }
>>>  EXPORT_SYMBOL_GPL(sunrpc_cache_unhash);
>>> +
>>> +/**
>>> + * sunrpc_cache_requests_count - count pending upcall requests
>>> + * @cd: cache_detail to query
>>> + *
>>> + * Returns the number of requests on the cache's request list that
>>> + * still have CACHE_PENDING set.
>>> + */
>>> +int sunrpc_cache_requests_count(struct cache_detail *cd)
>>> +{
>>> +	struct cache_request *crq;
>>> +	int cnt = 0;
>>> +
>>> +	spin_lock(&cd->queue_lock);
>>> +	list_for_each_entry(crq, &cd->requests, list) {
>>> +		if (test_bit(CACHE_PENDING, &crq->item->flags))
>>> +			cnt++;
>>> +	}
>>> +	spin_unlock(&cd->queue_lock);
>>> +	return cnt;
>>> +}
>>> +EXPORT_SYMBOL_GPL(sunrpc_cache_requests_count);
>>> +
>>> +/**
>>> + * sunrpc_cache_requests_snapshot - snapshot pending upcall requests
>>> + * @cd: cache_detail to query
>>> + * @items: array to fill with cache_head pointers (caller-allocated)
>>> + * @seqnos: array to fill with sequence numbers (caller-allocated)
>>> + * @max: size of the arrays
>>> + *
>>> + * Only entries with CACHE_PENDING set are included. Takes a reference
>>> + * on each cache_head via cache_get(). Caller must call cache_put()
>>> + * on each returned item when done.
>>> + *
>>> + * Returns the number of entries filled.
>>> + */
>>> +int sunrpc_cache_requests_snapshot(struct cache_detail *cd,
>>> +				   struct cache_head **items,
>>> +				   u64 *seqnos, int max)
>>> +{
>>> +	struct cache_request *crq;
>>> +	int i = 0;
>>> +
>>> +	spin_lock(&cd->queue_lock);
>>> +	list_for_each_entry(crq, &cd->requests, list) {
>>> +		if (i >= max)
>>> +			break;
>>> +		if (!test_bit(CACHE_PENDING, &crq->item->flags))
>>> +			continue;
>>> +		items[i] = cache_get(crq->item);
>>> +		seqnos[i] = crq->seqno;
>>> +		i++;
>>> +	}
>>> +	spin_unlock(&cd->queue_lock);
>>> +	return i;
>>> +}
>>> +EXPORT_SYMBOL_GPL(sunrpc_cache_requests_snapshot);
>>>
>>
>> This API architecture introduces a TOCTOU, since as soon as the
>> queue_lock is dropped, the count can immediately become stale.
>>
>> The count returned by sunrpc_cache_requests_count() is used as the array
>> bound. To wit:
>>
>>   cnt = sunrpc_cache_requests_count(cd);
>>
>>   items = kcalloc(cnt, sizeof(*items), GFP_KERNEL);
>>
>>   seqnos = kcalloc(cnt, sizeof(*seqnos), GFP_KERNEL);
>>
>>   cnt = sunrpc_cache_requests_snapshot(cd, items, seqnos, cnt);
>>
>>
>>
>> This appears in all four dumpit handlers (ip_map, unix_gid, svc_export,
>> expkey).
>>
>> This isn't a memory safety issue; _snapshot() caps its output at max, so
>> if the list grows between the two calls, entries are silently truncated
>> rather than overflowing the buffer. If the list shrinks, the arrays are
>> merely oversized.
>>
>> However, the practical risk is incomplete data returned to userspace. If
>> the caller is guaranteed to be re-invoked (e.g., the netlink dumpit
>> callback gets called again until it returns 0), then missing items due
>> to list growth between count() and snapshot() is harmless: they'll be
>> picked up on the next pass.
>>
>> But looking at the callers, they all do this:
>>
>>   if (cb->args[0])
>>       return 0;
>>
>> and then set cb->args[0] after the single snapshot dump.
>>
>> The dumpit is a one-shot: it snapshots once and signals completion. If
>> the list grows between count() and snapshot(), the truncated entries are
>> silently lost and there's no subsequent pass to pick them up, IIUC.
>>
> 
> Userland will receive a separate notify request whenever a
> cache_request is queued, and that notification is only sent after the
> cache_request is queued.
> 
> So while it might not receive all of the queued requests from the
> kernel in the race you describe, it won't matter because select() will
> return the notify descriptor again on the next pass and mountd will
> pick up the remaining entries at that point.

Makes sense. But perhaps should be documented somewhere; the "retry"
loop is not obvious from the source code introduced here.

"Caller is expected to ..." or some such language.


-- 
Chuck Lever

