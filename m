Return-Path: <linux-nfs+bounces-9960-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE4D2A2D79F
	for <lists+linux-nfs@lfdr.de>; Sat,  8 Feb 2025 17:58:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC8991889C07
	for <lists+linux-nfs@lfdr.de>; Sat,  8 Feb 2025 16:58:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AF7A2913;
	Sat,  8 Feb 2025 16:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ewk6mxFy";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="o/sUCQ9x"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40040A23;
	Sat,  8 Feb 2025 16:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739033900; cv=fail; b=L8l82hgEFIp6Equ3itZwqx9QuXkQjB5nea7t9bq4UXwJhFsDege4jZx4iqseE0Vl68qZIzMzrjfuR09y/V8m6VmYAgV17sexoRESeI1km+h/5yJJdz3dBROdy+REW3p/Nn0aXs/7RGCbfT2UpUsDxc5t+I+Apnwa1SLyLOR3kXk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739033900; c=relaxed/simple;
	bh=4kwAk7fdqo9N5nZlJ+iV6Yo4bG3vp3fv3mNtIcLyVJ0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NjAU06cmDF2tP+CvgSEfhQXXIWO1C+8e9CXk2dtjJUIQqFIA3qhvAqolhV5L+RftQbMzmLXgdA4GQOg/z+rNtKeKgMd4CjzwWu2L+tdnyjateP3JPX0HqDENGUyxULqYY7iVuTX9d1UHp/EzajEE469sq3185DnmN/qpbwi6fxg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ewk6mxFy; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=o/sUCQ9x; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 518Dfdcu006498;
	Sat, 8 Feb 2025 16:58:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=+ZtHE+CgHchgxN88m8elge38NeiR+jt8FUz2Ty+V6Vw=; b=
	ewk6mxFySjRykNXNUiNWztdCTau+pt5remBr8BPbiMMitRbprIsVX0KnexfgbMDz
	BAWpzn/GDJcIP4JdrQ4YSmzvPol01JKhFO30fn0QV5exZ1SWH9Gmte4ppNyvnZFB
	caQ21SZgG68VxPgA5UM68mWIJHPxegX974wC1u4GSjh8IxH+MagpOdV8BzPgQjM6
	S7/reDYLc7Y1/ogzgbz76sNspmvoLGyEQSCpBiJWdMP0Bq5PNl5hKKR21Pu+c3ds
	F4hmXtgFSrz9b1tAkXES/AATLuxcqi47hiTc/1JL77THJTxcU5Mesyqi9kWVzGfc
	Y87bDFxGyJjAv0v/Yp95KQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44p0s3rcyb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 08 Feb 2025 16:58:07 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 518F1A1n017134;
	Sat, 8 Feb 2025 16:58:06 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2043.outbound.protection.outlook.com [104.47.66.43])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44nwqc6b0d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 08 Feb 2025 16:58:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MDw+CtyL0oy09ZmCJbjthEPVBHm9AXduT0GvDoSWerhf+CQo6XcYYt4PNYhuiRYuQnWgqds+eaHnSYfzBZqkt3aadYWHJa7zSFzy0b2h6/sVftuvxGWvtkqwot04JswxhTSc9vXKRZlMMf4UKw6OKFfYyisP+0xo9RT4DLAJEfW4J7oZZQbCmgVIoBoIFzahzc7mAiq6lYWmNa6kdUmx3TL3jhmsBh5N3N2VKDpSfWDxdzLYvayCJnbS5yz3wte8YUlOSvYDho82yQIFdXQ02pP5LtwYID9g7F5WdsxCPO8nO5wRJ2TFzXUKA9kyKW+q6ic3mTCcTDLaM+Dgla8EoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+ZtHE+CgHchgxN88m8elge38NeiR+jt8FUz2Ty+V6Vw=;
 b=PDCOW59W/LGCvo7hrOwKKGqmpYUvpCvUS8XbT7ZdAqKRXMw0z9h6GS4vkFbkuAGW758Rqi05+hONq0Uuuc0hpvyo6c/WgAwaz9PKeSxUwb41/64aUiqUHfPKudKq2u9t9bcCaK5bEPtikP8G1UoYIKCenQMfAe62u9U/AxPaL5zLCavR1ml7RvlfWL6gs8f4hFFOPbmiPDvyfgtG9VxnjZ5u2W63iL3dkwUfirBTUUJ01sZGH1A0/LKs8na9OPe8HV5LPTfsimsAxcQiQ3tj9c7Z3IrPl1Ih7njgApNt0wdctCy47C4ixfEIDChDniGYEWTsR2SXxG1NxnbbSdUApQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+ZtHE+CgHchgxN88m8elge38NeiR+jt8FUz2Ty+V6Vw=;
 b=o/sUCQ9xyDFVS2OYaS38OxJm+gOcfQz/zd/N6d/Dk2v4wvP8C46qLITl2CvWi/piF60BLztLuFILONByHewylIE6xkcyeIhpjhbU3V0gwWZUx0DS3H/Vvvd0lA1dZN8UXyTh5JQPftlYXIBFnYT9yUb9Rvmp2DNpJv3mtvwrAdw=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SN7PR10MB6452.namprd10.prod.outlook.com (2603:10b6:806:2a3::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.15; Sat, 8 Feb
 2025 16:57:39 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.8422.012; Sat, 8 Feb 2025
 16:57:39 +0000
Message-ID: <184cf63f-d9c3-4948-aae0-efb23a49e188@oracle.com>
Date: Sat, 8 Feb 2025 11:57:37 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/7] nfsd: always release slot when requeueing callback
To: Jeff Layton <jlayton@kernel.org>, Neil Brown <neilb@suse.de>,
        Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>, "J. Bruce Fields" <bfields@fieldses.org>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250207-nfsd-6-14-v5-0-f3b54fb60dc0@kernel.org>
 <20250207-nfsd-6-14-v5-2-f3b54fb60dc0@kernel.org>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20250207-nfsd-6-14-v5-2-f3b54fb60dc0@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR05CA0025.namprd05.prod.outlook.com (2603:10b6:610::38)
 To BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|SN7PR10MB6452:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a64943d-aeff-4071-e7ef-08dd4861b22d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?L0gvY1pWdzNoZ0xyc3pPZHhIUFZaa0ozbk5YZXFrMEJsOWdFekkwOEtFOVRB?=
 =?utf-8?B?aFcxdStQbmZSYUlBcVZEV28wYVh2L2o1N3pwRzFCaGd4VHBoUTdGQ1VwbDRO?=
 =?utf-8?B?OEFWalhVSCsxR3ArVHJpRnNuT0RpYkQ0TWppOXQ5OUFFU21TbnpTZC8rSmZ1?=
 =?utf-8?B?UHB5bHFQMlo2ZVZ5NnBYdkFOaEhZY2NjUGYzeE9Ia3ArMHJpOG5vSjcwVWtC?=
 =?utf-8?B?RXdnZkswYjZHTlpQUklqN1BLOVhWQnZZVmJHNEpiaFhDTHZhN0RZT08yQ2Fz?=
 =?utf-8?B?R0duOVVmV3QyZGI2amtYQTFESC9VVWZoN2QrZ1N3cS9LdG1aSlhUME9PWnpM?=
 =?utf-8?B?enB4MEJnQ1N3ZGd0YXdMTlA2WVFqSE82S3grSWtQZDB1ZWdiQmZ3RCsva2Mx?=
 =?utf-8?B?aUw4bGtNclBoTnBvM3JUN0c3ZHdYOFA4VXBocHdXbzU3SHROM2NWVnZlL2pn?=
 =?utf-8?B?cmNXUzZFT2lSNURZaVBlRnhTaE9tNlY3QkI0NE1oS3l4NTQwaVhsTlVFaThQ?=
 =?utf-8?B?Z1owMHYrVEZ5RC9EQnFnOE14TGJmUnkwSXV3Y3hCQ3BSTWkyaCsrSlpKcHhw?=
 =?utf-8?B?SVU2cDByNHI3eXhEYUV6Q1FHaUVQNThQYVBBc1JzcVpyQU9aeCtHSUo1bHN2?=
 =?utf-8?B?eVJZK2VRS0c2Qk1naDBMYTh2MkhMSDJ1VU56dnNOSU1XU0xtL3NtUW4rdEUy?=
 =?utf-8?B?c1l4RDVxRisvTGR0VzdzODljdVczWStoUnEvc1NBci9pUjZlMDZOU0Y4Vzlw?=
 =?utf-8?B?akhqcVNvM1pnYi95TENOdytpeFZFc2VNSkRVenl2am41TEorTDlGNnY5aWdR?=
 =?utf-8?B?WDhVV3JVRGtKZXRvRDFsNXI3cjdQeDdqQlNuRjQ4U0F3dzlTclQ0Z1FuZlFv?=
 =?utf-8?B?T3BSanp6eGdEMG5NVzRRTThaekNhSjY4eE9CUml5d2Ixc1RvZkYzdzVKN1FH?=
 =?utf-8?B?WWJVc0RzS05pZHNCeEJWTmVUZE5LNGtQZ0lQWG9aL01aMkNpOGQvRys4cVhH?=
 =?utf-8?B?UTlPUm9MekdudWltbDltRUhIQnc5RzVFMnZLSmhZeC9tS2xHU1hzclo0clF4?=
 =?utf-8?B?eGI0a2ROeWZxMXlUM29wVlh3VWhzdnQxZlFLZ2VuaERrdDNsNU1pT2RpUjRl?=
 =?utf-8?B?S1E5aXcxbWhuRGxoRVozYk01RUNqVFRVd2JTMmp4Ly9pRjZMbmtLQ1luTy9s?=
 =?utf-8?B?ZmRPMzhENFFYeG5pMFFXeUZxYWZKVHZnMURKVXNKYityQlZkcXFkakpSbnN4?=
 =?utf-8?B?RkN1NURvNmNPZlBKQmMycGJEeFVvemdQZTlYMmhLZGZLSEFNN2grWks5cGFW?=
 =?utf-8?B?Q2wrcVNheVhVQ0MwWHE4TkhtM3RuVk53bTdyZXNILy9TNW9xMG9LTkYrOVNj?=
 =?utf-8?B?M0Nrdi9pencrL2JqaENKTlhpYWtBTjBiYnFmaUplT01YWVFnQUdoRUVNb0dH?=
 =?utf-8?B?SHZod0FoRDkxcnZRRSs4bnY1a1g3Q0psVFZPaHpMS0pJdFE5SHh3YXdjdC81?=
 =?utf-8?B?amlJelJUY25xYjlKem52RG9wb0hUSUo5SmJLRlRUc3JLNE0vV2dBS1lKSDFl?=
 =?utf-8?B?TW04TUx4cEVtUUladEU4RGFseWdFK1prbmNaaTB2OGF5OEU5cVdLcDYxQk9y?=
 =?utf-8?B?NFBjWk5FVGVWR2FibW1hdzhQMkoyVnpMbG1GRzlzUlkwbFZvdlVjZXViKzVN?=
 =?utf-8?B?Yjc1Nis0citSRTBHVTZXWkJFeVVtUEVvSk11eHRQcHRQeHBmRDNOMXhua3Jp?=
 =?utf-8?B?Sml3aFd3RFU0eGxWbGQ4R0xvSGpMTjhNeGZ4UVNMWFgwY0c2eTlmQzNpektr?=
 =?utf-8?B?ZlRHOWFOSC9kUHkwZ09FaEZMYkMxZGo4by9ZbFdKK2JDNVhHcFB5endUbHdH?=
 =?utf-8?Q?5eGQU9VDZkibc?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?akNIM3pxa3B1QW5NdEFNV2FFODIwNG12eDRjMGJuUUZlUXp3R3NDQjJPZFNs?=
 =?utf-8?B?Q3R6aWZOckVmZkNGT3g1OHJoRDhGZStlcDJOdmx3MUZ3MlZRbGpEUUJjNFRr?=
 =?utf-8?B?dlJteHgzbTBsZURPZHZkVCtaVGVuT1VuK0FVdjkzOUVERFRXOWJFQ0U2RThN?=
 =?utf-8?B?TVhTcDlseDhpYjF0YjcwNGFSb1ROK0pQZ1U4Wnc2SVAzd3pjOXFXT0JHNEJ2?=
 =?utf-8?B?NndESmVHQ3BaZjlPV04xK1dGOHpPWWpLV3BOdDI0L1J1aHoxWmRhTHlIU2Ju?=
 =?utf-8?B?WDEyNVFlMjVnZDNzT0svRDFkcmZseHpyRGx3dWp5ZTFQbi9EWTc1TjVJNDdi?=
 =?utf-8?B?MXhMSEVOdWFpb2E3QWkzLzBNMERCblRwWW02NnNOUklpZW04dmpuc0RCRWp2?=
 =?utf-8?B?MUdmRzhQSllCaGlOUk1uemVZb0Y1SFM0ZEIySktsQytaRGZpMHFwaitmZ2dB?=
 =?utf-8?B?d3k3QWYxUktFSnJyYlZ6YnNJR3FSeThsbnlJWDFETWJMRnhDTFphaDZ6eFZl?=
 =?utf-8?B?ZU1JVUlzOHlvcU1ERXZLVzY0L0JEaVNHRG1NNW9yak5qcTErVnM2eGNHRG90?=
 =?utf-8?B?dlZ4WmhyUXdsMkFGUm15ZFNwV3ltNUNoQ3o2d3lmQlppL1RCMHZSdHFmeGxB?=
 =?utf-8?B?ZW9oVFVHcHFIWTd0azQzK1h6NnNYbjlCMm9KVlNET1JFcGx2ZEl3ajF6NHFY?=
 =?utf-8?B?Q2UrdS9HT0RHOXdHQ0pPUkh6OHBxZGhPRkUzeUhIU2FNQkVUNjJ2SXpqcCtV?=
 =?utf-8?B?NmNKb0I3WnVIRXJ3UkVDVCtCN1FLOWcwMEtSeFdsRDdrZWV1RitmVmJVM2hV?=
 =?utf-8?B?ZG51K01pL3dxSzR5SkNSU0JEcGRVcUNzU3dEWlRqZXhMMjM1WnJRN3hvWVVw?=
 =?utf-8?B?MW1kZG50UkRoeEJBU25IL2J3d2FMRDRQdWdhdmVUZ0MrdFBkb0hob1J6Z29U?=
 =?utf-8?B?ckZRVzZZNG1KWWdTcDJqV29oMW1NdG1CL1dQRDFJV2EvaEkzWVQ5UERjYXdl?=
 =?utf-8?B?UFpzUURjWDJLNUQ3UjcwWkcwMDZ1SXo4T0JtaW8yYUhmbXpLR0lWaGRJbzRy?=
 =?utf-8?B?MVpnVmlaYVB3S2EyOHZwakl1UGo2TlhsclE5SFRUVExRTU56d1BacEJKcHZu?=
 =?utf-8?B?NURCNkgvNDlXZ0x1dHVBcW02OVlPMk5Ya0FpVVVwcXNhWFhZMUpveTd4WmFN?=
 =?utf-8?B?S1M2YmRDL3hmd1lFKzY0ZmdHaElBUnFTOWN0L2RmMklwM1AwUVp0b0JJQ3F5?=
 =?utf-8?B?VFB0SjV6WFBkMHpsMUZIbG8weHg4dEI0MGNIbGdNbWEwdERLOFFSMUk3ZGpv?=
 =?utf-8?B?K3g1bHJwTEoyUG9OL2NDLy8zcTQ4WmJESm9KT0t6S1BTWVF0UGpaOUV0a1Ur?=
 =?utf-8?B?Z2tKenZpSzFaVWl5OGdQR3dTNGw0UWUzOEhnQ3ZOZXVTYjB6UXk0cThVUXdJ?=
 =?utf-8?B?MXNidTlyeXBrdm9kSmgrOCtpMjgybjJnNFVYUU9wSkpqNXJlTEFSMjh6Tng1?=
 =?utf-8?B?VHFWbitMTUJqTVZ2ZTNUQW5lSG9aenFCakdjeVpqL2xxbGVZWXZwak9rQy8y?=
 =?utf-8?B?U2h4UGdzbktlTDJFOFh2NzhQaDVkaUhkYWdEV1gyb2czYVZJdVBoanE1MXJN?=
 =?utf-8?B?TitteHc3R1dIYXVQVi92eGZQbC8zaWdMQ1hTY2tYRnYrTEpSVEdRMnJub0dN?=
 =?utf-8?B?dmFRZzVGdXdCY3VpNXlGWkRNTEdLV2lYTXhtWlBnVVdadFZXSmJqS0R2Zklk?=
 =?utf-8?B?L2UyUEVLQ2tDMHJxLzVIK1BoSUVtOXBQM21teENHdm5keXFZdjBrYkROMWNL?=
 =?utf-8?B?c2g5bmV2RzNtM1YxNVhQNnVuVDBTSkk3clN4VUV5NjdadHpBcC9ic3pMd2hK?=
 =?utf-8?B?YnJFd1gxK293OXpNU21HR0U3MkNUbnFDa0xUcTAvNmNlUndqaFFNdFFtWlI3?=
 =?utf-8?B?OG1pbVI1emJ0RGdsRWNhaTdEWUg5REE2RDBtVUdoQWtuK05MZkg1VVFWc2tX?=
 =?utf-8?B?c0ZROTd1Ni9DVXUwZTV6Tk9xVnZSU3FFbG9UTnR3ZGpDRDZCL1Z1SWhRNjNs?=
 =?utf-8?B?Q1B3TGxIWHFHcVdueUZON3BSK0hhU2NJYzZsTmdrK1o3U1IyQ3lKUDZsN0kz?=
 =?utf-8?B?dWtzQk5lNUdIZFV2djRxdFhsYkhUZVloZk53cTAyQWtNak9CaXZCdFV4MlFw?=
 =?utf-8?B?bXc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	DQTnsXavcdRTYIEO923R0Sn3APw+MzwQ4KbjNNE0kHLZiYdEFYT3fgrO77elnLSkJRuHsyf47h9i42mrhKzmxGz+R6qByF3bISxeNn6SF+ogJzSMFEMatHSnqb488mOWCE8joMnlM4WI+rfiNEfD6vY+eq0w1OoMDZYAALp+/sLRAeX4yDvDgBCr/pnFy6Pjb1VkZZCq3NIMh5sQXNzWRMDw/17jOQbGYKvLrtGygelowak1439WioWuwlBtMYFWE008ny7CY9kUIxGOJvziRPyv3ytJ0hQxAr4cTxH31OlgBo4H6AoNQsy0reHaeePlkYDAYV987HvhZvhQ7/UL9EYoZwueWFfTvm4ip+vnu7XdYfaqPkEpMZN+XWWLHJZfFWr/Ig24fW0Q+ShuXYZB+rAfewZa8asjAFRQXJzLCCeBNY6iY8vZ7Ss9uLJs+o5D7gWWUIQUbcvZHOfMXq3zrNJp0KVvA/d2q2W6EBwgFgnIYYROmCQ3xpBP5ydzZzHHDE6RCOL+gmMbQS0SweUwoTsKP1YSBwVPZtbYoe9p06TbOVsNA95mJtxFN3mZk0EHBxXx3HUL9Mat5c6xR7y797W0EY1bKmouW0GWZkJy9as=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a64943d-aeff-4071-e7ef-08dd4861b22d
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2025 16:57:39.6296
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Uxt3B6QenZwD0+S/HrN7wjnXssOSBt6FBv2ZxgNyTFC88PhrfEkggbnPtIO/U6q0bIbb5HmBD//kNZmC3LkQGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6452
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-08_06,2025-02-07_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=928 spamscore=0
 suspectscore=0 malwarescore=0 adultscore=0 bulkscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2501170000 definitions=main-2502080143
X-Proofpoint-GUID: fPRWMApWy6aCwfHL19GHJoL5S5EUqxgV
X-Proofpoint-ORIG-GUID: fPRWMApWy6aCwfHL19GHJoL5S5EUqxgV

On 2/7/25 4:53 PM, Jeff Layton wrote:
> If the callback is going to be requeued to the workqueue, then release
> the slot. The callback client and session could change and the slot may
> no longer be valid after that point.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  fs/nfsd/nfs4callback.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
> index 79abc981e6416a88d9a81497e03e12faa3ce6d0e..bb5356e8713a8840bb714859618ff88130825efd 100644
> --- a/fs/nfsd/nfs4callback.c
> +++ b/fs/nfsd/nfs4callback.c
> @@ -1411,6 +1411,7 @@ static bool nfsd4_cb_sequence_done(struct rpc_task *task, struct nfsd4_callback
>  	rpc_restart_call_prepare(task);
>  	goto out;
>  requeue:
> +	nfsd41_cb_release_slot(cb);
>  	if (!test_bit(NFSD4_CLIENT_CB_KILL, &clp->cl_flags)) {
>  		trace_nfsd_cb_restart(clp, cb);
>  		task->tk_status = 0;
> 

The NFSv4.0 case also goes to the requeue label. Is
nfsd41_cb_release_slot() a no-op for NFSv4.0? Even if it is, this is a
little confusing. Later, in 7/7, the nfsd41_cb_release_slot() call is
carried into the helper that is called by both NFSv4.0 and NFSv4.1, and
that doesn't seem necessary.

Perhaps this change should be done /after/ the NFSv4.0 error flow is
hoisted into nfsd4_cb_done().

-- 
Chuck Lever

