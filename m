Return-Path: <linux-nfs+bounces-8702-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 505019FA1C1
	for <lists+linux-nfs@lfdr.de>; Sat, 21 Dec 2024 18:34:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4BBDB1887979
	for <lists+linux-nfs@lfdr.de>; Sat, 21 Dec 2024 17:34:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3B2133C9;
	Sat, 21 Dec 2024 17:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="h5dkw8HN";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ViCn1GaN"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D82B2A59
	for <linux-nfs@vger.kernel.org>; Sat, 21 Dec 2024 17:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734802492; cv=fail; b=lkydbnwRm9l7Xz+ZZH5OzJ9ENBLseDwjtYcq95O3SZfPHRFDyc2Oa+yBLlMkDyIMFFta8qEW5ln3fOk0QBOZko3u7IGkhkUWDO/kTQiW9eCVXVyq2td5vOCrkM69kQT4QJaTPhFZoBaLHXT9KbYui9T4XG0ORX7bdBKXqLaOCj0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734802492; c=relaxed/simple;
	bh=Uex8bUKQ0rogSOZjGve8nyv16nFOQu1chkm/h2YzHjo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qgMAQJqUqxyIUU7j3CMTn5Yf4XAnnfsPGi2cF5D8g9Gnc1bJJzBzA7NxJlxRkcMT7DW9rRbul4vRE9k0p5t00Fn1NHjYExHMPouekGLe8EgBsFP37E/ShaWVdLglqQ6TPonuWlRtGi67SoNCjHD+31P+kxxljgnwAU/ugpLro4A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=h5dkw8HN; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ViCn1GaN; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BLHTfQY024209;
	Sat, 21 Dec 2024 17:34:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=p7xJCveF/Hzg0yhKKGbquBjW9RH+aTe0/6wcbOjnOtw=; b=
	h5dkw8HNEe4vlm8jZq0AEoU1mQiRVSaIUZ503V8AzfHsrZHDk31urkANof+bG6Zx
	pkE0mfip2elz/0QQGczB1IYuKmoue7DZy/994H6rTShltGfTE9LdYoX7rQX5ZXIq
	EuUlDk51lCYcbz1bo/mH3B3yxWb9yEFbCzOpOdxE2R44D+zGPFwpk6lAYCjvYVvd
	xdr9I3x/mrMQ2CZW+7XPBIczW1UZNg2GVQ6kwyEu0zlhLPDgxflFafph2Z9ykHEs
	RVHCqXXYexoC6ohRlxyazw6TMD7+JJK7hbPaDFamt/Im/VCp5omZWioPc05VkPDj
	XLX01NVwpz8n2xls3Dehzw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43nqd5gd3f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 21 Dec 2024 17:34:48 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4BLFP7iI037969;
	Sat, 21 Dec 2024 17:34:47 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2177.outbound.protection.outlook.com [104.47.57.177])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 43nm4bnj9d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 21 Dec 2024 17:34:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xwvr4FP+iGzZ7S6cIAyz64LSgodfq09f8eEbagx5kqQ6POMFh6I7ODAmf5NRtdF9LqYOQOmMDpwB17KN5FiddP4+4CG2B0d2puZFG3DVEsL4yvl/Qi3gVJdnHoICBCu5lJkDhBHcZ4d1b7SCo7I+iYZRNH9jX4/YfJqMngokN+uzSp1SUXSvBFMJtroPdPAzOZQH7bmVNPNGzB63yU8tYeDiUb6HZGXrTiRXwVG1mcYCt0bXRfVRVHlEvN4Nb4i5TbuN8sKwa2Bo5ww8+ptA48W9FQ2lChwyT8p1Xxcxt4VExRzJ9mU427L+O6HEMVHbskAX8rHAVJvDeqDf5tHRHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p7xJCveF/Hzg0yhKKGbquBjW9RH+aTe0/6wcbOjnOtw=;
 b=XB967QOqyCuEszeV6ytlEsbALS7+78sBcPEP3/ztzZO+hwWdIGbKOKNi9t0bW6pp1IyD9J8aFUBx+N6TnqUQ2Tq5325XsN3+VsUo3VG/6YBmFME0urFDnjf/+xxwEvfRWrqTxM9HtHHaLeXuWjLzVwrQ6Ir1xGfvO0ofZ/QSVvyBgU73LxuNiQBh66laffoyTAh0QTitamCrqGDJXtl2JAcwpWKlraGfrc70mPGcHzJMMPqXl8xcoxRgA6+AiytavfDdEGpi9n5OdoAwj4J09oa1VVyOL4TQOmf4GEaoXlwxIxz2COxQNVE3X2cIwfBlOmfArCq1kraTf+V4z3TpGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p7xJCveF/Hzg0yhKKGbquBjW9RH+aTe0/6wcbOjnOtw=;
 b=ViCn1GaNCGFsmRilkXnNbFad46U2GXEhhEFD/oRF2dJBb1qL5Ksb9EoyLWNjabOmfHkP99e9dO/EEVZgDAAmw46ZPLWdvE52THO+980eLmGP6aLaVCKQL2NzAokLXXK7y8wK1por40aKy3AmLu5LESI9kKC4aEk3malKMDNCMm4=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CH0PR10MB5003.namprd10.prod.outlook.com (2603:10b6:610:ca::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.18; Sat, 21 Dec
 2024 17:34:42 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%7]) with mapi id 15.20.8272.013; Sat, 21 Dec 2024
 17:34:42 +0000
Message-ID: <e4853faf-0836-4595-952b-69f71150bede@oracle.com>
Date: Sat, 21 Dec 2024 12:34:40 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: knfsd server bug when GETATTR follows READDIR
To: J David <j.david.lists@gmail.com>
Cc: Rick Macklem <rick.macklem@gmail.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
References: <CAM5tNy4-SNVD+zqgaJTmLtAQ+kKV_Ce4tRr2zqgjTq1KPM-rfQ@mail.gmail.com>
 <4804ce6a-fa67-4b50-bc31-715689d3c766@oracle.com>
 <CABXB=RQn8qU5TZsWyBpWNaDQpaMPhdi4RYVJ0D1qJAWiFuBAHQ@mail.gmail.com>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <CABXB=RQn8qU5TZsWyBpWNaDQpaMPhdi4RYVJ0D1qJAWiFuBAHQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR08CA0021.namprd08.prod.outlook.com
 (2603:10b6:610:33::26) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|CH0PR10MB5003:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a990730-8aa4-4930-1f9c-08dd21e5c089
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cmx1ZEFsaG5FVTdINmJJZ2kzcy9hc0pZamkwbzVBNmJ5cGRTbWhPSDg0Y3Q1?=
 =?utf-8?B?Rk01NFVMN2ZmZzlmQWlqY04zdkEzM2xjQThOZVRJZ2d0eXR2QmplVjVaRFdu?=
 =?utf-8?B?clc3eEp2WlJtdURvU1FMMkRBc0FGZU82a3JvNk51ZmFmU0kvc2NyL2ozM0Jp?=
 =?utf-8?B?NVBzeGR0Rk5sZVJOS0dJV3lZdjlZVTRwdDEwN2NlMHlYN2QvdzRFWmlvcVR2?=
 =?utf-8?B?Y2dZMFBubEcxckRsV3JJcnNOekVGSkhsUTFTK2xXR0lSWUExMkxhUXZ0RWlR?=
 =?utf-8?B?eUFmZ29Gdm83b3J3by90VmkyMVlIZlRCNnU4RmRPY1h6a3VSb2txdjN1RS8x?=
 =?utf-8?B?V21vUTJrRm84V041QlczWjA3MUtRNUdrM1VhNDhON0t0QTVlZlR2RDdPQTBN?=
 =?utf-8?B?eU9pZUxCbVBma1dmWEg4QjlxS3UvK3M5Y0dSYkNIKzc1STdJSzNSOWI4UTRC?=
 =?utf-8?B?bi9PTVExbTJZU01CRE05eGZxd2hjbXRydG1MNTdaeDdxcEFLT3BlT2dubjhP?=
 =?utf-8?B?aUF5UWZjYnRWMWU3UitEWWhyOTRlc2lic015RDZkKzBHdytDWUY3Q0kyNEI0?=
 =?utf-8?B?RGNyNllCdmFQUTV1NWVBK2lZVG9xbkdQaU1HSUFNZmh0amxlOHl1ZW1xQzh5?=
 =?utf-8?B?UUQwbkZuSUV1Nld2WkpyRkd4TkIwdyszV1JDWFFpUG41WHRmb2lsOWdHZWJr?=
 =?utf-8?B?YmpiSGlXZVRCVGJPVWZqU0xkVGJGcmJ0cWZCbW9hTFdpK0JSWjgxWW9IZ0Iz?=
 =?utf-8?B?MnRZV211UTJwallCek9uNndKMENYNWxYeDhiZzJ3RTJUZm5VVHRRd2l1Yjlx?=
 =?utf-8?B?a0g1OHNsMlZHSVZBVUlPUDE5VXhFd204RnhwdE9TN1FIUGZaVk1YUkFtbERU?=
 =?utf-8?B?ZWNzZ01WN1VNaUtlalNBbEVDR3lZbHJLOUxNZ3RWQ2hhWnBmd3N4OElZTW5M?=
 =?utf-8?B?RmZ3NytpdjJtUjBiQmJ0RzVuNlY5dzVDK1d0VGJqNEQvSHN4VHM2VHpXZktS?=
 =?utf-8?B?KzFNTGFnOHgzY0VZa1NsV3lsZWFXbGdSbVlhTUM4ZXJqUGYzZVY2eFhzMDZk?=
 =?utf-8?B?dUZwTnkwZUM3RFhhOG8vUStpMGhDOGsvSVozUFFha2tLTzdnZVQyMStSU0NE?=
 =?utf-8?B?QTJLNzNVbGVKUFd3N2pCL21MTlU5dUE4cDNHcVRoTndrdHkxb0Y0TjhTWFNT?=
 =?utf-8?B?L3B4YThEeEVlTFZ4YUs2K0JtOWVxNldlbWc2c0dscERXM2tWNGVwaGZteUVq?=
 =?utf-8?B?OGhpa0xsU0VoWmV4cjUySWsyTmR0RDRpVVNaaVozaExZZUdjUk92UU03d2J1?=
 =?utf-8?B?bXJkbnBZMnBUL3djTjNmREpRSXIwR2lTa3o0Mm05TFNyeVRxZDhZVC9zKzdZ?=
 =?utf-8?B?ZngrS0xaQnlXVTRaMVZWSHNUemsxVS9XR2NkNmx0RWQ3Szl0aFQxV3haeE5j?=
 =?utf-8?B?S2tvYlVNbS95M2tiNGpPRFdlSWQrZEhQTmdnam55Ynh6d1BvQUlTdER1ekJB?=
 =?utf-8?B?TU4yL050M01KUHZuVjlWVk1IMm5zMVlyL3k1Y3ZibDl2a1BhOWpyVXVYZnBo?=
 =?utf-8?B?WVl2RnhmbFB5dnFvOUMrOG5SQmxLZWRaMDNkWTMzNDZnWmtrQzdzTFVnV0RG?=
 =?utf-8?B?Q05MaklqT1Bkajd0Sm1uc01JTG9xRTQvdWVCZWIzMW01TWpUZ3Y4NElnV3FT?=
 =?utf-8?B?YnRIZ1FWMkk4Q2JoalJBN2Q5UnpzUHgvVnBqQWRTQkZhZUlJKy85UnU4cG5v?=
 =?utf-8?B?MjUxaUJHSm4yZHlqZFBpZXRMcnh0ZGZkNEdrbkxlb2F1WW5ESkhtU0xRbXBt?=
 =?utf-8?B?M1VNVWhaOHpheFBzTStyUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dDRMYWw2R3MvL1NNa2pHbFlIK0lXUXdkQk9HMmFxM3BnRVVzMUZHZXAwbzdS?=
 =?utf-8?B?UjdKMXJaemdsVkJyTllqZ3BCT3lhZ3FQdEtUVUF6T3pycndVeExZeHZtWTZI?=
 =?utf-8?B?Y01wZnUwZXVjdVhjTGYxc3FGbE1vZGZ6UnJWN3ZkTHpnS2Q1NGJiUWhTakth?=
 =?utf-8?B?dzZSTmZwdTBpTW9nVElRYTcxdFJDT1JmODFpdHhiTnFVdkFzUTdzQlJYTjFp?=
 =?utf-8?B?Y2hkcFgrUytOVGpHb2J1SUl2RlF1TS8vMTl4RjFITE8zeXdsWHVYYzMxQ1po?=
 =?utf-8?B?dHZhQit1VUhBYlordHN3MXpRdVlMc3Y2enJOU29ZQmdpdmxOMjZIdjZPYnM1?=
 =?utf-8?B?MEx6RW5SSWZlcFBMOFArZWRyVm1OeUpZNm03dzhxSkFxbUhYbGx0QXVVMG9J?=
 =?utf-8?B?MXBhYktYYXFybklGM3RISnVXWFZiWGpnMGhDbE5lb2dNb1RHd2ZlaGJaTG5r?=
 =?utf-8?B?Njd1TEJGV0RiOC9OT1JPWUpvSHlPZFI5VVI5M2kycHNkbVAxNWZkU0hzNGFh?=
 =?utf-8?B?aUdTYi9paUo0RUdKc3c0anFjWVgrdkpGeW8wOVRKVzNwazQvaDZ4K2FRdmFw?=
 =?utf-8?B?K1VnTnQ0WnQ0ZTArQXRjcUVSUjJVb1BsajFKd0kwVDZBSHZCeUY0cDBvQloy?=
 =?utf-8?B?OVcxTEtSZUxDT2xUL1pJTmNwdXZyS29RWG9KdllxK29wQ3BTbEtlbkU1VC9B?=
 =?utf-8?B?a253bjRubTVNaWhvNU8wdnlpLzlrckMxUndwVmxwV3Znd1UzWWdHVmRCWUd5?=
 =?utf-8?B?bjBjTFRRMk5UT2NLU01rY3FaN3BrM2lrMlZZSFVKK3dhQXdpQndOeTNBN0Zp?=
 =?utf-8?B?Z1g0OU1zNjVWamtuSUFUTjMwMXdGejlvQkRTcjhyYTJDVUFZdDY5RjVNYVU0?=
 =?utf-8?B?cnRpS2JQM1cwSHZ6RjZUVFJtb2dQRVRmODB3cENOYnJaeG1JcHUyREFKZVZj?=
 =?utf-8?B?ZTQzcjZqNzRvUkFXMUU3Zkdha0RZUll6aWtxcHdUR3lkY2hHeURhK3Vncllq?=
 =?utf-8?B?ZlcxK1NqUmxIbEd5NnZQbDJHSmdBWW9ESEI4aWZFZWZpNnRsRHlBQTFyZUNY?=
 =?utf-8?B?cm1pbDJ1UndwNFZQUHBDMG5PYWtOS1NaYjZMZlp2OEUxcklFKy96VUxFNHla?=
 =?utf-8?B?YnpEU1lGd3BHTkg4OEprMHBXVnZhaFQ3U1d4TUtLaSt6TzlpeG9Vd2Jva285?=
 =?utf-8?B?bThnWVhwRmY1Qk4xdUdRRzM2UDJjUC9iRVBzUFZuRi93OU1nLy95L1FyZ3cr?=
 =?utf-8?B?R09mYmp3eHlaWHV0ck1wbzZWVGJncjdNVEdsWSt4Vk5MQmxwU1puOEE4azFG?=
 =?utf-8?B?SndLbDZXU1lmWmdMa3hLbTZTUzlCaGw5QjhYcTRFaUF6Wmx0NGRFSG1oQmto?=
 =?utf-8?B?WUZwOURhdkw4NTJhcXJmTmZ5c3VKb1VuVVVsZWhRUEROSUVTdEQzTitBQWdE?=
 =?utf-8?B?eUFKN2RrUnlLay8rQUFQUEpEc0tyZVBvM1Job0RHUkdWL3RmTmxMSjRYS1Qr?=
 =?utf-8?B?a0pMaWhiVUVCM3JwVUZ4NnhhSzZON0tYVGRkamdUWGR6SXFKSlcvQW9lZXVx?=
 =?utf-8?B?TGQxaFBhRWZZOXo4dnBYWmh5V3lpckxXa3d5cU5UcjhxN2tlMm9jSHg3UFZk?=
 =?utf-8?B?TGo1RDZuQ0FUSi9sOENHK0ZVWGJwY3VrekVSWk5jdXR5dURqMFhpZVJnOVhW?=
 =?utf-8?B?Si9vc2RKRzdCUkM0cWJqMUdQTlR4eXQ5dTErS3FJeGRTMk9lbk9zM1ZKODh1?=
 =?utf-8?B?R0lNYUJ6cW5JbEFFdWc5a29ySFp5MHVrcExDNVFnRGdBUUlGQ3IwZ3lIMTIr?=
 =?utf-8?B?dnNYak0zUGVjMXVvWnhCWlU1anRNa0d2K0l1RnBsS1VNclpJNVY0M2FlaWwz?=
 =?utf-8?B?eHB0cTNEUm1vaGhSZ214bkh3cmFPWjhWcFIvVHZIc3ozVGxCTGR6RDZVeUc0?=
 =?utf-8?B?OVNPVC9ZYWw0Z3ZjcFRvOWhRSmNhY0xzbjlZdXNzLzk4VkRMVTh6QXY2eEpN?=
 =?utf-8?B?bGd6b3RwVVVRZmtoZHVDNW9TTzFFV2RibnEycnpYYkt6UVVwa3BnOUhqM0hL?=
 =?utf-8?B?ZlpSZFVST2RPT2YvaUpVQVQ2aWJ2NDVXamMwVmp1bmRLQ2VwYUw1OHlrQlpr?=
 =?utf-8?Q?YpEgw94p8fmI+MMjnxregqcXX?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	bJcVkMJKrskyHLsJzbEzegDW4n+MULzZE309cYp2kmUJs4cYsKz/Na0el8UZ12RH7ZSb28du3u4iBDbeYbBY9zgB0YpmjApkCsYRWo7SBcvpyLw4e8kZqLOfMZvHu4MJgcs1jRUuSJOsnFsfgdWiNBMLFrNzlhZI/h+OC9kanc40DhFPE1mZWgkcat/HQ1aMdZoXxPGyXoZ/KZkP5U7PpZ5I75BglrnZ0KLsypdBFJWjhFogtPbu2xcVTfeuhf96QSlaRmVYK0zMTs2zVV2RthjQpmM6J/HfkuymmguQCLT+11ftOV9cWE1mXG2JSmLmxNkMoVxd0fMwAKG3B8eybUUE4/Dqz0ZO9jDMOfNe6BfFThTbfMfriX1hYEXTh6sMnuJmDJzVZ2jd1OVGBOw+U6Ll6AWo9SSneC7tnlxmmu7dXXobEOCx92AhxU8KH+EFG0i/jxTfGLXjouqGBIsF2XzVlHoOHQR2Jfm/x1N23cuElUjR01OBlo30HQszGECXEAdMoNBLnoSEiuyGlF5t3dpGwuGWraFhz9Hz97ztQQ2wqj1Thg+3Q5ulR9q1/8uM2r5+ezPBzrgDXqObbz64I10klrtB3ygA9aIN00wdMdw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a990730-8aa4-4930-1f9c-08dd21e5c089
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Dec 2024 17:34:41.9512
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UbQDoicFWwvoc9XpPcCfFHz7qUIjMylZLw9zHWjeXxOaetklRmSVq9y0oF6RGkcMBZxln1lJ9q9lbHpJeNwuww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5003
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-21_08,2024-12-19_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 malwarescore=0
 suspectscore=0 mlxlogscore=999 adultscore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2412210157
X-Proofpoint-GUID: hI26adA4H6mEGxBi9K_9b7Cs-9IINU87
X-Proofpoint-ORIG-GUID: hI26adA4H6mEGxBi9K_9b7Cs-9IINU87

On 12/20/24 9:16 PM, J David wrote:
> Hello,
> 
> On Tue, Dec 17, 2024 at 8:51 PM Chuck Lever <chuck.lever@oracle.com> wrote:
>> If they can reproduce
>> this issue with an "in tree" file system contained in a recent upstream
>> Linux kernel, then we can take a look. (Or you and J. David can give it
>> a try).
> 
> Yes, I reproduced this behavior on ext4 with 6.11.5+bpo-amd64 from
> Debian backports on completely different hardware.
> 
> Then I set up another NFS server on Arch (running kernel 6.12.4), and
> reproduced the issue there as well.
> 
> Then, just to be sure, I went and found the instructions for building
> the Linux kernel from source, built and tested both 6.12.6 and
> 6.13-rc3 as downloaded directly from www.kernel.org, and the issue
> occurs with those as well.

Reproducing on v6.13-rc with ext4 is all that was necessary, thank you!


> Additionally, I have tested every combination of FreeBSD, Linux and
> OpenIndiana as client and server to confirm that FreeBSD client with
> Linux server is the only case where this problem occurs.

Interesting.


> Does this count as reproducing the issue with an "in tree" file system
> contained in a recent upstream Linux kernel? I'm asking sincerely; I'm
> so far out of my depth that I'm pretty sure there are sea monsters
> swimming around down there. So I can't rule out the possibility that
> I've done something wrong either in setup or testing.
> 
> During the course of this, I've gotten the reproduction down to
> extracting a 2k tar file and then running "du" on the resulting
> directory from the client. Doesn't matter if the file is untarred on
> the FreeBSD client, the server, or another client. The tar file
> contains a directory with a handful of random Javascript files from
> Drupal. As far as I can tell, it has something to do with the number,
> size, or names of the files. The Drupal project has three separate
> directories all structured like this with the same filenames, but the
> file contents vary. The issue occurs with all of them.
> 
> The Linux /etc/exports file is just:
> 
> /data 192.168.201.0/24(rw,sync)
> 
> (The production case also uses crossmnt and no_subtree_check, anonuid,
> and anongid, but I eliminated those one by one to make sure they
> weren't responsible.)
> 
> The corresponding fstab entry on the FreeBSD 14.2-RELEASE client is:
> 
> 192.168.201.200:/data /data nfs rw,tcp,nfsv4,minorversion=2 0 0

Out of curiosity, do you see the problem recur with nfsv3 or the other
NFSv4 minor versions?


> One additional thing I noticed that really blew my mind is that I can
> shutdown both the client and the server, wait, power them back on, and
> the issue is still there. So it's not something in RAM.  That prompted
> me to try "touch x" in the directory to create a new 0-length file.
> The issue then goes away. Then I can "rm x" and the issue comes back.
> By contrast, I can write megabytes from /dev/random into one of the
> files without affecting anything; the issue stays the same.
> 
> I then tried it with all empty files using the same filenames. The
> issue still occurred. Add or remove one file and the issue goes away.
> I then renamed one of the files to zz.js. Issue still occurs. Renamed
> it to zzz.js. Problem still occurs. Kept going until I got to
> zzzzzz.js and it worked.
> 
> Finally, I got it to the point where running this in an empty mounted
> directory will create the issue:
> 
> rm *.xx; for a in a b c d e f g h ; do for b in 1 2 3 4 5 6 7 ; do
> touch $a$b.xx ; done; done; for a in 1 2 3 4 5; do touch x$a-xx.xx;
> done; touch y0-xxxxxx.xx
> 
> and this will not:
> 
> rm *.xx; for a in a b c d e f g h ; do for b in 1 2 3 4 5 6 7 ; do
> touch $a$b.xx ; done; done; for a in 1 2 3 4 5; do touch x$a-xx.xx;
> done; touch y0-xxxxxxx.xx
> 
> (The difference being one extra x in the last filename.)
> 
> It works in the other direction as well. This causes the issue:
> 
> rm *.xx; for a in a b c d e f g h ; do for b in 1 2 3 4 5 6 7 ; do
> touch $a$b.xx ; done; done; for a in 1 2 3 4 5; do touch x$a-xx.xx;
> done; touch y0-xxx.xx
> 
> This does not:
> 
> rm *.xx; for a in a b c d e f g h ; do for b in 1 2 3 4 5 6 7 ; do
> touch $a$b.xx ; done; done; for a in 1 2 3 4 5; do touch x$a-xx.xx;
> done; touch y0-xx.xx
> 
> There's a four-character window involving the length of the filenames
> where 62 files in a directory causes this issue. There's a little more
> to it than that; it doesn't look like you can just create 61
> two-letter filenames and then one really long one and get the issue.
> 
> So I haven't found the specifics yet, but perhaps due to pure chance
> this directory structure is exactly right to provoke an incredibly
> obscure edge case?

Well it's likely that this is a problem with READDIR, so file content
is not going to be an issue. The file name lengths are the problem.

Also, I'm wondering what the FreeBSD client's directory readdir
arguments are (how much does it request, what are the maximum limits it
negotiates, and so on). Rick?

Since this isn't reproducible (yet) with a Linux client, let's try
another set of network captures, and you can send these to me
privately.

Start the capture
Mount
Run one of the reproducers above
Unmount
Stop the capture

I'd like to see one with v6.13-rc3 and ext4 that works as expected, and
one with the same configuration that fails.

-- 
Chuck Lever

