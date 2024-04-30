Return-Path: <linux-nfs+bounces-3073-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B70A8B775F
	for <lists+linux-nfs@lfdr.de>; Tue, 30 Apr 2024 15:42:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5201E281FE2
	for <lists+linux-nfs@lfdr.de>; Tue, 30 Apr 2024 13:42:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1562D171E4D;
	Tue, 30 Apr 2024 13:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="lwdvg4r6";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="m3jGmGeI"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D6BA171E45;
	Tue, 30 Apr 2024 13:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714484564; cv=fail; b=S5mUjHMJ6Qo1sPbZPSCV3PqQ8Ryo9kULd6uk0rFlz9yy36krkOdye4qbtxe7+opeZ59zHnulcLasHS0aZfqNCkunTMC/08nJ3idWfQaMiNzx0MzWxmV9+FQVv34WHtZwnmdgrUMObF507Kap/4CU46b6t2uAvU8XXUoFwuy6t0U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714484564; c=relaxed/simple;
	bh=8jmZBCjg1n1uP+wxYjF9ubX0Rzio6HKeEJdw/h1vkJM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fZpLNm4e7Ul5+oXMaxA4KmHhKnGNsCrWwc1ppPSg6SGIcSs0SC8f/JBY/EqaWrP/ptffru2/f7+rAvzGJpgKBZWhizismKnlJ1lKobuPJb5XnuzW48TN9anxQmb/XZRwN9cKu7TOJB1o7fE9tOtnSxR3g8atelQ52HiGGvBuheg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=lwdvg4r6; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=m3jGmGeI; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43UCnp6l016831;
	Tue, 30 Apr 2024 13:42:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=8jmZBCjg1n1uP+wxYjF9ubX0Rzio6HKeEJdw/h1vkJM=;
 b=lwdvg4r6RWXtLuYB6KeJ1GDrGCaa7P601RMYR2xRbKG6/9RYMLFHppS5YWGsqsbOYz70
 ol1MeofZ4rHKaEvOKQMPVQg0GPD8rKZT0mCvFW8uHqqfQSXFHNojsxXLcBz2blckPFgh
 ohsC6O4SxTPee1NFqZ7i1Ujct0WpJ9hxBQZbmb8vKPMtIVVtvPtltmBcWTVQq6LpfZWS
 ZM9mXcRYyTS6TGaJAcEhtTsHavD+OyP9iBV7+7I9xs2nb7Jgt1bPx6fRpzeTTlj8Eh3X
 yjDxtoCkPVrsOojzHM8FDcm+n2F8R8WbRVxHDyR31RtEYWTmehURyYyWWsni1tjySe4v YQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xrqsew1ch-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Apr 2024 13:42:35 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43UDD6TX008571;
	Tue, 30 Apr 2024 13:42:34 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3xrqt7we3a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Apr 2024 13:42:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CLbRFM95nQhng4Ng8VZP9hW207Fqn5BrmFKrbrp6WbLQ5sMfDj6nVmJnf8h5aCJ8a6mDjYUDJVngwh9m4mAlThtxuxyCQ9TilSJ1kHVFlu0ODHWT+F0/QvttsBUzkgtwn3kcYYwTh1+RY4sKpCJhs9+d+81LCqLB/KuPUO6xZqK6p5hYmsnp0IzX7FrUx8nEb5FujWioKKzwYAB/lfCfK4MceONXqLUOjdHBki183TzW67kG9mIzzwVcsp2JShrd0qKJmc8DkoieVDmjDLU5UqKbyMufZQGf0m3pm38I7KTrC208zfPEbP2C4PdjupWGl6ImTV9XKMOEVq9NcQJI4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8jmZBCjg1n1uP+wxYjF9ubX0Rzio6HKeEJdw/h1vkJM=;
 b=mnM9FAu43+nwlfyMM1TYJEtNigs3BQqnLl2a9DpmR9GcBHfQcumXyP7AsIGMoXLBzAChWa4qi11SO5V7dDzeA+Naq1Sv3igNnPM1WC3tFG2qySo5TCYWXzqJVuk2ljswx9/4QWjzItPoFJbqY6dLqjzfo5CaefoyFn0ctGjlLxTmNe5k58A3pxjHLLqBnTibkCOZA7KD6zOAAnkCSElyinucjpUQuKZUGSM7WZ8DopQSJai6LUJxdG0Dq820g877yEbXDddo1HFUoa+74tJwOEYeBxcym/HCI5xvVpCIxoiWdH31+38qDBCE8cISw0aL1J7wsYqRhnSj4rHegNZShg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8jmZBCjg1n1uP+wxYjF9ubX0Rzio6HKeEJdw/h1vkJM=;
 b=m3jGmGeI4ny2+zU7l4qr0Q2zxr9j+wy9KT1CbiukhtJGhtF/RngEFsX4S1kZZVtTgyf3edxkr+oAeFdPQAkoif+x1SP9v75XWl4JwaUJeD78VfRKuR87QWwDHhPhqRDPy99vziGY3tHtJ/6ftwOLpOo3XqDj5DtNlM81evEDchQ=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SJ2PR10MB7671.namprd10.prod.outlook.com (2603:10b6:a03:547::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Tue, 30 Apr
 2024 13:42:32 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.7519.031; Tue, 30 Apr 2024
 13:42:32 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Zhu Yanjun <zyjzyj2000@gmail.com>
CC: Chuck Lever <cel@kernel.org>,
        Linux NFS Mailing List
	<linux-nfs@vger.kernel.org>,
        "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>
Subject: Re: [RFC PATCH 0/4] NFS: Fix another 'check_flush_dependency' splat
Thread-Topic: [RFC PATCH 0/4] NFS: Fix another 'check_flush_dependency' splat
Thread-Index: AQHamkmDfBfBFsNf5kaeN/1BZO1Wh7GAavwAgABo5IA=
Date: Tue, 30 Apr 2024 13:42:31 +0000
Message-ID: <90F6A893-5315-4E53-B54E-1CF8D7D4AC4D@oracle.com>
References: <20240429152537.212958-6-cel@kernel.org>
 <efc4f895-3a45-4b44-a47d-532896526458@linux.dev>
In-Reply-To: <efc4f895-3a45-4b44-a47d-532896526458@linux.dev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.500.171.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|SJ2PR10MB7671:EE_
x-ms-office365-filtering-correlation-id: bb3f3ca4-1d3f-480c-72e2-08dc691b62aa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|376005|366007|38070700009;
x-microsoft-antispam-message-info: 
 =?utf-8?B?c2FrTUhpV1VDQ25aUlVPSkNPOFdpV0tMSmNCU0pnaENYWEVLTlZXWTZlNWY0?=
 =?utf-8?B?d1BoRUoxaEdVdXlaZkx2UFFITWZRZkV0R2hySE1GTlQvWUVUcDZiTDRuZjlL?=
 =?utf-8?B?ME1ZaEl2Tng3eHBkbThLRCtjTXU1ZlJPc2VBZC9IS2tOL2NrbFhvcTRxbmdG?=
 =?utf-8?B?WXp0VHU1RWtPRm5ib2gwTGZYTmNON1VlZW1udnhFK21wVTl6azVKQ0RLQlZW?=
 =?utf-8?B?ZFpQdm1xcmo2TWRCRmYwNjYwK2g0Q3JXYjZqd1JXMW9ZVHVwNmpCczJvYkVw?=
 =?utf-8?B?N2tqbTBqSE5nMlRFT3htRlErMTFMWDBmc25aOW5Rd25scnFLdTd5ZHk1SzVz?=
 =?utf-8?B?bWxmOW1qWjlRNzViRDAxdWVneE8yZFc3NXZGcGhkQ0FydEtjekh1S01XVVlN?=
 =?utf-8?B?RmppOW1POGxscWxrbWFGMC9DV25QLzlHMVl2Yy9pRFhXeGtFSmEvaWJvQ3J4?=
 =?utf-8?B?N3ZvWXdVOG9CYzZYZ1ZvK1RlY3N4MzJ2UllxTVR5V0hKRllzMmFDb2pvWm5x?=
 =?utf-8?B?SWtYK2VyRUEvd21LUkZSelU1cWppbUJJdjU1WEFXT2dpR2V5NVo2RjBtaEdF?=
 =?utf-8?B?Q2ZGU280USt1c1V0RmYzWmJ0a3RhWjBSeWt3QTBReVdYa0kvNG9VbU9QYmNy?=
 =?utf-8?B?eVZ2L29qL0lKaDEyR3ExbzF1YlRCMHNBUmU1WHRCcWJrR0JkazAwcS9xYWZt?=
 =?utf-8?B?ZSt4Z1RhaDRIZTA2bHROL1ZRWVBWaHpZbFZwQ2hpcEFMZ05WT0Q1TUdVT2JL?=
 =?utf-8?B?U25oUDY3YXQ1Rnc3UTFIUFhGOEtTWmhmdmM0bXRGamlGaWtTbFNRYlZ6SUVl?=
 =?utf-8?B?MVNQOXNyeVJCbk1uMlZjbUdoMjFmcU9LRUJiL0VGSHQwUkkxOW5RVjBORDFi?=
 =?utf-8?B?bVIyOUszcnRaNVVwdXBtbFBnb0VvUjlxNk8rcUtRQW8zUnlGeHhkMEk4RnUv?=
 =?utf-8?B?bTRVQVdLS2pzMFJJL3NIZEc4d2k1aVBUN3liU3dTTHRZdzBjZnNiRmhCSWdq?=
 =?utf-8?B?dlhDTXpiM1dENzEvbHF6NHVrWjZWQjBsNnY1NE44T0p0TklMdkU5Y0dVdGNI?=
 =?utf-8?B?N0dSVGZ0LzlYYWVCRlFVMU9qdmJnSGh6cEsyZnlkelhVNEY2L2dMaHF5K3B0?=
 =?utf-8?B?UlExRGRLS1EyQXZnSEJ6RkJhK2diK0REdzMzZ3V2TXNtbXFwQlVRZjFmNkdZ?=
 =?utf-8?B?Wndpd3M4WG5jTzhjbGdiMTlRZ3MzWm5OWGY0VmRnNGtGd0M3dHhOa0VJUEZT?=
 =?utf-8?B?T3lCYzJvMll3Z2grdytZTHplSjVyRnYyckdIMkVKSFN3WngvdEhkWXJEbzM1?=
 =?utf-8?B?Z2ZnRGVqVFhuUUtTMnJNV1lQVkw5anA4aUhyYi81SzBxRk8zaG5lMnFhcTM0?=
 =?utf-8?B?QUxEWVA3YUtjY3NXRUZBRVg1WEw0ZTBpMkVEb3cwWmhYMWNzeXZ6dVNOUjVy?=
 =?utf-8?B?YUpCR2VyQ0ZPczZFai91a243WXJLcEdRbHJrajB4U1Mwb0JrQmVOYkRnWThO?=
 =?utf-8?B?UjRiWWJkRjZMdVZuK2xZRW9rVVVES3QxcFVHTU1EbG9pZUQvTWJWbi83TWs1?=
 =?utf-8?B?WThYc0U3QzhzTFMrQlpWVDFybzZZRmNKKzczV0RRRDJKa0p6OWZidjBvNlpm?=
 =?utf-8?B?SWFxN3V5YUlWalVkVHNyZXdudG9kSmZ1SjRuRXRwUWZUY2pULzY3UHk2N05k?=
 =?utf-8?B?dTBidjlIeTZSSkVRY0hyOFpSR3J2ZGJ0OGFDa1FnbHlIU0l5YWV4ZWRqNHRh?=
 =?utf-8?B?S2QxZ29ZajE0bHpYYW1Nc2JKUGhrYU1nRk5kZFdFRkJsaWlaaXoyMGg4djdZ?=
 =?utf-8?B?Rk9neldzaUdJRnJ2ZlhXdz09?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?aVVBdm5DS0MyMUNTRG1zSklnaElyc1FFOW1qVTJBNjVpUDUra2hScmFjMWcy?=
 =?utf-8?B?dHdjQ1FtQStzTFI4OHN3WjhZWXlHcDR3NlZVbDlMR0xIT3V6czF0NENHRzlS?=
 =?utf-8?B?Yk5QYjA2b2Z4RWF2YzRKTjIxeHFUVXRSR016Q1FmeXlLWkN6Q1ExSEljU3RJ?=
 =?utf-8?B?RCtRMHg4M0lwTFJjZmlNWEpNSnhLR1pUMXh2MkVVR2xxYzNFazZHTzFkSVBN?=
 =?utf-8?B?VlNkYmdwNWlNZnpXaVAvVG1FSmFPQVdrN1V6V0xZUkhHMjl5SVNtSFFyN04x?=
 =?utf-8?B?QUpjYmNaR1VRTGZ3SUZoSHNkcGlFVVRxOUNmSU81YXFIa1hDSE1PWGFyQWJJ?=
 =?utf-8?B?T3JIS2lNNUowanRLbjFudHN0TDFJdWZpemkxTFJxUTVyQTFzTVdxYXY4bXRl?=
 =?utf-8?B?WDBZTVFYUkVrM3FFdEU5ZTRYSjM1UUNxY2F4d1RvSnNKaXdWVXZjb04vZy9V?=
 =?utf-8?B?KytQSzk4Y3NBQ0E0cHlQUWJ4dW9XeUVZcW5ucU9qUDk5MWhaczk1QmtNcnli?=
 =?utf-8?B?NmZZcGNBeXU3Q2ZUUFJmcEwzd3FleTFQd3l6ZGFEelpaM29iRXZFSVpkSDVJ?=
 =?utf-8?B?RmRnb2JycmtLOUc3NWsyLzZ4emlEZzdDR1dmM1A4elM3QVNhMDJPazB1Mm1W?=
 =?utf-8?B?KzRuOGdMR3Q3cU8rZUJxekt4M1ZEUUd1eTAwbEQ5Q25kd0xSL0FiUFZ5OC9o?=
 =?utf-8?B?MU40VFUwTVFGSURLMjlVOGpnaHJWNnc0N00wRlhRV3pyVms0VDZ4ZFZKQ0xu?=
 =?utf-8?B?YU1XNjN6eDZVVkUweUIyVmwwTGx3ZUVrcmoxNDg5UUg4bUV2ZGJmSndzelhu?=
 =?utf-8?B?dWhHQnRUSmNhRytscTNEOTFTQ1BwVXdpWWdObUtDMHk4dnpjTHVnTUdwVnRm?=
 =?utf-8?B?ZnFCNWxzRGM4c1hIaFlKTEpmMFd2ZVRBYTBIMXVQeHRRQmlNbHNRa1dxekRt?=
 =?utf-8?B?ZHphR0JaWllnVVYxMkExUHRzdWFWeGNyUm53VUZKNnMrcStmYzV5cTcyYmcr?=
 =?utf-8?B?YWE3MzdKUzlGTlVSTU5tdXNvSnlBQ3hDcGtiUEFjdEh0M0d0RU1pVXJ2amE3?=
 =?utf-8?B?eVJBVUhCQk1HTVg0d2N0VTgwZlU1ZGwrcGxzREJnRmdRNVlyTmdjc010cVhJ?=
 =?utf-8?B?VXE2S21vdDU4Ylo2SCtWK2Z5TlBETzVnS0VTMHp2eUthZGw5eHpIV3JrUVg2?=
 =?utf-8?B?czlzbXZOWkIxVzNEdThQREtUcDVmYlJLSEdXY3g5ZWNWaWVUNUpjK092eGMr?=
 =?utf-8?B?ck1IZkhqWk5xL1VKUXE4Qmd4T3BNTGFwbkJleXNsNnRxaWZrMUl1Y1BXZW4x?=
 =?utf-8?B?V2tmU1ZTVUVtMWozTXZMN3FxdElpNWI0dXF6N3BWajE1YWl4OFZtVVVobnFC?=
 =?utf-8?B?ZXN4aFNqYWhtMHNlc2pvSjd5K2dwdUg0UDVFYTN1U050NHdiKzdzYmNEOHhV?=
 =?utf-8?B?QkVSRnREdW9LN2ZNT0hNemZwQmxDdjFDbGhYRkxqV0RWR0lGQ3ZxcElpSkNF?=
 =?utf-8?B?SVh5MCtmdHp0Y084eW9UMVp1TTdoTzZ0dXhhVllUaEZ4VVZ5V1YzSlJSNWNY?=
 =?utf-8?B?KzJhaUtCUUVXSjZxb2lLNzRidFduWndXWFFPL01MdFFoWWg0R3hiMEFGeThN?=
 =?utf-8?B?UHdWTzhaRVZuamI3UGIxT2NlcWVKQU5WM1o0SGRwY1dxWWpyc0orNWdldEg0?=
 =?utf-8?B?aHdnT0xYeVJXNUtyWnQvRWpxY2NtNU1ieFdZS3Z0Z3A3SVdBT3Q4dmJkc1V0?=
 =?utf-8?B?L3FuY05uYzVVQ2ZyTkQyRm5jS0ZRUjZjMXBnZ0dqNXo2eUI2WHN0YlBwTGtE?=
 =?utf-8?B?RXFRMlR0UkhuejBVU2Q0a21MM25xalY5YlJtSzhuQVMrRUhQUzUyTmNpTC9a?=
 =?utf-8?B?UUhPa2tRcXVuV0hHYjcxWDVnSlA2eVFpYXpTYVBNQm9mNE9mVXoybjRwbmJn?=
 =?utf-8?B?Z25tK1ZYZ2h4ODFxbm5iUG5WcU9zaG1WQkx3bkYxMXAzblhFazVmVGgzSEVF?=
 =?utf-8?B?Wkc3dEs2UnBuQjEzalNVVXdNWGRoRDFEUTg1anVoemYvMm05VUs1RTVTRVM2?=
 =?utf-8?B?L3d0MDhnMmFHMnZKTVpEYi9ob3NZK0ZBa2NjVVdTQWVsSlcrSmFrMTB4eHNM?=
 =?utf-8?B?S2tpbDZDMlAwODRsTEhobVRYWWpSYW44Slgrby9wRXVHWlBkWjM4THhCSmtF?=
 =?utf-8?B?OUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0EB4EDA2017EF943B3813954D6A1E3E1@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	nzrGtZp7DTRHKiXSgrKIwA2TApdb3d+59EX7LoPMsudMngG8qDaIvkdpHC9LxGDbBvFFT0EQhVtvRk0hRmWi2ooERXT3bzKUiVKegJXttIqMMd5o3rhilaw5MzpZ6T29c0anE9+1tl8gwzacCbYHHuell1pl08qU+8RbSoR5oJwxH9QDOmsklR8e87KAA2JZiyooaOfG8acAi9w5VK44Xzmi7rZvFu3q91lGPyECorXUAplqY22zLw+OvLB/kxsGXggZWLcDpAoT4GcBv1G+kcVEdcQIONISv5EVKkojud48rvjQU4PusGK9wxMVsNotbiuq8pziG/CaqiBssdgwvobyvZrQF721KDAAi5phnqOvokqTr5CaKwFWbl+XmOQ2k4Qe449wUXjQ81QVZuK0y10dJ71ljWd9Uaay18mfXqyi9uKEV9Y4WqTxxoK76YRMXGS90i93AGVwcpotQ7L2MDRmU47pOtjsrv8zkLheimZrKAhm1IiE1h1ZBgxYnIO5GRiiyyDLoVJC0Ph3oP1loSMSrL7Mh4Sg8zy/Vd7oFeTUAdUT/eEkB8f2PVgTv65GyHCfdYAybhoWIH3DxrQiCoIN7zAWNAMcwBejYGz7AoI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb3f3ca4-1d3f-480c-72e2-08dc691b62aa
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2024 13:42:31.9846
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cQNobk0JhnvE4q2MgPCcRcyZgorhosYXdSUmcv6dixFbWLz6DIz77gscvgCdxQgM7lMhfSH7LLF2XGZamL+zYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7671
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-30_07,2024-04-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0
 mlxlogscore=999 bulkscore=0 suspectscore=0 adultscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404300097
X-Proofpoint-ORIG-GUID: qKU9VdSfaWAoawvsc2WK-8UcMHx-bclG
X-Proofpoint-GUID: qKU9VdSfaWAoawvsc2WK-8UcMHx-bclG

DQoNCj4gT24gQXByIDMwLCAyMDI0LCBhdCAzOjI24oCvQU0sIFpodSBZYW5qdW4gPHp5anp5ajIw
MDBAZ21haWwuY29tPiB3cm90ZToNCj4gDQo+IE9uIDI5LjA0LjI0IDE3OjI1LCBjZWxAa2VybmVs
Lm9yZyB3cm90ZToNCj4+IEZyb206IENodWNrIExldmVyIDxjaHVjay5sZXZlckBvcmFjbGUuY29t
Pg0KPj4gQXZvaWQgZ2V0dGluZyB3b3JrIHF1ZXVlIHNwbGF0cyBpbiB0aGUgc3lzdGVtIGpvdXJu
YWwgYnkgbW92aW5nDQo+PiBjbGllbnQtc2lkZSBSUEMvUkRNQSB0cmFuc3BvcnQgdGVhci1kb3du
IGludG8gYSBiYWNrZ3JvdW5kIHByb2Nlc3MuDQo+PiBJJ3ZlIGRvbmUgc29tZSB0ZXN0aW5nIG9m
IHRoaXMgc2VyaWVzLCBub3cgbG9va2luZyBmb3IgcmV2aWV3DQo+PiBjb21tZW50cy4NCj4gDQo+
IEhvdyB0byBtYWtlIHRlc3RzIHdpdGggbmZzICYmIHJkbWE/IENhbiB5b3UgcHJvdmlkZSBzb21l
IHN0ZXBzIG9yIHRvb2xzPw0KDQpXZSBhcmUgYnVpbGRpbmcgTkZTIHRlc3RzIGludG8ga2Rldm9w
czoNCg0KICAgaHR0cHM6Ly9naXRodWIuY29tL2xpbnV4LWtkZXZvcHMva2Rldm9wcy5naXQNCg0K
YW5kIHRoZXJlIGlzIGEgY29uZmlnIG9wdGlvbiB0byB1c2Ugc29mdCBpV0FSUCBpbnN0ZWFkIG9m
IFRDUC4NCg0Ka2Rldm9wcyBpbmNsdWRlcyB3b3JrZmxvd3MgZm9yIGZzdGVzdHMsIE1vcmEncyBu
ZnN0ZXN0LCB0aGUNCmdpdCByZWdyZXNzaW9uIHN1aXRlLCBhbmQgbHRwLCBhbGwgb2Ygd2hpY2gg
d2UgdXNlIHJlZ3VsYXJseQ0KdG8gdGVzdCB0aGUgTGludXggTkZTIGNsaWVudCBhbmQgc2VydmVy
IGltcGxlbWVudGF0aW9ucy4NCg0KDQo+IEkgYW0gaW50ZXJlc3RlZCBpbiBuZnMgJiYgcmRtYS4N
Cj4gDQo+IFRoYW5rcywNCj4gWmh1IFlhbmp1bg0KPiANCj4+IENodWNrIExldmVyICg0KToNCj4+
ICAgeHBydHJkbWE6IFJlbW92ZSB0ZW1wIGFsbG9jYXRpb24gb2YgcnBjcmRtYV9yZXAgb2JqZWN0
cw0KPj4gICB4cHJ0cmRtYTogQ2xlYW4gdXAgc3lub3BzaXMgb2YgZnJ3cl9tcl91bm1hcCgpDQo+
PiAgIHhwcnRyZG1hOiBEZWxheSByZWxlYXNpbmcgY29ubmVjdGlvbiBoYXJkd2FyZSByZXNvdXJj
ZXMNCj4+ICAgeHBydHJkbWE6IE1vdmUgTVJzIHRvIHN0cnVjdCBycGNyZG1hX2VwDQo+PiAgbmV0
L3N1bnJwYy94cHJ0cmRtYS9mcndyX29wcy5jICB8ICAxMyArKy0NCj4+ICBuZXQvc3VucnBjL3hw
cnRyZG1hL3JwY19yZG1hLmMgIHwgICAzICstDQo+PiAgbmV0L3N1bnJwYy94cHJ0cmRtYS90cmFu
c3BvcnQuYyB8ICAyMCArKystDQo+PiAgbmV0L3N1bnJwYy94cHJ0cmRtYS92ZXJicy5jICAgICB8
IDE3MyArKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0tLS0tLQ0KPj4gIG5ldC9zdW5ycGMveHBy
dHJkbWEveHBydF9yZG1hLmggfCAgMjEgKystLQ0KPj4gIDUgZmlsZXMgY2hhbmdlZCwgMTI1IGlu
c2VydGlvbnMoKyksIDEwNSBkZWxldGlvbnMoLSkNCj4+IGJhc2UtY29tbWl0OiBlNjc1NzJjZDIy
MDQ4OTQxNzlkODliZDdiOTg0MDcyZjE5MzEzYjAzDQo+IA0KDQotLQ0KQ2h1Y2sgTGV2ZXINCg0K
DQo=

