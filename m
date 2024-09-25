Return-Path: <linux-nfs+bounces-6651-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 837F99867BA
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Sep 2024 22:39:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0346AB22DB7
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Sep 2024 20:39:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E383A14A4F0;
	Wed, 25 Sep 2024 20:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="EGmHMUgV";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="jyMMv2gi"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23F571BC2A
	for <linux-nfs@vger.kernel.org>; Wed, 25 Sep 2024 20:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727296767; cv=fail; b=PWq3WcceuPO9Qao2Rpwzc3pKsO/9to/JGTdBGIgn6GVVMGAcoTnPU5kcnXUncJ2hWB7+d5F3n9OXrPteoxkRQdG1SUt/QoBMWgDtBrKpNUG87QFB0V/nIDUcTHbKcWkfbfXsT07WM8028Ih2X34EbYTl6w7Piu3S58Pc8rbCHHQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727296767; c=relaxed/simple;
	bh=/L9JreessfvHmE+km9/83eaegnFuLJ3EGE3nwRFOT1Q=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bBh0r5elEJGca4xbuiOimji8oT3sTY5LexGZ1upyWO7MyKG+MGQmzvaPOL6Wm4mJJkZQxEUuGmTs8wt3WNOpJQJtVzTkHzT4Qgj9bitZ083p0n0zLfSrftIE47cQTUooJQCc3+T0vD/yYsMs9qx1FeOTr3znuEbyUz7qF+8//qg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=EGmHMUgV; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=jyMMv2gi; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48PKXa6J006627;
	Wed, 25 Sep 2024 20:39:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-id:content-transfer-encoding:mime-version;
	 s=corp-2023-11-20; bh=/L9JreessfvHmE+km9/83eaegnFuLJ3EGE3nwRFOT
	1Q=; b=EGmHMUgVEvlJDVjq9i500udO7xL+FrjKapbT6JeEn39bpWtPw1KVs+aEN
	tB88JPUHwa6xmx1DtFvx0MgQuMHl3z6bsIOIg6vwoKytyBU7+edxjjHbsN6dinF1
	DlBdI18OEw4Sr3u7Tkq7QCeS4RS/minGuf0oc1+xlD8RDgF5jEWjemobZ6SDo+kW
	bmcxsxR166Wia3+IwI0IDQIx8hNv6iv0s+B6BKly1sFlfqdXo2SGRXMPu4ZvG4Fx
	0OyZTqEGi6aNtgOvgFWQ+7U336p2+kUkWOdqBwdFHUIBxLdMqSE7zEXUHu671c+o
	q6FoMI2n8B8ii3BGpevAEIv2A9fHQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41sp1akbgw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 25 Sep 2024 20:39:08 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 48PJmJeh030361;
	Wed, 25 Sep 2024 20:39:07 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 41smkb8pu4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 25 Sep 2024 20:39:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hlq8K2rU7X6g/Ysio7ja0OCFWJ6RScZb/vQUYiC0tqmNDV6p7VoVTfLCX3S2wZeeSSxW7pM8Gyc5A33PV+MQoBp3ncvFtNoyZWJW9/xCLgtKU5cW2aE5QHaUL/LNb2eDTh31Jh9ONQJNuCzp82RDTtXyPnx1mIQkFfNXbpVMlAIyV65S2CsfQPKT2svm9lfWZQs9bETYAZkGlQXrSuGQCJ38eLCHMBt2WPv99WO/FEOTQ32goAjbXBfE5aOvoiTCUF654PGb2sZU5dexkbvRj1kbfbGKUPSp6d8oQed70C2RucT4NKNgTJofLXwKMPg4oy2zu6Izx2kgD4dNXUle2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/L9JreessfvHmE+km9/83eaegnFuLJ3EGE3nwRFOT1Q=;
 b=tmiHrpbres0ebKAbtWcoIBNP5MrCv7lfWB6Gfn8UUvewi1CFuzA8xvHVSviTupzGd0oxG/NTGr8JC6aM8XbG1ekCWoiZNNrN+5xPO8WL0OC8m/Wfo5bwpQJZ34oPuJIrBjfrNdXir9zzxtnCjKWqXs1CebFZCKeYuN7GV+EPDUIIAhzTp8F/j263se1p1cl9qHqwszQv/CTBg3eR9aam+3/9pRDACEv+IYCOJmNASHd4ArEUi9I+frZD2/tS3Jf1F9FVlDbGHsvQx5aVQq3XLwUx02p49UKcEz8JhKNFCUoqx5wOxOC06iiCooFNbc0InxZBcX4GnCOiVruC3yHg0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/L9JreessfvHmE+km9/83eaegnFuLJ3EGE3nwRFOT1Q=;
 b=jyMMv2gi/3UtC7uC4GDusKM7o6BYqH4LlA3XQaYsFthZNQLTRFMOJxRoVbSve681uvlxg+3rClyFLTteuJAQeYuFmKBOzg8EbczrXbMLnkJO9HtAc/EJ4KNQuE3Oe8fTqD0jYSxxe2KTWhKyP1hEeM7xhw4FskIr1xmVH/hBsRU=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH7PR10MB7837.namprd10.prod.outlook.com (2603:10b6:510:304::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.10; Wed, 25 Sep
 2024 20:39:01 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.8005.010; Wed, 25 Sep 2024
 20:39:01 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: "Hanxiao Chen (Fujitsu)" <chenhx.fnst@fujitsu.com>
CC: Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "ltp@lists.linux.it"
	<ltp@lists.linux.it>,
        "Xinjian Ma (Fujitsu)" <maxj.fnst@fujitsu.com>,
        Steve
 Dickson <SteveD@redhat.com>
Subject: Re: TI-RPC test failures; network configuration related?
Thread-Topic: TI-RPC test failures; network configuration related?
Thread-Index: AQHa+kqUd5GqyOUrQEOhJTzAS7dpNrJUYj2AgBQMxoCAALJDgA==
Date: Wed, 25 Sep 2024 20:39:01 +0000
Message-ID: <4BFE3BC1-5ABC-4924-9F53-ED87FB0D680C@oracle.com>
References: <662B8BF1-099A-4CD0-94AB-267BE738130F@oracle.com>
 <FB5CBAAE-D2A4-42A2-93D3-FE2C893871AD@oracle.com>
 <TYWPR01MB12085B32EDB006F5C99DD8E95E6692@TYWPR01MB12085.jpnprd01.prod.outlook.com>
In-Reply-To:
 <TYWPR01MB12085B32EDB006F5C99DD8E95E6692@TYWPR01MB12085.jpnprd01.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3776.700.51)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|PH7PR10MB7837:EE_
x-ms-office365-filtering-correlation-id: 770542c0-ee0c-4259-f334-08dcdda216a2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?R1J0dGpQVVhFMkRHNkZ5cE9YTXVtOStRZU9GbFpuUDRsT1ppT1V0aU9BNjR0?=
 =?utf-8?B?WWJZeUZqZmRFNDFJNm1SQ2VpYStydjVJSU0zSUI3anZFQnN4WWxhQmlEWjNM?=
 =?utf-8?B?WWVXV2hmK1FScmwrSHd4d1B6dmdmbC9GNG1mY3BBaU5pTzQ2ZFQ5VERQSFNn?=
 =?utf-8?B?eldPb3RqKzltcmtMUUFJSDNWb0tBZmZmamltbVdhWkR6elJndTN1K1dBMGJx?=
 =?utf-8?B?WXdSckI4ekF1MHlQSG5OTWR1NWF4cDhnczg4YktVRW4xT0RNUEFpSkMvR0ZM?=
 =?utf-8?B?YmpJc0VxTlFnZk1yY2IyMTcyaE1NM3FQek1IdkVML2dFRXVmOVkwQUVHeHRR?=
 =?utf-8?B?U1Bmdi8yYVUxVXVqdzdnZEphK1ZBak5yVFIvWXdEN1pLU1llVlhBY3puL0Rm?=
 =?utf-8?B?cWZVdTQ2U1c2bWI5Nnd6ZnR0dkFIMEFha3VmTXQvb2ZpL0dHc01jTnhkdzha?=
 =?utf-8?B?eHJva004cWU0TXltWUlTV09XdC9TclViYlA1Si93OUtobzhxdmNFd29OWE5N?=
 =?utf-8?B?UEhTWmlUZ095ZHBDZjJnZnczZ2dTajV6a2NTZSthVVRJWitxSUVPeEloNFpn?=
 =?utf-8?B?YXh3WDlDV3pwVzVJemhPdzcxWCtZQndPQ3ZUMm1Ua3ZtMGRjL0tRSWhDdTNv?=
 =?utf-8?B?TjJDU0FRZ1ZkV08zU0VCYUJiajQzTG00NjBmZ29hcERVNUQ0USs2WEpyMkor?=
 =?utf-8?B?eTEybVUrdDB5TG5qZVppd3owbTErYUV2a2hudlpkcE1BNGlQSGcyN0V0WEJE?=
 =?utf-8?B?cVBhWXNkRHNlM3VXcExoTE9RbDJJWFg2Mmw3Q05BOThDcDJ3RjBhZnVZc1Rn?=
 =?utf-8?B?TXQxMnN6WFlDWGVOMVRnS295VG54UC9KaU8rWXdUNEZMZDdQK3RlL2liSExQ?=
 =?utf-8?B?SUdUYmZSME02U0VhMkFHWGphRGxNOXJPVUlxaXNJYkM4YUhhQzlJaFN3U3hG?=
 =?utf-8?B?aW4zUWt5bEFxT2dXaDBvQ3ErV3A2K0w1c1dWRXoxL2hkRmdGSFhVUDRQY0pD?=
 =?utf-8?B?M0UwcDB4bllIQk10WFV1Nk9zM2tLeFRxOWMvMHltVHdFZVVPWWFORUlpUGQ2?=
 =?utf-8?B?WWdHMllFV3BsZnE0TERxWkJmTEIwaVkya1ltbThHWXJyOUJHY3BQOFJ0a0pN?=
 =?utf-8?B?Q0tyZUJYdW51QWF3NDBpK3hRRXNrOFhQQnJXSGlLL0hGU0hnZFhPWjVwWDg1?=
 =?utf-8?B?Qit4eFlqQzFOaUNyQUhjai9SK2lZVmxBVjRmekhqYmpKTkFHSk1zTjFBUUIw?=
 =?utf-8?B?ZUtRcktWa2dSN2lqd3JBTXdsV3F2MzZ1WTFBTmkxem9YbldtamZ4MUlxZHgy?=
 =?utf-8?B?OVU2Wlo1TEVlS2FUMG8yV0k3U0NNTTE2NnVwMTd2QW43Sm4wNmFXWTV4WmtC?=
 =?utf-8?B?bm51dU1kdjBweXFleXpDbjZ0TWNUYVdON01OVHEvc2NPdStlcUdLVFNvSmJ4?=
 =?utf-8?B?dnFKK3B6OW8yanRnb1pXRjhJekp0MXNBU1Vzc25jclpDVUhOME9PRFdjMGc2?=
 =?utf-8?B?MjdnL24wUVQwTGRLRkFZTUVJZGV0OTNSQlNoUTBsS092YWxaZmdXUmUxVGQ3?=
 =?utf-8?B?djRIM3k5RW8xbWlqczZCRjE0Z3ZkR2Z0S0RYdFprMGpKQmRRWTBGSXMydWcz?=
 =?utf-8?B?YldJZnJzNDZUQ0VMODE4eTVFOUg5UmpQYnhXQ3EyUm9VempTZnFFcUlQUmRO?=
 =?utf-8?B?eHhuZndNYkREeEdEZTU4cFk2Nk9JOHlVT1RTOGdNVndWMUtjTTlDcHNTNTRl?=
 =?utf-8?B?SEV3NjREU0ozOTByZUR2VGhSZTJmVE1ldmdMLzV2MkswYVpwemk3LzlDaC9z?=
 =?utf-8?B?Yit1bEozYzk1NGdCUXc1L0V2SXQ1RDlCK1pTUEI5RUFGaXNVcnR0QlQ2VFNY?=
 =?utf-8?B?M3Q2VWd4MTlSQ2oxdmJ6di9KR2pjejdWRE1yQ25BUTBEM3c9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bjg2WjUwSU03aHkxL0xvZkEyVVNiNU9sa2VBengwVlVPTXgxa3RONFQrcFpQ?=
 =?utf-8?B?aTQxejJNVUZ1SXNMOTJnLzhjc0JjN29MSWlLK0Z1MnRPaEFpZHVXSDlXelE1?=
 =?utf-8?B?Q2VHN2tQTXBYbDBTZWxad21wNVZwdVRuZTk1N3QxNXdCa0owVXNPTkVnek1K?=
 =?utf-8?B?SzFZMFFLSHgwNXZ3TG56bkxXaGhoNDJUODBHSHFPK2tjZlJudmY2aWhmdHNO?=
 =?utf-8?B?cVFXdVJQZlJQUEZmcm9YUU81VXJjbXorZHpvWGlTQWFwUkZOQWNKMHRNaUM1?=
 =?utf-8?B?RnlTdFZZSHVjWW0weHFGQmhOc1A2U01hWFhrN1g2aFl1Q2dsdm8zL3d4Rkc1?=
 =?utf-8?B?VGpCc0Vza0c2SHd2Q3J5ZGkrNjB1R2M0RUZ1ZEpaTVUwMVdXb2Zrd1p0dWNs?=
 =?utf-8?B?RDF3aSt0cEFjTkVVU3Z3WHF0bGVLZ2FPVEN6TlpOaExkUEZCd0V3OUpWM0xB?=
 =?utf-8?B?eENjRW02WUtJbnYrRXhWY0VJaEhhUkM5blE0WXEyc0xJMndBWlp3UzVqY3lv?=
 =?utf-8?B?MFBWR2ljQjBRRW8vLzlackJqYmhsaEV1bmJEUkU3TWt3TXFQM0J5ekR0UUFG?=
 =?utf-8?B?SldKbzhKZ1ZqYWZlUHhQTCtFNGZhUEJxQTZhaVdRL0FFSWpRM3ZCK0tuMzVH?=
 =?utf-8?B?QzBpTERBTi9aOE5YT1VoWHN4TVhVdXBXOHBlbHNsYlJwaTcwNVYvZFFHS3dv?=
 =?utf-8?B?amhaZUNvcDZDOWpoM09sMG5kci83V1Q3L2lHSHRNUmd3emNzeXhyZzFtVkRL?=
 =?utf-8?B?bUpPM3l6RDdjMjNZK3VDM2xPK002U0J6VWk2TlRXeHRPcHJhM3dvbjhZQkp0?=
 =?utf-8?B?RUJ0cVBuYjd3WTZtejVVVFU3dlUwa0dzZXVXNFJDRFRESDM5RTJVVTdGckUr?=
 =?utf-8?B?M0NCTnpvQTR0Y0VteDRhZmM2ZW14TDJhVytMZmc2eVlDYTMwQ1ZXSDRaT1RH?=
 =?utf-8?B?ZG52a0ZIYnU1emcvRm5POWZTT28xUGo4bnd6N1BTMUZDL3dINTIvQit1ZTU5?=
 =?utf-8?B?Vkg3L2lkL0t1M2xKV2UwQjB5cTRZNDQ5N1FGSjN1Z2tOSHhDM3NvSmxBNmVC?=
 =?utf-8?B?cjd3cS8vTnRjR2xNRjNycHpxV1pxWWlJUVk2TUdQU3ZrUWpXdjd2Q1Y5MHp0?=
 =?utf-8?B?OUFEYTR0YmFsbmxyZVJEeHYxNHpiRjRLZWN5N0JlYk9zZklWVjJHd0xiYkdr?=
 =?utf-8?B?K2p1czIycDdVbURWZUs4dDRhbkN4OEovK204VVV4dTZUeC8rWHBOZ2RvdzE4?=
 =?utf-8?B?ZVZsNHRqVVpOL2QxdHhBdURuZEdzYzBoWlF3aGI4NmhLWmpEaWFCUnBxTThS?=
 =?utf-8?B?VTNoek0xNDlXMXRSV2VNblVkNXRZYUF3SlYwZkdBemhIbXNQRjArYlBvOFdH?=
 =?utf-8?B?eGswVitNeVBKazhzOXNUQU5NRVdKV0pmMHlKK0I5NDBsMUI4SmZsb2lYMDJZ?=
 =?utf-8?B?RmJ5bWc0cDE5aTM3dk1GMGpEVWFzNjZGSE5lMk9Db0ZDZzlIaFUvMHViRFV0?=
 =?utf-8?B?aGZqaEsyT01FODZBZ0NkVG0yNTZlMlM1SkJOaXozSEdFM3Rjemg1d1BlM2pD?=
 =?utf-8?B?UjFhcnhaYnpCOWZYcURVQUZxQWZrcFM5QTJZMTZYRCtVSUJDUFVwb2pkZTdD?=
 =?utf-8?B?MTg5ZGczeFhkdUc0UnlGWFNUTmpvYjM3ZC9Rb1lGWE1YWk1CMTkwUm1FYkVI?=
 =?utf-8?B?WGphVHNuNEp2WUdMcGxucnRzYlB0NllSTzVzYkhWUHVHbldiSEJpRGFGZnY2?=
 =?utf-8?B?am1RaEJsZ2tydGVINGlQbFllL0tacXN4c3VuRlNZTHRuditsVjBrQTdyY2hX?=
 =?utf-8?B?dFNNb2RvbVpGemJkK2ZaWEhxd05kT3gyOWhkNnRBYlFXRjZOQkcwd1c5SGx6?=
 =?utf-8?B?WmVEM2pZRGN6TGNuWm9DVUduRmJwcm5FSFRwNytDY3VDUWtIRHdmZVAvMWx2?=
 =?utf-8?B?bTQ2Q0VUcWNBM2c2cUpPeEltdHRSSzIzcUR5WjdmK1Q4Z2FTOXpoV3hwcnRK?=
 =?utf-8?B?UTZXL20veGtaalYvekhFZktuYWJlbGhEWEtJQnNHMVlIRGV5QVNVSFZxbFlU?=
 =?utf-8?B?NEdCcThETjZjeGlhdnZ0VmhqT1g3YlJydDRKTjdVNTJyWlA4Y2tVdjBYT1hr?=
 =?utf-8?B?MTdXZEdjZnM3cWtib1VnblFybXV2Q2EzMVF3a1I0b2VJM2ZrSjM1YWJhWEs0?=
 =?utf-8?B?Mnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EC8EEA295BFD1943846DD07BFF37EB45@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	FhVuHLntdPZQmn2mbwjLL4ETEElImO/6FE1ng6lk/Nu304ilKkmB7P3EsbD3HhPae4lMhWeS2Z7+cd77L844gnvOHoStvWnlTHhCKElnMOBiuf7Jte1qrxMzEO0eqbzV9sNPGVtSLx+ebuZ906Mk8/c/rBCKFdztSws8ufnHE5hQQdwYqaIjYNSym2bApJe3UDu9QZ3JorPY51oWCeTj9Y2eO/3V8OuwcNeq69Ubyc72IbIHOp36dKYABnOEbyCN/TMSGTd2nbPdBHY8rPDTeyake89nXtlLv3yfeW4oG3zFYCpYW1x40Dcf3tW6otnoofOgKiUE99e5DJC81EC1QPjeu5PeQ0XmaSAVFurlg1ON3iRm3hsZ4cx7rLBk1IrIwztYB9i7JyU/fL5FZXCxk7J9iblXk23YXLtpjwtPE8taVO2O+qPI+0EO/veetWCIuRs9ifmMUu5vJJrw3Jte4UrRYudD1WDjDjP/ia8U0ecUfJ7NMOYqsOO1biRlrtx//1vIabgXYckpLdxfoFSZw7PaXyMyh+XUacPgKXUeADYNnTieeA/iz/qKEKdVhbsVWPrvoGb+cGnAWoWzgjerZ8jdLkmCXhjl7H+wcFwP6Co=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 770542c0-ee0c-4259-f334-08dcdda216a2
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2024 20:39:01.3591
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5i0Yol4C5ZMMlM8a28LhjRUSWtEs7KPGj7j2QcYuXiF7iRWgk/cxTP+fEaJV8xrDW8kyATXeYKfi48Ledn6Mfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7837
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-25_12,2024-09-25_02,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 spamscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2408220000
 definitions=main-2409250141
X-Proofpoint-ORIG-GUID: LWq111qgiQ0PK096UT_TeHIuaJ9OEZP_
X-Proofpoint-GUID: LWq111qgiQ0PK096UT_TeHIuaJ9OEZP_

DQoNCj4gT24gU2VwIDI1LCAyMDI0LCBhdCA2OjAw4oCvQU0sIEhhbnhpYW8gQ2hlbiAoRnVqaXRz
dSkgPGNoZW5oeC5mbnN0QGZ1aml0c3UuY29tPiB3cm90ZToNCj4gDQo+IA0KPiANCj4+IC0tLS0t
6YKu5Lu25Y6f5Lu2LS0tLS0NCj4+IOWPkeS7tuS6ujogbHRwIDxsdHAtYm91bmNlcytjaGVuaHgu
Zm5zdD1mdWppdHN1LmNvbUBsaXN0cy5saW51eC5pdD4g5Luj6KGoIENodWNrDQo+PiBMZXZlciBJ
SUkgdmlhIGx0cA0KPj4g5Y+R6YCB5pe26Ze0OiAyMDI05bm0OeaciDEy5pelIDIzOjUwDQo+PiDm
lLbku7bkuro6IGx0cEBsaXN0cy5saW51eC5pdA0KPj4g5Li76aKYOiBSZTogW0xUUF0gVEktUlBD
IHRlc3QgZmFpbHVyZXM7IG5ldHdvcmsgY29uZmlndXJhdGlvbiByZWxhdGVkPw0KPj4gDQo+PiAN
Cj4+IA0KPj4+IE9uIEF1ZyAyOSwgMjAyNCwgYXQgMzozNeKAr1BNLCBDaHVjayBMZXZlciBJSUkg
PGNodWNrLmxldmVyQG9yYWNsZS5jb20+DQo+PiB3cm90ZToNCj4+PiANCj4+PiBGb3IgYSB3aGls
ZSBub3cgbXkgbmlnaHRseSAicnVubHRwIC1mIG5ldC50aXJwY190ZXN0cyIgaGF2ZQ0KPj4+IHRo
cm93biBhIGJ1bmNoIG9mIGZhaWx1cmVzIGJ1dCBJIGhhdmVuJ3QgaGFkIHRpbWUgdG8gbG9vaw0K
Pj4+IGludG8gaXQgdW50aWwgbm93LiBXaXRob3V0IG1vZGlmaWNhdGlvbiwgYWJvdXQgaGFsZiBv
ZiB0aGUNCj4+PiBjbGllbnQgdGVzdCBwcm9ncmFtcyBzZWdmYXVsdC4NCj4+PiANCj4+PiBIZXJl
J3MgYSBzYW1wbGUgdGVzdCBmYWlsdXJlLiBJIGluc3RydW1lbnRlZCB0aGUNCj4+PiB0aXJwY19j
bG50X2Rlc3Ryb3kgdGVzdCBjYXNlIGFuZCB0aGUgcnBjX3Rlc3RzLnNoIHNjcmlwdCBhcw0KPj4+
IHNob3duIGJlbG93LCBidXQgSSBzdGlsbCBkb24ndCB1bmRlcnN0YW5kIHdoeSBjbG50X2NyZWF0
ZSgzdCkNCj4+PiBpcyBmYWlsaW5nLg0KPj4+IA0KPiANCj4gSGksIENodWNrDQo+IA0KPiBJIGNh
biByZXByb2R1Y2UgdGhpcyBpc3N1ZSBvbiBteSBDZW50T1MgMTAgc3RyZWFtIG1hY2hpbmUgd2l0
aCB1cHN0cmVhbSBMVFAuDQo+IGxpYnRpcnBjLTEuMy41LTAuZWwxMC54ODZfNjQNCj4gcnBjYmlu
ZC0xLjIuNy0yLmVsMTAueDg2XzY0DQo+IA0KPiBJbiBteSBsaW1pdGVkIGludmVzdGlnYXRpb24s
IGl0IGxvb2tzIGxpa2UgbGlidGlycGMgcmV0dXJucyBOVUxMDQo+IHdoZW4gTFRQIHRyeWluZyB0
byBjcmVhdGUgY2xpZW50Lg0KPiANCj4gOTM3IF9fcnBjYl9maW5kYWRkcl90aW1lZChwcm9ncmFt
LCB2ZXJzaW9uLCBuY29uZiwgaG9zdCwgY2xwcCwgdHApDQo+IC4uLg0KPiAxMDIzICAgICAgICAg
ICAgICAgICBDTE5UX0NPTlRST0woY2xpZW50LCBDTFNFVF9WRVJTLCAoY2hhciAqKSh2b2lkICop
JnZlcnMpOw0KPiAxMDI0ICAgICAgICAgICAgICAgICBjbG50X3N0ID0gQ0xOVF9DQUxMKGNsaWVu
dCwgKHJwY3Byb2NfdClSUENCUFJPQ19HRVRBRERSLA0KPiAxMDI1ICAgICAgICAgICAgICAgICAg
ICAgKHhkcnByb2NfdCkgeGRyX3JwY2IsIChjaGFyICopKHZvaWQgKikmcGFybXMsDQo+IDEwMjYg
ICAgICAgICAgICAgICAgICAgICAoeGRycHJvY190KSB4ZHJfd3JhcHN0cmluZywgKGNoYXIgKiko
dm9pZCAqKSAmdWEsICp0cCk7DQo+IA0KPiBUaGUgdWEgZ290ICIiIG9mIGxpbmUgMTAyNg0KPiAN
Cj4gMTAyNyAgICAgICAgICAgICAgICAgc3dpdGNoIChjbG50X3N0KSB7DQo+IDEwMjggICAgICAg
ICAgICAgICAgIGNhc2UgUlBDX1NVQ0NFU1M6DQo+IDEwMjkgICAgICAgICAgICAgICAgICAgICAg
ICAgaWYgKCh1YSA9PSBOVUxMKSB8fCAodWFbMF0gPT0gMCkpIHsNCj4gMTAzMCAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIC8qIGFkZHJlc3MgdW5rbm93biAqLw0KPiAxMDMxICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgcnBjX2NyZWF0ZWVyci5jZl9zdGF0ID0gUlBDX1BS
T0dOT1RSRUdJU1RFUkVEOw0KPiAxMDMyICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
Z290byBlcnJvcjsNCj4gMTAzMyAgICAgICAgICAgICAgICAgICAgICAgICB9DQo+IA0KPiBNYXkg
YmUgcnBjYnByb2NfZ2V0YWRkcl9jb20gb2YgcnBjYmluZCBicm9rZW4/DQoNClRoZSBwcm9ncmFt
IGlzIHJlZ2lzdGVyZWQgb24gb25lIG9mIHRoZSB2ZXRoIGludGVyZmFjZXMuDQpUaGUgcnBjaW5m
byB3b3JrcyB0aGVyZS4gVGhlIHRlc3QgcHJvZ3JhbSBpcyBydW5uaW5nDQpvbiBhbm90aGVyIHZl
dGgsIGFuZCBpdCBjYW4ndCBzZWUgdGhlIGZpcnN0IHZldGggYXQNCmFsbCAobm8gcm91dGUgdG8g
aG9zdCkuIFNvIHRoZSBjbG50X2NyZWF0ZSgzKSBmYWlscy4NCg0KVGhlcmUgaXMgc29tZSBraW5k
IG9mIGNvbmZpZ3VyYXRpb24gcHJvYmxlbSBvbiBteQ0KdGVzdCBzeXN0ZW0uIFdhcyB0cmF2ZWxp
bmcgbGFzdCB3ZWVrLCBidXQgSSBoYXZlIHNvbWUNCnRpbWUgdG8gbG9vayBhdCBpdCBhZ2FpbiBu
b3cuDQoNCg0KPiBIaSwgTWENCj4gDQo+IENhbiB5b3UgZml4IHRpcnBjIGNhc2VzIHRvIGxldCBM
VFAgZ2V0IHJpZCBvZiBzZWdmYXVsdD8NCg0KQWxsIHRoZSBSUEMgdGVzdCBwcm9ncmFtcyBhc3N1
bWUgdGhhdCBsaWJ0aXJwYyB3aWxsIHJldHVybg0KYSBub24tTlVMTCBjbG50LCBhbmQgc2ltcGx5
IHByb2NlZWQgdG8gY2FsbCBDTE5UX0RFU1RST1ksDQp3aGljaCBzZWdmYXVsdHMgaW4gdGhlc2Ug
ZXJyb3IgY2FzZXMuDQoNCklmIHRoZSB0ZXN0IGNvbmZpZ3VyYXRpb24gaXMgbm90IGNvcnJlY3Qs
IHRoZSBBUEkgcmV0dXJucw0KTlVMTCBhbmQgc2V0cyBjZl9zdGF0LiBJdCB3b3VsZCBiZSBoZWxw
ZnVsIHRvIGRpc3BsYXkgdGhlDQpjZl9zdGF0IGVycm9yIGluIHRob3NlIGNhc2VzLCBhbmQgc2tp
cCBDTE5UX0RFU1RST1kuDQoNCg0KLS0NCkNodWNrIExldmVyDQoNCg0K

