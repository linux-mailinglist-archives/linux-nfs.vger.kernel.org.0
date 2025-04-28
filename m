Return-Path: <linux-nfs+bounces-11307-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 98498A9F33B
	for <lists+linux-nfs@lfdr.de>; Mon, 28 Apr 2025 16:16:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75ECD175768
	for <lists+linux-nfs@lfdr.de>; Mon, 28 Apr 2025 14:16:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA5BD26D4D1;
	Mon, 28 Apr 2025 14:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JxSjCEEU";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="bQ2A25wm"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A2E678F40
	for <linux-nfs@vger.kernel.org>; Mon, 28 Apr 2025 14:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745849759; cv=fail; b=sChSmj78JplSWebujLuy1PHV6TSwlbMevzmgsC3NFA4S1meYtU2KJ7YQ3JL8ZTf739vStjcaOq41ZCPg8YpdyBkMq/nscYhWhoYdbKXAPTO9oCvDbjlgekHc7VfIFS4I3E5oNn6ThE6XVbRiF4guN28f3uPC1w+LYRVoWO8Ysrc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745849759; c=relaxed/simple;
	bh=lW/gZNlH+MkbRB6dqs08nmWeVsxXWb8UAq3URg2uLI0=;
	h=Message-ID:Date:Subject:To:References:From:Cc:In-Reply-To:
	 Content-Type:MIME-Version; b=Z7Xjag1WqtoKfy821HGqik5j+mv1p2zSqj/NvasuWeINJlJv1/dvg+MdhQ+z29OHwe9yzaTJjI+kpF+tQgWZtQoH43UGpgHy/UdBpUUGCZXIHRjXxVVqI81cPlo/XajvOF8ZrB9JCILlAvIdrAosjJphqWEknfcpbrO9b5GyG7Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=JxSjCEEU; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=bQ2A25wm; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53SDspXk023266;
	Mon, 28 Apr 2025 14:15:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=YeUnD0XdmPfp58T4JrWVMECiTVvEepLYlfoTlMmCgcI=; b=
	JxSjCEEUA3NA5gLMIE40XWLaOnxiTOIbRSmkxE6/QVlviGCyC2LQizGcGzbaa9y/
	XfTawAi/S+atmbrWCIAGzGZ6aSFP5vBH9hMtWQc4rdbw1/zBdYXBLNa4A6ew55d5
	nIKMkXGTUwMqkpyI/uDXvKLYz2erTNcoJYLdnRNrMrCIu6tTox3SOjUfVfmT0i9j
	7P70TTnOIfE9GxNWHOWGVnzMr0trowgEUrd43IT3dUFhwBrwbo1hxjO9Yr1oTFlx
	ILBho3BXckW1PB0Dm9/MNcIO/TSI28LJDsYuxCVA5zka4Cz3yWycCPMj8dBxTRg7
	F4ANboptinJznQCUC3V3Dw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46aayp01w5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 28 Apr 2025 14:15:56 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53SDP6d7003783;
	Mon, 28 Apr 2025 14:15:55 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2040.outbound.protection.outlook.com [104.47.70.40])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 468nx8g5bg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 28 Apr 2025 14:15:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y3TbCEH5et8keBbvTJ9SpCGAv1flxYnSvRzTUH29aHfjt7kqSvv1ibAD8K7Y83cK8znm+Poed/xZZmJF3V4foBYi0JRwyRqm0OJJHB4YVqpnZc7SNbkIbReP/pz9061lh/JQUBz4QdKwD+CbNuV3OZgHAYe1+S2fNGTep4ovAb05H9YotMsDGtC1fEDPWx/+ka45PMrNttP7kxwf0VRWV0dMBUQnMkV2t+Kb5T6cbhlEvtAqnELKsQ4oGDbUTULy0Swo5Kh2kJ7y5vt/kbMgovdi3Fsnwk7sjN/5VCNZTYadfH8y4YUS79ZtEiSGrwU0LQBO4VtsfX6VOxGBHH+A0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YeUnD0XdmPfp58T4JrWVMECiTVvEepLYlfoTlMmCgcI=;
 b=NcD+kMEUrupoTwNfHuzzLYW52L0yA0rNJ/yXj3f9kNdqu7NFjb3ihK0279CJrOVfElyZ6siy5g3F+oglk25ZWecGedsqn8u5TkOsLgF9LreVDyjshXQyFIWQ9wjH2WEIGUEAzfFT8OZkqowPNqeZ8K25PsfHXGVj2seiA3qqRhqevo6opCUtKEBsgH/sN7fdwxRkfLkx1eFTVzxAVr/WohwkwfuWGP7xv+QNB8/ruZnWGkkml5zABMCONFz4dJNGj7pVB2LbTOs78D5bwhR3n8npq7aPz+o2OAVlp4premavykKCHsM2HBgqB2qP5giRB6QhdZmGGabYXVo/PAlU4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YeUnD0XdmPfp58T4JrWVMECiTVvEepLYlfoTlMmCgcI=;
 b=bQ2A25wmvsCjA9/Kj9EwI4C1l/VmUVmCZ9T0GgffzGdZvMQGB2sHTm27+VAS5I6/gW1SKtRfU5ytNUhD0Wi77xngc5LrdL+qFVowWpfR502S9PQEaFzvTfQSPnfSHMXB0/2lqAwEqp04KmKTzuP1SBqUbeG+1DtEqu6c6LCZboY=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DS0PR10MB6128.namprd10.prod.outlook.com (2603:10b6:8:c4::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8678.29; Mon, 28 Apr 2025 14:15:52 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%7]) with mapi id 15.20.8678.028; Mon, 28 Apr 2025
 14:15:52 +0000
Message-ID: <434f6474-b960-4383-8d61-0705632b4c33@oracle.com>
Date: Mon, 28 Apr 2025 10:15:50 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: fattr4_hidden and fattr4_system r/w attributes in Linux NFSD?
To: Sebastian Feld <sebastian.n.feld@gmail.com>
References: <CAHnbEGLHGX2rMnf=S6CasoNyc939DTe-whcsjt9WhSWG920OoA@mail.gmail.com>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
Cc: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
In-Reply-To: <CAHnbEGLHGX2rMnf=S6CasoNyc939DTe-whcsjt9WhSWG920OoA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR04CA0044.namprd04.prod.outlook.com
 (2603:10b6:610:77::19) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|DS0PR10MB6128:EE_
X-MS-Office365-Filtering-Correlation-Id: dfabd9ff-685b-447c-df27-08dd865f2e82
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VFA3ajFjUkREemo0Z1I4MHZoZm10N1RHMUIySlRsMkRiZVM4ZTl4NS9xNEpv?=
 =?utf-8?B?VVowR2hKeno0Um04RGpQK1RoVWk3S1NxTG9EZm9YdkxnbU5KdnFIOEo1TURE?=
 =?utf-8?B?aHp0bVhsb1lGUDhkY2UyMHNxaTNGZE5wb1ByNXFxbHg4VFZDVUd5Mm5jZG9y?=
 =?utf-8?B?RHNzdE9wb3NmTUlmUGR6S3VzRkZldGJQTUtnb0paSTNGc1JxVk1qTGlaazlG?=
 =?utf-8?B?dzVJbnUremxDUzZWNzRRWWZ4OWpSNUt3cHRMUmNQTnpvNXRPU1NPdUpOWFZX?=
 =?utf-8?B?dnlZN01wWjVXZWkramxVSE44em8zTWNDZkhjSFlEWFQzQ2lKNll2K2NEQjEw?=
 =?utf-8?B?K2RzdC9ZcmRkNjBET0F4eDQ4cWxqVmNNUGRYcHFTbjN5RGZhVFNTTDY0Yzdk?=
 =?utf-8?B?SUtFMzZaNlduQmZHSVZyMFhITzhHVlhURVA3K2RpTk4xSzRMOWlmOEVUazY0?=
 =?utf-8?B?blV4S1JBQjUzTi9nU0pwZDg0TWhET080eUxBSURWQTFlWVBtbEtlMWthbXVO?=
 =?utf-8?B?UVdsV3pvbGJhSDlTZWhXMXZLQzhxdmxUZ2ZWZ1lQczBVcDRGa01ENWZYRXZH?=
 =?utf-8?B?UUtNNysyV09XZzFHTlZMT09sekh4bDk4SWViZkR1N09ZbnNEWkhwQk5JL0x5?=
 =?utf-8?B?L0l5UEJDS2NKY0ZMY0JCT1czRXI3YWFMQ2hQSDJYNjdURnVQT0NseXlmOGI1?=
 =?utf-8?B?S252R3Uvc0dSYzFmRDhDaHp5R0lkTnl5aVV3eVZPd3lZY1R6VWVmazZ2ZVBi?=
 =?utf-8?B?c0pTQjFQZThZdkFTbUNCa25vOU5BaWdXd1h4Y2plWkNCdi9mOGhiMnhZN1hi?=
 =?utf-8?B?UjcxcUtEK3FSNVdQNktiS1VreDlkd205MndlS1dzbElGVk1ZV29jMlpWRWsv?=
 =?utf-8?B?OHZLYWdMem0waFcyM0luOWJTOGlOejJVRUxadE84R294RnZjQU5yZFAzMTRU?=
 =?utf-8?B?T1d6K3h0dUpYaDlSWFVBVDVITHZoc2t2SDRwSGh3SzY0OUFhODVESitTTTho?=
 =?utf-8?B?Zk5NQWswdThlbVVBNEpSSVNIaGl0MzZ0SnRMQU5DS3RCVlEwODVLdHNzMksy?=
 =?utf-8?B?QUU0WGRpdEZQR1ZJbWlyK2Y2V3BnaFlHeFB5U3NlRFZWcUdKNnMrTmNPWXl6?=
 =?utf-8?B?ZVg3Q2Z0MHVlak9SM08waVUraGNONE8za3VBMGN2UUJsaWczRW55UGc0WWNh?=
 =?utf-8?B?YlI0a1BXS2Vrcm5XV2VIcEVxbE0yQkREaVhsWTBSaG1TWXhmUGtqb1BhaVdq?=
 =?utf-8?B?ajBhaXBWY2V3d0dZajNqa0NRVXgyV3ovY1R4YzEzVjhVUzB4VlZwTHptdXlh?=
 =?utf-8?B?Z204enlTWFc3ZFJKaUY2UnlZcTR5VkZaRHZiS3c5UUJ0ZGZmeDd1VG1CZ3k4?=
 =?utf-8?B?Z0Z0aEhhOXpZaWdacjNyUkdQdGNLbWVJbU1OWmxTdzFkSkM5RVdHM1pkSEVw?=
 =?utf-8?B?NnRTajZaM0t4b2dtV3N5czB3TUdhMHEwekVBV295R2V1THdGVm1JbXFRS2ZN?=
 =?utf-8?B?bUgrRlNEM0tnSHZaL0dTcjV6WFg3bDNRSEZObDNkUFd6b3NvcUpXcEZ2dUtS?=
 =?utf-8?B?N0RrdVZMd0c1MTZKcWRsNWg2bGhoZlZ2V2xUeDZGWTVhbXk1NGFsSEppcitI?=
 =?utf-8?B?RENqcUoxVk5QcGwwZ0VySGxIaFpHN0lCeVhHRUVNQ283aTRjUFB3NEI4cW5H?=
 =?utf-8?B?WVdpU2VPUWY0azI1TUFEdmZ0Nm9ZWWNJR095M3JnZXFDNnZVd2JabjVMSkdo?=
 =?utf-8?B?b3UybmVkaW5ESHptaGt2N3N5QkV1am9paDRwbnVwT3htWFpDVWVQSDlYRzBG?=
 =?utf-8?B?RC8vbXdWdFJncll2VnV0WUMrajhQak1BOU5DWUxCWkxHYytWWGpNcVlNUFJL?=
 =?utf-8?B?S2Y1UGo1VXFyQzY4Qi9pWXdwc051K3pWd1M1aXYvRmh5Q0R6dmF2bURmOXF4?=
 =?utf-8?Q?jskqZGVP9sc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q1BrdVF1Q3hhZ1A5Z2pzcWhSdXlEc0M5RkFROXQ2YnQ1bi93c1ZCQ29QR0Jm?=
 =?utf-8?B?ZW1KNXZCK1VMQkR2ZXdtQ2RoTEl4ZmVuNkRDYzBxazl0R1RmcWFCdVhsTXll?=
 =?utf-8?B?dm9UaFdZVFRkRlhpcDhEeFU2aXhnTkpOaDJWUEN4YzFwbzRUTGFXL0NxZlhs?=
 =?utf-8?B?RnZpbHozenRyVmsxZElQejhwYkIzaGd2a251eGE0TmpzY1FUMlp6eCs2RDVq?=
 =?utf-8?B?cGFkY2VITnNUZTJRV1NOR0haNHdJbTNQbDd5dk1aeTlaRVdyajlmVitkSTNt?=
 =?utf-8?B?R2tNd0NTUVd2WW1vM3AvdDJoZjFhL0Fwc3NSZ1FuSUhqOHcvR3JtYnhBOVFr?=
 =?utf-8?B?UXhMZk5veWhXY1FoTnU1Kzg1Snk1S0NiZk9sRUdKU0diV0NoRzg0YWVDbitm?=
 =?utf-8?B?cVVXeHdaUzF2V2VNNFRWMnlWa2xPQmxtUm9MRlZVQ2h4NkttSW9uY0xHUjJR?=
 =?utf-8?B?YzBYcm81TDBJQS9RWWdtL3BhUDlJZ1R5OURSVndhM0FmWUcvV01RcUplRFJG?=
 =?utf-8?B?eE5CY2d6bGZiMzVJU2RNa293OUtjOGtwc0ErZ3N6cTA3eUVhaFBEYmVlc2FV?=
 =?utf-8?B?UUxTcEZIaHF2ZzVvMlhQQ1cxL05sM0lhYjI1RFpkL1VnSTkyTHN2V0VWN1ZH?=
 =?utf-8?B?cmRLRTE0V3l2ektlNko4SzVkQWZtNGZ5aytMSkkxNnhCbUtrWnBTYVE4T2hS?=
 =?utf-8?B?TEkvbUIrakJCc1lnT0pzQlRXMjIzV1k5R2RNWDB5RUwvazZvMGJGYVhrMkZG?=
 =?utf-8?B?U0Q3V1RVR2U4OEt0a1RvV1JyL2djU01sYjJBVEJZZXRlT0RzaW5EUVhEcU1K?=
 =?utf-8?B?SVNkL1NtRDFLdmgwUzlFRmFxQzRzbDI3Nkt3TXdRMlVsNFhIeEZVVmtJaExJ?=
 =?utf-8?B?Z1FpR0FGemZ3N2lYUFprc1FrT1I1a0NvUjdNUks0NW5DbXdSNUdRbGI5WFo4?=
 =?utf-8?B?Yk5QeUdlSE14dUwrR3B3TVc0eWZFdzBiUzd1Wjl3T2h1WjRiVG5XQ1JrczhU?=
 =?utf-8?B?Vm1aK1NVZmdCdDVBQ0RTR01CK1hONjloa2NDZVhZSEoyUVVMRktPaVN1czJX?=
 =?utf-8?B?N2g1YzBIOS9qdVNFTFYyTkd6dnI5U0Z1bVg3SkpIYnJHQnp0aHJpMm5WRFQ1?=
 =?utf-8?B?SGp6Zm5ITWdiaHErdWpRSFFuRVBUcDNOZkY4T0FmejQ3VFlheUdJODFyRlpF?=
 =?utf-8?B?RDB5TnVmbmNHQnZEejdJNUdPTjI5VSs5eGhQT1V2VkhYUkJmeU1qK1g2TDEx?=
 =?utf-8?B?VStFK0JnbHBFbjRuYkVtRFljVHAzWE1jeHdIZHd2WWVKNGFDbHZlcVZQNXJT?=
 =?utf-8?B?R1F3V1k2VUx5T1lsdjRkV0hKNFZwZXRhVStzclhYWnR5TkdiQ1Uzei9BK3Yv?=
 =?utf-8?B?VDdwMEh5U0R4dkZJQlg2TUppdElSN3ZkTy93VTBOQjlLUWtNNnN4dVc5WkRM?=
 =?utf-8?B?MGdJb1NlVjFzRVhxak9Xc2l3Z0t0Q2tLNnl1VUFCNGROWDVqVXBiU0djQ28x?=
 =?utf-8?B?eERPKy8zTFgzcDNFc3dOaXQra1ZzNDViL3VKRWFYQ0s3TG5GQXZ5U1Bkc0Yx?=
 =?utf-8?B?bFBiUGpoK3BKdms0Rmxmamsrc3FPdW5PeHBtNDlCTmhhL3RzTUl0MHZzSTdO?=
 =?utf-8?B?emVsZVJ2VXFneTBjK2krUWE5SFo2RlhrSWhqSU1McS93T3lsL3gvWTNLZXFV?=
 =?utf-8?B?c0VFZU5uOE9STTIvekZkZ3pVcVZoaXhaTkdIbU9BUjFTbjBTa1IrOTlWTzJw?=
 =?utf-8?B?VGZwaEdoUFpvMmNuNlFTNFpvemFqWjNFdERlaU04R0N2WWJhdk44TlhJUm1K?=
 =?utf-8?B?cWtBV21WdDJDbmYrV3hzdlJ3S3ZGclhMVkd3cFFuOXVRTXZXTTdLaU5NaHgx?=
 =?utf-8?B?eWJZUkxRbEtqTUJpSzZCQkZQbk5UcUlDMnlOZ2gwNjdDUVJGdnpwODViQVVZ?=
 =?utf-8?B?YnZOZFdiSnFTeUthNk5Zc1ZJSlhsdnk3WEpTWG4zZlBvWit6NCtrWk5zQnVO?=
 =?utf-8?B?bXk0a1NmM3BkTVI2RFB3Znl4Z1J5MUkyWXZsRkRreXlFSHBmMitrRGprRktv?=
 =?utf-8?B?QW0rM0tocVZvM255NVRQUWdWbGpid0dGcFRjam5uSDhTMlZNWU5BYUVHam9B?=
 =?utf-8?Q?7uUw6QVUjsA8/4AKppVsAWMnM?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	I7tvIZ3/LlK2k5hiZWwx/0M+PTYh5+cIMWv8WpmWCsMsFFRo/Oum6PaAnrL94L+Y4jrODTcnq+IIimImc+YYLfuIreWkHJdkmQNH3arta5+U6NHwkr2JKxFEJ69W+9SOcYOIPni751NjMjsH97ti4AoFCUqduPcGp8ytAqjcumTQr3w19aO93efeHVKJIxluFVoS4brj7uGXwcO/J6wc/THF4UvsCupHNvn7zgEtJlptD1hz07uMwxk/dwLM5+Kh/iTX5psiJUqp/I8GttIU7ROI8+1ADer+awseggvCMumoI6MtSVqrJj6r18GvzjtdmSBCUbuBl7xNUn7oVYaHbOgV3HF2WIsqdV7Y26O2qamfDsRS+fjFnYTi/WCa4cCmooSDela8m5oN+cJ82WwOxN+9m4uuHifzBdNmPg0daMT1h5wTb/5RCgD81TD2oicfnCE7+E2PqAhnhgDZ3Msh7pMsjJwVUxCG4mOrhmFEBfdBPAlS3+bje+hIk0Kni4kpCG8zNRix8NiwGBGeoavEyOJcfHYg0mqWbvtr95PFLKm4b0fxabtFZr33SBmp6Z+YTbAKySmgFD359US2S2x2AiMRB7+FBS/1pdSMz3RIbdQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dfabd9ff-685b-447c-df27-08dd865f2e82
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2025 14:15:51.9330
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sUeaLf9iJfF/c9vFmjaBR1x2+SQp0b4QKOyIQSZL5DhlqDvkR7P/7NurhrkNktlzlZCYVaHTNiLVgYXqqQZKGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6128
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-28_05,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 phishscore=0
 bulkscore=0 mlxlogscore=999 suspectscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2504070000
 definitions=main-2504280117
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI4MDExNyBTYWx0ZWRfX/MoTZ9HAxQ4p 8tKlLEwpDNoK247RlbeNBOQcP68qfDv5IBteMyU9HRDREnlBbJmgOqc9cLxXlSl2FmC4Hyn3SPA HFUozghOXBQYFss56Z1iWsZVIyNXC7F5gX27JEaMkQn8YrHVxUjQ8Q76nARrH0j1VgR5WvpknMg
 Fp3wURiLu1pk/ZfvkhZsQNs3zhnoj+hMlYjROa6qoKdlhYcQ1K/0KPGscleeiZFjduSEKnsPMDH cI4+nmhOfilawV34NUpa1KtBtHIJl4SZG5+3U1cdQNGqxsaZF+oIUU5itVdafUwV4W421Uf0Cgh cLHHZuB/vzkpr3FH5cT9bldmffTLh07Y96XyR21SvwSUtyh2q6KRQ+nzzA/vcnWeN+nXcD7JJPo 0d65pTcN
X-Proofpoint-ORIG-GUID: dc-_nF7ZRoUx7Bfi5HV0IlLliGziCXCM
X-Proofpoint-GUID: dc-_nF7ZRoUx7Bfi5HV0IlLliGziCXCM

Hi Sebastian -

On 4/28/25 7:06 AM, Sebastian Feld wrote:
> I've been debating with Opentext support about their Windows NFS4.0
> client about a problem that the Windows attributes HIDDEN and SYSTEM
> work with a Solaris NFSD, but not with a Linux NFSD.
> 
> Their support said it's a known bug in LInux NFSD that "fattr4_hidden
> and fattr4_system, specified in RFC 3530, are broken in Linux NFSD".

RFC 7530 updates and replaces RFC 3530.

Section 5.7 lists "hidden" and "system" as RECOMMENDED attributes,
meaning that NFSv4 servers are not required to implement them.

So that tells me that both the Solaris NFS server and the Linux NFS
server are spec compliant in this regard. This is NOTABUG, but rather it
is a server implementation choice that is permitted by RFC.

It is more correct to say that the Linux NFS server does not currently
implement either of these attributes. The reason is that native Linux
file systems do not support these attributes, and I believe that neither
does the Linux VFS. So there is nowhere to store these, and no way to
access them in filesystems (such as the Linux port of NTFS) that do
implement them.

We want to have a facility that can be used by native applications
(such as Wine), Samba, and NFSD. So implementing side-car storage
for such attributes that only NFSD can see and use is not really
desirable.


> Is there a fix, or workaround?

There was recent discussion on linux-fsdevel@ about how the community
might introduce support for attributes that Windows has but POSIX does
not [1]. I'm not sure how far along that got, but there does seem to
be some interest in getting Linux native file systems (and the VFS) to
be able to store and access the attributes. Once that is available, then
it should be straightforward to add such support to NFSD.

Until then, I am not aware of a workaround.


-- 
Chuck Lever

[1]
https://lore.kernel.org/linux-fsdevel/20241227121508.nofy6bho66pc5ry5@pali/


