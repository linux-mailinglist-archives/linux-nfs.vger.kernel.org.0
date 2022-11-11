Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6B7A625E48
	for <lists+linux-nfs@lfdr.de>; Fri, 11 Nov 2022 16:25:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230303AbiKKPZM (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 11 Nov 2022 10:25:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231840AbiKKPZL (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 11 Nov 2022 10:25:11 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 661342BB3C
        for <linux-nfs@vger.kernel.org>; Fri, 11 Nov 2022 07:25:09 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2ABFHRgj019901;
        Fri, 11 Nov 2022 15:25:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=9eKyXCT/DYyfN90ahDcZCZQKLnp26jxHUfGfJT7HSMw=;
 b=wxKh2ah59vcLmpLFRL3LdNwN77C0eQf8b35Vc73t+pesXFe7EgiwU4S8frs06iWNbu/q
 voYfxNrNNI1bFzZOnPofFELeJJ3X8rtsOZBOzcK750k8sRFVKGN+1J5arnpnPehB8Alt
 QpHM7EwT6rYtCkbn2tFfIvUjcxqOfGmJYXENFOnpa7TuS5IdB4nZKgdPdDjlTDi4nT7m
 38CmXPCHjodiETzKYWQ3np316S99FVFlKeguuVvWuf5qiW+mTbzEEwqBUsD4ML2T4fdC
 8zUZbqfIgCsfnczY8uampG5bsTtrmzx+vDwLBElPNd/eDIPVE++B2ktf4znNPxA0WtdP ug== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ksre683bs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 11 Nov 2022 15:25:06 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2ABDWp6b009083;
        Fri, 11 Nov 2022 15:25:05 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2044.outbound.protection.outlook.com [104.47.66.44])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3kpcqmn4uf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 11 Nov 2022 15:25:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Te4gnwushFfstAqKZFWvu2y5ifBUaL6D2yrKiHdmJjQMcF45W+544JjC1W4djYtfKSSwkYPL1s+f94lqA2SO0yTJX+WKivQED3p1OL3m8Ogej4RyFcGGOw7RjE6lY5xyeBLRLih1y/ylTxf4xVRNEsM7cU4UTKFBx60VgF6jYf1T6r4EGtWA++xAnHFEeYg1FYXhsxJGpn8d3cXSaZbFNa+VgWKj3u8zvbDN1p0iNfeCTtyL6Qy+e/vrh3smb3ZJ1rdPVX+yjHs8Bj6HIjLg0jH3b4ck+NTvdJQaJxR+AtP8ZvuUoIFlh4/q/abEgf6B4xAGRQUp5FoSnx9UqRsfYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9eKyXCT/DYyfN90ahDcZCZQKLnp26jxHUfGfJT7HSMw=;
 b=UyxWb4qf7wbMZLRYXpw22WNwDw+MNy85gY1pLUcS+ZPInWv6zPz2mERUsC1gnh5+mZelkqgIW9Yz+aOfS4dyoXXb6SPPN5560ExtCWkDIkODYPUmoQDTO6nTOydMhe6pR42BBy2+O9NVxzDgWbYzfnsv01xhipXmRiTOxLawOA+VMZKFyREirFUvm4Qh49G28sMOdyva1sDMfyeUqspZk79sBI9TZA45uK23bF/0lwz9UXXFka70awzJ8aLNKaY65ku2EF/QJUyrx/U9WZ2EvrH7OEvBqWesubSdMys5QfYhdEZvI9nKFmcqD1Zyjwnj76bdkNbQPypP5HN777LmRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9eKyXCT/DYyfN90ahDcZCZQKLnp26jxHUfGfJT7HSMw=;
 b=VPU8N2CwjXzAyRkD70mWzlEKbj4szlTlVlCJxDSgeZi8vsz94tgr6s55NySXrF79scdxHzPh44+BXneEpeRXOZO4l2FvKfqnq0Uf0h7eNodZmS+jahRbQZp/I7QnIuTB/oBBFm07cmLNo+wiIIkf/qhrksJUktvLEGuj/gvcQ50=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by MW4PR10MB5680.namprd10.prod.outlook.com (2603:10b6:303:18e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.26; Fri, 11 Nov
 2022 15:25:02 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::b500:ee42:3ca6:8a9e]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::b500:ee42:3ca6:8a9e%6]) with mapi id 15.20.5813.013; Fri, 11 Nov 2022
 15:25:02 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Dai Ngo <dai.ngo@oracle.com>
CC:     "jlayton@kernel.org" <jlayton@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v4 1/3] NFSD: add support for sending CB_RECALL_ANY
Thread-Topic: [PATCH v4 1/3] NFSD: add support for sending CB_RECALL_ANY
Thread-Index: AQHY9LtYo8I+6rqy8ECLPxQ+anZim6452hGA
Date:   Fri, 11 Nov 2022 15:25:02 +0000
Message-ID: <B5C21AD5-9347-4BF2-9885-C70FEF2B6ED0@oracle.com>
References: <1668053831-7662-1-git-send-email-dai.ngo@oracle.com>
 <1668053831-7662-2-git-send-email-dai.ngo@oracle.com>
In-Reply-To: <1668053831-7662-2-git-send-email-dai.ngo@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|MW4PR10MB5680:EE_
x-ms-office365-filtering-correlation-id: 5cc249af-243b-478c-9b2b-08dac3f8e72f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YjEXm/ojsAzkAjA1AkiLoO3A0Zu0UmTJfG6e0GVkDgDO6x2TgBKtwNltUQbG2gIps758ye8FUXaZBGc+k+E43+1P3YTM5H2iN7bklFfULD3eRBmF2BYVpjWgmNRQDPfpeFPrUWLe7E0nNtH26i/KRz0vf0RNao4kRDpujCQLb3z2pYbfqzNcRMgTB6jkfHwE9CfSUs29zlpoV5LmS+qo/pryOXeyuvgp29kXJvWn7AavIiIuJ+tKaloiD5qoaktwz91fsCE/IBS8UY5mYhh6LbsRLomFChrg6c6PFWB0L3xwvkzHo/CAijMjt3cnH07liX2XFRezVz2vm4RF6MqZAjSj8HG0IQoaM9bmPdItBdOI2HK1YzgceYUhdRc/MKozUFKu02Gs2JIM/nFNBRonjeUwAEFGHBh9FF4TPnA+tizw8QhgPPXtgEmMg64Lc1gBEgNPrYAOpJIpEfcBDzZeAFWQwj0pikxII5rLRS8Zh7BrXGQHWxstSuLhtshTEUCZJ0rJY3uH9BkWZLzfDSnaNnWo7GcsL/Sbd1+Z2oP64h7A1AqIE7brXz6VGwHY/tNukmgIOcsml7CslKPJnWpShS1D66Rhkmdnbx9soxMZupIS3ofJu6O0OdcC9R5QOEQ77dI9l/X23c2vhp4DIC3AVP9MY2tpP0xEmJ+y+r81WSUsJw1zPnc8jFm8CNe0MUw99X+fqPn53tEo63L7aj0r5cDN5maxmtXWlDLPkN3MfpCMA50aadpjsUAJ0WWaDyb7WCuJLWrpSGG7rw5AuFIdVP0MioLRN3KnOS07XPaeL5Y=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(136003)(376002)(366004)(346002)(39860400002)(451199015)(38070700005)(8936002)(41300700001)(5660300002)(8676002)(4326008)(6862004)(64756008)(86362001)(2906002)(37006003)(54906003)(6486002)(6636002)(316002)(66476007)(66446008)(36756003)(91956017)(71200400001)(76116006)(66946007)(478600001)(186003)(33656002)(53546011)(6512007)(2616005)(83380400001)(38100700002)(66556008)(6506007)(122000001)(26005)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Dd6D1lqtxP/eyGJd0gjmIpE+jiR1LlcU0qZ8KOWfXBLY12cv6bfOXuPeHoqe?=
 =?us-ascii?Q?IRYAGYNIaigJ4aLDSoY9sIT7oNEEo3oohgqnF2P93Cu/5YM+T6EDE6El1koU?=
 =?us-ascii?Q?9R5Aj3SlGHw5CFG+7Mfmr+R5UyB5mCgOCb3SRAiMCloa1S5pDIU1K6hmDDBm?=
 =?us-ascii?Q?amdWEQpgC9eFlEFNbtGBgNVjRTPPXCiVDNi5oAhgz1v2OqJhGKka5kCot5U0?=
 =?us-ascii?Q?V9iNV5FZ519yF3ESXV58e6RkJllARYGsgcs0ZI2gfng3BogcfKpK0izj7z34?=
 =?us-ascii?Q?Z5gddbXwnGIdJ4H+O+ahjLUg9gbv8lUHlwQszjjVORNQjAcA7FR/e54exCoG?=
 =?us-ascii?Q?3ISybxi5qxqvn/+ypHiztQn3JxfPzleZdor3NUPqSrhYiDnSVZRFoYqpJUM1?=
 =?us-ascii?Q?V5hQFlqA5oocGgKdupn/ZzH6DQABB6HiG/iKAhdMiAXt2s/Dtu2/1elUMTXU?=
 =?us-ascii?Q?IvvieGKtp1Z6eR0K99f5DufcLnbBMKDtk3TcRJPBFk2SNJifvblgFH2Wkozd?=
 =?us-ascii?Q?UxdXU5VmLuWQMTj/wE/nBUbwSZmE+HDxIumqxrkIgadimzX7koKtPGH5+bEc?=
 =?us-ascii?Q?BXojtplPrQouwVcLNbOe3rXVeKGB6tMBZ6vla/NUinkKk43FA9SMsP2OioP/?=
 =?us-ascii?Q?Dpdq+mZ841frvh4Hvoyqzej8yfXftRlKKDHyaKXESkXu4G+znyMf2hPkkW12?=
 =?us-ascii?Q?LD620ZUPj5B9S0Ey76NwVOog+FtzPh/Sb8wdQY8rFs8uqtx1Jev3znX7fQHE?=
 =?us-ascii?Q?Xdlso4S4Ppl5c9JovlBQxc/6O0KemsGEcFvDwaG/SY0qDFyu4f6da3gPclv6?=
 =?us-ascii?Q?Yu7QphP261cO208fCKr+yBfZoqN5ARlLo9FZCK9QSXdhNhiVH9/gUA+BkG4D?=
 =?us-ascii?Q?ZeCOtA9vKtJF2TOWfYn1YKzyGeNqcHqS7h7WHCSfQ4GBTZWGqoZmYE8BfqRg?=
 =?us-ascii?Q?sl7gqmwiWUxpQQIJhC02G2TT4oYuSBAGxtfTMwoQCljDZ8i9h47Lj7IIG2ol?=
 =?us-ascii?Q?Me6+/NkPQICOgDAnvTe0IJdUDHrZAHdpMlH2QDxTBDnQUbDpIhnilBQiir5v?=
 =?us-ascii?Q?LgbIxtjOOK+BAso12H9LweJcrOIhIxc4KgqXDsUJHFtl7n+q9xx76hc1Ow/c?=
 =?us-ascii?Q?NQU7kfJ26I1hZu1MCmxIiAA7FQTIj/xLfxrHDnJYONYOCdDXXh6gBOpkDdyI?=
 =?us-ascii?Q?wo1PV+0pFjGAyFMjsBkOCZhtG3jW8EfBv4UXNafhQWPReA/pWXWmGrE8JDv/?=
 =?us-ascii?Q?cLLoJ0Y2N6ONE18pgazFILHggZl9u9qRKU5ZNnU7fjaGq3f60r+bj3q9aGqm?=
 =?us-ascii?Q?TlFxmlSyobsmpn8KnhG4reAlWy0XutEuiTelHEuIs7BqsidJNh2F3vAAb0Ch?=
 =?us-ascii?Q?Dq3GL4e5AKlUzKjfLXXPrsuGBuFie2J9rW9QA6MtJK6AUI/MtvgvXPa2R55j?=
 =?us-ascii?Q?7ghjZiorg1S2CfVhPSpRFI78DogcYqAmthsUJgekKsegqcZK+3llX+ipoEMq?=
 =?us-ascii?Q?ZVE3GsLwuRabFhpfnHuc4amMtqHyJKv2mpapX0VSixfz1+wkMz35S4lSsK5c?=
 =?us-ascii?Q?ApCYUHUnmDfMnUteWuSXHvVaKGMIat9lnfW9ANZPN0Pgo2s05NcthwK4cR4U?=
 =?us-ascii?Q?lg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E99EE7E3DEEBF842BF702F7A458D9082@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 9A7hgIAYwprvVXn41SpYxb+/aeFZ1kanyXF/RGhLdDfl0YpMJhf69RM49XGW53BPVZAzfY/lQZY48VYorrfMa0x08thNhrmP2clHi62rt5wISurotZgGT3O8WhKd++xeKPQ8It4Ny/l58Lxl343mUwOnrrPA0/uJ5Vi7bpWVcvWpYxZHuEz2qE0N0598BgEoHX/ZxgGfo2R6SSh7QGO8IrTNw7xVvHrYzy77CuRcVRRsBfXKhjXGRnX+/OAh1D6jOopZzye+dJ39KmpJd05g5+AgjYBEBrFUVD+wKv6HG9U+cnb72eHwIdhBT5fG8C2M/UJj4bF6A1RLxYsv1F2fM5N0B/GYFbz4FXpvBJ8F05sR13KAYbGzRifrmEjFBSFsuuVIp62NL/4AM88eyZd6ZtZDiGJ1whK/mgDCgVC/XoACs50dF1zZ5pJ+gm95/KWI7ubndacosai0xdegjUs+BtnwLxqYdj9+s7rB/6Erpg4iVg0kbF/nFF4Dcq1HDRmjzfDpkF7MH/uLFHqXKRvknm+4Wgf9ns0lZG77n7OTtteO+MfMMjEB8D00onyxbHuXu7RwQ9e3+cVb0psHUkI9AMC6Gqbu+amIB1RJYBupHsevwbtnFHSrfFx5Qoqrj3t40ildOCxbYjYlIItXjBrNAyRlJVJlRyx0Em5IEsZw/7bCKOqLx14UdIW61DbncYettr1nALdGsXIEZdWlw8ES52CjiwdXciqOTVPzPha3qVBBAsYj44j/XGWO7eA0aS9WxisD9icsng2uePS0O1v5CtUlKVBLENwb/kTOMTT3JK0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cc249af-243b-478c-9b2b-08dac3f8e72f
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2022 15:25:02.3684
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4o7f1rZnfOIQLiYewtKdHFrhAlhjxQ0ZSr5lXw9LQfyoCWrm7G5El1oTGfbx4Rx00dFh6+sfOJHgrgnUuALw2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5680
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-11_08,2022-11-11_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0 mlxscore=0
 suspectscore=0 spamscore=0 malwarescore=0 bulkscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211110102
X-Proofpoint-ORIG-GUID: 2TyOmSJIJ-oNivbLjEWOAlhTmQkAj0oY
X-Proofpoint-GUID: 2TyOmSJIJ-oNivbLjEWOAlhTmQkAj0oY
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Nov 9, 2022, at 11:17 PM, Dai Ngo <dai.ngo@oracle.com> wrote:
>=20
> Add XDR encode and decode function for CB_RECALL_ANY.
>=20
> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
> ---
> fs/nfsd/nfs4callback.c | 62 +++++++++++++++++++++++++++++++++++++++++++++=
+++++
> fs/nfsd/state.h        |  1 +
> fs/nfsd/xdr4.h         |  5 ++++
> fs/nfsd/xdr4cb.h       |  6 +++++
> 4 files changed, 74 insertions(+)
>=20
> diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
> index f0e69edf5f0f..01226e5233cd 100644
> --- a/fs/nfsd/nfs4callback.c
> +++ b/fs/nfsd/nfs4callback.c
> @@ -329,6 +329,25 @@ static void encode_cb_recall4args(struct xdr_stream =
*xdr,
> }
>=20
> /*
> + * CB_RECALLANY4args
> + *
> + *	struct CB_RECALLANY4args {
> + *		uint32_t	craa_objects_to_keep;
> + *		bitmap4		craa_type_mask;
> + *	};
> + */
> +static void
> +encode_cb_recallany4args(struct xdr_stream *xdr,
> +	struct nfs4_cb_compound_hdr *hdr, struct nfsd4_cb_recall_any *ra)
> +{
> +	encode_nfs_cb_opnum4(xdr, OP_CB_RECALL_ANY);
> +	WARN_ON_ONCE(xdr_stream_encode_u32(xdr, ra->ra_keep) < 0);
> +	WARN_ON_ONCE(xdr_stream_encode_uint32_array(xdr,
> +		ra->ra_bmval, sizeof(ra->ra_bmval) / sizeof(u32)) < 0);

My only nit: You should use ARRAY_SIZE() here.


> +	hdr->nops++;
> +}
> +
> +/*
>  * CB_SEQUENCE4args
>  *
>  *	struct CB_SEQUENCE4args {
> @@ -482,6 +501,26 @@ static void nfs4_xdr_enc_cb_recall(struct rpc_rqst *=
req, struct xdr_stream *xdr,
> 	encode_cb_nops(&hdr);
> }
>=20
> +/*
> + * 20.6. Operation 8: CB_RECALL_ANY - Keep Any N Recallable Objects
> + */
> +static void
> +nfs4_xdr_enc_cb_recall_any(struct rpc_rqst *req,
> +		struct xdr_stream *xdr, const void *data)
> +{
> +	const struct nfsd4_callback *cb =3D data;
> +	struct nfsd4_cb_recall_any *ra;
> +	struct nfs4_cb_compound_hdr hdr =3D {
> +		.ident =3D cb->cb_clp->cl_cb_ident,
> +		.minorversion =3D cb->cb_clp->cl_minorversion,
> +	};
> +
> +	ra =3D container_of(cb, struct nfsd4_cb_recall_any, ra_cb);
> +	encode_cb_compound4args(xdr, &hdr);
> +	encode_cb_sequence4args(xdr, cb, &hdr);
> +	encode_cb_recallany4args(xdr, &hdr, ra);
> +	encode_cb_nops(&hdr);
> +}
>=20
> /*
>  * NFSv4.0 and NFSv4.1 XDR decode functions
> @@ -520,6 +559,28 @@ static int nfs4_xdr_dec_cb_recall(struct rpc_rqst *r=
qstp,
> 	return decode_cb_op_status(xdr, OP_CB_RECALL, &cb->cb_status);
> }
>=20
> +/*
> + * 20.6. Operation 8: CB_RECALL_ANY - Keep Any N Recallable Objects
> + */
> +static int
> +nfs4_xdr_dec_cb_recall_any(struct rpc_rqst *rqstp,
> +				  struct xdr_stream *xdr,
> +				  void *data)
> +{
> +	struct nfsd4_callback *cb =3D data;
> +	struct nfs4_cb_compound_hdr hdr;
> +	int status;
> +
> +	status =3D decode_cb_compound4res(xdr, &hdr);
> +	if (unlikely(status))
> +		return status;
> +	status =3D decode_cb_sequence4res(xdr, cb);
> +	if (unlikely(status || cb->cb_seq_status))
> +		return status;
> +	status =3D  decode_cb_op_status(xdr, OP_CB_RECALL_ANY, &cb->cb_status);
> +	return status;
> +}
> +
> #ifdef CONFIG_NFSD_PNFS
> /*
>  * CB_LAYOUTRECALL4args
> @@ -783,6 +844,7 @@ static const struct rpc_procinfo nfs4_cb_procedures[]=
 =3D {
> #endif
> 	PROC(CB_NOTIFY_LOCK,	COMPOUND,	cb_notify_lock,	cb_notify_lock),
> 	PROC(CB_OFFLOAD,	COMPOUND,	cb_offload,	cb_offload),
> +	PROC(CB_RECALL_ANY,	COMPOUND,	cb_recall_any,	cb_recall_any),
> };
>=20
> static unsigned int nfs4_cb_counts[ARRAY_SIZE(nfs4_cb_procedures)];
> diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
> index e2daef3cc003..6b33cbbe76d3 100644
> --- a/fs/nfsd/state.h
> +++ b/fs/nfsd/state.h
> @@ -639,6 +639,7 @@ enum nfsd4_cb_op {
> 	NFSPROC4_CLNT_CB_OFFLOAD,
> 	NFSPROC4_CLNT_CB_SEQUENCE,
> 	NFSPROC4_CLNT_CB_NOTIFY_LOCK,
> +	NFSPROC4_CLNT_CB_RECALL_ANY,
> };
>=20
> /* Returns true iff a is later than b: */
> diff --git a/fs/nfsd/xdr4.h b/fs/nfsd/xdr4.h
> index 0eb00105d845..4fd2cf6d1d2d 100644
> --- a/fs/nfsd/xdr4.h
> +++ b/fs/nfsd/xdr4.h
> @@ -896,5 +896,10 @@ struct nfsd4_operation {
> 			union nfsd4_op_u *);
> };
>=20
> +struct nfsd4_cb_recall_any {
> +	struct nfsd4_callback	ra_cb;
> +	u32			ra_keep;
> +	u32			ra_bmval[1];
> +};
>=20
> #endif
> diff --git a/fs/nfsd/xdr4cb.h b/fs/nfsd/xdr4cb.h
> index 547cf07cf4e0..0d39af1b00a0 100644
> --- a/fs/nfsd/xdr4cb.h
> +++ b/fs/nfsd/xdr4cb.h
> @@ -48,3 +48,9 @@
> #define NFS4_dec_cb_offload_sz		(cb_compound_dec_hdr_sz  +      \
> 					cb_sequence_dec_sz +            \
> 					op_dec_sz)
> +#define NFS4_enc_cb_recall_any_sz	(cb_compound_enc_hdr_sz +       \
> +					cb_sequence_enc_sz +            \
> +					1 + 1 + 1)
> +#define NFS4_dec_cb_recall_any_sz	(cb_compound_dec_hdr_sz  +      \
> +					cb_sequence_dec_sz +            \
> +					op_dec_sz)
> --=20
> 2.9.5
>=20

--
Chuck Lever



