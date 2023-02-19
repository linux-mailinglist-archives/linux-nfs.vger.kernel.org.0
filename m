Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51C0469C22E
	for <lists+linux-nfs@lfdr.de>; Sun, 19 Feb 2023 20:46:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231256AbjBSTqJ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 19 Feb 2023 14:46:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbjBSTqI (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 19 Feb 2023 14:46:08 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11EF7BBA4
        for <linux-nfs@vger.kernel.org>; Sun, 19 Feb 2023 11:46:02 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31J51RMi015374;
        Sun, 19 Feb 2023 19:45:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=O1fE0KSbJKDciHVZ9ECSV2MwGfbIgGXV59xUEsCgGw4=;
 b=jqBRVEnVj+4d6Xz7ZcYMeGyNhnCMEw1p7l91bxVkBGzAxYSa8KT/osVB2xyPK8fW9x2u
 AakfKC2BX79/wWWB1YeF8RN7Nw2cTe0x/bDKapFYzUtyzQizYbSXIvRa4vgt/49u6UqL
 OGXtbEeC9FMR0u2NrMt/a3w6SvekAycUHqRSq0Bq3WMbmoRjbTcNKFHOhjNXoTj2UbqP
 bwgPuHrutcyANqsEvi5iybhnEHICjXLkT1f7JcMQ+0jInFkY0F1N1B8mXihcNRsE6Q3b
 s+EERIUwWf4/6Bmh5rqGXxvxNeR5mf6sdvQ0Cx85k82CieXkrppszuk/SRXzeoArq4Pi 2Q== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ntpja1kue-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 19 Feb 2023 19:45:51 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 31JJj0Mh023257;
        Sun, 19 Feb 2023 19:45:49 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2105.outbound.protection.outlook.com [104.47.70.105])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ntn4354t0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 19 Feb 2023 19:45:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EzQ1OhRq7UUqSEeXJ8Eq/4VuLr1fFYoWqm0840pboLbXAySPMRr+z80+2Y/8TRMO7TeCuBuWkkQWWX7wQceByLu9268dDm8uGvXteCDApEq7QuJ3Jlqliftc0zQZO+wc10Ng0Uh2Nmf0QcWQ8b4eqIso+xlsaENOR3/TQC75Z5i+6kRnoVZ5+3vmrPAJ+D3ERUWNTmy3Td+99de8/4w3UVZjacajZgrsn9AXw9WoIPvfGPvlWVEYmfZFz74ph/cddAKViEz/HWLK8GJvx2ECdgMT3JH9p6RWn6q+uBg9wXE6ckhzzWlS5PUqnF4Y2dc85/kSCxX3nxZ1l4KJpArTew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O1fE0KSbJKDciHVZ9ECSV2MwGfbIgGXV59xUEsCgGw4=;
 b=DRhqX6rvw0J09OCAN47/x0bqajD32irm0ztVY/9ZjYi7y1/5iP8F8IDYxI5MQ4/UxEdiiRsZk75aVS3+/+CqpQAmCaM/iRM0qcztP9XxgdqPSf6kuoNXAJwNwbeJF59setHvJiivoWB//zdAgva2KirShdHx2V4EYuWV0XA/M3LYbtChfLwUPN/w3WJKuFU/nYaTyT9AzUbZV+mhcmuNLjQKKYP4h0Fi4TXhIFuzQqtZACNqmUWYxu4ar9Y6rGNlli6YXxnROADJP4SaPeYWAHZxmJHvpAD7AWORPtbfXftV0+5CBEQDzJnHcLXtI/xNGgLnoX/Kwgkd4jixr6HiYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O1fE0KSbJKDciHVZ9ECSV2MwGfbIgGXV59xUEsCgGw4=;
 b=U7MI4tYlAUQHrWyZlWqhWmy0R4BGtZXZLbNI3KPGsoxgDWvNjVuV4dPs2J/0YI7CvI2KVzwH+/fbW1yFIhzrO7RlBM22faboG1/IyU6nK/4QKm0Wsl6oPpnqJK5dQuHMW49Z+ec3BTdioQXq0NzTQuL0+IZAOJhA7yHAsyAcFlY=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CH2PR10MB4373.namprd10.prod.outlook.com (2603:10b6:610:a9::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.15; Sun, 19 Feb
 2023 19:45:47 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5c2f:5e81:b6c4:a127]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5c2f:5e81:b6c4:a127%7]) with mapi id 15.20.6134.015; Sun, 19 Feb 2023
 19:45:47 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jeff Layton <jlayton@kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v2] nfsd: allow reaping files still under writeback
Thread-Topic: [PATCH v2] nfsd: allow reaping files still under writeback
Thread-Index: AQHZQTQzETDvMMvAKU6IO7GFCd+rU67WsxwA
Date:   Sun, 19 Feb 2023 19:45:47 +0000
Message-ID: <ACB5CC34-59DD-42DD-95D4-F4B7CA93552A@oracle.com>
References: <20230215115354.14907-1-jlayton@kernel.org>
In-Reply-To: <20230215115354.14907-1-jlayton@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.2)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|CH2PR10MB4373:EE_
x-ms-office365-filtering-correlation-id: b1c31fa2-154e-474c-8e15-08db12b1e5d7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /Dq1aPO3zboOmVPpVhaf1VnceeB8IU26xXGJPvH+A55z6EAJfMsZTRw+RrBa1YNQrFFYe260ZLD0GSGN33XAsMh5dkDQuq/NNdp4thLhCh+901C2lIyQb+xyxMbWBXgg2m3F4SqQcZSdqPP/Kd9qcNwnHkY2Q5dvA0jsPki6Do/Ua+/QGEw+4Nn2q3zNQtWSYRPY3adiQeaNwSAFNJ5tZ4ziG6YJyV+6+rRMsaEgh9YHPBH1fhKofg1h5p2Jbw21UPMFeFc5JQ7WVrFYRPzWKodU+UKpmLU75wrGicDRUj5lM0NFqHLw7LckE6uAuIzaqLevFlrd89Y1KTHnanxHpk3hLPAW3Z2v1tuIlJDnbwTRv5jvXxLB95aBqjB/C7UW9PRGr0/UUetoJ3xUMDZ9qYf5zSiQdDU39nmy0WkCrJYpTZdwWH+E2XU1iSjXMatskSo1KDEGc8iG4VwdBbzqZFQO69VKloxYs9wRUTqsCHZKxTETV0xjT33QyGiNLaat+cFgaLssnqVyBvXUFWgHPPDApbMsrGxgd/6SLpl1363Qd+63WhBA97saCayKcLYjmBvCAA21HKs+5pgR5WiGF6di3tHFZ72dkhyW5E8HCnEreGGinTP328WBvv2fR1oQo6LHp+iJuOWQGiwGHmmWw3ja+xAvQtLDLZFL/L19CaxH/nxvny3N61qb9PLsPa9FcmkKdkZ6/ltkeGBRIm9Y3LhKOtcjOTjH9iF/r5E8K18=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(396003)(346002)(376002)(136003)(366004)(451199018)(83380400001)(36756003)(38100700002)(8936002)(5660300002)(122000001)(2906002)(86362001)(33656002)(38070700005)(2616005)(6486002)(53546011)(6506007)(478600001)(4326008)(91956017)(76116006)(66946007)(66556008)(66476007)(66446008)(64756008)(71200400001)(110136005)(8676002)(6512007)(186003)(26005)(41300700001)(316002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?KDzigyrBwfADeFOf2TLSZNl94SOpDCOHRYYk3ee30c/vcmjPM0AI6gSXV+xS?=
 =?us-ascii?Q?1xj0BddGEb7Mp+a/lmJurh+YBLu2PZWy/l+L5dC74QYwgcJ946FM3N7TODpQ?=
 =?us-ascii?Q?Gp7oB7+ZER85ET2XRz5XaXvqhKYuTjlskDkDNgXJkTWoDMEqEbzwCt+5BBXq?=
 =?us-ascii?Q?uIC86XLgE/Inz9IfXicrW+Y7ewCFJD+0Vt5h3MF6B18Ktlf32tVvbwBqZhbg?=
 =?us-ascii?Q?g6X69JrG0YgVltfy+jBTY0EAl0bQ192JoGFsjiJJwRfdPiKwXJRVSQU9n4RE?=
 =?us-ascii?Q?1kSpbQMEj9yrGq/W7HHPLl/oInq+HDnU9VSWT/KM06K9xXpmMLMJRw8xzcH9?=
 =?us-ascii?Q?WgMH0nMvjrBKPpbeHtXuAojH7ftaPlA36k1qH8k+wFsQA0zg6dAjxDfxJiOI?=
 =?us-ascii?Q?E1EYCoQekA9Q81WC2KiyuQR+uWmuxXitTYgpkHfGA7Er/UpqH+ZxAI85XH9E?=
 =?us-ascii?Q?Io2ePsFHKnw9MR8KzrDEjdq0g61/kATw6RRifkAbXCuz2ZWprQwclkpK/wrH?=
 =?us-ascii?Q?T9eaDPCbOAN+zCDASln0IPp+OIsc+y4KBdZ4xOHFdc3JsqN4FjY3L5LsjkGg?=
 =?us-ascii?Q?usCDvebLy4/6bSRL8cKiFHhtxIG3Nl8mOhPpjupqFKgx2Rucy6c4SAICT5uG?=
 =?us-ascii?Q?6WGfmHZPigFXl3QIxOa0s8hdXOTvrievpp4F3CMJ5gClhwU9KRPo3VC/H6rm?=
 =?us-ascii?Q?kBgZmkVqVHK4/7Vu+AdFWGhj2qQoYelIlRsm20RxN1rW+thU3xqn3JKafTIo?=
 =?us-ascii?Q?wTbtA5IJz0mPwM9cVOca8gNQTMseuMdHskDBzS6J6Lg64xKmZUvx0fwZ2Csa?=
 =?us-ascii?Q?9dkkU15wqvXerpl3ytlEK9DV0FauHBY65QZxWjOKbXR9wn9BTfJdndhTzysR?=
 =?us-ascii?Q?TYKW4t2hyOqPxnYplGOf1qrRsMSVntkc8dvwOixgLD2CQ/rjKYZKm0Z1oWar?=
 =?us-ascii?Q?l4V1rvAdwMvRZlzPkW+vzcDWLqHfxyvAbKiHjhdQkZngjU7GWaFFEJi6+A5c?=
 =?us-ascii?Q?XtpIk/JF2ROqwDH5dftJsoykgF6czXWVdLcyTQp0VBwCKOJKZ0e0I+41Jz0W?=
 =?us-ascii?Q?34xSrIV+GJX2mZLd9K+9ZogNoOOTPg4P5axhBYQmh9KAYYvu04ffeb1JWZC0?=
 =?us-ascii?Q?m9NwcDH4AWFSI2cZVyXQaokYogtAPb2t1mz06xMasoLTE2z0+miQ6zUM6A/4?=
 =?us-ascii?Q?oU/qley4UAacZAVxroWOSRYuXo3ZrdWEwURrN9GzUo9BxpR+XztTSjDWudNx?=
 =?us-ascii?Q?uPPiLwKulGRoAOzXH8+hL0iJMCh+TNDh0Vf3/Mg52dIqvuBn54txIeutbaMn?=
 =?us-ascii?Q?kZfm/21oVyt54xHXpTnF4bCwOPviq6sX7SAxeHCX3hYkIDIzMH6Sye1yjT7+?=
 =?us-ascii?Q?7RKxbvqQywhW6Humiv/clhdkqnDg7RYjuDEuqBxnwjR0So6ZqP1Iiu9Tt0HT?=
 =?us-ascii?Q?bepMNXw0TVa3jr+gZuPR+4NjojE7Z9Nmn3Lylp9inc4WfrmyV4n6fEP5Xduc?=
 =?us-ascii?Q?cTZawMw+4P88lRw1IdYoQildBim3lhIrCdhT2d9auznGHHcnE7HChl2DoTTU?=
 =?us-ascii?Q?W+y2TgXP81N9siDQI8mhClLw979E/wGX6PTgxPAryO2FVxdJGSkwF3y3iRFY?=
 =?us-ascii?Q?aA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E660BDC62073E94C99DF3F2807A657B8@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: cUv9TjvoIe7ibW5bWHd78fq0sAnb+0bYXdN/3nlMiIvzVPqWAUgHMS0CMRmbCLGjlq1NsfvKrw+jYilgOFyoChEib35wcUQVKNWWIYU/usQ3tZ6FlbFb6M0YvVTJUJQbtMEnNxlra6evZmengPXqnUBa+G9iHfqiZRCS6B2h0gKKvv91mlBtKu82K7EeVfa+Sw0iZorB333KurWRr3N/bibwoqeu3MjwzHuCWOXPE/pscuyaDKslNKjq3WzgULpA2J/HeVl53TZvw1ur4MaXcD83pHtaszp7RD0j9tpShqNHus1wMwZ+5e5hCDgXA4tvy+oTaImJCzw6wuAyFaqtaLUTmlQ/O77OyZAbIMIiMocIzSvoICgWSvx1gKgvBLvrXIdcV1q2UIQ+rvdqtda8pB0IePt3S3UE3ze6S3Jt2UO70eYxNQXyBHjq4I5JB1WiUsNg/M70ycTTFVbr3MdQFoAiRuCdLbmBNyS+CUfN/KOnlIJbuFH5vy3PvzCIHCEwpGvADrXwCRx5jAmDp7pD1RVY5erW0R+8Y2kadzYXI6TE9dk1rYkw7MNC2Je1+nB5lIHPFLAx3noUbTR/FcOzMrTJ925YwGbbFL5WHh3Q17MeUHtxx5O1F/LYjl2pXRwhQ0r1W62YTnu1ow9O5AC6cRXOmKBUlkMkhfH25mUC9dtMpyR6zYOppZFksaYL40bP4uK0hwFzgV+iHGvl2QwTMONp1iI62mxB+Q2Q4buvzpUpBd0s8736Vyb4VtXdnpbg3hWdXsaEO7YNQZkOcVHbsvjvIGIH338OC50B1XZojCU6l8XaWnykTT/HIkl/GqQIGs1o/E5m7+4uvnr1oINpLg==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1c31fa2-154e-474c-8e15-08db12b1e5d7
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2023 19:45:47.7520
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0zvOei9y2UmDWWBre+2FM13+mAND1PBuavL5qQ3YdzEcKlSLkDAh6WkZU5HXBQToYrGVTocoG3sg+Ee2q0TpJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4373
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-19_12,2023-02-17_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 malwarescore=0 mlxscore=0 spamscore=0 adultscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302190188
X-Proofpoint-ORIG-GUID: 5w3SUuhSZNDOrkAkgt__6Zac1r9Mu7TT
X-Proofpoint-GUID: 5w3SUuhSZNDOrkAkgt__6Zac1r9Mu7TT
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Feb 15, 2023, at 6:53 AM, Jeff Layton <jlayton@kernel.org> wrote:
>=20
> On most filesystems, there is no reason to delay reaping an nfsd_file
> just because its underlying inode is still under writeback. nfsd just
> relies on client activity or the local flusher threads to do writeback.
>=20
> The main exception is NFS, which flushes all of its dirty data on last
> close. Add a new EXPORT_OP_FLUSH_ON_CLOSE flag to allow filesystems to
> signal that they do this, and only skip closing files under writeback on
> such filesystems.
>=20
> Also, remove a redundant NULL file pointer check in
> nfsd_file_check_writeback, and clean up nfs's export op flag
> definitions.
>=20
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

I assume that I'm taking this via the nfsd tree? If so,
I would like an Acked-by from the NFS client maintainers...

For the moment this is going to topic-filecache-cleanups,
not to nfsd-next.


> ---
> fs/nfs/export.c          |  9 ++++++---
> fs/nfsd/filecache.c      | 11 ++++++++++-
> include/linux/exportfs.h |  1 +
> 3 files changed, 17 insertions(+), 4 deletions(-)
>=20
> diff --git a/fs/nfs/export.c b/fs/nfs/export.c
> index 0a5ee1754d50..102a454e27c9 100644
> --- a/fs/nfs/export.c
> +++ b/fs/nfs/export.c
> @@ -156,7 +156,10 @@ const struct export_operations nfs_export_ops =3D {
> 	.fh_to_dentry =3D nfs_fh_to_dentry,
> 	.get_parent =3D nfs_get_parent,
> 	.fetch_iversion =3D nfs_fetch_iversion,
> -	.flags =3D EXPORT_OP_NOWCC|EXPORT_OP_NOSUBTREECHK|
> -		EXPORT_OP_CLOSE_BEFORE_UNLINK|EXPORT_OP_REMOTE_FS|
> -		EXPORT_OP_NOATOMIC_ATTR,
> +	.flags =3D EXPORT_OP_NOWCC		|
> +		 EXPORT_OP_NOSUBTREECHK 	|
> +		 EXPORT_OP_CLOSE_BEFORE_UNLINK	|
> +		 EXPORT_OP_REMOTE_FS		|
> +		 EXPORT_OP_NOATOMIC_ATTR	|
> +		 EXPORT_OP_FLUSH_ON_CLOSE,
> };
> diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
> index e6617431df7c..98e1ab013ac0 100644
> --- a/fs/nfsd/filecache.c
> +++ b/fs/nfsd/filecache.c
> @@ -302,8 +302,17 @@ nfsd_file_check_writeback(struct nfsd_file *nf)
> 	struct file *file =3D nf->nf_file;
> 	struct address_space *mapping;
>=20
> -	if (!file || !(file->f_mode & FMODE_WRITE))
> +	/* File not open for write? */
> +	if (!(file->f_mode & FMODE_WRITE))
> 		return false;
> +
> +	/*
> +	 * Some filesystems (e.g. NFS) flush all dirty data on close.
> +	 * On others, there is no need to wait for writeback.
> +	 */
> +	if (!(file_inode(file)->i_sb->s_export_op->flags & EXPORT_OP_FLUSH_ON_C=
LOSE))
> +		return false;
> +
> 	mapping =3D file->f_mapping;
> 	return mapping_tagged(mapping, PAGECACHE_TAG_DIRTY) ||
> 		mapping_tagged(mapping, PAGECACHE_TAG_WRITEBACK);
> diff --git a/include/linux/exportfs.h b/include/linux/exportfs.h
> index fe848901fcc3..218fc5c54e90 100644
> --- a/include/linux/exportfs.h
> +++ b/include/linux/exportfs.h
> @@ -221,6 +221,7 @@ struct export_operations {
> #define EXPORT_OP_NOATOMIC_ATTR		(0x10) /* Filesystem cannot supply
> 						  atomic attribute updates
> 						*/
> +#define EXPORT_OP_FLUSH_ON_CLOSE	(0x20) /* fs flushes file data on close=
 */
> 	unsigned long	flags;
> };
>=20
> --=20
> 2.39.1
>=20

--
Chuck Lever



