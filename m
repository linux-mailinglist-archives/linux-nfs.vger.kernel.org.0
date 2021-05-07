Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA236376672
	for <lists+linux-nfs@lfdr.de>; Fri,  7 May 2021 15:55:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234758AbhEGN43 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 7 May 2021 09:56:29 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:44088 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234081AbhEGN43 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 7 May 2021 09:56:29 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 147Di39U036832;
        Fri, 7 May 2021 13:55:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=AYnF/ke1rRfeCrg3LcQ8P4uoLTWVmFJjhL2oPk0TsnQ=;
 b=JX+bp+RSTW+T/1SkP0oONn2ViHS6qC1ibr5kqXd8LemjvBfHqXVFL1mdZlYpK8Vewr3G
 NoD3q9D6b/zcZK0SVE5MsY81oc4W/IJ7/kbLBT6rFArXKD/Z4ovhznNMs/a+Q+9BNSqX
 WJWvP1S6o02qssquga+2PtyJ3bt++usaWuSGcC1WiiHMDWRejvoPWY2kN4t5J4eKP3S1
 W6d49mykpFlfxcn5s1RUnPLOphhzNuxa1VGXeIFep+mf1XzcB51LQD4I3GHMXVeaI28I
 kBiv1b6rQWlpdUhAcg7nPgXI5UGvXeuM4O5Bj5DR0o6ewKfqaIufcLNPOAHGx5IkQ1j3 tQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 38ctd89myu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 07 May 2021 13:55:20 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 147DlkfL162105;
        Fri, 7 May 2021 13:55:19 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2173.outbound.protection.outlook.com [104.47.56.173])
        by aserp3020.oracle.com with ESMTP id 38csrtg3gp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 07 May 2021 13:55:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S3daoEpDWbTUQa83VTdaXZHtBMvCB0Z7rTQtD3SjohrKLGROXGImuN6ACh8cCTukmKCNFBWTnVmLogRxbJK2wh6XxJJaBciPrbCs7XCT5CWE/KEZXxhHwmJimb9LCGT9RpeKaa/uOOoRcL8BLF+RooNlOXABdzfgd32DPswOIhOJFPjcS3OmMY+x3t/9uegCXvSoQcVEd/pOkgmNRNM9AQ4FDgv/IFVUupGpINucZO1R7+Q2fhjI+SjD6n82iG58Ivfj0LJ58rLOObls1IX2uf1DzveIDAXjQSSbiZUVW3aLa7jBEzUICeff7F5uEOtXh9SB/HRBfGHxYTCp7oWtWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AYnF/ke1rRfeCrg3LcQ8P4uoLTWVmFJjhL2oPk0TsnQ=;
 b=ivDS5OfvPH8qkUObGCxJ5J8ckvUh4UwK+DuF0iwVit8/vaChLWek+uU+dDTukzPT5l+tzTOx0KS/cy9txVkKlagqfgyDHLhJ0QNSF1oEWfT4gWMeK/ZIUvv56shpvQiWETepBLrmgtlOlheI8flGJmeOHyUkxDL8bSPdG4u1WL12ohXO+Mths9Zf5toUXkt2nFb8TUSaLE4uFBkdj3Ti8gVKpk79MmuPZ0mx5H214iQlsM/JexMQBlZnvq4qDKNE8y690PZgxAJK74qG7hYPScB+4gIwp6hjACyfGDZQXkkzI975t1LKwD9aokRaWZZLpaIAnnfP4fInJyh8FPCIOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AYnF/ke1rRfeCrg3LcQ8P4uoLTWVmFJjhL2oPk0TsnQ=;
 b=IIoQ9FCbZV6K5k4FgGQNRlrBoLrBUGkwqAcuAf0XKXr0pqi3vh6LxEst7lAucq3GoND+hOhlr507btZdZUiN+e/eSwN499UeSh46qyQ2/cqNUItmYHZmWvXqD/bFo6ssmBaGBJyg0eYoRZIZ+IC9ip0G8iuWhdEFt3h6i1zsfY4=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by SJ0PR10MB5485.namprd10.prod.outlook.com (2603:10b6:a03:3ab::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.26; Fri, 7 May
 2021 13:55:16 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::50bf:7319:321c:96c9]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::50bf:7319:321c:96c9%4]) with mapi id 15.20.4108.029; Fri, 7 May 2021
 13:55:16 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Neil Brown <neilb@suse.de>
CC:     Petr Vorel <pvorel@suse.cz>, Bruce Fields <bfields@fieldses.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Steve Dickson <steved@redhat.com>,
        Alexey Kodanev <alexey.kodanev@oracle.com>
Subject: Re: [PATCH/RFC nfs-utils] Fix NFSv4 export of tmpfs filesystems.
Thread-Topic: [PATCH/RFC nfs-utils] Fix NFSv4 export of tmpfs filesystems.
Thread-Index: AQHXQuMiXfq5XDoV1UyaLfWrKHICQKrYC2+A
Date:   Fri, 7 May 2021 13:55:16 +0000
Message-ID: <A4E16B80-F754-4F11-9689-C2A4E5588019@oracle.com>
References: <20210422191803.31511-1-pvorel@suse.cz>
 <20210422202334.GB25415@fieldses.org> <YILQip3nAxhpXP9+@pevik>
 <162035212343.24322.12361160756597283121@noble.neil.brown.name>
In-Reply-To: <162035212343.24322.12361160756597283121@noble.neil.brown.name>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.de; dkim=none (message not signed)
 header.d=none;suse.de; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [68.61.232.219]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4c8776a7-6987-4312-ffca-08d9115fbe5f
x-ms-traffictypediagnostic: SJ0PR10MB5485:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SJ0PR10MB5485843637E263AC2AA06BCD93579@SJ0PR10MB5485.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nB0YjZJORgglc/PJNlNqnXTwzMioQAmmK7Ioswa748Cmhlm8azc5FPpZ0mIKPfiB2kfjb+DIDBH/1ZEqe+l2X1oyOYCiiomYP87mgv4JrJqtZT5aZ3kOh8Wtx86L2j/IUodAGRg7SRkebvTQMZlWv5m2AeVe1V4zEZZI5nVkoSygHHUAdtls5p2wRZL+UvW6ga/RkQ10UIbqrRHnWgySPhmD/o2ak1/UQey9PdkrXtwwxy+OnciyRBIBorRDlBM2I09XEpmqfQ+Ogq+uXnfldQk2eSH8rg9rWGZywYu58JM1wA6kURR1bcns0wsBwKIG5XEn3S4bn5wRGso4LIXHSz/WSEM5ZSOpD7PAs61ayNW8NP5J4LE7ZmLOksTVoc0PB+gAtFFxjBnHAedgDz9UeTFU9C0Hc32xJ2krLHNbYlETXmixMKtueJxAGMFsDTb0XqapagtCBweG6c/2vZKZMKCXFa9TyVUk2AJ7LBPsZUATLkqTjc16XmaoJAR8sqFiEw80OEv4LD7m2oa1wHf7YuVrX9+F7F0lfBjwVhoEzbI72a9yO01qQCHcI5Jh2P8UkABpnjd6fc3i8yD9bOXzCQXeQMHvKbuPWulwDTAvuzE65VasA9KETR3qOkNqNzZrx9fgwKpNXSH+npRzOsT/vh3BY5DvtFVdRRN4/u82pYo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(376002)(39860400002)(136003)(396003)(346002)(71200400001)(107886003)(26005)(6512007)(122000001)(5660300002)(36756003)(6486002)(53546011)(38100700002)(2906002)(6916009)(33656002)(316002)(54906003)(66476007)(8936002)(6506007)(4326008)(83380400001)(76116006)(91956017)(66946007)(66556008)(64756008)(66446008)(186003)(8676002)(478600001)(2616005)(86362001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?Q/OIqBQsVJparo6HwVsNULiHQF8tU/sQINPTR/dV/XEFZGqjY67XpwVD49wo?=
 =?us-ascii?Q?6hUzvchMmbmV7LQdYsmfmty83itKn+nxxw1WkNdj3oNf4A5Snj4mzF4PBzhd?=
 =?us-ascii?Q?cKUULX8gwN+JeHi4Q9lahJ79OVrZBuhexk2YYWB9nG4fDEDBHupRzdTJmSfO?=
 =?us-ascii?Q?tNqCf5QDDTjYhwrcYt3K2aB3CJ5NFxkdChaaNsT2wcnT3oN/fmCZ59mtmibG?=
 =?us-ascii?Q?iUSiF6gpc5/H/g00OMHHxXg3I+2CPUGvVG1ZVjS/YbLDJsRm7Jc2r2hLeynz?=
 =?us-ascii?Q?yONVFkBGp9X30OG9bcnzOo89vpjvmauP+b0lhUgOmoiB9L6CExd/ltyUECeM?=
 =?us-ascii?Q?XyEpMs3JF+qhwXHbqcaKeONb7AKSIsRBxKtCHoek/f2xHLj+8EjCkQOBS8yB?=
 =?us-ascii?Q?wz4xCPS4/YwGsWQuBnCaTcS/wpMMADhByl59jPz0ScRj8sBCfSsq+Ps278nJ?=
 =?us-ascii?Q?mif3RFHnKQwQP2Cq3fXh/CyM7l38+s3EWGcaceOUOQylom8sJNwV9JyHrJ04?=
 =?us-ascii?Q?+Nd9uXuhGEB4rnIAgRUesESm9Rd8+Oe0/mlOG0BIKVtmLwiG5vUK74o2IQvJ?=
 =?us-ascii?Q?DMtCE/7ZYiKLw2qimC202t2r2Pe+GhwEET9IeMWiZr2xXNPw674K9wBMTJdK?=
 =?us-ascii?Q?Kc/LoPE8EnEoL8kEjV2daiGog4MEIJZPo+qBl9taAqEEPXDAtOZahNG9nL9x?=
 =?us-ascii?Q?+u0tqmKl0ZAmzuelu2NHRKHBn0V8cJBFBUl5QAYhAMC57tdIfI13JKIJAPhG?=
 =?us-ascii?Q?b73gF1gckiOVk/Vj8jhfqTed8IaxQlD6ZIHs8XLwguxI2/hGNZwcwHOyjcva?=
 =?us-ascii?Q?kPtOgAr1mu2D+Kd9Sj+bRpnpcGykKe1fj6CrHnbr2CYEnUI+7twMy2lQuwIS?=
 =?us-ascii?Q?WGstx4uoVtWRRov+U/zaOFaLzGOwTj+/TFcVlacGcxLanbefOmYS4IxZAq8w?=
 =?us-ascii?Q?4wltZA2rerhyCez5OAX6CW35sPpGkPLJAuwnaLkGICnCFDDbMeCqghboxjtU?=
 =?us-ascii?Q?JXwo1CMFrRmsrdLQXxjFothgrQlcNLdMXll+RNpMX4MFCV8hhWGH58yzXuUT?=
 =?us-ascii?Q?yuDP5ryu70pjMQsIg+9rrIhAyr5RzzVNbvJ82u8MwYDkDif3ZVdcMI76x/oC?=
 =?us-ascii?Q?G7/GV2IjgXa1IxNza1/j7jMl5WShxKdAOqFKxiIgwENbADqxgcAnl+nUbkXF?=
 =?us-ascii?Q?F/XmHJfUpV9sbAAv0Y7x6sJbnCSPNc28YEg+jTrb6K9XrrtAw0/R3YgJQRGO?=
 =?us-ascii?Q?H4PcjW929hmQabSaov0SUoasQRAT6D9jJhbsHZs1fbSNPy+p0+UcFbesPQcZ?=
 =?us-ascii?Q?dikmTtOeuC5G7vcI3rTRk+0j?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <28C26E98364F924D944EEAA5CA24627D@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c8776a7-6987-4312-ffca-08d9115fbe5f
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2021 13:55:16.2018
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cUt/J5Rg5ui/sVvASDGzmzyRZQcnAoypMLHArvsKv7tVEhpwUYom8270WknP9N1/qT0U2091z9f+W3gRkrf2qg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5485
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9977 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 phishscore=0
 spamscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105070095
X-Proofpoint-GUID: 5smi41rr_WozuWak2Exaha9HmA18GW9Y
X-Proofpoint-ORIG-GUID: 5smi41rr_WozuWak2Exaha9HmA18GW9Y
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9977 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 adultscore=0
 clxscore=1011 spamscore=0 mlxlogscore=999 priorityscore=1501
 lowpriorityscore=0 phishscore=0 suspectscore=0 impostorscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105070095
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On May 6, 2021, at 9:48 PM, NeilBrown <neilb@suse.de> wrote:
>=20
>=20
> [[This is a proposed fix.  It seems to work.  I'd like
>  some review comments before it is committed.
>  Petr: it would be great if you could test it to confirm
>  it actually works in your case.
> ]]
>=20
> Some filesystems cannot be exported without an fsid or uuid.
> tmpfs is the main example.
>=20
> When mountd creates nfsv4 pseudo-root exports for the path leading down
> to an export point it exports each directory without any fsid or uuid.
> If one of these directories is on tmp, that will fail.
>=20
> The net result is that exporting a subdirectory of a tmpfs filesystem
> will not work over NFSv4 as the parents within the filesystem cannot be
> exported.  It will either fail, or fall-back to NFSv3 (depending on the
> version of the mount.nfs program).
>=20
> To fix this we need to provide an fsid or uuid for these pseudo-root
> exports.  This patch does that by creating a UUID with the first 4 bytes
> 0xFFFFFFFF and the remaining 12 bytes form from the path name, xoring
> bytes together if the path is longer than 12 characters.
> Hopefully no filesystem uses a UUID like this....

That's not really a UUID, as per RFC 4122. I'm guessing it's possible
for a collision to occur pretty quickly, for instance. It would be nicer
if a conformant UUID could be used here.

Is there a problem with specifying the export's fsid in /etc/exports?


> The patch borrows some code from exportfs.  Maybe that code should be
> move to a library..
>=20
> Signed-off-by: NeilBrown <neilb@suse.de>
> ---
> support/export/v4root.c | 57 +++++++++++++++++++++++++++++++++++++++++
> 1 file changed, 57 insertions(+)
>=20
> diff --git a/support/export/v4root.c b/support/export/v4root.c
> index 3654bd7c10c0..fd36eb704441 100644
> --- a/support/export/v4root.c
> +++ b/support/export/v4root.c
> @@ -11,6 +11,7 @@
> #include <config.h>
> #endif
>=20
> +#include <fcntl.h>
> #include <sys/types.h>
> #include <sys/stat.h>
> #include <sys/queue.h>
> @@ -21,6 +22,7 @@
> #include <unistd.h>
> #include <errno.h>
>=20
> +#include "nfsd_path.h"
> #include "xlog.h"
> #include "exportfs.h"
> #include "nfslib.h"
> @@ -73,6 +75,38 @@ set_pseudofs_security(struct exportent *pseudo)
> 	}
> }
>=20
> +static ssize_t exportfs_write(int fd, const char *buf, size_t len)
> +{
> +	return nfsd_path_write(fd, buf, len);
> +}
> +
> +static int test_export(struct exportent *eep, int with_fsid)
> +{
> +	char *path =3D eep->e_path;
> +	int flags =3D eep->e_flags | (with_fsid ? NFSEXP_FSID : 0);
> +	/* beside max path, buf size should take protocol str into account */
> +	char buf[NFS_MAXPATHLEN+1+64] =3D { 0 };
> +	char *bp =3D buf;
> +	int len =3D sizeof(buf);
> +	int fd, n;
> +
> +	n =3D snprintf(buf, len, "-test-client- ");
> +	bp +=3D n;
> +	len -=3D n;
> +	qword_add(&bp, &len, path);
> +	if (len < 1)
> +		return 0;
> +	snprintf(bp, len, " 3 %d 65534 65534 0\n", flags);
> +	fd =3D open("/proc/net/rpc/nfsd.export/channel", O_WRONLY);
> +	if (fd < 0)
> +		return 0;
> +	n =3D exportfs_write(fd, buf, strlen(buf));
> +	close(fd);
> +	if (n < 0)
> +		return 0;
> +	return 1;
> +}
> +
> /*
>  * Create a pseudo export
>  */
> @@ -82,6 +116,7 @@ v4root_create(char *path, nfs_export *export)
> 	nfs_export *exp;
> 	struct exportent eep;
> 	struct exportent *curexp =3D &export->m_export;
> +	char uuid[33];
>=20
> 	dupexportent(&eep, &pseudo_root.m_export);
> 	eep.e_ttl =3D default_ttl;
> @@ -89,6 +124,28 @@ v4root_create(char *path, nfs_export *export)
> 	strncpy(eep.e_path, path, sizeof(eep.e_path)-1);
> 	if (strcmp(path, "/") !=3D 0)
> 		eep.e_flags &=3D ~NFSEXP_FSID;
> +	if (strcmp(path, "/") !=3D 0 &&
> +	    !test_export(&eep, 0)) {
> +		/* Need a uuid - base it on path */
> +		char buf[12], *pp =3D path;
> +		unsigned int i =3D 0;
> +
> +		memset(buf, 0, sizeof(buf));
> +		while (*pp) {
> +			buf[i] ^=3D *pp++;
> +			i +=3D 1;
> +			if (i >=3D sizeof(buf))
> +				i =3D 0;
> +		}
> +		memset(uuid, 'F', 32);
> +		uuid[32] =3D '\0';
> +		pp =3D uuid + 32 - sizeof(buf) * 2;
> +		for (i =3D 0; i < sizeof(buf); i++) {
> +			snprintf(pp, 3, "%02X", buf[i]);
> +			pp +=3D 2;
> +		}
> +		eep.e_uuid =3D uuid;
> +	}
> 	set_pseudofs_security(&eep);
> 	exp =3D export_create(&eep, 0);
> 	if (exp =3D=3D NULL)
> --=20
> 2.31.1
>=20

--
Chuck Lever



