Return-Path: <linux-nfs+bounces-8303-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D58289E0810
	for <lists+linux-nfs@lfdr.de>; Mon,  2 Dec 2024 17:11:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 952C1285459
	for <lists+linux-nfs@lfdr.de>; Mon,  2 Dec 2024 16:11:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7005C17084F;
	Mon,  2 Dec 2024 16:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="A+ECG1ew";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="nlT1vRsA"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D24116DC28
	for <linux-nfs@vger.kernel.org>; Mon,  2 Dec 2024 16:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733155899; cv=fail; b=WGg4C49W2+63I99A9DQmJN/AV8ga7xJ1i9yK3jZEBGny1qulbfO+UN7U+kKTLZXv/FlJ7KSNUqJ6Z/aCqIyJqIaV/fSvlxOorqZ5imkCmhvzrLOqmjf1iAUMXHArBJsCRrEweIR7/7N8/OE36+YEjqeXKDopjNSn5D+B/A9hMeg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733155899; c=relaxed/simple;
	bh=x02C5iSlmK1QfYisIwnYNCVtQf1zMNWgqV2ri9Ba9Xo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=AUsP0p7nUrIdE9pcsqpD0dGNu5f4AzlEZh2GokIiKJtB6UxWld1MMWoESde0PWwuWucrCCdXzMJn9s+CfsZ7kG2cOzKgEWXgPe9TBnaNaifzeomWns3ms793A4ut3dy9BcH5bIw35MXH4VN5KL2QlO39rrWDl9Twts+Bu4wkQ4c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=A+ECG1ew; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=nlT1vRsA; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B2FTBQY015030;
	Mon, 2 Dec 2024 16:11:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=x02C5iSlmK1QfYisIwnYNCVtQf1zMNWgqV2ri9Ba9Xo=; b=
	A+ECG1ewIgZVSXF3XaBWPtsKijq56ghvbeFGSj4H1dk+juRWFtUQNJALPMlmNZQ5
	mtUdpS4wp1PzGrRa8BV8qU6L6hOTmC5W4QLjbTYr00heRS5+MzVq9rvvC1Sk+MuG
	JzYKp9vAfcWuREOJfHIXfHUK7xdMk8IIuSq8rvzSuyL3fWgjpTuuwZuLmhYn+dsu
	qU9cNHsgZMUBAVMwbp8gtCJjz6wph16X1f52/anzm7mUGNgGsrjgYWnvvl1pdm0n
	0fAUhHQuhaW3CShxcYs/rj+zmeDrwGJjImTT1AxU8X+Zx58muAFTYZZaPQY3P/kV
	1XTZXU/Rlsnn7qK2XsgSOQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 437smabsxq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 02 Dec 2024 16:11:26 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4B2FUvWV031481;
	Mon, 2 Dec 2024 16:11:26 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2049.outbound.protection.outlook.com [104.47.58.49])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 43836sq41j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 02 Dec 2024 16:11:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GKM8xZxKxi1OaZcF/dKw/uICN+3bw6DDDag12BkXroA4Qsj0JvtvGM0cHOWWHmrSSfacGdjyl9Pbn+2zPZsDZXtyanM9wOjHXN6jPH91vEE0d/YV+nyw85UdoYf1207wRNkGgy25scJWIiF7owkTfadRCGaWzFVMQc2RHAbWBtHcdVPKwwy2hGSsc1EX7ndzvs2LJXIOPUmrxpm40ZrHKvCew3LL8nGd+2RH3nLJZSxOhe908ckEzCNhOleT+dtMeKQOkPeeTAwXwiiOjowSdk6BzkWrIyfd/ujuVFABJfx1M83aPJHgWiXMClq5G7aQQ1wjYEX7cRdinjTmglTt+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x02C5iSlmK1QfYisIwnYNCVtQf1zMNWgqV2ri9Ba9Xo=;
 b=FjJAHXV0T1H8JgIZzpwdsUPD4aSo49gZYpmtSMFlylf/+xXGN9woy4wnmXx3vpMvsfJ2L0cQCqi95RW2soY2KdFZ91Aeb1OP+Nb0d8nd3yTjMMnkZLNObpNpYnHIjng6EjQuXSKD5Y287pkrgWllY1eKaZ4PecDhRaTaIiaPisEzJIqRsMMqZ6WWTabZtGb2KNTgDRs3kBxeLdMUOYVdUl8kkk6W5rxnpuLrdnHa+0lVOwsmYPtK7uV/KAkXY93iF9aqkJ6ux1jTJAS3MxxwYqX/KFLU/8aV9cWJQc+tIfOGw6IAiUziSDsjW73gmvecY3w45xliSbAIAeaQABwPDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x02C5iSlmK1QfYisIwnYNCVtQf1zMNWgqV2ri9Ba9Xo=;
 b=nlT1vRsANKbVshP0un7yuDw/Aq3givdn95xBrxwD9C0gmGV0vHEvqoulJSlaBeaZTIveX4fv/O31aUFLo36npCI7gG8CfLiB4H4Tt5BbqaXeD6PJGTqfTVE3/mRm1jGi6OUKXhLg1nKn/ZG5QjSsyHbWYwYBX/zA9LpwXlxUdSo=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CY8PR10MB6826.namprd10.prod.outlook.com (2603:10b6:930:9d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Mon, 2 Dec
 2024 16:11:20 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%7]) with mapi id 15.20.8207.017; Mon, 2 Dec 2024
 16:11:20 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Neil Brown <neilb@suse.de>
CC: Jeff Layton <jlayton@kernel.org>,
        Linux NFS Mailing List
	<linux-nfs@vger.kernel.org>,
        Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo
	<dai.ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>
Subject: Re: [PATCH 5/6] nfsd: add support for freeing unused session-DRC
 slots
Thread-Topic: [PATCH 5/6] nfsd: add support for freeing unused session-DRC
 slots
Thread-Index:
 AQHbOh0Frj5X9m/dQEyMrQOHJ7SFQrK+/WyAgAA04wCAADAjAIAC50SAgAALpYCAEOAEAA==
Date: Mon, 2 Dec 2024 16:11:20 +0000
Message-ID: <14EF5A9B-0511-42FE-8E3C-32CDC8133A99@oracle.com>
References: <Zz069lQT2WOgR4EC@tissot.1015granger.net>
 <173222565373.1734440.11186656662331269538@noble.neil.brown.name>
 <FDB4D98A-FBCB-4863-BB0E-1EEB2CB50159@oracle.com>
In-Reply-To: <FDB4D98A-FBCB-4863-BB0E-1EEB2CB50159@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3776.700.51.11.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|CY8PR10MB6826:EE_
x-ms-office365-filtering-correlation-id: 060ce1a2-1980-4aa6-f10c-08dd12ebf5d6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?SEhzZlo4bi9jNUlmRkM2NTYyaEY1WVVJTnRwbGR6M0I2YmZRWGE2TUQva2wx?=
 =?utf-8?B?V21WWXNLYmVVczA5WXZDWWJNZzZkMmw5Z0tvSzZQSTBiTVI4MGFhbzIwbm4x?=
 =?utf-8?B?MjlGZXJMQVFRTUdQam1yOTYxdVBCbkIyRmdVQnhjSktiRGczVEFpVFNaMElx?=
 =?utf-8?B?WHZ0N1NLWVYyNTJleGhsRmdlVkhnTGNJd3Jpck4xVVFSaDlOOVZ0OVVhOWdL?=
 =?utf-8?B?Z3NjRmhkT0NWUlIwSXNxLzJxenh2NTEvc3JFQThPOXNkZUw2VTdiVTJEL1g5?=
 =?utf-8?B?bnR6MzV0bkxjL1dSVjJKdWErOWthUmxaZEFVcHFKdmhkOUU2eFVqaVFnOGQ5?=
 =?utf-8?B?SFRBejVUajJHV3ExVFhQU0dyWVFMYlphclR6Z3k3OHpLMHBNeUFsVkd2bEtx?=
 =?utf-8?B?d1RaQlA1Qml3a2ExMHE1WkVCTWFRU253OE8yMjdZWncyWU9iS2FGZ1MwMVJB?=
 =?utf-8?B?YjdFQmNsRFFwb0s1anoxRDJlSnl1MXlxNmNwdDJpakVpVDBlNTI4VTRTa2Y4?=
 =?utf-8?B?Yzl1SGFaOHlvR0c1WnZSbXUzWHIxTmo1YU1Oekt2SHJsdkdLWFNERm9TaTFN?=
 =?utf-8?B?R0IwMUdPUkxtZ0RQU3NCTWZnUUVrV09hcDFxcXovQTlPVlEvbEVzNi9pT2ZM?=
 =?utf-8?B?ZG85Z2FubGVKMFdmTW5zb3NLYis1QXFzdllGaTJTNGdWNytPeG9BTFRObG15?=
 =?utf-8?B?TDNzcmVRcDUzZjAvVUxEN0dIVmlmY2g3bGdpUWY2cDNPa2Q5cTRDd0w5L2xX?=
 =?utf-8?B?VWNHY0gwWTA2MGV1b21ocm9HTWY5V1k0SXQ1NTJFYXpHUk9JQUYxZ1NrdzRm?=
 =?utf-8?B?ZnR5c2FSdjNTN2RsandJYSsvWFd2UVdsbWVkY3hEVldmZ3RKcHVOQWRzT0FE?=
 =?utf-8?B?TWtlYTRiZWJUNVJqSTdEU0FoZjVhWitrME8yeGkvRWRhWFc3NUpkQXgxcklo?=
 =?utf-8?B?K1drbVZXS2VOOTZWL0dudVN2alNDZ0JaRXFGdDQyUkZxMW9MVjU2M0lObjBL?=
 =?utf-8?B?bUFmSVVDaSs4UGVNMjQ1Mi9qZTdqRjBTNTRRbVRSVVNFWnRJOThselljYitT?=
 =?utf-8?B?Vi9xY3BQa2ZCNXpiNDZ2TEE3aG1laFFzOWpsbFlBSGcvUDZaelljbXdYZ2xq?=
 =?utf-8?B?WnU5MkFqNFJlVk5pc01aWWlkQUZaRjhFSEJpUEkxNms3S28wMTNBUUFzREN1?=
 =?utf-8?B?d29wMG1NcWxQRHV6MTNpbWhXaHV4VDRVc0dwWEdJdWF5L2doTDAwemFpQXdu?=
 =?utf-8?B?N2pqWWg0T1pBdHBITEFaT3JNNEtoa3JvZ05acEtJdXZ3NjVtZE5sNXFYeFhh?=
 =?utf-8?B?RDZWb0JVZVRRclFWUzlKMUZ2MDRXdGRFTlVFbnFjNldseXdKMERsOHd0ZlpU?=
 =?utf-8?B?NTNVbkNpbmZ1YkpZc1pzNTlOTG85SnNTQm1tY2Jnb2NyZUFEaFZLQ1l0a0RE?=
 =?utf-8?B?S2pLRmh3UGJUQy9hdXFDM002S1RTYVlxOGIzVndOUHUvenFOeHREank5d3gv?=
 =?utf-8?B?dDVzRHhvNUlSdDZOY1JhTXc1TFNLVkJMK2NUcmpqcVBLWXcwa09nay9NM0pB?=
 =?utf-8?B?ZkNkR01EUG5sdTU1Y2g3Z2F5emZjSDgvZEcwZjdjZXAvMVFQVVlIV2VlaU5a?=
 =?utf-8?B?MUdydjRLSTV6ZVBYcVR3eEJ0YW90ejVOMUVGQXIyc25oNHpPbWdSeXM3ZGRE?=
 =?utf-8?B?Ky9vMUtQdW1ydU5ScE82TUJjbEMwb0tVRFp6VWN3d3ZrbklBZFhod09uamNz?=
 =?utf-8?B?QlVBL0ZkSjU5VzVaS3YvcVhDb2ltU1Q3N0dZM1J3R3Y0aTUxWU1CS2YrNUJ3?=
 =?utf-8?B?eWFCdXlpOTlVNjl1RkN5SHFKdUVTWkZlWFZVSU5aUVc1S1JwNGd3aVhXNjJL?=
 =?utf-8?B?alpKdlc4Uk9uQ1BCVDVkM01lb0xHbG5aSGY0bzNVMGdvYkE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TVo5WFJDKzdUS2dLcndmZEhpU2JsRmVuYTcwcmN0cDBCVGIrb1VjczVObkU4?=
 =?utf-8?B?Q01wK0pWa3VRY0J0WWdoTWRsdjY1bW9YWUZSQkdrbGVmYWZBOVplZGI5UnJF?=
 =?utf-8?B?YjFPWG9ZSlNBRUtiblM3ZS8rMEpscXZPdkVDQUtkQlJWQVp3R3h0M3dJajlz?=
 =?utf-8?B?dmVhSzJtOEd2MnhDZWhpOFVDTSttR24yRXRjKzdXY0ZnUXBhbDlBTE5na0NL?=
 =?utf-8?B?RlFjcEcreTZiUVJwK3BwMytLYklVUFViNmRhblFhYkRSOWRoRndkYzJtQ0Fl?=
 =?utf-8?B?L21xL1J5WC80MEplUjd0cjJYN0w0L3lEaUFTcXZET1JYWTYwTzVNWUNjblhz?=
 =?utf-8?B?aEYvN1kwbWVaUHNVSTRRVTR1WGlYbzZvRUJpQzkwa1M3aThVelhQdzRSN2VW?=
 =?utf-8?B?NGd6WktkMkN5clk5ejdNdnRqYWZqVGFKMXBUWGtmYUd0NUczWTlQQWJzRTZQ?=
 =?utf-8?B?NW9aSytuY2Y0MjYrL1hEbjFtbXBFT2RwcktHQVUyRVNaSUMza0xtTUlDMWNO?=
 =?utf-8?B?Z1R4ZXJ1OXhKVmJZUmlvT2N4R3lvMXVhV0I4TUdHa24zNjVwdnByUzl4Ulg5?=
 =?utf-8?B?Ym9RK1ZLMDdiT2NFN0JlRW53a2dkcmdDR3VMbVpJNXZBMnpsME1xQ2tOTURF?=
 =?utf-8?B?K0R6a3MwdHZmMmErd1BlWkdZVnVJTDVtODBOTmRsNWhPalJYbzY0Z25lUzRV?=
 =?utf-8?B?cmVvcWRCRUJnZ0FFQ0tWRWsxQjZ0S0drZDlOVVpvbEtsdklxSU1CSmxxVytt?=
 =?utf-8?B?eVJiSXRSOVczbGd3alBoTmNwUVIxNHN6UkhPQ1NTQUNvdHlXSjdPNWxRSDlJ?=
 =?utf-8?B?TWh3V2svWllRVnNvVVp0enBYbkZyRjBJMjZ4citiRzJlb2liN2ZvRHhkakxC?=
 =?utf-8?B?U3YwNkE2d2Z4NFhYY1R4a05KdUlmUjNESWxjSzJIRkhVOFJFalQ2cUlSVDB4?=
 =?utf-8?B?UDVtdzFCMkt0alZ1bXR0cmtHU1BPelZFV3czOGVEemg4MmVYSkY4RG9HK28z?=
 =?utf-8?B?V2dJSDJIZFRYNmxaM1VWTXZ6MUtWZjAvQXpGYmQ1amxFMCtvWVRZVjNOMm5O?=
 =?utf-8?B?UUdMNjFKMU0rbW50bU5RNUhkd3dFeHJOYmhJZnJZU3lTVXFya3JZdXZrUFlI?=
 =?utf-8?B?bFRzdFV5c3VaOXltVWF3TzA2ekN1eHZNUVBKa2YzVC93L0QyY0VVVi9teEhQ?=
 =?utf-8?B?SU9hcmE2UXN4bTk3NklUdERrMkFpSDRleWU0dGJ4Z0hGejFFZFhBR0lMMXRS?=
 =?utf-8?B?dWtDT2JPK0ZwWDNxcHNvYkx4ZVgxdWUvS2h5b3E5WUlwdTlVUS9GNkhoRTlz?=
 =?utf-8?B?SzVUOUR4NjBidEZvUEJTY2JDc3BIU2VKRlhvRmpGeDVzR0o3NjJOQktlVHdJ?=
 =?utf-8?B?VFB4RmhrK1krSzY3QnFiaE04L1ZMd1JDY0twVkh1M2VsVWdSTnZUSzl3OG42?=
 =?utf-8?B?YTVJWGg4VjJUeVZrdUI3dnh1OHFIQzBkVEtDUUFLZ01qbGFDcXNwZnZSMGdk?=
 =?utf-8?B?bit4eFFqU2dDVkpIYTREeks4WUp6U1lLejdYSGlkODJLSENmUzdqVklyMVQ4?=
 =?utf-8?B?dWNLWXlxMlp4ZGp4a3NyUVl1b2htR0lvTFVkTHUwRG1uK3I3T1EvZW1MdVRu?=
 =?utf-8?B?UDMwc2lHbjM3eFkrbnJwQ01lRzZjSUNxZHFnWnpUbTlqYXlLMUJyZjZVbUFq?=
 =?utf-8?B?THhuRy9NQ1R5aElYWDJjbXFFbnoveFFoMlM1OXVHZ1BMRkcvTUNmOElVS1FH?=
 =?utf-8?B?R1NtL004aFFKaFNWSWozaXNGTnBUZXMyTnhQcFRWbW5UNUcvcko3ZHBpTHVV?=
 =?utf-8?B?enphWmtscE9xOUV4VkZ2Vmp3UVFJTC96bmpURllnNkJhcGFTcnNXbXJ2cno1?=
 =?utf-8?B?cFFIZ3VaSGxSSW1IYkhvYVQxVFM1d0g4c1N1UWp6MW85bkVrWlJ4TG04U0ZL?=
 =?utf-8?B?cTNDVTZoaU9ZTkh1VEJtTVh2Y3ZkS1htTXBzVmRsN2JTdGNhVHh2M1BZckVz?=
 =?utf-8?B?K2JacHJZaWdwSU1ldzBHZGdhNTN2bFBmcW9pY1VrcUFYWllBekpMQjBmZENW?=
 =?utf-8?B?YWlCNktjWEVmZmFDQ2RIYzBYNDdCM2NmL3pRVWErc1lRR1Q5TkVEblhQcGRE?=
 =?utf-8?B?UmJHYUxOc2w3bDFxc1g0ektEREtRTE0xMU9adDE5azByK2treXlVZ0lSTVc3?=
 =?utf-8?B?TXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B242D280FEEF3146AB8198A3F3845907@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ywY+YPOQYk4e6H4gbuwkBGqlZMATBVBYCXSxD78hAML5xESsgebBTzQQ/9Mi0q686ndMgTvgyfUmPznDGAigBnWw2GsSTGC8ZfdxrmhdnX8Y9rXUooxw8gXJXQ2t+pLVl5tunBNhcweiDX/Xf2/B6LTxWJRjCPi+ghBFhT/3rUwMbZoPzgZVvFb6kNaJFDLy3bUELek/ZNzM+pslImZCAt2WK7BfNhgW23PHn6UxnJIWqcVZsbdS74w9k32ihHvs8LvA+SJQWrv05oQbAHWtUpQ6YY9OajhYtWwKWRr6pEsh1ielMoGsUiID44ogStI0LYzT2ZQdJ4uZXcbUkESqD5zHIvSTsqhmDNNEvA+rsVmWK1Hif5KMh6TxrZaABMdVAgkw5pQwfI1tx1yUcpNMUULOQEQ55apNX3yMmyzuMkpkgnr3TFqwDfCJds9xS8RwDKmUpbVhdM+/5oZSR64k7ufd6nO49CljDFkJAy3vOZoh5e1SsnDCywM9w4yI8xkAIhSipEsA7UsK4RslwuLpbkD//IoudfqJh4sZXso7gp8grvC1UTBIfqam0an4G7DI0o7UhASfr8L27ETOI5Tok23JqGtDjgVCz5tLY2d+plw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 060ce1a2-1980-4aa6-f10c-08dd12ebf5d6
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Dec 2024 16:11:20.6808
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: G4oM1bY681DbnsiINTgcE8im34pIWZ65Ws10gpcauikOo42T9Oc/tgedtfwvfQFJpHGjdBIC4umv0FVAEwY+mg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6826
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-02_11,2024-12-02_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 suspectscore=0
 malwarescore=0 bulkscore=0 spamscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2412020138
X-Proofpoint-ORIG-GUID: YoL6Vd6XrCttlOCwnLox3Yv_MzZ7xCe-
X-Proofpoint-GUID: YoL6Vd6XrCttlOCwnLox3Yv_MzZ7xCe-

DQoNCj4gT24gTm92IDIxLCAyMDI0LCBhdCA1OjI54oCvUE0sIENodWNrIExldmVyIElJSSA8Y2h1
Y2subGV2ZXJAb3JhY2xlLmNvbT4gd3JvdGU6DQo+IA0KPiANCj4gDQo+PiBPbiBOb3YgMjEsIDIw
MjQsIGF0IDQ6NDfigK9QTSwgTmVpbEJyb3duIDxuZWlsYkBzdXNlLmRlPiB3cm90ZToNCj4+IA0K
Pj4gT24gV2VkLCAyMCBOb3YgMjAyNCwgQ2h1Y2sgTGV2ZXIgd3JvdGU6DQo+Pj4gT24gV2VkLCBO
b3YgMjAsIDIwMjQgYXQgMDk6MzU6MDBBTSArMTEwMCwgTmVpbEJyb3duIHdyb3RlOg0KPj4+PiBP
biBXZWQsIDIwIE5vdiAyMDI0LCBDaHVjayBMZXZlciB3cm90ZToNCj4+Pj4+IE9uIFR1ZSwgTm92
IDE5LCAyMDI0IGF0IDExOjQxOjMyQU0gKzExMDAsIE5laWxCcm93biB3cm90ZToNCj4+Pj4+PiBS
ZWR1Y2luZyB0aGUgbnVtYmVyIG9mIHNsb3RzIGluIHRoZSBzZXNzaW9uIHNsb3QgdGFibGUgcmVx
dWlyZXMNCj4+Pj4+PiBjb25maXJtYXRpb24gZnJvbSB0aGUgY2xpZW50LiAgVGhpcyBwYXRjaCBh
ZGRzIHJlZHVjZV9zZXNzaW9uX3Nsb3RzKCkNCj4+Pj4+PiB3aGljaCBzdGFydHMgdGhlIHByb2Nl
c3Mgb2YgZ2V0dGluZyBjb25maXJtYXRpb24sIGJ1dCBuZXZlciBjYWxscyBpdC4NCj4+Pj4+PiBU
aGF0IHdpbGwgY29tZSBpbiBhIGxhdGVyIHBhdGNoLg0KPj4+Pj4+IA0KPj4+Pj4+IEJlZm9yZSB3
ZSBjYW4gZnJlZSBhIHNsb3Qgd2UgbmVlZCB0byBjb25maXJtIHRoYXQgdGhlIGNsaWVudCB3b24n
dCB0cnkNCj4+Pj4+PiB0byB1c2UgaXQgYWdhaW4uICBUaGlzIGludm9sdmVzIHJldHVybmluZyBh
IGxvd2VyIGNyX21heHJlcXVlc3RzIGluIGENCj4+Pj4+PiBTRVFVRU5DRSByZXBseSBhbmQgdGhl
biBzZWVpbmcgYSBjYV9tYXhyZXF1ZXN0cyBvbiB0aGUgc2FtZSBzbG90IHdoaWNoDQo+Pj4+Pj4g
aXMgbm90IGxhcmdlciB0aGFuIHdlIGxpbWl0IHdlIGFyZSB0cnlpbmcgdG8gaW1wb3NlLiAgU28g
Zm9yIGVhY2ggc2xvdA0KPj4+Pj4+IHdlIG5lZWQgdG8gcmVtZW1iZXIgdGhhdCB3ZSBoYXZlIHNl
bnQgYSByZWR1Y2VkIGNyX21heHJlcXVlc3RzLg0KPj4+Pj4+IA0KPj4+Pj4+IFRvIGFjaGlldmUg
dGhpcyB3ZSBpbnRyb2R1Y2UgYSBjb25jZXB0IG9mIHJlcXVlc3QgImdlbmVyYXRpb25zIi4gIEVh
Y2gNCj4+Pj4+PiB0aW1lIHdlIGRlY2lkZSB0byByZWR1Y2UgY3JfbWF4cmVxdWVzdHMgd2UgaW5j
cmVtZW50IHRoZSBnZW5lcmF0aW9uDQo+Pj4+Pj4gbnVtYmVyLCBhbmQgcmVjb3JkIHRoaXMgd2hl
biB3ZSByZXR1cm4gdGhlIGxvd2VyIGNyX21heHJlcXVlc3RzIHRvIHRoZQ0KPj4+Pj4+IGNsaWVu
dC4gIFdoZW4gYSBzbG90IHdpdGggdGhlIGN1cnJlbnQgZ2VuZXJhdGlvbiByZXBvcnRzIGEgbG93
DQo+Pj4+Pj4gY2FfbWF4cmVxdWVzdHMsIHdlIGNvbW1pdCB0byB0aGF0IGxldmVsIGFuZCBmcmVl
IGV4dHJhIHNsb3RzLg0KPj4+Pj4+IA0KPj4+Pj4+IFdlIHVzZSBhbiA4IGJpdCBnZW5lcmF0aW9u
IG51bWJlciAoNjQgc2VlbXMgd2FzdGVmdWwpIGFuZCBpZiBpdCBjeWNsZXMNCj4+Pj4+PiB3ZSBp
dGVyYXRlIGFsbCBzbG90cyBhbmQgcmVzZXQgdGhlIGdlbmVyYXRpb24gbnVtYmVyIHRvIGF2b2lk
IGZhbHNlIG1hdGNoZXMuDQo+Pj4+Pj4gDQo+Pj4+Pj4gV2hlbiB3ZSBmcmVlIGEgc2xvdCB3ZSBz
dG9yZSB0aGUgc2VxaWQgaW4gdGhlIHNsb3QgcG9pbnRlciBzbyB0aGF0IGl0IGNhbg0KPj4+Pj4+
IGJlIHJlc3RvcmVkIHdoZW4gd2UgcmVhY3RpdmF0ZSB0aGUgc2xvdC4gIFRoZSBSRkMgY2FuIGJl
IHJlYWQgYXMNCj4+Pj4+PiBzdWdnZXN0aW5nIHRoYXQgdGhlIHNsb3QgbnVtYmVyIGNvdWxkIHJl
c3RhcnQgZnJvbSBvbmUgYWZ0ZXIgYSBzbG90IGlzDQo+Pj4+Pj4gcmV0aXJlZCBhbmQgcmVhY3Rp
dmF0ZWQsIGJ1dCBhbHNvIHN1Z2dlc3RzIHRoYXQgcmV0aXJpbmcgc2xvdHMgaXMgbm90DQo+Pj4+
Pj4gcmVxdWlyZWQuICBTbyB3aGVuIHdlIHJlYWN0aXZlIGEgc2xvdCB3ZSBhY2NlcHQgd2l0aCB0
aGUgbmV4dCBzZXFpZCBpbg0KPj4+Pj4+IHNlcXVlbmNlLCBvciAxLg0KPj4+Pj4+IA0KPj4+Pj4+
IFdoZW4gZGVjb2Rpbmcgc2FfaGlnaGVzdF9zbG90aWQgaW50byBtYXhzbG90cyB3ZSBuZWVkIHRv
IGFkZCAxIC0gdGhpcw0KPj4+Pj4+IG1hdGNoZXMgaG93IGl0IGlzIGVuY29kZWQgZm9yIHRoZSBy
ZXBseS4NCj4+Pj4+PiANCj4+Pj4+PiBTaWduZWQtb2ZmLWJ5OiBOZWlsQnJvd24gPG5laWxiQHN1
c2UuZGU+DQo+Pj4+Pj4gLS0tDQo+Pj4+Pj4gZnMvbmZzZC9uZnM0c3RhdGUuYyB8IDgxICsrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0tLS0tLQ0KPj4+Pj4+IGZzL25mc2Qv
bmZzNHhkci5jICAgfCAgNSArLS0NCj4+Pj4+PiBmcy9uZnNkL3N0YXRlLmggICAgIHwgIDQgKysr
DQo+Pj4+Pj4gZnMvbmZzZC94ZHI0LmggICAgICB8ICAyIC0tDQo+Pj4+Pj4gNCBmaWxlcyBjaGFu
Z2VkLCA3NiBpbnNlcnRpb25zKCspLCAxNiBkZWxldGlvbnMoLSkNCj4+Pj4+PiANCj4+Pj4+PiBk
aWZmIC0tZ2l0IGEvZnMvbmZzZC9uZnM0c3RhdGUuYyBiL2ZzL25mc2QvbmZzNHN0YXRlLmMNCj4+
Pj4+PiBpbmRleCBmYjUyMjE2NWIzNzYuLjA2MjViMGFlYzZiOCAxMDA2NDQNCj4+Pj4+PiAtLS0g
YS9mcy9uZnNkL25mczRzdGF0ZS5jDQo+Pj4+Pj4gKysrIGIvZnMvbmZzZC9uZnM0c3RhdGUuYw0K
Pj4+Pj4+IEBAIC0xOTEwLDE3ICsxOTEwLDU1IEBAIGdlbl9zZXNzaW9uaWQoc3RydWN0IG5mc2Q0
X3Nlc3Npb24gKnNlcykNCj4+Pj4+PiAjZGVmaW5lIE5GU0RfTUlOX0hEUl9TRVFfU1ogICgyNCAr
IDEyICsgNDQpDQo+Pj4+Pj4gDQo+Pj4+Pj4gc3RhdGljIHZvaWQNCj4+Pj4+PiAtZnJlZV9zZXNz
aW9uX3Nsb3RzKHN0cnVjdCBuZnNkNF9zZXNzaW9uICpzZXMpDQo+Pj4+Pj4gK2ZyZWVfc2Vzc2lv
bl9zbG90cyhzdHJ1Y3QgbmZzZDRfc2Vzc2lvbiAqc2VzLCBpbnQgZnJvbSkNCj4+Pj4+PiB7DQo+
Pj4+Pj4gaW50IGk7DQo+Pj4+Pj4gDQo+Pj4+Pj4gLSBmb3IgKGkgPSAwOyBpIDwgc2VzLT5zZV9m
Y2hhbm5lbC5tYXhyZXFzOyBpKyspIHsNCj4+Pj4+PiArIGlmIChmcm9tID49IHNlcy0+c2VfZmNo
YW5uZWwubWF4cmVxcykNCj4+Pj4+PiArIHJldHVybjsNCj4+Pj4+PiArDQo+Pj4+Pj4gKyBmb3Ig
KGkgPSBmcm9tOyBpIDwgc2VzLT5zZV9mY2hhbm5lbC5tYXhyZXFzOyBpKyspIHsNCj4+Pj4+PiBz
dHJ1Y3QgbmZzZDRfc2xvdCAqc2xvdCA9IHhhX2xvYWQoJnNlcy0+c2Vfc2xvdHMsIGkpOw0KPj4+
Pj4+IA0KPj4+Pj4+IC0geGFfZXJhc2UoJnNlcy0+c2Vfc2xvdHMsIGkpOw0KPj4+Pj4+ICsgLyoN
Cj4+Pj4+PiArICAqIFNhdmUgdGhlIHNlcWlkIGluIGNhc2Ugd2UgcmVhY3RpdmF0ZSB0aGlzIHNs
b3QuDQo+Pj4+Pj4gKyAgKiBUaGlzIHdpbGwgbmV2ZXIgcmVxdWlyZSBhIG1lbW9yeSBhbGxvY2F0
aW9uIHNvIEdGUA0KPj4+Pj4+ICsgICogZmxhZyBpcyBpcnJlbGV2YW50DQo+Pj4+Pj4gKyAgKi8N
Cj4+Pj4+PiArIHhhX3N0b3JlKCZzZXMtPnNlX3Nsb3RzLCBpLCB4YV9ta192YWx1ZShzbG90LT5z
bF9zZXFpZCksDQo+Pj4+Pj4gKyAgR0ZQX0FUT01JQyk7DQo+Pj4+PiANCj4+Pj4+IEFnYWluLi4u
IEFUT01JQyBpcyBwcm9iYWJseSBub3Qgd2hhdCB3ZSB3YW50IGhlcmUsIGV2ZW4gaWYgaXQgaXMN
Cj4+Pj4+IG9ubHkgZG9jdW1lbnRhcnkuDQo+Pj4+IA0KPj4+PiBXaHkgbm90PyAgSXQgbWlnaHQg
YmUgY2FsbGVkIHVuZGVyIGEgc3BpbmxvY2sgc28gR0ZQX0tFUk5FTCBtaWdodCB0cmlnZ2VyDQo+
Pj4+IGEgd2FybmluZy4NCj4+PiANCj4+PiBJIGZpbmQgdXNpbmcgR0ZQX0FUT01JQyBoZXJlIHRv
IGJlIGNvbmZ1c2luZyAtLSBpdCByZXF1ZXN0cw0KPj4+IGFsbG9jYXRpb24gZnJvbSBzcGVjaWFs
IG1lbW9yeSByZXNlcnZlcyBhbmQgaXMgdG8gYmUgdXNlZCBpbg0KPj4+IHNpdHVhdGlvbnMgd2hl
cmUgYWxsb2NhdGlvbiBtaWdodCByZXN1bHQgaW4gc3lzdGVtIGZhaWx1cmUuIFRoYXQgaXMNCj4+
PiBjbGVhcmx5IG5vdCB0aGUgY2FzZSBoZXJlLCBhbmQgdGhlIHJlc3VsdGluZyBtZW1vcnkgYWxs
b2NhdGlvbiBtaWdodA0KPj4+IGJlIGxvbmctbGl2ZWQuDQo+PiANCj4+IFdvdWxkIHlvdSBiZSBj
b21mb3J0YWJsZSB3aXRoIEdGUF9OT1dBSVQgd2hpY2ggbGVhdmVzIG91dCBfX0dGUF9ISUdIID8/
DQo+IA0KPiBJIHdpbGwgYmUgY29tZm9ydGFibGUgd2hlbiBJIGhlYXIgYmFjayBmcm9tIE1hdHRo
ZXcgYW5kIExpYW0uDQo+IA0KPiA6LSkNCj4gDQo+IA0KPj4+IEkgc2VlIHRoZSBjb21tZW50IHRo
YXQgc2F5cyBtZW1vcnkgd29uJ3QgYWN0dWFsbHkgYmUgYWxsb2NhdGVkLiBJJ20NCj4+PiBub3Qg
c3VyZSB0aGF0J3MgdGhlIHdheSB4YV9zdG9yZSgpIHdvcmtzLCBob3dldmVyLg0KPj4gDQo+PiB4
YXJyYXkucnN0IHNheXM6DQo+PiANCj4+IFRoZSB4YV9zdG9yZSgpLCB4YV9jbXB4Y2hnKCksIHhh
X2FsbG9jKCksDQo+PiB4YV9yZXNlcnZlKCkgYW5kIHhhX2luc2VydCgpIGZ1bmN0aW9ucyB0YWtl
IGEgZ2ZwX3QNCj4+IHBhcmFtZXRlciBpbiBjYXNlIHRoZSBYQXJyYXkgbmVlZHMgdG8gYWxsb2Nh
dGUgbWVtb3J5IHRvIHN0b3JlIHRoaXMgZW50cnkuDQo+PiBJZiB0aGUgZW50cnkgaXMgYmVpbmcg
ZGVsZXRlZCwgbm8gbWVtb3J5IGFsbG9jYXRpb24gbmVlZHMgdG8gYmUgcGVyZm9ybWVkLA0KPj4g
YW5kIHRoZSBHRlAgZmxhZ3Mgc3BlY2lmaWVkIHdpbGwgYmUgaWdub3JlZC5gDQo+PiANCj4+IFRo
ZSBwYXJ0aWN1bGFyIGNvbnRleHQgaXMgdGhhdCBhIG5vcm1hbCBwb2ludGVyIGlzIGN1cnJlbnRs
eSBzdG9yZWQgYQ0KPj4gdGhlIGdpdmVuIGluZGV4LCBhbmQgd2UgYXJlIHJlcGxhY2luZyB0aGF0
IHdpdGggYSBudW1iZXIuICBUaGUgYWJvdmUNCj4+IGRvZXNuJ3QgZXhwbGljaXRseSBzYXkgdGhh
dCB3b24ndCByZXF1aXJlIGEgbWVtb3J5IGFsbG9jYXRpb24sIGJ1dCBJDQo+PiB0aGluayBpdCBp
cyByZWFzb25hYmxlIHRvIHNheSBpdCB3b24ndCBuZWVkICJ0byBhbGxvY2F0ZSBtZW1vcnkgdG8g
c3RvcmUNCj4+IHRoaXMgZW50cnkiIC0gYXMgYW4gZW50cnkgaXMgYWxyZWFkeSBzdG9yZWQgLSBz
byBhbGxvY2F0aW9uIHNob3VsZCBub3QNCj4+IGJlIG5lZWRlZC4NCj4gDQo+IHhhX21rX3ZhbHVl
KCkgY29udmVydHMgYSBudW1iZXIgdG8gYSBwb2ludGVyLCBhbmQgeGFfc3RvcmUNCj4gc3RvcmVz
IHRoYXQgcG9pbnRlci4NCj4gDQo+IEkgc3VzcGVjdCB0aGF0IHhhX3N0b3JlKCkgaXMgYWxsb3dl
ZCB0byByZWJhbGFuY2UgdGhlDQo+IHhhcnJheSdzIGludGVybmFsIGRhdGEgc3RydWN0dXJlcywg
YW5kIHRoYXQgY291bGQgcmVzdWx0DQo+IGluIG1lbW9yeSByZWxlYXNlIG9yIGFsbG9jYXRpb24u
IFRoYXQncyB3aHkgYSBHRlAgZmxhZyBpcw0KPiBvbmUgb2YgdGhlIGFyZ3VtZW50cy4NCg0KTWF0
dGhldyBzYXlzIHRoZSB4YV9zdG9yZSgpIGlzIGd1YXJhbnRlZWQgbm90IHRvIGRvIGEgbWVtb3J5
DQphbGxvY2F0aW9uIGluIHRoaXMgY2FzZS4gSG93ZXZlciwgdGhleSBwcmVmZXIgYW4gYW5ub3Rh
dGlvbg0Kb2YgdGhlIGNhbGwgc2l0ZSB3aXRoIGEgIjAiIEdGUCBhcmd1bWVudCB0byBzaG93IHRo
YXQgdGhlDQphbGxvY2F0aW9uIGZsYWdzIGFyZSBub3QgcmVsZXZhbnQuDQoNCkRvZXMgdGhpczoN
Cg0KCXhhX3N0b3JlKCZzZXMtPnNlX3Nsb3RzLCBpLCB4YV9ta192YWx1ZShzbG90LT5zbF9zZXFp
ZCksIDApOw0KDQp3b3JrIGZvciB5b3U/DQoNCi0tDQpDaHVjayBMZXZlcg0KDQoNCg==

