Return-Path: <linux-nfs+bounces-20042-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iCd5DsN5sWk2vgIAu9opvQ
	(envelope-from <linux-nfs+bounces-20042-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 11 Mar 2026 15:18:43 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 873732653CD
	for <lists+linux-nfs@lfdr.de>; Wed, 11 Mar 2026 15:18:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D1E233032071
	for <lists+linux-nfs@lfdr.de>; Wed, 11 Mar 2026 14:18:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34C34366563;
	Wed, 11 Mar 2026 14:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="O2ID7xgk"
X-Original-To: linux-nfs@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11023106.outbound.protection.outlook.com [40.93.201.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A31931AAAF;
	Wed, 11 Mar 2026 14:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.106
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773238704; cv=fail; b=VZereml+DM1tXyy+0bfJN7EpPJoxQ6ez2olwsX4LiQD8vuNLXCttG/MaZb3jI1zk+dIC9d02h+IfoF5qmQGVgStMcFaTHZw0AaEaxSmKNq+EmHORGjDe+JPK2yNZzkjuD9XbYLI7H+tx3pyZ6RyDWiCTMGcvaYhKnM38XOeT/5k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773238704; c=relaxed/simple;
	bh=Bw+asLwkeaJuvhfwvcjrwMo5CuDAM2lIVbHrKFyXNts=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sSIfvoTCeUzUQFww0Onxk0VWDUaQfl53O17CEXTuATlO2BCxW5E6DZDRij3OzHPLcnKs2czGd3l85gPeZyiw/pKbHdJqbYMLWZU2q027BnHQiG0Co2ctTVf1T96BmA5QPdkC5F7gx8N3GS9Tss075tddxEX4OOb1P5DYDdVs/Mk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=O2ID7xgk; arc=fail smtp.client-ip=40.93.201.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ktsn5ce7V0UPAKmGS2oi8Rcaa9lyBwguTLp9YtAJZdM3GU54ergROxiSWUzNH828qKYmn9DuVazoGOsDq/HqH2+iYP5Rxw3FsyYKQ2FEbGk8tXhNDTK3i7DJLGzDVgoqeH8UcKsYEM2UjCKUdXqyYpo5YHT8VCkfQeNWOtmuVoGxhBz+lwr8O/YQoIbdEnAloNlbMt1l8tCkxVPItvDi3OtnIokPMW9pEm8zlR8io+L9I7yvzPc2pMNetn+rkMlyqArTPY1dDj2m3rtUFdj7GLxeT3DOfTXh/SEdTwWLx6v6MDQRFdPsIyerB1jz1UBSZgzJKXHdRPzAErojsC+Gaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RfJJk4JtfviFSY+rRXxemH8qBEIYQEKCGiPUO7KUy6M=;
 b=XanUjFgLejFy9jKjEiaswwlttOsFbHU27m0hDO5+pgA4hOQBogZVy/B3AM2EAflsrW5KmY4uC5BD+K39U3q3jVZH0ZHZNcGXbUi74RD71jQt0xnRaLeRtLhjkQXVCRfDo/iudVjwD2apDwJ/WB8fj55DCSBVKeH2ARRqnKayTuFV/K0iZiavDAaaVsBdrG/3xCotrSLXRDmxyasXbl6ESPob7M8UcbDQ3ig5k14hOP8KaSmwDTxpV5yl7rbk757MuZXK11JJ9arZ8xTs6BBMoLEsadFSJmPqlaMcG0XYyAjrzNOH7xFKMnNefKS3o3bxiLR4oterwXf4eiW3NbdLxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RfJJk4JtfviFSY+rRXxemH8qBEIYQEKCGiPUO7KUy6M=;
 b=O2ID7xgkZ2vnO/0qN0rxmE+aHPZuydwt+cpsTbLkdHnDCq/EFH29J/FcxRYdb20gj8WgRqSd5734A18f94JQAwHQzRiZ2iI5Yurj0salVFoDjGYQGeXRLwrqc7tOMN1NqO4jU6MWcASMachubJn3Tm7hBm3bS1nl6A5csV3wQlg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
Received: from DM8PR13MB5239.namprd13.prod.outlook.com (2603:10b6:5:314::5) by
 SN4PR13MB5328.namprd13.prod.outlook.com (2603:10b6:806:20b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.13; Wed, 11 Mar
 2026 14:18:17 +0000
Received: from DM8PR13MB5239.namprd13.prod.outlook.com
 ([fe80::fa6e:7b5:d1ec:92f3]) by DM8PR13MB5239.namprd13.prod.outlook.com
 ([fe80::fa6e:7b5:d1ec:92f3%4]) with mapi id 15.20.9700.010; Wed, 11 Mar 2026
 14:18:16 +0000
From: Benjamin Coddington <bcodding@hammerspace.com>
To: bsdhenrymartin@gmail.com, Chuck Lever <cel@kernel.org>,
 Trond Myklebust <trondmy@kernel.org>
Cc: linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>,
 Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>,
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>,
 Tom Talpey <tom@talpey.com>, Anna Schumaker <anna@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] sunrpc: fix TLS connect_worker rpc_clnt lifetime UAF
Date: Wed, 11 Mar 2026 10:18:09 -0400
X-Mailer: MailMate (2.0r6272)
Message-ID: <FEF1FBB7-B82A-4A71-8F25-689EB5CD8F41@hammerspace.com>
In-Reply-To: <20260309112041.1336519-1-bsdhenrymartin@gmail.com>
References: <20260309112041.1336519-1-bsdhenrymartin@gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BYAPR02CA0066.namprd02.prod.outlook.com
 (2603:10b6:a03:54::43) To DM8PR13MB5239.namprd13.prod.outlook.com
 (2603:10b6:5:314::5)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR13MB5239:EE_|SN4PR13MB5328:EE_
X-MS-Office365-Filtering-Correlation-Id: e52ed575-e36d-4d05-74b4-08de7f790945
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|55112099003|7053199007|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	v9SN1+IM/TNLd6Jwuuj5kqxBYiQMh3OfJRKQmiH2lv7BF8wfqrMo/FTSzFeaffRAFZ0MJsgvCq5ufZJnMjWM2Yi8KpiHl0577fti87Z5kPWVwfwtb6qbv2CBcUtVqwZ+PKP+EV2opU8OZRXh3dn6bbpNrw+azQB3zzI9BIXZ9+khd3JFttRi+uaYRgbDmbi+XMm+zyxSJqHvpAEVMtBVETy4t0XW6Ynv0ws+SQcS4ouPzoPtd4qRPRfZsiEfxGBBlFz9NBmzlNz+dyd2EtbKRTu2dYZtX4OMzG71Av5vnH2/Ow+oLCBlqjOH7oF6Rvx6BINu4MbgRQUmFPdF/PT4DpJcbzdGD71hMCIXdOsw1X5EhSnGxKiEpO67ZSNE17p4Tf6paqkF+xqNq37x0yO4pIImiudTA9Y5S4hSsW7mvFeCxBAaePWffaZ8o5ZIGIOAwjkm4IaX26RUfymjt3JFuw4QjYtjS6x95jZiCGeDg0kmW0Ha9ggmz3YDgBBB5z1a291BD7pv+sCvqk0LELXxbL8PfaYDCV+Ye5MQ89Gc+TN2YqjShGN843qFoI2R2iOS/7t8MSiAgdolZ1kVy86lUwUhorvwbrQ1/YBAKZQTARWEx0uKqQXYkJpkO/x8Xid7OI2Hw5ALqU7D0s0SXsfxOoaCyXtNkc+tp4tl8lM9F+9re/6E4tIrZ+7tgsdBmk6j9GtQ2SO5omJlBxgoqbGieB8uH1Im2O8+jTnnbkgMi9M=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR13MB5239.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(55112099003)(7053199007)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZBUWacWVsILT9GtfoiGWWuz7nsPnJNvZAQ04uIA+BmOywdaidZ73TcQdPFoA?=
 =?us-ascii?Q?lKEZ2U5TjcoKa43h19C26jrwwvsVp2lKcgj30fgf/3RPbvPLkfldACnSqXaJ?=
 =?us-ascii?Q?mRIi4T3QY2tO967yAfkAcqNuqWeyXAh8NnnNw1U4cDYXoZxIhFe4V5a3iesE?=
 =?us-ascii?Q?1XdZDX1lnoMlv0fLhMSPMsF1fYe3G4mhwdn7wV+Y+elnWCsjueoJ8wZv0NNc?=
 =?us-ascii?Q?1z94MADTk2Rm1L7D3cjZv35F6iOSUqzsaziHU+03kImnx3csLMZN8und1776?=
 =?us-ascii?Q?GO1eoNGJYAL6IyWcNNCe0YMZkMLerRI1MNUOKA5Aj8kUdSkz39btk4unFeOr?=
 =?us-ascii?Q?uVEARJaBmstsmpWZGQK0DeNKUV+GCfvfJfL2yRsK9PW4I3uW09BUqqtqzECI?=
 =?us-ascii?Q?ICTLDCT2Z6uTcz5u3fFPjnQVkDrgQedzmpo5PoX0oGB7GlsumUHVTf+lUd6Y?=
 =?us-ascii?Q?hSBIX9n7R+7UVEEfClUxIGIXee//FmEqauAVTETnWH8JfCPEyLszBiO/yA8D?=
 =?us-ascii?Q?OR4rSjqoLByS+ImWfGC/138907Nh7gP6FeiyLLbLxDDm2alUkt7yTKnlwK67?=
 =?us-ascii?Q?vpq88Zei8T4JbUux6cYpQuNnU6VyIGLVfGpa1OoXsnTIURb0FAANYNf0hkg5?=
 =?us-ascii?Q?qSc7edazYHXMLlvmPEdVwnxqF/hQN9QE8WHcQlFYzjLUoBFq77w8Z6O2yi8S?=
 =?us-ascii?Q?pPVOJz/njyMqYVLedRSgJcyFPGFn4HYUe571KVN/QzlMeRVtMXRevd4QLQA4?=
 =?us-ascii?Q?sa7o/dEpRTzbLz6JZ+O+QKKE5/TROMRNmOSClVJS/QQpjczgvgr8/q7W4xh3?=
 =?us-ascii?Q?GhlrJIL6/+BkKVFrbEFqHbH+T7bXG7v81+bJXd+Aic2X2zR+poN930jsUn5r?=
 =?us-ascii?Q?jsg+27uzEAtMBXAuPVt8tCxW47mhDDYkMdC+9hNFVcZ5ZCuegX02GOZMR57W?=
 =?us-ascii?Q?5rmn6lCjdMN3tU84XKzSIh/kYsrg+N4seWNljMSa5sJ4S/PTb2vX9pN6CKGr?=
 =?us-ascii?Q?lVpX7z/I+vrqVpWtXKB6nF7l2nSOQnpPyItjSrxU8PbRdageOpUAOWZr3Zvc?=
 =?us-ascii?Q?pIl4K2/gay/G87JUeViZLpUvhtXjlugSziY6WujuooSEcorWmuo97Y1nMemK?=
 =?us-ascii?Q?1vr/E5SV6OSfRacg2nrWdOGb44qigllv5GK0IGHgQvdN4lZRUtI4f/rlXYLJ?=
 =?us-ascii?Q?DlbUouqft05IBd+mcsL58cCnwvfZ4dkCYMcmq+hUuajF7x7SHZDwGe5ex97l?=
 =?us-ascii?Q?YJzMAgTuBq91v6E1ws6JD3TdmhfV/Kae0Ir0JZ0wYVvIFhV6Iu88Fu1SKmxy?=
 =?us-ascii?Q?S7iwf35s2vx/vztN9sQPGoUK1oCIUbVhnihw9T03Y7I4lU/m+jsPCcfLEeC1?=
 =?us-ascii?Q?dfrq8HwT9UzBnWObIh/1gUT5duZq0x1rfwFugC3dkOnvKbjLv7r8mFO5aQXJ?=
 =?us-ascii?Q?QvOSUJvqEBiQ/67gLK3m5RvrlFTzv3NJmQvfiYmMbmq4phCaqLb/mmERLbt1?=
 =?us-ascii?Q?FXgupREahsPQc6rFYyaq+Ynyi1jcJme4ggW2DyvvquV3BKTSQLevtn8D9kyB?=
 =?us-ascii?Q?Q/svgeFwBUq4crzZwPhTlMyO6+gxuU6QcvZrqYNzBXj/sQ5om2di94PZO8y0?=
 =?us-ascii?Q?hYk/2spYL0a7tbDvU9SNyg0cbGTHMIBoABsofn1VwnTg1QwcUj7YQ+wEkhTE?=
 =?us-ascii?Q?rjh5zzTzaik6atcceBoXgoP1HYzUcypnMmUijDCEWHvzlaOpSk9QYTDOukv5?=
 =?us-ascii?Q?pH2ymLm6TY4fGDmllzFngubAt+Fzl/Q=3D?=
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e52ed575-e36d-4d05-74b4-08de7f790945
X-MS-Exchange-CrossTenant-AuthSource: DM8PR13MB5239.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2026 14:18:16.1763
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gnEGAS6zM/suimVKHlnwm/Zz4K9/EWOO5ILMf8ZpfE5B1MTd9kKpN0y8+UG1cQtzcdGHBCT/f9HVoDHtg10PP8/8gzjvAI5LaqtBgaRndm8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR13MB5328
X-Rspamd-Queue-Id: 873732653CD
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[hammerspace.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[hammerspace.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[19];
	TAGGED_FROM(0.00)[bounces-20042-lists,linux-nfs=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org];
	DKIM_TRACE(0.00)[hammerspace.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bcodding@hammerspace.com,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	REDIRECTOR_URL(0.00)[aka.ms];
	TAGGED_RCPT(0.00)[linux-nfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[aka.ms:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On 9 Mar 2026, at 7:19, bsdhenrymartin@gmail.com wrote:

> [You don't often get email from bsdhenrymartin@gmail.com. Learn why thi=
s is important at https://aka.ms/LearnAboutSenderIdentification ]
>
> From: Henry Martin <bsdhenrymartin@gmail.com>
>
> In xs_connect(), transport->clnt is assigned from task->tk_client
> without taking a reference when a TLS connect worker is queued.
>
> If the RPC task finishes before connect_worker runs, tk_client can be
> released and its cl_cred can be freed. Later, xs_tcp_tls_setup_socket()=

> dereferences upper_clnt->cl_cred and passes it to rpc_create(), where
> rpc_new_client() calls get_cred() and triggers a slab-use-after-free.
>
> [   93.358371] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [   93.359597] BUG: KASAN: slab-use-after-free in rpc_new_client+0x387/=
0xdcc
> [   93.360748] Write of size 4 at addr ffff88810d67bfa8 by task kworker=
/u4:4/44
> [   93.361919]
> [   93.362225] CPU: 0 UID: 0 PID: 44 Comm: kworker/u4:4 Tainted: G     =
            N  7.0.0-rc3 #2 PREEMPT(full)
> [   93.362297] Tainted: [N]=3DTEST
> [   93.362313] Hardware name: QEMU Ubuntu 24.04 PC (i440FX + PIIX, 1996=
), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
> [   93.362348] Workqueue: xprtiod xs_tcp_tls_setup_socket
> [   93.362433] Call Trace:
> [   93.362447]  <TASK>
> [   93.362462]  dump_stack_lvl+0xad/0xf9
> [   93.362513]  ? rpc_new_client+0x387/0xdcc
> [   93.362574]  print_report+0x171/0x4d6
> [   93.362653]  ? __virt_addr_valid+0x353/0x364
> [   93.362719]  ? srso_alias_return_thunk+0x5/0xfbef5
> [   93.362784]  ? kmem_cache_debug_flags+0x11/0x26
> [   93.362839]  ? srso_alias_return_thunk+0x5/0xfbef5
> [   93.362913]  ? srso_alias_return_thunk+0x5/0xfbef5
> [   93.362978]  ? kasan_complete_mode_report_info+0x1c2/0x1d1
> [   93.363057]  ? rpc_new_client+0x387/0xdcc
> [   93.363122]  kasan_report+0xb3/0xe2
> [   93.363202]  ? rpc_new_client+0x387/0xdcc
> [   93.363266]  __asan_report_store4_noabort+0x1b/0x21
> [   93.363339]  rpc_new_client+0x387/0xdcc
> [   93.363399]  ? __sanitizer_cov_trace_pc+0x24/0x5a
> [   93.363451]  rpc_create_xprt+0x1ac/0x3b4
> [   93.363519]  rpc_create+0x5f9/0x703
> [   93.363588]  ? __pfx_rpc_create+0x10/0x10
> [   93.363654]  ? __sanitizer_cov_trace_pc+0x24/0x5a
> [   93.363706]  ? __pfx_default_wake_function+0x10/0x10
> [   93.363808]  ? __dequeue_entity+0x5d2/0x6c3
> [   93.363887]  ? srso_alias_return_thunk+0x5/0xfbef5
> [   93.363952]  ? srso_alias_return_thunk+0x5/0xfbef5
> [   93.364016]  ? write_comp_data+0x2e/0x8e
> [   93.364063]  xs_tcp_tls_setup_socket+0x476/0xff0
> [   93.364151]  ? srso_alias_return_thunk+0x5/0xfbef5
> [   93.364217]  ? __pfx_xs_tcp_tls_setup_socket+0x10/0x10
> [   93.364315]  ? srso_alias_return_thunk+0x5/0xfbef5
> [   93.364386]  ? __kasan_check_write+0x18/0x1e
> [   93.364468]  ? srso_alias_return_thunk+0x5/0xfbef5
> [   93.364540]  ? set_work_data+0x70/0x9c
> [   93.364603]  process_scheduled_works+0x66c/0xa15
> [   93.364699]  ? __sanitizer_cov_trace_pc+0x24/0x5a
> [   93.364763]  worker_thread+0x440/0x547
> [   93.364867]  ? srso_alias_return_thunk+0x5/0xfbef5
> [   93.364937]  ? __pfx_worker_thread+0x10/0x10
> [   93.365024]  kthread+0x375/0x38a
> [   93.365097]  ? __pfx_kthread+0x10/0x10
> [   93.365185]  ret_from_fork+0xa8/0x872
> [   93.365247]  ? __pfx_ret_from_fork+0x10/0x10
> [   93.365309]  ? __sanitizer_cov_trace_pc+0x24/0x5a
> [   93.365364]  ? srso_alias_return_thunk+0x5/0xfbef5
> [   93.365428]  ? __switch_to+0xc44/0xc5a
> [   93.365509]  ? __pfx_kthread+0x10/0x10
> [   93.365593]  ret_from_fork_asm+0x1a/0x30
> [   93.365684]  </TASK>
> [   93.365701]
> [   93.405276] Allocated by task 392:
> [   93.405852]  kasan_save_stack+0x3c/0x5e
> [   93.406581]  kasan_save_track+0x18/0x32
> [   93.407230]  kasan_save_alloc_info+0x3b/0x49
> [   93.407932]  __kasan_slab_alloc+0x52/0x62
> [   93.408606]  kmem_cache_alloc_noprof+0x266/0x304
> [   93.409359]  prepare_creds+0x32/0x338
> [   93.409965]  copy_creds+0x188/0x425
> [   93.410545]  copy_process+0x1022/0x5320
> [   93.411208]  kernel_clone+0x23d/0x61a
> [   93.411870]  __do_sys_clone+0xf8/0x139
> [   93.412530]  __x64_sys_clone+0xde/0xed
> [   93.413192]  x64_sys_call+0x33f/0x2105
> [   93.413883]  do_syscall_64+0x1b3/0x420
> [   93.414588]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> [   93.416895]
> [   93.417169] Freed by task 396:
> [   93.417673]  kasan_save_stack+0x3c/0x5e
> [   93.418321]  kasan_save_track+0x18/0x32
> [   93.418972]  kasan_save_free_info+0x43/0x52
> [   93.419652]  poison_slab_object+0x33/0x3c
> [   93.420315]  __kasan_slab_free+0x25/0x4a
> [   93.420973]  kmem_cache_free+0x1e5/0x2e4
> [   93.421616]  put_cred_rcu+0x2e7/0x2f4
> [   93.422219]  rcu_do_batch+0x5b6/0xa82
> [   93.422833]  rcu_core+0x264/0x298
> [   93.423475]  rcu_core_si+0x12/0x18
> [   93.424086]  handle_softirqs+0x21c/0x488
> [   93.424750]  __do_softirq+0x14/0x1a
> [   93.425346]
> [   93.425612] Last potentially related work creation:
> [   93.426358]  kasan_save_stack+0x3c/0x5e
> [   93.427024]  kasan_record_aux_stack+0x92/0x9e
> [   93.427739]  call_rcu+0xe4/0xb2b
> [   93.428337]  __put_cred+0x13e/0x14c
> [   93.428937]  put_cred_many+0x50/0x5e
> [   93.429530]  exit_creds+0x95/0xbc
> [   93.430099]  __put_task_struct+0x173/0x26a
> [   93.430770]  __put_task_struct_rcu_cb+0x22/0x29
> [   93.431513]  rcu_do_batch+0x5b6/0xa82
> [   93.432144]  rcu_core+0x264/0x298
> [   93.432737]  rcu_core_si+0x12/0x18
> [   93.433345]  handle_softirqs+0x21c/0x488
> [   93.434030]  __do_softirq+0x14/0x1a
> [   93.434632]
> [   93.434910] The buggy address belongs to the object at ffff88810d67b=
f00
> [   93.434910]  which belongs to the cache cred of size 184
> [   93.436720] The buggy address is located 168 bytes inside of
> [   93.436720]  freed 184-byte region [ffff88810d67bf00, ffff88810d67bf=
b8)
> [   93.438582]
> [   93.438868] The buggy address belongs to the physical page:
> [   93.439734] page: refcount:0 mapcount:0 mapping:0000000000000000 ind=
ex:0x0 pfn:0x10d67b
> [   93.440982] memcg:ffff88810d67b0c9
> [   93.441546] flags: 0x200000000000000(node=3D0|zone=3D2)
> [   93.442327] page_type: f5(slab)
> [   93.442878] raw: 0200000000000000 ffff88810088d140 dead000000000122 =
0000000000000000
> [   93.444091] raw: 0000000000000000 0000010000100010 00000000f5000000 =
ffff88810d67b0c9
> [   93.445365] page dumped because: kasan: bad access detected
> [   93.446334]
> [   93.446638] Memory state around the buggy address:
> [   93.447505]  ffff88810d67be80: 00 00 00 00 00 00 00 fc fc fc fc fc f=
c fc fc fc
> [   93.448748]  ffff88810d67bf00: fa fb fb fb fb fb fb fb fb fb fb fb f=
b fb fb fb
> [   93.449973] >ffff88810d67bf80: fb fb fb fb fb fb fb fc fc fc fc fc f=
c fc fc fc
> [   93.451147]                                   ^
> [   93.452039]  ffff88810d67c000: fa fb fb fb fb fb fb fb fb fb fb fb f=
b fb fb fb
> [   93.453227]  ffff88810d67c080: fb fb fb fb fb fb fb fb fb fb fb fb f=
b fc fc fc
> [   93.454455] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [   93.577640] Disabling lock debugging due to kernel taint
> [ 1206.114037] kworker/u4:1 (26) used greatest stack depth: 24168 bytes=
 left
>
> Fix this by taking a client reference when queuing a TLS connect worker=

> and dropping that reference when the worker exits. Also release any
> still-pinned client in xs_destroy() after cancel_delayed_work_sync() to=

> cover the case where queued work is canceled before execution.
>
> Fixes: 75eb6af7acdf ("SUNRPC: Add a TCP-with-TLS RPC transport class")
> Cc: stable@vger.kernel.org # 6.5+
> Signed-off-by: Henry Martin <bsdhenrymartin@gmail.com>

Hey Henry - nice catch.  This fixes crashes where the kernel's cred kmem
cache was getting corrupted due to the UAF - we saw the slab's freelist
pointer getting overwritten.  We didn't have KASAN turned on.  That looke=
d
like this:

[29530.962454] Oops: general protection fault, probably for non-canonical=
 address 0x68a55f8d85dbaee8: 0000 [#1] PREEMPT SMP NOPTI
[29530.963024] CPU: 2 UID: 0 PID: 1134 Comm: systemd-udevd
[29530.963524] Tainted: [O]=3DOOT_MODULE, [E]=3DUNSIGNED_MODULE
[29530.963997] RIP: 0010:kmem_cache_alloc_noprof+0xa1/0x2f0
[29530.964229] Code: de ff 70 48 8b 50 08 48 83 78 10 00 48 8b 38 0f 84 c=
a 01 00 00 48 85 ff 0f 84 c1 01 00 00 41 8b 44 24 28 49 8b 34 24 48 01 f8=
 <48> 8b 18 48 89 c1 49 33 9c 24 b8 00 00 00 48 89 f8 48 0f c9 48 31
[29530.964616] RSP: 0018:ffffd100904efc40 EFLAGS: 00010206
[29530.964808] RAX: 68a55f8d85dbaee8 RBX: 0000000001200000 RCX: 000000000=
0000003
[29530.965000] RDX: 00000000a1e0a002 RSI: 000000000003c9a0 RDI: 68a55f8d8=
5dbae90
[29530.965190] RBP: ffffd100904efc80 R08: 0000000000000001 R09: 000000000=
0000025
[29530.965382] R10: ffffd180a2aa4000 R11: ffffd100904efb3c R12: ffff8d440=
023fb00
[29530.965567] R13: 0000000000000cc0 R14: ffffffff8ed27c4d R15: 000000000=
00000b8
[29530.965756] FS:  00007f290bba9280(0000) GS:ffff8d4b1fb00000(0000) knlG=
S:0000000000000000
[29530.965941] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[29530.966119] CR2: 000055a0fc871dc8 CR3: 000000010531c003 CR4: 000000000=
07706f0
[29530.966311] PKRU: 55555554
[29530.966501] Call Trace:
[29530.966674]  <TASK>
[29530.966843]  ? __lruvec_stat_mod_folio+0x84/0xd0
[29530.967015]  prepare_creds+0x1d/0x290
[29530.967261]  copy_creds+0x30/0x1a0
[29530.967426]  copy_process+0x2c6/0x17e0
[29530.967589]  kernel_clone+0x9e/0x3b0
[29530.967747]  ? syscall_exit_to_user_mode+0x32/0x1b0
[29530.967905]  __do_sys_clone+0x66/0x90
[29530.968060]  do_syscall_64+0x7d/0x160
[29530.968281]  ? __count_memcg_events+0x53/0xf0
[29530.968431]  ? handle_mm_fault+0x245/0x340
[29530.968577]  ? do_user_addr_fault+0x341/0x6b0
[29530.968722]  ? exc_page_fault+0x70/0x160
[29530.968863]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[29530.969002] RIP: 0033:0x7f2909b08143


Tested-by: Benjamin Coddington <bcodding@hammerspace.com>

That said..

> ---
>  net/sunrpc/xprtsock.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/net/sunrpc/xprtsock.c b/net/sunrpc/xprtsock.c
> index 2e1fe6013361..6bf1cf20a86e 100644
> --- a/net/sunrpc/xprtsock.c
> +++ b/net/sunrpc/xprtsock.c
> @@ -1362,6 +1362,10 @@ static void xs_destroy(struct rpc_xprt *xprt)
>         dprintk("RPC:       xs_destroy xprt %p\n", xprt);
>
>         cancel_delayed_work_sync(&transport->connect_worker);
> +       if (transport->clnt !=3D NULL) {
> +               rpc_release_client(transport->clnt);
> +               transport->clnt =3D NULL;
> +       }
>         xs_close(xprt);
>         cancel_work_sync(&transport->recv_worker);
>         cancel_work_sync(&transport->error_worker);
> @@ -2758,6 +2762,8 @@ static void xs_tcp_tls_setup_socket(struct work_s=
truct *work)
>  out_unlock:
>         current_restore_flags(pflags, PF_MEMALLOC);
>         upper_transport->clnt =3D NULL;
> +       if (upper_clnt !=3D NULL)
> +               rpc_release_client(upper_clnt);
>         xprt_unlock_connect(upper_xprt, upper_transport);
>         return;
>
> @@ -2805,7 +2811,11 @@ static void xs_connect(struct rpc_xprt *xprt, st=
ruct rpc_task *task)
>         } else
>                 dprintk("RPC:       xs_connect scheduled xprt %p\n", xp=
rt);
>
> -       transport->clnt =3D task->tk_client;
> +       if (transport->connect_worker.work.func =3D=3D xs_tcp_tls_setup=
_socket) {

^^ .. this seems a bit brittle..

> +               WARN_ON_ONCE(transport->clnt !=3D NULL);
> +               refcount_inc(&task->tk_client->cl_count);
> +               transport->clnt =3D task->tk_client;
> +       }
>         queue_delayed_work(xprtiod_workqueue,
>                         &transport->connect_worker,
>                         delay);

This fix works and I think its great for stable:

Reviewed-by: Benjamin Coddington <bcodding@hammerspace.com>

But I think we ended up with this problem because we're re-using the
rpc_clnt in order to set up the lower_transport, and maybe we don't have =
to
actually mix those layers.

Chuck, Trond - can we use a "dummy" rpc_program to create the lower rpc_c=
lnt,
and keep the lifetime of the original rpc_clnt disconnected from the
sock_xprt?  I can send a patch..

Ben

