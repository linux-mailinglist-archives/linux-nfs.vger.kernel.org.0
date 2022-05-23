Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF664531D67
	for <lists+linux-nfs@lfdr.de>; Mon, 23 May 2022 23:09:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229450AbiEWVJx (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 23 May 2022 17:09:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiEWVJw (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 23 May 2022 17:09:52 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C9E57983F
        for <linux-nfs@vger.kernel.org>; Mon, 23 May 2022 14:09:51 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24NHgMdg016403;
        Mon, 23 May 2022 21:09:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=J3siC1+gUTUE7bDJ0r4+VD9vVOi1dQIdNRaZ8ebH9ho=;
 b=BRxXOYS/dStmovia4g4ddFGExdgzEa8U6TPnSLDeqGQqJeVcZ5r2Ed940S6ZC9GoJhzh
 mmPb6IzwP8F2SvhyyhIHRPexh3Eu6/R/qd4cmy4e678ll7J++rqtsW8PGrXwvUuMvjK+
 EJcDQH9Y06aWeUSm3lWvhp23ju9wU7zpClGjW77ngBY3bW/sgwiap6EmLss8DGqWJQOy
 a48JbkKI+9jkMv9Oxwu4yWkmjCsZKJed3V3YuSlLVR8y/KdL6hyrmwwmD1wXbnWhMBOD
 LLKgaA95tHdC0yw9PpSQnZN5pYwfhTSkSMgTFtH0BdOKB6my8IEdPjcXuUHiXCJOThR3 Tg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3g6qya4g6u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 23 May 2022 21:09:49 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24NKuW2X012004;
        Mon, 23 May 2022 21:09:48 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2042.outbound.protection.outlook.com [104.47.66.42])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3g6ph1yehe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 23 May 2022 21:09:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h1gNyQQ/klIKDrvNmTKvMi4DYPlUnMD1bPBTSByachmdWwsIEPpt2uHrwDLMde+xNIq6KusP9eNvXZTAjR+QAZZA58iaO7kIBGzag+UzgLVBBb9BHMVlwqHX6FAYUOWpdWNT5Rw24xfUc+TWwlhAoh8ymH+fEQ7RuUeU+mRhT+EpqdeQ63nAn1E75adXga6Q70EOxY9G6UZxXBBmWWHNVcVqKoTDKIBFLVNVMi4vg9UO9o05BHIiEoH/bS5uGwzoBls8/4ENm4aNKO8Wa1uigsJMNkgU1NEvEexp/5tQp0KhO7KCuu1UTi9BE2ERojDJy/8ZmWB9yyZasddAO4iS+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J3siC1+gUTUE7bDJ0r4+VD9vVOi1dQIdNRaZ8ebH9ho=;
 b=iGmTxzTge/nUkr8lfPlDSgHr4tx3XsDneEwUsuqHUMVp5ChwR6ahO/nvXdnwQsvqWxmYxuMyx2Xj3QLdscoBmQZda/ZMqgJ3fXfJlweIhEfIliFgyT+IV1ZoCwR1V+24TxMfykIc1tyTsfo/eI/X5PJ12X2LdPein7RpZXDq7ZV8ldd8zG2S4f7LUTWPbxFWhe91kl9JzyfCG2pdaVek2/vN51LCk+CgLJ2VpDzTMHHsm/SC8GMtK6Lei5yIZhsg54K72hZMVLfSMHmX3QaovnJt3bswd1VeZXitw4qJmQRpmr3wett7nayQa/axSuikY5Xq53D0yt8lydZPOclaVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J3siC1+gUTUE7bDJ0r4+VD9vVOi1dQIdNRaZ8ebH9ho=;
 b=vixUEES7xA646T7c7rOgEx3w2A/ZAM3cg29CKJNZ6tLIdRAQamJjZyYCkpmIbEX4pjaTdd6eHqll/osHEZNZdYKw/c3885GCpOSTtMaXc+b91u4oitpHCUKzaZPUHwkk3pPG8JFWEQDPEbQtZ3SrlYSLlavT2I+8izvYv0Jmpdo=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DM5PR1001MB2362.namprd10.prod.outlook.com (2603:10b6:4:32::39) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.16; Mon, 23 May
 2022 21:09:46 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ed81:8458:5414:f59f]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ed81:8458:5414:f59f%9]) with mapi id 15.20.5273.023; Mon, 23 May 2022
 21:09:46 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Dai Ngo <dai.ngo@oracle.com>
CC:     Bruce Fields <bfields@fieldses.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 1/1] Add pynfs4.0 release lockowner test RLOWN2
Thread-Topic: [PATCH 1/1] Add pynfs4.0 release lockowner test RLOWN2
Thread-Index: AQHYbt1B7qnH8pZxnU6G9O3o9v4isq0s9SCA
Date:   Mon, 23 May 2022 21:09:46 +0000
Message-ID: <26E7B9B8-6401-4053-9865-C1DCF68DD921@oracle.com>
References: <1653334950-8762-1-git-send-email-dai.ngo@oracle.com>
In-Reply-To: <1653334950-8762-1-git-send-email-dai.ngo@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fb73e762-895b-48a6-2d5a-08da3d0090ac
x-ms-traffictypediagnostic: DM5PR1001MB2362:EE_
x-microsoft-antispam-prvs: <DM5PR1001MB236245BE9F5975D76C67689293D49@DM5PR1001MB2362.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ggH6z0sEYIALLXN1xLrLdPvdrSq2ZxswH50jR+pdwrYf12RzfZltT2uEBMYNYn6nX+LUWRAjY2W48gttZ2qOTmz9ofXaHaMIOZPdzYMwBeY2lC7EuakNkESE7OO9XVx2l77GoYaDHeUvaOlSUswS6kBDblUUYOFdD8Yv881nIWmKJ+5vLbY6//S8x6ODUGboVmkCb0Oi3i7pbVro/p6e1G8TzK8e33I5OyZQnUmXqt3VjszhOckRdC2LfEU/MwtgUy0AaJuzNUkDPSuYS05oB1SsvAHiNGVw9ueqp/1yZgC5NKM2zurTOmVW+LdmYLVxizkwX5aFtbhohAE2srIWQIQOIPdd4w+3hLwNaktb9yaq79+8W68uyuFqurwo7bZWj9CCbAVoJsOKnmEAVIsyZ4dnUtdWD+e4V5QgoLO587+wSJxqOg5CFHxH2e11UAKPSmVgc9PEn2tDODPa9YEAdj5wU7DFXfZX10s56vMdMZkY+08rOLjPv4zZTodKk8rbarSm/DrsZ/hjQSW2Nbgu/UDdGO8aeml4uYEUZrFzeVIWckRQwSdkBCSJZAkYDi+nrjTP4zaO2ndXGHN2Hh6j1dA33J5AMiQuHK7JI+7B1UEGIOV0VbOvbMFhDTkpVu40PVPtAURO2S+w4426pSPCO7N+nPH58u3cEpJ+jIZd/xmwR2xlxn1VuxYPYV56ZqxLOYN9srMcC5mQglmA1mWVoQQttiPtmaNppuCFc2aaL58FR2c2whU0+I/CcYzgR76v
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2906002)(316002)(36756003)(53546011)(122000001)(86362001)(6506007)(6512007)(26005)(38100700002)(38070700005)(66476007)(76116006)(37006003)(54906003)(91956017)(6636002)(6486002)(5660300002)(66556008)(66946007)(8676002)(186003)(4326008)(2616005)(83380400001)(66446008)(6862004)(33656002)(71200400001)(508600001)(64756008)(8936002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?aokZFRyV0zLtnM687ccZOzyJFJums/q0hSeKFj2kZvbyfzoDAEyBiiw3uomp?=
 =?us-ascii?Q?awDHt3s7Q9jBS3QVVacRir40tHuzUZmUgn2i8Xe/uta+0rdsTqj/MdglLUh2?=
 =?us-ascii?Q?owa65MPsTbmHjxKqq/FTKycMAXlZ3XfzN4Kka0qcSlnB4l36sfKdYCWv/47U?=
 =?us-ascii?Q?/mvI7igHVp2hLR6PYlQMeVlX0PYHzl245zktOTS8MZ4w/OgnpR8Df7aqLHJF?=
 =?us-ascii?Q?DWs4EcU1khfBKbJhT9JP+glUiHbSD2CJCtsF/QLtU/qm0Q4AP+vt8BbNXrs3?=
 =?us-ascii?Q?Slg2L8K4r/ln/tbgvRmh2a/lBVG39iXevQrjgAqNzREhteyxnbCa/TyjZHYB?=
 =?us-ascii?Q?3oJ8FB2ZBHevFPsJGMyKojrwQcBhHgJ3RUbDBCOYCBqaC7n957yr8hpMUHmK?=
 =?us-ascii?Q?FkhXtOhu96DfQn0CtslpSrg/EBazUgWDxebmxzMexXKQNsoETtMlJZrX6LQJ?=
 =?us-ascii?Q?OYCKsx6+fMnQu+flNa858BBdee+uQlm1G43fCR4D5ykl50pSscj20KYXQZrd?=
 =?us-ascii?Q?y009gSR1cj2FZJOb4s+rFAFJnwuFVO3Pneye9/cpiXXfzR9wew8GtqBwaSB+?=
 =?us-ascii?Q?XdAT5qniNKzACw/Wh/XbzT8b1+8oo45a3U9VAI8roHblwpjOnczS+T5tI0fp?=
 =?us-ascii?Q?U7Lwe/RuvyAcSjD1dnt2EsR5pO8BObPZBQURx85Sn1pk1O8Tavw/xUvWXgWk?=
 =?us-ascii?Q?LszbQUe0E+lI0U1BeK5DwLIEEhAXf9rKY2U+8jCLNVZSMmDnppgtMobDEVJe?=
 =?us-ascii?Q?A8fX/DqycRhktGL/mJwfz06JFFnVkzTPF/f7xmetbhW/Ik4pCiI50OoySXA6?=
 =?us-ascii?Q?4jI8ejh0TsPLy/kWTqKbZq0eh5c+k8RUb/QdpDlQJmJZncirXMaGEOrgLX08?=
 =?us-ascii?Q?X9B72Ko6UfVwWS4Mz414e/niKrDdIlr9sS65b0/+LDMcPPfC1ZvDeHCq+OUm?=
 =?us-ascii?Q?xfTmlnmciCLcObu3+YU+U7GfIMx1eEPjfvElVaCHvSiAJ1eBq5CA23EKozDr?=
 =?us-ascii?Q?IRJ5bq7c3Fuvd77of0e7EtW+4HBPECKlknrgvFOEZDiysbuclrQBvbG92Ejv?=
 =?us-ascii?Q?fMvIP++9nrIbdOGFFwL4RgPUVE9Uose2TQ9WdvaoTR+6avfzppDTHS6Cnt4r?=
 =?us-ascii?Q?Jy6JqJaC97KaAGev5Qg+f/xxnjdJynV8ui4qWIctdbadWB9vFymkhSz2g0Qn?=
 =?us-ascii?Q?MhEDArO7j1oj6C019Jp+ZJBKmWmzzy3NSnL8Wn2zsz8BmzKY7UuXIOUsjVuT?=
 =?us-ascii?Q?+RXdmHh07SPUQCxJ26FNChack7yjL4GbHAAJ+UnTDcmxgq2WJ3X+2xI+9fA2?=
 =?us-ascii?Q?4mx+7jHRuannY0XKANlhmAVv9stiFcikas3x3TkBAiNBcrRdoUc/YbVuBE6K?=
 =?us-ascii?Q?KqCBN5+m9r5NNAK8eFS5KZZYfDskteGO3OkmSC2pRggp3NZ8BpPebUVuobpw?=
 =?us-ascii?Q?wEJ7BqRoOSALcmutdaMBYejRMv7yw1eox0ctPEHAp3JZmdtqFTtCsrHarRg5?=
 =?us-ascii?Q?zHHF5wemUaorEnMEzDWaDYjCZQM2oyEfDdxtPf4uMdofNoGYyg/gIUSPugfB?=
 =?us-ascii?Q?q9P+Ht1372HrkyVBgpt8xB2oPE2LyPPlqUbbaD1bpVX1AEAqs0TXendijVNN?=
 =?us-ascii?Q?QbtbcizRs/N/N4RHNljG/Tl6G+Q7N+L3iPH+nhliqmY51mG9bDIVj9xDplyr?=
 =?us-ascii?Q?Kc61mHu6OwieaChld3lsLIpTomuLa2DLkjyv1ibJYS52Gpr1YHtV0Sa3DMli?=
 =?us-ascii?Q?D8QcOkbfU4+swRwwlpUCw9jt+WkuqQA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <8D546A5F88A7D54BBB9A36F1854398C8@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb73e762-895b-48a6-2d5a-08da3d0090ac
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 May 2022 21:09:46.2218
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tshSsVzpGLCpb6xDmzzH3r01XPUj5r7MD8thZseY+aTYMBNx6+flzlERwujiF5SPOtAWfYH3qaYNQlGC8aNlYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1001MB2362
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.874
 definitions=2022-05-23_09:2022-05-23,2022-05-23 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 mlxscore=0
 phishscore=0 mlxlogscore=999 adultscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2205230110
X-Proofpoint-GUID: g9uFDX83kIHBp7H7HwGsacm2gLXOC10d
X-Proofpoint-ORIG-GUID: g9uFDX83kIHBp7H7HwGsacm2gLXOC10d
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On May 23, 2022, at 3:42 PM, Dai Ngo <dai.ngo@oracle.com> wrote:
>=20
> From: root <root@nfsvme14.us.oracle.com>
>=20
> Add RLOWN2, similar to RLOWN1 but remove the file before release
> lockowner. This test is to exercise to code path causing problem
> of being blocked in nfsd_file_put while holding the cl_client lock.
>=20
> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
> ---
> nfs4.0/servertests/st_releaselockowner.py | 25 +++++++++++++++++++++++++
> 1 file changed, 25 insertions(+)
>=20
> diff --git a/nfs4.0/servertests/st_releaselockowner.py b/nfs4.0/servertes=
ts/st_releaselockowner.py
> index ccd10ff..50cef88 100644
> --- a/nfs4.0/servertests/st_releaselockowner.py
> +++ b/nfs4.0/servertests/st_releaselockowner.py
> @@ -24,3 +24,28 @@ def testFile(t, env):
>     owner =3D lock_owner4(c.clientid, b"lockowner_RLOWN1")
>     res =3D c.compound([op.release_lockowner(owner)])
>     check(res)
> +
> +def testFile2(t, env):
> +    """RELEASE_LOCKOWNER 2 - same as basic test but remove
> +    file before release lockowner.
> +
> +    FLAGS: releaselockowner all
> +    DEPEND:
> +    CODE: RLOWN2
> +    """
> +    c =3D env.c1
> +    c.init_connection()
> +    fh, stateid =3D c.create_confirm(t.word())
> +    res =3D c.lock_file(t.word(), fh, stateid, lockowner=3Db"lockowner_R=
LOWN1")

Should probably be b"lockowner_RLOWN2"


> +    check(res)
> +    res =3D c.unlock_file(1, fh, res.lockid)
> +    check(res)
> +
> +    ops =3D c.use_obj(c.homedir) + [op.remove(t.word())]
> +    res =3D c.compound(ops)
> +    check(res)
> +
> +    # Release lockowner
> +    owner =3D lock_owner4(c.clientid, b"lockowner_RLOWN1")

Ditto.


> +    res =3D c.compound([op.release_lockowner(owner)])
> +    check(res)
> --=20
> 1.8.3.1
>=20

--
Chuck Lever



