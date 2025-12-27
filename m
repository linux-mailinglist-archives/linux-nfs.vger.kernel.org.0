Return-Path: <linux-nfs+bounces-17319-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F8E5CDFFD9
	for <lists+linux-nfs@lfdr.de>; Sat, 27 Dec 2025 18:04:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7E89D30062AD
	for <lists+linux-nfs@lfdr.de>; Sat, 27 Dec 2025 17:04:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F32281DF73A;
	Sat, 27 Dec 2025 17:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="PmEdjRPX"
X-Original-To: linux-nfs@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11021113.outbound.protection.outlook.com [52.101.52.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FF758834
	for <linux-nfs@vger.kernel.org>; Sat, 27 Dec 2025 17:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.113
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766855040; cv=fail; b=NWvCR7UmUW66MWsiJle7Z0OrMB6zzA1Wo/U8tJb4Y3B5VMWGsw7ZqARA1YacnChuI9W19S/aIFoj0Kbrj8FZ5OwgBUIu8L5m1o1eXglhQz49rhH3tFvgzgMns/A4fFpriKwCBx+KkbTqJTiAM+dgxIILCvRce1zWlLeKgRr5YYo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766855040; c=relaxed/simple;
	bh=/XsjW8lBMoj/tku1oZcSrBNVxEo9wawYoVGJufd6en4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IXqWvvKcQt/qZ2ezx5jUAVzOxKB1KubflbJNGU87qXvRryvlWYGE87zUa/DVEtMbXdDZ+c7uXHEmnPKETAsc5rPpbPonFtvlM4+cJPflAzmeVb1AszBPBrN9Ab63HSCsOvzi4coiXpgHTqK787Cf0Hl97ezOJgxCsVvjFpDxafE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=PmEdjRPX; arc=fail smtp.client-ip=52.101.52.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VT3+x2to4OaNdsWUFUqLf24rzeX7pIgmqsKIO0DehPcx8yl1lDTKS23mkMGYk5zHOV8e/sc1awDC8hrDOToIThnvfdQg41FnNK/uJqKEslx/NFijSAKCJGTF4aOAyyUzM0BcMt5VxWBzTmP/Rb9D1orVYux6qkXtfmvfyuUCp23UBkAZv15Rnj9HVoNhKIzCNq4j0YscFqDMf30l/UiO3J7hrosLcaGYIse5kX789Pn3P1irvYV7pvQANxsAcnjyWT/7nOyVS9MwRkoNzROJu4CuVgGD63Yg4jzQi6iFna/yRRVpNUf7yUnBdNFvjT68VTgnAUF+KRHm3D3iKzpzhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KQDrXkI2e0+r4wuQq8dvyM60NEwzOraCDHyVss4+l3Y=;
 b=fEOwEr0o9dSGSxrA0ckXUtZEyJjQnP98ZtOdEC24oiQy0zJrfQ6QO2CccQ2nB+gtVj3XelxdeLIZPgaAJjwBA8L95b/8ifqb4ZHAQi5F1wsC+hDfCUw5rzKRd1G/RprAzMao9Tn+vQitr6ES/FsLZi+LE4ReSCErkx8n0r8+ySxVvMgGnRNb/9avkFQDWeXEBl9j5hEdV3inpDA33WF1UR9YEGolfPEpwBxjkj5vnRH7pOAVlJdnwVeOjcyAWMflW+sv0UMvXAb7n4kUdOp6j8t+hHbZwQ4NWqmlAgEQ5XmR5ob6y7Q+R3GjyTEr90o/pnCT9koUAltYwDx8G7KDSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KQDrXkI2e0+r4wuQq8dvyM60NEwzOraCDHyVss4+l3Y=;
 b=PmEdjRPXhRYtB4mab6rcVVNi0WdBbcMTNNjYBULtsfDQo8v7FTe119/KZ7scVDFOVUFnlp57v5ihQHobp+LVInuyOVxKYzCZwtnPJiBvCPs3mDSt9tI9sTH55amHBXrztDd+N3Jem/JFblN1DtZZ8nnsdXw0INzpeSi4ieI3kNM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
Received: from SA1PR13MB6648.namprd13.prod.outlook.com (2603:10b6:806:3e7::10)
 by SA0PR13MB4061.namprd13.prod.outlook.com (2603:10b6:806:99::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9456.14; Sat, 27 Dec
 2025 17:03:55 +0000
Received: from SA1PR13MB6648.namprd13.prod.outlook.com
 ([fe80::c48a:c42a:aa18:2ef4]) by SA1PR13MB6648.namprd13.prod.outlook.com
 ([fe80::c48a:c42a:aa18:2ef4%3]) with mapi id 15.20.9456.013; Sat, 27 Dec 2025
 17:03:55 +0000
From: Benjamin Coddington <bcodding@hammerspace.com>
To: Steve Dickson <steved@redhat.com>,
	Benjamin Coddington <bcodding@hammerspace.com>
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH v1 0/2] nfs-utils: encrypted filehandle support
Date: Sat, 27 Dec 2025 12:03:50 -0500
Message-ID: <cover.1766853122.git.bcodding@hammerspace.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <510E10A4-11BE-412D-93AF-C4CC969954E7@hammerspace.com>
References: <510E10A4-11BE-412D-93AF-C4CC969954E7@hammerspace.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH8PR02CA0039.namprd02.prod.outlook.com
 (2603:10b6:510:2da::26) To SA1PR13MB6648.namprd13.prod.outlook.com
 (2603:10b6:806:3e7::10)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR13MB6648:EE_|SA0PR13MB4061:EE_
X-MS-Office365-Filtering-Correlation-Id: 06fc4364-12ab-4412-91eb-08de4569eb0d
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zkFoWiuQLtaNzGlivhXxh/KfsPa5zyb3Z8QyHJRo+cVh/5MQshu85b5uJmxr?=
 =?us-ascii?Q?VZ73h2DgCWiB40BS1FFL6QEKYqo+8hlcYrqsOGPUVwpHWUiXPWcQFi4Cm5D3?=
 =?us-ascii?Q?n3mONsHQLN0GPBaGBbMyFebiFr3u+EX4QjkhkRSrRULs9IRlSxG8lySET6CB?=
 =?us-ascii?Q?qyWyA2vOas74iMDEgLbRe9ORnU51PC+cUuAv4L4H+DsfilItrQRkQuR/o2Dv?=
 =?us-ascii?Q?0n128rDqvLxrwfbweZsRCtePnyIdbqmH+WFGB3XXuvx/KJPP7O6q6ihWnq9Y?=
 =?us-ascii?Q?bU3bSqN0033upwBFgmgezpxoyw85ezailJVhXqNa95SiADRuPfpNURxETQMd?=
 =?us-ascii?Q?zNVzFz2ldoUn3QFsRJ0WSIOVp3B58LcRph1mCT4S8MS/fP3RGjN6cobJNaE2?=
 =?us-ascii?Q?SO3LFMyRobT2YWUUCxp0DXcFXxt/hbR0xr9CYIsHZuTd/yJvxbWQO2p8JdTA?=
 =?us-ascii?Q?x+khx9bAe/alPryGXNaAX0oaE/T1+wlWQYvWeVdhXSyMIBEUCVD57ZO3v4St?=
 =?us-ascii?Q?dgb8XI4NMo64KmjCy6RJ9LzVUS4WlIz/Kg39rwBNQhsv0KRXK9XO0AzFPZ7B?=
 =?us-ascii?Q?7a80XynDiQNdhW7fbvI1sutiHlMS/w4JdpZvzoWk+DuYvfl7t65Smv0Odlla?=
 =?us-ascii?Q?bmfISW41+WaeGsZQHj0snc8p9J9uDCTB/0eoka5IDR6rSt5j7kMfk59DjBzO?=
 =?us-ascii?Q?C6iwYoLnd0nKhvzn1Ub5nPVq/HKiZzMMiM+DGZxNg+VmOUqDVEe5+tZIGR3v?=
 =?us-ascii?Q?MMptWhbUiUehboZM03mA0KlXR7aHfp+y3fRrkL2qeih1L9q1XSs2EIbzRyku?=
 =?us-ascii?Q?vICSQ4VRvVMc2fDspD4aWdVCHGplWnpE3fj2+M43llrgH2l2U8lcg4ctPN4N?=
 =?us-ascii?Q?ZB7HqrVWiyvczQisGLeJPxmhHf/N4FDWFh58QUCnxemlN9fWtWszsWvUQJgg?=
 =?us-ascii?Q?zaebVxYmwXbftpMgnA06lHM7V4P8h/BSgwCJowLEPqrcFjCcahT9QfRPx5Io?=
 =?us-ascii?Q?LtU2lFNo5ysdortGW+K2n0EiIjMqZXuxSNITDt/JZm8ZZ+TVwvzIYPN+R0Qo?=
 =?us-ascii?Q?rhpCoyDG482HIvcyIiLJi14CRXnxLY+g77BIxDB+EtFWW286VZJOacUlSCh2?=
 =?us-ascii?Q?eS+GUXR0QKxsv7L+fiE8CWKx7Ra1AZ4WleDB35WFu6Ithdv92VXlnnTt7qmD?=
 =?us-ascii?Q?WuZXtwo2g7X7Hth+UtK4R8xJos8DeT54YmPMPJUuXaztisX7BTK75YD7vSdU?=
 =?us-ascii?Q?IIr4oFQsjeyPM+V0pKuD60a9+8p7xlO1ACx0wMDj9iLiv76Ca2FLnXnEyeCS?=
 =?us-ascii?Q?S3YxQTdjKuMwE3LCRrasz1gILGOtlZRxYwsI54FRGmSdD0KtwurBmiN7om6M?=
 =?us-ascii?Q?JHwB/QQijcdyRbSDEl6U4fmHm3LOXuFsfhbtTR5dzVHNxBeDNoDjYfzpYDCp?=
 =?us-ascii?Q?WNKl4W2sJEDNyzqgj4iuxNuM2qJk6cvL?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR13MB6648.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?y1+B0+JHddfy8ez7+Cms0oQZyb3+3KEmcB8wECVZrt5BZJgE3HdbquLNbjJi?=
 =?us-ascii?Q?eyXp+3Q/2WXJvxithTaEXLOduMB0I1H7Htnk+Dq9raOs9FYbaQmYDvXDb7IG?=
 =?us-ascii?Q?SA9swGfmHedqAKvWIVVoC4eolJidFpB/hcbyuXhCe11FFgZDc0Rj4Ya63zAQ?=
 =?us-ascii?Q?AgzRjPwnYafoJlmWvbcd8/y5+OrBQwZlu/TOH7RHtRbS4p5X5owIVzXjaD8p?=
 =?us-ascii?Q?1NTyI6WFb4B+ayfSDdUd8DTjGVqSSSgs9zAbBusF8l5Z2UjYS0jVmJM66tdP?=
 =?us-ascii?Q?vabMfgbzBwYdnKxoTyG8GJD9jEcD7ZvQL/OQu8bqcZUcBNCVUhkIjwEK2Fnp?=
 =?us-ascii?Q?j7Ygmd3Lz80FTqY3GBkafCF06AFwXnAICkppLxo2qysJqOKqrqlzMFM44RVj?=
 =?us-ascii?Q?Ya+QZioL4AHx/uty9V1RZs2Vo1o7VEqR8lbSzlQNNKpu0MJ4xZildzuVTxF7?=
 =?us-ascii?Q?0D2Qm8DY6YQUFMFKDx5LNd7kXyGclSMPLo8fKCZLQMK+cJyFxLAiprkPZcyP?=
 =?us-ascii?Q?qjQ6WF83kYglfGEvqJOIydFkdThhb6Q5SHlFJAMIQdbzPXj7sfD1PvJebF4O?=
 =?us-ascii?Q?ZRd/Elwa4RvqKZC7gTwOdniUj2rs3JdXZMHXf2rCF3J4dwMVZzAcrB+J97Rg?=
 =?us-ascii?Q?Le7UAQQhm7o6T4Eg7anPQM+yUUi67Bpmav0LIILIxh/P81x9zuqDtTW/Hk77?=
 =?us-ascii?Q?qcDeTeWPZU7bq3hUcwa3EuA1Kq+PRI4WlpHgJ6ULXVKQ99vFqyMg4MhPh3c7?=
 =?us-ascii?Q?FeLpq5Lb2KMexp/QDd4ESw+iXBz8S8cbJHkqUl9yvkFB8s1uaFzGkfGadvWn?=
 =?us-ascii?Q?w9gWluHOrAFu5NydOlqgbZ0zHDSBXiqTo5EEs2G6QE965lCHYd09vAlNaLWh?=
 =?us-ascii?Q?QNpHZhFJEXnvY778JBzZmafvl6gVMC40/VMtgOnjJVHvmxlrk+ZBlm+QAv3v?=
 =?us-ascii?Q?dC+GpbIBy0MInpupU/n5+3GjN6Xw+//3KVap1FmbNWXpsW/7GeE0SoYGvwal?=
 =?us-ascii?Q?FPAkwLtS1llWFtOLAWYxGuMqRhuDlO+mlsy8PvBsdGbppQ49esvJs0S18EIN?=
 =?us-ascii?Q?ETS98rDHDeZkKOAY5CJsLRzchx7TkUWWt5i+znBj4jpDupcvDS55SXOneGV2?=
 =?us-ascii?Q?fD2R1WDBRHCGcxk/qkk6Jrw9cBExTLPYIpJFS7MDrp/qYF/4b6H0jVoMT0/m?=
 =?us-ascii?Q?g4fkHAE0zeGN6IK3cWltgbXJ3jOg77CtcKCAnl7TFvwVoTqoU7ktpKIUX3Uq?=
 =?us-ascii?Q?gM0dOiTlrhWWUaoU7SAomqpp+hbRfwbzC2OF3VeUJreNPWVJMIAkxvbVVFNC?=
 =?us-ascii?Q?sq9K6fUg5sd80hFIAGJ2vUXnlUgsqtyJdoTaitEKXK/NU9tFDIzgcee0u80Y?=
 =?us-ascii?Q?5JwBk96AD3OBkaeCGWeXvg58HA7o9sQuSEs/buRK4M2LbOHYBddU7rb+S0hv?=
 =?us-ascii?Q?vfluprMIR8isOA6c7xtIhOLbOovr7+61YsgTylDm5BIHGKdR/97/+/uKuwIt?=
 =?us-ascii?Q?8aqE6Z/rmcdsRmRR73ZnO0GlNdvWppPc1hroXOEWvLoXT5xo4rfx5cd9dzKh?=
 =?us-ascii?Q?QQxtqIRHf5JJCRMGEm0KQYxmgGqfiv6hdFObUxsdQHNcFUpFXsJ1y+lhxr8A?=
 =?us-ascii?Q?f5JEreT37I14tZ/F0oKMnudT7MIXka6KNlgT2/IHCJ1vQPctSWwwQqDfeawX?=
 =?us-ascii?Q?4WxcoLz3RVOSEnEbOLRk+ehrO/r+0p1qC11k0SXMbo6o3WRdulYsisSdLe+L?=
 =?us-ascii?Q?VRIHpBD3QKz/D1fq6xV3enYnq6F4V0E=3D?=
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06fc4364-12ab-4412-91eb-08de4569eb0d
X-MS-Exchange-CrossTenant-AuthSource: SA1PR13MB6648.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Dec 2025 17:03:55.2285
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HdLYV1QdzzLgRpacL/s6fRArhvjgCIEnFntKOfrdIM3+tfxJeqvPvfFVDHzVi40loGf/1Bcgbgxiiy+LikLWSrwAhB95rPEpxxc89ZKXEqk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR13MB4061

Here are two patches allowing userspace to set a secret key for kNFSD to
encrypt filehandles, and also set the option to encrypt filehandles for an
export.

The secret key is only implemented via nfs.conf and "nfsdctl autostart", as
further interfaces to set it into the kernel have not yet been built.  I
expect we may need a way for rpc.nfsd to set the key - but perhaps the
community would like to continue to transition to nfsdctl for future
features.

Comments and critique welcomed.

Benjamin Coddington (2):
  nfsdctl: Add support for passing encrypted filehandle key
  exportfs: Add support for export option encrypt_fh

 configure.ac                 |   4 +-
 nfs.conf                     |   1 +
 support/include/nfs/export.h |   2 +-
 support/nfs/exports.c        |   4 ++
 systemd/nfs.conf.man         |   1 +
 utils/exportfs/exportfs.c    |   2 +
 utils/exportfs/exports.man   |   6 ++
 utils/nfsdctl/Makefile.am    |   2 +-
 utils/nfsdctl/nfsd_netlink.h |   2 +
 utils/nfsdctl/nfsdctl.c      | 132 ++++++++++++++++++++++++++++++++++-
 utils/nfsdctl/nfsdctl.h      |  10 ++-
 11 files changed, 158 insertions(+), 8 deletions(-)

-- 
2.50.1


