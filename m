Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45C7F77F853
	for <lists+linux-nfs@lfdr.de>; Thu, 17 Aug 2023 16:05:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351686AbjHQOFR (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 17 Aug 2023 10:05:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351785AbjHQOFJ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 17 Aug 2023 10:05:09 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21AC13A99
        for <linux-nfs@vger.kernel.org>; Thu, 17 Aug 2023 07:04:59 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37HCO09Y022240;
        Thu, 17 Aug 2023 14:04:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=3wMedm/hvh26yLlCVHzjO70WFvIth99GB8/dJO2mOaA=;
 b=vls2fCyLLP/lu28wfJdshnjdnvxWytY3eSpxhxu2XPYTtSLq29I5QqXr8v79sfa9rjpz
 3XuXNvxh84wyX0f+xYcf5mBuKk8TBIYzny1YLlCTnPqkuXKBomsYn4WOJCYTzgrRjv7o
 hAbp3bShdlXXvdXzdn6rnLHNciqO+GH49ie97JXnWZFgx7n4MPOjuhcZ2VKGk9MfZ62e
 o35Jxm2PTAzla+f+DibqYF7MwfeGMR6kIiN1Anc6ikRiZe8+/rJKdKcjsGb7VdGEocSj
 TVq4+VdDyUIn+Nv2Cf9iER5xUFBBW6QX/1DHcnFzhc+7tHd/8BzBARNKtE9J+/z0KitI 7A== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3se61c9h2f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Aug 2023 14:04:50 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37HCv0QK006666;
        Thu, 17 Aug 2023 14:04:49 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2172.outbound.protection.outlook.com [104.47.57.172])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3sey2fw8gk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Aug 2023 14:04:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ca9lurDevypyGwEj50Sbw9aAvKdXz8unmDILHEwMyAAMPiOIHSMuTqTzYqiLAHdezwugI/RtpN4BDm07a5BquU339Z5J/gNdKoReOa987Jed4vRtuQA287JjuDGnEvNBwpFjuOtad6xKYO8pbwEuzzutN1D1cDcq9CFZQhnyrHIUGcsQbFUP0J3qt8vRKQJsPf2Nz0eugth4wIkPq4DGsUOHI8rgSXinbENAKxwzAVhyV6i30OcKk8VRl2u5PzGwiizPb9isXutkcc1+pcSB/vxwZB1Fyf9JR4tPWXdiOYPneuwkmYI4z7fpKFMK2YFfhVUutExt6+r6+qTJw5PjkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3wMedm/hvh26yLlCVHzjO70WFvIth99GB8/dJO2mOaA=;
 b=dxu6IDRJ1Rhj07CK4gf9nTORoM8ek+d/rfUcTwZ0AW9u/xiGnmJPpMBlINuVxKgRS1hJxn5M2ss/moZ1/f4XBI8YpAat20N38lF+bt6Sqs/+MtbJkKkyBap7sJEhoIihnzL9rz2M9bniiPz2ZGhT/VnZ8chsY25VHacu0CjFL7ofJwV0sm3ISKBOyvAjSGxYIgSjFg+BISRgQTOjSHRXKbvJGN++7xPGU1m+bJu+GfXBsfO8XVh7N2wJsn6EHmKhgeqJolbqAZ2nf9VzFuwQ4YnuecVr8yS65hBgyR+QeV5vzXQ68omuA6XWRhEjwOWI+Fj8YNSZx+i7J3ma3FQPtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3wMedm/hvh26yLlCVHzjO70WFvIth99GB8/dJO2mOaA=;
 b=P1g8Ebwd3Nuwfv7H/RpcBeFyyuWT0EcvaFkAcxk/ztQqzBZUKZOFuzb3Oa7s+tZTcV8rywEqkqMlWxaA+q6yUf6+0IfrIvVVJiaMpeyDOZI7uQWghuLQ2XYXLC48DztjHfOcFrJBji5/V029LfajhnrR9XItaSpzxXOOjYo0R90=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH0PR10MB5594.namprd10.prod.outlook.com (2603:10b6:510:f6::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.30; Thu, 17 Aug
 2023 14:04:01 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2990:c166:9436:40e]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2990:c166:9436:40e%6]) with mapi id 15.20.6678.031; Thu, 17 Aug 2023
 14:04:01 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jeff Layton <jlayton@kernel.org>
CC:     Trond Myklebust <trondmy@gmail.com>,
        Anna Schumaker <anna@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Neil Brown <neilb@suse.de>,
        "Kornievskaia, Olga" <Olga.Kornievskaia@netapp.com>,
        Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>
Subject: Re: xfstests results over NFS
Thread-Topic: xfstests results over NFS
Thread-Index: AQHZ0P0G3UtnV+hujkSFP4znnBMwz6/uhVEA
Date:   Thu, 17 Aug 2023 14:04:01 +0000
Message-ID: <7C595ADA-E841-44F7-918A-3A46A55D546B@oracle.com>
References: <9ee56f62652c3d338aff809f70e7941dfc284bf9.camel@kernel.org>
In-Reply-To: <9ee56f62652c3d338aff809f70e7941dfc284bf9.camel@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.700.6)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|PH0PR10MB5594:EE_
x-ms-office365-filtering-correlation-id: 48aaf4ab-7b44-4f65-c22b-08db9f2acf22
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jx3jIctZLCgi8xwI8s5Vz1q56+3POSWOKl+mHAkRSGx9wlIH+mZ8jixVsitvpqYlayFrYMfuUwacC/hAxctSf60C91M/ZsqzwVM3pKc8FJdjzHyMm6N1LHqQKGWQZRTh4+MWLvXrdIf4xht4kgLWNtloYesQJhs8RZAnSqbuIxTtV9fPT36mCp+o/akp0Hf6WZ/8CaRPzGvTtRAJgV0uHOEQ7EJWtAhI5lkFbc4j8xb3z2412S469DR0GIQxGWcaEOFoITY28Jln9s+NSS7d0bt2nmw1YZgv+DsNQqa9D+31/uU+na7TEmqSsu0Qq2wCnm+bnYM2NkoWDuD6i4+dO/PqjfjW8hulu8YIUqqp1a8Tw4QGLQAjp8GgbhJs3wVwIup/+QlXp8/lngBq2c1jOblqck8ag8XycPlZIpZlXrkD11weihS6MSb8Zn/+elan8ydThKIXf5bdueCxsAXGqeBgm/VVf064+egNaI4wXK/zDJaFbptx0xJ9a8GyYhp06eoUdHVPkXhR9e+mi0utwS7d9VdVrE92AnPHsjpEJKkRQ7Mr6sPvzmcfZL8FF/uw3RxCwlTzqRFervO9LmBLyDuiMXNXZYbwXB6FjH7b8FpzcM9RtuSto+LQLT1QdWOYgBh2aqY5vj/RBSCWyzbrrA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(136003)(346002)(376002)(39860400002)(186009)(451199024)(1800799009)(36756003)(33656002)(86362001)(6916009)(8676002)(4326008)(83380400001)(5660300002)(2906002)(8936002)(41300700001)(26005)(6506007)(71200400001)(6486002)(53546011)(2616005)(6512007)(3480700007)(66946007)(91956017)(122000001)(478600001)(38070700005)(38100700002)(66476007)(316002)(76116006)(54906003)(66446008)(66556008)(64756008)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?yA8sIrk26AhMi43TYkHVifuIalxmAiW4OjyD1JZA1g/f8k3IyQXgr3Eh/ij9?=
 =?us-ascii?Q?cnY4CXiziuuJm+ktqXumG2ChXS8bfZBuHWTL6HvJsmnTQDCJZnLZ36X00avs?=
 =?us-ascii?Q?iiGvSOYtFuOOl/UCDUR0TE0NNuQchwGXvvWxdcXINiR6u4khXac0u5A8K6Uw?=
 =?us-ascii?Q?Lb8zeQhkhGDpLPUrQvApNUfMqph7fapPuyR2IZKsIllmWo4DolqcU61cmEa1?=
 =?us-ascii?Q?35fMRNdndyeGQ1IaKMgemVsjpQ5kPWN+W4WzRD+7Ann7JBCATIzkFny2PSsZ?=
 =?us-ascii?Q?38FeOvLSxAaFZlWtSLwfxVzuUGKeqJ3zySamYDeS86jG8xhabfUn9+uFlq9T?=
 =?us-ascii?Q?qE5h67kDaOk/p7XnQOwzXUC/AT73AF+/ZuzvWhteugsr3fqelmaFYcXCtDH2?=
 =?us-ascii?Q?AFvXW7KrkHw38Viu1INOleXiGv8zBfOc6IV9nIrX+v58U4Gx10H75t/TzyBO?=
 =?us-ascii?Q?RipY4qOBSwwUA99/WVy/KYguhfUiNPILkipjrysr44X7M9iIud9cs1gXEU5E?=
 =?us-ascii?Q?OkGf1ZRaWpmTYreSI5zcL4zHG7cN8mKqmMQXQqaGChX0W3a9gUpZoejVBo3o?=
 =?us-ascii?Q?MKwXOTtvOJBeGtRI44a2+/2CFakp6sld44T/q05y5DF9XaN0jGpDWeg/u9Fq?=
 =?us-ascii?Q?a6ThMkQqNae/DhEePBCNZQL+hG3bflOTvQj3q5CC294O4MgFVYva+YH1rFKO?=
 =?us-ascii?Q?e7G0K55C1hjA0TYELTE8MscukrjaxKkff6B92ixruFib9F7q5qnNQj0n9Bvn?=
 =?us-ascii?Q?JofXyJvkKIk5vhmqlPS6OxyMuIlx450vjr75mECuNzEwGBR27lBLOkj6f8Bp?=
 =?us-ascii?Q?Scm5JHt9ENum+M0fvIAn5/l/l4KsNCxPuvQTgerV3G+gxEA8zFF+TrTUhge5?=
 =?us-ascii?Q?EHR+encxsdS4YHudqhih9X4VcspRbEdPgj8by8tVZlj/KVXvGgSX9oSuOZpS?=
 =?us-ascii?Q?kDTgZn1ATQww6k059cKsnJv/LIaSvRSKAlzAhSbvin8cq5+e9FMQBpT2zXrV?=
 =?us-ascii?Q?FTGwIKI/PendztE33nA9OWZuUMFOzTVkaSiAy3VsMHBdoCdQqqRGLRyUPcp9?=
 =?us-ascii?Q?2ZLobzA55u0vhtinImAkuqzm2jleLbLAwt5bc9eTH2ft9aUwg/X9z2OPxwjm?=
 =?us-ascii?Q?Pg1wuOhO/mv0fr2nOQ8mEkFtTcsTGvFtKoZs4toqjyQr6AUpqYiaxyWx5Mcx?=
 =?us-ascii?Q?1OYzVcywDp7FaATugWLPqfMgRLbVlWZyJncPYo8+dT0ZenqufYYzQu/3G07f?=
 =?us-ascii?Q?k0KxFeAxyNX4pYiKwbaLC81i/ZINVK+DRlO8aKRNnxKi+ZumtJsoWTt1zaWj?=
 =?us-ascii?Q?gAivlAzEP5fl3OYXHhkrAyK+LEh1xvVaW4GEGhhVr2HFFm5v8wTqk/+LYgsN?=
 =?us-ascii?Q?HmAdr6LsELJdqSRhuW243D8w7qbPtZ/49l3P3GNm9oQRn126kN/jITqrmv0M?=
 =?us-ascii?Q?dR1AuuTh9BYZfd7wfFQSo6ei6llJDIYkhpzIxjVlzKFewj82HvpxaWgcpXlW?=
 =?us-ascii?Q?enD6Mb/6sPpoQShM/eLfp0P+smrTV9nAC09cgd//wy/VxcwgSxf8bsEdcH2M?=
 =?us-ascii?Q?ieThaBRgOkynem2r1ryq7Ii13BpVDh0zNMCqlbi3MCE/HCIhkwThMrQCKPKg?=
 =?us-ascii?Q?EA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <73C640C1FD9AA649A563DF94AC5061A6@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: XKvtT/xX93a1dMXBVQTS599CngQ/SCh2Du8MgowxjK50wdigqUY3c+lDtgcR49php5FgJN9T29N6B5osFre14B74XEBml+gcAvsPAdsy/TdrMgZuUWYZ/T46avN+weJWSIOpmBfeCFEwQIaWBsSM6oulXJv6hj1PH9wBToSL0ckwxVJHVwdJ8iKEfAUyAuMgiGILgIHwoCJvAAJJBjf7836IgA1E43w8sVAjHQTfRkxqYtV2rncHnMnVl+aW7/L1TdPQjxmc4zB0uQmoskvnYka6blircK9kMSCoD6ETBrZScfjJKQ9acqIp9okU3C8hLUwQcKwO74Cs0E8pZd/jSE9aAQZ1aGKxobjvM88lUUa7pF6j9euXu27PxPeD8PjktGOpxmC79jslK0P4deODX/nc7/YrYe0xTj/oKI2MnBE03aFpZqQrmyG2+4QpNYl0RkdZK0GFIDEadYct+sc/Hlf4Sq0oIpzRJo1vWGaI9RHW0KZbLIOcO/Ys5NvqxEaBq9sa6q/30n0jQKejLVQZfoQPpxpzFJy0m5wX1QcF5lsX/DQbOb4o4gBaG5z99qMd2Fyv9mEwDXESd4w9vh6iAwW29mSEBX48AojAfLJLyl1u5LtN6FmBXO4ce5gLQmfnXz4UbazELqvi742zdJcppXVTh6/W5BOyytm/ArAsBk+1BykYS4L82H7u9OnpjkiaBzqv1gachrpA4YuU4BjgIQ7ssNnW3iOcLo14iEuPQ2+wO5oer8VaM3KLicl2oJKc4gqFcSnIPHo7Nn3ep7sLof1CO1nsFOI0QBtg0PR5uFKFp/ff4tNWm23Tkmx80RwJSA2gP/X+PaG4WrpWyeHCRKIkGmiaFdRKjmC+C/SitIeI/wV/QZPDIw3vYco3wt3JD9VOOeTLOVrRlobS57+oOw==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48aaf4ab-7b44-4f65-c22b-08db9f2acf22
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Aug 2023 14:04:01.5374
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MT6j4D6fh8AK4IFNc9dJkh+pGgJX9nu8GlB3UboglUte4Up2X8Vz1XQq4hZrlSwuBZe2xHWiU6qRQ24MqgL1qw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5594
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-17_08,2023-08-17_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0
 mlxlogscore=999 bulkscore=0 adultscore=0 spamscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308170127
X-Proofpoint-GUID: CVazW0j84WWcpD1pwE8_K_L_ETd6oAeF
X-Proofpoint-ORIG-GUID: CVazW0j84WWcpD1pwE8_K_L_ETd6oAeF
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Aug 17, 2023, at 7:21 AM, Jeff Layton <jlayton@kernel.org> wrote:
>=20
> I finally got my kdevops (https://github.com/linux-kdevops/kdevops) test
> rig working well enough to get some publishable results. To run fstests,
> kdevops will spin up a server and (in this case) 2 clients to run
> xfstests' auto group. One client mounts with default options, and the
> other uses NFSv3.
>=20
> I tested 3 kernels:
>=20
> v6.4.0 (stock release)
> 6.5.0-rc6-g4853c74bd7ab (Linus' tree as of a couple of days ago)
> 6.5.0-rc6-next-20230816-gef66bf8aeb91 (linux-next as of yesterday morning=
)
>=20
> Here are the results summary of all 3:
>=20
> KERNEL:    6.4.0
> CPUS:      8
>=20
> nfs_v3: 727 tests, 12 failures, 569 skipped, 14863 seconds
>  Failures: generic/053 generic/099 generic/105 generic/124=20
>    generic/193 generic/258 generic/294 generic/318 generic/319=20
>    generic/444 generic/528 generic/529=20
> nfs_default: 727 tests, 18 failures, 452 skipped, 21899 seconds
>  Failures: generic/053 generic/099 generic/105 generic/186=20
>    generic/187 generic/193 generic/294 generic/318 generic/319=20
>    generic/357 generic/444 generic/486 generic/513 generic/528=20
>    generic/529 generic/578 generic/675 generic/688=20
> Totals: 1454 tests, 1021 skipped, 30 failures, 0 errors, 35096s
>=20
> KERNEL:    6.5.0-rc6-g4853c74bd7ab
> CPUS:      8
>=20
> nfs_v3: 727 tests, 9 failures, 570 skipped, 14775 seconds
>  Failures: generic/053 generic/099 generic/105 generic/258=20
>    generic/294 generic/318 generic/319 generic/444 generic/529=20
> nfs_default: 727 tests, 16 failures, 453 skipped, 22326 seconds
>  Failures: generic/053 generic/099 generic/105 generic/186=20
>    generic/187 generic/294 generic/318 generic/319 generic/357=20
>    generic/444 generic/486 generic/513 generic/529 generic/578=20
>    generic/675 generic/688=20
> Totals: 1454 tests, 1023 skipped, 25 failures, 0 errors, 35396s
>=20
> KERNEL:    6.5.0-rc6-next-20230816-gef66bf8aeb91
> CPUS:      8
>=20
> nfs_v3: 727 tests, 9 failures, 570 skipped, 14657 seconds
>  Failures: generic/053 generic/099 generic/105 generic/258=20
>    generic/294 generic/318 generic/319 generic/444 generic/529=20
> nfs_default: 727 tests, 18 failures, 453 skipped, 21757 seconds
>  Failures: generic/053 generic/099 generic/105 generic/186=20
>    generic/187 generic/294 generic/318 generic/319 generic/357=20
>    generic/444 generic/486 generic/513 generic/529 generic/578=20
>    generic/675 generic/683 generic/684 generic/688=20
> Totals: 1454 tests, 1023 skipped, 27 failures, 0 errors, 34870s
>=20
> With NFSv4.2, v6.4.0 has 2 extra failures that the current mainline
> kernel doesn't:
>=20
>    generic/193 (some sort of setattr problem)
>    generic/528 (known problem with btime handling in client that has been=
 fixed)
>=20
> While I haven't investigated, I'm assuming the 193 bug is also something
> that has been fixed in recent kernels. There are also 3 other NFSv3
> tests that started passing since v6.4.0. I haven't looked into those.
>=20
> With the linux-next kernel there are 2 new regressions:
>=20
>    generic/683
>    generic/684
>=20
> Both of these look like problems with setuid/setgid stripping, and still
> need to be investigated. I have more verbose result info on the test
> failures if anyone is interested.

100% awesome sauce. Out of curiosity:

Does kdevops have a way of publishing (via an autonomous web site)
and archiving these results?

Does the "auto" group include tests that require a SCRATCH_DEV?


--
Chuck Lever


