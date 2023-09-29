Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35A317B3889
	for <lists+linux-nfs@lfdr.de>; Fri, 29 Sep 2023 19:23:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232923AbjI2RXX (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 29 Sep 2023 13:23:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232800AbjI2RXW (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 29 Sep 2023 13:23:22 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84B331AE
        for <linux-nfs@vger.kernel.org>; Fri, 29 Sep 2023 10:23:20 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38TGnExF017880;
        Fri, 29 Sep 2023 17:23:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=FEGVR13RT4SLjCMHjcJSR45fZPxj7nLXf5769zhlZ7o=;
 b=XWNhWcDCljfDeRoCwztU5arhEz8w6oCdiiFiHdsPBROEmQjXEzrhh10e/vHXWPhEBAMu
 EQfRxMn3A6FhJv/e+2VNA6049tZHrVDZ+YVoLPY1BlY0bUzHAWbDOlmJ7+bzuiIsS7NH
 +nD32IU8KuzdDkeSsH2TKWklPLEkTcNBFBqkHZZrdiqb7wVElSaLLsfQTuvd4i65grA7
 D1+D6xcffqihM6ZnEwhZgFKcnKAz8JvRkThRq0Ut3efVEKNsh9gsRi/EtTiPM5pL4he7
 yM6QI7YiQ7Xtu+N1OqiM0L6D06O8hbrf2CT92yS+qGfbcO8U51uNF+TGCtEUqJKz9uAY fw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t9qmuq8h4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Sep 2023 17:23:14 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38TGTW3T004816;
        Fri, 29 Sep 2023 17:23:13 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3t9pfc2ma7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Sep 2023 17:23:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HWu3L1CzSoQwYPdCi4dfValODOmdJCvWI3X/uxoSYflcYCQlnW/96tIO8xhV+A4YYO7FRcWWZI+CVKEUgCGipxGRTJRBe95Si9eImlxDSn1MwhiPlf5wuu/95GRbvofYGLs4pbu8zh/1Lb5zJh0E1Hofmah2d3DACszDeJ6cDJQMxVPMrg7fg5WsBHJ6YaJMRYrhjjP3qrTxMzJ647DTPPcD6QkID6ffuZVSo5hIy34lu07gW+v+IWo94gb/zFIf/SL2DLkJAG8qpakeSmVItXbhgFxSdfOMC4x5ivCt5HSfS3VX5otC6KiUFMoBKYe+2qy5phXyGjcdDpXkFzxKrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FEGVR13RT4SLjCMHjcJSR45fZPxj7nLXf5769zhlZ7o=;
 b=Hj/UwuiS1/zhFcKVIY8M2msMeRUe2HbkIshp6/018Ya2hOtz2JckKYlpQ8sdNGeBhPkv+Gx2v4NnLSOCLAqtCQ6w3KNxfs3HJS8tE4yDBNgb1phMkc3Qyd0R7nmdspEVIsbjJlNDm3+ss9BwJJsOVJbiFhBpoQGGnkXKVrYInZ5hz97dWLs5g78Ia/mRgG93vSDciJd9H02nygOLg0RJFuGOrqacccvf/CjC5htkCSAZ1N6+iw9GrQHDmYKjmHKldO5fsa2tDVM48BzLxrKRyVbVD9JkADHeVCxZCEu+7YdiYqwwmLYyM6bbfj1cOOjNuvxPtZOkp1SVdYNiYu5Gxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FEGVR13RT4SLjCMHjcJSR45fZPxj7nLXf5769zhlZ7o=;
 b=eFAazSf2xA5JA6jqAEIT/aN8+VjZ/upd+uh1RLiAJXXurMRCYBEfzrjl3NV/fbFYxjIltMmCYlXZJU+ULUI9u5qOhcgc84s4hKkFET+G5cEEYVSJGuXrfXLzdtuvgL9hL0lxy9A/kJGJF1kau2EIol5kabBUrnM6ltqAac7oVrQ=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CYYPR10MB7627.namprd10.prod.outlook.com (2603:10b6:930:be::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.35; Fri, 29 Sep
 2023 17:23:09 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::bffc:4f39:2aa8:6144]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::bffc:4f39:2aa8:6144%5]) with mapi id 15.20.6813.027; Fri, 29 Sep 2023
 17:23:09 +0000
Date:   Fri, 29 Sep 2023 13:23:06 -0400
From:   Chuck Lever <chuck.lever@oracle.com>
To:     Jeff Layton <jlayton@poochiereds.net>
Cc:     Chuck Lever <cel@kernel.org>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH v1 3/7] NFSD: Add nfsd4_encode_open_read_delegation4()
Message-ID: <ZRcH+lQ5RRxsT5x6@tissot.1015granger.net>
References: <169599581942.5622.15965175797823365235.stgit@manet.1015granger.net>
 <169599594587.5622.94747681619250190.stgit@manet.1015granger.net>
 <4c6c46419d34cbe0a408aea4705383edecffa00d.camel@poochiereds.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4c6c46419d34cbe0a408aea4705383edecffa00d.camel@poochiereds.net>
X-ClientProxiedBy: CH0PR03CA0262.namprd03.prod.outlook.com
 (2603:10b6:610:e5::27) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|CYYPR10MB7627:EE_
X-MS-Office365-Filtering-Correlation-Id: d198a6e1-c2fd-43bc-be08-08dbc110bfff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MgfzdO49FT06Sio2w9nAk8z/kg7cv6DAeATf2ewItnKGN6w/yj8AvBvfuB/AKkMgAGflonp6L+qee/k1uAaRV38YRoNzEyoYV3yzaxM8FIXy3m71NIHsJqkL8/f5nBwoWIlFcR+8K68sQo588kakfz4WPo4fe6xmtPBRsERzrFw35rZ7HFKRrowXO75z89eqRbeXcDz9A9GThOnxyolt1FxStFKg0rGPAnUzZhllAIzX8jMbmnDI+rZqLhlA5T0xbEnFzm5VnDHiw5fXfnm4h7z0hB8nJe6yVrvGPYF1HU0runHoXfXSjJVO4k4CG88prg21+mbh1m5ztRwTPoP7e5D3zTrEIXGYlwqDwjW5YEzaDiOO6vjHwtp40iLgn5n6BMyKVZr+cyiKXFDjWUXVHKSH/xlXEDuc6vs70qxITNk95R0yCDkOsrounHN+dPkFlLZbY4VdKWbX1jlRAxUBVu9P6FpMTg0O0t9hq2yuPcOqxNkfxscAOeHKDZ1obEAYkW62PP8ZFgw3umj70+QT32sufWXSd71EFB8MDCPjUBM+IUxxwM8czKUpO8EaJnH9JrD1FTDaf+QrTJsh+mjLCgjXjZ+FN/IIdjwSVIy3Fwy05tq/c4hrOmcd4QqrAmg2Rex9Rn5l3eA4fRRoWfDwjA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(366004)(136003)(346002)(376002)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(6506007)(6666004)(6486002)(478600001)(83380400001)(26005)(6512007)(9686003)(5660300002)(6916009)(316002)(41300700001)(2906002)(44832011)(8676002)(4326008)(66476007)(8936002)(66946007)(66556008)(38100700002)(86362001)(66899024)(21314003)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8xGfFgU8+fDhJrEd2UFXwNhL8W1Y1wLJmC0PIoxZ0ufwjP05+sKdmbRTd3qw?=
 =?us-ascii?Q?F7Y4boWzIweGXx8P/BvHst8jJqZK+26Lx9Ao7tnVzNfKRctI3UobGXPdflZR?=
 =?us-ascii?Q?gS2GBc5MKCiaY25P+jCzXpsSco+KWsYHawbLeiX8bcxTar32JQ8+P5urHnu9?=
 =?us-ascii?Q?FAl25SvKblb9ZgGFwSTNri/BoDsNLaSSDdBAMycNwwyDsr15KfaQZbJImcbd?=
 =?us-ascii?Q?ap2xgEhNwfpm+0Z0gauK9dZSRJQzlXVeVO4DWOAVyg/JhzgP8xDzWcLyAdgm?=
 =?us-ascii?Q?txih9J+XvfKAAv5l/HrkHrMVo+Ct7gLq00+aEgP7P+VqqFV8/zGAvf1qe/lX?=
 =?us-ascii?Q?ridJsai+0gAKA4oIFqasGKGWW4MM9lhnRsD3BVDds1OnQcZoLqJ1unGC7ZtZ?=
 =?us-ascii?Q?o6ikA/G97ac8rkw7XPNMFDZyKti7qdMcWHsOlJRyth2BaWJNgx4xwuollYWF?=
 =?us-ascii?Q?oFb6bom2kjINC+BX0oS/BufYuWtLSxVquyWYLpsKm1gsRd210KZfsHgCd8C3?=
 =?us-ascii?Q?QMHaiABfSCt/gL4uUQCz0JvddEGW1FNCm4UNsbYLPfN7aNbqnV4y9blZlDcL?=
 =?us-ascii?Q?qbpdlgX/ZN1fQZmi1rwCCieMEJPFZF4RKBuEUmYCTDZ503n4MZr+qcswmBRv?=
 =?us-ascii?Q?OCSoZ0y8mCIDFVzaapR4Ym3QsXwwqR5aufxmOI5yI+XebYp8+sbnjykhuyi7?=
 =?us-ascii?Q?kAbkuBXzQsBDyqcvLFRJvMo24AUPhkTXHJYmiMb33Xnsdii5Jo4QdPAvCDoi?=
 =?us-ascii?Q?ZJ8CFl573UjeXpla/FTrcnnidoh8WsDSfAIqOnuxnmPwY2F4t6Sz6PsqGOcj?=
 =?us-ascii?Q?ZVjiXbfkYJhX/2lGA/YS+SzZj1Xiv+Im3eWKVBhoskfQsm3r4GUOhrMGKFHV?=
 =?us-ascii?Q?68cDENpVKgVRVIU/ucfScbuJIcVV6M5PIXHCTdPp25q6BvtLIYD7uE1Flk2D?=
 =?us-ascii?Q?trfysdXVRZ29Ycd+pS/QHI482+QwsLmmEVkcrYCoLpaGU1GibT65BTF1yUwz?=
 =?us-ascii?Q?kN+LIDjYov++WRvJzpDpq5Pw3KkRbG+InMWuzYe+tYzWXUNf3/b1hDCqI107?=
 =?us-ascii?Q?jaexe/pdnegq4+a/AJxqkPCKhq3ygHNlaDHQAxEtNT5WgA8hHt12NM+lxUST?=
 =?us-ascii?Q?ywdVviFCE0uk/35nlWkz7iHnVvk1pR9tc8GhpVsRk9VkSC5uvxmBXGNkoSi/?=
 =?us-ascii?Q?tKkeMjfcsR7b+T4Jwqvc6CliQodvpO+IN8cRz2rxpk+CMDm0SIuSkmagA244?=
 =?us-ascii?Q?KRbkzsvljcuoRjL1A9SDKb9TxSKnTjOqCBK21nsnjJ6qIyMNhy+pCG9mTCFQ?=
 =?us-ascii?Q?RH3EkC9qwzU+UzQxhAs0m8RrBhiesgHeLtPBmLmYxqnQ+T1dYGuMEXKlnDLZ?=
 =?us-ascii?Q?DAYfj7rVOBZVyeXjsW19Wbg5ax8bvBw6dznJeiwqbq+SJR4ic+pjTTH5DS1x?=
 =?us-ascii?Q?rW2DGFDoEh3tsSroCC+RboNgVwnnekoESjcz1G9D2JZv8VkGM7UcgV2XuM9M?=
 =?us-ascii?Q?X02T1W8U8tHgD6u+C2Bo85L3WZ8wgdpkcCN76vQaHB8cNV0GEOeFbru/jHEs?=
 =?us-ascii?Q?cgF8A8kcuqyFc+iBJCPOB9mBBzotfEfYPheE5SAcZcPg3t/XpHWnQE5KNh4r?=
 =?us-ascii?Q?tQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: cLGymCfOxMsyoxQHJg5xXn/376b0z0SzHKL1z/uYrguYGSYXMV4FdWPLZ5os8L2jGTwfqQDBTphlYexh79CnRhci3d1hWhQaFHKDeJpQTHsW2vSZrPnqd/1WdV3DVLnMEUVIUB7brGWbYTAU98dyaMZxsHomjA0V9iKXDLEz3zBlsAcD7GLy7FqYz0juAzL5b6hlBB+SegvG49o+x3OJxGLv595hphsqmmS0t0fbKPBKpBjj03Y65zQUg/comJVvNscVGboPTQABXJlnRX0/mHES625n3GAqwN3I0CPHIK8nzDxX1iKy069GcGLtY33vvFq2k1dzah8HRe0um+OJJQZ8hvZUqZjba8Dtuvr9dkaorq1QZJc2GH4sxDTPGxcWY3mDC46IAuiNejI1sVHGEkjIoUjlfddBLMTB6mu3l9CUVnSJcd/xjnjayFUzYz7O6r0WCoZjtx7RPgpzDxnRTi0lV1F3ZLLeZxP3naCRs8/Sb6L63YjANQppsmKlj1+g3ewDlr/dGAfVuyPfSYopRvphURRhhSAiFyKN+0jEccUn6DXTAO2EewFEHEYPOjFaOvPEQDhX5ySfs99APQcpHYU1M2JGxeNZCv5qba15b1r5cAtoB16AXBOHGwxV01a4m8wo5fACy4TUnSYCF4rD7Vq1lmWx9DJd6D0Q5wVuJS0nKgK7/BqfWcUp8kbRgBlQtFkDmPj6aPLV4QNzDWz4l0+JVwod6oJ9NYnl2eWK73y7k7Gn7lu1/0o8/nGG0zSmzS7Fl3w08K72vtLURnzuBU4V60y9AtPsHVS8jdC+izUhO2DEi5Ll6i8j0j7f3R15gH6kac7BMXPJ77Fjosv4dg==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d198a6e1-c2fd-43bc-be08-08dbc110bfff
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2023 17:23:09.1352
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hUoUOhkGRPGhtdxnzc0UBf7mu95IpU3unA/S0BeA33YxXM8wlAwcOYZ0DUxpeHf9SXEaqO8CH+0h3zbaqMWhMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR10MB7627
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-29_16,2023-09-28_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 mlxscore=0
 adultscore=0 mlxlogscore=999 suspectscore=0 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2309290149
X-Proofpoint-GUID: hiI1p9NO4KYowVg4EOSL4oFbhZdalW4j
X-Proofpoint-ORIG-GUID: hiI1p9NO4KYowVg4EOSL4oFbhZdalW4j
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, Sep 29, 2023 at 12:21:28PM -0400, Jeff Layton wrote:
> On Fri, 2023-09-29 at 09:59 -0400, Chuck Lever wrote:
> > From: Chuck Lever <chuck.lever@oracle.com>
> > 
> > Refactor nfsd4_encode_open() so the open_read_delegation4 type is
> > encoded in a separate function. This makes it more straightforward
> > to later add support for returning an nfsace4 in OPEN responses that
> > offer a delegation.
> > 
> > Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> > ---
> >  fs/nfsd/nfs4state.c |    6 +++--
> >  fs/nfsd/nfs4xdr.c   |   61 ++++++++++++++++++++++++++++++++++++++-------------
> >  fs/nfsd/xdr4.h      |    2 +-
> >  3 files changed, 49 insertions(+), 20 deletions(-)
> > 
> > diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> > index 22e95b9ae82f..b1118050ff52 100644
> > --- a/fs/nfsd/nfs4state.c
> > +++ b/fs/nfsd/nfs4state.c
> > @@ -5688,11 +5688,11 @@ nfs4_open_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp,
> >  	struct path path;
> >  
> >  	cb_up = nfsd4_cb_channel_good(oo->oo_owner.so_client);
> > -	open->op_recall = 0;
> > +	open->op_recall = false;
> >  	switch (open->op_claim_type) {
> >  		case NFS4_OPEN_CLAIM_PREVIOUS:
> >  			if (!cb_up)
> > -				open->op_recall = 1;
> > +				open->op_recall = true;
> >  			break;
> >  		case NFS4_OPEN_CLAIM_NULL:
> >  			parent = currentfh;
> > @@ -5746,7 +5746,7 @@ nfs4_open_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp,
> >  	if (open->op_claim_type == NFS4_OPEN_CLAIM_PREVIOUS &&
> >  	    open->op_delegate_type != NFS4_OPEN_DELEGATE_NONE) {
> >  		dprintk("NFSD: WARNING: refusing delegation reclaim\n");
> > -		open->op_recall = 1;
> > +		open->op_recall = true;
> >  	}
> >  
> >  	/* 4.1 client asking for a delegation? */
> > diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
> > index ee8a7989f54f..f411fcc435f6 100644
> > --- a/fs/nfsd/nfs4xdr.c
> > +++ b/fs/nfsd/nfs4xdr.c
> > @@ -4074,6 +4074,49 @@ nfsd4_encode_link(struct nfsd4_compoundres *resp, __be32 nfserr,
> >  	return nfsd4_encode_change_info4(xdr, &link->li_cinfo);
> >  }
> >  
> > +/*
> > + * This implementation does not yet support returning an ACE in an
> > + * OPEN that offers a delegation.
> > + */
> > +static __be32
> > +nfsd4_encode_open_nfsace4(struct xdr_stream *xdr)
> > +{
> > +	__be32 status;
> > +
> > +	/* type */
> > +	status = nfsd4_encode_acetype4(xdr, NFS4_ACE_ACCESS_ALLOWED_ACE_TYPE);
> > +	if (status != nfs_ok)
> > +		return nfserr_resource;
> > +	/* flag */
> > +	status = nfsd4_encode_aceflag4(xdr, 0);
> > +	if (status != nfs_ok)
> > +		return nfserr_resource;
> > +	/* access mask */
> > +	status = nfsd4_encode_acemask4(xdr, 0);
> > +	if (status != nfs_ok)
> > +		return nfserr_resource;
> > +	/* who - empty for now */
> > +	if (xdr_stream_encode_u32(xdr, 0) != XDR_UNIT)
> > +		return nfserr_resource;
> > +	return nfs_ok;
> > +}
> > +
> > +static __be32
> > +nfsd4_encode_open_read_delegation4(struct xdr_stream *xdr, struct nfsd4_open *open)
> > +{
> > +	__be32 status;
> > +
> > +	/* stateid */
> > +	status = nfsd4_encode_stateid4(xdr, &open->op_delegate_stateid);
> > +	if (status != nfs_ok)
> > +		return status;
> > +	/* recall */
> > +	status = nfsd4_encode_bool(xdr, open->op_recall);
> > +	if (status != nfs_ok)
> > +		return status;
> > +	/* permissions */
> > +	return nfsd4_encode_open_nfsace4(xdr);
> > +}
> >  
> >  static __be32
> >  nfsd4_encode_open(struct nfsd4_compoundres *resp, __be32 nfserr,
> > @@ -4106,22 +4149,8 @@ nfsd4_encode_open(struct nfsd4_compoundres *resp, __be32 nfserr,
> >  	case NFS4_OPEN_DELEGATE_NONE:
> >  		break;
> >  	case NFS4_OPEN_DELEGATE_READ:
> > -		nfserr = nfsd4_encode_stateid4(xdr, &open->op_delegate_stateid);
> > -		if (nfserr)
> > -			return nfserr;
> > -		p = xdr_reserve_space(xdr, 20);
> > -		if (!p)
> > -			return nfserr_resource;
> > -		*p++ = cpu_to_be32(open->op_recall);
> > -
> > -		/*
> > -		 * TODO: ACE's in delegations
> > -		 */
> > -		*p++ = cpu_to_be32(NFS4_ACE_ACCESS_ALLOWED_ACE_TYPE);
> > -		*p++ = cpu_to_be32(0);
> > -		*p++ = cpu_to_be32(0);
> > -		*p++ = cpu_to_be32(0);   /* XXX: is NULL principal ok? */
> > -		break;
> > +		/* read */
> > +		return nfsd4_encode_open_read_delegation4(xdr, open);
> >  	case NFS4_OPEN_DELEGATE_WRITE:
> >  		nfserr = nfsd4_encode_stateid4(xdr, &open->op_delegate_stateid);
> >  		if (nfserr)
> > diff --git a/fs/nfsd/xdr4.h b/fs/nfsd/xdr4.h
> > index aba07d5378fc..c142a9b5ab98 100644
> > --- a/fs/nfsd/xdr4.h
> > +++ b/fs/nfsd/xdr4.h
> > @@ -389,7 +389,7 @@ struct nfsd4_open {
> >  	u32		op_deleg_want;      /* request */
> >  	stateid_t	op_stateid;         /* response */
> >  	__be32		op_xdr_error;       /* see nfsd4_open_omfg() */
> > -	u32		op_recall;          /* recall */
> > +	bool		op_recall;          /* response */
> 
> nit: this would probably pack better if you moved op_recall down beside
> op_truncate.

Fixed. All 15 pushed to nfsd-next with your Reviewed-by. Thanks!


> >  	struct nfsd4_change_info  op_cinfo; /* response */
> >  	u32		op_rflags;          /* response */
> >  	bool		op_truncate;        /* used during processing */
> > 
> > 
> 
> -- 
> Jeff Layton <jlayton@poochiereds.net>

-- 
Chuck Lever
