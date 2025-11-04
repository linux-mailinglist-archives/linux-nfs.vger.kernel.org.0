Return-Path: <linux-nfs+bounces-16027-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 63054C32D31
	for <lists+linux-nfs@lfdr.de>; Tue, 04 Nov 2025 20:37:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3D8444F63B2
	for <lists+linux-nfs@lfdr.de>; Tue,  4 Nov 2025 19:34:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BBCF184540;
	Tue,  4 Nov 2025 19:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Rwpn4Jki";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="zd1Ic0Nk"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEB3121A459
	for <linux-nfs@vger.kernel.org>; Tue,  4 Nov 2025 19:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762284835; cv=fail; b=VJyrcZkONT4VBOpf9iT+RcY6ceBEuOFPmjcutpgWNgh0LUMvxAtGvi1ufbIdvFXbHlh9S/X0uazVMEE8cDmbjjNfKn6jc88WGXe1ewGJUhQZ8T3WzFH2AFo1DoGGFYMOtuud7xcDTA0Zmf4Cyr7KgS1thnLXo8vr7WT7y6/WBdw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762284835; c=relaxed/simple;
	bh=dkGbD1nJP9AQFfTEguh0xJPWKTx7XjDTcPHKMOJXfhg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=sJQ/jseCfEKDu2OqB+he+eG1aNfLxdZqeUxY2qARdhhmUlOEPkGKudxhROtshWojcYIXSNDn28TFI2I6KEeuf9ZulLZx24jlvs0UCbmQsvkfdM6oYZv4vwnCwpgv1rEgS//xCNw4B9Xx3TGB0IFDHTTfkCHY6ymS6b+Ytk9+uFY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Rwpn4Jki; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=zd1Ic0Nk; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A4JOihV009258;
	Tue, 4 Nov 2025 19:33:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=uiZPGKyGFK8dchbVUaypR7VzxZL70EZEWxmE79nyI1o=; b=
	Rwpn4JkiLD5wKbzPAWUYssbGbiq9EA5WFpgJ/hboLn4iFAB72FBMVOKHIqVRQ2uu
	T4bgXqbgkRnzrbuGkFLB/V9XJ2MAWFEWeT9hKgpavzk0no5U5Z6kL5MC0Etdy4p/
	VE79MBmOuXozjV5pOuJUFaIDAC2uE4icWbaZXVtMfRJCFGtCdYG8A3fgHB1ozZtn
	WVHo7KatWBwjkFqu/z0Yhiq2cxC4IQ5F6Wd/r0JoOxwkTioVJordR2OLVERtGFcg
	BUzyAUi81z/xURL7ow36osJTaY+eI9rrVBj35SlNb42hiJ7VvNRJhB3QLGZOazd5
	kIq0N8BQMsa1uw9tS9GrkA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a7qm7g0s2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 04 Nov 2025 19:33:49 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5A4IQcrE025004;
	Tue, 4 Nov 2025 19:33:48 GMT
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazon11013048.outbound.protection.outlook.com [40.93.196.48])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4a58ndkbkf-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 04 Nov 2025 19:33:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D2ENEdCkyK5cFVsSehYm5NVqYBGpP6i0dUW/tOI04taiap8NgqmgwKE0Lp8EFreMTXKpocN2npM9B7sUy9RFhhG4YltZM1/W5HFPtlIhiJ1ipRKsIYwbcmpdDCtbww+hnzm47T5zTBkUCx9OINEHU9GTqodOa5g67bTirW5mkBpFrwj3q3OcyvCD9APgU7JPO0h3H/9RCDoUBBLm52DBbEaC3JDmiNtYVlHJrYZC4NYaaEcCP0lrrcx3Vu3PdX56xAyU6LWmdFWsiqR4vsyP/PLGbKivDHabm81K161uFnNzmXpssBV9EXSQ1ODpxJ+72mbAucgg1jLKgI57QQX42Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uiZPGKyGFK8dchbVUaypR7VzxZL70EZEWxmE79nyI1o=;
 b=jjZ0v8tDF9f507NoaE6ZpThqZkYbbn60BFKNLXnVlKjeZ1LAlD/e8rKBnp7QPYMzkh7HDyG1S3PztgU4GN24ObiliZVW7HCyOC0JEwVF6ukUTMuvpCQHJiSTVcIAGUil9T+9aR7EjIbANB5yS/eUllkAzJNzlcV6nVdY+w+cqqKskCn1v2fF/PRG5DCTjJ8iSbDMAZnRX3bIjJD/LEKzEKKlyN3Ozp1qbYsuQeOAmepkjpa4LAGxJ1iC5Zu8V6kTRHrhEtZ5MC6gIg3eSPseJa+O6+gsTlZsBUDdn5P2jxWeuz+85Nj43ZaSdVTOq3syyybMUo+lGv1vUX1gewR48Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uiZPGKyGFK8dchbVUaypR7VzxZL70EZEWxmE79nyI1o=;
 b=zd1Ic0NkPWz2GGerjj/WCixZPNrgQkP7xT2V3WP2x4+aEC+LJpuYBcHPfVtlZ6lRj+G8Uwh07FstjiUcM7y5pXGLA+J/RFzsevJ/BUcCnrw2xV3K5VzE4n7gKMb8UI4gKL5GVg06jf8DkCfkTnQLe7K/De6u0SLbBRnwX4bk7i8=
Received: from DS7PR10MB5134.namprd10.prod.outlook.com (2603:10b6:5:3a1::23)
 by CH3PR10MB7629.namprd10.prod.outlook.com (2603:10b6:610:167::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Tue, 4 Nov
 2025 19:33:44 +0000
Received: from DS7PR10MB5134.namprd10.prod.outlook.com
 ([fe80::39b2:9b47:123b:fc63]) by DS7PR10MB5134.namprd10.prod.outlook.com
 ([fe80::39b2:9b47:123b:fc63%4]) with mapi id 15.20.9253.017; Tue, 4 Nov 2025
 19:33:44 +0000
Message-ID: <3c642f75-2eab-4cfb-beb2-350c4e323447@oracle.com>
Date: Tue, 4 Nov 2025 14:33:43 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] nfsd: avoid using DONTCACHE for misaligned DIO's
 buffered IO fallback
To: Mike Snitzer <snitzer@kernel.org>
Cc: Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org
References: <20251104164229.43259-1-snitzer@kernel.org>
 <20251104164229.43259-2-snitzer@kernel.org>
 <038374d0-6f09-4440-bd99-fbeef8f6d683@oracle.com>
 <aQo5VOxRpr-HORf3@kernel.org>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <aQo5VOxRpr-HORf3@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR05CA0063.namprd05.prod.outlook.com
 (2603:10b6:610:38::40) To DS7PR10MB5134.namprd10.prod.outlook.com
 (2603:10b6:5:3a1::23)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5134:EE_|CH3PR10MB7629:EE_
X-MS-Office365-Filtering-Correlation-Id: 4de0df0a-442a-4341-f023-08de1bd91140
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?WUN4c1BxN2JnblF4Q3owcHRNdkV3NVExc3gxZ3hKUktpVkhnSXpndzIzNEpT?=
 =?utf-8?B?V3lKdC9palZJOTRaQzBudTcwUlVjekRLRVJzSGlKMldCNFFhWXRsRXFPRFdV?=
 =?utf-8?B?bnBtNzkxcUZZeFlJMWM2SVNIRHphbzl3TFBTQjVzbkFrMUl5K2czblBkUFBj?=
 =?utf-8?B?ZWZwM3NCYTdsR0Zjc2Nsajh3Q3dDbDRrdHF2R2JuL0lQNHVOamQ1dUJaRnl6?=
 =?utf-8?B?VU9iK3NHTHVPbE92ekNUb0NiTFpBMHhBbk9ZeURYakE5VlZsQ1ZPejZpbVE2?=
 =?utf-8?B?Rmc1aHo1V2dORERtM0pHemt0Q1ZyRHRPY1U5eG81VkE4ekhSeHk5NDMrMUpB?=
 =?utf-8?B?VEQ5OU9VTVFCYTV3cU5XSkdoaDdvM2N3MkpkL0NFazhDeUdZNzh3VTl2eFJm?=
 =?utf-8?B?aFFOV0xHQjhiWGZJK2JERTRFS2hGRWxWOGdSbmdEaC9Zb25IbG9CUStHRWxw?=
 =?utf-8?B?VXMwRHVBMC9zMTBaTTVvZWkrNlVvbGVvbkQyWHpUemNsTGZkMTI0RklPdFZZ?=
 =?utf-8?B?SlNlK1V5ZkFIZ2dMUktMVmlENkZKUjZzN1hIOGhJcGJ2VmlCV255aTVpcUlV?=
 =?utf-8?B?bWxJZ2c0cU8yYlF6bUZ0L3ZXWTR6T2Npc2NYYjNHOHgwRjdiTWcrRDZNQ1pu?=
 =?utf-8?B?aGZrc3Z2azJoNSt6ckw5OW5YOE9FVDVTcHJiaHNtN1EwZDdSSlI1Y1Zqb25H?=
 =?utf-8?B?OEFXVlNTVm1BKzRtRGZhak83UGdpNTFPWWlMaW92VzdSbjNUcXMzUUgxd1Ny?=
 =?utf-8?B?eHd6N3BBRk9YeEo3UHB3bWIyTENqM0M3aDRTdmwzN3BLellPLzd5ak1FbmR2?=
 =?utf-8?B?RTQ4Z0ZCYUszUzhlZjV6YmFxZm5STHNJOTN2ZmQrajRIcFlZSitaZkpkTitT?=
 =?utf-8?B?alNoKzJMczFKZGg3M3pKbkJMNVp4Q0NFTVJSUTd4MWZobjZvKzBrS2xybDNu?=
 =?utf-8?B?N1lTSHZsSEZkNVpWYzBBSmt2UzJHc0t6R1hqN3JrVmJQOVFIdlZjUSs0QStL?=
 =?utf-8?B?VDJYZWRvemlRQUlwL3l1Z21qWGJROUIwZ2YvSXRjQmUvbDc1aGRKVUNUMVFT?=
 =?utf-8?B?cVhPcGxEb0xvdU1jdTJubm1XaUFzMDB5MVE5VGJteE44NUpXYU9WQlRjRmVi?=
 =?utf-8?B?bXNPT1ZHZlpkQVUyWS9PUTJSYmlaZmtnMm9IbXk0M212cHk2ejE4U3JoREJY?=
 =?utf-8?B?Qll5U0JQMUI2cDhqZWxvSGpleTFZd1hHZmtkTkFKbUM5cCtsVm5lVG56RkZV?=
 =?utf-8?B?U1FjVk1XdEk0bUxyV2oyNkszOHgwTENtY0dReEU0dWlOa1JBMS9ITm0zOVN6?=
 =?utf-8?B?R1Zvc0pLUEszeU1pUHAzM0tpQngvRnFZcVhjTVJDeUtvdHB3eG9kYkZFUjNl?=
 =?utf-8?B?d29QZzZrVHFXdy83eE82SkZYTzdOMFNwdW9KU29DUVhvTXRwOEs0RlpxUXk5?=
 =?utf-8?B?ZUNtSTNMT0pocis0akdtTk5qWG5EZ2JNT2hGakVsQzRyM0hzOFpWa1k4c3ZP?=
 =?utf-8?B?NnFSSnUweXhYT3I5SXRRVWFjakRXaGdiRzdBY2dwWGxVcDkrNCsxMm9aWTBt?=
 =?utf-8?B?SEJvVGQ0a211UDZSaGdpcG9FemNLR09DV1ZocnRZOTF1MkM4bzM0RnVZM3hL?=
 =?utf-8?B?WUxHa0JMQy9CZE1adnhuaEZ4U01QenpGZlJrRExPelZUTWVXSHNiRGp0QXB6?=
 =?utf-8?B?Vm5ha21neUZRTHczVXR6TERJbWxQcGovRkJLUTVmbmNXcThuMkgxVnB6T0w1?=
 =?utf-8?B?VjNoQVJYbkplMUZCLzlVSEFmK3Nqd01oT0cwSzFRWEorWk9USzRtQUdPOGhI?=
 =?utf-8?B?VmZNNEtWWEc1TzBsSTBPWTNrU3IwOEFUcUlkdlRHeDZCV01BUm5abEQrMG1W?=
 =?utf-8?B?Z1RxaGRwbDNqWUVEN2NPQ05YQTJGdk95cmJHUm9rcEdaN3ZZQVJNS0xTb0tK?=
 =?utf-8?Q?MR67xMm3G9HKvBEcLDsX4E5MTsfcuDtL?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5134.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?aU9mWER6ZXpTSy9QVllBbzFlMEJxRElMKzh6bW9OZEF4STZGZW1xbjhlM1c1?=
 =?utf-8?B?SE5oNEVjNS9MVE9mQk9tSk43SGFzZThoNHc3cnM5VDRaTXp5YmtyeGxwVUVK?=
 =?utf-8?B?UmNPMGpyK1cxdGVUd0ZYekd0aFdjQ2R0V2dJRzhzeFVSYkF0UmlaWFFseXVy?=
 =?utf-8?B?bUdYSEM5a2xvbUNlVjZjV3kyQmhlM0R5NmFGUmRMRGtueVUxTHRoU1EvVUZV?=
 =?utf-8?B?VHhCWFJRcnFZUWpYOXhqK1V6VTdyTG50T2xJb0twU3U5Wkt6UFRyNTBCbzB5?=
 =?utf-8?B?QmlEMnBsUXVGN1Jxd0IxTmRaaEJraWdldDFzVFAvaWV2Um1FeTVsOUtxMTdG?=
 =?utf-8?B?dlU0UVVrSzk5Q043b2U4RThuUFRCQkhEbkR0d05qMTlTRG9SQk02NFVxaklN?=
 =?utf-8?B?QlZicnMvRkZvMXNHczBOV05CTnRDMEt4c1hNUFF0SG8rTGZSYVlvak9uNUsv?=
 =?utf-8?B?dFhZcFJLKzNWS0lmV3g5M2hQQmZhQloveDJIMHZsZGc5cGVRWG5IRnh4c0FE?=
 =?utf-8?B?TnU5MVRqdDJDMUhNTDZiYzIwa3FXUjFDc21yb3FEZk1HejVPRE1mRHRyTzRC?=
 =?utf-8?B?WG1XUG9mMGVkZEZZR0xEd25Ga0FqK3N6ckRZS0V0Y1llQ05GTjQwVEJSdTdQ?=
 =?utf-8?B?UkdIeVo5aU9DWnYydDJ4M09vQ3p4M1duT3hiQ1RyWVoranBDZTY4OHV0bnNs?=
 =?utf-8?B?ZnFCekVLbU1KYm9iQXRDRG5rcytRM1FEZTNEU2ZvcXpBMi9EOFRhbVBPajRR?=
 =?utf-8?B?b3BOOU5JV0VOM1pBbWhaV05NWktYUGN2aU5kaFNFSWhOZkIrTm5RNFBUWTUx?=
 =?utf-8?B?V1BxQlY0YjZ2VGRQZkFkcWd1eC9PMlB3REIzMW1HTjd6c1pmbGlYajFrS0Ev?=
 =?utf-8?B?NmJ2RG9FZE9zaEZwdG9MenZlUktReDhJK0k2QTdhUWVWamQ0cGo3UEY0NWpm?=
 =?utf-8?B?Q2dPR1hJd0V6aWhUdForeENqTjhabmN5S1lkZDFZNEIreWtZNjgrd3N1NDRX?=
 =?utf-8?B?U25xSWFGUC9SWUtsbm9sSis3M3QrWmNva1I2SGZWcC9hNzU0OGlCVFRTRWRo?=
 =?utf-8?B?TU92YitRaHhhZTljUm1qb1lwUEFpTVI3cmJJSGVLTmxVTk1sa01VMVpncy80?=
 =?utf-8?B?dlVEaVExVXB2cERDYXZDRUVmY1hhekNadWQwdzMyVXVlTkxRQUhrSDZkUGlw?=
 =?utf-8?B?d1NIaERqUXVwKzlyMWZVc2ZJWG5jbExwL2R1cUIxcUsxVjQxOWpDYVVvbk9y?=
 =?utf-8?B?NW1yb294ejRydHRrOVB4TmR3KzlTdnVtajFjc25STzUvczVvaTlabHNXMXda?=
 =?utf-8?B?QU5keHpqRmIvOTgwSTliY0YvRENUdVhLbFZzWEpSK0k5RkorTnBJNmJqbHBD?=
 =?utf-8?B?WjVZbHB6YnVCcXpOOFNseCtnd1NZL0o2b0pxTzRoRDJWdHpqR091cGZiLzJZ?=
 =?utf-8?B?Z2Z3UHNzc0ZRVmNSQkc1OWFqbE8vNENMQ21XRVBpU3R3dU5IdGtVbzhKRFpa?=
 =?utf-8?B?NWlVSzc0MVl1Z0E3M1ZYaHJOZ2xKN3VncXd6cnVLSisyWGtDR0p3bnBBb0dW?=
 =?utf-8?B?V1Y5eG81cnVFV3EvQnI1c2dNNVNGcEE2d2VRelFSRVhmdy9qc0U4Y0tJMGp2?=
 =?utf-8?B?OGpTY1VxRVZ6R1laeW9iYXRBVnF2TkZ5U1ptWDN4ZWRKTG1mWWNlS3RmUnV2?=
 =?utf-8?B?N0t4Q2Zwb1YwRlpsSUFEazJoZmlMU1lxSXJDOHV5cmZnN0tsTmphS1VCalpK?=
 =?utf-8?B?Snh2QnQ4ZzZCV2RBOE5qbDRUSWtXeGlQazJYazVuZ1RuamxkcU9qbzBuZXU0?=
 =?utf-8?B?R010TVVvQnVhR1locW5KNkpOUm51eDR5emdXdjUyREJ1ZEZtVlUzRTNmNms0?=
 =?utf-8?B?bW1VTUdSQ0NuZ0FzRjU1WTJCN1ExaE54ZGEwZ0ovV0szb3dvR1FPUTg3TWZk?=
 =?utf-8?B?aHJIcFEzbVFWYWYyZS9xUU5qY1lCcDZLTWt0bUlPT3VjY2k1Uk80NGFPU01z?=
 =?utf-8?B?RnNQSlFQNmYwcTFieTlwREVsaVAvYU0rZlZWUXJYaXh4RUtjblpCdnVIOG9u?=
 =?utf-8?B?SlJvTml6c2NkbytHR1ZVZS9XK3cxLzhLR3M0ZE1iazA3bmZMWFdYeEdJdkdB?=
 =?utf-8?B?elBpaDE3QVMrVEVUcHlxRXNxTEJVblpNSGc4cWZzUHNzalNJYnZxTzgxak5h?=
 =?utf-8?B?L0E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Z/epqVH2oZSScG9M+wt29kasPoMOATJ7KCp68Tsx1fKY33RUZI6/Zyc8YCEzK34LL2GAnPb0w7SgX3g26xxVCthDpRdzjECXD8adp2wKZirc2crJ9fQTuAgHhEYx9Md1hEBCcjVhHv0L4iiox7oIH+aP9q39W3ZbOprQTu4tJ8xhqcS53oXRW933oDL6APtf0dihXR5rC8uFSBEAf7874tBOijnKvEF7RZx6iXT9se7iE85JXpocAL/jtrCgVyOUOefhhePvWJyYRsWo5SaG2TkQ5TL4XnbsQ9Bquc0KA0SCaBN1yiag833WctNl4Cx3DBS/EYhVbprlslppbj0J/ttOHm3fdawIAeJNOPY2C3pQwhC2vcQ6B8K71z1N9daHLG5pySCEVcyNdhSsDoMWkJpu+iG7udFtFKJ9mQeoE3Prl9zPr3nfV+xChRw49J4hgK1hIwtz+g4bebV76AIQAlbrAw/Q9a4vuwpUiJ8nZ0g6U7KRh2gf3ZfMV75YfRB/e0yWHNI/VjUZlWXnoFYxKOyrooRi0sQPgnkteR0fG9ABuKHVUVvPIiDt8loVBnC6rPfV9RSJZhVCTGh8M4jWcgIAu6kSDHgY9mfvZkNYLsE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4de0df0a-442a-4341-f023-08de1bd91140
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5134.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 19:33:44.5843
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OjshSZEtegIv1CssPjCrcGvi9gpWVOH/e0o4p77NMfap9YrKemXyMW7c0+A3Tx7tCMI4jcjXhf0SniYpmEHtZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7629
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-04_03,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 bulkscore=0
 malwarescore=0 adultscore=0 spamscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511040164
X-Authority-Analysis: v=2.4 cv=asK/yCZV c=1 sm=1 tr=0 ts=690a551d b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=ItR0Lh82H43DvQzcQ3UA:9 a=QEXdDO2ut3YA:10 cc=ntf awl=host:13657
X-Proofpoint-ORIG-GUID: HhrzhxAWN5DFT3Jpt-_-lXV4oRBV5y2h
X-Proofpoint-GUID: HhrzhxAWN5DFT3Jpt-_-lXV4oRBV5y2h
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA0MDE2MiBTYWx0ZWRfX/tI0lqaH1wwQ
 bbQPJ7LMT8FiRXEBsqhWiY4ppeWXRCVZmgQa2+2qS0TF6tdTyOjQZ4fAvKjNo08zy8QWdBf4Yhy
 SPzQbGF3gzAU+Ez4qT7OciQSvo1yPQXB7aQzUnazzjcNGPWbruCiKzKhHug8qRA1Of5F/vgFMVY
 ltjInsyRg3jfvE1/qdX809oEo3fmB0TywJiI1ScuWyX7hRrth0FOETfve3SS0qkGL4PBtl+MtBM
 IiPJwyXCcOuJQ86LuB08tPHW+C18mjKewKi3VEncpr0g8TLmwMEx4lJ0x0fvJWDimtWCa49PKXc
 aMzyP7WppWxvcRpzeHHRQyCF5PqqCdxRIUfJLTsEIFR/zswKD9xn3RTe4Y7cReR55bTsNwTC+Xj
 LR7dF3jiS5/CAntfdh++c2A2QeDU8VSJxQusI/uCQJ2DmleGQak=

On 11/4/25 12:35 PM, Mike Snitzer wrote:
> On Tue, Nov 04, 2025 at 12:23:02PM -0500, Chuck Lever wrote:
>> On 11/4/25 11:42 AM, Mike Snitzer wrote:
>>> Also, use buffered IO (without DONTCACHE) if READ is less than 32K.
>>> But do use DONTCACHE if an entire WRITE is misaligned, this preserves
>>> intent of NFSD_IO_DIRECT.
>> These two changes need to be separate patches.
> They are linked, otherwise if READ uses DONTCACHE for the small IO
> it'll kill any benefit to RMW.
> 
> Unless I'm misunderstanding which two changes you're referring to?

It's unclear to me why the READ and WRITE parts of this patch are
related to each other. So, if you believe these are inseparable changes,
the patch description must explain why.

I don't understand why performing READs with buffered I/O has any effect
on the RMW behavior of direct WRITEs, for instance. Unless, you mean
that it's not an RMW cycle during the server's write processing, but the
application and client are doing RMW? If so, the use of "RMW" in the
patch description and new comments is misleading... and I'm not sure we
care all that much about optimizing unfortunate application behavior.


> The "But do use DONTCACHE if an entire WRITE is misaligned" just
> amounts to a comment tweak in nfsd_direct_write (last hunk below)

Don't the last two hunks below both modify the direct write path?

The Subject: is misleading, then: it refers to both "misaligned I/O" and
"fallback". I think you mean only the unaligned ends should avoid
DONTCACHE?


> +	/* Don't use expanded DIO READ for IO less than 32K */
> +	if ((*count < (32 << 10)) &&
> +	    (((offset - dio_start) > 0) || ((dio_end - (offset + *count)) > 0)))
> +		return nfserrno(-ENOTBLK); /* fallback to buffered */

A few more comments on this hunk:

- What caught me up about "nfserrno(-ENOTBLK)" is that generally
  nfserrno() is for converting an errno that is not known at compile
  time. Here you are passing it a constant. I mean, that is already
  what you do in the caller with "if (nfserr != nfserr_eagain)".

- Why cap the buffered READs at exactly 32KB? That feels like you are
  using a number that is beneficial to a specific workload and hardware
  configuration. I'd like to have a warm, fuzzy feeling that you have
  looked at the impact of this change on other common workloads.

- The convention for new code added to fs/nfsd is to use symbolic
  constants rather than raw integers for such magic numbers. The
  definition of said constant would appear in an NFSD header.

- The new comment is repeating what the code does. A more useful comment
  might explain why this cap is necessary. But, such a comment might
  instead be placed in front of the definition of the symbolic constant
  mentioned above.


> On one capable testbed, this commit improved IOR_HARD WRITE
> performance from 0.3433GB/s to 1.26GB/s.

Can you elaborate a bit on what the benchmark is doing? Why make a code
change rather than simply recognize this is a workload that does not
perform well with NFSD_IO_DIRECT ?


-- 
Chuck Lever

