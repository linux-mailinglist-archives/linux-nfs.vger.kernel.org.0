Return-Path: <linux-nfs+bounces-4315-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E3ADD918269
	for <lists+linux-nfs@lfdr.de>; Wed, 26 Jun 2024 15:30:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C2A128256C
	for <lists+linux-nfs@lfdr.de>; Wed, 26 Jun 2024 13:30:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8549016EBEE;
	Wed, 26 Jun 2024 13:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="lv6GY1t9";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="mz8nPYa9"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9105716190C
	for <linux-nfs@vger.kernel.org>; Wed, 26 Jun 2024 13:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719408587; cv=fail; b=fHbejnmOJi7WPijmNoKIVAokl4Qq24F9H0AvY4xCFtnCQdCFY49yQ1RC63qAeD9XhLf8Exx5rDbBbDuE5Ji+sHBkGdcBh7Y8LkuuIzf9KCDovfT6qhifSaoDoyGdWP2Sv3lGZlifD0YweEe3kat7RqnxUy3LqMloeKZeJDV3oV8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719408587; c=relaxed/simple;
	bh=lHAxlEKHt3GT7A4kbm0OgCVCSfCqekV9qymdJauVtks=;
	h=Message-ID:Date:Cc:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YFlv/+/K4CYxT1BpfDXLCU6zLyyw2v0xhpsLGS1L62J72yX5LOVldhwdrUn526q+dz9VE4EGivMaG+yjXDoEXMLfoZIc/UIIB5pVwo9MLeTs6IH8rQgKapmu6bISNw9eZKhY8EzPV3tzeHFcp5BYMwrfjs/yk3fLxfNX9nyObSk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=lv6GY1t9; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=mz8nPYa9; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45Q9sHNT025732;
	Wed, 26 Jun 2024 13:29:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:cc:subject:to:references:from:in-reply-to
	:content-type:mime-version; s=corp-2023-11-20; bh=KPKlQ1+/8SNnGF
	Iq+RpXbvN33IVmrG/yynX3GUMES8Q=; b=lv6GY1t97D/AQ5dNJxu1pDCqP+RI0W
	rfkY3kASnRy7NZ5BSX96Lyo1tSz2EXfbJzXdUYhzu5lD0eA9v1+xlmszBWuAbQ20
	hE91kHxUbtfOtrC0P1ZqJhAgk3msVnss8OvNfsUZlS3Q1M7rh8K84csuU6uUUUKN
	I2sZdahnnd1vEIBz4dNj+G2prlnA7OcLzQ461xrqEgByn9AgT8c//9Go5am0Wx1R
	WVWCaYcplZSXyEoHsuWYQwdxu4rdDn8+YN7snsL8M0SXUr4Acq8ZO2sZTUILOy3u
	EWQTH980aYJAJISogFcdUkoY67Ukqc+IrPs1OwGnrMiqWFa9uhSsNT6A==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ywn70bars-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Jun 2024 13:29:37 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45QCKGce023314;
	Wed, 26 Jun 2024 13:29:36 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2041.outbound.protection.outlook.com [104.47.70.41])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ywn2fju42-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Jun 2024 13:29:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XqBQ3K1+ntZsPWbNHdyP6pKrvdoo7IAwlpnxGlvgKfsXfhHfIaoALswWmnbmF0ehcXUiZL+lshVGKIM0y/U17hwAiypMlKl1lEf6ao/bImFMdhQYFn/3PQ0/qwmWmNgxYDHmqG5WxZgDQ7b+8qQBOkerkliu3vEPvkodEPfv4yr+vVNH1TZf+t5uFVQQTVe3jbFFeVTpoWWx4BsEZLXnLLlQd7uDHoLAn6wcSRqucD1gDTgIn4gDpEKicfXbcGu37KMm71CYVnVJj+XDTw/jHTIxASdFDGEUXujiQwS9H73VD3a33vPz32NkMOZSCC28RlAY6G0JhEA26DFWHDIDcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KPKlQ1+/8SNnGFIq+RpXbvN33IVmrG/yynX3GUMES8Q=;
 b=FZ7Wnzx9r4Kqsj3LedYt7JTLGIJXVTAENQE9KAUAZd/2rIvUp+U5lVMIBLOFOJh60WWWMKpXKL3/oOuw41676iPefYCpR7LvyKH2TsNw3ud30YOTyew2Lp3Vk/IPBpUbG6Rp8PBCcEUZjeaB11ae6WyOMgT5KCZVfYgV6FJ05UO/UHAR2rMzQ2luLiwCMtnSD3IdfNn/07fkEFd/8nFqruvhu1irZL8CGzq3YldSIJnpqAp1qLXoge4vvIQ4E+A4vMDgkhaLdJJClSx5WBCESGi2O2DsNKahywehglEha7dv5w+dMHhtKu1x7gKIxy2/pQE9ZO1rnlXd+rIJWYM/GQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KPKlQ1+/8SNnGFIq+RpXbvN33IVmrG/yynX3GUMES8Q=;
 b=mz8nPYa9MD8al9IRWlpC7f/VdAWWlm0Ev+xKo5MmVN8eicgNg3pgogwwCS6Hh53EJnbMRqHZEuQE46aMUf/ViqZ4SfmbBxWCN6s9Qu+WYYAYfvGqLqvb8BcV51y0ChdKIa2ybniFhG0fGUM/4EfNeUG2QJGZfOiKFa/cBobQvDQ=
Received: from BN0PR10MB5143.namprd10.prod.outlook.com (2603:10b6:408:12c::7)
 by PH0PR10MB4630.namprd10.prod.outlook.com (2603:10b6:510:33::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.32; Wed, 26 Jun
 2024 13:29:33 +0000
Received: from BN0PR10MB5143.namprd10.prod.outlook.com
 ([fe80::783:503f:ea07:74c7]) by BN0PR10MB5143.namprd10.prod.outlook.com
 ([fe80::783:503f:ea07:74c7%4]) with mapi id 15.20.7698.032; Wed, 26 Jun 2024
 13:29:33 +0000
Message-ID: <e839cc9e-ea5d-43b1-bada-5fc6a9971837@oracle.com>
Date: Wed, 26 Jun 2024 14:29:28 +0100
User-Agent: Thunderbird Daily
Cc: Calum Mackay <calum.mackay@oracle.com>,
        Olga Kornievskaia
 <aglo@umich.edu>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>
Subject: Re: ktls-utils: question about certificate verification
To: Rick Macklem <rick.macklem@gmail.com>
References: <d489e2d7-d4ed-424b-8994-6abf36a01e06@oracle.com>
 <CAN-5tyFQpEdSnco8SZWY_nsZVdYhAg+x_EAMmbWW5uYutyDA9g@mail.gmail.com>
 <2f5cb9b7-3d8e-4ec6-a357-557c484431c4@oracle.com>
 <CAN-5tyE5XpM750=9rG0cfp4WHRxOtXAwvViVmc4kQEVnA1dmTw@mail.gmail.com>
 <fdd4e4ce-65eb-438e-88c0-2688b7fa196b@oracle.com>
 <CAM5tNy6eLnWd7vLU-K00OJsFxLpWr_S2g8fhbE0ZMMVgonBZZw@mail.gmail.com>
Content-Language: en-GB
From: Calum Mackay <calum.mackay@oracle.com>
Autocrypt: addr=calum.mackay@oracle.com; keydata=
 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
 smRifw1wGg==
Organization: Oracle
In-Reply-To: <CAM5tNy6eLnWd7vLU-K00OJsFxLpWr_S2g8fhbE0ZMMVgonBZZw@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------MdSW0kZ6LTT3C8yl5fQyJYNt"
X-ClientProxiedBy: LO6P265CA0011.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:339::17) To BN0PR10MB5143.namprd10.prod.outlook.com
 (2603:10b6:408:12c::7)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5143:EE_|PH0PR10MB4630:EE_
X-MS-Office365-Filtering-Correlation-Id: 8db80e96-907e-49e3-2f27-08dc95e403e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230038|366014|376012|1800799022;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?WjMxWnozZ3ZIWCsydzdmSEgrM1FPMU04NFYvRUFMZy9lVm15NUZtSTBTNjcy?=
 =?utf-8?B?SUg5eGt6bkJyOFdidW9YWE40VnBJQkErNCtYcFMyQzV1YzF6U2FEZ2JlenUx?=
 =?utf-8?B?M3hhamVHcVZ2UWxta3RxRUZEZ1Vab1ZJODF3Q1MrM2E4MVFTc0ljZ3JwUDVP?=
 =?utf-8?B?Ky9MRnM2VTgrdVprSjVSUEdkMEdiS1N0WHZROFZKaU0zTWJwc2VQdGwwbXlT?=
 =?utf-8?B?bjVjeTE5d2dwQndhTUFnRVBvTmt1aUt6cHJXWXczZHYwcXZYRmtOTU05R21k?=
 =?utf-8?B?U3NRV1p3RWcva1lsdTVWWU8xellOOVJXdEtBenplK1lCd3pNbXpQMGpmaUN5?=
 =?utf-8?B?MG80R0NHMTZGTXdFbmJUU0Z6RGtHK2tjcmRENVhvM2lQYVhmdFFYVDY1QTl0?=
 =?utf-8?B?U3hQMmxrb00yNXhJVkxjdEpFZnRvL2UwMVA5VDhVNGZ0QllhRHNzb01VbVBn?=
 =?utf-8?B?b0ZGMlhqSi96b25wNGxkazMvQWhBZk5SY2tPV3AvT3U1WDhiOUw1V2dRT2V4?=
 =?utf-8?B?VzdOWEcwZWJBbjlPVEdxbVUxbWRuTTN1K1JNSEpET0dPVHo4OGQydWplSWRh?=
 =?utf-8?B?VVlHZ3JVK0E0SEk3d3BWWjJiVE00YVhTZHo4a05XakhnNUVMbXM3c0JlelRu?=
 =?utf-8?B?eDFFQkhVTDRiMjA5SFJvR3ZWK0gzcUFib3ZRMXBrRGpTYUw4aVRsNlViWUZK?=
 =?utf-8?B?WU9FNG9rNWRJUk9qaXgwckd5azRqVXVXR1NjTExtbE1OSTlKZThrQXZRSkxp?=
 =?utf-8?B?VnlabVR5U0Z3SnoxTkEydmFaQUhSZHErWFBweStWSHVqUmROUkF6M3A0Z0tG?=
 =?utf-8?B?bUxUSDg3cVo5YmxENUNnOXE0MUNtbnJGN0xmWm5pWG5IVTFqaG5qdGI0UXVV?=
 =?utf-8?B?ZExlMzFwU2RWVXhhQktDOFFheDQ0L1J5U2k2Zm91eXpFZjZrMUpQa1RRODlK?=
 =?utf-8?B?dXFGWHRmV2pqVXVXalBER0t3Z2puK3ZXNWIrSXUxVW1qSlFvTFlwUzIzYnZG?=
 =?utf-8?B?TnBjdGlaWnlvMWhnZUxaNFFYUW1HY2trZ0RFeHFua1p5cEVzeHhxRGNFKzZx?=
 =?utf-8?B?YUFQMjlSdWJzTDZ0TlhTdWY1T05kYWZwV2czS25sWmJ2MElTWlRya0Q1SnNT?=
 =?utf-8?B?NDBtdHNLK3p2Tjh0TFBydS9sR3EzbWVSZ2VmWUFOc1B4UmdyQ0VyRE5NdytR?=
 =?utf-8?B?TUllV0d5ejIzY2tkSzF0cDZ0YzhFcUVnV0xXMEJzbEUyVUZra0pkSnNVdjVt?=
 =?utf-8?B?ZU11SGVmb0F3bjJvcTVjeEVzeTdsSWZOeXNlUFpmWVptMTZ2L2ZEVS9mNGFE?=
 =?utf-8?B?aXF2T3NydDV2dTlXdnRMY3VuN2pVQzhpYU9GWmpDZkorZWV2TVNyaHlZVVZj?=
 =?utf-8?B?NW4vS0hCWXE4MXdDUjVVWUsyQVlnbTBZMGd2NVVsVTY2TG04NUxxTHFMZ2dN?=
 =?utf-8?B?cHhjRnJmblE0Ykd6M3MzdGFQeko0d2NJOEk0OWc3bUltK2pFYy9lTnJ6Mlh4?=
 =?utf-8?B?SWF6MUxJd1pqd3UrOUE4N0pKYTdRV2Y1ZG1LSjZ1ZlVzLzByd28yMHM4b01a?=
 =?utf-8?B?cU1IUU9vUEdpNTlkNVVBUG1uN2JSbUlKazk1d2dTNGxjOEU2K3pPblhKdW80?=
 =?utf-8?B?WWQ1cXhvdExJblNCWldUNXY2OXlzVU9XQ0VsZjMzYldiMmlPMVFEYWtPM0Nn?=
 =?utf-8?B?MEdDTzZ4MG1TdkJkdGhXRzV2bWlhMGkvaDNZY0tWWmw1L3pNZHErdDhuRHlE?=
 =?utf-8?Q?Ao1U/y6y8qLfvYOUQo=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5143.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230038)(366014)(376012)(1800799022);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?QmFvQ2JJMmxqb3hhVEhuRG1pSDNWOTZFenBPNUE1QkdXd09OR0FnY2FaSjJa?=
 =?utf-8?B?SzlkTUZlL3BUQUROKzdXSTRQNndaZmhRTEticys2UWF3aFZ4cXhGZjVtTk5j?=
 =?utf-8?B?YWFoVHBzRVJSMHV0UDRoRkluV0NKWUJ3QVM4YnZQV3RsT0pQREVwa0creGhm?=
 =?utf-8?B?ekZLNVVFY244NjVTRWRHc0c4T1VubmF2VUkxY3VlbFo2K0lxdFNlUERrNEVo?=
 =?utf-8?B?T2w1SUlIR29GaFNlcWZ1S2F3YXVESy9YOEJjbUtUTEdZNUlab3Qxak1LNnBN?=
 =?utf-8?B?cDBHVXZrRE9DVnlURnlLTU1XZWlWTERWVE5JeTBiM2xsSFpiVUx6ZVVoZ1Ns?=
 =?utf-8?B?Z2dJc3BmWjNJMzdicEhOZUk2UnZrWjlLZ0dia2lJQXlMMHBwcmp1TWxUTks1?=
 =?utf-8?B?VitUdGxOK2pJTkFOMmlKNmdtYm93cGt1NDcwZWc3QjZWb0twUG9XUmFwanQy?=
 =?utf-8?B?WE52bmtsMzMyUnV5MjVtUGFiSXFWTFdPMG1Fd0dncnZEZVFicCt1YnBkb3Rr?=
 =?utf-8?B?T0pZVlJKYmNHclFpUFJUY0lnbFd5MVdhbmprM2xKK0w2OWNYNE42S3RMeFFV?=
 =?utf-8?B?V0Zjdk9CQnhQazJ3bGNId3RZQUtMR2w1K24yck5tbmNOUVlyMERwYmRsd2lj?=
 =?utf-8?B?QWxWV0xhRmZRbllxbmtCcElHTzNMcCtWUzNqaHpQek1tcW4xbko4SUQwOTJ0?=
 =?utf-8?B?NkNUQ3VRUlpmeXp3cUxpMkhMMGRGWlZXZTJxZjF6ek9NNTluYzc4NUVUYlR3?=
 =?utf-8?B?WnQvMGczTS9OcjFnN1FOREMrWkxrUzUyeXZoTHpvVEd5cG8vWTNOZzVlY0ZC?=
 =?utf-8?B?WU90Q3lJYlp2bThES1pmdnQvOE4wQzVjUmZrWXBiU1RmeDJQd2pyTnI1Qzhr?=
 =?utf-8?B?MVFzdWhpU01lN3VRR1lpbEtOVXNQNnAwZ0puUkxmWHhQc0xwTG5ZNWFKK0dX?=
 =?utf-8?B?ZEk5Q1oydE01UXNmSG1BRmRqOFZjeDZTSmpaZyt2MUEzRlNVSVpab2NZV09a?=
 =?utf-8?B?dS9oc3FCby9IcUtpS2JvaEpMK3dQcHF1d1R3bjJ5N2VJS0x1NXhhMnZEY0pE?=
 =?utf-8?B?TkdROUZXQlJ5WFVlR1p4VC9ZbEhTcE1hWTVUbkRVZ1p5ZWRBbzRWNGFlUXds?=
 =?utf-8?B?NmdDcDUzRlE0b1BYODVUdHluZDBmdklZekNDajhFTEtZRUZ2bzc2OHgxQnVI?=
 =?utf-8?B?RFFoMUF2NkRuU0MrVUR1UFovRW9sMkRlQVlsZUhwbE1KMStmbkJhYUVIN25Z?=
 =?utf-8?B?RDJLejdGTGNUd0laZGxsMGhzdi9tM2s5SU1BRWZuR0k4aWkzM2pkWlpWWGdV?=
 =?utf-8?B?N3hjbmRVNWh3WjJVcGxUOGV5eUxKQWI3Z1ljS015Z2UyUkEvT2ZnT2pvdWZI?=
 =?utf-8?B?R2FWMjVTdzAvZEEzdnQ0ZU45MHlJQlBFRFczNTJLKzZ3cXFEU0U2QUdqd0xr?=
 =?utf-8?B?S2hxWk9KVHlNU01GR1N3S3d6RTluTDBWcWQ0QmZMSjlBeWhBbkdFbmhmbDV2?=
 =?utf-8?B?dHdsM0ErTDVVRmN6STEzT0JrTTR5YldhRURJakJsNHNsZWo5V1hWeVptYlgy?=
 =?utf-8?B?UFZINElPZlJrUldTSnZyNVcvWDREOFczOXpGYnZOcndMYTNIM2NFUXUxQkdG?=
 =?utf-8?B?NnBYTHBtS0lKZ3FHdFhvZWlmeUV4K3NDQjg1Nk9OMWJaOHdTWGRuc3dNVlY1?=
 =?utf-8?B?c2F1Q0YxMDhsNnpEVjI1YjhsWXBIVXlxYTduUmxMK0I1elVUOGtTOFVIT3ZS?=
 =?utf-8?B?dEZaV0tyMEpaRHhucnBjbUFjcUpRRmhxRm5qTGdMQk5PNHZ0dENNUGtxclp4?=
 =?utf-8?B?aXVOaHRZUWxlelNlckdWRGorT3Z0dlFtaGJLUW1QRktUaGRGZ2oyU21OMnpm?=
 =?utf-8?B?OEVrOUdrcnFlY1hjSHJzb3VFZXFKenVJQk1zWUw0QjRYbXU2M0p3VFBwRSsz?=
 =?utf-8?B?R3ppQ0VvWEZZV3BXc2tQd0RMbjNBdVhQSDRFa2p0UTJQa05GMDNETFdUWCtJ?=
 =?utf-8?B?elkzZVVQNVhaMVVUQXZZWGR6ZzNnb3I2cjJkL201R3R5QU5EZHZXSE1oUWFa?=
 =?utf-8?B?N3c1SUVDVWw2bU5zaUNsYzJSQm9MaGx3QXpIbmUxdlk0KzVTTWo3NFR6SkNk?=
 =?utf-8?B?SWZJS2VuVE1PcXRvU0tzZVhPZG5TN3VORkNzbmczN2FnTkVjaUxXckg0RHRs?=
 =?utf-8?B?U3c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	4LJZsbL6hT1axjsp9lk626KAnGtlTafiyPSFAWJ47kS5ZtZaTGX6Bd7gyGfQ5YFWIAmuZ6jRytthzTrHoE6m4yx+VbpNOhjlq6zh7jooByy6SeGv2TzPIy+Ek74N7GUgXkUPdqpmorZw1b/Dy2UXIzbuykKYJ13u4AC3uFnCgoKX3g7XqzuUT/IB+6oM2oBDYK1l5HlBPVXKcgJ5dnTe+6RxK895xpruZI0n6c6FD21HEfLpowQA8motRS0wTHITp4agWqmqXXw4fm1T1lCgvPozA6ttnkxOrNmAlYgcLnYJ77Xkv+DkhwS7MyOspKjC9DACS+nP33+xLIbzvweYnPWtKdT9YOCYg8cSZWexMeRAPFu2509GIuze2o0ZGtQtv1LAuICVOgQ4Bd7BG5VGbP6DyQBLKxoftdpO3YVTjsEFqdLVAulJE9R0u0NB4FxzEHr+WxWcMXzshdEmGUtUyPml4cTrgxbSAp/j9mGhsAqi558LZU4EEVOEPQehJI9Kisf3IKXM6qeVKxyvyaL6B4reiDvGUEsoZmeRXhYcpZlU96g+upDIhYGxE9VBZOzA4Fw2h24Eu8AlQa6hXRyNnNgmujVq6CbXU4y0YQOOcoI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8db80e96-907e-49e3-2f27-08dc95e403e2
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5143.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2024 13:29:33.3527
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B5T/2/1eUQhrLS+5Lnq0R9WlmocvVadiFECWmq8f/nzXKKAXQSTDSpyTMOtZHl32qrEw7jWfsV10+qsE8tKQ7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4630
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-26_07,2024-06-25_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 suspectscore=0
 phishscore=0 adultscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2406260100
X-Proofpoint-ORIG-GUID: 9GvvHZnrFviWgJ91F5cFMfpKxpi-hX7m
X-Proofpoint-GUID: 9GvvHZnrFviWgJ91F5cFMfpKxpi-hX7m

--------------MdSW0kZ6LTT3C8yl5fQyJYNt
Content-Type: multipart/mixed; boundary="------------Rn8jxG1NnxThBeqOfGsLEK4r";
 protected-headers="v1"
From: Calum Mackay <calum.mackay@oracle.com>
To: Rick Macklem <rick.macklem@gmail.com>
Cc: Calum Mackay <calum.mackay@oracle.com>, Olga Kornievskaia
 <aglo@umich.edu>, Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
 Chuck Lever <chuck.lever@oracle.com>
Message-ID: <e839cc9e-ea5d-43b1-bada-5fc6a9971837@oracle.com>
Subject: Re: ktls-utils: question about certificate verification
References: <d489e2d7-d4ed-424b-8994-6abf36a01e06@oracle.com>
 <CAN-5tyFQpEdSnco8SZWY_nsZVdYhAg+x_EAMmbWW5uYutyDA9g@mail.gmail.com>
 <2f5cb9b7-3d8e-4ec6-a357-557c484431c4@oracle.com>
 <CAN-5tyE5XpM750=9rG0cfp4WHRxOtXAwvViVmc4kQEVnA1dmTw@mail.gmail.com>
 <fdd4e4ce-65eb-438e-88c0-2688b7fa196b@oracle.com>
 <CAM5tNy6eLnWd7vLU-K00OJsFxLpWr_S2g8fhbE0ZMMVgonBZZw@mail.gmail.com>
In-Reply-To: <CAM5tNy6eLnWd7vLU-K00OJsFxLpWr_S2g8fhbE0ZMMVgonBZZw@mail.gmail.com>

--------------Rn8jxG1NnxThBeqOfGsLEK4r
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 26/06/2024 2:04 am, Rick Macklem wrote:
> On Tue, Jun 25, 2024 at 12:48 PM Calum Mackay <calum.mackay@oracle.com> wrote:
>>
>> On 25/06/2024 6:31 pm, Olga Kornievskaia wrote:
>>> On Fri, Jun 21, 2024 at 1:39 PM Calum Mackay <calum.mackay@oracle.com> wrote:
>>>>
>>>> On 21/06/2024 4:33 pm, Olga Kornievskaia wrote:
>>>>> Hi Calum,
>>>>>
>>>>> My surprise was to find that having the DNS name in CN was not
>>>>> sufficient when a SAN (with IP) is present. Apparently it's the old
>>>>> way of automatically putting the DNS name in CN and these days it's
>>>>> preferred to have it in the SAN.
>>>>>
>>>>> If the infrastructure doesn't require pnfs (ie mounting by IP) then it
>>>>> doesn't matter where the DNS name is put in the certificate whether it
>>>>> is in CN or the SAN. However, I found out that for pnfs server like
>>>>> ONTAP, the certificate must contain SAN with ipAddress and dnsName
>>>>
>>>> Noted, thanks very much Olga, that's useful.
>>>>
>>>>> extensions regardless of having DNS in CN. I have not tried doing
>>>>> wildcards (in SAN for the DNS name) but I assumed gnuTLS would accept
>>>>> them. I should try it.
>>>>
>>>> Wildcard didn't seem to work for me in CN, but I may not have tried it
>>>> in SAN; I'll do that too.
>>>
>>> I have tried to use a wildcard in the SAN and that didn't work for me.
>>> How about you? Specifically, I tried in the SAN
>>> "DS:netapp*.linux.fake" and tried to mount netapp119.linux.fake which
>>> failed with "certificate owner unexpected" (meaning certificate didnt
>>> find anything match to netapp119.linux.fake.
> I don't know if this helps, but at least for the OpenSSL libraries, wildcards
> can optionally match a component in a DNS name or multiple components.
> For example:
> *.linux.fake could match netapp119.linux.fake, but not
> netapp119.subnet.linux.fake
> OR
> *.linux.fake could match both netapp119.linux.fake and
> netapp119.subnet.linux.fake
> OR
> *.linux.fake does not match anything.
> 
> Which of the above is true depends on whether an argument to X509_check_host()
> is set to X509_CHECK_FLAG_MULTI_LABEL_WILDCARDS, 0, or
> X509_CHECK_FLAG_NO_WILDCARDS.
> - I made X509_CHECK_FLAG_NO_WILDCARDS the default in FreeBSD, but it
>    can optionally be set to either of the other values.
> 
> I don't know if you guys use a similar call? rick

Thanks Rick.

The Linux handshake implementation (tlshd, in pkg ktls-utils) uses the 
gnutls library, rather than openssl. gnutls does consider wildcards when 
hostname matching by default, and tlshd doesn't disable that.


I've just noticed, in the gnutls docs:

https://gnutls.org/manual/gnutls.html#X509-certificate-API
> gnutls_x509_crt_check_hostname2
> … [wildcards] are only considered if the domain name consists of three components or more, and the wildcard starts at the leftmost position

tlshd uses gnutls_certificate_verify_peers3() rather than 
gnutls_x509_crt_check_hostname2(), and the …peers3() function does check 
the hostname, so presumably the same restriction applies.


That would suggest that Olga's example ["netapp*.linux.fake"] wouldn't 
be expected to work, since the wildcard isn't at the leftmost position.

However, my testing was using "*.dept.domain.com", which appears to 
follow the rule above.


gnutls doesn't seem to have quite the same level of option granularity 
that you show above for openssl.


I'll test further later today.

cheers,
calum.

> 
>>
>> hi Olga, yes, exactly the same here. Wildcards don't work for me in
>> either CN or SAN.
>>
>> What I've been doing in my testing, when the host full DNS name is > 64
>> chars, is to use the simple hostname as the CN (for ease of
>> identification in e.g. "trust list") and the full DNS name in a SAN DNS:
>> extension, and that is working well.
>>
>> thanks,
>> calum.
>>
>>

-- 
Calum Mackay
Linux Kernel Engineering
Oracle Linux and Virtualisation


--------------Rn8jxG1NnxThBeqOfGsLEK4r--

--------------MdSW0kZ6LTT3C8yl5fQyJYNt
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEE1GBbrQYgx8o9Vdw+hSPvAG3BU+IFAmZ8F7gFAwAAAAAACgkQhSPvAG3BU+LF
eA/+KpUgDqS30gCDcJ2j+MHAxLyb9KeV3TSB3Z5f/9ZMhUHy8Q78N5U4qheoZnppBSvoZLje7JGT
fijqXLywWaEazPosRJX/2dzkkNCkI6bhJLuTnrdcIHEpgJjXiUGszlG4T9YYvbtlkDYDvHUUA05G
u05DlhKjcEIcarDj+r2CxARdRiolmGC0XgGB6I/PvgAV+bkkHFbeOfh7tw5i7WWKgn+vOjexKKYN
GRlqHhxsaA5IMoXR+ivP7rdL9wpVXM/VEHZs4PoglM4WdDPJPmlxuEOXhd0Udb+sbnxBBzIkZ8uG
XPI5KqPIRoOrzpO4hNtGEIWSDpoZ1HwjMrZwdJWKPj2hGxTpZlZMSrK/S6tOL+fgLjsUQftDFnm2
PUfMKLH35CyzhMnhyIfTZ5tyX8e0Pi9X99bwU+K5n0uiCk5u2dahLPbahyp+mjwp6ISoGMGlZTVl
ugGSEdg73mqRtTyoJcaCz42DT8KyFcpz7m02A3LTDaLu9/Ty3zGS/mr0+iBjO8hkDJ2XRhw0AtKU
UUwcVlO5pMOXS33uvgzBjBLrdjTx6DIFk0eoHjL5gfqa4vPpBPQzicefnwPDJOUFd1jeh69GdQbB
WlFpvVxGA++M+xeUp2uOE76ACfF+xa9ADnRIf5qQk7af9wTNBeXybBTgsJ8SOukBKpDOjBNuJUXU
Nd4=
=+Giu
-----END PGP SIGNATURE-----

--------------MdSW0kZ6LTT3C8yl5fQyJYNt--

