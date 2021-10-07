Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D84D425812
	for <lists+linux-nfs@lfdr.de>; Thu,  7 Oct 2021 18:37:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242095AbhJGQjE (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 7 Oct 2021 12:39:04 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:39870 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233594AbhJGQjE (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 7 Oct 2021 12:39:04 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 197GQ65S029746;
        Thu, 7 Oct 2021 16:37:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=JzvYqaSeVyLZwsO9E7QaVK/FsyXKBUYUBOaDA7BvWcM=;
 b=xCJM5GN9SCmAfcwWQXDn1+PJvSLsuXAGhDaCzdo1dwkAJBQwDLInr7bC6aNNOnbGdEJt
 gf/fZH4uMiBNm3YXJa8pWis+fW0c57oyKjXnrfAd0XgrF5rth/WBsfs3IOlbktDHhmih
 yhtWjp+XetGyBgyZ8RgDfUIn9E4Ab0lItNEsI7HGz4E31/hDckEyXGVvTWM4gZEFpJ4o
 l5z7D5/g3gBi03JIWTKEIZOA/H65Qruzd63ZdWWechu0EDKqOs27M0gmLVAux55KvvLT
 gV52WrZCkSm4UI0XmLbzq3wYNuPi+h92TyjKw6J53HQT/xJSUNBs7ff2lljSA1vunz9q IA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bj02jj3dm-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 Oct 2021 16:37:07 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 197FUnhA190664;
        Thu, 7 Oct 2021 15:31:10 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2046.outbound.protection.outlook.com [104.47.51.46])
        by userp3030.oracle.com with ESMTP id 3bf0saeb40-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 Oct 2021 15:31:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lydp04JWELofVgZRU16SErDQJWxg6NrjSgvoHnpN+qJqPuPYm1ajczQuBLf27v90Ow3D9qaPslCcLlsrx0y+gR8g+j6UcNnaoqhR7zuvelonU1gDxnySSsW8qv9udF5UIghS0HTtJ3ei17xsNuQafe5gnjfwVFBu0pSWcPnNovKi0YMs2enkmADWKBiUzwoz0hq4tthI6LfCdFoDY9H1KOnfq75NdHuxT994VrKkxsq69QIacn5DNsZUIAIdmm7Lk6naRSbQk+SZCSZlCKuWbH/sm3zclpElNA2WYLU1olXEqOzxXuiOKnnFIzKLI2YfzfmeTYAjpICPZ5r+f8Kh/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JzvYqaSeVyLZwsO9E7QaVK/FsyXKBUYUBOaDA7BvWcM=;
 b=jfblFg7JGYW/lTUpPWbCnw+TaXv2gBamY1GHasJG8TDqejGBSXprWI2bCsiIgMmVLef2aXgfo9f/roMHmWu8YiVOfN7IFSG0p/jafc1DvjZKTaatqpnp9nJuvKNPIvmnJPS3iI9Hr07nqC3LmE2luTB1O8oc16dTlK1jLZLYXGXo3DaAeizSRPDZJ42/FneflFRgpSrAVWAjAYlh5iYz/FM6FOrlrqTs4txaltYvSyTYpHBI0XSlQwYjSidhHcHizyfIy8yKw8me8jyBqBDYUPisA+1Z4tNJF7wevg6f4PZFlHuAgjZk+/oAOVMVZ+bRjVFe92cgQTEojG72vKHzuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JzvYqaSeVyLZwsO9E7QaVK/FsyXKBUYUBOaDA7BvWcM=;
 b=r6NfeVa052rWpEploqmA9cX1Y0P4U0P5ipbRQU5mwgFNBRfCeP+/fRtTiWiFPDndzB761Y5IjTaHkjeMyse2jwbMSNK7U+QgggG3dtAMfjFTLylJEFBT+7EEDFoi0Kwp3XDvSarNG9oChm9BpH6JAh+WNRj07sq8DWrRSid5KPY=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by BYAPR10MB3557.namprd10.prod.outlook.com (2603:10b6:a03:125::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.22; Thu, 7 Oct
 2021 15:31:07 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::f4fe:5b4:6bd9:4c5b]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::f4fe:5b4:6bd9:4c5b%6]) with mapi id 15.20.4587.020; Thu, 7 Oct 2021
 15:31:07 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     David Wysochanski <dwysocha@redhat.com>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH RFC 5/5] NFS: Replace dprintk callsites in nfs_readpage(s)
Thread-Topic: [PATCH RFC 5/5] NFS: Replace dprintk callsites in
 nfs_readpage(s)
Thread-Index: AQHXugx45Ev+HCUtEEmdoiu/yqrAbKvHg9gAgAAgVgCAAAbzAIAAAXeA
Date:   Thu, 7 Oct 2021 15:31:07 +0000
Message-ID: <E1387930-9DD0-45ED-AF11-82D12692E6B8@oracle.com>
References: <163345354511.524558.1980332041837428746.stgit@morisot.1015granger.net>
 <163345406901.524558.6277128986656130592.stgit@morisot.1015granger.net>
 <CALF+zOmKJTg-qx2J69QZAhG7KQOfra9noR5=bmaLfAFg1kZf-g@mail.gmail.com>
 <027FEF08-ABD1-47D1-A527-67B4F2184C43@oracle.com>
 <CALF+zOnHf04LYt-weSB2vwpLZNZMe71_r-dOc2uztnwmJQesHQ@mail.gmail.com>
In-Reply-To: <CALF+zOnHf04LYt-weSB2vwpLZNZMe71_r-dOc2uztnwmJQesHQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=oracle.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b20671ec-e35a-4f47-29b8-08d989a77bbe
x-ms-traffictypediagnostic: BYAPR10MB3557:
x-microsoft-antispam-prvs: <BYAPR10MB3557D28E7076596E50A1C75C93B19@BYAPR10MB3557.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1051;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AFzDcPpAFhx1pcng+0AVLU1K6Ubxp5Ivu/d9b1cUt5erp5Qgc8HXl+gdoRkky4zgEvEXgaOZKtHzEP7tMYpgu/+5QNk5Pzy69rHHW63v+GdcW52WchTqwW4q3wl5q/gVb3iNedBjalKVoPb0GGTxPIqXs3gADvdljOmKGK+vkuDzXv47EUMf8byWnkBz7rqsr8CXd9ZzVlnzQWXqQ1XVZqCwdH+GIddsvR/JJDIugHMmuPlzWcuV58HgSW/wLSknIb8w5rTxF5BTWTe7ixY3D9wED2S0vug/Ecf9UUhb7gf+7CS/BC9LEGnd4tMzLeYuykukEsdKw7FQjw1M3zwjunQ6xVzgpYvwGBG2+I2H8t6Ugucw9Cl4Ur+YCb6iZS8+1HjDTpym0qm/1tgNaby2jySXlOaN3lmfKY7t7Kz1S17/JeyIWaJVgovvkmTkpbMW5PT9P4Ry7T6JNqNIs7DrurZ+xSdhoHebIUphENdNs9Hho683NenvuOU2oIrREWTsQLOufMm8QQ+QFbVRfNUCRqpmbxoPt8cCW2IRC84G8A/nq0y/21PmrXjY7wZ5RYDV8ERllR8yjaPYWLH8BuaDJbdjuuFBH/dCi4srhap6lK68DXlDEKEjyU+39WB10sD+eUzak/mQhV23HbnGNAY2bvR+Z20tc18EZFwUzQPTkN68BvGcsXOFvQcQONExZQPZEc0u7LZClKBdIF9ffsRaJ7p1mWV4hNoEDsvXT1OTPOxNY/vXMP25Cp+mNCGps/iF
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(36756003)(76116006)(91956017)(66946007)(66446008)(71200400001)(66476007)(6512007)(2906002)(8936002)(38100700002)(33656002)(6486002)(122000001)(4326008)(26005)(38070700005)(86362001)(6506007)(186003)(53546011)(6916009)(316002)(508600001)(66556008)(64756008)(2616005)(8676002)(5660300002)(83380400001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?IVbgTG8uFqLDKHfSrdo6Z5uoWF+iRLFMvU4yFi+Tpd3IXNG8huhI4Rs/lBm5?=
 =?us-ascii?Q?Ck3FVFibXmsEPRLoqNysbQJIiIlggEENW0tzKSw+GHPDPE/OqmY6bJLZaLwZ?=
 =?us-ascii?Q?1jOkD4d2fH35z9VHzCpW12GZTomjD6sqUjwb0v5ZP7MyuaS4k2+AFQj1KDvy?=
 =?us-ascii?Q?kEoybn6/FxCemOdpzuJrXt13yIBVTqvS4DxsHIPwi4VPHQMh8OEiOqsvV4Fg?=
 =?us-ascii?Q?CqXH4JMqXznDSOs5o4wgt4fcwchS9H7i01SIQJGmzUIiphe8blLMCgKE9Ut9?=
 =?us-ascii?Q?Kapq1+Kk9SWNvlqBaDjSwUOKN65x4exUP9EQvm6+XC7G6Q+iYyb0OPUsZO03?=
 =?us-ascii?Q?vsj0a5IiwtSKUiXnryWSCVm2z3sdhDtsInGUsSkLBL3Pz3YI4J59XM5rrfKJ?=
 =?us-ascii?Q?aoEdxvpqSRqr5OtkwwyeghUVzfu6Kug226cguV3gCXvE3a0r/H8m8yDVhktx?=
 =?us-ascii?Q?mvX+qZE6jiSFDYDzvvQRYIZp/aXWOiNlblpjBoFfIkIHxJ/5recqBdVSyyu8?=
 =?us-ascii?Q?a3Co+/9QCZZ5pZxVtwg5pW3NUNhtvGhjvYCWaBngZ3KvACnzV1wSCPzC2a6q?=
 =?us-ascii?Q?sR/Gbkcnrtf+YbpuJKisqOp8ZhXg+wuPG7EUSwVusYQZgetTHXQcAXf7sz3+?=
 =?us-ascii?Q?N/1coCj5gfGK+da/B4VD6F3t9W87vpOpveeqWwchTVvK2iRX7DD5CFMe8mHf?=
 =?us-ascii?Q?k1zRvlZdaTBmdp8Ceafado6FbUnKvtWkI4FImXizg1fDPUWCp030pLKfY4tX?=
 =?us-ascii?Q?sRkkrDWrBnUL2AiPISE2RMX8raNm8lPzZVpL5BrLLDcwr3UJdMIgg3pprcHT?=
 =?us-ascii?Q?yB2afS537CrP/JJKQPi5WJBMAvp3Pj9cc3XR2m7jGzZPXTu1U/1KYMHaMAP2?=
 =?us-ascii?Q?Ug6X/SgX9xKcAb1RNBVMjBtSaMo5XKNAqFCmldcTt+CpZ0XAdr+GsIH1vewq?=
 =?us-ascii?Q?2OabybO2y9GA4UJlroGvpdGbtE6Aegn+E9rmair5+Ud5UWDzPeOMOKFtp0gO?=
 =?us-ascii?Q?5Ur7V4iUG+yp54ZX+R2WpIAstANmiu2RZ2s44xmr5BW6uFvatx1T7MMX/umW?=
 =?us-ascii?Q?TFdvQLMshpXo/I/7gY8aQycA7ICY8Jo3HBPkwa09kMOHSRDzhoJ0bAjprTlj?=
 =?us-ascii?Q?42sEIiys79OUpDem0Mmh5nOeJV6XkEwL6oxvjjpBuUBqcY7ANt8Q52N7kSI3?=
 =?us-ascii?Q?Y7FgXh8dedUOMyL2DM12r7pAKGzW1Wi+eJYuqGrf0W7rWyq3b3rErRhiujG8?=
 =?us-ascii?Q?Dm0YatrsDGRMGo356d/W3TaMTvVpBjq4CoMHwYKyZ3UNF33cvFP0NW8Cm8r2?=
 =?us-ascii?Q?tMBltvrtZEfkhYXVNe8zzzgv?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <38EFC1549F0F4D4DA19CC37576269538@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b20671ec-e35a-4f47-29b8-08d989a77bbe
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Oct 2021 15:31:07.7204
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yX+tW94tHPMvhHm7PGg/faLTiQUqp3QJ4LGj1LV+bFJWJN1Dzcl4cpjke73MiZPABQoeyutdg64ov4ghAw9F3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3557
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10130 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 adultscore=0
 mlxscore=0 phishscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2110070101
X-Proofpoint-ORIG-GUID: Uz5WsVc6Pe34I_6DjNGipQzdQrLVO2bc
X-Proofpoint-GUID: Uz5WsVc6Pe34I_6DjNGipQzdQrLVO2bc
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Oct 7, 2021, at 11:25 AM, David Wysochanski <dwysocha@redhat.com> wrot=
e:
>=20
> On Thu, Oct 7, 2021 at 11:01 AM Chuck Lever III <chuck.lever@oracle.com> =
wrote:
>>=20
>>=20
>>=20
>>> On Oct 7, 2021, at 9:05 AM, David Wysochanski <dwysocha@redhat.com> wro=
te:
>>>=20
>>> On Tue, Oct 5, 2021 at 1:14 PM Chuck Lever <chuck.lever@oracle.com> wro=
te:
>>>>=20
>>>> There are two new events that report slightly different information
>>>> for readpage and readpages.
>>>>=20
>>>> For readpage:
>>>>             fsx-1387  [006]   380.761896: nfs_aops_readpage:    fileid=
=3D00:28:2 fhandle=3D0x36fbbe51 version=3D1752899355910932437 page_index=3D=
32
>>>>=20
>>>> The index of a synchronous single-page read is reported.
>>>>=20
>>>> For readpages:
>>>>=20
>>>>             fsx-1387  [006]   380.760847: nfs_aops_readpages:   fileid=
=3D00:28:2 fhandle=3D0x36fbbe51 version=3D1752899355909932456 nr_pages=3D3
>>>>=20
>>>> The count of pages requested is reported. readpages does not wait
>>>> for the READ requests to complete.
>>>>=20
>>>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>>>> ---
>>>> fs/nfs/nfstrace.h |   70 +++++++++++++++++++++++++++++++++++++++++++++=
++++++++
>>>> fs/nfs/read.c     |    8 ++----
>>>> 2 files changed, 72 insertions(+), 6 deletions(-)
>>>>=20
>>>> diff --git a/fs/nfs/nfstrace.h b/fs/nfs/nfstrace.h
>>>> index e9be65b52bfe..0534d090ee55 100644
>>>> --- a/fs/nfs/nfstrace.h
>>>> +++ b/fs/nfs/nfstrace.h
>>>> @@ -862,6 +862,76 @@ TRACE_EVENT(nfs_sillyrename_unlink,
>>>>                )
>>>> );
>>>>=20
>>>> +TRACE_EVENT(nfs_aops_readpage,
>>>> +               TP_PROTO(
>>>> +                       const struct inode *inode,
>>>> +                       struct page *page
>>>> +               ),
>>>> +
>>>> +               TP_ARGS(inode, page),
>>>> +
>>>> +               TP_STRUCT__entry(
>>>> +                       __field(dev_t, dev)
>>>> +                       __field(u32, fhandle)
>>>> +                       __field(u64, fileid)
>>>> +                       __field(u64, version)
>>>> +                       __field(pgoff_t, index)
>>>> +               ),
>>>> +
>>>> +               TP_fast_assign(
>>>> +                       const struct nfs_inode *nfsi =3D NFS_I(inode);
>>>> +
>>>> +                       __entry->dev =3D inode->i_sb->s_dev;
>>>> +                       __entry->fileid =3D nfsi->fileid;
>>>> +                       __entry->fhandle =3D nfs_fhandle_hash(&nfsi->f=
h);
>>>> +                       __entry->version =3D inode_peek_iversion_raw(i=
node);
>>>> +                       __entry->index =3D page_index(page);
>>>> +               ),
>>>> +
>>>> +               TP_printk(
>>>> +                       "fileid=3D%02x:%02x:%llu fhandle=3D0x%08x vers=
ion=3D%llu page_index=3D%lu",
>>>> +                       MAJOR(__entry->dev), MINOR(__entry->dev),
>>>> +                       (unsigned long long)__entry->fileid,
>>>> +                       __entry->fhandle, __entry->version,
>>>> +                       __entry->index
>>>> +               )
>>>> +);
>>>> +
>>>> +TRACE_EVENT(nfs_aops_readpages,
>>>> +               TP_PROTO(
>>>> +                       const struct inode *inode,
>>>> +                       unsigned int nr_pages
>>>> +               ),
>>>> +
>>>> +               TP_ARGS(inode, nr_pages),
>>>> +
>>>> +               TP_STRUCT__entry(
>>>> +                       __field(dev_t, dev)
>>>> +                       __field(u32, fhandle)
>>>> +                       __field(u64, fileid)
>>>> +                       __field(u64, version)
>>>> +                       __field(unsigned int, nr_pages)
>>>> +               ),
>>>> +
>>>> +               TP_fast_assign(
>>>> +                       const struct nfs_inode *nfsi =3D NFS_I(inode);
>>>> +
>>>> +                       __entry->dev =3D inode->i_sb->s_dev;
>>>> +                       __entry->fileid =3D nfsi->fileid;
>>>> +                       __entry->fhandle =3D nfs_fhandle_hash(&nfsi->f=
h);
>>>> +                       __entry->version =3D inode_peek_iversion_raw(i=
node);
>>>> +                       __entry->nr_pages =3D nr_pages;
>>>> +               ),
>>>> +
>>>> +               TP_printk(
>>>> +                       "fileid=3D%02x:%02x:%llu fhandle=3D0x%08x vers=
ion=3D%llu nr_pages=3D%u",
>>>> +                       MAJOR(__entry->dev), MINOR(__entry->dev),
>>>> +                       (unsigned long long)__entry->fileid,
>>>> +                       __entry->fhandle, __entry->version,
>>>> +                       __entry->nr_pages
>>>> +               )
>>>> +);
>>>> +
>>>> TRACE_EVENT(nfs_initiate_read,
>>>>                TP_PROTO(
>>>>                        const struct nfs_pgio_header *hdr
>>>> diff --git a/fs/nfs/read.c b/fs/nfs/read.c
>>>> index 08d6cc57cbc3..94690eda2a88 100644
>>>> --- a/fs/nfs/read.c
>>>> +++ b/fs/nfs/read.c
>>>> @@ -337,8 +337,7 @@ int nfs_readpage(struct file *file, struct page *p=
age)
>>>>        struct inode *inode =3D page_file_mapping(page)->host;
>>>>        int ret;
>>>>=20
>>>> -       dprintk("NFS: nfs_readpage (%p %ld@%lu)\n",
>>>> -               page, PAGE_SIZE, page_index(page));
>>>> +       trace_nfs_aops_readpage(inode, page);
>>>>        nfs_inc_stats(inode, NFSIOS_VFSREADPAGE);
>>>>=20
>>>>        /*
>>>> @@ -403,10 +402,7 @@ int nfs_readpages(struct file *file, struct addre=
ss_space *mapping,
>>>>        struct inode *inode =3D mapping->host;
>>>>        int ret;
>>>>=20
>>>> -       dprintk("NFS: nfs_readpages (%s/%Lu %d)\n",
>>>> -                       inode->i_sb->s_id,
>>>> -                       (unsigned long long)NFS_FILEID(inode),
>>>> -                       nr_pages);
>>>> +       trace_nfs_aops_readpages(inode, nr_pages);
>>>>        nfs_inc_stats(inode, NFSIOS_VFSREADPAGES);
>>>>=20
>>>>        ret =3D -ESTALE;
>>>>=20
>>>>=20
>>>=20
>>> I added this on top of my fscache patches and have been testing.
>>> Should we be tracing (only?) the return point with the return
>>> value?
>>=20
>> The purpose of the entry point is: you get a timestamp, filehandle
>> information, and you know what is driving the READ request (sync
>> read or async readahead).
>>=20
>> There is a dprintk() at the top of the function as well as a
>> performance metric counter, but there currently isn't a dprintk()
>> at the bottom of the function. So I assumed the return code is
>> not a critical piece of information. I'm willing to be educated,
>> though.
>>=20
>=20
> Well, I was trying to understand the various approaches in nfstrace.h.
> There are tracepoints that are paired with entry and exit, but I guess
> these have multiple pieces of information that may change from
> start to finish.  Examples:
> nfs_refresh_inode_enter
> nfs_refresh_inode_exit
> nfs_lookup_revalidate_enter
> nfs_lookup_revalidate_exit

These were added over many years by several different people.
Unfortunately there isn't much strategy here at this point.

But yes, especially for nfs_readpages, the *pages argument
is a list that is drained by read_cache_pages() so it wouldn't
have the same value at the end of the function (not that the
trace point is recording it, but you get the idea).


>> A return point trace event could be generated only when there
>> is an unexpected error condition, for example, to reduce trace
>> log noise?
>>=20
> Ok so you would just add a second tracepoint for non-zero returns?

So for I/O operations, there is precedent for recording the
completion with a _done trace event. I'm redriving this patch
to include an unconditional return point trace event. Stand by...


>>>         bigfile-6279    [004] ..... 11550.387232: nfs_aops_readpages: f=
ileid=3D00:2f:26127 fhandle=3D0xb6d0e8f0 version=3D1633611037513339503 nr_p=
ages=3D32
>>>         bigfile-6279    [004] ..... 11550.387236: nfs_fscache_page_even=
t_read: fileid=3D00:2f:26127 fhandle=3D0xb6d0e8f0 offset=3D0 count=3D4096
>>>         bigfile-6279    [004] ..... 11550.387237: nfs_fscache_page_even=
t_read_done: fileid=3D00:2f:26127 fhandle=3D0xb6d0e8f0 offset=3D0 count=3D4=
096 error=3D-105
>>>         bigfile-6279    [004] ..... 11550.387248: nfs_fscache_page_even=
t_read: fileid=3D00:2f:26127 fhandle=3D0xb6d0e8f0 offset=3D4096 count=3D409=
6
>>>         bigfile-6279    [004] ..... 11550.387248: nfs_fscache_page_even=
t_read_done: fileid=3D00:2f:26127 fhandle=3D0xb6d0e8f0 offset=3D4096 count=
=3D4096 error=3D-105
>>>         bigfile-6279    [004] ..... 11550.387250: nfs_fscache_page_even=
t_read: fileid=3D00:2f:26127 fhandle=3D0xb6d0e8f0 offset=3D8192 count=3D409=
6
>>>         bigfile-6279    [004] ..... 11550.387250: nfs_fscache_page_even=
t_read_done: fileid=3D00:2f:26127 fhandle=3D0xb6d0e8f0 offset=3D8192 count=
=3D4096 error=3D-105
>=20
> Example:
> bigfile-6279    [004] ..... 11550.387252: nfs_aops_readpages_error:
> fileid=3D00:2f:26127 fhandle=3D0xb6d0e8f0 version=3D1633611037513339503
> nr_pages=3D6 error=3D-5
>=20
>=20
>=20
>>=20
>> --
>> Chuck Lever

--
Chuck Lever



