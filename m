Return-Path: <linux-nfs+bounces-17328-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 02D50CE0000
	for <lists+linux-nfs@lfdr.de>; Sat, 27 Dec 2025 18:05:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 12E24300FA16
	for <lists+linux-nfs@lfdr.de>; Sat, 27 Dec 2025 17:05:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C16463168F1;
	Sat, 27 Dec 2025 17:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="RIR2ocuU"
X-Original-To: linux-nfs@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11022078.outbound.protection.outlook.com [40.107.200.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB04032571B
	for <linux-nfs@vger.kernel.org>; Sat, 27 Dec 2025 17:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766855112; cv=fail; b=a0fSfZ4SX4b7RCYIJuzV7W1/yYVxWucpJ9wwZVBu150Yb/fJnyTznjU3hhKxSfOIYkLXU06w0d5LihN7YvlMifwUcpbsSD2D+qVHcPjnVBqumIEq0zeaBUm0AM9bsB2JLwEWP+xzbchvFArO53p/A3P20Mg7NFkh47P4bQdM0YY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766855112; c=relaxed/simple;
	bh=Uwcm9xOjX58SI9Af7KbQZsSrT1lwVgXiuFy1jjdXTjo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DaSMvEMLHgEFlgkqiNMgpdzPXobYRRTOckjfxeA57MxhwWX+YTwJEw0tTuLz9w2vH5bXhqVTftyucnwXG/F4/C/v5SZbCU1ZDk/lNeb3r8AbOF2d5CZ9cBarsIMv3tEaDbFVgEht6cMeImlhF84IU5AAN5KHJG/mp9p6F3pDRAs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=RIR2ocuU; arc=fail smtp.client-ip=40.107.200.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t831G5nCeJ+ixISlP9Z6mnJjYrIILLAQNtVw3JyuctvrdO+UYMOz5YIMQruq074yExkdTfuND9tJKOU2EYRDohCfFUtUKvAElEXtfit4LFZj27S/SNGNAD/ddgIBmlkbiHQhIUyTiFOTFUgKdiD9JkKn91AbMM0yJn+Mpf1tK1x1vHJtP7zzATnqUlkriBQMBD8pDIsW4s6te0bVRxRl/LV29GeHj0YfaBr+cgxUeqTzzmmZyGLmw80BQ00pmfRCHj8hwmtKJDX21hwGNHW9DufD5yy0dWqA3ukihMcrRLxQJZXMC2uIXCgfWcueD+zu3QDwopO1Q4PQy6wqm38RHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8W81y5YvSREQ/o3fD5+nCi+S06yzvAyndAwGG9Qq+to=;
 b=B1w2A5j1DSFvCTfO+25qOjRjdiI6N4VKEh/3dOpoG49MPEzakbybKAH4twkzROIm0o0FF76bG+z9hV7oYiG5d/00T3AFwHLMgPDKugTGglyTBj7zDMZ4+Za9ExJnRGq4MFx4r99NI+OcXiyPOEyYQWQH2HdwQ3X7Ncd3BjLuZvhnvQrNnYT7FemxVzhM6erw3vhOS2hs9eAhYQWu48NSmcWjmou8m/3ta2VWdogmJ7OMpYvYGhd88BGQ8Dx9AQOjSyKqOUfs9KLClzQil/GMiOklq6qhqXglpJHeR8r+EJvJU8iIJ8J099UbyNMtTSWXROn0yY4f2aa0dEv+XDs4ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8W81y5YvSREQ/o3fD5+nCi+S06yzvAyndAwGG9Qq+to=;
 b=RIR2ocuUzK1ORdnC5fd6txYZ9Un0nmwgHMh+hSPCK0mCj02xyl3WyTQdcdS0H6H6m9gb3GhVSaBhhjd93PF5h7U+IreDwPuIMOzxBXKHvXh7FcyZ2b+2D8mMMs7aNo3xuZre6CgusEQWu7JVCGcWA7E1hmLYIu5Gzn1swzSZh/c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
Received: from SA1PR13MB6648.namprd13.prod.outlook.com (2603:10b6:806:3e7::10)
 by SA0PR13MB4061.namprd13.prod.outlook.com (2603:10b6:806:99::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9456.14; Sat, 27 Dec
 2025 17:05:04 +0000
Received: from SA1PR13MB6648.namprd13.prod.outlook.com
 ([fe80::c48a:c42a:aa18:2ef4]) by SA1PR13MB6648.namprd13.prod.outlook.com
 ([fe80::c48a:c42a:aa18:2ef4%3]) with mapi id 15.20.9456.013; Sat, 27 Dec 2025
 17:05:04 +0000
From: Benjamin Coddington <bcodding@hammerspace.com>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	NeilBrown <neil@brown.name>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Benjamin Coddington <bcodding@hammerspace.com>
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH v1 6/7] NFSD: Add filehandle crypto functions and helpers
Date: Sat, 27 Dec 2025 12:04:54 -0500
Message-ID: <0688787cf4764d5add06c8ef1fecc9ea549573d7.1766848778.git.bcodding@hammerspace.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1766848778.git.bcodding@hammerspace.com>
References: <cover.1766848778.git.bcodding@hammerspace.com>
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
X-MS-Office365-Filtering-Correlation-Id: fb5661a4-31fc-40b5-d4b2-08de456a1477
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7142099003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TUGCMVadcoNe3zCvcxx/nmtZrDDP2lxZqmIqPXsR1fm/gnM4eBdEoSnyfRhv?=
 =?us-ascii?Q?uWChEgK6t0aJtGL2Znd1/36S4NJtl/34tz9za/jfQIJ/9RovYupxUlIYfRN/?=
 =?us-ascii?Q?V82LihfEmGy7kQzWAHtaGC1S+UF08qT8/eOI392kf0fX0Uoz/HlavomIOjZe?=
 =?us-ascii?Q?48WJaXgN8nwH/ZMv2MVERAuotYaTt0CGmFjbMXb6RDPFVmcl1NbhX00mFKrt?=
 =?us-ascii?Q?8BSLtkMqWNd68MESzD+D+2E4nN9ia69oz5oF1p0GH0/Ho7YNSPv94HQ+QfD/?=
 =?us-ascii?Q?hwivQhCL+9Y+YbYheZPJVLmv6BlqjyDemXqsR63O4YQIDcagKR3XKRsegDMa?=
 =?us-ascii?Q?X+SO+4mTml4v1ihieh3rOcMHuSD53Yh39IutqTJhx7MbEHd7ozCZLg5nIm2O?=
 =?us-ascii?Q?yRTAhUlGSjXHmmMdIJ3EPTUOLFTFlnhvOHtpjOfFIXTMmDBzl5iUzuydv2JN?=
 =?us-ascii?Q?LLBeqzO0DmecZQ9wWEmPYZ7PHCQmyxyJUDSBcN8kQEIVBmOL0aJ1UR2EbOWq?=
 =?us-ascii?Q?udwPntURM3CVzxzUzoSvhAAu+SsC1UR1v7wOpIwGLmqrbLw4l0GDQ4FhCe0j?=
 =?us-ascii?Q?Yo4H99LBk5zu5+QLY9V3as2PonD24Ca6SKzh6frGm3leQNh40Iu0zEu6Dm57?=
 =?us-ascii?Q?OVvQfS1iiH/Um7aMY0UhzSJLkMl1K9L5KD9mc8ei/Oys+PgCTcEWtDYKm02c?=
 =?us-ascii?Q?P6IWueFymU5xc+r6DvjNxJGahRQuhUwIEKbZmhCjPQQl42JwwqRMZkxPteaD?=
 =?us-ascii?Q?sUpoYar4QEucynWSXPErx456NJCwZTipokhAf+MOqM2fL/cVZwY5qjjivjXR?=
 =?us-ascii?Q?kL7WQ6MashGYfKQwyIjmy3c1VyrbzQ3cEDfuKtGYEhWDAi3jrTdlbh9i/mz/?=
 =?us-ascii?Q?T7m278z3RR/hvzg9xKci+mSvqscZUy3dnD8M0aWBttjIpm8wGAe9hsF6iP9A?=
 =?us-ascii?Q?XGSJlscOll05FX0KIF74JVFz5EdI5b1nSbWQZ8OFEiCabNtzOOqZ7qR2rvpl?=
 =?us-ascii?Q?jI/H+HYJG4IBEowPc/6dFcs7NRPYwkVlogjSejgkmL8BChZbj3RM9UO952SU?=
 =?us-ascii?Q?Pme5vfcjqQPqddWOrVxW3xfa8tbi8ph4HsNov2Ul0PgPz4MDghW1tivoOuFC?=
 =?us-ascii?Q?m20ULIkt/CHL6yQ3QVsTBXCELj9DjIgRHbglR0ikfoJjWKe6YB8P3wTL+3wF?=
 =?us-ascii?Q?uYhG+VtADJqniiCBiNxqT3wzzpC8K3MnfwR8Y6Ql6BCO4j1zD/sZLYaK8cRJ?=
 =?us-ascii?Q?w9qr1tjPTsV277LmTwjeqm+uGd6/SE+Wo5iGzht96SW8UMrKitTOus5LqhhK?=
 =?us-ascii?Q?sP1qkyWyCJkkoxrDmtS5dClOTGp6h76krORjq0I6F576Xdm9yugnOglgQmQ9?=
 =?us-ascii?Q?9pt6eV3NxAs2woLL9Q/nDhA419lHezoiTAG/YAsffD4jBLV7oC7Vf2FZjAIB?=
 =?us-ascii?Q?mTktJI46ilc76c21lKk5pCSOEjyeqgA2?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR13MB6648.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7142099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?A91JOB/Mygo/7XBYvcyKSlqhRr9qlTy78M1GHqPbJqP8d8PPY15ePbL5RSrK?=
 =?us-ascii?Q?mxR1rdRw+BAly1te/Fp/m09hLZaRlaIy1vR3RzLN+8I2EFbeV7tnMgkhyLKI?=
 =?us-ascii?Q?YxOgUPq/LZ6DHE/V34/qH+iVub6StCzz+x9z6n3Wm9YxIFL8Bd+h/eg5NpFK?=
 =?us-ascii?Q?h0ke90r9KiD/eWdaK0PFu5z2gGkq+rOXyHwPuKszamDe34KEwnurCrIo3pFu?=
 =?us-ascii?Q?om82HQdtBePTXdo3Ez6XhnLFnvgYwy3uvFzFq0dY5ejkFhPu3LqZ55yy7FPd?=
 =?us-ascii?Q?Kj4/Pnul1ypTHd7nICqwKWJTPnySkyHq4xztFAczhl81lq9g/FasqE0kDCgJ?=
 =?us-ascii?Q?MhFtlkF1eXT69UKgLcj0oNJku81l5jIXElP9EYnex/7JKv2EYH9eJTLmu/Ro?=
 =?us-ascii?Q?wBDmFn4ZM64kNvZpsyM/5IIr9p7bIFq4b37n+EiMJwamNWBDh/GyEbYDs5pU?=
 =?us-ascii?Q?H6bMz12fsnVxYDBOhZboQUHKyTApBOgVuAfPwM+Nqt30KWZ9oHb+YDZppV5D?=
 =?us-ascii?Q?N3AFy2qdSvmOv6OhjKp6cShCUal81r+SJK9M1rn5oEmps/Ym0Y1oW1tskpGJ?=
 =?us-ascii?Q?FTVUqJG4u8iO4KNpliQx9+GvVJA4NkgNxrrabEEefFdl2InKFitKppxOJrub?=
 =?us-ascii?Q?GDUKfr3F/f8cMvs9WXBevznUFEsqnNofWpPdqxS0l7Lf2FxdBgALP9Nh8+/r?=
 =?us-ascii?Q?qGF1NPN233IdmmX7bT/wEpDRU6ypuYRLs39I4JQaO7GsCp1QeRDu4hu2G8cC?=
 =?us-ascii?Q?XBGJzOvtkuB4olp2dahsUJpYsSIiB8h8M9MM7+Ub00HNIWKQdhTnjsAvIkfG?=
 =?us-ascii?Q?8zWv1lF5lvWAGQuAqQ6YTX25Jc2EtCiwPMjoHmXrJHqAEQvuQi9h4kIVVpbz?=
 =?us-ascii?Q?5+LnPSgQ6JibIN4eY+QaeHTWi7K4BzrHq6cCuHFJOPJt/mRy0lZTfzkhcRWS?=
 =?us-ascii?Q?V58DJE0VB6Nu6BT8cU8IMiIHN03XJxsUwNSIOw0dcG/NDiDhmjZjA+6N3weR?=
 =?us-ascii?Q?ndNqRWHBZMfYm7Jf+8kWyzC+WI/S1oAzELK/2/6XQmGxhfGogBZzZG2YQyPh?=
 =?us-ascii?Q?Z0mGaPirV+pfkjq/o6XikDJ+SRT3ERx+Y/AbUMMW4whUt2k9Ys0UqjaGJ2xi?=
 =?us-ascii?Q?PYZ0IMJIzrspDiNDsgoD7VzEtjoLfnMPBUMt07aadnpyF1+1vqQHQq/lLP4O?=
 =?us-ascii?Q?x1CmhTcnnbfFO6UMaDHS9Aj482N3zdU6zUroSHX+JvteZMJ4oKKTzUlBcFtU?=
 =?us-ascii?Q?7WN39NwtmXC2ULCqQRsIYC99EBQWJGbQfJwZMBeCYe2IKz75ZcVpBM5XFl4O?=
 =?us-ascii?Q?c9CCBQqBHbY+7k0sBFX2wIyr0pbwjvddbhcoYPQH+IIW/xx8OqHCFSwrl3Vv?=
 =?us-ascii?Q?sklLBIWYMSue4Cga9X0o+V6D5ZQdtWaZHTrQGyyaj6UVyL0484TsFiNOMhQ2?=
 =?us-ascii?Q?SxLn64U91wFsOTP+HLcLw4jQUdMfm1PQJux4xUTyfmaCXlDEQ/hoat1Fw+LK?=
 =?us-ascii?Q?o4MW1rZyAJvHxDJUpi1NP8RYYrNllLaCEV6ICzXnUaTeRsSOEUI6UEt6lYuI?=
 =?us-ascii?Q?r5H5uA9b8+qIeTiEKupiReqqrK2SosQywxQNZojkPLkGjx1Gdr3lbVh/NC6/?=
 =?us-ascii?Q?0OHKlfUk3KCmVVmz/Qe7sJ2cDDQD9BwSDEpxNMXb1yahWakJRhU/AqpB6Jyz?=
 =?us-ascii?Q?u1HEX+UGhyjYQhU0fYoRlxOGDjpiv84xOsJLPq2CbCZDC8oHimXhaIDk8nC7?=
 =?us-ascii?Q?FlUMC4oiHW/Majte9wcts2Ko/OQhCec=3D?=
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb5661a4-31fc-40b5-d4b2-08de456a1477
X-MS-Exchange-CrossTenant-AuthSource: SA1PR13MB6648.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Dec 2025 17:05:04.6631
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pcYZWk/qgLA78kMlQdqUk57pqGVXo8PJdq8fNisIIDiQl94aQ08AWADLli/zBoCecqdJ4g+Zss1YSvBVBqIl6ttqH2EzdL/GGW6rtTZl6cM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR13MB4061

In order to improve the security of knfsd servers, create a method to
encrypt and decrypt filehandles.

Filehandle encryption begins by checking for an allocated encfh_buf for
each knfsd thread.  It not yet allocated, nfsd performs JIT alloation and
proceeds to encrypt or decrypt.

In order to increase entropy, filehandles are encrypted in two passes.  In
the first pass, the fileid is expanded to the AES block size and encrypted
with the server's key and a salt from the fsid.  In the second pass, the
entirety of the filehandle is encrypted starting with the block containing
the results of the first pass.  Decryption reverses this operation.

This approach ensures that the same fileid values are encrypted differently
for differing fsid values.  This protects against comparisons between the
same fileids across different exports that may not be encrypted, which
could ease the discovery of the server's private key.  Additionally, it
allows the fsid to be encrypted uniquely for each filehandle.

The filehandle's auth_type is used to indicate that a filehandle has been
encrypted.

Signed-off-by: Benjamin Coddington <bcodding@hammerspace.com>
---
 fs/nfsd/nfsfh.c | 165 ++++++++++++++++++++++++++++++++++++++++++++++++
 fs/nfsd/nfsfh.h |  13 ++++
 2 files changed, 178 insertions(+)

diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
index ed85dd43da18..86bdced0f905 100644
--- a/fs/nfsd/nfsfh.c
+++ b/fs/nfsd/nfsfh.c
@@ -11,6 +11,7 @@
 #include <linux/exportfs.h>
 
 #include <linux/sunrpc/svcauth_gss.h>
+#include <crypto/skcipher.h>
 #include "nfsd.h"
 #include "vfs.h"
 #include "auth.h"
@@ -137,6 +138,170 @@ static inline __be32 check_pseudo_root(struct dentry *dentry,
 	return nfs_ok;
 }
 
+static int fh_crypto_init(struct svc_rqst *rqstp)
+{
+	struct encfh_buf *fh_encfh = (struct encfh_buf *)rqstp->rq_crypto;
+
+	/* This knfsd has not allocated buffers and reqest yet: */
+	if (!fh_encfh) {
+		struct nfsd_net *nn = net_generic(SVC_NET(rqstp), nfsd_net_id);
+
+		fh_encfh = kmalloc(sizeof(struct encfh_buf), GFP_KERNEL);
+		if (!fh_encfh)
+			return -ENOMEM;
+
+		skcipher_request_set_sync_tfm(&fh_encfh->req, nn->encfh_tfm);
+		rqstp->rq_crypto = fh_encfh;
+	}
+	memset(fh_encfh->a_buf, 0, NFS4_FHSIZE);
+	memset(fh_encfh->b_buf, 0, NFS4_FHSIZE);
+	return 0;
+}
+
+static int fh_crypto(struct svc_fh *fhp, bool encrypting)
+{
+	struct encfh_buf *encfh = (struct encfh_buf *)fhp->fh_rqstp->rq_crypto;
+	int err, pad, hash_size, fileid_offset;
+	struct knfsd_fh *fh = &fhp->fh_handle;
+	struct scatterlist fh_sgl[2];
+	struct scatterlist hash_sg;
+	u8 *a_buf = encfh->a_buf;
+	u8 *b_buf = encfh->b_buf;
+	u8 iv[16];
+
+	/* blocksize */
+	int bs = crypto_sync_skcipher_blocksize(
+				crypto_sync_skcipher_reqtfm(&encfh->req));
+
+	/* always renew as it gets transformed: */
+	memset(iv, 0, sizeof(iv));
+
+	fileid_offset = fh_fileid_offset(fh);
+	sg_init_table(fh_sgl, 2);
+
+	if (encrypting) {
+		/* encryption */
+		memcpy(&a_buf[fileid_offset], &fh->fh_raw[fileid_offset],
+				fh->fh_size - fileid_offset);
+		memcpy(b_buf, fh->fh_raw, fileid_offset);
+
+		/* encrypt the fileid using the fsid as iv: */
+		memcpy(iv, fh_fsid(fh), min(sizeof(iv), key_len(fh->fh_fsid_type)));
+
+		/* pad out the fileid to block size */
+		hash_size = fh_fileid_len(fh);
+		pad = (bs - (hash_size & (bs - 1))) & (bs - 1);
+		hash_size += pad;
+
+		sg_set_buf(&fh_sgl[0], &a_buf[fileid_offset], hash_size);
+		sg_mark_end(&fh_sgl[1]);  /* don't need sg1 yet */
+		sg_init_one(&hash_sg, &b_buf[fileid_offset], hash_size);
+
+		skcipher_request_set_crypt(&encfh->req, fh_sgl, &hash_sg, hash_size, iv);
+		err = crypto_skcipher_encrypt(&encfh->req);
+		if (err)
+			goto out;
+
+		/* encrypt the fsid + fileid with zero iv, starting with the last
+		 * block of the hashed fileid */
+		memset(iv, 0, sizeof(iv));
+
+		/* calculate the new padding: */
+		hash_size += key_len(fh->fh_fsid_type) + 4;
+		pad = (bs - (hash_size & (bs - 1))) & (bs - 1);
+		hash_size += pad;
+
+		sg_unmark_end(&fh_sgl[1]); /* now we use it */
+		sg_set_buf(&fh_sgl[0], &b_buf[hash_size-bs], bs);
+		sg_set_buf(&fh_sgl[1], b_buf, hash_size-bs);
+		sg_init_one(&hash_sg, a_buf, hash_size);
+
+		skcipher_request_set_crypt(&encfh->req, fh_sgl, &hash_sg, hash_size, iv);
+		err = crypto_skcipher_encrypt(&encfh->req);
+
+		if (!err) {
+			memcpy(&fh->fh_raw[4], a_buf, hash_size);
+			fh->fh_auth_type = FH_AT_ENCRYPTED;
+			fh->fh_fileid_type = fh->fh_size; /* we'll use this in decryption */
+			fh->fh_size = hash_size + 4;
+		}
+	} else {
+		/* decryption */
+		int fh_size = fh->fh_size - 4;
+		memcpy(b_buf, &fh->fh_raw[4], fh_size);
+
+		/* first, we decode starting with the last hashed block and zero iv */
+		hash_size = fh_size;
+		sg_set_buf(&fh_sgl[0], &a_buf[fh_size - bs], bs);
+		sg_set_buf(&fh_sgl[1], a_buf, fh_size - bs);
+		sg_init_one(&hash_sg, b_buf, fh_size);
+
+		skcipher_request_set_crypt(&encfh->req, &hash_sg, fh_sgl, hash_size, iv);
+		err = crypto_skcipher_decrypt(&encfh->req);
+		if (err)
+			goto out;
+
+		/* Now we're dealing with the original fh_size: */
+		fh_size = fh->fh_fileid_type;
+
+		/* a_buf now has the decrypted fsid and header: */
+		memcpy(fh->fh_raw, a_buf, fileid_offset);
+
+		/* now we set the iv to the decrypted fsid value */
+		memset(iv, 0, sizeof(iv));;
+		memcpy(iv, &a_buf[4], min(sizeof(iv), key_len(fh->fh_fsid_type)));
+
+		/* align to block size */
+		hash_size = fh_size - fileid_offset;
+		pad = (bs - (hash_size & (bs - 1))) & (bs - 1);
+		hash_size += pad;
+
+		/* decrypt only the fileid: */
+		sg_set_buf(&fh_sgl[0], &b_buf[fileid_offset], hash_size);
+		sg_mark_end(&fh_sgl[1]);
+		sg_init_one(&hash_sg, &a_buf[fileid_offset], hash_size);
+
+		skcipher_request_set_crypt(&encfh->req, &hash_sg, fh_sgl, hash_size, iv);
+		err = crypto_skcipher_decrypt(&encfh->req);
+
+		if (!err) {
+			fh->fh_size = fh_size;
+			/* copy in the fileid */
+			memcpy(&fh->fh_raw[fileid_offset], &b_buf[fileid_offset], hash_size);
+			/* trim the leftover hash padding */
+			memset(&fh->fh_raw[fh->fh_size], 0, NFS4_FHSIZE - fh->fh_size);
+		}
+	}
+	// add a tracepoint to show the error;
+	// if decrypting, we want nfserr_badhandle
+out:
+	return err;
+}
+
+/* we should never get here without calling fh_init first */
+int fh_encrypt(struct svc_fh *fhp)
+{
+	if (!(fhp->fh_export->ex_flags & NFSEXP_ENCRYPT_FH))
+		return 0;
+
+	if (fh_crypto_init(fhp->fh_rqstp))
+		return -ENOMEM;
+
+	return fh_crypto(fhp, true);
+}
+
+/* Lets try to decrypt, no matter the export setting */
+static int fh_decrypt(struct svc_fh *fhp)
+{
+	if (fhp->fh_handle.fh_auth_type != FH_AT_ENCRYPTED)
+		return 0;
+
+	if (fh_crypto_init(fhp->fh_rqstp))
+		return -ENOMEM;
+
+	return fh_crypto(fhp, false);
+}
+
 /*
  * Use the given filehandle to look up the corresponding export and
  * dentry.  On success, the results are used to set fh_export and
diff --git a/fs/nfsd/nfsfh.h b/fs/nfsd/nfsfh.h
index f29bb09af242..786f34e72304 100644
--- a/fs/nfsd/nfsfh.h
+++ b/fs/nfsd/nfsfh.h
@@ -60,6 +60,9 @@ struct knfsd_fh {
 #define fh_fsid_type		fh_raw[2]
 #define fh_fileid_type		fh_raw[3]
 
+#define FH_AT_PLAIN		0
+#define FH_AT_ENCRYPTED	1
+
 static inline u32 *fh_fsid(const struct knfsd_fh *fh)
 {
 	return (u32 *)&fh->fh_raw[4];
@@ -284,6 +287,16 @@ static inline bool fh_fsid_match(const struct knfsd_fh *fh1,
 	return true;
 }
 
+static inline size_t fh_fileid_offset(const struct knfsd_fh *fh)
+{
+	return key_len(fh->fh_fsid_type) + 4;
+}
+
+static inline size_t fh_fileid_len(const struct knfsd_fh *fh)
+{
+	return fh->fh_size - fh_fileid_offset(fh);
+}
+
 /**
  * fh_want_write - Get write access to an export
  * @fhp: File handle of file to be written
-- 
2.50.1


