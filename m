Return-Path: <linux-nfs+bounces-7906-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9F709C5AB6
	for <lists+linux-nfs@lfdr.de>; Tue, 12 Nov 2024 15:44:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8D6F28A3EC
	for <lists+linux-nfs@lfdr.de>; Tue, 12 Nov 2024 14:44:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E81F21F7099;
	Tue, 12 Nov 2024 14:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="MgEtNXQe";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="eH3peOrP"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E191A23098F
	for <linux-nfs@vger.kernel.org>; Tue, 12 Nov 2024 14:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731422500; cv=fail; b=B3TlwrCsOmZGhbjkOV5NbjpYfhxZuMfKQuzbNgRjGSps8Dv2dZTlio1/Wf1LS1tvuVXhTC3/4RgO/3usG3HFFLLwdNAXQOjDN4Lo8m20RsCCBJBUPDs3mh3mgIYI04j5FvNM0pd6JabisokHOVpo6gcTwfrnNSlB2uywvQOFSIo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731422500; c=relaxed/simple;
	bh=FGRtsBgQtYXuwdbOIrMt5mhd6aegkq25fhq44X2ohKE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=OgFriScLVG6FcWJ8sc8na5TPFo11KSJ6+T5JLyJQ3EGAEFrZrxtOJoJsCaZMMkkVdS0nKhPkSb0rmrR4CrIoIQMpdGZRysklVm7IBawIDOpFgTWxOir0m7HG/+gC2G1hBFMacfcVGWe2DK3ZnUkNJzBZljV/j9zuE2vrAAlMbD4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=MgEtNXQe; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=eH3peOrP; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ACDBZk6005184;
	Tue, 12 Nov 2024 14:41:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=N2aTl72wr3A/Wj37yk
	1XQp7Jd4ml9e3vsaSoUeaGsQE=; b=MgEtNXQeBO5h/IMsSqvgtG2/jllvoqZXQj
	oyCDN2GyTl2/SByGhhcTA91ookDR78sqQi/h0THPGq+fCkoz6uZs3cg9TZJHHzsO
	PUEQDlLYZKNPy7PE2WXDKYuWFTyOaEIwSgeUZ7WxbKnO4DgpL8unwq/df/GeWHkb
	HwyZllAcEEI5OvdKZ/jtAsEIHJSp/C6KRvRSSzywn8/Ucl2mysR5FRT0FzyAD2WB
	aJpoBcuvVkfYLDcnN+D+a7XbdVs20JUgJujlSADSv5XTYXvO59mTA8g99vef9rDb
	es25PMkNJZFpSPUMLarOXACUjykz6AFY5cT2BsDeCMuIUo4bQJEA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42t0k5cf1w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 Nov 2024 14:41:35 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4ACEX8IM005677;
	Tue, 12 Nov 2024 14:41:34 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2045.outbound.protection.outlook.com [104.47.58.45])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42sx686f5g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 Nov 2024 14:41:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g0/vqE091iHueLbA09eYS6i8XD8fnF0Rjf84Ypg053UWUdAz3gLpSMPPJGh7uCjoBWdndLeKVgJPSt4eBbmQue4EcLAgGSPZl9cmL+2pRt5moO5Wjp71o89umF2vb5JrE7JvHEQybFrclZDaFffLnAUHnIfVt15j5ID8Kl7etLQauvjAAvs+tgRoeBiuqPOWSZnHYoV//vaW73mIlvWSDWmijF1qXSWiJWFz9b82t0KAfaKdIIKFnjqeOPdmecXqLKTnUbflq9aNUerSEkiLUD7bzF6WsvXBXuteewybraMCgU1+3C3GDjdIFt7crXbYTUgEkbILNsANDO0AaLt1Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N2aTl72wr3A/Wj37yk1XQp7Jd4ml9e3vsaSoUeaGsQE=;
 b=o3VpOZ1wBosdKgEjirEVzrc+3f/BlHRf8xIi3pFIsVFOi3PeN14LaI9dtJVsB+ZACpSOW2A4uLukKA9ACq0oPOHl5e+wK3OIsiaLwBzgL+Id4r65vArVrxGsg7ij8AflAUaMKKxUOHf7+IZVbC1N/4ifU2ZtHuMoNrxiCrEdqvE7zYtvDBS8jq2rnA3BlYNw+12vlvFRcYOxHuIx51gr3hEnNiFsYs6uJD01p0V1ioB5Y8I0WlazHLnJ4BRisps9GHAo4Bt54QIlVEkjgbOw7zyqLkMRKWoF64XSRetvmL0ylg0rVBtj3zZRLHQg2Zk3Ugqk4XFglwnbVXsEbS5Fjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N2aTl72wr3A/Wj37yk1XQp7Jd4ml9e3vsaSoUeaGsQE=;
 b=eH3peOrP7uHzHvY2S23k3a/7ZFnL+F3aDr7ZZvLb4bI+rorzWKNH+f5HhE6C9Rj85GARkmL4hwSjO7a5+MU74DNHm+mq75KtiA/1UQXFO/zW/Yyvu4KjBYIXTg3EK3qfKLnZ+8WdtORmY3+jLiDzfb9JSF4G+n5zR6dF+lLniI8=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SJ0PR10MB4623.namprd10.prod.outlook.com (2603:10b6:a03:2dc::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.29; Tue, 12 Nov
 2024 14:41:31 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.8137.027; Tue, 12 Nov 2024
 14:41:31 +0000
Date: Tue, 12 Nov 2024 09:41:29 -0500
From: Chuck Lever <chuck.lever@oracle.com>
To: Benjamin Coddington <bcodding@redhat.com>
Cc: Philip Rowlands <linux-nfs@dimebar.com>, linux-nfs@vger.kernel.org
Subject: Re: Insecure hostname in nsm_make_temp_pathname
Message-ID: <ZzNpGZ1mK8lUo4St@tissot.1015granger.net>
References: <6296a7d4-64de-4df0-893e-8895e8ec36d0@app.fastmail.com>
 <192D38BE-BC46-4C8F-8C01-89EED779E77B@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <192D38BE-BC46-4C8F-8C01-89EED779E77B@redhat.com>
X-ClientProxiedBy: CH2PR05CA0054.namprd05.prod.outlook.com
 (2603:10b6:610:38::31) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|SJ0PR10MB4623:EE_
X-MS-Office365-Filtering-Correlation-Id: 506972f5-a3a9-4439-3271-08dd0328194e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CTmkyRGRzuUz8dhD0KeDSf3IRzp33b9MPXdvC9iCbHlZgO1Pz5eYP29NjUAl?=
 =?us-ascii?Q?RA6DOhvqU/OeuSDg3EJ5YV32TFG3UhZw0J7l9skF52z7adzkQ/HBNKZWUfBn?=
 =?us-ascii?Q?AIXn54aJR0/Yq7apOJGdkyXTPcQUzo1mFqD0TEt3d3Sx/w6p3F/hgNWKGNdR?=
 =?us-ascii?Q?fw0fmhJPEV3j9mnRBPAqzlB+cbevp7ouPDOBIlzDosHZtnEKPPTHpqKitTxP?=
 =?us-ascii?Q?BvdGQ/itCutaLEdM0NSODchzJr1IRV13XIIWDQnSgmUE6eeZn8bevZUvRUvx?=
 =?us-ascii?Q?l62aFPyEtJxDtrCG0XZcn7mcjNoB0cJL3UAGUr9lk9jUDd4RSSnz1ZcQJRJ/?=
 =?us-ascii?Q?lyssL7R7oAZttajIc99oT4uEErnjqaVsSF9Ev5I3vPYbXlXvclHhLhbKTgd7?=
 =?us-ascii?Q?yXaGX6lXZnB4X0iJ1sbW7iwEmL3pk7T90DnyLALgmmYXNkhWQMwj4hQr8LWZ?=
 =?us-ascii?Q?OMkjBmoORIfLMkI5pLnewL3lCa0EVAwyqT9mV2Aji38T0hCHw8i5muzQ2ww6?=
 =?us-ascii?Q?dpfK+u6dy5psHqr/EbZmg3yT+baL5SgD39e2iR+E3zGyggVIlgae74wTqBpX?=
 =?us-ascii?Q?bm8Zal0uAeczEimJpbAxCEyXkciNwflxWFS/7oKz5vo0NzuQipVX0qvq8Q8S?=
 =?us-ascii?Q?HqKAx7bJVsgRlNueb+nkIfhidc0rSD3B3ZH8dLtZS7Q0qJLQ5IfkRTZpMge1?=
 =?us-ascii?Q?L0TbAmUM/sOzA8/+jtQP/+cE0CxBJJOtLVd8LubU+YpUksINnkpBRDMKXmNf?=
 =?us-ascii?Q?J25uuGYFdzRExdRG/Rei2ex0qBR06ro+x116ZgmpcPpuv5gTM+6zanEUHBmA?=
 =?us-ascii?Q?qQW3PC+sRjx1QUoSlBLS0i+2BlyLpQRO34TQjvsbXkq9fgaPBBA5BDeeJXXA?=
 =?us-ascii?Q?xitvlhYFMxCQSq5t1P2uemji2Jvty3pzWb0Wd3SOem53UuXfc4zkVgCvBsvv?=
 =?us-ascii?Q?oJYlQs7F9dyCfmGcmofEgxCB7A+A1jkFvYFYwI46VjBajO/r8hzu9fcF8pUj?=
 =?us-ascii?Q?rZ84UwDXBcJyqVPkqgC28VIlELneuWO2LUjASoFxyhmXxNniPLMz0UnGub7z?=
 =?us-ascii?Q?PDa2rLvGeCGpL7uLVTdpy6Uu10Qtj9atv9bMFc6jN4dl8sQZ2rYESYsDhdEc?=
 =?us-ascii?Q?Sp/NJwQngiMG66+2oUfJmdStQnNh/Ao7FXfOR+L4pAksZ7v79flJuWI1DONM?=
 =?us-ascii?Q?ALFSB+KFnecW1d6YNXSMzlEn6QmdNL0hGGG6zn3QGVKse/R0K1sqxwzCFZV1?=
 =?us-ascii?Q?hFZhuVdiyU56VjgsueiN5h2I3c96tgpG/7x1GYwFwuzzChOPH/gvtisrAs99?=
 =?us-ascii?Q?/4yT7vpia2Ytet9DZnqZ1tAi?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AvCHXaLH3FJRgd9CsoZDsUmF4qx9m15atjgixeccIQE3IhR6cDTK2aVeiDwj?=
 =?us-ascii?Q?teNkNSGarcQOWyPHx3eyYrpm6qtl98pvhBGFUHjOW9srpPRRswrd8ZBzmZ7L?=
 =?us-ascii?Q?orLvkvTnaoKx7zd8YOUb7cSGlXFiQzF0IayDip3UwkeW43iPLgFzkfVQMHFC?=
 =?us-ascii?Q?75v+vVGzbeanUXPMhD/oCAROs3oW6OZ+kD+4/enC77wwO8IBBr3TKB4Ei01T?=
 =?us-ascii?Q?K20RnGsPwVetz26AMsXAhQJDqQYG5jR4lXx77VLqY2dPrM2swFtwCHXDDEF9?=
 =?us-ascii?Q?mhByN1WJVSsiE1Q4D3J43YPueTxF1/RUbt10+1NwwhNevHzjwRkjNTpxh7iI?=
 =?us-ascii?Q?SrjGiUQH0EXQh93+sBZWqPsKq4YnHxO21A08gpv5ZtCgrIBcnuvEg4txSQmf?=
 =?us-ascii?Q?eHOGitDg9c5HxucLoNqngGXy0HkNpNa3vEfeQcNkbbXXZjdNar750F1hERtv?=
 =?us-ascii?Q?+uLVRzpG690mGP4SG7sWpeABBofyu2ijGmpWFCRLOUknPaTvTkBCkktHUWlM?=
 =?us-ascii?Q?o/FyeCTrvu9qEsrAE5oYvbGAp3rU5LxXFEta5Jtp83Wdo/mzUTcVq8WGCA3U?=
 =?us-ascii?Q?KGjklIna+Y9yLtupjP7cG01eVSIFIhAbXD2Ch2lspFLmFKaPLjiD8waHX+Q3?=
 =?us-ascii?Q?5hJBqwtun+74HoK+hQbtvmigx0MWE/mL7TDBi8XUzmTWZiQt0T27dA3DwXfZ?=
 =?us-ascii?Q?Y9i65OzKausNNWdGUzNPjZJS2qUUphp9OeA43brH6K1GUWQVfAHoHYo8W7Mb?=
 =?us-ascii?Q?3aTb7ETETwrXbHaZhzAz9FAODPo0DoGkpYFOnozgBVNq3aZeNhv5uWY0a1Aq?=
 =?us-ascii?Q?g4kpAalacvxqNstmDW2IjODNhOHT4BGxJDfG1x9nkJt0sO9aeccRDNDRjM4n?=
 =?us-ascii?Q?r17lQvokHQosZvysjgJI45QMwkoKJ3w/6y3Nims4oPS5jfmMpIKRppNVhG5z?=
 =?us-ascii?Q?au9WCCO6zAGKTVSnIyidqHvCI8m2f1S3hzqHHlssvozJGLiJUhm1hk/eCxwD?=
 =?us-ascii?Q?NgH7gTgZt4Z7mgekDJWeXcp4BnBaVdHXhzOylVzwTIlXft0vkzWf0fLjeESk?=
 =?us-ascii?Q?YNKx5w2e2HJao5sTyUMUf6PkY7J40c+VAPJTHTHlOJntIhh3Q5XABeaPb4rH?=
 =?us-ascii?Q?nFYqq1MY+n+I01Q4C0O5/mUQO2A9bLLH6ZC53hZ8paXXNIN+cJL+YcNGdsXD?=
 =?us-ascii?Q?NGmpQDYcomityTcQAVGv2wxlRTaTfeDDLXI9Vcvibmi5Z/iUwaKENuAdtv3G?=
 =?us-ascii?Q?/czNkeErxC+gBkwWow2WwEEdm70LLUYq+fbTTxO0Clxxg62qYtQ5shI3yIwz?=
 =?us-ascii?Q?Z7rtjuuY3bxUqrRb+Hna3U6X7+27pXL4sV+JQraqdP5WMHXx3giXKmZdGI2j?=
 =?us-ascii?Q?kGqTVbZDeENZF+JymjHCPnsicquA5xHs3uyeXXg/Fz6qOmv2TDMHZ4eO33NJ?=
 =?us-ascii?Q?rYgypwi4h29Huxv9ZhemSX11Qhg9zHA/e8WPO91FTPZ3ZEA1qL/vtK6V8A8b?=
 =?us-ascii?Q?OXXecIeT0Ij4hyQb8P9H93deR+L0h1rG1bq0f48jgRBC4Hc1CI75xsuOdMPd?=
 =?us-ascii?Q?7l7+gPjSzKB4nXjOz/lTRGtIda+8ImsxLqutt89d2BhxQ3hD3V6FRzxYIEIi?=
 =?us-ascii?Q?Cg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	DGhcypXNPDrO5XzLtFFLJp3CdsRhtQz6DLfohJrxb9q6dSG56g8lhOmNlU04dKXjM5HoFaS78uCmIirDzVspDGN6kSSaIk6ssb647SbKXjaKKoB7rc/rWwSKk7LgutgRAgTO5nrHIZ8O02SF15riUFZ4uCwT2UU4G/cqVJEBqONB50Kzkb51GPXCMpyQfv6AbW8xwLvhXJexL6zatiMejPHk0fRuk5DWWIt3CO1gebLBHwuBwEK/xDctOt23l+7wLV+vN8CW7ASR8f3bI90GcKY/qywWgTF6ygWNwB0Iya5AOFQkcRHKf74XR4lJnQ/jc7KXOSSXW5a4y+aOyW+U58m3tE5d/TGz5sb1Y7hyD7KBuaxOUbyBtDkkgvL1xJm2kFYmP1ODASCA/E9mRPsXEejL6+phSph/Ws9vCFAORZ02/NKr5TccI2RfyeYb4bJDyZMwzfJvQ4xSB6jy54fJuf7nRC0dbZ9HGbAF4qRNRut2tY7GSNgJOjX5ZWJrtJDqbd7JRRE6jlbUPbcfV6kPOTBaptvne9xdFAZooLV36GDXSvjcl2hDVi1irtj+JPZP7Tq6G1pHXPpbWBIKFktg2fuiZv+0ir5WWEjmYKPewyM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 506972f5-a3a9-4439-3271-08dd0328194e
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2024 14:41:31.5696
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yKuUomQsltMXm5Qeyt7UuV68TpP1ptjLFFDd32pgZxlos05UQRDYHPiTi4UonsK35oVfSdFg4FWaif99hqTK/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4623
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-12_05,2024-11-12_02,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 spamscore=0 adultscore=0 mlxlogscore=999 mlxscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2411120118
X-Proofpoint-ORIG-GUID: FbVJv1IReO9KlLhY7JUacLLVF5CCo4OF
X-Proofpoint-GUID: FbVJv1IReO9KlLhY7JUacLLVF5CCo4OF

On Tue, Nov 12, 2024 at 09:27:45AM -0500, Benjamin Coddington wrote:
> On 11 Nov 2024, at 17:49, Philip Rowlands wrote:
> 
> > If a host dies after nsm_make_temp_pathname but before rename(temp, path) we may be left with paths resembling .../server.example.com.new
> >
> > Some clever person has registered and installed a wildcard DNS record for *.com.new.
> >
> > $ host server.example.com.new
> > server.example.com.new has address 104.21.68.132
> > server.example.com.new has address 172.67.195.202
> >
> > You can see where this is going...
> >
> > Our firewall scanners tripped on outbound access to this address, port 111, I assume due to NSM reboot notifications.
> >
> > Suggested workarounds include:
> > * explicitly skip over paths matching the expect tempname pattern in nsm_load_dir()
> > * use a different tmp suffix than .new, e.g. one which won't work in DNS
> >
> > Steps to reproduce:
> >
> > # cat /var/lib/nfs/statd/sm/server.example.com.new
> > 0100007f 000186b5 00000003 00000010 89ae3382e989d91800000000dc00ed000000ffff 1.2.3.4 my-client-name
> > # sm-notify -d -f -n
> > sm-notify: Version 2.7.1 starting
> > sm-notify: Retired record for mon_name server.example.com.new
> > sm-notify: Added host server.example.com.new to notify list
> > sm-notify: Initializing NSM state
> > sm-notify: Failed to open /proc/sys/fs/nfs/nsm_local_state: No such file or directory
> > sm-notify: Effective UID, GID: 29, 29
> > sm-notify: Sending PMAP_GETPORT for 100024, 1, udp
> > sm-notify: Added host server.example.com.new to notify list
> > sm-notify: Host server.example.com.new due in 2 seconds
> > sm-notify: Sending PMAP_GETPORT for 100024, 1, udp
> > # etc.
> >
> > tcpdump shows the outbound traffic:
> > 22:42:31.940208 IP 192.168.0.131.819 > 172.67.195.202.sunrpc: UDP, length 56
> > 22:42:33.942440 IP 192.168.0.131.819 > 172.67.195.202.sunrpc: UDP, length 56
> > 22:42:37.946903 IP 192.168.0.131.819 > 172.67.195.202.sunrpc: UDP, length 56
> >
> > The client statd was artificially placed for the purposes of showing the problem, but I hope it's close enough to make sense.
> 
> Makes sense.. yikes!
> 
> Maybe we could just prepend '.' since nsm_load_dir() ignores those - Chuck, you were in here last any thoughts?

The problem with a leading dot is, of course, the file becomes
hidden, which might be surprising to administrators who are trying
to diagnose a problem.

Note that a domain label can contain only the letters A-Z (or a-z),
the digits 0-9, hyphen (-), and dot (.). So replace ".new" with
something that contains an invalid character like ".<new>"


> diff --git a/support/nsm/file.c b/support/nsm/file.c
> index f5b448015751..eaf19cd4963e 100644
> --- a/support/nsm/file.c
> +++ b/support/nsm/file.c
> @@ -185,9 +185,9 @@ nsm_make_temp_pathname(const char *pathname)
>  {
>         size_t size;
>         char *path;
> -       int len;
> +       int le;
> 
> -       size = strlen(pathname) + sizeof(".new") + 2;
> +       size = strlen(pathname) + sizeof(".new") + 3;
>         if (size > PATH_MAX)
>                 return NULL;
> 
> @@ -195,7 +195,7 @@ nsm_make_temp_pathname(const char *pathname)
>         if (path == NULL)
>                 return NULL;
> 
> -       len = snprintf(path, size, "%s.new", pathname);
> +       len = snprintf(path, size, ".%s.new", pathname);
>         if (error_check(len, size)) {
>                 free(path);
>                 return NULL;
> 

-- 
Chuck Lever

