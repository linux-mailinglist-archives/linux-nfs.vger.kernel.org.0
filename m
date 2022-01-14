Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B333948ED94
	for <lists+linux-nfs@lfdr.de>; Fri, 14 Jan 2022 16:59:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243081AbiANP7k (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 14 Jan 2022 10:59:40 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:44734 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243092AbiANP7i (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 14 Jan 2022 10:59:38 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20EF9lJq002912;
        Fri, 14 Jan 2022 15:59:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : content-id :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=gf4IyqjXJBois1jRYuGhDTCspGic5iWTeDy9VNAy2ic=;
 b=mb++e9Wr3ZPYxGplBdT1ebf/DIzeWg8G9SjvbBUlqmFs+SlJzqkVl+Jd4U6XiSHvkQ4f
 u9Dmnpa9xgQeqgfqHKKzvS13Pj7sdRsE4oMpbR8CFrC5x7r9o+9f/OdiKvbgCY3AIrFS
 f0wGLfEVpuqvNJYfS7qfj7tZimd9hsIXizfxqukJQ8gTM/9OWd9GL8PlLzK2RsC8A6fN
 sGfgyVPvjoIHnWvtYnl+ldk7libDsdkt532OXxgfBz3yCAR90jYeAkVXw6jliXvlhBfv
 i/KEpKpopOAn27ZFFWHuor5VI72Y0zu5HIRfv7zCrJw4AoOhenakTjHFeADq2YLRLP6i TA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3djggmccpt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 Jan 2022 15:59:30 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20EFobvs133203;
        Fri, 14 Jan 2022 15:59:28 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2170.outbound.protection.outlook.com [104.47.58.170])
        by aserp3030.oracle.com with ESMTP id 3dkbcs9uu7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 Jan 2022 15:59:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H8qpbE1rXSS6lZSUOKwbVpZdOuchZgfE51IdbmBshLPKNfpgfIpDxdWVRS5HqMSbE456sT/FVVnAOU37Yu/1Ce3o+J/7FLVq1TBSBvNUEFekEx7YWKYL7xIYuL5rz111TErPA/zbpcFKSfS+sHk7Axx8cYFTqPEDi3osaliOpOKbcNI26KggT1pZhGY7XlK6t0P1kCt0RHYBYqjTJu6nNU9Kfx1NN8f8d7fCEXX38RHHCnNZ3ajVb+d8hbx2WyxvE0G0vhIHZij2KFrICsI6nVLmdLiF9tLd43huomdmGspZFNtnYBbanV1oHPRFrMZxvNY5tGOskIle42xKj4j45A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gf4IyqjXJBois1jRYuGhDTCspGic5iWTeDy9VNAy2ic=;
 b=m94Xuw3HQo+lS0dqnoH3EQmjshNCUi773GiN99MqBcI8F+YWBKdu96eu396oSIa6nVp75bCYFgdrkQ2HpEojfkbfNTvIrxN8MrF7s4hEvnW17gVhObZCaUpD2hwwpcndpjKpIR5HYAcDVKSeCYgXbGlTmXu+Yv+zFYpMmFa3Tb8Kzpj8FAPlylt6d8uYrY9WZXvGo9ukzTtpIThsc9fpCxuNk3R/SE1VAg8HNzzHjiGvW94EzWpk8W7i2gORHWn07+R1jYmD/LT8ugMl8UQKg3vkYSoILovE4BXVBsXiAa1UXFsiCPwTBCSMurVkY4gPyIoetZGwixQ2HpwvezMMTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gf4IyqjXJBois1jRYuGhDTCspGic5iWTeDy9VNAy2ic=;
 b=SOa9hJn6PW3U7tn1BdcyVP+mQiasFOQgOUXK8GDiu573Yubg2/g2h84YCUHRYbQHbq7n5FUxm19K8QxmLTWkAOSWHBRwAO4ODRZJcnHwOVAaYSjMlqGmaD1qwS+jwfI0JdBx6eA2zhgAfOjpgSTex0uVFzPnF/b+AvR6D2DwZto=
Received: from CH0PR10MB4858.namprd10.prod.outlook.com (2603:10b6:610:cb::17)
 by BL0PR10MB2852.namprd10.prod.outlook.com (2603:10b6:208:76::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.9; Fri, 14 Jan
 2022 15:59:26 +0000
Received: from CH0PR10MB4858.namprd10.prod.outlook.com
 ([fe80::241e:15fa:e7d8:dea7]) by CH0PR10MB4858.namprd10.prod.outlook.com
 ([fe80::241e:15fa:e7d8:dea7%9]) with mapi id 15.20.4888.012; Fri, 14 Jan 2022
 15:59:26 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
CC:     Bruce Fields <bfields@fieldses.org>,
        Jeff Layton <jlayton@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] nfsd changes for 5.17
Thread-Topic: [GIT PULL] nfsd changes for 5.17
Thread-Index: AQHYCV+0u+sxMzv1xUCX/nGOprTZTA==
Date:   Fri, 14 Jan 2022 15:59:26 +0000
Message-ID: <6F9150E5-3591-4A8C-8776-CA34D063EB45@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: be714278-fbd1-4cee-23f2-08d9d776d74d
x-ms-traffictypediagnostic: BL0PR10MB2852:EE_
x-microsoft-antispam-prvs: <BL0PR10MB2852A7BF3F6CAC2D856226C193549@BL0PR10MB2852.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eyB8ouCZWf5X7Sfmkn8GZK3oAIaceJb8ANf63MQYZlpn8XHZcJGOSB/Bg97dIlNF6xZeOu36ZOitcnJT3YO+kxZxpYTuCRVXqXUQNUwXaegAwAcY48rY1JlIJABaj8BWvSrH1F6eb9gcYh5F5cPc9ZBfnvQBY2SO4Sle41eTI1Kvpsfly6xil2ufPPf6fxdJ8mahWGgKes2LAzOk9N7MtO12pQ9NCjyYW1jJ045ucFlM8O4fcVIQOt9sA+YPWxre0qrjvLGPdB8mfbseBQDRiX1hdQPdE9oU3p258MbAz9DC+kPjF9qjFOPFTVSaJmJ0VOmB+Mo9eMHhBxksbY8Rysany1GUFo05oImAye0A7L+iISUfG78NrmeUu+8EkmArXtWbzLlWcAYMsjhBzU/p2a0v8RslV5DlRKB7xfix13X4cjGLAcTnutEqxT/ZkUnX/1+RRVsqhSdQFGRAZtQQGbYKV7aaUb8EBBYUFT3tfW6NM+Gq9397OZoRPLw/WshmmCXF3Ei1C0QCnLqugcZ7acZ/gH+HyeRjsXgIgYgzRAj1KpfNMBvDodpftCatr4aCop/fQJR1i/LrK0y4l/dT06EMUjQNZFtaR1iwSRvFqwtjtLY+St09e5oRZA51FDJvlz7ITnqGSoNJQnfWPIQnDEr6JW5jgV5fgl7tqNdSEzcVio74dohBhFPh65J6Vmf92iobWNe3duSvwPYhDiY3V1Sd2MCyV3kK+H48tofc/gwbB5cyKYJgd7tgt+y8vMKDz3NrHfm/Iklj5fx5fiYm+2Adv2FsohKvxhQUkvO9LZYSXnk4iXfPXYphUoXSQ2MEZgg4nfM07m6Bm9Ih/zzPfA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB4858.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6512007)(71200400001)(83380400001)(4326008)(5660300002)(966005)(86362001)(8676002)(508600001)(36756003)(2616005)(316002)(66556008)(66476007)(66946007)(64756008)(6506007)(6486002)(66446008)(186003)(2906002)(26005)(4001150100001)(6916009)(54906003)(38070700005)(122000001)(8936002)(33656002)(76116006)(38100700002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?kebDbdol4cZL8nKTwzGJJq+U7m2Ajf/FYxYti8XOh4+9HCbeltBAl1W4BsSb?=
 =?us-ascii?Q?kOjV1AfOTs90XpA+560jYDouS9aBtuEonhIoqIpp+z7rOg6xSjLp3MSJe2jF?=
 =?us-ascii?Q?Ph4eN/P1HxPi+4WNpOh9Ox7iyOjTVlH7PZ+4fvIqkdMDCQ54d+7RGwfCXWAc?=
 =?us-ascii?Q?HLD50JwwDHFOGfTZNY8XVbJkULn/X0ZIiWspklSIoMxMNaCI9l/ewjRtClak?=
 =?us-ascii?Q?6cJqckJ56rmzlZMKjJM27k0rlFJK50GdUwYMxxVTrwe0WfP3AjZCMdQ0o0j7?=
 =?us-ascii?Q?OLMeGpsae3pSjXgbKB9gaI7xIlMAVwqH3F5SztuHhfRDcXIdgtAFYC9HxkP7?=
 =?us-ascii?Q?SPuCIxH/uF/tv/1lpzbjp/6oyBZiEyC5ZQkvY0vGT7UUrcXR0ruxiFuOo2mf?=
 =?us-ascii?Q?GFQwj4yKa+/P1Or33eCn0Uz11bjJ1G39wYsdjIArGuCH6hDWmq1M3MSlzwsB?=
 =?us-ascii?Q?saFK04v6ouqs1fjf2oe0+h9Xyxhkp0DXybTt96aXN5az9NyU0xpnYQZ5V06d?=
 =?us-ascii?Q?eczypnwr+XHdYpVyY3M07JzrT0pD9COMgxfB0bHvpyRJms2zOt65btUaMxTO?=
 =?us-ascii?Q?LPbbV/ANnOwSRbYJQESgxKbuYMS9pGYg4sslBQ+Cd1cXim1N6cIB+Y16zbbq?=
 =?us-ascii?Q?DW0BDq/lz3fm7gw75mPF/GF2nOHb1KkFmN9z/3g+7B/tg/VxwSJbfa3jQPwa?=
 =?us-ascii?Q?t2PhQLs0/vc4HYjh2E8deAaWsZSjPvMYomX6ivXGPhEBJi4aCAzwXhMYUhyS?=
 =?us-ascii?Q?nKhKYNtsH1l7onUq/hfaSQ5VFImWtLtdKZZj4pPBVCbGORd2l4OrdJ4U6gX3?=
 =?us-ascii?Q?Mr8apqH8evsDS4S+cucGUIj0qPrcUMDLlxZiYj9PIg6yxLB2bYLTYlKnL5eW?=
 =?us-ascii?Q?5HK/B/etmE6prFtWxKTRnQrJu4u306+u1bxEbAyvSvycDgqiUznDJztYlM1X?=
 =?us-ascii?Q?kWArlRq3x4WT+VxHrd+WOVn3WzwZv3t33E4BMPgIx837T9hSj53yZK99Glkf?=
 =?us-ascii?Q?NTEK8Rb6KXnB9caYTWjC4CoiXCc9ZggwpXP5DcFHgBhtzz1OQ+T9dW8Bfzm7?=
 =?us-ascii?Q?VRWWGvwhQNSQdXXm471Uedc6FmSynUoEHCDqfsPglG6K5NlG3DE1JNKMVpCB?=
 =?us-ascii?Q?c8l6iRSsTdOGB6BjCARau69x5FNXvg9nvVMpnmdI37aHedSOr2n/75weOQP3?=
 =?us-ascii?Q?gogEVl973uOWN/G4DMwDilHE9w41z6c6YEm5beR1oeg77hPk9c0sFQHfPtUi?=
 =?us-ascii?Q?7WCfRyLBL8dJFmQD+0PKysybyDVimKUVRB/Alak4E9RgHrLmxHSr/flSkC/h?=
 =?us-ascii?Q?hcwrWOUuoH7/HCGJy090SItnaKmuzMpwBIwhzl9gOBDlAC5XUm4DXOZK8/oW?=
 =?us-ascii?Q?Y6i5lc3Pu/rAtqv+q/iRGpZjNU3JiL6gFs0lY/LCAaxJsOQzNeMbA98nB9IG?=
 =?us-ascii?Q?7oG5MhYExM42mtU4DclIM2P5GSNut9E9FVXJlG4luZac7ip5x+jCFN4bY6K6?=
 =?us-ascii?Q?flPWqai9qbFvBHCVOscnD39PyT0zibxVzEVRHGmNqo+g6NoaRa573B0jHmrh?=
 =?us-ascii?Q?f+i8b8sEXRsl9AWO26Wf0kW6DfDjNJCUgzvZ2iPLdc99LT7rEw7MK6rzM7hO?=
 =?us-ascii?Q?LCdZzJoVcsIHrtJc+2PYIX4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <6739B9F8E0FDEC43AC7073BA64DC7B25@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB4858.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be714278-fbd1-4cee-23f2-08d9d776d74d
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jan 2022 15:59:26.7124
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PW/x/htd4j7TPDELiHn9GuVNKj+GgYaeh7xyoiMwymjYkKNEQLqZgb22fdL8HAiJhI2lSj1tIjnhrjFFyjm56A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR10MB2852
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10226 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 malwarescore=0
 mlxlogscore=999 suspectscore=0 mlxscore=0 phishscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2201140105
X-Proofpoint-GUID: AYAe_MoA90hjqlybmhoX4CGGRJrFTLb2
X-Proofpoint-ORIG-GUID: AYAe_MoA90hjqlybmhoX4CGGRJrFTLb2
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Linux-

Happy new year! First, the news:

Bruce has announced he is leaving Red Hat at the end of the month
and is stepping back from his role as NFSD co-maintainer. This pull
request includes a patch removing him from the MAINTAINERS file.

There is one patch in this PR that Jeff Layton was carrying in the
locks tree. Since he had only one for this cycle, he asked us to
send it to you via the nfsd tree.

There continues to be 0-day reports from Robert Morris @MIT. This
time we include a fix for a crash in the COPY_NOTIFY operation.


Pull request details:

A while back, Stephen Rothwell reported a minor merge conflict with
the userns tree:

https://lore.kernel.org/linux-next/20211217181325.4fa394c4@canb.auug.org.au=
/T/#u

I'm not sure exactly how this conflict is resolved with recent
linux-next trees, but the original resolution was small and correct
and no problems have been reported since then.


The following changes since commit 2585cf9dfaaddf00b069673f27bb3f8530e2039c=
:

  Linux 5.16-rc5 (2021-12-12 14:53:01 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-5.1=
7

for you to fetch changes up to 16720861675393a35974532b3c837d9fd7bfe08c:

  SUNRPC: Fix sockaddr handling in svcsock_accept_class trace points (2022-=
01-10 10:57:34 -0500)

----------------------------------------------------------------
Highlights:
- Bruce steps down as NFSD maintainer
- Prepare for dynamic nfsd thread management
- More work on supporting re-exporting NFS mounts
- One fs/locks patch on behalf of Jeff Layton

Notable bug fixes:
- Fix zero-length NFSv3 WRITEs
- Fix directory cinfo on FS's that do not support iversion
- Fix WRITE verifiers for stable writes
- Fix crash on COPY_NOTIFY with a special state ID

----------------------------------------------------------------
Arnd Bergmann (1):
      fs/locks: fix fcntl_getlk64/fcntl_setlk64 stub prototypes

Chuck Lever (18):
      NFSD: Fix sparse warning
      NFSD: Remove be32_to_cpu() from DRC hash function
      SUNRPC: Remove low signal-to-noise tracepoints
      NFSD: Combine XDR error tracepoints
      NFSD: De-duplicate nfsd4_decode_bitmap4()
      NFSD: Fix zero-length NFSv3 WRITEs
      NFSD: Fix verifier returned in stable WRITEs
      NFSD: Clean up nfsd_vfs_write()
      NFSD: De-duplicate net_generic(SVC_NET(rqstp), nfsd_net_id)
      NFSD: De-duplicate net_generic(nf->nf_net, nfsd_net_id)
      NFSD: Write verifier might go backwards
      NFSD: Clean up the nfsd_net::nfssvc_boot field
      NFSD: Rename boot verifier functions
      NFSD: Trace boot verifier resets
      Revert "nfsd: skip some unnecessary stats in the v4 case"
      NFSD: Move fill_pre_wcc() and fill_post_wcc()
      SUNRPC: Fix sockaddr handling in the svc_xprt_create_error trace poin=
t
      SUNRPC: Fix sockaddr handling in svcsock_accept_class trace points

J. Bruce Fields (4):
      nfsd: improve stateid access bitmask documentation
      nfs: block notification on fs with its own ->lock
      MAINTAINERS: remove bfields
      nfsd: fix crash on COPY_NOTIFY with special stateid

Jeff Layton (2):
      nfsd: Add errno mapping for EREMOTEIO
      nfsd: Retry once in nfsd_open on an -EOPENSTALE return

Jiapeng Chong (1):
      NFSD: Fix inconsistent indenting

NeilBrown (21):
      NFSD: handle errors better in write_ports_addfd()
      SUNRPC: change svc_get() to return the svc.
      SUNRPC/NFSD: clean up get/put functions.
      SUNRPC: stop using ->sv_nrthreads as a refcount
      nfsd: make nfsd_stats.th_cnt atomic_t
      SUNRPC: use sv_lock to protect updates to sv_nrthreads.
      NFSD: narrow nfsd_mutex protection in nfsd thread
      NFSD: Make it possible to use svc_set_num_threads_sync
      SUNRPC: discard svo_setup and rename svc_set_num_threads_sync()
      NFSD: simplify locking for network notifier.
      lockd: introduce nlmsvc_serv
      lockd: simplify management of network status notifiers
      lockd: move lockd_start_svc() call into lockd_create_svc()
      lockd: move svc_exit_thread() into the thread
      lockd: introduce lockd_put()
      lockd: rename lockd_create_svc() to lockd_get()
      SUNRPC: move the pool_map definitions (back) into svc.c
      SUNRPC: always treat sv_nrpools=3D=3D1 as "not pooled"
      lockd: use svc_set_num_threads() for thread start and stop
      NFS: switch the callback service back to non-pooled.
      NFSD: simplify per-net file cache management

Peng Tao (1):
      nfsd: map EBADF

Trond Myklebust (2):
      nfsd: Replace use of rwsem with errseq_t
      nfsd: Add a tracepoint for errors in nfsd4_clone_file_range()

Vasily Averin (1):
      nfsd4: add refcount for nfsd4_blocked_lock

 MAINTAINERS                   |   4 +-
 fs/lockd/svc.c                | 200 ++++++++++++++++++++++++++++++--------=
----------------------------------------------------------
 fs/lockd/svclock.c            |   6 ++-
 fs/nfs/callback.c             |  32 +++++-----------
 fs/nfs/export.c               |   2 +-
 fs/nfsd/filecache.c           |  79 ++++++++------------------------------
 fs/nfsd/filecache.h           |   1 -
 fs/nfsd/netns.h               |  27 +++++++------
 fs/nfsd/nfs3proc.c            |   6 +--
 fs/nfsd/nfs3xdr.c             |  65 --------------------------------
 fs/nfsd/nfs4proc.c            |  24 ++++++------
 fs/nfsd/nfs4state.c           |  63 ++++++++++++++++++++++++-------
 fs/nfsd/nfs4xdr.c             |  21 +++--------
 fs/nfsd/nfscache.c            |   2 +-
 fs/nfsd/nfsctl.c              |  27 ++++++-------
 fs/nfsd/nfsd.h                |   2 +-
 fs/nfsd/nfsfh.c               |  66 +++++++++++++++++++++++++++++++-
 fs/nfsd/nfsfh.h               |  40 +++++++++++++-------
 fs/nfsd/nfsproc.c             |   8 ++--
 fs/nfsd/nfssvc.c              | 220 ++++++++++++++++++++++++++++++++++++++=
+++++++++++++++++++++++---------------------------------------------
 fs/nfsd/state.h               |   5 +++
 fs/nfsd/stats.c               |   2 +-
 fs/nfsd/stats.h               |   4 +-
 fs/nfsd/trace.h               | 106 ++++++++++++++++++++++++++++++++++++++=
++-----------
 fs/nfsd/vfs.c                 | 122 +++++++++++++++++++++++++++++++-------=
---------------------
 fs/nfsd/vfs.h                 |   3 +-
 include/linux/exportfs.h      |   2 -
 include/linux/fs.h            |   4 +-
 include/linux/lockd/lockd.h   |   9 ++++-
 include/linux/sunrpc/svc.h    |  79 +++++++++++++++++++-------------------
 include/trace/events/sunrpc.h |  37 ++++--------------
 net/sunrpc/svc.c              | 175 ++++++++++++++++++++++++++++++++++++--=
----------------------------------------------
 net/sunrpc/svc_xprt.c         |   8 ++--
 33 files changed, 702 insertions(+), 749 deletions(-)

--
Chuck Lever



