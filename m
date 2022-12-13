Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91BFB64B6B2
	for <lists+linux-nfs@lfdr.de>; Tue, 13 Dec 2022 15:02:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235236AbiLMOCS (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 13 Dec 2022 09:02:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234981AbiLMOCR (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 13 Dec 2022 09:02:17 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5542C15709
        for <linux-nfs@vger.kernel.org>; Tue, 13 Dec 2022 06:02:14 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BDDtTPB013300;
        Tue, 13 Dec 2022 14:02:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=PRajvNddZrKVUEXDEQYj9v28p80hCHksi9Efq8+9TQU=;
 b=kPpf7YtQybVVpDOHB9Bh/pRkPnQMpuM6dlJwc+n9V9XoHUNENgfnslDjLImjdFKWOl5v
 1UpqV50/qAFIr8eZNQAltrNeUUvRKSRwh603F1lOmA0SZhweVA9nXVwcEsiXemIlLhkZ
 H0clRCkHV+AfO/ij7P79IA8PkPIVV0Lg0LpxbJUgVMEkbnm2XKPdFk3GVR8iKJxM7Frt
 DEbcyElw7nUdmaP1XYoSgRMIAZyEijLgGYzj3P+JxVZkQXdjP0EBB5TUxICgg/rPEAbM
 lX/xVW/kGRGVaP/mYxVg46ABpL8FHYn/qL38qKU/1HRuKOz3/BgylBDkvVS8RrwcYe2F eg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3mchqswckg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Dec 2022 14:02:04 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2BDC2NXl017653;
        Tue, 13 Dec 2022 14:02:03 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2046.outbound.protection.outlook.com [104.47.74.46])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3mcgjc149d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Dec 2022 14:02:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ewyrNV0BFa7qCWmEkXXCWnq/+RWVe/jotH0QbAbbgL2xmdqRUC08qO38yuC6RxyBnzIiEgyFGSpwouhBva3zm2epa0l5h2QOvozGCc4Kp69icsajGrbXPpWn5eP4V/ETe2+fy83+OWw/w6zGgrSHozTYEsSZ+42f8bFS1D/hAi7cB8T94c4oerBPlmSOWVX0ncDq+pdlOcbNlGETfrWn3Un2i06IW0Z1/gdYPofh8BZ0lcJFDnDLwO0w+hX/k8LCxuyREd/y7BI7z740x1X556GUA3IYSX4iiBDyQ1JFy/zyKWwWoYnyP/ab/2vYp5Dh48FdyDPeNnSZNMSciveqhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PRajvNddZrKVUEXDEQYj9v28p80hCHksi9Efq8+9TQU=;
 b=WEmZUxTJA9pBx0GfLA/k7Fd5/DsCr7vUJevJOqg8BQbeCD3QXtKelqvcA9ncwuBTmhEzdhq6VAUc/Gt/FcMBu2rBoT1N0N6t5n5ooCvOOAxnuqjJkRGoqqfD+i1Kr7K/ajTO45qvQxy5ZfEN5b4QGkzv3fIm3yaMqfiiZybxi/7GW1fZqMJVkpDBg1fCSPXdC+ESO+RxoNnEaQCPTOKepZFlA2zy5StnOibRCflCVmv2i2oeHYyUxhBf8++yT9ZLDAUanpNQsNStD9/h3XNcYBhbRAy7jqgiMYyhz0EhNgfttjIcCSHHmeNW7+jw0C1RGMmQZOowGAv0eFZ0wUoBcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PRajvNddZrKVUEXDEQYj9v28p80hCHksi9Efq8+9TQU=;
 b=sTilZwFrNTcFQBvbl1Z6ETzkSjBN640m1UFPOrVd+PANZ6G+6XefLHt0KJGPBlrcgmXx2RyzzMzwbMkPWkFIMq7KQb8qLXiHQAmNqks0qWNmUjlkSXupWNg7AKXZuPsAoc05A4MN/xLXrtoPbaCHEIzfpk5wTWYg/Rn8tf1Eqa0=
Received: from CH0PR10MB5131.namprd10.prod.outlook.com (2603:10b6:610:c6::24)
 by SA1PR10MB5781.namprd10.prod.outlook.com (2603:10b6:806:23e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Tue, 13 Dec
 2022 14:02:02 +0000
Received: from CH0PR10MB5131.namprd10.prod.outlook.com
 ([fe80::773f:eb65:8d20:f9c8]) by CH0PR10MB5131.namprd10.prod.outlook.com
 ([fe80::773f:eb65:8d20:f9c8%6]) with mapi id 15.20.5880.019; Tue, 13 Dec 2022
 14:02:01 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Xingyuan Mo <hdthky0@gmail.com>
CC:     Dai Ngo <dai.ngo@oracle.com>, Jeff Layton <jlayton@kernel.org>,
        Olga Kornievskaia <kolga@netapp.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "security@kernel.org" <security@kernel.org>
Subject: Re: [PATCH v3 1/1] NFSD: fix use-after-free in __nfs42_ssc_open()
Thread-Topic: [PATCH v3 1/1] NFSD: fix use-after-free in __nfs42_ssc_open()
Thread-Index: AQHZDnweXCJ53drKKku1BZzW7bJsHq5rK+aAgACuE4A=
Date:   Tue, 13 Dec 2022 14:02:01 +0000
Message-ID: <9CCA3C67-3A27-42BA-93D1-7665A051F485@oracle.com>
References: <1670885411-10060-1-git-send-email-dai.ngo@oracle.com>
 <CALV6CNPysKmTDmeZds61eKrtmA-yGbj1pQKvxOtfkpF3P5ankw@mail.gmail.com>
In-Reply-To: <CALV6CNPysKmTDmeZds61eKrtmA-yGbj1pQKvxOtfkpF3P5ankw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR10MB5131:EE_|SA1PR10MB5781:EE_
x-ms-office365-filtering-correlation-id: 1a921cad-9fbd-4c2c-2449-08dadd129bcc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lmsCj0TcWeLDrq1v9+x8TRzEvDKRxak/1F3I2RFBhjzPPwk5GoJdUND448RSN8mtyFus6tF+vQjQJJCA9VkfXY4wPFEffao+T9tim9rKvwCiB0xsTf4hpDZQfkKiv39EsvtrjutIh4s6qK6WoxgR8/wrdKRpugxsnW/lFK4p2xqAv8k4D+OeuwbW3KxblZ/VPP3KwUVSkk+EYrWQ8dSqYRo+apz3rcV9Kp0XUGs/FjAOQqW1vVyiwGycbqfFUd97gnNUNOd0tTOaeOLaNccPiuYbE/SZSFPCTFGA5Q3lCv0Mv8en2t+4hBxvWzbLyFuAzICTGoOdGuk81We1SFKakSfeShfRk9GOWcnLkSAEFphG4J0PUtgFLxlaAVVZdYgjl+1kYmktYDeFTrlDUYpZnVmZ5CIDT/2evmYciq1P5Qz5JxeDcAdPD+PM1KmrkPEZTbC0PNQhxAuqYF1reDSpSunWkFGieLH7bx3rSQJL8om8iqx8OY/nPp8X/5OdC0LulIWwmKh5AxsJAh1nTfEYz8M9FfcA9CtSXO4T1n+tO4u1RVOXjaqEpAoUpGuowf1Dl5BqGt8XcrkOAR6nVmFwz9gUbU8fdA9vbTPiLXWq6mwu/B1/SKsRf/eQJjIezq8DMhbXFCWXvdty7ZAoQVyWkKpFkR8e1aACnKyGEAU7CIgQI2LPdZ/kBDr5DzqC5yWbA7xxtCCbngQSO5BMl2gOg+o4IpB6kcDOaaj5etqhqyE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5131.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(396003)(39860400002)(346002)(376002)(366004)(451199015)(122000001)(2906002)(38100700002)(2616005)(36756003)(6506007)(5660300002)(86362001)(83380400001)(53546011)(66476007)(71200400001)(8676002)(66556008)(76116006)(66946007)(4326008)(64756008)(66446008)(38070700005)(8936002)(186003)(54906003)(6512007)(6916009)(26005)(41300700001)(316002)(33656002)(6486002)(478600001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?5eQ1flPDJYlxWy6YR6J9zKe7+/vWdZuYzkHLnAHCDKKhGxsUl7JNTAMETuAX?=
 =?us-ascii?Q?ItqUjz2GqvSNYVUD8o/FntIyqu/iomMgwj+7ZKVSqBjdurdmCDTJTpXeHMtP?=
 =?us-ascii?Q?L9g9u2scrJXUy/sejXgLca84UJdxAoJ2i/QomLDWd2mloJcVoKw/QRF9pPD2?=
 =?us-ascii?Q?yvg1KGGTqmzv2bJsdiPKMXK4jDdywU3kSd184VMLam7nt7JKkZTUdhm/Lt1P?=
 =?us-ascii?Q?jtyL3Gjm/W+GjnGoZiEy7KdaBYFRCBE72Zep7Jr7VoOIEVCm2oLRKJgj2WVH?=
 =?us-ascii?Q?7qMdo2fCUmEACtRNtTJEDyXSfDCz8DSQCrc1fTLzXr1hustKJkyTiBoou0Bq?=
 =?us-ascii?Q?hCjiEJDrrIGacBx7jcZL0wmQMbJCpzZDfDsNNcGdzD0sQffaQDOECA89bU+g?=
 =?us-ascii?Q?fl75IXTkJzl21Bj0qerhdubvb2RIZPZYLvKFi3FxIyDF6PkF1Z3wKBtOC7BH?=
 =?us-ascii?Q?/InuPlycRHNLwI+SclBBDmGXPrBuSHHj2A8kymUbpuwXK5wRuiZ18ARGQmEu?=
 =?us-ascii?Q?K29pMnJR16mdytShH8ZztxPKjOm46cvv5hH3ffMezchtAjjOOxTwakx8Y61B?=
 =?us-ascii?Q?HZhREd8piqW8jFN0OmbmweGsBE7v4UfbxAzvKSUzIwd4KbcJ+H6mPBf9mb1n?=
 =?us-ascii?Q?m//o8DL6YVYBTra7oRgBXfTkMLNWTnTVsmxsqetR8cqyE0cP7JH9Pb6u7Nf9?=
 =?us-ascii?Q?ziAZtJV2dtXbMKXLVUxywgKCU1wujrCY25/VkMxx+xdz/NbJbdGAZQR0uxmd?=
 =?us-ascii?Q?VAMDPicEDrueeJBGXwWVJvaHMe7+ZRM/MZML6GP3e9JyjnQ/+kKSWKFZsqwn?=
 =?us-ascii?Q?+tuQD7z3jzXUPo+rFFgISqvDVJG+lkDDToIcBCLJtAKWV6LYxpPhNM+FCJ9r?=
 =?us-ascii?Q?ecl56mSDTV0AY+uCqRyTZzH+hJDHhP9XXcsgxfhnU8O5DxspGyrLUky5odbj?=
 =?us-ascii?Q?bSrdfGWkArx2eqxt9sVTtwpLQKnumCsS+TGmPtsmg4e8W4gECZFSfosYhtMh?=
 =?us-ascii?Q?tx/2Zg/BoGPzVBQ4NvLcBHVZ/FIFKCvLfOyGMQnt2BkJ1tr1CVfQDwSce2Hr?=
 =?us-ascii?Q?+TKVsF+VZVsUCWX4EVy54J3mtK7YtXB8xsiKC6r0Y2ffSEXt3Fir7knxsEIp?=
 =?us-ascii?Q?6DU2GIkdg6k8nmD9MuetIe+bSX12D5NYmbajXGesoxBcy0QzxOWeDo1eApt6?=
 =?us-ascii?Q?XL5aaC6hfGKq3DxmrMFoMHprHK/jJkt7477iQvQKqcJOHhQxulrUOo5SQQOE?=
 =?us-ascii?Q?d4fryhv6T7Hka6stko3lGbTAV04rf9sF9A8xWUXv05qt6uqWb/JVKzjg2xds?=
 =?us-ascii?Q?5xN4iBYGGI0vooHqXQl/4RqnMXi49ayDSuVRjeqOw7Jg5hYazdJKFlSfau6U?=
 =?us-ascii?Q?YMuqaXa5A0j8AgxSz6MlAzspA5Tl1uyk1KW67bs4xbTgG71ZVVTk0ivqF0aq?=
 =?us-ascii?Q?8b9gGmAGEsM3R7SUGz9COd9/WXGbkk8rSV5uBoInUTaves8bpHfCgZAPl5oY?=
 =?us-ascii?Q?rYkKbaSL5XbhWSb3c3MmDauLseBV4la+R+Sn7Ia2b7pg0M0kL6Cl1w4/Z2cC?=
 =?us-ascii?Q?ZJTNp/S0NvmzduhdPvBX0b8hqPzv8G4EXWH/M3wlKzWpGszkFIiNjfUdWdnD?=
 =?us-ascii?Q?BQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <5BCFEB0D84C02A41A304FC09C60C75ED@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5131.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a921cad-9fbd-4c2c-2449-08dadd129bcc
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2022 14:02:01.8874
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vhvrkC5XRglz15C+5ZUpd6ZkPAYZW7MjS9EMFxxK8VoP/EQcBmzCe32mBYju/OmTpeNm5WcE7j30gKDFxOqZCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB5781
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-13_03,2022-12-13_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 bulkscore=0
 malwarescore=0 mlxlogscore=999 mlxscore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2212130125
X-Proofpoint-ORIG-GUID: Y43I8-djomg9Uokt62mU31cIP5Kc2V-T
X-Proofpoint-GUID: Y43I8-djomg9Uokt62mU31cIP5Kc2V-T
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Dec 12, 2022, at 10:38 PM, Xingyuan Mo <hdthky0@gmail.com> wrote:
>=20
> On Tue, Dec 13, 2022 at 6:50 AM Dai Ngo <dai.ngo@oracle.com> wrote:
>>=20
>> Problem caused by source's vfsmount being unmounted but remains
>> on the delayed unmount list. This happens when nfs42_ssc_open()
>> return errors.
>>=20
>> Fixed by removing nfsd4_interssc_connect(), leave the vfsmount
>> for the laundromat to unmount when idle time expires.
>>=20
>> We don't need to call nfs_do_sb_deactive when nfs42_ssc_open
>> return errors since the file was not opened so nfs_server->active
>> was not incremented. Same as in nfsd4_copy, if we fail to
>> launch nfsd4_do_async_copy thread then there's no need to
>> call nfs_do_sb_deactive
>>=20
>> Reported-by: Xingyuan Mo <hdthky0@gmail.com>
>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>> ---
>> fs/nfsd/nfs4proc.c | 20 +++++---------------
>> 1 file changed, 5 insertions(+), 15 deletions(-)
>>=20
>> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
>> index 8beb2bc4c328..b79ee65ae016 100644
>> --- a/fs/nfsd/nfs4proc.c
>> +++ b/fs/nfsd/nfs4proc.c
>> @@ -1463,13 +1463,6 @@ nfsd4_interssc_connect(struct nl4_server *nss, st=
ruct svc_rqst *rqstp,
>>        return status;
>> }
>>=20
>> -static void
>> -nfsd4_interssc_disconnect(struct vfsmount *ss_mnt)
>> -{
>> -       nfs_do_sb_deactive(ss_mnt->mnt_sb);
>> -       mntput(ss_mnt);
>> -}
>> -
>> /*
>>  * Verify COPY destination stateid.
>>  *
>> @@ -1572,11 +1565,6 @@ nfsd4_cleanup_inter_ssc(struct vfsmount *ss_mnt, =
struct file *filp,
>> {
>> }
>>=20
>> -static void
>> -nfsd4_interssc_disconnect(struct vfsmount *ss_mnt)
>> -{
>> -}
>> -
>> static struct file *nfs42_ssc_open(struct vfsmount *ss_mnt,
>>                                   struct nfs_fh *src_fh,
>>                                   nfs4_stateid *stateid)
>> @@ -1771,7 +1759,7 @@ static int nfsd4_do_async_copy(void *data)
>>                        default:
>>                                nfserr =3D nfserr_offload_denied;
>>                        }
>> -                       nfsd4_interssc_disconnect(copy->ss_mnt);
>> +                       /* ss_mnt will be unmounted by the laundromat */
>>                        goto do_callback;
>>                }
>>                nfserr =3D nfsd4_do_copy(copy, filp, copy->nf_dst->nf_fil=
e,
>> @@ -1852,8 +1840,10 @@ nfsd4_copy(struct svc_rqst *rqstp, struct nfsd4_c=
ompound_state *cstate,
>>        if (async_copy)
>>                cleanup_async_copy(async_copy);
>>        status =3D nfserrno(-ENOMEM);
>> -       if (nfsd4_ssc_is_inter(copy))
>> -               nfsd4_interssc_disconnect(copy->ss_mnt);
>> +       /*
>> +        * source's vfsmount of inter-copy will be unmounted
>> +        * by the laundromat
>> +        */
>>        goto out;
>> }
>>=20
>> --
>> 2.9.5
>>=20
>=20
> My test results show that this patch can fix the problem.

May I add "Tested-by: Xingyuan Mo <hdthky0@gmail.com>" to Dai's patch ?


--
Chuck Lever



