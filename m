Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A756626A5C
	for <lists+linux-nfs@lfdr.de>; Sat, 12 Nov 2022 16:58:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231534AbiKLP6I (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 12 Nov 2022 10:58:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230257AbiKLP6H (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 12 Nov 2022 10:58:07 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0829713D20;
        Sat, 12 Nov 2022 07:58:04 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2ACFidvi008699;
        Sat, 12 Nov 2022 15:58:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=nq5ciP+26oEmHid4ijMxLNOIxZzaeR9yf46lGRGp0fY=;
 b=rDd4ndX8nXga6Io9Qq6gwVFmcIzd6n2VbKxszyg6kUIB9CbULePZEx8BXOc09uQbQ0OF
 qNpbr965fROD/tJ+bWiLUKB6J2+iOFmdgfgx5blhqgE9TJ87bKbQ9H5UiWQoNGrFAzvL
 ziJkHyuG0ijzt+P6fwiEBzpxlv4Jd9MHlxvqbtdvOdfqWWwzJy0DdO3mEGAgWtOmaD4s
 aMp6QsgO4tvVBB9Cm+fe8ZaVC0PzDcbZQ4UMlY5kbt8geGZ/8C8DmMORBGUG3xA8IDwW
 U1Op3CTph4CJ7VnaMiuyFseKFEmpxijmZNvsB24FVCroefV4VexTIH5xHYdEQCgyX2kp gQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kted4g09v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 12 Nov 2022 15:58:00 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2ACE4VqF016504;
        Sat, 12 Nov 2022 15:58:00 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2048.outbound.protection.outlook.com [104.47.56.48])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3kt1x8q4e2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 12 Nov 2022 15:57:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q/Msv0NTLHcmAubtYUWs8NPZEFkC3rvZbMcz001j2LZ/Vit1kRH3F7VROq09vBrToENZqy0Vd+Q0kxaOM7S1cc8E0hVdphk2nZklFL+jQCY180/pgblVGZpS242AIw8k3nkwmqy+x99Yj+3lZ/M5xRmCFRFdIe6TcIOSNr9UpPl4Vn3u9s+Eifc21qwV/8hcPnWwPOCCabmF11PHAVB3ugMHgjTxo9qSbWCZjWrX9NW92Nx723AKLTqxQWeJn7Okv8eHscQMrxbAe2U7UV0ntB1ZuKLqyr/SJuXWdr+wZOrKiKKX1JzNymjFI7wmViCsFi6+lVXAFEgz2hw0EuGnYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nq5ciP+26oEmHid4ijMxLNOIxZzaeR9yf46lGRGp0fY=;
 b=YZ0p9oD+U7mxznAsd5UAg5C8v7JIQYWbPZGuCQ+qdsSEagmCD0JnUhVjfzRLio09/Fi7267DHaoSVZNrqexyaxJRQVsGa1FYSnaOTMYxk77lxbkk7jiPUWnOseamO6zDZY9uw+b1KQK333UZSdSn3WaRnDeoLWsuvODnfxQ97C0uhSqW3aGYa790haAoPe1iSIRLDi6txukypENCDG8RydMZDsYDfwBp1VreM90Q1t7kUm5P41s+eGMv2iCMeOHUjtaWJblowK0zkDo5bSAWjFywGo0QJOaKeBr8JnEFWIOkDr7d9Z9Gch8MQfMdv3vngYfV6DuxyRcmfZ41BIUriw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nq5ciP+26oEmHid4ijMxLNOIxZzaeR9yf46lGRGp0fY=;
 b=r3udz1liA6tayc6MPyr63+UcIjMKloj1ea2dkGYoWQg0xmOXvpN7DmUPJYpJXxVet2Zxw8jmrZ7+K1lDxo2bp5S2VSeHOTNtGBKGTmhJtrjj9k6B5NqQ8fMmDEHXcr8HwfhxF1a5K/jdtCmxQDdBp6vDKEyaWOMjWJrABUjNFqk=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by MW5PR10MB5807.namprd10.prod.outlook.com (2603:10b6:303:19a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.13; Sat, 12 Nov
 2022 15:57:57 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::b500:ee42:3ca6:8a9e]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::b500:ee42:3ca6:8a9e%6]) with mapi id 15.20.5813.016; Sat, 12 Nov 2022
 15:57:57 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Steven Rostedt <rostedt@goodmis.org>
CC:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: Files in include/trace/events
Thread-Topic: Files in include/trace/events
Thread-Index: AQHY9pIxS7zdpDkDakqjuyvnBhQ08K47ceuA
Date:   Sat, 12 Nov 2022 15:57:57 +0000
Message-ID: <23D84506-BC58-4269-BD71-A88DDBCC92BA@oracle.com>
References: <20221112072742.065df70a@rorschach.local.home>
In-Reply-To: <20221112072742.065df70a@rorschach.local.home>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|MW5PR10MB5807:EE_
x-ms-office365-filtering-correlation-id: dc09041d-5cb1-4c5d-6809-08dac4c6ab07
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XkRhQL1eP0Dlk4OHLvOqoQVYWdmUO3g5RBpWQ+8pT2OSRHm8hsDXcLMhfRwhbz4G1Uf87DUbH/5ZMxEO7cM0txampV/n5rwljDLV+RchnIRnHL03JU1C4FKxR1RHsQFBrdEkbFvjzhNB7sA1ckeWUjbE5F0xbJ0sxToeezVtozpQKoNw0kDQxWsgyUX/JTcbQqFN31sCFwk6hVOTSP06exnNx/vT+WfUQJGSR/cI+ZET9lIQSWAZqIbHObK0C4SxB0auVOtNbehR66B7gfYc4gK8osIaSREBf5qCBuMmm1teoRyXwEPF5Y4jIXSOdRZTp8CKySObGfGliQ7Hu5KTmltQ/c4wJiYuXtkoR14nZRIcfiQTGebQ2KVAybdTD2Tg9r/oYq4w6Ds2XJp16yxhHGsXhA6xwuvyRz5qbNrgKO1sXZmoImSvI2E5ketFxZleGbxbeRIKRuKNyrf5kgq0wNHW9gQHXurSFupt7IV9Yky7S0dOaQ0RN2TPmyeK5rOetb72y9O02+/C2+Lw5L0MbG1rJKuE6DktyD3PU0+XMf4u0foWcROS3/XkCITC4FAbZiHOAgjmPbgDVIa7SbCP47w9YqzbnD8y0ho5KM6dbDCbHPMaO4uZ4l0C+mTZhGHj2VxKyQWwvZWTy9mhT2+tfmXPNXPaSX7rfY0YDETR5EPl+xumC9Hz3tiEaOdUZo7j+MaRMnm9Nbc8V8gjQ+CRqdA7Hn+GAUDpKOOFVRMA+MCXLThENshaJICxvpPVbdy9le3VpzfVSBgvpBwhfPUZPoPRBlJJzxcNW1kpCWw6fhk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(136003)(346002)(39860400002)(366004)(376002)(451199015)(316002)(6506007)(53546011)(83380400001)(4744005)(6916009)(54906003)(8936002)(2616005)(66946007)(33656002)(5660300002)(2906002)(186003)(91956017)(4326008)(8676002)(6512007)(41300700001)(66476007)(64756008)(76116006)(66446008)(36756003)(26005)(66556008)(86362001)(38100700002)(71200400001)(6486002)(478600001)(38070700005)(122000001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?7P2CPPXTM9XlUN1JGXKM+ufGcfpJTLWvFux1q9x7gDqBTwZxlr4ol3U1sfMo?=
 =?us-ascii?Q?iwhP/Os45r770IKvMVx1Pc2vyJr8M25ccjNQYSzVksBufx3Aj39VdegiiBQl?=
 =?us-ascii?Q?7Fgr//kKJPaTdiN+GicWNcKJmfYWIbmf+mSmES9NDrd77cVQqTS/YUbjprkZ?=
 =?us-ascii?Q?F9bXS0h782+28uF73MBoimLNKBGA9BSj2M7q4B4cRJ4XrWPT8rW1PkPj5yEC?=
 =?us-ascii?Q?0WV3q9ML4oNMmusSJC8u0AXaEiS9dKM6DWW9Hv3Yb7+oTZVKf/IphLqWQne7?=
 =?us-ascii?Q?fU0Yn4uFnmsQAJeNXXm74nAgaiY4zxPE59/lgyeCBXm3w+Coodwb9UU4Cc6/?=
 =?us-ascii?Q?FAv/tkgMSQLZBr40+F4KVNt6zJ47CY6hk9Z95VBkCbqWcGgrbNRt//iEC1Or?=
 =?us-ascii?Q?cj9RwfJqWvDr4PRb3PGjlAV1qla4/HhCmK7mglYJ7+bHov2XbWutZut6+UTN?=
 =?us-ascii?Q?/XPrUj4S/q9v4kxGehHgslJQ+to30Z/d8akdZg3afa82trDcURpv/h4kSiPr?=
 =?us-ascii?Q?EJ10kLZinXVh2q6Izfc/yqQZrgaynZIa0M7Zm4dLWfw4iV4CvQjXJ5QN/2+h?=
 =?us-ascii?Q?CusHFShui2Y7EN2yStE4zMLKd8xXwt0TNaSC9YP1mJs3Ohuy2FyPH4lrU/x5?=
 =?us-ascii?Q?zsxFC8kZHYVVRwke4M89t3VTlY8m8fCRQlz6Bs+E3/AgMPrkSrHACKX5yf8z?=
 =?us-ascii?Q?LMOkuK/ToAQgWcVQWZToBtSmjF1hnXTgap+I9+iAyKw3sa3oiYWGprgrGHkx?=
 =?us-ascii?Q?XNrCPKoBYQF5ZOPHF42hhr5gfT4xtX71EokjMJwUd6yC7rZfneJsSpcCz2am?=
 =?us-ascii?Q?sN8QZnKQEN3TyLuRmNGefGzMfEgXSZTwkaUr615V6fVhYKHqLbWVoCjVYTFv?=
 =?us-ascii?Q?5G9k8rw/6wyB9niGSh/psbsD4TUnkfrSd3juBMku2v01ywqQmAqAMpp0fe+b?=
 =?us-ascii?Q?SVz+ecQt5/GCGHqCN4C41ibQnUpN5NxpqOhgVrbxR8Zl344D6mkAeHH5O4AL?=
 =?us-ascii?Q?7Seq6IJUj+CmBQrKPP4unOsmeE189OJjVwrYbXy56R2Rstri7DS0ajj8MuvC?=
 =?us-ascii?Q?ydd/LgsaXgo8+lN2OvKD8Ok416UePlnrZ/fAm1HPU5b0vQKwR5QNGcisKy+l?=
 =?us-ascii?Q?vAgHBwNWMCQW5itFY1r2SIbzI/CAPGnG3YG+d6CVBMP/K0XBU+9wMaplEN0l?=
 =?us-ascii?Q?l71ro4bf8qUEQNKk0YfpC9Ir2n0M3WJvnnzgtxa9/Oinh+dPmGodAmAbrRzM?=
 =?us-ascii?Q?mP0jLypgMe2Hwde4JMS/qYwCXOmyEdgARimS4qH517Vgpw83bqX7riRlKemx?=
 =?us-ascii?Q?wjRKShK59i7f3bGEenzUqXbVoQseuEImG7UR1mtiyOH1z2Muw9kknXCXW+0d?=
 =?us-ascii?Q?oVI7e18ZaW/MrVwt+YxGRl9/moFfU1BhZygz4D+iAwQhiG/fEGVq+vV4QXyE?=
 =?us-ascii?Q?cCWwwGhkFiCnslMoZHNyYBlZauX5cMESmRfFaRwL2QK+eqCqiuaP/QKAaHdn?=
 =?us-ascii?Q?HpG0z5dF1yfCiNXsDWt3XOkoLKc2YyDtlYgSdQt5zg+WyTQgHT6rYhHWByyE?=
 =?us-ascii?Q?AJgVfoM6kTw7QFKCSqIcStLrkpHoiE8rKU5DW4ew8QP7bZLlVcCOK+tWRLCB?=
 =?us-ascii?Q?RQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <42A8DF03D99ADA43AB084A4076C53E1C@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: df4KsYIYFfRwpy2Y+KuqKqTtKGzMZotPtmhCh32rHEb4iWvTTZM7icp0svQi92OwSZ6uYH9WDqBttE/8sB+BKDEoQtYNDklvJOfZpyvMJ8u74nv5tSkc1RAjXSKcC02dVjtDJDIIwGaPbyaPWux8e5QthyttDC7rk2tvm6+SS4qX0R1HZJw+wezPSlZbZX61OIcK6KCdI0ENAsyg4Jlhiax/JrHtEgN1ns2bYwPSWpjOP7WrOwaZ6iOfbYHGvaf55tsZPSNQ+GyWILiEoJ6rM3ypRbctJ6yl2Vy47l/paBrkXHztQDM4Adyq8RY5XNsuTYGyBCqldkzN+13WU5qXIXV9nd8YCh34lTwEfLospYCqOekb5U9jz0eE5JKoDnG+iyiXTssUtuqFEOs7FOcBYdwjhxrM9q9BvdYQQc4MbjaP4JQu67P2uVuLBS2AyhRTrm4ffVk5Z/XnzFtOo7wmCGK46rnIucrGKXTMXyvj6Dly3Mk9ivJf4mn27Piqy3wEqBlqj3qERlfGVepr3uExqgaJfj9PKZfjOdw6NDCVP2WTsomLp84nbOXiqM6uAy4T44XSOXn1CToLlRePcIj9107pRuKOe1z2z3LxkRa3v6v94Mrh4M8XUcDRBFdXFrVeChgRQXnqDgd8JhAFbcJ2mDkv/VT9QdlyvEPFQR/SIC4ywxwU55CXcFvOrh4tCV/Svo59gSu1Bb9G0SsqJpe6l/LLa/L4qvq35D+RDeaMzoba8RcXAd4+TA4Z1WfLOy+xDfyAm1dCjbQ5MJUNPO2IzYj3bYzZneJBdTY27TyG7ewq8z71maHSB+M0c84JDn+TK3+WWzU/Pc0xN8y89dW/JNXuHYaoYQx57+IA/2E1vCp4J1K8UfxzZVAGLgGFUSqN
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc09041d-5cb1-4c5d-6809-08dac4c6ab07
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2022 15:57:57.8148
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jzcGF3GlBAKXw665cdLOninZh1m1pwurWzGwRNZVck3fL/6hEDvrUVjhHBhWsYb7GFiUiOsI9JXpe86DXHovrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR10MB5807
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-12_11,2022-11-11_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 adultscore=0
 spamscore=0 mlxlogscore=976 mlxscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211120122
X-Proofpoint-GUID: cf6-YenKW6UUPuJ1DfSMuSOT96iYdr07
X-Proofpoint-ORIG-GUID: cf6-YenKW6UUPuJ1DfSMuSOT96iYdr07
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Nov 12, 2022, at 7:27 AM, Steven Rostedt <rostedt@goodmis.org> wrote:
>=20
> Hi Chuck,
>=20
> I was just looking over some files in include/trace/events/ and noticed
> that there's sunrpc_base.h, fs.h and nfs.h that are not event files.
>=20
> The include/trace/events/ directory should only hold files that are to
> create events, not headers that hold helper functions.
>=20
> Can you please move them out of include/trace/events/ as that directory
> is "special" in the creation of events.
>=20
> Perhaps we could create a new directory include/linux/trace/ or
> include/trace/linux/ specific for these types of files?

I can take responsibility for moving the helper files I created.
IIRC there are a few from the RDMA core subsystem as well.

But let's first decide on a proper destination for such files.
A sister directory to include/trace/events, like

  include/trace/ < something >

makes sense to me.


--
Chuck Lever



