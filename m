Return-Path: <linux-nfs+bounces-7722-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD0DB9BF1E4
	for <lists+linux-nfs@lfdr.de>; Wed,  6 Nov 2024 16:41:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BD8A28575A
	for <lists+linux-nfs@lfdr.de>; Wed,  6 Nov 2024 15:41:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9C07202637;
	Wed,  6 Nov 2024 15:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="AnCXwZhI";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="iZmbv+nD"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58038202F8A;
	Wed,  6 Nov 2024 15:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730907669; cv=fail; b=DFxjRP+HdVk/JV6e1JPSC0PMpvPg12ZHIwE5xBo19exhxlguwCqEArPjDpXslyTX7+WiNBx1NRpu7hp4V4lDqljYyAPCbfHnjq74xRhmbmbNnfYdM8NGY7fpRAq+qmv7IuQyrnf/beFZVSsB/+/kVs8wGIbPKMmmIKtLjnQ5lac=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730907669; c=relaxed/simple;
	bh=eRApEx0mAy+geITsC17W/eDRrTay9ZjuT2z3TbelbcQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=i2LmLTfA7eqVt97RceMI0SFQb7PS8oDI54NRAsa0it8O3TUZ72erGAOd0TU7t3qpvC3kSX1ZGgVXzGGPG2EtVL0Kvp1yI+Jn+yYxxmt683k4QhljaYaYztgoG6bRsdJ8oQDq7uDBg8dcvhELoJueML9BQBUGy2FULLhCDZZWOk0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=AnCXwZhI; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=iZmbv+nD; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A6Ci3g6008107;
	Wed, 6 Nov 2024 15:40:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=fC0PLBeYg4yZ7SQyqH
	Eo8Y0MSToV8NdaPM5SWRpzoSM=; b=AnCXwZhIM/r0tX4Eis4P/BzzEmZmx3oNT5
	RxlScLc7cyBHIs6ZqWXFFdYuMTdi2TUo2xVkYwpmst7g8PGCOG8ReH3xFRUMk+t9
	qDP8KQxsuZ+BAGtbDnr9wJvs289RXaWw0X1QtFSH1bpjT56gnqdfudfcfGJ74DnQ
	7+tnDxmO8yBejlegjZmRSP7FuT8/OFbJVaGCijbVtlcFeki3y8vJIgwU7G6HjHar
	S/UbPqwMUgu+HJZztzx1H1vUBCqbjuS0MtcGxvi45HHpD7cU/yVmSdkm9DvEzSKj
	igWTLgOvwBj1idpQO8HlABnHmJ7HAi/VYa1Hw/07vtXKOw0g+K3A==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42nc4c084f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 06 Nov 2024 15:40:54 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4A6FTlir008595;
	Wed, 6 Nov 2024 15:40:53 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2048.outbound.protection.outlook.com [104.47.56.48])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42nah8pad8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 06 Nov 2024 15:40:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vx9FG85xaJgfnS1A1uqyMzvuy26+fvfZtlUoIbIFHhUpCBJLqhkP7lHovAJ0tMFSW7WggoUqIS/MI0T6rwEwvZmpb08yMDP+SaeMEM78px6xMm5lmJs8uvtrlRZdoWzyj1IUXmWqNqWhVthruvoX9wnEllP3IfyVqlx4htaPha+x68hlZn7voIqTgcQ/N0krPFPYK7CshruTVBrpduokInBqkoDWe7er6jvppkJVwbTotmHvQ5k+FEPMz2GNJmqfZh/g75TwXNoThCIJQPTkr8EUIZti+hGSksPx5nvUU9+mw5DoX23P1oozwdfVdQjBP72Mp9xDR0B3ecHGjQMELQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fC0PLBeYg4yZ7SQyqHEo8Y0MSToV8NdaPM5SWRpzoSM=;
 b=jK6CPjVe4KMRldQOIBqQ+mSF0NoQsl/t/faqbH1+43e3QJ2lj4SAJ7kv7iknqZcYxtaqAk7pJRWgR8oWHrgZ+ZJMFIw5ZXcb3R9hQz4iNfYxDUYhuNtSHU+u+D2OFRO7usR0SXKWNYTftFUT8bFD1EKdDv9UkQoINNoEND2N/K5csIGImIl5heVjDrDUyzypuJYhHUUWBx4RmbK6hf7TNLFRzXrceitiSonFFVqUj+1P0F2i/X2xzwfBA1AxwCyQjkCvkvDhuY+lIRO06GujIcq2ZvyXl6d+4lFwNzg94ma0DifllyoTcPclTGruZD0f1KSdLJutfuBqX5fGeniGKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fC0PLBeYg4yZ7SQyqHEo8Y0MSToV8NdaPM5SWRpzoSM=;
 b=iZmbv+nDJlQ1r+1ARET1Kn252Ohyj94zVyKMwGi5DC/1NA/dp+rfHXDdIDbrmAQWz5VbulaGrzul6NbK2tCnNj5zScbUuOfWYDf06zyWEDgkQpI2IdwVMSh3kHSpZwCJT2qPovcep/2G4H9PQkkEuS9+iKeC61KRMJtFd4tKp2U=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SA1PR10MB6493.namprd10.prod.outlook.com (2603:10b6:806:29c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Wed, 6 Nov
 2024 15:40:50 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.8114.031; Wed, 6 Nov 2024
 15:40:49 +0000
Date: Wed, 6 Nov 2024 10:40:46 -0500
From: Chuck Lever <chuck.lever@oracle.com>
To: Jeff Layton <jlayton@kernel.org>
Cc: Neil Brown <neilb@suse.de>, Dai Ngo <Dai.Ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>, Olga Kornievskaia <okorniev@redhat.com>,
        linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] nfsd: allow for up to 32 callback session slots
Message-ID: <ZyuN/nxLfHF94kmM@tissot.1015granger.net>
References: <20241105-bcwide-v4-1-48f52ee0fb0c@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241105-bcwide-v4-1-48f52ee0fb0c@kernel.org>
X-ClientProxiedBy: CH2PR14CA0007.namprd14.prod.outlook.com
 (2603:10b6:610:60::17) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|SA1PR10MB6493:EE_
X-MS-Office365-Filtering-Correlation-Id: 82dbd8e7-ccee-423a-034f-08dcfe7963b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+uagEjCXBMTsVqGVyHhJf8E1Eq1h2EywI+n8fr05wAvG5ZpCWCGqG44dYbee?=
 =?us-ascii?Q?xtily/5uEFtENdoiZHEoa2JiY7QIzrxLMfzrEfvHpl5EuzqdUto0LhXnlr9s?=
 =?us-ascii?Q?jAUP8KruBf+gHsRMqY719jxhRWQL7a5f4l5L5wqvpYO8J5cGN2ho+Z6n4YDC?=
 =?us-ascii?Q?/ag0dUnR6taMavJte9sJWw9nPpqkDY5Tx+Wa+JvSyxAQygkgwyLHtIzT5AnY?=
 =?us-ascii?Q?MG2PiKGAvHVW/oa9D5kNRydfzYs1TKvalBfPljLO7C9Gc4cZrNe5mI6AfMjF?=
 =?us-ascii?Q?QaFLkSZNseh3qazPN5K/nd0+Vd5Q9i5Pnt/dQ1k5md71SBggAP64UQdo8lAl?=
 =?us-ascii?Q?htgDC6eiY8pLzzp9OMursQouImdiF70tACLGd7mHD+IbgzzsuI/N3qNCgZtY?=
 =?us-ascii?Q?T9NgDyotz7Fo2MdijeSAxm6qhvuqXl7eJm75Y48ZCYX8o56qIg9DPXDzFjyu?=
 =?us-ascii?Q?U2IpHg0LphPJo017xwYHCQR98LKdiiWyvk0n4g+c4PqrI5u/0feaJoUg+KmF?=
 =?us-ascii?Q?h19V1HuZ0VLMEsb4SmWBKXe377UbKv4uXYVhHG3MDDF1YVr+651J9Kz7lhlC?=
 =?us-ascii?Q?+yEV5cR/E0GB09zt6FIzBCQTOIDst+0ho/TGCNewvDcfja6xjyMQcUCgLZkg?=
 =?us-ascii?Q?MfAXNzjy72FrdHVMpcAON9KRgvWC9tMVNFqL702z7mOJlrVGCZMssMRreP71?=
 =?us-ascii?Q?EHdogrsMfX1+sqC2im//iTdm3BbNkbhKcDdxrKQeLbiVd6JpPBVGMpFnUgcb?=
 =?us-ascii?Q?FQJuo+eU56+95vW+EpHvzMX9+A+4AcjDD24UPfQNjnjAxb0YV6DV+ITet4E7?=
 =?us-ascii?Q?pTSbW1iOcjYESrn288Ju856ztUj6MWw/96P3Q3dHyoxkBK5O584tzZBSthtS?=
 =?us-ascii?Q?x1YZRSaOLboCazwUNewGFbY1AAKSzp41eF0XjLiYoQ2iTPswW+c6onAn6a3p?=
 =?us-ascii?Q?zAmAgaYFXcNvtQ6gGBIk7ZhFb6ZB59Z/3DuZZuE7M4PtaYhFY48yBjbDkq5x?=
 =?us-ascii?Q?s/L3pnxRqbRiBKjG3IQh34DbVyQQAnCVYgHBgpUc/0M21/EZxLa9sxo+VhSb?=
 =?us-ascii?Q?ggQrEZxZxqRXR1sWaakzh3A/wx5znKY5E1qJ1ey/ZoCkoXMq5FoJ+9bPltfF?=
 =?us-ascii?Q?P2pkYSpqiEgPLKPyCl2ZXnVyWO3wn16Phgkbq0NnlebdWPkr0RiI6fT/faRQ?=
 =?us-ascii?Q?mHT7b/NfeKZMaJf+2K5c30y/DNU1TOfw2GBaquyvEH6bI/UvbvZbMdY3KYOT?=
 =?us-ascii?Q?08fuIcYwuij4ecYalpAQ7YfmT/6O1UubnfynDhf4ffPfnNZzOCU0BhVwz20s?=
 =?us-ascii?Q?vwbWCTJm63oaYdFt/dMJ59rR?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YLMd59RapQ0usk0YX9ARx8E0llijy9mBNp7TyUjaaF5fMrhHK2WHjRPoHni+?=
 =?us-ascii?Q?XJTdHCtZtEXDkoQY0zEh8JAvBE4oha1DDavP9h3IXWSCi0cSESHh0EH/KQyn?=
 =?us-ascii?Q?c5q2hTeeJzda5zWFZBAtvzTJRex+wxRjm5FUpTnyI4MBeF7be65c+0J8/0X0?=
 =?us-ascii?Q?+jnAf/J3nQvuRQnwjVdv1Mvo8ZYJBSdQsmQRgEjFU+6qZ/kbkk/oRsl3hSzP?=
 =?us-ascii?Q?FUcXZJE2IP/2KUlZRylOSoO5m1ldQSmLwLoLan1N5ZxBT7qhRO7tygvcdwWa?=
 =?us-ascii?Q?lOToepwjDtvNQTZQreVsNBCR39R9ePQEZse/k0ycCrPu/wLGgTni6/EcDHyq?=
 =?us-ascii?Q?WBTg5sVtEcwtyNLg/yFSbMbYX/M2yF+Di6zW7OvxPvEiwMXtxAVgDoI5I5w8?=
 =?us-ascii?Q?LDXCIEVRCPgU1UJ3wTlDF78+KLxj8hUcOwH+XkRN8YqcWE73DciL+YnrqCyh?=
 =?us-ascii?Q?RV3xsKnibcymFdk+aMWg1aMoa8HTuLQAjrxrc0cyAycjSKDE6Df/a5q6OJ/i?=
 =?us-ascii?Q?oHZLzAvaqXx91K918e7Z0BLLFNmnO+8HEKLTzlwsCVM9kU44xP4uZPWcHRdW?=
 =?us-ascii?Q?Fgcuv+XR9VibKK/ptS7bcmcxfY4qme5fuhUrH/t6GvYInZAx1VsbkV+8xHE1?=
 =?us-ascii?Q?Nz1ATMZEl7+INlBeyq2eeLrvnXn2DZmGLHGvYpqjXRUn5nQ7Cht5s/1cUp3L?=
 =?us-ascii?Q?/QpG4k4g1tm89A2o3Js7uVtrjqUhcFulTcuS9ydW6wGopHN1DSqB4Pr5A6nq?=
 =?us-ascii?Q?7ZBxrH+XiiQO5BTM4qmQyzw/qm11Uws0DrsbZoWAysLY0uYRM+kOsXHPwIBf?=
 =?us-ascii?Q?FgQElrXkx5QVufQIUvxgsRgnJ65j5CCLJVtHn8jrja8BjKQQPWAwTCyESYvm?=
 =?us-ascii?Q?MsbatpQPfnXhIqkssiBPpYun7T0sseoEIxpOP1Be1DWBG/zYuOUTeKkJVcOW?=
 =?us-ascii?Q?iHYAZmZWOW0+4AtjL7n+HJs7qLb0ecTOXwMC3LFEDCev+tSZzwlJdujBNzCh?=
 =?us-ascii?Q?H83B6fSBM45ZI3kHrOvdpW4bTqabzEqulGJSddjcb1VtaO7CzGkq6/LpR0CS?=
 =?us-ascii?Q?OAPTusqPF8TwS2gHLinmce6l4wcVNo+m+VwNC45AN6T4MgX9dmLip0LlBXFs?=
 =?us-ascii?Q?vdFK1vd9CgecXgyhqvdVFQ5lslTbg3lYylZpBcK+hGJKbpaH2TaBiHM5Lqg1?=
 =?us-ascii?Q?dk38UMGzBwBwhw3TNU9vhCoHR6s8eD4HhIKNiw3Zwh8yVX3C3eqDTTo9Coi4?=
 =?us-ascii?Q?DKNNTs78sC0j5iv/CsK7nkYJS2BInc3MjYJdqr3Sh0NVKfQoo0K6o2Nnj2IB?=
 =?us-ascii?Q?EXmbcusEeW7fon7VtO3dpJa/SGiL0ZONG7fSDkkgwVPkgBMm1hTuwxHVh8yz?=
 =?us-ascii?Q?LnyQv88ZR+UTjXgNP/oCev0tCJNgrFjRPev0DXH3cMaOhV/DJtrLE+PBHbia?=
 =?us-ascii?Q?I2FZmyFdYIlNyWuMxK+Fn1dHhUqEL1LK+3PpIIPUlzh5Cp/mnpUhazL70MCS?=
 =?us-ascii?Q?u00on/KygBPXZBFHiGWXYG4WIVtlz6bpTiDzFyEinwMr/sLf5qeuHNLlr6TR?=
 =?us-ascii?Q?iRT7bPccHaG1K6zbUgEtOr2Z+K2zLMYLfxj/xKYXyL3mKi4309tahHrEMSpb?=
 =?us-ascii?Q?aQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	BU7yKpIzZf42xyP4BSOtN3Bk/SxJibJl1RyXap45WiniZBPDSt0q1iyImBiQuPA1rwnJTL8NRIqTQOYVbzVFteZ0RyMU8rnWdgcwk98+elUFdf6NA+kJt8j5GzYZJqn1ox4Pbyk+LOgvQSLHEpR7Emfb66AG77KHdYCtQ+yhnWS2Dc/xJKSFUtiZbQ0GZpanJKzS3YbFmrS55x7cOTFliE0hv7b+T86WLDp/YuZos1gMF9VvvdeIJSqK6nyodvY1a74aPCyE9LznRbWgBSc9CVyxNxswPH3Ai1UzV1OTt/2XJwXYhEId/H2rJauLpnJUY1g7Sv1YGfvFMfGnVjeSceQQ5Tdzhj/FlxHIguCsIFmSbUSr5YDrrTaoTUaTTtB+Noofzg6JLQpyh1B8h2R+z9ElM/PkjYeCwiN6qSJng+m+KMb3RbblG93OfTw9p1zZYeD9UggIEF/UhJD/bFg5/PfYueeqqq+Njlo8hFqnjDYAUtzZojCBJcY/X1cAsvPsuvBXwh0TDdNfIkXDB4kRkmgrZZtvh9Xro1XkI1xrRE3QmCz1jD5zLG8J1DTtx75oGZq9j5+l3EFlHFKD0eYiTZNJNrSd8wGCZQQ2Dx/Hs6U=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82dbd8e7-ccee-423a-034f-08dcfe7963b7
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2024 15:40:49.9007
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AVZb39n92kd0q+McryOkKyHcE9fp2RUyewqtH25VsZBRsrhpqJTnTGtoimVi1nuBDiqW1rppFH+mczZOIMkoIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6493
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-06_09,2024-11-06_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0 spamscore=0
 adultscore=0 phishscore=0 suspectscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411060122
X-Proofpoint-ORIG-GUID: U0omOvxcrB4ArkgVdaXaXpDIcf_Cz6x4
X-Proofpoint-GUID: U0omOvxcrB4ArkgVdaXaXpDIcf_Cz6x4

On Tue, Nov 05, 2024 at 07:31:06PM -0500, Jeff Layton wrote:
> nfsd currently only uses a single slot in the callback channel, which is
> proving to be a bottleneck in some cases. Widen the callback channel to
> a max of 32 slots (subject to the client's target_maxreqs value).
> 
> Change the cb_holds_slot boolean to an integer that tracks the current
> slot number (with -1 meaning "unassigned").  Move the callback slot
> tracking info into the session. Add a new u32 that acts as a bitmap to
> track which slots are in use, and a u32 to track the latest callback
> target_slotid that the client reports. To protect the new fields, add
> a new per-session spinlock (the se_lock). Fix nfsd41_cb_get_slot to always
> search for the lowest slotid (using ffs()).
> 
> Finally, convert the session->se_cb_seq_nr field into an array of
> counters and add the necessary handling to ensure that the seqids get
> reset at the appropriate times.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
> v3 has a bug that Olga hit in testing. This version should fix the wait
> when the slot table is full. Olga, if you're able to test this one, it
> would be much appreciated.

Note: I've replaced v3 in nfsd-next with this version. Thanks for
the update!


> ---
> Changes in v4:
> - Fix the wait for a slot in nfsd41_cb_get_slot()
> - Link to v3: https://lore.kernel.org/r/20241030-bcwide-v3-0-c2df49a26c45@kernel.org
> 
> Changes in v3:
> - add patch to convert se_flags to single se_dead bool
> - fix off-by-one bug in handling of NFSD_BC_SLOT_TABLE_MAX
> - don't reject target highest slot value of 0
> - Link to v2: https://lore.kernel.org/r/20241029-bcwide-v2-1-e9010b6ef55d@kernel.org
> 
> Changes in v2:
> - take cl_lock when fetching fields from session to be encoded
> - use fls() instead of bespoke highest_unset_index()
> - rename variables in several functions with more descriptive names
> - clamp limit of for loop in update_cb_slot_table()
> - re-add missing rpc_wake_up_queued_task() call
> - fix slotid check in decode_cb_sequence4resok()
> - add new per-session spinlock
> ---
>  fs/nfsd/nfs4callback.c | 113 ++++++++++++++++++++++++++++++++++++-------------
>  fs/nfsd/nfs4state.c    |  11 +++--
>  fs/nfsd/state.h        |  15 ++++---
>  fs/nfsd/trace.h        |   2 +-
>  4 files changed, 101 insertions(+), 40 deletions(-)
> 
> diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
> index e38fa834b3d91333acf1425eb14c644e5d5f2601..47a678333907eaa92db305dada503704c34c15b2 100644
> --- a/fs/nfsd/nfs4callback.c
> +++ b/fs/nfsd/nfs4callback.c
> @@ -406,6 +406,19 @@ encode_cb_getattr4args(struct xdr_stream *xdr, struct nfs4_cb_compound_hdr *hdr,
>  	hdr->nops++;
>  }
>  
> +static u32 highest_slotid(struct nfsd4_session *ses)
> +{
> +	u32 idx;
> +
> +	spin_lock(&ses->se_lock);
> +	idx = fls(~ses->se_cb_slot_avail);
> +	if (idx > 0)
> +		--idx;
> +	idx = max(idx, ses->se_cb_highest_slot);
> +	spin_unlock(&ses->se_lock);
> +	return idx;
> +}
> +
>  /*
>   * CB_SEQUENCE4args
>   *
> @@ -432,15 +445,35 @@ static void encode_cb_sequence4args(struct xdr_stream *xdr,
>  	encode_sessionid4(xdr, session);
>  
>  	p = xdr_reserve_space(xdr, 4 + 4 + 4 + 4 + 4);
> -	*p++ = cpu_to_be32(session->se_cb_seq_nr);	/* csa_sequenceid */
> -	*p++ = xdr_zero;			/* csa_slotid */
> -	*p++ = xdr_zero;			/* csa_highest_slotid */
> +	*p++ = cpu_to_be32(session->se_cb_seq_nr[cb->cb_held_slot]);	/* csa_sequenceid */
> +	*p++ = cpu_to_be32(cb->cb_held_slot);		/* csa_slotid */
> +	*p++ = cpu_to_be32(highest_slotid(session)); /* csa_highest_slotid */
>  	*p++ = xdr_zero;			/* csa_cachethis */
>  	xdr_encode_empty_array(p);		/* csa_referring_call_lists */
>  
>  	hdr->nops++;
>  }
>  
> +static void update_cb_slot_table(struct nfsd4_session *ses, u32 target)
> +{
> +	/* No need to do anything if nothing changed */
> +	if (likely(target == READ_ONCE(ses->se_cb_highest_slot)))
> +		return;
> +
> +	spin_lock(&ses->se_lock);
> +	if (target > ses->se_cb_highest_slot) {
> +		int i;
> +
> +		target = min(target, NFSD_BC_SLOT_TABLE_MAX);
> +
> +		/* Growing the slot table. Reset any new sequences to 1 */
> +		for (i = ses->se_cb_highest_slot + 1; i <= target; ++i)
> +			ses->se_cb_seq_nr[i] = 1;
> +	}
> +	ses->se_cb_highest_slot = target;
> +	spin_unlock(&ses->se_lock);
> +}
> +
>  /*
>   * CB_SEQUENCE4resok
>   *
> @@ -468,7 +501,7 @@ static int decode_cb_sequence4resok(struct xdr_stream *xdr,
>  	struct nfsd4_session *session = cb->cb_clp->cl_cb_session;
>  	int status = -ESERVERFAULT;
>  	__be32 *p;
> -	u32 dummy;
> +	u32 seqid, slotid, target;
>  
>  	/*
>  	 * If the server returns different values for sessionID, slotID or
> @@ -484,21 +517,22 @@ static int decode_cb_sequence4resok(struct xdr_stream *xdr,
>  	}
>  	p += XDR_QUADLEN(NFS4_MAX_SESSIONID_LEN);
>  
> -	dummy = be32_to_cpup(p++);
> -	if (dummy != session->se_cb_seq_nr) {
> +	seqid = be32_to_cpup(p++);
> +	if (seqid != session->se_cb_seq_nr[cb->cb_held_slot]) {
>  		dprintk("NFS: %s Invalid sequence number\n", __func__);
>  		goto out;
>  	}
>  
> -	dummy = be32_to_cpup(p++);
> -	if (dummy != 0) {
> +	slotid = be32_to_cpup(p++);
> +	if (slotid != cb->cb_held_slot) {
>  		dprintk("NFS: %s Invalid slotid\n", __func__);
>  		goto out;
>  	}
>  
> -	/*
> -	 * FIXME: process highest slotid and target highest slotid
> -	 */
> +	p++; // ignore current highest slot value
> +
> +	target = be32_to_cpup(p++);
> +	update_cb_slot_table(session, target);
>  	status = 0;
>  out:
>  	cb->cb_seq_status = status;
> @@ -1203,6 +1237,22 @@ void nfsd4_change_callback(struct nfs4_client *clp, struct nfs4_cb_conn *conn)
>  	spin_unlock(&clp->cl_lock);
>  }
>  
> +static int grab_slot(struct nfsd4_session *ses)
> +{
> +	int idx;
> +
> +	spin_lock(&ses->se_lock);
> +	idx = ffs(ses->se_cb_slot_avail) - 1;
> +	if (idx < 0 || idx > ses->se_cb_highest_slot) {
> +		spin_unlock(&ses->se_lock);
> +		return -1;
> +	}
> +	/* clear the bit for the slot */
> +	ses->se_cb_slot_avail &= ~BIT(idx);
> +	spin_unlock(&ses->se_lock);
> +	return idx;
> +}
> +
>  /*
>   * There's currently a single callback channel slot.
>   * If the slot is available, then mark it busy.  Otherwise, set the
> @@ -1211,28 +1261,32 @@ void nfsd4_change_callback(struct nfs4_client *clp, struct nfs4_cb_conn *conn)
>  static bool nfsd41_cb_get_slot(struct nfsd4_callback *cb, struct rpc_task *task)
>  {
>  	struct nfs4_client *clp = cb->cb_clp;
> +	struct nfsd4_session *ses = clp->cl_cb_session;
>  
> -	if (!cb->cb_holds_slot &&
> -	    test_and_set_bit(0, &clp->cl_cb_slot_busy) != 0) {
> +	if (cb->cb_held_slot >= 0)
> +		return true;
> +	cb->cb_held_slot = grab_slot(ses);
> +	if (cb->cb_held_slot < 0) {
>  		rpc_sleep_on(&clp->cl_cb_waitq, task, NULL);
>  		/* Race breaker */
> -		if (test_and_set_bit(0, &clp->cl_cb_slot_busy) != 0) {
> -			dprintk("%s slot is busy\n", __func__);
> +		cb->cb_held_slot = grab_slot(ses);
> +		if (cb->cb_held_slot < 0)
>  			return false;
> -		}
>  		rpc_wake_up_queued_task(&clp->cl_cb_waitq, task);
>  	}
> -	cb->cb_holds_slot = true;
>  	return true;
>  }
>  
>  static void nfsd41_cb_release_slot(struct nfsd4_callback *cb)
>  {
>  	struct nfs4_client *clp = cb->cb_clp;
> +	struct nfsd4_session *ses = clp->cl_cb_session;
>  
> -	if (cb->cb_holds_slot) {
> -		cb->cb_holds_slot = false;
> -		clear_bit(0, &clp->cl_cb_slot_busy);
> +	if (cb->cb_held_slot >= 0) {
> +		spin_lock(&ses->se_lock);
> +		ses->se_cb_slot_avail |= BIT(cb->cb_held_slot);
> +		spin_unlock(&ses->se_lock);
> +		cb->cb_held_slot = -1;
>  		rpc_wake_up_next(&clp->cl_cb_waitq);
>  	}
>  }
> @@ -1249,8 +1303,8 @@ static void nfsd41_destroy_cb(struct nfsd4_callback *cb)
>  }
>  
>  /*
> - * TODO: cb_sequence should support referring call lists, cachethis, multiple
> - * slots, and mark callback channel down on communication errors.
> + * TODO: cb_sequence should support referring call lists, cachethis,
> + * and mark callback channel down on communication errors.
>   */
>  static void nfsd4_cb_prepare(struct rpc_task *task, void *calldata)
>  {
> @@ -1292,7 +1346,7 @@ static bool nfsd4_cb_sequence_done(struct rpc_task *task, struct nfsd4_callback
>  		return true;
>  	}
>  
> -	if (!cb->cb_holds_slot)
> +	if (cb->cb_held_slot < 0)
>  		goto need_restart;
>  
>  	/* This is the operation status code for CB_SEQUENCE */
> @@ -1306,10 +1360,10 @@ static bool nfsd4_cb_sequence_done(struct rpc_task *task, struct nfsd4_callback
>  		 * If CB_SEQUENCE returns an error, then the state of the slot
>  		 * (sequence ID, cached reply) MUST NOT change.
>  		 */
> -		++session->se_cb_seq_nr;
> +		++session->se_cb_seq_nr[cb->cb_held_slot];
>  		break;
>  	case -ESERVERFAULT:
> -		++session->se_cb_seq_nr;
> +		++session->se_cb_seq_nr[cb->cb_held_slot];
>  		nfsd4_mark_cb_fault(cb->cb_clp);
>  		ret = false;
>  		break;
> @@ -1335,17 +1389,16 @@ static bool nfsd4_cb_sequence_done(struct rpc_task *task, struct nfsd4_callback
>  	case -NFS4ERR_BADSLOT:
>  		goto retry_nowait;
>  	case -NFS4ERR_SEQ_MISORDERED:
> -		if (session->se_cb_seq_nr != 1) {
> -			session->se_cb_seq_nr = 1;
> +		if (session->se_cb_seq_nr[cb->cb_held_slot] != 1) {
> +			session->se_cb_seq_nr[cb->cb_held_slot] = 1;
>  			goto retry_nowait;
>  		}
>  		break;
>  	default:
>  		nfsd4_mark_cb_fault(cb->cb_clp);
>  	}
> -	nfsd41_cb_release_slot(cb);
> -
>  	trace_nfsd_cb_free_slot(task, cb);
> +	nfsd41_cb_release_slot(cb);
>  
>  	if (RPC_SIGNALLED(task))
>  		goto need_restart;
> @@ -1565,7 +1618,7 @@ void nfsd4_init_cb(struct nfsd4_callback *cb, struct nfs4_client *clp,
>  	INIT_WORK(&cb->cb_work, nfsd4_run_cb_work);
>  	cb->cb_status = 0;
>  	cb->cb_need_restart = false;
> -	cb->cb_holds_slot = false;
> +	cb->cb_held_slot = -1;
>  }
>  
>  /**
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index baf7994131fe1b0a4715174ba943fd2a9882aa12..75557e7cc9265517f51952563beaa4cfe8adcc3f 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -2002,6 +2002,9 @@ static struct nfsd4_session *alloc_session(struct nfsd4_channel_attrs *fattrs,
>  	}
>  
>  	memcpy(&new->se_fchannel, fattrs, sizeof(struct nfsd4_channel_attrs));
> +	new->se_cb_slot_avail = ~0U;
> +	new->se_cb_highest_slot = battrs->maxreqs - 1;
> +	spin_lock_init(&new->se_lock);
>  	return new;
>  out_free:
>  	while (i--)
> @@ -2132,11 +2135,14 @@ static void init_session(struct svc_rqst *rqstp, struct nfsd4_session *new, stru
>  
>  	INIT_LIST_HEAD(&new->se_conns);
>  
> -	new->se_cb_seq_nr = 1;
> +	atomic_set(&new->se_ref, 0);
>  	new->se_dead = false;
>  	new->se_cb_prog = cses->callback_prog;
>  	new->se_cb_sec = cses->cb_sec;
> -	atomic_set(&new->se_ref, 0);
> +
> +	for (idx = 0; idx < NFSD_BC_SLOT_TABLE_MAX; ++idx)
> +		new->se_cb_seq_nr[idx] = 1;
> +
>  	idx = hash_sessionid(&new->se_sessionid);
>  	list_add(&new->se_hash, &nn->sessionid_hashtbl[idx]);
>  	spin_lock(&clp->cl_lock);
> @@ -3159,7 +3165,6 @@ static struct nfs4_client *create_client(struct xdr_netobj name,
>  	kref_init(&clp->cl_nfsdfs.cl_ref);
>  	nfsd4_init_cb(&clp->cl_cb_null, clp, NULL, NFSPROC4_CLNT_CB_NULL);
>  	clp->cl_time = ktime_get_boottime_seconds();
> -	clear_bit(0, &clp->cl_cb_slot_busy);
>  	copy_verf(clp, verf);
>  	memcpy(&clp->cl_addr, sa, sizeof(struct sockaddr_storage));
>  	clp->cl_cb_session = NULL;
> diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
> index d22e4f2c9039324a0953a9e15a3c255fb8ee1a44..848d023cb308f0b69916c4ee34b09075708f0de3 100644
> --- a/fs/nfsd/state.h
> +++ b/fs/nfsd/state.h
> @@ -71,8 +71,8 @@ struct nfsd4_callback {
>  	struct work_struct cb_work;
>  	int cb_seq_status;
>  	int cb_status;
> +	int cb_held_slot;
>  	bool cb_need_restart;
> -	bool cb_holds_slot;
>  };
>  
>  struct nfsd4_callback_ops {
> @@ -307,6 +307,9 @@ struct nfsd4_conn {
>  	unsigned char cn_flags;
>  };
>  
> +/* Highest slot index that nfsd implements in NFSv4.1+ backchannel */
> +#define NFSD_BC_SLOT_TABLE_MAX	(sizeof(u32) * 8 - 1)
> +
>  /*
>   * Representation of a v4.1+ session. These are refcounted in a similar fashion
>   * to the nfs4_client. References are only taken when the server is actively
> @@ -314,6 +317,10 @@ struct nfsd4_conn {
>   */
>  struct nfsd4_session {
>  	atomic_t		se_ref;
> +	spinlock_t		se_lock;
> +	u32			se_cb_slot_avail; /* bitmap of available slots */
> +	u32			se_cb_highest_slot;	/* highest slot client wants */
> +	u32			se_cb_prog;
>  	bool			se_dead;
>  	struct list_head	se_hash;	/* hash by sessionid */
>  	struct list_head	se_perclnt;
> @@ -322,8 +329,7 @@ struct nfsd4_session {
>  	struct nfsd4_channel_attrs se_fchannel;
>  	struct nfsd4_cb_sec	se_cb_sec;
>  	struct list_head	se_conns;
> -	u32			se_cb_prog;
> -	u32			se_cb_seq_nr;
> +	u32			se_cb_seq_nr[NFSD_BC_SLOT_TABLE_MAX + 1];
>  	struct nfsd4_slot	*se_slots[];	/* forward channel slots */
>  };
>  
> @@ -457,9 +463,6 @@ struct nfs4_client {
>  	 */
>  	struct dentry		*cl_nfsd_info_dentry;
>  
> -	/* for nfs41 callbacks */
> -	/* We currently support a single back channel with a single slot */
> -	unsigned long		cl_cb_slot_busy;
>  	struct rpc_wait_queue	cl_cb_waitq;	/* backchannel callers may */
>  						/* wait here for slots */
>  	struct net		*net;
> diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
> index f318898cfc31614b5a84a4867e18c2b3a07122c9..a9c17186b6892f1df8d7f7b90e250c2913ab23fe 100644
> --- a/fs/nfsd/trace.h
> +++ b/fs/nfsd/trace.h
> @@ -1697,7 +1697,7 @@ TRACE_EVENT(nfsd_cb_free_slot,
>  		__entry->cl_id = sid->clientid.cl_id;
>  		__entry->seqno = sid->sequence;
>  		__entry->reserved = sid->reserved;
> -		__entry->slot_seqno = session->se_cb_seq_nr;
> +		__entry->slot_seqno = session->se_cb_seq_nr[cb->cb_held_slot];
>  	),
>  	TP_printk(SUNRPC_TRACE_TASK_SPECIFIER
>  		" sessionid=%08x:%08x:%08x:%08x new slot seqno=%u",
> 
> ---
> base-commit: 3c16aac09d20f9005fbb0e737b3ec520bbb5badd
> change-id: 20241025-bcwide-6bd7e4b63db2
> 
> Best regards,
> -- 
> Jeff Layton <jlayton@kernel.org>
> 

-- 
Chuck Lever

