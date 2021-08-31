Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEFE63FCA52
	for <lists+linux-nfs@lfdr.de>; Tue, 31 Aug 2021 16:47:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237410AbhHaOr4 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 31 Aug 2021 10:47:56 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:24702 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232214AbhHaOrz (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 31 Aug 2021 10:47:55 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 17VDEilQ009244;
        Tue, 31 Aug 2021 14:46:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : content-id :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=ENEi2bptYZk83BORNy7nbYN0MYRq17juBwtbYdWQEa8=;
 b=aWDiy5kOdk4Pu0/O3ygFUjFGXDAHmdEvBVEk6SqZEejgab+WlirCNNVHjX3USjEcavqh
 cAwM04DCWyp6M9czQKH1Lx3Fuicr1V5q3zm1kYON8vY8xmhrZqun1vj06ZQ8b3rW6JFp
 W8gR5Qh8UZvPVGYbRPv1wL9aQfKG7A+D1mByH2kfOfTakImacO0F1YZNeEmW7pt/oCLt
 1jDjoNSGw3UgmMwz2EQGxJsdhiyiSv47Q9AzAapD6Y8060986oFh9bZk4QJSy104ZNJR
 CEKVCDHiWZ5abmLo2MjNap9zfjw7ZuNEinfqRaHCwx9Mq82hYZ5aIsd7Q0k2sQiRJnLs SQ== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : content-id :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=ENEi2bptYZk83BORNy7nbYN0MYRq17juBwtbYdWQEa8=;
 b=jyMlqq25bDsV1UGgjDH3rrebG+xO4aLSRp12TXRLxCHVosI5WkBEs9s6rdsvJkSe8ztK
 /3ivXC6aGUi42/pkKM4Z4UIGfal0ppMw9YJasZz2jHNrLfsXkp4f6yjOW/E86uOxoHdg
 FEPxZKtAjNd0yEPoSqkMKnF4+/tosA2ZhbVJ2jMF5QDkyvlStu2lGYTaJULCb4Y09b/1
 Rv6zK2daW/RmOWxZrK5Q65qIh56q+4xTZXVZIthvnaeTyr+FqMeGTB5LBJY63bisHp92
 zAwGPhJAQ9i6grdlxquuCRkOIl/mDsoLcgQcKZXYBB/WhFuGyDYSBGp5Sn1CAPJrFR/x wQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3asf2mh790-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 31 Aug 2021 14:46:42 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17VEfor8054025;
        Tue, 31 Aug 2021 14:46:41 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2173.outbound.protection.outlook.com [104.47.56.173])
        by userp3020.oracle.com with ESMTP id 3aqxwtn70m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 31 Aug 2021 14:46:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hb5EdRhKXQ9p3rd2mdl2Qi8NoHjmGt0auT9y7/q5TeqxtsCmFRNqTDXhCFfdZtUOO4V7TjJJ02NpBYSqSF0g+hzL/SEiTPJ5L5nMlhsO4QJ7MX14Hn/Ycb3JnNzx15KHgxbLi1H1sBd9SA/bCBoYubT0UzrkxODc+ilpHv0xZhVrC5ORC/mclzWWqqC5TZTdMnNAnKBXKQrJx4W6Dsi9R2wTYFDHcd5c4TwilQNAF8tNYMe1ol2dm74j4pXZ+D7RExaNTI228fXul5IoDDDRxXgOLO4eNLGr3QnGmO4qUi43R+iKGaaTIbQM0NOg3hBFdaxGnlSsfHflpXVR15rziA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ENEi2bptYZk83BORNy7nbYN0MYRq17juBwtbYdWQEa8=;
 b=Q4vLP/ooRvmmxbhQHEtzaZrlU5yLzp3ZbFJVAaLje3nyxFl+PgFH/kuORdyl7EmhZcDi87fbZSqGcu2m/f2eofgg+Pw2EobYBoAaDyT9inyhwFMigxWLi0TFJCfQHxJ2J2cUGSkzVm2hdSCzZxNagAswWxwnK2i/ti8c30/gfklnilsTgAolGjPS3uXdHSn5ZXuN/E1+QUWxhJGj27GNtm/x4C6cIGtfA7Kwn9Kkd8VO5kLFoyE9DH/QTKBDcg91zEh3+3bXnJrV+Aeg7V0mSwrUsQqIrZibISfs2ukubTC32/b9pKu7N+isRZzTSRhlF4utGJewsbajHu1qiQZX1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ENEi2bptYZk83BORNy7nbYN0MYRq17juBwtbYdWQEa8=;
 b=M9dV3w/x6/3UVJSnksSbVddXwJzl4oEYxaEkXeRNYAqyxg26siZK9nVjK1nOs2UiZujo8/UID7XLrYoQtT7Fcm+OmhbLr2UTgOyxqSOn3rqQGaAIxGFQgRzCUmSrgcKv5Eaja6VxchP6xMf29jS05Ei6XMmLCxOzHWYjWwk/WRA=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by BYAPR10MB3461.namprd10.prod.outlook.com (2603:10b6:a03:11e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.24; Tue, 31 Aug
 2021 14:46:38 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::f4fe:5b4:6bd9:4c5b]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::f4fe:5b4:6bd9:4c5b%7]) with mapi id 15.20.4478.017; Tue, 31 Aug 2021
 14:46:38 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Bruce Fields <bfields@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [GIT PULL] nfsd changes for 5.15
Thread-Topic: [GIT PULL] nfsd changes for 5.15
Thread-Index: AQHXnncBxE0Ae4VkzkOpKNPMIV4sAA==
Date:   Tue, 31 Aug 2021 14:46:38 +0000
Message-ID: <A5435167-2468-4F7B-8084-F542F8C1A838@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linux-foundation.org; dkim=none (message not signed)
 header.d=none;linux-foundation.org; dmarc=none action=none
 header.from=oracle.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 43dfbcdc-fd04-42a0-f507-08d96c8e2395
x-ms-traffictypediagnostic: BYAPR10MB3461:
x-microsoft-antispam-prvs: <BYAPR10MB3461C99B9848BA9CAA3A0E9D93CC9@BYAPR10MB3461.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1284;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Zgx+2vnRJPg6VRG0D93acQ18tsai4HylM9brpBrl/CYZEKISQGUJjh4XdEXE4LSS3SPqyQ8SF3il2vIS/7vodBmYdbxVil/x7ofm5lnqgBxhDPavpM4cxU2FzrQeESDjFzd4tn9mY4OaF5RHyOM9CIffCF3JY7TDBa63qX1tICOWnr58YkC2ZihKtI65+0rTpNyoi4ddjDRGU68KKA4qUvUb+qsk29L1BLPRNkw5srM35fzj0o/RMmXy7MNs6y3sOE8jU+eK7j0FcDxFAl2fhxPx1xGzht/s5b7G2xOAa2qyIlDOiuBK7f9eEcLbMOeHL+hOdwJth7y2m8szQBg7LJxdbGRa1UDVA5fDm6aMubAPlJ7FUHlwPnfV4GxOct9L/TfDsnPTeG9DK5zDLRqljvbE5EV8wdIC81qzvUKTx7If3OEyzpKzI3i07SljAV9A0Q5l5w1wO9lVeaqxbi1tvRLGbOiuOIpvQF7F3J7VTkfC1V9Tqi9lVocyxRU7bC2ZxlB5Wp1bMtHguqdl+F8G/17ZRuEXhPA1DFLiQEnqKDFTbZDEOBLgascBdkTb6X3yb9VAeC8FYTKH96w+oPg4153DwIyK8gbB6B8r2AeAkP2UYor3+RgG2nCtLNiZKun7YgimxWjjRdBr4Pz4iwobKMgPBlV7Vs8iWhfddmxHxrTkHtWKmkqv2vF+aOYZjANMQY0iIpeWotYLuvKXlO/dFgjP93ElTGICiHUdmyIPEvPOm5fS+U4sLV2zuPvzRixvlr/o5+IHa2U1Po9J22nltNeI8ewmD/NjiUAE9D01m7+WDqYg2BXPquhD5LPviZjNjWlPHIaORraJSxXTZYYM+0pk6LKEGyiMTbuFDB7K39w=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(396003)(376002)(39860400002)(136003)(366004)(2906002)(83380400001)(36756003)(966005)(478600001)(54906003)(6512007)(8936002)(6486002)(66446008)(64756008)(186003)(4326008)(66556008)(26005)(71200400001)(66476007)(86362001)(8676002)(5660300002)(91956017)(66946007)(6916009)(33656002)(122000001)(76116006)(6506007)(38100700002)(2616005)(316002)(38070700005)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?sN5MdW52dl5ZbbvGISHjEPk2Nws8wi9eoWV+NpJ8B3xxlTRH3Xo15nbGeACp?=
 =?us-ascii?Q?VWG23f3Vy5DOxVC2PQGvw99oT/+F2jO1xNgPpuhBT1Rtfxh/yy4NvCJRmZGG?=
 =?us-ascii?Q?kd9dFkyRaiQdfTjOu62q3RCKsf1a7CPNAa4UCIipY7y7JHe1f/T/mkbGO+/q?=
 =?us-ascii?Q?+Fw3co4VV7/RPTax7nqRdcavR6nYJBDGU+3zTTu6PvdHfkQkvi1D3NXahrzp?=
 =?us-ascii?Q?vLtu3TWHXScmGjRl3cnloaKHioSwfQsKYfCybQDNZj1N6RUbmi+vOKpjjH6H?=
 =?us-ascii?Q?sa1df6SxOgW3wmwl1VioM2Zsu9HTi9/A/ZZ/v1NxR/e4QIT6ILsbNZrtPayb?=
 =?us-ascii?Q?QXWIPnbXGtXvnYVXmCVKPag2P3EEsCfsXtJ+pX1A3Qcg4Jjsc1jEOpEUKL4n?=
 =?us-ascii?Q?dwiRKUwdx/ayi7vRmQpTy7owvkYZiNnVRb2vcCW0By09RSX42Zv4bz3MtNBR?=
 =?us-ascii?Q?ZhBKLMCUYN35Dd13x7T73kwJ1sML0C0NesUkh4a7Qvxnt1N2sHJTiYC5aOLm?=
 =?us-ascii?Q?HQud1m5zf7k12tJlyd9ZSQHdLn/F2FEb6XblVAyn7iM+rfeN6pXITdxGCCBS?=
 =?us-ascii?Q?4AkbUtcFbVhlOq2Vrgz7WzlT0xTKD4z+yVEAZRMBRQoa58C1plYUlChvFLvc?=
 =?us-ascii?Q?nfbJWcj40+SjpLIB2Lf0YORE8opKyD8Uw2Q0tpQLM3i7EWMhEJ60vzRDcgOv?=
 =?us-ascii?Q?DZ2IfR8oYLijkD43Rs43yekHf/zn+GzvfdXbYdOgVoSLtp3k/2+K585FAI8u?=
 =?us-ascii?Q?0hkbFc6VuIrmOd2QBxYQ7u/ALR7NbwfuOkaJQvfuDxAk1fkpbDlIpwftO5TG?=
 =?us-ascii?Q?btBtL4XJq+RSVUgw908dw56YcjHFI2u0WxjJLewVMIZZgkaAdYS2MB6gowIa?=
 =?us-ascii?Q?gHoRck5mxVIG8zb8vrAHi2WUn7LCpAGWdU2w9HlTTABIGyNJxAvAv/BaWxSZ?=
 =?us-ascii?Q?/1bOV9wUbGm2JbbaW8xwIOJ5t4gxWYddZwjjKGAivQSBThMaVbZMGyLNB7pw?=
 =?us-ascii?Q?fN9LA7EFiAYLiJbCT4su/TVuSVi/6OSdxybnhdy6off8tGqnW1nkp1TTwrKT?=
 =?us-ascii?Q?e/0EN6VmI1Ak0nxLSFn+mdkzrU42ZkXpEi2jaEMlma5Mt2uilKYPjfN0tEQh?=
 =?us-ascii?Q?1w525ZYYAvmrIel6V70/y7durqg5kgNu+uqaaBqAuqrJ0WXFW7SYWE4DxJnQ?=
 =?us-ascii?Q?xsoUJbkhZfZgpihHPE5CWaHCh6xPWMUNBH7MgOkdwSnt46jODcmPlwHd2aPO?=
 =?us-ascii?Q?hBImpd0quGpf8gR4n0wwy5NILeLTPdwDLSIG2ag0vAyYPZ17ft2R8p+o9lr8?=
 =?us-ascii?Q?FzmnwC25xMVBzfhZdzF1igMu?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C4140EE128077C449A06E02957E29421@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43dfbcdc-fd04-42a0-f507-08d96c8e2395
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Aug 2021 14:46:38.6756
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /pOaG+t7nEoz1nkfEgCYj7ac3zVGCWemGYAwAwxhchrk0LG2iUSLk6qtmWtHzi0x/MPmF2M0IweglAJjEbywZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3461
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10093 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=635 mlxscore=0
 malwarescore=0 suspectscore=0 spamscore=0 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108310080
X-Proofpoint-GUID: rAKLDgSuG2BAAqur5bo-lHDolxWP_a-x
X-Proofpoint-ORIG-GUID: rAKLDgSuG2BAAqur5bo-lHDolxWP_a-x
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Linus-

NFSD pull request follows below. First some notes:

Stephen Rothwell reports a minor merge conflict with Jeff Layton's
file-locks tree (and now your tree):

https://lore.kernel.org/lkml/20210824100737.4bd6d815@canb.auug.org.au/

The resolution Stephen provided should be adequate.


There are two v5.13 regressions we are aware of:

- "[Bug 213887] kernel v5.13 regression & NFSv4.2 client timeouts?"

  This issue appears to be addressed by recent commit 062b829c52ef
  ("SUNRPC: Fix XPT_BUSY flag leakage in svc_handle_xprt()...")

- NFS server regression in kernel 5.13 (tested w/ 5.13.9)

  A fix for this has been queued for nfsd-5.15-1. It was a bit late
  to be included in nfsd-5.15.


And there are two longstanding issues we are aware of:

- BTRFS subvolumes cannot be exported properly by NFSD

  As featured on lwn.net:

  Part I:  https://lwn.net/Articles/866582/
  Part II: https://lwn.net/Articles/866709/

  Neil Brown is working on a set of patches to address this.

- NFSv4.1+ backchannel not getting restored after PATH_DOWN

  This might be an NFS/RDMA-only problem. The reproducer is very
  rare, so it's taking a while to nail down.


 ---- cut here ----


The following changes since commit 7c60610d476766e128cc4284bb6349732cbd6606=
:

  Linux 5.14-rc6 (2021-08-15 13:40:53 -1000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-5.1=
5

for you to fetch changes up to 0bcc7ca40bd823193224e9f38bafbd8325aaf566:

  nfsd: fix crash on LOCKT on reexported NFSv3 (2021-08-26 15:32:29 -0400)

----------------------------------------------------------------
New features:
- Support for server-side disconnect injection via debugfs
- Protocol definitions for new RPC_AUTH_TLS authentication flavor

Performance improvements:
- Reduce page allocator traffic in the NFSD splice read actor
- Reduce CPU utilization in svcrdma's Send completion handler

Notable bug fixes:
- Stabilize lockd operation when re-exporting NFS mounts
- Fix the use of %.*s in NFSD tracepoints
- Fix /proc/sys/fs/nfs/nsm_use_hostnames

----------------------------------------------------------------
Benjamin Coddington (1):
      lockd: Fix invalid lockowner cast after vfs_test_lock

Chuck Lever (15):
      NFSD: Clean up splice actor
      SUNRPC: Add svc_rqst_replace_page() API
      NFSD: Batch release pages during splice read
      NFSD: Use new __string_len C macros for the nfs_dirent tracepoint
      NFSD: Use new __string_len C macros for nfsd_clid_class
      svcrdma: Fewer calls to wake_up() in Send completion handler
      svcrdma: Relieve contention on sc_send_lock.
      svcrdma: Convert rdma->sc_rw_ctxts to llist
      SUNRPC: Fix a NULL pointer deref in trace_svc_stats_latency()
      SUNRPC: Add RPC_AUTH_TLS protocol numbers
      svcrdma: xpt_bc_xprt is already clear in __svc_rdma_free()
      SUNRPC: Add a /sys/kernel/debug/fail_sunrpc/ directory
      SUNRPC: Move client-side disconnect injection
      SUNRPC: Server-side disconnect injection
      SUNRPC: Add documentation for the fail_sunrpc/ directory

J. Bruce Fields (11):
      rpc: fix gss_svc_init cleanup on failure
      nfsd4: Fix forced-expiry locking
      lockd: lockd server-side shouldn't set fl_ops
      nlm: minor nlm_lookup_file argument change
      nlm: minor refactoring
      lockd: update nlm_lookup_file reexport comment
      Keep read and write fds with each nlm_file
      nfs: don't atempt blocking locks on nfs reexports
      lockd: don't attempt blocking locks on nfs reexports
      nfs: don't allow reexport reclaims
      nfsd: fix crash on LOCKT on reexported NFSv3

Jia He (2):
      sysctl: introduce new proc handler proc_dobool
      lockd: change the proc_handler for nsm_use_hostnames

NeilBrown (1):
      NFSD: remove vanity comments

Steven Rostedt (VMware) (1):
      tracing: Add trace_event helper macros __string_len() and __assign_st=
r_len()

 Documentation/fault-injection/fault-injection.rst |  18 ++++++++++++++
 fs/lockd/svc.c                                    |   2 +-
 fs/lockd/svc4proc.c                               |   7 ++++--
 fs/lockd/svclock.c                                |  82 ++++++++++++++++++=
++++++++++++++++++--------------------------
 fs/lockd/svcproc.c                                |   6 +++--
 fs/lockd/svcsubs.c                                | 114 ++++++++++++++++++=
+++++++++++++++++++++++++++++++++++++++++---------------------------
 fs/nfs/export.c                                   |   2 +-
 fs/nfs/file.c                                     |   3 +++
 fs/nfsd/lockd.c                                   |   8 ++++--
 fs/nfsd/nfs4state.c                               |  20 ++++++++++-----
 fs/nfsd/nfsproc.c                                 |   1 +
 fs/nfsd/trace.h                                   |  17 ++++++-------
 fs/nfsd/vfs.c                                     |  21 ++++------------
 include/linux/errno.h                             |   1 +
 include/linux/exportfs.h                          |   2 ++
 include/linux/fs.h                                |   1 +
 include/linux/lockd/bind.h                        |   3 ++-
 include/linux/lockd/lockd.h                       |  11 ++++++---
 include/linux/sunrpc/msg_prot.h                   |   1 +
 include/linux/sunrpc/svc.h                        |   5 ++++
 include/linux/sunrpc/svc_rdma.h                   |   7 +++---
 include/linux/sunrpc/xdr.h                        |   1 +
 include/linux/sunrpc/xprt.h                       |  18 --------------
 include/linux/sysctl.h                            |   2 ++
 include/trace/events/sunrpc.h                     |   8 +++---
 include/trace/trace_events.h                      |  22 +++++++++++++++++
 include/uapi/linux/nfsd/nfsfh.h                   |   1 -
 kernel/sysctl.c                                   |  42 ++++++++++++++++++=
++++++++++++++
 lib/Kconfig.debug                                 |   7 ++++++
 net/sunrpc/auth_gss/svcauth_gss.c                 |   2 +-
 net/sunrpc/debugfs.c                              |  85 ++++++++++++++++++=
++--------------------------------------------
 net/sunrpc/fail.h                                 |  25 ++++++++++++++++++=
+
 net/sunrpc/svc.c                                  |  44 ++++++++++++++++++=
+++++++++++++++
 net/sunrpc/svc_xprt.c                             |   3 +++
 net/sunrpc/xprt.c                                 |  14 +++++++++++
 net/sunrpc/xprtrdma/svc_rdma_rw.c                 |  56 ++++++++++++++++++=
+++++++++---------------
 net/sunrpc/xprtrdma/svc_rdma_sendto.c             |  41 +++++++++++++++++-=
-------------
 net/sunrpc/xprtrdma/svc_rdma_transport.c          |  11 ++-------
 samples/trace_events/trace-events-sample.h        |  27 ++++++++++++++++++=
+++
 39 files changed, 495 insertions(+), 246 deletions(-)
 create mode 100644 net/sunrpc/fail.h

--
Chuck Lever



