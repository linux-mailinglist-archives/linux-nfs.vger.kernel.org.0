Return-Path: <linux-nfs+bounces-10964-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1583DA768F0
	for <lists+linux-nfs@lfdr.de>; Mon, 31 Mar 2025 16:58:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DA9316532D
	for <lists+linux-nfs@lfdr.de>; Mon, 31 Mar 2025 14:58:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE6ED222596;
	Mon, 31 Mar 2025 14:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DFJI9AJD";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="D7i46FG9"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 028B522331C
	for <linux-nfs@vger.kernel.org>; Mon, 31 Mar 2025 14:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743432572; cv=fail; b=Wd/tuHTSHjsTm8s9upPxXEXMmbdcsiDlJfa9/cc+sYxKg8O1NAYth0pIXQJggCYw9GJ8FJROJu+DEjh8dIqsTNe9o2fBGoMxIAxiAHJtM3LpkO9vHANl3Lv7Q13nznNqZuPq4vd5TS5F/aC3tEDKw0/GgZGrH/O+O+NMnZ3A70k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743432572; c=relaxed/simple;
	bh=ssktlL0orhTlE0KUaQod+nW5YZzPsCJBiGMKTXKj/KM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=e0aGR9FqWvQQO+/OppQ36O1Ujn2OPUDp5OS8koQGnlMv3M8jClPl+zMPgDBdpd8sDaqzcxTxvRbmBP5ehy/OMS1Gh0+NEBywMgb0j5z8NhsxTgs5qIwvM68JtasSZ7O6mtKGckdW5WdWx3Dx5yk0/0qVMyL4rqTNJRAdzN/TsIk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=DFJI9AJD; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=D7i46FG9; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52VEC56K022759;
	Mon, 31 Mar 2025 14:49:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=h/UxCkQphTxKGEPNGvBGlDjNtfXrwEf2YcrdqoSXegk=; b=
	DFJI9AJDL0gus1mYlXJ7jSeaM7H57Yfz2Y2+WtVr1kjLB0ni/B8PC8FxpF88MtoW
	YsrHrLZP8o8xk4sJcz67voI8k3CFk3Oxn3I/m6j1ufy8ro3HNr7j1oXfzLBZfsWX
	v1peNdnT4viskFjdKFux6KT/kISZCLBcS8og7bNbhDG+C0UAo2S3oeNj3GkpAa9F
	1wsP9Sz7lwFY63CfAerZ01jC3LBioa6djI/dy+0kW2A6Ci/9Etye8AO7djhSbj+q
	hticeQG1eV0am69BZp+kRgvpOLwMCyPeM+6vWYg5hF1QGFks4rhS0SIz6jm+x54O
	5+bm+FUxzg58kxf3g5cU6A==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45p9dtbcfs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 31 Mar 2025 14:49:16 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52VE0FcL032806;
	Mon, 31 Mar 2025 14:49:15 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2043.outbound.protection.outlook.com [104.47.57.43])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 45p7a80bgh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 31 Mar 2025 14:49:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HSzxSxT95rieJYqjvRpiO/Jz4wB729lGNULcZbiVdwGmWHqPXrI1hfDwM5klXwN5/mLLdg5fMzCeY2eCmGQT4QrnzeAx7CQ/2Ivej6Lbt0/n7du3usYgPFyCkNhJzderWtX2z14NW/1NENRPhxAmmxIWKd4Y/PQiC6vSaPfPzlJlJdApy0s3YVsYK8Tyt6BQ/jWA5Lh98mWn17Ncxa9+CvJF+R1coI+rLn6hZiYg+p3AP2Mj9AVM8abDi/pBxRdZoQaTMjvRVg9+3j0OobYBeighPkef2WTl4QLQnt9V1xMAscvnrIcNiTkfRkupuDT97TFlRGbkMRVLY0ytX5gqCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h/UxCkQphTxKGEPNGvBGlDjNtfXrwEf2YcrdqoSXegk=;
 b=bICNLY9idZbVljtjE3EdVxU8yozhVJlr7MDY0t5XEnNf/FYwRXMklNW4WmJbcJFpy3pMfSughHFg6xO+uNA+cRSkaSRue0ZyoLnBC7IzJNoBJhHMF1rj4s1LRhVpFnEsd8lURgyZMiA20GlvOwKAgxeg5R4tZoQfnRaEHjpKiBo1BHW4uTomuIUrPnDQNhk16tcWaW1AozSvVVAu+B1/2DHoTrZG4YkMoijrXI9EQdvqbiYbXrCVql2D1MfzU+m4VvlzNT7HpWpV7yAArFyv+BSLFdiM0v2fMlUqMUUYCZJ7w+tiihOTJ7J6xDMISVL2G8G94WiISf9gagM+SyczDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h/UxCkQphTxKGEPNGvBGlDjNtfXrwEf2YcrdqoSXegk=;
 b=D7i46FG9JRFmGZA/g+dmQ1RHE2DJ/fHXLJubsap55imRAhg30Me9SdZMVDgbi+8G8Ynz7KTdAlsLQpLlOF5lx9AI0+DXQPtX50CnOz3r/oI5zmvuPcYuImg7kE6pXSCFD84qZD08PzEavMUgQlowX1AvXcGfmzPNjAiVD+Mvhsk=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CH3PR10MB7906.namprd10.prod.outlook.com (2603:10b6:610:1cc::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.38; Mon, 31 Mar
 2025 14:49:13 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%5]) with mapi id 15.20.8583.038; Mon, 31 Mar 2025
 14:49:13 +0000
Message-ID: <f9c6169d-edc6-47be-b6db-ec7eaaeb33cc@oracle.com>
Date: Mon, 31 Mar 2025 10:49:18 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] nfsd: reset access mask for NLM calls in
 nfsd_permission
To: Olga Kornievskaia <aglo@umich.edu>
Cc: Olga Kornievskaia <okorniev@redhat.com>, jlayton@kernel.org,
        linux-nfs@vger.kernel.org, Dai.Ngo@oracle.com, tom@talpey.com,
        NeilBrown <neilb@suse.de>
References: <>
 <CAN-5tyHWB9+Q9ONmWfF2LGe6wO1hZXvx2vEHb441Q3XkjzOFmQ@mail.gmail.com>
 <174337981427.9342.10894606812592381794@noble.neil.brown.name>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <174337981427.9342.10894606812592381794@noble.neil.brown.name>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0043.namprd03.prod.outlook.com
 (2603:10b6:610:b3::18) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|CH3PR10MB7906:EE_
X-MS-Office365-Filtering-Correlation-Id: 2af1c038-e89c-40b7-8dc4-08dd706333da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bEI1TTVKY1BTWDhEenRhcjd6bUVzNnBFK0tuQmN6OWt3bkFtaFg4bWpYeFhX?=
 =?utf-8?B?UW55WXlzcmVnM3c0TVRnMVhabTlrYlZqR0tYZXJFakQrSXlsTjJaeHR3SzR0?=
 =?utf-8?B?aWl2b0VPY2xIWlFrdjRpS1U3K0NOb3p2RFlIeENYN254RE1QWXpNMjY1Um5z?=
 =?utf-8?B?R2RFVTFNbVVKb0RuMVR2WkQ5OFJxSHZTdGRMTi93ckJpSmJmZUt6alllWG42?=
 =?utf-8?B?dFhvakhsZjNoRDA3QVhHR3VWSDgrVnpIYWVPVUlieXdveUxNa2pLWjgvak51?=
 =?utf-8?B?Z3ZBZGJSTHdES1pQYkJMUDdrYTNjNG9ndi9vbnZMMnFWMXdIYkQwbmhEdXll?=
 =?utf-8?B?eGFESzcySDJQU3JES1dxZW1mMkIwWU9paTI2VmZQNGl4Y21GT0lJck0wWEJw?=
 =?utf-8?B?ejN6SUg3bDhDOFM1OHdtb2FEMWh2dXZnMEpueXppUS9VbFJkNTM3UXZDRm1n?=
 =?utf-8?B?T0VEcWV5dXhDRnVxUmltUjR1bTE5Y0hLUzYyREhtM1I1aHo2bkZ2SncwT2Jo?=
 =?utf-8?B?WXdVOFdlYS91Y3hIVzdQTjRxRUcyajF3WmpySHNEUGlQeWt0SUJ5SGZ4UTJh?=
 =?utf-8?B?Y2dQRktTVElGNitzSW84QUxRbk9NQmtFUVFqUjVxbHZDVXAvdGxoMzBXSjda?=
 =?utf-8?B?SWRweXMzTnpuUGlXQkR1NVdLSWpBa2NEUnpQSWNKbysvRTIyOXpuc3dUV3JE?=
 =?utf-8?B?M2hkZUJTU0ZMcVBlSDZ0Z1dRMXFvQXg0Qm5ub0RycStmVXZreXNSSTJDSGNB?=
 =?utf-8?B?VlJxSnJnOWFNM3NnSWtoSXNZNFM4UlpxR1AwdnJRcGxLanRMSWZYdElVQkIw?=
 =?utf-8?B?cC9sMjVLdkg4MFg1MmNnL01wVFlpRlBmVGdGcHM2aE1yWENoL1RqZG5vUjhZ?=
 =?utf-8?B?MW9yeEl1ejhGN0VtWHdlemNYSkhxZjl6d3kxWURpbWtCd2d0QjlDSk5Qd1Vh?=
 =?utf-8?B?SzhtQUY1WDRpdlZPT1JXc2U4WElqNy90TnlhNWlvM01yYitONzBUcEhTK3A5?=
 =?utf-8?B?S3F5Z1RSRXdMdlc5eGlmTkpRTCs2NzVBQlNWREtCRENiN3BUVmIzcGNMZ1hr?=
 =?utf-8?B?bXBkN2R2djlsK3o2c2Y3alNGUVFBeUpCby9TTWY4RWxNTzdXNWdFR1NhdWgy?=
 =?utf-8?B?MEF4ZXhzWGxieEhtK2hyTmsyUlU4bDF5YkZtNE5CdmREcjFGcUw0NlJzQ2VV?=
 =?utf-8?B?T25BWTZVOGptekhIc21JZTBJYmtJTGNDVjFvU2VUMUdXWm9HUDBubENhQ2px?=
 =?utf-8?B?bDcra2dQWXdRTkM0SHpUZTZaYTBjdEhWemdDeVVYak5EcSsxVitiV29sZjNX?=
 =?utf-8?B?c0xyRmVJcCtURExCckZzcFhIRGhGTjBrSUxQRVpHT1JrTGQ5aG40K2Z0Tk8y?=
 =?utf-8?B?U05HNVhKbFlaMDMySWcyZTF5dVdCUjdBZ2t1MTNZWC9NVmozaHpYaEJlbjk4?=
 =?utf-8?B?bDQydmVDZ05ZTVFYVGQzcFRDQm9PSUJlNzdhV284aXUzemxnSnpWa1ljZkpn?=
 =?utf-8?B?ejNFb25wNFdlR2JobGxnSnprbHVGcXBramhQV09tcTRNK2tvTTRiWFFqUnFI?=
 =?utf-8?B?cE1PR1NmZlJCY0EwZFNQUzk5S0FNOG82VG1tMmxqODNTR3p2ZHZtL0E0QTRt?=
 =?utf-8?B?NnhUNHZsSW51OFRRUzVQWHo4M2ZzQUlCSUovU3kyN0NzWElqM3NJSmx0Yk5V?=
 =?utf-8?B?VVJFU0VWbmZsSWRmemVkdGVZTExFdWpJOEZZQXBxNUxOQ3lHakJTVTg0MWk2?=
 =?utf-8?B?bHQxTCs0em0zdGN1SHgwQWg4NHpQdXlOcko3cUlWL1JWd2tTc3EwdjdXUFVP?=
 =?utf-8?B?aFA3MWVnTGFkNGJmK3A5QzZYaTdtTUdnZ3BwSm5BVEVlOFY3V1pBMzhqRkk3?=
 =?utf-8?Q?arc5Oi8vwp6o8?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZnlIZ25aV3lsUzY1eWZIN3lTUjF1SlR2N0I3ZnpHRlVWTmxTSk9Md0E5UFlm?=
 =?utf-8?B?ZEQxR25nRTdlY3ZRUWxLT0FRWFVkWHBjbVVjK1h0VVM2cXlCYWNkWHg2cUo3?=
 =?utf-8?B?QS9OUjQ0UXZmS1haYk5KZlpIZzJoZlNJUk1SQnJIZmVUYWM0NU5xUHFvMTJJ?=
 =?utf-8?B?T2NXVGhidWZlL1ZKbk5XYndxRC9HMHllTHU3REhTT051YlE3eUltTElSRmsw?=
 =?utf-8?B?QmNsK0R0REl4TWxpcm9Qc1RLL1JMNDVLbnVaVVp4ZXRNa3lReG1WRFRENHNJ?=
 =?utf-8?B?TXdkOUhPWWhTNDA3cThXa1YzZFFLNE1VM2tDb3d2Z3NIeFViWU5GM3VVRkdE?=
 =?utf-8?B?ZUpSTy84MTFKUU5uWnEwWTZzWWNKOVM2KzdLOHl1cVJBMUU5Z1UxUlVaVk80?=
 =?utf-8?B?TXF5akdLMEpiYU9PK3UwZFp6SWtwK0RhbXNaVEpVUHlzTzFMZlk2dldOMFVu?=
 =?utf-8?B?YnZvM0kvRlVFMTdxS3BxZHFzWGZ1dm40aDU1K2Q0cUgzS1MreTlUV1FKTHVR?=
 =?utf-8?B?aTJhaExjOXpQM0xPZXkwTlBiRjI1Y2FhWmUxWDRqUlEvdlBTaWdYd29ELzJ2?=
 =?utf-8?B?K0RaK2FyOEtyUVVhWURneU13WnhsM3NHempndEhGVGcrditiU3ltcHBlYzhh?=
 =?utf-8?B?Rkw3ODR0RmUrNmN4QlIvOTZrNlRzQnR6VGQrcU1tNnRHWHh3VGV2Snl6bDA4?=
 =?utf-8?B?OVhlWjdXQ1dydDczd296d3BMenI1SEtzL2VzRld6UGJlTldmVm1hRTV5WWt2?=
 =?utf-8?B?b1BidW1WTTFxekx1U3NySUxNOWY4SmI2OUE2cFprd1kwSXMxYTc3b1E4LzVx?=
 =?utf-8?B?OTN0SGZiWHBZWGlBalpmWDB3WTRLMFc2cjI3Q2s4aXMxckQ1TnNacEFKUGsy?=
 =?utf-8?B?QjQ1VTFRVjFlZnVLcUY2TVdzY1pRN05rVUNvWlU2b2VNUVFWeWRZaGI4Q3h6?=
 =?utf-8?B?di81VUVsT1hJWFU1N2tNL05zbWVRcG8xNEdnblVqWE9yMDN0eHBqZkNFMHkr?=
 =?utf-8?B?UVp5Z3g0OC8zM3FaTlNYK1c0dGxPK0FCSTJ1TEhXRnh0c3Jjc1p2andNREI5?=
 =?utf-8?B?dkN5ZXl5U3Azdkk1NW5PVlRhNzNVM1paYnNmTVN5NmFxTVJSWWFpRmJWMEds?=
 =?utf-8?B?ZFdVTkhWRzFpR2hVQW8zU3pVcnJsbFlENDdKSmJTQ25zR2tjd0tyZTlaWjBX?=
 =?utf-8?B?T3YwZ0l2dmxvY1FmemlZN2R1SlJCc3JWMzRsMS9OYzl1alBaRllrb0RLR1g3?=
 =?utf-8?B?YXRzdnhhVjhKeDJUdndJOE9hczd2TmpkVnk3OVhOYUlpS3ZlRFpiQ1MxY05O?=
 =?utf-8?B?M1d5OG5JQSt6N2h0cVRyanlPeS9VdnUrRkptK3hYaXpwa1NFODNjc3FZK0FN?=
 =?utf-8?B?QjNkS2dFYTZoSGlEOUJrbFhuK0dJYytNTlF2eDYrZTJuVDlYaXVLOHpEclEw?=
 =?utf-8?B?RzJEKzh5cU5TNEpOQWoxUEMyWG8zeXNFUEplZitxR3N0cFhUUWJLVFJndGNW?=
 =?utf-8?B?N3cvN0pXYjQ3RnRMZ2tML1pOQmFUdGNFdWkxQ1BkZXVhWnFvVUJJN2hnV3pG?=
 =?utf-8?B?aWUrR3o4Ym5CeDNNWFdmYmtWWXhPalUwUVFoWXBzUlJicTI3V2hvMHR1Nktv?=
 =?utf-8?B?OXgreFpnRmVYdDhQWldYSTI0TjBUUmlrSEZSVEowZHdWMkpaOGlPNGRhcENO?=
 =?utf-8?B?UWo4MGZaYTVQS1RXVzdudWxuWU1VZERIeDQ4bkU5eUNPdXNYWDZpejg4bXpZ?=
 =?utf-8?B?QUVjT2RrSzJtOEE0amM5RllQMWdBVFpHVFB5bnpaMHBSbGErcnQ4SkxYNmx0?=
 =?utf-8?B?cllJWjJmbm5laGlPU3dsSWVRYllrMXdIbG90TGJRaElrdHN1WDE4aFB0LzQ2?=
 =?utf-8?B?TG5nVURmTEJnT2xBL3VQU010R3NDalJsUDVvQXMyOFcrRGxueDdyL0FqQWx5?=
 =?utf-8?B?MFFEZ2Mza2lGYW9IQjZONTVldzNyV290YUp1TTlySjFEaE5XVUpaZmUyTC9L?=
 =?utf-8?B?WCtxaHcwYXpPNmxjN3FTOXZoNGJOR3FIR3VsTk5HK29lV3BKdmU0RGxHSTly?=
 =?utf-8?B?RmtyVnZ1M1NpM0FJbklCQ1YzcTk2Z3FzYVFzSHBvRGw2Qlk4SEpDajVzRklo?=
 =?utf-8?B?d0Ewd1lWR0k0MlQzSGFjb1cvRlZ6Tm1vWHBxN3U3V2l0MmlRYmpQNVBLaWU4?=
 =?utf-8?B?c2c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	BXQ/QD2H0WhUs2hVUFGqcZOy/eROIrdQkYcMgSXaL4MHc9il36D/Uv0AeqYmS0/WVCIHiznAHdRPluSjtvQF6ZtVsQGep/Ttzrr/Pr9F2sdQ1VD3OjAJm97EI0YdVSuI3Na1uB8lyAqREwnCpMnHzGXWYsbeqUOW0AoRflj0kxDTOCUOLkTmfXAinGJjicE2Ecd5L/3EnrFC9HsFelZmOEBX3cGqHXakWkvbDhHj8khFaac9PpO04tLofA0Ui6r6FySq4ZeZDtwbjb8algWKUG+6ZDj+z0HiLEfE73PHD+V5PiM5pHxwNtAiEVlTYFwENNCzrar4O0d7z9TsnG/3TaLg2K+34GcUKlLwsssieZU6DMyF3qaDRqI5j/AhTlRWRFXrIF++EmG6J0Uqo5gPHFuJ0Tp0MKAuSuK0SiqeG6itqLMMFTKqbD6XUJFC+CnqqOYYM8Y9TpzlmLp5Pb2NzAhEh3QnRVD4gUhBpVsfsBEhDPUKANpVPAheKTtAOzctjKiaJoCTgY+lEwneD7aMr/U0Fh/BeL41BEwkXufjM2kqiZEaceDn/gKsRl1kHm3gNSJETgcpgg/13r4scTYa6cxciskQw6wEo+KYpAOZ07s=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2af1c038-e89c-40b7-8dc4-08dd706333da
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2025 14:49:13.1650
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hf0gwais02E70j/MkZ8X9CZE9pgHb1ZCWDMGz7QEmjfvwsXZdvsI87uPBnm1h9pJBiuvF7DGfS5uTcJFGy9qSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7906
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-31_06,2025-03-27_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 suspectscore=0 mlxscore=0 malwarescore=0 spamscore=0 bulkscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502280000 definitions=main-2503310105
X-Proofpoint-ORIG-GUID: nWEo7Bl4oe0Yl-y_6P6vp-FzNTEh4kXd
X-Proofpoint-GUID: nWEo7Bl4oe0Yl-y_6P6vp-FzNTEh4kXd

On 3/30/25 8:10 PM, NeilBrown wrote:
> On Mon, 31 Mar 2025, Olga Kornievskaia wrote:
>>
>> This code would also make the behaviour consistent with prior to
>> 4cc9b9f2bf4d. But now I question whether or not the new behaviour is
>> what is desired going forward or not?
>>
>> Here's another thing to consider: the same command done over nfsv4
>> returns an error. I guess nobody ever complained that flock over v3
>> was successful but failed over v4?
> 
> That is useful.  Given that:
>  - exclusive flock without write access over v4 never worked
>  - As Tom notes, new man pages document that exclusive flock without write access
>    isn't expected to work over NFS
>  - it is hard to think of a genuine use case for exclusive flock without
>    write access
> 
> I'm inclined to leave this code as it is and declare your failing test
> to no longer be invalid.

For the record, which test exactly is failing? Is there a BugLink?


> That is technically a regression, but
> regressions only matter if people notice them (and complain to Linus).
> No harm - no fowl.

-- 
Chuck Lever

