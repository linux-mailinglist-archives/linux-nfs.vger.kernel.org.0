Return-Path: <linux-nfs+bounces-19835-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CLWvKQ8Aq2lxZQEAu9opvQ
	(envelope-from <linux-nfs+bounces-19835-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 06 Mar 2026 17:25:51 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 02044224DD7
	for <lists+linux-nfs@lfdr.de>; Fri, 06 Mar 2026 17:25:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 74A553173DD8
	for <lists+linux-nfs@lfdr.de>; Fri,  6 Mar 2026 16:19:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEC053D3329;
	Fri,  6 Mar 2026 16:19:38 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from LO0P265CU003.outbound.protection.outlook.com (mail-uksouthazon11022121.outbound.protection.outlook.com [52.101.96.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E4FA3ED12E
	for <linux-nfs@vger.kernel.org>; Fri,  6 Mar 2026 16:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.96.121
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772813978; cv=fail; b=g+rIDmbKeZujPv6ybhL4G897xrrYo8TLccNVymiDaT5oNt5CebeZ43xOjSwN8uADzRj/2NlTLBvbA8BbM/Lf7bBdzDt1kIlJEunAbv+C5AO8w+hvsnbu7camzzUjaZGVFglh8uGzlrNxULRT6UWaGzvmyrDFSr2Jah9J0MHRJOs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772813978; c=relaxed/simple;
	bh=YRb9qGchanMXkbfShzm1HKov+3TuiBpSJsM6qHZX9fg=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=HpZK5DlRODz8w633Iw6C3EJhG+LW9Xvg9AKhCV2SLNLZkLLtLOw6vLat8nsC1lqkVbHpkN+A0Gor6j7LiiusPN27ozURBN2bJ92kY4J4S6OuPq8m9+hlTbH5tVhp/dNUXPBl4VkUktp4idV1kGrePLmZcZDiC0Spd0dwCBDiO8I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.96.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jDRPmUsnKrWaTLdOTPz1sMC8MtVi7j1opd5bk1c7vnDBufSZ2jT4gSi1jSSENBwEFWan9MM9tdEvzTFfmHLX1Gmq/OBfSaySbFvyFQ8eP59RN6KvJOFucKRw0ZktBUttUCYa9iosJ2exdSLnOqY8sllIbT4yX0wzkW7UdpbppzSA8pCFGP0iRvaynjYENTr3c2xLwVSuP6DEFmmrbKaIvymnnQdsJqep0xxhbF6qJYAflxG53Lx1lWE+4Ce/Gc2JykJW86CAhzJMxYFZHX9QJoAxnpwUH1j4XHh1SguYFz1Ue1NVYu62qxVoxHUnauRWX1JGuSB/2ODt4i1u21qcqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LGo+KjrEz8gFbwinKPosJ5jHcWo+VjE50t2tN/jzieM=;
 b=xRMdQ5JJT4CGazBnvs9R9bISg6EmnHD0JJrjavCxclXw0FNCgnDBLoJWFYkf2LCj8AXHRfAobipa0XN5rYPM3Nr/D/V+fM8C2+62SMlufLQq2pH5ctsZrx/EKAIyfuCosLrOTIX2gFeXB+hvA4iwet6QoceMQPWJqjcWORvyJ2RP4zN+5/tvNZLfmk0p/FlUaYAJ1tkiZsC1/vFXUeq3U+B26HKgoCt+drl28vBibj8XHkIA/l9+2mMjStsqJWIGcP/8z1cibdsEn8FlVpOxIWBDlCpHM1oVY8O5rIlPkp6Y+NyW7xdJTSLlkSBYlMLIBapv07zNwebcnTaamvZoDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:70::10)
 by CW1P123MB8870.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:272::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.19; Fri, 6 Mar
 2026 16:19:33 +0000
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf]) by CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf%2]) with mapi id 15.20.9678.017; Fri, 6 Mar 2026
 16:19:33 +0000
From: Aaron Tomlin <atomlin@atomlin.com>
To: steved@redhat.com,
	tbecker@redhat.com
Cc: yi.zhang@redhat.com,
	linux-nfs@vger.kernel.org
Subject: [PATCH] nfsrahead: enable event-driven mountinfo monitoring and skip non-NFS devices
Date: Fri,  6 Mar 2026 11:19:29 -0500
Message-ID: <20260306161929.4148128-1-atomlin@atomlin.com>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: IA1P220CA0023.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:464::7) To CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:70::10)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB3523:EE_|CW1P123MB8870:EE_
X-MS-Office365-Filtering-Correlation-Id: 073920d7-827d-433f-2932-08de7b9c26c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	/1WoF/3OoLhfqKOOcfja3+22XlI83uktjyEcOgsgnArmBAOKTTg7s+WnWi4X6z+BScns9GejJ8Kkeqp47UC9nSvKevzjEvloKi3r6ZAM7VdAi9uNQTcGGSEBfjQkwJBh/xLklEXgfgzqhlSTXA568f4z//g8WwRKW/u5zq+wN8LYGpjlLiwqNhtWgrMVwkUB5lVtWiOTpEpHrWmnZw1gZG0XMwyJKyHNO6w9yNki37GWGF2tV/cJjhw4q5uQZuviRa0dE0PLKCflKjoZfY9GijD9qKErZA/xMn44zIw6bc2OZafNOvRNH4SP6fLStEf8ibZJEP9AraZLOO8nnlIATSMEPz0r1KaCMaInuHpgOTQCmgXnVyhJt8fj8RbhhIxHyXKnMOgXfjIiL82fNE8IoLt+Q1bRh+Rz5bTB/pF1UuGZguKxECmDOkqTqUE7Af6b6f0uj+J8GR0GvOuLDnFdq+0pc63QxeAIdrifP1/tLA+1yODQ8y/vMy84sta3THq9pFTOVhZBOjNhFVEdJf/CIFbfHs5jFjfJr2TBEstCdiS6vOYh4VBmDTxL4H4rEWeRsoROpjwTlYG9JhjxAv5FQbJlOBmXacKUVFKOQNIP9RhDVkGImnvtE2c1ZYv17lITjvgPozVPrUn0hfIgbAvZ83Ezd3DC0Sv2gvpYKtdZ+1c5Dphft8LynZDv0UjIJ+TN
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WXp/KSvab1A34hEaFyi3yuFS4yb2uvhIOQSBXzzb7hXq/TbjCow03Ru2WuxD?=
 =?us-ascii?Q?9ckH1NaOBs+hM14orcZ1kPvZ8mxBBGkrB6ARw347DSh9Fj7E5E6AVY2rwiK0?=
 =?us-ascii?Q?xGuRh9bd2qbFbeUc0ZNYtMfjYcEbpOvJXZwTBmL3mN8uRmS42ElvG2cwpq4M?=
 =?us-ascii?Q?LKwm0LRYxCdl0wRzHa/e5tm8roDVDyzb6+zgwWGP2DjSmHgNw1JqSXpHfZjI?=
 =?us-ascii?Q?f0UDmm1UJ5NoFY8c7aHpDtWh4pGy/2eTQW02Yp0JMeDtHlv4K8KP8zdqbVTy?=
 =?us-ascii?Q?HuqJUGXolM/SlCSOsp32NrpGkCRUwMiLKcH8a5LdbQPTarNVfE4Aktl5isFs?=
 =?us-ascii?Q?hiY6DEy1ezQ8pzyWfpJeWzA9jhr0OgAkbDtUYjkeeu817j73XHmVBLxXkm6k?=
 =?us-ascii?Q?8DE6xsisDnwrWhjrq2qwo9QTo9P6VfUgAEcrj9qfqaTg6EV4dxyC363uIkFi?=
 =?us-ascii?Q?gHwANfAQZ2th/fVEDthIwalP0shbqjv/ZuNuhYOeDFq5yZ99mZ/qeN3H83vb?=
 =?us-ascii?Q?iM3ES1CncPnQe7mIuHuj10s5I7tUPUVsvt9Wdh4ZfV7bMmeP/VOsLneynlIs?=
 =?us-ascii?Q?y/KKGWgwmqjkSQUHIHHAtxeGxGa6K5WXRIGcrrhzo830slfMhZL4vr2VxYUH?=
 =?us-ascii?Q?oOTYk0PxfotZF7hoVEdTE7p7telmKfXenpjOeQqx8CBxO1wet7+RNFOvdb7f?=
 =?us-ascii?Q?bNBMdI6qtvpn36l9HKSN4nFmgT43HtTQNPGVWStyU1C2mIufDhTKUuFXYSvS?=
 =?us-ascii?Q?CEKRPoecCy+iD0dS5+G3WIYUGttWBAHgy8WFuPY8gLXNTuNn6d+No6+ekv4X?=
 =?us-ascii?Q?idjV3au37WuGDA9e+4lGgVf/DowB2Kp80iQcJCwwVKJRxHqLEQlh5Rj8wqOu?=
 =?us-ascii?Q?zrYapQ464Zy1CwJbDoY1AL9783b5pcY/G6SAtpYo52kRXEEjLCo7SubMXUYq?=
 =?us-ascii?Q?E0g9wXvsjOPsq6vX1x+0h5scrmnKzlTgpc4M9sqqqevFkvRskLTRNap7Y+ld?=
 =?us-ascii?Q?OFu1gT9vNYPA9SW92Ibk7rxoFmm/DwvqAUeRG8oBhfr0Pt7Nukw9BYgZFbcJ?=
 =?us-ascii?Q?dbE6HREfZlgmRIePjIihwXqhmLnfzJ+cOaw/YZz0+nUNsmeSuINIcqUDXuzh?=
 =?us-ascii?Q?Z/sZYWTJfxsOBW6BgPiNMGO1LQ9wU5kiRXfIkM2XsBGm+cE61dYlaI8QgoeA?=
 =?us-ascii?Q?5aNgP/+LvrPaCtKGMd0mBVOtXR9oNX2q/F2BrmOFssdHB+9QwwBraNpNbWc5?=
 =?us-ascii?Q?X42WaGS4WfeKHPX16zv74W9KqaYHYd+jIZK+L0LK9dTyLKK/EfswgB963qP7?=
 =?us-ascii?Q?cI+hwG2bPMZOtoBlbXMOd6FTlL48m0Fk40ye2iovuYfCDnOk0uI+2rEXNOp3?=
 =?us-ascii?Q?G+An/cmu/thbLvaXV9FVmL+CbF7HuzoraHyqW8SbTAi2eoXASMYcEAitdLxT?=
 =?us-ascii?Q?AMclAzAEJjS39+LFKSVIEw+qnaxK6rzh/rgtfuYqY40EmAqPaCeyFx+I5sYP?=
 =?us-ascii?Q?PtQqXKdCTwVsW+mLmS4ZiWGqoG2PKvKzeAtGa2Tc7u4q58WdFIh/H+j/9oel?=
 =?us-ascii?Q?QexZAPaau4yBrlmznhcT7rkw0V2roFKX3jzWuPcwpVBjhLdoo88rH0tbDayG?=
 =?us-ascii?Q?+J4OSoKUJ44/Mjaj38vtHA9sRjjv4qfVQmIuPTP5HO7GPduZVtFM8Dhc8QZj?=
 =?us-ascii?Q?qxo6V2Vsxfj1QgoXVqlDFLbbwZ08tIKnMfunvSAv2elq64XD/HzeL5V7HzMr?=
 =?us-ascii?Q?LMTZW0vOOw=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 073920d7-827d-433f-2932-08de7b9c26c2
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2026 16:19:33.2098
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dunjHdd4qc0hdI94oUdh3mJEeIIvjUKA4SE1fbaHMcuWKrobPu8SugeuLephhfqcRcl3PLc4hLcdb0Hq4z906g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CW1P123MB8870
X-Rspamd-Queue-Id: 02044224DD7
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.04 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19835-lists,linux-nfs=lfdr.de];
	DMARC_NA(0.00)[atomlin.com];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-nfs];
	R_DKIM_NA(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[atomlin@atomlin.com,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.561];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,atomlin.com:mid,atomlin.com:email]
X-Rspamd-Action: no action

The nfsrahead utility relies on parsing "/proc/self/mountinfo" to
correlate a device number with a specific NFS mount point. However, due
to the asynchronous nature of system initialisation, the relevant entry
in mountinfo may not be immediately available when the tool is executed.

Currently, the utility employs a naive polling mechanism, retrying the
search five times with a fixed 50ms delay (totalling 250ms). This
approach proves brittle on systems under heavy load or during
distinctively slow boot sequences.

To mitigate this race condition and improve robustness, update
get_device_info() to utilise the libmount monitoring API.

The new implementation introduces the following logic:

    1.  Initialises a monitor on /proc/self/mountinfo using
        mnt_new_monitor().

    2.  Replaces the fixed polling loop with mnt_monitor_wait().

    3.  Increases the maximum wait time to 10 seconds (MNT_NM_TIMEOUT).

    4.  Introduces a fast-path rejection mechanism. NFS backing devices are
        allocated from the kernel's unnamed block device pool (major number
        0). While some local multi-device filesystems (such as Btrfs) also
        utilise anonymous device numbers, physical hardware block devices
        (e.g., sda, nvme) always possess specific, non-zero major numbers.
        By instantly exiting with -ENODEV for any device string not
        beginning with "0:", we safely bypass the monitor for physical
        drives, preventing the exhaustion of udev worker threads.
        See set_anon_super() and get_anon_bdev().

    5.  Implements strict monotonic deadline tracking within the monitor
        loop to prevent indefinite blocking.

Fixes: 2b62ac4c ("nfsrahead: enable event-driven mountinfo monitoring")
Reported-by: Yi Zhang <yi.zhang@redhat.com>
Link: https://lore.kernel.org/linux-block/CAHj4cs8URj2fJ7KyP9ViAm6npVOaMiAErnw2uFyPYEU2wb7G_w@mail.gmail.com/T/#t
Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>
---

Hi Steve,

This patch should resolve the udev worker exhaustion issue reported by
Yi. It applies cleanly on top of the current nfs-utils tree, after your
revert [1].

Thank you.

[1]: https://lore.kernel.org/linux-nfs/20260305124221.55407-1-steved@redhat.com/


 tools/nfsrahead/main.c | 55 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 54 insertions(+), 1 deletion(-)

diff --git a/tools/nfsrahead/main.c b/tools/nfsrahead/main.c
index b7b889ff..78cd2581 100644
--- a/tools/nfsrahead/main.c
+++ b/tools/nfsrahead/main.c
@@ -3,6 +3,7 @@
 #include <stdlib.h>
 #include <errno.h>
 #include <unistd.h>
+#include <time.h>
 
 #include <libmount/libmount.h>
 #include <sys/sysmacros.h>
@@ -17,6 +18,8 @@
 #define CONF_NAME "nfsrahead"
 #define NFS_DEFAULT_READAHEAD 128
 
+#define MNT_NM_TIMEOUT 10000
+
 /* Device information from the system */
 struct device_info {
 	char *device_number;
@@ -117,7 +120,57 @@ out_free_device_info:
 
 static int get_device_info(const char *device_number, struct device_info *device_info)
 {
-	int ret = get_mountinfo(device_number, device_info, MOUNTINFO_PATH);
+	int ret;
+	struct libmnt_monitor *mn = NULL;
+	struct timespec start, now;
+	int remaining_ms = MNT_NM_TIMEOUT;
+
+	/*
+	 * Fast-path rejection:
+	 * NFS backing devices always use the anonymous block device major number (0).
+	 * If the device number does not start with "0:", it is a physical block device
+	 * and will never be an NFS mount. Exit immediately to prevent blocking udev.
+	 */
+	if (strncmp(device_number, "0:", 2) != 0)
+		return -ENODEV;
+
+	ret = get_mountinfo(device_number, device_info, MOUNTINFO_PATH);
+	if (ret == 0)
+		return 0;
+
+	mn = mnt_new_monitor();
+	if (!mn)
+		goto fallback;
+
+	if (mnt_monitor_enable_kernel(mn, 1) < 0) {
+		mnt_unref_monitor(mn);
+		goto fallback;
+	}
+
+	clock_gettime(CLOCK_MONOTONIC, &start);
+
+	while (remaining_ms > 0) {
+		int rc = mnt_monitor_wait(mn, remaining_ms);
+		if (rc > 0) {
+			ret = get_mountinfo(device_number, device_info, MOUNTINFO_PATH);
+			if (ret == 0) {
+				mnt_unref_monitor(mn);
+				return 0;
+			}
+		} else {
+			break;
+		}
+
+		clock_gettime(CLOCK_MONOTONIC, &now);
+		long elapsed_ms = (now.tv_sec - start.tv_sec) * 1000 +
+				  (now.tv_nsec - start.tv_nsec) / 1000000;
+		remaining_ms = MNT_NM_TIMEOUT - elapsed_ms;
+	}
+
+	mnt_unref_monitor(mn);
+	return ret;
+
+fallback:
 	for (int retry_count = 0; retry_count < 5 && ret != 0; retry_count++) {
 		usleep(50000);
 		ret = get_mountinfo(device_number, device_info, MOUNTINFO_PATH);
-- 
2.51.0


