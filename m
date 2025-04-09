Return-Path: <linux-nfs+bounces-11074-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D461FA82D04
	for <lists+linux-nfs@lfdr.de>; Wed,  9 Apr 2025 19:00:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 657591B6500B
	for <lists+linux-nfs@lfdr.de>; Wed,  9 Apr 2025 17:00:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70F35270ED7;
	Wed,  9 Apr 2025 16:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="T8Hi38gk";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="lZYlV0W6"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54CCB270ED1;
	Wed,  9 Apr 2025 16:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744217968; cv=fail; b=GIX26ZBV2PsZCo4PQwedQxqbh8SD+MqbJ1l3fM+a8PK4mhCnbiPz0LxrjSFEcK9Mxj3esycfMCoGelG0tv1JcfYgGgJlCmJcO5ec1/9N91vBfTOjFNjYXj+qfmmUX/07K79ZreyjyPs0pGp/z07EBy0vIJGEqRurDW867qUOSTI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744217968; c=relaxed/simple;
	bh=x+TBIizkUwrRE6IbH4zdIhXxfIKoI2xcvjFUK/kmV70=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=aeAjxvJI7z2oiVDk+RtSaHSl6AnhM1ZGHUgOKEWCXMA/WDOi8PPI+SWyrhFIv2o2g4iBQytoR8CVX2XKX1etyejElrrFNmop+ulrxmiB9/rJzh+Mh+gKi7nbSRq/PBYNuRITZaxCZSvO7IfO3VKpIyme6AMzDaCx5JzLWQfWbag=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=T8Hi38gk; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=lZYlV0W6; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 539Gu3oD029296;
	Wed, 9 Apr 2025 16:59:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=gX7ox3rVkCGbWzGggzHLFzqCccGLQ0IkYP1dUaSALRA=; b=
	T8Hi38gkQ9LmgIXSGV52dvJAyQH1NvttseTp3Wwk5C3uBkqaUi1biSQZsf6USlFg
	rXfjuVSxM8rmhLzPMLW2R0ONx0DPEacUVe8E4JEHoN/CsUmrJJtEZtseeIN9PaW+
	xAQgYrJiR7epNWmw8atOn+Obicu3SI2ydkb7Sko2veBNEsYhg3BF4BioNtK00XzJ
	5I8iVNPJsgncs0Qbb0vYrZmL7XdoxBGsnE+PGL7O+VUE5rD+ywjtuQVyl/xHva3o
	+ZapgkrVJK3/MSk/rlkoXolgvzlMb5fnmJCJSqk6YBJ9VijXSWiQtwyHixHRIeuz
	8UIJ8UDjLAlO5dQUVQ0utQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45tua2yp20-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 09 Apr 2025 16:59:15 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 539FTkXa013743;
	Wed, 9 Apr 2025 16:59:15 GMT
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazlp17010006.outbound.protection.outlook.com [40.93.1.6])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 45ttyhcsj0-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 09 Apr 2025 16:59:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m1MojCTGILquBP6nBnEOAilBAeNMaHykiAN2C4JS6xQH4ShXdXFsJzg9IZ0WaATsvIQK3iryFfUo2aMd+TvnTZ3jI/USOVGBsa+ef2Xe7314KWbKiywkwviQN7hbq8usHxd3pPcfxc1CPzKC9K2d8wQTwyRVFzvlsHDaWWhvHkE5LnTLyQ7OzgPnzXRFiaQr6eyeHoEA6W8tLNY77D+govEA+q3ne6lds2Yt3unCKaLPJNjJQoKXX8CFIE/x6YXzRrXCRAd8h8Q+9oscDnhbbzu5UOZyel0SNuSXawBV39gJsICwvbKHV1awVeHOGeZ81HKhWstGEYb4OfK4ESPfZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gX7ox3rVkCGbWzGggzHLFzqCccGLQ0IkYP1dUaSALRA=;
 b=ngo8MrTEE5POqcw0gBFce/DGC1ORQJvr7PqqmNMhJ75lxDB0ye+MsAoDfvwbAu+W9rGD8zgHEby5W1s7kcOBGG+LO8Q2BBmmJ2ZGelyqAa88KNM8Qy2QSANgueGMDuH4PVBD1MWHB3ilf+HGv9R8kGuAFpfwJ0skcIoEmhwpv++DoIeZvLv4DN83or4WLaYzLUm9soHqn1zRlmwi2sczd26fZQ3JX2oJBKB3Uthr0IzDNGGKgWwQrW6f0UBu1pbDc5uO+1EA3Gk48ntw+aH4VsthZU83ZcBOj8LeoSFcjNGdIB22O9YbbcwKt9guhrkRrxv1UA8Jji5bbijBN6HcUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gX7ox3rVkCGbWzGggzHLFzqCccGLQ0IkYP1dUaSALRA=;
 b=lZYlV0W6D37lGc9ODF49VqliQQrI8SIgdWukzy71ebkqA0KEd0E2rlIkw5qVIi+vrptBA+ZwWQ1StljYNq8Xkd3XfSdkkBqc9F4IynS0sCrBTr2/adj4wZin39VeZS2ufaomXpH7F+WnMVilkam6JnOGcWG5/3gAa6hfT3j/mjg=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BLAPR10MB5201.namprd10.prod.outlook.com (2603:10b6:208:332::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.34; Wed, 9 Apr
 2025 16:59:11 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%7]) with mapi id 15.20.8632.017; Wed, 9 Apr 2025
 16:59:11 +0000
Message-ID: <d86eba8a-f977-45ee-b58d-4de0892068eb@oracle.com>
Date: Wed, 9 Apr 2025 12:59:08 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/12] nfsd: add tracepoints around nfsd_create events
To: Jeff Layton <jlayton@kernel.org>, Neil Brown <neilb@suse.de>,
        Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>,
        Anna Schumaker <anna@kernel.org>
Cc: Sargun Dillon <sargun@sargun.me>, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20250409-nfsd-tracepoints-v2-0-cf4e084fdd9c@kernel.org>
 <20250409-nfsd-tracepoints-v2-6-cf4e084fdd9c@kernel.org>
 <078a639b-1f19-48e2-a0cc-f861b67f34c9@oracle.com>
 <df78d9806222676667eac8cee4b5ce26ba0e7e10.camel@kernel.org>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <df78d9806222676667eac8cee4b5ce26ba0e7e10.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0363.namprd03.prod.outlook.com
 (2603:10b6:610:119::32) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|BLAPR10MB5201:EE_
X-MS-Office365-Filtering-Correlation-Id: 68871eff-0af2-4057-a952-08dd7787d99e
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?N3VaWnZ1OVRTMTlLc3VBeFgrNFEza3ZVUkJFKzhhVUVXZXlBSWh3WXViVHN6?=
 =?utf-8?B?c3NPSzdBLzBoNU5kbk1NYkV6cUUwZXliK2w3dEhjM1JtSEhoRFkxYW0xZllF?=
 =?utf-8?B?dnBqNVFwT0lIMWl0TEJ4MmpGdVZPSjBSZ0g3bE5wSVNta1FEazFrbE9pR0g1?=
 =?utf-8?B?TWpzY1lXSklaenJzdVZ4VWR5RXBlcmVNcU9EVlFldGtEbU96Z0NUYW9IMDAy?=
 =?utf-8?B?RkxUNDV5YnFVOWRVL1JmL04rYzRPblBhODEwbDBkZnFHcVB2ZExkeEoyQ1Fi?=
 =?utf-8?B?anFYV3h2Qm8yYUxxNHhReWVHdGhZclc3Y012WkpaTkZPSWsvK2FLQVE2NkZx?=
 =?utf-8?B?STNHL1krVnA0T3Z1Z1ZDS1doWmNYQWFvUFpueERGTGJTSWw1TWZMNjA0dTFj?=
 =?utf-8?B?YzF3NlF3aXRTSGVsU09SNXg5UnZEcERWaGVGLzN5WCsrU1ZFUkZ3cXlkbjVi?=
 =?utf-8?B?RFdXM3drUXpMdFVVaDJ0ZlNQNzdqT2htQ29zalZQNU1BSm44YnQxV1ErQWdD?=
 =?utf-8?B?TDJQNDJBWmF1cGFtbVhRam44ZDFjYzBJRE1rUDMvbytESWRiS0N5L2VHaU13?=
 =?utf-8?B?b1VWTU1IcllmQ0lScEtPenV6YlpuOHZHWktHVExFUWMvSFZsNllQWTNHdWFZ?=
 =?utf-8?B?THBRYVd0T3pXUVFZclhUcUpISUVTalgrUk1Jd2dUekw5a1lWUWZQZHBNZmRC?=
 =?utf-8?B?N1Vva3ZkUkNUMzRpZlhIa3BHTExNd3hxcTl6Y1dFUkFNNjVMOVoyWEpUU1lk?=
 =?utf-8?B?YW5lb0xPQ0x6Q3JOTldQY2J6M2syOTlVb1ZmeENSaWwzRWhCZ3FSKzVOa0k2?=
 =?utf-8?B?VWk2TTlHWEgrUGhkTHIxK2dCUzNISHp3cVM3RmNuMEtMT0xYR3VaTXdzbTBP?=
 =?utf-8?B?Wm5pdVJkVGxLUXA2ekZyMXU1dTJKVWpGenN1OGgzWlVSSmpJeUthOGFYQ0Yv?=
 =?utf-8?B?QmREWkUwOEIyaytaWXJUL0RjUk1mTGVVdCswYlkzT3hBV29ZZ1JPdjh0alVW?=
 =?utf-8?B?cFJuQ0sxdVJhMjRaRm1EakY4ZlkxaldrVzltcjFOUTQ2aDg1V0pyNzNKVTUw?=
 =?utf-8?B?ZXhDWi9oK0h3cTlGQ0pPb3pjMzBsQjlacXVSMUdlbWFpY2wweE1sbm4weGcr?=
 =?utf-8?B?NDV1cWFjZGtMQWtFdzdIR0RZdURkL0RpWWZDM0s2dVhubEJrWUM0TkhhRTYz?=
 =?utf-8?B?ejNQMm1HUjVqbkxteWdQM0pNT1FtOWNoWUhtTUtKbFM3V0RkaWdIcTdPbDJK?=
 =?utf-8?B?NlUrcWRoL01rbHczc0pla2ZRTTRjTEFIQlUyN3M5bkl3THFpVzcxRUpoS3pq?=
 =?utf-8?B?U0lhTC9nZUx2WHBrYXpGSjF3RThFb2RDRzZMZWNnY0NTeXlzTEttUTBkL2dy?=
 =?utf-8?B?ZUNFOHZUYjFnR1IwMGlYVHpzbVFWcGxBNnVidVV1aktqZWN6VzlGcnJOVWlt?=
 =?utf-8?B?NkJsYTF5L0gxeWVhUGNpMDV0cmFLcVFPSXdxRldPL0xTVjZtVW5KNi9ZU1F4?=
 =?utf-8?B?dnEzSzFxdThiMU9DdHRuR3paa1Njb3FiWlEvUUE3TzYzUStmd1FsaEZFQUV2?=
 =?utf-8?B?dklrUDlYZEp2a2RQakhsSVZDbE40N3Zwc21BWGRSTlN2WmxzL0FOVzJyMlhm?=
 =?utf-8?B?TGZ0VFV0TWxIRTN1NVM4Q2N3TnJMOVRZeFJSQ1BZeXZqQUduM1FuSFRxVGJy?=
 =?utf-8?B?MS9kSkZXTEF4aHpyWWRZeS9sM0ExbHcwdTcycStsTGtVU0xYc0NTVFJyUU9Y?=
 =?utf-8?B?dEZiTzRRQVJFdmdpNlZJMy9yYlk3N1RRelRPTUFFbGpoZUljVVdiWU5rQzlv?=
 =?utf-8?B?QnhUclpZTG93aWRoWjl5WlBoVlNhT2pxV0hKZ0xGVlI5V1FCL0w3VGlON1Zw?=
 =?utf-8?B?dzhOMUppanhMVll0THUwRFZ0WjEyTldBK01uK2VuZ0tnaTFZSkkvMWNQa0p1?=
 =?utf-8?Q?UJHyUq++eOI=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?YkE3NnVHbkJEMnRvK3VUaGZlaFE3Q2gvQ0JQUW4zbEZmZUo2YkxqOW1UR1lp?=
 =?utf-8?B?QS9Hb3VnNzh6YjJmNStNU1BhOFhLcUhqaVlBWXVFUGxKRVhZZHA0R2htWHF3?=
 =?utf-8?B?MVVKLzUxMmtPZzEvbUN3aS9obkl3YThSQ1E1TlBNOVRGMEQ0dFh1REFpVlp6?=
 =?utf-8?B?QzJIZVcwY0gvNU94M3d2aUNZN0E5a1BzOUZZRXRVYWI2bjNyeTUrMVFOaG13?=
 =?utf-8?B?MU1uVE5xang3bXVPRm84REtmdGV1SWprem5lZ0NFMjZlM1ZZUEdXV1lld0VJ?=
 =?utf-8?B?QkVBaC9DUnM3VUlRNHl0VFZPa25WdXZ2TmMyUEgzdnhkMWpGdmJUL1BPcUVQ?=
 =?utf-8?B?U3pzc0hsM09EeGdOMko3VUJGdEVuN1VQN3JaK3FKRkpNalNBMDhGdG5odXZx?=
 =?utf-8?B?RkxGejJua3JoSVZhRW52ZjIrcVhKSjI1SmpNNStKYkZtTmtYTE5oNTVkZUdo?=
 =?utf-8?B?THc3ZzRlem1XTzg4QzBhUEFRNFgyMHowZ3hmY1NZdklxc2N1TzVGNU4vcUhr?=
 =?utf-8?B?OFptdTRCRDBpMnJKdVZiSDZ4TjlNZFp6bFdlbTFlV0FKUjBMalFlNGM4V1Nm?=
 =?utf-8?B?SENqZ2puZER2cERSbUpsTTlEUXNiWUk1Vzh1bE01TlJBNW0yMlpCWmJuUFBs?=
 =?utf-8?B?QzZlaU4vRXM5ZnZTUTlNT0JhY3d6SUR1QkhOTXNVRDQzbXVlWWY4azdFYk5z?=
 =?utf-8?B?dGxsZlVXYjY3VnVxV0EzdC9VS1RzYk5seVZjck41azhRT0tRUS8rUWo5SEdx?=
 =?utf-8?B?d01jUVptWjd3S2VSUFROUlpncUxVK00ybldDR3RRR2pQazdQRXkvR1YwWmln?=
 =?utf-8?B?N05rUlpHcFM2eUZKS1RDNjJIYWRIcjgrbEQ4bm5KcWdEVEtxUXFRTVU4MjVa?=
 =?utf-8?B?Y1RkOHJCcXZXSmZ4V01tNW41bjlzN3Q2OUpHTDFxaEpKL1Ztd3I4U2pMSThz?=
 =?utf-8?B?UlB1Y3lQZ2M4dWs5Zm5lbExVRjdoblRZaVhBMjFmZFpDSkVrSzg5YmxsWjFk?=
 =?utf-8?B?RzdSV2pZNFR1ZlFHNVgvbFpLdlE0TWdhN2w5ODVqVTBUM3l3U3ZITkZ0N004?=
 =?utf-8?B?Yi9qRDgydUZMU2pmNDlid3hPY3NjZmZLZ2pzK2tGcmo0eEJ4b2R4NTB1aUZR?=
 =?utf-8?B?bGYxL0ZxN0Npd0tFakxBbEdTSjRtOTNicmIxb2RENjdwQUxNbFZkZThUVGR6?=
 =?utf-8?B?aG1KSDZDL0xhTHFJaERhSlNIUy85VEtJVTdJQ2dQQkx5SXMxSGdpSVo5aDJk?=
 =?utf-8?B?cjR0emxacjdCRGNGYkNORXg4c2RXc0Z0ZTllNzMzekkyT2NiaEVMbEJiYkZI?=
 =?utf-8?B?WHh6dTV3dWE2VWxnMEJYTnFpVmY1ajgvS3pRc3BSNy9vSVhEWHVCa3BQR1Mw?=
 =?utf-8?B?VmkwZTYzaHFjZzVHUFBmcGxUM1FydWI0dzdvbEdVVUdoeFdBNmtpOE83RU9V?=
 =?utf-8?B?elVuVmZsZ2cwSTdIdzkzaUwzSDRSWk5ybU5wN1d3NWxVT1VGK3BxUU5XaXA3?=
 =?utf-8?B?bGhWTXY5S2VsTWI5VVJ4a2I5RDNRc2IyQ3lwODVWOFVUMEpUMkp2ZWpqVDBW?=
 =?utf-8?B?SEJBVlZpblV4Q2wrQnhjcU5ERFloTkFlV2lSWGdaM3JkUXRYSUtoT3dUS2ha?=
 =?utf-8?B?dDFTcDZEeExNNkM2alVUNW1SYndaY0I0UGdMT2dnMTB6ZDdPTWRvMXJqR29u?=
 =?utf-8?B?RWR3Z1hueEhOUm9JU3FJVlp4bnYwUGticDBUU0EwR2lESjU3b2NZNWxJVE4x?=
 =?utf-8?B?VTd1eXZQRjNaZWJqMUU3VXpUWkN1UkxYNWV2QzRkM2p5YmhRZ0JOUmM0VUtU?=
 =?utf-8?B?MVBYSTA0SXdPenVBZGlEWFFsaHl5cnNLeHR3cEdlUVo4RW5TWmpPWHlRalhW?=
 =?utf-8?B?Ri9BR3g0d2pRaElXRDlJdmdWSkp0ZWIrYmQ0Y2hMcmV1VGhVUUM2VkR5WTgv?=
 =?utf-8?B?S09MRlNKRkFXcnd0SmtZb2pWZUxUalZVdU1wMkZvMkUvOGxOQWVPQTlEVVNU?=
 =?utf-8?B?OWh3ZzZUQ0dQd0pPdXFSSEZoS2JZMk1Xc1pESWVOdXVPdGVENlBETHpDczhN?=
 =?utf-8?B?WURMekdBakNMVnFBeFdLUXI3TlJMeFJSekN6V21MY0o5NWhTSjVhcFpla2lq?=
 =?utf-8?B?UWgraUhianRJcXQxVnpwQW1tbTd4Z1lGSnZoa2ZwSFRobm1yZWR4YVE5L2Vw?=
 =?utf-8?B?UkE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	SCtW1xfoufP8Aqs6URX8ileFfI0HWJBxOHIwx2Me5DVbqd5OJLK5cd3yvLBN6Sx0xh/3KsWBPFrDG4gZMFsKV8UgLDv6qjupEMkyS1XnWx3HghtStj6SMpEZLhBlbU8c8Ic9LvPP+M1raQVAqwDH0KW5KbEOiKvY/TCILRvm3NJhoFZNUIrdU5H1bgRPtwLrjYQZDo/yApNy6j9bQT6TuvT0PLBFLRKkCZu6GWrNXZkSFskCF3id9z0ImBhR0gUbedGtcebd1rr+J7mpdHgO5fWtMM0quOh43Qf6nRTnRkOnnVnGhzMK/Xw7GL3S0mKu+5b4KQl1Drs3XC/cPWaRv7WA7mnr3Q9oR6VEFHOUV8QFCtJJgrCeA53HD9YxO+qeQBp/8zBK+q9S+GUXWgy70ZHI9E/lO5nJuQICInPtjmjdjitXXD7I2N3bJa19szIooI+zwcf6a3+E87j7bv6Kj4Ipo988bfPEZ9OL54XbxESSHNCH+j1ufnBDOjSQwquyinRF3f15RU4xpcY5ofDbbi0ZPzazerMx4vMhT89zSQ/YQrcSwMGct4MP/MKZ9H740b9MYgyay9EVAVmZKAT3S4VtsOWg1+ABsJIdtNfagmc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68871eff-0af2-4057-a952-08dd7787d99e
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2025 16:59:11.3245
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Tz4ucZU+W+KYS2rBkvqxo2ayUY35bJrOQfXqpvtvDiybd6s2/txyGVobKaUFZvG/F0QVZc7uxN7whkdnWDNeeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5201
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-09_05,2025-04-08_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0
 mlxlogscore=999 bulkscore=0 suspectscore=0 mlxscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502280000 definitions=main-2504090109
X-Proofpoint-GUID: PLnw3iBJOMj0wOdm3ZQ2ruDED3Fh8T_5
X-Proofpoint-ORIG-GUID: PLnw3iBJOMj0wOdm3ZQ2ruDED3Fh8T_5

On 4/9/25 12:50 PM, Jeff Layton wrote:
> On Wed, 2025-04-09 at 11:09 -0400, Chuck Lever wrote:
>> On 4/9/25 10:32 AM, Jeff Layton wrote:
>>> ...and remove the legacy dprintks.
>>>
>>> Signed-off-by: Jeff Layton <jlayton@kernel.org>
>>> ---
>>>  fs/nfsd/nfs3proc.c | 18 +++++-------------
>>>  fs/nfsd/nfs4proc.c | 29 +++++++++++++++++++++++++++++
>>>  fs/nfsd/nfsproc.c  |  6 +++---
>>>  fs/nfsd/trace.h    | 39 +++++++++++++++++++++++++++++++++++++++
>>>  4 files changed, 76 insertions(+), 16 deletions(-)
>>>
>>> diff --git a/fs/nfsd/nfs3proc.c b/fs/nfsd/nfs3proc.c
>>> index 372bdcf5e07a5c835da240ecebb02e3576eb2ca6..ea1280970ea11b2a82f0de88ad0422eef7063d6d 100644
>>> --- a/fs/nfsd/nfs3proc.c
>>> +++ b/fs/nfsd/nfs3proc.c
>>> @@ -14,6 +14,7 @@
>>>  #include "xdr3.h"
>>>  #include "vfs.h"
>>>  #include "filecache.h"
>>> +#include "trace.h"
>>>  
>>>  #define NFSDDBG_FACILITY		NFSDDBG_PROC
>>>  
>>> @@ -380,10 +381,7 @@ nfsd3_proc_create(struct svc_rqst *rqstp)
>>>  	struct nfsd3_diropres *resp = rqstp->rq_resp;
>>>  	svc_fh *dirfhp, *newfhp;
>>>  
>>> -	dprintk("nfsd: CREATE(3)   %s %.*s\n",
>>> -				SVCFH_fmt(&argp->fh),
>>> -				argp->len,
>>> -				argp->name);
>>> +	trace_nfsd3_proc_create(rqstp, &argp->fh, S_IFREG, argp->name, argp->len);
>>>  
>>>  	dirfhp = fh_copy(&resp->dirfh, &argp->fh);
>>>  	newfhp = fh_init(&resp->fh, NFS3_FHSIZE);
>>> @@ -405,10 +403,7 @@ nfsd3_proc_mkdir(struct svc_rqst *rqstp)
>>>  		.na_iattr	= &argp->attrs,
>>>  	};
>>>  
>>> -	dprintk("nfsd: MKDIR(3)    %s %.*s\n",
>>> -				SVCFH_fmt(&argp->fh),
>>> -				argp->len,
>>> -				argp->name);
>>> +	trace_nfsd3_proc_mkdir(rqstp, &argp->fh, S_IFDIR, argp->name, argp->len);
>>>  
>>>  	argp->attrs.ia_valid &= ~ATTR_SIZE;
>>>  	fh_copy(&resp->dirfh, &argp->fh);
>>> @@ -471,13 +466,10 @@ nfsd3_proc_mknod(struct svc_rqst *rqstp)
>>>  	struct nfsd_attrs attrs = {
>>>  		.na_iattr	= &argp->attrs,
>>>  	};
>>> -	int type;
>>> +	int type = nfs3_ftypes[argp->ftype];
>>>  	dev_t	rdev = 0;
>>>  
>>> -	dprintk("nfsd: MKNOD(3)    %s %.*s\n",
>>> -				SVCFH_fmt(&argp->fh),
>>> -				argp->len,
>>> -				argp->name);
>>> +	trace_nfsd3_proc_mknod(rqstp, &argp->fh, type, argp->name, argp->len);
>>>  
>>>  	fh_copy(&resp->dirfh, &argp->fh);
>>>  	fh_init(&resp->fh, NFS3_FHSIZE);
>>> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
>>> index 6e23d6103010197c0316b07c189fe12ec3033812..2c795103deaa4044596bd07d90db788169a32a0c 100644
>>> --- a/fs/nfsd/nfs4proc.c
>>> +++ b/fs/nfsd/nfs4proc.c
>>> @@ -250,6 +250,8 @@ nfsd4_create_file(struct svc_rqst *rqstp, struct svc_fh *fhp,
>>>  	__be32 status;
>>>  	int host_err;
>>>  
>>> +	trace_nfsd4_create_file(rqstp, fhp, S_IFREG, open->op_fname, open->op_fnamelen);
>>> +
>>>  	if (isdotent(open->op_fname, open->op_fnamelen))
>>>  		return nfserr_exist;
>>>  	if (!(iap->ia_valid & ATTR_MODE))
>>> @@ -807,6 +809,29 @@ nfsd4_commit(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>>>  	return status;
>>>  }
>>>  
>>> +static umode_t nfs_type_to_vfs_type(enum nfs_ftype4 nfstype)
>>> +{
>>> +	switch (nfstype) {
>>> +	case NF4REG:
>>> +		return S_IFREG;
>>> +	case NF4DIR:
>>> +		return S_IFDIR;
>>> +	case NF4BLK:
>>> +		return S_IFBLK;
>>> +	case NF4CHR:
>>> +		return S_IFCHR;
>>> +	case NF4LNK:
>>> +		return S_IFLNK;
>>> +	case NF4SOCK:
>>> +		return S_IFSOCK;
>>> +	case NF4FIFO:
>>> +		return S_IFIFO;
>>> +	default:
>>> +		break;
>>> +	}
>>> +	return 0;
>>> +}
>>> +
>>
>> Wondering what happens when trace points are disabled in the kernel
>> build. Maybe this helper belongs in fs/nfsd/trace.h instead as a
>> macro wrapper for __print_symbolic(). But see below.
>>
>>
>>>  static __be32
>>>  nfsd4_create(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>>>  	     union nfsd4_op_u *u)
>>> @@ -822,6 +847,10 @@ nfsd4_create(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>>>  	__be32 status;
>>>  	dev_t rdev;
>>>  
>>> +	trace_nfsd4_create(rqstp, &cstate->current_fh,
>>> +			   nfs_type_to_vfs_type(create->cr_type),
>>> +			   create->cr_name, create->cr_namelen);
>>> +
>>>  	fh_init(&resfh, NFS4_FHSIZE);
>>>  
>>>  	status = fh_verify(rqstp, &cstate->current_fh, S_IFDIR, NFSD_MAY_NOP);
>>> diff --git a/fs/nfsd/nfsproc.c b/fs/nfsd/nfsproc.c
>>> index 6dda081eb24c00b834ab0965c3a35a12115bceb7..33d8cbf8785588d38d4ec5efd769c1d1d06c6a91 100644
>>> --- a/fs/nfsd/nfsproc.c
>>> +++ b/fs/nfsd/nfsproc.c
>>> @@ -10,6 +10,7 @@
>>>  #include "cache.h"
>>>  #include "xdr.h"
>>>  #include "vfs.h"
>>> +#include "trace.h"
>>>  
>>>  #define NFSDDBG_FACILITY		NFSDDBG_PROC
>>>  
>>> @@ -292,8 +293,7 @@ nfsd_proc_create(struct svc_rqst *rqstp)
>>>  	int		hosterr;
>>>  	dev_t		rdev = 0, wanted = new_decode_dev(attr->ia_size);
>>>  
>>> -	dprintk("nfsd: CREATE   %s %.*s\n",
>>> -		SVCFH_fmt(dirfhp), argp->len, argp->name);
>>> +	trace_nfsd_proc_create(rqstp, dirfhp, S_IFREG, argp->name, argp->len);
>>>  
>>>  	/* First verify the parent file handle */
>>>  	resp->status = fh_verify(rqstp, dirfhp, S_IFDIR, NFSD_MAY_EXEC);
>>> @@ -548,7 +548,7 @@ nfsd_proc_mkdir(struct svc_rqst *rqstp)
>>>  		.na_iattr	= &argp->attrs,
>>>  	};
>>>  
>>> -	dprintk("nfsd: MKDIR    %s %.*s\n", SVCFH_fmt(&argp->fh), argp->len, argp->name);
>>> +	trace_nfsd_proc_mkdir(rqstp, &argp->fh, S_IFDIR, argp->name, argp->len);
>>>  
>>>  	if (resp->fh.fh_dentry) {
>>>  		printk(KERN_WARNING
>>> diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
>>> index 382849d7c321d6ded8213890c2e7075770aa716c..c6aff23a845f06c87e701d57ec577c2c5c5a743c 100644
>>> --- a/fs/nfsd/trace.h
>>> +++ b/fs/nfsd/trace.h
>>> @@ -2391,6 +2391,45 @@ TRACE_EVENT(nfsd_lookup_dentry,
>>>  	TP_printk("xid=0x%08x fh_hash=0x%08x name=%s",
>>>  		  __entry->xid, __entry->fh_hash, __get_str(name))
>>>  );
>>> +
>>> +DECLARE_EVENT_CLASS(nfsd_vfs_create_class,
>>> +	TP_PROTO(struct svc_rqst *rqstp,
>>> +		 struct svc_fh *fhp,
>>> +		 umode_t type,
>>> +		 const char *name,
>>> +		 unsigned int len),
>>> +	TP_ARGS(rqstp, fhp, type, name, len),
>>> +	TP_STRUCT__entry(
>>> +		SVC_RQST_ENDPOINT_FIELDS(rqstp)
>>> +		__field(u32, fh_hash)
>>> +		__field(umode_t, type)
>>> +		__string_len(name, name, len)
>>> +	),
>>> +	TP_fast_assign(
>>> +		SVC_RQST_ENDPOINT_ASSIGNMENTS(rqstp);
>>> +		__entry->fh_hash = knfsd_fh_hash(&fhp->fh_handle);
>>> +		__entry->type = type;
>>> +		__assign_str(name);
>>> +	),
>>> +	TP_printk("xid=0x%08x fh_hash=0x%08x type=%s name=%s",
>>> +		  __entry->xid, __entry->fh_hash,
>>> +		  show_fs_file_type(__entry->type), __get_str(name))
>>> +);
>>> +
>>> +#define DEFINE_NFSD_VFS_CREATE_EVENT(__name)						\
>>> +	DEFINE_EVENT(nfsd_vfs_create_class, __name,					\
>>> +		     TP_PROTO(struct svc_rqst *rqstp, struct svc_fh *fhp,		\
>>> +			      umode_t type, const char *name, unsigned int len),	\
>>> +		     TP_ARGS(rqstp, fhp, type, name, len))
>>> +
>>> +DEFINE_NFSD_VFS_CREATE_EVENT(nfsd_proc_create);
>>> +DEFINE_NFSD_VFS_CREATE_EVENT(nfsd_proc_mkdir);
>>> +DEFINE_NFSD_VFS_CREATE_EVENT(nfsd3_proc_create);
>>> +DEFINE_NFSD_VFS_CREATE_EVENT(nfsd3_proc_mkdir);
>>> +DEFINE_NFSD_VFS_CREATE_EVENT(nfsd3_proc_mknod);
>>> +DEFINE_NFSD_VFS_CREATE_EVENT(nfsd4_create);
>>> +DEFINE_NFSD_VFS_CREATE_EVENT(nfsd4_create_file);
>>
>> I think we would be better off with one or two new trace points in
>> nfsd_create() and nfsd_create_setattr() instead of all of these...
>>
>> Unless I've missed what you are trying to observe...?
>>
> 
> Now I remember why I did it this way. Doing it the way you suggest
> makes this all a bit messy:
> 
> Most of the callers create files via nfsd_create(), but
> nfsd3_create_file calls vfs_create() directly. It does call
> nfsd_create_setattr(), but that's really not the right place for this
> either, since it's doing a setattr and not the create itself. Notably,
> it isn't passed the filename.
> 
> Note too that burying this tracepoint down in nfs_create() also means
> that error conditions can happen before the tracepoint that may mean
> that it won't fire. So, if you're watching the traces to see when
> CREATE or MKDIR calls occur, you may miss some of them.
> 
> How do you want to proceed? 

You can see incoming RPC messages via the svc_process trace point.
If you want to see the arguments for the operations too, you enable
the nfsd_vfs_ tracepoints. It is reasonable to add trace points in
the error flows if you believe those are important to surface.

For CREATE, add the new nfsd_vfs_create trace point in nfsd_create()
and also in nfsd3_create_file().

How does that sound?

-- 
Chuck Lever

