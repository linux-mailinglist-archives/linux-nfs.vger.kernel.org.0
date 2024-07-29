Return-Path: <linux-nfs+bounces-5185-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D58394005C
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Jul 2024 23:26:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 532F62836F3
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Jul 2024 21:26:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0A14186E29;
	Mon, 29 Jul 2024 21:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="UYFzWCX9";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Xo3T60AK"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C91D18E753
	for <linux-nfs@vger.kernel.org>; Mon, 29 Jul 2024 21:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722288356; cv=fail; b=vBcXwN0Dp+TG4PhtDZFRnQ6RFsL8V2PuTiuk0LokgF40i2jtn74ivRhs9xWbf66zTJi3yT50MDFZDMGPHWOOO/kh1U2fC32vSG3CfQ5VJGUh7SCRTN6b/iBXNzhO3nxdNTsJC0ZNOGoDviscxWj4bhQnfgHGLLDA9NURrZ3ziK0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722288356; c=relaxed/simple;
	bh=TZAfT43UvCMO+8qhQbMqQ+GSnyBgBgrQHcT6HrB80xU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Sf0oQN9qoUuJcWbWG9yG6uyWSfGni/Ik4k6uC7HCm/jPoVfz9us1aQdJGhDBFELAs4CcpvcYDWPwOZDbb0FnQRxDq3dvQdI8gTFJqYEWZoS+UqPWH+CVk9kfJEpyYh1Pw8muOVJjCE5ny09XzLKTXKejQYLd/R2qMbw8B93h17g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=UYFzWCX9; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Xo3T60AK; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46TKteuj026091;
	Mon, 29 Jul 2024 21:25:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-id:content-transfer-encoding:mime-version;
	 s=corp-2023-11-20; bh=TZAfT43UvCMO+8qhQbMqQ+GSnyBgBgrQHcT6HrB80
	xU=; b=UYFzWCX9l7MGYn0QZml1C7hn5twPmuaPToAr34JKnNpw+l9b77JqxYURq
	3fZ4PQMp8ED+Nkv8vi40TG2X/+Or6wH4Egj4+Rr+bx3e7AnIof+I4g7AKFGqvluP
	0b02V5HyXM/SuGnU/5+wZ8p7FZ5RlPiO3PZStKSrynx87Og9sjqnPQKz2tk/Yag/
	MQBvepcMxD8SPeAcKOAyl3yKtwSrDJA8nqQIj3wLKPYL3f+Cs62+7D2m6SJSK5G5
	JnVxiN90IYueP1LQJ0lbCSUYjDM7IKP6LxVUwd+sWqDyXd9nFswq0ZfxJMjh3Yb7
	5HkbhopTIVQcez5wUxAh4nfW866mg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40mqfybpw5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Jul 2024 21:25:32 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46TJUfHT025856;
	Mon, 29 Jul 2024 21:25:32 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2049.outbound.protection.outlook.com [104.47.74.49])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 40npcf5e3x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Jul 2024 21:25:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EQC0NhZu8b4D3x9XzwbGvD8ymS28W/PVPbareQgyn/wt3em1nT44JGkMhSSKmVxmhyWE2oP38Xti/v3u6AvoW3EkIkkz2a2vw10OpuBXgVEUt4bQShbShnWk4Xc2lgDATt6nuA0t0Ly4X8RZRbClywoD/3Io5fq3Bt1XUhQS7CEonB0gmNVP0K4/IU4559MxVfwesVbTQ1pUHou4gko65Q9fMjvSRbA9qkdYrlzr4aocCibostBEbKDFvPdhMJT7+aTqLq2UdBAAbZm9kUoVREF6+8YBuKnsypgTqAVdOinVUTY3iwUbzn2vpxB9wW5xvhaC0ZYlUoHbKfjU0dcIdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TZAfT43UvCMO+8qhQbMqQ+GSnyBgBgrQHcT6HrB80xU=;
 b=kVFpLln0eASWzkzvyguXQZcmutqIGJ1C18GkKlwg77Lzng2k+ggMXkRF6PpTJJrPvp8hQCdfOxxdi6+ArCHn/2eSvWtZkS4OaXSuWLsTFvUDO6VSMvpbMyhPAWk7HRC/L6QbuZBrjccNDpoBrpI9CNok21uIfAvi8dWRK2aXOVuP43Hj/rXiDgtFKKi1/coUwqhE+Jf2Jhyoz3O+m+VT+Qr9IDL7TH3jbFkvjGJxrWqS6LszoslsoxJ64Wf9Obzbni+hhIltXm2nA3xG2eBlXeQ1ZVmjFhB6CQdhd+tQuMrtSoYX/hn30DH95CJVZjQE1dLK65zj67y/5AdyB39QSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TZAfT43UvCMO+8qhQbMqQ+GSnyBgBgrQHcT6HrB80xU=;
 b=Xo3T60AK7eQZdbW45xIDAMVmebJCzO/TxSJ8PpVS4y+iTarvKYfyxjzVXRpO32z5tgovm1Vy++L8dim4QCRxVWzOww9cFrzAugd0eCJDNAwTlmL2M464PlgEthj/f2hFydNiFFUrW7vPABGII4KXHaVcsXZurbkePxyjdVPOpZ0=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SN7PR10MB6473.namprd10.prod.outlook.com (2603:10b6:806:2a0::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.27; Mon, 29 Jul
 2024 21:25:28 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.7807.026; Mon, 29 Jul 2024
 21:25:28 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Neil Brown <neilb@suse.de>
CC: Jeff Layton <jlayton@kernel.org>,
        Linux NFS Mailing List
	<linux-nfs@vger.kernel.org>,
        Olga Kornievskaia <kolga@netapp.com>, Dai Ngo
	<dai.ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>
Subject: Re: [PATCH 0/2] nfsd: fix handling of error from unshare_fs_struct()
Thread-Topic: [PATCH 0/2] nfsd: fix handling of error from unshare_fs_struct()
Thread-Index: AQHa4V4SiOdJl0aD0EadOsube9FRd7INxoyAgABtW4CAAAT7AA==
Date: Mon, 29 Jul 2024 21:25:28 +0000
Message-ID: <363EC622-AFCA-4A01-AB81-822C5D2004F2@oracle.com>
References: <20240729022126.4450-1-neilb@suse.de>
 <Zqeo1c37E6xDDgSA@tissot.1015granger.net>
 <172228724989.18529.183021144838147324@noble.neil.brown.name>
In-Reply-To: <172228724989.18529.183021144838147324@noble.neil.brown.name>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3774.600.62)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|SN7PR10MB6473:EE_
x-ms-office365-filtering-correlation-id: bdea4e2a-a037-4065-2f1b-08dcb014f818
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?dmJjcXNrYjBheUlDTFFOUDB3TXpyd2t4Y2RhaWFrd2t5TXcvWUthY2hXQTZt?=
 =?utf-8?B?OEFON3JzWkRXVUJWN3p5RnRnd3BYRDBza01BWkIvemMxajB3ZkJndk41eWlD?=
 =?utf-8?B?RjFwbHBCY0hQeUNIQnpwSDJ1eGM4Q3lxVE8xYUc3RFdXNVQ5aittVWgxVnAw?=
 =?utf-8?B?bWtrWWh1WWIybCs4cVd0Z3BnVEJRT2JqQ1MxTSt3Q25qWVFqU2hsUytnWWRE?=
 =?utf-8?B?ODNjTGNGUG1lZ1FiSXEvU1UrZVhTSEFaY0g5eXNjdXU1czV5M2xPelBUcHBt?=
 =?utf-8?B?WGpTV3h5YUlIbUI4elltSG9EaTcyM2RxRTRRckRNY241dVZ2WW5QMW5EWXBi?=
 =?utf-8?B?YmRBMEIzem5NckRNdkc4eXUyNWZSM0JycXhmT09XWnh0by9FUnZzaXE0T1F2?=
 =?utf-8?B?SmJGWEVuKzFTcVRvdGlueXdoTVovMGlBU042SnUrSVZMemRyVHBMaWdyNnlU?=
 =?utf-8?B?ZWZaTXdicmJ0TVdpS2Z3M3M1TzRTZGtTNEs2TitvUjh3VFNJQ29uMEJocFZL?=
 =?utf-8?B?UXhSeFBFUUE3N2wwRHNRcjRmcEFLM2Z6TGV3akk4MVgrSDUvVjc1WFJmR0hT?=
 =?utf-8?B?SWNvTTRVckdJNGJNVzVLODJpWXRrK0VoSGV4L1RGajltbHY2YVpmeFV3aFNB?=
 =?utf-8?B?Rnh6cWx0cXpyTUx5REZGVjhSZEtibVR3WXNXR0tNdk9ycjNsUHJoUnpGVnJw?=
 =?utf-8?B?T2tDWG5RWmxONWlNM0YvQ0ZoVTluRzI4SFNzdVB6cXJxYjNuWW1YL21SWURu?=
 =?utf-8?B?S2xVV25iendrUHB4dHFGUzQzeVFPb05CbFpnM0lkZGpSWVBFbDJkQ28vcytU?=
 =?utf-8?B?b0NaOWZLb0o0aWZDTHdJN3RnUyt0UDVsd3RnWWE4WWZxbG04eVBBVjJoVWFN?=
 =?utf-8?B?aXhsWDZJbENZOERUeWxKcWlINUNjV212UVA4VThmWkllL09xaTNMeHQrNFJp?=
 =?utf-8?B?M3NZOFU3NEdSOUNFa0gxRDF4QWxkYk1sOGtid2ZWVTlYaVgrc09GcmVzb1Rw?=
 =?utf-8?B?aEJIOGtVcU9QVkhMZGxEbFkySHBDREMwWnVmcldLTEowOERHZlJveW04VWda?=
 =?utf-8?B?NGcvaVUwT3BtalB4U3RLVG9ocXNmOE1uR1ovSzJhcURJdTZXRy9YUmNJZWpD?=
 =?utf-8?B?aUNVbllBMkxqQUl2NFdtMlFta0hlc3oxODZKNTNQWEZRK044c2JDdXBuQlQx?=
 =?utf-8?B?MzIwWVdwbmptWExQVjREd3FkUGJrU2t6S004aFdpT21JOFpIemNSZUNZTWdE?=
 =?utf-8?B?ZVJqSjJQaTZFclBjSG1lQnhwT1ZLR2Q3Q0EvSGpCZlpQS0tFR2FWQ3pRbXdM?=
 =?utf-8?B?eDZrS2lJWElwaCtnOUFRN1NCTHZnY2RnVVVybkF0TS9zRzh1SFQ4eXFTOXpa?=
 =?utf-8?B?N1p4MEhXYjBiclR1cVhFSE9RUEFtVWNocEZVVEFHeWV3NFErdk53THdHcHNW?=
 =?utf-8?B?ZkFWQlM1N1I5WTJVRGkvb2VsZTNtQWcvVHpadFJmOFd5eU42K1hYd1RpakI2?=
 =?utf-8?B?dTFsUmZXWEowUVI3Z0hwUHptVFNncVhEZkY1VFhOL3NqelRFMWNXWWRJZDBL?=
 =?utf-8?B?cHN1bXRjZzBaRVlzaXRIbVpvbHFoZnppZWU0SjNiS3dTNUVzNVVsTGZYTW5w?=
 =?utf-8?B?Q1pMbEd4N3A3azIxTWhDQVo1Q2orcFkxUXpjMnQ1eDRrdHcxeGl2OEo1aGU1?=
 =?utf-8?B?SE05cHFvUjNUK2xuSFlKNHF6NCtWQ29wcFBPdm9lM0l0SHFzQndoZkoxWjBN?=
 =?utf-8?B?aHRkUFg4VkZTYVZGeWNFNHk5QnNYYmY0dys4ZnRWWDQ0WG1QNU81eFBqSUhL?=
 =?utf-8?B?cExsZDRnZnRYbzk3Qk9nRUtzSWxiSjY3TEh3S096RnBJYjhRLzdLS3RPREdn?=
 =?utf-8?B?WE9VeHM0Ylp2eExiQUxYNWUzZlFrZWVtTVpURkZjNDlvbXc9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZEN1azJhS0V2bUpzTlBoajZTZjZ4SllWSnIrN0lNblBBOWdpK01RYkxZYWgv?=
 =?utf-8?B?TlYvUnBibmMyeGxBYTBvOHRYU0pMRWJjYnliaGlmdVJHNFdXb3psU1ByNHFj?=
 =?utf-8?B?WTlQQy9VemlBQWhKaWpGREEzWGkvSkE1S3I5MUpGRGl2UGFuRmZSbXN0RkhR?=
 =?utf-8?B?eFZUaklPd3hKN3BBTHNpYWxESjB0WnBTOE4zQmlWTStGRkZCNE9VOTFIcEhv?=
 =?utf-8?B?RGZVd0Y2bUdxUjBwbDlLbmIvTG05Q3JDWExRTThlRXNWaGtNS0h1ZjFWR3dU?=
 =?utf-8?B?WmxxQzhicVk1L0hURC9HdEVpQVB1YjM5NHMrUG1GYWhkbnk3NkdPejExYWR2?=
 =?utf-8?B?YzJTZDhiaFhtbXFZRXYzVUM2Z2JNVi85cFZuWkFlS2ZrcERrUXRwZkRzSWox?=
 =?utf-8?B?SGxPcFFxOVJ5dFZ3SmNwUSt6cTRCbytkMnFqVHM0WmhJQkdraFdGNUpuUDRZ?=
 =?utf-8?B?ck45ZkpwTEtIQitKd21aNWRiU3lZbjhkV21pWXkyOUs0VkdMdDd0T0YwUkFu?=
 =?utf-8?B?WHB1Tmh2RzlGKzMyNzhPTXdCZVVNenBUY3JqUDcvVy9tMmVRTjg0cCttZUF3?=
 =?utf-8?B?Z3ZIOEgrY1M1MUhPK2NRZHRYOTd0WU52S0JrQWhyUjdQT0R3SEw2R1U1RERU?=
 =?utf-8?B?alorU1dQeWx2MjNDMEVaMHBTVnhORUNhVE9zNDhzelV0Rm5MWGVQaTlEQk11?=
 =?utf-8?B?Sm94YkE5V3dDUnFpd0RYOVZaaGd3eTlYbkVqd3ZhMTdwbkE3RGYwaGhDdEJp?=
 =?utf-8?B?dVpqdHhuenJZSE9HbzBRMGRSRnN0Tk1jQjRhaStHalc1OWlIVmltOStPakcy?=
 =?utf-8?B?UEV4aThwVnFxck51L3JqODhhS2dxVmttOWw3QmlMNjNSWCs0YnlUMmFLK2F4?=
 =?utf-8?B?SHBNVkRpZmMwQURTSFZiMG5Yc09IZC9BYlNtRnhLM21ZTCtGNVNhVU8zbjBy?=
 =?utf-8?B?VDN4aHJaR2xiU0F0bUNSQ3BmTTJ0bEFsa0lDL3pIdGQxaGF5ME1MVWtCcFFB?=
 =?utf-8?B?NUF3bC90Z3Z5Tmo5clNMb0w2dDI0aXJEUkxHSHdMZGRMODJ0RG9IZktSc1Bm?=
 =?utf-8?B?N1FPcGEva2ZnMU1rRDVYaW02aHNDaG5YZ2kyZWNlaFprSUtvQ1NKN3ZxSTIw?=
 =?utf-8?B?TTRpMXNjR2VLRDE3M21uYTgxZnUyMGU0bkE3aG9TQi9rRCtEdkR4b0tNWHlq?=
 =?utf-8?B?SmF5VEhUSHpENzNPTUx0WXFqb2gyN1ZJQkxRNTMrUWUrKzI5UTAyQk1ZN0NB?=
 =?utf-8?B?U0FweVd5K2VoY3Vva2IrcGdTSlZjampxWE5hdHFjRGhjdFJGRGpaS0ZvMjcv?=
 =?utf-8?B?VWpkdjA5VlZuWWRxYVNXYmh2Y2diNUJDRUdqQXNZWUFPSnFKNm11dUY5MHBP?=
 =?utf-8?B?bEY4bTQ3ck1iVW9OQ0MyWCtDdU9iUVhmbUJsOW5wMzVmYzh0OGF2OUc4S3po?=
 =?utf-8?B?L1huR2l1ZDVOVkU2azJXUW9aRGFDTjRidWNCaEg3eFpBM2hidWtKTmlUWVRi?=
 =?utf-8?B?a2E0YVlESlk2N2orb2RMcnV5aE8yUmxxVTdkSDJ0SHJ6MUtkZGV2aEV4a1JQ?=
 =?utf-8?B?ZHZHMHBZaVRxcUFueUh1ZGZJV01mTGl3N1djMUxVQ3BZWTNkQWFlNWJBSnRs?=
 =?utf-8?B?cGkvN0phTEhQZldpQzE1dVpsbk5wQ3NvSk9ydlo4a2Z1b3RQL3hBNjBIWWIv?=
 =?utf-8?B?ek1lcVBtU2t3MW5mYml2Y1JJTjhLMGZpSEFCeXlYMU9adkg0N3pjRFcxMXEv?=
 =?utf-8?B?aHN5N2RyVENLWTZrbzcvS0J3YWNza3BXTUFNVjc1Q3ZNc0tmREhjL3c5cjRN?=
 =?utf-8?B?M0N6T3ZIQ2Z3Ri82MCtTUjgwS3ZNWndQTmVsZnA5TzAreWRHU2l4NEc2ZStt?=
 =?utf-8?B?cFl3QjAzVExyVyt6aGdKQXR0aHptUUZFN1NvTDh4WHBpS3hEZjgxRHF1cnJB?=
 =?utf-8?B?ZEx2SURRMXozTTIyNjFMVXZRWGJlc05OVDFYbjdqOWJzemlQblFXbldRMzVQ?=
 =?utf-8?B?NThPTWJGQUpZdnFyY2cybTVIS3o4cE50WEthTStoRUx0QXRuOUtGOW1xWUZR?=
 =?utf-8?B?RkhUcGFnb2hsMG5EMnhvSjJ1bE82MHoxemQ3a04xYTVETy9tNHlSQlNaVFY0?=
 =?utf-8?B?d0xGT0J5Z01CTmJrMGV4SFpWU3htUTUzTlZiUFFnTWJaenFnNHNWKzMzQ3E3?=
 =?utf-8?B?dGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FA01A80D85D35D4C8E96A89D2F907ACA@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	m0mrdItKKxcIqXFfxZHp4zB+fCVpZOY8DeJOmNFqTftq3vh9Cmo2FPy3c0lbWcTxEWuBjEc5kvpUNza5ej8gGYmlO5Q5Av/I9d3/LmwcQ2mr4tv2H4cvBrn1V5YqcUNFn9hLSBCIw04PhlN8GwlHMxDPQ00YM9nigHtqxfvfZz6rnpOoMOpSW8PhU0ji0FCOgjKKg+LRZkfFtLBwIuxPCrvNzICzHQSkIlhh6WHgYmKjNSBbNiOKv7hCD5O1Lb/LZWjzgYOXRC+dmKbVgeRtMkGzXjrtglhuUIRD1Pufic/ctWQLQF2IahilH+03clCKAkeQVoyaIpS9+3QVPJXyUnnFElTSNOuio6I5KJkvlMU84lVK3ja4rP5XdZuaO3tuUm/aGuItrMWY68NNpdRZH+3F9/lE7hhEru90k+1K2lWs6A2muX4wPbrlYuXeZB4iM98PNjXOzyOzi2htnrKix2p1THa/Zuqpf42ong9eN13L6RRUwYiX4WVwgnxhmThy8KzMKFZvSM4gdrWinb7v7Axj6BqJkmwNnpS1+6Y4wWTgv5auQGlywCJpcd2a8SsN2NN1rw18VnhPkhIWFABp2EQ7tUOJMGH1rdmyx44DrGk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bdea4e2a-a037-4065-2f1b-08dcb014f818
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jul 2024 21:25:28.7346
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Lvu0jvIYnSbZGxJQ7WUWW79g+4aqn7omQfbPcvcr64Na+5D5I3kWtMqf0ly12a1o1eYwe9w6JUHkAQEcIuKcBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6473
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-29_20,2024-07-26_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=807
 bulkscore=0 suspectscore=0 spamscore=0 malwarescore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2407290146
X-Proofpoint-GUID: B3eFhmPcif-a4enFN7fXe-Tm3cIE3Q_g
X-Proofpoint-ORIG-GUID: B3eFhmPcif-a4enFN7fXe-Tm3cIE3Q_g

DQoNCj4gT24gSnVsIDI5LCAyMDI0LCBhdCA1OjA34oCvUE0sIE5laWxCcm93biA8bmVpbGJAc3Vz
ZS5kZT4gd3JvdGU6DQo+IA0KPiBPbiBUdWUsIDMwIEp1bCAyMDI0LCBDaHVjayBMZXZlciB3cm90
ZToNCj4+IE9uIE1vbiwgSnVsIDI5LCAyMDI0IGF0IDEyOjE4OjE5UE0gKzEwMDAsIE5laWxCcm93
biB3cm90ZToNCj4+PiBUaGVzZSB0d28gcGF0Y2hlcyByZXBsYWNlIG15IHByZXZpb3VzIHBhdGNo
Og0KPj4+IFtQQVRDSCAwNy8xNF0gQ2hhbmdlIHVuc2hhcmVfZnNfc3RydWN0KCkgdG8gbmV2ZXIg
ZmFpbC4NCj4+PiANCj4+PiBJIGhhZCBleHBsb3JlZCB3YXlzIHRvIGNoYW5nZSBrdGhyZWFkX2Ny
ZWF0ZSgpIHRvIGF2b2lkIHRoZSBuZWVkIGZvcg0KPj4+IEdGUF9OT0ZBSUwgYW5kIGNvbmNsdWRl
ZCB0aGF0IHdlIGNhbiBkbyBldmVyeXRoaW5nIHdlIG5lZWQgaW4gdGhlIHN1bnJwYw0KPj4+IGxh
eWVyLiAgU28gdGhlIGZpcnN0IHBhdGNoIGhlcmUgaXMgYSBzaW1wbGUgY2xlYW51cCwgYW5kIHRo
ZSBzZWNvbmQgYWRkcw0KPj4+IHNpbXBsZSBpbmZyYXN0cnVjdHVyZSBmb3IgYW4gc3ZjIHRocmVh
ZCB0byBjb25maXJtIHRoYXQgaXQgaGFzIHN0YXJ0ZWQNCj4+PiB1cCBhbmQgdG8gcmVwb3J0IGlm
IGl0IHdhcyBzdWNjZXNzZnVsIGluIHRoYXQuDQo+Pj4gDQo+Pj4gVGhhbmtzLA0KPj4+IE5laWxC
cm93bg0KPj4+IA0KPj4+IA0KPj4+IA0KPj4+IFtQQVRDSCAxLzJdIHN1bnJwYzogbWVyZ2Ugc3Zj
X3Jxc3RfYWxsb2MoKSBpbnRvIHN2Y19wcmVwYXJlX3RocmVhZCgpDQo+Pj4gW1BBVENIIDIvMl0g
c3VucnBjOiBhbGxvdyBzdmMgdGhyZWFkcyB0byBmYWlsIGluaXRpYWxpc2F0aW9uIGNsZWFubHkN
Cj4+IA0KPj4gVGhpcyBzZXJpZXMgZG9lcyBub3QgYXBwbHkgdG8gbmZzZC1uZXh0LiBJdCBsb29r
cyBsaWtlIDEvMiBleHBlY3RzDQo+PiB0byBzZWUgdGhlIEVYUE9SVF9TWU1CT0wgYWZ0ZXIgc3Zj
X3Jxc3RfYWxsb2MoKSB0aGF0IHlvdSBhbHJlYWR5DQo+PiByZW1vdmVkIGluICJTVU5SUEM6IG1h
a2UgdmFyaW91cyBmdW5jdGlvbnMgc3RhdGljLCBvciBub3QgZXhwb3J0ZWQuIg0KPj4gDQo+PiBB
bHNvLCAxLzIgaXMgRnJvbTogeW91ciBicm93bi5uYW1lIGFjY291bnQsIGJ1dCB0aGUgU29CIGlz
IHlvdXINCj4+IFN1U0UgZW1haWwuIChNYXliZSB0aGF0IGRvZXNuJ3QgbWF0dGVyKS4NCj4gDQo+
IFByb2JhYmx5IGRvbid0IG1hdHRlci4gIFRoYXQgaGFwcGVuZWQgYmVjYXVzZSBJIHdyb3RlIHRo
YXQgcGF0Y2ggb24gbXkNCj4gbm90ZWJvb2sgaW5zdGVhZCBvZiBteSBkZXNrdG9wIGFuZCB0aGV5
IGhhdmUgZGlmZmVyZW50IGRlZmF1bHRzLiAgSSdsbA0KPiB0cnkgdG8gcmVtZW1iZXIgdGhhdCBm
b3IgbmV4dCB0aW1lLg0KDQpTb21lIHBhdGNoIGxpbnRpbmcgdG9vbHMgbGlrZSB0aGUgRnJvbTog
dG8gbWF0Y2ggdGhlIFNvQiB0YWcuDQpCdXQgYWdhaW4sIEknbSBub3Qgc3VyZSB0aGF0IG1hdHRl
cnMgZXhjZXB0IHRvIHRoZSBsZWdhbGx5DQpwZWRhbnRpYy4NCg0KDQo+PiBDYW4geW91IHJlYmFz
ZSBhbmQgcmVzZW5kPw0KPiANCj4gSSBjYW4ndCBzZWUgIlNVTlJQQzogbWFrZSB2YXJpb3VzIGZ1
bmN0aW9ucyBzdGF0aWMsIG9yIG5vdCBleHBvcnRlZC4iIGluDQo+ICAgIGdpdDovL2dpdC5rZXJu
ZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC9jZWwvbGludXgNCj4gQW0gSSBsb29raW5n
IGluIHRoZSB3cm9uZyBwbGFjZT8gSWYgbm90LCBjYW4geW91IHB1c2ggb3V0IG5mc2QtbmV4dD8N
Cg0KRm9yIHNvbWUgcmVhc29uLCBnaXQga2VlcHMgcHVzaGluZyBteSBsb2NhbCBuZnNkLW5leHQg
YnJhbmNoDQp0byBjZWwncyAibWFzdGVyIiBicmFuY2guIEkndmUgcHVzaGVkIGFnYWluIHRvIGNl
bCdzIG5mc2QtbmV4dCwNCmFuZCBpdCBzZWVtcyB0byBiZSBzaG93aW5nIHVwIG5vdyBvbiB0aGUg
d2ViIFVJIGFzIEkgaW50ZW5kZWQuDQoNCg0KPiAoYW5kIGlmIHlvdSBjb3VsZCBkZWxldGUgImZv
ci1uZXh0IiBmcm9tIHRoZXJlLCBhbmQgcG9zc2libHkgb3RoZXIgb2xkDQo+IGNydWZ0LCB0aGF0
IG1pZ2h0IGhlbHAgdG9vKQ0KDQpJJ20gbG9va2luZyBhdCB0aGUgbGlzdCBvZiBicmFuY2hlcywg
YW5kIEkgZG9uJ3Qgc2VlIGEgZm9yLW5leHQNCmluIHRoZSBjZWwgZ2l0IHJlcG8uIFRoZSBvbmx5
IGJyYW5jaGVzIEkgY2FuIHNlZSBhcmU6DQoNCm5mc2QtbmV4dA0KbmZzZC02LjEueQ0KbmZzZC10
ZXN0aW5nDQptYXN0ZXINCm5mc2QtNS4xMC55DQpuZnNkLTUuMTUueQ0KbmZzZC1maXhlcw0KZXhw
b3J0ZnMtbmV4dA0KdG9waWMteGRyLXRyYWNlcG9pbnRzDQp0b3BpYy1yZG1hLWZhdWx0LWluamVj
dGlvbg0KDQoNCkkndmUgYmVlbiBkZWxldGluZyBvbGQgdGFncyBhcyBJIG5vdGljZSB0aGVtLCBi
dXQgImdpdCBwdXNoIDpicmFuY2giDQpkb2Vzbid0IGFsd2F5cyBzZWVtIHRvIHdvcmsgYWdhaW5z
dCBnaXQua2VybmVsLm9yZy4NCg0KDQo+IFRoYW5rcywNCj4gTmVpbEJyb3duDQo+IA0KPiANCj4+
IA0KPj4gSW4gMi8yLCB3aGF0IGlzIHRoZSByZWFzb24gdG8gbWFrZSBzdmNfdGhyZWFkX2luaXRf
c3RhdHVzKCkgYSBzdGF0aWMNCj4+IGlubGluZSByYXRoZXIgdGhhbiBhbiBleHBvcnRlZCBmdW5j
dGlvbj8gSSBkb24ndCB0aGluayB0aGlzIGlzIGdvaW5nDQo+PiB0byBiZSBhIHBlcmZvcm1hbmNl
IGhvdCBwYXRoLCBidXQgbWF5YmUgaXQgYmVjb21lcyBvbmUgaW4gYSBmdXR1cmUNCj4+IHBhdGNo
Pw0KPj4gDQo+PiANCj4+IC0tIA0KPj4gQ2h1Y2sgTGV2ZXINCg0KDQotLQ0KQ2h1Y2sgTGV2ZXIN
Cg0KDQo=

