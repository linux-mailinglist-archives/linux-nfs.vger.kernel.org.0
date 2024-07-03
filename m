Return-Path: <linux-nfs+bounces-4606-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EF3CD9268A7
	for <lists+linux-nfs@lfdr.de>; Wed,  3 Jul 2024 20:53:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4E97BB25F18
	for <lists+linux-nfs@lfdr.de>; Wed,  3 Jul 2024 18:53:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB20A1891C1;
	Wed,  3 Jul 2024 18:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gbG5bhCT";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="p77aYzy2"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EACDD188CDA
	for <linux-nfs@vger.kernel.org>; Wed,  3 Jul 2024 18:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720032791; cv=fail; b=sgVpdSTM5nz4zLYfH1jPawgrITcNvloWufqrcDEUcg8LbybREoFE3za51VwARLF4QFqk/iYUydzwo0OvAsvbalhixnXTkTdlcMl1ocyTq1bmw+tasmm+jY8e7f8QH6GAcjhno0/Mws26Aoz1r0ByopsLQ5YRAOOdGP+jdIQ7N24=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720032791; c=relaxed/simple;
	bh=1B/niFf44Sggh7E5qR4g8rLXx9n5MTs82H7ERGIYM7Y=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=n/V0oHeZ9g/TeC621KYepPFuZfStbH2J36h4ekOj5v7JJOkVhkLb1V/D208GkQRefcA/V5kyQiayjV5leeiFIvomLJv66wzUCT0+vIAfMGVJuLGXCeeXP5obYf6fUwhr22QTPdYZHEdR3dKi21S3Ex2S71Xo8B6EfyNntAI9nxE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=gbG5bhCT; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=p77aYzy2; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 463IfTcg024568;
	Wed, 3 Jul 2024 18:53:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-id:content-transfer-encoding:mime-version;
	 s=corp-2023-11-20; bh=1B/niFf44Sggh7E5qR4g8rLXx9n5MTs82H7ERGIYM
	7Y=; b=gbG5bhCTVSsmr8ZCKqDa9MatFWQpNZmLIJIKNDIF0NgS0qLfb0iTebORv
	/g0uv4cKGvyawR08RfHIh37Jt1vWzX6PzSMW+lvvziPmirtDZoeQcK2lrKyyMIWH
	8jZyllwY1eMYhYkGaUHY1L9laLHAcqPepR19ADnVl9ioEtIA6kHQqntoggoqwe72
	CbnVE+ST8kRcHoXGLiCmL1HiP0Hrih3mv3bQcFQ9H5WXl8ZSbQmx2SAS7A9rCxyM
	lLoAnIbVCWfIK/GAIHQFGB/b3YyncXmg+uaFBPFRdlkvC41l/JlNVcuZcHxPG9If
	Akzdkdbu7SAN9IBkjeSgOKfvT38gA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 402aacgxnd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 03 Jul 2024 18:53:00 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 463IQwF2010934;
	Wed, 3 Jul 2024 18:52:59 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2043.outbound.protection.outlook.com [104.47.51.43])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4028q9kp5c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 03 Jul 2024 18:52:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kSbL/TU8qGXUkuS+xBQcmFH5E9njcLYDdNvl/7ttNKcreOi4ff97+sSo1yqd2Id07YKoNSOqxJzPYt7ss5bRdyj8Wdpuh6lK/TxN+rYaIS3Ldn0LxZwwjw0jDdDa8I04pwWbTtKsNuRmWvrUlypm1e14+YMiGpD4itkzDAdIP6KwaCx37f3fVCwMQLA1Ep1TOpwOHKqF6Twq98s6XY3g7qM9cawMz2EjXB3gfpZPHDpeSf+PhSiQUbD0AfTLPXcONq6DR3rA6K/RhwOaLspBEoQRLeV+XauUhosfam1QMb6C6YDX9Mb4L40ua3/rWtV5ellTu0KTyogFuwdobHgGvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1B/niFf44Sggh7E5qR4g8rLXx9n5MTs82H7ERGIYM7Y=;
 b=Ot2V/deALog2acvsxXxtBqqPaJ26+ZID3Ou30GvqbjPA/x81AYIP1zZerszyzb0dtcTSw1aOlkXqiGoZYukx1ebYwuTGbuTz8Q6GT1IJJwHz09eOZvvLE9sNzFpdA2Lv/erNRXHskbv/7vw5Ah9FRFnYR0nTzd9jXTeO7CrY3+9N+Fb9U+8V+e9wOy2v01q9gQ3nL8AcQp2Wvf21jzZpufn2RQbAvG0c04Lb4cbeECRdrubBGNy1VGSYXvKpzVXCsWeUlzgd+hMT89tRwN9Z3tJzRqYC9Bg3EbNDaQGBvU+HltEKhadjqrqJl2OF40oLG4/rr5An6ZIQbVkrUO+JhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1B/niFf44Sggh7E5qR4g8rLXx9n5MTs82H7ERGIYM7Y=;
 b=p77aYzy2/D4ZoI11Aap/yr8QAM2OBhbfP3HHpmnTGfa98/dzOXYxjPifgnBseVW0h9QExbRrySCd8Fzkapp6PC3ovcazqVk60fEAHM/MCp68rC/UyjLv9D6VxdRldKmV21HPpgv4fXKMiulVclsEASpU1GoFSmdns+Q1kuqilWo=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DS0PR10MB6223.namprd10.prod.outlook.com (2603:10b6:8:d3::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.32; Wed, 3 Jul
 2024 18:52:57 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%5]) with mapi id 15.20.7741.017; Wed, 3 Jul 2024
 18:52:56 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Olga Kornievskaia <aglo@umich.edu>
CC: Chuck Lever <cel@kernel.org>,
        Linux NFS Mailing List
	<linux-nfs@vger.kernel.org>,
        Olga Kornievskaia <kolga@netapp.com>, Dai Ngo
	<dai.ngo@oracle.com>
Subject: Re: [RFC PATCH 5/6] NFS: Use NFSv4.2's OFFLOAD_STATUS operation
Thread-Topic: [RFC PATCH 5/6] NFS: Use NFSv4.2's OFFLOAD_STATUS operation
Thread-Index: AQHazK3y32l+VD0JmkKmvfie7HJrrrHlWwWA
Date: Wed, 3 Jul 2024 18:52:56 +0000
Message-ID: <0567268D-7149-489B-9C3C-0C33CF95B094@oracle.com>
References: <20240702151947.549814-8-cel@kernel.org>
 <20240702151947.549814-13-cel@kernel.org>
 <CAN-5tyHKV-DP9FK0s9J+6j2uHMvK_8TKqeMh5=GZ81+424xntw@mail.gmail.com>
In-Reply-To: 
 <CAN-5tyHKV-DP9FK0s9J+6j2uHMvK_8TKqeMh5=GZ81+424xntw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.600.62)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|DS0PR10MB6223:EE_
x-ms-office365-filtering-correlation-id: 32e3cd5a-3328-48cf-40d8-08dc9b915a2a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: 
 =?utf-8?B?ckZkOGZ4dGRpa0p1eXlDS1JBalpSQ1R0ZWZGZ1NZL3JhZ1Z6ZU1YbGp4N0J4?=
 =?utf-8?B?eEFHelBQbDlPd3dkK0hxNlEydnk0TmN5VUlobnlSNHROMHg5Skh3c2xUdHpZ?=
 =?utf-8?B?UWd3ZHNQQlo4TXdvcXJQRmVsSDlVLzRiTjJ1WnR6aUJRUjJxOWprbXFUSlZF?=
 =?utf-8?B?VXJ2dkg1S2V2ekdsNm5UUWJDVW5xZUFzdStkZFEycFpKQ1NMaUV5ZjlEVDBw?=
 =?utf-8?B?RjJDeWFocGJFc2ZEQ2hCM3BGbHo1a1VLaUljUDhiN1daNkE1azVVdndBY09z?=
 =?utf-8?B?ejI4eFJGUHZtWnJaSDM3SHNxV1VWN0VpcFJkakt2WWM5Q0p0TjQ4MHBOdDdn?=
 =?utf-8?B?c0hpNnZSVnRZb2poV0lJMEtodjNLZkpUL2syYU1yWDhGWlloaUo3VlF2K2p2?=
 =?utf-8?B?OEVySlkxWVRlaXFwVmY3bEs1bExUSEh2ZTh0YXdYMjVYdGRtNWtjbWp2bWdr?=
 =?utf-8?B?ampGT0pUR1hGVDRyWjRRTmU4UFIyejByeCtTVHgvaEFzcUM0bDZkdGsvb2lj?=
 =?utf-8?B?a3EvQm1mcmtSU0Vwd2hXcU80azdSUUVGeHFlNlp4dmh3cFA2SGlEZTRvc21j?=
 =?utf-8?B?cGhhL0EwRDg3bHNMVjl0L3R3dFRBUnA5dTBSenYydVhETXdCS0FZWWg5Nmtr?=
 =?utf-8?B?bmxIRDNCU21qRWtVS2M2OXpucVBvZWMxaFBTNUtsOWhIS1BVMmdzeVk1VWpY?=
 =?utf-8?B?R0hMdHdIN252K041cHFIU1liN25EYm1VNkduank1TFVIbVg3cndYblgwZVVK?=
 =?utf-8?B?bW1JeE1MVjVHOTlSRUFIUndnWjVDcHJWNVgvcmFJTjlKUTNCc3c1a0xZQk5C?=
 =?utf-8?B?UjF1N01wSU1kYmd4QzR4eUlka3BIMERldHRFL3BZNnJOb0cvQVFJWWpXZ1U0?=
 =?utf-8?B?dkZnSnViczZTcVZWUW40bGZvY3RVVTl2RENpN0ZHQ1hJTlJnMThEWnFLMG9V?=
 =?utf-8?B?bXY3MWpscnhTeUxHVThwdEg5T0xnRWplajZkbjAzNk81Zy9SeWhJSUxDVzlp?=
 =?utf-8?B?UVJSL2c3eXB1ZktINmVFSjhnalhoVUUzOVVob3NEWFZ5RHgwb21RVzY1VEty?=
 =?utf-8?B?UmViV0pnUnlKL3RPa0daZHVKNXpkNFNkOStxOURqekdUN2huRVcyYlFaYTNa?=
 =?utf-8?B?RGYwMmJOK2tzc0VhWk1FQ0FueEgwcGI0ay9qRXBCRFdEMlpHMzFjTzM0UXJx?=
 =?utf-8?B?aDZYM2tORHl5bXYrRWhFNzVpUkFBSWJHZ0JEOHlXbWtUTGVuM1JuMTQwQnF0?=
 =?utf-8?B?Z2pZS0ttajhzTEduVHFPSnZXUHI0bHZWK0RIU2krMkl0MkVvUFh2SlVpdmdW?=
 =?utf-8?B?bWJac1dXNVNtZC9LODVGdUw4RmpwRWFmZDhRT1JSOTNBeGIwazZVdDhLY1Q1?=
 =?utf-8?B?S283eFhqZFZ1OWtrRTlyMXlLdGtnakQ2Z3M2a1g4V2tMZWd6ajhTWXV5SWlw?=
 =?utf-8?B?THlJbjVoQzg1d1VMYXRBRzZXZzBCei9WVzNmNHBJN3RLZ2QzeFNCZkF5ZmZ4?=
 =?utf-8?B?SUZzdlBUQXAxd3lpQnExcmhYVWZxQzdTcmxNZmlnOVRhNjhDMmliSmt6OFZE?=
 =?utf-8?B?cE1IbWwwOWMzV2taWHU2a0cwYmdqZmVWK3pwN3BLczJxaWdIS21kYlIrWFZk?=
 =?utf-8?B?WS9XZDBXL1Y3Y0VuZTBJZHltUm0zMFlDTmlXeFdjS1grSUFEekFHYkRSaEtH?=
 =?utf-8?B?blFrODRYK2RQUXR3NUdzZzU3c2hETm9UdktDSTlHaHk0aGI4cldhQTFLd3hu?=
 =?utf-8?B?czUzeVZhcG0waDJFOVI2dTNDOFNjUDZ4aWJqYm1UZ1pXL001Z1BOekxHdW16?=
 =?utf-8?B?UkxpQzlzMW1zemdSdDFpZTI1MmMwSWFYRmFyUUl5Z2ZwMm1iMGFicFE0QVlq?=
 =?utf-8?B?VjlzaWc1MnQ0RC8zc080MittNlFyVEkvQmtSbEVtWEpUdmc9PQ==?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?cExCZEhwaFdiaE1Wc2pMQU0yaGtDQi83eTNibWl4MzZBRmhUSEJzaW5Bd3dY?=
 =?utf-8?B?SWl1aERNYjR1L0wrTzhRMHdaVzhiUkc4a1dvU202bmxKNDd6TmYvc1N0VHJi?=
 =?utf-8?B?L2ZjQzd4amMwTXljVzhia25ndVBnbHRLY2UrbUZrRmEydXJNNHl5cEVnUm9F?=
 =?utf-8?B?VmJ1Ty82T1dWZ0c0NXJnZUxFeGxHalZOZ0pFdFBkRGVZSXIxWTJXTUdlOGRV?=
 =?utf-8?B?eUx2RW43L202YTdvQ2NwTnhyYStsTjZiMW5qWndUdU9yS1NnZzV4dUlTQ1p0?=
 =?utf-8?B?SEpXbjlCZCtNRmR1eEgzYU5SWWxweEJxaFNsdHZTTnQxZ01UTmZpTm5hdVVW?=
 =?utf-8?B?Y0F1dU0xeDVyTTlHU3VZRTBRR0ZBYmoyQmxFN0dScWtHa1NGODFHeGRQZGxm?=
 =?utf-8?B?OGQwT3Y1T3llMkxLY3RvK29zZkJibjhqb1EvOGU3WEVORnlEYm81YXNCYWZu?=
 =?utf-8?B?RERVN3hZRURwdHZMTE1MSlZzcVlyOVRjUVhsTGw2Y2EzSEthbVdVOWtFamNE?=
 =?utf-8?B?bER4c0FENEw2MEpVY3VvMzkyOHFkbmc0QkRIOUpWeGRaS2hydEJ4T09URDRI?=
 =?utf-8?B?VjZzZXB4VTQ1S2NMdHpCVHFRVU51eWs3dm42YmVaU1EycnBpQWNCbmZlamhU?=
 =?utf-8?B?MUFjZy80dU1SeGJVbHdIdExNbTRXbWpIZW5xUkE0VnRNbHJtaFl6M0ZDc3M0?=
 =?utf-8?B?V1FHWFRXNFAyK3h2bW0yb0pHdFhXdEhGTXZyVXhsOWl0d210N0NVQnlLL3NF?=
 =?utf-8?B?UG96QWkvNDl2SDJRUkREaXNIeW9nVHIzTTlIK21GWGxUbDFpMkZIc2l1RmJ2?=
 =?utf-8?B?S3VBQmU4aXlhdWx4Nllkb01LL2d2TE0waUpwakJvWVQ1eFpvQ3VIQzdldldq?=
 =?utf-8?B?dVJaeGxhMzBWSGx2b1NVQ0hCeEpEL1BZdEo4RXJHdW5oa1dmQ0F1YlNJRHJQ?=
 =?utf-8?B?cDc4a3pWcmRybVVnOW1jS0xQQ0FDOFMvaEE3UytuS1pSYTRLSkdLVVBMZDI5?=
 =?utf-8?B?RlJXaG4wck1pM0hpVG1KeEJiWEQxbkhST1F3bElJOXNqU2JzTW9mVE9yT1Ev?=
 =?utf-8?B?Q20yVWhMZ3ZjOEMxUlVOdXhqcUk0Qy9nQ2JDNHdkSmxyRnl2REpaWmtGVU5r?=
 =?utf-8?B?S28wWXc4Q2ZGclpWZU1DTnhacmUxa2o5RXc3RlFoRjhXUlAyOVM4TWYxVElT?=
 =?utf-8?B?ejRUeVBzVkk1OXRCQ0I4ZGoyMFpMN2pVVTM1b3JEY0VTd0dYZ2cwZEI4dTU3?=
 =?utf-8?B?QzBrY3BVN055d2hSQ2svUTFoUzdZRHdGUlp3TEdBL0wwbTc2Q280SUw1YlJQ?=
 =?utf-8?B?RldkVmlYMlNVMHQ0TDJUKy9uUDNpb0pLUk0rRCtwL0hFVFZBLzIzZERlU2c4?=
 =?utf-8?B?WGY4cWt0eTlaVTh0VFR2UHpoc0Fnemw2c2IrdHVZRUtoY0llbEhDODRMMWRh?=
 =?utf-8?B?bmE3a1hTU1BJeVk5bThZMlJRdEU2emRUcEJ2dkJQZ01EcUd6VkEzaHNHZnpm?=
 =?utf-8?B?ZjBSbzBZcEJTMG15amZhelV4bkExZEJJVmpmTHUvODJnUjR0NXIyVVcvRnJF?=
 =?utf-8?B?R3ErNitsVHY0L2VqdFR2QnNRTVhvTE9xaHNWLytMdlV1TzRpSUVTa0M3ZGxu?=
 =?utf-8?B?eTYzbXdwTk14cDdYU01rVXlIL3IrRXhBYlJyb2g0d3hhRk1Ia2d5NGZoWVFG?=
 =?utf-8?B?amVyVnFMVkFieXVaa1YrT2F0QTdWaFBtWEdSR1dpZjdGTXVXZWVpcEZCdjdp?=
 =?utf-8?B?Mit3N0NweUkxdHNkQmI4R05wVU1hMnA2K2RZdWpKNHVZWlVJMFN3UGFxUU5n?=
 =?utf-8?B?U2dhQkxLV2phdTJJM0dXVDNrWVlIekhXKzBuTnJ3cE8xT3MrejNWUzU0VGJ2?=
 =?utf-8?B?SkRVUmZoWGVqT0l0MkpxM3JSazVOSEdPaEk3TmhGb2UvZE5RYkZXMzY4d2FC?=
 =?utf-8?B?ZnY0SitjYzZNd0h4Vy9POVIyR3orODFHME5jcHo3ZUEvOGdnR1BZQ2JXbDll?=
 =?utf-8?B?bDM3NXc2QnY0Zys5Wk1FM2JHWnhKcFFCWjd5bHpSazJTamEzS2VwU3NZc1lG?=
 =?utf-8?B?VHlqQ3NjR2R1RERGTDY4bm1xQVpjV3RwWndVQk5CT0dxdG1kTWJyNk5IV1c0?=
 =?utf-8?B?T01ERUJMZm1jQ3RIUXJ3b3NRTVVKa3VLOVNZVXNCeCsvT3F3WGkxamk4Y3My?=
 =?utf-8?B?Unc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D603F9F95C4CCC49AB58794B2360C44F@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	2eH3AJDvZw2rVbbV2OZRQ6L3Ud42Jk/xuIAk2x8LpGnmyqAdnEJUa4rfycbHroqvMh9YPA/LCqP+YazrJT0ZTBnSSyagBvQ0K/9v9RJvqmNeGLiM+3ZOAAVw/J/oA5GuwNL/nMZ49BuIoOZNjo7kfUldidoDSZ6JrbytcGWG6pjPe0ls9Pzjwlk+HYZmF015d7b1DlMApsI8xihFqMxP6MSNzsaW1qhYtMAZDKN22VyEKlm8gDsJOmccWYTG5vbqAkGYLF+dIqbJG8DEVsydwj0MgHNwFcpnQQtEKFhAtgj3tcooSioq3A98sNX747cBm2L9Vf8j/s94AwAhlQmZySWHsen/NuREr26A2HzMLVHvdAVfwk3vVYL5GiavKvghOxMu5FkJoD7m+LyTvuj1T1q9Ry3/o2pNtHRqdT+vVOYPtEw4trhycIZZWNDJurNIZWOwhYslQLjt1BH2AUXB5DF2JPaDR4AMLbUee5or0MNUqh5shgxVMbWo+/CyH0luIX6fWeqshVL0X8IaaOE8QiXGZeQNAvrB9lgf12DW590Od6mBUrqVFRntmuULSHMkkuWH0+O35OEBhnPbcBBal3nA5HnwWFD1Q215iyGVQTs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32e3cd5a-3328-48cf-40d8-08dc9b915a2a
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jul 2024 18:52:56.4967
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ua/bTm90VZHqqyFXwfCHvNSJuuKMhAJf1WQbzjXXjHeua0H+l5CWSVQYp9U3J+kdygmubLLQcYK9JDF94klhFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6223
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-03_14,2024-07-03_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 spamscore=0 mlxscore=0 adultscore=0 bulkscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2406180000 definitions=main-2407030141
X-Proofpoint-GUID: 3VdlDlUG6eso2LBaCdTowXKIy40eErj5
X-Proofpoint-ORIG-GUID: 3VdlDlUG6eso2LBaCdTowXKIy40eErj5

DQoNCj4gT24gSnVsIDIsIDIwMjQsIGF0IDI6MzDigK9QTSwgT2xnYSBLb3JuaWV2c2thaWEgPGFn
bG9AdW1pY2guZWR1PiB3cm90ZToNCj4gDQo+IEFnYWluIEkgZG9uJ3QgdGhpbmsgdGhpcyBhcHBy
b2FjaCBpcyBnb2luZyB0byB3b3JrIGJlY2F1c2Ugb2YgaG93DQo+IGNhbGxiYWNrIGFuZCB0aGUg
Y29weSB0aHJlYWQgYXJlIGhhbmRsZWQgKGFzIG9mIG5vdykuIEluDQo+IGhhbmRsZV9hc3luY19j
b3B5KCkgd2hlbiB3ZSBjb21lIG91dCBvZg0KPiB3YWl0X2Zvcl9jb21wbGV0aW9uX2ludGVycnVw
dGlibGUoKSB3ZSBrbm93IHRoZSBjYWxsYmFjayBoYXMgYXJyaXZlZA0KPiBhbmQgaXQgaGFzIHNp
Z25hbGxlZCB0aGUgY29weSB0aHJlYWQgYW5kIHRodXMgd2UgcmVtb3ZlIHRoZSBjb3B5DQo+IHJl
cXVlc3QgZnJvbSB0aGUgbGlzdC4gSG93ZXZlciwgb24gdGhlIHRpbWVvdXQsIHdlIGRpZG4ndCBy
ZWNlaXZlIHRoZQ0KPiB3YWtlIHVwIGFuZCB0aHVzIGlmIHdlIHJlbW92ZSB0aGUgY29weSBmcm9t
IHRoZSBsaXN0IHRoZW4sIHdoZW4gdGhlDQo+IGNhbGxiYWNrIHRocmVhZCBhc3luY2hyb25vdXNs
eSByZWNlaXZlcyB0aGUgY2FsbGJhY2sgaXQgd29uJ3QgaGF2ZSB0aGUNCj4gcmVxdWVzdCB0byBt
YXRjaCBpdCB0b28uIEFuZCBpbiBjYXNlIHRoZSBzZXJ2ZXIgZG9lcyBzdXBwb3J0IGFuDQo+IG9m
ZmxvYWRfc3RhdHVzIHF1ZXJ5IEkgZ3Vlc3MgdGhhdCdzIG9rLCBidXQgaW1hZ2luZSBpdCBkaWRu
J3QuIFNvIG5vdywNCj4gd2UnZCBzZW5kIHRoZSBvZmZsb2FkX3N0YXR1cyBhbmQgZ2V0IG5vdCBz
dXBwb3J0ZWQgYW5kIHdlJ2QgZ28gYmFjayB0bw0KPiB3YWl0aW5nIGJ1dCB3ZSdkIGFscmVhZHkg
bWlzc2VkIHRoZSBjYWxsYmFjayBiZWNhdXNlIGl0IGNhbWUgYW5kDQo+IGRpZG4ndCBmaW5kIHRo
ZSBtYXRjaGluZyByZXF1ZXN0IGlzIG5vdyBqdXN0IGRyb3BwZWQgb24gdGhlIGZsb29yLg0KDQpJ
ZiB0aGUgY2xpZW50IHJlcG9ydHMgdGhhdCBpdCBjYW4ndCBmaW5kIGEgbWF0Y2hpbmcgcmVxdWVz
dCwNCnRoZW4gdGhlIHNlcnZlciB3aWxsIGtlZXAgdGhlIGNvcHkgc3RhdGUgSUQgKGl0J3MgYWxs
b3dlZCB0bw0KZGVsZXRlIHRoZSBjb3B5IHN0YXRlaWQgL29ubHkgaWYvIGl0IGdldHMgYW4gTkZT
NF9PSyBpbiB0aGUNCkNCX09GRkxPQUQgcmVwbHksIGFzIEkgcmVhZCB0aGUgc3BlYykuDQoNClRo
ZSBjbGllbnQgd2lsbCB3YWl0IGFnYWluLCB0aGVuIHNlbmQgYW5vdGhlciBPRkZMT0FEX1NUQVRV
Uw0KaW4gYSBmZXcgc2Vjb25kcywgYW5kIHdpbGwgc2VlIHRoYXQgdGhlIENPUFkgY29tcGxldGVk
LiBUaGUNCnNlcnZlciBpcyB0aGVuIGFsbG93ZWQgdG8gZGVsZXRlIHRoZSBjb3B5IHN0YXRlaWQu
DQoNCi0tLQ0KDQpBZ2FpbiwgaWYgYSBzZXJ2ZXIgZG9lc24ndCBzdXBwb3J0IE9GRkxPQURfU1RB
VFVTLCB0aGUgb25seQ0KcmVsaWFibGUgcmVjb3Vyc2UgaXMgZm9yIHRoZSBjbGllbnQgdG8gc3Rv
cCB1c2luZyBhc3luYyBDT1BZLg0KTXkgcGF0Y2ggc2VyaWVzIGRvZXNuJ3QgaW1wbGVtZW50IHRo
YXQsIGN1cnJlbnRseS4gSXQgY291bGQsDQpzYXksIHNlbmQgYSBkdW1teSBPRkZMT0FEX1NUQVRV
UyBiZWZvcmUgaXRzIGZpcnN0IENPUFkNCm9wZXJhdGlvbiB0byBkZXRlcm1pbmUgd2hldGhlciB0
byB1c2Ugc3luYyBvciBhc3luYyBDT1BZDQpnb2luZyBmb3J3YXJkLg0KDQpUaGUgYmxvY2sgbGF5
ZXIgZm9sa3MgSSB0YWxrZWQgdG8gYXQgTFNGIHVuYW5pbW91c2x5IHN0YXRlZA0KdGhhdCB0aGVy
ZSBpcyBubyB3YXkgdG8gaW1wbGVtZW50IENPUFkgb2ZmbG9hZCByZWxpYWJseQ0Kd2l0aG91dCB0
aGUgYWJpbGl0eSBmb3IgdGhlIGNsaWVudC9pbml0aWF0b3IgdG8gcHJvYmUgY29weQ0Kc3RhdHVz
Lg0KDQpJTU8gdGhlIHNwZWMgc2hvdWxkIHNheSAoYnV0IHByb2JhYmx5IGRvZXMgbm90KSB0aGF0
IHNlcnZlcg0KTVVTVCBpbXBsZW1lbnQgT0ZGTE9BRF9TVEFUVVMgaWYgaXQgc3VwcG9ydHMgYXN5
bmMgQ09QWS4NCkxpa2V3aXNlIGZvciB0aGUgY2xpZW50Lg0KDQotLQ0KQ2h1Y2sgTGV2ZXINCg0K
DQo=

