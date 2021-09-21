Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F173413582
	for <lists+linux-nfs@lfdr.de>; Tue, 21 Sep 2021 16:39:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233635AbhIUOlP (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 21 Sep 2021 10:41:15 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:52500 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233606AbhIUOlN (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 21 Sep 2021 10:41:13 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18LEL5Ij004118;
        Tue, 21 Sep 2021 14:39:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=kOhFFm8O+7YVIOMBXSz3kOZT1+ZonbZyOjtBVW6BksU=;
 b=LjAOuQa9e4AIwJR5mp2HWTy+eGH6wXb99jFHp0uJgkgrnjMNz5Mq8ddIA4grddACPGMe
 3bkVbRxFtba4ByQZtO5l68LI67/lOw4mYJ1s3HeBqpgmLjuJ1IZmoN0gFgiXQA4SIVkd
 ZRdkxcFRXr1S4DraV1nOZaxcYI2UgOU0xHZBhmA4/TmfqZmam3vVkZju/U5U2x2H/X/L
 n/WoOWfhPuzvWv8UWyFhYrrQk1388++ABo7tzcMMBP4xzWJkDJrm2R/cZGcu/j3lo1RR
 2FARj7j8ASpTElZcnqo4iT24gA1aRqXuhQkJnH13MQRA/xVpQuAqa+FZKpLNBwLKJ64l hA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3b757vu0j9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Sep 2021 14:39:43 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 18LEUoGo175173;
        Tue, 21 Sep 2021 14:39:42 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2109.outbound.protection.outlook.com [104.47.55.109])
        by aserp3020.oracle.com with ESMTP id 3b57x5k77c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Sep 2021 14:39:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D7UfpZ+7aa0nkLk1ZwOwb5FjWXnOswc5cOwcn2pN/IWg6YekcB7bvNGjkk2p0VqL1F55BhnKjEOvP0mteUiAv+7HiplivPUtupe2Dov+uSre0PUy1VyI2O9IXuKypCQnxUeieeyTX6us0hJOwAJaNIJDh5DCIAj0lxR+EimpYz8Fe/rJ7GzcZcLhtKLy0au1LH5UMeekai6NlGl0H5T3kwB6vXFVm83kVuJt/jNyK654XDG58zTWi1xO3lnFXrk/algzUpbqtFrBQNAWPsuQVJO4ps5EwY09WLCqQqlhVGhzp4ilLfiNdtdCLJ7A0Z+mhPexuiIHq0STSORU5Z7h/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=kOhFFm8O+7YVIOMBXSz3kOZT1+ZonbZyOjtBVW6BksU=;
 b=UvHWOBISQGAX+ffuH02ARW9ISZ9KkWvZCwtMV3CvyNB7bqB3kE4wW10PlSYO9aGCZhzSJKtJUb2bjBcVW2QbGrdRglNnc/H4XkQdYO4PoEX+n568TBQ7pw5zBHDQ+qZv+YG1NFcvhM54b3gdgw/bQ9pDkvum/wJg6gBr58PYo+B3ub9uCJDyximjP8+5uQjMBTGf17tW0Hwf/ikSUcV6inBsgujF+k8n3jXENpoh9LXy966uWsobKTTB8u36H0kYLAis+ecU1hUBN4zbpOHVWBdXfe3PMCjDtjO69A2C4fGL8+UvCXjcs2dZTI5ciUY6zkT1CiBvjSliBXXqeXxVHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kOhFFm8O+7YVIOMBXSz3kOZT1+ZonbZyOjtBVW6BksU=;
 b=aMAYmlVNAzG4UQKqxxdKWKqltLasMkpcbGziq67rrMqb5jNVYhIKpz5b0u09jtpsSqNNmMefLPaiHPWlEWnTwYNuqfg9sdj5xbP6SIvwImvJY0gykMMnHFQ92ijR9RRkaFPIpqlW/N7cNCfCjAIW+kZ+J7EeCkIOI335jJwm+pI=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by BY5PR10MB3953.namprd10.prod.outlook.com (2603:10b6:a03:1b6::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.17; Tue, 21 Sep
 2021 14:39:40 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::f4fe:5b4:6bd9:4c5b]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::f4fe:5b4:6bd9:4c5b%5]) with mapi id 15.20.4544.013; Tue, 21 Sep 2021
 14:39:39 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Bruce Fields <bfields@fieldses.org>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] nfs: reexport documentation
Thread-Topic: [PATCH] nfs: reexport documentation
Thread-Index: AQHXrvWaAWSTDh3zBEqQtD2/lsKJM6uujxeA
Date:   Tue, 21 Sep 2021 14:39:39 +0000
Message-ID: <37851433-48C9-4585-9B68-834474AA6E06@oracle.com>
References: <20210921143259.GB21704@fieldses.org>
In-Reply-To: <20210921143259.GB21704@fieldses.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: fieldses.org; dkim=none (message not signed)
 header.d=none;fieldses.org; dmarc=none action=none header.from=oracle.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6c3628eb-3895-4f33-42a7-08d97d0da4a0
x-ms-traffictypediagnostic: BY5PR10MB3953:
x-microsoft-antispam-prvs: <BY5PR10MB3953A61E6A9DB06D6AD943CA93A19@BY5PR10MB3953.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZB1jAsN1olhBftuCwMzcy54xyyDMGAjeJEdE5/zHa564qZ0ZIZwhsWlqx4slPT/ZfZVMekuxG8dnk5uTsuIAgaaDm+4MfLKNt0BqizMuS1VNECWrDbOpdn34FtKGelMCS3GKaQw7tHSi9SpUAm5yYNOjfBVyw9O+jHCucaEMxEq6GsYkLYgXDBkpyjeYOviutQuVdQzwdv39mkALS1X5lqBIJZlFd/xC1cUoa6e9hWWU8XdtQ6DGSl2pD6YKwg3wm9TDNKDSX2lv64c00lZTyN5gI4be6thHlPY1HEEsIw6r+ut42ZfhE6t+mjvIT0cc0sFYrcDYWzkgoaNZF8dKzgfnVMpHD91aWuBY7+EZou8jLH2IS0xOF1rT3UZFeYne64AhovfUslFuOE/wbK+FS8bSKM21iUNOow6yXCU5V/1eQ5zvmh7RvZeNG89Y2EnKZ+PUDNGXfbjrsmbfjHjveVaTkmiJNpKhFFKXKh/8qPUkLUH+dY+EzDvJViZlZTvJmj0glPOcxSHRV31CL0DsGblVolF2c04ZYhq/QWz0cLVPeZPtBswSs6Hb7nqk2iGyRMLA8SyrIVR8GMh5+4oPH+bWbbwmjNV0EjRI6hLN/qy/dMJQsZon41zditvr5R7kec1leeVhgAjQqZDe06BRPd+fQ9Phi6N7nrSOl4YymJ4tl6V5CGsJSUcRCqSlL9CkhqO1bzke5Ig8kmy59NRz82ALLLeJf7K7+M7/gf5lm7T68vW32Tt+OmE5LribphxjLt+1HaQBTG01qs6fGFnvhkso48Ma9vf1ZPCsYPio3Soq61eUcKIaGaMrOENxUxzA86g3azMcJ+GfhRAjJ3keDA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6506007)(6486002)(71200400001)(53546011)(91956017)(66946007)(26005)(966005)(8936002)(66446008)(316002)(66476007)(66556008)(38070700005)(64756008)(4326008)(2616005)(6916009)(508600001)(6512007)(76116006)(2906002)(83380400001)(16799955002)(33656002)(5660300002)(38100700002)(86362001)(8676002)(122000001)(186003)(36756003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?c3jrwxSbxWXGRlxdrCabH6YhIc+lKSdEEWRXM6fadfbV9LQQALm4xGkHZ13N?=
 =?us-ascii?Q?z7KbkHykEtQzaetiyavG9HKh+vbYFoB/igYKZZ+9wk+c1I6T4ajcf1oiuTEv?=
 =?us-ascii?Q?M2OCXFuKQUlcGBtvNU0LLX/HsiDElN7M3R7wOmIZ+sjtNCorNVhFXnoelfV4?=
 =?us-ascii?Q?dh5jrvU6zwee3/GWTiGIwoansuRfb4umXt0E14eub5XHml48ZUQAz/HOpumD?=
 =?us-ascii?Q?eYqBYCbW0sYRNIxwd7oNZJ6dLUONh95E+SoVNqcVoM7FA7ths90x5bKGkl+g?=
 =?us-ascii?Q?+1JgSfBkVNA9xSkSjJ65qNbLwFRHqaSubmqinVXf+J20ZZ2LFN6e9vssYwDy?=
 =?us-ascii?Q?ZaZyRUauU+acSBhodgd1Hm/h7aQwDpVe++JvIwFZhZiUXyaRGh7QP8QKZJM4?=
 =?us-ascii?Q?bJMDbbJ/VA9aOi4/vHTM+1FiJ69t34tM9euiFjk2Be1uIfvYw8CVvSneE2W6?=
 =?us-ascii?Q?6T7xsIEEFyaPf7eFF6Bxf2OJ+1H7rc6uKBb1f3jVc61n98Lj9Ue9sFl+Owbc?=
 =?us-ascii?Q?n/D2OGKfVv8er8DhOyFmqJUT78A5gpxgE6wEh2jDskLqN5agmodu8MCr3xMW?=
 =?us-ascii?Q?sohCDnSJxEKzO+zq+3mUKNYZct10KvkfMuyyF+cc7NsQhph427e351/SMohe?=
 =?us-ascii?Q?3okJL9maDhjHTOaQQXeIx/1D8YjpEwMm3+etjfm7ohNp5tPb0zbPOM/RHHJ0?=
 =?us-ascii?Q?7wPwE5mpuGBPE+th1kCoB3pntcgE2HZvxObPGLZY1eSuAzEJXMXugcUKoNVU?=
 =?us-ascii?Q?9SvnPGed0Z4rdiG0of+62lrvzb26h0f7FSCVnhBDYGla2In2qQb8k6xtJCuw?=
 =?us-ascii?Q?cOTKF5gmZZaK3A0De9Z34pGvFieyGTvDu3az5xB5hHF3+/aIG8pFP/RTnhPB?=
 =?us-ascii?Q?GToRozvdGz2TysYLeHRUi4jB0oYB9kJg6iIJ5OUsn+HBilhARJ5dLpe7IJM5?=
 =?us-ascii?Q?l9eOuTIX/mkSZRCBBvrAzg2iBC8xO7CbAfDYYzuyBjimIjUfZAIAJZCgNKXN?=
 =?us-ascii?Q?At24DQtFUUDXEo295ZoUi3B5G/Lwva41pmXmVoxauTuGXLAE2j+OJE9VU1j0?=
 =?us-ascii?Q?+XAac8hF+3FhNX5lUvQr8lKs6apgqmE9AC4U3+2KutjusSdKS6GVFhG0iqnI?=
 =?us-ascii?Q?1aIHOcLbBHkFnNmG4LU4dpprdfBEjG+6zPf5XoKMKL+bscUs8SPfdi7muHKD?=
 =?us-ascii?Q?AOFOlz0CU4ow9OE64JjYRBaU0zcsbh7jXw3Pj1ximA+KbQ04JUcvfpUeYv8C?=
 =?us-ascii?Q?C2kSvSMDwnvl3Jzupo5jyuDTkuxRygLwSfiihZ8/8Rv+vTkOC+xGamNrJ+gV?=
 =?us-ascii?Q?Orh+2ysECo0Y9l+eF8BVO53l?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3600289FBFAA774CAE1E6E8BBF433E8F@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c3628eb-3895-4f33-42a7-08d97d0da4a0
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2021 14:39:39.8663
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qlXFJtMifWD/w+lZ0ZSUJiOYT/Ngjp+7h5GeJOUYnnQ/cQixsTHm0wOQH8f+Wmq5qXX8NGTBAGO3GRSv09PAPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB3953
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10114 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 adultscore=0
 phishscore=0 spamscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109030001
 definitions=main-2109210089
X-Proofpoint-GUID: wuPNyfoBsM_y0DTHaZ2OrDojqk1ZdBVi
X-Proofpoint-ORIG-GUID: wuPNyfoBsM_y0DTHaZ2OrDojqk1ZdBVi
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Sep 21, 2021, at 10:32 AM, J. Bruce Fields <bfields@fieldses.org> wrot=
e:
>=20
> From: "J. Bruce Fields" <bfields@redhat.com>
>=20
> We've supported reexport for a while but documentation is limited.  This
> is mainly a simplified version of the text I wrote for the linux-nfs
> wiki at https://wiki.linux-nfs.org/wiki/index.php/NFS_re-export.
>=20
> Signed-off-by: J. Bruce Fields <bfields@redhat.com>

Thanks for posting this, Bruce! Comments inline.


> ---
> Documentation/filesystems/nfs/index.rst    |   1 +
> Documentation/filesystems/nfs/reexport.rst | 110 +++++++++++++++++++++
> 2 files changed, 111 insertions(+)
> create mode 100644 Documentation/filesystems/nfs/reexport.rst
>=20
> diff --git a/Documentation/filesystems/nfs/index.rst b/Documentation/file=
systems/nfs/index.rst
> index 65805624e39b..288d8ddb2bc6 100644
> --- a/Documentation/filesystems/nfs/index.rst
> +++ b/Documentation/filesystems/nfs/index.rst
> @@ -11,3 +11,4 @@ NFS
>    rpc-server-gss
>    nfs41-server
>    knfsd-stats
> +   reexport
> diff --git a/Documentation/filesystems/nfs/reexport.rst b/Documentation/f=
ilesystems/nfs/reexport.rst
> new file mode 100644
> index 000000000000..892cb1e9c45c
> --- /dev/null
> +++ b/Documentation/filesystems/nfs/reexport.rst
> @@ -0,0 +1,110 @@
> +Reexporting NFS filesystems
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
> +
> +Overview
> +--------
> +
> +It is possible to reexport an NFS filesystem over NFS.  However, this
> +feature comes with a number of limitations.  Before trying it, we
> +recommend some careful research to determine wether it will work for
> +your purposes.

^wether^whether


> +
> +A discussion of current known limitations follows.
> +
> +"fsid=3D" required, crossmnt broken
> +---------------------------------
> +
> +We require the "fsid=3D" export option on any reexport of an NFS
> +filesystem.

Recommended approach? I would just say use 'uuidgen -r'


> +The "crossmnt" export option does not work in the reexport case.

Can you expand on this a little? Consequences? Risks?


> +Reboot recovery
> +---------------
> +
> +The NFS protocol's normal reboot recovery mechanisms don't work for the
> +case when the reexport server reboots.  Clients will lose any locks
> +they held before the reboot, and further IO will result in errors.
> +Closing and reopening files should clear the errors.

Any recommended workarounds? Or does this simply mean that
administrators need to notify client users to unmount (or
at least stop their workloads) before rebooting the proxy?


> +Filehandle limits
> +-----------------
> +
> +If the original server uses an X byte filehandle for a given object, the
> +reexport server's filehandle for the reexported object will be X+22
> +bytes, rounded up to the nearest multiple of four bytes.
> +
> +The result must fit into the RFC-mandated filehandle size limits:
> +
> ++-------+-----------+
> +| NFSv2 |  32 bytes |
> ++-------+-----------+
> +| NFSv3 |  64 bytes |
> ++-------+-----------+
> +| NFSv4 | 128 bytes |
> ++-------+-----------+
> +
> +So, for example, you will only be able to reexport a filesystem over
> +NFSv2 if the original server gives you filehandles that fit in 10
> +bytes--which is unlikely.
> +
> +In general there's no way to know the maximum filehandle size given out
> +by an NFS server without asking the server vendor.
> +
> +But the following table gives a few examples.  The first column is the
> +typical length of the filehandle from a Linux server exporting the given
> +filesystem, the second is the length after that nfs export is reexported
> +by another Linux host:
> +
> ++--------+-------------------+----------------+
> +|        | filehandle length | after reexport |
> ++=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+
> +| ext4:  | 28 bytes          | 52 bytes       |
> ++--------+-------------------+----------------+
> +| xfs:   | 32 bytes          | 56 bytes       |
> ++--------+-------------------+----------------+
> +| btrfs: | 40 bytes          | 64 bytes       |
> ++--------+-------------------+----------------+
> +
> +All will therefore fit in an NFSv3 or NFSv4 filehandle after reexport,
> +but none are reexportable over NFSv2.
> +
> +Linux server filehandles are a bit more complicated than this, though;
> +for example:
> +
> +        - The (non-default) "subtreecheck" export option generally
> +          requires another 4 to 8 bytes in the filehandle.
> +        - If you export a subdirectory of a filesystem (instead of
> +          exporting the filesystem root), that also usually adds 4 to 8
> +          bytes.
> +        - If you export over NFSv2, knfsd usually uses a shorter
> +          filesystem identifier that saves 8 bytes.
> +        - The root directory of an export uses a filehandle that is
> +          shorter.
> +
> +As you can see, the 128-byte NFSv4 filehandle is large enough that
> +you're unlikely to have trouble using NFSv4 to reexport any filesystem
> +exported from a Linux server.  In general, if the original server is
> +something that also supports NFSv3, you're *probably* OK.  Re-exporting
> +over NFSv3 may be dicier, and reexporting over NFSv2 will probably
> +never work.
> +
> +For more details of Linux filehandle structure, the best reference is
> +the source code and comments; see in particular:
> +
> +        - include/linux/exportfs.h:enum fid_type
> +        - include/uapi/linux/nfsd/nfsfh.h:struct nfs_fhbase_new
> +        - fs/nfsd/nfsfh.c:set_version_and_fsid_type
> +        - fs/nfs/export.c:nfs_encode_fh
> +
> +Open DENY bits ignored
> +----------------------
> +
> +NFS since NFSv4 supports ALLOW and DENY bits taken from Windows, which
> +allow you, for example, to open a file in a mode which forbids other
> +read opens or write opens. The Linux client doesn't use them, and the
> +server's support has always been incomplete: they are enforced only
> +against other NFS users, not against processes accessing the exported
> +filesystem locally. A reexport server will also not pass them along to
> +the original server, so they will not be enforced between clients of
> +different reexport servers.
> --=20
> 2.31.1
>=20

--
Chuck Lever



