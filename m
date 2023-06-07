Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE04E726211
	for <lists+linux-nfs@lfdr.de>; Wed,  7 Jun 2023 16:04:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240237AbjFGOED (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 7 Jun 2023 10:04:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235683AbjFGOEC (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 7 Jun 2023 10:04:02 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36E9E1BD6
        for <linux-nfs@vger.kernel.org>; Wed,  7 Jun 2023 07:04:01 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3576JhSm001942;
        Wed, 7 Jun 2023 14:03:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=cqnGrdq3M+Sth6gddmiO4Cc2ylLkDUQuvVgxv9IR2Gg=;
 b=JCaXtIMjHZtWvL4Npmh1IfurIdoGsBCRNrzbrWK+i9sA1LPXltQhZdX9IKkY33q7pnxy
 3FNh/IFxNRF1Ybcqv2HwJXGC++RwGUaBb3dMIg2pIREL0gFQGm+Jqfze47EcT1wY+ZkP
 Fldeiqvo+oced2Pq+U+wYdhmB74UPU+vNMK+Wzz1ggl3Y/gANYOteX6wBqsQAlXzc14V
 pj2h1EAIM9zNpjM8RWCNKPZWVw6+ClMfE5yKNwprJZ+eA6jpeGmE+N0a3jOIYc4RqbyC
 E21VhaZzYRSz8bZ7CfyfOBaAE8mrLDk8egQzIdCRmv4VHsXlFTv0/ycm9D/aMsYZdXVS cA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r2a6u1um4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 07 Jun 2023 14:03:52 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 357ChH1Y036877;
        Wed, 7 Jun 2023 14:03:51 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2048.outbound.protection.outlook.com [104.47.56.48])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3r2a6jskny-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 07 Jun 2023 14:03:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dg8JDTP7ZlYj8sJK3TbF/QH76LiS5NWhWgEuqyMCaJmV6Phe3ebZgbpB8N9U+qz7KXYYvT7CxUkguIcriRAgQuqA3xUKsnpYLxaywNMfOLRZo6SptujIAAcudv20Rf5bPKzVp3kT3mbyMWDaUBw84KXYHUtgwneU6XrismT+0jYSv37fNGouTJ5DEHrUk8/qLF7u5Ksjm1XRjYHieaEk4FQHPwZXo99CQP9kSSFFKBNn76vYwNIZkRoOHpD4HelmO+oACCQkzKxixI3wl1MMS/pvUVdlFnsD90+WIpiAVTXVZ23dx+UTyS6zsY0vQYIIG7EtMTlVZRuIa4P6MFNhVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cqnGrdq3M+Sth6gddmiO4Cc2ylLkDUQuvVgxv9IR2Gg=;
 b=hrNo/J1jsSHwtszYtzo3wE96NwwH4O5+1PC468YOWfeqlKmlkAuywBaZBSYNvxTq2ONWVaqQNBXxNcRqqyzMKSzBRqrtdzOg3h3NjLkPM6sjWKLjVaKZiGhM8oGpwk3/I+hce83ZirztHJvrkjbO/suUHG0PXUuhHHOTbdGb18RhtyWNYeZ7I7PcY3xj0gAxqYk33rHVHUfrrWvrggHrDspLfCANU5+xFMV+vXAkn1H+bcvfTHy5gfwo0sIrLaBa0tEGdwpfA9emin2+1x6ef/CirSUWvXQw2B23LUTE+hUYhZrYBwp6WnYdGk0k+7cg6X9eIPLsFXR7MTNIC9FnMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cqnGrdq3M+Sth6gddmiO4Cc2ylLkDUQuvVgxv9IR2Gg=;
 b=MUczwE2H6WhudNDro5PYc83YhIVSul9I4D0sjVjyMHDba34pmlkKMKdiaSZ70UQmzDkSRnwtG/oT3swAwqxteUEgpWzv2oSv1n7oL6HkNbvytYJc5Zl30qem+Tl/l32C0Q9XsJpyAmO0KAMInFvPHs/BFsbCSsL7xEV7Ket6zWM=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CH3PR10MB7235.namprd10.prod.outlook.com (2603:10b6:610:124::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Wed, 7 Jun
 2023 14:03:49 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ecbd:fc46:2528:36db]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ecbd:fc46:2528:36db%5]) with mapi id 15.20.6455.030; Wed, 7 Jun 2023
 14:03:49 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Dai Ngo <dai.ngo@oracle.com>
CC:     Jeff Layton <jlayton@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 1/1] NFSD: add encoding of op_recall flag for write
 delegation
Thread-Topic: [PATCH 1/1] NFSD: add encoding of op_recall flag for write
 delegation
Thread-Index: AQHZmNBl1jZeoclDdkSsnDrqx8vSea9/YBUA
Date:   Wed, 7 Jun 2023 14:03:49 +0000
Message-ID: <71B00613-DA0E-41DB-BDCF-14F866C73A37@oracle.com>
References: <1686094862-13108-1-git-send-email-dai.ngo@oracle.com>
In-Reply-To: <1686094862-13108-1-git-send-email-dai.ngo@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.600.7)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|CH3PR10MB7235:EE_
x-ms-office365-filtering-correlation-id: b4ac03ad-c16b-4a7d-a148-08db67600469
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HkRU0pa0/epsXSwQK0J+PD/zPUrHXX/1T8lDhizoRhH21fDipArb817W/gkU0DHYzPxoi9XT436KNXUR7WyfOa8nQeuoaS7pEttIb9G28PnzBtirUd8i/4VS70v2axRaPTS/r/Q0aMKPnxWSQ5evaABvg/FEAalGC316siOAWGNjMZ4I1CIuVd21KtvIZgHgRp/8+4oCJy3klX0sqQrTuwtT/HCllFFhAIqH7/miOkFR6jpuRkZw/H5A6QyLU2ru8tIdU7MyYbnXClZ8c8UZ4v9UXnt9zPxsRL78YiL+qHp3wltV87UaVBUzTE/av4JC8S0Vn2OzAum8skcn7uaaqBcm7ooSe9PM+mlx/6LHivxK+pjBU3taHFYLUj95tbnUz8/3i5gAVxioXcsBZ5xWPjPUXjVdiuSuMAWuOaFS8BqXeZ3+MuMO/ji6WswV2vDfpq4wpHAEkMIptCMJBMJDIRHa3vyRXdeIJkJs3rF6gdNc08bSKjpqSqnwq0mjtOV37F5d3V6atG9aVNE599HNTwmotyiq6zGdf3wf3uuP+0NvozEK9GyYckAkIer/mJcW8u4aalDeam2rnsTApfjeErn1IG3roUzToevJFusQXP7T64I5NaWROJELnWlBgUsfLk+9/0xIwz/m0kzaiSjORg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(136003)(396003)(366004)(376002)(39860400002)(451199021)(6862004)(8676002)(478600001)(8936002)(37006003)(54906003)(5660300002)(6486002)(316002)(41300700001)(26005)(186003)(6636002)(76116006)(4326008)(6512007)(66556008)(71200400001)(91956017)(66446008)(66476007)(64756008)(53546011)(66946007)(6506007)(2616005)(83380400001)(2906002)(4744005)(38100700002)(122000001)(86362001)(38070700005)(33656002)(36756003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?J8GAydXK8hGifWVWke4s3JddXh76HezWR9Z0MY6KkCpLlyyWndSUauNBSB3i?=
 =?us-ascii?Q?rX7zcIiySLwD/AGpwHLxUQBBzresbG6KttXVBYhdBrMRF2hU6i2obJXxAJVl?=
 =?us-ascii?Q?XB/6hG1nwFmheRvlWPlGxnrQcuVml3RnJng55UXJ1pJ+AqMzWwf9CJpTphcs?=
 =?us-ascii?Q?rLZVlzLs5Rorwo99zrL/YSwfB6TR34iRemG6f0wFAXf0JT3Ras8VyIL3OrTZ?=
 =?us-ascii?Q?HRdN4KGzwy3rafOgBVu3Op3GgZddbNmun4qdgyYeiK49Wjqm84TzJ7XpQs5d?=
 =?us-ascii?Q?v+CuimKK296PLyIm0HkqTyKxT1vaNUmkNdZB/A/YikGwrG9US3Fku0JXSiTv?=
 =?us-ascii?Q?qLqp2J9a4OmT1Xs9LRfct7LTct3KAI2cYc761q65waZ/16v7FSd8HrYXvLVa?=
 =?us-ascii?Q?x1hfK3o03XcoQ1ZG355vviag8rItVgXJ1Y/ftxc7e4rZZatZatZYcrlyWhPd?=
 =?us-ascii?Q?8rqPZbA+XCWV35R8hk3Atl546lvROQZgcYQkZttj6niRlVkzW7lgymdPnCQ+?=
 =?us-ascii?Q?x5IGGVEqZaB+HMk8cBQ5x7xSLs1GkTaXalH7r7bap+gFGAUuRfK9XYzBlbIb?=
 =?us-ascii?Q?i4Qvf6KnnGqp7S0ePsjWBZqb8wH1KOhvD+Yf9VH7/NKWh1dQYxi+Ckis8RRy?=
 =?us-ascii?Q?WwO85cIGR1OukcmO+hioWIPKUoXMsVPKo6ajBN6hoawjHNUL8jJTIdQN7/f0?=
 =?us-ascii?Q?LLKF7F6wKNQ8v1SI/oYpiuLG1M6hDHh/mC/cqnVOFqkxIcD9RhslBKsM4TTF?=
 =?us-ascii?Q?rGiiLNkOC8AwfyF8KmrKv6TccsQ0QZ6jzdb8R3n9rsucc55wkGBJ4/A7jvEx?=
 =?us-ascii?Q?FRmMv977lkru6i7+ww6a/hQUqPhUjjTQmmv39OMrh62HqKEu0nNBRHk89W1U?=
 =?us-ascii?Q?EUUb80XWmTFmntKFuPqj2RUuestUu6fviqhcSYS08H/bvtiPG1CEXUTObXxU?=
 =?us-ascii?Q?Eg6wByF477nsryV9COfM46fEJA3V8cisI+HMYHvFqjwBbPeF4hG3sDfgQmaP?=
 =?us-ascii?Q?YRc2u1FJqM/H8hjZxPV83xlqWMbNjU44YKtBONaMgw5Ki1a01jD/HYjgyu6/?=
 =?us-ascii?Q?Jy0IFBZyyh4igUMi5a/or1KI2lggbUInPSSAZsl2flSow+2JugoDei9eXmqd?=
 =?us-ascii?Q?16SDf7H20R2DiYRdAJ2dkwJdHMwQ7jlY/IxyuE22MzxlzfUNvX8ie33LKh8h?=
 =?us-ascii?Q?otalCfgqOu4hsinbJfIX47aYQC2pfT1ziB+l7r1JhCscNRVe7qy/P3zVZyXG?=
 =?us-ascii?Q?Sq7J04A6JY94GgPvIaUIW2pYP5MaW7Owe3iRRJQoIKp6oIL17tymSrOxPP9O?=
 =?us-ascii?Q?qU4xxmG8Eqf5aZamJZ0udtJqXW9vY+bNgOm2KAKHkUIz7EZfstaRAAHqSPnD?=
 =?us-ascii?Q?hNB1OvfNTQhqJ7KCCaZ8ILZS2GvLXFhKTm0R7lg7ybNBTlE/TmOS3rtYvdyU?=
 =?us-ascii?Q?pQYRyNP6tz3m7bytt5MtLvntz+bUJWSIkxXlVJlrwM5BDllVdXxVYuZ9Zr2E?=
 =?us-ascii?Q?HUV+3dJy6I3glcJcinkkXPx4INix96flsDlHue0HOLhc08DlEEndV4PLL3Xw?=
 =?us-ascii?Q?pYWWO1WnbZceXsItRKXk21UezIZHydjxyMGbmNBxA69UqHitwVmPI1NPtmkf?=
 =?us-ascii?Q?ZA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D6BC7B3BFEF3984DB2B00364887F4FC4@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 2FRyq8e5VKtBnwnYR0DkEV9QHQUkpR4nLQMlVPP6qIEMiAEPsLKsB68CheLV90U8hkClGM2H/HUZbLfv8441LlpQlGHqj/4rHIMxu9SIAA/hO0oLafjiUfjBfQf8aBkLSAhiWxVAQW3D7zy5VoJG02VTSjc+xZ8QmLthk/kOm96VaeuAuCRclS4Tiuua1kg7bU0fVVILMknpKy9NN3H4mZt/x8SPum5x/ryRmAxU23Y12MSklhqBkVylIDtBjO+ageVV31HfnsoXiaqyxc+cKWfJ9kaXaHGEPJn9czNXuMOX8X+Uu2JtFl9/gv5OZfNRwBcWuMAPkEu3gtH1ihIYShPebmkX6T4AOi2fGr8kica5HCZ/Kx8KMgOl53RHNufXwWIblzSS90ZTJdDHQsMFT59bSmL0yN0qpy2YZ5KM7JLfJbVDkA2VPwY4jlFsvrKaL645hXANOhVhD/4bsT2gNkucF/Lbt/RXqgzwfn2tZt0Hs6p96S2hTZHgyfav7/GuMa2Xl9JKWRTTE0+LeDP+0+wcS8pczPWOGk+2UiIBf4rgVSk062ZhSrePWf4aShLyv30AOtIN6hE0Xs9lb+dZ2g3t0AUUZ9/nwcRLwgUELtZiCenT3bspdurSCvRDMs8CyQn1bwhI9MM4hDAzcrRyZVRV345YTuaTXeWtwx2VD+YQehT5HyDhjZzb42/eL9g5+3FWjI/FjH2IzjdaVv7Bc+L7VtCR0CxKiAUx9fvPSVEDZ6oYRYI53JjnRVo4YpV7DcOACZMX/ycAr02ckM4kfzvMBww82XNGkrtxCMTf9Og=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4ac03ad-c16b-4a7d-a148-08db67600469
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jun 2023 14:03:49.1568
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oYKiuoLyhk541TI2Qu9XUhwclItNFj0PeiUdPWPVZ3tlD7rnT3NXUz2jlKKDADSnFEsuiq47Lq0lkufAhEusdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7235
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-07_07,2023-06-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 suspectscore=0
 mlxscore=0 adultscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306070119
X-Proofpoint-GUID: U17ZblLfvjtK2KtcpYFeTK2qyd7JlDcA
X-Proofpoint-ORIG-GUID: U17ZblLfvjtK2KtcpYFeTK2qyd7JlDcA
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jun 6, 2023, at 7:41 PM, Dai Ngo <dai.ngo@oracle.com> wrote:
>=20
> Modified nfsd4_encode_open to encode the op_recall flag properly
> for OPEN result with write delegation granted.

This appears to have been broken for forever. I can't really nail
down a Fixes: commit, so I will add a Cc: stable.


> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
> ---
> fs/nfsd/nfs4xdr.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
> index 4590b893dbc8..d7e46b940cce 100644
> --- a/fs/nfsd/nfs4xdr.c
> +++ b/fs/nfsd/nfs4xdr.c
> @@ -3975,7 +3975,7 @@ nfsd4_encode_open(struct nfsd4_compoundres *resp, _=
_be32 nfserr,
> p =3D xdr_reserve_space(xdr, 32);
> if (!p)
> return nfserr_resource;
> - *p++ =3D cpu_to_be32(0);
> + *p++ =3D cpu_to_be32(open->op_recall);
>=20
> /*
> * TODO: space_limit's in delegations
> --=20
> 2.9.5
>=20

--
Chuck Lever


