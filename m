Return-Path: <linux-nfs+bounces-1069-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 100C782C8ED
	for <lists+linux-nfs@lfdr.de>; Sat, 13 Jan 2024 02:53:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 123651C21CB8
	for <lists+linux-nfs@lfdr.de>; Sat, 13 Jan 2024 01:53:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 238971A5B5;
	Sat, 13 Jan 2024 01:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="RvA5893y";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ZLDsNFU1"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31DD41A594
	for <linux-nfs@vger.kernel.org>; Sat, 13 Jan 2024 01:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40D1W0uK000881;
	Sat, 13 Jan 2024 01:53:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=LzEfbWms+fVm4lSYiPPh5VNzxN30OgWpRoFrBXAtC1k=;
 b=RvA5893yD0RpKM5vDf+h6V4fjrN97lWvRSAH8fXhRe8TJV4bYtXPPpz/HJJaKaWdw4G9
 RkzkiH1PfK/wgbc+l4W4xacnzo2e4bJPCYOh2evhvWdmUH4dJ/KzceRTG8AiOVTS6eQE
 rHvj3dU7dYLj/vMjN/xnlrt+m8V6rGMULOJ0dDP4Vl4jIdYcvVrlu3yloFH5/vegsyvC
 5pdt/Gk2m35dQ3xkseb6I261uGlo5VcjUnKPO9g+TNA7hzOhLhaw6GPGO5ZKmaeN890k
 9nzZwXDcVQ+2NGFlqN5f97/ZzRciKZXpkOosbchIj5Q+Vkwt54Fa08pzyzlo+Zq+qHJx WA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vkgxdg13u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 13 Jan 2024 01:53:10 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40D1XB5X009484;
	Sat, 13 Jan 2024 01:53:09 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3vkgy38c0b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 13 Jan 2024 01:53:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QTfkoOUsk3q/vs7yuoFSby/fmyPiHzok05C5+d4ifOsvYn42zxG8zkCrm7b8qHDrGq0WRuEENBpQz10v+v14R8oLtQF9g6WEAgg2YSFECYKXribxWFS0kkoYg3moRpza2w7fHqm/PE+iYvQUEr3tRaaWBWXcZGid25dyu4W5ZdS2J7bDJCWI2Gk0d47QTIJE9Ko7KmVBBqWQIZW51zHnvs4UPkJSVYNAOJYepKGzgMolPhRvQ3acFdBxkTVFl/vJJNR44AUWSOKnydRni0ad+mIQUADFDWzqS90rZijjZOUtNNbOTYCYEHsmZEqoPp5ZvSdKG3wTji4ocx0+/6Shtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LzEfbWms+fVm4lSYiPPh5VNzxN30OgWpRoFrBXAtC1k=;
 b=bAo9vgAvUqmz6ZmLpwT/nDBRkevn1Pgay2tgnGknUfa9py8nFtru5+gYoXwO3F92K9YpqQvcEqGByaCVrAKRB6UatCwrf3C+98bb/YwVaT6+3KUNVbk8fR/NTn5Qq5cHnZfC9KnN1P164TfIB9vVGejeUuHX7bUeiaOGryh/ixNmjVvJWLcXTuDJ0AWYhfiOdXpwXSzUGSr0Yg7gYf05SRf269ZJmIjO9T9t9R55P3VO6IJ3F1ZBTlGJ2NpSqitaQOxzLwLrkR0NgOMQXf/tB/5NUS3Qn4d/7Bw5+mashxpAto2nhJAjmXnyNsqXccmymMqwASo61dGRVjCKVgEbYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LzEfbWms+fVm4lSYiPPh5VNzxN30OgWpRoFrBXAtC1k=;
 b=ZLDsNFU1kyVHpQi5HSHxTFNdTvew25jkh0HGSFiGYwNYo/gWirwmAwCc1CGAeJ4bwKuouR9FYcrrmaPBwMS5qBhnt5P5CrQu50vvm1Uo9fNlyyFUfX9Xs7cFxDEziYd9N/yvCr22vr1H9iVLfY5i4vf3apXe7pepYprngTGM6nE=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SJ0PR10MB4672.namprd10.prod.outlook.com (2603:10b6:a03:2af::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.21; Sat, 13 Jan
 2024 01:53:07 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::4027:2de1:2be4:d12e]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::4027:2de1:2be4:d12e%3]) with mapi id 15.20.7181.020; Sat, 13 Jan 2024
 01:53:07 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Dan Shelton <dan.f.shelton@gmail.com>
CC: Jeff Layton <jlayton@kernel.org>,
        Linux NFS Mailing List
	<linux-nfs@vger.kernel.org>
Subject: Re: Increasing NFSD_MAX_OPS_PER_COMPOUND to 96
Thread-Topic: Increasing NFSD_MAX_OPS_PER_COMPOUND to 96
Thread-Index: AQHaRbZPBYb+SPTdz0iA03bgLbzGobDW9WmAgAAEEoCAAAGOgA==
Date: Sat, 13 Jan 2024 01:53:07 +0000
Message-ID: <BFA98D60-DBA4-4CB1-AC9C-D546B369855F@oracle.com>
References: 
 <CAAvCNcDtTNDRvUVjUy4BE7eBCgmkb6hfkq3P0jaGDC=OXg0=6g@mail.gmail.com>
 <89fba598b0b93cf97bf208e106001f74eadd1829.camel@kernel.org>
 <CAAvCNcBSW7ZH4LpSLLo+Bmh2kQ=w5sFrLJ-PKDDSBKwkS5fd5g@mail.gmail.com>
In-Reply-To: 
 <CAAvCNcBSW7ZH4LpSLLo+Bmh2kQ=w5sFrLJ-PKDDSBKwkS5fd5g@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.300.61.1.2)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|SJ0PR10MB4672:EE_
x-ms-office365-filtering-correlation-id: e4ac8c14-36be-4d45-36f4-08dc13da63b0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 0lOq3RzVSLeyY3dVHvvMJXJbmDNXN3wIlsl7C70ASgVmSlMeR/VlmX77TzhhBhehXHmGNkRAVxb25hq/U+o2+RvTyL52Ucv1+VmltszHnviy42kWRZj9beGETCdydHlFjb7AzKw4nhEsUz1oxd+/DzISe6vHVthpOaNebzWXgjrqs2KBinuz3GniseZuMT7pFrP+oQY/Qr5oUsq+pT2FP+HGdDU8nV0SM1xhP2KBQjbm1ZC1tOdK+NX3ErEhq4ZIiJf2SEzC/zYgsVUk42A4zFGD675c6KiyTf+UwjilpbZNADjV2dJ6duhmiydA6ZLQfjgUBoLLIfi+BYjKAOPHy+5c9VqbjPAFuYTbzQSsZNyUSwYCg2ER237ecG2svVA2TdV/aIF8CpFc7SwnMMsplJQf7h3rD05tLoNP3qvtTJ+cQAVARrjrxkR/EbRbeImh+vVcYCJbNWujSadPQMzLXD70te0+OFCTuzCYeTIeC1Z0n5au5tJNzJkkPwrnV9bBPYLoYf7XoBnFaamsG44j89az+ccA2Jaj8zoG+jnc90Eghqzhdx/zrBpCoyALwRT7HX1woBAAlNNVd2uEXz2LfE39RQo3czoQvmdiDaQL34lkJ7YexAH6oO5i04JNCJ1O6ok4Imw44W6SQ3KM03dbPw==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(346002)(396003)(136003)(39860400002)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(6506007)(53546011)(71200400001)(6512007)(26005)(2616005)(36756003)(86362001)(38100700002)(38070700009)(33656002)(4326008)(8676002)(7116003)(41300700001)(2906002)(83380400001)(122000001)(6486002)(5660300002)(478600001)(8936002)(316002)(54906003)(76116006)(64756008)(91956017)(66446008)(66476007)(66556008)(66946007)(6916009)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?a2NuOHlzaWUwdFFkSDAxeW1KRDRJb1NSSjl0QVFvbk52RUNwMWlhd0dKa1Rx?=
 =?utf-8?B?WUVjbC91T29Lb0tvT3lLckNoYWp4K25OYnBXM3hxdEJFU3hLMy9VeFI1YmZr?=
 =?utf-8?B?M0lGMGJqUDN3c3NTdHhRVG0wd1lQbCtuQUJkK2xuWGM2b3JrQ1FJZzNEOTMx?=
 =?utf-8?B?RXFJdXdzL05XUUUza0t1c0ppL2MvOUlHNlNKbkV1UGtFUzVIcWZQdXd3MUtZ?=
 =?utf-8?B?ckdiWll4RHhpdGUxSWN1OEQyR3RBOW5FczA1OCsweG95eTdvclRGV2Q5WXZP?=
 =?utf-8?B?MkNsTHFMbzNsQ3g3UnBzSzYxdjhNaHpRdCsyc2hGejNLL2RxUVFnWWNGRFBx?=
 =?utf-8?B?eCtOOWE2Z1g0enFUeWVZVVZCVEpiaUxxTTVId29EMGJabG9Ec0Z3bUpzQmt6?=
 =?utf-8?B?ZXhNdGV2MTVlWm9EZ2wzVkE3T3V0akZPMzB6OGFPdmczbnlVYWJTZmJUcDM1?=
 =?utf-8?B?Wmc4aHlQejBOeGZEZ1UvM0NVSlBFR3hkdkk5ZDhLamNZN2xyMXpLNXo3VWhD?=
 =?utf-8?B?MDJnQi9VRGRLVHdzWXhBaFdUNzZkY0kzcGd4YXl6OHVHWVc1N0tnTkE1bmxH?=
 =?utf-8?B?ckZlZUxWOXZjMERxYTVNU3FXNXJpVUdFRFFTN0tERlJsek5uUzhnV2c4cnR6?=
 =?utf-8?B?eGJZaFFuMjNqa3o2eTExRjRCUTFsVEluNkxKVHgrS2lJWFkzM3pwRDEwS0xD?=
 =?utf-8?B?SDE3c1JEUTdHNGl2aVFUUllZcFNaeWo0UWxoQXhkRzZ5UXFQRDN0a0I3Vmtp?=
 =?utf-8?B?ZFljUmJMejNqYjBVZVVRSG56dUZGaWR4aUZvZ2hHVDhGMEZBUGRtZDlEcUFQ?=
 =?utf-8?B?S0pxQkVicnFjbDFWMmY3d0hpUVorTm5QdEgvK3dveU1tdEFDcVlMR3BXNDdJ?=
 =?utf-8?B?ZjREQnhuVGRnaVIxUG40ZEE4ckpBaVZReVpSc2xOUTlnenNZYnpWOTY2UzdT?=
 =?utf-8?B?UHlQM0JDVWhGbVo5ZGJRZ25GcnVUeEVMU2NRcmR5VGtPZ2V0NktnTHlwYUlh?=
 =?utf-8?B?Rk5aS3lMV3pCc0Rkd2NXNjRFL1ZadWVEZGhqYlh6disreUg2ZEhSaXk4azdG?=
 =?utf-8?B?NHFqSFl4eU5vbndoRVRGbHptWE92M3lRNWk4VTZEZFBDMmZqRVFtaDdjR3ZP?=
 =?utf-8?B?c3VaaGxYZS82V3pnSkVhTUE4RmFyRmoyd1RDUm94aTR4SENURkNEbTVQUUdG?=
 =?utf-8?B?Wjk2Tmxiazg3ZDBoWmY1YWU4Z3crNDFma0Q4WVlXSmljOHQvcWhGa3dZdko4?=
 =?utf-8?B?QXRLZ3lyY1h6V3pyZmpHdS9vQnVRMFFXN1FSZXNXZEZPNnFIRVFYS1RzdFZQ?=
 =?utf-8?B?V0Ird0ZEc0ZFVUJJcUYrdDJmM1BJSmJFVVF0OXJ1eFhFanNhdHBqaDRWcWtO?=
 =?utf-8?B?YTd4UTBZdTJOazJmd1B6bjAwVGNUSEV3Y25EQ3pXaVpxSGRCcGNzNWg3NzEv?=
 =?utf-8?B?Wmh5bldNZExFUk5Nd1QyNndpeVJCa3J1VEtIMTRsQTNSMm1UTXA1Uk0zZUF0?=
 =?utf-8?B?bCtmTEM4OFFVQ0kvU09VU0YvV1FYS1hTOUJMUlQzWkpZNEVmc2NMVTRVb0lU?=
 =?utf-8?B?UlhOWVp3YlhRbXlnQmptc1BmemNiZ3VobE8xZDFUS200Mk1Fa05ZVjhoK3NY?=
 =?utf-8?B?WWo1ei9HbHl5RU11aVNlanVZaklyZXM1MnNpMm9ZTlBXNTZ3aXZuMHFmZVAr?=
 =?utf-8?B?ZmdGbjd5N0FEbXU1MDNkRmZRQVJBcEVQcUVBRHN0TGFldGJLZ3hWOTI3UEtZ?=
 =?utf-8?B?WlRHOTUwbEpNVEluWVdOY0oxYkxIZWVWMHRVL0Y0R0U2NUZnTlEweWthQlJ6?=
 =?utf-8?B?Wmxkb0djekxVNE8yaFFxTElkRld2VkRicEZ6TitUcWJQdUtNbUkrTzJRRzRM?=
 =?utf-8?B?aStpWUF3a241VUttVVpPNnlRZzR1ZlpXU0JNY0pDUisrMkNDdWZQK2J3T2VF?=
 =?utf-8?B?Wm5qZjY5VWRMM0t4cHlYVGE0TndDaUVheDZFVnp4cFpHT2prRGtJdkNHMFRq?=
 =?utf-8?B?d2t6VnB6MUtOeEo3WEptNWxWUWdGSkduRWlSVEduWGRlV3VlL216MWZXRmJy?=
 =?utf-8?B?UmVCa0pGNXVpa3VrQzJEem5oRjFrWTZMM05NSmh5MXVJUGpYeC9IbFU0RHI0?=
 =?utf-8?B?RWRTT1R5cFRNdjBsRG1mTTk0djZQWSszQVBxQnZHdENCNHRoeDhyVjdMWGFk?=
 =?utf-8?B?TUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9488358FD9352940A7D30177852A305D@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	cSh/QekIEhggpXDWAoKUWRaCyfcyhZQOTEwNU1uPmf0YtAyEJnbjDKvPJ2hIWjHNIvsPg3/eQShgXSn52A+JQWnKpSdS1D2jqB95u2wRhEyRmuEU9CCWAW+veyezoKRxbRS/4Yo+HBADgtqPp5hohI1tl/urHXsEnsDcVmr2uFp+NS1oPQSom/RQFCHiExRG+L538jhtQ5q0jEC/KNmEqZ203Q1P30cAxynRd07QACeRDPYRBnMzxn6H3i2f2FKv+NaWllF5PwaSzzo43Fndj8txes2q5AspmtZ/I0rvEqtWGTyHT9WQirehmSWPbjQgmYpobE78O7DwHH9Hz0eAkO3N5BYGraULzPcl6BilR6pTl+bNrjKJ+RY0AmJJEgxOGZpi+Be+2Fa91qj7bOYhtsck3M14f8EGR4lef258TRmd9/LloW7XTkXr+nKlIyXfyZqclfzNJgcpmicEeZsfbWYcl5na33gGXEdFBRg8TgOXfcG7zYYo/nY2LLUt4BOm6k6Wt5CzSdIiEamoMdnDjih/ORD53ike0+74WCXjTFq6o0wV6MNFdhipR3rac+qoZSlHX8LYHYsfV2kb0+MRGX5of9SqAZ391AnuQfOf0Gg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4ac8c14-36be-4d45-36f4-08dc13da63b0
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jan 2024 01:53:07.6033
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kwtLoYSti/2fcyWRpRjjYeT88ChCfhl0AJkWcbgL04HMTs9YXxhnYKoRzqiVU/x7fwmxMzYW2cjTdja2X7c3hw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4672
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-13_01,2024-01-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0
 malwarescore=0 adultscore=0 mlxscore=0 bulkscore=0 mlxlogscore=803
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401130013
X-Proofpoint-GUID: -0X6SPNnASVoFuuuZ7xAAOvHPuNCgIo8
X-Proofpoint-ORIG-GUID: -0X6SPNnASVoFuuuZ7xAAOvHPuNCgIo8

DQoNCj4gT24gSmFuIDEyLCAyMDI0LCBhdCA4OjQ34oCvUE0sIERhbiBTaGVsdG9uIDxkYW4uZi5z
aGVsdG9uQGdtYWlsLmNvbT4gd3JvdGU6DQo+IA0KPiBPbiBTYXQsIDEzIEphbiAyMDI0IGF0IDAy
OjMyLCBKZWZmIExheXRvbiA8amxheXRvbkBrZXJuZWwub3JnPiB3cm90ZToNCj4+IA0KPj4gT24g
U2F0LCAyMDI0LTAxLTEzIGF0IDAxOjE5ICswMTAwLCBEYW4gU2hlbHRvbiB3cm90ZToNCj4+PiBI
ZWxsbyENCj4+PiANCj4+PiBXZSd2ZSBiZWVuIGV4cGVyaWVuY2luZyBzaWduaWZpY2FudCBuZnNk
IHBlcmZvcm1hbmNlIHByb2JsZW1zIHdpdGggYQ0KPj4+IGN1c3RvbWVyIHdobyBoYXMgYSBkZWVw
bHkgbmVzdGVkIGZpbGVzeXN0ZW0gaGllcmFyY2h5LCBsb3RzIG9mDQo+Pj4gc3ViZGlycywgc29t
ZSBvZiB0aGVtIDYwLTgwIGRpcnMgZGVlcCAoISEpLCB3aGljaCBsZWFkcyB0byBhbg0KPj4+IGV4
cG9uZW50aWFsbHkgc2xvd2Rvd24gd2l0aCBuZnNkIGFjY2Vzc2VzLg0KPj4+IA0KPj4+IFNvbWUg
b2YgdGhlIGlzc3VlcyBoYXZlIGJlZW4gYWRkcmVzc2VkIGJ5IGltcGxlbWVudGluZyBhIGJldHRl
cg0KPj4+IGRpcmVjdG9yeSB3YWxrZXIgdmlhIG11bHRpcGxlIGRpciBmZHMgYW5kIG9wZW5hdCgp
IChpbnN0ZWFkIG9mIGp1c3QNCj4+PiBjd2Qrb3BlbigpKSwgYnV0IHRoZSBuZnNkIHNpZGUgc3Rp
bGwgd2FzIGEgcHJldHR5IGRyYW1hdGljIGlzc3VlLA0KPj4+IHVudGlsIHdlIGJ1bXBlZCAjZGVm
aW5lIE5GU0RfTUFYX09QU19QRVJfQ09NUE9VTkQgaW4NCj4+PiBsaW51eC02LjcvZnMvbmZzZC9u
ZnNkLmggZnJvbSA1MCB0byA5Ni4gQWZ0ZXIgdGhhdCB0aGUgbmZzZCBzaWRlDQo+Pj4gYmVoYXZl
ZCBNVUNIIG1vcmUgcGVyZm9ybWFudC4NCj4+PiANCj4+IA0KPj4gSSBndWVzcyB5b3VyIGNsaWVu
dHMgYXJlIHRyeWluZyB0byBkbyBhIGxvbmcgcGF0aHdhbGsgaW4gYSBzaW5nbGUNCj4+IENPTVBP
VU5EPw0KPiANCj4gTGlrZWx5Lg0KDQpUaGF0J3Mga25vd24gYmFkIGNsaWVudCBiZWhhdmlvciwg
YnR3LiBJdCB3b24ndCBzY2FsZQ0KaW4gdGhlIG51bWJlciBvZiBwYXRoIGNvbXBvbmVudHMuDQoN
Cg0KPj4gSXMgdGhpcyB0aGUgd2luZG93cyBjbGllbnQ/DQo+IA0KPiBObywgY2xpZW50cyBhcmUg
U29sYXJpcyAxMSwgTGludXggYW5kIGZyZWVCU0QNCg0KU29sYXJpcyAxMSBpcyBrbm93biB0byBz
ZW5kIENPTVBPVU5EcyB0aGF0IGFyZSB0b28gbGFyZ2UNCmR1cmluZyBtb3VudCwgYnV0IHRoZSBy
ZXN0IG9mIHRoZSB0aW1lIHRoZXNlIHRocmVlIGNsaWVudA0KaW1wbGVtZW50YXRpb25zIGFyZSBu
b3Qga25vd24gdG8gc2VuZCBsYXJnZSBDT01QT1VORHMuDQoNCg0KPj4gQXQgZmlyc3QgZ2xhbmNl
LCBJIGRvbid0IHNlZSBhbnkgcmVhbCBkb3duc2lkZSB0byBpbmNyZWFzaW5nIHRoYXQgdmFsdWUu
DQo+PiBNYXliZSB3ZSBjYW4gYnVtcCBpdCB0byAxMDAgb3Igc28/IFdoYXQgd291bGQgcHJvYmFi
bHkgYmUgYmVzdCBpcyB0bw0KPj4gcHJvcG9zZSBhIHBhdGNoIHNvIHdlIGNhbiBkaXNjdXNzIHRo
ZSBjaGFuZ2UgZm9ybWFsbHkuDQo+IA0KPiBPSy4gSG93IGRvZXMgdGhpcyB3b3JrPw0KDQpMZXQn
cyBiYWNrIHVwIGEgbWludXRlLg0KDQpJJ2QgbGlrZSB0byBzZWUgcmF3IHBhY2tldCBjYXB0dXJl
cyB3aXRoIHRoZSBjdXJyZW50DQpNQVhfT1BTIHNldHRpbmcgYW5kIHRoZSBuZXcgbGFyZ2VyIG9u
ZS4gU29tZXRoaW5nIGlzIG5vdA0KYWRkaW5nIHVwLg0KDQoNCi0tDQpDaHVjayBMZXZlcg0KDQoN
Cg==

