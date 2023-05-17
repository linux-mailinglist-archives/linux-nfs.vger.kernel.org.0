Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3219F706FE5
	for <lists+linux-nfs@lfdr.de>; Wed, 17 May 2023 19:47:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229996AbjEQRrs (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 17 May 2023 13:47:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbjEQRrm (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 17 May 2023 13:47:42 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9E66D2C7;
        Wed, 17 May 2023 10:47:23 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34HE5CFD031014;
        Wed, 17 May 2023 17:47:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=dkpDg7GuhJDDs4td12pUvAJ4vlKH2Olbn9+FRDroq/E=;
 b=mj4qZb2FK4K9zKGITYiv07CAqvUdm5ib28aGcvlXC1iCy/A0uQFA4fRLBUn7LGOEDnwG
 YXpiZccgWEJY5ED31Is+K/kcHl/BS69z1/mtyjAHqqw8T1fmmZH7ym6PgBWiRa5RMoyF
 ss+f91D7NQSOcBZCDtSfK6KXznBy4eDEz9ZD09ed/arRwTXOBDhoYUkIrY9zkuCpp0zZ
 /a2aVRcOymx0JIq5JubgOrt7j9XtL22s4eyyJt1jvEKJfDl7vWTS2ceL/ao+VsHy/vUB
 5ckqq3cM6PZ46oItzy1DjXo5QWyumrFsvx+LBITTwIlIvrdJCqWqRHDnj2Utw/fsF+c6 5w== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qj1fc6fpv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 17 May 2023 17:47:17 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34HHhPjx036175;
        Wed, 17 May 2023 17:47:15 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2177.outbound.protection.outlook.com [104.47.56.177])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3qmm02rb9f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 17 May 2023 17:47:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AxLcxzvLSA0ztlSTmkiqCYe9LcAc3ATDn6etBv6khEbQIbkBgjxkNcN+v0/V+cBCxYUMxLD3pBXmEDrjWbyTynuwnK5IARB0jd2q3vpF8wgq2zLBveU39RcjKi9hHKOtljOyxQ/C+Ef6ZyO48Zyw4wNoGjR9DHNUAZvZF+bdZx9W8MfIfNnvp3Ec5VsWLVxuLD6x4sCbyxNCwxLsvIGRPalvZTAxEjFFQ2LUaDprzS2RCDVwq14cBtleaULlPdPGp3+ZheeYyRP6nPrtiSHLgmpkGDNkNIh/jdxxSzQnRLuoDPHBbiHdl02MZKGkp+na6d54GHpTodZ9I6XrZtRxFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dkpDg7GuhJDDs4td12pUvAJ4vlKH2Olbn9+FRDroq/E=;
 b=N1rpvlQ1hwoseXF+7FOLTNPEl13Va6MVj9H0nH0pIFEIj6JGzLuQo+FMrFzW9BnTkZiZ/dPtvpHsxWyr3tjnTHL7oS70qERcpSv9abubOjj/o8fk9og0aNKzkLxzU9SvxPCA8ugAzXJi8lFkcp+qv0AbCoXhFCVb/yLhQs7sAf9ZVQ4v+vEmGqz82e1HpfLFGrR2sFq1W/BonZ/xCMVfU7mWtjO2SvfGqC1NPBwkpx8A3/y5f6Xr1GSmrZTgxNZbPJ7UIDfnvEpnfRFVEwDNCUiIiiVHiD+xNZmMBoUYnaTGrmaXd82P4GOl5luWAqZLcQ9xd7LShkdc/no37OxaBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dkpDg7GuhJDDs4td12pUvAJ4vlKH2Olbn9+FRDroq/E=;
 b=rmT2hv6UnVKwSGIJ+RkerG3K9XBIzIPC/u40eLjkmE4fWbSxmBvqYKCAkj7SV5DalLYRG3EK27sj91fWuji+cDFB6NurDJsQjnsOERdzZnKI09287MBnfTwVJZSg+hWG8fy7o24M8kWrMD3v5IclPQGrAr9LFVxT3uHt6POmhgQ=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by IA0PR10MB7276.namprd10.prod.outlook.com (2603:10b6:208:3dc::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.33; Wed, 17 May
 2023 17:47:13 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ecbd:fc46:2528:36db]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ecbd:fc46:2528:36db%5]) with mapi id 15.20.6411.017; Wed, 17 May 2023
 17:47:13 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jeff Layton <jlayton@kernel.org>
CC:     Zhi Li <yieli@redhat.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] nfsd: make a copy of struct iattr before calling
 notify_change
Thread-Topic: [PATCH] nfsd: make a copy of struct iattr before calling
 notify_change
Thread-Index: AQHZiNxjTBHmZLbinU6qeN9/OzGsKK9evXMA
Date:   Wed, 17 May 2023 17:47:13 +0000
Message-ID: <74D303B1-08F8-4CDF-8732-9352FFDEC463@oracle.com>
References: <20230517162645.254512-1-jlayton@kernel.org>
In-Reply-To: <20230517162645.254512-1-jlayton@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.500.231)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|IA0PR10MB7276:EE_
x-ms-office365-filtering-correlation-id: 5420cb0a-7cbd-42bf-f921-08db56febf2d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2RZM3x5ofYmNbyByC4Kyn/qYS5Nx6Oantpks/ouIVxeCiEQeROmivCa8RBWantuZaP52yBp/sy4gfy9/wiG1zWj/NaYr2QlOMGQf4FO/i7co7X5Q/oYXYe7ENg/UnmV/y5kAsFdmodNleOFDW896yZxyHlnODhIYk5OiTY3PWOs57JEXjD6LAHt9/5tk5yNGfLg/bRYZtjKwjJhXs7gpvILpgBpiDtkMLxt98WqPyQAZ3OIQaVwKtxCLclZ2ZtpBWvUQnANq6Vq+k+BF9pl7vRBg8+5aYVFGVu3UvBmRQMqZ1saJiyb7vo/U+6soKcmheg1bPh2kGdhg3Jm3TbIXRQZkmxudcaAaF+u9NkaXDVdbp3N7g2r9XxmjrGLFiCwxt6Hnltsh3GATtoIuUBvB74uLmxV2Y9MQwASRSyuKqm6HJfPlrlPAcqSlfulbXceDU+m705llo0Mzce2qxcra8zEWxn3h1zq+WKsfYMkQFtzRoq1NfibfjlPbFOxd1VCjM++B2kPgVvThpJ8gbcmC/A9YpigF2H0Q4mbQHzKbZYKPonZB3VD+AzEkXtenglTBIRzJZeEQuMXydoMpOkjOPcNcyRxdfuJQnnUTDDeJVqu9Xzn3R2Sc3XcJQcs045kM
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(366004)(346002)(39860400002)(396003)(376002)(451199021)(36756003)(33656002)(38070700005)(86362001)(66446008)(54906003)(316002)(91956017)(76116006)(966005)(66476007)(66946007)(66556008)(6916009)(4326008)(478600001)(64756008)(71200400001)(5660300002)(8936002)(8676002)(2906002)(38100700002)(122000001)(2616005)(26005)(53546011)(6506007)(83380400001)(6512007)(186003)(41300700001)(6486002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Nrh13yiCEPtMEmVE8hsKawGgMgENjECSFco6K05jj2qSRGoa8WccFGFeROoa?=
 =?us-ascii?Q?XIfdUWPk4f8BV5vT82WFkhm/4tqhwIVHCA8d2BrhWVIf26pJEGb9oGH10G2n?=
 =?us-ascii?Q?I8Mq1ABksTX49fEcsQ0MLga/X8MHXK5llEPpfxnQjespKsX/RuhiiSVwYYdC?=
 =?us-ascii?Q?nTu5ZHtiHxbUKLBKhc6GAhQMBjWiLnRqK+T635wUS3ILrajunGADwSa093Pl?=
 =?us-ascii?Q?mxjLC1u2zr96MuBpjyFS2rFOFRzBI1nhQuRAh1IHAPVtU+lHGtaijP2Z3939?=
 =?us-ascii?Q?IPiQZ9Z6ow3bYrnKeY+zM/BoWjxsTy6Z3+vqV73IzX9UJ7zIZ4mbmxwG62PK?=
 =?us-ascii?Q?vhpBT3yhqvvMxxmCE9Q+oYbotQYiJigoOUrnYexzTH7abFfgjQ7BkK9FKJD/?=
 =?us-ascii?Q?QxtQRY3+fEgqvuUpxofMQljm2AUhc9U/Zy2T0wyMB8W+1akW7x183e31kKnG?=
 =?us-ascii?Q?9aQPc4LoOmFEGxr2s4w6tfzkYjjQ7uBVGCAa/5+4T622AoNS2E89AJLAVZII?=
 =?us-ascii?Q?Vd+gS3HHdZv4tVMKsj4b+XXasxEqj3EYBkpZaD4US7BCbGfWzZ5KRcKQH884?=
 =?us-ascii?Q?cuN/Bc84Jao9zagzRZ3WRchg7GDsXmgm35/f1iu/FQVcekhRCVIFaa0KAL7V?=
 =?us-ascii?Q?4lLR+Tra4uSVhLg+9hnaaoo8vHlKuGvbrao22aPjj75+b6ZvGe+10Fepi7Bk?=
 =?us-ascii?Q?MqYGHtPPrYCZ5N2owghgX4RTwTZI80y0AKQ6Yn0vZH6gdl1Ui2tk+W5yt7O+?=
 =?us-ascii?Q?VyRBXvDEEOhaOFIKvj3uLQ399W51SeUvFGriTprnAwdEzIlODHFAmC3hp7yA?=
 =?us-ascii?Q?4BXHewHAz0Bp5j2xz2PQoiJtO74ewUxpamx3tQldegnN5v4lUGBUtK1/LPkA?=
 =?us-ascii?Q?nQ+YnMeIQ+vQ+zFVYmnFY/C35KUhXRDNMMVy0Fb6Ptjo16C73++oFFWpnx4/?=
 =?us-ascii?Q?pFGeHavp2EGRXxZxM7JzYZudJsRvJD1qkbMRzgqC3ceO5QwsZ5h6wNpm8PLS?=
 =?us-ascii?Q?c4FdMIb2o68ekTXRnav8vIiWPZV2QLp+g5v1jLz56D4LtzkZfDNTeNPq+i1U?=
 =?us-ascii?Q?B32G7ogwn40ushTp9FPE9q4LlNTNd230P+/ml2C0f+OsAIiP/ZHTUnvskfOe?=
 =?us-ascii?Q?OYNiq4tmzKPdXoyc/eMdh/TVKVoeNurhP+6So18bu7moedXqYVuIqzE618bC?=
 =?us-ascii?Q?WEGgZ0CQq3pYAOOWueknUsdHPrD0BjKPBThcumn32jFFAYsSzFa/jF4vRtHG?=
 =?us-ascii?Q?v6/bV1Db05TFnxvjcomjPE4Euo5VZpYFzzLiGX7BHG3tc7JlXE/zuTXiREp8?=
 =?us-ascii?Q?yO2nmXy2nh6IMm7TzP+k7J0CLnOdl3p7W8Q0RNrQWe73U5q4zzPR801CaX9N?=
 =?us-ascii?Q?i2QgY9kPEkNNEuB0dRegAy/TX66fxpQXFO6/bsvpeV6++R+E5YjyRRWLJTAL?=
 =?us-ascii?Q?c6DOJLSuXPw6AXI3kCmZVnbl2DsWoHiqNgIrfTueR6noyhs8Hnh3VE3OxzBE?=
 =?us-ascii?Q?dbenXccrEiveo09KHmPjWKxfNoy+HD775TbkIeQsPxkkzlmCGeFavCTHxX6K?=
 =?us-ascii?Q?+P7JkcCmoQYtZ0QDAuUcmKD+w07UdGTKeiTYG0OZieccVS4NNW87ilzFdEoH?=
 =?us-ascii?Q?Kg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <8CC45C45018B8F44924A55827C79BFE4@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: fMfHLsRmpFUo79wm04z3Gx6ozD/CeczAfargFbmOjGZsdALaYGU0bnBdW7/9ajCPzly40Cdt4IBwRAQ0l5ZBMo7SG6gBwwgeG1pCwVd3QQ1aoYYzx0TSJJ8wZ9O9xi1FalRGCu3qBZb+DS/RzdZdStOoY9J29P7WrFxp7+FL/AICVzRhYh+rrUYABN1cfJmdXzQw+XcRGz/Jqk9+HRqoYYWiL+zFuRg5/N6HGYGy45cnkGknZND+L8qgKK0yXEaiql74wFVmFtHbx8urJouJ1afbkBGp4eD4Xe2yOHshT4sgKWZMBlzxa/mnCoraGR04OzDG7PzqmBmBTNHhJ01b3Zkvaj0ZHMBBgThMRl6xqcFLfLytaiff/Z9Y8gz2XL7CtiOIKCOWmBaoAlFr7aXfXA8KCwJ9TR22CPtY1JOXyYIjrJ68hMWCiO7BXVvI0VWbgPP1/gJyksBxYiLhWVN+SbWYtuwJX3ywHtDbXalzMxliLnr/h0PACmuo108wb6NdgwtL4HAj62fx4mg5zy7sPn4z2UyWfk0s5pag27zamIaI8EnSrN2afgzOj3oMGM5Otcv4vs6aZc0Mm35JTm6IXtb4aLWmw7GcHR6nVwy5+tGihzy229HfWR59SYaBKXaZx+ZWq+2Jkfwhx5J3YhiMC2B1+OIiC4hHmPLBZI9kmfQdlqRBVwJrwzEBcMx2XvBThnK/lvaGWySpXepmBCCnlP7esLAo0+Uwhscp9z1Bh0StzlCvBVTqZtQ2ssNOuDpR8N/2hsNvPBD3tHAg2BK32JxhsYOX6sF0m0y0Pt40i8YAJPi3UeQ689IPfaC5z2Eg
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5420cb0a-7cbd-42bf-f921-08db56febf2d
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 May 2023 17:47:13.1738
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LF+JhXdAtkUHQAkV4V+6M8VPj/5uCAy7cwOPuUH27J6Q8EoJikSMBHYv2CryLqANst3JnywHDRtV3NutmzdWiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7276
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-17_02,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 malwarescore=0 bulkscore=0 spamscore=0 phishscore=0 mlxlogscore=999
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305170146
X-Proofpoint-ORIG-GUID: uqie-gC3q9dJz6N3UPDxoUhCpuhpprSy
X-Proofpoint-GUID: uqie-gC3q9dJz6N3UPDxoUhCpuhpprSy
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On May 17, 2023, at 12:26 PM, Jeff Layton <jlayton@kernel.org> wrote:
>=20
> notify_change can modify the iattr structure. In particular it can can
> end up setting ATTR_MODE when ATTR_KILL_SUID is already set, causing a
> BUG() if the same iattr is passed to notify_change more than once.
>=20
> Make a copy of the struct iattr before calling notify_change.
>=20
> Fixes: 34b91dda7124 NFSD: Make nfsd4_setattr() wait before returning NFS4=
ERR_DELAY
> Link: https://bugzilla.redhat.com/show_bug.cgi?id=3D2207969
> Reported-by: Zhi Li <yieli@redhat.com>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
> fs/nfsd/vfs.c | 4 +++-
> 1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> index c4ef24c5ffd0..ad0c5cd900b1 100644
> --- a/fs/nfsd/vfs.c
> +++ b/fs/nfsd/vfs.c
> @@ -538,7 +538,9 @@ nfsd_setattr(struct svc_rqst *rqstp, struct svc_fh *f=
hp,
>=20
> inode_lock(inode);
> for (retries =3D 1;;) {
> - host_err =3D __nfsd_setattr(dentry, iap);
> + struct iattr attrs =3D *iap;

This construct always makes me queazy. I'm never sure if an
initializer inside a loop is "only once" or "every time". I
fixed a bug like this once.

But if you've tested it and it addresses the BUG, then let's
go with this. I can apply it to nfsd-fixes.


> +
> + host_err =3D __nfsd_setattr(dentry, &attrs);
> if (host_err !=3D -EAGAIN || !retries--)
> break;
> if (!nfsd_wait_for_delegreturn(rqstp, inode))
> --=20
> 2.40.1
>=20

--
Chuck Lever


