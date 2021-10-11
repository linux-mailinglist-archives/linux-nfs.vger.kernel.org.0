Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 317534294A9
	for <lists+linux-nfs@lfdr.de>; Mon, 11 Oct 2021 18:37:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232419AbhJKQjT (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 11 Oct 2021 12:39:19 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:46946 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231655AbhJKQjQ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 11 Oct 2021 12:39:16 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19BFqQGD004394;
        Mon, 11 Oct 2021 16:37:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=MH6rzBml9JDVmE6PtSSYzGyYEiORbPscF4Al8kxHFeY=;
 b=pGn3bBt1T9VVKWVqhdGH8OYTuAad5mVp6f9CWmhWZFde/UjA//2BLq4JxUr74qMUrItE
 6c0FXHW4IBZlCgZf1MMlGZqNW0+UZomYd1v/KkLnrwe84I6JR4G0fZ4QHdBVFavJ7KEl
 +LJDN3OguhegE3xrwOX2Cg5cA1Gr/lhc3ex7y5EppZReerNmYf3x7JVkwrFBN/JypcZX
 khGlVyDTsvYwY62iyZEl0vfRTS0/goeO2HGkvxoUOcn0zyRnj2qCJox6xZkL4WiWYdlP
 maFhGL0p7j6PlkZ5uyPFjWjoXgOC58sYho15gSsrg9cEd84dpdm4TMZO39lpUKCdRM96 AA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bmq3b8uxk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Oct 2021 16:36:58 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 19BGV5TD103655;
        Mon, 11 Oct 2021 16:36:52 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2177.outbound.protection.outlook.com [104.47.57.177])
        by userp3020.oracle.com with ESMTP id 3bkyv8hp37-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Oct 2021 16:36:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LKI2G7sq03BhcIDinP/Re4hYZouVtr1AGxamwCk2Xx6WL3dVHlncvcuw33oIjvHAdI4WprgOz9mT8Yp5HzIxsaeU915hahh/vy+oliFGgfoOj5YfiuxLMLDJDqcmOfgKdwn2goFebfWn/CZygGApG2+Ji6OZviPHwxNz+3WX+sgFhdVs3OhPtLjItQuN00LOv+VfwxqSmYESO847hPtBjCUiJ1sNKy4TqYDDsyQ6XtqOhY73psHqE0MolZhoUk2RhddBmXEgM/JuEYNkPp8gZoYYKwjjdp47hg5PzNzFMDHV3/So0hVG36+X2nYVtEsUCOLrhQpZf9Aib63RXy0rlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MH6rzBml9JDVmE6PtSSYzGyYEiORbPscF4Al8kxHFeY=;
 b=i7fgy/FeLrS2NWXt6P0VXvhKC3payyuonRB6rafjbaairCcmVrYtzMuZEGMyz37lUxOtCGh6Xk8QFtr8bL/W3c4J4SNMPkEz7hQqzWBkDQmrxbwnmHqg0vxpglxfxXV3gpwUcjTdC8KQ+lXh7e77kmjNQ1GaJcuUZPgRPQZG5NlwjHBCTa+B6vVj2jm0tr1xcbr87p39GypWHxp4nmGcD2797r0LLnxWx+wBDV3POyRO7JUutv2jN5HssaKb2+oMmTwnUxpV/LcECfadoHFnRPAS6se3rcI21darkqcKiQnNSuVknD6sC7Wj7fqWjwuV33+ptW2e2OdE0qJXXjXc/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MH6rzBml9JDVmE6PtSSYzGyYEiORbPscF4Al8kxHFeY=;
 b=is81f0L7Xo5KPsCpJeAJtEcgjvKQtje40i0cwJLWJyc0VVhv7wux21G3ZGpv7Dek7LnAscix9ZYX3kLSbfgI7WiGmMnkg2HWxzDhWMrYLHuku+NUE+SoMi/YEoMZhLtYyYuJWqFwW0fwlHpX0rrjbN6zOq/OJ3LJrr14wtQMT1A=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by BYAPR10MB3141.namprd10.prod.outlook.com (2603:10b6:a03:154::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.25; Mon, 11 Oct
 2021 16:36:49 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::f4fe:5b4:6bd9:4c5b]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::f4fe:5b4:6bd9:4c5b%6]) with mapi id 15.20.4587.026; Mon, 11 Oct 2021
 16:36:49 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Bruce Fields <bfields@fieldses.org>
CC:     Scott Mayhew <smayhew@redhat.com>, Neil Brown <neilb@suse.de>,
        Timothy Pearson <tpearson@raptorengineering.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Trond Myklebust <trondmy@gmail.com>
Subject: Re: CPU stall, eventual host hang with BTRFS + NFS under heavy load
Thread-Topic: CPU stall, eventual host hang with BTRFS + NFS under heavy load
Thread-Index: xSdTgH983VDBQkCAmg52fDts9flGRuDSBNJBgAFhrICAAvGVAIAAI0wA
Date:   Mon, 11 Oct 2021 16:36:49 +0000
Message-ID: <34A4C7EB-2798-4482-A786-90161F5F9E34@oracle.com>
References: <281642234.3818.1625478269194.JavaMail.zimbra@raptorengineeringinc.com>
 <162855621114.22632.14151019687856585770@noble.neil.brown.name>
 <20210812144428.GA9536@fieldses.org>
 <162880418532.15074.7140645794203395299@noble.neil.brown.name>
 <YWCpnsdVqssFaLrf@aion.usersys.redhat.com>
 <589AFA4F-DF8E-45A3-8299-54E820E33169@oracle.com>
 <20211011143028.GB22387@fieldses.org>
In-Reply-To: <20211011143028.GB22387@fieldses.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
authentication-results: fieldses.org; dkim=none (message not signed)
 header.d=none;fieldses.org; dmarc=none action=none header.from=oracle.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d9445408-cd2c-4993-8c05-08d98cd552fb
x-ms-traffictypediagnostic: BYAPR10MB3141:
x-microsoft-antispam-prvs: <BYAPR10MB31416B88289C83E581B6B6FD93B59@BYAPR10MB3141.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4Nvn6ruhqa9xdkzoxQIbSLW3UvFvuiBGdnpwqej01C0HBK8mAu/7ATCttNngErqjvAYovHoUNMqQ7QGUoX0dkVG7SuVoj5WY0iMiJVYM7lLdBjg5mOoa4iO2cGc5B0Ow4k9yyMu4f6/FQI5wBBxlqXqxYRSY1dojQnjcrDHFRslC7Fsj+4TYEejIG5ocpqYt1dpoyR3GuzSbIZg5jFQanrN3wcHrygilJ+mea6aL9z0dBc8BdMd/R8CL/dGZLjWwtCutzJZXa5aRRsSdg194KJTxDpp6TnSmv4b2s1HyaCGCLJqwFEIZxlqM3yzg+JgZ2+0H4zWHVdshAQhnAZvyq1wStcSF0csxe0DWjHPjRlQQqMXA5coeH+16D+Z25UuJ/lWpEqF1AWOa9FBB3pF+uM+DN+abfR0Ui8stSkDSsr4AkI0CicEPkwsE9trg/86mtkgy/0/WYlP7USAr2U1Ff5lxR6/Ne027nsXE2CjN8PKUf1WQQnojwLTKECEWAR0NDZLMekBK8CpHBZwwxb+y2cvvCoWMMhQTyGlLptEwcwtU7D45QmGuE+QEgjZ7f15Am/hMfKfimP29pGii8WyuGSsgyfRcHRfmoYboIXchf/joOZc8UHDlFZD3nFG+RjkyxSBZkJnRlPj8kUvcMvo3pKuwRTl1w0oDv3e2ZD5wtg2eCL81tzl8d2KkhOKcE4Ef3Nr4gddtAY/UrOgNj7AzM/iR4uGfCKdsIalHInNKXwzSxdQXFwmB9Hj8arJDIRz7UzD70Em5DPmwe+xZIspLyi1SXIOxut95jZSqrb+sFF/+efVumTdMeibWk1plU5+CngeTdVPtzEimZCIl6g4BRA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(122000001)(6486002)(8936002)(8676002)(45080400002)(33656002)(6506007)(54906003)(316002)(38100700002)(5660300002)(4326008)(966005)(53546011)(508600001)(86362001)(2616005)(186003)(6916009)(2906002)(71200400001)(76116006)(36756003)(91956017)(6512007)(66556008)(38070700005)(83380400001)(26005)(66446008)(66946007)(64756008)(66476007)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?TkLM2SCIgWDTEVku4ih3qKXY4fEFrFLleNUVgz+bp22b2CdLxNeUvBKkHzPn?=
 =?us-ascii?Q?rh+zH1zdJ6lnXaSlbTBkWMimobv7rLD8fDAi8b7cLaB9qyQ0mrGODeWa0kcB?=
 =?us-ascii?Q?1PKhQakSj8jQSr6ZaKXMHZ9xoMwUqHNJEUFs5yyjg2K0l+T4zByHEkLBle1G?=
 =?us-ascii?Q?oUGH9InwIyb8akPf3biwbCwrDMPPUM/Ib82wEQWr1wtXzFbXIOCKL1MExxKZ?=
 =?us-ascii?Q?hvk99kwrSDoZpT672gELJn4ubQfZ9mLPgp0UvW3RIHCO7et6DRZ3jFQ9ezvM?=
 =?us-ascii?Q?vpQXlLXK8Xnb/BNK8I4Wadb1zyTE9fWIZg9WaYDFfEDjPNJ7Yyzra/GYicYP?=
 =?us-ascii?Q?0H4pi2Hfeg+lUxQbGuetgKhrledSvxOri+N43oiwsR0CTSaHQouOLVhH1eaV?=
 =?us-ascii?Q?TfLc3icnxxSdYJLoUglDir737ty8LD/9jcQ6HsFYDme+3u7bgptb1EmSmUeB?=
 =?us-ascii?Q?HDGERMaFGLlxd1OWArhEqwoosw0pUSTtYAoAjPQjmiKU73FUaeXou8ac7eM5?=
 =?us-ascii?Q?qZovMf6rDipu1mojGQ0EYvcbgavjnYfGVcTMHZQczwb51fFSfG8gARMuSJG+?=
 =?us-ascii?Q?i7TC93hPK/V5k0ZAVFD3t7O4gnENmvhiziJvW4Lqn7qiUp4LMlXuhp3OhDHB?=
 =?us-ascii?Q?sxEX+Y7o3+3O7jaG9TybaYPf8G3HCNGtcy228mMx4W6G/iTSJzo1qKfk4Al3?=
 =?us-ascii?Q?JxHzyKP+Fq8WpADsvhHy2ZINI9UoHWVXmt9CKiWkPe+HgNkCqluSZZFLLzJ4?=
 =?us-ascii?Q?MTsrn+gLgeeVA+13q8mPd9l/Hc+65IJWaKa44WcHpXNgJMiXfX35TU6cPA0w?=
 =?us-ascii?Q?x6GgSgMB7K7o9x6YEt+Oqi/yUp363LS652hNNEJ0tvC+t/aAf2j9E6GcIe7W?=
 =?us-ascii?Q?57rvsm1yQaauIzjhpaQT/U0cZTFPdzqYn13tMkPgOMmnKMphqQ2PvzgU2TYC?=
 =?us-ascii?Q?lKdE5g1/XJcmmmHaC9UB/h6Ney1R+ahpuZet5oWeDMTT4q3zo6gs8E4l36C/?=
 =?us-ascii?Q?FrETbr4UBbHcCnF2VJdIFXWz2aBbnnvBdlKjne8ASYz2uQP5H5MGxb86Xhob?=
 =?us-ascii?Q?pW21z2qCZVd632BiZvVQBWh5MUYofoVpyrDOSwUyFptuMSE9Up5npyCO7RIA?=
 =?us-ascii?Q?bRFuHYEjSbwsAJjUcstp2pxJKcYPvq9aya3dMrQHz4NIlnDrtMAWsKmvBahx?=
 =?us-ascii?Q?7gpOkGII0MG+Zf7FWTWP/ONVTRe9xO0mGzPwDLtj126z4k2zJ2qH1G3qqxHZ?=
 =?us-ascii?Q?2Y3LNfFp3WQUbeaSekr0tN9YJfJD+s4uukakQlF69T6kZKaJD2IxYz7zZvz+?=
 =?us-ascii?Q?owIeNyjvUZLbYgeN4x9hAM8r?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <97AC8B4626F946409F4212A77D0B6648@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9445408-cd2c-4993-8c05-08d98cd552fb
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Oct 2021 16:36:49.6471
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SBMsUxZACWUFEASJVBS/f5w2Cqb+NiBqvdA89yJuB4JBUhxoz9lY+mx+cFmJZ0V1aeFLr1OSL+yZ5rsrqNCfPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3141
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10134 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 adultscore=0 bulkscore=0 mlxscore=0 spamscore=0 mlxlogscore=999
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110110097
X-Proofpoint-GUID: PpXXd7zKFt0Rdit5_QGSDJJR9adpe-aM
X-Proofpoint-ORIG-GUID: PpXXd7zKFt0Rdit5_QGSDJJR9adpe-aM
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Oct 11, 2021, at 10:30 AM, Bruce Fields <bfields@fieldses.org> wrote:
>=20
> On Sat, Oct 09, 2021 at 05:33:18PM +0000, Chuck Lever III wrote:
>>=20
>>=20
>>> On Oct 8, 2021, at 4:27 PM, Scott Mayhew <smayhew@redhat.com> wrote:
>>>=20
>>> On Fri, 13 Aug 2021, NeilBrown wrote:
>>>=20
>>>> On Fri, 13 Aug 2021, J.  Bruce Fields wrote:
>>>>> On Tue, Aug 10, 2021 at 10:43:31AM +1000, NeilBrown wrote:
>>>>>>=20
>>>>>> The problem here appears to be that a signalled task is being retrie=
d
>>>>>> without clearing the SIGNALLED flag.  That is causing the infinite l=
oop
>>>>>> and the soft lockup.
>>>>>>=20
>>>>>> This bug appears to have been introduced in Linux 5.2 by
>>>>>> Commit: ae67bd3821bb ("SUNRPC: Fix up task signalling")
>>>>>=20
>>>>> I wonder how we arrived here.  Does it require that an rpc task retur=
ns
>>>>> from one of those rpc_delay() calls just as rpc_shutdown_client() is
>>>>> signalling it?  That's the only way async tasks get signalled, I thin=
k.
>>>>=20
>>>> I don't think "just as" is needed.
>>>> I think it could only happen if rpc_shutdown_client() were called when
>>>> there were active tasks - presumably from nfsd4_process_cb_update(), b=
ut
>>>> I don't know the callback code well.
>>>> If any of those active tasks has a ->done handler which might try to
>>>> reschedule the task when tk_status =3D=3D -ERESTARTSYS, then you get i=
nto
>>>> the infinite loop.
>>>=20
>>> This thread seems to have fizzled out, but I'm pretty sure I hit this
>>> during the Virtual Bakeathon yesterday.  My server was unresponsive but
>>> I eventually managed to get a vmcore.
>>>=20
>>> [182411.119788] receive_cb_reply: Got unrecognized reply: calldir 0x1 x=
pt_bc_xprt 00000000f2f40905 xid 5d83adfb
>>> [182437.775113] watchdog: BUG: soft lockup - CPU#1 stuck for 26s! [kwor=
ker/u4:1:216458]
>>> [182437.775633] Modules linked in: nfs_layout_flexfiles nfsv3 nfs_layou=
t_nfsv41_files bluetooth ecdh_generic ecc rpcsec_gss_krb5 nfsv4 dns_resolve=
r nfs fscache netfs rpcrdma rdma_cm iw_cm ib_cm ib_core tun rfkill nft_fib_=
inet nft_fib_ipv4 nft_fib_ipv6 nft_fib isofs cdrom nft_reject_inet nf_rejec=
t_ipv4 nf_reject_ipv6 nft_reject nft_ct nft_chain_nat nf_nat nf_conntrack n=
f_defrag_ipv6 nf_defrag_ipv4 ip_set nf_tables nfnetlink xfs intel_rapl_msr =
intel_rapl_common libcrc32c kvm_intel qxl kvm drm_ttm_helper ttm drm_kms_he=
lper syscopyarea sysfillrect sysimgblt fb_sys_fops irqbypass cec joydev vir=
tio_balloon pcspkr i2c_piix4 nfsd auth_rpcgss nfs_acl lockd grace sunrpc dr=
m fuse ext4 mbcache jbd2 ata_generic crct10dif_pclmul crc32_pclmul crc32c_i=
ntel ghash_clmulni_intel virtio_net serio_raw ata_piix net_failover libata =
virtio_blk virtio_scsi failover dm_mirror dm_region_hash dm_log dm_mod
>>> [182437.780157] CPU: 1 PID: 216458 Comm: kworker/u4:1 Kdump: loaded Not=
 tainted 5.14.0-5.el9.x86_64 #1
>>> [182437.780894] Hardware name: DigitalOcean Droplet, BIOS 20171212 12/1=
2/2017
>>> [182437.781567] Workqueue: rpciod rpc_async_schedule [sunrpc]
>>> [182437.782500] RIP: 0010:try_to_grab_pending+0x12/0x160
>>> [182437.783104] Code: e7 e8 72 f3 ff ff e9 6e ff ff ff 48 89 df e8 65 f=
3 ff ff eb b7 0f 1f 00 0f 1f 44 00 00 41 55 41 54 55 48 89 d5 53 48 89 fb 9=
c <58> fa 48 89 02 40 84 f6 0f 85 92 00 00 00 f0 48 0f ba 2b 00 72 09
>>> [182437.784261] RSP: 0018:ffffb5b24066fd30 EFLAGS: 00000246
>>> [182437.785052] RAX: 0000000000000000 RBX: ffffffffc05e0768 RCX: 000000=
00000007d0
>>> [182437.785760] RDX: ffffb5b24066fd60 RSI: 0000000000000001 RDI: ffffff=
ffc05e0768
>>> [182437.786399] RBP: ffffb5b24066fd60 R08: ffffffffc05e0708 R09: ffffff=
ffc05e0708
>>> [182437.787010] R10: 0000000000000003 R11: 0000000000000003 R12: ffffff=
ffc05e0768
>>> [182437.787621] R13: ffff9daa40312400 R14: 00000000000007d0 R15: 000000=
0000000000
>>> [182437.788235] FS:  0000000000000000(0000) GS:ffff9daa5bd00000(0000) k=
nlGS:0000000000000000
>>> [182437.788859] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>> [182437.789483] CR2: 00007f8f73d5d828 CR3: 000000008a010003 CR4: 000000=
00001706e0
>>> [182437.790188] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 000000=
0000000000
>>> [182437.790831] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 000000=
0000000400
>>> [182437.791522] Call Trace:
>>> [182437.792183]  mod_delayed_work_on+0x3c/0x90
>>> [182437.792866]  __rpc_sleep_on_priority_timeout+0x107/0x110 [sunrpc]
>>> [182437.793553]  rpc_delay+0x56/0x90 [sunrpc]
>>> [182437.794236]  nfsd4_cb_sequence_done+0x202/0x290 [nfsd]
>>> [182437.794910]  nfsd4_cb_done+0x18/0xf0 [nfsd]
>>> [182437.795974]  rpc_exit_task+0x58/0x100 [sunrpc]
>>> [182437.796955]  ? rpc_do_put_task+0x60/0x60 [sunrpc]
>>> [182437.797645]  __rpc_execute+0x5e/0x250 [sunrpc]
>>> [182437.798375]  rpc_async_schedule+0x29/0x40 [sunrpc]
>>> [182437.799043]  process_one_work+0x1e6/0x380
>>> [182437.799703]  worker_thread+0x53/0x3d0
>>> [182437.800393]  ? process_one_work+0x380/0x380
>>> [182437.801029]  kthread+0x10f/0x130
>>> [182437.801686]  ? set_kthread_struct+0x40/0x40
>>> [182437.802333]  ret_from_fork+0x22/0x30
>>>=20
>>> The process causing the soft lockup warnings:
>>>=20
>>> crash> set 216458
>>>   PID: 216458
>>> COMMAND: "kworker/u4:1"
>>>  TASK: ffff9da94281e200  [THREAD_INFO: ffff9da94281e200]
>>>   CPU: 0
>>> STATE: TASK_RUNNING (ACTIVE)
>>> crash> bt
>>> PID: 216458  TASK: ffff9da94281e200  CPU: 0   COMMAND: "kworker/u4:1"
>>> #0 [fffffe000000be50] crash_nmi_callback at ffffffffb3055c31
>>> #1 [fffffe000000be58] nmi_handle at ffffffffb30268f8
>>> #2 [fffffe000000bea0] default_do_nmi at ffffffffb3a36d42
>>> #3 [fffffe000000bec8] exc_nmi at ffffffffb3a36f49
>>> #4 [fffffe000000bef0] end_repeat_nmi at ffffffffb3c013cb
>>>   [exception RIP: add_timer]
>>>   RIP: ffffffffb317c230  RSP: ffffb5b24066fd58  RFLAGS: 00000046
>>>   RAX: 000000010b3585fc  RBX: 0000000000000000  RCX: 00000000000007d0
>>>   RDX: ffffffffc05e0768  RSI: ffff9daa40312400  RDI: ffffffffc05e0788
>>>   RBP: 0000000000002000   R8: ffffffffc05e0770   R9: ffffffffc05e0788
>>>   R10: 0000000000000003  R11: 0000000000000003  R12: ffffffffc05e0768
>>>   R13: ffff9daa40312400  R14: 00000000000007d0  R15: 0000000000000000
>>>   ORIG_RAX: ffffffffffffffff  CS: 0010  SS: 0018
>>> --- <NMI exception stack> ---
>>> #5 [ffffb5b24066fd58] add_timer at ffffffffb317c230
>>> #6 [ffffb5b24066fd58] mod_delayed_work_on at ffffffffb3103247
>>> #7 [ffffb5b24066fd98] __rpc_sleep_on_priority_timeout at ffffffffc05805=
47 [sunrpc]
>>> #8 [ffffb5b24066fdc8] rpc_delay at ffffffffc0589ed6 [sunrpc]
>>> #9 [ffffb5b24066fde8] nfsd4_cb_sequence_done at ffffffffc06731b2 [nfsd]
>>> #10 [ffffb5b24066fe10] nfsd4_cb_done at ffffffffc0673258 [nfsd]
>>> #11 [ffffb5b24066fe30] rpc_exit_task at ffffffffc05800a8 [sunrpc]
>>> #12 [ffffb5b24066fe40] __rpc_execute at ffffffffc0589fee [sunrpc]
>>> #13 [ffffb5b24066fe70] rpc_async_schedule at ffffffffc058a209 [sunrpc]
>>> #14 [ffffb5b24066fe88] process_one_work at ffffffffb31026c6
>>> #15 [ffffb5b24066fed0] worker_thread at ffffffffb31028b3
>>> #16 [ffffb5b24066ff10] kthread at ffffffffb310960f
>>> #17 [ffffb5b24066ff50] ret_from_fork at ffffffffb30034f2
>>>=20
>>> Looking at the rpc_task being executed:
>>>=20
>>> crash> rpc_task.tk_status,tk_callback,tk_action,tk_runstate,tk_client,t=
k_flags ffff9da94120bd00
>>> tk_status =3D 0x0
>>> tk_callback =3D 0xffffffffc057bc60 <__rpc_atrun>
>>> tk_action =3D 0xffffffffc0571f20 <call_start>
>>> tk_runstate =3D 0x47
>>> tk_client =3D 0xffff9da958909c00
>>> tk_flags =3D 0x2281
>>>=20
>>> tk_runstate has the following flags set: RPC_TASK_SIGNALLED, RPC_TASK_A=
CTIVE,
>>> RPC_TASK_QUEUED, and RPC_TASK_RUNNING.
>>>=20
>>> tk_flags is RPC_TASK_NOCONNECT|RPC_TASK_SOFT|RPC_TASK_DYNAMIC|RPC_TASK_=
ASYNC.
>>>=20
>>> There's another kworker thread calling rpc_shutdown_client() via
>>> nfsd4_process_cb_update():
>>>=20
>>> crash> bt 0x342a3
>>> PID: 213667  TASK: ffff9daa4fde9880  CPU: 1   COMMAND: "kworker/u4:4"
>>> #0 [ffffb5b24077bbe0] __schedule at ffffffffb3a40ec6
>>> #1 [ffffb5b24077bc60] schedule at ffffffffb3a4124c
>>> #2 [ffffb5b24077bc78] schedule_timeout at ffffffffb3a45058
>>> #3 [ffffb5b24077bcd0] rpc_shutdown_client at ffffffffc056fbb3 [sunrpc]
>>> #4 [ffffb5b24077bd20] nfsd4_process_cb_update at ffffffffc0672c6c [nfsd=
]
>>> #5 [ffffb5b24077be68] nfsd4_run_cb_work at ffffffffc0672f0f [nfsd]
>>> #6 [ffffb5b24077be88] process_one_work at ffffffffb31026c6
>>> #7 [ffffb5b24077bed0] worker_thread at ffffffffb31028b3
>>> #8 [ffffb5b24077bf10] kthread at ffffffffb310960f
>>> #9 [ffffb5b24077bf50] ret_from_fork at ffffffffb30034f2
>>>=20
>>> The rpc_clnt being shut down is:
>>>=20
>>> crash> nfs4_client.cl_cb_client ffff9daa454db808
>>> cl_cb_client =3D 0xffff9da958909c00
>>>=20
>>> Which is the same as the tk_client for the rpc_task being executed by t=
he
>>> thread triggering the soft lockup warnings.
>>=20
>> I've seen a similar issue before.
>>=20
>> There is a race between shutting down the client (which kills
>> running RPC tasks) and some process starting another RPC task
>> under this client.
>=20
> Neil's analysis looked pretty convincing:
>=20
> https://lore.kernel.org/linux-nfs/589AFA4F-DF8E-45A3-8299-54E820E33169@or=
acle.com/T/#m9c84d4c8f71422f4f10b1e4b0fae442af449366a

That lines up with my (scant) experience in this area.


> Assuming this is the same thing--he thought it was a regression due to
> ae67bd3821bb ("SUNRPC: Fix up task signalling").  I'm not sure if the
> bug is in that patch or if it's uncovering a preexisting bug in how nfsd
> reschedules callbacks.

Post-mortem analysis has been great, but it seems to have hit a
dead end. We understand where we end up, but not yet how we got
there.

Scott seems well positioned to identify a reproducer. Maybe we
can give him some likely candidates for possible bugs to explore
first.

--
Chuck Lever



