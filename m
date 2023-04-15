Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2714D6E345C
	for <lists+linux-nfs@lfdr.de>; Sun, 16 Apr 2023 00:59:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230009AbjDOW7a (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 15 Apr 2023 18:59:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbjDOW73 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 15 Apr 2023 18:59:29 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23B3610D0
        for <linux-nfs@vger.kernel.org>; Sat, 15 Apr 2023 15:59:28 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33FMdh67026509;
        Sat, 15 Apr 2023 22:59:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=NQr1En4Cn4FNQY1ltREbVlrKGbbkdEQROTt3AVK2h7k=;
 b=G3LFQI92gjZv7NOOKDzRc2tmxcK5wlc5Hc9soSmd4Sx5i9URRnAbJjwL6mC/ENFPVmbY
 s3ZnOeg6mgeV/wzD6sdnUziwiBSXxN5FkI5dh5V1pHJny/z/KM2q/goDznxk3b2lFyHe
 bDEzofzVIsgHS7RI4URhjO9QetetFpvWqHLNDcxXGflBX8sA0srC5GUtz/hnFDBUAOj/
 ULq3baYi2/qVrE89xRgZzJAJs5OTy+4Z9y+bysA0Gvb5iiH5F838oUgrWU7gjm8xed9Y
 AB2an+QAV0g3UGhFXEPO64ClbEzAeZ5j6jAuH0to2FITzyhQRU5b+HyEM81xeH9fM2vk mA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pyjuc0uyp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 15 Apr 2023 22:59:24 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 33FMmUtn007561;
        Sat, 15 Apr 2023 22:59:23 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2175.outbound.protection.outlook.com [104.47.57.175])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3pyjc2b47g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 15 Apr 2023 22:59:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i99eqlhqbQ2OR/yMmh0xvQNOJEkcwHZHIRu8Gb8hU807F+jtZWFfAPIZE/fn/pnyfWL1K01V7XfFtWc70m7yhu8wzupKTFj3wJ9uMnIHfXGKbExHPm8V4pQk1Y/Kmf0fowAuOLf9YvdF5sSHK4Jdg25iKWQJlT3N9QsTHsMVY13fG0IvSZW4p3y7QJTiXonufGeFmkstYvlGqNrXwbJfWRYxPfjoJeBEVT36SOBPR0HS02wZBQJYK2dlPf6pN8vRGYHv6Tdr+A2PPQw1terKLl0k8VitDLhhSG5z3ebC0njk39mKsbukv9IlbfcZGyazBl7V5x651g+aOYCyWacKiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NQr1En4Cn4FNQY1ltREbVlrKGbbkdEQROTt3AVK2h7k=;
 b=UgBNgmi3Wazt5MTFSaTsyTV8HTvZCSL9oNyXgZGIWdW65C/ZxYDSJg9FWrF1k1Q34AmfJHEGdn3HyqsPExMbpC1eEpbrxIHNtctKd2zv7JSJkWZP8QdpzsNXrsYPVEi1QAbNtr90Me7cNXmGzY8vKLdOUyUOscopYX3FQlamzLxfDww+7+Y1RN3gydbe3/WSTIftt+/+Ph55YUw3FXckOoU2zUTlC9+SFwSct/hTNeZx0DD/JBKutVz+KHUVqNbJTFVnHU/00hdSdXx6JcWmwGVkd+VoeJrfpEeecYBgA/sKfGh6kc7HJQ6U9Opq0h472lAnlGqT8q/6KERnXmixfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NQr1En4Cn4FNQY1ltREbVlrKGbbkdEQROTt3AVK2h7k=;
 b=u7JuHdQ5/Q76OGkp7McDfzXWDkICvfnFGXBkZKegpXtvuRiFrJaENvkc78OVm9PxJNP80Jh7uPuriJFUltO92pTDqdpoc4nHcwbjI6+4zZa+TijXAA9CRNG7f6I2pXBpZcbdBI3GE4aJScUvM5YSVoAqiTjBxLg9z8w2+09rUsc=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DS7PR10MB5216.namprd10.prod.outlook.com (2603:10b6:5:38e::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30; Sat, 15 Apr
 2023 22:59:21 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ecbd:fc46:2528:36db]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ecbd:fc46:2528:36db%7]) with mapi id 15.20.6298.030; Sat, 15 Apr 2023
 22:59:21 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jeff Layton <jlayton@kernel.org>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v2] nfsd: simplify the delayed disposal list code
Thread-Topic: [PATCH v2] nfsd: simplify the delayed disposal list code
Thread-Index: AQHZbxiG/N+K790Z6EWLNCNAtkF8za8s/ZYA
Date:   Sat, 15 Apr 2023 22:59:20 +0000
Message-ID: <8D55FAFA-FD29-4264-9232-F92D8A72C15C@oracle.com>
References: <20230414213144.385947-1-jlayton@kernel.org>
In-Reply-To: <20230414213144.385947-1-jlayton@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.500.231)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|DS7PR10MB5216:EE_
x-ms-office365-filtering-correlation-id: 077a829d-a121-4c2c-a343-08db3e050c8b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1x6r0ntx4TgFCGNXLg3Nz4xNwFkcB8kunXOCwotckg9YzWSluFwDtxBwqpy/stS0Mdu1Zti+IjkBrT6qM7Q1VETL76gDIUQC2pZOkQ8Gu0RICTegLMuB2dEus/TLswjE9+7QE8tlkZP6SO8ZQxxfQD7M8HM+Tx46OW88IqyBaOCBpWArIPscQHqkaMBhOf33xFhQcI/wMzogEtIET68uBMF8+a7q85lXpJ15MuBogUkzLnrJZqOdQqCgSeqp8jnx8W/r1pHhoy2Dh4u2EMRuUX8RltEMNy2ssweV7iXxMMN7OmJTYVrU14/mYa0pXOoO4IITdC1MMOPZGYDqUh1k8EXB0upgFGOGtg+jjZqxjShS9lCjJ9r2cDVYfxIAW8jCQswhmYCnznHOt9JjRc7GHYXQ6O3uKb2r1sK2+JA9DqA/F1VhLbRfWiNCktRveyI4I7mr3LejAZBen9WJ3oSocDRxwPHdOwPPrVpi7a9RAvdvDnU8UwUIl+AxcrGOrZ9gYv8yCwyieCQphAzgGqDJCABSjE0NlmH1/i17KMSZrNy7ely1i4/fLqMWD8t1z4bdhwgYldqH9td18xvL86Uyjh9hsogjuw/tf1i+Q0tjst8Tu8jgjtUu2yS5LM+Qo9k38h5ehWxNaNrsqX3mhF6BpA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(346002)(396003)(376002)(39860400002)(136003)(451199021)(2906002)(8936002)(76116006)(91956017)(478600001)(8676002)(5660300002)(41300700001)(316002)(64756008)(66946007)(66476007)(83380400001)(36756003)(66556008)(33656002)(66446008)(6916009)(4326008)(6506007)(122000001)(86362001)(38070700005)(38100700002)(186003)(53546011)(26005)(6512007)(6486002)(2616005)(71200400001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?lqwRS+nO/M6lnF5wmvaBQ0kOtWV7wN7lQURW9kpBaSlmn00IUGCzjGTiGcw3?=
 =?us-ascii?Q?6EsHCv/jyThEe3xqKQpRFHy5EuHg5Z+IYB71kwYkKXufu/skNA3gQONRFyNJ?=
 =?us-ascii?Q?PqPDPebEZN86cCwJSa/W6N3vderBUju/+g4IhYRrzRqj+aWtcBc3zpuhTkkF?=
 =?us-ascii?Q?bQkpP5SFBwbdbvVfU56GtjX5EDPZnG8TEVqjWyLyLeTtz0mFLj7BC+UDvdMc?=
 =?us-ascii?Q?qYPrCs9qDEw6LS8i7zMGf4V4OgtsjzsobIh7lYlAMoIXQKwQgG/Dz93h8NN9?=
 =?us-ascii?Q?F4TlcVtWHwCh8QDgBwsI0K/1tiXAVN4jiV8xaT21pznYEIyGr/9jcBxvEy9t?=
 =?us-ascii?Q?e/Ntl0I1li5734ySDAb+Z47g5Ehg4/fIByKes528y/Je6YYUVC0vSOI/Ii/J?=
 =?us-ascii?Q?gMa9x9oz9WzwC7pMFvuKsHJe9EJupXcvvKKJaQvj2fiYUnvhPOmcoB4R2Iqa?=
 =?us-ascii?Q?FzQU2FdW+yK0zkDnY7FvzXNq8QhLYPEDQllYINcBl1pEGCEQV9U9XX7vKo2g?=
 =?us-ascii?Q?CXzntHbnajv04hEq7y8LV6mxbEnN6W5bLbsxaozdtgqcHzbxSyVdFefUE3+D?=
 =?us-ascii?Q?C2/AX3QXBhLla2s4MF6Lc22CWTPSKFB8r2a6eLlZDGMiM2U444YxCOWysL8V?=
 =?us-ascii?Q?/sRhsrRGB51FBs1csvJP9Lb+kdeAnqYBD55rVQB0WJa1pGvZ3Boo7eGD1d8K?=
 =?us-ascii?Q?/p6/ljDuRsKxstZduBTR+X+hUBYRAY8TC6LqhlUabOQaWaT76fMJ9DSFpVSA?=
 =?us-ascii?Q?nEFfGFvjgt0DGVjp9hBJF2iRJ6rGRt44QI+1dveWv6Jhlmc/DE6OeW+vO1iU?=
 =?us-ascii?Q?PMN3qrzrECxS/toEB+hXKLBZjVr6KkGa6uU4SUvopuk0PkhyKD/r8K1+M2uZ?=
 =?us-ascii?Q?WnaJ7pjhWfzQik4BqYv3+m6cSW6IcqYbcHtMT/gLfjXdU62o5NQRAFQwhkCR?=
 =?us-ascii?Q?cVqzn1nCVOAE5QoDxhVkT6CGTSns6/Tjk/8jlG/f2frX3Uha13H5jgHQLLMp?=
 =?us-ascii?Q?IxaU+UxpaB39PewS++go9C/sULwJJHE0jXK1NB7pBovewHfeWD3CE9ctjzzo?=
 =?us-ascii?Q?J42noirnrAO3b9GBTPPuP9WQQRfiXuLtThmf6ek4ze5P+tAqx/Z66y5/UAuq?=
 =?us-ascii?Q?QvJQ7Jer51UaMC12G6JBOgt3m2mTxSjb1NkLQYa4VTscX6tl45Tjckc0hIHv?=
 =?us-ascii?Q?6Xfspnk0ioiOarmMGWFNa67OFp/YTxrKFt1J7D0d1RsN6yC/HQuj2VCqOgDS?=
 =?us-ascii?Q?TmWLn1EBprsRGCofUcu0dZAnOftpM8HeyiruoV8PSH4iFRYIh/lMjwJBtkXk?=
 =?us-ascii?Q?nQRbYruvlLFPlphXX34i0D1iYoM+nTOTYRz/+WjdJYrL2q5jVk4MOZIknCQD?=
 =?us-ascii?Q?C3/LuhOIMrOU7AhkGYh95IaRhtbmCOKh5vyqi7dxdzQ/cW+6wY4dke6dQXSg?=
 =?us-ascii?Q?VDR8wP+rt82fX0McqUtmBgs0HoBWc7Wncwzx9X4QL2c19NQvW3eO1oVn6ob3?=
 =?us-ascii?Q?Kwdr9yBnQoLBj/eWRr2OdeGsVmoS67rghrdl46LNIjVLGEarEWb6xDnxCoZU?=
 =?us-ascii?Q?3RQTHwqPNl8RqV31rWzGRklXnkBCTMwwamdcccQtmTzJ90sQrO+gKRWIcOED?=
 =?us-ascii?Q?/Q=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <852331DE9C45094FB5F2E8DAF598FA24@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: DWA4GFzkINLhJgZu2nD1wAEnjnj3M5u5bRIqx6icH+orD8CxOhRooasMHM8iGaBuqSIWa5Le84H88f0KzZK/gyOYOajZxPPvms1zpJtuAikEr/LB6olQPV14xyX03jUZdZhev1guMjsfynwwNrZfCh01/bKcIk3vxlxwlA+w88ohXeolwnFZkDkXHLwhU0kDQQP0sAWfRv9rdMUNxEap7bW4nWe3wQAiD60qvR0G4xb+Uz13bm5ue981c35rufyf6xGgjbeEzKEInheBRqXuNDNr1j7cTcSPcCjs19jELyDu9m7CEN1XHi1kx47RuFAkhbFEpUo4G39RsP46PSDvd5kCBWd0KncQA+GzvN7Yjx7xporrRZR5Ke/KoFeuQAKwIwIJq0d7fCRh13s40TSi7lenMcKMpeWLhIpdhc/n0z+eG9jBZWT4O/AmSK8cATxzev7a5KPQgPINdPpkVt25WmXovSzIcH/Prza0cwrr7+sA0DD8PVnxzwoAQ10WLrNUuwrrxvFAUUrbTh/Ko0MIfufGyBd5CWCYAh0mh0IxA71rW1LQkKq1lnoqoH/G21l0yz5PpuFbtjZVTxjCJMlfUtT5hsgd9LB5uKziBz+JdyONf0BtUY8GvZzUdEfgGsnKmIKcQ2hlm16buabEFh9h5i2m1gHiX4+9zrrborWotxzNoWjjRup1gFK+fOmYt3Migun9fdOzRfpoqTizynoc3SG75V+cWGUyeBheZyx6E+GUbsQ9m+ipJpF0DogM/VrPAOIN9sLKzYKvSkKH1gYGNO/8bpjZeXvbo6MZ0hjW02k=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 077a829d-a121-4c2c-a343-08db3e050c8b
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2023 22:59:20.8803
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oDtXhbCU1WwKNG2HvJ8NMxdROpDNXLe5BewUFLE5NNwLst28jovrP6voZjJKRw2I4XnQn3iTP3DIFBfDbCQKRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5216
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-15_11,2023-04-14_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 malwarescore=0 mlxlogscore=999 mlxscore=0 bulkscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304150214
X-Proofpoint-GUID: 0aPoDxKD-A9LntEql_rAmB9Oq8dATxNf
X-Proofpoint-ORIG-GUID: 0aPoDxKD-A9LntEql_rAmB9Oq8dATxNf
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


> On Apr 14, 2023, at 5:31 PM, Jeff Layton <jlayton@kernel.org> wrote:
>=20
> When queueing a dispose list to the appropriate "freeme" lists, it
> pointlessly queues the objects one at a time to an intermediate list.
>=20
> Remove a few helpers and just open code a list_move to make it more
> clear and efficient. Better document the resulting functions with
> kerneldoc comments.
>=20
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
> fs/nfsd/filecache.c | 64 ++++++++++++++++-----------------------------
> 1 file changed, 22 insertions(+), 42 deletions(-)
>=20
> v2: add back missing queue_work call

Thank you! Applied to nfsd-next.


> diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
> index 2f0b2d964cbb..f40d8f3b35a4 100644
> --- a/fs/nfsd/filecache.c
> +++ b/fs/nfsd/filecache.c
> @@ -402,49 +402,26 @@ nfsd_file_dispose_list(struct list_head *dispose)
> }
> }
>=20
> -static void
> -nfsd_file_list_remove_disposal(struct list_head *dst,
> - struct nfsd_fcache_disposal *l)
> -{
> - spin_lock(&l->lock);
> - list_splice_init(&l->freeme, dst);
> - spin_unlock(&l->lock);
> -}
> -
> -static void
> -nfsd_file_list_add_disposal(struct list_head *files, struct net *net)
> -{
> - struct nfsd_net *nn =3D net_generic(net, nfsd_net_id);
> - struct nfsd_fcache_disposal *l =3D nn->fcache_disposal;
> -
> - spin_lock(&l->lock);
> - list_splice_tail_init(files, &l->freeme);
> - spin_unlock(&l->lock);
> - queue_work(nfsd_filecache_wq, &l->work);
> -}
> -
> -static void
> -nfsd_file_list_add_pernet(struct list_head *dst, struct list_head *src,
> - struct net *net)
> -{
> - struct nfsd_file *nf, *tmp;
> -
> - list_for_each_entry_safe(nf, tmp, src, nf_lru) {
> - if (nf->nf_net =3D=3D net)
> - list_move_tail(&nf->nf_lru, dst);
> - }
> -}
> -
> +/**
> + * nfsd_file_dispose_list_delayed - move list of dead files to net's fre=
eme list
> + * @dispose: list of nfsd_files to be disposed
> + *
> + * Transfers each file to the "freeme" list for its nfsd_net, to eventua=
lly
> + * be disposed of by the per-net garbage collector.
> + */
> static void
> nfsd_file_dispose_list_delayed(struct list_head *dispose)
> {
> - LIST_HEAD(list);
> - struct nfsd_file *nf;
> -
> while(!list_empty(dispose)) {
> - nf =3D list_first_entry(dispose, struct nfsd_file, nf_lru);
> - nfsd_file_list_add_pernet(&list, dispose, nf->nf_net);
> - nfsd_file_list_add_disposal(&list, nf->nf_net);
> + struct nfsd_file *nf =3D list_first_entry(dispose,
> + struct nfsd_file, nf_lru);
> + struct nfsd_net *nn =3D net_generic(nf->nf_net, nfsd_net_id);
> + struct nfsd_fcache_disposal *l =3D nn->fcache_disposal;
> +
> + spin_lock(&l->lock);
> + list_move_tail(&nf->nf_lru, &l->freeme);
> + spin_unlock(&l->lock);
> + queue_work(nfsd_filecache_wq, &l->work);
> }
> }
>=20
> @@ -665,8 +642,8 @@ nfsd_file_close_inode_sync(struct inode *inode)
>  * nfsd_file_delayed_close - close unused nfsd_files
>  * @work: dummy
>  *
> - * Walk the LRU list and destroy any entries that have not been used sin=
ce
> - * the last scan.
> + * Scrape the freeme list for this nfsd_net, and then dispose of them
> + * all.
>  */
> static void
> nfsd_file_delayed_close(struct work_struct *work)
> @@ -675,7 +652,10 @@ nfsd_file_delayed_close(struct work_struct *work)
> struct nfsd_fcache_disposal *l =3D container_of(work,
> struct nfsd_fcache_disposal, work);
>=20
> - nfsd_file_list_remove_disposal(&head, l);
> + spin_lock(&l->lock);
> + list_splice_init(&l->freeme, &head);
> + spin_unlock(&l->lock);
> +
> nfsd_file_dispose_list(&head);
> }
>=20
> --=20
> 2.39.2
>=20

--
Chuck Lever


