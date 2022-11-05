Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B1C361DBD7
	for <lists+linux-nfs@lfdr.de>; Sat,  5 Nov 2022 17:00:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbiKEQAe (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 5 Nov 2022 12:00:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230094AbiKEQAa (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 5 Nov 2022 12:00:30 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FF7F1007E
        for <linux-nfs@vger.kernel.org>; Sat,  5 Nov 2022 09:00:25 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A5Ds5l9017214;
        Sat, 5 Nov 2022 16:00:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=AxBjOJkPceLaBlOrM9Mbb/GJL129L+8VEKKSNJ2rjlY=;
 b=nxhkqUi3zSTYx3ojZjgvtV75Lkn4Faw3yJ16a8XsfLvl0ixRx5/FpNoeHw7UXa2VqdkA
 L53U9geZekmjafV/j8llcD3YGTL041zhXLt0u03jBdTzrSkaAOnqIA0cEXebDyZS2grY
 uIv82lKZiTnf2MujOSW99Nvxs2NrojnH3eolFavSy4g9FMwTwqVve5Aht3je+8PmMD4n
 33InLLpTf0T9+uv4Cvo382+NrnJfpkH/FHwDi1jd+7YEC+4rpZ1TKkeqhAOR5zNzz8H3
 bWd8OqrlYuOJAP4/A9WzK5znGukctMLZgc7TeZPcE/j6XLPP6IbGrO8IqVq5a+LwSDyt 1w== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kngregkr8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 05 Nov 2022 16:00:21 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2A5BWEcE006747;
        Sat, 5 Nov 2022 16:00:20 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3kne923kv2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 05 Nov 2022 16:00:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b6J5FLdXFKfC2gMHhoD57mCl4WrSDwrSkRJVaTUUNj+i7PdbC4T1hwoYsGGxBS73doyZgiQ2nErDgUgtT+CNC/gyPQNBt5crZ31Z1d9VP4pTGD3iXSuVK6xybU6kVKcBKP+3lp6+KroNADJtQfpuVIThUeZtJXEySV6lPdaqWL2/Q4/yN3MP1DXoaMv4oqV8wz/uGhAYADa4Q53xkXpPI4I3YviXMgMan8OXX48CxSMUCfWsjDACPiVspODP6xhxDl9996MJqrKWfTvoQw9ihItjnvUXuhk9mZ7qfRSti9hs0KxOcx9/Qhs66k3u+GBgElr8sGHetSk0loNthGXNxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AxBjOJkPceLaBlOrM9Mbb/GJL129L+8VEKKSNJ2rjlY=;
 b=WxK28NML12rfJV8FO4TDXUIez22YSoP7Y2O3Aetw6HzaME9I51O/RMO53J3emFOfCjPtfZd3npJbhghHQ1j6WBAdPm4/BBytcBUkFPP/J3mSgPNrG52h8bVDQaJKm/+mTDgkjJh3wYWjFJamzXJZ/tm/vDFGry5SkNgV6hAxOq1ZX7YtNR/6/1XJZ+jHKG71V+Cccna51aXXdo96HUBJuOxET/2z4wmqEqAHy14wD+DrDnefF++5JDmgvn8XzZN+tRHpLqiL6RghQe4rpfykBHp/ll6gl0wUk3hrNgng4wTJvJS7CJp6EesSkA4YTfL7wM5AjHwNu0SyYQEGdRKNKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AxBjOJkPceLaBlOrM9Mbb/GJL129L+8VEKKSNJ2rjlY=;
 b=YjneE/sCf1nLucGu851ytkzevS83Sx4PFlJc2QIBE+xHJb93fO0xPRG4e5+ndVxBqrnTaiEifj7JT52f1Yk15ihybE160whO8ZLSf/xgusaQBrvV+W6NM9v43kjRf3g4hR1R3hKE44CInVVrGeuwdHer3/AVhbvydaorQk3kMhg=
Received: from DS7PR10MB5134.namprd10.prod.outlook.com (2603:10b6:5:3a1::23)
 by MN2PR10MB4352.namprd10.prod.outlook.com (2603:10b6:208:1de::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.24; Sat, 5 Nov
 2022 16:00:18 +0000
Received: from DS7PR10MB5134.namprd10.prod.outlook.com
 ([fe80::e208:8886:f6f1:ab09]) by DS7PR10MB5134.namprd10.prod.outlook.com
 ([fe80::e208:8886:f6f1:ab09%7]) with mapi id 15.20.5791.022; Sat, 5 Nov 2022
 16:00:18 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     kernel test robot <lkp@intel.com>
CC:     "oe-kbuild-all@lists.linux.dev" <oe-kbuild-all@lists.linux.dev>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [cel:topic-rpc-with-tls-upcall 12/16] net/sunrpc/xprtsock.c:2544:
 undefined reference to `tls_client_hello_x509'
Thread-Topic: [cel:topic-rpc-with-tls-upcall 12/16]
 net/sunrpc/xprtsock.c:2544: undefined reference to `tls_client_hello_x509'
Thread-Index: AQHY8Ny9k6WmGxDKiUqvnAIZ1ZkZLK4wfauA
Date:   Sat, 5 Nov 2022 16:00:18 +0000
Message-ID: <55C1634B-3B7E-4671-8A81-F92495256F1E@oracle.com>
References: <202211051449.mnJj6fib-lkp@intel.com>
In-Reply-To: <202211051449.mnJj6fib-lkp@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR10MB5134:EE_|MN2PR10MB4352:EE_
x-ms-office365-filtering-correlation-id: 7a3b7552-c89c-4775-e71c-08dabf46d5c0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aWHq3gyKCEsswmksiUeVwonWrgUD9enQFXAGWykmtAe5mLOCKZ3gUaTtqwuTUE516B3JBebpI1bBAMkcom9BYdMOLbUc5Ol3DpO7bJwtoHQbRj7Hsbc6WqMeNmrS56XepFRThVSgCdPcxTQdd9XOpjv6m5Jw+pfYQaERCDBoXQKXkcqP/3LvTVy87wVLiBwJQQ4nRT2h7rQo+4+FPxq0UMKOv68rihi1NIS1IY8H0573NVRALVugR2kQPkTT7v2DYC/V+a9xoRYjDLEsOmu1+Webb94nX8jXwKcuBgkc1VRzbMd5uknj6rvp3cIT93iN2lDdsIVP5s52/wvoi87SOxxVdtT2lHJ+Gg+q8qUqarsxV8SrCJdGWWiYL2Ij/UtwhD/cvyVTYJNH23XMqUrg7yi2NQMdtggmwq+Z39B6eLOCntZ2/0zHrVJDJNdNl266bsPRZ5IpqIX960ffMVfIhbMriIUB/DP6+6tS1xU8tZ5B6KwBG40t1D8Xmwpgotr9gRdBM/3am92m5ToUQj8Lnx0s/zI3wKDoss6oHASEY+p7r8jwanqx34o/S0NV8S85M8yE678ZZGYD2Xj20+JxxsThSsbR/dJ+TXJbLZTlPvRLbS2wKgbURUyrhf8X52jahKN8ZFBbsuJdQ8NUAj3rbH34aE9a1kDYIiQgjspkrGgdiKQnTVdLXi8MO1wgoPJb6PKXqGXN5T1i1GLbjvPnnwV8NuFzOYYAuC3jUjP8MhkCip5yQrDLhp8QsO5Uwu/8461rSWvATezBk9yYOm9W705Ma69Qpd0PApeN79kG9VXSiurJtANaunN02GJdbwkUWVpB802Ni9tj3v6e91sTzsjbx0h8hoiwGFV1v15cJODg0Qo7/g16ecEc9M3mMuxFldnz5TSEelyPUR0z6lmFGg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5134.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(39860400002)(136003)(346002)(396003)(366004)(451199015)(316002)(71200400001)(6916009)(54906003)(41300700001)(5660300002)(8936002)(38100700002)(33656002)(4326008)(8676002)(64756008)(122000001)(66446008)(66476007)(66556008)(91956017)(76116006)(66946007)(83380400001)(2616005)(186003)(53546011)(6506007)(26005)(6512007)(6486002)(966005)(478600001)(38070700005)(86362001)(2906002)(36756003)(81973001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?CjCsP6hVb54x7nkAM0XwPi3nU5Ugb61PWDKpNR8Ai3hgE5mOcvoaTLWT/v+J?=
 =?us-ascii?Q?JLfke/iwASluMRKXrwC3zyuGK95jkKVYeAFt0308I2Ik+OIpWnpnGVG/6VnI?=
 =?us-ascii?Q?ur/iFYn6GtQMcWVJQEtXBHLYVRVvFBYt5+rk2Cp2pXLDB6PAWwU5lJO3azpe?=
 =?us-ascii?Q?LlFK5tsmslCpey4qbZ4fZjfMf7ffHOkCJg4d3OCohsbdoFxfiKSwwlSV8RVd?=
 =?us-ascii?Q?9Oo5nYq5mGTkWis7j0NS3XKuPOBmxqbje8Lcwhb+jbyAaLkAfyMwqDQfX8QH?=
 =?us-ascii?Q?BAjKPKCsZMhhwIBL92g6I+zJ16jB6VzJYzSzBBES48mfE4LQOHBVCx/HEI6U?=
 =?us-ascii?Q?t94iO7VWc2yuCHsYO9DvZQ25+mv1yZQtWotfgmsg8japcoLbeYuw/lVaLHKk?=
 =?us-ascii?Q?qChsH98PXfdjB4A1p8hlgKzAOaMNXoXVTaOi58nr8oBeyjan9ZTUouxgxwrl?=
 =?us-ascii?Q?PnJkXsa/px+CZQbvnYDEDqNislu6rwghiIdLWIWsxWcTPlaiuxlPssbgWfux?=
 =?us-ascii?Q?/863ib0nxHdbcwShhz+UsyMSpNZkFPcyzSBt2VNmy709CKksugJTmAMBjkpe?=
 =?us-ascii?Q?rG0OsECW7MAiCKvPSbfu2TSmJHReXMS3mp6FUzeds3QBr2eGKaBz/YdxDU3d?=
 =?us-ascii?Q?f8SsbveaVBDxdibLL/5lCruxxFLmvAeHG4dNZ/MYSk/qoqW4QhxiSa4GdkKN?=
 =?us-ascii?Q?4qAq3sQo9tHwd0baAytvUXSuJ+yf3HFGesy+wF8oyFTd/Gx5Rq/Hxwnw7mV6?=
 =?us-ascii?Q?1I9NpwC2xVoPL6GHLOHpiQRYmjpmqVCHKraC8P2u2tdXpvjG69z0GFt0xS+O?=
 =?us-ascii?Q?zYL1SOZsJ5HbvZ0rHbhAC1BCoAsrCXy0loKGcdvoT7UGD2Bc//F2TN2cSuS7?=
 =?us-ascii?Q?4TJs3Ss81k7oDrMvq/ktUKB683rEmGakNSCuV4FHtzGgWDANqHOHnCMWXXeC?=
 =?us-ascii?Q?WWm6wmmHOevsRowzzvWD/IH+tfXR2L1d2JL38qkgRpex1W7yCxndxAKmy089?=
 =?us-ascii?Q?46cxIoRAa62q8TVfxYBEtLjECiKjoewDCvfMAiUvCY4gorXF+trRhlColROW?=
 =?us-ascii?Q?GUMPzJTj61+FWUaLMPr7AvRJnSZgPu9H5UO4WrsEV72cEmDpBn4KgGnl4GmR?=
 =?us-ascii?Q?+zso6o8btpyXN2ostAu1K18BOWJghVMUA2J/lRFi47xw3PJEm7wqQeWrhOsX?=
 =?us-ascii?Q?vnQVtheZ56CtwhSagKSf63T/2Ib+fjuWZO+KmdIebgUwuMyoy6Jv+BP8R2qu?=
 =?us-ascii?Q?zpmxSa4jkTZEC0I+wndHrsCKDcCZ/reJuiNncWJUG7Pt0qXPhuLT1OWYUnun?=
 =?us-ascii?Q?/cZI9D10wortVqYrPgXOOCy9aRJnGOWbNfTJBCRLpD4mQqvF6RnmVz6xRH4c?=
 =?us-ascii?Q?ljP9wzTqC9l3FhAdBVX9Bfc5uW3lHs3ZBvf6+4Xn2Kf71l9VSTkeh0f38AbH?=
 =?us-ascii?Q?c+KZsiZQBfm1YWry74e35qzfi+JplEc0FfK6KTLzroAMoYf+vZyafh2verij?=
 =?us-ascii?Q?/JGqUnoY/4istwV22tSTIWb7n++yyCbRM5rNTBiNkmcdP0U6HB4Wt9WJ6sej?=
 =?us-ascii?Q?B6QiMKah3rOxoccKNaaxsyOcJK17Gq6SxWIwUpT591vRObUfmsg0IvAUut+Q?=
 =?us-ascii?Q?5w=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <77D0A9DB49033E4B9DB1484C36EE41AF@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5134.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a3b7552-c89c-4775-e71c-08dabf46d5c0
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2022 16:00:18.0683
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Io4pOCeXOTfg4rjI20eZ+R3Ym+x02A7W7Ipw8B5SeKH0evvv8bbB+IOsRc2XB669ZnJNiPvNA4qbegOaV/MZAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4352
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-05_09,2022-11-03_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 spamscore=0
 suspectscore=0 adultscore=0 mlxlogscore=999 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211050121
X-Proofpoint-ORIG-GUID: s6-lXqmpxz5lvyLO4V2pUknCdNBSprGs
X-Proofpoint-GUID: s6-lXqmpxz5lvyLO4V2pUknCdNBSprGs
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Nov 5, 2022, at 2:05 AM, kernel test robot <lkp@intel.com> wrote:
>=20
> tree:   git://git.kernel.org/pub/scm/linux/kernel/git/cel/linux topic-rpc=
-with-tls-upcall
> head:   92abd0e9e73597857455026e8312192264aaabf9
> commit: b39cc345e2d6ed4f37bea31528ccbfaa3dec4f69 [12/16] SUNRPC: Add RPC-=
with-TLS support to xprtsock.c
> config: x86_64-rhel-8.3-kvm
> compiler: gcc-11 (Debian 11.3.0-8) 11.3.0
> reproduce (this is a W=3D1 build):
>        # https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git/co=
mmit/?id=3Db39cc345e2d6ed4f37bea31528ccbfaa3dec4f69
>        git remote add cel git://git.kernel.org/pub/scm/linux/kernel/git/c=
el/linux
>        git fetch --no-tags cel topic-rpc-with-tls-upcall
>        git checkout b39cc345e2d6ed4f37bea31528ccbfaa3dec4f69
>        # save the config file
>        mkdir build_dir && cp config build_dir/.config
>        make W=3D1 O=3Dbuild_dir ARCH=3Dx86_64 SHELL=3D/bin/bash
>=20
> If you fix the issue, kindly add following tag where applicable
> | Reported-by: kernel test robot <lkp@intel.com>
>=20
> All errors (new ones prefixed by >>):
>=20
>   ld: net/sunrpc/xprtsock.o: in function `xs_tls_handshake_sync':
>>> net/sunrpc/xprtsock.c:2544: undefined reference to `tls_client_hello_x5=
09'
>>> ld: net/sunrpc/xprtsock.c:2539: undefined reference to `tls_client_hell=
o_anon'
>   pahole: .tmp_vmlinux.btf: No such file or directory
>   .btf.vmlinux.bin.o: file not recognized: file format not recognized

I am not able to reproduce this build failure.

I'm on Fedora 36 with gcc-12.2.1-2

CONFIG_TLS=3Dm
CONFIG_TLS_DEVICE=3Dy

CONFIG_SUNRPC=3Dy

Any help appreciated!


> vim +2544 net/sunrpc/xprtsock.c
>=20
>  2526=09
>  2527	static int xs_tls_handshake_sync(struct rpc_xprt *lower_xprt, struc=
t xprtsec_parms *xprtsec)
>  2528	{
>  2529		struct sock_xprt *lower_transport =3D
>  2530					container_of(lower_xprt, struct sock_xprt, xprt);
>  2531		int rc;
>  2532=09
>  2533		init_completion(&lower_transport->handshake_done);
>  2534		set_bit(XPRT_SOCK_IGNORE_RECV, &lower_transport->sock_state);
>  2535=09
>  2536		lower_transport->xprt_err =3D -ETIMEDOUT;
>  2537		switch (xprtsec->policy) {
>  2538		case RPC_XPRTSEC_TLS_ANON:
>> 2539			rc =3D tls_client_hello_anon(lower_transport->sock,
>  2540						   xs_tls_handshake_done, xprt_get(lower_xprt),
>  2541						   TLSH_DEFAULT_PRIORITIES);
>  2542			break;
>  2543		case RPC_XPRTSEC_TLS_X509:
>> 2544			rc =3D tls_client_hello_x509(lower_transport->sock,
>  2545						   xs_tls_handshake_done, xprt_get(lower_xprt),
>  2546						   TLSH_DEFAULT_PRIORITIES,
>  2547						   xprtsec->cert_serial,
>  2548						   xprtsec->privkey_serial);
>  2549			break;
>  2550		default:
>  2551			rc =3D -EACCES;
>  2552		}
>  2553		if (rc)
>  2554			goto out;
>  2555=09
>  2556		rc =3D wait_for_completion_interruptible_timeout(&lower_transport-=
>handshake_done,
>  2557							       XS_TLS_HANDSHAKE_TO);
>  2558		if (rc < 0)
>  2559			goto out;
>  2560=09
>  2561		rc =3D lower_transport->xprt_err;
>  2562=09
>  2563	out:
>  2564		xs_stream_reset_connect(lower_transport);
>  2565		clear_bit(XPRT_SOCK_IGNORE_RECV, &lower_transport->sock_state);
>  2566		return rc;
>  2567	}
>  2568=09
>=20
> --=20
> 0-DAY CI Kernel Test Service
> https://01.org/lkp
> <config.txt>

--
Chuck Lever



