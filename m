Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E55397388BB
	for <lists+linux-nfs@lfdr.de>; Wed, 21 Jun 2023 17:20:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230144AbjFUPUw (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 21 Jun 2023 11:20:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230393AbjFUPUj (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 21 Jun 2023 11:20:39 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 708002723;
        Wed, 21 Jun 2023 08:17:13 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35LDAo6G030108;
        Wed, 21 Jun 2023 15:17:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=dwbWqEXIN/+gyZkVVMp7xxtc2ZfuTgt5bFnG399hWbY=;
 b=d/ID5EZEjuYdTA23dF9RSGIg8bBIGPwYZV+luW5D0ockd2MYCmgWMP9Pdw7KbbBmbLDW
 Kre7/iMGDw0tHghIvwqQUyzZxq4UsBH/UXBdxIXC+sa8xDy8tUHz5CcX4eyjQz4xU12w
 t82mWFSbDYxrx/wi6pL1xxmFOonrPBgBZLWikeuPxIzeDTNK+ADu8qaKh4EhCOET4rHw
 nhjzGJDGX7ZrbDsLMbAYlA6u62ZMu3jH0vAYk2Dbi4KrvW5Rw3NCSnPZ8FTKajlyPsNA
 M9CwNb4Xfecr6VP+hJ0lL2ehcnbFepCfNYseWOD2MQWmFq7NUtPS/UgoHSpaAbGAmry1 Gw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r93rbqsh7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Jun 2023 15:17:03 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35LEw7kY005799;
        Wed, 21 Jun 2023 15:17:02 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2169.outbound.protection.outlook.com [104.47.73.169])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3r9395y1jj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Jun 2023 15:17:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mXURSZGxh8WeX+C6n3jTv927wrXf3c51VfV3gb7A3EcNJu8t49fM16x35N9pMiQv9Tr5r8vQJO1Rp3i1H6sYPCznxRZeN5P5DZXZOwDtnffzysOeCpYk2maxdKsxwcTO1HlHbnzBM/HAhGYtSbMBAWcIo5m0mdAW0xTey/kjVk4oFcXTaYbIzaK2mpDI26R3h/qcnIsjhwBRyiRt/DysezKekksvBG3qAB1WCSTauUM9rKimSJ1D4DhUgfGk7Ik3A9mwDDfxsVrhTyj57G5JQNmEGX8GjTSj10jfINmyKFntYSKVeVSe1PdqLqES0e6t98ZHw2bnhZx65x91kNeC2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dwbWqEXIN/+gyZkVVMp7xxtc2ZfuTgt5bFnG399hWbY=;
 b=A8yPdYgCmNxtDHTkCZ+Sx8nz/SzKO/zsW25aF5jgylW28kBDwJ2n+MJ1547NL7fLDWxsjLAKbUODXVVWZAoADGzNQsihCt5girt4TGCZQQ1RS5nbbBpnDVYhQsJyTuKhS+DgyTlETxuTDy/gc1Nq026a4PyerzBmk8fknPCC6zvui8TmmgbPfyu4x4A1Xlww/z6IdRnpyfQMUqrTA6fNlg0E1kQO3qZDbGZD719+iK9/z8QPcQI2x1HdTy2m1MCoFyyWVEunHYxaMeqpGnHbZ3u4vN6Mpc2uE2ue++ewxXxpiytKE519tTMwUcs8IP40PN93RQcwJadNqlT58Bbb/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dwbWqEXIN/+gyZkVVMp7xxtc2ZfuTgt5bFnG399hWbY=;
 b=DrA+qSCpYZL9Cd5PL1BMLcJFt5mpWPINv11PoqXaHrnviGf50ayzAVEdFdbJUuAW2wJ2vgN+QNOmWDvIkQdHrxH4fQb7gnduhMfcI8G5hBXgBPqdPB4i3IJIOmPskMe+Fqv1sl0QkTJ8MScYJZgA3cLWn1FezKsyWwNNMe/0t1I=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CY8PR10MB7378.namprd10.prod.outlook.com (2603:10b6:930:95::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Wed, 21 Jun
 2023 15:16:59 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ae00:3b69:f703:7be3]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ae00:3b69:f703:7be3%4]) with mapi id 15.20.6521.023; Wed, 21 Jun 2023
 15:16:59 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Colin Ian King <colin.i.king@gmail.com>
CC:     Jeff Layton <jlayton@kernel.org>, Neil Brown <neilb@suse.de>,
        Olga Kornievskaia <kolga@netapp.com>,
        Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][next] nfsd: remove redundant assignments to variable len
Thread-Topic: [PATCH][next] nfsd: remove redundant assignments to variable len
Thread-Index: AQHZpE/2gGXcRZ8Xuk6bkkIOvHN+CK+VXiyA
Date:   Wed, 21 Jun 2023 15:16:59 +0000
Message-ID: <59159FDC-6343-4C15-B6C5-D1CBD7679942@oracle.com>
References: <20230621145205.2682584-1-colin.i.king@gmail.com>
In-Reply-To: <20230621145205.2682584-1-colin.i.king@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.600.7)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|CY8PR10MB7378:EE_
x-ms-office365-filtering-correlation-id: 44c1254b-f1ea-42de-7337-08db726a8f2d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HEAYcC2U0vFgNAkuQCRpZwj35p7YXrOBytTD4R89GUYpeNUDl2eTjsSX1qy/l6/pyO4tBgzqPogjP/7ZG/3lVLBxXJuKnYrKmHrrN3TBSW7ZM8PA51fHLr3Nyp1Hzfnx0R2FPnSerXMoDEs0Q4Z+UvzPiFFYpnez3yWnfFcaE76OPTV6RniEz1hUnNgjAc4yzFNJmux1+Yj3FVzHyiYKFsqfNtYOfr/tGUKCZw89zIqeJA6sfzEa7zdoxsmDI89+pIhl3k6ii1D7gOdiQpW8fSMxV5tjFkVTt8tKbWvk9RMMpGHtAmHnKJWXf9wZMaE96maTKZsiamMTgHzdgcTU4esjDXGgtpO3QwH+pBpPxdaejR24mwGd1nTzWBbMcEiBqbJbeJol6RG75OcenMk21uPc3XULJL8349u7oanSsQsUz6AwjFKwCWMAkxSgTjl1SD4C09JO2Og/5WCg0Eo4CkYppGhhG8AnGyRgvH8EO0ux/Z+pT2BMELFcOpDLUxPDe6mnubeGCpn49PlLr1ywlHdQ+o5k+kU6ph9/WgiQ580H+YSf0I4+UfZzVeAWTei6EoelETgagcGe0Q0HWpxZPs37w/rDLQmEHptYO2f8W1vMSs/BPQ0e3qHoqYMsnHAZa62toxoN1hSA6WpVGk03qA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(39860400002)(376002)(346002)(366004)(136003)(451199021)(54906003)(478600001)(6486002)(71200400001)(91956017)(76116006)(53546011)(6512007)(6506007)(26005)(186003)(2906002)(66946007)(41300700001)(66556008)(316002)(66446008)(66476007)(64756008)(6916009)(4326008)(5660300002)(8936002)(8676002)(38100700002)(122000001)(86362001)(33656002)(36756003)(38070700005)(83380400001)(2616005)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?lbJi0sVSrVSrIFZbVvjlsUK8H5UNvvSNXN3dgsXh9DXy6gsB+MvSEm+/rWHC?=
 =?us-ascii?Q?clHtRp4bOpgxNZBq4FpdK1/lgjR6POgscI7Rsk8h9GiFKxvA4IN15L0mwAas?=
 =?us-ascii?Q?Eii8T4UDRQ/A9sce8gCG09re4ErPQNulwq4ZiLvMtbCpXne5bkHEyS9nYX8z?=
 =?us-ascii?Q?yWP5hhf0cffxz67axyEWXZPnSCKYdn5ZGObygiFPxeWHAZTmvmsYOLruvJu+?=
 =?us-ascii?Q?NLfVVtuOdJnkPFMswtqsWqN4V/YtVfQIS3Lq9dmAaGa9SBvMeBqBAxcFvPkH?=
 =?us-ascii?Q?SRKaavjTD03ABhpb5wJc7HfAkBS7zhWogbOYyGiIgQKHNfb3KffmhHu8EiKE?=
 =?us-ascii?Q?wqdWtryIXxTuw0ERAR4/30Ib8Y9UMCTdk+1sVW/zb6Op1CmiKWDuthce8cYm?=
 =?us-ascii?Q?lldhuHEx6rT5OaOr1KHLEwPu4xxmdLEx7b24ZEZD7gig1vyos4RUJJIsc8Yl?=
 =?us-ascii?Q?3y5hndFA5M8+ocFk6wnh3FqvpkTFX+FMCtR3pNdCl8yeK1J9BgJM0PdiotQ6?=
 =?us-ascii?Q?TrkTY9rG9XPYatwB29AIC/6MjO4MWr1GlawfCcrIzxSrltx52ZZsj4stzLYl?=
 =?us-ascii?Q?4q4AnLsRNp04X4jeFoSpve0vLTLGG6AndoXGp3tI3F7CTlZJOwsMoSTJYQIb?=
 =?us-ascii?Q?KbtBKfpcl+sRt2OjgDGoMs20zQ1nH+zbF2dteNvnfucOsndvUPcQU11icGfw?=
 =?us-ascii?Q?T8ruOTkWlYF5dZf4uh1lwFW3D1KDAG7SdDNgkqI/pTspheI2GrJXM6tS3Fr6?=
 =?us-ascii?Q?9+ApSDR5gN2nOv1CKnkle7pw6Ec+lxAtSJRgDYwnH454MTI6SmNDsG2FnzUP?=
 =?us-ascii?Q?NfBqrRq+Mu2Sk/zt0VWAUzy5oeQ8WahmisssVI7aJ49uymhjAwdd6ZcbL4nj?=
 =?us-ascii?Q?pNSKNcq2+ZwlopRgtewUWxE9jcIrL7MfPf9a1j+7aCCACClbq6Nd1jJS3jP8?=
 =?us-ascii?Q?nud6DTscoSNaqcEf75iDFDb3TaCC2KmGHoRoenrUOknCZmCCWyWHOkk9BXp2?=
 =?us-ascii?Q?tVcJZYfc4MQpzXK+DBB4ggOe7xhSqYON2+SK4qeTJpGrP/am0fBiASe/pM41?=
 =?us-ascii?Q?VHQk2zMvjCaAdaBUZie0KBoaqaY56DUiUCtLlHyhrSi3QugchAIL7UaPp1gz?=
 =?us-ascii?Q?nGmsrmaAIsPAAWi4iiRmTUkU2RwazJxGuTCenOz9+nmZO5fUFp3jofzGbvuA?=
 =?us-ascii?Q?z9GzwTMX1SDXNP3SapZ+hGus9yk2k8YXpfQzIZqdmhgdsu6MpFIW4SxoH6k4?=
 =?us-ascii?Q?cMKkZO4YR9TlKl/dGEVUwPzP1BmY0PZbRIklNdmkfpeiP3bwDgxDh+B7LK9e?=
 =?us-ascii?Q?p6+F++fpmO9Y0iBb92/qDjSf0C+KzExKRgVmyfg3d7fqllEiMwvh1KwoaxQN?=
 =?us-ascii?Q?VtqLf1SVZX5SUG+Sj5lxVpSdb4T3ROfRvlOribdYfEec89yZfGmlYGmLSfxP?=
 =?us-ascii?Q?qBW07Opn6lYyL8xkm3OsQPcMpZ0jSOnWj/nBG7oQdde/rtUGoxfNSEPHsGgs?=
 =?us-ascii?Q?B84LF4gKe1/8BDy84EdEzZRwkamkhD7Vm3GLaG96wdxjbyeC0lRmCF+WhHo/?=
 =?us-ascii?Q?4XoGPhfRHnimc62AfO/GEahLc5bahZ8S94LMh4jgtDAv9FIGO9COO/SoVNl7?=
 =?us-ascii?Q?Dg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3D69971A4FBB5F40AF227E3A0A7377EE@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: /CwDBkEH0PvsWKgo257Uc/6ys45Sp5KBBEG1EJ7s5wx+Woo3URUDMWx1O1p93FTQ0cBSczbzkkqaROkwpZ4eV1v2DC7uann3rQQWnteUhVQG72Nm/cyBgGOOIizHRZhg2Ms84Cdf0yXF6VHEbzGflLYLD7pK5yAv9p/xnxKKigXdxgI8C3uYMxR/D5A63HAkixrvorj0D510m2I3TxS2eQiYjFHvBgZQcIv7JcnO2RNwEdEWzhRDlckf1wxAGqAnsZiWg5IuuSrCsWrjKwz+7nxJS8MnBzRJyN/dWPMFE/dAufngD8HUc8tro/gRv/NnI9AhXIx35u3uk08iokMBn2xBU5L0TriFol6qTrE0Kj/ten4Zf6DzHAleznfSHJLNE7x8+1iVFH37dB6Ir/nBOB1Xt5w217l14Nlk6nayu32VwfW9lITPTDOfmpiyictDOvujuqeIm1nOOxwMAq2hmI/qOXFlAFb2oZdGtUl4GCj4TkGQp4C0THXVQ+/jTlNvWgDbHfAgWf6O4dSrTqsLArgPG+i+Pp24r/LmblBvZDdbAPACLof3zpGeIse/ZmAZCPPsn39kMt8bhM70MMmbqO7agb1Z8r17oyqVY86l43Q5IC6/SAQFM84/v5aT4HRX4NOfyetQOHTSPEysDQc2vNG6X8++pgDgzqHMfCQczUJuVT6iwrIzS8GugJY6s6yWwEaffJRMNPBRdgZo3HKp7rVxmA57wUckdp2WyWPaTrzHFzGmzxu7lIPjtmvcl6f5Tnw5HKRfxKHvLuxXC1Mgb/hjZFkkQ42E56LptdxTuy1r4mQxcm8DJtcz5JXz5P0IcgJZFuQtpfw4or4Sh0wIVn93CJdDFTF7kOBa+AGFh5F6uBKrHpSJZGc5KeobIxhVLvjUe1VjhDhfYa/hNph6kQ==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44c1254b-f1ea-42de-7337-08db726a8f2d
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2023 15:16:59.7209
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Qf7eoVIqNGYbPw8LdA9+1lnTF30DqTKJ3SyTQz3JNrZiqL86AfzRwoW5dOBwWvTDwUKb5XGHnTgmLX+o+GiSlw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB7378
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-21_08,2023-06-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 spamscore=0 bulkscore=0 malwarescore=0 phishscore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306210128
X-Proofpoint-ORIG-GUID: cO2H-aSZsQnvrbDCnAoMVQ0BtV_fF5sr
X-Proofpoint-GUID: cO2H-aSZsQnvrbDCnAoMVQ0BtV_fF5sr
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jun 21, 2023, at 10:52 AM, Colin Ian King <colin.i.king@gmail.com> wro=
te:
>=20
> There are a few assignments to variable len where the value is not
> being read and so the assignments are redundant and can be removed.
> In one case, the variable len can be removed completely. Cleans up
> 4 clang scan warnings of the form:
>=20
> fs/nfsd/export.c:100:7: warning: Although the value stored to 'len'
> is used in the enclosing expression, the value is never actually
> read from 'len' [deadcode.DeadStores]
>=20
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
> fs/nfsd/export.c | 12 +++++-------
> 1 file changed, 5 insertions(+), 7 deletions(-)
>=20
> diff --git a/fs/nfsd/export.c b/fs/nfsd/export.c
> index ae85257b4238..11a0eaa2f914 100644
> --- a/fs/nfsd/export.c
> +++ b/fs/nfsd/export.c
> @@ -97,7 +97,7 @@ static int expkey_parse(struct cache_detail *cd, char *=
mesg, int mlen)
> goto out;
>=20
> err =3D -EINVAL;
> - if ((len=3Dqword_get(&mesg, buf, PAGE_SIZE)) <=3D 0)
> + if (qword_get(&mesg, buf, PAGE_SIZE) <=3D 0)
> goto out;
>=20
> err =3D -ENOENT;
> @@ -107,7 +107,7 @@ static int expkey_parse(struct cache_detail *cd, char=
 *mesg, int mlen)
> dprintk("found domain %s\n", buf);
>=20
> err =3D -EINVAL;
> - if ((len=3Dqword_get(&mesg, buf, PAGE_SIZE)) <=3D 0)
> + if (qword_get(&mesg, buf, PAGE_SIZE) <=3D 0)
> goto out;
> fsidtype =3D simple_strtoul(buf, &ep, 10);
> if (*ep)
> @@ -593,7 +593,6 @@ static int svc_export_parse(struct cache_detail *cd, =
char *mesg, int mlen)
> {
> /* client path expiry [flags anonuid anongid fsid] */
> char *buf;
> - int len;
> int err;
> struct auth_domain *dom =3D NULL;
> struct svc_export exp =3D {}, *expp;
> @@ -609,8 +608,7 @@ static int svc_export_parse(struct cache_detail *cd, =
char *mesg, int mlen)
>=20
> /* client */
> err =3D -EINVAL;
> - len =3D qword_get(&mesg, buf, PAGE_SIZE);
> - if (len <=3D 0)
> + if (qword_get(&mesg, buf, PAGE_SIZE) <=3D 0)
> goto out;
>=20
> err =3D -ENOENT;
> @@ -620,7 +618,7 @@ static int svc_export_parse(struct cache_detail *cd, =
char *mesg, int mlen)
>=20
> /* path */
> err =3D -EINVAL;
> - if ((len =3D qword_get(&mesg, buf, PAGE_SIZE)) <=3D 0)
> + if (qword_get(&mesg, buf, PAGE_SIZE) <=3D 0)
> goto out1;
>=20
> err =3D kern_path(buf, 0, &exp.ex_path);
> @@ -665,7 +663,7 @@ static int svc_export_parse(struct cache_detail *cd, =
char *mesg, int mlen)
> goto out3;
> exp.ex_fsid =3D an_int;
>=20
> - while ((len =3D qword_get(&mesg, buf, PAGE_SIZE)) > 0) {
> + while (qword_get(&mesg, buf, PAGE_SIZE) > 0) {
> if (strcmp(buf, "fsloc") =3D=3D 0)
> err =3D fsloc_parse(&mesg, buf, &exp.ex_fslocs);
> else if (strcmp(buf, "uuid") =3D=3D 0)
> --=20
> 2.39.2

Thanks, applied to nfsd-next.


--
Chuck Lever


