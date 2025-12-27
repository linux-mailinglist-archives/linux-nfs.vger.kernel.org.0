Return-Path: <linux-nfs+bounces-17322-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A1DCCDFFE5
	for <lists+linux-nfs@lfdr.de>; Sat, 27 Dec 2025 18:05:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CB64C3001E0F
	for <lists+linux-nfs@lfdr.de>; Sat, 27 Dec 2025 17:05:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CF771DF73A;
	Sat, 27 Dec 2025 17:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="CysYMPIa"
X-Original-To: linux-nfs@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11022078.outbound.protection.outlook.com [40.107.200.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03AA88834
	for <linux-nfs@vger.kernel.org>; Sat, 27 Dec 2025 17:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766855103; cv=fail; b=pwVsrrtft362Fyq3gL3eFKs5H47d+KmtELszHlL50ge2WKZQoo4R3a4FeCIXZOPd8YdRaUC6LyppO4Bg37dW2najO47UOl3UP1TZSPEsNOIBh8Oe/xMGEd9+2SlWUDXPUlraqVWFP2fl2x8avi8oj6vQDnLF2choq1fZqV7LzEY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766855103; c=relaxed/simple;
	bh=fyRAWJCTj7Ok3791mQOvPXoyDHrRyeQnfJLwdxbCJWw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jWPyiqVKYOitLiS7uuKUS4HlLNwJmq6i6Igu8OW0u5W8Q7unVo7f1jZcY7x4DGqy+8iLXKxml7ptKRcXdUDgdrRMsyE7l2tbXJhlUWtn5K/038VAiV9hClaOrySNLqCJdhM+kfw9TbEVyp6Iogi9Cp7Al4MLlL3BkVI9rZWSCok=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=CysYMPIa; arc=fail smtp.client-ip=40.107.200.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GvDOBhQ54uzta+rjTQWcnFCFkaVsqfJMgop1Ez6wiJZKS/QEJ0VoaTkRBmNcucr+1LhKsrMsZFVYm9IE4ze2u0ILpGf5Yc0N87/kAeBAm7ifR1B0QWclEP3pHe6jrXrgrnbdJeDtZlr9ycIGGPcEuE+TCfouviPS+jUgZwesnVW3JyGVNh/iYnUX7t1w+efZeqrUup4yhOIuXUQWPn/qoiSbsDPWEGy/QGiMlv1Gs7GV/LaXqUE5I8+WVwIsrAsTTgOXsrxFEnuymZBYUSofpnd9XGRzHffjFulju+jKSLHvsZYAQUvlamNUitSte8iKsDA9+VpsAgzGV+2ZzDbCtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=16O5rKKTF0EduuFk6UlZYnrktRo9sN4PjxF+cHYIafA=;
 b=MmYKEayGfI6nSlt5+6xQUVmMrczN6hTHPXx2+uSOsVUw/YvhRIdDhkaDXeRpFWl7hnnXBYyMD+jcQ5RbDJCWE8oP2XXtVaovVCZpRq+D/GtB+dneohG56PrlraT6et92hcfjuefSMvd3q85FF1FwO0KWecKIUGRtBfVnu2nrlg/475TIkuHk/uLLnGKUzh+bQzLDujcyTTu/NU6dFAg6sm2peDSaYNSTF9s6ZNippVQIR9wKc80qdt4rigENRBjKSqog01t8HOkocVjIFczPtnfIPea5aL2fdIIsuwaxJTHA4UoKtaPGbovjy6MnMFoYLjQGON3hTEAxR1Z6PSkXKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=16O5rKKTF0EduuFk6UlZYnrktRo9sN4PjxF+cHYIafA=;
 b=CysYMPIaHduJ5BED1ZsP85IQbuUicNuL7EPFvdi5olOlo7GaYmiWfpj17y/39fyhf+M8Fi/KAf55KUJlNarTc2gZczfatXu/lYyTJnMmnhf2b9EJ/H8kyEw5H/PSOZOwRyEol1sveFeN7+veFVgsjY90w91GOacLgQFLVECVXaQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
Received: from SA1PR13MB6648.namprd13.prod.outlook.com (2603:10b6:806:3e7::10)
 by SA0PR13MB4061.namprd13.prod.outlook.com (2603:10b6:806:99::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9456.14; Sat, 27 Dec
 2025 17:04:58 +0000
Received: from SA1PR13MB6648.namprd13.prod.outlook.com
 ([fe80::c48a:c42a:aa18:2ef4]) by SA1PR13MB6648.namprd13.prod.outlook.com
 ([fe80::c48a:c42a:aa18:2ef4%3]) with mapi id 15.20.9456.013; Sat, 27 Dec 2025
 17:04:58 +0000
From: Benjamin Coddington <bcodding@hammerspace.com>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	NeilBrown <neil@brown.name>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Benjamin Coddington <bcodding@hammerspace.com>
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH v1 0/7] kNFSD Encrypted Filehandles
Date: Sat, 27 Dec 2025 12:04:48 -0500
Message-ID: <cover.1766848778.git.bcodding@hammerspace.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <510E10A4-11BE-412D-93AF-C4CC969954E7@hammerspace.com>
References: <510E10A4-11BE-412D-93AF-C4CC969954E7@hammerspace.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH8P221CA0058.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:510:349::7) To SA1PR13MB6648.namprd13.prod.outlook.com
 (2603:10b6:806:3e7::10)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR13MB6648:EE_|SA0PR13MB4061:EE_
X-MS-Office365-Filtering-Correlation-Id: ee107c52-955b-41b2-f5a8-08de456a1071
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7142099003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zBG1pYW5YSl6garNSkDsEDQc3UDSpdYdOHC4mFGhxkJc2923PPpumYfVVQih?=
 =?us-ascii?Q?kFuEXSfdjLy9OwUF8Xjd9CkQfV7GNIOnU5qbO6oYJnNbShV3EZ9la12joLzV?=
 =?us-ascii?Q?KZYwHbtS3lKaG6fKA9SgkH4io6eIAelruh6OUt7tNHIcuZQYXzxZmNBaOfqU?=
 =?us-ascii?Q?uXPtq4n7u9Lq732SVBqkW0iyDgyywE/FPDyC7hRXagaKQAg9IP0S+uFeq3JR?=
 =?us-ascii?Q?tdZktEGQvKx4LkYQ51H7syk6BoSdWHSJdv2qcudnxsW7IHOAvS8s5DaHwBY4?=
 =?us-ascii?Q?LDgrcPKzGN7y8tcoyWov6klUvjGciGpudGvDAAfEMEkZg8N13EK2lVaB46/9?=
 =?us-ascii?Q?otQ3QBAR/Ot5Tc3V8fSiH3yp/5sgKZEGZ3RB3luy+tzhKCP4LmDihOaagoPr?=
 =?us-ascii?Q?iiOZMIjheupm2BMa6F6kQYU6+rt3TF/XtLgHc5R6IlhawnhkndNG9aB72iEy?=
 =?us-ascii?Q?3VXz3g2EsCqjnp2Yrher7mjf/HItqnPoxhdRirFv/zczZWtSMQEkDsogWrVB?=
 =?us-ascii?Q?yiVCW/M1nPK18xWLnGDL0CgLUzqrv3HFBdSDy3TLp+u0/YW0VVqFLkV+KWwB?=
 =?us-ascii?Q?dSCGzhgktHAyD7eoF9Uj84AC7vDLQ4IjkQGMx/7ayf+cNV9UY9SWb5oSbmG3?=
 =?us-ascii?Q?DSx/TFnOO1518iqlY3lVTGkG3hhsJvPJplqrSz6eVhREl9FXVze7DMKo2X2N?=
 =?us-ascii?Q?kV4indNBZWQIZI16x/PeTsD5CwZsiaI0V74nB+Y4G3ewGcZG7v0SWxZEXx+x?=
 =?us-ascii?Q?69Az4L56u508f0LY0b+mFkBDkx3GfTxNCYtdOch8sNlsHp9oGXf+cX02Wi/B?=
 =?us-ascii?Q?2Fa7DAJ8FFgKZHl5G5opmddcyTsrac4bh2ZaQch3eAPE0swIhGdxkgny4dLp?=
 =?us-ascii?Q?PzqSuIFevqDpbjHaxNUWqL2g7ju0cO5UZ8jTwlNFqSKudO1wFT64qHGyhj3d?=
 =?us-ascii?Q?7U3el2RitPEc8pso6FJVFfZsRE5svBp/HPDtSsdnRN+uZB9oFfOOl9J5U6lN?=
 =?us-ascii?Q?HkrTCdkl/JvqJP2NqWSmlVcvjNZZ1EF+F17f8TYLnFbEMbdvIdnnXyjL4nJC?=
 =?us-ascii?Q?2Tvh8EQyaXviCoIaz+9LF+10Kkx2D6mrO8d0p8yfKDNBlmHJD+bBU7oND0bH?=
 =?us-ascii?Q?ZATKO1N5OgsMz0DucEOrJ3byl/VM7penvLdbj8yVIPpHSE5qknDjcWAatq8d?=
 =?us-ascii?Q?rWnK8Rzzk633ytaeNrfGqbcsnR51LZJotXpxylJnnHUinhanNBg6iViSDOic?=
 =?us-ascii?Q?AHxd49/VmC9xTj6xdgHiWu0zQVyAil9D8A1Xz09a0tqI0X78ksW/0hx3jd/e?=
 =?us-ascii?Q?FDAveWHq/ykOMkcFDyBaRMRQnBKLwiCFhB2sbsvJBHA2+sqej1o2Qub+5imc?=
 =?us-ascii?Q?GijqGVXRTJ9ca7uuPlNqwIXtGzOv7CRKmIcfCHJEuK9ZdJ8ki+TuHLEFO4e9?=
 =?us-ascii?Q?ICJ1R39xoWxKk40uoxXAsNI/iknLN4nx?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR13MB6648.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7142099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CWnd7lAIbzvlrP4klV0uQEcRm6We6UOZjgiGJZLQYiGZadqLTKCt8Vkawf1q?=
 =?us-ascii?Q?sKe71PGSsVgyk9OFmpTUDHkhGQylL53LwIJKlNj4V+f6SddKNVlaFNddUimp?=
 =?us-ascii?Q?B3E7p6AMuw+xnV6y2UFOeVuvLW4pJPnykdAnZheQ7cIcI2UE18RxeFCNV2Na?=
 =?us-ascii?Q?1PmrGPlmAROi7u7RdfviRjDYkkNB4FgtPthn+8Ach25vmeWJgBcV65GkXXrD?=
 =?us-ascii?Q?Ty29Agg5impL6Ur0e0MJKjKSbioaKAixBRWrMUn5XMd80ybGVfiX3YAyEx9X?=
 =?us-ascii?Q?5QwW7N5+F23KRX9NDPP4Hh7clDhCb4nJpOMfFRZKniVHivqPbynpxkVaRKBh?=
 =?us-ascii?Q?RcbvvD+SsNq/34MiU9NGZvR66kHNd5fvMxkKKQeGIGQb+UzzP4PHI1s/w1vF?=
 =?us-ascii?Q?nZ1cXSUuF2i7/EVA4crNQivWLDgXwYlpw2wxB8zZREtZyXjoSuqucD8gJRAL?=
 =?us-ascii?Q?4AnrY8lQTueu12P3GUW7TkbEn/vor0pmfgVFFyUaMQgfUnLeZUFuZcASTPnk?=
 =?us-ascii?Q?ifPA8S8LufggiDmZRa8c/3sJRekgbcI4cdcy769TPrdz0AxSsGJ6w0FusjbE?=
 =?us-ascii?Q?TjL1AuvQgAvO5p6OMT2P2zA5fJcVaqlc8V8dL6cq+nPc/rB50TSuwTp+2z+Z?=
 =?us-ascii?Q?n99gM8uvYGTnwmftsBllwEkqf4O8nbmZEd8LVA9PqfKR3k1WjEguwDVIWywa?=
 =?us-ascii?Q?f7VfDVzqqN4k26alexijrJpFzeLOuLPeN9521DHv59haTvBv3KqZgEmo7g+2?=
 =?us-ascii?Q?/UTmZbqOpgrW7e5JH3aiuexv5n9fO7NkM4VcilCOecf2saPTgJNdvu6eSQWj?=
 =?us-ascii?Q?19Zb5fyCRiTcMSQS7Axe55zqLs76bVTPPDCj24NpqoNmw9Q45RtqVIl7Tl4y?=
 =?us-ascii?Q?s7NN4z8i4S2llzcEtYd9ZDPOLkDn5NsvuGNQChVbOKMqxwXao2dkrSwOCcrX?=
 =?us-ascii?Q?Xj3ngeWXpHEtqC5OUYrWuqxqKQCG62k7YXjzXT7LK+I4J2iND9CJFX7pxd1E?=
 =?us-ascii?Q?ALx9EWqsVGg5wTi25sW1FbQMLFiTgtGRlZzo079S/RT+qOh5rRy7cVJsK0uQ?=
 =?us-ascii?Q?Y56lYovk6+k5YdixBRBKlffpLQf0tlMktM9HyYj4RjlOH7K++7FddKsWbOKP?=
 =?us-ascii?Q?Rfi533bU0SS/GUjBKlYMHb7K1JmKCymkaP05GVMFXEv5KafoedLUWNpgCrv4?=
 =?us-ascii?Q?zSPq4hCzQOsIPC9wbvGr4JA3UtpmOCkiLNIou4cNWCisWONFSNOishx5JMcX?=
 =?us-ascii?Q?KPjMtHHcp43fqMRAIgD6bvIVRvmYZf4WkE8S1Pv61F1fP1jdQwUyhnluIXfY?=
 =?us-ascii?Q?h9IwospFvxvSNkzEIPmx2NL0TnbYuxgiGYSh8j4vB7sjxZgtSdzGq24I4ETP?=
 =?us-ascii?Q?FI07Hu66n76+RYUeUd89tstDF+VDOEzWvS/X7wa+wvNY+GBjaOPwRczB3xd0?=
 =?us-ascii?Q?Mth/RTfKOolweKXQ4Wjim9M8ZkNPAN+yNha+BW1IxpZhTEocSbTfgbnA2lk+?=
 =?us-ascii?Q?PXKr5HWYCRCp/roYIBn+Ci4nXOPvb8/BLVVyYtGGzqLB5DPDvVVmd1RXODQC?=
 =?us-ascii?Q?g1f2ijnGev95LDdUrbuXRVcyT9Ne4kERcziPt04aksbOQVY9ytAuEOTrBYZy?=
 =?us-ascii?Q?Hg5rPxrD1fkVvpE8CqmB/W8S6uEFPsj2+dLw4aZCgqGitDridwOhQrGmesFa?=
 =?us-ascii?Q?dJu4u+QG69+MlXDjZ9J8eoU4TTHLYdmbOJ6MHIj3OiLQi2VilneKAZa61aFn?=
 =?us-ascii?Q?busnhA1QDFIy70k+kRh0r3YVb4MgCZU=3D?=
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee107c52-955b-41b2-f5a8-08de456a1071
X-MS-Exchange-CrossTenant-AuthSource: SA1PR13MB6648.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Dec 2025 17:04:57.9619
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XlaT/JwiRo9eFL+9J/CBFZcGzNxwubUJTUUnBAsCQETvfIv4pIuYXIE57DFyZ5Oqtnt5gALKBVfWgwNk66tQ6nZq5JacWIrIilFHnMb+28A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR13MB4061

In order to harden kNFSD against various filehandle manipulation techniques
the following patches implement a method of reversibly encrypting filehandle
contents.

Using the kernel's skcipher AES-CBC, filehandles are encrypted by firstly
hashing the fileid using the fsid as a salt, then using the hashed fileid as
the first block to finally hash the fsid.

The first attempts at this used stack-allocated buffers, but I ran into many
memory alignment problems on my arm64 machine that sent me back to using
GFP_KERNEL allocations (here's to you /include/linux/scatterlist.h:210).  In
order to avoid constant allocation/freeing, the buffers are allocated once
for every knfsd thread.  If anyone has suggestions for reducing the number
of buffers required and their memcpy() operations, I am all ears.

Currently the code overloads filehandle's auth_type byte.  This seems
appropriate for this purpose, but this implementation does not actually
reject unencrypted filehandles on an export that is giving out encrypted
ones.  I expect we'll want to tighten this up in a future version.

Comments and critique welcome.

Benjamin Coddington (7):
  nfsd: Convert export flags to use BIT() macro
  nfsd: Add a symmetric-key cipher for encrypted filehandles
  nfsd/sunrpc: add per-thread crypto context pointer
  NFSD: Add a per-knfsd reusable encfh_buf
  NFSD/export: Add encrypt_fh export option
  NFSD: Add filehandle crypto functions and helpers
  NFSD: Enable filehandle encryption

 Documentation/netlink/specs/nfsd.yaml |  12 ++
 fs/nfsd/export.c                      |   7 +-
 fs/nfsd/localio.c                     |   2 +-
 fs/nfsd/lockd.c                       |   2 +-
 fs/nfsd/netlink.c                     |  15 +++
 fs/nfsd/netlink.h                     |   1 +
 fs/nfsd/netns.h                       |   1 +
 fs/nfsd/nfs3proc.c                    |  10 +-
 fs/nfsd/nfs3xdr.c                     |  14 +-
 fs/nfsd/nfs4proc.c                    |  10 +-
 fs/nfsd/nfs4xdr.c                     |  14 +-
 fs/nfsd/nfsctl.c                      |  40 +++++-
 fs/nfsd/nfsfh.c                       | 179 +++++++++++++++++++++++++-
 fs/nfsd/nfsfh.h                       |  26 +++-
 fs/nfsd/nfsproc.c                     |   8 +-
 fs/nfsd/trace.h                       |  19 +++
 include/linux/sunrpc/svc.h            |  12 +-
 include/uapi/linux/nfsd/export.h      |  36 +++---
 include/uapi/linux/nfsd_netlink.h     |   2 +
 net/sunrpc/svc.c                      |   1 +
 20 files changed, 356 insertions(+), 55 deletions(-)

-- 
2.50.1


