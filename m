Return-Path: <linux-nfs+bounces-3475-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EF0998D386C
	for <lists+linux-nfs@lfdr.de>; Wed, 29 May 2024 15:53:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DEB21C21FA5
	for <lists+linux-nfs@lfdr.de>; Wed, 29 May 2024 13:53:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5557B1E532;
	Wed, 29 May 2024 13:53:08 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 840C11CD2C
	for <linux-nfs@vger.kernel.org>; Wed, 29 May 2024 13:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716990788; cv=fail; b=dWi1nj4s3DGcA1D16P/59aE8WovOmBnHx3GP8FaIRb4NgSfL0U2CIOhF+5rre0gLg08KL+UQNxTcdzZ96a3V9pU1U75fUgrc0fmx3zhOigr2sBkv+ps28oF6ZwZQAon0BDkb2qdz4WETx/fhu9PfJYfhdrD1PmuvdsacyD/r6Ek=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716990788; c=relaxed/simple;
	bh=F9DJvOPQFuxuDNuuVn/7iR46OuTMfabSU5yrGH9r1+Y=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cb0SYbJztkA5RVDiG5jdrTk0Cbpv7Ty4P/KtvEEsOzQECPJySCoPdXr3JQti13vzzdHCP+cBVUIi0HAM9gXykyqZ+jIBZXU9R4ucadT6i5ugTSXsT/UEoaAC+pPX5blvMaZE8+CcQWScOixFxOA9qv8/+rHxvpce10MxYM1O294=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44T6I3lQ008106;
	Wed, 29 May 2024 13:52:52 GMT
DKIM-Signature: =?UTF-8?Q?v=3D1;_a=3Drsa-sha256;_c=3Drelaxed/relaxed;_d=3Doracle.com;_h?=
 =?UTF-8?Q?=3Dcc:content-id:content-transfer-encoding:content-type:date:fr?=
 =?UTF-8?Q?om:in-reply-to:message-id:mime-version:references:subject:to;_s?=
 =?UTF-8?Q?=3Dcorp-2023-11-20;_bh=3DF9DJvOPQFuxuDNuuVn/7iR46OuTMfabSU5yrGH?=
 =?UTF-8?Q?9r1+Y=3D;_b=3DFnPj+XtBlT7YnfxrTI1hIMPUyfbx32unh1jnIy/obm8aE2StO?=
 =?UTF-8?Q?adLaLt1Wxprqk+XhYkX_ZBTrQ32x43siyTxiOvLg5lzuebe6gUGVUHG5O8hDyWV?=
 =?UTF-8?Q?77rdeJ+KorlX2KLtxwwUL95b6_0rHzn0asjXgzXAosBdKQwrdSTuXydfe9w35IC?=
 =?UTF-8?Q?PknmjP97AB5fWHxXjLJUgb1OlG3l6HF_ghhOBeaQL5YfQEtYoealp4NRNZ4GNaL?=
 =?UTF-8?Q?TVfvk43YAFPy/ZyEsT7B3oWkEpMiiUqV4hmhy_JW9cj6p7W92wH/rFE9z8PjHyn?=
 =?UTF-8?Q?MEDaw3oCdkxV1GvnZe0AlfS6839B5LNKS3+qTxfTDXt_dw=3D=3D_?=
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yb8hu6s2q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 May 2024 13:52:51 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44TCKhHm006492;
	Wed, 29 May 2024 13:52:50 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2041.outbound.protection.outlook.com [104.47.57.41])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3yd7c5jbbn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 May 2024 13:52:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W4K1ssyubd/1QZEYDlPkp2NtQSOHG++AaCrzYma0DNun6wWbzSYLaFloNkEQjqpbTRP7O615q/lp9eD0dicgRdudltC6Jm+HDy1/7vZRRQprZQ4CatsvMOoK4jgsocDhkN5lR15a/iE2bRu1EuZ2vSSRGWsIwYuDFVOtSaKU0PTZ/bxO3QL9gGS3ZTbQmGdKztqH2GfaEph0Hfpc3eCeYnD2bdyAGiPrOzi9aGAiV0nrUnW3fVpw75C2rTQ3leXzDUafACDKHVH/EJ2OfniisUXmR1bXK4jcOhvGXjkKfyDCZ35FZiBtnSy2U7oO5BxJetUX8KYZc/Fz/AilT2fXIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F9DJvOPQFuxuDNuuVn/7iR46OuTMfabSU5yrGH9r1+Y=;
 b=Zgnahq/hEl2Er14PKAdaKKjL7UmWu2GersPJFIIJIOdaH/8Z+r+lqeb7wBVJdBSjNMYs61/XgWsKWVk70C3OwldWRTa+Epc5JdFUy5wSgxQAyDQ3/RQLwTlg0U3HK5uYu/hJ9OET7oIIgUu3jSNyxfgiR10AUfxPd5DB7pcPKy7ek8jFA8Ah3cJDGnBj0hHa40iT2xzuMAt7Rn2Tjizzp0eQHGakXi8mVEQXViLUbY/xs0Yxw4GOqzKKxi8zspv5REH/+ld7+oX7N/AeFsObfjueZmrY0seTyDGISA1D5XNtTApulcRUeYRu6bBv+TgFl42hNFzxUwkHe1Yojf700A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F9DJvOPQFuxuDNuuVn/7iR46OuTMfabSU5yrGH9r1+Y=;
 b=UwYZ8xcctcvVLduLAd8pZOaGVCj/REusKVXBSWurzRKfq8E1sqMt/5/TjFVeRx/kKDvV5WjbHDl01+Br1d4rc5KjDLy9u1pyhPuHGQX69q/d6AWsDcNszqpZgn+I/hkilUySE/yb5wdDRFe757MToOiu8VPLBI4eajhq8jE5KfE=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BY5PR10MB4147.namprd10.prod.outlook.com (2603:10b6:a03:20e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.34; Wed, 29 May
 2024 13:52:48 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.7611.025; Wed, 29 May 2024
 13:52:48 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Dan Shelton <dan.f.shelton@gmail.com>
CC: Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Christoph Hellwig
	<hch@infradead.org>
Subject: Re: RFC2224 support in Linux /sbin/mount.nfs4?
Thread-Topic: RFC2224 support in Linux /sbin/mount.nfs4?
Thread-Index: 
 AQHapknQmFeuXcZb5kKY27PdDSV60rGY1hmAgA3YMoCAAsSmAIAEKaEAgAA5SQCAAHx+gA==
Date: Wed, 29 May 2024 13:52:48 +0000
Message-ID: <D1043A78-2963-4D36-A158-3971A0E69D85@oracle.com>
References: 
 <CAAvCNcCTWbU-ejURuUC0_xhcoU3GF+2jX28rV4+2cKgfO5Lqxg@mail.gmail.com>
 <619bbf23-dbfe-4c26-adb9-1cc89f3f22a2@redhat.com>
 <CAAvCNcCGhZ917yerEOMcEEj7+_Yz5by8en2F4Yr5zLk0iQEGjg@mail.gmail.com>
 <ee3805865e12f8ed2f82f7e99e33598f0bcc6667.camel@kernel.org>
 <CAAvCNcD0MTwBthZE3KPAoG=_gsVY=tNS5D4K+UV6+9jMJPs1Og@mail.gmail.com>
 <ZlbKtv4asoSjKdbq@infradead.org>
In-Reply-To: <ZlbKtv4asoSjKdbq@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.600.62)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|BY5PR10MB4147:EE_
x-ms-office365-filtering-correlation-id: f010f6fb-5d34-4610-b1c4-08dc7fe6a000
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|1800799015|376005|38070700009;
x-microsoft-antispam-message-info: 
 =?utf-8?B?NkxPL0xSaDNJRFhWcnJuWDdBb0V1bk1PNGJGWWZNc3NmaHdPVE1IdTFJMUV6?=
 =?utf-8?B?S0xvU2srdHRWRGQ0TWZXUHhyZnF4dno2OWd2cW1RVk10anZMblNHYXMzNkZR?=
 =?utf-8?B?YVF0d0NKck40dmZnamt5dlJGWGZJZE9iWVBLNVJRR1ZiWlVvaWorNjc3dHZ4?=
 =?utf-8?B?RkRsYTh0YTlOTVBFdm5NUXUvZGdPV3c4Y1pNdk84OEczb2RZczB5eUZySTFJ?=
 =?utf-8?B?NDdmdDdTcEgrbVdXSDhibEppU2pyNU1zU1kwa3RrdEZCWXdiUlJzOGtqMm40?=
 =?utf-8?B?c1NZVE1Lbm9QaUtqTTlZdWgxMnZYZHhmREIrZGNaQms3Y28wQmlUaVduaDMv?=
 =?utf-8?B?cWFVeWlyVmNVQktKVll1dTNjcVl3T2pNeE5pUHNISWtmTjd4eUxraVlJdzZo?=
 =?utf-8?B?Y0xXWVgyZjBsM3dJcCtxQ1Z2VVdsOE94RllvZGdsTUk4alI1Qy83cFJXUHh2?=
 =?utf-8?B?TitkbXI2eGVXQkpDVitrWDVRZ29KblNGM2lQc1lmVGxEMHltMFhVSm5JRE5L?=
 =?utf-8?B?eXBIZE1RMVY0d0dUTjN0UURPMHVjU0NzZFBpcVo1TEI2UkJpTnkwK21qaitx?=
 =?utf-8?B?RDdacVNGRC96WjJRTXUydmNrMzZRYnNscldzZVpLc29EZkwrWStJNXpsZjlJ?=
 =?utf-8?B?akQ4cU9RdkRwS1pISFZlc0Nmam93alR0ZFBRVjR2ckJ3ZENrbE0xb0QvZUM3?=
 =?utf-8?B?QlBrWFdtcHRxeEZYSDNIdjNjK3R4VUxMMnFWdFJmYlB1QVYrbjY1NlBCL3pm?=
 =?utf-8?B?OWxBNE92aE9tWkxGbHhnQXpjbTNrQTVQQ3dkL2lYQ1lKcnlYZjBpdDVKRlVJ?=
 =?utf-8?B?ekhjQjgzcnJmRmVZUzFGcXpDc2E0eERrNzc1clB6L29LTWJxSjQxTGJNa2VZ?=
 =?utf-8?B?VVQvMmxVVC9pTEJXR1R6YVNsODlJMmNGRmxZVUFoYStNSlo4MlhtbUt6Qlha?=
 =?utf-8?B?NlJ1aVFYSzMvcjdGK2t2TzQ2d0VPWWRHVHVGaFVJeW51L0NxUjY3WStJenkr?=
 =?utf-8?B?V3VUdzNDSDhueThPRGt0c1JhQXl5VW5BTDB0NVVpdXRVbWl4Z1VGRFRiOHd6?=
 =?utf-8?B?ZXdLRFpvL1BVeFcxMVFzNGhUWUhkOVhzSUhpeVBzWnhsNWczK0pOKzdIcFFh?=
 =?utf-8?B?QTZRcjRHam5lWnlNdGY3ZnNiMG82ODUwSVFoTkRJMkQzWWM5THJ1bjc5aDRi?=
 =?utf-8?B?Mm5oU1JTUkttWDVsRnVSa2RVSjNGb3FaWUwwTERXYVVXd1NQaFlRMWF0VS9u?=
 =?utf-8?B?WE9NKzdEWkExR3orNTVpQWYvM2xEVEhyTmhkZ1dpZGNQMVkyK1NLemlLLyts?=
 =?utf-8?B?blFBL0xoK1dqKzErelQwRUwrakhvSWlCSDFlNiswL25nUlVRWDlKOU1ENVRi?=
 =?utf-8?B?djFhNkNyMk1HWXB6Vjd5NHRSbHIzRFFGQldXZG5HV2VuSFR3cEVCVXBlQldQ?=
 =?utf-8?B?OUg2aGd2UjZUQUNuRVBhMGNjT2g3YktSSldad3VTWVUvYlFtR25WbTR4OFB3?=
 =?utf-8?B?djFnVlZwaklzc3B4MDV3dnFMWThaeC9CRlBXNXJhaS9nN0ZLd0xzRkMyeFZx?=
 =?utf-8?B?UXZ4aEhKWWxPdlpndWZYeEQzcDdSWU5ISEFMZVVEeGYrOElsSWpyNmxHSGdu?=
 =?utf-8?B?bldwVjArQS84TzkyVkJmUmVhZmpOR25ENlZIWTRQQ1J3TVI3REFYUUo0cGhv?=
 =?utf-8?B?UWRJNzRVNWc3WHhVaDRyNUl0U1htZEpmcmQ3QW1sc0UyeVNCNDBUZmF3PT0=?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?bXpxeUVVZFp3ZzFTOFZ0WUxlSGhINkVvd09mejhxYWFkbW1DNDNkakhjRzhr?=
 =?utf-8?B?TExkbFlxcUR3VElXbTZRc0pKaHdhUW9LekFSbWhXcWRMVkxuNHQwSzV1bVNv?=
 =?utf-8?B?V28yblFUSm1GcFNiSzlpYWp2T3NubEFQeDlUK08rL1NFK1dQRzNRZWZ6aVFP?=
 =?utf-8?B?azk0Y2llYTN4TTRLSmdkbUtpWFlRcXRaS3FMVlUzbXZBbUdhWUp5N0Q5eDM2?=
 =?utf-8?B?dG83STNXeEZNOUxzd2IwTnd2M2c4cmFZRm5MSmRDeEhIRzRyUWs2MmRMcHly?=
 =?utf-8?B?blVEOE9HZ2hmSUttck0vQk1Kam12ZmIwb1FoNHkraUY3Z0xxczNyanRkcllB?=
 =?utf-8?B?bFl4ZW1QdXFxNzhISlBPNWxwRytHZi9XbUFKdll5b3F0UUlDcVduN3A2dE1r?=
 =?utf-8?B?aFloZ2I2OUdqdzlDMTFlM1JiQWRrVEMvaXRtZTlZR0pxRWV0S09JdXBKZDVF?=
 =?utf-8?B?eXlTTVJteVAwQzFLcEFLVFRKVWV1djhuaGlzWnRkNkhoZzBha2JjN1JaTUVN?=
 =?utf-8?B?K09KcWZnRTBvQnhJNDdadWF3QmJ3WUdneWltQTFBcnN0YjlPVTJqYmMzVDlM?=
 =?utf-8?B?SmlxSlozK0E2ck9vbVp6V0wyK3N6dkZBU0hBRVNkaUNnVTdWeVlMNjIwbU5M?=
 =?utf-8?B?OG93SFJCTSt3UjJJT1RpaFprZkNsRlBuRzhmMmJpQ3Z3dGpIc2lMM1piRnZQ?=
 =?utf-8?B?TzB1TzFyelRUVVVKWFRKSlBvYk1FbW9BdTlDZkU4Mkl0QjJrUDNiT0ZvMEhk?=
 =?utf-8?B?eERyNERkYTJGL3dCVlVtZXBFa1V0T1U1UWtZREEydjlsYjA5VVZQMFJiN3pM?=
 =?utf-8?B?cGkxNWVWTjlNbWxWSjlDcWM4UFNPNExVWFlFQWV0NzJyaVpSeU9SNldsRUYw?=
 =?utf-8?B?ZW52a3RKSm81Q0FYZWhzTTQ3eTJ3WGtsQm5GY0lhakUrMmZzN2hsL3lMZVRq?=
 =?utf-8?B?djNkK1FLMmRGS1JWSW1ZT0lNTDdoL2VpeDI2YzVDOFhkLzB6eGtteTRHZWk5?=
 =?utf-8?B?L3JmbWRnVkE0L1FOVU5NSjN0ckhEaUdycXg2cm8wZ1JmS1pLOEpyQWhMbXBv?=
 =?utf-8?B?NlBCUVRkM1ZIVHdPaDRSUWc0QVZhYzMrY2FTcXN5MjJhVWo4dmJiOTc3TCtN?=
 =?utf-8?B?ZHVFSlFQN2R4b1ZvVEh4WWU0Y295eW16a1NGWUhWSjZDZkNaUmZQeWJ1QUgz?=
 =?utf-8?B?cUFITkhqLzNzUjhKZjFLZEY5QVkwZndQZElpNXV2d3lSUnZuMVlTdTJ4QTVD?=
 =?utf-8?B?YldESkZ4TzNLcE80TE0xSDFBRGh6ckZFOXF5R0kzRUxSUnVvYTRxWVBMTVBi?=
 =?utf-8?B?aXJrUHovWk05ODlHUUlKTVZOaWxlYkE5RWNuSmo1dDkzZ2tNNHRkMU0rbHo0?=
 =?utf-8?B?MGlyZW92ZmcyS3RpSTVMbzEzeFRaaHZlM0k5ZGs4ZGc2YkhOcWdOZFAvWXQ0?=
 =?utf-8?B?MVVtRlV6aXBwT1g2c3BWK0I3NVFiWm82L0dVdGhXVmdjcnk5dVNNMHhpaFZl?=
 =?utf-8?B?UVkzOC9Yb0szbkUvWVlxUXpxMjR2aWxpcFNZWStIRFJ2TGloK056NlBFYWVR?=
 =?utf-8?B?QWhlSnUxZDVwY3M4V3ZBRytPWW9MQ09vVUZzQUtOelM2ZzIxRHlkOWluU3Z5?=
 =?utf-8?B?YU16QWh6SVlhNGQ2YWhaWlVuTEc3UCtCZU5yV1BnTzNlS2h3czI5NENLTnZr?=
 =?utf-8?B?bDZIeVpCSnVlalVIL3VJV1dpenNqa2x2bXhieFhMdHJkaTlrMGNIYnM3UlJQ?=
 =?utf-8?B?cjdoR0M3WDlNTXNoNVRxelhhY3VOQlVhdzMxcXJWek8vWjhjREkxY0NIbHpk?=
 =?utf-8?B?eVQyQWNHcmhxVXAybGVMMkhLVW1PM3I4WmFYZ3ZKbnozN0xwTTBPb0VialVh?=
 =?utf-8?B?ZWlodGQwbVhNOWF6VzZUTEZMZlNEOGNPVmpwMlFHNDhicE1kYVBqZmp0NHlu?=
 =?utf-8?B?VlIvOG4yVTcyeTFMMlc4ZG8yZFAvcnZDTGk3Sk44ZitwSnAwbkhtT2lDNlRj?=
 =?utf-8?B?czcwR05WRmVKdFNBK3hKUEVBUUtldDhrcXF3NzkvSWQxamJzT1Z2V2wrbFk3?=
 =?utf-8?B?VndTVUphQ0hYekh3Y1lsRlk0VUQ1OUgvME5BZ2JOSWdOWHdaUnlLbkYzc2dk?=
 =?utf-8?B?RVR6Ly9Sc0gzMHZjVWJ6Z1Y1bVR3NTJ0WjJuQ1BINTl1cXVmV2xBdkFsZWtk?=
 =?utf-8?B?ZFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5A2F0E736E777C47A808CACA0E086A5F@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	098ISaCl0XwxKd0w9Pudls4B5/2DmCm47Q76DwUjOzdARMGZMASmU+vsD46Lgq2MVYv53ZmqEeZUWvfdgvMrKIJmFz1Ag4/kt7oOLY5ASG+ctWPwx+kyNqYLGHJuTaOAmJbhXkxQHrEep81joVlLbKeaq1KkynnsfzEy4N1ONm25dVVHk7yepoyMNJB4HKJfRAsdAthKLbD91/gwEsiFcEryYim1jtHDBz144nXGHb+Y4j5Ru68ZxeU8OvlAEIoueTacB2lPuyIe8776SOhIbgGOOhtLD7R2Te0wxzGPGKr37hNOlIgS1iEzgMe66d28zijHxXk9HU7qiUCUJ87ADlyYMWkx9l1IYJZg9Z8N9DM7TSdo4HZYgZr8NZuKTC9vVerWqlH9XLvfl9rBZ6mGXiMexmGnvtMtkPz/jnIqsZ42V7N8LmQVytJ39lWz+GRPolMfB95eGEztcNiMhMA7TRZzobTgMzJMFbfkXNwy3bYuYhLtLc2QBorD7OBOWwK76XmfpGLFvHz80sUEnxKdBqBMDq+k3jr7glsH0g/LX/uqOYaR2DlnxkkN/xMJQ+ZU8YIIKOTIJMCbLXAzv1o6pP8TUIRSUWu1nCn4dpjYZFM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f010f6fb-5d34-4610-b1c4-08dc7fe6a000
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2024 13:52:48.2760
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EpM1cKw1Zf9rVYogEMh/NnI1Wl56Vq1S0SUMOJD15dIkrNzEfua5SlKeyYN76sFWhZok+bN0cQIqgfaOPXSFxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4147
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-29_10,2024-05-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0 bulkscore=0
 suspectscore=0 mlxscore=0 adultscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2405290094
X-Proofpoint-ORIG-GUID: mCa5dF9KfQe_vDN5a9S-rlTcuVkwoC_n
X-Proofpoint-GUID: mCa5dF9KfQe_vDN5a9S-rlTcuVkwoC_n

DQoNCj4gT24gTWF5IDI5LCAyMDI0LCBhdCAyOjI34oCvQU0sIENocmlzdG9waCBIZWxsd2lnIDxo
Y2hAaW5mcmFkZWFkLm9yZz4gd3JvdGU6DQo+IA0KPiBPbiBXZWQsIE1heSAyOSwgMjAyNCBhdCAw
NTowMjowMEFNICswMjAwLCBEYW4gU2hlbHRvbiB3cm90ZToNCj4+IE9uZSBzeW50YXggYWNyb3Nz
IGFsbCBwbGF0Zm9ybXM/DQo+IA0KPiBBbmQgd2hhdCBleGF0bHkgd291bGQgYmUgdGhlIHVzZSBj
YXNlIGZvciB0aGF0PyAgSXQncyBub3QgbGlrZQ0KPiBtb3VudGluZyBmaWxlIHN5c3RlbXMgaXMg
cG9ydGFibGUgaW4gYW55IGtpbmQgb2Ygd2F5Lg0KDQpEYW4sIGFkbWluaXN0cmF0aXZlIGludGVy
ZmFjZXMgZ2VuZXJhbGx5IG5lZWQgdG8gd29yayB0aGUNCnNhbWUgYWNyb3NzIG9ubHkgb25lIG9w
ZXJhdGluZyBzeXN0ZW0uIEkga25vdyBMaW51eCBtaWdodA0KbG9vayBsaWtlIGEganVtYmxlIG9m
IGNvbW1hbmRzLCBidXQgdGhlcmUgaGFzIGJlZW4gYSBsb25nLQ0KdGVybSBlZmZvcnQgdG8gZ2V0
IHRoZSBjb21tYW5kcyB0byBsb29rIGFuZCBmZWVsIHRoZSBzYW1lDQpoZXJlLg0KDQpZb3Ugd2ls
bCBzZWUgdGhhdCBjYXRoZWRyYWwtZGVzaWduZWQgT1NlcyBsaWtlIFdpbmRvd3MNCmhhdmUgbXVj
aCBiZXR0ZXIgYWxpZ25tZW50IGFjcm9zcyB0aGVpciBhZG1pbiB0b29scywNCnRob3VnaCB0aGV5
IG9mdGVuIGhhdmUgbGl0dGxlIHJlc2VtYmxhbmNlIHRvIHRvb2xzIG9uIG90aGVyDQpPU2VzIChz
dWNoIGFzIGNvbXBhcmVkIHRvIE1hY09TKS4NCg0KTW9yZW92ZXIsIHRoZXJlJ3Mgbm8gbWFuZGF0
ZSBhbnl3aGVyZSB0aGF0IGFkbWluIGludGVyZmFjZXMNCmFyZSBwb3J0YWJsZSBhbW9uZyBvcGVy
YXRpbmcgc3lzdGVtcy4NCg0KT25lIGV4Y2VwdGlvbiBpcywgb2YgY291cnNlLCBtb3VudCBmb3Ig
TkZTLCBhbmQgdGhhdCdzDQplbnRpcmVseSBiZWNhdXNlIG9mIGF1dG9tb3VudCwgd2hpY2ggcHVs
bHMgbWFwcyBmcm9tIGFuDQpMREFQIGRpcmVjdG9yeSB0aGF0IGlzIG9mdGVuIHNoYXJlZCBhbW9u
ZyBoZXRlcm9nZW5lb3VzDQpzeXN0ZW1zLg0KDQpUaGVyZSBhcmUgYSBzZXQgb2YgbW91bnQgb3B0
aW9ucyB0aGF0IGFyZSB0aGUgc2FtZSBldmVyeS0NCndoZXJlIGR1ZSB0byB0aGF0LCBidXQgdGhl
cmUncyBubyBzdGFuZGFyZCB0aGF0IGRlc2NyaWJlcw0Kb3IgbWFuZGF0ZXMgdGhlc2UgKGFuZCBu
bywgdGhhdCdzIG5vdCB3aGF0IFJGQyAyMjI0IGRvZXMpLg0KUHJvdG9jb2wgaW50ZXJvcGVyYWJp
bGl0eSBkb2VzIG5vdCByZXF1aXJlIHRoaXMsIGFuZCBhY3R1YWwNCnByb3RvY29sIHN0YW5kYXJk
cyBhcmUgb2Z0ZW4gYW1iaWd1b3VzIHByZWNpc2VseSBpbiBvcmRlcg0KdG8gYWxsb3cgZWFjaCBp
bXBsZW1lbnRhdGlvbiB0byBwcm92aWRlIGl0cyBvd24gdW5pcXVlIHNldA0Kb2YgZmVhdHVyZXMg
YW5kIHZhbHVlLWFkZC4NCg0KU28gZmFyLCB3ZSBoYXZlbid0IGZvdW5kIGFueSByZWFsIHZhbHVl
IGZvciBzdXBwb3J0aW5nDQpORlMgVVJMcyBvbiBMaW51eCwgc28gdGhleSBhcmUgbm90IGltcGxl
bWVudGVkIGhlcmUuIFdlDQpjb3VsZCBpZiB0aGVyZSBpcyBhIGNsZWFyIHRlY2huaWNhbCBuZWVk
IHRvLCBidXQgc28gZmFyDQp5b3UgaGF2ZSBub3QgYXJ0aWN1bGF0ZWQgb25lLg0KDQpOb3cgaW4g
Z2VuZXJhbCwgd2hlbiB5b3UgbWFrZSBhIGZlYXR1cmUgcmVxdWVzdCwgeW91IGRvDQpuZWVkIHRv
IHByZXNlbnQgdXNlciBzdG9yaWVzIFsxXSBhbmQgdXNlIGNhc2VzIFsyXSBzbyB3ZQ0KY2FuIHVu
ZGVyc3RhbmQ6DQoNCiAtIHdoYXQgaXMgbGFja2luZyBpbiB0aGUgY3VycmVudCBlbnZpcm9ubWVu
dA0KDQogLSB3aG8gd2lsbCB1c2UgdGhlIHJlcXVlc3RlZCBmZWF0dXJlIGFuZCBob3cNCg0KVGhh
dCdzIGp1c3Qgc2ltcGxlIGdvb2QgZGVzaWduIHByb2Nlc3MuIFBsZWFzZSBpbmNsdWRlDQp0aG9z
ZSBpbiB5b3VyIHJlcXVlc3RzIHNvIHdlIGRvbid0IGhhdmUgdG8gZ28gYmFjayBhbmQNCmZvcnRo
IHdpdGggeW91IHlldCBhZ2FpbiB3aGVuIHlvdSBwb3N0IHNpbmdsZS1zZW50ZW5jZQ0KZmVhdHVy
ZSByZXF1ZXN0cyBmcm9tIG91dCBvZiB0aGUgYmx1ZS4gV2hhdCBtaWdodCBzZWVtDQpvYnZpb3Vz
IHRvIHlvdSBpcyBub3QgYWx3YXlzIGNsZWFyIHRvIHVzLCBhbmQgaXQncw0KZXNwZWNpYWxseSBp
bXBvcnRhbnQgYmVjYXVzZSB5b3UgYXJlIGFza2luZyB1cyB0byBkZXNpZ24NCmJ1aWxkIGFuZCBt
YWludGFpbiBjb2RlIEFUIE5PIENPU1QgVE8gWU9VLiBQbGVhc2Ugc2hvdw0Kc29tZSByZXNwZWN0
IGZvciB0aGF0Lg0KDQooSSdsbCBub3RlIHRoYXQgTXIuIEJsYW5jaGVyJ3MgY29tbWVudCBhYm91
dCBpbnRlci0NCm5hdGlvbmFsaXplZCBkb21haW4gbmFtZXMgaXMgb24gcG9pbnQsIGJ1dCBJJ20g
bm90DQpjb252aW5jZWQgdGhhdCBORlMgVVJMcyBhcmUgbmVjZXNzYXJ5IHRvIHN1cHBvcnQgdGhl
bS4NCm1vdW50Lm5mcyB3YXMgY29udmVydGVkLCB5ZWFycyBhZ28sIHRvIHVzZSB0aGUNCmdldGFk
ZHJpbmZvKDMpIGFuZCBnZXRuYW1laW5mbygzKSBBUElzIHNvIGl0IHNob3VsZA0KYWxyZWFkeSBo
YW5kbGUgaUROQSBwcm9wZXJseS4gSWYgaXQgZG9lc24ndCB0aGF0J3MgYQ0KYnVnLCBJTU8pLg0K
DQoNCi0tDQpDaHVjayBMZXZlcg0KDQpbMV0gaHR0cHM6Ly93d3cucHJvZHVjdHBsYW4uY29tL2ds
b3NzYXJ5L3VzZXItc3RvcnkvDQpbMl0gaHR0cHM6Ly9lbi53aWtpcGVkaWEub3JnL3dpa2kvVXNl
X2Nhc2UNCg0K

