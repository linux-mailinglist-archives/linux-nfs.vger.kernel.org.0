Return-Path: <linux-nfs+bounces-9040-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA29CA081CC
	for <lists+linux-nfs@lfdr.de>; Thu,  9 Jan 2025 21:54:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3092162536
	for <lists+linux-nfs@lfdr.de>; Thu,  9 Jan 2025 20:54:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52B54202C31;
	Thu,  9 Jan 2025 20:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="EXyhMCKA";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="lNW3+wrz"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75284204C00
	for <linux-nfs@vger.kernel.org>; Thu,  9 Jan 2025 20:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736455905; cv=fail; b=HxKskxOU0X0tQzTHaPUS0VnA8c9MFvLJOdE/wF+jtQ/Z/wfHBlDO6XrRLxDRewn4b2TXmUXRchQnvMFBbVLqy/ekXRkk2NOsDkZPbx+Jbci2uADU37RZD6EoHaiw9ElwO9umO7pKbLrOG4FbIA+W9EIx8c3s/WdEo+y4FYRHFXs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736455905; c=relaxed/simple;
	bh=mZl3gL6VyRJdYBYJqotLG2YwkEIrGn1fqTMAw9M91fc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XSTNr6xG5/2hPkilzlHB6kohhk1eamPDtZ93zAEkKlXuF1EVENuAy544urIeMSw2gexH47sjcB5ZHnYFRpY4sD2d4EgWqvIbwS8+qdcT5AjHYKmyL/pyUp8RbkGd4AH213jvD5GNjz8nxNV5cCyLWpdfPVT4JePjQJMLwViyt7o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=EXyhMCKA; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=lNW3+wrz; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 509GXo3K016260;
	Thu, 9 Jan 2025 20:51:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=+Uirv4BppyRnKE8qeMI2RuVyp+K81wS2kGsVzRfRYTY=; b=
	EXyhMCKAvDvIByxhPfcO/LdXYv3if+cFfbsIwy6dMNfsbW/wrSchKzw4D7Am4UOX
	6FEnr9//0PGQv7sGHgK0lxerUZ9m3599bnn1cBDeNZ4jtmWhr6MDNZsACdBHtBDa
	VlPfuyw+gOxxGSGBH+JPAYPJ33OnzC3wCFlAbedotR465AtsgvEtMJpMKYnNrNmx
	PI5/SnGOJ78ENSCn2tMvI7psNlCZywcFviHV48KmJ6pjCvwLtSLYBABdSKzfdRTl
	iFTxuEvUoVchLD/f1ViO07GlJ4iy4q32SoeRHDPjQkZibdHrgQhg9CP5teqOsY6f
	L9qwwbjvZ5EkYVZrW0/j+w==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 442b8uh914-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 09 Jan 2025 20:51:35 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 509J7UOE011061;
	Thu, 9 Jan 2025 20:51:21 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2173.outbound.protection.outlook.com [104.47.56.173])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 43xuebekkb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 09 Jan 2025 20:51:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iapxXHobTFGI/hG/X502S3KsSxgJ4hAo7jHyUQEhRe6/aM4XSlCH06Xamqgc1RNGiOVqQpF94G2Po3cRAnZKDGkAvD8Pd4PrkgZZikq4WTUfPiNAirG8HBXyOTkcGLh9neAuQ67CgiFE20UeTN8biknB26oqgX3i3uoMpcObb444lNEUqeoS6XrzjEt49xJwiCc3JVRzMtu+z864GHmc9FKFThEf5UjhgFN7URx9yGc29+KbFempgG/blh/B3lKY5C/eKS3KZTpPKaTJDXHeix0qmIr+VZM4vJ4lqAkoHE7GIN+Wxn23t4Bny2kgljf8CS5V0U2JsQMNV2Li99k1Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+Uirv4BppyRnKE8qeMI2RuVyp+K81wS2kGsVzRfRYTY=;
 b=ZCrJkn2FStyav6PjeeJ/ADfsva9dhcGUloLxM6Z7Ed4J2ADXAWE+8jDkDYDAIGymVXYAM43IVPMJ2NzLSSPZGJrP9faLlBMCySiq8XyeXeqVEfPFzVMEFb7bfAjNyjtSSaUrEuxSfdJwYODH5nMhYa46JT5a/uWrK28kUzG8Yv0CypXfCxBVpt2ZngoDJq+i/wU6vuaqWVqRKmwXKSFrM+laic/npZWJQQLuWjFZvROpy0aYZvnXHAHSov+SPxsfKdOVuo+8Auz0TIewnZk767kxBWilKgxB6lwFMYt0wkM3IHeihVTiugdTCJP8WU1CAtIq6/xwZ0/t+11D7FEKxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Uirv4BppyRnKE8qeMI2RuVyp+K81wS2kGsVzRfRYTY=;
 b=lNW3+wrzwPw4hgBNzqno2Hpc1iodp2IYms5QhbbUH/vF5B5umB1GnLpVea3yYkB34oWaAJWNBbpRhw5hEqZJxcY0GMCSWfF+rqDQabjjiHwSdp+frrm+sEi4/FOGXecTthO59Hf0jKN6UI4BUS5WNh/ObyEEY6TMXGdCmWs/g3Y=
Received: from BY5PR10MB4290.namprd10.prod.outlook.com (2603:10b6:a03:203::15)
 by SA1PR10MB5842.namprd10.prod.outlook.com (2603:10b6:806:23e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.10; Thu, 9 Jan
 2025 20:51:18 +0000
Received: from BY5PR10MB4290.namprd10.prod.outlook.com
 ([fe80::8c24:37e7:b737:8ba5]) by BY5PR10MB4290.namprd10.prod.outlook.com
 ([fe80::8c24:37e7:b737:8ba5%4]) with mapi id 15.20.8335.012; Thu, 9 Jan 2025
 20:51:18 +0000
Message-ID: <d08e9be7-b801-4479-80ac-b981804fe60d@oracle.com>
Date: Thu, 9 Jan 2025 15:51:16 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] NFS: Add implid to sysfs
To: Benjamin Coddington <bcodding@redhat.com>,
        Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org, trond.myklebust@hammerspace.com
References: <20250108213632.260498-1-anna@kernel.org>
 <20250108213632.260498-2-anna@kernel.org>
 <0430CAB9-DDCA-4DE7-B377-1AE485FB731E@redhat.com>
Content-Language: en-US
From: Anna Schumaker <anna.schumaker@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <0430CAB9-DDCA-4DE7-B377-1AE485FB731E@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH5PR02CA0010.namprd02.prod.outlook.com
 (2603:10b6:610:1ed::22) To BY5PR10MB4290.namprd10.prod.outlook.com
 (2603:10b6:a03:203::15)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4290:EE_|SA1PR10MB5842:EE_
X-MS-Office365-Filtering-Correlation-Id: d5a35d20-9ef3-426c-b711-08dd30ef5d5b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|10070799003|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bEczSjJ0b01hamVsQmcvWFczOEQxa2xtM0RNR1hIS1VCUGFRWjN6Y05iMVpR?=
 =?utf-8?B?UCtVbGVxcmZvRWN4a1ZRak1sWE9hSDJOR3RsQ0xTdVVsRUxGMTVvUWJCS0kz?=
 =?utf-8?B?dXNHWE9JYmtNbTJmN1NkVTFVRThzYVkxU1hUMVRyLzByTEU5anRTUnpTdW9q?=
 =?utf-8?B?ZWdFZXozcy9iL3k2akpkWFlhK3lCV211VUV1UHcwNitueitMaytXRWM5ME15?=
 =?utf-8?B?WjUrVkMzTTJBamhGVk9UVWJUbHIrZU5iTWtBeFVDV0RPMnF4YS91Sng5a211?=
 =?utf-8?B?a0JSbUNKMDFXbkN3c0ZxS2tJTWJTTHVmR28vTmZWRGliVmNRa1g4WStwWlRM?=
 =?utf-8?B?Y1U5SlBqSndmNTZYNmJBbmJ3RTNmcDYyS1VUVThGdzlGUnVGNFZFMEdMd0dm?=
 =?utf-8?B?U2RnZEIrbUpwU24xZXNnQm1YeUpKa1Zzb0RncHFPN3Zzczc3R1g3bUF1ZUxI?=
 =?utf-8?B?YlBhSjQ4YWF3MkM0QnZKT05Ra01Iekd5dlh4dFBWemdaWk80Qm9jbDRYcG1I?=
 =?utf-8?B?OWE5Z0d5N1JUS3p0ZlRHaHNkZUdmZGVMRVN0cVZWR2VqaG5xUW9JYXZmd1My?=
 =?utf-8?B?MUNuU1ljZ05TRDlqUHR5R25yQ1NITEZhbUFxMnhlT0tDRnA1b1grWHpQUjho?=
 =?utf-8?B?VUxpeUF0TEx2alVTWG5qMG1oRkVEdWFwTU5wVXBPSWRXb1JPcGdEVjZ5NWdv?=
 =?utf-8?B?TmoxaXFqMTZYRzEra2JFc2xIUHp1dXBQYzBJT1VuNzJraXlJWWdLS3J0QW9r?=
 =?utf-8?B?c1A4R0VLaUpPNDhrSFFjNXFldUc4OEwvWkxxWmxzRk15ZFBJaEt6NXNtVlpo?=
 =?utf-8?B?dkpieSt3dzFmRTRYSDkwS1ZpdGNpWk5Mbkoza3hHam1LWTZRQjJmRFBZNHNr?=
 =?utf-8?B?NmFnNXZiODFpZk9HZituTFBhdWl4MXNlWTA3dFJZTko4dDFwVDAxK0V0YmZw?=
 =?utf-8?B?eGVQWGVOWG9yazUwdjdiaExrNnAxTjZ0dExZQ0ZudURhcFhNWlkxcS9iTW5D?=
 =?utf-8?B?T1dITlRLaFRCM21mRHpkZXpmQnBWbVREOFRsVG1rSjArL3I4am1mZ1hFZk53?=
 =?utf-8?B?U2ZtWjhTT05nR0tiSWVvd3VPdE9XNTlKdU5zSW5WdTRVWDBnS2lNSE0rR1NE?=
 =?utf-8?B?elpac3RqMjIvUHNkenBIMFRqdUgwbXlSbTU4YlRYaXBzeVBtVWw3UVJxa3VO?=
 =?utf-8?B?NmdrSXV4a1RxdWVZRm5Wb2h3eE9zMWVNY0lsMG1sUlZoOEhMYlNwc2w2UEJx?=
 =?utf-8?B?aUw0a3FCZXNpemp2ZjdOWUVoZDV5Rk0zWFRmYzZ4OFFDM0RSTEpES0xvcWo4?=
 =?utf-8?B?aCtvRXhQMmFRUFllZ1JEWWpKVHJlM2ZCNVdwSUY2NDdnVWt4SG1LK0xCOTlE?=
 =?utf-8?B?S3ZVT3kzdDdWKzdEUXcxd1JLYkZkcFpMYlVkNHhLaStQVUIvWkNNUUk4MVZS?=
 =?utf-8?B?Sm40RmtuU0pYdzNRb2gybjE0M2hvd2grZnZkMEhWMFdCWjZoM3FWa0p6dHFm?=
 =?utf-8?B?YUN3S3lTTU8zbjRnZWpaS1pibGZGMjFXSUd2cmZBeTNWSm5JMzBJL3FBSldX?=
 =?utf-8?B?cU1sbTF3Tk5KbWg4ZEE4ZFU4cGpSdXFMQTVON1VpSTRkYlp5c3c5UjBGRWR6?=
 =?utf-8?B?b2dmUFhTbk53Y1ZQTVEvVldKZm1idkhwL3BRK0liZGcrRTFGSEhGRENBTDZO?=
 =?utf-8?B?MWQzOXhicEdoSTVDcWF4Z21wRUhNblVDOFlaMXpNS1JpK0N1czFXeW56WU1o?=
 =?utf-8?B?eGkvZGtzZWJHLzYzdFgrVXpBNVRIMTJ3K0lCQll0TG4rZzlCM1JtSXpZREQ3?=
 =?utf-8?B?MWpUeFZ5N3pUNVdPVkJNRlZmSWRFM3B0dDF5eEgzSkNzS3htNkxmb1ByTzZw?=
 =?utf-8?Q?hHsEhnIe2tiWq?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4290.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eEFRYlVaUDZtUGpLUjZPVS9nVWd2UmsxRlc0Wk81a05TeVoyZUZvbkN6NHdD?=
 =?utf-8?B?RlBrY0ZEWnZrd1dCQThxaytKZjB5alhXSFZ4aS9JMUJFUVFZc0ZQdkx3eUI3?=
 =?utf-8?B?V1dCWEcvNHBab3FsRFJTVWpSUW5pc09XOC9GTlY0NEYvVWxsaEZVNDhlZ3Y0?=
 =?utf-8?B?VlhnSU5TOWRmVjVwUWlLVzIvL2VHV25Xa25XaXRZejcycjI4dmwwTkRISE44?=
 =?utf-8?B?N2NoMDNZcFlhQU42SDlwMDRxaGtRTXc3aEVNWHhLU2JsWm9CcUVxTkZ6Z3pE?=
 =?utf-8?B?c0pUZDB5SFlKTFJySHc4T053SmtObm9PcFJOb09jYk1Pek5xUkViMUJaOTRs?=
 =?utf-8?B?cWJyMFFoQmduWkpOR3pyREthaGNjSDNXa3BHVThQbWF0VHIyNkswYWFIM3VB?=
 =?utf-8?B?OUZzOUpBVjVyZlVKNXE0YVhRQy9WYkhxV0VPa1J0OTdSSVFWcDZJVnZOcEll?=
 =?utf-8?B?L3JENVZwNmI4dm5mSUprYU1seEdmSHN0UTlMSGFRWXBOK2VMRCtZVS84TU5Y?=
 =?utf-8?B?eE91YjlZZnI2VU1YUERxZE5BQ0pkZTdMZ2tjMzRKM2x6THZEKzNENzRlQmkz?=
 =?utf-8?B?Y3dwd1R5SFlnSkhrL29OTUk2RndqRERPcVBPVzZLa3djN1NDVmQwcWZ3OEE1?=
 =?utf-8?B?VG9udnpkZ0JoTFYrcnV5ZFJlRzVVcEQvRFJ4MXN5T1N5YkJnMDZpdUMrNG5Z?=
 =?utf-8?B?ZmM1S2hqaHBFazhIdWQ5VlZqMjZQb20rWVJEbUlPSlRCVmt5Q0FJaFpkZmhV?=
 =?utf-8?B?M000YnpQbTg0UitSNjYycFpTa1I2YXJ2R0grdWZuc1laVEp3N0U5ZjNkanlr?=
 =?utf-8?B?SU5vNDM0VlIvOWpLSjlVUXFYdzNTVW5MbEZFcVpjTXVGUlo5RGw5N0NlOWNp?=
 =?utf-8?B?MlNJTFM5MDhUelRib2VXb3FtK1hoUFNEVDZmQkp0eGRlZ3JaU213WGlCZ1pE?=
 =?utf-8?B?eEtBRUR6TVhENzIxRjZyOGgrUEp5aFlUNVEwUW9VMXJLUXdRY1dhZnN2T2g1?=
 =?utf-8?B?UlJuN3ZRWVF5dmlXdlJNbzlOektGcFpIYWY1SHNVTzIwS2haazR3cm95U2kv?=
 =?utf-8?B?d2ErVno4cFNGSC9ydEFjTTVlbk42d3pKVVlWOUdCdDJwN0JDNlRqTkswREcx?=
 =?utf-8?B?KzFXSHBLc3FhUGMyd1Y3S3A1Mkl0aWFHeDB6eHBLTGtMM1pWY2Q5MU5sNUlY?=
 =?utf-8?B?M1RwYWw2ZG5GVnIyVm9NYXhCd3dKckVlMnBKek5xZ09IWHdQZ1NwZFJCZEdO?=
 =?utf-8?B?VGpVVVdaNW9meWUvY214MCszTjQveUdaRkpaL1dZM1hQaXl5L1M5bUM5M3FM?=
 =?utf-8?B?ZGxLZUgvQ0drVE1nUkhraDdHRHFGMjZLbGpBNU4zdldLblpkZG5scGdWcmpN?=
 =?utf-8?B?TXU4YW1KOTIxMTV4bTEza0NtMWk4ak8ra3lJSjNMT29lYStBVy9abDFuVklr?=
 =?utf-8?B?c2pOcGZ4WVhBMVpUUVFWVmZEVTFuSWNGWXB6S2pFWVZyNmNLQWg5N1VPZG1Y?=
 =?utf-8?B?aVplUU83d0lLZ29kTCtaT3V5b1I5OFdiV2hZMnhORjdETlB0ZXpIL0pBVjhR?=
 =?utf-8?B?WCtwZTBIc1lGVklUMFZnWnRjTFMvbHdsczIrL1AzUTJGaUwya2Z5ck92TmY1?=
 =?utf-8?B?aGtOZHBCRE9xN0dhVStRa1R4eHNlUG13UEh1VnR6RllMdzgxM0hTMGxFWXhJ?=
 =?utf-8?B?YWZNMS8rTWtyL3JyK2hJWUxLM21IbFBCS2RLWStrVVBnV3lYV0dCbWdScHRz?=
 =?utf-8?B?b2lPVmtvQU1pek5DSCs0SUJ4My9wSExOUWF3dVNMR1JsQ2F3TFYwaDZFdU9w?=
 =?utf-8?B?L1QwMmlkOHZrb2FCcHU1ZGp5cDdrMmIvczlTcTFLcStHZmpXVGxpQ1ZISDc4?=
 =?utf-8?B?ZXMra1dtVHhNYTd3TFNNVFk2RUx4bWllNE9qb0VCR3JIWlBpRFcrTVRaSWth?=
 =?utf-8?B?TzVBRmphK0dPNHJ1VE1LaVI2TGpjZlJHbVBvTE91ODl2bTNFdUJIUTRjaWNr?=
 =?utf-8?B?U3NqVWNZb3gxZW15cG42R2dNT3djZG1Wc3dQbm05Rmkyc3F2MzN1aUlHUEN4?=
 =?utf-8?B?UzU2NWtyS2h0SWJiN2VURTF3OStMTUM4d0p5alVZamxtR1FYZWJncFJFMEZZ?=
 =?utf-8?B?RGFRQzB3N0JyQjVIR0tMU0F4Z3ZzLzlLbG92MTl3eVliOEY3M2dOSVUxZmxv?=
 =?utf-8?B?WUQ1d2w0N1NqNHlDVkw4UUFCeXdTVENvRXY0WG4rYU15MlducFdrRlpvYXAx?=
 =?utf-8?B?Y29LRVRtNHlTUW9HUTUrWERiQ1RBPT0=?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ZHtXZJQjUSsm42C5N2fd/Q4t3vYjUjyNCXpoNIXcT+gPDOwLAQhdbYqvbFZQT3apG73RJKZYNhO1lZ3+fxyKvfZocu3VbPzhy5j1Aysr1YjnGQllayRT6PEIm+SLh7/iDVnNfkZQpYrQCSY8q/gpimlkDGgR2z0g3VsZP4GrhOGgaHK1bBBg6Mix+eiMNTFCdaq0aaOxvnIPnOY6DhiiOIL81WE64euKRMyij59dxKQFs4kUSi33s/+htfTpasxU0IAyKQVNpi1d7f0SruJEps6zItnu81pqXxD1djpcxucqDR4IDkxJAabgDkaNKL7K2XwSC+iNBuz0hcRGNjMWpgNhiv9j/d49kSAaGyW+1klUqIkSD0pcS1nMfzd1rU45gfsSMd8YLpHasIVuZW9tO6363f+jU7TwuE9hm746YHiRKLRFrOskwe4hPmY1ORBKdxIWLoIq300ia27T6bR3aKmDLYms6CxAxbgfOuuacUi25z0caTEJ4MJzFTenbRUmmo8U3DWYQTBPB6QbOrXff9PowWXMREQY1BWFr4x7jrg/JtFquRDllgWe8Gbc4v1eyetc7FRGmiWoEtX9Cvr7yUMK11eTlgW4WdCmxA+hfGY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5a35d20-9ef3-426c-b711-08dd30ef5d5b
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4290.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2025 20:51:18.1184
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HNgzBwkLJBXXpUuiyI4Yuvtnh2rFAGj0yBhu8N6BGJAGukxW1Pk5wQWOc7IP1lbYVJ7z43X3+pmyx2zkplEiGO+TC4adSnlrofSoGnK8b6c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB5842
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-09_09,2025-01-09_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 adultscore=0
 mlxscore=0 phishscore=0 suspectscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501090164
X-Proofpoint-ORIG-GUID: IuiIJ8asY3sbPSFvkIXc2HdhXFQXl5-9
X-Proofpoint-GUID: IuiIJ8asY3sbPSFvkIXc2HdhXFQXl5-9

Hi Ben,

On 1/9/25 9:33 AM, Benjamin Coddington wrote:
> On 8 Jan 2025, at 16:36, Anna Schumaker wrote:
> 
>> From: Anna Schumaker <anna.schumaker@oracle.com>
>>
>> The Linux NFS server added support for returning this information during
>> an EXCHANGE_ID in Linux v6.13. This is something and admin might want to
>> query, so let's add it to sysfs.
> 
> I agree that admins will want to know (and they might not yet know they want
> to know), good idea!
> 
> A couple comments..
> 
>> Signed-off-by: Anna Schumaker <anna.schumaker@oracle.com>
>> ---
>>  fs/nfs/sysfs.c | 79 ++++++++++++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 79 insertions(+)
>>
>> diff --git a/fs/nfs/sysfs.c b/fs/nfs/sysfs.c
>> index 7b59a40d40c0..6b82c92c45bf 100644
>> --- a/fs/nfs/sysfs.c
>> +++ b/fs/nfs/sysfs.c
>> @@ -272,6 +272,32 @@ shutdown_store(struct kobject *kobj, struct kobj_attribute *attr,
>>
>>  static struct kobj_attribute nfs_sysfs_attr_shutdown = __ATTR_RW(shutdown);
>>
>> +#if IS_ENABLED(CONFIG_NFS_V4_1)
>> +static ssize_t
>> +implid_domain_show(struct kobject *kobj, struct kobj_attribute *attr,
>> +				char *buf)
>> +{
>> +	struct nfs_server *server = container_of(kobj, struct nfs_server, kobj);
>> +	struct nfs41_impl_id *impl_id = server->nfs_client->cl_implid;
>> +	return sysfs_emit(buf, "%s\n", impl_id->domain);
>> +}
>> +
>> +static struct kobj_attribute nfs_sysfs_attr_implid_domain = __ATTR_RO(implid_domain);
>> +
>> +
>> +static ssize_t
>> +implid_name_show(struct kobject *kobj, struct kobj_attribute *attr,
>> +				char *buf)
>> +{
>> +	struct nfs_server *server = container_of(kobj, struct nfs_server, kobj);
>> +	struct nfs41_impl_id *impl_id = server->nfs_client->cl_implid;
>> +	return sysfs_emit(buf, "%s\n", impl_id->name);
>> +}
>> +
>> +static struct kobj_attribute nfs_sysfs_attr_implid_name = __ATTR_RO(implid_name);
>> +
>> +#endif /* IS_ENABLED(CONFIG_NFS_V4_1) */
>> +
>>  #define RPC_CLIENT_NAME_SIZE 64
>>
>>  void nfs_sysfs_link_rpc_client(struct nfs_server *server,
>> @@ -309,6 +335,33 @@ static struct kobj_type nfs_sb_ktype = {
>>  	.child_ns_type = nfs_netns_object_child_ns_type,
>>  };
>>
>> +#if IS_ENABLED(CONFIG_NFS_V4_1)
>> +static void nfs_sysfs_add_nfsv41_server(struct nfs_server *server)
>> +{
>> +	struct nfs_client *clp = server->nfs_client;
>> +	int ret;
>> +
>> +	if (clp->cl_implid && strlen(clp->cl_implid->domain) > 0) {
> 
> Can we create the files and leave them empty if the strings are not set?
> Having an empty file might be a nice prompt for an implementation to start
> sending values.  I also have a slight preference for a less dynamic sysfs.

Sure! I've made that change in my branch.

> 
>> +		ret = sysfs_create_file_ns(&server->kobj, &nfs_sysfs_attr_implid_domain.attr,
>> +					   nfs_netns_server_namespace(&server->kobj));
>> +		if (ret < 0)
>> +			pr_warn("NFS: sysfs_create_file_ns for server-%d failed (%d)\n",
>> +				server->s_sysfs_id, ret);
>> +
>> +		ret = sysfs_create_file_ns(&server->kobj, &nfs_sysfs_attr_implid_name.attr,
>> +					   nfs_netns_server_namespace(&server->kobj));
>> +		if (ret < 0)
>> +			pr_warn("NFS: sysfs_create_file_ns for server-%d failed (%d)\n",
>> +				server->s_sysfs_id, ret);
>> +
>> +	}
>> +}
>> +#else /* CONFIG_NFS_V4_1 */
>> +static inline void nfs_sysfs_add_nfsv41_server(struct nfs_server *server)
>> +{
>> +}
>> +#endif /* CONFIG_NFS_V4_1 */
>> +
>>  void nfs_sysfs_add_server(struct nfs_server *server)
>>  {
>>  	int ret;
>> @@ -325,6 +378,32 @@ void nfs_sysfs_add_server(struct nfs_server *server)
>>  	if (ret < 0)
>>  		pr_warn("NFS: sysfs_create_file_ns for server-%d failed (%d)\n",
>>  			server->s_sysfs_id, ret);
>> +
>> +	nfs_sysfs_add_nfsv41_server(server);
> 
> I think you didn't mean to send the hunk below.  :)

Hah! No, I did not. I've removed it for v2.

Thanks for looking at this!

Anna

> 
> Ben
> 
>> +
>> +/*	if (server->nfs_client->cl_serverowner) {
>> +		ret = sysfs_create_file_ns(&server->kobj, &nfs_sysfs_attr_serverowner.attr,
>> +					nfs_netns_server_namespace(&server->kobj));
>> +		if (ret < 0)
>> +			pr_warn("NFS: sysfs_create_file_ns for server-%d failed (%d)\n",
>> +				server->s_sysfs_id, ret);
>> +	}
>> +
>> +	if (server->nfs_client->cl_serverscope) {
>> +		ret = sysfs_create_file_ns(&server->kobj, &nfs_sysfs_attr_serverscope.attr,
>> +					nfs_netns_server_namespace(&server->kobj));
>> +		if (ret < 0)
>> +			pr_warn("NFS: sysfs_create_file_ns for server-%d failed (%d)\n",
>> +				server->s_sysfs_id, ret);
>> +	}
>> +
>> +	if (server->nfs_client->cl_implid) {
>> +		ret = sysfs_create_file_ns(&server->kobj, &nfs_sysfs_attr_implid.attr,
>> +					nfs_netns_server_namespace(&server->kobj));
>> +		if (ret < 0)
>> +			pr_warn("NFS: sysfs_create_file_ns for server-%d failed (%d)\n",
>> +				server->s_sysfs_id, ret);
>> +	}*/
>>  }
>>  EXPORT_SYMBOL_GPL(nfs_sysfs_add_server);
>>
>> -- 
>> 2.47.1
> 


