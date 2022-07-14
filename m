Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88FEC5753CF
	for <lists+linux-nfs@lfdr.de>; Thu, 14 Jul 2022 19:15:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240090AbiGNRPH (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 14 Jul 2022 13:15:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239294AbiGNRPG (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 14 Jul 2022 13:15:06 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3527F45998
        for <linux-nfs@vger.kernel.org>; Thu, 14 Jul 2022 10:15:05 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26EGBmUm026608;
        Thu, 14 Jul 2022 17:14:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=0bjjBvRIONeDqD7fer9U2JnHoj1d7NaBfZPVIug7BpA=;
 b=EgrVTh8mfzLRU8MS+zHc+2yYuyn1l8+Nxwnhvj7sj5HrZC0777Yu4yjf9ckINf6Fe3iU
 y3MZdXNv9iqbddKBd5KeOv4COhIngTdGO10now+VBtchqJKJiYRWdUGRJCrfOyOlvyI0
 3bnKHsWYaKBtaiQGwIJz0eSaQcOoW4cyz5z+ysqabkGgexY181KDma5pQI03Fpc8lCOZ
 hJf/1LDfeKhrx56Ci9qwgMpjLBQAqSuQfeVW6xaY8uhNA2ePuIh00cGA90mEsncqiWI7
 XRl6HBF+IrvL09I47fF+Yad8xaQ/RDopUwpwMVNWpkYwA9Fv0yxMhO+z30i960rMNwCR hg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3h71r1dc3t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Jul 2022 17:14:59 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 26EHAjli021297;
        Thu, 14 Jul 2022 17:14:58 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3h7046hrkr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Jul 2022 17:14:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yqax8OvXpaG+w4gKEe9Wr14Tt5DqlfOc7DkAnvZYXsNpAwpB/ZT6EqpCw1qzayE21b8kxdQMgU5PkjOMnw4gs7WkJ+8rPckn056k8AmfIJ8oUXAtUCQCsdtEJFsPkt8qAfrr4dB51yVORn6BTtFE+4ma4G552LlXRBQ7rKpQ66hiGReCwtw45wg81e6XlDmHY3k8w08UrqQb3PR03SGvBl6JlqB7Ve89YT4BisJSp8IB/cTu6akeQ+0+BcdC0YHTU3zBdwhzNwRDF4WXLY7a3pdAR+3NlJ8GR2uQXJBR2S9XrJJ/MePyn7RQsj/CzVqE9b81zV2jU487Ls5etz73Uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0bjjBvRIONeDqD7fer9U2JnHoj1d7NaBfZPVIug7BpA=;
 b=dx+vOYd/W7hbxcUNgDB7UqLTWQc8A+XTlxuKEqCVdhHO5k4YYVwwCKxdfIFx91u1i9EbwTPFyBGUBdg/AWbEl8uCN7l/ms/83ypcmVV+WRZzoIFJYeRkd56uCsrnW9wQc1kEutU2ORcVULgK+P35H5otMCR/sgaCOd1g517VeyLVxU6P7c/68UZhtvkqAxADQEkpodhvt3LTKAiCqvkG5+NgoxVzGnepsA+/oUwBovwZz4Pb7WCmatJx5KDW7jCcI2OuZt7odFgZog7rdF3Oz4NlfZeJymyFXSIsxj5m4YQTGK5DjAIo3BS/m0fPSdc/PirumHIAYdySTvqBhpqRlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0bjjBvRIONeDqD7fer9U2JnHoj1d7NaBfZPVIug7BpA=;
 b=pPoujFoGzErUZpUt4Vo1c2/eKU7HgffmrZ1NFbaaFn3Kh1sHMBdJ5V4PgiKl+B/3BmtHbbQP4f1Z7+fSUkLci6PMuEomBgM8QnHcQcxR7+MZyx8fXy3Ci4qtZbYCkODTpveNU4dyGDShVAViSpJYImxjVNCgWe1GLmumwwYKSOE=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CO1PR10MB4483.namprd10.prod.outlook.com (2603:10b6:303:98::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.14; Thu, 14 Jul
 2022 17:14:55 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::8cc6:21c7:b3e7:5da6]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::8cc6:21c7:b3e7:5da6%7]) with mapi id 15.20.5438.015; Thu, 14 Jul 2022
 17:14:55 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jeff Layton <jlayton@kernel.org>
CC:     Neil Brown <neilb@suse.de>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [RFC PATCH 2/3] nfsd: rework arguments to nfs4_set_delegation
Thread-Topic: [RFC PATCH 2/3] nfsd: rework arguments to nfs4_set_delegation
Thread-Index: AQHYl5ZdeROx4s5Ma02JTduV4JOwj61+E5GAgAAG9ACAAADHgA==
Date:   Thu, 14 Jul 2022 17:14:55 +0000
Message-ID: <E8CCB7EF-242C-4530-96E2-ACC7B5CB3163@oracle.com>
References: <20220714152819.128276-1-jlayton@kernel.org>
 <20220714152819.128276-3-jlayton@kernel.org>
 <CDD9B96C-3CFC-4BA5-A71C-6C2BFAC2B227@oracle.com>
 <476892362c94debad589af79ff7d6766f5ca8c85.camel@kernel.org>
In-Reply-To: <476892362c94debad589af79ff7d6766f5ca8c85.camel@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.100.31)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1a8dea1d-de2c-4799-5921-08da65bc5f9e
x-ms-traffictypediagnostic: CO1PR10MB4483:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1SPBKHU8WmIbRU5w247yyeNKI+Rzwqhd0NQcwXHvtMgnKaZ3hQXRGpy+EVDllaSXqfRpFIjvfXM9yKrL0NQ1yEH+Bdp93FOZ+4CgmvWqwZDfCuexR+11Mr4FVyc0pNFxCCg4IXD2ChnPAb34g/6y5JnrtcV5LbL6bhbe0COs8LxHXi29+gBCDgRJQBqNt0lt9w08wsXDvJTN1NBumusJhz6PMbWm+Zd2XDB3RPf+v1Ac+zm5aEr10fYDP4173rI/jSqgAt0ieeUP5AulDd/T9Th4ttRkHsqAoOUAn2En2yvIUy0NZk+CMCJhB5ZP/rrlWo2OvTnrIGckgOdEDeznrnM/aSfPMq0jzas8nkKRuOp5XJBP/o1dWLxq8Ao49jzUm2BM6gr6OFVyOJsO2XTsIPpTWH26HHb5nBY8HMzpifrXOui3+BNSdSKA1/y+RcbadiLGCxkRPame9B5LrjJv6gLtUzBlc11apZPY5bZQ29/FXjWj1QPim9DCTOgEJ5ntrztqtRJj/iuNuGwD7sdqih7dCcXluIxh2gsza1zaJm92xLud3W24JSpnxuN5dwYnSgiG8Vi5N0QioPg3Y7C3g2W/pP/Nh125QricHJbT/gs8schjgKN6bn0jCXdohIP5zfCm0Q4mLxeT4943twxO/ToK49IpwTeVuVol1lgrAC3oTE57fgcWr+nQhDw8c5TRLYIm4P11HIhEUNMEClSX8lFL4/Y6RUS+Tl04w5juir1ck9nzXBiWJaTH+BbZSLzvU/m6MPR72TrdhFwHXDXiwozAUvgxCw7iY0nkzlX92Wwe3v56f5a6AXhgt7+rWfRxSMtowP2kerdi25El/Rry0qtP8uUrBtDXrZTBsKXbkWU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(39860400002)(376002)(396003)(366004)(136003)(71200400001)(4326008)(8676002)(64756008)(478600001)(6486002)(5660300002)(36756003)(76116006)(66946007)(91956017)(316002)(6916009)(54906003)(41300700001)(8936002)(66446008)(66476007)(66556008)(6512007)(2906002)(2616005)(33656002)(26005)(186003)(53546011)(38070700005)(122000001)(86362001)(83380400001)(6506007)(38100700002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?O0eifyy7IIDsUWalpt2hn5jMMgBoexXg3cmibrXHtgVPUuM5X7Fb9+tz6KkK?=
 =?us-ascii?Q?fTa5/r73LLEabEylWYDdjcOKWKD4Ko24dkxA8TVz8jfkEXLRq7G1oZ3xQnpS?=
 =?us-ascii?Q?Xj3YZWwJDsa+YKxrcpF+xbhbhTySkI7yJMeI6Qb3WCyoUyPUc2hSVkAe1QEM?=
 =?us-ascii?Q?Hun9CsQ6rbMT3oE/FOdVw7dkNdXJnKgoV/X9tnkakXO/EHfRDlKZJhX4Z3jH?=
 =?us-ascii?Q?ot71Bdr+9lTYMJoWQgiD3zAYtNGvsMSBmwTPB6AQ53Fi52mK9EPuL6FtHV/C?=
 =?us-ascii?Q?RGdho38QXu74OX/BI9WlI9HCm2kpxWlHT/MlA8ATWCnYBrTFRORvckogRaX8?=
 =?us-ascii?Q?0uGPMZ8dOckJn3DEUi2Hv+j5mS37IGqRV0JNXM2wFlNDbym0rm3JNwfIPTXh?=
 =?us-ascii?Q?/U0IqhX39W+yj4kTS8cEH9V4krJO3P57TLevvK7RBzgB75d97MIWfYLgCUqD?=
 =?us-ascii?Q?S9yPieaL/zpJ4RKBWkox9fKMC37fj8jmwlSUs+ZynPDS3amZThQebM1+G293?=
 =?us-ascii?Q?vwxPoqktcuzECU7fvjeYwJJYs65/snrD6m1Gh7Jxvt6iTkOgrnt2oTtiwPLH?=
 =?us-ascii?Q?8Sd+9T4hpHWRnC73wh9C0icrw9DIK5SbRUtAGIYzmWJsF/uvg3qh+8b5f+/k?=
 =?us-ascii?Q?rCustUn8Vi3jTvXAaZFwr5wbk0RTCHlyctEFUfM0Hme9P1CimeW/sdduY4VE?=
 =?us-ascii?Q?0aTzOrgNi/Jyjs2Q3o/vLBZsGMZmbfkJkFrPKUeD4p8mazpwbznH4VHzajWp?=
 =?us-ascii?Q?o1Wa6p5PgMynq86+RltNd0S+ze0/tEoji5FDG7KqO8DZKsy7FUnkdcMfTxGl?=
 =?us-ascii?Q?qqMbLTPSgTuLSVJVgpwqxgyqTE4ktwGhpUXgF5AMZyLK5dEaZWIuPeiy/646?=
 =?us-ascii?Q?QBbDSl5lCfwGAwzuYRPp3R7yH7gg98kV9D5qwEEFub//x+Lc8WP1j0skK0bn?=
 =?us-ascii?Q?OGyoD0fd23FdDWknIpUPEyoOewW47VYqsKy0Br32Q+AIqmZ3+lpqHNLQ+v0y?=
 =?us-ascii?Q?xMi5IrbVDX7ircrxq7bBeIldLhjO9jNIHogBIpYqpl4BnJKbzG88Aj/bWSCU?=
 =?us-ascii?Q?+xrqOJ96aF2BgAnx+/uInoAotPW7Rq/dxbf09yj54d9UUx4ZbN+CilXIOYDR?=
 =?us-ascii?Q?VcRlLNejR2ZmWGji2BenPl/BjECm8XXMVhkpSixePVIqDT/Zb6yR7scbLfwd?=
 =?us-ascii?Q?opCkFYjmJataHEKkJKcUC1hCL+X1x6OiW3POBwRC2ubbHmoH3GQXyL3XYyWc?=
 =?us-ascii?Q?yXdBUtjQ7nfT7vkpfsUTDijWH5IlGMT1SsWTsSmwZJzBd0peHJpngdlb0o1r?=
 =?us-ascii?Q?vj5+i3h5bM6t1jWNKm7cEUHkI9WeQ6672/c1TpPFUpC/E85LgTE1BNksxQWA?=
 =?us-ascii?Q?0DqXPNhrBkeOGsCkyY911Frd+CbFK+DCy9imKHq0yKq1zLuw7LUGQ1QNae4Z?=
 =?us-ascii?Q?lqGwT0qntwBMbbzxBpYIv4hSt5b/VJrH7QHpPAy0/1RON40A+AuAP5UGpNbo?=
 =?us-ascii?Q?1BYSkK3CNYLBrjKD/xt49sVOEN9D2qIyNkMwezMo8pbcMt7pyoWn5/Hc3/jB?=
 =?us-ascii?Q?WuxkI3n7TOhjhatj5pvNxqERPfBJwFVFz2w8yHJ7MWNRJiVLNqmBcWxwWjgM?=
 =?us-ascii?Q?Ew=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <68B15DCDA23EAC4082FEE717C5BF04E5@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a8dea1d-de2c-4799-5921-08da65bc5f9e
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2022 17:14:55.8504
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tZ8xiHa1GvD8vURMrcVxKlnbd5W0jwK4xpM64hMR2qaKkZ/t2Se7fFZ81OtixY9+uSbrz0zpMEC/48BWv1A2jQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4483
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-07-14_14:2022-07-14,2022-07-14 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 malwarescore=0 suspectscore=0 mlxscore=0 spamscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207140075
X-Proofpoint-ORIG-GUID: WtDweXI3Yo9mDTWKKsCnPpR6jfJtLB9g
X-Proofpoint-GUID: WtDweXI3Yo9mDTWKKsCnPpR6jfJtLB9g
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

=20

> On Jul 14, 2022, at 1:12 PM, Jeff Layton <jlayton@kernel.org> wrote:
>=20
> On Thu, 2022-07-14 at 16:47 +0000, Chuck Lever III wrote:
>>=20
>>> On Jul 14, 2022, at 11:28 AM, Jeff Layton <jlayton@kernel.org> wrote:
>>>=20
>>> We'll need the nfs4_open to vet the filename. Change nfs4_set_delegatio=
n
>>> to take the same arguments are nfs4_open_delegation.
>>=20
>> ^are^as
>>=20
>> Nit: Considering that in the next patch you change the synopsis of
>> nfs4_open_delegation again but not nfs4_set_delegation, this
>> description causes a little whiplash.
>>=20
>>=20
>=20
> Yeah, I should have squashed a couple of those together. I _did_ say it
> was an RFC. I can resend a cleaned-up version later if you want to take
> this in.

I'm interested in Neil's thoughts about this approach, but I'm
willing to run with it unless test results show a regression.


>>> Signed-off-by: Jeff Layton <jlayton@kernel.org>
>>> ---
>>> fs/nfsd/nfs4state.c | 8 +++++---
>>> 1 file changed, 5 insertions(+), 3 deletions(-)
>>>=20
>>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
>>> index 4f81c0bbd27b..347794028c98 100644
>>> --- a/fs/nfsd/nfs4state.c
>>> +++ b/fs/nfsd/nfs4state.c
>>> @@ -5260,10 +5260,12 @@ static int nfsd4_check_conflicting_opens(struct=
 nfs4_client *clp,
>>> }
>>>=20
>>> static struct nfs4_delegation *
>>> -nfs4_set_delegation(struct nfs4_client *clp,
>>> -		 struct nfs4_file *fp, struct nfs4_clnt_odstate *odstate)
>>> +nfs4_set_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *s=
tp)
>>> {
>>> 	int status =3D 0;
>>> +	struct nfs4_client *clp =3D stp->st_stid.sc_client;
>>> +	struct nfs4_file *fp =3D stp->st_stid.sc_file;
>>> +	struct nfs4_clnt_odstate *odstate =3D stp->st_clnt_odstate;
>>> 	struct nfs4_delegation *dp;
>>> 	struct nfsd_file *nf;
>>> 	struct file_lock *fl;
>>> @@ -5405,7 +5407,7 @@ nfs4_open_delegation(struct nfsd4_open *open, str=
uct nfs4_ol_stateid *stp)
>>> 		default:
>>> 			goto out_no_deleg;
>>> 	}
>>> -	dp =3D nfs4_set_delegation(clp, stp->st_stid.sc_file, stp->st_clnt_od=
state);
>>> +	dp =3D nfs4_set_delegation(open, stp);
>>> 	if (IS_ERR(dp))
>>> 		goto out_no_deleg;
>>>=20
>>> --=20
>>> 2.36.1
>>>=20
>>=20
>> --
>> Chuck Lever
>>=20
>>=20
>>=20
>=20
> --=20
> Jeff Layton <jlayton@kernel.org>

--
Chuck Lever



