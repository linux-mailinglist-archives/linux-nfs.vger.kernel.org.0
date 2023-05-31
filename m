Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D1D07189D9
	for <lists+linux-nfs@lfdr.de>; Wed, 31 May 2023 21:09:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229554AbjEaTJ0 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 31 May 2023 15:09:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbjEaTJZ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 31 May 2023 15:09:25 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B8F51B4;
        Wed, 31 May 2023 12:08:56 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34VERMEF032512;
        Wed, 31 May 2023 19:08:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=gfq4Y4VsAOM89ocvkR+V14iNt116lLrzxVdmSHmCVRU=;
 b=UJqeDB8DXYPVC8r4PZa4+IHAbV8zC4kzf2j7sE0L012Zwa1agObpZB+Dgh6FNXuuPkHY
 PTBDsIiXzct2rHnTGamjXHAbtPALd2k0OccTDIkm6a+J8Mz+xz8oro2DAPsUkjjcyeJG
 VM1+Wu9uITBtW4V9ndqIjZd+fS/+CiatlaePiLda1DuEpeY8wGofAEhDnnGNru9NsYR0
 gi7nGEzGtQ4DPn1vl66KSnK4VszfVXwgN2q0w7UOxzk7W67M8XQ0Q5z9+vl05slWG7dI
 CFdc8r45jJ83w7nVSIL5+gvHL9q1ICfbfSUUXb+LLhTfmoRd+GDWPzYRO1xdAkZq5QxR Vg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qvhb96rc2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 31 May 2023 19:08:41 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34VIplX0003687;
        Wed, 31 May 2023 19:08:39 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2048.outbound.protection.outlook.com [104.47.73.48])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3qv4ydpn6v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 31 May 2023 19:08:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PbMpSGajkdAoCARN4SczlNatfmQ/on+rWy6g2CscvX9/W8tIHJIUOMs2Vx2z4OJKAZ5LHPN1bq0eVYA2Oz27+5qRjrjfiIXRYe/bA4eyDgAdArKl7aBNx+Vr0dbUsZR2TG4W2sYT2/NiQccbglLlBhXFiexkvHMNqYNIyWV4MglOHpOYNvUbumzq+CtMPsSdvA62CKeWGbGcbatj+HhDG3DdQ2U9n5UCrq968HKy/Ytal7D6g6wA6uykIM+DkqByRBiLbYCpJWj92XzDI5d6Wf4wFRruhKR91w7FulPgAo91yI/7vAW99NG3U3E/deBdhwitcvzbdzTib2lUCBY5mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gfq4Y4VsAOM89ocvkR+V14iNt116lLrzxVdmSHmCVRU=;
 b=jfd4wguiFH/pDgWRxuw/9bpACDHcj25CefblStf1P8iHffeyF8U8vhtEE12p8kb0c5FXRhvta3PMvZkYOShPOW42P7c+yPaEMh6QeWd5vpT2Nb0COjqzHg4ogZN3n8Pc0Vg0V4Ef2AaBqW2XxSxYMIzueXuGzVyH367elov4VRfkSSB84439jgS+otKf8cMbbjQSz1caAtJefBqV43paPIuNa4qk46MokfDO8U8nAP4ert1jNcgD3oH2m8tWLEB5tPw0KSSyHUdWF4MUssz90tIqWziwKUwr60MGzgJYHJ7bxGuaIs3g4j5Oxm8eg11jdTirx5sYwAAb+Cw9RJ6jGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gfq4Y4VsAOM89ocvkR+V14iNt116lLrzxVdmSHmCVRU=;
 b=vOpKU95IU5OVpNudAU4a3C8xK4pYlESggfczWSssYrYcr6h7EMlJVKZLDGcw71td6gCH0/OAcP+2/3EfuvefH9bpALqyT3Mxg5VbHNURnmemwvJSP5npAuInCTjnDO69qn45J1dBCSfZGoD/z/YrsTZNdiU+1wA8LSn6mA50DU4=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SN7PR10MB6620.namprd10.prod.outlook.com (2603:10b6:806:2af::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.22; Wed, 31 May
 2023 19:08:28 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ecbd:fc46:2528:36db]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ecbd:fc46:2528:36db%5]) with mapi id 15.20.6455.020; Wed, 31 May 2023
 19:08:28 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     David Howells <dhowells@redhat.com>
CC:     Herbert Xu <herbert@gondor.apana.org.au>,
        "linux-afs@lists.infradead.org" <linux-afs@lists.infradead.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: How to get my krb5 crypto lib upstream?
Thread-Topic: How to get my krb5 crypto lib upstream?
Thread-Index: AQHZk+GxE8WfLhdsKUaenlRuxq/mKK90vr+A
Date:   Wed, 31 May 2023 19:08:28 +0000
Message-ID: <8C32DD7C-719D-4CC5-A1E3-33BCE0A7FEFF@oracle.com>
References: <723506.1685552525@warthog.procyon.org.uk>
In-Reply-To: <723506.1685552525@warthog.procyon.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.600.7)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|SN7PR10MB6620:EE_
x-ms-office365-filtering-correlation-id: 8c4fe65c-9010-4dbd-b64d-08db620a6aa4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pwe0JH5P8t+C83Yo5ofjBvliu04cC7c8dMfNSD4z/YK2ES+IzH9qSCbxRrQewzcA+6K64YNeu+KUJXd4XhbV6Lw/2jUCI4TKrx+QMxZyadCFFfmS6X/af6Khy36Uom9PbCvZoTJaMHFXKmz+dHdl5f85Vkgg6Jg2ngV4OXAf74kB0+UBAnsrgpYX5EJlUFw1wT/r0L+SSLCIAI6Ehl3HT8f/1k/k/jnGjnQJHtjCZUsiRzWw0VAjGwQi0cXqywW4RMVoZYtHO/8DZGqWhVYOA4I77wizXCzu6UWbd0U2V6vFz9u8VhgRKs1rYCmncAIuQJxidoDRPDYM/P2WBPwrmCGOkyuum2tL5izw+XLU0Xv/JRExbOpbMHqy/Hrr3J/mqHyOMMxTiuroR/ahShOHU+5okWWlnTf43n2BQQP1A5j2LKXBmmNKDBUtYctIIDtZdwkcZ1JiwnvtR/gy3tOGYZnLSsab2h4lsOZ92rOgM+ba3st1GstU4zLaVTQG1GpYqdPbprTEN6LNxjagHJEjHtNTeacjHBe12nly831YeGrG+tcw94Ph8ZVJW5ntVwOqR8KLaGI2oMyRR/rPUOtCDRibrP4n9d+r7LmI3omxG09np321jHhGKzAhxUbDvbOixw0Sf/C8nXwmV8Uh9uPTaw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(376002)(136003)(346002)(39860400002)(366004)(451199021)(38070700005)(6512007)(6506007)(186003)(53546011)(2906002)(2616005)(54906003)(26005)(66899021)(478600001)(83380400001)(86362001)(8936002)(8676002)(41300700001)(38100700002)(6486002)(122000001)(66476007)(5660300002)(66946007)(71200400001)(316002)(76116006)(66446008)(36756003)(33656002)(66556008)(91956017)(4326008)(6916009)(64756008)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?lIlmKdTdO0fDA65dLvlsObn2xKxpvZDdVYYP2qbC9Y12gdgYq1qCMTQFbVdB?=
 =?us-ascii?Q?I4zoj39ooaKW6mEdndyj4dv6GIAFkewDHZApppfVp7g11L9vNsGzwE8gBn2T?=
 =?us-ascii?Q?S75EvZNY3Lah/bBxSHkr16p961Vz0uf7M4SRNxuggaefYQ8tbL8agbAxeXbl?=
 =?us-ascii?Q?gil0LoR+7wvnevjing6pCM2QYCwr0+vy8Om2PoyL726DKIL24fsnmwFhr4De?=
 =?us-ascii?Q?n7udkdlMyOnS2FWTvgEm068ZX2Qte7m1MLQlxI7NVy0/nJN6fPH4TqEobWC1?=
 =?us-ascii?Q?jI7Ay/3cdUt7B0tU57qrpt4F0oNocwn1L+XNNXOm2Sn4n1DhWtSM3aop7uY7?=
 =?us-ascii?Q?mNUdx9kCr+jMaOTl2TFH0rxu5Ehv7j+wPhIKw9dQ7cXGz885Mx2eZNYifG7R?=
 =?us-ascii?Q?eBaD1xtl7/4t6w+zaE9oarIF0nkHGGmj7xIWCyAzCGAUkHhkKkxRk08YVD++?=
 =?us-ascii?Q?LVzDpcHh6OE426BhPqGKvEbOwdgQIrsXjXFZ7ku4XWCjv+Yigec/qm6FU0Wv?=
 =?us-ascii?Q?371yVCLoTZr9nwOXVH6vdy4VlmxDXThhZzN9MnGcYxGPGYX6HhSCC3Qvc/xv?=
 =?us-ascii?Q?OMfD3TazvXdEhhw8yROYGTn0E9ejs9qwZogFZnjlPGaUE2lW7Ff7e0PRRfZ5?=
 =?us-ascii?Q?HxkVSLKV2Qb/mbvgJHJZA0f1AXqFz7LWe2OjehqrpyB3KlaDnfMw3S04cJFx?=
 =?us-ascii?Q?yJLq4jHEJ+i9F+SAYxdmOeHQorUDWHj5D8UnQJbe/1+DD8P4qXRmWaE4/4xV?=
 =?us-ascii?Q?hkmyQ4ZCFQs+iFdydg+9sF5eIAUneFLC8KxCmNj9myO5oOBqZByc5SOMP+pP?=
 =?us-ascii?Q?eobGvR24Hsk2AOx4iK7vo3rs0TQ3xfzsV09mYky9GHQrznCwhobC0ctXHQVi?=
 =?us-ascii?Q?1/ozMC3zf2zqOfCfDps+zQs5kyN7IYklglwvCa/AtKbvnbNnx2I4aHJ+V9s8?=
 =?us-ascii?Q?wl95X+FqzGnIDt0nLVY5AWJOVoH7l6ph8MIsvGS6FwBDPc4B0JsdjrZaa7Zi?=
 =?us-ascii?Q?3nnlOgUoW4Cht5yzcKnuPmhU4JyN17qZX6eOs7do2mLj8iQgof6ny5E0Xkrq?=
 =?us-ascii?Q?0p/VeCOG4Y95VLGZb+sXTJzq4P1RnjqkA/i1ZcnP925Ia6hmKTbRvwb621Sy?=
 =?us-ascii?Q?lbdWw0QRxCjmoho9wZaiDmsuDhZ5L04tRIw9o54wJNfhu4znoQR+4moeZyaM?=
 =?us-ascii?Q?5oFZ/mBJMA/D2TLy62+Hv6RVOVWRQVN32dIQW1XtkasxbrQwga7o8wS/FYEC?=
 =?us-ascii?Q?Iq397QdoCWEJmDVbGrlUB9aF544mbYTJNe9ZtkL+4okVIZqEo413dc0y50fG?=
 =?us-ascii?Q?VpCQwsl5iDTUqTKsiJrQMNYWFCF6ItsgRymLWjO/QtPNI3b7n6UWn0qDyzOr?=
 =?us-ascii?Q?Ni10DMAKIPtirdTh/HF+1WN2eOtFTP1pX1dw/B/tXWz9mwKOZn0YqRzV/+2G?=
 =?us-ascii?Q?m1cMUcKlWQh7v4H45MaNjtio94O35gfdwS82ulklZf3Zwnzj/Zopr4ApmHO2?=
 =?us-ascii?Q?La4CNLX7Ocal+NsXDiLSwKQtG/TmCiJmq2+/8IQhvebzpPwm6FAjOuSM4iYT?=
 =?us-ascii?Q?WLXlYw6U9gnOEZHU9uvAsK2lwYLE3c8NPpFPmjSr+fklYrIODHjlffNeAVhD?=
 =?us-ascii?Q?sg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B8218331E00685448F0B3FEA4D91306B@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: +nkpjq+ovKdXtIW8txURhSDXVxeEKJ33+pINjASjezEExRGM6HGaOp9i1+LhCBlrgjqlEIvvhxYBZak2yxKQFBm+ScBs6knGr5Br4hBr5glspNauD7QtOzXssY/CiH6mbSWtxd3cWnP7pw1HpSUoPrGDLRDFpzLFJl5yYC5hiq4AkdQITtWrNyZm0cZsgteTrN1p7rERJl+ZkSjh5TPW1YRtj6Bkj4tllFVTp1SfLpQr0r1a5ZpWOLQD9w2XaxH4OKLPlKe5nLJluo8wz35D5urlQ9/jYPypbCS/AnP5jb2bBqsFxP8VYbkjL3JXTfavFsgDathaoDttY6P4R0z5wUXJxa+chjXS5ka+8uNmn67qSmvfU8CvOBYQlXEfBBVByiNVnY9KrCoUguE6iGC0PCBLCyHHJQ5EWiIQ653kYlbaglNASRZX9GXNPI3kMVNAScZZf9+Aps/ZyT6dz5EukC++H3RU7dNIhjKWPeau/B2JWaEXyke5NMA95rjc/UT+UJ1YmIPIEnuvVyL39chS4Fvsee+w1IXyL7mofd7t7wIJA+m9W5GVHV9TdO711prQRsuXbkMrXZeyehRlbB0vynim9Uu90KZuXqLYePBjaWy3uhoUSHZojAtSoJUFKlTyNJ/8bW9A7ve+x0lAAbAeJ6xh7x/JQaedlUaQnbq2KdHyQgjjrAg6OKMeWaXPCD0Zr4T0nNgaV8kIcxFdhuJWWRypoanSHYhWKUSKD4Qkbr6NSWe6ErpCVPNFaKSvRFY1+tMYtGax8zljUzDNtyaKZ5FnxqYUNKeH6Zc0m6DflP0WV6x1MW3HIsoKk1HIp5SSB7ttcpz2spYBwxkyBdWw0fu25orMQ7pcUWZEC8Yhh/fqn/A4tx8VJ/mNGKsbPH8abNxw7P9WWzo/AA/K2lK3XQ==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c4fe65c-9010-4dbd-b64d-08db620a6aa4
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 May 2023 19:08:28.1338
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lmCHJKuVkpEhpDH6dHNZW287aWBpGsiTpigY2IqGSLyWPSbohP1cuSekn973RbZxOXD5Pkd8PUEThnySBKaHYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6620
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-31_14,2023-05-31_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 adultscore=0 malwarescore=0 bulkscore=0 suspectscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305310162
X-Proofpoint-GUID: bm7OBWAUM076c1Yu_tnHwxkujDwTvkFk
X-Proofpoint-ORIG-GUID: bm7OBWAUM076c1Yu_tnHwxkujDwTvkFk
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On May 31, 2023, at 1:02 PM, David Howells <dhowells@redhat.com> wrote:
>=20
> Hi Herbert, Chuck,
>=20
> I'm wondering how to make progress on getting my krb5 crypto lib upstream=
.
>=20
> Can I push it as it stands and then we try and build it into the crypto A=
PI
> for it later?  That would allow me to push my rxgk implementation for AF_=
RXRPC
> and at least allow userspace to use that.

Sharing our private conversation during LSF here:

My feeling is crypto/krb5 needs at least one consumer, and
it makes sense for the first one to be AFS.

Once crypto/krb5 is in the tree, I'll be glad to look at
starting to replace the internals of the SunRPC GSS Kerberos
mechanism with what is provided in crypto/krb5.

However, if there is going to be significant API churn after
crypto/krb5 lands, I'd like to wait until that stabilizes
before adopting major pieces of crypto/krb5 in SunRPC.


> As far as building a crypto API around it goes, we need four interfaces:
>=20
> (1) Key generation.  We may need to generate a {cipher,hash} key pair {Ke=
,Ki}
>     or just a hash key Kc.  We might conceivably want both.
>=20
>     At the moment, I return a prepared cipher or a prepared hash.  I don'=
t
>     deal with the key pairing here as it makes testing a bit more awkward=
.
>=20
> int crypto_krb5_get_Kc(const struct krb5_enctype *krb5,
>       const struct krb5_buffer *TK,
>       u32 usage,
>       struct krb5_buffer *key,
>       struct crypto_shash **_shash,
>       gfp_t gfp);
> int crypto_krb5_get_Ke(const struct krb5_enctype *krb5,
>       const struct krb5_buffer *TK,
>       u32 usage,
>       struct krb5_buffer *key,
>       struct crypto_sync_skcipher **_ci,
>       gfp_t gfp);
> int crypto_krb5_get_Ki(const struct krb5_enctype *krb5,
>       const struct krb5_buffer *TK,
>       u32 usage,
>       struct krb5_buffer *key,
>       struct crypto_shash **_shash,
>       gfp_t gfp);
>=20
> (2) PRF+ generation.  This takes some a key and a metadata blob and gener=
ates
>     a new blob that then gets used as a key.
>=20
> int crypto_krb5_calc_PRFplus(const struct krb5_enctype *krb5,
>     const struct krb5_buffer *K,
>     unsigned int L,
>     const struct krb5_buffer *S,
>     struct krb5_buffer *result,
>     gfp_t gfp);
>=20
> (3) Encrypt and Decrypt.
>=20
>     Encrypt has to be parameterised to take a specific confounder for tes=
ting
>     and generate a random one for normal operation.  The IV is fixed all
>     zeroes in the cases I've implemented.  When testing, decrypt should
>     perhaps be passed the confounder to check it.
>=20
>     When encrypting, the output buffer will be larger than the input buff=
er
>     (or, at least, room must be set aside) so that a confounder, padding =
and
>     a checksum can be inserted.
>=20
>     When decrypting, we either want to provide a separate output buffer s=
o
>     that the confounder and checksum can be stripped off, or we need to b=
e
>     able to find out where the decrypted payload plus the padding will be=
 (we
>     can't work out how much padding there is - that's left to the caller)=
.
>=20
>     At the moment, I pass a single buffer descriptor, providing encrypt w=
ith
>     extra space front and back and providing decrypt with somewhere to sa=
ve
>     offset and length:
>=20
> ssize_t crypto_krb5_encrypt(const struct krb5_enctype *krb5,
>    struct krb5_enc_keys *keys,
>    struct scatterlist *sg, unsigned int nr_sg,
>    size_t sg_len,
>    size_t data_offset, size_t data_len,
>    bool preconfounded);
> int crypto_krb5_decrypt(const struct krb5_enctype *krb5,
> struct krb5_enc_keys *keys,
> struct scatterlist *sg, unsigned int nr_sg,

So are we going to stick with struct scatterlist here,
or should it be rather an iterator of some kind?


> size_t *_offset, size_t *_len,
> int *_error_code);
>=20
>     I also allow a krb5/gssapi error code to be returned so that it can b=
e
>     used in the generation of abort messages.  This needs sorting out
>     better.  It may be that only one code is actually relevant to this an=
d
>     that the caller generates all the rest as it checks the metadata.
>=20
>     The AEAD interface might suffice as it stands if we pass in the keys
>     already generated and passed in as a single key blob.  We don't want =
an
>     IV generator as the protocol defines the IV to use.
>=20
> (4) GetMIC and VerifyMIC.
>=20
>     Both of these need parameterising with extra metadata that will get
>     inserted into the hash before the data is hashed.  GetMIC will insert=
 the
>     checksum into the buffer and VerifyMIC will check it and strip it off=
.
>=20
>     I'm not sure that the hash API is suitable for this.  AEAD might suit=
 for
>     GetMIC at least, but using AEAD for VerifyMIC would lead to an extran=
eous
>     copy I'd prefer to avoid.
>=20
>=20
> ssize_t crypto_krb5_get_mic(const struct krb5_enctype *krb5,
>    struct crypto_shash *shash,
>    const struct krb5_buffer *metadata,
>    struct scatterlist *sg, unsigned int nr_sg,
>    size_t sg_len,
>    size_t data_offset, size_t data_len);
> int crypto_krb5_verify_mic(const struct krb5_enctype *krb5,
>   struct crypto_shash *shash,
>   const struct krb5_buffer *metadata,
>   struct scatterlist *sg, unsigned int nr_sg,
>   size_t *_offset, size_t *_len,
>   int *_error_code);
>=20
> There's a lot to be said in using an asynchronous overrideable interface =
for
> encrypt and decrypt.  The problem is that we want to do simultaneous hash=
 and
> crypt if we can.  I think the Intel AES/SHA instructions permit this to b=
e
> done and there is sufficient register space to do it - and I *think* that=
 it
> may be possible to offload this to the Intel QAT or the Intel IAA on the
> latest 4th Gen Xeons - and maybe NICs that can handle NFS/SMB offload.

I agree that a hardware-based AES/SHA implementation of
encrypt/decrypt seems like a good step forward for storage
consumers like NFS and AFS. That could be a significant
benefit for switching SunRPC GSS to crypto/krb5.


> I think we'll perhaps need a "krb5 encoding type" API that can provide ke=
y
> derivation, PRF+ and information - something along the following lines:
>=20
> struct krb5_enctype {
> int etype; // Encryption (key) type
> int ctype; // Checksum type
> const char *name; // "Friendly" name
> const char *encrypt_name; // Crypto encrypt name
> const char *cksum_name; // Crypto checksum name
> const char *hash_name; // Crypto hash name
> u16 block_len; // Length of encryption block
> u16 conf_len; // Length of confounder
> u16 cksum_len; // Length of checksum
> u16 key_bytes; // Length of raw key
> u16 key_len; // Length of final key
> u16 hash_len; // Length of hash
> u16 prf_len; // Length of PRF() result
> u16 Kc_len; // Length of Kc
> u16 Ke_len; // Length of Ke
> u16 Ki_len; // Length of Ki
> bool keyed_cksum; // T if a keyed cksum
> bool pad; // T if should pad
> };
>=20
> We need to be able to look the encoding up by ID, not by name.

It's not clear why something like this would need to be
exposed to crypto/krb5 consumers. There are a few items
in here that XDR needs to know about (lengths and such)
but that kind of thing can be provided by a function
call rather than by having direct access to a structure.


--
Chuck Lever


