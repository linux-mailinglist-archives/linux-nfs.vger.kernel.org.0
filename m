Return-Path: <linux-nfs+bounces-9537-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C2C7A1A5D5
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Jan 2025 15:37:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4E2E3AB2D1
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Jan 2025 14:37:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6A8220F08C;
	Thu, 23 Jan 2025 14:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="bgNs69C6";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="RaYbaI9w"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6AF21CA8D;
	Thu, 23 Jan 2025 14:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737643049; cv=fail; b=J6zEmaLJyfvQjuuCyZy/CMLnmtMtk0+TsBl2fNcG9zvmlF8egxYY8JQ9v13NBWSdfxGO6/oBo8C+TwZuQqsNbo6+KtJMZywxmFBHEEdn+6cw4QlGjj7rZ5CxI1eVPUGa3Etr4CMFR1VdQKedkEEMLlBgS/DRmgMMpGeywXf4AYg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737643049; c=relaxed/simple;
	bh=7x5JqpETD8VbQWTaY2wV3Ki0/ez8cJpwSciseUFoWUI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VzByYh56KViWs9wpTG6bMM65Fhr7ebchWZeFCLXvs3ePlCgRNkwsfGOYiYdUnh5pFZ1YXPwnYNOm2olxlIpvtXM/wsaYMRMYFz0qU7GoqJUMCdaMXy1kBq/EpNj51NXHyPyaXm5qrtbZYf62BEUeay73gxf5ixpi1GmDsKU9iDI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=bgNs69C6; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=RaYbaI9w; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50NDaM2c030496;
	Thu, 23 Jan 2025 14:37:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=oVTK24LlT2kqekRBYLAACq5qLirdXZaNOEXFgwtn81k=; b=
	bgNs69C6wzitU4jKwiXmUsjau6fVzTBB4+DvS5StqcBjoyL+CFVad47J8WSjL0/9
	GViv1KyU/j73d3gcD4iwMidIaHby2MFIH2xh548hoQS65qWMg/F8JyBex0hE5DFq
	bbu5kt7Xww3MNIjHHfxk0oop+mVqcgNQXEIhCpliMQnGGgz81gq7bMA06/zbktos
	KegYVzQIgfo4xQjrTVPY0WsasWseQ0i6YPEfP/Hwv3NAK79Riaj78r0rhy+8Vk4m
	tPsAJd28XV7fgP6fzw1YXUd+cmpNWL12BFfHU1MkXcvQ0FDLlLcFFDmhXkGzOmo+
	Ayoem/Im5P8IcpK7pLVirg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44b96ah81g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Jan 2025 14:37:19 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 50NEF3bR029761;
	Thu, 23 Jan 2025 14:37:18 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2175.outbound.protection.outlook.com [104.47.55.175])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4491fmjgx2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Jan 2025 14:37:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uBLBmzpQhukKuPHL9YtZkOWV8X9f5NNF6C+jQWZeJMiLDlKVoHlx0K6bpfsuBxjtUWiun+8vpMi8d1L8U+sBdhtWZ1v4eJ69eHGsHyflVcvUNY81A0BkV4FbcccTuKXxsCVr0hnorJfPNA32CS/VQhLCtp9ULu09d6rtGzFbMXr1+nha4YwptR3x8Mu4L50EGgPm1OFh/OCi96/pHf3UPE9Q+T5Usa8VP7UGkBAYJsTcnV2DEXyxXOonhAhQRwPtHA82kZZzvag8MX1FRfAKx3Km+q9dzhw/UJiMX9q/m/75bG7bmkyHHAt0r6PvH2XyRo06d/4ksmTJ/UbjiN2uSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oVTK24LlT2kqekRBYLAACq5qLirdXZaNOEXFgwtn81k=;
 b=bMW9A6s0uJlzl5TwkQZC2mD5wRC2m7lfjcdaDmj4R1CnahbyvTgQjjES6ut8nowFZ4oVsIBb3Xd/P+0/ansf4IE7KwMy6P6mqXQBLN1DesMGvZ5c3kH+3E2YIpHeB7WPw9eSvCMsWdmrv7t7ufrqHCgJMi/9OLBnmimxWyypUYTRdHmM0x+ySmlJy1nKlZ/kqWOoihFsRUPGJt3jL/KF0NPUIq2eAERl4wC270jP+c6jfLbS++PquWGlWIqj+VDFRKPeb4JBxCfOqIZqYsUogC7CgSKUAZSzrvwgbujsk2KuXMPO6lIMFjH8zthjTI4mqsfn39Yhgkpu6v3ZdXsH8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oVTK24LlT2kqekRBYLAACq5qLirdXZaNOEXFgwtn81k=;
 b=RaYbaI9wYnWxmH+ox9kRRVSAKrEVeLKpEsq28CvBsQiQUeJVg0+dVJzdLXlOQSl/JF8HYRetFv5V/XyUptre/mR6JbYL2Z/URSxSaCKcfTRsQhx00H8qia/qcMOBmdV+GavHmiQgKoS/SlaVvGZCAY2oGbwM2pT7LqYq0vpGNTg=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DS0PR10MB6200.namprd10.prod.outlook.com (2603:10b6:8:c0::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.21; Thu, 23 Jan
 2025 14:37:15 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%3]) with mapi id 15.20.8356.020; Thu, 23 Jan 2025
 14:37:15 +0000
Message-ID: <5e3f1c01-8e3f-4a18-86b4-c9494d71f30a@oracle.com>
Date: Thu, 23 Jan 2025 09:37:13 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nfsd: always handle RPC_SIGNALLED earlier in
 nfsd4_cb_sequence_done()
To: Jeff Layton <jlayton@kernel.org>, Neil Brown <neilb@suse.de>,
        Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250122-nfsd-6-14-v1-1-6e1fb49ac545@kernel.org>
 <e85a0515-7972-4428-9270-a982073adcb4@oracle.com>
 <6196ed07e6db1bf664d2f10280cbe0e80857583e.camel@kernel.org>
 <84527e1a-a163-49b3-8335-a551c2822929@oracle.com>
 <833c69c167a14aa25592f043a61f107ade0826db.camel@kernel.org>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <833c69c167a14aa25592f043a61f107ade0826db.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH5PR05CA0009.namprd05.prod.outlook.com
 (2603:10b6:610:1f0::15) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|DS0PR10MB6200:EE_
X-MS-Office365-Filtering-Correlation-Id: 39525335-dbc3-4ebf-7456-08dd3bbb6e4b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SERpNlN1Y2xzRHNiald4clhnS21yOFFNK2p0VjdaWmR6U2pUelp4Njd5TUVD?=
 =?utf-8?B?QmozalZQWURwd3ExeGwzVnptODdnTDBKY0l0VkxhYWFYUlFSZi9TV1dVVjl2?=
 =?utf-8?B?YnQreGdSR1liSW5LS3dXa3RCUGJxMHZodEJ1L04yV0o4SkI4VEtuaWE0bzQw?=
 =?utf-8?B?REpDSXFkL3pFNmk0RXpzS2t2bElqNWI5bXEzdFQ2VjVqdkJHVVY0QVhWZnlO?=
 =?utf-8?B?WDBXUlN6OWZ2VHMxMThyZlViZ0JBSWszcC91ak5HdTJVVzczTTF2U1JHaWVW?=
 =?utf-8?B?MHZrU3NSUStheWkrMDhkUVpJNUovOGlHM2w1d1BYYitTZVduaXZ1TWkyd3c4?=
 =?utf-8?B?WWpIMTRVTjVHUVg0UTZoVXZhRE1IS2hkaGc2akQyYVJ6ZlJ5MkpkYzhzeDFl?=
 =?utf-8?B?WjY3WmdHdlF4azNVY0JtdEdPK29oV0lKMFRkRXBTWktMT2p2dnQ1Q2ZkZjIv?=
 =?utf-8?B?WXlKYlkxV2kvWWJ5RkRVaFRCRkNSejQ2UWN0bFBUMTM0elZMZXZmcGhDSmFp?=
 =?utf-8?B?b3hqWHVxT0xaWVBJTGkyUEFtcGFya2ZvWGs2TDU5WE9uTDVudzVhLzFVQmdi?=
 =?utf-8?B?bU02M04zK1czVVdEREhCN1ZBMzdEZDEvTmhoWkt3bngvMkZkMDFIb25HaHow?=
 =?utf-8?B?NmlQdWxrT3N4OHFZSURNTVJaZjZmSjJqTVp1ZkszMnc1UHpPTkF5TTdKVnJV?=
 =?utf-8?B?azVqVVZWQ2JtbDBlT29tZGtxWjNVbGg5aGpVWUFob2Uxd3FtdWZXVmZCYUJ6?=
 =?utf-8?B?ZzhaenErQ3R0KzhYVk5zN0E0K1pJT1RCQXBtV1dWbEtrZWJjSTZQQ2o2ZlM0?=
 =?utf-8?B?eFNzSzltZWRXYXYzcWIwd0hHbWFOV2Zma1FyRGlvN0cyWVR5TjB0QW1kbW43?=
 =?utf-8?B?NFpWakR6c3JPOE9Ma0lSanZTQUxHb0k1bGJ0c2Jpc0R1OHdBOGRtS0p0ZkZN?=
 =?utf-8?B?Q0tiekpwZTBGRHM3Sml2SmhSY0c1a2FBNzNEMFBEbjUvOTFEWWxIY1MwS1kr?=
 =?utf-8?B?cnFjWkxpQ2tyOTBhN3JnVThmWHNhVVo5NzVTSHJoY0JGTFVUMnBOdGM2aHA3?=
 =?utf-8?B?RVJOM2pqa0tBVWNuaEk4c1IrUXo3YWdGTG9ZTm14YWZSN01KdHhwaWljd1E1?=
 =?utf-8?B?Q3VPRkFwWkFyeWhPc0EweUwzV2pjaUhDQTFFYlNlckNhUzhWcDg3ZmIvbHA0?=
 =?utf-8?B?d2ZNTVdrUFg0NEUweVVNaUF2cTRITXhScEhDRXY0VzhhK3BnMnFudUpwZm1n?=
 =?utf-8?B?WUd2THZHN0w4bkNpM2lNU0I2ZU4zNjkyY29pZTRiNHZsazc2ekhCK3p0NzJp?=
 =?utf-8?B?YkZ1YVNYYnJGVlRqNUliQlJPdlBscHZ5blFtSE8rZ3hkTC9NMGthWnJlNDFR?=
 =?utf-8?B?STM5VjBieTRLaEg5MmtrTXExNHd4alBZQjh3Q2V2ZjVmdnRHM2hpM3pxSHRs?=
 =?utf-8?B?b2JSZksyd2twdFhLcy82ZFNLckhGNXJCcHRsR0tWc29jYzY5UngvbnNJVHNx?=
 =?utf-8?B?Y09VS0w2WEh2T0h4NWhTcEJ5M05VUW1jTS9MYzZPS1BGSUZKSzFwTmF4Tzc2?=
 =?utf-8?B?OW9sTG1WcXlPREQyV3crZlliZXRpcERUUjFzMTJRMkRxUzRsVG1qSTZIY1hG?=
 =?utf-8?B?aWhsSEtJNGF4YlVEOHlSYXI2TmNQS2hMY0RqRERnRkI1d3FUaWNWamhNUUll?=
 =?utf-8?B?M0lId05HZ1JEOXBNRWYzOFdUQXJuZWFMWEw4Nk1YWFZYVW1YWE1EWjh3YWpr?=
 =?utf-8?B?aFliMnBWNTNxUWRKTEtaLytreGlMQ0x5Nk13d2RDNEZWMHgwSFRpSDFKc0E5?=
 =?utf-8?B?c0JER2l3M04vZTdZVDRPWHRlcUdpeEV5SFg3ZHQ5eXkxZ3JJM0xMQTNFTFpt?=
 =?utf-8?Q?n6gx78PKkvnSl?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z0Fmb3o5NlZkVkFsZ0FvVHQvZVFSWEhzcG13NzZSRlBOVTRmTlpMSVk1OG9H?=
 =?utf-8?B?UTArKzIzaGk2YkdxaVpRSUVOb1hJeitSMUNJbUl2cGlQa3FCRUlFcnErNnZE?=
 =?utf-8?B?TWpTQS9yYzhzWnNXNTJtcVpoSVJhZ2dOQjZOT25KWUpnU2llL3JXTFpDUVhl?=
 =?utf-8?B?bkh5YjRrQndsejA0U2h1Z0lRTVhxdGZ1aXpMa3VWRmdoM0hLdDN0L2xZdFpZ?=
 =?utf-8?B?emFIOEpBTGVOMk4rdVczK3hLSTFpMEwwakR2M2lNdEhiZEt6UHdWR3V2a3R1?=
 =?utf-8?B?YWt0NXhRaTVSTFBicHIxbHBmNDFZM245NVZ0UG9GWElkVW1GZVQ1YjVXRFAz?=
 =?utf-8?B?eXovRm5UcktDcG9taWFObi9kM1k0ekV3dS9wWUQzMDc5a3RGTTdyVU9FY3JF?=
 =?utf-8?B?LzdoQUNwdmpEZytla3dsZjVIbEJHMGw0dFc3Y2JrQmppMXB5V05rZ3FHNDJL?=
 =?utf-8?B?ZEtyaTNLSGdpQ0xYbE1qZW1HelZxcGEwMEVWaUdZTEpyZTVQb25FTnZjeXBh?=
 =?utf-8?B?VXBzNUFTYTVGelVaOU9uUGRnQzVLaFExb2ZOcXVSOWNra3JYWHhUTmtMWDVO?=
 =?utf-8?B?ZWNmRnBnSythZnJxM0dadCtlRXQwbDVic0IvdXR0Mnd3eXZqc0F3TGpLS21y?=
 =?utf-8?B?RGF3b3kvSHpQOVRnbGdSS0NlYy9LekpOb2Y2VndPQVdRMm5iMDA1V28zRVVw?=
 =?utf-8?B?UXc3UGs4bVhhVUxlVkxFTkpaWGJ5ZytaVHlKb3J2NjBzUzIwdG9tWk9hR2RI?=
 =?utf-8?B?OHJycC9PUHlkL012MEVjS3RKRkVoQ2c3cWExcnFkN0dsRytDNU9xQ3ZUK2Ex?=
 =?utf-8?B?TUI4UGRRL0VLeDZ5Z0k5QS80VkNqZGNzYWc1WHFjWlFIaFpnRjREWVI5SFhx?=
 =?utf-8?B?dWRoekdxR01UMmc3enlOMm0zWU5HQW92TXpNbDdtTnR4cEh3ZlJqUk9rS3dk?=
 =?utf-8?B?bCtpdWo4aWxOTDFQaFdPOHVKT3JGUTJZUldPT1FGQklMVllObWpCM2Z3anU5?=
 =?utf-8?B?V1IwV1BzVWZ2NXluS0pmdGFvYjZ6YnJZRUo2eVJhRnh3NU5Od29pdURYalU4?=
 =?utf-8?B?RDc5cUlCOS9jblg3N1pVN2pVKy84UklQVjVWNTludExqeGkvUnJHOFhoQU5m?=
 =?utf-8?B?cGZ1aTJzZ205cWljNEpaRHVXa24xbFJuWW1MR3NLV2JYUnpWWXk1SnkyNzAz?=
 =?utf-8?B?QXM5dnk0anpwZjNNZE5rTXV1M2FkNE5odFBBNkJlR3VVKzlXcEdYbFhsdVBx?=
 =?utf-8?B?T3UybEdLd2lyOUhpYTVoRU02V1RKR04vRGd2MmhuRXp0eG55TnN6a24wV29v?=
 =?utf-8?B?b29LcE44TTAyamN6WWxNOVFsTTlIeS9YeTV4cEsyS3NaZVhZNnp5MHlvdi85?=
 =?utf-8?B?OExYYlBpa2hEcW92N3FMNUMwK1hJT0lJMmtCaUVVZlV6bGY5QXdBQ0ZwK21p?=
 =?utf-8?B?T2JnUGFyRWJhU1J6djNWdFZIY1hKb0ZkbUhEL1BOcHFrWFF5ZnJZMkpPdTRk?=
 =?utf-8?B?OVFyQzQ1Z0IxaGZDZE9kRmJyRXZnNndqOGl0T3NUc3hZWHBXWlJ4cGVzVEFz?=
 =?utf-8?B?aHBXSENuSXpOUVkvQ1dyOGlmWXF0QXl5T0lNbkpyUmpLekxnTUh6dG1JTEFX?=
 =?utf-8?B?cm5IcmJIcmxzV2pTWmpSNU9tVTBtRGhNdDh5Y0pSdTBvYTF6Y25ibXR4THpN?=
 =?utf-8?B?R3dQWElCOU9vOWowOTJZTWVJZzhoU3NBclp4MXV4QmNRaGJaSkRZY095RDVK?=
 =?utf-8?B?NnRUS3Nhb0ZGTVF0ckxDN0RrSnlCT3ozYm1UZXIvTjQ1MFFxZ0ZsalRoMC90?=
 =?utf-8?B?d1I3ZkFyMTBReUg1VlpEajNUY1V1YmhBVW5iZTcyOFU4ZzE4eDBTN1FVNFRX?=
 =?utf-8?B?SnlXS3UzRHNXM2p6ZWQ1ZHRxNGhvNWJoalVOMnRZRTNJb0ZDNVg2dzVsTHB2?=
 =?utf-8?B?K2dTSGVXQVgyOGg0MkN4OUFRWUEvY0k1UEROMWpsZXBISVlyNXdOT0M1OCtD?=
 =?utf-8?B?ZS9YdzltWDk3L2hyV3h3ckVqOEVFSGliSzVhYjhpU1dqbjZFVDhEcytoTHdz?=
 =?utf-8?B?cGRyWmQyMGl3TTBzZ3ZGQkVQKzNsOU51MmhNL0pPdHlvZi9QaCtuU2tldEZO?=
 =?utf-8?B?UTRHVFVudUZxRXROYzR0TW8remNWNFA5VEp1cnZWVEFUcUtlc2JjTk1Rd2Jp?=
 =?utf-8?B?ZVE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	5n+LcvZkl6u6f4DO7gJTCcatofKYU1i2n2vN7yhOSq0P0U3C2TfKz+KOwyQTzB+waqGSWnkmk+IqvfBNIEQLNhCaJxAOM4ZjmreMLOGJhnaflj9GE5a5irqH5MFheHe/aTeXYTC3uoFW0+3cwl3udcj1N/dOJkDAX0sL3Z+atqQKg5w19i2sNLPbE0TujObaauUtJnubVz2kQkjV7MhiqAQHB7mWzsisgPBbKWkQUfAP242MSAv+rsZD938cE4efOyuIELHpkLZ7AEHZYDaLdUEapP5Dyv8fofSjNQQ9dwrEkTFeYaN68zpL3sbDjyqfZy8E7vDngShcacCgqj7uUOG/7Ma1b7NxL80Sa4mYBEWtMcFO46Ag8x4/4Fowl0DuJnO1/COI4IlukPyKmnmqPPNUJV5mu3N/FBS9Y+6A7O2WzObSxwZAvTOp3juzrc+jRnnCYZE0ar96/5KaBVukJfHXtt+zhKQZTuiDWxjsBMchtiHOjiFBQ3kJgKjqQZ1pjmECtZOp5ALNlUJ8fEsZZyPxDiwBaS7sZ0OfJdnVM/jH62aCT1fuHUYCdsFT8XrvH42wqLbzy9JcTtMu4s+bNzE+2QWbDsQb2ABXA3rUndM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39525335-dbc3-4ebf-7456-08dd3bbb6e4b
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2025 14:37:15.4785
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qjtMUWcsUmk61yULA2JIJN0wPxLTkElo6W7Pw4yOIYyH9i9EJI2A/22lO5GZSw+jF3eyQvLIeYw1IjSG3DKJEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6200
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-23_06,2025-01-23_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 bulkscore=0
 malwarescore=0 mlxscore=0 mlxlogscore=999 adultscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2411120000 definitions=main-2501230109
X-Proofpoint-GUID: 3y_IGDFV-J5xux82tVNaen0gJ2p7eVbp
X-Proofpoint-ORIG-GUID: 3y_IGDFV-J5xux82tVNaen0gJ2p7eVbp

On 1/22/25 11:50 AM, Jeff Layton wrote:
> On Wed, 2025-01-22 at 11:06 -0500, Chuck Lever wrote:
>> On 1/22/25 10:44 AM, Jeff Layton wrote:
>>> On Wed, 2025-01-22 at 10:20 -0500, Chuck Lever wrote:
>>>> On 1/22/25 10:10 AM, Jeff Layton wrote:
>>>>> The v4.0 client always restarts the callback when the connection is shut
>>>>> down (which is indicated by RPC_SIGNALLED()). The RPC is then requeued
>>>>> and the result eventually should complete (or be aborted).
>>>>>
>>>>> The v4.1 code instead processes the result and only later decides to
>>>>> restart the call. Even more problematic is the fact that it releases the
>>>>> slot beforehand. The restarted call may get a new slot, which would
>>>>> could break DRC handling.
>>>>
>>>> "break DRC handling" -- I'd like to understand this.
>>>>
>>>> NFSD always sets cachethis to false in CB_SEQUENCE, so there is no DRC
>>>> for these operations. The only thing the client saves is the slot
>>>> sequence number IIUC.
>>>>
>>>> Is retrying an uncached operation via a different slot a problem?
>>>>
>>>
>>> Ahh, I missed that we always set cachethis to false. So, there is
>>> probably now a problem with the DRC after all. Still, I don't see a
>>> good argument for processing the CB_SEQUENCE result, when we intend to
>>> retransmit the call anyway.
>>
>> I expect that the rationale is that the slot sequence number needs to be
>> advanced appropriately before the slot can be used again.
> 
> Once RPC_SIGNALLED returns true, the callback code can either trust the
> result of the rpc_task or not. If it's going to trust that result, then
> there is no need to restart the call.
> 
> If it's not going to trust it, then the RPC call might as well have not
> happened, and there is no need to increment the slot sequence number or
> do anything else.
> 
> Is my understanding wrong here?

It might be.

The callback client is careful to initialize cb_seq_status to 1 before
it sends the RPC call. Thus if cb_seq_status is any value other than 1
in nfsd4_cb_sequence_done(), that means an RPC reply was received
successfully and the XDR decoder was successful.

RPC_SIGNALLED doesn't have anything to do with whether a reply arrived
or can be trusted.

nfsd4_cb_sequence_done() needs to process the reply unconditionally,
otherwise the server and client will disagree on the slot sequence
number for that slot.

-- 
Chuck Lever

