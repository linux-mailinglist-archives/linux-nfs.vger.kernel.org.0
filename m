Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7CDF4255F0
	for <lists+linux-nfs@lfdr.de>; Thu,  7 Oct 2021 17:01:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242221AbhJGPDD (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 7 Oct 2021 11:03:03 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:59018 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233392AbhJGPDC (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 7 Oct 2021 11:03:02 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 197E70rU029735;
        Thu, 7 Oct 2021 15:01:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=l8+Ne57Z1DoIaLXqUSeVEuEnoC1Tn4PcPMNsBN6kGzs=;
 b=pQCA+P6DyAtAhobxUR/2r0qKX3bLtorNHiQS6os1If3LySDLxpf/XpHT3m+zRafG/Q/i
 dD60+urQRDxSEMy+TWtcg6XVc5WHiBdVVL1HOwl5xRrvluRwArtlmPYrGQGLl5P9Tn59
 BdqJ6lcyEdPRIUh4z2x3OIgkDpqhJqFAClc2fICSHt8SQhfc6ekIjuoJXTjo4r1LPo3W
 ++1qI8CGBn0nXegCYJYIjlXpQCrT26rtiln4HFeWJgag3F4pfZkMvoZCGlfNH0PH/fsD
 reeitgj2Td2jJsB3W90CB3BqYjZm4jBMnL7D5dI/YLo3BBjjf/itICczKIl7uBGRXVdl Ag== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bj02jhays-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 Oct 2021 15:01:05 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 197EuQxN138673;
        Thu, 7 Oct 2021 15:01:04 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2177.outbound.protection.outlook.com [104.47.59.177])
        by aserp3020.oracle.com with ESMTP id 3bev913c9w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 Oct 2021 15:01:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QZsUVsXCaN+AKYXetUf5ftRDM4y506WZVkVPuArtKd5aOccA8SIGejXb5FEhlucAi+q+E9u60zPVVw6G+PaNj/PkLQr9xY/weOxt0ymOOVTWuOB0NizEsHkvlrMuu7wbQC4m91ZQFGdNsSapQJ2RuYvLV/ZVY3CiI5zaNX6LfOmAxmIORmMWuJ5Fqu6L9EGnYL4YE4ZwH/HvtICTJbB1j+eQzbCLgjmEMHD8oJgHVIf61VeXHUcFnpECyIzOu8VpjK0l3JwwbxK+LF2LndeNNC1hHq63QPmCl5eZ6utduW2fX+In7ZVByhQY77yLbfX+snRgUCqx7FdyTRZ0lm6qWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l8+Ne57Z1DoIaLXqUSeVEuEnoC1Tn4PcPMNsBN6kGzs=;
 b=IuAo4j0tKbF9CIhdL3PBKTNqX6/HFvxcs/wQcy0hhUTJo8d7jPKESJru5WkZdyI+nix7z9E4MwOpDs3q5az3eZhnjVJz12w2sM9zJHsQ3OIwnqrlYorSFDilvsuht45kCe0zk6KRFurWWy8KMGeoy3aNGoLEkLt9THRUqQ6yy32IWbDiz8m0yqiwXh87L4pI4uGzfgFGdThNRwnwlXP1RjuhkteTX8qhkwRMAxZYbIUkyqIBwhqG9ftjvE8ttCFmcTnUeCLbpKrZLfaDWvKd4/fGQkKbHGBXfiZ/mTcfcEq39ed3TjLEugwBRjJuLC3cjqcpmKCJscZ87CFpMBes2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l8+Ne57Z1DoIaLXqUSeVEuEnoC1Tn4PcPMNsBN6kGzs=;
 b=XUwBuyA0SD5TFm8gvrxRj3t7yyRL9AdN+oBDWGHjCUh9OXlz4ljpIhNvcoGaOe0u6rJEi4NFsHXguXn+8y4KZOHhxWqHlFBKegMbahNIKEli20/clNpcs/gklXCnwVrnpMVHEKa4w/AmVL/o3NETCQnlNrnwl7My9LZtM5vxdAo=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by SJ0PR10MB4446.namprd10.prod.outlook.com (2603:10b6:a03:2d9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.19; Thu, 7 Oct
 2021 15:01:02 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::f4fe:5b4:6bd9:4c5b]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::f4fe:5b4:6bd9:4c5b%6]) with mapi id 15.20.4587.020; Thu, 7 Oct 2021
 15:01:02 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     David Wysochanski <dwysocha@redhat.com>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH RFC 5/5] NFS: Replace dprintk callsites in nfs_readpage(s)
Thread-Topic: [PATCH RFC 5/5] NFS: Replace dprintk callsites in
 nfs_readpage(s)
Thread-Index: AQHXugx45Ev+HCUtEEmdoiu/yqrAbKvHg9gAgAAgVgA=
Date:   Thu, 7 Oct 2021 15:01:02 +0000
Message-ID: <027FEF08-ABD1-47D1-A527-67B4F2184C43@oracle.com>
References: <163345354511.524558.1980332041837428746.stgit@morisot.1015granger.net>
 <163345406901.524558.6277128986656130592.stgit@morisot.1015granger.net>
 <CALF+zOmKJTg-qx2J69QZAhG7KQOfra9noR5=bmaLfAFg1kZf-g@mail.gmail.com>
In-Reply-To: <CALF+zOmKJTg-qx2J69QZAhG7KQOfra9noR5=bmaLfAFg1kZf-g@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=oracle.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 71ea27e1-3b0a-4836-ae8d-08d989a347ee
x-ms-traffictypediagnostic: SJ0PR10MB4446:
x-microsoft-antispam-prvs: <SJ0PR10MB4446F15DD596072EAEB2FDA193B19@SJ0PR10MB4446.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:293;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qxYZr9X7sbs3aEh0I6x/mxFq8X5pzdXRbGvZwg+7bt4zJDlGoiIN3UwA0GiiZHLeT5FQIKjYf1hVQlshdQM1i1pu3bsv/zpkOxt4/pY5QO/tLtJyz6LXpj70meaINtfXXGDWqffhlBT5MUq6kUlqPcMXKp3G1S1dfFHdylxYv+xHAt29Vewef/qO3i3+8N1JSZYmgJCWYiAaEAFXO9AvO0W2INFGVpNse4FB3Syo0H+yuFHg9rTr15IpjSUdQyeLjKfd5vDDawUAjd+fpa6l1Z3glVYmzTuY+xp7/fWVk5bSMM2QGY1YtYwOiKtPjZbasdTwCFzLAFOnScyjetHjLgKlHI5pJgtGeQlSUbZiWFW7s4PgyQQhrJLzImxqjsGd6wLVrKTE14V5wx9nVDQeyskiYZdxdDCGPhY4wef28rB/nKj44VF2m/hb5OYH9ZX8lYmA21kswzCmrx72IVDe1L7dDPoHT+J+Pk1aHhjNcq/Awk85+CsP5RH4nDAXPP63PTTFEoQt7zp7Zp20tm6W0NH/SrSX6djPeRTqAp24JqMUflhol4cuDWRhESUmziV6wW70WN6OsV0pVrGQ3dCOEySfEyjN5BXHfm4fGTE7EJiEH7J/FZs+udtr83b9t4zVFUn/e2pF/n0U3ZxjcWmd44pdkgmNAYgwnHTKNR/uFEsHCj5tMbXS+K8iPn5siN7zZrEKeoBfwLiv0qBGZFgp7lVc2Hex0dapWHwdR3jSPnI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(186003)(38070700005)(316002)(76116006)(91956017)(4326008)(26005)(8936002)(6916009)(8676002)(5660300002)(508600001)(6486002)(53546011)(83380400001)(6506007)(66556008)(71200400001)(38100700002)(6512007)(122000001)(86362001)(36756003)(2906002)(33656002)(2616005)(66446008)(66946007)(66476007)(64756008)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?CIcakTiAZfrP9gTdhCtUiKEEkkTZm0BhhsgS+GjvSIXSVhVl7U/HfzqzOUp+?=
 =?us-ascii?Q?IFm/zzq3kQFT5thEX9I5p6rpfcr576JYwpmfssKxSny+zx0slxzPOQAWRjt4?=
 =?us-ascii?Q?TpAAHGJ42oT6+CkExz2Ous/0V2jttylGutQ/R1Gx2j4u0fXIcOYz8KNe8oxV?=
 =?us-ascii?Q?2u+0pw5tpmHD4FukpA5RMaL1zf4L9xX+mmpffXS7i1j8Ac9Q17K0WVxS7IR2?=
 =?us-ascii?Q?SKLz8Xe2ZzO1fry/FY+G7RhuHSVdTUikz9f4TUM71FSdWKLVY+yj2GCdxGPf?=
 =?us-ascii?Q?trYwbUbej2/49UyMViODKAVAWI3/e6GH0sHvMTPGVanz6rBafujXtG9uVwIf?=
 =?us-ascii?Q?5AHYUOVOTdfm/8wPi8I7rDOtt40Tb0a5nORs0173JI4ACZMSdN/Iifxe9nOS?=
 =?us-ascii?Q?URrsQAObogAorz0R4GWzNaJlhDzxys0sUo20GQkr8pFqLVEXGZLN4zkRgXUV?=
 =?us-ascii?Q?gU5wNkiZGRxvTySFU5J09yI/cUfgWtAm6753oQCuw3PJjyHMkgDSu7XTTh5y?=
 =?us-ascii?Q?+YYcjkM282sjdm9/2lf/K7JkHPivdidYwKplb8qWQfBcHWkiyWc/k/VvpKu2?=
 =?us-ascii?Q?BtVLUVBQqR4q+APXuhwnTUBFhbarkfjqxun8/99TJtdKD5Q/srPel6QfWbby?=
 =?us-ascii?Q?wVhwvzlQARK6Yuf7MyuYnv7Xt5sUFuUUlPJ7EBSUKl4z1PjTWvUQ2ApC+nbR?=
 =?us-ascii?Q?Y6ea2xSuKxyuXuOLz4ufJIlOLNJRdCvsCCdlyncmA+NnkwvQ53ewCSTm+1O7?=
 =?us-ascii?Q?JUmUVWlLa+WiMgRjLgGqh9RXbZeIUPY/X7cA96sj+H6R2fdUrTY4Ritqbd7F?=
 =?us-ascii?Q?ehuyyVfyvYieLa2igQG/NzTEtp2d4Y3vBPH1uW3WC0/EVmApsSrNZwFOn3Ln?=
 =?us-ascii?Q?ZmC2VO2p60BfmmWBWR03hCiPed5LET2XzyX8tqOL9LctB0S82XEsYx2oUSxZ?=
 =?us-ascii?Q?8W98kbErZzIEz6k6qn8c74lHdNeJg6QBHMHMheH6gam1aYbb0D8Vv/3uUGZP?=
 =?us-ascii?Q?UC7LOpAYRSIN1ZJQnOS4G0NMY1oTpj0FLdt9uCxjvvXFc+jqPfA5iWit8z43?=
 =?us-ascii?Q?nFIXarA5D98wB3GLErzzGG2UOtXrwyVAHMR9E4z/qEYL3jO8SccbTuhCfmbj?=
 =?us-ascii?Q?eDt4KPikh8rIHj8asGCEYr+n8bpb1x2d8KTw0VscAM3g2OcxuiyUY8rkpLxD?=
 =?us-ascii?Q?hcGp0IvRKwiMdlc8MWFnTK7Iw3T2Ze/+xcOpntX/BAAUnwRdWu4CUfAlIJkr?=
 =?us-ascii?Q?/2H3SqLiVInfNgfMni5MY8ppGMvvImIGjiBF9nNJVlgQDMWKZrkoyVT9MEtb?=
 =?us-ascii?Q?r5dCBpmqfbLLCZQ4t20LSeWT?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <5C18A281A47F7F49817EA0F102038A9F@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71ea27e1-3b0a-4836-ae8d-08d989a347ee
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Oct 2021 15:01:02.6257
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3u3r/COvi4xSUkOrgPURqNV0HbRwupXKhHiarGY6sR7bXX1iDAVU36V5tI64nGjCRdHEN/ikhorZslVEbkpskw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4446
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10130 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 phishscore=0
 spamscore=0 mlxscore=0 mlxlogscore=999 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2110070098
X-Proofpoint-ORIG-GUID: cyYJk02zJkg2nmkTHE4KX7uQDmX32SlS
X-Proofpoint-GUID: cyYJk02zJkg2nmkTHE4KX7uQDmX32SlS
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Oct 7, 2021, at 9:05 AM, David Wysochanski <dwysocha@redhat.com> wrote=
:
>=20
> On Tue, Oct 5, 2021 at 1:14 PM Chuck Lever <chuck.lever@oracle.com> wrote=
:
> >
> > There are two new events that report slightly different information
> > for readpage and readpages.
> >
> > For readpage:
> >              fsx-1387  [006]   380.761896: nfs_aops_readpage:    fileid=
=3D00:28:2 fhandle=3D0x36fbbe51 version=3D1752899355910932437 page_index=3D=
32
> >
> > The index of a synchronous single-page read is reported.
> >
> > For readpages:
> >
> >              fsx-1387  [006]   380.760847: nfs_aops_readpages:   fileid=
=3D00:28:2 fhandle=3D0x36fbbe51 version=3D1752899355909932456 nr_pages=3D3
> >
> > The count of pages requested is reported. readpages does not wait
> > for the READ requests to complete.
> >
> > Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> > ---
> >  fs/nfs/nfstrace.h |   70 +++++++++++++++++++++++++++++++++++++++++++++=
++++++++
> >  fs/nfs/read.c     |    8 ++----
> >  2 files changed, 72 insertions(+), 6 deletions(-)
> >
> > diff --git a/fs/nfs/nfstrace.h b/fs/nfs/nfstrace.h
> > index e9be65b52bfe..0534d090ee55 100644
> > --- a/fs/nfs/nfstrace.h
> > +++ b/fs/nfs/nfstrace.h
> > @@ -862,6 +862,76 @@ TRACE_EVENT(nfs_sillyrename_unlink,
> >                 )
> >  );
> >
> > +TRACE_EVENT(nfs_aops_readpage,
> > +               TP_PROTO(
> > +                       const struct inode *inode,
> > +                       struct page *page
> > +               ),
> > +
> > +               TP_ARGS(inode, page),
> > +
> > +               TP_STRUCT__entry(
> > +                       __field(dev_t, dev)
> > +                       __field(u32, fhandle)
> > +                       __field(u64, fileid)
> > +                       __field(u64, version)
> > +                       __field(pgoff_t, index)
> > +               ),
> > +
> > +               TP_fast_assign(
> > +                       const struct nfs_inode *nfsi =3D NFS_I(inode);
> > +
> > +                       __entry->dev =3D inode->i_sb->s_dev;
> > +                       __entry->fileid =3D nfsi->fileid;
> > +                       __entry->fhandle =3D nfs_fhandle_hash(&nfsi->fh=
);
> > +                       __entry->version =3D inode_peek_iversion_raw(in=
ode);
> > +                       __entry->index =3D page_index(page);
> > +               ),
> > +
> > +               TP_printk(
> > +                       "fileid=3D%02x:%02x:%llu fhandle=3D0x%08x versi=
on=3D%llu page_index=3D%lu",
> > +                       MAJOR(__entry->dev), MINOR(__entry->dev),
> > +                       (unsigned long long)__entry->fileid,
> > +                       __entry->fhandle, __entry->version,
> > +                       __entry->index
> > +               )
> > +);
> > +
> > +TRACE_EVENT(nfs_aops_readpages,
> > +               TP_PROTO(
> > +                       const struct inode *inode,
> > +                       unsigned int nr_pages
> > +               ),
> > +
> > +               TP_ARGS(inode, nr_pages),
> > +
> > +               TP_STRUCT__entry(
> > +                       __field(dev_t, dev)
> > +                       __field(u32, fhandle)
> > +                       __field(u64, fileid)
> > +                       __field(u64, version)
> > +                       __field(unsigned int, nr_pages)
> > +               ),
> > +
> > +               TP_fast_assign(
> > +                       const struct nfs_inode *nfsi =3D NFS_I(inode);
> > +
> > +                       __entry->dev =3D inode->i_sb->s_dev;
> > +                       __entry->fileid =3D nfsi->fileid;
> > +                       __entry->fhandle =3D nfs_fhandle_hash(&nfsi->fh=
);
> > +                       __entry->version =3D inode_peek_iversion_raw(in=
ode);
> > +                       __entry->nr_pages =3D nr_pages;
> > +               ),
> > +
> > +               TP_printk(
> > +                       "fileid=3D%02x:%02x:%llu fhandle=3D0x%08x versi=
on=3D%llu nr_pages=3D%u",
> > +                       MAJOR(__entry->dev), MINOR(__entry->dev),
> > +                       (unsigned long long)__entry->fileid,
> > +                       __entry->fhandle, __entry->version,
> > +                       __entry->nr_pages
> > +               )
> > +);
> > +
> >  TRACE_EVENT(nfs_initiate_read,
> >                 TP_PROTO(
> >                         const struct nfs_pgio_header *hdr
> > diff --git a/fs/nfs/read.c b/fs/nfs/read.c
> > index 08d6cc57cbc3..94690eda2a88 100644
> > --- a/fs/nfs/read.c
> > +++ b/fs/nfs/read.c
> > @@ -337,8 +337,7 @@ int nfs_readpage(struct file *file, struct page *pa=
ge)
> >         struct inode *inode =3D page_file_mapping(page)->host;
> >         int ret;
> >
> > -       dprintk("NFS: nfs_readpage (%p %ld@%lu)\n",
> > -               page, PAGE_SIZE, page_index(page));
> > +       trace_nfs_aops_readpage(inode, page);
> >         nfs_inc_stats(inode, NFSIOS_VFSREADPAGE);
> >
> >         /*
> > @@ -403,10 +402,7 @@ int nfs_readpages(struct file *file, struct addres=
s_space *mapping,
> >         struct inode *inode =3D mapping->host;
> >         int ret;
> >
> > -       dprintk("NFS: nfs_readpages (%s/%Lu %d)\n",
> > -                       inode->i_sb->s_id,
> > -                       (unsigned long long)NFS_FILEID(inode),
> > -                       nr_pages);
> > +       trace_nfs_aops_readpages(inode, nr_pages);
> >         nfs_inc_stats(inode, NFSIOS_VFSREADPAGES);
> >
> >         ret =3D -ESTALE;
> >
> >
>=20
> I added this on top of my fscache patches and have been testing.
> Should we be tracing (only?) the return point with the return
> value?

The purpose of the entry point is: you get a timestamp, filehandle
information, and you know what is driving the READ request (sync
read or async readahead).

There is a dprintk() at the top of the function as well as a
performance metric counter, but there currently isn't a dprintk()
at the bottom of the function. So I assumed the return code is
not a critical piece of information. I'm willing to be educated,
though.

A return point trace event could be generated only when there
is an unexpected error condition, for example, to reduce trace
log noise?


>          bigfile-6279    [004] ..... 11550.387232: nfs_aops_readpages: fi=
leid=3D00:2f:26127 fhandle=3D0xb6d0e8f0 version=3D1633611037513339503 nr_pa=
ges=3D32
>          bigfile-6279    [004] ..... 11550.387236: nfs_fscache_page_event=
_read: fileid=3D00:2f:26127 fhandle=3D0xb6d0e8f0 offset=3D0 count=3D4096
>          bigfile-6279    [004] ..... 11550.387237: nfs_fscache_page_event=
_read_done: fileid=3D00:2f:26127 fhandle=3D0xb6d0e8f0 offset=3D0 count=3D40=
96 error=3D-105
>          bigfile-6279    [004] ..... 11550.387248: nfs_fscache_page_event=
_read: fileid=3D00:2f:26127 fhandle=3D0xb6d0e8f0 offset=3D4096 count=3D4096
>          bigfile-6279    [004] ..... 11550.387248: nfs_fscache_page_event=
_read_done: fileid=3D00:2f:26127 fhandle=3D0xb6d0e8f0 offset=3D4096 count=
=3D4096 error=3D-105
>          bigfile-6279    [004] ..... 11550.387250: nfs_fscache_page_event=
_read: fileid=3D00:2f:26127 fhandle=3D0xb6d0e8f0 offset=3D8192 count=3D4096
>          bigfile-6279    [004] ..... 11550.387250: nfs_fscache_page_event=
_read_done: fileid=3D00:2f:26127 fhandle=3D0xb6d0e8f0 offset=3D8192 count=
=3D4096 error=3D-105


--
Chuck Lever



