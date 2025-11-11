Return-Path: <linux-nfs+bounces-16246-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 086B0C4E49D
	for <lists+linux-nfs@lfdr.de>; Tue, 11 Nov 2025 15:05:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5412F3B443F
	for <lists+linux-nfs@lfdr.de>; Tue, 11 Nov 2025 14:01:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB13E309F08;
	Tue, 11 Nov 2025 14:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WsS8YcCL";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="c6J36FHr"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34E56305E09;
	Tue, 11 Nov 2025 14:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762869673; cv=fail; b=RBs2+6T8zdmA1tWvwgi1/odVtWoTVbwg3FFN7XADqopA2lEppOzlBOjAdKe68glxFgmX42M9FwG99mQbQZ7+pbp33lyWiRO+2/oyo354U6Cm2yS4Yq5Xs/TXWyxlnjbwwI4ftSmNNKFtZtPcziVBcBYHA2GBMmVPrJKFphpQbH4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762869673; c=relaxed/simple;
	bh=MzFcyX2wyaGR4UCg2B71osV6In/B6EFLL0nXM18c4SI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=shj1WA2CTToW6po4w25I7l8L0AVKsnGPDugiAvEkud/HFOatqpg11dw4+FvWXqeGEEi0S6qkHH4z6l4CFBnJ1ypGtCbTHTv19JJvddJ7IXHCDi9yxTt3h1wG5q2FeuqeqphEOsytnUZ6MvQEAt8X1FJ03KQUqV5kn79l0OvNlwk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=WsS8YcCL; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=c6J36FHr; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5ABDpLsM032240;
	Tue, 11 Nov 2025 14:01:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=QuvDzLC/PBPHrJ+SvPqf5LD0vHyxgDuPYzFlChqy5R4=; b=
	WsS8YcCLMikXTdVPHkWK3jHSs97F1uKfRY88aWNpwGf86v5b+d/CvhM/EEs+EjYq
	DC3uSXH5A6ufKBrWs8ZhGaLlmHOqizA3qVQTB6grPaiyyJGOT+JG5hStWv/BjV+l
	OPnxeWHPI1hEDfjJ5ER/tpbEAIWReHZMOIh+GOnx/vfC2ZDdojSYBa6dCDq0T0FC
	oBYOmbtaVcoHdkwej3avY9G9q1X3WtwdQDhwiUma2p7P4o1ifyE+OoopXwLxHt4h
	XEu3qu00kH0s3g7GUaXZ5Z+o6rFR8+R2i1PZaJLU29qKQDRJzQcxB3R8E0X9tTam
	PcrpTahnkKxtuF1FfCdvNg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4ac54p05f3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Nov 2025 14:01:02 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5ABDkx8Q010012;
	Tue, 11 Nov 2025 14:01:02 GMT
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazon11011050.outbound.protection.outlook.com [52.101.62.50])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4a9vakacw5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Nov 2025 14:01:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XRKSQKRl7TsRZPx3+uesHeucfo/Ltwv1yuP3MTmfSA8g+AYLpttl52ATvKLVrrWwmZjqP9lami9MUqISP0xSAkO4OM0T62+LE17jYiofkjZ6ri4AiLqPDcyaw3WEK22Gh4Wn0oAlRAhVUNeDaYfTjazRmbc0GR3Ofk4yF0vVHULS63SEbtgIceGAVNAxQXuFrjqBE0C+Ck30T2Gh2pgaLbNpWDHvCYNDCQxJgtcOSbgyf+A9/a5LMLTYNOTpZURQjfvsRJknWNN18qhsfRsUF6jcCyBA3qzdpLEK6m8mKrZMSU1MVLyR5RukuFNRff5G9ReCUsY5YwCYpW1vui+raA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QuvDzLC/PBPHrJ+SvPqf5LD0vHyxgDuPYzFlChqy5R4=;
 b=IgW28o2YZEpsctF7pZXqOS6nvLh0+nIk7Hc5iq3spdEqZdIhneI/m80bZulnVb3MQOYAZSY6JytxHHMTUmJY7i8nLB3y1FWvpQ2DMoW4fqiI/9wbGv/g49aNYE70yy/Vhk6FzxlElOhtsDYempfchddIq9NgjVNXlYv6Ub3x1Kijb/vOiEL3tXYtoXLJqz+Cb5GZsg5fpHaKSxyAUOmhfLfO/TF3RPSaTyNy/0frGK+6vTp/CX4zWWQlKHhjOBgCJz/8UOfqcRazvT7QtJuxAtZI1yAIz9u0uWw2P7G9SxplqCuUU6Zl+Ohbkjlo8O5cw3aQN1CUAKQ/mdZFpO+XDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QuvDzLC/PBPHrJ+SvPqf5LD0vHyxgDuPYzFlChqy5R4=;
 b=c6J36FHrsMRWRL98MLuPuUln4qZ49tkqUVLgpqm2vlDeDpyNn0QE7SsIr+G+toA92OM0tw2TmFweHOQI0p5ywUFW4S207c+8RgoyuaJq/J25fl/VWfT5rAe9KZgm1h0uZeVuecVcUFujOKsmqYnqnFBoVOZ/bOpGOmGO7IFd4ek=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DS0PR10MB8151.namprd10.prod.outlook.com (2603:10b6:8:204::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.15; Tue, 11 Nov
 2025 14:00:59 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.9298.010; Tue, 11 Nov 2025
 14:00:59 +0000
Message-ID: <d11e04d8-75ed-4540-bc80-ba9a33d10f78@oracle.com>
Date: Tue, 11 Nov 2025 09:00:58 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH stable 6.1.y] nfsd: use __clamp in nfsd4_get_drc_mem()
To: NeilBrown <neil@brown.name>
Cc: stable@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
        David Laight <David.Laight@ACULAB.COM>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        speedcracker@hotmail.com
References: <176272473578.634289.16492611931438112048@noble.neil.brown.name>
 <17e85980-9af9-4320-88d1-fa0c9a7220b1@oracle.com>
 <176281669984.634289.12369219545843965992@noble.neil.brown.name>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <176281669984.634289.12369219545843965992@noble.neil.brown.name>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH5P221CA0023.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:610:1f2::25) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|DS0PR10MB8151:EE_
X-MS-Office365-Filtering-Correlation-Id: fb9d2d0c-122f-47cb-a463-08de212abe3b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TnV6dkNDeHMrZU5Vanl1Z2F1NGw2aU9kTThaNUQwZnhwZ2JncjFPMnVNUy9k?=
 =?utf-8?B?VEVVdnNISEk2eU1KU3gwbTRZelZtUncwMFRaaVFib2srU1NscFNkWkNhcHIv?=
 =?utf-8?B?TXBJTmlDV0Q5OTVFWGpMZ1FKK1FCOTFXTDlDUDBBemxrcnpZQ0s2MjAzQUlN?=
 =?utf-8?B?OGRzRURGVXhRSzdDT05tZ0lJR01WOHlMMWFzQVBwbnVGTEFPN2d2SU9xNzFK?=
 =?utf-8?B?SEcwb3ROb2Y4NyttRi8vYmZTdU1IU1g0SkJYK295UW9aT2JqWEdJZDNiZ29G?=
 =?utf-8?B?T0c2cy9wbGgxZjNjOVlpVVBrQzFHSEl1dTdncWNtOXowalR0bjN3ZS8rRU1z?=
 =?utf-8?B?Y2ZsYkZXOHZKNnR3bTk3WE8weGdRNkl3V1AvK2trSTQwdFkzVk5reGp5bERa?=
 =?utf-8?B?SEsraUFmK2FreG9SaitQc1JDOWtiaDhFTHpUMkh4dm85WHpYVnVObnN3cTc4?=
 =?utf-8?B?T1dJK0NlUzNvSVFGdE9Rc3kvQWZVdjJncDJXL09VRms0Mi9CaXZYbmIrWHN1?=
 =?utf-8?B?ZUpOOW9MSS9sNGk2dHg0UytHQy9tZ0ZBTStYYzRZRGZOeXlUZzlaU0pBbHV4?=
 =?utf-8?B?SkNQUEZkaWI0L3ZMblNnT0djeU03eCt4QU1tczlRUzgvKzhUOUlmUDN6SVVk?=
 =?utf-8?B?K29xQm82ZHVxUlZEaUowb3BDaS8zZW1PczVxeWtzdStRckVyeCtUQk9ubmNU?=
 =?utf-8?B?dFdPOUx1UFVXdGpmSjNiZFlrOWptdUNuYS96WVRTVWpBMXlMNERIMHFDR3p2?=
 =?utf-8?B?aXV5NUllWWplUk90Rk9QT2wweXNYSVVvRWo0OTR2WWhGSElVdDRRQ08xYkFa?=
 =?utf-8?B?TzlnNG53Q0ZtSzd0L1BOVkdHTXBWYW1GdXFOcUs1TWVjMHlFTkgxbnJNczFk?=
 =?utf-8?B?UkJxTVFsbjNPM0tQcVBBZjFHcHJBM2xhRi90S3N3WWdZSW03Y0tWV0hFR0xZ?=
 =?utf-8?B?ZlVuMGZvOFpOZUxSMGdsQTRrU3Nnemh3R2xMcnJTM3pjWEtZSzl2WTJZdGpn?=
 =?utf-8?B?ZjhQTVREVi8zQTlzZXRZK2U4ZG1HYkwyVXhncGNFc3VzblMrWnlDWkx3WUY5?=
 =?utf-8?B?dFFiYm5aL2t6ZlpVMHd1SGcwQUsxczRHa21KTUY4M1VGeVlLRmF4OU1uSEhl?=
 =?utf-8?B?am15WVM2NnhZdUc2Q1NJN3VKcWJNWUtjWXdiRmJJdmo4T1dmSFZ5Z0pOeUla?=
 =?utf-8?B?djhJblZJQzdKZjdkZUd5MXVUaHZMd3I2dHZmQThsaTN6MG5XanJYUHRWUnl0?=
 =?utf-8?B?eEI5MTFwb1o4VjFLcXd0WW1HcWVVQW44cGlXZ3IvMDE1TWRSVUswR2NIZHlx?=
 =?utf-8?B?UVdVdTgzS1VHTTV1aStZSVVacC9sUEx6emdDUVdkZUc5ZUFlTEpySkM3eUg4?=
 =?utf-8?B?Nk1ZUkM3Ui9MQVlCZ0hhQ2w2RGc0ZU1kQXlCSnRkS1RPSGR1UjRrV1A0S1FZ?=
 =?utf-8?B?ZjRxYllpOXN6aytFT0hMVVF0U2l4UUx2WUI0S2lWUTNqYy94QmtGdlVGOUhW?=
 =?utf-8?B?ajBYdXJsUVZBNUluVHYxQ3NZbUw3MHpRelpObE9oTVhKTlpZYnJXUS9EL2k5?=
 =?utf-8?B?WkdHWXdTZStmQjVVbDloMVhsRmYxV09sRmQwakUvc1llYSswaXBRUHJ5Q2Js?=
 =?utf-8?B?S0NJanJUZURLdzBGc2ViWTBEdjlvYThuWk8xdWZwaTlzRjdNaE4wSkFLSGxa?=
 =?utf-8?B?TmlNcnBJV2dPdCs1UlhoVVd5N2hKOWZSUDNyMFBpam9yZWtWQnNObk9sTU8r?=
 =?utf-8?B?aGlGN0lwcVdJMzIwdFFvNzNPRDZ0VHdvUHBZaHZFM2YxUTVWb2xhNjJoeXlE?=
 =?utf-8?B?VWt5RVAyQjY1TFFQMHYyaFlET2M2OCtXYVBWWmxpcFJ3SmNxVEdySjNNYVhy?=
 =?utf-8?B?VE9RbWFUUlZFSi9JVUZSUEk5cXVYei8rSEY0Y0xGbnkwRGRueHQwaGVRcE5I?=
 =?utf-8?Q?/VPvsCp5b3J+xEbKFwoWcGhke6lwfg7t?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UTdNRC9tUEcvVFF2cjE0OU90aFNCaXF3N2lxWGQxT2xrd2tsWmhSRE9HejNo?=
 =?utf-8?B?Y1JucTR0TE1WWkhyQm9KaVZrYjV1WGJheVRVdHVhUnlUcVVwNTNsQ1YyWkFu?=
 =?utf-8?B?eGFKUmlIZVZpNE1mQ2NNU0U0YW5oWFRmMkR3RFlKbkhOOUhJYlduYUFNNjZF?=
 =?utf-8?B?ODcwSGpnMjUrMnFBcC9vZk1nb3pKdjRYMm55TURjMXZPL0o3L2hmSUpzMkxq?=
 =?utf-8?B?eGcrd1VqSTYrV2JscWdPaWtZSENYTEllU2U2TEE5dFlaSG94L2M1MUt0ckdT?=
 =?utf-8?B?S0l6MmQwdEpMSnY2dVgralRYTWFzTjEzUHRqV2lxalJZRWtlMkpxWE42MVY1?=
 =?utf-8?B?UHRRalZqVitENlJDc093dVdBYzRNZlp6eTl6UVhCQmhLc1U3ZGtQazlYS01V?=
 =?utf-8?B?ZktrSEpGK092WmxBTmhtTVczQWdoRmVGUU1PSkFmRFZzZkRqeEtSNmcwSkJ5?=
 =?utf-8?B?WVRWb2pRcExmSzBsaXJTcGgvNjUwSm5lS2RVSUZYMHY3d0EwNlFzeWNiank0?=
 =?utf-8?B?enZQUXRZU3JHS3lCZ3hkc3pSeEs5b2lmZklhQmhkSTV6MS9TQ3h4d1R4OVFO?=
 =?utf-8?B?bHZqN1NhOFhpdE5zSHVVSXJqbjNGTGp5ZzlNTmpnV01vY3lTeDhZU0dKUmNH?=
 =?utf-8?B?clZLYmxzWGpaaEZmMEpVckNkUitySUpHVy8rZVFtQVJpcDc0TStDYWl2akZj?=
 =?utf-8?B?VEcvSUlzODc0QzJvMGp2UVorY1NqM3ZIV2tGTlBndzFPUXFNYkJHNmZSQ2No?=
 =?utf-8?B?SmlRek5HLzA5OTFzd1Y0YXcwTUluRzZOUTQxMTE5UUhIOStXV0JhNmV5QkpC?=
 =?utf-8?B?ZGNuZDV5M2lzT2xpRjNjRUdUa2prYy8zMW1ONzVZOWY2ajVXMHZXWkd1bXor?=
 =?utf-8?B?SFJNcm85QnF3OHVPRDZRVEp2VkttVmN4Z2FRT0tyTnNkT0xHRldjbDVYRUFC?=
 =?utf-8?B?TW15a0FNSEorRHJTSENsQ3NkN1h0WGthMGJIQ3R1cTRPM1VxdlRSM1RIeU5W?=
 =?utf-8?B?MExTVzRIaFIxbDJHWG8zRk1ZTTZUOG5zUllCakZFcVpia1daeGNZNXpXZVdQ?=
 =?utf-8?B?VjNIMmthYy9TemVOenplM21WWDdCMjZnV09Nc0VLby84Q01zMm9Zci9Ea1k0?=
 =?utf-8?B?Q0pPaGpPL0M4N1NzT2prcnJYVDVwbkRGa3dreWE4bUlwUWx1N2d1NWptc2Nj?=
 =?utf-8?B?UUF3SEg5VTV3OW5SNCt1NUM1UldaZzRudjFEU0Z2L2dmaVoxS1hjOXd0Z2Y4?=
 =?utf-8?B?THZoRDFDbWJ6MGxoK3dRQ1l6ZHg4MUQ4NGd6YTZMUm9RcEhSdy8vbm4zeDg3?=
 =?utf-8?B?d3pweU4zUURELzd3dkdiRWFqK2wwRm5wMHQycDgxc0dYZ1htMHBmVldvRnBL?=
 =?utf-8?B?dzFJY3BaNkRvai9oYWs0RGJ4QmtXdmQrZ3RpdFdlY2ZSbjEwNndEbkJrTkRK?=
 =?utf-8?B?a3pKRW9FVldCRXhIUk0vSWliNldmRkNVdVVWQnIwQ0doa3pQekZVRUlIQUkx?=
 =?utf-8?B?WDJPQXRpR2NWQzV3Y3FjUkw2TkNSNW1zcldhVU9XUHIydEZVZjFRN1hSQW5F?=
 =?utf-8?B?ZzIwRnNGWEROSjlQWjRMMXhhc0xMblN1WmhtODZqWkNPV0VXRGdoRDZNTnU0?=
 =?utf-8?B?L0o4OEVVS25IYTZyNUZKc2FzM0R2QSt2SlZPK0ljTGFFeUY0QjN4RWJYZVAz?=
 =?utf-8?B?aW9VYldmN29QZ2ZlOG9pajY0U0NsQmtYc05wbmRDcjd6RitHa00vOU9LRnky?=
 =?utf-8?B?QitiQk9vVDl2SEFSQm5mUC9HZGpMTjZCY1FFanFEY04yVnpnam5PY2QzTXc1?=
 =?utf-8?B?SUkzUEVjYk51RWxOd1A4djJ4RjRYeXJqZmJyMEo2L1NjNzU2T1pzYjlsOEdn?=
 =?utf-8?B?bnp4ZDJRaENPK3pQNXc0R0tJQzBueHZ5RFdldksyU0JLdW0wL2hvdU5TVHhi?=
 =?utf-8?B?V2JCNUdBNFJxSlE1QU5CSGVudXdkL01rQ3FqNjJOTmlHNkJmUTlzL2ZBUStx?=
 =?utf-8?B?TkIvMnloS3E2dUFxTzUwVnRUY3YxMGl2NGc1clBwZmhqRGpyZHA2SWV0cnBS?=
 =?utf-8?B?N3V5ZWs4M25Bc2Zlb3kvQTFscFI1WmVaYzBrSWk0VmI3VHczd2JuakxZRW1q?=
 =?utf-8?Q?QD+ifWPlGqrnuMpUyfXNmDsmv?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	xpIfhpc4IdYGFrO9OfTqggOKKooFAWzhMJI7O0/UStVeNPUX9w1YWC8ls44GOYaZ36nfrgf1dQBevG6LkI71jDTaWc1H0OKbf3+0QBiDvyCVw24WMTK9ROl8PuFz5JNL34xJqylhMh1+JW4IqmiCOy6PzXJBQRo5YlVry7GauYZahMAmfWJZVTSdbkUL+Y40Xgso4mKtiEU8jKteai71gr20Nevq99kok+WN4sHADl/LnxsRkeq0ST97zlEQQSOBVHDzeOG5zwBLn7wmDYw2LZ+hLdlbAflFVNCF3VVzcFL0GJSc6k14BnJdiROsHxLmO7Pxv6ebSGwshqkAbjmLwN+Vd8ndHm53CsGHlz/95z8O4EqIp2BN3GGcb2pbIk+L27OaiTm/G3y6X3d9ssxuUx73L2wyyZS04m2PXgsqSAD1wFLOwJpF8m0msP65xu+ksOrubL/atS31hNu3HPfL/HPC5VhSF/F7q6DHKNXwfvKP0bdX7t+UnRICxuoENZTDI3XL9AhvZw+7DmuQ6GiXTmPETO2eSThS0y9IFtw6epdSIL/IveuEm1AC86MO3LEtksO36FIeD+6FbXPjzuWVKWHL1MALi3Pzq+KTUdOceiU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb9d2d0c-122f-47cb-a463-08de212abe3b
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2025 14:00:59.8959
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OaL2bEgNn/ckg2/o1kMC+fks1gtYa/e8h6FNm9Qc9kWUzkxt3jxDvqK1feNSCOuoKoEXPoqyy1VNQzdymKs2hw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB8151
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-11_02,2025-11-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0 mlxscore=0
 phishscore=0 mlxlogscore=489 spamscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511110112
X-Authority-Analysis: v=2.4 cv=K4Iv3iWI c=1 sm=1 tr=0 ts=6913419e b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=noqcoGvEQzpvHSLjex4A:9 a=QEXdDO2ut3YA:10 cc=ntf awl=host:12100
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTExMDA5OSBTYWx0ZWRfXz9DAq1Wxt+x3
 Oaf63DAT5rNufTxebYGCLUqIhUbB/+uwefYl/YxMXwXtffg7kTrC2wicvILtmQnawAJ+xtzYPmD
 oklrAMQwrboHx4KmBeX/sL+8Oq9OQDP4CYMWkS/oWAGhWAE3E0DnQMIESiPB32rm+Uy7eoXLBNp
 FS4CE2g2FZ3wumbxyMWjUa+tkhTx3ELNjESmYXH1wd0UCSBNinCZk5EhbaBrGJD2tolA9OTUXBx
 fT0oD+/ur9rWs37dgUo5Qcw9u//8B/AoalnVykMWD7NRO6Q3ghRwpxodIRK6C92L4z1dfRzr5Wc
 BfrY3bIYGfYcVknSSohweNHE1F21jEGJmSFf8dxVtWiqYEjCk5fGtIRo1srj2YejckZqnFDmSjF
 VelDQFZqhKZJdy2iP4vXp0SMG8i4pLiNa7SnOugbxRthX8Oyu/g=
X-Proofpoint-ORIG-GUID: CKrLT-0mlmmqtlSOZ5QfWWJlhmHvyBsO
X-Proofpoint-GUID: CKrLT-0mlmmqtlSOZ5QfWWJlhmHvyBsO

On 11/10/25 6:18 PM, NeilBrown wrote:
>> So IMHO this patch needs to target v6.12.y, not v6.1.y, and it should be
>> marked
> Can I leave the process management to you.

Yes.

-- 
Chuck Lever

