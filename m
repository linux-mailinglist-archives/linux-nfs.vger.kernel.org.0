Return-Path: <linux-nfs+bounces-16445-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77686C6470B
	for <lists+linux-nfs@lfdr.de>; Mon, 17 Nov 2025 14:45:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 943993B6FA6
	for <lists+linux-nfs@lfdr.de>; Mon, 17 Nov 2025 13:41:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0D9E1F463E;
	Mon, 17 Nov 2025 13:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VtGFlA40";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ceFyGZPQ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28068271476;
	Mon, 17 Nov 2025 13:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763386892; cv=fail; b=k3ffPEu0/bbOI6cdYgU/HC84PBDAsPWH6eQSMV9Fw4vEVbC+pbjQKgj4J1OLOaM8UxeWRtHYItgHnMuOELW7tJYFoGXe6hJRRPvDcmccnrIEhywY3fyj62e+xvfRgQT6UeWHFKwBrTJvD8IZxnWoCheNMApJX+oGW234nRdZ00E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763386892; c=relaxed/simple;
	bh=5kNSt8ZHXNl05yizSk4FPXrQQPEgkMPmdOQ3wnJJBTg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Teodso7AOYMrL8Y4ITYQldWOYHANUWCZejiSh2eEk7/XPiirXPCDW7pWIfHyJ78087BVLbxO/n7/h7/XxUnNeLCP4EzYw8NWywQ6NGXGeue44BxoNxbZWQGpT/MQhrMM7+RhwERs1en25n+oIUo9345HPr8MFdgRRzK78ygM3vQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=VtGFlA40; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ceFyGZPQ; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AHC8Uu9002262;
	Mon, 17 Nov 2025 13:41:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=OlZ9fxmTniKmO8gyZzD/+wxaDd/vd6RKYy01SFohZNo=; b=
	VtGFlA40Z/QDWhHR6m8rI5PswkG9XeMRaFSFmnqmACzwx8g5rNQ5NKCgfIZDmX0s
	SPgTN2opmwhj2r2Mzdm6bWMDlfBt0qHsCSaR7cMraLZOJ2fxmAziigDekPzXffwR
	02AJ2LRHmOx/EqDmbzCHeIEkkr3DYYMx4QUpR1728MvBgXtjSSvCh9OV8Pc1VcQz
	8HzfUI7c9NXMa1IzlBfibQ+kF2qYoWu3qdG4pTK4Hv3ENG2wppwzIcpELWG41jB5
	VmowIG7Kpi/TiKI6M1IOiF3GENkGM8je6zQVfbln/SAHo2g0O4wzZJXUiXoGFfHi
	jGpQF3x4w42M4bM98xKTGw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4aej962e8p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 17 Nov 2025 13:41:10 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5AHC0MjI004268;
	Mon, 17 Nov 2025 13:41:09 GMT
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazon11013070.outbound.protection.outlook.com [40.93.201.70])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4aefy7esux-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 17 Nov 2025 13:41:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jkFZWLzcfuNV8v6bWGGw4d8fTmjmrRhqXmkWX4kXWDMr7sCQdcTF9mfT+Zuwk5B+xms6edpbicoHAeZXRdaG1bJP1u7XBDKgJff2Y56FcLP6dW3/pDKEdR2NqC4agXaHvsHnmszIRodvEMoMO8de5KSZ/gWrJGqRGixJ6BZ8uQlHGeGkccJBVgpEkZQFPL1jeQH6XsI7Nw5Ly2jipmUrNSMDDFg8ITKMzfKz0TfWE8ADcNG8wkO4Mr10igWIl6gluFhNXKf4zcrQY1O4T7cGgzpjaz0diRnyWsuN0Mp3BfxXt2cix/zQyMM7yulVT9GDOEXe17PZV1zoKX/M3tCvrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OlZ9fxmTniKmO8gyZzD/+wxaDd/vd6RKYy01SFohZNo=;
 b=UOmyNTHbqqMdU1YKqdMKlNmrp5HNx6eq3b+HtITWeVAz12E6+KiDzLAzbiuiwSmWk5OhULgNOY1qmjdpNkk5WXbGmHtogE68P9JpK9qJgyQ2gpz5AuHYzsWFEl87PQD4RoaxSpD4PLIpFNKfhi+kH1HREgfGZYOq40C5DGJLDE6FKVplUj2T8IgcIjHw9u7XSjD9lVVPFY1/dp5vfKB+nF9QPRK0o43mDzN6LAWDWsEUA9tUwCWZatFiMVFsDzhUCVov8EHJ8wqf6NRIJThTXzyySooscnMu6sqnMKNb5UiiGFyQPuNQ4e+vSlDu3xzFRo9Nd68TKg0Jvi2K+1ePtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OlZ9fxmTniKmO8gyZzD/+wxaDd/vd6RKYy01SFohZNo=;
 b=ceFyGZPQ3qPwIbyNlzNiH7nP1PxYnq7eFNkI6aNw6obOA12dJ4CMO6wjSq3epZziGZrTf8qZkSjs/RevbOD7t4rlcFxQ1DyQjSaQ+00+GPGkx/NPWE1+YXBPSHCNpccCh0COKY0FRSGuLqeIkV3XeexaOMcNqb67wOm2Y9B1DfI=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by MN6PR10MB7542.namprd10.prod.outlook.com (2603:10b6:208:46d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.18; Mon, 17 Nov
 2025 13:41:05 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.9298.010; Mon, 17 Nov 2025
 13:41:05 +0000
Message-ID: <e5112807-a427-4762-b7b9-ecaa95fa0482@oracle.com>
Date: Mon, 17 Nov 2025 08:41:03 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: ls input/output error ("NFS: readdir(/) returns -5") on krb5
 NFSv4 client using SHA2
To: "Tyler W. Ross" <TWR@tylerwross.com>, Trond Myklebust <trondmy@kernel.org>
Cc: Anna Schumaker <anna@kernel.org>,
        Salvatore Bonaccorso
 <carnil@debian.org>,
        "1120598@bugs.debian.org" <1120598@bugs.debian.org>,
        Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>,
        Scott Mayhew <smayhew@redhat.com>, Steve Dickson <steved@redhat.com>,
        Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <176298368872.955.14091113173156448257.reportbug@nfsclient-sid.ipa.twrlab.net>
 <aRZZoNB5rsC8QUi4@eldamar.lan>
 <de44bf50-0c87-4062-b974-0b879868c0f5@oracle.com>
 <AVpI5XolCCA38sGzxlfk6azQI9oUAxafUVl9B7B1WgJEmGgSAQq5nvulQO6P_RQqjBp3adqasHFsodhAAxai0dcp5scRMJk0dLsGMQeSiew=@tylerwross.com>
 <fVv3cF7Ulh3cKUP17C98gh_uOv9BcMlMpsIh1Nv5_0tdw-75PKiPJgIEP5o2jBVry7orwz7jeiGQenfCbuUxyj5JFstbx3RTFYr223qDmV0=@tylerwross.com>
 <a6d1435b-f507-49eb-b80c-4322dc7e1157@oracle.com>
 <Y79HV0VGpScPYqI_dDxeItkX2UZwSdReaUOpIeMeZXq2HLsHf5J_PTQqr7HrBYygICRsn-OB89QPrxPzjgv2smuzTThUPy_3fq_N1NprlUg=@tylerwross.com>
 <4a63ad3d-b53a-4eab-8ffb-dd206f52c20e@oracle.com>
 <902ff4995d8e75ad1cd2196bf7d8da42932fba35.camel@kernel.org>
 <ji2_uZ3RNtBdATHSokoxSrIXMAi4zh2jZXEd0WownMtXo_WNIseAeeDZoBFjT54nCE1Iw0PcGgfORC5p39CP9KGqjY6T2wqeBRGonjIjfXM=@tylerwross.com>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <ji2_uZ3RNtBdATHSokoxSrIXMAi4zh2jZXEd0WownMtXo_WNIseAeeDZoBFjT54nCE1Iw0PcGgfORC5p39CP9KGqjY6T2wqeBRGonjIjfXM=@tylerwross.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0P221CA0006.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:610:11c::29) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|MN6PR10MB7542:EE_
X-MS-Office365-Filtering-Correlation-Id: 131e6af4-850d-4c09-b362-08de25def4a1
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|159843002;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?ZEt6bDRqQUdPeGhwUStxQ1ZaUVB4dE83RmcyaytMZ2ZTL05CY0tQMHhKekRR?=
 =?utf-8?B?bVJlQWlnb2hONW9kUXBJQ0lsT1NjY0RScGhvNG1WeTgwZ3ZEZVZ4bUQyU21p?=
 =?utf-8?B?MUhIdDJTL2F1S01MakZWeVBsRXp6TG5QRFNZK3N0b3l3TDBNd2svb3lsVW82?=
 =?utf-8?B?bWZEdFoza0NnajVpVzFHODEvV2Y5V0JzRGE0VXdBdkJweDJaWUdMdTBmMXNX?=
 =?utf-8?B?Tm9obVBZUk5GWXZCRmhkNWh2bkhVYWwrV2NlNC9rOTlDSDA2Z1dST2FTdkpZ?=
 =?utf-8?B?Z1RtTHduODJQYk9jbEUvT1RYRHFmV1dkK3FVTGVaZWQwRkxxNUlaNXlwYzh2?=
 =?utf-8?B?cVh6a2lqRlVFVlVOSWVWbGRSZWFUM251ai9tU3BnaUxkTzJxN1FDakQ1d1Bt?=
 =?utf-8?B?azRIOHR3TWwzNHM1NEhYd0NQRUxvNGw3UmZHUkI4RExmUkN5Z244V3lpWFJO?=
 =?utf-8?B?SHd0d3BIVWxqaURoVEU4YjV0UVJ2WFpmUnVONXpSVGEyMVQ2YlZFRUdLWFEx?=
 =?utf-8?B?dW4yR1hGVEtVVkY2V2hsQlBNNHZ1aEtLOCtUTUxnbnRvYlh5dXpCMm0rZlQx?=
 =?utf-8?B?WUJtVVB5dmhhdUlIZWVVTmRMRzZaVTF4SVlVUzhDS1B0cTI5VGgzdkdKVU9u?=
 =?utf-8?B?OXovVjcrS0FvZEx3dzFVazJoZ3hrOXZjbWs3VUFzUnBIbmJxRHlnQUNBZkd1?=
 =?utf-8?B?Z1NTQW1XZU9CL2ZHOXFIYTBzZnhZdG5sZTFuaG14RjdUZExpZldZTG4xN1dj?=
 =?utf-8?B?cE1DdDd0aU1Iay9rVXRMUTVya1diZDh0MzhKeEpXcVhTaEFFakRLVjVxK3pw?=
 =?utf-8?B?UHZZVXFTNGNWTlFsZXoxYWs2NmEydUpDRm56M3BkRytDMG4wRk5GU1VvM1lh?=
 =?utf-8?B?dVFZc1lYbStBSHF0cHNwekg1dE1PUUR5dVlmQzFiL2owWGpoWUNnWUFOK2Z4?=
 =?utf-8?B?akg2S3hzTG9OTHpoRFRhSXJaeTRRZFlRQjdSN0FQM2lyZE0xS2dnSkNGanRm?=
 =?utf-8?B?TkVJdHVpRGJUYm5WRFp3UlMzcjUyZ095eU5KbFVJVG9FMHlwbnhLQlhjSzlU?=
 =?utf-8?B?UnlUV2lnN3pRZitQeDB2dmcwYXBwTlMzbk5lSk5ReCtvSzJSWTVibGRMUGpF?=
 =?utf-8?B?MmwrMW0vMjZmV0Z6QUFxV2hCUVY2WStPQWFRamtRY2FhclJrVnNvMTVXMnhx?=
 =?utf-8?B?TXBjcmtWZVluMWtJUjBrdTBVSDlMZWVIc3BwckFkUDlSejJKUDIxSGlGM09E?=
 =?utf-8?B?NjRSbEJCejlhcDZnQUxrUG45L0Rtcms2QVRuUDZKaWlxWlpXOXlQT1VBMk0r?=
 =?utf-8?B?aEIzenBpaUNleExMZDg0WHJaNXo2cUFTVjNYUWR3bjZjQkxCR1NoNmZNV0FU?=
 =?utf-8?B?VE1abWZsQWRScnhDcWZEd0VieVdlUE9ReWkwbGhpa25JajVBcFZyTForZWtP?=
 =?utf-8?B?YVVjMEtBMmE4TW1SNXZPUzJURmcrQzA2U0xxZVFwcW9JeWlnSTJKT1BQTTNZ?=
 =?utf-8?B?R3hoT0xpT0ladHpBMFgxTWtQakdEN1RNdEJXZHdieXdLclM2K2h4ZE04T0hQ?=
 =?utf-8?B?dFBDZTM3NktJZktER3dDRGQvNnNzNmJlbkVMa2VUZzJreEFEb2lub1Bvdmhi?=
 =?utf-8?B?ZmlKSFNrZW5KSnBoRHVMNGtFWk9udnFjTDBUdytGMlhaNHZPcHAyV1lmRUZq?=
 =?utf-8?B?b1NvbEFJR0g2RnRnc3FXTGlSTUxOVDhza0M2ZG8xbVl3UE5lSnEvTVJqeFFs?=
 =?utf-8?B?K0p5dDFudHV2S3kwR0thU0NYN1YwUWdmM2c5cS9CMTU3cHAzY3BaRDhkYjg5?=
 =?utf-8?B?Nm1oUmVjbTNrT3JDZUs3WEl2c25wUHJqUXZ2WitSMjQ1c3c1aXNjRXVpNkVz?=
 =?utf-8?B?MC9BdC9qNlN1L0lKckRydkk2RlFjWUladlFyaDRxdFF5dytKbjlodSswbllL?=
 =?utf-8?B?dWYySWdoQUtiQm9QdlF3UENGQ1IySG9RSm1HUTBjbTg1aGs5K1hzV2pNcitB?=
 =?utf-8?B?dnlSYzQ2TTlnbDVJR1dOeDI1dEpzVC9PWnBCY1BwMjdZakFTZ3RaWkVBUUVp?=
 =?utf-8?Q?Ab9Q29?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(159843002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?TGV0MXEwS2FRUmUyMms2MGVQTkFYNFFFbVBaTnBiYTVzLzRkZjd5aXVRS3l4?=
 =?utf-8?B?WE0xaXg1dzVySWVXZGRTNkppaGVWdXpISXB0OW45RFEveXhJZHNaSkt4WThX?=
 =?utf-8?B?MUx4NGI3L2M2cGVOT0dXdlRTektLaS9qS0l2TzA2YmFwS0prZitMbHFtVU0w?=
 =?utf-8?B?dzlBTDZWdVVSSUp1WkZWMCtWYnl3WlNFcEozNWdzWGxMaW1jVXZpZVNuTTdM?=
 =?utf-8?B?NHJ5TG44eExybHpkSUc5OVc0dGVyeEs3dlJpdnF5OHE5ZDljK1c5NDlVZFpM?=
 =?utf-8?B?U0FRS3VVTkh2Mi9VVG5SZXo4WDNpQmhYNWU0ZEV2S0xaWktCenU1U3V3aXB5?=
 =?utf-8?B?ZFEzSmY0T1VrMmlUMWtsL1VPTlpxYzNNSlFLczRHbzJiMFNIN0NQRzNZa1ZB?=
 =?utf-8?B?RmVNN29CbDRpbXBZNkFSVHE0NXc2TnRqL0J4MzlwaVRkTVRONi9qRlAzVnVk?=
 =?utf-8?B?UEY4UHIrbkJETmZZMlVPVTEwb1ZPL3JjS2JRZEFZS3J1VWxJMkcxRWljbFcr?=
 =?utf-8?B?RFJmUHY3OGMyRXFrTDhtc3Jrc3I3bHpKcDEzbzF0eFFrejZIM3BwTmUzY2hL?=
 =?utf-8?B?Z3Qrc3ZxU21xOXpLV2YxQXZxVDNjdkR6NFVHSDVtZkFlOGZya1MyK29SZ25E?=
 =?utf-8?B?QW1TVzZoTklNbm1aOGxxek14NVZndjFEUHBSbTlzcGVlOWpHenRaeWpkZVBw?=
 =?utf-8?B?bEVpTlpSWnU3aTZoMk5ab0t5enJkNSs1ZHZCTlFGUHd4cmV2bHVHQm83U3Rn?=
 =?utf-8?B?TnRRQTlweWl6U3phblJ1M2xIQVpDaERPU1VhQng0RlJxNVExNVdDck1TMkZ6?=
 =?utf-8?B?UkhQQTBBcmNFUGN5cm9WUUdNUnFCbnRjS0NJeGZJeEhYR2s4eXFldk1LTXkr?=
 =?utf-8?B?a0laMDNVUi9UZXpjRnVJUUZZUGhpZ1pKSS9tZGFBTDBFejNLV1BEa3JIWDli?=
 =?utf-8?B?bjUwVjA0VUJYTW50d2hDN3ZLV0F0ME9tVXlnTW5uMnBWY1JYN2krSXh5S3VQ?=
 =?utf-8?B?ZkQydjNRSEVmM1U4dTlNblhQM0RUM042MTNTV0NCQlhhLys0a2NqcXlhaG9k?=
 =?utf-8?B?YWJKNXk2MHFuVmI4b05QaHhuYkZMRk9idXlPT3Y3cDVKK3JML0hkdkJXL014?=
 =?utf-8?B?Rjk3eU1pL0lud05qTDgwSU5mTk1HbFhhWXpsNE9QL2grTEdjdHNCeG5CUW1h?=
 =?utf-8?B?TGx1YVBxRW1lelhLU0MrTWcwelFLS29Gci9GZW10bVl4dEk1MGFaZ21wcHU0?=
 =?utf-8?B?ZnRmcTNMOUtKTnI1RC9VcUl1OWRSMGlhSXMrSExQRlJmSXA5TkZrQ1NML3R0?=
 =?utf-8?B?YkdhOGJmclp3bm8rYmp5Z1N1K0pYbWpuNnpwK2t6bFVzRDMvbzE5aFNTZHFC?=
 =?utf-8?B?SDJwT0h5TzcvN0tTcktBVXExdTlsbWw0anBGdHRPZE1zbWR1L28wWngxUEdX?=
 =?utf-8?B?Z3ZkTlZhcEg3aXFFanJVWW0vNEl4UWdXblkzd3hSbnpBQVRRNWxOb0JKL05w?=
 =?utf-8?B?aE5rTGs1Ujh1cjJDOEN2WWNvallQWVBURDhtbS9CQmkvbkhseXB0ck9RR0lm?=
 =?utf-8?B?bmNuNk5BQVVxRmtaaDBxc1p0aU02TmxsSzgyMW5ETUV0UnJHanU3dllnQmpn?=
 =?utf-8?B?bllsdmMwZVBNeFVuMk5BalQvRzg3MkVwUXNlL0dwNnVMS3haWms5Um9IaUNw?=
 =?utf-8?B?aXF3RkdOdTZIRzRyb0J3ZUlzYUx3QnBiTldXY1BhNU1YYjVFQnJ0S1RYVU14?=
 =?utf-8?B?RkpRTm5FNzZrSTVER04zQTA5VmkyVzVGN0ZEN2V4WmNjTUJaanJBbG1HVXBz?=
 =?utf-8?B?RE03aDZYVDBEMm5RMjhIZHBSOGhqSkwvdWRzT0ducWhwd20vV3Vwc0I5MC9W?=
 =?utf-8?B?V01XT2RFQVhISEZSVDdreG40bFZVZlpTUHlBYTZDZ21jUmhwT2JxMVZPdEV0?=
 =?utf-8?B?WG9TdGN4dnFFMXRidThRQjkzQmdYd2NZTzNUZUJvZEdueHpPaWZpemx1aFFl?=
 =?utf-8?B?LzBZam5nMG9aZWQzemQvQlVYS1BKdGQvN0h2b0pMOS83b1JPYkN1VFd2MlA4?=
 =?utf-8?B?WmJxWHFzM2k4VTRRb0s1V1RzVS9HRCt2SEh1QVFPOHBPY2Zwd3RqanJITFBj?=
 =?utf-8?Q?SNKWNKfKg1s91Dh/ZZw5BKhz8?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ZAs7Uw6Jrvl+gGmZ+4jKLTvcqKK1B7tnZ7VUGG1chMvfmHgp/bZTKx2oDPvZhOdPv9nb/5KDIyVIreEP88gMjQ5ZQzaUL5QC/Pm283deGrXoQaKGW8nSG1IbkRGb3MrG9/vFNppQmCBrLpW+Lb89g3d2pbTWpP9qtCQJMRjy5oxRvM4hG+gvmpPpJdYXNYCjJ6g6X2Amcxxu2gZkFOzjH9yz2rK1iL7/kHvxxpfW70BTF3Gc4tZup6ukWxFpGAvKka9U9+jIA7JmppbuoEC5PYyzGy4++JjR5awEoZ/ZoyZH5UmDvnZKGOzXXazWjndY3zUDoCwmx6uZlYl1TdhgXZzOyixV8RZlGkd/mwGEntHTOUZcsS5u/uQJuowAr+xvnOkXvHF/fGgwhCCUQDhrBmy/ntmAWYpxUgjx9z8EtULvyIrM59WMCPl1Bn06c1+6hiUIdv1vKHjrdDuwUhTz41JbrMMPHwJdVNUzES7kPn6jcaP6BSAraidp5OT7dS4+0Fz0A3aomcKZemAzUgVv7UxdIdQUV0Kd3G6YUiOoQpxXHrfmPEjl4Rwf19m3mO8aqe6EJkxZgWT3SSYi6I/uHObVbbMgC69PVqAnSDW5iJE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 131e6af4-850d-4c09-b362-08de25def4a1
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2025 13:41:05.1970
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /gIl6PxKGdt9fqjgATUKOaAlajnE0e8frYLrjOHoMiGVSJbuwLmdsbUNVQY/+YnG6Gseq7pZhaQdHmoDCPWnyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR10MB7542
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-17_03,2025-11-13_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 suspectscore=0 malwarescore=0 mlxscore=0 bulkscore=0 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510240000 definitions=main-2511170116
X-Authority-Analysis: v=2.4 cv=DYoaa/tW c=1 sm=1 tr=0 ts=691b25f6 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=daNS9Uhs3h4oHNtZA08A:9 a=QEXdDO2ut3YA:10 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: 9ON6LC2_lhqin1NWZgAQF4oqT7sWILtj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE1MDAzMSBTYWx0ZWRfX9eOnc7Lp6SCV
 06sAxicfsug9aofFKQDxuHaLO5Y1ejKiOlW8e1NCUFh1giaYhad4yxCMFoohRl3kVOYPyKNCHjj
 cascIS5Ty2Ut1VorB0vTeLrHKefuQzX12gU6yVrybv3/JjQv75PxoJV3GpaaVtt6ZoGiGpHNQjp
 /7ddsCICLgHY9zgXEvTkK1GhrfRZlCBZ8zSUtNQ0IDj1cT/5phTNOsTe7mi9e1Orj9TwODbwbC3
 kyWCM60VFA4sOg3rxGKNWlQF6scsLnKMfsz9MDfk0X+F5eLXZiqMlkm0QXz/LuIWXmfYHLIz2U6
 RKe3L4vOCsDVMlZZ6tniaVlSaq9MNO3vtr40LqaDx6sszRnmzLkxFmLNAQcZu1buCKcKhMDvrXy
 s90RzsnXTkRBiQ8N/g9rpLesx14qKw==
X-Proofpoint-ORIG-GUID: 9ON6LC2_lhqin1NWZgAQF4oqT7sWILtj

On 11/17/25 12:19 AM, Tyler W. Ross wrote:
> Weird behavior I just discovered:
> 
> Explicitly setting allowed-enctypes in the gssd section of /etc/nfs.conf
> to exclude aes256-cts-hmac-sha1-96 makes both SHA2 ciphers work as
> expected (assuming each is allowed).
> 
> If allowed-enctypes is unset (letting gssd interrogate the kernel for
> supported enctypes) or includes aes256-cts-hmac-sha1-96, then the XDR
> overflow occurs.
> 
> Non-working configurations (first is the commented-out default in nfs.conf):
> allowed-enctypes=aes256-cts-hmac-sha384-192,aes128-cts-hmac-sha256-128,camellia256-cts-cmac,camellia128-cts-cmac,aes256-cts-hmac-sha1-96,aes128-cts-hmac-sha1-96
> allowed-enctypes=aes256-cts-hmac-sha384-192,aes256-cts-hmac-sha1-96
> allowed-enctypes=aes128-cts-hmac-sha256-128,aes256-cts-hmac-sha1-96
> allowed-enctypes=aes256-cts-hmac-sha384-192,aes128-cts-hmac-sha256-128,aes256-cts-hmac-sha1-96
> 
> Working configurations (first is default sans aes256-cts-hmac-sha1-96):
> allowed-enctypes=aes256-cts-hmac-sha384-192,aes128-cts-hmac-sha256-128,camellia256-cts-cmac,camellia128-cts-cmac,aes128-cts-hmac-sha1-96
> allowed-enctypes=aes256-cts-hmac-sha384-192,aes128-cts-hmac-sha256-128
> allowed-enctypes=aes256-cts-hmac-sha384-192,aes128-cts-hmac-sha1-96
> allowed-enctypes=aes128-cts-hmac-sha256-128,aes128-cts-hmac-sha1-96
> 
> 
> Is this gssd mishandling some setup/initialization?
> Or is there a miscalculation happening somewhere further up?
Does Debian's user space Kerberos support the sha2 enctypes?


-- 
Chuck Lever

