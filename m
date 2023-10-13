Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F33BA7C853C
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Oct 2023 14:02:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231421AbjJMMCf (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 13 Oct 2023 08:02:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231452AbjJMMCY (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 13 Oct 2023 08:02:24 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B348C171B;
        Fri, 13 Oct 2023 05:01:52 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39D7OjeS022472;
        Fri, 13 Oct 2023 12:01:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=UgBHciMsesk8EVidEr3TovpFYvgIYorh8weDONs/Q6I=;
 b=M4D3xB6OALCijXFjZH2g1iawGOe5tdc5vcU4Dpq6f4vL4HwzUFaZPDCrCOudeTbx6CBY
 208zJG7ePLrDxGH5D9+FwP+E6Bh/EgYUUXxtgw90Tmo/7WmIbDrhK+QF1YIx34DwWgFN
 XTDhbfUs4Od9gRG7MD889o5WUvf1ItRy/N7ZNSZK8bpDK8FWIGNj0rUJgy50PB+J0Osv
 PeXV3re1hBgKeWqGggaFA3ksnzxKpMQdFc5Q+8v5FNlquXeIPHfAq3d+lf4ohT9Q9HK8
 GB75wh6bAYJP9Nn358jAr+c9IXpQw29zVtMxl1qlP8o5v0IZPEFaULza9evHDPVUiN2n 0A== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tmh9125qv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 Oct 2023 12:01:45 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39DA8hVt039128;
        Fri, 13 Oct 2023 12:01:44 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3tpt0trsg5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 Oct 2023 12:01:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m1nB5rNKWjgkrJ4vJ7xRyzf79CtLvI9p2FWs7o6ioyAuVVJkc5zMnNFlj3l+q+RYAvW6X1h+ZQltOeq+xH+deZkEeN5zaDi6NwCgl3pyyM77L9BRqfUjF5lGZ+c9Zf1ymA1JUZb5GHy69f1PGChq6KYgbUc1ESr+lKzkatEtAlrTPkh1MeQ4Y3TqlnoZUyD72fsKQ2HFnRybHgMcHhZVqIB4XBME53oGb/lrcToO2MU1MIVDfipg7NkNUMYF4sHmjjadHXaOINXOXNuOWw4wjY6sXn15+meMJM6L8G59cYE69O6A+HeZgEgPaPawWzA+ZbMy5/++YDaMSYNKsqa7lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UgBHciMsesk8EVidEr3TovpFYvgIYorh8weDONs/Q6I=;
 b=ja85tMyOKS+T1OA9bpjqJpwuz30Jyy2MZqrpX4n+oG5TYx8KvRfDvxN/gCdWq5AGJ/4gmM19TpPLg3NQGtfNmgLs6uvNF3nOYcrrpv/vSPz8HODW3j5P3PtNCNiI8n7q7RnqYt2LypYKqwk/FwdRBbEPbegzjhcZhIAiESEkL8IEJZckEP5uEJQnXwhJd0LcnPLPbaAi5cllIHTJGl3mwWBI0juLbnSVviQcUpg5qS52tCG7JwEyikZRPjJdLbT5nCHwaBKqhS3XJZOFO8ltj8MTs4mIl2gWLehTJ+t5f0WUCwY0CDRIfWrxtiHQauomSeTa++Axv4Ilzm+V70LHbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UgBHciMsesk8EVidEr3TovpFYvgIYorh8weDONs/Q6I=;
 b=gebqHnMRbtp6F5/CzQQ50qZmGQx0K1n7DiWuJkyDuC6QfudvPYnogrD1WW3Wtyp36XkperUZonmxqpXL7i/e/nuBUdIm9nKsCezzPDSQHQfnkaO4R6nHBaSgIKSDJ4wb2r+HUdyz3mZQjVbO3AVoDg8ikTHoADWLImsBKDlCzOE=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CO1PR10MB4483.namprd10.prod.outlook.com (2603:10b6:303:98::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.46; Fri, 13 Oct
 2023 12:01:42 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::cf32:e9b3:e1e0:9641]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::cf32:e9b3:e1e0:9641%4]) with mapi id 15.20.6863.046; Fri, 13 Oct 2023
 12:01:42 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Tom Talpey <tom@talpey.com>
CC:     Chuck Lever <cel@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH v1] svcrdma: Drop connection after an RDMA Read error
Thread-Topic: [PATCH v1] svcrdma: Drop connection after an RDMA Read error
Thread-Index: AQHZ+56J1sr/avAOwk+1mhbyafE6vLBG372AgADDB4A=
Date:   Fri, 13 Oct 2023 12:01:42 +0000
Message-ID: <9A009CB8-DF99-467A-8AA2-30E3E450CC7F@oracle.com>
References: <169695862158.5083.6004887085023503434.stgit@oracle-102.nfsv4bat.org>
 <d2ecff1e-1404-4f9a-8550-b211ff5f7410@talpey.com>
In-Reply-To: <d2ecff1e-1404-4f9a-8550-b211ff5f7410@talpey.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.700.6)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|CO1PR10MB4483:EE_
x-ms-office365-filtering-correlation-id: 3af2fa3b-4570-4410-89f1-08dbcbe42a00
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FGbIwiV/Nuw2lASmFveu68fjLuKhZRkj2/eSZFQXmcnNQG6dUbDyL+QMIq9rNyOf71lKbUxg3IYtIiYNU6/+KcCe/XAm8OLDGQTmE0JsL0W2rzEjfJU0zBG0mszLPvMKwTZgkmoQgyz0YC1xK9hfLmkM4FMsv4kf+yMZlnZVnp50hag58N2JvhrK1VKLimeDosthJDu2Cw7EHMRJWWIwtbjGMumZXd+6Nfpa4eJiUTKBqvBv/uGBLKtaKeRYVFrxqvT7ZMWi+0fgoPtVsyI4Dhj8KXesrMxKegoYb6D004v6B+eqHfG7KoWvPeLdGL8ozx5ftspTF2m4nqfBmzI7NkvEfJ+PprflWIKsCZu9SHOwdFMsLdQ8loivIQTKHd0dFESDf3FAju4pjnaFa7KV2f0hdFCxBHUUaMaZG7jMaoHRsH6j6OZOrT9pUq+6TgvHPnUmUqgpi2GuOFkiWVhZkdjRtT0/PtJjqqNZN42QOtK1aLqmUryci0vBwIzeU6SX5tprEZHmi89TxLYJJTMCMSD8RlFPh8v7eNdSaT1VJY75MAltk6xeWz5HOj2aIzYlGo17ylbxLkK5eGE1Rd1HdGYX6trASSyFiPY1OB6mHSHo2VgtCyMWa4olHaAFtS9H8Z+b4IloSVg2UEBGLH/olQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(136003)(366004)(39860400002)(346002)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(6506007)(478600001)(6486002)(71200400001)(26005)(86362001)(2616005)(38100700002)(38070700005)(83380400001)(122000001)(36756003)(33656002)(6512007)(53546011)(91956017)(76116006)(41300700001)(316002)(66446008)(6916009)(66946007)(66556008)(66476007)(64756008)(54906003)(8936002)(8676002)(4326008)(5660300002)(2906002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?5pJCf+miua5kIPRltKDwFcgxpbks+lleDa0ym/x5EGmAmpJCO0UMeeeVWJl4?=
 =?us-ascii?Q?CY2XUj3t6SIFQbuUA57X7nh2lUoELrZPrO9VdBl76e5LBdgwZPHJTy9b68iu?=
 =?us-ascii?Q?aTpeffGgyO5mnowIDgk8NHpdAF2a8+1P8MErhpsnhEwGJA+Mt8U3RhA0NWKL?=
 =?us-ascii?Q?5dYwI+/PXiGbzTtLv21XonUVTPVTXO4ySwg8od3eB/FtWDIwZTFhWseicHKV?=
 =?us-ascii?Q?pSZlWHytnNtjcTqOwd0DmKuDC6TASdCi/3ZdmvpgBZ0QcAFqjYghTWIhowat?=
 =?us-ascii?Q?7d1ZWWgG4XJUzxIPYWlP1B9Cavw4Wmq3OQrSfG2nbnqVOmQCzpwH/pPmWGpg?=
 =?us-ascii?Q?b1xITDOd05weTZk3NU2YEVgrwFNEPYEC0ZKxj11k5YWZrBskEdHdyIe7EAXf?=
 =?us-ascii?Q?s1QhyGgLyznWOcURrEgDwT2ldvr6R9CISM+MoJAqnHJJU+ixqMuXdODX3LWU?=
 =?us-ascii?Q?dRuVIcLP3g4jo71l7I/V9D7Q0gWuj/I7xmfOcZ8FLTwYeEncDrAMdKKQNsaR?=
 =?us-ascii?Q?nJBL2B9IISYyjSySenBhaiQCcWyX6qctiRP8FpjQBv7fcLVRIB8X7WEv2PNC?=
 =?us-ascii?Q?Qj4K+e/BkLdEcl5JcUlX8JYVJeDY/GZPiibig9HIo6t3jGkkrgwh+rMB6Aoy?=
 =?us-ascii?Q?w7yT6/V6nVRXPylz+/o9MfNZto+o8YNdbb+onpvBNrEV/yVqfvQHz9Z4bBhN?=
 =?us-ascii?Q?O9dXde7PWd2FKd/jJDcYT3BgylsrKkuUNv69koOLc56uOkHbnzDw+rBlzbaw?=
 =?us-ascii?Q?WOcIZ05BfccYR707T8CZP+R+9vmZY0eV/fku0OObGDr1Lodx3FH1X0zoQjhI?=
 =?us-ascii?Q?u8TvHy4YkIQ/f37KQn3CyczOo7hTeR7tfeODPaCv0/3xzgBfgCK2U02Gqovd?=
 =?us-ascii?Q?KQ7aARtZ2j520g9UMFrUm+b4r6nK/DioupbZIo8jt4SG3vhjETeyjT+BhU03?=
 =?us-ascii?Q?RoEDCnL+fKVM7GbFF06mloVpIYxvlhqa12djXaF84E3mSAjB53+EYi3VUc9w?=
 =?us-ascii?Q?Cdl8uFv1tKq/BFrkZHqxWCPFX9KnXuW8ouCIsuQTtMynjJXxd5vAU1Elddor?=
 =?us-ascii?Q?1pFDNHj/sdxwzvf8JlG1DiSDHi5rk85lge8u36Xm1C1+33vZu5tznsQaMNcG?=
 =?us-ascii?Q?fSeX63FAdzj220hsu4JiqsbW5FDmz2lUyvGRlWy7CE5OVFEX2aTUf8So3XrO?=
 =?us-ascii?Q?N65UyEsZu3SET6GZeEPbJzU2+us7ntQRVhNMEaGr3sbz0qHbngwyIRNRMrhJ?=
 =?us-ascii?Q?3isGLiaQuWtMK0rObmrG3jafNM4KBm3WM0s+fXyeAyC5Lnki5oOlf7pJLz3h?=
 =?us-ascii?Q?2+4Xvs/M6jhV/qrpLNWhSRtQLEo5F38ZCXpdOUBOmH4VZdXU2lWCG9NySVHc?=
 =?us-ascii?Q?pyOsyGFqrWLIqzAcH2zApOmCw/NQw4u/fBiQkfcmWbWw973hCeCs8gbmerMi?=
 =?us-ascii?Q?NXblZGTUIPdGG5htUQ64n6lDOge1TMjljEtMsbzheSfaz3XVupMaubukc9jr?=
 =?us-ascii?Q?bYPF70rSEP715gxPNrKFhTlPB6+Z0GTssiwWGgrJnekbacJah9b7crLlt5+R?=
 =?us-ascii?Q?LmKUT6VKSKATgDFWRrRlBDINDzrXjO2/7XvwSe9VX2IhNF3kfMPGU2GV0waY?=
 =?us-ascii?Q?0Q=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <25358A5DF48FBC4EAFDF57F21CB0F2C1@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: v5mlB3Ks3WQX6rE9rCNycaYXAsRfg2XQcdBS6da1HE69fsT7qte0fAoe0g2qjIejct9uEQVBepUyubNEGTGBPW5AoY7qcF9cwoSaS8rOJwhXmc9RJAxkr4nKms5MoeOcfSpgO3uUA4apbpXF2ECeHe7N677zMMGkLSb5B2g/1zNIICiJRNXxlUeSyazYTsjpLfmNZUwgtm+gLtLheokuc9MwxHgx4n7JSKpbRT03oXt49NkgY+YKgnRe9QAd0pRIA/w3VOypP7ufk2498AarCq3SCIbqs1d7i3sUeqUQ5wMU3xPwbxysv6eQTC8ohaGx7Ay686VTU7mevWFanaqrFaNxCPlhOZWYeMNCel5wAz8E004DQ9U6JZ5i1Pwn/DdjNt44LzEHKQ7kDAOopANwBaaXXOAjT0X+xO5tH4ibOkMeP4gZ5dMmVZe370MQC2LL0oeBB+h4sjJLLGgUoGk5K4ldNa0FxlTnqVN6gfmWFJeLLqnqmyKq/YGl7WkWhrfAcIlVdM5RKe6BX5BgDdZq8xtH9Q2anZO2/9/1Nm45UgY9Fx/Rvxf/yOuWBjhyZjvbKbe0TsDNfz09Xhy60g6poYSrjH4tzI6lKTZ2hVgnw+3itU8D/t8NcGzB8oBuxMmzTiG1fueU+4g3lznO5xrpUlnKTiAG87yj+NXnrpk0/j5PsCsFn3QorxT9uaY4M2BWseEPrNyRz7azpRRlcK2rGLA2s5IC4+zV2kTkQRoAhJFwNU49VSocXFyx9Bd7ZM10Xr1Joxh66YcGzheLdHS+0c0P6XMQFV4LY4ya/wMSeTP2wZgWZQuQ03T7ot7PU4xwSaUJJ5JKiH1jZ1rBvF/Gyg==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3af2fa3b-4570-4410-89f1-08dbcbe42a00
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Oct 2023 12:01:42.0175
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2HAx9VqRs5ZEuhPl/TQ7H7FE9qfiMufxHzQBfziKXohJKSQGmSAdTfiS7r0uJRTleUMoQsPdR4vG+KzNuFY6sg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4483
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-13_03,2023-10-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 mlxscore=0
 spamscore=0 suspectscore=0 mlxlogscore=999 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310130099
X-Proofpoint-GUID: emzplgRcpabD_EtQU8DyESrdbXUWwi1r
X-Proofpoint-ORIG-GUID: emzplgRcpabD_EtQU8DyESrdbXUWwi1r
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Oct 12, 2023, at 8:23 PM, Tom Talpey <tom@talpey.com> wrote:
>=20
> On 10/10/2023 1:23 PM, Chuck Lever wrote:
>> From: Chuck Lever <chuck.lever@oracle.com>
>> When an RPC Call message cannot be pulled from the client, that
>> is a message loss, by definition. Close the connection to trigger
>> the client to resend.
>=20
> This looks correct, but it seems there are actually two changes here,
> it's initiating the close but it's also unconditionally returning
> -ENOTCONN. Other similar code paths do this so it's ok but the
> altered return value is a bit mysterious.

It's conventional for transport top level methods to return
-ENOTCONN if the connection is closing or closed.


> Reviewed-by: Tom Talpey <tom@talpey.com>

Thanks!


>> Cc: <stable@vger.kernel.org>
>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>> ---
>>  net/sunrpc/xprtrdma/svc_rdma_recvfrom.c |    3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>> diff --git a/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c b/net/sunrpc/xprtrd=
ma/svc_rdma_recvfrom.c
>> index 85c8bcaebb80..3b05f90a3e50 100644
>> --- a/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
>> +++ b/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
>> @@ -852,7 +852,8 @@ int svc_rdma_recvfrom(struct svc_rqst *rqstp)
>>   if (ret =3D=3D -EINVAL)
>>   svc_rdma_send_error(rdma_xprt, ctxt, ret);
>>   svc_rdma_recv_ctxt_put(rdma_xprt, ctxt);
>> - return ret;
>> + svc_xprt_deferred_close(xprt);
>> + return -ENOTCONN;
>>    out_backchannel:
>>   svc_rdma_handle_bc_reply(rqstp, ctxt);

--
Chuck Lever


