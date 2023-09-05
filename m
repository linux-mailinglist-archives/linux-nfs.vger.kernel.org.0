Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F374792FCD
	for <lists+linux-nfs@lfdr.de>; Tue,  5 Sep 2023 22:19:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233046AbjIEUTI (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 5 Sep 2023 16:19:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231444AbjIEUTC (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 5 Sep 2023 16:19:02 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F8DBE58
        for <linux-nfs@vger.kernel.org>; Tue,  5 Sep 2023 13:18:46 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 385ExkIW026585;
        Tue, 5 Sep 2023 18:10:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=+pnxGIdLLLeGyfpT3/Y8BwHIxESIzzO6wnrzvA4FSEk=;
 b=JpaNs3y5HC9Tv0fDScKqt8JaXFpB33gI050yhZaLWudXKrInHbMEC+XMWOrHjNnvtSc0
 lwN99F32YG2PqsY89Ifq8Vcyu9XNxN7D7spi9ysPxYb3JPEbOw0EEZPjcst0VpLZNH/w
 4tXUrlx377eGXvfxV3uq/7HPvImiOcBQWnLgPf7EgqlGRariLH1kK+vMx2YpgwTeHtn4
 nwUPxwt3UNLc4qydGtbJRfwP3NUyiyBCUZy25y+H/C3pxwNOAagzRyVGO1Go2o8db40/
 uEa3/H7Y2XEMWqUdtfW+Ky7USoIZOfDNNRkAJk+qCsZOMlFIxES4QZfsx1mpZxoBqtmF RQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3suuybp4rg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Sep 2023 18:10:14 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 385I1AU9037106;
        Tue, 5 Sep 2023 18:10:13 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2048.outbound.protection.outlook.com [104.47.57.48])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3suugbcj4f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Sep 2023 18:10:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R4jLRo9gauDkMUAKVK85/OfrsNVAaH20eBc/2Z+QlcLuBf8eDJbS0edxSBIwnDEzUsNr4bLPhfO8B+1fgd+mWKtoGU+wJjNkDkwNp1A5a2y9e6SDzGmXLYyIX4CbVdqTYW7lMYwV1rURc5EyGNQlHH9vXHl5ISXESCOsPAlGudJqcClh2J81qTqgYb0OA4M2xNtZGsFBQloHLtgEYH8iu1TJIphEE+h86a2kddf6RYI8kQmD/BRkjZT6Yu4Bt2A8/RXUeKFdC4agomLA7V/ceFxRcdYngA2jPk4ypjy667D7JOeC6DoCaMKYFxRvM5waweiv6drzzsu4ehQgDQQqSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+pnxGIdLLLeGyfpT3/Y8BwHIxESIzzO6wnrzvA4FSEk=;
 b=NcPTy6KEMThKE1X/TvyD8WDvN4pomW4cHma0f9G8lZNyZoLBsd4ahjFCinHmkZDu8l+7fvKVZ6zSM+k51Gxz5h0EpUGH38vKRBhwtmrNlEGL4bD9NBvVjgQQ7gs0G68zYRt+pcFA66pA7p4hFsnFeidbxtbyUPB+sO+W1Y4MvUhuP6so/LFh9U8idAC5f/GOrXQuWPb90JOLNhwc/bEe13iIemSSECvfHIkVNxjMRW3/9Hs2idhuNwML22+5FNML/9MjiJ051AucOVSc3ysPQMaVm+K+uF/pvAwE9OmDTONjdY/S1iJC3TZy3K8GO5uzHRf4rJc76jXbAWSdrt5tmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+pnxGIdLLLeGyfpT3/Y8BwHIxESIzzO6wnrzvA4FSEk=;
 b=MjC4brxUCNeH9kQhMhXT4Mfg5Qj9QlfjoZKMf+3v0EOCQLUxcS6nZNdtZslVgtdOPYiPUqlzZUa5eLVa/DvEz98tY/NvwQEwoimT3YrkEbkVN90M9RvER3Xu77XK6bp4tmhaUgFijzBj90y8tWaLbwn6CBiGTkV9LhB2g0oiXNs=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by IA0PR10MB6818.namprd10.prod.outlook.com (2603:10b6:208:439::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.32; Tue, 5 Sep
 2023 18:10:11 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2990:c166:9436:40e]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2990:c166:9436:40e%6]) with mapi id 15.20.6745.030; Tue, 5 Sep 2023
 18:10:11 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Neil Brown <neilb@suse.de>
CC:     Jeff Layton <jlayton@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 0/3] Revisions for topic-sunrpc-thread-scheduling
Thread-Topic: [PATCH 0/3] Revisions for topic-sunrpc-thread-scheduling
Thread-Index: AQHZ35n/QmLNxYmNaUqIIHf3aAgJxrAMiTQA
Date:   Tue, 5 Sep 2023 18:10:10 +0000
Message-ID: <0B88EBEB-48DB-4729-9FBC-7DD0F46FBEC2@oracle.com>
References: <20230905014011.25472-1-neilb@suse.de>
In-Reply-To: <20230905014011.25472-1-neilb@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.700.6)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|IA0PR10MB6818:EE_
x-ms-office365-filtering-correlation-id: d42f0a68-85d2-42c6-22d3-08dbae3b5812
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ilph5gzv9pZcA8+2fL8JnMkGe24RLIorKnc/HKu36M0SUy/GT3XcymJOAVr5nPdWqKPRPOL8hzqZkX8mxcXOw35h7sAXOHRHNMLfwCHCEVj3ql9xK/+qGpdg8BfwzzMuzGZfxhgF04lqwrMC2SkCzt1DPpS9KmaT7T5z1sEo7ZBkft642Ny0PnqZE4t+jgSvXFozH9dPGwTSLte7OM4PAzvq4NnQwFn/9TF/CLjeNU2zFkTAePT2G3iYr3lkwT3dBnNtqojOh2ACBk4y9/m0C5j1gNxdGNqd/FVMAujKaUS9hKKUZpyfFXikXlPLBa2+Rh3t9dASViwReFMiT5Qqy7Bt9m3bucCg/xwXocfSfc3jAw29tOcMkxHbYA6EFv1PPvxrrcEV9V6ldwOCXFhMWHxLtPhdBASVijontUxrgxOvFtrj0c94DpdPo1eqqOefkzkrpFhnorEHQvJJ01Mtopls0d+8Mej2NPJOmLAgtJdSCrozknL9JLCgzpxhYtDVCUbTWDOHJI3Edm7XN0GuFGVOPDiM3rbN/YeitTT1pI+6rsJ5CeshJUWbTNkMgW2QwXQQeZHtp8MOKkwidO/t+eE6YuooufnkL1+cZI9MHNfWFP54KNZLy6lgJxCAyP+IGpYtp2l3hvi83yxSjxKLBg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(346002)(366004)(376002)(396003)(451199024)(1800799009)(186009)(2906002)(66556008)(6916009)(66446008)(54906003)(316002)(66946007)(64756008)(76116006)(86362001)(66476007)(33656002)(91956017)(36756003)(8936002)(5660300002)(8676002)(4326008)(41300700001)(2616005)(83380400001)(26005)(4744005)(38100700002)(6512007)(71200400001)(38070700005)(478600001)(122000001)(53546011)(6506007)(6486002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Icy3HVCCNcmeIyMZmUjCyMLUG7RpGriKEdR3u3g2e5zw4bPENO+uj0VKRUf8?=
 =?us-ascii?Q?1ryCyz9RIc7TMYVSgqwqx43R5Jrh+kTcG5oHN+GFMmyJVrsCwUprbGnaxOPy?=
 =?us-ascii?Q?UWzQrYgPaNprnyR6LcG8CMJiWi4k14GTJxjPX0pxdLkuvsIGDa07pG0JSDh2?=
 =?us-ascii?Q?F0ffr1nDX1Piv+m4FmDGP1RZsmXohJJJYVy5t4K4/DJ6FOWOD6ORoNWuz4hQ?=
 =?us-ascii?Q?zLwdxfS5bG0fNeTqzY3NOcvBnoX0KzRWAbXMrxg7JicIeBCSiNYTokdpoetv?=
 =?us-ascii?Q?dVe8hP/xY0vQnRxsvBGNx6ml4hGm9Xsw9DF8uVoA3ZH//wi14eEAiHZ+S+p+?=
 =?us-ascii?Q?plGWFhnb39hw7QkEzlvm5fK0p+wCYCxg54ZsHpOW31+o7hXvQHPq6zoDfHSh?=
 =?us-ascii?Q?5wMEwbWKKS2AVkCiUR6ea+JafnK7qotbb9R4GWX+j3K91ADNT8l+y9gqopU6?=
 =?us-ascii?Q?MryiHcagCNdkGsRaysNqEtcq3bi5NUhf8We03IxFL7ZzpeoNG/9Ba/yVoRun?=
 =?us-ascii?Q?1VaboXp71C/fm1go6bzEqitdB02Ex2/T0Uj7fERttA6kVuLUR9n4evph4AjX?=
 =?us-ascii?Q?mbzyRsU9he60KPLuQQ2eaLTVXI2iSzotMpD1reW2RHq7dp99kyixN9Xe/Wjd?=
 =?us-ascii?Q?4Ulb7CegRrBDB5LVFqt9r+C9ZEBm3SuIqzU5fZ4vgwkLz7Ingh5+Ct07Bygi?=
 =?us-ascii?Q?O5XpoZvzf9CworBp7k7TFuFBACuDor9geg85iquvmWsT/skNZjdgLE/iUGH3?=
 =?us-ascii?Q?bMEl+7bQ6A0fseQP4RpcU4CNEBhCs/p01L/o5vbi6TcrakkGD8B7FOxlVzwu?=
 =?us-ascii?Q?Br5dYMi32K39z7labaLhnv/USOXsF9iF5BEni6nnB+z2oNNBTftmFaDYVB6V?=
 =?us-ascii?Q?K1Q0jv2huBaLTpFsCE8zmBsvfbiiAyPKm/r3lfTuyNCH/Aru/oy45I/MSMo9?=
 =?us-ascii?Q?Dt6C/pxv1tNrD3L4DKqZnNXFrNc5REsPcryIwMWg94AoQoihwtr3d0DZ9QQO?=
 =?us-ascii?Q?qbN99KBeiNcBU5VZ7ukNbCBIgFe4kqTpb3vVMICRU+H06dOThPQWf10mm3/y?=
 =?us-ascii?Q?Tbg2Ct1fMzVIf7RpHgxbrGA2U2RtktmsKQjyfesTSzH6fGu03Zz2pgA+CR24?=
 =?us-ascii?Q?5Rb6ZDPQ3R9yQa4m1TvA2PiJ7sF0axzkujKi1K0tjW0k6KlRl6NkrkfZP1X+?=
 =?us-ascii?Q?9KZdP/S9tmiBcGpRcphH6IiDY/cQ+oQpSE/BchPfVYWZ1GwoMC0IEd/1nI+2?=
 =?us-ascii?Q?HWgERUocqcieQw/Iwav1gQSWFOqodH5c+bYTu2I+LUaAFF4BZWkyNpRo/wk2?=
 =?us-ascii?Q?PXImFEdlZvJ8llxLTP40ydKCoE1ufn0d9udreV2lILCx1fLcMSKyWFZUS7wg?=
 =?us-ascii?Q?eRN2eXIZVMYZfuReHCZZDOqrRwfpaM6BHRv9XlYf+kY0+YJsiLWEaUrgNmUW?=
 =?us-ascii?Q?yu/3QlSc3l7HZMMzlEYbEMa8NKQ9Px0eHc4kjuUVQgSkYAjAA7Vccq285E9B?=
 =?us-ascii?Q?7mWpk2CwqkIGa5Bdy7X/7iae1NeVv86yx8nlPSoyKcnTMeGTsQBbUkNrqPi7?=
 =?us-ascii?Q?xWy1draVtcQtv3wKP5E8/6/0hTc3YzzZ82jP1pC+4m46n5m+SincnjhXklHP?=
 =?us-ascii?Q?4g=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <114511E8B68ED74D84D392C4CFC38AFA@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: xKeNIjpNPM1v4Qaqb46XPutNxWhSz/1KZgGluMz4GkHK+q/B04PJgztQVoxo4vNAFWzfKJtZPKVrlFGkv5qh7gVvu4mZhEmwD6hrLg2ANSPN03UM5zNfaJL1TCMSevA6AJhX657yoVP1B7GQsxmGjCfFreiGuuSdSryk/tHqx7NpnUDZjev4nsQ+S2PT+fMVY+gd0D1UtkvxQ39S3kXBh+KP6o0E61YYUQIsjgOF2t4s/TC42+exRP7RsuwvZ8Vd/wwTLdow/Jktz/Ox9ejNyqZKQPCRNmWTJoJMO4OTkkrEbkuQ0NtJRlielQKF4TilvuqlcB9076AIR9J3BW2FgoFD0eX3regYZt/dAdgJtBrp0pEnCh35qd6LH+7/gl/1TtI7ALnjz+5qmA00ja6Co0QPPA0UrqmDvbTyS7IkzVWo2dj8+QSgFDeq0VfkDQ7kP7mOtfHeN+C26mMSlgPL0E7sOd2kyyAP56VvVRa6jQ/24UGB5NArpun5cAZA+IoWshOu3EFjY/kGcKFLbH/B2Dmmr/CzWNWBxp1tPyEEBsRLJsAfaITGX8vuYF1yG6AIewzn8vpxdmnkZaL9LIyzJBoTuafNyVAoS4hObSpTKGEKM2wKIrhpturfKuF5b8SFHJmbvB3eNPJO2QkU+8fiTy912/vZGH+3Jw7wnDsa/ktxbOm65+laaC9ARxLBgo3c+aEmXLjibFB2Ih3XiQz+k1s+zqSZmFJ5frJnHgel6dr8wDHRqo/h650N5T6uWjgpDopO7ZWmTKiOWz+aVZoyyAt5jrIHsPMfMyMXpg0s/s1H5HzgfId4uuZ9IE8hcngX
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d42f0a68-85d2-42c6-22d3-08dbae3b5812
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Sep 2023 18:10:10.6388
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nPdR0a2QBiI2UCxYZ6S9c/dkiuqsY83Ni+WkPx/LySV95zBz2dKxjVas6GqVAK5SExAyZQODa3FMDzpioUX4DA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB6818
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-05_11,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 adultscore=0
 mlxlogscore=999 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309050158
X-Proofpoint-GUID: ilVpgxS_xLn_du-moXjHxM3r_3qwog8a
X-Proofpoint-ORIG-GUID: ilVpgxS_xLn_du-moXjHxM3r_3qwog8a
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Sep 4, 2023, at 9:38 PM, NeilBrown <neilb@suse.de> wrote:
>=20
> This a resend of two recently sent patches (1 and 3) with
> review comments addressed, plus a new patch (2) which renames
> some function names for improved consistency.
>=20
> Thanks,
> NeilBrown
>=20
> [PATCH 1/3] lib: add light-weight queuing mechanism.
> [PATCH 2/3] SUNRPC: rename some functions from rqst_ to svc_thread_
> [PATCH 3/3] SUNRPC: only have one thread waking up at a time

Applied these and the remaining patches from the previous
series. No build problems with this set. I'll test them
for a bit and then post the latest version of the whole
series for further review.


--
Chuck Lever


