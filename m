Return-Path: <linux-nfs+bounces-6417-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 01F9F977351
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Sep 2024 23:06:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3FFF28390C
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Sep 2024 21:06:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE9FD1C1743;
	Thu, 12 Sep 2024 21:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="APhZxlep";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="jvdRehzK"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EFA313CFB7;
	Thu, 12 Sep 2024 21:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726175180; cv=fail; b=AGiPWDToVisq0rNcp5jtlF37CkkyXfm+pwCKA9mMw/+qwKUNVSKzaE+d5ayWM3sH4voRRhC1cu7AUhnsFDPx0CGvgwLVNRWh+KPmukn62/dlGfKRBdqIoXWwIFa2eqYv6rCRIADPXV+gEIAVitUhic/ufSgEhtVIZZXvK9pipG8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726175180; c=relaxed/simple;
	bh=rBNlVsZFxv0m0P+OGXOg48bJv0vyGqFe69dUUCInemc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GAugPj5ycI4eDXpAnhywhX20tshQzDcwy+6m2mWx4wUc/03Hy5knBrLFkobbDPo25sFnUWySaf8Rhd/+8N3BDAQUy+Sn/bhx2DJUHT2AaqV5l9hOdU5CPwJwR1/2VZlNrMFz1OODw6yRkBaPtbqaG7hrCJMRxYPBdgTySOwOjxQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=APhZxlep; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=jvdRehzK; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48CJQUuS002822;
	Thu, 12 Sep 2024 21:06:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=P7hFT0TvdynxsJgQuddgGPj3rCsWcwrhWMRc2bV0AGY=; b=
	APhZxlepazPBQD1yJ87Mi8Py//zJIm5Nihdav6mVUlC/BqYqbzKl0vXN/Kkun2GN
	VPApJLX/Gnw0r0FAg3S7Zm39ta/PWhlMcajz5MUHzh4J0UMkrH/EQc2W2nizKs7F
	1+WGDA51dMHnMot16prbQ+2BDKx3a17k8dRGIi3u2cGoGo7T5Tfqw8/WFWy5jcol
	436g1wWwJJYILjwKNRzJfXOCutKUQtw7TNkGB1FirF9OeKLkKDu4Lye723+1w7gg
	hmNiBqZMBJ5JHH2l99hgEc/Bm6x5wYNPjSWf3nc+lUgFJqrOO0JWQhMHIvBXInhI
	9jC4WIefb+hwQtbD5Qlq2w==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41gdm2v0sf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 12 Sep 2024 21:06:13 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 48CJ3aAD006215;
	Thu, 12 Sep 2024 21:06:12 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2175.outbound.protection.outlook.com [104.47.56.175])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 41gd9bv8s6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 12 Sep 2024 21:06:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=in9oTl6XNkD9AEP8e3TuMAn/FB6rYm+yD/hpCoyEqi013QIha/HNBQQHF4EuTXNK+0poiMIsD4xdkC08Oj+/nAAbiyrfSmI9Iz5pF41lPc2xc9g/fW670VVKjpKFLOWlrN/07D2vY0kFq01bgaJbp+sW3F1jyfYvGEQUk9Pbm/MgWVk/7L9xsN97hIVzzA3jxa6AQYkpFIwdgxykKglaNdvns05X7sGbV+NHcNKfi/1mOmmwWVpizLrERvoJKt/sXlQwvdJ1ub7rHTp45ImWjMtDqqx+nyaNiMpv29IUIYOof1sLL9egyEcB44VuDp0sLIFUjx31sjjqH04YJXjHxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P7hFT0TvdynxsJgQuddgGPj3rCsWcwrhWMRc2bV0AGY=;
 b=TvSrZwn8nTtTYzhDc7kFL37bTq6KEB6aTJSo8Hwp2IbmD3hJwHKU7KnmMBWnd6Y6p1azbJF8lwe1ywgs1bgCzQbNs6VqQVqJBSGNzuz+rJX1lb1y4qTTJjA3LcIUsO6P6G2zklIw9ub0tCUIeUkaugtWAbUJHT6SDviBlYpHp3cNPy+kapZAUGmrO6WrYFW5N8Vkm4lORr/3viinTFl77eg7qbzeVW1nbxl0lK7viv/L57AmgNYk0/UiAG3DXDZ/1+J9Dv3jlw1WwMD70shDoJSfWGfKKVi9U/5tDWKY2F3LqlPH4BYKAVuEP1mZkA/gpiv4MT4b5V47Y1b5IU0gvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P7hFT0TvdynxsJgQuddgGPj3rCsWcwrhWMRc2bV0AGY=;
 b=jvdRehzKIhgfxRl7MCzN9pgzD0S5yk79VULxqkuy8n0hwk83JUKrQ/og6+35HPWD8lbHuPf4uMt2hl+ZwJbOHPEOF0jjb3UU0sQMdxLasX+Z8ujIASU92pWvsJ86m2UykNQ4tOnPm29OAg5Z0HVpq8gphtzE/RhwKi32ox/6IhQ=
Received: from BL0PR10MB2947.namprd10.prod.outlook.com (2603:10b6:208:30::27)
 by SJ0PR10MB5786.namprd10.prod.outlook.com (2603:10b6:a03:3d7::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.8; Thu, 12 Sep
 2024 21:06:09 +0000
Received: from BL0PR10MB2947.namprd10.prod.outlook.com
 ([fe80::8ad0:1f2a:6f02:635d]) by BL0PR10MB2947.namprd10.prod.outlook.com
 ([fe80::8ad0:1f2a:6f02:635d%3]) with mapi id 15.20.7962.008; Thu, 12 Sep 2024
 21:06:09 +0000
Message-ID: <eb6a1739-6086-4ebd-a5dc-03bedc3a12a6@oracle.com>
Date: Thu, 12 Sep 2024 17:06:07 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] nfs: Fix mounting NFS3 AUTH_NULL exports
To: =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>,
        Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240912130220.17032-1-pali@kernel.org>
Content-Language: en-US
From: Anna Schumaker <anna.schumaker@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20240912130220.17032-1-pali@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR03CA0207.namprd03.prod.outlook.com
 (2603:10b6:610:e4::32) To BL0PR10MB2947.namprd10.prod.outlook.com
 (2603:10b6:208:30::27)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR10MB2947:EE_|SJ0PR10MB5786:EE_
X-MS-Office365-Filtering-Correlation-Id: c7f2ca94-4179-4a97-b854-08dcd36eb99e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TnN2UHRsTHpSUFhZaDJjRnhZN0FEcDNkaFhlV2RDTGZPNjgybmRwbE5IOVo1?=
 =?utf-8?B?Z1lHOGg5MXYzSnRHbFErOE44aHozNUsvRkNoNEdzWFRVdGhtMWR3ZE1xYm5V?=
 =?utf-8?B?Nno1am5udCtzMjRudUZ1R1l0OG5ReEUzRlBPZ2lRcXEvK2FHV0NGVXI1ZXEw?=
 =?utf-8?B?dW04OGlVL3dWTEtXcEZDZXpwdmJ0MWY5cGFWTGJYTU9CUDdyT1M4alV4dzhx?=
 =?utf-8?B?ekozQ3RjVFM0U0JkSmlycFdkNDJUbnVnSjdhem0wUlFHejA3eFB2L25RMHJn?=
 =?utf-8?B?T3ZXa1QxYTJmOHZ2R1ZrWGZvR0xUVXBFalBYL3c5N0lMdEpYKzcxZzlGZysr?=
 =?utf-8?B?NS9Ja2pOK1ZUSEROblE3SFErU09tY3VRWnZIcXpweWpSeE9yRHQ3ZFMrRE5v?=
 =?utf-8?B?a2dnTTcraDVSU3YydUwvL2g2aW5UbnlDQlBLSE5JSGpZRmhUMnUyTFBrSTR3?=
 =?utf-8?B?WE83SmpudVdCZGJUOXhEMzRGY1FCODk3aHprK3FLV1gwcXo0QjQ3UmJ0M2pC?=
 =?utf-8?B?RDc3TFVpbTk3a291RFN2V0srQVRxUUJ4WEo5NDFiWENpQTE1UDAwTnFwODN5?=
 =?utf-8?B?NFE5VDRJU1MrZTU3N1JCdkdxWFpYZVBkK3QwSzB4TUFVREZGQ01vbXhqOVJJ?=
 =?utf-8?B?NkkydFRWM051NXU0bndsZ2VSdFhiUHhiOSt0NUVFUEpxWkRWN1huQjBHTE5D?=
 =?utf-8?B?K1RodVErcFNiZm1TbTlKc1BJaGg5eVptampmajRRV25OdU1CbStYTVoyWHll?=
 =?utf-8?B?WThlWUtGd29mSHN2N3owNTJNUUprK0h4VXBlVlJYM0Fhc1JaQkhqdzFGaUhv?=
 =?utf-8?B?NHhGRXdNTllNQWk1Mjd5a0NkaHR1UlZsL1lHd2c0Z0lXSlllQ1hFT2lkZFdP?=
 =?utf-8?B?NUMvMTU3cnBxN1ltVCtRUGxrejFGVmdONTF3d3pmb0IvRER6UmNKd0huNldY?=
 =?utf-8?B?ekxjbEVQNERLVEdMMVUvQTF2bHBZQzIrcWFQWmdxRGE5MWR1TVRrMThrekNB?=
 =?utf-8?B?QnhKWGtMVFlYbmpuRUtzVGRwajJ2dlBSNHZJQ2czeEYzK2ZrdDF3SDVQT041?=
 =?utf-8?B?YkdtTEtCOWZmbDZPQVltZHZiY1d3ZnlVRkJVRXVadXhETnVKL0JMWHQ5NTdH?=
 =?utf-8?B?TS9CeTRDTGtSaDh3T3BRbFNHa1drRzZET1k0QVdoTUZZU0NySHZIUEhaTk1m?=
 =?utf-8?B?N25GR3VSbGkwUklWWTF3M1h6cWN4cEFHQTZKRlFteXgwUEFiVmdBL1FpYUdN?=
 =?utf-8?B?ZjBXbVJxa3FqVlpDdklSeDRnN2VIRVpRREt2Ym43K1NyT0ZUMC9yMFJVVTZI?=
 =?utf-8?B?QUdKUUc2ejluSXZhcWRLcFBzZHh2ZVlQbkRWRWZKbHo4dlBjZjRoUEpqay9s?=
 =?utf-8?B?WkVzaTVaNWJXRWxMZUhuUi9nbXovVE90dHN3T2EvSE9tUi9uZ0Y2T1ppdVVW?=
 =?utf-8?B?Mkp2enhSQytjMENiTU54MkVFRzJaeFpwcnAxbjgvU1BPaGZuRExOMmh0NHEw?=
 =?utf-8?B?RlNtUzhqTmFIQ1h3c3AvL084WWIwcUo5S2N2eG13NkFMRlNlTVdldDc4Y3VP?=
 =?utf-8?B?WXdta01VT2lxNXBvb1FsU3BUYmdkNHpQUmMrTUdYbXVKMmd2cGd2TFFXM0VF?=
 =?utf-8?B?NTEySkVHd1QyakxYL3R5U3RlOWdsZ0krdHNjdG0ySUt3eHJUWHQ2VW1JZ0pq?=
 =?utf-8?B?azF5QlVwZ0FnMGtyQnZKdFUzTk93dmhTbXZLMjVwWDRTeDlvMkJ0TTl4c21M?=
 =?utf-8?B?RHhlVFR5N0Zya09yV0JGb1N2cG9lNUFLZ1h5eFI4K2IrbDIrR3NIM0FVZTR1?=
 =?utf-8?B?bHBzalBvVDF5S1JneC8rQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR10MB2947.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ODAzOGVDeE5DaFFEWFp1Q242ZnhBbFptenBOWDZ4SGhZVWVRdytpNFlUY3RU?=
 =?utf-8?B?b1RqUHFqL3FDVXRmQkhWOTU0emVHTlNtVFVtL3JyajhYZy9LVEM1NnpUVjVF?=
 =?utf-8?B?TEdPSVRmMHMvUWU2YThnRUN6YWJMSzUxeUplUWI5NDZuR05UY1AwNXhTRnV0?=
 =?utf-8?B?OEZ3cmpkL3RadkVCb1YvTDkrS3UzSWROU1RKUWw2SmpuazBvRVV1T1FmL29Z?=
 =?utf-8?B?WTlRTGd3RU1PSWU5RXJMZDFuWEQxUXJ1bldPM0hpVTJmcnMvV2hEaWQxMXQ1?=
 =?utf-8?B?RUN1UlFVZTVTRnpYc1EvSXdQSUx5VEtueTVzS3BWcWgwdWFpTWY4YU9Zb1Na?=
 =?utf-8?B?Sy9id1NjamRyeEowbEJtSDFRZTJuekI4cldwRktMSmIyN1R5YmNnZGhMTW5M?=
 =?utf-8?B?aUl3L3hDeU56ZHNQSUcvejI5d3VVeGx5SzRqWEMzbTVsME5SRDBhUExjNDRy?=
 =?utf-8?B?T25nbWtlaC9UWGxTMU42Vi9FclNqcEw3cktnbUNVdEs5bDNPUmdCNWRkeTJ6?=
 =?utf-8?B?MThnV3owMlBqQy81ZjRXVlVSK0dWNVUyVStDN2g4bm0zWDZKcTZzSjArWkhs?=
 =?utf-8?B?b2VuUDgwOVF4L0Z0QzlXS2NzZmoxZ1FJUXVveXladmZLdzlyQy9hMmRMSzRY?=
 =?utf-8?B?TXNIa2pDWnRHRWJrWFBIdU96cGZCL0gzT1JYbllIMzZ3R01tL2wyS3A3SlhO?=
 =?utf-8?B?OFVqcnNGVnB4bVdnSXJyM0hEUlF6SEthSUExUGJsTnh3TjFVRVdwOXZlVWlt?=
 =?utf-8?B?TmxEZGM2NmN4eHVCeEMwY2ZBSWRBbGk3bWo0Ri9vYS8vN1J2RUZia28yQTJ0?=
 =?utf-8?B?VFlmQkxsaUc3SDkzNnRWOWFMUXBQelJ5aHlmbUJMSzhLQzNVWHlTQkZ1UW40?=
 =?utf-8?B?SmFBYTI3NE5xL21DRnllZWpSVHE5NzBaZVBaODUzQjM2clpmbTl4eVMrUzBj?=
 =?utf-8?B?T0I2MEpOTXdOYjFheVhnamd1OEFwMTVaZ0tlaktyTUZ4czNRb1RUVVJ2MnRl?=
 =?utf-8?B?N2NUVEVDeDZadXNKMFBralo3NTdUK2t5Y1E4N2F2bXQwbmtHUFN3THpVdHRq?=
 =?utf-8?B?bVp1QkF3UXVoV2d1c0pVY3FqOWp4N3J2RjQ4bDJVV0pUMHlNNU5udG9lK21S?=
 =?utf-8?B?Z3hyQllJbExQaFhtZ2NkSThaSUgvbC80cU8vdXhOaXZXT1ZUSG5PU3ZBVHA3?=
 =?utf-8?B?QkVENEJweHBPVmppOVc5Uk8yVURtQUxyRlFZMnk3NHBYUG95ekxTMElPYWxw?=
 =?utf-8?B?RUNqRVVSOFNqdEdrcTN1ajVjV3NhM0JRWXJ4OEFaYzRHaGloRE5UWFo1UlRJ?=
 =?utf-8?B?dmdGZXpTWTY0b1U4c3NWSnVsTXJ5Q0l4UFVEY0wyMXZIdk9ra2VSVnNGYktD?=
 =?utf-8?B?KzkzS0xkSysrOUFnK2FvbkdZVFZCRkw1WWpSZ3UvNDFSYmg0TU5BS2JvUmxv?=
 =?utf-8?B?UUVoNzJLR3N3RTdrK29FelFuNXBDazhRZG0relFtcGZIZmwxd0duazd0ck9I?=
 =?utf-8?B?SmlBUFVTUXVXUEZpcU92cXE1SkVydnNxeThlVllQbXh3OXMvamtLSk1TRXow?=
 =?utf-8?B?bXczcUMrV3psYzAxUDAyOG5YZElndnI2N0VxdXFINWlKdnJhR0xyemdzeDdS?=
 =?utf-8?B?SnFXWkRnUzN5Z3hOeDVZcU5CMEN6aG5xUHV3T1lHbzF6SVQ2emRTWUhoNTFX?=
 =?utf-8?B?TnNpVVJQUjBWTXhMdFgvSm9yM0M5cFJDekgrVWJQOGsxOW81Q0NXSnErUlFm?=
 =?utf-8?B?bWdYOVc2d1dMbWllZmM2cE9yNGovVjdwOFdFdlZKZXROQkVLbjJoS1FpVTd5?=
 =?utf-8?B?L1A2Z2dvRFVmRUY2QzNEdXdhTEpXbWI5YzZjZEtuR0ZPRFZzODdNMWF5eFpE?=
 =?utf-8?B?eElVTmV2VnNRNVlNUFp5V1pLZG1QWEpGWEx4M0V3SkZjcGFoTlZrdmtlSDVL?=
 =?utf-8?B?clY5Tmhtc1dldC84dGQ0amh0enVtb2tzTnNBendtaUY5TUpRQjdXeWNGcnJZ?=
 =?utf-8?B?bE83ZDJ3M1BuOU5vWHdvcHhHY2ZlZGtXcWd0dVZCLzcrdWN0TElzckxhWkRq?=
 =?utf-8?B?UGMwRW0yaGdUdTl1MEcrTnpaODhLTVlOZFN3dHdUZDFqVzdWazVKVkZFYWda?=
 =?utf-8?B?aCsrZkE1cDhwTVhVaVBnMmtreUM2emhrQVFLWDNxeGdSZkk3VFJuK09NaEpl?=
 =?utf-8?B?MlE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	5x2Z1IRQ8+i+nXTLfQ7mHdfEEnNIhPW5EwSdvCAsCY0ugD21one/hko3qYLlBB6aKMCqo2zay8SzYWR2nlCnXLtegyEl8aTPSOfcqiqHLDwI/4ApYPlxfYdf9/eq1dYhZSUn2rIdIpamz+j6GbyCYzPGS7WkBydHlcawtSWeSvl3yib9TQgYArry6LnSdO197EgbwAhHNkEGtFXk7EswscrHU+vBuGThFyqE+Z3GO0bycyjpcE17YLawvPSn2xb3tUAKmKFJrQEGgHIJS1Auj0dDgPGHCk2Edacbw6j9x57URyzX/OVbK6Vf+Pi73cVx9zHFOo+lMBRaie8ur0hnHwWDoHBKEODT+7auPjCRa/nCQY4N2HF5D/Zqi6F5c9Quhrc8gkT+NXjrGeWrkFjyJ8Vli0i50HXYmHLNpVLve88LOVMNOj89X93GKMb52co91jYu10s6S7Qvce42yOnV3+3bgWseWkVfFtVh/XnyA5gNx6W8GtQNub2QY+D3PifgkpDG5i6xSrHSFGnUg2HMST/IP1d/zYFpwOE53UZ2DK+fiIunrXxwSqOcjvCX7L4ZPJ9cHhjcHVcFUODqRzBMuNY7usT9ce1412vdR3CmBhw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7f2ca94-4179-4a97-b854-08dcd36eb99e
X-MS-Exchange-CrossTenant-AuthSource: BL0PR10MB2947.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2024 21:06:09.5203
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D2lsVsfhaF7DiKCLH7eSFq8ppHIBu9Cq26HYzd6y+XqFMp8BB38YYvkyIo9B2/gtalAR0/M+M6km9GlgEQBCIgJyBvZxz1S4h01zRnJd96I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5786
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-12_08,2024-09-12_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0
 mlxlogscore=999 bulkscore=0 adultscore=0 phishscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2408220000 definitions=main-2409120153
X-Proofpoint-GUID: DyD2ybDnUj7jMZYTUMEL0rwhP5JEB_7q
X-Proofpoint-ORIG-GUID: DyD2ybDnUj7jMZYTUMEL0rwhP5JEB_7q

Hi Pali,

On 9/12/24 9:02 AM, Pali Rohár wrote:
> Linux NFS3 kernel client currently has broken support for NFS3
> AUTH_NULL-only exports and also broken mount option -o sec=none
> (which explicitly specifies that mount should use AUTH_NULL).
> 
> For AUTH_NULL-only server exports, Linux NFS3 kernel client mounts such
> export with AUTH_UNIX authentication which results in unusable mount
> point (any operation on it fails with error because server rejects
> AUTH_UNIX authentication).
> 
> Half of the problem is with MNTv3 servers, as some of them (e.g. Linux
> one) never announce AUTH_NULL authentication for any export. Linux MNTv3
> server does not announce it even when the export has the only AUTH_NULL
> auth method allowed, instead it announce AUTH_UNIX (even when AUTH_UNIX
> is disabled for that export in Linux NFS3 knfsd server). So MNTv3 server
> for AUTH_NONE-only exports instruct Linux NFS3 kernel client to use
> AUTH_UNIX and then NFS3 server refuse access to files with AUTH_UNIX.
> 
> Main problem on the client side is that mount option -o sec=none for
> NFS3 client is not processed and Linux NFS kernel client always skips
> AUTH_NULL (even when server announce it, and also even when user
> specifies -o sec=none on mount command line).
> 
> This patch series address these issues in NFS3 client code.
> 
> Add a workaround for buggy MNTv3 servers which do not announce AUTH_NULL,
> by trying AUTH_NULL authentication as an absolutely last chance when
> everything else fails. And honors user choice of AUTH_NULL if user
> explicitly specified -o sec=none as mount option.

Why fix this on the client instead of fixing the server to announce AUTH_NULL
if this is what the user has configured?

Anna

> 
> AUTH_NULL authentication is useful for read-only exports, including
> public exports. As authentication for these types of exports do not have
> to be required.
> 
> Patch series was tested with AUTH_NULL-only, AUTH_UNIX-only and combined
> AUTH_NULL+AUTH_UNIX exports from Linux knfsd NFS3 server + default Linux
> MNTv3 userspace server. And also tested with exports from modified MNTv3
> server to properly return AUTH_NULL support in response list.
> 
> Patch series is based on the latest upstream tag v6.11-rc7.
> 
> Pali Rohár (5):
>   nfs: Fix support for NFS3 mount with -o sec=none from Linux MNTv3
>     server
>   nfs: Propagate AUTH_NULL/AUTH_UNIX PATHCONF NFS3ERR_ACCESS failures
>   nfs: Try to use AUTH_NULL for NFS3 mount when no -o sec was given
>   nfs: Fix -o sec=none output in /proc/mounts
>   nfs: Remove duplicate debug message 'using auth flavor'
> 
>  fs/nfs/client.c | 14 ++++++++++-
>  fs/nfs/super.c  | 64 +++++++++++++++++++++++++++++++++++++++----------
>  2 files changed, 65 insertions(+), 13 deletions(-)
> 

