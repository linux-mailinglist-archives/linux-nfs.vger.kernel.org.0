Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D19265AA05C
	for <lists+linux-nfs@lfdr.de>; Thu,  1 Sep 2022 21:47:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233374AbiIATr0 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 1 Sep 2022 15:47:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234379AbiIATrY (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 1 Sep 2022 15:47:24 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A33498D16
        for <linux-nfs@vger.kernel.org>; Thu,  1 Sep 2022 12:47:23 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 281HJPPS011776;
        Thu, 1 Sep 2022 19:47:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=XeI0pnuzfU0IGFeBdQzrjvrpaUtQ/tD5g7QqS1GVyU0=;
 b=h6cCEolX4t4Ww9xFvP90gu9EYx2AB8mlCHNkSQVqsqrD9RmjfbV/u0ZgrOuSbXdc3BTT
 yvofySvkPkONqhGooZG73K/lOb37c79SXxnDc90tLz106RlgJ4HP+nIBRtSdol+F1fUx
 biUVl5h62Aq86UopZPi0s62GC2saIL9J9uil+GJ+d+/EdSDchF1+2/NjVLgNrvB9YfzJ
 KB52iNHOYLL7P/dFpECyc87dv9dld77kMINOwcxITioDHUYnZz10GzRQvhT9byDuu5d4
 8A7u00kQ5LckhH1lOqVzzvHlbkYkrXab5FL7lE4jB723gQ5dcGXPKCqxFA+qOBySD8Tw UA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j7avsnbh2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 01 Sep 2022 19:47:19 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 281IZv4d002187;
        Thu, 1 Sep 2022 19:47:18 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2105.outbound.protection.outlook.com [104.47.70.105])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3j79q6wgh8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 01 Sep 2022 19:47:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JpkDyPT9UnxVbHMluGoafk/ZiibPK99U2FTa8NTIRskbl/mkSA9Z7dDwMMFGl8ffn7tcfC4+bskkzrlNRxdWEpymeLJ9oNmJnvFrdKyKLWWLROzGYpRA0ZsM1GmLtjslamrFcuK8PkblVVHvkVFhmQOGTn1EwUjxc+I4z938nx6rl50e4BeOA5EiLQwU/wXB4dnxByih2vvmdOQpWGpwNF+tSu6LZzzaxeJBWUkmY3g9leyq2YYXhQROxD68RPxeEY6hXWnuNhVDC/131Hje3HiRSaCkljtotiUP29gKZYkNkX81NTIHgcM45R43rRtAHyVG++qSUIsR+0kAQgkkSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XeI0pnuzfU0IGFeBdQzrjvrpaUtQ/tD5g7QqS1GVyU0=;
 b=P52adXS1w6tRVE0sTnGWHOryHkIuuOTSOsIXIhaA5tQKy0cgLo+3yx/uO0e7h6Lwe4L0uKbXhL2DJsLLGJvnUuXZMciNf1pVpjdICplBqOoKWAlQ1mS7krSNqx3NnP4+sIeZlxnSBePsy9zkQv8dnT5PnFIJWpirGb3vC5gqdB/UN9+mUws6lI3rxTiC+jBH3ZfD5gROFdqe+eUIMIQjNFI0yHDnpVueVPSB1YMvqQ0MIiwVYorQK2K8ZZB2pd5cVxr9lOieGbQrprrrwiSdMGq8XliOciMHy+3wB/FaAkhSNu8urx3ID5gqUHY5iINWePDPLJ5ZH20w+vrUnI4xEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XeI0pnuzfU0IGFeBdQzrjvrpaUtQ/tD5g7QqS1GVyU0=;
 b=Q1vNDpwk4U+YZ/BY5i/zwTLmPWTlETiVGuMzzT4s4ykYeYTFyV6Z6LE5J+aKSfKQkMByP+fmrMTMaxoHbYz+uQXr4TLZsvBiau/PqjtTNy40C+bPqOewvAsgKkthm1PtanXUsqxjsCvf7EqBDX4sYxAiBAuOZ7e1chb2kCivtq4=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CO1PR10MB4724.namprd10.prod.outlook.com (2603:10b6:303:96::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Thu, 1 Sep
 2022 19:47:16 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::25d6:da15:34d:92fa]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::25d6:da15:34d:92fa%4]) with mapi id 15.20.5588.012; Thu, 1 Sep 2022
 19:47:16 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Anna Schumaker <anna@kernel.org>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 1/1] NFSD: Simplify READ_PLUS
Thread-Topic: [PATCH 1/1] NFSD: Simplify READ_PLUS
Thread-Index: AQHYvjFg3/EVQxaYQEaaRJDN+HcN9q3K70kAgAAK4ACAAAC5gA==
Date:   Thu, 1 Sep 2022 19:47:16 +0000
Message-ID: <B210E435-39C9-428B-B96E-9DE0A5C88591@oracle.com>
References: <20220901183341.1543827-1-anna@kernel.org>
 <20220901183341.1543827-2-anna@kernel.org>
 <D0E7F490-7459-48EF-8D74-99BEEF349444@oracle.com>
 <CAFX2Jfn9t14pSCrdaxe1N12Qk+gS9vfqubh64wwjWVmwRyhY_A@mail.gmail.com>
In-Reply-To: <CAFX2Jfn9t14pSCrdaxe1N12Qk+gS9vfqubh64wwjWVmwRyhY_A@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 86c9ae5f-415f-4fcd-17bb-08da8c52c5d3
x-ms-traffictypediagnostic: CO1PR10MB4724:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: A87O26MWqZDgeJvdqex5AWzD+3YBFGTwcmOOxv8FQ/wU7RrIzbVLCQzLPvwZZ/deAXF6oFwOrVime7DSaROt64oelWSafUIqVV8Jl1MwFkiVUzFcMDdCo6CDfNnftULM1dU9UUyRzR5P/TjL4vQjy5mlwwxUb8ABkFw/8w2wDxn0t6Z1fosaRD/8ep+3XV5oEkwAB5/gGCOaEuAFMd5hOS2zN7hj+dgmHEG9e/e4UeF3XFfCCaQrcCwXLMXzZnKbcnUuPp7iHxsYZMw6m+q71PqsLLy1T6cNqesGhLINHxhKF0hBYyhDJ+O001r3e1oXMg3bUzd4dpMcYTizOohlkmHILbD+1MMEn96UMOtyh/DtQkmUHI/H03hX5egZxjh8/HMoTwhAHkVK06VHP19BO0sVh/xWE13j8kOTv8mZ8ynzTvmCtTZJQI49d6WkE5bm8W72iIR7/4splW2mCKId31ws4AywRgg9yTbweVd9pK2ZvGCa2blzNCnnfKP29OwGTdT8oucqfPCOtcqDXm0dTvR4914JITNybe0WnQF4hEMABf0w51ULY+wwlNhI9mRF7MMT9YE3A2Te6iW+NrAR6ZAW+1huaOMIJWS3N5eXbDateuxnF86CdqonqGan1oDD9qjIX9x5XsB0VpPjOkFON3YvgR5kMwpnIpZdePQqTgxD2PR7GK3df2UGsVaCdc/0w64D3JrBU+ohkIyqkflOn4qO3qWh/7Q/qZBKa5zNWGKXmzDkjinuzWk2vL9m3M9rw1iFGaScD+nr0avjxNEhnG28fRRZxeawRO5mP2sM3gc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(366004)(136003)(39860400002)(346002)(376002)(91956017)(2906002)(6486002)(478600001)(76116006)(26005)(186003)(8936002)(33656002)(8676002)(66446008)(66476007)(66946007)(6512007)(41300700001)(4326008)(64756008)(83380400001)(38070700005)(2616005)(66556008)(5660300002)(122000001)(38100700002)(6506007)(53546011)(316002)(6916009)(36756003)(86362001)(71200400001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Bz7B+aVYo/pCrfrPu7haH0etQiaFsURKCeXWD4HarvGuZpfmtaVJxYMaj2Ki?=
 =?us-ascii?Q?XiWFs6wfiNN1lfphDvyRUvwIAog5UnWGwzQG7UudbUCoEu6ZqsWtuxixf0Ow?=
 =?us-ascii?Q?e1jujQWFtI+2GO4VwCjTP1FQSFhuK6Aupdl/x/W0IN2SKb9PztNtDbAyX6Mg?=
 =?us-ascii?Q?C5UqPWcErCOSkPbqgxwmNIFuhl5fSdQKth5w0fYAW69yLxDqtSfKvVtn/7DP?=
 =?us-ascii?Q?vEIq0f6DYz6gLyGcrjh9B8FR3ADiD9Nqruv4TcGd0GB5hXs0DygAbr6XMtAl?=
 =?us-ascii?Q?IvopPqke3TUv4T+QbCUhpW4Ro1b/M5AaSFMITx8CmGlkQ0xO2aQ4ytF4+l3p?=
 =?us-ascii?Q?UuE+ZEya9ul1CcP0EFJB9AhBwq+1y4HCQH6iGZ55Ouj38df+EoG0NIITulRO?=
 =?us-ascii?Q?PyMTFHM8ycmAFTPzeox8s2kU/oPqjBJOTczzSyIr1M9jA2RMm6DHM4yGyQDU?=
 =?us-ascii?Q?Sf5nXIHQ1JFF3Z0RR8Co5HxLHfkSrDrciHlSUz6o7smIQXNvZLDoXYGhuQEw?=
 =?us-ascii?Q?DP3kbSW7cIyfME4AIRWrYCD2+QTCzW51uWjlnP5rbnW6uhwSEqcxKDIWpkwn?=
 =?us-ascii?Q?OzyOM3j99w/lJWXokROBecyvoCCFjqN2mB8x4mtDfZZ+sYdEjFDUOfR2XKPV?=
 =?us-ascii?Q?z7HzR8mmHWUlxacFCb6SOuDYAYaxpE8DO60AMo11rtu2S63atFAlkXfgqcCj?=
 =?us-ascii?Q?LX2eOpIRwk19vLMwPRBtut4hgT3p0OYW7seoxmvEH8WV9dwbmiz7y7tUjD45?=
 =?us-ascii?Q?A0T/BOnDhjDb2RN3IbAMTcPpZV3/Ge+pXIHop6QxDSF5dmlBYqjzmZeWlPCT?=
 =?us-ascii?Q?ay27uIiy7RUCCTxTAQsOzWsj0gPLRTsF/ahf+C8k7a/OmL3MZsVdJ5UgOMU/?=
 =?us-ascii?Q?/7D5msaAdz+bdYvS10wRAsMNdlUf04rnjTaynRiCGXEiYoPX+hRcFSSdBOdD?=
 =?us-ascii?Q?nGVeinTeaRDrss8F29YmOvyHQyNvxXumnsGo7uAGucvQjMzS9Ss6eLWO7830?=
 =?us-ascii?Q?1Uk4vWYNj2BACbhTMHvano7wsi5RN6NjyfVZXwa4o9A+FJ5XNQqojWuT6roo?=
 =?us-ascii?Q?WCSodL4UqyhZnTdiSl4sAnoIBIehZprBDpmYPWGWl3SKwkTWoQ35tqXWRvCZ?=
 =?us-ascii?Q?RGCuGsDGwSGonIYaZiCBJ4Pn/68/zljd9pfVz67ZVqJYINNyHaY3aigsMfGs?=
 =?us-ascii?Q?OaWkjSqkdHQmAEAgtZ65G4lEdVzWOOTgrjiAhU94dTGropF+Veab2HdMCWAl?=
 =?us-ascii?Q?QywKIIzq6mxA1JnqmP3ovnLLoqEOIi8VyUplMnog5ID8tK9VW40ltlnBx0nb?=
 =?us-ascii?Q?XbVSCLeg34aEUgo8DTuqkH7QYdt/lc9ywNX+haGvSfaUIQBqGp1Wu3KwYrfP?=
 =?us-ascii?Q?48PnhgRoDdjzNjez1MUY52CpAlGeaxdQ7Hq+INxJTJTYhDXNYG0hYufrdCAL?=
 =?us-ascii?Q?fJVdDP4nWR27Ey1sbgmFBsIELXd8wb/GYmuydfRPE/a2cboEMs/Muy65o9V1?=
 =?us-ascii?Q?vjIKc8V6ah8TaALeAqY7CfiDmarNWyejm8kLIYDh/dpofUAsxZDAoT/RQZsO?=
 =?us-ascii?Q?AFfbA1IoLp+rCU5cOC6ohGv9SM0FB9Uxv/pEz8HzaYRvkJPVd6v6E/wV8rv6?=
 =?us-ascii?Q?xg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <5DD7FCE1EF90C64087072F3E0D90B236@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86c9ae5f-415f-4fcd-17bb-08da8c52c5d3
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2022 19:47:16.0185
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rqKDesyjXgeHlvgcjlWgtDIxiQ9inrLENRmH/k055fxLy4I65XtrFdNOAFsxzw62t4gLLk1/+nNYE+EaRudOwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4724
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-09-01_12,2022-08-31_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 suspectscore=0 adultscore=0 bulkscore=0 mlxscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2209010086
X-Proofpoint-GUID: a5ZRVWlW9-oSpWkq00cMxdhY14ENwyFX
X-Proofpoint-ORIG-GUID: a5ZRVWlW9-oSpWkq00cMxdhY14ENwyFX
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Sep 1, 2022, at 3:44 PM, Anna Schumaker <anna@kernel.org> wrote:
>=20
> On Thu, Sep 1, 2022 at 3:05 PM Chuck Lever III <chuck.lever@oracle.com> w=
rote:
>>=20
>> Good to see this! I'll study it over the next few days.
>>=20
>>=20
>>> On Sep 1, 2022, at 2:33 PM, Anna Schumaker <anna@kernel.org> wrote:
>>>=20
>>> From: Anna Schumaker <Anna.Schumaker@Netapp.com>
>>>=20
>>> Change the implementation to return a single DATA segment covering the
>>> requested read range.
>>=20
>> The discussion in your cover letter should go in this patch
>> description. A good patch description explains "why"; the diff
>> below already explains "what".
>>=20
>> I harp on that because the patch description is important
>> information that I often consult when conducting archaeology
>> during troubleshooting. "Why the f... did we do that?"
>=20
> Makes sense! Do you want me to resubmit now as a v2 with some of this
> moved over to the patch description?

Let me have a careful look at the diff -- give me a couple days --
so you can incorporate any review comments in v2.

Also I'll try to answer the splice question you posed in 0/1.


> Anna
>>=20
>>=20
>>> Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
>>> ---
>>> fs/nfsd/nfs4xdr.c | 122 ++++++++--------------------------------------
>>> 1 file changed, 20 insertions(+), 102 deletions(-)
>>>=20
>>> diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
>>> index 1e9690a061ec..adbff7737c14 100644
>>> --- a/fs/nfsd/nfs4xdr.c
>>> +++ b/fs/nfsd/nfs4xdr.c
>>> @@ -4731,79 +4731,30 @@ nfsd4_encode_offload_status(struct nfsd4_compou=
ndres *resp, __be32 nfserr,
>>>=20
>>> static __be32
>>> nfsd4_encode_read_plus_data(struct nfsd4_compoundres *resp,
>>> -                         struct nfsd4_read *read,
>>> -                         unsigned long *maxcount, u32 *eof,
>>> -                         loff_t *pos)
>>> +                         struct nfsd4_read *read)
>>> {
>>> +     unsigned long maxcount;
>>>      struct xdr_stream *xdr =3D resp->xdr;
>>>      struct file *file =3D read->rd_nf->nf_file;
>>> -     int starting_len =3D xdr->buf->len;
>>> -     loff_t hole_pos;
>>>      __be32 nfserr;
>>> -     __be32 *p, tmp;
>>> -     __be64 tmp64;
>>> -
>>> -     hole_pos =3D pos ? *pos : vfs_llseek(file, read->rd_offset, SEEK_=
HOLE);
>>> -     if (hole_pos > read->rd_offset)
>>> -             *maxcount =3D min_t(unsigned long, *maxcount, hole_pos - =
read->rd_offset);
>>> -     *maxcount =3D min_t(unsigned long, *maxcount, (xdr->buf->buflen -=
 xdr->buf->len));
>>> +     __be32 *p;
>>>=20
>>>      /* Content type, offset, byte count */
>>>      p =3D xdr_reserve_space(xdr, 4 + 8 + 4);
>>>      if (!p)
>>>              return nfserr_resource;
>>>=20
>>> -     read->rd_vlen =3D xdr_reserve_space_vec(xdr, resp->rqstp->rq_vec,=
 *maxcount);
>>> -     if (read->rd_vlen < 0)
>>> -             return nfserr_resource;
>>> +     maxcount =3D min_t(unsigned long, read->rd_length,
>>> +                      (xdr->buf->buflen - xdr->buf->len));
>>>=20
>>> -     nfserr =3D nfsd_readv(resp->rqstp, read->rd_fhp, file, read->rd_o=
ffset,
>>> -                         resp->rqstp->rq_vec, read->rd_vlen, maxcount,=
 eof);
>>> +     nfserr =3D nfsd4_encode_readv(resp, read, file, maxcount);
>>>      if (nfserr)
>>>              return nfserr;
>>> -     xdr_truncate_encode(xdr, starting_len + 16 + xdr_align_size(*maxc=
ount));
>>>=20
>>> -     tmp =3D htonl(NFS4_CONTENT_DATA);
>>> -     write_bytes_to_xdr_buf(xdr->buf, starting_len,      &tmp,   4);
>>> -     tmp64 =3D cpu_to_be64(read->rd_offset);
>>> -     write_bytes_to_xdr_buf(xdr->buf, starting_len + 4,  &tmp64, 8);
>>> -     tmp =3D htonl(*maxcount);
>>> -     write_bytes_to_xdr_buf(xdr->buf, starting_len + 12, &tmp,   4);
>>> -
>>> -     tmp =3D xdr_zero;
>>> -     write_bytes_to_xdr_buf(xdr->buf, starting_len + 16 + *maxcount, &=
tmp,
>>> -                            xdr_pad_size(*maxcount));
>>> -     return nfs_ok;
>>> -}
>>> -
>>> -static __be32
>>> -nfsd4_encode_read_plus_hole(struct nfsd4_compoundres *resp,
>>> -                         struct nfsd4_read *read,
>>> -                         unsigned long *maxcount, u32 *eof)
>>> -{
>>> -     struct file *file =3D read->rd_nf->nf_file;
>>> -     loff_t data_pos =3D vfs_llseek(file, read->rd_offset, SEEK_DATA);
>>> -     loff_t f_size =3D i_size_read(file_inode(file));
>>> -     unsigned long count;
>>> -     __be32 *p;
>>> -
>>> -     if (data_pos =3D=3D -ENXIO)
>>> -             data_pos =3D f_size;
>>> -     else if (data_pos <=3D read->rd_offset || (data_pos < f_size && d=
ata_pos % PAGE_SIZE))
>>> -             return nfsd4_encode_read_plus_data(resp, read, maxcount, =
eof, &f_size);
>>> -     count =3D data_pos - read->rd_offset;
>>> -
>>> -     /* Content type, offset, byte count */
>>> -     p =3D xdr_reserve_space(resp->xdr, 4 + 8 + 8);
>>> -     if (!p)
>>> -             return nfserr_resource;
>>> -
>>> -     *p++ =3D htonl(NFS4_CONTENT_HOLE);
>>> +     *p++ =3D cpu_to_be32(NFS4_CONTENT_DATA);
>>>      p =3D xdr_encode_hyper(p, read->rd_offset);
>>> -     p =3D xdr_encode_hyper(p, count);
>>> +     *p =3D cpu_to_be32(read->rd_length);
>>>=20
>>> -     *eof =3D (read->rd_offset + count) >=3D f_size;
>>> -     *maxcount =3D min_t(unsigned long, count, *maxcount);
>>>      return nfs_ok;
>>> }
>>>=20
>>> @@ -4811,20 +4762,14 @@ static __be32
>>> nfsd4_encode_read_plus(struct nfsd4_compoundres *resp, __be32 nfserr,
>>>                     struct nfsd4_read *read)
>>> {
>>> -     unsigned long maxcount, count;
>>>      struct xdr_stream *xdr =3D resp->xdr;
>>> -     struct file *file;
>>> +     struct file *file =3D read->rd_nf->nf_file;
>>>      int starting_len =3D xdr->buf->len;
>>> -     int last_segment =3D xdr->buf->len;
>>>      int segments =3D 0;
>>> -     __be32 *p, tmp;
>>> -     bool is_data;
>>> -     loff_t pos;
>>> -     u32 eof;
>>> +     __be32 *p;
>>>=20
>>>      if (nfserr)
>>>              return nfserr;
>>> -     file =3D read->rd_nf->nf_file;
>>>=20
>>>      /* eof flag, segment count */
>>>      p =3D xdr_reserve_space(xdr, 4 + 4);
>>> @@ -4832,48 +4777,21 @@ nfsd4_encode_read_plus(struct nfsd4_compoundres=
 *resp, __be32 nfserr,
>>>              return nfserr_resource;
>>>      xdr_commit_encode(xdr);
>>>=20
>>> -     maxcount =3D min_t(unsigned long, read->rd_length,
>>> -                      (xdr->buf->buflen - xdr->buf->len));
>>> -     count    =3D maxcount;
>>> -
>>> -     eof =3D read->rd_offset >=3D i_size_read(file_inode(file));
>>> -     if (eof)
>>> +     read->rd_eof =3D read->rd_offset >=3D i_size_read(file_inode(file=
));
>>> +     if (read->rd_eof)
>>>              goto out;
>>>=20
>>> -     pos =3D vfs_llseek(file, read->rd_offset, SEEK_HOLE);
>>> -     is_data =3D pos > read->rd_offset;
>>> -
>>> -     while (count > 0 && !eof) {
>>> -             maxcount =3D count;
>>> -             if (is_data)
>>> -                     nfserr =3D nfsd4_encode_read_plus_data(resp, read=
, &maxcount, &eof,
>>> -                                             segments =3D=3D 0 ? &pos =
: NULL);
>>> -             else
>>> -                     nfserr =3D nfsd4_encode_read_plus_hole(resp, read=
, &maxcount, &eof);
>>> -             if (nfserr)
>>> -                     goto out;
>>> -             count -=3D maxcount;
>>> -             read->rd_offset +=3D maxcount;
>>> -             is_data =3D !is_data;
>>> -             last_segment =3D xdr->buf->len;
>>> -             segments++;
>>> -     }
>>> -
>>> -out:
>>> -     if (nfserr && segments =3D=3D 0)
>>> +     nfserr =3D nfsd4_encode_read_plus_data(resp, read);
>>> +     if (nfserr) {
>>>              xdr_truncate_encode(xdr, starting_len);
>>> -     else {
>>> -             if (nfserr) {
>>> -                     xdr_truncate_encode(xdr, last_segment);
>>> -                     nfserr =3D nfs_ok;
>>> -                     eof =3D 0;
>>> -             }
>>> -             tmp =3D htonl(eof);
>>> -             write_bytes_to_xdr_buf(xdr->buf, starting_len,     &tmp, =
4);
>>> -             tmp =3D htonl(segments);
>>> -             write_bytes_to_xdr_buf(xdr->buf, starting_len + 4, &tmp, =
4);
>>> +             return nfserr;
>>>      }
>>>=20
>>> +     segments++;
>>> +
>>> +out:
>>> +     p =3D xdr_encode_bool(p, read->rd_eof);
>>> +     *p =3D cpu_to_be32(segments);
>>>      return nfserr;
>>> }
>>>=20
>>> --
>>> 2.37.2
>>>=20
>>=20
>> --
>> Chuck Lever

--
Chuck Lever



