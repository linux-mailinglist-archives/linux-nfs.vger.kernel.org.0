Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F27C4489BBD
	for <lists+linux-nfs@lfdr.de>; Mon, 10 Jan 2022 16:02:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235067AbiAJPCY (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 10 Jan 2022 10:02:24 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:16284 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235033AbiAJPCY (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 10 Jan 2022 10:02:24 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20AE36FA024778;
        Mon, 10 Jan 2022 15:02:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=G1OpZDRyXIE8fLKvfbtKF/WVfOy/66yJIZFCpA/ezr4=;
 b=lSmbSpq2lYxTrOjidSWwJo/lWqP09Zmw2oCPiZqCagA+EN1K7x/6oQmg0D6bxMXhzq1r
 kXusxhc1lylcRZn2KNrj6sRsITqisMQFT4flGNzCF17iMeX+RTaE1Etujem+xcpBiRZo
 o1G6bP0qlFkSxr1Scrz3sbiQn2FKwAumEPAD/43EIYVfZuyw2zFmoyg44rsfGUgiS6lL
 Dbz3AzZSx1lB3OVk/b7oogQ6Trrb5FwU7oMY3Byfbkob3c2G5R0MzgsGCLSYNcWLlB0E
 vcMpXKQBDvC0ADQ1QDJy925gS41LPrOIiyoNE9fOZv4fZxTD5m77CIYWqd3ul2P+KYkL ww== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dgp7ng5ht-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Jan 2022 15:02:17 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20AF0PNX161038;
        Mon, 10 Jan 2022 15:02:16 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2047.outbound.protection.outlook.com [104.47.57.47])
        by aserp3030.oracle.com with ESMTP id 3df0ncp4sm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Jan 2022 15:02:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ET3x6zw/GcEJBKTW7o8+N1O25JNZeCht+KllXAJkWxDAzV+BWajGHK62JhVevZpjgzm78GJ02htivrKr+sJja2hauiAhpFFOUS4siujxT5vb/g9cVBhilkb2XEwyJ6H1g0yvFdg/ZB7fJAT7oLWpNFAKduc6Wm8LSF5UHv6TrIo0sqn9MmSR+mjfQjw5basQPjJT4efzP10ZobidB3LmDGjvlg1nf+YRQ9WKaKNF75zWlMf4tfs5HjROaTXQ8GSIgEMYFl1W91F0vaz/bkkcdceMmLurmooBM08Lz2rM96m81cP9JbGEikTX+Tu7GXg5W3bDmIij3gGNHFWhbI8TzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G1OpZDRyXIE8fLKvfbtKF/WVfOy/66yJIZFCpA/ezr4=;
 b=RyLs7lRk2GPvP2cgEt/tDKIdaRMzK2U1yEEp4GX5De33nBa/gHbR5nxZrugjSnaWBxSUrFyAw1E4Z4hOWPAopiwiZJcI1Qe01TcqyZiiC07S2a3T4RvD6U3dAsE8/CgEpuJ40WZvc3FZb1eH1Mdu32QOyctXsNA90rcdcg4QlQ3DNxZQLrE1U+u+7gsafv1E92tk8fDsbZuOnqD9Q7r1SOaZBtGRAcex0nL0XMTF+ZgoBlxf/sPoaahksUkXFkU/ZO6/IL+zTdrT+Qo/xe1VBCfU5o7RBwvqT9tCdeYdhwsdxNI1HzVoU0dDv6Qx9rW011jbBdU9nUOOf8cdF8iokw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G1OpZDRyXIE8fLKvfbtKF/WVfOy/66yJIZFCpA/ezr4=;
 b=nCTPf5b4a/ZOx8CU3CnMvOge+QHAe3rL51AVyDeRyLXWPX8eMFtikVuK5U33vpzfti18nmFt5RJlxZEXpTA1jA928tWNePVoqOcO3XsfAeKEh7CCeyX1O26ZDk79fhZbNhzMhBpJfg+/bwtCvVzSCi9UWSg1WNpgZCbKU+DFDKE=
Received: from CH0PR10MB4858.namprd10.prod.outlook.com (2603:10b6:610:cb::17)
 by CH2PR10MB3862.namprd10.prod.outlook.com (2603:10b6:610:8::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.9; Mon, 10 Jan
 2022 15:02:15 +0000
Received: from CH0PR10MB4858.namprd10.prod.outlook.com
 ([fe80::241e:15fa:e7d8:dea7]) by CH0PR10MB4858.namprd10.prod.outlook.com
 ([fe80::241e:15fa:e7d8:dea7%8]) with mapi id 15.20.4867.012; Mon, 10 Jan 2022
 15:02:14 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Ondrej Valousek <ondrej.valousek.xm@renesas.com>
CC:     Bruce Fields <bfields@fieldses.org>,
        Trond Myklebust <trondmy@hammerspace.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 1/1] nfsd: Add support for btime
Thread-Topic: [PATCH 1/1] nfsd: Add support for btime
Thread-Index: AdgGB5B4QwuMm5tYT+mNbyLUFc83FgAK3ycA
Date:   Mon, 10 Jan 2022 15:02:14 +0000
Message-ID: <AEC24099-5BC9-49C8-B759-920824F23F3C@oracle.com>
References: <AM9PR10MB5099EBEF0B0EC919065D840AE1509@AM9PR10MB5099.EURPRD10.PROD.OUTLOOK.COM>
In-Reply-To: <AM9PR10MB5099EBEF0B0EC919065D840AE1509@AM9PR10MB5099.EURPRD10.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a664e776-e4f0-40cb-22c3-08d9d44a301f
x-ms-traffictypediagnostic: CH2PR10MB3862:EE_
x-microsoft-antispam-prvs: <CH2PR10MB3862F7F333AD06E1AABD790793509@CH2PR10MB3862.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pnVJOCUMgGpkRx9WIaidZicpK9UyArk0DtNoWY83W6eFg+DN4Q1JfrLvbHEM5vP/QKWVPJTOJCAygWF8HiGXI3XoQZ672Y0mzLhnW9Ftgr8uko4UHJVmpEG/Ns1pjXvH8ZNvY0b+oaoVVX7OKYTCZulnZIGXte+fuT9r2agJ4jnddibZ5nq/9mPgfurrUfumiCVlIFsoHodXI1w9r2Jtw3VJWhWqkfEEJdhk/zhDVjt0dLeIBD1brVvWf/nJbqMSxKAXvYmdjpnCreUt3S467PMdiLuDUYTgIGzTf3hNaLKtvbtJDTyJ2EH90gLc4RrRUaMhunZa1Pvs+4/3UIHIaeC5r/1OAiOYQcLt1+XzWPn8NEtAD0rKx0DoUF2DnedJyQ4kQRcKJX5sP7RXGZIm1C52MaFWcRetfF3ffpLzFIA1umAjv4UpvS90rERumWsdDHZuUPJDWW/gLm8zxedlO3p9tWlvIcs7S2GepONsTwvU8KIKzWukFc0KpVbq5gN1uzEgU5WaiuF4i0RmZB4zMGaMQq6SlT3Y+vJnDmhKjRNgxDejCPhaLeQb63nqy77wAcXrDy9++7zcZP7ai6SZ4XQ5MtsISCwxZ7Fmz7+8vnOzKOoLm0KAoBoKWHPnRz3eH71J91b56AbdOtWWm9idtbiPah6ot3pWLHmDgNNNxHeJVf4yokdpwMUht5/tAqA8MZn3xiebRi2A2LFo+8L3SnApdBj3TfleCZtsAxE7pb7uD71FlgoxBFSVXT+WfYaY
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB4858.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(38100700002)(38070700005)(122000001)(26005)(86362001)(71200400001)(6486002)(6916009)(33656002)(5660300002)(2616005)(83380400001)(4326008)(2906002)(316002)(53546011)(6506007)(6512007)(54906003)(186003)(508600001)(66556008)(66946007)(64756008)(66476007)(8936002)(76116006)(36756003)(66446008)(8676002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?9kwR7RqsuzrI2bt1ZtsWG8/KFBYwtrVOU6xF0Y91LhPdZImnvmnKwH7HeU/n?=
 =?us-ascii?Q?tn9T9fuDUMOj1p1ozsE0s5XRWv3to09fJwQp03RkhtPBjd9EClnEbOImgFUZ?=
 =?us-ascii?Q?5zSXraO7zOSCFHjZiinnQET/dL+ERAZ3f3VSI46X7cpVTwwGcH3aA4nJX0xM?=
 =?us-ascii?Q?mrXcZ4GCuZ2E1kYN96E6MWPezGx8P/rvA+u8mm0dYuyGUDoEjwzZE8q6PWwD?=
 =?us-ascii?Q?JNBHFKzkc40diYrQHYJGcgNbqe34Eaht/uK62UBgDag31nWS4j3AvqfDZw3b?=
 =?us-ascii?Q?7yry/Qz4WNqUclDu5nm7TSrwCOwc8kV377S4dKs5X9xs9bBQGqkendg+XSVe?=
 =?us-ascii?Q?b/UBQigQBwONeGQsk3sLcdyMiqhA4x7hzlUmaynWc7clYyxl3v6Z+vSlSuYk?=
 =?us-ascii?Q?WqNn2SBovQgr/U2I647crHDMEmCzjhKgFY+AOoG1S0RIpYAMpwqRvwH31aDK?=
 =?us-ascii?Q?12HMI97rsGDfid54mBIQd0D3WpeBhTQw8kfF/dsNbtb5ZxEdgDvyYkQDduXa?=
 =?us-ascii?Q?XulqRR3b6CCiBsTKn8cR+cWOUUTUiT4b/B3KA+TkGRUyHVo9JtMWPR5ye/e6?=
 =?us-ascii?Q?PAyGc5y7+g9hVjtITtGZQvjIw+2zVAUpRu6QFo5J1Gr7E+2O3KpkNAsPlQ48?=
 =?us-ascii?Q?aDVz47HW26+Imh5xRYTufgMQNneldOIUJ8LFiIrQtwmhZ1vH1dWBqWF5WRQ2?=
 =?us-ascii?Q?9LNcvsrNos2A3vBM1TA9ZpIZ6vhzObgV/ZQXr64J+eph/tP8o/eDfcDKrj9V?=
 =?us-ascii?Q?AGZC8uA9CXLjDNHvuxgzMzkHLlt59CnsPPezQozTkXnihT9/xuaeaEIeXjr/?=
 =?us-ascii?Q?t9SJWmgRHSmpagKazlXZnqoHOOvY5fcpKR+UPabq6GkzIAmhPyUJdNln8UMV?=
 =?us-ascii?Q?YmTxy7OibyLh2OU3sEYiN28nTPrAsXdedbLrGjbprHIifkRF6+2wBTBdzK0H?=
 =?us-ascii?Q?F1hYUN8gu6XenL1z+/WtJN4k1zSo/zLeK5AyGnEXX7oRwzD2IWXZ3qMI/Vx2?=
 =?us-ascii?Q?86ogTjcnfT4gem+V1efxG88L8qH6R0WLcpzClXZvKUWTlqdTIRxavdii0LgW?=
 =?us-ascii?Q?Zzjy0pfSKWeUepo3sdzq2+J/jGE29tzH4ZljS+sKrlaYI6DYnbZZJxTikO6j?=
 =?us-ascii?Q?2peBDSGY60JCqpMW4FsO0FW1cJiVHyb9LV6aszU4CchCm1v9eSQOyHQZVfjT?=
 =?us-ascii?Q?6S3zru3yiHRYc3O5NPDyMA4YmPQ7CzmEXAGw6RFrhwKFO7csGFU4USC69pF4?=
 =?us-ascii?Q?pHd72czNOuJUTvdNqKlI3R/xj2vmpq/ego/NWAixOX0nLzbJFUzoI7cg7nIy?=
 =?us-ascii?Q?ZhvWo7qYZz1y2PMTeL7fmEUerzGFxCspyqT/3l12wAQXoo8bxcXKOh94cmT5?=
 =?us-ascii?Q?xKbz/T6zRxNq9MMVnT/4IzihnXu3+M5hDqW8Dpoy+68GurSxH8Y8CJ2Ieqlj?=
 =?us-ascii?Q?hEWyYJBjGRnRdtndqaIJLU5swFo7OrQsYlod3F6SBZOmeAns53gApA1bmp2I?=
 =?us-ascii?Q?2Yg29zjkfMboVWzWGEfaPjJYQKewDLkFOQWZ3lIZx3MGERDVG2BLW1cfp7Aa?=
 =?us-ascii?Q?3pKDLB6RXdIZ9YOjxkcTrID/kX9g0jsPU9JcpJDMNKUYZdGUUgZkxL2HAKlh?=
 =?us-ascii?Q?vc9IFBtU7O0+6p/ukx9ooGU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3DB6CE1C6E0D334B9C34888A4601D60D@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB4858.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a664e776-e4f0-40cb-22c3-08d9d44a301f
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jan 2022 15:02:14.8870
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ehDvn8a4UZ9Fk6Be6fPewuWU/uzRHRSwEvYvbEBWa1dBga4xNLzfqifX4fYBroHaOWFbhbQ0sXm+oX6/PZKnrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB3862
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10222 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0 spamscore=0
 phishscore=0 adultscore=0 suspectscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2201100106
X-Proofpoint-GUID: zHcAMd9iMsECwSWux3fcTHvV4f2Ldj1v
X-Proofpoint-ORIG-GUID: zHcAMd9iMsECwSWux3fcTHvV4f2Ldj1v
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Ondrej-

> On Jan 10, 2022, at 4:53 AM, Ondrej Valousek <ondrej.valousek.xm@renesas.=
com> wrote:
>=20
> Hi Bruce/kernel maintainers,
>=20
> Please help to submit the following patch into kernel.

This version is better, but there are still some issues (all
fixable). I'm guessing you will eventually want to submit more
than just this simple fix, so I'm going to give you feedback
instead of just fixing it myself. If I'm wrong about that,
let me know and I will apply this by hand and we can be done.


> Legal stuff: It is OK for Renesas to submit this code into kernel

Thanks for checking.

Regular contributors generally don't have to check each time
they submit, but rather they have "blanket permission" from
their legal team to submit to the Linux kernel... So if you'd
like to continue submitting, do check in with your management
and legal teams and make sure they understand what's what.


> - and besides, it Bruce's patch in fact as he told me what to do.

To indicate this, you might add:

Suggested-by: Bruce Fields <bfields@fieldses.org>


> Signed-off-by: Ondrej Valousek <ondrej.valousek.xm@renesas.com>
> ---
> Short description:
> Adds support for "btime" fattr into nfsd

Our tools use the content of the Subject: line of the email
item as the short description. You don't need to add it
separately. The Subject: for this email is just right.


> Long Description:
> For filesystems that supports "btime" timestamp (i.e. most modern filesys=
tems do) we share it via kernel nfsd. Btime support for NFS client has alre=
ady been added by Trond recently

When submitting, this goes before the Signed-off-by above,
and it's typically wrapped at ~72 characters.


> diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
> index 5a93a5db4fb0..876b317a4cae 100644
> --- a/fs/nfsd/nfs4xdr.c
> +++ b/fs/nfsd/nfs4xdr.c
> @@ -2865,6 +2865,9 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, struct s=
vc_fh *fhp,
>        err =3D vfs_getattr(&path, &stat, STATX_BASIC_STATS, AT_STATX_SYNC=
_AS_STAT);
>        if (err)
>                goto out_nfserr;
> +       if (!(stat.result_mask & STATX_BTIME))
> +               /* underlying FS does not offer btime so we can't share i=
t */
> +               bmval1 &=3D ~FATTR4_WORD1_TIME_CREATE;
>        if ((bmval0 & (FATTR4_WORD0_FILES_AVAIL | FATTR4_WORD0_FILES_FREE =
|
>                        FATTR4_WORD0_FILES_TOTAL | FATTR4_WORD0_MAXNAME)) =
||
>            (bmval1 & (FATTR4_WORD1_SPACE_AVAIL | FATTR4_WORD1_SPACE_FREE =
|

Your e-mail system changed the tabs to spaces, so this
diff doesn't apply using "patch". Have you tried sending
the change using "git send-email" ?

Again, if that's more than you feel like dealing with
right now, let me know and I'll apply by hand. Otherwise,
please try again using our preferred tooling. That makes
life for maintainers a little easier.


> @@ -3265,6 +3268,14 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, struct =
svc_fh *fhp,
>                p =3D xdr_encode_hyper(p, (s64)stat.mtime.tv_sec);
>                *p++ =3D cpu_to_be32(stat.mtime.tv_nsec);
>        }
> +       /* support for btime here */

I'd prefer if you removed this comment because it states
the obvious.


> +        if (bmval1 & FATTR4_WORD1_TIME_CREATE) {
> +                p =3D xdr_reserve_space(xdr, 12);
> +                if (!p)
> +                        goto out_resource;
> +                p =3D xdr_encode_hyper(p, (s64)stat.btime.tv_sec);
> +                *p++ =3D cpu_to_be32(stat.btime.tv_nsec);
> +        }
>        if (bmval1 & FATTR4_WORD1_MOUNTED_ON_FILEID) {
>                struct kstat parent_stat;
>                u64 ino =3D stat.ino;
> diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
> index 498e5a489826..5ef056ce7591 100644
> --- a/fs/nfsd/nfsd.h
> +++ b/fs/nfsd/nfsd.h
> @@ -364,7 +364,7 @@ void                nfsd_lockd_shutdown(void);
>  | FATTR4_WORD1_OWNER          | FATTR4_WORD1_OWNER_GROUP  | FATTR4_WORD1=
_RAWDEV           \
>  | FATTR4_WORD1_SPACE_AVAIL     | FATTR4_WORD1_SPACE_FREE   | FATTR4_WORD=
1_SPACE_TOTAL      \
>  | FATTR4_WORD1_SPACE_USED      | FATTR4_WORD1_TIME_ACCESS  | FATTR4_WORD=
1_TIME_ACCESS_SET  \
> - | FATTR4_WORD1_TIME_DELTA   | FATTR4_WORD1_TIME_METADATA    \
> + | FATTR4_WORD1_TIME_DELTA   | FATTR4_WORD1_TIME_METADATA   | FATTR4_WOR=
D1_TIME_CREATE      \
>  | FATTR4_WORD1_TIME_MODIFY     | FATTR4_WORD1_TIME_MODIFY_SET | FATTR4_W=
ORD1_MOUNTED_ON_FILEID)
>=20
> #define NFSD4_SUPPORTED_ATTRS_WORD2 0

--
Chuck Lever



