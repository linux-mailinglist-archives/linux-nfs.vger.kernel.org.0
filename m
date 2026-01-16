Return-Path: <linux-nfs+bounces-18065-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E1F11D38909
	for <lists+linux-nfs@lfdr.de>; Fri, 16 Jan 2026 22:56:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4FBDF30D5C84
	for <lists+linux-nfs@lfdr.de>; Fri, 16 Jan 2026 21:56:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A8FC30B506;
	Fri, 16 Jan 2026 21:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="nLxddbOy";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="HSi8Iof3"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 852F130E0C2
	for <linux-nfs@vger.kernel.org>; Fri, 16 Jan 2026 21:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768600573; cv=fail; b=dCGlOzyKYLQ/+yng6KyXYLlLM6mbbupz5IZKwi3XJeQxslBxZEK4Wgy5UXnF++6/Lp89kxxxxINOibarSsA79OdL7Se45orcs87x9Le1YoMaYJuSgIdmBcc1WzZTvP/57bt5bHgUifgCmdS5Z+CXkavXlsvFBkNCg7W3/Npgqgw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768600573; c=relaxed/simple;
	bh=iKXQhoTGnqzQOj83echWB/O2I0imRe6AdYrh1n39fVg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=AexLfCDJLSZArL+1rpY+BKFwwpIFQP87WY5I9d/AWrO9OQTypBNMmAyNCs4msq1C2+MJw+Hhym71HVgxaNFZMwnbcXidEhmW+l4BtNW7LgxEgYuNf8Nv+JXZwJkFislXojHYydK/sQhJvmKBxTEKF5/NBfyAonsVm5fzCL/U/OU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=nLxddbOy; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=HSi8Iof3; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60GKb1oD3839192;
	Fri, 16 Jan 2026 21:56:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=8DLQ7iGjQeoMODis42ecTI4KJ/hJxLcCZYz76qTDsaY=; b=
	nLxddbOy83oL5PpJKB5vWPUUjY/V1TaexQfO0m9FeRvIw6Q/r8vkzIXhl8IOXE0z
	/UUGhPAI8RF9/tSvyXHK4NoUskq8hnXpRP2yJ7zFwmYGuf1wa794U9dc/pd81MDf
	2Ytjs47qay6lI108wb1eBgGWx/8SKoTqkYkVpWclklbqTxKrwZtVYMyaWz65ei//
	5ylQRF+jQlPE1KzmP8sQ8JF3DQeeV2iKj/z5ltyWy6/lroLpViXFKVcCsmLrPFZK
	SGJ5Ezaa3LgMVf4vgVCSMbT/Sa86MUJK/kx2O4jqN0V2S7bbQ9gSIwdJ5tH6pOK7
	Tg9ws3tIBafOa0ay+3Ttig==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4bqvh7g35j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 16 Jan 2026 21:56:05 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60GKKdt6010740;
	Fri, 16 Jan 2026 21:56:04 GMT
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazon11012050.outbound.protection.outlook.com [40.107.200.50])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4bqv9m2tjn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 16 Jan 2026 21:56:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ReXyYF9X9q+BPSeb3sfpWFp0Yh0PBREs+ZesL/XgqljXaDqOiBWwEIBjPNnBIckUx7SOHAT1NQuHwcvLj4UfDygFAnOrKgkdEms/f6zEGEqbdDvABQwHvgCeJn5uUNCiHmIZyzXoj5oUpCmaOc1s/1jrP79BC3mNQ/uu575tMu0S2kinbaC7njCOcFIYyC5kQxwAxdLHBS+NSvMrIk1+3jNi6SwKzuiwYUOG98oRNldHxMYBruZY6F2cLdl53stOGTTlHhLlXkihXnUDFoBquZFd//GKFPFQ2KpCDVRXdf7JtP+NBqOIuxF2Ze7Zyn9PxBqLNR9GXfF5apwpHNZ6fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8DLQ7iGjQeoMODis42ecTI4KJ/hJxLcCZYz76qTDsaY=;
 b=tVL2n9MMlzQkSh+SvZCytzSevhiNk7z0FmS7kqUH7WdLcKpKUi18u5GODIKFnnpiKU69cLLE0uNtWxj9/Q63Qe0mdZKd0GAOQvK3TNpP46eISP9Ze3+jS8S6F8r2MJRSKtbFw+REGSll+ZPLOk91lqkS0iMoRci11lhMpwqgpjBgDBop/aUo4YhX7SkOMlCViDb475FECrONZ+vsGV4Q1SjQN1/aZb9fWtIVUlMS+H/bAPF0tIYxqjbpz/SK+ld4R0S3TEzPHm/Haj8VCZn8/9ZSvvE4KcHs1yxjNBwjcu4XjlpNPMz6iPNLvZa3tayrnGkjlQnfgfGBDr7V2kVPMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8DLQ7iGjQeoMODis42ecTI4KJ/hJxLcCZYz76qTDsaY=;
 b=HSi8Iof3yd3WGvPk4YkFrNpBRvZc6eO21bSV9H4mdX0AKgJYKmW/ITWeI+iCGqKc+z2DFkqyBXcQMYhVFzC+kWC/TUTxsrN296pjcCcL4yj+zcLmZALnRT4mEaGIfT2SjM3r2Us4Jxy3xPEoT6tubTNhtKFpE9u62KLXvvzBjsg=
Received: from MW6PR10MB7639.namprd10.prod.outlook.com (2603:10b6:303:244::14)
 by MW5PR10MB5876.namprd10.prod.outlook.com (2603:10b6:303:190::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Fri, 16 Jan
 2026 21:56:01 +0000
Received: from MW6PR10MB7639.namprd10.prod.outlook.com
 ([fe80::69ee:3509:9565:9cd6]) by MW6PR10MB7639.namprd10.prod.outlook.com
 ([fe80::69ee:3509:9565:9cd6%5]) with mapi id 15.20.9520.003; Fri, 16 Jan 2026
 21:56:00 +0000
Message-ID: <108fb719-8654-42b8-9e37-275726f4b5d8@oracle.com>
Date: Fri, 16 Jan 2026 13:55:57 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: Bug in nfsd4_block_get_device_info_scsi in nfsd-testing branch
To: Chuck Lever <cel@kernel.org>
Cc: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
References: <45f16856-b71d-4844-bf11-fc9aa5c2feed@oracle.com>
 <a1442149-fdc2-4f66-b73a-499a2e192960@app.fastmail.com>
Content-Language: en-US
From: Dai Ngo <dai.ngo@oracle.com>
In-Reply-To: <a1442149-fdc2-4f66-b73a-499a2e192960@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BLAPR03CA0124.namprd03.prod.outlook.com
 (2603:10b6:208:32e::9) To MW6PR10MB7639.namprd10.prod.outlook.com
 (2603:10b6:303:244::14)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR10MB7639:EE_|MW5PR10MB5876:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f9d53d9-69e4-44b2-7dd9-08de554a0968
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OXR0azI3MDdKSHRkZmZVM05GN2diYUpxUERJVnVnOExNUkpmSzU2UHI0aXJa?=
 =?utf-8?B?a1FoSjZxaHdLcGNQL2xxTHpuTFZtV3AvSGxiS2ZBY1ltZXY5bERGYk9jREVq?=
 =?utf-8?B?TWhNZDdIaVNzVW94U1J6Sm5leFdKMEJWekoyd0ZKeTR3d3dZWkIrNDhPM3Fk?=
 =?utf-8?B?eHl0RXdKS0dsYWZ2NTdYdnNSRUlzM3lqTFNlemRPS01HL1NFRUs4aUd2bGpr?=
 =?utf-8?B?amNabncxQTdWWlRkaE43TCtVYkRZdmt6VnhPc2I1RlhIUmIwK3pkcDMrVUhp?=
 =?utf-8?B?QUdML0dnMlBGOW1SYlg4QWNkYW5uL3hCTjBBSHJaM1FJTCsvZnkyRWUvb29N?=
 =?utf-8?B?UDlwdTVKSXZVK0hJZ001QXh5Y3ViNDdIMHlJQlFaS3A4Z1k3TjVQMGZPRk9H?=
 =?utf-8?B?WjdZWjhJOTAzNDRpc2ZaS21XaFI2SlIwOWR3MmRGVnhCdkdsclpRbDIzZ3F1?=
 =?utf-8?B?KzhYcE5TNjlWK1Y2aHVXdFowTWF6bXZJUUt6ajhDQm5PRUZjY2JTSTNlK2M1?=
 =?utf-8?B?c2FZcVo2dmRiWUZKZTFwcTZpcHNZRmNPSitWclJIUEZvZy94RTZLd21KU3J3?=
 =?utf-8?B?MWhnLzgzZGkvY1BZV0RZL29jMFh5TXptOEVVZ1RFRTE3ZDFhTlZOT1VHMUJE?=
 =?utf-8?B?Y01UOUJ2TzZidjQ3UTNUZ3A3a3RFWlBsVWw2d1F6ZEN0N0NYa09WaW5HNy81?=
 =?utf-8?B?c0t6dGcwNVRDSzIrYmhoaHM3anAwK2dBUnBKS2xGQTFuNWVOa3lVdFBEQzNW?=
 =?utf-8?B?RCtiQ0l3QWNDYW04ZUloQmM4VDJ3eWFNRVg1TUE4L0ZHU0NmU2N6ZEk1bzhS?=
 =?utf-8?B?a2xNT2UydmtTamkxQ1FMSFpaeE9MSDQ0SVlsQUVYWlU4NUxqbm1SRTZENExs?=
 =?utf-8?B?UlpscVhmRnltSGgrdTU1VmpDWjc5dzZwRU11aGNHWnUxSDFxRzl6L21YNWts?=
 =?utf-8?B?Mm9jby9KYkxzZmM5LzJDVWMwOTBCcGxXUlo5UGFBano3RFFUU0ZhRHd1cHVp?=
 =?utf-8?B?bGh3Mm5MK1ZJTlNxcit6RHR5amlVaE9NTVJSTEJHS2xTOXlXdy8xeWt3QWZK?=
 =?utf-8?B?amc5cHRxcWljVmhXcnpVUm1oZGxhcWxjZUo0M2RjTVFRT29GZ3dKejdSbmVH?=
 =?utf-8?B?c0xTR2FNM3FmT2ZQaFhuRG1mWEtVS01rSVNTNmRRT2ErNFNYN0tnQWkwVUFD?=
 =?utf-8?B?SlVwcWcvckFGckZMQ3hlZTFNYWp4L3k0aEE0OEJRVmxEOG40QWc4UVR2Q2Nw?=
 =?utf-8?B?NlhmUnhtQUt3MlJOampwd0I4ZVVoRjlKbGxRVkJhclVVT3lvQkFjeWx2V2pG?=
 =?utf-8?B?b1lhSXpLQ3NIQkhBK2pVbmY0RkJRYnR1blNyZDA2TFVDTSs5RWdobHc1YTVT?=
 =?utf-8?B?WG5VSW5HUC9TcGxQbHBHZEpoeHJITTZqbEpmUnpyVUlkUGFxQjlZY0s0R1hZ?=
 =?utf-8?B?WmlWZWRoWlRJVWVjSDNjYjFncUg5V0NQNjdsdStkMHIzZDdITm1CMGRvSFFr?=
 =?utf-8?B?QTV4Q3RSMGJWSXhXenBybjJmeVNia2Rsek9WNnBoQ0ZYUUNDazVLTGdYTXl6?=
 =?utf-8?B?dlJyRUhzT3pFaDNWOWNnN3ZtbjNpeWN0REZiakRMSTRMSnhoWmYzbTRQTFJ4?=
 =?utf-8?B?SWRuakI2dWh5ZjFhVzV5T3FxZUR1SUhucml4N1FtaUJoYWRNYU1Bc3NCckh4?=
 =?utf-8?B?RkFDZlRTaUpPdU1NNjZBS2xYcUtFRUFYbjFYQ0J2T2l1OVduaDR6blowNFI5?=
 =?utf-8?B?c0RUT2poTnRwekJVK3g3Q0J5dEZVbHhhdVR0cFRMNldjWTBPM1NXY1ZwdUNh?=
 =?utf-8?B?VWhoMGFlRlRLVWdNVWQrTXFVaWRIUVVJZHFGM1lrN1ZTVnkyQkloS0c4MTdV?=
 =?utf-8?B?TzBQZ0U0SEdzVzg2KzBCdXNDTXhNSkFyUjJkekdiQkREOE1jYTVxMUdnT2t6?=
 =?utf-8?B?bjFMQzBtQno2NXdqRzZNZk0yVDFDb2tYbmFKR3FWbFZDZWVpOTQ3OWtJNUVl?=
 =?utf-8?B?b0srWE15dTMyR1lRQnBBdS9ENTJYRWNOSGI5STRVaktEbmFmUGxQRnJDT1or?=
 =?utf-8?B?T3Y3OTl1RkMwWEJZMG9JVXVBVkwrQ2dndzc0R1R1MUlKTEdWai9udTZCMjk4?=
 =?utf-8?Q?GtQo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW6PR10MB7639.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q1J0bGwvOWxmT1Rld2Qrak1DOUFVdUdiRXduS1V4QUhGYi9BQlN0ZHJ2dWVk?=
 =?utf-8?B?dUNqYlRXQVI0Y1hDdWRKQWtjMnM4eVp1cDdBNk91N2ZmRWVWbkFrbmwwQmF2?=
 =?utf-8?B?eGRVbTl0eUtQci9wa3U5dE9xd0Q4UTVhSVRzTEVsZFA0UEt6ZWRlUXJHSE5a?=
 =?utf-8?B?TXY2OWp2dHkvREloems1RFdsbUJvYTlTN1FhV08wQTNLR0dBcTBhZ3VpbW1E?=
 =?utf-8?B?ZWFSOTRFVjBudG1MVy90Q1g5THJGSEJWOVVMOU9pdWdld3dtRWJ5Y0F4WFhN?=
 =?utf-8?B?YjZnMWt2cHhVOG0xb2cvRXU3N1Y5Z0tWUGtJLzlEU3FHOUlQZzZ1U3gzTytM?=
 =?utf-8?B?TTZmTUpYK2FWZXlka2JldUl0anAzTnFoNDM5bDN1VGY5aXcrb05Wc0hmbVZS?=
 =?utf-8?B?RExNdklIZHdTNUV3OHdZRC84TDI0MHZEcDMxbVZKSU5kU1ppZ0Fhekh4R2Rs?=
 =?utf-8?B?UVM1VEdzYUdVWHcvZmYxUmJ6NTJIcTR2SFZjMlF2OFZUN21aRE51RFZCay84?=
 =?utf-8?B?VVZ2MmVZdGhCbE1aRDVnYjl2ZmxBWmdaQnBNNkZEcDdXMzVOTHVhZjI0aHVl?=
 =?utf-8?B?NnZacVV3cWptZy9HUUxMQ2xNMlc4dlFSNHZxMWU5R3lwNndRQ0hkSEdxRG1a?=
 =?utf-8?B?ZnZBT01DWXpYODNoTzg5aXIxUVFJTzZ2dzE3bWRmUC9xd0RwdEpWdG1zTGNq?=
 =?utf-8?B?RURSMVhHMnpJWGJMakpjYlozcWtSUVYyUjA4Ym9Qa3JUNkxJM2pzNTR6YmhF?=
 =?utf-8?B?clU5bmQrNzl6YUJvTU9YQ2xKWUlaQmZPUDQ1WTByT1BRNXo3SVFHU3ZCTkYx?=
 =?utf-8?B?U0Ixc1ZpZmNNcjArZnJTQlYrUk5Ib0tPWVd0K2hzSW92ajl3dWJyUlFLUEE1?=
 =?utf-8?B?RkZJU0FLRHVsZDFpTmFsSE56OFBNM3JXYkY1RUFtQ3hYOEdYZjJldUsvcEVO?=
 =?utf-8?B?bmp0SU1qaW5uTXNJakxPTE9YS0t0TGd4cmljdDMrWk4raWRFZWRSTEFMY3h3?=
 =?utf-8?B?dGhHaC94NDl1L1JENm5wandrS2wvYThPMzBaNlBNblVxajZwZjVIQ00rQ2dk?=
 =?utf-8?B?dkh0cHFhNndUTjg4emVqM25iRUJId0VzMjd3TGNqVlh1bEFOSEd0UmZOTEk2?=
 =?utf-8?B?OCtBZEVqeDB0UjR2ckoyZjZsTTIxUHdWYnBLREY2L1ZjNzFKd1dwNkNFMmR6?=
 =?utf-8?B?QWRFZmVwOW9ZUHdKNjRIWlhlU053Y2pMaVFFRU5IUksxeFo0WW4wcndMN25t?=
 =?utf-8?B?SDlkcklscXRwQTN4QUVmMVRJaWdnTzAzbXoyNmgwVnJ0dHBKK3lxcW9reVl2?=
 =?utf-8?B?MU9EUndlVTc4N1B2VktqQlc4ZWI5OSs1Yjdtdy9nL0xXUWJ4R3Jmc0R6S0lU?=
 =?utf-8?B?MWE0VVhZa1RFNjFWSTJOZmVtN2g4RlpiSWh0STNkZzBrVkE2WHRRMDdHNGpJ?=
 =?utf-8?B?dFIreWtuT2J4b3JoWDI5NGFzWEV1WjVkejZoRUQ0RkJDWEdHVllKeFE0M0Qv?=
 =?utf-8?B?YWlKSk5UbWhwYjRMbDN0SGZZZ2VFYjdROVdxTCtQR1UyZitGenBWcFczTHJQ?=
 =?utf-8?B?bWJXZFdoeElXLzNtcVA2S21GNWtQZ3RnellqS28zTXFsazMrQWtqaGdnVWpu?=
 =?utf-8?B?NmxvL01iWEFpTnVvUUJIVnhuenlOMUhkWjhxamhRK2JtUW93ZFdHOVN3QUlM?=
 =?utf-8?B?MHorS09CMGMzTDNZWUxYWlExY3pCVGdkdUkxTjRpNUhrY21ORWFsaTdEN2VX?=
 =?utf-8?B?ZE96b0Q2djdKTEZma1IwMS9YWTJDUDVBR05jaWUraTI4Z1hJalYyYUtXL3I4?=
 =?utf-8?B?UlZwUEkyUmplc2krSzFYd2YybCtGbEhEY21EaGZQWTFZeTl3Qmk3SkxHVHV4?=
 =?utf-8?B?MXpFT1ExZFFPNllpUUZRWFZDWGJyUkhUQnZFR0U1MUZZQUdyWDhYNHFObEhh?=
 =?utf-8?B?ZG4zUnJiVVpENjZNL2FoWWZYY3FKS0FycEdqaVRoNEpJbXlTVjluS2xUaU01?=
 =?utf-8?B?Qi9NUTYxZExoTHpFV29kWTlnam9OWmlmQTNPaWVWVkE3VGxCUE43M2lkQUcz?=
 =?utf-8?B?czMwemh5RWxrZWRvOHNXcFQybURIV3BFNWFZV1pTU2kvQ3Z3SENDaVVqWGF4?=
 =?utf-8?B?NlhXK3RNRWhTRS9qZ2VERmRwN3dXMFFYaldCZUJ4RzZIa3J1Z1N3ajFSdFh4?=
 =?utf-8?B?dlBtb1U2WUZUZEVBUGg4MW5PYWVCTU5aa3Fsd1JHMTNhZUxTOEJXRlBhYkVU?=
 =?utf-8?B?VXR3Q3hrbHhYUDBiZCt0N2VHeEk0L1IwOEFZcVN3dDRHN1JUdHMvOHZHTlEw?=
 =?utf-8?B?WGloOEtOcHYyT29ETDN2S21FanNPTEc1dGJ0U1IxNGhvL2dNaTBEdz09?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ofKEeOhyWEGCBRxP4duDipI2iQ5Os65t0a2+YbBR4MVS+hqeR74KhCYu7oTFMVJRIP+3WV/RsLiOpbDuLV0RjPMBsVnNMlP+KFOAFW87w5jjjzFzL1Ccj8geDdWklFXh8yIUqalBA2BoFv0rkl5Jmxt9INP7gp+HtkGjBfT02sUP8ICw0Wjxd2d2Fb/OVr29Vd8g5dheLgq4ZGGFsjm54JDUFb4GFqCIf/6yRf1HjUfzjy62QKjdbIsPIAVExwVi7ccjt62J0IliIqrxpP0jkJMJOThwEo7O6HpVPqtPpmSXJN9r/hXxghFWQSb7seRIl18WyqlSdJURHh+uZyJbBvJPzrtsk02PmFnpVSs4O+BRPc9EByVtXdPI7qYka8JZft1aFvQ5hC7yfZVtaVT8wt10BMGqQCUCZX6naX0c/Higpu87/wSHkPAlZnlc/cziVGCPwnvx1gu9oQJNhiZj3qo5IssUpDrLRLTO0JBUWSFlsfOVG4jleQ9Rqal2Fle4K1aDTE+47sLpXNmVyD4vYvAHWFl2MbAyypbhm3sKlPDXiVVh88PbPEoQA3tzPuFdDo/HZ7koiUfHC8f/p3huA6L253WTFJxtag6HDkBvh34=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f9d53d9-69e4-44b2-7dd9-08de554a0968
X-MS-Exchange-CrossTenant-AuthSource: MW6PR10MB7639.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2026 21:56:00.8620
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jneDea+lM+kKchEW0iEdMq9Ohjmz0ymybjVvTFD/Xo1fEHOdNjU28dsDH48xtm9QCCa3jzI/utd+kjOd8vqjrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR10MB5876
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-16_08,2026-01-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=937 malwarescore=0
 phishscore=0 bulkscore=0 mlxscore=0 spamscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2601150000 definitions=main-2601160165
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE2MDE2NiBTYWx0ZWRfX+Srsz/scWXAn
 qYKCsEYe5jc0tbeV/7AbDgJopHtm75UfyJvJfpjyAEQKS/WeXTPMxIhXt89OJzj8uPe5E7Ljxxj
 5LNRHrh1npScY3BRa3m4TVYMZdPWsz1KNNNVBOGjYAAtYv/qLd2/t5sWwdggwi4pNVLt1SuzEm7
 ZMNBvBhVAvMWIRxYG3YGqaoS/hUGbzhgUtSVpSdrvh7+T5BxeXk1mcB9Uofos4vzsdsG0fNS58x
 cIguNmFJSIQTqZz4NMsbgW2Q6MvemwmIVecABdrAr7WIxiK0mFDfQbVoaFPc67pXNC/ujSFvt21
 SRpnHEGoSP7COL4KXVIKaVo6vcXNBzxsuW2KzDhMrbLKn6c1p2hzGpHWO/jdaaKeSguKO23/4W2
 YCwH0ZF6dP6klLjwPBn/KUKX82zi1GywzHJwDHNnrOXwDr35cbhPiS33CzrN6hDlga1ze4g8Zz1
 PEPId/wM80l6zDZE43g==
X-Proofpoint-ORIG-GUID: bJSrZarueZFV_d5DQkAmGveW43so3o-U
X-Proofpoint-GUID: bJSrZarueZFV_d5DQkAmGveW43so3o-U
X-Authority-Analysis: v=2.4 cv=A9lh/qWG c=1 sm=1 tr=0 ts=696ab3f5 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=vUbySO9Y5rIA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Xgn9zhmlsbUXyY4ULKoA:9 a=QEXdDO2ut3YA:10


On 1/16/26 12:00 PM, Chuck Lever wrote:
>
> On Fri, Jan 16, 2026, at 12:15 PM, Dai Ngo wrote:
>> After the entry in the xarray was marked with XA_MARK_0, xa_insert
>> will not update the entry when nfsd4_block_get_device_info_scsi is
>> called again leaving the entry with XA_MARK_0.
>>
>> When the server needs to fence the client again, since the entry
>> still has XA_MARK_0, it skips the fence operation.
> The mark is cleared only when a pr_unregister is done.

The nfsd server never issues pr_unregister. It uses fence to stop
client from accessing the device.

>   I didn't think
> that an additional GETDEVICEINFO should clear an existing registration.

When the client detects I/O error, due to SCSI reservation conflict,
it retries the I/O to the MDS. On new I/O, the client sends LAYOUTGET
then GETDEVICEINFO and send I/O to the DS again. This is why the nfsd
server needs to clear the mark on the xarray entry on GETDEVICEINFO
in case it needs to fence the client again.

-Dai

>
> So, did I misunderstand the API contract?
>
>

