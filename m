Return-Path: <linux-nfs+bounces-14586-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2505DB87022
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Sep 2025 23:07:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF52F16E6F1
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Sep 2025 21:07:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53DFB13B2A4;
	Thu, 18 Sep 2025 21:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="qjLW1X0x";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="d7ouNcTJ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6010B2C0280
	for <linux-nfs@vger.kernel.org>; Thu, 18 Sep 2025 21:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758229621; cv=fail; b=HxDVxIHP36VacY2T8xFiqZEi3pRTBQ84q3FxI5l02BbYBVoJ6kb1Izdka/UOHXDSUnkLFPvaogMRtDCnwnqogoMWp8Dm5YTrRFm+yVeWSyx3xetTRk6ipOB287SvNW4yQZkXIEkR4yyg3vFWsTk39dGAsRQlUvGfi5Htp8HXGxc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758229621; c=relaxed/simple;
	bh=DA0h0/9fcMbTeHNbTaLp5tK0kBUv07NpWOkAslVaKQs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CddYk2qVap/HYRFzPh5VBmsmZR0cXMTFqu3lQDos44EIlJtZQhZOWDRRXvW1AhVwYPne1hdu3Cqf7s/5OizrN0TcpDnv27bbsu0hlGBVPgADCZBCqAVN54N4NjtcJe6bHvtpE3857AK1L1gfzWlBKGnJO+XvAwKgUplhWwxhYtc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=qjLW1X0x; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=d7ouNcTJ; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58IG78n6007076;
	Thu, 18 Sep 2025 21:06:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=LUlXPNxEdT68PhlgtBOTpYntuWtx/hUFMjNOV6eDnRM=; b=
	qjLW1X0xWa4NipeC9RjKvGbJd3pKPpTRMbmnBHbN7iRy5ISM31baZR8MtYnzDmW9
	eCcWzzfXe3Tb06uLTSZAvdxC3/r8DEl/eKsv1dR0SMrGXD7PKo51KInHOJMgwWrE
	kOOYF0ZYESU5vW5pk2m55cnfwZurly2imIJbo5dX73rqQUVxlYYznCM0N48JbJZr
	OIWeKtDpZdjUI6Yrsvbt7BpLc/YZmggrWCU3Tf/e1aIv/4kS3iKKWusAaRzPPTgJ
	U7m8QrtHIM47r0A+srsFWoHfIa84TSi/DhVyaIFoMNkvNVaA8Gt9zFxB/P6gs2I4
	r3I0nOu2rldJRT4ljwl8JQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 497g0kcf7v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 18 Sep 2025 21:06:52 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58IJLDUh035200;
	Thu, 18 Sep 2025 21:06:51 GMT
Received: from ph8pr06cu001.outbound.protection.outlook.com (mail-westus3azon11012066.outbound.protection.outlook.com [40.107.209.66])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 494y2p0rrb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 18 Sep 2025 21:06:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b7pzW4ZTgxc4WtOX4lTxVOmnYdTSpcWTkFnC6YvJXLz6jynfq0MyDj5r9WypwSeQ/Ey7HNPWSzmItN+7Xg++s2CLwU+MQiLmB5EIKpJR9vSMIXP/zyN5MvjgP7cJ6+S4RZybCg/az0NY8HMdlWRDcB7F1pcxN+Q/IBcIbmID83ccszJYaoWRGqm1PokGLPPxR7ZTpMZTCFvxmemIlFqzEsCe59GKuRTllekkqLctAq+7AVVhtO2ItW+qI1CNnD1VK5GP7s3WuX9FAoROh9oUEVavRvq08NFK6PMX2ZtMMo58qSDYRHGnC1hnXjQLlKY+BdEx0FR3W244TXNTLt+A9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LUlXPNxEdT68PhlgtBOTpYntuWtx/hUFMjNOV6eDnRM=;
 b=aJy2goEaKPc+Jag4DgLkMlx/6RMe4Gm731q27QjWtd4pt03Bpl5DPMfcJNmDzmQtmY0FO06CQmx2E4AXQIvYHe/o261KVp1o4DfyOSo3/t2jRP8gTooFtkCZDQJgTl4SvnzbinSxc9u9SfXusuI632O4Hkj482Zqfq45mJI6Ypg0S+AX5Bj6gN2gTVRCwzY3FgvNwINR+0EMgc0ld0Vy6C3ElV16LU6Rd628HnVxpebwBEIGR/ep1zv0stwRvx9sFt57HmmTusneqFjXtmOLiWYCsnQSp+4roB1UYH8iG3CsSxczV4ktnDade67fNkRmoqgZnOj1J+3dkPJ+0BSr3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LUlXPNxEdT68PhlgtBOTpYntuWtx/hUFMjNOV6eDnRM=;
 b=d7ouNcTJ3iAPVdLh1Fm0GOWoymmbP/XyymLDCMg4HBhYug4wNNC6Y8zr7MTDrt25uIzzgGN4IjWJbrAMAxM2qgDqQkiv5wpdmQHe/36zTMbSou1FPoFcojMv5/KVgridfB7v/ehMlU0ULgtFh+6de4Aw5phIQ326DbjZGfBY1mk=
Received: from BY5PR10MB4290.namprd10.prod.outlook.com (2603:10b6:a03:203::15)
 by SA1PR10MB6613.namprd10.prod.outlook.com (2603:10b6:806:2be::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Thu, 18 Sep
 2025 21:06:48 +0000
Received: from BY5PR10MB4290.namprd10.prod.outlook.com
 ([fe80::c86a:40f1:7833:ef3c]) by BY5PR10MB4290.namprd10.prod.outlook.com
 ([fe80::c86a:40f1:7833:ef3c%3]) with mapi id 15.20.9137.012; Thu, 18 Sep 2025
 21:06:48 +0000
Message-ID: <964e3fba-93c7-4905-b060-adfb5fabb53e@oracle.com>
Date: Thu, 18 Sep 2025 17:06:46 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 6/7] nfs/localio: add tracepoints for misaligned DIO
 READ and WRITE support
To: Mike Snitzer <snitzer@kernel.org>
Cc: Anna Schumaker <anna@kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        linux-nfs@vger.kernel.org
References: <20250917181843.33865-1-snitzer@kernel.org>
 <20250917181843.33865-7-snitzer@kernel.org>
 <23118649-3dc6-443b-beb7-9360199e93e3@oracle.com>
 <aMxFhX-jHnfv1F24@kernel.org>
 <9d8fb1e9-d40c-4c00-a555-e37ac0d4f290@oracle.com>
 <aMxbtqugI2dhwsF6@kernel.org>
 <34a15201-e8bd-4269-9f18-e74394c63dba@oracle.com>
 <aMxpKagpCRll2Cjj@kernel.org> <aMxzimxm6ZahmY68@kernel.org>
Content-Language: en-US
From: Anna Schumaker <anna.schumaker@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <aMxzimxm6ZahmY68@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR05CA0020.namprd05.prod.outlook.com (2603:10b6:610::33)
 To BY5PR10MB4290.namprd10.prod.outlook.com (2603:10b6:a03:203::15)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4290:EE_|SA1PR10MB6613:EE_
X-MS-Office365-Filtering-Correlation-Id: 22364264-42d4-4041-7bc4-08ddf6f74832
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ckFpQnVLa2JPVFRLRHBTalJ1MEJ0YXVQYWttZk5BaEJaY1F1YzlpQ3NvL2pp?=
 =?utf-8?B?d2VIbmZnUjlVTnhmdmRIR2UyMFNRcTFhdDZzWXNCcVVCOXF2cm1OLzlsUUpi?=
 =?utf-8?B?UE1pQ2dkRjJoWktDeVpDdERiZE5pMjUydENHaVlyazQwZjJsVnRrcXk5T3RC?=
 =?utf-8?B?QmtwRnlBdUpwcGlHQnprNERNbUxJTjZrTXJBbjRTYmFVNDhiRFJFcUxKVnVx?=
 =?utf-8?B?YTFUaThzK0RyLzg2VzRSQlducElpYUlSUEMwRGE1ekk0b2J4Vms2YkRueGly?=
 =?utf-8?B?LyticHorNG9FZGlMd0U3OUtnZVgxcDBnYnl4aUFQU2Nqc3RnZnBGRHpsZ0wz?=
 =?utf-8?B?T0pVNjNJN0pHcUloSzVpQkc5bE82OUY5T1RyeHFEM3hQSG42STdvUzVJV2Rv?=
 =?utf-8?B?d3gwSzFWWDJMT3RISnV4Y0RPK1NTdkE1TmN6WmIvelVYZytIeFJPd1FTSGFh?=
 =?utf-8?B?OFRza3VuZ0dGUEVyY2haMkVWa2I2RHdSaWpPN3hQVlhmRytENDB3NHBSSTJm?=
 =?utf-8?B?aURac0lKVjNNc3BoaFJCMzlXN2plRktwVjh5eFJ5YXhDVmNsQSs2T1d1dWVt?=
 =?utf-8?B?dzM4elRMN2NncXVrMEFScnVpVmZyMmU0YVdkOUJGOTBRMStCcWhqUTdrMUlp?=
 =?utf-8?B?RkR3cytjUEovZVpYL3AycHRnR1dsVGNpY2dvSERjN3Noc21zcFl6MVNKaGJZ?=
 =?utf-8?B?d29wUE5BdFJsb05rMVd2M0FlM0JpSmc4eG41UW9kcWxzUi8ycVpkSE92VE56?=
 =?utf-8?B?Rk9vSUlKSXZSWlowbEx1ZzB4ZnhMb2NRK21SWWlLd1NzV25xK2VZNXZwU2FO?=
 =?utf-8?B?OFhsUE51TGY2VXdBdHhwbDdOR25MSm91SVE2bTgwczdFakZWRmQzalUzNkdl?=
 =?utf-8?B?SDZDeVJpKzVnV1V4eXhWakJpUnZTWmdiaGdjemtJQU5qWmdabHlyNkxwS3BF?=
 =?utf-8?B?ZTBmeGlITHl3SU5qOWlMUU5DM0ZNY3hoNEVibDViZjBPVVk5cWcxNU93cWRI?=
 =?utf-8?B?b1RXMkZBZjgrQnZZb1VSWnNVNlRmUlM0ZFlMc3gvMTdiTHgyaFJxODl3Uk1F?=
 =?utf-8?B?RWs3M0tVQlBCS2tTdlhJcmZlcjR3dGZhd0ZLSWFFVUJSQVo1S2xJcXRpZkJV?=
 =?utf-8?B?ZjJ4ZkxmRzZMb1ZyZUdya2ZxN0NqMm1FN3JlUDBrbVN6d0NObExmbWgzSEp2?=
 =?utf-8?B?NERIT0wwdnVCa1ZwSGU4QkRNYnQxSkZhN3QwM1ZpZ0REOG0wWVR2Q1BLR250?=
 =?utf-8?B?d3JFUGNabmlQOUdYTnZUQ1orYXZMRk53T0o3RTBXdE1wTkVtdS83NlZEaEZp?=
 =?utf-8?B?VnQ0MkZRaEUvb2MwUW00YmxmaHBLeUE0cWVXUEZpN1NIVUg3NEo4UXpNUDlw?=
 =?utf-8?B?TysycFViL2hFYmZEQjJ0VE9TYmREOFhXek5IMnFuM00vNjNHUktJczhkRjlq?=
 =?utf-8?B?Y25IQlJWQVFDRExodXlzTHUvdjBZWjJiZmZKd2ZsQzZvUTl5aVlMR2FveWJa?=
 =?utf-8?B?S2dpUjFzdERHWXR0ZVRLeFh0QmFCM3h4aE9GbUhUMUZqRlhpdGdUMUdaQ1BQ?=
 =?utf-8?B?K3hkU3kwWFZoYllUSHl1TkFzVG1aQzh2MWxUc1pGenNqM0xVSTQwdlRiNURm?=
 =?utf-8?B?VGRTQnY3YmRWYlFBMm1YUlg0QmdzYnZDQUhhdGVGamE1clgyalZxNUhOcmFB?=
 =?utf-8?B?enNvekhWMG1VUWQvU1dYWlV2OGVtMU5KUkJDTjR5RjlHQU9VMnBBbmZveEUz?=
 =?utf-8?B?dXVFSTRNenptcjAvcmZ4aGNjSmhoZXNQcit3d3JYVEg0MW1UWHJrdTNxZDhD?=
 =?utf-8?Q?a1pbb0kxBQ1vSoCKE+5epfxg1Uovw1wqnwZYc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4290.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y2dEcUUreWo3bllIN2lrK2NIcTE4QksrRFhLRmZsbTR1R1RKZkt4V3J4cU5s?=
 =?utf-8?B?UjFpbGhoWG55bTVLbWRGeEo4cW1vUmc0NCtSclRBYmQwTEJPazVISml5dko3?=
 =?utf-8?B?WTVQVnM5UFZrRDBPTjEvSittc1FyZS9JQlo0Rk5QcWF0NlVtOVJ1UW52c3RS?=
 =?utf-8?B?bVg4Um9RRlhEUVVmbzFIVXhPNnAvQkpseVkvN2FZRWFBU2d5L05rTytsZ1Rz?=
 =?utf-8?B?endEL0k3ZmxyRlVQZGlZMFE3NHo1Ry93ZVJDd0gzWDFUblVSaFJ4K0JFeTVP?=
 =?utf-8?B?akZwTnZjNENxamZ1Z0FIR0xsN3dGMmtQYTlWVWVTZjhrWVBhbFFwNVRVSGlO?=
 =?utf-8?B?WVc1aGpkT1JkTTg5VHpIZ1RUZllMUjJrT2ErRDFnR2ErQTc1ckpibGo4S2V3?=
 =?utf-8?B?b1Y0cXBmbEVtdmVKNG9wcHE0VHYwWU1memZZTzkrU2RYYVEvQUNzRWVXQVFx?=
 =?utf-8?B?aXFlcytPSHpPMFo0Z05RWmxHODFXbndtMTFoYS95U2x5MVBoaWs1bXRIcVpT?=
 =?utf-8?B?U1ljd21HZ0NlMzE4a2xNZXkxNzZiNXIvdk9hTFYwdlpnd1AxQXFMM1EzanFC?=
 =?utf-8?B?V1JoSGZOMm1ETU1RU05UOGRGWVBzdXB3dzUzUWJBMWlFaWR2UVE4b2tkQkVY?=
 =?utf-8?B?K3NpaDl0YllLcEFMdkN0VzgxTEJPeGt3bWZIT1pPRXlQUFJxUGlqWWFEeHNY?=
 =?utf-8?B?TDY0eXhMRUliSWRLZzNLWkpIZHlYSUVLSzcxU1hGZm5OM0VMd29mVGpMSnF3?=
 =?utf-8?B?a0lMVEZoZ2tPSVMyMkRzUWxCS0N2eUtDR2Rzayt0S2pWZUx5M01hV0dmbE4r?=
 =?utf-8?B?eE1nT3BUamFxNzdSNGhFZ1VadXVVNU5WWFRkaWd0VFNoTFp4V09MWTZCeXpI?=
 =?utf-8?B?aEdST0lHNy9hemQ3UkJLSUluVE1XZ3pNWG14Z1gwa2RPQTZ0R2tEbXFsdHZ6?=
 =?utf-8?B?QTNBeWNlQkdITlUxRHZoN3ZUVmN6QzI5c0FKMmlCQjVwdVdTMzhRVGRNb3hM?=
 =?utf-8?B?R2kxeDNvTVpRRnMzTlJJS2RUK2ZHL2RqR3hOTERwUVA5SVEyN3pSandVTnJ0?=
 =?utf-8?B?Q3hFVWFJZzRrMjhmNXMwVXd4MEl4dTNmU0JkWFhaWXVBd09UbEpSWmdTQ1pz?=
 =?utf-8?B?bmdRaHFBUkg2L0g4dEVMa2dadUpFVStlVFc0NjJjenlGTDNFbldPZjBjY2pO?=
 =?utf-8?B?cTk5ZllNNTJrME5weTVJSU05ajQxQUwyMmpORHNBZWNlTHJGUGdWVVV4WGZV?=
 =?utf-8?B?Z2VuL1J2eG54dXExSFdhK0wwc1ZZOFdrUEh0d3M2WThBMXJPOURXazVyZ0lu?=
 =?utf-8?B?R2FVVldqUnFpQXhrcmQwc2g4ZVpVbUlLQkxIeVg1YVZvelZ2cy80UUJiK1Y4?=
 =?utf-8?B?UWZ6YVBhdi8xR0R0bU1zakdnTk92aDdwN1B1WCtBMjRxQmI4N2paRFlqYTRS?=
 =?utf-8?B?Y0tjeGFPMlB5UEQzUUdTd2FqZUxKYzZUTE5aaXJQUldQSldWVFUvQysxZlVh?=
 =?utf-8?B?TVcwSk9pcjhNV1FaS3MzTjZlOFZvVHphbFVFK0ltY2dXaWVyS0k4TWRJU216?=
 =?utf-8?B?cVdhb3l3ZW54WSt6M28wdWcyODJTN0MxUWREOFQ1bzlNWHpSa3VxQkROaDZz?=
 =?utf-8?B?RXBnSU9YOStFQk5ERXQ0d3hlcTVqUFlrOUo1TnN2ZzdGUVVwWnVwRE82czVL?=
 =?utf-8?B?cGNBY0lwc3pubE9pNTZyeFAvemk0dXRZOUFnb21JQTVzREhFLy9DK21HWW4x?=
 =?utf-8?B?NWxiWHZGZFB2MmtOOW1IQi81YnpFRHZ5aXJNUENwRkJpYStZSkpDV3cyQ0Jm?=
 =?utf-8?B?akIwNGZQTzg1b214Y2gralJHZjY5K2ZYLzdqYlB5TmxSSWlSL25BM3VoZXh0?=
 =?utf-8?B?TTNwdllVcFZUYTR5dm1PMFVjeW5WamgwekFuUzVkRmpldVJZZXppZ0VjQTlw?=
 =?utf-8?B?dHFSVUw4VDZxcGdPRjdES0cvUGRTNnFuanA2c0wyUWlYOUxEK0JQQ0NYTUFk?=
 =?utf-8?B?dlRPeFBSWWxtZDEzVGQ4Z3JEYVRmZllUZWpKL2ZwdC95SXlxVEV1U3NWVXcv?=
 =?utf-8?B?UythSmNvTVVhSlFPRHp2cThWazU1ZThmeHNBTVhXb0xWMSt6UHBBQXVDUlZW?=
 =?utf-8?B?ZVVqeHE1V1p6dHlZc2EwRjRDUElsRW9vRHRFSTBNRU85UlZJZE9TTys0bU9v?=
 =?utf-8?B?MWc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	fNe1B6q/kv4x98zETknVK72nVrcJzwdTcTD8LtdlvRPa2TGJNhAWMVT6E6GH9vQa9QwWrddZZTl5xz17bjXIKjOA5ppKbtqkK5lUU15pRZRisTedy1aMq5Raho1Rb8kpDnhyvin5UPTKmR8FVn67j+Y1RgflstyjulhIgMt+ZKNw+g9swXUeMfQeiPYM/isE1K2xBiiYOqYrFMjaFyUupOHqWHC7FE2NZc5fNafm8IoKnTkq9DVbflSq0SzS+WShB6AiAEX4tnd7pkJZRY/4bjij7DuC82zbCGpyUsSpeLO+QRhO5hsHiG+GxDCFP03PajSMnB9h3vK/bBQIw0bj2yZUIh9T+ESaY4AJ3RdPzLr+Zn+obQT2xCJKIiFt7E8QTf9ZCJNzB9kcqeMquFAFX7A74Rbb4Z+QMRWUEJeHQM/Z/gRbBRRRUfeshr6SHfH+1qb5+KidaFwufw/Y1A3ZKc1zMlCUmHNVo6x+aJLNJFMtJdKcAsOys+it7d5ux9Kv7hpCyfZqdySnOh5EBI9MweamgTkFuiXbijbelJI0MuO4mTrEOtjs35FzjugeF4OshmfQJ1KQL/VASal5REWqPR0s3NmAdPLzf0rMKSF5YeE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22364264-42d4-4041-7bc4-08ddf6f74832
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4290.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2025 21:06:48.6277
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Pyq6nqoUH622jBpPqGzvb3YgT4nV1NuyskjmlN0JKpROG+41n3kygp5uVyXUvPPUpI5d66CjDwfR9mnOAEiJvT1xFae9ydRzwK8TGHmqxJ8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6613
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-18_03,2025-09-18_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 mlxscore=0
 adultscore=0 bulkscore=0 suspectscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509180189
X-Authority-Analysis: v=2.4 cv=b9Oy4sGx c=1 sm=1 tr=0 ts=68cc746d b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=P6JkxrBpAAAA:8
 a=hWeRS8zES8ejyzw-QRMA:9 a=QEXdDO2ut3YA:10 a=dwOG0T2NmQ8MtARghG3a:22 cc=ntf
 awl=host:13614
X-Proofpoint-GUID: bp5P5whKkjjSCB7OmRNcKzJpoOl55qUR
X-Proofpoint-ORIG-GUID: bp5P5whKkjjSCB7OmRNcKzJpoOl55qUR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMyBTYWx0ZWRfX24LMrRm4BRik
 qT8L/PM1cUS/cDNFqFphl+iNysWQxtBqFeBldyB3hUH5M9fC+Yqq+VKk4HdUVMYNK+PhSLnHzTc
 5xorRKd69/LTBripNTpX4gronCGlWJ52ZndDIfkm+lmOwU36oNf90wpq3ZY9u4VPY1P6GlbrYbT
 KwKgA/hKMsbNj8qbLuGxko6EhLEtz1HSv3EFiniYIdY0lFBg2CvaaJ2jjG4hETATVy5VCEhWxv+
 HXDb/Rsu258hhZVP4J8WeIfukjiaXrMzrKtuB5BcehBug4zfZyLIeCsds8tj3qSQalupfSzr5aN
 16MbgjMD73xRXd464czEnsIZWdr9SZv1X5+SrEDaWCmGNNdUyuqr/q7gysE3TuxVzP/R57YdLFU
 E3ig3eVm/Q+FXCOoglPmTutOcjk6rQ==



On 9/18/25 5:03 PM, Mike Snitzer wrote:
> On Thu, Sep 18, 2025 at 04:18:49PM -0400, Mike Snitzer wrote:
>> On Thu, Sep 18, 2025 at 03:55:32PM -0400, Anna Schumaker wrote:
>>>
>>>
>>> On 9/18/25 3:21 PM, Mike Snitzer wrote:
>>>> On Thu, Sep 18, 2025 at 01:55:03PM -0400, Anna Schumaker wrote:
>>>>>
>>>>>
>>>>> On 9/18/25 1:46 PM, Mike Snitzer wrote:
>>>>>> On Thu, Sep 18, 2025 at 01:33:30PM -0400, Anna Schumaker wrote:
>>>>>>> Hi Mike,
>>>>>>>
>>>>>>> On 9/17/25 2:18 PM, Mike Snitzer wrote:
>>>>>>>> Add nfs_local_dio_class and use it to create nfs_local_dio_read,
>>>>>>>> nfs_local_dio_write and nfs_local_dio_misaligned trace events.
>>>>>>>>
>>>>>>>> These trace events show how NFS LOCALIO splits a given misaligned
>>>>>>>> IO into a mix of misaligned head and/or tail extents and a DIO-aligned
>>>>>>>> middle extent.  The misaligned head and/or tail extents are issued
>>>>>>>> using buffered IO and the DIO-aligned middle is issued using O_DIRECT.
>>>>>>>>
>>>>>>>> This combination of trace events is useful for LOCALIO DIO READs:
>>>>>>>>
>>>>>>>>   echo 1 > /sys/kernel/tracing/events/nfs/nfs_local_dio_read/enable
>>>>>>>>   echo 1 > /sys/kernel/tracing/events/nfs/nfs_local_dio_misaligned/enable
>>>>>>>>   echo 1 > /sys/kernel/tracing/events/nfs/nfs_initiate_read/enable
>>>>>>>>   echo 1 > /sys/kernel/tracing/events/nfs/nfs_readpage_done/enable
>>>>>>>>   echo 1 > /sys/kernel/tracing/events/xfs/xfs_file_direct_read/enable
>>>>>>>>
>>>>>>>> This combination of trace events is useful for LOCALIO DIO WRITEs:
>>>>>>>>
>>>>>>>>   echo 1 > /sys/kernel/tracing/events/nfs/nfs_local_dio_write/enable
>>>>>>>>   echo 1 > /sys/kernel/tracing/events/nfs/nfs_local_dio_misaligned/enable
>>>>>>>>   echo 1 > /sys/kernel/tracing/events/nfs/nfs_initiate_write/enable
>>>>>>>>   echo 1 > /sys/kernel/tracing/events/nfs/nfs_writeback_done/enable
>>>>>>>>   echo 1 > /sys/kernel/tracing/events/xfs/xfs_file_direct_write/enable
>>>>>>>
>>>>>>> I'm having a lot of trouble compiling this patch. I'm seeing errors like this:
>>>>>>>
>>>>>>>
>>>>>>> fs/nfs/nfstrace.h:1800:1: error: declaration of 'struct nfs_local_dio' will not be visible outside of this function [-Werror,-Wvisibility]
>>>>>>>  1800 | DEFINE_NFS_LOCAL_DIO_EVENT(write);
>>>>>>>       | ^
>>>>>>> fs/nfs/nfstrace.h:1796:17: note: expanded from macro 'DEFINE_NFS_LOCAL_DIO_EVENT'
>>>>>>>  1796 |                  const struct nfs_local_dio *local_dio),\
>>>>>>>       |                               ^
>>>>>>> fs/nfs/nfstrace.h:1800:1: error: declaration of 'struct nfs_local_dio' will not be visible outside of this function [-Werror,-Wvisibility]
>>>>>>> fs/nfs/nfstrace.h:1796:17: note: expanded from macro 'DEFINE_NFS_LOCAL_DIO_EVENT'
>>>>>>>  1796 |                  const struct nfs_local_dio *local_dio),\
>>>>>>>       |                               ^
>>>>>>> fs/nfs/nfstrace.h:1800:1: error: declaration of 'struct nfs_local_dio' will not be visible outside of this function [-Werror,-Wvisibility]
>>>>>>> fs/nfs/nfstrace.h:1796:17: note: expanded from macro 'DEFINE_NFS_LOCAL_DIO_EVENT'
>>>>>>>  1796 |                  const struct nfs_local_dio *local_dio),\
>>>>>>>       |                               ^
>>>>>>> fs/nfs/nfstrace.h:1800:1: error: declaration of 'struct nfs_local_dio' will not be visible outside of this function [-Werror,-Wvisibility]
>>>>>>> fs/nfs/nfstrace.h:1796:17: note: expanded from macro 'DEFINE_NFS_LOCAL_DIO_EVENT'
>>>>>>>  1796 |                  const struct nfs_local_dio *local_dio),\
>>>>>>>       |                               ^
>>>>>>> fs/nfs/nfstrace.h:1800:1: error: declaration of 'struct nfs_local_dio' will not be visible outside of this function [-Werror,-Wvisibility]
>>>>>>> fs/nfs/nfstrace.h:1796:17: note: expanded from macro 'DEFINE_NFS_LOCAL_DIO_EVENT'
>>>>>>>  1796 |                  const struct nfs_local_dio *local_dio),\
>>>>>>>       |                               ^
>>>>>>> fs/nfs/nfstrace.h:1800:1: error: declaration of 'struct nfs_local_dio' will not be visible outside of this function [-Werror,-Wvisibility]
>>>>>>> fs/nfs/nfstrace.h:1796:17: note: expanded from macro 'DEFINE_NFS_LOCAL_DIO_EVENT'
>>>>>>>  1796 |                  const struct nfs_local_dio *local_dio),\
>>>>>>>       |                               ^
>>>>>>> fs/nfs/nfstrace.h:1800:1: error: declaration of 'struct nfs_local_dio' will not be visible outside of this function [-Werror,-Wvisibility]
>>>>>>> fs/nfs/nfstrace.h:1796:17: note: expanded from macro 'DEFINE_NFS_LOCAL_DIO_EVENT'
>>>>>>>  1796 |                  const struct nfs_local_dio *local_dio),\
>>>>>>>       |                               ^
>>>>>>> fs/nfs/nfstrace.h:1800:1: error: incompatible pointer types passing 'const struct nfs_local_dio *' to parameter of type 'const struct nfs_local_dio *' [-Werror,-Wincompatible-pointer-types]
>>>>>>>  1800 | DEFINE_NFS_LOCAL_DIO_EVENT(write);
>>
>> BTW, this ^ last incompatible pointer type error doesn't make any
>> sense.
>>
>> I'm concerned this is very specific to your development environment.
>>
>> (more reply below)
>>
>>>>>>>
>>>>>>>
>>>>>>> Am I missing a patch somewhere along the line?
>>>>>>>
>>>>>>> Thanks,
>>>>>>> Anna
>>>>>>>
>>>>>>>>
>>>>>>>> Signed-off-by: Mike Snitzer <snitzer@kernel.org>
>>>>>>>> ---
>>>>>>>>  fs/nfs/internal.h | 10 +++++++
>>>>>>>>  fs/nfs/localio.c  | 19 ++++++-------
>>>>>>>>  fs/nfs/nfs3xdr.c  |  2 +-
>>>>>>>>  fs/nfs/nfstrace.h | 70 +++++++++++++++++++++++++++++++++++++++++++++++
>>>>>>>>  4 files changed, 89 insertions(+), 12 deletions(-)
>>>>>>>>
>>>>>>>> diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
>>>>>>>> index d44233cfd7949..3d380c45b5ef3 100644
>>>>>>>> --- a/fs/nfs/internal.h
>>>>>>>> +++ b/fs/nfs/internal.h
>>>>>>>> @@ -456,6 +456,16 @@ extern int nfs_wait_bit_killable(struct wait_bit_key *key, int mode);
>>>>>>>>  
>>>>>>>>  #if IS_ENABLED(CONFIG_NFS_LOCALIO)
>>>>>>>>  /* localio.c */
>>>>>>>> +struct nfs_local_dio {
>>>>>>>> +	u32 mem_align;
>>>>>>>> +	u32 offset_align;
>>>>>>>> +	loff_t middle_offset;
>>>>>>>> +	loff_t end_offset;
>>>>>>>> +	ssize_t	start_len;	/* Length for misaligned first extent */
>>>>>>>> +	ssize_t	middle_len;	/* Length for DIO-aligned middle extent */
>>>>>>>> +	ssize_t	end_len;	/* Length for misaligned last extent */
>>>>>>>> +};
>>>>>>>> +
>>>>>>>>  extern void nfs_local_probe_async(struct nfs_client *);
>>>>>>>>  extern void nfs_local_probe_async_work(struct work_struct *);
>>>>>>>>  extern struct nfsd_file *nfs_local_open_fh(struct nfs_client *,
>>>>>>>> diff --git a/fs/nfs/localio.c b/fs/nfs/localio.c
>>>>>>>> index 768af570183af..cf1533759646e 100644
>>>>>>>> --- a/fs/nfs/localio.c
>>>>>>>> +++ b/fs/nfs/localio.c
>>>>>>>> @@ -322,16 +322,6 @@ nfs_local_iocb_alloc(struct nfs_pgio_header *hdr,
>>>>>>>>  	return iocb;
>>>>>>>>  }
>>>>>>>>  
>>>>>>>> -struct nfs_local_dio {
>>>>>>>> -	u32 mem_align;
>>>>>>>> -	u32 offset_align;
>>>>>>>> -	loff_t middle_offset;
>>>>>>>> -	loff_t end_offset;
>>>>>>>> -	ssize_t	start_len;	/* Length for misaligned first extent */
>>>>>>>> -	ssize_t	middle_len;	/* Length for DIO-aligned middle extent */
>>>>>>>> -	ssize_t	end_len;	/* Length for misaligned last extent */
>>>>>>>> -};
>>>>>>>> -
>>>>>>>>  static bool
>>>>>>>>  nfs_is_local_dio_possible(struct nfs_local_kiocb *iocb, int rw,
>>>>>>>>  			  size_t len, struct nfs_local_dio *local_dio)
>>>>>>>> @@ -367,6 +357,10 @@ nfs_is_local_dio_possible(struct nfs_local_kiocb *iocb, int rw,
>>>>>>>>  	local_dio->middle_len = middle_end - start_end;
>>>>>>>>  	local_dio->end_len = orig_end - middle_end;
>>>>>>>>  
>>>>>>>> +	if (rw == ITER_DEST)
>>>>>>>> +		trace_nfs_local_dio_read(hdr->inode, offset, len, local_dio);
>>>>>>>> +	else
>>>>>>>> +		trace_nfs_local_dio_write(hdr->inode, offset, len, local_dio);
>>>>>>>>  	return true;
>>>>>>>>  }
>>>>>>>>  
>>>>>>>> @@ -446,8 +440,11 @@ nfs_local_iters_setup_dio(struct nfs_local_kiocb *iocb, int rw,
>>>>>>>>  		nfs_iov_iter_aligned_bvec(&iters[n_iters],
>>>>>>>>  			local_dio->mem_align-1, local_dio->offset_align-1);
>>>>>>>>  
>>>>>>>> -	if (unlikely(!iocb->iter_is_dio_aligned[n_iters]))
>>>>>>>> +	if (unlikely(!iocb->iter_is_dio_aligned[n_iters])) {
>>>>>>>> +		trace_nfs_local_dio_misaligned(iocb->hdr->inode,
>>>>>>>> +			iocb->hdr->args.offset, len, local_dio);
>>>>>>>>  		return 0; /* no DIO-aligned IO possible */
>>>>>>>> +	}
>>>>>>>>  	++n_iters;
>>>>>>>>  
>>>>>>>>  	iocb->n_iters = n_iters;
>>>>>>>> diff --git a/fs/nfs/nfs3xdr.c b/fs/nfs/nfs3xdr.c
>>>>>>>> index 4ae01c10b7e28..e17d729084125 100644
>>>>>>>> --- a/fs/nfs/nfs3xdr.c
>>>>>>>> +++ b/fs/nfs/nfs3xdr.c
>>>>>>>> @@ -23,8 +23,8 @@
>>>>>>>>  #include <linux/nfsacl.h>
>>>>>>>>  #include <linux/nfs_common.h>
>>>>>>>>  
>>>>>>>> -#include "nfstrace.h"
>>>>>>>>  #include "internal.h"
>>>>>>>> +#include "nfstrace.h"
>>>>>>>>  
>>>>>>>>  #define NFSDBG_FACILITY		NFSDBG_XDR
>>>>>>>>  
>>>>>>
>>>>>> This change ^ was critical for fixing unknown type issues for 'struct
>>>>>> nfs_local_dio' issues on my build. But I haven't seen the issue you've
>>>>>> reported above. I'll try applying my changes on very latest upstream
>>>>>> tree.
>>>>>>
>>>>>> Which tree/branch are you using for your baseline?  Also, which
>>>>>> version of gcc (which distro even) are you using?
>>>>>
>>>>> I'm using my linux-next branch from: git.linux-nfs.org/projects/anna/linux-nfs.git.
>>>>> It's v6.17-rc6 plus the patches I'm planning for the next merge window.
>>>>
>>>> Like I mentioned in another reply in this thread, I've pushed a tree
>>>> that is based on your linux-next branch here:
>>>> https://git.kernel.org/pub/scm/linux/kernel/git/snitzer/linux.git/log/?h=anna-linux-next-6.18
>>>>
>>>> I've verified that this builds fine for me when using either:
>>>> EL8.10 with gcc 11.2.1-9
>>>> EL9.5 with 11.5.0-5
>>>>
>>>> Which distro and gcc version are you using?
>>>
>>> This is with Archlinux and clang v 20.1.8, although I do
>>> see similar errors with gcc 15.2.1.
>>
>> OK, so way more bleeding edge than my 2 versions of gcc 11.x
>>
>> I tried to see if disabling CONFIG_NFS_LOCALIO might explain it, but
>> that compiles fine for me too.
>>
>> Please feel free to share your .config with me off-list and I'll keep
>> chasing.
>>
> 
> FYI, I'm not seeing any compiler issues with gcc 15.1.1-2 (I updated
> my EL9 system to use gcc-toolset-15-15.0-9.el9.x86_64).
> 
> Please feel free to drop this nfstrace patch until we're able to
> figure out what's happening on your build environment.

Sounds good! I'll send you the .config I'm using privately if you want to try it out.

Anna

> 
> Thanks,
> Mike


