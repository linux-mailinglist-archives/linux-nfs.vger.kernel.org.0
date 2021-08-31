Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C49953FCF15
	for <lists+linux-nfs@lfdr.de>; Tue, 31 Aug 2021 23:23:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230125AbhHaVY0 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 31 Aug 2021 17:24:26 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:27200 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239889AbhHaVYZ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 31 Aug 2021 17:24:25 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 17VIiL3X015210;
        Tue, 31 Aug 2021 21:23:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=vne6HZGEcTbszJggfuXC8bS1nq0CvcJIJgaTPNlzWGw=;
 b=IBrT77/NflhriUAmqPS4pGRpk/tFBPHn/0///Ir1sTZ+3KMjXwVpJA23bTR8+ssR9N8H
 SFoUu9UEPR7IYgvuFrMyhWA8oSryheFAE4k7vJla8+8mdilrNGhaKQA8S2HiY6sV4VID
 hQNAGNnsOreeuAIguHkGwEbLAASyUzSRTaB72bWyztZGO5rqi0qL+oU+R6MX/nb108e3
 5UxDVo6043A2t3bQ/EmFlWDwx2aae+UzQp5ASatpxpcPybejkr2PuGObAmcDcrlAhEJt
 yfEqVJFaEncG3D5MTFs1WiDVV5oJW9SexO9LQbt+I8YRxUr27uScNQ+f/o1zVHJD3L6O yQ== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=vne6HZGEcTbszJggfuXC8bS1nq0CvcJIJgaTPNlzWGw=;
 b=m/7GF120sKW8kyJcEFjrVKb3ayfVJnFD1YjkacupgAhr+HNCXau/Fn+cB+nDK59zYyjJ
 sPwKA22I6yWbPCAP5r11OT5pk5zhzEy5Epvtg2dOb9zFC19IS5UYYQM1KNU82J2OteWy
 oFrIyeBMx7TWMQTMrB+SkQ4mLWsp6UcWtOKtyf5k1iNqasAitrXW4FSX92CoOi7mqIif
 V9xLeVcd49B78vjftSfmnzmYq2vY0vcnB5joL6bABnwI2rCt1UOhisnV65KYW8kCzHKt
 Ppd1zZS+X0eX/P3eDShNkdQ5xwDpK4cakcFm6folDW2YX8Ndx77PDdZfDMiiqNJ0rglO qA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3aseedjgt9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 31 Aug 2021 21:23:28 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17VL9qKS107310;
        Tue, 31 Aug 2021 21:23:27 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2103.outbound.protection.outlook.com [104.47.58.103])
        by userp3020.oracle.com with ESMTP id 3aqxwuadca-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 31 Aug 2021 21:23:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K/VlgYVZycQ8t+TIx87ao3T35wFwptl223FEdaOjnIcX/0kpnXMIJdr/eLjXhpuErc2YigpLtn4GqP+ne+gJNZCo7E0jLiC84FVRm0+DohxhKJ0dcSRR/fZntddLT6Glia6xnn+M+ZW7cWnT171gYBF6Q0ttg6SOQKIs66nwWygY2rJZEQbDjvF905SvZbHLD8ZB0Q+SsjYPmc8GwobQMda58IFwz88gSF6tvj/MWpggbRrUHHvdYrcB2LiZZG9iyDyqQBqjtqnVGh62dJvDJrMCeNI6HM8VuPuuwIy77tmA7vl0z44WeoXOLqnWd0r+hHVbPJXJPQ7+T8/rBIWzsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vne6HZGEcTbszJggfuXC8bS1nq0CvcJIJgaTPNlzWGw=;
 b=a5KP5LmgMJl1bgB0Ca23NDZVwaCMW6GO1ygnd9L+hTWk61IDPPSWRgtyoODWr+Niy9tBzdLnf6WcG+qQtxpVW2tLciA0BI5nk/cJ+sEqDRIBgCCBC0cIjE1jswLdw2AK4+ElWcKWUgWCNMos1Q+OKp5ml7uqOYkb4n8sDDS73IYWJ91Yz1PsPvVUFnx9MMSEqpm8dwFWN0/64pgeyOYcX+z75Njs3cbCid4Yu1Ujb3oEje9ak8miu4/owUbThW/3BXTsi+xjhEeHSB6ZIBfnFWDyeGtAvqsJkWTmoiN7wQg3OEBq5uZld8vFF1iQCUmD1WBDZr++KFQyAjcnmTk1OQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vne6HZGEcTbszJggfuXC8bS1nq0CvcJIJgaTPNlzWGw=;
 b=dCVO/+HNcVuoTL2VHruppVfl6w/iIbohcFi47evNVFjZScMtBsnmP/00cMIykWTQVtwNzWFg9x1qChmteQz8/ia+9zpCt6qbCf0vQID4HW24JPBYATTQIIyC2qua6eKMBVxRWAAhiTvXBEcIgtBvfZD7+Dably/II0bNHsXCuoE=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by SJ0PR10MB4637.namprd10.prod.outlook.com (2603:10b6:a03:2d6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.23; Tue, 31 Aug
 2021 21:23:25 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::f4fe:5b4:6bd9:4c5b]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::f4fe:5b4:6bd9:4c5b%7]) with mapi id 15.20.4478.017; Tue, 31 Aug 2021
 21:23:25 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Bruce Fields <bfields@fieldses.org>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH RFC 0/6] NFSD: Pull Read chunks in XDR decoders
Thread-Topic: [PATCH RFC 0/6] NFSD: Pull Read chunks in XDR decoders
Thread-Index: AQHXnpsmcuWuedcxvkuGPTniugh266uOFCwAgAALe4A=
Date:   Tue, 31 Aug 2021 21:23:25 +0000
Message-ID: <A56E33CA-C87A-41E7-BBF6-8623795D4607@oracle.com>
References: <163043485613.1415.4979286233971984855.stgit@klimt.1015granger.net>
 <20210831204220.GB7585@fieldses.org>
In-Reply-To: <20210831204220.GB7585@fieldses.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: fieldses.org; dkim=none (message not signed)
 header.d=none;fieldses.org; dmarc=none action=none header.from=oracle.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9de33395-2c30-4e08-9eaa-08d96cc591c2
x-ms-traffictypediagnostic: SJ0PR10MB4637:
x-microsoft-antispam-prvs: <SJ0PR10MB46379BFE5D7D4611CF9A3E3A93CC9@SJ0PR10MB4637.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: I9IVgWfuz59Y7aftrLmC/ddFdvlLQH5/sWnJgLQwpDwjVmE1dORvUmD/X6lBOoSlNUOZ7Mh6xDJ+iLZBYHKBj1kvuk07DuPzofijWYNkH9ScxfC9yX56JLjAAfIPPQXxb9NpVjU8+0lHZfyDT8E3M09hdzq5iolm7sorDIyAU8/qzJiyBeo9YbFmtjIsZLxWSVBNTMYs9HxyVCASweJ0uVKWq8HeJuV7d1r9ZaOfEd3Yp1q1GJYJvrIvKCzF892IIdAmyLlRo7bOwBNU5hD9extyP72xdWXLkMZaiCY0MqDJRzf5tQ2iF4R1a/6I+yvmS4XxEqHD1SmHfC44SWYxFurQaUSPeRB3ohi+nEPhcBYy+Sx025BOMEl+vLCYGGFy8Fdf/6ySoCJP4t6QfbCeou7fNn+mXDNwjXSwYFIBdvT8zKduUjO8uzcN6ZL48dv8AvB4ICwUkl5K4Zp0557jiF1CrcuG/D9Up9wZpC75lm4SOjW4cyYBEm04ZcdNKnpZpxd5f00+xL570fa+/bsWzVt2B3G7r4vJy+RpheDfWCc2cN3O3dn34EA8bgkuZrykAW/VdDfmhxgvaGFLqOsacNvmfIbEF760CnCZkQKFbVSWQAaGOG3LK5MD5wZl3JdlWH2CcIVI6P0mpsyZJYKSsWFjBWZe5LxwpV+xA+PjH0D+3KVQ1jHNjax9SMpM5i7zxwbPLGQUzSM1NqrPQU2jhwIiBCpghhxh68kn65kFIoo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(376002)(136003)(366004)(346002)(39860400002)(53546011)(66446008)(186003)(8936002)(64756008)(8676002)(2616005)(38100700002)(66476007)(83380400001)(66946007)(5660300002)(33656002)(26005)(66556008)(6486002)(4326008)(54906003)(478600001)(36756003)(6512007)(2906002)(6916009)(38070700005)(86362001)(76116006)(91956017)(316002)(122000001)(71200400001)(6506007)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?8347pOYcFNXA7EqnuFZA9sd8FJlFispgk9pKeXXgImGXP9JH5zicEsGV3H+W?=
 =?us-ascii?Q?W+pLjEJ1uUEs7B2mmsltPTrlTjEGrhrKHGgkSJRviHRxd3rJ4LSDSvAymrB+?=
 =?us-ascii?Q?JXCVjGUO9Tsnyuy2F8Io8ubMH1dRJ3LV7MoXG/S75FCNu1MuJzEK0vEKGVy5?=
 =?us-ascii?Q?T9II9BaWMrRbboTyPPeuNtpBc5vcfE9Kh8/jWTXQli5ZGdh6teBFl6pFwS3x?=
 =?us-ascii?Q?m3WOjcIi8GPBuF62JqGL42aqw/Ge2mZjrj565TnmaU+vSZHcpb7jOp5kHsQg?=
 =?us-ascii?Q?Hede3Y/iDxMgbdcMvYATqUVkQ/eiOLE9ybngf5f2D9mu5HdE0DWgAkr8zjFg?=
 =?us-ascii?Q?oitgPGZiXQwov653OB2pGzOjKo16AdkXi3AHrqnKik+a/EpJxPrVEkl3TzPk?=
 =?us-ascii?Q?l1VHPB/7GtpKmoPU4PEdYpGY5JNJ2pGlj4Qsnv0TV9UrRJqMo3hPcz8E8s/m?=
 =?us-ascii?Q?Pt3oaavtku6Z6gSmd1i7L0i71XJ0FfCy9GbuBnktgcCKt/rTpwXnVHQ6v6zs?=
 =?us-ascii?Q?+hqrEJ7Ozs36qASYA0d36KniMeWvDW5w/RkR+QU5zXsKa6QYd2Yz/wdCeFfi?=
 =?us-ascii?Q?XvH3agWWZjYAhtrszeFzwlXx7QA1RUhWCti4Ihb7qU9tI7Md2xTFK8idpGwD?=
 =?us-ascii?Q?s7ZTSbEx+1fhOIQAW6MTif+KDrOV2sJLOydhyFRpHT4R4aSLUknLZJ8IE3/B?=
 =?us-ascii?Q?XyhNcfQBwCRTRzPCH72ZCsw4AjPdIpLC36M85CTwepNKLtnt1I0UcJLmV4GC?=
 =?us-ascii?Q?ELFTN9NZxXNdU44S1FkKE9v6kuNRhbkplmVKgdud5pHREgNf5kK3GNZISJU6?=
 =?us-ascii?Q?yIyx9caAPVhjctxzTTQK0CPPSBAJB9uOkdpg7MdNSBSBFToJFkbBebzMqARY?=
 =?us-ascii?Q?lmymhY4CP0OGFgRG37VMDGYHbFZkbXAOSsdQjwSvd392jxwjW2tZWoI78lzq?=
 =?us-ascii?Q?+iVzuch+uo5mB6ghMIVWdWWgJTFZ/OgxwPj0vQWd88UsHA1CAZPjodLBB+9t?=
 =?us-ascii?Q?8HVdeehSJUDPFnhGPXYWsKv1EJT0N8DXOGE+Bk+baNOsqMzeV53gW91yqMUW?=
 =?us-ascii?Q?OQPsK33DnJgxae1X58jKeamm/oq52H/X1Nu6ON5aGr/PLasn4wpP3tlGVSSI?=
 =?us-ascii?Q?W9RRUu38T0rNsnpiGEks4n1x0UWAZfn+mkI6eCBXY/r4Ej6YzgL10/+Sui8y?=
 =?us-ascii?Q?PO1gETv/NWa4ne2L5/noWuTHg5mSuem85PoSAperZj5UGE6bTyVSy+x7GSPG?=
 =?us-ascii?Q?3Nrp7Yxhqg4S86q9KqWSV17uAAZuH9TPgWRKuODn8pKfhVa7OL/gSUdn4ZOy?=
 =?us-ascii?Q?HkFio74TmhGQ9WbbIpmbg/PZ?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <5F3D01E85A79104D8456351E5AB7C8B9@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9de33395-2c30-4e08-9eaa-08d96cc591c2
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Aug 2021 21:23:25.7970
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4ObRYcDW0v2XhrgVisZZQzob/R0AIgzCO6OnldwJbzgdaFOj/wQNxRVxi50DXG/VGH+nwy9u7jI+XwDhqx/i1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4637
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10093 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 malwarescore=0 suspectscore=0 spamscore=0 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108310116
X-Proofpoint-ORIG-GUID: iCltGm2QgpaaSuHhaK8uLzpoOjnl5Uuw
X-Proofpoint-GUID: iCltGm2QgpaaSuHhaK8uLzpoOjnl5Uuw
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Aug 31, 2021, at 4:42 PM, J. Bruce Fields <bfields@fieldses.org> wrote=
:
>=20
> On Tue, Aug 31, 2021 at 03:05:09PM -0400, Chuck Lever wrote:
>> Hi Bruce-
>>=20
>> Here is part of what we discussed recently about trying to align
>> pages in NFS WRITE requests so that splice can be used. This
>> series updates server-side RPC and svcrdma to ensure that an
>> aligned xdr_buf::pages array is presented to NFSD, which is then
>> converted into an aligned rq_vec for the VFS layer.
>=20
> Seems sensible to me.
>=20
> Do you have a git tree?

I don't yet, but can set up a topic branch somewhere where we're
a little further along.


> It didn't apply cleanly to 5.14 when I tried,
> but I didn't stop to figure out why.

It might apply to 5.15-pre now that nfsd-5.15 has been merged.


>> The next step would be to look at how to make the best use of the
>> aligned rq_vec.
>=20
> Have you done any performance comparison just with this?

Not yet. I just got it behaving correctly with the usual tests.
Baby steps, sir.


> Doesn't seem like it should make a significant difference, but it might
> be interesting to check anyway.

I expect it to add a small amount of latency to NFS WRITEs, since
RDMA Reads are done just a little later than before.


> --b.
>=20
>> My naive thought is that where there is a PAGE_SIZE
>> entry in rq_vec and there is no page in the file's page cache at
>> that offset, the transport-provided page can be flipped into place.
>> Might work for replacing whole pages as well, but baby steps first.
>>=20
>> This series has been exercised a bit with both TCP and RDMA, but no
>> guarantees that it is completely bug-free. NFSv4 compounds with
>> multiple WRITE payloads on RDMA are treated like TCP: the RPC
>> message is contained in an unstructured stream of unaligned pages.
>>=20
>> Comments encouraged.
>>=20
>> ---
>>=20
>> Chuck Lever (6):
>>      SUNRPC: Capture value of xdr_buf::page_base
>>      SUNRPC: xdr_stream_subsegment() must handle non-zero page_bases
>>      NFSD: Have legacy NFSD WRITE decoders use xdr_stream_subsegment()
>>      SUNRPC: svc_fill_write_vector() must handle non-zero page_bases
>>      NFSD: Add a transport hook for pulling argument payloads
>>      svcrdma: Pull Read chunks in ->xpo_argument_payload
>>=20
>>=20
>> fs/nfsd/nfs3proc.c                       |   3 +-
>> fs/nfsd/nfs3xdr.c                        |  16 +--
>> fs/nfsd/nfs4proc.c                       |   3 +-
>> fs/nfsd/nfs4xdr.c                        |   6 +
>> fs/nfsd/nfsproc.c                        |   3 +-
>> fs/nfsd/nfsxdr.c                         |  13 +--
>> fs/nfsd/xdr.h                            |   2 +-
>> fs/nfsd/xdr3.h                           |   2 +-
>> include/linux/sunrpc/svc.h               |   6 +-
>> include/linux/sunrpc/svc_rdma.h          |   8 ++
>> include/linux/sunrpc/svc_xprt.h          |   3 +
>> include/trace/events/rpcrdma.h           |  26 +++++
>> include/trace/events/sunrpc.h            |  20 +++-
>> net/sunrpc/svc.c                         |  38 +++++--
>> net/sunrpc/svcsock.c                     |   8 ++
>> net/sunrpc/xdr.c                         |  32 +++---
>> net/sunrpc/xprtrdma/svc_rdma_recvfrom.c  |  37 +++++-
>> net/sunrpc/xprtrdma/svc_rdma_rw.c        | 139 ++++++++++++++++++++---
>> net/sunrpc/xprtrdma/svc_rdma_transport.c |   1 +
>> 19 files changed, 292 insertions(+), 74 deletions(-)
>>=20
>> --
>> Chuck Lever

--
Chuck Lever



