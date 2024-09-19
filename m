Return-Path: <linux-nfs+bounces-6553-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C4DB97CAA5
	for <lists+linux-nfs@lfdr.de>; Thu, 19 Sep 2024 16:02:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A425C1C213F6
	for <lists+linux-nfs@lfdr.de>; Thu, 19 Sep 2024 14:02:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEF9F19DF67;
	Thu, 19 Sep 2024 14:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kxdKXSHQ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="K6dPmjWI"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3249619CD01;
	Thu, 19 Sep 2024 14:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726754563; cv=fail; b=g6mNnGWoVaBTarSfO7DhE7t+8q5SZLLtMI2AQgS37Rqb/wnz1BElHD2PnIKdHKHwiSgVvgq4vZyeIO8yWQw3ZE9QNF4+8+lUeXNzk6PlSpMWAPxRsqIcu1BLbTNhBaZurpZ7da2x1JzOHSFdvwXAKoDOpVOytAIdxcfnjac4KDQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726754563; c=relaxed/simple;
	bh=lSbksHSzE4CzoHHgmIbB0m6DLAwfziw+6IDgMlr7aVI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qOTUhDGEwNl4FhAlO2CqY4aVYHlc2MhvuRsGdcVkWgIHfzf/IW6oJBdcMq15805bEo/HEggMkflamhaHze78dLGbnfHOJVuC1Iz+kkMTjvY9VLp/66qQ6qZ6LvOzIXDFQGAkoxO72DCV1faj7yMzNJ0oe6JewtY6LM+7PFOJ/74=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=kxdKXSHQ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=K6dPmjWI; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48J7tXlU008059;
	Thu, 19 Sep 2024 14:02:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-id:content-transfer-encoding:mime-version;
	 s=corp-2023-11-20; bh=lSbksHSzE4CzoHHgmIbB0m6DLAwfziw+6IDgMlr7a
	VI=; b=kxdKXSHQRF1xMVonU7mz65xz7YMGWFbDEcSyBRS1Kg7QSV325MHDxnTtA
	MG8yELhbtQAu8XkwYLfgfNspEIet2AV1ZR3XEQD62KFVdgq9MNhC1eYR6jfNTyI8
	B3ro1ncBBr1CuZOnyITe5I2ZBYM0v9Ky5WHYzhuqcx75a2B/xyM1oZGAD1Gqp2/e
	BnMTuLXnSCPdSIh6+Hl0ciC/qhoH5Wnskyn/DwkhY+4hiTOm4lS39Ddm9Ci9uEbA
	g+EWckFdmAwePhHyDCJMBmLMN+LLNDQgCCgg5R7BlY4ebwbahXmhjFjlxgUOrBws
	sMCt1SAoGH3Xldbyg3oUCbk9/ZUYQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41n3sd4aby-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 19 Sep 2024 14:02:24 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 48JDP440040412;
	Thu, 19 Sep 2024 14:02:23 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2174.outbound.protection.outlook.com [104.47.59.174])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 41nydy40pr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 19 Sep 2024 14:02:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KNlQYuV2qIaDAZzfPky8eaVgwOOIcEnM49E0IX85V+AFd5w208qp+gZm+TbKaWojLQJv0MldEpQHTsTE9pb5m5hgI5T8mq/T7WsyXzQMf3i2LyPGyVxsW56UfJp4lJYzcRm4FYh2Pe65A5ksYs8fUzT4NC/Y/PKK7VNmsPnNyjzZL0B322XA+s4RxD+NGDMKytSYNI4Z+YHB1U+iu6jRVhhzF6Z5/MafG+N3tmX4WoJtC//nJdokRe2k6VU5fCgTjdsn9l/bFofBQdh30rnQrYtSiZfY+Xe4P+vH5zhuAMMxBZwrmcllLfbz51KDIWEMUvEmRsMIq4b5mpaecGgi2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lSbksHSzE4CzoHHgmIbB0m6DLAwfziw+6IDgMlr7aVI=;
 b=AfSUmpm5z7yHosOOvHSLk3zk6HG794eiCOBwpqgBs54kOO7Aam8ilDxXfFtl+ctWAnkpJrJA/N4dG4lEqcdM+eegtGw9s+XTfU97iR9sh/Avqq2j+EETAW6/If3ptDrincuz243O9m0jEtLtF0LMWVFVaIQZiPKjRHrJFBW9caeKR2EbafQUuDmt6D9brvfdV8i9Y+JdcvsQFBdAWSXLoDUHxYEcpe8NhenPjU41OdrdERIGDDSwJH4SZkT6OuiL6qfkU+mbzmZwgBnWAx0e88E3Dau/ZwbuVvUXsreYY/TVMwp84v3v1pWYVhbIMR9dwTXiZ1oTcmtOIdwQKvfBcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lSbksHSzE4CzoHHgmIbB0m6DLAwfziw+6IDgMlr7aVI=;
 b=K6dPmjWIFEAhaLXkVBQbzZSSdKyi2X5wcHc3MaUGo/8L+wvgq8c9z/bA3WfHLV0RPkPZqKcP6BiPlurAjLkEWrtAohAYsluMNXQzBuuNybKIqPH3SLvVXcrb1WThnsO9x2YqNU8DA96+CoyFWmzPFB2eS3csQoR/RVrzisuBeu0=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SN4PR10MB5621.namprd10.prod.outlook.com (2603:10b6:806:20f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.7; Thu, 19 Sep
 2024 14:02:19 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.8005.006; Thu, 19 Sep 2024
 14:02:19 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
CC: Jeff Layton <jlayton@kernel.org>, Neil Brown <neilb@suse.de>,
        Olga
 Kornievskaia <okorniev@redhat.com>, Dai Ngo <dai.ngo@oracle.com>,
        Tom Talpey
	<tom@talpey.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Linux
 Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Subject: Re: [PATCH v2] nfsd: prevent integer overflow in
 decode_cb_compound4res()
Thread-Topic: [PATCH v2] nfsd: prevent integer overflow in
 decode_cb_compound4res()
Thread-Index: AQHbCmuyuv9a1ihK+U29epThVrGY87JfJDAA
Date: Thu, 19 Sep 2024 14:02:19 +0000
Message-ID: <C185CD71-0AF6-4D83-AEE5-F8C87EEDE86B@oracle.com>
References: <ed14a180-56c8-40f2-acf7-26a787eb3769@suswa.mountain>
In-Reply-To: <ed14a180-56c8-40f2-acf7-26a787eb3769@suswa.mountain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3776.700.51)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|SN4PR10MB5621:EE_
x-ms-office365-filtering-correlation-id: d8cf3cdd-02ee-432a-98e6-08dcd8b3acff
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?cG81OHF6R3VaUHhwMkJLKzBQUjRpWGE1VDhwQnV3QW9LcmkwL21UZ21JdEN6?=
 =?utf-8?B?aHBDM0t3ZTFUWGJMWXdackZJVHpIRDR2TUtQU0tzWVIrcFZWamQrc0Y1czR1?=
 =?utf-8?B?czBVWW5DbXpHdGtBSnVxU0MvUnoxNnFxSnBQVjRGYkxIYXZlRGR6UW4vRGRN?=
 =?utf-8?B?aXhuL3crM1EzM0RQZXpaTzJoUnFJZXRRbnp1T09tNGZzeWo2YW0vWEo1MlIw?=
 =?utf-8?B?N01GQUJwT0lHaVRQRnR3WEVYcVJtR2NtQm9mVGZ6cldOeS9TRTU5S3N6UzdT?=
 =?utf-8?B?cHZ5ZlprNUh0TDFpWWNCNW42MG9DMk45RWJQS0VhQ0NiaUxzSXVlQXdCNFZY?=
 =?utf-8?B?MjNMYjdUWGZEZnRveUlTYXBJbEVnZjVVM09nTXU5bnJZTXRaOStNZ012NGVn?=
 =?utf-8?B?M0d2WWpzbjYvWVJ2MmNGbW0wa2lwT3B4aHNac3hSdHpRQ2pPL3lpRE1mUzhw?=
 =?utf-8?B?TnJJL2diMHo0VDBhZXpLZkV1cDBtRFJtejlRUTNBOTZrc2lUdHlMeHBXZ2Ni?=
 =?utf-8?B?b3lxdnJmZ3d4UnVuWHhoTEs5cThXek9MZ1h0RStFTVlNV0RYaEpDWDRMbG1U?=
 =?utf-8?B?UEdrb1dxTW81cENOUFFFdzVJL2tvd09GdGVseW9VeDBpakF4Q3BBQ0wySDFU?=
 =?utf-8?B?QXR3Zm5HaitLQy90UjdMTWxjZGN3bS82WlIvMHRoOWxZZmdNUEpVMVR4MXdk?=
 =?utf-8?B?dmZvcnBQQUNpZGFRM2lDeXg3cjNKckhmQjVHQTBxU3REL256dHBxanVsZGFZ?=
 =?utf-8?B?TGV3YTJCM0FLRllzRFFNYWVqcWdLSWcyTFE0WlNzVUszb0JZMzVRRzdRUjJV?=
 =?utf-8?B?Yyt5ajhsUUIyeUFTU1pXUFBVOG8weHM5c2dxdCtsanRiWVpvcTNFL1Z3RllL?=
 =?utf-8?B?TzJOaGV5SlV0Z1FXTkZ4Wjc1cnpkM3BERmViTWYzZ3NaL1BTeHJUenpWcVBO?=
 =?utf-8?B?VUswQWZGd1BKazlkczhnU2hMUWlRY3ZmSXlNNzNqZnlaakZLRjRuQzZ4bTk4?=
 =?utf-8?B?MkdtcGlWQmcrSndoNmZTdmFoSVZpRTUxQ0RTS1NCWTNJUVFCUkRiQkhZL0Uz?=
 =?utf-8?B?YXRrVGhwL0d3RCt3dzRwS0Q3UjdrUjJCcEVJeUMxSE9FV1Z6ZG9RTG9wQURy?=
 =?utf-8?B?U1pGKzJRd20wdXpsN3NlZGNIdGE3Y3VVdjljNXNDYUYxdEVzRkY1dnFBL1pu?=
 =?utf-8?B?K2tyWDJxZElRVDFjVkRnbjZ2dmlEMXJHeDNTcUEzcEUwVUdsM0lGeCtJcFlG?=
 =?utf-8?B?Z1NpRk9MNUpyQktZV1dlMHNlZHRtQ2F2WGVEcEthdVNRSm83Y3QyeFdvOERj?=
 =?utf-8?B?MWMwL2hualFqbzUzMk1WRDNJakFPYXMwdCtJSC9qZ3ZOalVlZmhHYk8vaU1i?=
 =?utf-8?B?ZVV1QTBCaUx6U3J0VlQ1aEYwN2xZMklTS0VUUmcvU2N2eFdCU2dEdjNVMHlw?=
 =?utf-8?B?MkNxVlJPYWFMeXpnNXo1U3FzK1Y4L0ZibW1wVnhENUZnU1NKbUVFY1ZKcy9F?=
 =?utf-8?B?cEhpM1VLb0hFL01oUk1iNnBWSDdGSllTZmZ5a0VucXZQVzZqYytnUWUxTHpj?=
 =?utf-8?B?cWprS3g2eUV2b3hQRUs5V1lZQldEUUhDRlRQNUMrMnEwSnYvT0k2UVlMWGZN?=
 =?utf-8?B?T0lVNktRc2MrcGlxZjhBTFVrTkZFeEc3a1FuT3JrMGxIU1l3WmZDNWg1anVV?=
 =?utf-8?B?ZUd6YklNdmxKNWh1dk1VdWlsSDVmZ08xQlhFV01qYmJYclJsM1BTblBXSkVj?=
 =?utf-8?B?dDAxd1lWTXZrUzlDdmV0dTRCamZiVEdGWU1WTFljUXl3VE1YK05jRzJqNm9D?=
 =?utf-8?B?N2xESm5MKzhUV1VwZEt5dz09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dUx4N1lXU21XTmRNd2FvQ2VZRXZsZFFnN3ZkYm9ybUR5MnQ0dkJOdTlydVJJ?=
 =?utf-8?B?aGlKYjRJeVNVZWdzRmxybzBOOS9aWlZmclRzY3BpSXhYckhCSzdic011RWJs?=
 =?utf-8?B?SVVCV1JVYUp1MytITHliOHBiQTF6N2w0aFc0eU9lUnhmbVVLVzRkKy9pRWEz?=
 =?utf-8?B?Ym1PSzRXbytNQUtTSjlFVUt5Ni9mSGE0WFk0ZTJtQzdhMWFRZWFSYnhCdWph?=
 =?utf-8?B?cnFETGFSc01FbzJrMkJxSFphYzhqV291YkZCOWR2NXJqUnZHTkVhS3R4aHVB?=
 =?utf-8?B?Z3EzanBTMTBaUGhRZnBncm9zSzBqV1RFaCt1aEhKL3NCV2g1K2ZRRU1aeXNC?=
 =?utf-8?B?bmJCMEp1bVdjcnVEc1padWZsZGpNY1NTNmJ4U0tuZ2pYMVVNRXI5K2JxQkdD?=
 =?utf-8?B?RExmV2daUVpnOUR3REsxTkxTVW9EMmdDVTBDaEVieHRQODVUQWR1K2VEZUZo?=
 =?utf-8?B?akpQTU5LQUFzZGF4ZlB4VWd0cjNZbTZWNEVSakcwY2laTHR5WVJGY3JBeG12?=
 =?utf-8?B?Z0N6U1VRR1ZJbitKQmdSYTd1MHY0bVdNeFRJYmExc25renNEZEVVL29Za014?=
 =?utf-8?B?UDNkcjlUM3YrZnpoVSthSXlhemN0NEsrdFNTeS9QVHpsUGw2d0lNTDBHK0Jm?=
 =?utf-8?B?WkxWbGVWMkVZaUZhUnFzdVdOdVNPanFudDVKWlY3T3hOQlhJTnlIcGlOSGRu?=
 =?utf-8?B?eEN5OGRuR1ZxS2VoYmNvcml2b0FWNDBOenJZV0QyZkhMVitMSGpSc0xISm9h?=
 =?utf-8?B?SHliYlF6UHc0eFlTclRRUzRlR28waEliZlVoUnJ3RndNZU1mUnlIVU9uYXZM?=
 =?utf-8?B?R2xJT2JTbHZHVEJxeTdxa2VBN3RJZ29RaDZCcStUQ1RzWERETDJtMXFJNDNj?=
 =?utf-8?B?VkZxQkFacjFXMW5XM2I4Z0VLYkFOMTd5K0VVT2c2cUdUR3dTQkh6U2wwUFZM?=
 =?utf-8?B?TThyR3kzR1MwY2V2MXB0dkd2RVdmdDZHU3JUVTE1eWs2S0xMYmNZaDJEdkt3?=
 =?utf-8?B?TkJNendjYndDNHlqVUhMeGRKSENiakJUMzRrblk1N2Y0SXZXQ294cVFFZCsr?=
 =?utf-8?B?S0RTMmM4NVgzREJiZWIranFOaXJRbnZ2aHgzdXErb0l2QWc0ck90QVhTa3J2?=
 =?utf-8?B?d2ZNbzRzaFB6Q0FhQWtHK295TmNLcndKTkRROWFVc3J2K2lYK1BzRUMxM3RY?=
 =?utf-8?B?ckpVakxHYlBDSGhNeU01VXgzdnNsUmJub0dBL0RFSGlSck5NYnVrcDV5bUpt?=
 =?utf-8?B?NmtwMDB1ZmZ0QlFjdng3Y2oyNnByNTJLVy9RRGFWL05UVEZ6WUg2TlREUHBj?=
 =?utf-8?B?WUdDR1d6RG9MWmVZN0JJVjVPZE8rOEtiSHIrbW9PZnJCRUtsdWloQmJKM1Vy?=
 =?utf-8?B?WU1GdnFwanRMY0wva09yUGpEdTBuZjRhV1V5Q2tYWnc4VTg4UWFlU3NQejI2?=
 =?utf-8?B?Zm5TbVFQbWZHS3h5anRwR1g0R0tBbzJYaklicjlVQzJrUlN0Y1E3TlprWGwv?=
 =?utf-8?B?QWxNSllBMFdCakgxQkhPR3NBcWUzK2RBRk12M09oaFc4WkcyMnh5U0JkS0lI?=
 =?utf-8?B?Y24xcGcxREs4bTRtZVErMnQ3SnNMSGgxRUt5ZkI0UzhWdjkvcGh1cTFaMWdJ?=
 =?utf-8?B?TW83bHZsQW1KeERpVU04Vld0K2ZWbUg2Wkc0RmVTbTBiekRwQnpiUmJ2YUta?=
 =?utf-8?B?V3RYRzJ5Nk1IMUhIUDZhN3pDSHA2ZE1Bbk9HSUtEbkN1S2NZSi9rUWZmUXZ4?=
 =?utf-8?B?dlM2M0UrdTk5NTJsYjlxZTNPdUplZFR5bVhnb3RaQ0dnaEhFRnl4b0RrUUVq?=
 =?utf-8?B?TUlVQURLdHgvb29mdTNONEpiWmtZUVBkKzROY25rTVJrR2x0MDE3ai9jc3VW?=
 =?utf-8?B?ek55b3B2SzdYSjllWW83VTFzWXR2SWhIS1YxblVtWUVzMmlLMXVqSy9WSHNM?=
 =?utf-8?B?TzBYMUh0NThKVjAvMmRSSjJDcCtCdGEyUjBzVVFpWnJGQ3gyNmcyaVJqZmpL?=
 =?utf-8?B?Y1NYKzJhTUo1WElNOWJ2UFAxV04zem1GQ0hXNnVmWlMzRW9OdHVYdytEWVBU?=
 =?utf-8?B?Vy9iMVdQaW42NXFlellJbVptZnFoUEhmemE3MmY0VlkwN3VLOVBOK0pjK2Yr?=
 =?utf-8?Q?eqJXIm6eKmQU8wGN9v1s1NyyQ?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D4C9D60C0AF74C4B9E3757F072A889AC@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	3tINXVjIdMaw70cnOy9QC89p7YAAPB7C5W8Df6apRGBGySAc14GEAF21n7alKmpJazsGbUNDitNCHAzUL6fBvCPE6hZR0koi73EwLZDkRMnswqFuMBAcHYLA/wZWlaB6BOk7+sQk/kUC3C23ArXSGVEsRHRJRmdrjoiTci9akhz2ttBIi7ZG7KYIu2LosIKghADvt2s5lRcJa/I0IoL20qbeKpj+f1He8XNAJOBxqkHuzy7+dmky1OWOSJvENnQV231X1j4oqQEiL/wxpkwuBDt4wBx27tGkLhrZ9DffZVTL4urBPnOLlKndjIbQweZjaVOfHjEBfCcuOer11mDrJ1O3Ub3nQ2lqCO3iWLV/MpIwY0faq7+8/aOZwoiHaAJ0JO/8Cx+BXHZLhIyG3hL38vBrlKQ/j6oo77NX0vITubV9IZEUyMfegpaVXaoXr9iz8ub4hTwqZhF3wcL0ODtgGHBZBT7QKlRZpAcvkbazFgqSZmMBcDeE485QyJwHIYzXyE8blnTANsSnRsK6L702naP2drOJxgdsIZc1SEoiHKXjvjE4kHi/miyo9/3Xw9xWkb8DHxyijVqz0iYvVcj4QaR1YR9ph6bOBatOAC0Uwj0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8cf3cdd-02ee-432a-98e6-08dcd8b3acff
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2024 14:02:19.2860
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cH5tq9KWhS5nJNdNY+S9t5Jkj4qTDqqgcg8l1KdAMMNvAGOxST+19dJmxX+Zu7M3a/PvNv0/CwmIeQD3O8vqgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR10MB5621
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-19_10,2024-09-19_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 adultscore=0
 mlxlogscore=999 suspectscore=0 malwarescore=0 spamscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2408220000
 definitions=main-2409190092
X-Proofpoint-ORIG-GUID: 42snHeQemsehvVrBWzrjOqtSXne6IKVD
X-Proofpoint-GUID: 42snHeQemsehvVrBWzrjOqtSXne6IKVD

DQoNCj4gT24gU2VwIDE5LCAyMDI0LCBhdCAxOjEy4oCvQU0sIERhbiBDYXJwZW50ZXIgPGRhbi5j
YXJwZW50ZXJAbGluYXJvLm9yZz4gd3JvdGU6DQo+IA0KPiBJZiAibGVuZ3RoIiBpcyA+PSBVMzJf
TUFYIC0gMyB0aGVuIHRoZSAibGVuZ3RoICsgNCIgYWRkaXRpb24gY2FuIHJlc3VsdA0KPiBpbiBh
biBpbnRlZ2VyIG92ZXJmbG93LiAgVGhlIGltcGFjdCBvZiB0aGlzIGJ1ZyBpcyBub3QgdG90YWxs
eSBjbGVhciB0bw0KPiBtZSwgYnV0IGl0J3Mgc2FmZXIgdG8gbm90IGFsbG93IHRoZSBpbnRlZ2Vy
IG92ZXJmbG93Lg0KPiANCj4gQ2hlY2sgdGhhdCAibGVuZ3RoIiBpcyB2YWxpZCByaWdodCBhd2F5
IGJlZm9yZSBkb2luZyBhbnkgbWF0aC4NCj4gDQo+IEZpeGVzOiAxZGExNzdlNGMzZjQgKCJMaW51
eC0yLjYuMTItcmMyIikNCj4gU2lnbmVkLW9mZi1ieTogRGFuIENhcnBlbnRlciA8ZGFuLmNhcnBl
bnRlckBsaW5hcm8ub3JnPg0KPiAtLS0NCj4gdjI6IENoZWNrIHRoYXQgImxlbiIgaXMgdmFsaWQg
aW5zdGVhZCBvZiBqdXN0IGNoZWNraW5nIGZvciBpbnRlZ2VyDQo+ICAgIG92ZXJmbG93cy4NCj4g
DQo+IGZzL25mc2QvbmZzNGNhbGxiYWNrLmMgfCAyICsrDQo+IDEgZmlsZSBjaGFuZ2VkLCAyIGlu
c2VydGlvbnMoKykNCj4gDQo+IGRpZmYgLS1naXQgYS9mcy9uZnNkL25mczRjYWxsYmFjay5jIGIv
ZnMvbmZzZC9uZnM0Y2FsbGJhY2suYw0KPiBpbmRleCA0M2I4MzIwYzgyNTUuLjBmNWI3YjZmYmE3
NCAxMDA2NDQNCj4gLS0tIGEvZnMvbmZzZC9uZnM0Y2FsbGJhY2suYw0KPiArKysgYi9mcy9uZnNk
L25mczRjYWxsYmFjay5jDQo+IEBAIC0zMTcsNiArMzE3LDggQEAgc3RhdGljIGludCBkZWNvZGVf
Y2JfY29tcG91bmQ0cmVzKHN0cnVjdCB4ZHJfc3RyZWFtICp4ZHIsDQo+IGhkci0+c3RhdHVzID0g
YmUzMl90b19jcHVwKHArKyk7DQo+IC8qIElnbm9yZSB0aGUgdGFnICovDQo+IGxlbmd0aCA9IGJl
MzJfdG9fY3B1cChwKyspOw0KPiArIGlmICh1bmxpa2VseShsZW5ndGggPiB4ZHItPmJ1Zi0+bGVu
KSkNCj4gKyBnb3RvIG91dF9vdmVyZmxvdzsNCj4gcCA9IHhkcl9pbmxpbmVfZGVjb2RlKHhkciwg
bGVuZ3RoICsgNCk7DQo+IGlmICh1bmxpa2VseShwID09IE5VTEwpKQ0KPiBnb3RvIG91dF9vdmVy
ZmxvdzsNCj4gLS0gDQo+IDIuMzQuMQ0KPiANCg0KSGkgRGFuLCBJJ3ZlIGFscmVhZHkgZ29uZSB3
aXRoDQoNCmh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LW5mcy8xNzI2NTg5NzIzNzEuMjQ1
NC4xNTcxNTM4Mzc5MjM4NjQwNDU0My5zdGdpdEBvcmFjbGUtMTAyLmNodWNrLmxldmVyLm9yYWNs
ZS5jb20ubmZzdjQuZGV2L1QvI3UNCg0KTGV0IG1lIGtub3cgaWYgdGhhdCBkb2Vzbid0IG1ha2Ug
c2Vuc2UuDQoNCi0tDQpDaHVjayBMZXZlcg0KDQoNCg==

