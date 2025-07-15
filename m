Return-Path: <linux-nfs+bounces-13077-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 46247B05D32
	for <lists+linux-nfs@lfdr.de>; Tue, 15 Jul 2025 15:42:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD6811C2736D
	for <lists+linux-nfs@lfdr.de>; Tue, 15 Jul 2025 13:38:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 864062E7173;
	Tue, 15 Jul 2025 13:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="g7q+Pzy0";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="sFtknIRQ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 055F070831
	for <linux-nfs@vger.kernel.org>; Tue, 15 Jul 2025 13:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752586292; cv=fail; b=WHpiNxwHbxsx6nkG1qX4Iw+LggJ30mTVAU0sDSznBSwZfujkvVEPp4InomDAPF/T+CHURRXkDQSrXsu9fskjjUsPglNrC/TzUk0kFrsISovEsLuUbd9l1FxEovHU408q4hbqM9UNcSQhoPK3WR0VeVS7nOv/NhE49n2MZGdxEhE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752586292; c=relaxed/simple;
	bh=VCJd6UgM3hz+Pz8sfc+ue2IPKrbhXtdbqv4NWovcGto=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=uPd6ynm2FkNFtNVKYXBQjPFt1WaZZgZ8D4uol55W8crkbqqbNLDJVSXNi0QU/7yXAMi02cPfNOHGj+U7tnboYaAH2e1Z+jE7C23K7gPzU87B5MHt8e9YhGGcdz7rUMRakc53SAKA62z/2m5fZonQBKSUegvgWF1PW5OjwMAKX5M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=g7q+Pzy0; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=sFtknIRQ; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56F9ZKhX022726;
	Tue, 15 Jul 2025 13:31:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=7/obCewvwZgzPvzs6AllSgCzXL+2gypwQKAuH5IKbiE=; b=
	g7q+Pzy0jO0kLeqS5tbnOpO09kCyPawx+t2qepGHsraz5B1BMWmZszgrq/nuP6oU
	B1GCTpmDjO+y/FzY1DFXwXOoUi+9pMRDG+dTzkuqV+NJJfN8WG+h6tXNZKulN8a/
	s9N4Dn9xRXI13itpJsVpkhxXtRPkTNFgeaDDlYJwT73zr7L1xZ0SGJPR45avA6VD
	ag8i03UUoyTHc9zRvCjOCEf1MS4QLjKMFYjvI2CmspBDjr1/kr3X0qAGX65P0Efg
	6SCL7RFsqo4oBlhNu0qXGqdhSpfjvKcIWIpqWroZnlacowZlZtcCkL2ITxRPlxeG
	8SV2MJRpLjskhJJLNpL/dg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47uk66xd9v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Jul 2025 13:31:27 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56FCtGaI013842;
	Tue, 15 Jul 2025 13:31:26 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10on2076.outbound.protection.outlook.com [40.107.94.76])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47ue59fram-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Jul 2025 13:31:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w1t7Nyz7e5zQuj5kacR0C01nG7SOww/9ApIq00J3sXx/oV8ZiM5yAbIx7B/6pST+2hrInk7mkMrreCYOlMyrJsXE1vS8AA2TnBss2CbTYhDssOG34e6A/xsP2iQNy/SO4rO8D3FrWrH/jo1kAzNHv8+/uBPeTlsmDn+g9tgf6vKhrfhEHtVSkjiArFLWp2gI/D0+IJbV6rK3q4UYchkUHirpL3Jo/IVUwriLWjcVlSk/N7/FSd1DjmklZ9TbC6z8Z7PBvNWRa7+NKaiobJYubkdgFSa6GcO1dSZMlszOd3ygzkMWbdFtHIeMzzPSEmt1vmDW/1KI4uL41sOKVyp9OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7/obCewvwZgzPvzs6AllSgCzXL+2gypwQKAuH5IKbiE=;
 b=oErWVqbhhJamRw16GctJyEWLw8OAj26y/hSpupwEm6rQ4qBaXWEnZ3RAX1+mxeKlWogOqbPDSDtkvJelm7FlLIDMSqaJz3UCfCtOtZbDesMoulWb8kPwpoz1PWmCU5ihU7MFtVRWUyF+T1SnJQUcVRBkR5nbZZrWev/mJTrg5101YxB7XIVeJaZi925T6HlBMzm/Jf6MN639gTPA2xeDxw6WlduFI4A4CEV34DubaCy4dy/gaiTQ8buLWbtcZPRlHxiQ12RaHvVWs++6juVhxDJnIR4v8By3Eh2H/ljMLTbPNAn6xebyyFnUkIDGUWKwr+cYqRwK+kt9QusZWD+uEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7/obCewvwZgzPvzs6AllSgCzXL+2gypwQKAuH5IKbiE=;
 b=sFtknIRQD0mqSn48+xKD4pdqOaLi+aij8pWMTgGUrn3CntExsu1+K+kvxdvN3euHvgjRUqqRjvgiLOOnAuW9YhNadzODWYbkTtf6WOthBXZv7pJNrJuEoqUSqgvn3qClAherJ2TXKXxg3AkWMBa+hJF1Ky6/S0xk2Hz/PIAZjaM=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CY5PR10MB5964.namprd10.prod.outlook.com (2603:10b6:930:2b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Tue, 15 Jul
 2025 13:31:23 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%5]) with mapi id 15.20.8901.021; Tue, 15 Jul 2025
 13:31:22 +0000
Message-ID: <4947075f-8417-47e6-8712-295500d0a50a@oracle.com>
Date: Tue, 15 Jul 2025 09:31:20 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/5] NFSD: add "NFSD DIRECT" and "NFSD DONTCACHE" IO
 modes
To: Daire Byrne <daire@dneg.com>
Cc: Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org,
        Mike Snitzer <snitzer@kernel.org>
References: <20250714224216.14329-1-snitzer@kernel.org>
 <CAPt2mGOwiXi3U5X3Pq1f425VmsKRJOSn6zA1S6CdoDx_twsv2Q@mail.gmail.com>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <CAPt2mGOwiXi3U5X3Pq1f425VmsKRJOSn6zA1S6CdoDx_twsv2Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR03CA0005.namprd03.prod.outlook.com
 (2603:10b6:610:59::15) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|CY5PR10MB5964:EE_
X-MS-Office365-Filtering-Correlation-Id: 625394a3-638b-4240-8dd0-08ddc3a3e3d6
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?UDJyV3JRZXZ6c1crU3JoNkN1ald5T2Fac2t6cDh6bWxNUEY4Y2hIOTZKYXI2?=
 =?utf-8?B?YWRiL3dLNTRuT1I3YVZrZDRpSm5QYlpyYlU3NWRIN3ZTMEZwd2FPZDh4Y2RE?=
 =?utf-8?B?WjkxWENVQ20zbXAvdjJJWTRXZ3FObFduRDRTemc0TFphV0IyWkV1OUc1MW5R?=
 =?utf-8?B?SUR2THVFNHpWZVo5Y2RXbXBIZFVYNDRubGwwbitZSDFBWFdNNVducUhVQjlz?=
 =?utf-8?B?MURqYURpclpVd1hXaktVQi8xK2NQQ29FeENnSDlWeEZKOXZKWG12c2NUeldQ?=
 =?utf-8?B?Sy8wc2dXaVJXVS81amxuZmI3OUk5UEM1TGV5K09pbUJTNGtkVmJoaUh2c2Rs?=
 =?utf-8?B?SkkwdmlYUDVUdDVlRWlSaitQYnJrZ3V5MU9VdFJSTE9ueXV5dDJYNzloTXpo?=
 =?utf-8?B?Nk1nUzE5a1FMeHZZTFczKzFXbXR0cWZRRTBPakFLb0FFNWg5bXFOUTJBb1ln?=
 =?utf-8?B?RTdpenpTSWFnVjFxa1FYQnlUZTVqYUVCV3pqbHNwMGZaOXQxQnUwa1R4WHZV?=
 =?utf-8?B?Q3hSc3hERVRmdGlHUGxQb1EydFg1YzVtdWxzQ0NDRG50WHk2UVR0NE5IbVZs?=
 =?utf-8?B?R0J4azN5eGF0SVNObnJIZ09VQzVTWGFHVnVVUCszYUNLM3A4OUhuS2loVk1J?=
 =?utf-8?B?cWJFQ2c3M25yWVpmdmVZVTc3ZVdlSjI2amEzU2V0aVF6TGtrdzRYQmlBWS9v?=
 =?utf-8?B?ZlkrMkx3ekFqQzZPbEI5aFUzbFFCN3U3RmFIZjdLVmRXa083a01DTmg5eUdQ?=
 =?utf-8?B?djdGVmFmRDRaMUNabVV0NmxSKzJWSWtZU3AzcFQ0VjJXSEZpZktuak5RdElp?=
 =?utf-8?B?ZEl0Rk16c2xqQ3p0V0JWNjZtS0FkL0tLcDB0NVBZczFLdVFDMXpKVmNVc0Rz?=
 =?utf-8?B?Q3NObVdDVFR1OStoN0ZmZDVXMjlpQXV0L1BpdG81TEN1UlNXT0hwbXVDRlp3?=
 =?utf-8?B?VFVLa3pWV1RVeUVId2RSRm1HVTMza2F0bG5mTU5ld05rdnVxZ0JXVCtnNjVp?=
 =?utf-8?B?QzN3dEVuUksyc2hobTB3bFd4VnlNUkcwdVk3K0xlMkpvUXFkcmdtNHV4cnp4?=
 =?utf-8?B?bE1ycUxCWTRuRmtZM1UzN3l6ZG84eTNlN2Q5YjBMRzFBbWlWM0hFWjhBdlQ0?=
 =?utf-8?B?bmFZOUUvemhkSk14MGlvMXBrRGRSZlJKdURHd2NzVXhJTDgxSWZiWWNXaHlU?=
 =?utf-8?B?QUVEYzJPUUtUeHJCOGZjZk5CWGtSRTJLZ3VHeHQ3UmtCcG40VHBQNVRGcEtC?=
 =?utf-8?B?bWdSbWhBQzBQNjVmRldMb0MxeEFEQ09ESEhMZ2h6dDgwbVdxMzJoc3h6d2RZ?=
 =?utf-8?B?dHZCdDBUREhTSWZMT2NHUE1oWUFMNVVJWC9FSzQ5NEEvMjk3c1U2R2g0cUxE?=
 =?utf-8?B?SHN4YmlBT3pRSFhLVHQ0b1h2UlpqYXpCc0xLYmttTlJhcWljTHRtd2dMUjBq?=
 =?utf-8?B?NHd5WDFnbFBPa1ZrcmRVVGJhNGh0c2h5bDdsbDJFSGxVNEhTZDcvZHRLUldw?=
 =?utf-8?B?RzdKaWp2UW1ESnBCMnlMMkxBeHowVG50TjdNaG12amFjMS9IT1lZVEd0cEdF?=
 =?utf-8?B?c0dWNlc2RlllbWFuU24yMUJMVTNtNStqZFRUTXMrNjhIUGRzdndodkU2djFs?=
 =?utf-8?B?L0ZYMk40M1dyNWpETkhYcklmQTZTYUhYUWdsVWRUM29rRkdodncrUmVHVzlz?=
 =?utf-8?B?RFdXb0VRenNpRG9jbWhoUzN1aEdxVklsRWhpc3c5ZDA0QWZ0c2VKT0NNNVVj?=
 =?utf-8?B?NzlTcTA5TGlUc3NmUTN5b2p6WjBZM3RwUmRQZEtxbllscUJuTjU3WEJzN0lN?=
 =?utf-8?B?S29zTldaNDR2T0R3OC9RWUVYMEtSTjRUVkhScnFRNVEra1d3ZDhjNFFYSThL?=
 =?utf-8?B?dWU3WjJHeWIzK1A3amowNWo4ME5PbmxwVkp6OC9NVjVFU3lqaUpSWWR3SGxL?=
 =?utf-8?Q?JuUJ9nJqGug=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?ZzBYL2YrbFhCNldqQVlYQWlvbjg2TzdDREpjRWVTOThuczRTOWhHMU9nc2Jn?=
 =?utf-8?B?ZlVTOHFiRGlVSkQzQUsvSm5ZYnR6NG1RSHlMVEtBQjY1YzlZSzl3Z3M0Q0E0?=
 =?utf-8?B?a2xXZjNOcnRhMWRUcGJPaXh4WXBBQzZuY3Z1WXY0L0JjQTJiZ3l2TnJwdXNj?=
 =?utf-8?B?M3g4N2tmSFFMNjNLRlAxZytQTCs0MEpYeXZxYVVQZ3VWbW1Rekx0eVdOU3Vk?=
 =?utf-8?B?d0xodWFQWFYxM1d3SVREaEtDQXduQUNCR3hzY0tUd3lCM2VxQVNlL01nNEV6?=
 =?utf-8?B?Q3ZWdUZsUnVSSEVCeThmTkJReXNub0NPbVZXOVBiMWgyRVJSUm1EVzFMMzJn?=
 =?utf-8?B?NDFxaWVpQ2pNTDlGVzE3ZTVRRnJLVllIQTM0OFN2NmozbHpIZ1dIR1RTenVa?=
 =?utf-8?B?eWM2UnRMN2Y4R2FQZFpsYjdYVnhkaWpVbm9TdUdMZklycUZ6RzMvZWZzUVE1?=
 =?utf-8?B?amI1azJPS0dHditIV3N6NGxXR3kwVlEranZPK01Oc0IrUzZUdDNDTGVFckR1?=
 =?utf-8?B?cy9aaDYxRWFwbXRpKzJSNGxYWWV4WnltaFdQQnQxQzkyNzJsTVVoWS9sc05r?=
 =?utf-8?B?OFBFOUlNRi9ESXY0UzMzQnl4WFlwWTcrOTQvclhOWGc0NDltVWJtSVBWU3BD?=
 =?utf-8?B?MzBBbWl0ekU2UlVRSFZDbit1YzBrWXZQTWpNdmE4dnVpYW51Sm5PZG01eGVX?=
 =?utf-8?B?OUZYZHIrMkZLWEVwcHFRbEQ5citIWFRjSGVtK3JWWEV3K3Z6SWd2bTN4Wlhj?=
 =?utf-8?B?Y25pcCthTUJYSnBDT09zRkNheDFNNE1XenBZeFZ5MS9MUUZDcnlCUENVYlhZ?=
 =?utf-8?B?NUNkbHVHZkhhYVVXMGVCejV3SnByMisyYm9FcEZjaFdIQTA1R2xhQklxOTlY?=
 =?utf-8?B?YnJhcWRQVDB2SUFCZ0x4eFhoZytWdk5sVVVkVllLNUhJTUJNTGxSUWpMN0lh?=
 =?utf-8?B?LzBQaEdPY2dTcFpRSmFqMnV0NDVMc3p2a0U5ZnJkUjNsYzZySXBZcXpCWUFm?=
 =?utf-8?B?QmIzTG5LaHMxTFE4djJ5NEpsbG9RZ3MvTWR6dFMzeUVXbWRkMXVITmV3QTd1?=
 =?utf-8?B?MjVnUXRTTDZDUlNVNWxPcDMwZkZIK3llSWFTcGpzTkhwd3hORVRPc0ZhZ1V2?=
 =?utf-8?B?RXk2UVo5ZkpTVUd1aFNYK01va3JTbCs2eE44b1QzS3hPU0VoaTl2K2RoMWIx?=
 =?utf-8?B?U050am9MdXhSZllxZTJWWXpMaUoxc2EvYjhtMXA5bzFrSERKRyt1d2c4WUh5?=
 =?utf-8?B?anRwa2NuejFCejNNT0UwTzZvZWpjTGpicXBGcGg0dURncWl1Wkh1MUlsOVJ6?=
 =?utf-8?B?TnJMSWJpcjFpb2JqMW8xdHAycU9OQVBNTXNqL2pmcnB3dEcvUk1kcWM1S01B?=
 =?utf-8?B?bUVWR3JFejg5M2k3Y1pwTXVIblhvcm12WEV4VEg3WXhQKzdBbnhrWlMwK3lw?=
 =?utf-8?B?OWN0a1BrMzRQV25DR3ZTR3pMbVIxSU1od0x5c0tUSUtMWU9WbFkrRG81eUN4?=
 =?utf-8?B?WkNiZWZ1b0g3YlZiNVV3bFYvMTUzOGV4Z2ZnNml1TnJXR2FYOWlLdUU4bG1U?=
 =?utf-8?B?dmhHYWl1emVXZFo5Q0JaT1ZaQzRCck4rc1BXRS9jTTVFWW1NYjgxT1RKci95?=
 =?utf-8?B?MStXUlh1TGZzOW0yYWFpSkxKNnJXdDVJMmdHUmVMRk5hcjNSdithOHBpbUpJ?=
 =?utf-8?B?b3JiYXRpbnduNnRTbUZYSDJuOHV2Z1d1eXVKZGZXV2tjeHlSNTNLb2JWa1hO?=
 =?utf-8?B?NVVlUUlOeUNrWFhOdDRndnlLOXRSdTgwRk5hSzYxa3lTM3FzRkpoeWtMUXBT?=
 =?utf-8?B?RUliTDF1LzRVcU9vTWVOYnpQcnJPb2M0UTQ5MnJrY1pzeW9aWEcybCtidDR1?=
 =?utf-8?B?eFhtOTlYczRmeHErYjUwRjFBWC80bXBld3FYaWVLQ3M5Y1ZWaE8rbm5WSm5z?=
 =?utf-8?B?REtiTERrZnZCUEswRlQ5RU84ZzdHalVlYmN2NU5kS1ZWTDlIMTJHQXFkTkt1?=
 =?utf-8?B?WjBXSzJpZjJya0hEeTBpVVJpL1N3MGtmakxmRGZMcW15ZENGYzIwdTFmd2hM?=
 =?utf-8?B?TlBERzRMTFlMZFltRDNKRTZSYnNRYWNneitPcVBQcHAzV0FOS2xzblQ0dG1l?=
 =?utf-8?Q?djxiFKa15a8jkpeT1tL9HsrbR?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	NLMAR1xiggjfZSNJVmWZB9pJz25NABlCUml3MBSSYXnhAV+XUeOlcj0B0wBkUQqEe2JjXVUkVoW7l8t14k8gM/HLNA/fwoKp6BjkzWE5VApjQJDpB39WjgxQ6gx6QL25p6gKSRd4tBShMuoYblpg3df/JI1OC+6ECnrCcBOlo8mRotd73Hc+WJ2veD00Qc8gpUpExoBUjyoegxgclbuBf+8xbTASLWm1xnGYQX3fMO2oPMsATnYxBZErOaunwjRYfm0u4TmfVi/fPZyKj/vBwyuK3BUfDid4tegSa5vwlFXEhDTNcRPxpd6WNKEYrcQWlVIBCLNr3Hi3ocJbFm/dOzfKwbGj9XhQo+KegoDegzAa3mF8qjgIQgCs/wqzGcrpg/0GefFgb+xJ/0lo0P6gQavfSOUQ8KsOuGN0B5yz5JGnEZZTqLeolWgSAXeWAKWo/zG9TxP9vQTb3J/TpPqniVDV873ql7cxtB3Ih7ZD8E8Ap4r9s2YOOT71Rzo31m/JojMMuad9qtHXSYehgJ0hE+DbgzL9bQprlArWYgTVbe4RRPwhsgrL06VJZgrkBbXyj/ZYaUCOz4ScLMz65gAUE63wj2rpGRABWUgbQTiseUw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 625394a3-638b-4240-8dd0-08ddc3a3e3d6
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 13:31:22.8013
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oRoe7RMnbjV/lnJ843o5VQTKHNcdN2LCloCNFw9vpGFz0ybMamYRE+eMBsrcG2Bdlz9toinqQ79Y+4zJ95lzqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB5964
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-15_03,2025-07-15_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 malwarescore=0
 phishscore=0 spamscore=0 mlxlogscore=999 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507150123
X-Proofpoint-ORIG-GUID: uS1cBCjta35QIg7SIeU1lINkx4lg-Idu
X-Authority-Analysis: v=2.4 cv=AZGxH2XG c=1 sm=1 tr=0 ts=6876582f b=1 cx=c_pps a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=ZepsX6G6N-IALYR4w-8A:9 a=NqO74GWdXPXpGKcKHaDJD/ajO6k=:19 a=QEXdDO2ut3YA:10 cc=ntf awl=host:12061
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE1MDEyNCBTYWx0ZWRfXw0E4Mog5xEwh I5EBAdnhjW0KhWI4Q/vtxM91usWqqaFhIwZ99SslzIKZkVfcvLQzxfXyuVJAOwi8NhqhjNGR09m opGANno+dpxWystsntGYtkO7HT/mBWtOCEvyqW46xBSDjhthxp8Mne43tMA7zxGXQKLoWWoaCrK
 bmhG7Afat3t6GHTvceYn7th4sZCU7Js97XlfOgK/RZVag8l5ekm53mZCw8vvDx3/kp3HrYtgGML M8y8E3DxNBTCMuwc6LSVmwqoRQt4JhqvcF/6Jyvf6+wnjPLiyeBxvBTiQ5pFT7Fe6qwc5YTDDSt lEo1bHysoUpTZQjmdO/OeL0FG7WXiWSFgmZgZSVQ7HQNpwvkFPBrv6D2YkFnpPha0i8eOdk/VYL
 84gs3rBqntEJ5ISevlOVizyfnN2ZCaIVUpDumdeF2TkAafUdkCuLl3hEtpjNB5fBZOwOuAUq
X-Proofpoint-GUID: uS1cBCjta35QIg7SIeU1lINkx4lg-Idu

On 7/15/25 5:24 AM, Daire Byrne wrote:
> Just a quick note to say that we are one of the examples (batch render
> farm) where we rely on the NFSD pagecache a lot.

The new O_DIRECT style READs depend on the cache in the underlying block
devices to keep READs fast. So, there is still some caching happening
on the NFS server in this mode.


> We have read heavy workloads where many clients share much of the same
> input data (e.g. rendering sequential frames).
> 
> In fact, our 2 x 100gbit servers have 3TB of RAM and serve 70% of all
> reads from nfsd pagecache. It is not uncommon to max out the 200gbit
> network in this way even with spinning rust storage.

Can you tell us what persistent storage underlies your data sets? Are
the hard drives in a hardware or software RAID, for example?

Note that Mike's features are enabled via a debugfs switch -- this is
because they are experimental for the moment. The default setting is
to continue using the server's page cache.


-- 
Chuck Lever

