Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42C8C345783
	for <lists+linux-nfs@lfdr.de>; Tue, 23 Mar 2021 06:50:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229451AbhCWFty (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 23 Mar 2021 01:49:54 -0400
Received: from mail-eopbgr1300095.outbound.protection.outlook.com ([40.107.130.95]:17502
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229437AbhCWFtc (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 23 Mar 2021 01:49:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MQOnPkCMeqqKtkNcXZDzSOu9dz8wRGSVUM35POAkx/YTni28K5soa+c+3UgqA83ud6ID5be2HnVKNG725FVmiXROAdDns7JXijddEk4QPoe9H8K2mWqefglXlQceRaBl7TGvhbfl4Wv/AxCilZfFYOtc1bmngGpYctyuthmFj8XBJE0/uQ5a74UepB1MtGi7lD8lkD1rUq9jIOS638q4HXnJcrnYqwuXCLa7C8x1/aEd2PzkvD6KZpni1Hy3AoLpCZIogpWi24703fHtJ2j+YdDVdc+wwRLkN0ed0SkmCKwn3neW4x2Mnr/s5fxrYFMXR3G6mdBG9+fnyaVWjpJ3lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qKBFFqhU6lZOMeV5hdzRQrZs7jmh/GISxGtQjIYmKFc=;
 b=kKhv2bMZ8Zn3atLIuiw1SR7GLmarzX3qm81CteG661SIvqzikpecE3w3q1RzyLATf5TS1KdJujomKHwMZFT9lzYOAnMmzgqHyWvWAgy7I+dmFcPAhIrGV4MRVRXFapTqFoO7/DSyaxqX1EZUcNZ87mL4VhZk8FZI/7FTm1maIIkzHzGVPBA77NmnzWR9+dIcEeUoa62XDlvhs7B5Cu2bLFuyvHdsZE6XRorojc4WdR/L+uDgULsseO7Oj8cGeb/oJ+I5N+hI+1AZ2UpBTFKerCALOJS8AaCDfSrI6EkLNgCWVQSFc0czBF3SgnhDauG8B44u9R1gNTNMJzLHbhXrrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qKBFFqhU6lZOMeV5hdzRQrZs7jmh/GISxGtQjIYmKFc=;
 b=QaG7GACwU4DN/U4i4rn2TrWxy3e8RHbTR5FOMkmAA7/G4MOiFhlwo03K8CnM9QblZ/vJ4rTCIoBCwrJx32+U7w/aEaUz8YRXj08Il9ykUrDPqAUc5Un8Zp0UUYSK53CTxLoKbymAbTPOfdfH3RtgXIs4gS0/K0FhEeyhT/UaxJw=
Received: from SG2P153MB0361.APCP153.PROD.OUTLOOK.COM (2603:1096:0:4::11) by
 SG2P15301MB0064.APCP153.PROD.OUTLOOK.COM (2603:1096:3:10::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3999.6; Tue, 23 Mar 2021 05:49:29 +0000
Received: from SG2P153MB0361.APCP153.PROD.OUTLOOK.COM
 ([fe80::cd6e:9dc1:85ac:f488]) by SG2P153MB0361.APCP153.PROD.OUTLOOK.COM
 ([fe80::cd6e:9dc1:85ac:f488%5]) with mapi id 15.20.3999.008; Tue, 23 Mar 2021
 05:49:29 +0000
From:   Nagendra Tomar <Nagendra.Tomar@microsoft.com>
To:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
CC:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>
Subject: [PATCH 3/5] nfs: Add mount option for forcing RPC requests to one
 file over one connection
Thread-Topic: [PATCH 3/5] nfs: Add mount option for forcing RPC requests to
 one file over one connection
Thread-Index: AdcfqDqoFcB9R6RLR4K5SOwpCsdSAA==
Date:   Tue, 23 Mar 2021 05:49:29 +0000
Message-ID: <SG2P153MB0361C58787DE9100722B81349E649@SG2P153MB0361.APCP153.PROD.OUTLOOK.COM>
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
x-ms-office365-filtering-correlation-id: 890139b5-2a9b-4e81-cd85-08d8edbf6cdf
x-ms-traffictypediagnostic: SG2P15301MB0064:
x-microsoft-antispam-prvs: <SG2P15301MB0064DFEB9941956A3CA04F5B9E649@SG2P15301MB0064.APCP153.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:142;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: S/EY/CeZBDAVpu9K6kL5HWtT/JkomV6XMtMAZCEE1aeAQHjd+oyJWcevQVw5BDIAmgS7QWtgSuXplN953yolsYU8MFo2fhO9YQ7NfCPbO4ImOWTpFdpfzGdrbwFlxXbo0yn6FIyTe4qKGAr2RlyKCSDOTQzYWJR8aPbwEDn82xOntELJPHzYnHth1ciuZBkRnr/YSFvatq9Nt2mV9c3E0v506+ol6zZEurtT1NZRUe0Tzqdu82XMGorSaVaYHnY6jghqW6etaicneSyKRz35qwytqrPr/W6vfIlMrqHp0cp978FbiYmZ9cp6QuyesSM6HmS16h9zJfXW26uVUnP/EM+HMaRLNWMfCE4TJZrDN38i1OCwrKjtzNHQAHkbpe8FWCmzEE/tkuvm7/0cDkB8MQLEqb1RfpNdpwl59DeDQugz5//wjZE5/TJA8cUMAFh9yBPCNRYa4/xn1aOk8/GzQNuyTaEam/XrVjfVFp++hCg4Zd5yyNlCG7qspodk/wGIx2Wr4M+eHhqMqsrbedaEUpKWS7gj6Sf4EQvsoV+9rmr0/iVZ3Eez+RKTc/KiwCkDRqZ3zBgzqZ549GuSutw6JIpS2oirzjtgmDVkUpFJbCuzdTwSVD7ZcnZj2n2LA8JrdyyP8h/+OAPP//9QPe2d9g1jbnsFhJOnXJlR01thlaY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2P153MB0361.APCP153.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(376002)(39860400002)(136003)(366004)(396003)(346002)(5660300002)(316002)(52536014)(7696005)(54906003)(76116006)(33656002)(86362001)(8990500004)(10290500003)(186003)(66476007)(38100700001)(64756008)(66446008)(26005)(6506007)(6916009)(66556008)(66946007)(55236004)(71200400001)(82960400001)(2906002)(8676002)(8936002)(9686003)(55016002)(82950400001)(83380400001)(478600001)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?YMguskSyQ0fu9i+GAF9jnmAVLVFFSOsE+hYTHBXWzfulwOKgZBc/A8tublf6?=
 =?us-ascii?Q?EkkHAzw8leyq0uDGniA5CWTCTJFjYhtK8NXPEMBCEtH7vNgaR69zf3BgpZlD?=
 =?us-ascii?Q?2r8NncUVPtXTh2v+o0uNMa9EBek2K7W8Ap+jgiYA/Kw8lS/cWuCCYSg1g5qv?=
 =?us-ascii?Q?kTgsthlWknF+wH0ua6zIWSGBsy8Cm45xZb83rTEUGQfWFzQiA43vFx8Ney2U?=
 =?us-ascii?Q?LCExGFjD3LYSlC7AHZ/lc37XBNRhDxjVxHbAIbIuEudSMSc+jozpmKFuwQkR?=
 =?us-ascii?Q?tHDmGRWdeGthR6opGEjIlIZr53kRoQlSpiHOD0wIwXxfzcd86S6U7hNwJcbp?=
 =?us-ascii?Q?3GIMNjEIFt/RapRUH+jPTeHrrzMzBmfPBIPRnG0e2Bl5J9rG4PCH92CfEeYl?=
 =?us-ascii?Q?VciPSGUSWgVbmsoLVqZ0kPIs5k36AQuhwm9EnG+pzk+HfgmSDa2wgs9sOYCt?=
 =?us-ascii?Q?D7ypXe+SEjv+mYNv9zO1JFfqaUv9yx8/AzGkvIrgpNetx2e4Cw+QM0+AcB3l?=
 =?us-ascii?Q?7ud823G8ou4wS9LwDGdUjbkcoU9lG5wkweg1egKPciEH8N5Wpgu8SkqkVA0G?=
 =?us-ascii?Q?XmFCVTlrgJW93OePu+rLMjl+91WSMLum+4dCfXiVSKn/woy0WO1b3ZjQcAXD?=
 =?us-ascii?Q?nRCZIOCgEpNk6sc8V9tg83XIWp+/A3pSI6B6puDfJXeU9oEdW0YyQJ+dh1DP?=
 =?us-ascii?Q?OGFK2uoK8DY8vxhb2RG2fXYT1u1XQtiHlLHtC/SQ29sxmjeE/ozsMFMr+KXN?=
 =?us-ascii?Q?Y8EmpgvstrOfk5PkEA041hkIPCJHvNz/NGmLaJs+AMvPV2RgSxZ7ezChqVNg?=
 =?us-ascii?Q?tGMyKDSJM7tfHz3PHnKGoif0iu1yJ4hZ5XCX83IPy2nGkFDdL6sP0Yt74LcY?=
 =?us-ascii?Q?HU2T1usOARtzalqJSIIxX1dXAiM9S9KjuJa0SH97eFiVQOA/2vJwXdqkDUBh?=
 =?us-ascii?Q?ORiKJ/l2SVZm8BqpNRX1MNatNgTdqZNNIHA3C9cVDhx03GdgCiTtz9FFdiGc?=
 =?us-ascii?Q?qEElqShxQeTUd1EGzDybVOJ9xaJj7FdD58nk24jfVmSW4mmK0/MxED2JSE9P?=
 =?us-ascii?Q?X/xrUbUaGxc1E8O+hdSzN4WvCOG0CfyhUWQt1sVs4eavW5MLEZs7Dw9Y/QXE?=
 =?us-ascii?Q?zfXyQYS7r+DT5wfMV2qhQAtWL6HUFxXztEfcGEEbNou2k4OR7Q7ctGUqaJCf?=
 =?us-ascii?Q?VM8gGboEbyxkAUvGDR1084LNncw9M2zvRgZp8/dRJt3Dfbet6XE78lxoeCIM?=
 =?us-ascii?Q?yamNI+6o2PSFuScW5x57xhpFY3rRKJxBdYnk+63Y3QpBsNDuXhQo7i7gQG7n?=
 =?us-ascii?Q?Ib5pUzYMbWLyzK+vBx001XoI?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SG2P153MB0361.APCP153.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 890139b5-2a9b-4e81-cd85-08d8edbf6cdf
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2021 05:49:29.1947
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3A/PGlAj0GoPFpW4uPCxvivNWCVGp5D9dT8Gjnu6fdqhLgCSVjz97JBfipDvKChEtS8zg5ltG/1r0aI5xuVrDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2P15301MB0064
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Nagendra S Tomar <natomar@microsoft.com>

Rename RPC_TASK_NO_ROUND_ROBIN to RPC_TASK_USE_MAIN_XPRT since
we have more than just the roundrobin policy now.

Signed-off-by: Nagendra S Tomar <natomar@microsoft.com>
---
 fs/nfs/nfs4proc.c             | 18 +++++++++---------
 include/linux/sunrpc/sched.h  |  2 +-
 include/trace/events/sunrpc.h |  4 ++--
 net/sunrpc/clnt.c             |  2 +-
 4 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index c65c4b41e2c1..9516c479ba46 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -6274,7 +6274,7 @@ int nfs4_proc_setclientid(struct nfs_client *clp, u32=
 program,
 		.rpc_message =3D &msg,
 		.callback_ops =3D &nfs4_setclientid_ops,
 		.callback_data =3D &setclientid,
-		.flags =3D RPC_TASK_TIMEOUT | RPC_TASK_NO_ROUND_ROBIN,
+		.flags =3D RPC_TASK_TIMEOUT | RPC_TASK_USE_MAIN_XPRT,
 	};
 	unsigned long now =3D jiffies;
 	int status;
@@ -6341,7 +6341,7 @@ int nfs4_proc_setclientid_confirm(struct nfs_client *=
clp,
 		clp->cl_rpcclient->cl_auth->au_ops->au_name,
 		clp->cl_clientid);
 	status =3D rpc_call_sync(clp->cl_rpcclient, &msg,
-			       RPC_TASK_TIMEOUT | RPC_TASK_NO_ROUND_ROBIN);
+			       RPC_TASK_TIMEOUT | RPC_TASK_USE_MAIN_XPRT);
 	trace_nfs4_setclientid_confirm(clp, status);
 	dprintk("NFS reply setclientid_confirm: %d\n", status);
 	return status;
@@ -8078,7 +8078,7 @@ static int _nfs4_proc_secinfo(struct inode *dir, cons=
t struct qstr *name, struct
 		.rpc_message =3D &msg,
 		.callback_ops =3D clp->cl_mvops->call_sync_ops,
 		.callback_data =3D &data,
-		.flags =3D RPC_TASK_NO_ROUND_ROBIN,
+		.flags =3D RPC_TASK_USE_MAIN_XPRT,
 	};
 	const struct cred *cred =3D NULL;
=20
@@ -8451,7 +8451,7 @@ nfs4_run_exchange_id(struct nfs_client *clp, const st=
ruct cred *cred,
 		.rpc_client =3D clp->cl_rpcclient,
 		.callback_ops =3D &nfs4_exchange_id_call_ops,
 		.rpc_message =3D &msg,
-		.flags =3D RPC_TASK_TIMEOUT | RPC_TASK_NO_ROUND_ROBIN,
+		.flags =3D RPC_TASK_TIMEOUT | RPC_TASK_USE_MAIN_XPRT,
 	};
 	struct nfs41_exchange_id_data *calldata;
 	int status;
@@ -8681,7 +8681,7 @@ static int _nfs4_proc_destroy_clientid(struct nfs_cli=
ent *clp,
 	int status;
=20
 	status =3D rpc_call_sync(clp->cl_rpcclient, &msg,
-			       RPC_TASK_TIMEOUT | RPC_TASK_NO_ROUND_ROBIN);
+			       RPC_TASK_TIMEOUT | RPC_TASK_USE_MAIN_XPRT);
 	trace_nfs4_destroy_clientid(clp, status);
 	if (status)
 		dprintk("NFS: Got error %d from the server %s on "
@@ -8959,7 +8959,7 @@ static int _nfs4_proc_create_session(struct nfs_clien=
t *clp,
 	args.flags =3D (SESSION4_PERSIST | SESSION4_BACK_CHAN);
=20
 	status =3D rpc_call_sync(session->clp->cl_rpcclient, &msg,
-			       RPC_TASK_TIMEOUT | RPC_TASK_NO_ROUND_ROBIN);
+			       RPC_TASK_TIMEOUT | RPC_TASK_USE_MAIN_XPRT);
 	trace_nfs4_create_session(clp, status);
=20
 	switch (status) {
@@ -9036,7 +9036,7 @@ int nfs4_proc_destroy_session(struct nfs4_session *se=
ssion,
 		return 0;
=20
 	status =3D rpc_call_sync(session->clp->cl_rpcclient, &msg,
-			       RPC_TASK_TIMEOUT | RPC_TASK_NO_ROUND_ROBIN);
+			       RPC_TASK_TIMEOUT | RPC_TASK_USE_MAIN_XPRT);
 	trace_nfs4_destroy_session(session->clp, status);
=20
 	if (status)
@@ -9287,7 +9287,7 @@ static int nfs41_proc_reclaim_complete(struct nfs_cli=
ent *clp,
 		.rpc_client =3D clp->cl_rpcclient,
 		.rpc_message =3D &msg,
 		.callback_ops =3D &nfs4_reclaim_complete_call_ops,
-		.flags =3D RPC_TASK_NO_ROUND_ROBIN,
+		.flags =3D RPC_TASK_USE_MAIN_XPRT,
 	};
 	int status =3D -ENOMEM;
=20
@@ -9808,7 +9808,7 @@ _nfs41_proc_secinfo_no_name(struct nfs_server *server=
, struct nfs_fh *fhandle,
 		.rpc_message =3D &msg,
 		.callback_ops =3D server->nfs_client->cl_mvops->call_sync_ops,
 		.callback_data =3D &data,
-		.flags =3D RPC_TASK_NO_ROUND_ROBIN,
+		.flags =3D RPC_TASK_USE_MAIN_XPRT,
 	};
 	const struct cred *cred =3D NULL;
 	int status;
diff --git a/include/linux/sunrpc/sched.h b/include/linux/sunrpc/sched.h
index df696efdd675..4885ba352c6b 100644
--- a/include/linux/sunrpc/sched.h
+++ b/include/linux/sunrpc/sched.h
@@ -125,7 +125,7 @@ struct rpc_task_setup {
 #define RPC_CALL_MAJORSEEN	0x0020		/* major timeout seen */
 #define RPC_TASK_ROOTCREDS	0x0040		/* force root creds */
 #define RPC_TASK_DYNAMIC	0x0080		/* task was kmalloc'ed */
-#define	RPC_TASK_NO_ROUND_ROBIN	0x0100		/* send requests on "main" xprt */
+#define	RPC_TASK_USE_MAIN_XPRT	0x0100		/* send requests on "main" xprt */
 #define RPC_TASK_SOFT		0x0200		/* Use soft timeouts */
 #define RPC_TASK_SOFTCONN	0x0400		/* Fail if can't connect */
 #define RPC_TASK_SENT		0x0800		/* message was sent */
diff --git a/include/trace/events/sunrpc.h b/include/trace/events/sunrpc.h
index 036eb1f5c133..9c1c0593d0e6 100644
--- a/include/trace/events/sunrpc.h
+++ b/include/trace/events/sunrpc.h
@@ -301,7 +301,7 @@ TRACE_DEFINE_ENUM(RPC_TASK_NULLCREDS);
 TRACE_DEFINE_ENUM(RPC_CALL_MAJORSEEN);
 TRACE_DEFINE_ENUM(RPC_TASK_ROOTCREDS);
 TRACE_DEFINE_ENUM(RPC_TASK_DYNAMIC);
-TRACE_DEFINE_ENUM(RPC_TASK_NO_ROUND_ROBIN);
+TRACE_DEFINE_ENUM(RPC_TASK_USE_MAIN_XPRT);
 TRACE_DEFINE_ENUM(RPC_TASK_SOFT);
 TRACE_DEFINE_ENUM(RPC_TASK_SOFTCONN);
 TRACE_DEFINE_ENUM(RPC_TASK_SENT);
@@ -318,7 +318,7 @@ TRACE_DEFINE_ENUM(RPC_TASK_CRED_NOREF);
 		{ RPC_CALL_MAJORSEEN, "MAJORSEEN" },			\
 		{ RPC_TASK_ROOTCREDS, "ROOTCREDS" },			\
 		{ RPC_TASK_DYNAMIC, "DYNAMIC" },			\
-		{ RPC_TASK_NO_ROUND_ROBIN, "NO_ROUND_ROBIN" },		\
+		{ RPC_TASK_USE_MAIN_XPRT, "USE_MAIN_XPRT" },		\
 		{ RPC_TASK_SOFT, "SOFT" },				\
 		{ RPC_TASK_SOFTCONN, "SOFTCONN" },			\
 		{ RPC_TASK_SENT, "SENT" },				\
diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
index ed470a75e91d..f1fb2984e393 100644
--- a/net/sunrpc/clnt.c
+++ b/net/sunrpc/clnt.c
@@ -1066,7 +1066,7 @@ void rpc_task_set_transport(struct rpc_task *task, st=
ruct rpc_clnt *clnt)
 {
 	if (task->tk_xprt)
 		return;
-	if (task->tk_flags & RPC_TASK_NO_ROUND_ROBIN)
+	if (task->tk_flags & RPC_TASK_USE_MAIN_XPRT)
 		task->tk_xprt =3D rpc_task_get_first_xprt(clnt);
 	else {
 		u32 xprt_hint =3D 0;
