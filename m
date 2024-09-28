Return-Path: <linux-nfs+bounces-6684-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EF5D4988FD1
	for <lists+linux-nfs@lfdr.de>; Sat, 28 Sep 2024 17:03:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77A9C1F21C10
	for <lists+linux-nfs@lfdr.de>; Sat, 28 Sep 2024 15:03:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCCF817C8B;
	Sat, 28 Sep 2024 15:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LffDq6SP";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="JUO2vQ2J"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D8691DA23
	for <linux-nfs@vger.kernel.org>; Sat, 28 Sep 2024 15:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727535805; cv=fail; b=RKRcXWu4TPeHo7Dl6nlx5xlpVueyuTena3bTwJkuHoT9E85FbYviOHmAN/Hy4wpS2c+3EwdOnB5CIomw7B8zv7tUaQTaQIb8nx2BbdjKYQssxAwTZYjKabuRueUHSMB77BI8p/LwHFEmo761/RuhUX6TMWbWECeW/rZynvFiMhY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727535805; c=relaxed/simple;
	bh=MRJJvYvZhXwLoiyGnJS8uXTyU0Om/EymqbldbFId1Qw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=eRnr9QaS4tn+m6o6YnmJJskpOLg4VW2bT9RQlFaaBV93E9deNiEADwjb9+mZdGdoaeBeV9ksFGQu1Mgs/CVHmtfdicrb504Bcrw4ieUb33yKCWcSYZ7QIlQriPZURFoJk/tWOixG0iGTcCjR3vrLtj5ukgfJo5wy9+aiEQvF/H8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=LffDq6SP; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=JUO2vQ2J; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48SEUseE026236;
	Sat, 28 Sep 2024 15:03:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-id:content-transfer-encoding:mime-version;
	 s=corp-2023-11-20; bh=MRJJvYvZhXwLoiyGnJS8uXTyU0Om/EymqbldbFId1
	Qw=; b=LffDq6SP9TQTei6WFeYEz7m7jzZKIvmiED8wD8Y5rHsG/t4bCCbeI+nzN
	eSGYhLXgJ34BKOq0iImuX+Ams/m8GgRGde2XgBr2jFi8RYnoHx25OGtUXgnp2o+u
	jAkxud5upjgxIXpxKqq3F4S0m4mnkrV1Z2sp46NJaogGhNTlXfb2YNJRBVh4OTMe
	7zOGMiPqKL0d86tjlkPEoU2N3Qg29k4aT3r02AvEpjwog+UaKlsHz6uDqwE3uhZa
	tGeXvKdNLt2Pw/dZJsLH4/AkfzkjgWqBae3RDyhCrSnyz6Kwp0xX8MhNMgwJdX+7
	FlzxZggVafTaqDgRgoEGE9vr5k6PQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41x8d18hww-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 28 Sep 2024 15:03:04 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 48SAY7fk017336;
	Sat, 28 Sep 2024 15:03:03 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2042.outbound.protection.outlook.com [104.47.70.42])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 41x884k4a6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 28 Sep 2024 15:03:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xTsOMNrRUDun3NhSumqfVGUrQ6jmCpjTPSEL7HiGknLWjk5L5C9Xw8v/bHXAVLQwfdJGBkw8URdUVE7vLv9qR8qT1qa2MBtn0nzM902ZAxJCXq/fJY3XIdDq9qwZkK+Bv6Ub5r2l9ZOoKhnH58LMHN0leYD4KgwmJI3n5v2BE2uRyvt/glQXjPf5yy9M9G8+WdRDDg3NwHTxkn2ktbLfqJ9yk7OQQUPkdiDBVsfj1aD2tUeEjSjJM3mwRQ30nLVkM465i7qnsX6hQWxCCWDCYRolBDh2XcDsOJ/1LGOHEp/zInVOLRpQ0sMI89z/Xhb/kqJaPZZFVZbAHXHMi5sJlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MRJJvYvZhXwLoiyGnJS8uXTyU0Om/EymqbldbFId1Qw=;
 b=Yu0uOkzVproYuzy6GY84VlqRxtYHmZdj0lUnekO0hsf+1nhEircGKAooTxCblXO8Ua3WUX8BOvl2jQf0tnvEJN+07neCV8t6Jx413HI6asbwOI5pTG0ImTVrezzTWGPNpBy7wAt2HlwgRC1vpftJUe+k1EcgA6iht61ZT/T9Jl9wa+Mk+8zd+byjzQPgjqAHZGhk7czbi8MmY5xuvLoRJG2992AFbTyQCtRp8EQzxlH1tZgB1odHsazBr8v0Tc9D+GLmLlb453Sw+qBJnEuv6/pn6qczRNOIWuwYTzyve6kerA7f7nflDnShQwktXNymnmWA9zV7jpYy6a4tsIRcYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MRJJvYvZhXwLoiyGnJS8uXTyU0Om/EymqbldbFId1Qw=;
 b=JUO2vQ2JiXuqhlLhozPZ9ocTNSk3VDdQVrbY/A6GZ4ujLJfnD8md+ujP9B3gOwuFzh5IwTVX4MEnLHBJTJLvYpE+0rNNiq2CEcYfpMynVokvdgCQ6/UwLo9005rul7NPgGCFnJySnuv69QhVXKE1FcKCEC64wJ196YZrF0g0NSQ=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SN7PR10MB6450.namprd10.prod.outlook.com (2603:10b6:806:2a1::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.10; Sat, 28 Sep
 2024 15:02:59 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.8026.009; Sat, 28 Sep 2024
 15:02:59 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Neil Brown <neilb@suse.de>
CC: Anna Schumaker <anna@kernel.org>, Jeff Layton <jlayton@kernel.org>,
        Dan
 Carpenter <dan.carpenter@linaro.org>,
        Linux NFS Mailing List
	<linux-nfs@vger.kernel.org>,
        Dai Ngo <dai.ngo@oracle.com>, Tom Talpey
	<tom@talpey.com>,
        Olga Kornievskaia <okorniev@redhat.com>
Subject: Re: [PATCH] sunrpc: fix prog selection loop in svc_process_common
Thread-Topic: [PATCH] sunrpc: fix prog selection loop in svc_process_common
Thread-Index: AQHbDxyD7AbU9jo1CU2En3ZfZMV8ZrJoji8AgAB2ZACABEwrgA==
Date: Sat, 28 Sep 2024 15:02:59 +0000
Message-ID: <9347B5EE-1CD2-4FD6-BE32-3E14E1C50BEE@oracle.com>
References: <172724928945.17050.3126216882032780036@noble.neil.brown.name>
 <ZvQcZge2KfnfvQwC@tissot.1015granger.net>
 <172729951045.17050.17378763434329064607@noble.neil.brown.name>
In-Reply-To: <172729951045.17050.17378763434329064607@noble.neil.brown.name>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3776.700.51)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|SN7PR10MB6450:EE_
x-ms-office365-filtering-correlation-id: 4ff1ceed-a649-41bc-5fd2-08dcdfcea475
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?ZGVVZjYxN3Q3MWZZa0tlU2pmWHVyQWJBWUdQcEJtYXFqTlVQK0ZvRnlzZ0E3?=
 =?utf-8?B?WGNwL1RuNWMzSWZ6aVVtVmllZkFTTXdUOUd0Uy94amY2d0ZFSkRjdi9MUDB3?=
 =?utf-8?B?QTQrY1NRYnhmdHF5N0dnODByWjJiTlFXTHlQU1FNckV0MjBWNFpXSUpJUDFq?=
 =?utf-8?B?Y1Y1MWl0Q0NISWxBRVZuU3RvYzVPaFFnekpyMVJPc1Q2cW1NcXRqaWpUbEND?=
 =?utf-8?B?VmJUK29wL0duQmJ5TmpzT0xOZExtOUl6SnVJZmdKc2tiY2JmbDJRZVdGNFEx?=
 =?utf-8?B?YUIvRXpHSHllTnVVSlBwUEY0T1Y1Ymd1NDduUnJQdEluRGt6N2ozdnZLUlRD?=
 =?utf-8?B?SEx4bDJWd2tYUWJicFZWOHAyMWFCdE5udWV2WmZ2WWxsaVNqQityYkNZZitj?=
 =?utf-8?B?a3VKZ1VwTDZoVFhxQ2VkbXZaeWs1dUFNOStDek1Uc2NGc0xHZTB4dVdsM2Vy?=
 =?utf-8?B?VHkwcThPU09JeUk3ZkRVclJLVGQwNjh5UTVQUjNPNUVpT09rWmZ1Wm1JYlNx?=
 =?utf-8?B?d1J5emM3RmN2TkJiaWlORW1KWEs4dDl2QXZDUnpCSWUrYWFSNERxNThKQnVj?=
 =?utf-8?B?bS9mR21RWHN6MTkrOSswcEY0Q1l3allwekoveFd5b0t4M2ZJZVBmYkxGb2c1?=
 =?utf-8?B?ZkVHUWRtWkJQakpnemZVQ2lkcnVaTkh6S1ZjYjJsZExnY1lXeUNxdUVhNm1K?=
 =?utf-8?B?UmV2ZTExcVpCZ0w3cWZLL1p2eE8vM1IwOVRUQVpZa2VkOUhFb1lUbVRwN0lN?=
 =?utf-8?B?cmp5Uzlob0tLNlh2YXkrb05wZit5TEd3STZvcUVGZVdjVGI4eE5lVzljcC84?=
 =?utf-8?B?dFJoYUg0dThQOFZsa3JXSzZCREx6MFpJN3lHQVl2MDk5ajFacTk1NHUxSmgv?=
 =?utf-8?B?OEtkWjJSakZCVDFOa1FXMXR1K2R5L0V1WUdQakN6cW5mK25FRU56VkdhcnQx?=
 =?utf-8?B?S256TVhJREVaSmY1bWt0bDQrcENORTFyTUNKRllRVWRKQkxwV3ZINWsyUFdE?=
 =?utf-8?B?dmlTODZLUVZoNUhXcktyOFZWVE9tZVBHS0RJMG5tSUpaWlFaR1JsSXRDanRD?=
 =?utf-8?B?RjcrQ1ppdzlIUDlpTjZVZ0RIQmF2b2FhOUxNN3psZ3FOWEIwYkFJa3kzd2dZ?=
 =?utf-8?B?TEhjNXJ4MzQzVmxVTVhVSTUwZGZIZm1sa1FzdTdDMHcxSGduU0dySjdYQVhi?=
 =?utf-8?B?YkpEUEgyNzczY29yeFRpTnY0UXRBSGp2WGgwU2pxMVNJVTYwY0h3VHd2TU4r?=
 =?utf-8?B?ODh0SnFaR2gwamhMZnppRHdjVlh2S0JjZ3R6VzZlS2JoTXdScnZ6TTllaU1w?=
 =?utf-8?B?cDRQdm5WbzhvaTdOVFF1TmZPOVN0Y0RSSS82ZEJMMG44Umlib0FXL2w5VDlC?=
 =?utf-8?B?TUFQRUVKSFNEQWNiZkR0NVVEdXFmRFgvSWlJV3dOUUF3Y0F4NkE4Ukl5UGw4?=
 =?utf-8?B?OUJoQ1dOSVQvdTAwMjVKWnVQeHl1VmpYc1pDS01nNCtkVlZ0TUtQTGtoamVO?=
 =?utf-8?B?Y1d4Qk5OTUdBblFIV3d0OGwvREJFZHBmWXQzUXFBMDdIV1RzeU9HcDUyTzBX?=
 =?utf-8?B?NCtXRnQ2OVhEclNaV21ONDlvY1BVNFRWcmhnaDUzb1NXaVFkM0dlellza1Ev?=
 =?utf-8?B?T3NGKzViOWJmTG8xQmJzTkxUMFBlS1laay9IZktEZndiUUpwWGNsaG5hcU01?=
 =?utf-8?B?czhZRHAxQlRjbFF6TUI5S2xvK1VCV2c1ck5ueUxzb3pOWlZtZlVSYldHT3Z1?=
 =?utf-8?B?T21MRDV5RE5oVm92eEpSaTBUT0RIK25qeTFBVVNHaEUvQjJPb28wTWJJQUlG?=
 =?utf-8?B?cktVMlJ2eFgxMkUrTEVxMzhiMktISmZ6cnlaUEg0My9EZ0VUWlZwSnk4S1RQ?=
 =?utf-8?B?alpBd3RUbFB0MWMxNUtNUytuWjNOaG90cStnNnB4VzVZM2c9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Y1d4ekxuU0RVaDk5aS9DWVcvNURoQ1NuaGo4T3Q0eTB3WkhiVVc5MXQ2VTlu?=
 =?utf-8?B?ZXp4b1FmeVBaSzlaSHV5SUMzN3F3Q0psYk1JVXg3b2VpWWRhTVBJSmxvSTM0?=
 =?utf-8?B?aEwxZWswSHFnQVhuazRwNWJTTzJKU3lqbVIwSVBUS3N5dlFDdGdBdmtyZWE4?=
 =?utf-8?B?UENhTWk4MFEyN3hCdWlHMzB0eUFMTnJKdVMwN0NqOGpOK1YvS2xMYVVjQ3RI?=
 =?utf-8?B?clp3cE04d2VwQUxqVWVFd3VjemRxRTFhTzdsSmo5aTRKYkc4eHFTMHRoOXBh?=
 =?utf-8?B?N0gxUjRoc2lPazU3NUE4M1ZXeUpOSnNMaVVyMFg2YlNSYjRxUWtTZm84QkU0?=
 =?utf-8?B?Y2JVSkNtRDZwR2pRWDcyMll4cmNRbWtmNXI0NTkyWDdNZkRoQmNxWHNud1h5?=
 =?utf-8?B?dmdObWVXUW5uUVpHRmR6SXhxdVNRRXluYStqd1Q4QjBFRGpCSyt4UjZCVnk4?=
 =?utf-8?B?Rm9TTmE2UE5mL3ZQRXNiU014UEZyU0xXcjhTeG5hdFZvdFRNaGhKSmhlUjRG?=
 =?utf-8?B?elVQQWkwWHdzbFE4QjNiZXh1RmU0SXNTcGdncWh6U25KK2RDUlBVNllndTVZ?=
 =?utf-8?B?Y0cybTNVbDdCeEgyYzZGS1ZJMVFtTjIvSE1JNXZ5UXErc2lVUWI0cFpKMHZ3?=
 =?utf-8?B?VVFqeDQvVmlEckRMdS9VeUIzeVQyRDRzdXpaNzFlY3Z1dUN6NlVPNGlqRXRF?=
 =?utf-8?B?UnJCYndSMFpDS202bWZtajE4UjFaM0paODZ4Z2lZMVZrbnZ0aEtvay9CYW84?=
 =?utf-8?B?MnBDaGpLcFVxQ3lmbjVsa2MzY1JOWXk3RGVFRG9LNmlEYWFXWjhTekZXb1RJ?=
 =?utf-8?B?b1ErY0xzdmRHNDNNWnVxcmhXbEU3dVNkblZVUWRVZFVhQVh6WWtTQVRCM09u?=
 =?utf-8?B?czd0ZHJkVkZJcnEyZDlaRGRoQWdoQkxqbWlRUlA3U1hpeHZra0ovUm81bWtM?=
 =?utf-8?B?V0lkM3RMZi9YeTIvYnNFMTdVSjZoZ2lOR3FScUxFcGw5aTZndzBuSW9sUkZi?=
 =?utf-8?B?Z2o5SHUzWXo3VmxJdmoxTU56OFFheittaUhFZHg3eFRpbkpPRzBWU1c5MzRJ?=
 =?utf-8?B?SXNORG1sdFQ1UTZNdmJEUWJ4RkJsTWtSK3M0NWlnMTV3bDRhdU45U1hNekhs?=
 =?utf-8?B?cVZtaVZXM1lLNUtBYkxzam5FdmcvMUpFSXhabEU3Nnk4eVVpUENZWnB5NU9Z?=
 =?utf-8?B?SmloZG42QVZNblpNVWFjYU16UzJtZ0ROZERTNm9mSUQzazI1QXlPanhOVlFt?=
 =?utf-8?B?Z29STS9NTlA4eG0yS3NkNXpUdVFpRlhiUXRNTUNSbVU0bjBlV2pXZTJoeHhI?=
 =?utf-8?B?akh3c1JwRnBIZzUvYWw5YU9YUDFaUFR5RkpUWTJPaXlBTWExdWFYa0dlb3lu?=
 =?utf-8?B?eWJMeEk2UDRaSjUvdWNsbEo2VVNWc1o0bC83TXdFOGVlSWlsbEpQWVBsbERR?=
 =?utf-8?B?dnpwTXBmU3hRUngxZGNrRTBpQlJnZW84OVdWcUxSUWR2cS9tb01IQXppd09Z?=
 =?utf-8?B?dkh3OEpNdVpZWHBtTFZzTXByNTFkeDFIcGZ0NHNnV1VIVnJyVmQ2enU4SVVC?=
 =?utf-8?B?YUxyT0ZvN3ZiTFFac1JMS3h2NDI3OHJ5ZGhBWHE1SkZya2xuMEFmTGY1SFZH?=
 =?utf-8?B?N2ZMZ3NpTjhFdXF0dGxMbmEreFZCdjA5by8zNUVaWm5iR2lNREdQRUJjU1VP?=
 =?utf-8?B?SlYwVVBWUWNrS2xTZUtUaGxabUp2d1NOOHBmSGdjbTZaYXJLSy9TWnlGcy83?=
 =?utf-8?B?NW9KTCtYSEhrWDZkS0p1L0FnWWRxSWRTR01EaUhXUEJDTHRsMUtqckRxbURR?=
 =?utf-8?B?V2hkV0NydDJaSjFqSGluNDFjYmw2TDhBMlU1WWxVR2JBZXZIZ0hDQ3ZsaG5G?=
 =?utf-8?B?a1ZTUFd4ZHF3Kys4STBmbHFhbFFyd2VhWTJPaFRaYkxrWWl3Z3Fjd1dtOVRs?=
 =?utf-8?B?NkJ1ZzhGZHNvaUwrT2tTdmxWdkIvWkhveW5yNHVZeXVvS214OHVSUlp3T1J2?=
 =?utf-8?B?NlZFMDVic3ZzR21OcjlHWlI2UzJMUWJFbWdUcWpZdkNFbnlhOWI0cEtJZSsv?=
 =?utf-8?B?V3VFZ3p4dldRd1kyNHJTREs3ejdFRGpRdnFCKzlwd1ZwdllvRUYvQllrVHdQ?=
 =?utf-8?B?dUdwbjliSVQ4cDNSejBoL1pvQ2hBT09TTXBTRjlvNmhGaXovcm41djdkdHdn?=
 =?utf-8?B?WFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <940451291FC29D43AF2D6F069B60780C@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Q8KoWQQ+VnMS7njvC1NFDTApQ4DF2CdpmQELumxdAB2SAEWDm3SOYpWutAcS/yYpvVNaW8XcjjOy8wR1coMTCKtZs2MP2FGyihAaZIUXSbgWlucmroIjCJ+QTrcNGErfAdjFqYM5ho4K0ADdRK0+J8e1mKj5lWzWleQ/RMp/wbhRjw1dcntWyB0E/7KTTTNrWfXRr9RSk8m7kv2fkKz8wHk7/UbP4rvY5B6/qQUbikUkec0dknkQsmSfA2J7ovIL7x9xLk+fK/iY8rlxdQ/HAAZ0PB04tPyrDl4u5V9U43UulGQIM2HiIBTYPRXPIz/CAky6Gfx9K0Un12Ois0IcVzjbQjg9bXHtmcW8UfMzeQDrKq2ji1+WcNyg1DrSOeVra4CuwM8ZbiUKgY8f4sWTXO8On/V/krRLkn1LXtc1px6TuKrjA2G5hBKboBMqVXd0BIAqhH3fdjcTl8K8leFQxi8jjwCPPXIKIGEFrpzesD58/MxTvl3dWQnmgtQIMiYS4o0nWgdqnVDn5iBUggE5x/ulbn0qSxTJDNHpxxihklne+foIPZ6qUqHSOLbSXdEYbdQZl2K451vr74PkF3cpNIxhY2A1jnfUu0KzOaTHYR8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ff1ceed-a649-41bc-5fd2-08dcdfcea475
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2024 15:02:59.5158
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oS3zaaqjdCTOQUlOLns5FXTNItzWGXDda3YUhcju8k0IUZDKNTkpI/JCNOCMqGDNgRjCUOkqEaLJaaQcsH5fVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6450
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-28_09,2024-09-27_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 suspectscore=0
 bulkscore=0 malwarescore=0 mlxscore=0 mlxlogscore=526 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2408220000
 definitions=main-2409280114
X-Proofpoint-ORIG-GUID: y5drSCJl37lIyLfXpDh6uZDUFyAxiCii
X-Proofpoint-GUID: y5drSCJl37lIyLfXpDh6uZDUFyAxiCii

DQoNCj4gT24gU2VwIDI1LCAyMDI0LCBhdCA1OjI14oCvUE0sIE5laWxCcm93biA8bmVpbGJAc3Vz
ZS5kZT4gd3JvdGU6DQo+IA0KPiANCj4gW0kgZml4ZWQgRGFuJ3MgYWRkcmVzcyAtIHNvcnJ5IGFi
b3V0IHRoYXRdDQo+IA0KPiBPbiBUaHUsIDI2IFNlcCAyMDI0LCBDaHVjayBMZXZlciB3cm90ZToN
Cj4+IEhpIE5laWwgLQ0KPj4gDQo+PiBPbiBXZWQsIFNlcCAyNSwgMjAyNCBhdCAwNToyODowOVBN
ICsxMDAwLCBOZWlsQnJvd24gd3JvdGU6DQo+Pj4gDQo+Pj4gSWYgdGhlIHJxX3Byb2cgaXMgbm90
IGluIHRoZSBsaXN0IG9mIHByb2dyYW1zLCB0aGVuIHdlIHVzZSB0aGUgbGFzdA0KPj4+IHByb2dy
YW0gaW4gdGhlIGxpc3QgYW5kIHN1YnNlcXVlbnQgdGVzdHMgb24gJ3Byb2dwJyBiZWluZyBOVUxM
IGFyZQ0KPj4+IHVzZWxlc3MuDQo+PiANCj4+IFRoYXQncyB0aGUgbG9naWMgZXJyb3IsIGJ1dCB3
aGF0IGlzIHRoZSBvYnNlcnZlZCB1bmV4cGVjdGVkDQo+PiBiZWhhdmlvcj8NCj4gDQo+IFRoZSB1
bmV4cGVjdGVkIGJlaGF2aW91ciBpcyB0aGF0ICJpZiBycV9wcm9nIGlzIG5vdCBpbiB0aGUgbGlz
dCBvZg0KPiBwcm9ncmFtcywgdGhlbiB3ZSB1c2UgdGhlIGxhc3QgcHJvZ3JhbSBpbiB0aGUgbGlz
dCIuICBJc24ndCB0aGF0IGENCj4gYmVoYXZpb3VyPyAgU2hvdWxkIEkgYWRkIHRoYXQgIndlIGRv
bid0IGdldCB0aGUgZXhwZWN0ZWQNCj4gcnBjX3Byb2dfdW5hdmFpbCBlcnJvcj8NCg0KSSdtIHRo
aW5raW5nIG9mIHNvbWV0aGluZyB0aGF0IHdvdWxkIGNhdGNoIHRoZSBleWUgb2Ygc29tZQ0Kb3Zl
cndvcmtlZCBzdXBwb3J0IGVuZ2luZWVyIHdobyBtaWdodCBub3QgYmUgZGVlcGx5IGZhbWlsaWFy
DQp3aXRoIE5GUyBvciBSUEMuDQoNCkNsaWVudHMgd29uJ3Qgc2VlIFJQQ19QUk9HX1VOQVZBSUws
IGJ1dCB3aGF0IHdvdWxkIHRoZXkgc2VlDQppbnN0ZWFkPyBVbmRlciB3aGF0IGNvbmRpdGlvbnMg
d291bGQgdGhleSBzZWUgdGhpcyBtaXNiZWhhdmlvcj8NCg0KSXQncyBubyBiaWcgZGVhbCwgc2lu
Y2UgdGhpcyBidWcgd2lsbCBuZXZlciByZWFjaCBhIHN0YWJsZQ0Ka2VybmVsLiBJIHdhcyB0aGlu
a2luZyBvdXQgbG91ZCwgYW5kIGZvcmdvdCB0byBsYWJlbCB0aGUNCnJlbWFyayBhcyBzdWNoLg0K
DQoNCi0tDQpDaHVjayBMZXZlcg0KDQoNCg==

