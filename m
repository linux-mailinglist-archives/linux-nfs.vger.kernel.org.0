Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 532FA70570E
	for <lists+linux-nfs@lfdr.de>; Tue, 16 May 2023 21:26:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229460AbjEPT0O (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 16 May 2023 15:26:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbjEPT0N (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 16 May 2023 15:26:13 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8733E7DBF
        for <linux-nfs@vger.kernel.org>; Tue, 16 May 2023 12:26:10 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34GG46N3010428;
        Tue, 16 May 2023 19:26:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=in/zZoobheOPKjvFTDYY8Bhu++tUXPDy9sAIBVh+ueY=;
 b=iPvZznxtDtw9NsMoyFmMunlLeqx83tjXIw6oJomL0yaGKUckcHztVMPtw3zziT6azStX
 zgOEGYZ7R+cySdczXrZu7CCGrBaqJRFerTg1Mi8p/+Ehb/uZDzOyJTon+0I8a0Fyi8Be
 /DRU0/1FKpvlRzzbLoYABZ7LD5WlxNIB3H3svg3iUwjmax58KHGpyvhgvJbfwBlN9eR2
 Pk58pcA3jvskKAKZzFnhxZYb/Z4IbQ+HMmlF6MpzpzNIR2L7Wp9pM1gcHoxBPlMZ2bxR
 sVDbJU0uz+nhyXMF/+Q2iqX+8DZyrYZ2rUMtQYPSGJ+3pDdVzaK8o45Is9kf8plbSu2P /Q== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qj1b3v4u7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 May 2023 19:26:00 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34GIhpdX024981;
        Tue, 16 May 2023 19:26:00 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2109.outbound.protection.outlook.com [104.47.70.109])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3qj104gcx2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 May 2023 19:25:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DvHth2kbn+Gq4N2n3QCD51DhPGhoTOBzRAXK1OGdURB3sy5f4pLXsQEl4TsDThJwGLMwep20/cTPlMaiTskZDVsTrTx8E0U/q2xEOyPQfYELxLlZJii7ZlPf4yEnr7YaLxqTxixnAXFbzBbp9I0h5RzZ3RcpY/D+sDP8aatkLJABXKdCK3qAmxI/Q6gYr/DKHmNDfJ1dvQOBGuPqbuhg0s1l1yfQzFpMWk2C7HXzNckLy3Gi+wDSz1Y144JPekiEbsavtzzHHetyZswdw1gPFopPmHLtO9gPZKzfvZ+8TxYqil8sYQujSRE5KHacT0O9db9kXPGg/+AHAwUmf96b5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=in/zZoobheOPKjvFTDYY8Bhu++tUXPDy9sAIBVh+ueY=;
 b=GcDRnIVd5hv9pUhoASRZv4dkOEYB0ElQmFyB88FARBCfoPnDowV3JqUc3Y+lbUTF8dmlcV3Lj7V8GmEnb7l3NimFb8RJb9UD8IBHf9MrSRv4AHhecX/TILEXN66612dRD5qU8N6yu93G5rkrBvbMwi++RaLJan+TsMKP+RWhRkAhPSjGCjRP3HbkiRy/iJj8qJtIcZ8QxMUJQcvAAhVxr+TWHaRvkd3uQNLdGkVqS4d3ukBr86IL/etJBGFJbVHDxMiuiZ2/7GmU/RxLB9NkJTJPuyLcGZqdmtSBOC1PPnhXVYoxNLw9CeybVooNo2QUy5CoJeUuFXhO1sFYN6ziyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=in/zZoobheOPKjvFTDYY8Bhu++tUXPDy9sAIBVh+ueY=;
 b=JN8WNhGhVr2P0jLfavAo1AqRj3faeByCzKJV56ozTYvP3bq4XJZ3xdLER2y6YsQAqYlsLMceiY57uMQEleVOMohESu57eHPa6pydi7HlOQLZEKLPF4pK18KT8IshwPOYa2phi9i9C1zxgT2VvTbFCRv7teNmj3I+NTXrGHKtlsU=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CO1PR10MB4785.namprd10.prod.outlook.com (2603:10b6:303:95::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.33; Tue, 16 May
 2023 19:25:57 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ecbd:fc46:2528:36db]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ecbd:fc46:2528:36db%5]) with mapi id 15.20.6387.034; Tue, 16 May 2023
 19:25:57 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jeff Layton <jlayton@kernel.org>
CC:     Jiri Slaby <jirislaby@kernel.org>,
        Steve Dickson <SteveD@redhat.com>,
        Chuck Lever <cel@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Neil Brown <neilb@suse.de>,
        Alexander Ahring Oder Aring <aahringo@redhat.com>
Subject: Re: [PATCH v1 26/27] SUNRPC: Set rq_accept_statp inside ->accept
 methods
Thread-Topic: [PATCH v1 26/27] SUNRPC: Set rq_accept_statp inside ->accept
 methods
Thread-Index: AQHZI37QRUQ4TvDJik2GwoQT/5RlW69HhAGAgAA1uwCAFlcegIAAAJUA
Date:   Tue, 16 May 2023 19:25:57 +0000
Message-ID: <0DEDF045-8C95-463D-B5E7-D2A3DF3230FC@oracle.com>
References: <167319499150.7490.2294168831574653380.stgit@bazille.1015granger.net>
 <167319546521.7490.43383592461162363.stgit@bazille.1015granger.net>
 <3e34a2dc-7d72-b719-248f-e78361db8a5b@kernel.org>
 <4AB1ED03-57C8-42C1-9A04-6C224E98EDCC@oracle.com>
 <569be8e6eff7af373e6baaf2170edb8a8c52f262.camel@kernel.org>
In-Reply-To: <569be8e6eff7af373e6baaf2170edb8a8c52f262.camel@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.500.231)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|CO1PR10MB4785:EE_
x-ms-office365-filtering-correlation-id: 568cba78-231b-4f89-0685-08db56435fc3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0Fn3xc87TuNbvYh70LdVdyOB5l7G3savfNEHi1zdIFeUk6JP7Pj8C8hQx1poClGggaojM5PMyGLZONr1XJzmOmq5Vxxw9AgbRhyDwVm0qIhwIx17fEewP8+wiiJ9YEHnrGzgeSTOU4ORKbZ8m4wQYkrBVSGvrfM1cQuw1Tvu3qZapZyxT+CYh5PeEhQz2kc1ihhiMBKj7A96aRoyn1i1FEIOZeKMz8kmfKDwEhXvlv1lYWCvdTMhapqoz098qdga2lc76lgHgon+4y68S+FehPsmcUdhLXzy2mw3kZvPWzleLwYjNVLdB/tvFUbz9sFEDHxukAsF/W+DJCzZZI5qgAQODPhbl9HZ9vJW3qy6cC42JoA15kwhrlm+/P5Fy4QEXY5H85nek95QSNCrsTor+TlM//rfMjQESTlNJ0eNdkuNz6+mdNp1ZuKvWeCXPdSF7eYWXDNKSGalr6gaz6FIWx4ZLsbjEgClRzg5DjSIO4X2QtikshzTib2HFHE4Qa8PyHT8DoaxtX+Q7m2p1x/JcmTBwS5HpxK9iz4GMJ655T/4mAf9mmMxUVE6eC9DPHzHO7Cl8rfBlTTAaaOeZzXL03Mg2U8E5/McFlnZH/B0wA74abIJEe2hPRWdBnuJ/OqsDEzlKE7oKvptpwUJQKEkNA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(396003)(366004)(39860400002)(136003)(376002)(451199021)(71200400001)(76116006)(66556008)(38070700005)(478600001)(966005)(66446008)(91956017)(66476007)(6486002)(64756008)(66946007)(36756003)(54906003)(6916009)(4326008)(86362001)(316002)(186003)(2616005)(6506007)(38100700002)(122000001)(26005)(6512007)(5660300002)(41300700001)(8936002)(2906002)(8676002)(33656002)(53546011)(83380400001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?iyXn4qcViLctt/NQo58IMLYp7cyDzMtMv8JGA7RWTCjl8rjiGEmu4wNSkxwe?=
 =?us-ascii?Q?/XayTIzRDxucU6v2vBs8kGlRpxHufYri94Gg6n2icpHDBMvh2e2Y8K28by98?=
 =?us-ascii?Q?iNTn2L08R7cntPWyl57CSzFAJVfps6t0tLS1kbkKOCnqRKlOXii6h1m3McSB?=
 =?us-ascii?Q?rSKvf2z6Uxn8ved5jkysJmJH84IWcFlVZvOvkW9ZI+J8MfPB8qxgUFwsOm7T?=
 =?us-ascii?Q?uGhkRojgPTp2rz0FlJ76ggIYMzIMr1Hk6wVmD3+HbTZ1oK/NTCxDKSfvotNw?=
 =?us-ascii?Q?UVplknA+Xok5fuhaHOvJNNS+NOjYSPlPzGka9bfskq3KJU+VfHQqwrwKE4Bs?=
 =?us-ascii?Q?V8VuPOI53+SARBB+/KVlPxsB3d10NuC25d8KbRebvEX77nQJ6+J6Cm+Nz6it?=
 =?us-ascii?Q?+zFgYqnB5frGKketIW/ZjCk3rqVvPWq4AM7ksVMq97BbfPPg8jbzm8IsVlJq?=
 =?us-ascii?Q?M5+X3q/gkvuw6SMj0jJmId/OIiukeCROhd0Kw2Xn/fR4zi5G25JkmBan701u?=
 =?us-ascii?Q?tpHmwi2dR2YrA4fPq3vOJdY6Bt1pEbo7Kq0SSwaOOxK/EVNx2baH/dOSUCBu?=
 =?us-ascii?Q?b13eQLYueMKE4wKoNVACPylg2IFzqoJvcmVVkzDT7MIrWAdcSX0F5vtQ3brt?=
 =?us-ascii?Q?s1OLUnWdpdrh335joe+JgJHaDJNVoOMhdLTSQqTT3qOeN8GfrsdB7Ks7fnsU?=
 =?us-ascii?Q?qvciJMXrKMCZWZTJHEAPEox/o+bJW1dYzkAp3SHTNdH6/GbaGzWqzhcd78cT?=
 =?us-ascii?Q?NGpOjcV8X6fQKdPxQMYdRIQFp/d26RgMGzvi7VT+++w1wz+mAJjrtDbRu9qR?=
 =?us-ascii?Q?FTSkMAthAJ5xx54TQfuDMXxOfNyrlgWJTxQhQv8aZs+RNwHLhxWHrb2Nop31?=
 =?us-ascii?Q?aKHtIUj7QimfryAaxDeHTSta4I3sdoO5nKOzHs+XrQeeB5dMf32QeNMGxb0N?=
 =?us-ascii?Q?itiLKHa51REOWOt2V8cSysuUOGBfDezf5Wt/tav+mQ87sxHXYsQFC6Nka/vQ?=
 =?us-ascii?Q?6WwQ6Od9dQavkYX2qiI8WzgJ0eNccw29+jZuGRwndPrGe2kXppcvB4gKkFLY?=
 =?us-ascii?Q?f41H0IpRAxkOVSRPbCVJi/9wByuK8HxjgtNdzztSB+GoO9L360RNve382ZAU?=
 =?us-ascii?Q?aHfbmvUW2YjnndGh0Ds5Ad7z42t6d7vHPU++S/jEIBeAvTBc+I6Lyi9jtlDG?=
 =?us-ascii?Q?OaQcz4Wy7R5KKyT8WKbY11PuWm0OR8X7sl2YNFaSaZ3cWXf/p2Pr180Pkvg3?=
 =?us-ascii?Q?wEi8AcQSBuP41WI23x8iuBHGzU5OrFGC445bn7DBZ4e6GFpOw/Goa9cVG0+4?=
 =?us-ascii?Q?PR5gdnwRIGNCYe09ejhCIF+MWQe5RmS3Ytn4xjFoCnYif/Z7DMhPYPTxCc2e?=
 =?us-ascii?Q?eowFrEULG932e/QqjoQNhY79tdx7WqFV19ZAVijmTRhESxOQmoW5n5uQFEw/?=
 =?us-ascii?Q?K2IsXKu98Yw0cTYSzj3sd+zXXW9IDuFp6NFJuNfoFG/WFQ+HgHr3tqSm3ua+?=
 =?us-ascii?Q?pAUEgFuV5QfS9gSb3B+97h9G5uzOUPmPrzVFC1L1YnH8Ju9TbVM2k6YG+aV+?=
 =?us-ascii?Q?iyuQHbnzPQ4FHKPaN3S3z3cgXS+zCSdU7ERCTZPpg1aCcocV89JXwkS1vDea?=
 =?us-ascii?Q?Ng=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <BF175BED93F90D438698708C149CF0E0@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: WnZYY6TzeF8DQi6Ny/CJGOr/UUKv08CR0jN4AiOCsAzKkOCj3+TtSr0Z3Sy4uulAAqdF7Z7TD0nMbbKHp6dwMIs6w3x5PUcwOJtqQPJ1OuDhqq/twcboQ8fewT5Qi2jmLYPiJtjokqJdfTHjlsTz7+5OCCt/OWSK53e+MpAee2ulKkBItn4l+6cSZgTH1oZUWMWLacXeG52rdVbgcdOn5rrC/eqrx1X/CEeDGAZGJMnkMKqO5mMvD1OwszPpu8txXTdwYASMll5ZH0q54cy/w/MdeZ7Q0+DMFNdWjMNip3GcgsuHbrlMT6hN3hpIZzQ+/6EIQ0Xn/F1esUcI2psMihnF3irD448rPlU14iBzxLpFcmPSv2fKEbi+FTXKMIwxbKd1FhbHStUebOkrZpl7Cxe7LzaQbP0aJBj89AONFeMLHlNgAcJFTG0dAXWLtfe0E1x2wx6dafDSn6bEmC+iBVifBnywHVtoXHgjrRGVDt25IDc1AMBzbzAEbdYoRpcQL5L3hL0uxLUWemL22ZzcZlFiWZTBcOMjWSDAL0eRD2P2RTvod3c7HFPul+GJYZpfoTW5UWfyvKWhrYdie4cP+0PYmPWbXvCqdgP6+YGgu/xPMXSvB/xPMo4ugzimsOTPpdepCCsfjiUKaZFLqMXH2OgMREH7Y3/lzt+Ej4OoaZrhIwtPwSYjGC6FqzJ2Zxtasl9uNYqbx0aQSKEGx5RkBX6JGIl52tVv+cbz6IuI6Zdln9qWTb0L3qDgYZgiwe3eQMO3OVBufBLunQ/8zEdzONBS27WV/jlZBa9JCvcXozFwxkpOzr4ZefVXNb6IUf2y3KpTxB58xdGAbTYzZh+deQ==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 568cba78-231b-4f89-0685-08db56435fc3
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 May 2023 19:25:57.1908
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VqJE31NQJ+TUwunk+UXylXK13SzC9XEuOfKGptjWrAqpErWTvs/l6AaD2xPIr93rFTJjwXxhyg0z1pON8VsSYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4785
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-16_11,2023-05-16_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 phishscore=0
 mlxlogscore=999 spamscore=0 adultscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305160163
X-Proofpoint-GUID: F6M999p_WqOW9UlOTujgZ_dcKt0QYcpL
X-Proofpoint-ORIG-GUID: F6M999p_WqOW9UlOTujgZ_dcKt0QYcpL
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On May 16, 2023, at 3:23 PM, Jeff Layton <jlayton@kernel.org> wrote:
>=20
> On Tue, 2023-05-02 at 14:14 +0000, Chuck Lever III wrote:
>>=20
>>> On May 2, 2023, at 7:01 AM, Jiri Slaby <jirislaby@kernel.org> wrote:
>>>=20
>>> On 08. 01. 23, 17:31, Chuck Lever wrote:
>>>> From: Chuck Lever <chuck.lever@oracle.com>
>>>> To navigate around the space that svcauth_gss_accept() reserves
>>>> for the RPC payload body length and sequence number fields,
>>>> svcauth_gss_release() does a little dance with the reply's
>>>> accept_stat, moving the accept_stat value in the response buffer
>>>> down by two words.
>>>> Instead, let's have the ->accept() methods each set the proper
>>>> final location of the accept_stat to avoid having to move
>>>> things.
>>>=20
>>> Hi,
>>>=20
>>> I bisected to this (4bcf0343e8)
>>=20
>> Assuming you did the bisect on the NFS server's kernel?
>>=20
>>=20
>>> as it breaks nfs3-only servers in 6.3. I.e. /etc/nfs.conf containing:
>>> [nfsd]
>>> vers4=3Dno
>>=20
>> Note: Changing the settings in /etc/nfs.conf had no effect
>> on my server, so I effected the change by stopping the
>> server and poking values into /proc/fs/nfsd/versions by
>> hand.
>>=20
>> Steve?
>>=20
>>=20
>>> The client sees:
>>> mount("10.0.2.15:/tmp", "/mnt", "nfs", 0, "vers=3D4.2,addr=3D10.0.2.15,=
clientad"...) =3D -1 EIO (Input/output error)
>>> write(2, "mount.nfs: mount system call fai"..., 45
>>> mount.nfs: mount system call failed for /mnt
>>>=20
>>> And the kernel says:
>>> nfs4_discover_server_trunking unhandled error -5. Exiting with error EI=
O
>>>=20
>>> I reported in downstream as:
>>> https://bugzilla.suse.com/show_bug.cgi?id=3D1210995
>>>=20
>>> It cannot be reverted cleanly on the top of 6.3.
>>>=20
>>> Any ideas?
>>=20
>> I can reproduce a similar problem. Network capture shows
>> that the server is responding with NFS4ERR_NOENT to the
>> EXCHANGE_ID operation, and the client kernel log says:
>>=20
>>> nfs4_discover_server_trunking unhandled error -121. Exiting with error =
EIO
>>=20
>> That's not the failure mode I expected given the commit
>> you bisected to, so it might not be the same problem you've
>> hit. I'll troubleshoot this and send a fix for testing.
>>=20
>=20
> Alex hit this problem in testing too, and I took a quick look.
>=20
> In the attached capture, the client should have gotten back a
> RPC_PROG_MISMATCH error, but the server has recorded an extra successful
> accept state before encoding the RPC_PROG_MISMATCH error, leading to a
> malformed reply.
>=20
> I think that the problem is that encoding the accept status too early
> means that we can't properly handle failures from the pg_init_request
> call.
>=20
> Chuck, any thoughts on how you'd like to handle this?

With this:

https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git/commit/?h=3Dn=
fsd-fixes&id=3D29cd2927fb914cc53b5ba4f67d2b74695c994ba4

I plan to send the fix to Linus tomorrow.


--
Chuck Lever


