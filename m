Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37C0434577C
	for <lists+linux-nfs@lfdr.de>; Tue, 23 Mar 2021 06:47:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229451AbhCWFqj (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 23 Mar 2021 01:46:39 -0400
Received: from mail-eopbgr1320131.outbound.protection.outlook.com ([40.107.132.131]:9280
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229590AbhCWFqR (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 23 Mar 2021 01:46:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jiVNu3s4nNfbZ1EFQUFKIaj2XBft8+RKLuFHZGt8Bff8iEdMtwCnf78sopxqoBgSZRUR1JRRnuMyUh3SdpHIRp/3tQTEgcr5ygWw0Bl/07DKmUnJlxYite+7Mqu+NQqsdG6Pp9QFcPDPi4U8SRXmTCp68DpC8CjW/FxVMXy0w/ZgTrgBkL9E2CtbfQ/innZOIUIRT+d9SjOU0W/Lpfg5tdPy738YPXH94d8JQ9Ao7IG1ifT1Pl5Dd2NPXc1vUaY3oh7OgYTgUtnt1tDABc/4CCn0JCfYrCEkysC3PSfBqS/by4Q+x65sDyWnu/ezvcRRfddqrIlnjDDQyEV9tnuf5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vQ2V4wLBsi3nX9WluOQPP0hwot9G+FSjPLWtQXBheKk=;
 b=X8DXBdcLV9UHaJXGqe57wWfGwxg+iq+P3inZBB65La42u3wVxQEZJsHY6onhsPtp0N3SRL+vdTRKMNkRPMtiH9iL97N2EYtTn6cjNNl8W9cLbtw4KJ8Fy0V3Wm+wD3cu+xwqx/fhEGxU7Ua6x+VJ8r+WwyEcf9RlTzA19NdvmSlM34xK8OFBFTHs0AQSEb0TUmINVmIrlVu8s5ldVvoctGH6ZMP8PHTIrnF1tSFPo3ThAsZArGuBCcVaCPYBp07r0hIjLwU79hO7PUy2d+rxsUdlv2foSw7KOwpeqGrko3IKMpVcft2Rxw1UmFJYR8z9jnN/RUEVEzYvlkzctj9iCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vQ2V4wLBsi3nX9WluOQPP0hwot9G+FSjPLWtQXBheKk=;
 b=S0P+2ERYngIivdhCElMlFfwSK8piCgnuXWzu4/izNC+ACxNgoQzM2kHcxNDhoqXVGHIlDEZpctclh/cxQbb16AgDsEfJjw/gqPB9ub8yZXlxDKtbZ6mVGh22XdJNTrS/93CyBlD7ctdZBaSfyoZi3uDeFgvCsf0WWGZlCZmbLFA=
Received: from SG2P153MB0361.APCP153.PROD.OUTLOOK.COM (2603:1096:0:4::11) by
 SG2P15301MB0064.APCP153.PROD.OUTLOOK.COM (2603:1096:3:10::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3999.6; Tue, 23 Mar 2021 05:46:13 +0000
Received: from SG2P153MB0361.APCP153.PROD.OUTLOOK.COM
 ([fe80::cd6e:9dc1:85ac:f488]) by SG2P153MB0361.APCP153.PROD.OUTLOOK.COM
 ([fe80::cd6e:9dc1:85ac:f488%5]) with mapi id 15.20.3999.008; Tue, 23 Mar 2021
 05:46:13 +0000
From:   Nagendra Tomar <Nagendra.Tomar@microsoft.com>
To:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
CC:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>
Subject: [PATCH 0/5] nfs: Add mount option for forcing RPC requests for one
 file over one connection
Thread-Topic: [PATCH 0/5] nfs: Add mount option for forcing RPC requests for
 one file over one connection
Thread-Index: Adcfp3hcmhRvn3IHQv25MQlIHJPMUA==
Date:   Tue, 23 Mar 2021 05:46:13 +0000
Message-ID: <SG2P153MB0361E2D69F8AD8AFBF9E7CD89E649@SG2P153MB0361.APCP153.PROD.OUTLOOK.COM>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=microsoft.com;
x-originating-ip: [122.172.188.128]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 225f3c89-7e3e-4eea-3878-08d8edbef853
x-ms-traffictypediagnostic: SG2P15301MB0064:
x-microsoft-antispam-prvs: <SG2P15301MB00649F71E3E47D5294047DA59E649@SG2P15301MB0064.APCP153.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uYGDNJbaFmU5EgZWOfIA0ac2hSW0+qZCpniv2+ML+nF/2wVdhpk6mSRHkvxSlzmbWLUgy6ruqW4mG7edZwUBWcgvEgigRHyLCWnbkVDomBlnZH0r+ZnzKx5Je2O9CTG5an2l4XmExhxVLHgL3tdD6wH7qs2086Q+94Sn7IG9nNXsgtJjBE7o4N5s//KKbmv5eqfs96jB97ZsyS2dxlBpr9veIqAgkz6KfuKqkD0A1KiGZ5dsJfy54x5qkWFT0B8EopYSTW5VLYKXzWpe7X0C+T093eVg04ZvTgqAzbtUNhcEbYm5Cye3xl9gyvacsbTYOpJqgy992DuM4mtPhWnTC6esjc6oEuZ5SOMeb+TP6n87RdZ0R5kmn0ngkL3SKF0XfFUc6+j57FKyt9j8PZaSGCqoaED/+nZ1Sw4l4hRR6eOW2oAVJMj1VQi/Mb60eOPSdIavZSjKhmg9eDJMjlWf1aNjRButKibG3jtR84iGUYvVSfG6ZDAHfjkzIXQkYyqDZAr8A8hsA+71CdJn2++j7fipaZ6jKHszkkqKr//EEwus/3+zo9ijvFejxvrUXxWnB2MyQPFnrxgfLcdoshXtsl35R4vm2GGGuAAuugyNGOQUJboFB4CbQEbPWFj16WCGqzcuXAgFHThjv7OcqAL+DMN+dSJhsnxeBaKyNl1NON8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2P153MB0361.APCP153.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(376002)(39860400002)(136003)(366004)(396003)(346002)(5660300002)(316002)(52536014)(7696005)(54906003)(76116006)(33656002)(86362001)(8990500004)(10290500003)(186003)(66476007)(38100700001)(64756008)(66446008)(26005)(6506007)(6916009)(66556008)(66946007)(55236004)(71200400001)(82960400001)(2906002)(8676002)(8936002)(9686003)(55016002)(82950400001)(83380400001)(478600001)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?tXFjzXnsAdQpUz+hv8IeG9l9eAUlj9IyV15+HEpjcEs25S+iEy9zWaG7n107?=
 =?us-ascii?Q?xbdbn+3AZAbK14xhfWloeR7qCiiOWI/UqBIhyL+kYoAMQdwc2Sruy14P02ws?=
 =?us-ascii?Q?n89MupwfnKyB0XX9VsEUbKytA/sqCVviWSznsbSIFS1E6yqS20TpA3KDMLnS?=
 =?us-ascii?Q?ekqYkIw72LCYefeZJs1oHHlh8JR3Su86UBnT1vj44k+itPL+uywctrfElv+7?=
 =?us-ascii?Q?NxeU9XLBPRwFPq6bcCN8eJ9Bcxdjg5e0yiaJg1TT/SbM3dXZW0VWaqrp56a2?=
 =?us-ascii?Q?W9Ap3d9TmdVcJHAHlgKf801Vc8GnYCpz4zoqN76bl6zp47DdQOG4175UW+8n?=
 =?us-ascii?Q?tn8cddU0Br6+kY37MwJZel4by4YcxiRQu2tjDbTa0C3PbfWKLaATVViuYM37?=
 =?us-ascii?Q?/lfiSVyG+VVGUAM/zyFDXoODs5v3XKu5WWdTsleJL7mMlyJh4O9SAhWpH9bc?=
 =?us-ascii?Q?+uIchyRM9DedUetPOkNOK2UW2KSROHkwrOcmYTFDHwZPrWSKfge4845fUX2h?=
 =?us-ascii?Q?RXgV+RVxPEfLyJ99INKF8EfaJw5hqDPKOADJwlRMScmod9qf/hiGTQoSdip2?=
 =?us-ascii?Q?xEGl8cGynERpV65s1pVO9fOZYAFVih4zUmm8iFy06BSIs/UvibxTXjb7DQWv?=
 =?us-ascii?Q?VWzZez/jxe9sQ8pGw+NiOk2FJ/1B3nVDUUr+M8hTMy20YLVTtzhywfsqwKeV?=
 =?us-ascii?Q?oxBBkE5cJ5Aftk4tnJCuOT3l0h9i7vIrFqUEAt7a7i4rV3oThgHiYoep4Mfn?=
 =?us-ascii?Q?N3BRUCiXLOo1TbRNcjI7YHAiwhE4xMrQEmYLbdFPz89AXG4uqMbeRg08sMOU?=
 =?us-ascii?Q?Vb22hoGGeuZ1znMe4STWUHYOEuYi9ZeXzNE4/HlL77TS4k0roM1IcpiMt5yh?=
 =?us-ascii?Q?rsHRmG81Sl68rl5+9XigVl/jpABQvL9JQRX4vLSXZ3RVzOYbdOQaDMJ7PB2J?=
 =?us-ascii?Q?F9D2ui4FfalSd6MOJ5UWZfw9BCEoYu2I+soX49DUONd+XDTzcNaKKvpec+sx?=
 =?us-ascii?Q?X3aJapaB0PPz1J5txV9Z3Hh6AbftVGB74/hTI6aSWAjndLJzeLCfUQDgi/No?=
 =?us-ascii?Q?LW5B8/hLRYXxAWK0WgieJE/gUTJYoyOnr8GVxoxP9J4svkgui6K833sZhL1U?=
 =?us-ascii?Q?DhDbLYHZr3DKyoyKND7nB7BX3wiOp3O/8EQ8JZToik2j9iwAqqZa0HciDg/P?=
 =?us-ascii?Q?KuRBbT6IVUX8yL48slxiBopOYGYfUM6u3gZq+Nbdb7xTG9hMM6tx75+I/kNA?=
 =?us-ascii?Q?8xf/H6xUQPocsMAyQE3JgC0XE1sKj/hDMK4+0Hj9KXOKdA2Qm6eIEN/kx2vo?=
 =?us-ascii?Q?qDmudvaWmseaokhSbtzAnqqJ?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SG2P153MB0361.APCP153.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 225f3c89-7e3e-4eea-3878-08d8edbef853
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2021 05:46:13.6238
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ytqpXSBdG7JrZOC0vJoDmEUhdW3tktNHWkOA/xwBV58EyrA7XeeOeg3AVN82IRUFMxpL76du8UdCSvsiMOthRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2P15301MB0064
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Nagendra S Tomar <natomar@microsoft.com>

If a clustered NFS server is behind an L4 loadbalancer the default
nconnect roundrobin policy may cause RPC requests to a file to be
sent to different cluster nodes. This is because the source port
would be different for all the nconnect connections.
While this should functionally work (since the cluster will usually
have a consistent view irrespective of which node is serving the
request), it may not be desirable from performance pov. As an
example we have an NFSv3 frontend to our Object store, where every
NFSv3 file is an object. Now if writes to the same file are sent
roundrobin to different cluster nodes, the writes become very
inefficient due to the consistency requirement for object update
being done from different nodes.
Similarly each node may maintain some kind of cache to serve the file
data/metadata requests faster and even in that case it helps to have
a xprt affinity for a file/dir.
In general we have seen such scheme to scale very well.

This patch introduces a new rpc_xprt_iter_ops for using an additional
u32 (filehandle hash) to affine RPCs to the same file to one xprt.
It adds a new mount option "ncpolicy=3Droundrobin|hash" which can be
used to select the nconnect multipath policy for a given mount and
pass the selected policy to the RPC client.
It adds a new rpc_procinfo member p_fhhash, which can be supplied
by the specific RPC programs to return a u32 hash of the file/dir the
RPC is targetting, and lastly it provides p_fhhash implementation
for various NFS v3/v4/v41/v42 RPCs to generate the hash correctly.

Thoughts?

Thanks,
Tomar

Nagendra S Tomar (5):
  SUNRPC: Add a new multipath xprt policy for xprt selection based
    on target filehandle hash
  SUNRPC/NFSv3/NFSv4: Introduce "enum ncpolicy" to represent the nconnect
    policy and pass it down from mount option to rpc layer
  SUNRPC/NFSv4: Rename RPC_TASK_NO_ROUND_ROBIN -> RPC_TASK_USE_MAIN_XPRT
  NFSv3: Add hash computation methods for NFSv3 RPCs
  NFSv4: Add hash computation methods for NFSv4/NFSv42 RPCs

 fs/nfs/client.c                      |   3 +
 fs/nfs/fs_context.c                  |  26 ++
 fs/nfs/internal.h                    |   2 +
 fs/nfs/nfs3client.c                  |   4 +-
 fs/nfs/nfs3xdr.c                     | 154 +++++++++++
 fs/nfs/nfs42xdr.c                    | 112 ++++++++
 fs/nfs/nfs4client.c                  |  14 +-
 fs/nfs/nfs4proc.c                    |  18 +-
 fs/nfs/nfs4xdr.c                     | 516 ++++++++++++++++++++++++++++++-=
----
 fs/nfs/super.c                       |   7 +-
 include/linux/nfs_fs_sb.h            |   1 +
 include/linux/sunrpc/clnt.h          |  15 +
 include/linux/sunrpc/sched.h         |   2 +-
 include/linux/sunrpc/xprtmultipath.h |   9 +-
 include/trace/events/sunrpc.h        |   4 +-
 net/sunrpc/clnt.c                    |  38 ++-
 net/sunrpc/xprtmultipath.c           |  91 +++++-
 17 files changed, 913 insertions(+), 103 deletions(-)
