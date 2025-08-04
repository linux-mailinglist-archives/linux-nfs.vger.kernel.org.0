Return-Path: <linux-nfs+bounces-13401-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF952B1A405
	for <lists+linux-nfs@lfdr.de>; Mon,  4 Aug 2025 16:02:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48A0917F606
	for <lists+linux-nfs@lfdr.de>; Mon,  4 Aug 2025 14:02:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7747226E709;
	Mon,  4 Aug 2025 14:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="RAC/0uRc";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="nzS/PE+W"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D129B26E146
	for <linux-nfs@vger.kernel.org>; Mon,  4 Aug 2025 14:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754316129; cv=fail; b=TJJ2IQvPBpCtEO0YMUyR6wy2PgHT1SJCEg5lwm5dhWSO/2eCcXyfCQwStnwBci+dOE/QiPVx/3rT/oBAbF/yiCq8FiPmFKt3s4K2KyIfJ+mvppfzFujMRHK43YgA/RD01T/YVNlDQFgn95cuYV4qCiyfhnLYsHBcyW3eK5x+y04=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754316129; c=relaxed/simple;
	bh=BXYUbBAoTRTKWYcDHOOOTSIN/FuOShqjbiVxoksQKgU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gol78l65Nw5Hlrhd2cq5UfaiE04/LJSGa+zxFAltKNYlea24VWSqZfeEf5NHg3qFnm/SQb+8/Ol7ENbFY9tcF3WG8mFfJX4XqFxdDbzyGdwi5i4rhJinghZLBLYMe3Djw+8c2Ggqjo8Y/brmgE/W0HFeIYTkCvWUuKduMqNT6v0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=RAC/0uRc; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=nzS/PE+W; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 574D6aEg031665;
	Mon, 4 Aug 2025 14:01:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=Y2MzfOt61o622Jhw9tErK2b2DRLILCBDfG3xW7TQKnY=; b=
	RAC/0uRc5MYla4AHsAN+W2gqji1at7RkOj7SekSsN8cmwRRaLxUbmuqJg400uLcB
	F+XtY1Gyt+Me34vALwapnTt21iRPVcWpZnjihQdc2TMFDItQd5ow5VzxSW5hK5Ex
	G+BaTV6zcPOZWvLWC9ulayO99Zpn3L+qG+9obvmBjfIj0nFNonBtZD7cAUm+EnFm
	2afLPEPSpi3v3uhGgCFsf9nwq1t9KEtiuW6HjNP6bxLBk+mZhhJCODjf5kunSvkx
	asxBvs5c8Lp16xTBUDXnwETRBTnEx4oI5wdVmrQ9Pv4OMj3vu9Aeb39mmY4pbHTV
	XG/UQZZZknNPLf5AechsYQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 489ajdjnxm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 04 Aug 2025 14:01:58 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 574DT1qY017901;
	Mon, 4 Aug 2025 14:01:55 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11on2053.outbound.protection.outlook.com [40.107.220.53])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48a7jvxh1m-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 04 Aug 2025 14:01:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qUJ+ck6UJiSmsJGR4ZpTb3w/V1EOyBOWpRW7CMjkahX3njn9+vgikUz2opq7g7HOyMxioStCJ4PRnoXY83xt0BGXCbGtepbxgBnY07hyfFEaGM95Bj6K+JNMPYS3ky/lN2dncwccROPuKkYuKV5t77evzV2CQYNkwEJdjcJUaN93vXamx8/GEPZggaOjBCZeJaLSmqQtKxa8nnTos8BIqT0zo2E0ggU8M/pp4obp6DoXOJz+s8cnh3E4AT4cOnr1E1aXeu3nr06Vz1Z4z4SeMxCgjoJidmggNFHiZTBPDaejBJNupYTR17Ram2ZzGUn4WzUBGgF6BL7339NOwR48UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y2MzfOt61o622Jhw9tErK2b2DRLILCBDfG3xW7TQKnY=;
 b=HC+mEBd5JtoCogz+AtfhA8IDlThb7LwObbnvOCfrbTfj7jI5EvDNw1R+T4NU8IohR+ySsEkrj+vJgT1gXqX6SmTNak9yM1W3nRaE+PjwpaPfWAm2rz9vcL34aLedyIvw/kR5bfBewiinTOCmvbebF3in9zJTTwTqhAGc69LE0mPk3rqUry9m/beBsxsJrC2Squh9VoxXvZKhDvRl3qwpbK6vBw6KVN8ad2PDtf9LcalxWVMRBz5B5InRQHqtlJXB7zKHDXAcIaiqFMEKR1De6uOmFe7f07p33/5N9TSrsBVNHpkXixkBUnjOdk29Kvj/rkoCV8Gawfvt0QBuY0riOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y2MzfOt61o622Jhw9tErK2b2DRLILCBDfG3xW7TQKnY=;
 b=nzS/PE+WO52mCbrMerpwQ1+uuEiBMMMKnOWJz/J7b3gUEgAX9QODNGE4di6YdniefUBR39xL9Ik8dm3P6XmL3DcP1PNkfl36POC7agrAgHnz2fmkwyEubZ0i3vyVUNnMsG1CjpJfQLUaFtuI0gu+i8iToe+uhzzQj54QoInSudk=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DM4PR10MB6744.namprd10.prod.outlook.com (2603:10b6:8:10c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.20; Mon, 4 Aug
 2025 14:01:51 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%5]) with mapi id 15.20.8989.017; Mon, 4 Aug 2025
 14:01:51 +0000
Message-ID: <360b8b4e-b8fc-4d21-84a9-2b908719d348@oracle.com>
Date: Mon, 4 Aug 2025 10:01:49 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nfsd: Replace open-coded conversion of bytes to hex
To: Eric Biggers <ebiggers@kernel.org>, Jeff Layton <jlayton@kernel.org>,
        linux-nfs@vger.kernel.org
Cc: NeilBrown <neil@brown.name>, Olga Kornievskaia <okorniev@redhat.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>
References: <20250803212448.117174-1-ebiggers@kernel.org>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20250803212448.117174-1-ebiggers@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH3P221CA0030.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:610:1e7::31) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|DM4PR10MB6744:EE_
X-MS-Office365-Filtering-Correlation-Id: d9e17ec4-2f26-41c2-049a-08ddd35f75e7
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?aGh2RjhZVEdmR2JJdDh3Wk5paUF6TVhuMmZ1ejA0U1B2RFdrNlBhc1NhQTUz?=
 =?utf-8?B?a0dKMUhtRHorY0lwOERwak1hcWpSUlY3L0tkeE1CdDczbzY4RnRKcWtYdG9G?=
 =?utf-8?B?QWVZc0dLRmRveGpNU0dZTDRGQkxzTFdrUTIzb09Ha0o0ZFN1eEM1VmppOHow?=
 =?utf-8?B?bFAwV2VJNU55bk9uRXBPcUpwcFZrdGN1U1kvdk9MU3BMSXc4a2RZZVN0WU1G?=
 =?utf-8?B?M2NtcjdIYkJPREUvSVQ4bGxNSVMvSDJLdWtyd2NRRlVlWklIQmQ5T1RpcU40?=
 =?utf-8?B?Ri9NZGhjR0dPdE15blhEaUo2dGx5c25NajlxbFlaK041a1lhTjhBd3prWFJm?=
 =?utf-8?B?SnA3K01OVUQ3OXR6Q3FvQk9RSEIyMmljUGNleForYlhFRGplMUVvSVVaM3gx?=
 =?utf-8?B?alphNUVyUjN0Y3Y5SFlTUmpDYjNnYU0vTTUrUW5ST1cvck80NTFYa1VZVlFH?=
 =?utf-8?B?WWZXZGs1dFNxRG5tY0RSM0R4RW1pZHllQUY4T3RsVjhKbXRObWdNaCtpZ3lH?=
 =?utf-8?B?bFhaenh3ZkxIWmh4eHphOXo5b3NYNy9IZjJrYlJqMHM2QmREZVZZUjdHa3Jy?=
 =?utf-8?B?dXpOVWNxa3c1cDJhVHhwSUtVcXpYZ1RWSHpQNGpacExVMjRxak9EUE54UG1y?=
 =?utf-8?B?VW1WUkpYR2tsOFBINkZ5RE1TVmhSbmxMNjBTRFZER3doOGNjbGx4WEJaL0xu?=
 =?utf-8?B?S0VubnRLWjhtK2dhU3k3TTNBVUZTTFQxVFZrVmFuN0NKc05kMTF5aE5ER1Zv?=
 =?utf-8?B?Qlp4MUNIV2czbTJrZ003ZVhjbzNlQmFPWC9KbTF5REU5S2NaTFI5ZFFDQVJQ?=
 =?utf-8?B?aHFKc3ZrR3IwUSt2WitsZXF2SWFQL1BXaGRIQ1hvWWxqcDFKbkJRd1pGKzQv?=
 =?utf-8?B?TUlaR3BSbzVLNlVUQ3JKS1FQamJHc1Z5dWgzSy9OM3U4eW41S2V3WFE3R0lE?=
 =?utf-8?B?OXJpOXRjc0d3Y3FZMUFEbHhvVnNJdEluSWZBUmlKWTRtL0N3WCs4RlFBNjFs?=
 =?utf-8?B?Y25QRXdPL3ByV1JXTU10V0crMDNTMG4xcGdTZ3lxRTF5RGk3bEhHUlRNSHJo?=
 =?utf-8?B?eFR0UGlXT3BTZ3ZzQ29JSjk2WWxvekI2MEgrT2NvNitDbW9ab3BrUXdMaHBC?=
 =?utf-8?B?eTM4ODBFSGQzeS9UOVFDUHdEMmRpbkRvVGIwUE53SDJjMnQvMTdjZnl5em1V?=
 =?utf-8?B?OEdLREROMnhKaklUVnZSWGJIdVZacnZlRDc4WjNCajBlSXFja0YvT21tT2dn?=
 =?utf-8?B?czVlcnZSSUhoNXpYaUszaXQ5aTBNa0JXbnFKSFpDNURIN2JzUlZkVHRINWZV?=
 =?utf-8?B?czdGcVZuY0V5RENPb1pGZkFTTk5Ta1hodG13ZzByWENick9IKzdOL2hnYjhR?=
 =?utf-8?B?OUk2em5uRjRRRVNKWTMycWIyR0Yza0gvVnRZUlNkc0h6KzkvcWJPZC9md1RT?=
 =?utf-8?B?VDVBRmNQS2Rzdi94U2c0REJ0SzhNZUdVc2l3ZmNYNHVnMENLVTNham5rdEFy?=
 =?utf-8?B?QTF2NE9PSkIrUlpXQjlUTFhoaUQyYjh0NHV2T3JhK0l2WnlnOWVwZlcwbElh?=
 =?utf-8?B?b1hsa2N3UEp1Y0xzUXd5SURGdDg0MUUxQ1JNZ1VMZWVTY2J4YUJvRzJsZjZk?=
 =?utf-8?B?QjNnQ3hHM0hDaWNRRkJKTFFFb3RrbEhHd1hkS2Y0YkY4dk5UdDB3ZE1wZWtI?=
 =?utf-8?B?VjE3NVZJUjI4TCsyOFZDa0p1QjVJY2NrWkVTRGh5Z0pseE9FcHBYUHJaQ0dy?=
 =?utf-8?B?ZkxRQ0dHNHQrZXl1VDZoZVQ4VU5UZkswSU1BRGNxbVFYOGdoWnpTakpMbTFt?=
 =?utf-8?B?VjRMTGNkbEJVVU82TnAxR3o5d28vL285QzFsNjZLWWoyZUpmbmRCR1RkWHhU?=
 =?utf-8?B?ZURZemVPNGtNeG8vT0FoQU5JMjNhd0hPa3dsYXpLTnk2VUhUaVZ0OGhERm1r?=
 =?utf-8?Q?+jd8Ev2r9hk=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?SHBzdUlJUUdFRWdpdzhqbVY3eGJrVEdTeHJ6SDZZbThiSGVmYjFsYkdMOVgy?=
 =?utf-8?B?Qk1MbGNPamJTN2N2bXdCTWdMMDlzOWIrNFNVWi9lMEhvclBsQ3VGNkV5d0Z4?=
 =?utf-8?B?aTBDbWEzd2VCWWJCVkdNNHBJRW1YZ1hha3BRNHBoVGgzdk9PYW82d3Zsd2ds?=
 =?utf-8?B?QTJNbE9BekNQUWEramhqc1NLWWtWUnNNYmVBYlVlZmI4eHJKQ3lXMHp2Vmow?=
 =?utf-8?B?NEJkeHE5d3F3NlptRkhKb1NkMWV4WitVNEFKUUVUNHFrazQvYndBYnJYWEdD?=
 =?utf-8?B?M0hkS2gzREpSRjhYVjE1UjFvL2dEWXN3dXVlN3lpOWZsdVV5UlowaWZJZTJz?=
 =?utf-8?B?SDVoZ1lkR241WGFhdEUxdDE4QThTVHdjZTBmbWF1WTZEVWlEUXJiSHMvbWFi?=
 =?utf-8?B?Z2V5ZGZnL0lIQjFPMis3UC9NMUkxM1dBUzdpRFhQNUduenJjWXBYSUNna1VS?=
 =?utf-8?B?cExwU2E2Rjc0ZW1SRys2ZTdYcTRTSGJrWnI0OUlpRWppUWY2M25qNU9DbWlK?=
 =?utf-8?B?QW9HYlRVdE41bE5GNkFGbS9xQWsyVVlrcG1JSURHUUd3d3FXVThZeHdTUmlm?=
 =?utf-8?B?RnN6NFhxaldEaXlRRDVQSHdvbHpXdEJOd3F4UGUwSjRqWjZtVlU4TnRMYW51?=
 =?utf-8?B?TG1PMnQ2OW9NcE5FeXFadVFSbVQ3RnlDdWQ5S05pVG5ITUUxbXgwb05aa0R3?=
 =?utf-8?B?UzFOV2JrbHJ0TmdKRVNJWHRONzhQMkwxbGZiYUdZWFNsWHRJdEZhekwraWwv?=
 =?utf-8?B?NExYUjBIbi9Ub1ZEc3k3dU1CaFBSQkNlcGhvU1dCS3hmVnVkZTVqL3lLM0J2?=
 =?utf-8?B?WmgxeFBiVWFPcEhsTlhZcURCMkVuUW84SWNkM3VRNXZDKy9QaDdDRmhBWjdl?=
 =?utf-8?B?UGtTcWZDOFZaendmWFNaVlpIS0xLSEdpZUF3YVVvbitpekcrcHd3TE1CMCtQ?=
 =?utf-8?B?QlI5U1lvRTRCZE1qaWhHOXM0U0xWVU5XRS90c2ZJVStVSTNxVitWcW9ZNTBh?=
 =?utf-8?B?VStwcXhCbWZyaUROUmVNYm9TY3gvTEVwWmw2K0tHdzdUVXpQbGk4YzhIWTdP?=
 =?utf-8?B?U2sxSXdwVlhCRWJYa3V5L3VLMkJUOFZ1Z01uN00rY0IvTEROS0JhQjcrdEpm?=
 =?utf-8?B?S2RHc1NvN01BTEtBTjJwbnh0eDR6T1RUUEQ0WUJVc2NKYlppSm4wZGtudzNU?=
 =?utf-8?B?WDV0bDY0MDFBM25vZ21mUzZ4bTZmdWZvMWRDYmhJbjNwZkExYWwzMm1HUEhI?=
 =?utf-8?B?ZGNoN1NGb29DV3U3RFZqdTZ1VzRTeHJMK3JpT3JwNXI0MzRWWVJKMkdGNEox?=
 =?utf-8?B?MFphUzJOREtjclp5REtLSkFkSlJPcG1sRVRsN0xtZ3lrdGtzbFp6K3ltd0VC?=
 =?utf-8?B?TmFxVFExR0xWUmtOQi9jQ3o5cW5vNjJ0SU9CR3ZGdVU4cHFDaUNsaFREMko3?=
 =?utf-8?B?VjVUTGZEc3ZQbWVoU2ErOXRkTitKait5YWpDeWwyam4xQjFma3ZIb1c2U3Zr?=
 =?utf-8?B?Y203bDlCcTNpQWoyMG52OWJ6S1RIdXZrSkRyLzdsQ0d1U3ZmV3JuWFZWTnpy?=
 =?utf-8?B?NFBLYUpLTWFQdFdGODZHbEowTlJqYlNLaDVHdUF6NmQ4OG4zNGJiZ29uVVBU?=
 =?utf-8?B?K0FWcWFHZ25wK3BsVkFrSlZBWUFhZER2U0d5TlU1NkhLQ0ttT2hPcTc5UHRj?=
 =?utf-8?B?M0ZiNjFmSDdGZjNKUURxVlF2MHFVVnh6WjhlYXUwQXJld3RTT3FtL1E4aVIx?=
 =?utf-8?B?R3JMYURBN3d4bkpCVE04YzdTZUR5VUlvQmMzT3ZRdmZ1SVY4ZWJKREVGNnVr?=
 =?utf-8?B?Si9aSzlHOUh4QnBOUWJUdGpqbVlXK2txa0cvT0k0MHJRZmdDbzV3eXBLRmxj?=
 =?utf-8?B?c1RGUEhIeE1STGdUTFFyMFBkcGV4Qi9Ldk96NFJRTmNqMTU4aEpzZUxTN3hW?=
 =?utf-8?B?ZGFNL3Q4WVV5MW0zd3diZlVGQzRqNFREQkNwSlBLUlZsOFpTMVliQXc4RlV6?=
 =?utf-8?B?eEk3bjNvOTIzZ2xxR3IyZ0ZBSXl2d0RRNWIzWG5MZk4reW9PaTVhL0EzbGlB?=
 =?utf-8?B?SURpRW04NUdBQ2pqSFRzRkRaNTVCZ05nS1ZBdllnOFNZTnM1WENvMjNXMGI1?=
 =?utf-8?B?dU82RWQ0Zk1Jakc5aTZsWkdOdkRyTGpzM2dnTW56V0lHSGs4cC9aazdXbVc5?=
 =?utf-8?B?b2c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	23FmT+oA0nyDXCfIas5jLXfLaV1XmxoJ+s4CMAhxTvAYQkukm8WSUTnjDCyhIszsd4WWVVOWangv9fKID8a7WEm5UpjRg5UUwhmqgU2p1OmqfwrEnaFIiB1g+jz2HaDOv6xr21F7Ee6BnAqVNM96RL/MUmG4/5RKu9Lyc53hWgJXOQY5ROh4H7wNG5UQyICpjuiO1jEK7c/z1llUpIQfId3EQujuupsVFPJcYEMpdr+taLShIt719KUZcXT1S8OnC/yh/wHX/troTBkueLpD3TaOmMWHm6n1TeaPyAGmU4VNF5824itQbbGWpuFHAw3QQm3ohlbBzgi4+zZChY9g8jI9FMzaHevLMVEiltRc9bajeoCClFj/XM21G2dpzF18TIByaDHIXTbFhMMnneB+3MIhiS7qEVxC8UnKeh1vYhN5ZQ6qR2NOXXskfvcmXRX4+0hj+9rN21+LDrq3Gr5dB38HrpBeOLH/D6892qF1zapc5ehbgZZJQGBQoYx3QcqAbkWu0YLqVwlOiS8Qp9oM801ON7FwrFD+unTvuZ1f4X/Sl7TV0D+vd+v8lCHBY6qnEfj80K3BqWpIVB3eV7dK/X32dxlOoz5FfU5sZtkIlRY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9e17ec4-2f26-41c2-049a-08ddd35f75e7
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2025 14:01:51.3125
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w2xcIH52+yYhPlhXBy+YGFLQIE6c/CDiwx+XoZhlgSZAglpQzp0iAPxc1tQJsoMQdRRKgbphR+Sc18U6Xmo8Xw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6744
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-04_06,2025-08-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0
 mlxlogscore=920 suspectscore=0 malwarescore=0 phishscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2508040077
X-Proofpoint-GUID: UKhRBvCepo41EKag8tbkBQCls9bMMbxA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA0MDA3NyBTYWx0ZWRfX61O74vDYutxV
 jWLt2Jl5bCC7QTZspP4eVBunC12KbWuEFIG+sjpoUHjNSED6PyPzdBSlkw9QG4DeWfJ/1VpveLx
 frQiPoYt6mp2pkYZbc/dCq8zZgHSPg/DoSeAIaEJZXJemq5J7so0DmSCF9Cp8OT1chKibS3/gz7
 ckX+uKan8ZEKEBKk5XbbqGF8PRduuaRi9NfjhC7zVpzHNFzighz2eqF7CFNkCDQoCGI128UU5st
 0rJH8/ZkfApgg0S6lnZ5FVSqE4pkCUAmZulXOEz3X3NZtzYnf2Tl8H2ttIqfSYdiA5W7Z4hTekv
 LExSctYRvFWba+gx14iOpyWfBpf3EkTSJ7OqTswPCfpZgFqNI+rQfXituT68EGSCVRrjFfwH1ih
 wb0486irdW3WM9hrYeB3DlrM4gTOlBQ4kALeivnl+/vnYaP+4v+UZsq/RoLQyyAfkUtazS3F
X-Proofpoint-ORIG-GUID: UKhRBvCepo41EKag8tbkBQCls9bMMbxA
X-Authority-Analysis: v=2.4 cv=FIobx/os c=1 sm=1 tr=0 ts=6890bd56 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=GvXlNLznAsv2ApiACwwA:9
 a=QEXdDO2ut3YA:10 cc=ntf awl=host:12065

On 8/3/25 5:24 PM, Eric Biggers wrote:
> Since the Linux kernel's sprintf() has conversion to hex built-in via
> "%*phN", delete md5_to_hex() and just use that.  Also add an explicit
> array bound to the dname parameter of nfs4_make_rec_clidname() to make
> its size clear.  No functional change.
> 
> Signed-off-by: Eric Biggers <ebiggers@kernel.org>
> ---
>  fs/nfsd/nfs4recover.c | 18 ++----------------
>  1 file changed, 2 insertions(+), 16 deletions(-)
> 
> diff --git a/fs/nfsd/nfs4recover.c b/fs/nfsd/nfs4recover.c
> index 2231192ec33f5..54f5e5392ef9d 100644
> --- a/fs/nfsd/nfs4recover.c
> +++ b/fs/nfsd/nfs4recover.c
> @@ -90,26 +90,12 @@ static void
>  nfs4_reset_creds(const struct cred *original)
>  {
>  	put_cred(revert_creds(original));
>  }
>  
> -static void
> -md5_to_hex(char *out, char *md5)
> -{
> -	int i;
> -
> -	for (i=0; i<16; i++) {
> -		unsigned char c = md5[i];
> -
> -		*out++ = '0' + ((c&0xf0)>>4) + (c>=0xa0)*('a'-'9'-1);
> -		*out++ = '0' + (c&0x0f) + ((c&0x0f)>=0x0a)*('a'-'9'-1);
> -	}
> -	*out = '\0';
> -}
> -
>  static int
> -nfs4_make_rec_clidname(char *dname, const struct xdr_netobj *clname)
> +nfs4_make_rec_clidname(char dname[HEXDIR_LEN], const struct xdr_netobj *clname)
>  {
>  	struct xdr_netobj cksum;
>  	struct crypto_shash *tfm;
>  	int status;
>  
> @@ -131,11 +117,11 @@ nfs4_make_rec_clidname(char *dname, const struct xdr_netobj *clname)
>  	status = crypto_shash_tfm_digest(tfm, clname->data, clname->len,
>  					 cksum.data);
>  	if (status)
>  		goto out;
>  
> -	md5_to_hex(dname, cksum.data);
> +	sprintf(dname, "%*phN", 16, cksum.data);

Hello Eric,

Can the raw "16" be replaced with "HEXDIR_LEN / 2" ?


>  	status = 0;
>  out:
>  	kfree(cksum.data);
>  	crypto_free_shash(tfm);
> 
> base-commit: 186f3edfdd41f2ae87fc40a9ccba52a3bf930994


-- 
Chuck Lever

