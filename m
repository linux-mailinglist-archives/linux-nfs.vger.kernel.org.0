Return-Path: <linux-nfs+bounces-2484-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C38B88CBFC
	for <lists+linux-nfs@lfdr.de>; Tue, 26 Mar 2024 19:28:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A9CC1C3CDAB
	for <lists+linux-nfs@lfdr.de>; Tue, 26 Mar 2024 18:28:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B20884D3C;
	Tue, 26 Mar 2024 18:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="TtWa37Jm";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="LxQlhj66"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FB741CAA6
	for <linux-nfs@vger.kernel.org>; Tue, 26 Mar 2024 18:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711477681; cv=fail; b=Kb//oqaft+wCrmP1V9Ze3/kt45F8PEA4D/h756iblABs9P2Xb1y58tTIA2XJGMEtpbhposNy4OY262Df3qsIbY23qnGAMK2bQXZ36Z4Va5uhn7E5pKb6YK7b0SgB5DmUM0bTrYYePQhXmYFq6olfyohToKyFMMywxlM3HfbVSkw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711477681; c=relaxed/simple;
	bh=ARBiaVX+HrYLfPoPYv++lMu00/Nx6128Bd3krlaX4/I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=To2ZXoWrqugPIe/3nTAR/TZg8iOMa8kZeWtbRfGNEzuGdTfA2NpQ4Q3YLFwYtb7sgzMVi5UImoaLWWkdNwKDCWOsaURfr7Pcs1Z2i820yeN1949DquaorhCP++TaEgxxDmFFO8mPB+YAt5c5Hcsb6a/yEIzXgj1r3go6gos7AUc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=TtWa37Jm; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=LxQlhj66; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42QIPJNS005975;
	Tue, 26 Mar 2024 18:27:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-11-20;
 bh=CUECsu2aYR1zYHDC8a8jTgxpurdngSNnnKQ2ONBPDfo=;
 b=TtWa37Jm5HROhLKC1eXF+Zy3Btom027Tmr+NC4xaP7nb+NQkoISu2WD/+mDZTMji3i0U
 5giBiK9wWWwhDnxZ6Ge1HdoQUIS5FRaHi0EQURDLLeqffxc/vpetAD314LBkw28LP7bR
 vPIZFOJQ2+iIDdgxlhHxWIvlyBaebtdcUcJGlr5irMTvKYKZqMboJREZ2c84q/ANR7se
 3owOW1/KeHs7gUGuUV5Gu4ohV+AMf64XnlSAl1kwOR7A1MegOe8JXe0IPluOCvgNBlJc
 chjhFQANq7NPdMO6AZOx9qYG+asLi3RsqFGaqnEFlWQsB6d0Rb6pBWypoA2wm8fPejRn GQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3x1nv45snd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 26 Mar 2024 18:27:49 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 42QH5rOO022327;
	Tue, 26 Mar 2024 18:27:48 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2169.outbound.protection.outlook.com [104.47.73.169])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3x1nh7d0a9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 26 Mar 2024 18:27:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MaImbWRcBfQ9TvjcvWeahqkwKb17Ttl/54R7dv7jx8P5kc9Egdx42HWTcjtIq+XnDRZp+2ziWlVgS4vS5VRXU3K1pUC8cCUjrX0M4xjPfuqjqfa8VLZENqfbqhYfCA4GXf5BCn5x8L8WkW3R6XsaaPfH12tEsOAZioPDExavoG97oaWDjmoWtpENwxECbSNZdHrf5ACJ68XRt6GMockiYktz24GZ2YEy3R4bE7g/O4BchVaFr+6o4A6oCSbK4I+TRwAoAgPklu54Z4scpyIpox8bem/UPJkLjOzjYZnxLt2Lq3CRGgw7cATWv5BAKEXf0Z41sa0RiriXGg8B42KusA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CUECsu2aYR1zYHDC8a8jTgxpurdngSNnnKQ2ONBPDfo=;
 b=iLgfzy5vSM0pzJ4oy9yTBDAPEWfn2pY4mUEnp64YLq0B/AG1uC0c6Zf38NcOFP22HVQQ6bTdCrACuvCmFQznGcsyApjP1egkFmlAoLgKOwsmTl4Hnk96CjN5xi43aWMyL9xXS5qa7STlSssgyODWyDeB8bTwQ0oGZPXed7CZVHrIS25bdFPQBHbkZbmi0xTF48/SLw4L4xuYsRYwH/jW3aLiZf8HZom4skeQscTUF3r3BM5rREyBDYpuk1W81zc/AROZZOfb//C8k9TkexnrJqq7FQ/B/GyvN7brGBryBgoNVXhRZ+FFmlhjLktcbBrIADOJ9jQChtCkfO8R9LCSsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CUECsu2aYR1zYHDC8a8jTgxpurdngSNnnKQ2ONBPDfo=;
 b=LxQlhj66Tvgye3cfvlKahEm9JO7nyKV8ZgkcloTqQI40hSHyMPOmh8j7kKUEfKfab67ZYAL5JDp38UYUj3ELKKp6cNMuUnMhycj3HfGeaUWSw3ng3/cw34mfO/8LefT8FSEMGp1EL2877WLrUMSN6SJP2NcJ0W/6WQACI0dEh5Q=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CY8PR10MB6587.namprd10.prod.outlook.com (2603:10b6:930:58::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.33; Tue, 26 Mar
 2024 18:27:46 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ad12:a809:d789:a25b]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ad12:a809:d789:a25b%4]) with mapi id 15.20.7409.031; Tue, 26 Mar 2024
 18:27:46 +0000
Date: Tue, 26 Mar 2024 14:27:44 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: Dai Ngo <dai.ngo@oracle.com>
Cc: jlayton@kernel.org, linux-nfs@vger.kernel.org
Subject: Re: [PATCH 1/1] NFSD: cancel CB_RECALL_ANY call when nfs4_client is
 about to be destroyed
Message-ID: <ZgMToHNkkGEHNb/y@tissot.1015granger.net>
References: <1711476809-26248-1-git-send-email-dai.ngo@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1711476809-26248-1-git-send-email-dai.ngo@oracle.com>
X-ClientProxiedBy: CH0PR03CA0053.namprd03.prod.outlook.com
 (2603:10b6:610:b3::28) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|CY8PR10MB6587:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	Fv9VofGYLWY3Gsos02bJm1WKd9FnPNhWy4RxjUBnqcb2VYu6sfwFZspv+RHQVRJcboSzdOB1J04hlPSLWeWgUE0ofQwFwlCSZMvxJtE5MNTAO53za7YC1D7hyZrQd1YALkZaX9UblITR5JoILo/3jizhC7n8KAfPkqF+13ek9M0ls6QOI1dwhfXvbmUiPAiXtIPmO4wtcmc7LI9RzrVJQFZtcQyC/rBN7QTEea1VxQYxHc6ru+xfs7Wc59lhLL6e0y7xbO5dSw6ZprIQPCLNufW4sS4CRzEHCgk7yaI56qlvR6SL3n0u00CpljrICeHwVBYX2/waj8j5EoAAFE/olv/rjA+oxKCby7jWkSOykbP6dUwSPb0IQPJ7cyEqMXihVL9wSlXMmF633/eLJc8FWkL0ghevDcXoXsNAwCRwJKucc8AY1HVAHl5+hPQFXskp2dKHG/M7xJRFaxM3Mr6NzlQyRE7T3YhEV5kTlokyhBLUUjse7KM0LzrPKtEKMpeHFnm4HrK/gL2qq26ORtV1m1mjot6s5J/fwmtZabTCXi/NPKBZyKDGwFb36ulQMJ4KjDvKcf7n/3C+vi8mbKqjMPF8MA3Z1VQKJ6z7HngVVWYt2vlysmoMidCTx/4hSkKBMfbanKuxpIwbyQqbQjn0QV9qjE9uT294I34BtvyKbrM=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?PS5e7yeqgy4loV6rUZciT2V45qkmiiBzT7I7Je6k3tfc7ztLkifaG/oNv9de?=
 =?us-ascii?Q?eTCr3Gr/1Od0O60TJOe5+izXyCI6yt+uUyU7c2sXlKzx9UX//E/XZ3cXbm52?=
 =?us-ascii?Q?orOq3BKvXbcBrTB5fJNYDCwv47e7PtCi+a95+NkrwHmwii10y2GwxIZI4PUw?=
 =?us-ascii?Q?rBN4QA5eCYuqsvJY8Z2k8NDwxPNfYPbxIF5LgN1fYQUnrKo3n0gn1ZNey1+T?=
 =?us-ascii?Q?yrNm/BIQvmLtFm7CMvvhA9jlxt5XQlQLh9AXbVhS0pfYCbu/u/YyspFTs8dl?=
 =?us-ascii?Q?pkKjNjN8afkVcNkZd+40cGbMfrIIrVgo903EBfaEMO4J6qFPrScbJ+2Q1F81?=
 =?us-ascii?Q?KPrgI2aEZesTfKuKeJmV5hdqo2E0N92lHYbOszjKoPlyg1vvDhYLZDE09EK0?=
 =?us-ascii?Q?2pdmXbOQLFTXO3ravxP1WLmuRm4nsRl3xiu2FcqxT4S8BbjuTXc/YaTxJSyg?=
 =?us-ascii?Q?lAdLcUnOj85rXYjLtwBfLv/4DofCzavgT+BxOChVhxk0u8X/dO6CWczMLOTv?=
 =?us-ascii?Q?YrNxOyxBkXbNkc4bIZgWMXT/IJ1llOSaY7iipfyPVz/oCsSV9VbHFZPkOFsY?=
 =?us-ascii?Q?nzia9vZb2qiw3zQliErdHCbv6cdIF2KNHLLnYR0/YdxxL/LgWS4guMZeADTS?=
 =?us-ascii?Q?dXitLjIHCy9OWrciKBIy1eyso0lmKPCb3GL2zUpS5n8GbnOt/E2CgbUd3U4E?=
 =?us-ascii?Q?S7PzRZF0O4BjZ/6IDSm/6YklmnB2VmP7InSh9MJ22BTKWdII2mYWzVBZ7SEr?=
 =?us-ascii?Q?U7J8VcBHvqEiefxdDI8FeJ570MoeJ9CKL+TfOGFYLtU5oekt7Doc/O5SWvy3?=
 =?us-ascii?Q?LIu6erce/vaztK7s+qWVYGDjvioHhmwuHnt5qOBqGJkaIWQvDRc1MsioTVWA?=
 =?us-ascii?Q?QKBeNORWgIRfVhf68wadDhil6jLFkFY/ST6j8TsR573gxSc1Nm1bZ53HcUyH?=
 =?us-ascii?Q?QBwqvNnsFfSkQX2PEXEak7/Ggd2Yq9oKgM1/A9S1XAzkTCKaBPe2PIZexh8Y?=
 =?us-ascii?Q?5/tsfXGfZNvOKloHOT7BGm4KKAnHyEq5reamR3yaQEMRPapKypa1jo4fhi68?=
 =?us-ascii?Q?P1zSBU94iT7AoS31cCXO36FiBGButTap6SjRIjFQuW01ZFOuQcMEaggdiDT2?=
 =?us-ascii?Q?df2XCgFgiyc9rHN4XYNYXKr456j4GPlIczRPGxt0Fpi79DSPCrAxnLmh1fis?=
 =?us-ascii?Q?nSRgRIouzVf6Cvyy40t2tYpuT9nRquTOQDk7TVcoSCVzncCHThZRu45WkTI1?=
 =?us-ascii?Q?41D6Ylt9oBdb41TUvEbMAqS0KqpATslQRB29LBDrCfcGJRhKmBT2kqWTcZTP?=
 =?us-ascii?Q?eHrquaDsjD6ocJ/lg1CZ8bW99FrsTlTgNA6wXh0kYwhlXN5Lc0/lMOrxZcO3?=
 =?us-ascii?Q?njzSWXqMm21zzXI69KsjS2d2mQGJEQAPz4TnX0TlkqekDzQFVGo3vdeA6Tm+?=
 =?us-ascii?Q?ODWHUH2+1cbzxBtQtkBlt9olq7c63v3KV7wBhxVC1RKptWZNlxt1x91ehhgA?=
 =?us-ascii?Q?xtPJu6tyihz78bWEsYGfVPuS/60Iz5u+wH003MN/1U4ho8bi28RaIZI3n4UP?=
 =?us-ascii?Q?rHsd/eHM2DOS8z/KNoa5hK8M4yszGj+ZOGuO1OxkNtYp2iesZyyhLldDKBjY?=
 =?us-ascii?Q?EQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	TeUCIJB+MU9bwQBkzSloQlsyLLfLc+pjt7Gvec9zytDAHfWSZl7P0lkRTTpF7XR48rE0v7jzhumRQVil5xuz6D93AfxQGtSwJE+wQOtg2mJl8kTtI5sGFhXl2hahnEX+8B9mNUtupbNKFE+qFs1FsMABzeqBSJdg1P3H5FXmv2i6PaFRM34Xtn/LU7gKpYc5ef1ybA8/e9rdIin4S8AvQCzaBD+ENRcVzjAKGzXy4mh4eZftsoeg4kp3Ypf1yAKuRkwS3+yqRV+R7+Enu+ubb6VPTqIjl19IBDHTWYGsf6MjdzmlqPjHMrzasCSIQVMIHM5HyphdEVTrqvE+Fd1WLolZNATZQItbYwLxEa3ZzHTHMNWUZ6L2Fl04w0/+0L7Bjf+jeoC1YIAS0rhGpxWenNK+WUBtVxVaYRF7pEnAuzesrfPyRJ60Jzeyg70D0DsqvJrgpHKwQRk5IVD9WljHK0JsUfW9p26K5Ej6gMGbyp/G219GVE4dP8gSn56EvattNP135V/L9Ca2N+EM27T9o4oOU0PEhaaPXSgB36aYNS0BdYGVHrEWuV+OLAXbAQ3dQZk/NFzfwO5M1E2WxmIP+UEbZ7es2hpr2d+sfprlhmg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0e2a5f7-c592-49b5-10ec-08dc4dc26f55
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2024 18:27:46.7675
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q98FW9SNoYIG0U70Dk7u6PIzv6LvlNMBdjPjG4wQrhPlZ9mexEghxdVs08iyjxTM9tyuO2+3s7xB1yJbaoVJQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6587
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-26_08,2024-03-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999
 suspectscore=0 adultscore=0 mlxscore=0 spamscore=0 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403210000 definitions=main-2403260132
X-Proofpoint-ORIG-GUID: djH64r9Hwz1w2hohTWw1_OPrHMj9b_A3
X-Proofpoint-GUID: djH64r9Hwz1w2hohTWw1_OPrHMj9b_A3

On Tue, Mar 26, 2024 at 11:13:29AM -0700, Dai Ngo wrote:
> Currently when a nfs4_client is destroyed we wait for the cb_recall_any
> callback to complete before proceed. This adds unnecessary delay to the
> __destroy_client call if there is problem communicating with the client.

By "unnecessary delay" do you mean only the seven-second RPC
retransmit timeout, or is there something else?

I can see that a server shutdown might want to cancel these, but why
is this a problem when destroying an nfs4_client?


> This patch addresses this issue by cancelling the CB_RECALL_ANY call from
> the workqueue when the nfs4_client is about to be destroyed.

Does CB_OFFLOAD need similar treatment?


> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
> ---
>  fs/nfsd/nfs4callback.c | 10 ++++++++++
>  fs/nfsd/nfs4state.c    | 10 +++++++++-
>  fs/nfsd/state.h        |  1 +
>  3 files changed, 20 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
> index 87c9547989f6..e5b50c96be6a 100644
> --- a/fs/nfsd/nfs4callback.c
> +++ b/fs/nfsd/nfs4callback.c
> @@ -1568,3 +1568,13 @@ bool nfsd4_run_cb(struct nfsd4_callback *cb)
>  		nfsd41_cb_inflight_end(clp);
>  	return queued;
>  }
> +
> +void nfsd41_cb_recall_any_cancel(struct nfs4_client *clp)
> +{
> +	if (test_bit(NFSD4_CLIENT_CB_RECALL_ANY, &clp->cl_flags) &&
> +			cancel_delayed_work(&clp->cl_ra->ra_cb.cb_work)) {
> +		clear_bit(NFSD4_CLIENT_CB_RECALL_ANY, &clp->cl_flags);
> +		atomic_add_unless(&clp->cl_rpc_users, -1, 0);
> +		nfsd41_cb_inflight_end(clp);
> +	}
> +}
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index 1a93c7fcf76c..0e1db57c9a19 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -2402,6 +2402,7 @@ __destroy_client(struct nfs4_client *clp)
>  	}
>  	nfsd4_return_all_client_layouts(clp);
>  	nfsd4_shutdown_copy(clp);
> +	nfsd41_cb_recall_any_cancel(clp);
>  	nfsd4_shutdown_callback(clp);
>  	if (clp->cl_cb_conn.cb_xprt)
>  		svc_xprt_put(clp->cl_cb_conn.cb_xprt);
> @@ -2980,6 +2981,12 @@ static void force_expire_client(struct nfs4_client *clp)
>  	clp->cl_time = 0;
>  	spin_unlock(&nn->client_lock);
>  
> +	/*
> +	 * no need to send and wait for CB_RECALL_ANY
> +	 * when client is about to be destroyed
> +	 */
> +	nfsd41_cb_recall_any_cancel(clp);
> +
>  	wait_event(expiry_wq, atomic_read(&clp->cl_rpc_users) == 0);
>  	spin_lock(&nn->client_lock);
>  	already_expired = list_empty(&clp->cl_lru);
> @@ -6617,7 +6624,8 @@ deleg_reaper(struct nfsd_net *nn)
>  		clp->cl_ra->ra_bmval[0] = BIT(RCA4_TYPE_MASK_RDATA_DLG) |
>  						BIT(RCA4_TYPE_MASK_WDATA_DLG);
>  		trace_nfsd_cb_recall_any(clp->cl_ra);
> -		nfsd4_run_cb(&clp->cl_ra->ra_cb);
> +		if (!nfsd4_run_cb(&clp->cl_ra->ra_cb))
> +			clear_bit(NFSD4_CLIENT_CB_RECALL_ANY, &clp->cl_flags);
>  	}
>  }
>  
> diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
> index 01c6f3445646..259b4af7d226 100644
> --- a/fs/nfsd/state.h
> +++ b/fs/nfsd/state.h
> @@ -735,6 +735,7 @@ extern void nfsd4_change_callback(struct nfs4_client *clp, struct nfs4_cb_conn *
>  extern void nfsd4_init_cb(struct nfsd4_callback *cb, struct nfs4_client *clp,
>  		const struct nfsd4_callback_ops *ops, enum nfsd4_cb_op op);
>  extern bool nfsd4_run_cb(struct nfsd4_callback *cb);
> +extern void nfsd41_cb_recall_any_cancel(struct nfs4_client *clp);
>  extern int nfsd4_create_callback_queue(void);
>  extern void nfsd4_destroy_callback_queue(void);
>  extern void nfsd4_shutdown_callback(struct nfs4_client *);
> -- 
> 2.39.3
> 

-- 
Chuck Lever

