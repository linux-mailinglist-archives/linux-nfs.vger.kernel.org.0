Return-Path: <linux-nfs+bounces-4004-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6412490DCA4
	for <lists+linux-nfs@lfdr.de>; Tue, 18 Jun 2024 21:40:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3618D2832B4
	for <lists+linux-nfs@lfdr.de>; Tue, 18 Jun 2024 19:40:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7993016D4E9;
	Tue, 18 Jun 2024 19:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Rq3blDv7";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="zaZqbCqx"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A80F716CD22
	for <linux-nfs@vger.kernel.org>; Tue, 18 Jun 2024 19:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718739577; cv=fail; b=dA6skWezyLaQHxGRrCw6rq8J9NfBmU56EfH5IVDCLduS9N0fzlOr7YPrDDoB55uyvXcrXPicwbABLAi9CJTanPEZNVy5GYElWaKyska12RZtrlOnDabNvPBrJu1CBP27aFGnSOOAvBxWHh3DIduZD4y94pBXwJlQWR8tfUY4WAw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718739577; c=relaxed/simple;
	bh=53wNMjxYG2VqGu8tiZL3qtwaqwwoKmMnPY7KUu1xEhE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CbEcCpUFF5WT4gOugkmEkq5ZxgkxIDN3wDgxBlNLsFmk7vFwf/0uHM1JqupB54QEKrinwZ9umlYTiB9ijJBp8kQ8YdhEbD7X6nG8ELiqH/ow7IDm/tbKa88w+HTn9LxbSHmdo9mvYsMHW0xb3oVUYpqO+6H4c2SINC56+hUycmY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Rq3blDv7; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=zaZqbCqx; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45IIUrRX029781;
	Tue, 18 Jun 2024 19:39:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-id:content-transfer-encoding:mime-version;
	 s=corp-2023-11-20; bh=53wNMjxYG2VqGu8tiZL3qtwaqwwoKmMnPY7KUu1xE
	hE=; b=Rq3blDv7cFXmA1RH3WT+ctfwr5510XP8bqQvNDrDjVB8T+4RmK1Lfgcrt
	s7uzAVp/vn0wIhSjHxWygaiKY+8iTTeiBlAoll+mum3vfwE4Zc39Rl/roVs7as9L
	CxCS+U6OmVgp76kcLRG0nf2MHAUV5jzsq5ZeC4NTJkzg2m0lRi/f1lso5H+1elnm
	jXUnotCPFADBkDqd6IPIr0ckA/0lTSnEbl6hfLlCV9qLqwdRzYKGL5kG4BaMMvZc
	9+Tz0/t0I5eYzgNxvzFfEOKSrXxymdxorLsNzPPoFLWIMmBva/ML61y3rgjMGWNQ
	vY509EFyrbc34WQS5/CVYSu3Rsp2g==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ys2js5q3w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Jun 2024 19:39:28 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45IIPcnO029288;
	Tue, 18 Jun 2024 19:39:27 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2176.outbound.protection.outlook.com [104.47.55.176])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ys1d8jwey-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Jun 2024 19:39:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hXO6gAAiriUXoIhmL1DvMlshp4Jy5Tk8wt7Pj6CPABlXLppZ6N4+uZT29f5xLegDt7beN3ha52ILUhIWBxqlw7PbPhX/Lkf0kxBrvj33quoHUHvUD4wyx9jhm2tzBB9s2/rpon6UCzO9pcayhnYN2A4eG1BSkcwMg6uWxadNEf1FTA8YHgJzzu3ptilOjBlUXgRQVt/BN9SOlrcXTp0CvIRIDvBHKiTfodqAJ2eezsT4xgnZb2uHYb5y8m6RoQDf+oHoOcTWiEJkGfOjuGn6kU891m7NsmNnpbr0QJo35rry3hM4znilSZIF0Rx9VNMI6KXIGjr4qGmWjbDOa1ZsXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=53wNMjxYG2VqGu8tiZL3qtwaqwwoKmMnPY7KUu1xEhE=;
 b=mZgyFt2Fd960V+adWl83rQt0oh+gWm27VkqR5fEuW7TX8BXACWdmDn3oZh8nJCRs557kh6qpbzTfe8hXiyiItHjORVye18wplewiwt/2s+B2eMxpd3FoswQuqMfosO2HFUR+zdiO1d4APRw8cCxwYuGtTXrI4CV9W/bHmax/xKC7p8hMJIqbShYYTWnLM8roKoMJjC13bYFWNVH+xSLu3CnWynJWo5G8hFIeFIHZ9bAuO/6IbHiZaInFN2z2HAW2GHDegXPTKxCuNQM/JaOHtO9UazJW81eWfwzV92JCK4DCz6e23OqmsWK6sLUg1SnE9gsS6cmMaMDaW9r/3nTCMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=53wNMjxYG2VqGu8tiZL3qtwaqwwoKmMnPY7KUu1xEhE=;
 b=zaZqbCqxzjheCy3rfsauvfYzu5JS7FVkCE1t9XQdIg+WpAsDOpOFOqC5GcM4Z/bdnO0WyTbSt3q2pTQ2qi7NjUcWq0C2JbOLqi6rG+sJ661jF+3nKyFIrRC303DUJQGsPTiEchuwzXN5fYyuZs0MXmaWfulse54fGm0/dAG0948=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BN0PR10MB4824.namprd10.prod.outlook.com (2603:10b6:408:12f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31; Tue, 18 Jun
 2024 19:39:25 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%5]) with mapi id 15.20.7698.017; Tue, 18 Jun 2024
 19:39:25 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Trond Myklebust <trondmy@hammerspace.com>
CC: Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "jlayton@kernel.org"
	<jlayton@kernel.org>,
        "neilb@suse.com" <neilb@suse.com>
Subject: Re: knfsd performance
Thread-Topic: knfsd performance
Thread-Index: AQHawa3dybcUo3ed40e1woBUDQls6LHN2rIAgAANu4CAAAKdAA==
Date: Tue, 18 Jun 2024 19:39:25 +0000
Message-ID: <7FFACD6E-86D2-4D14-BF03-77081B4CFF38@oracle.com>
References: <313d317dc0ca136de106979add5695ef5e2101e7.camel@hammerspace.com>
 <58A84B36-C121-46F8-ABCB-BE4F212E9C81@oracle.com>
 <754f3e0f6f962cbd46b2b22e87d9de9f8b285ab4.camel@hammerspace.com>
In-Reply-To: <754f3e0f6f962cbd46b2b22e87d9de9f8b285ab4.camel@hammerspace.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.600.62)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|BN0PR10MB4824:EE_
x-ms-office365-filtering-correlation-id: 4a049148-3654-42b1-f15f-08dc8fce5c30
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230037|376011|1800799021|366013|38070700015;
x-microsoft-antispam-message-info: 
 =?utf-8?B?aG5BUjZJTmZaMXQxV1NLN3BoamNBMGpGR0lXeDBTeTdiNER0ZXJpTmN3QkZQ?=
 =?utf-8?B?ajdQMDVYVlFTdnhJK2xWejVxMzJtNlBTK0JlbmNKVmZGTE5Kbis4NEIyWDdi?=
 =?utf-8?B?c2FLQWlpWmQwQnQydENSY2hidmNpcFZsS2g1VkRhRkRSelYxeTJkeWdzajBP?=
 =?utf-8?B?THNyNTlDaWZlUmdiU3lIbXh3UTVOR2tsREg2bmpyRk0rK1RaYjhRdUtVNkVx?=
 =?utf-8?B?MENNSVNyV1ZhVk54RktFdjQ2VTFsbVZ1bjZndXQxaU8rNk5JTnVkQ09QNEVp?=
 =?utf-8?B?bXRSOWhuOEo1elpBcm4waVpXNUlsTE1OdmVMRW42STdRZjdZbXFOWm0xSUpD?=
 =?utf-8?B?OFRMRHpvT3p3MC9wTkFwVkNPU2twbDVkS2ZoVFpQaDRSdGlkMSs3dC9KTDRF?=
 =?utf-8?B?TDJaYUI1NTdlY2I1NDVhSmxoQjViN3kxYzQ0M0djYXhOMzVkZ1dtU2RZM1Z3?=
 =?utf-8?B?RUR2NHR0UDJrWUU4THNPaDdNRXNDQ09KbnR3eldkbzZEaitYSHA2UmZ1UmpM?=
 =?utf-8?B?S2dXVHN2UWsxL0c3R3B0WUhWR3ZEYUR5OVBPSmhyKzhieTdiZG0xRzN3VTh5?=
 =?utf-8?B?ZnZDMzZSai9SZ2VzRmNqbk1kQ0taSWh0RTQrSlJvOFNoY3pxUjRXME1BcWlo?=
 =?utf-8?B?TFFLV1JxcVBzUCtSZVZQbnpxdmMycWJoSXRjYXYyMXBJV2xZOGN2U0pROUVx?=
 =?utf-8?B?ekRNUDkvR0dJdnVuQjJPWDlkR00zL2kzamdTbnFvdjNUVmZrTHhwVm5kajI2?=
 =?utf-8?B?cEsrdmZZREQ4b1pCRENMRGh0M3J5MEJqdjhJUjUydHFoM2JTc0xqaVNleGU5?=
 =?utf-8?B?RTBMWENMS0JxYVNxZmo5V3dVTjZkK1YrMkJQQWFIc2JtOXMycXIvN1lNZTdF?=
 =?utf-8?B?akl1TWI2OXczL0ZjWmZDWE1DVC9JOWZRc2liT282aFVGTEswVzNZZXJiQ1VQ?=
 =?utf-8?B?VndwVXI4SDFTdGhOeGlZUDdFUEt4OUNENy9hb1l3NEJPR2RQaEdid3pmRDFE?=
 =?utf-8?B?KzRoTjZYbWF6MkpLNTVJdU9WRTFNMzBKVVB0cXRtOWhHWkJQVmJUTGluT0p4?=
 =?utf-8?B?ZzdsS0tEQTg0YWl3a2hoQ1JIdzlzSVhRZkVOeGY2eWlzSnJqUm5YRS80T3pO?=
 =?utf-8?B?bXRCS3BoNFZFdjdjTVRma01UYkZJRmQ3ekNXSUVSZExIRUVPczFWYkZIOWhT?=
 =?utf-8?B?bHA2RXNUU1NISlZCTlpZemR0N2ZjendER0lzUGg5N3RXUDhTTWN3dkRFL1FL?=
 =?utf-8?B?SHJhQ09qZlBRcTFrczZGT3UyS0ovNituQmIzdkVIazUzS3dOdWd1Uk5NQzRE?=
 =?utf-8?B?V2xMSGxtZHpzTjhYcVR1eVlNNjhWOHc1SEZENXFTQ2EvTWxiVEFXcXFabE4v?=
 =?utf-8?B?UHVMQXpQUm82ci93Z1ZORnB0ckxkVnRiY1E1R2hCQVp6clBObUdxaFFEQlYw?=
 =?utf-8?B?eEpKTVBSWFdSdlBXR0hNQ0llY1l1QUFlQzZIY3RJQ0R1ZTVsOTYrWVNoNC9Q?=
 =?utf-8?B?dTIvbUtQRExTK3hlK01TanM4K2Z0YUZrS0ZEeU1ScmdqbFJnZVUxelAwdXZ3?=
 =?utf-8?B?allyVVd2UmIzRU5Wc2o0S1E3UzI5QWl4dElZRWZ3WEoyN3lGVEJSd0c2bmZ4?=
 =?utf-8?B?Z25qbTZ6V3YyMlloajV0RitmWVpiSU5UdWw4ZzZFYjFLVkFlcERkQjZ2RldE?=
 =?utf-8?B?WXZHdnU2SjRGdEhUWTdIZUtiRnAreHNFR0ZoUVZLZ1UrYjFpbWszU3hlYndr?=
 =?utf-8?B?Mm1GZHVJNFR5eFhadmRMenJCOStraXJ3aDNsaWtvN3d5MkFtc2RYeGNEUEZV?=
 =?utf-8?Q?7GISs1nmqya5HYCjdbp0KEqUENgX3I/pXJGF0=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(376011)(1800799021)(366013)(38070700015);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?bmNmMjRPdUZ2bmxUTWtNWis1SFBZV1lTZW4zTDQ5N3dUYXkvR0c3aFF2NlAv?=
 =?utf-8?B?RGE4OWNBcDgrMEd6dytzN0hGMHBIby9FRExHb3oxWEFlQ3hQMmNES0dXTUZW?=
 =?utf-8?B?WHJIeUp4OUxJb0NiMW9FbjZMb1lyYWRkVXIyanBUbkVtbG5CZGlaa21udzhq?=
 =?utf-8?B?VWc4M0J2R3EwdENmbEJXbHhSOUV0Qk12bC85anpkUXZkU3Q0RHpUVUd4cUV5?=
 =?utf-8?B?TktEYUEzT3lSclVBS01Cdjg3TmpQUjBMZHN6TDZjRTFBakVicEp5Zm5FY0xB?=
 =?utf-8?B?aWVrL01GaG0wS1ZvcnNrdzdORkNWK3JiL1lIdFpTMkpzN1ZwazdScW1WMDRB?=
 =?utf-8?B?TlpVSUJRdWhYc05nRW4zaXA1N2xIaVBKZnN1dXJwc1NNZzA1OHVoQ2M4WDZZ?=
 =?utf-8?B?allsaUd2MlRXQ0phMGNEZEZQQlp2N1VQUkg2Y1R2d2JucEoyR1RyU0pOOXZX?=
 =?utf-8?B?UUh3TkQ0SGkzVkduQTNJUElwYk5pWUlHdEJVL0E1cGFhQVFXVGdTVkJ4UkIv?=
 =?utf-8?B?bTNPRFAycGFUOFRXYVFRRkRlLzRjcnphUUZidEM3bFZ1dkMwQ1ZUY3ZQN2sz?=
 =?utf-8?B?U3hobGYwaGF5S0ljUmpBc2NDVmxBaCtQUnhoOVJkOXVsamdzZHhkRm9zVGZq?=
 =?utf-8?B?NDQwdmF5SzZ5N3NXbWNFaHZtejcxU0ZkcUpTWVdUV1dLc3ROeS94NDFMS1lX?=
 =?utf-8?B?NnZ2NUkrZGlFV05ia09BK3d3TTUvbjdDMmVNaTZTMGZUbUZLS2R1d2syT3Zu?=
 =?utf-8?B?RlR6dFprWE5IN3hnRW14c0k1clllbDZCRG1FOThpOGQ1M1hROC9GSnYweDIw?=
 =?utf-8?B?Nm9PSXlWQnBXeVhVd2tDQXNEOGF0RVZNanFJTmVEaisybi9OZ1VQSnlOOWZK?=
 =?utf-8?B?eTNIRUUramFyTEF0bE5MY05wTXFTdjJ2L1p0eVducnJGaUxQbjFSMHY2U1JX?=
 =?utf-8?B?b3FncjdrbkJSbXhYbzNnZ3dXZmV3blNhZnFRcWs4VmFrWU84L0VXZGV5aHdn?=
 =?utf-8?B?dk1DR3Y4SmlzSnBTMDZjMVl4TVhET3RTYm9jekFFYmViUHoxNHFmVE5BWHh5?=
 =?utf-8?B?NkhpeWFaVlRKN1AydFpSckxlSE4ySTlMZWRTbThpUGNyMm84Z20yWjJyd21Z?=
 =?utf-8?B?RDNaVStYYm1SVCtlM1k4QTYwaTVJNWZ0dmVhaG9maEtCLzc1bVVuMGJJdnp1?=
 =?utf-8?B?aGRmL0FSdGwyS3hXd0J5UFF4UEJ1aldsRjNOay9mcDdibmV6dWZUMTNmME5X?=
 =?utf-8?B?bmxaanVOQ3ZpSUwzV3dzWEpMODIrc3oveGdMenppd2tTOS9ydXprQnFUeXoz?=
 =?utf-8?B?M1UvWE5JcjdDRGIrSHU0d1Z0K0pmUzBtMllkdUErdWNBZFdYQUc3MngzdE1z?=
 =?utf-8?B?cmxtTU5LMStXWFFGd0JodzB2emN5RDBWdmFueXRXdXNYakNEVktzY1JUQVlh?=
 =?utf-8?B?MkVUNFdSM3RRMXZaWUxXUzNMT1paUUhkaE52NHNxZ3BJT1hQTURReUVJNkN4?=
 =?utf-8?B?K1MrSFhoenBXMm1ZdG1WZDNsZ1ZpSEYrUjNRVkJRVU1xdHIzSDhkQzd0aVFS?=
 =?utf-8?B?QUYxblZZQktVa1FlWTR4V2NMZnFQQ21udjNDemNzVmh5dUhDQldhY2lLdkhh?=
 =?utf-8?B?bDVkRTd2WVFrVExrWklMWGFEaFgxQ3FNdEdmbnJEMklCdjR4Wm5XU0FFSjFp?=
 =?utf-8?B?SjRWWWRwak1sdDkweTZzc05teGdib2N4bE9Uc2lYQmJnM3paVUxzeS9tdE9o?=
 =?utf-8?B?eWs5SzZLeEd5NUI0N21kRHlVdXQvTlVsNi9TcWNVT0tKd0sxTXMrN1hadDRz?=
 =?utf-8?B?RkttVGI3TFVaSUYzYmZ5M0FUcEo5aHhWcWJQdVg4a2RhakNTTDRrMjlTSTgz?=
 =?utf-8?B?RFZNeDZmdFpYU3Zkd1ZucVV5ODk3OEVZOXdraE5IQkFzSW81cW1IdTRkZVFP?=
 =?utf-8?B?RHZhY1NCRFNXRWw3TFRIcno0N3N4d3c0V1BBTitOenp6eWxrOUxmVmp6TExQ?=
 =?utf-8?B?cXYyVTB3bGk3WGIxUnBQaGN4bUdMc3VHekozYkwvbGVpdXMybTFrU25LNmVI?=
 =?utf-8?B?Q2xJMGRQQ2lrMzhzeDFmVm9INnZpRUQ4bVRBeXBxeVBaSTA3VFpnMGVBN3V4?=
 =?utf-8?B?Nzd0S0E3T0c3cHc5dGttcVV5elRqL1JXSFJwVnVIdVBBTnZ3WnZqRVFJZm51?=
 =?utf-8?B?L2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <105E03FEDBCC034CBCE00799B8B2E1ED@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	yFMKRYjdlulUi6Y6wJ/VYtS/bmBlZZJ8aAs7HPSdaRyPIpRUs293qd8aLzebFkA2U1gNqlE8hc1hKUZs47cl/8YTXkxpAN6teHJec+kLkznyIXwbyE7MOH/21w6+uHNFltuyMLZIgN9eDW1fWJhO/UUJfFOrRjR22wlaexXdUSzV3dZUK4tmfZ9ML45A/Z2QjZx1kRtlFI0ajWj0wXRxKTQ6BCsEHubDNxgqsni5X29rWgbTGyOoAJ7pyJTTvtWXzg0ftBtTtqO/V2Luea7wweaoCqdR08tqlY/5/OqPrClspq7qffQfYzumaCjdOVOb9I96T5tWl27ALZLrOQ8wfqXFcjkz+RvTqESoWhruE34JEj1cKyt40QXHAezFfgrlig3E5BwfdXeWZonsKYr+lE7U8jTWOddohz5uVUSx2Y/74y7AsJXEIFDV15R04KldYI5zwnwqxA5X7Bdr+kFdaZvHp+KHjIarSsLpXD8s8MS4iip2gVVbbF1I1xQOKB4+x839x5Inc9fHy3QOhgWuGvC4F6O7o0rS8zbWBRHx9WUpDIf0IbAm04fuWx3EHzvY4Az18B6oCofQGiELURN04BQ/Ihi0L2WjxIOw+hD4m4c=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a049148-3654-42b1-f15f-08dc8fce5c30
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2024 19:39:25.1975
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: v3poHy3HLusHriH2qSZ083+UXdOwF9vtww8g+ERNTQK70WkXOmU5i3tW51Lmg+JFMD9CfgFffn2YXXUw6rpP7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4824
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-18_02,2024-06-17_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 malwarescore=0
 mlxlogscore=999 phishscore=0 spamscore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2406180144
X-Proofpoint-ORIG-GUID: lRY4jhedO9szzA41NiUWWrZCmBGxDXcK
X-Proofpoint-GUID: lRY4jhedO9szzA41NiUWWrZCmBGxDXcK

DQoNCj4gT24gSnVuIDE4LCAyMDI0LCBhdCAzOjI54oCvUE0sIFRyb25kIE15a2xlYnVzdCA8dHJv
bmRteUBoYW1tZXJzcGFjZS5jb20+IHdyb3RlOg0KPiANCj4gT24gVHVlLCAyMDI0LTA2LTE4IGF0
IDE4OjQwICswMDAwLCBDaHVjayBMZXZlciBJSUkgd3JvdGU6DQo+PiANCj4+IA0KPj4+IE9uIEp1
biAxOCwgMjAyNCwgYXQgMjozMuKAr1BNLCBUcm9uZCBNeWtsZWJ1c3QNCj4+PiA8dHJvbmRteUBo
YW1tZXJzcGFjZS5jb20+IHdyb3RlOg0KPj4+IA0KPj4+IEkgcmVjZW50bHkgYmFjayBwb3J0ZWQg
TmVpbCdzIGx3cSBjb2RlIGFuZCBzdW5ycGMgc2VydmVyIGNoYW5nZXMgdG8NCj4+PiBvdXINCj4+
PiA1LjE1LjEzMCBiYXNlZCBrZXJuZWwgaW4gdGhlIGhvcGUgb2YgaW1wcm92aW5nIHRoZSBwZXJm
b3JtYW5jZSBmb3INCj4+PiBvdXINCj4+PiBkYXRhIHNlcnZlcnMuDQo+Pj4gDQo+Pj4gT3VyIHBl
cmZvcm1hbmNlIHRlYW0gcmVjZW50bHkgcmFuIGEgZmlvIHdvcmtsb2FkIG9uIGEgY2xpZW50IHRo
YXQNCj4+PiB3YXMNCj4+PiBkb2luZyAxMDAlIE5GU3YzIHJlYWRzIGluIE9fRElSRUNUIG1vZGUg
b3ZlciBhbiBSRE1BIGNvbm5lY3Rpb24NCj4+PiAoaW5maW5pYmFuZCkgYWdhaW5zdCB0aGF0IHJl
c3VsdGluZyBzZXJ2ZXIuIEkndmUgYXR0YWNoZWQgdGhlDQo+Pj4gcmVzdWx0aW5nDQo+Pj4gZmxh
bWUgZ3JhcGggZnJvbSBhIHBlcmYgcHJvZmlsZSBydW4gb24gdGhlIHNlcnZlciBzaWRlLg0KPj4+
IA0KPj4+IElzIGFueW9uZSBlbHNlIHNlZWluZyB0aGlzIG1hc3NpdmUgY29udGVudGlvbiBmb3Ig
dGhlIHNwaW4gbG9jayBpbg0KPj4+IF9fbHdxX2RlcXVldWU/IEFzIHlvdSBjYW4gc2VlLCBpdCBh
cHBlYXJzIHRvIGJlIGR3YXJmaW5nIGFsbCB0aGUNCj4+PiBvdGhlcg0KPj4+IG5mc2QgYWN0aXZp
dHkgb24gdGhlIHN5c3RlbSBpbiBxdWVzdGlvbiBoZXJlLCBiZWluZyByZXNwb25zaWJsZSBmb3IN
Cj4+PiA0NSUNCj4+PiBvZiBhbGwgdGhlIHBlcmYgaGl0cy4NCj4+IA0KPj4gSSBoYXZlbid0IHNl
ZW4gdGhhdCwgYnV0IEkndmUgYmVlbiB3b3JraW5nIG9uIG90aGVyIGlzc3Vlcy4NCj4+IA0KPj4g
V2hhdCdzIHRoZSBuZnNkIHRocmVhZCBjb3VudCBvbiB5b3VyIHRlc3Qgc2VydmVyPyBIYXZlIHlv
dQ0KPj4gc2VlbiBhIHNpbWlsYXIgaW1wYWN0IG9uIDYuMTAga2VybmVscyA/DQo+PiANCj4gDQo+
IDY0MCBrbmZzZCB0aHJlYWRzLiBUaGUgbWFjaGluZSB3YXMgYSBzdXBlcm1pY3JvIDIwMjlCVC1I
TlIgd2l0aCAyeEludGVsDQo+IDYxNTAsIDM4NEdCIG9mIG1lbW9yeSBhbmQgNnhXREMgU044NDAu
DQo+IA0KPiBVbmZvcnR1bmF0ZWx5LCB0aGUgbWFjaGluZSB3YXMgYSBsb2FuZXIsIHNvIGNhbm5v
dCBjb21wYXJlIHRvIDYuMTAuDQo+IFRoYXQncyB3aHkgSSB3YXMgYXNraW5nIGlmIGFueW9uZSBo
YXMgc2VlbiBhbnl0aGluZyBzaW1pbGFyLg0KDQpJZiB0aGlzIHN5c3RlbSBoYWQgbW9yZSB0aGFu
IG9uZSBOVU1BIG5vZGUsIHRoZW4gdXNpbmcNCnN2YydzICJudW1hIHBvb2wiIG1vZGUgbWlnaHQg
aGF2ZSBoZWxwZWQuDQoNCg0KLS0NCkNodWNrIExldmVyDQoNCg0K

