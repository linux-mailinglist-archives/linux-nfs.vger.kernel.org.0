Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A01D260BB29
	for <lists+linux-nfs@lfdr.de>; Mon, 24 Oct 2022 22:49:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbiJXUtp (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 24 Oct 2022 16:49:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234265AbiJXUsx (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 24 Oct 2022 16:48:53 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B29EC24AAED
        for <linux-nfs@vger.kernel.org>; Mon, 24 Oct 2022 11:56:05 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29OFYSAK013497;
        Mon, 24 Oct 2022 17:04:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=CSCmROh/9tHWp+gv6olYJlehq8WUYjO2SUi39tgvETY=;
 b=HUMdHWSrHzkllvun6NyzjR2OeNvUA1U6zgQxs3GYm7QQpIXSmmSgi/jQfO6F79/B5VjH
 UQBtWfG3+ki/gZiZT1KUW+soQYrtTv9T/t+F0pieDd0KkzKF5bRzxJ/LSrFb10JyjdfG
 KYOKqLJuvHdvvoY4nNajxo0IlJDL0/8fwEKUuE7uQMukC7/S+j0BZeyKY6qDrPVVzmSg
 athUvzt98trnO4qCXsQXbvdAuNfJYotytoPsC5AqH8zHZz8nlK2N1L1T+w0PnVRgWbk2
 GhWCqkt0sUir6Vj4j1pmGazZRGKOTjjMc/nX2P/CQMXNUmQxzNUT4TKJkU+dtRDT/15C CA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kc84sv8xf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Oct 2022 17:04:43 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29OGOLsM032203;
        Mon, 24 Oct 2022 17:04:43 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2106.outbound.protection.outlook.com [104.47.58.106])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3kc6ya2dma-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Oct 2022 17:04:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nqsUxHlVvsQWO3DwhyDySY2YgDhyhwKq8vNrvWixe3WOWS+wzjgEeIzatASi1wHm/zWULtL3CjJzpHKq1eCqljuLOByFTC5Dj86uw5WNzIqyVbYRWVWAjxwvZB6DpNVWAZKtGpx8JHgOUmkPA9Jwej3hsYuikE8S4mzkfn4UF6eiHtNG1L5eMaKZ7iWb/EPWmHz8Swmhtgoozh51BI07kjxStARBIYfyUIN1OvPGfLz9uYwi5drBfXKBR6VuWGT+RX2KzPv8Nkle6ny1LMAUV8evglKCNKs2y/b3xDl6jc4u+OsDoiW9xU8aSLsGbT1LNrryp+5NkJxDZ8MkrfyAsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CSCmROh/9tHWp+gv6olYJlehq8WUYjO2SUi39tgvETY=;
 b=PAo8+xFrfoI7qJIiu0e7mxFDaIbkp+Ju8DkOfDG6Si152soATIv0oVvBvm5HWkxnrtDT8UEDzQQosfMvkiLxDk/SXfQzJNmZsxrG9IsZS/ghP5sV+n14u5oKODn37OJKdUM26bM1ayXZtbGMcEkKDw0CRsRLu9rcSaf3rBieK1OzWztzhSW+04Q/iiVKqaej2/nPD/KPk/r9TTXqoTEBD4YuY0lp01+kW58azgnAYh8EyTme0ZEu4EuqToiJ8p5fUwyXhke3MtAjmWXuOU55NMpDam20O3A84276+nZJ2tWwtik8ZbZ5vQbSADpnlW+UECZ3KEeUiowuyZTOqZfGyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CSCmROh/9tHWp+gv6olYJlehq8WUYjO2SUi39tgvETY=;
 b=OtxDE9dDnHrLe7lEXq0PEHmh5sAAuZ8S2UrgjnfhMM7oOL9/TXrVTAcRjpSdHAy24Dnvp9oDTyXIsTyJbw8/s8PVgm5ZwC0POYBmy4FkFEh5OGdIFKD8xDJ6b4hb98v9oepVbwokSU7kRYir/tmvbDPw6hWf0IrsSQCXf+ow/rw=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH8PR10MB6549.namprd10.prod.outlook.com (2603:10b6:510:227::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.27; Mon, 24 Oct
 2022 17:04:41 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5403:3164:f6c3:d48a]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5403:3164:f6c3:d48a%3]) with mapi id 15.20.5746.021; Mon, 24 Oct 2022
 17:04:40 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Neil Brown <neilb@suse.de>, David Disseldorp <ddiss@suse.de>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] exportfs: use pr_debug for unreachable debug statements
Thread-Topic: [PATCH] exportfs: use pr_debug for unreachable debug statements
Thread-Index: AQHY5UgGkwnmp58/L0OX2xyj/M+Kj64cjjqAgAE8nYA=
Date:   Mon, 24 Oct 2022 17:04:40 +0000
Message-ID: <000A2614-4C72-444A-A1D3-7B259D99C70A@oracle.com>
References: <20221021122414.20555-1-ddiss@suse.de>
 <166656308707.12462.9861114416829680469@noble.neil.brown.name>
In-Reply-To: <166656308707.12462.9861114416829680469@noble.neil.brown.name>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|PH8PR10MB6549:EE_
x-ms-office365-filtering-correlation-id: e9365789-1c26-4434-4df4-08dab5e1d6f2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yfOPiALsKFmrvjoHFOqZBzQWGOMQwrmxXsn1jqEmpeS1Ol2O3y3IZSX0meNEyxB3/GSct9siXLty8JecQg8a3LcjRI45BsgQ/jw/fFJ6I0WpjUFD8GQgG9YgvKEwKwGMsfj9+D+VaDNeLV+uclmzL8A7k/YS6K2/q6rxqdhW+AajURK8YEljlaYG6FtcOXTiqj7uL3x7H6l1uwr2fiLToHYwCQHHZk/rfL5LJjlDyaJLgtBBQIFApXZY+wWNeukz9G2+RAotRc3tWX3FqTHsWOoeLnp1CSwHOkNUtDoo/GqvMFPofghqXdt+gcNOmKAZShcwBfhf2ZwqNp7q82icZIvwOfGTr4UBjZWxhZDzmBM0/F+atSKdKtI8vojSVDobE1WSP78ZnjFgKCxi76b93IXXpbOHoVLWjars59ljnJBsJjxgjKwuHzsweaoCcmqq4Ak6TJyo456gVVMIiOkS8A7CKeaD7ApyIEvAEY9xT63di6TBLqYDONSYyrYoRxZGIP7gt42j7xaCG6gUA1HwQsym+8GQJbo8RGCnTDtzDgZVi1xgIDgy3dHgMjBDiJS1imzYm+eD5x7E5iBKBUeWkc8yYOahpCUVN3DMFpLBPuvzdpiRJa7HzTjOcsF5EdSIu7RUOZwPjapM8zyC+MkqPdicZ16kZxD/JhTdvmXauKdSQVPOSNBvqPPnxQkcAOj6yhO/L9ylMgPV1T/b9z+hz9YwBgZkT7rkjpfhnwIlNxIBIbzBZAi+RDw9x4uhi403J3Qv3AB2Z9tIAwvwDeb/OTXEkIb95FHrz8UVBwIcUxA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(366004)(346002)(396003)(39860400002)(136003)(451199015)(38100700002)(6486002)(122000001)(71200400001)(478600001)(38070700005)(316002)(110136005)(26005)(4326008)(76116006)(91956017)(66446008)(8676002)(86362001)(6512007)(41300700001)(83380400001)(53546011)(2906002)(5660300002)(8936002)(186003)(33656002)(2616005)(36756003)(66946007)(66476007)(66556008)(64756008)(6506007)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?dkQSLxIVsYO2N2nQuN2kPzottMjKQTQ3vkYu9pfzro6JLhuLvK1DMmKJQecx?=
 =?us-ascii?Q?gG8yfwuY6tEFwZ8SkCQLN7tyYSUX2V9QXVUTr8dL9UmqGTbxbTwt0VTMLKNd?=
 =?us-ascii?Q?ALzwBVFod6Cv1hsEsdXTv2H8M6Ea9Nisj1dtTUZ6rss7WrtgCsHMO7WnCtBw?=
 =?us-ascii?Q?zNADqRVV3SbMD3v62vVCZJu9reb5wO33mGYRRSCBMavYNNugkdqfN2Y8GXqw?=
 =?us-ascii?Q?M8//WhbPJkib2RQo/LJ+94eaxI5HaIU8B9kxM5LzBskR9xDobjYFMslqgiYP?=
 =?us-ascii?Q?gzt6MA7Jx6Q+7mYbcksg7ju6k6NzrTNacGIWNenkCwrlp/1e1awTrFztXPGR?=
 =?us-ascii?Q?aO5nzg1oPu6P0OeVFuICys+35m1+wTPgKv9UCnceaYjOL97Ow3TFcGaiKzqR?=
 =?us-ascii?Q?l8NzcN1DWHWM/VC/PIXim/lat87GDHeRDvlvcOEnkNveI/Z26oKCXUVmkSdM?=
 =?us-ascii?Q?xGpVQB2oYvaHqp9wntEJ6Iys1tUtOlh3TuHdcf3vWfhz87wzgnjT/nQXmN5O?=
 =?us-ascii?Q?8JPpJS+bDDdyGbKbMbkS3vyU7i995jRkeqTF75Fd+3A4RUt8+qNG03ZT2PHI?=
 =?us-ascii?Q?5Q8BtBWui5diNMfgg6gkGzGNLxeVW4lP347Hifcdr4qTLJDUpB/3hiwgTRtj?=
 =?us-ascii?Q?7tGq8vq6olTq0KGT2n3cL+FBV6sq4qC1RsfwHATtRhGzXRwHNXTaYtGJY9V1?=
 =?us-ascii?Q?hrjbofWIkk1F5NXpwn1xNesnqCQWsP3GAMQnFvQVkIplsY72TP99gc2Rq/88?=
 =?us-ascii?Q?PM+bnqBmLWfvPvSKwz/FEmqsKOkwSZd9tYixxUF107m8wgkcSL32o5jG/6ny?=
 =?us-ascii?Q?I+7Tf3V22Nk4kvo9kWHSRN4yheoB+NFRQEE7dLZzKVMGFkxxmPM/01pD7pbm?=
 =?us-ascii?Q?Wf61eNiKgM4w59B9Ia0j04KxK3LrHie2Vit0oHDdx5iYEwsw+KVhIxTK6iNt?=
 =?us-ascii?Q?hHZlI1NgHDsGTiBfTRWNpb2fkL394XrFVTJcGPCq7N49eOvppnAzAdkF1q2j?=
 =?us-ascii?Q?PZkc41mY4IjNDMMmlcex6bwJ1toqS0+klc7ZumEPyLLF+JLKPAF1pZybnpXt?=
 =?us-ascii?Q?PizBCsGx9bm31dnDosydNmhLWl0BOXVKHtGVaq9gF+T8oC2sgutLhLnRr6rx?=
 =?us-ascii?Q?nT0rZm6wLt9k+v4ea7b/VQLO2ffvTvseGvDwulph8HDUaLBLXNtU26jUpXhA?=
 =?us-ascii?Q?wvyhz+rj0YmDlS9I4b5dWNEOo2UCxx08qn2O+CfLl8bVkua2C5h3cuvhHuxF?=
 =?us-ascii?Q?0KNQ1EAtYDSzetcs/3VZxaOgl+LP1qU5ppvdZ04N7tZ9OgsvdI1QUqzu3fhl?=
 =?us-ascii?Q?oIM3DK8qcFQYiQ11TO0nMRLA4vdCsXdqlyaUP0dU7Kcr092v/ggnOmMi7aR4?=
 =?us-ascii?Q?2UcL4sFVZbw6zG0N1cat9KusrpfcwO4dXfh7ECY1yVupZKjLCB+zDk7q3dWG?=
 =?us-ascii?Q?RHOOzzoLDBA6NrBuk0P6jToOjuLMvCtQMrvKkx4ABRwNsiXiQDvd29iOahtF?=
 =?us-ascii?Q?V3p65Nux2oxvEqOnjLWDJ98mnlR6fxQejIOdVZTMLPpO27BZW5LZ/E8UpTVd?=
 =?us-ascii?Q?U/NSdH16+R/csmyyZBhcDa5PpfzzfjjidJe/zLOJjAqx8nB5PFjX/10Vghxh?=
 =?us-ascii?Q?Ag=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <DF001445B7FCE043AE11FFCED9D818E4@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9365789-1c26-4434-4df4-08dab5e1d6f2
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2022 17:04:40.4496
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: i8hoszX+gn6CdkGiaxPCz0kzMUEFh35VdaK3MteME7iFtpblrb8Nqjqh8n20CC5ixzjtAUgblfUZeFo5+vkEQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6549
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-24_05,2022-10-21_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 spamscore=0 suspectscore=0 bulkscore=0 malwarescore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210240104
X-Proofpoint-ORIG-GUID: xI42gYaI61JVTCccUnYRDHefKOVW4vK9
X-Proofpoint-GUID: xI42gYaI61JVTCccUnYRDHefKOVW4vK9
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Oct 23, 2022, at 6:11 PM, NeilBrown <neilb@suse.de> wrote:
>=20
> On Fri, 21 Oct 2022, David Disseldorp wrote:
>> expfs.c has a bunch of dprintk statements which are unusable due to:
>> #define dprintk(fmt, args...) do{}while(0)
>> Use pr_debug so that they can be enabled dynamically.
>> Also make some minor changes to the debug statements to fix some
>> incorrect types, and remove __func__ which can be handled by dynamic
>> debug separately.
>>=20
>> Signed-off-by: David Disseldorp <ddiss@suse.de>
>=20
> Reviewed-by: NeilBrown <neilb@suse.de>
>=20
> Thanks,
> NeilBrown

I don't think we're the maintainers of expfs.c ?

$ scripts/get_maintainer.pl fs/exportfs/expfs.c
Christian Brauner <brauner@kernel.org> (commit_signer:2/2=3D100%,authored:1=
/2=3D50%,added_lines:3/6=3D50%,removed_lines:2/6=3D33%)
Al Viro <viro@zeniv.linux.org.uk> (commit_signer:1/2=3D50%,authored:1/2=3D5=
0%,added_lines:3/6=3D50%,removed_lines:4/6=3D67%)
Miklos Szeredi <mszeredi@redhat.com> (commit_signer:1/2=3D50%)
Amir Goldstein <amir73il@gmail.com> (commit_signer:1/2=3D50%)
linux-kernel@vger.kernel.org (open list)

But maybe MAINTAINERS needs to be fixed. There's no entry
there for fs/exportfs.


>> ---
>> fs/exportfs/expfs.c | 8 ++++----
>> 1 file changed, 4 insertions(+), 4 deletions(-)
>>=20
>> diff --git a/fs/exportfs/expfs.c b/fs/exportfs/expfs.c
>> index c648a493faf23..3204bd33e4e8a 100644
>> --- a/fs/exportfs/expfs.c
>> +++ b/fs/exportfs/expfs.c
>> @@ -18,7 +18,7 @@
>> #include <linux/sched.h>
>> #include <linux/cred.h>
>>=20
>> -#define dprintk(fmt, args...) do{}while(0)
>> +#define dprintk(fmt, args...) pr_debug(fmt, ##args)
>>=20
>>=20
>> static int get_name(const struct path *path, char *name, struct dentry *=
child);
>> @@ -132,8 +132,8 @@ static struct dentry *reconnect_one(struct vfsmount =
*mnt,
>> 	inode_unlock(dentry->d_inode);
>>=20
>> 	if (IS_ERR(parent)) {
>> -		dprintk("%s: get_parent of %ld failed, err %d\n",
>> -			__func__, dentry->d_inode->i_ino, PTR_ERR(parent));
>> +		dprintk("get_parent of %lu failed, err %ld\n",
>> +			dentry->d_inode->i_ino, PTR_ERR(parent));
>> 		return parent;
>> 	}
>>=20
>> @@ -147,7 +147,7 @@ static struct dentry *reconnect_one(struct vfsmount =
*mnt,
>> 	dprintk("%s: found name: %s\n", __func__, nbuf);
>> 	tmp =3D lookup_one_unlocked(mnt_user_ns(mnt), nbuf, parent, strlen(nbuf=
));
>> 	if (IS_ERR(tmp)) {
>> -		dprintk("%s: lookup failed: %d\n", __func__, PTR_ERR(tmp));
>> +		dprintk("lookup failed: %ld\n", PTR_ERR(tmp));
>> 		err =3D PTR_ERR(tmp);
>> 		goto out_err;
>> 	}
>> --=20
>> 2.35.3
>>=20
>>=20

--
Chuck Lever



