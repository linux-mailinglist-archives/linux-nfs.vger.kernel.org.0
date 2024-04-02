Return-Path: <linux-nfs+bounces-2606-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D042A895E64
	for <lists+linux-nfs@lfdr.de>; Tue,  2 Apr 2024 23:05:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4280C1F22C06
	for <lists+linux-nfs@lfdr.de>; Tue,  2 Apr 2024 21:05:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ADE415B121;
	Tue,  2 Apr 2024 21:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="cOBwRljH";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="XTUVqoMi"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DB9315E5CF
	for <linux-nfs@vger.kernel.org>; Tue,  2 Apr 2024 21:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712091835; cv=fail; b=o5pVcleV/go7wOkeDPK6eYjZIDyRAyjAw2SxBOK/rRORoEs+SZAEwlAngp338yU22AGNzKOiyxY6ax6gBCgQEdkClYtbmcBmZTNj7skJM9QaBOt+8tnCq7wiX9Wv1FfT8ewoOtffMkymh1ul+B4v6DkU9AF3A5bHpqB+gO3JATQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712091835; c=relaxed/simple;
	bh=JsU9YTihs5NHZWnvC9k9eyeayKd3ZzTCsJVOk1Y7SLg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=nwPRYwjDT4Hu80f9NeOCQxjawAyjCAIPxAV2OVNCeBTdXYoNdl5Uvrec/ccrU/kn2jMSf7PwIKLj3jkO+ZHV31USDLCLidItRssKm2pUkFUIt9kElObPXryin8ZrW5nlmmJ1+4HnKjKsjADLbMGctaaDJEgDvX1qlps2PRrEJTI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=cOBwRljH; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=XTUVqoMi; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 432F8T1J020074;
	Tue, 2 Apr 2024 21:03:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-11-20;
 bh=s+5wBrP8Nd+pNy/Tp+knjyr1QwDvFNnaTFC8QmAbRO8=;
 b=cOBwRljHen9wisDEi9d6TK8jXGdohP11IJGmKyEAwMhwFbrTxUQy0sp3GdSkZ5gNG8Kc
 XcQ2rwdW0qmeeHulfc8yIt512DZLDYjuBlu2iKb/CMuuNaTuH1K+oVzCRDuhqLx358NX
 mWg1r96g1khQx/ZmejsipCbtjbk/IFVWYlVliPOMVx3iTVzuuHZPnybSNhBD/0CkmLaz
 qaLzEU8nzwcGEW0iYrIdS0CjNLK13dzZyFxV0MF55z7/fWY/dUcFXCG8h8m1fb09kyhm
 dj66LtS+rgt1uTzQLeFvtf9wkm3rQmHpdcN1Uwn3aiV16wXK5/UOnB8ziZ1pXzT2Y1Qb OQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3x7tb9utmp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 02 Apr 2024 21:03:37 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 432KLXTC008360;
	Tue, 2 Apr 2024 21:03:36 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3x696dxgyx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 02 Apr 2024 21:03:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V2xOkwqFUwvTVb9ub8LgWM1Cb3NJkZxuZqhDCCCUTyk1g55BRSkvOCsKXqJmk6zQun2nR6WGJy1fNEtq16cJCGRrJg5cJF1V52PBewhs2SINpU9kDUSG4NfEY5H/xA6GKStc/6N3QdC35NbeHHX+vm/7SNzYjTpfBPCU/fRXRHY4Ko1lZ4ubdnx1cqih989TWje/KMejJXbSC2CnV5mlwA+L896MQDn5/gtIkRIQgUEJ2Yc+BydinTQFDqHhth0ZgTkJpYOBRFZUxQmN/v3/9VE27AiP7hXD3pzBWMFUWifC0L/8+qmsxTLwGBhOTkhG9cOwGQk+VV2P9MxOchCucw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s+5wBrP8Nd+pNy/Tp+knjyr1QwDvFNnaTFC8QmAbRO8=;
 b=dyZ5NNAcMmKbj/zDe18poKw83078SJR9BYnfeJKwFotMuA6uq0IRlbFMjUD86a6ooqn+rx5M5G8wJ6pzWnPlTJjKpapleVe6DeM57nV0RIys9zlcOaXTnuqsTUIQZdy2+oRV1q5ylwPeXAYXZOIZXtKj3QAYmzqoUALjPVcT1OdUpdCw8+velWWbK8T/E3SNTldkrCS52AlLSdmUF3EAPkWxFH4z+6fw6ZuOgXbLT0eRYp+Vx+zoaB/meis5odE083HsnMhicAlMLZolTDeI0/s6VD27jK4KI6NNIZ5lpAt8xqSgyB0SYhv+Kt/7+BBL4SY7QJ5fetRsBUfZLyClVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s+5wBrP8Nd+pNy/Tp+knjyr1QwDvFNnaTFC8QmAbRO8=;
 b=XTUVqoMioU8HKihreMratSx+Fsl9GAioTt4Q7tYjAzEQFYAIxJakk9XpEvAyG/VT5HUxC4+aQTFYg3i+rQk1prJvun1YWvVS47lNJgHBtx4YAWVUrD1jkXDlujRzosi+1FHyHOoXWk4r53g+RTlDpxn5lW7gZWayq634pVv8H1Y=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DS7PR10MB7252.namprd10.prod.outlook.com (2603:10b6:8:ee::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 2 Apr
 2024 21:03:34 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ad12:a809:d789:a25b]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ad12:a809:d789:a25b%4]) with mapi id 15.20.7409.042; Tue, 2 Apr 2024
 21:03:34 +0000
Date: Tue, 2 Apr 2024 17:03:31 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: NeilBrown <neilb@suse.de>
Cc: Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org,
        Olga Kornievskaia <kolga@netapp.com>, Dai Ngo <Dai.Ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>
Subject: Re: [PATCH 1/4  v3] nfsd: perform all find_openstateowner_str calls
 in the one place.
Message-ID: <Zgxyo8SH/DQYgF1j@tissot.1015granger.net>
References: <171010907730.13576.5751778995820664441@noble.neil.brown.name>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <171010907730.13576.5751778995820664441@noble.neil.brown.name>
X-ClientProxiedBy: CH0P220CA0004.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:610:ef::10) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|DS7PR10MB7252:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	RW+Vo6XEshYMFMKN6DLKGk7v4kPhBdzsHiW1a95lChhGST/yfgRd4h9+EbtGe0zmDDvMJ4VeBHUUrbDrvgiQ8DaNS9tHi2LyumzIwAK4PAFEZFRvxXhEra5LsaJvlPwdR5bBEzg+GNytQ23elU29hMmEKKkYq3VClgqrsFlYt3WoUuA+z0oho+3oNJZ1VBqRlCFbhCtcD+ttGth9PIdjnRblrV4Q6/nGVudU/C1vtphPhcrYEA58HdmmxE8XB+XBsoOUp3vNouP1PP39xMi0uNPpedOfBYjLdqcFn74AkSbc1BDqiQ+xWeLMsJqQDaHc1R5HE1AN8g/Nc4qqyp+ineI8sQA5I4gctg6qtiO35boD28loNA553+Fu3uFjlrweD0oXa5TqAl2v+xNwwrSE7iEMuH4luq2ZiQXlPvMwOoGxwaCyoD9Gfjmfy6Lv+idBpID6wSTrRtvvQwC7z21gnAi25UNo+QTo1JV+JplAkQmI3HND3YlxTciUcG0RRNeERX1NfclHhHVXWfG7dEJmHPXn+6+hM5Tjna/tBpFLW7dQLHXxxQMW2KHjFjDzG42yCSMraRvax90+3zzx/oN/7yXCjJ40DcX/VNoqcaOXsqTqsZbpZ29Wr30usmZpwBuvuGz5AL7EMgQLtpn7sth4K7qFsGZaaPikVatytTCgY7s=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?JUB3U0Nt9/5QmXdG6x3lfGKKoH9bzFiFt5Z0OgESeeJmXzD7f/I7nvcTK/17?=
 =?us-ascii?Q?dwyr9F+J6JQ0cRH/3yWSEFBzeLKDW4GNj+ImPU9PetFC3KwaznDsW95xa+mU?=
 =?us-ascii?Q?H2Oj4OgRZrexXp4nWMGf3cOo0GolJgUgaLQAqyw4kOFBJTK1idmwr0AbibEX?=
 =?us-ascii?Q?lcXjLpvv1LoQfZqsVl3VLokQ6Cd7sdMB2lSFGlftg+nMpGKlVZOacHf8qxUO?=
 =?us-ascii?Q?OcyyCVOCkGboGJXWs4EczgwU04mv3Ks/lXdgHJOR4UoNqyYFEbeb85LBIzbq?=
 =?us-ascii?Q?uWm9PnwRO/AVaUNZ2KXBj2KHHcKswUQfXTMO1ldbphhkEP/v01z4Q9Pher2G?=
 =?us-ascii?Q?qt1sPM5BJv8Vu4C0BchQ2+3FaWqwyagdWEDOiKnDWALiZqgKCGv7FxaocSBs?=
 =?us-ascii?Q?9d2lHh0o43pbB4UU5QilJ1Wq3DVIND93WRwEJC7oGqb/hCtWOYKLZjUb4T2L?=
 =?us-ascii?Q?4iLB2vyOFkYOu82rdjb8tZQeeFWnv1/x8eebmdDBQijF6qlhP8G97lQO8UBo?=
 =?us-ascii?Q?5dzVYMT+bUL2Nx98rKI6HEwqlIkJM8yEC+uzaZkdoiT91h8qPjhZCUhJM/YJ?=
 =?us-ascii?Q?iLGqlBpCOfumJgQ8neoCYwiMjR/ExNZNBXpvs7JcIQV4RhOjhIFDm8bXLJJB?=
 =?us-ascii?Q?WHqCEdSr0NIxwlAKeeiRlPJq9RdmXIZAJrEu6dgla0fIdLhQVYH29ceWMqtL?=
 =?us-ascii?Q?VQ+wTRvB5QmUVZB1ALpmKc5a/eNFlorEMkE+unDVf6xkNMOutHE3ypc7jXfw?=
 =?us-ascii?Q?CUQepFQF1/79Fep39qh+MJYRr8sGR5HPz3hFii6ArDUoJ+lHhck+KWyAMG8f?=
 =?us-ascii?Q?LaMxcgZLRU38/f0t7XbiJptDj1JVU/Yd+XWBW2cWB+6+vWB3Q0Lia5/pSPLy?=
 =?us-ascii?Q?VfUUI5nmr1BJSEGAP7fIDPhNlFDkMfPVeiV5fRx98sMro18FJm7lHlYOlHiy?=
 =?us-ascii?Q?NxRZnhKF1estRK7nzRTlOTubuKEhBERTBLiEBbhCgvzNZYk4GGJNze+7m/9o?=
 =?us-ascii?Q?bkjCQ17RCd5D8aAtapi4FmupoaRAzTGe54l9C1X16/P8Miwpf8twzBSwznXE?=
 =?us-ascii?Q?BnntWmw7WBXZS7HCW5oObKTdwfqkvty88q7aTkVNnWMBxViaOaGpU7waevjQ?=
 =?us-ascii?Q?0qock4zfFRqPJlt/bkMfGml3FjtTRTzd0qE6tPnrdSJHYAt6Kmi/3t+50GFf?=
 =?us-ascii?Q?bA4xBynfgwgMUJSXf3tg918ubizDl863uQWvcWUMoF6MZZWQHpq7S3qcLoeN?=
 =?us-ascii?Q?5uoxLMnzzrx7tEQl9kxnhdOOwXODfEAs2qxJgzJnHyeL1Nnp51sFycflll87?=
 =?us-ascii?Q?rQSO7Np714rTsqTCi2mwp6yEBuiNQK+iH48soOaiVi7AGMYP7iSevjcG+MVm?=
 =?us-ascii?Q?gyRCEQYfrmFjnbpqq3LwNVzL70aOWsKKZDU6jqWwYbbz28z1IJXFs+QxDaAS?=
 =?us-ascii?Q?RGry7toqo92tJquuljA+W/8HP8aXm030GsQ4sSnTcyvJeEqKaFA+mPMPH/rz?=
 =?us-ascii?Q?NXKgSXGkrU0Z3yPq0flyBhO7ghUVwq49C+Rnn4435LtNcaAAcJ9lukm+uck2?=
 =?us-ascii?Q?xbXeI23qQcKSlHpOjfdt6mo1iT0Ua7FVESTKDoYPE25/Hcl78xPsbtvKZ0ay?=
 =?us-ascii?Q?jw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	Hl6xDXw4lGBSovuPkqhcnnGuHpz73mrYTY0eAEYEcHsec9ziFQbS3wV4FgLRFV8BOwNDxfO+YoMkHu5pP+cixH41+ZRV/Q0W8MH3wsjXG3KeZW/uR2QxpvTsuVhrdcmvyJmPcedbMqHhS0PBkGGRRbpr2RMrxHR22nDLbF4K8YJBX2vXWTbw9cfDYjgcUpuqSPqu2Wb1p0xVE8+5mYcATuyvAjmJvn4I4sO1MnMnuewhgTCqr7Ky17ufsgZ4u5OO9wPLpJQQaVY1SktznGqKuhrzdNroe/H7w173oBWpWoC3HkZmZYFOeBFQ5BgnJOUkmsFjZqJMK+gl6ba13Ti7IOZeGiWFtDdRqRYDDb1LHwt7IWiKawJgB3LzGO1v2fPAy7ZcYX1n76M6ciVJK/DhK2ndGKSWfUmUoGFHJ5V7ZIJvbm3NlA5Dy0CRi92huIhQpJZuf34T1hVjUjY1iwQwxoDOOvewhZ/ECxTlFC9N1SQ1Q9Q+GkWYufwNyOHAI5s2nXly1IDdEHpkPAFTG2rtWeR3c6QWJIeXPfs4BcACX7RhUqk4OZI/k98k75P2NUJAdkfLnbVmRfnrc8smaXYSLr68ajVkv7D6yMcBuoitEUE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45f84102-44f2-4ca8-d447-08dc53585c01
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2024 21:03:34.7287
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cqqk/sP0cns4jPJ25ykPMPADO8yxanM+9HnAkW8sO3CzZLMvpXiOvrRRoHYPjrw7jkvjw6r/WCG05z685TimFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7252
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-02_14,2024-04-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 phishscore=0 bulkscore=0 spamscore=0 adultscore=0 mlxlogscore=830
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403210000 definitions=main-2404020156
X-Proofpoint-GUID: MYcNftqlXM0CK3Pb4JQpoxuSADljgvmP
X-Proofpoint-ORIG-GUID: MYcNftqlXM0CK3Pb4JQpoxuSADljgvmP

On Mon, Mar 11, 2024 at 09:17:57AM +1100, NeilBrown wrote:
> 
> Currently find_openstateowner_str lookups are done both in
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
> 
> The previous version of this patch could deadlock on ->cl_lcok as it
> called release_openowner() while holding that lock.
> This version doesn't.
> 
> Subsequent patch in the original series should be unchanged.  If needed
> I can resent them all after -rc1 is out.

I have, from March 5, 2024:

1/4: nfsd: move nfsd4_cstate_assign_replay() earlier in open handling.
2/4: nfsd: perform all find_openstateowner_str calls in the one place.
3/4: nfsd: replace rp_mutex to avoid deadlock in move_to_close_lru()
4/4: nfsd: drop st_mutex_mutex before calling move_to_close_lru()

Note that "nfsd: perform all find_open..." is 2/4, not 1/4. It
applies cleanly to v6.9-rc2, but after it has been applied, the
others do not apply cleanly. If I apply "nfsd: move nfsd4_cstate..."
first, then "nfsd: perform all find_open..." does not apply cleanly.

Please rebase this series on v6.9-rc2, test it, and re-post the
full series as "v4".  Thanks!


>  fs/nfsd/nfs4state.c | 93 +++++++++++++++++++--------------------------
>  1 file changed, 40 insertions(+), 53 deletions(-)
> 
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index ee9aa4843443..3e144b1a1386 100644
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
> +retry:
>  	spin_lock(&clp->cl_lock);
> -	ret = find_openstateowner_str_locked(strhashval, open, clp);
> -	if (ret == NULL) {
> -		hash_openowner(oo, clp, strhashval);
> -		ret = oo;
> -	} else
> -		nfs4_free_stateowner(&oo->oo_owner);
> -
> +	oo = find_openstateowner_str(strhashval, open, clp);
> +	if (!oo && new) {
> +		hash_openowner(new, clp, strhashval);
> +		spin_unlock(&clp->cl_lock);
> +		return new;
> +	}
>  	spin_unlock(&clp->cl_lock);
> -	return ret;
> +
> +	if (oo && !(oo->oo_flags & NFS4_OO_CONFIRMED)) {
> +		/* Replace unconfirmed owners without checking for replay. */
> +		release_openowner(oo);
> +		oo = NULL;
> +	}
> +	if (oo) {
> +		if (new)
> +			nfs4_free_stateowner(&new->oo_owner);
> +		return oo;
> +	}
> +
> +	new = alloc_stateowner(openowner_slab, &open->op_owner, clp);
> +	if (!new)
> +		return NULL;
> +	new->oo_owner.so_ops = &openowner_ops;
> +	new->oo_owner.so_is_open_owner = 1;
> +	new->oo_owner.so_seqid = open->op_seqid;
> +	new->oo_flags = 0;
> +	if (nfsd4_has_session(cstate))
> +		new->oo_flags |= NFS4_OO_CONFIRMED;
> +	new->oo_time = 0;
> +	new->oo_last_closed_stid = NULL;
> +	INIT_LIST_HEAD(&new->oo_close_lru);
> +	goto retry;
>  }
>  
>  static struct nfs4_ol_stateid *
> @@ -5331,27 +5331,14 @@ nfsd4_process_open1(struct nfsd4_compound_state *cstate,
>  	clp = cstate->clp;
>  
>  	strhashval = ownerstr_hashval(&open->op_owner);
> -	oo = find_openstateowner_str(strhashval, open, clp);
> +	oo = find_or_alloc_open_stateowner(strhashval, open, cstate);
>  	open->op_openowner = oo;
> -	if (!oo) {
> -		goto new_owner;
> -	}
> -	if (!(oo->oo_flags & NFS4_OO_CONFIRMED)) {
> -		/* Replace unconfirmed owners without checking for replay. */
> -		release_openowner(oo);
> -		open->op_openowner = NULL;
> -		goto new_owner;
> -	}
> +	if (!oo)
> +		return nfserr_jukebox;
>  	status = nfsd4_check_seqid(cstate, &oo->oo_owner, open->op_seqid);
>  	if (status)
>  		return status;
> -	goto alloc_stateid;
> -new_owner:
> -	oo = alloc_init_open_stateowner(strhashval, open, cstate);
> -	if (oo == NULL)
> -		return nfserr_jukebox;
> -	open->op_openowner = oo;
> -alloc_stateid:
> +
>  	open->op_stp = nfs4_alloc_open_stateid(clp);
>  	if (!open->op_stp)
>  		return nfserr_jukebox;
> -- 
> 2.43.0
> 

-- 
Chuck Lever

