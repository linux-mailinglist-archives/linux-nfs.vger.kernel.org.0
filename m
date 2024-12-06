Return-Path: <linux-nfs+bounces-8395-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CE9F89E7928
	for <lists+linux-nfs@lfdr.de>; Fri,  6 Dec 2024 20:41:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB6E11888B27
	for <lists+linux-nfs@lfdr.de>; Fri,  6 Dec 2024 19:40:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86F5C1D63C0;
	Fri,  6 Dec 2024 19:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="IDZXTWJ0";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ZSVNHZSK"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 736A51C54A3
	for <linux-nfs@vger.kernel.org>; Fri,  6 Dec 2024 19:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733514019; cv=fail; b=dIU3PqG+yHTfdcsawXnlepxPbI5+EWEw/jNMMqMbmzZG1TaJ3ZMJ4w9aAUHS6fZNHXIzlIEEuB3BDpYmfxqUgOMSIKhFCyJs3pwu9qq39vsdQpO75mt68kkaNlGtgqHlg8Z6xKJJy9Hv0q1TFYuALx6GG98bh1iTfl2MyqMqoic=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733514019; c=relaxed/simple;
	bh=x1tJl0G69ztvEdzUSqXyCtpvlSUNB47pXjhhKMncKwg=;
	h=Message-ID:Date:Subject:To:References:From:Cc:In-Reply-To:
	 Content-Type:MIME-Version; b=jxEs3RPup3oVn/SWSm8NBH0bZZghh/talRC0HJr0ba6u3nGHsnUf1PZ6JVegtN/GkTTzHwINwVRI7SVwFZumer0Kmwr2nG9RtDiUaCG6ndhAXLCNJ30w5i8OJt82fkBmB+4YVMbIrE/oilTEib8Q++ZX6dbBzFBguSkw7x2TN4Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=IDZXTWJ0; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ZSVNHZSK; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B6JMmlq008842;
	Fri, 6 Dec 2024 19:40:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=q034Kr70NKJ8qRJlH/XLno17ySNE80SBYuizUP60tgU=; b=
	IDZXTWJ0M2P86O+moo5nKiteKKeOpTmcVmbcgKfIxe93iu6KvkEi2LsdcV3taIm/
	nWV9RUlrW9n7fxaSB1wPgTjdDHvfRjFT+Ma2fvBzINi9xlNhLGUDfu71O0dnaE+6
	ypUYJgXTrHeSp1y0gDeOEPfcbjzczJ+V0MWOAQFtkTSLenr8bjNw27b+r1hf8iPZ
	w5/gN4lU+9gdyLaDebGB8Ild08KWfq6dE6bAz0cAvSQw/6yxOly8xqdrHTS0neZ8
	/pBogCiruN76w2bJRSwg/si60FLQrSssMwBhNkzYT8mAQEhpBGzhMmluJz9LFwcb
	G0HcfPjzjDoYRcxLkL/6Dw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 437sa069rq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 06 Dec 2024 19:40:08 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4B6HsMZG001368;
	Fri, 6 Dec 2024 19:40:07 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2175.outbound.protection.outlook.com [104.47.55.175])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 437s5cnd41-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 06 Dec 2024 19:40:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T62p8+KorDH9BiVCb263tWI1YhOULuvrfH5rGQHM0jVfv/mGgDqQ45cOJoDFUmTyfTNtN+W4NQtzB2xO3NdY1ym/UC56XwVysQ18tLp98PnMkPdRDBoFMxP5SxdFPY/tCwiMBV3be3/g5w8dTANrPcrnCGYxD7sqFTCeEn4abevi2frW7mOHHdcZngGEpct90zT47ldbWHJXmHtidEZ5dXIXXcIZ3TQqHwmWcL2bZ+MNoPWJ0OkqkVnupIEdKks2pURB4focYZpyU8VIwb6Kdg6z7v3yd65E6ijvACkBvdWcOCVYg0FbV2sdLw6IKlt3hda7VAMTtEoKg7NLXPEetw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q034Kr70NKJ8qRJlH/XLno17ySNE80SBYuizUP60tgU=;
 b=ZdZ5yK7qk4MubOzXJScAj5roBvTBpOyecRsUACXFwO2lBtWDNmBo996Rv+oJXrdjLTlXVpcqFlAOYKU3O6/gblESb8Qa4dFoWVYfvhploy6e/dBjrv2s7DQKNdFSGnHAkVDlHSp0hzmYQ35ufSD598ZKbTRGyIAXpf65pneyjJe+pgHa8l3XGkjwcDAIaAwDgEQ8XpitypKpRSgjGYSoKiStKVsZHiXTHIiGNlFZjCtwAEKaL2PGjuJyihBmn3BK1jIT8XUhhFhcxGOPXUUppP2753kz4jv38J00qbxEBinkJIY6ahxFN+SX98KuZwF81UENAwxBUFis/Ws3ylzcSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q034Kr70NKJ8qRJlH/XLno17ySNE80SBYuizUP60tgU=;
 b=ZSVNHZSKk5B9e8ky6X2ypwqY2pVE4OBm/qbXw0d7YobmKDY3yaGvKUq/DEHe+IJDAG/++1Ex2s2s0UxbhvQhiEJlL5jHy9HzmX7wKM2awnqcgWka75LUueOBVzByK7ZdYgTKEBU8evN9bNuAwSWrx942PuUERtU7+O2X9Iu9VTA=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH7PR10MB7036.namprd10.prod.outlook.com (2603:10b6:510:274::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.12; Fri, 6 Dec
 2024 19:40:04 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%7]) with mapi id 15.20.8230.010; Fri, 6 Dec 2024
 19:40:04 +0000
Message-ID: <7731cac8-c0ae-4055-b5f8-07f0f63b79b9@oracle.com>
Date: Fri, 6 Dec 2024 14:40:02 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: nfs-utils library dependency littering - fork nfs-utils for
 Debian? Re: [patch] mount.nfs: Add support for nfs://-URLs ...
To: Mark Liam Brown <brownmarkliam@gmail.com>
References: <CAKAoaQmaf7d01vK4TfR+=8k4CVN-CX3ESPFh88EaxvcOAQDWtQ@mail.gmail.com>
 <fb7bf50a-29d3-4543-90e8-617fdd205f76@oracle.com>
 <CAN0SSYyzWqp2CMziwQ9dGQ8X4+cL42P78oLZDZDrxbPTK_racQ@mail.gmail.com>
 <15b348d5-abfa-49cf-b605-3819feecc340@oracle.com>
 <CAN0SSYwgankwnJXq_RDCr4rEG9k=iDZ=qaehwudwSd0_eOqA-g@mail.gmail.com>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
Cc: Linux NFS Mailing List <linux-nfs@vger.kernel.org>, carnil@debian.org
In-Reply-To: <CAN0SSYwgankwnJXq_RDCr4rEG9k=iDZ=qaehwudwSd0_eOqA-g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH5PR03CA0001.namprd03.prod.outlook.com
 (2603:10b6:610:1f1::29) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|PH7PR10MB7036:EE_
X-MS-Office365-Filtering-Correlation-Id: 29a913e4-42aa-4ad3-db35-08dd162dc808
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bUlZYTVSNmlmYldXWWlxNWx5L1Qzd1cxOGtBRTNRQzE3SHJlcHhBckJ6RGxz?=
 =?utf-8?B?dGIzMEY1bnFSTElYSFJsMko3bEVtdCs0c2xpU0E0T2hQZUlPV044aFpnbEMz?=
 =?utf-8?B?citVK2FMT09PdFZCNENLSXRpNGdhN0JuTjQ1eWlUMk82bDFTMHBlb3hqeTY2?=
 =?utf-8?B?WGFKbDgrNW5KSXdMeitTS2xIcGZZb1hpa0VrNVVyQWthRlhOU2U4NDlvRk80?=
 =?utf-8?B?RkVVZnVxYXNUOURldWwrWm5PRGFBdUdjZ0hzckJNK3A3bThaL0oyUHVRYWUz?=
 =?utf-8?B?ckNvRUJ0VzNjWVZ5ZXlFTEFsVUcramFObVFOQzRvQ1ZSdXI0ZnoxWXZ1MzVp?=
 =?utf-8?B?amdkekNBendGeTB4RHZJUFpqRmlYM1RYc2xVdmcrQ3UwVDRKaWlTYmkza1BI?=
 =?utf-8?B?Y3p4R2I5WFBNdG9LVUJ4cmxKSmlPV2s4VVZXK29yZnpOZTNFMnQ4MkM4TGdN?=
 =?utf-8?B?UkRjQ2NSbm5xak1tejRhNWZadURiZU5vWkJwQkhvZDdCVktIc0t1K3hPRFow?=
 =?utf-8?B?VGJJWUl2Snd6WTVZeG1neHM5bnZCdzIwRHUyMHdDVXkxMnUvdDJqc3Q3bGVE?=
 =?utf-8?B?Y2o4TnVLb2ROOXR6UUtlclZEWVk3YzR2WjN6cFdjQ1VUbG1iNWJ2WXpzQXhr?=
 =?utf-8?B?REYzMjd5UDFYR0R6OHQ5REJNZmw2TnU5WnZyK3NjRitsdDFtN0tTK2krZ0x6?=
 =?utf-8?B?NWdSMm4rVkVTZUtzVURJeHVIQ2xYL2NselFHaUNmZ1g0TUNaNG1tTFRUSEIv?=
 =?utf-8?B?Mm4waDBvWWduMHViaHNiK0xrc1ZyemNzWlg4M2VGUkVHR016OE9LR2dOcHRa?=
 =?utf-8?B?SHdZcWJTeVFmekpxVEM5OVd3Wm9kUUhLM3RDYnRNS3NNQzdaQWpid0JJa3hs?=
 =?utf-8?B?Tjk2dk0zR05kL0dWZmRpOHh1VDFUZllsMlZTOFpOSUtERFlTbHpQaTNncXUz?=
 =?utf-8?B?NzZlTDhseWFDZjgrTzN4Zk5QRzRSQnc5VllwK3owNndtdTJDL3oyUVNaSE16?=
 =?utf-8?B?b1pFNEZwR0Q0U1hFN3lsQ2FFTnlraVRJY1pEOGdzVDY0OFk2SGVDbWl2cUxL?=
 =?utf-8?B?M2pUeUZDdXo1eG1QaVI0c1p2OFZRYzJ2ZGZ1YlIwQzBLajRQbEVVUmdNd1BY?=
 =?utf-8?B?RmJKTk9sMGRuRXNSU3NZWTRnZW43N21rbWVmckU1aHRBWGkzMDdaN1dRMkp2?=
 =?utf-8?B?VzlXdE9sZUNzY0FFWWoxNHVjR295SHJCQlAzY093cUFjWVFSdjFYUHZwZy9I?=
 =?utf-8?B?dDZSTVFMelNWNnUyQTZxMGlvTWgwRmtYNVpnenJtRFFnb3JHaUg1Vk1WSUJV?=
 =?utf-8?B?eGJ3ZWRRMEZMNjBlRkl2Z1pEOTZtbSs0QVJ6aE5UNXBVb3B3Q2piQ3J6TDZR?=
 =?utf-8?B?WVZTSFg3ZWVhQ01LYy9pWXpxdE8yQkRsQ1p6R0pyZUs1RXVjdHpkTW02ZDFP?=
 =?utf-8?B?OFVkSnFZZGlIVkxKdzJYS2M5TTUxaU9LODRBQ1NYNVllbFlPbUFJUVB1a2x6?=
 =?utf-8?B?aUN2Sm9QcHM4RUN5eDRMbTNLd1NuRXVWUVNHdHJZeFBPOTAyMks2ZThWcytS?=
 =?utf-8?B?Y3lXbFFSV2JFWWhFTWtIbVVpTWNMek9tdnd6MWJ0QzRpZUZXTXcwbUZjK0dK?=
 =?utf-8?B?YzNpNDFzd3kxbHlZdXRURTZOWEEyV0ZQa3djUFJTNmh5Q3l5K0dOdEMrMDMw?=
 =?utf-8?B?WHhqNnlVRVVUS3VVK0JZanMxQUdRclNVZnZYNjFBZk10SkV2ZG1QV1NRY2My?=
 =?utf-8?B?K0dETVRobjFoTmNWL0IveCtCdG1xdG9tMFdtTzVVaXJENjBZaXRsbTRZRXlC?=
 =?utf-8?B?YUU3Ny9ML0VOR0txMkFqQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eFlvaUtPd3dMQmN0eGFBS25KM1V6bWtBRXlGYWF3dlFUdFRaK1EvdkFNTWJL?=
 =?utf-8?B?NUduaDRxSkZjSGxGa3V4MEVDRmFFZVQ1dFRJZTRqaHNJSWtEV1JVVzQvckdw?=
 =?utf-8?B?M2JzTGErWDVJVkgrT3dzTXpVSTE1TXNWNzJDVFlFbHNLa1BPQ2t4cUZqekdN?=
 =?utf-8?B?aVViMUZSa3NlTllzQVF3aGcvRW1RUXovSnBNV0JQQ2VxTmZta082cmNsR0ZJ?=
 =?utf-8?B?aDRXaUFueEtXWFBYVFlJb3NaTDZ1WStEV0I0cFMvMFM3b2FFZ2xzNjk3SzBj?=
 =?utf-8?B?ZE42SDMwbzByRTFDYnVtWVNzZVNnZktuclVRUXpsYWVlZ2d6c3prNjlCTVpV?=
 =?utf-8?B?Um94UTRibHhYVUQvSGZyeFNDVVpIOERRRGxjUkFRclJmUDZjZ1JOYzRTeG5H?=
 =?utf-8?B?c2xlMWZuYzdrNThQWlRhaEZEQkFsd2VmcGNhQ3BWY0NQRGVDZEhieG9NaUlh?=
 =?utf-8?B?b1ZRbjBvK2FXelRKbjBCVk4xbCtMdFlaUEN3SWl1NUcyUklwN1VlUXc1cDFZ?=
 =?utf-8?B?RGZDNStyQzRKRjcxdHhPYVRRTmRpdW5WZFBpUXJodk45NXRWby84OEwvS2ho?=
 =?utf-8?B?L3J0Q2dZWHBiQWNpb2c4TVlqdDJKRnVQSkNFTURDVHlvTUVlMWZOY011d2M0?=
 =?utf-8?B?bVpIcS9kWFRHMFpiRWluQjNnbVBqUzNTQkhidkxjL3VRakJXSWJ4OFdmR3dr?=
 =?utf-8?B?OTVFZFNmRW1sTG51b2ora3NvMklqdzZVZlJsSU92djhKNlA4TnYvR1VENk1G?=
 =?utf-8?B?SGFEeFFub0I1QmtUNUtsMTlzQllNRjJscmRTbldNVXJLc3BCdmJYV1FBNnZm?=
 =?utf-8?B?NDNpanA5SEUvQUt6MjRDQzZqTTR0QkRVKzdwd0srYk9oUXhmMGsrRkdHbjAv?=
 =?utf-8?B?V2FTZEZGb2dhSDVBbElCbWxtZi9jSXNyQXVFeXpFRWN0dzRzcXdiM1E0QmR6?=
 =?utf-8?B?M0twelQyOHdzVFZxdDFlKy9wcFhSdkEzL2RNOVdyOXFiQlBHaTRWd3JIUWdB?=
 =?utf-8?B?SEQ1Uk5Fejl2QWFWMW1ZK2k1VGo5QS9TS2l3RnVvcTVJZnhvdDZHYU9lTUZ2?=
 =?utf-8?B?NjJpR2JIWjdOWXhvajF4YlRwNW9tb3h1b0s3MW9YWDM2S1pUcUNpM1BkLzJR?=
 =?utf-8?B?d21sMHFDWXlueGZSVUZDbWlyV2dSSUlteS93eGFhaHd2U2N6WklYNDBqbmtV?=
 =?utf-8?B?Uk1WNWJWNFl5UWpON21uSllhMG1zVm5sV0ZzNjNQa3BkTWRVcFVERHByRG9v?=
 =?utf-8?B?VDUvampNOXlOejBFRXZ6TzlKUUpYOFdmVUFTWXlXdlZZS1hOSm9HVWh4YWRy?=
 =?utf-8?B?Ymd1blRLaFJJLzViODUwcUhSWFlWUGU1RkpESlJsM2pLRlZqNnZUN2hKdTlY?=
 =?utf-8?B?cVJDcWdickhlZEc2MjhLVW96aXRnNEhiSDE5cytMKys2YXJjRWhNYTJsQXZJ?=
 =?utf-8?B?c3pxN09jcUJBSm03M2tjS1ZJTHVQLytrWGNvTjlaejRDWFY4TWJjVEpVR1l4?=
 =?utf-8?B?RDRSdVBrbnEzSlFvMWFBeDMzZFpnQlM5ejJ0Q1lTTUFKVGt1WGNua1ZNMENr?=
 =?utf-8?B?UHJyS2ZlWWtBM2lIVWlad1Z4MDFSWnlDOCt0d0laTEZqMjVhVmVFc1AzdGxJ?=
 =?utf-8?B?SUQ1UEVYUU00MXdORXFYUkxhMmlFN0N5eHk2R3hhSTg5QjJhYkFoSFlOb01q?=
 =?utf-8?B?Smh5QTBGdFN1Q1JBMUhERm9HRXg4bVhsOWZIbTgxVTN6OHNyQ3BQY3NTOFNu?=
 =?utf-8?B?UDU5N0U4ZHZ4OVhpN1pneC9yQ0VBTmlENlVqWHRvMTVZTGVGa2doU3F3MEYx?=
 =?utf-8?B?SllQZHBndW96Q1dRWkRPK3dZdGpBM3I5b3A2ZkR4c0xWSE5VV0lwYW0xbnJy?=
 =?utf-8?B?UnZodmh5L2l4Z3hicGNZUVB1MVlIcHF1TERvSW92M3M1ZEVpNjBRdFZJc3Nz?=
 =?utf-8?B?a0FUS1kvNkVoczNWY0ZyM25HSE44WlB6QTJSeEI0QjVTbFVkYkw1dUVRdjBD?=
 =?utf-8?B?am9IRTZjd2NzbW4zckx0STFLZHphbGZLUVhuWkxRU1pSNEg0ZXE0YzRwOUJY?=
 =?utf-8?B?ZXdGcnlFSm5hUzMvbmxmUExQRUQ4TmtVQTV3MjZzdVNvemxYeFBHcnFJR1hJ?=
 =?utf-8?Q?MRXQJbV+p58Ygp4hzlwUK30YJ?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	vqkcUSXNzsD2wfltZxFZavEmFp04Oe6CwFhWxkXf6k2aVxX3Nd+ZUYViWMa1NCBhVzKIdd8w2AbBYHMjnK099qqV3HMdyqiSfdQV2uX/fAdaxjg4j6l54lq3fxH/UaRM1hOjZ5t9xD8Fy+EPBQEhlADY1SmpxUBiAT1EnDsI/uBdQdhcvRx//8ykc30zLO+tx4pORp54q4r6xhMPQ52biSSDVzfv6+0TS8gSYrRByPXtD1f/J+pPwgFA+qmVdVVbhySrjFsUpKxgz7XUGvv47Ygxwtz/ZmleuB/EVWgBIBiZRgAI2oFCPZrutmjink1qGd0AQTEf3JXUfxXJiGqw+kNXszmgSKa9EHliYUOOGqRec056Fm0f8LXk0wY17xeyvKwjpfmCYuTGlLe2A5+QjrHePyZOyd5Z63MB4AXAxhe3gbeS1HKvccMwDIk7aZjZqGeajZVSGyOfKsnZhao/el0H+6z1gwshyCBpi8Jf0+ZvjxGULpR8EiYSrzDZLeSRTgnKz9klc4i4bd1vKulr+jacA4tXm2vfwoBZgYtyXByvLh6+5fh6f4vjtpUiM3/aQAV/zYwJH8z07pUxdexS+I0OiZRQI84LL5Riftc+oIU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29a913e4-42aa-4ad3-db35-08dd162dc808
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2024 19:40:04.3308
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: by4l7dhcSSp6nL1qq4ciy/SFLpy9UEEYORI8QmwJ4aLaGaGzPE9Ge0wLVtTHrFQ6Y/u+gPr7V3OKfz5kbsWirw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7036
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-06_13,2024-12-06_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 bulkscore=0 phishscore=0 malwarescore=0 mlxscore=0 suspectscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2411120000 definitions=main-2412060147
X-Proofpoint-GUID: 5XQZtsR7g6mUvP9rNk23yRR9UEUFg8ah
X-Proofpoint-ORIG-GUID: 5XQZtsR7g6mUvP9rNk23yRR9UEUFg8ah

On 12/6/24 12:13 PM, Mark Liam Brown wrote:
> On Fri, Dec 6, 2024 at 5:58 PM Chuck Lever <chuck.lever@oracle.com> wrote:
>>
>> On 12/6/24 11:15 AM, Mark Liam Brown wrote:
>>> On Fri, Dec 6, 2024 at 4:54 PM Chuck Lever <chuck.lever@oracle.com> wrote:
>>>> IMO, using a URL parser library might be better for us in the
>>>> long run (eg, more secure) than adding our own little
>>>> implementation. FedFS used liburiparser.
>>>
>>> Yeah, another library dependency for Debian? First you try to invade
>>> Debian with libxml2 via backdoor, and now you try to add liburlparser?
>>> At that point I would suggest that Debian just forks nfs-utils and
>>> yanks the whole libxml&liburlparser garbage out and replace it with a
>>> simple line parser. Does the same job and doesn't litter Debian
>>
>> This is a political screed rather than a technical concern.
> 
> Nope. Stuffing the libxml2 garbage as dependiy to nfs-utils broke
> dracut in Debian and thus nfsroot support, and that is a REAL WORLD
> technical concern.

You should re-read your initial email. None of this detail is
mentioned there, so it's not unexpected that a recipient might
dismiss your concerns.

Junction support in nfs-utils has always been controlled by the
configure option "--enable-junctions" so that distributions who
cannot or do not want to package libxml2 can build without that
dependency.

There are one or two bugs in this area which prevented this from
working as intended. The intention has always been that distros and
other packagers can choose not to pull in libxml2.


>> For one
>> thing, a fork certainly isn't needed to remove libxml2 or any other
>> library dependency -- all distributors carry local patches to such
>> packages.
> 
> It is a concern that nfs-utils keep adding library dependencies for
> which there is no technical need. Junction support in nfs-utils> could've used a simple tag=value format, instead a slow,
> resource-hungry and upgrade-antagonistic libxml2 was chosen.
> Real world users could not boot after that.

This sounds like a packaging issue; that is, it's specific to the
Debian distribution, not to whether nfs-utils has a new dependency.
It was not a problem for SuSE or Redhat when they enabled junction
support (RH enabled it years and years ago).

Please post a link to bug reports that provide a clear description
of the problem (and preferably also a root cause). This is honestly
the first I've heard of such a problem; and if it truly is an
upstream issue, it should be reported and dealt with here.


> So a fork of nfs-utils would jank out libxml2 and use a plain
> tag=value format for NFS junctions.

It wouldn't be difficult to write a patch series to implement a
KV-based junction format and teach mountd to look for that and the
XML-based one for some transition period. Would you care to give
that a try?


> So nay nay nay to more libraries, or keep it the liburiparser dep off
> by default. People who really want it can do an
> --enable-nfsurlsupportwithliburiparsergarbage.

Why didn't you simply suggest that before?

In fact that is usually the way new features like this one are
introduced to nfs-utils, so it would be a no-brainer if in fact the
maintainer decides to replace the proposed ad hoc URL parser with a
library.


> No one really needs exports and filenames with non-American characters
> anyway, the workaround is just mkdir /myjapanesefiles/, export that
> dir, and keep Japanese file names within that subtree.

You personally might not need to handle non-ASCII characters in your
export paths. However, I'm told that most of the non-Eurocentric world
wants to have support for mounting export paths with non-ASCII
characters directly. So, although the workaround you describe works
today, it's not something that any non-European administrator wants to
use daily.

I have no objection to handling NFS URIs in mount.nfs if no other code
changes are needed. Most other NFS implementations have been able to
deal with them properly for many years.


-- 
Chuck Lever

