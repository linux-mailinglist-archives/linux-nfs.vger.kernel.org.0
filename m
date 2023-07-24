Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5311C75F833
	for <lists+linux-nfs@lfdr.de>; Mon, 24 Jul 2023 15:26:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229789AbjGXN0W (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 24 Jul 2023 09:26:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229887AbjGXN0V (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 24 Jul 2023 09:26:21 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64DB4E0;
        Mon, 24 Jul 2023 06:26:20 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36O6o1wk007246;
        Mon, 24 Jul 2023 13:26:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=bWYY9CM8XiNxx2JIQMOBwx3xkR++tYNnq5Y0X3eiNpY=;
 b=oCRh0PrkECo9s0melASyQDvPrneeVGv3zGjYbEnpJhS4B6Fx6A6n7aOHPpUwJifuc5ZR
 xWSirTrgua+3T7WkdxpCx6OkPhX/qFzJfiv/T89uGH+jYq4cAzKjgYzQ1LeuGZQzZARd
 BmoTxyCv0N+vxX5gB/JJ1BkDnEaQiLfrTr9b5KkHwTBdyfSSKAenVXVEyRMKhmQYNIDQ
 5Bdoo2xiF0yH44llPZ2Xr8X1Ts7+8CSVS+d5aneof1JAmV8YX3gwnqaKmgbbfQ5DDfDy
 CKsTc5U/u2lOfo172y0EOEq9UhFIf2ggNNuQqwXXBa4tKhgDajK9uosmxeHo6IdnH04Q eg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s07nujn4n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Jul 2023 13:25:59 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36ODC4t6035392;
        Mon, 24 Jul 2023 13:25:59 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2047.outbound.protection.outlook.com [104.47.74.47])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3s05j3dysu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Jul 2023 13:25:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MLu1tUczVydYs3bkPetJPtWrUWeG9F2dayt4rDcGcS5w4MWU6CAjOmA5wpmwp1mkPwMBpKx5HT9l3YHah9f69ETWfep+m+O+vPOYI9drVLY6LOXEpkhDd267zZ44pweiFDxYA9xX+eYPPnSS0u4FWx8VFyewCX63A0lr/D7EthiWKWL+7PBJM7BmyQ+/O3wUjEbM5rZK3QmKolpA+dQVqOv2QxBhxgCxldvMhrqUSBz25LJdLMzfXYUGtihwdzyUtWMwP4j5oo+JRPfHCscseHmx5D1LmO75wJtsQDTU4IccfjK2n+oOK6je9ZImZxqay77KvNVNiXWVjH9bZJtjCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bWYY9CM8XiNxx2JIQMOBwx3xkR++tYNnq5Y0X3eiNpY=;
 b=WN7FWEeNVcJr+6wXK9NttV45+XHf6ma1VzQ5CgdKfODFwRgPznWWfn3c+m3mx7cAyIJKecYaRLmdB9xE0gLQID2uy9FP3A/PGNV4b7BysxY44qyJdeQE8ymui9S+5LLV3ScODkWpZK8jNiSF9XE8su3kJkiU2jiiXdZACCGYdrCNrC3mYOnA8uZB8L5eR/JSp4eFDX1bFOhV2DrhkSzuG4WPAs1twUGYnK86krfcAbqCtShIpgQXWIexVAaiCLqmXTet6hZPuyj/FL26WqRgxY7zfDjXEAyQCmNP12Tglb9oGHI8t79kwzInHj4Baoh/AlOEv8j2ll3JRG5MoSemyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bWYY9CM8XiNxx2JIQMOBwx3xkR++tYNnq5Y0X3eiNpY=;
 b=CrT7nvPekyuCN5u30GwbdJ2VRRX/GQVfHBor2TDWn3YovkFltnDNNcf3ukEvWmjdPBpnH6uHImGY7Tk03Cj1Gohf8EOz1Ek9/vR8/+YufRqOL+W00J8wjSzBMlWKAjugbJfF0nb/Wui9GWO6n+RJfcFjwAdEJ6BagVluforzAFY=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH0PR10MB4406.namprd10.prod.outlook.com (2603:10b6:510:34::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.32; Mon, 24 Jul
 2023 13:25:56 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2990:c166:9436:40e]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2990:c166:9436:40e%6]) with mapi id 15.20.6609.032; Mon, 24 Jul 2023
 13:25:56 +0000
Date:   Mon, 24 Jul 2023 09:25:50 -0400
From:   Chuck Lever <chuck.lever@oracle.com>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     NeilBrown <neilb@suse.de>, jlayton@kernel.org, kolga@netapp.com,
        Dai.Ngo@oracle.com, tom@talpey.com,
        trond.myklebust@hammerspace.com, anna@kernel.org,
        linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] sunrpc: Remove unused extern declarations
Message-ID: <ZL573hzgHEfp+gbb@tissot.1015granger.net>
References: <20230722033116.17988-1-yuehaibing@huawei.com>
 <169017533908.11078.1160756498004010060@noble.neil.brown.name>
 <d8178e7c-d0ec-9e5d-9367-53f554e0392e@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d8178e7c-d0ec-9e5d-9367-53f554e0392e@huawei.com>
X-ClientProxiedBy: SJ0P220CA0021.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::8) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|PH0PR10MB4406:EE_
X-MS-Office365-Filtering-Correlation-Id: c33d3849-d8d3-4c0c-1083-08db8c498313
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 79AxuZgloD555NVQA9sl2kGDlr6KLrZlMRSlvUW8gfjSNoVaCqOtN8Ku0FqVxWbBFVL05seaLJcgT7Cq2ie+kXAZHjr2GC6cM81Z69n72kL6BrG/kRQXUo7AxMFVsqXmhRtcbJIULp65eptDCyyOMf0IIkr4VUXBiykYg0G6XrY4MHuXYuslcftUHtcvouhThq0qp+lpBsAT6t0qG+W90Mgx5OikAVywA71QG/D6kepJQSyA3Dp1AMPlBAkoWFs1hgBY93dWHAfRXgZ6raUBW/a4OfJ5x9SWUThrtMshmJ0i7I1HgGXHZADbUXgpEGEDAwUGXCEUpRjgKIu1vLOXshtNtgwu4yA3Z8LDgPgmV/fA52U+sgeSvWCGR7bqmZgZiqcVZDE+Qi4Us8eeGnD4/vGstAgaIxzTieSEdnNGUl7+fFV/5LQbe5jj9kJs3ZiY8U1HeU3zNpSVN5Rds9ro3TLiuiko+luG4vjdc8vEIPjBokIspVEfGOK8Y0oDA0ITKHUV6kpqR/MR6LXaNd1rfb+h+vw1cnKRSpuzSNojZximJoIscofYearBavK9QL42okusSogeU9S83bHrEtTek9jgBDATb4ds8MFz4JAsHps=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(366004)(376002)(39860400002)(136003)(396003)(451199021)(38100700002)(53546011)(83380400001)(44832011)(8676002)(8936002)(5660300002)(478600001)(66556008)(316002)(6916009)(4326008)(66946007)(41300700001)(26005)(186003)(6506007)(6486002)(6666004)(6512007)(9686003)(66476007)(2906002)(86362001)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?w4FoucZbAFPP+sAbrK1GdAZ3mEn1UwhvtjstQqhnpybWoMi5Qh3mQzUsbbBG?=
 =?us-ascii?Q?+QQThvpbSbQvOld0ETKvOLlkZYQJnrit1qP7BR0i0zTkWJJwvcZD07GQ+xCt?=
 =?us-ascii?Q?U371HQoFYc2dEdsAwR8w/lyhcCRi5/FyQmrMX6GsEuRHLumDhIIIKjTPwd+L?=
 =?us-ascii?Q?V2lD1wXSUSKmEW0YGDICB91d8L7jLpvpS59naBeR1pJu5aiRJm1aXhDT6EqZ?=
 =?us-ascii?Q?7w2xz/85CVpm/tyU74RMXci5vvC8lDz+1HEUCK7vNpNEbnBFlOODDbUj9kZk?=
 =?us-ascii?Q?+JmYxLCdBTJogMbqbElBGJVjWErAj+9BRcd1fLsixKVxA9l09L+JD49KpVg7?=
 =?us-ascii?Q?lz1PoifTa3ZdGLpCM/s0XLgVOV72Nb9o+xXylnAa1x2yR2LLkAWBD5qkKyrT?=
 =?us-ascii?Q?jhBpyDbY1vL7eqp0a3jIRuXBQym9MfQ8AjnQ13DVufpb4A4FEBYXBgTa+fVK?=
 =?us-ascii?Q?XnUHT9fX2dzvHKedVzP30Ky7QXE+tRdF0HtUH4WxZYf46kH1q9ZfOCKoeKoc?=
 =?us-ascii?Q?rMrG9to1T73whNYOzneiGRA+rlKcqnpCTVz3KsBIxf5LD0J7L0chBzQ/IV12?=
 =?us-ascii?Q?vOq98CrOvCBHmtanIm60Kfzee7IVwSgA0FalOZ2xjjrz3sXbqVTw/4CmWCRc?=
 =?us-ascii?Q?cCf4w6UDc0UrfMcXyjq1qPBlRt5bg+9CuOErhl2fUxnbpfjkvKvTBZ5XIJme?=
 =?us-ascii?Q?3vgwR23wjB5GLH0DxG0cs44Udsd57z3GrU8sA2Jjtf2cSGMnB/wAqWYJ1E9E?=
 =?us-ascii?Q?vYEPkzt1+am7MZEMLQQjfNwxlQAuFWpEz7Q3y3/uoZo8CzkuaOzT/kzVLhb4?=
 =?us-ascii?Q?7AbZTuvd5ajGkH3ku0j41xXzUS+hYO1X6WVvK+UFZoj+STforkyBdxS5kG4R?=
 =?us-ascii?Q?sNurJLESd4keu8KvjxW94Y1XqPi6cvGsKam2c7RDVmiSt81rlW7dqDkbSpnq?=
 =?us-ascii?Q?t3b08u3NeKPPK1mgvHjYTvl2lXD7JUJD585a6JfVWf7YVG2/JedXu/iFuOjG?=
 =?us-ascii?Q?/kMjq7oJDOzzjri9j+gDE/9TNhEzWP7k7XNf4tq2zgjBNLyO4sd+yZ5DPEk3?=
 =?us-ascii?Q?6eXomaZPMITOyP+zeIrbAPeM2HQIT9JEUKrekkrMAgNF9HYA8IaGEC0XzCHm?=
 =?us-ascii?Q?j3DE0eENcvMJL4rPyNvcI+dRncI9Q46aAyX7my9nJtJLcro9aBi4wtZMsesa?=
 =?us-ascii?Q?l3SR/mRR4KM9O5ma9c2zL3gkWjeL/GQQDIERiGXk7c+Lwz7Cwvrl1xbtfikt?=
 =?us-ascii?Q?r+D5wFeWV5DjCCBUaog6Ysh9OMc1unXsuufa+mtLKf/yCmuMQ0TzLRp9eZPq?=
 =?us-ascii?Q?tQix2IoQCkxXXBpJieRqAtAKX5HY1WJ/t1uFIa21RKXvEnJG2NmM/WeiD9cO?=
 =?us-ascii?Q?mUVhMbk0reurKnTaTioZOkvE460KOrXbu+oQFbJuNxYMLNP3AuUB0eYxRTE9?=
 =?us-ascii?Q?PgPIpQHXQIGSF0KR7xOefuvt451i9Pa+iH3KqFoKCVojvp0VgvpG09Id8B6X?=
 =?us-ascii?Q?J9NiVgGUEowxrMwyzj1wUYnn+8Igz8oFBA1rh2bP9cIjVDrf36G684wjegi/?=
 =?us-ascii?Q?VvGFUDSfn+xvpuLPbaqbJbojzOr3tpo4ws0YGt3B?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?Kcn0n9z/8a6iv3BY3Qlu06/o/vm57mUtDrsWIVeEYx4ER3WzGgVokaahxgRr?=
 =?us-ascii?Q?yveR6KR1zzvDgpPHa9qubvJMT3sMxK1kPEesMhw+jzWxDvA4uwHt6zEGAnrm?=
 =?us-ascii?Q?Pk3fogDZ3KLL//eD8sEsrdS4lrRWR/wi2Mj70M1O78UL5lCDbwnJz3rTH+p9?=
 =?us-ascii?Q?GV8BFrK+G0r/jmYIRDrqv3nsQzEK3w+U9lHcKXiIScoVsDu5G/CWKLBn6vYr?=
 =?us-ascii?Q?ajS553De9QI46jj/u+Sjg6pL/ERPwYr8WST8/2bzi8xxmUAAlIKY7Z+yCBuk?=
 =?us-ascii?Q?FSsMumwWPKhBrgH5WmEnB5W2Ph8LCoVfxf+Ey0gRJSYagZAPLk/6XuUC9+Mn?=
 =?us-ascii?Q?9AjmBRvglocyWxD1QgzY9maM9KA24Or3bTlToOuBbQMsgCdeL3Qo2gGrh2/5?=
 =?us-ascii?Q?CV8nHlz3a6bHeBmxqE8fk60bCBhhnfFarCirw6XbgvDrf0xoF3ehnM6U05xK?=
 =?us-ascii?Q?5jYipq5uo8egLAbftV6icIQDLLsLh+sR2VohOA+ouTsP0g6PxQptcjkXTH6D?=
 =?us-ascii?Q?v4Zcc6sPc3s3dcWYnKEN7B+BtxGjOlhqHXBUegHCQoTX9Fr+3mfxqy8iSUI5?=
 =?us-ascii?Q?d/GqNzfF2IgOq7IDdf0jXRL7RlSHob6eu9bssbFuOE34Y4tEUHXorMKkeQ0L?=
 =?us-ascii?Q?j7hzWlKTbiV19W/KwvD5EsDd4kgm/xbOt2zwzzpK32DNGiIdX+bpUzDXAq6I?=
 =?us-ascii?Q?i9Fh9RukLEmhunI2Byu1+6kqPaUXyno9SyHow/vWSt4TC3kmrHTYzYd/Add9?=
 =?us-ascii?Q?PoacbsaRZ4QDzhSAZtAWbvc+b2fPyzpHdkErY4+3geGN3542tuQ8UeqK/l9P?=
 =?us-ascii?Q?kGMFdLJ65kjd/f0jTRcwF/ZpxLT0w8ma482ErKOwvKnwJwNSWWDRvIoLG7ET?=
 =?us-ascii?Q?YFNYIZqwHElSKavKTaMSHPIwqsZmGLboCpaqgPT6gT8LHpphefF2d8/CepCi?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c33d3849-d8d3-4c0c-1083-08db8c498313
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2023 13:25:56.4677
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9OX/TJtmhIm3/cyRn6RBlucCEE3S4XcRDxaSJGWw3VSqotirQGEDtbfVEZGTd/7ffa02TJUDu5xUM0ed2hBjvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4406
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-24_10,2023-07-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 adultscore=0
 phishscore=0 mlxlogscore=828 malwarescore=0 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307240119
X-Proofpoint-ORIG-GUID: AILO1Ag43qzme2ifdlpdBRpIoEYKOYJI
X-Proofpoint-GUID: AILO1Ag43qzme2ifdlpdBRpIoEYKOYJI
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Jul 24, 2023 at 02:45:07PM +0800, YueHaibing wrote:
> On 2023/7/24 13:08, NeilBrown wrote:
> > On Sat, 22 Jul 2023, YueHaibing wrote:
> >> Since commit 49b28684fdba ("nfsd: Remove deprecated nfsctl system call and related code.")
> >> these declarations are unused, so can remove it.
> >>
> >> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> > 
> > Thanks.
> > Could you remove the declaration of auth_unix_lookup too?
> > It was removed in that commit, but the declaration is still with us.

Thanks, Neil. I thought there might be one or two others, but none stood
out to me.


> Sure, will do this.

Yue, I can just fold that into the applied patch. No need to send another.


> > Thanks!
> > NeilBrown
> > 
> >> ---
> >>  include/linux/sunrpc/svcauth.h | 2 --
> >>  1 file changed, 2 deletions(-)
> >>
> >> diff --git a/include/linux/sunrpc/svcauth.h b/include/linux/sunrpc/svcauth.h
> >> index 6d9cc9080aca..2402b7ca5d1a 100644
> >> --- a/include/linux/sunrpc/svcauth.h
> >> +++ b/include/linux/sunrpc/svcauth.h
> >> @@ -157,11 +157,9 @@ extern void	svc_auth_unregister(rpc_authflavor_t flavor);
> >>  
> >>  extern struct auth_domain *unix_domain_find(char *name);
> >>  extern void auth_domain_put(struct auth_domain *item);
> >> -extern int auth_unix_add_addr(struct net *net, struct in6_addr *addr, struct auth_domain *dom);
> >>  extern struct auth_domain *auth_domain_lookup(char *name, struct auth_domain *new);
> >>  extern struct auth_domain *auth_domain_find(char *name);
> >>  extern struct auth_domain *auth_unix_lookup(struct net *net, struct in6_addr *addr);
> >> -extern int auth_unix_forget_old(struct auth_domain *dom);
> >>  extern void svcauth_unix_purge(struct net *net);
> >>  extern void svcauth_unix_info_release(struct svc_xprt *xpt);
> >>  extern int svcauth_unix_set_client(struct svc_rqst *rqstp);
> >> -- 
> >> 2.34.1
> >>
> >>
> > 
> > .
> > 

-- 
Chuck Lever
