Return-Path: <linux-nfs+bounces-11717-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A9CBBAB6A75
	for <lists+linux-nfs@lfdr.de>; Wed, 14 May 2025 13:46:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D17243ADA18
	for <lists+linux-nfs@lfdr.de>; Wed, 14 May 2025 11:46:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33D3D2253FB;
	Wed, 14 May 2025 11:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="l7TD46fz";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Szcj7Q0N"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E1FA4B5AE
	for <linux-nfs@vger.kernel.org>; Wed, 14 May 2025 11:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747223194; cv=fail; b=CI4/9yA3Hj923vVuwd59/9EZgDAoy2/beC/AvyBgv3xUH7abwIPGR0LfVsZZEfclK1qSmQyrzdM37rVSsXtWnRTm5NGaWW3tbu1o8IidzhJC/eAtNrFR63CIvx5dJjByTtuc9gcjX1PwE88krK6/7sZHTd/jVAoKIKtlUDdKSi4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747223194; c=relaxed/simple;
	bh=dw/9FkGr+5efLahM8xA6vJlNrRw0L7xRoxtinikhxK8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=aoF2JJCD6cOtQD+gIC7xn4fNM9JXInXIBbw0wXk32dpTsN78TF8USKIxSuPNUV5sVe3rWglk8C6p8udjFlfD26e+R6u+XocbynHEtJ6W0DPfEXvd67iG/OmamfczjIdAnCpae98s7YsL3lOiWEYRJSirYYeG5Lj1Y57zhJ7whu0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=l7TD46fz; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Szcj7Q0N; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54EAC4Sh016086;
	Wed, 14 May 2025 11:46:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=HvX507P9KtACdeWle0UkBLgNohH1/59ieGv2u6S6Lm4=; b=
	l7TD46fz7QNK3Mn5cUICwH6FRJXyiFP8z+8F+O0Ni6370hn7rCTUNOxyZo6krHiC
	kqCFaQRLZ2sb9o6zwheuZRXVBzhG47gyJ3ZPtqD/NejxpGPOmZ2dw6Bu7HN/m6CM
	adAAvdiA0rxTp2Nb3898H1BIUCLpWHh5dny9BCIvBNyDE5t/nokc2gCdtsAnYPO2
	6cuqoe+gtayjLOJqwMCsOxYMSEzVFYaL20hoGBQn1Oq+hOQhe0RcnxLad8mayDXQ
	nzCcNTMHapANU9AzfPX6wIToNCQgllL1hPanx5zYylZJO76Z9ubiUBi8wWEkKh/+
	G9oUavjPR9b+BEjumXTUJw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46ms7br5qk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 14 May 2025 11:46:28 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54E9nPYS016323;
	Wed, 14 May 2025 11:46:23 GMT
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazlp17010003.outbound.protection.outlook.com [40.93.1.3])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 46mc33aqda-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 14 May 2025 11:46:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jfZPtXi50+VXwaT4wI2YmBRRZgR53uLySF0w/WPi/Tcv3zvOWRyl7jfI2YuhJwlUPhAeEpuS9hC/dpyVSxObdsgwvpAppOg4ZsySRAnrq4wTGFKywZOT/YZ5jqOETm1JX9/hpgxyIix2hSo2aJvyaEUbEsqv1vHqRrxGlEgevGQH0mPpiFZdagNKKWIZbG3BRwG3JlI03PyRKPeEk3yqy7G7jTXsg9bK2mOKjMQw627J16qAX/D8xEM54hp2VAPISycOLmAHNulPfaP2SpFQ9Z9gNHUPga8p+X2pZoSK6tuDTzuJhUA3K82GzI+zzpfqjSvzJUKRZUWxN3t22J+D2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HvX507P9KtACdeWle0UkBLgNohH1/59ieGv2u6S6Lm4=;
 b=yLXmBiwFz55QzvFVK36w50OpgND4iDW4GNiNGk4mjZxAHTR/glqrDoZEfnf3MmLeFYVvd5apOVsQoWPVsR/Ul9Lszlf9aJycfisvXHLsU1frORA3t3qu+7ZCHsZ1r/t44v8iWEfylopjbEilgZyukwj+ASJ8M1fD+YAeG7RKTVIvYdVcWUGtTXBBea2vTeUH4fY86BuTyJUYLVS9q7hllGQw4DH0P4KM6cTt/bXlSgeEdwlQJmMgy/bz/PVTBgyd8HHVqWuUqan/CndopqVpmxXGbM8WTxAkQ8L/70e2zWgrkoLyrOV489YjhCXG86oUUPQgtix+8UbdkP050AtDpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HvX507P9KtACdeWle0UkBLgNohH1/59ieGv2u6S6Lm4=;
 b=Szcj7Q0NRJTAY7N4MR+EYe/xtB7fUp0RHKBbCc3kfGAkvwj2nHedZFmrqbCovHF34vHoqiI4+mrfR+eCxbA7s9fsJF2M0SwLcVKV+G+0LfNm8J9q3HH4s3nA3Yu/uZ9zVGtrXCfRE+xQb8ALdUxPRnCRAJCfQP4I8gnL+m4Dq1s=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BL3PR10MB6113.namprd10.prod.outlook.com (2603:10b6:208:3b8::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.28; Wed, 14 May
 2025 11:46:20 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%5]) with mapi id 15.20.8699.022; Wed, 14 May 2025
 11:46:20 +0000
Message-ID: <7870a1cf-a014-447d-948e-309dcbc705a8@oracle.com>
Date: Wed, 14 May 2025 07:46:18 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH nfs-utils] exportfs: make "insecure" the default for all
 exports
To: NeilBrown <neil@brown.name>, Jeff Layton <jlayton@kernel.org>
Cc: Steve Dickson <steved@redhat.com>, Tom Haynes <loghyr@gmail.com>,
        linux-nfs@vger.kernel.org
References: <20250513-master-v1-1-e845fe412715@kernel.org>
 <174718900620.62796.18240600261000060825@noble.neil.brown.name>
 <174718970409.62796.16127055429561662161@noble.neil.brown.name>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <174718970409.62796.16127055429561662161@noble.neil.brown.name>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CY5PR15CA0021.namprd15.prod.outlook.com
 (2603:10b6:930:14::26) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|BL3PR10MB6113:EE_
X-MS-Office365-Filtering-Correlation-Id: 4619c028-ee3a-44f1-dfe8-08dd92dcf1bf
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?UElQOXNCRXZML2cyM2xVcENXaTR3VzVJejZlbnhERjBGdnphT1ZMTXE5NDRJ?=
 =?utf-8?B?YjJWTURNYjQ5QjFEcTBtTzRTSzNhZjIwWXV3VW1jRHJMNEY4bjJuYWc0d1Vv?=
 =?utf-8?B?SjV0R001U3FHM0hnRk0wOEtnZXRSMmRrUk91WStIMWRvaEdicWJuekZRd1ox?=
 =?utf-8?B?MWdnOC9USklPZjM0NU1SeGg3UTdsOU55bXQwRGNzVUU2SmtPKzR3VHQxUklN?=
 =?utf-8?B?RmF1QTA2NXR2TUdVU3pnMk5KZ21Ic05tdGhDVmhaVk1leUZweXp1Mi9RNzky?=
 =?utf-8?B?alpaK2RXSk1hZjM3S1g3L2g3c1BZTGI3MGh5TzB5TnVjdmhtaStJZ2xUT0lI?=
 =?utf-8?B?KzU1OFhad0JNVnZFNjZIZXVpcStiZlRNYjMyUkpnTGM1c0VCSWtwS2hhTDNJ?=
 =?utf-8?B?a0RDUGkwQWxQUTJmTjBVemxWOGJPdnpROCtvTzczbTg0S3FMUDVJKzN0dlIy?=
 =?utf-8?B?TW1zMEY4UFdKQkkvOUhkVm9aQ05YSFk1VXpvNmc0bTlXVFBvRXc1Y3paOGRO?=
 =?utf-8?B?NktXSDNqTHZzODVnS25xUTFSenljMFp6ZlFocGpvRmwwNHZZcHJaT0JWcGRM?=
 =?utf-8?B?dFEwZHZhS3VORDB3Y1kvVjVEU2phT2lPRDdKZzc1V2tVY1RSUnJnZTlROGhJ?=
 =?utf-8?B?dDdCcXoyU1Vna3JVSHBUYkJUSkVrVkpueGZMVk83YnpRN0pJT3hzaUx4OE1E?=
 =?utf-8?B?c1NBQWtvWmtZMzlJamFNbTBTVTNxeDh0L0dGdTZVVkJhM3NBM3lyNjFuMURN?=
 =?utf-8?B?V1RLRXY0V0paR1p2b0lNeGhDR0lkZ0lybVRUMW1MbVJNRmpRaGRLNExDWnhW?=
 =?utf-8?B?Zlgzb1JjazBNY2pyTVNNdTMzMElTbUIwKzd2ZUg4aU94RVZSYWFmQjZkNWxn?=
 =?utf-8?B?VFVFNXZVK2xhMUMzNk5iY0t4ZmhUcVV5K1YvY3VCS09JYm92STkvZTNOaE5G?=
 =?utf-8?B?d1FHUHE1VWFlTS9Bb0RVTUFBemgxK1M1UGZJT0Q2ZzlMbUczbXRaY01zUUo2?=
 =?utf-8?B?ZWV6czZWeXpXL0ZzeEtRcGFzT1JQQW1TSzNqS01QRVFpdjM1SDJGemx2SytD?=
 =?utf-8?B?M0ExQm14WGt3dldNVDkvNVFKY3B5dTlYNWJPQU5zeUtKZW02b3R0MmtXbnlq?=
 =?utf-8?B?Sk85S1FrRFBFckdGK3FCOCs0MHhkNm44UG5OWjFMM3pOYVlBb2dlQUFXWXhk?=
 =?utf-8?B?KzdRcHFvNm1oTG02RHZiZTNNYUlhZktwNnFWNXdaMmltS0gvcWs3eXdNRVRS?=
 =?utf-8?B?QmRxaitUMVJZcjd1b2FGUHh4enJaY0VoNkh4ZGJYVkRTNkR6VHpsb2RyUU44?=
 =?utf-8?B?RnpZbzdmb2JnZjdrcTA3dUtLTGJmUDZSTHBRYW1qVEN0c284eXJiNE5pTUFK?=
 =?utf-8?B?KzRIVjBoS2tlZHBMeGFUd05UZFo5MEx1R2lacThiMllVOXdUWGE3TFMwWlV6?=
 =?utf-8?B?Q0xzbkkzY0VBOGR5L0hUaHFLQUc2VGVrVGNNMTlTekhxVEliTmRLd1RnenhV?=
 =?utf-8?B?amNjVXZ1b0ZLSVMwUTBaa0t2R2hHRlFoRFp5ZzNJVzR4TnVQbkdncEtmdU5o?=
 =?utf-8?B?S0RUVFR0bkc0UmFhUWhGRW55L3VpcWdMcndSM0J4eFphdEhPSUpOeEdXTnRl?=
 =?utf-8?B?QXNuRXpNSXdTNG1KVlcrcllSeDVIYk5IWHRaSS9UUHlJRnpmSUxzdkw0eUps?=
 =?utf-8?B?ZWRZV1BQc3RqNWM1R04vakErRnNqMmh2RW82L1hyOFdROGtUUWNHZStOc1R0?=
 =?utf-8?B?SEg2bXR4YzAzR3p5YjRXcXJqa2N6eG5sR2llOXBqcTJ0NzlWQ2pMMG5LN0Jn?=
 =?utf-8?B?QnNQWFZNYk9XMW13YVNIYkxCMG40dGd2MnFmVThVTXNkMVRVNGtLeGxGdkNM?=
 =?utf-8?B?ZFlla3k1UkhnajBrVkQ2WkpEUmRpNXZDMEVxTWxzMUZIbzBQbmNlNDNvUmFx?=
 =?utf-8?Q?V2YLiG9jVHI=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?VHJ5M1czbG1QZzhQVlVtRXc1RU1IYXBETFlPT0N0VGNERm1Xb2ZsT0ZkS1Ur?=
 =?utf-8?B?a1JqSlU5YXM5bDBndHlaSDlpVmp2d1pYajFJUVN2YWFxYlcwMEVsWkMydXFz?=
 =?utf-8?B?WUx0RjNvM0lKWlEvR3d5ZldCcjVXWG9QMElkQUZQSVZqMkNOaWV6b0JtT3pS?=
 =?utf-8?B?UDFoN1VmL0txc2Nac0VsVzl2QUlBTmUyUFFudy91cmROMm9TNldycXpwUmRY?=
 =?utf-8?B?TGpWbUpBQkN5MDltUU5wY1JETjRVeHpDWmtOeDhJNXBBVTRTaVlMNkZ4bktr?=
 =?utf-8?B?b0l5MDVibWJLeGd5bkUyL2dRRDBBNHg0YXdVRXd5cHk3OGxOdTI5TDJPNHRW?=
 =?utf-8?B?cTMxLzMzbGhvMHhFaEwzR0ovL3BtcG5aVW41c0J1R3lIdEt4VStablVYL1ll?=
 =?utf-8?B?TkdoaEZvek1XRVdWZU83aDN4eWFWOTJyYVE4ZXZBTEtlMW1vWXg0ZVFicFVR?=
 =?utf-8?B?Tm1uNXBlYUZjQUNwWHhuZWNLNERKeGRreTd1MzZoL1VabnpvWEFwVkZ1V3Bn?=
 =?utf-8?B?NjYraGxtbnFMZjZpWjRtNVJLYXJVZHV5cysxcGRHQTBqWUVQa3pERFVuazVS?=
 =?utf-8?B?OElTTmo0T2o5ZFJiemhvV1M5ckQzdkhwdWcyayt5dVE5YWJzaHYwZktkdHpi?=
 =?utf-8?B?eXRsbG5TOWZEUWdLR3JwU2drd3ZWcDVRMVBnTVJMaHlHdk1qS2dWSnhYanFU?=
 =?utf-8?B?dk5JbVhReEI3MVZmMlNWUlE5K0w1dWo4OWJTdWRDK2dTWkVzNmNyZloyZWxr?=
 =?utf-8?B?cUwzZ0JQa2l6TzJIR2tOTXBOazRGdEo4bE5YS2dzb01MWElHc2pVem1Gakgy?=
 =?utf-8?B?b0M5azlvOXp0K2lTbS9oN1l2VkhwckJXdW90QUo1RDJicGFpZDJKT2I0ckdD?=
 =?utf-8?B?VWhWV01IQm5rT2xlamlmK2oxN1NrVkNZSldGNDZBTUkzUkwyNlUvL2d5N3kw?=
 =?utf-8?B?bGFacEN5c1JQbjVkVmNsT3d4THI4SHBFVTVENkVkVUs5ZXZvOTFtLzBFVXFp?=
 =?utf-8?B?aUZXYXF4TnByaCtUcDliTENOd0JkYStQT2RJUis0K29BV3dzSE1iaWhQREhK?=
 =?utf-8?B?bElCVUo3bWtJZEdKK3MxdmFWdy95Tnhpc1hvaVY5Y2JnYndiS0NkOXk4UlVw?=
 =?utf-8?B?M0t3RFZOajhITll3WHI3YkV3QkllNlFDUHl2T0ZiY3RlTTllTmk5UUlTTnc5?=
 =?utf-8?B?czJPSmtISXpOa1pCNEZkQXBobGV1WlR3YzdJR3FBRnErcGVmRGlmM1JpdFBZ?=
 =?utf-8?B?ZU54YlpUQVphZFdLYU9oa3I1TGRQL1BxNm5yMlZTenU1VCswYWk4bENxM0dZ?=
 =?utf-8?B?ZkVuZXdLVkk5QWV3Ri9HRmNNSTBOSmZ3dEtFYlovRE5rb1hQMUtYS1hWakpP?=
 =?utf-8?B?aDJzZGNteXhCL2N5WktkRzVXSllQZzZzMS9qazdDUjlLMjg3MGlYaGp1amxY?=
 =?utf-8?B?dmxWUEFBSFpDdU1jYjhPU0dWWWdKQ3p2SW9POXJPTlZuKytZN0dldjYrY293?=
 =?utf-8?B?S1dOQXRLQnc1SldQaEFIRTZxV2dwdWs3SEgrRmJRbGMzM2IwckRNbVBLRll0?=
 =?utf-8?B?WmU5MmhmekxTTkRBZVNYelFFWFM0ZUpoL0g4R3BoWUUzYWJFcWg0bXo3MElQ?=
 =?utf-8?B?dmRhaE5OVnpiQmJHWjlFU0FkN2VYY1ZhOGYvdUJBVllIeXh5SVZQUmhVNFZB?=
 =?utf-8?B?Z0R6SnhJSnJNeVFYcTFFZ2ZWcVY2eE0zcjNZbldkeHE3R3gzcmxBY0FWcnZs?=
 =?utf-8?B?NW1kb3VBa3VIcGlONVdreVh5SUx3N2NlTkRzTHF5RGlIaDhwbnFWRWREc0J6?=
 =?utf-8?B?RmZjTnQ2eVoxUUVpblRnZVZxb3pibVJreTlWT0g3dkJuZVZUU1h5NS9JYW1G?=
 =?utf-8?B?RHkzY0lSWEp0N3A5TlM1WllGWVQ0K2hyREFVNTNobUdicDN1S2s4SUNxcWV6?=
 =?utf-8?B?a0cxOXFkeTdCQUU0UDViakU0WFpJWGwxVE45RUZKa2tUM1B1bTM1UDZLQXhz?=
 =?utf-8?B?d3d5RzY5TlgvMXRxMUxmTk5pTDd3MVR3OG1qUFJSOWMxaWtVQ3FyUUNXOEpV?=
 =?utf-8?B?amRxQld1R3A2UjlCckJ6cCtUZDhCMkZaVk82U2R6L0I1RjBKdDdrME9zdW05?=
 =?utf-8?B?K2lKWGNYOXE4U3IyZmd2TlV6Y2xSVlZjbGNGdzBrckR0RmgzTTJKenlDYXEv?=
 =?utf-8?B?QkE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	CuW702XvytAyrH3ZyyHwVzFGni0r07cAr4agUJWaR5GicvS94T2xjHA8ocDf65CTegjn2luLYdixSwEVAH0N4mJLREapOt9p/z/ajw2yUHN6ACb7V85Tv7Yzyq/seFoJMsw9ggEzTlOLhz9Wg81mBDJbZHkAvKvCFo2OYYqSvHHVDdKSOaruqhMx13cLk7RLA0hAl37nhGKOZ82uUdvPkfIlM6kCGh+ui6o3sDFGBTkJRwTQo9pr+lDqOWGhYLdtRZWMnRU0PUYiiHo1qOwEqyx8mgwnLogp+LXLPFpI7ct/NSF1vMaeoKhsOBpnB+cQQPfq1yf41KpjbC1ug55x3KSFwXrtBcAzx8lgwNXOpp8C2hQdjaxVeJLaW2RxbUV1Y70ubWypqxR0WtdizvnYcUPn9rZ6GhWeAg7ttqD41utb7tqZ1LOoVwFbi4qnGV+QOV5GXiR8s1pg5EBOJX2wx8F/Mvz0EGkoPPdDp762sDEdsQdiJGovDJc9UelHOVwGIqckk1gehPYKdhcR9jN/ykGqDn7QPTxGaAAqirY4VFKbKWoOpzqkcXNULxmMwZYqHI6u8p2ifFlYBE/ob+s3zLZXqOPljWDJjeLTUAUW0tY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4619c028-ee3a-44f1-dfe8-08dd92dcf1bf
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2025 11:46:20.4940
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pKKCXmJcb7fzLKmsBYFnZ7kcD2IHDm3kKoQCoR2elwgKV3siyt2SARCZ9ooXPZkeh8NThV3d3ckHUbmRru6ONQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6113
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-14_04,2025-05-14_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0 spamscore=0
 malwarescore=0 phishscore=0 suspectscore=0 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505070000
 definitions=main-2505140103
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE0MDEwNCBTYWx0ZWRfX8zMoC1+21sc9 KNEhrzitmRCVh4JoWoiPEx64tucOKiIsKhBZrXoqODEe0khzM/k/pKhpoLohPCl7p2CqYA/14nT S1Fgy8FdxtlCYuGXBCTmYWwOlTQqoHfQolE/w4ZgL4QDOR+0pLKER9aLKPWYaIkpHvFJG4SN9sk
 uxfoX5KzJ/AnV1uyMUtwxauRWIHVIbnRCAGvEbSLPoZnRiFOwBlVYEiNsxWxNx/+rl98/2yptNO dvR4dlonovIxg93wbolycadtyKfZveAtHxHeMRZwT0FhlrKkquWGoTMr9JKqXQjt/w+/JOgynVy 8lH6LuXavqHkUm7jq6tyFHPISLQ3yfOdeNdVr79zIpZeBCmfkVTtWLyRaeWRulWo8qoLj3Pp96h
 4ozZXSq7k2huC3gtE2y0rd0k8L7pPOLvorP8kFimQNOQRzJYkWBIbZf+Wl/LnqQdciJc5r8I
X-Proofpoint-ORIG-GUID: lV179iBQ_NjK8jO5UOv-8kWHNiNlmbfQ
X-Proofpoint-GUID: lV179iBQ_NjK8jO5UOv-8kWHNiNlmbfQ
X-Authority-Analysis: v=2.4 cv=P846hjAu c=1 sm=1 tr=0 ts=68248294 b=1 cx=c_pps a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=zfLX3wCb_2uOyOJKgKsA:9 a=QEXdDO2ut3YA:10 cc=ntf awl=host:13186

On 5/13/25 10:28 PM, NeilBrown wrote:
> On Wed, 14 May 2025, NeilBrown wrote:
>> On Tue, 13 May 2025, Jeff Layton wrote:
>>> Back in the 80's someone thought it was a good idea to carve out a set
>>> of ports that only privileged users could use. When NFS was originally
>>> conceived, Sun made its server require that clients use low ports.
>>> Since Linux was following suit with Sun in those days, exportfs has
>>> always defaulted to requiring connections from low ports.
>>>
>>> These days, anyone can be root on their laptop, so limiting connections
>>> to low source ports is of little value.
>>
>> But who is going to export any filesystem to their laptop?
>>
>>>
>>> Make the default be "insecure" when creating exports.
>>
>> So you want to break lots of configurations that are working perfectly
>> well?
> 
> Sorry - I was wrong.  You aren't breaking working configurations, but
> you are removing a protection that people might be expecting.  It might
> not be much protection, but it is not zero.

I beg to differ. It really is no protection at all in the modern era,
and it is actively inconvenient for deployments with desktop file
browsers or NAT routers.

As a community we should be encouraging secure deployments out of the
shrink wrap. Making cryptographic security easy should be (and is for
me) job number one. This export option is nothing more than theater.

I agree that a warning would be useful if neither "secure" nor
"insecure" is specified for an export.


>> I don't see any really motivation for this change.  Could you provide it
>> please?
> 
> Or to put it another way: who benefits?
> 
> Thanks,
> NeilBrown
> 
> 
>>
>> Thanks,
>> NeilBrown
>>
>>>
>>> Signed-off-by: Jeff Layton <jlayton@kernel.org>
>>> ---
>>> In discussion at the Bake-a-thon, we decided to just go for making
>>> "insecure" the default for all exports.
>>> ---
>>>  support/nfs/exports.c      | 7 +++++--
>>>  utils/exportfs/exports.man | 4 ++--
>>>  2 files changed, 7 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/support/nfs/exports.c b/support/nfs/exports.c
>>> index 21ec6486ba3d3945df0800972ba1dfd03bd65375..69f8ca8b5e2ed50b837ef287ca0685af3e70ed0b 100644
>>> --- a/support/nfs/exports.c
>>> +++ b/support/nfs/exports.c
>>> @@ -34,8 +34,11 @@
>>>  #include "reexport.h"
>>>  #include "nfsd_path.h"
>>>  
>>> -#define EXPORT_DEFAULT_FLAGS	\
>>> -  (NFSEXP_READONLY|NFSEXP_ROOTSQUASH|NFSEXP_GATHERED_WRITES|NFSEXP_NOSUBTREECHECK)
>>> +#define EXPORT_DEFAULT_FLAGS	(NFSEXP_READONLY |	\
>>> +				 NFSEXP_ROOTSQUASH |	\
>>> +				 NFSEXP_GATHERED_WRITES |\
>>> +				 NFSEXP_NOSUBTREECHECK | \
>>> +				 NFSEXP_INSECURE_PORT)
>>>  
>>>  struct flav_info flav_map[] = {
>>>  	{ "krb5",	RPC_AUTH_GSS_KRB5,	1},
>>> diff --git a/utils/exportfs/exports.man b/utils/exportfs/exports.man
>>> index 39dc30fb8290213990ca7a14b1b3971140b0d120..0b62bb3a82b0e74bc2a7eb84301c4ec97b14d003 100644
>>> --- a/utils/exportfs/exports.man
>>> +++ b/utils/exportfs/exports.man
>>> @@ -180,8 +180,8 @@ understands the following export options:
>>>  .TP
>>>  .IR secure
>>>  This option requires that requests not using gss originate on an
>>> -Internet port less than IPPORT_RESERVED (1024). This option is on by default.
>>> -To turn it off, specify
>>> +Internet port less than IPPORT_RESERVED (1024). This option is off by default
>>> +but can be explicitly disabled by specifying
>>>  .IR insecure .
>>>  (NOTE: older kernels (before upstream kernel version 4.17) enforced this
>>>  requirement on gss requests as well.)
>>>
>>> ---
>>> base-commit: 2cf015ea4312f37598efe9733fef3232ab67f784
>>> change-id: 20250513-master-89974087bb04
>>>
>>> Best regards,
>>> -- 
>>> Jeff Layton <jlayton@kernel.org>
>>>
>>>
>>>
>>
>>
>>
> 
> 


-- 
Chuck Lever

