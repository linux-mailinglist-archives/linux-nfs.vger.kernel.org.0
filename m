Return-Path: <linux-nfs+bounces-1922-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6B9A854BE0
	for <lists+linux-nfs@lfdr.de>; Wed, 14 Feb 2024 15:51:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 416D2B20378
	for <lists+linux-nfs@lfdr.de>; Wed, 14 Feb 2024 14:50:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15DFF5577F;
	Wed, 14 Feb 2024 14:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="E5M/oERd";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="T3zTF/rW"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1C915B1F3
	for <linux-nfs@vger.kernel.org>; Wed, 14 Feb 2024 14:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707922257; cv=fail; b=YRUJQfRnpV+EJ4G5RAc/qTs8u0gwNVzYIhVaPofAzVQxUcUgXXDfm5Fr+Z1piBcGU2N6jVfYT5WzN9uniq/854649HhtEa5gVHDr3/m9W6VNydF+1CJI3ZkjEHpF7UW84kJS/akdXhHjLJC6odZwM0vKq4f9Z0X+BVg4oYdvdC8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707922257; c=relaxed/simple;
	bh=h0pu1/q7OXSM884VS0LHfDiQiWBDtItn2sKPX78UM7c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=fyye67+k9Pkb+ecbNe7wHRCXY2sO5o30NaJRb02KwWNu8ELGIMCK3wLkWCecpRplZy+1+rjXNTph2cj6gJIrwcSgdGv0yKKWnHlmeLatZqLEUV9KZRWyeJdzu7waAvp0CqbkTmKDxL7HlYUA3UZ5tXVOQB7K6FHLcfepeseOiv4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=E5M/oERd; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=T3zTF/rW; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41ED3WSF024800;
	Wed, 14 Feb 2024 14:50:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-11-20;
 bh=464Xf07drL1F1QVG0hlfo5F7PJaw/0+AGOR0tqLwo5Q=;
 b=E5M/oERd4vs7HZyhTtxJjEpchRfWWKuVFNk3l39uLbTLbni89pUVZ3VcaLpoA6SjZuz6
 GfmLGm1W2U4cmwAJYNcJyeD/AV+O1RsIrrx2PBcUPqBsQw0a6Bbf3X0CH+47AKgmibdE
 IdZq2hVQmf7dth/GIAJFqSSHeYGrcJSu1Esa5ucHDbLhRCfTrXclWvTuEsjfyTbsESER
 dFHdVM/Rcuq0l83Qmlz6gfycEBxdRUP9yb1D/VA9VWLfsYQO5tMnp94Jl678A3Gh2w1S
 NrBFvznmC5sDf9/FCe1Xx2oHojy7AW8Pw8kSMlElHHSmi3lf5IWwmLyNsi5666M/MzPp gw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w8w6v8dg8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 14 Feb 2024 14:50:42 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41EE70h1014963;
	Wed, 14 Feb 2024 14:50:41 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3w5yk8rvqu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 14 Feb 2024 14:50:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TXpL+lR225WglL/S+INNplC5ioYiUgu0OWh61AJBMDdY9q2YJFxLhSMn/8BmnEiG9Dsu3/bIDs5Ux+dOmVwU6aI4UvPRJaZrwpOrGHSZ0ZDy4MIcwFk7tUQNoZH6ryIWF0i2SE4hqtboQTMpe9XmTiPr+o5SE6uTxMMoXbGyU5xZRM1NnEoVJmjoO8JVgwZIInt0mY77NDYsvxBFnyW0AerQWCXSEJ7JJ0d6aaDix5LGnFoUA6gQWQVNk9wYuvyysistOZzi0P98n5PCQPX2PDRjIw6QbRsu2OK9hc5bfATL+sBOKRWdHiFUMmNW2a0c3c4KwLkAKpUzd9HntZk0fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=464Xf07drL1F1QVG0hlfo5F7PJaw/0+AGOR0tqLwo5Q=;
 b=DwOex6N4SXvn9hnFk2dl/Wzfyu5a16zZaPuMS0caMeSwQj0mjP9Wy6HZsOvA2aUDpUu6dgim9E3cynacvfb/QQt85SCKCP9IuD5aJ2AXY9+9lrngTySGUoSjdE+L87tDenZu+RoXO2uFG1EPh8IwQD5FdzKNGYyconqL6sfw/vuskVEplcz9tEDJBpmTvdUP2MBC9T1QXI4Cg94yD6JG4qhu8lZAUD1B9EBEl16Zz1e3tXZGLdRP4LjBaRH8vcghNoV0YDfvL/+HX90p5ljkxJ+MiX9sjo4FmvsCE8b47wRHIwQjcjN8D8t4InpLUOVAbz7aAGUOcY1uEdz9fGlsVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=464Xf07drL1F1QVG0hlfo5F7PJaw/0+AGOR0tqLwo5Q=;
 b=T3zTF/rW6Hfd71k0wFOBJyfXRyW01gChYam2W5oi3tRpyhvCs/AOt8XrIsVP+ennDxvSQ5jWxDKKYtoXLF4VT+cH8zevGk1dKycQ+L6q3K96To45G0DdB5m3vi3VI5zs5fkN6lMm9q4OpF+HGIr/LYyg5yLvSu3esRYPhtq+sug=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CH2PR10MB4278.namprd10.prod.outlook.com (2603:10b6:610:7f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.39; Wed, 14 Feb
 2024 14:50:39 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ad12:a809:d789:a25b]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ad12:a809:d789:a25b%4]) with mapi id 15.20.7292.026; Wed, 14 Feb 2024
 14:50:39 +0000
Date: Wed, 14 Feb 2024 09:50:37 -0500
From: Chuck Lever <chuck.lever@oracle.com>
To: Dai Ngo <dai.ngo@oracle.com>
Cc: jlayton@kernel.org, linux-nfs@vger.kernel.org
Subject: Re: [PATCH 2/2] NFSD: handle GETATTR conflict with write delegation
Message-ID: <ZczTPSSCmKSmdSnB@tissot.1015granger.net>
References: <1707846447-21042-1-git-send-email-dai.ngo@oracle.com>
 <1707846447-21042-3-git-send-email-dai.ngo@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1707846447-21042-3-git-send-email-dai.ngo@oracle.com>
X-ClientProxiedBy: CH0PR07CA0029.namprd07.prod.outlook.com
 (2603:10b6:610:32::34) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|CH2PR10MB4278:EE_
X-MS-Office365-Filtering-Correlation-Id: 61808467-6edf-4775-2e13-08dc2d6c4f8d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	bp9yhQm1MhGzKoSwcrEnTfz+h7xeHq9y43LYVxx8DNJU71hcENWBdUxuC9Snqm+6SyBq197vunmxP3UwVAYcG9qHbRiIFSqKzhabdWIRtjzx/XQ/3sGHda3CsUm9r2ryaXW/uDSATyZpv9/ny5hAFkQ7G/77+xm8KkXVYvTlxZdNR5b7rF8dlJUx3k9f5z5vbd/MUXPcpwLWaYnkSo91RDioqb/PHePUP06X7kIlfl7b+ZIIHRCoWWgNe15hFBAqAMJtPBoDMMsHKsyyDMCn4T98OY7jE3c72U6/RbhaWmf/6LUUCTHlDVjv+c9Cs/hwO4fHg5ukov5jA/0iy5kR8RwF1lifwNgK1PAKf5+s5TRfSYe9wEd+xSn2JtILsf2Zsp8ZXYUgCRQTbK3kdfKbr5keieyoXcA80X0vmW8MM++nU7NToMYT/JYUCRKCSP01SJODy547RaPxOoCnr3kaiqbx+7AKO2R63hmYb9EtaHaJl8sB5PJR12ndYHIP2j9zWRqc5bPy07en0ZAe/WxsDo4QztITO2CtEnhHRKo0b4MMXMW5CFeW68HOov4OUcks
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(366004)(39860400002)(346002)(376002)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(44832011)(2906002)(66899024)(316002)(41300700001)(6636002)(6506007)(6512007)(6486002)(9686003)(478600001)(8676002)(8936002)(4326008)(66556008)(66476007)(6862004)(66946007)(5660300002)(30864003)(26005)(83380400001)(86362001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?l6mmBYxOlH7zjI/1vsPK8rbgFVW2Hr+oboxlNhLhKgyX05zf/7MfYaCWHas1?=
 =?us-ascii?Q?jflPcro+uHRCLsvWx3/BhvCQhz5L9qG0MaTgY0x/XySkDFV8uLcKrsnDDLUS?=
 =?us-ascii?Q?MR4/mdMkx4wPrCMACuzKxVCsYXivWIX9EH6JMdVzTiLov2YtYz/dTIEU4LjQ?=
 =?us-ascii?Q?7TNVNVcUDze1bm9XjIxPeLYoWHTeH6uDQ2xfUgpN8+TuT1kYrUrPBPJ+0BvC?=
 =?us-ascii?Q?aFgt3c1FyeWhHammb0vtVIVz3gnMSubHiKPiuEnxK/9YgcK/tG5v0O76NJ7W?=
 =?us-ascii?Q?pEjRhCQW2gX9fAv6TXePA8P6LYfH7oZpgkFHm2GITRfm4jV9/l5I6xAGXCaF?=
 =?us-ascii?Q?Gc+/EivX5clWuSgdcCljCucPC5FUvqptQLUCXkZQEfR1UCEgrEmh1APtHzc6?=
 =?us-ascii?Q?ioIOBb8ONbq8hqWTKkP8SYmaFHK9zTJectAhcfywYwD64uiTCXhTNNu1XvRQ?=
 =?us-ascii?Q?4mHm6V0KSp8K0Ubyis6nS9M92Vzk4zC14R0Rvo5pNiVxjCF69b8PEj7OyFvg?=
 =?us-ascii?Q?PoHw/kxv0HAbquOG4FVQLobx158wdD+pjE+DgrvQSEg8CtPemtK+XwjJ9tmH?=
 =?us-ascii?Q?F0PbUwJ8nDgMLr8UhtDZqTBrxXn3NCtvh8WsyjYDajjOAbk60SLQK+mikK0m?=
 =?us-ascii?Q?uCeb3KKeuTEHDFaF+EC0L9rf62Ho8g1jqvhFcxY96p2s/YBEMg+D1VvpPlc1?=
 =?us-ascii?Q?x/BjSKxi+3n7DylfL9+3c44KZHwNIWsCqZpHorTOIVNUWpdo5/+RVpqjJIXK?=
 =?us-ascii?Q?fuyotBck6+wkgILd2SHpwkxnWv7RHevjOv/uT9dr9dxqGdQHEdDvMkSsNMYo?=
 =?us-ascii?Q?u+H2KW/uVHx41Czl9cfi7fBQ5ViZm7YwENhYMMjDI6aLL6k20TEL1h6RizW3?=
 =?us-ascii?Q?nSzdjy/4rP4nXcoDyYicKzAUWgG4Qq2UA/7Y/laKI7yGeO+VU3LM1UCbJD06?=
 =?us-ascii?Q?jkYNXNvfH5tsjm1n/zUW4mhv5Hg9K8q7CmUdRuCKEmh6xXaIFkKNmsrTalhc?=
 =?us-ascii?Q?8d0ikPo/5GG4Lx8OWrSYzMZjHbF1p/TdIH4Ly8AqIDiWucd3CAGbK+as+6J/?=
 =?us-ascii?Q?5aKve/DPxnZ86Ki5hN/z6wwo3RgCNMrInYzZ4MOdBJFRbJI/PpNsuDadzray?=
 =?us-ascii?Q?TNyuq2A9cXOpHRgJG3GZMpEHQYB8uIMoJmXvkpbSTAtOdfTpDBkcufO7m3D0?=
 =?us-ascii?Q?U9Ve/auPJ17zGnMcCle5SJAfbAZEnTyhr72nM/J3ZOpcdH2XtBGJAZxj/9F3?=
 =?us-ascii?Q?Z3rR8DLanYfonLF6v3hd3F3IoQn3/52Yox4efdgDpunvFB2U9ypp7NGJ/V8j?=
 =?us-ascii?Q?lYz5EsoPpzUivrsN5DF2CjjQMhr6cAI8z1dypuzDzS3Ik550D6a+9hLrL8W/?=
 =?us-ascii?Q?jsFM5MiVQL7uSXePmxifiWfMuXjXqXi9ToOIdPTcpU9D3LDHyBnetFennEfV?=
 =?us-ascii?Q?B4MCG9GZAvh2+eZinRoUeKTREyLgDwkfaJs90+gXPWJtAt5aQ4kChROkhk8C?=
 =?us-ascii?Q?veB9nZmpqK8dbOedoES27EdJgqBfb9XSYDBUeNdXnNV43y5D9agZir2ZMiec?=
 =?us-ascii?Q?6gw0o3AtCrocrxVOdgaxXIsmFHGloyOnIp7ywDfQJd9ZmLWTUKXCSj50hjqt?=
 =?us-ascii?Q?Lg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	QlS3sO44GvSRDZ8wMIz4NuJYA22n7c5N8vGSJMuFJZPsUHlKHjQArlQ2FHVxMSBlRYFUyohyQd74hlmGRPD+4y8pBX2Vp/Mma1DDPInh7C/uCUyiiaCaBwnHDUBIUL/IqIu3kgduz0fqn+kaxKSNcekdu+FTxrVDO7KvWz/oG18eETUplUg3zEDO5Jqg9Nk5rMNVJofIBhGiXtfMgD2ES/NMVdmdjuOMKL7/jqWeVC85voug0JmK0Jzrm/+LACfLd7ccCVu+ScTPKt9vU41GJkD2FzQojwkUMbHshk7mKBXnoRix7dBg5qyXzEnj00TOgQCc7k6l/6/BT2IeZrCVYDT1A0LUnbODnjGcYpxbJPNG/a1RZpUiilV7L/ggs5rofWO0PH677r7mnM2oSm6p1cu/TXRRIKnwuEE4jJRbyc9VzxV6TtMNuSJTcZi5fEkP1tLV2OApH96I6cdQVCp/b29J7mDt7/jJP+SNmyaZo+07tbA7sinMt44kOZNHd3StSh0cC0FAH5GO1UoCY4Yi2kD1L4tfm5cgI+RIQOQpZVPXpnK08UgRazoGRF6IvPgx5Z8KrrWm22UrxIJ5hixu2TC3QepJ8m/LwOZTE9MNnJM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61808467-6edf-4775-2e13-08dc2d6c4f8d
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2024 14:50:39.6063
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /foijb4dICHcYrM+IcbTT9VMME+TR7vQ17Yz/HuhhMp6g3HXEjUudmqxtLKAQRQrVHeA37hufNGeg01xClkfIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4278
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-14_07,2024-02-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 phishscore=0 mlxscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402140115
X-Proofpoint-GUID: rvq9navFfXAUjPYok528quqjaP3VAG4B
X-Proofpoint-ORIG-GUID: rvq9navFfXAUjPYok528quqjaP3VAG4B

On Tue, Feb 13, 2024 at 09:47:27AM -0800, Dai Ngo wrote:
> If the GETATTR request on a file that has write delegation in effect
> and the request attributes include the change info and size attribute
> then the request is handled as below:
> 
> Server sends CB_GETATTR to client to get the latest change info and file
> size. If these values are the same as the server's cached values then
> the GETATTR proceeds as normal.
> 
> If either the change info or file size is different from the server's
> cached values, or the file was already marked as modified, then:
> 
>     . update time_modify and time_metadata into file's metadata
>       with current time
> 
>     . encode GETATTR as normal except the file size is encoded with
>       the value returned from CB_GETATTR
> 
>     . mark the file as modified
> 
> The CB_GETATTR is given 30ms to complte. If the CB_GETATTR fails for
> any reasons, the delegation is recalled and NFS4ERR_DELAY is returned
> for the GETATTR from the second client.
> 
> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
> ---
>  fs/nfsd/nfs4state.c | 119 ++++++++++++++++++++++++++++++++++++++++----
>  fs/nfsd/nfs4xdr.c   |  10 +++-
>  fs/nfsd/nfsd.h      |   1 +
>  fs/nfsd/state.h     |  10 +++-
>  4 files changed, 127 insertions(+), 13 deletions(-)
> 
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index d9260e77ef2d..87987515e03d 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -127,6 +127,7 @@ static void free_session(struct nfsd4_session *);
>  
>  static const struct nfsd4_callback_ops nfsd4_cb_recall_ops;
>  static const struct nfsd4_callback_ops nfsd4_cb_notify_lock_ops;
> +static const struct nfsd4_callback_ops nfsd4_cb_getattr_ops;
>  
>  static struct workqueue_struct *laundry_wq;
>  
> @@ -1189,6 +1190,10 @@ alloc_init_deleg(struct nfs4_client *clp, struct nfs4_file *fp,
>  	dp->dl_recalled = false;
>  	nfsd4_init_cb(&dp->dl_recall, dp->dl_stid.sc_client,
>  		      &nfsd4_cb_recall_ops, NFSPROC4_CLNT_CB_RECALL);
> +	nfsd4_init_cb(&dp->dl_cb_fattr.ncf_getattr, dp->dl_stid.sc_client,
> +			&nfsd4_cb_getattr_ops, NFSPROC4_CLNT_CB_GETATTR);
> +	dp->dl_cb_fattr.ncf_file_modified = false;
> +	dp->dl_cb_fattr.ncf_cb_bmap[0] = FATTR4_WORD0_CHANGE | FATTR4_WORD0_SIZE;
>  	get_nfs4_file(fp);
>  	dp->dl_stid.sc_file = fp;
>  	return dp;
> @@ -3044,11 +3049,59 @@ nfsd4_cb_recall_any_release(struct nfsd4_callback *cb)
>  	spin_unlock(&nn->client_lock);
>  }
>  
> +static int
> +nfsd4_cb_getattr_done(struct nfsd4_callback *cb, struct rpc_task *task)
> +{
> +	struct nfs4_cb_fattr *ncf =
> +			container_of(cb, struct nfs4_cb_fattr, ncf_getattr);
> +
> +	ncf->ncf_cb_status = task->tk_status;
> +	switch (task->tk_status) {
> +	case -NFS4ERR_DELAY:
> +		rpc_delay(task, 2 * HZ);
> +		return 0;
> +	default:
> +		return 1;
> +	}
> +}
> +
> +static void
> +nfsd4_cb_getattr_release(struct nfsd4_callback *cb)
> +{
> +	struct nfs4_cb_fattr *ncf =
> +			container_of(cb, struct nfs4_cb_fattr, ncf_getattr);
> +	struct nfs4_delegation *dp =
> +			container_of(ncf, struct nfs4_delegation, dl_cb_fattr);
> +
> +	nfs4_put_stid(&dp->dl_stid);
> +	clear_bit(CB_GETATTR_BUSY, &ncf->ncf_cb_flags);
> +	wake_up_bit(&ncf->ncf_cb_flags, CB_GETATTR_BUSY);
> +}
> +

What happens if the client responds after the GETATTR timer elapses?
Can nfsd4_cb_getattr_release over-write memory that is now being
used for something else?


>  static const struct nfsd4_callback_ops nfsd4_cb_recall_any_ops = {
>  	.done		= nfsd4_cb_recall_any_done,
>  	.release	= nfsd4_cb_recall_any_release,
>  };
>  
> +static const struct nfsd4_callback_ops nfsd4_cb_getattr_ops = {
> +	.done		= nfsd4_cb_getattr_done,
> +	.release	= nfsd4_cb_getattr_release,
> +};
> +
> +static void nfs4_cb_getattr(struct nfs4_cb_fattr *ncf)
> +{
> +	struct nfs4_delegation *dp =
> +			container_of(ncf, struct nfs4_delegation, dl_cb_fattr);
> +
> +	if (test_and_set_bit(CB_GETATTR_BUSY, &ncf->ncf_cb_flags))
> +		return;
> +	/* set to proper status when nfsd4_cb_getattr_done runs */
> +	ncf->ncf_cb_status = NFS4ERR_IO;
> +
> +	refcount_inc(&dp->dl_stid.sc_count);
> +	nfsd4_run_cb(&ncf->ncf_getattr);
> +}
> +
>  static struct nfs4_client *create_client(struct xdr_netobj name,
>  		struct svc_rqst *rqstp, nfs4_verifier *verf)
>  {
> @@ -5854,6 +5907,8 @@ nfs4_open_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp,
>  	struct svc_fh *parent = NULL;
>  	int cb_up;
>  	int status = 0;
> +	struct kstat stat;
> +	struct path path;
>  
>  	cb_up = nfsd4_cb_channel_good(oo->oo_owner.so_client);
>  	open->op_recall = false;
> @@ -5891,6 +5946,18 @@ nfs4_open_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp,
>  	if (open->op_share_access & NFS4_SHARE_ACCESS_WRITE) {
>  		open->op_delegate_type = NFS4_OPEN_DELEGATE_WRITE;
>  		trace_nfsd_deleg_write(&dp->dl_stid.sc_stateid);
> +		path.mnt = currentfh->fh_export->ex_path.mnt;
> +		path.dentry = currentfh->fh_dentry;
> +		if (vfs_getattr(&path, &stat,
> +				(STATX_SIZE | STATX_CTIME | STATX_CHANGE_COOKIE),
> +				AT_STATX_SYNC_AS_STAT)) {
> +			nfs4_put_stid(&dp->dl_stid);
> +			destroy_delegation(dp);
> +			goto out_no_deleg;
> +		}
> +		dp->dl_cb_fattr.ncf_cur_fsize = stat.size;
> +		dp->dl_cb_fattr.ncf_initial_cinfo =
> +			nfsd4_change_attribute(&stat, d_inode(currentfh->fh_dentry));
>  	} else {
>  		open->op_delegate_type = NFS4_OPEN_DELEGATE_READ;
>  		trace_nfsd_deleg_read(&dp->dl_stid.sc_stateid);
> @@ -8720,6 +8787,8 @@ nfsd4_get_writestateid(struct nfsd4_compound_state *cstate,
>   * nfsd4_deleg_getattr_conflict - Recall if GETATTR causes conflict
>   * @rqstp: RPC transaction context
>   * @inode: file to be checked for a conflict
> + * @modified: return true if file was modified
> + * @size: new size of file if modified is true
>   *
>   * This function is called when there is a conflict between a write
>   * delegation and a change/size GETATTR from another client. The server
> @@ -8728,22 +8797,22 @@ nfsd4_get_writestateid(struct nfsd4_compound_state *cstate,
>   * delegation before replying to the GETATTR. See RFC 8881 section
>   * 18.7.4.
>   *
> - * The current implementation does not support CB_GETATTR yet. However
> - * this can avoid recalling the delegation could be added in follow up
> - * work.
> - *
>   * Returns 0 if there is no conflict; otherwise an nfs_stat
>   * code is returned.
>   */
>  __be32
> -nfsd4_deleg_getattr_conflict(struct svc_rqst *rqstp, struct inode *inode)
> +nfsd4_deleg_getattr_conflict(struct svc_rqst *rqstp, struct inode *inode,
> +				bool *modified, u64 *size)
>  {
>  	__be32 status;
>  	struct nfsd_net *nn = net_generic(SVC_NET(rqstp), nfsd_net_id);
>  	struct file_lock_context *ctx;
>  	struct file_lock *fl;
>  	struct nfs4_delegation *dp;
> +	struct iattr attrs;
> +	struct nfs4_cb_fattr *ncf;
>  
> +	*modified = false;
>  	ctx = locks_inode_context(inode);
>  	if (!ctx)
>  		return 0;
> @@ -8768,12 +8837,42 @@ nfsd4_deleg_getattr_conflict(struct svc_rqst *rqstp, struct inode *inode)
>  				return 0;
>  			}
>  break_lease:
> -			spin_unlock(&ctx->flc_lock);
>  			nfsd_stats_wdeleg_getattr_inc(nn);
> -			status = nfserrno(nfsd_open_break_lease(inode, NFSD_MAY_READ));
> -			if (status != nfserr_jukebox ||
> -					!nfsd_wait_for_delegreturn(rqstp, inode))
> -				return status;
> +			dp = fl->fl_owner;
> +			ncf = &dp->dl_cb_fattr;
> +			nfs4_cb_getattr(&dp->dl_cb_fattr);
> +			spin_unlock(&ctx->flc_lock);
> +			/*
> +			 * allow 30 ms for the callback to complete which should
> +			 * take care most cases when everything works normally.
> +			 * Otherwise just fall back to the normal mechanisnm to
> +			 * recall the delegation.
> +			 */

The code already says what the comment says, and if
NFSD_CB_GETATTR_TIMEOUT is ever changed, the comment will become
stale. I suggest removing this comment and adding just a one-liner
something like below:


> +			wait_on_bit_timeout(&ncf->ncf_cb_flags, CB_GETATTR_BUSY,
> +					TASK_INTERRUPTIBLE, NFSD_CB_GETATTR_TIMEOUT);
> +			if (ncf->ncf_cb_status) {

				/* Recall delegation only if client didn't respond */

> +				status = nfserrno(nfsd_open_break_lease(inode, NFSD_MAY_READ));
> +				if (status != nfserr_jukebox ||
> +						!nfsd_wait_for_delegreturn(rqstp, inode))
> +					return status;
> +			}
> +			if (!ncf->ncf_file_modified &&
> +					(ncf->ncf_initial_cinfo != ncf->ncf_cb_change ||
> +					ncf->ncf_cur_fsize != ncf->ncf_cb_fsize))
> +				ncf->ncf_file_modified = true;
> +			if (ncf->ncf_file_modified) {
> +				/*
> +				 * The server would not update the file's metadata
> +				 * with the client's modified size.
> +				 */

I don't understand "The server would not update...". Does that mean
the server is not supposed to update, or something failed? Can this
comment be clarified?


> +				attrs.ia_mtime = attrs.ia_ctime = current_time(inode);
> +				attrs.ia_valid = ATTR_MTIME | ATTR_CTIME;
> +				setattr_copy(&nop_mnt_idmap, inode, &attrs);
> +				mark_inode_dirty(inode);
> +				ncf->ncf_cur_fsize = ncf->ncf_cb_fsize;
> +				*size = ncf->ncf_cur_fsize;
> +				*modified = true;
> +			}

One of the lesser-known guidelines of coding style is that if the
indent level grows too deep, that's a sign that you should move
this code into another function. Up to you, but IMO that might be
easier to read.


>  			return 0;
>  		}
>  		break;
> diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
> index e3f761cd5ee7..9e8f230fc96e 100644
> --- a/fs/nfsd/nfs4xdr.c
> +++ b/fs/nfsd/nfs4xdr.c
> @@ -3507,6 +3507,8 @@ nfsd4_encode_fattr4(struct svc_rqst *rqstp, struct xdr_stream *xdr,
>  		unsigned long	mask[2];
>  	} u;
>  	unsigned long bit;
> +	bool file_modified = false;
> +	u64 size = 0;
>  
>  	WARN_ON_ONCE(bmval[1] & NFSD_WRITEONLY_ATTRS_WORD1);
>  	WARN_ON_ONCE(!nfsd_attrs_supported(minorversion, bmval));
> @@ -3533,7 +3535,8 @@ nfsd4_encode_fattr4(struct svc_rqst *rqstp, struct xdr_stream *xdr,
>  	}
>  	args.size = 0;
>  	if (u.attrmask[0] & (FATTR4_WORD0_CHANGE | FATTR4_WORD0_SIZE)) {
> -		status = nfsd4_deleg_getattr_conflict(rqstp, d_inode(dentry));
> +		status = nfsd4_deleg_getattr_conflict(rqstp, d_inode(dentry),
> +					&file_modified, &size);
>  		if (status)
>  			goto out;
>  	}
> @@ -3543,7 +3546,10 @@ nfsd4_encode_fattr4(struct svc_rqst *rqstp, struct xdr_stream *xdr,
>  			  AT_STATX_SYNC_AS_STAT);
>  	if (err)
>  		goto out_nfserr;
> -	args.size = args.stat.size;
> +	if (file_modified)
> +		args.size = size;
> +	else
> +		args.size = args.stat.size;
>  
>  	if (!(args.stat.result_mask & STATX_BTIME))
>  		/* underlying FS does not offer btime so we can't share it */
> diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
> index 8daf22d766c6..16c5a05f340e 100644
> --- a/fs/nfsd/nfsd.h
> +++ b/fs/nfsd/nfsd.h
> @@ -367,6 +367,7 @@ void		nfsd_lockd_shutdown(void);
>  #define	NFSD_CLIENT_MAX_TRIM_PER_RUN	128
>  #define	NFS4_CLIENTS_PER_GB		1024
>  #define NFSD_DELEGRETURN_TIMEOUT	(HZ / 34)	/* 30ms */
> +#define	NFSD_CB_GETATTR_TIMEOUT		NFSD_DELEGRETURN_TIMEOUT
>  
>  /*
>   * The following attributes are currently not supported by the NFSv4 server:
> diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
> index 3bf418ee6c97..01c6f3445646 100644
> --- a/fs/nfsd/state.h
> +++ b/fs/nfsd/state.h
> @@ -142,8 +142,16 @@ struct nfs4_cb_fattr {
>  	/* from CB_GETATTR reply */
>  	u64 ncf_cb_change;
>  	u64 ncf_cb_fsize;
> +
> +	unsigned long ncf_cb_flags;
> +	bool ncf_file_modified;
> +	u64 ncf_initial_cinfo;
> +	u64 ncf_cur_fsize;
>  };
>  
> +/* bits for ncf_cb_flags */
> +#define	CB_GETATTR_BUSY		0
> +
>  /*
>   * Represents a delegation stateid. The nfs4_client holds references to these
>   * and they are put when it is being destroyed or when the delegation is
> @@ -773,5 +781,5 @@ static inline bool try_to_expire_client(struct nfs4_client *clp)
>  }
>  
>  extern __be32 nfsd4_deleg_getattr_conflict(struct svc_rqst *rqstp,
> -				struct inode *inode);
> +		struct inode *inode, bool *file_modified, u64 *size);
>  #endif   /* NFSD4_STATE_H */
> -- 
> 2.39.3
> 

-- 
Chuck Lever

