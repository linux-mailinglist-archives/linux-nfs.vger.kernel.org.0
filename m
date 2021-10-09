Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 103EB427C66
	for <lists+linux-nfs@lfdr.de>; Sat,  9 Oct 2021 19:33:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229984AbhJIRfi (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 9 Oct 2021 13:35:38 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:53694 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229928AbhJIRfh (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 9 Oct 2021 13:35:37 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 199DsaM4001428;
        Sat, 9 Oct 2021 17:33:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=I8iQrbrqSl1RYjfsE9QJ82kawLOKqmOgbCN+VsRIqfQ=;
 b=VI0pH23wC8r7dVIfy/cnBaJ9eVBCblfB8dUcwUP9kmHAG2qdIW53MRpriuWN7iU14rF8
 wdETACVzIw+i1h1/uwcFi7WOMxQkltBDceGPsIolw5AuJX2XBYsKsHfGaIvuXB051iSf
 ORyJgBxD9FC2A9QlcgzaXMA/+bA/fBKW2SGu84iOWx22BaWsTqlXRo02VnrtXaztL00d
 9o9gsfnke1c8SDe8igyf9kwTZV73PFRO1aTlHIm1zK3mi3b/uof8V7yGV8AUz1uxDAzU
 aAgymBvA0/+dBOn0etwBr+AUPnx4bUxSrPgItnf+PmQnSrKkZ547rNcYDT9uZTq1UVhg 6g== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bk1p1skub-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 09 Oct 2021 17:33:24 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 199HUvBq169735;
        Sat, 9 Oct 2021 17:33:22 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2170.outbound.protection.outlook.com [104.47.55.170])
        by userp3020.oracle.com with ESMTP id 3bk2dkunqv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 09 Oct 2021 17:33:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hAa5Tnf5aCkWj6kJtmLrWlQiOhn7nBZkHlvqDx3Zk7PihfQaTmieDL9tVt6TFXa+7t1rmD2F7cQPfUHgCfBGmSgw52q2Q48ZpqDKaDyJfemkG2OKSZJkw9psjhjOeoSI3GBsLGUMxSqWIOJgaw4/tUlmW78ZeFj7PC35GpDzsCFm53UlPPP6TSUUpYuZ2tVEVG+1iKyitjIp+99Arj/N9JxYWU2KwFlUST4q/GTV1AAniby1e/I1OjQNaFdiel3+PYT4yy5IpjKpOmIQXu/osB80M2KRH5MI6uq8haYu1O/x7JHSdbk3PrnYBUzhrdBRBWK5jJpm/547MeBAhX0D6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I8iQrbrqSl1RYjfsE9QJ82kawLOKqmOgbCN+VsRIqfQ=;
 b=jbd+4LYS7FCSxxM5ga1AHD/e/XUY6+x/WFictBH6tFBv55cfq7K5ED0Pb7kdVid/vDn46Aj+92lKwsrwb4ZCu4sbJzjMaexlDmDZv8pWaz8P6On5wXba1nU4YUny76b1sPRIA0DSW8NN0X9kS5Y7rXszwNfTOg6044kwL6moxUqXqfy8XjYwjvh5U1SMAEk7WshwBinh2wXfuKDeQd47LXGdI9JRMilbnGze4Jmpmoc0QxkM7AEvOjWM/NoBv/JpTqLz7MNOaKAq/YFtN1rg6qZthnNZaYhvz3Fet76L25F6IZaKyNhMSbonsOVFWfZlzznh4qncjwl9QrKG0doU1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I8iQrbrqSl1RYjfsE9QJ82kawLOKqmOgbCN+VsRIqfQ=;
 b=xZDJalP32Asw7DDNUhhenVXr/SITlmZtiOQ9LgQyLMDJG1oFSyMkSYuXPTfTvZSZrt0SdEZBb5EGrjQsvVHvnbsBNIwPukhJmxMAbkJcXPN6VEWWwPHNjvA/NTWUgEoZoLhQKGqeIvXnf3wEq1Vpvhgf351L/iBniR62PqY+18Y=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by BYAPR10MB3189.namprd10.prod.outlook.com (2603:10b6:a03:14c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.22; Sat, 9 Oct
 2021 17:33:18 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::f4fe:5b4:6bd9:4c5b]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::f4fe:5b4:6bd9:4c5b%6]) with mapi id 15.20.4587.024; Sat, 9 Oct 2021
 17:33:18 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Scott Mayhew <smayhew@redhat.com>
CC:     Neil Brown <neilb@suse.de>, Bruce Fields <bfields@fieldses.org>,
        Timothy Pearson <tpearson@raptorengineering.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Trond Myklebust <trondmy@gmail.com>
Subject: Re: CPU stall, eventual host hang with BTRFS + NFS under heavy load
Thread-Topic: CPU stall, eventual host hang with BTRFS + NFS under heavy load
Thread-Index: xSdTgH983VDBQkCAmg52fDts9flGRuDSBNJBgAFhrIA=
Date:   Sat, 9 Oct 2021 17:33:18 +0000
Message-ID: <589AFA4F-DF8E-45A3-8299-54E820E33169@oracle.com>
References: <281642234.3818.1625478269194.JavaMail.zimbra@raptorengineeringinc.com>
 <162855621114.22632.14151019687856585770@noble.neil.brown.name>
 <20210812144428.GA9536@fieldses.org>
 <162880418532.15074.7140645794203395299@noble.neil.brown.name>
 <YWCpnsdVqssFaLrf@aion.usersys.redhat.com>
In-Reply-To: <YWCpnsdVqssFaLrf@aion.usersys.redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=oracle.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b22fda8a-8596-467d-5339-08d98b4ae1dc
x-ms-traffictypediagnostic: BYAPR10MB3189:
x-microsoft-antispam-prvs: <BYAPR10MB31899D23A79EBDFE33D93F1A93B39@BYAPR10MB3189.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JK0zZ9bwYsUDtRXaVzt+KZjI+eZxhoH+EnqJj35XvJKK96kBcTe3bKDWotejsF9IwsqidCkhpc25ItoT9yyH/Cnlq1vSKJjkZJAGVPGRYY2zFrfjcnoKaE3clEAKGQ28lsO6eGG+PSU8E5JC1RPnk3Q/IC5cqBt98dbKO6KVTSjQKEaX///psCzbcPnxJWpZNJ3DJVXsY6YC0vFEEECUX288GeqmmaeDTrdAj4GuEDefY6QcT6k4zD0ZY9xCKRamJn/I8YiyGRdKnbJuknSSgDs8RlIEbBFC5QAryaN+AsoXV+aGQdkuqyDSDb6/wDWYdzCpAa8DgcSz2RFMVlurtTySyIZLe4gOFkAyIzthi7uKCkE1d7Dyr5mkl8A1zTsAZQQmvfz6YCx6zsiirZNiU+1Q5tyLDh/dD1Yk+LqVbMUy7e8dU+CWL7KFuTNS49yugFmfip2v9PACrQ0Bd8Sf+nEkOBcrT+J8A6BSVke8oaHvKdaVXmDHfVX0akreQYd3BPLHYKCMiIIg+F5rNwGRAfGF+LhlEfImU9sinYQOOJPtd2thkEYmAUk1NNcCV1D7P9Xc6+119JKnhd1V7V9rh1Nz6Rj4pit6VFTJt16JLf0I8+dmpJogheBO6PPzll1cf03y7L0JXzlhPhspT0K6VecYwproW+WhJENCV4u5ycp51a4Tk4vot1Dr1z6NqGjy7HBESe03bU2y7oCZOhKoq4lxBBCQOSCHmPhjp6efVfHw1prCWnQFyGSVDbS5Fsvp
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(66476007)(5660300002)(71200400001)(33656002)(66946007)(4326008)(8676002)(66556008)(66446008)(64756008)(6486002)(8936002)(186003)(316002)(36756003)(45080400002)(53546011)(26005)(86362001)(2906002)(6916009)(83380400001)(6506007)(2616005)(6512007)(76116006)(91956017)(38070700005)(54906003)(122000001)(508600001)(38100700002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?YnPLlsAR+OvWQnsT194aUA+1xIL65xy0HxdIlUry/ajCEbddDMGIKS7vuvkJ?=
 =?us-ascii?Q?W/NrvsU2NfZD69aknPJUo2N64A5FwclcgLn6Cnld0hV0+CaAi+NdEBMW6GkA?=
 =?us-ascii?Q?94OG2BnVdErL8fA1f7otMzNEDqsXH6udf86XGLJ7SmwtELytr2NhzmeoShfF?=
 =?us-ascii?Q?HES5AGP9PgUl+NWy8dVkTMK9NeTsBgVrquYU9HJZ9AspZCieE3LrFb48ZKiP?=
 =?us-ascii?Q?pd29VloDplGx2qFj3LWtkrJMS5rtW0Dbq+FjHMctlWq9lvLHeofKHoLBGSkw?=
 =?us-ascii?Q?b9LXsrW4FmNLHChgg3Wxlvs9tiusZEGXF+FlHijxg00si8RhWUS1kpVC7sOa?=
 =?us-ascii?Q?HW/ID7x9qmYg1DdV4n4IiuvuuhZFyM4xhRuD9Wz1km7mhcUDI1x/jEkLZApe?=
 =?us-ascii?Q?IokdfwgwR77fjMxVSPZNyr3h5F8UHQbI4JGeuaEhPpCdym4NmA3qnSuAPvv2?=
 =?us-ascii?Q?okBX3rwMm25cZ60kx3E74ULrWC39lo33MnpS2CraQSdwLB4qqYGhRneUGWfB?=
 =?us-ascii?Q?FG7CsqERQcR2GeXUNctyFpFvSy0NdYl7nfioSZ6RfeTVma5CIW7RzABn9Vmm?=
 =?us-ascii?Q?oLalJG4bK2PvyZKZIuEg/JNIsr40X7oAp1ulg9BFMoaORJ7aV0j25QqOaWmv?=
 =?us-ascii?Q?s/qdoEdQf13jNF/yewzLkDH5mXV6wz4jvyaWWZYoSuR3e7BVws6fjen+VgBf?=
 =?us-ascii?Q?snpBHo9TS7RfuiTBkqIP+owMSZq9pLiP5CHvfW1+gduPKsGjPLV6+Ysmgeqf?=
 =?us-ascii?Q?evVCFgZJa5rcFp6XcNOelIasrUldhKOEvG4JjuxIOlsuYHmXuRs5IFQgXqKr?=
 =?us-ascii?Q?DaFB8G3NpKVhRyq8M46Ec71KNYjF66TFD6JMZXQ+db9TDrNbETZWv7dVw8sT?=
 =?us-ascii?Q?sSjK620XhHlYEdAV7ULCEadOerxTRxOgLgUg9AkHKNuhhvwJCduyTJwN0ws0?=
 =?us-ascii?Q?+FjMwHLYJbalyWi0fS8BfS71X1v2xZyBP/Qr/RsIcmUST/jqGlE5eu/u6d+q?=
 =?us-ascii?Q?BiApdbsme/OijQ2fXqdluM729aVtCZGS8AUrkXr/btr1oLEz61UIUtCyzptU?=
 =?us-ascii?Q?qk791Kwuivgnv8wWxK+DshDcOeJhljI87H/bxnSXazuj2YOoas6dgJBWL38o?=
 =?us-ascii?Q?vVWCEso+QvAeNgASz2k25zzzufYXoWkllJkft39AYiDemo6nfQDUdzuzFhLX?=
 =?us-ascii?Q?/2Y7On3mkT6Ts+NvW7ujQcXiOCuD/1QM7LMLwyHX46u3rUzfONv4zmc7LFq+?=
 =?us-ascii?Q?Mv1Av+PH8oEZbzGI/4zHepKbro5ehG45y3im7F0U60jEe8hhEPYsabpg84Cs?=
 =?us-ascii?Q?wwxghPTVYhe7JMuzv1NSCzeq?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <23D20965FCAE854990E5C92B8704E12C@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b22fda8a-8596-467d-5339-08d98b4ae1dc
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2021 17:33:18.2062
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QsQSD4XXDuGG/TeuifaHJgt2W53hMRZtmXPdV9Ceod5OYLzoPlX7r0Hv+oJ8t8O8knAH2bkrD8+fVkbose5pcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3189
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10132 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0 bulkscore=0
 mlxlogscore=999 adultscore=0 suspectscore=0 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2110090126
X-Proofpoint-ORIG-GUID: lM86d20NllwjmJ0ed2357K3f6mAoIMIk
X-Proofpoint-GUID: lM86d20NllwjmJ0ed2357K3f6mAoIMIk
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Oct 8, 2021, at 4:27 PM, Scott Mayhew <smayhew@redhat.com> wrote:
>=20
> On Fri, 13 Aug 2021, NeilBrown wrote:
>=20
>> On Fri, 13 Aug 2021, J.  Bruce Fields wrote:
>>> On Tue, Aug 10, 2021 at 10:43:31AM +1000, NeilBrown wrote:
>>>>=20
>>>> The problem here appears to be that a signalled task is being retried
>>>> without clearing the SIGNALLED flag.  That is causing the infinite loo=
p
>>>> and the soft lockup.
>>>>=20
>>>> This bug appears to have been introduced in Linux 5.2 by
>>>> Commit: ae67bd3821bb ("SUNRPC: Fix up task signalling")
>>>=20
>>> I wonder how we arrived here.  Does it require that an rpc task returns
>>> from one of those rpc_delay() calls just as rpc_shutdown_client() is
>>> signalling it?  That's the only way async tasks get signalled, I think.
>>=20
>> I don't think "just as" is needed.
>> I think it could only happen if rpc_shutdown_client() were called when
>> there were active tasks - presumably from nfsd4_process_cb_update(), but
>> I don't know the callback code well.
>> If any of those active tasks has a ->done handler which might try to
>> reschedule the task when tk_status =3D=3D -ERESTARTSYS, then you get int=
o
>> the infinite loop.
>=20
> This thread seems to have fizzled out, but I'm pretty sure I hit this
> during the Virtual Bakeathon yesterday.  My server was unresponsive but
> I eventually managed to get a vmcore.
>=20
> [182411.119788] receive_cb_reply: Got unrecognized reply: calldir 0x1 xpt=
_bc_xprt 00000000f2f40905 xid 5d83adfb
> [182437.775113] watchdog: BUG: soft lockup - CPU#1 stuck for 26s! [kworke=
r/u4:1:216458]
> [182437.775633] Modules linked in: nfs_layout_flexfiles nfsv3 nfs_layout_=
nfsv41_files bluetooth ecdh_generic ecc rpcsec_gss_krb5 nfsv4 dns_resolver =
nfs fscache netfs rpcrdma rdma_cm iw_cm ib_cm ib_core tun rfkill nft_fib_in=
et nft_fib_ipv4 nft_fib_ipv6 nft_fib isofs cdrom nft_reject_inet nf_reject_=
ipv4 nf_reject_ipv6 nft_reject nft_ct nft_chain_nat nf_nat nf_conntrack nf_=
defrag_ipv6 nf_defrag_ipv4 ip_set nf_tables nfnetlink xfs intel_rapl_msr in=
tel_rapl_common libcrc32c kvm_intel qxl kvm drm_ttm_helper ttm drm_kms_help=
er syscopyarea sysfillrect sysimgblt fb_sys_fops irqbypass cec joydev virti=
o_balloon pcspkr i2c_piix4 nfsd auth_rpcgss nfs_acl lockd grace sunrpc drm =
fuse ext4 mbcache jbd2 ata_generic crct10dif_pclmul crc32_pclmul crc32c_int=
el ghash_clmulni_intel virtio_net serio_raw ata_piix net_failover libata vi=
rtio_blk virtio_scsi failover dm_mirror dm_region_hash dm_log dm_mod
> [182437.780157] CPU: 1 PID: 216458 Comm: kworker/u4:1 Kdump: loaded Not t=
ainted 5.14.0-5.el9.x86_64 #1
> [182437.780894] Hardware name: DigitalOcean Droplet, BIOS 20171212 12/12/=
2017
> [182437.781567] Workqueue: rpciod rpc_async_schedule [sunrpc]
> [182437.782500] RIP: 0010:try_to_grab_pending+0x12/0x160
> [182437.783104] Code: e7 e8 72 f3 ff ff e9 6e ff ff ff 48 89 df e8 65 f3 =
ff ff eb b7 0f 1f 00 0f 1f 44 00 00 41 55 41 54 55 48 89 d5 53 48 89 fb 9c =
<58> fa 48 89 02 40 84 f6 0f 85 92 00 00 00 f0 48 0f ba 2b 00 72 09
> [182437.784261] RSP: 0018:ffffb5b24066fd30 EFLAGS: 00000246
> [182437.785052] RAX: 0000000000000000 RBX: ffffffffc05e0768 RCX: 00000000=
000007d0
> [182437.785760] RDX: ffffb5b24066fd60 RSI: 0000000000000001 RDI: ffffffff=
c05e0768
> [182437.786399] RBP: ffffb5b24066fd60 R08: ffffffffc05e0708 R09: ffffffff=
c05e0708
> [182437.787010] R10: 0000000000000003 R11: 0000000000000003 R12: ffffffff=
c05e0768
> [182437.787621] R13: ffff9daa40312400 R14: 00000000000007d0 R15: 00000000=
00000000
> [182437.788235] FS:  0000000000000000(0000) GS:ffff9daa5bd00000(0000) knl=
GS:0000000000000000
> [182437.788859] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [182437.789483] CR2: 00007f8f73d5d828 CR3: 000000008a010003 CR4: 00000000=
001706e0
> [182437.790188] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 00000000=
00000000
> [182437.790831] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 00000000=
00000400
> [182437.791522] Call Trace:
> [182437.792183]  mod_delayed_work_on+0x3c/0x90
> [182437.792866]  __rpc_sleep_on_priority_timeout+0x107/0x110 [sunrpc]
> [182437.793553]  rpc_delay+0x56/0x90 [sunrpc]
> [182437.794236]  nfsd4_cb_sequence_done+0x202/0x290 [nfsd]
> [182437.794910]  nfsd4_cb_done+0x18/0xf0 [nfsd]
> [182437.795974]  rpc_exit_task+0x58/0x100 [sunrpc]
> [182437.796955]  ? rpc_do_put_task+0x60/0x60 [sunrpc]
> [182437.797645]  __rpc_execute+0x5e/0x250 [sunrpc]
> [182437.798375]  rpc_async_schedule+0x29/0x40 [sunrpc]
> [182437.799043]  process_one_work+0x1e6/0x380
> [182437.799703]  worker_thread+0x53/0x3d0
> [182437.800393]  ? process_one_work+0x380/0x380
> [182437.801029]  kthread+0x10f/0x130
> [182437.801686]  ? set_kthread_struct+0x40/0x40
> [182437.802333]  ret_from_fork+0x22/0x30
>=20
> The process causing the soft lockup warnings:
>=20
> crash> set 216458
>    PID: 216458
> COMMAND: "kworker/u4:1"
>   TASK: ffff9da94281e200  [THREAD_INFO: ffff9da94281e200]
>    CPU: 0
>  STATE: TASK_RUNNING (ACTIVE)
> crash> bt
> PID: 216458  TASK: ffff9da94281e200  CPU: 0   COMMAND: "kworker/u4:1"
> #0 [fffffe000000be50] crash_nmi_callback at ffffffffb3055c31
> #1 [fffffe000000be58] nmi_handle at ffffffffb30268f8
> #2 [fffffe000000bea0] default_do_nmi at ffffffffb3a36d42
> #3 [fffffe000000bec8] exc_nmi at ffffffffb3a36f49
> #4 [fffffe000000bef0] end_repeat_nmi at ffffffffb3c013cb
>    [exception RIP: add_timer]
>    RIP: ffffffffb317c230  RSP: ffffb5b24066fd58  RFLAGS: 00000046
>    RAX: 000000010b3585fc  RBX: 0000000000000000  RCX: 00000000000007d0
>    RDX: ffffffffc05e0768  RSI: ffff9daa40312400  RDI: ffffffffc05e0788
>    RBP: 0000000000002000   R8: ffffffffc05e0770   R9: ffffffffc05e0788
>    R10: 0000000000000003  R11: 0000000000000003  R12: ffffffffc05e0768
>    R13: ffff9daa40312400  R14: 00000000000007d0  R15: 0000000000000000
>    ORIG_RAX: ffffffffffffffff  CS: 0010  SS: 0018
> --- <NMI exception stack> ---
> #5 [ffffb5b24066fd58] add_timer at ffffffffb317c230
> #6 [ffffb5b24066fd58] mod_delayed_work_on at ffffffffb3103247
> #7 [ffffb5b24066fd98] __rpc_sleep_on_priority_timeout at ffffffffc0580547=
 [sunrpc]
> #8 [ffffb5b24066fdc8] rpc_delay at ffffffffc0589ed6 [sunrpc]
> #9 [ffffb5b24066fde8] nfsd4_cb_sequence_done at ffffffffc06731b2 [nfsd]
> #10 [ffffb5b24066fe10] nfsd4_cb_done at ffffffffc0673258 [nfsd]
> #11 [ffffb5b24066fe30] rpc_exit_task at ffffffffc05800a8 [sunrpc]
> #12 [ffffb5b24066fe40] __rpc_execute at ffffffffc0589fee [sunrpc]
> #13 [ffffb5b24066fe70] rpc_async_schedule at ffffffffc058a209 [sunrpc]
> #14 [ffffb5b24066fe88] process_one_work at ffffffffb31026c6
> #15 [ffffb5b24066fed0] worker_thread at ffffffffb31028b3
> #16 [ffffb5b24066ff10] kthread at ffffffffb310960f
> #17 [ffffb5b24066ff50] ret_from_fork at ffffffffb30034f2
>=20
> Looking at the rpc_task being executed:
>=20
> crash> rpc_task.tk_status,tk_callback,tk_action,tk_runstate,tk_client,tk_=
flags ffff9da94120bd00
>  tk_status =3D 0x0
>  tk_callback =3D 0xffffffffc057bc60 <__rpc_atrun>
>  tk_action =3D 0xffffffffc0571f20 <call_start>
>  tk_runstate =3D 0x47
>  tk_client =3D 0xffff9da958909c00
>  tk_flags =3D 0x2281
>=20
> tk_runstate has the following flags set: RPC_TASK_SIGNALLED, RPC_TASK_ACT=
IVE,
> RPC_TASK_QUEUED, and RPC_TASK_RUNNING.
>=20
> tk_flags is RPC_TASK_NOCONNECT|RPC_TASK_SOFT|RPC_TASK_DYNAMIC|RPC_TASK_AS=
YNC.
>=20
> There's another kworker thread calling rpc_shutdown_client() via
> nfsd4_process_cb_update():
>=20
> crash> bt 0x342a3
> PID: 213667  TASK: ffff9daa4fde9880  CPU: 1   COMMAND: "kworker/u4:4"
> #0 [ffffb5b24077bbe0] __schedule at ffffffffb3a40ec6
> #1 [ffffb5b24077bc60] schedule at ffffffffb3a4124c
> #2 [ffffb5b24077bc78] schedule_timeout at ffffffffb3a45058
> #3 [ffffb5b24077bcd0] rpc_shutdown_client at ffffffffc056fbb3 [sunrpc]
> #4 [ffffb5b24077bd20] nfsd4_process_cb_update at ffffffffc0672c6c [nfsd]
> #5 [ffffb5b24077be68] nfsd4_run_cb_work at ffffffffc0672f0f [nfsd]
> #6 [ffffb5b24077be88] process_one_work at ffffffffb31026c6
> #7 [ffffb5b24077bed0] worker_thread at ffffffffb31028b3
> #8 [ffffb5b24077bf10] kthread at ffffffffb310960f
> #9 [ffffb5b24077bf50] ret_from_fork at ffffffffb30034f2
>=20
> The rpc_clnt being shut down is:
>=20
> crash> nfs4_client.cl_cb_client ffff9daa454db808
>  cl_cb_client =3D 0xffff9da958909c00
>=20
> Which is the same as the tk_client for the rpc_task being executed by the
> thread triggering the soft lockup warnings.

I've seen a similar issue before.

There is a race between shutting down the client (which kills
running RPC tasks) and some process starting another RPC task
under this client.

For example, killing the last RPC task when there is a GSS
context results in a GSS_CTX_DESTROY request being started
on the same rpc_clnt, and that can deadlock.

I'm not sure quite why this would happen in the backchannel,
but its possible the nfsd_cb logic is kicking off another
CB operation (like a probe) subsequent to shutting down the
rpc_clnt that is associated with the backchannel.


> -Scott
>=20
>>=20
>>>=20
>>>> Prior to this commit a flag RPC_TASK_KILLED was used, and it gets
>>>> cleared by rpc_reset_task_statistics() (called from rpc_exit_task()).
>>>> After this commit a new flag RPC_TASK_SIGNALLED is used, and it is nev=
er
>>>> cleared.
>>>>=20
>>>> A fix might be to clear RPC_TASK_SIGNALLED in
>>>> rpc_reset_task_statistics(), but I'll leave that decision to someone
>>>> else.
>>>=20
>>> Might be worth testing with that change just to verify that this is
>>> what's happening.
>>>=20
>>> diff --git a/net/sunrpc/sched.c b/net/sunrpc/sched.c
>>> index c045f63d11fa..caa931888747 100644
>>> --- a/net/sunrpc/sched.c
>>> +++ b/net/sunrpc/sched.c
>>> @@ -813,7 +813,8 @@ static void
>>> rpc_reset_task_statistics(struct rpc_task *task)
>>> {
>>> 	task->tk_timeouts =3D 0;
>>> -	task->tk_flags &=3D ~(RPC_CALL_MAJORSEEN|RPC_TASK_SENT);
>>> +	task->tk_flags &=3D ~(RPC_CALL_MAJORSEEN|RPC_TASK_SIGNALLED|
>>> +							RPC_TASK_SENT);
>>=20
>> NONONONONO.
>> RPC_TASK_SIGNALLED is a flag in tk_runstate.
>> So you need
>> 	clear_bit(RPC_TASK_SIGNALLED, &task->tk_runstate);
>>=20
>> NeilBrown
>>=20
>=20

--
Chuck Lever



