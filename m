Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DC747210B3
	for <lists+linux-nfs@lfdr.de>; Sat,  3 Jun 2023 16:59:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229675AbjFCO7Y (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 3 Jun 2023 10:59:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbjFCO7X (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 3 Jun 2023 10:59:23 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B7F4A2
        for <linux-nfs@vger.kernel.org>; Sat,  3 Jun 2023 07:59:22 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3533wJEN018621;
        Sat, 3 Jun 2023 14:59:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=GYEosmIzXfwu4SyWbhriXSwq7f+HqBYGZ8UT4lhawkQ=;
 b=O11sHc+/AY5zfDsxAEomvx8+Rvyt2SaNCpEdmISxnG7lcmx2D7KlhBxRumhnYpYwQvGj
 B3Ys0tYkcVQS/Mf4KcqL60TSIYdA1rrmH/WbQ0SFN6fUlB9BvnP8XU0ISSHOg2xGgniV
 wIxoCLU6K/Dldi1WMuLZh9+CYTd+ncjNcQbuLAvI5bNgK6s7o4y79Th614BYid7su0vd
 o0y+pKpESDBO5cNm7hsvDBrHhq6nUswvhcjaA3uoIuyKrhs7c6FZw/d3pbYFwdbbo70q
 Sh9fLtcepRgv+MLix0emmQ66u4/qHTcN1AQJP0bH1uZxGiZXlmgPzKa7QXRXl9CBQENW sg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qyx2n0jvu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 03 Jun 2023 14:59:15 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 353BO1v6011159;
        Sat, 3 Jun 2023 14:59:15 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2175.outbound.protection.outlook.com [104.47.57.175])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3qyuy7ug2u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 03 Jun 2023 14:59:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CUBXSdX9ayIrhZuobFQsv4sg+iLWsku2NtTmIPSl22tDaUmHoUwtVWFVwgWCsnX8PlKP0GvvZoMf56OB7xC+FRKQNhsl9Lu62kC9erfwN7ypjBagFultPvzLyytAos56l36noCUBUELmsN1tZISPLvg8zJFfE69QkQX4C8wftr++Qly4YBEqvdA7fJsr/Xum9pnczwThTd+WgTvO8pCX4R9R5XKcMGpqSO/PGKy5n88qDu34bJhDPBULhfVXf7M/qiTp0+HGM0S3fKBt7bwrGEU7v35FJ4tVCAAbfb9KtgyYhw3aARRZNarGc+jhm7bKp//XJ64LuBDrGZl23WO+Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GYEosmIzXfwu4SyWbhriXSwq7f+HqBYGZ8UT4lhawkQ=;
 b=acsT6eaWfp5wx1VQiT5gfyTuU4hSh6t3TLC6Ww+nv7Xj1PaAVLHRa3zPXGWycnbbonBkACYB8ViNziTo1YJ6TjJxVOmI+pupi3s/gicfq2yA/Orfp6RBzUxfAh1Zs0RxyPGxevORTVg2qZun8ElUPqXSAz1hvs7ArEzX3kN8HXvcbZ2nECRJQ3hjQq+a6q8pDPX47lVW+NQgo2Lbny8EEuv51p4U+p1aSiJhZ/+sjHg/pRn8I4fIOlCgF6Mn7KPax+pyKYpK9Q9ShWdI0sv0zwv/qLF5gqCOGMMcgcL4lEUMjXIfhT6hpwhduzqbGIU5sEFSctKuFvsXxyCiw3mMjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GYEosmIzXfwu4SyWbhriXSwq7f+HqBYGZ8UT4lhawkQ=;
 b=FlbqmXGOjBqE80HQ7hEHVeBJHe0+dQ9V4B4Ic6SZ+B1O5DKjmJqkvteVekc+n1COxJ76OhuszxWtWPxi2ogxnOOswvCzlVIUlWlgPtLoy67/Wn9cbjjDJEV5Hktc7/2RK1EH80WHM4bkbFkpPcr/sVOfUkORE697W8EP7j3Gl4A=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by MW5PR10MB5876.namprd10.prod.outlook.com (2603:10b6:303:190::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.26; Sat, 3 Jun
 2023 14:58:44 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ecbd:fc46:2528:36db]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ecbd:fc46:2528:36db%5]) with mapi id 15.20.6455.030; Sat, 3 Jun 2023
 14:58:44 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Ido Schimmel <idosch@idosch.org>, Neil Brown <neilb@suse.de>
CC:     Bruce Fields <bfields@fieldses.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 13/20] lockd: move lockd_start_svc() call into
 lockd_create_svc()
Thread-Topic: [PATCH 13/20] lockd: move lockd_start_svc() call into
 lockd_create_svc()
Thread-Index: AQHX5N0WWgW13Lz0b0Kb4xgS36Hhoq97CRkAgABfhACAAMqoAIAAWryA
Date:   Sat, 3 Jun 2023 14:58:44 +0000
Message-ID: <303B01EF-AFDB-474C-B951-0F2A118416B2@oracle.com>
References: <163816133466.32298.13831616524908720974.stgit@noble.brown>
 <163816148560.32298.15560175172815507979.stgit@noble.brown>
 <ZHoO3GRH6h/bcRjm@shredder>
 <168574130862.10905.10707785007987424080@noble.neil.brown.name>
 <ZHsI/H16VX9kJQX1@shredder>
In-Reply-To: <ZHsI/H16VX9kJQX1@shredder>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.600.7)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|MW5PR10MB5876:EE_
x-ms-office365-filtering-correlation-id: a44389b1-af0d-4527-22d5-08db644306c8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UMKVhqcZrQ9yHBZj8xxDfQVHOxaV0k3V/pfQA425QZpp7reSnacc9j1ypImjdUzmvPJ81H5PsQdh4yOy4Jp6LaEXLrKzZa3gQUki5ohUV9VgQhYm6tICIA1WULbEKbkReoNJQ1spfT5idUB/LzwpE9Ck8mTV9DCVbRIdiMmJY+PahfpEkaqVPhCft/XImoj0mWq7C67RcnwEIxGT5GoYkEhTIyCz4Tswj3dZwfOKzUGv9H4FGMlZRnh0EDfdTdTa/SA+yVMjFpAkZTb2NPp0UALEaKwaN6/gRhl/gobh1OVKvIM9KC9PUN78ZoYrNNwdTbL0vAhG6QclIiUpHfO43Fo5T3TplWq/rS0tis3eqbKdBI0yNbch8ZwXc5WQCDRyPcISmpRzPHWzzLSLlrqGCaXkviemUFEne6OOoDVpSiOZOM5TUus1Zefe80lw0zlK/embt77Ty1C2JJ9hr9jVKAemdFwv7T0Oh1ygRJsaN9wKJxqPWO7Ve8pbuqlF6I6RNoJ0fyIwjGaDQa1xZavuksAqu9chYHT3TCqumb+Lq4nP1EQ2IS5mvqt2a1d3gpH+mGIazSyJImubnYi/+xX+hxp1HuApNGKuVUUJxdtcJeX/hI41xQ0gCr0Rj5uQIO9F6NtC3m8C5i07JnD7XXTIRg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(346002)(376002)(366004)(396003)(39860400002)(451199021)(38100700002)(122000001)(110136005)(86362001)(54906003)(478600001)(91956017)(76116006)(66446008)(66946007)(64756008)(66476007)(66556008)(33656002)(38070700005)(36756003)(71200400001)(26005)(6486002)(186003)(4326008)(6506007)(6512007)(53546011)(316002)(2906002)(2616005)(8676002)(8936002)(5660300002)(41300700001)(83380400001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?bx8W5Um+hmA1BTxIlbAJ1QutuBDY1UwZdfx7BGe2w4DSpzjMW6F3qjRcfMjz?=
 =?us-ascii?Q?6IiV0H1m5wBy3jNyAMCHj4ffL1Q4OnG2pHU7lITH7Y3tU/FrrrS2peVvJgHJ?=
 =?us-ascii?Q?iKLVfG129Ow3sxuDgqhBXyCcjhCHSDnsdSjH2IuWQVz6ltr2TPYmKlnPNgWv?=
 =?us-ascii?Q?T9zWVYFzfVxRlIUMeeu0pJoxi+5PyQHMBne/dbrICIDzTRyPZYYxV3LDIS2z?=
 =?us-ascii?Q?dtYYRkVBkekKqhE6eDw2xPSs52MHQ3eG7TIUyaZL7IypJ8khEyIXUZzfEiWz?=
 =?us-ascii?Q?6t3OY3lUikUC/l4C4541lOj1MfEWFH6ds+2GMiQXO7MAHvK5tzKcu+xpkYLf?=
 =?us-ascii?Q?bdh4bI2BcDeXapmcTVdDOMvTcHBJqbxocrJw33Y9e2Q+iPR9PxyO083WwZTN?=
 =?us-ascii?Q?inhjBm+qzKQPZNZ6FvQ/7ck6FSsvwldvmRNPzHt/fbCpig8Q0kiTKEpUy9cS?=
 =?us-ascii?Q?QupnwkxXFi2AVLXCqLwrw6MOVgL5V2qgQPrbyXuntv4xO8H+XM5pV3QJWeqw?=
 =?us-ascii?Q?gbhHxFX6mqvRtv/oRFrLRKeSLMxnIO/lVubldF9PpSEnZ3Ch4JTJPz2BuFeJ?=
 =?us-ascii?Q?bVKWTJ8nqNErBKvpPFxmsk9Bbq2GAUKRBXlROvehS+Oh2Ko2mD1TtyuLIQeu?=
 =?us-ascii?Q?RSEWu+7Zhr9d29G48PT9xc0sba9RoDfwjlhiPcEOllExVGX0IsyItsObxjhk?=
 =?us-ascii?Q?42k4GrrokQHmPnLQpUn3evI7gcgG1RytuAG/uZLsBQMYp3WGaKIROAaCfqTe?=
 =?us-ascii?Q?W0zVHlStg9e1NM+i1RxhW77Gd+w3+02mcLP1YwMILoXcaqWa6WMni7KEDN4I?=
 =?us-ascii?Q?zMhItOZuVwOTJBph3l40PyZsoyK/kpoqa8m3GpTN72rbAdV87dz9kJE0Sf7P?=
 =?us-ascii?Q?wlXDqa3Ko+evyVanQvUCKJ5uWWN9yLLm4HBVE+qh1NpHAivgbBFdldsnO6KK?=
 =?us-ascii?Q?BPZCJN2wOWifQGe4Wcfm9fMj2sKjuo+cvYosTTrfvrqs4S5+Hi4IBYn+qK5s?=
 =?us-ascii?Q?CDFyasJJaHONla7XJVXjno6KEiEfAwhOa+aW72XLPvaIuIv19ptRDV3XklJ5?=
 =?us-ascii?Q?rNvS4gQoAhtt19nbKXJ83+1sdA5ddVA7aVP47/fQCIECjb7rSv+iv/m7VCg5?=
 =?us-ascii?Q?p+30xbfg/te4+4mE7TgvIk0zvrcGxO6mvDdkWDiE9GpvXRcA648j445YH8Wr?=
 =?us-ascii?Q?9yHV/1zyqSHKekcMyLlofYDusb9q3Q7sv3S6yuf+kwAjYsX2kQbOC5Vkvad7?=
 =?us-ascii?Q?C9i/1Psj6MmUJWPQkVR5LLzRrpIl6AooP/yht5fXiTeZyMwsfKOG97CuAPhe?=
 =?us-ascii?Q?CtnezoWiq6U+RcZy7YapESOlgOjFbt3vCJIjyfHciW7ugWJFdQeL3l7T6/ep?=
 =?us-ascii?Q?KRv0sCULycKsTFivPUN69ROH0EqHmgkVVuzRjo4NQGKJi/gV9qeTLLZVHS0F?=
 =?us-ascii?Q?1c01fVdHLLuEPfp/E/lL2dsH2y43xw1y/15G4lk3vymNpio/R2TL1ZbSdZIm?=
 =?us-ascii?Q?ypqj3HfN15MZU/rhHYDUlqJ51fHZ8oatTCnVfh/DvYRvzQnMc1ReAlotuFm9?=
 =?us-ascii?Q?KAmoTMZEUYzr6uxvrYuWYzYrrsVBhIC937g4CJCM6gRaLwM6oD4oAlfEb6Dw?=
 =?us-ascii?Q?sw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2AFEC01DC0A2C04387B97FFB4D86D2A8@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: e6vqHdIjrp7NmPjNgnSF+HowkZiomdCBCGiFH9XSF/j8qA2Hqy5Un4lKPfvRb/XwwfCDWMISgMxYRMJciaOowmnvp8FLwb7OpHMnN5uZgG6b2NfLTqi1siYX8WQATQWkZnijM+lM3cmblD7RPcvjMw+n3ZXhUA6/Cu9KMkyxwVgWtgoB2lBikBvv/hxBBP2IWxIc8yUGciHT13rm+pri44eN3ctvRafJ9mZq0IuSTkCNjLSxjQOZBbkixs/v7WyhrD6/a65JHcpADTcPrwr2LXmnZDUOtGEEeAy/yMowXWo2Hxj6UDWpEj6uDh3KuxkfXexfA0G4+tZw+jhJl3NUmuOBD67VeIKTrSxsCbVzil042+kSutpSp3ajKCiOP2y0E5A5NJTtQuEpVR54PvdbWeIgakw9IP4B2IuNQcS0agOctKJ3f2Wehp2UP8nkSqc9HiEW15S7Kags2IdzVgFPJ++nz1LsFykn1CTqSauZGciutuSnHAPlnkm8iS4xES8hZ9KvSKrIx5q19fbQxf5qwFtccv/WoLFCI6bLoZsqXpdFWaimZGcSrAZIw74lTOgszK7S6Fde/bvpsbCOiMiKKekMxbEP1/7Oj9droDglDh3bGR4sxJA4mky9TUJfqZI7tfXQyb+K8rAyN9nboTiPWyGERzE49lMtEuFS10Y7odiBSBN88u/Wm3vyyt+LIsXI1Ha5yU+YtxhIV3GNZIvc9687vPWjyoj4a923uSfnm/HFLS3mO+H3fVI+kz54UBNAMK+R42HUt+DyjpiWJxx1Nc76q1aKuGV6Lyg0xhG1kaKfsqRu1lzTdHoGCva6l3IClVlMGv4Pxf9Uza4IvpjT+w==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a44389b1-af0d-4527-22d5-08db644306c8
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2023 14:58:44.2045
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uiUMUsnGY618gW9L/W5cOMyosJBivJdYPFVb+cL6TSMJZ/gUtYt3WTup2KDb82vIGEDL4+XZPLcZ57YHLI1a/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR10MB5876
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-03_08,2023-06-02_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 suspectscore=0
 spamscore=0 adultscore=0 mlxlogscore=948 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2306030137
X-Proofpoint-GUID: sJ_OARfcOjgxcrvFcn4WisTeUeu_VwLf
X-Proofpoint-ORIG-GUID: sJ_OARfcOjgxcrvFcn4WisTeUeu_VwLf
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


> On Jun 3, 2023, at 5:33 AM, Ido Schimmel <idosch@idosch.org> wrote:
>=20
> On Sat, Jun 03, 2023 at 07:28:28AM +1000, NeilBrown wrote:
>> From: NeilBrown <neilb@suse.de>
>> Date: Sat, 3 Jun 2023 07:14:14 +1000
>> Subject: [PATCH] lockd: drop inappropriate svc_get() from locked_get()
>>=20
>> The below-mentioned patch was intended to simplify refcounting on the
>> svc_serv used by locked.  The goal was to only ever have a single
>> reference from the single thread.  To that end we dropped a call to
>> lockd_start_svc() (except when creating thread) which would take a
>> reference, and dropped the svc_put(serv) that would drop that reference.
>>=20
>> Unfortunately we didn't also remove the svc_get() from
>> lockd_create_svc() in the case where the svc_serv already existed.
>> So after the patch:
>> - on the first call the svc_serv was allocated and the one reference
>>   was given to the thread, so there are no extra references
>> - on subsequent calls svc_get() was called so there is now an extra
>>   reference.
>> This is clearly not consistent.
>>=20
>> The inconsistency is also clear in the current code in lockd_get()
>> takes *two* references, one on nlmsvc_serv and one by incrementing
>> nlmsvc_users.   This clearly does not match lockd_put().
>>=20
>> So: drop that svc_get() from lockd_get() (which used to be in
>> lockd_create_svc().
>>=20
>> Reported-by: Ido Schimmel <idosch@idosch.org>
>> Fixes: b73a2972041b ("lockd: move lockd_start_svc() call into lockd_crea=
te_svc()")
>> Signed-off-by: NeilBrown <neilb@suse.de>
>=20
> Thanks for the quick fix. I no longer see the memory leak with this
> patch.
>=20
> Tested-by: Ido Schimmel <idosch@nvidia.com>

Since we are getting close to the merge window, I've applied this
fix to nfsd-next.


--
Chuck Lever


