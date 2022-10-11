Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB9F85FB43C
	for <lists+linux-nfs@lfdr.de>; Tue, 11 Oct 2022 16:07:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229901AbiJKOHl (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 11 Oct 2022 10:07:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229839AbiJKOHT (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 11 Oct 2022 10:07:19 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F6E397D57;
        Tue, 11 Oct 2022 07:07:00 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29BDT8NU019741;
        Tue, 11 Oct 2022 14:06:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=q5lc1KM/fSXmzeCNlpRN47OVAK639Y+Y7T7D4775JYo=;
 b=KMEhKJJfKG/Gg5LD2ecnbSGdW7voO+XzoaUfe4MIwQXvzp9x+Ha6MjCeHr+o3+82XBjl
 WY1VidkqF/SUo8G6ItcMXWtDGXx2P6XmKM+LsfiiTbDpCcj+YAeIXZYhBev9wDITjOjo
 0RmyQZlBuu++u5Hp5yojaou5jSudulq7A39Ogec3WxY54qAfCczuujTZGor31NHIhIhf
 QxNEN5pvSEf9z/kgzhmop98QRcexrZjdSgaydQgjNefiBOPP8JtypHn0g98jRNcDdRXA
 NtlR/fCsh04IPvJ/mcy28fROpTs6crii+rEHkOKksLyBhP5z6/SitPFCVL1kqa7cgiYV sA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3k30tt6ryp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Oct 2022 14:06:50 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29BC498P003016;
        Tue, 11 Oct 2022 14:06:49 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3k2yn3nkx2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Oct 2022 14:06:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R/bkwVtbfRPsObs7qm2LVbqVHpN0rEMwmfMq4jJmvyP1mUBBROKznJ7PIV6OKyvHbpCxpvpEzHLtxu1n/uwZ76Qpbdx+Yra2qntz7lkFz4K4Kx1QVCHGh6oZXq4GBFCZK8p2Ez5/eZ42UK8yOrHmEsq4VrQlJZwXiY+w38mp69hBdV7fFj5msIvuiFJAT07XQWLcZ0SOqBA37lAjWxRQdzW+6Lrh9gq0Xx4sAPpok836M3LxEw/6Hs0bg+B2wJCA+iHel5TokXWt1bywO7feRimGP97U/B+TOv7wIZtK1TLxwqE7UwzmnIcwSUlS8x4GhpqetfkDzgA4eEYCq2S6rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q5lc1KM/fSXmzeCNlpRN47OVAK639Y+Y7T7D4775JYo=;
 b=VL9vwMON6AJseFbo50C3L+b6oJcRsFSl/lkBz1PwUH5OFLXZ8z4Mi876tOcNuqQn1SQhHrtT4YPWIpTterr/i2oiYqFidYTE4zQj4cHawaNUCDEhC3MYlfbfOUaeNDvcbO9Nq1xc20NX4mY+YWhZWBxZtFtNWe6KwXSFw5g56RhXZI9OeCA+EmvPn2nHlutoDkFIGrkoFn/gck4/+xP17yyXu6vH007V0cQjfHBAmhaB163QOWXdGUSAAJaBzByAIQDsJfPT1yu93iQO78W6vhWc4Jn7+/1+l9JL11Sn7RMnVVnrDzPD/7LSO8wXKUcyZxeFMsqIEMFsny72EZmO2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q5lc1KM/fSXmzeCNlpRN47OVAK639Y+Y7T7D4775JYo=;
 b=Ex4K3FzB3WTsfGoaRKTcOWnpn6dw8zCYckK83BVZ4Yx5LBydF/CwJZz0DC413IfOK+91krcHJDoG2OZeikIyqLPlklmChG3hx7dQf1P6h2gI4Q/bEyAh3pVkEs/24X0BrG5ofUahU1Sjg0nNB7g/zTC6I8gfa/GneCOTIyP9UG0=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by MW4PR10MB6372.namprd10.prod.outlook.com (2603:10b6:303:1e9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15; Tue, 11 Oct
 2022 14:06:47 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5403:3164:f6c3:d48a]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5403:3164:f6c3:d48a%3]) with mapi id 15.20.5709.015; Tue, 11 Oct 2022
 14:06:47 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Colin Ian King <colin.i.king@gmail.com>
CC:     Jeff Layton <jlayton@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] NFSD: Remove redundant assignment to variable host_err
Thread-Topic: [PATCH] NFSD: Remove redundant assignment to variable host_err
Thread-Index: AQHY3OZN5N4Ak51WjkytHVUZefVuva4JO5gA
Date:   Tue, 11 Oct 2022 14:06:47 +0000
Message-ID: <ECDFC360-1397-4C3E-AAC6-7FE532E8167C@oracle.com>
References: <20221010202423.3221664-1-colin.i.king@gmail.com>
In-Reply-To: <20221010202423.3221664-1-colin.i.king@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|MW4PR10MB6372:EE_
x-ms-office365-filtering-correlation-id: 51df1729-8970-4836-42be-08daab91d5f0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: u5oBQscsWmC3yMBMTbQGpHTQQp5U2Z2QBvx7Jy68XmsDMKtbZv7y49stX1LGBGYuCS2vlttuRcpJm9GuoE5aYeFFCUxg0AGYIybI7ZcVXbAHmJCPzetN5sCHErHKF/9Wd7+rhKfBsS34I31jlVcqfV3axrYUICJM1le7xf4ZOYUmzhe8Cz+Lrup+awk7eQ5OEttIUE05J18jmPS5SyRiAOVRfw0MZu+sF2XOdt3hyJqvvbmm7tUy1kbEY/MokDYwupQN7FRZDI8J9/DSo8ZIKQ8JpsSRugCMXN/vPCwuiFoFwl3jS20TSjK3N7OYGJUsKA/sLlPE7QhX6DaiBAx0uz5lgQM1s19sGhmfqWALLE846kg00l1fAJL8hjRAbUe4sFBZ5hhGrh7/cU2Kg4Dw7ca8/N1ZZ+D8WIS/y4i1YIsoNSYOII5AWRqaoj/61IuiF2p4P9G5vRseWtR2t8f1Ms+rD9DkxKFDG9xJwqU0vOi9zl13TlSROS0RRWlx3fEeP+VsAYSSvkYrLqv0hqDrv7tuLeO8v81OjJ7GaMEAQ2zYgiA3wrf7E6dBtp4SqUGSsA2gLPno6utaB0+K9vE1KVUf5PuUsACOFu5Oqf2V1ZdB33iAS8rhbXEE+Pvr+0P6iKfR9XsWu53Gp1Z+/5GQX5KmEnzKsRHJxCO9glUZCTHxyzWhkj76mxpNhHszeaYLtqXyO+Mo/C1Qrlf/XzOwWoBxnkndoZZPzZ3gcxzxr4X902gwZCDU0IMHkmqYgfK+oWWFbZPt+Hrv17udq/hUKJGir4THpCYLspGT+wHztms=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(346002)(396003)(39860400002)(136003)(366004)(451199015)(2906002)(33656002)(316002)(91956017)(66446008)(4326008)(64756008)(54906003)(76116006)(66476007)(66556008)(8676002)(71200400001)(478600001)(36756003)(6916009)(66946007)(41300700001)(86362001)(6486002)(5660300002)(4744005)(6506007)(83380400001)(2616005)(8936002)(186003)(38100700002)(26005)(53546011)(38070700005)(6512007)(122000001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?O+Khzvz1M8M6Z0QnDWD1lSQePmI9Xdj5sO5hCJHRbwNY4oBHSNea2PGDu7Nu?=
 =?us-ascii?Q?ofRHCrI0QsZchSzmtscQzI/YY+caPP3PZLzLe8qi4WkXUNvQ5l7WntzJ5Lna?=
 =?us-ascii?Q?6V7q7FeQgEcKMWTdKHoCFYslhspmFpFCAcFfcq2i1x4DBbpg0XGVyH4m8tSv?=
 =?us-ascii?Q?yULM24jqoPiTdIcYFTQed/a4VBknJpGN32N/L+Zua4QF/XgB17PvBNdzJTkX?=
 =?us-ascii?Q?fts/CQpN/qqldnuX5SkKfv5qmn6ffWaycoY/rU1HeHv8hnH4/jbHoQLQvDsj?=
 =?us-ascii?Q?zcKedQOWXQBBOlWZwdd2wIRcq9zheIcIkWlnzRWB+b5rJp56JfrxEj71yNYY?=
 =?us-ascii?Q?Czsk9rmwNAezFrMBoELot4d2srHlBOm1Tb4QCRiqZOur8Rw4v65ISEVsiUmC?=
 =?us-ascii?Q?QqjMG0q5ZKAZclA4R065OWh6o5wKn2envCb/SKzpIDgZ6ksnVuN0MuU43OLr?=
 =?us-ascii?Q?dKmjAYxx8+tzj59UKrLAXWFnanP8g2L2bZBr+T6MYrpsxsGi1P9oRsGkljiz?=
 =?us-ascii?Q?fvDa+hV3vyS3LnJgEhzEpnx+PLBZEG0w9jbFqDzZew6160BYvRy5aUn1K2k0?=
 =?us-ascii?Q?fzCMp2TbaHQyGG0+Fhricc9TyLP8iyZ+GHKWrtWDC0W+bUdVVpALxbGhNVQC?=
 =?us-ascii?Q?43ZpuOT/x6Em5d0X4/CIwbofUB4dVshSrDmC4htQgE98KNiDqyDpXkkzZjI4?=
 =?us-ascii?Q?Wfiwg59CzaJxmsmMnp3VrBIZq3xCVk/vCu3MCCIfU/jkbmeakjFhTaqy9ltV?=
 =?us-ascii?Q?oBBGYjl1YWLaWfk5wIoVlaQyXtOpieCS+Ny8UhjnrKh3v0OiEXXLGRJWmttc?=
 =?us-ascii?Q?Ii6MTnEi+WqAdaaJle72KZJGVCvysU0TATEdt2fe6c8fBbOOpYpSedWw2dQZ?=
 =?us-ascii?Q?TDeqgH9NWQNnW0udwleB4QEYelBy5+TBRnZB4uzW7dYjslUAIHQIeiRSJrQm?=
 =?us-ascii?Q?2oDEWcTlHe1JYyNgEqtyiLIxQ6qIQ7ajJ0FhnewSTWwokZ06RdACCYUIBj5I?=
 =?us-ascii?Q?rtzam2TJozAJVD5yu8Y1lumundi/EgzeOI5ekUGoDhZxyeYQr6BuH5OaXewu?=
 =?us-ascii?Q?s0uS13Q3jvHtxOXGoS+UTwvKQgsoV7WaAUqDSbAkOGw0vWk7lHeH+uw/ay8Q?=
 =?us-ascii?Q?RbyLi8NGxLIf+a0cHuM4IJdxy0V+GDYmQ74XMqc/oqsfeF2U9hNiqCfhH+jr?=
 =?us-ascii?Q?YG0sj5QYqyUrEtzQxnRrWmHmK+xUpYElb2EL5aC3wzSpV6O44BveCOQ425/1?=
 =?us-ascii?Q?wfDZO00rvREfkXDOf9bx4wiyike6pk0/9QoLTat9IFw3J++fZiIFjzKkMuJo?=
 =?us-ascii?Q?MqdXbaJnzuObKSn8V/mJxT6VLimBj3fbdvj7Q9GOitJuYGPz2d7ovvePJzel?=
 =?us-ascii?Q?PlMkwls1DPxsqujYrOUO8Xi0L0kr6EeL5xUTy88m+mlEsSZ3+/0rKlobxQ7X?=
 =?us-ascii?Q?tACbBVe7wt2LRR3T7TTtwgYomq+NPJ0BDhnayNTqlzstwJsmYjt1XsivNszn?=
 =?us-ascii?Q?StBaOD0irjwdis/TR1N2G2R7F/elhXkj44zYbwxX+TXAkb7NxrOenpwSH3H9?=
 =?us-ascii?Q?n0kVIq3X3uvj0U7yyp4xc5LWC676vKYABk9tA1LLTunpngFPpHgpSMlq4pj1?=
 =?us-ascii?Q?fA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B1F51A122D49E541B84F32B1AB7E9F50@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51df1729-8970-4836-42be-08daab91d5f0
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Oct 2022 14:06:47.3778
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: V63htRexjfxh7RLLryFJoHhQcgwWMgbciOLYBn6d6FscbSVjbLB10ih365MT91NQezqykYF8UEzlTxNRGzN3qA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6372
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-11_08,2022-10-11_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 adultscore=0 malwarescore=0 phishscore=0 suspectscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210110080
X-Proofpoint-GUID: PTy_MvWXdbjcDS23Wxf29GkhqVG1Jorw
X-Proofpoint-ORIG-GUID: PTy_MvWXdbjcDS23Wxf29GkhqVG1Jorw
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Oct 10, 2022, at 4:24 PM, Colin Ian King <colin.i.king@gmail.com> wrot=
e:
>=20
> Variable host_err is assigned a value that is never read, it is being
> re-assigned a value in every different execution path in the following
> switch statement. The assignment is redundant and can be removed.
>=20
> Cleans up clang-scan warning:
> warning: Value stored to 'host_err' is never read [deadcode.DeadStores]
>=20
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>

Applying this for nfsd's for-next (not yet public). Thanks!



> ---
> fs/nfsd/vfs.c | 1 -
> 1 file changed, 1 deletion(-)
>=20
> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> index f650afedd67f..5093ae788f53 100644
> --- a/fs/nfsd/vfs.c
> +++ b/fs/nfsd/vfs.c
> @@ -1304,7 +1304,6 @@ nfsd_create_locked(struct svc_rqst *rqstp, struct s=
vc_fh *fhp,
> 		iap->ia_mode &=3D ~current_umask();
>=20
> 	err =3D 0;
> -	host_err =3D 0;
> 	switch (type) {
> 	case S_IFREG:
> 		host_err =3D vfs_create(&init_user_ns, dirp, dchild, iap->ia_mode, true=
);
> --=20
> 2.37.3
>=20

--
Chuck Lever



