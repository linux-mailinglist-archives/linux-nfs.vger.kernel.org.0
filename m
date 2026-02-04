Return-Path: <linux-nfs+bounces-18723-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id Mi8jFK6qg2lvsgMAu9opvQ
	(envelope-from <linux-nfs+bounces-18723-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 04 Feb 2026 21:23:10 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 64253EC6A6
	for <lists+linux-nfs@lfdr.de>; Wed, 04 Feb 2026 21:23:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A0E923004628
	for <lists+linux-nfs@lfdr.de>; Wed,  4 Feb 2026 20:23:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76133340283;
	Wed,  4 Feb 2026 20:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="OIrbXl7e"
X-Original-To: linux-nfs@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11023119.outbound.protection.outlook.com [40.107.201.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E75C823C51D
	for <linux-nfs@vger.kernel.org>; Wed,  4 Feb 2026 20:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.119
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770236585; cv=fail; b=P35miIYnAypGh2SX8cdWu0xqga+uU2ZE7kBlteD5in3dJxs8l6vKl0GhKgi0bfsimF4ccbViSv1b/MWD6jZtp2mD7+Wa4nZ7e9188nT54UywHrWpsSS0et+LvdJx9NyXAigZA3MSrNRBv8T0JxzJthiaifqP0ohaakPOZMbd5CI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770236585; c=relaxed/simple;
	bh=TQ2QxY/Vx2JaX+wva3h/o8AKCi8FX1W3rkgaFHIn/Qo=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=LND0nVCqCGIIohEG5Su50WijjhW4f+L2E8IgcBb2qlJFDVpiGLOXjTObDnSzWUzXIoBzSCHrNaydPKdJ9wNZCRA142PcBvE5p1P0UtHKdtGEOl1j0gE6iEdLhyiUMlUc8WbSWMUPniDYyQZbKeBDPaiX7OAAJdbg8TOnj/YIhSw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=OIrbXl7e; arc=fail smtp.client-ip=40.107.201.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eJDEtGHWROMaHh6veXps3G3udVOYubk55TMfcRigHf4sdCJ4OhPZs75j5KU/6MpBzg/uoi5yt3ZC/xpER8LDrPgkM0bihYEOIePMlMSO97vB7UamzFyw+xi+AaVtqHbRJf8R+hjSj1jVJsoz9Dwq9K3qBKE333UfLngYUUU++OOuseEbiLNqS+OHqq7ObJWh6ZoOBHlMtMfoSJAvvaveerQv4VplG5+K2+R+QPDGlqlBJzOJvok/naKJ/JFfG37Jl+4FkIj9NUe4PAx1MQttIl9HqQwqi+J2LiEuFE6DcZa16rupEY3V4Ua1cg+lMJi7IyLTzZHvNuFgJPLH9cVMmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IEhWMvxhvus7mNwrMx+o+dz547wnHHu5m12ISKEsFNc=;
 b=RLUTPj7Muv1GSNQ7+B2YZ8K/Y6+gq9tumyjcuvHmGMTxbvnCZjfSPX4tb3/UxjKD3eA79OWjprApRvtQBTduqE+fC0t3i1ya9W2JxIsOVeB8rX7rOy9EIYqOzvIhybk9mQEnDfytHOiJ/jYe4XcUUSzntYHzSSCW5TL7lD8ru8gwdfqieqw8UUaBdaBrDTbdsBZV30FDoh9f9p3hxuULlWdftnZt4FWppQJ0DscK69d8NL7NKC6FUZNLmF9SBXZmd9x6OkGtj8yLUszKK47oTEdlg/frlOGr2CpFwqwb7ue6JsXBKEyGqbNnErFAA1OujfgGcEcfo9o9S/4uy07bKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IEhWMvxhvus7mNwrMx+o+dz547wnHHu5m12ISKEsFNc=;
 b=OIrbXl7e0mNlYBSz1C0rBlFJN2I1wsVUROhH3i8E3+d9/hVqGSRV9zoZogsg2ruuZ3r7M5/lNoh1YMgprwD3Ev8EtQSMkpeo8+PCkgfpbkyj7tpqO4T8msd7TyHuSAn7Kj994HbNa8XtRPV8TUQV8NBm6nnzZspqYv7yGQmyH2g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
Received: from DM8PR13MB5239.namprd13.prod.outlook.com (2603:10b6:5:314::5) by
 MW5PR13MB5440.namprd13.prod.outlook.com (2603:10b6:303:191::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.16; Wed, 4 Feb 2026 20:23:00 +0000
Received: from DM8PR13MB5239.namprd13.prod.outlook.com
 ([fe80::fa6e:7b5:d1ec:92f3]) by DM8PR13MB5239.namprd13.prod.outlook.com
 ([fe80::fa6e:7b5:d1ec:92f3%4]) with mapi id 15.20.9564.016; Wed, 4 Feb 2026
 20:22:59 +0000
From: Benjamin Coddington <bcodding@hammerspace.com>
To: Steve Dickson <steved@redhat.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH] nfsdctl: load modules on nl family resolution error
Date: Wed,  4 Feb 2026 15:22:56 -0500
Message-ID: <09076517d782c31cc0a654563b42b78c846c5f38.1770236512.git.bcodding@hammerspace.com>
X-Mailer: git-send-email 2.50.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH7P220CA0088.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:32c::32) To DM8PR13MB5239.namprd13.prod.outlook.com
 (2603:10b6:5:314::5)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR13MB5239:EE_|MW5PR13MB5440:EE_
X-MS-Office365-Filtering-Correlation-Id: 753b4274-c67a-44e1-d833-08de642b307e
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PC/hfO5PU6M2DyzI894YwdHyYUCYxxFmM+NMFJfp41shm6jRIvZDlph/66RO?=
 =?us-ascii?Q?Eg4PMiQ0RgjyWHG4rbaSoCbOeL6+TIlT+v+/rHp3JILK7FXSgLqlQDFS1qvs?=
 =?us-ascii?Q?3XuFvtTsSYAQ5u/FEuiYAT7jtYcxcgaOG3bqBWapwXGDV6LzryfD+Z2Ve9tf?=
 =?us-ascii?Q?PgFQSkzB0vLMwTWO6T/eUW/5/oosMW/yyB8KRXjuLOET0xEWX71eWrRxAfmZ?=
 =?us-ascii?Q?s47alHf4CXHCC5XUSx1+RUiQflFb6XE6DKA8+R2T09ApylsNEqXh2/W3b14L?=
 =?us-ascii?Q?SKtaCmI9bSx4AbGuMmHsePD/iJEHr6yoiRc53NwayHiwcVp/Rt0e/quiaxhs?=
 =?us-ascii?Q?gKfBWjIDLebHQWhieBEJcFhfWU8POZgKxJXdDFrTjR+P+mTn/dJsepFeLsKR?=
 =?us-ascii?Q?6/exFd53VoPine05EwsmVHz8UpnSOvh/Sx1at3jmoZJ+pwP0grpicV3HPt7d?=
 =?us-ascii?Q?UAaGEEP1mYSJfetuWDYzgd0RfDKe3FjR5ujWM+i6tWrJ482u2lW/uBrEfwcx?=
 =?us-ascii?Q?I0qeyEZmuLA1vF1htASsYx92JH3WZ0UGI5uW5FDv5qxaAgtkxGj3jJU3wFKg?=
 =?us-ascii?Q?ro6w2cKg6bzHFbHl5Ff9NXb1x1ejcwhYK2B2yOkBB+lzLeQWwa3o1TBqswAU?=
 =?us-ascii?Q?ySxZ4PnNL+pKycqLCk6leRlvtoREQSluTvio2LlHQ6rCeao7Bd+5Uv3/6q5g?=
 =?us-ascii?Q?onbCeRshKKUK3JJSTMuqKnx0U2QCWVJ+nvl9CeOvMe0ShprOmXmW7B6b+1hO?=
 =?us-ascii?Q?UfpC3LoilJzcIYhRrrgRz1yOLyQR3mQNb7HAUgAaqh4BG7mKeGAyx2ByDMYs?=
 =?us-ascii?Q?e/p87yKMnTYYg5s20QUMp+ocyRRXBIIyaJR70LyVM+rPDh3OraY6+cw6+kJx?=
 =?us-ascii?Q?jW548BdGug6h5KF0937RYQZcCgvHyeAFLEmmwSAFlCF4Hs2cVv20deKufVM7?=
 =?us-ascii?Q?CaFbQkUmyl9qshcp6kF0eN24nnPbLanbKLGGIffUYvJzYs2QixfnleXITEcX?=
 =?us-ascii?Q?MeIS3rLPrMjGrwsSfy6RhHrC3wNUr7cy1WEo2VlgV+CVeLdh4pE+Oo4nXaGl?=
 =?us-ascii?Q?P2KhxayTMYTQrAo3l0+Fec3UFR2J8XpoclhSm6ZSRSfVljKZ1xk+yPYhTg32?=
 =?us-ascii?Q?4MU7IySdP7+p0c1yqQJXPb6Jo2bSeDFJXuDhLUdUwk0+LjEUO63StedmBc2M?=
 =?us-ascii?Q?c/63Xs03rFkFANBFRjUsLbA/DQYKixnR6aE8lw/hlfQnCi05ejdZwWl6+A3h?=
 =?us-ascii?Q?x8dvPi6eQaoPUARsNzodE0SRJmX+DcQLsehLvhjPyQJHAg1xKzbukKEbal3E?=
 =?us-ascii?Q?c8jeRzV6zACRMN7bRZ7/g+4sie0venvkUd1mdjNdPcmAkYUFsN2f5dtmFigQ?=
 =?us-ascii?Q?16j5RRDs8gc3bgA5yqalGGZ4F2KwqYIuD5gwOaaLKReq2TKB1Wn9lZC/Uros?=
 =?us-ascii?Q?RlBXClX38gT8fyDW0h5KyzV69nIEN/rvaRC8MdPiyFTYMYtBiiUN3RaY+yFA?=
 =?us-ascii?Q?nBwDiuW/BOY0ZnMeIHilUrSeGHpTAwISWfXs2uNA32TsIzVpzDNg1N9ed64k?=
 =?us-ascii?Q?jbDeHdgvBgkiWTF0Azs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR13MB5239.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nPqAHpWiBE9Z11RE19hcuP9HnfkDS+wfYcJjujL1mQDJC1Tnz6LOM89vZCGW?=
 =?us-ascii?Q?76NNS79RYmx7MzaG52kobUsVkYg4M5RhtZ5S++bDDIMsnY7q+wM2fUhhfoIW?=
 =?us-ascii?Q?dM7+JJAzBCK0VQp8cxJ7vAC3OshxT8XcoLk5D24luAyfGkQKrgAtW+1jnd/w?=
 =?us-ascii?Q?IsEjFHCCTCrBqPKAtJ1aYyx8L6WLAmAcBx2IGE9p7rQlgFwXcwOGjfCDfZUF?=
 =?us-ascii?Q?UD6mN62WXKH75d0wG5YjoUcwNVO21OYrkQqubgJzsu6AmTVQJx6xTQsM46Z2?=
 =?us-ascii?Q?A5er9NQC/DerShinfCo5IoG7Au1KLHY0fpItSFgxD7r30b4JB6h49M2zsVD4?=
 =?us-ascii?Q?UracWaY2KCv0GwCKAu9s1GVd0oPniz0gJb73Qa8S+pvaUBuQV8nS4srmoG2h?=
 =?us-ascii?Q?khFTVj2HshyAzx3ziPRO3baYzsWPVgYzsX2IDpD7zW9R3MeopPsQfzkgqtyF?=
 =?us-ascii?Q?kasw5gGwUT+ZCnbW4Z98glS1vrk6HYgRRG5ZZWgoPKVdXanpBcrUDZqrHEqd?=
 =?us-ascii?Q?LsfdNQU+VDNmOwHaBRyHXE+ZsdzfGFkYSpurTugrBHJD+RTJx3vmvXvk23Xa?=
 =?us-ascii?Q?R6QOIwz/LUsjHikvU3FFvCMC2bS1XExba0rvwXK04Yq/EdqELjrDBNP8FXuN?=
 =?us-ascii?Q?Y38frTS26rpq+IA46clpTRBZCI6PKrLfKzCBcWTsYFVI9qh2y4Lme7JvGc/r?=
 =?us-ascii?Q?QfUDqf+CZYg3/1D+6ch7thEpAkXuDDzqHEZ9HIx1STVBqdhY4g1Ct8KIUyzZ?=
 =?us-ascii?Q?0rQM9635KhCMyz3dnjR2qUhJZlRgxrZlQmUMLWcCqvde9YviCjcHjEoh0t3X?=
 =?us-ascii?Q?o69FL1UQlUKWtouubJPjwdrmxOPw7gwQM+GUcKXD2bHrtiUbMFEA4920wnHK?=
 =?us-ascii?Q?svV+9t5/rO5+Nt/9kns5Oznvt0W9f434Kj101GHhCgWVGCWL6PFKM+LNkPuK?=
 =?us-ascii?Q?sa+34PK3FtpSx611nPR+E09XjwGSavW8tZ95RrAuiuyjP83SJHE+aUNSoHhN?=
 =?us-ascii?Q?iAwtPKWQ6oLp1Dd82NtASANjfUUISXaVpYqBaAbQQUp74K6ycI3ll8SJzEAB?=
 =?us-ascii?Q?xC4Y2Uy3P+fQXiR+IIRvbiNYQp/pOlzQQ5e1fl582gj5lszssQjMYOQq587t?=
 =?us-ascii?Q?DzSyapSFWAdg016Z9SpO+kbbamxT0sOjLhE/Dy5Y/GkTZwNXMA80P8UOTfWf?=
 =?us-ascii?Q?m3Aeny2klrps4gBDBzy7uHt5iBQxquQoRGoHt/jxBDa2xHAJvXTaSm4/RiWl?=
 =?us-ascii?Q?O1AtTkFVtaTJQ19TzMQ2PXV0rA0HbdBcVLLyW1l6jCDSPleTSrnra95L5MZE?=
 =?us-ascii?Q?t5TtbjBdOwY4BRVT7HSb8BhvDFtJk3K3f6X1nPsLcTxVnAFRnG8y3gg4AzEd?=
 =?us-ascii?Q?ptHFKOtzhiSxzQjFZw/ETXXCW1xG5uGN9jlrMZrQKiXGb3Kp1A+XamdbYor1?=
 =?us-ascii?Q?XvIQ/8PCOWdLJWP3D9J8CrigyG/eeLAqENDJT5BTgqK+OaR3qqKDIaikh3Mz?=
 =?us-ascii?Q?2WnwtprT4SMU88oEPKUuAHySWoD7/SOxAK66Oikqm0AHKJgZD81556/R8WmT?=
 =?us-ascii?Q?pgQdDUdfM2Ei5wp1X22Wk9xChLq+/V38/t/i7EvoFwEJ6z9dIjr2t+p4p6Zj?=
 =?us-ascii?Q?8Xys3NHDJGoq2WKkWibBMMaQpuN20g3dLd8E2iO2x51VfAuE43200Q55UNXZ?=
 =?us-ascii?Q?IHZ9y5IJgbybwS2H4D6U0haf7LqPVZziRhwLmBAZfQSzHxSqhXqoM6qwkP2y?=
 =?us-ascii?Q?ZaN2pf9VizkQjxiTf+MTwYEEtRn9XKs=3D?=
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 753b4274-c67a-44e1-d833-08de642b307e
X-MS-Exchange-CrossTenant-AuthSource: DM8PR13MB5239.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2026 20:22:59.7056
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xrg1oFLSgLxRsRv+LYmGKtoAZMbrYNaUsceK8Q/EZbDM1RgkYzWvpwM+Exq8dLIDZpSsfoJOB+fK+9PoWaLpwN6i4iMRNPK4L5lS+cSNMxc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR13MB5440
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[hammerspace.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[hammerspace.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_THREE(0.00)[3];
	TAGGED_FROM(0.00)[bounces-18723-lists,linux-nfs=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bcodding@hammerspace.com,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[hammerspace.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-nfs];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 64253EC6A6
X-Rspamd-Action: no action

There's a precedent of attempting to load kernel modules for userspace
functionality: rpc.statd will "modprobe lockd" and rpc.nfsd will "mount -t
nfsd" which uses the kernel's internal module loading to load the nfsd
module.

Let's do the same when nfsdctl's name resolution fails.  First try to
resolve and if that fails tray again a simple effort to load the required
module.

Signed-off-by: Benjamin Coddington <bcodding@hammerspace.com>
---
 utils/nfsdctl/nfsdctl.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/utils/nfsdctl/nfsdctl.c b/utils/nfsdctl/nfsdctl.c
index 2b01f705874a..6a20d180a81e 100644
--- a/utils/nfsdctl/nfsdctl.c
+++ b/utils/nfsdctl/nfsdctl.c
@@ -458,12 +458,12 @@ static struct nl_msg *netlink_msg_alloc(struct nl_sock *sock, int family)
 	return msg;
 }
 
-static int resolve_family(struct nl_sock *sock, const char *name)
+static int resolve_family(struct nl_sock *sock, const char *name, int loglevel)
 {
 	int family = genl_ctrl_resolve(sock, name);
 
 	if (family < 0) {
-		xlog(L_ERROR, "failed to resolve %s generic netlink family: %d", name, family);
+		xlog(loglevel, "failed to resolve %s generic netlink family: %d", name, family);
 		family = 0;
 	}
 	return family;
@@ -471,15 +471,25 @@ static int resolve_family(struct nl_sock *sock, const char *name)
 
 static int lockd_nl_family_setup(struct nl_sock *sock)
 {
-	if (!lockd_nl_family)
-		lockd_nl_family = resolve_family(sock, LOCKD_FAMILY_NAME);
+	if (!lockd_nl_family) {
+		lockd_nl_family = resolve_family(sock, LOCKD_FAMILY_NAME, L_WARNING);
+		if (lockd_nl_family) {
+			system("modprobe lockd");
+			lockd_nl_family = resolve_family(sock, LOCKD_FAMILY_NAME, L_ERROR);
+		}
+	}
 	return lockd_nl_family;
 }
 
 static int nfsd_nl_family_setup(struct nl_sock *sock)
 {
-	if (!nfsd_nl_family)
-		nfsd_nl_family = resolve_family(sock, NFSD_FAMILY_NAME);
+	if (!nfsd_nl_family) {
+		nfsd_nl_family = resolve_family(sock, NFSD_FAMILY_NAME, L_WARNING);
+		if (!nfsd_nl_family) {
+			system("modprobe nfsd");
+			nfsd_nl_family = resolve_family(sock, NFSD_FAMILY_NAME, L_ERROR);
+		}
+	}
 	return nfsd_nl_family;
 }
 

base-commit: 8f54511aefe1455161a6c4406ed8c770139f61e3
prerequisite-patch-id: b0d57152c98d360daa9a71e6fa9759b7eb9de348
prerequisite-patch-id: 99680869954aef9f878c24ec9ee1302ab7f24b1a
prerequisite-patch-id: 2ab31271461352d11bcce760e45573f9e6459553
prerequisite-patch-id: 22c392c9dba2e63916af6cd8fbf4e9d6bce9d01c
-- 
2.50.1


