Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D70545915CF
	for <lists+linux-nfs@lfdr.de>; Fri, 12 Aug 2022 21:12:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238027AbiHLTMt (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 12 Aug 2022 15:12:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238120AbiHLTMs (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 12 Aug 2022 15:12:48 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C14BA6C1C
        for <linux-nfs@vger.kernel.org>; Fri, 12 Aug 2022 12:12:47 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27CIIkXI022731;
        Fri, 12 Aug 2022 19:12:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=XCQDR+FVB7o4H0ebRJ/DS3SSV7oBbKd1T/u+q5HqzRA=;
 b=UYNbFqnL24iyngOrjmT6PthliewCeKQQR2NQREk+Ck5dH7SoFrVOAgC6E2sbLUQ4KoXz
 toQhOciBWcxR02FQ2+UMJ5CgxUUhSlvvGO1PBijwV+EciCbL3nlrabh48zey/bXSUoXq
 sCNMNcEThvUURz0ZUVHfb+6wMwGZ1ZoBsbxa2Dx/LDuE2aTHXugmdxxpyyfGNL2kBqBm
 K8U+M0rJqpun7q54ctl0aYZy5KazIL2+cg7ZUIBw96dj5tJFEZ3KfRxJz3lJqV4ntawW
 YJhmwGRgqYncuvZxspDB29iZG4GPF48hatR3ct4MNx3L5v3crnOrmJ/Ea1Kc4nQ8jH7l jg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3huwqbrcv6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Aug 2022 19:12:45 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27CI1CIb040773;
        Fri, 12 Aug 2022 19:12:44 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2103.outbound.protection.outlook.com [104.47.70.103])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3huwqj3y08-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Aug 2022 19:12:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j5pTm6hw38ECMCb6i7XJ56SzncamKRAAX6c4CXdgeqJLv2WSyOOmZBcprUSFOr7mUnIu2R9wRt4ZJIr3cqThyMCi/hxTpmjcoeEHsSAHb6r8YTsLlFXEvoxulR+ue3wGSH6Z/2M2YMLKpct2sxaCZxjSKu2h051EPCDHs9tlxURS2oeShwVfdb4I3OYNBSlFYIrryj0pdHJAv60tYlHuQbtaqftY/awpBHQPJyWK6IHIngvUMN3W6+GeMxaJe1YH2/dIprZqLvirawkUxL+VJMMptj9/8jFpidDGC3ACuF1pYxm/Qe/5Me6J4rQYLNhNaLoHdp/kxs3ZWexlyr3znw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XCQDR+FVB7o4H0ebRJ/DS3SSV7oBbKd1T/u+q5HqzRA=;
 b=G+FwR2MR09t5Xwe8Hq0kSYH/YQaMe0yCsPViqYkfQhBdk5AyhPlTtS6QT9a7m9Ieum8IOKs36NpuFngvFkwOZUxfe9HeYkKAQ9BBEGkSZDNA+xgfKHE3oR7h7Yn0WkNuj+11wvCM8E4k6obpwiVciulE2QA1fyRkSuRO02f4KzXOCVW3rsFQM/+sDlQnK4USws7w4GZfKzGpPybS/2mIPmXFK7cZRLZyJBSxEjWlMrroXj0IHQ6BzlSib01Oyz2E2mnh+5j/2mquqzkott8z1rMtWFuvQEIZJUrH9VfKlGCH3ea/w8QyIrt3HUWAet9uYpBCmHbtHdWmMxvK3QZQVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XCQDR+FVB7o4H0ebRJ/DS3SSV7oBbKd1T/u+q5HqzRA=;
 b=0M1o0GYYTzxk5YMgmYRQHsrEueu7mdV4B9dVCGqRlLEPFfWAhrGIgL9ZyHfKdhducYEOfkk+vKelL6Lj9aaBEg7vzFTbkSO4Ui+SuRcB2lNIP9qn6vrSM9VS8kGOxpprpmhjfddgahKT0w/f00+6o4LuBRMGmsZJYpog/5uhaKs=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BN6PR1001MB2099.namprd10.prod.outlook.com (2603:10b6:405:2c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.18; Fri, 12 Aug
 2022 19:12:42 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::91ca:dc5:909b:4dd9]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::91ca:dc5:909b:4dd9%9]) with mapi id 15.20.5525.011; Fri, 12 Aug 2022
 19:12:42 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Bruce Fields <bfields@fieldses.org>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] DELEG5: Create test file with mode o666
Thread-Topic: [PATCH] DELEG5: Create test file with mode o666
Thread-Index: AQHYrlUAQjpvTECZoE+6Zj4N/l2ynq2rolKA
Date:   Fri, 12 Aug 2022 19:12:42 +0000
Message-ID: <F2DE58E9-E804-4F5E-9A9D-1EBEEAC9ECE5@oracle.com>
References: <166031330113.3080139.1273532571655274363.stgit@morisot.1015granger.net>
In-Reply-To: <166031330113.3080139.1273532571655274363.stgit@morisot.1015granger.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 37002667-8435-4ff8-d16a-08da7c96a15e
x-ms-traffictypediagnostic: BN6PR1001MB2099:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QgB65Jjy/mbm3YkSDW7lA9Ln1kAjF+4amrQPoPOiAW3zqZ1gVOhaYsG2VFvSX04QecfvQxaX6kTeIjWYycbEEqv3Dw0P01w4IDjIYbX1U2oqAGW4gJiDKmeVac1032jaOm9t7/94pRtAQGCYIzL9kL5K2lvOOXnZea7IqiiEEmkp2yhu8YY6lftuLpobVnkaIh0W8IraRiUrOLp/4uOxm56ptzVTztMt2Ps83r6qwldAUy350VC0629M4FYqFedGh6tlZa1iOEUzpkvapQBn3XrxXciaEFNOolDeqVABDBATYYAS52DhUHhdTjAimw8OWWzcmyXQNGPni/LJerRUqeyabqWlv+czsAySyCMYD8OBvxY0raV1S9xfE4tMFUnaduQEXx3aH1AP2HeVYl1d019FjrYM10Z2KnzX6FtKDFN81w/vVoKDJ3ITQSpZDj6O2j8RoMFpC2KUjYNIzFYYWYAkdpVjgGwHNta43cdIykOqQlowHXL3VMKyZfld72z3bPOzTfXsQnoZfmHbFo8YbBhGktMjrWQEl03tcnYSuUzMElZNWCrgFmtt0yTk0Ooy0L8rUKubXnNgqVd7m034TWS7vECNeRTc3eFvkDkDe9GcPv+aTN0OkAqUD8uOOngapl1b4lEu+q/4aw8LhHpJ2kied0q+/xqccr1HV6d6zCXX7SFEG41sDFEfgt7lCCyir8AFDHLpMjjz9N6kGZicnvWVoxk/KngCzpTH6VsB7XDpbUdmFG2oyz7787125q8jF5e2Jcrj0swYABhXQvr5GKYucJtJqH3+lpbF3Hvzqw3ZzP8+ujeyORqBd2220pTsPa2RdpU+zPLoGegG8ZgcEw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(346002)(366004)(136003)(39860400002)(396003)(53546011)(41300700001)(6506007)(66556008)(122000001)(5660300002)(33656002)(36756003)(2906002)(26005)(6512007)(8936002)(38100700002)(71200400001)(66946007)(66446008)(8676002)(478600001)(76116006)(91956017)(38070700005)(4326008)(66476007)(6916009)(316002)(6486002)(186003)(2616005)(83380400001)(64756008)(86362001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?x0q20z4Edy4j1o+7RStfcKkMAlESTlj4yZyt0FSxaV2sz7S/DDH6DmrXADmD?=
 =?us-ascii?Q?0BKJhLYt9DhSQoz/jAMwVvlvmT8I1ZgpAVGsPj+/86Ez8CvzIK8d3d5l4Krg?=
 =?us-ascii?Q?Z1FI6iZ9cgNDA4NmjIBjx/4veMcS4ni2TTNdH2VieIqH2CPK8hHbP5Pkw78I?=
 =?us-ascii?Q?nXw3BvZzLaUcTzYLMwf/0rE/hW0++jMZOLcFcdXyCxvnuez6ggIn+ohaN0dM?=
 =?us-ascii?Q?HkXOQTvRtVbugAF9XwBEpj52MDHpZG1VT/JKQOO2Q3vVlfr/7luMH0HvZ+ps?=
 =?us-ascii?Q?09WNbxKdyAGuMASEh2AigxevoRHGHyuKOMmIYpv8aIN3GLw6X9h31Z2BmJcG?=
 =?us-ascii?Q?LB4k2Tin2MoMbneIffldWM/cnrND178nyzoQKhWtTyJzLV/YB8i81CcXHizg?=
 =?us-ascii?Q?B8aaK9pT2apamTseZHHKP2vfeqq2dnuUjPiB7OGdJprl1I7UEw1Izj+wUgQW?=
 =?us-ascii?Q?aqW/zYy7CvU44lafPtnrVesc95Gb2uDFVahhUc9eb/lROrNT9Tnxy7sZKfM/?=
 =?us-ascii?Q?tfs5wkSZGVQXy1rGGICYixT/w+3d+E7UgOHPxBn/lTiueTo6ZwBSCRdWwwjn?=
 =?us-ascii?Q?MzAUu8ttXX7KvJKj7Q+BVkLbQWlQ92+VoOpI9L206G/UvS0SL/3WQMxYNsOS?=
 =?us-ascii?Q?NzkQ3a5fwkVaMVRsFjHzzKbAbsb5ov0toDMB8U9jawF4k8gBjZHCasJxNcY2?=
 =?us-ascii?Q?lwFakPsaWIllLMpid4gNCL5DsgPLIBLJma1RUEtN/8PszmQvSRB90U7Ow8l+?=
 =?us-ascii?Q?VEmg/MnfeNsmrYDcqCHENNZoNbCTYuDocTr6NAK6mBdfw6VO04k2EGqj1xIR?=
 =?us-ascii?Q?rK7jZDco3vMmFBikl9x9LoBxDTmOu+RY3Z5uerNg+/qWgfYfHF66lv46x8bR?=
 =?us-ascii?Q?eNeZieHweMNUR1s4xmIr9o0RXgisvZe9tvm3RF32iL36ItvKB56/91YMO1Fp?=
 =?us-ascii?Q?5VKKEe1XMqNDPL36hXE0u5S47ZVhP0qblxcuchAgHQ60r5AmTVGxAldD13rD?=
 =?us-ascii?Q?yq+BU7GlCJYZDoutm48lyel5/Ti/pCwYgHXi3Y94eunD/jhx2RtaswKy9QiA?=
 =?us-ascii?Q?KNVcl3nBMDQoxivClBZOeMSyqh70IHjJdla1zQaT45C/7wfSayesr2WG8/po?=
 =?us-ascii?Q?60hwlL8gZ/t1HerH1OBl4F/aDt3L/MFR3DfzbGgxhOYqpBbwWJwIwrqUX1xp?=
 =?us-ascii?Q?wGt7lMizv5PjXBD+DHwO9v3075mKh2bZD7tX3q/0MjOdlcEOnzF83hvLY9RD?=
 =?us-ascii?Q?rj5Q5coJbArRAoWOyfHBTVUAENePfbIPg3O6TsabvxGbORxthkpOccwCa7gW?=
 =?us-ascii?Q?uzLMD5M3lva0dYL1mGIDJLnTTxozITI3cp56J7tqc8owPJiK1shcC5KYSPwT?=
 =?us-ascii?Q?/6l/m+NynkZ6ZqpIwWE+sHlf6WaEu/sNYPwP8tH/Xii7yz88828FDDnkUCJl?=
 =?us-ascii?Q?cUTpuGMiLIbVYvrbPuWN7Ek0YztBJ8NbUN2UFZMq5+pE8KsSnUZhqTKCFH1F?=
 =?us-ascii?Q?WrVPDwEkW8Doyc9Tcqolkz1xlaSdERRI66rK8/XoTDm3zL2rD/QI3F8vDCXj?=
 =?us-ascii?Q?puzX3Cdunw5eO8cEH68hwsG0oCd3W3TjDmrDSK346lBbGvDyg57UYEMv6dN8?=
 =?us-ascii?Q?YA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <BFE0618E84C53B4CB60003F49F962A4F@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37002667-8435-4ff8-d16a-08da7c96a15e
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Aug 2022 19:12:42.0475
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GGLm8VnLuQUe7XIBmLYcuq0QjNO09ySN7a4V82lYxur2VeZ2WuRnWTr1zAYsNpp2BI/egHin2Yr2Rdm1feka0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1001MB2099
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-12_10,2022-08-11_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 adultscore=0
 mlxlogscore=999 mlxscore=0 bulkscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2208120051
X-Proofpoint-GUID: UAbrPrQA8K1nf4vMDNHnLF7g838IcEBG
X-Proofpoint-ORIG-GUID: UAbrPrQA8K1nf4vMDNHnLF7g838IcEBG
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Aug 12, 2022, at 10:08 AM, Chuck Lever <chuck.lever@oracle.com> wrote:
>=20
> DELEG5   st_delegation.testManyReaddeleg                          : FAILU=
RE
>           Open which causes recall should return NFS4_OK or
>           NFS4ERR_DELAY, instead got NFS4ERR_ACCESS
> ******* CB_Recall (id=3D14)********
> **************************************************
> Command line asked for 1 of 678 tests
> Of those: 0 Skipped, 1 Failed, 0 Warned, 0 Passed
>=20
> WARNING: could not clean testdir due to:
> Making sure b'DELEG5-1' is writable: operation OP_SETATTR should return N=
FS4_OK, instead got NFS4ERR_DELAY
>=20
> DELEG5 attempts an OPEN with ACCESS_WRITE to force the recall of
> a bunch of delegations. The OPEN that requests ACCESS_WRITE fails,
> however, because the test file was created as 0,0 with mode o644.

This paragraph could be more clear:

DELEG5 creates the test file as UID 0 with mode rw-r--r--

The later OPEN for Write (to trigger delegation recall) is sent as UID 1.
This OPEN fails because mode rw-r--r-- does not permit UID 1 to open a file
owned by UID 0 for write.


> A perhaps more preferable long-term fix would be to follow the
> advice of the nearby comment and convert DELEG5 to use _get_deleg(),
> but I'm not expert enough to tackle that yet.

_get_deleg() creates its test file as UID0 with mode rw-rw-rw-,
thus side-stepping the subsequent permission conflict. My proposed
fix simply copies that behavior to DELEG5.


> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
> nfs4.0/servertests/st_delegation.py |    3 ++-
> 1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/nfs4.0/servertests/st_delegation.py b/nfs4.0/servertests/st_=
delegation.py
> index 9c98ec0e0fb3..ba49cf9f09db 100644
> --- a/nfs4.0/servertests/st_delegation.py
> +++ b/nfs4.0/servertests/st_delegation.py
> @@ -244,7 +244,8 @@ def testManyReaddeleg(t, env, funct=3D_recall, respon=
se=3DNFS4_OK):
>     c.init_connection(b'pynfs%i_%s' % (os.getpid(), t.word()), cb_ident=
=3D0)
>     cbids =3D []
>     fh, stateid =3D c.create_confirm(t.word(), access=3DOPEN4_SHARE_ACCES=
S_READ,
> -                                   deny=3DOPEN4_SHARE_DENY_NONE)
> +                                   deny=3DOPEN4_SHARE_DENY_NONE,
> +                                   attrs=3D{FATTR4_MODE: 0o666})
>     for i in range(count):
>         c.init_connection(b'pynfs%i_%s_%i' % (os.getpid(), t.word(), i), =
cb_ident=3D0)
>         fh, stateid =3D c.open_confirm(t.word(), access=3DOPEN4_SHARE_ACC=
ESS_READ,
>=20
>=20

--
Chuck Lever



