Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A8F25F85F4
	for <lists+linux-nfs@lfdr.de>; Sat,  8 Oct 2022 17:50:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbiJHPuX (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 8 Oct 2022 11:50:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229723AbiJHPuU (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 8 Oct 2022 11:50:20 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFF0042AEB;
        Sat,  8 Oct 2022 08:50:16 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 298FOkt5024383;
        Sat, 8 Oct 2022 15:49:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=wI8p00Zv8INsYqYMn4p9YFk6ZMikx52k8ZL5Ii62Kg8=;
 b=Z9zLZ+1b6yfJ1EJXKMu9K9wp6kqNExBU4ttgQPTBM6QzSwxVLsvLWSnOF3U1qtdEqvin
 f9FxEMvRLd0SBVMNiaKzXExKiK5bmTzyEqn+YoRbcIWNkVszAYuQ4So6tk6gl+mlqOu3
 5jmMN7+tGv89aov3iOKYMk2KyrPagaoPXiADDmYydYJqA/IDLO82PlSyRMevpgdFU/O2
 LX9YCYaGB5vAb6d6zbH0GQvFZzenCUW94RjBiCnTftGhlSRkKZ5FznJga2hOuvD+2gAE
 J4HFNo++WO3uqsTGp9nmyHqPw31C0fMxRWgVpumxUgn8qVb/FJ6fEfi+BgvG584+hMVe 7A== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3k3002rmjg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 08 Oct 2022 15:49:50 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2988B04V022496;
        Sat, 8 Oct 2022 15:49:50 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2170.outbound.protection.outlook.com [104.47.56.170])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3k2yn89v72-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 08 Oct 2022 15:49:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m9Prlw0mNjRs9te3+7eCahsCf2jN5xIMIJDAjR7hrE5Xdn7WYKalzB6iRr5IIDmsvBsSHZstea5jHlFhnZdsqLDVqOscDt+z6gGg4q/bxioioe0VbezyW6d5hzv2xVAYcUjFPAXXHHuin4mnW2onluaEXqei6uySV5IuE2HqQth3RaVg0atMVzxi+vK8JHxVOFEqzXnEpz0hbCBTx2WlTRgere6qziIup7hJl9ZsFen2iJbq/6q2tdYdxMUH9YlcmzDcoN62n7NnfSlBGDUXwVnufnZ85EBWJWT0LceZojGt9X3qJc9O4VWxYbDga73tsAeDBlT5azeCU+nCQWu1Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wI8p00Zv8INsYqYMn4p9YFk6ZMikx52k8ZL5Ii62Kg8=;
 b=QtziX9IlcP8jITj5HUPPCdictvCuJ65Yhvk+9J6QPWTppoOyFtoflOIZwp9/IIiRTsUAWV5bAATZYNySaSdhV4d9FCTgaYqRfJqvy0wGEXPdcfojhFZOtjNA+63pYBfMVjOCaKdBrxl7mcy/qdQA8En2kguG0x4mONL9ZsKnoAX/j8VrLc74rmjBPzsfD4jJ1OrYy/0P54PGsHY+R7lbadHFNK1rKPCv82FckSlnxp76jspM3k6hX3ESxE2IZHEMYkffEgkQTkwiOyBTLCK5E7ChmJKT8TooO2k/Pgq8hDhguJDdxBXwT0kBgJL/nuhHfQe+ZxE37jlCLF4IRZOV1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wI8p00Zv8INsYqYMn4p9YFk6ZMikx52k8ZL5Ii62Kg8=;
 b=ow/+Lfhb8TKn2SUgpaRC8ne88HgWnK8ybN96xbG3J0FQYjOu8XSy/LQMiHO1aWrplR+xJ18brNoR6/aWJ4RMutQIjg6NqNChiPFxqid2ZregSfO4kRGj4dPfcZHMkqsZgJf/fPg4NohYDLzsTLgdQbcM1GoNL9qfShQy7vZF1AA=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.24; Sat, 8 Oct
 2022 15:49:46 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5403:3164:f6c3:d48a]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5403:3164:f6c3:d48a%3]) with mapi id 15.20.5709.015; Sat, 8 Oct 2022
 15:49:46 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Kees Cook <keescook@chromium.org>
CC:     Jeff Layton <jlayton@kernel.org>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "llvm@lists.linux.dev" <llvm@lists.linux.dev>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>
Subject: Re: [PATCH] NFSD: Avoid clashing function prototypes
Thread-Topic: [PATCH] NFSD: Avoid clashing function prototypes
Thread-Index: AQHY2qgawkU0NaFsc0uXdbeEqqYBz64EpdyA
Date:   Sat, 8 Oct 2022 15:49:45 +0000
Message-ID: <7AC81CF2-2D64-452D-83FC-33E5BEA82209@oracle.com>
References: <20221007235406.2951724-1-keescook@chromium.org>
In-Reply-To: <20221007235406.2951724-1-keescook@chromium.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|BY5PR10MB4257:EE_
x-ms-office365-filtering-correlation-id: 7c882088-5c9c-4bb9-e468-08daa944b961
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1zGp2zkrRdakMffC1vub6/z85aeEo8DDpnaaorZNzzzgYXGbEePucmtdekxaGsp8XUiZwQKVntOk6bcpYrPZs1uy6Uw/7UPui2mL5UGI2fTqnoHPCVRipuTKUXyhfDp1aMPc8ybO7YB2s71VnOaYcII8ghVNpqyKjIE/g2mM5iaoHLPxv85WF3hddjQ4TKt8/JJXtz94rL3jP0vNFQlE6Qjl1LwKjoyAvx/gVDgyYemMDyNbbZDrwO8PzJLgz/CkTj+pchFw2pgkccIymmey+yLtENlbCytKFuzLNadwacy1oz+EOXO/ADWE861z7GI0xFTvxrsdVvgFUiohBKVvF8bVg5D7h7yCyQIPAgTHwLRNB27IsdEu9vJKI+DwKpAtpacBCRQu3ViHDX3tIsKI4EA3q1yunwAg4QyU+gKFBYVzGYy/s0JgPR0i6HbwCn8ct+VjHxDO++cnEVK5KDBzOO/izHvAlF+CzgSJ+ip0b+ZdlNBYwYrVlKl+Y00M2FPsut6Bg3PMf5Au2uFGReuBi4eqliE13IP5OfDeaL3E2tvrIWhSuoFxQlE5uRV3Ox376rOitN+C4tMxUXgGMQ8Ny1ajdzqGCrAhiuMFlEPmuHyrQUACJ0jBuJD4mg9IbSdKY10EDUukeANFBT0RVZowojKNurluDOdmupnfPoNpfKYDn5zXpRvn+tGVxDntrHrbNT1GB1EoMSX4KCBuWujl7x53iV3cSjafy9f0JmVTwX/pPGSSaATy/2C2+5JxYfbZn1tIJywEqVIU5toQKrmUVHUxpycjJKRj6p5kg43tGGLpU6MrLLRn3QgAHd+9AFn1RoDCJyM83Ujd3CMMud1i6w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(346002)(366004)(376002)(39860400002)(396003)(451199015)(6506007)(2906002)(2616005)(316002)(26005)(6512007)(53546011)(36756003)(38100700002)(71200400001)(8936002)(41300700001)(86362001)(30864003)(8676002)(91956017)(33656002)(6916009)(66556008)(64756008)(66446008)(66476007)(7416002)(122000001)(76116006)(54906003)(966005)(4326008)(5660300002)(6486002)(66946007)(478600001)(38070700005)(83380400001)(186003)(66899015)(45980500001)(579004)(559001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?2yCyL7edgW0gy1OPVlGcN9HyCAaHp1NTT7mgHgAcasihGx5bXkZF7RTqprUk?=
 =?us-ascii?Q?Tx6bd0DHYjF2wo89Irckju+5fA3iJAIESEPOmaMZ0ANzCr2JYYPPKX6sCt+Y?=
 =?us-ascii?Q?YB/9Y/a8QXCWdpIb9BLCIp6jiG5M989bBXfvA0fuOconUQsUJLbcbbjvqMlW?=
 =?us-ascii?Q?LNeBQr1w1uWXYhoq5fy4XfBqbJqcBnEFL87OYMEDoR4Yi+5Q92VifJaBRk47?=
 =?us-ascii?Q?lgySZkxyV4y9/Io/sHtgEQ6bIzLJcUR+L4HHrkULYpH/ryRG6xnoICfQc+6R?=
 =?us-ascii?Q?IgH19pnRFAp2jzC15+0+IiODY8txKUp5PUHbVTxcToCEaOFxztAMGx7qXKz4?=
 =?us-ascii?Q?WNcrqMYOKWAnsqNOAYumkqOHl5gjOv6YSYIaEVcBP1qqbW+5sF81hVxe4W11?=
 =?us-ascii?Q?3r900ql0HmWKUFtzQKlvXEvCRM6+G3aKHlS+aUR4/5IzLoxV03GJXAC3fRPL?=
 =?us-ascii?Q?qmqQ0gCiWkeqQypYRJLu639c1NV9gyldlFHusV2mJ+vJ9P8rNqtauZIw1VJm?=
 =?us-ascii?Q?JeI2bMkECRhSPiCiinATPBMMd0eeENKFb4lKWAMeAGGIM4tpOV5EkblsRAh2?=
 =?us-ascii?Q?1Ye2DtUbyUheVlWX/34TU7xNq8H+Hnfm1APwbKDVZRWJ/ASxBSnvAcpGPFLa?=
 =?us-ascii?Q?eXp8mguS/19NqgthBVN8h/AAtTlxATfESOO/ATAGfXAYDnHRXF3vyTiEr/CT?=
 =?us-ascii?Q?8qmRdsOY4MO0lr+Ly5tY/X15J/1+A7GAcg7pvTny9V40y4/4kEIGGVEpXSJt?=
 =?us-ascii?Q?P2k4EeRgo6C5yvzn8ADGh8dQbjnv+yMQ0fvjchpHb1xGZMh6WtYQnUS54Ori?=
 =?us-ascii?Q?klpREqZgjbD4cdLa92Uvia1KYiWT/rPRq6HKhN+yAy0v4yewMTpg/l1TuU0H?=
 =?us-ascii?Q?LPjD3beqy8NL76x/0OfnIjMZLuS++lWIfZo5Npc7udo1tFD8HrvSUFwdyrtS?=
 =?us-ascii?Q?11ff4UuBm4gw8C7Wqx9pg8Ag44k4sMkbXHs4ljh5+ArIhN4JQ8ymCxcG9cdy?=
 =?us-ascii?Q?0U9q0//rv8o4I3CPfrzYHkS4iklndAtdZdBj6JUQWARzqoFQQzfEQ8Q8luxJ?=
 =?us-ascii?Q?0xCwjzXq4qoJpEg17S9P3OobRdZPGVPlqLawZXH++tKrxZyIeLiofbWlQZxI?=
 =?us-ascii?Q?yhYsDkqUW418KRKpipfIPnAmxN/oKeZXmZ6Pkgs+54DafsY/1SnXMpeGGFtH?=
 =?us-ascii?Q?8GknO5ROfgh5/PgigBTarb13ANuEIwNKtpWs34blf9PSFj2FQhI+5dlIKIVa?=
 =?us-ascii?Q?f3uT4bhF4A3UjjEPVX/sW8bFNXbaf95RZMjf37JyB6Afs4AkbCeX3hATUhyw?=
 =?us-ascii?Q?9VW+xxR0e0I8m2Pzk1EBLlYAAYMM1cfGThUMyY1SnOkOVb+R2ypuafVlKlWM?=
 =?us-ascii?Q?i7RaUDhThXwFLqRoxPbs9Fl9QvWu0ALVGJXJF0hZFyQu9Y4kDQgbRvdi9YRn?=
 =?us-ascii?Q?ky5bvx+z0BXsOfJa08ZZOaW8duL2/E8Dtr3z/eQ9fteJD7dtNdZMuurqZdJQ?=
 =?us-ascii?Q?5ptTu+/oIUYB3L5GJVCtZ23pV398X3kBCImzU7kJbMtxB+0B5ygspACL2Yv+?=
 =?us-ascii?Q?NDhar4ZCe6c5cBEy7ODVCHqcXPDzqWOOiTuE6hvMQW6/0MjY7L7VeJZd64sK?=
 =?us-ascii?Q?+A=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C81A8CE423CA3D479F8DC4076365DBE5@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c882088-5c9c-4bb9-e468-08daa944b961
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2022 15:49:45.8948
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: w0RgTfwJFLnJovkl8FwfnJMivSgUni0Br+6AONQx9fcqB6Kxd48QT8j/8uJC1vL70fV3WvHqVWkz9H0TkjPXUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4257
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-10-07_04,2022-10-07_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 malwarescore=0 suspectscore=0 mlxscore=0 adultscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210080102
X-Proofpoint-ORIG-GUID: wlyTkm2rZdSeynVxR5dwKmokcb_ytcgr
X-Proofpoint-GUID: wlyTkm2rZdSeynVxR5dwKmokcb_ytcgr
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Oct 7, 2022, at 7:54 PM, Kees Cook <keescook@chromium.org> wrote:
>=20
> When built with Control Flow Integrity, function prototypes between
> caller and function declaration must match. These mismatches are visible
> at compile time with the new -Wcast-function-type-strict in Clang[1].
>=20
> There were 97 warnings produced by NFS. For example:
>=20
> fs/nfsd/nfs4xdr.c:2228:17: warning: cast from '__be32 (*)(struct nfsd4_co=
mpoundargs *, struct nfsd4_access *)' (aka 'unsigned int (*)(struct nfsd4_c=
ompoundargs *, struct nfsd4_access *)') to 'nfsd4_dec' (aka 'unsigned int (=
*)(struct nfsd4_compoundargs *, void *)') converts to incompatible function=
 type [-Wcast-function-type-strict]
>        [OP_ACCESS]             =3D (nfsd4_dec)nfsd4_decode_access,
>                                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>=20
> The enc/dec callbacks were defined as passing "void *" as the second
> argument, but were being implicitly cast to a new type. Replace the
> argument with a variable the desired to perform the casting in the
> function body. There are no resulting binary differences.

Hi Kees, thanks for the patch. I agree this internal API could be
cleaner and more type-safe. A few things I noticed:

- Your patch does not apply to HEAD probably because it conflicts with
3fdc54646234 ("NFSD: Reduce amount of struct nfsd4_compoundargs that
needs clearing")

- A union type might be a better fit for this application, as that
would avoid casting through an anonymous pointer. NFSD has a union
type, union nfsd4_op_u, that is ideal for this.

Would it make sense to use "union nfsd4_op_u *", such as is done in
fs/nfsd/current_stateid.h, in the definition of nfsd4_dec and nfsd4_enc ?


With regard to timing, I would prefer to queue this change for the
v6.2 merge window through the nfsd tree, if that's OK with you?


> Changes were made mechanically using the following Coccinelle script:
>=20
> @cast@
> identifier func;
> type T, opsT;
> identifier ops, N;
> @@
>=20
> opsT ops[] =3D {
> 	[N] =3D
> -	(T)
> 	func,
> };
>=20
> @already_void@
> identifier cast.func;
> identifier name;
> @@
>=20
> func(..., void *name)
> {
> 	...
> }
>=20
> @proto depends on !already_void@
> identifier cast.func;
> type T;
> identifier name;
> @@
>=20
> func(...,
> -	T name
> +	void *_arg
> ) {
> +	T name =3D _arg;
> 	...
>   }
>=20
> [1] https://reviews.llvm.org/D134831
>=20
> Cc: Chuck Lever <chuck.lever@oracle.com>
> Cc: Jeff Layton <jlayton@kernel.org>
> Cc: Gustavo A. R. Silva <gustavoars@kernel.org>
> Cc: linux-nfs@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
> fs/nfsd/nfs4xdr.c | 601 +++++++++++++++++++++++++++-------------------
> 1 file changed, 352 insertions(+), 249 deletions(-)
>=20
> diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
> index 1e9690a061ec..df059b03bdf2 100644
> --- a/fs/nfsd/nfs4xdr.c
> +++ b/fs/nfsd/nfs4xdr.c
> @@ -768,16 +768,18 @@ nfsd4_decode_cb_sec(struct nfsd4_compoundargs *argp=
, struct nfsd4_cb_sec *cbs)
>=20
> static __be32
> nfsd4_decode_access(struct nfsd4_compoundargs *argp,
> -		    struct nfsd4_access *access)
> +		    void *_arg)
> {
> +	struct nfsd4_access *access =3D _arg;
> 	if (xdr_stream_decode_u32(argp->xdr, &access->ac_req_access) < 0)
> 		return nfserr_bad_xdr;
> 	return nfs_ok;
> }
>=20
> static __be32
> -nfsd4_decode_close(struct nfsd4_compoundargs *argp, struct nfsd4_close *=
close)
> +nfsd4_decode_close(struct nfsd4_compoundargs *argp, void *_arg)
> {
> +	struct nfsd4_close *close =3D _arg;
> 	if (xdr_stream_decode_u32(argp->xdr, &close->cl_seqid) < 0)
> 		return nfserr_bad_xdr;
> 	return nfsd4_decode_stateid4(argp, &close->cl_stateid);
> @@ -785,8 +787,9 @@ nfsd4_decode_close(struct nfsd4_compoundargs *argp, s=
truct nfsd4_close *close)
>=20
>=20
> static __be32
> -nfsd4_decode_commit(struct nfsd4_compoundargs *argp, struct nfsd4_commit=
 *commit)
> +nfsd4_decode_commit(struct nfsd4_compoundargs *argp, void *_arg)
> {
> +	struct nfsd4_commit *commit =3D _arg;
> 	if (xdr_stream_decode_u64(argp->xdr, &commit->co_offset) < 0)
> 		return nfserr_bad_xdr;
> 	if (xdr_stream_decode_u32(argp->xdr, &commit->co_count) < 0)
> @@ -795,8 +798,9 @@ nfsd4_decode_commit(struct nfsd4_compoundargs *argp, =
struct nfsd4_commit *commit
> }
>=20
> static __be32
> -nfsd4_decode_create(struct nfsd4_compoundargs *argp, struct nfsd4_create=
 *create)
> +nfsd4_decode_create(struct nfsd4_compoundargs *argp, void *_arg)
> {
> +	struct nfsd4_create *create =3D _arg;
> 	__be32 *p, status;
>=20
> 	if (xdr_stream_decode_u32(argp->xdr, &create->cr_type) < 0)
> @@ -840,21 +844,24 @@ nfsd4_decode_create(struct nfsd4_compoundargs *argp=
, struct nfsd4_create *create
> }
>=20
> static inline __be32
> -nfsd4_decode_delegreturn(struct nfsd4_compoundargs *argp, struct nfsd4_d=
elegreturn *dr)
> +nfsd4_decode_delegreturn(struct nfsd4_compoundargs *argp, void *_arg)
> {
> +	struct nfsd4_delegreturn *dr =3D _arg;
> 	return nfsd4_decode_stateid4(argp, &dr->dr_stateid);
> }
>=20
> static inline __be32
> -nfsd4_decode_getattr(struct nfsd4_compoundargs *argp, struct nfsd4_getat=
tr *getattr)
> +nfsd4_decode_getattr(struct nfsd4_compoundargs *argp, void *_arg)
> {
> +	struct nfsd4_getattr *getattr =3D _arg;
> 	return nfsd4_decode_bitmap4(argp, getattr->ga_bmval,
> 				    ARRAY_SIZE(getattr->ga_bmval));
> }
>=20
> static __be32
> -nfsd4_decode_link(struct nfsd4_compoundargs *argp, struct nfsd4_link *li=
nk)
> +nfsd4_decode_link(struct nfsd4_compoundargs *argp, void *_arg)
> {
> +	struct nfsd4_link *link =3D _arg;
> 	return nfsd4_decode_component4(argp, &link->li_name, &link->li_namelen);
> }
>=20
> @@ -901,8 +908,9 @@ nfsd4_decode_locker4(struct nfsd4_compoundargs *argp,=
 struct nfsd4_lock *lock)
> }
>=20
> static __be32
> -nfsd4_decode_lock(struct nfsd4_compoundargs *argp, struct nfsd4_lock *lo=
ck)
> +nfsd4_decode_lock(struct nfsd4_compoundargs *argp, void *_arg)
> {
> +	struct nfsd4_lock *lock =3D _arg;
> 	if (xdr_stream_decode_u32(argp->xdr, &lock->lk_type) < 0)
> 		return nfserr_bad_xdr;
> 	if ((lock->lk_type < NFS4_READ_LT) || (lock->lk_type > NFS4_WRITEW_LT))
> @@ -917,8 +925,9 @@ nfsd4_decode_lock(struct nfsd4_compoundargs *argp, st=
ruct nfsd4_lock *lock)
> }
>=20
> static __be32
> -nfsd4_decode_lockt(struct nfsd4_compoundargs *argp, struct nfsd4_lockt *=
lockt)
> +nfsd4_decode_lockt(struct nfsd4_compoundargs *argp, void *_arg)
> {
> +	struct nfsd4_lockt *lockt =3D _arg;
> 	if (xdr_stream_decode_u32(argp->xdr, &lockt->lt_type) < 0)
> 		return nfserr_bad_xdr;
> 	if ((lockt->lt_type < NFS4_READ_LT) || (lockt->lt_type > NFS4_WRITEW_LT)=
)
> @@ -932,8 +941,9 @@ nfsd4_decode_lockt(struct nfsd4_compoundargs *argp, s=
truct nfsd4_lockt *lockt)
> }
>=20
> static __be32
> -nfsd4_decode_locku(struct nfsd4_compoundargs *argp, struct nfsd4_locku *=
locku)
> +nfsd4_decode_locku(struct nfsd4_compoundargs *argp, void *_arg)
> {
> +	struct nfsd4_locku *locku =3D _arg;
> 	__be32 status;
>=20
> 	if (xdr_stream_decode_u32(argp->xdr, &locku->lu_type) < 0)
> @@ -954,8 +964,9 @@ nfsd4_decode_locku(struct nfsd4_compoundargs *argp, s=
truct nfsd4_locku *locku)
> }
>=20
> static __be32
> -nfsd4_decode_lookup(struct nfsd4_compoundargs *argp, struct nfsd4_lookup=
 *lookup)
> +nfsd4_decode_lookup(struct nfsd4_compoundargs *argp, void *_arg)
> {
> +	struct nfsd4_lookup *lookup =3D _arg;
> 	return nfsd4_decode_component4(argp, &lookup->lo_name, &lookup->lo_len);
> }
>=20
> @@ -1135,8 +1146,9 @@ nfsd4_decode_open_claim4(struct nfsd4_compoundargs =
*argp,
> }
>=20
> static __be32
> -nfsd4_decode_open(struct nfsd4_compoundargs *argp, struct nfsd4_open *op=
en)
> +nfsd4_decode_open(struct nfsd4_compoundargs *argp, void *_arg)
> {
> +	struct nfsd4_open *open =3D _arg;
> 	__be32 status;
> 	u32 dummy;
>=20
> @@ -1166,8 +1178,9 @@ nfsd4_decode_open(struct nfsd4_compoundargs *argp, =
struct nfsd4_open *open)
> }
>=20
> static __be32
> -nfsd4_decode_open_confirm(struct nfsd4_compoundargs *argp, struct nfsd4_=
open_confirm *open_conf)
> +nfsd4_decode_open_confirm(struct nfsd4_compoundargs *argp, void *_arg)
> {
> +	struct nfsd4_open_confirm *open_conf =3D _arg;
> 	__be32 status;
>=20
> 	if (argp->minorversion >=3D 1)
> @@ -1183,8 +1196,9 @@ nfsd4_decode_open_confirm(struct nfsd4_compoundargs=
 *argp, struct nfsd4_open_con
> }
>=20
> static __be32
> -nfsd4_decode_open_downgrade(struct nfsd4_compoundargs *argp, struct nfsd=
4_open_downgrade *open_down)
> +nfsd4_decode_open_downgrade(struct nfsd4_compoundargs *argp, void *_arg)
> {
> +	struct nfsd4_open_downgrade *open_down =3D _arg;
> 	__be32 status;
>=20
> 	status =3D nfsd4_decode_stateid4(argp, &open_down->od_stateid);
> @@ -1201,8 +1215,9 @@ nfsd4_decode_open_downgrade(struct nfsd4_compoundar=
gs *argp, struct nfsd4_open_d
> }
>=20
> static __be32
> -nfsd4_decode_putfh(struct nfsd4_compoundargs *argp, struct nfsd4_putfh *=
putfh)
> +nfsd4_decode_putfh(struct nfsd4_compoundargs *argp, void *_arg)
> {
> +	struct nfsd4_putfh *putfh =3D _arg;
> 	__be32 *p;
>=20
> 	if (xdr_stream_decode_u32(argp->xdr, &putfh->pf_fhlen) < 0)
> @@ -1228,8 +1243,9 @@ nfsd4_decode_putpubfh(struct nfsd4_compoundargs *ar=
gp, void *p)
> }
>=20
> static __be32
> -nfsd4_decode_read(struct nfsd4_compoundargs *argp, struct nfsd4_read *re=
ad)
> +nfsd4_decode_read(struct nfsd4_compoundargs *argp, void *_arg)
> {
> +	struct nfsd4_read *read =3D _arg;
> 	__be32 status;
>=20
> 	status =3D nfsd4_decode_stateid4(argp, &read->rd_stateid);
> @@ -1244,8 +1260,9 @@ nfsd4_decode_read(struct nfsd4_compoundargs *argp, =
struct nfsd4_read *read)
> }
>=20
> static __be32
> -nfsd4_decode_readdir(struct nfsd4_compoundargs *argp, struct nfsd4_readd=
ir *readdir)
> +nfsd4_decode_readdir(struct nfsd4_compoundargs *argp, void *_arg)
> {
> +	struct nfsd4_readdir *readdir =3D _arg;
> 	__be32 status;
>=20
> 	if (xdr_stream_decode_u64(argp->xdr, &readdir->rd_cookie) < 0)
> @@ -1265,14 +1282,16 @@ nfsd4_decode_readdir(struct nfsd4_compoundargs *a=
rgp, struct nfsd4_readdir *read
> }
>=20
> static __be32
> -nfsd4_decode_remove(struct nfsd4_compoundargs *argp, struct nfsd4_remove=
 *remove)
> +nfsd4_decode_remove(struct nfsd4_compoundargs *argp, void *_arg)
> {
> +	struct nfsd4_remove *remove =3D _arg;
> 	return nfsd4_decode_component4(argp, &remove->rm_name, &remove->rm_namel=
en);
> }
>=20
> static __be32
> -nfsd4_decode_rename(struct nfsd4_compoundargs *argp, struct nfsd4_rename=
 *rename)
> +nfsd4_decode_rename(struct nfsd4_compoundargs *argp, void *_arg)
> {
> +	struct nfsd4_rename *rename =3D _arg;
> 	__be32 status;
>=20
> 	status =3D nfsd4_decode_component4(argp, &rename->rn_sname, &rename->rn_=
snamelen);
> @@ -1282,21 +1301,24 @@ nfsd4_decode_rename(struct nfsd4_compoundargs *ar=
gp, struct nfsd4_rename *rename
> }
>=20
> static __be32
> -nfsd4_decode_renew(struct nfsd4_compoundargs *argp, clientid_t *clientid=
)
> +nfsd4_decode_renew(struct nfsd4_compoundargs *argp, void *_arg)
> {
> +	clientid_t *clientid =3D _arg;
> 	return nfsd4_decode_clientid4(argp, clientid);
> }
>=20
> static __be32
> nfsd4_decode_secinfo(struct nfsd4_compoundargs *argp,
> -		     struct nfsd4_secinfo *secinfo)
> +		     void *_arg)
> {
> +	struct nfsd4_secinfo *secinfo =3D _arg;
> 	return nfsd4_decode_component4(argp, &secinfo->si_name, &secinfo->si_nam=
elen);
> }
>=20
> static __be32
> -nfsd4_decode_setattr(struct nfsd4_compoundargs *argp, struct nfsd4_setat=
tr *setattr)
> +nfsd4_decode_setattr(struct nfsd4_compoundargs *argp, void *_arg)
> {
> +	struct nfsd4_setattr *setattr =3D _arg;
> 	__be32 status;
>=20
> 	status =3D nfsd4_decode_stateid4(argp, &setattr->sa_stateid);
> @@ -1309,8 +1331,9 @@ nfsd4_decode_setattr(struct nfsd4_compoundargs *arg=
p, struct nfsd4_setattr *seta
> }
>=20
> static __be32
> -nfsd4_decode_setclientid(struct nfsd4_compoundargs *argp, struct nfsd4_s=
etclientid *setclientid)
> +nfsd4_decode_setclientid(struct nfsd4_compoundargs *argp, void *_arg)
> {
> +	struct nfsd4_setclientid *setclientid =3D _arg;
> 	__be32 *p, status;
>=20
> 	if (argp->minorversion >=3D 1)
> @@ -1350,8 +1373,9 @@ nfsd4_decode_setclientid(struct nfsd4_compoundargs =
*argp, struct nfsd4_setclient
> }
>=20
> static __be32
> -nfsd4_decode_setclientid_confirm(struct nfsd4_compoundargs *argp, struct=
 nfsd4_setclientid_confirm *scd_c)
> +nfsd4_decode_setclientid_confirm(struct nfsd4_compoundargs *argp, void *=
_arg)
> {
> +	struct nfsd4_setclientid_confirm *scd_c =3D _arg;
> 	__be32 status;
>=20
> 	if (argp->minorversion >=3D 1)
> @@ -1365,8 +1389,9 @@ nfsd4_decode_setclientid_confirm(struct nfsd4_compo=
undargs *argp, struct nfsd4_s
>=20
> /* Also used for NVERIFY */
> static __be32
> -nfsd4_decode_verify(struct nfsd4_compoundargs *argp, struct nfsd4_verify=
 *verify)
> +nfsd4_decode_verify(struct nfsd4_compoundargs *argp, void *_arg)
> {
> +	struct nfsd4_verify *verify =3D _arg;
> 	__be32 *p, status;
>=20
> 	status =3D nfsd4_decode_bitmap4(argp, verify->ve_bmval,
> @@ -1390,8 +1415,9 @@ nfsd4_decode_verify(struct nfsd4_compoundargs *argp=
, struct nfsd4_verify *verify
> }
>=20
> static __be32
> -nfsd4_decode_write(struct nfsd4_compoundargs *argp, struct nfsd4_write *=
write)
> +nfsd4_decode_write(struct nfsd4_compoundargs *argp, void *_arg)
> {
> +	struct nfsd4_write *write =3D _arg;
> 	__be32 status;
>=20
> 	status =3D nfsd4_decode_stateid4(argp, &write->wr_stateid);
> @@ -1412,8 +1438,9 @@ nfsd4_decode_write(struct nfsd4_compoundargs *argp,=
 struct nfsd4_write *write)
> }
>=20
> static __be32
> -nfsd4_decode_release_lockowner(struct nfsd4_compoundargs *argp, struct n=
fsd4_release_lockowner *rlockowner)
> +nfsd4_decode_release_lockowner(struct nfsd4_compoundargs *argp, void *_a=
rg)
> {
> +	struct nfsd4_release_lockowner *rlockowner =3D _arg;
> 	__be32 status;
>=20
> 	if (argp->minorversion >=3D 1)
> @@ -1430,15 +1457,19 @@ nfsd4_decode_release_lockowner(struct nfsd4_compo=
undargs *argp, struct nfsd4_rel
> 	return nfs_ok;
> }
>=20
> -static __be32 nfsd4_decode_backchannel_ctl(struct nfsd4_compoundargs *ar=
gp, struct nfsd4_backchannel_ctl *bc)
> +static __be32 nfsd4_decode_backchannel_ctl(struct nfsd4_compoundargs *ar=
gp,
> +					   void *_arg)
> {
> +	struct nfsd4_backchannel_ctl *bc =3D _arg;
> 	if (xdr_stream_decode_u32(argp->xdr, &bc->bc_cb_program) < 0)
> 		return nfserr_bad_xdr;
> 	return nfsd4_decode_cb_sec(argp, &bc->bc_cb_sec);
> }
>=20
> -static __be32 nfsd4_decode_bind_conn_to_session(struct nfsd4_compoundarg=
s *argp, struct nfsd4_bind_conn_to_session *bcts)
> +static __be32 nfsd4_decode_bind_conn_to_session(struct nfsd4_compoundarg=
s *argp,
> +						void *_arg)
> {
> +	struct nfsd4_bind_conn_to_session *bcts =3D _arg;
> 	u32 use_conn_in_rdma_mode;
> 	__be32 status;
>=20
> @@ -1579,8 +1610,9 @@ nfsd4_decode_nfs_impl_id4(struct nfsd4_compoundargs=
 *argp,
>=20
> static __be32
> nfsd4_decode_exchange_id(struct nfsd4_compoundargs *argp,
> -			 struct nfsd4_exchange_id *exid)
> +			 void *_arg)
> {
> +	struct nfsd4_exchange_id *exid =3D _arg;
> 	__be32 status;
>=20
> 	status =3D nfsd4_decode_verifier4(argp, &exid->verifier);
> @@ -1631,8 +1663,9 @@ nfsd4_decode_channel_attrs4(struct nfsd4_compoundar=
gs *argp,
>=20
> static __be32
> nfsd4_decode_create_session(struct nfsd4_compoundargs *argp,
> -			    struct nfsd4_create_session *sess)
> +			    void *_arg)
> {
> +	struct nfsd4_create_session *sess =3D _arg;
> 	__be32 status;
>=20
> 	status =3D nfsd4_decode_clientid4(argp, &sess->clientid);
> @@ -1659,23 +1692,26 @@ nfsd4_decode_create_session(struct nfsd4_compound=
args *argp,
>=20
> static __be32
> nfsd4_decode_destroy_session(struct nfsd4_compoundargs *argp,
> -			     struct nfsd4_destroy_session *destroy_session)
> +			     void *_arg)
> {
> +	struct nfsd4_destroy_session *destroy_session =3D _arg;
> 	return nfsd4_decode_sessionid4(argp, &destroy_session->sessionid);
> }
>=20
> static __be32
> nfsd4_decode_free_stateid(struct nfsd4_compoundargs *argp,
> -			  struct nfsd4_free_stateid *free_stateid)
> +			  void *_arg)
> {
> +	struct nfsd4_free_stateid *free_stateid =3D _arg;
> 	return nfsd4_decode_stateid4(argp, &free_stateid->fr_stateid);
> }
>=20
> #ifdef CONFIG_NFSD_PNFS
> static __be32
> nfsd4_decode_getdeviceinfo(struct nfsd4_compoundargs *argp,
> -		struct nfsd4_getdeviceinfo *gdev)
> +		void *_arg)
> {
> +	struct nfsd4_getdeviceinfo *gdev =3D _arg;
> 	__be32 status;
>=20
> 	status =3D nfsd4_decode_deviceid4(argp, &gdev->gd_devid);
> @@ -1694,8 +1730,9 @@ nfsd4_decode_getdeviceinfo(struct nfsd4_compoundarg=
s *argp,
>=20
> static __be32
> nfsd4_decode_layoutcommit(struct nfsd4_compoundargs *argp,
> -			  struct nfsd4_layoutcommit *lcp)
> +			  void *_arg)
> {
> +	struct nfsd4_layoutcommit *lcp =3D _arg;
> 	__be32 *p, status;
>=20
> 	if (xdr_stream_decode_u64(argp->xdr, &lcp->lc_seg.offset) < 0)
> @@ -1729,8 +1766,9 @@ nfsd4_decode_layoutcommit(struct nfsd4_compoundargs=
 *argp,
>=20
> static __be32
> nfsd4_decode_layoutget(struct nfsd4_compoundargs *argp,
> -		struct nfsd4_layoutget *lgp)
> +		void *_arg)
> {
> +	struct nfsd4_layoutget *lgp =3D _arg;
> 	__be32 status;
>=20
> 	if (xdr_stream_decode_u32(argp->xdr, &lgp->lg_signal) < 0)
> @@ -1756,8 +1794,9 @@ nfsd4_decode_layoutget(struct nfsd4_compoundargs *a=
rgp,
>=20
> static __be32
> nfsd4_decode_layoutreturn(struct nfsd4_compoundargs *argp,
> -		struct nfsd4_layoutreturn *lrp)
> +		void *_arg)
> {
> +	struct nfsd4_layoutreturn *lrp =3D _arg;
> 	if (xdr_stream_decode_bool(argp->xdr, &lrp->lr_reclaim) < 0)
> 		return nfserr_bad_xdr;
> 	if (xdr_stream_decode_u32(argp->xdr, &lrp->lr_layout_type) < 0)
> @@ -1769,8 +1808,9 @@ nfsd4_decode_layoutreturn(struct nfsd4_compoundargs=
 *argp,
> #endif /* CONFIG_NFSD_PNFS */
>=20
> static __be32 nfsd4_decode_secinfo_no_name(struct nfsd4_compoundargs *arg=
p,
> -					   struct nfsd4_secinfo_no_name *sin)
> +					   void *_arg)
> {
> +	struct nfsd4_secinfo_no_name *sin =3D _arg;
> 	if (xdr_stream_decode_u32(argp->xdr, &sin->sin_style) < 0)
> 		return nfserr_bad_xdr;
> 	return nfs_ok;
> @@ -1778,8 +1818,9 @@ static __be32 nfsd4_decode_secinfo_no_name(struct n=
fsd4_compoundargs *argp,
>=20
> static __be32
> nfsd4_decode_sequence(struct nfsd4_compoundargs *argp,
> -		      struct nfsd4_sequence *seq)
> +		      void *_arg)
> {
> +	struct nfsd4_sequence *seq =3D _arg;
> 	__be32 *p, status;
>=20
> 	status =3D nfsd4_decode_sessionid4(argp, &seq->sessionid);
> @@ -1797,8 +1838,9 @@ nfsd4_decode_sequence(struct nfsd4_compoundargs *ar=
gp,
> }
>=20
> static __be32
> -nfsd4_decode_test_stateid(struct nfsd4_compoundargs *argp, struct nfsd4_=
test_stateid *test_stateid)
> +nfsd4_decode_test_stateid(struct nfsd4_compoundargs *argp, void *_arg)
> {
> +	struct nfsd4_test_stateid *test_stateid =3D _arg;
> 	struct nfsd4_test_stateid_id *stateid;
> 	__be32 status;
> 	u32 i;
> @@ -1822,14 +1864,16 @@ nfsd4_decode_test_stateid(struct nfsd4_compoundar=
gs *argp, struct nfsd4_test_sta
> }
>=20
> static __be32 nfsd4_decode_destroy_clientid(struct nfsd4_compoundargs *ar=
gp,
> -					    struct nfsd4_destroy_clientid *dc)
> +					    void *_arg)
> {
> +	struct nfsd4_destroy_clientid *dc =3D _arg;
> 	return nfsd4_decode_clientid4(argp, &dc->clientid);
> }
>=20
> static __be32 nfsd4_decode_reclaim_complete(struct nfsd4_compoundargs *ar=
gp,
> -					    struct nfsd4_reclaim_complete *rc)
> +					    void *_arg)
> {
> +	struct nfsd4_reclaim_complete *rc =3D _arg;
> 	if (xdr_stream_decode_bool(argp->xdr, &rc->rca_one_fs) < 0)
> 		return nfserr_bad_xdr;
> 	return nfs_ok;
> @@ -1837,8 +1881,9 @@ static __be32 nfsd4_decode_reclaim_complete(struct =
nfsd4_compoundargs *argp,
>=20
> static __be32
> nfsd4_decode_fallocate(struct nfsd4_compoundargs *argp,
> -		       struct nfsd4_fallocate *fallocate)
> +		       void *_arg)
> {
> +	struct nfsd4_fallocate *fallocate =3D _arg;
> 	__be32 status;
>=20
> 	status =3D nfsd4_decode_stateid4(argp, &fallocate->falloc_stateid);
> @@ -1894,8 +1939,9 @@ static __be32 nfsd4_decode_nl4_server(struct nfsd4_=
compoundargs *argp,
> }
>=20
> static __be32
> -nfsd4_decode_copy(struct nfsd4_compoundargs *argp, struct nfsd4_copy *co=
py)
> +nfsd4_decode_copy(struct nfsd4_compoundargs *argp, void *_arg)
> {
> +	struct nfsd4_copy *copy =3D _arg;
> 	u32 consecutive, i, count, sync;
> 	struct nl4_server *ns_dummy;
> 	__be32 status;
> @@ -1951,8 +1997,9 @@ nfsd4_decode_copy(struct nfsd4_compoundargs *argp, =
struct nfsd4_copy *copy)
>=20
> static __be32
> nfsd4_decode_copy_notify(struct nfsd4_compoundargs *argp,
> -			 struct nfsd4_copy_notify *cn)
> +			 void *_arg)
> {
> +	struct nfsd4_copy_notify *cn =3D _arg;
> 	__be32 status;
>=20
> 	cn->cpn_src =3D svcxdr_tmpalloc(argp, sizeof(*cn->cpn_src));
> @@ -1970,14 +2017,16 @@ nfsd4_decode_copy_notify(struct nfsd4_compoundarg=
s *argp,
>=20
> static __be32
> nfsd4_decode_offload_status(struct nfsd4_compoundargs *argp,
> -			    struct nfsd4_offload_status *os)
> +			    void *_arg)
> {
> +	struct nfsd4_offload_status *os =3D _arg;
> 	return nfsd4_decode_stateid4(argp, &os->stateid);
> }
>=20
> static __be32
> -nfsd4_decode_seek(struct nfsd4_compoundargs *argp, struct nfsd4_seek *se=
ek)
> +nfsd4_decode_seek(struct nfsd4_compoundargs *argp, void *_arg)
> {
> +	struct nfsd4_seek *seek =3D _arg;
> 	__be32 status;
>=20
> 	status =3D nfsd4_decode_stateid4(argp, &seek->seek_stateid);
> @@ -1992,8 +2041,9 @@ nfsd4_decode_seek(struct nfsd4_compoundargs *argp, =
struct nfsd4_seek *seek)
> }
>=20
> static __be32
> -nfsd4_decode_clone(struct nfsd4_compoundargs *argp, struct nfsd4_clone *=
clone)
> +nfsd4_decode_clone(struct nfsd4_compoundargs *argp, void *_arg)
> {
> +	struct nfsd4_clone *clone =3D _arg;
> 	__be32 status;
>=20
> 	status =3D nfsd4_decode_stateid4(argp, &clone->cl_src_stateid);
> @@ -2118,8 +2168,9 @@ nfsd4_decode_xattr_name(struct nfsd4_compoundargs *=
argp, char **namep)
>  */
> static __be32
> nfsd4_decode_getxattr(struct nfsd4_compoundargs *argp,
> -		      struct nfsd4_getxattr *getxattr)
> +		      void *_arg)
> {
> +	struct nfsd4_getxattr *getxattr =3D _arg;
> 	__be32 status;
> 	u32 maxcount;
>=20
> @@ -2137,8 +2188,9 @@ nfsd4_decode_getxattr(struct nfsd4_compoundargs *ar=
gp,
>=20
> static __be32
> nfsd4_decode_setxattr(struct nfsd4_compoundargs *argp,
> -		      struct nfsd4_setxattr *setxattr)
> +		      void *_arg)
> {
> +	struct nfsd4_setxattr *setxattr =3D _arg;
> 	u32 flags, maxcount, size;
> 	__be32 status;
>=20
> @@ -2176,8 +2228,9 @@ nfsd4_decode_setxattr(struct nfsd4_compoundargs *ar=
gp,
>=20
> static __be32
> nfsd4_decode_listxattrs(struct nfsd4_compoundargs *argp,
> -			struct nfsd4_listxattrs *listxattrs)
> +			void *_arg)
> {
> +	struct nfsd4_listxattrs *listxattrs =3D _arg;
> 	u32 maxcount;
>=20
> 	if (xdr_stream_decode_u64(argp->xdr, &listxattrs->lsxa_cookie) < 0)
> @@ -2205,8 +2258,9 @@ nfsd4_decode_listxattrs(struct nfsd4_compoundargs *=
argp,
>=20
> static __be32
> nfsd4_decode_removexattr(struct nfsd4_compoundargs *argp,
> -			 struct nfsd4_removexattr *removexattr)
> +			 void *_arg)
> {
> +	struct nfsd4_removexattr *removexattr =3D _arg;
> 	return nfsd4_decode_xattr_name(argp, &removexattr->rmxa_name);
> }
>=20
> @@ -2225,92 +2279,92 @@ nfsd4_decode_notsupp(struct nfsd4_compoundargs *a=
rgp, void *p)
> typedef __be32(*nfsd4_dec)(struct nfsd4_compoundargs *argp, void *);
>=20
> static const nfsd4_dec nfsd4_dec_ops[] =3D {
> -	[OP_ACCESS]		=3D (nfsd4_dec)nfsd4_decode_access,
> -	[OP_CLOSE]		=3D (nfsd4_dec)nfsd4_decode_close,
> -	[OP_COMMIT]		=3D (nfsd4_dec)nfsd4_decode_commit,
> -	[OP_CREATE]		=3D (nfsd4_dec)nfsd4_decode_create,
> -	[OP_DELEGPURGE]		=3D (nfsd4_dec)nfsd4_decode_notsupp,
> -	[OP_DELEGRETURN]	=3D (nfsd4_dec)nfsd4_decode_delegreturn,
> -	[OP_GETATTR]		=3D (nfsd4_dec)nfsd4_decode_getattr,
> -	[OP_GETFH]		=3D (nfsd4_dec)nfsd4_decode_noop,
> -	[OP_LINK]		=3D (nfsd4_dec)nfsd4_decode_link,
> -	[OP_LOCK]		=3D (nfsd4_dec)nfsd4_decode_lock,
> -	[OP_LOCKT]		=3D (nfsd4_dec)nfsd4_decode_lockt,
> -	[OP_LOCKU]		=3D (nfsd4_dec)nfsd4_decode_locku,
> -	[OP_LOOKUP]		=3D (nfsd4_dec)nfsd4_decode_lookup,
> -	[OP_LOOKUPP]		=3D (nfsd4_dec)nfsd4_decode_noop,
> -	[OP_NVERIFY]		=3D (nfsd4_dec)nfsd4_decode_verify,
> -	[OP_OPEN]		=3D (nfsd4_dec)nfsd4_decode_open,
> -	[OP_OPENATTR]		=3D (nfsd4_dec)nfsd4_decode_notsupp,
> -	[OP_OPEN_CONFIRM]	=3D (nfsd4_dec)nfsd4_decode_open_confirm,
> -	[OP_OPEN_DOWNGRADE]	=3D (nfsd4_dec)nfsd4_decode_open_downgrade,
> -	[OP_PUTFH]		=3D (nfsd4_dec)nfsd4_decode_putfh,
> -	[OP_PUTPUBFH]		=3D (nfsd4_dec)nfsd4_decode_putpubfh,
> -	[OP_PUTROOTFH]		=3D (nfsd4_dec)nfsd4_decode_noop,
> -	[OP_READ]		=3D (nfsd4_dec)nfsd4_decode_read,
> -	[OP_READDIR]		=3D (nfsd4_dec)nfsd4_decode_readdir,
> -	[OP_READLINK]		=3D (nfsd4_dec)nfsd4_decode_noop,
> -	[OP_REMOVE]		=3D (nfsd4_dec)nfsd4_decode_remove,
> -	[OP_RENAME]		=3D (nfsd4_dec)nfsd4_decode_rename,
> -	[OP_RENEW]		=3D (nfsd4_dec)nfsd4_decode_renew,
> -	[OP_RESTOREFH]		=3D (nfsd4_dec)nfsd4_decode_noop,
> -	[OP_SAVEFH]		=3D (nfsd4_dec)nfsd4_decode_noop,
> -	[OP_SECINFO]		=3D (nfsd4_dec)nfsd4_decode_secinfo,
> -	[OP_SETATTR]		=3D (nfsd4_dec)nfsd4_decode_setattr,
> -	[OP_SETCLIENTID]	=3D (nfsd4_dec)nfsd4_decode_setclientid,
> -	[OP_SETCLIENTID_CONFIRM] =3D (nfsd4_dec)nfsd4_decode_setclientid_confir=
m,
> -	[OP_VERIFY]		=3D (nfsd4_dec)nfsd4_decode_verify,
> -	[OP_WRITE]		=3D (nfsd4_dec)nfsd4_decode_write,
> -	[OP_RELEASE_LOCKOWNER]	=3D (nfsd4_dec)nfsd4_decode_release_lockowner,
> +	[OP_ACCESS]		=3D nfsd4_decode_access,
> +	[OP_CLOSE]		=3D nfsd4_decode_close,
> +	[OP_COMMIT]		=3D nfsd4_decode_commit,
> +	[OP_CREATE]		=3D nfsd4_decode_create,
> +	[OP_DELEGPURGE]		=3D nfsd4_decode_notsupp,
> +	[OP_DELEGRETURN]	=3D nfsd4_decode_delegreturn,
> +	[OP_GETATTR]		=3D nfsd4_decode_getattr,
> +	[OP_GETFH]		=3D nfsd4_decode_noop,
> +	[OP_LINK]		=3D nfsd4_decode_link,
> +	[OP_LOCK]		=3D nfsd4_decode_lock,
> +	[OP_LOCKT]		=3D nfsd4_decode_lockt,
> +	[OP_LOCKU]		=3D nfsd4_decode_locku,
> +	[OP_LOOKUP]		=3D nfsd4_decode_lookup,
> +	[OP_LOOKUPP]		=3D nfsd4_decode_noop,
> +	[OP_NVERIFY]		=3D nfsd4_decode_verify,
> +	[OP_OPEN]		=3D nfsd4_decode_open,
> +	[OP_OPENATTR]		=3D nfsd4_decode_notsupp,
> +	[OP_OPEN_CONFIRM]	=3D nfsd4_decode_open_confirm,
> +	[OP_OPEN_DOWNGRADE]	=3D nfsd4_decode_open_downgrade,
> +	[OP_PUTFH]		=3D nfsd4_decode_putfh,
> +	[OP_PUTPUBFH]		=3D nfsd4_decode_putpubfh,
> +	[OP_PUTROOTFH]		=3D nfsd4_decode_noop,
> +	[OP_READ]		=3D nfsd4_decode_read,
> +	[OP_READDIR]		=3D nfsd4_decode_readdir,
> +	[OP_READLINK]		=3D nfsd4_decode_noop,
> +	[OP_REMOVE]		=3D nfsd4_decode_remove,
> +	[OP_RENAME]		=3D nfsd4_decode_rename,
> +	[OP_RENEW]		=3D nfsd4_decode_renew,
> +	[OP_RESTOREFH]		=3D nfsd4_decode_noop,
> +	[OP_SAVEFH]		=3D nfsd4_decode_noop,
> +	[OP_SECINFO]		=3D nfsd4_decode_secinfo,
> +	[OP_SETATTR]		=3D nfsd4_decode_setattr,
> +	[OP_SETCLIENTID]	=3D nfsd4_decode_setclientid,
> +	[OP_SETCLIENTID_CONFIRM] =3D nfsd4_decode_setclientid_confirm,
> +	[OP_VERIFY]		=3D nfsd4_decode_verify,
> +	[OP_WRITE]		=3D nfsd4_decode_write,
> +	[OP_RELEASE_LOCKOWNER]	=3D nfsd4_decode_release_lockowner,
>=20
> 	/* new operations for NFSv4.1 */
> -	[OP_BACKCHANNEL_CTL]	=3D (nfsd4_dec)nfsd4_decode_backchannel_ctl,
> -	[OP_BIND_CONN_TO_SESSION]=3D (nfsd4_dec)nfsd4_decode_bind_conn_to_sessi=
on,
> -	[OP_EXCHANGE_ID]	=3D (nfsd4_dec)nfsd4_decode_exchange_id,
> -	[OP_CREATE_SESSION]	=3D (nfsd4_dec)nfsd4_decode_create_session,
> -	[OP_DESTROY_SESSION]	=3D (nfsd4_dec)nfsd4_decode_destroy_session,
> -	[OP_FREE_STATEID]	=3D (nfsd4_dec)nfsd4_decode_free_stateid,
> -	[OP_GET_DIR_DELEGATION]	=3D (nfsd4_dec)nfsd4_decode_notsupp,
> +	[OP_BACKCHANNEL_CTL]	=3D nfsd4_decode_backchannel_ctl,
> +	[OP_BIND_CONN_TO_SESSION] =3D nfsd4_decode_bind_conn_to_session,
> +	[OP_EXCHANGE_ID]	=3D nfsd4_decode_exchange_id,
> +	[OP_CREATE_SESSION]	=3D nfsd4_decode_create_session,
> +	[OP_DESTROY_SESSION]	=3D nfsd4_decode_destroy_session,
> +	[OP_FREE_STATEID]	=3D nfsd4_decode_free_stateid,
> +	[OP_GET_DIR_DELEGATION]	=3D nfsd4_decode_notsupp,
> #ifdef CONFIG_NFSD_PNFS
> -	[OP_GETDEVICEINFO]	=3D (nfsd4_dec)nfsd4_decode_getdeviceinfo,
> -	[OP_GETDEVICELIST]	=3D (nfsd4_dec)nfsd4_decode_notsupp,
> -	[OP_LAYOUTCOMMIT]	=3D (nfsd4_dec)nfsd4_decode_layoutcommit,
> -	[OP_LAYOUTGET]		=3D (nfsd4_dec)nfsd4_decode_layoutget,
> -	[OP_LAYOUTRETURN]	=3D (nfsd4_dec)nfsd4_decode_layoutreturn,
> +	[OP_GETDEVICEINFO]	=3D nfsd4_decode_getdeviceinfo,
> +	[OP_GETDEVICELIST]	=3D nfsd4_decode_notsupp,
> +	[OP_LAYOUTCOMMIT]	=3D nfsd4_decode_layoutcommit,
> +	[OP_LAYOUTGET]		=3D nfsd4_decode_layoutget,
> +	[OP_LAYOUTRETURN]	=3D nfsd4_decode_layoutreturn,
> #else
> -	[OP_GETDEVICEINFO]	=3D (nfsd4_dec)nfsd4_decode_notsupp,
> -	[OP_GETDEVICELIST]	=3D (nfsd4_dec)nfsd4_decode_notsupp,
> -	[OP_LAYOUTCOMMIT]	=3D (nfsd4_dec)nfsd4_decode_notsupp,
> -	[OP_LAYOUTGET]		=3D (nfsd4_dec)nfsd4_decode_notsupp,
> -	[OP_LAYOUTRETURN]	=3D (nfsd4_dec)nfsd4_decode_notsupp,
> +	[OP_GETDEVICEINFO]	=3D nfsd4_decode_notsupp,
> +	[OP_GETDEVICELIST]	=3D nfsd4_decode_notsupp,
> +	[OP_LAYOUTCOMMIT]	=3D nfsd4_decode_notsupp,
> +	[OP_LAYOUTGET]		=3D nfsd4_decode_notsupp,
> +	[OP_LAYOUTRETURN]	=3D nfsd4_decode_notsupp,
> #endif
> -	[OP_SECINFO_NO_NAME]	=3D (nfsd4_dec)nfsd4_decode_secinfo_no_name,
> -	[OP_SEQUENCE]		=3D (nfsd4_dec)nfsd4_decode_sequence,
> -	[OP_SET_SSV]		=3D (nfsd4_dec)nfsd4_decode_notsupp,
> -	[OP_TEST_STATEID]	=3D (nfsd4_dec)nfsd4_decode_test_stateid,
> -	[OP_WANT_DELEGATION]	=3D (nfsd4_dec)nfsd4_decode_notsupp,
> -	[OP_DESTROY_CLIENTID]	=3D (nfsd4_dec)nfsd4_decode_destroy_clientid,
> -	[OP_RECLAIM_COMPLETE]	=3D (nfsd4_dec)nfsd4_decode_reclaim_complete,
> +	[OP_SECINFO_NO_NAME]	=3D nfsd4_decode_secinfo_no_name,
> +	[OP_SEQUENCE]		=3D nfsd4_decode_sequence,
> +	[OP_SET_SSV]		=3D nfsd4_decode_notsupp,
> +	[OP_TEST_STATEID]	=3D nfsd4_decode_test_stateid,
> +	[OP_WANT_DELEGATION]	=3D nfsd4_decode_notsupp,
> +	[OP_DESTROY_CLIENTID]	=3D nfsd4_decode_destroy_clientid,
> +	[OP_RECLAIM_COMPLETE]	=3D nfsd4_decode_reclaim_complete,
>=20
> 	/* new operations for NFSv4.2 */
> -	[OP_ALLOCATE]		=3D (nfsd4_dec)nfsd4_decode_fallocate,
> -	[OP_COPY]		=3D (nfsd4_dec)nfsd4_decode_copy,
> -	[OP_COPY_NOTIFY]	=3D (nfsd4_dec)nfsd4_decode_copy_notify,
> -	[OP_DEALLOCATE]		=3D (nfsd4_dec)nfsd4_decode_fallocate,
> -	[OP_IO_ADVISE]		=3D (nfsd4_dec)nfsd4_decode_notsupp,
> -	[OP_LAYOUTERROR]	=3D (nfsd4_dec)nfsd4_decode_notsupp,
> -	[OP_LAYOUTSTATS]	=3D (nfsd4_dec)nfsd4_decode_notsupp,
> -	[OP_OFFLOAD_CANCEL]	=3D (nfsd4_dec)nfsd4_decode_offload_status,
> -	[OP_OFFLOAD_STATUS]	=3D (nfsd4_dec)nfsd4_decode_offload_status,
> -	[OP_READ_PLUS]		=3D (nfsd4_dec)nfsd4_decode_read,
> -	[OP_SEEK]		=3D (nfsd4_dec)nfsd4_decode_seek,
> -	[OP_WRITE_SAME]		=3D (nfsd4_dec)nfsd4_decode_notsupp,
> -	[OP_CLONE]		=3D (nfsd4_dec)nfsd4_decode_clone,
> +	[OP_ALLOCATE]		=3D nfsd4_decode_fallocate,
> +	[OP_COPY]		=3D nfsd4_decode_copy,
> +	[OP_COPY_NOTIFY]	=3D nfsd4_decode_copy_notify,
> +	[OP_DEALLOCATE]		=3D nfsd4_decode_fallocate,
> +	[OP_IO_ADVISE]		=3D nfsd4_decode_notsupp,
> +	[OP_LAYOUTERROR]	=3D nfsd4_decode_notsupp,
> +	[OP_LAYOUTSTATS]	=3D nfsd4_decode_notsupp,
> +	[OP_OFFLOAD_CANCEL]	=3D nfsd4_decode_offload_status,
> +	[OP_OFFLOAD_STATUS]	=3D nfsd4_decode_offload_status,
> +	[OP_READ_PLUS]		=3D nfsd4_decode_read,
> +	[OP_SEEK]		=3D nfsd4_decode_seek,
> +	[OP_WRITE_SAME]		=3D nfsd4_decode_notsupp,
> +	[OP_CLONE]		=3D nfsd4_decode_clone,
> 	/* RFC 8276 extended atributes operations */
> -	[OP_GETXATTR]		=3D (nfsd4_dec)nfsd4_decode_getxattr,
> -	[OP_SETXATTR]		=3D (nfsd4_dec)nfsd4_decode_setxattr,
> -	[OP_LISTXATTRS]		=3D (nfsd4_dec)nfsd4_decode_listxattrs,
> -	[OP_REMOVEXATTR]	=3D (nfsd4_dec)nfsd4_decode_removexattr,
> +	[OP_GETXATTR]		=3D nfsd4_decode_getxattr,
> +	[OP_SETXATTR]		=3D nfsd4_decode_setxattr,
> +	[OP_LISTXATTRS]		=3D nfsd4_decode_listxattrs,
> +	[OP_REMOVEXATTR]	=3D nfsd4_decode_removexattr,
> };
>=20
> static inline bool
> @@ -3594,8 +3648,9 @@ nfsd4_encode_stateid(struct xdr_stream *xdr, statei=
d_t *sid)
> }
>=20
> static __be32
> -nfsd4_encode_access(struct nfsd4_compoundres *resp, __be32 nfserr, struc=
t nfsd4_access *access)
> +nfsd4_encode_access(struct nfsd4_compoundres *resp, __be32 nfserr, void =
*_arg)
> {
> +	struct nfsd4_access *access =3D _arg;
> 	struct xdr_stream *xdr =3D resp->xdr;
> 	__be32 *p;
>=20
> @@ -3607,8 +3662,10 @@ nfsd4_encode_access(struct nfsd4_compoundres *resp=
, __be32 nfserr, struct nfsd4_
> 	return 0;
> }
>=20
> -static __be32 nfsd4_encode_bind_conn_to_session(struct nfsd4_compoundres=
 *resp, __be32 nfserr, struct nfsd4_bind_conn_to_session *bcts)
> +static __be32 nfsd4_encode_bind_conn_to_session(struct nfsd4_compoundres=
 *resp, __be32 nfserr,
> +						void *_arg)
> {
> +	struct nfsd4_bind_conn_to_session *bcts =3D _arg;
> 	struct xdr_stream *xdr =3D resp->xdr;
> 	__be32 *p;
>=20
> @@ -3624,8 +3681,9 @@ static __be32 nfsd4_encode_bind_conn_to_session(str=
uct nfsd4_compoundres *resp,
> }
>=20
> static __be32
> -nfsd4_encode_close(struct nfsd4_compoundres *resp, __be32 nfserr, struct=
 nfsd4_close *close)
> +nfsd4_encode_close(struct nfsd4_compoundres *resp, __be32 nfserr, void *=
_arg)
> {
> +	struct nfsd4_close *close =3D _arg;
> 	struct xdr_stream *xdr =3D resp->xdr;
>=20
> 	return nfsd4_encode_stateid(xdr, &close->cl_stateid);
> @@ -3633,8 +3691,9 @@ nfsd4_encode_close(struct nfsd4_compoundres *resp, =
__be32 nfserr, struct nfsd4_c
>=20
>=20
> static __be32
> -nfsd4_encode_commit(struct nfsd4_compoundres *resp, __be32 nfserr, struc=
t nfsd4_commit *commit)
> +nfsd4_encode_commit(struct nfsd4_compoundres *resp, __be32 nfserr, void =
*_arg)
> {
> +	struct nfsd4_commit *commit =3D _arg;
> 	struct xdr_stream *xdr =3D resp->xdr;
> 	__be32 *p;
>=20
> @@ -3647,8 +3706,9 @@ nfsd4_encode_commit(struct nfsd4_compoundres *resp,=
 __be32 nfserr, struct nfsd4_
> }
>=20
> static __be32
> -nfsd4_encode_create(struct nfsd4_compoundres *resp, __be32 nfserr, struc=
t nfsd4_create *create)
> +nfsd4_encode_create(struct nfsd4_compoundres *resp, __be32 nfserr, void =
*_arg)
> {
> +	struct nfsd4_create *create =3D _arg;
> 	struct xdr_stream *xdr =3D resp->xdr;
> 	__be32 *p;
>=20
> @@ -3661,8 +3721,10 @@ nfsd4_encode_create(struct nfsd4_compoundres *resp=
, __be32 nfserr, struct nfsd4_
> }
>=20
> static __be32
> -nfsd4_encode_getattr(struct nfsd4_compoundres *resp, __be32 nfserr, stru=
ct nfsd4_getattr *getattr)
> +nfsd4_encode_getattr(struct nfsd4_compoundres *resp, __be32 nfserr,
> +		     void *_arg)
> {
> +	struct nfsd4_getattr *getattr =3D _arg;
> 	struct svc_fh *fhp =3D getattr->ga_fhp;
> 	struct xdr_stream *xdr =3D resp->xdr;
>=20
> @@ -3671,8 +3733,9 @@ nfsd4_encode_getattr(struct nfsd4_compoundres *resp=
, __be32 nfserr, struct nfsd4
> }
>=20
> static __be32
> -nfsd4_encode_getfh(struct nfsd4_compoundres *resp, __be32 nfserr, struct=
 svc_fh **fhpp)
> +nfsd4_encode_getfh(struct nfsd4_compoundres *resp, __be32 nfserr, void *=
_arg)
> {
> +	struct svc_fh **fhpp =3D _arg;
> 	struct xdr_stream *xdr =3D resp->xdr;
> 	struct svc_fh *fhp =3D *fhpp;
> 	unsigned int len;
> @@ -3726,8 +3789,9 @@ nfsd4_encode_lock_denied(struct xdr_stream *xdr, st=
ruct nfsd4_lock_denied *ld)
> }
>=20
> static __be32
> -nfsd4_encode_lock(struct nfsd4_compoundres *resp, __be32 nfserr, struct =
nfsd4_lock *lock)
> +nfsd4_encode_lock(struct nfsd4_compoundres *resp, __be32 nfserr, void *_=
arg)
> {
> +	struct nfsd4_lock *lock =3D _arg;
> 	struct xdr_stream *xdr =3D resp->xdr;
>=20
> 	if (!nfserr)
> @@ -3739,8 +3803,9 @@ nfsd4_encode_lock(struct nfsd4_compoundres *resp, _=
_be32 nfserr, struct nfsd4_lo
> }
>=20
> static __be32
> -nfsd4_encode_lockt(struct nfsd4_compoundres *resp, __be32 nfserr, struct=
 nfsd4_lockt *lockt)
> +nfsd4_encode_lockt(struct nfsd4_compoundres *resp, __be32 nfserr, void *=
_arg)
> {
> +	struct nfsd4_lockt *lockt =3D _arg;
> 	struct xdr_stream *xdr =3D resp->xdr;
>=20
> 	if (nfserr =3D=3D nfserr_denied)
> @@ -3749,8 +3814,9 @@ nfsd4_encode_lockt(struct nfsd4_compoundres *resp, =
__be32 nfserr, struct nfsd4_l
> }
>=20
> static __be32
> -nfsd4_encode_locku(struct nfsd4_compoundres *resp, __be32 nfserr, struct=
 nfsd4_locku *locku)
> +nfsd4_encode_locku(struct nfsd4_compoundres *resp, __be32 nfserr, void *=
_arg)
> {
> +	struct nfsd4_locku *locku =3D _arg;
> 	struct xdr_stream *xdr =3D resp->xdr;
>=20
> 	return nfsd4_encode_stateid(xdr, &locku->lu_stateid);
> @@ -3758,8 +3824,9 @@ nfsd4_encode_locku(struct nfsd4_compoundres *resp, =
__be32 nfserr, struct nfsd4_l
>=20
>=20
> static __be32
> -nfsd4_encode_link(struct nfsd4_compoundres *resp, __be32 nfserr, struct =
nfsd4_link *link)
> +nfsd4_encode_link(struct nfsd4_compoundres *resp, __be32 nfserr, void *_=
arg)
> {
> +	struct nfsd4_link *link =3D _arg;
> 	struct xdr_stream *xdr =3D resp->xdr;
> 	__be32 *p;
>=20
> @@ -3772,8 +3839,9 @@ nfsd4_encode_link(struct nfsd4_compoundres *resp, _=
_be32 nfserr, struct nfsd4_li
>=20
>=20
> static __be32
> -nfsd4_encode_open(struct nfsd4_compoundres *resp, __be32 nfserr, struct =
nfsd4_open *open)
> +nfsd4_encode_open(struct nfsd4_compoundres *resp, __be32 nfserr, void *_=
arg)
> {
> +	struct nfsd4_open *open =3D _arg;
> 	struct xdr_stream *xdr =3D resp->xdr;
> 	__be32 *p;
>=20
> @@ -3866,16 +3934,20 @@ nfsd4_encode_open(struct nfsd4_compoundres *resp,=
 __be32 nfserr, struct nfsd4_op
> }
>=20
> static __be32
> -nfsd4_encode_open_confirm(struct nfsd4_compoundres *resp, __be32 nfserr,=
 struct nfsd4_open_confirm *oc)
> +nfsd4_encode_open_confirm(struct nfsd4_compoundres *resp, __be32 nfserr,
> +			  void *_arg)
> {
> +	struct nfsd4_open_confirm *oc =3D _arg;
> 	struct xdr_stream *xdr =3D resp->xdr;
>=20
> 	return nfsd4_encode_stateid(xdr, &oc->oc_resp_stateid);
> }
>=20
> static __be32
> -nfsd4_encode_open_downgrade(struct nfsd4_compoundres *resp, __be32 nfser=
r, struct nfsd4_open_downgrade *od)
> +nfsd4_encode_open_downgrade(struct nfsd4_compoundres *resp, __be32 nfser=
r,
> +			    void *_arg)
> {
> +	struct nfsd4_open_downgrade *od =3D _arg;
> 	struct xdr_stream *xdr =3D resp->xdr;
>=20
> 	return nfsd4_encode_stateid(xdr, &od->od_stateid);
> @@ -3974,8 +4046,9 @@ static __be32 nfsd4_encode_readv(struct nfsd4_compo=
undres *resp,
>=20
> static __be32
> nfsd4_encode_read(struct nfsd4_compoundres *resp, __be32 nfserr,
> -		  struct nfsd4_read *read)
> +		  void *_arg)
> {
> +	struct nfsd4_read *read =3D _arg;
> 	bool splice_ok =3D test_bit(RQ_SPLICE_OK, &resp->rqstp->rq_flags);
> 	unsigned long maxcount;
> 	struct xdr_stream *xdr =3D resp->xdr;
> @@ -4016,8 +4089,10 @@ nfsd4_encode_read(struct nfsd4_compoundres *resp, =
__be32 nfserr,
> }
>=20
> static __be32
> -nfsd4_encode_readlink(struct nfsd4_compoundres *resp, __be32 nfserr, str=
uct nfsd4_readlink *readlink)
> +nfsd4_encode_readlink(struct nfsd4_compoundres *resp, __be32 nfserr,
> +		      void *_arg)
> {
> +	struct nfsd4_readlink *readlink =3D _arg;
> 	__be32 *p, *maxcount_p, zero =3D xdr_zero;
> 	struct xdr_stream *xdr =3D resp->xdr;
> 	int length_offset =3D xdr->buf->len;
> @@ -4061,8 +4136,10 @@ nfsd4_encode_readlink(struct nfsd4_compoundres *re=
sp, __be32 nfserr, struct nfsd
> }
>=20
> static __be32
> -nfsd4_encode_readdir(struct nfsd4_compoundres *resp, __be32 nfserr, stru=
ct nfsd4_readdir *readdir)
> +nfsd4_encode_readdir(struct nfsd4_compoundres *resp, __be32 nfserr,
> +		     void *_arg)
> {
> +	struct nfsd4_readdir *readdir =3D _arg;
> 	int maxcount;
> 	int bytes_left;
> 	loff_t offset;
> @@ -4152,8 +4229,9 @@ nfsd4_encode_readdir(struct nfsd4_compoundres *resp=
, __be32 nfserr, struct nfsd4
> }
>=20
> static __be32
> -nfsd4_encode_remove(struct nfsd4_compoundres *resp, __be32 nfserr, struc=
t nfsd4_remove *remove)
> +nfsd4_encode_remove(struct nfsd4_compoundres *resp, __be32 nfserr, void =
*_arg)
> {
> +	struct nfsd4_remove *remove =3D _arg;
> 	struct xdr_stream *xdr =3D resp->xdr;
> 	__be32 *p;
>=20
> @@ -4165,8 +4243,9 @@ nfsd4_encode_remove(struct nfsd4_compoundres *resp,=
 __be32 nfserr, struct nfsd4_
> }
>=20
> static __be32
> -nfsd4_encode_rename(struct nfsd4_compoundres *resp, __be32 nfserr, struc=
t nfsd4_rename *rename)
> +nfsd4_encode_rename(struct nfsd4_compoundres *resp, __be32 nfserr, void =
*_arg)
> {
> +	struct nfsd4_rename *rename =3D _arg;
> 	struct xdr_stream *xdr =3D resp->xdr;
> 	__be32 *p;
>=20
> @@ -4248,8 +4327,9 @@ nfsd4_do_encode_secinfo(struct xdr_stream *xdr, str=
uct svc_export *exp)
>=20
> static __be32
> nfsd4_encode_secinfo(struct nfsd4_compoundres *resp, __be32 nfserr,
> -		     struct nfsd4_secinfo *secinfo)
> +		     void *_arg)
> {
> +	struct nfsd4_secinfo *secinfo =3D _arg;
> 	struct xdr_stream *xdr =3D resp->xdr;
>=20
> 	return nfsd4_do_encode_secinfo(xdr, secinfo->si_exp);
> @@ -4257,8 +4337,9 @@ nfsd4_encode_secinfo(struct nfsd4_compoundres *resp=
, __be32 nfserr,
>=20
> static __be32
> nfsd4_encode_secinfo_no_name(struct nfsd4_compoundres *resp, __be32 nfser=
r,
> -		     struct nfsd4_secinfo_no_name *secinfo)
> +		     void *_arg)
> {
> +	struct nfsd4_secinfo_no_name *secinfo =3D _arg;
> 	struct xdr_stream *xdr =3D resp->xdr;
>=20
> 	return nfsd4_do_encode_secinfo(xdr, secinfo->sin_exp);
> @@ -4269,8 +4350,10 @@ nfsd4_encode_secinfo_no_name(struct nfsd4_compound=
res *resp, __be32 nfserr,
>  * regardless of the error status.
>  */
> static __be32
> -nfsd4_encode_setattr(struct nfsd4_compoundres *resp, __be32 nfserr, stru=
ct nfsd4_setattr *setattr)
> +nfsd4_encode_setattr(struct nfsd4_compoundres *resp, __be32 nfserr,
> +		     void *_arg)
> {
> +	struct nfsd4_setattr *setattr =3D _arg;
> 	struct xdr_stream *xdr =3D resp->xdr;
> 	__be32 *p;
>=20
> @@ -4293,8 +4376,10 @@ nfsd4_encode_setattr(struct nfsd4_compoundres *res=
p, __be32 nfserr, struct nfsd4
> }
>=20
> static __be32
> -nfsd4_encode_setclientid(struct nfsd4_compoundres *resp, __be32 nfserr, =
struct nfsd4_setclientid *scd)
> +nfsd4_encode_setclientid(struct nfsd4_compoundres *resp, __be32 nfserr,
> +			 void *_arg)
> {
> +	struct nfsd4_setclientid *scd =3D _arg;
> 	struct xdr_stream *xdr =3D resp->xdr;
> 	__be32 *p;
>=20
> @@ -4317,8 +4402,9 @@ nfsd4_encode_setclientid(struct nfsd4_compoundres *=
resp, __be32 nfserr, struct n
> }
>=20
> static __be32
> -nfsd4_encode_write(struct nfsd4_compoundres *resp, __be32 nfserr, struct=
 nfsd4_write *write)
> +nfsd4_encode_write(struct nfsd4_compoundres *resp, __be32 nfserr, void *=
_arg)
> {
> +	struct nfsd4_write *write =3D _arg;
> 	struct xdr_stream *xdr =3D resp->xdr;
> 	__be32 *p;
>=20
> @@ -4334,8 +4420,9 @@ nfsd4_encode_write(struct nfsd4_compoundres *resp, =
__be32 nfserr, struct nfsd4_w
>=20
> static __be32
> nfsd4_encode_exchange_id(struct nfsd4_compoundres *resp, __be32 nfserr,
> -			 struct nfsd4_exchange_id *exid)
> +			 void *_arg)
> {
> +	struct nfsd4_exchange_id *exid =3D _arg;
> 	struct xdr_stream *xdr =3D resp->xdr;
> 	__be32 *p;
> 	char *major_id;
> @@ -4412,8 +4499,9 @@ nfsd4_encode_exchange_id(struct nfsd4_compoundres *=
resp, __be32 nfserr,
>=20
> static __be32
> nfsd4_encode_create_session(struct nfsd4_compoundres *resp, __be32 nfserr=
,
> -			    struct nfsd4_create_session *sess)
> +			    void *_arg)
> {
> +	struct nfsd4_create_session *sess =3D _arg;
> 	struct xdr_stream *xdr =3D resp->xdr;
> 	__be32 *p;
>=20
> @@ -4465,8 +4553,9 @@ nfsd4_encode_create_session(struct nfsd4_compoundre=
s *resp, __be32 nfserr,
>=20
> static __be32
> nfsd4_encode_sequence(struct nfsd4_compoundres *resp, __be32 nfserr,
> -		      struct nfsd4_sequence *seq)
> +		      void *_arg)
> {
> +	struct nfsd4_sequence *seq =3D _arg;
> 	struct xdr_stream *xdr =3D resp->xdr;
> 	__be32 *p;
>=20
> @@ -4488,8 +4577,9 @@ nfsd4_encode_sequence(struct nfsd4_compoundres *res=
p, __be32 nfserr,
>=20
> static __be32
> nfsd4_encode_test_stateid(struct nfsd4_compoundres *resp, __be32 nfserr,
> -			  struct nfsd4_test_stateid *test_stateid)
> +			  void *_arg)
> {
> +	struct nfsd4_test_stateid *test_stateid =3D _arg;
> 	struct xdr_stream *xdr =3D resp->xdr;
> 	struct nfsd4_test_stateid_id *stateid, *next;
> 	__be32 *p;
> @@ -4509,8 +4599,9 @@ nfsd4_encode_test_stateid(struct nfsd4_compoundres =
*resp, __be32 nfserr,
> #ifdef CONFIG_NFSD_PNFS
> static __be32
> nfsd4_encode_getdeviceinfo(struct nfsd4_compoundres *resp, __be32 nfserr,
> -		struct nfsd4_getdeviceinfo *gdev)
> +		void *_arg)
> {
> +	struct nfsd4_getdeviceinfo *gdev =3D _arg;
> 	struct xdr_stream *xdr =3D resp->xdr;
> 	const struct nfsd4_layout_ops *ops;
> 	u32 starting_len =3D xdr->buf->len, needed_len;
> @@ -4565,8 +4656,9 @@ nfsd4_encode_getdeviceinfo(struct nfsd4_compoundres=
 *resp, __be32 nfserr,
>=20
> static __be32
> nfsd4_encode_layoutget(struct nfsd4_compoundres *resp, __be32 nfserr,
> -		struct nfsd4_layoutget *lgp)
> +		void *_arg)
> {
> +	struct nfsd4_layoutget *lgp =3D _arg;
> 	struct xdr_stream *xdr =3D resp->xdr;
> 	const struct nfsd4_layout_ops *ops;
> 	__be32 *p;
> @@ -4592,8 +4684,9 @@ nfsd4_encode_layoutget(struct nfsd4_compoundres *re=
sp, __be32 nfserr,
>=20
> static __be32
> nfsd4_encode_layoutcommit(struct nfsd4_compoundres *resp, __be32 nfserr,
> -			  struct nfsd4_layoutcommit *lcp)
> +			  void *_arg)
> {
> +	struct nfsd4_layoutcommit *lcp =3D _arg;
> 	struct xdr_stream *xdr =3D resp->xdr;
> 	__be32 *p;
>=20
> @@ -4613,8 +4706,9 @@ nfsd4_encode_layoutcommit(struct nfsd4_compoundres =
*resp, __be32 nfserr,
>=20
> static __be32
> nfsd4_encode_layoutreturn(struct nfsd4_compoundres *resp, __be32 nfserr,
> -		struct nfsd4_layoutreturn *lrp)
> +		void *_arg)
> {
> +	struct nfsd4_layoutreturn *lrp =3D _arg;
> 	struct xdr_stream *xdr =3D resp->xdr;
> 	__be32 *p;
>=20
> @@ -4699,8 +4793,9 @@ nfsd42_encode_nl4_server(struct nfsd4_compoundres *=
resp, struct nl4_server *ns)
>=20
> static __be32
> nfsd4_encode_copy(struct nfsd4_compoundres *resp, __be32 nfserr,
> -		  struct nfsd4_copy *copy)
> +		  void *_arg)
> {
> +	struct nfsd4_copy *copy =3D _arg;
> 	__be32 *p;
>=20
> 	nfserr =3D nfsd42_encode_write_res(resp, &copy->cp_res,
> @@ -4716,8 +4811,9 @@ nfsd4_encode_copy(struct nfsd4_compoundres *resp, _=
_be32 nfserr,
>=20
> static __be32
> nfsd4_encode_offload_status(struct nfsd4_compoundres *resp, __be32 nfserr=
,
> -			    struct nfsd4_offload_status *os)
> +			    void *_arg)
> {
> +	struct nfsd4_offload_status *os =3D _arg;
> 	struct xdr_stream *xdr =3D resp->xdr;
> 	__be32 *p;
>=20
> @@ -4809,8 +4905,9 @@ nfsd4_encode_read_plus_hole(struct nfsd4_compoundre=
s *resp,
>=20
> static __be32
> nfsd4_encode_read_plus(struct nfsd4_compoundres *resp, __be32 nfserr,
> -		       struct nfsd4_read *read)
> +		       void *_arg)
> {
> +	struct nfsd4_read *read =3D _arg;
> 	unsigned long maxcount, count;
> 	struct xdr_stream *xdr =3D resp->xdr;
> 	struct file *file;
> @@ -4879,8 +4976,9 @@ nfsd4_encode_read_plus(struct nfsd4_compoundres *re=
sp, __be32 nfserr,
>=20
> static __be32
> nfsd4_encode_copy_notify(struct nfsd4_compoundres *resp, __be32 nfserr,
> -			 struct nfsd4_copy_notify *cn)
> +			 void *_arg)
> {
> +	struct nfsd4_copy_notify *cn =3D _arg;
> 	struct xdr_stream *xdr =3D resp->xdr;
> 	__be32 *p;
>=20
> @@ -4914,8 +5012,9 @@ nfsd4_encode_copy_notify(struct nfsd4_compoundres *=
resp, __be32 nfserr,
>=20
> static __be32
> nfsd4_encode_seek(struct nfsd4_compoundres *resp, __be32 nfserr,
> -		  struct nfsd4_seek *seek)
> +		  void *_arg)
> {
> +	struct nfsd4_seek *seek =3D _arg;
> 	__be32 *p;
>=20
> 	p =3D xdr_reserve_space(resp->xdr, 4 + 8);
> @@ -4977,8 +5076,9 @@ nfsd4_vbuf_to_stream(struct xdr_stream *xdr, char *=
buf, u32 buflen)
>=20
> static __be32
> nfsd4_encode_getxattr(struct nfsd4_compoundres *resp, __be32 nfserr,
> -		      struct nfsd4_getxattr *getxattr)
> +		      void *_arg)
> {
> +	struct nfsd4_getxattr *getxattr =3D _arg;
> 	struct xdr_stream *xdr =3D resp->xdr;
> 	__be32 *p, err;
>=20
> @@ -5001,8 +5101,9 @@ nfsd4_encode_getxattr(struct nfsd4_compoundres *res=
p, __be32 nfserr,
>=20
> static __be32
> nfsd4_encode_setxattr(struct nfsd4_compoundres *resp, __be32 nfserr,
> -		      struct nfsd4_setxattr *setxattr)
> +		      void *_arg)
> {
> +	struct nfsd4_setxattr *setxattr =3D _arg;
> 	struct xdr_stream *xdr =3D resp->xdr;
> 	__be32 *p;
>=20
> @@ -5042,8 +5143,9 @@ nfsd4_listxattr_validate_cookie(struct nfsd4_listxa=
ttrs *listxattrs,
>=20
> static __be32
> nfsd4_encode_listxattrs(struct nfsd4_compoundres *resp, __be32 nfserr,
> -			struct nfsd4_listxattrs *listxattrs)
> +			void *_arg)
> {
> +	struct nfsd4_listxattrs *listxattrs =3D _arg;
> 	struct xdr_stream *xdr =3D resp->xdr;
> 	u32 cookie_offset, count_offset, eof;
> 	u32 left, xdrleft, slen, count;
> @@ -5153,8 +5255,9 @@ nfsd4_encode_listxattrs(struct nfsd4_compoundres *r=
esp, __be32 nfserr,
>=20
> static __be32
> nfsd4_encode_removexattr(struct nfsd4_compoundres *resp, __be32 nfserr,
> -			 struct nfsd4_removexattr *removexattr)
> +			 void *_arg)
> {
> +	struct nfsd4_removexattr *removexattr =3D _arg;
> 	struct xdr_stream *xdr =3D resp->xdr;
> 	__be32 *p;
>=20
> @@ -5174,93 +5277,93 @@ typedef __be32(* nfsd4_enc)(struct nfsd4_compound=
res *, __be32, void *);
>  * done in the decoding phase.
>  */
> static const nfsd4_enc nfsd4_enc_ops[] =3D {
> -	[OP_ACCESS]		=3D (nfsd4_enc)nfsd4_encode_access,
> -	[OP_CLOSE]		=3D (nfsd4_enc)nfsd4_encode_close,
> -	[OP_COMMIT]		=3D (nfsd4_enc)nfsd4_encode_commit,
> -	[OP_CREATE]		=3D (nfsd4_enc)nfsd4_encode_create,
> -	[OP_DELEGPURGE]		=3D (nfsd4_enc)nfsd4_encode_noop,
> -	[OP_DELEGRETURN]	=3D (nfsd4_enc)nfsd4_encode_noop,
> -	[OP_GETATTR]		=3D (nfsd4_enc)nfsd4_encode_getattr,
> -	[OP_GETFH]		=3D (nfsd4_enc)nfsd4_encode_getfh,
> -	[OP_LINK]		=3D (nfsd4_enc)nfsd4_encode_link,
> -	[OP_LOCK]		=3D (nfsd4_enc)nfsd4_encode_lock,
> -	[OP_LOCKT]		=3D (nfsd4_enc)nfsd4_encode_lockt,
> -	[OP_LOCKU]		=3D (nfsd4_enc)nfsd4_encode_locku,
> -	[OP_LOOKUP]		=3D (nfsd4_enc)nfsd4_encode_noop,
> -	[OP_LOOKUPP]		=3D (nfsd4_enc)nfsd4_encode_noop,
> -	[OP_NVERIFY]		=3D (nfsd4_enc)nfsd4_encode_noop,
> -	[OP_OPEN]		=3D (nfsd4_enc)nfsd4_encode_open,
> -	[OP_OPENATTR]		=3D (nfsd4_enc)nfsd4_encode_noop,
> -	[OP_OPEN_CONFIRM]	=3D (nfsd4_enc)nfsd4_encode_open_confirm,
> -	[OP_OPEN_DOWNGRADE]	=3D (nfsd4_enc)nfsd4_encode_open_downgrade,
> -	[OP_PUTFH]		=3D (nfsd4_enc)nfsd4_encode_noop,
> -	[OP_PUTPUBFH]		=3D (nfsd4_enc)nfsd4_encode_noop,
> -	[OP_PUTROOTFH]		=3D (nfsd4_enc)nfsd4_encode_noop,
> -	[OP_READ]		=3D (nfsd4_enc)nfsd4_encode_read,
> -	[OP_READDIR]		=3D (nfsd4_enc)nfsd4_encode_readdir,
> -	[OP_READLINK]		=3D (nfsd4_enc)nfsd4_encode_readlink,
> -	[OP_REMOVE]		=3D (nfsd4_enc)nfsd4_encode_remove,
> -	[OP_RENAME]		=3D (nfsd4_enc)nfsd4_encode_rename,
> -	[OP_RENEW]		=3D (nfsd4_enc)nfsd4_encode_noop,
> -	[OP_RESTOREFH]		=3D (nfsd4_enc)nfsd4_encode_noop,
> -	[OP_SAVEFH]		=3D (nfsd4_enc)nfsd4_encode_noop,
> -	[OP_SECINFO]		=3D (nfsd4_enc)nfsd4_encode_secinfo,
> -	[OP_SETATTR]		=3D (nfsd4_enc)nfsd4_encode_setattr,
> -	[OP_SETCLIENTID]	=3D (nfsd4_enc)nfsd4_encode_setclientid,
> -	[OP_SETCLIENTID_CONFIRM] =3D (nfsd4_enc)nfsd4_encode_noop,
> -	[OP_VERIFY]		=3D (nfsd4_enc)nfsd4_encode_noop,
> -	[OP_WRITE]		=3D (nfsd4_enc)nfsd4_encode_write,
> -	[OP_RELEASE_LOCKOWNER]	=3D (nfsd4_enc)nfsd4_encode_noop,
> +	[OP_ACCESS]		=3D nfsd4_encode_access,
> +	[OP_CLOSE]		=3D nfsd4_encode_close,
> +	[OP_COMMIT]		=3D nfsd4_encode_commit,
> +	[OP_CREATE]		=3D nfsd4_encode_create,
> +	[OP_DELEGPURGE]		=3D nfsd4_encode_noop,
> +	[OP_DELEGRETURN]	=3D nfsd4_encode_noop,
> +	[OP_GETATTR]		=3D nfsd4_encode_getattr,
> +	[OP_GETFH]		=3D nfsd4_encode_getfh,
> +	[OP_LINK]		=3D nfsd4_encode_link,
> +	[OP_LOCK]		=3D nfsd4_encode_lock,
> +	[OP_LOCKT]		=3D nfsd4_encode_lockt,
> +	[OP_LOCKU]		=3D nfsd4_encode_locku,
> +	[OP_LOOKUP]		=3D nfsd4_encode_noop,
> +	[OP_LOOKUPP]		=3D nfsd4_encode_noop,
> +	[OP_NVERIFY]		=3D nfsd4_encode_noop,
> +	[OP_OPEN]		=3D nfsd4_encode_open,
> +	[OP_OPENATTR]		=3D nfsd4_encode_noop,
> +	[OP_OPEN_CONFIRM]	=3D nfsd4_encode_open_confirm,
> +	[OP_OPEN_DOWNGRADE]	=3D nfsd4_encode_open_downgrade,
> +	[OP_PUTFH]		=3D nfsd4_encode_noop,
> +	[OP_PUTPUBFH]		=3D nfsd4_encode_noop,
> +	[OP_PUTROOTFH]		=3D nfsd4_encode_noop,
> +	[OP_READ]		=3D nfsd4_encode_read,
> +	[OP_READDIR]		=3D nfsd4_encode_readdir,
> +	[OP_READLINK]		=3D nfsd4_encode_readlink,
> +	[OP_REMOVE]		=3D nfsd4_encode_remove,
> +	[OP_RENAME]		=3D nfsd4_encode_rename,
> +	[OP_RENEW]		=3D nfsd4_encode_noop,
> +	[OP_RESTOREFH]		=3D nfsd4_encode_noop,
> +	[OP_SAVEFH]		=3D nfsd4_encode_noop,
> +	[OP_SECINFO]		=3D nfsd4_encode_secinfo,
> +	[OP_SETATTR]		=3D nfsd4_encode_setattr,
> +	[OP_SETCLIENTID]	=3D nfsd4_encode_setclientid,
> +	[OP_SETCLIENTID_CONFIRM] =3D nfsd4_encode_noop,
> +	[OP_VERIFY]		=3D nfsd4_encode_noop,
> +	[OP_WRITE]		=3D nfsd4_encode_write,
> +	[OP_RELEASE_LOCKOWNER]	=3D nfsd4_encode_noop,
>=20
> 	/* NFSv4.1 operations */
> -	[OP_BACKCHANNEL_CTL]	=3D (nfsd4_enc)nfsd4_encode_noop,
> -	[OP_BIND_CONN_TO_SESSION] =3D (nfsd4_enc)nfsd4_encode_bind_conn_to_sess=
ion,
> -	[OP_EXCHANGE_ID]	=3D (nfsd4_enc)nfsd4_encode_exchange_id,
> -	[OP_CREATE_SESSION]	=3D (nfsd4_enc)nfsd4_encode_create_session,
> -	[OP_DESTROY_SESSION]	=3D (nfsd4_enc)nfsd4_encode_noop,
> -	[OP_FREE_STATEID]	=3D (nfsd4_enc)nfsd4_encode_noop,
> -	[OP_GET_DIR_DELEGATION]	=3D (nfsd4_enc)nfsd4_encode_noop,
> +	[OP_BACKCHANNEL_CTL]	=3D nfsd4_encode_noop,
> +	[OP_BIND_CONN_TO_SESSION] =3D nfsd4_encode_bind_conn_to_session,
> +	[OP_EXCHANGE_ID]	=3D nfsd4_encode_exchange_id,
> +	[OP_CREATE_SESSION]	=3D nfsd4_encode_create_session,
> +	[OP_DESTROY_SESSION]	=3D nfsd4_encode_noop,
> +	[OP_FREE_STATEID]	=3D nfsd4_encode_noop,
> +	[OP_GET_DIR_DELEGATION]	=3D nfsd4_encode_noop,
> #ifdef CONFIG_NFSD_PNFS
> -	[OP_GETDEVICEINFO]	=3D (nfsd4_enc)nfsd4_encode_getdeviceinfo,
> -	[OP_GETDEVICELIST]	=3D (nfsd4_enc)nfsd4_encode_noop,
> -	[OP_LAYOUTCOMMIT]	=3D (nfsd4_enc)nfsd4_encode_layoutcommit,
> -	[OP_LAYOUTGET]		=3D (nfsd4_enc)nfsd4_encode_layoutget,
> -	[OP_LAYOUTRETURN]	=3D (nfsd4_enc)nfsd4_encode_layoutreturn,
> +	[OP_GETDEVICEINFO]	=3D nfsd4_encode_getdeviceinfo,
> +	[OP_GETDEVICELIST]	=3D nfsd4_encode_noop,
> +	[OP_LAYOUTCOMMIT]	=3D nfsd4_encode_layoutcommit,
> +	[OP_LAYOUTGET]		=3D nfsd4_encode_layoutget,
> +	[OP_LAYOUTRETURN]	=3D nfsd4_encode_layoutreturn,
> #else
> -	[OP_GETDEVICEINFO]	=3D (nfsd4_enc)nfsd4_encode_noop,
> -	[OP_GETDEVICELIST]	=3D (nfsd4_enc)nfsd4_encode_noop,
> -	[OP_LAYOUTCOMMIT]	=3D (nfsd4_enc)nfsd4_encode_noop,
> -	[OP_LAYOUTGET]		=3D (nfsd4_enc)nfsd4_encode_noop,
> -	[OP_LAYOUTRETURN]	=3D (nfsd4_enc)nfsd4_encode_noop,
> +	[OP_GETDEVICEINFO]	=3D nfsd4_encode_noop,
> +	[OP_GETDEVICELIST]	=3D nfsd4_encode_noop,
> +	[OP_LAYOUTCOMMIT]	=3D nfsd4_encode_noop,
> +	[OP_LAYOUTGET]		=3D nfsd4_encode_noop,
> +	[OP_LAYOUTRETURN]	=3D nfsd4_encode_noop,
> #endif
> -	[OP_SECINFO_NO_NAME]	=3D (nfsd4_enc)nfsd4_encode_secinfo_no_name,
> -	[OP_SEQUENCE]		=3D (nfsd4_enc)nfsd4_encode_sequence,
> -	[OP_SET_SSV]		=3D (nfsd4_enc)nfsd4_encode_noop,
> -	[OP_TEST_STATEID]	=3D (nfsd4_enc)nfsd4_encode_test_stateid,
> -	[OP_WANT_DELEGATION]	=3D (nfsd4_enc)nfsd4_encode_noop,
> -	[OP_DESTROY_CLIENTID]	=3D (nfsd4_enc)nfsd4_encode_noop,
> -	[OP_RECLAIM_COMPLETE]	=3D (nfsd4_enc)nfsd4_encode_noop,
> +	[OP_SECINFO_NO_NAME]	=3D nfsd4_encode_secinfo_no_name,
> +	[OP_SEQUENCE]		=3D nfsd4_encode_sequence,
> +	[OP_SET_SSV]		=3D nfsd4_encode_noop,
> +	[OP_TEST_STATEID]	=3D nfsd4_encode_test_stateid,
> +	[OP_WANT_DELEGATION]	=3D nfsd4_encode_noop,
> +	[OP_DESTROY_CLIENTID]	=3D nfsd4_encode_noop,
> +	[OP_RECLAIM_COMPLETE]	=3D nfsd4_encode_noop,
>=20
> 	/* NFSv4.2 operations */
> -	[OP_ALLOCATE]		=3D (nfsd4_enc)nfsd4_encode_noop,
> -	[OP_COPY]		=3D (nfsd4_enc)nfsd4_encode_copy,
> -	[OP_COPY_NOTIFY]	=3D (nfsd4_enc)nfsd4_encode_copy_notify,
> -	[OP_DEALLOCATE]		=3D (nfsd4_enc)nfsd4_encode_noop,
> -	[OP_IO_ADVISE]		=3D (nfsd4_enc)nfsd4_encode_noop,
> -	[OP_LAYOUTERROR]	=3D (nfsd4_enc)nfsd4_encode_noop,
> -	[OP_LAYOUTSTATS]	=3D (nfsd4_enc)nfsd4_encode_noop,
> -	[OP_OFFLOAD_CANCEL]	=3D (nfsd4_enc)nfsd4_encode_noop,
> -	[OP_OFFLOAD_STATUS]	=3D (nfsd4_enc)nfsd4_encode_offload_status,
> -	[OP_READ_PLUS]		=3D (nfsd4_enc)nfsd4_encode_read_plus,
> -	[OP_SEEK]		=3D (nfsd4_enc)nfsd4_encode_seek,
> -	[OP_WRITE_SAME]		=3D (nfsd4_enc)nfsd4_encode_noop,
> -	[OP_CLONE]		=3D (nfsd4_enc)nfsd4_encode_noop,
> +	[OP_ALLOCATE]		=3D nfsd4_encode_noop,
> +	[OP_COPY]		=3D nfsd4_encode_copy,
> +	[OP_COPY_NOTIFY]	=3D nfsd4_encode_copy_notify,
> +	[OP_DEALLOCATE]		=3D nfsd4_encode_noop,
> +	[OP_IO_ADVISE]		=3D nfsd4_encode_noop,
> +	[OP_LAYOUTERROR]	=3D nfsd4_encode_noop,
> +	[OP_LAYOUTSTATS]	=3D nfsd4_encode_noop,
> +	[OP_OFFLOAD_CANCEL]	=3D nfsd4_encode_noop,
> +	[OP_OFFLOAD_STATUS]	=3D nfsd4_encode_offload_status,
> +	[OP_READ_PLUS]		=3D nfsd4_encode_read_plus,
> +	[OP_SEEK]		=3D nfsd4_encode_seek,
> +	[OP_WRITE_SAME]		=3D nfsd4_encode_noop,
> +	[OP_CLONE]		=3D nfsd4_encode_noop,
>=20
> 	/* RFC 8276 extended atributes operations */
> -	[OP_GETXATTR]		=3D (nfsd4_enc)nfsd4_encode_getxattr,
> -	[OP_SETXATTR]		=3D (nfsd4_enc)nfsd4_encode_setxattr,
> -	[OP_LISTXATTRS]		=3D (nfsd4_enc)nfsd4_encode_listxattrs,
> -	[OP_REMOVEXATTR]	=3D (nfsd4_enc)nfsd4_encode_removexattr,
> +	[OP_GETXATTR]		=3D nfsd4_encode_getxattr,
> +	[OP_SETXATTR]		=3D nfsd4_encode_setxattr,
> +	[OP_LISTXATTRS]		=3D nfsd4_encode_listxattrs,
> +	[OP_REMOVEXATTR]	=3D nfsd4_encode_removexattr,
> };
>=20
> /*
> --=20
> 2.34.1
>=20

--
Chuck Lever



