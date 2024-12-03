Return-Path: <linux-nfs+bounces-8325-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB5A99E1F24
	for <lists+linux-nfs@lfdr.de>; Tue,  3 Dec 2024 15:29:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72AA1163F93
	for <lists+linux-nfs@lfdr.de>; Tue,  3 Dec 2024 14:29:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 381391F666E;
	Tue,  3 Dec 2024 14:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Husc04Ux";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="osb4mFSx"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55CE31F6662
	for <linux-nfs@vger.kernel.org>; Tue,  3 Dec 2024 14:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733236135; cv=fail; b=sA2pSaA5maiJxrTn/lqTxtgLewXaeCgf34pRImDq0mMDR9DuFEbVkchIHbufTpkOFUgVKJ8MCNCffqTDjTM6WLvA710dsOf5M2L6Afnu1JvUUG//qSSOHC3lzaHYWs7TuGLskFrgLruRciowBaHPmi91FTW84OT4rpln4Zb15S0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733236135; c=relaxed/simple;
	bh=4Cau1EmA/AldC/nVybyHUZcmMX5/nlt/LBZWXHMZvjA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mC0M4kk/IrqtfxSIkGUx8vAtp9G3t3wEO5ANEcgPVMOEb1gc1achuLM3/ighfCp1YVYQmrEEn+3JxGPJ1z/N/WpJ0u3HhGycsSImCXFq9rD4zzkS0B9gjaZ75q3j6ykN3c7J8Ux/wl7UfZ3EvRM1k4/jz4EiMKd7rKpNr1HCKGU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Husc04Ux; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=osb4mFSx; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B37Y4Ok003706;
	Tue, 3 Dec 2024 14:28:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=4Cau1EmA/AldC/nVybyHUZcmMX5/nlt/LBZWXHMZvjA=; b=
	Husc04UxjkCxsa7S2x0LeUFXn9OJjumiDb7qPuFiuFYCpjFE3BhTBeYEA/18q0cf
	WvrIpTYw1TQ+yDBUNLcqHlQaEymb/pGGFwE+ByS0Lz0p2/+usvIlY16jrNQkrVUJ
	gVL/6PrDW8Mo3RyE6GwppHe4Pcm7s6yq1zyfXeJcPNHd/MrA53pHaZ4lfyxbmQ63
	yOGkTaNzW2WvOYTAtAVyo5DpaWcmpu/o8OyLY/AUxb/89EwnPVfan/wC/Y5Hxd+z
	qCBqaWLPEfH/yxlAdnElfgMt+Xn8HjY6L78+/pGKHifb7vW8HQNBWMyAdI+MQIRa
	dAIWyhUzAmH8rWCcK7nSEg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 437tas646m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 03 Dec 2024 14:28:50 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4B3DrKw6001198;
	Tue, 3 Dec 2024 14:28:50 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 437s57yjdp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 03 Dec 2024 14:28:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tHCBXG12mLlM7vYn/Y3YYA4OuVQqE+Vv4o/xqRrJeW5p8RCJ7lL/Db2nPxxyiLGghCGrQVYX/m2azKXpJc2GCmQhXpK5Zy1mjZksCO2eOwkd/Ci0EKdradNaMEU4qu7ERjhO2xRw9kUXFeyHf76/80DPCP/0Tr4VUu40+N2vkCJBiGnC03H1p2ABoklYpAO2E0TNfNo0LlVXHRMkuKBRHKsqZPo7e9Pp6OR7XLGoRhyYsgcs9ux0YF1oZ45gj/EDoVw0a0qzWVSph8Xw8gD21Foc2H7Fl2CFcX0fthHh+7wUNDnlvPPhEdKYxzVtZZsLT3oYx5ai2YfMc2b4m+Y/VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4Cau1EmA/AldC/nVybyHUZcmMX5/nlt/LBZWXHMZvjA=;
 b=u9X77uSkUltwTrGxhzNvHCwAXb2fMkwR73M0AgxIA+QGzGo77k3BVdKejzZWIu05x5a5szqJI/wxOC8NIv7Nn0ivrcyzEX8kUbThg6T982gx7xPeuhtJWTk1Q8b5VQAJkLOC4GGoyFcLDEFqW9GL2M8ln/aHWkC2pklZkIF/ULw/eEFqVWRuEZ0MrGqI1uaQ0+Va4RftDhZ3XJJQB71zr5MM8O7ZodH/sy+PJJA+SknJMj67wkQq2ExBZzNJOK3rHLhhQpv2s3jZARdKG/8E3STlC+eyJzPdYrkV9+wQot+Z6VeNwDor1gt4hUpu+krYT6gfVBm4JWI5H+udUrdnqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Cau1EmA/AldC/nVybyHUZcmMX5/nlt/LBZWXHMZvjA=;
 b=osb4mFSxFlOEyp7K/eGytIoa+yytlV4eRb108RhvNMGbdBPq7X+yIrk9ccx7gr0yomMVGWOtyhJI+Yl03XcoI36NsCGDxrCitNJhYhIYZrgidZGTspi/UmCIFhfseKTtDxmSF5GDxh0qvd1MOZcOIO0KXEp6UuV2J9h8v9jmH1k=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH7PR10MB6226.namprd10.prod.outlook.com (2603:10b6:510:1f1::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Tue, 3 Dec
 2024 14:28:47 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%7]) with mapi id 15.20.8207.017; Tue, 3 Dec 2024
 14:28:47 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Steve Dickson <SteveD@redhat.com>
CC: Scott Mayhew <smayhew@redhat.com>,
        Linux NFS Mailing List
	<linux-nfs@vger.kernel.org>
Subject: Re: [nfs-utils PATCH] exports: Fix referrals when
 --enable-junction=no
Thread-Topic: [nfs-utils PATCH] exports: Fix referrals when
 --enable-junction=no
Thread-Index: AQHbRQEiw86raxJWZUWDjDc1ottT+LLT2liAgAC67AA=
Date: Tue, 3 Dec 2024 14:28:47 +0000
Message-ID: <A47A9D21-EF59-4263-AC63-059FB0661CA8@oracle.com>
References: <328fdce3-a66b-4254-a178-389caf75a685@redhat.com>
 <20241202203046.1436990-1-smayhew@redhat.com>
 <6b8990cc-ec29-4e01-acd6-8c7ec6487d99@redhat.com>
In-Reply-To: <6b8990cc-ec29-4e01-acd6-8c7ec6487d99@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3776.700.51.11.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|PH7PR10MB6226:EE_
x-ms-office365-filtering-correlation-id: 17ce038f-274c-49ae-25dd-08dd13a6ccc4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?L0x5a3dYSkhtYUxQdTJKN2hUQlljV1I3RzBRaURzaUlSbkxiaWpna3Yxamdv?=
 =?utf-8?B?d1d1SjRXNUN5a1lCaytsZ0k1TTJ1QmlhaElhNGlCYmVCZFNSU3BZTkN2aHlG?=
 =?utf-8?B?WjdHdzdVQ0RzNWd6UFdEZ1ZObk9YOHFJNEdYcm5yelV4Q2hKQ2VKSVhsajJp?=
 =?utf-8?B?cGlCcWlMWTJEM295UlBQWCtibW41UTdlYXlqTWRJd3FwaHAvRmdDZlV1TmZN?=
 =?utf-8?B?aUVoMWJuUUp1K3NkZldxZ2J2UjhWOHQyYUVTVTVFUW1FTWhIa2RmR0JCQzRx?=
 =?utf-8?B?V3VIS0VqSkhlRVZPandiNDEyZGp0U3QwTjJDdU5NQjJab2xsODN0Y2VqL1F4?=
 =?utf-8?B?S3pWQVVLRGdxV1FHM2tvNEpkTGRuTEFGSldoanJBMmRzQzdMN3FRYkY3bjYx?=
 =?utf-8?B?eFVDeXZTM3owaXdPUlBFNzVYdm5CdXAwelpaN0M4NUl6Q3pKSmdiODRMYzVi?=
 =?utf-8?B?Z0FJbVl6SUtCV2kyWWI5djJjbEw4TFU5MXJjNmd2YkNWYks4ZERYSzc5anh2?=
 =?utf-8?B?UGFNRnRXVjc5TXRRN0pVV3p5SFJYUzV5UWVZYlc0Y2JYTmZxS0pRMTNLd2JQ?=
 =?utf-8?B?WmtERzBXSnlNbUdqaUhnS1RERm9UdElqczU3TjI5RzJTbEViNDhjby9NRFp4?=
 =?utf-8?B?bFU0UWNGWUVueXhvNDM1NXBiRXBXTEFJREpKNmkwVWhwdUZkMFNTRlZ3TjVR?=
 =?utf-8?B?M3NtK3dCdWE3dmorQ0VWNldGbmdWQjBleWJQeHJSTnZmdWpSZFlNU3FwLzFW?=
 =?utf-8?B?N1U5dm40ZldBQnpaZmp6bDlqcEx4VXB2c29SSjVmZmdFQVdTeE5sZ3FBTjhD?=
 =?utf-8?B?WnFFT3NWalB1bFJyWnNaMjk4MUlwNFdYcGpCRzlvYUlWVXNFN2dpTXRRRzlN?=
 =?utf-8?B?WXkra2x6ZkpOaFZJUXdDcE00T0VCQkJPbUpqTitrZnlzdkFoeFYxYjFrc3FU?=
 =?utf-8?B?R2NlckE0ZHFzT25LVWs2czMyc1pHNTBEd3ZDREhZdnlhSkhPcGxzM2lIb3dP?=
 =?utf-8?B?cUUvQmZSbWdLVWxHd2JlTnM3bjZJdWRPUEJiQktTbTJmL2l4QXptNGdSWjJD?=
 =?utf-8?B?dWtEK09JSVV5LzM2TnhRWDBZWE8vL0o2c1BoT2VWakFRUDlqY0tSdXlCaGwz?=
 =?utf-8?B?MjlVbFQxc3NiWUgwYmkzcXA2TjEybWxLRlpydDA0WC9uanZDUkNnQmtMaEFh?=
 =?utf-8?B?bTZXOVoyaEdQb3Rwc1BlUkFweWhDVUhEckhJditHTXNwVEZDUDJLMWE3TVNG?=
 =?utf-8?B?Vk1oSHJMZlovYkp6VDZJdjlOYXRnRUV4SUFlY0M5NGhpMmlXa2h2NE4ydlNq?=
 =?utf-8?B?ZGtYNWN3dEhReUd2T3lldk1tZHRXaFVOek0yeG1RM2hQemVKck0vRWV2UmFR?=
 =?utf-8?B?emplb09WbFNWL1ZXYVdQelh5bGU0SUs2Z3ljZW9aVDJmUURmbWI2cDBaWVVx?=
 =?utf-8?B?WEV3dEo0TE1UMUgyVHNmU1p3UTdNK2VIOGtBcGJDbjlYWXNJTGlVWkNHZm5C?=
 =?utf-8?B?ZnZLMklpL0dpNTJOclhCSmtybStKVjVEbTZTaTRpbGJpM0RHVGlyZ3k3SGFa?=
 =?utf-8?B?cWdFaURuVkhqcU5tVWtFZmtZVGVTYko1KzFwb3hEY1JVUERyWGdZdTl1S0VE?=
 =?utf-8?B?aC84cEZ4ZS9tUnBBdnVmL3dDMDkwVFBKb3V6dU51U0pVNjFsdVRnQUNySzJj?=
 =?utf-8?B?NCtOQ1kyOHZmWWlLOGNqd0RXVnZrUHU3cmdpTDBFVEVNbWNFbUxSSHNKQ3BG?=
 =?utf-8?B?Rldtb3ZkUkw5OWt2RXRtcmNrRmhxSzdLNW1UU2djblRrcVZoeS9xU0pKUFdR?=
 =?utf-8?B?cjVCNjJtNDI0Q3JiUWV5enZjb1o0WUhnZ001NFpvanJNR1hYdVdoTitYK0lh?=
 =?utf-8?B?UlpGSW9YcFUreVRLeWp3V09tSFFyYXdtM0s4ekkxYW1TOXc9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?b3BmMFh4amFRT1JRY3RKUWEzMlpQRUQxM2hvQkxRSTNmWklqTUFCbTlCZmxB?=
 =?utf-8?B?Tm9WTnJyVFM0V2ZSdGtoTExXeENrbjRqV2ZpL291U3I0MURVc0VpVlVOUk52?=
 =?utf-8?B?V052WWRoQlVBSGlLaHR0WHFiaDBJOTZSczEzTXMxdTRDRkg3WmtJTXpmd1Nj?=
 =?utf-8?B?M1g2MlkvUXFGaXVnTTFoRHFpT2VzS0orNkFkYlV5WHJMY1pzZW5HZ3RGVVFt?=
 =?utf-8?B?YlRiZm91eGpBRXF5V3dDUjZ0OU1ycElmS2lqRVdoaGNiQlpCL0xNM1VUY3BN?=
 =?utf-8?B?elErYll4bHhwZUkxTEd0WVl1WTFneEpEQTRMdVhvekNpRTZHOHdoNjBFUFc0?=
 =?utf-8?B?SFJxQTRqcmdUT01tNXArRmRPd2d6RWVGNWQ3cGpkQUlLUkJmSFFzeGR4R25n?=
 =?utf-8?B?aDRVeFJ2cEp5U2cwaUhWbW40NDRXUDFHUW1hZ0FGeXFCbUZWcW5admRPSWNw?=
 =?utf-8?B?U2tITUxWWDBuM2ozQ1U2NThFZ2dVSkE2T1c2QTBuM2ZVREJ2U1RGeXJuTmsv?=
 =?utf-8?B?WXlEUGdaR2ExNDV4d1p0SjdmUXJiMXk3bThaTFdqMWZrNC9qNWRNeWxDREFX?=
 =?utf-8?B?Qmg2UnI2ZWxQV2puaC9pTXBaSHRYVXRITzJYNXFZR0c0SXhoNGJMRkEwQmJE?=
 =?utf-8?B?enBSWmdGZWhTVDFCUlA5UnNteERBQ25OakJRU1dMa1Z0L1Y4YUZWSldSY1dY?=
 =?utf-8?B?dExPRVMzS1VTdWdsb1FrNlZMTjJWNmVrMmJXTUNHYTI4SG5Dd1dUd295VVMr?=
 =?utf-8?B?NWE4MzBxbEVsVTZ3eE5DM1dPV2h4R3p1cGk2YjQyRUNyWERpRzN6WHBGejZo?=
 =?utf-8?B?U25oV1ZTTEF0ai9IVDFtZG1mdm8vMzdQQTB3NVJVMlhTeWRKdThLcHhhTmhG?=
 =?utf-8?B?Tm9HRFp2N0ZVbW1iRG93UFQwdmFyY2hHWmJXeHZvNmdpbU4wbDVnQUl6RHRP?=
 =?utf-8?B?c25Ib3VYdXp0WHAycm9ZMlU3Vk1vUys2ZlpMRERMb1IyQ1V6RGJFV09rVERo?=
 =?utf-8?B?WGNHYXFVbE1uVXBlbjVxdG9jdWY2Q1ZmUHI1VHdyNWtSUzBIUGp5VklhMXBW?=
 =?utf-8?B?OU42cFU0U3AwQnR6MXdRNHBUdnhuTGwrWS9CYTFYQ1RqZi9FWjdQeSs4b3l6?=
 =?utf-8?B?aEk1NHpEZHBCMU1RYmNyd1R4K0F2ckFuUG45OEN6NEErT2NJNUJraXUyRnNx?=
 =?utf-8?B?QndibzdubktJN0lnb0RmK2szbmR2bmNoZVRiVlFyc0ErYWFvT2VyQk1ycVlu?=
 =?utf-8?B?WFZRU2tVVEFBSldQVVFrZHlqcnVPbHNUdnFIaWlwZHNZSEZyT3o2Q0thNVJV?=
 =?utf-8?B?OFBkZWVqRkxsTWtrTnB5bEV6eTJUM01lclgySjYwcW1scWZsR0hIMk5FSmdx?=
 =?utf-8?B?b3RYTFBWYjZYVzJyZmZBTlI4M0JVUU8wUGl1K00zeE0wWUJqenVpRXJjMDVj?=
 =?utf-8?B?R09rNnFZZEloZ2FEaDh5ZGRQeVZ2eDZnUjV4Z3lRRVVaNXNScGI5S2hLa1Jk?=
 =?utf-8?B?TEJ0SnBFMVYzTEsvZUFDT05tR0lneW9KelAwN3VZZlRMQzJ1SlZqWXpYS2ZV?=
 =?utf-8?B?QjNEMXUzY1FBTlY2NWpPUjFkQXdCNVZQdGw4L1E4NHlCVXFPS21sSmgrdFFJ?=
 =?utf-8?B?UFpjZkhuTmc0Q2ZNOW9aU2xYNEEvWW1jZVVlczdqUHdWcDc1ZTRhVEl2djc5?=
 =?utf-8?B?U1hVbURZNy81RkllMkx1Wm9UbU5WQm51d0RlTFk1ZXkxajBhWlBzMnZSWThM?=
 =?utf-8?B?UW5MYjJGMnFBR0pUdXBlQWJRZ1B5OFJiNlAxdTR6UEsrTVo4bWp4SGF1Rlpr?=
 =?utf-8?B?VFF4eFNHM1NoTTh1S2RBTUxCVU1Ja2JWUGQzSnVMZU85V0pBa1pxdldVODlz?=
 =?utf-8?B?eDVEa282clZYUU1PNXcwSCsrQTVlakVsWHFHS3N3Y1l1ZXZaeEtON3ZwbU81?=
 =?utf-8?B?OTVGUXgwL2JqZE4rNktxaWpGU0xQL2k4VUQwU3JES3l6bUVuL045aXREWWl3?=
 =?utf-8?B?QkdIYk0zK3pyd3NtNFhxK0hFeWJFYjFmMXJWUm9sUXExQitseDFJdUJ1Qjgw?=
 =?utf-8?B?UHgzQnEzZ0dqWitRWjYrWDM5WjM4b3FMeW8wTlMzOEwyZ0NVb1VyOFpRWUhL?=
 =?utf-8?B?Tnk2V3Y2NFE3T0FZTGxlZWZscWdVekFrRmVoS0t0Y2VoajhjbXQzTWJJOVhD?=
 =?utf-8?B?NlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DB46913146A4464E87D23F113102846F@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	95XjjerIhWQYS/SlxN9GIEfphubUqTKoS1+CgIV8d2WNffaqsUrhSQCJ9xgxRtIh87/YDoBtJkq6fAO9GODWCxkKfKVgyqfsqKzzg3mEjyOezI5mp4nO037gBSJw0qOd59Bz3FFPKOABaporaDUYL7+bS/bhIlRSy+DVBf/F2KpYRRtZRWef6uBnMOqrB1IxP2PdkYny9HZuKFqZD2/tw26TGwswXFbuJ0YMCiexV0DRiMJ5Deoy8JhkZDqnAhVsA2ocfv5rQHen5TYdhyzfh9um5hAHpWD8vyhVqad4sW6PVuyU9L/w3yCaF53QJ3W7OQHG2mzZimKEieaJ28Utl85naRFIlj4gqf2kzpJn1HiEhihDsm/9fzwckHepZclubTNbzR2z8ZHq6HAERiDtmxP54GltBZ5GRNGqKUVjUZiyeF5uCLAPTs9AjnqEc6c5dkI6iX+ufAr0+xpDCZy1HIu8OXchp95G7UPHZjuI3ZfonCa2Ov1Tz/My8AIEKIRHkRuhPnah/9J4f0uJPVO8u2T623NWvh5lKph+NgANflcV6clPgfrrMcGbAbJbocuuKNT89vHOFnT5RZChtiPIA966sINl2TA7dofx6f+VTVo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17ce038f-274c-49ae-25dd-08dd13a6ccc4
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2024 14:28:47.7078
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iBHMdepq7etpxfZIlZwEXaM4qQZrgOsluxTEE/olPo0nzwbG5kL/ojdq31Nhiky8CKSO9MMZFEzpj/zG2qNZpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6226
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-03_04,2024-12-03_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999
 adultscore=0 mlxscore=0 spamscore=0 suspectscore=0 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2411120000 definitions=main-2412030123
X-Proofpoint-GUID: 7lnNI-fFGp4Ss0VinOoTRqzkv51FNw98
X-Proofpoint-ORIG-GUID: 7lnNI-fFGp4Ss0VinOoTRqzkv51FNw98

DQoNCj4gT24gRGVjIDIsIDIwMjQsIGF0IDEwOjE54oCvUE0sIFN0ZXZlIERpY2tzb24gPFN0ZXZl
REByZWRoYXQuY29tPiB3cm90ZToNCj4gDQo+IEhleSwNCj4gDQo+IE9uIDEyLzIvMjQgMzozMCBQ
TSwgU2NvdHQgTWF5aGV3IHdyb3RlOg0KPj4gQ29tbWl0IDE1ZGMwYmVhICgiZXhwb3J0ZDogTW92
ZWQgY2FjaGUgdXBjYWxscyByb3V0aW5lcyBpbnRvDQo+PiBsaWJleHBvcnQuYSIpIGNhdXNlZCB3
cml0ZV9mc2xvYygpIHRvIGJlIGVsaWRlZCB3aGVuIGp1bmN0aW9uIHN1cHBvcnQgaXMNCj4+IGRp
c2FibGVkLiAgR2V0IHJpZCBvZiB0aGUgYm9ndXMgI2lmZGVmIEhBVkVfSlVOQ1RJT05fU1VQUE9S
VCBibG9ja3Mgc28NCj4+IHRoYXQgcmVmZXJyYWxzIHdvcmsgYWdhaW4gKHRoZSBvbmx5ICNpZmRl
ZiBIQVZFX0pVTkNUSU9OX1NVUFBPUlQgc2hvdWxkDQo+PiBiZSBhcm91bmQgYWN0dWFsIGp1bmN0
aW9uIGNvZGUpLg0KPiBXaHkgbm90IGp1c3QgdGFrZSB0aGUgZW5hYmxlX2p1bmN0aW9uIGNvbmZp
ZyB2YXJpYWJsZQ0KPiBvdXQgb2YgY29uZmlndXJlLmFjIGFzIHdlbGw/DQoNCkl0J3Mgbm90IGdl
bmVyYWxseSBnb29kIHByYWN0aWNlLCBidXQgSSB3aWxsIGJyZWFrIHVwIHlvdXINCnNlbnRlbmNl
IGJlbG93IHRvIHJlcGx5IHRvIGVhY2ggYml0LiBUaGVyZSBpcyBzb21ldGhpbmcgdG8NCnVucGFj
ayBpbiBlYWNoIHBhcnQuDQoNCg0KPiBJZiB3ZSB3YW50IGp1bmN0aW9ucy9yZWZlcnJhbHMgKHdo
aWNoIGFyZSB0aGUgc2FtZSkNCj4gSU1ITy4uLg0KDQpKdW5jdGlvbnMgYW5kIHJlZmVyPSBhcmUg
cmVsYXRlZCwgYnV0IHRoZXkgYXJlbid0DQp0aGUgc2FtZS4gQXMgU2NvdHQgZGVtb25zdHJhdGVk
LCBhIGp1bmN0aW9uIGlzIGEgZmlsZQ0Kc3lzdGVtIG9iamVjdCB0aGF0IHN0b3JlcyBORlN2NCBy
ZWZlcnJhbCBpbmZvcm1hdGlvbi4NClRoZSAicmVmZXI9IiBleHBvcnQgb3B0aW9uIHN0b3JlcyB0
aGF0IGluZm9ybWF0aW9uIGluDQovZXRjL2V4cG9ydHMuDQoNClRoZSBjb21tb24gcGFydCBvZiB0
aGVzZSB0d28gbWVjaGFuaXNtcyByZXNpZGVzIGluDQpORlNELCB3aGljaCB0dXJucyB0aGF0IGlu
Zm9ybWF0aW9uIGludG8gdGhlIHJlc3BvbnNlDQp0byBhIEdFVEFUVFIoZnNfbG9jYXRpb25zKS4N
Cg0KDQo+IG9uIGFsbCB0aGUgdGltZS4uLg0KDQpXZSB3YW50ICJyZWZlcj0iIG9uIGFsbCB0aGUg
dGltZSwgeWVzLg0KDQpKdW5jdGlvbiBzdXBwb3J0IGhhcyB0byBiZSBlbmFibGVkIG1hbnVhbGx5
LiBUaGlzIGlzDQpiZWNhdXNlIGl0IGRlcGVuZHMgb24gbGlieG1sMiwgd2hpY2ggbm90IGV2ZXJ5
IGRpc3Rybw0Kd2FudHMgdG8sIG9yIGNhbiwgcHVsbCBpbnRvIGl0cyBuZnMtdXRpbHMgcGFja2Fn
ZS4NCg0KVGhhdCBpcyBpbiBmYWN0IGV4YWN0bHkgaG93IFNhbHZhdG9yZSBpcyB1c2luZyB0aGlz
DQpvcHRpb24uIFRoZSBzdGFibGUgdmVyc2lvbiBvZiBEZWJpYW4ncyBuZnMtdXRpbHMNCnBhY2th
Z2UgZG9lcyBub3Qgd2FudCBsaWJ4bWwyLCBzbyBqdW5jdGlvbiBzdXBwb3J0IGlzDQpkaXNhYmxl
ZCB0aGVyZS4gQnV0IHRoZXkgL2RvLyB3YW50ICJyZWZlcj0iIHN1cHBvcnQuDQoNCg0KPiBMZXRz
IG5vdCBiZSBhYmxlIHRvIHR1cm4gdGhlbSBvZmYgYXQgYWxsPw0KDQpUaGF0IHdvdWxkIGJlIG5p
Y2UsIGJ1dCBpdCdzIG5vdCB5ZXQgcHJhY3RpY2FsIGZvcg0KZXZlcnkgZGlzdHJvIHRvIGVuYWJs
ZSBpdC4NCg0KSSBhbSB0b2xkIHRoYXQgRGViaWFuIHVuc3RhYmxlJ3MgbmZzLXV0aWxzIHdpbGwN
CmVuYWJsZSBqdW5jdGlvbiBzdXBwb3J0LCBhbmQgaGFzIGFkZGVkIHRoZSBsaWJ4bWwyDQpkZXBl
bmRlbmN5IHN1Y2Nlc3NmdWxseS4NCg0KV2Ugd2lsbCBnZXQgdGhlcmUgZXZlbnR1YWxseS4NCg0K
DQo+IFBvaW50IGJlaW5nLi4uIGlmIHdlIGFyZSBnb2luZyByZW1vdmUgMyBvZiB0aGUgNA0KPiBI
QVZFX0pVTkNUSU9OX1NVUFBPUlQgaWZkZWZzLi4uIGxldCBnZXQgcmlkZSBvZg0KPiBhbGwgb2Yg
dGhlbS4NCg0KDQotLQ0KQ2h1Y2sgTGV2ZXINCg0KDQo=

