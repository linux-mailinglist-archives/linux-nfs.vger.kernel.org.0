Return-Path: <linux-nfs+bounces-1574-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C632B8410B8
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Jan 2024 18:31:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A6FE1F24941
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Jan 2024 17:31:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E9C53F9DA;
	Mon, 29 Jan 2024 17:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="AO8f8sXs";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="XmZn6RJe"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 199323F9D8;
	Mon, 29 Jan 2024 17:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706549196; cv=fail; b=dPeOpGmgfMKGOR73gaE+OoSo3WtRxXwEZRKajtTOHS+a9d5ABhH4/Z4UxGPlXbyMC+flqIiEeo3MVNiOUqHzy6Pp1gwjvsKrdG0fsrcUYXfqazJHHXsYP7sAJZuHefDBhOlbHzDe1zZXdKEdIfMeQZN+WdqRIWmt6PESiKYT8A4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706549196; c=relaxed/simple;
	bh=Vr/9Q4+O0nY76FSehOcAoetnI8JnD04BW85qCCyBHXQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=NNkHgVXwZbk5zhFn67FQmqSQ+T+dsAsXnzo6RorSRKi8m041afYsUomokMaFHpuPaMmiNULKmGSumpkWcvbNMwzweAag4pFQvjRW3X1MsIoRU6Hfa+rpgrRe8pXBQND06xoWU0NWBoHZjBW65ZTnFPYETw0o4gi5WJfsEPbDzyA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=AO8f8sXs; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=XmZn6RJe; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40TGnBxo001214;
	Mon, 29 Jan 2024 17:26:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-11-20;
 bh=iKmf0dt+FV68bnlcgRC3yfoihqekQaCutSPmSdPDem4=;
 b=AO8f8sXs34DHjjyaD49iA807IaQFu53Byi9LRJpeFyMuaURHqcqH//1sAhb57EhYkMUa
 9G5WwMTMFGoa/P1J6ReCsm5FWq00PBkFP/EYehBbK20vvcHiHJQszJ/obN4aH+yI5Dsp
 BqW0dlRqHSYTdgproIiQYAv6QdGsuQH0xRJf5WWRotnOKLqBvbZasE8ud/4cxFJYMAnL
 YWdzxlt3uUFL+4d9B8/tLurqCwV7DCOBgvMXJRsTJDPQonl0S+EIqoTY+P9sruN9XE4h
 h2ePhCXeM0ro8tgQUozKt8N7zSwh9LZTPBCIKEPcrSApQqxYtcUBpjEPvViUGbdfXK+X Bw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vvsqaveth-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Jan 2024 17:26:20 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40TGKOtr014562;
	Mon, 29 Jan 2024 17:26:20 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2040.outbound.protection.outlook.com [104.47.57.40])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3vvr95xgsw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Jan 2024 17:26:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bfOLtZRu3CXwgsmj8bKLgsjK7a/aYbNb8ql1B7pRZRJRA1JYb3i/hKNahEK3GPVNrkdApW0AwEUbJTyTCqU9lcU7dUux3Tmd/eFFwks+/OSjCJzQ8tnj++cGXf/52SVGGmlsLBRbPlqzYzl9KfCfOWPqhSY3Ld41aCQqWlr2HiCoqcUcP0wNQVEKlRfJP32oGtiYPVNiWT55Afa0p8B4315rn7X/rVZceiBd24YyBDCHSROD9xEfFBW0veci7DZecnuVWBQSOz0MvclaEjPbzM0Sz3sTA7YcNg8Ml0fR3aTZLRFMKeXtfxsBuvl5fdOkB5B7vaRRrkDohcCuQQS7oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iKmf0dt+FV68bnlcgRC3yfoihqekQaCutSPmSdPDem4=;
 b=dxFEq/5BJrT8FsB8A/jx4Z0rVMjqn50+fL5KyOOR6Op6fUAYp4a5j5Oj/zyl0T3YsMs4gCZygr1gHM6jAgkTpqZBJE0Ae7OPSIoob/15KttKGBAJNFX462CJv9PHO4PmcQz+BIwexsPJYDWqs6TSztKSEpqrBUYRD7ZqvehpQilYiXrGazkl83PujaeXFVg72KxtfgLcln+OSNVDf6QwCAmA5lZs51L9+CRmufbB5FnuflgdALWDfm0yT8zlp8jIoPiZ1iFO65m0j1Um5HxOk1NtSNZsllY9EZ7+q4knCgsWUdZV5guKvSl3R/5KoVWlodBz3uy+Rk7Y3Eeac1YMfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iKmf0dt+FV68bnlcgRC3yfoihqekQaCutSPmSdPDem4=;
 b=XmZn6RJeSRFux0++V0iu6/APfKDEmHAPHiUfw4GqItCmRO9i4VYn1yFBjlmjTjyagJRKouomhdw/yQTJx5sUcHmjf9M+mtidL1C7xz5hnl++H1tQo0qAUVy+JP3QAyJfEGlEsj61oBHldbqpt8jGUFJnevMWnq7TIp9hImpx9uY=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CY5PR10MB5985.namprd10.prod.outlook.com (2603:10b6:930:2b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34; Mon, 29 Jan
 2024 17:26:17 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ed:9f6b:7944:a2fa]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ed:9f6b:7944:a2fa%6]) with mapi id 15.20.7228.029; Mon, 29 Jan 2024
 17:26:17 +0000
Date: Mon, 29 Jan 2024 12:26:14 -0500
From: Chuck Lever <chuck.lever@oracle.com>
To: Chuck Lever <cel@kernel.org>
Cc: linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH v1 02/11] svcrdma: Use all allocated Send Queue entries
Message-ID: <ZbffthImvL3YspVT@tissot.1015granger.net>
References: <170653967395.24162.4661804176845293777.stgit@manet.1015granger.net>
 <170653984365.24162.652127313173673494.stgit@manet.1015granger.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <170653984365.24162.652127313173673494.stgit@manet.1015granger.net>
X-ClientProxiedBy: CH3P221CA0024.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:610:1e7::33) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|CY5PR10MB5985:EE_
X-MS-Office365-Filtering-Correlation-Id: ace2e084-f08b-44d7-0ebe-08dc20ef6687
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	bax8T5Gr9+zQ6d595AwZuUJf0ub8EWeCadBCcxiFCbpq9pkvKW4fF1Btu556nGoUUazsnjaxyuDsw+0r1oRMncG5z7gl9utvfT3K9TZQyiO24bwF/5xRzk3uEGblOhUROEJtboaJwuADnKuLIfx0NxU1dsgh0l0enP6VadZpmS7MX+OmApsvbQPbaWsdbu2ZW8GJUoQMr/4YmosyLZ53pKYJfeWp4gjfKCg4AbHCYc+vkMoZS0Lzwr5PPKipo1I8p+lLXRebtjtWbt2twPVX1nzR8VtfG0btXS0OUJz157fG/vLO2de+V++UK0duvJDpooja5V08EY2VJTNjuKeCzi79lHtvLK8sbVG0kMfIP2mImqQ3Fn3Awinc6+9pjAuY40uOMjpFECQN3ZyRugMZkmRhK1VoWulhd7nJBWdNix1Tt8zGs8GudL9JTrUyFRFHG53zXTOr702dZS1iuGm4nVm4xl+frjHxSy2y1JmiNi8W1OE77+xXRN6qgC3uBsDLyyhuGkKCe+12zfIUvhBpj6K4d/szLTUeCFLuiAgvF0q0JjEmnvJlUc74Lu61YzmM
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(39860400002)(136003)(396003)(366004)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(6916009)(316002)(8936002)(66946007)(8676002)(66476007)(66556008)(4326008)(26005)(83380400001)(478600001)(6666004)(38100700002)(86362001)(44832011)(5660300002)(2906002)(6486002)(6506007)(6512007)(9686003)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?BsvTYjFj27U3rxfWw+qf+J5eVP7TUbqmBvqBuArZ7H17acX05Fb975OmUJsV?=
 =?us-ascii?Q?jah7MqSjD0gi1zyMfjCSx9rhhDaqPA63KZCJGi8eOexB+9Ugi/M0kfKiwt1p?=
 =?us-ascii?Q?CewR5TACuzhYKpOMoRU8hCchVuqUwwwprbaTEQsJUwbHEZkWZ434k49DhyBl?=
 =?us-ascii?Q?uFlzsrXapNFcOWdeKtwPr68n5EPIZjh23bVQ9aY2awkdTbvguO6+qADUBVUb?=
 =?us-ascii?Q?kGhk2juaGmXO6vFI++UKeWlj5KZFqrnkv4GkNeLxKgVezdLrfoV9PYXAJ6aw?=
 =?us-ascii?Q?G4BaZ3Z+lwnePSX+KsuNRCn0rKLQmUNBwYlYMWa+oUe8NzXfxOam+VoJamJh?=
 =?us-ascii?Q?RFd/HC6HQBSJoT1k2dzCfPu6GfOxToACI20e5lLbe15R0hIal0bmemJjLlQu?=
 =?us-ascii?Q?I+vCW54yTJoJnBFAgHHxy7WZUcM3btGiPkuy5vnHMj5LFqkipFSOIgfKZ4U5?=
 =?us-ascii?Q?oiBBA401FINwIgrNKhi3kQUIEEHPgkKBKbjsl1hlBhyrlR8w3I9IqNwUJH30?=
 =?us-ascii?Q?d8qIm7TZvd9htwx5ql913TqPPHg7MxujoBLMMDMpWIvlwAQom+DoVh9y9IQo?=
 =?us-ascii?Q?E+oX4rm88OUhzg76kU52jE6JDLLNSPkBlgwPJcoPVc7gD2gmOqfbzHj8PUYc?=
 =?us-ascii?Q?+WkXRhMTO4y9gpLkDBuuaWmi2tQWrPECcJqTkb4xiEwaDJWPL0ke1RSHPKQo?=
 =?us-ascii?Q?QZLcGemsAC1EFs4KShIB8NWSw/eU+g5i2dgVVEsSD8/FeUEQzPzLBb2x1Bac?=
 =?us-ascii?Q?XgyEcq7eVAsTVC+CiHP4AkWzEU/LXVRz8OAJtCQtHmXYFyPqD+zxbTZgxKH+?=
 =?us-ascii?Q?vfIiZQuWsuGv05mNqert3mb4wqOnsm4LRETIVOuXeXQBd/kruulJ1zhnBSpf?=
 =?us-ascii?Q?VDPAsM/BTlyYBsxHekkgQUrczk2ia4yQx8XU2PpZfN5uCsfpMHP9YIC57I7E?=
 =?us-ascii?Q?LI2r0NLRUWWqEaim5URVeTP8dfOiYzR7q5IWa5CXyr25t0lndPYXR9iyeX+A?=
 =?us-ascii?Q?OdB6qK0c5YMe0e7XDa6X/w1UWVjimfNGEWtonZVi4GRVEdttte4foxYj3+ll?=
 =?us-ascii?Q?5pw+NNtLpbkQ4EKL9S/BCXI9qSOLwrXo+MR2mM6mY911dm0yqCiAeF4cxxc0?=
 =?us-ascii?Q?aVDt5BWkFYqEShd8KR7Tj+ZEZb4cwM/I8dbBoQoOZ/BM4obamAMEqEZ0PoDZ?=
 =?us-ascii?Q?mbwoNe919Z3ThjdmkjGCxtQKyf8b4rlynb26Neomw4CHwO8sA0cVvrCJIlt/?=
 =?us-ascii?Q?0Pem/VlcVzy1dsmD/LMwjxwLM+m512CtHR2LJ+wnKPHC6KUe5qMlu8u7r1Zd?=
 =?us-ascii?Q?ZaxvwNPfk7V3MJg+k7KkDxPH8rN4ad63FSHMfI3wH6RXVoYglixqY8Ovg0db?=
 =?us-ascii?Q?OIUv3s/Jb8gG1gtQYniix5oiSAcEdbE5MwK3DQ9DvRg3Y5HpP/Jt3me6+MI/?=
 =?us-ascii?Q?sLHTJfVgS5uIzllz6W0qRApV3qYvRO/uNWjd/J+OLNVl3eQzOIT95NhirQdN?=
 =?us-ascii?Q?8PfeCutVhwoB1Sdb/LQyu5s2QE7FhAPlZ9Q2YF2aqa3MkllaS0s9PFz2gZ8n?=
 =?us-ascii?Q?VlQPZzCv+sJObgBfsYW9IVtITzhmGk78SuRi1WRaggcJCaOqg4i5ajbKxs2p?=
 =?us-ascii?Q?lw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	UUarHrJ4s0clhB4krj/NI7jYYCymt6D+iHbLM3pO1NNKRGlUfc8+ebYUd0N8kxVHzbK3cwXtSx44xpZ/sjTmnDGNVuzv9R2LuArv2dHgzh9AnA0ADPAvlD1/OW1MZa/5SfiD93Qo5azP6vaiNd3Iv0UmbRfQVdNHk+zky2U6UwU8Cp5IogplqVQagI2vpaXQVJgwzgeVPcWO/BDgTyxTjJS7H8y1G7mDCf3FZ3KpW161tqDq/pLvnCk6SDA4qUCqq5xLUd8KlRNWht8UBpqHyeRS8tNX4TbEsLkPdqeHrqfoTySdoKljAJC8fhg6L9hUdgR3iKgq0VNX8JLQYj/BYwrNOAdsY8+9J36M9YouTEOitltswbzcTZnbF8Fwp03lE82hISDfN7d3Zbj51yjgb5sP9zMnArRsXsXq4m1NwcnSnjO4NfGvGWAKrK1ewmMRVnfGzuTFJaxkVsghndwU+3MNiwLHbjFBx4FqpWuo5e5d6qVi6S2LqWFUj10GVmGFq8n1IKz1MALRpzbSCuh/WwpDUc1JMps65f1WNBR7osAZREtwOMv5nh81fBVKGx7RAGLXjZBVEyVdvQN000SdDH7lZ1On+fiCgeKsTYwZNHk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ace2e084-f08b-44d7-0ebe-08dc20ef6687
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2024 17:26:17.0914
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iBYyvD67Vw24ca+0N+tSgFPWGE4NCcGDKQ2FS56321W8Oe0SkvhyBiMMdImu4Wsaz7rTHpHJn/vsq+S9pPJutg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB5985
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-29_10,2024-01-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 malwarescore=0
 suspectscore=0 phishscore=0 mlxscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401290128
X-Proofpoint-GUID: upAF-4wF2MttkN6ZqL7GaoPjumUeAXPH
X-Proofpoint-ORIG-GUID: upAF-4wF2MttkN6ZqL7GaoPjumUeAXPH

On Mon, Jan 29, 2024 at 09:50:43AM -0500, Chuck Lever wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
> 
> For upper layer protocols that request rw_ctxs, ib_create_qp()
> adjusts ib_qp_init_attr::max_send_wr to accommodate the WQEs those
> rw_ctxs will consume. See rdma_rw_init_qp() for details.
> 
> To actually use those additional WQEs, svc_rdma_accept() needs to
> retrieve the corrected SQ depth after calling rdma_create_qp() and
> set newxprt->sc_sq_depth and  newxprt->sc_sq_avail so that
> svc_rdma_send() and svc_rdma_post_chunk_ctxt() can utilize those
> WQEs.
> 
> The NVMe target driver, for example, already does this properly.
> 
> Fixes: 26fb2254dd33 ("svcrdma: Estimate Send Queue depth properly")
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  net/sunrpc/xprtrdma/svc_rdma_transport.c |   36 ++++++++++++++++++------------
>  1 file changed, 22 insertions(+), 14 deletions(-)

After applying this one, workload tests trigger this set of errors
on my test NFS server (CX-5 in RoCE mode):

mlx5_core 0000:02:00.0: cq_err_event_notifier:517:(pid 4374): CQ error on CQN 0x407, syndrome 0x1
rocep2s0/1: QP 137 error: unrecognized status (0x41 0x0 0x0)

I think syndrome 0x1 is IB_EVENT_QP_FATAL ?

But the "unrecognized status" comes from mlx5_ib_qp_err_syndrome(),
which does this:

 344         pr_err("%s/%d: QP %d error: %s (0x%x 0x%x 0x%x)\n",
 345                ibqp->device->name, ibqp->port, ibqp->qp_num,
 346                ib_wc_status_msg(
 347                        MLX5_GET(cqe_error_syndrome, err_syn, syndrome)),
 348                MLX5_GET(cqe_error_syndrome, err_syn, vendor_error_syndrome),
 349                MLX5_GET(cqe_error_syndrome, err_syn, hw_syndrome_type),
 350                MLX5_GET(cqe_error_syndrome, err_syn, hw_error_syndrome));

I don't think the "syndrome" field contains a WC status code, so
invoking ib_wc_status_msg() to get a symbolic string seems wrong.

Anyway,

 - Can someone with an mlx5 decoder ring tell me what 0x41 is?
 - If someone sees an obvious error with how this patch has
   set up the SQ and Send CQ, please hit me with a clue bat.


> diff --git a/net/sunrpc/xprtrdma/svc_rdma_transport.c b/net/sunrpc/xprtrdma/svc_rdma_transport.c
> index 4a038c7e86f9..75f1481fbca0 100644
> --- a/net/sunrpc/xprtrdma/svc_rdma_transport.c
> +++ b/net/sunrpc/xprtrdma/svc_rdma_transport.c
> @@ -370,12 +370,12 @@ static struct svc_xprt *svc_rdma_create(struct svc_serv *serv,
>   */
>  static struct svc_xprt *svc_rdma_accept(struct svc_xprt *xprt)
>  {
> +	unsigned int ctxts, rq_depth, sq_depth;
>  	struct svcxprt_rdma *listen_rdma;
>  	struct svcxprt_rdma *newxprt = NULL;
>  	struct rdma_conn_param conn_param;
>  	struct rpcrdma_connect_private pmsg;
>  	struct ib_qp_init_attr qp_attr;
> -	unsigned int ctxts, rq_depth;
>  	struct ib_device *dev;
>  	int ret = 0;
>  	RPC_IFDEBUG(struct sockaddr *sap);
> @@ -422,24 +422,29 @@ static struct svc_xprt *svc_rdma_accept(struct svc_xprt *xprt)
>  		newxprt->sc_max_requests = rq_depth - 2;
>  		newxprt->sc_max_bc_requests = 2;
>  	}
> +	sq_depth = rq_depth;
> +
>  	ctxts = rdma_rw_mr_factor(dev, newxprt->sc_port_num, RPCSVC_MAXPAGES);
>  	ctxts *= newxprt->sc_max_requests;
> -	newxprt->sc_sq_depth = rq_depth + ctxts;
> -	if (newxprt->sc_sq_depth > dev->attrs.max_qp_wr)
> -		newxprt->sc_sq_depth = dev->attrs.max_qp_wr;
> -	atomic_set(&newxprt->sc_sq_avail, newxprt->sc_sq_depth);
>  
>  	newxprt->sc_pd = ib_alloc_pd(dev, 0);
>  	if (IS_ERR(newxprt->sc_pd)) {
>  		trace_svcrdma_pd_err(newxprt, PTR_ERR(newxprt->sc_pd));
>  		goto errout;
>  	}
> -	newxprt->sc_sq_cq = ib_alloc_cq_any(dev, newxprt, newxprt->sc_sq_depth,
> +
> +	/* The Completion Queue depth is the maximum number of signaled
> +	 * WRs expected to be in flight. Every Send WR is signaled, and
> +	 * each rw_ctx has a chain of WRs, but only one WR in each chain
> +	 * is signaled.
> +	 */
> +	newxprt->sc_sq_cq = ib_alloc_cq_any(dev, newxprt, sq_depth + ctxts,
>  					    IB_POLL_WORKQUEUE);
>  	if (IS_ERR(newxprt->sc_sq_cq))
>  		goto errout;
> -	newxprt->sc_rq_cq =
> -		ib_alloc_cq_any(dev, newxprt, rq_depth, IB_POLL_WORKQUEUE);
> +	/* Every Receive WR is signaled. */
> +	newxprt->sc_rq_cq = ib_alloc_cq_any(dev, newxprt, rq_depth,
> +					    IB_POLL_WORKQUEUE);
>  	if (IS_ERR(newxprt->sc_rq_cq))
>  		goto errout;
>  
> @@ -448,7 +453,7 @@ static struct svc_xprt *svc_rdma_accept(struct svc_xprt *xprt)
>  	qp_attr.qp_context = &newxprt->sc_xprt;
>  	qp_attr.port_num = newxprt->sc_port_num;
>  	qp_attr.cap.max_rdma_ctxs = ctxts;
> -	qp_attr.cap.max_send_wr = newxprt->sc_sq_depth - ctxts;
> +	qp_attr.cap.max_send_wr = sq_depth;
>  	qp_attr.cap.max_recv_wr = rq_depth;
>  	qp_attr.cap.max_send_sge = newxprt->sc_max_send_sges;
>  	qp_attr.cap.max_recv_sge = 1;
> @@ -456,17 +461,20 @@ static struct svc_xprt *svc_rdma_accept(struct svc_xprt *xprt)
>  	qp_attr.qp_type = IB_QPT_RC;
>  	qp_attr.send_cq = newxprt->sc_sq_cq;
>  	qp_attr.recv_cq = newxprt->sc_rq_cq;
> -	dprintk("    cap.max_send_wr = %d, cap.max_recv_wr = %d\n",
> -		qp_attr.cap.max_send_wr, qp_attr.cap.max_recv_wr);
> -	dprintk("    cap.max_send_sge = %d, cap.max_recv_sge = %d\n",
> -		qp_attr.cap.max_send_sge, qp_attr.cap.max_recv_sge);
> -
>  	ret = rdma_create_qp(newxprt->sc_cm_id, newxprt->sc_pd, &qp_attr);
>  	if (ret) {
>  		trace_svcrdma_qp_err(newxprt, ret);
>  		goto errout;
>  	}
> +	dprintk("svcrdma: cap.max_send_wr = %d, cap.max_recv_wr = %d\n",
> +		qp_attr.cap.max_send_wr, qp_attr.cap.max_recv_wr);
> +	dprintk("    cap.max_send_sge = %d, cap.max_recv_sge = %d\n",
> +		qp_attr.cap.max_send_sge, qp_attr.cap.max_recv_sge);
> +	dprintk("    send CQ depth = %d, recv CQ depth = %d\n",
> +		sq_depth, rq_depth);
>  	newxprt->sc_qp = newxprt->sc_cm_id->qp;
> +	newxprt->sc_sq_depth = qp_attr.cap.max_send_wr;
> +	atomic_set(&newxprt->sc_sq_avail, newxprt->sc_sq_depth);
>  
>  	if (!(dev->attrs.device_cap_flags & IB_DEVICE_MEM_MGT_EXTENSIONS))
>  		newxprt->sc_snd_w_inv = false;
> 
> 
> 

-- 
Chuck Lever

