Return-Path: <linux-nfs+bounces-5042-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B65B393B7A8
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Jul 2024 21:44:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CA9A285F68
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Jul 2024 19:44:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A333452F6F;
	Wed, 24 Jul 2024 19:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="eM+rD47b";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="VIpqroIJ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0682613D
	for <linux-nfs@vger.kernel.org>; Wed, 24 Jul 2024 19:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721850248; cv=fail; b=iHy8VkO2fGCdVd1mPuOG29Xlcrk7jLMzrsuAdnkuZibE4ovAYuaOYhatcQOAFgCTeCoz/WCN0gObsHaUBnD/NobowP6x2pYsSaZL8KcZM4OY1n8+A1s2EHBunY2KxwLkPyd6aOtxJ/OCCa0pft0ICQ235HzcQchR15z32fdm9tU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721850248; c=relaxed/simple;
	bh=sb5+mSSwkB47WOmhbAFFygsArWKXSFonUk3BbtsXmWU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IhJso1bPPqq12qXlDm9gOUjEsdZg4/exhd3gfN4f5yaJPIHmwarh8dl55gLFFQDtbrjddprACsQz+lxIP5YpWcDQer6eU64APDlm2cnbwa9VFrxX/etkZHrY5weG46iHqGeDZNxXig/zGjPf+y1I45DjnWSGFsW1lqL59CnAtxQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=eM+rD47b; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=VIpqroIJ; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46OJeEmf008708;
	Wed, 24 Jul 2024 19:43:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-id:content-transfer-encoding:mime-version;
	 s=corp-2023-11-20; bh=sb5+mSSwkB47WOmhbAFFygsArWKXSFonUk3BbtsXm
	WU=; b=eM+rD47bX3rNuxA341PWJ7cpeVwcz8ZJXEdLy+pQ3MtMlKyDJqp3MvMTm
	CU2AWq4cIEn2GM9+uP+VodvbBJ1wW57sK09EvB0FZiiTgtyBPr1eddf+TOqe3u1U
	LU71NxCPnHaRfmFYkrWDUnboNXJBvN5iCV3dIosAe1PFgEkkfRH3YdqoTxuMNj+U
	gfZInDgtAHRNw7q6HODboJf4oQYczBpC85zDKQ5jONtfllBMWawqXQB1iEkxWBcE
	vQo7ZuSrO+SVqfe/UGinUVXdLc2DY3L809EbrvKVU3A3Fbi4UAo+NE5muHdmY3N4
	7Bb1NzTCY7Hb/9YnHJp98rrGeKy0g==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40hfxpj21u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Jul 2024 19:43:57 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46OI80nu040133;
	Wed, 24 Jul 2024 19:43:55 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2170.outbound.protection.outlook.com [104.47.55.170])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 40h26pbw8c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Jul 2024 19:43:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n4p45HRG0vKAJ2MTvGghQzF4rgr1oPd/tsIh/+6NkjAHCD8R70//+E2THUMrE2jeDNPEhu/x9r1CWyvYCDX+8x8/HvhN+eKylDG/Vca90qK13f8WvJgR0TLOFpO6IoiovOuShmoTTjhOWoLDoCDd43X6OMB885okbMimBZe8B3HCvRkK1bxfWcsMSci3ELSmnFgTlIRteC+B8OUsu63uxWlG2qjf/Nx4IQAK0d8dHBy3c9PQKGy8WvXlCAoNnNXKS2TLIfIgUo0p7T/EDagGimxw81gpniJMiZLBG/K2KW5hRDITRIq3eNAmZ8DqW+ity8PzOl/nEWuqPu4wjS4Iew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sb5+mSSwkB47WOmhbAFFygsArWKXSFonUk3BbtsXmWU=;
 b=idNhrUajUIXo8GL6zPWF8JVVPfJJqlkJQrggxrztSOB0RBE4FZeCAM8MyB3vXfVZWNw5+pee2spWt5vw2q01HRiPokcceXy1yWy4RJM/DThvHUHh7miSFun0o3z/oyLIWFrMDrN0NGvVRZQldaE7BeyF9c9dOvN3FkZHYi8SpKHlW1a83gecfxjZN3u+CGzmKWy+HWMGf8SYkAXaoKAG9kmlD215VoLJeLL7DUY1ND7vZ5ZqWz0n7yqx3gxWqAnAiMaPb+Kanv51vSOpGp9dzPjeUukfN2WtVqgcaOLoKVJqxwNmzhjwDxjrSIEsZaGDzVUyzUo2zjn6x3JMzs0qIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sb5+mSSwkB47WOmhbAFFygsArWKXSFonUk3BbtsXmWU=;
 b=VIpqroIJdVLP6s9mMzmPOGFeZaTRWTSUos5Y11j1y5niwvrkLDpyMhRMyuP7/nYH1p+gqi4WK85wPAU2Qe4nCNQXvY/oBgW3OShxQ94E/1jPJCNPkEBjmv3CIMZRFNykVHx7c6XyC+eXABdrcaWpYeYy53FqV6H1saX6PGMf2So=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BLAPR10MB4916.namprd10.prod.outlook.com (2603:10b6:208:326::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.20; Wed, 24 Jul
 2024 19:43:54 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.7784.017; Wed, 24 Jul 2024
 19:43:53 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Neil Brown <neilb@suse.de>
CC: Jeff Layton <jlayton@kernel.org>,
        Linux NFS Mailing List
	<linux-nfs@vger.kernel.org>,
        Olga Kornievskaia <kolga@netapp.com>, Dai Ngo
	<dai.ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>, Steve Dickson
	<steved@redhat.com>
Subject: Re: [PATCH 00/14 RFC] support automatic changes to nfsd thread count
Thread-Topic: [PATCH 00/14 RFC] support automatic changes to nfsd thread count
Thread-Index: AQHa1otEhcHK0YOrM0ewES4qIoejsrIGVnwA
Date: Wed, 24 Jul 2024 19:43:53 +0000
Message-ID: <FE431D13-1C6C-4336-8015-8A67EEDC23C5@oracle.com>
References: <20240715074657.18174-1-neilb@suse.de>
In-Reply-To: <20240715074657.18174-1-neilb@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3774.600.62)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|BLAPR10MB4916:EE_
x-ms-office365-filtering-correlation-id: a95bf473-41e6-40dc-e04f-08dcac18f32e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?dW9EVFlxaFA2eWNraWU4NCtDRkRSNG90MGttdUFXQWM2QmJLbE5nc1pVc3pP?=
 =?utf-8?B?dk1oS2Fla0I2OCtnREMreHF4RzZmRTNuRnJOcTBOTVJLTzQrTUdKTG9TUWhT?=
 =?utf-8?B?d2FyWFRrb0ZKNC9NR0cxeXMxTXpESzhkaTZtTUlST2pIUWlPYVgyZStaOU1B?=
 =?utf-8?B?NjZZN0V6MXRLN3dubi9GcmhNNUkvM2wySGN0ZkJUbnFoMzBkTFFCR1dHY1Aw?=
 =?utf-8?B?SHFIZ212QlBud2RrT2ZMc3AvMFpwWWhBVFZ0MzcvMi9LVVZaOHMzVTV1TVVO?=
 =?utf-8?B?RStRN2lhRmUrOVJvcmRQUk9Iem1OS2t3ZHZvZkRGVkcybVErMmFNbm5OY0FT?=
 =?utf-8?B?ZVJPN09FSHFnZFI1N2VnYU1Kb3piOENJcEs3NjRVMHpIT25NRHI1TWlnR1JV?=
 =?utf-8?B?RjdWZGtOdHEwYS9YVkVIT0lYcTdkaFNmUWFnVXNoZmttbnUrV0hBNzB6ellY?=
 =?utf-8?B?RWF5WkVtVlNtV01jYVJKRVpwNytPemZXcXlyK09rOFQxYkU4bnVCcU5uNGpk?=
 =?utf-8?B?bElFTzRXU2V5VlBzRjhnZHBMdWhZeFY5U1lUT0VlWGVXMEJYak1KcU9VUmpW?=
 =?utf-8?B?SE5aWFVHaDBtOXRkdUtFY2J0cUZSRjFEL2NzVXZqbUZJcG94Mjh0WGtRZ3hT?=
 =?utf-8?B?aGlpREdSWkpwVjJMWDlwb1YrUE9xUDhNdVc2NXk0dHZvZFl5ZzdBVHFSRWVt?=
 =?utf-8?B?Rkw2Skpzb080dDZKNXRCSi9pNGNLamRpZzZqZzMvYWUrbFRBelpwaWw1S3BT?=
 =?utf-8?B?VVlYTFBwODdPcG1VR0lwWFl4V1pQTERQWkVJYzVmcStrUDVVSFFlWlNGV21l?=
 =?utf-8?B?aDVoL3RSNDZ6ZytEOUt2c1l0VndKd1FmWHQzN3hiaHY0Z3BQSnRHYmNJUTN1?=
 =?utf-8?B?SmV5eitFWEVlV2VzV05Pbkpnc2hmckZsVWJKbjYyQjlDcXA2RUlDczlMdVpO?=
 =?utf-8?B?V2Y1eXNjVnNtclI1Q2lNN1J4V1dEUmJ5ZzdySms2bCt3RGptZCtvSEZXWGtI?=
 =?utf-8?B?ajQxRFVPMW01R0dmbmtNT1dSS3NCZDRDMFVYNnJHM1BHb0RETHlmMmhRU09O?=
 =?utf-8?B?QXlVd0NBTlB1QjhTSDhVSVloQ1ZMdFMzSVViR3lVc2l2Z2FMdWdWMEFRWWdC?=
 =?utf-8?B?VmRhdHRodkNKRE9KM3dzQXVBbkFzQUtXUFBMbUUwL3FmRXBoOTc5U2FkTkg4?=
 =?utf-8?B?RUV6ekd2NEhucnpUdC85b0hRUlJiOGhCc1FveStGYkV1VURqNWdOYURkQUJX?=
 =?utf-8?B?QktlcTZQUUxvZ1VTeG5uK3J5dzdyTWtrOXZIV1FXN2pKRWI0bU1DUi9WTURR?=
 =?utf-8?B?bnlYMnlWQ0I0eldjVkJxczJlaHY3NXBtM2xnSC9SZ25laUNvNEplSHMyQkp2?=
 =?utf-8?B?TmcyODNYZ3BpT3NYQ1VwN0YyRllJYnJCVDZmNzhUdUhhRTM1NmlvTmx5eXdY?=
 =?utf-8?B?OVBxWTdyTlB2bkhWdS9sbnk4VUU5S3kySHlDQVlWNytRQjB3K3UvcjExdkQw?=
 =?utf-8?B?bnFzYmFoVVpvRzRUckZSeVJ1YVM4NXBWejllUE9WOFp2Vlc5ZndXc3NydHZK?=
 =?utf-8?B?U01ybHpKeE5md0kyeWRseUpTd1haRlMrZzFkSWJQbXljVXQzdTlub0kzckFh?=
 =?utf-8?B?b3o0TVBML2RhNUlod0d5Smh4VHY0bW5xQUJsWG1vRDQyUHozVk0rQlF1eVZn?=
 =?utf-8?B?d0ZYcm4rb0FhQlJtRUdVMHhMV3M5blJpNzBlZ2RJOGc5VFVsUWI5anpOUnB0?=
 =?utf-8?B?OVVCczk5QWRGVVFXUGdPZjVEL3ZXNE5TRmV5TWplV3dXa1VRcllTQk5EWE9q?=
 =?utf-8?B?SHpQQ3NRbExNaVFsZm02RGJqMWFDQmdPVUp0Tlhuem9VT3FGNnB3aWd5TVg3?=
 =?utf-8?B?VnhGdFMvZ0s5TkRZS2UxQUo1eGFRejNheUdTYTR4TXlVckE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?YmZIQis4OTBLUzU5cVR6U3Y3dGJlNlhSTjJ1SkhnZkFpWEUyQzdVZksyWXM3?=
 =?utf-8?B?ZU8xSGVSY0V0MlJVbGNWUkc0bHc2RWVLdzl0SGpKZCt3S1ZXZ3daVkpDUEdv?=
 =?utf-8?B?dWgxSnlJV0YzQlJNZTdVZHh3MG1CbXhPKzI5Qi9aN09FdE5ubmtaVlRvQUFC?=
 =?utf-8?B?aVhZUmhQMC9kVVh3YzBaSTFWVlZYOFNSb2hmb29ac3hmSzJKeitKWk9BUHBW?=
 =?utf-8?B?L0I4V09KdVg2QUUyZStUaWFHMDYwMkdsS0lNam83UnJHOERIbU9NUklPcEsw?=
 =?utf-8?B?TFVQMWx3aHhUOFo4VXFxM1ZLVi93QnV1UXZkTkJBK3doNTlTMm9EMGJCc3gx?=
 =?utf-8?B?VlJPUCtubmpwYkl4M01hQ24veEloMVBzVlk2MW14REs1bkhwN0Y1VW9lRkhV?=
 =?utf-8?B?NkdzUzNsbjJVdGFZcWJ5cEkwOG5vWUdoQk5raC9YcEN1VXBLeUViNEpuNm1V?=
 =?utf-8?B?R0ZweHpZZG93bmM3c3plUkF6YWFkaDIweEkrSXB1WVJVRzhqQkkzcU5KMGI5?=
 =?utf-8?B?MFBUdWRsUU9aQlcxSXJBYk5wYUtJZW5QajhQU0tMZmw3R2MwNXVBS0tjU05J?=
 =?utf-8?B?eHUrZWZDZnc2M2Q4RmdVYzYyWXpPMjlVMFZwTk1ES1UwTUZKaHBxT0VxNWpF?=
 =?utf-8?B?eHFDVWxRaXFUOVNzOE9QTWZ3NmVLc0VQRmxSc1JPdXlINlpNZXVYbjJ4VVc0?=
 =?utf-8?B?WFdBRFNhblpjd2FIR3ZqVlJFZDV0aUd1MWhNcTJMS0xPZ2dDelByQWo3anEx?=
 =?utf-8?B?NXRseS93NXEyWCtlUTlUOUpGdjZWUVhlNmt0Uk5iWGw5MVdsc2FXM1oxcW1o?=
 =?utf-8?B?ZjIyOG8zcXJOOWFMZmNOV1FYZ1hlSmY0VXgwNkh4bERZdU4zNEJ4OU1saWU1?=
 =?utf-8?B?Qk5Bd3pxMk9XYVI3UFZ5b0pLMFNXU2JFeHVLWlpsaGptVWtLaXN5YlF0elR5?=
 =?utf-8?B?Wks5b3czYWx0TkFSMkV5UStSdWlJZ3dqbENaUFpFWWlQOHFHU1o0TWR4UThN?=
 =?utf-8?B?QXRWVzgxOUsxN1c5NGlFNXE0V0NOWFhTWjRDSm05L1J4OWFmNWVqOVhMT3VR?=
 =?utf-8?B?aW04VXZqK3llQjRXTElEWEY4NEpBNXN5OXhLSG9DUTdNMnN1Uk5OTnZFTVFn?=
 =?utf-8?B?ak9oU29LbkYyYm5SZUpKZDhuODJXbHhPbkhMZGcrd0Mzb0t2WjBTNHVOTzdO?=
 =?utf-8?B?MnVxalNibGhwMUxxS2pFVUYxajA3M1NVNUlNT2lkY3M2em5wNVN5VU9SSVBh?=
 =?utf-8?B?ajZsK3lpTXVoK2h1NGpsN1BQZXc4eGgvYXZOOHg0RGx4aFEwakw2djBQSkZI?=
 =?utf-8?B?NWRUenBlc0VWRmRNeUtCZFhOYnNJZVU2bDY0aTVSTmhmaTZOUlVHMnBEOU5O?=
 =?utf-8?B?VmZiMk1lM1Q4a2VwbGJzTzJ2eHhJSURlKzZJQXZrTzFmaENpUng2UTA4bWFM?=
 =?utf-8?B?dmZNWGIvL1BVb1N0R2lVSHIyM1hob2owUkpjRUp1RWtZTWdHelozWVUrOTVN?=
 =?utf-8?B?N2lBazhwZDBEKzYrOEtYQVg5aTJOZ1M5T29QMGhrWk16VUI2YWc3SnJBUlBj?=
 =?utf-8?B?OU5XQWFMVTBJUjdUZkhTaCt5R2NqQUJLNmU1ZDhKRnlJZjlmWEpYcTVQRHUz?=
 =?utf-8?B?bTIrQ2NYWTdLWlBBOExzcGtKSlU0YWVwdXgzb01xVFJPM0lPS2dYRnhQdWN1?=
 =?utf-8?B?UGxvOGwyQWtwN2tqWEo0UkZodjBFKzIvNDFhL0JNN1RFQ244MGdTTkI1Mmhr?=
 =?utf-8?B?NU9xYmNrMzZ0STZheVl0bFcrM0lsdDlTeHhtWmhPc2RFbTIzVHZUQzNaNzZw?=
 =?utf-8?B?STZ4RCtQVFpEb1hNaTd1dUp0Tk13RmVHYURzdTVTdUtJZDY2azJ2UWdEcUg1?=
 =?utf-8?B?V0JMRG8rMFRUNFBxRkErVzZhQnJmZk1JWjdoTFdQSzZnS0NLSDMrTGE0WGp2?=
 =?utf-8?B?VENFMittOW1BQlcyd0JFaitSRDJTSW5UclA5THhkVmwvd3NBYm5WMWVXYitL?=
 =?utf-8?B?SXA2RHdqRGh2MTBidlNaOG4ycjVTcjQxVCtPUU5YWWFHVFhlZm0zYWd2Umpt?=
 =?utf-8?B?ZmVQbnVhak5hZFZYaVhRV1FETElrRWpXcnloRVdIenQvM3FZTW1wRHZKVFor?=
 =?utf-8?B?SUd1UDJWOWVSSWU3ZS9HbVhWam9ZTUpIQmNFRHkzNVN3NFNQUU5yQUdzSWpQ?=
 =?utf-8?B?UFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2DCC73747C9D5C4AA1F53235CC02C2BF@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	KFstqoFWBZ4tpHNVUJZ1Dywx+UaRTrHVgncR7w9geFnhQICUILXgnbaWPsN57xgalCDW4xsbb4B/7qEs/PmvRJAad7nRjQafxkTlp8jvH8TExnA4kk9HYJzzaMczQfnMNkwNn55/VRjb+rJI8xJalKos0sFg7TjdVdLFDDNL+rrIN6rFP4WHpvEKRUgsEIemhIIsDSUFwh/Qjs68Zbce0XJZSLd77nhdOaDQMaMMUzV7BFgATsmfHIfa6OSqK+cqY6aSaG2ekFAAjE2Lp7c5Dg+t4UNpS9FFCCmgQoQyoSSJjS54oEPV++VLxZQHtsUPsi9Cp6Q+LbUbsgwRL7oqSCI44CdzE9TGD5d79DK7KWDAnPjz88LyqJXOWKiHB9iCjeE0bNIuztV6mwYwQ8XCo4vm0Ay9ih8ibW88TRBkkg2MRa+oIQBsxVHRZkzZM25FDGC4Jw+IVNIuAa0bY402479DNifbXHzPDP65ktq4ov5zXpLzBlprh5JeLYnD22tsc/Jg2XeGafumWdSuq+7Q+KlZm8i97p9oVh2NwZM1diIvZIZjNuQDg0V88sEpTrT/9ldww0xe4vT53cYvra5GUqWodFpv40Tr+5iEkYs+dfc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a95bf473-41e6-40dc-e04f-08dcac18f32e
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jul 2024 19:43:53.8822
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QuLDSiahhiHKKRe4yUYWIo6FbFfza3XntgSp3/O50UFgRIftd5hiDd/0UfyzbAApjNxuiastlphlbrtlG3JQmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4916
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-24_22,2024-07-24_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 bulkscore=0
 suspectscore=0 malwarescore=0 adultscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2407240141
X-Proofpoint-GUID: mw_wXqZluMlKn3IiqDAT_lxKUJzjFWq7
X-Proofpoint-ORIG-GUID: mw_wXqZluMlKn3IiqDAT_lxKUJzjFWq7

DQoNCj4gT24gSnVsIDE1LCAyMDI0LCBhdCAzOjE04oCvQU0sIE5laWxCcm93biA8bmVpbGJAc3Vz
ZS5kZT4gd3JvdGU6DQo+IA0KPiBUaGlzIHBhdGNoIHNldCAoYWdhaW5zdCBuZnNkLW5leHQpIGVu
YWJsZXMgYXV0b21hdGljIGFkanVzdG1lbnQgb2YgdGhlDQo+IG51bWJlciBvZiBuZnNkIHRocmVh
ZHMuICBUaGUgbnVtYmVyIGNhbiBpbmNyZWFzZSB1bmRlciBoaWdoIGxvYWQsIGFuZA0KPiByZWR1
Y2UgYWZ0ZXIgaWRsZSBwZXJpb2RzLg0KPiANCj4gVGhlIGZpcnN0IGZldyBwYXRjaGVzICgxLTYp
IGFyZSBjbGVhbnVwcyB0aGF0IG1heSBub3QgYmUgZW50aXJlbHkNCj4gcmVsZXZhbnQgdG8gdGhl
IGN1cnJlbnQgc2VyaWVzLiAgVGhleSBjb3VsZCBzYWZlbHkgbGFuZCBhbnkgdGltZSBhbmQNCj4g
b25seSBuZWVkIG1pbmltYWwgcmV2aWV3Lg0KDQpJJ20gdHJ5aW5nIHRvIGdldCBtb3Zpbmcgb24g
dGhpcyBzZXJpZXMuIFNvLCBJJ3ZlIHJldmlld2VkIDEtNiwNCndpdGggb25lIG1pbm9yIGNvbW1l
bnQgKHBvc3RlZCBwcmV2aW91c2x5KS4gSWYgeW91IHBsYW4gdG8NCnJlcG9zdCA1LzE0LCBsZXQg
bWUga25vdywgb3IgeW91IGNhbiBzZW5kIG1lIGEgc2V0IG9mIGVkaXRzIGZvcg0KaXRzIHBhdGNo
IGRlc2NyaXB0aW9uIGFuZCBJIGNhbiBhcHBseSB3aGF0J3MgYWxyZWFkeSBiZWVuIHBvc3RlZA0K
dG8gbmZzZC1uZXh0IG5vdy4NCg0KSSBzdG9wcGVkIGF0IDcvMTQgYmVjYXVzZSB3ZSBzaG91bGQg
cmVzb2x2ZSB3aGV0aGVyIHRvIGNvbnRpbnVlDQphZGRpbmcgTk9GQUlMIGluIG5ldyBjb2RlLiBN
eSBpbXByZXNzaW9uLCBmcm9tIGF0dGVuZGluZyB0aGUNCnZhcmlvdXMgTFNGIHNlc3Npb25zIG9u
IHRoaXMgdG9waWMsIHdhcyB0aGF0IGNvbW11bml0eSBjb25zZW5zdXMNCmlzICJOT0ZBSUwgaXMg
Tk8gQlVFTk8iLiBJZiB3ZSBmZWVsIHRoZSBjb21tdW5pdHkgZGlzY3Vzc2lvbiBpcw0Kb25nb2lu
ZyByYXRoZXIgdGhhbiBjb25jbHVkZWQsIHRoZW4gd2UnbGwgaGF2ZSB0byBzb3J0IHRoaXMgb3V0
DQpvdXJzZWx2ZXMuDQoNCg0KLS0NCkNodWNrIExldmVyDQoNCg0K

