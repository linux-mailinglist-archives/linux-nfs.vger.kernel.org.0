Return-Path: <linux-nfs+bounces-7937-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 392949C790D
	for <lists+linux-nfs@lfdr.de>; Wed, 13 Nov 2024 17:41:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B63981F23368
	for <lists+linux-nfs@lfdr.de>; Wed, 13 Nov 2024 16:41:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5B5F16DEA2;
	Wed, 13 Nov 2024 16:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mceWjz5d";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="wIb4VhyF"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72F3D14F9E9
	for <linux-nfs@vger.kernel.org>; Wed, 13 Nov 2024 16:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731516098; cv=fail; b=q/YrNnrObpc+/VscdA1E+L6SzmsbfPOqFqsHLKBaf41waypq6k7nZzK/BG+jj8BPQKWqfn06Fw2TCAtzhdakJMKtz30zqJh5/pMLc8x/T7zHnJBOR/gMYh+Nmr6zJ76bZ84kESBpBBoB+TtuFW6Q7sr9YCSh4A/YNHIdHafKMNc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731516098; c=relaxed/simple;
	bh=VU58ayjDca7BU3zDPZuYXyesELIMljFGHNy0BouSSNw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YJFC7IgkyOv9zf2yKI+rWn2qGBcBmOEIlmY3Dwqb7sQpSc3dbqBe/GhgJdBM6fKkiyb2BCstiOHOqrA9BWy7mCDDaWw0craLKswR4HfJjlVUmB/SO91JCTVxp6yAV3Fnxf98Rd9ybfWawknzGwQzEl21INsMFax4PwSAIYaGLlI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=mceWjz5d; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=wIb4VhyF; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ADGVdGc008072;
	Wed, 13 Nov 2024 16:37:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=VU58ayjDca7BU3zDPZuYXyesELIMljFGHNy0BouSSNw=; b=
	mceWjz5dHCZ7nIa4PGvU/HW9ObirSO3Api9+A1KxEiQnq4v51UPsc0t3CRj6Ons6
	elcQvB7wbfuu9hqYtl54XfCXivul7vPXzHUi/X+4anXdGMKRKHOD4cWd+XQFORFu
	GN9hSMXEDvUNcTZ1JF0SQGWUU3PBUqgEK6iTNBgfDPfwLqpoRTVl0QaQhXuOz4mI
	XgpuGwg2TlW+mZV3j0JwQr3lmi4r5WkVrFm+m2WGIk2ZYJSK/gKmDU0gjp/dcBeA
	Vl9HABnRyZUrFBf+QZRPrMToO+7ZGk9fkxs1Hoxi/O32zsbHa8tbhm1XwfWYTf/N
	yPZeRdBaZTlHptyCoAXEcQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42t0k5f690-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Nov 2024 16:37:17 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4ADFigJD025881;
	Wed, 13 Nov 2024 16:37:16 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2173.outbound.protection.outlook.com [104.47.55.173])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42sx69jhbk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Nov 2024 16:37:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IqT6OxJsTT0lO5LyOCi8HglJAZcHvN33w8TBvyL/DzAPOz2mjpAD4KDXlPVWIS+yksEgBys0PDGe/ucJHPh61F/PsVnvunP1HrTARIP1xfT21yHAyN4Zn3NJC5GHufc/FW73fNKuZBw1AhvW5uM3JK1na/HXLoPFgRhk2R4CTyvcDvmibYJUNidNNpVp6TNcCzxdUuCrih88l/H717Kd1mG/IQg0M6bP8y9qHT5yOhkX8HlLvriwYqZHd0K/C3R3ST9NKXNgqJhSVfoxMb4RCMkPT0PT6huEzgmq7wDdtj6A0CuLgEcvZWi8beKRNgdTgvtGbCGLMvZS4DF40BRP5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VU58ayjDca7BU3zDPZuYXyesELIMljFGHNy0BouSSNw=;
 b=bzPorC+Y2vxs9StI3bzphJVhWnp8dBY/fpRIiAbXC+jxCtpTW1JiVh0OrIdmyAtccnEZb3nio5bPgHnoE4p1vRKULaqHUR4ssCvga4jR/GnBhYCwcC0j8+P/HSUVV0NIDSmu/fX+FU1SQUPhTIyYrkZ7rsfr2oKYckGCQD76oh8SLbVDDT5PQBD4nZ7yjbN6u8DRdE6cECOi8LB7xumQF9d0GNb1yvG9kZWlSsI3AL5/rzbMw3lP7/btmZeD6LApoUIA6ZCZ+1PCC/WKRZpzBBAfA/Pxir8cebjjhzTuncKl5iowYxYAcdzrQZ0T1RxqUJRlHy4vBbIQFjynmfH0Tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VU58ayjDca7BU3zDPZuYXyesELIMljFGHNy0BouSSNw=;
 b=wIb4VhyFWwjAe4g65QSFxlGARr08KX1vUZVVCFCck6OaTx5Kh/Q0nMbPqPGRW34MC5v/2bhoMx8fLuJAWi5/yUbi6UOe6aeJAcojFXFd3XyP97nvJISX2HYVbkK1hSvI8ddHYc+tRmqC+XrbjKmtxxyaH/GNpel6WdMD05WnIZ4=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CO1PR10MB4625.namprd10.prod.outlook.com (2603:10b6:303:6d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Wed, 13 Nov
 2024 16:37:12 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.8158.013; Wed, 13 Nov 2024
 16:37:11 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Jeff Layton <jlayton@kernel.org>
CC: kernel test robot <oliver.sang@intel.com>,
        Mike Snitzer
	<snitzer@redhat.com>,
        "oe-lkp@lists.linux.dev" <oe-lkp@lists.linux.dev>,
        kernel test robot <lkp@intel.com>, Anna Schumaker <anna@kernel.org>,
        Trond
 Myklebust <trond.myklebust@primarydata.com>,
        Tom Haynes <loghyr@gmail.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [snitzer:cel-nfsd-next-6.12-rc5] [nfsd]  b4be3ccf1c:
 fsmark.app_overhead 92.0% regression
Thread-Topic: [snitzer:cel-nfsd-next-6.12-rc5] [nfsd]  b4be3ccf1c:
 fsmark.app_overhead 92.0% regression
Thread-Index:
 AQHbMNFCR8jSrZBFk0KiMvLsFcBCRbKrsJKAgAm0swCAAAY8gIAAAS2AgAABngCAAASVAA==
Date: Wed, 13 Nov 2024 16:37:11 +0000
Message-ID: <00A9E843-767A-40B6-9963-41C8508A655A@oracle.com>
References: <202411071017.ddd9e9e2-oliver.sang@intel.com>
 <4d5d966b2efc0b5b8c59ef179e99f3f8fbf792f8.camel@kernel.org>
 <ZzTKQGYJFh7PH4Fw@tissot.1015granger.net>
 <48ad2574e14c35aca27c10e68f2a1069ccb646df.camel@kernel.org>
 <ZzTQd5NKe5WXkLlA@tissot.1015granger.net>
 <79e94b2225fa8e4a4723b8941eea79111f77c55f.camel@kernel.org>
In-Reply-To: <79e94b2225fa8e4a4723b8941eea79111f77c55f.camel@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3776.700.51.11.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|CO1PR10MB4625:EE_
x-ms-office365-filtering-correlation-id: fc952b4f-f14c-400c-3090-08dd04016c3a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?QkIreEFWcnVsNDB4bUxpU0thMVQ2MFZIZ2t0ZndxK1BuelRRQjRFMCtVZ2tz?=
 =?utf-8?B?bzdOc3ZLdzJ5MThBdjBvbXVyUWdPczB5em9BS3BHeUVuZnlUbWFRN2lPb3Uz?=
 =?utf-8?B?UTBPcE03ak9pbjRFV2tQdkJ0UG9VdU1aSnFqVC9GZzI2MWhaYlRUQ2s5RFEr?=
 =?utf-8?B?d25EaXVHY1JPeTZhQ0dxemZHd0JBNWdMbXFkUjcvM0hxbWMySjVVVzBWL1Aw?=
 =?utf-8?B?V1lkLzI4b2w5Q0d1Vno5QkpodEcvd2srV1poMlEwaDA0cHVFczJlREE0NmtW?=
 =?utf-8?B?V2ZZaUloZUNUbkdzK2crdndsbXVHVEJEcnZLWUJld1BRUXkzdm9GQWdTNTVx?=
 =?utf-8?B?VVRyUGpaZThDaU1zQWtBdk5sUFZLd3JjSHhZRUpzVmhwTkRJOFZUcW1LNnIz?=
 =?utf-8?B?ZUJFbko0T0FycmM5d2VCSW15RExBSTBIRVNwb3NKa1VsR204UnV5cEZnQUVy?=
 =?utf-8?B?MUIzeGNEMWhSVmxJK3VFbjJ0Q2s5b0lEUnpjMldOaGg0Z1cyTDJ2SHhIdyty?=
 =?utf-8?B?S1VEZWEvend5RE9OR3V6aFQ1R3VPMlYyRnFyUE1QajJicnkyUUNIZGd2Ums1?=
 =?utf-8?B?SzM3U1hxUm1IbXczbWpXZHlvbGJlUjZYMElwbHQwSmV5dlRkN0x4Y2V0MHZD?=
 =?utf-8?B?SnQ2Z0FwL0llUmRpQXQrK0ZHZzhDaUZZK1B5K21Jc25BZDlEVlBnTlljMHJS?=
 =?utf-8?B?aVgwVTlHM3BhVHNHMkNMcUpPQlVGSEs4OGRJOC80VVpSaDlRRm8yNnFQQUg2?=
 =?utf-8?B?ZFpjTkNsWXhyazJodm5icUFwc0Mvcm1aanZ0VU44eUgvMEh4QjRNZVRSR3V6?=
 =?utf-8?B?MEpRUEZGZVhUd0JORWJsSm9yZGRqZnkvNkhPMDFzN0wvcWhKZVdMTTgvM2VC?=
 =?utf-8?B?T0lJRFd3VGxoV0o2dXJhMmJxTzBGZkpKb000MFI4SDJ6dklvQXYyOGx2TGxZ?=
 =?utf-8?B?cDNhOWViSXBpMVJSVTZ6WjFmYU9tS2phZk5taVhwZWp5Q1g2bnNETTRHZ3R1?=
 =?utf-8?B?Z1l6WVZuV0FXRkwzL04zcE10QWNjSkNaTnNtMk5hNFhKRWNQM0pPNnFUVDAy?=
 =?utf-8?B?SUxsZ3dsUGY3TVl2ZDJnTGV3L2pqblVGRml0SU9XUXpkRXh3UGdzRVNzSXl6?=
 =?utf-8?B?NkxFdnB6c1RKdmt1Q1RlSE8vdTZUMElTaWROV1kvVkxJL3dFbWtQaTVZSXRJ?=
 =?utf-8?B?eEVSZzlPWkRRa2lGSHBQdVBCUzVPYzlFUXhETVlQUU1YdDVwbXJrTkpibkZk?=
 =?utf-8?B?Vk5WSkFhNnpJM3JsbG5FbHo1MU9pYzd5T1hWQVg2ajZpVWZGSVhhanZ2aGds?=
 =?utf-8?B?YVpXc3ZZUTVUUEJYT2FmbktVRFJ4WWU5WGhPVWl2ZitTY1BPSmxRd2lMS3Fl?=
 =?utf-8?B?SlRFdkJRQXRqL2p5OS93dzRIQnM4eWZ1UlVnREsvSGFIZ0E0TnVvNTFrcUpp?=
 =?utf-8?B?RGcxT0c1Rnkvc3dVL2xaeCtDUzJSbnoreGZWbGRaOUxzK3JoZ042TklNYkdk?=
 =?utf-8?B?N2U4VWdSMDdoaVJmc2ZVSUEwdjNxWEdqSklRWlNKN1MxSEdkbk1saHFrVFA3?=
 =?utf-8?B?MlRlSUU1RlZKQWlISEJMK0ZjTVJXb3dJUUZKc2V4WElVTkg4TlF2SVA0U0RW?=
 =?utf-8?B?U0hhZlUrZnBIZXVYclNsbEN0dnlpT2dEcTNXU0lZWU4xajU3Nnlqd2JUMENE?=
 =?utf-8?B?RkR2enRlY1VBditkUmRmQlRqUjlQcy9ObG5OVjZYRStOY2UvV09oWkFkT1Aw?=
 =?utf-8?B?WGhOSHFCQjRnSWtGS01RUUtiRTRuOEpwUjAweVV3dUphMTZMZXRxVE9YUDR3?=
 =?utf-8?B?TWR0RUp6bERVdDBCTmludz09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?M084c1laSDI4aVVGanZqTHVFQU1LQWVuRU1SYi9tdE1JMCtMUHFmcTlWQWl5?=
 =?utf-8?B?QkNMeFM4L3c1Q0x5ZzZZTHU5Q0dKQWpTL00ra3N4Z3ZwUTRWTUlWMWhRTlEv?=
 =?utf-8?B?SlZuUk5UTmwzM1lsZ0c5VUs4bVM4UlhlTlBCVjlnME5aRHV1SUdTSFpDS0Yr?=
 =?utf-8?B?MTJoVWZVYzV3UWV1MG1PeEQ4VVp1Z0lURjAzLzUvblA2alhtajI3RGRxb0Z2?=
 =?utf-8?B?MkR2T3M0TDd6OWJCZnRnU0lJYUt3NHV4MVg4UmFaRW5ma0RaL0hLYWFhVmc2?=
 =?utf-8?B?andVeXlTZFpTK01oa2pQOXVxQkQzaWhQa0s1ZXoxdTlFU3F2NGxyQXVNandi?=
 =?utf-8?B?UE1EUDFVYlV1U1NSWHNVQjVoZ2JGbDhlMUhEbm9COU8rYlNRT3ppYzkxWWtT?=
 =?utf-8?B?Y2p1Z0NrSHdKR2l2UWFIU2FBSzZYdUdiZ3FydHZmUUJtT0ZDSTJaSUcwY20v?=
 =?utf-8?B?TzdkK295RWU3bWdWTlRPMG1qUktXTnREbk03VDZCNFhhM3U5T3JvRlloWmlz?=
 =?utf-8?B?WW9IVGF5SUY3a2piZjlCNWttdUgzYnRwb2Z2QkEvQkdlbE9GbGtqNW4zNUJr?=
 =?utf-8?B?bHJZQml6WUlYYmhsT1ZVaU5INE1vUHdoSE1OTitTR3NjNHlTcjBmSGU1RzlS?=
 =?utf-8?B?S0UwaEFrdTc3amxTeHA5ZytpVGNzZmJzcEVYc2lrWkRUQW9LbGJlTEEwVWVG?=
 =?utf-8?B?SFRtaXJra1hxQTdRdDZyQTZ0Ylc1czZiL1FRTE1sdnlHTWxUUm5OQ3ptU0xB?=
 =?utf-8?B?THFHdFIzczh4dUhTS0E5WkhQYVB6MUhBQ0xicVZMbzRmL1kxaHhkbElGUy9a?=
 =?utf-8?B?REhGTkRwVUN4T1FBUXJaR0JtRzVOclY5SmtJMWJJV3N2RGhNRHZtSm9Wa1RX?=
 =?utf-8?B?MlBJd0lZYUN5SU5TQ0Q0QUJSanhEeEp6RFl3S2d4L3o3REtaNlJxZDhXK2li?=
 =?utf-8?B?ZGtCSWFIdmZLYVM1SzVKTmJsOEJPMGgydGZDMG9BRkd4cnZuQXVrZ1QvZ1BI?=
 =?utf-8?B?eHprTURqNTl0QkNPa3hKKzFVVEtNeUY2bjFMcUtJdWcvdW0rbTdtVHRFalhN?=
 =?utf-8?B?VGEvZEFhNHZLSkpRZnp3M2RyQi9za2tHTEErcGNFaVdabnR3WFNscDcrMnJz?=
 =?utf-8?B?b3V1VEpPVkUyQklFTVRqdGZqZlgxYjd0VldINkU5d1NzWkc0emZxYTBFcmQv?=
 =?utf-8?B?OHJYbGFSL1Eya1RtV1NjWTRnSWJEM2hyd2ZOTUhzWWtpNEJodFZzdi9qeHh5?=
 =?utf-8?B?Wmk2bXBsaGlUR3hFMGVKcjJ1R0VCUk1ZTjB4RzVrcGNFN1hqOXhEZ3hYajM2?=
 =?utf-8?B?VXd4TUtFeGxCTUYwVzhIVElOOEFxY3F4WFZwK0ROUGV4ZlBJdjJaZTF1bzl6?=
 =?utf-8?B?UVM3dkZENllSS21vR2RIQUp3aS85bE9EWFdZeFFTYWMwYnJ1NmtDWDgyK0wr?=
 =?utf-8?B?NE5abG0vUnVES2J2S1Rmc1craTZiK1Z2aVIrUW1TejdHd2ViQmREdmJOK0ZI?=
 =?utf-8?B?MEdsTktmeXJ2Z3FMTGlwaldOS2JEc0FOaGRkWG9scnhZOU5JdkFXT1pEVjlP?=
 =?utf-8?B?NVdQNnlKY09lUUNKRHhFRkRWODIrcXFyU2QySWkxbEtQdUErVUUzRzByakNX?=
 =?utf-8?B?anpIQmtoNUZuZWZpam1EeW5yejFCTDhTaEdaQkcrdktlSHorUlRocTJ1QXBP?=
 =?utf-8?B?OWYrUFljSmtJVno1Q2UvbnViMDI0QUsveHpyQ2hQQTBRZHl0ZS9yVUUxU0pI?=
 =?utf-8?B?cVlRMXh2V0x4akU3ZHp3RWJhbkVKL1NOaGF0cGdDMWRaVVFNeCtIQis1ODRx?=
 =?utf-8?B?Zlp5VndWZCtxM1pWMXBEdkVSeUd2dU9zcDM1ODVmRHhxOHc1dGRqa0JaZEQz?=
 =?utf-8?B?MDdZRGVsS1ZMb3F0N0tXelZjVmNZdWxoUTcxekltZG1IV1R6NFhvTEFZV2do?=
 =?utf-8?B?QTlRc2NmQTdlUWYyQ1E2bFhBKzRaZ3Bham5ZejdUNFdlMFZjY09tUjB1S3Zt?=
 =?utf-8?B?TUJaVzI5SFBRY21OdHoxbUttY3YwUjIrTTN4WXBTN0JtU3YyaHNaa0VUK2hm?=
 =?utf-8?B?dHVVQzhRWDJHWWhPZ0ZhYlNQU1dVdW00ZWRSWVVLUHBuaEgrTU1kZmFlUEFH?=
 =?utf-8?B?NFdWK0I0Y0tvNFc3MkpyQm1PbFdyRWFHSXBjbWZCZHBpK3doRjlHa05zUmdk?=
 =?utf-8?B?Umc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C65A5B84EFE57B4B9AECC41C3B90B732@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	HTWYoCtRGmVYh6+6sykV9xC/EeGQ8OTW1SE4OutKV2KT+qOu2NIrxER6KMkaPto6+RGH9BeKzSOuf8lqj3/3/Qrf6dtcssAigmYGaHUxiSNRxvERIressmx1cSEVbZjSSJNKzJ15fGFK4YiQeQxB3z7fQudvFQVFS8EcZDydEEvvP086fA2fvWIUmD23OzCX6d3Dr92KezGsKoumezkR4VoO7fqiV1ltD8un8vDQLylfOsbcU/GSJ8UTgyS0BWQGXM/Fh8L9FB8dFlgockrMteAJq94lJMVUcwZz4BPREYWFZServr5g6+Y2ViQBPypnN4hdWyWL1ZC8tlFGWQ/RCcE2A36FQ+qLs7jGfpCXNx5elWF6gR2uS49/IYN2WA+OS+85DcFwisa99cxY9Exr2CB0z5Dez1p9KZ9ZdlDNGFgkgQCYHkYNNxGDLgGHAfFaxijM9vrAiAyqBQFKujclq+TMd1LcEPKQ5aTHBIn1PlseE5zMAizxCT584IYPXpEkBGQjs+F29Xzelky541DHnDYPbR0qc+zUWy2RS6nc7ChqwAaxTX9lWtVG5fzqAiIn5ka73DfZlMluM2aB0wn4Dh2GApn/+WzaBqhoHp+iHTw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc952b4f-f14c-400c-3090-08dd04016c3a
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2024 16:37:11.3338
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LDEjLRR1Qk5gI2if5efsypI67mbRfUpDmAvDqJsvpRHjqanBKfhEC19aPy0G9mpQBUTV+BJO+OcAsqrqXIEZEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4625
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-13_09,2024-11-13_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 spamscore=0 bulkscore=0 phishscore=0 mlxscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2411130138
X-Proofpoint-ORIG-GUID: FdGhKnOKUEzddnyrdZ9ZEHHqv9PCPTsR
X-Proofpoint-GUID: FdGhKnOKUEzddnyrdZ9ZEHHqv9PCPTsR

DQoNCj4gT24gTm92IDEzLCAyMDI0LCBhdCAxMToyMOKAr0FNLCBKZWZmIExheXRvbiA8amxheXRv
bkBrZXJuZWwub3JnPiB3cm90ZToNCj4gDQo+IE9uIFdlZCwgMjAyNC0xMS0xMyBhdCAxMToxNCAt
MDUwMCwgQ2h1Y2sgTGV2ZXIgd3JvdGU6DQo+PiBPbiBXZWQsIE5vdiAxMywgMjAyNCBhdCAxMTox
MDozNUFNIC0wNTAwLCBKZWZmIExheXRvbiB3cm90ZToNCj4+PiBPbiBXZWQsIDIwMjQtMTEtMTMg
YXQgMTA6NDggLTA1MDAsIENodWNrIExldmVyIHdyb3RlOg0KPj4+PiBPbiBUaHUsIE5vdiAwNywg
MjAyNCBhdCAwNjozNToxMUFNIC0wNTAwLCBKZWZmIExheXRvbiB3cm90ZToNCj4+Pj4+IE9uIFRo
dSwgMjAyNC0xMS0wNyBhdCAxMjo1NSArMDgwMCwga2VybmVsIHRlc3Qgcm9ib3Qgd3JvdGU6DQo+
Pj4+Pj4gaGksIEplZmYgTGF5dG9uLA0KPj4+Pj4+IA0KPj4+Pj4+IGluIGNvbW1pdCBtZXNzYWdl
LCBpdCBpcyBtZW50aW9uZWQgdGhlIGNoYW5nZSBpcyBleHBlY3RlZCB0byBzb2x2ZSB0aGUNCj4+
Pj4+PiAiQXBwIE92ZXJoZWFkIiBvbiB0aGUgZnNfbWFyayB0ZXN0IHdlIHJlcG9ydGVkIGluDQo+
Pj4+Pj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvb2UtbGtwLzIwMjQwOTE2MTY0NS5kNDRiY2Vk
NS1vbGl2ZXIuc2FuZ0BpbnRlbC5jb20vDQo+Pj4+Pj4gDQo+Pj4+Pj4gaG93ZXZlciwgaW4gb3Vy
IHRlc3RzLCB0aGVyZSBpcyBzaWxsIHNpbWlsYXIgcmVncmVzc2lvbi4gYXQgdGhlIHNhbWUNCj4+
Pj4+PiB0aW1lLCB0aGVyZSBpcyBzdGlsbCBubyBwZXJmb3JtYW5jZSBkaWZmZXJlbmNlIGZvciBm
c21hcmsuZmlsZXNfcGVyX3NlYw0KPj4+Pj4+IA0KPj4+Pj4+ICAgMjAxNTg4MCDCsSAgMyUgICAg
ICs5Mi4wJSAgICAzODcwMTY0ICAgICAgICBmc21hcmsuYXBwX292ZXJoZWFkDQo+Pj4+Pj4gICAg
IDE4LjU3ICAgICAgICAgICAgKzAuMCUgICAgICAxOC41NyAgICAgICAgZnNtYXJrLmZpbGVzX3Bl
cl9zZWMNCj4+Pj4+PiANCj4+Pj4+PiANCj4+Pj4+PiBhbm90aGVyIHRoaW5nIGlzIG91ciBib3Qg
YmlzZWN0IHRvIHRoaXMgY29tbWl0IGluIHJlcG8vYnJhbmNoIGFzIGJlbG93IGRldGFpbA0KPj4+
Pj4+IGluZm9ybWF0aW9uLiBpZiB0aGVyZSBpcyBhIG1vcmUgcG9ycGVyIHJlcG8vYnJhbmNoIHRv
IHRlc3QgdGhlIHBhdGNoLCBjb3VsZA0KPj4+Pj4+IHlvdSBsZXQgdXMga25vdz8gdGhhbmtzIGEg
bG90IQ0KPj4+Pj4+IA0KPj4+Pj4+IA0KPj4+Pj4+IA0KPj4+Pj4+IEhlbGxvLA0KPj4+Pj4+IA0K
Pj4+Pj4+IGtlcm5lbCB0ZXN0IHJvYm90IG5vdGljZWQgYSA5Mi4wJSByZWdyZXNzaW9uIG9mIGZz
bWFyay5hcHBfb3ZlcmhlYWQgb246DQo+Pj4+Pj4gDQo+Pj4+Pj4gDQo+Pj4+Pj4gY29tbWl0OiBi
NGJlM2NjZjFjMjUxY2JkM2EzY2Y1MzkxYTgwZmUzYTVmNmYwNzVlICgibmZzZDogaW1wbGVtZW50
IE9QRU5fQVJHU19TSEFSRV9BQ0NFU1NfV0FOVF9PUEVOX1hPUl9ERUxFR0FUSU9OIikNCj4+Pj4+
PiBodHRwczovL2dpdC5rZXJuZWwub3JnL2NnaXQvbGludXgva2VybmVsL2dpdC9zbml0emVyL2xp
bnV4LmdpdCBjZWwtbmZzZC1uZXh0LTYuMTItcmM1DQo+Pj4+Pj4gDQo+Pj4+Pj4gDQo+Pj4+Pj4g
dGVzdGNhc2U6IGZzbWFyaw0KPj4+Pj4+IGNvbmZpZzogeDg2XzY0LXJoZWwtOC4zDQo+Pj4+Pj4g
Y29tcGlsZXI6IGdjYy0xMg0KPj4+Pj4+IHRlc3QgbWFjaGluZTogMTI4IHRocmVhZHMgMiBzb2Nr
ZXRzIEludGVsKFIpIFhlb24oUikgUGxhdGludW0gODM1OCBDUFUgQCAyLjYwR0h6IChJY2UgTGFr
ZSkgd2l0aCAxMjhHIG1lbW9yeQ0KPj4+Pj4+IHBhcmFtZXRlcnM6DQo+Pj4+Pj4gDQo+Pj4+Pj4g
aXRlcmF0aW9uczogMXgNCj4+Pj4+PiBucl90aHJlYWRzOiAxdA0KPj4+Pj4+IGRpc2s6IDFIREQN
Cj4+Pj4+PiBmczogYnRyZnMNCj4+Pj4+PiBmczI6IG5mc3Y0DQo+Pj4+Pj4gZmlsZXNpemU6IDRL
DQo+Pj4+Pj4gdGVzdF9zaXplOiA0ME0NCj4+Pj4+PiBzeW5jX21ldGhvZDogZnN5bmNCZWZvcmVD
bG9zZQ0KPj4+Pj4+IG5yX2ZpbGVzX3Blcl9kaXJlY3Rvcnk6IDFmcGQNCj4+Pj4+PiBjcHVmcmVx
X2dvdmVybm9yOiBwZXJmb3JtYW5jZQ0KPj4+Pj4+IA0KPj4+Pj4+IA0KPj4+Pj4+IA0KPj4+Pj4+
IA0KPj4+Pj4+IElmIHlvdSBmaXggdGhlIGlzc3VlIGluIGEgc2VwYXJhdGUgcGF0Y2gvY29tbWl0
IChpLmUuIG5vdCBqdXN0IGEgbmV3IHZlcnNpb24gb2YNCj4+Pj4+PiB0aGUgc2FtZSBwYXRjaC9j
b21taXQpLCBraW5kbHkgYWRkIGZvbGxvd2luZyB0YWdzDQo+Pj4+Pj4+IFJlcG9ydGVkLWJ5OiBr
ZXJuZWwgdGVzdCByb2JvdCA8b2xpdmVyLnNhbmdAaW50ZWwuY29tPg0KPj4+Pj4+PiBDbG9zZXM6
IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL29lLWxrcC8yMDI0MTEwNzEwMTcuZGRkOWU5ZTItb2xp
dmVyLnNhbmdAaW50ZWwuY29tDQo+Pj4+Pj4gDQo+Pj4+Pj4gDQo+Pj4+Pj4gRGV0YWlscyBhcmUg
YXMgYmVsb3c6DQo+Pj4+Pj4gLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0+DQo+Pj4+Pj4gDQo+Pj4+Pj4gDQo+Pj4+Pj4gVGhlIGtlcm5lbCBjb25maWcgYW5kIG1hdGVy
aWFscyB0byByZXByb2R1Y2UgYXJlIGF2YWlsYWJsZSBhdDoNCj4+Pj4+PiBodHRwczovL2Rvd25s
b2FkLjAxLm9yZy8wZGF5LWNpL2FyY2hpdmUvMjAyNDExMDcvMjAyNDExMDcxMDE3LmRkZDllOWUy
LW9saXZlci5zYW5nQGludGVsLmNvbQ0KPj4+Pj4+IA0KPj4+Pj4+ID09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09DQo+Pj4+Pj4gY29tcGlsZXIvY3B1ZnJlcV9nb3Zlcm5vci9kaXNrL2Zp
bGVzaXplL2ZzMi9mcy9pdGVyYXRpb25zL2tjb25maWcvbnJfZmlsZXNfcGVyX2RpcmVjdG9yeS9u
cl90aHJlYWRzL3Jvb3Rmcy9zeW5jX21ldGhvZC90Ym94X2dyb3VwL3Rlc3Rfc2l6ZS90ZXN0Y2Fz
ZToNCj4+Pj4+PiAgZ2NjLTEyL3BlcmZvcm1hbmNlLzFIREQvNEsvbmZzdjQvYnRyZnMvMXgveDg2
XzY0LXJoZWwtOC4zLzFmcGQvMXQvZGViaWFuLTEyLXg4Nl82NC0yMDI0MDIwNi5jZ3ovZnN5bmNC
ZWZvcmVDbG9zZS9sa3AtaWNsLTJzcDYvNDBNL2ZzbWFyaw0KPj4+Pj4+IA0KPj4+Pj4+IGNvbW1p
dDogDQo+Pj4+Pj4gIDM3ZjI3YjIwY2QgKCJuZnNkOiBhZGQgc3VwcG9ydCBmb3IgRkFUVFI0X09Q
RU5fQVJHVU1FTlRTIikNCj4+Pj4+PiAgYjRiZTNjY2YxYyAoIm5mc2Q6IGltcGxlbWVudCBPUEVO
X0FSR1NfU0hBUkVfQUNDRVNTX1dBTlRfT1BFTl9YT1JfREVMRUdBVElPTiIpDQo+Pj4+Pj4gDQo+
Pj4+Pj4gMzdmMjdiMjBjZDY0ZTJlMCBiNGJlM2NjZjFjMjUxY2JkM2EzY2Y1MzkxYTggDQo+Pj4+
Pj4gLS0tLS0tLS0tLS0tLS0tLSAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0gDQo+Pj4+Pj4g
ICAgICAgICAlc3RkZGV2ICAgICAlY2hhbmdlICAgICAgICAgJXN0ZGRldg0KPj4+Pj4+ICAgICAg
ICAgICAgIFwgICAgICAgICAgfCAgICAgICAgICAgICAgICBcICANCj4+Pj4+PiAgICAgOTcuMzMg
wrEgIDklICAgICAtMTYuMyUgICAgICA4MS41MCDCsSAgOSUgIHBlcmYtYzJjLkhJVE0ubG9jYWwN
Cj4+Pj4+PiAgICAgIDM3ODggwrExMDElICAgICsxNDcuNSUgICAgICAgOTM3NyDCsSAgNiUgIHNj
aGVkX2RlYnVnLmNmc19ycTovLmxvYWRfYXZnLm1heA0KPj4+Pj4+ICAgICAgMjkzNiAgICAgICAg
ICAgIC02LjIlICAgICAgIDI3NTUgICAgICAgIHZtc3RhdC5zeXN0ZW0uY3MNCj4+Pj4+PiAgIDIw
MTU4ODAgwrEgIDMlICAgICArOTIuMCUgICAgMzg3MDE2NCAgICAgICAgZnNtYXJrLmFwcF9vdmVy
aGVhZA0KPj4+Pj4+ICAgICAxOC41NyAgICAgICAgICAgICswLjAlICAgICAgMTguNTcgICAgICAg
IGZzbWFyay5maWxlc19wZXJfc2VjDQo+Pj4+Pj4gICAgIDUzNDIwICAgICAgICAgICAtMTcuMyUg
ICAgICA0NDE4NSAgICAgICAgZnNtYXJrLnRpbWUudm9sdW50YXJ5X2NvbnRleHRfc3dpdGNoZXMN
Cj4+Pj4+PiAgICAgIDEuNTAgwrEgIDclICAgICArMTMuNCUgICAgICAgMS43MCDCsSAgMyUgIHBl
cmYtc2NoZWQud2FpdF90aW1lLmF2Zy5tcy5kZXZrbXNnX3JlYWQudmZzX3JlYWQua3N5c19yZWFk
LmRvX3N5c2NhbGxfNjQNCj4+Pj4+PiAgICAgIDMuMDAgwrEgIDclICAgICArMTMuNCUgICAgICAg
My40MCDCsSAgMyUgIHBlcmYtc2NoZWQud2FpdF90aW1lLm1heC5tcy5kZXZrbXNnX3JlYWQudmZz
X3JlYWQua3N5c19yZWFkLmRvX3N5c2NhbGxfNjQNCj4+Pj4+PiAgIDE3NTY5NTcgICAgICAgICAg
ICAtMi4xJSAgICAxNzIwNTM2ICAgICAgICBwcm9jLXZtc3RhdC5udW1hX2hpdA0KPj4+Pj4+ICAg
MTYyNDQ5NiAgICAgICAgICAgIC0yLjIlICAgIDE1ODgwMzkgICAgICAgIHByb2Mtdm1zdGF0Lm51
bWFfbG9jYWwNCj4+Pj4+PiAgICAgIDEuMjggwrEgIDQlICAgICAgLTguMiUgICAgICAgMS4xNyDC
sSAgMyUgIHBlcmYtc3RhdC5pLk1QS0kNCj4+Pj4+PiAgICAgIDI5MTYgICAgICAgICAgICAtNi4y
JSAgICAgICAyNzM1ICAgICAgICBwZXJmLXN0YXQuaS5jb250ZXh0LXN3aXRjaGVzDQo+Pj4+Pj4g
ICAgICAxNTI5IMKxICA0JSAgICAgICs4LjIlICAgICAgIDE2NTUgwrEgIDMlICBwZXJmLXN0YXQu
aS5jeWNsZXMtYmV0d2Vlbi1jYWNoZS1taXNzZXMNCj4+Pj4+PiAgICAgIDI5MTAgICAgICAgICAg
ICAtNi4yJSAgICAgICAyNzI5ICAgICAgICBwZXJmLXN0YXQucHMuY29udGV4dC1zd2l0Y2hlcw0K
Pj4+Pj4+ICAgICAgMC42NyDCsSAxNSUgICAgICAtMC40ICAgICAgICAwLjI3IMKxMTAwJSAgcGVy
Zi1wcm9maWxlLmNhbGx0cmFjZS5jeWNsZXMtcHAuX0ZvcmsNCj4+Pj4+PiAgICAgIDAuOTUgwrEg
MTUlICAgICAgKzAuMyAgICAgICAgMS4yNiDCsSAxMSUgIHBlcmYtcHJvZmlsZS5jYWxsdHJhY2Uu
Y3ljbGVzLXBwLl9fc2NoZWRfc2V0YWZmaW5pdHkuc2NoZWRfc2V0YWZmaW5pdHkuX194NjRfc3lz
X3NjaGVkX3NldGFmZmluaXR5LmRvX3N5c2NhbGxfNjQuZW50cnlfU1lTQ0FMTF82NF9hZnRlcl9o
d2ZyYW1lDQo+Pj4+Pj4gICAgICAwLjcwIMKxIDQ3JSAgICAgICswLjMgICAgICAgIDEuMDQgwrEg
IDklICBwZXJmLXByb2ZpbGUuY2FsbHRyYWNlLmN5Y2xlcy1wcC5fbm9oel9pZGxlX2JhbGFuY2Uu
ZG9faWRsZS5jcHVfc3RhcnR1cF9lbnRyeS5zdGFydF9zZWNvbmRhcnkuY29tbW9uX3N0YXJ0dXBf
NjQNCj4+Pj4+PiAgICAgIDAuNTIgwrEgNDUlICAgICAgKzAuMyAgICAgICAgMC44NiDCsSAxNSUg
IHBlcmYtcHJvZmlsZS5jYWxsdHJhY2UuY3ljbGVzLXBwLnNlcV9yZWFkX2l0ZXIudmZzX3JlYWQu
a3N5c19yZWFkLmRvX3N5c2NhbGxfNjQuZW50cnlfU1lTQ0FMTF82NF9hZnRlcl9od2ZyYW1lDQo+
Pj4+Pj4gICAgICAwLjcyIMKxIDUwJSAgICAgICswLjQgICAgICAgIDEuMTIgwrEgMTglICBwZXJm
LXByb2ZpbGUuY2FsbHRyYWNlLmN5Y2xlcy1wcC5saW5rX3BhdGhfd2Fsay5wYXRoX29wZW5hdC5k
b19maWxwX29wZW4uZG9fc3lzX29wZW5hdDIuX194NjRfc3lzX29wZW5hdA0KPj4+Pj4+ICAgICAg
MS4yMiDCsSAyNiUgICAgICArMC40ICAgICAgICAxLjY3IMKxIDEyJSAgcGVyZi1wcm9maWxlLmNh
bGx0cmFjZS5jeWNsZXMtcHAuc2NoZWRfc2V0YWZmaW5pdHkuZXZsaXN0X2NwdV9pdGVyYXRvcl9f
bmV4dC5yZWFkX2NvdW50ZXJzLnByb2Nlc3NfaW50ZXJ2YWwuZGlzcGF0Y2hfZXZlbnRzDQo+Pj4+
Pj4gICAgICAyLjIwIMKxIDExJSAgICAgICswLjYgICAgICAgIDIuNzggwrEgMTMlICBwZXJmLXBy
b2ZpbGUuY2FsbHRyYWNlLmN5Y2xlcy1wcC5kb19zeXNjYWxsXzY0LmVudHJ5X1NZU0NBTExfNjRf
YWZ0ZXJfaHdmcmFtZS5yZWFkDQo+Pj4+Pj4gICAgICAyLjIwIMKxIDExJSAgICAgICswLjYgICAg
ICAgIDIuODIgwrEgMTIlICBwZXJmLXByb2ZpbGUuY2FsbHRyYWNlLmN5Y2xlcy1wcC5lbnRyeV9T
WVNDQUxMXzY0X2FmdGVyX2h3ZnJhbWUucmVhZA0KPj4+Pj4+ICAgICAgMi4wMyDCsSAxMyUgICAg
ICArMC42ICAgICAgICAyLjY3IMKxIDEzJSAgcGVyZi1wcm9maWxlLmNhbGx0cmFjZS5jeWNsZXMt
cHAua3N5c19yZWFkLmRvX3N5c2NhbGxfNjQuZW50cnlfU1lTQ0FMTF82NF9hZnRlcl9od2ZyYW1l
LnJlYWQNCj4+Pj4+PiAgICAgIDAuNjggwrEgMTUlICAgICAgLTAuMiAgICAgICAgMC40NyDCsSAx
OSUgIHBlcmYtcHJvZmlsZS5jaGlsZHJlbi5jeWNsZXMtcHAuX0ZvcmsNCj4+Pj4+PiAgICAgIDAu
NTYgwrEgMTUlICAgICAgLTAuMSAgICAgICAgMC40MiDCsSAxNiUgIHBlcmYtcHJvZmlsZS5jaGls
ZHJlbi5jeWNsZXMtcHAudGNwX3Y2X2RvX3Jjdg0KPj4+Pj4+ICAgICAgMC40NiDCsSAxMyUgICAg
ICAtMC4xICAgICAgICAwLjM1IMKxIDE2JSAgcGVyZi1wcm9maWxlLmNoaWxkcmVuLmN5Y2xlcy1w
cC5hbGxvY19wYWdlc19tcG9sX25vcHJvZg0KPj4+Pj4+ICAgICAgMC4xMCDCsSA3NSUgICAgICAr
MC4yICAgICAgICAwLjI5IMKxIDE5JSAgcGVyZi1wcm9maWxlLmNoaWxkcmVuLmN5Y2xlcy1wcC5y
ZWZyZXNoX2NwdV92bV9zdGF0cw0KPj4+Pj4+ICAgICAgMC4yOCDCsSAzMyUgICAgICArMC4yICAg
ICAgICAwLjQ3IMKxIDE2JSAgcGVyZi1wcm9maWxlLmNoaWxkcmVuLmN5Y2xlcy1wcC5zaG93X3N0
YXQNCj4+Pj4+PiAgICAgIDAuMzQgwrEgMzIlICAgICAgKzAuMiAgICAgICAgMC41NCDCsSAxNiUg
IHBlcmYtcHJvZmlsZS5jaGlsZHJlbi5jeWNsZXMtcHAuZm9sZF92bV9udW1hX2V2ZW50cw0KPj4+
Pj4+ICAgICAgMC4zNyDCsSAxMSUgICAgICArMC4zICAgICAgICAwLjYzIMKxIDIzJSAgcGVyZi1w
cm9maWxlLmNoaWxkcmVuLmN5Y2xlcy1wcC5zZXR1cF9pdGVtc19mb3JfaW5zZXJ0DQo+Pj4+Pj4g
ICAgICAwLjg4IMKxIDE1JSAgICAgICswLjMgICAgICAgIDEuMTYgwrEgMTIlICBwZXJmLXByb2Zp
bGUuY2hpbGRyZW4uY3ljbGVzLXBwLl9fc2V0X2NwdXNfYWxsb3dlZF9wdHINCj4+Pj4+PiAgICAg
IDAuMzcgwrEgMTQlICAgICAgKzAuMyAgICAgICAgMC42NyDCsSA2MSUgIHBlcmYtcHJvZmlsZS5j
aGlsZHJlbi5jeWNsZXMtcHAuYnRyZnNfd3JpdGVwYWdlcw0KPj4+Pj4+ICAgICAgMC4zNyDCsSAx
NCUgICAgICArMC4zICAgICAgICAwLjY3IMKxIDYxJSAgcGVyZi1wcm9maWxlLmNoaWxkcmVuLmN5
Y2xlcy1wcC5leHRlbnRfd3JpdGVfY2FjaGVfcGFnZXMNCj4+Pj4+PiAgICAgIDAuNjQgwrEgMTkl
ICAgICAgKzAuMyAgICAgICAgMC45NCDCsSAxNSUgIHBlcmYtcHJvZmlsZS5jaGlsZHJlbi5jeWNs
ZXMtcHAuYnRyZnNfaW5zZXJ0X2VtcHR5X2l0ZW1zDQo+Pj4+Pj4gICAgICAwLjM4IMKxIDEyJSAg
ICAgICswLjMgICAgICAgIDAuNjggwrEgNTglICBwZXJmLXByb2ZpbGUuY2hpbGRyZW4uY3ljbGVz
LXBwLmJ0cmZzX2ZkYXRhd3JpdGVfcmFuZ2UNCj4+Pj4+PiAgICAgIDAuMzIgwrEgMjMlICAgICAg
KzAuMyAgICAgICAgMC42MyDCsSA2NCUgIHBlcmYtcHJvZmlsZS5jaGlsZHJlbi5jeWNsZXMtcHAu
ZXh0ZW50X3dyaXRlcGFnZQ0KPj4+Pj4+ICAgICAgMC45NyDCsSAxNCUgICAgICArMC4zICAgICAg
ICAxLjMxIMKxIDEwJSAgcGVyZi1wcm9maWxlLmNoaWxkcmVuLmN5Y2xlcy1wcC5fX3NjaGVkX3Nl
dGFmZmluaXR5DQo+Pj4+Pj4gICAgICAxLjA3IMKxIDE2JSAgICAgICswLjQgICAgICAgIDEuNDQg
wrEgMTAlICBwZXJmLXByb2ZpbGUuY2hpbGRyZW4uY3ljbGVzLXBwLl9feDY0X3N5c19zY2hlZF9z
ZXRhZmZpbml0eQ0KPj4+Pj4+ICAgICAgMS4zOSDCsSAxOCUgICAgICArMC41ICAgICAgICAxLjkw
IMKxIDEyJSAgcGVyZi1wcm9maWxlLmNoaWxkcmVuLmN5Y2xlcy1wcC5zZXFfcmVhZF9pdGVyDQo+
Pj4+Pj4gICAgICAwLjM0IMKxIDMwJSAgICAgICswLjIgICAgICAgIDAuNTIgwrEgMTYlICBwZXJm
LXByb2ZpbGUuc2VsZi5jeWNsZXMtcHAuZm9sZF92bV9udW1hX2V2ZW50cw0KPj4+Pj4+IA0KPj4+
Pj4+IA0KPj4+Pj4+IA0KPj4+Pj4+IA0KPj4+Pj4+IERpc2NsYWltZXI6DQo+Pj4+Pj4gUmVzdWx0
cyBoYXZlIGJlZW4gZXN0aW1hdGVkIGJhc2VkIG9uIGludGVybmFsIEludGVsIGFuYWx5c2lzIGFu
ZCBhcmUgcHJvdmlkZWQNCj4+Pj4+PiBmb3IgaW5mb3JtYXRpb25hbCBwdXJwb3NlcyBvbmx5LiBB
bnkgZGlmZmVyZW5jZSBpbiBzeXN0ZW0gaGFyZHdhcmUgb3Igc29mdHdhcmUNCj4+Pj4+PiBkZXNp
Z24gb3IgY29uZmlndXJhdGlvbiBtYXkgYWZmZWN0IGFjdHVhbCBwZXJmb3JtYW5jZS4NCj4+Pj4+
PiANCj4+Pj4+PiANCj4+Pj4+IA0KPj4+Pj4gVGhpcyBwYXRjaCAoYjRiZTNjY2YxYykgaXMgZXhj
ZWVkaW5nbHkgc2ltcGxlLCBzbyBJIGRvdWJ0IGl0J3MgY2F1c2luZw0KPj4+Pj4gYSBwZXJmb3Jt
YW5jZSByZWdyZXNzaW9uIGluIHRoZSBzZXJ2ZXIuIFRoZSBvbmx5IHRoaW5nIEkgY2FuIGZpZ3Vy
ZQ0KPj4+Pj4gaGVyZSBpcyB0aGF0IHRoaXMgdGVzdCBpcyBjYXVzaW5nIHRoZSBzZXJ2ZXIgdG8g
cmVjYWxsIHRoZSBkZWxlZ2F0aW9uDQo+Pj4+PiB0aGF0IGl0IGhhbmRzIG91dCwgYW5kIHRoZW4g
dGhlIGNsaWVudCBoYXMgdG8gZ28gYW5kIGVzdGFibGlzaCBhIG5ldw0KPj4+Pj4gb3BlbiBzdGF0
ZWlkIGluIG9yZGVyIHRvIHJldHVybiBpdC4gVGhhdCB3b3VsZCBsaWtlbHkgYmUgc2xvd2VyIHRo
YW4NCj4+Pj4+IGp1c3QgaGFuZGluZyBvdXQgYm90aCBhbiBvcGVuIGFuZCBkZWxlZ2F0aW9uIHN0
YXRlaWQgaW4gdGhlIGZpcnN0DQo+Pj4+PiBwbGFjZS4NCj4+Pj4+IA0KPj4+Pj4gSSBkb24ndCB0
aGluayB0aGVyZSBpcyBhbnl0aGluZyB3ZSBjYW4gZG8gYWJvdXQgdGhhdCB0aG91Z2gsIHNpbmNl
IHRoZQ0KPj4+Pj4gZmVhdHVyZSBzZWVtcyB0byBpcyB3b3JraW5nIGFzIGRlc2lnbmVkLg0KPj4+
PiANCj4+Pj4gV2Ugc2VlbSB0byBoYXZlIGhpdCB0aGlzIHByb2JsZW0gYmVmb3JlLiBUaGF0IG1h
a2VzIG1lIHdvbmRlcg0KPj4+PiB3aGV0aGVyIGl0IGlzIGFjdHVhbGx5IHdvcnRoIHN1cHBvcnRp
bmcgdGhlIFhPUiBmbGFnIGF0IGFsbC4gQWZ0ZXINCj4+Pj4gYWxsLCB0aGUgY2xpZW50IHNlbmRz
IHRoZSBDTE9TRSBhc3luY2hyb25vdXNseTsgYXBwbGljYXRpb25zIGFyZSBub3QNCj4+Pj4gYmVp
bmcgaGVsZCB1cCB3aGlsZSB0aGUgdW5uZWVkZWQgc3RhdGUgSUQgaXMgcmV0dXJuZWQuDQo+Pj4+
IA0KPj4+PiBDYW4gWE9SIHN1cHBvcnQgYmUgZGlzYWJsZWQgZm9yIG5vdz8gSSBkb24ndCB3YW50
IHRvIGFkZCBhbg0KPj4+PiBhZG1pbmlzdHJhdGl2ZSBpbnRlcmZhY2UgZm9yIHRoYXQsIGJ1dCBh
bHNvLCAibm8gcmVncmVzc2lvbnMiIGlzDQo+Pj4+IHJpbmdpbmcgaW4gbXkgZWFycywgYW5kIDky
JSBpcyBhIG1pZ2h0eSBub3RpY2VhYmxlIG9uZS4NCj4+PiANCj4+PiBUbyBiZSBjbGVhciwgdGhp
cyBpbmNyZWFzZSBpcyBmb3IgdGhlICJBcHAgT3ZlcmhlYWQiIHdoaWNoIGlzIGFsbCBvZg0KPj4+
IHRoZSBvcGVyYXRpb25zIGJldHdlZW4gdGhlIHN0dWZmIHRoYXQgaXMgYmVpbmcgbWVhc3VyZWQg
aW4gdGhpcyB0ZXN0LiBJDQo+Pj4gZGlkIHJ1biB0aGlzIHRlc3QgZm9yIGEgYml0IGFuZCBnb3Qg
c2ltaWxhciByZXN1bHRzLCBidXQgd2FzIG5ldmVyIGFibGUNCj4+PiB0byBuYWlsIGRvd24gd2hl
cmUgdGhlIG92ZXJoZWFkIGNhbWUgZnJvbS4gTXkgc3BlY3VsYXRpb24gaXMgdGhhdCBpdCdzDQo+
Pj4gdGhlIHJlY2FsbCBhbmQgcmVlc3RhYmxpc2htZW50IG9mIGFuIG9wZW4gc3RhdGVpZCB0aGF0
IHNsb3dzIHRoaW5ncw0KPj4+IGRvd24sIGJ1dCBJIG5ldmVyIGNvdWxkIGZ1bGx5IGNvbmZpcm0g
aXQuDQo+Pj4gDQo+Pj4gTXkgaXNzdWUgd2l0aCBkaXNhYmxpbmcgdGhpcyBpcyB0aGF0IHRoZSBk
ZWNpc2lvbiBvZiB3aGV0aGVyIHRvIHNldA0KPj4+IE9QRU5fWE9SX0RFTEVHQVRJT04gaXMgdXAg
dG8gdGhlIGNsaWVudC4gVGhlIHNlcnZlciBpbiB0aGlzIGNhc2UgaXMNCj4+PiBqdXN0IGRvaW5n
IHdoYXQgdGhlIGNsaWVudCBhc2tzLiBJU1RNIHRoYXQgaWYgd2Ugd2VyZSBnb2luZyB0byBkaXNh
YmxlDQo+Pj4gKG9yIHRocm90dGxlKSB0aGlzIGFueXdoZXJlLCB0aGF0IHNob3VsZCBiZSBkb25l
IGJ5IHRoZSBjbGllbnQuDQo+PiANCj4+IElmIHRoZSBjbGllbnQgc2V0cyB0aGUgWE9SIGZsYWcs
IE5GU0QgY291bGQgc2ltcGx5IHJldHVybiBvbmx5IGFuDQo+PiBPUEVOIHN0YXRlaWQsIGZvciBp
bnN0YW5jZS4NCj4gDQo+IFN1cmUsIGJ1dCB0aGVuIGl0J3MgZGlzYWJsZWQgZm9yIGV2ZXJ5b25l
LCBmb3IgZXZlcnkgd29ya2xvYWQuIFRoZXJlDQo+IG1heSBiZSB3b3JrbG9hZHMgdGhlIGJlbmVm
aXQgdG9vLg0KDQpJdCBkb2Vzbid0IGltcGFjdCBORlN2NC5bMDFdIG1vdW50cywgbm9yIHdpbGwg
aXQgaW1wYWN0IGFueQ0Kd29ya2xvYWQgb24gYSBjbGllbnQgdGhhdCBkb2VzIG5vdCBub3cgc3Vw
cG9ydCBYT1IuDQoNCkkgZG9uJ3QgdGhpbmsgd2UgbmVlZCBiYWQgcHJlc3MgYXJvdW5kIHRoaXMg
ZmVhdHVyZSwgbm9yIGRvIHdlDQp3YW50IGNvbXBsYWludHMgYWJvdXQgIndoeSBkaWRuJ3QgeW91
IGFkZCBhIHN3aXRjaCB0byBkaXNhYmxlDQp0aGlzPyIuIEknZCBhbHNvIGxpa2UgdG8gYXZvaWQg
YSBidWcgZmlsZWQgZm9yIHRoaXMgcmVncmVzc2lvbg0KaWYgaXQgZ2V0cyBtZXJnZWQuDQoNCkNh
biB5b3UgdGVzdCB0byBzZWUgaWYgcmV0dXJuaW5nIG9ubHkgdGhlIE9QRU4gc3RhdGVpZCBtYWtl
cyB0aGUNCnJlZ3Jlc3Npb24gZ28gYXdheT8gVGhlIGJlaGF2aW9yIHdvdWxkIGJlIGluIHBsYWNl
IG9ubHkgdW50aWwNCnRoZXJlIGlzIGEgcm9vdCBjYXVzZSBhbmQgYSB3YXkgdG8gYXZvaWQgdGhl
IHJlZ3Jlc3Npb24uDQoNCg0KLS0NCkNodWNrIExldmVyDQoNCg0K

