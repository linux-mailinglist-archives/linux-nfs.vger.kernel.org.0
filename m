Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9BC963AB08
	for <lists+linux-nfs@lfdr.de>; Mon, 28 Nov 2022 15:31:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230306AbiK1Ob5 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 28 Nov 2022 09:31:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232553AbiK1Obk (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 28 Nov 2022 09:31:40 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C869623143
        for <linux-nfs@vger.kernel.org>; Mon, 28 Nov 2022 06:30:59 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2ASDiOS1031967
        for <linux-nfs@vger.kernel.org>; Mon, 28 Nov 2022 14:30:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type : content-id :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=r/Pj3J3NvBgCu92KdYVDy2u0PVTstNbxPT7wkNVOplM=;
 b=sddiWvoeGsgrDealkjldQoDs9f58W8AsFiT7CBrkNwGLEFptQ219pwcm+OjCjBDjTVJx
 mvubWQqlMIub9lxVeRlzZ12T0EO26g1Dwht2ABitpRkkZPlxf6wrER811Gk5qRp1tBHC
 +AmzPdc4Cx0fvh7OhdxbzjdoKsrltrBeBTSv2aHY7O1+076XbbofopZYWsAkjoqtOjkE
 sFW+DePRu5bEKaFQ3WGpMiZB9JCYN0J8yiX0/uOvGS3TGLW56CaX7rZapq8j7+gF6pPM
 RFz7FA4JhR1w+TWnUAFwpOLOv0iobCqa5ZyAmAyjGIqzhTRkJaaSMv8/p76WQWUXj3GZ GA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3m4aem9va4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-nfs@vger.kernel.org>; Mon, 28 Nov 2022 14:30:59 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2ASDUTAo027963
        for <linux-nfs@vger.kernel.org>; Mon, 28 Nov 2022 14:30:58 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2176.outbound.protection.outlook.com [104.47.56.176])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3m39859rtc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-nfs@vger.kernel.org>; Mon, 28 Nov 2022 14:30:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XV/3JrOgOHc/SjwuHBA5ZxlM9ZMqHZwlYATwkeIcwQZE7TlteefKOkaJumUk9qiGAe5mhF+p0hs04qPDruRXUQwlxZyLGsQpkIjiBEyogXOWlAw00t5zh0c/Rel0Hf3ECokLwCMHbLFYpVv0hHJM2OsjKvIHnKfY/y0eOdHNjssk6y3GujnbuNla47wo0HMbzPMX/ujJc5lyJ4d9HudeyZlEJd/RfuZ+QImF7fAnF2q1FMT7ONKRE6c6QGyo7y1QqGhA+Ki+c/Fcn6JTuxXF0/ytVIXCA2kfojSfXC8qz+FTi5clWOJXoHA2i7v/XNE3QqTXDuk4cixa4L+KbXukUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r/Pj3J3NvBgCu92KdYVDy2u0PVTstNbxPT7wkNVOplM=;
 b=egrjzSHtQg1YyBhsxw441rYWQXYB/RQwoJllAFM9w6WpcYu8oTOul4OnxA14dcsIQKbXm+B2IYcp50Imn5lplA2ZQZMISbUsIGqer+4fwTDwCSFFsnVwkCVyqy3LqCDqvg3bf93sg0LSB3mlfIq/BhWUG7FF8ovDkff9KtqS7OiI1Ozd2ZirqAvDDvf3PFIgAiC8XIbzTdbjHZ1q9XmBPGHYc8ei/jhIbD66EJtQomY1t/iKlchnG/MOvQrqrNWEGrbld4E72nyYtLXB5+Hp2EFNPBNPq8/uU5lncgnN68fyQ4/ggL+2G6tV9nbA1lUTmZf7xMdI+ZXVOrCnHZo6Kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r/Pj3J3NvBgCu92KdYVDy2u0PVTstNbxPT7wkNVOplM=;
 b=PcIya8PkUiBVIszkknUZt0CaqBRDwoCHsXdVyf31r62gO3r5rLO0FVvqruGsHyHx+r5AiAki28HNuHs34NvOWclTgAgmzZKi+Zv9PWvU1Fb1gPLTFvT1pFCm/+p619ZxpzPq9KtWGOo5ytfAnG9Z/3wOI8D6vqowgCkSj4MvgFE=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CY8PR10MB6588.namprd10.prod.outlook.com (2603:10b6:930:57::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Mon, 28 Nov
 2022 14:30:56 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::b500:ee42:3ca6:8a9e]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::b500:ee42:3ca6:8a9e%6]) with mapi id 15.20.5857.023; Mon, 28 Nov 2022
 14:30:56 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] SUNRPC: Fix crasher in unwrap_integ_data()
Thread-Topic: [PATCH] SUNRPC: Fix crasher in unwrap_integ_data()
Thread-Index: AQHZAoQmzavTBIzL1kiUAKK/+ro4Ma5UZwOA
Date:   Mon, 28 Nov 2022 14:30:56 +0000
Message-ID: <00CA9FDF-1605-4FA5-8E77-320D55867F4A@oracle.com>
References: <166956944745.113279.2771726273440100988.stgit@klimt.1015granger.net>
In-Reply-To: <166956944745.113279.2771726273440100988.stgit@klimt.1015granger.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|CY8PR10MB6588:EE_
x-ms-office365-filtering-correlation-id: fd0224a2-ccb8-45fe-d4ec-08dad14d2962
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yRLu4AjR+FZPn9faZmndJpSazka6Z/yBrtNZkbhEpV7k/Zgb+T9uoPScHVqMN4f9jzW+bElRwz0AGhegsvlim13ZD21Yi5WhIYW1YeqVCDc17h8vC+g22QH7j+osqxq1+WDamLcB9WgBuawi/Up+OWt6lqcyyKNkNUsKJjpxYSCx023viwkd5DOxgrz2fUdx+9F2Js28bymyNm7X2nLTTAHJfBLIfJxpHSYacBnqYMnNfLa/AaTmgejypN7f4ojW8kBAsiv9VBahJbUldh1Gi0tO52I2jyVHKDzI6wcz9UCwpmxm1q9ep+bq3Lcm9+e6Oq+ZSYdoHml1AL3vuyaQGtlqAiSMwDEz7+mHXxDtAsnV0uOl3YIv35Q8mNv6dD+FFA0DnEkHfJJF2nnybJ2SS5I2QJjgUZ+KMDM52m/rqMT9/hxPp9gz+luMPtWimd0o9XhZQw92x2ei+GGffEMFfDvdJTKCrjLpQE6DWB6vyYgIQwGKDufvpRR3LZUMpFQ/ouCxmSV6B2I3wUJapd9MDWchGy8vtaG12hCaXcNiajCO2sWpPPEP4yuaOPIahvcTqr11TL7lmLJ6zP3PNsiBZDbLL8gZhrj6mxrOyQQLUdtKac+z97V3pKmFDj0LPlewTgYTDLvC7yAOWSBphY2XWDUS9GlZ/68fLC3R8yu5nGgYXOdBYRli7SeLWVs+trWiq5kCPO2YOz27SH1RmejFzwkF72O/eIwkfIL+bVLZsDw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(376002)(366004)(346002)(39860400002)(136003)(451199015)(2906002)(8936002)(316002)(41300700001)(5660300002)(66946007)(76116006)(8676002)(66556008)(64756008)(66446008)(66476007)(91956017)(6506007)(36756003)(6486002)(71200400001)(38100700002)(478600001)(2616005)(186003)(86362001)(53546011)(26005)(6916009)(6512007)(122000001)(33656002)(83380400001)(38070700005)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?cQamlwKPPRuQElfrJCqTNFi82z8cJ2VrjwzUibPF8aAqnpXJ+mG7fxOL/Xpx?=
 =?us-ascii?Q?OWBm7Zr7EzqtnDq4ebpzv7QAYZenXYq70v8eFHb57+mxoGGZSPI4OK9Kcqon?=
 =?us-ascii?Q?rqCdcTtXXoSp1OFHIPZCl8GwE5aqw2JxEoXlDGVJnSf19UgyY3uitb5522RR?=
 =?us-ascii?Q?cv3Tts4qmyrTgyjGOkn8KKW9AbGYOwOAMM7ireokQoAMnX10bCgxrKRhYA2I?=
 =?us-ascii?Q?+P+1bQqcsMeQnRSM5f1VQs/bwdVRG/ITFFbhUsgXal8rLgomfQROYPoqMC8E?=
 =?us-ascii?Q?UfZVcv5AybuKog+Peysm8C+aAVShmiza2Sdjin9j/bMs2Uq5Fx2TDV7DneM0?=
 =?us-ascii?Q?iKOE09oPN5veEcMUKCJLDS2C2Y5ARqxiyGOQMumStIo+67hMPws5ZY2sLfBY?=
 =?us-ascii?Q?AuoK1f0TuDNXGVga2hKoR6CXVk30AZZtdyzN5oom7MDrnv1WWrvnHKUJ8fYO?=
 =?us-ascii?Q?Lqxzabwssf85C3um9XcUOYFkdMuJztvwe5Rob5NCnaMocu3GYgoBqJtXdD/F?=
 =?us-ascii?Q?jF6KYbM879c15+WUlqBj4K3nHwvCp474bYfQWO1WZ+8O7Tq1EymeyTwr95Jt?=
 =?us-ascii?Q?b370phbDCdVjG269zZvBKJfka/1EsZzGPgcsUiFHzdw3jYVcS+x19p+BGykC?=
 =?us-ascii?Q?lYu4gOt0wS4fW0lGXytMyPgVOEZ5LDDcXHQxvCOkyW7hbzV9tAD6GwFJTAOC?=
 =?us-ascii?Q?JCX6+mth2FflVdVnIG1z6jPK+FavfkA8knlv9HRkiXLk9MsAMpQoWaO1IWRX?=
 =?us-ascii?Q?yKjosdQnhsOYP64nYMtReEbzUGzX3rtyilXYFEadRwQpAKI75K7H1989N+jX?=
 =?us-ascii?Q?9izv0nvRmDfroxS7/Z+3P8j9B596P0oOD4tQHNxGV/5G0d1scmCEHtgLgC0R?=
 =?us-ascii?Q?AayJwWIRclPmYqFLTaV3hpIqf2IEqfCJfmX1OuH4DkE3WiPHEfGOSYrO0Auq?=
 =?us-ascii?Q?lDZIMxzU6I/GempAdIEFEQq2WI/owWPojqS8YGyv/yTlfrTlkMycWM0IZEdE?=
 =?us-ascii?Q?D7sQ59G1yfAPzTAG6YykET+kbuoZ/ecIjwaLO2FsXInKmUEE/qba7XhaLYbT?=
 =?us-ascii?Q?KtLsfZUbeS/JOdlhVrg3ssHnEPNpZtRs8rwFZ9hW3LFvAfDQRcTG1JTIl+Kh?=
 =?us-ascii?Q?wyqGi6MaMrbbDcg/t6vwkS+AVtngkVd3vXMjGyLR2dF9FCb3JLC+NiBLoIcp?=
 =?us-ascii?Q?sczG6a8zeIwsZ0CX3N49WfK3npumZd8B/r+GrApfmJEG8o6v7fSWZJ3UoZnt?=
 =?us-ascii?Q?G77a0gOHAHx1HSyuSBAzvaoGfGu4f5nhapeXT5IwArOvbSnn9xBxLQ2K0wPs?=
 =?us-ascii?Q?MsoFJHtRbM5xVc8gkzOTxA3TtzNfIPp/876Zg5n0zyBXC9ei+QEWQixlNSV0?=
 =?us-ascii?Q?X3fPhDzHAkoz/tITvAwtoWYWRCHh6bTEiCeY4L2OjmT33zn7vi0qL38HjlxH?=
 =?us-ascii?Q?iU7+8VkPGVxxW8Vzt7VuXhTtTmrL3Ma/+/2i+6aJ+/TZWM3FZLGGCmgfcFJO?=
 =?us-ascii?Q?ECbw3psNgPFJiMKn1EkFsd9Oh9MSfGEK7UhLL96JhHUUDUUcV9CTB9RJW5A7?=
 =?us-ascii?Q?c+YBY1owt4IUJ8WR8VMOAEvazdJdhXyWjb1OpQP740HHukRbE74w/NQO91Jm?=
 =?us-ascii?Q?tQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <AC2F5362D88DDF44BFAD1D48551DCCB2@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: cHzcB3wrl2O0rYll4a2XYjRRGeoJ8QmsVl0HADGLezUOkq6g7v9uhomo+Q4tRyGR5lfCMwWZ3w4/GIfj7bYeeCHO28Rw32DsVDA2xgQb32oqz20yMXXp1J8eBFm6Z/HtU8PLCAjsGh9pSThsKgs1kt9gniRAVhTKpD1aX//MM46q+/f0OqsB9KDXPyxncfUEY8JzloXIFxj+xSlTE6jk+cyGeBWblGGKkpL4pj+b7fRYY6fpJrmEUlotCiuyf5nH9yjBZrobVlcgpvYJQQ3wFDAjtzN/QqYWLkmQwYB3G1Hksa4DOFywmMl5fyGdqEkPBPwStYWe8LkXFhGM4RK7+XB8rSMgY5ApSCxYla8ZZ+vzsJg3mWnyvUSFvUTEBlZKnMLfcJlBRTKmDYKjS0G09IRl2qb54Cfpfbi3TGq7bzxbww8D4ko9GmFYRu5X8It3++d10NVeM8sMtrZcA0BW/99kg0zMIJxF/JdJko/DgSiUEn05X7OUxOxJlLRW7YAoXNddb4a4tURYt3JmJcnJ4yokIdS7uB92/Gb7RWTnINwsT86TUccV6a6tLTProGFiXmHAWI/yX2pR/9J3H2PKVR99E+77qcgI75M0xyHnYM4sRjBDMDY0VZFUomFFU568lvER5tbeefrICnCY8QpvVX89lNoaRQM14Hx/ml4dnN5TItC3BagdAuLdcSTdOa7DvGrRNUTmXp5DT2XXhQqwcxOkzcBHilc06C85rlvuZmEOoojzhYAjBMRcFcRFc6IGsqMSSLeiYRHxr3rkcbd1Jw==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd0224a2-ccb8-45fe-d4ec-08dad14d2962
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Nov 2022 14:30:56.3063
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Njggv/WyB9sMMLyGm92/l/7Xpb2VUFyfm2XkOz5D6mjNv6HiAFvA6L+OU0OlzUzn2H+ARg8nLnwT9RxfxWVd/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6588
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-28_12,2022-11-28_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 phishscore=0
 mlxscore=0 spamscore=0 adultscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211280109
X-Proofpoint-ORIG-GUID: HWmkah3CXW2AyIv7nY3EpOvQiJX-QQiz
X-Proofpoint-GUID: HWmkah3CXW2AyIv7nY3EpOvQiJX-QQiz
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Nov 27, 2022, at 12:17 PM, Chuck Lever <chuck.lever@oracle.com> wrote:
>=20
> If a zero length is passed to kmalloc() it returns 0x10, which is
> not a valid address. gss_verify_mic() subsequently crashes when it
> attempts to dereference that pointer.
>=20
> Instead of allocating this memory on every call based on an
> untrusted size value, use a piece of dynamically-allocated scratch
> memory that is always available.
>=20
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
> net/sunrpc/auth_gss/svcauth_gss.c |   55 ++++++++++++++++++++++----------=
-----
> 1 file changed, 32 insertions(+), 23 deletions(-)

I forgot to include this one in yesterday's series, and posted
it separately. Can I add "Reviewed-by: Jeff" to this one too?


> diff --git a/net/sunrpc/auth_gss/svcauth_gss.c b/net/sunrpc/auth_gss/svca=
uth_gss.c
> index 9a5db285d4ae..148bb0a7fa5b 100644
> --- a/net/sunrpc/auth_gss/svcauth_gss.c
> +++ b/net/sunrpc/auth_gss/svcauth_gss.c
> @@ -49,11 +49,36 @@
> #include <linux/sunrpc/svcauth.h>
> #include <linux/sunrpc/svcauth_gss.h>
> #include <linux/sunrpc/cache.h>
> +#include <linux/sunrpc/gss_krb5.h>
>=20
> #include <trace/events/rpcgss.h>
>=20
> #include "gss_rpc_upcall.h"
>=20
> +/*
> + * Unfortunately there isn't a maximum checksum size exported via the
> + * GSS API. Manufacture one based on GSS mechanisms supported by this
> + * implementation.
> + */
> +#define GSS_MAX_CKSUMSIZE (GSS_KRB5_TOK_HDR_LEN + GSS_KRB5_MAX_CKSUM_LEN=
)
> +
> +/*
> + * This value may be increased in the future to accommodate other
> + * usage of the scratch buffer.
> + */
> +#define GSS_SCRATCH_SIZE GSS_MAX_CKSUMSIZE
> +
> +struct gss_svc_data {
> +	/* decoded gss client cred: */
> +	struct rpc_gss_wire_cred	clcred;
> +	/* save a pointer to the beginning of the encoded verifier,
> +	 * for use in encryption/checksumming in svcauth_gss_release: */
> +	__be32				*verf_start;
> +	struct rsc			*rsci;
> +
> +	/* for temporary results */
> +	u8				gsd_scratch[GSS_SCRATCH_SIZE];
> +};
>=20
> /* The rpcsec_init cache is used for mapping RPCSEC_GSS_{,CONT_}INIT requ=
ests
>  * into replies.
> @@ -887,13 +912,11 @@ read_u32_from_xdr_buf(struct xdr_buf *buf, int base=
, u32 *obj)
> static int
> unwrap_integ_data(struct svc_rqst *rqstp, struct xdr_buf *buf, u32 seq, s=
truct gss_ctx *ctx)
> {
> +	struct gss_svc_data *gsd =3D rqstp->rq_auth_data;
> 	u32 integ_len, rseqno, maj_stat;
> -	int stat =3D -EINVAL;
> 	struct xdr_netobj mic;
> 	struct xdr_buf integ_buf;
>=20
> -	mic.data =3D NULL;
> -
> 	/* NFS READ normally uses splice to send data in-place. However
> 	 * the data in cache can change after the reply's MIC is computed
> 	 * but before the RPC reply is sent. To prevent the client from
> @@ -917,11 +940,9 @@ unwrap_integ_data(struct svc_rqst *rqstp, struct xdr=
_buf *buf, u32 seq, struct g
> 	/* copy out mic... */
> 	if (read_u32_from_xdr_buf(buf, integ_len, &mic.len))
> 		goto unwrap_failed;
> -	if (mic.len > RPC_MAX_AUTH_SIZE)
> -		goto unwrap_failed;
> -	mic.data =3D kmalloc(mic.len, GFP_KERNEL);
> -	if (!mic.data)
> +	if (mic.len > sizeof(gsd->gsd_scratch))
> 		goto unwrap_failed;
> +	mic.data =3D gsd->gsd_scratch;
> 	if (read_bytes_from_xdr_buf(buf, integ_len + 4, mic.data, mic.len))
> 		goto unwrap_failed;
> 	maj_stat =3D gss_verify_mic(ctx, &integ_buf, &mic);
> @@ -932,20 +953,17 @@ unwrap_integ_data(struct svc_rqst *rqstp, struct xd=
r_buf *buf, u32 seq, struct g
> 		goto bad_seqno;
> 	/* trim off the mic and padding at the end before returning */
> 	xdr_buf_trim(buf, round_up_to_quad(mic.len) + 4);
> -	stat =3D 0;
> -out:
> -	kfree(mic.data);
> -	return stat;
> +	return 0;
>=20
> unwrap_failed:
> 	trace_rpcgss_svc_unwrap_failed(rqstp);
> -	goto out;
> +	return -EINVAL;
> bad_seqno:
> 	trace_rpcgss_svc_seqno_bad(rqstp, seq, rseqno);
> -	goto out;
> +	return -EINVAL;
> bad_mic:
> 	trace_rpcgss_svc_mic(rqstp, maj_stat);
> -	goto out;
> +	return -EINVAL;
> }
>=20
> static inline int
> @@ -1023,15 +1041,6 @@ unwrap_priv_data(struct svc_rqst *rqstp, struct xd=
r_buf *buf, u32 seq, struct gs
> 	return -EINVAL;
> }
>=20
> -struct gss_svc_data {
> -	/* decoded gss client cred: */
> -	struct rpc_gss_wire_cred	clcred;
> -	/* save a pointer to the beginning of the encoded verifier,
> -	 * for use in encryption/checksumming in svcauth_gss_release: */
> -	__be32				*verf_start;
> -	struct rsc			*rsci;
> -};
> -
> static int
> svcauth_gss_set_client(struct svc_rqst *rqstp)
> {
>=20
>=20

--
Chuck Lever



