Return-Path: <linux-nfs+bounces-7338-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 885E59A6D58
	for <lists+linux-nfs@lfdr.de>; Mon, 21 Oct 2024 16:55:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18D0D1F212F0
	for <lists+linux-nfs@lfdr.de>; Mon, 21 Oct 2024 14:55:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F97F1E906A;
	Mon, 21 Oct 2024 14:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fA5OAVGH";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="vJGFfC1s"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71A481D517D
	for <linux-nfs@vger.kernel.org>; Mon, 21 Oct 2024 14:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729522522; cv=fail; b=X2tlHOlULw8ocNt/B0e/oTkADLES7LVdKRX7z598cmT2yAQI/yZg/pOOnRXt5Ew/RhPywZJ7/KbwBoPRoOVXDIhw8zQ+LFpyJmvZF22DxjCXDhZ/EGd6Z9aTUaiZqw7gyG51zgvObpDBLO5zkTBKMSwyIb69CG5TqUK1hevJpPc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729522522; c=relaxed/simple;
	bh=g/rocgCEYX8bgy6Fz3aUyaz60gusT0VqOcjWqEl5omk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Y/CGXy5U1z0+QHfWdRpFE2qcSMJIINeOyhMkOuY7YlFF8A+VUvJmCVRg9Sle9ituBclFWf1OOtFVTbb4NTbR1iJ2ts5uSbsqTQNg+uO1Yrmlt5gUZAYG5N/SkgvoCS21xk8Q9O6+brmQwbUgiD8f8pgw8y2UXoHCB8tQANw6fkc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=fA5OAVGH; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=vJGFfC1s; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49L96de3026528;
	Mon, 21 Oct 2024 14:52:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=g/rocgCEYX8bgy6Fz3aUyaz60gusT0VqOcjWqEl5omk=; b=
	fA5OAVGHspMUinEX9c88MMzLTfiFgdsXExkrZ59uvXUU9ZtdEsTJ64S9c0Y2MFVq
	VDuhvspYRkNP1B6b6F10Dl+JbYnGjSrqJdYH6p579RrMyvTYxEd99i5+zkqDFDV4
	Mf0u7CDWwo/0Qj/ps/aXsKA6hQAcRJvIBio5cC5AYGT3warSpndxfewsCBU/3bR/
	2pxYQdsLQ1W7Z5R9Kd3HUCIgaEvW7wLC03NHbFYDLzjiZ5qe+5ru6LaifPOSTGEc
	yS5VpLg7NZNbaR+BD78ukVatTMx13TSMInu5E53BUNNTDrWH7wAwzYzoGpR0B6AP
	5rvc+o6KKEnKs1RdNS7X2Q==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42c55eb9jp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 21 Oct 2024 14:52:45 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49LDWgLK035268;
	Mon, 21 Oct 2024 14:52:43 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2176.outbound.protection.outlook.com [104.47.55.176])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42c3776fhe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 21 Oct 2024 14:52:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aR96lzyFvPpNK/LOsiIhQhoTcT/9QmHd95hJ6MPf+11B4RtMvaZhs2bc3Uw4PDUwYZz6D8k0yG/hXa28T42sS2hUIZDjoX6/AsT4qFFEwVpVLyzuvDa9K3PymTX4YXpxc0XTXUVKJqIWasX5DjZP3nOwOR9aR+65nRMN+SrDa/w96r4g+TIrlAI6tz0PCtYvGch2eJsCrNpGGhSzCsSk/lOh5yzrJzujQRdh6DkiR066yLJW9jjhLyC3XBOQEtmh5KXvREDckwCBRkUS/u0TTIB5Ypgvl+CxjHNwEp5trFZGrVejW+3FL6zQenpBTPKSUo02GneSqjdfIW4oKD0R0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g/rocgCEYX8bgy6Fz3aUyaz60gusT0VqOcjWqEl5omk=;
 b=S/2RQgISTGC3/qNCe9X3AuAyc5DRCzex5O3KaZWZQipkIP4Cb4zazU7Hl7NNCYHnndvXC3QG42fe0mKPuBEIV8oFmWTJZbEDBcUoRp1yesONKCSyVL+Vkoz/G5rDuFdJtiFnVb60mJQeHhnBr7WfynWByGLrCwoHhQTXYO8ctCQDTVvYbUg4LKx3Lfj9smaEhYvoDRZ2ffO1qwoT6t45051Aver4jqeTbpEM1Zjw5KhPQRMu7kK+kn6YaGgljZw7Lj+THHDZqjdW8q3wQCopFLeXK1dFZ/F05zv6uwsdd7euTet7ExnK0ZMaXw5X7Iik6qAwSs6iWs+rFM4bYrRetQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g/rocgCEYX8bgy6Fz3aUyaz60gusT0VqOcjWqEl5omk=;
 b=vJGFfC1sMZl/VYRxu0B99QoMRGWmYQp2jXH7d7IuChxLbis3rXw17g1tr7b0IxqskVH+dSD6EwiltDn2gLYdQKwP+PLyUFSUzbGQuvk684PeTaTH07tYpEwDarYSXrhZqwJLWzbVzDjrEnD1M2wDIC2ttzYgTVcQvB5pUheFEaM=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SN4PR10MB5557.namprd10.prod.outlook.com (2603:10b6:806:200::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.17; Mon, 21 Oct
 2024 14:52:40 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.8069.027; Mon, 21 Oct 2024
 14:52:40 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Yang Erkun <yangerkun@huaweicloud.com>
CC: Neil Brown <neilb@suse.de>, Jeff Layton <jlayton@kernel.org>,
        Olga
 Kornievskaia <okorniev@redhat.com>, Dai Ngo <dai.ngo@oracle.com>,
        Tom Talpey
	<tom@talpey.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        yangerkun <yangerkun@huawei.com>,
        "yi.zhang@huawei.com" <yi.zhang@huawei.com>
Subject: Re: [PATCH 0/3] bugfix for c_show/e_show
Thread-Topic: [PATCH 0/3] bugfix for c_show/e_show
Thread-Index: AQHbI8U7BQmBhkM0yUW7X7/5mCxrV7KRR2SAgAACxIA=
Date: Mon, 21 Oct 2024 14:52:40 +0000
Message-ID: <82E154A7-8DB0-43DF-8574-09878BE9608D@oracle.com>
References: <20241021142343.3857891-1-yangerkun@huaweicloud.com>
 <20ab72b19ff1a63e948c6379cefce900fc02ee1d.camel@kernel.org>
In-Reply-To: <20ab72b19ff1a63e948c6379cefce900fc02ee1d.camel@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3776.700.51)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|SN4PR10MB5557:EE_
x-ms-office365-filtering-correlation-id: c4eb5967-eefd-4f58-f09a-08dcf1e002f6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?VDNvc1FiVWx1ZUVpdWJiUzB5MGRsUzEvTVYzMGFZVUVhK0E5TE5EQitvY29M?=
 =?utf-8?B?UWVlNGxPZGxqU0E4bWVPdFdwT1p4TktmcE1TaG9MdHR3aVc3SEc2M3FLS2NM?=
 =?utf-8?B?Wm1MU0FNNHFXOUx2elM4UzJ2UXFZUm92S0xvSXFNNW1rNFZGakc5SHB2c25R?=
 =?utf-8?B?cmpRVnQ5a09qdnpTV1BZNlR4THRGaE1ZNTFyL1VnUnF0T0pZL2hUODZpM3ZY?=
 =?utf-8?B?MnRXQXhQazlVOUc2L2l3engydFJRZHNRbU5zRjRrYVhZV2xieFdCTkxVc2Rj?=
 =?utf-8?B?Vnhrb2Y4Yys3WTA2eFpwQ2Rrd1p5amxSUmppa21KUnJabjBoZUgrZmh3N3B3?=
 =?utf-8?B?VU0wZWkwK3AwZDY0Y2crQXF3S3hBdWdJTGhjNW5SUUM1cHd5ZDdWMXBhZlNy?=
 =?utf-8?B?REYyNEZhV3p1dUxWSGhFWEdnemlvNTBMTGhyU3p0dTA3Z01VdlFHQVc4TVNF?=
 =?utf-8?B?UTdvcFlrbEJOb0o4bDdIZjltdTBkaGdjSGMyUUhFRXJXZ3E2eUtSZVhGd0xP?=
 =?utf-8?B?Y2czTU1sOVhKNXY4ejEzRWZuL09qbVpGTSsxNmEydkIzL3VNWE5pWUs2QnhB?=
 =?utf-8?B?bytFMXNtQ0ZndXRFN0dTUVdKSmFoWXNEa004OElnZlAvT1dLV05GME12NitT?=
 =?utf-8?B?TmVWVFpRNnNNMmhIR0U0VHhKVmRqWlJmTHdDYkhqOWVjZ2U2TTNPd25GeStu?=
 =?utf-8?B?eFIzUlpIUzJPL3U5aGg5MlUwYUIvaE5GWHBJSFBETEFxb0k2RlFkazVYbm52?=
 =?utf-8?B?RGVUTFdIcUJhNHgvWWVRaTFYbnMrYXhvWk5WUXJZVm5uK1ladmdpcWVEekJM?=
 =?utf-8?B?RlZtY2o1ZU5aYnpHaVRYQWZhUVlEdklKSUk3SWR5K21xeUNLaDBGYXh1eTZU?=
 =?utf-8?B?VWFPWldWcWlpWEx5YVc2SHpKVU83dVVZdTI0ZUcyMVF1YUlsM0NuMkY4bEto?=
 =?utf-8?B?SGFhMkQ3SG95bWZVdHZGZWtEVVQvelRMTlN4aWxYbUlTczUrY3QxYzV6TXV5?=
 =?utf-8?B?MTRsZUFxU0FpRFBVdVM5OXJkTnAxaUxLR1lRUHNTTzBIVmpUclVzekxtN012?=
 =?utf-8?B?d3lnQlkyMmxISUJ4MEtIcEdJdWNBTmJ5Z3lyenBXWllBRVo5ZVZoenNWTmpu?=
 =?utf-8?B?b0pWVEVmRXpvWEFCTVZPaUxTRDNMdmg0bXFzZmhKczg0MlNMUEFUemJsUlA1?=
 =?utf-8?B?dnNDNXk3Vi84eWdydUE0cEF4azhxOTBnRVhHSFM0cVJtVU8rdXMrL3lZenRi?=
 =?utf-8?B?dUV6TFRBQ1RQUkdSY0JXWU9Rek9JblROdUROMFFUY3lrZUIvRnl1NlpmQW0w?=
 =?utf-8?B?L29QekxMQWhJWGthN3prYVV0ZnRrcWFyb2h1ckluSXh3QzJUUldHUDNrb3Zo?=
 =?utf-8?B?NmJuMStMWDU3ZmZ6b3dIQXBmeWZuSkFVcjZJQzVVd0Y5a3gwNEJDQ0NqbDdQ?=
 =?utf-8?B?cFNPNjJPaEEzV1VqREMwV3E5UDYzQ2VFMVhlVHp3MHRZb0U0S2p1VFhMZnhX?=
 =?utf-8?B?QjNhWmZlYmYwTUlON0Zvd2w2L2hSeWhBTVZJb3JtLy9pMU9KL3JZS3I1Wksr?=
 =?utf-8?B?ZTI0a1FLbW5qd1hIVm9VREdORE9MbHhiTFJSM050a0FaT1k0YkNvZk9jUUpV?=
 =?utf-8?B?eVFNZUhDUlkwQ2lsOW1tZ1RpZEppQUJlZnVKZkZVWmI5NmdZSU9FSGNPd21a?=
 =?utf-8?B?Q2dzaS93dmluMGxiOXduTS90SWR2MzhrOE0zelNrQ2duMTk5MEtHZEg1d0Q1?=
 =?utf-8?B?TSszdlVJOXM2OFRPaEJGVDA1OVFUOGJDN0hUVWUySGRRSUJ2UG41UjZjNjdu?=
 =?utf-8?Q?XUbgYR24+2ve7poPMdQiKVhxNK+J6C8ROZytw=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?N3I3a3RHWVBuWiszTGNrS1JFUVZING5aRksyN3JwblJ6SXNlRDB4YisvbUlK?=
 =?utf-8?B?dkRMYmxrQzkwZ3BMQjBQZ3BzdDNhekNSRjEzSXN5dUx1T3NKeU9sZnVJcDVJ?=
 =?utf-8?B?dHgzbFBLbTNGZXB0Z3k4ajVJK2x1TFdqVitmaTJqTnFsS3VyZ3ZyZ1A5SjBr?=
 =?utf-8?B?ZExwL0xNazFXeWZVTTlwWERNaDAySEFpdzF1YVpnTHNWRkRhMlFHcnNSS3RP?=
 =?utf-8?B?M0ZXb09KSXl0ZzkyUE03OUhLZXlpWnppMmc2alU5MlcvWFJuVk1IWjFHY3BZ?=
 =?utf-8?B?aGFGTFJOZlRadG1lRys5SmNBNzhQMkVCeUl5QnZsMGtFM1dxdmg0d1dTWnB3?=
 =?utf-8?B?YlpId1hJZUovQ0R6S2t3bTJIa0dRNjdjcCtlcVRyRDFEdkxiVEd1VGdtNm91?=
 =?utf-8?B?azV6R3B2S2pYbDNsMDJQT2REb285aEs2dVBENDczb1orTmhOMkpyaEhmMzRX?=
 =?utf-8?B?S0V0VVlLZWZVbzc2RG81N2x0Mnc5ZkxLSlJaWHJRQkt6YWNaQnAxTXFuUXBG?=
 =?utf-8?B?bUdQS0FoMmtSNHBqbnQzSW9OMCs2S1BBTFlNd1NpUWt6cVJwdmxvUUtlb000?=
 =?utf-8?B?RW9hcW1wdjF4M04vZDUrclVyRUZKOFFCWUlvT0EwZnZmMmUyR05zcjR3WS94?=
 =?utf-8?B?amNSbkgrU3ZERDR3cUF4UWRCTm1TZXRsZTFlTXF5TzJXaGV2aHFRODg2cGJT?=
 =?utf-8?B?UmF4YlBVZW9ZVXhnRTRkZ01uZ1JaVVl1U3FKMkRXVDc0aENTQUNkOElvZzlr?=
 =?utf-8?B?OC9DM3ppSmphMUdnYUUrNnY1dTBGdldOaGN2eldyZzNLSDE4QlZlY05peTRP?=
 =?utf-8?B?OHYwTThuVDJMc0cxWFJBUG9uMXp0eXAvRjJVNXlESlhXRi90OHNTWDhrb21J?=
 =?utf-8?B?NzY3L3A2dFpzTTNPclRFV0ZzVm9JZjJFc3FsbVBiTmRSVlFBWklncm9RcjFN?=
 =?utf-8?B?ZU9JNXFEa0h5MDBrNEZuZXJGejQzWHZWNHJFUVJoN2RJSitJY0NWYkJwQ2NQ?=
 =?utf-8?B?QXBsdkFIQnZUVFV0ZU5rRmpSNDU2TTJSaUhKSm5FanRZL0JHWG1LaEs2RXNX?=
 =?utf-8?B?eFhXOUk1MVp1RHEzaUFvazN2T2l3Z1crNjVYajFmZTQ2TUdBZUY5dGZXRzlT?=
 =?utf-8?B?dHJPc2Rwc1JFanpUN1JWN1FsU1dJalI0UU0zdGxPTTlYK01leHArYlhLcUZu?=
 =?utf-8?B?eVdpdmlkdk5tSFNjbHFhazBvczRkRUlpMytUdjh6TGg2MjdKMHJWVWpGUW05?=
 =?utf-8?B?am5QSEJPOVFJemoyNUJKNkNBMnFNSm5WejVGUzI3QnJYWDVpV3I1Sy9CNjEx?=
 =?utf-8?B?aXUzVnlwSDNWeUxSM3ptMmErSERZZ09IYUlmbUpvWVdpdWdDS1Ywdyt0N3Fq?=
 =?utf-8?B?YnhMWE5nWVA2K1ZXTklCQlRLM0VWTUlxSFdiTjRKV25GSnhVZVlTWjJkc1Q3?=
 =?utf-8?B?Y1k1WmZpZUVicTlLNHU0UUVBb1J0RHdaZ1JTSDZpeUprRUFzdGpzSXV0aVlS?=
 =?utf-8?B?NjVBZVFzYkpnTmpQbW5ha25lQWw0QnVmN25UL3JPV2NhWlZCbE5MYUdtQk9C?=
 =?utf-8?B?MEJZelZKVmUwVGVqRTdsd0s5WEVYYU04Nmo4SlNzbkVENlNyd2s0NGVhSmlD?=
 =?utf-8?B?QUdNSHIycWJreG5rbDNjeXQvMlVlK0xjM2RUUGs2MzJOL1NzZWNreDlPZ2xE?=
 =?utf-8?B?ZXdlbStaYXRKR1p4aTM1SGVNQ2pjNVYxckxsUzdwYVFBdndtNU9Db2w4VjVr?=
 =?utf-8?B?L1lWTG9xZnVNRTliZGluSjBSL3NKNmtpeXk3bU9DVisrenQwTFduR05sdWlQ?=
 =?utf-8?B?NEQwTzA5RFdodzR4RlhkQmxLbnhaWE92dU1tMTBhQ2YvM1hBZXZ5dXhIR09P?=
 =?utf-8?B?aHBqNHM5eGpSdmF2TDRUUk02NmdxZVhETzJGaUlmVU5LSUlwcnEyTFdsZUlL?=
 =?utf-8?B?SXdvYjBXVlpkV2pFZFBWSzh5eVpjOWZVb3JYYnNGZmY1eEpOaFpWZDNXNHVw?=
 =?utf-8?B?V0U5d2ZjZHF2d3NKak9zZUNkL3dnNEVkZzFZSDhoSnU2S3IyMzVkZWd1NTFk?=
 =?utf-8?B?TkQ3MitzMlBvQ1BkN2twdXkxUFhoZy9BYmUxTHhPMzd2NURjK2hybFIzNlhW?=
 =?utf-8?B?SjVHSmo5Nys2bXREc29FNE1LMVo1dVN0RGFqcHA2TXdRZk9xdE9oUW45T2Yv?=
 =?utf-8?B?bXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <092DB6EDFE59AA499C75346DBF811C04@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	LYwirCs5XTv7zCYbjZ8CXv7Z23zjgQI8XLV8uEJlQ8hu7EU8oY9tDIOw8ubYVIXmZmK+g7lj0fHDguwK3WYN3rOOa8+p9tzlTbYr99Vh6DQDnuvZ+hzwoMaIkDxypHn1Yl6T+wd7AFZpaGeJammqG5abY6JZcG80qU/s/ZX4FCyUhgKekE8HjNLSxdZa/4E9pDS58OvRvz12LWPpgrJdFHz1C0CQKswlFJ/5paPlFSZHsEtQYA15i877lJeMHYukNUvebGOs52R62oUPxGzcy453+otJT5HBWr9ckAtroyWPqr11nsypc+ft0LxtyxILf865gyystdQ3Bcphc0pR+R7QrGV6VYv2F3wZBj5dZFlS+khGsGVxYMraV3DHFYCq8Jsv4qYQ0r0BimU213mm9979IhHV83X5w6PvT+hm0ija9Hjd/4tw1HvD+e8xYKZ5K/F1eZ7KHpKW5Kmg/2MpkCdO/wis/PLPG82LHLFEgR80ni52fHQ7GsOO6uh+APS9RjUrdBoV0ZwwOQpzjddwfxJokOMOh7myuNHD3ySUeeYE38mnzzxafKto6v9TfX7cGHswbLI3SSdaC7vpkW0YTNnea93dvfhrCDHf2U8cJRQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4eb5967-eefd-4f58-f09a-08dcf1e002f6
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Oct 2024 14:52:40.4064
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QD4UosXqowPmZhAfl3DXyoUXVyuYp+qZuXTHLa5oK3GWcuEVVzPIQKBAXUWMJrk/1MW5489Vc++KW4JTsa7eKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR10MB5557
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-21_12,2024-10-21_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 adultscore=0
 mlxscore=0 spamscore=0 mlxlogscore=868 suspectscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410210106
X-Proofpoint-ORIG-GUID: azcVHfDtI72pjvVJfZm2sE8i2POSh3M2
X-Proofpoint-GUID: azcVHfDtI72pjvVJfZm2sE8i2POSh3M2

DQoNCj4gT24gT2N0IDIxLCAyMDI0LCBhdCAxMDo0MuKAr0FNLCBKZWZmIExheXRvbiA8amxheXRv
bkBrZXJuZWwub3JnPiB3cm90ZToNCj4gDQo+IE9uZSB0aGluZyB0aG91Z2guIFdlIGhhZCB2ZXJ5
IGxpdHRsZSBSQ1UgaW4gbmZzZCBpbiAyMDEyLCBzbyB0aGVzZQ0KPiBwcm9ibGVtcyBsaWtlbHkg
Z290IGludHJvZHVjZWQgbXVjaCBsYXRlciB0aGFuIDIuNi4xMi4gY2FjaGVfZ2V0X3JjdSgpDQo+
IGdvdCBhZGRlZCBpbiAyMDE4LCBmb3IgaW5zdGFuY2UuIFdlIG1heSB3YW50IGEgbW9yZSByZWFz
b25hYmxlIEZpeGVzOg0KPiB0YWcuDQoNCkluIGNhc2VzIHdoZXJlIHdlIGRvbid0IGhhdmUgYSBz
cGVjaWZpYyBjb21taXQgSUQsIHlvdQ0KY2FuIHVzZSBDYzogc3RhYmxlQHZnZXIua2VybmVsLm9y
ZyA8bWFpbHRvOnN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+IHdpdGhvdXQgYSBGaXhlczogdGFnLg0K
DQpCdXQsIEkgYWdyZWUgd2l0aCBKZWZmOyBsZXQncyBkbyBhIGxpdHRsZSByZXNlYXJjaCBmaXJz
dA0KdG8gc2VlIGlmIHdlIGNhbiBpZGVudGlmeSBhIGN1bHByaXQgY29tbWl0LCBqdXN0IGZvciBk
dWUNCmRpbGlnZW5jZS4NCg0KDQotLQ0KQ2h1Y2sgTGV2ZXINCg0KDQo=

