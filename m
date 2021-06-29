Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39EC13B77D0
	for <lists+linux-nfs@lfdr.de>; Tue, 29 Jun 2021 20:28:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234727AbhF2SbJ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 29 Jun 2021 14:31:09 -0400
Received: from mail-mw2nam10on2117.outbound.protection.outlook.com ([40.107.94.117]:31489
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233843AbhF2SbI (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 29 Jun 2021 14:31:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KaEAFzrud/cHFL3sQ7wbOCN7pj8oQ4w4YioPu25PLiwkzQwBib8kZJmN1yUZPidCw3xRjKeAMm6MCcPSmyDGcySWhz09u9bJdJkTrJJCVAgh08vY+bvPpzA5j4cgcqiVOLLmKzmQvL/fCRazu9pcXDVLjKgnHeB6FLimsLsOTsGbkwqqlCiIDGHowPM/GvkPSewobZq1X9h4ujlFreEWENU+y8f7dQ1/tPpCYgnzaqaIEyWKNtrorRAnwlcd7T/sZiNxOJ/xquCJg3sJkkWdYOiu9Zo9mExjwPyAL2eIgWENJRdmvOesOL/hfnTE0/9io2vDs629ZThzSmQr3N54ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=muGTbG7JcUJT89+9X3/JEwKbgufp+VDRvLj2kq0sw2M=;
 b=CURYN6/fMKXebzied3BmIEVz6tUXXs5Hq1FucUTOhxDMMfekAsillJuhe3akfyp94FymmHjiJ4cfrx6Dveg5K3PdP8UAxko2Uu+tSCMGfcS7fko55TalsRdEY2rHxkkVxbzCME9wzdXmvVjIPas+KMZVyU4Lg2N8gkiRCVSwNu4/3OUpC1jtGkl5wtHOV+pPBDOJy2gzgWFBXd2n3RWbkXOrl5BEspa6ikevo4A2V9waHrhPD2pJhof6MHH5/ALnsN4cEb8lGHDtrSJ66nLXB1Bcw2pRyPJe35eLMSrSf4D62kpEaQGbdiC8WBit5zItajRo7FpqGGgApypOzzU89A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornelisnetworks.com; dmarc=pass action=none
 header.from=cornelisnetworks.com; dkim=pass header.d=cornelisnetworks.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=muGTbG7JcUJT89+9X3/JEwKbgufp+VDRvLj2kq0sw2M=;
 b=SYrUYzGYshSlA3z7matAJQ0KDQr7ppAnIHQEuJG1Lg9UeUbrSp0UkOmZ3TBPtYqj4J0j7BsVtQc6WCR9QpH3GbGmEe1kr9hdObY5AqOYJ5TvO+7oBVDnBC08ZZnDvx8KgMETKyYWnQnvYrvDlcX8apYcsVj+pwtdjolQ50uqum3CzCB6x2FaMT4YSzqM0A4b7sKLTNwP+oLrqRiFXvQPyyZMuyzGxtZ2vUUhwWjYpgkjDImEwPiTPQcBPOpA6w8IwjtDuIRT/1z3DEnq+ss7xhZvdiCrIGBlyJiMDGne3zaW/attRQnLa5O2DE6G1DM3o6IX54W42JBU2r+mdrxRSA==
Received: from CH0PR01MB7153.prod.exchangelabs.com (2603:10b6:610:ea::7) by
 CH2PR01MB5960.prod.exchangelabs.com (2603:10b6:610:43::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4264.18; Tue, 29 Jun 2021 18:28:39 +0000
Received: from CH0PR01MB7153.prod.exchangelabs.com
 ([fe80::81f3:3a8:e00f:92ec]) by CH0PR01MB7153.prod.exchangelabs.com
 ([fe80::81f3:3a8:e00f:92ec%9]) with mapi id 15.20.4264.026; Tue, 29 Jun 2021
 18:28:38 +0000
From:   "Marciniszyn, Mike" <mike.marciniszyn@cornelisnetworks.com>
To:     Chuck Lever <chuck.lever@oracle.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        "Hillman, Richie" <Richie.Hillman@cornelisnetworks.com>,
        "Dalessandro, Dennis" <dennis.dalessandro@cornelisnetworks.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: NFS trace new to 5.13.0 (GA)
Thread-Topic: NFS trace new to 5.13.0 (GA)
Thread-Index: AddtE3KnceyIXtJFQ4q1p77amM2J2Q==
Date:   Tue, 29 Jun 2021 18:28:38 +0000
Message-ID: <CH0PR01MB71539295AEF1947518073D0FF2029@CH0PR01MB7153.prod.exchangelabs.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none
 header.from=cornelisnetworks.com;
x-originating-ip: [70.15.25.19]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5f147a7d-c126-4135-73bd-08d93b2bb6e9
x-ms-traffictypediagnostic: CH2PR01MB5960:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR01MB59605550F4B0F094D544308FF2029@CH2PR01MB5960.prod.exchangelabs.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: niILPTTeT1jdpb79XFarYvP2Oo8k+DJUFjEexl1hhtu/tMB6QcVup9nfY3sCSZExp0wxcKuLQ2zTkSqC/PyNIqv/PPfaEvV5/4pS8m1brguKYIELsuC/mjCShwCsZOuo1VX10qaDYIIQms7AOsnW07MgmLsQUnPOJVC4HIRvSFSCqmRHvEwFoO4gRnRXkDsq6ouf5C1X78IaFe58VActD1knEdzTuwnIWVhZtnjCcoW5cj4UBcn15bIUwqQfQfdnx2DChRHejN19J1GXmb0H2kGCbKHzqPe23XuSsd9fg/7Zn7dGtbgz93fhclUiA5Yh9UL+WtJ1JFVpzgC4jB8yuOXFDJfsjbdIP7V8upeAuZanpstr6gTmTBco7W49YJGRG2gJMqHGJoQbseLUqk/NQbRIU6GDukSqdT+KcmIbHGx9f/4xx8UTUtdD4+v4eVFCHzvPjTythHrrNuk9ml8x267R3coGyupnL3G5Pb3FROHeWDBwzLMpoyAZT9GLIjmBTZ/wCF0pNEciHaqyLsaAevzhEPPTRsNkFDTLaji/7sW437LFHadeIg0Z+IaDuh4aS7CitRF0La5T+ewvMhzaRztbdYbTwJS3aCLkKDN8unl5BryQQrfBhXZ5UIOTXQn0eyBxjMQKqjqckAnbGJiXtQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR01MB7153.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(4636009)(39840400004)(376002)(346002)(136003)(366004)(396003)(8676002)(8936002)(83380400001)(33656002)(478600001)(71200400001)(66946007)(2906002)(26005)(186003)(122000001)(6506007)(7696005)(38100700002)(6916009)(9686003)(316002)(66476007)(64756008)(54906003)(86362001)(76116006)(4326008)(66556008)(66446008)(5660300002)(55016002)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?IziGOlzbZHheKn6D5HzpLPw648Z51aBXI53ANYDglVrNpb9TjKv5mAiGOM09?=
 =?us-ascii?Q?FwcI9HAMLLIzjG8nwAsz5UVXjBbKrM5kBjFPwpjOfKpa1HmN+Z93+nRSIWpq?=
 =?us-ascii?Q?X9uUgeBrL5kIJ8NJ9uuuX4M+aynTLqkc7EoHy0v+tMgM3cUzm6pJA5fKT/Zi?=
 =?us-ascii?Q?3VfmWZfqOdjr+PoM7g5XPjICLepz1yK/d3Giv6r0gmeKZuBQ7jLsXlvddMFM?=
 =?us-ascii?Q?jsUnjCEutO5zKdLaAa17ckXc+fD7jjhb7E7W9Q8dEh1GLnkLz96lRCl9Ahoi?=
 =?us-ascii?Q?UP5JQ3cQoQ3L1QEJ7WfWZhx3Nf/tLy+nI67Wk3SYj75189b0/KVQX/Vrmt9b?=
 =?us-ascii?Q?C3kAiuJk/1ekEMPaVcl0Esk0nIbqgSOUIgA6VuegKCVJ8eCP27tI9NZnOacx?=
 =?us-ascii?Q?J2BHEh1arP3rcQtotOsdBoKeEg9CvShLkbzILMGmiopQPjN6s/GWM/VbgcC/?=
 =?us-ascii?Q?Ktlj65HvYAmtenark25KNTT7UDWGZo8qv1n5O5Gk/cQeZ/manV08cqOVQkLt?=
 =?us-ascii?Q?qYJofsgJyE5bfNBmmpjNsd+ctpwwlJaXah/NBRc2Z2HEsW3GjW+nHlatGQ9o?=
 =?us-ascii?Q?mxhN0AWz/aNiad3Cn+LjlCHBT5KOAArwsqG3hsBsn/EWweMuBVBAirZ0RhXL?=
 =?us-ascii?Q?1mNCe+LhwMlGafAU4EvcF3D+yEfQm9KUs7hGYmQpcAvj5u4lorQ1If4bHS9K?=
 =?us-ascii?Q?0VwK/mKfQrjs0BibcO757I6sNeVNPl7t7B6br7KLARuMlua2gIyovuLdxHhQ?=
 =?us-ascii?Q?JVdyhOmkaTNvDwYGON6Wr08vCV6OiHQraJ67cKphKK4yjOjpbF1tOvG2nVUz?=
 =?us-ascii?Q?E9Dn2xwENMwBHD30AVMntJo+O1LtehxgkhXr7jM0BFaX/FdlBId9t8f5XT9N?=
 =?us-ascii?Q?YCQJK9aBIH73b63CfeL8ff5H4hn4zvwkQ2dG1Q5IK1RQQxXw9kJ9Jr32/Hub?=
 =?us-ascii?Q?XQ8ntpFTuJhxBist2E2c3/SyKuy36zJZydEsJIeTNzToR5qUUQTECggaB5B0?=
 =?us-ascii?Q?9cmI9nnXz1Cgcdq2dyQiakDg8kWC82AcCAoNl6ob3QyDgRsKRYYdWJscjJ3x?=
 =?us-ascii?Q?xgZCpYQcjrsaLwnxJm66/lyYggcjcvK5Cm/tzS+iLOpJi38H12uf22RoVs0H?=
 =?us-ascii?Q?Iqe6INL5Ys90ByDDo7uR8TpPJk5OWNPiirPQKzcuX7xP1WukDBxRSx7CRNot?=
 =?us-ascii?Q?0bPAH+ALzcQDPg4ZStJoaoAKHQ0CaTq2idNdtlflXNuP0UpSKFzO1bqq9cFe?=
 =?us-ascii?Q?2EVLQAAwLyMrdo7Royodz/5n/ojFw/Al9iWHZHrO1ndMh6XHExqAccxs4Yh2?=
 =?us-ascii?Q?JC0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR01MB7153.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f147a7d-c126-4135-73bd-08d93b2bb6e9
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2021 18:28:38.6258
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yjnBzYWe5W4OziABXIROxVHmCntNfjnZHcbCDhiJNCrK/ZXq4GGCOx3h8I7d+DY1dgQwGv0nIeOrkh3B4aK5p1aXo7/XFVSPgejwlSFbdZ5qgLVorm0+pK3y2dnqGv/7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR01MB5960
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

During our continuous integration testing on 5.13.0 kernel our testing trip=
s on NFS testing with the following trace on the client:

[32936.156848] INFO: task kworker/9:1:519 blocked for more than 122 seconds=
.
[32936.165201]       Tainted: G S                5.13.0 #1
[32936.171562] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables =
this message.
[32936.180773] task:kworker/9:1     state:D stack:    0 pid:  519 ppid:    =
 2 flags:0x00004000
[32936.190565] Workqueue: events xprt_destroy_cb [sunrpc]
[32936.196854] Call Trace:
[32936.200107]  __schedule+0x38e/0x8b0
[32936.204482]  schedule+0x3c/0xa0
[32936.208464]  schedule_timeout+0x215/0x2b0
[32936.213401]  ? check_preempt_curr+0x3f/0x70
[32936.218518]  ? ttwu_do_wakeup+0x17/0x140
[32936.223336]  wait_for_completion+0x98/0xf0
[32936.228396]  __flush_work+0x128/0x1e0
[32936.232942]  ? worker_attach_to_pool+0xb0/0xb0
[32936.238351]  ? work_busy+0x80/0x80
[32936.242555]  __cancel_work_timer+0x110/0x1a0
[32936.247726]  ? xprt_rdma_bc_destroy+0xc6/0xe0 [rpcrdma]
[32936.254034]  xprt_rdma_destroy+0x15/0x50 [rpcrdma]
[32936.259873]  process_one_work+0x1cb/0x360
[32936.264788]  ? process_one_work+0x360/0x360
[32936.269915]  worker_thread+0x30/0x370
[32936.274436]  ? process_one_work+0x360/0x360
[32936.279526]  kthread+0x116/0x130
[32936.283534]  ? __kthread_cancel_work+0x40/0x40
[32936.288924]  ret_from_fork+0x22/0x30

The same tests and same servers see no such issue from rc4 to rc7, so the f=
ailure seems new.

Any thoughts?

I'm currently rerunning rc7 just to be sure.

Mike
External recipient
