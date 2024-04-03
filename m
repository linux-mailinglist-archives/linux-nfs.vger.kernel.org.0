Return-Path: <linux-nfs+bounces-2628-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 64FB28970DD
	for <lists+linux-nfs@lfdr.de>; Wed,  3 Apr 2024 15:27:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB7341F29334
	for <lists+linux-nfs@lfdr.de>; Wed,  3 Apr 2024 13:27:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC44B1487F0;
	Wed,  3 Apr 2024 13:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WMkw+4Bx";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="h+AcEDCQ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7F9E146D4B
	for <linux-nfs@vger.kernel.org>; Wed,  3 Apr 2024 13:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712150683; cv=fail; b=tFvTPohvJHIPe2jvDtyAcKAf7JGPToaannKaYKxUo4q7XxTRanaZotT+0WHt+F1cZoH+9VFgnhGDsXPfbPnx4uGDBdBmQwK5OwaUUHVa8ylE9u40KuWLTnqMRRN044DnZkiDro11Kw3F90b5LQBWeeGlxffqR/qMnE+DHSyaqNc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712150683; c=relaxed/simple;
	bh=OCOnLqqhBasQjB3sNsjHsIBze1rOC9MfjTYwOTFfMTw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=NLzkxzv9sbzQKNtOsA6uGIFmW1sp6ORjdCZsWbgK0eDmd9riuzxU5muQWz9fwpZKvvvx4PqvhXIjTzhkO5Q242hoBwpmxTn2tMgSyz7YOI5743apfY9y/T2E07f+LDF1LK4v7tvQ8C02kMspQzIcazIAqCiAlGqsg+vyFfWJQ/s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=WMkw+4Bx; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=h+AcEDCQ; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4334q0DP023044;
	Wed, 3 Apr 2024 13:24:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-11-20;
 bh=TWSiKcpC9olHu56uFWzOwH3x3427/sfqh4yeI0ZbqG4=;
 b=WMkw+4BxE+xgGMem+KfizFFnyyjJR6V56sMGraY0HR6XmZ2jtpJPTDMB383+UYrJlFWr
 9ySXgcd8HLjpYGtKpeK/hi8l7I+iLHkSIbcpk6/6rKO69XglBFqwKigS2mkYvzVD4GJc
 x/Nb0ko7AZRJb1DuhFYqZy+HDQ4vcXJnFwTbmKTFF19TncbvufmpYeyVCVdIQaF1D/iw
 GfVYZnfQ1If4PIdcRGjhHvhGv/+3oJACAZgvvgWt5DDAlRl2FqOIvw9hYQKHma/EBqCN
 JWy0d6nZ3eR+ru5wo07/Q9uTipEjcRr9j1sAKaNfMdanfjapojoO7Zq2xWfUyzdM6Zcq bw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3x6ambf1hb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 03 Apr 2024 13:24:40 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 433CupRb011490;
	Wed, 3 Apr 2024 13:24:38 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3x696etskw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 03 Apr 2024 13:24:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=agrB+65uZwZNgyXFlHJ8nEr/BhfmvnRmSnGxReWU+1pJSgMmadZgE/BQNwRT374ZzrgDOo8ZQRiR5WrrhUr4zICeEjFlrTHlW1zrYciYg6xQQc6/q7BV+d427UCh+jet7hGIcB7Z0jvDuuppMUcwNGqYxukDZ4EkE0ClNgraGyPlaH4lL6nqv5LluJAV6QIEAm/A1o4p53Xf+fvXrzudIxdxIE40QHwGyHay0l/rKEFVAL/4Zg48URGBKy0b/hUKIwK43L/OOphi7WpKA5HxOixyyU8oV1eKRiv1G/w4AjDl4wgG7JumgEEiBYPoYMG/it5PXgB2T+NDRdq5oAIVQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TWSiKcpC9olHu56uFWzOwH3x3427/sfqh4yeI0ZbqG4=;
 b=aXV+aEewpYumwUXn0r9ukXCAF+tICPz13V6DGWafjp5GNeRvqUk/w0na4of3ll7ZGu1aRyYMxGSFn+3b+xVve/QQ+P/xMjfXEGe3tAIGuqqOpgcRxviF7UxvXPfSb5yHQuhluEr63kgSHjVS3tg1GVf1fIkBN2GHnyQJiqRPbcK8dHiqbtfNfxk63RqeBY+a3RgPaeIu/PnvK4fxYSelo4zGeFSqGDrV00MflZze1lw3/vIM+Gtk8XvsES439fs5HkFDJk5D2DTENeQK5dhUUxuunjuF9jK673FUS4lstFUefqafFhx9qnmAUZIZeV+7Nxn+8dxrPwkm41yPWuS2Hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TWSiKcpC9olHu56uFWzOwH3x3427/sfqh4yeI0ZbqG4=;
 b=h+AcEDCQ4gtNQNHEg+h8AbO9u0lOkkOn6vbgmmq0aIXphdE/WkiZ4Zu5acf+BBS57Aom7m/6qXpnltpfIc3tti8PQ/a3MlJAD+3ZCcshIMmSb8ua0objhb3W0t8eQ3I/73MfOfaixaKsP+t6BiLp2RMy4jKuRHiGHwWuPbQ1zWA=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SN4PR10MB5605.namprd10.prod.outlook.com (2603:10b6:806:208::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Wed, 3 Apr
 2024 13:24:33 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ad12:a809:d789:a25b]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ad12:a809:d789:a25b%4]) with mapi id 15.20.7409.042; Wed, 3 Apr 2024
 13:24:33 +0000
Date: Wed, 3 Apr 2024 09:24:30 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: Cedric Blancher <cedric.blancher@gmail.com>
Cc: linux-nfs@vger.kernel.org
Subject: Re: [PATCH RFC] SUNRPC: Fix a slow server-side memory leak with
 RPC-over-TCP
Message-ID: <Zg1YjvJ3zE+S9B/p@tissot.1015granger.net>
References: <171208672277.1654.1052289246945629541.stgit@klimt.1015granger.net>
 <CALXu0Uet83m1hX05vt9qYO+xmDoPfNYZ+r09y9FJS4H=ahyjwg@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALXu0Uet83m1hX05vt9qYO+xmDoPfNYZ+r09y9FJS4H=ahyjwg@mail.gmail.com>
X-ClientProxiedBy: CH0PR03CA0241.namprd03.prod.outlook.com
 (2603:10b6:610:e5::6) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|SN4PR10MB5605:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	W4Uvn/OiWniB6CoRU9KAX//wyoToeof/FLQIqkUC2BNlKBBPV9APd7eH5oP6F5Q9TvPhMjgw4ha4DS9gGsQC2QCyXdKzd6JT/l1bjzxK4+1M8H90qCvQ7ygbOGlY1Jy+YdJKr8a+ShdD4LxiJDtAfcgh9WihdnzSkJuCNdktaxigfM4P18S0yxjVU82wTsW052wA01jFtww4pa/btCFLeFKn2w5BWCJuYmZu8pXY5fUpvWbD1pmgXq5xWTPZfW+Wrs3yUuXNKLxhSBRCJYX5zjszkCZ0CVFx7QGeLuw1nfYtEQOGvPJhamAsDzFSYEG0F61NFHMGfqD4NXlw9Hs3JNdW0E9BwgONKiouLA4H+/VRlST0UiSUL41A7p71m1c34z0+OBB1EcH7x19OrOu/9TgOsIqR3RlGEeEnck2uvL8u/E5b8pdZOMBnURdJZTay2Brkpkyrpbq/cXLwdpaRQKsW459xWoAXnx2K4AHVbV9YN5NyvhGLHOJwOYN7ATbXCTM/JySLpjTF4ZQ+TuUyARDJdSKWjkCZR4Bjv9nVdRw/Vpsd8hZtlS5LABB+4blqNgbfkR6S3RxzH1PsYaljnpNU/T9C5iQfPp9+gaqC3U4=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?3WrDrxyzsBRJ1dtxhgLEqH80VDvRnfiYSgr8Cp/spO2hE4iT3VVqOuqaKyxH?=
 =?us-ascii?Q?5/zwQSr/wQMcEawitba+Az1520SIBWGiUnFDoLmu3Gn3ycLMMufymdto5vrl?=
 =?us-ascii?Q?0LQMHiomgrwsSU3LLWJLsFHJys6XAFChB526N/AY/wR4QBWAKtwisbl4KI6M?=
 =?us-ascii?Q?84/DTVNarA7J/TVzkmgyU9l6pBcGsaq0WHlVxwYSlTx17ie1kki6jfQwKByA?=
 =?us-ascii?Q?i90ELnY1GUIQkz30z2NqcBp0h2YGUxruPAA2+mj2QkXTePB9beO5uG5nhKrb?=
 =?us-ascii?Q?lBAHtwTgl4kjkx1G5DUnjMA5vzS9cPebymZsKTmfBRtg6OPg/UU8EDaA6EXt?=
 =?us-ascii?Q?p05W50BY84o0zq0w2GBfRmUbTbNEDMr531D+7ICz3lkfnF1gFeQFnBQcQ/pI?=
 =?us-ascii?Q?/v47D8sulWJ1zM6lvFDL1/YYidSa29oKrOiPsz0BSCryzNPupBYckbFpayLF?=
 =?us-ascii?Q?FXTmk1yFIC7M05llMh2qJz0YkjhB/GcGw9CqsF6trMjc7XTmcj31MBib+APN?=
 =?us-ascii?Q?GfezB31Q/AaXGdikjeLX/aM7oJ0poS+/f8DHQBQvKrWEEt3mUvg/tM97K5z9?=
 =?us-ascii?Q?NoPDFOZNzo2P8lnzX16jU9J+4E8D0PTWEH0Fh0dxec/Xd9jK+mp+roglzPj6?=
 =?us-ascii?Q?HXy6RqGreENXbBJ/ly9R7lWaVgHWoCJlMP0roQ4s7sq3M7Ied5C/qF6ojAeD?=
 =?us-ascii?Q?PEBsbLc9W25oTkErjpbbd7C6hH6M7oXpxwHwyC1Af7e19buRt8JMcqYx32sH?=
 =?us-ascii?Q?Tt+icMQvDqnRX+/ji7Ozr4rH0mYtA9rvwRdo+6dsHWWH7/4QLZPXwZxwnykr?=
 =?us-ascii?Q?Sfo3jX6xJHTuRbwm+nrMP8caw5P2XkXxhZXPkCtnTQ9FaDGgQrIgdX3pQZoj?=
 =?us-ascii?Q?5fIX5Wm21ec8rN/HpmrDjdS4GP9VIy+nx6atCVgs1tSodeYdhEiCvnfHw0vA?=
 =?us-ascii?Q?1menGcA/umVsGUyI8RbqX5FhBF1tQCokD18cA839teRIXEf9yTw6PJIcdZFP?=
 =?us-ascii?Q?ERX7YlX/cbEGN1VOhoEoKQwzUfCB+atJLHX0q/LVelrvjRbfafF55t9HOmdC?=
 =?us-ascii?Q?TXcmRE3negLVr10hhK+NO19Kx3vpy26NLUCo8JZ3cBecLiayOvjCvN7mOBFA?=
 =?us-ascii?Q?rllCp6ogK+LghZiBx8fvABAa6deJaGBORXUxVHO/svPL3CCJxE5af1WzyQHC?=
 =?us-ascii?Q?RCsQhknPkFS+93P2B81Rtv0L15jkLsl4JmyVhHEPJfXF+NSUZCcjO3M1YEF9?=
 =?us-ascii?Q?xBw1aCVKLSTsyfmnHsDdKPVSEFw4BGo8AW53ATU6wHPs394qRAx0d+c8KsZQ?=
 =?us-ascii?Q?ZuHszCKOhPM1ov+J4nAkhUjWFyPspS8zk4LnvpOg6yQO7jUf9SKM3AJRZuBD?=
 =?us-ascii?Q?ri24/DP/wEaqO6Piyw6Mm5CynSCXExsjCyjSB8pU9lEXXOv6mhboHEAQ0p0N?=
 =?us-ascii?Q?SKnWbxqH5VmjDa8FwQRGjtXIac7E4X6uGq7setgXAOvqAoimuVVNiltYFKrU?=
 =?us-ascii?Q?5+TD3dYAFjYElA5FgyWLEGp+lU3siCD/X8wmQfur1/XGiyxikBKsWU9YJl5R?=
 =?us-ascii?Q?zgq0h+hDgYgptPh58GYNSz5OS/WVH/TWni0K6X+UfiEGpRmafbFcXZEFENPz?=
 =?us-ascii?Q?uw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	KHJowIP+GFE3R5hU8ApYRc1436TXVl19U0s2ZxaT5h5ordPArgRdWYu4A/AGtFniUk1iMNC4Yf+iLru6t2mR8zKzbPnRw5f5ic86qlpMRJuw3Qlqg6BxlCnTJq3z9AQgXS2MEJBudxvOCXBZKKaknr1fgIPNr9s8qoqiqVYokRTFL9AtrlwimCr092x1F4vrpMBU/hGkpbf56g7UybwY8cnGT8XW8TxAT2owQE87PvrT4MoAsY4tmRo7GPTDIc9CF1/CZFd0zT5QmH0LM0ZKAbz+IlhjC0jtu/ifnzdhVVhJ97EfAH7Zmjyb3P0wRacW3mCW9AVWnDwr+CuWbrXDKh6c15xRzCsMUjH4ScLAArOCKcpunCOcuBU+yPOIK99sv9oCuvGsMyH6vb7WCT/CMCawfvPaepDeSt6AOMPS4yGrPm2atsz9Yy9R8nhoqrqhl2jMtOXXvzBoia4zpvzNcSOLnCW7429bj6zrKQRaeGQNRg74ReGErbNa0j/NGSFWjdRR9eRcKcEiYQEmilUoDs+FGGAkYMd8n/xaNW2DxGaiBCoTU7ZNiLFcT+2zxl/XD1PD9hAROpejaQ+B6j8Ezbf4JXq7N10+7+RvRmihTIg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 101761fc-b775-4515-6549-08dc53e1667d
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2024 13:24:33.4106
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 399Ctka/CVSNi1uo6NcJ50DsQ9oqEkEQm/5wkrg2vansFKOhQnA5PwAxvLtKkeLr6N1cb9A/XOLW1uFCYmeTvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR10MB5605
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-03_12,2024-04-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 phishscore=0 bulkscore=0 spamscore=0 adultscore=0 mlxlogscore=966
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403210000 definitions=main-2404030092
X-Proofpoint-ORIG-GUID: yVq0R4TXgcdiMzkPBonXguOkjg_0E4C6
X-Proofpoint-GUID: yVq0R4TXgcdiMzkPBonXguOkjg_0E4C6

On Wed, Apr 03, 2024 at 07:29:00AM +0200, Cedric Blancher wrote:
> On Tue, 2 Apr 2024 at 21:38, Chuck Lever <cel@kernel.org> wrote:
> >
> > From: Chuck Lever <chuck.lever@oracle.com>
> >
> > Jan Schunk reports that his small NFS servers suffer from memory
> > exhaustion after just a few days. A bisect shows that commit
> > e18e157bb5c8 ("SUNRPC: Send RPC message on TCP with a single
> > sock_sendmsg() call") is the first bad commit.
> >
> > That commit assumed that sock_sendmsg() releases all the pages in
> > the underlying bio_vec array, but the reality is that it doesn't.
> > svc_xprt_release() releases the rqst's response pages, but the
> > record marker page fragment isn't one of those, so it was never
> > released.
> >
> > This is a narrow fix that can be applied to stable kernels. A
> > more extensive fix is in the works.
> >
> > Reported-by: Jan Schunk <scpcom@gmx.de>
> > Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218671
> > Fixes: e18e157bb5c8 ("SUNRPC: Send RPC message on TCP with a single sock_sendmsg() call")
> 
> Is this bug present in 6.6 LTS?

It was introduced in v6.6, so yes.

~/linux $ git describe --contains e18e157bb5c8
v6.6-rc1~108^2~27
~/linux $

Once this fix is merged upstream, the LTS maintainers will notice
the Fixes: tag and backport it to v6.6 automatically.

-- 
Chuck Lever

