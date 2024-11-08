Return-Path: <linux-nfs+bounces-7751-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 593049C2087
	for <lists+linux-nfs@lfdr.de>; Fri,  8 Nov 2024 16:35:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 787911C23672
	for <lists+linux-nfs@lfdr.de>; Fri,  8 Nov 2024 15:35:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F70021A710;
	Fri,  8 Nov 2024 15:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XOcR5mo7";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="tF4EaF4O"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D7CE1F1308
	for <linux-nfs@vger.kernel.org>; Fri,  8 Nov 2024 15:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731080100; cv=fail; b=CF7z0kUC6NoYrera9yTC+rNry1XtwKsTDE6vnK/haQG57oZzLsmnK43hOJEbdSzOHHfvnDwfgOg/gT9BkXo5PFbnWlOS3vgVq3Ksd03QgkJufGnMHkb+4MeZM12aucxMCumPn7BaqIvc/R8YjYw+KFbiM0GeAcs/6ipEqiTogn0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731080100; c=relaxed/simple;
	bh=OGjMX43eIdxKdi3G7U5U/C0EFiWvkqEMuf5RJpQcg/U=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=g/hbS2oJCwjrpJRYe/6GcswZrSXd4sFAscMkhqCAcq/nhLB2v5JGMFRF30ZnGZz5LM+iZ79vwd2rXjzLXObFTkvxOlgg0acdFd+VSCoREZmNns0vOSNpgSG7LRuWbuq+9OwswyWrfrxHhRR/2xSkpSlRB+xEnpafq8p9WvmmBcs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=XOcR5mo7; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=tF4EaF4O; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A8EfZeD006882;
	Fri, 8 Nov 2024 15:34:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=OGjMX43eIdxKdi3G7U5U/C0EFiWvkqEMuf5RJpQcg/U=; b=
	XOcR5mo7jPkHzsAT+2zLH8XVJnigNJZHhiApE+6wr0v1VKCAQbNcAE/h4DSk9LWx
	X6LBhq8n1UzeFiZgH3s+BZiMJElRT5N6m1cWDFQzSxoIG40Wgp9wjJSBsILNyuO1
	ge55Fvxxi1j5SVhBxHxx2RxQ5ati7EbMTBdG+bprLt6EripVHz9iCkWicfZTcc0t
	dWhWoEVEXzy5fCvZ/dIncEA0X18QPSHnIuLkj0XP0uyrhKOj0qG6MalR1jSnAup/
	FYgCBomb/sr48vW005c29gMWTqvC1fBnLc0jL1btzRbhnCbNP9kiCgtwyQZMCwgX
	lnHMkIeyPcWZsM4GweDCSg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42s6gkhs7a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 08 Nov 2024 15:34:50 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4A8FGjhC033584;
	Fri, 8 Nov 2024 15:34:50 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42nahhw8af-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 08 Nov 2024 15:34:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GR9KqyZUEuDhSzGhxolwpC8sIG1W7K429tOgEzWpvjHuyiv/WjxJlsFcsMuwxtUOQfpWGtxsl57H8V34X6qMDftU6a/Qfj6QjWbgn3H6Ail1ka6YbVOuKvwnHIloOmuRCHL+xKDVpdjSR72XvCk8qYX7RQYci/ecCmpYlTGkD5Qj8zSwdNUz6dl0fG3z0tXA+opTEf+tgrcRxcLcy/dV032cADsgeazdPW1jTZjYIg2l38ghrfQl1udHPrGOLLNWKh5mdDfEm/l+DJZhtvegcnf0eq/0uD3+g4ZJ/LJCyMOshNQibJFFngphiOAWMIZAD6Jo3+JjmEVjLCKFFirmAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OGjMX43eIdxKdi3G7U5U/C0EFiWvkqEMuf5RJpQcg/U=;
 b=LEaSYFhcQLSgBJyyEi7Z0txBY0OiAPNlF/Vynq3TUk6QWtHn+XYjo1AP1TkkFpHxeYYUNEY9I6KHa7ehcV0S7YtAfFAppugnVJAL8RsBy96uJqDea/KGLBjGX6pIYq4bYqnYT4aSiUVXHXtm8V0x1ouIVp6au+5foPc8EKVIjK4LFyKnrDBp0aXqhBhEPXlGycr7J7mEkpBk7XeSEluU0GEEWJbj7ibi4oRGbYiTCWPhggs0Ol3pyEcQCvwD4dlbvzioBAzdsBkMPImJM6AjWKfdKYnKrpmY4I/wImn6IUPUL7sZUI/R9TmJC2xBRHQqsAbfvYGCdFB1NHO8Wb2H4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OGjMX43eIdxKdi3G7U5U/C0EFiWvkqEMuf5RJpQcg/U=;
 b=tF4EaF4O+OlzYIq7r4Se6fh/2ZZKehNmV4P+evwwVxo1Fwul0WL2sqZhKyZGt2bieQSITKq654J9d/TcLzbQDt7LtWuKUB/2YWKKNZWjmHcDHYjU9NAiAjrNsEPNnIwAXyqG7xE6TgAxu65YEecD8GEaV7Q6ohhaVGD6nQct2fE=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH0PR10MB7025.namprd10.prod.outlook.com (2603:10b6:510:283::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19; Fri, 8 Nov
 2024 15:34:47 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.8137.019; Fri, 8 Nov 2024
 15:34:46 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Olga Kornievskaia <aglo@umich.edu>
CC: NeilBrown <neilb@suse.com>, Olga Kornievskaia <okorniev@redhat.com>,
        Linux
 NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: FAILED: patch "[PATCH] nfsd: fix race between laundromat and
 free_stateid" failed to apply to 6.6-stable tree
Thread-Topic: FAILED: patch "[PATCH] nfsd: fix race between laundromat and
 free_stateid" failed to apply to 6.6-stable tree
Thread-Index: AQHbKNJAPJroocR06UmGvOIRe6tPqbKtk+0AgAAB3QA=
Date: Fri, 8 Nov 2024 15:34:46 +0000
Message-ID: <570FB8EB-C52A-4168-BA63-58DD0C4DFBB4@oracle.com>
References: <2024102832-murky-pasty-feca@gregkh>
 <25BB7B46-50A1-45BC-A10D-70CAB6F2F500@oracle.com>
 <CAN-5tyG5zwdo8O8ewoPidAZp_FJCpQz=KRPsgsZYa+U5bMkm8g@mail.gmail.com>
In-Reply-To:
 <CAN-5tyG5zwdo8O8ewoPidAZp_FJCpQz=KRPsgsZYa+U5bMkm8g@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3776.700.51.11.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|PH0PR10MB7025:EE_
x-ms-office365-filtering-correlation-id: cde298da-4b95-4fcc-7028-08dd000ae050
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?L01MTDZhQ1MrRjhEWHlncW1qQ3lBaUltRCt6MXc4NE1LU3ROSWMrRUdsZklN?=
 =?utf-8?B?aHZCdmhuYjAyQVBaTlpDQUh6SHVvRThsT0NBZ29ZdFdPRjhtVDRCS2tFeTRK?=
 =?utf-8?B?dE5OWGVzUFJxYmo2SmJRR1JoVGU2NHVtT213V0FFcHN6ZnFYa093NFZHbUNP?=
 =?utf-8?B?bU1KUlZOWkkzZEtIc0VweElobU04bGt0M2FlV0hOZXN5MnBQTnZuT0ZtSDRP?=
 =?utf-8?B?QWdWR3g3Ulgrc3RCSXdTOFBDc3RWN1NhZ2xtVk0rK1A3bFFCNHdsSHEzVGZ6?=
 =?utf-8?B?R1h1dGhCM0FUd2R4R2F3N0FhTmxrdFdLVWQxN1JJSm9yenBYRkpHanhUQUMr?=
 =?utf-8?B?cTdJQ1Y1b08vSzJyWXIvSnR4KzRsVUdTSTM3VHpmeFg3ck9vd2t1eDFwQStr?=
 =?utf-8?B?ZXZDRDlHRmQ3eUFpd0JzbEpRaHg0bG1HR05iYk1pSENvMk4yOE5uQzhNekQ2?=
 =?utf-8?B?V3VWY0lLZzkxMnljOUEvYW1xSFV5N2hxLzlNenRNTmd6ekViYm5WNFNEbEdJ?=
 =?utf-8?B?VVBaclRnWkVXSkFOOE94MURZUUYxeXVlSERCc0piZkdFQU1EQXBuQVV1RHFa?=
 =?utf-8?B?K3IycE5SbjhTNGRYQklnWjFYYlh4RHVtWHYrK2NZOWpycG00cmZBMXpsZ05t?=
 =?utf-8?B?N0J3bnRLMmNSTlQxakJEU1ZTM05vOVRRejdRbC9HaWt0Y3dGa3IzaDB3Y1pv?=
 =?utf-8?B?enVRQitmZC8yYTl0MjhDYXRhSVpWOEZWVGRibDZSOEtFTWRvT3h4WnY5aFg5?=
 =?utf-8?B?a0lFcC9ma1JISUxrN3Y0V2xGZHN3aE5SMkx1VDdYbEdYeEdjQkhwWi80MkhO?=
 =?utf-8?B?d05YS3oyM2p6blJzcm1MTDVreE02NkU3SW5CUjNVeWNXU3I3ZkZwcENUelo4?=
 =?utf-8?B?a1pnbEc5dG1NeTQxL2lvaE9XWDB1NE50YzBHWFhIRFZvQ3BJTHg0c1hXRm1a?=
 =?utf-8?B?eUZ4WGtRcTRwOGl5bGdSN0lZQWZBbEdzR3dRK1dEOHozWlQ2M2RnZHIzeVk1?=
 =?utf-8?B?SmpsaHB4My9wQlZsL2dKUjdwOGV6MzlnV004Ly9rcFFDWFY1QVl6N0VIZ1VD?=
 =?utf-8?B?MGJ2VG5aTlhiSUlOamJiYTQyTnBsVUpKQkI2NlBzUitTckJacHp3bmpOWUFT?=
 =?utf-8?B?WjV6ZnlielRod0xGUXBLSUplZHF5SVp5eng5U3ZtYlpMT2U5YTB1Q0hobnNJ?=
 =?utf-8?B?R0dYeHpVNHo2UTd3MDMyZlBaQ2dUYTA5RVZWU1ZZOTFZMXVDK01QSDJlODAr?=
 =?utf-8?B?T0gyWFJ1bDdoQzdqbnBQYnR3Ky9laDNuY0RrZTZCMmordkZLV2h4MDIvV3d6?=
 =?utf-8?B?N1FiZ2c2VGw2U0crMzBNNTkrRXU1U3BLWVZFOHdRWVBpd3JlUEhweW43UXV4?=
 =?utf-8?B?YUNkWFdmcWtiWVpKRDBhb2JzdnJrUHQyNlU2bUw4MVdIRXZYLzhQMTlGV2Ro?=
 =?utf-8?B?bncxTUs5c2JOcDZUNXhrTnh1MmdlYXJCSS9pcjF6dWFlQkhkOFpFTlM2Umxy?=
 =?utf-8?B?UTFWUkN5SVZkUlhMZTkwNzJhSHVyMUVqc2FzTG9zSytYVFFQYnZNbmx6TFdU?=
 =?utf-8?B?eXo4c0FISFlyYTVxQlBVZmY4WmdOWmliQUdIZmVsZTlBbUZtcTJkaXpZbDZJ?=
 =?utf-8?B?bFNGdjJtdUdSMllPOFk3TjhKZVRVSldXTkZFNVJhWk1aT0UxaHpjN0JRczM0?=
 =?utf-8?B?Nkg5NXN5L0RmSXNVa2JZWXY4M2FDK0VSRVFMOWlVZUp4VTZUbnVyWnoxYWZO?=
 =?utf-8?B?bDhJbk83UGtVem0rMS96SUdUSlZtelN5MkpiVmJJVVdaVzJVZmQyVCtMY0g4?=
 =?utf-8?Q?rVaTTyNyz6NcDe595+ETbItKAKm70zR76Q5nE=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Wm9VUUhGeGJsTlp1THJnZTNmVnU3R25KWDV5T1l6T1drQU1kK3RtU0FKOVBB?=
 =?utf-8?B?c1p4ZmR1OWNhcldLblZrc2xRZEdIWXl2MitZaTlFWmZaM01FSFM3ODVlc2ow?=
 =?utf-8?B?UWNjUzFienlKWW5XcTJNRGE4Mm81THJkUFQwSzMrRVBob1dFR0J3YlJMZHRC?=
 =?utf-8?B?U2VLaHlJVlYxMUtUOExuQ29vSnhhWlA2RUlsMkVzdEdDR2RHR0RRc1RkQkZ0?=
 =?utf-8?B?Mk96dDVHbkdyUElNS3QvMFhHNzhBVDhkL20wTUp6anp5TGVYbUNscDNnVWh3?=
 =?utf-8?B?Y3F4RE1rV0ZtdmFiTHRtTElEd3dVdFFVS3VwV21kU0x5WExwTVJGYmwxRTBn?=
 =?utf-8?B?Qjd4aVFvdkhsaWJsUVdCdGVUVDI0MHlBSFZmVmdqZ0Q5akc3MVJxYTJ1N2pX?=
 =?utf-8?B?bm15VDdpeXhKM3JNRStPRmxrdGlicW9GQWtVN05Kb2tNdGIwTm5PUlJnVWp3?=
 =?utf-8?B?Q0pxUGdnWEtIS3FsRThubW9XemhpMmM0aC8zY2VONmxZbVJEWDk1aEtnVTJX?=
 =?utf-8?B?YmhnYkVOQmdPRXcxQTRvZjVrZkI1dHUyK0hnUEgvZDRGRG5GMkxlSmxJandw?=
 =?utf-8?B?L1JSSHJKd0VLS0srRFhlK0kyMG0vcGRBbTZuSlltc0dod3BBNmpqL0hGSFlh?=
 =?utf-8?B?MWI5dGVTek4yUmt0djRPMGtzdTNiS0RxSi9yU1l5NUxRRGhGSENEL0tiSVFH?=
 =?utf-8?B?VzJOdm9aVW5iaFlGc3pNYWM3YkMzUzVXSjFSblR1Nnd2Z3FFbFNBYzRKem13?=
 =?utf-8?B?blIya0Q0R0hmZ25VL0dnUHFwL3RBZDE4S0p2eTNkQWZ3dERsMHZZdUVVT0ND?=
 =?utf-8?B?N1hadUx4UCt0UVdBME4vOXQ4RWROemIzY1dYRjY2L3E2VUJrWndxc3BjM2Mw?=
 =?utf-8?B?bTFqNU5yQjVLaVRTQS80TjdEcGdQN1ZDV3puSGZrRnFPY2JrWWhKMCt0ejdM?=
 =?utf-8?B?VWtsNnI1bEUyYzZkVkkwZ2Rkd1VqK1lZdGI2ME9WRzNmZjRLWE9pMzdEbDl5?=
 =?utf-8?B?ODg4L2R3bVQ3dWJXQU5PaDdzWmZCcEhDTFU0S3VsNExFYTdmWUtGak5YM3Mz?=
 =?utf-8?B?RnNqM0RvdnN0bkJIRCtJMnlHTTc0RFhPR1hkSDgzOFdteW16WGwrRGtkY3hn?=
 =?utf-8?B?U1d5MllkaXUxa1R3TmNtNTNLNFRzZURsT3ZYa3Zwc0g0NzNTbE9TM2xuQUxs?=
 =?utf-8?B?Rldod0ZDNEdJR3RYZDc5YkU2a1p1d2RSSnE2TTNsNkFUYW5sblpkM2FwUnpp?=
 =?utf-8?B?MU9mN2w1WklHbHhYZ1JZZ2czSkt2a0g5dGpKU0ZjK3YxeE5Nb25QNVhpcEN3?=
 =?utf-8?B?Wm5XOVhobWRKOSsyRVo2NEplRTZBVXZwWG5pbXJBa0ZvM0hidHFUczUvUkdX?=
 =?utf-8?B?MTAzWnZ3T3plR0ZqUXpNUjhkSVBJVWVPYWxJTFF0ck5rcDZEWFFOOXpxQkVL?=
 =?utf-8?B?QU1jd0tOWitvK3JSczZLaDdnVGtUYVl4QUJnbTYzRHp0Q0FMSVZ2NmFyeVN1?=
 =?utf-8?B?NnU3cHk0c2l1Q0UvdnU0WWo5R2VSTFI2dk1OWStmb2VScGp5a1JJQzVxVXhH?=
 =?utf-8?B?RU1WcExyMEFKTGUxRU15QmpBaEE3dU4vYzhwQmY4aFhmTk8valZzckhmUkkw?=
 =?utf-8?B?WlFwcGhBK3NLd1ZjTG9wWXlOTWdNVXA0VXhpdDNDQVdKU25iSFYrZzRGbGk4?=
 =?utf-8?B?bUpHSXB6ejNXWTBMMG5rWE9JN1czNEtPQm50LytjQ1dGWmJzVVBNVlpDSXRE?=
 =?utf-8?B?UmRueGhBaFNIdDlscEF3clB5bEs1ZGRHaDVlcjJpRlZiNUlQRGhENFZQL1F1?=
 =?utf-8?B?WFhmNExEQTd1dkRUSTIvQ3lUVVpib0t5eWQ5NU5CcllsRlBxbm5ReXhaR1dT?=
 =?utf-8?B?MzhTc05LYnpNbnorMEZ6T01XRHhWbTZsSUphTE45cFl4bnlidmhaSmxyM3N4?=
 =?utf-8?B?ZFNmVUljQTJMSkpFOUlvdDRPYW5vZzNvT2cwWXpUZTRoZFpONU9TT0JqWnZ5?=
 =?utf-8?B?SHhzclBNVytQVDNnWXlibkZiWmpXZ2duSkpQMDBGNVZNaXlGbFJzUWZMZlo3?=
 =?utf-8?B?UE4vc2FpcklzandvMDh5MW1aaWo2czh4VUd2bnJjQ00vcTZiV2p4SzB0djYw?=
 =?utf-8?B?NVNIRkxTanZZQTYvUk1lOStyek5NWnhQcno4eGZITDQ0RXRrQXBqbitER0Ru?=
 =?utf-8?B?RUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4CA7782856B9AA40995C0FE058A046FF@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	0lBd8Bi5arJu2aJmxfKq3Sn6zQAdt93nIbICPtAOS9kKfnhVhs6PQm7/hRi5peqW3L7IQ7qHI+RpFBK2G0Cy0e6G6fTzKzl0PY08KYZYhO7vZWzGc0v7WhPlPWxAZ76exhSx0BYToB4TLhsK00auKzyQNhf6bhhH28yezGAyrLxv2uuQveT8TzBodd8Rj4j7xIeiGQrlrKJB/IaDB22suWvw72fX+d6V+TqAl28U79Xgab2M2k5gCzFKdOkRjP/dhcUG8cx80nQ5B+lXV7OoAboeA+StEmscZMx3Wbvi+MNwLtkl0W8+Kr4tiqN0/nD5PRBYe0DtiaJjXaVmzxIEjMWdye0ejUQdYiBKpNuH7KhhymvEfIdxR5bsZIKwoSfGRFl28rNfevD8medLNEN/Bb1T+pN7xt0lZwB5IbNw+2Ayd4jJ+CApCeqmYsRLFg2Ezte8LPxfLeQzI1AmrZ8VUaT8oMI/B8CW4yDcdUPl7uzoEBORRbf9xx2VpuuWBBwGEp6dNnl/5BxoX0nLXIpbV3hBE8DgcUlNfkBMyHRMqC5WCJbcOR/0MujPLut++9g31blTwFxTaRna/thu+3HM5uxbmyh92g4qd/dr+iQZQ7g=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cde298da-4b95-4fcc-7028-08dd000ae050
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2024 15:34:46.8978
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 05oN+VXkWY7H+bjCqCpAT64jvRRN7KNSg+CUOGajxnV4hLPrpjwX2PNpFrrgClwVOogfPNx/cvE6qkYj2NRj5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB7025
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-08_13,2024-11-08_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 spamscore=0 mlxlogscore=999 mlxscore=0 phishscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2411080130
X-Proofpoint-GUID: 2_PxZnyXqM846tcJjx68zYxLs1VAC-R0
X-Proofpoint-ORIG-GUID: 2_PxZnyXqM846tcJjx68zYxLs1VAC-R0

DQoNCj4gT24gTm92IDgsIDIwMjQsIGF0IDEwOjI34oCvQU0sIE9sZ2EgS29ybmlldnNrYWlhIDxh
Z2xvQHVtaWNoLmVkdT4gd3JvdGU6DQo+IA0KPiBPbiBGcmksIE5vdiA4LCAyMDI0IGF0IDg6MzXi
gK9BTSBDaHVjayBMZXZlciBJSUkgPGNodWNrLmxldmVyQG9yYWNsZS5jb20+IHdyb3RlOg0KPj4g
DQo+PiBIaS0NCj4+IA0KPj4gSSByZWNhbGwgd2Ugd2FudGVkIHRvIHNlZSB0aGlzIGZpeCBpbiBh
bGwgTFRTIGtlcm5lbHMsDQo+PiBzbyB0aGlzIGNvbW1pdCB3YXMgbWFya2VkICJDYzogc3RhYmxl
Ii4gVW5mb3J0dW5hdGVseQ0KPj4gaXQgYXBwbGllZCBjbGVhbmx5IG9ubHkgdG8gbGludXgtNi4x
MS55Lg0KPj4gDQo+PiBXaGF0IGlzIHRoZSBwbGFuIGZvciBnZXR0aW5nIHRoaXMgZml4IGludG8g
TFRTIGtlcm5lbHM/DQo+IA0KPiBJJ20gbm90IHN1cmUgd2hhdCBhcmUgdGhlIG9wdGlvbnMgaGVy
ZT8gSXMgaXQgYWNjZXB0YWJsZSB0byB3cml0ZSB0aGUNCj4gc2FtZSBmdW5jdGlvbmFsaXR5IHBh
dGNoIChidXQgZGlmZmVyZW50KSB0aGF0IHdvdWxkIGFwcGx5IHRvIGVhcmxpZXINCj4gdmVyc2lv
bnM/DQoNClRoZSBwcmVmZXJlbmNlIGlzIHRvIGJhY2twb3J0IGFuIHVwc3RyZWFtIHBhdGNoLiBC
dXQgTmVpbCBoYXMNCmhhZCBzdWNjZXNzIHNlbmRpbmcgY2hhbmdlcyBzcGVjaWZpYyB0byBwYXJ0
aWN1bGFyIExUUyBrZXJuZWxzLg0KDQpJJ2QgcmF0aGVyIG5vdCBlbWJhcmsgb24gYW4gZWZmb3J0
IHRvIGJhY2twb3J0IHRoZSBwcmUtcmVxdWlzaXRlDQpjbGVhbi11cCBwYXRjaGVzIGluIHRoYXQg
YXJlYSB1bmxlc3MgaXQgaXMgYWJzb2x1dGVseSBuZWNlc3NhcnkuDQoNCg0KPiBKdXN0IGFzIGEg
c2lkZSBub3RlLCBpdCB3YXMgb25seSByZXBvcnRlZCBvbiB0aGUgNi4xMSBrZXJuZWwuDQo+IFBl
cnNvbmFsbHksIEkgd2FzIG9ubHkgYWJsZSB0byByZXByb2R1Y2UgaXQgb24gNi4xMCAobm90IGJl
Zm9yZSkuDQoNClRoZW4gcGVyaGFwcyB3ZSBzaG91bGQgaGF2ZSBhbm5vdGF0ZWQgdGhlICJjYzog
c3RhYmxlIiB0YWcgdG8NCmV4Y2x1ZGUgdGhlIGVhcmxpZXIgTFRTIGtlcm5lbHMuDQoNCklmIHdl
IGJlbGlldmUgdGhhdCB0aGUgcHJvYmxlbSB3aWxsIG5vdCBhcHBlYXIgaW4gZWFybGllciBMVFMN
Cmtlcm5lbHMsIEknbSBoYXBweSB0byBsZWF2ZSB0aGlzIGZpeCBvdXQgb2YgdGhlbSBmb3Igbm93
Lg0KDQoNCi0tDQpDaHVjayBMZXZlcg0KDQoNCg==

