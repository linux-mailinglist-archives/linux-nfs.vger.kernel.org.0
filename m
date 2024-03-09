Return-Path: <linux-nfs+bounces-2248-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A89A87736D
	for <lists+linux-nfs@lfdr.de>; Sat,  9 Mar 2024 19:57:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF5E11F213F1
	for <lists+linux-nfs@lfdr.de>; Sat,  9 Mar 2024 18:57:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E23B4286BD;
	Sat,  9 Mar 2024 18:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="RzmtHxOF";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="zwM2oqQO"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A936516FF30
	for <linux-nfs@vger.kernel.org>; Sat,  9 Mar 2024 18:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710010623; cv=fail; b=UBFxQr7sdeDUD23ojOEvcqe0jXZnQVTIvi5BKSbBOhgMEs8mITZ3kmkbqjOAMcUu/9DZTLnZ+2x00NK07QJ6IIbqG6lXmnz1AD6A6T7xE3/86mJn2fV1S6xjd13+dXfCwK5A1r+McOgrxWx+0kv6hHkr5JsJjwXnMmtL5NgLJhU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710010623; c=relaxed/simple;
	bh=WuA9m35RUmlprh7/S1bZIgZpL62Uu+EVAKRqYefGad0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Z9vbnkk9Tx6geQlereswsvhg0/jevXIAgaFlS/ATu2gNA5i+MOscFJaSNhRhMjLOSZsejKlpbGQfDjj4exnjZjZPDZJdBM+62M1OS+N4EL+wDzwhnHi7u1M+6X8JRyM3sYUDC6VBZ6D9MWv+TPdVg9QZjUVxgRUFyND90bv3j2w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=RzmtHxOF; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=zwM2oqQO; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 429HxAgw008844;
	Sat, 9 Mar 2024 18:56:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-11-20;
 bh=EhDG75W1Ne4v0fYn8Aum4p9LERboQbcAStgGo78pAZk=;
 b=RzmtHxOFxlqQx8TYHpVi4CC6ehFHXNvyqk8uMu/Mf3IqQ/1lJ4lJzorjh/zjgR0ott1s
 a3mBBs6wLVIAVNW33DUk2gjrnhOFgvtzsMkWIakeYk8cuaiW5sAafAfv1W+wzoFQsyYX
 4Zvqp3Uxnxo4inAZifBSmrgz5RSg+9uSbuvUvQ/BF8fLAWJuvfJHc9lnot8JSe/ufu3L
 R5e2rhE1BQW0vnX5rR62mCLBI8fQykUkpYrWvPRApW2pqQvZVuv0V6Ylu9TwdWtaBrVB
 vC7cz+FWQk/FkhwYjOoWt1CxW5RQSBKGvX1659bvOFo69wVJuHJid3Taa7jHNZe8cLYc RA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wre6e8q4f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 09 Mar 2024 18:56:43 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 429EpBNv006101;
	Sat, 9 Mar 2024 18:56:42 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3wre749en8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 09 Mar 2024 18:56:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=No3tA5X3nwYHx0Y1I0PsRHbsLuABnx2gw7zKuyDgcE2WsKYLHQJgxctnhT0eDy2qZ3U08bavht1W+thqvAVWjkXvkoBpErDM3ecQHo9tV3vzJpj4QHof1zHSheuBTcWLb5VLJ8YXJ7FhTdqVycxmUu6QoRnqJEt80OnEFv3WLrEvnkd0aeo9fsMIWUM7gAZ7qDnd5DT2WXkOfOkCgIpIUAQpYnhIRJ1Z8lTTJAnCkbKMdhWvmjDuTe5ZukdJoZThRjECLD+3hApmIWRN6aevemlvaCrgJgXFX27tUbtLvMo+ov22nTKfTF/f5gifJmMxK12DC7XejvOFUO6l/AKGBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EhDG75W1Ne4v0fYn8Aum4p9LERboQbcAStgGo78pAZk=;
 b=C7eycpXelIUbL6BFwdhNiC2NG4VElBA98Dt+NtskzICWcAIFghRrkkc98hm/DddwGSxahxz0x7bwBApJ0VP2NJM4MZerxGpikZhZ0LjZbVNav3KOEC8ogYAi2q6/eMAGOs7D99XdOZOBzgKj0qp99ULEnYlS2ZbzRTjvyJxd7DlRb7QfvucE9ZereTmUrSCoTv8SurtYldl6Uk+zfasjKCIRQXQRF5s97LRXhmB/QmRbi+nDnfJtUAA03buBG98Y0kPAYIuwDxtRsKH/2rRSTz/StMLfweJFkfJQJjosrKaPEq4sUeLbna5OQwG2tMtDuKZ3YqIvqpww2pX38yd3TA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EhDG75W1Ne4v0fYn8Aum4p9LERboQbcAStgGo78pAZk=;
 b=zwM2oqQO0PCtMpTbSKORfYkccxcDHW/Wb0R9TPhdxjLnTa1TC1enodmY/0fxcT3eUpEgkmRvEGTAYx4TDFH9yanyS0xoLy2rrIcZdeB8yshNIXM0tm5twfwq4tKYVOKqHLoH5srRSwfbGPVZUPtiJiuJ/siR05oF6b7aAkshqrk=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by LV3PR10MB7724.namprd10.prod.outlook.com (2603:10b6:408:1b4::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.27; Sat, 9 Mar
 2024 18:56:40 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ad12:a809:d789:a25b]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ad12:a809:d789:a25b%4]) with mapi id 15.20.7362.031; Sat, 9 Mar 2024
 18:56:40 +0000
Date: Sat, 9 Mar 2024 13:56:37 -0500
From: Chuck Lever <chuck.lever@oracle.com>
To: NeilBrown <neilb@suse.de>
Cc: Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org,
        Olga Kornievskaia <kolga@netapp.com>, Dai Ngo <Dai.Ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>
Subject: Re: [PATCH 2/4] nfsd: perform all find_openstateowner_str calls in
 the one place.
Message-ID: <Zeyw5c3WO-OjinBE@manet.1015granger.net>
References: <20240304224714.10370-1-neilb@suse.de>
 <20240304224714.10370-3-neilb@suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240304224714.10370-3-neilb@suse.de>
X-ClientProxiedBy: CH0PR03CA0428.namprd03.prod.outlook.com
 (2603:10b6:610:10e::23) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|LV3PR10MB7724:EE_
X-MS-Office365-Filtering-Correlation-Id: 549d77ff-8f17-43c7-b83a-08dc406aa7a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	nWpYjuPWRlytg5e7USjz+dJK07Slw829moZc9Ue/9BGUwwibVIWRD6iJMJyeJ/gV2AcwKU4xVGakqTvf7D5Wzn8D303q2bYuudhvxF/OrB3mXjXN5tiL0woRsjld9YKmmZAaL0PLS2VG0HQcdjty6gIGAw+xxO0ik6n2jDGi983VNyiFUwdGL6m0O3aLgHAM+F41Z3xyF4+W4n7H7KvoWCbM4JA8D6r6F6jRN9MMcTKZXsp6JcyMuF72XSYVgG2bs9xXGujBNQ7Ps1+V8ZV9jewpqvo7Pbk7oljMOO5BJTvePx25LrvCRjXCSOBZ9aHU9s7qaEBsZg5HWzGHETblaE+PzpIGWSaTh1C3bso0dlZLKJ3tf09agLZmC7CK/i602LUjOzy6EvY3RUATOyzGcWMayQcAnApGv/k7UDVP7Tipp5mjI4zbZn1S8uw/Q/rNRNEt91Hw1HHDX6rbxAVZ/UEky3cer0kE1nH/gT5+kJGYu+xkIcVDorFfuWbiEu2y8r6DhstZ5+O4aeYTrGG/W2FAE0M0k5mcXxOOGwQ6rWO+Qw7XveygfL64UmA4Npn9/i6kB320iSoxjNQIHARNzE26vtE6yipOIsUQaA0nDenYif8o985O3TExyEtrQeobY4mGbjwBLb+loxYsiPvyjA==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?K3GZcm4L1c4PhFAvFLz8x9Lcbnxe6z60s+tB9nxdV24kaz/KrdOYZE+XSByl?=
 =?us-ascii?Q?ixZHUsRIxhEbaJ29K2ttNUx3r0uee8PpD9XtP9L5brDOpLXMMTUWH0TdmyjF?=
 =?us-ascii?Q?DeCNaTbM/zJX8wsDVhBujppg2W1uaBrikwxqxhqL2MPpU/RrAn/zDlkcBUk6?=
 =?us-ascii?Q?JUVBq1YSqxvYGbXLeoiEmO+sDjXaSKczr25nnUt+7WuZvukucxX25brNmXqX?=
 =?us-ascii?Q?gAdUzL1ncz0+QT2ydoZXG55O+D1OmEJ+CSsvBLIdeY1WSxaLXUFzGCiCpDr4?=
 =?us-ascii?Q?JSSmco57VnzK0MuDsRc1oMG5zKQjjSUxpnoagGKjtzVSZq2cMRSqnbwH8BQ7?=
 =?us-ascii?Q?7zUw2n7LfRcIRKfWRqZ73mM7Ofa9XHGxKWLI9Wj7ahWyBxSOCXylnbLRdAgz?=
 =?us-ascii?Q?R4DfhILsTO/Oui9jOQfpkacnEUjkgdVBEN8CgiWiRHDS6Ex4emuUBsaAxbOs?=
 =?us-ascii?Q?UZ09BlKUc+CyU6VUajiIKUkcHKsyiD9ZfOAI4kcZ6ZE97F3K+TvEsy2ESFd/?=
 =?us-ascii?Q?+eOWwgthXTn/7A9hOs/Eg/bfMUo8CRbBReig1X1YoaUe3lPtJAfxzaCjxW6n?=
 =?us-ascii?Q?00M9PYjfInAngud/ffOj3C3sVPP9JgLN6dgNtHi/hViTu73jpe4MtyTrTGAt?=
 =?us-ascii?Q?QOaUMb5ypiu+s8TzKVRaR0gIp5k/xqSp3I3bAPUCqzQZTfyw5NcYHQIs97hm?=
 =?us-ascii?Q?EwbRNyYQk1ld9zMLv86G/9tfJJP8ZfX4/nOUNYQ/rlsvqCLGa9AW6HjZtDo8?=
 =?us-ascii?Q?ju4h9Smg91owW+9NNdS7dps34RFtoN7BM+XAPXeWYeN0p2Gonn1z0bejh1ao?=
 =?us-ascii?Q?OgepsZw4XUmKiki+Y7VRGpjp0QUy109xHSFhve5avdOSG2DufZuw6bhtQY7V?=
 =?us-ascii?Q?zAFpSoNLQDptqueE3pyZmcwjeOa9fbO/mSJerse/V+tlo4d/gHN76LYEzj7y?=
 =?us-ascii?Q?v1KtVEtH13OaqIl3m8nljJIFM03JrlFnUADG56mmvnhhKIhPuzLcZQOYAhjH?=
 =?us-ascii?Q?0I6p7w9i6w9Yo53zaDS7sr2sjjAxYconB8Lj2b/PxHAw8eko/ooDqdTEm9BW?=
 =?us-ascii?Q?q8Iuz2p6nMo35xrVkPzY+ivq8YTkxLaH/yGwzYYqGqetmpxheO3EdQfCcxdO?=
 =?us-ascii?Q?dLRTVtTHc+C5OP/nmSadqAUCNpoK7jDoHSy+D+jD5Nj4CARDkNot8skyg9xV?=
 =?us-ascii?Q?VDGvTV/v1CRwN3csRe1Bp5EQZSDQk6h8hZ5aoakq306ypbQ+n2tVyKa1tjjm?=
 =?us-ascii?Q?s+KZfPiaST9xur97NLvppvjpJDuxArnGt7V2Ixk2IGhnLwkmLZZ+D76PeLNk?=
 =?us-ascii?Q?+PnyJUKX0No+CK0wdt5Avj44I33WmnXFLzi9EHY2id4JplHGVzj1+xbZwr9q?=
 =?us-ascii?Q?Ovi7SfSmImilo9FsEapVOAyvYx/OqHQYT1uvGGbzNeqcHQhfv4mODeGl9IRu?=
 =?us-ascii?Q?oIse51W33Blz5E1qP0VXJqLPFSn1Rentxr+covVZmeVuitou4N7fv9U17pTP?=
 =?us-ascii?Q?F/mPPkILAHeDqXOWln9kNGj45CJ8icibW5e6LSF9O7Ol1b+Efqmg8blIccWK?=
 =?us-ascii?Q?6pHzHsXOFOcLmW1iDuBefVUXdV3bEUFZmHTLRCbj72vFOy0igWZn7ZVK9mMy?=
 =?us-ascii?Q?vw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	APLxBCrBKXTT+3yIOmf4cNfr7oKNr42LGudXN6ycVpfLsZEA6N8NS7Z+p56nnlEzca/TSud9EjeHBbJT6UBoSrBO+gtqBrPyvk/ytgTjTD1VMG9tvFO3vv6TqnLQamoE9s7MxcrD1C4tdFz/uYDFJ6/4l6r/A04cGYa/tS5Yl4ro30CCBD5WPmhHvufpSGvjWg8TJ2HX5Q3EHaFMcL2BkGo5aqHgZSTNBzf2qx5jfO8332dc9cMEkSMnr1FhURUst2zWsnewPL8eDWvaJV8EArhP/KLAFpuiu1uVbnIckOZ9/IEXkqsS2R9Bq8VIRcwr5h1JnAvMj95gcF4IasPa036ZxQIrrJGaRRcUKmRAj6WfG7Ilp7tbyZnBKlQjsdDLSCtwQYfYw+q8NMhQfXuzP4vhF73TOdp+sS/65rzEWmE1WW2PyXyy2mxVGCV2FWFPo1BL+xZ6YTs8uBRPHUaF0wiwLsnJU1l0ESODjGoy/3xqDRCTZrUH+5JRbx04E43s+W5E0DCnmscKbwwboXPbumOCM7Ii3HZOSIdhq1vfRZLCkNDjVJ6OmUOPBSBbdLN9U9KrXZs7MWdO+hs2AqrsDEySPSuZL8jpwFFLOtnd6P4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 549d77ff-8f17-43c7-b83a-08dc406aa7a4
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2024 18:56:40.4290
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4aT3K9E+BEakNVGmUUklVaQ5wMi2Frfw2KkLD2JTJ6yXxgtp4ME1a47e1a8AcxNZfv5xp3MdgchA8kHYJL3NpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB7724
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-09_03,2024-03-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 spamscore=0
 bulkscore=0 phishscore=0 malwarescore=0 suspectscore=0 mlxlogscore=687
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2403090156
X-Proofpoint-GUID: fXURg4d5g1FXeilqHYJxpTquy5GljEPi
X-Proofpoint-ORIG-GUID: fXURg4d5g1FXeilqHYJxpTquy5GljEPi

On Tue, Mar 05, 2024 at 09:45:22AM +1100, NeilBrown wrote:
> Currently find_openstateowner_str looks are done both in
> nfsd4_process_open1() and alloc_init_open_stateowner() - the latter
> possibly being a surprise based on its name.
> 
> It would be easier to follow, and more conformant to common patterns, if
> the lookup was all in the one place.
> 
> So replace alloc_init_open_stateowner() with
> find_or_alloc_open_stateowner() and use the latter in
> nfsd4_process_open1() without any calls to find_openstateowner_str().
> 
> This means all finds are find_openstateowner_str_locked() and
> find_openstateowner_str() is no longer needed.  So discard
> find_openstateowner_str() and rename find_openstateowner_str_locked() to
> find_openstateowner_str().
> 
> Signed-off-by: NeilBrown <neilb@suse.de>
> ---
>  fs/nfsd/nfs4state.c | 93 +++++++++++++++++++--------------------------
>  1 file changed, 40 insertions(+), 53 deletions(-)
> 
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index b9b3a2601675..0c1058e8cc4b 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -541,7 +541,7 @@ same_owner_str(struct nfs4_stateowner *sop, struct xdr_netobj *owner)
>  }
>  
>  static struct nfs4_openowner *
> -find_openstateowner_str_locked(unsigned int hashval, struct nfsd4_open *open,
> +find_openstateowner_str(unsigned int hashval, struct nfsd4_open *open,
>  			struct nfs4_client *clp)
>  {
>  	struct nfs4_stateowner *so;
> @@ -558,18 +558,6 @@ find_openstateowner_str_locked(unsigned int hashval, struct nfsd4_open *open,
>  	return NULL;
>  }
>  
> -static struct nfs4_openowner *
> -find_openstateowner_str(unsigned int hashval, struct nfsd4_open *open,
> -			struct nfs4_client *clp)
> -{
> -	struct nfs4_openowner *oo;
> -
> -	spin_lock(&clp->cl_lock);
> -	oo = find_openstateowner_str_locked(hashval, open, clp);
> -	spin_unlock(&clp->cl_lock);
> -	return oo;
> -}
> -
>  static inline u32
>  opaque_hashval(const void *ptr, int nbytes)
>  {
> @@ -4855,34 +4843,46 @@ nfsd4_find_and_lock_existing_open(struct nfs4_file *fp, struct nfsd4_open *open)
>  }
>  
>  static struct nfs4_openowner *
> -alloc_init_open_stateowner(unsigned int strhashval, struct nfsd4_open *open,
> -			   struct nfsd4_compound_state *cstate)
> +find_or_alloc_open_stateowner(unsigned int strhashval, struct nfsd4_open *open,
> +			      struct nfsd4_compound_state *cstate)
>  {
>  	struct nfs4_client *clp = cstate->clp;
> -	struct nfs4_openowner *oo, *ret;
> +	struct nfs4_openowner *oo, *new = NULL;
>  
> -	oo = alloc_stateowner(openowner_slab, &open->op_owner, clp);
> -	if (!oo)
> -		return NULL;
> -	oo->oo_owner.so_ops = &openowner_ops;
> -	oo->oo_owner.so_is_open_owner = 1;
> -	oo->oo_owner.so_seqid = open->op_seqid;
> -	oo->oo_flags = 0;
> -	if (nfsd4_has_session(cstate))
> -		oo->oo_flags |= NFS4_OO_CONFIRMED;
> -	oo->oo_time = 0;
> -	oo->oo_last_closed_stid = NULL;
> -	INIT_LIST_HEAD(&oo->oo_close_lru);
> -	spin_lock(&clp->cl_lock);
> -	ret = find_openstateowner_str_locked(strhashval, open, clp);
> -	if (ret == NULL) {
> -		hash_openowner(oo, clp, strhashval);
> -		ret = oo;
> -	} else
> -		nfs4_free_stateowner(&oo->oo_owner);
> +	while (1) {
> +		spin_lock(&clp->cl_lock);
> +		oo = find_openstateowner_str(strhashval, open, clp);
> +		if (oo && !(oo->oo_flags & NFS4_OO_CONFIRMED)) {
> +			/* Replace unconfirmed owners without checking for replay. */
> +			release_openowner(oo);
> +			oo = NULL;
> +		}
> +		if (oo) {
> +			spin_unlock(&clp->cl_lock);
> +			if (new)
> +				nfs4_free_stateowner(&new->oo_owner);
> +			return oo;
> +		}
> +		if (new) {
> +			hash_openowner(new, clp, strhashval);
> +			spin_unlock(&clp->cl_lock);
> +			return new;
> +		}
> +		spin_unlock(&clp->cl_lock);
>  
> -	spin_unlock(&clp->cl_lock);
> -	return ret;
> +		new = alloc_stateowner(openowner_slab, &open->op_owner, clp);
> +		if (!new)
> +			return NULL;
> +		new->oo_owner.so_ops = &openowner_ops;
> +		new->oo_owner.so_is_open_owner = 1;
> +		new->oo_owner.so_seqid = open->op_seqid;
> +		new->oo_flags = 0;
> +		if (nfsd4_has_session(cstate))
> +			new->oo_flags |= NFS4_OO_CONFIRMED;
> +		new->oo_time = 0;
> +		new->oo_last_closed_stid = NULL;
> +		INIT_LIST_HEAD(&new->oo_close_lru);
> +	}
>  }
>  
>  static struct nfs4_ol_stateid *
> @@ -5331,28 +5331,15 @@ nfsd4_process_open1(struct nfsd4_compound_state *cstate,
>  	clp = cstate->clp;
>  
>  	strhashval = ownerstr_hashval(&open->op_owner);
> -	oo = find_openstateowner_str(strhashval, open, clp);
> +	oo = find_or_alloc_open_stateowner(strhashval, open, cstate);
>  	open->op_openowner = oo;
>  	if (!oo)
> -		goto new_owner;
> -	if (!(oo->oo_flags & NFS4_OO_CONFIRMED)) {
> -		/* Replace unconfirmed owners without checking for replay. */
> -		release_openowner(oo);
> -		open->op_openowner = NULL;
> -		goto new_owner;
> -	}
> +		return nfserr_jukebox;
>  	nfsd4_cstate_assign_replay(cstate, &oo->oo_owner);
>  	status = nfsd4_check_seqid(cstate, &oo->oo_owner, open->op_seqid);
>  	if (status)
>  		return status;
> -	goto alloc_stateid;
> -new_owner:
> -	oo = alloc_init_open_stateowner(strhashval, open, cstate);
> -	if (oo == NULL)
> -		return nfserr_jukebox;
> -	open->op_openowner = oo;
> -	nfsd4_cstate_assign_replay(cstate, &oo->oo_owner);
> -alloc_stateid:
> +
>  	open->op_stp = nfs4_alloc_open_stateid(clp);
>  	if (!open->op_stp)
>  		return nfserr_jukebox;
> -- 
> 2.43.0
> 

While running the NFSv4.0 pynfs tests with KASAN and lock debugging
enabled, I get a number of CPU soft lockup warnings on the test
server and then it wedges hard. I bisected to this patch.

Because we are just a day shy of the v6.9 merge window, I'm going to
drop these four patches for v6.9. We can try them again for v6.10.


-- 
Chuck Lever

