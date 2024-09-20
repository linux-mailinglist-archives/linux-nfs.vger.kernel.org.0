Return-Path: <linux-nfs+bounces-6569-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A31697D85A
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Sep 2024 18:31:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 381A4284008
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Sep 2024 16:31:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60B631F957;
	Fri, 20 Sep 2024 16:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="CUYRqRm4";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="n5EsuHDG"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F59A1E517
	for <linux-nfs@vger.kernel.org>; Fri, 20 Sep 2024 16:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726849866; cv=fail; b=VS+7pHkx8Y1tpx6OHhVSoabb+dljtCJOVJtCPbQ5i9R/WiVKGz+u0+nxnnYu1k/r95gyduRkxf/g1j5j0vdDaL5BeVQAu4hy9fpxu7VYUUVdILqqNPuS7HoSTMROr0gXZDupYqC6ZLB9VACD+c3414OFRs/MJIBvMmleS8J7og8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726849866; c=relaxed/simple;
	bh=lPGLgWMRrJHGfzB/OLpxNjei2JaaWGpSuOAKeQci20w=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NSQ/xieJQJXLjCg3AbevWCttbif7rPkYWmn9RT6bdn73tbE66OOJ8SwORmBNLjEIYZL4hM9Vt4fckbzcHk2DfI/DnLPSUXMNJhYfBuLzIJYjuZMKAZG/28aiiqxCtQTYkmRtBNHnavWktRpnbo3PYdlMpWMkU1AN3IAAktjBki4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=CUYRqRm4; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=n5EsuHDG; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48KBfCND018052;
	Fri, 20 Sep 2024 16:30:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-id:content-transfer-encoding:mime-version;
	 s=corp-2023-11-20; bh=lPGLgWMRrJHGfzB/OLpxNjei2JaaWGpSuOAKeQci2
	0w=; b=CUYRqRm4NRRzrwEfRt08B9z0sfN4kylVfbSXGDlc7+9w6IbJuM8ZgrRTe
	y87JG+MuKrOoggHnhv0dTcjsPsHtjULE0CDFjaGW5UJ1mWqdwurd0WjS+yjmIvR+
	8NGvOGYEYGkHXWXd2gXEzSgEWlJUhr2QnpG2u3UtoteIuGukMlyloZEGY1+NRAyl
	qXIVbGD7tCq7KNDVq2YP/IB+8GW4WEgxpveGE0eWfg3TWXkPSKZP+e5Bt8WbQaCh
	8ct09FzT0kc6KirovuFYkjklgtshGg4XsdO4U6v3IWdwvLeCCu165SZGKjN0VVnM
	csgJcsn34zdt8nPsBBF0OlpUdlUFQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41n3pdxvc8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 20 Sep 2024 16:30:58 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 48KExxZ5014950;
	Fri, 20 Sep 2024 16:30:58 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2044.outbound.protection.outlook.com [104.47.74.44])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 41nyg7ndnc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 20 Sep 2024 16:30:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RCxzJ2K3PwM3VZ6MecHlW6amNSs8xsUBFtIctS/ZXK/gl6s17GVrXt1dLsekRKxZyxPlRX9p8WfHUyPqwEMDHGNboDDufAN9W+WuVJ7oHyQEEBNVUsley/LO/JdExLjVnk7NUt8XPpxA2AoEzrLwHG3rCsNDs8l8GNIGHojPOOJ09HzCkmmW7N3AenVSkfWAX6JEWelc/feHjdGBXnfptPXzKdWF3vDyuPIykM99yTKmySGRE0BiEIcovqZGvbh0AbBo742AIm6RZ0VCSQRBPixMRGHOSEoT5dGCBJSgbmnMox8ZdAyZi3z37l1e582ZRtrfnJIWxn+yH8869mGEiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lPGLgWMRrJHGfzB/OLpxNjei2JaaWGpSuOAKeQci20w=;
 b=BDVakKY5b32F/hvfzNdB+WicFEnDxk0Bd4tIleYcxce/1mxErThHVf79RNKuFT2+wqAl9+HfVBrCUK2QolniaDQowCl9Kfgoaj1p1rvV/1k06f5zZsTJ2H8wdA5Lk1On48NH+3LmZR+azkku71g+/aK3cqjZ6scGSr49zrygDmrmdD6DYnIHSSCGQ8JYovLQeK1jUDOTDgXq1EW79R9W6A23k5sGlUXcXUOxDLbZCdJs3aUokXdY42gomnlk8PqVg+GAS/FqAVNf4NZGtrPawcLD5CikxWxqLow23FBnVEIBlgHVZ00h16eGt3IVhpOnXvxr3YI2RkO+/MEQ0tOCIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lPGLgWMRrJHGfzB/OLpxNjei2JaaWGpSuOAKeQci20w=;
 b=n5EsuHDGQPNpmkAyN1brpV148xpfD07fHjoj1+zNDkCqNVkHMSIp8axi/jLfJdF0ks5m8oAxw0DRZoMRcTTOC62vortAqOlXqDRqnF/NvSQWWxc1ZfClChMS/coGH83izbScWkz0by0XECIPZjbS92EqzWVG4kEe3Oon1sMbOZE=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CH4PR10MB8052.namprd10.prod.outlook.com (2603:10b6:610:23d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.9; Fri, 20 Sep
 2024 16:30:50 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.8005.010; Fri, 20 Sep 2024
 16:30:50 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Jeff Layton <jlayton@kernel.org>
CC: Olga Kornievskaia <okorniev@redhat.com>,
        Linux NFS Mailing List
	<linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 1/1] nfsd: fix handling of WANT_DELEG_TIMESTAMPS on open
Thread-Topic: [PATCH 1/1] nfsd: fix handling of WANT_DELEG_TIMESTAMPS on open
Thread-Index: AQHbC3cD2MFUE3Eu80a1Wg7izEAaprJg3EEAgAABrQA=
Date: Fri, 20 Sep 2024 16:30:50 +0000
Message-ID: <FA97862C-82C5-4879-B9AE-F5F5B813150B@oracle.com>
References: <20240920160551.52759-1-okorniev@redhat.com>
 <995712d148b21cd238c9604c58f42fe7a4b1581a.camel@kernel.org>
In-Reply-To: <995712d148b21cd238c9604c58f42fe7a4b1581a.camel@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3776.700.51)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|CH4PR10MB8052:EE_
x-ms-office365-filtering-correlation-id: e696fec6-d154-4273-08bf-08dcd99196e1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?SE01YWRkak1BOExIQkRHZFZGTmFRWFEwVUVWdXV6U3JLN3p6RjNQVk5hNXVz?=
 =?utf-8?B?ZGtJMGhZdlIvR1ZQb0pZbkx3WHdNQWx1SzJtMGZQMWN2SEFJakZETThwRFhi?=
 =?utf-8?B?MWdFYkhRSHlEd2lBV2Jzem85djRSNHM3VzViZWVuNkhmYmM2dzhUbEExYng0?=
 =?utf-8?B?M2o0dVBQT0I5ZDU1NkFCS2RHQWxncXZUWVJqbnRGemZRTE9JTTFvcU54N2wr?=
 =?utf-8?B?c25MWWVBMVVwSGV4WERwK3F5YXRXR05xM2JVY3hBOHVRVGNoT0s1U0ZsOExW?=
 =?utf-8?B?RzFtUGhQVmRnVS9RSnU2U1NqZWM0cjdweitIeGc3SkNIZ01wVDJiaFlJdkdO?=
 =?utf-8?B?cW5vZ0k4OG1SKy9JbmprWVdLRDdxcmdtMGdWU255MDg3RDIwRjBKeFIwUEJV?=
 =?utf-8?B?N2xoTUEzV0tGRmxyWldPRXB4MkQ4d2p4Q050Z3ptZGk5L0l3R3lRM1hDSW5N?=
 =?utf-8?B?MzZDUm1GMndrT3BneDdKcFJmLzY1UmJIOGN4VFJQdERLRDN3anJYc0kyRmlQ?=
 =?utf-8?B?aWNkQllVdFNNK3gxL01LS09qZERMZ2dsamh0aEVYWjV5aHVVTy9vUFE1dklF?=
 =?utf-8?B?SUZuK3loWlZ4Z2w4ZEZ1eWNTZFRjOFBFMEhwcnJTUGZ4OWhkMHZvQkovdWVO?=
 =?utf-8?B?YVMvaFhCU2tBWEtsWjRnOUoraDFvRHc3eE14SVNBQW1CUkFSeDUvMXVTT0Jt?=
 =?utf-8?B?UFFCL2NKMURqeEp2SWlwVC9vU3h6SnZKTnBseC9EVnlmSUdkeHYrTEJyUGJ6?=
 =?utf-8?B?SkFaN0lTUXU1UFVEMEQ3dmpuM0ZtTFNaRWpUc1NVRUF6SUhVS00xRC8zQzlo?=
 =?utf-8?B?QUd0UXE4Q29kejZaWjkrVkROWmtpeGczdW01N29qZ2M3dHVwVTQ1bnQvSEl5?=
 =?utf-8?B?WEVvWjJENjgydXpIQWcyWFYwMHlSVFB2TWdBZ210eEZ4Mlg2Rk1TT1FWS1RQ?=
 =?utf-8?B?cC9OYmxJTVY5QnZ3eGRKM0dQZyt4NTFGM3FOU2U3T3B3d0kzNGMybE1VaXNV?=
 =?utf-8?B?cDBOYXAyaThTZ0d2dkM1VnB4OE5Qc0JHcVdTbDd6Q1lrU2tRVG5jeTg4Z0Jw?=
 =?utf-8?B?Z2lRVlhEdldLK0wwWFY0cVdoRExJaEEyOE1QWlhYbFZEYzhsYUQ0ZGRlUlhH?=
 =?utf-8?B?NW9UMkdXNXQwVUxXWHJiTitYcGtPcG5kVi9IMjBvbWc0c2pkR29STzdLcGFs?=
 =?utf-8?B?aWtOV1hDeGdnc3prOHJTWEpVN3pSUjdBcXZjNVk4U1I0T2Z3WU5jZDQ3UGFG?=
 =?utf-8?B?cWtoT2xsdDZTUFFKNHd5eU1VcHJBTWw3aHA3dk9vN0xYcVpuSkZmYTBjeFJ1?=
 =?utf-8?B?UTFKbmtVVlhzU1VaZ1VnbXc5TzBHVFdvYm1qdEM2NVY1YmNtVkFCUmh1Vzcw?=
 =?utf-8?B?cy9UNmJyT1RwMmhtQStGUitRRVpQR3RWYU9sdjJld0xBOHMvUWEzYTNqT0Zi?=
 =?utf-8?B?V0xWakkxb2Uwa0ZuNXJsSm9zOTQ4SVQ5amlFZ2dnN2NLanROWUdyUTJHQWc2?=
 =?utf-8?B?cHlKcENFUkFHZG5uVXBEWHdoSEVGS1dZUVJRbzZNcVpHS3NDUCt1Q3UxSEM5?=
 =?utf-8?B?UkVQRUVjd1Y3ZjVBcFRlcnFIcUZmMDNjY1o1K1BEL3RpQXRrVklpRmc1TG00?=
 =?utf-8?B?UHZOd1pmcXRlUjVaOXhkd05Pd3p0UnRtZ1JaN3ArUHovZ2VTUFQ3NHA0dENU?=
 =?utf-8?B?dENINGtNeSszQk82amdHb2RnYkVHbkFLMXozNUtteWVLZjN0ZHVqZE9WUGp3?=
 =?utf-8?B?Tm5UREtoalMwWEpHNTNuUXR6ZEo2WFRKdlR4REVJdEo0cWk2M2FoeEU0Nmo2?=
 =?utf-8?B?eFROV2FORHNRMnBCV0dUN3RyejVxUnZKUjJFSEgwZmJXK1RuTVhVNGhvNnNa?=
 =?utf-8?B?UkVwM0FBb3JwMVg5QkZyNjdVVEZuUmcxRkJIMU15TGx1a0E9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?QVRLdms0YzJaVUd4WEszS1ZjbTlrYmlLanh1blNqYWRGYzdnSC9oYlE3RjNW?=
 =?utf-8?B?VFVhdURleE9DZUFxbTkzS2ZqUW9NSG0zaTR0ckhSZHlyUDdDMFI4bWI3UHU0?=
 =?utf-8?B?Zjl1WktibEJrRFlwUFQ2dXpkbkozZnRZTGNvZnF3UXlVZkNBS2YzN0k4cFJF?=
 =?utf-8?B?aU41MSszaDRwejlEcFVmdzNNbVFlVTRBK0dHREZvcVp5d3dwWitmeGZFT0xX?=
 =?utf-8?B?eVVZSUtFUytDRVNzWlUzczc1Q3pFV3E2M3JaTVFYT0hqWkhYdEV1SGtCeTUx?=
 =?utf-8?B?UnIwNUtJQXFlZ2RMeUE5R1h5YmxSalFZT29QUy9aT00zam9xTUVNMHBZRCtF?=
 =?utf-8?B?cUhoVGt1NnZ1by9RcStRdUkxVmt1cHcwODNrREJFWXFZamhteU1uckpsNGg4?=
 =?utf-8?B?WENza0EwZzE2V29GSE5tS1E3K2I5OFhjVUZRbzRjZjVmZjJsVW1Fd3FQOGdF?=
 =?utf-8?B?bGtkcjF2ajMwa0MwVmJYVFQxSVdvNGh5Mk5jTlZySEhMZUc4SmJOc2JhVjRa?=
 =?utf-8?B?QklpUzlScFg5VEdQM0psL2pSUlJJcU9aSVM1WXVKbzhwbTV2c0lDWUcvb09Z?=
 =?utf-8?B?Sy8zYnRzZGUwK0xBODdYWnZXa0tSc1dUaHdFU25QT3pJcmt4YWNxY0p4RWp2?=
 =?utf-8?B?djhBQytkbEx4RnZzTW1rdml1NXVuck9VelZZK1YxbHI5UWhBbUVRN00way9u?=
 =?utf-8?B?eE1FQXRhK0IrbEcxUUxKSzNxVWdEM1hXQlBuUzBxS1hiMGxsa2Y3RjNvZnND?=
 =?utf-8?B?T1FLSnBqUWhEQVJ1ODRhWjBWUHMrRWtJamZuY1c1UW56VHpjZ3FGSDZPWlp2?=
 =?utf-8?B?OFpnTzV0SVd0S1FoQTByMHdzK2cyZ09ydjkrYmV6dnVLWk9ZU3lpd2JJMVdi?=
 =?utf-8?B?MUVtWWpWWWZCdnhoQ3o2R1N6RkdoUE5HMmVYQ1hRQWthbnkwTS9UNkM0dURO?=
 =?utf-8?B?YnB5RCtJNWdCYVdJdUpiWVErUDVPUHVLYXE4VUhKTVlkbkxqM2JqWWh3NVBX?=
 =?utf-8?B?WUR6Q1loangxc0RqVTFMUjNLVEwrcFZtKzlyMEhyd0RnN0xqL092TG02VzBx?=
 =?utf-8?B?SzZXZ3N6b25tRDBzSXNUTStxWHNLQXVSNFI2bU95Z2pXNGw1VXJGQTlHTlBC?=
 =?utf-8?B?RW5vUEkrN0dtT3dFaW45d3J2dVpKejZNWSt6REpTWlFVaWlBVjZwOCs3L2sx?=
 =?utf-8?B?MU95VjVqVmwwdGlUemgxOEV5dGM4R0ZKbjZwMkkyZGFsMW9uWG5PZVdHN2pr?=
 =?utf-8?B?VExndU5sdkZIeW95REdmY2RVVmtpd3gyVXBEeXYvbitBVHdwdzh6Q0Yxb2FF?=
 =?utf-8?B?QlFQdDJjUldzUjdHVlN0dWEvWWRYVmhnYitBQVFycGxEV2ttOEJ2UXQvUWdj?=
 =?utf-8?B?b0sxWThwbFZnaGZuY1hKcXE2NDMrL2hqVjFCaFdBV2ZUVmd5UU9kUW9QSVlo?=
 =?utf-8?B?anllRTBpejFGODI2cmlJaytoQnZ1YzZ3TkpBOHJ6SEtHMGRPM2RCSzkvT1dQ?=
 =?utf-8?B?T1VOZmFmRmUzZDFESVkvMXBaSGNhUGJ6WTBGOVhsSUZXazFIWEF5TXFPN3lY?=
 =?utf-8?B?YkJSSGdQNUYvNnpKRzJkR2pra214WHcyTTBwTUpocnV0anlSbEs2K0JqdE9n?=
 =?utf-8?B?U1dQNHdVMVVqcVhGNWFVRjRyTWR5cGkvVGYyaXpLRXlqYnJzbWVGN3NCcmVh?=
 =?utf-8?B?dmZQRGc3eWczby9CTzJmSXp4NUNXenU1V1F2OTlYTG5nWWZCejFDdjROU21W?=
 =?utf-8?B?d3htYklqYzEwOEZiNFdWbjAwWHczaVlTTFl2aGZqQzNXdVl6amRsbXUwbUpo?=
 =?utf-8?B?emE0YUFyUHByVzF5QkNsN29BcEpRS2J1a1EzMHlZUnZoNXVrTHVSZUFKTFBi?=
 =?utf-8?B?OU5vVEhjcmpHaFA5NVB3dkNiREhsRCtjYUFVN0o3SFpWWVNYWG03ZnE0RVR2?=
 =?utf-8?B?aW1SWU5uUFVhOFo2d2V5RjVINlROV1NuTHpac0xTWmdCakJOR2NIUExOZng4?=
 =?utf-8?B?WXhOMkhyM2JzZkIzSUlUU3YxYzVVTk55VXNpekhLNGM1dGlnSkxYVklYdlVN?=
 =?utf-8?B?RjdGSFpMcDRGQWNsT1RCbVhKekErVFg5YmQrUlJ5dzVaZk5DdjZtM1ZBNUdC?=
 =?utf-8?B?MUhuUVlJeDNWWVZRTkI5QXlxOURnakRINDFUaXVIQ3BWMm5oM3NkaW9BV01K?=
 =?utf-8?B?eWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <15409382C0FC4A4B9C2A8271822542D1@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	CZg4D4GnHDpwNDxVlTWHIBcfK1QhXy7OFe8+gQEl8Kdj7Rtq8RhHuWpEk3Ghod2Ncq1XyLPybTzoLUl8J65hKkllMBNvXWLJtJcNgmy7smzRiqMViI41aZ/wUS0SFjpHkYTKYPC4A7Sr9MgSdlg6mO/0dmTibwWyteeJH+9ZBnuleBvP2jBUuLxJUKcQRsxAk3oxUMGjIxywS1uYs7eBcNeFd/Ob8frODyfRqJj3RHRuhfvIzCpFm9MAFi1ttEC3UVlgu0KGV/e9rwvZ021DFhkGWExL8yeRJ+q2hY0xnzZgi10d14zu9cgm2Rvy4daI39S26akD7AidddzD02nQ90NT5FiNmbr7q0qFil6VdUnpHdyfIlC/k2UAYf8xOmu2pKmTWW3+Kqg8j+gXzc6zsV43rkYLkIjIRCVknM9fhL01mXejTlSQpl27WtNVF0Ch+b2RRPkVql/BECR8HzWDI4Z08RXOPnuNTjKfG0q0pGvSUFlyWMqQUAkUucZzLRJCnfCZknCW2V3gG2Lfw2eNrd58yDyAd2TM76M5CS03aNu5dawJv+Z1qXXt7EJq0J+TlTmjnQpgfOdoa8EVTWAfwNXEOl/pAviKbdgEACyplCw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e696fec6-d154-4273-08bf-08dcd99196e1
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2024 16:30:50.4027
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8eu1LOvNIykEzbqqpGKwmET+iJh9jPLEJHuQ0Rg6zdxAMrwzVWGEGZxSRLDQ5I0VbfHND4vb020jU8+tkrecHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR10MB8052
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-20_08,2024-09-19_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2408220000
 definitions=main-2409200119
X-Proofpoint-GUID: Uh6FC3dwhSHvPvav3D1AY-CeKBQ02WzE
X-Proofpoint-ORIG-GUID: Uh6FC3dwhSHvPvav3D1AY-CeKBQ02WzE

DQoNCj4gT24gU2VwIDIwLCAyMDI0LCBhdCAxMjoyNOKAr1BNLCBKZWZmIExheXRvbiA8amxheXRv
bkBrZXJuZWwub3JnPiB3cm90ZToNCj4gDQo+IE9uIEZyaSwgMjAyNC0wOS0yMCBhdCAxMjowNSAt
MDQwMCwgT2xnYSBLb3JuaWV2c2thaWEgd3JvdGU6DQo+PiBDdXJyZW50LCB0aGUgc2VydmVyIHJl
dHVybnMgdGhhdCBpdCBzdXBwb3J0cyBORlM0X1NIQVJFX1dBTlRfREVMRUdfVElNRVNUQU1QUw0K
Pj4gYnV0IHdoZW4gdGhlIGNsaWVudCBzZW5kcyB0aGF0IG9uIHRoZSBvcGVuLCBrbmZzZCByZXR1
cm5zIGJhY2sgd2l0aA0KPj4gYmFkX3hkciBlcnJvci4NCj4+IA0KPj4gRml4ZXM6IGQwZWFiNzNk
NDhhMCAoIm5mc2Q6IGFkZCBzdXBwb3J0IGZvciBkZWxlZ2F0ZWQgdGltZXN0YW1wcyIpDQo+PiBT
aWduZWQtb2ZmLWJ5OiBPbGdhIEtvcm5pZXZza2FpYSA8b2tvcm5pZXZAcmVkaGF0LmNvbT4NCj4+
IC0tLQ0KPj4gZnMvbmZzZC9uZnM0eGRyLmMgfCAxICsNCj4+IDEgZmlsZSBjaGFuZ2VkLCAxIGlu
c2VydGlvbigrKQ0KPj4gDQo+PiBkaWZmIC0tZ2l0IGEvZnMvbmZzZC9uZnM0eGRyLmMgYi9mcy9u
ZnNkL25mczR4ZHIuYw0KPj4gaW5kZXggYzBiYWQ1ODBhYjZkLi5hZGRhOGI0ODkxNzUgMTAwNjQ0
DQo+PiAtLS0gYS9mcy9uZnNkL25mczR4ZHIuYw0KPj4gKysrIGIvZnMvbmZzZC9uZnM0eGRyLmMN
Cj4+IEBAIC0xMTA5LDYgKzExMDksNyBAQCBzdGF0aWMgX19iZTMyIG5mc2Q0X2RlY29kZV9zaGFy
ZV9hY2Nlc3Moc3RydWN0IG5mc2Q0X2NvbXBvdW5kYXJncyAqYXJncCwgdTMyICpzaA0KPj4gY2Fz
ZSBORlM0X1NIQVJFX1BVU0hfREVMRUdfV0hFTl9VTkNPTlRFTkRFRDoNCj4+IGNhc2UgKE5GUzRf
U0hBUkVfU0lHTkFMX0RFTEVHX1dIRU5fUkVTUkNfQVZBSUwgfA0KPj4gICAgICAgTkZTNF9TSEFS
RV9QVVNIX0RFTEVHX1dIRU5fVU5DT05URU5ERUQpOg0KPj4gKyBjYXNlIE5GUzRfU0hBUkVfV0FO
VF9ERUxFR19USU1FU1RBTVBTOg0KPj4gcmV0dXJuIG5mc19vazsNCj4+IH0NCj4+IHJldHVybiBu
ZnNlcnJfYmFkX3hkcjsNCj4gDQo+IE91Y2guDQo+IA0KPiBUaGUgcHJvYmxlbSBoZXJlIGlzIHRo
YXQgd2UgaGFkIHRvIGRyb3AgdGhlIHBhdGNoIHRoYXQgYWRkZWQNCj4gT1BFTl9YT1JfREVMRUdB
VElPTiBzdXBwb3J0LiBUaGF0IHBhdGNoIHJld29ya2VkIHRoZSBmbGFnIGhhbmRsaW5nIGluDQo+
IHRoaXMgZnVuY3Rpb24gaW4gYSB3YXkgdGhhdCBhbGxvd2VkIHRoZSBuZXcgZGVsc3RpZCBmbGFn
cyB0byBiZQ0KPiBwcm9wZXJseSBzdXBwb3J0ZWQuDQo+IA0KPiBJIHRoaW5rIHdlIHByb2JhYmx5
IHdhbnQgdG8gcmVzdXJyZWN0IHRoZSBwYXJ0cyBvZiB0aGlzIHBhdGNoIHRoYXQNCj4gYWx0ZXIg
bmZzZDRfZGVjb2RlX3NoYXJlX2FjY2VzczoNCj4gDQo+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3Jn
L2xpbnV4LW5mcy8yMDI0MDkwNS1kZWxzdGlkLXY0LTgtZDNlNWZkMzRkMTA3QGtlcm5lbC5vcmcv
DQo+IA0KPiBPbGdhLCB3b3VsZCB5b3UgYmUgT0sgd2l0aCB0aGF0IGFwcHJvYWNoIGluc3RlYWQ/
DQoNCkF0IHRoaXMgcG9pbnQsIEknZCBsaWtlIHRvIGNvbnNpZGVyIHBvc3Rwb25pbmcgdGhlIGRl
bHN0aWQgcGF0Y2hlcw0KdW50aWwgdjYuMTMuIFRoZXkgaGF2ZW4ndCBnb3R0ZW4gZW5vdWdoIHRl
c3RpbmcgaW4gdGhlaXIgY3VycmVudA0KZm9ybS4uLg0KDQotLQ0KQ2h1Y2sgTGV2ZXINCg0KDQo=

