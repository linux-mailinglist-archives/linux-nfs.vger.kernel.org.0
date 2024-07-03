Return-Path: <linux-nfs+bounces-4604-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DD4E9266F3
	for <lists+linux-nfs@lfdr.de>; Wed,  3 Jul 2024 19:19:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B90ED2858A4
	for <lists+linux-nfs@lfdr.de>; Wed,  3 Jul 2024 17:19:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2832D18C05;
	Wed,  3 Jul 2024 17:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VBM1CEKd";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="K/dQFWug"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 641A918509E
	for <linux-nfs@vger.kernel.org>; Wed,  3 Jul 2024 17:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720027173; cv=fail; b=iCtl7ErBMkKtaHiLRd6prqbVSLUKlEWUBrdRL7xzgX3BuNrIlipqNZsjJyOuedsvnyvWg9fOYryXmivmGsP9Q4OOLBYILPgzEJQF7DiYri0I2CuC63gPDukzez2Fzw8NXyZItzIDwvmVuc56RO0IrAdJKT3DqpVdABI8Z6N32fo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720027173; c=relaxed/simple;
	bh=jgxYpaQTbReHNYpoJMY9YkvTnpuQbNb8xMd0G6azkFM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nrQWxom1u9IFV4tAsQaOJiZvlEj4ZrgnYlwGWdCU/k13LZ3uRKonXrTswqzer9j4umvG81CwFKPZoG/xL5+d5niSfUA3BKmitSkH0c6gFR3uHOeHqGJerXWqYstlFCBxzVcbnQhCwGkJkyUMG7fZE5dP9t2Ul6V9Lv9pHud19Pk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=VBM1CEKd; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=K/dQFWug; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 463FMWLG006447;
	Wed, 3 Jul 2024 17:19:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-id:content-transfer-encoding:mime-version;
	 s=corp-2023-11-20; bh=jgxYpaQTbReHNYpoJMY9YkvTnpuQbNb8xMd0G6azk
	FM=; b=VBM1CEKd56Ga39u79qOwSyRv9LwLCXIlIjBph0Zr2VmTcMY0748326mCj
	ow6nTZ4rpmzduGjVn+QkIyUdG1guvBMbZnqFw2Q0FcMWzS3/cPFwuENo+vW/O3Lp
	26MRfWSO8PNslVFFBYWwnDeT5RWbhRKKrHBRmFOQBClovbo62L11AS/zk2Oj7Q1I
	+znPDZmG5+YuylgIURcfD8km7Zaf7Zxmdbn+lf02OdxLc7ehjQ0faugsdzbKoQgx
	ksXsqpPayGBhwPZQ23yw/NXCZKUlyZPyw0s81KlUfN+ac7ykROJG648lnxSR2hD+
	g8d14/E/KQSk15S/ijqfK4NRV0KHA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 404nxgj86p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 03 Jul 2024 17:19:17 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 463GVm3W035751;
	Wed, 3 Jul 2024 17:19:16 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2168.outbound.protection.outlook.com [104.47.73.168])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4028q97ptv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 03 Jul 2024 17:19:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hhynVYVIgtCRS3i7feqd69+lo4IoJhRk4cCM1fuULG964PoqpOWHsufmXZVKPGv5TnoPwOmbV54UD1CeflAbTF0mIoIiUFX00TqR58qgFXgRzYxqR8H8qheVdJPr19SuJNA85WOiu0DVHB9X6fXemwTKPUhY3hA3CqWfC5rFAj4UGNuT4ToUxyIPdZDGxl5P2Br/J/71ImWKqmaFa8ophK/qKxI0I9L3pe3KO1Ka4lQWQBPo03/SxIZ0w4NhzYg4/tylbXK5mgzzQORIuXa5MG58j+mJcQBoKyhfAuzpUDIZJR4bgtZO2t/FxIKiuk+qrteHpZh/DpvdP9Etyqmi3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jgxYpaQTbReHNYpoJMY9YkvTnpuQbNb8xMd0G6azkFM=;
 b=Vs02lq/2QwBiijUxMCvzWnJtXHZv77bMD20SaOIoGYtNf9+hg6cLMCAmprXEyt55/gwXmt3pA9br71jBRtbFlYZy6sM3uKjkGV+5akAXfOpzcX/PgDbHPQaDQW46IKu6gn+LT34HLkORlquM14toa+snDcW6HhVrBrl51ligoYB2b5EJTKIsG7upwHuX+S5snbOh0LEUuvdBi7FSfG1xDfKfXLycSD6LNYmwDkafLMog0JvYSkoEODhnhOLquZ/VPxX/ZJJEJl5mvnTRy3IJ9XKV/Jcdo4vmyTAE5ybwtlIsXkJTjJVkujUrgVGKBD4f1Wp1ApQrvXDxylW+V7TuUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jgxYpaQTbReHNYpoJMY9YkvTnpuQbNb8xMd0G6azkFM=;
 b=K/dQFWugXMaD5CjEkw2ZfN6niEeemNlurCPyxLiCdfXqhGRfu9hXG+vmmD9mCTOItSUJi6tp7Jgz4M/0CET4tmjk1gyLM5MvB3aEnAz0yrkdOb9Bt8EPHhyon4pC+Lha3VH9xytGaoEaEHYhVP9ygEmstmCPnK1H7OQGeYfGnho=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by MW4PR10MB5882.namprd10.prod.outlook.com (2603:10b6:303:18f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.32; Wed, 3 Jul
 2024 17:19:06 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%5]) with mapi id 15.20.7741.017; Wed, 3 Jul 2024
 17:19:06 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Mike Snitzer <snitzer@kernel.org>
CC: Christoph Hellwig <hch@infradead.org>,
        Linux NFS Mailing List
	<linux-nfs@vger.kernel.org>,
        Jeff Layton <jlayton@kernel.org>, Anna Schumaker
	<anna@kernel.org>,
        Trond Myklebust <trondmy@hammerspace.com>, Neil Brown
	<neilb@suse.de>,
        Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH v11 00/20] nfs/nfsd: add support for localio
Thread-Topic: [PATCH v11 00/20] nfs/nfsd: add support for localio
Thread-Index: 
 AQHazJzmgcDeJH7XRUCD8QiVhiofhbHju8AAgAC4HQCAAD+aAIAAWoOAgAAPdYCAAAG7AIAAAbOAgAADUgCAABzCAA==
Date: Wed, 3 Jul 2024 17:19:06 +0000
Message-ID: <F5BE7C26-9E43-4514-9E5E-2B6F7B32569D@oracle.com>
References: <20240702162831.91604-1-snitzer@kernel.org>
 <3A583EDC-519C-4820-87E9-F4DC164656DB@oracle.com>
 <ZoTb-OiUB5z4N8Jy@infradead.org> <ZoURUoz1ZBTZ2sr_@kernel.org>
 <ZoVdP-S01NOyZqlQ@infradead.org> <ZoVqN7J6vbl0BzIl@kernel.org>
 <ZoVrqp-EpkPAhTGs@infradead.org>
 <F1585F6E-8C41-4361-B4FA-F9BD6E26F3A9@oracle.com>
 <ZoVv4IVNC2dP1EaM@kernel.org>
In-Reply-To: <ZoVv4IVNC2dP1EaM@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.600.62)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|MW4PR10MB5882:EE_
x-ms-office365-filtering-correlation-id: 4a09305a-de43-4976-7ad2-08dc9b843e50
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: 
 =?utf-8?B?TWpWZjYwV1V4RWg4WnhQNFlHWmc4UC9zenkvWUordUtDRFVBeWJPZklkTDgv?=
 =?utf-8?B?b0FJdkZFVEIwa2pwN0drNnkyMlFBSW8wYzNYMHNYRHRlbDhuRFhTbmppbDZD?=
 =?utf-8?B?cW9OS2tMQ0F1b3UvOEVOWUJXcndvbGR0aXRNVnJ5U2s0N0RRb0IxRFh5SnFU?=
 =?utf-8?B?V3hvNGZDUVFjQkp0blRoQTdEaC85S2NmMVRNVGFzeW43cll5ck5lS3lkZzBZ?=
 =?utf-8?B?OGhIa2E0TXBXc3JuY2JQMW5VSE1DcXhOZGtxSTNXNHRtNXE2a2pMNUtsNXdD?=
 =?utf-8?B?TXVXY1o2bWd1ak0rbDhZTStrMVdnVGd3eXpCTUwwZ1ZyVVdleUwySERkU3lE?=
 =?utf-8?B?WEd2aWFkK0FkTWJWeDY1a29TV1M1alc2VWFHaTlEZVdYNmZEUlMyaHdvNW1S?=
 =?utf-8?B?ZGpzS0VOOE10UEJOWU0rN0pBekFVN2E5N1NZaGx0OFdYWGlhcWJxSy8rVTh5?=
 =?utf-8?B?L2dIRUpYdmp4c01Qa3laWHcyVnZVU21XbmJ0UUp0anVsWVZWck1rcW5aYWxp?=
 =?utf-8?B?T0cwVDU2ZUlwMWNLcWdIa1BybDBEQnBaMk1Qako4aWZMWUI4N0Y3bWFqamEz?=
 =?utf-8?B?aHN0U3BkWDJJOGs0ajhTQUQ4cm0rZGpNVC9FcXVLdllzVEh2eFNDaXQ1Uy9I?=
 =?utf-8?B?L0pKRWtqTEtRdUdHM0RUdjBITDZOaElpMjRCUDJNYWpwS1Jlbk9TNUdVVzU0?=
 =?utf-8?B?TU1SbjNuMUpneDRWdjBCaHhZN3I2MDNxellqUjFFQlI2ZEd1TkY4djFyYnRK?=
 =?utf-8?B?WmgwbzBYOXBJbldieUdCc3VzN3YySmtsb1pYaXhxNU95dk5kenZyTXhrSjdZ?=
 =?utf-8?B?dzltK3F6V3MxTTZPaWFMYkZZaG9LVnZKL1NaZkUrZjhnN2pMeGE1Q2JLa3Q5?=
 =?utf-8?B?QmpmQ2ZmdUQrRndUb09vbUdTWjZEaWpNUExMNlh6T1BtaFlOcGhNV2srYXVR?=
 =?utf-8?B?allRT2JYbkExa0h1RU1zMEM2QlNSS3Ava1hVdEFkTUdyNzFWVjZtU3BROUtP?=
 =?utf-8?B?R3RiTWdrZ2E1YjlXdFZMTU40NzVQWVFYUFczTktHMHBac0dEOEI1amY1aEFt?=
 =?utf-8?B?K3lXcWlJZlErNWpDM01iQ2ROWE80TDQ4QTlZN045UTBFdS9pMWU0VDZYbDJn?=
 =?utf-8?B?T0RWanArZ25Kdk92eWgwYWRwYnNmS1JJYXRlYjh1bEZJcXFsQkJoZ3o1bEUw?=
 =?utf-8?B?RFBia3N5VFpHNVlNNEFURUhSUHpaR3VFYVpVclRiaTgwQW9LeUlpMEo0Zjhy?=
 =?utf-8?B?RlUvdnI1d3dDcUJKa0JlT0Jxb1JVMnlBZnJaOW5kS2psUHlkdmFvNHFTOGFl?=
 =?utf-8?B?OUpQekdMRCtoQ21TblBYb2tHakI1aVQyMXk1VVFMcldUMXo5N2pwTFpIZHJu?=
 =?utf-8?B?T0dNRFRWS2NObWpML3o1ZHpzRTcxNTgrNkxNaUZGNDVTUkZPcUJ0TGNMMnlJ?=
 =?utf-8?B?QjhJLzRIckFONG9kY3lYekhpZFdiUWtUaXdBUGYwUjVCdUZtM0VPaDVNdlNQ?=
 =?utf-8?B?REIxTzU0UmE0elVWZ3pjOGdxcmtsWVJmdDhNSlJPZHQ3OHlWZVJaLzZUckpW?=
 =?utf-8?B?c2JJYW5nb0RBYmI1SVE2cm10TlJiTnF0NUdGZVo0cUtQQ2x3dThXT09rUlJw?=
 =?utf-8?B?dU52SFdqZ0dPTHo0bkZ2aG1vL0VTbS9SY1pMNk5BUWNqQUVIVUhsaFVFVWhN?=
 =?utf-8?B?VWp2SmRWdzNqSU1vRGtuSUNURlZJQWFSZWtFdXZ2MjVwTUZ4b1k1SG1NdUdz?=
 =?utf-8?B?cHFqT3pNZ0c3dXRURElKMXlKWVhUZzZHamJHYmd1QWlTUnJydnpxSncrY3pB?=
 =?utf-8?B?UEdqT0dhQkFoV3hWRzJEUGNjSFJlQmdyMjBmZ20rT0ZlT1ZEbVBlWEY3NGkv?=
 =?utf-8?B?TXJOUUNNQkhhZVFrQnFuWWZCamg2MElnR2k1WXZCeGxrTnc9PQ==?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?aTdkVFUzN2crZ09TakRBb1VoZmNUbytoYVp1YjZuS2pML3BONSswVVdhMVpj?=
 =?utf-8?B?QkZQVUhXK0ZqSldETXRRNGh6Nk80SVlUcW5zTnlhV2FPaU5QY3dUeHJmUUhx?=
 =?utf-8?B?L0VsbGE0bGozSHYvdjJ3UW9TZm1oZUZMR0djUHc2Vi9ENWYzcFJtcnlDS1gx?=
 =?utf-8?B?dExTZWhGa1oranZqN1g3cUE4TThqYi9OQ1dxMEk5dUphWW5oVUx0Z29zVkpL?=
 =?utf-8?B?N1BDYVlRaDcxRituQUZqZ0JWUjMydlJqOFZ2b3Jnd1o4QSs1dCtVaENXRTA5?=
 =?utf-8?B?NjZRanFQYm12ckJ5TnRrQ0gyU1lzbVBjdUVRRnBlbHFScWZtVTlGVHNXenB6?=
 =?utf-8?B?eWFvOU1pYUR1S0hlVVpoMmFBU1BvampoL2hFQmRGeUJrNE1La3Q1WVlVYkli?=
 =?utf-8?B?TXJiQmhzVVVyUHY1V1pxWUJ0TzNyc2RUd0VFWThmNFRoNHMzRFBpbDVmVkRz?=
 =?utf-8?B?RXVZNjhNR1h5N21SMnJHZmtmQ2NlL1pJM0pPVWRrbUdtbGw0SlNPU0ZmbHBG?=
 =?utf-8?B?KzBCMHM2WTR1NWZBU3NWT01IMDdDeFowdnhlTlBpYkNzQzdFU2I2MGpmeDVM?=
 =?utf-8?B?WjFocDI4Y1NvWFplNDhCVFpBMjJBR3VTcUpPM2RORU41L3o5YTVUMHlmMWpy?=
 =?utf-8?B?WGtubzEvUVV5VDJTcFVLSk4rSFAzS2VacGpWR1Qvd2pUOXVVQTh6T1prdS9E?=
 =?utf-8?B?ZHZLamlkVzZEbWVXTjlJUUVHMWp6ZVExWDIxR2lON0tqVTlzbG5TQzNjdEM3?=
 =?utf-8?B?RHdwUTFBc21GMTcxWFlwM0dOcVcybmtZSjJZSWlCRWRIb3phRm9XUGRwNHQ2?=
 =?utf-8?B?NlhTNTUxZDU3NlZQcTArYlVibnFabkl3OGlVTnpqMXI1VTdYalBzUXJlZzVp?=
 =?utf-8?B?YWxUMlErQm5VODBJUGF1cXpyVnd4ejNlK1VFcWVHVjFzMHhVSmY3VzZQT2lh?=
 =?utf-8?B?Q2x4TXpqR2hTcXV3OVI2OEM5N3BteU5vckVPMXhCR0Y0bW1jOG9HMkFXRFEv?=
 =?utf-8?B?Q09JRmJ1RFpWWXptY29HT2k1T09LTk4yQUFTWjJDcXBGMUI4ditKZFhFVmRY?=
 =?utf-8?B?S3JpRUhnRm1aYnBTS0ZIQm1DZlZ3TG1aaUZra21UZFIvL1IyeksvR2l6U3hp?=
 =?utf-8?B?Z0pNTjllYjVWQTFkcDcrSHV0MnNsTFRGa2YySDN3TWFjN2JqTEhuTG1YVVR6?=
 =?utf-8?B?NjYwS1pzbG9aSEdqRWFveVovalNxeGlUTkZ3RHhZNWFnRmxITmZvd01YejNh?=
 =?utf-8?B?Q1oxNEVPQlIycG1xdXlHMFlLK1MwYTFTMnJjTVpIZjZVenBTQlhxeWFxMjZV?=
 =?utf-8?B?amJCcFpOcXUrWVNrYUhmYnhZM2Y0Slk4Mlc0OHpoRVZidkJEQ0pTeTF5K0Vh?=
 =?utf-8?B?ank4d1ZibEhlbGV3bjFiWXZWcXNONTZCenMzbjkwNE1DVmxhd0xsVE9JYnF0?=
 =?utf-8?B?NnlDN0g1OTVqTHY2UGlMNWhyaHdES2NRdTJGTFpJUUV0Mm5ZR3hYcm0yZk5C?=
 =?utf-8?B?M3BJclRWdjJMNDVqUDI2eUFzbHR2ZTlEMUQvSmV1b21tVVQxYWNzUXphWUFl?=
 =?utf-8?B?KzVIZGhGSmV2a1c4TlV6dEZWWjZUTVhodUQwM3BWTkdtZTdIb2pPeitRUHE1?=
 =?utf-8?B?VUQ4YlRXRk1Ic0RuWE4xandFQndBL3IrWWhuTXFyeWtxbVdEeDRRc1RsRndZ?=
 =?utf-8?B?QjN0b3ZKemt0UktmMmpSbnhhTnVvbEIwdHo0WGhXSndpbllaNUdrZXpUUjJO?=
 =?utf-8?B?aHk4OTBqRmQ3TUJqY1Zyb0J3QTlKR2pYSEZRNGxkVHVJTStmZUR4QkZzb3Bh?=
 =?utf-8?B?T3dzTnd4NHJBbUEvUmJFOHdCQkF6WWh4WE5mdHJvMnkvb1hCeUltRWxkRUJP?=
 =?utf-8?B?Vk0yNE5qVkJta3FsTHRONU5UUU1RZ1hudHVreHZWcUpPdkFIckVCVEdwMkJE?=
 =?utf-8?B?cTdEbnNrc2p3c2lrMFRyVEhrcWRBL0VnK0lFaWpBd2xnSnRubnltbk01MEd0?=
 =?utf-8?B?MktCWTIrM0hiTnJQaS9meVVZWnFmNnEyU29UZGgwd2ZNSHEzUTJFWkgrbTFo?=
 =?utf-8?B?N3A1RnpDOCtYSWJtRWhQWXpwMFhEZXVJOXZUdExlZC9ZVW5JOE1vRWQzRGNU?=
 =?utf-8?B?d20wNkdNbGVKMzltMXUvQ1dKcXE3L0dUR09Ic3VSK1hLNGxaM2J2c3g1ejg2?=
 =?utf-8?B?eFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E5AABA71D04A734B8970C1C6943BA149@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	s1LOq8xeQCdL7G76HQbkKVriMhGmAYYhHtazqO1OY9SNBUtCKawN6DKz6VRL2XprkWh5+m/35CmaCDLni6A4xJoveXUZQTxvKwZh+3ExjljYXvwWgCoCgoXf0LfhQLGJhD/uvVlMNGqmto8eJbuxk6hOk4xCSqdX4kF/fldYRI9j2gLbW2Na1JcZcCcZ2hniFt6kGUBgRcRLkqT6TJS0EvzbnqaYUvPo44M1neiTMAfsTZQUAnXqNfwvaf8NYdpgJCYWpDp4gX3IF6EpwqnS2+dC+aON0jYW1dsFt0BbLsnakHch/CxaIVmAZZsbtSvqvQ3RfGBCv8N9xJ85lS6Z4irLT//gL2vwOgsb/5Em9AtRRzz+ITC6TPirqQ5s5hvwlz1SSfCvDpMeUdlCIKj7tWi3kVZTUeZGTGTIWOoEnfcG6GyCuuIZxdlt/1GV1x29W0D3cK2f5MSex+pg0JPRFjqC4mWyNFvwix4aMpJrOEw7qb7SdKh4OFO3QqC0ni524en4FFmbXDCZK8mIoAz6aw05fNwej8z07lp2UkIHv87DcWEeZF4ddmKUiTZQVPHtZk6c7KKzMCsVhVP4fdbqfVNGLwDKwaidwANNEcVB9Ck=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a09305a-de43-4976-7ad2-08dc9b843e50
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jul 2024 17:19:06.2665
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hoz0MvIyzgHeCsDyntlOufbBMqfVd1r6YXQ/2QpvcOGrke/lO+5ulKkrpom8yXiyHmOnc+JS1ZStep5+RgoFhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5882
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-03_12,2024-07-03_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 suspectscore=0
 mlxlogscore=977 malwarescore=0 adultscore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2407030129
X-Proofpoint-GUID: Tli5cShfZ37d_-EjWaFQsVN1T0H5rARp
X-Proofpoint-ORIG-GUID: Tli5cShfZ37d_-EjWaFQsVN1T0H5rARp

DQoNCj4gT24gSnVsIDMsIDIwMjQsIGF0IDExOjM24oCvQU0sIE1pa2UgU25pdHplciA8c25pdHpl
ckBrZXJuZWwub3JnPiB3cm90ZToNCj4gDQo+IE9uIFdlZCwgSnVsIDAzLCAyMDI0IGF0IDAzOjI0
OjE4UE0gKzAwMDAsIENodWNrIExldmVyIElJSSB3cm90ZToNCj4gDQo+PiBJTU8gdGhlIGRlc2ln
biBkb2N1bWVudCBzaG91bGQsIGFzIHBhcnQgb2YgdGhlIHByb2JsZW0gc3RhdGVtZW50LA0KPj4g
ZXhwbGFpbiB3aHkgYSBwTkZTLW9ubHkgc29sdXRpb24gaXMgbm90IHdvcmthYmxlLg0KPiANCj4g
U3VyZSwgSSBjYW4gYWRkIHRoYXQuDQo+IA0KPiBJIGV4cGxhaW5lZCB0aGUgTkZTdjMgcmVxdWly
ZW1lbnQgd2hlbiB3ZSBkaXNjdXNzZWQgYXQgTFNGLg0KDQpZb3UgZXhwbGFpbmVkIGl0IHRvIG1l
IGluIGEgcHJpdmF0ZSBjb252ZXJzYXRpb24sIGFsdGhvdWdoDQp0aGVyZSB3YXMgYSBsb3Qgb2Yg
IkkgZG9uJ3Qga25vdyB5ZXQiIGluIHRoYXQgZGlzY3Vzc2lvbi4NCg0KSXQgbmVlZHMgdG8gYmUg
KHJlKWV4cGxhaW5lZCBpbiBhIHB1YmxpYyBmb3J1bSBiZWNhdXNlDQpyZXZpZXdlcnMga2VlcCBi
cmluZ2luZyB0aGlzIHF1ZXN0aW9uIHVwLg0KDQpJIGhvcGUgdG8gc2VlIG1vcmUgdGhhbiBqdXN0
ICJORlN2MyBpcyBpbiB0aGUgbWl4Ii4gVGhlcmUNCm5lZWRzIHRvIGJlIHNvbWUgZXhwbGFuYXRp
b24gb2Ygd2h5IGl0IGlzIG5lY2Vzc2FyeSB0bw0Kc3VwcG9ydCBORlN2MyB3aXRob3V0IHRoZSB1
c2Ugb2YgcE5GUyBmbGV4ZmlsZS4NCg0KDQotLQ0KQ2h1Y2sgTGV2ZXINCg0KDQo=

