Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A0D63F5311
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Aug 2021 23:54:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232915AbhHWVzP (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 23 Aug 2021 17:55:15 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:39472 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232898AbhHWVzP (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 23 Aug 2021 17:55:15 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 17NLZcce029091;
        Mon, 23 Aug 2021 21:54:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=MR9kiWQT8UeQS5SromUviV7frpgupi45E7BEi2s2pf0=;
 b=hgR8/NmhwGofvoeFSLSRT7O39x3sFX5yzhIE3f2orDDJOw1+pDSs3SLm0ePNUUCwwIOP
 8JPOx+wrK1Y50wOa4D3QuG7DbjnS3Wjasp5w3UjjFmqZdVNTjB8s0jlz9aYFG5LAt4zB
 INeElGD2HyFrTsdle0jQ0k8Y0f1+c5YhVP+5rw906/IsLNeqeJbZaCHdPIocTEK8ntG9
 sKvO6Do2p7iTZVzwQWohtpW23X020GfM20MFFbq/PhIYme5WOrZ8msZj76LJsv+9DMgE
 tqoFnLqmJRrRu4T+qe+vFFsRnaKuRXQX8jZe4KUX63Ic9zGR79rotwZdWa/CV8iMec0H 9Q== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=MR9kiWQT8UeQS5SromUviV7frpgupi45E7BEi2s2pf0=;
 b=hWRUwYxt2rXdguK4U77gVAmZBjjQILTPTEvxXsNuyCkuYRT9A6id7n10tlpsSVk5FtpA
 Bl7aGBMziNwuNcSkTMSrZif5l12QzXBm3QK6xrnfzFSO2IGYyhPGuFez5JADY72OyQQV
 UjTkmD1s6OdodRJ8S7MgDCHLeWyRl9NO5uJLVj497sdgFQO8gi9G8o/n6qxnhDz/tvhE
 g2uOgDnTjoaB0AvS++48cqlACTeX0Ycjckbv3rvcCWSXCs+hFMmTiJeVJK7h2kmFYDaz
 8DZzN8fN1JHYPiSAelfBxx7R27EHetRqIZ2RW1DwnJMUuNbuwEoK2vh2g+h/E5dpcTzf PQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3akwfm2rk8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 23 Aug 2021 21:54:24 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17NLpB6N010914;
        Mon, 23 Aug 2021 21:54:23 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2045.outbound.protection.outlook.com [104.47.66.45])
        by aserp3020.oracle.com with ESMTP id 3ajsa438m5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 23 Aug 2021 21:54:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JhdQDoSMy+P+KZ9bCsfeUn19xDjhQWlG+Tg+PI+BCZRQM3xYUS+SoSCIR+kIFV8dCuGx63qApsC8sr6b1QrtHhP+S6jIt4QqwI4nU4L4387H/6lXNsOn//QgUfRdifSTqxzZlJuMvsg24U/klh9pZX7SShyX9n6XmowvuC/ePlYmYMUAQic7lvjUXuhBFsnam4DHkKQbCvzUxI1fGe8hmkGsN6v2UEiCGG6kM+5CTrnFA7zLx7K/6b+arVkUbYEM1/qDn6GwZY0GIdu0KM21C1eU6F9iai+PoSWoVl3BXWGDgl58JZj46irFI30Zf9aLdvvBWf+epS+WswJult1PgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MR9kiWQT8UeQS5SromUviV7frpgupi45E7BEi2s2pf0=;
 b=T0vYTqcAmLMZpKmCPanXwdmOsRNVgPi6KZpNIx5OM/1bVlUirquCborN9sY+KbiOzoWU/a+l5nUq6uxaYo1HKyyQRVfmdc/ZoShOhcl/gBhr34TVcBZclN0GgCRjAU45Umh/5sAbfByE9u5fovEOhp+sZKIocrEDTv8z0TbvTZVj9drMSyqslLmrvJ4otMKWke0YG2xL1YoMlmiXGyT/93mZypY/u7cii4wY3lG9eNu3BxCjVgJ2Ozirckdx/wCHmZLYZgipfrjPO/b8lUSruQHI2X2qIvGR6ib0DNY8aGCqZF8cEUmdAyTCoy4vCA+Q0NWvimWcJ4TbQreGQwRj5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MR9kiWQT8UeQS5SromUviV7frpgupi45E7BEi2s2pf0=;
 b=tX3u8hZSCMhjoqWLPRj06RcKcxc1iIH0EQSYJlnZ/bA8qS1btwsRLCj+h+V6pPnVKNsx6sRY4A53+hJzznYFP1Tsrw0bv0uAe70xouVC8f7pktVTKBVNT3n2YuA1wBbza3HqjDZiyMnqCCh/Jh/zpDbHcB53JejSMk6sfQvORtk=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by SJ0PR10MB5536.namprd10.prod.outlook.com (2603:10b6:a03:3fa::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Mon, 23 Aug
 2021 21:54:20 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::a8db:4fc8:ded5:e64]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::a8db:4fc8:ded5:e64%7]) with mapi id 15.20.4436.024; Mon, 23 Aug 2021
 21:54:20 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Bruce Fields <bfields@fieldses.org>
CC:     Bruce Fields <bfields@redhat.com>,
        Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <schumakeranna@gmail.com>,
        "daire@dneg.com" <daire@dneg.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 5/8] Keep read and write fds with each nlm_file
Thread-Topic: [PATCH 5/8] Keep read and write fds with each nlm_file
Thread-Index: AQHXlgaoDTPabXQqaUuaOjS+9zbjC6t+J7cAgANNsgCAAAB1AIAAHUgAgAATpYA=
Date:   Mon, 23 Aug 2021 21:54:20 +0000
Message-ID: <B4927FC9-0B91-48FC-84B4-3F56CB03747A@oracle.com>
References: <1629493326-28336-1-git-send-email-bfields@redhat.com>
 <1629493326-28336-6-git-send-email-bfields@redhat.com>
 <FD16AB43-CC95-44FC-AB08-159AF5C3CAB7@oracle.com>
 <20210823185734.GG883@fieldses.org>
 <D4CAB684-DE35-4964-AB9C-43FD57FA003D@oracle.com>
 <20210823204400.GH883@fieldses.org>
In-Reply-To: <20210823204400.GH883@fieldses.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: fieldses.org; dkim=none (message not signed)
 header.d=none;fieldses.org; dmarc=none action=none header.from=oracle.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 980ac58d-d133-467e-9af3-08d966809015
x-ms-traffictypediagnostic: SJ0PR10MB5536:
x-microsoft-antispam-prvs: <SJ0PR10MB5536B8631EFC0E1EBC530B1693C49@SJ0PR10MB5536.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JRTuPal82Vr2Jy8uD1nj/d4AL5qeL0GyaaY46WrkPq+qZlzOZVDofi7i5VQjsJ8HcBK+XdOmK1FmvUZjpE29KwDMFay5V/Ia/p2bC/Ne0Z1BICAaIujv3V7G2KdfGARBZ1jBNtsRe3y9bqlb1ZCG+LY8lRsPzvqwOqjNuzTMwKruzD4HGVfDQLMlpgHj//ROcO3bG1pDtqdHiVrRLrZBJHkRbqCcPiS9rJyKnejwGx2cujNO+6Ibx7NxP3asWwYIXRgAqhApwMflBNAzQmEtFlLhZxm0x0ruIbYKodG+mvWd7SLYpFUYDtldtZrQ0pf701oKkShSqRv5B3SWhZPWsBKG3DeaxGumW2pCPwzxbo8ABqDfGO5AmuxYFdEbkWbFZkuMASRm8RxXxlm4zdOkmi5sYOisYg0Kx63qBXpNPSup0vRNZND03t1Wvlh8swjT8Qxz45ywivnW8OrnhYiWzKU7JP6qoiIl8w/DC4aviecv3S8RlZd6KlxIr9ou9QXWQTvEGiwMgbD3iprRYOCQitYYXstnPhw5BrGYIoMjlCKUNCEILk/cFSmZGR4St70XFGYxvMuKyNtV7HncIh8W90qGT/zFhWa/5NeANC3LM/8TpYJCguESuaK1RsAlKrEn63aLSh59R5pd1gXkNE3/higr83qzTpoJr/utmNTAyYHm10dyY4OcqXPwldEUymZ5wP4uJ3sz9qyyVCVdtXB0Tdvr6GIg73i5s5C9nJSVDQSKGUn99c1NR/LM+0c3ZhXr
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(66476007)(33656002)(54906003)(38100700002)(86362001)(91956017)(8676002)(6512007)(30864003)(76116006)(5660300002)(4326008)(316002)(6916009)(66556008)(64756008)(2616005)(38070700005)(53546011)(6506007)(186003)(8936002)(508600001)(83380400001)(66446008)(26005)(2906002)(71200400001)(36756003)(122000001)(6486002)(66946007)(21314003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?6wahm6pMpohfjhwzftJBdWoXhRNrMvMSvUrXe0TAJ2xEvesG7j8DAqTiGo9o?=
 =?us-ascii?Q?98ixXdyd9KFmvPe2fI/orJjmqhrg5PVTN+rbJ8H3kjXaEffG9Dgy7WhvsBfd?=
 =?us-ascii?Q?hyiueU6147KrKUCaW5jYKE6Kd3Yyg75XPpyNT4m0YfmyyC48yYJ5etm9QPy3?=
 =?us-ascii?Q?PD+7OvKhX++bKWaOiB2U0BHqAkDCDmZ7+L2QlxHIb8xQz3NV+jcPa0BlWK4w?=
 =?us-ascii?Q?M0kuhlnEJgF19OdMKGWyPx7vPDeCVU4XlUVzx9aIoeP9McZEelUXEJvivsg2?=
 =?us-ascii?Q?I7Tuwr1T+dbWk0g/VwcYoecvxAwskp9+yn2GEbI8iPovCVp7VLa4Er7hXM5f?=
 =?us-ascii?Q?c82sAo266AHw39M2Hme0gs4Ci/yLTry1W68Es0RAoQ6nkfNPe9Y9h1xJVyTc?=
 =?us-ascii?Q?/3wIuvkioL9tc9VQbT/MMMqXJmG229mDiYupAU46lq+5u7u0NkaaoMRiKuNd?=
 =?us-ascii?Q?7gv6ZeNFeywxqqFBARtiPa8DLFnePQZv3qEhwACiOubTyorzoeo3xLHFwe01?=
 =?us-ascii?Q?0Y7/KcbwCTDlQd9jFpgd54QKe5u/5iMukYiNFfDyngUxEI9UB81DdcOMmdDm?=
 =?us-ascii?Q?cOAOM9XdFfJUosI+KJwO2XvdPUnzYyNoNzbMZ1ojqKUgA9CwmCozLjL71l6o?=
 =?us-ascii?Q?yQd8R6BznfM+cmnfJnauQ/syVQ2oG2U2Ffsx7rPrwIJ2gHKTQH3GNEVbrBGW?=
 =?us-ascii?Q?XEw88GwnaFehJqbtsF756pRxOsO3FaMSDCjWMJBwPHlaZx1di0P+7zbOQ9zT?=
 =?us-ascii?Q?1polMptNrAidfxFlhCRx4bKHdZazYEkkqTbQmPAcwaRpDe55j3hlaefUcpCD?=
 =?us-ascii?Q?Va/EZAQfue3LlIZarBCdC3LUIbrQEAp42dTgOmfHpqC3gJOFNoA+/j88G1vO?=
 =?us-ascii?Q?WwTIs0Dn5Fbc6EnhJzmFj7v6uny0kKAf8Qcq0qXIgLGnPL2/aiaGEoQnRFkG?=
 =?us-ascii?Q?b8oay9db4twuD/CAG6bHz9KoiVxfv6nu9B98DBfz4/d1dLyzyLBplqlXmnQ5?=
 =?us-ascii?Q?VWsACZ+6bRI5yjgssRO4Dtt35e5b2ec361lHL82aE+/j38kAWVtcDIxhrllj?=
 =?us-ascii?Q?/QDftH8rKYjS7u7PyjLd2wdDfbuXQlcAiYcq5pMsU0MX1Do6Tufbzg1vUErB?=
 =?us-ascii?Q?JSAiPl8UsqkfxM+Nfh3sW4Nf4OjZ5n+/Gl8r3THgZc4H88uLvQNINpre/kUl?=
 =?us-ascii?Q?FbFvJUxXJx5f6FwEjjGwmLVAIjF4kaGzvFKSYPuEkRA5xWeDC978291jA5iO?=
 =?us-ascii?Q?f+tvd8ZKXE84v3YkEer/4T4/KufqgV1uy8Ih9rNDpNsyzpflHCVNy5+PsLl2?=
 =?us-ascii?Q?mm7GfinWLm/SdmP0DH6BRKxK?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C867D3C20AA11A439AFA79DDDD68CA10@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 980ac58d-d133-467e-9af3-08d966809015
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Aug 2021 21:54:20.7483
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WhcXPF5aCZ8UFXipe4d6mMRe9fZkUlHJkRjBjPCjLKZlD7fTYXmXvDMVK/FP2aamBCwO/6A6onW9vu+FJvNlOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5536
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10085 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 mlxscore=0 adultscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108230149
X-Proofpoint-ORIG-GUID: Y0cfviMqPfgw9qs_BNJLAtC4TBc9HUuu
X-Proofpoint-GUID: Y0cfviMqPfgw9qs_BNJLAtC4TBc9HUuu
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Aug 23, 2021, at 4:44 PM, Bruce Fields <bfields@fieldses.org> wrote:
>=20
> From: "J. Bruce Fields" <bfields@redhat.com>
> Subject: [PATCH v4] Keep read and write fds with each nlm_file
>=20
> We shouldn't really be using a read-only file descriptor to take a write
> lock.
>=20
> Most filesystems will put up with it.  But NFS, for example, won't.
>=20
> Signed-off-by: J. Bruce Fields <bfields@redhat.com>
> ---
> fs/lockd/svc4proc.c         |   4 +-
> fs/lockd/svclock.c          |  25 ++++++---
> fs/lockd/svcproc.c          |   4 +-
> fs/lockd/svcsubs.c          | 102 +++++++++++++++++++++++++-----------
> fs/nfsd/lockd.c             |   8 ++-
> include/linux/lockd/bind.h  |   3 +-
> include/linux/lockd/lockd.h |   9 +++-
> 7 files changed, 111 insertions(+), 44 deletions(-)
>=20
> diff --git a/fs/lockd/svc4proc.c b/fs/lockd/svc4proc.c
> index bc496bbd696b..e10ae2c41279 100644
> --- a/fs/lockd/svc4proc.c
> +++ b/fs/lockd/svc4proc.c
> @@ -40,13 +40,15 @@ nlm4svc_retrieve_args(struct svc_rqst *rqstp, struct =
nlm_args *argp,
>=20
> 	/* Obtain file pointer. Not used by FREE_ALL call. */
> 	if (filp !=3D NULL) {
> +		int mode =3D lock_to_openmode(&lock->fl);
> +
> 		error =3D nlm_lookup_file(rqstp, &file, lock);
> 		if (error)
> 			goto no_locks;
> 		*filp =3D file;
>=20
> 		/* Set up the missing parts of the file_lock structure */
> -		lock->fl.fl_file  =3D file->f_file;
> +		lock->fl.fl_file  =3D file->f_file[mode];
> 		lock->fl.fl_pid =3D current->tgid;
> 		lock->fl.fl_lmops =3D &nlmsvc_lock_operations;
> 		nlmsvc_locks_init_private(&lock->fl, host, (pid_t)lock->svid);
> diff --git a/fs/lockd/svclock.c b/fs/lockd/svclock.c
> index bc1cf31f3cce..6abbc92b88e3 100644
> --- a/fs/lockd/svclock.c
> +++ b/fs/lockd/svclock.c
> @@ -471,6 +471,7 @@ nlmsvc_lock(struct svc_rqst *rqstp, struct nlm_file *=
file,
> {
> 	struct nlm_block	*block =3D NULL;
> 	int			error;
> +	int			mode;
> 	__be32			ret;
>=20
> 	dprintk("lockd: nlmsvc_lock(%s/%ld, ty=3D%d, pi=3D%d, %Ld-%Ld, bl=3D%d)\=
n",
> @@ -524,7 +525,8 @@ nlmsvc_lock(struct svc_rqst *rqstp, struct nlm_file *=
file,
>=20
> 	if (!wait)
> 		lock->fl.fl_flags &=3D ~FL_SLEEP;
> -	error =3D vfs_lock_file(file->f_file, F_SETLK, &lock->fl, NULL);
> +	mode =3D lock_to_openmode(&lock->fl);
> +	error =3D vfs_lock_file(file->f_file[mode], F_SETLK, &lock->fl, NULL);
> 	lock->fl.fl_flags &=3D ~FL_SLEEP;
>=20
> 	dprintk("lockd: vfs_lock_file returned %d\n", error);
> @@ -577,6 +579,7 @@ nlmsvc_testlock(struct svc_rqst *rqstp, struct nlm_fi=
le *file,
> 		struct nlm_lock *conflock, struct nlm_cookie *cookie)
> {
> 	int			error;
> +	int			mode;
> 	__be32			ret;
> 	struct nlm_lockowner	*test_owner;
>=20
> @@ -595,7 +598,8 @@ nlmsvc_testlock(struct svc_rqst *rqstp, struct nlm_fi=
le *file,
> 	/* If there's a conflicting lock, remember to clean up the test lock */
> 	test_owner =3D (struct nlm_lockowner *)lock->fl.fl_owner;
>=20
> -	error =3D vfs_test_lock(file->f_file, &lock->fl);
> +	mode =3D lock_to_openmode(&lock->fl);
> +	error =3D vfs_test_lock(file->f_file[mode], &lock->fl);
> 	if (error) {
> 		/* We can't currently deal with deferred test requests */
> 		if (error =3D=3D FILE_LOCK_DEFERRED)
> @@ -641,7 +645,7 @@ nlmsvc_testlock(struct svc_rqst *rqstp, struct nlm_fi=
le *file,
> __be32
> nlmsvc_unlock(struct net *net, struct nlm_file *file, struct nlm_lock *lo=
ck)
> {
> -	int	error;
> +	int	error =3D 0;
>=20
> 	dprintk("lockd: nlmsvc_unlock(%s/%ld, pi=3D%d, %Ld-%Ld)\n",
> 				nlmsvc_file_inode(file)->i_sb->s_id,
> @@ -654,7 +658,12 @@ nlmsvc_unlock(struct net *net, struct nlm_file *file=
, struct nlm_lock *lock)
> 	nlmsvc_cancel_blocked(net, file, lock);
>=20
> 	lock->fl.fl_type =3D F_UNLCK;
> -	error =3D vfs_lock_file(file->f_file, F_SETLK, &lock->fl, NULL);
> +	if (file->f_file[O_RDONLY])
> +		error =3D vfs_lock_file(file->f_file[O_RDONLY], F_SETLK,
> +					&lock->fl, NULL);
> +	if (file->f_file[O_WRONLY])
> +		error =3D vfs_lock_file(file->f_file[O_WRONLY], F_SETLK,
> +					&lock->fl, NULL);
>=20
> 	return (error < 0)? nlm_lck_denied_nolocks : nlm_granted;
> }
> @@ -671,6 +680,7 @@ nlmsvc_cancel_blocked(struct net *net, struct nlm_fil=
e *file, struct nlm_lock *l
> {
> 	struct nlm_block	*block;
> 	int status =3D 0;
> +	int mode;
>=20
> 	dprintk("lockd: nlmsvc_cancel(%s/%ld, pi=3D%d, %Ld-%Ld)\n",
> 				nlmsvc_file_inode(file)->i_sb->s_id,
> @@ -686,7 +696,8 @@ nlmsvc_cancel_blocked(struct net *net, struct nlm_fil=
e *file, struct nlm_lock *l
> 	block =3D nlmsvc_lookup_block(file, lock);
> 	mutex_unlock(&file->f_mutex);
> 	if (block !=3D NULL) {
> -		vfs_cancel_lock(block->b_file->f_file,
> +		mode =3D lock_to_openmode(&lock->fl);
> +		vfs_cancel_lock(block->b_file->f_file[mode],
> 				&block->b_call->a_args.lock.fl);
> 		status =3D nlmsvc_unlink_block(block);
> 		nlmsvc_release_block(block);
> @@ -803,6 +814,7 @@ nlmsvc_grant_blocked(struct nlm_block *block)
> {
> 	struct nlm_file		*file =3D block->b_file;
> 	struct nlm_lock		*lock =3D &block->b_call->a_args.lock;
> +	int			mode;
> 	int			error;
> 	loff_t			fl_start, fl_end;
>=20
> @@ -828,7 +840,8 @@ nlmsvc_grant_blocked(struct nlm_block *block)
> 	lock->fl.fl_flags |=3D FL_SLEEP;
> 	fl_start =3D lock->fl.fl_start;
> 	fl_end =3D lock->fl.fl_end;
> -	error =3D vfs_lock_file(file->f_file, F_SETLK, &lock->fl, NULL);
> +	mode =3D lock_to_openmode(&lock->fl);
> +	error =3D vfs_lock_file(file->f_file[mode], F_SETLK, &lock->fl, NULL);
> 	lock->fl.fl_flags &=3D ~FL_SLEEP;
> 	lock->fl.fl_start =3D fl_start;
> 	lock->fl.fl_end =3D fl_end;
> diff --git a/fs/lockd/svcproc.c b/fs/lockd/svcproc.c
> index f4e5e0eb30fd..99696d3f6dd6 100644
> --- a/fs/lockd/svcproc.c
> +++ b/fs/lockd/svcproc.c
> @@ -55,6 +55,7 @@ nlmsvc_retrieve_args(struct svc_rqst *rqstp, struct nlm=
_args *argp,
> 	struct nlm_host		*host =3D NULL;
> 	struct nlm_file		*file =3D NULL;
> 	struct nlm_lock		*lock =3D &argp->lock;
> +	int			mode;
> 	__be32			error =3D 0;
>=20
> 	/* nfsd callbacks must have been installed for this procedure */
> @@ -75,7 +76,8 @@ nlmsvc_retrieve_args(struct svc_rqst *rqstp, struct nlm=
_args *argp,
> 		*filp =3D file;
>=20
> 		/* Set up the missing parts of the file_lock structure */
> -		lock->fl.fl_file  =3D file->f_file;
> +		mode =3D lock_to_openmode(&lock->fl);
> +		lock->fl.fl_file  =3D file->f_file[mode];
> 		lock->fl.fl_pid =3D current->tgid;
> 		lock->fl.fl_lmops =3D &nlmsvc_lock_operations;
> 		nlmsvc_locks_init_private(&lock->fl, host, (pid_t)lock->svid);
> diff --git a/fs/lockd/svcsubs.c b/fs/lockd/svcsubs.c
> index 13e6ffc219ec..cb3a7512c33e 100644
> --- a/fs/lockd/svcsubs.c
> +++ b/fs/lockd/svcsubs.c
> @@ -71,14 +71,35 @@ static inline unsigned int file_hash(struct nfs_fh *f=
)
> 	return tmp & (FILE_NRHASH - 1);
> }
>=20
> +int lock_to_openmode(struct file_lock *lock)
> +{
> +	return (lock->fl_type =3D=3D F_WRLCK) ? O_WRONLY : O_RDONLY;
> +}
> +
> +/*
> + * Open the file. Note that if we're reexporting, for example,
> + * this could block the lockd thread for a while.
> + *
> + * We have to make sure we have the right credential to open
> + * the file.
> + */
> +static __be32 nlm_do_fopen(struct svc_rqst *rqstp,
> +			   struct nlm_file *file, int mode)
> +{
> +	struct file **fp =3D &file->f_file[mode];
> +	__be32	nfserr;
> +
> +	if (*fp)
> +		return 0;
> +	nfserr =3D nlmsvc_ops->fopen(rqstp, &file->f_handle, fp, mode);
> +	if (nfserr)
> +		dprintk("lockd: open failed (error %d)\n", nfserr);
> +	return nfserr;
> +}
> +
> /*
>  * Lookup file info. If it doesn't exist, create a file info struct
>  * and open a (VFS) file for the given inode.
> - *
> - * FIXME:
> - * Note that we open the file O_RDONLY even when creating write locks.
> - * This is not quite right, but for now, we assume the client performs
> - * the proper R/W checking.
>  */
> __be32
> nlm_lookup_file(struct svc_rqst *rqstp, struct nlm_file **result,
> @@ -87,42 +108,38 @@ nlm_lookup_file(struct svc_rqst *rqstp, struct nlm_f=
ile **result,
> 	struct nlm_file	*file;
> 	unsigned int	hash;
> 	__be32		nfserr;
> +	int		mode;
>=20
> 	nlm_debug_print_fh("nlm_lookup_file", &lock->fh);
>=20
> 	hash =3D file_hash(&lock->fh);
> +	mode =3D lock_to_openmode(&lock->fl);
>=20
> 	/* Lock file table */
> 	mutex_lock(&nlm_file_mutex);
>=20
> 	hlist_for_each_entry(file, &nlm_files[hash], f_list)
> -		if (!nfs_compare_fh(&file->f_handle, &lock->fh))
> +		if (!nfs_compare_fh(&file->f_handle, &lock->fh)) {
> +			mutex_lock(&file->f_mutex);
> +			nfserr =3D nlm_do_fopen(rqstp, file, mode);
> +			mutex_unlock(&file->f_mutex);
> 			goto found;
> -
> +		}
> 	nlm_debug_print_fh("creating file for", &lock->fh);
>=20
> 	nfserr =3D nlm_lck_denied_nolocks;
> 	file =3D kzalloc(sizeof(*file), GFP_KERNEL);
> 	if (!file)
> -		goto out_unlock;
> +		goto out_free;
>=20
> 	memcpy(&file->f_handle, &lock->fh, sizeof(struct nfs_fh));
> 	mutex_init(&file->f_mutex);
> 	INIT_HLIST_NODE(&file->f_list);
> 	INIT_LIST_HEAD(&file->f_blocks);
>=20
> -	/*
> -	 * Open the file. Note that if we're reexporting, for example,
> -	 * this could block the lockd thread for a while.
> -	 *
> -	 * We have to make sure we have the right credential to open
> -	 * the file.
> -	 */
> -	nfserr =3D nlmsvc_ops->fopen(rqstp, &lock->fh, &file->f_file);
> -	if (nfserr) {
> -		dprintk("lockd: open failed (error %d)\n", nfserr);
> -		goto out_free;
> -	}
> +	nfserr =3D nlm_do_fopen(rqstp, file, mode);
> +	if (nfserr)
> +		goto out_unlock;
>=20
> 	hlist_add_head(&file->f_list, &nlm_files[hash]);
>=20
> @@ -130,7 +147,6 @@ nlm_lookup_file(struct svc_rqst *rqstp, struct nlm_fi=
le **result,
> 	dprintk("lockd: found file %p (count %d)\n", file, file->f_count);
> 	*result =3D file;
> 	file->f_count++;
> -	nfserr =3D 0;
>=20
> out_unlock:
> 	mutex_unlock(&nlm_file_mutex);
> @@ -150,13 +166,34 @@ nlm_delete_file(struct nlm_file *file)
> 	nlm_debug_print_file("closing file", file);
> 	if (!hlist_unhashed(&file->f_list)) {
> 		hlist_del(&file->f_list);
> -		nlmsvc_ops->fclose(file->f_file);
> +		if (file->f_file[O_RDONLY])
> +			nlmsvc_ops->fclose(file->f_file[O_RDONLY]);
> +		if (file->f_file[O_WRONLY])
> +			nlmsvc_ops->fclose(file->f_file[O_WRONLY]);
> 		kfree(file);
> 	} else {
> 		printk(KERN_WARNING "lockd: attempt to release unknown file!\n");
> 	}
> }
>=20
> +static int nlm_unlock_files(struct nlm_file *file)
> +{
> +	struct file_lock lock;
> +	struct file *f;
> +
> +	lock.fl_type  =3D F_UNLCK;
> +	lock.fl_start =3D 0;
> +	lock.fl_end   =3D OFFSET_MAX;
> +	for (f =3D file->f_file[0]; f <=3D file->f_file[1]; f++) {

O_RDONLY and O_WRONLY ?


> +		if (f && vfs_lock_file(f, F_SETLK, &lock, NULL) < 0) {
> +			pr_warn("lockd: unlock failure in %s:%d\n",
> +				__FILE__, __LINE__);
> +			return 1;
> +		}
> +	}
> +	return 0;
> +}
> +
> /*
>  * Loop over all locks on the given file and perform the specified
>  * action.
> @@ -184,17 +221,10 @@ nlm_traverse_locks(struct nlm_host *host, struct nl=
m_file *file,
>=20
> 		lockhost =3D ((struct nlm_lockowner *)fl->fl_owner)->host;
> 		if (match(lockhost, host)) {
> -			struct file_lock lock =3D *fl;
>=20
> 			spin_unlock(&flctx->flc_lock);
> -			lock.fl_type  =3D F_UNLCK;
> -			lock.fl_start =3D 0;
> -			lock.fl_end   =3D OFFSET_MAX;
> -			if (vfs_lock_file(file->f_file, F_SETLK, &lock, NULL) < 0) {
> -				printk("lockd: unlock failure in %s:%d\n",
> -						__FILE__, __LINE__);
> +			if (nlm_unlock_files(file))
> 				return 1;
> -			}
> 			goto again;
> 		}
> 	}
> @@ -248,6 +278,15 @@ nlm_file_inuse(struct nlm_file *file)
> 	return 0;
> }
>=20
> +static void nlm_close_files(struct nlm_file *file)
> +{
> +	struct file *f;
> +
> +	for (f =3D file->f_file[0]; f <=3D file->f_file[1]; f++)

O_RDONLY and O_WRONLY ?


> +		if (f)
> +			nlmsvc_ops->fclose(f);
> +}
> +
> /*
>  * Loop over all files in the file table.
>  */
> @@ -278,7 +317,7 @@ nlm_traverse_files(void *data, nlm_host_match_fn_t ma=
tch,
> 			if (list_empty(&file->f_blocks) && !file->f_locks
> 			 && !file->f_shares && !file->f_count) {
> 				hlist_del(&file->f_list);
> -				nlmsvc_ops->fclose(file->f_file);
> +				nlm_close_files(file);
> 				kfree(file);
> 			}
> 		}
> @@ -412,6 +451,7 @@ nlmsvc_invalidate_all(void)
> 	nlm_traverse_files(NULL, nlmsvc_is_client, NULL);
> }
>=20
> +
> static int
> nlmsvc_match_sb(void *datap, struct nlm_file *file)
> {
> diff --git a/fs/nfsd/lockd.c b/fs/nfsd/lockd.c
> index 3f5b3d7b62b7..606fa155c28a 100644
> --- a/fs/nfsd/lockd.c
> +++ b/fs/nfsd/lockd.c
> @@ -25,9 +25,11 @@
>  * Note: we hold the dentry use count while the file is open.
>  */
> static __be32
> -nlm_fopen(struct svc_rqst *rqstp, struct nfs_fh *f, struct file **filp)
> +nlm_fopen(struct svc_rqst *rqstp, struct nfs_fh *f, struct file **filp,
> +		int mode)
> {
> 	__be32		nfserr;
> +	int		access;
> 	struct svc_fh	fh;
>=20
> 	/* must initialize before using! but maxsize doesn't matter */
> @@ -36,7 +38,9 @@ nlm_fopen(struct svc_rqst *rqstp, struct nfs_fh *f, str=
uct file **filp)
> 	memcpy((char*)&fh.fh_handle.fh_base, f->data, f->size);
> 	fh.fh_export =3D NULL;
>=20
> -	nfserr =3D nfsd_open(rqstp, &fh, S_IFREG, NFSD_MAY_LOCK, filp);
> +	access =3D (mode =3D=3D O_WRONLY) ? NFSD_MAY_WRITE : NFSD_MAY_READ;
> +	access |=3D NFSD_MAY_LOCK;
> +	nfserr =3D nfsd_open(rqstp, &fh, S_IFREG, access, filp);
> 	fh_put(&fh);
>  	/* We return nlm error codes as nlm doesn't know
> 	 * about nfsd, but nfsd does know about nlm..
> diff --git a/include/linux/lockd/bind.h b/include/linux/lockd/bind.h
> index 0520c0cd73f4..3bc9f7410e21 100644
> --- a/include/linux/lockd/bind.h
> +++ b/include/linux/lockd/bind.h
> @@ -27,7 +27,8 @@ struct rpc_task;
> struct nlmsvc_binding {
> 	__be32			(*fopen)(struct svc_rqst *,
> 						struct nfs_fh *,
> -						struct file **);
> +						struct file **,
> +						int mode);
> 	void			(*fclose)(struct file *);
> };
>=20
> diff --git a/include/linux/lockd/lockd.h b/include/linux/lockd/lockd.h
> index 81b71ad2040a..da319de7e557 100644
> --- a/include/linux/lockd/lockd.h
> +++ b/include/linux/lockd/lockd.h
> @@ -10,6 +10,8 @@
> #ifndef LINUX_LOCKD_LOCKD_H
> #define LINUX_LOCKD_LOCKD_H
>=20
> +/* XXX: a lot of this should really be under fs/lockd. */
> +
> #include <linux/in.h>
> #include <linux/in6.h>
> #include <net/ipv6.h>
> @@ -154,7 +156,8 @@ struct nlm_rqst {
> struct nlm_file {
> 	struct hlist_node	f_list;		/* linked list */
> 	struct nfs_fh		f_handle;	/* NFS file handle */
> -	struct file *		f_file;		/* VFS file pointer */
> +	struct file *		f_file[2];	/* VFS file pointers,
> +						   indexed by O_ flags */
> 	struct nlm_share *	f_shares;	/* DOS shares */
> 	struct list_head	f_blocks;	/* blocked locks */
> 	unsigned int		f_locks;	/* guesstimate # of locks */
> @@ -267,6 +270,7 @@ typedef int	  (*nlm_host_match_fn_t)(void *cur, struc=
t nlm_host *ref);
> /*
>  * Server-side lock handling
>  */
> +int		  lock_to_openmode(struct file_lock *);
> __be32		  nlmsvc_lock(struct svc_rqst *, struct nlm_file *,
> 			      struct nlm_host *, struct nlm_lock *, int,
> 			      struct nlm_cookie *, int);
> @@ -301,7 +305,8 @@ int           nlmsvc_unlock_all_by_ip(struct sockaddr=
 *server_addr);
>=20
> static inline struct inode *nlmsvc_file_inode(struct nlm_file *file)
> {
> -	return locks_inode(file->f_file);
> +	return locks_inode(file->f_file[0] ?
> +				file->f_file[0] : file->f_file[1]);

O_RDONLY and O_WRONLY ?


> }
>=20
> static inline int __nlm_privileged_request4(const struct sockaddr *sap)
> --=20
> 2.31.1
>=20

--
Chuck Lever



