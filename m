Return-Path: <linux-nfs+bounces-11438-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A4BEAA9B30
	for <lists+linux-nfs@lfdr.de>; Mon,  5 May 2025 20:07:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31786188856A
	for <lists+linux-nfs@lfdr.de>; Mon,  5 May 2025 18:07:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 005B11ACEDE;
	Mon,  5 May 2025 18:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="T585DtUW";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="s3QrZUhy"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76FD226C39A;
	Mon,  5 May 2025 18:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746468432; cv=fail; b=ioeO2Bp2TESd+BmGvpUY15l3cwg89/ByGvRuhARxq1mJ0ElCcvaCPDpwKq86x+fktmp0YHx6/wrwjKHno6GsUgQpYqLpEFYeOXxm8MIi06Ma2VrhId+N17xUJGmM/Lwu+t4mMMqbdgInfRcAf/QuOUZgGBPEh2l//GybKmZ5Ldo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746468432; c=relaxed/simple;
	bh=tO1rJdy/eauTUKfSWB2VqR0AoNC+plnX2q4tpJ7W+j8=;
	h=Message-ID:Date:Subject:References:To:Cc:From:In-Reply-To:
	 Content-Type:MIME-Version; b=m7vjNdln3TE0ZvVOQYGedCESOQnRjgANJqwGmbkfswhg8r/vSXUpm3mZkrAd0a2ZsXQP5a+51nmgSoQNUEEHxjFu1U/vq2JkXSL156XrQuv5xKE/Vh3XBV93gkYHr2TRNIifmwTG59LFIZRkAnh82go9Oow12BtRS3epbrsjEdQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=T585DtUW; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=s3QrZUhy; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 545HWDCa028743;
	Mon, 5 May 2025 18:07:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=MwBoQxedDF9kCE195HbUq8OjPfnLlS2LBjzyqzX7ltc=; b=
	T585DtUWMYQW7Z/1MahU7/zguoNchMvmrIB1bVSiK4F1+DEPmFf8XAE/rNXMEAtd
	Br/6Lvg/zZCukl4AULns/EmjBDr0yz53vgmS0N9o91LbVdXmLnKXYPudnS0yHPkA
	u8SijSm/RSo3Dj4ynOYKiJBZNZB3D1mQLQWmsjeQnTfHV7Wpur7miWi1QGSyFJhg
	8mIX0rJlbW0aLUMoJh0wDLX46fQafhvi631R+NUdPBRL1tr20po2mu/Ofgl9t6jI
	48ITSa0ridw9diSdW4s3S33iq7w1i0Ls1z7+63qDmdxOLV2Tcy03KlKSHrzAcFLj
	5Qfz6mtMuPSJfoUUQhdeGw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46f1th02mv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 05 May 2025 18:07:02 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 545Gjp2M038297;
	Mon, 5 May 2025 18:07:01 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2175.outbound.protection.outlook.com [104.47.59.175])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 46d9k7rn5r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 05 May 2025 18:07:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c6IEh3rKgVQ0XNzT6ZJTAWt2WRKBOl101r+c2LzN0miwzPRyoY740baUS3kNLokVnLXuX5xwu0MJUvUTegFg5xaf5QgIz09Ga0Jseckhlt9vol9HUSvyD3yfkH28DLcX92VNGcuWXSGVK9ZzkPknOGJnHawriQi5G/VIiujRa/7lgLu73hD1MpG39kOeFeLW6LUutx6TbDDPgde0qYH4QvdADI9YcPm/lZywgttHyFbEukprSWkdZFCzfw1Ot8s2dLhqvv4/zPBwmyrcgfZKhnXrg+yv4OwHy6yFcn4vRhYNrgYd/V1gYIoNwIS4L3l+j8oKABPhMnwsIux4HptPrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MwBoQxedDF9kCE195HbUq8OjPfnLlS2LBjzyqzX7ltc=;
 b=b6OIrM7oHXzGfIVmyHMChnqCVzYosHFRymnnsYXcRq2oVhWYLbo+Cxj7+SLk9GgCHiHyVbhZnEG0mTm4PGObmWnselVc/TPE7z0yHkrZcu1VnM11l2ysvktJrEmS0rm73Z3Z7HBiVoXkedm0Wvf2Qd+d6I4D85iusEcgUuD9ryX7zzNv60P1PGaQuzrhejSK2FMdR6cg+wrio88FIoVWnqf7bSgpVLvgCtnHgPiSdXuxc3761ipC1N+wP67jCLtWbPnPLGXLg+smEnGiHoNqOH+31nQDTjHSvyAInSJ/6k0ER5q2Ju36zB8q2ZOCOujjKJ1ACfnloSNUtSITaMUVMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MwBoQxedDF9kCE195HbUq8OjPfnLlS2LBjzyqzX7ltc=;
 b=s3QrZUhyR8xeoPDtpVnDs9j8OdBRKIBPtt1+aIMxgccKueXw8CPmVjPjc6Nw+Ut6zhQIMXnD6NZiV8uAQpxx+59j5/hdYeEK15Cxkz+1EtIDTuzNSz1zs1tdeNunaifTfK/69mZMeMErLVcISQd7UmXX/dd3+TjMFCJkr8XTVUM=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SJ0PR10MB6432.namprd10.prod.outlook.com (2603:10b6:a03:486::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Mon, 5 May
 2025 18:06:58 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%5]) with mapi id 15.20.8699.022; Mon, 5 May 2025
 18:06:58 +0000
Message-ID: <32e4bd99-a85f-4f53-94bd-b8c3ecf2c66f@oracle.com>
Date: Mon, 5 May 2025 14:06:56 -0400
User-Agent: Mozilla Thunderbird
Subject: [ANNOUNCE] ktls-utils 1.0.0
References: <oracle/ktls-utils/push/refs/tags/ktls-utils-1.0.0/000000-c787cd@github.com>
Content-Language: en-US
To: kernel-tls-handshake <kernel-tls-handshake@lists.linux.dev>
Cc: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <oracle/ktls-utils/push/refs/tags/ktls-utils-1.0.0/000000-c787cd@github.com>
X-Forwarded-Message-Id: <oracle/ktls-utils/push/refs/tags/ktls-utils-1.0.0/000000-c787cd@github.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR14CA0020.namprd14.prod.outlook.com
 (2603:10b6:610:60::30) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|SJ0PR10MB6432:EE_
X-MS-Office365-Filtering-Correlation-Id: 9332f815-be9a-44ce-58ea-08dd8bffa084
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|4022899009|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?N0k3RG92aFpwUTVwT2VZRzZOdE5zRGt3M3hvZ3c0YXlYRmhPc1V4dm5iVTZF?=
 =?utf-8?B?cDViTldPSzFVVk9NbGJLUnl4R1NQL2JkWjZRNlpuY1RINVFPZzQwZkJGVkdX?=
 =?utf-8?B?K3phTEhyeXhOR3ZCYkhSN1BjQkpEMFN4RzBNTGVaVXluSkNJODJ2LzVBdkh0?=
 =?utf-8?B?cmpSb3VDempuTzRQT0JheS9DNFdZbU96d3cyYU83QWhPNTFlOXlQck9MaytL?=
 =?utf-8?B?M2VOYzdoeXhyYWlNemxGUnd5UW9OdUdsNGRRQ1IzeEdXVkNCeUVqRExnNDJG?=
 =?utf-8?B?blpQZFptTEZNcXl2aC8yN3BFSjZBOGNvdmI5QktKdThxVUtIZ0FpdHJLU29S?=
 =?utf-8?B?NjBpN2JVekJtOHBjbCthZWxEYlVtNTJqOGlqdmxxWTRnL2RvWFdYTTlPS2hO?=
 =?utf-8?B?Uk5oallpOWZPdW02R1FmVUE3amtnZjNnMHdRTFF6dnVSTENBbDMza29DN2VV?=
 =?utf-8?B?QU1KanY2TDBMQWlSUWtaYlUyUHRLeHZoc29XdnFzZmIwdThDMmxuRTJnNnhZ?=
 =?utf-8?B?eSsycE1HVThZbldOaFNSNkVkbjhpMFVjVHRQK0tFcDBmbHFOc293dmlJUUdV?=
 =?utf-8?B?T291QmpmRTBKMGhEdlVodndVbCt5dkZnUXNjZ0hDRnpFMHVIQyt5QmpuMFox?=
 =?utf-8?B?Y3g3aUh2bWVvM0FwY0w5RFRrVWx1VCtMbURaRmI4YnNEOENMZVpYRXZpNTR6?=
 =?utf-8?B?cm1LY0VZYmtEQVV5N3BCdENhOE05NGhHb1pBWHhyV2U2akZCOFg5UUJRR3Ey?=
 =?utf-8?B?ci91SDVYV2RsYVJiRG9kZmZBeTFYUGozWFM0VWk2WC9WL1Y4SXkxam1aUW1a?=
 =?utf-8?B?MDNRZFk0ajZObEhRdjNraVp3Tit6RjRUT3c0WndNUkNSR0I3WndQUFVGV01p?=
 =?utf-8?B?NngwVU4yUHZmZHVLbnRzQU81QnI1TFlwKzZFYVQrVUFvRUlnSlhoU21VZkpM?=
 =?utf-8?B?V1VuNDVlQ0V1N21nWGMvZHQwTWVhZUxWK2hBbVZtK2duSmMzQWJ5a0tpUGg4?=
 =?utf-8?B?UXdqVnpnZ1VudjltTlFOMjBFMm8rSkJoTXFPbVBiRHJXS3dEWU1OcDNOQXZz?=
 =?utf-8?B?R3A3L24xckQyU01Icm1acUZQNTF1M1VhYU8vTlJOWms5MmEycVhBM2NtMEhu?=
 =?utf-8?B?MUdNODZ4bER6NEpQb054T1hBTFFKMll5QVQvTjhWeU54YXdSM1RiNExVcjVU?=
 =?utf-8?B?dXRjTTdnK0hybGczZ1d2QkFQc3RZQVB5SVF4UHRHMmVDb1EzWlRmY0puUFpQ?=
 =?utf-8?B?WnRIb1M0bmdJZ3hUei9aYmJ0ZmxuSC9yb1hvNjhaUE5lQ0VoRWJQR2VPcS9a?=
 =?utf-8?B?Y0JCb3Q2Yk5iRE5SbDFmR0w5ZW5KQzBGOXBDZ2hHSWxGVFY1NDFJR2VGbFZF?=
 =?utf-8?B?QkhucHRCL08vMEtQTk9Ja2JRRE5YMlV4WUFxVTJzVndzRGs5N1BnM1FNTWpH?=
 =?utf-8?B?TjZ4ZTY3R29lYjdQMHRnaFJrUjVvc1M1WnFKSTVMZENkVGpiN1lUbE0wRkhU?=
 =?utf-8?B?ME5HVCtuU1pPVzY2Y2p1cVJidU1tOGRlTnFTMHg0bkNib3ZkZi9kS1dLRjZv?=
 =?utf-8?B?OHpFRUNJK1p0Q0ZSd1Jtbmt4Y216S05vQmNiWnV2SlNmbHd6bjVEQ1BRYnNo?=
 =?utf-8?B?L0NiNG13aW9wMUJhelhoVFYrdzJBQ2UvbEFMbFhTWVRHeXB6a1RvUC9FOUJE?=
 =?utf-8?B?bGxiandoMEUvcFdSbUhSMnpKUGdhNExTTTJtMnFsRFhPdWRKVWdjbUpaUnhk?=
 =?utf-8?B?elVsM3hZOWtiQU84NWZSTE5DRHFqRTdmWGVkLzFrMUFrTnFVZ2hoWDNFNjdT?=
 =?utf-8?B?bGpFL20xV2lkRGtybzJPR1FNZVVDWFZmbXlDaCtuZzFWWTZhN21zMnE2aGph?=
 =?utf-8?B?YjY5ZVhERzdsdUNjWFg0cnl2NzhRTWhWTW14OHZBMlVvUkZmcEVaQms4ZWxr?=
 =?utf-8?Q?rH+HsiJUIK0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(4022899009)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZkVPbUlKSXA1OGtvUVlRMTMvSVJEMlZNdEhFMnhPM0JQM2tROHNYN1dxc0lx?=
 =?utf-8?B?TDBLUjlmc21jYlVCNUhSNWk0aGdnb1RxOW1lZjFDU1Iyc2src0ZKSFc5RkY4?=
 =?utf-8?B?YzFwRndTdk9ZVWVxNXlnalc3c3pBRUdYcVg1M014N09lOVhGWWhPazFWMzhh?=
 =?utf-8?B?S0ZPc01BcmNlTXlGMW5wODdZNHNHUVhmWjd4MXpMNFJyWS82bXpYeFJBc2Fq?=
 =?utf-8?B?enZ0b2VER0RBdE5FbUdTaThrNFg4TXY5NVZROHRFOXgrYU5lenJ3QVdNOFJT?=
 =?utf-8?B?TXRDeU00MksyZ3FpbnQvMDF5aFJRRFZWeWZlNnhUM2F6b3BoMXpLMmZMZ0hm?=
 =?utf-8?B?SVVEODdLdUpIK3pJamtLVXdJUloxS0orYjV0Q0VpSHZRS0tqVUVheldxSGJ1?=
 =?utf-8?B?dGJyUVhhUmErYjV5OWJxUVlpbm5EbVNWQjJlOG1SL3RPWmw5SXVMSlg0N1My?=
 =?utf-8?B?dkowdkRwVlYvQTRGOTdVQkxQWUNWZWZ0UFdtSHBjWndqYll5WVMwWG4wMXFW?=
 =?utf-8?B?cWpoSk53OTVuREw3em5ORXpLRWIyQWtibVZhQlFYcFgxQkdEWlQ0eVVhbjBz?=
 =?utf-8?B?U3cvTzRMeHZJSGROQWY4Q1VNQitBOFg2OEZkaTJLbmlHWWI4ejNzSzMzVjFr?=
 =?utf-8?B?TDVtUU5qaHhJQ1BoTU5FTGlKUExVcVNXbjVoYlpVdjA3anRkdkpaVUx6VHhh?=
 =?utf-8?B?d0h3cENvbnVwUmROOHBUSmpxRVA5a1pvb2haSmpDd05jL0N0L1IvN2tKc044?=
 =?utf-8?B?c2RHZmdmRUpDL3NHSE5qYUVkZ0ZVYUtwZVpqdlM5WTJBWmFScTlQQ2lwZUtw?=
 =?utf-8?B?VUtsUmJIamFvOXgyRlNZY2lOYjBYa2pZekpDUDErTGlUekhBZktTcEMvam9k?=
 =?utf-8?B?Y0hDS0srTzFFZ0ZiSmVZSDE5MmpWWGFqSjRFc05GZ3kwQVl1VEhNOHl1Qit3?=
 =?utf-8?B?N3RuUVkrNVR2NVB4S3ZMT0lwVXZJUTY5cmVpODF5eEc1NE5CNFdpejNFa2xE?=
 =?utf-8?B?a21IOTJMZnA3a2ZTam1raW51ajVpNzhCYXI4TFB5eEVScGJrczBvRGE0ZVF0?=
 =?utf-8?B?TWhRTWhxcEpxcHkxZzB5cXhqOFlRbWhBR3BVZUU3VjBRNGhadDZjbDlVcC9J?=
 =?utf-8?B?VFo0R2lyT2JBTDEyU1YvMzJNRU0vQ1BUck1LVkE4d0Evd1ZWclg2RGM3eERx?=
 =?utf-8?B?Um9HbDRzR0ZvL05hK2tsRERqN2hvekZCYWs5RzVZem1BY2RYVmZhWmsxSDNP?=
 =?utf-8?B?a2dDR3dOQ3picCszdTd0eWZocWxOd00wWm51MjVVbmpxSE9XbjJLaGc4enc0?=
 =?utf-8?B?a1ZoSENxcFVieG41aFdPeEdnTWlsT0V0RlpXMk1PRDYrOTlqdHcwNFRMOU5U?=
 =?utf-8?B?bkdvUkw5dnBHSUtEN0gvdStUZkROY0lBcTZvUTFEeUkvY3ZHcjlPZnM0R3Y2?=
 =?utf-8?B?Q1p5M3FWaUNSQ0xWWkF5dkdxai9UenFZT1VBQVhsbUJIYk9YV2tkYU5IVk45?=
 =?utf-8?B?eVlXQlJ0Ky9OR2xRR3FxUld6NlB6dWE3ckJsdnJQM0xqa0ZBd2dRR1NPdG5u?=
 =?utf-8?B?WmpEdUpwR0pxTUFxQ21iNzkxWVR4QVlMdVZoRmpDRzZ1S2NqbFJQYlhLQmto?=
 =?utf-8?B?b1FmNzdCSnFxYldzU0JiVE8zT1lnYUx6SE95ZmVqVTlYRHhSZDZxYWd3cnFB?=
 =?utf-8?B?aTRLWkQrMk9rVU9hTFcwaURyVG5QWEkvbHRILytlbkMwWmFoa0tVRVo0b1A2?=
 =?utf-8?B?K2NaSm9OZEhxYjZ0WW5aSGc4UzRvSUV2SzNhdi85TWJWMmptdEVUZFB5SzFR?=
 =?utf-8?B?blhDSk81UFVIZk9mNVhPYUQvYUswU1lFWnFKV0U3WTY4cnQzKytUaUh6OEZy?=
 =?utf-8?B?WWdoNGQxOXJrRlFmZUZ2cjhqaWZWclArMXpXMDdUMHZRSlNkMU9rMjAvc0hS?=
 =?utf-8?B?emRKOWIyNGhObFN2RE9ySWtKNHBwekVPV1ZMNEhRYWd2emdEYXNZQ0ozODRz?=
 =?utf-8?B?Q0MxQTRmekQvYVlzR3NFSnZ4Z0NnN1pWWWRZY3JuMU1Xemkwb2ljcS95NkZL?=
 =?utf-8?B?bEU4MFkzVUp3QVlUV2V1T0xaSThuRWE4M1J5cFBtUFB3blo2ZUh1REE5eVV4?=
 =?utf-8?Q?7pEyKIP/cpL+uYtvYYw5zYqmF?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	tL/Mpau8LiilwD0FCLRV6PZubzRj0qk2EF75wKB9xtNFKqqaFUJvZFk4rLL/7cQXk+mDt25XdRJmMiHMXP5VSqZbdGSCsFtsKyG1+6y58WWsK31T5M2vGN/gXvKptAsNOJrrS9MNS+ZNaqjhmmYT6rKGXa2GU6cAgQzGxbpY8Ay0Mg+ZyMBk1Y9mF2gTXm9k2n2NNzUOoPLBxKbXGcvJzeet6UQ0ZlkKbuqXbTL1YaMNa6qGMmxsmVQjEiv7JEKc4Y/q0Y/sBVg8bOzvfINT1pP73Sw3etiEUozX559apPUbDpfSJWm0oaa8io/VL64okEHoz9e6foUuJR41UEgsAtPsLTnoV/y49sF/z6+gaqVq12inbSii4hKinvaFf7ZZPdK5ZaGVFhZKBDal/yyqZwsDFcZDwM6r6AgZAafnsb8bUY1qkB+Uy8gIEBs6drvkidboM/yh47fygOOQKX/m5og3X0bnew0VOCpRdpDqxEw1q2cmrqqG3W9BxhEVvPLRIAmzBR0rI5fESRi82srn7cHz/X2DP3WUsJ/DSbH8Xdrirs3IlHfwJ7jvsgGu2ykyplK93CETVbDFWqE+M4ddBP4sQgcMpAsJ8CV5aIfaaSU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9332f815-be9a-44ce-58ea-08dd8bffa084
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2025 18:06:58.4176
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wfjqbqb7WRpiUd4BLF/Hh1uqodA8m/IKPQndgKrpvH88h+8/P7gD+xId83XErOV3tZMrW3BkkREOs4ZzoAzdBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB6432
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-05_08,2025-05-05_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 malwarescore=0
 adultscore=0 mlxscore=0 spamscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2504070000
 definitions=main-2505050170
X-Authority-Analysis: v=2.4 cv=R7wDGcRX c=1 sm=1 tr=0 ts=6818fe46 cx=c_pps a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=NEAV23lmAAAA:8 a=yPCof4ZbAAAA:8 a=FbGEPtFUfCT0HSo4qEEA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: sYUunYU-gbg1L5-iRe0szLWVQ1phuDmd
X-Proofpoint-ORIG-GUID: sYUunYU-gbg1L5-iRe0szLWVQ1phuDmd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA1MDE3MCBTYWx0ZWRfXxQqqJ4KzJgiT fO52pK81DD/Xe/un13YnSgjt5M3cxC1UoL3W1w3fV1bRzgOIrBRPQZO7qWZ2iAIsMKP4iuhEsKm 5xIWKmD07tldJNl1mF0JjJP9BGpyhLaiHvDLVZEfx2qPCH4wALbDw5OA4c23vcsTNlR9qMpRU6U
 C/CKluKwT9BsI+fExOS7ZB/yyS4GhgHF/e8QP2pxfjwCCHtDixnmpVKi875+MiesEaUKODL+aKd 0T3KqlZs/EZlzqDUgUVOwR+SJJY4LPvgVKuAQVBOK0ddR0NNawQKvqw0dG/rGacudknTWxr8YJE 8n78dDlF8tFYjR5rZaaHnw8GRzCdFIiXv7O9J34rLLRRGP9ZvDh/9lssi7vfmthFUgBvJDbGImx
 HKM4XyYufHZ0rITxtrgMBwFIiG6ehFWRtbqC9cYH+XvKfH8HPKDngb0dRsZsm8yqUujzUhWX

This is the official release of ktls-utils 1.0.0

The marquee feature of this release is initial support for the Linux
kernel's QUICv1 implementation. In-kernel QUICv1 support has not yet
been merged but it is reaching maturity.

I had hoped to include a few fixes that enable ktls-utils to be built
on MUSL-based platforms, but the contributor has not responded to
requests to sign the OCA (he said he would sign, but has since
disappeared).


-------- Forwarded Message --------
Subject: [oracle/ktls-utils]
Date: Mon, 05 May 2025 11:02:34 -0700
From: Chuck Lever <noreply@github.com>
To: chuck.lever@oracle.com

  Branch: refs/tags/ktls-utils-1.0.0
  Home:   https://github.com/oracle/ktls-utils

To unsubscribe from these emails, change your notification settings at
https://github.com/oracle/ktls-utils/settings/notifications

