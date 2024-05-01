Return-Path: <linux-nfs+bounces-3120-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB0FA8B8E77
	for <lists+linux-nfs@lfdr.de>; Wed,  1 May 2024 18:48:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19CBE1C2174C
	for <lists+linux-nfs@lfdr.de>; Wed,  1 May 2024 16:48:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 224CDEAEB;
	Wed,  1 May 2024 16:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="O8zf4LWG";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="qAz1IXVC"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 351AA3234;
	Wed,  1 May 2024 16:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714582078; cv=fail; b=aPDIZXDUtdtT43h5e2f2HH2IFwXz+typF1iuWrdAj1yNCIbSzUK6b3/jLhSLjwimMFJwg9EhTjT+XWnoMB3zX65U8CbVVA15y7WxV8Rl+FAclZgCNVg90IUmTQVUQbY4vAiiCvbgnoQmwzlV72zLi89X7rX9DihZI2YjVxeVbBk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714582078; c=relaxed/simple;
	bh=Z/llOvm34ZEtnbsXRE9BX3idqV1cEO7or5KceQXljPk=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=nUEeI+NqitR0arl/cLlJIvmtZYnyf1ND0BDLC3xDGewaYwLM7nMGufpRxmEcwc3T8+Dlb5TeJJiZLSFFl4azep1T4WEHW9ELitr4OLPLE5QNTTx2CL/ZWnbWKG0xauWp2yptGzReEPEL1xstQN019+dWHBv21kIVQ8bAfXe4gB4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=O8zf4LWG; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=qAz1IXVC; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 441ARujt032751;
	Wed, 1 May 2024 16:47:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : content-type : content-id : content-transfer-encoding
 : mime-version; s=corp-2023-11-20;
 bh=rBz40b4oTs3bpafCdUGGNvysF7DHp3ef7NT9PncyDYc=;
 b=O8zf4LWGttRMnE6dj4OpD5pwPuU5N1ZYy7pQQpiFfjlWcjz9+ux92trsBJBXkvOK/ny9
 RleEdFWrk3FRamqTRVk2e1Rtmbt2kJPHrBWRYtVIOmtUBKHzgRfPjskXcADJGBL6gcHU
 m3ulmlbhRankTsZLWO+NOGECEkHg5L46TI9Z1NHEPaOAy3ybUc06MsjdCrt2Q3zLJfHF
 b9GhXsaJlaQySbn87qZGnC6cH8Oh8wPSGW8N7UajDK52J98+svOPHKPCJcPZhTYSJKpD
 QiHdZ4kT9ntiPEyP/UvmZUiQZbOwdQB3LfeXIBKtaL4KWUa1kf/+eaLqaBs2e/jxBcm8 0Q== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xrqseygvr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 01 May 2024 16:47:54 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 441F5vUD034721;
	Wed, 1 May 2024 16:47:54 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3xu4c0tbmb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 01 May 2024 16:47:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i9H0HzTZbEoKXqKbVwNMqPIU8JxNus4VFk/Ka0QO7Q941Fia0ODkxg4R+hXMJVMWXjYX+I76ElFnUx1eWafYWDK2X7iRhM54lNSTyGjDVuafWRQbSLOhybrYKaAsAvCQ8i4NkLi1bfn5oVEBg2199PZ9njU58t07FGwhP49qFH9qfMwP0agPA0WYuGrxkCY754RI387jRMUqg+L3dz2t/aMKjAuX6Zp0JmMLAySZg6LzEihZxGiC/QUQKsxrRX/S0hR9pa5mP0bjXSz8SbabxtMgH3nslf7gw1aR1FK7RENwke3K7ZMlZFwKmqh6RBnBJ+R3l4Dh/DWfBtlUMiITKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rBz40b4oTs3bpafCdUGGNvysF7DHp3ef7NT9PncyDYc=;
 b=neAThyiiQAPjkCMkEFuqUNJjd5x5y11zwZcMS6CeuDt6+PmTfN4c22KZBXxrHBgUY4PjYYPrBzeBZ2HRoU3EUHMYzRVY53FKARRCziDe/SWkcYcrj+y+NvR6Hp+XSwlo3sLHQ1DFD5/agYFYISo++G8Q5fhVPcA7ye7PhmSHK4m4jnGiJ2xjAmKYP7lgays6i2cWJ1r9kCQOTl6zRUhrP21BgFLJOyc7ZLQM2AK+R/nsmVIIExwd/mWEOgp61a0nj07no0vdDsVvbNRCwqjPKWxKWCvDc6/tf4V2Zv7bgmrLgZnieKl8JCMCU94+HLf+8PAsbLXfr51r11Kv9dc+VQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rBz40b4oTs3bpafCdUGGNvysF7DHp3ef7NT9PncyDYc=;
 b=qAz1IXVCLxtZjWWuQj/mEyAWmWHPuA543tircGf+/J9QOt286Odu72QR/0897XDoZIyF78B4u6m7TKAKN58JKIriOPDTvgQw1r/J9YDsQOsvPrAwld7MydTA86jqbRSork3bwgBbJmdAIX+j/wmFxv5gBVMx0781cbIDDOLfbZY=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by MN2PR10MB4303.namprd10.prod.outlook.com (2603:10b6:208:1d8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.29; Wed, 1 May
 2024 16:47:53 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.7519.031; Wed, 1 May 2024
 16:47:53 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Linux-XFS
	<linux-xfs@vger.kernel.org>
Subject: possible circular locking dependency detected
Thread-Topic: possible circular locking dependency detected
Thread-Index: AQHam+dPiFSo7JS0g0+BFFeRGi0+eg==
Date: Wed, 1 May 2024 16:47:53 +0000
Message-ID: <A5C74A44-3B8C-4A0D-A86A-90484DE8A6C2@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.500.171.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|MN2PR10MB4303:EE_
x-ms-office365-filtering-correlation-id: c720a869-95f1-4871-a953-08dc69fe71bd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|376005|366007|38070700009;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?JfbQc356SWdrIoWqnvvxFOzHPdsKZZ4+wYtJTkLShuGj/0/LcvUnhbQHE9/q?=
 =?us-ascii?Q?7wQke5SbJIldmU8bPHhQvKEB7yX1Ox6h60c/9He0XKWath1i02wh47eEyCJh?=
 =?us-ascii?Q?abqkyrM3pOw9tkDwoPuBNrKFA/pXlyy5LapI4qwCxs8zC7oSgCNKgUPOWDLM?=
 =?us-ascii?Q?nMKcj3g1nvI2gcdg7qd+PihI90q8aP21JWvm0leCwObB5vQFxRFHL6Oa7vlH?=
 =?us-ascii?Q?cEjXPpkPSSJ1PfL9Lbs7guxiiWCRAxxGgPYbKpfAe1svJ7mF5kowyzpWFfBJ?=
 =?us-ascii?Q?Lp6ABHXR/SSCVYvyseFv9aTnXnqnzuvge844juDFh81QyjyJl8dHUHoY5I12?=
 =?us-ascii?Q?lX8iQdKpzq0W32nz3qkYyKj/5u8XhoYPcPGE4sBw0J3aSi6C02wge4yfaCi8?=
 =?us-ascii?Q?ucPkTkgxHQ7rgi9n2MrHLVBgk1nqBIr7wLQu2XNDT78W64FnHtq8yfhy2S5q?=
 =?us-ascii?Q?hsTd0d5mv/DY1WXJOb4yV6EwkoZyQxfmUnrpH11yNj5wuRdlMc+42LddNmWk?=
 =?us-ascii?Q?Grxq+xyIew6xjY/J2ADvnQtEp3ClHaKuNiQGYHmAueHHkhq4URfWrfpO0s57?=
 =?us-ascii?Q?trYHWusO45tOLy2UEoVweaAZPTn0nagbdN8wiivQb1hQJj/nPhl8ZBix3mkJ?=
 =?us-ascii?Q?saFyqTv3lPD766koMTo8shql1IYGptBNTeqt+6/hK4SWpGt9+xxWIOOf2/79?=
 =?us-ascii?Q?7kZsNIg9wuwTFVCMCCBx655/quB9A9Qb2PfdMw3KlGIV+/UrU9La36wgWucf?=
 =?us-ascii?Q?qtiqDf1fDMNfC9O+l/zC0xnlWXCt+vm7CNK8cstWZyuC4Qvmib2WPGqgnPRT?=
 =?us-ascii?Q?PfsxDySEcEtF/OKx9U6nHLc/qtkm/2S+nHVGwfl0Tbx6a3ODrdwcUTdrZLs+?=
 =?us-ascii?Q?ThkQSw7YXPDcnEI28o+6LBhO0NKpVSDxTn6rNmOzaHIU5j8JlVBYkngTt7Fs?=
 =?us-ascii?Q?NGJ9Ju595tIavjUx+p6OQ1laWTlSCYNZ8/jDtVPvs3jF69CCykEmjp8CyW3g?=
 =?us-ascii?Q?d1r3L1bZTYeZdUcuW9GCKlftdXoGdGrgcqHbTg5PsusHv7yyctHLm/xAbZLE?=
 =?us-ascii?Q?aN3L/vbhFUYXMTUh6X5h73DU7I+7BAYPGw8WhTQ7q1GgfyCY+P7/rC0TmRdh?=
 =?us-ascii?Q?uP4UMsWznQu87DItQYaILArjuOCmVKUuNukhRsm+yNZivwHttxw9XB0Qc7Lw?=
 =?us-ascii?Q?xQ4ukWAe1GHTX/cAY4veD1F33Oc//pjPPbAV1ov558iCAOklnjmd+mPGNYhR?=
 =?us-ascii?Q?Qb3Fd2xj/9cKYZ4vnxKmSs7VM+AVd3U/y8o1+EWqPcSssE/CFHtJXmkOtFJ/?=
 =?us-ascii?Q?xmHTGLWz1tdsNfBkIYL+aucPeBVAXExCSAM7vVyEAuzqqg=3D=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?OyWaFe+8wxvqM+Ft6Zcf1sLNiMJFpNSR63mi6bXcf15GhI6Y/aRkuX2CmE/p?=
 =?us-ascii?Q?XtVPU+99vRH2FykbNHt/KlHpZw2xkgkG8CYOK95RbEnNp30EwSDbl3H98Bvn?=
 =?us-ascii?Q?lwTf+JWG9LYB5kNhcNFwYmqfVuEI5G5doxIc6+3uo8sIj69TcPxQMSsEdlo/?=
 =?us-ascii?Q?GoK7oVQQ3gcRzeHuDq5WJF0dDV1wYcMJLjcvzjBP+ALZ4+GNeCfMSfuPvgjM?=
 =?us-ascii?Q?8ZuU7HZupxQNdgSF9f5FyPz5RGeiyRUO/nDwvsqepJn2yUCj3GrgN98qdXwX?=
 =?us-ascii?Q?K7PMRML1/lGRfG0n8L956jYf7JvF2+Zw0biJH/9zSuzo1p+CZbLoXNgjYWkK?=
 =?us-ascii?Q?wG5rnl7MvFNuWhAHQyAL4vVQSWSt4xDt0lWbSQ6HOH8cuh5RLLiR7HuH1tPn?=
 =?us-ascii?Q?RsiZwe9z7rHmDtKG+v91mDdS12lbk56V+jRJh2zaaAeZGPSkVoe6/QJqy8Bh?=
 =?us-ascii?Q?Br7IS95f29GgrjSucj+RRqIDq/Ourbj/S/2TfRgHHf+S8fnD9AjMIZLNJEoq?=
 =?us-ascii?Q?K9dHgn46xK5Z6X2FzfqTw0SE+rHNlW8vt99cYnCMpQn1S8QgxUlxTBWYE1Zp?=
 =?us-ascii?Q?Mcits+s7OjFyS1v0w9yT6nNRWLIWZkY/JMJjYNv5dSTGpkQxb57smCteq/2r?=
 =?us-ascii?Q?8+cm/aRuT91xVOsbayx6QJUBcFoNuYSYMAlgSILjPPXkHrDmKPx0kr+gybLK?=
 =?us-ascii?Q?vaiDO9es0xMU7oEeYM05MkUmw2IKjFZN7LiAz3GkFVn2/s6YvMMTdWhju2wU?=
 =?us-ascii?Q?8FGxiVga6llQIg3PPnX6gIAZPSsW2X8x4k2+Jg6r66ZljHKzgnE9wumFDXjy?=
 =?us-ascii?Q?4ofIPikDilG+XT7toDeNJZpr4JoGILXoau5VoVEIh/SlrshXJv86yEzBDFT1?=
 =?us-ascii?Q?yJncJE6QQdt7rZP0zCBXZoZ7r6PVu4KCyOKgtVeNecJ2lXJWJu7aO+6CqodH?=
 =?us-ascii?Q?qGamIP9J4Et53/0781xpQFOU1HUqgormHcCMWGVCZp5z4/RXTYaT2gFOeDBt?=
 =?us-ascii?Q?ldEDZliqwDJW/3ZktfPxEcOJAX0FCB6NYTS1C6Mf/pGDkHhavsY8nPF8GqDV?=
 =?us-ascii?Q?I0EzPwuLj/K46bvGvl0bKAKDa+tK5fZNRHP9i/J6v5FWWFxwTLjLdM87jGUi?=
 =?us-ascii?Q?DSCq0tFDSagxE7Pb4aYz+VcI0Vy0sTHSfYjAugXYSwFk/tTUWeiDsztuu2SQ?=
 =?us-ascii?Q?7KxfKAxjSFm3mLp7Dhwx0Qk32gPlL7Z4/mlnl7jt/ZgFxjwefiCcnA2xIyF5?=
 =?us-ascii?Q?l+DTM3m79PR/QU76KqRBtyeFBpZ3cTtFXRzqRgrTo4wt4Di2vKhyMoQCABeq?=
 =?us-ascii?Q?kZakf8l6qyC9xgWeYJC61g3S7t9JVWW43r04Yj6kMq1TCAw59P4M//gnoTij?=
 =?us-ascii?Q?bAAA4sz/0E5ImoSfhF3gvUc1TC1WqB9a+ncrA9LZk7qDEJbrIoYvrn742iLQ?=
 =?us-ascii?Q?Liy+OXNtE3LkwBF218npPGCC+a7EwUIaGRmu+IqNtvl/GNqB8yse6RCBjUvD?=
 =?us-ascii?Q?Ya4EnrQJauFhs3/nOsElXs0JnOM/RYIDJJi2px58aS8QL1K7GbNMnlkpnlvV?=
 =?us-ascii?Q?LTIFYnecijuhc5d8nNGaPq3bf/S+lLu+6q0DZwwCPvZxTyAWh55uUQega5MQ?=
 =?us-ascii?Q?Xw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <8E891DDCD44A6141B4C796395A752FD1@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	+O7w0JMUyV4g5b2G3wTed2+qck9CHrckt2FJJXLnIxtPows/Kfglf1Bw2/T7pTNx/74LXAYxDrJu3GbiqKsHN0c8vJupeOjfzh2Fev+oexl1eKN65uZNVcKdKBswDNArbdWU3+AHYOIR2qJp0yO+1lSTxqA2M4sTYgT+iIP4B+tD0eYRBrBSXCy+2ySmbeazjgRzj2nM4YhDOffQ8Fiwthhj2jnQCyCa0gqBbe+jlwQG1QhnwzuvsZHqiWKqw7SALAbAfLCgorZK4v5+C0OmlvLMqemZKuWHc4VCwzZMSEovQ2GYv43s/iKUZJOAyO5qoe5sQcXYxEeVV8RKyvj1tvS/EZndYn/sG6x6VE/yaFZ6D21XtfnK1eMNAdwwZVnIMCSSBv93/H5SlbA6v2x9UXW44+rHZa9beKz9fqHfwDJAWv5JqQSR0v5Y+3B6GzxY0L1xv0xe5MCC2ljGxCWOAJEXBlsbBsmMnjq4bbYuE72vjPKJFZtRfGucfdx2CDlsA0MUqFJs1zV/uYxviz4+3aLUEnb2Sx8gK6tcbJR400BEQLeeknS81A/nfsCP8ZrzU8WKJ3CbcAwFvHd/3OTkjvpIFk82j9tfUR9yaKpGhuA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c720a869-95f1-4871-a953-08dc69fe71bd
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 May 2024 16:47:53.0460
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: T+GJs3f4iQwb15K5v9k41wCr/Xbxv6WsW8cHTAtgwhZoWRX3qNsSlWRgtpdbo3Ms4Q/FQPPm5Hc8HhsowdLDWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4303
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-01_16,2024-04-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0
 mlxlogscore=762 suspectscore=0 mlxscore=0 spamscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2405010118
X-Proofpoint-ORIG-GUID: 90kEWJiFAr7HGgQsZsMbWx0I4iY6w3h-
X-Proofpoint-GUID: 90kEWJiFAr7HGgQsZsMbWx0I4iY6w3h-

Hi-

Lockdep splat showed up during xfstest on v6.9-rc6:

[10205.014915] WARNING: possible circular locking dependency detected
[10205.016399] 6.9.0-rc6-00022-g06cd86b25b98 #3 Not tainted
[10205.017724] ------------------------------------------------------
[10205.019194] kswapd0/64 is trying to acquire lock:
[10205.020656] ffff88813f60db18 (&xfs_nondir_ilock_class#3){++++}-{4:4}, at=
: xfs_ilock+0x14d/0x3c0 [xfs]
[10205.023544]  [10205.023544] but task is already holding lock:
[10205.024932] ffffffff8deb5420 (fs_reclaim){+.+.}-{0:0}, at: balance_pgdat=
+0x167/0x1530
[10205.027718]  [10205.027718] which lock already depends on the new lock.
[10205.027718]  [10205.029842]  [10205.029842] the existing dependency chai=
n (in reverse order) is:
[10205.031760]  [10205.031760] -> #1 (fs_reclaim){+.+.}-{0:0}:
[10205.033478]        fs_reclaim_acquire+0x111/0x170
[10205.035002]        __kmalloc+0xa9/0x4b0
[10205.036223]        xfs_attr_list_ilocked+0x6f0/0x1540 [xfs]
[10205.038856]        xfs_attr_list+0x1ce/0x260 [xfs]
[10205.040688]        xfs_vn_listxattr+0x102/0x180 [xfs]
[10205.042753]        vfs_listxattr+0x9e/0xf0
[10205.044100]        nfsd_listxattr+0x134/0x250 [nfsd]
[10205.045890]        nfsd4_listxattrs+0x16/0x20 [nfsd]
[10205.047585]        nfsd4_proc_compound+0xe41/0x24e0 [nfsd]
[10205.049477]        nfsd_dispatch+0x258/0x7d0 [nfsd]
[10205.051196]        svc_process_common+0xa88/0x1db0 [sunrpc]
[10205.052934]        svc_process+0x552/0x800 [sunrpc]
[10205.054315]        svc_recv+0x1958/0x2460 [sunrpc]
[10205.055877]        nfsd+0x23d/0x360 [nfsd]
[10205.057315]        kthread+0x2f3/0x3e0
[10205.058524]        ret_from_fork+0x3d/0x80
[10205.059821]        ret_from_fork_asm+0x1a/0x30
[10205.061222]  [10205.061222] -> #0 (&xfs_nondir_ilock_class#3){++++}-{4:4=
}:
[10205.063319]        __lock_acquire+0x3437/0x6e60
[10205.065023]        lock_acquire+0x1ad/0x520
[10205.066444]        down_write_nested+0x96/0x1f0
[10205.067897]        xfs_ilock+0x14d/0x3c0 [xfs]
[10205.071022]        xfs_icwalk_ag+0x885/0x1580 [xfs]
[10205.073093]        xfs_icwalk+0x50/0xd0 [xfs]
[10205.075391]        xfs_reclaim_inodes_nr+0x158/0x210 [xfs]
[10205.077605]        xfs_fs_free_cached_objects+0x5a/0x90 [xfs]
[10205.079657]        super_cache_scan+0x389/0x4e0
[10205.080918]        do_shrink_slab+0x352/0xd20
[10205.082122]        shrink_slab+0x161/0xe40
[10205.083157]        shrink_one+0x3f2/0x6c0
[10205.084218]        shrink_node+0x1f6e/0x35e0
[10205.085322]        balance_pgdat+0x87f/0x1530
[10205.086433]        kswapd+0x559/0xa00
[10205.087399]        kthread+0x2f3/0x3e0
[10205.088673]        ret_from_fork+0x3d/0x80
[10205.090550]        ret_from_fork_asm+0x1a/0x30

I can leave the test NFS server up for a bit if you'd like me to
collect more information.


--
Chuck Lever



