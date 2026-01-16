Return-Path: <linux-nfs+bounces-18035-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id ECBDAD3841E
	for <lists+linux-nfs@lfdr.de>; Fri, 16 Jan 2026 19:18:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E9312302AF8E
	for <lists+linux-nfs@lfdr.de>; Fri, 16 Jan 2026 18:18:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6364338906;
	Fri, 16 Jan 2026 18:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="TkheYSH2"
X-Original-To: linux-nfs@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11020136.outbound.protection.outlook.com [52.101.193.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4382E379998
	for <linux-nfs@vger.kernel.org>; Fri, 16 Jan 2026 18:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.136
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768587492; cv=fail; b=M31LCKiSdiJNV4AQkQSwY6g2+yksLXaqLS+1pmqTSu8oauGO39NsRSbebOjx17NC6mZBL/NR9pdNdAJ3Li/cTgbUHmQ4xXimmdLSB5HQl45VwTMJSNC/WgdTbDM66A4eF1xhEv6RYrTkflE8O4x3x2b+1jln3/idgJBsWmpCElQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768587492; c=relaxed/simple;
	bh=AVUqC3OvkYP35LnONjbfBKN3r/Lk5MNUZQF7Q33ajj0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hBXR24XMNCRwKQx+WcDOeIbTpERNbWPBhXcyqaMZK1GRk2sa70uWuF+niqigxJEDG7qBAoLGzvDWEDRbFcJURrsk0RptR+vhYk2Ftsz55lBBP1DoGOHgLtFl+/vZL1L5hpU5D6p/ada6mK+EATk3q2hfnNCKtP/AqcZ7wpNEx+o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=TkheYSH2; arc=fail smtp.client-ip=52.101.193.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HsJrZstU4TMY/MyHuTfzQSPSzc3Egcjd+DmpdxTVzV5pyS/BMk4NThFLnc0rXAlQc1ac4KaaDSh6han4Gfns675IWqoKcoOEyS7UWXS6l9UY5KUI11AclJcpAl6Myj+icrVFVEE6kT+lEph9mGP00agLQ4+5kFvQpfzxuIgteFojNA9Mq9d4/XXB1ekM7n6SUlJRCzc5vX6zXjnk8Vwz3xeO2qW86fZzWatmDhjrA5NZTfPUdb76gIBqsuHRZOUUPU3yoN6MmWMw6z0hfMxM2nekvYlwCMJopEXQ1sUMVFYsX4Z5G4QFDIBCHz5HhbIHpPXQxIi6WQOzbyIFnokTfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kAhex7lF3USBjmoWwEFhADCOPbkMrv0pUqN1S28QJCw=;
 b=g322LSqWhriqrmM2aa64ib4S8aBI8Z/dl7q4vH/Qiocp8cQb0nLAAN26hh1HfzqDv3lwH31gttQsKJZO+a0nrJPIzM+WpQyVZFE+cFn8XaVXyH1jK4h/BiFjnO/ETX//18QQ3NWub30wm4pe/p/usjlA7cHlZ4/tHZe2ZMzzPKd3CpvPd0QzHIS2qJWwDEaQIojPxxpjKJL/ifOCD7jUS/PhqLySl8C9vgoDALaS/SFJ6rZbjyIXATt1N83polW0wlS467seYGnK5RLYn6LN8OAz1v62uF4zWsRLNniTsm+iETosxpVhUK/muEW9NDw67fygDsqvXYeYBjWwdFn1HQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kAhex7lF3USBjmoWwEFhADCOPbkMrv0pUqN1S28QJCw=;
 b=TkheYSH2mcPajvDJ9ZFuAOfHS1bHhjZSHZCZCBZQEKNudyZV6BRvFRdpHFJ9ExJITM8+0F/eZyD0Nikb+1Eh3/4zLedU96wvJ9mzywNVjRBw/1zClTTZtu+hIeSXkOQ+0ZdXPKcoQ59/7dsQVoXpPARgY7mxGBzanxQDzVYmN3U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
Received: from DM8PR13MB5239.namprd13.prod.outlook.com (2603:10b6:5:314::5) by
 IA3PR13MB6935.namprd13.prod.outlook.com (2603:10b6:208:521::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Fri, 16 Jan
 2026 18:18:07 +0000
Received: from DM8PR13MB5239.namprd13.prod.outlook.com
 ([fe80::fa6e:7b5:d1ec:92f3]) by DM8PR13MB5239.namprd13.prod.outlook.com
 ([fe80::fa6e:7b5:d1ec:92f3%4]) with mapi id 15.20.9520.005; Fri, 16 Jan 2026
 18:18:07 +0000
From: Benjamin Coddington <bcodding@hammerspace.com>
To: Steve Dickson <steved@redhat.com>,
	Benjamin Coddington <bcodding@hammerspace.com>
Cc: linux-nfs@vger.kernel.org,
	Chuck Lever <chuck.lever@oracle.com>,
	NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>
Subject: [PATCH v1 2/2] exportfs: Add support for export option sign_fh
Date: Fri, 16 Jan 2026 13:18:03 -0500
Message-ID: <2cff941029aa02d5524ea5afeaff5c65af52adf4.1768586942.git.bcodding@hammerspace.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1768586942.git.bcodding@hammerspace.com>
References: <cover.1768586942.git.bcodding@hammerspace.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN0P222CA0021.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:208:531::28) To DM8PR13MB5239.namprd13.prod.outlook.com
 (2603:10b6:5:314::5)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR13MB5239:EE_|IA3PR13MB6935:EE_
X-MS-Office365-Filtering-Correlation-Id: 79cc9878-ac74-4217-08c2-08de552b991c
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7142099003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DhS9Repu7WlBza2dcb+5HHPca8i9JiaxmdHYjMqk83iO7eCfKA08n0ZqoYi4?=
 =?us-ascii?Q?dUKwziPP0oeFevdkrgCKhVKSrEDre9fB7S62X5E+kC/rhnB7Hf+QxOghDhuX?=
 =?us-ascii?Q?MIRFnoYpdo/aisL73HQ0NlRy/UJ4W8xKWmrRWs6aHsVQ31+wDlOhlTCLS9Oh?=
 =?us-ascii?Q?5QoZghPpxYZPs6u3TUTXdx+v0hcZiSdagLB/55WBk4tHAkQNh82cTY21lWki?=
 =?us-ascii?Q?y1uNirZolx9mVg1ZRPYvio91Qfo/7WsHYB3jID4iX7CdmiVDKTi/lLi1art/?=
 =?us-ascii?Q?ush51YcJuKjZRrC5wJfj/L8UhYh+tmnmJ+2JgWQ7Mb3SI7SdTCyyOfIq15Fv?=
 =?us-ascii?Q?4OZa47SYIi35fMSV1XzN6zpxybY4/zdDeer1y7KV5DDB1aHkWpWaiF4f9SHX?=
 =?us-ascii?Q?DauCVgI/T1s/X5uHrDZXx3CmVrPLAcdOeRsxlyRKsLDKapkD800RC5nAKriZ?=
 =?us-ascii?Q?5xDVJBl5EQ9ckK3PGq3xVqftXqYef8j0VypVGzzRG/GxA9akf3UxXj+jm4Qi?=
 =?us-ascii?Q?NNwu66PJGJTZ+7IM3bU5N9MWPZd24/KMoB4YZc0FAsBHmx22YlHbqYxRdYfA?=
 =?us-ascii?Q?x21H2frivG55mSZojjYXBnhC3kcoa0t3wzCXFofMTgSCOmlHVm9IQWfOJrkv?=
 =?us-ascii?Q?DgjtNtGMbvKSzKGFDc8X/uogEzOACUv5vzbbhVwSF8bxyi4vgx7SGNJgzpmF?=
 =?us-ascii?Q?9ck6tnyjLK4mSSMVw9G12J5YBztTrSZwNr8jNLq6G2H2kkT1Tm6RcsTbYMEF?=
 =?us-ascii?Q?DI3F7igBcfMSsMpCaCSJmLolkuZMUiKbpX6N74thD6bPj8Nbic60jliOG9TN?=
 =?us-ascii?Q?5Ox3g3tWWhr/cCRB1C82G3nHXaJaR6JuGn5icL4iZYRM67XVesG3a8VbvLAS?=
 =?us-ascii?Q?zL9B5J8D0D0HDL8I9uPJURewuA+eU44nI4jULP8eS2dMck3x7fJXxFs/G1/c?=
 =?us-ascii?Q?iCVGDgIcMBKyQ4TJIy+KUZw39npjiiGb95Jwsk6/DJHxw4lMrj1NyDHkUPKf?=
 =?us-ascii?Q?WrVbvX5usfgf3WfKdkZ68BSau+EQtutYXpd8Pv5jsN+3dtoWPkvFOTjt5Ha7?=
 =?us-ascii?Q?8XAgu3iJKJ3YaI6n6W4U7frrHJbtD9boKBhfWg4RbB4r2FR62Kcp2E0hmKu8?=
 =?us-ascii?Q?NW71rW4ooPk6I5V6sYOVc417Ej0UKPjnGs2cwLys+haNBGHj6BvPiUud5eGj?=
 =?us-ascii?Q?C4TWciSE7Jp1JWjdZtc4XMtTA42GrRHs9VSubLzrjTh8UcXGb+5w66EOHL9M?=
 =?us-ascii?Q?Zay8RmGbvvgUM+8Lo8Zk+2qC6nxBTpGByQvFUyoyx5ck2RUGFRYxpagHIs+P?=
 =?us-ascii?Q?ZGFZs2Y6tRvjPUncG7DTcw+PGRnrFFUm0mZebmGHP5u1Pu0rlUi29S17eLCn?=
 =?us-ascii?Q?Jtu7HJBBbZVTI52REepN1L0ziOUQpw0I9AzvEQZB4UAHZr9sozJLTp8p4pkl?=
 =?us-ascii?Q?6iF2BEr4bd73LU9DcFggmeN4bgOmolmJdyIxnGQY04YeQOzmqtO0/4HX0xcC?=
 =?us-ascii?Q?MDC8/lPpYQnWvJaOoSx3nE1CBZevg99hu7RJxEHIxJ+J4i5/N6U+RM8jL1yV?=
 =?us-ascii?Q?4NxYitPLiAsmY+4dgXA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR13MB5239.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7142099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TLi88RLWNwn29EfMJ3vGc9vQ8cB2sGFUFRKxLbS2vu2W3OUKPdit6q5i8pxt?=
 =?us-ascii?Q?TK9ZYE6eZLNraXliAnwxeR1pzDqgfhCdBURm7fhGjqnS7ekbtj9tuJ2lduIa?=
 =?us-ascii?Q?PMHYKjO9ls9QXourBa90HEuwPxltS2wbphqPDG1lfFIQE9VKRKAoSLksntPt?=
 =?us-ascii?Q?bOZG8BxjByKaMwMt2kBPdBHcJQ1j867cAb/fy/nXPTXrlq7kdY2ivBJsLvC/?=
 =?us-ascii?Q?TzkXDPqx8j/h0p3EJx0J/F7RQurCi7DQkzlGtemzcNM2tdPu66EAKOFA8hu9?=
 =?us-ascii?Q?pZefQK5Y6e0UmHqDBVzPMqTX2irm0WwXMGHBu+2p1rEv2Dk1O7hLfncg+H9j?=
 =?us-ascii?Q?4nRIZN24xYOaMClWiQZ5Q1F9hlKui5O6ejLBxLOsuPYHx+VMHEpOorQK4wfJ?=
 =?us-ascii?Q?E6Dx/3df6dfAlXFnsRr+D++m3GfojOSAFFtvYT/nVoJ/u1f5QFOqvK+iIDcX?=
 =?us-ascii?Q?kdLrP4V19TMGjYYkuE3PIBKrrzvewIB1LrKj2r7smOTLObSOtrY7/hhEd9wI?=
 =?us-ascii?Q?yp0LKrMiBwnbtDfSx6pQk1TeG5gvmc20lhySuxkdukpZerbZXdTgF7B7W65+?=
 =?us-ascii?Q?lIrZUp/ilUBEAHESV15DI7hiCC8HxourN8/Oh3504SN8Vgk1IWjl4DlQWofw?=
 =?us-ascii?Q?ZjH+/IBh6ZUO94h0S4ZEDCFiRLhZpMKKesAJLQtKz9ffAGRvL1kA3Ctsy14X?=
 =?us-ascii?Q?fp9K/8DDTMhYJRHWsffbTKQ/zJcO0ebERIPwt+qFL5hcdTqtkwAyUwo3Opko?=
 =?us-ascii?Q?AzHuCA7kZBYYxi3dyc6vZq5iVt0Q+KMk0imd3Cjo7WM8gBemmkc7bCmdUzym?=
 =?us-ascii?Q?Gb1J13CjKXnvXW1EMO3gMOXLlIaCR4PlxEwCFzet1D0Yq24he1DZMZTdTb/w?=
 =?us-ascii?Q?+xjAWXUq/dwYVCxL2jwqlwPacN69RUXg85u1LVi62VqdPJGwojn6QtGii8pc?=
 =?us-ascii?Q?1/2FcM6+8TkhG9z9+0iyI0cWuXXyNL8dbI+KsXAMOJUFJ4W8uKQkKdSs/RST?=
 =?us-ascii?Q?0yvD6JeRQZpGvI23K/3PawZnN1sqXxyjK46TYPzaNknF7lD0qQLt9i3PRelr?=
 =?us-ascii?Q?4f95o9gtkco24WUR7DUWhvy4h9atHhUDnmCSDGexCj+9KdlyLpzBCvBqst9k?=
 =?us-ascii?Q?HwApi5PREGSZcI79dl17EdTxaYQDGJJWu2uOlYALm9ypLWNBKtFke2j+ocQN?=
 =?us-ascii?Q?i4QKDd0Itm2bO6Ns7Pnu9gZlKG8h5yxkgSSNeTj78PeXSHnZw1C7bM6bcq45?=
 =?us-ascii?Q?SUpAdpSRkyHLMdS7gdvBz8eguNasHQTbyvwoM40SsH13IVi3DRl9rBp+JmaZ?=
 =?us-ascii?Q?snD9b42aSXUUrVAtX5OjU/Q2Yec3/TcGccHzeW0OqPvv4ilbCjvEomx/vkxI?=
 =?us-ascii?Q?HZjzdn5LXkkLZbNSuOLDGI0/gWir6zFRK3I4ldaUUY0jtBPcz8j5I57PSdht?=
 =?us-ascii?Q?si35n7CrWI81LpfzyPJsvIu5D6B7O0SzMYjwYQOoPdk/kFQj1YmTK7/xOHea?=
 =?us-ascii?Q?gR1+cxVNQMbEjSAUEKe8Q1zSpnKAIGWNt+Q+kBKuvmONovZZfUuuTPsabc5d?=
 =?us-ascii?Q?Fslol3dhSBCW+EY1C8CrQJFVXu8x9O0lcUApCFU/UG/+Vo4n5oT4nT/Q+e2W?=
 =?us-ascii?Q?13xb6j0NjdpuBUOb3h9q9aAZCkJQ2uOUCtrd1WnsG1X/efAu5HZ9GSauJJxy?=
 =?us-ascii?Q?SqXBe9FrjBAsGdIekiex5WfhBUFOe+8emjMiF2VNb2QRV6mBITx4KD95Z8Dn?=
 =?us-ascii?Q?r9cHm9QjXU216pnv3I/lQK8xgHI5Z0A=3D?=
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79cc9878-ac74-4217-08c2-08de552b991c
X-MS-Exchange-CrossTenant-AuthSource: DM8PR13MB5239.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2026 18:18:07.5081
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DtsiQf8OnkEoJo+VZr10tMRc+gdl3jfGRBoz3sJ3U1c5P9wv0OxTh/e5/nECnbOpkrPPbPtMaBg+321EDNGefw3lxRNxu93vFfAhPZilo0Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR13MB6935

If configured with "sign_fh", exports will be flagged to signal that
filehandles should be signed with a Message Authentication Code (MAC).

Signed-off-by: Benjamin Coddington <bcodding@hammerspace.com>
---
 support/include/nfs/export.h | 2 +-
 support/nfs/exports.c        | 4 ++++
 utils/exportfs/exportfs.c    | 2 ++
 utils/exportfs/exports.man   | 9 +++++++++
 4 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/support/include/nfs/export.h b/support/include/nfs/export.h
index be5867cffc3c..ef3f3e7ea684 100644
--- a/support/include/nfs/export.h
+++ b/support/include/nfs/export.h
@@ -19,7 +19,7 @@
 #define NFSEXP_GATHERED_WRITES	0x0020
 #define NFSEXP_NOREADDIRPLUS	0x0040
 #define NFSEXP_SECURITY_LABEL	0x0080
-/* 0x100 unused */
+#define NFSEXP_SIGN_FH		0x0100
 #define NFSEXP_NOHIDE		0x0200
 #define NFSEXP_NOSUBTREECHECK	0x0400
 #define NFSEXP_NOAUTHNLM	0x0800
diff --git a/support/nfs/exports.c b/support/nfs/exports.c
index 21ec6486ba3d..6b4ca87ee957 100644
--- a/support/nfs/exports.c
+++ b/support/nfs/exports.c
@@ -310,6 +310,8 @@ putexportent(struct exportent *ep)
 		fprintf(fp, "nordirplus,");
 	if (ep->e_flags & NFSEXP_SECURITY_LABEL)
 		fprintf(fp, "security_label,");
+	if (ep->e_flags & NFSEXP_SIGN_FH)
+		fprintf(fp, "sign_fh,");
 	fprintf(fp, "%spnfs,", (ep->e_flags & NFSEXP_PNFS)? "" : "no_");
 	if (ep->e_flags & NFSEXP_FSID) {
 		fprintf(fp, "fsid=%d,", ep->e_fsid);
@@ -676,6 +678,8 @@ parseopts(char *cp, struct exportent *ep, int *had_subtree_opt_ptr)
 			setflags(NFSEXP_NOREADDIRPLUS, active, ep);
 		else if (!strcmp(opt, "security_label"))
 			setflags(NFSEXP_SECURITY_LABEL, active, ep);
+		else if (!strcmp(opt, "sign_fh"))
+			setflags(NFSEXP_SIGN_FH, active, ep);
 		else if (!strcmp(opt, "nohide"))
 			setflags(NFSEXP_NOHIDE, active, ep);
 		else if (!strcmp(opt, "hide"))
diff --git a/utils/exportfs/exportfs.c b/utils/exportfs/exportfs.c
index 748c38e3e966..54ce62c5ce9a 100644
--- a/utils/exportfs/exportfs.c
+++ b/utils/exportfs/exportfs.c
@@ -718,6 +718,8 @@ dump(int verbose, int export_format)
 				c = dumpopt(c, "nordirplus");
 			if (ep->e_flags & NFSEXP_SECURITY_LABEL)
 				c = dumpopt(c, "security_label");
+			if (ep->e_flags & NFSEXP_SIGN_FH)
+				c = dumpopt(c, "sign_fh");
 			if (ep->e_flags & NFSEXP_NOACL)
 				c = dumpopt(c, "no_acl");
 			if (ep->e_flags & NFSEXP_PNFS)
diff --git a/utils/exportfs/exports.man b/utils/exportfs/exports.man
index 39dc30fb8290..8549232dea74 100644
--- a/utils/exportfs/exports.man
+++ b/utils/exportfs/exports.man
@@ -351,6 +351,15 @@ file.  If you put neither option,
 .B exportfs
 will warn you that the change has occurred.
 
+.TP
+.IR sign_fh
+This option enforces signing filehandles on the export.  If the
+server has been configured with a secret key for such purpose, filehandles
+will include a hash to verify the filehandle was created by the server in
+order to guard against filehandle reverse-engineering attacks.  Note that
+for NFSv2 and NFSv3, some exported filesystems may exceed the maximum
+filehandle size when the signing hash is added.
+
 .TP
 .IR insecure_locks
 .TP
-- 
2.50.1


