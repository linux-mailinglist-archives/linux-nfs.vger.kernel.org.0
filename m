Return-Path: <linux-nfs+bounces-10656-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 751B9A67893
	for <lists+linux-nfs@lfdr.de>; Tue, 18 Mar 2025 17:00:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D622017B1DC
	for <lists+linux-nfs@lfdr.de>; Tue, 18 Mar 2025 16:00:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7683120FAB0;
	Tue, 18 Mar 2025 16:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="oyjwR/KU";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="JqzqeGh+"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DEF1210F49
	for <linux-nfs@vger.kernel.org>; Tue, 18 Mar 2025 15:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742313601; cv=fail; b=cZ9UOndSU41V4D/yD9CeNc4dKJ5OtsLCpcewkuxJh5Pw9TtRQdFo+VitFdBKEO/YU43X3h/fCVcmsaTnnX088xw7fGr40ZiF1t0j/+2mbMZQgoI+tKUIwinvYX+5U74yEv/jC/wLzpiCGBvN3+L6uAZCdcMv+Tnlkk4t8UoiExk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742313601; c=relaxed/simple;
	bh=7vQ8TyYXGXIHM0r597h8djPgglS/yGUYQvkVUm3Tv8I=;
	h=Message-ID:Date:Subject:To:References:Cc:From:In-Reply-To:
	 Content-Type:MIME-Version; b=D2Pt4HoZMyiwJyXJqvBHo4Q1dTNaBFtCFKJ2tAytqa8SraG2m+Mt55t4KjNxi7y1/Vh1/GnmGicHkOeo558tuWROWARyhnclHsV2VMcjaJGf/meBcYbCMscFxq6jmZJS747up1AfCd3nCmnBn3G9Oaa3zKcBs95NCuOpdVpFgYg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=oyjwR/KU; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=JqzqeGh+; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52IEfqK0010097;
	Tue, 18 Mar 2025 15:59:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=tOU/282Crg05QBBk2GXEOfEX9RnR+jELiLeZZGjqjyk=; b=
	oyjwR/KUIyLSqUcnmczXPwa+VAmd+fkaZawMz92X42kMAJ8P9mUyvz87eseBkH+l
	uBIr7MrkiBnQAVD4FHnskATrazTERmwwcDT+i71JibEYI72j84JhnYGqXj1HsSYL
	iwLdiKr+hgiR8708+mavKfteyeLxKZRE3FXaYmYSD4wLc4RX2mTSo+ofpKmfnkp4
	hZnSopbK6gpObNIFKu9mC12V/ZZjIqAAyl0Fcygx/Mu+dEKaUo7ePDRbw4Lfs/5v
	UiPK76lBZOvMJO9p0rwPr/jBbij3/+xUp3AqkAzMgO7tDPWD8wI581TR/Zn2n4Go
	2a/EkEvWtq6pdLJd0jS5lQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45d1n8df2j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Mar 2025 15:59:57 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52IF37wU018489;
	Tue, 18 Mar 2025 15:59:57 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2173.outbound.protection.outlook.com [104.47.58.173])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 45dxdk9n9k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Mar 2025 15:59:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RRWhTjtGlAIv3aKVtKyMTifwtAUScxToNIZd7maMEgRKWReF1lLQsSvnOAnLynmsy6sfKn1jt/unnfWdG1/RX9GTHDVd88ytdIaNhHcxqLRscABt9erJLKhMBnD5n+WlsnEQTRHiCDw/gaARh4J8VH2pBHZysksazYN+6P/whgC2si4rDaeXjZ2m0LBmgmmpBG8ofIMfaODE1Io1ile+0d4OUJL7V3Z1dxtWCdWp292tM+MQG5DsV3tFUPvr+NjIdkbatxcw3sNU5L7wgQPGn6pp/Hag4gGdvOjtrEfT/8UC9HIMmZOygfvFQyMuHxtR+vcqe5cfOMOsO+eqVwRlmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tOU/282Crg05QBBk2GXEOfEX9RnR+jELiLeZZGjqjyk=;
 b=RbVr52KN9WhYFlvhsWef7RbM1t96+e+b6v+AB1zVKuOyTmiDaDu+zeM3vcnTppYG8qzontbI0pYkafcblK73FCm5SFd3H1STOFjO3+5lxS2VTG3F/aYN92wDUQ9GdEaF9W9iovkp8G8KN6u18yTzRIxOAlJXWj7q/tXN0lDe+pbO7e43tHGI8DoXL4zhUJGi7HhLVIzT66cvKM6dZKe47okV+iBTiBprkm6AJVsTrfhkhIKmrDhiE8Hsrm/k7oR4FCsCEd7vhOcDALvzNAkugj6x/wYA0cOfA7tMF9dgjXrK3VQtGB+ZP/tnJBoWasXGEVs3EeZ4ijkOfqu+KxNH/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tOU/282Crg05QBBk2GXEOfEX9RnR+jELiLeZZGjqjyk=;
 b=JqzqeGh+RzpwEiRGiQFckUGpb0GEMjNC7A2joyvOsz5G9IlRQTvbWFSUjzzQSZachZMhc3ibM29dzCWO+3XzOevNUo/KeRPorEzgCvaYhwCwEDtM1Vf3paWBNmA1gRtdXUX+vrYkmIjdd61n3U0sUHTuq2CP18mCZtbrjVZqdkQ=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SJ2PR10MB7583.namprd10.prod.outlook.com (2603:10b6:a03:537::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Tue, 18 Mar
 2025 15:59:52 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.8534.031; Tue, 18 Mar 2025
 15:59:52 +0000
Message-ID: <89535c4a-7080-41cc-a0a3-1f66daa9287a@oracle.com>
Date: Tue, 18 Mar 2025 11:59:50 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: Supporting FALLOC_FL_WRITE_ZEROES in NFS4.2 with WRITE_SAME?
To: Takeshi Nishimura <takeshi.nishimura.linux@gmail.com>
References: <CALWcw=EeJ7rePwqv48mf8Se0B5tLE+Qu56pkS-fo0-X0R3DQ=Q@mail.gmail.com>
 <0ea71027-c0cb-436a-8dc7-6f261f0d9e0e@oracle.com>
Content-Language: en-US
Cc: Anna Schumaker <anna.schumaker@oracle.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <0ea71027-c0cb-436a-8dc7-6f261f0d9e0e@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0189.namprd03.prod.outlook.com
 (2603:10b6:610:e4::14) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|SJ2PR10MB7583:EE_
X-MS-Office365-Filtering-Correlation-Id: 8395641e-f3be-47f1-2d21-08dd6635eafa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Mlg2Rmg3ZWpVVzZudEcvcEdtTWJVSEVGNXdORTh6azJsTXl4Q1NzYVZQY1Rm?=
 =?utf-8?B?SUluUitRWm5HNlFqd0d5aFQ0d1FOd09IMVhCeDduUU4zK0dFQVpSeTJDclRw?=
 =?utf-8?B?eW1aLy9VMXJyS1E4UW56Y1BDZHhnaDF1TTBPSzhLc0h5WEpiZVo4VWgxRCsr?=
 =?utf-8?B?SUJZdm1Oamw3d1VIUUdsalh2VmJVSzFRUGwxbUtoQ29jd09GRFhwUEhyb21Y?=
 =?utf-8?B?QVRnMDAyc28wVDNmd1laaXp6b2ttTjVUN3ZPdmdwZXc0MTVsS3BRRTFrUXo3?=
 =?utf-8?B?MGowY05SNCtZRWdSODZUM3ErVDVobGlKRDV0WFNQZVF6Qjg5TnZodmpJcnVS?=
 =?utf-8?B?TzFPMEp5ZWtOY2Z6ajA1RXVnanFaUWxzTWNBNmhPSlJGUk9OdXNHZlVYdm5x?=
 =?utf-8?B?OWU3YlBRMWtuZUgwNHdqeFN6WG96V0RzcUJMcHVjajk3NXpmQ2RhS2tsY0xq?=
 =?utf-8?B?Yy8rbEhJdGxNUFROYkYxU1oxSE40VXV5Uld0UlZUNFJTQzVvSDFEU0R6aUto?=
 =?utf-8?B?U25NclEyK0FlblE2LytOVEZaQ0QzUkpOVmd5eDdkOHFSalFNUC9JTTRTWEV4?=
 =?utf-8?B?cXRCM0h2WXg2Uk1Wc09BWVFjRndSY3RoZHZLQTRycTVoNTErbkhZM2lIcnQw?=
 =?utf-8?B?SGEwcWtoZVZ0QXBHam8yNlN5eVgyNGRzWHgrMnc5YzIrRm90MThQbnVFUWU2?=
 =?utf-8?B?aGtad3krd08wVXZsUFlkRXV4Q0l4emNFWVBXSVhzK0tuRW40SWltS3g5NU42?=
 =?utf-8?B?KzlINWJub3RCMndRWnlsaTBhcWpXOEVBaW90UisrTUdtck03UGFic2RxMHY3?=
 =?utf-8?B?SDZPY0ZoelhnaTZlQmRrYisxSmIwazQybE5FMXptVFVoR0xHSUllaXdFUXRB?=
 =?utf-8?B?K0JIamJCMGl5SmhEaXViVWppcURMMVI4cmlrNzJreUI5dmR0UFpSQVljYllX?=
 =?utf-8?B?RTZYNEU3QlV0Q0ZrMDE0VE50ckhDa1lyMjBNZ0IrekRGUVo5VmFTZnpIcVBV?=
 =?utf-8?B?WlNqVjFHM2JucUxMZkJXSXFnT2d4Z2ZSRmRHNmp1MmVqdHMwUjk0YnluNlRt?=
 =?utf-8?B?WWtxcHhDK1dISXBrbCtyaDNnbS96cktjeEU2TnYwcGU4dG5NVi9YUHcwd2E1?=
 =?utf-8?B?NFg1RVp3QjdudElWMmhLWmxaaytFbXgwQlFrZ3VRbGhndDJ0RTZTK043eEV6?=
 =?utf-8?B?aE9ENjIxWjBEczhnSXdEalRLL3RidEc1OTdhWGxyYXF1S2picFl5NEU4WlFO?=
 =?utf-8?B?aEtMNnFsQlorZ2NIOE93d1AyekNvckxHTVNHUDVlYWwzeDNWOU9LM0sxdEFY?=
 =?utf-8?B?Z1FZMjIyQ0pFYlRNcnpqMWxvazNGb3RpdHlhMTNVMXZKQ1RvZ3ltSG9xQTdW?=
 =?utf-8?B?REFreGtBN21yKzgrUHVyWHlpZk9RNXJnYi9YNjQrbkJQVG4wMGdJdmNQbTN3?=
 =?utf-8?B?T0x2Qmp1R1ZYNThqbmxJVmJQQ3VGV3k2N3pJSzc0b1F4cHBrMnpHRjZiOWVu?=
 =?utf-8?B?bDByYmY2ZVF5T1pXdE1BY0dMMEk5TTdQbnBWYVZsaFFCeVM2M0I3TnI4bk11?=
 =?utf-8?B?U3YrczgybnVDZ2tqR0UvMmlCTUkyZCs1a1ZmY295alFPbXBJSDMxLzJpNU9k?=
 =?utf-8?B?MjJ6QkFCNkFIb2xZSjVYZTc0VXRoREo3M1NGbHJCK3NQL1c5b2o3T3RhcWN6?=
 =?utf-8?B?dnFzWVVIMzRsTXFSelF3TkcrOVMxT0F5ZC82RExMSzV2TW9GMWJhVU94aVp4?=
 =?utf-8?B?N3BWNFRtb2FCdngwbmZZNGx5dEw5cStCcDlCOEQyc1RIQjFNZTllTVUwcUVS?=
 =?utf-8?B?ZVdja3lsejZSWHBFVklNRVdMRUpuS3JPbFNXS0lKdE9sUEhxeEZoaFB4LzVR?=
 =?utf-8?Q?39COshWhE/+kX?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NlVBdXZjTWQ5Nm1QTTlMU2xlcVlwT1JLVmh2Nk93bEl5V3pSakMwVlBnS2J4?=
 =?utf-8?B?RWR4c2dXdklGREFGY01EWkh5Z2dDbjh6MWk1RUhxYWc2MERWdDRWTzhWbnVy?=
 =?utf-8?B?NUhVWFNmaUtURStlaEoyZkMvcXdkUDBYZDJQTnZlQ1owVXoxMTVPck1EbHZu?=
 =?utf-8?B?UmVjN0RoS3liWjNzMTZUNFVDbnEzTjdJRXVPdmNCUVhEQzlhejZrTmhGQ3RS?=
 =?utf-8?B?UnBSWFRlL1Z2eXMrRENvL3EvdnE4K3Zpa2hnSjl4T3hIdDBWOEM5eklnVWpE?=
 =?utf-8?B?RlFRNWh1ZEZsYVVlRGNSbVY1WVpvcGMySy9vc211c1QvbFZuejQrSnVxTVB5?=
 =?utf-8?B?YmVHMmZhZTZqWkdsTnRocVFNRjN1c29GNTV1QlN6clZsWXhiaWJOOFk4V2dV?=
 =?utf-8?B?M1R4UkJFM3pSM3g0UGxaVDlnUkpRMW9YWDQyNldLRldSVDhJcjYzVE9wZUN6?=
 =?utf-8?B?b21PQ2RZUkxLZjd5NWIyd2xZak9ZMk1tNmhZQkgvTjhrU3M4WjBtQm1WQVY2?=
 =?utf-8?B?eXUvWm9hZXhvR091T3pEUHBscWttQnNkOVhRV1RIN3ppWk1RbzBRYlZxNzdX?=
 =?utf-8?B?bDJ3bnhxVU5yMjkvZFVSdE1iM2JpZHFyOE12dm5TMTdDL0Z3UXJpUFZGRDVR?=
 =?utf-8?B?bW9lSXJQRitBdjVLT3VSRG5KWG1McFpsTS9kaHUxM3NsZzBkU2FmZmF0amZS?=
 =?utf-8?B?eGVyRndkVU9mMTRMeVVqMkRUN21jY1M3TlVuNnZpbFo3NGwzb1FxdGhybGE4?=
 =?utf-8?B?WHlqc0Q2bVdkQVY5U3pPVzRQMFFXaGZLMUhHd2doSmRuWFhLNEtFWXhLWU91?=
 =?utf-8?B?SStXMllUak0wZlJXeU1aNGZPdm5uRkQ3K29mUDhhSGw1SmtMN2dkQ0drdnVX?=
 =?utf-8?B?eUhlYjd3S2tLK005TEpoRk83a2NsYUs3Y1R0VnpicHpLSnJQMVVaTndMUDJv?=
 =?utf-8?B?TjNTaThScUNRUnlYN0JRczRQWjBmSEh4bXUxdkNoalYyMFVxWXlXVlZEbnp0?=
 =?utf-8?B?QjRRNW9KU1lwSDREaHdlVEVacFRlQ1FHRFpIb09VVXdPejBPVWJERURrd3lQ?=
 =?utf-8?B?bUFUK3gvRkJnSWo1UDJVVUlFT0dZSkExQ251UXdFczdmMm81QVFxaisxQ0xh?=
 =?utf-8?B?WkxYQ1A2OVlqcUJyeTlBZldlWGx6TU5naUhISHkwRi9zSmlFVkJ1OFZsZE9v?=
 =?utf-8?B?cm5RQTd0bklzWnRUK1Q0WnNIaDhhVHhNYmc1UEhIa0M3SkRaeDlGd2ZBY0V0?=
 =?utf-8?B?WHAwNGRJWFN5SmdQa3hhaEl2S3NOMGtlMW0yaGhuMXlpVTVkVENTU0tKelpt?=
 =?utf-8?B?MnM4UUdxcmVBZTlKSWpVUUVDUldPb01pN0RmSGR5RUJYUENhNUlrYkcxVVZr?=
 =?utf-8?B?UlVyT2lqcHNuaGVYSWdNZklpcnZWWnRXWFYvVjJqeVY0SnpGeGJTSFYrK2tv?=
 =?utf-8?B?TnEzNE9SYnV6RkNaRjh3eU1Kd0tuNDRzWURBckhPNCsydlZEYU83V0ZkQlRZ?=
 =?utf-8?B?UUJMaEJUQTVKc1N6dGplNUVuS1pxK210U0d0bTA2VDJJU3IvZmNQUzRteUNV?=
 =?utf-8?B?Ly9JMWgxMEgvNTkwVFVyQXgvMG40MGt6VGRQczZHWExUbkpCV3JlLytWMUJW?=
 =?utf-8?B?QkdKdlArNVVWQi9oZU15QmplOFVlaHBWTkVwQnFKQUVZNDJERGhVSUtaa2d4?=
 =?utf-8?B?UEZhT0VFTXd6bUpKZGsxLzRNcmswNVdkcTJwZWwvVEVwc0FZT0s4aXoyZ0dX?=
 =?utf-8?B?ZjE4WnBZRHVhR2M4MGRNazMvTkNqclljSTg4d3dDdWVRUVFMUG9PenpPdUNM?=
 =?utf-8?B?dzZra3VzWE9sQVJEaUFaQ2RsREhPNC9FVlJ3cWlmUEFUcXlwbzlvRlhKcVVF?=
 =?utf-8?B?Q1p1bFBWVktDM21pWkhtb1FiSFhiQStVSW5pdldZOUFnRmFLblc0cno2TW5l?=
 =?utf-8?B?cGpCUmVFTTI4ME1nMHU3RVVLR0g4b0dNVGxLTituU2cvcndvc0loRHFnTGoy?=
 =?utf-8?B?RElmeW5jQ0g2UE9oMXVCK3NtV2ZqWU5sUnoyZmNZT085N0xuMkRMdUUvMDdl?=
 =?utf-8?B?SnNzeGJQSEwrNGkvbkI5OTN5WGJEUFhVNHBGRE01Z0JNOTF3ejBRNTNOc0E4?=
 =?utf-8?Q?ClvWCWvhe98lVW11GkbKtA34X?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	5oOP5IhA7YXgoIiq4X+5QL9E4BEy4KmSlDm2FH/xeK4n8QlJciOdMO4zEwEbbkLC51r/nd6CzmM2iS2ieSrToLINS6DzapWCM5Z6ZpZctpEsPDTXLzZ3EGH5IF+DhGU0sUv8HesjgBTw4Yv0BWM8ErRnBwUtSnQ3IU4dqowb146PqJ8v0FeJg3nvihqpquvCBFeSS/iUThHBFCZfCRfosG3xgWvfSOPpl/SiJDjR/+dze1OO/3YlTR6aK1YLw9rNS7xWGxBxFFguaCx+kfnCRRr/u2zX/uAhhIot362FH3J6nZhq5uWSw1uQF1r1UTStxpfkHr9p6yufVlghTirGbwW9G4i9Ra3ZBECoJ32fPPUTHhmzyay5ueZvulujQIBAM6GF/kFReo46AkV/TeJERCWhFB51VQiqlB20TI6be+XgD9d8S+5CNRuDQoFdVyQPtlBPWWoDLeA8HaDEgE9dLHvEy4j3/q1Br//RvEPhU574h3GsuGFFgW0yak1Jbe6enSTgjYPm4ryqvL7PkXyOHC1B+Lzac9wnwcU2k5nMuZ654vv0ijnaMrfVeADdXGGtqyTE+gRCgnLWLjMRaXvZuZkG9FReLI7y18SNAvc0kVc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8395641e-f3be-47f1-2d21-08dd6635eafa
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2025 15:59:52.0243
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3rk50EA/eJvWwiTcAIRqKQI6/W/Kphk+qvKkePMBRSleyJmcUPV5uTf9qzCjSbEop0+8wbF7qlvsLGQC3ecT9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7583
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-18_07,2025-03-17_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0
 mlxlogscore=999 mlxscore=0 malwarescore=0 spamscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502280000 definitions=main-2503180117
X-Proofpoint-ORIG-GUID: w-TgayTBvx_0gP1EJ4fgp-Av4cfBW6IB
X-Proofpoint-GUID: w-TgayTBvx_0gP1EJ4fgp-Av4cfBW6IB

On 3/18/25 11:09 AM, Anna Schumaker wrote:
> Hi Takeshi,
> 
> On 3/18/25 11:00 AM, Takeshi Nishimura wrote:
>> Zhang Yi <yi.zhang@huawei.com> wrote in linux-fsdevel@vger.kernel.org:
>>> Add support for FALLOC_FL_WRITE_ZEROES. This first allocates blocks as
>>> unwritten, then issues a zero command outside of the running journal
>>> handle, and finally converts them to a written state.
>>
>> Picking up where the NFS4.2 WRITE_SAME discussion stalled:
>> FALLOC_FL_WRITE_ZEROES is coming, and IMO the only way to implement
>> that for NFS is via WRITE_SAME.
>>
>> How to proceed?
> 
> I've been working on patches for implementing FALLOC_FL_ZERO_RANGE support
> in the NFS client using WRITE_SAME. I've also been experimenting with adding
> an ioctl for the generic pattern writing part. I'm expecting to talk about
> what I have for ioctl API at LSF next week, and I'll post an initial round
> of patches shortly after.
> 
> I do still need to think through any edge cases and write tests for
> pynfs and fstests before anything can be merged.

Takeshi, it would be immensely helpful to us if you could provide some
detail about how exactly you intend to make use of WRITE_SAME so we can
focus the development, review, and testing efforts.

So far we don't have any specific use cases, but there is some
skepticism (as voiced in the previous thread) about whether this
facility will actually be useful.

For example, do you expect to have SCSI devices that accelerate
WRITE_SAME? How will your applications use this? What kind (and size)
of patterns do you expect to need?


-- 
Chuck Lever

