Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BCB65ABFDF
	for <lists+linux-nfs@lfdr.de>; Sat,  3 Sep 2022 18:52:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230160AbiICQwj (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 3 Sep 2022 12:52:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbiICQwi (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 3 Sep 2022 12:52:38 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2F7A25C47
        for <linux-nfs@vger.kernel.org>; Sat,  3 Sep 2022 09:52:37 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2839U7BQ031508;
        Sat, 3 Sep 2022 16:52:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=fsINO0suksjvPoEEM+5SQShOuWK4R8drcGnuE9pEkx4=;
 b=KtYaUrWrB8EWxXBzpNCBqO1i1ZBN0UOKliQt4T4jQkqrMYU4rHZB4d1v/oLluR7kHEST
 9DG/igVNo5XdeW6OCiKzplWXiAhZEF9nI3YWIf2atdmPLdwrI3/sd4wOcLNFeT2FixQp
 Tl+63Twze56Zx9UZGV7HF2B8xAipmdPUPvj6howscRIx6dT90sWLw6Zs0Trl6/cttkra
 HBW59bSA52xxUVqbOi6ln9WVAsUAE5KF7o+xvVnp17d8Ha17hSCVgcLF5arwblLNlO0M
 vVXx/yKPmQ36QxGgtc5wwd5MxDgRuZ4U/yYStvVG+Qvts0hh6C+PBNQfIEUatPg6PWp4 KA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jbwbc0v2n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 03 Sep 2022 16:52:35 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 28394qPv017464;
        Sat, 3 Sep 2022 16:52:35 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2104.outbound.protection.outlook.com [104.47.70.104])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3jbwc6tngp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 03 Sep 2022 16:52:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UCNwHdljB4Zr7ZSjpFXroaWn5kL/1JjaGvnsRIIfzd55xroMYsloeKjxRBoDYoJiVWFd5sn68voammSpcpdnYIJqjrVYd7+LLZ6svmyyS4V2NoJCj0VpjoZayHsv9OHNPef+ZsOzDE8Rj4FIQNudYJD6LUSOJL8khvqWikkFWKCDSiNcWH6IWFhUdxyUovnl4eVrZk8luOSjBRkzRViiHUcwJV7W0I14TIIXFcl9NtRwMKIVPgzEvyNINMdltnzisyhBpwE+7sHnl7kI/5nZH3YAo+0At03ehEydPELRToGokXvUmsphqKwn3R8ivzGvD3N+QPDSEvH25lylPpabXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fsINO0suksjvPoEEM+5SQShOuWK4R8drcGnuE9pEkx4=;
 b=QHsG0Ra9/3P3k8dZS8MTXLb6gVqmP3Ccs3sd5P3gUukHqhdqYqUkuBZyNHjq5qDe3Mmc+vlucek1wcvoTvr7A9sl28SIQXUbcG7cOOBeWobCwL/N5ZZ9dpdbA3tyhbB4NRgwaeuR07fngDNZegMg3mpCSdh/M+ai+ivhv06Py6cC/X1GJd5boUqjDRBEP+QyYUY6MSnoH1bcQcfc/zDsVLdGP4JxlTfNs5TvHWhYRxfHM96fcZJHOnO7mkv19Cu8cFPmXUMb40ofsau12LihzQ63wPPvOqyF+lxkwpFMTOWkYN4GbpSDIE0YIFFIjL51eO3dFMpk/Bknup34yT2N8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fsINO0suksjvPoEEM+5SQShOuWK4R8drcGnuE9pEkx4=;
 b=apX8to3eSjO0Q9Rkg1FbEzfGwVfjYhQX/51ErMw4IqZFlnGoWewUQHXuXPgW+Bru0WlGRUbbJqSMGkKX/+vyrpCJyW32aNo1Ksjaj5jT/Mfw98397/TfYke3VwacWQGj9X/H2l2BNMbRf1kctReQmmPyLLPcJVodU4gwXZVBrXo=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BY5PR10MB4242.namprd10.prod.outlook.com (2603:10b6:a03:20d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Sat, 3 Sep
 2022 16:52:33 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::25d6:da15:34d:92fa]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::25d6:da15:34d:92fa%4]) with mapi id 15.20.5588.017; Sat, 3 Sep 2022
 16:52:33 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Murphy Zhou <jencce.kernel@gmail.com>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: mainline kernel fails fstests generic/130 over nfsv4.2
Thread-Topic: mainline kernel fails fstests generic/130 over nfsv4.2
Thread-Index: AQHYvTlPQz8fMrGV1kqvLqRSUqg1763N8KsA
Date:   Sat, 3 Sep 2022 16:52:33 +0000
Message-ID: <EC03148E-4DF6-4D9C-AA02-046AAA1D512A@oracle.com>
References: <CADJHv_tkpQi4F930dS6qadHHR+d5JenfeDzbvAW0okKCMndKkQ@mail.gmail.com>
In-Reply-To: <CADJHv_tkpQi4F930dS6qadHHR+d5JenfeDzbvAW0okKCMndKkQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4dcc0dbc-e89f-43d9-cffd-08da8dccb28e
x-ms-traffictypediagnostic: BY5PR10MB4242:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kRcC9wCnQ460LHWLOmzK1hmiKar/eXWfO2uof5jFYpeMErLPTUe8bTUJZ1Df/PSQ4kabTCV/AILYj1kdCsm6jPukFCJVESpbQ5E+2UbVrZ6gxuAKLtDEAvcUBF15FjVdfG7vRZX0a0+yqR8FT6Rh5AXunvDUJi/XE3m+L/BuJdfiiRKIa66PnwQLxiv4yqJ+kx4yXnjp3pjrnUhSxApjFPk2VbRYpVlFEvupE0UTiZQMKn2HwlOlvbkw9IS5Ip99rfoNa660CSomA6ChA6oDsUDSacN280tfsA3qTAYKNF4A8BXePTMcWC+JhLF4IiU4aHc7F6Db7Jqt7eTE7zR/ranY+rPgxlptF70UrKFVjmdfOepLYQLKN/BNGAPE6B3l/dmdm16+zRsxJAiLtPXUyDsmAXmFTtqXNQtdYflSF1FFP8tv94lkfWzoNMndIC9rXt3V8/uqg/moowYQjp4xMcDWjHAZ0CwY01TasNS+swRemd+1WsjYfS/VkCwRYo1Y+QaCyhu8tm9E/q/QJwp3boXSsiYNDAaDYzjtC/xSt5y42l3+dA6JhbfPSzya/gGlRbU2C2Rced/S1QKF6n3lO7rn9VlRtUd+XKq2R5oJBYyqy/ZUYTEPNQ05+8t9RTmwNulksOWU0htStQQn2nMhHygGQZhwPX4D9TiLGG8M4nrlEnNgaJATm124ZoBRJm6jiVH9owYTWWbALwuHMOXs8pkjM0Yh8se0UpRW95b5L8EiGbmDbj5So+wyPflB+HNNXhw7pDd2ZMmElhOoyhv/BBfJ4jo5rNPKGq2aC0XWb38ojSjLJDIrR4luOCL9RBFe53zMpstJRYorW9EOoI4sQOtg6Y+97o+2O1KqQ3QCWMg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(136003)(366004)(346002)(396003)(376002)(6916009)(8936002)(5660300002)(2906002)(4326008)(91956017)(64756008)(66476007)(66446008)(66556008)(8676002)(66946007)(316002)(76116006)(36756003)(478600001)(71200400001)(41300700001)(33656002)(6486002)(6506007)(26005)(53546011)(6512007)(86362001)(186003)(2616005)(122000001)(38070700005)(38100700002)(41533002)(45980500001)(505234007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?dTU4p8C0p7K8L7ME6Ha39AkwoMPsOm6YQtlJiR49VfOxcGAVGlxcROrt/1LH?=
 =?us-ascii?Q?E3afjId4NbgU1obyDsCadeyq0KlIMWybBr2KRNQaaYSKyi08P5uZvVKw0V+l?=
 =?us-ascii?Q?/EA3w9ORi74TITNJ1+KmXAYKdr8bA7deShMkb/jBPnZLUat+ppFCWqnwK6Nr?=
 =?us-ascii?Q?1xmaEfeRsZetAKu+PI1Ptdc3GRDUfRWx2/3KI2eJ5Pir8+kHwwwjOO/Fjca+?=
 =?us-ascii?Q?WLs6EbcCor4aD63dLXWnhrT8H+0O9OR6WfHlwEttftTLe0nQzMO5EIiigbTH?=
 =?us-ascii?Q?Fo5p0vTvV47pCdNPXIJQcHv9vJFwWw8UKll1j5EIGyiYKQKVpcBkcXmxo/r7?=
 =?us-ascii?Q?J42TP/dnjIqNJJtFAmHSIX9zV6EK9KDLp7OlpGRmGiLkUVnd8/HGtJIc3owo?=
 =?us-ascii?Q?C9AifXkcm0kow3i6CRuDhmzge66qFcwAjZKtQ0ZFLmKcmSC6vgjw+MrpJXGZ?=
 =?us-ascii?Q?Ex7sNX8Q/yoXLXWAyCqrtvAeDabyzxjsvzF+5c7XrfaW5j74/jzr9QNpkVYB?=
 =?us-ascii?Q?JnZqwb9vEIawnnK5A7/z6TFQDVJMeG/rXsh0d5sB45bCEjw8lTx7/wluvAKX?=
 =?us-ascii?Q?w+jrMI/B9wFTqlV3/PN+1jjBK3/OsrHzphr2h+tHl33BgqsMvBRRgZJFPQqN?=
 =?us-ascii?Q?vrr0omzcsU3VYIRFmkrh6MZNa+LCN1cYeTQDHOkX4t6dA8gN0bY4VcmJSkOT?=
 =?us-ascii?Q?vdReGCz90KOquENI0VaBiO51Vvecs96K3AZ1HGRoIdGuYDD3nAPUvMjmKGNp?=
 =?us-ascii?Q?VR/Dmstc838bmgXnDnlfSJV8lmKkllngAJLQO9X3g0KZTTv9dVi2cHKrYpig?=
 =?us-ascii?Q?gj1WbBGtxX/ZcfeS8SULJoEbxBas0OtOIRZajUit+3Bh47vm8SCpUhYy0uTl?=
 =?us-ascii?Q?vBXiOqrYv7RVsnZR68lGnKZa7if9u25MNcLBhh9jkesIA7skutmbyJeZBUtc?=
 =?us-ascii?Q?0BTOaSWaDlpS1sWLYJOcyASM0IKBWzOx9SRmtO5v+hpEZOch6PXeN1eIvA50?=
 =?us-ascii?Q?5o+QW1RUHMNn7vCY1TiED8MHQuxOcTMSQp7xRRJvUCcBsR7Cz7ao520SA8PZ?=
 =?us-ascii?Q?Ik8yFhlQFLI1h7NooA4MVBKEPCLLPOHHKp2srHDM/z/otzNQqMKeliZYuhEO?=
 =?us-ascii?Q?wWOEIFyRWmSPqPTCGZKbFCDKEkuYV84MZf0oBEyOSSBIxZ/jkG3aESXyLStC?=
 =?us-ascii?Q?22yKZSRfdmp6curmm4Leln+V9/OG0WPpLaY/cXE7yHA9sGZhBuAalWdMyEi3?=
 =?us-ascii?Q?arXfMsEjc9n2XCppo3erm84tnINGXOc/fIACO0eXu3e/P7qoTzFvek8EazkC?=
 =?us-ascii?Q?+cLwykWY9//biS/OWz0Zse9hF+Txbd712bFx7YLDHH29tyErmKAGlQRUaxQM?=
 =?us-ascii?Q?NGD6w8baINavW1wDJR8fDn5yzap0ODL1Nz1F7Q4k8//08m5hdREE3SLmcqyg?=
 =?us-ascii?Q?EtHTneUyZ2pVu6DfrS2dN57lWw+i9sJlgGBo3I9ideYtLkzOGVn9ApkvqJW5?=
 =?us-ascii?Q?vcLgbTCbhoc0yKacOBhN9ryeElWk2xYUMJZuL4bdKgnrAWKDKwxm2ogRe9Ck?=
 =?us-ascii?Q?r0xqsB7r3QSTe59bNcdBsPdKlwz3zwhomY3cN40fhzoPHtziiJQsiaV2ofJW?=
 =?us-ascii?Q?oQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <71350EF13635964AA941865E90720F87@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4dcc0dbc-e89f-43d9-cffd-08da8dccb28e
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2022 16:52:33.4582
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QbKPWW1K2FsTn9HdiJCKWOAQZTPoQpT79u3lhFxmu5fB7+Npixt3L5dUtlAcVqNsndzMqgLKoMs+f8dbzaQpFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4242
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-09-03_07,2022-08-31_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 adultscore=0
 malwarescore=0 mlxlogscore=999 bulkscore=0 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2209030086
X-Proofpoint-ORIG-GUID: 2-bDtIVX9sjS4Yg6guc06DWh5fVuwVqx
X-Proofpoint-GUID: 2-bDtIVX9sjS4Yg6guc06DWh5fVuwVqx
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Aug 31, 2022, at 8:57 AM, Murphy Zhou <jencce.kernel@gmail.com> wrote:
>=20
> Hi,
>=20
> It's pretty reproducible for me.
>=20
> Could anyone look into it? Thanks!

I'm not volunteering to look into this, but can you also
provide more information about your configuration? The two
most interesting items would be:

- What filesystem underlies the test export and the scratch
filesystem?

- is READ_PLUS support enabled on your test client? Look
for the CONFIG_NFS_V4_2_READ_PLUS setting in your client's
kernel configuration.


> FSTYP         -- nfs
> PLATFORM      -- Linux/x86_64 ibm-x3250m2-4 6.0.0-rc1 #1 SMP
> PREEMPT_DYNAMIC Sat Aug 20 19:03:47 UTC 2022
> MKFS_OPTIONS  -- localhost:/export/scratch
> MOUNT_OPTIONS -- -o vers=3D4.2 -o context=3Dsystem_u:object_r:nfs_t:s0
> localhost:/export/scratch /mnt/xfstests/mnt2
>=20
> generic/130       - output mismatch (see
> /var/lib/xfstests/results//generic/130.out.bad)
>    --- tests/generic/130.out 2022-08-23 07:38:25.769217560 -0400
>    +++ /var/lib/xfstests/results//generic/130.out.bad 2022-08-23
> 08:09:10.121494654 -0400
>    @@ -7,6 +7,520 @@
>     00000000:  63 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> c...............
>     00000010:  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> ................
>     *
>    +0000a000:  1c 1d 1e 1f 20 21 22 23 24 25 26 27 28 29 2a 2b
> ................
>    +0000a010:  2c 2d 2e 2f 30 31 32 33 34 35 36 37 38 39 3a 3b
> ....0123456789..
>    +0000a020:  3c 3d 3e 3f 40 41 42 43 44 45 46 47 48 49 4a 4b
> .....ABCDEFGHIJK
>    +0000a030:  4c 4d 4e 4f 50 51 52 53 54 55 56 57 58 59 5a 5b
> LMNOPQRSTUVWXYZ.
>    ...
>    (Run 'diff -u /var/lib/xfstests/tests/generic/130.out
> /var/lib/xfstests/results//generic/130.out.bad'  to see the entire
> diff)

--
Chuck Lever



