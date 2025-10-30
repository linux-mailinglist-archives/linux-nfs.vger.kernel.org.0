Return-Path: <linux-nfs+bounces-15794-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C574DC20423
	for <lists+linux-nfs@lfdr.de>; Thu, 30 Oct 2025 14:35:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BEAD6189FEC3
	for <lists+linux-nfs@lfdr.de>; Thu, 30 Oct 2025 13:36:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 119CE248891;
	Thu, 30 Oct 2025 13:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="QNR+KDDk";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="HKdRIZDW"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E1743557ED
	for <linux-nfs@vger.kernel.org>; Thu, 30 Oct 2025 13:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761831254; cv=fail; b=lRKuOWOsScGHRItJHaNu+oUPxXgth1sKmi18g641h5qbuYjji9pZmai73X85XjLHirpzJMSVQ5sMH1udgzkHMG4BLnFyQUZb1s8+WJaQm9nhPNtuLb3WYFXBzdL/5pTGKqA8DFGhNPoRxzjpPDVOm+DhQahLd5ciT7AGoXV2O00=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761831254; c=relaxed/simple;
	bh=RpUWmlEcEW427Fz+Jq8ycGBtZSk2RJ1YR6sXrv0CQnw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=u8m/p+RoS2y/VW50GYnpNls6vebH/uf7sjp10pUoHfV8unCUyI8Qp5c5L14rk6cQoYGS/erc7HdIJUwpkTWDB2J0wllZYbfTpPUkSIZttN/u+atrGIZlZTxJU+G28oaSt1PL88wlxEiSMVksfbg9mA7VIdwBvEYbpz9RxRaaZvE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=QNR+KDDk; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=HKdRIZDW; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59UDCOAY024360;
	Thu, 30 Oct 2025 13:34:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=dZUJ/E+4HseunZpWpVHZvLka3uQ844VISzptKgeA9D0=; b=
	QNR+KDDk6fv4a3O3FV+ELDqRkLVJNrF9IL/rL3qrvYLI/gL9cATjRPpzwWhJRA0f
	e59OclB3StP87THBha8K0zh7MbjPNFI9Wmhw8QqPYjmxKLcQb9YIdO2UawTGjYYW
	9PJ4MmEqMWfJ1yc8/4xceWJcaeV7wTYqV+BbOihAQrKuGjSC1OaQIiwIcZokTPt8
	nifz0MZewfv1F83CagvaxTcA/DiI6lXgA04EEOxnL/Q3u3ln/BgrB5vrOoCaMFXd
	a07QN8Ml6HEqdgOHAW9KJ8FgjOg/nxtGuhHILhannKaQBdF5xq6mqT+qSP26lz4G
	NdqU93qoo/0xQQj3wux6nQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a476hr97e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Oct 2025 13:34:03 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59UCt0vi034254;
	Thu, 30 Oct 2025 13:34:03 GMT
Received: from mw6pr02cu001.outbound.protection.outlook.com (mail-westus2azon11012015.outbound.protection.outlook.com [52.101.48.15])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4a34edc11b-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Oct 2025 13:34:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nG4OBvHQ/Mv6YzxtjILZ4DAca+jIsS2REg/iAjS9DVXuAobx2+8bzYak4gqCt0DBLklI5Pds8CZVu/U73FHBsE25u1oBo0Fs0sPPnz2vj1kYACHNc8PTCMSMOCWpeQAGihtbNip6XGRCjNT2bOjhSrRuUQp0+HEtAwyXHO8kDXTY6waVbH5xfnBY9fqcN5kpwacpYjpzrPC9lmghbaYPB4VyLH4MPqLl5RiYc+mKQ0F54Jpl08ewyOnMxhkS1f5zlu6eztUsf7pnrhv7XyHXmmLF15urKUcobQESiiQonqU3xmuOZTQtiQYW1F6gTrnGrEBfJf2xV1cXQSfkGORr0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dZUJ/E+4HseunZpWpVHZvLka3uQ844VISzptKgeA9D0=;
 b=ShmqJloHAQMK8PoK6W9o6H3ukN3SmogrsMTL+YGPjVTvt0fB/ukRfySAxjbOPeMpjCb29T+EFnPaLrS7TxKkdr470af3S8pV4vXHgMbKh6j+1b9bE65GXu5WfjmAvpoMsLmsNSYdTJQYh6H2wqotjTF+FGHu0zLWrEkMnXGa+io4CbbDOli+sys432F7zBVdy0+/PnezqLYnI0Qn3byMPtgB1ACw6I1oXDHmwBoQtLacn7JYXLH2SvX4etm2fBB5yE8JhhN4Zsv3xByCf2WGRCb5FzTGxbPOzAu0S/4quLg7Ecz5E/vpaachCmOMDPV1yZKJlSwamDGuMNNkkIjbbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dZUJ/E+4HseunZpWpVHZvLka3uQ844VISzptKgeA9D0=;
 b=HKdRIZDW+bTicZu9SIpXk+8pYWTSC6KE64LVs/LkN3o0GV/6vBkGeVBU0oxeQam33wf5WEvMM6AEOIZ9oTbgItE1yPpa1gPJ0CcQ4ViHH9AdujudaMpNPYvjVafjbhppsKUnBM3ISFPcFu3UbvqjMEz1KE9bTxuVnksICqXi88s=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CH2PR10MB4341.namprd10.prod.outlook.com (2603:10b6:610:78::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Thu, 30 Oct
 2025 13:33:58 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.9253.017; Thu, 30 Oct 2025
 13:33:58 +0000
Message-ID: <bd381b06-0c61-4102-b0da-bad8e1130eeb@oracle.com>
Date: Thu, 30 Oct 2025 09:33:56 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] NFSD: Fix problem with nfsd4_scsi_fence_client using
 the wrong reservation type
To: Dai Ngo <dai.ngo@oracle.com>, jlayton@kernel.org, neilb@suse.de,
        okorniev@redhat.com, tom@talpey.com, hch@lst.de
Cc: linux-nfs@vger.kernel.org
References: <20251029232917.2212873-1-dai.ngo@oracle.com>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20251029232917.2212873-1-dai.ngo@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH5PR04CA0012.namprd04.prod.outlook.com
 (2603:10b6:610:1f4::28) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|CH2PR10MB4341:EE_
X-MS-Office365-Filtering-Correlation-Id: 7191523f-f572-4ae3-939b-08de17b8faae
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?WTFiSXBjd09XMmVMRHFPVlZEQTZ4SXI5QmNpQmxlZ093Ulg4SWNPdUNtM0la?=
 =?utf-8?B?cUdlZEFLaWtUdS9WZDJMTkxuOHRoR3FmTEFaODNTVzUwL1Y2VDFxYU9LcjRh?=
 =?utf-8?B?dVBaMXYvYnNiSmY1VlVQRFgxYUxTeU5jUnF2ZzZaMHkvQURsdGw3aTlDL2pt?=
 =?utf-8?B?UnpHTytqTmtnQ1BNU0dpM0JVYU04dkRtOXBSbDloc1c4R2EvZVI5M1MvaDRL?=
 =?utf-8?B?aXF1TWhsV1ZzMDEwZXJNRDYweWcxMjJuYmU3eTdJVTM3cVpoM21XdzdaYzNU?=
 =?utf-8?B?bmJOOTBvU0RhRVpHbmVvR3VLNFpFdG43enllaStBamh0dGlLaGk4aG1JRjg2?=
 =?utf-8?B?aW4wZ05wNFZVM3NNdSsyeUdQZDh3akxjMTlNUlMrQkY4dm5iVXFTNzZtUVhB?=
 =?utf-8?B?R0VpeUZuSG1nV2FBTDU5VHZSNjB1N2RZYUkwOThJdUJtREFWRFQ2elAxMHBx?=
 =?utf-8?B?Tm9mZlQwcjRaZVBIdjJKcWdxWjc3RGhvRHNjbzh2QVJuTlNULzdBaXdRYytV?=
 =?utf-8?B?WTRGTC9HL21IM0RXRHpveUxFN2gwMWpiYTM0b2F6eGtSRUdBR1R3Tzh0OHUr?=
 =?utf-8?B?OTZFbUo0bEZON3lHVklocDZnRGJBb3p3VmxuaXRIenVZZHdMdUR1Uk5zeDBW?=
 =?utf-8?B?U1Z5ODZJTTJFZTlqZnl0UHBxbTJjWmFKRkhIbDlxKzRvVmozcXJXaEF6RnVZ?=
 =?utf-8?B?MHlaU2hBWURiR1ZoOW44S05YSWNHdGFrdGM2c3NMRVBmR1B0VTdQTUlIbS9P?=
 =?utf-8?B?d0lsYktyRG8wNmFIMnI5UVNHc0puMDNaZHZIZTJxK1NRKzVDRTJGMFJaM3A1?=
 =?utf-8?B?OGtXT3huVnM4cCtzcnNSdUdRaG1rOWRhUllkbzVWeWVMOWdrTHV5eXM0enVm?=
 =?utf-8?B?MGFxcE1KUS8vL1lVVVNvaGZCckNUVkdPMHRIUEJ3a1lDMld0VGl3RnZlZEVM?=
 =?utf-8?B?OW4ycmpleEtxalIwUlFFNDhDam5GazkyYitqTEhTQWp6RXg3dllCOVJuaXIv?=
 =?utf-8?B?c1RoS1FoUnVNNVZYMUlvLzFYTTBad2lLZHpuTjBzSTh6dXBiRnpkcm5NMUhJ?=
 =?utf-8?B?YXpLeWNIZklhVUxIMkd1V3lZM0FnOUc1ek9ZaWIwcWtVU0gyVzYwNXREMFky?=
 =?utf-8?B?Nm5vYlF2eHBhS1N2YWl3bmdBN3JZUy9PWGxvTTcvZ25iNzRZWUFudHJXQ2hr?=
 =?utf-8?B?YjJnWjNFS3IvSWw4VTY0M3VoazcvU3EyaDRVU1JjMnR2MnpsVGNMRERISGFF?=
 =?utf-8?B?Zy9nWk81MGQ0TS9DSmhuTVFGNEcwbGZ1cm4yWWswVmo1ekdJRithQ0dVYWNX?=
 =?utf-8?B?S285M1FCcFk0b0duKzdoeG1YSTQ0VFNIcTVPN241WU9rTFpNQWJqendBM09j?=
 =?utf-8?B?elBvbkdEZlg5Rmx0Snd3U2x3ZVlxTUxLTDN5SDdBMC9kNG8zSU45b0dhMXEv?=
 =?utf-8?B?WWFuY1QxQ01zaW1VMWkvY2w1amxhZUpFZTE3cjcwRjRTSWtBQ1MralVKZWR6?=
 =?utf-8?B?UXlJL2Nlczg4M3dzdlJQd3J0S2hTUlRLVDl0ajlqR3laSHRDeDdRQW85TlRY?=
 =?utf-8?B?RWJ0K1lERjNzNXl5RmJUZ2QvYVBtejJhWlhmc3QwVTlqTmgwc1lZU2lTaGE5?=
 =?utf-8?B?TVFtZVNuUFZsRXQvbnNFc2pwUmQvNmJSdGZrY29tSFVrdXRxRGcvMzF2YlVF?=
 =?utf-8?B?WXRIMTExR29PZ1RBMTlYdno0d09TOXYyaGlETk5rUjFsSTVHcUVNZEtWMFRq?=
 =?utf-8?B?VVR5MFV5eFpwQjlLWDVoK3psak1MRTRCb1A3aGY4U3F4cTBXUXFaL0g4WDEr?=
 =?utf-8?B?TUNiNkFrbjM0T0JWOXdxS1FRbGVyaHU5TU1oVVRFc1pxc29YaWdDMk85NnRt?=
 =?utf-8?B?Z1R5SHNENDFYZDYva0tWbmlPSHdLY3BPczlKcS9KTmt0NXpJZk5IZjBhUnlX?=
 =?utf-8?Q?lq1fY4+9I6hfIb3cFuwNeN9DYZpREoz9?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?eUR3UlBTcitPTHNqY1VWcGFNSVhwNzhzUHFqV3FDbFNJTXMxTGg1THBMWVIr?=
 =?utf-8?B?U0hpQy9vVS9oamNxdTZpbE8ybndCNjVNTWFYUE9vdnNPdTRSeHhYUVBrOFE2?=
 =?utf-8?B?TFZ1VzlFSERUd2NVb3JqSk1QaUFrM0dTTXZ5MGVKWExtVWh3UHJEdzk0RzN4?=
 =?utf-8?B?L1ZlUDNJV2ZYUk5XbnM0a3gvTTYvUzg3aEswZWJXZUs2alFkRXhPNXRWVTND?=
 =?utf-8?B?VWZTaU15N2pERnFLMWJUTWtNZS8rdHNxVzlSU3dMMHBZdkZXMzV0eUROU3Nh?=
 =?utf-8?B?bnpWTU5WclhSMmpJbFRZY01MOVQyUi93WWhKZkx0VGJkZk44a2FZRUJKdjNS?=
 =?utf-8?B?QWNRYXZTdXJvTDlEb3U4bWY4NHQwajF5bHhTdGQ0c1RxaUR6eUtjeGxhS2w3?=
 =?utf-8?B?dWNaZWtXRjExWWh0RU5TeHI3eEo2R2MyVERyMnRnRkJOU001Z2JrVkVBdXBp?=
 =?utf-8?B?dW04elpJbzk0TlhnVVBZMW9WVzFzdjRQeEIrMCtKcDRFUU9LbUZLbHpQNEZu?=
 =?utf-8?B?RUE5aWNsd3pJemVPMlpnc01HYzduOG5NUTZUQUppSldNWTNPSUJoT3V3dmVK?=
 =?utf-8?B?d0syTlV0YVJKWlRFZWhtdXdaUmNRK1ppT3JrTkpEVG1zRFNla2xaL1FMWVRR?=
 =?utf-8?B?S25WSm5mVytXOERjU2hQbzBNaHk4azEyM2ZVb1NOY3FwQWw1TDZaMVdhMG81?=
 =?utf-8?B?WXNyNGNlTnZmOERFamNIMm8rUHRCd3RzUGJCUE5NQ1hVQXhyZ09ydXJMOUtF?=
 =?utf-8?B?dnFyTTUva1M2SVdpd1ozUHJwYzZpeDc1WjBBaENJRGFPVHRYOVJFenJ1ZkJG?=
 =?utf-8?B?RHFKeDdhWkRyOHJYZFlCcUFZWjV3ZzhySlZoTXVNMGJMOVFSV0I3TjdGRzYr?=
 =?utf-8?B?UGdjOGFpMnIyaVJYTE15aUpVZ21ETDZkLzZZbXdINVlKMjB6VTNLRFplZWV3?=
 =?utf-8?B?MFdZOTNiU2tHY2U3WDQ0UktEeDMwUVNxTFhKY3ZXTVB2QVJHd091cW9xN1kz?=
 =?utf-8?B?TjBON3ZyWUg0NHd0Z0p4NUhEaVNsYVRQV05OaUR1dzZBRjBDVkVQcDRMOGVB?=
 =?utf-8?B?dHJia1lKaVA4Q0M0Y3BJNzMzdHRPTEVONi9aYjdzR2dBZXRsVWlDVXM1QVZF?=
 =?utf-8?B?SHpJNzdmSEQ2WEJWVUFqQXhiNnRrc0RWV2RCQUt2aXRvOGRjbHRxNGFmWU5Z?=
 =?utf-8?B?NHQ2TFJUQVhjQ21GRU4vdGFzRXE3bW1yMnFCNEpFWXFXbDdiT0ZVeDJVSTNt?=
 =?utf-8?B?QWdiY29VS0VCOHlPZHBPKzlGd2QwRmxrM0JtV1JrRHZsd3RiZ2ExQVJjdnM1?=
 =?utf-8?B?TXc4bGlVYndjNDg1V1NLYnZXYWRFZXlGNjMySHhyRkp1aUtlN1BKSml4eU5O?=
 =?utf-8?B?Zjh0dFZSeWFMQXBJMElobWpmbWI3K2xJQlNtQ0VuMDF6WnAyWlBLUkk4QVhD?=
 =?utf-8?B?U0NGMkVqQXN2V3VWUFg4d3huU3VFdEVnRmJIam5zU2o5MlYyY2tNZFc2d3dG?=
 =?utf-8?B?RlpFK3lDa2VmWHJvK3dBbVVnZW9paFNqdEt3cEYrVjFPU3pneTJ3R3AvYzhI?=
 =?utf-8?B?SVVOSDNNWTdadVBDSWhyTzIwY2xpa25uZHo3RWJ3U1pWa1MwYjE1NGM4ZnZX?=
 =?utf-8?B?WWZTcFBheWhwbzU0OGQyT0F6Q1JubTFlakI1aHlyaU1HOGpEM2ZENW9nbjkr?=
 =?utf-8?B?MFBvZ052RFNPUTJvNVFBcTdibDMzQWhMenpHR3BkWjIzSzFLdzVsSkV2K1Ju?=
 =?utf-8?B?QjFWU2J1a0VNcDRUVHRTcC9vTFBnUzhDMTJ5ZEk1TmtDNmVFNWZtK0J0OWtz?=
 =?utf-8?B?S3dRSXRkZ3dZK1BOaUhlZG1HV3ZvdHVwSis5eTI2ZmRrbHdlZEpnZlNFUmd5?=
 =?utf-8?B?YkpWam9EQlcwZ3I0TkIzQUt2S2p2RVBjSmxhYWJiSFFqWTJ5RWhzUWRyUEZO?=
 =?utf-8?B?dEI3RTMva2s5Z2VKYStCOFN0N2hSZnptMTBiWnhxVFJFTlh0TVQ1WFhvZnFE?=
 =?utf-8?B?T3dCVGNnK2wvd1lFT1VBQ1BSVzdHaG5TRGYwNTZ1Z0dkMjV4RmUrVTJydE4z?=
 =?utf-8?B?RTU2V3FLOCtQL0x4L3hEdzRxZWhzM3ZpK1V4L0h0OHdDMjBEMWQwditZMVRE?=
 =?utf-8?Q?PGlcLIu/6pFkQUJo2gIRlXLFE?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	oqhR32bBc7Y78t7R3PdTdqVxThNzniYdUp0zoNhv6ImUF0PJdFa2NSK9kefKwDEQl+ktnHsSIu/VkwMjukHBX+VIY8JmgqTTYV5kcUGzSAXLexbO5INDTx7WQ7xUf2+gbo1p/gnz39dJxbzZI4bbAo59ZqfItU4gRgxxm59YjZOPMNANAk+CB7ANQ2xbEAEpuhLnuz2BoUzyr1vbZzvzJbythu58c/fhNW6YHgRSvNKVEAzjJRb2T5T0TAw/804ottaYEd5MxA8qqJ4q/iu9EqtRW6rUQT5sFQGQJyPyECD27F5QJHlPgn/jZKoF6Nel5PFpuUtVTtJ7tjtaaj1UqIWXNMkq3NRW1PfJpASwCn2qk0S85ZSh4Br4mo9jIvd0I1ONmF08O49OeZR7k/DxoxmtatmvQm79hcoPUh8NVzkDTUlIo/EAXZ/RKUjOZte3Q/ibcDz1geeJ1q82CvI0uuzg8vU1pTSNziUgzbVIUUziqEMFaivjRRs5xBNaoC4UZFrvlVhv+A2YtSEVl+xXyrZT75QUntSAntUP/6gtNSYgGC3wAQeN9rVdD/AmmAEIcXRSP5l0U4zNNK2LKdzY8CrmDyXIT0hessZGjeBQcCk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7191523f-f572-4ae3-939b-08de17b8faae
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2025 13:33:58.1788
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YiQJG1XLDptD/HeeyDQnZhL583ADrP2worCaYPstlotEPNEfMwvzluLhg5PE3N1ZVYQD+b2+2F9LVwkHnpjzOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4341
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-30_04,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 malwarescore=0
 mlxscore=0 phishscore=0 mlxlogscore=999 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2510300110
X-Proofpoint-ORIG-GUID: QcvOghL_I8B5UfiAhSyx9Q_Ti4NeOAwV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMwMDA5MyBTYWx0ZWRfXxX035X+dcKrx
 alN8vpnzMxGQ0ILEPFzbJyvMZIc/BNH0qpSfZ1IUzeFao0mTTTZHoEJt9PnX22vrkA7lnix55i4
 S58wSsb95jIAIDdF6rsfC4ttzuS/wj6uUgASC3SvCQpeXzIVRxZC4wape7VtHReNSmEfyzwfgwh
 ASQkWn2SoXqcnYpWFij8UP747tbc810CnqURp9VUry7ZX+Axnr0mxx0DGtBCWhq7cxKkXlvZt8p
 TcbzfU15VAD+RczknoHNqoa78VZC3huuYQnIOgl0dIDjr6JMyQVYYxXmryqO1Jui7eUgM85ECzL
 m6FHdZbXiutdXbge3YUQ2j6HkTCjKtwgWjFUQSxwA9a8WUc/qgRj7c6y7WnFrdo2alc0ztXOkPt
 38z3ghovfMn1moO+YHL0c6B/Lpi7G4KF4I2L3k4KTP9WzbwDg0A=
X-Proofpoint-GUID: QcvOghL_I8B5UfiAhSyx9Q_Ti4NeOAwV
X-Authority-Analysis: v=2.4 cv=YaywJgRf c=1 sm=1 tr=0 ts=6903694b b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=yPCof4ZbAAAA:8 a=sGNrE1U84WATv7g4QmUA:9 a=QEXdDO2ut3YA:10 cc=ntf
 awl=host:13657

On 10/29/25 7:28 PM, Dai Ngo wrote:
> The reservation type argument for the pr_preempt call should match the
> one used in nfsd4_block_get_device_info_scsi. Additionally, the pr_preempt
> operation only needs to be executed once per SCSI target.

As hch mentioned, let's keep each of these two fixes in their own patch
with appropriate Fixes tags for both.


> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
> ---
>  fs/nfsd/blocklayout.c | 17 +++++++++++++++--
>  fs/nfsd/state.h       |  1 +
>  2 files changed, 16 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/nfsd/blocklayout.c b/fs/nfsd/blocklayout.c
> index fde5539cf6a6..4ca6cb420736 100644
> --- a/fs/nfsd/blocklayout.c
> +++ b/fs/nfsd/blocklayout.c
> @@ -340,9 +340,22 @@ nfsd4_scsi_fence_client(struct nfs4_layout_stateid *ls, struct nfsd_file *file)
>  {
>  	struct nfs4_client *clp = ls->ls_stid.sc_client;
>  	struct block_device *bdev = file->nf_file->f_path.mnt->mnt_sb->s_bdev;
> +	int error;
> +
> +	if (ls->ls_fenced)
> +		return;
> +	ls->ls_fenced = true;
> +	error = bdev->bd_disk->fops->pr_ops->pr_preempt(bdev, NFSD_MDS_PR_KEY,
> +			nfsd4_scsi_pr_key(clp),
> +			PR_EXCLUSIVE_ACCESS_REG_ONLY, true);
> +	if (error) {
> +		char addr_str[INET6_ADDRSTRLEN];
>  
> -	bdev->bd_disk->fops->pr_ops->pr_preempt(bdev, NFSD_MDS_PR_KEY,
> -			nfsd4_scsi_pr_key(clp), 0, true);
> +		ls->ls_fenced = false;
> +		rpc_ntop((struct sockaddr *)&clp->cl_addr, addr_str, sizeof(addr_str));
> +		dprintk("nfsd: failed to fence client %s error %d\n",
> +			addr_str, error);

Instead of a dprintk call site, would a new trace point be more
appropriate?


> +	}
>  }
>  
>  const struct nfsd4_layout_ops scsi_layout_ops = {
> diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
> index 1e736f402426..1de4acc7d539 100644
> --- a/fs/nfsd/state.h
> +++ b/fs/nfsd/state.h
> @@ -735,6 +735,7 @@ struct nfs4_layout_stateid {
>  	stateid_t			ls_recall_sid;
>  	bool				ls_recalled;
>  	struct mutex			ls_mutex;
> +	bool				ls_fenced;
>  };
>  
>  static inline struct nfs4_layout_stateid *layoutstateid(struct nfs4_stid *s)


-- 
Chuck Lever

