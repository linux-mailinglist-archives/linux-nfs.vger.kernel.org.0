Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FD116F1895
	for <lists+linux-nfs@lfdr.de>; Fri, 28 Apr 2023 14:59:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230049AbjD1M7W (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 28 Apr 2023 08:59:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbjD1M7V (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 28 Apr 2023 08:59:21 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C22319BE;
        Fri, 28 Apr 2023 05:59:20 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33S7iEgR032679;
        Fri, 28 Apr 2023 12:59:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=8t0eS7tzgne541sUYB4lRlU/IV34EjZJTfHY582pXgE=;
 b=pP7GvZAabti5DSBjllibumnc3tqREAsgv/vyPSHRRK60aV4nlqdxNxqB0hGTLpgykzs8
 8hYJwKl1S1s5uTl33Eh/thoLeCl2gDTHq63DaDM8+6IT110WEZCavDHZSxA2zyFBaxSi
 lMRshGhzEE7CiD3CA7SvkLHCfofcMS2gNwjy2FRW6HUxfAH95ry5SUKq2RF/2Qvuki+j
 XXt22iQs5G96J7ApU4MgNbxz3UWPIg6zwwbs00FsgrlBjRmL2JWVQgIftncZhMqTLS0e
 2FyeGBkSS/veokiZ6PnCFl6AoB1R6KBeRaOxezrqD9+3p5tHUTCtn6orjFih/mFra348 tQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q47fax6g5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Apr 2023 12:59:11 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 33SCBBnv029932;
        Fri, 28 Apr 2023 12:59:09 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2048.outbound.protection.outlook.com [104.47.74.48])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3q461arukv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Apr 2023 12:59:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gnK9LUvGhZPd0FGFpHQKLiz77+v/OI7hAQAKAhAS4GyhOMWoaKn6IhC8i2L7vsUbr4V3t1r8c3EXGpJftnzw/mlSyS9TiG885NsFhY9QLJQsyAD+S6t+3Tq+HBWpqPrw6/27fZ1JHMG0QTHPtX6inx4ny+6eGdSfGJ6zA9J89DNIEF+HwLdtSAk4sMf/0Z3qHj9/yzueds+lLFMe/J3edD+a5srA62k4GL01MhBh23CWYGl/Ui+IAnm5g1PBrC6f9PuqnG4JY6ihNmitBfxXp8tJ5XUNnKR76cOZKemGm2yx1MMN9qKMMquA7HQZfKHRN5j27SHtVxyMWvKGkjcTkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8t0eS7tzgne541sUYB4lRlU/IV34EjZJTfHY582pXgE=;
 b=aaACejdqBGBu60Y9A2kgK5rgyN1aXjBAkezeQF26u723sReRpyJDoFqazPGmd7EVQDUEHm00ZcPbpfNpLzjFioVusOXttRmx2yMI364IdnPvcgiErx9iod7Nq34ZtXfV1B+nbcg4LqL7Vr1M/HEnIbnWOEqZutkr/BSTlWjPE0PYegsyDjh0anac9+oQ7xk+JYuq47QdIAVdob0t2hyONxU+kAPYfGIpZji96Nr3a73+ifpS/4CvuhLneYQ516TqfmVti0MjClHoitwWXelM+N7T3OxRDU2s/q52Fp3o8O4Pwfe7JWg218VXof5cIz7lU5uBPUFXgB12sYPnvk49Gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8t0eS7tzgne541sUYB4lRlU/IV34EjZJTfHY582pXgE=;
 b=qwoKbfwW3A1TB5GwDzhtJbLkHmmjjckSmeRLnN+1P+XjTwlReDUI4Ifn70JPoHE063fdIDu476ElGGK83WMRAikBdv/Ycc7DuJ2p+SRykCWallQXY/C9bD+/2XpNH9qp/1UkoXV66QL6AqQ8GTUnJn+B3pzZnncLrX969F2XHCY=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by IA1PR10MB7261.namprd10.prod.outlook.com (2603:10b6:208:3f6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.21; Fri, 28 Apr
 2023 12:59:07 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ecbd:fc46:2528:36db]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ecbd:fc46:2528:36db%5]) with mapi id 15.20.6340.024; Fri, 28 Apr 2023
 12:59:07 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Ard Biesheuvel <ardb@kernel.org>
CC:     Herbert Xu <herbert@gondor.apana.org.au>,
        Scott Mayhew <smayhew@redhat.com>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: RPCSEC GSS krb5 KUnit test fails on arm64 with h/w accelerated
 ciphers enabled
Thread-Topic: RPCSEC GSS krb5 KUnit test fails on arm64 with h/w accelerated
 ciphers enabled
Thread-Index: AQHZcwlyVC5Tj4/bTUCg0bPZoyBbT69Ahe0AgAADmoCAADLHAA==
Date:   Fri, 28 Apr 2023 12:59:07 +0000
Message-ID: <F46EA3E0-1338-4E92-8CCF-DD869BD573BE@oracle.com>
References: <ZEBi8ReG9LKLcmW3@aion.usersys.redhat.com>
 <ZEuVcizjPtG96/ST@gondor.apana.org.au>
 <CAMj1kXGOxw2mm8dVNHBg3HfJ7==JVV+vdXaW3iGGKamb4ZAg-g@mail.gmail.com>
In-Reply-To: <CAMj1kXGOxw2mm8dVNHBg3HfJ7==JVV+vdXaW3iGGKamb4ZAg-g@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.500.231)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|IA1PR10MB7261:EE_
x-ms-office365-filtering-correlation-id: 00a8bd2b-8b00-43ba-8327-08db47e85a4e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZhGmnuWnnqkF0GSdFn0V1DXKb696B21VajzZxUGu0obsMOTFfjsgBUp6aZlg5o9m6+6fIh14ndo6mxERrgMwsY4oAjacL0g20muNFPn8y1LN6BcAX5F5yzS8592O2IlBnmqbiZx4+YIWAwEJqfH3nJ7HbiJjX/Ybkfcfytu/LlYacvAuTO4F4I0wwAce/Mt9QsYcwn8TZPZbveepekd7CBJlG511HZy9aotD2Y98B4APbu2Y8Z207KwLfgYN5sBnESnN5LdPgMnORC54cK8FcwLgpZqYHUQ6748h9P48z4hT1irQXwEyUrDA3J4Ac5r+nIu1/l75slmADc0vdNLXb2dlvbnlp+XaqrWskw9Ukov56ux3lLS8oNFyTqo8MuTo+tQ/2t8/sOJyQz85cd4BY2CXP8cxC6sCaJbiUGDml1IHHO1LnbNqNvFGz1OaVPIEPHJtXQGbzSOser/ydnu7yhzhOSZ6lY2gTSsJf45bHVGcGpkuC10JZdicC0NkJHFRcVQovglz19wExa7PMoMYKvhv4uCjHRu2RP9tEc5DfFQr8fgy9UA4a8AOPa79wG4tJpr78XX4EinPuQDh7U/e5TEQ/8CkjFHTHlm93V0bPPRWBuDkcKQwpysU0h+R15BSH3ZSalt87osXs4kbdmnjRw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(136003)(366004)(39860400002)(346002)(396003)(451199021)(6486002)(36756003)(83380400001)(53546011)(71200400001)(186003)(2906002)(6512007)(26005)(6506007)(478600001)(54906003)(2616005)(33656002)(316002)(66946007)(66446008)(6916009)(66476007)(76116006)(4326008)(64756008)(66556008)(8676002)(86362001)(38100700002)(122000001)(5660300002)(91956017)(8936002)(41300700001)(38070700005)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?1YEUK/9wk2lem+vxuWeIZVBcGGzOKR8r7pTGH+4HfNuNNSoiZd7/GzaUph2C?=
 =?us-ascii?Q?6KMTdxMxDPlSyPSFwC19Kcl6oJ1JGRH/OSUO3QpzzBsTUanJ+g6I+m1SaATv?=
 =?us-ascii?Q?FANynbO1umg9n+Q6R6V/AOrQBEszfpZPPaSwjYo/nRM42lRH20aqCdYs6qHk?=
 =?us-ascii?Q?vYfmHtCmY6776cZib6JHv/IYulkKfpwV8mqcPHNX/AdAub25NVjW59Kaohsx?=
 =?us-ascii?Q?tsXFLcv7OD0Qd0bunRjNFMnCarPjsV/IWh6anB3ClrpE05/s4Uu3EgV4r/5v?=
 =?us-ascii?Q?6yhBCEKIxIuQ1H9xMdR6lx5oWAvhPDD1XHN/GVthZmynWT+Et7YaCrXvmVw4?=
 =?us-ascii?Q?Kbnb4O2xDIOJ1gGK4rjc2tlpDB5dMjddAUGDkWIBzN8vp/JkFlZayulEcAKy?=
 =?us-ascii?Q?IHwOpOxFHGnqCNlDEkfu0fr4OI0BRXiMdWeLXU4NqilSdoGdsI84iZZMQ2Qv?=
 =?us-ascii?Q?f+jUeb3+sdnLA/xkXsCReBcjhlKN/WsUhMsC5Dg9io5abZMItf0QKQCqMSth?=
 =?us-ascii?Q?w5JgWxQ+FdMlzqaPET4dVPN4MnU0Q0QX6NPu1IvK2f0UR4O8WRI6WgO+m64B?=
 =?us-ascii?Q?JlF30Mtfk5fBLs5d2gGs7u85VIwS+FaoxvtXmLfU+KKB5pXSH3oSxCwl0KQZ?=
 =?us-ascii?Q?Qvps3EISankU3OmVx+XTcM1JKYFrZwzwi227IGdNJUuLiJqrh/fJGOZRWLH8?=
 =?us-ascii?Q?7PNMpfJMB8EsXP7tVpMMKB057DghMajVT3C9Lsjen7JXeUxgdoDtJ9pi0Dak?=
 =?us-ascii?Q?UaSvxwUJAU05x95rQwZ4ezk+0epAqmxRMsZi7UHE9b9kRPFzj6A9plIhD3o8?=
 =?us-ascii?Q?AFckk/A7fqeP/Jrb+iocWuF6rNBHIfqv+V4hQllXwOggOQhJe7dIt7M7tRMU?=
 =?us-ascii?Q?ZPSe/Ua2HWrHW7r8yeKBM/Bqcwu3kqk0GEOBMudXhsc772S7yS9AglNbSb5e?=
 =?us-ascii?Q?nFpyGeJUk9N2HFoHzHer3wN6VMNNENFemtIDgtNK7b1sG+Fr+S/YEqpRb0p+?=
 =?us-ascii?Q?ijuyVhtrSZQEoGD+ieNcMusqcNv1fbXGY1Ns7zf/z2nn1uSqnoXmoCQgVW1i?=
 =?us-ascii?Q?mLETL0jQjWprzqP8AxUhPat8vzSrjbO6afUakINlThmUG0/ZlnbGGnD1AEF0?=
 =?us-ascii?Q?LYcQ8imO4ATkfXgP1l2DTKm3qO6F5cG0nnk4bECKRcMncdUO6ul1MvmAJ7eq?=
 =?us-ascii?Q?M6Q9mpJ4F9AOS54vNH0plWxXkiaf8L7MQcGGF+mTkHLIFO8fhp7LRbfLlLyR?=
 =?us-ascii?Q?wVLbwsgZ+86TtXR2Ibnwm/mDY8+YzWSROjBnLwcZ9WfK3CcC9SCxbo7eOAJG?=
 =?us-ascii?Q?hN2WUKT803YxBjen1pR99TsNv/AXsrYzPzYbF7h+YZhxdRKxlMVIhsHX/Lea?=
 =?us-ascii?Q?G2tukGY04icjmN5aLhb0EzgTTtTrPMsNRNiAV/y/UA7QZ3avxqBu9v+h3jov?=
 =?us-ascii?Q?qnlEe6VS+qtg5ZNXGLcc25iuVttTZvWkpMScwPtfE10UGczcRbMFURfBKAOY?=
 =?us-ascii?Q?QGmk9dUTXe6d8F45TKa8kou/4Q8YXux8QeUjMtuIpa8qMLMxZ2q9L0ec5l4e?=
 =?us-ascii?Q?oG3y6sLP8RLL25O5Jq2QutzuLgAr4fcRwfcwS1ewU4tQxYVzM2Avjl2Q6Ywl?=
 =?us-ascii?Q?tA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A5AC89D3B90E8147B7472D1F3F59FBE9@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: b5X/vpCssd6E4Smuuebg+zDO524GgGfAXeCOkn3/J8ik686uccl1aNubiSsuYpT6tN+Uw2HJmqUnoQx/uJy3k5oKecD+xqC/zawsIxp24K1qZPhjeoyQpsfAp0KleX9L5ODw29321E7L6y5uwArHAhjFJhNZ/a+SQYp/lUhUGzpdLjnEPOORYu8vjELYEMU4EQgiP1xRUWurK+CqeZIsMl13rJGaQWAw+mKIYYJR5fWZQ8n2LchRNKxlYkfxn0SInVk2w5YZwLcmQn+OmWqwPhuieGWLIKvAX6OQXvsttdQyIJzOatJrK7n2+moMEoa00bg9fUnbF/PcFxt7/s2mugZGIJX7Oc0Q+X3AtTF7W3vWzxvNvWBuNjTgXcwNmvU8vVOu1d0Z3srVMeNoS14uzdLK9qPEt9yXyJxwO1zVNjWXrsR21+AbxmND93irOobzdd77Mu+OrPUb3H/8DHmusiLqbcmSDO5LeFM5eFNkAjEAk8F3YWV8bSnz56FThkQYhUyVv/Bb/Yvpk8KejwvO/kiVeRqkD5uqymTTXYWmSK3hQhETmkvqnjiiRuY1mGy7lxJ/yk87HXGRfPqSgwRXl7OGh9cZOiHq8zPH1vxpW5XAMopbHSbI5s3xHLIySsT9JpRZN4H6uKB/P9duUglaFH8YcE+XEVEftGn06026IDDzzuQLk/sygM/HRC44g77cK1qnq+CYKxfDW0vpHvNX6r4r5uHWJjIZxZUvyk+p/P5R5mOhG7flTO5iGSyx0AayEh2HBk/VhsOyaT6P5p0ICw+4zj2qb8ruDVHEY/sfejbBOJSYmCyXN3aZ5kUiznWjBQBUBJSFHaMEHT4BdF+hJMSEeNRLV7Q7Mi+iOWcPBgiRfMbMO4Gj+stCPCabwk59
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00a8bd2b-8b00-43ba-8327-08db47e85a4e
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2023 12:59:07.6015
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MYXaVp8h+8hQSSPTEgfZ1nRalbrUvPMX/UEsDgMqiUJ396pK/duzF7C0Uh5G3y/5Prb7gfUgEjfknzMRaSJWQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7261
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-28_04,2023-04-27_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 adultscore=0 malwarescore=0 mlxscore=0 spamscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304280107
X-Proofpoint-ORIG-GUID: DM41IRo9eybXACGIcYrL9h9CfeqDITYn
X-Proofpoint-GUID: DM41IRo9eybXACGIcYrL9h9CfeqDITYn
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Apr 28, 2023, at 5:57 AM, Ard Biesheuvel <ardb@kernel.org> wrote:
>=20
> On Fri, 28 Apr 2023 at 10:44, Herbert Xu <herbert@gondor.apana.org.au> wr=
ote:
>>=20
>> Scott Mayhew <smayhew@redhat.com> wrote:
>>>=20
>>> diff --git a/arch/arm64/crypto/aes-modes.S b/arch/arm64/crypto/aes-mode=
s.S
>>> index 0e834a2c062c..477605fad76b 100644
>>> --- a/arch/arm64/crypto/aes-modes.S
>>> +++ b/arch/arm64/crypto/aes-modes.S
>>> @@ -268,6 +268,7 @@ AES_FUNC_START(aes_cbc_cts_encrypt)
>>>       add             x4, x0, x4
>>>       st1             {v0.16b}, [x4]                  /* overlapping st=
ores */
>>>       st1             {v1.16b}, [x0]
>>> +       st1             {v1.16b}, [x5]
>>>       ret
>>> AES_FUNC_END(aes_cbc_cts_encrypt)
>>>=20
>>> But I don't know if that change is at all correct! (I've never even
>>> looked at arm64 asm before).  If someone who's knowledgeable about this
>>> code could chime in, I'd appreciate it.
>>=20
>> Ard, could you please take a look at this?
>>=20
>=20
> The issue seems to be that the caller expects iv_out to have been
> populated even when doing ciphertext stealing.
>=20
> This is meaningless, because the output IV can only be used to chain
> additional encrypted data if the split is at a block boundary. The
> ciphertext stealing fundamentally terminates the encryption, and
> produces a block of ciphertext that is shorter than the block size, so
> what the output IV should be is actually unspecified.
>=20
> IOW, test cases having plain/ciphertext vectors whose size is not a
> multiple of the cipher block size should not specify an expected value
> for the output IV.

The test cases are extracted from RFC 3962 Appendix B. The
standard clearly expects there to be a non-zero next IV for
plaintext sizes that are not block-aligned.

Also, these test cases pass on other hardware platforms.


--
Chuck Lever


