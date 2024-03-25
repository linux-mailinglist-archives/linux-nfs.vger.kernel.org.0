Return-Path: <linux-nfs+bounces-2471-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A8EF88B19F
	for <lists+linux-nfs@lfdr.de>; Mon, 25 Mar 2024 21:36:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDA291F32F8A
	for <lists+linux-nfs@lfdr.de>; Mon, 25 Mar 2024 20:36:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C6251BF31;
	Mon, 25 Mar 2024 20:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FakJGVqj";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="RgPITRBB"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7FC9339AC;
	Mon, 25 Mar 2024 20:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711399010; cv=fail; b=cUkuSRdXDkq4zo8gU3gQkBsJk55RR7mfG3uxXNQAyF6Bbgvozj/aOqeA+l4JGE+lzOxe82zVc2/Bjj8cI31r7Y9mlOBZIbkWB+OtfBD69cr5B6bkbpowXWUKmkw0YYl83YIyvoBIo8rMOeco1rncdvjbFbms3ULSwAq+N98deQw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711399010; c=relaxed/simple;
	bh=ZmxK+gg5mMo3gxhh0BwkiuUBxk9QI2wItguSdSIVRKo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Ug//9vHP0B9TvkP8/tHzpzIJPBpMhRNRZYAu8U2qQWgJokxDrkKMyQgSxAVS1hwIUL7UokOtrH9yMjEbFB4lml1rfJ/8aTdwlpA7oze+IRULZv5ynuicTzRDmrYEAyblS53fCUbgo6miN6Zmz8ViC8OVPPDp40Ky0RUS8cE1D2w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=FakJGVqj; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=RgPITRBB; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42PKYLF9030060;
	Mon, 25 Mar 2024 20:36:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=ZmxK+gg5mMo3gxhh0BwkiuUBxk9QI2wItguSdSIVRKo=;
 b=FakJGVqjc8TvkAPblv1gABGbvWz4bZGmJ9KHUqPYmeZefd2n3W70dItGmd+OQBEWql/U
 +1t78h+Jd4CnPMU+G3e5F+vl+uskscFvwn2w6g9nXl+noH+UwyJlqngBqDqy5JEDnFnO
 e7bvaipYltPThEg7dy8pH+tR7PRsku9vJtxTN6y/iReMPKjWTKxUEuxjqcCxIs7Yop9j
 QTAJ3DSqh519YIliKwQi+3zEpWE6ZwZVuqA6M0BWEfIzSclVmoOsXZ+K2NwDZ/U2Al9w
 48nCzXgcCIlztHp2y4a8PsxzuLAsTjMYx6houKEKd/hmLWNsJ3My71GQbnnsyiWx2YY+ 5g== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3x1pybkk6d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 25 Mar 2024 20:36:37 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 42PJMJ3I010557;
	Mon, 25 Mar 2024 20:36:36 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2041.outbound.protection.outlook.com [104.47.57.41])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3x1nh66m99-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 25 Mar 2024 20:36:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qfhg0TV06qn99M1hXw6IWceyy11tkORBHpf+ldskRzujaYL2VSh/3q/bvubZQA2t0wLCwDGhFSbdYoXWWdXpv+47pxmRVzoDXdsaJRKGX+hlLHJfUI39/JQICsW3a2Sz3PUPvMcIgLf0niHDW9t2aZonR/n8xwj9O9w9EeGxwvZi46Dq+ulgyxtjnGvXoQOqdcJ9Nq0z6g70g+zJtp+SptGIz6Vdv4gFXVzNS1FR+QnlVRkKRYOUBUtaLmwgiCJOyTd3WygkZCdiR0tn++/Vm2uo6QaeQRE/0zPRzZGEd/dxpwvycbk7jl4Uoz49ZCPAV0Fqr3ey8i47T6gJsQKCoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZmxK+gg5mMo3gxhh0BwkiuUBxk9QI2wItguSdSIVRKo=;
 b=igGMC6zvjaC+o9ZljTh7LW8q6vddfLtrMnVK/Zq6642+UeXuPl542qheBiSR9br64Um/zA01Wu7/y8tyijKSSIfbkC64o+YOybCDCeoO7XpArgH0Ntpqew6ungn4SvjjA9lG5+l+KlriaJE9+Bvv7Gomu8xlCku4Rnzl7E/NcVTM972tEn2kppR8CE7MC2BeKI8tQhEc8bFti9NvcOCVZ/CWFi85zQpHWpsbsWeAKXF1lhnO5QYtXpllXMlddAopAXYwMy8MGIB+A0zkGYzIXCcOJh8CD6LNJdBvUdkZt69n4jyuJo1aa4tPis+13TL9omjPOGvpF68BqMUqjCwm3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZmxK+gg5mMo3gxhh0BwkiuUBxk9QI2wItguSdSIVRKo=;
 b=RgPITRBBpct8M6m6tF5o1+aDwBErFoU0mqnLzyn0Rs0qgikU9N2HFtedGQG0rYLAcAu+WsfABNvCgPguxx6ZOH2tJ2ysKZFSmFU3N+Ud32JtFM2PRTPWszzcVcXBSK4pt11uA6GXC9gUcCaTZzjSqjxKiMjsP6uNQjd7voHM2jY=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH0PR10MB5627.namprd10.prod.outlook.com (2603:10b6:510:fa::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Mon, 25 Mar
 2024 20:36:34 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ad12:a809:d789:a25b]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ad12:a809:d789:a25b%4]) with mapi id 15.20.7409.031; Mon, 25 Mar 2024
 20:36:34 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Jan Schunk <scpcom@gmx.de>
CC: Jeff Layton <jlayton@kernel.org>, Neil Brown <neilb@suse.de>,
        Olga
 Kornievskaia <kolga@netapp.com>, Dai Ngo <dai.ngo@oracle.com>,
        Tom Talpey
	<tom@talpey.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [External] : nfsd: memory leak when client does many file
 operations
Thread-Topic: [External] : nfsd: memory leak when client does many file
 operations
Thread-Index: AQHafvQgFHRWnP2bS0KTIVIRm3T7ww==
Date: Mon, 25 Mar 2024 20:36:34 +0000
Message-ID: <51CAACAB-B6CC-4139-A350-25CF067364D3@oracle.com>
References: 
 <trinity-068f55c9-6088-418d-bf3a-c2778a871e98-1711310237802@msvc-mesg-gmx120>
 <E3109CAA-8261-4F66-9D1B-3546E8B797DF@oracle.com>
 <trinity-bfafb9db-d64f-4cad-8cb1-40dac0a2c600-1711313314331@msvc-mesg-gmx105>
 <567BBF54-D104-432C-99C0-1A7EE7939090@oracle.com>
 <trinity-66047013-4d84-4eef-b5d3-d710fe6be805-1711316386382@msvc-mesg-gmx005>
 <6F16BCCE-3000-4BCB-A3B4-95B4767E3577@oracle.com>
 <trinity-ad0037c0-1060-4541-a8ca-15f826a5b5a2-1711396545958@msvc-mesg-gmx024>
 <088D9CC3-C5B0-4646-A85D-B3B9ACE8C532@oracle.com>
 <trinity-77720d9d-4d5b-48c6-8b1f-0b7205ea3c2b-1711398394712@msvc-mesg-gmx021>
In-Reply-To: 
 <trinity-77720d9d-4d5b-48c6-8b1f-0b7205ea3c2b-1711398394712@msvc-mesg-gmx021>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.400.31)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|PH0PR10MB5627:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 aAUeEAfBohK6Gg9fYR5WaTx/7BaOpSv4BRX33YNsemqxTatFCozzgYQdo/UdjwCDUdHs4nNyLXL3A9B3jfeMr/+IYU7J4wZONLUNNsYRWXzfvH+TT0K9/pZTe2T32HNIdTU5u+fv4TmRiWl7nrcd1C4IQYFkz2ygNvk99yN5IH/kOcvD4SmIeNiEtw4WKZqSAQSiiRYoLw6roIADH8NALyLDBoLaLqztibGYV3W5lJrh4eN4Ufqwf59NvPLqiRFpK7hJltHjmhKOQygwYhXfhEg7kOJfWTna98SSLE2EcqM/FF5nt+DNNB/3TFR/EToAKEjZZB8OwCb0Rdr2MWiUiqq00p2Y16gzpa1lqRxNGlTNOnbGYNuOXAnv24glLenRJM7rFGSyXMC+5OqfcEdhCJEwo0Ov47+0y/UqmIP4UXh+3TQuSygvky1qfq8oqn2uQlCcxDwEnR9NBt9flOgJimUlBUxKLf9vU7VoHiuCbyzpwWQBzEp3PzhJOHR9exIuqV5L1WXLU7DXZ8McRlOp081Dk7HPeKVF3cBvRQOveB0L4SzRV4y+1Xl0wutTPmoa7jAnwUjNammNPLxEe0T17rYs0bbeizcUQCHZMyNLQGbBMHorTMrMVcRliAThUPJ7nrKisGyg2FptUCJHxzrcqP4+UuJ23G84HDYKhuAF2hY=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?OW91SVlxcHhubjFqZ2NJczRmdFptTjZ6ek5HVDhRdElIMHlITTN6b3JiRjkv?=
 =?utf-8?B?cWJobmtxUjA1WFVKKys5SXF6dkZlRDVNdXlWaGV3NldxdDI5MmtqWE1WbVJa?=
 =?utf-8?B?TTZxVlF2YzB0dGJyZHZlQW4yQ2JQSDZGcGJJWHNGMzNGMVZNT0daMk0wZHNF?=
 =?utf-8?B?ZEszTjJaRjlydW5jbmJ6Q1BLOEtSZm11ZmtXMFZSVC9wcVc2K1M5UURtZjlr?=
 =?utf-8?B?eTFDZW5rVkI3VXo0Q3c1VUZlcjdzNDBERDNJQkRFaW9pbFJGKytMa0t3SUZ1?=
 =?utf-8?B?ckNEUGlSZXZZRDBpS0lsanhSVVV1K2EydXlOeWlPYkNPZWY5bFJrSVhlTDNB?=
 =?utf-8?B?OWV3bVUvaDVkUGhMWGRQN2d4cWFBbUlhd0VNaExzYzVEVE1kc0t0VWMwOWxY?=
 =?utf-8?B?K2dvWmxFeStVc3pvK2U5RkhnQ2x6S2tCSmIrZ3pFYlZidzc5VkhIMGd2LzVZ?=
 =?utf-8?B?MG13YzhMblhkdTFuQ3BsTDJoY3JCSDJnQlNVZE1vZnBvQTNvLy9UcysvM2dX?=
 =?utf-8?B?U0JWb3I5WUVHSURnb2Z3NkZ5STV3N0JiNkhkSFJIdk9OSkFKekdJNEJzSElz?=
 =?utf-8?B?dnZNdlZxL29JUnFMRHB2MFpDL2hWMFo5Q2psckJhSUQ4d3daOWNudVp1Mms3?=
 =?utf-8?B?VndxTVY1M2U3WjNuNkhpcHJNV2VUcDBmTHR2NzdSVjB5M2MvYUFnZjcxTUFZ?=
 =?utf-8?B?UUtWV3JjQTZJdE5CazhCUVB2U3c3am1kdHJ1V09FTVJJc1UwenJ2SGZQVjVT?=
 =?utf-8?B?TlRqSDV4Ym5Da3Q2ZDFnQ1orYko4MmZjNkYrT3JiMDUzaGc5VVphQWpLbitW?=
 =?utf-8?B?WEpGUkhLWUplTFNTWnUwVDh1a1ZkY0ozNDlqalZPTVg1Wlg4U05Mdm5RSHFT?=
 =?utf-8?B?OFhWN2VTY1ZHS2FpZXJDNFo2bXdKYTNVdkVlWVhDKzhabm1kUUswN0pTcXRN?=
 =?utf-8?B?LzVOVjl2R3hUT1dTL3puQ3YvU0VEQ2VYWnAvMS9JWTRUbDlzVXB5c2d6S1ht?=
 =?utf-8?B?QmI4ajNZNzNYd2lOVjB6dEErVEFqTHdDYko3cjhrcUdGdWRna2VPcGNoMXNX?=
 =?utf-8?B?OEZQNGJEYmg1TjBmM2ZYYVUvQ0FFTFpyQnZhSjd3Z1FFSFBCRFRNOExKcnB2?=
 =?utf-8?B?T3k0K0R5Z2dKVGU5WjZndi8zYWs1MUZydHlwdGlSRUV5bmNOWjJvc1Fidkl4?=
 =?utf-8?B?U0ZaaU1VdDlYd1MweEJDUUZmNTBpWGdCNzRPU2hNTC9sVlpOYnkyTC92MTYw?=
 =?utf-8?B?aDh2TDYwUDRQUDV5MDdnR1czakVnVHprTmpFZUNnRGZmdytoaHBYV1RyWFdJ?=
 =?utf-8?B?RHBPMTF2YzBWWWJSaXJlVTEwS00rZWNSVkc5VHhZU0RTMi9hTFppN2pNVFM3?=
 =?utf-8?B?bDdCbTE1MnZiUy9VQlVoZzlDaXFJK0Flc2h2VFdGM09sVHRjcWwzaEw4REU5?=
 =?utf-8?B?T2FJWTU3QnJWN21vSjEwTEZaSTAxaWg2YVhDMUIxbkRBRVdsNVRZQzh1WW90?=
 =?utf-8?B?M0R0ZCtlWG5vRVlBdDhsdWZER2pSYWpPVVRrN2Myb3JhVkhuUm5MRkFwU3hw?=
 =?utf-8?B?aGhtQjFmZkxUN0RhYkxqY3NBRE1Hc09ZVzIvZVVRTFNJaW9TVE9VcHJqVTZl?=
 =?utf-8?B?cFpVb3V6SnFUKzMwMjdGNW5GTEdBb3Bxa25Fd0R3L203bElPdkpuNUFsdFl3?=
 =?utf-8?B?QldRUjY1dUE3U05TRnFnQ3pFUjc3alYzbUJ5YTNDMG5oME1NY2UrRHVIRFF2?=
 =?utf-8?B?WTRqTW8xclpIUjhqSVFrMlJFY0VXRXhIVklTbVo1MUxnZWtXSWdmSGhJNm9w?=
 =?utf-8?B?Rkc1Z3hIWExSRmpUc1dyS3MxZXRHK0lnS3pnNmdrZ1p4SnR0LzVBOWF2aTJB?=
 =?utf-8?B?c2tOMEM1Q1R3dm1BOHB3SHlGR002V2lhNHFEcXN2allld1cxVk9vV0poVUdI?=
 =?utf-8?B?ZlAvelVlM0FWZHkxZ1J5cFBIOVk2L3lDTlRLa2VoZ3BxLzB4VXpyQWV2cjVM?=
 =?utf-8?B?a1k4WS9jM05KZkZCenV1ZHJnR2puQ01ZRERqY1l2bk85OUFNWFBoYkVwbFF5?=
 =?utf-8?B?Mnk5cHVIekNhVHR5ekY2S2Z6V083U0RSMC9iVHpFbHlyNnhON0tBUVg5cGFn?=
 =?utf-8?B?ZmNnejZ3ZERUdzgyRFlDS25yMXAwbmFnK3VrSVN3SDFSektKR1J4YzlVazlu?=
 =?utf-8?B?WlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C2F6C4A13CF8D9438CA790869C5062A3@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	QzkyZEcJEz6JSuyexBHcexqI4iY0gSaTmxlEV3bY2w61h4wP7P/cAJoU1wuqgW0xsshtTJnus2RLXJoZlnQqtb6f07cWIxTBMkocDdKvbBKh0jjYE5UnVNBH6QlnM4xtExbp0OtCqF/PWsqvIFBdKKsvR4cD4T031TUFaCXPkg7f/u2wR6kbmAouC8YCjfi1AZTBaGQLay+c32f44AibnCmCPGbNiWWXY8SAKNnG7LAtyus3PaBKcAV5uS8fXcNmBSR1ABI+x9YZW2NtFGXampHrt0X4fBHKQ4p5xcw7OTz4BD5Y6DydZdhKGkozr6XnBquGlgdFGghScS1rMqYaJunFGphjLdabjh6AaggRt/8A2VpoAD2XYPIBc1VZLI75MiQh2STKsim0lyRcdOgFhBq5NNn30hGmKRHgfOV+6sY0MLaPmcSYe21uB+f+hHBkQQTyfOM4fKQcOPhMDxoMOcC1jmm3QbIoZix2bqIA7bs8fdFMYluzHIQlvDcojTUGmV0pISFbVTvQNuXgQJFtFHPXYJSgOkDfujOT59aoQhZnz8HRc4jZQMmTjjEyLx3dG5MO0vo8+cEDTMizAdHfJDgU8o2K4qKx8UQAO0/4tVc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f8c3cd0-b43a-4cc4-58e0-08dc4d0b4333
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2024 20:36:34.6660
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XZ/z0KUVqwNE6qR70dVO8ob3aaf5v9zn/z+lkrRIR8oFv39mX2pTmmalGwK8VqXCDEDVGyUH69F0ZyLCrf/WGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5627
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-25_19,2024-03-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 bulkscore=0 spamscore=0 adultscore=0 mlxscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403210000 definitions=main-2403250126
X-Proofpoint-GUID: GDJGaRmDUW5XLS-NgXeAR0V2VQKpOozF
X-Proofpoint-ORIG-GUID: GDJGaRmDUW5XLS-NgXeAR0V2VQKpOozF

DQoNCj4gT24gTWFyIDI1LCAyMDI0LCBhdCA0OjI24oCvUE0sIEphbiBTY2h1bmsgPHNjcGNvbUBn
bXguZGU+IHdyb3RlOg0KPiANCj4gSSBhbSBidWlsZGluZyBteSBvd24ga2VybmVscywgYnV0IEkg
bmV2ZXIgdHJpZWQga21lbWxlYWssIGlzIHRoaXMganVzdCBhIEtjb25maWcgb3B0aW9uPw0KDQog
IExvY2F0aW9uOg0KICAgIC0+IEtlcm5lbCBoYWNraW5nDQogICAgICAtPiBNZW1vcnkgRGVidWdn
aW5nDQooMSkgICAgIC0+IEtlcm5lbCBtZW1vcnkgbGVhayBkZXRlY3RvciAoREVCVUdfS01FTUxF
QUsgWz1uXSkNCg0KDQo+IFdoYXQgZG8geW91IG1lYW4gd2l0aCAiYmlzZWN0IGJldHdlZW4gdjYu
MyBhbmQgdjYuNCI/DQoNCkFmdGVyIHlvdSAiZ2l0IGNsb25lIiB0aGUga2VybmVsIHNvdXJjZToN
Cg0KJCBnaXQgYmlzZWN0IHN0YXJ0IHY2LjQgdjYuMw0KDQpCdWlsZCB0aGUga2VybmVsIGFuZCB0
ZXN0LiBJZiB0aGUgdGVzdCBmYWlsczoNCg0KJCBjZCA8eW91ciBrZXJuZWwgc291cmNlIHRyZWU+
OyBnaXQgYmlzZWN0IGJhZA0KDQpJZiB0aGUgdGVzdCBzdWNjZWVkczoNCg0KJCBjZCA8eW91ciBr
ZXJuZWwgc291cmNlIHRyZWU+OyBnaXQgYmlzZWN0IGdvb2QNCg0KUmVidWlsZCBhbmQgdHJ5IGFn
YWluIHVudGlsIGl0IGxhbmRzIG9uIHRoZSBmaXJzdCBicm9rZW4gY29tbWl0Lg0KDQoNCj4gRXZl
cnl0aGluZyBpbmNsdWRpbmcgdjYuNCBpcyBPSywgdGhlIHByb2JsZW0gc3RhcnRzIGF0IHY2LjUu
DQoNCkkgbWlzcmVtZW1iZXJlZC4gVXNlICIkIGdpdCBiaXNlY3Qgc3RhcnQgdjYuNSB2Ni40IiB0
aGVuLg0KDQoNCj4gSSBhbHNvIGxvb2tlZCBhdCBzb21lIGNvZGUgYWxyZWFkeSBidXQgdGhlcmUg
YXJlIGh1Z2UgY2hhbmdlcyB0byBtbSB0aGF0IGhhcHBlbmVkIGluIHY2LjUgYW5kIHY2LjYgc28g
Zm9yIG1lIGl0IGlzIGhlYXZ5IHRvIGNvbXBhcmUgaXQgd2l0aCBvbGRlciB2ZXJzaW9ucyB0byBm
aW5kIG9uZSBvciBtb3JlIGNvbW1pdHMgdGhhdCBtYXkgY2F1c2UgdGhlIGlzc3VlLg0KDQpCaXNl
Y3Rpb24gaXMgYSBtZWNoYW5pY2FsIHRlc3QtYmFzZWQgcHJvY2Vzcy4gWW91IGRvbid0IG5lZWQN
CnRvIGxvb2sgYXQgY29kZSB1bnRpbCB5b3UndmUgcmVhY2hlZCB0aGUgZmlyc3QgYmFkIGNvbW1p
dC4NCg0KLS0NCkNodWNrIExldmVyDQoNCg0K

