Return-Path: <linux-nfs+bounces-10057-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 67181A32A56
	for <lists+linux-nfs@lfdr.de>; Wed, 12 Feb 2025 16:43:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1B4E188B48D
	for <lists+linux-nfs@lfdr.de>; Wed, 12 Feb 2025 15:41:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C679420E027;
	Wed, 12 Feb 2025 15:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="USIR/F0/";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="yUSzJbRV"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87F5B212FA1
	for <linux-nfs@vger.kernel.org>; Wed, 12 Feb 2025 15:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739374890; cv=fail; b=Nnw/YlIWF/rTx3wGhj06kwhWVoDNxucJOzEC9XlseDX5lClk+uIBkPwUBwdP2bKiYiDI/IvlzTk0iJU6BW/8vUrajZHYPxqrqvPVClCDo842WpiDeTUKz8mbGpj1u/EcKGqp1z9AbeAnwUW+Yqb6SxKxRBOcp7RxNCR4UF1Sfnw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739374890; c=relaxed/simple;
	bh=WS0yl4P51ZFRY3qBQnY2gPwMDTkdBCuSdp99tzh1Hl8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=IY0JKBK9VupM1TeUWB8xIzy6fFZe59NRUcBxJqHqKOJO301SaAQaCQsXzxc7/VeJWfqPktZxe/eEkco4b5q+RuVWQHJgSgmvOHJ97TM2K242YgzJeeF/W6o8hVxz5SsWA9nOeir+jewr/j8B6xmVOl6cZyXqzTohe0u5G7XEGdM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=USIR/F0/; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=yUSzJbRV; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51CEta4e008437;
	Wed, 12 Feb 2025 15:41:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=MfxKaYB6UA+CX63LT/mu5+FTSzOyCMLmhHRA+p7cNxo=; b=
	USIR/F0/9r18Xd4PjaT70XkdIIs3EglXaUcCAxZMA1/ncmgVgbfSKWG4GRKWVgJr
	dei1MvltGquybDU1Uwt2slbX6RT9oCc29rozWpLDrpK1fR/cso6G5wQiWoPQTbJm
	ntGKZfJMmN1b3YsUgziLleLzl/DuuMARZi06JesLY7oVK/UI98kDmcwP9SWfKvZd
	uZzNnXXCpRMtlhKKQR4/JwwUinQiNZpiefqySwzes2B2DQzgXFLbK7NGDDfwD1Kk
	6luFurxW9nMKoFtU6kToHO+O6PeRfMUnOA31vGsPPzws1sueIZkTs7u+ZS37yDkE
	2BSqaaM85OxTnm9cslZ4Yw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44p0t47ke5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Feb 2025 15:41:21 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51CEWp3l009770;
	Wed, 12 Feb 2025 15:41:20 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2174.outbound.protection.outlook.com [104.47.73.174])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44nwqgqjyq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Feb 2025 15:41:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t0+fZ6569jBh20Cxy8WQkEI0UUx1tHV5/O5ILPJ3qWhbpL3Vadj5xbovDTaWyrGJzP/oaSbEyg20WUGKoObA3U/U0dJH3Oj6/O0+gS5zoYngBq6905JZyvi7tyrzK1IpKBgcfSoizO+TQvhIgwAoM1H4rNp0axJJ/UhsYej6Bz2LXxL8G/scxDbOC8EqLnm0o8qm4sVZIp5JXsCNEGwZRjrH9EK04I3LMOfoO/BqzkT9VTeIvnlv3KCNPkBJWk4CDiIgJA4V8j/yGDE87Ak+34Qgh9Jd7fNSdAflms6K5yEZ5w6h+Hhq4gsp5a4S/uf21uvCX9xfrii+giyLOxkyCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MfxKaYB6UA+CX63LT/mu5+FTSzOyCMLmhHRA+p7cNxo=;
 b=BxRQZcq8P/emdsjmUcEBDg5+e4PYMNabJ2z4jIH+GarLOKip3GaIuNOGi+9c0gjGwNWd3eMpcrTsWpCozbMBwYgNupLOsxbD+CPBC5gDSkZTg//r9gaZ2PwJJNxOaUsIowRhXP9H0fd14pQaohUEoFsYXDKXWT0qcFrfNPcd3whJq7SNKtJ7iuWjCjQ5bz/6ayXNtGm6om9bWtZty1TahbpGf2KRC7VElJJVxErJMPu+fg1hslz4vWEDiiHXOJ+UPx/XnbiFtPfp7cby7varwksDtfAxysq3VZTcTVn98LCeyZ4YsHqHp6J1CJTbrfOIdSif+9bMQllg2c9RP7T1ZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MfxKaYB6UA+CX63LT/mu5+FTSzOyCMLmhHRA+p7cNxo=;
 b=yUSzJbRV2xYCmW8abrBpdynzRgcJYvzqcna0ClZLCXZ+GSp3u90Er94ZO5LXefu+kbxV3isAbCLFVWknb5jyaQrPzJj/CcrT77UKRF18jpi7KG5u9S6dq0NS/cVaDYcgOIqfLVboQ77jvPKGNbjTd+Ge7w9JuTnq24K7nLNNF6I=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by IA0PR10MB6820.namprd10.prod.outlook.com (2603:10b6:208:437::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.11; Wed, 12 Feb
 2025 15:41:17 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.8422.015; Wed, 12 Feb 2025
 15:41:17 +0000
Message-ID: <601e9474-ebb7-4b2f-8642-82b28cf4697b@oracle.com>
Date: Wed, 12 Feb 2025 10:41:16 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] Allow to fallback to xdrlib if xdrlib3 not available
To: Jeff Layton <jlayton@kernel.org>, Petr Vorel <pvorel@suse.cz>
Cc: linux-nfs@vger.kernel.org, Calum Mackay <calum.mackay@oracle.com>,
        Michael Moese <mmoese@suse.com>
References: <20250212132346.2043091-1-pvorel@suse.cz>
 <31e2b01ff9b3b4fbd370419f31886cd4a2a933ba.camel@kernel.org>
 <20250212134713.GA2044610@pevik>
 <e5ff0c6ac9ecbf0ebb7a1ecce55e17885eedf543.camel@kernel.org>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <e5ff0c6ac9ecbf0ebb7a1ecce55e17885eedf543.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR03CA0114.namprd03.prod.outlook.com
 (2603:10b6:610:cd::29) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|IA0PR10MB6820:EE_
X-MS-Office365-Filtering-Correlation-Id: 28746ca6-f08d-4e23-1a0e-08dd4b7bb0b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Y3JNOE5COEFONEtjeW5RYkt0eDYvMlBMbllPUzR5UUpzVEhVTUlGRm4rbEtl?=
 =?utf-8?B?RmowWUZiTFVnTzk0bldxZmlZYms2Zzk0TkxSVlh3bllqRkVWUE1zRnRvYlZo?=
 =?utf-8?B?NGZxVW1mcEVJRDhtQzh6SHpxZXl2RGJtUVNWKzdYV1lpdjNqTk52TS9pWUV0?=
 =?utf-8?B?VmJZckxUOGwzdWxnU3p1WXlWSCszMkpEWCtXbzFMa3crTlVBVlhncHJqTm9x?=
 =?utf-8?B?ellvR21wY1lHQUE0TVdGcU9NTXZCaUhBaXRnRDhzSEJFaWV5bXZjeTEwNHdB?=
 =?utf-8?B?OEI5L1hlYWJ0L3A4bTFOSG9hWm1mWVlGV25zWFphVVVpSDM3cTI1U0M5Q1lH?=
 =?utf-8?B?MHBxS2YvOGtxVW5IRzBzM1BJbXlQekQ2cjJzaysrMHV1Ynl1eUlPY1Q4Smto?=
 =?utf-8?B?MisvZ1hGRWJWazAwQVF2UWhWQU93amtIR3IxaW5xQ3JaOFo3TVFXWXM3SDFo?=
 =?utf-8?B?NXJnbHNrSWlIWTVMTXJsQUR5Y2RxVFlaVktmcFZtWjlOS0tPbzdIYkVqQnNu?=
 =?utf-8?B?UmdSY0xnL2RLOUFVZEZ3U3dLMFdpdUNraG8xY2xRcklkOHNPUkxnVzE5RlZl?=
 =?utf-8?B?cmk4eUxkM2JZVHo2Zk52c3NqU1F3M0NYYXJ3ZFFQbWdqZ3ZuLzNBcjRHbUp0?=
 =?utf-8?B?eC9nUnQ5RGcxbkpEMUR3c3RsVDVUNG5NNHdMc0w1eXdLU1lOckhzY01KRWVS?=
 =?utf-8?B?UHVGSjlKK202S3M0TytwQ1ZpMDlJMmx6K3NzbUdZa3NBdFcvMW9NVkV5ZGVE?=
 =?utf-8?B?WTVVQzlIUkhYcU5HYnBtWVRJaHBpVWc3M3cvRWt0aDd2VHQ3aUVYcFhOZ0Y2?=
 =?utf-8?B?dWE2UHNTaXN2YTZvUVZqamZGUmI0QmxETXVQZTRPaE0rR3hsU2ZBNHBqQUtO?=
 =?utf-8?B?d3lZbWRaMFZJWjZlTXpKTzF1RTc4V3lZRnpoYlA1TGFwTkczSThKRGtHMHgy?=
 =?utf-8?B?ajBmR0tua3ZrZEJ2ZHlPbmVUNDhDdmFhM2J2N2JsQTBsK2R0TUJTMzNRZng4?=
 =?utf-8?B?S04zd2czZFFFVkhWMDNpc0w4SlNPNnlPb1VQOTFuTjNKODF0dmFMQnF4N2N2?=
 =?utf-8?B?bGFiYlZsMzhtRmg0NG9JN2dVWmY0SDJxYjY2YTNtK0VSZnhWOEQ3Rm05YlVP?=
 =?utf-8?B?UTdaOXhVVkQ1ai9NaVVaOEEwcmJZa1RGRS90V2liNGxBRC9xR1BFQXduNHU2?=
 =?utf-8?B?aWJ5SGJMSW45WEx2aVFpeEZRbGhDR0F5eTFTMG5YYXRvUVUxckZ1RVVCZVhD?=
 =?utf-8?B?eVJkcFpIbjZsYktJQzZPRmVQQURtWkV6a0czYUJtcUxCWDRBTkVKd2tnUHBU?=
 =?utf-8?B?NXMzUHQrMjVobmNMTTErTFZXWlloZFgrVCt5YnpxREVYYmhWMWQ2T2J3NkpJ?=
 =?utf-8?B?KzNxenpZeEZ2TjNPc0JKV0tGOEtiWFphMEVBMWRQZFBaZ3ZQZFlZZEc4TzZN?=
 =?utf-8?B?Q2dBTWNyeW01UzZyMTlWaUJla1F1ZitodWlZeEVQOEZyMjJOQTk5UWNSM0Vl?=
 =?utf-8?B?dnR6TDRBRlRubFpqa2thV2p0Q2lsZVV3NHdZWWdCNFI4K3pmY2h4TjBySjJu?=
 =?utf-8?B?TW1CcjAvam1hVXA0K1BGWUwwQTY0QnRDb00wbzB5YVRKbytySHFzQWtGYnZj?=
 =?utf-8?B?b1BqN293eVdaaVRyKzlBR1dYeTl2OE0rcGRpenFKbW80RTJxYUNxNVR4dUZi?=
 =?utf-8?B?Sm9vZTNPaW1NSHFwalBLNi9xUUZCUk10ZlJVSEpheS9SRkJCa3luQzhNQ0lq?=
 =?utf-8?B?c3VWSi9BVjZTSHdwWUpYdTY0cndFWkRFKzRCOWhROWJoc051aFhLRXU2clhR?=
 =?utf-8?B?S3NSWSs5VmlLbVVIZHZHbmpIemd2QlpscktWUzNZd0JuU1A0YUd0NU5xLytE?=
 =?utf-8?Q?o4GPgpXsBrunn?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RXZpMm0vUUVLZnlCcEt2ZXFMby9XN3NYZElHZi85QmtWUWNPSDZaaGdYWFBS?=
 =?utf-8?B?RktrUFdCbU54QzVUcDExdGpYa21yNjltYWpQRWwrdnd1bmNYRWtySjZCdWh6?=
 =?utf-8?B?TEYwTFpEVi90UElSMUtGbUQzeXlqQy9talYyc0M5bjFWQTgxSnlaRTFSMVBM?=
 =?utf-8?B?WXdNSjM3NnJKbU1Jdnlicm0wQ2VFb0RTSDlwek1zeUQ1b0R0TVVVTWZBVmxn?=
 =?utf-8?B?bjkxM2syVnppUGhFNGIrMncvc0RtV2hGRUptUXVMMlVuNTdkazhrdE5yaXdF?=
 =?utf-8?B?WjhidnkvSDNzMWpBem1wV2NwNThOYzZ6Qmh4RkovT0NCTHp3VUF2NG16SWpq?=
 =?utf-8?B?WWMwZW85T3FjUkJFRjRhTmg5a096WWxFbFAvbVhRZm1WYkNhRk00NVI3MWNV?=
 =?utf-8?B?cGNiS2R6d2Q5eGt0b0prcjdOZkQxU0x2Ulc0citNNXAwZkhiZ0pJNkdWUXNK?=
 =?utf-8?B?RVBoVHIxRzQyZUVlN05uWnVBci93Z3Z3UE9RZXJNQ2xVVXZ0QzFoR0FONEgz?=
 =?utf-8?B?TWlzb09FdEZZY0xiWmZhZU9wSjBFWFpoS0ZrTzl2MDh1emNIdW1zb1ZRQnVv?=
 =?utf-8?B?VmpMdXNtRGlFcDU2QTdrOTNXbUNTTDh2dEZTaWZ4Ym9Ody93NFRhYXNrZUcr?=
 =?utf-8?B?QVJvR1dLREVwbTN0allMTDVPdVlDYXFhZjFlaHJFOHM0ZmpqTXY3QzlEMkxS?=
 =?utf-8?B?NzJxMVRqQnZDWkMxMHhCY1FoTWNpR1RydTMvTS84dFFPK2tKVEtKdTRwRGN1?=
 =?utf-8?B?RnZwUXZwM3RIR1VSV0ZqNU9XSWZJOWExQmptV0JKRTBFM1FHWERwTzVmS05J?=
 =?utf-8?B?NEE4QU1pVXdVK1pFODQxdHNKRWxzeFdlYUNJWkcybmhLa3hPRUxIYjNSSmw4?=
 =?utf-8?B?OVRnNDY0K2FvNW5JQy9iQWRPVlEwd0Q0Sk9CV01sd0kxMkNNRTlQN0hTVXdO?=
 =?utf-8?B?ZUhKaGV5OUIra0szOXZKRHIyT1o3NmFod1BEeXNIVy9iN053VGFVQWk1OURH?=
 =?utf-8?B?eHZCbG41WERNWUVnSHd0VVRUSlBpUGhNRE00bkFRQ1lXM0oxYkRZMURkMkxa?=
 =?utf-8?B?OWVMU0ZHbmZRZStYd1hRZ09zZjBUMkp4ZnY1cHdHTEhpYXVMWTZmTkp5LzRL?=
 =?utf-8?B?anFKTEtVWXBwTTA1bFBQVlhYWG1aci9ZK1E4NDRITHhveDFPSnZBcUxQTHhX?=
 =?utf-8?B?TTRmU2lvRkdZdXd6SVFOMndQQ1hrb0ROdFZhQ1NPYW9wdnBiMC9IMVZuRnBE?=
 =?utf-8?B?dVdXc0xXSWttRTBWdXNhUml3TjVOZURDRFhuakVocG5qa0JBY1JuWHdhUVdn?=
 =?utf-8?B?TTF1bHV4bCtReUszUmw1Ukp2YTA2bVRiM1pBZHdyMzBTdjQxR1ZZd0FaUU43?=
 =?utf-8?B?aklaK015RnJIT3JhOHU3TE4zUkljRXYvZU5rNndUcElFVHpVbDQzWkYrTnZ3?=
 =?utf-8?B?VkZaZy9EZEt6NWpseEw2amRSRmhjbWtHWW5JVnZJMzRWcnJaZjVPdEhTaXph?=
 =?utf-8?B?SytVYTlOUEpDYkR3T3Btb0JIVmZWc3p5emJyeFIvd3lBNVF3c3lKMXFreXNm?=
 =?utf-8?B?SUFZNkNjTllCNU1oNWlCSStSYnZORUY5bDk0aXQ1YXNOMzBVVFBuNHdmTTlk?=
 =?utf-8?B?N2VHdkxQbnhZRWY3dkc3ZGdUK21iYU5MV0FzZlU4SGZMZFdGclZ6OG83aTg0?=
 =?utf-8?B?S0RkQm0yUHVlQzFSbGpQakFJSUg5U0xpMnR0cTFJa0JlM2tpWktwZEhDb2th?=
 =?utf-8?B?d2tjeU5FTWljdnJacDBSQ25zQ3ZnMUFwV3BrZGNZZmRTbzZUcjNFK3luRURV?=
 =?utf-8?B?VzZJTDF4Y09lcmhudVN5c1Z1VHdKdWdNVUE5eHRlVEJjUllZMXJYLzh4dTRz?=
 =?utf-8?B?Wlp4b1ZWa2prRXVhK0lJZWFGV245azEwa0pTdGRvbVhTYjdTaURaYUtuUDBy?=
 =?utf-8?B?VVkwdFBLdFA5V2Vud2p1VzdvaVB3VFBUelpTblhpcFMrRkFudVBGdUYzSXhD?=
 =?utf-8?B?ZnZQb3Z4U1pDck5jUTBscCtiazhRUjRnQUJKbWRlekJ6emQxTE9IeXVYT3M4?=
 =?utf-8?B?L3czU2Y1UWd5aFlHQ3NibmlhTnVrL0Q4UDlnTkpVMlVLTjB3WEZmQm53WGJ2?=
 =?utf-8?Q?aJN1Lpo9VjPGGUb6K3CAhfXXy?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ePG+6RyTSRzCiF71Nevcg56iush+f7DW1a0PZFFSl1lCxgWu9GrAikju/OSvID17kMLC8Lll7aGW5Iq6m9G5JJ6+ppgswqr3bKxvVi1uW3u4vTqodIqBfwt8drb46LI0Ft2mu66g9Cc3tkStK2B7ifCCiXySSVgdPj7+VB+pJZgzppB2pPamOKND/SE8f675ZRHwWVeo+/nbezdtocuoVm1gyveIWdBAk8G+/6IWD0JaDXLStt+62IqNCKd7Gz4jsQpPHoXBh24dueDgCHz78hBWsQgo+9XVPlTlIT+01QFCjGMAZcfcULgkyu6r03eikqgUtxUl/zMaSfU2rHiR4mKDrRmrDHPR5hAqhoqtkKH3n4z3iXw2pj0FA4iQQkTJFQoAcqU5s/uhXVUqyVsLkIhujA+GDllnwLsBSbD+A500aLEeCWVIzY3LG40tKbnLKDFZzqe/6uyaEMEz5AOQorexSksp0UFBV8Q73t0kY2V5mreOo7iR05J0ykuA/S3aK07J9GlXn7ZgXh86X0NN1Kn7jwcyRMsh34wSD5b5rF+KgSC9fYCXRgeJgrWK5zH9weofoHxZlsbfTdjQoAlsv7GTN+NfiFbUcGHHVoN4JCQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28746ca6-f08d-4e23-1a0e-08dd4b7bb0b3
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2025 15:41:17.6115
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zoc2TaWkOTI/CZJJXr+vsPKnsiKpWUvM8noB3wPztofLk/94pzCKFh99PS8Oq+qjiklL2+iKf333GlnAVq93Ng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB6820
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-12_05,2025-02-11_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 suspectscore=0 malwarescore=0 adultscore=0 bulkscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2501170000 definitions=main-2502120118
X-Proofpoint-ORIG-GUID: 6lN34ChQPL7-sSrAh62whKH1s9IlUqud
X-Proofpoint-GUID: 6lN34ChQPL7-sSrAh62whKH1s9IlUqud

On 2/12/25 8:53 AM, Jeff Layton wrote:
> On Wed, 2025-02-12 at 14:47 +0100, Petr Vorel wrote:
>> Hi Jeff,
>>
>>> On Wed, 2025-02-12 at 14:23 +0100, Petr Vorel wrote:
>>>> On certain environments it might be difficult to install xdrlib3 via pip
>>>> (e.g. python 3.11, which is a default on current Tumbleweed).
>>
>>
>>> I did a "pip install xdrlib3" on Fedora 33 just now, and it has python
>>> 3.9. What's the problem you're seeing with SuSE installing it with
>>> v3.11?
>>
>> Yesterday I did not notice missing ply, I saw only missing xdrgen
>> (xdr/xdrgen.py). Therefore I thought that virtualenv is mangling PYTHONPATH.
>> Obviously installing ply with pip would be enough.
>>
>> I also thing using a fallback saves the need to use virtualenv on old distros,
>> therefore I would prefer this patch to be accepted. If it's not accepted, it
>> might be worth to extend info about dependencies.
>>
>> Kind regards,
>> Petr
>>
>> $ python3 --version
>> Python 3.11.11
>>
>> # pip install xdrlib3
>>
>> [notice] A new release of pip is available: 24.3.1 -> 25.0.1
>> [notice] To update, run: pip install --upgrade pip
>> error: externally-managed-environment
>>
>> × This environment is externally managed
>> ╰─> To install Python packages system-wide, try
>>     zypper install python311-xyz, where xyz is the package
>>     you are trying to install.
>> ...
>>
>> => let's use virtualenv
>>
>> # python3 -m virtualenv .venv && . .venv/bin/activate
>> created virtual environment CPython3.11.11.final.0-64 in 1466ms
>>   creator CPython3Posix(dest=/root/pynfs/.venv, clear=False, no_vcs_ignore=False, global=False)
>>   seeder FromAppData(download=False, pip=bundle, setuptools=bundle, wheel=bundle, via=copy, app_data_dir=/root/.local/share/virtualenv)
>>     added seed packages: pip==24.3.1, setuptools==75.8.0, wheel==0.45.1, xdrlib3==0.1.1
>>   activators BashActivator,CShellActivator,FishActivator,NushellActivator,PowerShellActivator,PythonActivator
>>
>> # pip install xdrlib3
>> Requirement already satisfied: xdrlib3 in ./.venv/lib/python3.11/site-packages (0.1.1)
>>
>> # ./setup.py build
>> Moving to xdr
>>
>>
>> Moving to rpc
>> Traceback (most recent call last):
>>   File "/root/pynfs/rpc/./setup.py", line 15, in <module>
>>     import xdrgen
>> ModuleNotFoundError: No module named 'xdrgen'
>>
>> During handling of the above exception, another exception occurred:
>>
>> Traceback (most recent call last):
>>   File "/root/pynfs/rpc/./setup.py", line 18, in <module>
>>     import xdrgen
>>   File "/root/pynfs/xdr/xdrgen.py", line 235, in <module>
>>     import ply.lex as lex
>> ModuleNotFoundError: No module named 'ply'
>>
>> Moving to nfs4.1
>> Traceback (most recent call last):
>>   File "/root/pynfs/nfs4.1/./setup.py", line 15, in <module>
>>     import xdrgen
>> ModuleNotFoundError: No module named 'xdrgen'
>>
>> During handling of the above exception, another exception occurred:
>>
>> Traceback (most recent call last):
>>   File "/root/pynfs/nfs4.1/./setup.py", line 18, in <module>
>>     import xdrgen
>>   File "/root/pynfs/xdr/xdrgen.py", line 235, in <module>
>>     import ply.lex as lex
>> ModuleNotFoundError: No module named 'ply'
>>
>> Moving to nfs4.0
>> /root/pynfs/nfs4.0/./setup.py:7: DeprecationWarning: dep_util is Deprecated. Use functions from setuptools instead.
>>   from distutils.dep_util import newer_group
>> Traceback (most recent call last):
>>   File "/root/pynfs/nfs4.0/./setup.py", line 11, in <module>
>>     import xdrgen
>> ModuleNotFoundError: No module named 'xdrgen'
>>
>> During handling of the above exception, another exception occurred:
>>
>> Traceback (most recent call last):
>>   File "/root/pynfs/nfs4.0/./setup.py", line 14, in <module>
>>     import xdrgen
>>   File "/root/pynfs/xdr/xdrgen.py", line 235, in <module>
>>     import ply.lex as lex
>> ModuleNotFoundError: No module named 'ply'
>>
>> # pip install ply # this fixes it
>>
>>> BTW, does SuSE have the xdrlib3 module available as a package?
>>
>>>> Fixes: dfb0b07 ("Move to xdrlib3")
>>>> Suggested-by: Michael Moese <mmoese@suse.com>
>>>> Signed-off-by: Petr Vorel <pvorel@suse.cz>
>>>> ---
>>>> Hi,
>>
>>>> I admit it would be safer to check if python is really < 3.13.
>>
>>>> Kind regards,
>>>> Petr
>>
>>>>  README                                | 2 ++
>>>>  nfs4.0/lib/rpc/rpc.py                 | 6 +++++-
>>>>  nfs4.0/lib/rpc/rpcsec/sec_auth_sys.py | 7 ++++++-
>>>>  nfs4.0/nfs4lib.py                     | 6 +++++-
>>>>  nfs4.0/nfs4server.py                  | 6 +++++-
>>>>  rpc/security.py                       | 6 +++++-
>>>>  xdr/xdrgen.py                         | 9 +++++++--
>>>>  7 files changed, 35 insertions(+), 7 deletions(-)
>>
>>>> diff --git a/README b/README
>>>> index 8c3ac27..d5214b4 100644
>>>> --- a/README
>>>> +++ b/README
>>>> @@ -19,6 +19,8 @@ python3-standard-xdrlib) or you may install it via pip:
>>
>>>>  	pip install xdrlib3
>>
>>>> +If xdrlib3 is not available fallback to old xdrlib (useful for python < 3.13).
>>>> +
>>>>  You can prepare both versions for use with
>>
>>>>  	./setup.py build
>>>> diff --git a/nfs4.0/lib/rpc/rpc.py b/nfs4.0/lib/rpc/rpc.py
>>>> index 4751790..7a80241 100644
>>>> --- a/nfs4.0/lib/rpc/rpc.py
>>>> +++ b/nfs4.0/lib/rpc/rpc.py
>>>> @@ -9,12 +9,16 @@
>>
>>>>  from __future__ import absolute_import
>>>>  import struct
>>>> -import xdrlib3 as xdrlib
>>>>  import socket
>>>>  import select
>>>>  import threading
>>>>  import errno
>>
>>>> +try:
>>>> +    import xdrlib3 as xdrlib
>>>> +except:
>>>> +    import xdrlib
>>>> +
>>>>  from rpc.rpc_const import *
>>>>  from rpc.rpc_type import *
>>>>  import rpc.rpc_pack as rpc_pack
>>>> diff --git a/nfs4.0/lib/rpc/rpcsec/sec_auth_sys.py b/nfs4.0/lib/rpc/rpcsec/sec_auth_sys.py
>>>> index 2581a1e..41c6d54 100644
>>>> --- a/nfs4.0/lib/rpc/rpcsec/sec_auth_sys.py
>>>> +++ b/nfs4.0/lib/rpc/rpcsec/sec_auth_sys.py
>>>> @@ -1,7 +1,12 @@
>>>>  from .base import SecFlavor, SecError
>>>>  from rpc.rpc_const import AUTH_SYS
>>>>  from rpc.rpc_type import opaque_auth
>>>> -from xdrlib3 import Packer, Error
>>>> +import struct
>>>> +
>>>> +try:
>>>> +    from xdrlib3 import Packer, Error
>>>> +except:
>>>> +    from xdrlib import Packer, Error
>>
>>>>  class SecAuthSys(SecFlavor):
>>>>      # XXX need better defaults
>>>> diff --git a/nfs4.0/nfs4lib.py b/nfs4.0/nfs4lib.py
>>>> index 2337d8c..92b3c11 100644
>>>> --- a/nfs4.0/nfs4lib.py
>>>> +++ b/nfs4.0/nfs4lib.py
>>>> @@ -41,9 +41,13 @@ import xdrdef.nfs4_const as nfs4_const
>>>>  from  xdrdef.nfs4_const import *
>>>>  import xdrdef.nfs4_type as nfs4_type
>>>>  from xdrdef.nfs4_type import *
>>>> -from xdrlib3 import Error as XDRError
>>>>  import xdrdef.nfs4_pack as nfs4_pack
>>
>>>> +try:
>>>> +    from xdrlib3 import Error as XDRError
>>>> +except:
>>>> +    from xdrlib import Error as XDRError
>>>> +
>>>>  import nfs_ops
>>>>  op4 = nfs_ops.NFS4ops()
>>
>>>> diff --git a/nfs4.0/nfs4server.py b/nfs4.0/nfs4server.py
>>>> index 10bf28e..e26cecd 100755
>>>> --- a/nfs4.0/nfs4server.py
>>>> +++ b/nfs4.0/nfs4server.py
>>>> @@ -34,7 +34,11 @@ import time, StringIO, random, traceback, codecs
>>>>  import StringIO
>>>>  import nfs4state
>>>>  from nfs4state import NFS4Error, printverf
>>>> -from xdrlib3 import Error as XDRError
>>>> +
>>>> +try:
>>>> +    from xdrlib3 import Error as XDRError
>>>> +except:
>>>> +    from xdrlib import Error as XDRError
>>
>>>>  unacceptable_names = [ "", ".", ".." ]
>>>>  unacceptable_characters = [ "/", "~", "#", ]
>>>> diff --git a/rpc/security.py b/rpc/security.py
>>>> index 789280c..79e746b 100644
>>>> --- a/rpc/security.py
>>>> +++ b/rpc/security.py
>>>> @@ -3,7 +3,6 @@ from .rpc_const import AUTH_NONE, AUTH_SYS, RPCSEC_GSS, SUCCESS, CALL, \
>>>>  from .rpc_type import opaque_auth, authsys_parms
>>>>  from .rpc_pack import RPCPacker, RPCUnpacker
>>>>  from .gss_pack import GSSPacker, GSSUnpacker
>>>> -from xdrlib3 import Packer, Unpacker
>>>>  from . import rpclib
>>>>  from .gss_const import *
>>>>  from . import gss_type
>>>> @@ -17,6 +16,11 @@ except ImportError:
>>>>  import threading
>>>>  import logging
>>
>>>> +try:
>>>> +    from xdrlib3 import Packer, Unpacker
>>>> +except:
>>>> +    from xdrlib import Packer, Unpacker
>>>> +
>>>>  log_gss = logging.getLogger("rpc.sec.gss")
>>>>  log_gss.setLevel(logging.INFO)
>>
>>>> diff --git a/xdr/xdrgen.py b/xdr/xdrgen.py
>>>> index f802ba8..970ae9d 100755
>>>> --- a/xdr/xdrgen.py
>>>> +++ b/xdr/xdrgen.py
>>>> @@ -1357,8 +1357,13 @@ pack_header = """\
>>>>  import sys,os
>>>>  from . import %s as const
>>>>  from . import %s as types
>>>> -import xdrlib3 as xdrlib
>>>> -from xdrlib3 import Error as XDRError
>>>> +
>>>> +try:
>>>> +    import xdrlib3 as xdrlib
>>>> +    from xdrlib3 import Error as XDRError
>>>> +except:
>>>> +    import xdrlib as xdrlib
>>>> +    from xdrlib import Error as XDRError
>>
>>>>  class nullclass(object):
>>>>      pass
>>
>>> Acked-by: Jeff Layton <jlayton@kernel.org>
> 
> Ok, I don't have any objection to the patch. I was just curious as to
> whether SuSE had some problem using pip for this.
> 
> Acked-by: Jeff Layton <jlayton@kernel.org>
> 

I agree in principal this is what should be done, but my Python fu
is not strong enough to say whether this is the best way to do it.
But it looks good enough for government work.

Acked-by: Chuck Lever <chuck.lever@oracle.com>

-- 
Chuck Lever

