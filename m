Return-Path: <linux-nfs+bounces-18891-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kJ3kEPi4jGnlsQAAu9opvQ
	(envelope-from <linux-nfs+bounces-18891-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 11 Feb 2026 18:14:32 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ED06C126825
	for <lists+linux-nfs@lfdr.de>; Wed, 11 Feb 2026 18:14:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 510D43006822
	for <lists+linux-nfs@lfdr.de>; Wed, 11 Feb 2026 17:14:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8158E349B1B;
	Wed, 11 Feb 2026 17:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="RA7T5tDN"
X-Original-To: linux-nfs@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11022129.outbound.protection.outlook.com [52.101.43.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5296C288C2F
	for <linux-nfs@vger.kernel.org>; Wed, 11 Feb 2026 17:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.129
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770830070; cv=fail; b=YopC6QnU4uEzvxOQSVmxAO1oh1KpRybosGybd0Yakh8c+lQ1bCd3WtPrDlM6AJmFMlWVlTFxQKSrgC9epC6tRMXpBQ8io9DzFjpzfiJia0cyoPBZkjzNG8WhB+SGETLaTXHHtmvT0LunUwJgFzbTyh3HY6ZQPPzR/wcjzYW538A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770830070; c=relaxed/simple;
	bh=a4CanQsX3/0SLnfT1lIQ/k1ixezbpRTLrVukv8Kqwbs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bj8bSheq0thPH0hZiu0VVLg9YfZ6UJbpjTRx+cZiP/Gm8as6ZsBdwOChxixX549bmgGPk5/w+I2GeSbMClszw/AzRwoShMG85Z0TusQjilp9miUuEG/doGo7u5iJRg47RpkaHCv4ROBvrV/ge5QRVet2V0mvcLYecyUIJjG0bmU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=RA7T5tDN; arc=fail smtp.client-ip=52.101.43.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YmSb8oYEwyDuVbjB8QNO+Xg4inpeT1c8zqPEAdVzcQvGyOjxz1qu0QkdgWjPQmLpPveWRKdyS4o7ySNYuc4Msx4NckUK7Nr+ErM9OuldGZtxNs161tkZHREeyXUlvkvx5XhtK+danDeqen3sE6Wi0Lg8GG9pxFpqLNf0czsbZF02Lzv9E0l7MOvNuIar32A+/SwTMAWygNl9BEa5RSHANYx52VjTxvOVPgGD+R5FoeOK5Ei7RWe8dEg3o4d2G3tv95y0SznBIl7KgzSajZbz5/B22VHmtfbfU0TnGOOk8H1Fw8YDCvAubIm7P0RqDmyktg/PT3fPpQMfEHhYUEZcCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w2dgSbxMbGvzSjdIyPnvkatJSFu3Q691dmkcoi+cM18=;
 b=WB/4KzVDvRiafVS7QKJg58FGdUpAi+F+jFtqr7o1Ur7AeP4IiEAWx/yuD773tKbd/jxYwyuZtg0dV1ZoPc89lNTlHfrShT9LP3HPNoiNXGOK6ykg0HJuDQOM/yZa3iaJvMe5h1T4VLo9w4EUzJwAc18VybCcxbFT8MnKBCKeVYz3QoO/1Tnd/oTS8s2p0treXC16V+1yam4GdqiaSGRaJOMxrWURkTWqOcgXpX0qaf5akG8cmUr2RG2kHpjAjojwRICFh+YCIMARWFAbvsZDikE/mw+vQVwxTGKzpwMxh+mNvCS1XFPXV7LMMJy0o7Zv5BM95EsqwOPGXfDmZIRMjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w2dgSbxMbGvzSjdIyPnvkatJSFu3Q691dmkcoi+cM18=;
 b=RA7T5tDNoAzjtW0oo0gT2oq3moeKm0m+XutsRqXSkwMU17PwCmnQ+SEJBQt6CoKKSYIdXqQ9RQoeq0iLwruI0Cz1og4MHcCdzYtVomiEppTu1nujMc+99Ol9qg3CTfwiVzRD1/nW65x/mgRj1ONppcuXd09UQHKrmsNjCmlYeM0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
Received: from DM8PR13MB5239.namprd13.prod.outlook.com (2603:10b6:5:314::5) by
 SJ0PR13MB5941.namprd13.prod.outlook.com (2603:10b6:a03:430::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.18; Wed, 11 Feb
 2026 17:14:24 +0000
Received: from DM8PR13MB5239.namprd13.prod.outlook.com
 ([fe80::fa6e:7b5:d1ec:92f3]) by DM8PR13MB5239.namprd13.prod.outlook.com
 ([fe80::fa6e:7b5:d1ec:92f3%4]) with mapi id 15.20.9611.008; Wed, 11 Feb 2026
 17:14:24 +0000
From: Benjamin Coddington <bcodding@hammerspace.com>
To: Steve Dickson <steved@redhat.com>,
	Benjamin Coddington <bcodding@hammerspace.com>
Cc: linux-nfs@vger.kernel.org,
	Chuck Lever <chuck.lever@oracle.com>,
	NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>
Subject: [PATCH v6 1/2] exportfs: Add support for export option sign_fh
Date: Wed, 11 Feb 2026 12:14:16 -0500
Message-ID: <69c1c5e20afa59d236982982f651833f5e2ad061.1770829825.git.bcodding@hammerspace.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1770829825.git.bcodding@hammerspace.com>
References: <cover.1770829825.git.bcodding@hammerspace.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR13CA0018.namprd13.prod.outlook.com
 (2603:10b6:a03:180::31) To DM8PR13MB5239.namprd13.prod.outlook.com
 (2603:10b6:5:314::5)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR13MB5239:EE_|SJ0PR13MB5941:EE_
X-MS-Office365-Filtering-Correlation-Id: e8afe5f4-032d-4b9a-bea9-08de6990ffa2
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7142099003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?R0T/Y5szhHmnvacbbmPz9UksR8QoD2mSMHSbFtr62+Dy8liO7+Kxo3SO0OtD?=
 =?us-ascii?Q?MsfbP+WplX8dd/sYM58GnUXoFLSBMiv0CQkXJWzKzBQyrNdXPN43JjGVc0z7?=
 =?us-ascii?Q?bNcOfdI8zqgi0Do25UbKAw1jBQKalvWIuQACjezX8fSJoQvtmVX7AIFBVuxL?=
 =?us-ascii?Q?ONbOuSzVA0fdLyBVt8WJtOx5uXWNPzE1gH+9r1QlVVAjSrcq+snxTdL8N2KU?=
 =?us-ascii?Q?DK6vJa97INe5E+is4AQfjBIfp0mS/p0tScByGFBjvnnOLEuUK2dVsQvf3Z92?=
 =?us-ascii?Q?su6Ls1+VY/NtbN7fzogbKU/I46SpQuJPilZIUHMo/8rcpMFsRWB5M5Zc7l04?=
 =?us-ascii?Q?Fw44/CPPyL6QtI1Z0eY065+tJwYMXzMDCX8XL+6RaiAb94nUA2MJlMW+c/b8?=
 =?us-ascii?Q?hPM62VOKvy0kwttB4ZQQZbmu3ZWBy76le+cnaPjRp2qdRauHCpitvfSZ55Og?=
 =?us-ascii?Q?zWpV/hPMt2VhVhm3IJlrVjLMT/gBh9ofrKYoHoZ0Zm0ZYNB3YzI4989TI2Eo?=
 =?us-ascii?Q?y0EqH/K7M69GaJHrk4z2381jtMhYNip+VRqK84j+K3jBVLWKxHhzsCC0XUGF?=
 =?us-ascii?Q?WPlFeCniKiu5x/soaC6DuVWesvxsrQ3tOCrR46cDsoKJhD96g6HFufMAhWfj?=
 =?us-ascii?Q?c9cPIvD/JLBTi1qyPvkFLQtYe9X1UfufZkdi/Rbb9uqhgsHjzVf2srxIbfMt?=
 =?us-ascii?Q?KPA0WivbjxQ0/7rrEJ36D9yeOpCRkebJAaFcWL/jKUfEogfHjXZPiaLMmiXU?=
 =?us-ascii?Q?7nZ/Rp067xXutOQcBQIUzMeX4oyKCxHbTE1E4Q038FrToi3rzM/iRjSOiYrk?=
 =?us-ascii?Q?0Bh2kywVZL3zyUnJ5HxIHCcjluGMxoudCYt6q4zjO5h9/eXqg0b+t+tsoMze?=
 =?us-ascii?Q?AL01imC/MRGIcztC8872eMxfY5c9/yLRBr9hDnlu8NYMkft6v+cGBzv//3t8?=
 =?us-ascii?Q?+hs3hCloQrqnBLkpkKiTyDyvXPONE2G7yeHW7Z9FHRXgWXgyyCZL4T0NcGSN?=
 =?us-ascii?Q?MOuJ+AtPcxhtGF4QXC/Taru/XMFRz/UQhQ3EN6e1usFC2qL//kqGHJDM5OKW?=
 =?us-ascii?Q?LhkUGhwxLfHuTEkkj0TtnmIybME52rQsjvLihMXIwNRzNo8qYJ8iS0lLMBDF?=
 =?us-ascii?Q?Ay1366IU1Fzu7cPnuYdBzAxq+DAv30npTlq52JWCwdljVo4UitU7BExmWwsk?=
 =?us-ascii?Q?5kO99FDaat7mwVYjxxMGU0UjQ0i6R2QiDyzS/jkt+S1zeThG+ysemK8vo+bQ?=
 =?us-ascii?Q?Xz/nC25ZKOgZqGAB+rizKRqskOpUZN08ArdvYlSxm2p3OJE8pdtKwOgHc6u3?=
 =?us-ascii?Q?p73+HXurtE3XBFQMrH0ffBWHruxElzHjWqeWOempkY0EgJmMN5gfRFFKF/IO?=
 =?us-ascii?Q?FWPmAHQrWnDoo9SbVODBrmtVg0OvoLNhewYm/xWTaJvcpegljCSJjx0tpEJn?=
 =?us-ascii?Q?ww4p5I5xNf7IZB8CZAJW74zv66ec43bbOAJPbrgq0wVdyNwQfk81dGCYrh2Q?=
 =?us-ascii?Q?ddGNlvmpyBuVHT3D0e9/1KDiK38Qh/rXP2iX81BTkYrlAZhKrYwoHY9J/IhY?=
 =?us-ascii?Q?0VZVm8iVhhhKC9riMNA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR13MB5239.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7142099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JhNuW3ogPHY6Ferx3bD3RfjKQTgOwVT1O0lbc94MDGdyCj9p64k51Cdw5En6?=
 =?us-ascii?Q?IMRSHTSifKiS9u7lFij/eqi2Lw0CnnJZ2kKTnXLN9jkAswU6Nx4iJ8rN4oBF?=
 =?us-ascii?Q?q2bmOGhqsS8Hp61RlE/a1PRwE+FGD/TPt0N7PNF/JrzSJqVFa7off4k3cKfo?=
 =?us-ascii?Q?uA55wynFthwOKYrMyN8ekZWAk9Cdu14lhql+G9OIHYo7tc0ZobTtNYWawRZu?=
 =?us-ascii?Q?SDQGcHrg6J4+0rBvGWsOUAf2ihhhE77jYMmWTkr9cDtysqbFcwNWSeJV0Ux5?=
 =?us-ascii?Q?8cDmF1y5tw0JvKUwvMrpOR2RVHnp/fHsLepNSELDSjnqqqT8lJaFEadEPq92?=
 =?us-ascii?Q?lFooSg95JX7R5UTmWGqgOBHL/9NHbMgdXHkRiGkaOScifuL8v3m/hK6ZAri9?=
 =?us-ascii?Q?6IQ/pWXhhWstDbEVlarWT4uCuIHGsEgLuh8DP4mLYpVccoeRlkMsJTuWIx5R?=
 =?us-ascii?Q?MFNXco2kPm2e7EgoN3egfSecFHLSfAwXulGYvLu0MZatJMbCl2exwFf9x1vo?=
 =?us-ascii?Q?qll33HghIKTrLP1qhYU7U7yxBOaw5aMiz3pwxHIwyl/wCB5qtXrFz4jSQo+l?=
 =?us-ascii?Q?nSFZBCRwy+ImiSsG8K5AceYRaRtTsd9y3JImdRifqoJxxGQsyEBPDi4vjot1?=
 =?us-ascii?Q?J1Ab3N7GiGhlVeMf5OCV3DaEgBbUxaZbDglSQcdyHviJKle5txB1kMt55pzN?=
 =?us-ascii?Q?GqJlfzJeiWxXVvUyGN+2pRSOMRyYn5F3stimsdCztFdHgESMHr0iqRk/71ik?=
 =?us-ascii?Q?5GpHGudx03Ynuevbqh6/lLvPREyPCaFM7Z/+9/zQo3cl7PHYOhkGhzLjofo1?=
 =?us-ascii?Q?aJV33Y1F4dFjlWTq9GxFULDbaWgRO7ghlhEJi7sqoTbutyBj4fIe25uy4oMk?=
 =?us-ascii?Q?tvvVEsQty6JNE8hnsDLYFE2DewEaCYIiW7ffk6DcZr/tM54ASQ9P5ZrUXxct?=
 =?us-ascii?Q?5hyjm7yH1wO6dzEJyY/6MsOH/BLGKTmiYE9dPFCTi4eC2dpW9q+9zhJ+27Qq?=
 =?us-ascii?Q?88JxV3rfhYWiVDz5aANrHGftSfF7J0kfVwaaHAwswXjBHyiOzDnhns59VY1m?=
 =?us-ascii?Q?Ms2PVOnl1P5rlPCfuCrFfHm4rP+qbDwt8P8ewBc8T5UOki1k346eX2abYTIM?=
 =?us-ascii?Q?3N1jIjm14ATkonBaa3/IO3oeppf0QXl7+rc1+4INq7rG8ZYot1o+3ZJFxyxB?=
 =?us-ascii?Q?tjsIrkcaTT0xBdwsVFMbZtRw7iLMfJA/zi5JRXE1Fi+K32F6erUCzMLQAVVy?=
 =?us-ascii?Q?vkDkK//e1viZkJDhg6ZaMqZ3dBfILJ4eP4/HU5CBkGJGViuXvLYVM7/PLShV?=
 =?us-ascii?Q?2q29HqAzgPtRgoP32gj4fpR5cgQgQ3PJakwIhUL3mfoFIQmc2sSQ2ztyItjg?=
 =?us-ascii?Q?9zpgfQieTmLLasPG2/jK3zeQm8pSBtmXi58UgqDs+1hqCWfwka3cYbiWhGNc?=
 =?us-ascii?Q?uzpWcls36bMpsOjOOGyZWb2kj6BjKXgeVZVPkAc4bbeOQGeHRkAnW8gOlGbM?=
 =?us-ascii?Q?q4lQqBQWUD3NXSf5iOdqcuzHnYrBGtq1l/MjMk8PQFmn/GGbwufJM3wyi0Sr?=
 =?us-ascii?Q?9NHyfYf7ZDFZOpGyW8ZqOv7ckbmfLuNHQ8XBiKwy3uLhjjeaBEbcN8Ezgdif?=
 =?us-ascii?Q?xHXpbV95buZIEdXI3LvCQ1bI0z7/738olY2w2bmzc/1PZnRLF9gofHs5gG5Y?=
 =?us-ascii?Q?2gP0vnIfOL+XwBnqapty7m/cOdusiGPrb+5bo7rDv15Cjl9KWsCFVW1zHPyq?=
 =?us-ascii?Q?eMz/bict+7Iblq9MAnI59Zwtmajmklo=3D?=
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8afe5f4-032d-4b9a-bea9-08de6990ffa2
X-MS-Exchange-CrossTenant-AuthSource: DM8PR13MB5239.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2026 17:14:22.0075
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gk48O4v22vSzEwow7QfSWWO1v18l2EtS2MMX5n3Ub52jDN3grCosjVKkOT/T8pL79Q6BZ7b0MQMiKQ7xJdQjjjOMYoq8YBQVBr19wPoqqyQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR13MB5941
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[hammerspace.com,none];
	R_DKIM_ALLOW(-0.20)[hammerspace.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-18891-lists,linux-nfs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[bcodding@hammerspace.com,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[hammerspace.com:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCVD_COUNT_FIVE(0.00)[5];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[hammerspace.com:mid,hammerspace.com:dkim,hammerspace.com:email]
X-Rspamd-Queue-Id: ED06C126825
X-Rspamd-Action: no action

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
index efbc6ef65c5f..7f0278fb8d33 100644
--- a/utils/exportfs/exports.man
+++ b/utils/exportfs/exports.man
@@ -351,6 +351,15 @@ file.  If you put neither option,
 .B exportfs
 will warn you that the change has occurred.
 
+.TP
+.IR sign_fh
+This option enforces signing filehandles on the export.  If the server has
+been configured with a secret key for such purpose, filehandles will include
+a hash to verify the filehandle was created by the server in order to guard
+against filehandle guessing attacks which can bypass path-name based access
+restrictions.  Note that for NFSv3 some exported filesystems may exceed the
+maximum filehandle size when the signing hash is added.
+
 .TP
 .IR insecure_locks
 .TP
-- 
2.50.1


