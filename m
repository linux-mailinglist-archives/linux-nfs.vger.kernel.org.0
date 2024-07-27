Return-Path: <linux-nfs+bounces-5088-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B784593E011
	for <lists+linux-nfs@lfdr.de>; Sat, 27 Jul 2024 18:03:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA51C1C20FB5
	for <lists+linux-nfs@lfdr.de>; Sat, 27 Jul 2024 16:03:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93C0F1836E9;
	Sat, 27 Jul 2024 16:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="IWA3DJA6";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="sbfnvg85"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94B411836E7
	for <linux-nfs@vger.kernel.org>; Sat, 27 Jul 2024 16:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722096214; cv=fail; b=edRwpucuML7Gpo6UMWg7FFM+EGjyRpFkHHt7az/Q1yQOzay0dpaAMvRg90y63S38sWdzLM2rl7m337YyYZHzugcvQTHzjFjihWI9DsLb/l/zf0ZPwBfkgZlP5ThcA9yoYqCOd4SIwx1TVnJo7QPKznZ6ye9p3saEp6kynIGVFNw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722096214; c=relaxed/simple;
	bh=+KP+bNuGgeEwHYPYpqFI5pRRcczdwbOw0HR3dWTom3k=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Nv5N+hKkDxrUFBKf5rqhM9VOrpBi9JmRilaFdEkihTjTem8hJ6LlXL70x43fPnpsglno6U4wt91E7Bqx+GR3LVUXPrwTwOUV5rkYPbMI2eCxDNh8LzqVMV7v+/PGWcbxh1/kp2eIvTs1guMajpGFeT6SVGuAMj9xBIhGpcuLTrE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=IWA3DJA6; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=sbfnvg85; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46RDPQqs012169;
	Sat, 27 Jul 2024 16:03:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-id:content-transfer-encoding:mime-version;
	 s=corp-2023-11-20; bh=+KP+bNuGgeEwHYPYpqFI5pRRcczdwbOw0HR3dWTom
	3k=; b=IWA3DJA6nueYYTBpHYYILX/Z8JBy47LpOVxHgQJWW7MudE3DrGv5nha8e
	4mAGOKcG1InGmabJph4inTu/gniZwxC8G2zytSU9WBHm2DS/5wF7vbNQUeOWbRk9
	B61EhepkV9y4Sk/0F23xB0BGHdN1Oy7uTGSOZ3zorbSb1DAhDgTnf2CV23io5yOL
	Me+SE38gByUhAYJ0UTb4qS/izZ51FSnzJYU1BTnsp3t6pV2sHZiwPfNMQApF63Gh
	zzM3tjuuR4h5cCwryfMcTOoUE6FK5NelbVBFfnjs/yZQQmYeEcUh86TWUp7jlGRK
	ME4MBsMXkzkimrCs99gFljQtldWnQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40msesgcxy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 27 Jul 2024 16:03:11 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46RBU4cj031118;
	Sat, 27 Jul 2024 16:03:10 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2173.outbound.protection.outlook.com [104.47.58.173])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 40mqbbm608-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 27 Jul 2024 16:03:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kXd2MJ6IdDGIxj/1wAKFLYxOt84ur6ERRkttz9MSmbGcIaR1Puhi5QDC+3Cb8zDhjDBL+8MU/GI5682fj6yXpJMK/jChR0J5V+ZQUX5WBOcsByiP3Kr6RyOO6dTA3ir6dGsMvDNiHR2EQqwDSiPvcS4uwIangodkGctEPTiY8siiD3/G3goKLFi4V8rM2h/FbnsW4wsXlPX/y8JtmjX+VRRynXpZ8FQ3HJCpPZx6mZVMIZDG+awQXyXfDWxGoJtk6HYfXB3zs5loc4VeK3Xv15373k+o+UHff8QAayfLp9Vd/5XBAbjJIcH8Lx2cvXUt6cwEFGq1c2SFVd5fIp7T0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+KP+bNuGgeEwHYPYpqFI5pRRcczdwbOw0HR3dWTom3k=;
 b=GkQRUmMAKGXp4xDYrbnkz6W6o+vzY63hkXsGGQwIGqWOD9bW1KPaaQ+OJrETGr0BjHtU6Nsy5KFjglHyoZCHPL987tzdlGy+++lRIbIo+USLm7LhnBQJfxwvN+b/HXINAKzahR2eufHSjJEvKQ/vHyuYidzS9R/eWqY0V9mGZQbuPzvCfFHzsuj2yXPRyuj+Y/mLSXeh7donxbNK4cdPRxhWevnKxhf9WtXImO6c9tzG7Km69+trHwPbtuUgM5po92uFtC/96/XcoM2QXLq3wufWMl85FiUWdA8OaXZePyXCiy5b+dOgm4D9VcjaT2K0Zw4v6TMn+FmCmlyX6pz35Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+KP+bNuGgeEwHYPYpqFI5pRRcczdwbOw0HR3dWTom3k=;
 b=sbfnvg85oRCCtx7BOK7fJKKvVp2Ai+j3AKzl6fE5p5wtX+8LwdlSXUQMZL6H8tXSPRFbWQSx6sVmagMVkc07ps1OSR3QBs6xVhoMI9xMvdQU7WHB5kb8fVHrUp61bJiMc331GndU4tRPRyLvaBqrAkJlFd1CLH3yS6enLboCjpE=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BL3PR10MB6187.namprd10.prod.outlook.com (2603:10b6:208:3be::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.16; Sat, 27 Jul
 2024 16:03:07 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.7807.025; Sat, 27 Jul 2024
 16:03:07 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Jeff Layton <jlayton@kernel.org>, Steve Dickson <steved@redhat.com>
CC: Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Neil Brown
	<neilb@suse.de>, Olga Kornievskaia <kolga@netapp.com>,
        Dai Ngo
	<dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
        Lorenzo Bianconi
	<lorenzo@kernel.org>
Subject: Re: [PATCH nfs-utils v6 0/3] nfsdctl: add a new nfsdctl tool to
 nfs-utils
Thread-Topic: [PATCH nfs-utils v6 0/3] nfsdctl: add a new nfsdctl tool to
 nfs-utils
Thread-Index: AQHa3Fjk7Husn4qOd0KbIiuoiOfDdbIJbqyAgAAfWYCAAAdwAIAABeIAgAEo2gA=
Date: Sat, 27 Jul 2024 16:03:07 +0000
Message-ID: <4253CF10-D78D-43CC-B925-C4037616E09D@oracle.com>
References: <20240722-nfsdctl-v6-0-1b9d63710eb5@kernel.org>
 <823ebc16-caf3-4658-9951-842fda8c6cbd@redhat.com>
 <c327208425684c14c788032b56803f05d59f1070.camel@kernel.org>
 <807d899f-56c2-46d9-81aa-d2ef4c84d3b0@redhat.com>
 <9587ca96fc8cf49852e129857ffebefadff1c436.camel@kernel.org>
In-Reply-To: <9587ca96fc8cf49852e129857ffebefadff1c436.camel@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3774.600.62)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|BL3PR10MB6187:EE_
x-ms-office365-filtering-correlation-id: 274e8c8c-2470-4ed7-eff3-08dcae559ae6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?U3NLZnErWFprejM0UG95b0JwWnZjM0xzS0g4OVczYThuWDJJdVY3cW93M093?=
 =?utf-8?B?UnlSZWwwUGlibTRCT0dvNS80NGhvcGdWVzg5U1FDakEzOXlzWE9Ccm9YQ1Rs?=
 =?utf-8?B?L0wwL1hoaXNHOXpBY0dCVGlmVVI1UE9SaEJEOGtuNXZKVWIvVm1EWkNaTjIy?=
 =?utf-8?B?MEJwdk5USE5MMXlUVDQxUVdzWU5LT0lqeW1oMXpSTThPWEc2ZnlINkxoNWJJ?=
 =?utf-8?B?OGExajZnQkU5ZjBobXJGRnUwcHR3dkMvWHEvZjczckZNNmdkYW9XTzZ1S0dF?=
 =?utf-8?B?d3dqUTFwTlc0NHQveWQ3SDl1TmVrWDA5NHlhRmltUExpMmlTa2N1NFRUNjVl?=
 =?utf-8?B?SmNSd2Q3bXorUjUreWJKbFYxUzVieFMxdWllYVg2d0Vad3V1bXFVWVljdTZo?=
 =?utf-8?B?cnRFTHMxQ2Y1UUwyTWlLemFBcVBLYUVhdXBOL1pQOXZCdS93cS9ZT2VsMEND?=
 =?utf-8?B?SVMxWGRNa2Rnc2Q1V0tCWHFuUmpPQzZSV3IzWjQwd2pWNDZZS0p0Z0V1MnRF?=
 =?utf-8?B?dGo0enMweUhZRmxsUzdPR3FTMzV1bTBaV3VEd1poWFBENndUUk5CWlI3Q1kx?=
 =?utf-8?B?NTRtZ2dwdm5xbGFWUjRLTUtSZlBteVdnajRSbDNaM1NhNTV2RHVqMzE2amxx?=
 =?utf-8?B?Y1RqUm1LOWFzYVJWQ2xiWDNXUWNhQWxaRmljc2s4dzRLRmNZYUMzdWlVU09o?=
 =?utf-8?B?SUplaGxVU0VMa1ZWU0c4Zk95c2xBbkRwbm9PM2hUUG0zNDFzbzc2NzFaeTVt?=
 =?utf-8?B?YXdocFdHeVk2enJHb0RjSm51akpCcXFnK3NEU2RkM0NNcnQwMElSeDJIYnlK?=
 =?utf-8?B?SFg3bStpSTUwRUdHdVhQTWpRNG53WHNSSWVEZFNJalNEUnF1ZFk3aTU0dm1K?=
 =?utf-8?B?UDNGNElRbG1odUdScXVTMEk1UzR4U2RHVWZ3bmM3aWFueGxqRjJHNU5nOXY1?=
 =?utf-8?B?Q3plM0s1bm1EZnlscHE5OEg5YXJNS0NOYkVLMlZ5YUZ4VTAydnp4WWgyUkpa?=
 =?utf-8?B?bjZMbnRHTnZMak5TLzVtNjZ4RWMwYnQzczhIdVlwUDhhT1d0Sk1FQmdHVTlN?=
 =?utf-8?B?MUkybFdQaWVCQUw1SFVmaEdYbk1aWEdXQmxsZ2l6bnR5SzREVUJ6ZXpWS2Q1?=
 =?utf-8?B?bFlsWUdMbzZUOUY2NlJDNlRrRlJwYUhaZEVFdEROYm53K1JEQ09QaGRKc1lF?=
 =?utf-8?B?cHZ1UDVNeTUwZzBYN0JMN2syWUt2ZFdHU05jTk50eGZaWjlZL0Y4QWJIeU5Z?=
 =?utf-8?B?aVRXVW0rdi92ZHlYR1REOXNqZU5mNGg2QW9HblFrS2t0L29CVndpUGNwK2ZI?=
 =?utf-8?B?amZyZjd1L1NwSHhkbERxS2IvRG0ra2J6SkZYT3F0MWR1bGxXZGlFbmwzL0NJ?=
 =?utf-8?B?YTc2Lzc2UTlEUFhaZ1J5ckUzWDRxdW9UZXBtcVZtTWZydVllWGY0K1VQV256?=
 =?utf-8?B?eFJNTzhtc29SV2wvU056bkJGVytWdjVTd1AxS2ZHZFM3UWphQXdGbktSTXRr?=
 =?utf-8?B?K1N0WnlxTHM4VXI0QUNKdjVtc2ZtRDAwSXI5Q3M1dlZJY2d2cEUvRFd1MUVr?=
 =?utf-8?B?eDhPSkZadkxZNHd1eHludDc1QzI4ajMwVDduRnhaOUFFWER1a3E1RFR4T3Ja?=
 =?utf-8?B?WExvaUJqT1RsMldtYUduTytKUkgrUlM5dStkcDFpejF2dVR3eCtta0I4V1pV?=
 =?utf-8?B?bkdoRWFDNzhiS1drRTNhM0pWMUNicUZ4RlhEM2RRVGhwOWdEaU1oVmFncjZL?=
 =?utf-8?B?WjdQQnozQWpxZzdtTi9ONFdyaFJIanlCUDhMeDN0V25XaVBIVUxkcXV2K3FQ?=
 =?utf-8?Q?Re7zr9asykweINjPkjzbwjiQchd99MsNNk5bk=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TjZkbEJwRytGWWVTWHYySDdpNjlzNnEvelZ0aTFnbDFuY01jdWxNTTd5V1lL?=
 =?utf-8?B?bHpoRTVHak1WaUhrZzVJNkVGMSsrUEM3NE5DdVpzWEM2a1U1MUxXc1dtU0dJ?=
 =?utf-8?B?bEptSnlLSHcvMFVqQXR6SFJ1bDB5eURuL05mUnBBa05ZdHpLcnR2UVFYL09j?=
 =?utf-8?B?a2o1TVcrZ0h6OFdLM3o3R0VVVTNkRjBTZWNLcFpGZlYxWm5CSktaS0VmcE9J?=
 =?utf-8?B?ZkxkMVI2QXd1dTgvd0plbHIwR3NPb2lWWmhRWG0vaGhVeEZwQlRpc2J6TDQ5?=
 =?utf-8?B?SnZoL3lQbGtIU0pvSkNvdTIzcVorUmhKRW5VQ2FLSGFmSmFOWVpzUmlKK2ZJ?=
 =?utf-8?B?Q214MFNnWFZUWGVVUmhzRC9sRlhCcVdVQ2ZUZVdKMGp3UE9QQTZFK0tQV2tE?=
 =?utf-8?B?clliZGNMWlJsWjJubndYVmpabnVHTjZaTWRQSFJYa2VBTmFub1dkdnN0ZjhV?=
 =?utf-8?B?RVVXNjRqVWd3Vk9mbnBqbTg4bmhBMjcxYWpEZTRRa1pBVDArZDBsVTI3NUdC?=
 =?utf-8?B?elNMZGNlRTc0N2IxZjlpQm5pSS9kQ3hvUWp5NmV4Z2U5UGhGVmVWbWlEKzhx?=
 =?utf-8?B?N3BGbUxhWnNodENQem1OalVObHVhK1VHenJLZ1dDZUlySk8vcEExamhrN0NS?=
 =?utf-8?B?dFExNENzaVp3ZkVjeDZpQkFtc0NRTE91NUJMbFlKV09kYjVZcHo2clBRWmpY?=
 =?utf-8?B?S1FoRVNOTWg2SkYxK2xVNFdFbVVubFZYSlIwVkQzeUVPRkxmYUJBdmYxbWhX?=
 =?utf-8?B?SnF6aHIwYjBWQm1LL3ZIOGhvVmdxY2hYRUN5V1BjQTZqWkFmWmhZWll3L1Ns?=
 =?utf-8?B?dGh3RXBNVGZUMFhicEVsOFVWRGptbVlzblh2QXZzVk96eTRPeVE3MGs2YWQv?=
 =?utf-8?B?ZjNyTVRuWGVaQnZwMS9DOWl0dVBHTGthaWZuSm9zZExPQzVwYUJ1TTRJU3l2?=
 =?utf-8?B?UFlOMlpNaVRLVkdZTXA1TkFVdHlCOUxhVmY3eEJUeGhQSkN1bzF6VlgybGxz?=
 =?utf-8?B?WWtSUkdvSGlsa2pWanFSSnFNS0w1THZaU1NQNnBBeWNwUC9RUHVET3Z2dFlE?=
 =?utf-8?B?SjI3UTVVelB1Vk5KQXBtajl1dXl4NVIvL0Y2M01IQWNlaHJhaGFRQ0pSR09E?=
 =?utf-8?B?cUlaaFY0Qyt5UXJ1c29uVmJ0a0xUVkxzQ2l1THJQWE5jK28wZDR1VldHRmlF?=
 =?utf-8?B?OUJEdHZ5cko1eXh5K3JLeWVtcE1KQU1iOWpoK2lEazZrMCs0d2o4U2t1aXNQ?=
 =?utf-8?B?U3RnbThQTnI3SDQyQmdHTnhwYXMxV0JWWTUveG5sQlpZMTZlT1FiTGtLSFh1?=
 =?utf-8?B?SkRkYWI0bHZoWFNHQUNWUnkzZXU5ZEwxYTR5V0FhYXZVbjJ6OVFHUUpRN0lU?=
 =?utf-8?B?VFRiZ2lvWE1OY3lhaDlOWjZZZVdBeHdDNVFVVDNmQlAyOThLZzZNSmFMQm50?=
 =?utf-8?B?eEMrekJhbytqRk9uU1BwSnVWWW80bDJjM3B4R1pjaW1DcjNCTTNXY2pqekNG?=
 =?utf-8?B?TVord0RZTlRWSGh2ai9KNTVmc2I4Mng1bTBNcG9ncDY4L3pTVDd4VTEyWVV4?=
 =?utf-8?B?dHV0ZmJ3Vy92NllpTjJoSlZ3c0lMMDZFZFFEMXNENHBLMDM4VWp3MU5aZk93?=
 =?utf-8?B?RXJvOU50WmliQlVKM3dmNFBxMlJWem1EeklCNUN0NWpnU0MxK2s3MmtSVGNI?=
 =?utf-8?B?R0lQRUtJNkZIL3BWOWdmVTh0NDJZbFdtbUJoRHAyeldhVEV6aDI0YVQ2U25C?=
 =?utf-8?B?ZkJWdm4yY1hRY2dCRFkyaDFHNHdIS24ybEdQUDFOempPWHpKbUJJcUQ2MXZJ?=
 =?utf-8?B?eHRGQ0NzMGlPQkVWV0orVGVCZWU1RmZLTzVWUlU2RGVrR25JVnJOUVBndDBk?=
 =?utf-8?B?Qm5hT3VNSkZjaHFhUEk0Z05lYzhQVWM2VEd3WnNJVDBKcm5HU1d4ZURleTRt?=
 =?utf-8?B?a2tWeXBxMjIvNHAzTm4wd2JJMk9zL1VtaU5rS3RsSEFDR2twVmFwODBnTkhm?=
 =?utf-8?B?TlY2aG04eXRJSVJEMTY1TjZtRzhpeHZRaUpYSWtNYkhTam1pS2NTUzlwd1Vn?=
 =?utf-8?B?R2JESStYL053MVpuTXhrUGhZRHJIYnJKSVJ1M0NPODBtY1BVMklIWmp4VFhW?=
 =?utf-8?B?MTB2WXErdTNSOEh3WGM0QURTQkhNME1JMURDVmpKbXBlMjBNR0dybnVmSXM4?=
 =?utf-8?B?Y2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <50F5E57B8CF8E348AE5D08D2416294EE@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	rsFiDBOHnGT/sMy2sZ92V9MKES1bFNoPKgXxYuRiLx94t5t5Im8B3TugM9tKVN2SVwVW+AyfpDC2u0gVU1Fx3lwkXy0VIwpueeEHCEyiuJWN9wikBp7dtun0vDRN+D13fS7olAvRHu7uIM9XtVkWqhxSX3pnnHkToCqYAzDUpyCqU2Vp84+iTqc6fH+bjQhkkmg1kSryxbCIg92XJSegNzy/P/I1kDOpUxxmLvJDSNyAkCsFiA3BVFOikTn7g37fu85sOc/OSxJ0wp6ivyVJdGM9JhnpAzAiHHzpBydcnC+xN8oS/zqlX1No2j8m6Yhol1tAI2W2i4wRXPEkjw07YPAxWurngg2ziO5mqGOb7LD9JjZnuK1COKhd4B7EIt6eNdj899SHRV+LP1ba+WERUgwW51IrTQOEl5p1LhADLcKXovGOf/FXd+40B0CRPYBgRZgtHQL2zgNpyrrhKWh+1WsUDBhWD8RzDKWqJa0dHts3BiSHZ+byWKBFdd+gItqdYLAPXnHhaFzBtZUgT3coDotTkTjapn+rOE8UaUKbnwbTn1JfsOmy7/PeVVLB6DAzfTLnds+Y9DsnFF/SsBBzS00CXPsa3Xr+Vm9P7LnVn50=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 274e8c8c-2470-4ed7-eff3-08dcae559ae6
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jul 2024 16:03:07.3538
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HdlsWrx4mHF1gbJ7i7izTSn0l74D7qcNeFo16ClKRKOs71CCwF/3VxBVkiJYrDR707HBi/hSXdendsAXzMOjlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6187
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-27_11,2024-07-26_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 phishscore=0
 spamscore=0 suspectscore=0 malwarescore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2407270109
X-Proofpoint-ORIG-GUID: JfuqSrkYFctaKa4HiA6tuqCB6X6lgo53
X-Proofpoint-GUID: JfuqSrkYFctaKa4HiA6tuqCB6X6lgo53

DQoNCj4gT24gSnVsIDI2LCAyMDI0LCBhdCA2OjIw4oCvUE0sIEplZmYgTGF5dG9uIDxqbGF5dG9u
QGtlcm5lbC5vcmc+IHdyb3RlOg0KPiANCj4gT24gRnJpLCAyMDI0LTA3LTI2IGF0IDE3OjU5IC0w
NDAwLCBTdGV2ZSBEaWNrc29uIHdyb3RlOg0KPj4gDQo+PiBPbiA3LzI2LzI0IDU6MzIgUE0sIEpl
ZmYgTGF5dG9uIHdyb3RlOg0KPj4+IE9uIEZyaSwgMjAyNC0wNy0yNiBhdCAxNTo0MCAtMDQwMCwg
U3RldmUgRGlja3NvbiB3cm90ZToNCj4+Pj4gSGV5IQ0KPj4+PiANCj4+Pj4gT24gNy8yMi8yNCAx
OjAxIFBNLCBKZWZmIExheXRvbiB3cm90ZToNCj4+Pj4+IEhpIFN0ZXZlLA0KPj4+Pj4gDQo+Pj4+
PiBIZXJlJ3MgYW4gc3F1YXNoZWQgdmVyc2lvbiBvZiB0aGUgbmZzZGN0bCBwYXRjaGVzLCB0aGF0
IHJlcHJlc2VudHMNCj4+Pj4+IHRoZSBsYXRlc3QgY2hhbmdlcy4gTGV0IG1lIGtub3cgaWYgeW91
IHJ1biBpbnRvIGFueSBvdGhlciBwcm9ibGVtcywNCj4+Pj4+IGFuZCB0aGFua3MgZm9yIGhlbHBp
bmcgdG8gdGVzdCB0aGlzIQ0KPj4+Pj4gDQo+Pj4+PiBTaWduZWQtb2ZmLWJ5OiBKZWZmIExheXRv
biA8amxheXRvbkBrZXJuZWwub3JnPg0KPj4+Pj4gLS0tDQo+Pj4+PiBDaGFuZ2VzIGluIHY2Og0K
Pj4+Pj4gLSBtYWtlIHRoZSBkZWZhdWx0IG51bWJlciBvZiB0aHJlYWRzIDE2IGluIGF1dG9zdGFy
dA0KPj4+Pj4gLSBkb2MgdXBkYXRlcw0KPj4+Pj4gDQo+Pj4+PiBDaGFuZ2VzIGluIHY1Og0KPj4+
Pj4gLSBhZGQgc3VwcG9ydCBmb3IgcG9vbC1tb2RlIHNldHRpbmcNCj4+Pj4+IC0gZml4IHVwIHRo
ZSBoYW5kbGluZyBvZiBuZnNkX25ldGxpbmsuaCBpbiBhdXRvY29uZg0KPj4+Pj4gLSBMaW5rIHRv
IHY0Og0KPj4+Pj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvci8yMDI0MDYwNC1uZnNkY3RsLXY0
LTAtYTI5NDFmNzgyZTRjQGtlcm5lbC5vcmcNCj4+Pj4+IA0KPj4+Pj4gQ2hhbmdlcyBpbiB2NDoN
Cj4+Pj4+IC0gYWRkIGFiaWxpdHkgdG8gc3BlY2lmeSBhbiBhcnJheSBvZiBwb29sIHRocmVhZCBj
b3VudHMgaW4gbmZzLmNvbmYNCj4+Pj4+IC0gTGluayB0byB2MzoNCj4+Pj4+IGh0dHBzOi8vbG9y
ZS5rZXJuZWwub3JnL3IvMjAyNDA0MjMtbmZzZGN0bC12My0wLTllNjgxODFjODQ2ZEBrZXJuZWwu
b3JnDQo+Pj4+PiANCj4+Pj4+IENoYW5nZXMgaW4gdjM6DQo+Pj4+PiAtIHNwbGl0IG5mc2RjdGwu
aCBzbyB3ZSBjYW4gaW5jbHVkZSB0aGUgVUFQSSBoZWFkZXIgYXMtaXMNCj4+Pj4+IC0gc3F1YXNo
IHRoZSBwYXRjaGVzIHRvZ2V0aGVyIHRoYXQgYWRkZWQgTG9yZW56bydzIHZlcnNpb24gYW5kDQo+
Pj4+PiBjb252ZXJ0DQo+Pj4+PiAgICBpdCB0byB0aGUgbmV3IGludGVyZmFjZQ0KPj4+Pj4gLSBh
ZGFwdCB0byBsYXRlc3QgdmVyc2lvbiBvZiBuZXRsaW5rIGludGVyZmFjZSBjaGFuZ2VzDQo+Pj4+
PiAgICArIGhhdmUgVEhSRUFEU19TRVQvR0VUIHJlcG9ydCBhbiBhcnJheSBvZiB0aHJlYWQgY291
bnRzIChvbmUgcGVyDQo+Pj4+PiBwb29sKQ0KPj4+Pj4gICAgKyBwYXNzIHNjb3BlIGluIGFzIGEg
c3RyaW5nIHRvIFRIUkVBRFNfU0VUIGluc3RlYWQgb2YgdXNpbmcNCj4+Pj4+IHVuc2hhcmUoKSB0
cmljaw0KPj4+Pj4gDQo+Pj4+PiBDaGFuZ2VzIGluIHYyOg0KPj4+Pj4gLSBBZGFwdCB0byBsYXRl
c3Qga2VybmVsIG5ldGxpbmsgaW50ZXJmYWNlIGNoYW5nZXMgKGluIHBhcnRpY3VsYXIsDQo+Pj4+
PiBzZW5kDQo+Pj4+PiAgICB0aGUgbGVhc3RpbWUgYW5kIGdyYWNldGltZSB3aGVuIHRoZXkgYXJl
IHNldCBpbiB0aGUgY29uZmlnKS4NCj4+Pj4+IC0gTW9yZSBoZWxwIHRleHQgZm9yIGRpZmZlcmVu
dCBzdWJjb21tYW5kcw0KPj4+Pj4gLSBOZXcgbmZzZGN0bCg4KSBtYW5wYWdlDQo+Pj4+PiAtIFBh
dGNoIHRvIG1ha2Ugc3lzdGVtZCBwcmVmZXJlbnRpYWxseSB1c2UgbmZzZGN0bCBpbnN0ZWFkIG9m
DQo+Pj4+PiBycGMubmZzZA0KPj4+Pj4gLSBMaW5rIHRvIHYxOg0KPj4+Pj4gaHR0cHM6Ly9sb3Jl
Lmtlcm5lbC5vcmcvci8yMDI0MDQxMi1uZnNkY3RsLXYxLTAtZWZkNmRjZWJjYzA0QGtlcm5lbC5v
cmcNCj4+Pj4+IA0KPj4+Pj4gLS0tDQo+Pj4+PiBKZWZmIExheXRvbiAoMyk6DQo+Pj4+PiAgICAg
ICAgbmZzZGN0bDogYWRkIHRoZSBuZnNkY3RsIHV0aWxpdHkgdG8gbmZzLXV0aWxzDQo+Pj4+PiAg
ICAgICAgbmZzZGN0bDogYXNjaWlkb2Mgc291cmNlIGZvciB0aGUgbWFucGFnZQ0KPj4+Pj4gICAg
ICAgIHN5c3RlbWQ6IHVzZSBuZnNkY3RsIHRvIHN0YXJ0IGFuZCBzdG9wIHRoZSBuZnMgc2VydmVy
DQo+Pj4+PiANCj4+Pj4+ICAgY29uZmlndXJlLmFjICAgICAgICAgICAgICAgICB8ICAgMTkgKw0K
Pj4+Pj4gICBzeXN0ZW1kL25mcy1zZXJ2ZXIuc2VydmljZSAgIHwgICAgNCArLQ0KPj4+Pj4gICB1
dGlscy9NYWtlZmlsZS5hbSAgICAgICAgICAgIHwgICAgNCArDQo+Pj4+PiAgIHV0aWxzL25mc2Rj
dGwvTWFrZWZpbGUuYW0gICAgfCAgIDEzICsNCj4+Pj4+ICAgdXRpbHMvbmZzZGN0bC9uZnNkX25l
dGxpbmsuaCB8ICAgOTYgKysrDQo+Pj4+PiAgIHV0aWxzL25mc2RjdGwvbmZzZGN0bC44ICAgICAg
fCAgMzA0ICsrKysrKysrDQo+Pj4+PiAgIHV0aWxzL25mc2RjdGwvbmZzZGN0bC5hZG9jICAgfCAg
MTU4ICsrKysrDQo+Pj4+PiAgIHV0aWxzL25mc2RjdGwvbmZzZGN0bC5jICAgICAgfCAxNTcwDQo+
Pj4+PiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4+Pj4+ICAg
dXRpbHMvbmZzZGN0bC9uZnNkY3RsLmggICAgICB8ICAgOTMgKysrDQo+Pj4+PiAgIDkgZmlsZXMg
Y2hhbmdlZCwgMjI1OSBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPj4+Pj4gLS0tDQo+
Pj4+PiBiYXNlLWNvbW1pdDogYjc2ZGJhYTQ4ZjdjMjM5YWNjYjBjMmQxZTFkNTFkZGQ3M2Y0ZDZi
ZQ0KPj4+Pj4gY2hhbmdlLWlkOiAyMDI0MDQxMi1uZnNkY3RsLWZhOGJkODQzMGNmZA0KPj4+PiAN
Cj4+Pj4gVGhlIHBhdGNoZXMgYXBwbHkgdmVyeSBjbGVhbmluZyBhbmQgdGhhbmsgeW91DQo+Pj4+
IGZvciBzcXVhc2hpbmcgdGhlbSBkb3duLi4uIGJ1dC4uLiBicmluZyB1cCB0aGUNCj4+Pj4gTkZT
IHNlcnZlciB3aXRoICduZnNkY3RsIGF1dG9zdGFydCcgdjMgaXMgbm90DQo+Pj4+IGJlaW5nIHJl
Z2lzdGVyZWQgd2l0aCBycGNiaW5kIHdoaWNoIG1lYW5zDQo+Pj4+IHYzIG1vdW50IHdpbGwgbm90
IHdvcmsuDQo+Pj4+IA0KPj4+PiBKdXN0IGN1cmlvdXMgYXJlIHlvdSB0cnlpbmcgc3VwcG9ydCBt
eQ0KPj4+PiBpZGVhIG9mIGRlcHJlY2F0aW5nIFYzIDotKSAoVGhhdCdzIGEgam9rZSEpDQo+Pj4+
IA0KPj4+PiBzdGV2ZWQuDQo+Pj4+IA0KPj4+IA0KPj4+IFlvdSBkbyBuZWVkIGEgcGF0Y2hlZCBr
ZXJuZWwgZm9yIHRoaXM6DQo+Pj4gDQo+Pj4gICAgIGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xp
bnV4LW5mcy9acDVqMkRXKzJCTmFJUGlmQHRpc3NvdC4xMDE1Z3Jhbmdlci5uZXQvVC8jZTY3NTY0
MjYzOWM1OWIxYzAwNzBmNGIxOWNkMDNiODljZmY3OTgzYmENCj4+PiANCj4+PiBXaXRoIGEgcGF0
Y2hlZCBrZXJuZWwsIEkgZ2V0IHRoaXMgd2l0aCBhdXRvc3RhcnQ6DQo+Pj4gDQo+Pj4gW2tkZXZv
cHNAa2Rldm9wcy1uZnNkIH5dJCBycGNpbmZvIC1wDQo+Pj4gICAgcHJvZ3JhbSB2ZXJzIHByb3Rv
ICAgcG9ydCAgc2VydmljZQ0KPj4+ICAgICAxMDAwMDAgICAgNCAgIHRjcCAgICAxMTEgIHBvcnRt
YXBwZXINCj4+PiAgICAgMTAwMDAwICAgIDMgICB0Y3AgICAgMTExICBwb3J0bWFwcGVyDQo+Pj4g
ICAgIDEwMDAwMCAgICAyICAgdGNwICAgIDExMSAgcG9ydG1hcHBlcg0KPj4+ICAgICAxMDAwMDAg
ICAgNCAgIHVkcCAgICAxMTEgIHBvcnRtYXBwZXINCj4+PiAgICAgMTAwMDAwICAgIDMgICB1ZHAg
ICAgMTExICBwb3J0bWFwcGVyDQo+Pj4gICAgIDEwMDAwMCAgICAyICAgdWRwICAgIDExMSAgcG9y
dG1hcHBlcg0KPj4+ICAgICAxMDAwMjQgICAgMSAgIHVkcCAgNDIxMDQgIHN0YXR1cw0KPj4+ICAg
ICAxMDAwMjQgICAgMSAgIHRjcCAgNDAxNTkgIHN0YXR1cw0KPj4+ICAgICAxMDAwMDMgICAgMyAg
IHVkcCAgIDIwNDkgIG5mcw0KPj4+ICAgICAxMDAyMjcgICAgMyAgIHVkcCAgIDIwNDkgIG5mc19h
Y2wNCj4+PiAgICAgMTAwMDAzICAgIDMgICB0Y3AgICAyMDQ5ICBuZnMNCj4+PiAgICAgMTAwMDAz
ICAgIDQgICB0Y3AgICAyMDQ5ICBuZnMNCj4+PiAgICAgMTAwMjI3ICAgIDMgICB0Y3AgICAyMDQ5
ICBuZnNfYWNsDQo+Pj4gICAgIDEwMDAyMSAgICAxICAgdWRwICA0NjM4NyAgbmxvY2ttZ3INCj4+
PiAgICAgMTAwMDIxICAgIDMgICB1ZHAgIDQ2Mzg3ICBubG9ja21ncg0KPj4+ICAgICAxMDAwMjEg
ICAgNCAgIHVkcCAgNDYzODcgIG5sb2NrbWdyDQo+Pj4gICAgIDEwMDAyMSAgICAxICAgdGNwICAz
NjU2NSAgbmxvY2ttZ3INCj4+PiAgICAgMTAwMDIxICAgIDMgICB0Y3AgIDM2NTY1ICBubG9ja21n
cg0KPj4+ICAgICAxMDAwMjEgICAgNCAgIHRjcCAgMzY1NjUgIG5sb2NrbWdyDQo+Pj4gDQo+Pj4g
DQo+Pj4gQXJlIHlvdSBzZWVpbmcgZGlmZmVyZW50IHJlc3VsdHM/DQo+PiBZdXANCj4+IHVuYW1l
IC1yDQo+PiA2LjExLjAtMC5yYzAuMjAyNDA3MjRnaXQ3ODZjODI0OGRiZDMuMTIuZmM0MS54ODZf
NjQgKHJhd2hpZGUpDQo+IA0KPiBEaWQgeW91IHBhdGNoIHRoYXQga2VybmVsIGJ5IGhhbmQgdGhl
bj8gQUZBSUNULCB0aGF0IGdpdCBoYXNoIGRvZXNuJ3QNCj4gaGF2ZSB0aGUgbmVjZXNzYXJ5IGZp
eC4gSSBkb24ndCB0aGluayBDaHVjayBoYXMgc2VudCBhIFBSIHRvIExpbnVzIGZvcg0KPiBpdCBq
dXN0IHlldC4NCg0KIm5mc2Q6IGRvbid0IHNldCBTVkNfU09DS19BTk9OWU1PVVMgd2hlbiBjcmVh
dGluZyBuZnNkIHNvY2tldHMiDQppcyBxdWV1ZWQgdXAgZm9yIHY2LjExLXJjLg0KDQoNCi0tDQpD
aHVjayBMZXZlcg0KDQoNCg==

