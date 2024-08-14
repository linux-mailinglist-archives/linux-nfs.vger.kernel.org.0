Return-Path: <linux-nfs+bounces-5356-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 717AD951A95
	for <lists+linux-nfs@lfdr.de>; Wed, 14 Aug 2024 14:10:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27D14284630
	for <lists+linux-nfs@lfdr.de>; Wed, 14 Aug 2024 12:10:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68EEE1AE875;
	Wed, 14 Aug 2024 12:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mFwr+mbE";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="SMNXu6KG"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 649EB1AD40B;
	Wed, 14 Aug 2024 12:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723637454; cv=fail; b=N30GT297kvbfIj25fv994E/v1DKlXYSkPimilhHEUQV+uvth+BWWHd900obA2qCuwJjtItN08cPLZOxuCCG713JUaBHvx9dOm7HaOuAWjDtw3ZCjYrga1fFa0kqCfMyZNGe4QQUW+FgqrVhHJ+5E+wIv7axeJUl0CT7ao8Ss+/Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723637454; c=relaxed/simple;
	bh=N9TVVNygPgetZlQbG6pXhdt+O6oBl+6Jk0drD88gZQo=;
	h=Message-ID:Date:Cc:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BltWVjO2jj5M9YUSMFGJ9yCvvbkirYb/6IEMkK6PfPCqE3OM/DY4jk32wrvGz7131vHplPFKRm0/MEfDnTS+6sSIiM+jFrK++fs4guFYUi5/zgy55z+oc2LZyccV599ac+VRfLX2Xbjkmnl1Wy0Q7cn6lwTJp4AwDu+ineXyzPE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=mFwr+mbE; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=SMNXu6KG; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47EBtZg9003670;
	Wed, 14 Aug 2024 12:10:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:cc:subject:to:references:from:in-reply-to
	:content-type:mime-version; s=corp-2023-11-20; bh=N9TVVNygPgetZl
	QbG6pXhdt+O6oBl+6Jk0drD88gZQo=; b=mFwr+mbEUqsoGfGYysW3lOQ1Wi9kYj
	slzPyOhCAx51P0MBv7kzPpPMY/lNYPi4ps+UH4Tsjcwab/8DNy1qd6/raUkTRyVi
	zV0ktDTngUrqPiHrblYoGJ9bY8YtvODLTbzCrtH0NaZRAbh+jr6FDuyu2vIzr2Lk
	cFlvq64YJy/26khsIBV7M2JCrimJFJenBSeEjJjQqpRr+bFmNIH+JBaqSkhgE2Ve
	9VFoTJVblWzkntoxIfhMqWKklYpa8bIJ01k7GiekgZA8c/wHvBvrRqkfI7u34cWM
	PfYvZsoRJaCaS5OQejr4T9sDsCNStPpp0cQuGQFFJymoKLNqm8a87U+w==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40wxmd024s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 14 Aug 2024 12:10:41 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 47EB3n55003655;
	Wed, 14 Aug 2024 12:10:41 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2047.outbound.protection.outlook.com [104.47.51.47])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 40wxnau9ty-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 14 Aug 2024 12:10:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LHOlDAF5YOxb8eAfPbWGIAPBQC0ttuW0V1R7bY9bG6nQsP4mCYyFSG1T0zEKJa7mjushlbVY72Nb4w57WEIUyekXXDBTBL7Feewuzez08nNFT/4A8JD4T0VHOT5Ue+HkUgK1zealWJtGHlq6FIbZXtqHbR8wpFn6bLFpdG/e0wMXk9m+Jj7kaMDhjG/K31nGv8E1NW7/MpkFopcGgJvxZWg5jkSKb9l+B8Q1jTC914foMzUlmrSvRRkgssu08CMO+RnhcEwRoBAuh03zlyJAJpq3atgRKCaPHwxGc9ZXzenZP1ai0gZacvZfMWYZ2LiIkGt+IqkFJ81TJk5tpDQHSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N9TVVNygPgetZlQbG6pXhdt+O6oBl+6Jk0drD88gZQo=;
 b=D5Xr+g2cDM6T5bp8WcP7Oqu33UKNVOVPBt0zR0Wa6NlweLD9BmVhqj+fZcrx5zHjVUPGJidj9VTd/9HRYDttTfXgi3fWLwKaDHZfN68bJYXN6JoL2kqfAp4uQ01Tb+TzLqIS5/1FmfgTPRSTqUwoV1X/Bwe+3x27ewV+bggA0U98d/B6jUTtErD7IHgOCnRv188KTfrJuqy0HyBsTJ2oCOE5NHiQ89m59RVJObpKKOJo4n1KEiPnX2r1p5aRMTt/5/rs231TO75pwMONMNFarD16Jfg3XENbLVbnm+Sgg2l2ECTRuCELHKGAkW94eXlUiKrCPx+v4vcMbRjLeIOk2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N9TVVNygPgetZlQbG6pXhdt+O6oBl+6Jk0drD88gZQo=;
 b=SMNXu6KGcxc1d+7AQi6pS5FnSpL3L7g5sK7635iLquCW8l0nvKRrog8HCs4BEE4xLy8Xcqd+jjJMIyesmoM4V7YJZ6JxT5cgQR2nQEJzkqX+HicHjivhFsVgzqJRvFEjuXCeGzq1L0XD2X2ibjZ1Mm/ZojIRbI3n5cKsP3ei9fY=
Received: from BN0PR10MB5143.namprd10.prod.outlook.com (2603:10b6:408:12c::7)
 by CH4PR10MB8099.namprd10.prod.outlook.com (2603:10b6:610:242::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.17; Wed, 14 Aug
 2024 12:10:39 +0000
Received: from BN0PR10MB5143.namprd10.prod.outlook.com
 ([fe80::783:503f:ea07:74c7]) by BN0PR10MB5143.namprd10.prod.outlook.com
 ([fe80::783:503f:ea07:74c7%4]) with mapi id 15.20.7875.016; Wed, 14 Aug 2024
 12:10:39 +0000
Message-ID: <28b1bf63-e4bb-471a-8ced-bc7aecce8d17@oracle.com>
Date: Wed, 14 Aug 2024 13:10:35 +0100
User-Agent: Thunderbird Daily
Cc: Calum Mackay <calum.mackay@oracle.com>, stable@vger.kernel.org,
        linux-nfs@vger.kernel.org, sherry.yang@oracle.com, kernel-team@fb.com,
        Chuck Lever <chuck.lever@oracle.com>, Cyril Hrubis <chrubis@suse.cz>,
        ltp@lists.linux.it
Subject: Re: [PATCH 6.6.y 00/12] Backport "make svc_stat per-net instead of
 global"
To: Petr Vorel <pvorel@suse.cz>, cel@kernel.org
References: <20240812223604.32592-1-cel@kernel.org>
 <20240814074559.GA209695@pevik>
Content-Language: en-GB
From: Calum Mackay <calum.mackay@oracle.com>
Autocrypt: addr=calum.mackay@oracle.com; keydata=
 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
 smRifw1wGg==
Organization: Oracle
In-Reply-To: <20240814074559.GA209695@pevik>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------Kd7WCCmSFnZdVOe44peBqjnc"
X-ClientProxiedBy: LO4P265CA0027.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ae::17) To BN0PR10MB5143.namprd10.prod.outlook.com
 (2603:10b6:408:12c::7)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5143:EE_|CH4PR10MB8099:EE_
X-MS-Office365-Filtering-Correlation-Id: 2fb0785d-b345-4019-359a-08dcbc5a1c57
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MVlRL0lhUUFPemlSTzJVREliZW9yRWNua1FOczdMRUV4WWRPNXh4a1hURGtl?=
 =?utf-8?B?b05sbXpUZmE1T2FWYzdQRW1udXRHSFdBTmVHQjdGcEdsenhUcEFmaDJ6YnRR?=
 =?utf-8?B?TG9jZjVPN2NOSUtBQUNabEFlV3RLa3U5UnNJeVBmMDBIeFFJK3RmUWdvc2lp?=
 =?utf-8?B?aVo4a0YwWmNKUEVvQ0RYSlBFMEpVWEdWQzJ6RUZsWUFBRGZJTXQzYVNTZVJk?=
 =?utf-8?B?d0tDY3NTeCtrYjZKRjB6c0tCalZrbHhmeHd1QlV0ZGIrR211MkJtLy9SSnFN?=
 =?utf-8?B?NEh4VXNrdGE5Y0VmbUNTOGpBdmRBS0V0NUFTTGxqMlB4VmJzdGxLMERaT2pJ?=
 =?utf-8?B?bVF3NU9jU1dZeERsTmg5K0lPUm42eC9JTUUxQmNZZUxRR09oWlkxbkFRdVRQ?=
 =?utf-8?B?RDVnQ0dYL3M4MjVrR0ptb3JGZGNHdGk2MWh2MGZmSWdPR05xRzNzaGxibHM0?=
 =?utf-8?B?dDB5dFBrTlQreHJjQkZ4REM1SmgwVGJLcDZyU0ZaTXRGR2FTZ3pkYU5MOFh1?=
 =?utf-8?B?YjRUcEtVdkhtdDA1UTBCZXVOL3c0blNoWWRRemJPV1Zkemh2NzVHNGZQYzdz?=
 =?utf-8?B?anhtUElCZ0xQc1NIS1FOK1RSMGNmUDFWMUdHbE52OHpsL3JwdEdUME9DaE1q?=
 =?utf-8?B?T3dnc1ZweWN2ZSs1bFpzQ2tZdWZ6ZWRtcjRTYjNyMUhxbjkyRUtvM3dxRzB3?=
 =?utf-8?B?bHNVN0QvbDlWQjk2NXdqNFBvWVNvWnZEQy9TcWVPSzViWVlJRWZ2OUNyb0Z0?=
 =?utf-8?B?MXZoT2ZUWTJXV21DQWZaWWZaRGdIcmNEMkpkZndRcjNGZjBtWks1Zi9xbDk0?=
 =?utf-8?B?Y0ZYWW03VjVmaDVZOHJBRUpKTzVDWlVGQjRkSDl5N0V1MEowY09sUzhJZllP?=
 =?utf-8?B?b1dPbjlDNWxUTVYxNjRCRW9BK3FpZCtDbmZ4NjlaVHliN1M2ZzJhRGN3bGZK?=
 =?utf-8?B?Rm00WHd2NlJCKzk3N2dDRzhHWWJsaXB1eXJhaWcxN1c3NWFaRmdrTEQ5dWIv?=
 =?utf-8?B?Q1RiV0hzLzhhalZadVBmSWhlcnFXcVZENHd5QUZvbDliRzZoU09kZXNvVUZG?=
 =?utf-8?B?M1lDTFBBRGV5dUhBUVRkdW5yVWVPQndMVStkUTZYeTMxZ0hOQXB5ejJCcDVZ?=
 =?utf-8?B?VzVQS3o1ZHZ4dkdRV09yOUUzeXJXaXpjVldiV2RiUG01N3laeFdObDVUK3l3?=
 =?utf-8?B?cHloWUlidlY2SWdXbEZ0V2dCcURjSTBVdGpVOXhzTzhWclJ2bFJZV3FxZVZZ?=
 =?utf-8?B?cTd3ekVFMzJZOUNCQjk0djByaG9BQXUzR212MHhCOWVCZW9ybmtzOEJOSE1p?=
 =?utf-8?B?Y3lEdTBudTlNYnRhQU9xMldDSEx1VTIyenl0TlEwRW94L1V4ZjVtL3BkRXJ4?=
 =?utf-8?B?UVh0M0Y5UmRoK1lBUnR3czlrRlRtdjRGZE1UbGFzMUpRZEJPK1prQjR2RG14?=
 =?utf-8?B?UnNHTVhjVGd3TFhXTXB0Wk9kWnY1cDFMTytzZWQveFpUWFhOOEJldUt1UGhG?=
 =?utf-8?B?NlZOWERYZExHZkhDeE43MFhON3B1YlAvZkZVamJ2SXU0Vy9sZEVmNnVFQ0V0?=
 =?utf-8?B?TmdIQ0w3Q1c3RHQ3WWozY2M4Y09wUlRjdWlEbE4xT1owZ2tzeGNuTGZ4RVQw?=
 =?utf-8?B?ZUlmTlNvaUwzUGlaTFNCWXIxQXBOMW9NK3Q1dnU0WHh3S1krZ2l1bjNKakdi?=
 =?utf-8?B?V3FpUkdnbVdzaG1zV0VTVFpTZ3p5WE9hNWs2VndyVEVZK1VDWlB1aVFhZ3Ny?=
 =?utf-8?Q?+5UqWEIWBIdbukMAOo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5143.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M0k3eVVoOTh6dTBBU0RXUDBuK0p5NldLUXFITTlTb0xXMlJGOU1jb0krbVhB?=
 =?utf-8?B?YTZDWThwWHF6eXBxOXE3emJtUy9ERFJXbkk3dy9xalJZUHVGTHp5dUZvK09h?=
 =?utf-8?B?SXoybVFrVWx2K0dUSW9SYTFSS3hiZzloUmcraExZVHA5eW5yTE04WWI2d0hx?=
 =?utf-8?B?ZlNNWE5nOHJGZndEZG5OSkRqTkxVTG5UcVExSnF2aVRhVjQ2NmwyVnNqVXpo?=
 =?utf-8?B?K3JCQVpBbmRnYTdwdUxremduT09jcDJUaUltUURVaXhxMngydmVZS25oVVFD?=
 =?utf-8?B?dVBtWlMyREgyaGpna1lXVkYra01zT2tSZkJzMHBaaUk1eVVrOXQ2cm5neXNa?=
 =?utf-8?B?Q1pqRUwxRUVtby9wT2U4VlByYlBYbGJFdzgyb0hWWk5PdTdnblNNck5Ma2hQ?=
 =?utf-8?B?YlB5MVFPZUVQODBGZXgxUFRjQTBXcFhIYnNOblhmaW9HVm1SQWdsVURWVUpF?=
 =?utf-8?B?cmF2ZEUyUnhNa1ROQkoyV2FWcEpSMFZaVko5ZUs0Vm0vSmxjcElVRUJ1OEZx?=
 =?utf-8?B?bkVLdCtUblQyK2ZwSHl4L2JiczJFUklIK0FuSkwrd2t2SDhHRXVINTIxckVl?=
 =?utf-8?B?Y3ZkdnpOUjc2V0xSUFRyYTZMR2dldU8zbDA4bkYySVZTQ0FoMnlubTF3cmJ4?=
 =?utf-8?B?c0NEM090b3FMR1Z5QmNlQVoxeWxQN0doeFRldGtXRzRIaDZWUUJFM0RjanpY?=
 =?utf-8?B?VFFDVUZEQ1NnRHVvM3N3S295bW1EWXdLeVJWYk9wVHFNTER3NE0xNDJSdFFn?=
 =?utf-8?B?cW5iK0hDc28rNSs1UkRLcXZlNEpnZjZsbHBmSy94QzlCSVRjd0taM3JIbm5B?=
 =?utf-8?B?c3RsSFJUQm9pcW5NTE82QksyU0g0UUdJeFYwZkRJYzM3QXE1akRRUFZkOVpG?=
 =?utf-8?B?ZGcvaU9FaWlGVStqS2FMQTVDYzdUR2loYW5jT0J5NXRVSUJaRVRKR2RLNU9u?=
 =?utf-8?B?bzN4c2hkMW11cWV1ZXdhOTArbmxrVTRESGtvOTdIaWZWc0tQV0lWM1NSWFh2?=
 =?utf-8?B?bjA3TnluazZuVGFjd2d2TGJPeEJxR3pRTVluUmM4L0dQZFJ3MW5TenhOcG1M?=
 =?utf-8?B?SFFJMk9waXFQT0EycytoV2tpVnhKb083Y1RBRDYwaFdRTUFLV21paTBtZzYr?=
 =?utf-8?B?czg1Zm54Rzg2OTJJRmkwRC9HcUorZHB5bllTQmtpQkdRZUh6RjVtS3ZXcjhS?=
 =?utf-8?B?QnRseHN0M3pBS1REVkoxcHIwTTEwR3IveG1lNU1Wb3h3R3pzOTNmNXoxb2RN?=
 =?utf-8?B?S1FUa0NhdDc0Y0ZnVThtY2ZWNVBkVnVFNW1CSDVZWFFRYXowOGRwQVBDMmdi?=
 =?utf-8?B?SHJSYzYxNllZNXY0RnNRdUNPOG1rVjdhT2ZQQzlZT1NLdk8yYW5IL1BPam1Q?=
 =?utf-8?B?YkxOSEMxL2pKV2hjMTEwcjJwSTF2ZzlOcCtmbXVkUVZ6Z1p3M081WmdZbzdM?=
 =?utf-8?B?TGJRRG5EY0x4WUtqM2kvT244L0RyRllZZHJpaGswVmlYNmlZZDBGbHg2M21x?=
 =?utf-8?B?RUw1RW9aYWdEZXpRRGVlQ0NFeENpRW52K3ZFTTJaS2RCMUtveTZLSmIybXhx?=
 =?utf-8?B?UmdhbTExWlNmTGZNUFdEeTEzUjdOOCtFdWhjeFB1UUFRNkNZR3lJMW1KRmJ6?=
 =?utf-8?B?Q051VE1ZYUJOZmVyZERVVVg1UjFqQWxtY0pKQURxU0d1S3N5aXR4VkliVzNM?=
 =?utf-8?B?bWh2RzBWRkE2bGNPdVBxNnJWazBjbVF6UWJ4SlJZWHdhK3d2ZktwNHZxdTlV?=
 =?utf-8?B?aTNGRnNzZ0RyaXZKTVZCQ1pPMG5kc0RKcmV0b29qTmxXL3RKVk1SWEtPdFB0?=
 =?utf-8?B?OWRaOE5uNTAvYUhaRmZqamFrZ3dEOU9vVTJzWGtmaVNpanUvWUdRNXlWTGZ2?=
 =?utf-8?B?cHhoV1N1aEhaLzBpS0tveDl3UnFQVlhLL1laSEUxcDFWZUJKc2U3c0cvbzAz?=
 =?utf-8?B?U3ZqcHZBK01xRE9qN1F5eXIzRjFSYXJKcUJ4N1JEamR4YTgrTXVzL3NrVTZQ?=
 =?utf-8?B?MHdiWjZhZkRqQWgzYXEwYVFvYytCZ3p3L0ozU2NyaDVMbFl2NkJaQ1NsSTJB?=
 =?utf-8?B?U2xMZTROSDNVa1k2cytBRjMvelJlei9rdjA3MEh6NStRTnlrdkx6bVU5VmJ4?=
 =?utf-8?B?TGZ1Q3lRZ3hpTTBlSE9rYy91R2h2eGtRT0czMHVRZDJBMDhwTkE5aU1leVlM?=
 =?utf-8?B?elE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ICU7T3CcXNhdAsI5fNkqAYG+F1NvdcIb89VUA7gFsOvb96GYQdXTioER2OoMPPT8SzqYTj//iKBs6NKHyAjWVuogKLLqIz+Wv131GpgeVg3xhc6LmXIgUIQsqPq6mkKzk80OKEZn7mckUZZ+x9lYV8n2L825nQMjc/9ilRSx5tt03p2ronLcDiEI8ul5kX2grXVhipdB9PfBY7PIG7nDnCzwDHAAk6VbOPI93G6yLfvg87+0Xlw0cyiBxJzuDxZjbM+RjSZiPQPAqw7gfdcimuRSxcNFnJOpOaVKIvf42a/54G/KjMWeXqn03aUciO2Wv/PXaMiSiDFLUZ2GSJ2Kw03/OVr2JWE/B8HEo8KqmrGB3mAMgUaUREeieF3OK7Bt44ZvHik34Kg7dz21l7VV9pwiI8vwioP3dhfTofDNFchwX3j7cYArcAhd7ebJvCRe/05XHZ9ZNuNwSD3JiWpAD471q+pY8KX1ic6wbUPqgUVg2fGQ0upbFR96CjxCgnT2mgdi6SDIte/lOoWw8qhveNgcz2QYHL4sfXUbp0brfbY2q23mPwUnsGjEEfc1GYEFHrI8Sh0VbSzyGwbiRuduCPSLeYcUcW+ON/pb+AeLDpY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fb0785d-b345-4019-359a-08dcbc5a1c57
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5143.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2024 12:10:39.0674
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Bpp2iBf+GbIPLkTlbYzzrHtVpkxfY3+Z51CxYYTDU04U34OWNuPLL2sIg+fUWHnbViXI1q/QAhKLekYJY7gJDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR10MB8099
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-14_08,2024-08-13_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408140085
X-Proofpoint-ORIG-GUID: QFsZbcYMwjEP2hbq7lYYi8dQYMfDJgoS
X-Proofpoint-GUID: QFsZbcYMwjEP2hbq7lYYi8dQYMfDJgoS

--------------Kd7WCCmSFnZdVOe44peBqjnc
Content-Type: multipart/mixed; boundary="------------kDPZuub007xuqGxyBzuvfcJC";
 protected-headers="v1"
From: Calum Mackay <calum.mackay@oracle.com>
To: Petr Vorel <pvorel@suse.cz>, cel@kernel.org
Cc: Calum Mackay <calum.mackay@oracle.com>, stable@vger.kernel.org,
 linux-nfs@vger.kernel.org, sherry.yang@oracle.com, kernel-team@fb.com,
 Chuck Lever <chuck.lever@oracle.com>, Cyril Hrubis <chrubis@suse.cz>,
 ltp@lists.linux.it
Message-ID: <28b1bf63-e4bb-471a-8ced-bc7aecce8d17@oracle.com>
Subject: Re: [PATCH 6.6.y 00/12] Backport "make svc_stat per-net instead of
 global"
References: <20240812223604.32592-1-cel@kernel.org>
 <20240814074559.GA209695@pevik>
In-Reply-To: <20240814074559.GA209695@pevik>

--------------kDPZuub007xuqGxyBzuvfcJC
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGkgUGV0ciwNCg0KW3Jlc2VuZGluZyBmb3IgdGhlIGxpc3RzLCBvd2luZyB0byBibG9ja2Fn
ZSwgc29ycnldDQoNClRoZXJlIGFyZSB0d28gc2V0cyBvZiBjaGFuZ2VzIGhlcmUsIGZvciBO
RlMgY2xpZW50LCBhbmQgTkZTIHNlcnZlci4NCg0KVGhlIE5GUyBjbGllbnQgY2hhbmdlcyBo
YXZlIGFscmVhZHkgYmVlbiBiYWNrcG9ydGVkIGZyb20gdjYuOSBhbGwgdGhlIA0Kd2F5IHRv
IHY1LjQuDQoNCkhlcmUsIENodWNrIGlzIGRpc2N1c3NpbmcgdGhlIE5GUyBzZXJ2ZXIgY2hh
bmdlcyAoYW5kIG90aGVycyksIHdoaWNoIA0Kd2VyZSBub3QgYmFja3BvcnRlZCBmcm9tIHY2
LjkgKGFjdHVhbGx5LCBhIGZldyB3ZXJlLCBidXQgb25seSB0byB2Ni44KS4NCg0KVGhhbmtz
LA0KQ2FsdW0uDQoNCk9uIDE0LzA4LzIwMjQgODo0NSBhbSwgUGV0ciBWb3JlbCB3cm90ZToN
Cj4gSGkgQ2h1Y2ssDQo+IA0KPj4gRm9sbG93aW5nIHVwIG9uOg0KPiANCj4+IGh0dHBzOi8v
bG9yZS5rZXJuZWwub3JnL2xpbnV4LW5mcy9kNGIyMzVkZi00ZWU1LTQ4MjQtOWQ0OC1lM2Iz
YzFmMWY0ZDFAb3JhY2xlLmNvbS8NCj4gDQo+PiBIZXJlIGlzIGEgYmFja3BvcnQgc2VyaWVz
IHRhcmdldGluZyBvcmlnaW4vbGludXgtNi42LnkgdGhhdCBjbG9zZXMNCj4+IHRoZSBpbmZv
cm1hdGlvbiBsZWFrIGRlc2NyaWJlZCBpbiB0aGUgYWJvdmUgdGhyZWFkLiBJdCBwYXNzZXMg
YmFzaWMNCj4+IE5GU0QgcmVncmVzc2lvbiB0ZXN0aW5nLg0KPiANCj4gDQo+IFRoYW5rIHlv
dSBmb3IgaGFuZGxpbmcgdGhpcyEgVGhlIGxpbmsgYWJvdmUgbWVudGlvbnMgdGhhdCBpdCB3
YXMgYWxyZWFkeQ0KPiBiYWNrcG9ydGVkIHRvIDUuNCBhbmQgaW5kZWVkIEkgc2VlIGF0IGxl
YXN0IGQ0NzE1MWI3OWUzMjIgKCJuZnM6IGV4cG9zZQ0KPiAvcHJvYy9uZXQvc3VucnBjL25m
cyBpbiBuZXQgbmFtZXNwYWNlcyIpIGlzIGJhY2twb3J0ZWQgaW4gNS40LCA1LjEwLCA1LjE1
LCA2LjEuDQo+IEFuZCB5b3UncmUgbm93IHByZXBhcmluZyA2LjYuIFRodXMgd2UgY2FuIGV4
cGVjdCB0aGUgYmVoYXZpb3IgY2hhbmdlZCBmcm9tDQo+IDUuNCBrZXJuZWxzLg0KPiANCj4g
SSB3b25kZXIgaWYgd2UgY29uc2lkZXIgdGhpcyBhcyBhIGZpeCwgdGh1cyBleHBlY3QgYW55
IGtlcm5lbCBuZXdlciB0aGFuIDUuNA0KPiBzaG91bGQgYmFja3BvcnQgYWxsIHRoZXNlIDEy
IHBhdGNoZXMuDQo+IA0KPiBPciwgd2hldGhlciB3ZSBzaG91bGQgcmVsYXggYW5kIGp1c3Qg
Y2hlY2sgaWYgdmVyc2lvbiBpcyBoaWdoZXIgdGhhbiB0aGUgb25lDQo+IHdoaWNoIGdvdCBp
dCBpbiBzdGFibGUvTFRTIChlLmcuID49IDUuNC4yNzYgfHwgPj0gNS4xMC4yMTcgLi4uKS4g
VGhlIHF1ZXN0aW9uIGlzDQo+IGFsc28gaWYgZW50ZXJwcmlzZSBkaXN0cm9zIHdpbGwgdGFr
ZSB0aGlzIHBhdGNoc2V0Lg0KPiANCj4gQlRXIFdlIGhhdmUgaW4gTFRQIGZ1bmN0aW9uYWxp
dHkgd2hpY2ggcG9pbnRzIGFzIGEgaGludCB0byBrZXJuZWwgZml4ZXMuIEJ1dA0KPiBpdCdz
IHVzdWFsbHkgYSBzaW5nbGUgY29tbWl0LiBJIG1pZ2h0IG5lZWQgdG8gbGlzdCBhbGwuDQo+
IA0KPiBLaW5kIHJlZ2FyZHMsDQo+IFBldHINCj4gDQo+PiBSZXZpZXcgY29tbWVudHMgd2Vs
Y29tZS4NCj4gDQo+PiBDaHVjayBMZXZlciAoMik6DQo+PiAgICBORlNEOiBSZXdyaXRlIHN5
bm9wc2lzIG9mIG5mc2RfcGVyY3B1X2NvdW50ZXJzX2luaXQoKQ0KPj4gICAgTkZTRDogRml4
IGZyYW1lIHNpemUgd2FybmluZyBpbiBzdmNfZXhwb3J0X3BhcnNlKCkNCj4gDQo+PiBKb3Nl
ZiBCYWNpayAoMTApOg0KPj4gICAgc3VucnBjOiBkb24ndCBjaGFuZ2UgLT5zdl9zdGF0cyBp
ZiBpdCBkb2Vzbid0IGV4aXN0DQo+PiAgICBuZnNkOiBzdG9wIHNldHRpbmcgLT5wZ19zdGF0
cyBmb3IgdW51c2VkIHN0YXRzDQo+PiAgICBzdW5ycGM6IHBhc3MgaW4gdGhlIHN2X3N0YXRz
IHN0cnVjdCB0aHJvdWdoIHN2Y19jcmVhdGVfcG9vbGVkDQo+PiAgICBzdW5ycGM6IHJlbW92
ZSAtPnBnX3N0YXRzIGZyb20gc3ZjX3Byb2dyYW0NCj4+ICAgIHN1bnJwYzogdXNlIHRoZSBz
dHJ1Y3QgbmV0IGFzIHRoZSBzdmMgcHJvYyBwcml2YXRlDQo+PiAgICBuZnNkOiByZW5hbWUg
TkZTRF9ORVRfKiB0byBORlNEX1NUQVRTXyoNCj4+ICAgIG5mc2Q6IGV4cG9zZSAvcHJvYy9u
ZXQvc3VucnBjL25mc2QgaW4gbmV0IG5hbWVzcGFjZXMNCj4+ICAgIG5mc2Q6IG1ha2UgYWxs
IG9mIHRoZSBuZnNkIHN0YXRzIHBlci1uZXR3b3JrIG5hbWVzcGFjZQ0KPj4gICAgbmZzZDog
cmVtb3ZlIG5mc2Rfc3RhdHMsIG1ha2UgdGhfY250IGEgZ2xvYmFsIGNvdW50ZXINCj4+ICAg
IG5mc2Q6IG1ha2Ugc3ZjX3N0YXQgcGVyLW5ldHdvcmsgbmFtZXNwYWNlIGluc3RlYWQgb2Yg
Z2xvYmFsDQo+IA0KPj4gICBmcy9sb2NrZC9zdmMuYyAgICAgICAgICAgICB8ICAzIC0tDQo+
PiAgIGZzL25mcy9jYWxsYmFjay5jICAgICAgICAgIHwgIDMgLS0NCj4+ICAgZnMvbmZzZC9j
YWNoZS5oICAgICAgICAgICAgfCAgMiAtDQo+PiAgIGZzL25mc2QvZXhwb3J0LmMgICAgICAg
ICAgIHwgMzIgKysrKysrKysrKy0tLS0NCj4+ICAgZnMvbmZzZC9leHBvcnQuaCAgICAgICAg
ICAgfCAgNCArLQ0KPj4gICBmcy9uZnNkL25ldG5zLmggICAgICAgICAgICB8IDI1ICsrKysr
KysrKy0tDQo+PiAgIGZzL25mc2QvbmZzNHByb2MuYyAgICAgICAgIHwgIDYgKy0tDQo+PiAg
IGZzL25mc2QvbmZzNHN0YXRlLmMgICAgICAgIHwgIDMgKy0NCj4+ICAgZnMvbmZzZC9uZnNj
YWNoZS5jICAgICAgICAgfCA0MCArKysrLS0tLS0tLS0tLS0tLQ0KPj4gICBmcy9uZnNkL25m
c2N0bC5jICAgICAgICAgICB8IDE2ICsrKy0tLS0NCj4+ICAgZnMvbmZzZC9uZnNkLmggICAg
ICAgICAgICAgfCAgMSArDQo+PiAgIGZzL25mc2QvbmZzZmguYyAgICAgICAgICAgIHwgIDMg
Ky0NCj4+ICAgZnMvbmZzZC9uZnNzdmMuYyAgICAgICAgICAgfCAxNCArKystLS0NCj4+ICAg
ZnMvbmZzZC9zdGF0cy5jICAgICAgICAgICAgfCA1NCArKysrKysrKysrLS0tLS0tLS0tLS0t
LQ0KPj4gICBmcy9uZnNkL3N0YXRzLmggICAgICAgICAgICB8IDg4ICsrKysrKysrKysrKysr
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+PiAgIGZzL25mc2QvdmZzLmMgICAgICAgICAg
ICAgIHwgIDYgKystDQo+PiAgIGluY2x1ZGUvbGludXgvc3VucnBjL3N2Yy5oIHwgIDUgKyst
DQo+PiAgIG5ldC9zdW5ycGMvc3RhdHMuYyAgICAgICAgIHwgIDIgKy0NCj4+ICAgbmV0L3N1
bnJwYy9zdmMuYyAgICAgICAgICAgfCAzOSArKysrKysrKysrKy0tLS0tLQ0KPj4gICAxOSBm
aWxlcyBjaGFuZ2VkLCAxNjMgaW5zZXJ0aW9ucygrKSwgMTgzIGRlbGV0aW9ucygtKQ0KPiAN
Cg0KLS0gDQpDYWx1bSBNYWNrYXkNCkxpbnV4IEtlcm5lbCBFbmdpbmVlcmluZw0KT3JhY2xl
IExpbnV4IGFuZCBWaXJ0dWFsaXNhdGlvbg0KDQo=

--------------kDPZuub007xuqGxyBzuvfcJC--

--------------Kd7WCCmSFnZdVOe44peBqjnc
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEE1GBbrQYgx8o9Vdw+hSPvAG3BU+IFAma8nrsFAwAAAAAACgkQhSPvAG3BU+Ls
xRAAmvnd2mT/mge0KqkjYIfXJmRipx9EjpcY4FHWx1G7n+EFm5yFtxrzplbO6RJDzgIMeksCi6fF
Ibv5fAOiPU2sl+jrPcLuQRfgcKhuHpxwwUpXMqwxyyHc09Lm01FUMTEls+kQTm9hGIcFmycQjNvP
5ex5ynR9nceI+pqEmvTSs2O1Gt/qoSka+YO6EaaANF3ZDWhkLNjoivrUqQA/uZJJOZLmcFt8KgDe
9Cpf1cZhzxRsbjwOUy3lV7LKys/+QFSrRv2UeKBRepVyVn1GX2IssmH4n62I8bUBSxpPsh/vF15q
xQfM9IvY4qlNfdcPwjEkRqd+ffZG0+8bXkAjAFRcQtfWI+N96Bqq5ejLiQPxwAdPwYrhIIW9J8vr
Mtv1CYk8Y7THYt3TdzZPDN+tVZ4C25V8OdqRbaiLMSfhQcXZseByYZXy/ZD1fvIDEcWKPYkjeIj+
NwAPgUxFN/s64GJF1c7KPmePkm3Tp1aPIoMXjaExZptLCdw/08KoRLFlvqlvwd373/j5ejQBlnis
jkn+tj5PcfM/k++hMy9UYl4/S1DBJLFUbcjbsLG/VibV9QUb+YxYehnReLQk3v7pFdDg4QUkdTLM
Y6NMRk9FyyUloq/1Dtw9en2+yEttsNfT+2WCrMKzhq2V9ZS83A2naEEcUDx5cDuQnWD0EczXkRbY
BTk=
=afzd
-----END PGP SIGNATURE-----

--------------Kd7WCCmSFnZdVOe44peBqjnc--

