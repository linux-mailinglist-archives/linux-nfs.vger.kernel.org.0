Return-Path: <linux-nfs+bounces-6370-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D212F9739B6
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Sep 2024 16:19:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5109B1F25F50
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Sep 2024 14:19:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D066B188CB1;
	Tue, 10 Sep 2024 14:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="O4Gm2T2r";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="baHGTWdN"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C982517BEC8
	for <linux-nfs@vger.kernel.org>; Tue, 10 Sep 2024 14:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725977962; cv=fail; b=cW+iSufq/T0bTUhE5H1fReRUVSqHBKF4T7boDgCJk2nliayYtHGxrFexqqtfX9hsqe+wC0DSTw6Efggcvjws8haG/N002hvZTc4+qXd7fBBDnTpo95DZcRJSYIYLSOAs/HuodynMLLtYfxVcpU4dRTzEnNMzaQ3uDV0Tf8Mo8GU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725977962; c=relaxed/simple;
	bh=dI+qjWtk5C8CA8qVgOWYF1wA5Hbdlqs+4Mk6YfadfZI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WeSdX9NfzOvUxUf2t0e416ZpFxZWIwCEGrKzkWUUO77I4bfMRe2ZV1Yybbcl2X8vm8ymFumgSdbx4euEZxj53bBmO53A2Z/oNilLxLLMEluomnG2TP8D5gc4xLCFn/aLBXUmAv3WsT7Ow1UcIxd14D+/MpeO6kDmwnBVt5vvQCE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=O4Gm2T2r; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=baHGTWdN; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48ABMYMD022580;
	Tue, 10 Sep 2024 14:19:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-id:content-transfer-encoding:mime-version;
	 s=corp-2023-11-20; bh=dI+qjWtk5C8CA8qVgOWYF1wA5Hbdlqs+4Mk6Yfadf
	ZI=; b=O4Gm2T2rhe/PxxczhklMtqNXpNBXwIua6oepSDDLdFXQ+GKc5js0DZEov
	zjqQSXfXR9vbB/agKcAKm9LATQSsfSS1ETDVp4264B3eMqGAnrnDSJ7Wa8kSCZfT
	Db2K1vef4AjOrrMKRHC8CWBabc4pvfER67HligLRZfkLe27Fs9AB1OQuPgH+cRpW
	FYjvrqUjZHoB2XEOQTGktBCmHLQ1wILejKJF/glxA1AUDxNqOlK8ZQ6wOvkF982J
	y/o3Zb+XMVZsAl14irJLC3N45K3RWmgOqV27j73ResxgB7qtRafwMWdDujb7GvWj
	mIKzunq/Lw/8Tk4U3SaMOqmZmPSKQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41gdm2npr4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Sep 2024 14:19:01 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 48ACvJj8032478;
	Tue, 10 Sep 2024 14:19:01 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 41gd9ewf9p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Sep 2024 14:19:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XZAW04Pxn91/ifWzYy4zCKLAAbJAjoHKQdRFpAs2k9zhTYT1dR/mVrm+IpHoDmd7zkN2bCanNv5qStJeo0BtB5JJMYV2RNgaMQEwiJuPD/Iu+mr4u5mk8ve2vVTgeKUj9Q5d15p+HczJ69KOcgcfhFYMXKSl+yIBFXDgk0wYDkcaj1vEvGFhJJ/ysPz0Gz3o0G8FpnvUQOkHxlud70Xkni99PavDlpgsBGwZyC+vj/ug3IhBTxbSJMZZusxYHiySalvLiiw+MluHIdzaZggOVMylZjTRgTdveb8vT3QrY0MtQZDgp1kE3JhYUcBTaS4VMyVBBClFwoJayKmhzswEvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dI+qjWtk5C8CA8qVgOWYF1wA5Hbdlqs+4Mk6YfadfZI=;
 b=K4HPL3pCLEgRYZsHGwbCZVNohGj0EzAdLuNfL+E30q8Co27XDhFa3kpDhP4ZNRZukLc34YhvZE6xnIth6U3JMWlkW6Ke/fEyGRhmGsOdF2QFzsEcNA6apUyzdNc/L0klnWayR+MyRalJa+o9irVADjbAfG9Ncad6hCtMe+kxwaVm9+gCWsULiDLYvLab/4ugIjWR5XEvg/jxm4OcUV67dgKWQMkZ5d2S3nW0GmO7G+SxLIAtM5dRANQdsqOxwmOBE4GeK6jkInUbX5YFkujpiCnGDLlg9KLBEv1EYs36zK6xA4pSE3qxent4O0VNDm3IHHuZKvxaRTSIVZQriFxvyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dI+qjWtk5C8CA8qVgOWYF1wA5Hbdlqs+4Mk6YfadfZI=;
 b=baHGTWdNPKWrEfqS7G+K4lJ27DUHP+VHlaMSqv9kDKsb8deFuRLbbtFq7pOxAMblLk6FWLvbjfH37HvSjfN7u4FCrAdfstGL7sMpkpXOQx5QHsLkr49IraHm16JWlQlHX4EriEjW+bOUwjLKtil8QePIfAx3xRMufBgsceJU5xo=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by IA0PR10MB6748.namprd10.prod.outlook.com (2603:10b6:208:43c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.14; Tue, 10 Sep
 2024 14:18:58 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%5]) with mapi id 15.20.7962.014; Tue, 10 Sep 2024
 14:18:58 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Tom Talpey <tom@talpey.com>
CC: Olga Kornievskaia <okorniev@redhat.com>, Jeff Layton <jlayton@kernel.org>,
        Neil Brown <neilb@suse.de>, Dai Ngo <dai.ngo@oracle.com>,
        Linux NFS Mailing
 List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] nfsd: fix delegation_blocked() to block correctly for at
 least 30 seconds
Thread-Topic: [PATCH] nfsd: fix delegation_blocked() to block correctly for at
 least 30 seconds
Thread-Index:
 AQHbAnYWzk/Hpp/79kCmPEQurBPxabJPYZyAgAAfiACAAAWagIAABvkAgAFoSACAAB3HgA==
Date: Tue, 10 Sep 2024 14:18:58 +0000
Message-ID: <D8E83DA7-522D-4143-8998-DD768DC11D74@oracle.com>
References: <172585839640.4433.13337900639103448371@noble.neil.brown.name>
 <adadfa97e30bc4d827df194814e4e05aa26b8266.camel@kernel.org>
 <CACSpFtBYpQpAKVOmHLPUOr5LvoYq0-ea_NFMctqhMYSamUL_ZQ@mail.gmail.com>
 <Zt8IOQUF/VEkCPgO@tissot.1015granger.net>
 <CACSpFtCD-yBiO3Oe9m8k9q6Wug6MqgNQmjoT9K8DRAmc3bGLfg@mail.gmail.com>
 <727023c4-416d-43ba-a82a-3fbd0a831f49@talpey.com>
In-Reply-To: <727023c4-416d-43ba-a82a-3fbd0a831f49@talpey.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3776.700.51)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|IA0PR10MB6748:EE_
x-ms-office365-filtering-correlation-id: 3730db31-4ec9-4bdd-d776-08dcd1a38291
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?RUd2R1ZPTmpoVDdjME1OVlBCdm1sbVBSUmJtOTlTSkpYUDN3TGx0TEx5bUdu?=
 =?utf-8?B?d2MvN3F5RFVhUktpc2NGeTA1Q2RtMFN6TVBRZWdEQVhlR0dQYjMzT0RrdWNl?=
 =?utf-8?B?TVpqditKZnBBRDlXWHMxTDlxQ1RmbjBKVzRMa3RXM0tTZFJseW9LVXhvWDEx?=
 =?utf-8?B?MHljejNPQTM4REFjeVkxZXJZZnREWlVNQTdPUXQzVHRpTW13UXBMY29FblVI?=
 =?utf-8?B?dzdzM3NnK2FHRXE5Q0Z5VEVrckx4NlA5WG53MlNEWXk2SlNPdlQvNEJXdVlU?=
 =?utf-8?B?ZTBzQmN2OCtyeFFBa1kvNE9vWTlDc2N4TzZRNVg2NS8ydHRocGVmbmlBY0xU?=
 =?utf-8?B?ZmVkdFpCMjRERXdheXpsZGJoQWlJQjdEZUt3L3RvT1d3VUhuOERqclQxWFJK?=
 =?utf-8?B?N3FwenBZZGdTVDJQaFNNVGlJbmRzUXRrSFh2VUVrZy9UenNDMGJUeCtUZzNx?=
 =?utf-8?B?OG5MTUZmUmdVTTRuenZUY21oYUY5Q3RGaU1iLzZKbzFqZXlSM0l3anZRWUd0?=
 =?utf-8?B?c3RwTU4xOGZpUGEydjR6QVd6dzFOSnd1bVNRd285MUkxRWcrQm91QXdJTWY5?=
 =?utf-8?B?TUUvVWdDcEVpSXNibTFoWDdHMnB6RWRXZmNQRGhsWTAzMDNlZm9zQ2lmak5j?=
 =?utf-8?B?dnEvL0hkOG53L0o0dDhrMUdzT1k0cktRWmJybXhNeEdabkRFbis3eXphLzZm?=
 =?utf-8?B?SjhpVHo5VTBIcGlEdXBya1N3V3pMQTFRZUlpd0JKU3pvNlN6UU5PZHlDUFpL?=
 =?utf-8?B?eks0UE9RSFlvU3RCV2wzcFNQTXcrcmsyVk8wc0NJZFVoQmdiSDY4TElmSHRr?=
 =?utf-8?B?SVBGbGE2NmwxSmlzU252eHBPT1NYZHgvYlpjTkJKRGJDd3JFWTJ6bnJ4OGk1?=
 =?utf-8?B?M0NTdkFnay92WTJYTjNwelBkYkd0MDE0Tko5Z2RzeUY2VTU5ZjlCbWFEWGtj?=
 =?utf-8?B?OE9yY2R5VmFRYTNsellMSW9jZ2dMWHVLck5ESXNkNWlLREhPOExHbmFtbVJX?=
 =?utf-8?B?RlBNdVd2aExRSUlWSlZSZ20yYXhVS0NnYzFuNFEwMzRvRUNUaWxnUk4wSDlx?=
 =?utf-8?B?bDI3UTBzUlBLWjQxd29XMFhHd201bzczc1pDWXN6Y1VjOVFUcTkzN0M1U0lt?=
 =?utf-8?B?UEZiU1dROGFZTmRpSmY3MWhBVXhzSUx6dnJqMVMvYjFPdXFhYkU3eCtPYzBO?=
 =?utf-8?B?Wm9OVjdNa0RSNUZya2YvS0hOem5UeVJoU3k0a25kaVVUM3ZocTNwRVpPRFY0?=
 =?utf-8?B?dTQya1FkVUdIM1FZdG5JclRsUU1KdGNmL3lPWFZleGxtRkZxenFCcXF3OWlw?=
 =?utf-8?B?RllBWFpOb1ZIT3dWbjlkcWRjM0hoODZOQ1lad3hZOGpLbHAvMXNzZDAvRmJt?=
 =?utf-8?B?MEZxendSQ0x2bXBCbDV0OTVMQ3hMWkxKRDdSTkxoZTdQTmZ0a1dVaU93RU5h?=
 =?utf-8?B?YVh1aDNzdDNDWUFyR1hWYm11NDJwamQ3NEJOUDhnc010eTY1YTU3SWdxNXdt?=
 =?utf-8?B?YkxnbVV1dVRNbU1Ec0ltSTliZURqc1RxbTRQRmR2YVFJUUNyWkV3WDlaRkV6?=
 =?utf-8?B?ejBFOERvc0J3aVdHbVpybnE5UGF5Sm5MOVFtNk00WTEzaWhTSjZtN1l5Z0Vx?=
 =?utf-8?B?UHlDWkVpY0JLa3c2TWcvUEtDUkpGZjNpV01nam1qckZnaWNZdk44ek1yYjZw?=
 =?utf-8?B?bGsrcWlvL0V2ODJWbHA2TklscENuc1cyRy9ZdDcwSFM3cnpKdGFPd2VwOUQv?=
 =?utf-8?B?cDIvcmRsb2txZVRGb2RaVzRSWTl4KzRPU1VvdUM5YTBlSGxFbXVRYWE1L1o4?=
 =?utf-8?B?NTl4dTNCUTNmbFgrWE9YTHhDWHZ2cW42UlpGejVabDF1VWY1S0lsNlZLcnJq?=
 =?utf-8?B?cUZpcWpvSWV5ZnV2ekJFdmZGQkRuajNKZnpTV3NnTGZ4YXc9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MkNJNk9HOWFiZG1NbWJQVjFoaWFyRkJwMFJwUFFRaFlCMlZrREY1ZFo3N3I2?=
 =?utf-8?B?SWplSHlsMU96UWhnSStwRlhjeDAxcWE3ZER0L0pvbWRlY3dyZFQ2S3dSUkRD?=
 =?utf-8?B?U2hOV0wwaUJnYlRGQ1d1MUpHWHF2K0R0ZTZobjVrL0VvaHZUL09kOUV6SS9a?=
 =?utf-8?B?ZjdqODlOVHdhSWNoTGdYY0hKOE5DSVhyc3Z2dkNhZkZGSlRuRllRRTU5a1JV?=
 =?utf-8?B?MFF5eVVxU0padGZkRERLT3dsTDh3YWljSDJiYWZlRWFIMGNRa1FSV0JLcGY4?=
 =?utf-8?B?ZEJiMmxKOUdQcXpvckpCOHlCNDlNK2tuSFBnaDdJYWRURi9XZ3lleVM1MEVa?=
 =?utf-8?B?cDFzYVUyK3k3OStGZTlhUHF5T1VOY2Z3aUN3WVJ0MGRHRVkwZmVtMS9mQUly?=
 =?utf-8?B?VEFndEZuTlpua0YvTVBPMnB3Zi9RK1RBeUNVK1BjeUR0UWhxVTVQYUY3NUYr?=
 =?utf-8?B?Q1NiWWRmU2JBWU5UMnFIWjZ5Y0p6bkF0QzVheTZCaWhOajRuVTcrY2FHUi9s?=
 =?utf-8?B?Z0JiVm5kQ3JtM0VBK2s1ZmcyNW43a05ZMC9DVzI1U1BTUENVZThpblNhbmxT?=
 =?utf-8?B?SHhMbUc0YStxOXNhbmxLZTlDcGsvc2RpME9BWEZHdU00U056SnBMdzY1aTN6?=
 =?utf-8?B?dHNmWk9DNlpTR2dtcHZhUlU4SVVwejE2RXM3b2I5ZStFMWNPZlhEcC9NWjRP?=
 =?utf-8?B?T1lvbGkvYlgrSHMyWUJhSXhMekxhVUJ1WWZwUUlSS2ovWlhwc0tqSTlGVkNm?=
 =?utf-8?B?a09lbXBhWkhVMDVkeUJsT1JZd0hIWkdmOGk1RmdodTVSbEVrZU1vZUZTSjRZ?=
 =?utf-8?B?MzQzNTE3VGtHNitpbHh4dDZhcGc2M3p4OEtDUlcrc3ZRMWhmVkc3bHY1Q1ZH?=
 =?utf-8?B?bXV2czkvRTlneGd0MEJsS2ZZeHY5emt6Lys2cUVKWVJMZnE0enY0QWFtMEhm?=
 =?utf-8?B?dFNSd0JHdG5DZi9xTWE3WHd3ZTlWOWNabU9zOEFNTkhZUlQxajFUeE5iMW1N?=
 =?utf-8?B?aVhWV2hKUkVId2JNK1J1NGtRMUJ6YTFUN0d1dVRENjZRVEkvUkhmUndHaUFy?=
 =?utf-8?B?VlNlU1pJVkd1UzRScU1pTVJiTURLay9Ub1pCVnNocUphQjRsUElvREpRQU16?=
 =?utf-8?B?WVJuTjVyMjJlVE9heVMrT0JiRXZwbWhPL1Y0cUVFaVVpYTVMVVFZNHMzSERn?=
 =?utf-8?B?dGR2eDRzVWJlWk5ocDJiRXY4ems4d0dRZG51Z2FPMit0NzF6bE9FazlSU25w?=
 =?utf-8?B?Z3pUZjhsaE1FVXF1WmV3d2JlcjZVK2pmcW1OUmE3Z3B6dTlJOEVMZGJRVjBu?=
 =?utf-8?B?WVBEcjhtQ3JiZ1h3ZXAwKy81bUFvYjRqNGlNcGkvQklMLzMzTmFuMzJleHFw?=
 =?utf-8?B?aTlFY0t0TUJreVJZeUdVT0xPZmYzNW1leHV2UFRncjhiSTdmNkxTWXBqWmdK?=
 =?utf-8?B?NUdtQ1dCVlVISVdHc2ZZMU4wL1QzT3ppUUEzMWxGenpMdHhrSnJNNGQwaXhs?=
 =?utf-8?B?d2UwVGFCVWs3eUNkSDN6QzE0bGlnK2dxaitqUzhiaXJxZm82UVJXMWRXejRS?=
 =?utf-8?B?WVF2S2tDN2FhQkg4aE1qSlJyK053ZitxdUZRaDhpSDVJUHJra2EzRmhLTGRP?=
 =?utf-8?B?OERZNjZqS29LTnZWY2tTYTF3cDZWakZRWlYzL3hxWHYvWS8xMHlsRkJpRUN6?=
 =?utf-8?B?bUVDd0xRc1NUaVFNeC8yU1RDV2FWZksrR1RDSS9jTUl5bytvQ2RBK1ZYN2po?=
 =?utf-8?B?T0hCd0VuRVZnUUZURVNDZy9lTjFNaTk1T0lrZUIrTmtGNEN1UjE2dmE2L3lO?=
 =?utf-8?B?NEd1VWpOeDFZQzI0Zkc4SXZoV0FDYkVzYjJLeENpU2NtY25sSFdveVozZThC?=
 =?utf-8?B?clhOeU9uOGJoZmlSSzI0b1lUU05YWG05K3htZlVPTTd3SkhBZ0Jkd3FTbTZF?=
 =?utf-8?B?RGFYZUJ0NEtYMWRBYWdnL2NoclNsUGlGV3B2WkhDRGtqd1MzZWx5SnhQeUNX?=
 =?utf-8?B?dEo0RjE0WDB5OWlqbXNGTnhQNkZpUU4xOVVLMDlsenN2QWkxZG9zYzRacFB1?=
 =?utf-8?B?cmxFVzdtK284bjNxNWxXV0MvRVB2OWdtTmpMK2VjNXk4MDllZ1VVaDEyclVm?=
 =?utf-8?B?b2NUd3BBV3dHRDJENytHWGlWN1RUZjRUZjgwQ0oxdGtVSTUxUlo4akxETU13?=
 =?utf-8?B?eUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5C8898C36E239C44A71C7C999CA04473@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	AzDzOcwc1mXayLLaax/aE/oNHiEubC8G9wkgd03VHBzE6BCFGWQAlQr21ofIk1PSiX28RwPp9JGQbw2VOaewUvzRs4u12Kt7NMiVcbxAh16tTR21ThV6P4+zvZ1ByS7Yk9f5k+5gRyM1VlMqB6FCO0R9CiY08X6wl3al7NIFN51pd7rdvZpflF0at1BtJG2XOUduBjGKF8WruX47sLhD2sY7jxoRbmXeEz4NOxzTrOqjQZ0wKraqAsNVhpIx6x85HaNvql23+dm4SxskBCbb9XndRfHIfRIMN8ijia5DzTrz9PyQw6HqShyNIVf1QMy/DSSS0Vm2nQmiO09w1ByoIIEMZUdCNUJS4/Dmxp2VBV4n+DebxsXvUA73w7jxTjt4jIb6kF4wSXSsu0Ut0/wI7W+7ccZFNiR9ZromDw/Iy3cg5FlePGL5lTWODFnQvSLpD6Ww9ac5Og7qATEh9C9ggWyheOcv3XDu8XlbZ5OKREaNMYWHu4KZpgkX94sYVxW7XWP1cFskZYHW5YOV1XFlVRhEJENUrULivwfhENahFPiBxkGfevwlL/R46mnn7BMRH82uRdiOs7EvyBOQUE/CxiuSITIMQIGVmfaYzIETBJ0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3730db31-4ec9-4bdd-d776-08dcd1a38291
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Sep 2024 14:18:58.0134
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: x3dmki46h+/tgoKd9sbgJLuE3/9qSuUU67LRQ/Ypcp/JETqSE9nXem4fjkRMx0YUL3VV8KwRTyO7dmxHcGdAnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB6748
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-10_04,2024-09-09_02,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 mlxlogscore=999 malwarescore=0 bulkscore=0 spamscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2408220000 definitions=main-2409100106
X-Proofpoint-GUID: sAvVWacKC6f6mdor5FpXn6HBud8Ksj_J
X-Proofpoint-ORIG-GUID: sAvVWacKC6f6mdor5FpXn6HBud8Ksj_J

DQoNCj4gT24gU2VwIDEwLCAyMDI0LCBhdCA4OjMy4oCvQU0sIFRvbSBUYWxwZXkgPHRvbUB0YWxw
ZXkuY29tPiB3cm90ZToNCj4gDQo+IE9uIDkvOS8yMDI0IDExOjAyIEFNLCBPbGdhIEtvcm5pZXZz
a2FpYSB3cm90ZToNCj4+IE9uIE1vbiwgU2VwIDksIDIwMjQgYXQgMTA6MzjigK9BTSBDaHVjayBM
ZXZlciA8Y2h1Y2subGV2ZXJAb3JhY2xlLmNvbT4gd3JvdGU6DQo+Pj4gDQo+Pj4gT24gTW9uLCBT
ZXAgMDksIDIwMjQgYXQgMTA6MTc6NDJBTSAtMDQwMCwgT2xnYSBLb3JuaWV2c2thaWEgd3JvdGU6
DQo+Pj4+IE9uIE1vbiwgU2VwIDksIDIwMjQgYXQgODoyNOKAr0FNIEplZmYgTGF5dG9uIDxqbGF5
dG9uQGtlcm5lbC5vcmc+IHdyb3RlOg0KPj4+Pj4gDQo+Pj4+PiBPbiBNb24sIDIwMjQtMDktMDkg
YXQgMTU6MDYgKzEwMDAsIE5laWxCcm93biB3cm90ZToNCj4+Pj4+PiBUaGUgcGFpciBvZiBibG9v
bSBmaWx0ZXJlZCB1c2VkIGJ5IGRlbGVnYXRpb25fYmxvY2tlZCgpIHdhcyBpbnRlbmRlZCB0bw0K
Pj4+Pj4+IGJsb2NrIGRlbGVnYXRpb25zIG9uIGdpdmVuIGZpbGVoYW5kbGVzIGZvciBiZXR3ZWVu
IDMwIGFuZCA2MCBzZWNvbmRzLiAgQQ0KPj4+Pj4+IG5ldyBmaWxlaGFuZGxlIHdvdWxkIGJlIHJl
Y29yZGVkIGluIHRoZSAibmV3IiBiaXQgc2V0LiAgVGhhdCB3b3VsZCB0aGVuDQo+Pj4+Pj4gYmUg
c3dpdGNoIHRvIHRoZSAib2xkIiBiaXQgc2V0IGJldHdlZW4gMCBhbmQgMzAgc2Vjb25kcyBsYXRl
ciwgYW5kIGl0DQo+Pj4+Pj4gd291bGQgcmVtYWluIGFzIHRoZSAib2xkIiBiaXQgc2V0IGZvciAz
MCBzZWNvbmRzLg0KPj4+Pj4+IA0KPj4+Pj4gDQo+Pj4+PiBTaW5jZSB3ZSdyZSBvbiB0aGUgc3Vi
amVjdC4uLg0KPj4+Pj4gDQo+Pj4+PiA2MHMgc2VlbXMgbGlrZSBhbiBhd2Z1bGx5IGxvbmcgdGlt
ZSB0byBibG9jayBkZWxlZ2F0aW9ucyBvbiBhbiBpbm9kZS4NCj4+Pj4+IFJlY2FsbHMgZ2VuZXJh
bGx5IGRvbid0IHRha2UgbW9yZSB0aGFuIGEgZmV3IHNlY29uZHMgd2hlbiB0aGluZ3MgYXJlDQo+
Pj4+PiBmdW5jdGlvbmluZyBwcm9wZXJseS4NCj4+Pj4+IA0KPj4+Pj4gU2hvdWxkIHdlIHN3YXAg
dGhlIGJsb29tIGZpbHRlcnMgbW9yZSBvZnRlbj8NCj4+Pj4gDQo+Pj4+IEkgd2FzIGFsc28gdGhp
bmtpbmcgdGhhdCBwZXJoYXBzIHdlIGNhbiBkbyAxNS0zMHMgcGVyaGFwcz8gQW5vdGhlcg0KPj4+
PiB0aG91Z2h0IHdhcyBzaG91bGQgdGhpcyBiZSBhIGNvbmZpZ3VyYWJsZSB2YWx1ZSAod2l0aCBz
b21lDQo+Pj4+IG5vbi1uZWdvdGlhYmxlIG1pbiBhbmQgbWF4KT8NCj4+PiANCj4+PiBJZiBpdCBu
ZWVkcyB0byBiZSBjb25maWd1cmFibGUsIHRoZW4gd2UgaGF2ZW4ndCBkb25lIG91ciBqb2JzIGFz
DQo+Pj4gc3lzdGVtIGFyY2hpdGVjdHMuIFRlbXBvcmFyaWx5IGJsb2NraW5nIGRlbGVnYXRpb24g
b3VnaHQgdG8gYmUNCj4+PiBlZmZlY3RpdmUgd2l0aG91dCBodW1hbiBpbnRlcnZlbnRpb24gSU1I
Ty4NCj4+PiANCj4+PiBBdCBsZWFzdCBsZXQncyBnZXQgc29tZSBzcGVjaWZpYyB1c2FnZSBzY2Vu
YXJpb3MgdGhhdCBkZW1vbnN0cmF0ZSBhDQo+Pj4gcGFscGFibGUgbmVlZCBmb3IgZW5hYmxpbmcg
YW4gYWRtaW4gdG8gYWRqdXN0IHRoaXMgYmVoYXZpb3IgKGllLCBhDQo+Pj4gbmVlZCB0aGF0IGlz
IG5vdCBzaW1wbHkgYW4gaW1wbGVtZW50YXRpb24gYnVnKSwgdGhlbiBkZXNpZ24gZm9yDQo+Pj4g
dGhvc2Ugc3BlY2lmaWMgY2FzZXMuDQo+Pj4gDQo+Pj4gRG9lcyBORlNEIGhhdmUgbWV0cmljcyBp
biB0aGlzIGFyZWEsIGZvciBleGFtcGxlPw0KPj4+IA0KPj4+IEdlbmVyYWxseSBzcGVha2luZywg
dGhvdWdoLCBJJ20gbm90IG9wcG9zZWQgdG8gZmluZXNzaW5nIHRoZSBiZWhhdmlvcg0KPj4+IG9m
IHRoZSBCbG9vbSBmaWx0ZXIuIEknZCBsaWtlIHRvIGFwcGx5IHRoZSBwYXRjaCBiZWxvdyBmb3Ig
djYuMTIsDQo+PiAxMDAlIGFncmVlZCB0aGF0IHdlIG5lZWQgdGhpcyBwYXRjaCB0byBnbyBpbiBu
b3cuIFRoZSBjb25maWd1cmF0aW9uDQo+PiB3YXMganVzdCBhIHRob3VnaHQgZm9yIGFmdGVyIHdo
aWNoIEkgc2hvdWxkIGhhdmUgc3RhdGVkIGV4cGxpY2l0bHkuIEkNCj4+IGd1ZXNzIEknbSBub3Qg
YSBiaWcgZmFuIG9mIGhhcmQgY29kZWQgbnVtYmVycyBpbiB0aGUgY29kZSBhbmQgbmFpdmVseQ0K
Pj4gdGhpbmtpbmcgdGhhdCBpdCdzIGFsd2F5cyBiZXR0ZXIgdG8gaGF2ZSBhIGNvbmZpZyBvdmVy
IGEgaGFyZGNvZGVkDQo+PiB2YWx1ZS4NCj4gDQo+IE5vIGNvbnN0YW50IGlzIGV2ZXIgY29ycmVj
dCBpbiBuZXR3b3JraW5nLCBlc3BlY2lhbGx5IHRpbWVvdXRzLg0KDQpCdXQgYSBjb25zdGFudCBj
YW4gYmUgImdvb2QgZW5vdWdoIi4gTm8gb25lIGhhcyB5ZXQgY2xlYXJseQ0KZGVtb25zdHJhdGVk
LCBmb3IgdGhpcyBtZWNoYW5pc20sIHRoYXQgb25lIHRpbWVvdXQgdmFsdWUNCmlzIHdvcnNlIHRo
YW4gYW5vdGhlci4NCg0KDQo+IFNvIHllcywNCj4gaXQgc2hvdWxkIGJlIGFkanVzdGFibGUuIEJ1
dCBldmVuIHRoZW4sIGNob29zaW5nIGEgbnVtYmVyIGhlcmUgaXMNCj4gZnVuZGFtZW50YWxseSBk
aWZmaWN1bHQuDQoNCkknbSBub3Qgc2F5aW5nIGl0IHNob3VsZCBuZXZlciBiZSBhZGp1c3RhYmxl
LiBXZSBuZWVkIHNvbWUNCmRhdGEgc2hvd2luZyB3aGF0IHJhbmdlIG9mIHZhbHVlcyBpcyB1c2Vm
dWwsIGFuZCB3ZSBuZWVkIHRvDQprbm93IHdoZXJlIHRoZSBjb250cm9sIG5lZWRzIHRvIGJlIHBs
YWNlZDogZXhwb3J0IG9wdGlvbj8NCnN5c2N0bD8gL3N5cyBvciAvcHJvYz8gQ2FuIHRoaXMga25v
YiBiZSBhYnVzZWQ/IENhbiB0aGUgc2V0dGluZw0KYmUgYXV0b21hdGVkPyBNYXliZSB0aGUgY29u
dHJvbCBzaG91bGQgYmUgImRlbGF5IGEgZmV3IHNlY29uZHMNCnZzLiBwdXQgdGhhdCBjbGllbnQg
aW4gdGhlIGRvZ2hvdXNlIHVudGlsIHNlcnZlciByZWJvb3RzIj8NCg0KSW5kZWVkLCBpdCBtaWdo
dCBiZSB0aGF0IGFueSBkZWxheSBncmVhdGVyIHRoYW4gemVybyBoYXMgc29tZQ0KYmVuZWZpdC4g
SW4gd2hpY2ggY2FzZSwgdGhlIGZsZXhpYmlsaXR5IG9mIGNoYW5naW5nIHRoZSBmaWx0ZXINCnJl
c2V0IHRpbWUgc3RhcnRzIHRvIGxvb2sgdW5uZWNlc3NhcnkuDQoNClBvaW50IGlzOiB3ZSBkb24n
dCBrbm93IHlldC4gSSB3b3VsZCBsaWtlIHRvIHNlZSBhIHBsYW4gZm9yDQpob3cgdG8gZ2F0aGVy
IG1vcmUgZGF0YSwgZmlyc3QuIEFzIEkgc2FpZCB5ZXN0ZXJkYXksIHRoZXJlDQppcyBhIGNvc3Qg
dG8gYWRkaW5nIGtub2JzIGxpa2UgdGhpcy4gSSB3YW50IHRvIGtub3cgd2hhdA0Kd2UncmUgZ2V0
dGluZyBmb3IgdGhlIG1vbmV5Lg0KDQooVG8gYmUgY2xlYXIsIEknbSBub3QgbWFraW5nIGEgaGFy
ZCBvYmplY3Rpb24uIEknbSBqdXN0DQphc2tpbmcgdG8gd2FpdCBmb3IgbW9yZSBpbmZvcm1hdGlv
bikuDQoNCg0KPiBEZWxlZ2F0aW9ucyBjYW4gYmxvY2sgZm9yIHBlcmZlY3RseSB2YWxpZCBsb25n
IHBlcmlvZHMsIHJpZ2h0PyBTYXkgaXQNCj4gdGFrZXMgYSBsb25nIHRpbWUgdG8gZmx1c2ggYSB3
cml0ZSBkZWxlZ2F0aW9uLCBvciBpZiB0aGUgbmV0d29yayBpcw0KPiBwYXJ0aXRpb25lZCB0byB0
aGUgKG90aGVyKSBjbGllbnQgYmVpbmcgcmVjYWxsZWQuIDMwIHNlY29uZHMgdG8gZGF0YQ0KPiBj
b3JydXB0aW9uIGlzIHF1aXRlIHRoZSBndWlsbG90aW5lLg0KDQpUaGUgQmxvb20gZmlsdGVyIGlz
IG5vdCBhYm91dCBjb3JyZWN0bmVzcywgc28gZGF0YSBjb3JydXB0aW9uDQppcyBub3QgYSBmYWN0
b3IuIFRoZSBwdXJwb3NlIG9mIHRoaXMgbWVjaGFuaXNtIGlzIHRvIGdpdmUgYQ0KZmFpciBmb3J3
YXJkIHByb2dyZXNzIGd1YXJhbnRlZSBpbiBjZXJ0YWluIGNvcm5lciBjYXNlcy4NCg0KDQo+IFRv
bS4NCj4gDQo+Pj4gcHJlc2VydmluZyB0aGUgQ2M6IHN0YWJsZSwgYnV0IGhhbmRsZSB0aGUgYmVo
YXZpb3JhbCBmaW5lc3NpbmcgdmlhDQo+Pj4gYSBzdWJzZXF1ZW50IHBhdGNoIHRhcmdldGluZyB2
Ni4xMyBzbyB0aGF0IGNhbiBiZSBhcHByb3ByaWF0ZWx5DQo+Pj4gcmV2aWV3ZWQgYW5kIHRlc3Rl
ZC4gSmE/DQo+Pj4gDQo+Pj4gQlRXLCBuaWNlIGNhdGNoIQ0KPj4+IA0KPj4+IA0KPj4+Pj4+IFVu
Zm9ydHVuYXRlbHkgdGhlIGNvZGUgaW50ZW5kZWQgdG8gY2xlYXIgdGhlIG9sZCBiaXQgc2V0IG9u
Y2UgaXQgcmVhY2hlZA0KPj4+Pj4+IDMwIHNlY29uZHMgb2xkLCBwcmVwYXJpbmcgaXQgdG8gYmUg
dGhlIG5leHQgbmV3IGJpdCBzZXQsIGluc3RlYWQgY2xlYXJlZA0KPj4+Pj4+IHRoZSAqbmV3KiBi
aXQgc2V0IGJlZm9yZSBzd2l0Y2hpbmcgaXQgdG8gYmUgdGhlIG9sZCBiaXQgc2V0LiAgVGhpcyBt
ZWFucw0KPj4+Pj4+IHRoYXQgdGhlICJvbGQiIGJpdCBzZXQgaXMgYWx3YXlzIGVtcHR5IGFuZCBk
ZWxlZ2F0aW9ucyBhcmUgYmxvY2tlZA0KPj4+Pj4+IGJldHdlZW4gMCBhbmQgMzAgc2Vjb25kcy4N
Cj4+Pj4+PiANCj4+Pj4+PiBUaGlzIHBhdGNoIHVwZGF0ZXMgYmQtPm5ldyBiZWZvcmUgY2xlYXJp
bmcgdGhlIHNldCB3aXRoIHRoYXQgaW5kZXgsDQo+Pj4+Pj4gaW5zdGVhZCBvZiBhZnRlcndhcmRz
Lg0KPj4+Pj4+IA0KPj4+Pj4+IFJlcG9ydGVkLWJ5OiBPbGdhIEtvcm5pZXZza2FpYSA8b2tvcm5p
ZXZAcmVkaGF0LmNvbT4NCj4+Pj4+PiBDYzogc3RhYmxlQHZnZXIua2VybmVsLm9yZw0KPj4+Pj4+
IEZpeGVzOiA2MjgyY2Q1NjU1NTMgKCJORlNEOiBEb24ndCBoYW5kIG91dCBkZWxlZ2F0aW9ucyBm
b3IgMzAgc2Vjb25kcyBhZnRlciByZWNhbGxpbmcgdGhlbS4iKQ0KPj4+Pj4+IFNpZ25lZC1vZmYt
Ynk6IE5laWxCcm93biA8bmVpbGJAc3VzZS5kZT4NCj4+Pj4+PiAtLS0NCj4+Pj4+PiAgZnMvbmZz
ZC9uZnM0c3RhdGUuYyB8IDUgKysrLS0NCj4+Pj4+PiAgMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0
aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4+Pj4+PiANCj4+Pj4+PiBkaWZmIC0tZ2l0IGEvZnMv
bmZzZC9uZnM0c3RhdGUuYyBiL2ZzL25mc2QvbmZzNHN0YXRlLmMNCj4+Pj4+PiBpbmRleCA0MzEz
YWRkYmU3NTYuLjZmMThjMWE3YWYyZSAxMDA2NDQNCj4+Pj4+PiAtLS0gYS9mcy9uZnNkL25mczRz
dGF0ZS5jDQo+Pj4+Pj4gKysrIGIvZnMvbmZzZC9uZnM0c3RhdGUuYw0KPj4+Pj4+IEBAIC0xMDc4
LDcgKzEwNzgsOCBAQCBzdGF0aWMgdm9pZCBuZnM0X2ZyZWVfZGVsZWcoc3RydWN0IG5mczRfc3Rp
ZCAqc3RpZCkNCj4+Pj4+PiAgICogV2hlbiBhIGRlbGVnYXRpb24gaXMgcmVjYWxsZWQsIHRoZSBm
aWxlaGFuZGxlIGlzIHN0b3JlZCBpbiB0aGUgIm5ldyINCj4+Pj4+PiAgICogZmlsdGVyLg0KPj4+
Pj4+ICAgKiBFdmVyeSAzMCBzZWNvbmRzIHdlIHN3YXAgdGhlIGZpbHRlcnMgYW5kIGNsZWFyIHRo
ZSAibmV3IiBvbmUsDQo+Pj4+Pj4gLSAqIHVubGVzcyBib3RoIGFyZSBlbXB0eSBvZiBjb3Vyc2Uu
DQo+Pj4+Pj4gKyAqIHVubGVzcyBib3RoIGFyZSBlbXB0eSBvZiBjb3Vyc2UuICBUaGlzIHJlc3Vs
dHMgaW4gZGVsZWdhdGlvbnMgZm9yIGENCj4+Pj4+PiArICogZ2l2ZW4gZmlsZWhhbmRsZSBiZWlu
ZyBibG9ja2VkIGZvciBiZXR3ZWVuIDMwIGFuZCA2MCBzZWNvbmRzLg0KPj4+Pj4+ICAgKg0KPj4+
Pj4+ICAgKiBFYWNoIGZpbHRlciBpcyAyNTYgYml0cy4gIFdlIGhhc2ggdGhlIGZpbGVoYW5kbGUg
dG8gMzJiaXQgYW5kIHVzZSB0aGUNCj4+Pj4+PiAgICogbG93IDMgYnl0ZXMgYXMgaGFzaC10YWJs
ZSBpbmRpY2VzLg0KPj4+Pj4+IEBAIC0xMTA3LDkgKzExMDgsOSBAQCBzdGF0aWMgaW50IGRlbGVn
YXRpb25fYmxvY2tlZChzdHJ1Y3Qga25mc2RfZmggKmZoKQ0KPj4+Pj4+ICAgICAgICAgICAgICAg
aWYgKGt0aW1lX2dldF9zZWNvbmRzKCkgLSBiZC0+c3dhcF90aW1lID4gMzApIHsNCj4+Pj4+PiAg
ICAgICAgICAgICAgICAgICAgICAgYmQtPmVudHJpZXMgLT0gYmQtPm9sZF9lbnRyaWVzOw0KPj4+
Pj4+ICAgICAgICAgICAgICAgICAgICAgICBiZC0+b2xkX2VudHJpZXMgPSBiZC0+ZW50cmllczsN
Cj4+Pj4+PiArICAgICAgICAgICAgICAgICAgICAgYmQtPm5ldyA9IDEtYmQtPm5ldzsNCj4+Pj4+
PiAgICAgICAgICAgICAgICAgICAgICAgbWVtc2V0KGJkLT5zZXRbYmQtPm5ld10sIDAsDQo+Pj4+
Pj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICBzaXplb2YoYmQtPnNldFswXSkpOw0KPj4+
Pj4+IC0gICAgICAgICAgICAgICAgICAgICBiZC0+bmV3ID0gMS1iZC0+bmV3Ow0KPj4+Pj4+ICAg
ICAgICAgICAgICAgICAgICAgICBiZC0+c3dhcF90aW1lID0ga3RpbWVfZ2V0X3NlY29uZHMoKTsN
Cj4+Pj4+PiAgICAgICAgICAgICAgIH0NCj4+Pj4+PiAgICAgICAgICAgICAgIHNwaW5fdW5sb2Nr
KCZibG9ja2VkX2RlbGVnYXRpb25zX2xvY2spOw0KPj4+Pj4gDQo+Pj4+PiAtLQ0KPj4+Pj4gSmVm
ZiBMYXl0b24gPGpsYXl0b25Aa2VybmVsLm9yZz4NCj4+Pj4+IA0KPj4+PiANCj4+PiANCj4+PiAt
LQ0KPj4+IENodWNrIExldmVyDQoNCg0KLS0NCkNodWNrIExldmVyDQoNCg0K

