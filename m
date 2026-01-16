Return-Path: <linux-nfs+bounces-18034-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AD3D3D3841F
	for <lists+linux-nfs@lfdr.de>; Fri, 16 Jan 2026 19:18:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D6A0C30213E5
	for <lists+linux-nfs@lfdr.de>; Fri, 16 Jan 2026 18:18:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 304CC344055;
	Fri, 16 Jan 2026 18:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="O/W/xDMu"
X-Original-To: linux-nfs@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11020136.outbound.protection.outlook.com [52.101.193.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F1F7338906
	for <linux-nfs@vger.kernel.org>; Fri, 16 Jan 2026 18:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.136
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768587491; cv=fail; b=uDOSfV7ISCiDKx6xRUw9CyAKko68sxCU04vTUjllht4ueQTtU5GahKhNXyjv6apfZO2ixtOpofzXai2MgPzqZS8/SgzPmSHQxSmFwZOotQvKsinOcadZZGal2H8wkF7WIf2M4fWPkeCleMh55CNgukuOCkjXnwCCdhZjTdcKXVY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768587491; c=relaxed/simple;
	bh=ujZpE3ZzHMXu70ZK9VMTVOeMY3eQYzN+vnszCmFZnZI=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=FJA9tUH6wXFexSnqNNhUZCdnlbmNrdQE7ir7WucE8fZ4wjfRppw/nwxicRlWaMqj5MM/3jpyvKpafuUzk9JTmyP48ZmPax86nOg9X9AOgh55X3FdpcZW8KVgKWX/vbh1N0mPBa5Ill+qzxnvMIwxtZ3pLpNcruCHktuGM/hi4R4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=O/W/xDMu; arc=fail smtp.client-ip=52.101.193.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CXOQTWWUZrDg3iXQtYBr1RhL0vYiYHCuAPMjrYO74DWTfAeP1e7jn5ecnGePma7X9GlZu5IJvSC8Zq7/Mu5MOJo0bugCJKtAr2lk9HewNXvALmdq0yIbQVRX9pswRxqI5s+CgCtIZvEiiwrqU7Nc7h5pD0ku8Zg9e1UY15FwL4gGejIFn9di17H3JUrYPor/HClIaGTnRFU6pyL6qE12gQ4JGpwgdo+vekvIPhdMZzShG+jYn0bOexN+vG8zLgy6TgYF55+ijw3FZhVuEiI+sXDfyal2Fu2IYVln7DjVjoKQuynvOR39Oczb5aUBrAaeKKqday0kfybV4gTjUnq7nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tRZwHR1cTB0OVOYS6BwEn3+2+mM/quQep/9Be+u3oSo=;
 b=aPwWo0xi3mfhVsurWM8CEmmBDdSfwEkLo5FXSHOnE6MA9kDZG+y4QjUHgIqlgyUcqVXcZjQOKLI53KUeP2QazQsL1MWVUQ67I/FLEeG+PxyuEwOevuvCgEMeVnxCBWAWj/+KhrNN44agKme/GJviS1d9i852FWnbyopvyBk1kLCPfSCiqeUMUJk93ILKMXiC6zpONN3oh9aZZfpISnvwPERrh9mUqTTjWdNQXWMVrU+4UbDMv+UQOUIZGzbjju4vm27qjgb0aO7wGcD+caU9kfjBH8l6yjKxt9sNcoOqVfm67VYJaoZGIWfCwVWhbTnEl17JjNog0n77d1S/X4yfKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tRZwHR1cTB0OVOYS6BwEn3+2+mM/quQep/9Be+u3oSo=;
 b=O/W/xDMu6kIcWibTZB3Pwm0kneKn7EN9UZl2nJHcSoWsP2RFiz4k6d3i80hcYt6qDvCfxWELU+KYbvNgj5DZs1MpNNePZX3qmOlUIPpvIdwA69+Hd0+eTVW+hmGgbPKGe/vyGDuJGKJ2AYd1RSY6mMmdd7VpkfkxmCbMNVB/61o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
Received: from DM8PR13MB5239.namprd13.prod.outlook.com (2603:10b6:5:314::5) by
 IA3PR13MB6935.namprd13.prod.outlook.com (2603:10b6:208:521::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Fri, 16 Jan
 2026 18:18:06 +0000
Received: from DM8PR13MB5239.namprd13.prod.outlook.com
 ([fe80::fa6e:7b5:d1ec:92f3]) by DM8PR13MB5239.namprd13.prod.outlook.com
 ([fe80::fa6e:7b5:d1ec:92f3%4]) with mapi id 15.20.9520.005; Fri, 16 Jan 2026
 18:18:05 +0000
From: Benjamin Coddington <bcodding@hammerspace.com>
To: Steve Dickson <steved@redhat.com>,
	Benjamin Coddington <bcodding@hammerspace.com>
Cc: linux-nfs@vger.kernel.org,
	Chuck Lever <chuck.lever@oracle.com>,
	NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>
Subject: [PATCH v1 0/2] nfs-utils: signed filehandle support
Date: Fri, 16 Jan 2026 13:18:01 -0500
Message-ID: <cover.1768586942.git.bcodding@hammerspace.com>
X-Mailer: git-send-email 2.50.1
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
X-MS-Office365-Filtering-Correlation-Id: 8b9e94c0-a4ef-4dfe-1cc3-08de552b9788
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7142099003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fNoYh1iqKVADbyZTTtpfgatoSPuXzXkO71YYQIRWSDmzYjXTV6VZ7PYWqNtn?=
 =?us-ascii?Q?8Junnmr6YahunyVucLA0D0kEQ1gLem86JC+xCvd3CbPbgrx7hewPWp+letw/?=
 =?us-ascii?Q?kJ96mwNhPnvI2+kXQlb3TMpunCCo/60c4qpZjSCarUw3J1zrIgqVPPckGiTI?=
 =?us-ascii?Q?wj2yDCacOXk5vTVVBDXuuY/FJFimGDY3N3npsySgreltRk9a77WJ4u4KxH2A?=
 =?us-ascii?Q?zBpAlcDR+S8VGDyrJGIS+JZpnSagGfIPDtIjGgD70RcoGRbJAO1vvln6mn06?=
 =?us-ascii?Q?ajF98Sc0Gc2iSVrk/gS0MfWXWbJofGGesKQnhmDYQVYHKPgY8YKTw82A5UsN?=
 =?us-ascii?Q?UNxBGXtt430N2LbEUIen5W77V4coICCXEhgBo3w+kYFjYJCTgL3ZbfvpRUiZ?=
 =?us-ascii?Q?+VOuKdztyMUxUlme7RSmMKm35gX29NuQ35f3pvtMVwxYSBvypMi6S/3dw9cd?=
 =?us-ascii?Q?hlVm+H4MiTiY7VdAqZwK3JHFCU6pgiifQJXpmP1Re7SmjIpAKSQiS2ZCx1TG?=
 =?us-ascii?Q?6COG7DnUO09GeB7QDlrrm2zsWNbXBT+0ENhrxpnDbD8RHx+H3giE89nOAj6S?=
 =?us-ascii?Q?PR1Wd9LVs4ilKSeeCEFUlec8izglTAZ+eEBHL38ufuY5HCTLCPtCwOnWEkx4?=
 =?us-ascii?Q?E9oLl152nO4epTDuIjt7+/cPjkHAp905K1kErkH9HB+9vPkevrECLPcucH28?=
 =?us-ascii?Q?IoXpfMXSz3VV2c6zhAYYnrdrLwsb6zSnx4PqUt/WT8jrCS5IYfqTXgk0h1uZ?=
 =?us-ascii?Q?RKjpxSpF411eoDDZAb6iGjEvLbYwRC3brMMuDjt6/5k7Y+tJLpjQwvpIzxkw?=
 =?us-ascii?Q?ikuycpKvPi9Z3W0+ye84gSurv0xMIM1ysc12b9hzYFX4z4eqMpp8wReuVxvc?=
 =?us-ascii?Q?cwe3p4SXVy91LobCW99DNpVCp7SDQ3CmpnT8abkjY0LLybHh8sX6JlNskYxC?=
 =?us-ascii?Q?BiTYSwi9FxalffNQCl+VYAu1HXgZq0tiEAyFen3tQTAOwSaLIO16gByKl+F2?=
 =?us-ascii?Q?WOxoyZDdLMPwZ9EHpdaY3/YYeCeD1YlIKQVlfAm5PrDlQDozZP3ePeD9LmNZ?=
 =?us-ascii?Q?ErH5vE+dI/7DU0fVpSCuGDTTJOlZ5baUew8rnmHbgVj8VAwc8EUafkEzV+EY?=
 =?us-ascii?Q?/qxjv5PBApU6sZinpZxQ5VrwPlL6vKAxEWZ7jq9Tw3dJtc28uYkIFlbTPU01?=
 =?us-ascii?Q?XwPNY0uCtkbKo8mxRRVhApGYZbtzb3bNrAGFSis8IXdcvHNplWVwop20/NCa?=
 =?us-ascii?Q?VGHJ8Sopqp1QSuQBhj2600QYx5P+0npC1SmYH1h/x5TKuVRpRdh0YzaQaee3?=
 =?us-ascii?Q?1RY71MRyNBs8ZPXV9m0vJYJ9oOO/vNomq/0+yD9NEfGQarqNv9+RWrSluCbk?=
 =?us-ascii?Q?mHJi5o6U5Y5T05Z00cpDm1aomPlCbFOxNwJl9EfX+MdRadmXHHvbGTWRPrsI?=
 =?us-ascii?Q?ujPb6uZOGQ8qCBQ6Em2jp7fqnMTaTdCkL6mFsxwsZt7MiAOcHQ7f1M9SYCcM?=
 =?us-ascii?Q?0nUbmMUzfd8+pYrZGF7CQUhzVy/8cKyCMvLC?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR13MB5239.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7142099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EYFzTLpC1NDeDAyntox4gOUQCxlL2/S6PpvMNGnilRfc8lj8oWCv9KCVeEvK?=
 =?us-ascii?Q?P1OztO58qznS4zRPYMsobXqHCFKBBHHITwhFVBIkgECPc0rY3CBgOf/vK48D?=
 =?us-ascii?Q?SsYQuX6r1SMXAp0NypAvs9JmzXcC6PBj4KipoFvahJkGHyBlDwvlgCtERz1Y?=
 =?us-ascii?Q?V/9vaXqow1U+uRRsKiKu9bMzxUv6Uivk+5WynLvEWnRGxBfbhdwbYUmO4fWb?=
 =?us-ascii?Q?Wpsy4z85ovuq5LQNaQit2XudQCuhyNr/dLcdIn/9MAyq96/+lMvaOoQykRdd?=
 =?us-ascii?Q?k/Io7tUCDk1XVJSZza9W/AyLgWJvXKm50sFAu7O9dsYpJAITZ34rEqFqLrZb?=
 =?us-ascii?Q?GPpLmFv9nBk2238cFSP0q+irHKZNsbdb0DPeaMfLKX5g2JIRmDaxiPinp5Ss?=
 =?us-ascii?Q?Ru/FWSr+lZXl6laEZ/ImvttgVgqlM9Y65r4udVVIvSiObh+SgGRLNoZMBr7b?=
 =?us-ascii?Q?BldZpos6yq5AjnPlonyam6kh72ZOBk/X6zRcia4R44n5Oid1fqqRU+Qkt/xZ?=
 =?us-ascii?Q?79F53ePsdBO+5RLyhrBw8j9ajgrqYe9jO9kxExi4Jzx438iXFaodWh2MvTQD?=
 =?us-ascii?Q?MOmRCk74UCH4Ylv7+YeH6UdcQ2YFKTCLK5Y0xnVUcANnt3YiQOaW6fIp54rn?=
 =?us-ascii?Q?nHI6da0HU2Z3nFA9AK5b7FUCWtG2iq6ihedUpekFmtKQ1sduokXskMNprPOY?=
 =?us-ascii?Q?fQAOzd7uWiPEaQoG8mT3PK4Mk8UTXbXcODeyu1mhGlgdG/5UOUBqvMpyueiE?=
 =?us-ascii?Q?PCcHck9n6IP1ZGVg9Y/w6/S2zvkbXkGH/O+DrajJ1qUXIA8oYzZZ7tAMyWSO?=
 =?us-ascii?Q?vSB80MCsx3ppROq5RNmGC+pUOFoofEQBkAe/uM4xpp4NoDMAGRjBQbBpydC9?=
 =?us-ascii?Q?kxokmSFKneI/+JtwjFxM2k7JcoJGXCocsYbHjm9Qh/c7aomg9g4+XZj9RIXy?=
 =?us-ascii?Q?+IeD7rS7bZLsu2p67FS739xm94HbSbs+4ndQcieM52ReitzzBTrDD60HoCLY?=
 =?us-ascii?Q?kQl+Iwd9/xNAQedEhr4r4JUqOifoK4JfPbwg7/B9PYa1QO1U+XQfA53z0CGa?=
 =?us-ascii?Q?Bu/6d80Lo1EqpALqSoq61b+IXk1nWz29FIEB9YHpzbS4zd5mcu4c3ITlTWFY?=
 =?us-ascii?Q?X9Qag+lwTDLZ6qtvfNUOnGMHI71mnqY7vamysDqaWub3fRDxoxMeNVE08Z0U?=
 =?us-ascii?Q?tAybcCytX1sF2XD0MCSu4Tl+VpN5gexmZqy1ic4+tH9Kct1Wr7stlhHOJrAP?=
 =?us-ascii?Q?Re4LhVa7QxsfexK3qjftdjzn/Z90yZXvp/D1/OGRmN+2kZHTwCUT1I5VBVTy?=
 =?us-ascii?Q?1Nv+x9jy56oaOgBCoiz013qYWafAvn6uYZLI/o3SWAHXti9RbmvWXAqeFnMO?=
 =?us-ascii?Q?7WrRH1P9oluNDZYV9x8LODqw74zZmhtmfkqMA7ZloOr5fgZnjcKEvu6GhYXy?=
 =?us-ascii?Q?wXjLpHfXDbq9byazYuW/Xl9iqvHwmmkpv/b2md8tPJyfp7+TbMJV53dDegnf?=
 =?us-ascii?Q?0RaO4e/UfME8edz0IMdkLWl6mEUjiqlq6QlyAjWa1JFZjtMhuJEMhcmkTbS8?=
 =?us-ascii?Q?Q9EMHFrlz4Ol0q2Aq/cmuRH7rCvWDApHvfK4/NPWta8bAOHqtfZulUrs9qQ/?=
 =?us-ascii?Q?oSj81SMX13Qk74UXJPGdZ92T9lf5W75sRHnXZ0qODSLBN28rUaoKU1AT68t9?=
 =?us-ascii?Q?JHUv0oLZI+xPG/dbwvGJbI0hctfV9XxTg13Egul7lKKqu1DdbqffSAfIRZO9?=
 =?us-ascii?Q?TsfiABE/AV5jxfadq3CuJWwxJnIp0/c=3D?=
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b9e94c0-a4ef-4dfe-1cc3-08de552b9788
X-MS-Exchange-CrossTenant-AuthSource: DM8PR13MB5239.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2026 18:18:04.8638
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G/BQ988LWIAwfwurv67m4i7mrDoGc1BWWDNxMOYCC8+Fsm/rN6jXwpuQ27mz7GzBaBmFXZ2UtX/uysdL5E9lmczzScQnkiDKAvOtgJe7/oA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR13MB6935

Here are two patches allowing userspace to set a secret key for kNFSD to
sign filehandles, and also set the option to sign filehandles for an
export.

The secret key passed to the server is the first 128 bits of a sha1 hash of
the contents of a file configured via the nfs.conf server section
"fh_key_file".  Exports that have the option "sign_fh" set will cause the
server to use this key to append an 8-byte siphash of the filehandle onto
each filehandle.

This version of the userspace patches correspond with the v1 of the kernel
changes which have been posted here:
https://lore.kernel.org/linux-nfs/C69B1F13-7248-4CAF-977C-5F0236B0923A@hammerspace.com/T/#t

This work is based on a branch that includes Jeff Layton's patch for
min-threads:
https://lore.kernel.org/linux-nfs/20260112-minthreads-v1-1-30c5f4113720@kernel.org/

Comments and critique welcomed.

Benjamin Coddington (2):
  nfsdctl/rpc.nfsd: Add support for passing encrypted filehandle key
  exportfs: Add support for export option sign_fh

 configure.ac                 |  4 +-
 nfs.conf                     |  1 +
 support/include/nfs/export.h |  2 +-
 support/include/nfslib.h     |  2 +
 support/nfs/Makefile.am      |  4 +-
 support/nfs/exports.c        |  4 ++
 systemd/nfs.conf.man         |  1 +
 utils/exportfs/exportfs.c    |  2 +
 utils/exportfs/exports.man   |  9 ++++
 utils/nfsd/nfsd.c            | 16 ++++++-
 utils/nfsd/nfssvc.c          | 26 +++++++++++
 utils/nfsd/nfssvc.h          |  1 +
 utils/nfsdctl/nfsd_netlink.h |  2 +
 utils/nfsdctl/nfsdctl.c      | 86 +++++++++++++++++++++++++++++++++++-
 14 files changed, 153 insertions(+), 7 deletions(-)


base-commit: 612e407c46b848932c32be00b835a7b5317e3d08
prerequisite-patch-id: cc4d768b1f6935b3c94ae87bd0389270717bc5b0
prerequisite-patch-id: c1ef8324c84a18d3ba29a971cb43b16798d71166
-- 
2.50.1


