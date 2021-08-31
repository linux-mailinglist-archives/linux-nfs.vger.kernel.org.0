Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 580443FCB26
	for <lists+linux-nfs@lfdr.de>; Tue, 31 Aug 2021 18:02:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239625AbhHaQDU (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 31 Aug 2021 12:03:20 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:1802 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232770AbhHaQDU (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 31 Aug 2021 12:03:20 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 17VFoLpN009245;
        Tue, 31 Aug 2021 16:02:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=KrQBewoR4okeZjiQli7O+zT8ePAc7XiM9yfZCaOF8gE=;
 b=odKJFEIDWOlYP9tcRImPjnW7f+KUKqG1hOGWbOt8zwtXTFOiXNaUOszx278o/2U8Mxms
 67rIJO89A9f8KX2SR/LkhI92DFTlYhZt2CL+fd80ibQaeDbt7uf7gizH8kKFt3OeuxUs
 1S2U0st9X+o1+Py+0qefFXs57chK5LozPAwsvHl4OZETaqMrKWkchH59WyWXvUK3bXbY
 rEnUPCm8Ap4RsycLQT+GaslRTpPMGrCZlDAtzb61BZ0Av298mNKK1yH6UXcWdfcD13LQ
 XRa41MYaCpDp2DH4EHr8A74cjpAEsxjKcs4GBg4nQnBgWgF9kUsffdbOhRuyWKy1zf1l TA== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=KrQBewoR4okeZjiQli7O+zT8ePAc7XiM9yfZCaOF8gE=;
 b=gNxz3uzU4saXc2WjZhacbxHKOdbcoMZ8c8ewj7aeFdKK8pE1mmgYXQKxSC2frmaQwhwq
 s843UmObCjWHyeyrs01a7WtBtYBISxSqaV3APwsDxNS8MgNnJo9cbBeL1z1FpmDi8FWG
 Y12/JsMVJQ+AywQBOXBw2iJg5uigsoNqMsMXY4WlxYUMPBYvlJyypASr8l6VAsCKZKXT
 EjNiuv0t7pQOVrWEPAb7yCjnnXHGoqwVl1lqC1Hj+44LP2cvS4jX6lJwVIWwNIaVfPYY
 PTmCzpj4H9hvvnUxo02HH8zP7U4CqGFhcBRWelur0rqVnAR5bpt0vYmViFEKXZeqN4st xQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3asf2mhfvb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 31 Aug 2021 16:02:20 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17VFxppq177562;
        Tue, 31 Aug 2021 16:02:19 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2103.outbound.protection.outlook.com [104.47.70.103])
        by userp3020.oracle.com with ESMTP id 3aqxwtsgqj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 31 Aug 2021 16:02:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HlbzFA2eiwXARZzkJaDFc2CyftXp8/zgah7ZlxWwK6Uab12hgs810WGev0DBi1QVc0UUhCEbRrcjNpRsO4lUF8I2pzLKv710vKec0Q8aBaA+RkGnKApYtWktFALAW3FBBkNwtMv9SISb8NZzrr7FiOMsHpghPDuZILNO7eM8NQIBRzAwpZnz2t31FPsUhKN7+7a0lJOVfuoIrV7+G4/IlxGjyjGfgi44vVqJVIr+FsQN4tVvckNvqoSr4AJWq/N5VQtNYHzWLubrhMMYF6Q9eLVOwPCe9huloS5Ir3FQ6CUIV3e3KOyWqdwn2h0z/uyOYv12RR88SHoXRim1aGGzXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KrQBewoR4okeZjiQli7O+zT8ePAc7XiM9yfZCaOF8gE=;
 b=WSmCR+KTmTqdZIXOhAOWfraB4AeugfsI2mD/zMzQwXQD4Mfh1hBinjctqdlUm9IATTDgseZpg+1zKEPmd1qSBh+W12lgG2rRAEJtKgoDoA6BzvdnSMnOm2YyzlwVYWjssoIXMlJDINtwqEfaqiF7c0+HLnTY5jk7ffv0aMkoyNJz6F9IMSgAt3fZN1Q8FFRHUWTSsDwBYafMnoisoi610TPpzfUqLZnB5F/wmz41MpxFG399UFfqnysy9epcE6PMXKAeXNIR1Wb4xY4k0gqsuKpFo+j8/Oix7gQ0T1xmwnUoNNmHvJj8fFodZCSD+S5uY/C40RX8URqNCSusV8l7AQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KrQBewoR4okeZjiQli7O+zT8ePAc7XiM9yfZCaOF8gE=;
 b=c4Q0pbiKp3e9zLXDW7Pu73e6GebLQ8XGK7kMC09FQCG3nek8Vj0BKNmTdmzBbiXBhDm28+ji7HPk08cRBwUpZp323BWO0EKJ4WlPoUbEhZanymD8t2CGvnRXSapqKqOJOJjTlt5d0ThfbgSK03l9clSNAzj+AgKZn5FfgHojnro=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by BY5PR10MB3859.namprd10.prod.outlook.com (2603:10b6:a03:1b6::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.20; Tue, 31 Aug
 2021 16:02:17 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::f4fe:5b4:6bd9:4c5b]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::f4fe:5b4:6bd9:4c5b%7]) with mapi id 15.20.4478.017; Tue, 31 Aug 2021
 16:02:17 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Olga Kornievskaia <olga.kornievskaia@gmail.com>
CC:     Trond Myklebust <trondmy@hammerspace.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Anna Schumaker <anna.schumaker@netapp.com>
Subject: Re: [RFC 1/2] xprtrdma: xdr pad optimization revisted again
Thread-Topic: [RFC 1/2] xprtrdma: xdr pad optimization revisted again
Thread-Index: AQHXnb+EPQ6bfsCh/km34j6ENph6pKuMRqKAgAAFyYCAAALCgIAAB7UAgAAEWwCAACcYgIABQxIAgAACPAA=
Date:   Tue, 31 Aug 2021 16:02:17 +0000
Message-ID: <CAF2348E-72EC-447F-A94D-C98D97D79EED@oracle.com>
References: <20210830165302.60225-1-olga.kornievskaia@gmail.com>
 <20210830165302.60225-2-olga.kornievskaia@gmail.com>
 <F7F9A947-B282-416F-BC65-796BF325054F@oracle.com>
 <CAN-5tyEB9nv576uJijBtyhv2pqAHGNB4yeKo=F21btOkVQuaDQ@mail.gmail.com>
 <04f975f95126921f3d239a7a9d80ced2d88b05ff.camel@hammerspace.com>
 <C73DE4AF-9C1D-4694-839B-D88EABAA6DAC@oracle.com>
 <9448f294a39775734212083cbe329642b9e15d09.camel@hammerspace.com>
 <B5C7A8A1-E810-4616-9E1A-265BADEC5432@oracle.com>
 <CAN-5tyFwxC3BtU7xQiaUKdCnBQg1hfKv6QJ-dnnBrLnP0P9kfg@mail.gmail.com>
In-Reply-To: <CAN-5tyFwxC3BtU7xQiaUKdCnBQg1hfKv6QJ-dnnBrLnP0P9kfg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=oracle.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9645382e-2752-4189-9b3e-08d96c98b4be
x-ms-traffictypediagnostic: BY5PR10MB3859:
x-microsoft-antispam-prvs: <BY5PR10MB38598EB1E801775999DDABCA93CC9@BY5PR10MB3859.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 11dNP9d0vU5W2ew6Gcl0dvucWCW24DVroP8LZLEh8eB4FkWdR2OIdNoDGgD+3pjeAAWAH8QXA8CrjFzAO+ou10qisv3sKT8vhoDrA0YItNAgR8euRuNroJA3UJbAfV1KjxBfsHEfKOJ7fN/gCC9ShfsYYfoSMXSUfHP8VAnNzC3c+GZiJHkJ0fPWiWGo7JYeS28aIFg2OLbCjF8n5NtJAAAvxzYn+lSPjLNM+dRbJuHF1Dm2+ZtosYBt81k8Gb4hi4f3HGmSbzhZYrCoXS3o8BirE2EX/uLyXdbVTOI4hB7KDCJHbwWXtGkPvsQfzrv1zwftEJrqj2rfwTl7h0buSn6dzKQo7sB8N0UmBHFpAk9dx8Eh2KwoohGLIhI9Z50qQMwp+eR4HSRqgWsMbisdtq8P8ACmSSFts2yn/KulCxPfGG7qUTtN0CcKbdCDjOAXhWTfIUMlz5jJ7Ii/6KOAUJ3zy0r2QSA6SdOFvBiHWQlTMUuPcXS7ySBoQWO9suul2/ziYN7+qD2LxxBObP/VtqCYwdXnFqpXRhVcTVydJ5Mmgpd6nOrqaUhyHqf48YAg6YBKHRpbgn3vtFFLMYj1Jl1hVoyrhCLhVeK7jQesgw5sKaaMlU33kjwy7L2HagWCfBjyeyK1TeLtjsxCIa+yAbGW182LiQBOCAmzmPOQ6K5ytEB3YQjefs3y6Cu6MTcXF1HsyzdRHfsByMq5G/EjWN/ixgsOZG7JTOHEDeKpSeAenpCcRbOVawx65OLPafkH
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(346002)(376002)(136003)(39860400002)(396003)(8936002)(71200400001)(86362001)(66946007)(91956017)(83380400001)(4326008)(54906003)(66476007)(38070700005)(478600001)(76116006)(36756003)(2906002)(8676002)(66556008)(64756008)(66446008)(316002)(186003)(38100700002)(6506007)(2616005)(6916009)(33656002)(6512007)(122000001)(6486002)(53546011)(5660300002)(26005)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?VmxPhEoGnzl/XWbRdRl9dtH9uo4xPLd2pFrCEAyOxxr/wHFzFjoaqeAr9qJM?=
 =?us-ascii?Q?8T7Pj8nLn/NVxy3NnDBXzlifrR0pB0QP8S5nVFS17dCqwCz9k55GNjG88pz9?=
 =?us-ascii?Q?zkGGK0T8A8PaR41VA/2U1kyptAViOLfquFaIyR33McA1ZoWvQyMsPcAwjI0B?=
 =?us-ascii?Q?eX5omybi6WAYae0b9X7Q/SWfyujVgUVltJSe9uUpLZ83H47a0wWE9ilztBnw?=
 =?us-ascii?Q?bQMgcHhcfeWKuswt5LZu/aPM8AVu1XSZ06AgJtfPMCX60dNDndblVgA6MMW8?=
 =?us-ascii?Q?SCARh/poT2BU7pWgQV27rj/afeBXChq6rEoq9y+gxD4kYyCwPRwG5tKGe2Hp?=
 =?us-ascii?Q?1KDntxlM90jwvdc1WzqwCCHuwit2+9y1C9Gm455Z1rCLENqssVmyfxQ2Ejo0?=
 =?us-ascii?Q?0OrElIp7aWUvzy7XJGdExmBmFoVxp77Ye+9S387If2vEOidZc9Js1a6+GaCu?=
 =?us-ascii?Q?Ss2AGOaePgkL1BQJp4D19GYdDDF1hmBADQAfzOru8wSONxlyaIBsL3JDZ5bb?=
 =?us-ascii?Q?kSeZk/01VYZ9jUNGm3TgzmOrqrGTBVmpweIKBPy2/rZGwG1U5kxkt3NB+pcu?=
 =?us-ascii?Q?gEF5uBOB8v0/U2ZJFhAPxyXWyjRkbgUvWzwcEum1j7nBfKzJqnWjs1M8Qhct?=
 =?us-ascii?Q?vjzHT7ZTfgoro3vifjrzb/Y6ewa7BO9gJp7kULZ6YeQBtdJOZv1Dqt7GtfHd?=
 =?us-ascii?Q?PIoEVpnlD3B9xQXRvChtVzWWDj1Xn6tIvQlxrGKg+h1guu0G/65IAKM1azq2?=
 =?us-ascii?Q?XKXstDqweTqHHxJme+HV4qy4c5L7UrULdVhJEcanQ4J7rKqnzJMKlB1t06/P?=
 =?us-ascii?Q?l9+p9kZgpBanFYpy8xhQ3wkh1Vzlb5nKrs7tm2A1lxXT/84fQVPrUziOqKOn?=
 =?us-ascii?Q?xn7bVuWhbdlL3TRAyzb+j/JaQOV1AmSZZZJ9bfdZa8xaVRQq880LyKIw59cU?=
 =?us-ascii?Q?A8oIEWC5M6ClzglkdoEynY+nWODlk1fP0UZEI/taBXM3w250H13PGtYW8frc?=
 =?us-ascii?Q?8d72auVoc3u4JbbyxYjZY6/akmIAa+Ls16tUfkauErFVfC+1aSk2HhxZxJZs?=
 =?us-ascii?Q?dPlefjI2X1Nq1tCm3KTl2h73q1dg2nI35aVHptOedqicIPYFC8p5h/QLjfBw?=
 =?us-ascii?Q?TC936WCb41nKlGheBR5CMPsuJK2YKkrDmyJVn66bouvZ+qX1tkvEQiTPIOLw?=
 =?us-ascii?Q?I07OjvsPRSOYbOjDmBTcacNCson719nFJGz7jUzjdbxtqzddbcGkJUt2Jv8u?=
 =?us-ascii?Q?BRBEH7ylMaQpPnP3D6sn13C3g1RewuSmC/VOc2Bp3VnBF69Q0CvegQU+a5xK?=
 =?us-ascii?Q?YW05WApcTRqjf2f74qM6rxPm?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <0043D4307A6E1643A921BF0BD47A8B59@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9645382e-2752-4189-9b3e-08d96c98b4be
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Aug 2021 16:02:17.2277
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ujKiUEBJREzLVi63L2YGpPwNTPZq3pZWwGSAW/b0jU54f8uZouCYncqUGEr6liQ21KOpZ0+CIR/Z9RnahrmX5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB3859
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10093 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 malwarescore=0 suspectscore=0 spamscore=0 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108310086
X-Proofpoint-GUID: mnm3HKsDWdnD7v3zbYnJ7i4LhMRFNX4N
X-Proofpoint-ORIG-GUID: mnm3HKsDWdnD7v3zbYnJ7i4LhMRFNX4N
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


> On Aug 31, 2021, at 11:54 AM, Olga Kornievskaia <olga.kornievskaia@gmail.=
com> wrote:
>=20
>> However, if there is a problem, it would be simple to create a
>> persistently-registered memory region that is not part of any RPC
>> buffer that can be used to catch unused Write chunk XDR padding.
>=20
> When I think of XDR padding, I'm thinking of a number of bytes less
> than 4. Perhaps I'm confused in my understanding.  Tail.iov_len is
> never a value less than 4. Tail.iov_len can contain bytes after an
> opaque element for which a read or write chunk was used (eg
> READ+VERIFY or WRITE+GETATTR). Thus when RDMA looks at tail.iov_len
> and allocates that much memory, that allocation does not represent
> just XDR padding. Since RDMA can't distinguish between
> padding+operation vs padding, can this even be solved?

Yes, I think it can be solved. xprtrdma was relying on the upper
layers to tell it how big the XDR pad was. Instead, it can either
provide a 4-byte pad segment unconditionally, or it can look at
the value of in the rq_rcv_buf::page_len.

The reason for all the current cleverness in there is because
adding the pad segment has a cost. If we make it no-cost, it can
be added unconditionally, and all the cleverness can be tossed
out.

--
Chuck Lever



