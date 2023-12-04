Return-Path: <linux-nfs+bounces-274-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B17780372C
	for <lists+linux-nfs@lfdr.de>; Mon,  4 Dec 2023 15:43:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D489D2810EE
	for <lists+linux-nfs@lfdr.de>; Mon,  4 Dec 2023 14:43:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FAAF28DC4;
	Mon,  4 Dec 2023 14:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LDDXFm26";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="anL7dfBZ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C5FB83;
	Mon,  4 Dec 2023 06:43:14 -0800 (PST)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B4EJG2s017512;
	Mon, 4 Dec 2023 14:43:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-11-20;
 bh=dRWJe0b1ssmcUbIcKzTOcmiyfuSmuOblliversfq9Hg=;
 b=LDDXFm26e3IrSMeE7XuDoi5Rv/AxcvmSvXtd4b8S42ADg9Ap5tYJxHIJZBnB/UnRRmzx
 uGJQ/ee5HUBzVI3QXMEBK077wFMfDVjgQo+AEG03SPF6I+sf4cwv/Yq73DRRFdVUCpcO
 s05cSrJ2OQ/r8oauISU7F4zvZzXo4JYtwgOAvSzfc/aHhyXYrtrhsVr9rsoKpz86sPAX
 QLheSlTXPr2O2/cMvZuqJHPDZzvVQXGyBMFBkxEQc5/2tgne8NQJS83zk/teB+saK2eD
 Uz5hh5FEo7m36rV22rHXfNOYVavlBbfZ0Wl1FRx1j1PADOExTbzoGX+QvU1MxiOJ/mnx SA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3usfhbr8nq-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 04 Dec 2023 14:43:05 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3B4DHNbL022564;
	Mon, 4 Dec 2023 14:33:40 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2040.outbound.protection.outlook.com [104.47.56.40])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3uqu1cavrn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 04 Dec 2023 14:33:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LjBKwyMzoGkLTb+2Dk/mvJUA5wkrtoQM/zlCnOISa1//bRlAhy0XsNozbA/XHokMdb7zSQaZYkkI9gjLNdOJ0uMatvzpCkUBdhAUVi2OoQTtzujEQ/j1XULwaS4AzP/+u3RcjlXoVTlfJb9xLyJaJ57ZY/ucCtWcdm508j+JKVal61OEm+zU1FGKgBkm4OOvwQ7aew9jNN8xaaPLCXv/DAK7UB1K0rK7MwUlV8ykNx10rAqrV5qZ98t0wUUEa9b5fCDVd6lohtQPjgP3TOgx52clUHPXT3ZRub4cUWVYHVG9/j2ZuxC9GaMDsjYTAPEOgTeTz9SyjO+3ovzmQYhR3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dRWJe0b1ssmcUbIcKzTOcmiyfuSmuOblliversfq9Hg=;
 b=ODkRwwvgGGLNdG14GUv+QwwrXjFnEkZqdIsxq2o+IKeDVFy1blAt75yCVsWezKttF/IhUKCmkfRudvF0JV/mGgpzrsYfZbdNPJ2q7ji18Vn9bpXUt30xcpgagb6INsmoGt6HwfvFvU3H8jhJbZnQXwar+04dZiipkvzA5ba5VmUcL7FGi9BTymgnEVmCfzlthKMCcrhZqEKuybEa/ZlHve1blpSt5tDbetV7ESBv5FK7pwa+Ekqo142Ah8pPzAkgmIoNtYXdJ4yIISmPlsZwf/idjUofFO4O74xmLb4u7/QiptPviU1eGiHvM4Z9Cj34lVPI2oAPf+yTLWRF7U4JJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dRWJe0b1ssmcUbIcKzTOcmiyfuSmuOblliversfq9Hg=;
 b=anL7dfBZZ2VME09vazrkDanwkYNc+f3NggVii+eNuEB6sIjgSs2rRP9IS08IdlZKeNKzAVE2z4PSxRsg38hGQwRTZaUWpBgeOlbYmUzKYUl9dGDQvcBDgoYrdflUiAVbtNfAqkgNm6um+MVKfN342xQZRRDTCg/RnD+opDLoHfI=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CH0PR10MB7482.namprd10.prod.outlook.com (2603:10b6:610:18b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.33; Mon, 4 Dec
 2023 14:33:38 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c%4]) with mapi id 15.20.7046.034; Mon, 4 Dec 2023
 14:33:38 +0000
Date: Mon, 4 Dec 2023 09:33:35 -0500
From: Chuck Lever <chuck.lever@oracle.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Jeff Layton <jlayton@kernel.org>, Neil Brown <neilb@suse.de>,
        Olga Kornievskaia <kolga@netapp.com>, Dai Ngo <Dai.Ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] nfsd: remove unnecessary NULL check
Message-ID: <ZW3jP7Z1OpLn+45Q@tissot.1015granger.net>
References: <0cce4257-6c22-4c0a-b769-b946990413fe@moroto.mountain>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0cce4257-6c22-4c0a-b769-b946990413fe@moroto.mountain>
X-ClientProxiedBy: CH2PR07CA0057.namprd07.prod.outlook.com
 (2603:10b6:610:5b::31) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|CH0PR10MB7482:EE_
X-MS-Office365-Filtering-Correlation-Id: ed57592a-59cb-4ed2-dea1-08dbf4d60112
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	oSH7CBvBZiqRwLOAk2fzRMYBR6U7++7Dy3aXU7yMBKcqNhejM8tsSKsjrSddsIXkdcczLzLa5nP5b8CIDXtDgTpFq7ZLi1kPy1zrpWsiYwuuivMSMwbJ+taKc3At0hUHVt46r7595IYpok+N4g+M453EALduRT9lEQw652Jv5K/Rd9zr3hGJ+WktxD1MCnVzZk2Fb7wB2gdpdyQi7CI54IqbD86B4jOhZTeD2qSY55Fdck4glqz6Lf9BAv4yPnMNiCP943zT9i6+RCbmsz8+ibuTMIyInHE/So9eimrYXQqFGKAMIi6u7xL7Sw8GZ5UOqMQQj0j4KPACD8y+Mnz471QWfcqDY09rqPuPiF+kk3QpVU//bK9yDs9DGW0N2hvEe3+UZEDmUa1R0MjlvbEj0TpR421y/3o6KlWEnthJUfRaYPN/u9aL6D9H1585mxwYPN+hjo28wBlWR4bcRz/12Y3fLQBJ3Qoo0oOIExNnmCbgVQH72ZHNrpTBjdNbYkHcwJTie9NMz9pX9qWtNFsa4T3W7RR08n+RKjP0IcwTk6BtNLeWpgXS9vPtxKs285z/6hYW7YEjm98RFymCC+yxZWyMjob9j097MmPLkBqD352/qr82Ku/Gao9WznsuPo8U4dC4RaQt4OoUEbJTV5Itrg==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(396003)(366004)(346002)(136003)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(38100700002)(5660300002)(4744005)(2906002)(83380400001)(6512007)(9686003)(6506007)(6666004)(26005)(478600001)(6486002)(41300700001)(966005)(316002)(66556008)(6916009)(54906003)(66476007)(66946007)(8676002)(8936002)(44832011)(4326008)(86362001)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?UR7brwLrw2h3pDgsx5oYHS8NAMFdI/So+rewvEKyRZcxXzvMS29JKNcAFlyo?=
 =?us-ascii?Q?C9SEags48AijspEM55WgJ2JRvdo1XP+UfYCE8qj/ETAyq3QdnwGw16Ar/mkh?=
 =?us-ascii?Q?O7+4P0VKmCoj6El1x0fPAGPASZg90Ww7NX0KtvemDiF7SaGG9MTeadm9zqbT?=
 =?us-ascii?Q?ifrgZSS9/dxP5pY7iLBXYT3Co1deULuF9eZnltBH8HsULZ+RXyoiomUGEk2q?=
 =?us-ascii?Q?CxhkIRCK7rzfhZoFyRIcr7Opy+ooVSZVA3LJO1bzwhrvW1sUICCZeEKJnqSB?=
 =?us-ascii?Q?YT+RgjtO9/rTvHyYdoCJ6nfrOWzVO1UX60TH9PUHAtEn6JlVrS6fcrOI5hDH?=
 =?us-ascii?Q?4SLv9+H8UBm8Ykoo3rtDPQ/jdxyioEQSuO54KsBx99mPtZv2QrLpd5T7xR9t?=
 =?us-ascii?Q?0Bb2lksgTDVQMiyCaGt+7k1p3xN++k9NECmHDo72+PoncleBWxZd3OeHOUVO?=
 =?us-ascii?Q?llojilXENW+pUJl5hCxnB7Oi4P/6zseeGPcL5HaWZNjm7UuXC+nxcpOEoDfp?=
 =?us-ascii?Q?gNe9Xfjx4cgQnEUG2nJyk6mkA8pG9jtrwE3kQjrWK6bFFWcN3pTDNSW8wm4J?=
 =?us-ascii?Q?xVRI0VlAZFrqvZvvYd/POXi8Ukxbs7avpIx3VTBRoSqZ1ZDmvkfnvw2X/8Aa?=
 =?us-ascii?Q?6ZxM4QLAQxv7CI5nLgDkIMXr+EzRGtzHEU+Fb3isM8he5CUKDaET7d2XpS8U?=
 =?us-ascii?Q?yPNySISpMNpv3jxmGNaHQ1WCls7h2P544Bv9Exnov/aJDlmgRFeZQLenJC5V?=
 =?us-ascii?Q?gajctLIX7nSHaGJc8QgZfhB0kz76J5Q0MS9EhTGcItdHJVF6bZIZOdyVW1n9?=
 =?us-ascii?Q?6SmJvE8SesIw9kr9rweGKP21ZItA7ySyl/xAw+139Y/++taJmVufVbApssOy?=
 =?us-ascii?Q?wuWgm2LUe0Ul8ucLRjLMpta/wNDEuKRgNvdWDO2EPqrXBTpXBycxZoOWa8cq?=
 =?us-ascii?Q?oYDrxyTMOx1cWjegKvJO8BpduVEFaNpzKO7UPmjQCGZG4t0ta74x4M0yUgkM?=
 =?us-ascii?Q?pz0yN2/brT8TLD0qGaPAbuhQ7j1zJrCE+y0zmiGRDFJqoO+qcNG058PPZ5pP?=
 =?us-ascii?Q?LNwVY/sPcE6qpo80d/tkpFOMbNuJfbsETK0eVwsPOAQMoAwiPg+EiTtXwHfz?=
 =?us-ascii?Q?DDxFIRFmRzcGL4ZfkPfZwWfOPXtJynHt5azGYNL6hNsGr7BNwOVh+5QIM7Do?=
 =?us-ascii?Q?1kRpGcQiZ1qlmuKPVqhwGvh0jg9d9yshsxUjkc6DW6De9XvTmYl4NYYUVfVf?=
 =?us-ascii?Q?8laQz4SCMgnmAU0OPWXTzFVPuYypM3GtP/VS/kUh5Kfpmturn3m4LDqrctOb?=
 =?us-ascii?Q?OcCyc04ab0QYD3IcG8JV3RQfAFXMixC7KDp9GEyDxyOGunGpfyOAt+zdz6h+?=
 =?us-ascii?Q?w8OA0FFdxpOmGOAv5LBQWNiPAsbOT8BpwwSgaTT0EtAhPiY07TqgmFvHoIu/?=
 =?us-ascii?Q?R/MoCuVNhWpP7hNwNwSMvCyvkGDIWLj4crX/cl0xhAae5ZuDMxiHHUZrto3+?=
 =?us-ascii?Q?LG9LhhFvmUqcI85SfLSogfco8XzjoH2APnsgzdWMpsA99Yt+XV3rCnw4JmC0?=
 =?us-ascii?Q?ocGgZME3XH33cg8aWfUK2Re8Qn7Cqbt5+RqpKrYRVS9h7HdYhrdFGQVyc0VA?=
 =?us-ascii?Q?rw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	Q7lNK5u08Oo29+nwR9+VoMtU50Wm0vYvmLOgBsi+n3EmSi4QNVlkw9iA1IcBkyXwsWJrFtYq96WYyDJLbLCMYtc7FA1aBgu0gFCEZgAfrKoPDRKrk5Gln3s9xy1s+NSvNvYaAB0QVWIgzMF50rIa5CYjUnVXyK/mQc9cBqPw5NdxLGzqku6hkSdutlV+q17Qk/dXyuegIud5mB7ODTy4Nm/DXAfVnr4CNL/yuJytjQGoBUZsy4UXTDOzin1KwiadPmH0IAvS4XduepUd+9yqQnLjRL5Wla/alEldJ4uydl6Dpqv4MpOjIzfR2S82FTV/0vm0tT7xDwvybyJh2P5qM+AZ7nW04C+3EsigrWa8xWc6fyZuV631CpItdtZJO213sy2jQ2+2G3wGm2ET5mjh2EBSWjmDGh3+TJD6Ureo/ak6609iSDmDcNwbR7/Xh3sNkImttQJQKS655UpXIhO/M+XDOkgHJC7FuZT/3UcCAZSvB0tTUMsD5/25sWsepkfDY1ZrOJQPR4QK9LNF3dRKfRsgLYyPgfGKUjtpZ21tu/kmaVsdqt3U5IC+HFozx5Di7hl5o/rJ8ktjRbIR+qOgpr6xXT/5MFut8RKVAE6URJOWrbf53+DQmUu50sbUwoGPeuXe19Nmg8UV+wvJzDQIkM1iWBFNNuseEKoErOxmWbCXPss4Dr8WK8+43LzqvMsMXzoY/P9hH4iJGgMUAhcn/i4zWw22RXPFeok+jj66bKXyzXXJQ9EDS7261sk9NWtOJAcp9SzStBa7ejwpDLnHHAOEcNGt0YOCfpUH9A6j/Okuwd407NMSGMDof555SzqLqTxYVPdlcilDLjkDfFHbCB+cTJEVx1pkNpOXV5bsbbYTo7QLLpsCRimfvRhJfMyLdmZc6SazF/VoPeMkZqaiUw==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed57592a-59cb-4ed2-dea1-08dbf4d60112
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2023 14:33:38.2507
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pbBpg6EtcdFd7ruDygJForxFdZsPeLXNE1SjnZ70UoaLBzSqWqBd1vMLak6T1zw0kgQDn5SD+agBvPTP2+K1ew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB7482
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-04_13,2023-12-04_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=949
 adultscore=0 suspectscore=0 phishscore=0 spamscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2312040109
X-Proofpoint-GUID: 23FpZlZ9e7vbhmwxTgug8eE_bOWiLL1q
X-Proofpoint-ORIG-GUID: 23FpZlZ9e7vbhmwxTgug8eE_bOWiLL1q

On Mon, Dec 04, 2023 at 03:30:06PM +0300, Dan Carpenter wrote:
> We check "state" for NULL on the previous line so it can't be NULL here.
> No need to check again.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/r/202312031425.LffZTarR-lkp@intel.com/
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

LGTM. Applied to nfsd-next for v6.8.


> ---
>  fs/nfsd/nfs4state.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index 40415929e2ae..fb551a3db1dc 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -6639,7 +6639,7 @@ __be32 manage_cpntf_state(struct nfsd_net *nn, stateid_t *st,
>  	spin_unlock(&nn->s2s_cp_lock);
>  	if (!state)
>  		return nfserr_bad_stateid;
> -	if (!clp && state)
> +	if (!clp)
>  		*cps = state;
>  	return 0;
>  }
> -- 
> 2.42.0
> 

-- 
Chuck Lever

