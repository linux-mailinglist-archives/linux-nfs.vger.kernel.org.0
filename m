Return-Path: <linux-nfs+bounces-7109-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC29399ADF4
	for <lists+linux-nfs@lfdr.de>; Fri, 11 Oct 2024 23:13:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 978AB284454
	for <lists+linux-nfs@lfdr.de>; Fri, 11 Oct 2024 21:13:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34BFB1D0F74;
	Fri, 11 Oct 2024 21:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="GJOJHykX";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Drhqalq+"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C07D1D0B9E;
	Fri, 11 Oct 2024 21:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728681224; cv=fail; b=qRV/XeYbPYYzCsuQ6r/WiKpjVCDgiJ44wC70eVuNqIabYuZ3Hvmf/vGccUi2kWfxqHO2SwrSOI5mFGILhYOFf91hUitfkCMZ6HwLTFxN2XGWm+THjUMtBazjjwB/14lqmjrUXd9ob9GxMjPsiK8xgOs5r45eFmcv5TftJgEkVPo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728681224; c=relaxed/simple;
	bh=cukGZ1R2r5w9Cq/LoaI5uEjACq/jWFcvfcnpmXkOq0o=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Jzh7YUpT91PQNQ+e+Iy71DzTXzaKUAE618pgmFyQBtkl9YBg40hgh4nrXP98GOM4P6HD6P4g/xnC+WIKphYhavE92KC0Bt5eh6qB8Zp6v3sQnyTJHobALSYoEFr5VxCBeNYS64fzDhVq1A3bdhzesTOKPqq2c/+SsVUhSlmG8oc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=GJOJHykX; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Drhqalq+; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49BJU81u030021;
	Fri, 11 Oct 2024 21:13:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=cukGZ1R2r5w9Cq/LoaI5uEjACq/jWFcvfcnpmXkOq0o=; b=
	GJOJHykXQquAGsT0YWMf1iK2IeAsspq3XBY93fAnOdtsAhWHnVtxMOpHBcj0aelI
	tvmKD95yTFZCw98WfxzTDkjUkQAuJ21fiPOrRbifc4Yct9f18/fy7GazaGg5pcEL
	3pL8xkeQHzcJBdtR+LQO3THkCvxD66107Q3Z5YsSO2MnYJ3kzdt1s46E64D7RBqs
	1lL9QMhnQ3u82PveCZon8c/p4Mlfgek/M4KRzL33aYTyROMAM2/SYlstiRNf09X0
	q33o84QnfQmb0tDiPGouzteAdf+788Nn7qzgZ4iP2SpoZpToUsyGDeQCBlJpxg3D
	8rpbp6+sEvsnpuiaIqdTyw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42308dwu7j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 11 Oct 2024 21:13:30 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49BKK6Pt028012;
	Fri, 11 Oct 2024 21:13:28 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2047.outbound.protection.outlook.com [104.47.55.47])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 422uwj2jbc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 11 Oct 2024 21:13:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m6ivboRjhKt8zMz93wdCyUpLZnKepiBh6wa/yPZw0GEomhpJ+FP9nzzlRLx4PKAXD1zRcHnx+JD8ugAaHgZQMIZ9G+/m+6Q5qVgia2hDa06MhI3NvEPPs9dsH4hHkvULML2bcg/RA1wcupw4ymNVCn5l9X4jfnbQ6AQieiGgGlFU9CqUwGIRq0oVnl+2CPQ8wr91+KQNmC9awrVv+pA5H/nCZk/xoAzi39wVac2RAWe/Np0kM8ZU/WvnCPAwyQIfj8nsfex95Pf9ny7O0+HGhkZsYVg1Wdt1wGAlgKq9oER4mGpHIx0szz02iydnDWSuNgzBwVJU2HwRxnjUiays3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cukGZ1R2r5w9Cq/LoaI5uEjACq/jWFcvfcnpmXkOq0o=;
 b=r5hUMOKJU5i4Mji3Opzc0HVSOQSdeiKwx+Nb5IaN0+1/lcFhA9GURrToz2ld3mMsjzvxkFQlKP/qa5d4oaPJSmC7hFxT6r1I/l3frjWByDl61A1FVNnCSSjVqjcQN8PJHJb0RKI1W/5q6ff9IK+QCecMKxXQcuV74PLqWLAS2DXE3yIDfnNv/gvLOx28rWGcvbfI+C0+ZS3XbDAV5sUHf57lC+/TQhO1JcxDQD5Q2SVMOvo+egsLxLrtu8QC9UcwxM0vsIHnaqotjH2J083mgvnZBXB7W44IeBwYcGu3DycRiMO7FrZIZrv+Rwyq4UAEGRv1evjbLCX7NXyif4zwgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cukGZ1R2r5w9Cq/LoaI5uEjACq/jWFcvfcnpmXkOq0o=;
 b=Drhqalq+WhMJkJm6mzbSbkkDaTkT8kMyxUI1QaaDxdy/NXSj762biwa+fYn42/64RxaGkc3yLVw72tHjr81TbyvaXv2GeqB7mkzxWjy/D7ORDdSrERNXTmyFqKC7SKkQ3PbdsqSnsHB2lUXMPLCWNycWTQwe2HCrzLa5mLWf0YA=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by IA0PR10MB7383.namprd10.prod.outlook.com (2603:10b6:208:43e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18; Fri, 11 Oct
 2024 21:13:22 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.8048.018; Fri, 11 Oct 2024
 21:13:22 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Neil Brown <neilb@suse.de>
CC: Jeff Layton <jlayton@kernel.org>,
        syzbot
	<syzbot+d1e76d963f757db40f91@syzkaller.appspotmail.com>,
        Dai Ngo
	<dai.ngo@oracle.com>, Olga Kornievskaia <kolga@netapp.com>,
        Linux Kernel
 Mailing List <linux-kernel@vger.kernel.org>,
        Linux NFS Mailing List
	<linux-nfs@vger.kernel.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        netdev
	<netdev@vger.kernel.org>,
        Olga Kornievskaia <okorniev@redhat.com>,
        "syzkaller-bugs@googlegroups.com" <syzkaller-bugs@googlegroups.com>,
        Tom
 Talpey <tom@talpey.com>
Subject: Re: [syzbot] [nfs?] INFO: task hung in nfsd_nl_listener_set_doit
Thread-Topic: [syzbot] [nfs?] INFO: task hung in nfsd_nl_listener_set_doit
Thread-Index:
 AQHasSgfq92jO4adGE2aUUYlbrdUmbJCQxwAgAIRoYCAA/UAgIA3Zx0AgAMAoICAAC+0gIAAAUKA
Date: Fri, 11 Oct 2024 21:13:22 +0000
Message-ID: <E101BD08-4779-4945-84AE-F3660B7A159D@oracle.com>
References: <2E11BA19-A7FD-44F9-8616-F40D40392AA4@oracle.com>
 <172868092131.34603.3179327692157650453@noble.neil.brown.name>
In-Reply-To: <172868092131.34603.3179327692157650453@noble.neil.brown.name>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3776.700.51)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|IA0PR10MB7383:EE_
x-ms-office365-filtering-correlation-id: 66985eeb-c594-4cd9-22c7-08dcea398991
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?WDg4bG5CWUhTVlNUMEROeDVueTdiMXZDNlkwQzFPU1Bvakt6NVZMaUtCU3NJ?=
 =?utf-8?B?WW9keU5vV2VSYkJWUmdwNGdFa2E0R0o1aWlTeWVPUytQUGxhK21HSUpNdnlN?=
 =?utf-8?B?Qzl4MVg2QlppMFNtYkFONHE4Vlk0ZTFBQlpvbTgxdFFCTXVtUkRCR0FwNk9k?=
 =?utf-8?B?Zm1jMS8zMkN3d1VEbk4zWGN5NFU1MEQ5UWFBdFR2SWlyYmhkZzJxMld4TXl5?=
 =?utf-8?B?ZDNxblpjeEpwUXF3Y0s1TG1PcUVxSkFiSmluV21XMFUyVTZySzRFMjltNm5w?=
 =?utf-8?B?UEd4RXBiZHFZOXpGRUdwWE1TYU1BMDZoMFVSYVpRaHNHK3hmUmY0UisvclZa?=
 =?utf-8?B?b25IUHZBdmd2WnNqQi9hRDgyL2hhaHBVaGx1L0p1dmNUY3NaRUc4MFJ2dGR2?=
 =?utf-8?B?eWQxTnJMSERMT1FkMGJwMXVWN1prWldTRVQxaXNxdDVwenJZdTZQVGxkY3lP?=
 =?utf-8?B?dVdVWExlN3hwOWErdmdPWlVoREx2cmtWRjhRTXB6R09zQ2RuM2MxNklkL3o1?=
 =?utf-8?B?NUkwQUZ4UVpxYUNEdGQ0ZWVUcVptYWttTURHYVQ4NHFRUUdmNmFHUVhzWVNz?=
 =?utf-8?B?UFRhMGhQMDEwVjNlaXpaSXlmY0tpeVhIWnBYbUFKZUhXOWZhS3lIUGZRcnlk?=
 =?utf-8?B?L1dzdEpDTUYwelNEd1haT3VRN0ZzQzNLcCtyQ1ZHbWpoUXNOMHBGc2RmSXph?=
 =?utf-8?B?SHZTV1FNOFFYOWhRcnIzTFZRNUo2ZDczb2pFSjJhWTJQNEgvM25tVGZITmUv?=
 =?utf-8?B?cmxjNS8zZGJMNTlXZ0JtdWtkMGd1K2xLdHAxZ0xZbjJnNUY0RkpyamEyZmVG?=
 =?utf-8?B?cWY0UUtPaGVOSnJhMUFLa3FnZzFIZzJzUXR6d21YaDlLY0xRMFVMVFBsQTlo?=
 =?utf-8?B?NGp1dWpZaHVheEk0cTR5SVFHQWVPTW5lWUtqQkJHWm1TUWNJazJ6bUpiTER6?=
 =?utf-8?B?N0htVjJtM0lSbFZJbS9HcFdqN0hTL1crWG5DbGFJSEQ3ZGViNldRQVZVNFJT?=
 =?utf-8?B?cGZucWVWNHZ2a1NJdHQ1eGNna2lmbFh0VmcwMTVjeXdpTDdwbkpGSlQ1SzM4?=
 =?utf-8?B?cWJ0aU1CeGZ5OHA2enJXSjZSZGRBRzZuM1YzVjJyYVVQK0RJZEZCMUhMK080?=
 =?utf-8?B?bUdtZnVLRCswWXR2SHd6OXA2VWFQdWo0TG43dUN6eWdVL3RGSVQ0R2R3Wlkx?=
 =?utf-8?B?ZUlnYmNQTEN5QjBBRnUyVTYwYlBaZytKNHBXejFBT3lIT0ZmWGRlMDlhOGI1?=
 =?utf-8?B?S2RzRHF3cTZSYjlKOXBLRzdKMnZXVHFSUG5BcTF5Y3Q2MzE3TGlLVm5EM2dx?=
 =?utf-8?B?aEFxNkwxUm9xNFNwdXl2L1ljakgxVDRJckdJUzM3Ujc4RFI5NjZSVVBNSEdG?=
 =?utf-8?B?Mnd4cExRMUVSRE5nUE1jYUxkT3hMUVd0Z0FVdWhMK0lPN3pLUFZNcU9mMW53?=
 =?utf-8?B?ckRhaXk4djZLVGlvM1hjd1IvQTVIVTNFUGVnTXBRb1dsbHBCT05zVjRUQU1j?=
 =?utf-8?B?VERRK1E4ZmNWOGw5U2Z5VjRoT3p2a2xuYXo4UUVIRFUwOWNOcmp1NUxvYlNE?=
 =?utf-8?B?cllzT1BZeDk1eGlXYVo1MkZMMFhZeGpITzhwb0Y2bVFQOG5CemVqUGx5eFJS?=
 =?utf-8?B?UmhrRUhzSmhtTFlibjNTempSSEF4dkpBSkwycGpqM1JMdnNUSU9FTXRzSkRH?=
 =?utf-8?B?REZ1clYvOVlxR1JoK3pVcDdPTU5Lc1lmTVBCMUVaL055eWxUS1RkZXpaR3RU?=
 =?utf-8?B?ZkhieGRteFlHSVVrOFdnR3Q0Ymg5TTRQTkh5ZkFyeEp6RUc2c1NkcW5yQ2Rr?=
 =?utf-8?B?VktuRHd2V0t5UExDMExUdz09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NDd6dW8vbWlkck5QbVF4cWhJZEpkZVJiQ2VLVDFjRjRsLzExbm1FUlRhKzBv?=
 =?utf-8?B?RlhMTlNJMU9RV2R3VWo0M2lnM25aVHhWck1pb0dDbUlQdkVkYnRpUnIxK1BL?=
 =?utf-8?B?N0ZsVk9Icnh1czY4UGVjRS93Vmk1d2pVbllDT3dkMnRPekFmUkFMSDZybER4?=
 =?utf-8?B?OGNkNy83NURXNkxXZWlRK1Ava3hBemRyZXhjbU4rYlNEUUdWdmlzMGxDZDFU?=
 =?utf-8?B?OTd5UTNyTE9ucGdQeVpPV2NOZWo1REhsb1BYYndUUkVwQ1hSeDdKRDd4c2RM?=
 =?utf-8?B?VGxnYTNMb05IYTRXTzg5aVZtVUpYbjBGalpIZlAyRnB2T2dsT1J6c3hmbXNL?=
 =?utf-8?B?RVdaaVFIdzlTQWZEZ1V6YTVWZEo4S2h6bXBBNjZoVXM1Z29FUlRYNHRKbDVF?=
 =?utf-8?B?aEpDMURRKy80ZTRZclJGdWxsYlhnRlRZNThRcGRpL0d6Q3RsOFNuQWM5cXE2?=
 =?utf-8?B?Z2tjSmJuTEZrM2plYXkvMm1tZEh6dld6K2NwZXRPVHVscFY0clVxcTdhbk9Y?=
 =?utf-8?B?bEl0Z2VLTnRxeVdCWWRPZndoWFpaOWRPcjJ4SVo1VDRQSk5EMGNqRFM3UXBa?=
 =?utf-8?B?Z0NEUlg0TmloMW90dVRYRFdwcDM3R3ZOSzloOXFvd1AzbUtpL1YxejI1K1BF?=
 =?utf-8?B?cWE0T3FyTXYvZ2JIVzZPYjBxc2czMytNUXFtQXhZOVJVQ1EwbSsxdS9nYTl5?=
 =?utf-8?B?UXcxRmZwWmJTZ1dtUTVhcWdUT0YxKzBjMU9GUnlic0tDWTUrcUp0VWNBN2VT?=
 =?utf-8?B?WGJWeWJVN00wZjduSE04ZTZ3Nys2cGZxRkFTdWtaWExVWUw4S3dVdTRqUkZh?=
 =?utf-8?B?SG1mR3dBN1MzRVNIL084OVBKZVdGNVNLcFlobk5kOG80MGRIVThQcjVocER0?=
 =?utf-8?B?SDBCYlY0eS8zMVlYbHdFYm1IUklIN3IrOXlEWHNLaG5hSGQvN2JlTDRJQWRz?=
 =?utf-8?B?Z1ovbjBDTncySXJwQ1orWnM0TmN0VlpYVU9lT2lMMHdGN2Y4NW95VVMyMWpX?=
 =?utf-8?B?OG0xT3B6eGdBbzB4YmRLMStlM01nems1ZUZLTUMycWxaMGdWVXd0NnZpcXFk?=
 =?utf-8?B?SVVyQ0s1c2g0UnFBUGUvZm8vQWs4QzRxb1RRYkVZUlNROEJ3a1kzbHVGTisw?=
 =?utf-8?B?VTNpZ0lzTjRIOEw3SllSUjZJWkw0cjJvTVBYY1ZCUTlWVWJ4WXVSYUpndG5K?=
 =?utf-8?B?R0s2cTNiK0xMK0taNDlMNDRSczRJTU1SWkRkL1k0VUNoWHZzQjhzVWYvSGFF?=
 =?utf-8?B?UTdJMjhJajFlZHhZRmxNaFk2RGZ6T0FhMVpzZ0hJWHNYMVJaSFNSRFo3WEJU?=
 =?utf-8?B?QWRQZm96R0krRFdTMTd0TGV2aGdpaXdIaU1DSldFb3JnVUZ0aWExRUFvSVVs?=
 =?utf-8?B?V1ZZRjE1NkVLbUFESDRZWTl6Y284THNWSVNKUDVtV2ZVVWFtS0NtV0Z0MnJI?=
 =?utf-8?B?Rnlmb0xYc0xvc1FMR0RaZzdmUFhTc0NrdXlJQjB1RnVwaXc5TzVOR3dRaHds?=
 =?utf-8?B?UHNXODQyNUoxemlwNFFNTGdaUURlcDViUlhnYStrMERiZnNiOHRoNGh4dlVB?=
 =?utf-8?B?cGd1S0pCNitla2FFVG9jNUxTdFNEcys4YVdCSjlQS3o3TTlkWFNQc1pVbWRP?=
 =?utf-8?B?ZlA4ektmL0NyQkIveUpaVjJoWE1TNndBK1Brelc2N0g1SkRhR2RaaDJBaWRy?=
 =?utf-8?B?cE4rTzM2aDdOYW1mR01KeERDQzBpSmZ1a0RsWGZDWk9SNFFvQW4xWmkwek1u?=
 =?utf-8?B?M0h5Z1R0RzViMytROG92M1BDY0c1QUxVbGN5dmx3QjJuYnF2SXNkK2JDbllR?=
 =?utf-8?B?K0tnalV1cDBOVmg3TE9wcUJUUUFPL1E5d0ZlZlFFbFJkVW9NdFJ6Q21wMnNN?=
 =?utf-8?B?VDNzKzhncmVyZ09vSjBSaDRpMktqQWtkNHZXbGYvTWw4VE1MNmVKS0trbE9q?=
 =?utf-8?B?ZzFlOGhObitLY05Od3lmNVN1OTNCWUJLc3RNeUwyRE1ucXJmQmR5WG9DS043?=
 =?utf-8?B?Ulc3bE1DQjBSaXE2TnFtT0lUNko0MW1MZzcxY2cvNFdmTWlxMHNCcFMzZkwy?=
 =?utf-8?B?QzZPSzV3a3hET3hZNGlSNjRCdGlQc0ZvbVgwTURMTWVjY1BERVR3ZmJRRnVF?=
 =?utf-8?B?TitkNmw5YkI0OTZIMW9WUTZCekFGQUxZaHNmbkNoMnNRVmF4cnZpQVRzYzh6?=
 =?utf-8?B?cVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B120B3289580A04D93A26A4268BFE129@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ehVTIxCfKr/BVgUJ0LYUIMrW9+BDf0qjIB3ot+ogRltyw/5JOYlDbP8BN8AN8Z5pBy2PSkL3H54wRXSws3Ao/eyMm5PomnlBlRlQ/39uofdTTUzkK9SA4bIxQGRJGs/2nsS+vMXu2fsDkuLOUekxps7x2oqm49mXSmBWX6dBCSxHyLCs1qL5XQHW871jMr8SDSLUfR/w+UQVxgTjtog8h2Rjpw0TE74ZMmdKDvRaH0gZLJVOG8FxQXUGybgzoYTK0OWV6sxMsIT8ijb4B68Qu6bGuRAO0tek3r243KY8CD9V+Y4WFTS/HzJMeXoO1i6qJnctySWl0W+2hcoVw/1JZMx9Ut/8jPQIzj0k1XVvCcbDMHngSDAPIWQEevz0JV5RorLn790f55lFPecxzyCxv8jUsT1fmzuo8zqq+ELurbi4Qu5O7snq62C1gkurjGMdBSFMF04gyM5ZbuZ2wy8Gkaq4fSfI7rfSE1d5PGXZHICHzzHjoxOdRD9iw5Q3PoKQfe23jwkaPg2eB0nrXcbLeNjFDz8dU0I6TtU2duzvYPIJK7qQD9FTnxWZ+8HqwEgOyN8MV60OrxHcjPCpG5pSf33Xyz+Lq7FiYq66AqSbVgo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66985eeb-c594-4cd9-22c7-08dcea398991
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Oct 2024 21:13:22.1199
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: d/I8fS1B6LejbWvFfTt71QV6LKRKPTzCdbNnq/KS2tHc2pipBYd12xwymkqgzHF0VFbwEV3pPuB0GuNKv/FE+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7383
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-11_18,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 mlxscore=0
 malwarescore=0 bulkscore=0 mlxlogscore=999 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410110149
X-Proofpoint-ORIG-GUID: pjyh1CtgnZNad9s24f_zIzhG7M7VsuIk
X-Proofpoint-GUID: pjyh1CtgnZNad9s24f_zIzhG7M7VsuIk

DQoNCj4gT24gT2N0IDExLCAyMDI0LCBhdCA1OjA44oCvUE0sIE5laWxCcm93biA8bmVpbGJAc3Vz
ZS5kZT4gd3JvdGU6DQo+IA0KPiBPbiBTYXQsIDEyIE9jdCAyMDI0LCBDaHVjayBMZXZlciBJSUkg
d3JvdGU6DQo+PiANCj4+IA0KPj4+IE9uIE9jdCA5LCAyMDI0LCBhdCA0OjI24oCvUE0sIEplZmYg
TGF5dG9uIDxqbGF5dG9uQGtlcm5lbC5vcmc+IHdyb3RlOg0KPj4+IA0KPj4+IE9uIFdlZCwgMjAy
NC0wOS0wNCBhdCAxMDoyMyAtMDQwMCwgQ2h1Y2sgTGV2ZXIgd3JvdGU6DQo+Pj4+IE9uIE1vbiwg
U2VwIDAyLCAyMDI0IGF0IDExOjU3OjU1QU0gKzEwMDAsIE5laWxCcm93biB3cm90ZToNCj4+Pj4+
IE9uIFN1biwgMDEgU2VwIDIwMjQsIHN5emJvdCB3cm90ZToNCj4+Pj4+PiBzeXpib3QgaGFzIGZv
dW5kIGEgcmVwcm9kdWNlciBmb3IgdGhlIGZvbGxvd2luZyBpc3N1ZSBvbjoNCj4+Pj4+IA0KPj4+
Pj4gSSBoYWQgYSBwb2tlIGFyb3VuZCB1c2luZyB0aGUgcHJvdmlkZWQgZGlzayBpbWFnZSBhbmQg
a2VybmVsIGZvcg0KPj4+Pj4gZXhwbG9yaW5nLg0KPj4+Pj4gDQo+Pj4+PiBJIHRoaW5rIHRoZSBw
cm9ibGVtIGlzIGRlbW9uc3RyYXRlZCBieSB0aGlzIHN0YWNrIDoNCj4+Pj4+IA0KPj4+Pj4gWzww
Pl0gcnBjX3dhaXRfYml0X2tpbGxhYmxlKzB4MWIvMHgxNjANCj4+Pj4+IFs8MD5dIF9fcnBjX2V4
ZWN1dGUrMHg3MjMvMHgxNDYwDQo+Pj4+PiBbPDA+XSBycGNfZXhlY3V0ZSsweDFlYy8weDNmMA0K
Pj4+Pj4gWzwwPl0gcnBjX3J1bl90YXNrKzB4NTYyLzB4NmMwDQo+Pj4+PiBbPDA+XSBycGNfY2Fs
bF9zeW5jKzB4MTk3LzB4MmUwDQo+Pj4+PiBbPDA+XSBycGNiX3JlZ2lzdGVyKzB4MzZiLzB4Njcw
DQo+Pj4+PiBbPDA+XSBzdmNfdW5yZWdpc3RlcisweDIwOC8weDczMA0KPj4+Pj4gWzwwPl0gc3Zj
X2JpbmQrMHgxYmIvMHgxZTANCj4+Pj4+IFs8MD5dIG5mc2RfY3JlYXRlX3NlcnYrMHgzZjAvMHg3
NjANCj4+Pj4+IFs8MD5dIG5mc2RfbmxfbGlzdGVuZXJfc2V0X2RvaXQrMHgxMzUvMHgxYTkwDQo+
Pj4+PiBbPDA+XSBnZW5sX3Jjdl9tc2crMHhiMTYvMHhlYzANCj4+Pj4+IFs8MD5dIG5ldGxpbmtf
cmN2X3NrYisweDFlNS8weDQzMA0KPj4+Pj4gDQo+Pj4+PiBObyBycGNiaW5kIGlzIHJ1bm5pbmcg
b24gdGhpcyBob3N0IHNvIHRoYXQgInN2Y191bnJlZ2lzdGVyIiB0YWtlcyBhDQo+Pj4+PiBsb25n
IHRpbWUuICBNYXliZSBub3QgZm9yZXZlciBidXQgaWYgYSBmZXcgb2YgdGhlc2UgZ2V0IHF1ZXVl
ZCB1cCBhbGwNCj4+Pj4+IGJsb2NraW5nIHNvbWUgb3RoZXIgdGhyZWFkLCB0aGVuIG1heWJlIHRo
YXQgcHVzaGVkIGl0IG92ZXIgdGhlIGxpbWl0Lg0KPj4+Pj4gDQo+Pj4+PiBUaGUgZmFjdCB0aGF0
IHJwY2JpbmQgaXMgbm90IHJ1bm5pbmcgbWlnaHQgbm90IGJlIHJlbGV2YW50IGFzIHRoZSB0ZXN0
DQo+Pj4+PiBtZXNzZXMgdXAgdGhlIG5ldHdvcmsuICAicGluZyAxMjcuMC4wLjEiIHN0b3BzIHdv
cmtpbmcuDQo+Pj4+PiANCj4+Pj4+IFNvIHRoaXMgYnVnIGNvbWVzIGRvd24gdG8gIndlIHRyeSB0
byBjb250YWN0IHJwY2JpbmQgd2hpbGUgaG9sZGluZyBhDQo+Pj4+PiBtdXRleCBhbmQgaWYgdGhh
dCBnZXRzIG5vIHJlc3BvbnNlIGFuZCBubyBlcnJvciwgdGhlbiB3ZSBjYW4gaG9sZCB0aGUNCj4+
Pj4+IG11dGV4IGZvciBhIGxvbmcgdGltZSIuDQo+Pj4+PiANCj4+Pj4+IEFyZSB3ZSBzdXJwcmlz
ZWQ/IERvIHdlIHdhbnQgdG8gZml4IHRoaXM/ICBBbnkgc3VnZ2VzdGlvbnMgaG93Pw0KPj4+PiAN
Cj4+Pj4gSW4gdGhlIHBhc3QsIHdlJ3ZlIHRyaWVkIHRvIGFkZHJlc3MgImhhbmdpbmcgdXBjYWxs
IiBpc3N1ZXMgd2hlcmUNCj4+Pj4gdGhlIGtlcm5lbCBwYXJ0IG9mIGFuIGFkbWluaXN0cmF0aXZl
IGNvbW1hbmQgbmVlZHMgYSB1c2VyIHNwYWNlDQo+Pj4+IHNlcnZpY2UgdGhhdCBpc24ndCB3b3Jr
aW5nIG9yIHByZXNlbnQuIChlZyBtb3VudCBuZWVkaW5nIGEgcnVubmluZw0KPj4+PiBnc3NkKQ0K
Pj4+PiANCj4+Pj4gSWYgTkZTRCBpcyB1c2luZyB0aGUga2VybmVsIFJQQyBjbGllbnQgZm9yIHRo
ZSB1cGNhbGwsIHRoZW4gbWF5YmUNCj4+Pj4gYWRkaW5nIHRoZSBSUENfVEFTS19TT0ZUQ09OTiBm
bGFnIG1pZ2h0IHR1cm4gdGhlIGhhbmcgaW50byBhbg0KPj4+PiBpbW1lZGlhdGUgZmFpbHVyZS4N
Cj4+Pj4gDQo+Pj4+IElNTyB0aGlzIHNob3VsZCBiZSBhZGRyZXNzZWQuDQo+Pj4+IA0KPj4+PiAN
Cj4+PiANCj4+PiBJIHNlbnQgYSBwYXRjaCB0aGF0IGRvZXMgdGhlIGFib3ZlLCBidXQgbm93IEkn
bSB3b25kZXJpbmcgaWYgd2Ugb3VnaHQNCj4+PiB0byB0YWtlIGFub3RoZXIgYXBwcm9hY2guIFRo
ZSBsaXN0ZW5lciBhcnJheSBjYW4gYmUgcHJldHR5IGxvbmcuIFdoYXQNCj4+PiBpZiB3ZSBpbnN0
ZWFkIHdlcmUgdG8ganVzdCBkcm9wIGFuZCByZWFjcXVpcmUgdGhlIG11dGV4IGluIHRoZSBsb29w
IGF0DQo+Pj4gc3RyYXRlZ2ljIHBvaW50cz8gVGhlbiB3ZSB3b3VsZG4ndCBzcXVhdCBvbiB0aGUg
bXV0ZXggZm9yIHNvIGxvbmcuIA0KPj4+IA0KPj4+IFNvbWV0aGluZyBsaWtlIHRoaXMgbWF5YmU/
IEl0J3MgdWdseSBidXQgaXQgbWlnaHQgcHJldmVudCBodW5nIHRhc2sNCj4+PiB3YXJuaW5ncywg
YW5kIGxpc3RlbmVyIHNldHVwIGlzbid0IGEgZmFzdHBhdGggYW55d2F5Lg0KPj4+IA0KPj4+IA0K
Pj4+IGRpZmYgLS1naXQgYS9mcy9uZnNkL25mc2N0bC5jIGIvZnMvbmZzZC9uZnNjdGwuYw0KPj4+
IGluZGV4IDNhZGJjMDVlYmFhYy4uNWRlMDFmYjRjNTU3IDEwMDY0NA0KPj4+IC0tLSBhL2ZzL25m
c2QvbmZzY3RsLmMNCj4+PiArKysgYi9mcy9uZnNkL25mc2N0bC5jDQo+Pj4gQEAgLTIwNDIsNyAr
MjA0Miw5IEBAIGludCBuZnNkX25sX2xpc3RlbmVyX3NldF9kb2l0KHN0cnVjdCBza19idWZmICpz
a2IsIHN0cnVjdCBnZW5sX2luZm8gKmluZm8pDQo+Pj4gDQo+Pj4gICAgICAgICAgICAgICBzZXRf
Yml0KFhQVF9DTE9TRSwgJnhwcnQtPnhwdF9mbGFncyk7DQo+Pj4gICAgICAgICAgICAgICBzcGlu
X3VubG9ja19iaCgmc2Vydi0+c3ZfbG9jayk7DQo+Pj4gDQo+Pj4gICAgICAgICAgICAgICBzdmNf
eHBydF9jbG9zZSh4cHJ0KTsNCj4+PiArDQo+Pj4gKyAgICAgICAgICAgICAgIC8qIGVuc3VyZSB3
ZSBkb24ndCBzcXVhdCBvbiB0aGUgbXV0ZXggZm9yIHRvbyBsb25nICovDQo+Pj4gKyAgICAgICAg
ICAgICAgIG11dGV4X3VubG9jaygmbmZzZF9tdXRleCk7DQo+Pj4gKyAgICAgICAgICAgICAgIG11
dGV4X2xvY2soJm5mc2RfbXV0ZXgpOw0KPj4+ICAgICAgICAgICAgICAgc3Bpbl9sb2NrX2JoKCZz
ZXJ2LT5zdl9sb2NrKTsNCj4+PiAgICAgICB9DQo+Pj4gDQo+Pj4gQEAgLTIwODIsNiArMjA4NCwx
MCBAQCBpbnQgbmZzZF9ubF9saXN0ZW5lcl9zZXRfZG9pdChzdHJ1Y3Qgc2tfYnVmZiAqc2tiLCBz
dHJ1Y3QgZ2VubF9pbmZvICppbmZvKQ0KPj4+ICAgICAgICAgICAgICAgLyogYWx3YXlzIHNhdmUg
dGhlIGxhdGVzdCBlcnJvciAqLw0KPj4+ICAgICAgICAgICAgICAgaWYgKHJldCA8IDApDQo+Pj4g
ICAgICAgICAgICAgICAgICAgICAgIGVyciA9IHJldDsNCj4+PiArDQo+Pj4gKyAgICAgICAgICAg
ICAgIC8qIGVuc3VyZSB3ZSBkb24ndCBzcXVhdCBvbiB0aGUgbXV0ZXggZm9yIHRvbyBsb25nICov
DQo+Pj4gKyAgICAgICAgICAgICAgIG11dGV4X3VubG9jaygmbmZzZF9tdXRleCk7DQo+Pj4gKyAg
ICAgICAgICAgICAgIG11dGV4X2xvY2soJm5mc2RfbXV0ZXgpOw0KPj4+ICAgICAgIH0NCj4+PiAN
Cj4+PiAgICAgICBpZiAoIXNlcnYtPnN2X25ydGhyZWFkcyAmJiBsaXN0X2VtcHR5KCZubi0+bmZz
ZF9zZXJ2LT5zdl9wZXJtc29ja3MpKQ0KPj4gDQo+PiBJIGhhZCBhIGxvb2sgYXQgdGhlIHJwY2Ig
dXBjYWxsIGNvZGUgYSBjb3VwbGUgb2Ygd2Vla3MgYWdvLg0KPj4gSSdtIG5vdCBjb252aW5jZWQg
dGhhdCBzZXR0aW5nIFNPRlRDT05OIGluIGFsbCBjYXNlcyB3aWxsDQo+PiBoZWxwIGJ1dCB1bmZv
cnR1bmF0ZWx5IHRoZSByZWFzb25zIGZvciBteSBza2VwdGljaXNtIGhhdmUNCj4+IGFsbCBidXQg
bGVha2VkIG91dCBvZiBteSBoZWFkLg0KPj4gDQo+PiBSZWxlYXNpbmcgYW5kIHJlLWFjcXVpcmlu
ZyB0aGUgbXV0ZXggaXMgb2Z0ZW4gYSBzaWduIG9mDQo+PiBhIGRlZXBlciBwcm9ibGVtLiBJIHRo
aW5rIHlvdSdyZSBpbiB0aGUgcmlnaHQgdmljaW5pdHkNCj4+IGJ1dCBJJ2QgbGlrZSB0byBiZXR0
ZXIgdW5kZXJzdGFuZCB0aGUgYWN0dWFsIGNhdXNlIG9mDQo+PiB0aGUgZGVsYXkuIFRoZSBsaXN0
ZW5lciBsaXN0IHNob3VsZG4ndCBiZSBhbGwgdGhhdCBsb25nLA0KPj4gYnV0IG1heWJlIGl0IGhh
cyBhIHVuaW50ZW50aW9uYWwgbG9vcCBpbiBpdD8NCj4gDQo+IEkgdGhpbmsgaXQgaXMgd3Jvbmcg
dG8gcmVnaXN0ZXIgd2l0aCBycGNiaW5kIHdoaWxlIGhvbGRpbmcgYSBtdXRleC4NCj4gUmVnaXN0
ZXJpbmcgd2l0aCBycGNiaW5kIGRvZXNuJ3QgbmVlZCB0byBieSBzeW5jaHJvbm91cyBkb2VzIGl0
PyAgQ291bGQNCj4gd2UgcHVudCB0aGF0IHRvIGEgd29ya3F1ZXVlPw0KPiBEbyB3ZSBuZWVkIHRv
IGdldCBhIGZhaWx1cmUgc3RhdHVzIGJhY2sgc29tZWhvdz8/DQo+IHdhaXRfZm9yX2NvbXBsZXRp
b25fa2lsbGFibGUoKSBzb21ld2hlcmU/Pw0KDQpJIHRoaW5rIGtlcm5lbCBSUEMgc2VydmljZSBz
dGFydC11cCBuZWVkcyB0byBmYWlsIGltbWVkaWF0ZWx5DQppZiBycGNiaW5kIHJlZ2lzdHJhdGlv
biBkb2Vzbid0IHdvcmsuDQoNCg0KLS0NCkNodWNrIExldmVyDQoNCg0K

