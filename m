Return-Path: <linux-nfs+bounces-7466-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A27019B048B
	for <lists+linux-nfs@lfdr.de>; Fri, 25 Oct 2024 15:52:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2960B1F2426A
	for <lists+linux-nfs@lfdr.de>; Fri, 25 Oct 2024 13:52:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61552212177;
	Fri, 25 Oct 2024 13:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="UAYoz2Yw";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="b9QDUWZp"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 137891F708E
	for <linux-nfs@vger.kernel.org>; Fri, 25 Oct 2024 13:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729864308; cv=fail; b=Kw3EWLqT8SAM4TFvMDKrOyMe+uC2fVjNK+n3e1cdoIGE5ujY92QAK15sE+1KqnNsp3eQA1TfESMFn++H5Iw4byNIS6aSHbM62BUkbhmV1nFKcuK7byw0trU8Zi5hesNiVNT22DWlngvtSzNjadhBf7GgIJUKpmN2e8jXTqqGuNY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729864308; c=relaxed/simple;
	bh=BeX2AhFV/NeZzHXiognk3tJwlTSjhlT8WdumTM6X2Ss=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=r1Hl+TBJ0JRMWrj7r5hIS4N5LtQ/h4+7Sk8t/RWjRfHVh4gYSuz7JRwAc89poefMYzN1559syLrZ5dyGh/6SQFBhFqrKbGeNbUIDOCV2bsxL7QFTkql+EFRI+BwS9NUJAChdtdZlqspWXj8iXsfVqCt/huhtA5S/dUCCO3WOGvI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=UAYoz2Yw; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=b9QDUWZp; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49PDhkF5008307;
	Fri, 25 Oct 2024 13:51:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=BeX2AhFV/NeZzHXiognk3tJwlTSjhlT8WdumTM6X2Ss=; b=
	UAYoz2YwiC1gT0J5GyGd7zBRCFjSakZ4XXWarz9fXMBJgPdbE/sMqgDd/CjvfvtI
	FSXE4qfZzjlBka/AGpexwupmIr8sKaldQ+nBYwlfJMLGseF6Cxmn3QiYKZ7xZIS3
	21uaMsOnDXoEY/l8KbvWvN2gvWz2Gy1CIlWwdWEZcee9pNjQBRF/1CtRraTVquN7
	E/4mhgS3Zy7rT5FU6GHBmgT2/jR1koVns9FwrKMQVit0H19OTl00AsYOGGUGi/sh
	V6joXuUmzXR7Q2jFVXPE5K7sEh/HLWZ7uWfI9yPkGR/FwlBVW+jn9iDVztqPXhG9
	LocJ9HfXY/3PyceFabNkQg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42cqv3m2jr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Oct 2024 13:51:32 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49PC2DMN008819;
	Fri, 25 Oct 2024 13:51:31 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2049.outbound.protection.outlook.com [104.47.55.49])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42g36ah9ve-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Oct 2024 13:51:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=psveO5Y4UcZErDM4TI1ozJiQuLtA4X+TKtwhL4k8cNqn7Bpq4AjbahzRdJdwHUdssX/RyWhX30QjQVkxVJlvpX15MuMVCSPsEFJoWMqSFiFY5cHKyqB+YCew31Q24uHZLeN6gutgYaPVHChsxuPL0tbvHQd9D8wAPGycY1m1PUetqM78tAoPgyIZeV4vslCB1HzkECJ4IU9ocvYD7cVwnWn+VMXPQcx4cQ394ELv276NI4E0FcFpwIJjGeh62VODL3VRzrYQdlLra7T0+4nGDc9PsGH0wXW/fVHaKdl2S1BpRtVixs7bTo0gNJbP8/Q29rutduauwB7Xd/xpXaWYJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BeX2AhFV/NeZzHXiognk3tJwlTSjhlT8WdumTM6X2Ss=;
 b=j63nU4jrsdrrAhpxSqzmfgQbhS1ezVs4tdCxKOlJ2LeGI+/qzsORKiz6ewsT/HP2gdTQW5uwouNTqzxlo71gLMu8zNEkg4byBAPcCBanzgqn4bOVPwcoURwHaEzN5Se7/QbJ0lylxdJMTYz2G2mVA9cIOJs6Xi8HC74XQ/9pPU1Y7Q37g1jKd8+LXZoT/rqBfU4SgIsfYL5bNcld8oTDrrrLkSXtU1qjyIz/2c6ycRvOWAj6CjpMnObHBKHrpxx6SOlWMkio/WdG71z05Nxdm+QaYx66nqq1PNoPvcDvHQxsgY2NKJTUq2wFtKwYf/TEFMxperEu7Z/Z582TEzLDxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BeX2AhFV/NeZzHXiognk3tJwlTSjhlT8WdumTM6X2Ss=;
 b=b9QDUWZpRAb66C/rOmUdcTr9ZOllon03VU49Ums6exJSaQmv+OKCByiysGqv2VCWk28K/PrbL7573/HT7UvTf+mF0/Ng48ixf31ZOW/T4gMh4YVO/HmynHZ+6sd1HfbomVlJGXfq2Syk1QiJOfQCWZGWMGlNjGxto2UhQsuWZkU=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SN7PR10MB7074.namprd10.prod.outlook.com (2603:10b6:806:34c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.20; Fri, 25 Oct
 2024 13:51:29 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.8093.018; Fri, 25 Oct 2024
 13:51:29 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Trond Myklebust <trondmy@hammerspace.com>
CC: Neil Brown <neilb@suse.de>, "anna@kernel.org" <anna@kernel.org>,
        "snitzer@kernel.org" <snitzer@kernel.org>,
        Linux NFS Mailing List
	<linux-nfs@vger.kernel.org>,
        "jlayton@kernel.org" <jlayton@kernel.org>
Subject: Re: [PATCH] nfsd/filecache: add nfsd_file_acquire_gc_cached
Thread-Topic: [PATCH] nfsd/filecache: add nfsd_file_acquire_gc_cached
Thread-Index: AQHbJkZRJKeBbZMiH0yQ9Zrq2PLSGLKWx6wAgAClS4CAAAr2gIAABXQA
Date: Fri, 25 Oct 2024 13:51:29 +0000
Message-ID: <0680D905-B902-40AA-B5E3-B6291FDDA5E3@oracle.com>
References: <20241024185526.76146-1-snitzer@kernel.org>
 <172982525650.81717.5861053414648479623@noble.neil.brown.name>
 <4EDD901C-1CB9-4F99-A35C-3FCBE6F115B6@oracle.com>
 <2ca444702fe535a04adb26df41a9ae2b904fc260.camel@hammerspace.com>
In-Reply-To: <2ca444702fe535a04adb26df41a9ae2b904fc260.camel@hammerspace.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3776.700.51)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|SN7PR10MB7074:EE_
x-ms-office365-filtering-correlation-id: ea103650-00c6-4733-ab31-08dcf4fc2062
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?QTdOdVFNZnJwTVFzRGI2ckhEcGFGazRkS0k0OEIyRnpyYnBrODNzS1dlZ2pr?=
 =?utf-8?B?NWFmcHluL21vZUNYVzBVMlJZVWZRN29JR044QkxlZGViTzUyWmRZdGo0MHRM?=
 =?utf-8?B?aUxaMUNjdGZyVlpFa1FOK1F4aE9LY2RKSkFEN01GQWVqRFNKYk52K0gvVkUw?=
 =?utf-8?B?SVVzN0V5ck1uNDJidXBQVU41V095aThjWkJZWDdUVks3UGp3NHNMd3dwa01s?=
 =?utf-8?B?SlkzaGlYWUxYTXJQMVJGeE1UM2FPNzd5U0YvcWxJOThOYm9xc3dma2U5VitW?=
 =?utf-8?B?WTJUdU1ZU3Z6UUh3ZHA5bnVORkMxdnBYL283dDdXcWxiQzhNdm5SSDRvKzh0?=
 =?utf-8?B?TmVscGFSZmZvUXZnNCtpMmVLbDVWOU9YQXV5c2RzZVhzOHE0R2pkYk1tZE0r?=
 =?utf-8?B?NS9TODJGQmRRWWJrbFhndVF2QVgvOVF4RGFmLzR6REJlRFBZaFp5UWlMNjUz?=
 =?utf-8?B?bFRGcm8vbGZKNzkxbUU0UDRhVDlJSkQ0MlVmQ0l6SmJQbmsva0J4aHBFSC85?=
 =?utf-8?B?YlJNN3lMVjhSRWVQSURWeDQ0bWd1WTNiM1VmeVRJSGJoRFV1Z3NmOTk3dVJr?=
 =?utf-8?B?MzBLSjJZc2M4NjZSNjErSWVRemtoaGtzWWZSOFJ1S3FMZklkTTBteEI2Wmk4?=
 =?utf-8?B?S0w3dUtYWUUybk45L0FPYTRYdkpENGE3TWdMUU5kTnZMTVYyT3ZtUG9TQlVs?=
 =?utf-8?B?SGhuK2dGc0t3RVhMeU1KaXV2ZTlmeDdXS25UOFpKWThZNUZNMi9qcDhHN3RN?=
 =?utf-8?B?S3kyRmUrSWV3c0hYUDhnT2g0aHQ1Z0krTzZKeW9qQ1l1Y2tVd0treFNFNncy?=
 =?utf-8?B?SXcrMXcwN2dhK0lHVjNVR0RFN2FPVmNpdC96MnZHQm1TWTFvRW8zS1RaVkp6?=
 =?utf-8?B?SW1KRnc1enRJTmVGWmI3Y0tkeHA0T3JwOERzcG9WZmU2MU1PUTVxblN0QmlD?=
 =?utf-8?B?MGRQM0RXc0VZeTZETFl5SUxTVG9GNnlIM1J4MTNWYU5vZ3F2WnhXM0l5OVVs?=
 =?utf-8?B?cTFPZTNOeHBJUlpiOGRIeFY5c3NrUDZDQVVoalBac0pWZy8yNVI5NXJtL1J2?=
 =?utf-8?B?MVlkZFJwS3RaTmJ0WkhRclJQaytLbHRLbDFJdHdWNnEzL0NRS2IxMmlTRkJ3?=
 =?utf-8?B?L1BDbW9pTVEvSDVHVUFmdENza2VQVFJJZE8rMVY5SFdJMVlES01VbmlISXpZ?=
 =?utf-8?B?WGdUY3VPblRaWnV3TDk1aW1QNkpycUpTYkxVT1U2WFQvWGhhTnYySzEzMDBD?=
 =?utf-8?B?dGFDNXM2dmtXTW80Um5vSnVKWFdHOUlpclgxL3JRMmpKYnBtVVpoLzJNd05h?=
 =?utf-8?B?VUJ3RmQzNHdwMmR6aVNqZ1BrUFlseWhNY2h2bS9xOW8wdHV2SUp0RUVjNVFP?=
 =?utf-8?B?anhXN1RabENHZ3hVOUtIMTNlMDBaa1lVWDhzY0FTclVIbW9HUDc5WU9UNFVs?=
 =?utf-8?B?QUkyOXdxMXpCMGRtYkdlTjFYbjMxZk0rUnhrVVYyQXFvSmU3K0JkdW4vUHRM?=
 =?utf-8?B?SUJLTmd0MENzZTJoRzR4Slg2Ni9pcFlLaSsyenJRaHdTbnFOWlN2bldVVCtH?=
 =?utf-8?B?ZjY2ODh2cWE4NzVtNVVwRWVvMVBRTG8ybkxrMGQ2QnRwRGJoTWlaeW93RGpy?=
 =?utf-8?B?M3ptNWE1VWJkd1V1ejcvS2NqY0RLWnV2dXNWSThDUWNlVnNDMXZvU2FpWkdW?=
 =?utf-8?B?Y2h5cW9mWEdzT2l0SFRubWhLMDlsb0pnL05jRGJWcGlwaHdiWGYzZlRzTDBU?=
 =?utf-8?B?Q3lBTDF0RXk0SGpnZ2laVTd3OEpvcThTSVJQbG1BTUVSNVMrS2NqbW4xeW5N?=
 =?utf-8?Q?bAcPIVm31sHfuI0U6fQCxRje1Qtq5aDUJg2tU=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?R2lCQ2JRVEkrNS9keUxOR0ZUR2w5OTFUdXovVnZ3a0hscEliaTZrQTJPUEZR?=
 =?utf-8?B?eWlwcHI0Uk5iYjRydW8xMmdVMGRyaDZHOE5leVJGeUd2dW4zd1lYY1lpMjFq?=
 =?utf-8?B?QnZscDM3MHFtZ0VqU2VUVTJtNE8rVEpVZWFPQTdJeFhLTURXYi9qZ1ZoRlBt?=
 =?utf-8?B?NldsSWNaSlB3VUhUN0Vkbjdtd09JSDlLWloyQjFVQ3pzQW5kWEsvNENnZWlR?=
 =?utf-8?B?QmRLSlZ1K0t0VGpyY24wMG40cXJjck9UbG1Rc2svQXpEVmZxcFFmcUVLNkRC?=
 =?utf-8?B?WndUS1M2dE1wZlA1cUlCL3gzOHFYNWJ3TEVNaFRpcElJWUloRCthZ01Ba2kx?=
 =?utf-8?B?Tk53OHM0TG1vTEZ4QUNZaytOWjBqa1Q5dzhKdkJrOXlMb3NtYlQ3UkVwR1BV?=
 =?utf-8?B?eUhaWXFPR09jOTU2NEFIS3pkWjFKYUl6cGNwYVJnTkRHSFRXWjBFYkZoekln?=
 =?utf-8?B?TEdRY3ViUnVMZDlPeUs3bThvallESGJJcnVDWkZHMWhkVVVnNElmVWR2WHpP?=
 =?utf-8?B?NEx6K25TVi83dzJjOHhqcXY0c3JUMFJXYkRsS1R0UnJneVpHa0lSdE9aRXFT?=
 =?utf-8?B?Q0JReGwxNFV1K3pyKzZxN2dwVll5OVg3amJUdE8vL2lsb2hLWGpvZHVoOEl3?=
 =?utf-8?B?V1JESGllR2pNQXlrTVlWQ3hxUE9uRENKUkZsT0dLTlBJWE95MlJvOWx6dXF0?=
 =?utf-8?B?NGtGdXU0ZGdPL2tEMytwUFNYZW84Si83YnJCb2hUcmIzelFiTGhGb2lyak5y?=
 =?utf-8?B?R1l0dUJIMW40MFpEeEZPTXNTMTM2VjJJM1Q4UUl1eWViZjlFSTBLWmYzL1dE?=
 =?utf-8?B?WnBYc1BISWx0Yk5UVzByYVgyNjJvUFptZm9jQldmMG1PVTVDYUZKM0xBLzhq?=
 =?utf-8?B?Y3IrdVRRSEtpbFpkSE5RUG5JRnNaYUdlclV3VUU2ajA0d0FjNncrMFRRbFVy?=
 =?utf-8?B?dnlFNkp4ZWpaNkNFUzNuaElZZklBdEpUbUc5NXNlS05hWmE0TVRxVnVjdnFL?=
 =?utf-8?B?ekk2OEtidFJYeW4yRjZkMXp3VkNzZkFDZ0dtc3M0dVpDd1cxNmVEbThrRHc3?=
 =?utf-8?B?akdUN2w4TWFiUm9QdHRuVktlZEJmZlQyeWRmVUxYQ2VwaW4zY1FTK0NjcFMx?=
 =?utf-8?B?OVNzb3RhY25YUzhFTWhvZjhpWFIrRkloaC9PZExYeXRUZ09nS1FaQzh0MWdz?=
 =?utf-8?B?RDlTbUE2MEU3QUZ4WGQ2eXZQMmdpMjRDU2tKbFhKajlldnJpaWpqRXdKeTho?=
 =?utf-8?B?RG42RmFCRFdoYjY1b1NCMnp4aVhkR3k4MERiOUhqYWFnVU4rc05TWkJrVjZV?=
 =?utf-8?B?Y3RwQWowUWZLZEg0ZTNaWS85djVNZDljS2FQbHV3MFBuWW55L2N4L3hxbHlw?=
 =?utf-8?B?dlVWWFVrNTRWY3VQYlRpWkRKelo3d2tRQ0JxZXB1MGY3L0t6aHFOVWIxeW9x?=
 =?utf-8?B?MEFTamZ4dnIydWVsV3hJTlJCSUQwWVJTVjFnUGN4MDY2aGhjSXBaS3FFRnYz?=
 =?utf-8?B?WnAyaHpxU3BiQ0JsaG93T01GU1duMS9WZi9sOGFMcFdKR1dQTS8wS1Jnd3Rq?=
 =?utf-8?B?MElyT1pYSGNVWHJmd2tzYlk2RktxT0pRZzR6NTZjWFVxSkc4MUM5dERFcXQw?=
 =?utf-8?B?cldvclpRQ3E5MGpoRnJWVGFIaWhHelZ1RXB3cG1IOW5pR0xQcmpLVU9xaTNp?=
 =?utf-8?B?R1ptNXJuZ3N5bEFnaVRTbUtXV0d4SHczSm55blcrVUR3YlAvZ01kVCtlaVlM?=
 =?utf-8?B?ZGZmb1JkUmZiOCtwOXVxWWhnL0I1V1JDMUNtUjJOVzVCUGdJS0Nad3ZYWVFq?=
 =?utf-8?B?Y2hKLzRtaWExWkRtNGxPSHNQSEJkTzMreGl5NG5vdHJOQ1o1ZnMwcDRJeWdF?=
 =?utf-8?B?WURrYlRxTlNWM2Rqbnp4ZEd1R3o1aHZOOUt6NmdvYnFCVXBzaVFRaFgvUVZt?=
 =?utf-8?B?UmF5bEVoVnhDeVJzanZBZFUwUHRYVVlKdlI4cEpwQm1qcmhPenFvSVl4a2Jk?=
 =?utf-8?B?NXcyUDNjVys1bDdMM3VNTjUvR0pOaTZ4ZERSSDhnZHVINU9DdmlvYVk4aWhT?=
 =?utf-8?B?WnpxRElkMmVIL0NTNHNoR2ZjdmVraHNlUmFKNkxobmNVSU5iTHMxTllEOC8z?=
 =?utf-8?B?WWZEREYvOWNJcWFrUEZOeVJ3Nlg0bFAyT3lCdlJhQm5CUzJJSGpSSkZaaDZM?=
 =?utf-8?B?QlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D947E91993B2944FB5D435B455BECD12@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	gMdhjpEKiV/AV01yEcAwQZbTBEtSPNVFL1Afl0upPhZKcVSlkpEWbiG68FhYOO6ja2whP3L2Y8zZNQiYmN3B6ZbNXV6g53n5kScebWQlOlEBnG4cerWVBWssPd+RAddzkK0jKis4Jkxd2+UnvIDtDauUxQL7EzJUD2oJgPW9eKDn60nGDLveptsI9tMZkZpL5GY4+HldjsI8G1AgQ3ln4oQOJaiMJqtssbcisn7hH4r7kZe08KPd0HQcUzVFOqaUiNbGfL9KgynGgypynqYFjTM/6XQ7Ggz8CyDli/vV3wAg9gUVeGAvCdnrcovOq6MFW4Dhpa7XH3iI5er+A4kVkdtQjApwQgHHdki9kheYcDzDkOHNDgHE+Dn1sDnxjkbwIKMPSXPifcs9hX0CGSuTZjP1Peu/twfl9pHhlJ1gyUhbCzGJWEm52eKpcGIoFeImX03bKt8QC/fFaG66AjN9iFcjctCfFfh09jMazB8V69G+Xr1osvfkmd0e7GCoGi/cSj5IDCf+qeBEGabCf4PXEu1ae2bA1jvUTho1Qizn0U6P+mFRh6RpJAPRlxpME4Wckpa6PNMevHwVERTQQZZzU11BIapKC398OjVVCIa/fu8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea103650-00c6-4733-ab31-08dcf4fc2062
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2024 13:51:29.1539
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UPM11LAjvZ9i9QdcX0W8JJtIpuwgNdgbBENfVzfTvxPwCMZvSJLblHV0x8tQj2pNeI8rHGDod2KvicVnvo/AkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB7074
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-25_12,2024-10-25_02,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 mlxlogscore=999
 suspectscore=0 bulkscore=0 malwarescore=0 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410250107
X-Proofpoint-ORIG-GUID: UBtsZqZAS69Xa1tlJmkeZ_xCdTNSmGmR
X-Proofpoint-GUID: UBtsZqZAS69Xa1tlJmkeZ_xCdTNSmGmR

DQoNCj4gT24gT2N0IDI1LCAyMDI0LCBhdCA5OjMx4oCvQU0sIFRyb25kIE15a2xlYnVzdCA8dHJv
bmRteUBoYW1tZXJzcGFjZS5jb20+IHdyb3RlOg0KPiANCj4gT24gRnJpLCAyMDI0LTEwLTI1IGF0
IDEyOjUyICswMDAwLCBDaHVjayBMZXZlciBJSUkgd3JvdGU6DQo+PiANCj4+IA0KPj4+IE9uIE9j
dCAyNCwgMjAyNCwgYXQgMTE6MDDigK9QTSwgTmVpbEJyb3duIDxuZWlsYkBzdXNlLmRlPiB3cm90
ZToNCj4+PiANCj4+PiBJJ20gd29uZGVyaW5nIGFib3V0IHRoZSByZXF1ZXN0IGZvciBhIGdhcmJh
Z2UtY29sbGVjdGVkIG5mc2RfZmlsZQ0KPj4+IHRob3VnaC4gIEZvciBORlN2MyB0aGF0IG1ha2Vz
IHNlbnNlLiAgRm9yIE5GU3Y0IHdlIHdvdWxkIGV4cGVjdCB0aGUNCj4+PiBmaWxlDQo+Pj4gdG8g
YWxyZWFkeSBiZSBvcGVuIGFzIGEgbm9uLWdhcmJhZ2UtY29sbGVjdGVkIG5mc2RfZmlsZSBhbmQg
b3BlbmluZw0KPj4+IGl0DQo+Pj4gYWdhaW4gc2VlbXMgd2FzdGVmdWwuICBUaGF0IGRvZXNuJ3Qg
bmVlZCB0byBiZSBmaXhlZCBmb3IgdGhpcyBwYXRjaA0KPj4+IGFuZA0KPj4+IG1heWJlIGRvZXNu
J3QgbmVlZCB0byBiZSBmaXhlZCBhdCBhbGwsIGJ1dCBpdCBzZWVtZWQgd29ydGgNCj4+PiBoaWdo
bGlnaHRpbmcuDQo+PiANCj4+IEkgZG9uJ3QgdGhpbmsgdXNpbmcgYSBHQydkIG5mc2RfZmlsZSBm
b3IgTE9DQUxJTyBpcyBhIGJ1Zy4NCj4+IA0KPj4gTkZTdjQgZ3VhcmFudGVlcyBhbiBPUEVOIHRv
IHBpbiB0aGUgbmZzZF9maWxlLCBhbmQgYSBDTE9TRQ0KPj4gKG9yIGxlYXNlIGV4cGlyeSkgdG8g
cmVsZWFzZSBpdC4gVGhlcmUncyBubyBkZXNpcmUgZm9yIG9yDQo+PiBuZWVkIGZvciBnYXJiYWdl
IGNvbGxlY3Rpb24uDQo+PiANCj4+IE5GU3YzIGFuZCBMT0NBTElPIHVzZSBlYWNoIG5mc2RfZmls
ZSBmb3IgdGhlIGxpZmUgb2Ygb25lIEkvTw0KPj4gb3BlcmF0aW9uLCBhbmQgdGhhdCBuZnNkX2Zp
bGUgaXMgY2FjaGVkIGluIHRoZSBleHBlY3RhdGlvbg0KPj4gdGhhdCBhbm90aGVyIEkvTyBvcGVy
YXRpb24gb24gdGhlIHNhbWUgZmlsZSB3aWxsIGhhcHBlbiB3aXRoDQo+PiBmcmVxdWVudCB0ZW1w
b3JhcmwgcHJveGltaXR5LiBHYXJiYWdlIGNvbGxlY3Rpb24gaXMgbmVlZGVkDQo+PiBmb3IgYm90
aCBjYXNlcy4NCj4+IA0KPiANCj4gTm8uIFRoZXJlIGlzIGEgaHVnZSBkaWZmZXJlbmNlIGJldHdl
ZW4gdGhlIHR3by4gSW4gdGhlIGNhc2Ugb2YgTkZTdjMsDQo+IHRoZSBzZXJ2ZXIgaGFzIG5vIGlk
ZWEgd2hldGhlciBvciBub3QgdGhlcmUgaXMgZnVydGhlciBuZWVkIGZvciB0aGUNCj4gZmlsZSAo
c3RhdGVsZXNzKSwgd2hlcmVhcyBpbiB0aGUgbG9jYWxpbyBjYXNlLCB0aGUgY2xpZW50IGlzIGFi
bGUgdG8NCj4gdGVsbCBleGFjdGx5IHdoZW4gdGhlIGFwcGxpY2F0aW9uIGhvbGRzIHRoZSBmaWxl
IG9wZW4gb3Igbm90DQo+IChzdGF0ZWZ1bCkuDQo+IA0KPiBUaGUgb25seSByZWFzb24gZm9yIGp1
bXBpbmcgdGhyb3VnaCBhbGwgdGhlc2UgaG9vcHMgaW4gdGhlIGNhc2Ugb2YNCj4gbG9jYWxpbyBp
cyB0aGUgJ3VzZXIgbWF5IHdhbnQgdG8gdW5tb3VudCcgZXhjZXB0aW9uLg0KPiANCj4gSXMgdGhl
cmUgYW55IHJlYXNvbiB3aHkgd2UgY291bGRuJ3QgYWRkIGEgbm90aWZpY2F0aW9uIGZvciB0aGF0
LCB0bw0KPiBnaXZlIGtuZnNkIHRoZSBvcHBvcnR1bml0eSB0byBjbGVhciBvdXQgYW55IG9wZW4g
ZmlsZSBzdGF0ZT8gVGhlDQo+IGN1cnJlbnQgYXBwcm9hY2ggYXBwZWFycyB0byBiZSBmbGF0IG91
dCBvcHRpbWlzaW5nIGZvciB0aGUgZXhjZXB0aW9uLg0KDQpXZSd2ZSBkaXNjdXNzZWQgdGhpcyBw
cml2YXRlbHkuIEEgbm90aWZpY2F0aW9uIGNhbGxiYWNrDQppcyBwb3NzaWJsZSwgYnV0IHRoYXQn
cyBjb2RlIHRoYXQgd291bGQgaGF2ZSB0byBiZSB3cml0dGVuLA0KYW5kIHVzaW5nIEdDIG5mc2Rf
ZmlsZXMgd2FzIGFuIGV4cGVkaWVudCBmb3IgZ2V0dGluZyBMT0NBTElPDQptZXJnZWQuDQoNClRo
ZXJlIGFyZSBzb21lIGNvcm5lciBjYXNlcyB0aGF0IHdpbGwgbmVlZCB0byBiZSB3b3JrZWQNCnRo
cm91Z2ggdG8gaGVscCBkZXRlcm1pbmUgd2hldGhlciBhIGNhbGxiYWNrIGlzIHRydWx5DQphIHNp
bXBsZXIgZGVzaWduLg0KDQoNCi0tDQpDaHVjayBMZXZlcg0KDQoNCg==

