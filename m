Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95D2323CFD1
	for <lists+linux-nfs@lfdr.de>; Wed,  5 Aug 2020 21:25:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728347AbgHETZ2 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 5 Aug 2020 15:25:28 -0400
Received: from mail-dm3gcc02on2115.outbound.protection.outlook.com ([40.107.91.115]:26848
        "EHLO GCC02-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728255AbgHERYW (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 5 Aug 2020 13:24:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oCt106S5buOmBC+Tjxe/7PSCkQdjEJ3s/A1xWivqM5PCw1+XtAh+9OQbx7NNVd/o46c0Lgq2jaOzepPByoKdit+6M8002OzS4AntvyT3u951qwL7DxZVZ8LhNAu8DxzafdAN3azLiiG/wpERtToKjY7S3k/yj2p3QrH0K2yg2f+UBKqbsUMhxgbYcf3qa8bOlgpu5G2aU1c6YW9p+ZlRL+N8lnj7UGxX9Q7lQFh/OMQlzan5MEmPS1Ylc/5t0ubFNoNrXDVM4n9E/FynxaeQB+X8kTxmYj39aXuzq+o+Z/Mx3Y1z28YLvRvgBo9aU6RfG03lV+JUVWiIJBsrXnI/Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fb9me95xJ+xQhlKuFG0fG3rgNb10JMh8SBWTKgw+10U=;
 b=L0w+OO95DKOImyOOlZYTMNu0AeI+WLutTd6fJe5j3DDGHjRbjrZqEt8eCpLZ58fvRwuzQqaA425lbbDDTzq5qKslZr/jLqd+7mpMalmjgjcC8wMQCaieBKizZgFbzs7wZwjFcUiBYO9m8S/hItNLhHwKKr9zPUF3EthyJ+9tdCJjG9mfjMy1LpD+oNdFDH2LkkNEYL8q39eq7wfX3aUWHni8a1F19caLUHKDx4mcY/p/avkj52UZ94xw6Ivaohn6xafJIoMsbCZZ5DCOajiXQBEOBXzlbEKvTUHzjRYrZ7cNmmbzHBvj8wVB3KgaBs0dNkpKnpSksXvBYxsTqUFSsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starlab.io; dmarc=pass action=none header.from=starlab.io;
 dkim=pass header.d=starlab.io; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=starlab.io;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fb9me95xJ+xQhlKuFG0fG3rgNb10JMh8SBWTKgw+10U=;
 b=K+94MxhRRRj/A/I7UjMJMe7kOKit1DdCoVOQrHr4INqhZxH712mDhB8GqxoFSiFlcvAy5xU3iJaOK9mcwciRHPynlMMXIJkS3aBRp6U+OjR69QqPgqx+t/OAC+DM4JLeaHiD0YnNz8jU97fpHp/77H5ODkpJW6fLUqV3m/bKAJU=
Authentication-Results: starlab.io; dkim=none (message not signed)
 header.d=none;starlab.io; dmarc=none action=none header.from=starlab.io;
Received: from SA9PR09MB5246.namprd09.prod.outlook.com (2603:10b6:806:4b::9)
 by SA9PR09MB4687.namprd09.prod.outlook.com (2603:10b6:806:4d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.16; Wed, 5 Aug
 2020 17:24:19 +0000
Received: from SA9PR09MB5246.namprd09.prod.outlook.com
 ([fe80::b199:d616:504f:9b6e]) by SA9PR09MB5246.namprd09.prod.outlook.com
 ([fe80::b199:d616:504f:9b6e%2]) with mapi id 15.20.3261.016; Wed, 5 Aug 2020
 17:24:18 +0000
From:   Jeffrey Mitchell <jeffrey.mitchell@starlab.io>
To:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>
Cc:     linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jeffrey Mitchell <jeffrey.mitchell@starlab.io>
Subject: [PATCH] nfs: Fix getxattr kernel panic and memory overflow
Date:   Wed,  5 Aug 2020 12:23:18 -0500
Message-Id: <20200805172319.12633-1-jeffrey.mitchell@starlab.io>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DM5PR2001CA0019.namprd20.prod.outlook.com
 (2603:10b6:4:16::29) To SA9PR09MB5246.namprd09.prod.outlook.com
 (2603:10b6:806:4b::9)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from jeffrey-work-20 (99.61.31.14) by DM5PR2001CA0019.namprd20.prod.outlook.com (2603:10b6:4:16::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.16 via Frontend Transport; Wed, 5 Aug 2020 17:24:18 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [99.61.31.14]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2106a1f1-89e6-4179-44fb-08d839646275
X-MS-TrafficTypeDiagnostic: SA9PR09MB4687:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA9PR09MB46875CDB9C756F1BB454E2D5F84B0@SA9PR09MB4687.namprd09.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dWVeNIyJLsZ4M2J3oIypbjCFYqyPxkzF2kzf811geYqURz8tLKCckKL08KuSsRnIrilly0IheXMOPUMICQlRvR2+RVrECezwR5ocCZs8tjwrO/e4ZUbz2VNNVU8iENj+dg/Sm26B1sAThH1COyLRmjwZahrNrfmnw3a8Iycj+hfgd5vlss0EzihABEdXN7cDIwtpCpeHaCJjwOWiaMMdC7wrrwpFFZg7bnyTSqqUYEY6GLPTPSbPuz4DG6JOCkN0dzOtTzlXQSFT3f9jwkdE4l5lSKd7bXLPVzbjeNhiqjLPsAsH75lN4+AexCZpMg0aG/X/DghzHL+CrxYEqJk2QA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA9PR09MB5246.namprd09.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(39830400003)(366004)(376002)(136003)(346002)(36756003)(1076003)(26005)(44832011)(186003)(956004)(2616005)(86362001)(2906002)(5660300002)(16526019)(107886003)(6486002)(66556008)(66476007)(6496006)(52116002)(110136005)(316002)(8936002)(478600001)(8676002)(66946007)(4326008)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: fssovrObQ9wezRc+EUwo+hye50qTpM/+yKVvYVsVnJtnYhc4Mq8m/ZPLhyQ2G5/+aZcMLWQphy1W4cPjJm2c1XBIURrnwYqQxLt9gaJCogn+9ZGJ6sgXZEU4JrEfu9YxGC/PzGxG6QJuf34+MANUxiXQ2pgwXjnm/rtmyOhTlUboiUUtOAFKPQH/BpHh1lJTf4CCIclI1c5uNGiZXN2tBT6vxTJ31ILDDLBXa7nnE43WbzDoyAAI5x9G1eVOzy7mprta94rN5r8Q+YWJE1ddeNaLrdKlj/GROVTAhTAqojEVUbAaWuRMUUSrRDjJ5/qQ6VVyTX5UDwKWnj5Quo0I+Gh3vPAi2p9CoG/qe5lq5twh8/DUmFtk/4D/LiNvhkoCmnQ1JGicHCVw3vJ2dfGbVopvmMR5xSQXYNi0wnOthN991K53QF1bpHtyPby5PB+TR2mskJdY+8KK9SpPGd/pY2Zd5UMuFCu9Y4hWSOQHZ+DkIw113v/lHmGhxHdMTrb04USNPH0KFugH98h0uCiSl/Y6g5uhsJ/6Hv4HHyR+WV/O/a6qdi//TnSAJWnpmyvo8SELSPYqsrbgTvruU5bzgTSB3beEGXg8udU4xnwbO7IoWy7L03+ojckmESftkmw0E6Dv92u0E3VXERTijGk3qw==
X-OriginatorOrg: starlab.io
X-MS-Exchange-CrossTenant-Network-Message-Id: 2106a1f1-89e6-4179-44fb-08d839646275
X-MS-Exchange-CrossTenant-AuthSource: SA9PR09MB5246.namprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2020 17:24:18.6739
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e611933-986f-4838-a403-4acb432ce224
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qtay2axeT/0Tmsu+lRKUC0tgQpr84F/NmHJD8UZX7MGbcZjtZEXBu0rbalPg5fSXgwhLN2Togy59PAzUO/SjJ9YqtiZIEhDYzCZlT5c3MmQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA9PR09MB4687
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

_nfs4_get_security_label() and decode_attr_security_label() run severe
risks with memory management and do not fully implement their
functionality. In the case that the buffer and length are both NULL, which
according to the getxattr man page should simply return the length of the
attribute, decode_attr_security_label() will kernel panic trying to write
to the null pointer. If the buffer length is nonzero but below the size of
the attribute, decode_attr_security_label() will write the data anyway,
overflowing the buffer, and it isn't until later in
_nfs4_get_security_label() that -ERANGE gets returned.

Here is some of the kernel panic output that I reproduced:
BUG: kernel NULL pointer dereference, address: 0000000000000000
[...]
RIP: 0010:__memcpy+0x12/0x20
[...]
Call Trace:
 decode_getfattr_attrs+0xb1f/0xdc0
 ? set_next_entity+0x8e/0x180
 decode_getfattr_generic.constprop.0+0x10f/0x210
 ? rpc_decode_header+0x570/0x570
 nfs4_xdr_dec_getattr+0x94/0xa0
[...]
 _nfs4_get_security_label+0x134/0x180
 ? _cond_resched+0x10/0x20
 ? __kmalloc+0x1f6/0x200
 nfs4_xattr_get_nfs4_label+0x89/0x120
 __vfs_getxattr+0x4e/0x70
 ecryptfs_getxattr_lower+0x4a/0x70
 ecryptfs_xattr_get+0x23/0x24
 __vfs_getxattr+0x4e/0x70
 sb_finish_set_opts+0x12c/0x240
 selinux_set_mnt_opts+0x288/0x6a0
 security_sb_set_mnt_opts+0x40/0x60
 vfs_get_tree+0x57/0xb0
 do_mount+0x742/0x9b0
 __x64_sys_mount+0x89/0xc0
 do_syscall_64+0x3e/0x70

- Jeffrey

Jeffrey Mitchell (1):
  nfs: Fix getxattr kernel panic and memory overflow

 fs/nfs/nfs4proc.c | 2 --
 fs/nfs/nfs4xdr.c  | 5 ++++-
 2 files changed, 4 insertions(+), 3 deletions(-)

-- 
2.25.1

