Return-Path: <linux-nfs+bounces-11687-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EEF0AB568E
	for <lists+linux-nfs@lfdr.de>; Tue, 13 May 2025 15:55:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F3D31B43154
	for <lists+linux-nfs@lfdr.de>; Tue, 13 May 2025 13:55:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8F6F2BCF5A;
	Tue, 13 May 2025 13:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FAa+aedl";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="WtBi+dLZ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E33C028D827;
	Tue, 13 May 2025 13:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747144538; cv=fail; b=brU1R8/SqBb2D+ii1St5iZwGFcfatMtriqbm+4lKN7KKEYwbnNUxM3zwzpsphsCeyRWAKiiQ3mssmjecJwPskE06RYTKB+D+dyu/MuUgXSoGVx2HHF8I6YvovYMm9A7FdW6/LnalmgLziOWpxczGxn8uyRwrH6QrvcPUrDkz5Rs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747144538; c=relaxed/simple;
	bh=ssgdfy9oVlTrGSYHp6tVaAzl0QGU8IrRhimDiEdH64E=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QwoyWIupluvocXvB3ltiigrD6iL6V/9n5nLa4LmE7mR7vpgG2lGD0Kbj2ybuuFIyZMh/ILwFTHqe+vJBN/3+zDAt5P9TdYn3RGaBnY81YAHYoEaS5fPV5HnnQi2dXprVktJBqVsl4E93MCXYteQGHM5c9zIW01jH2M95zQBfsjU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=FAa+aedl; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=WtBi+dLZ; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54DCHL95004878;
	Tue, 13 May 2025 13:50:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=cGqKEiG4rpa9X4AIsbq51KNI/M4uQHVqQYgjlFH6rpc=; b=
	FAa+aedlBrihIlYvphNyOiAMddESBL3k19U1iv5O0Xv/Bah4OQSfJCwwc0am12+t
	3puy5Y4OVL5GLr0pRHAKjbUyY2X5kNoYZ5w4xDG5vQyPidWLBU6a5+oYZwqZK0bJ
	MnZyUmFGgriK8pDH/QT6Nx+5Kf+ApRnGDkSWum62dWCSiKS7S9v386tuUirSFKbg
	qhQTmMdgC3KZugfU+6P2gRk9kTomlXzeCKzy2KieWKnPF3T27H/e7rglf+XmaOoN
	UM4lKf/b9axwGr3cRaCYaxBatU7tpPvFlQcn/HikgCFN+wwbzm4K80mkMFdgrddY
	8apLf/+PrYfnts7jqJeb+Q==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46j059vvsx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 May 2025 13:50:14 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54DD94aR022303;
	Tue, 13 May 2025 13:50:14 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2175.outbound.protection.outlook.com [104.47.57.175])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 46hw89prad-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 May 2025 13:50:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BiodcGaqMnj2Imf7Olu3fV3a50n/1LIC6pubvVw7oiBMQHg3S50355EsjGUFKOpOUCYONSjaeSl3ts8wYjyC1/jC01T5dXwbZmZI+rKtQXNoS2eoITEJfWxKYGNZe+UX6FbWnlbgJyaPokaUuAiwLm69oYr8Dtuan4TZgb9rg8UhqwGbSYTsFGd/4g/8XQCB7AYg+qokckft4nLe9Adl9GxocTYx6IkfHRYo7/9S0aPvWJSC+iQA1CH9qlyTzsTSijnpidS8tNz7aAZ62JVvpYqnMqTOP/JktADusxAvBQ4+3zQ7IzuThHieYJAbfr8g4+yPe+Nb65e7oMMEiNRe8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cGqKEiG4rpa9X4AIsbq51KNI/M4uQHVqQYgjlFH6rpc=;
 b=qaIUnVAUZTaeLr23ko9YjffnnDgCw8gNm10elg9HHwYl4f8FtLZ5pNujpc+wVCNN7FonIVuim5tidCmHyktx5xjWYFWQl0TldI4EgJjjdpCusFyqAXZkouKFeWncg6H+4+JSgmUCffBrfb5RklcnSIudQfnts/51QOIPU2CY4T4QJ+kKNw8osMBD4V608zkka3IBkMqlRtlzSpYJiyP/AW1AUNFRhgSzIiERqOSVBg5vNaXOfA+Sro7SUJ7sU8iFnhIPrizAwSxruur/e89yOTOju0X1xeV9olLm8g5ikOYA/9cBeKPyZkO7Icju2HWqwliL1xkuuAelk2hKMaCJ/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cGqKEiG4rpa9X4AIsbq51KNI/M4uQHVqQYgjlFH6rpc=;
 b=WtBi+dLZAnEqmrudfKE/6ixwttfZihJ/WghF/sbL5n8NjEKIor+PBdv2l/mR0hfMv0lGNATJKqa0TALrvR2PcKz0NN9LY9C40/lKXLmEP4Lw/IxxHvPKta6p96j0SNwLSHDB1GqSkdxcQN979B/SihjrHWz1k4I/ul5rdPWDLs0=
Received: from BY5PR10MB4290.namprd10.prod.outlook.com (2603:10b6:a03:203::15)
 by SA1PR10MB5687.namprd10.prod.outlook.com (2603:10b6:806:23f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.25; Tue, 13 May
 2025 13:50:10 +0000
Received: from BY5PR10MB4290.namprd10.prod.outlook.com
 ([fe80::8c24:37e7:b737:8ba5]) by BY5PR10MB4290.namprd10.prod.outlook.com
 ([fe80::8c24:37e7:b737:8ba5%5]) with mapi id 15.20.8722.027; Tue, 13 May 2025
 13:50:10 +0000
Message-ID: <33bee0b7-cd55-4d1a-9afe-63b3b93420ab@oracle.com>
Date: Tue, 13 May 2025 09:50:08 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] nfs: handle failure of nfs_get_lock_context in unlock
 path
To: Li Lingfeng <lilingfeng3@huawei.com>, trondmy@kernel.org, anna@kernel.org,
        jlayton@kernel.org, bcodding@redhat.com
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai1@huaweicloud.com, houtao1@huawei.com, yi.zhang@huawei.com,
        yangerkun@huawei.com, lilingfeng@huaweicloud.com
References: <20250513074226.3362070-1-lilingfeng3@huawei.com>
Content-Language: en-US
From: Anna Schumaker <anna.schumaker@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20250513074226.3362070-1-lilingfeng3@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR02CA0023.namprd02.prod.outlook.com
 (2603:10b6:610:4e::33) To BY5PR10MB4290.namprd10.prod.outlook.com
 (2603:10b6:a03:203::15)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4290:EE_|SA1PR10MB5687:EE_
X-MS-Office365-Filtering-Correlation-Id: 57e319ba-2a52-4fd9-eed7-08dd9225141d
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?L0RYczY3WEJxamRsN21VWndvVmpNOU1JUytNVDBmRU9OcEZDQ0E0QkZYMGVI?=
 =?utf-8?B?cFZYV0w3RG40cXM1T3l0eHBWWFdGemxoR2NpU1N6dGdaZC9ybS85T2FaRW53?=
 =?utf-8?B?OGY1eDhFTklFZHdBczJoTHByYkRzVWlaUzdIbHBqNjdoZGFLQk1PWlg0Tldu?=
 =?utf-8?B?dGp4eEVzQ2x2MlJqY0pXdnM1SCtIWVBRMjFpRkRwOUVpakFIN3dHUVhVdWN5?=
 =?utf-8?B?Zno3U0U4NEExSU80UDVFYk9ZaFRablNBNWx2Z2lSMmZROVp3MWlJM2thMFRO?=
 =?utf-8?B?TWJST2Q2RzJrNU5HcnAyb0NkdkdXYS9lRjZmK205OHJYeDFDTS9hNWNnYXZO?=
 =?utf-8?B?emN5VXJPSExuNmlQMzZvRVFOVERNVDFlOFVsWWlTY1lsSDVISFFNazNDQWlB?=
 =?utf-8?B?dldaTHRkcGJuZVRLdit4VnZVeEczazVRYVR0S1cvSDJFNS8zaUhycGduTDRN?=
 =?utf-8?B?c2h4bEljeU4xdThhanZQbnNYV2J2OThwQ1c0N0MzY2xWcVh6VzZ4WVJwNlpJ?=
 =?utf-8?B?QnN3Ny83b2dLQ2tlc0FyUVNEYVh4OGZlMk9zZGhTclRQN0xBbW4yVjBsWFJV?=
 =?utf-8?B?UVNqYUQvMEo4U0FORis3RzVRb1pFdnlrazhTSVdhbTBDSWZjd2JDVk5IWlhn?=
 =?utf-8?B?d2haZkN5b3FYRTB1ZmFubmpIVUhEWm5uNncyaUY2U3lMVWJGUnkvNCt2R1Er?=
 =?utf-8?B?azkxai9QdjdlYTIycGZnZnJRSnIvM0FRNElGM05iV3ZGWjBsS0F6d255RUoz?=
 =?utf-8?B?Rmk1RkFHVjRScE5VL295OGtjVjhuYjhNNDRUeDIxMmIzMkFxZnZSekdFL2My?=
 =?utf-8?B?NmkwV2xPTWpXK1pVdmhwL1NWaUZoRGhOTzBQUE5adldWMEtMbFBneXpsUmlv?=
 =?utf-8?B?SGVwKzlLRUd0bHVzUVJIc1R6Sk90Q1M3T0dYaSthSHZuZUNQMFF6Rk9GOHpk?=
 =?utf-8?B?RDc0NmFYREZMODBTM21mNFhvbHpHZlNwZkZuRElDdXhmUEc5U0RSU1NVQ0kr?=
 =?utf-8?B?aWFGWmZJakJBcUpnZEtTcXY3WjMvM2p5RGo5TXJ6bXZ2RkhYcVFoa0gvUFdN?=
 =?utf-8?B?Ly8vRnRTeTZLYjBsVWZCZmNuTDllYlZpdlg4Q1d0ZldTZU1MbEpRRGU5K1Vq?=
 =?utf-8?B?MyswR3RXdEZOMXZwY2dUMEVmelNGMEY4WjRvOW50b3JYWUtGV0lrck1QTVBH?=
 =?utf-8?B?bGUvT3g3YXpwUXlTZ2ViWUlBVjZxM1U1K2VEVE9aVEs2MzU5ditGQTcwVW1K?=
 =?utf-8?B?SU1wVUlZcERzcnVRT09CanZoS2JCenRvaWM3M0pyd0EzQ282NkFmMnZ6Z0RZ?=
 =?utf-8?B?Ykl5N3VoTTFzbjZxU0RFR2h6M3hmU1pXTjFwanIwcDhaRVpwWmpyRkY4a1pi?=
 =?utf-8?B?MjVSaVNSZEkxbWpBeVJBZDdvL1hSRXpheFZHWEpBUG1PK3oyTzdXNzdRWVBj?=
 =?utf-8?B?TFkzL0k1U0R1anJnWXRiQk5rVm5nZXhsaE1jTkxvcFJWekpOa0VkNUdSQk54?=
 =?utf-8?B?amg1bnV1bHZVem92emVoTnJOYWxiN1ZoanB3Wll5M1BOSW51OFM5WmpKbXZt?=
 =?utf-8?B?c2JMZ1l4TEpxcmlKVnlGVDlObGtUKzQvMWxjUStYcFA2SmhpYlJRT0NubXhq?=
 =?utf-8?B?VnNsMG9qOCt4OHc3bXJ6bTJYb2FvYmlXck52ODJiTmplZ25Ea2lrcmM2WFBm?=
 =?utf-8?B?MlpQN1dzbW5xelNVUkx6eGJIYTA2V0xJdndVakM5eXhJYWhGaERPTVJBQkVN?=
 =?utf-8?B?ZS9kcDB3RzJXb1lPNDdyd1FFL0lHS2VaMzNUUUFWQ3VoTUdyeUxZb3dCZkVD?=
 =?utf-8?B?ay9nWmUvdVdEUXNKbWNSOXRsOElsS25FR2xWMy94WVBDMVFCY1dZc3pZK0hq?=
 =?utf-8?B?YlcwN0F5NlQ0bkdmZUdTbXZlOE11OW5wUzdzcGVkc21BcFNyOVpiclpvbnVm?=
 =?utf-8?Q?l1Ro9Ou9kis=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4290.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?MzRwRjNScE14TjNUUnl4Y1JpUGpFQi95NnV2VzdPcXUwWExZQXhXRTVEbEdP?=
 =?utf-8?B?YlYvRll1Wm94SVJDT1NtOGYwQ2R5ZlRaZFBnbWJMZ3hpaDgrc2RVM0lMMlQ5?=
 =?utf-8?B?bFdteFFYYWFLQU9tM1UzSjdFdjdtZGxQVzdrSmUrU1ZkUm03SkNxOHRJR1N3?=
 =?utf-8?B?d2Z3WWtYcXJIdjNXejdEOHdZbGVFYU1ZdmYwazR2N3FnTnF2U0t2bWdFaFkx?=
 =?utf-8?B?UGNYd0NnRU9uNjRuRlJYSWlLQmJzWlAvOGcyRDNMRVJyV01ScVZndHF4QWUv?=
 =?utf-8?B?aVFOZ3ppSjhsZDRReGhOdklKYVB6QXBLZGFnMTlCQk9jZHBjdHN5ZFRGeWt3?=
 =?utf-8?B?OS9CaHYrSjRKMFhHMkFHSGN5ejloaHNyVnFub0o5Ujk4WEFtMm5abTNIUnBY?=
 =?utf-8?B?TXJwQXkzRzZIU292VnJ0ZElFOWZtY01LNjBOQkF4SjY0WmxCU3JaY1VBWVJF?=
 =?utf-8?B?SndGZ3MrNjJoZjQ1cmlUZTZhK3hOd2xaN2IvY1pUbmxDam8rTlJXamkwdHNX?=
 =?utf-8?B?VGg1UE5EY29uQ2FOTmNnbi9wTjRkYVFRaEJzbkl1K2R1MFdWTFp1MkhaWDZo?=
 =?utf-8?B?NVpGRFAwMEJuUmRIV2M0TnFSRW93UGRrMFFwanAwRnBFMUNsejUrczJuUml2?=
 =?utf-8?B?K055b2tVdmE4L2pSUDY0aHMyeVlrSTltOWZoMmhZRmJQZ0VaQzRIaEpWdXVC?=
 =?utf-8?B?blFKRFluNDlUdTVEWWlsZVMxOFcyUTNRS2tKeUt6ZVk4aCt6Uk42czdtcGJk?=
 =?utf-8?B?MlhrTEVRMmRGR3pyRnRSL1Y1MWkyMmNYd0lPeWp5RWt6RU85NC84N2ZER3Iw?=
 =?utf-8?B?bVdjNkIzbWRJeS8vRlNQS1IxR2xPK0JXNFZXL0Q1YzZPMHBaTTd1akVlcFFr?=
 =?utf-8?B?SEplNjJQVHc0ZklsTnVKU0t2Q1ZJU1Qrdm1Hb1ZGTlFwTHJEK2Jrb3hrTUpL?=
 =?utf-8?B?NjNveUVtNW9XYWMyMGNMVDFpNEtGSG5CazFtS01QSUxUTHdnMzFjdWtHazRW?=
 =?utf-8?B?VmlPc0NicEJVR2dKWlRueWpQY2o2NTAvMmw2ekV2NFVSNkJiRUhiVXJZZTJJ?=
 =?utf-8?B?dlkvTWRlbHBvQzRBbW8rTHB2V0dhTUIyNUxxUi83OEdaQS9TRXZpaXRZdlBV?=
 =?utf-8?B?ekY5dWd1Q3NBa2w5QXlhNjhGRmtHNjhFRCtNN1hla2pmdzFvb1ZkYlkvellw?=
 =?utf-8?B?aXpMK3crN0pzVkt1YnA3cVZsdkI4VzVZb3pRU2JueXJHU0JTc2FKdGtDRUhL?=
 =?utf-8?B?b1EzNldkc1NVTEQvUm5DQnR5aFBQSDZFMGhBK2l5Ty9JNk5BclBTU2Z5d09m?=
 =?utf-8?B?TVloeFA2QmV1MGRzREYxTFJDaGZ1dnhqeVAyTkhTWTFwVEY4YTRuMEhBUUcy?=
 =?utf-8?B?VmZncEQ0aVJlU0dBbGtSMzJmb1FZL0dSUUt0LzJxZmJDV2hiNUJtUkdQSzJl?=
 =?utf-8?B?Y0lESlJFdDNmVGYwQ0xCeXZuVTNYMFZ5bGtEYVlnbks1dHhiRDIvVFJQNktw?=
 =?utf-8?B?K0U4cHZENXRTZXovVlFEVlZJN0kwQnJJT2VQWjFudENHenVOeW5YTVJxMndk?=
 =?utf-8?B?UTRsL2hCUTgzZjNSVDgxblJFbjBNZ0xqQ2hyMkZnTEt1cktxeGNEd090SStj?=
 =?utf-8?B?bEtSWjV1SVVBY1ZxSUVwOHFMVTdKUjNjSWNaTzhDUkxlMzlDTlZMeU1waWpJ?=
 =?utf-8?B?eERMT1hEck5MV0FBSG04QmJOcWxiRlRRdG93NjNYQnFtTUhVL0ZNYmI1SW5B?=
 =?utf-8?B?aG9wd0dOSFQ3Z2Y2dVVOWmJ0WW1uK1kvdFZQWnMybGVMQzhjeXJzdVVlM042?=
 =?utf-8?B?ZldVTGs4RXBOUVJFU054QkduSVFsK3dUZGk0MDJUSk9XRDd3MHMvcWxWWC9I?=
 =?utf-8?B?ZEtDS3hVamtJV3h4RWlXZ2VpYlM4TmFSS1dua1A4bVJHK1BDL3ZaYmJ6ZTNE?=
 =?utf-8?B?d3dsYkN3QlcrQzJvUmdTM011UmVmbDd6QUphUDN2NzdTNFZOUDkvMWY3WEJE?=
 =?utf-8?B?STZwM2kvb3RZa2tENHpWT1ovT1UvSk16QURuWnk0YVV5ZnphZWtvQkh2TXM0?=
 =?utf-8?B?eGFwVUk2ZmhUTUN5emJoUDh3dmlySlFsVlR4ZmxYWGUveXR2TU5FWjhnbCtK?=
 =?utf-8?B?NFpwK05lZndzY0pvWUUxdE4xK053QlFYQ3pIN0lWOWhKRnBFMXU3K2ttbCtU?=
 =?utf-8?B?ZVE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ss8BE+BhoF/yQ8Zut9Z32GSU6ElqwhkjwIBZNy/5AapLFDs7ELe5TVAy+AU9xjVTbd/5okpGIgslLHMUhF+DPuYHR/plXViwo7bBuMpREBxm7ezyBXW6lyAScG0lNM4KSxXyR3D8Ef2OtjkZeFXtJFPRUeggOPLsgtUfbsgOViye/x/BCfLUVk1nmyV2eKQdl0YFLrREbcEceIl8IfrxhA1HobMtGNRprH/p0nVsLkRHCn79//ENLQYsh5ohcEcNvW65rdvEWBHvoD4EJcnfbIY2JKwAirojopC7qhYXNp0dHYr2VCCsFqTQQggHmBFQWHWw/CbyStd4aw0EGK2dQsAdsJSv57ong+jrHauEeNdw17gHFAjR2ZX6jMlqqpmuczftFAh+EqYVwjvZd5XWogNwkpNK52w61qRTP9zNu/SF3Ebsltyg/f7qCTG7aJa19FzDFgnYbSEJn6IHoumOVfS6eMAhDfXrYqUkswVVJ+l1gkIiWg02Ce/7o0qbJiKRqPun9dvDdTLrPtPYCo4atXmKc6Z+2KZ8+9QVIm9FKGk9tmIhV9e+EdkdwbDV7U6fdNRKCrDleQzUs9dE3BAXmKPpnci1CJ0MkdykqgaEcnk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57e319ba-2a52-4fd9-eed7-08dd9225141d
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4290.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2025 13:50:10.7971
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5gLk0+mqYawveyFMRd8qeq514DG2Ame3yLTgUljzQZcxQD666EUcFumf7VbgL/ZD2ePi23HIyCyaS+OqhV6y84Qr4GjSwpEAp7GOvWZhWOw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB5687
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-13_02,2025-05-09_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 spamscore=0 malwarescore=0 mlxscore=0 phishscore=0 suspectscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2504070000 definitions=main-2505130131
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTEzMDEzMSBTYWx0ZWRfX1YUhsyu8op+J 2IBWyCOx3nBfrpCeQnce/x+2axTek55nk7Zovhh1ThTILXcznZPAKl5U3anHnRPo0sZyFSO+9NF mJ4sdnd/VFJTjzCbsOu819u7u6bGe+gt8TvsMCOF1NCV7Ut9d7jTvB25SgvViEQdq2+ijf5SQ9b
 /rcm9S2qi2H9IA473R3V3CnJM6Y+be0QaIdwRAgfgM/eD3/4nzaZs70dweTSNfbwGBwt+cUtfjr JnCIl2n0YR1LcAI8ZIltx/ii6jD+92Dl0xMGkEzyqm4ZQbIT1iXOMlcEHEkLi1pArryFZshWCNC BeE9wwp1L4Aww1HR+VkdNlBmOLTsCr7QnCew0ZMuM1Vkqw/T6HzstYmkYkGLZAd4S5sV1PLioSx
 KgiGyR68ZWPv4AifSJSmOpKo2hVdpxdm0SUgposkIHAAIduxWCatrUgTZ+UAXERy9Xlzzzg5
X-Authority-Analysis: v=2.4 cv=RPmzH5i+ c=1 sm=1 tr=0 ts=68234e17 cx=c_pps a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=i0EeH86SAAAA:8 a=BIpzR0kw4EylIUiAi7UA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: L5NO-aH11bVShrsxmYh2r0bbEMZF8GpP
X-Proofpoint-GUID: L5NO-aH11bVShrsxmYh2r0bbEMZF8GpP

Hi Li,

On 5/13/25 3:42 AM, Li Lingfeng wrote:
> When memory is insufficient, the allocation of nfs_lock_context in
> nfs_get_lock_context() fails and returns -ENOMEM. If we mistakenly treat
> an nfs4_unlockdata structure (whose l_ctx member has been set to -ENOMEM)
> as valid and proceed to execute rpc_run_task(), this will trigger a NULL
> pointer dereference in nfs4_locku_prepare. For example:
> 
> BUG: kernel NULL pointer dereference, address: 000000000000000c
> PGD 0 P4D 0
> Oops: Oops: 0000 [#1] SMP PTI
> CPU: 15 UID: 0 PID: 12 Comm: kworker/u64:0 Not tainted 6.15.0-rc2-dirty #60
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-2.fc40
> Workqueue: rpciod rpc_async_schedule
> RIP: 0010:nfs4_locku_prepare+0x35/0xc2
> Code: 89 f2 48 89 fd 48 c7 c7 68 69 ef b5 53 48 8b 8e 90 00 00 00 48 89 f3
> RSP: 0018:ffffbbafc006bdb8 EFLAGS: 00010246
> RAX: 000000000000004b RBX: ffff9b964fc1fa00 RCX: 0000000000000000
> RDX: 0000000000000000 RSI: fffffffffffffff4 RDI: ffff9ba53fddbf40
> RBP: ffff9ba539934000 R08: 0000000000000000 R09: ffffbbafc006bc38
> R10: ffffffffb6b689c8 R11: 0000000000000003 R12: ffff9ba539934030
> R13: 0000000000000001 R14: 0000000004248060 R15: ffffffffb56d1c30
> FS: 0000000000000000(0000) GS:ffff9ba5881f0000(0000) knlGS:00000000
> CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 000000000000000c CR3: 000000093f244000 CR4: 00000000000006f0
> Call Trace:
>  <TASK>
>  __rpc_execute+0xbc/0x480
>  rpc_async_schedule+0x2f/0x40
>  process_one_work+0x232/0x5d0
>  worker_thread+0x1da/0x3d0
>  ? __pfx_worker_thread+0x10/0x10
>  kthread+0x10d/0x240
>  ? __pfx_kthread+0x10/0x10
>  ret_from_fork+0x34/0x50
>  ? __pfx_kthread+0x10/0x10
>  ret_from_fork_asm+0x1a/0x30
>  </TASK>
> Modules linked in:
> CR2: 000000000000000c
> ---[ end trace 0000000000000000 ]---
> 
> Free the allocated nfs4_unlockdata when nfs_get_lock_context() fails and
> return NULL to terminate subsequent rpc_run_task, preventing NULL pointer
> dereference.
> 
> Fixes: f30cb757f680 ("NFS: Always wait for I/O completion before unlock")
> Link: https://lore.kernel.org/all/21817f2c-2971-4568-9ae4-1ccc25f7f1ef@huawei.com/
> Signed-off-by: Li Lingfeng <lilingfeng3@huawei.com>
> ---
> Changes in v2:
>   Add a comment explaining that error handling for ctx acquisition failure
>   is unnecessary.

Thanks for the patch!

> 
>  fs/nfs/nfs4proc.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
> index 970f28dbf253..e52e2ac1ab39 100644
> --- a/fs/nfs/nfs4proc.c
> +++ b/fs/nfs/nfs4proc.c
> @@ -7074,18 +7074,29 @@ static struct nfs4_unlockdata *nfs4_alloc_unlockdata(struct file_lock *fl,
>  	struct nfs4_unlockdata *p;
>  	struct nfs4_state *state = lsp->ls_state;
>  	struct inode *inode = state->inode;
> +	struct nfs_lock_context *l_ctx;
>  
>  	p = kzalloc(sizeof(*p), GFP_KERNEL);
>  	if (p == NULL)
>  		return NULL;
> +	l_ctx = nfs_get_lock_context(ctx);
> +	if (!IS_ERR(l_ctx)) {
> +		p->l_ctx = l_ctx;
> +	} else {
> +		kfree(p);
> +		return NULL;
> +	}

I was thinking the code would look a little neater if this if / else block
was changed to:

        if (IS_ERR(l_ctx)) {
                kfree(p);
                return NULL;
        }

>  	p->arg.fh = NFS_FH(inode);
>  	p->arg.fl = &p->fl;
>  	p->arg.seqid = seqid;
>  	p->res.seqid = seqid;
>  	p->lsp = lsp;
>  	/* Ensure we don't close file until we're done freeing locks! */
> +	/*
> +	 * Since the caller holds a reference to ctx, the refcount must be non-zero.
> +	 * Therefore, error handling for failed ctx acquisition is unnecessary here.
> +	 */
>  	p->ctx = get_nfs_open_context(ctx);
> -	p->l_ctx = nfs_get_lock_context(ctx);
And then update this to set p->l_ctx = l_ctx.

What do you think?
Anna

>  	locks_init_lock(&p->fl);
>  	locks_copy_lock(&p->fl, fl);
>  	p->server = NFS_SERVER(inode);


