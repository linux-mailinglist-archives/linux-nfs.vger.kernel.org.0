Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1935074EEE6
	for <lists+linux-nfs@lfdr.de>; Tue, 11 Jul 2023 14:31:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbjGKMb0 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 11 Jul 2023 08:31:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229798AbjGKMbZ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 11 Jul 2023 08:31:25 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B2A21734
        for <linux-nfs@vger.kernel.org>; Tue, 11 Jul 2023 05:30:58 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36B6I6DE028014;
        Tue, 11 Jul 2023 12:29:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=RMhQHJ+Zpf6mkacP5GSxWh7zJ5HEnGyCoSQBTptBYQ4=;
 b=kGPvK5SDCNsOVelXRwryG54l+9D5HJ1WAAaIYXHDbvOyDCffNjkqB+yrLwhD3RGwOFm0
 NPdbNxdr11T890mE1iv3x+W5P15eAIsYomMM1CFaMUQobyZsKR/8gBERWi7dlYtYHYXz
 0WhMI9NGyqJKosUC/fx4VU3QMNBnjOY3k5ZZZAo26eolUgHp6jg5pPhu+MiD7yzX0XIR
 Xoif1MYvREDNOExbJBGo+ClDzzzKSqoWdn8+4aI5b4Ct7mcCEP9/cehcRX2C+ClBs0kH
 n4RdIjX973eLm3F/xerhQImVpJKyY/6Rc/Tfi2cj5mKKKpTX5+EscbQYow5EpFt4fePW Zw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rrfj62krh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Jul 2023 12:29:30 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36BC4tkc004231;
        Tue, 11 Jul 2023 12:29:29 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2108.outbound.protection.outlook.com [104.47.70.108])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3rpx8b2bs8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Jul 2023 12:29:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FGP6SbQ4vt6EEc5O71pHSteOkqK2dvvu/gNJmRNCffsR2vlMp3dZ2OSW01e4ENLY9GZClD9S32V1bDW0JoPpCcnrlNh8LnN/gGbmPA2E+OHWDg5L4i4hyZsB2wtf2NOqAGmsn9ELjuLevkQ4pSwFVPNugZqQ4d76UvloDsNVluILxFHH7du75shqqnxijrSAt3dHQXF9qb8Fz939TolwvLUcXiYaFYKl8wWQt6vGglNco7zr/ttDPj+cTVVJ7rKF/QLgnibAZ94f0I0keHfUd3BtihWJah/TA8aOjCYS2P1WR9jVUbXTfa9GpP752YrfkYjPHd2KHrQgVmSppy2ong==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RMhQHJ+Zpf6mkacP5GSxWh7zJ5HEnGyCoSQBTptBYQ4=;
 b=I+Z/cSP/lFYY6bQ5a2eo/Ch6mrqoTTeltxaICjm8jUT3D94/o0KVX1XGY5ov+oQGQbO34DcNZqWPwqmrMAOyfz+QbkTc63HSarqb3jH4SbyTDEhOAVJRqiHUX8fV9G2+KlxTA6DYb+V5E8CqhUMqw1jc8va9DrjbQG6YyXlg23oL/hex8yQ8HAVY9iGhFEj+DgMwlJthk2xCfy7bvYdGHqA0WPTiwMJD4NqEUKEMYhN9FqepbVpJDKLOFOYV9Iw+1MeTPFiR/r462SNb13L3Cw8rAjZ+8GVuQhZ7ynFOMVFtUlYhjY8zAa1dIUX/uer/sTcNCAlVYfpPjwdpNwVa/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RMhQHJ+Zpf6mkacP5GSxWh7zJ5HEnGyCoSQBTptBYQ4=;
 b=iCf0Ee+cSmt7ZeH16+pBwISgeGwH59vjzuGsxnB0bLXhv8wi0tcNf5V33Nua+VCnV2h1gMz07z872SjVfNahfjkn8fbFl/NU1En3+nblFAGl8bxoSL75IiN//xsvQN2Viz9aGzGsiDzglYgbKsJ0cpGv+BeiN6imUpUvwVwoe7o=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BN0PR10MB4966.namprd10.prod.outlook.com (2603:10b6:408:128::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.32; Tue, 11 Jul
 2023 12:29:27 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2107:f712:a7c5:9ac7]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2107:f712:a7c5:9ac7%3]) with mapi id 15.20.6565.028; Tue, 11 Jul 2023
 12:29:26 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Neil Brown <neilb@suse.de>
CC:     Jeff Layton <jlayton@redhat.com>, Chuck Lever <cel@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "lorenzo@kernel.org" <lorenzo@kernel.org>,
        "david@fromorbit.com" <david@fromorbit.com>
Subject: Re: [PATCH v3 5/9] SUNRPC: Count pool threads that were awoken but
 found no work to do
Thread-Topic: [PATCH v3 5/9] SUNRPC: Count pool threads that were awoken but
 found no work to do
Thread-Index: AQHZs02GG6qEobU1aE6J2mdZLN/TsK+zlUyAgAAGRYCAALlOgIAAHiiAgAAJngCAAANdAA==
Date:   Tue, 11 Jul 2023 12:29:26 +0000
Message-ID: <ED33222B-7235-4D79-A63F-66CB6405222C@oracle.com>
References: <168900729243.7514.15141312295052254929.stgit@manet.1015granger.net>
 <168900734678.7514.887270657845753276.stgit@manet.1015granger.net>
 <168902815363.8939.4838920400288577480@noble.neil.brown.name>
 <D20E4286-30D2-461D-B856-41D3C53C756C@oracle.com>
 <168906929382.8939.6551236368797730920@noble.neil.brown.name>
 <18061cab9338b08da691e8651e75f8fe8e88b830.camel@redhat.com>
 <168907783478.8939.2524484078705916909@noble.neil.brown.name>
In-Reply-To: <168907783478.8939.2524484078705916909@noble.neil.brown.name>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.600.7)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|BN0PR10MB4966:EE_
x-ms-office365-filtering-correlation-id: 2f54eee3-1dad-4705-0b0c-08db820a7757
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iUsCPjy9Kg2c3Q2l6dTaW/EdYS5Ign6sk5+oMvWQZMGd6bPP3ii6KYsm+H3rBfqLhVbe5QagM05YAgwWd7ew9WHCvQ/WpdBv9EfQcwC2rcw2uGoFaS9WQJ4OB/DpKruRZaJsASwulxuLdboSLrh7NgWKjBKoM1pwy3XiboJX/XzIVO3qAGyzUhcAbOslBf4Oxp+/SL7gLEh45zGvgDC4VROjNVB9R4dgpmvMqgiDm8PW8CbZm5d1xbiLYtmcrFU3BWdtfymp9BwvEimy+Sx+b/sj88mdHAxmtLrxiSPIqguH8qNQ7/BXtvlkDRdfbUA6tMv6zo1BFE2CnH0FF4SExSe38NmGE3iriinAi3xLzGQUZPSUVmEMeZvgi+rjYTQgLUbTFd0kr2vPOhRcMDQSQudfhUQzv6j2Pe2sQzG3ocUx1n1DwK01mkbT6xomp6wDGj/YaPgccKWOKxlmgZIojdsdntdZ4AcAs4Y0uf7rZpzZVGYswftex1RpStYx79ukktVS36wLSNaRvE6sF2+yPlpV+RIztDa5K8H5G16z6hb4nbu0bmnqFBbo4Mjgyt1N9/PuldApZvS0kpd0zbBEqgKL68hTWC8AxQCM/w4xCi+5C1GsxvmZw1GzA5iOsh89t5RcRq0/tHilUuv39mkDXw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(39860400002)(376002)(366004)(396003)(136003)(451199021)(53546011)(6506007)(41300700001)(26005)(6512007)(83380400001)(186003)(2616005)(478600001)(122000001)(54906003)(71200400001)(6486002)(4326008)(6916009)(91956017)(76116006)(64756008)(66446008)(66476007)(38100700002)(66946007)(66556008)(316002)(86362001)(33656002)(38070700005)(5660300002)(8676002)(8936002)(36756003)(2906002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?QT+9fFUpJZfdRoc4CNisUB6HNjTBLCIB46WA7Z3KQPTtwhW04GsxDLyKgC3Z?=
 =?us-ascii?Q?wbSjXHBvq1LzZlaEuXC1RYz0h+0GHhHeeLRasSAeqdysdBGjVUCiN12rCOIU?=
 =?us-ascii?Q?EoL09LUr6Ym3IKG7JhJfhggKEJX6TqQS00Ukd9qkFl/JJzVqeCmQYnj+uIjy?=
 =?us-ascii?Q?evbIjkkaYlb0Jz89w5UHJp9oTNHpjxRFpc9QL3PcfNhF/eaXgczGa/F/TV3T?=
 =?us-ascii?Q?O662ITPlsVZMxnx/chxhmBCEC2VAy4xcyqr/DDQ8bWaLmjD+TknjMqgviysZ?=
 =?us-ascii?Q?gBtAaQqS1/rPBIEMnT3ywCkCM/NC5O8ds9O8LZe4bqsi7EnRn21EEbuSSq7i?=
 =?us-ascii?Q?uX6bVDn9l7DLA6MzNwq6bZM2Xvbq+ho5lhvA6bS4raj8JWv2lrbMpFzSwSnW?=
 =?us-ascii?Q?TPMzRUA0vIiHgUCqTCt4TK8niAiH0ZXyQ2aQJIwrhUjGsIeigU/4hXCql05i?=
 =?us-ascii?Q?hsTsnApcGZsJTfgPe3n8D94d3vxnF8OE9lIfbm+Tb5CTTRUfJShNwxhXUSYZ?=
 =?us-ascii?Q?mBSWidpwB8W0kEnkGNDLt99/UoXGXY7yPSQ+mt1JfzizWlBm7nbD4QfulFLn?=
 =?us-ascii?Q?egwhCBjqcFeLxmwU8u4iKSKxtI22zymcT4eewvETQqnM6EdJlhh6mS6lajmm?=
 =?us-ascii?Q?4KCgjNCgOtpJlV4czNspq5hY8+3K+n42rD3vHWR7+byGCwyw5t4vGTV80nEV?=
 =?us-ascii?Q?Pco3d8bYIsjSfsxFxbOg0aeWvVlzxhhY6ryoTW0ksuQKukdo2o78t64Nrn0c?=
 =?us-ascii?Q?558yzsxHGIs/YIrV4l+4dvBwg5gguLzA6BXkBqraSQhabxEJK1iEwRtILtLD?=
 =?us-ascii?Q?/yI4+vUdtNnhsgHv1UjcXxF9z8hlfPhSJeTEPrmS0x/5zn5NZg1vft+aiP/L?=
 =?us-ascii?Q?uVr2o7Od/OUCp+dXYjr1Z9lz2vXsaS3ATrT3hA29IU5Nk1wd3j7RrXCFN8/S?=
 =?us-ascii?Q?m28Kt/DHTyX57mBnRre7W2b9Vopq3xlm5OGU53YT5ZPqB7xHgT6ggMPbN0sq?=
 =?us-ascii?Q?7eg3W0pR2teA7Bt2ceqzcBXfraB5Rf/QN/KALZwc745HESRHqulPcO6gvweR?=
 =?us-ascii?Q?8nMT7zB0sGjoF7ufc5wEAbjXBKOo4EuSuDSSuVbz10Moe59k1+ik18dlGnIw?=
 =?us-ascii?Q?+4Txbf48tXkYrMOzXKW8Dd584m6xWslqxzQpkSaon3kFhYa51wYiFmKL8rrU?=
 =?us-ascii?Q?5uzZWvruoT2nwlVN65tIZcBKtOnp4Zh3pOl0ut2NNQMomwrkH2aSYFgH8/uc?=
 =?us-ascii?Q?+c8TQTVis9VBxfjGwwf1y8zKCZNufmN0c8HjUiM2pNBXplfCOB6ja3rEcFFT?=
 =?us-ascii?Q?u4OcXtG9h9J1/3PIHnH2zGlmijCXwwqhxpkCl6pmzUQRbl/lG78HjM+77Q+P?=
 =?us-ascii?Q?p5jMjSAowMtjzWBt8mJJY+paLwhSWJDELq3UuHljUhx5Fav911BUV8mRV7qb?=
 =?us-ascii?Q?5DY2Q5S9akViiBlE1/8Thesph8H08o1Hwp8hUMav8Tkcc+ebz2UAmaSWbt7R?=
 =?us-ascii?Q?VFR8P54E0+vS2zw5UvwJEaeaBzUhVIjjSt02UVld7vVAkGkEfGCt3wBTkEDN?=
 =?us-ascii?Q?857CTYoPzuccNUYBm6G0oggGO71oNnA0Yv/02fozashMrvK0XC3r8y2pd/Jv?=
 =?us-ascii?Q?Jw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2128F5415F52D0449AD84D97E6C7FEA3@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 2fAf3B1IHcKh9EyuKyRpO2Md11vAosp4obJ89dxfo2ojvsfJ9180fegP3wUSyDv1AM7pR3IMryUb6lsXYWiGfQAMsZ2gKtcgx6/gMK+8EmRPh3CYg2SCsnUsJLsW05AQCGDm+n9e9gnibadK6h515eMxKlsDAS2VNx4KQLo86CPfUqg1yv9nKd9OMA6Gc0KEshh0fZsMOxPSb7Xx7Osz53iafj48wE4wJBYaGNtpoLW43HCVVlkf38zCD3g1NTn3er8Wo/Tj9YjRgwMGGmdjuD5DBMiBzwj38loTbmMtKv82eI89EK+bBx+oJoiWJ0qmrK+2wAgmJyNN32Gq4npTS0QSrYp2rCdOmGBqa162SVEOXpJBYJwUS0/u4jLbhdoSuAK1N7JbC3H3/1u06Vzla7vScZfYvokWJdzV0n82XsSpVbn0x3XHu7DWS2+TCpJIwOVSIjHDDmpp0ngy1LZXju91kUE6cc5LuDS/7UooaTa85ExYPndAMi6vjyjDb5SEvj1sPkzxTojmDZSPW+wpwFDZBYnbZMrobl3jV1rSoT6BqehvE/Jn9bUSgU0m7MritHh7izdZDcpwtBqLBNXE4csqGZUNdpZXQ9fULAFnsnJDMz2IYawkeyGPEhgD5dTC0zu5EahKuDh5+cLYUJwCO2wsUOVzMyY3724agyFV6rJhkIerp7jNC/5iqe9x6bb7kelHIV2MDWlLJZkNyjOb8XNShDhe5XTkn/CHlpMV/FnNg8YarkycidDK3JzXYOpg6q6bb1Ujf8fyukjB9RN5/LRSOXe4HdLeLUjtKjkEVoB3d6dgebC4YLvlu9bT+766VTk6YCCSxHqN+MglK7D4l7qukynCLp55qjzoq2FKc42DAU/1QuXx5x+vb44f29aP
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f54eee3-1dad-4705-0b0c-08db820a7757
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jul 2023 12:29:26.6219
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mQnibmqqzS25xExyubJXO61yu+0olPAXMVP+ys1rMIhLHAfLk14xjD47n5SLdyqLBwyjQVVSU8OIURJGWhXJYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4966
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-11_06,2023-07-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 phishscore=0
 spamscore=0 mlxlogscore=999 suspectscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2307110112
X-Proofpoint-GUID: EqKpY8RNnescAV10zcWgnhgrnH9R9qk6
X-Proofpoint-ORIG-GUID: EqKpY8RNnescAV10zcWgnhgrnH9R9qk6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jul 11, 2023, at 8:17 AM, NeilBrown <neilb@suse.de> wrote:
>=20
> On Tue, 11 Jul 2023, Jeff Layton wrote:
>> On Tue, 2023-07-11 at 19:54 +1000, NeilBrown wrote:
>>> On Tue, 11 Jul 2023, Chuck Lever III wrote:
>>>>=20
>>>>> On Jul 10, 2023, at 6:29 PM, NeilBrown <neilb@suse.de> wrote:
>>>>>=20
>>>>> On Tue, 11 Jul 2023, Chuck Lever wrote:
>>>>>> From: Chuck Lever <chuck.lever@oracle.com>
>>>>>>=20
>>>>>> Measure a source of thread scheduling inefficiency -- count threads
>>>>>> that were awoken but found that the transport queue had already been
>>>>>> emptied.
>>>>>>=20
>>>>>> An empty transport queue is possible when threads that run between
>>>>>> the wake_up_process() call and the woken thread returning from the
>>>>>> scheduler have pulled all remaining work off the transport queue
>>>>>> using the first svc_xprt_dequeue() in svc_get_next_xprt().
>>>>>=20
>>>>> I'm in two minds about this.  The data being gathered here is
>>>>> potentially useful
>>>>=20
>>>> It's actually pretty shocking: I've measured more than
>>>> 15% of thread wake-ups find no work to do.
>>>=20
>>> That is a bigger number than I would have guessed!
>>>=20
>>=20
>> I'm guessing the idea is that the receiver is waking a thread to do the
>> work, and that races with one that's already running? I'm sure there are
>> ways we can fix that, but it really does seem like we're trying to
>> reinvent workqueues here.
>=20
> True.  But then workqueues seem to reinvent themselves every so often
> too.  Once gets the impression they are trying to meet an enormous
> variety of needs.
> I'm not against trying to see if nfsd could work well in a workqueue
> environment, but I'm not certain it is a good idea.  Maintaining control
> of our own thread pools might be safer.
>=20
> I have a vague memory of looking into this in more detail once and
> deciding that it wasn't a good fit, but I cannot recall or easily deduce
> the reason.  Obviously we would have to give up SIGKILL, but we want to
> do that anyway.
>=20
> Would we want unbound work queues - so they can be scheduled across
> different CPUs?  Are NFSD threads cpu-intensive or not?  I'm not sure.
>=20
> I would be happy to explore a credible attempt at a conversion.

Jeff did one a few years back. It had some subtle performance
problems that we couldn't nail down.

My concern with workqueues is they don't seem well suited to
heavy workloads. There seems to be a lot of lock contention
unless the consumer is very very careful.


>>>>> - but who it is useful to?
>>>>> I think it is primarily useful for us - to understand the behaviour o=
f
>>>>> the implementation so we can know what needs to be optimised.
>>>>> It isn't really of any use to a sysadmin who wants to understand how
>>>>> their system is performing.
>>>>>=20
>>>>> But then .. who are tracepoints for?  Developers or admins?
>>>>> I guess that fact that we feel free to modify them whenever we need
>>>>> means they are primarily for developers?  In which case this is a goo=
d
>>>>> patch, and maybe we'll revert the functionality one day if it turns o=
ut
>>>>> that we can change the implementation so that a thread is never woken
>>>>> when there is no work to do ....
>>>>=20
>>>> A reasonable question to ask. The new "starved" metric
>>>> is similar: possibly useful while we are developing the
>>>> code, but not particularly valuable for system
>>>> administrators.
>>>>=20
>>>> How are the pool_stats used by administrators?
>>>=20
>>> That is a fair question.  Probably not much.
>>> Once upon a time we had stats which could show a histogram how thread
>>> usage.  I used that to decided if the load justified more threads.
>>> But we removed it because it was somewhat expensive and it was argued i=
t
>>> may not be all that useful...
>>> I haven't really looked at any other stats in my work.  Almost always i=
t
>>> is a packet capture that helps me see what is happening when I have an
>>> issue to address.
>>>=20
>>> Maybe I should just accept that stats are primarily for developers and
>>> they can be incredible useful for that purpose, and not worry if admins
>>> might ever need them.
>>>=20
>>>>=20
>>>> (And, why are they in /proc/fs/nfsd/ rather than under
>>>> something RPC-related?)
>>>=20
>>> Maybe because we "owned" /proc/fs/nfsd/, but the RPC-related stuff is
>>> under "net" and we didn't feel so comfortable sticking new stuff there.
>>> Or maybe not.
>>>=20
>>=20
>> --=20
>> Jeff Layton <jlayton@redhat.com>


--
Chuck Lever


