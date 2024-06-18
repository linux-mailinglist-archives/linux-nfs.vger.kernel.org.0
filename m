Return-Path: <linux-nfs+bounces-4000-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FA5C90DBCF
	for <lists+linux-nfs@lfdr.de>; Tue, 18 Jun 2024 20:41:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF2E61F2335B
	for <lists+linux-nfs@lfdr.de>; Tue, 18 Jun 2024 18:41:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D57915ECCF;
	Tue, 18 Jun 2024 18:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="V8QdEL85";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="gjkjd3Gi"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 739D515E5DC
	for <linux-nfs@vger.kernel.org>; Tue, 18 Jun 2024 18:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718736070; cv=fail; b=CUM0ufMO29g9as6+LcbOQ1qH/gGTyVoxvDcd1vogRT8tvUVwg1MkoIbUR+LhNcX14dcwjYxvTpwkWlPzTTtZXNE9f3UxgVp8ro/jytGFAhj95mdc7B+w1m84LU4zYGmDxGKyhqeBGcwnJ6yefo02i0NEQv6zPJYnzUoyFgYbXuQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718736070; c=relaxed/simple;
	bh=u0N83HWuchU/Cpj+98xY+rDfOshMb1Zhuhz9PEi52Bs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=H5iIJeSrCPT6MfVQt5kLQXnY4idNmWfnwG9+AZFk1MiMZZV688XyLJTyMUnZGYW6lui11ZqN53o/2yhPPkfOBtRXfxNXUX9bN7zlYx+i916RNJHWnxgjTHA9adN+6fk3ZQOGbgj5Lk6fKqLBXvcfoBkjQ/4e1kfNWZISxq/x7fU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=V8QdEL85; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=gjkjd3Gi; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45IIUosJ005340;
	Tue, 18 Jun 2024 18:41:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-id:content-transfer-encoding:mime-version;
	 s=corp-2023-11-20; bh=u0N83HWuchU/Cpj+98xY+rDfOshMb1Zhuhz9PEi52
	Bs=; b=V8QdEL85VYvxRaUtWsBeRMfmOUezfF7qh/T0wXMt/31/jLa+CUcwgZPIU
	c1jCr2HBXeY0vzvN8Ko1NlYKY1HX2pLgonE3Jx2CxxAP5opJQ138SGQSu+IvPRz7
	iN22D20s8o7itAtNRHgZxrv1Cx67Nd7FvbMR6hQJa5Mg9FYBnqJEH00crF4WdToH
	xE7cOgJFE2+dGfnNRNHVaOdUNjC2L261/i/6xxiQeRfJ8Ow7gc+qpGjSO/QEI18h
	AHVPZPwi/moPBEw2wiuqEPfUr9FfS8L3aom/AcrF9E8nMlWt/amsYEYEFOj+Euce
	r4OxXwJ16h0brf57t+rbZf67HgZ2g==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ys1j05q2c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Jun 2024 18:41:01 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45IH8A4v015519;
	Tue, 18 Jun 2024 18:40:59 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2046.outbound.protection.outlook.com [104.47.55.46])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ys1dek8wg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Jun 2024 18:40:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JvsaGDwNG0vSlV6OTW4z5WuQVCiyZ4wVOwMCXxUfgDPsvr0tNcnrE1fYJ38VrHCSEBDugBqq9ze8BQFuy0DsV9EEe7IJBl7vzCFBJZvgDhPmAZv6pSxWQ/Uv+mV+x/Xg5VUbhi3goMGHwZdFgOdqeDr0VLH38DgPsuTcATsTipVeY1R3M4hUBCQZwWWnQEPMHDaDUEo2IVg1i9lNii2XeSsGFcTvddE6oFjfwBKwqPC7QKQg7yga5d8bH5trEgzemkR/6K0PcAUi+OsRSZoA1M6NZDf0D3UDyq08Wimz6rdvgC9p4hxGoOg+pwdmPSHX1PoT5Dxi9ecYwnQhXkIYNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u0N83HWuchU/Cpj+98xY+rDfOshMb1Zhuhz9PEi52Bs=;
 b=VZ6MZFhzMjnbU91e0TKQ6WQHSnOnQ2XjWUterWjU/xtBUJ/e0SGd3NH9c68iGdyr9iVfTmDmVC39t8W1h4kp1HHhoVypc/wx1aXCS+RQPqLnyM5pTpmwE8vxZEGeyVk14S426iZtqSs3ekx1oiv8JUxsACF+mMweTfk7VLFrCsad/FwWwK31cM1hz9oBrwURW1tv5bgFpSHs5EQnBevhLnEaxNX6zMW7a70qfWyg3w2Ax7YlO4arAm0VAsWsvTQpWNqCeosqQvfJB/Fds2H+Mb96R36qsVnFfx6YhqH7cu2x6wX65hgY4hb4l7/H0I9IqCSCKiQM+EDPzz9u1zSc2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u0N83HWuchU/Cpj+98xY+rDfOshMb1Zhuhz9PEi52Bs=;
 b=gjkjd3Gi0bdl234I5WYnxHb5RN4263jgZrmTwKKwLe6V16zO/SIvkvhcoZ8N7hAUdcR47MtCwu6ns0x28lJaWmqitZgcJxQIiREwd2Brs/GnYynH8K9Xc1asdOU9zK5tgI51/n4o2UkWi4tDTIxVxxIdIetRl5NlwjcsnHh7XX8=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH0PR10MB4615.namprd10.prod.outlook.com (2603:10b6:510:36::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Tue, 18 Jun
 2024 18:40:54 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%5]) with mapi id 15.20.7698.017; Tue, 18 Jun 2024
 18:40:54 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Trond Myklebust <trondmy@hammerspace.com>
CC: "jlayton@kernel.org" <jlayton@kernel.org>,
        "neilb@suse.com"
	<neilb@suse.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: knfsd performance
Thread-Topic: knfsd performance
Thread-Index: AQHawa3dybcUo3ed40e1woBUDQls6LHN2rIA
Date: Tue, 18 Jun 2024 18:40:54 +0000
Message-ID: <58A84B36-C121-46F8-ABCB-BE4F212E9C81@oracle.com>
References: <313d317dc0ca136de106979add5695ef5e2101e7.camel@hammerspace.com>
In-Reply-To: <313d317dc0ca136de106979add5695ef5e2101e7.camel@hammerspace.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.600.62)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|PH0PR10MB4615:EE_
x-ms-office365-filtering-correlation-id: 506b0b61-c690-4381-d0d0-08dc8fc62f90
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230037|366013|376011|1800799021|38070700015;
x-microsoft-antispam-message-info: 
 =?utf-8?B?RW5rc2E2NnErMXdjb0F1NDVpeEtRajdacDlWalVzaVBwNkd2Ly9ncTZGVEZ5?=
 =?utf-8?B?VFEzSlc4MlBWd1lxamkxVjBudTQzQUtUMVpaMEtlYWhGTlhiZUwrUXN2ODND?=
 =?utf-8?B?VE9WTFdROE11amluU2tNS3ZsQU9nK3RXZ09mVXN3Y0JzenpBelpxelI0MUMr?=
 =?utf-8?B?YzZ4Uk9BbUxZYnR6SnpwMGpXNXV5bVQzYTc5WVlJb0NRU1IwNmdoSlM0NGZs?=
 =?utf-8?B?SGF2SkgzSEdJd0c2Rm9HaDlWT2NaMGRBOUlFMTJzeU9BTWZuYlZUMDhkZGtK?=
 =?utf-8?B?WEJhZnhLMFVTZ3NLRjBiRk1KTml4ajZ3a1pITitXdy9TNkdiQys1SFBKaVcx?=
 =?utf-8?B?TUw3UUZlNmExamRERisvdm14RXROcXNPcnRNaFVvUks5dGZLYkdMU3BEeVlX?=
 =?utf-8?B?NXZwQit0eEVzYzE3K0JRUEo1TEdzdzRESGZOb0F2cXdoTzZKelNtY1R6Mm5p?=
 =?utf-8?B?WWI1VStGZkFmb2FOS2YwMmFDWFNHZ2NtbkdwZmdBZ2N3TWxaTFprLzhiRVFT?=
 =?utf-8?B?MVJEWHg4TVlhc2RKaHN6L3krbVE5R0dOeEVveWNaTWVzSzY2aUg4dmd5YUsz?=
 =?utf-8?B?TDQvZEhuREdMSFEzTkZpVnV0eEF2T21pYXdRVnozTVlISlA3K2FjbHgyM2xP?=
 =?utf-8?B?RmJqTHRwV2Q4VkhsbTVSa1JTa3kyZ1c0bjUzMGJxNmdmMGdKeHB5NDhjNEFz?=
 =?utf-8?B?dEZ4ZkFyMk9HQllkZWc1VXlsY0ZCMUZQMWM1ZWRHK3NPOU9CWFUvTmxPUEln?=
 =?utf-8?B?b25mc2k5NFVaUWtrMXBOVCtCdTdkd3BXWWZqVjB5ZHVraUtkMVY2NHB4Q2hR?=
 =?utf-8?B?MzZSVVdwbEZBaUtVNzA3eVlFSUxSaGh0VnR1K2FMSmZVS0swVWNmQlFJUDZi?=
 =?utf-8?B?T3lSamk0Z2pxU3BlL3hHODJJbE5iZGFSTGMxM3JYRm01RU56QWNZNkRuN0RU?=
 =?utf-8?B?YlJzWlVrQzJVLzlNL1ZEczYyY0RPU1Q0dkt1QUoweUpPbmZEMVc1NDY3bjcv?=
 =?utf-8?B?bnBUMmF1NVltYTZMVUg5dTBWaW95M0ZnTlQrU2x1NjhyQ2JSNlFsaG0xNzRW?=
 =?utf-8?B?cDRwVDNvQXpFV1laanRxNmkvaWs0allLbXA4NU1qS3JRdnBlQXJRUG05TTVE?=
 =?utf-8?B?akp1blNwQXlJQ0kyOFE0Z2lpZkx1QVZ6cGJRLzZwb0xBUkFnbDRUamtZbGF4?=
 =?utf-8?B?ZGlrL01zTVF1MzBsM0wrOTNycU55M2JsZlRZSXRMSlBhTGNUbEViSjFmRWhO?=
 =?utf-8?B?T3ZVcUFZSVRmU2JIeGVGL2RhaFAvSHA1MWdKZDFDQnRERUwxM3o2MlN3TzZm?=
 =?utf-8?B?QTc2R0ExUkp0N0JxYWN4aTI3d1cyUHNKSWdHbkhFZDBBYlhUbEVWUE10REtQ?=
 =?utf-8?B?dTZjVXM0Qk1UWGdpS2xzVGtWMEoySVE3T3BwaFZnV1VjYTkwUVEzeEU1VEI1?=
 =?utf-8?B?bE96OEZoZzUyRng3MHE4RnV3MGhXOEZwMHJJaHhpU1N4RFM4ZXVDeDJGSGhE?=
 =?utf-8?B?TzJNV0VtbjRnWHFpalF4RmdWQlhMbm9nSzZnSzE0cjFGVkFCbGJMMjNrS0l0?=
 =?utf-8?B?eU1GTGJoTG85NnJDN3NMOG5QamlUUGZCS1VGWG55dDZKcGNVWWlDcW5mRTRW?=
 =?utf-8?B?TFg5VnRGTGU0cllSLzZYQ09STUlRTzZGb1dvOWRxTmtESTdEdXZRaWFuRExJ?=
 =?utf-8?B?bzRXbXZnSjNxczl5ckNrODExVTZ1ZzhRL3oybXpCUE9iUWV6dDlLNTJ4VWpl?=
 =?utf-8?B?MnQxQTI1UTVZMUtjU2JBcFNwUlpUWndPZ2xtSUJwdjQ5RVhxbWtVcXpubjNy?=
 =?utf-8?Q?mh7mvMrtDUX8Lr4TpOmZclKXyiyY/QKlxa9hs=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(376011)(1800799021)(38070700015);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?QVhmamZLUkNyeXh6OWQ1K285Q1hqR0h5cUZudUIzVU5BMEd2VTRLeDRUWWNJ?=
 =?utf-8?B?MUJQeWx1R2ZlOVpPVGxhSVE3VEdQVGZJWUNlaVNUYW5kYmFNSnVkalhIYW5z?=
 =?utf-8?B?NjBIbTNnVUkzNWpCelcvaVhUUHdjZGNqQTVkNlBiTk5zWERBZzNOK0U4NWhh?=
 =?utf-8?B?Yk5yNWVZZmZ4OVRQcmJ2MlEwTFVBWndWeEJiY0ErV09VL3YyTDUyNkM5ZDls?=
 =?utf-8?B?RWVzOVEyTkRDUnFBK1lCcjRCSWNYQTdyWkZNZVNYOGpxUXRVUjJSZ25XbVNi?=
 =?utf-8?B?ZlZvK3J0MktncmVya2VKQWc4RC9LcWNsWjlNMWltTDllbmF0TW1meTc3TkVU?=
 =?utf-8?B?Y0Z1NC9pTTgrc0g2Qjh5RTAxNVZnMEkzTytGYXVvNmp4Mnc5YUJGNW9tRkxm?=
 =?utf-8?B?Y24rNEhEYWxqWHJueElITUxQR0JUcWNHQ3ZwbURzVXNSWHhIZ1RHYUNvSDdj?=
 =?utf-8?B?QWUzTUIyM0MxR0VtR3h0RnNZOUx2Wlo1NUU3aEc3bExoM1RBbENmQUlMS2d6?=
 =?utf-8?B?Z2Fjd0YvZm1FQjF0MVFyOXJ3SGFvK2R4dkV6VGxmSzRMRmgwZHltajViL1RS?=
 =?utf-8?B?MXZJZVlucW0rdEdpTVBFWEdrZTcxa1NqQnRlZHlkaGhZQVFxampGT0JsUWNY?=
 =?utf-8?B?NE1YVFVIcVNyV0orTnFtNFBOK0w2MnRiUmkvSnpONVdsMHgvMHFyeDV3UlpI?=
 =?utf-8?B?SFRYdmtoVnJIR3pVZGk1ZFFyUDlaY2NOTG9DVWFVNjJPOGcyWFkwYmJmbkNo?=
 =?utf-8?B?c2M2T3ZuUkx0NkdvMGdRUUNzb3RXZWNHOS91LzhxZ2FjbDhZRlRvOWdmVXEy?=
 =?utf-8?B?MU95dkkwQkM4UStHclI3RDFYQXFybVJmdUZONWpxcVo1ODBIblBsaTJEbER0?=
 =?utf-8?B?OUhZa0Q1MlAvdGdNZ2N4S1FkQm5odDFud0ZIeVZ1QnluYTVIWjJpYlpiYVd3?=
 =?utf-8?B?c2tHZGpKSjRlbnNOWWVIZGg2OWlaclN2TUFtZ2RYN3lzcjlRUFZmcU5QdCtk?=
 =?utf-8?B?MUczVytYVHFhSlRYWkNaR3J0SVJLWUcrYjkvWCtYVDZnUGk4akhrUjBmcEQ0?=
 =?utf-8?B?YllCUW9oWDMwQUlIOVZZSXg0eTBWdHc3Z1U1NTVxTHExcnRrZ0NOL3U5YzI2?=
 =?utf-8?B?YTBIdDdHV1BLV1hNcGxta2IzVTB1bnpLRE1GSllybXZsY08vcXlyWDdLcnBz?=
 =?utf-8?B?a2xGUTEwQlBHOWgzTk1FdXhMbWk2em43YnpJYklxYzFKNWh5VjlzTndzaGNo?=
 =?utf-8?B?djZrRkhtYXhSdnlRVjZCQzBaVUdhUXkxVHVveExpa2FJNXk0QlpRbHM5UTZ3?=
 =?utf-8?B?VlZReVdYQTJETWVFc2htVFRhQ0R6c0RsdlN2ZThsY2lxUUpDOHBwREkvYmdB?=
 =?utf-8?B?a1JKSkJ6dS9MenJReHdJU1FlMDRqMXVJbjk3emtreHlha0pMVUREZlVxUzNZ?=
 =?utf-8?B?dXNPd20xVU50K2RuWjhDY01kWERkcldPOEVUNnlvLy9pTkQ2Zk4xZXJDa1Fh?=
 =?utf-8?B?T1NuTkRZcmtrMGl3eGNiOU9wUmZCTVpxNkhXUStwbXNQbGRzWmZwL3EzUEsw?=
 =?utf-8?B?TWl6MmhtMXNBMTdtbm1FRDl2L3pUN3lFb0czVnhpck9SZzN5VXhwK1IveGg4?=
 =?utf-8?B?ZFhkRzNjSml0T2dua29kdFhGNVVXMXRBeGd3UkRINUJoYW9CY2x1ZHdaRDBv?=
 =?utf-8?B?ekI0cC95d0RKbk84OEV2UnRQQUxFNkljN2dsZnlwaUtSOWpha1gzWFRzSjdP?=
 =?utf-8?B?MjZTVVJyTlVCbkdaYldPMk42OGQ5WVpyUi9Pc1dvMFFEZTdZUlQwelpDYUt3?=
 =?utf-8?B?aWRMbUFoWU5iY3luQVRnaWVXR3ByNUJ2TStkWnNrOXBsdWtNdEhRb3ZhRzZ1?=
 =?utf-8?B?S0xzZTE1aksyb1NIeU9wcWdpaTZzY0E2UkJLYU5ubzFmeGdkbVJ1cW0wVFVr?=
 =?utf-8?B?Z3g3MjJ5M2NhNER1T2pkMlY3ejBQMFJwdGtuaTV2aVpMKzM4SDlnZGJaT2dB?=
 =?utf-8?B?SDVQYUxMVEJsbGlud0ZtVmR1cXcvRmJGcHlxVXdLZE5aa2lBc0JXZVhCcVRG?=
 =?utf-8?B?SVpKNkZYb3JMYjlJWGFKRXp5aFJCZ1pMcFdyRHVsd1BhV0hVTkpobGt6c0Jz?=
 =?utf-8?B?WkNJdWUrdzhRVHBDaStZV0dValN4ZVNKUkxkaHVFY3hWaSsza0M4NTdRVGUw?=
 =?utf-8?B?RlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E4FE41B072E5C147BA195E80E81113A1@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	WxNJuIj4PmT3x1pIe0NS6y7Zv8FgEYWkafVlgah9fnKy1F5JIdQfrrECeu74G+8DbEKJJTGIfFdBxQAoBV6RCq8jymkoiaEyBbc6jTwlKtuCm7wiM0uAgStUrUiFRsG28hOtZaIWh5lnjWb71m1dH8ZqFRmkJa0m3Ihe+qjNMQ+b0nL0iehZayGH1CS6Dp9P8sH9/Fgtfj3xDz0esX/ByC1w5LWPyg03W9MrLQE84etQEeEMt2J3b3Sph5ft31zYNrvk3UMNLYYDHL2OCTC4DL7EDWdzJUKtldzDzbflJaRix9l/Qcjxjs/00lxZQqO+aSFlviuJl18Q8DHe4ECoUR3D1+EMz8l04maikwGOoQup8XYQJNplXqU8xO5kwPN2Q4wQWJgJxppGuE1sJXt0hmRVmSrP5xdKkkbdck804+axusnu+30VZl/g1QLKZLuJNKWSnWDeI2iXaHVc+rURdIyyof7rk8gFi9rs21EDr3HncasawqpPedgd04u0Na9LWyYxD8fmHt01CHoX0g7v4DjgDSWtOi0JEfqcCWGXACPA5e3IkYe4Jy/Pf5QHwl2KFElDIc98tOB+GFCpumaTjCD4PC+QtxAJdD1ggkX5lKU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 506b0b61-c690-4381-d0d0-08dc8fc62f90
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2024 18:40:54.4032
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Vo/JHvzDHAbMOODp7kdDlp8g5n+tYCuQGcGLwZGCXTwRkn7YzLehkP8UWlLRYghzFaeoivvHtviNz7aZfS/GUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4615
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-18_02,2024-06-17_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 spamscore=0
 adultscore=0 mlxlogscore=999 phishscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2406180138
X-Proofpoint-GUID: V2yxlo-KPyHWw6RWpKT6iLErXh2qCaf0
X-Proofpoint-ORIG-GUID: V2yxlo-KPyHWw6RWpKT6iLErXh2qCaf0

DQoNCj4gT24gSnVuIDE4LCAyMDI0LCBhdCAyOjMy4oCvUE0sIFRyb25kIE15a2xlYnVzdCA8dHJv
bmRteUBoYW1tZXJzcGFjZS5jb20+IHdyb3RlOg0KPiANCj4gSSByZWNlbnRseSBiYWNrIHBvcnRl
ZCBOZWlsJ3MgbHdxIGNvZGUgYW5kIHN1bnJwYyBzZXJ2ZXIgY2hhbmdlcyB0byBvdXINCj4gNS4x
NS4xMzAgYmFzZWQga2VybmVsIGluIHRoZSBob3BlIG9mIGltcHJvdmluZyB0aGUgcGVyZm9ybWFu
Y2UgZm9yIG91cg0KPiBkYXRhIHNlcnZlcnMuDQo+IA0KPiBPdXIgcGVyZm9ybWFuY2UgdGVhbSBy
ZWNlbnRseSByYW4gYSBmaW8gd29ya2xvYWQgb24gYSBjbGllbnQgdGhhdCB3YXMNCj4gZG9pbmcg
MTAwJSBORlN2MyByZWFkcyBpbiBPX0RJUkVDVCBtb2RlIG92ZXIgYW4gUkRNQSBjb25uZWN0aW9u
DQo+IChpbmZpbmliYW5kKSBhZ2FpbnN0IHRoYXQgcmVzdWx0aW5nIHNlcnZlci4gSSd2ZSBhdHRh
Y2hlZCB0aGUgcmVzdWx0aW5nDQo+IGZsYW1lIGdyYXBoIGZyb20gYSBwZXJmIHByb2ZpbGUgcnVu
IG9uIHRoZSBzZXJ2ZXIgc2lkZS4NCj4gDQo+IElzIGFueW9uZSBlbHNlIHNlZWluZyB0aGlzIG1h
c3NpdmUgY29udGVudGlvbiBmb3IgdGhlIHNwaW4gbG9jayBpbg0KPiBfX2x3cV9kZXF1ZXVlPyBB
cyB5b3UgY2FuIHNlZSwgaXQgYXBwZWFycyB0byBiZSBkd2FyZmluZyBhbGwgdGhlIG90aGVyDQo+
IG5mc2QgYWN0aXZpdHkgb24gdGhlIHN5c3RlbSBpbiBxdWVzdGlvbiBoZXJlLCBiZWluZyByZXNw
b25zaWJsZSBmb3IgNDUlDQo+IG9mIGFsbCB0aGUgcGVyZiBoaXRzLg0KDQpJIGhhdmVuJ3Qgc2Vl
biB0aGF0LCBidXQgSSd2ZSBiZWVuIHdvcmtpbmcgb24gb3RoZXIgaXNzdWVzLg0KDQpXaGF0J3Mg
dGhlIG5mc2QgdGhyZWFkIGNvdW50IG9uIHlvdXIgdGVzdCBzZXJ2ZXI/IEhhdmUgeW91DQpzZWVu
IGEgc2ltaWxhciBpbXBhY3Qgb24gNi4xMCBrZXJuZWxzID8NCg0KLS0NCkNodWNrIExldmVyDQoN
Cg0K

