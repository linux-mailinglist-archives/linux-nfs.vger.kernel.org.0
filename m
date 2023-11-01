Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 562A27DE40B
	for <lists+linux-nfs@lfdr.de>; Wed,  1 Nov 2023 16:47:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233678AbjKAPmL (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 1 Nov 2023 11:42:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232759AbjKAPmK (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 1 Nov 2023 11:42:10 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12F91A6
        for <linux-nfs@vger.kernel.org>; Wed,  1 Nov 2023 08:42:05 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A19k1Ed001599;
        Wed, 1 Nov 2023 15:41:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=T5QvIYRFBMwJOaKZxOxo0tA6Mcv1HOkL7oyQK24JyKo=;
 b=TEilY83KB6eRmyXVHlp711SriVjIMwiqKs3l14BnjT2Ffwj40H/4Lh932hmuK9ctSZCZ
 DyOX4JvSG9MvamwPjRiMY+L9jjOYU/4E+0L8COepPheM9AQmFm40QckYtQy7l/n3hxnv
 Tnx9gTJ+jP0KsunI168QW3AYLV+4mfaBRwTnb8OuGOb2JrvItr/I1z9e+w8if5p5mgAN
 3KsH7fAI/cm6ub2kxJ5+qmOY9bNu7iGP2rojERN+aT2dNcnYKR2zz++3VSmX4br/kEu4
 sUkfjjw3H0LE6eb+0cnLL+TsRoHctoM6jNurkoYqQKmuR+F0rYbtJEcPw/uhdHZ9Yy04 +w== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u0swtqu2g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Nov 2023 15:41:54 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3A1EEVZ4020283;
        Wed, 1 Nov 2023 15:41:53 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3u0rr791es-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Nov 2023 15:41:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hZOLIc6fNTJogfaiZBCiL9FgANh6MHcEfj6A8AU4Io5VFr+nS3nVMy6pqcLGNNzPAq78Wkg9u8XLIDRCB9IMBfll0fIQt5KqkgTkEOl+hLpko2RsyK0P2P9RXAZVm9A4j1t9XInwmbZBQyfl6blbLZi5jg+USrCJZO3hS1T46dVQ+eRpuFAfPGYADOw2jvgxJwCrf6qFfmAUDVbwNk05nHA42zPS3BYYLeCDA0UECLUk93Ltczudd997CVVW6KHHYPNnGC8wL3iE33+Zrc2pZTsx5SE5uGH6QRpe9b2RpJAQ40BPRH+HdZT6OTUKVZV8zHZ1LjCwPiiSXkKRZuJDSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T5QvIYRFBMwJOaKZxOxo0tA6Mcv1HOkL7oyQK24JyKo=;
 b=PK3OfzU6u/jYTldcSNdBAPIWcd2APQzOCkxz5Q+HuirPW7AZ70+IEMR8d30BsqrbjxZhCj7WAvCmNRlaKTrk5Mtcu/oarKYYaBVx4upqO+hx/K1yOjlXvW/jkJq9iAB6zCg/l+g85fdm15h+1rv4ZYre3z5P6Uid7f/MGqsFwSSqasdpbM4Dnvv8+VXPjMRurdd/6BhleaJOLdbkfnpzJcA5bG9ofG0266N0QHs1IXXSNJ1zDwcvRtMtYe1b1SryG35HXT76+P51txs6ECtcyKqIORDVTw20Qk8LdRYjaCVgaijHNp6kv0ZB3z/6u8GA1LK3c6kebtwrets5jDqDvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T5QvIYRFBMwJOaKZxOxo0tA6Mcv1HOkL7oyQK24JyKo=;
 b=MsGZRlL1jfSDFxL/z6VZebNijWMBmxW0b7hILECchh90CtlJcUh0pptMdyzqzHBGC/Qfv3dsqPi+jmIpwrQO6g0ZVUoQX/SWMYrZ11RwQ9Jf5NqsuAa/XJoqZUimGrRaonTw8A9fgzVygdJmTGv6EK9Ox+rEfPhijsJXvofhh1k=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH0PR10MB7079.namprd10.prod.outlook.com (2603:10b6:510:28a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.19; Wed, 1 Nov
 2023 15:41:50 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::3474:7bf6:94fe:4ef1]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::3474:7bf6:94fe:4ef1%3]) with mapi id 15.20.6954.019; Wed, 1 Nov 2023
 15:41:49 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Neil Brown <neilb@suse.de>, Dai Ngo <dai.ngo@oracle.com>
CC:     Jeff Layton <jlayton@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Olga Kornievskaia <kolga@netapp.com>,
        Tom Talpey <tom@talpey.com>
Subject: Re: [PATCH 6/6] nfsd: allow delegation state ids to be revoked and
 then freed
Thread-Topic: [PATCH 6/6] nfsd: allow delegation state ids to be revoked and
 then freed
Thread-Index: AQHaDF75bEKrShy72kWA52GSBv2SfLBkuEKAgAAOcICAACzEgIAAIeyAgACFroA=
Date:   Wed, 1 Nov 2023 15:41:49 +0000
Message-ID: <E4C94AEE-6CBA-44C4-AA45-C56E8458286E@oracle.com>
References: <20231101010049.27315-1-neilb@suse.de>
 <20231101010049.27315-7-neilb@suse.de>
 <4C3DBAFF-4C83-4DB4-A6C6-D9C4387BF1F4@oracle.com>
 <169880769331.24305.7672914147957308642@noble.neil.brown.name>
 <D2B988F4-D8F5-4A5A-BC97-F67D19A76C78@oracle.com>
 <169882459188.24305.13216722681220510683@noble.neil.brown.name>
In-Reply-To: <169882459188.24305.13216722681220510683@noble.neil.brown.name>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.700.6)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|PH0PR10MB7079:EE_
x-ms-office365-filtering-correlation-id: e7afc380-6f84-4e4b-be9e-08dbdaf1105c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: js+ar98BqnHRxb9XvT+W/sfSRI0g4Qjvpj52js0yOMatBJBT1T5+rgS8Q8Vs1uBI7KtqWVn09QUj534sKmaTQYG8QsNzG3emTORuzbNE0KBScTrqS4vIG2GntrPA/Zv691D2iDLhO7yIlAsxdOArhn7NYjQc0l70YlyjsxyJWUPUVGAvSq757Vw8fGHXnijx7m1/+tYSQGTu35ABLr1NYBIFKmMwkZ1GzG04lYJVHJ+CmcyBAdtHbsXicv7wiUh9h3C6xE84QYowMRcnfURWb5wQEnp4R4CKefc/Fd4UEtSM6Zgfo2vp/6EVf6nnK2OUGWkRzDPvXxrERMoLnHXwC8oGgrxEj91jeDgu0bNQxpOy+hrTlXdvfrVNOTMjBRnO59eKV6IVX9QaRo3g0K3IJ8/SVeLTIDpm1CZa+SlEtAJyd33k/Bw9U0InpM3IAJvaYll0VTIhy35+nA8AffdG2HZoPesVRiwkyQGbzdLFTdAjnX7Pa4pQR38HLc0FkPx4O59DW8HQCWT3F0LyCL5wjE0HyWdw+Ywj0F385/DXEgC5UB5mQGzYFkjuIxUQ5tQyh4qdyLGfim1K8PRnD03bdeqlzW6X7hT/zxpU9srmdt5B7nsNij3Fk9ZXmfl2DOrsHaMwXfZGxRUX5GQcRMkvrw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(136003)(396003)(366004)(39860400002)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(66899024)(26005)(6512007)(2616005)(38070700009)(36756003)(33656002)(86362001)(122000001)(38100700002)(2906002)(83380400001)(5660300002)(53546011)(71200400001)(6506007)(478600001)(4326008)(8936002)(8676002)(6636002)(316002)(66446008)(66476007)(54906003)(64756008)(91956017)(41300700001)(110136005)(66946007)(76116006)(66556008)(6486002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?8W5f1d7ypyzFqCvqh6FOENzahMHTNptuE5EPwFByPtALC/0hPcI47JukPvHv?=
 =?us-ascii?Q?5rIUdTm47B/ARraQCD8B0RcA18T/vgoo7f+aY1DLKSsopaXhtEzXvM1EzAbs?=
 =?us-ascii?Q?KMom6YAAbt9K8HBvuwpvILsBl0HUf9BX4EFf0vnD3bNnbXGHUqa5BP81TQAV?=
 =?us-ascii?Q?CgHRT+4v02u/e1+Butl5KkRDabfJpW0cY5c2fptpwXq7DuNBCL/SzBTlKksi?=
 =?us-ascii?Q?mUhS1tOPdzDZx0+VYRP0o0pDfnw2qmK1TuPN/dDjGRAAVmbkrUCbOMZzhPWW?=
 =?us-ascii?Q?Ao5km+MFcUGOASQbbNSxs9PjavpI4BCTqMxYdK1LTMkM7CAIPB6tpX89Exmf?=
 =?us-ascii?Q?n09MTidNkfYdRnr6vR89EHTQ+pWIDpK9PpwnRJxIGWsI/JudrpQhKakLLkL6?=
 =?us-ascii?Q?U4qhGYO+RhyWt+RwxOAYKSY/nuL4bNYHxYC0/idqJ2i1DhOaJ8LKPFga8kqg?=
 =?us-ascii?Q?4vh4G/1GbDfkaLT6NX4P8RrFa8zNahUnqib26JoxHCK4NQKDjeUUg5pQRsiI?=
 =?us-ascii?Q?tKLN1a/HQmumjnxmh7RrpCu4AstfMW7YfQHUqJhwpEiwU/kum/tZwlDQDwNc?=
 =?us-ascii?Q?2mD5IWoh9Jy4y2yssjAqBZTMe/bIEpI0BezAxm21DsKubj37fEe4eTmEDnUB?=
 =?us-ascii?Q?DWBNO1m4dpI4Qt20OJP9xnUgzdzRwcOtsCp1BAEvNSXz+Pm4oO/a2jrLkClF?=
 =?us-ascii?Q?A+/SX+UzdfWq0krnx9Xih2Z3d2Ollg3ZYfKkADguAE4Linvirf334yC1e/XQ?=
 =?us-ascii?Q?9GxEh4xHTneJbAAxRc8HVLbQHTQJlQzvYa3N3EEg0EOai9HHRamALtFg4kdm?=
 =?us-ascii?Q?oC2Fk522zKwEUt2g7zPtlcy5ReuPLGoTZJ1vzTw5Zypjj6mubs5a8yiFDOUj?=
 =?us-ascii?Q?VnZBeh1LcMZAVG+nuhPGCOrLKOdbOTcNxTpTc6zF8vx0Pm1NA+egU8xf+73O?=
 =?us-ascii?Q?BKMtGkICAfYGlQKyY4DC6FB3vPCowIaac/gkJ/FvrJ7zVUg697ebao9EQjyx?=
 =?us-ascii?Q?qnW71X4IqYXHN8lMMsa5NHuL5gEpU1wCF+WTgu4NS06MaNWx7PMsuzkojIkp?=
 =?us-ascii?Q?S5hJxbb+5M+RuBZOvgeFFEMW0IuGAGrgQAFl7VRy6tt4C9SK2+zeoPXXHnmv?=
 =?us-ascii?Q?D5AV3PQkpea95l+Ho5PKDC/0ERSomM17V76xZ3JWXysK6gdaLWMhjblNIucL?=
 =?us-ascii?Q?rmGVejN+o2QOVzLlvRanPXY614CCyVWe5awOlQbaM8TSgMkKJads6/EuBLEI?=
 =?us-ascii?Q?guLE5p0rs3fWn2Jh9o9XbB34Ml8nftXsEegMz0Ynds2Pi53nwBQUNPq7UZsD?=
 =?us-ascii?Q?dfTnJHmztMorvUL2fE60A/wxfOLceC5hrJI+zNTdzvklRBATb5Gc8L1Hv2gI?=
 =?us-ascii?Q?9tL5D/YBhZcVa1JW9eyAQBJnRwtNW6LEtXszlADccnzr8gtzGrklVmzz5Vsg?=
 =?us-ascii?Q?nSvZsRMk4CYAYaGNfDjIKeo8vigWxyUIeQb/0+gUZPOH1F1m4a4P577kn5dA?=
 =?us-ascii?Q?KJjCkIrrBZmP0usKok5R26RYtc5o+emdvQt2CmpYAOlNTNSlRak7/3SR6oyO?=
 =?us-ascii?Q?Z5WpC6bctbC6Rcr2Of283jR68bYe6hDEpoe3BEJQsFrKSAKxEsgsb7+0nkSz?=
 =?us-ascii?Q?Wg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B1DBA3101262D24797F796E21924BDDC@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: UTqxdIOtLG1ykyY7iDI5DKTBaI77BKXO2a/tgn6M5l97vkXwYMe6aH2qNQaxDNvF/yfCkEQRMxkWj92zsEPoTh4B6gCyU48t2v1vqEgt/KBGwqTmrBuyxPHqI5xNKQJyhdeFHowR+C2Nh+oigsxRX/TZh269zLqdbpQmSKp/SUY5bhZHCCInsh77WG23drPWRZIeZXR9ym8/NESd4d+rq8n7iImyXyS/6D3p26d8i32Js7+vYmUfs1jIDFvjJZ1OsmLyh8ZAQxDm5JN7kwA2z6ZNpA/Dmi+KkwUGHSiW/uo7R3gaQYgOM7gdEe9cXp7zuo5oH7iTR4znLdMYri4551Fq2aT7XHMvd50vas2NYNFbXLoMYvqeKMI0XxXu/i94+0Ih25mK/ICMYQcGY1+kfDXzH85TFr8pPJbtbJbV8cRc+EecKft/kDfAoj//fa/w5Hc2KCQv5RxWUl08aths876BV6zpuxQ46ea9+RloEp+hR2YEpxPnB/nVaXadtv0aD1AbNHee5ZtbUDod1a8udR7Hoq0zmoFYaz7VWmUawo4VgcxCr5jpZGjI5ZKz9MN2JZ0Gr4vpD9RufN/qqfRo8OQllU1GJu/73g97Q87FdXJ8EDvEoZON5ck3bIv8dGxEjy4s1EidrtaEbRF3pN1sOTy5TVuwxnh9sgdSk+AliHULmRaacWt0+zX4pYi1kvqgK7GnqFKjJfKHAcOxKYI3AD2Wo3Va5Xg36QHaEoXa7wD7fTufpgbRribRlaMVzeS4eE90WEYWEISxO3qa36S38Pjmj7AqsQ8rJHQvKWTsFb3ePu+/HAUJbemGjIHSJuGdvszOQb2026qUfyGMWUNoPuzmOzASb59/uU5BjUPmgXbW76vkDubKd28I42DVsn7Q
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7afc380-6f84-4e4b-be9e-08dbdaf1105c
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Nov 2023 15:41:49.9417
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Wgji7TN2iqMfmPZ+okiepAUb9/rzgDzHPGek8GqbB2kpFm5sG2zeR3MX6JnEN6f6l1oPeHw/2dlcO7S8dfK2QA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB7079
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-01_13,2023-11-01_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 mlxscore=0
 spamscore=0 phishscore=0 adultscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310240000
 definitions=main-2311010128
X-Proofpoint-ORIG-GUID: ntMj8Kl5_fU4ubXNcabcUStCaBPV9bYZ
X-Proofpoint-GUID: ntMj8Kl5_fU4ubXNcabcUStCaBPV9bYZ
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Nov 1, 2023, at 12:43 AM, NeilBrown <neilb@suse.de> wrote:
>=20
> On Wed, 01 Nov 2023, Chuck Lever III wrote:
>>=20
>>> On Oct 31, 2023, at 8:01 PM, NeilBrown <neilb@suse.de> wrote:
>>>=20
>>> On Wed, 01 Nov 2023, Chuck Lever III wrote:
>>>> Howdy Neil-
>>>>=20
>>>>> On Oct 31, 2023, at 5:57 PM, NeilBrown <neilb@suse.de> wrote:
>>>>>=20
>>>>> Revoking state through 'unlock_filesystem' now revokes any delegation
>>>>> states found.  When the stateids are then freed by the client, the
>>>>> revoked stateids will be cleaned up correctly.
>>>>=20
>>>> Here's my derpy question of the day.
>>>>=20
>>>> "When the stateids are then freed by the client" seems to be
>>>> a repeating trope, and it concerns me a bit (probably because
>>>> I haven't yet learned how this mechanism /currently/ works)...
>>>>=20
>>>> In the case when the client has actually vanished (eg, was
>>>> destroyed by an orchestrator), it's not going to be around
>>>> to actively free revoked state. Doesn't that situation result
>>>> in pinned state on the server? I would expect that's a primary
>>>> use case for "unlock_filesystem."
>>>=20
>>> If a client is de-orchestrated then it will stop renewing its lease, an=
d
>>> regular cleanup of expired state will kick in after one lease period.
>>=20
>> Thanks for educating me.
>>=20
>> Such state actually stays around for much longer now as
>> expired but renewable state. Does unlock_filesystem need
>> to purge courtesy state too, to make the target filesystem
>> unexportable and unmountable?
>=20
> I don't think there is any special case there that we need to deal with.
> I haven't explored in detail but I think "courtesy" state is managed at
> the client level.  Some clients still have valid leases, others are
> being maintained only as a courtesy.  At the individual state level
> there is no difference.  The "unlock_filesystem" code examines all
> states for all client and selects those for the target filesystem and
> revokes those.

Dai can correct me if I've misremembered, but NFSD's courteous
server does not currently implement partial loss of state. If
any of a client's state is lost while it is disconnected, the
server discards its entire lease.

Thus if an admin unlocks a filesystem that a disconnected client
has some open files on, that client's entire lease should be
purged.


>>> So for NFSv4 we don't need to worry about disappearing clients.
>>> For NFSv3 (or more specifically for NLM) we did and locks could hang
>>> around indefinitely if the client died.
>>> For that reason we have /proc/fs/nfsd/unlock_ip which discards all NFSv=
3
>>> lock state for a given client.  Extending that to NFSv4 is not needed
>>> because of leases, and not meaningful because of trunking - a client
>>> might have several IP's.
>>>=20
>>> unlock_filesystem is for when the client is still active and we want to
>>> let it (them) continue accessing some filesystems, but not all.
>>>=20
>>> NeilBrown
>>>=20
>>>=20
>>>>=20
>>>> Maybe I've misunderstood something fundamental.
>>>>=20
>>>>=20
>>>> --
>>>> Chuck Lever
>>=20
>>=20
>> --
>> Chuck Lever


--
Chuck Lever


