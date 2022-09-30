Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D7C15F1259
	for <lists+linux-nfs@lfdr.de>; Fri, 30 Sep 2022 21:21:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231717AbiI3TV1 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 30 Sep 2022 15:21:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232027AbiI3TVQ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 30 Sep 2022 15:21:16 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF0941B3A7A
        for <linux-nfs@vger.kernel.org>; Fri, 30 Sep 2022 12:21:08 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28UITWJC024163;
        Fri, 30 Sep 2022 19:20:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=z0YgxcfXBT0H4QjhqeKsLtN8nfjf15EFknEzcr7bXxM=;
 b=bkPGn2NsoOmwgjqZgGgkLe9okK5NPM1BmBd0GyntUs3TD77nMdbSchONF0SEwQSN29hd
 f8DqL37YW8KsIpUjtQxTlEO37fGxUI/295Unw7kGf3phuPbdxKQBC3DFtWlWDJSuRuIC
 N8PNjtgEztn3PZSA28mB1tKTBuVAKSlFkTfFRd/54ZXyuGOX23femHNLTEbAJyhJJa+O
 7+47IfQi3CwtdyVin1d8jcgALq2bCHS0U5q7aqdjspJU317YgMAEgRAeI5va9vgidvnI
 OYHUJ7hfrioB7DBR/aqY7oiuSyQph+vF2h+b6QMqq/a9WX2P5Qqd0lbPKXt1enekR8ei lg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jst0m09sf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 30 Sep 2022 19:20:57 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 28UGUNPA034136;
        Fri, 30 Sep 2022 19:20:57 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2173.outbound.protection.outlook.com [104.47.56.173])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3jtpqbwtgq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 30 Sep 2022 19:20:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XAl41dEywRfjFupEL3zLbTAVTMNs08vkblnpHJ0qlg59fyKxmk7gPTP098EfHxYfSWLBzu6sy0L2bJNEVilxOO79x6Wf4kuJFT7/7GCPmAkPGCQIRKRCqxNGZBOXj6mhU0Bj6kht6XiA8J60zw/RyMVjg7lgsTfJmiaxux3wlOrpqTeWjyUQtxDH7NktPdxg3fsm1ineL/UHNj9twObe+mIkyhEvSfrF6eshQQSTX9L23JLuS1uwaQ2juypTCZE2Vny5IAFBfqGzGS7Y4kHiGVaC/q2v/fz39uOYdhblNHOeHZmMd/S4HeYLT5Izc6OWtqMgbSclGfJxrIUvf9wEbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z0YgxcfXBT0H4QjhqeKsLtN8nfjf15EFknEzcr7bXxM=;
 b=IsapFQ+Ut/UIAmZq56hw8UOMDzpMzqs/8cfv0o/5xfIz5vcA3+rn48i1PJOYqvoPLVaPtaPwwsXa9CuLrmSOIlHEtpWeaXs1n1u8rHQTe4ogQojfg0vUL0XlHEJIim0fjSYRaLLQlPV6JB1t7urAqQwmDrI359JzhcHcgT0BxlNEpxFQYzsISKEw/pkjXofTP4p+jwqxf0LNO8B20Jhz+wVeM/ZQzNVbXv5Zb6gKnfLmdBp3+r+W1gGwMp8+V0B0KSrCzwbzcyRTLF6xSq9Ec+H1ySKLTXkwEc1Hz52qjwtGupMg10DpCBtiKxh8OJap9BPIh1qLuMm9MbUZ3i6sPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z0YgxcfXBT0H4QjhqeKsLtN8nfjf15EFknEzcr7bXxM=;
 b=OKeyNEJwZj2c2iAsKfYke6G1SIUQyZ281r4a4WH/Afx/Jtr4hU6Pk9dQU+FOCtPrV1dnM/a+3tl6LsaRDPxk8jbYJeInuWEol/fzecFbdg6VkwaM/FoGZX3THpK+H7EdA1NvtmO5llv6UpByybA8/VzXJpkOfXgH9ifkst86lpc=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH0PR10MB4711.namprd10.prod.outlook.com (2603:10b6:510:3c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.23; Fri, 30 Sep
 2022 19:20:55 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5403:3164:f6c3:d48a]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5403:3164:f6c3:d48a%3]) with mapi id 15.20.5676.020; Fri, 30 Sep 2022
 19:20:54 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jeff Layton <jlayton@kernel.org>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 1/3] nfsd: nfsd_do_file_acquire should hold rcu_read_lock
 while getting refs
Thread-Topic: [PATCH 1/3] nfsd: nfsd_do_file_acquire should hold rcu_read_lock
 while getting refs
Thread-Index: AQHY1QEWqnYiB4uxs0SMdlnrLaX8o634WYIA
Date:   Fri, 30 Sep 2022 19:20:54 +0000
Message-ID: <9D4FA4C1-2246-4CAE-BB8A-D152603E3A56@oracle.com>
References: <20220930191550.172087-1-jlayton@kernel.org>
 <20220930191550.172087-2-jlayton@kernel.org>
In-Reply-To: <20220930191550.172087-2-jlayton@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|PH0PR10MB4711:EE_
x-ms-office365-filtering-correlation-id: cf4cda09-b819-43d7-cec2-08daa318e55a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LE2Q5awhbU3Q5WsKMAVlRNpADyqbXK9SiEUOJIaoluS+/giiIRek2YHAxLrXRbZnMWrVWYZ3cP74BOEMZJL/kdRv57tn2VuanWMWEOCKHIytNVVeJvpNdgNzTifRuXvNPZsEIKn1M/AL7A+fCaiH7Id9P9KSA2D/rPbpT6538XR1JwJwgj1wijLm9m2+70FMOMx8/RJjywl2fRBLtdfu5EYyKf4IfiQhhLCpOXQ8I8iNLn1fjqLbLYZqb2y/Rsl7JLmQe2NFeBi+CQcE+K9tLAYnB0AOQdv6cJe4kHO3NWRntasuL/Tc2OSNy0AiPs6sk7oD3huKFKPHGN/nT4TYCM2faX/whJTgKEu3sJl4XlcJa1DAoYPG/vCeq48kgFDcuP1p2t9FcB74aCFRHo6931/lsPyfy7w5zlJpnPx6XG4HdLhojMk/VjMC1W8dUwOr3D2rXvRZRS6pKjLdSs9HEb1KTYKPiZNNoJXx/8fCtXu9+N2BfTXk2WDRUtP4cbrFYLpsm6U9AG24tEJF8lvEEbpV3VGil2bK0EeEEq1eRSUbaH+zMv1cBpHt+reCTeV7UWjeVxdEXHSNx0fDJGYY2xrSmOwUp5mI0tFxFtR9vD9WuOX4ygEy09DLnTvPkCC1iQAJG9PJ9p79jEUa9LyhqO9URCcqsS3QeXdMdFDP4m2YozBP6fY5/tluIua90qhxIwENuOLqw937F1Vv1I+81ipcO//Sk7daWe0eIJXN6O18OE08+7DiizrI/f/ziR/KSL7vXg0iZCWvvK/d0PGaiDRhn88hzA9kdf3Zix16PBk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(39860400002)(396003)(376002)(346002)(136003)(451199015)(186003)(2616005)(83380400001)(38070700005)(122000001)(38100700002)(5660300002)(2906002)(41300700001)(8936002)(316002)(6486002)(478600001)(53546011)(26005)(6512007)(71200400001)(6506007)(4326008)(8676002)(64756008)(66446008)(66476007)(66556008)(66946007)(76116006)(91956017)(6916009)(33656002)(36756003)(86362001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?zTelbHE+kATVZHaTMPzPIobrF5TKjh2x3ineeEeyHkS7iLXcC+koFSFZpZOv?=
 =?us-ascii?Q?OUQsMGygDYAxhFdUM//tdbp7dwhSl+3P1VjcLkunm5IDMW+3GQr25srXAvgg?=
 =?us-ascii?Q?3vzwsaFltUYJN16AxS3Z20LW4oSVnfanATBSREgY/JZV5kGA3EG/MJAeiMyB?=
 =?us-ascii?Q?h+soLChvh3zWF2N1FPnBybSPS97p7A1IaNfpjJQsZ8a4P97sdPE+VxaInODj?=
 =?us-ascii?Q?KrdEofMkfPkTuyvMWihtt7E74Au9jIWGnGqRoSmepk1pTyJGbhC/64ngK7g7?=
 =?us-ascii?Q?A2JMBkPmWnWzEX9DzwQC2r2iHgGZbgOKsdKOHtOSIuHXMWvVRY+EUyaDWvq2?=
 =?us-ascii?Q?VeGdGMr0mAfnATLZOWJ9HiUZZnqxzjDRZxIX4Exfwa5TsEGpPEcOTzNF6M7p?=
 =?us-ascii?Q?qvjI6ppwp95TrxO084lMsCJNLxs8UWCJHdfny4L3PUZG4u+x+rj219aqwxTI?=
 =?us-ascii?Q?vmhXZ6tIYs8UspgsxS9LUXu0yhmWR811erRgMhKBVEKxbw4ml1GqRr5h9Hm9?=
 =?us-ascii?Q?a0GIG7GpI0Ikh5Bw8hJFz5k8W7y6ZDObJUKccFkAwUuflOCpvtVp3eS+i2gA?=
 =?us-ascii?Q?mkmIfS+yBl1qRBq1+gJV1vVcDUZ6MG1dcGzdW17ejtT7sYDOnHJ6buefCPZB?=
 =?us-ascii?Q?qSZ3T2fK3QMDpynt6pfDUmb5qFIklfVPNdsnBhyXYFEBPPzA8g/Dxk677t05?=
 =?us-ascii?Q?ynRekOXfKQmB514SUAZRW13Skuf81lkY1ZDi6Vn3dF1oXsBO3DGPeQQmS/Op?=
 =?us-ascii?Q?lFubCdJhr6BZVzhVmyEt80HYg/u7vsYXCodLBkQHf0TtkFpT1Mhg9KB5dZN9?=
 =?us-ascii?Q?XTG2P9G8p8DBj/fN/xgMOhaAYVgoujkFED9EzD/f9W1d0LXMam5ND52XWlad?=
 =?us-ascii?Q?M4KINhzJ0PYRloDLe1fjbSCRR1jaVVnwZKCvueXemegcHqpda9IMExP3WcUk?=
 =?us-ascii?Q?Oj8bCtxlhuHKOyzNG8xdi0E+IZEJHWHmtxq3dqqs2qxooHUmesZz21SSz+dk?=
 =?us-ascii?Q?fV0GN2pjCnWZp23ankvhXTHSe5ja14Sw6AXSV0dUA/81L37fjT4CA5yc/NlX?=
 =?us-ascii?Q?OOif2QGbztxD7a+EjWEBOVHXfHCMFTpcOa8gQj8L93g6oP8Yr2GoJqgDRfqO?=
 =?us-ascii?Q?wae7dQFr8Vj1+ou6YA0xitzkG13XJl33L4QsEMfQyp52n3kjXyRV1Q9birNF?=
 =?us-ascii?Q?5KnXUrbmY9NScG9G76QH8twJHglah98DptYXUmxiQictQs7FR3FKLO2sz2/E?=
 =?us-ascii?Q?3d/zSstjkJ94ptItnYMTX/IyF+1DXB0Kt/JGjNLIiVzImEvipclItYZH4fna?=
 =?us-ascii?Q?XYOlNFOeoMfMWIpB6wKbkR8sfnXSFqZRnUK9TjJefhQRVbOEtiXG8A/DU2Mb?=
 =?us-ascii?Q?ijUfy/5HSYEUCAmkRWtcxgIPAjgel9O59FuLPI+YwECiRooPffBVKAAq84pg?=
 =?us-ascii?Q?tluVloeuVqteRGGKml/Z+0AFYn+5u0dOaLuuajyvasnTRa/EMdMVWN/MYqbE?=
 =?us-ascii?Q?dc75u2CqOiOZrN89ql8mhnb6Y2czl0DC8ZVcVvL/L4rUWHjOK6xoTtO0yHBH?=
 =?us-ascii?Q?+/IXPI2r0yHreyIz+LM3Srnk80WxT7TpN1TayU5Ls0A5zVzk428WCyV2VsgH?=
 =?us-ascii?Q?MQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A276048A79C8A84E86FD78C6F53AD8C5@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf4cda09-b819-43d7-cec2-08daa318e55a
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2022 19:20:54.8354
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GepWSR4U95W9vTrDsfqS2eVH1H83mfUspPeZK3kKesc/MRPLU5yJeihoRQC9CaA6Y8LImSUj9z3Tz+rLoZdseQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4711
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-30_04,2022-09-29_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0 mlxscore=0
 suspectscore=0 malwarescore=0 adultscore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2209300121
X-Proofpoint-GUID: LI6KMICVGjCV0tVdwZwOyvXzOPOd7tWL
X-Proofpoint-ORIG-GUID: LI6KMICVGjCV0tVdwZwOyvXzOPOd7tWL
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Sep 30, 2022, at 3:15 PM, Jeff Layton <jlayton@kernel.org> wrote:
>=20
> nfsd_file is RCU-freed, so it's possible that one could be found that's
> in the process of being freed and the memory recycled. Ensure we hold
> the rcu_read_lock while attempting to get a reference on the object.
>=20
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

IIUC, the rcu_read_lock() is held when nfsd_file_obj_cmpfn() is
invoked. So, couldn't we just call nfsd_file_get() on @nf in
there if it returns a match?


> ---
> fs/nfsd/filecache.c | 9 ++++++++-
> 1 file changed, 8 insertions(+), 1 deletion(-)
>=20
> diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
> index d5c57360b418..6237715bd23e 100644
> --- a/fs/nfsd/filecache.c
> +++ b/fs/nfsd/filecache.c
> @@ -1077,10 +1077,12 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, stru=
ct svc_fh *fhp,
>=20
> retry:
> 	/* Avoid allocation if the item is already in cache */
> +	rcu_read_lock();
> 	nf =3D rhashtable_lookup_fast(&nfsd_file_rhash_tbl, &key,
> 				    nfsd_file_rhash_params);
> 	if (nf)
> 		nf =3D nfsd_file_get(nf);
> +	rcu_read_unlock();
> 	if (nf)
> 		goto wait_for_construction;
>=20
> @@ -1090,16 +1092,21 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, stru=
ct svc_fh *fhp,
> 		goto out_status;
> 	}
>=20
> +	rcu_read_lock();
> 	nf =3D rhashtable_lookup_get_insert_key(&nfsd_file_rhash_tbl,
> 					      &key, &new->nf_rhash,
> 					      nfsd_file_rhash_params);
> 	if (!nf) {
> +		rcu_read_unlock();
> 		nf =3D new;
> 		goto open_file;
> 	}
> -	if (IS_ERR(nf))
> +	if (IS_ERR(nf)) {
> +		rcu_read_unlock();
> 		goto insert_err;
> +	}
> 	nf =3D nfsd_file_get(nf);
> +	rcu_read_unlock();
> 	if (nf =3D=3D NULL) {
> 		nf =3D new;
> 		goto open_file;
> --=20
> 2.37.3
>=20

--
Chuck Lever



