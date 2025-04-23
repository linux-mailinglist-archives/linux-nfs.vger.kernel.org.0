Return-Path: <linux-nfs+bounces-11234-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D93CDA98F54
	for <lists+linux-nfs@lfdr.de>; Wed, 23 Apr 2025 17:07:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C4F51B86973
	for <lists+linux-nfs@lfdr.de>; Wed, 23 Apr 2025 15:01:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C1042820C1;
	Wed, 23 Apr 2025 14:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Uwb2/Tf4";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="RVc+BUzR"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 218D828369C
	for <linux-nfs@vger.kernel.org>; Wed, 23 Apr 2025 14:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745420394; cv=fail; b=tH8aA8r0sdjZ3v6gKKsHpOJRHHv8JS+4v50q6RZBDaVT3JCJlVWfLhQVD0BztZLjiCRuirNfhTrxqpUFe/okYiVJVPsc1fdp8lozBBWxeHLQ1aozvcH8bkZhL/0ivCQIelCkdViEi92J1/U9oi+TVydzEH3yJOkRBzd1EybpnhQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745420394; c=relaxed/simple;
	bh=CVQwswweIGAErDGV5cFbco+yFRbtCSM0LrThczrHt5Q=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DSVLW+V2fsZd7j1k4gyuO4sTWYTIUyUM6H4ddDgFiJVQdvDEvyFA/OjwguCsNfdNYPB1IBLvxBAgAQcPHtNkEjaL43DNxeC9AU+K8uqQNY7LzVuDishP8G2AG4cR9OYNTBmtdNlzq9BrUxw+89dMIwlOuujhJftaQEJuWb14NYE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Uwb2/Tf4; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=RVc+BUzR; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53NEfxw2026183;
	Wed, 23 Apr 2025 14:59:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=G0wwNEcgGyCcQM5zLlfaJy4QorW27s99zo1zQA7sPhY=; b=
	Uwb2/Tf4xfd5162hRRWNk2NzofVvrV6aNtLjhhP/6T84eI8b5wS+rnMa6qMDOgj/
	DWiNmdUzMq2Sw/pw5mZJp008TzRdaoO6xWWbETS9aGITiM8pXk3+DLOTOKM1WPwh
	343wnnMp434JWBzZRFK24R1gKvM1pLTP6BvkH5YLyuX/QVhs81VM5ivFRAJNzqhJ
	e50iFDEtDZTlaWcxBt897rnkTgYMdlbi6e+dEvR5WzkKk2z8dcgN9GFfXdAcvVZ4
	mrZWaJ0xhF3C9o/Wu6jtfdLcLM06MG6yBkKWaTiBGoTovX+qePX7xoad/g3uX2ne
	ULvqwWCMEvpzDGTwlcB/Hg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 466jhdhfk1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Apr 2025 14:59:39 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53NEj4DE025324;
	Wed, 23 Apr 2025 14:59:39 GMT
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazlp17012038.outbound.protection.outlook.com [40.93.1.38])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 466jbqrsna-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Apr 2025 14:59:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FDDvLxAuY+W/uB9ppfnDHy5y2QIr6MWZN/CiJy9Vjx6hYu6lU517EBvZXDxVqAFkHgLn8m+0zzFd9u/F4YbuKFVhTLJUu/7fRHyrqHox3k/n56o286o+1vJAmTY9HGPL2t81I4y6BnBx0UJaqMO14vyf0qflYsIjhWQzGV9Um1jIf8B+veqRYlEoY4ZLS7quN27kl8ErPp0Pnh+lB4LT0E+0VKWWjeignHXPLqJMLjgRPMnFnqrRJN960pWhsBObbyDVAM9xS0RhCgoQkyDD1rrsLceyx0qu9fHY3U2Utdk6mtJ2esAKJl2JyenOVrry3azxRBMzc1oyDrpdNgO//w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G0wwNEcgGyCcQM5zLlfaJy4QorW27s99zo1zQA7sPhY=;
 b=CTQiYAiHXulI5q4LzVwaO4pdhWQCihJsWQKhiCevbPoN14IPs3aKNRQ4+34JOywrDY3s2iwryT4XMfkqkM8NDKeVZUgrKkj9pluf1MYCaomAOKhKF60raYnJ7G7J3DncT/HLv27aPy2PF13Nb+KgxAPWnBk6F5QK2es9sQY9/8yimbPhR5FI/XaSItRUX91FmXIvW8QdEiUinBQDP/GpkeWH9ZozUqluDmJt9qTtRmquWy39HUHBz3jZN4+q9wKrho9jPCrOUIuMQR1/YtMAlcqFq1HNtliTUr3g6qllbdvN83uLMYKc2lMGpeChPuADYpv/fJMuZbP139UO6kRwHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G0wwNEcgGyCcQM5zLlfaJy4QorW27s99zo1zQA7sPhY=;
 b=RVc+BUzRaPlg48ts94fsJjOMLEvcG+8ENwAlI2AWAkqkjoO2AQJDkmiDArpBlvQmF2w9IyQQtclRNwK1HL+W8lR+my27hC7RURRTVFeiNERRvKuOBjDZ+JK4V4l1KARI4+hI0ANtKmX54qGv4AjNb/utSCKXD/+5cPGKlC9KDzI=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CH2PR10MB4229.namprd10.prod.outlook.com (2603:10b6:610:7a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.23; Wed, 23 Apr
 2025 14:59:34 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%7]) with mapi id 15.20.8655.033; Wed, 23 Apr 2025
 14:59:34 +0000
Message-ID: <138082b9-d35d-4f7f-a34f-1a2b7cb88510@oracle.com>
Date: Wed, 23 Apr 2025 10:59:31 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] nfs: add dummy definition for nfsd_file
To: NeilBrown <neilb@suse.de>, =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>
Cc: Mike Snitzer <snitzer@kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
        Anna Schumaker <anna.schumaker@oracle.com>, linux-nfs@vger.kernel.org,
        Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
        Jeff Layton <jlayton@kernel.org>,
        Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>,
        Anna Schumaker <anna@kernel.org>
References: <> <20250422201609.gkcgjgdljd2u4rx7@pali>
 <174535888011.500591.1496684320777038856@noble.neil.brown.name>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <174535888011.500591.1496684320777038856@noble.neil.brown.name>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH2PR15CA0019.namprd15.prod.outlook.com
 (2603:10b6:610:51::29) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|CH2PR10MB4229:EE_
X-MS-Office365-Filtering-Correlation-Id: f3e1d232-f21f-4e4f-6f37-08dd8277754b
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?MWFaOWM0ZnN1MDU3RmtiQXEySTRhN3A4Qkd6Zk5IKzJLM3A2UjBEcEU4NWp5?=
 =?utf-8?B?TDFGaERycVZ6TmNhQzJkOUJ6SVJjdnA0NXBRWEg1YkoxRUNQREZRalVOZzh0?=
 =?utf-8?B?Wkgybi82cVNwQnFRaXM2dndaemlUcWF1cDExcW9adXkxNHpQTFVabm9jZVZn?=
 =?utf-8?B?Q3BDLzZaUFVFYWZWWGV3WlZXblpoSkpLTjFxSlVOb3UraDZybHNOQkNKWG1R?=
 =?utf-8?B?STFYa3VBSFA2MW1TdHFjcDJJb252SmpWc0Urbm5pZmduK21jbUxkWXFtU3A4?=
 =?utf-8?B?R0VjS2xmT0lhL24rR0FrdHVGb1RiL2Nla3BzUnd4MGdudmpYQmJNNEdoTEhD?=
 =?utf-8?B?OFYzTHNoRFNNWXlEbTRLVGNEZzA2dFd4bURqbzh0dnpvcWVwZ29vWG1ramxm?=
 =?utf-8?B?VGYxSkw4OVIxb2tyS0I0VEQ1ak9DcW1BRFU3eFgvVVRGRG90NTBUdE9NVWRy?=
 =?utf-8?B?N1lzaXpzZWc1UEtVV1l1SnRLaUVXUEprbTdaUlNHVStTK1dIRVN5U2xNb0dq?=
 =?utf-8?B?UjFVN0pRV1dTeFMrN2daZWtrejNsNldnUUZVWEljSmN2eDNpd0ZuQlprWFRu?=
 =?utf-8?B?TkVCZ1BGa3Y1MkFEemRMYW5WQzRsWGg5QkRoUlo1Z0FUS1Zvc0VuYW9iYldZ?=
 =?utf-8?B?OURGUlFlT3V3MisxcS9ETThQNkczbG52eTNDSGk3SjljMVhpaURoVDlEckN2?=
 =?utf-8?B?dUtFcEFmc0svOVdxNndHN0JtQWI5eEk0UFJBTU5ZY2pRUGJwMWNZbmowc0xU?=
 =?utf-8?B?QkduS1RQYUFHR2FucVg1bTRNekxLdmpBYzl1M2UyMlREaWlndnorVVNUdWQw?=
 =?utf-8?B?dlpaVjZwOEQ3MGU4R0RpSXBPK3l0NENZU2t0bC9maWFUODd5dzlQbE82ZTdl?=
 =?utf-8?B?czM2dkQvemdKR09BZm01UUR4L0h0KzVaLzF4S1JNeXAweWJLZ3h3Q2UraEFj?=
 =?utf-8?B?NmZLcldQL2F4NUI1Z2NjYTlkWTZNcGtjMWxkNEtPOW5OU3NYWFZFMjFwbXcy?=
 =?utf-8?B?elVGQ3lUOHBFMjd0TWU5RVA2MG4xUy9DMXo1TE9wMG1yRnlSbHpwSG52MkVw?=
 =?utf-8?B?SkpKUXl4ZlZoM1JBZ1Q1YXFzOVJCakloM2VreVVRcHlrMHJ0ZFVjZUhSSi9t?=
 =?utf-8?B?UWVFVzZNQjdSak1VenRPV25kb0xobGM1TlBSTFB3bzR3a0lLdG5DNzlTR3Zr?=
 =?utf-8?B?THdKRndlOU9JZXE1NDVwbDdBR3FzV2hncUhXNk9vSnRsV0hLcDh0TXp1T2J5?=
 =?utf-8?B?V2dvNnJqWWdvMFp1SmZldlpYV1c5RUdhQ0l1VTVnYi9ORHJCN1R4cTJSWVBs?=
 =?utf-8?B?UG9wdGJuU2g2dTFlVHoyME5HbzVQbUR2RU5XT3ZxNjBpZ0ppTXN2NXdsRE9R?=
 =?utf-8?B?MGUvQWtsZCt6TVVyY2ZZUDI5ZVRyTUdtZlJuTWp1RGlMRDhaN1BZcXg4eFdE?=
 =?utf-8?B?c3RqT2tPd0JWbitvWHlzN2J6OUlvU3NRRmNHSU9BYVcyb2ZVaWw1WHpKRnJy?=
 =?utf-8?B?dzVmdGs1ZTdyVmQ3RGlUa0VPUE5kRzU1WTV0NTVPb3o3b0wxZzI3VXdORmxi?=
 =?utf-8?B?SVhWQ09TTWZoZWNiRjl6TmtYb2JQcGwzMVdyVi9GQ053K05QT2N2R2F6WjBX?=
 =?utf-8?B?Rmc3R1B1em9ySGgzcTlqT3M5bjh4VDBYeUJSMGhOMlIrV21pc2ZZcEVoSjdH?=
 =?utf-8?B?dmdsViszdWErWU1ua2h3SHVHL3ZERzBGZUE1bzdqSzE3Z1puWW5hQllxUmlv?=
 =?utf-8?B?eSsxOG5EZkhBUlZqL1FIaVRGRldicUhrY2QzV3NGNFoyMTBrR2czdkhlWFJF?=
 =?utf-8?B?Q3d2cVNEU3JIN1VwM0FMM0l6Z3gvMFU5UkxON2FRbU5FdXBkNFM3Y0NhVVVn?=
 =?utf-8?B?VHNoYS9SQWZqOWI3cnZJU0QxcWlMWUpKVDlFS2FpeEJSeGpCR3F4TkZ4Q3Yv?=
 =?utf-8?Q?NgAr/YFqwkw=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?aFpLcXQrVmI4WDEwZTc4ODRoRTlQL0V3NUxCcXNLTTBnYmpUNTd5bVNOSmI0?=
 =?utf-8?B?UWJ2SjYrZCt2L3JlQy8ydzNBRkJDWUt6VVJ3ejB3WkFQdUwrQWRJVXMwYTd4?=
 =?utf-8?B?VjVqWktndlpROElFTzQ5cjZrQ2wrSHpwZm10aFZlZzJBZE1pUmllZmFMdUIy?=
 =?utf-8?B?ekJKN2RJM3dmRkpyU3FZUW1DZ25MckJTNFR3Q0lwYTd5U0dXVVlnWVZ2VUh2?=
 =?utf-8?B?OFYvLzhsWmpvQlBJRmtHeStCUTFPTmI1Wi9mYVBOZkVlQm5NcGpnTHFrVjN5?=
 =?utf-8?B?UHEvc3NPeGt4YjU0TnJGeCtBUzVxdFlsUEtxUXVmdmd2MFpSV1BaM3lTWm93?=
 =?utf-8?B?TnN3UWZJYWt0RVVxQ3pwR042R2JKQ05aV1lLUW5UaUVnNUNWOWllZlJ1UnRx?=
 =?utf-8?B?TC8yZWkvc0pGR3ZqS0ZWSTlYSVFrbHo4S0tLZHZqbmRJbENubmFNeENML3Qv?=
 =?utf-8?B?cTl4OW1WNGVFaytuR2FVOTRHQkpvWjcvWURZdUs4Wm5jRDVVYmlMOEN1ZGc4?=
 =?utf-8?B?OEZJS2x5ejY3ejNKSThKeXBDWWg1TG5pcEdjVE1UZCsrbnV2NHVLb05kY1lX?=
 =?utf-8?B?dWI2UGNZTGQ4UHNFSDNFbzIxTld3djFSMnltOTZQeEN3RkJJUUpBMkt2Sm92?=
 =?utf-8?B?R3dxNkJ0SVJka0FlZmk4TjI3L2pQU0dxZDhaUmJFOG1TRTV4ZHg4eWZ0T1dT?=
 =?utf-8?B?cWhLNFJFWGtXc0F6dnZuTXM5Umw1N0ZxQTYrWUNHb1JMMHBZUnM5SUxyaHEy?=
 =?utf-8?B?K2lLMGdCNlJHSEduU1hpU3ZkaWMxRWxOM3h0bGUrWFg5WURmSnZMSnpybWFu?=
 =?utf-8?B?ZXFsTFc4ZEhudCs1cnZNcy9PMitwK01Db1g4RkFrTjBOQ0pvSlNXcTFCdTg1?=
 =?utf-8?B?RjZZR1ZsTTluTFJ2NmdlRzlFTEpEdjhGNGFaaFpQS21taEJsSE1FS0JaVTBV?=
 =?utf-8?B?SDhML01UbWl6c0xZNW81NjRxWGtwaERFWUQ0R3ZjWUZsbXVGL0VYV09tR25W?=
 =?utf-8?B?MCtIci9JMVFGbEJpcUhyR0JFQ0E4VEVFWnFjcWxDVlAvY0tXYXhWOWRRby9s?=
 =?utf-8?B?UWlnYlgyekoyRjJNcTJxL25NcDIzVGxQMGxHTWJ5UisxSXVrVVNLZjdlWVJv?=
 =?utf-8?B?TmZiR3RRdVdWKy9DY0xhUU56M1pqc2F1b3U5ZkxtMHhSNDlsT0JIRWpsNVA0?=
 =?utf-8?B?U0FPQSsxOUlJbzJuaFd6cWN1clI0dzBUWnZoc0lwbHRtVEVZaWl4UHc4R2VN?=
 =?utf-8?B?dEc0UUdRRGI1UythekdZZllIVjZESEsrcTdQRDc3THFiVzE1SXdocEhWYS84?=
 =?utf-8?B?M0FNQWJNdHJhelFXbjBUU0JaQzdMdkRKV0F2RzFQaFdFbUtOV0FVZHFzWTFr?=
 =?utf-8?B?WHV6aWxaS2xmUUhlTE5yZDlVZVFQVXhjaU5qYkN5aGVjQ096cXNicVRaWjha?=
 =?utf-8?B?MC9hczZNVHZEUnlocXFVWDMrYjZVY2IxRVZaMVhtczM2VVRGbFgwNVlGaG45?=
 =?utf-8?B?R0tPdDdyNUwraW1FRjluVEFrVnQwMGlSVHVMZmNZUjByVUlzaXpVVW9kSk8v?=
 =?utf-8?B?UndzUU1kMFRkdmJvOHRDQ1FpV0NxdG9maThrcGpPK3pQZXlDdy9QT0ZkKzFa?=
 =?utf-8?B?WmYyR0JwMVRMVWh6dXl4MElGQUtFK0RtMEJZQklNeHRzaG90RnVuemxJUG9Z?=
 =?utf-8?B?N2RXMFhPRWFXSTYzUzc5TmtaSFAwZWN5cUVEM2MwdmNrcWpsWSs3ZWluZnN6?=
 =?utf-8?B?MDdlTWFnTUhsQnE0S3FRNXd1MlFXTWZIZkhWY2hzOWNYcXpOUXFWQ2ZrbURD?=
 =?utf-8?B?NlVSRm9KaHFoZTVuMlZtL1g1dUl3UEtmQWMxRUdJblhPRUFST3dWZHFQMFBx?=
 =?utf-8?B?eFRPQ3o5eHplam9xd3hHNVpQb0J3dFNSZzBDbFdVUVFoK005cjNsUXlZNmx5?=
 =?utf-8?B?SU41d3ZVQTRnQXpFWFphVi9nOW4xRk1CYzIrL0E1YVJFQUdjRFRlTExEK0dU?=
 =?utf-8?B?bVpyYzhKeDdaWGR3SHd5MG5JckRFTXppcjhMc1RqYlRHS1VZZVhTRU1qbEdI?=
 =?utf-8?B?Q3RzUEhiWFdocVR0U3N1NlRmS0syTHVJUmRJZjVLTVdlWTV1MmZxeXBrTDdx?=
 =?utf-8?Q?pHkx7PGYASHMJ/wlNlsr1PBL4?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	XKJNwAfItzEvueJiWrPEg6K6I18/nj+tbK7JhveUu2CzkiQ3ufp76FpgQ7IVZ/YOO+w8V4zvxO7XbpiKMPEGvBse64mrOwY6fVCz1Xj9wXttuG+lYXIwG4hQO/e5Vd/RF1LbKGZVyg7SpRyECi4ehLvhAeFcMGgvByMNkkli6p9MWFGwA+VcizTurBLDv9tbqgJaS3TY2xoQBecUrChvxWvgH3j1l0h5rWLearfHVO241AIeoEeS44WvpvFPxgrIQuoUTV77OStPXDByX04f3STasEmCgvUVPcwRpFYC4acARal6vr12ZwkzFHIS8B7Ev3bkjq21EKE7LDFPozyV02UW2BkaUEXG4y4IVbUGuvZW/miJnFEs1puSSX+jKtO2xwSZsq93Kj+Y0kOs/iPxfaRsNZivTwF5dUK9s+Sbav8pQ81Oz2T6OWHlyePbXRUr1v11vWXfJj8AbgsOR6flmX+EEGPVjcLeLGuqoLhB5A1XCCivMqNq9JAc4rLzrkjiFDahMMh04D7gU4kC0XA2lHsW051PDCo7tvAzwDbkGF3gihhA34wUMLL9qSYFFx4CS8XFUITTAofGIuSKmHPejX7YmhCPIzWvWtmA4tFmytM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3e1d232-f21f-4e4f-6f37-08dd8277754b
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2025 14:59:33.9958
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wvfMP36tilZ2tzXj4fZgnf7N6m+0FZYlFgrvrLGKQMNYMH0IQ+ba2yqjA6HqSJYz4KfhytxiJ4YsRo+/5lHTKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4229
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.680,FMLib:17.12.80.40
 definitions=2025-04-23_08,2025-04-22_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999
 suspectscore=0 malwarescore=0 bulkscore=0 phishscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2504070000 definitions=main-2504230105
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDIzMDEwNSBTYWx0ZWRfXxvgcXQ3bKGFE bpMYGV/QgxxvH1ma3HfXbT3UEK3PogJJCUy3ysflX3iSAPKkBR0HSg23FSCTE2XbUKu2gjEtuE/ Vb0iagTUUG38RyesLOXgrdYZh/j8NMNY+adIGq8+sEKY3xUx7X0lhZ5QfODpysmhNTipzHCWhwO
 V8lIIwPWe4m3wUFH4COk3NWzsndZqlgMI0oZkImUwdR+DHnIx0jqJ4t7Z2admEYKoZDWkR/46Fd LlFWpUlfWkwlIremIlfl7w0ZgG30pSFt/uSQed5RKfRisOCk18fwHTm5GiWTBGkbhk04U62QHGF FwLNvtdVIAGyYYchrkQom0ACmtk8rU1KVdyEGFfr1SESqmJ6laz6Ia2wNSDyYbkcCJ4HPvVu+Du t4rjxGXK
X-Proofpoint-ORIG-GUID: dhjXtpu83FX9w4fGfk9N0_kFp7hcCOyG
X-Proofpoint-GUID: dhjXtpu83FX9w4fGfk9N0_kFp7hcCOyG

On 4/22/25 5:54 PM, NeilBrown wrote:
> On Wed, 23 Apr 2025, Pali Rohár wrote:
>> On Sunday 20 April 2025 12:12:22 Mike Snitzer wrote:
>>> On Sat, Apr 19, 2025 at 01:52:31PM -0400, Chuck Lever wrote:
>>>> On 4/18/25 5:34 PM, Mike Snitzer wrote:
>>>>> On Wed, Apr 16, 2025 at 09:31:55AM -0400, Chuck Lever wrote:
>>>>>> On 4/15/25 10:41 PM, Vincent Mailhol wrote:
>>>>>>> +CC: Neil Brown
>>>>>>> +CC: Olga Kornievskaia
>>>>>>> +CC: Dai Ngo
>>>>>>> +CC: Tom Talpey
>>>>>>> +CC: Trond Myklebust
>>>>>>> +CC: Anna Schumaker
>>>>>>>
>>>>>>> (just to make sure that anyone listed in
>>>>>>>
>>>>>>>   ./scripts/get_maintainer.pl fs/nfs_common/nfslocalio.c
>>>>>>>
>>>>>>> get copied).
>>>>>>>
>>>>>>> Here is the link to the full thread:
>>>>>>>
>>>>>>>   https://lore.kernel.org/all/Z_coQbSdvMWD92IA@kernel.org/
>>>>>>>
>>>>>>>
>>>>>>> On 10/04/2025 at 11:09, Mike Snitzer:
>>>>>>>> Add dummy definition for nfsd_file in both nfslocalio.c and localio.c
>>>>>>>> so various compilers (e.g. gcc 8.5.0 and 9.5.0) can be used. Otherwise
>>>>>>>> RCU code (rcu_dereference and rcu_access_pointer) will dereference
>>>>>>>> what should just be an opaque pointer (by using typeof(*ptr)).
>>>>>>>>
>>>>>>>> Fixes: 86e00412254a ("nfs: cache all open LOCALIO nfsd_file(s) in client")
>>>>>>>> Cc: stable@vger.kernel.org
>>>>>>>> Tested-by: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
>>>>>>>> Tested-by: Pali Rohár <pali@kernel.org>
>>>>>>>> Tested-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
>>>>>>>> Signed-off-by: Mike Snitzer <snitzer@kernel.org>
>>>>>>>
>>>>>>> Hi everyone,
>>>>>>>
>>>>>>> The build has been broken for several weeks already. Does anyone have
>>>>>>> intention to pick-up this patch?
>>>>>>>
>>>>>>> (please ignore if someone already picked it up and if it is already on
>>>>>>> its way to Linus's tree).
>>>>>>
>>>>>> I assumed that, like all LOCALIO-related changes, this fix would go
>>>>>> in through the NFS client tree. Let me know if it needs to go via NFSD.
>>>>>
>>>>> Since we haven't heard from Trond or Anna about it, I think you'd be
>>>>> perfectly fine to pick it up.  It is a compiler fixup associated with
>>>>> nfd_file being kept opaque to the client -- but given it is "struct
>>>>> nfsd_file" that gives you full license to grab it (IMO).
>>>>>
>>>>> I'm also unaware of any conflicting changes in the NFS client tree.
>>>>
>>>> Hi Mike -
>>>>
>>>> I just looked at this one again. The patch's diffstat is:
>>>>
>>>>  fs/nfs/localio.c           | 8 ++++++++
>>>>  fs/nfs_common/nfslocalio.c | 8 ++++++++
>>>>
>>>> Although fs/nfs_common/ is part of both trees, fs/nfs/localio.c is
>>>> definitely a client file. I'm still happy to pick it up, but technically
>>>> I would need an Acked-by: from one of the NFS client maintainers.
>>>>
>>>> My impression is that Trond is managing the NFS client pulls for v6.15.
>>>
>>> Sure, that's my understanding too.  Feel free to offer your Acked-by
>>> (for fs/nfs_common/) and hopefully it'll get picked up.  I can
>>> followup with Trond later this coming week if/as needed.
>>>
>>> Thanks,
>>> Mike
>>
>> Can we move forward here? The compilation of kernel is broken for at
>> least 2 months. Also I have tried to contact Trond for more months but
>> has not responded to my emails.
>>
>> Could be this change picked with a slightly higher priority than just
>> waiting another two months? Note that nobody objected this particular
>> fix and there are 3+ Tested-by lines. And it is not a good image if some
>> kernel component does not compile...

The optics are not good, but IIUC you can disable LOCALIO with a
Kconfig option. Isn't the default for that option "N" ?


> Actually I do object to this fix (though I've been busy and hadn't had
> much change to look at it properly).

I'm not terribly excited about this fix either, but I don't have a
better suggestion. Mike reminded me of Neil's objection, which he made
a while back on linux-nfs and it's why this fix wasn't included in the
initial round of LOCALIO patches last fall.

Usually when Trond doesn't respond it is because he is not comfortable
with the proposal but does not have the time to look at it carefully.

This is why I've been hesitant to just pull it in via the NFSD tree
without an explicit Acked-by from the client folks.

To move this discussion along, I would like to include someone with more
immediate expertise with the kernel's RCU helper infrastructure. Any
suggestions?


> The fix is ugly.  At the very least it should be wrapping in an 
>    #if  GCC_VERSION  < whatever
> 
> to make the purpose more clear.  But I'd rather a deeper fix.
> 
> GCC is complaining that rcu_dereference is being called on a point to a
> structure that it doesn't know the content of.
> So the code is says "I'm going to dereference this pointer even that
> that is actually impossible as I don't know what any of the fields are".
> 
> I'd rather it didn't do that.  I've been playing with the code and I
> think it can be made quite a bit cleaner by moving the rcu_dereference()
> call into the nfsd side of the code.  Hopefully I'll have a patch in a
> day or so to demonstrate what I mean.


-- 
Chuck Lever

