Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 562446D38A8
	for <lists+linux-nfs@lfdr.de>; Sun,  2 Apr 2023 17:09:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231156AbjDBPJ1 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 2 Apr 2023 11:09:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230469AbjDBPJZ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 2 Apr 2023 11:09:25 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33C56AD27
        for <linux-nfs@vger.kernel.org>; Sun,  2 Apr 2023 08:09:24 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3323x9D4003587;
        Sun, 2 Apr 2023 15:09:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=I486PvxwmTpeI/pdJUhy7GMTZBl+54I73n+ABZxQ53c=;
 b=uVIBWs9ouv/nBV1jPygY//uA/DYWqSIxg4rGT9B3zbZmWSjma8UgjoVUT6s13sVv0KFL
 +XlxqKj08LsuwB/NZoB+iPbF2WFbFBuVLVH3j2SPsCsHTLa0K0whT2yfOMzOF6uHJUd4
 zCGolrtyNoYVKsL1P3+ygPk7o75uNqe5ywnIDzdeDnuIuZ3kqiC9w/IO6ANKpI6EM2ww
 l1CFHgpU1gFV2z8VH/gIsb4owi3LNJkwSroKBYoThcwrEqwlMsX33gMR/5h/HUcecvRp
 O3ydgwqBB5N7ED0bwt2eygfyR8XP06o2ntE8t/YvSbZZWK65V3gUE7gMpuIj9tFc4QWg ig== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ppc7tsjqt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 02 Apr 2023 15:09:20 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 332A5aqR001463;
        Sun, 2 Apr 2023 15:09:19 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2174.outbound.protection.outlook.com [104.47.55.174])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ppt3e5max-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 02 Apr 2023 15:09:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AlWdgJFyV1oFoSCM8B7pOx+dcmC9nx2tyx16rYHgr2KdoWmZ1K34btZR6Yv9YBfxmlzj65dU9WjeUpT7AISUJFYzp2pH1xksCFbItUCBHsZOtuRYCEQ0wqk6XsbqEyNCiU48rX4/e6tEe6aAZns4V58ErNgVd5RF+ams2DxG8EdLLMrJalHM1qYKPzXNcrXMWkQ5wwH7AvP0r1+xErQve+qBWlDPZkQDOn7Gc8pSGfuSzUFRhewDdlDec7Q2vA+a0+dMBEVlPmi1mNbNVLilu1qs5BZm/81NrAlwtZEoRqpPyGAhyXV2Ttsv2j/4mSi6u3xQOPYEWO+G6e3ZiNJolw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I486PvxwmTpeI/pdJUhy7GMTZBl+54I73n+ABZxQ53c=;
 b=bkmDOy+4MNYGXoGJdYXMGCn8NFpmwEfTRxvBlYDOcNvt2CufglVVoDw6oarXhsBMzYy77UQPyUUZLJSVxbmDhzCuq/qeT9ZA3KMs4Sj4+8Eg4T5tqoOA5bIX0cICo4ihPknhparr8iUJ0j5Plqi9seNyO/NdNDhpYngf5LFRuDD3KNcdt/tpSw5WSvMda0ovrITmkFtL62Cekn2NkxPKkB2WEOhVDnyXX5Js1g+ED1uhzsvFKDZX/1rgtGspXt46CpLw79yNq5FjgztZ5SFc50hM0G4J+8gjOkLYmhryTtXU9OhjwGc4TqfUPYFw9P/fUkx2jTA6lk4Lmx79oizPWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I486PvxwmTpeI/pdJUhy7GMTZBl+54I73n+ABZxQ53c=;
 b=zqOeOmFGaAoCh1ez/bXBKAYCoGgmCHLKdEZDhaA3pZB26iPisczU2v4t95LB3zDKrsyGv1Zuod8GiYwMPUsT0gbEmKEChrxz40mksLw5fvYptwiDXLoZQBtP3FFX9SHsNx/FUQyR0wHdr6xuzKYYKZoxK1ItZ+TVBfqUyI562x0=
Received: from DS7PR10MB5134.namprd10.prod.outlook.com (2603:10b6:5:3a1::23)
 by CO1PR10MB4433.namprd10.prod.outlook.com (2603:10b6:303:6e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.28; Sun, 2 Apr
 2023 15:09:16 +0000
Received: from DS7PR10MB5134.namprd10.prod.outlook.com
 ([fe80::15c:75c7:a36f:ab3f]) by DS7PR10MB5134.namprd10.prod.outlook.com
 ([fe80::15c:75c7:a36f:ab3f%5]) with mapi id 15.20.6254.030; Sun, 2 Apr 2023
 15:09:16 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Dai Ngo <dai.ngo@oracle.com>, Neil Brown <neilb@suse.de>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] NFSD: callback request does not use correct credential
 for AUTH_SYS
Thread-Topic: [PATCH] NFSD: callback request does not use correct credential
 for AUTH_SYS
Thread-Index: AQHZZNetCma7323OEkqk2ZkGldRq468YIHMA
Date:   Sun, 2 Apr 2023 15:09:16 +0000
Message-ID: <CF4DFCD5-332D-4147-AA8A-F81FAB96AFA4@oracle.com>
References: <1680380528-22306-1-git-send-email-dai.ngo@oracle.com>
In-Reply-To: <1680380528-22306-1-git-send-email-dai.ngo@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.500.231)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR10MB5134:EE_|CO1PR10MB4433:EE_
x-ms-office365-filtering-correlation-id: 753037bb-35f2-4fce-a18c-08db338c3a1f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dpYSkNml2tmAt3bEoktrlf8pFleE2atW0J/1GDZcJKGDuhYY46HQZSvAItu4+u6zFkvIgaMUNryrXohPAXs4wM1E2infVUd7h4sEqvghE8jo1f/HA6bEeyqgp12HCySrHvm+bICELBcZdVTsaoTWLYRu1mQOWbnuVF5/Jtxj5HHksb+D0+qNmT7TTMEHpk7BaigYT/B0IHYjWL4rhEBIg9kfI4nbJ6LnjQXwYcBXQyzZh5tit06k+jd3qY+GSG8ZuZMHpxdKzN2okpHh3uYDAoRo0LUxgO3FzX9XbhS5Z0wKzJx63odsaBu63fJqZuGHf0qWOY5Pf9VueqAwNDyE3IKqFdrTbPzMKdjBTKS1bhJ0DDB0wXhAMq/NPHa5V3RuNT6j8KoLtmWud8WWKW44WbFnEkNBiRyCPhULN8PvTBzR3I4apD7wvK8QocsQ09J8pN6DPrYmmbg98dPStdt80FyEhwpsr3hnjvfX9LJyAVVu/rBQfHvFwV5RBsEmJej+KEH3TJDOwJN9j7Qc3KcEHICRwPrqspf0Cev5KSTBrl05oPq07zNlIFKOlPCJG2wLCx8HVmoZDFvvgW/vyv0+kT/WysukzzGB9unJWqc0P+Y3EXJxJW6pOJUkN3JcOsEhMakXYMdEGKjZBtopOfxcIw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5134.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(366004)(376002)(39860400002)(136003)(396003)(451199021)(86362001)(38070700005)(33656002)(2906002)(36756003)(71200400001)(2616005)(53546011)(83380400001)(186003)(6506007)(26005)(6512007)(6486002)(8676002)(76116006)(91956017)(478600001)(66476007)(66446008)(66946007)(66556008)(64756008)(41300700001)(122000001)(38100700002)(5660300002)(110136005)(316002)(8936002)(4326008)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?WRp4eHV6LRJlaJupjLLCcEAIem6holavGCFxAo1J+FwMzDIwch0D7ElYkzRu?=
 =?us-ascii?Q?N3ML5dSajiNzfnpyAJq3TSwnRkYIpHq1XM+9n1u6mTfyUpuNMgr/i5xeEiUk?=
 =?us-ascii?Q?LNFCIzn263vwO6j93i0zqmAt/ND3JAvhUQEPp6HreXa0cQnG3ksen+InBmaj?=
 =?us-ascii?Q?qZG9lmvIT3b3l1zRVPXwkaroUmtIfpdQLdzu5eAaq0nBrIkFYXhf6pKv+iC4?=
 =?us-ascii?Q?VRalMXuK5VsGFZGlft+K9JMakJ+KHkx+mMOnG1+e2Se1NQT9Rq12a21LcOQA?=
 =?us-ascii?Q?Q+MYMOsBYIBvhwfvUAYvJQbm4Rvw/aKaGmxockndDspINvqVfkMXfzQ0Z8j6?=
 =?us-ascii?Q?xz4bhOToPe+NHdQpRlr1fOimp79nETB1uhBoWxQ/RxGsvDQdTaBTRyCSbwOu?=
 =?us-ascii?Q?O4lfynqKdyy+/4SqA7IOsiDEY8P2nakmy+cQ5kQTDID02Frrkmq7alyu1vR/?=
 =?us-ascii?Q?09aMi5ZSKf5UNmPVf1zWcHI0Ugef4qj00PnvWRXt1MKtiOst/NmRS7ZS0MdO?=
 =?us-ascii?Q?JOODkfYLjH2Xux7aSRgT7NE7d6ELV+hxRRzvJhTUqRJR88HWbokjs1jxnQGT?=
 =?us-ascii?Q?hZu835JLt8Rb/oJ60zKn3ex6EbZC76iDEJ2b0acA000vZKHm1r/qGx75DQQl?=
 =?us-ascii?Q?dJfXbGsGe4LDifDBoDCvaJf5BzKvhgUeiiVI+1vbLtlFNEvVspuROCNpiC4D?=
 =?us-ascii?Q?frBA0wmP3tbni95Auo4/Bjht8esUqaFPOqXr1FB830iDcb+OpUFLgWBegAzh?=
 =?us-ascii?Q?3uAss6biT0qkbItWbxC2+2530zcBs4JjuREV9QCcX3DMZSnaJbZu7mb3jKzV?=
 =?us-ascii?Q?mMQtm29bMj1O39lq7JmBfMbKSwIvgpeqFx0+BUpaDuvFxFtT9tajUyBsLjYh?=
 =?us-ascii?Q?ESEI6BUUYr3bAaSuweARw0rjtW8Oz3M6IcgbWORXSS0GC3zO9HHF5FRK98bu?=
 =?us-ascii?Q?CzOKe0MH0BFEzhy8dY8IJA91px+oDw37urf1L7kuFgvJCbSkJtLDHOn0uJti?=
 =?us-ascii?Q?PbjT39ir+xCyhDnQ3kmHZKdRAiI+gN2wZC/QRIdH0487T2nQMjEnOa+HdlEw?=
 =?us-ascii?Q?6Cbk/g9lc1S1Zf4/eUnXyMn5njbmisOlCXFBTI47YC3JkFqgow3moZHwUiqk?=
 =?us-ascii?Q?fSa4cEmlm2i46xpn4n2HR+B7hWD9SgVIJ5y/s3G1PF5z1u+JsxfhNDrlnnvE?=
 =?us-ascii?Q?dawydCM/TyIUCL8OADOpesLFUBJY0ObhXe0FamOIFcj77hO30vHV+3jdFypd?=
 =?us-ascii?Q?TDKrSfsCoEn+ReTY489x1jLRColaFobKjpyGugBmAw5YqEUIDtESHr1hquCl?=
 =?us-ascii?Q?SLsRZYA0MXXyAneR/OwzHshCjNfiOKklnIa1YF2XFprLIfRURuvh+GiVCR66?=
 =?us-ascii?Q?qkNq3fmYPsdR2u2ZbbiQ3Upjq5Yj5XEdt7fhTlnrjrPaaKJLKU+9oXDlcTzT?=
 =?us-ascii?Q?zkf3jjUFIMoXBRHQP68ZRoalx5gBaDuun/4/GNwTC5zpXX5FfekejPVCEjPd?=
 =?us-ascii?Q?b9CNm71NN5d5OUXFxedb6YWHkSGYKiftyEBNkSfLMWI2ZShJMKzxJoYd0bYx?=
 =?us-ascii?Q?+p0G8oN5F/0/LWyBge/qH3S6rQ4ZogPa7i1Y0q4Ww3S1FCpK0TK8ZheI/aLi?=
 =?us-ascii?Q?Zw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <311CE5607A00AC45903D89E8CA6F24DC@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: o4aGuat45yIx50B7sat8gaGbldkbcTyB7lesaz6oIBp+ophGMynE7CnrU6nBiaOiEPatiot2A+rXiE3ZXFIzroAnAYwOTqK26bDOTwIawD7l8Osqts/Qhe61F7UNMEKXdLEghQyP9JUHvkr/g6V08Sky+O07UTGCXJ9d493tSbyRf3lmS9ujfLM4YcmoAySswsw5fNTBvuvjcr8T4rUhAXL3dwGms5/F2Ve6CwKpwlhRbVPeBOyObQDz0fH37sp/U5EfeSg8MEJSgvWehqNKmNiK8OxNB6wNbewBjCOs1ZMGy/Go5SLObKdcciSWzZRhFYbh+TTU96+zb3eutIbkb3aXyWD8yjh7kqgtHCCUu4ZpyS6vPfWDIyh42lIsPVxEfd7cD10TCvL55IAWyWD4fsCUr/8/7ZFVMRSJEXynYIMMWz8N/MjlM5OJt3aU66ybta9ux2+EdUk8tcRTPJA1j2eNuLHmpJBx3nG3AbBluBcdtHU0tuREE1FJmBaHk4XZgE4s/jxwIGylbRGmnRggMUEvOCxv3dijuEu5pAKOX9AXDb0t7E54X5rjt+CFNF8KV6HSmujx/WdBob9r7Rb76Rfck0tO5mex+XnK6jiSpTumwkOZH5LM6r2U661flwFIBKQ9ZyNnCOPIPTR1vRC0J06+4Y9fRbY9uoPB9JPVvnxdQbF3iZtlxtrc/BzMHTZBKoOB8ufWalPf16hcLwa7mVTp0wI2GyCZ7D2gp+AS9gWKJasmoOzbB9zrZsDVS4QRdNeFsfgDQkY0QdrmUpJu8A==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5134.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 753037bb-35f2-4fce-a18c-08db338c3a1f
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Apr 2023 15:09:16.6416
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: m3E4UEIm69gAJrqrKC/bEi+WXrErLVVTuMjH5tbHE6caUUggH16ehhSrze2vk65EIX//70HjU79u6xlkMTPj4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4433
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-31_07,2023-03-31_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 phishscore=0 bulkscore=0 mlxscore=0 malwarescore=0 mlxlogscore=999
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304020128
X-Proofpoint-ORIG-GUID: U5Yq5Cnmqz7LlNbB_DhJmwuu3xyDLGfG
X-Proofpoint-GUID: U5Yq5Cnmqz7LlNbB_DhJmwuu3xyDLGfG
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Apr 1, 2023, at 4:22 PM, Dai Ngo <dai.ngo@oracle.com> wrote:
>=20
> Currently callback request does not use the credential specified in
> CREATE_SESSION if the security flavor for the back channel is AUTH_SYS.
>=20
> Problem was discovered by pynfs 4.1 DELEG5 and DELEG7 test with error:
> DELEG5   st_delegation.testCBSecParms     : FAILURE
>           expected callback with uid, gid =3D=3D 17, 19, got 0, 0
>=20
> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>

Does

Fixes: 8276c902bbe9 ("SUNRPC: remove uid and gid from struct auth_cred")

sound OK to everyone?


> ---
> fs/nfsd/nfs4callback.c | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
> index 2a815f5a52c4..4039ffcf90ba 100644
> --- a/fs/nfsd/nfs4callback.c
> +++ b/fs/nfsd/nfs4callback.c
> @@ -946,8 +946,8 @@ static const struct cred *get_backchannel_cred(struct=
 nfs4_client *clp, struct r
> if (!kcred)
> return NULL;
>=20
> - kcred->uid =3D ses->se_cb_sec.uid;
> - kcred->gid =3D ses->se_cb_sec.gid;
> + kcred->fsuid =3D ses->se_cb_sec.uid;
> + kcred->fsgid =3D ses->se_cb_sec.gid;
> return kcred;
> }
> }
> --=20
> 2.9.5
>=20

--
Chuck Lever


