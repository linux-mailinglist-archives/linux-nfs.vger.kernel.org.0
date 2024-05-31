Return-Path: <linux-nfs+bounces-3513-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4D378D6823
	for <lists+linux-nfs@lfdr.de>; Fri, 31 May 2024 19:27:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D61B1C25A92
	for <lists+linux-nfs@lfdr.de>; Fri, 31 May 2024 17:27:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B7D07BAE7;
	Fri, 31 May 2024 17:27:52 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C75155E4C
	for <linux-nfs@vger.kernel.org>; Fri, 31 May 2024 17:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717176472; cv=fail; b=eUsnjb9Q1IQz9au+FEppreMz9VfBm4RJmUYBPxDb1x8Qf4zzwFQe76h6LtReiOlfTahfT3xnyte4YOfxFX4+u2L4EsmEzXcX0CQbMcgr6MV5aqX0USNY1gxj0b6zCe8LCLZxP3zzMIAXJOjxmKeZqZ4TC+ICj5hIAhfhg3aUXIQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717176472; c=relaxed/simple;
	bh=AXqB7BEl0euTbdZfRb37hLmZ5lIi5dPW1JdCWvdGg04=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DtyMkrwyw3axFlaySumCK3GodMnZFOtlsMSVj+lURg7TDj8iouybd1fpDIejhkAmaHbOLH/s4n78kphd1efnHcKHJ6dBX0le7dgdyVG3MK5BxJKasrOYThHWb6lN8LZJZgV+GYPvcF8L5Zy0r8j4iWooFgBkBeu8JVLN2pb4Kys=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44V9T8Sh020115;
	Fri, 31 May 2024 17:27:42 GMT
DKIM-Signature: =?UTF-8?Q?v=3D1;_a=3Drsa-sha256;_c=3Drelaxed/relaxed;_d=3Doracle.com;_h?=
 =?UTF-8?Q?=3Dcc:content-id:content-transfer-encoding:content-type:date:fr?=
 =?UTF-8?Q?om:in-reply-to:message-id:mime-version:references:subject:to;_s?=
 =?UTF-8?Q?=3Dcorp-2023-11-20;_bh=3DAXqB7BEl0euTbdZfRb37hLmZ5lIi5dPW1JdCWv?=
 =?UTF-8?Q?dGg04=3D;_b=3DTkJUQX+Jni4P2zXaAFGIMJKEYhDWTfusiqzJ/uhw95ZRmdGI1?=
 =?UTF-8?Q?f8tInojit00D9wYklgu_4VeHebmumOlm8XSlESE895+RlM0SVofPBzjdP/Twq6L?=
 =?UTF-8?Q?lhM9+0EHxpXjsvLY8IBEO8ysW_1k/bFVPTRl3L6vi0uEg+wAyxoCDAhaNwh4h9+?=
 =?UTF-8?Q?NRiDk3Mic5cZ9Tfbh281yHeiGg2zb1y_kOfj+/EHd4ChdsjXADzH8pP4lp97jsW?=
 =?UTF-8?Q?DsDQh6xpqE5cRVRwoe4xyhBCRD+bvkCGqojVs_5WYEccEMX57vmnnEnAgdMlrGY?=
 =?UTF-8?Q?iupZCuNkeb/SK/TrMow+l2fXMvhxAzhxMjYyw5SZ8QE_jA=3D=3D_?=
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yb8kbbquy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 31 May 2024 17:27:42 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44VGxQTh019527;
	Fri, 31 May 2024 17:27:41 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2041.outbound.protection.outlook.com [104.47.74.41])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3yf7r2r5sd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 31 May 2024 17:27:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SD+fkQgZMTVmi3EkwLvSc09WZyjoXjFsst2KR6c6PMdcrnwDs3p1/RXyQgHmdZCJIyE6fDoWa8watAxWBgmdtUByJV3A/IhuVG0p24en9PKtWjzQlUOC9GgUZZfhZzuwJWIg+/S8Cj2qyY4gPV4G6/rUg6z6zDhE0s2QZhjM9kbKLCy/0b3B8DYcVVPSzEavSqGzc2+Y3GA6XbIrn6uWgs6o1hvcL6QTgn+oGzuI7g1dYc8IfzQJZ5gfalDa8OtxHJd8D5Ui365vRgsg3WDZ8K3mqAzAeq9S/kaCd/xMgzp5WMEcmDIiLFbHgf9ffzWOFnd8kNTxo3WI4I7cMlWD7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AXqB7BEl0euTbdZfRb37hLmZ5lIi5dPW1JdCWvdGg04=;
 b=XyqrnENlr4p0qckVfvTO+lIsg69VWkHNyIYJNO06TIvRktKlxijfN5CoPqQgz1mLgikT5xQ8IKkuONwyb+sB5wsw7G60v9DOVWM0/ItZ3c5uOlSrud3mJ8RFZ91RCmp1c1UE2Fg35g/pEdqY7N7E6nnUZK0HeEINcRWoQQOY8vrJKNrmi5X2jXA4nPs6zK7OZY6DrXx0D8YWyFQorVgVGFCershYIlLY2zamfNyL2zlhU9YqLbfWUUEv9deGol/QFK01N1CQrnqWii1XTHLhDn7uHGfkVEQqof+3wbW6Gnnotm9KKqrPIkIKlRfBBuSnVbDyTnGnOtL00aXZwnRmbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AXqB7BEl0euTbdZfRb37hLmZ5lIi5dPW1JdCWvdGg04=;
 b=NSPAd6kB3l+D8Vq2LOtus6rUKeFdZpbtdQHZ9/xB7M7bAhfihUssCFhpj1K1kRxCfOJUWy46i/JauBBJOd09m3U0LFKe1HsY+uyp0JM1veRlXEizM8B0GfB+T8qUgfD2vVmDWA9soOejNWNb1oCp42QJ5geUjLcZhsi1UKFIN7Q=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DM4PR10MB7428.namprd10.prod.outlook.com (2603:10b6:8:190::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30; Fri, 31 May
 2024 17:27:39 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.7611.025; Fri, 31 May 2024
 17:27:39 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Olga Kornievskaia <aglo@umich.edu>
CC: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: ktls-utils: question about certificate verification
Thread-Topic: ktls-utils: question about certificate verification
Thread-Index: AQHas39TTLvaQrkL9UiH4bHQ94G1GrGxmJ8A
Date: Fri, 31 May 2024 17:27:39 +0000
Message-ID: <6A2D93D5-1603-4CB5-95BB-841163E20295@oracle.com>
References: 
 <CAN-5tyENK71L1C=6NwdB4mkxxf1qYZ2-4e-p8FQM=SmA3tMT_g@mail.gmail.com>
In-Reply-To: 
 <CAN-5tyENK71L1C=6NwdB4mkxxf1qYZ2-4e-p8FQM=SmA3tMT_g@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.600.62)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|DM4PR10MB7428:EE_
x-ms-office365-filtering-correlation-id: 9f48f08e-3f7a-44fd-d320-08dc8196f872
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|366007|376005|38070700009;
x-microsoft-antispam-message-info: 
 =?utf-8?B?aDh3SE5HdzlLdFE1bUpTZU94SVBsb3RqTk9uV1ZhOHhTN2FUZE50REl2YTl1?=
 =?utf-8?B?SFVwdXRVSTdMNVlLOHFpMHVjWE0yQkZ2NkhheG1sQ1h1ZjVJV1RNRElSOVU0?=
 =?utf-8?B?Q054QURrTmlBV0pSajl3WGlDZWZEU1NJSDc1SDh0L2lPRG95Y2FOeHN0aCt0?=
 =?utf-8?B?QS9yanFJcCtkcmdud252RWhNU2ovb2V4OXJWcGFPRTRHY1ArSVh5ZDk2K2p3?=
 =?utf-8?B?UFhOSDJWd2FCVnZ5SHRibWhUVEdid0o5QVF2c3FxWmlxVW1xZU5GTEVvZHY3?=
 =?utf-8?B?c1FxSFZpWEpwSndXa0NyVTJodHNSZDZGbGRMWjBHVG9kMVFCc3B3bnpDU01y?=
 =?utf-8?B?ZG1BZzhtM0E1cTFWUFNvaGRTdy9vakR6Sk9QSmxqcVNjY2kreDdZa3VVVWV0?=
 =?utf-8?B?NlFZQmdUcHJRa2JaclpRSkoyVDhibTd1bitoSUFnSTVHc1BLVlhLRDBwUGND?=
 =?utf-8?B?ajZXTFpkSXUvRWN5QzlFY0ZqdGoxUmVJUW5EYkhzMDlQekZWZzYzY1J0SW1S?=
 =?utf-8?B?OWZIbS9MMDBUU3E1MC9tZlBpTnBCY29YVkhvdVhURW9GdExoSDlxV1RhY3FN?=
 =?utf-8?B?NW84TU9GNkN5OGZEb1ZtcWNuWHVraDFPeUhZS2x4aW5oT3ArWVVMQW9hRTRU?=
 =?utf-8?B?bnJiVWJwNHcyczhENFJCa1pMd1hOdmwwQllQeXhxdDE4endxbHpNbk04aDdH?=
 =?utf-8?B?elhCOXd5WnhCb2svWTlXQzlSbENTcndOV2RUYXpKWGExbmRCaFEwN2dYQnpk?=
 =?utf-8?B?MFBaZUNxMG4vbmYyZlROSHJSVkJ6VUM3ZzJlK3NYaHdWa2xqdzNhMEdMUDc1?=
 =?utf-8?B?TXlQRFNRdFMxWUZPdU8yMi83RER2cDV3UTArYThyUWVtMjBrTzJwMTBEV0dV?=
 =?utf-8?B?bFpONkV1bVVCUWYwaUpzQmhsRmlnQ0RKSmsyZGtaQXlSZ3MrYUQzdkUrY3lD?=
 =?utf-8?B?L1RIQjdmL05UZDZVOW9NRzNKV2R1cGJJQU1CdlgzR052cS9mNFZoSU5yUFk1?=
 =?utf-8?B?V3VneEZRUzRqUlpwMXZMbHFQc2RxNkQ2NzZDeldMNHVXUFBoTHl6K0tSM21s?=
 =?utf-8?B?dWVTa2lKUzUrVFZLWXc5N3hGS09BZWNGb2RCb2pLZmZEQVo1aXVkbTNLY2pL?=
 =?utf-8?B?UytLYXMxa2RDWDVkY2txc200aWRjb0prUVpucWYwTGRMWnlzdVVFcC9Ka0J2?=
 =?utf-8?B?LzZoOHZBVmFvc1I2WDFJd1BSdjU5UnhWNjIvcUQ0eFJmSlY3eUVUWWptUUZi?=
 =?utf-8?B?NHRuREo2OW5tcEdRMjZEVGltQU44NkF1Qk1QVlBOaDNDcFduN0hqbjBmUXMz?=
 =?utf-8?B?SDVOMU9pL01DZzVkcWZYN2FQbEdYYzlUZDJ4Wk5PUldYN2tnRlZnTVBDVmVB?=
 =?utf-8?B?dDFlUUJqb1JzZ3NhbGltRFhDUjd2dEVVZnpIU3dnTEVVTjNNbUtja3dveDkz?=
 =?utf-8?B?c29wUUYydnJsL1ZnTnBDRnFKaHJjUnJqUCtiVCtjWlhDejZRTWJLVGNXZmNU?=
 =?utf-8?B?K0FRT2svT3o5T2N2NlpuaGkvYVl4ZjdYMGFmdzNqbDk3QVM5am9LRVRqSkFa?=
 =?utf-8?B?SVdWa2NVaEhLZ0JZS1FYVm9KaVFmd0RaYjMwcjFSa3krcFprdG1ZVy95MTl2?=
 =?utf-8?B?VkFzR1Y1QzdaSXRsbzl3ZmxueXc4Y1c3RGlzbEFmWDNuaWZqUTNqanY4b1pz?=
 =?utf-8?B?dWZyT0VtSEgwT1lMMEdPN0w4eEl2bFFJTGw0R3hWRkhyd2tEaWJhSldMUGVi?=
 =?utf-8?B?NGJnZ1FjU1FQWVpNdzRNWXpZaDBIMTQ5WXJLZmRUbWFzbkdZQkZSSVpEbTNv?=
 =?utf-8?B?SkhYTzk4WWFxellUVjVNZz09?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?Z3lGaThabVlFRTk0ZFg2M1JSSk16L28wS2RrODRqbzZsUEFRN1FTeTV1dVRw?=
 =?utf-8?B?RUZpVGo1azRHTW9ZZEduYk9nd2h0Wm5TYTRWQXRiWVljVis1V09uSWZtK0Jo?=
 =?utf-8?B?N1BBSGU2SGREU1VkbTVsM2ZFdDlKclh1TG4zT0xLa2JuY0J1aHlGZFoyS3Nl?=
 =?utf-8?B?ZlV6VDBlQURtcmN3OFhKTlFZRE1QZ0tEM2tOclNCYmNEZ2pYeHlLdm5xdlhw?=
 =?utf-8?B?ZTVXdEVtYktleGUxYzhwRmNOdVJFVWM5MEpXbUJxU0p6S05vRG1KcGxQRzEy?=
 =?utf-8?B?ODc0Smkrb1NTWWloN2VMVit5S29ZdEZQcm9KUHYzQ0pvRkYvN3pab25aYnJ5?=
 =?utf-8?B?QVI0SzV0em5ZWHJjWE9MQXpFaGNRYjdoMHBHclFNUk1HeEJWMFRZUElaTFNT?=
 =?utf-8?B?UnVFdVBKR0FvSW54b25zaTVGODQycUg1VjVtcnplcE55TnJXcmIyZjh4Vllo?=
 =?utf-8?B?QjBxQlIzM3lVZCtFRVZTbXV3dWlNQmhMRTNTWmdZZDN2R3d1YWd4MFQ4dHBG?=
 =?utf-8?B?WFNTUFBHQlFTYjN5Y2xnVVNlTEtBQjg3bCtKZjcrWXVBTEtjRmNCaERiZkVO?=
 =?utf-8?B?Uk9mMElUSjNCN0J3cmRlZ0doZmFkNjV2RGFYK2l4OTBtK0JLTVRDblFZdmJN?=
 =?utf-8?B?WEtEUzhJVDkzaUFSOU8rbWNFbWdTL3NTQm1Hc0VWekp4ZmpvUXVVYys4K2E4?=
 =?utf-8?B?WnlhVzRkdXIrMzZJS0NzRklkQ2ZDR2toR29xRkhRclpRUUhQZ2gzRDI3c2lL?=
 =?utf-8?B?SDVGdlpsOHNVclZtSk9kWWE2Y2VKVDExQnVlemJveEU3VVJFeDJ4NXdhSzlo?=
 =?utf-8?B?NkRrT0twN1JncE1oblc5TVhEbTNiUkU2RWhmcVhPU0dFcnRTZHRwbU02MEtO?=
 =?utf-8?B?TnpFN0RqMjRYcTc3aVp5RE9FMTZFVnl5QVhZMXgvSUc2SHZtUm9KMDNncGpW?=
 =?utf-8?B?R2duMCtUNEk2bUpvbFBZVEZqSit3L2ltUlo0amoxanVEbXk2bEQwdlBkMHUw?=
 =?utf-8?B?UzlMTnNIV2hpNWVySUJrS2IzWVQ5NVFCa1BzYjVURmNNTWk4SGo2V1dzMkNU?=
 =?utf-8?B?VzdteDhQcmFVNjZaeGtaSFdtZUZRR1M4SExLT2ExWFhGQkhpa0ZKTGNHM2Qv?=
 =?utf-8?B?OFRub3o2MzZpYXZlZTMzcE82ZXlwejk5WWNtY0FlRG9sNEU5aE1vbDVmS3lB?=
 =?utf-8?B?Y1J5YiszTjZHUEIrZ0JMZmN3ZHBDUlA1TnJYc3ovTTNWUlluOXp5cnl0Mnlz?=
 =?utf-8?B?cUhObTZaWi9KNUhGRzVGdWtscUxocFNvNG93UmdpZFFhUmhCWkNtNUxxQzd1?=
 =?utf-8?B?TEFNSXlLeHpsMy9OZktvQStwNUlickF1RXFQYUZuMnhRVEZDU0ppNUk0Z2VS?=
 =?utf-8?B?K3pSN1dHRVIxMWFFTTFXaWg2RU1lQ1ZlVi94MTN6ckVRMlAvdStWM1pVMnc4?=
 =?utf-8?B?Rm1PTVdLekYxOVo1MlNGUmczWHBFd3hkOXRnU3YzS0srV3I5SWpTM2llUG13?=
 =?utf-8?B?QUIvMk5wMndhbkVyeE5BUXhQM210ODF4OWlqTGlNQ0tRbkpONlRhZHNHUnJz?=
 =?utf-8?B?OFlMekNPdkRqOUxoSlJ3TFFFRzFXU3VrUW1CbWtOU3p0aDk1dUNHTE44MWda?=
 =?utf-8?B?V1Z1SGcxZms4YjhTMGpiNkhUekFqRUxCVW85Y1JPeCtWajVxckpkamh0TWh1?=
 =?utf-8?B?M1R6YTJrWFBYMFdtWnNVeFV1ZW5MamI5UHgwblJZUml6TTMxMzNvUVR5Ujk3?=
 =?utf-8?B?WmdMTWhkWkk4ZXF4RklRZTE5a09mQUNYVHNzSXE1VWJ6SElaeHFVbDRJdTEx?=
 =?utf-8?B?MHlSVXlRNnlzNEFmaVNSMUx3eXlxdnNYQWRpTlRTNE1pemQyd1g0RHFBcnRn?=
 =?utf-8?B?VW1DSGovckowa2xDQmQrUGcvYWtweUx4NVZPVXVwelJIcjFhR2NadkVZK2hC?=
 =?utf-8?B?T2JpL3pSN1RDY3gvV0JCQTVkSythbXdtRitqR2tUZ2NhWFVmcUYvT2VDZVNz?=
 =?utf-8?B?UCtUYkFqTkhEQWR4VU9TWXkxNFZKdnN1enRHNlRQMXFMVWlLTnN3MmVaSnA0?=
 =?utf-8?B?U29qVGN3MnY5S21EYS9yVU50Yzh4U2ZaM1BYKzN4WURpL0hzampOUDhCTlFW?=
 =?utf-8?B?VCtVN1V1S0U4KzEvSE9KTnJzWmpESGhFak5ROVFJQlV5ZnZncnVsRUVpckZO?=
 =?utf-8?B?Umc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CF4292336F4E964AA8573B2F3FD1025B@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	dBlJU6TbexKvOUMvUcfO5hgDXit8tcy7WAZ8ps7aJHZQBaSNqIqqOve6++4tV537+HBeQ69PBArtw88kinM6gowA+pTWAxR/3/NRfCTWsGlRi5uOl7m/UBWNBUdNGda3X3sD3KO95ov5yvE1yA2t4CHHJ/Kpgxx4KoicGA5IUwrwjTvoTV4YHiXmyRYdriY4BHzyXKxtp9pCUGvVkDeC50AaCXlOrehHKVCaFmyxkHAhB1tS0SoYZWMKSDkgrZB+QqfOa7I66z05YnkmLuaV2fNI05zLtuuEDGv4gJ7yP/zqS9PaGT0LrFjwx6QVWp4hhWhI5LChj71T3VnqqwGyxrsCZyzbKGVTsxcDU0PPZelGzcvZbLeMO5yIfey7L5FxHN+4DhZHZH3o0yTV0Iq8mH7VrLtEP4S69J18kyD2zWzywEgY9fERgG68UMiNlIod1EkOuISnI82/I2H4FJ/03TbUZL9PAwnQ+D2xLEyi0hClmzRMQmOkD87yOxj1kndat2feiRihl/kcbkb+VF3gmVGnVhiu39VzmS1Ip9CcTF3DsHswSXeQ4jWmaggrYrxZRqmvOhFB2UCPFr+zAvjzOAU9PZXtOg3wUsC7HKogIBo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f48f08e-3f7a-44fd-d320-08dc8196f872
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 May 2024 17:27:39.2642
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MJJTzTh88pjvmD1IkWmE5jpxW06xMb4Nq+fPbD2EhdQtsnswCF65MuNNrflXgbnl/QYiazClKGe+oTJuBdRO5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB7428
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-31_12,2024-05-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 spamscore=0
 bulkscore=0 mlxlogscore=999 phishscore=0 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2405310132
X-Proofpoint-GUID: vI3_H7KuYFApH4d_dSUkAgbieNwgmj3y
X-Proofpoint-ORIG-GUID: vI3_H7KuYFApH4d_dSUkAgbieNwgmj3y

DQoNCj4gT24gTWF5IDMxLCAyMDI0LCBhdCAxOjIz4oCvUE0sIE9sZ2EgS29ybmlldnNrYWlhIDxh
Z2xvQHVtaWNoLmVkdT4gd3JvdGU6DQo+IA0KPiBIaSBDaHVjaywNCj4gDQo+IEkndmUgcmFuIGlu
dG8gdGhlIGZvbGxvd2luZyBwcm9ibGVtIHdoaWxlIHRyeWluZyB0byBtb3VudCBvbiBSSEVMOS40
DQo+IGNsaWVudCB1c2luZyB4cHJ0c2VjPXRscy4gQWZ0ZXIgc29tZSBkZWJ1Z2dpbmcgSSBoYXZl
IGRldGVybWluZWQgdGhhdA0KPiB0aGUgcmVhc29uIG1vdW50IGJ5IEROUyBuYW1lIHdhcyBmYWls
aW5nIGlzIGJlY2F1c2UgZ251dGxzIGluc2lzdGVkIG9uDQo+IGhhdmluZyBpbiBTdWJqZWN0QWx0
TmFtZT1ETlM6Zm9vLmJhci5jb20uIEhhdmluZyBhIGNlcnRpZmljYXRlIHRoYXQNCj4gaGFzIGEg
RE5TIG5hbWUgaW4gdGhlICJDTiIgYW5kIHRoZW4gaGFkICJTdWJqZWN0QWx0TmFtZT1JUDp4Lngu
eC54Ig0KPiB3YXMgZmFpbGluZy4gQnV0IHdoZW4gSSBjcmVhdGVkIGEgY2VydGlmaWNhdGUgd2l0
aA0KPiAiU3ViamVjdEFsdE5hbWU6SVA6eC54LngueDpETlM6eC54LngueCIgdGhlbiBJIGNvdWxk
IG1vdW50IChvciBqdXN0DQo+IGhhdmluZyBETlM6IHdvcmtzIHRvbyBidXQgaW4gdGhhdCBjYXNl
IG1vdW50aW5nIGJ5IElQIGRvZXNuJ3Qgd29yaykuDQo+IA0KPiBIZXJlJ3MgdGhlIG91dHB1dCBm
cm9tIHRsc2hkIHdoZW4gaXQgZmFpbCAod2l0aCBTdWJqZWN0QWx0TmFtZSAiSVAiKTo6DQo+IA0K
PiB0bHNoZFsyNjAwMzVdOiBnbnV0bHMoMyk6IHNlbGYtc2lnbmVkIGNlcnQgZm91bmQ6IHN1Ympl
Y3QNCj4gYEVNQUlMPWtvbGdhQG5ldGFwcC5jb20sQ049cmhlbDk0Lm5hcy5sYWIsT1U9TkZTLE89
TmV0YXBwLEw9QW5uDQo+IEFyYm9yLFNUPU1JLEM9VVMnLCBpc3N1ZXINCj4gYEVNQUlMPWtvbGdh
QG5ldGFwcC5jb20sQ049cmhlbDk0Lm5hcy5sYWIsT1U9TkZTLE89TmV0YXBwLEw9QW5uDQo+IEFy
Ym9yLFNUPU1JLEM9VVMnLCBzZXJpYWwgMHg3NTFhZDkxMTU2NTk0NWNjZTVkMjlkMWMyMDY0NTA1
MzhmNDk2YjkwLA0KPiBSU0Ega2V5IDIwNDggYml0cywgc2lnbmVkIHVzaW5nIFJTQS1TSEEyNTYs
IGFjdGl2YXRlZCBgMjAyNC0wNS0zMQ0KPiAxNTowNzo1MyBVVEMnLCBleHBpcmVzIGAyMDI0LTA2
LTMwIDE1OjA3OjUzIFVUQycsDQo+IHBpbi1zaGEyNTY9IkVmenU3ZnR2ZTFTSHhCVkFJd2Y4MWp3
QWFzUTBNM2o1cVdiRVZ1TThYOEk9Ig0KPiB0bHNoZFsyNjAwMzVdOiBnbnV0bHMoMyk6IEFTU0VS
VDogeDUwOV9leHQuY1tnbnV0bHNfc3ViamVjdF9hbHRfbmFtZXNfZ2V0XToxMTENCj4gdGxzaGRb
MjYwMDM1XTogZ251dGxzKDMpOiBBU1NFUlQ6IHg1MDkuY1tnZXRfYWx0X25hbWVdOjIwMTENCj4g
dGxzaGRbMjYwMDM1XTogZ251dGxzKDMpOiBBU1NFUlQ6DQo+IHZlcmlmeS1oaWdoLmNbZ251dGxz
X3g1MDlfdHJ1c3RfbGlzdF92ZXJpZnlfY3J0Ml06MTYxNQ0KPiB0bHNoZFsyNjAwMzVdOiBnbnV0
bHMoMyk6IEFTU0VSVDogYXV0by12ZXJpZnkuY1thdXRvX3ZlcmlmeV9jYl06NTENCj4gdGxzaGRb
MjYwMDM1XTogZ251dGxzKDMpOiBBU1NFUlQ6IGhhbmRzaGFrZS5jW19nbnV0bHNfcnVuX3Zlcmlm
eV9jYWxsYmFja106MzAxOA0KPiB0bHNoZFsyNjAwMzVdOiBnbnV0bHMoMyk6IEFTU0VSVDoNCj4g
aGFuZHNoYWtlLXRsczEzLmNbX2dudXRsczEzX2hhbmRzaGFrZV9jbGllbnRdOjEzOQ0KPiB0bHNo
ZFsyNjAwMzVdOiBDZXJ0aWZpY2F0ZSBvd25lciB1bmV4cGVjdGVkLg0KPiANCj4gUXVlc3Rpb246
IGlzIGt0bHMtdXRpbHMgcmVxdWlyZW1lbnQgZm9yIElQIHByZXNlbmNlIGluIFN1YmplY3RBbHRO
YW1lDQo+IG5vdyByZXF1aXJlcyBib3RoPw0KDQpJJ20gbm90IHN1cmUgSSB1bmRlcnN0YW5kLg0K
DQpJZiB5b3Ugd2FudCB0byBtb3VudCBieSBETlMgbmFtZSwgdGhlIGNlcnRpZmljYXRlIGhhcyB0
byBoYXZlDQphIG1hdGNoaW5nIEROUyBuYW1lIGluIGl0Lg0KDQpJZiB5b3Ugd2FudCB0byBtb3Vu
dCBieSBJUCBhZGRyZXNzLCB0aGUgY2VydGlmaWNhdGUgaGFzIHRvIGhhdmUNCmEgbWF0Y2hpbmcg
SVAgYWRkcmVzcyBpbiBpdC4NCg0KVGhlIHJlYXNvbiBmb3IgdGhpcyBpcyB0byBhdm9pZCBhbnkg
cG90ZW50aWFsIGludGVyYWN0aW9uIHdpdGgNCmEgRE5TIHNlcnZlciB3aGljaCBtaWdodCBiZSBj
b21wcm9taXNlZC4NCg0KLS0NCkNodWNrIExldmVyDQoNCg0K

