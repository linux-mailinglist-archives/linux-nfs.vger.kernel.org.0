Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01A5E758448
	for <lists+linux-nfs@lfdr.de>; Tue, 18 Jul 2023 20:12:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231852AbjGRSMp (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 18 Jul 2023 14:12:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231782AbjGRSMo (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 18 Jul 2023 14:12:44 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9F0E10B
        for <linux-nfs@vger.kernel.org>; Tue, 18 Jul 2023 11:12:38 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36II64IT007977;
        Tue, 18 Jul 2023 18:12:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=RDPMEqVpChXbOJSEatqGO5VoYipOjd8WbeexmBdKv6Q=;
 b=GlyP/k//PXTrDxdQqIYa2CXVUqkcdZLosBLbFpZm36KSnr8rP/jOd4YzruvntFIKkbP4
 NuOkJz+lhtZsmn1CPTrwRk9GuNDME+E6gS4K69AlE4Jw0vfNRPOkxOdLMCEVShUQfhd2
 UmF/GpZlVbHNv4I8UGmvix5R/DGhLHpYFKaQZSZUgmLiowYdsn3/k0DVYXyxDAeZN0hH
 JuZB+QDvG3cf6OpITNdouk/DclSjJvVv3vQqJYY+RE2c9xXHTGywTEhGmvZpcl8XlTpY
 WnJ9m4z+vkU0t7BTc5dLwXnyDw2hmwWDtPW231T/WASqhN2YyLROob4Yjg2HAoNUIMbg FQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3run785qjp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Jul 2023 18:12:15 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36IH3XNA038249;
        Tue, 18 Jul 2023 18:12:14 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2045.outbound.protection.outlook.com [104.47.57.45])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ruhw5gg9v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Jul 2023 18:12:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K8gw+zTEhBg0C0DAZ11uHeIe3WGYyQtcpmXsfUET4mX80cMrykV7EdSjEMb3g/0C1I+5G9xwWAb+E9Ibox0yPGihHqWhD50HNj8rvXZiD1K7od+6JFCq1aiXfSCXk0k5anLNAKmRi/hh9hJ7r/v02UPdDwezfQ9wHfxvxeGY45IUqxNwmk7pA4W0eZV94vV+XKtJYoKwK5LBTQxRIXkr222gx2GMiuahGS6gM/WAEVZqKZC6zBuaUSz9sJ5jFPOUm/oqkYsaIqflGn97U+arB8Lq9XO86scbbC6YVhjsyXn/94ZtsLp1IXGwusgoPf0aqDbatr4HSpKp2MHoz8mLhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RDPMEqVpChXbOJSEatqGO5VoYipOjd8WbeexmBdKv6Q=;
 b=m1fq8ENz9+6e1lIKPjmSQvt4G7tijmSWhd/uAvnkHRATxomLdPmldP05Fbe2mPzaT/KRqiujZhwWBvW4A2gU+kY7RiDRHW2OFFava4/iTTfl8Fw5ZMn383TMtre4G7p8Pg5uaY4Hh/TcxOlBTPNxAtjRDbq39d7qjb9P5iMIqn078BoTRGQg/Y65LnJLYV0V37q9DSDdb3p84aPZv9m3XuiQkh02Eus97GEGwZU+gkzgAQzIXxtJ2fBbR1T/060p3AhjZAFJcIcW4Z5TbRg0/iPlHsF3vBrMC6+wHKmKqW6y4WWNatcQGvMR9uciOaHYUXyNzMEsQ0yIdLpjTzhiyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RDPMEqVpChXbOJSEatqGO5VoYipOjd8WbeexmBdKv6Q=;
 b=qLNXLcanmHt/JSr2wgmEkH85D2IvascHw1L2HOrRZZGjBvVVQCgU0HmWaQKn8Q022T6XtlDSNr5wEt9uZmm3srH0CQxBVRRZXow5WlN74w+wmiGlFMFP8wOa7/Bvk1gyu3dBdSbSzp8+/6tdiOuDFfmqPaLKQMRBmpbEZftAzeQ=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BL3PR10MB6257.namprd10.prod.outlook.com (2603:10b6:208:38c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.33; Tue, 18 Jul
 2023 18:12:12 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2990:c166:9436:40e]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2990:c166:9436:40e%6]) with mapi id 15.20.6609.022; Tue, 18 Jul 2023
 18:12:11 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Neil Brown <neilb@suse.de>
CC:     Jeff Layton <jlayton@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 00/14] Refactor SUNRPC svc thread code, and use llist
Thread-Topic: [PATCH 00/14] Refactor SUNRPC svc thread code, and use llist
Thread-Index: Adm5o1+UDc5WVSn410O85Xbku7g/SQ==
Date:   Tue, 18 Jul 2023 18:12:11 +0000
Message-ID: <8DE79CFA-4382-482F-92B3-6802DF536853@oracle.com>
References: <168966227838.11075.2974227708495338626.stgit@noble.brown>
In-Reply-To: <168966227838.11075.2974227708495338626.stgit@noble.brown>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.600.7)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|BL3PR10MB6257:EE_
x-ms-office365-filtering-correlation-id: 11b449ff-f00a-4d81-1f83-08db87ba8216
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /OET4Mt+m3d8FN3axFOqcApwQMOMhcjOEKkvYoccUe8oyHLIKK/jEyHPhBgzlRWwLeF8wR2kh1ZCZdNeLrVHF3PxSsH9CXsED4zHNZqveaEqQBYQ9gxmFatboa9c1e8LrylGKvVuZL32xYMfA1J4+QYoRVWXSn01ev2VrydYtI5W2QgZOo2c8sWrUv4jNL0MZVTDsz1vlXstZmT3fAYN6MhK1nG8ILtlJ4lZ69Hv2sZSMxxp5c+rYx/IyWxH5q0oAh3yeoTJ1sJWb09+l6abPQyAO64pKB+2SaR4Q6//BHkI+NuXObQ3j4hPc9xMeKSlekMlTcQ1HqtdbQJvE8dVpob41i+l7dS/jmFfyNWJtNTjNV6TmRoMxqKkPCTP/S21SgxObsL8VnoTNL/ObEAHJKcHy8W4+lBh8zSb4InYIM5iShO5yOC6AhevdyENPZA6ydjAdkBHbmZNJQTuhWzwplZMFzu3G6zxfLzktBgbfQwz1igxdAGpqgA+WQaq7sJvtYR0aQk5NfwI0D79MWEMTE/rjucEvKxtWYQgI+VjXU843hzVrx0yMNBmZZg7XJWkJ1I4dokQTqnFi5zz1Fp1oqgRWjr/Sy6qSucLFxIkmL5hY7fFn16SrzO1GnGo/DC5bGy52KAcTzrwTE6/G4AssQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(136003)(376002)(346002)(366004)(39860400002)(451199021)(66556008)(6916009)(2616005)(83380400001)(66446008)(64756008)(66476007)(66946007)(4326008)(316002)(6486002)(71200400001)(6512007)(54906003)(186003)(6506007)(76116006)(478600001)(26005)(53546011)(91956017)(2906002)(36756003)(33656002)(38070700005)(86362001)(41300700001)(122000001)(5660300002)(8936002)(38100700002)(8676002)(66899021)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?P0S6QQB5uiHuK+E36Bx2IDB6Y3ye4lioWFaVtHfeMofsKsDEbA2RKCkhZ83b?=
 =?us-ascii?Q?EZd4GQYQcjukPyYCWmNGXwEaZJiReuLGZ64LsU/BwsvBQ6d1j43QtyVXFCl9?=
 =?us-ascii?Q?xu5fgFQMGAwg52uUwmi2DqWaFldxO0gZYgL6eeICDF333i/xCUNVNIV26Qc5?=
 =?us-ascii?Q?OzdHYvQJT39zjsxTMOWHEFeLnI/syB2QwPakT8kxeDjjMq4CaGjHSq+hplO+?=
 =?us-ascii?Q?acjYFGnlkQRmDQvUJHsp5CfzLMxd9f176JUnEgO3X3ON1pkaEDNA2ygHr3AL?=
 =?us-ascii?Q?Dmx47xipBYXUby0OgeqIUvsHbeCx2bM7R3SV9+8WIPm/iELl2NgcEz8WUtIK?=
 =?us-ascii?Q?wG1nApjpRWjUo+yi3GQpmHNzY9Tlwm619XXEhLflhuwWxcj6YBSC6wXrw/Ky?=
 =?us-ascii?Q?ULuNgYlQu8gbZbR8cucwZvfs40mwLesxI3U/JBfw4/l5yKccZPDX8QbZA/vb?=
 =?us-ascii?Q?YNNrgTPaX0lQkBySyy8A/EN3Q+iU9ChiReFqHDQNJUmjO9hhaAtsy7P1OjKg?=
 =?us-ascii?Q?Vch2ag/Z5N1bDDARfb7DCHM077gtoc++V4/Jb+TY1D7/PJT+wFHqqDarzdq/?=
 =?us-ascii?Q?/mItLNz/l9H0P6zkOE41MawZFDuVEqcDc6J8/2M0M+lS7bFWt9gSa41GS6dv?=
 =?us-ascii?Q?7JN7jNs6TOI7L1hxwhQehEGVOrU3WMOKX2U2LJG0Jxeml5oBunLts+s1YRSx?=
 =?us-ascii?Q?+3t+mclAR4Jdb02aS/dFcmPh0YoA2cbkkKhWdNvIUABbLRuHk5vwXoXKwgnM?=
 =?us-ascii?Q?QCef6zG9oOSM9NHcPntkBX81+9NdQe9Mj3y4AHLKiYG/roS+9wmZYairCPPb?=
 =?us-ascii?Q?lkwweLzYJVG4syhbNaqQUvYZr9PojEzM+XMbh1o/1GALO9KvQ1zvPNNeMKwt?=
 =?us-ascii?Q?EOvq9N7Y74FvNoJZwGgeytzMsJYvw6IcSP94fwlHsgou0I7chvZhGp7RIhrx?=
 =?us-ascii?Q?Jw4ikpjG78z/6BkBwOZsvXDA09eHE5BObdjkuowcOSW41pItgHxujlY1QAOd?=
 =?us-ascii?Q?QrQUxyJPvdxmSTG/LYpPxsGw6ZNpffqeuS8uELptMVy7vqK5/aZ8j/HURJgL?=
 =?us-ascii?Q?hHWhhNJt42Nh0g5xU8L+f14C48zsv1iWmu5oC2wZuI4OEO525HY962NGgar7?=
 =?us-ascii?Q?ed4G2X+x6cNCwV9Fk36Sh8edbb6o/zPd/yhA7hhroOrq6LaFFljm1U/GzYEK?=
 =?us-ascii?Q?Wya7cYRTaPupQqKd3XyyoMzoru7hs0EvePi+XNhVtZO9d8hpztrKeusUPVwU?=
 =?us-ascii?Q?SfdxXTw0JJAVUtJX7hJWuYv68Gocnm66vTXzoU5leurvATqyIy+Yb3MEKukc?=
 =?us-ascii?Q?81ehLuJaCpytbLwyS0z8HGKdnTckkzWCEOuvTbgp3N6R152K6OCmhKGg5nII?=
 =?us-ascii?Q?3ylq82+s2ElrY+F3KvVZfTbfW60cwRkWNWi88VCTbhIL+W35oIlpXGyLMIJc?=
 =?us-ascii?Q?OaAQSuLGSAouQo8q5H+sltgQkQFozfigUY7yxo9r18q+Ebo/q3jWJYSpJ3gS?=
 =?us-ascii?Q?TCUvf8SaAjST3UkhmBNnnSAT/VuBPp7O0wW2fVGaUKcM71dO76PgXQ4StNnj?=
 =?us-ascii?Q?CSm/i09BYSlSKkkaaiqgmnIbIkCaSgNIU1n/H7Kzjr4YFgGzE81Fm8rFGmNl?=
 =?us-ascii?Q?GQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <0CE0491A53AFFA469A783B608C442F7F@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: hv4uIUVIVSOJwObdMwXH1CJWNHgzSy5uyf/SDTpgx+rs9K30e4TLLsqIpKFbyNIOByW5KDDnU66kMkfunJ4WBrfDBEilBJc4B39mc3SDVMb311Rfon/lgVtBDK3eG+Mh78Qc9giGEiE5Fw+rsnXquQhpTPYDuylE8/LEvIShsNbZpmtCSeeLUYJXTzTj4ruaBrIvUMZkcv1OtAL6dR0qRrRrpLEu5rqEHlTAbuQ+7aXQWrk5h23OttTu4HDEpYIHupyPnhG0IWiNumTAO0qAQyfedxWj/61mc9pwcP20IY3Dgzept9elML7slqNDGTEx4YSKPL3ltpAEuPyTmwG3IgXTayTCaho4W6VI6GfJVUvohrSB83XSjA8itit35TaskV1BrZPFFHUfFtinH0sp4EMDPKVkvCBJIXpd0LrTofuTSih4nzSFFyi0Cw4qhZKixXbH+kXcXhXfF4I/V9lZLrpZTdXzH76/SsLkaApcTD66Z4W45/Br60tAtXPbw5bdvcfXc7wR83f2bKYR15Rgxrd+jnNWIsXg4AVWEPiftLi9aBZ6dReeSXCjQ5mRSB/ADM67op51esx0BHezOx99K0paDb/o0DPTlUZ8vvPNd/AzygtJ1NLAcWchnY/uYcXef4RPu9FMbgtvtsx25E5rUm1phkKFmZg2+T3Ozm+LCDjOlCz4JIzyWaesId8JXMKKpxauvuGZgTB1JHn5fDwPk6+SKbXeHevZk8D7MsnoV6jKVN9WxYP7yBnJrGkaZ4ql2eSSFjq9BX8hZLe5VEL6jXw15H5igCXh34FOw5F7SyzflY4LYD/9i0SxAxhIh+ea
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11b449ff-f00a-4d81-1f83-08db87ba8216
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jul 2023 18:12:11.8710
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zVQIcZJWeIr1+tvrzHVpTGL8Ut0TRR+qbRdrAAHx0JBkTz2PpbiI+2gytiiMk+YXcorKL4uqs/a5GjG3m8MmYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6257
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-18_13,2023-07-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 phishscore=0
 adultscore=0 spamscore=0 bulkscore=0 malwarescore=0 mlxlogscore=612
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307180166
X-Proofpoint-ORIG-GUID: xAoqX0TQYbajcz9TKMEtO5GR8NUimvoS
X-Proofpoint-GUID: xAoqX0TQYbajcz9TKMEtO5GR8NUimvoS
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jul 18, 2023, at 2:38 AM, NeilBrown <neilb@suse.de> wrote:
>=20
> This code .... grew a bit since my previous pencil-sketch code.
>=20
> The goal is really the final patch: using a llist without spinlocks to
> handle dispatch of idle threads.  To get there I found it necessary - or
> at least helpful - to do a lot of refactoring.
>=20
> This code passes some basic tests, but I haven't push it hard yet.
>=20
> Even if other aren't convinced that llists are the best solution, I
> think a lot of the refactoring is this valuable.

Some of these are indeed immediately appealing. Let's work on getting
those into the code base before we decide on the scheduler changes.


> Comments welcome,
> Thanks,
> NeilBrown
>=20
> ---
>=20
> NeilBr own (14):
>      lockd: remove SIGKILL handling.
>      nfsd: don't allow nfsd threads to be signalled.
>      SUNRPC: call svc_process() from svc_recv().
>      SUNRPC: change svc_recv() to return void.
>      SUNRPC: remove timeout arg from svc_recv()
>      SUNRPC: change various server-side #defines to enum
>      SUNRPC: refactor svc_recv()
>      SUNRPC: integrate back-channel processing with svc_recv() and svc_pr=
ocess()
>      SUNRPC: change how svc threads are asked to exit.
>      SUNRPC: change svc_pool_wake_idle_thread() to return nothing.
>      SUNRPC: add list of idle threads
>      SUNRPC: discard SP_CONGESTED
>      SUNRPC: change service idle list to be an llist
>      SUNRPC: only have one thread waking up at a time
>=20
>=20
> fs/lockd/svc.c                    |  49 ++-----
> fs/lockd/svclock.c                |   9 +-
> fs/nfs/callback.c                 |  59 +-------
> fs/nfsd/nfs4proc.c                |  10 +-
> fs/nfsd/nfssvc.c                  |  22 +--
> include/linux/llist.h             |   2 +
> include/linux/lockd/lockd.h       |   4 +-
> include/linux/sunrpc/cache.h      |  11 +-
> include/linux/sunrpc/svc.h        |  87 +++++++++---
> include/linux/sunrpc/svc_xprt.h   |  39 +++---
> include/linux/sunrpc/svcauth.h    |  29 ++--
> include/linux/sunrpc/svcsock.h    |   2 +-
> include/linux/sunrpc/xprtsock.h   |  25 ++--
> include/trace/events/sunrpc.h     |   5 +-
> lib/llist.c                       |  27 ++++
> net/sunrpc/backchannel_rqst.c     |   8 +-
> net/sunrpc/svc.c                  |  71 ++++------
> net/sunrpc/svc_xprt.c             | 226 ++++++++++++++++--------------
> net/sunrpc/xprtrdma/backchannel.c |   2 +-
> 19 files changed, 347 insertions(+), 340 deletions(-)
>=20
> --
> Signature
>=20

--
Chuck Lever


