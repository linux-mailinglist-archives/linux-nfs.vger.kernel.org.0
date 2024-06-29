Return-Path: <linux-nfs+bounces-4411-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 619F591CF06
	for <lists+linux-nfs@lfdr.de>; Sat, 29 Jun 2024 22:32:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10BAA282625
	for <lists+linux-nfs@lfdr.de>; Sat, 29 Jun 2024 20:32:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15AF8374FA;
	Sat, 29 Jun 2024 20:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="CubQMbIK";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="wfLGfvqQ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97D6E1CFA9
	for <linux-nfs@vger.kernel.org>; Sat, 29 Jun 2024 20:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719693119; cv=fail; b=E6up/RNDRFJcjJM5RptGJ3hIoF3re2FABRJGk2U2CY7pHDyJaggeOKZ5PMzhvs7ly/ekMCya4iXmKecNwy+awgkQZHoErTwBeLXGpV06mi/Exk1ksNfluCF3fyovva3yKbGbn/8uts4tK4uybPXZDwaH+66EsR2543HX4y3evsI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719693119; c=relaxed/simple;
	bh=mD1Jv1FpA3Nw+yODEnnmZ3z15bH+7J2X0SZVUAQkZmk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FdQlk5Uk6mxofJdvMEufFF5/vLwKSIMnJT68kamLJ+sCPokb30W/T6B7F3PqT/mSUHngre3pr9ndeNwDIPfb9Wp28R7Vpt3omKHeARbWwuOPvBIIlVAHWdOk7N3agak0UOeyIe8jrCnzmgg7BRCZUD1KqH8yZ+npeCAJQ0sBI3U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=CubQMbIK; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=wfLGfvqQ; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45TJt1Sp020665;
	Sat, 29 Jun 2024 20:31:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-id:content-transfer-encoding:mime-version;
	 s=corp-2023-11-20; bh=mD1Jv1FpA3Nw+yODEnnmZ3z15bH+7J2X0SZVUAQkZ
	mk=; b=CubQMbIKBMut93sACEG0yUx2BYpPLVY77HKgJdly4L9jk8seqShm6PYb1
	GN+omPuUJiuh7gkOGO3P4KM6P/kTVDA37iBpSQKn7glDkN+aLw5gHeEUh5EFNYIW
	8sJ42gD+Ic3cearGf88Zu7Of8yw1tGGL9NPiarvEigBgAJzX2E4Tbn3wDs4xJlxo
	Gm8TznDgqiXw8c2a88hCLrm7vy2EcU3U7gmdoEshWQu5LFrmLPDe38zuxnUz1c2C
	AtaaKUrq39VkpfMjJnMoM+TFR2mF7jkp9yVFxriNtk1sDv35IH2EJOmUlbpPwo2R
	8j2AHUCvnSBSwDW0T8XAc1Dr2zCvg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 402att8kpq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 29 Jun 2024 20:31:47 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45TGn1Dg022912;
	Sat, 29 Jun 2024 20:31:46 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4028q4ybvp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 29 Jun 2024 20:31:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZF7ZHj9lGM/o/96UP92L4swbrso3b/pjekYwnh8/9D+1yjTRt18M0YkUIkeaA8SSfe3arVEZBZA+5pjOI7x5v/pRcPX5E5+wp+AYtVELLPBQI/aoZqSgxKwFJRGRh+0gZNNdgvSV5hfyzetYTqO2zf10AbObLIkGxpIPU99UeiLiN2JU2SZx54N+BPvE3rhObBjc9W5XoxtZkHfAmiIVRybydcaf1fZnE+Ur4Mveh/2iMq4jRPh8cgHYfX/7Q5PZMxt05qGBiJUwB6fBxrsxEqT6uDU+9Mr5ABr7hi+w1l9mkYNIZQZKtW+5ktK3uHiAgHM0VXosDX7XhqvJflIT0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mD1Jv1FpA3Nw+yODEnnmZ3z15bH+7J2X0SZVUAQkZmk=;
 b=UOeQK7KmGAikU86FN7e2pess68G1PEPeAiiuo2bMTj2pCeWitiuAYFlx1pQtLYjKn/vkH06z41+kiA7By2II0UJ8Ijh9M1Lf+D6wcUO/yykJ/lTw8izka73RlftBQGDxCGucl+KpjEXIE3NQI2CF4EoFNMOGyhZek4mNznwOVj99G2FyMZ+p1mxoASpGJ42xQ7sGWZdPTg2dw+lJ27C7mLifXdevDAWXojADmakv5tz6oIZx8A8+51A+Vr5fjhPXRFBvda8OM1UJI3ni3KBe1pGMmUAmdyApOUFN6W78ZTLDooyx2ZmIk9NjTOOcLEyL2PWxxwua0Qw3W8s8mu/Fcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mD1Jv1FpA3Nw+yODEnnmZ3z15bH+7J2X0SZVUAQkZmk=;
 b=wfLGfvqQK++XVn/fhc3pc8CuamaRHMffHgBlz1N0GQKMNjKO++IuByGeumqiPGpaZS74Ta+/GYsDRP+GDLZ+jxzV4yirBtfkc4GgxIlakU3HIOXxT9oxKGdzd0ecYpvagezofOaeQMYbFomLuMX+ppVGBzmmiUL0n0cSFSMk620=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CO6PR10MB5586.namprd10.prod.outlook.com (2603:10b6:303:145::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.29; Sat, 29 Jun
 2024 20:31:43 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%5]) with mapi id 15.20.7719.028; Sat, 29 Jun 2024
 20:31:43 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Mike Snitzer <snitzer@kernel.org>, Anna Schumaker <anna@kernel.org>
CC: Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Jeff Layton
	<jlayton@kernel.org>,
        Trond Myklebust <trondmy@hammerspace.com>, Neil Brown
	<neilb@suse.de>,
        "snitzer@hammerspace.com" <snitzer@hammerspace.com>
Subject: Re: [PATCH v9 00/19] nfs/nfsd: add support for localio
Thread-Topic: [PATCH v9 00/19] nfs/nfsd: add support for localio
Thread-Index: AQHayZ/N552rtzwru0Ghtm/oU3ZYQrHe4NgAgAAHxACAABA9gIAAI96AgAAWsQA=
Date: Sat, 29 Jun 2024 20:31:43 +0000
Message-ID: <A347A6C8-02E8-428B-A2E8-A687B9A8F85B@oracle.com>
References: <20240628211105.54736-1-snitzer@kernel.org>
 <577D0632-FABE-4D16-93B9-4701C051B418@oracle.com>
 <ZoAwZnuaPLSSIfon@kernel.org> <ZoA+Bas+GV8lmRU7@tissot.1015granger.net>
 <ZoBcGxAsPuguaR7q@kernel.org>
In-Reply-To: <ZoBcGxAsPuguaR7q@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.600.62)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|CO6PR10MB5586:EE_
x-ms-office365-filtering-correlation-id: 874ae48f-cf0b-4f78-aaeb-08dc987a7d0f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: 
 =?utf-8?B?Zm5FSlVENHZ0WGN0b3V0dUZjZlIzWTFPT21BVnpLM0ZqdXIvVG9WbnBsdXhJ?=
 =?utf-8?B?MkdKYzhlSmE4UDRuNmJ0UElLVEUyT1VPUk1ONUpKSm1zOFNReGplNEtXY1kx?=
 =?utf-8?B?dFhEZDJ0WDUzTXE0Z1hjU2xYWk1VRmpVeUV4K2hSd01IZVpERUZEMWF5YWEz?=
 =?utf-8?B?UW1jaGZraDJXRTFEU3g1V0s3ZVA3MGR5U0RRcEloUkdaNWdLZU1hT3NBdXE4?=
 =?utf-8?B?SXR4TjdKTk5tUW1xaGlGNTV0YncrdGpXSWFoL0ZFZWhDeWl6VzhhRzM5dmNz?=
 =?utf-8?B?RXVIeHFicTZReFNnZTlmRUtEZUo1YU1BcGJJcUZmM1FoYXljRmNiSVlWdFVU?=
 =?utf-8?B?ZVpSOVo5ZFJIN3NjSWlaRWJic3ZLNExlM0pjUy9lMVlCdUFZYmlYU3JMVlpp?=
 =?utf-8?B?cmZVVEhYdTl5YloxRVBPV0s4MGNtRm40SmRDSFlhWk9pZUpjU1ZqYWU5MzRM?=
 =?utf-8?B?TVZ5YXByNGJVeDc3NVRNMGxmU1ErT3ZoYlZOS1I1T2lJaVNndWxtQ01ldUdN?=
 =?utf-8?B?L3drU0RMVDAzcHE4RHJhZFcxYzR0b0Qvb2RETExodDg2NWZCN0lsWnF6cmpU?=
 =?utf-8?B?eWlVKzVOSXlMY2puRllLWGZZSHA4aDJrelVsRTV5NEwrbFYxZjNBc2ZNcjk3?=
 =?utf-8?B?aDg0MDlKVDhIV0tkbUlqOCs2TnBDNmpFTHpRK3d6dzlYSlZDZVYyQkR3MEp5?=
 =?utf-8?B?L0dVUnk3d2RUN1EvY1NUcVlJL2s0YWFldjBDN0diL0NmRHBNZmtkbmxPdGJN?=
 =?utf-8?B?RDY5dkNrRlpJRlgyRHNuakNPM2htWVBlVU1XTlhFUEp3L2ZvOThFcnpDbUkx?=
 =?utf-8?B?NERiNWFlYzBNZ1VCMTdGNVQvUkdHbGxJZElCbStLZDVJNU1YY2N4bCtFVTZO?=
 =?utf-8?B?aFI3dlA4Y09KQ3dyUWFCRmI1VDA4cWxrRzFMYzNmSDhXa0VrRGdzTHlvTDdx?=
 =?utf-8?B?dEZ2ZjU2My84eFpVV2xnMWVhVkhMS3h1am8yL1pVQmt6b1BIWWp1Q1dBVWxT?=
 =?utf-8?B?T2p5MDd3Vld4Ujd5SllNV2RZL0FKcmJpVjFiY1JqdFE4Q3VRZ3p3bWQ5NVVy?=
 =?utf-8?B?VzdSSEdjYUxXM2g0b2lWWnlFZDJrRlBKQXV6YS9OQ0hqQmRZbmc5dCtSMjdN?=
 =?utf-8?B?bVgrdTNvVEdWSzNoTDVlREVaR3VDMDBvVTNJNnBTTWpYaVZzS2NpcFhVN2hh?=
 =?utf-8?B?eVJkN0dvdks5WUMwcGlVdG5GekFtQ1p5SUZvblU4dEp0ZHpMZGdiZDV5RHdh?=
 =?utf-8?B?UXQyc2tMKy93TEpTNmtjam1wMCtmcjBFR0dGdFRTbld2dEg3WkdoYnNsZldw?=
 =?utf-8?B?c2ROTkQrdExrTmRmZS9nMERIWWRROFJPRCtINlQrZ0ZhTzB2dGNrZ0o3UzY5?=
 =?utf-8?B?eXBqNTJrc2JNUHdya0VEdkQyNU4wUExUYnRjQzZZNk9UeVNjd1BlR0JMZUFz?=
 =?utf-8?B?SU9kR2RscXppMlc3c3NmVHVXM0djaU5jc2RGR3VUcXl3SWNsS0Z3Zkp0V0Zh?=
 =?utf-8?B?MjBZbUpKUWRKK3JNbmdObzBlYUhFMXdUaWpOTXpQV3kxckVsblFLeUhBWVQz?=
 =?utf-8?B?eklKckpJUGlRcUtHTE0zK092QUNLOWM1UXppRzRmTzZxdEc3am12TGFaRFd3?=
 =?utf-8?B?OXdPcHVkR3NSMVJXR1ZUM3d2cVdWMDdJZGZ3MmpwUG96K0dmU2R1RjVpWEhD?=
 =?utf-8?B?aStnK0ZSOHQzQ2twdlpHaCt5ek5kazZBOEZETGh1Slh3ZFBhZW5qVmc5MnBX?=
 =?utf-8?B?UVRIM0F1T3NoK0NOb3VTTU5XYkJOTGlMTDdEVjErWXRWNllkTHVNZ1hEVUtH?=
 =?utf-8?Q?exmCTljofUzS1NRw4FDazQ3l7hateC7lkS46Y=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?MHBKL0UvR2JpZGpMb3REWHI0WHJ2SGNwdzBvYnkzTW56UzBoTTBWTEs4S1BY?=
 =?utf-8?B?T2Fyc1UvWDdoQjBaNmZiSERVU2RvSUVObFh1blgvNm5vZWpxWG5kN0lsRWov?=
 =?utf-8?B?N1hGSFA4MWs4ME1qeXdxVElHcGN0NGttcFBySHRBMnRCbEs1V1hSS2l2U2Rv?=
 =?utf-8?B?alAxVUp3K0poY3VXcUdkSmlzS0JzQTEzbk1RZ1hjREs4VTNMZGpvcm53VXds?=
 =?utf-8?B?WHBUSkhpZFRTdEhtTDFyZGt6QlRuV09tQ21MMG1iZnMxSkFrWXpNcDdURmRP?=
 =?utf-8?B?eHlGZHlQZ205aTlma2xMV0k1Q1ArWm1GNnQrbzJoNFJrUE1ORDdBd2pPcUNQ?=
 =?utf-8?B?RkdhYjRUclFTdDVuL2puTDJKTkxJejBvTE5OWkozcHBUZjZvbmpxQWJjVjFo?=
 =?utf-8?B?blBDUWZacmhDbGRBeVpZajVFYXU4cFlzaEYzejlweWkvekZIc0RQZDZ6RlpE?=
 =?utf-8?B?YlJrMnh2V2hQVnp5VlVZWlN2U29uYktIcjBLWTYxNTFidkxnT0ZKRytYcGtV?=
 =?utf-8?B?amJkRmFnUDVrZUNnTmFScDBuVE83VzZiRDN6bkdYbUJYbzdmWXA3MFdUYk02?=
 =?utf-8?B?R2plTnpjenBlY0dTZWNVWStTcnpTWVNwRllPQkw4bWpSU0c1VVEyU1hCaXB3?=
 =?utf-8?B?bW80SFNwQkFUbkdMelJFdkFlSW44Zy9UWkEyWHIzR2tEbGtnYjhrVUhZWWo3?=
 =?utf-8?B?T05yYlNxWTlZUnF6TlltSU93QWd2TnV1QkxqbkpVNEI3WEZUaDNKZjhvUTVx?=
 =?utf-8?B?VTZJTCtqeDhMN2ExZTJmSFhUU3habXl1Ym01VjZDZTNNSDVTcENNZXBnZGhE?=
 =?utf-8?B?ZVdtY3lxc0EyY0tNanVBeXhteFUvS2V5bEYydlZsc0NaYkwyTlNQZTZiRFlL?=
 =?utf-8?B?Q3JSU0tQYmZhVjR1c1dYN0F5OE53OFgwWmFLcG9FbXpCUkN4RjBrMncyalRx?=
 =?utf-8?B?VGtwWjVoc1ZBWEpNZGZiZHJkMktsZ2pZb05wVGpNbW5qQkdPcmxGTTEvdExn?=
 =?utf-8?B?Qzk1MkUxRWt6YUNxaGkwYVdTS0IvOUUwSWlFRkdkM3QwT1MxYUxyeG90U29F?=
 =?utf-8?B?R0RaWGVoelFUZUN5QjZnYWRSRWVmbGdOenlVM2JpSG5CRmcwUlp3S3N3Tzhn?=
 =?utf-8?B?YWY1SWk4U2RsTVdlbVNsRHVmQnhOYVRRVGljUE5KR0FCdmtOM3p2UHlnQmUv?=
 =?utf-8?B?dWswWk0rTkRodE5SUDEwV3dZZ281eGk4ZENZc3hQeUtBYzJkWHFLeTNBM0tv?=
 =?utf-8?B?aVMzUDdUQm5Qb0FFVlQvUkd3Z3pXR3IyZ0V5bHIvWVJNTnRZUk04WURkUEw2?=
 =?utf-8?B?aytrTFRkbkJHZ0ducXpUVlJCYUJYZGZZaXUwc1U5Wkw3RG41ZXNjdEthem9y?=
 =?utf-8?B?UFFOb3M4MStKOGJrNE1GSEtTblVZOWhYSzBVT2VrYnpTb3NiSnQ0Sk0zVjlY?=
 =?utf-8?B?YU43ZkF6ci9tbEZzL00xa2syK2NZbFpMdVgzV29hUVpmWU5ZdU9kellQZHFx?=
 =?utf-8?B?SzVSNFU1ekwyNkx0NjN6UitEdWNWZ3Z1MmgyL2ZlbHlVeVB6Z3FPSXlCUlMw?=
 =?utf-8?B?TlFBZFREVE90NmxldjJmd3c5ZE9ydk83c3VJcVo4WW8rbGZZY2YzNUJKUjR3?=
 =?utf-8?B?L2ZZN055eWV1ZDdIMXlHUTlXQTBmNFJIN3oyMDMxRlpQOEpWMVFHVW9uTFBZ?=
 =?utf-8?B?bzJ4NTVPYjNvNHhBOGhXbHNLWHdBYkxHRmE1and1TkNRbE5CWFVaVTZVNVdP?=
 =?utf-8?B?QVhNaTcwaWwwSnRkZGo2TjdxTFc1UzB5WVA1U3NKZUxiRmhXT2F2RjFIRlFn?=
 =?utf-8?B?KzJFeEpBYlVKdW1rMjMramE3clhIaWg0c3UxZ09oUkJHTVB1UkZjbWE0YUJl?=
 =?utf-8?B?WnVLYVNrVlpHMEZqeURRcWQ5UVBrZHVpdENPUzNRZlMvK2pwQnN0eks0K3o1?=
 =?utf-8?B?cFJpQ29pVU55aFpXdkxGWE5JdkdvOEFPSXFQajBYWGRiSVB6eUk0WkUzSnVm?=
 =?utf-8?B?ZEVNVVdGNzdDbFFFeGwyT3JGTEJ4TnM4U3R3Q2FFeHUyNDhSaXE4QmliTVFT?=
 =?utf-8?B?L2FaR1VPS3pjWERTbE0xbDJGQkR2ejFiUTc3RGpDVndKKytBRjFDUzJUZE5o?=
 =?utf-8?B?ZmlGOHRCQTJTSnJqaHdLc0hqNmxWenVSZVBEb01DbkxRQTFlRlhtc2lXb2tO?=
 =?utf-8?B?Q1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8DEC35D7C399134E80766765D9D26C8D@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	yLc6Ds7v6b0ehh2KqurnjcMfCLwXrUhji0QzGOxDt3cVL528a6y68UHCGJyHFKRwdiABZNMw1IcFc5qan1gC3X6nZE8qoytJQs2z138eh4Z67x7h8GsiTL9yMGco7rRZhdwgF6H2MF45YaFHRpnNg/rIMhmDF/7Dj9TsPCxgzJArC1o6p3eRvxo7TM3fbN64BI8llM5XkRx0VviPNNI/+tbpTbvgLTybyFpBUE5bRE1oAPy76mJFc8bKH1+BChF1zCy0/f0DzYWjGKS0hztH2kI+QlygF6hpZvEWfaOvQ9wyWELmf7YgeB7eifKsXtoqjHhTL/7IeljpHHwpS0ENkWIGcZ7wBOtuPV2/1haP0egX07tPSVSszTR9+Dn2e7Kh3HKjYcH+8teCWJTy+wrI0RMSHHEj6tOyZLgBjDPrQ87OxlqWE0CiaQcbUieG9G1XMYWqI4IjD/8sex+VJRBGClnBCqFZPaFhgqJc8D2pNcD0csBBY3ISKvjusgpWIYKHZgaUKhKfkIfG3My6N5x3vqnIrbIWVt3qQ8SXv9Gm9MaG8ntoayx8iyqgdCITC9+720McbgmG8Bki9QsWItWlXYZguK95oC3AaUB/niZnCWg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 874ae48f-cf0b-4f78-aaeb-08dc987a7d0f
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2024 20:31:43.0869
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HBamfk5SDBB+zw2YNVombX/4UT8vuenhLwxZWBU6TwKXgfe0XRgClVzZUyFSK4NnZ9zQ/YW75oIEGRJTIQJ/nQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5586
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-29_10,2024-06-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 suspectscore=0
 mlxlogscore=999 malwarescore=0 adultscore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2406290150
X-Proofpoint-GUID: tmiLclObzkRfa7fHpLy-DThuAP2Ax040
X-Proofpoint-ORIG-GUID: tmiLclObzkRfa7fHpLy-DThuAP2Ax040

DQoNCj4gT24gSnVuIDI5LCAyMDI0LCBhdCAzOjEw4oCvUE0sIE1pa2UgU25pdHplciA8c25pdHpl
ckBrZXJuZWwub3JnPiB3cm90ZToNCj4gDQo+IE9uIFNhdCwgSnVuIDI5LCAyMDI0IGF0IDAxOjAx
OjU3UE0gLTA0MDAsIENodWNrIExldmVyIHdyb3RlOg0KPj4gT24gU2F0LCBKdW4gMjksIDIwMjQg
YXQgMTI6MDM6NTBQTSAtMDQwMCwgTWlrZSBTbml0emVyIHdyb3RlOg0KPj4+IE9uIFNhdCwgSnVu
IDI5LCAyMDI0IGF0IDAzOjM2OjEwUE0gKzAwMDAsIENodWNrIExldmVyIElJSSB3cm90ZToNCj4+
Pj4gDQo+Pj4+IA0KPj4+Pj4gT24gSnVuIDI4LCAyMDI0LCBhdCA1OjEw4oCvUE0sIE1pa2UgU25p
dHplciA8c25pdHplckBrZXJuZWwub3JnPiB3cm90ZToNCj4+Pj4+IA0KPj4+Pj4gSGksDQo+Pj4+
PiANCj4+Pj4+IEknZCBwcmVmZXIgdG8gc2VlIHRoZXNlIGNoYW5nZXMgbGFuZCB1cHN0cmVhbSBm
b3IgNi4xMSBpZiBwb3NzaWJsZS4NCj4+Pj4+IFRoZXkgYXJlIGFkZXF1YXRlbHkgS2NvbmZpZydk
IHRvIGNlcnRhaW5seSBwb3NlIG5vIHJpc2sgaWYgZGlzYWJsZWQuDQo+Pj4+PiBBbmQgZXZlbiBp
ZiBsb2NhbGlvIGVuYWJsZWQgaXQgaGFzIHByb3ZlbiB0byB3b3JrIHdlbGwgd2l0aCBpbmNyZWFz
ZWQNCj4+Pj4+IHRlc3RpbmcuDQo+Pj4+IA0KPj4+PiBDYW4gdjEwIHNwbGl0IHRoaXMgc2VyaWVz
IGludG8gYW4gTkZTIGNsaWVudCBwYXJ0IGFuZCBhbiBORlMNCj4+Pj4gc2VydmVyIHBhcnQ/IEkg
d2lsbCBuZWVkIHRvIGdldCB0aGUgTkZTRCBjaGFuZ2VzIGludG8gbmZzZC1uZXh0DQo+Pj4+IGlu
IHRoZSBuZXh0IHdlZWsgb3Igc28gdG8gbGFuZCBpbiB2Ni4xMS4NCj4+PiANCj4+PiBJIGZvcmdv
dCB0byBtZW50aW9uIHRoaXMgYXMgYSB2OSBpbXByb3ZlbWVudDogSSBkaWQgc3BsaXQgdGhlIHNl
cmllcywNCj4+PiBidXQgbGVmdCBpdCBhcyBvbmUgcGF0Y2hzZXQuDQo+Pj4gDQo+Pj4gUGF0Y2hl
cyAxLTEyIGFyZSBORlMgY2xpZW50LCBQYXRjaGVzIDEzLTE5IGFyZSBORlNELg0KPj4gDQo+PiBJ
IGRpZG4ndCBub3RpY2UgdGhhdCBiZWNhdXNlIG15IE1VQSBkaXNwbGF5ZWQgdGhlIHBhdGNoZXMg
Y29tcGxldGVseQ0KPj4gb3V0IG9mIG9yZGVyLiBBcG9sb2dpZXMhDQo+PiANCj4+PiBIZXJlIGlz
IHRoZSBkaWZmc3RhdCBmb3IgTkZTIChwYXRjaGVzIDEgLSAxMik6DQo+Pj4gDQo+Pj4gZnMvS2Nv
bmZpZyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgICAzDQo+Pj4gZnMvbmZzL0tj
b25maWcgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgIDE0DQo+Pj4gZnMvbmZzL01ha2Vm
aWxlICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgICAxDQo+Pj4gZnMvbmZzL2Jsb2NrbGF5
b3V0L2Jsb2NrbGF5b3V0LmMgICAgICAgICAgfCAgICA2DQo+Pj4gZnMvbmZzL2NsaWVudC5jICAg
ICAgICAgICAgICAgICAgICAgICAgICAgfCAgIDE1DQo+Pj4gZnMvbmZzL2ZpbGVsYXlvdXQvZmls
ZWxheW91dC5jICAgICAgICAgICAgfCAgIDE2DQo+Pj4gZnMvbmZzL2ZsZXhmaWxlbGF5b3V0L2Zs
ZXhmaWxlbGF5b3V0LmMgICAgfCAgMTMxICsrKysNCj4+PiBmcy9uZnMvZmxleGZpbGVsYXlvdXQv
ZmxleGZpbGVsYXlvdXQuaCAgICB8ICAgIDINCj4+PiBmcy9uZnMvZmxleGZpbGVsYXlvdXQvZmxl
eGZpbGVsYXlvdXRkZXYuYyB8ICAgIDYNCj4+PiBmcy9uZnMvaW5vZGUuYyAgICAgICAgICAgICAg
ICAgICAgICAgICAgICB8ICAgIDQNCj4+PiBmcy9uZnMvaW50ZXJuYWwuaCAgICAgICAgICAgICAg
ICAgICAgICAgICB8ICAgNjAgKysNCj4+PiBmcy9uZnMvbG9jYWxpby5jICAgICAgICAgICAgICAg
ICAgICAgICAgICB8ICA4MjcgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+Pj4gZnMv
bmZzL25mczR4ZHIuYyAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgIDEzDQo+Pj4gZnMvbmZz
L25mc3RyYWNlLmggICAgICAgICAgICAgICAgICAgICAgICAgfCAgIDYxICsrDQo+Pj4gZnMvbmZz
L3BhZ2VsaXN0LmMgICAgICAgICAgICAgICAgICAgICAgICAgfCAgIDMyIC0NCj4+PiBmcy9uZnMv
cG5mcy5jICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAgMjQNCj4+PiBmcy9uZnMvcG5m
cy5oICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAgIDYNCj4+PiBmcy9uZnMvcG5mc19u
ZnMuYyAgICAgICAgICAgICAgICAgICAgICAgICB8ICAgIDINCj4+PiBmcy9uZnMvd3JpdGUuYyAg
ICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAgMTMNCj4+PiBmcy9uZnNfY29tbW9uL01ha2Vm
aWxlICAgICAgICAgICAgICAgICAgICB8ICAgIDMNCj4+PiBmcy9uZnNfY29tbW9uL25mc2xvY2Fs
aW8uYyAgICAgICAgICAgICAgICB8ICAgNzQgKysNCj4+PiBmcy9uZnNkL25ldG5zLmggICAgICAg
ICAgICAgICAgICAgICAgICAgICB8ICAgIDQNCj4+PiBmcy9uZnNkL25mc3N2Yy5jICAgICAgICAg
ICAgICAgICAgICAgICAgICB8ICAgMTINCj4+PiBpbmNsdWRlL2xpbnV4L25mcy5oICAgICAgICAg
ICAgICAgICAgICAgICB8ICAgIDkNCj4+PiBpbmNsdWRlL2xpbnV4L25mc19mcy5oICAgICAgICAg
ICAgICAgICAgICB8ICAgIDINCj4+PiBpbmNsdWRlL2xpbnV4L25mc19mc19zYi5oICAgICAgICAg
ICAgICAgICB8ICAgMTANCj4+PiBpbmNsdWRlL2xpbnV4L25mc194ZHIuaCAgICAgICAgICAgICAg
ICAgICB8ICAgMjANCj4+PiBpbmNsdWRlL2xpbnV4L25mc2xvY2FsaW8uaCAgICAgICAgICAgICAg
ICB8ICAgMzkgKw0KPj4+IGluY2x1ZGUvbGludXgvc3VucnBjL2F1dGguaCAgICAgICAgICAgICAg
IHwgICAgNA0KPj4+IG5ldC9zdW5ycGMvYXV0aC5jICAgICAgICAgICAgICAgICAgICAgICAgIHwg
ICAxNQ0KPj4+IG5ldC9zdW5ycGMvY2xudC5jICAgICAgICAgICAgICAgICAgICAgICAgIHwgICAg
MQ0KPj4+IDMxIGZpbGVzIGNoYW5nZWQsIDEzNTQgaW5zZXJ0aW9ucygrKSwgNzUgZGVsZXRpb25z
KC0pDQo+Pj4gDQo+Pj4gVW5mb3J0dW5hdGVseSB0aGVyZSBhcmUgdGhlIGZzL25mc2QvbmV0bnMu
aCBhbmQgZnMvbmZzZC9uZnNzdmMuYw0KPj4+IGNoYW5nZXMgdGhhdCBhbmNob3IgZXZlcnl0aGlu
ZyAocGF0Y2ggNSkuDQo+PiANCj4+IEkgL2RpZC8gbm90aWNlIHRoYXQuDQo+PiANCj4+IA0KPj4+
IEkgc3VwcG9zZSB3ZSBjb3VsZCBpbnZlcnQgdGhlIG9yZGVyLCBzdWNoIHRoYXQgTkZTRCBjb21l
cyBiZWZvcmUgTkZTDQo+Pj4gY2hhbmdlcy4gIEJ1dCB0aGVuIHRoZSBORlMgdHJlZSB3aWxsIG5l
ZWQgdG8gYmUgcmViYXNlZCBvbiBORlNEIHRyZWUuDQo+PiANCj4+IEFsdGVybmF0ZWx5LCBJIGNh
biB0YWtlIHRoZSBORlNELXJlbGF0ZWQgcGF0Y2hlcyBpbiA2LjExLCBhbmQgdGhlDQo+PiBjbGll
bnQgY2hhbmdlcyBjYW4gZ28gaW4gNi4xMi4gTXkgaW1wcmVzc2lvbiAoY291bGQgYmUgd3Jvbmcp
IHdhcw0KPj4gdGhhdCB0aGUgTkZTRCBwYXRjaGVzIHdlcmUgbmVhcmx5IHJlYWR5IGJ1dCB0aGUg
Y2xpZW50IHNpZGUgd2FzDQo+PiBzdGlsbCBjaHVybmluZyBhIGxpdHRsZS4NCj4gDQo+IEknbSAi
ZG9uZSIgd2l0aCBib3RoIGFmYWlrLiAgT25seSB0aGluZyB0aGF0IG5lZWRzIHNldHRsaW5nIGlz
IHRoYXQNCj4gWEZTIFJGQyBwYXRjaCBJIHBvc3RlZC4NCj4gDQo+PiBPciB3ZSBtaWdodCBkZWNp
ZGUgdGhhdCBpdCdzIG5vdCB3b3J0aCB0aGUgdHJvdWJsZS4gQW5uYSBvZmZlcmVkIHRvDQo+PiB0
YWtlIHRoZSB3aG9sZSBzZXJpZXMsIG9yIEkgY2FuLiBJZiBBbm5hIHRha2VzIGl0LCBJJ2xsIHNl
bmQNCj4+IEFja2VkLWJ5IGZvciB0aGUgTkZTRCBwYXRjaGVzLg0KPiANCj4gUHJvYmFibHkgYmVz
dCB0byBoYXZlIGl0IGFsbCBnbyB0aHJvdWdoIHRoZSBzYW1lIHRyZWUuICBKdXN0IGdldCBwcm9w
ZXINCj4gQWNrZWQtYnk6cyB3aGVyZSBuZWVkZWQuDQo+IA0KPiBJIHdvdWxkIHNheSBpdCBpcyBt
b3JlIGNsaWVudCBoZWF2eSAoaW4gdGVybXMgb2YgY29kZSBmb290LXByaW50KSBzbw0KPiBtYXli
ZSBpdCBkb2VzIG1ha2UgbW9yZSBzZW5zZSB0byBnbyB0aHJvdWdoIE5GUy4gIEFubmEgaXMgaGFu
ZGxpbmcgdGhlDQo+IDYuMTEgbWVyZ2UgZm9yIE5GUyBzbyBsZXQncyBqdXN0IHdvcmsgb24gZ2V0
dGluZyBwcm9wZXIgQWNrZWQtYnkuDQo+IA0KPiBJZiB5b3UsIEplZmYgYW5kIE5laWwgY291bGQg
ZG8gYSBmaW5hbCByZXZpZXcgYW5kIHByb3ZpZGUgQWNrZWQtYnkgKG9yDQo+IGNvbmRpdGlvbmFs
IEFja2VkLWJ5IGlmIEkgZm9sZCB5b3VyIHN1Z2dlc3Rpb25zIGluIGZvciB2MTApIEknbGwgYWRk
DQo+IGFsbCB5b3VyIGZpbmFsIGZlZWRiYWNrIGFuZCBBY2tlZC1ieTpzIG9yIFJldmlld2VkLWJ5
OnMgc28gQW5uYSB3aWxsDQo+IGJlIGFibGUgdG8gc2ltcGx5IHBpY2sgaXQgdXAgb25jZSB0aGUg
TkZTIGNsaWVudCBzaWRlIGlzIGFsc28NCj4gcmV2aWV3ZWQuDQoNCkFubmEgc3VnZ2VzdGVkIHRo
aXMgc2hvdWxkIHNvYWsgaW4gbGludXgtbmV4dCB1bnRpbCB2Ni4xMi4NCkkgZG9uJ3QgaGF2ZSBh
IHN0cm9uZyBwcmVmZXJlbmNlLCB0aG91Z2ggdjYuMTIgc2VlbXMgbGlrZQ0KYSBzYWZlciBnb2Fs
IGlmIHlvdSBoYXZlbid0IHNlZW4gYW55IGNsaWVudC1zaWRlIHJldmlldyB5ZXQuDQoNCg0KPj4+
IERpZmZzdGF0IGZvciBORlNEIChwYXRjaGVzIDEzIC0gMTkpOg0KPj4+IA0KPj4+IERvY3VtZW50
YXRpb24vZmlsZXN5c3RlbXMvbmZzL2xvY2FsaW8ucnN0IHwgIDEzNSArKysrKysrKysrKysNCj4+
PiBmcy9uZnNkL0tjb25maWcgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAgMTQgKw0KPj4+
IGZzL25mc2QvTWFrZWZpbGUgICAgICAgICAgICAgICAgICAgICAgICAgIHwgICAgMSANCj4+PiBm
cy9uZnNkL2ZpbGVjYWNoZS5jICAgICAgICAgICAgICAgICAgICAgICB8ICAgIDIgDQo+Pj4gZnMv
bmZzZC9sb2NhbGlvLmMgICAgICAgICAgICAgICAgICAgICAgICAgfCAgMzE5ICsrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKw0KPj4+IGZzL25mc2QvbmV0bnMuaCAgICAgICAgICAgICAgICAg
ICAgICAgICAgIHwgICAgOCANCj4+PiBmcy9uZnNkL25mc2N0bC5jICAgICAgICAgICAgICAgICAg
ICAgICAgICB8ICAgIDIgDQo+Pj4gZnMvbmZzZC9uZnNkLmggICAgICAgICAgICAgICAgICAgICAg
ICAgICAgfCAgICAyIA0KPj4+IGZzL25mc2QvbmZzc3ZjLmMgICAgICAgICAgICAgICAgICAgICAg
ICAgIHwgIDEwNCArKysrKysrLS0NCj4+PiBmcy9uZnNkL3RyYWNlLmggICAgICAgICAgICAgICAg
ICAgICAgICAgICB8ICAgIDMgDQo+Pj4gZnMvbmZzZC92ZnMuaCAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgfCAgICA5IA0KPj4+IGluY2x1ZGUvbGludXgvbmZzbG9jYWxpby5oICAgICAgICAg
ICAgICAgIHwgICAgMiANCj4+PiBpbmNsdWRlL2xpbnV4L3N1bnJwYy9zdmMuaCAgICAgICAgICAg
ICAgICB8ICAgIDcgDQo+Pj4gbmV0L3N1bnJwYy9zdmMuYyAgICAgICAgICAgICAgICAgICAgICAg
ICAgfCAgIDY4ICsrKy0tLQ0KPj4+IG5ldC9zdW5ycGMvc3ZjX3hwcnQuYyAgICAgICAgICAgICAg
ICAgICAgIHwgICAgMiANCj4+PiBuZXQvc3VucnBjL3N2Y2F1dGhfdW5peC5jICAgICAgICAgICAg
ICAgICB8ICAgIDMgDQo+Pj4gMTYgZmlsZXMgY2hhbmdlZCwgNjIxIGluc2VydGlvbnMoKyksIDYw
IGRlbGV0aW9ucygtKQ0KPj4+IA0KPj4+IEhhcHB5IHRvIHdvcmsgaXQgaG93ZXZlciB5b3UgdGhp
bmsgaXMgYmVzdC4NCj4+PiANCj4+Pj4+IFdvcmtlZCB3aXRoIEtlbnQgT3ZlcnN0cmVldCB0byBl
bmFibGUgdGVzdGluZyBpbnRlZ3JhdGlvbiB3aXRoIGt0ZXN0DQo+Pj4+PiBydW5uaW5nIHhmc3Rl
c3RzLCB0aGUgZGFzaGJvYXJkIGlzIGhlcmU6DQo+Pj4+PiBodHRwczovL2V2aWxwaWVwaXJhdGUu
b3JnL350ZXN0ZGFzaGJvYXJkL2NpP2JyYW5jaD1zbml0bS1uZnMNCj4+Pj4+IChpdCBpcyBydW5u
aW5nIHdheSBtb3JlIHhmc3Rlc3RzIHRlc3RzIHRoYW4gaXMgdXN1YWwgZm9yIG5mcywgd291bGQg
YmUNCj4+Pj4+IGdvb2QgdG8gcmVjb25jaWxlIHRoYXQgd2l0aCB0aGUgbGlzdGluZyBwcm92aWRl
ZCBoZXJlOg0KPj4+Pj4gaHR0cHM6Ly93aWtpLmxpbnV4LW5mcy5vcmcvd2lraS9pbmRleC5waHAv
WGZzdGVzdHMgKQ0KPj4+PiANCj4+Pj4gQWN0dWFsbHksIHdlJ3JlIHVzaW5nIGtkZXZvcHMgZm9y
IE5GU0QgQ0kgdGVzdGluZy4gQW55IHBvc3NpYmlsaXR5DQo+Pj4+IHRoYXQgd2UgY2FuIGdldCBz
b21lIGhlbHAgc2V0dGluZyB0aGF0IHVwPyAoSXQgcnVucyB4ZnN0ZXN0cyBhbmQNCj4+Pj4gc2V2
ZXJhbCBvdGhlciB3b3JrZmxvd3MpLg0KPj4+IA0KPj4+IFN1cmUsIEkgY2FuIGdldCB3aXRoIHlv
dSBvZmYtbGlzdCBpZiB0aGF0J3MgYmVzdD8gIEkganVzdCBuZWVkIHNvbWUNCj4+PiBwb2ludGVy
cy9hY2Nlc3MgdG8gaGVscCBnZXQgaXQgZ29pbmcuDQo+PiANCj4+IFllcywgb2ZmLWxpc3Qgd2Zt
Lg0KPj4gDQo+PiBDb21lIHRvIHRoaW5rIG9mIGl0LCBpdCBtaWdodCBqdXN0IHdvcmsgdG8gcG9p
bnQgbXkgdGVzdCBzeXN0ZW1zIHRvDQo+PiB5b3VyIGdpdCBicmFuY2ggYW5kIGxldCBpdCByaXAs
IGlmIHRoZXJlIGFyZSBubyBuZXcgdGVzdHMuIEkgd2lsbA0KPj4gdHJ5IHRoYXQuDQo+IA0KPiBS
aWdodCwgbm8gbmV3IHRlc3RzIGFkZGVkIHRvIHhmc3Rlc3RzLCBpdCB3YXMgcHVyZWx5IGNvbmZp
Z3VyYXRpb24gdG8NCj4gZ2V0IHhmc3Rlc3RzIHJ1bm5pbmcgb24gc2luZ2xlIGhvc3QgaW4gbG9v
cGJhY2sgbW9kZSAoTkZTIGNsaWVudA0KPiBtb3VudGluZyBleHBvcnQgZnJvbSBrbmZzZCBvbiBz
YW1lIGhvc3QpLg0KPiANCj4gV291bGQgYmUgZ3JlYXQgaWYgeW91IGNvdWxkIHBvaW50IHlvdXIg
a2Rldm9wcyBhdCBteSBsb2NhbGlvLWZvci02LjExDQo+IGJyYW5jaC4gIFlvdSBqdXN0IG5lZWQg
dG8gbWFrZSBzdXJlIHRvIGVuYWJsZSB0aGVzZSBpbiB5b3VyIEtjb25maWc6DQo+IA0KPiBDT05G
SUdfTkZTRF9MT0NBTElPPXkNCj4gQ09ORklHX05GU19MT0NBTElPPXkNCj4gQ09ORklHX05GU19D
T01NT05fTE9DQUxJT19TVVBQT1JUPXkNCj4gDQo+IChlaXRoZXIgb2YgdGhlIE5GUyBvciBORlNE
IG9wdGlvbnMgd2lsbCBzZWxlY3QNCj4gQ09ORklHX05GU19DT01NT05fTE9DQUxJT19TVVBQT1JU
KQ0KDQpJJ20gcnVubmluZyB0aGUgZmlyc3Qgc2V0IHJpZ2h0IG5vdy4gV2UgZG9uJ3QgaGF2ZSBh
IHB1YmxpYw0KZGFzaGJvYXJkIHlldCwgYnV0IEkgY2FuIHNldCB1cCBhIE1haWxOb3RpZmllciBm
b3IgeW91Lg0KDQpZb3UgZG9uJ3QgaGF2ZSBhbnkgbWV0cmljcyB0aGF0IHNob3cgd2hldGhlciAo
YW5kIGhvdyBtYW55KQ0KbG9jYWwgcmVhZCBhbmQgd3JpdGUgb3BlcmF0aW9ucyBhcmUgaGFwcGVu
aW5nOyBzbyBJIGNhbg0KdGVsbCBpZiB0ZXN0cyBwYXNzIG9yIGZhaWwsIGJ1dCBub3QgaWYgbG9j
YWwgSS9PIGlzIGdvaW5nDQpvbi4gVGhlIHVzdWFsIGFwcHJvYWNoIGlzIHRvIGhvb2sgdGhhdCBr
aW5kIG9mIGNsaWVudA0KbWV0cmljIGludG8gL3Byb2Mvc2VsZi9tb3VudHN0YXRzLg0KDQoNCi0t
DQpDaHVjayBMZXZlcg0KDQoNCg==

