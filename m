Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51E29625DE8
	for <lists+linux-nfs@lfdr.de>; Fri, 11 Nov 2022 16:09:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234998AbiKKPJB (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 11 Nov 2022 10:09:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234927AbiKKPIF (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 11 Nov 2022 10:08:05 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F05671F22;
        Fri, 11 Nov 2022 07:06:52 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2ABF4Ptm024048;
        Fri, 11 Nov 2022 15:06:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=2O4rxJha/+cK68BKnl4wNqcWJ0kG3JzspmrGCmR0nlI=;
 b=i0H0o5986wu+o86LC+dMP6N6opfNC/7am+yqKBR8T+D7cPLQTSkhhYA7akSVeHLn6AvX
 AYPeVfvWfOgMccOfkYBV5Xd2fQ2jp101X1EGq/MGG3IeoDZKyGatiyhvqpEldE7ziQp/
 CJleEkmbYnLn0rWV5LSldIgXGKzIyWm99Xbjpy6zO3uqzfI2bI+nQUpeTZyZ3sLyLTP5
 wD91zRvGZCESH8jCd+6EjWb3FIR7qIkNiElPdQRXFN80H+MTn4Kjoxrg+uRKXa/2c+8t
 fsLcob4LPrFOh0LC8VXP2iXYbNjy3TndNgBOXOgRAIDSym+p/waoJhw5erYoSDnJxJ9X VA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ksre481w0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 11 Nov 2022 15:06:43 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2ABDWgKK021549;
        Fri, 11 Nov 2022 15:06:26 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2103.outbound.protection.outlook.com [104.47.55.103])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3kpcq6h37e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 11 Nov 2022 15:06:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iwIPx26dR3ashVQTYvyo8X7oxGvL3QKGjm4wQFSGHwG9MA6Byy9Cl8HmYfAYbUd/EDZuDEn4V8K7k+XTO8lXHYGelO+E7BfuTJy85a3tf/gDxyqn+Tic2WDhN5NmgxT6kjiouyvnM5qOrTyOnJB/WRUqXmfgjyPdlN9lEG0BGtadbhOchXXpFovDH8T7REhAtiWrLhHF2iJTdTBc56AKxOzEEyZ7LZHUo97AHRFjlUb9LpYEEPiVfd7eUChhEcpooyrhXlicOv12c/ZTPLBgl76MFRVgKm85LnYh0+OUmeyUmCoztvGOPuG7NNsH1aFU63gZDJALuuQilUKbvCLaHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2O4rxJha/+cK68BKnl4wNqcWJ0kG3JzspmrGCmR0nlI=;
 b=EVsWhCTYfeQn2YpwraXgucZWOo6jIypIaPl9BxtZJb7sdYuVpCgURtdQ7yzhuNEL5A4mwzpQ2ZKJh9QRM14QUNQNtWK8I39gcCd5PlgHad9kTWAvDAlKq7BLr+N5Ss5/NAWqTwSExtuUk3fS3/sgiklF06CmrqAM3wIoAoaNdPh7LkvEoQZQDnLLCRMNK0XPYp138bUlFqX7jun/jzIw8uAet63XoHT/D/TklROiV3dtTYTlk4dxX8ZX+5Cx6niDE1qTNGu5uPxsUbmv0mgig6jjmWav3pkPgYsJeQDiCLuw2vWdw1GVqvqBW+/Mzn4VzRsCufGQWiCHuE51pakToQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2O4rxJha/+cK68BKnl4wNqcWJ0kG3JzspmrGCmR0nlI=;
 b=FyeI+UT8CU3iwsXhZn7u2H/5S3YaN/Rfg544YYyIvFYB3doMgtE3WQ4huPwhxLCvso/jOSQsVrViXpsx36BMb6qAPuvKpB/SYyhq2mjZLtIrcAx0rHqAhFsk286fawISY1+70uDfJ0g7C3P+m8gGoV9IpzxDpsVP3ptJ7mU4NVM=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH8PR10MB6388.namprd10.prod.outlook.com (2603:10b6:510:1c3::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.27; Fri, 11 Nov
 2022 15:06:24 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::b500:ee42:3ca6:8a9e]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::b500:ee42:3ca6:8a9e%6]) with mapi id 15.20.5813.013; Fri, 11 Nov 2022
 15:06:24 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Xiu Jianfeng <xiujianfeng@huawei.com>
CC:     Jeff Layton <jlayton@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -next] NFSD: Use struct_size() helpler in alloc_session()
Thread-Topic: [PATCH -next] NFSD: Use struct_size() helpler in alloc_session()
Thread-Index: AQHY9a8JP32PwLOsZk2WkZIAFVR+oq450vSA
Date:   Fri, 11 Nov 2022 15:06:23 +0000
Message-ID: <0B29DB16-0E08-4936-9847-09D156933CD7@oracle.com>
References: <20221111091835.151942-1-xiujianfeng@huawei.com>
In-Reply-To: <20221111091835.151942-1-xiujianfeng@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|PH8PR10MB6388:EE_
x-ms-office365-filtering-correlation-id: 32faeb17-1514-4f82-e9c7-08dac3f64c91
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OKyryKfQg6ZvKPJ4nrbpFW9Hryu0eJHU5FXcVN7p9RwN0YaAiib/PLO4l/hXFT54s5qgg7MxPBqAYFQplQLWxs4c8wkfeQaAI0jwOA1ivtTAyfOAsc4tFIIMxwSIi6iqq6QRCHflWIq6jq8kMiaMpyLTMNcNC1nlt4kUpMazWJxwIfGmsUMvdsndTRuQXjxl5zmHm/vXScfO/8QBC2l/y9/RQ4ZSmT/Lf3dnwqlYYTPj5NVpxX25htvyk9RdCgIUoWt9/ZLDtdJZqZJuAZBYq3vPqopPdtq2k9gduEiXee8VT0R+KLYz52ZxIU88khBDVmd6ip6U2iX4k8xv/78fMqwRhCYfj2fSJOdhm5qoXDVLfRCA+NFpKWY/AJXZTtQgY1uQwO3BjIgx5ZBXzRkmBpXnCoZJnM23QFSZ3onX+7yFqLGelwcwgd3n5jAojS6Yn0g5uCRd3Vh/y8wDcJRbmWnhTWSYDMCIfWFroTgIH/5LLy5QdM9LSDIz7ojcDIijwF8AeZey+/gxYn57hI7vFTiGMz0TlWgEtj5cHXFH2nGreNZzHrIAItErnQYtXfUE4ae3+g8rQv/6W05C6dF4PCUbk3e6PcfSlhiXcI+boPx0qZKy/FzE6xYaFBeAcgV20WCwvk1BC9lURRdF2UhVeAy9aZy3S67yFG7VFemYAGxLR0MbGAGcV+oIOhvD/T35lEcbfYSZCUzlzpcfICKPPBwYyv3A8GyoadHS7V+2GCrKWlya2COfvfrylEWP63OGtPK/K0IYX1+ofPBW5CSAJLNLaSil9kjYWMfgVWVrUhw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(366004)(376002)(136003)(39860400002)(346002)(451199015)(2616005)(36756003)(86362001)(186003)(83380400001)(6486002)(71200400001)(76116006)(66946007)(66556008)(66476007)(66446008)(64756008)(5660300002)(38070700005)(8936002)(2906002)(478600001)(33656002)(41300700001)(26005)(38100700002)(6916009)(6506007)(8676002)(6512007)(91956017)(316002)(4326008)(122000001)(54906003)(53546011)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?tuj1lvC0OhP+29OeNM5Ach9uefT3kOXCk4Dy3Tckw7cn5j3yvvpWOaL88o4M?=
 =?us-ascii?Q?weU6rCVDNGhoXATYb6BTNhuizXRXr68jGk4eUYwq/+WxazIa1TF1IlVB1vYd?=
 =?us-ascii?Q?G9yHdvklUZly5gRLLunwVXzduTU3RpRFuAgH+oVMZeEqTpkhQeCbuWQqGMJP?=
 =?us-ascii?Q?Evsjx3NZcUVIbW3QBeBW01GOfUqoKwNNScSKmLu3B03DwuA4of7T3lCl/S87?=
 =?us-ascii?Q?9OkTtP+4hzzVrU2ImywdOTqMMULUnhBW0RpWzQq1rV1iZfOk+N3FSkE+2A5i?=
 =?us-ascii?Q?kmMcWisPLqHuUp9zA1UzmIMLiHZhEggd1djAKN9h2Z9OqaZmuTgb9HLV/bMx?=
 =?us-ascii?Q?gjoixxwro5qq3xnw9oUrUTZRMW8VtjsqomkmbnSwgF4HK4d+5OxkuGJB4eBE?=
 =?us-ascii?Q?2VTuZq6ZfHB3JQy7Q4IEptza6gcDoti4QwxfeI6Y1dL9aGned4BoKDn41laL?=
 =?us-ascii?Q?pOWue9O/ctl/xxPk7zih0+oQgCMO8RPqefDju+S6nvYp5AawtaWjWP4+c/CJ?=
 =?us-ascii?Q?UE+D+IMpUl5Q0/7/Gc80HNQJpVRdShKhWiiQk8tiXjAqJY37tRm2XaHzUD4i?=
 =?us-ascii?Q?UWhSUvkocf3KFlVLhXIUtuyo9IS29ozlnPhho0TvTbfccKoXsESKACqLkyjH?=
 =?us-ascii?Q?T7nWBPWGJOC6muOZtDTPIamxnvj8NAfYwjQkuhZHTm/cijldU6GRi23ozssL?=
 =?us-ascii?Q?qmIz+cGLfeaLGdl5BVTztskrxcfD16kl+hs5yu1xsHswKa36M3cdqPQK2VhN?=
 =?us-ascii?Q?L33GmcShVRjLE5YNtlJZLVNQtDEaqJ++ZqvrecYDsUR9Y2SrSdRFWafyCv3K?=
 =?us-ascii?Q?99d/OJUUe3TveRKE9KJswj9vuY5BwZZ208s0p5mmj1n/QhpApvlKr1tTI3JH?=
 =?us-ascii?Q?cyjV3a6HEtBX7YdsQOYdyT8Uo3pBSoZlKI+cP+vpy1jrdcTCGHV0UZBdn5oJ?=
 =?us-ascii?Q?7haD80eb0uRwP879TTGhMYG7Q3r9p/EURf1h5Su4eb6h3H8rC7nFFRn8mzc6?=
 =?us-ascii?Q?ubLSKc0uiAGyW9y8u19DjbRtoB+TcuE0bxUn2LYg5eXLU4hDQkh4O350Hl+U?=
 =?us-ascii?Q?+MHYriydMBUSd0QPLv8ofITeHk1l4/tmBf89lar7rScHm9C4c0WO8nfFirUG?=
 =?us-ascii?Q?f2N4c59xUZovoMSlF3m7kOjgLMM0/Kp+TrnYNCzxZeLkO4+xzY2BlGauF+Fm?=
 =?us-ascii?Q?oQrCT0AzbrKwW3rXuO5Jfv0grwrnsokJTJanXxvzoiQ21Lbany8Jue6vGQoG?=
 =?us-ascii?Q?g7HTHr7mRMf5qeMHrbGPZ6BlZDDxJkBs4OJBiipwn4ZDKDeueAu/jvjhjGcl?=
 =?us-ascii?Q?p6OqLnmMwwdDQgQN94iJNurwIRFmyR3QGABkDaQAAkW8UaQXgPNymezbUr4I?=
 =?us-ascii?Q?hJitNkfK6+FPBay4BREeyLtlWKYpwNQXeIxL10RX8ION9qqvBz2LWdYHuAz9?=
 =?us-ascii?Q?j2LnOen29mSz+eAAvbzUOxOhQH68JK4QforAVX4FzZH+mVK+UvQnpYpBYsmP?=
 =?us-ascii?Q?zUt8rxlQOqdBmgcjO7WicUk0tYavg6Dz/yj7lv4KrQYCGtRw1eZBfm8SEnW7?=
 =?us-ascii?Q?0fAVI+DBOMmJhuOUVUJalpZWN3su6UDlKm3eVTB+a3qmF3FGKyYQVS1n2911?=
 =?us-ascii?Q?QQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <82731632C5996E42B26EF9E3CFE69E38@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: zdqOo7bNF+eT+Gut9ZmwVz/HIxTrOO2aI+W+MImdRUZDjLk2lLKQPUQ1SEosCnfFDxfleseQ2AIyrA0HftgFsuTXvjZKbreXZmuSUFJ87irQi1gudPN23S/7XXc5hdTUjbx4A33mD9aB5FWYVRG+pc4Fm7gsOLy1Kx0P72c0+VyUbY+iRBGrE9ci7vEdoUiIFfg0ZiPZnTUL9fHaLpRGfmX34ECdXXXU3nxPiULbecYxy36mCAtPewLqfjezbH8sUpq+hp9GoT9R1PGtCtSNjakT0klbxDt8q9vpyA0ytrzfNg1nPXPxQ5tentY/bmWv6rcFDDRqwObjocgpxDfKWfc3kccnLnBrlKKBpEnKKsfuGkE3dn6fcqZR6XVExMAIaBrOK2tSqAqK526tEhoLSPRDM6+Mu3f1uhPTjrif8f9cGhEqueDIKoZkRBuqbse8KJN5xlZjJ8MKZ7IoCent3Sj4Rt1yP8/vwCYUvdvGHT3Gwknna/7xYTlW+Az7ip8RvirMRGh92F5v227cDHlznbeDrEVwmt0OKWMNPU4tyOPVDC/sPGtHv06qsXQkDHbXRf91bvBdkWSnMkDJllI0y+tWPhtthJQsnKlW+IRQ05GQJTaBwysUe1FNcXEN5LH9P9ViRP10pRIx1D/R0tYkIrjj19TLCvWfkIrxDg/F54Tz4Yq4hQ1Mr4E+oezeibXh5hVIQLFfdtZEtIcckwib0L8oj0O2jj9R+ytGilOg5si89QuDt6/Hx+RICSvwtTLL4MO4G2MTguOAbhgVGUzzOZKoZy/rRM9Yj6nx4YOHsprRf2uwgE5rARIzvzu2C8trgF6eKAI6tjyQbXQsbbVo6yR6fzSb3Ve6LCC19RKZYig=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32faeb17-1514-4f82-e9c7-08dac3f64c91
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2022 15:06:23.9723
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: K3u9m+Q7AbAkbtvDUFbKqUCFVIXcwX+9aolw1mXlJPr2HoTQJk1mb5bf5ShX58XUSgo1aPcKB6U9zDTIgdzePw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6388
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-11_08,2022-11-11_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 adultscore=0
 malwarescore=0 mlxlogscore=999 mlxscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211110100
X-Proofpoint-ORIG-GUID: KKIUXYJDVV4XjL06y8wcOXpeKUhf8G7g
X-Proofpoint-GUID: KKIUXYJDVV4XjL06y8wcOXpeKUhf8G7g
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Nov 11, 2022, at 4:18 AM, Xiu Jianfeng <xiujianfeng@huawei.com> wrote:
>=20
> Use struct_size() helper to simplify the code, no functional changes.
>=20
> Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>

Applied to nfsd's for-next tree. Thanks!


> ---
> fs/nfsd/nfs4state.c | 9 ++++-----
> 1 file changed, 4 insertions(+), 5 deletions(-)
>=20
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index 2ec981fd2985..97badca3135e 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -1833,13 +1833,12 @@ static struct nfsd4_session *alloc_session(struct=
 nfsd4_channel_attrs *fattrs,
> 	int numslots =3D fattrs->maxreqs;
> 	int slotsize =3D slot_bytes(fattrs);
> 	struct nfsd4_session *new;
> -	int mem, i;
> +	int i;
>=20
> -	BUILD_BUG_ON(NFSD_MAX_SLOTS_PER_SESSION * sizeof(struct nfsd4_slot *)
> -			+ sizeof(struct nfsd4_session) > PAGE_SIZE);
> -	mem =3D numslots * sizeof(struct nfsd4_slot *);
> +	BUILD_BUG_ON(struct_size(new, se_slots, NFSD_MAX_SLOTS_PER_SESSION)
> +		     > PAGE_SIZE);
>=20
> -	new =3D kzalloc(sizeof(*new) + mem, GFP_KERNEL);
> +	new =3D kzalloc(struct_size(new, se_slots, numslots), GFP_KERNEL);
> 	if (!new)
> 		return NULL;
> 	/* allocate each struct nfsd4_slot and data cache in one piece */
> --=20
> 2.17.1
>=20

--
Chuck Lever



