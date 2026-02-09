Return-Path: <linux-nfs+bounces-18820-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KP4MLOIsimkjIAAAu9opvQ
	(envelope-from <linux-nfs+bounces-18820-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 09 Feb 2026 19:52:18 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 54D0A113DA3
	for <lists+linux-nfs@lfdr.de>; Mon, 09 Feb 2026 19:52:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4689F300612A
	for <lists+linux-nfs@lfdr.de>; Mon,  9 Feb 2026 18:52:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5F4D3A1D05;
	Mon,  9 Feb 2026 18:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="PEBsDzw1"
X-Original-To: linux-nfs@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11020111.outbound.protection.outlook.com [52.101.46.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE119168BD
	for <linux-nfs@vger.kernel.org>; Mon,  9 Feb 2026 18:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.111
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770663136; cv=fail; b=WJVlDYvK00CawMKaztnsh4uuyVcEeVMYYakUhr7wCd8pkaGKwJ78NwMbzUulPnyj425lP/H8Bri9RDObref+GMj8rJIJ+oADRMzBiyPmDNC/pF0ey9EkzF5dc+c+byCRT+eXUyETQNTdM22AIjJSzgzfEMzJOVuMoooneU2+Wdk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770663136; c=relaxed/simple;
	bh=+cvuIjzcG5uS2vLLbeiesXsj3wtCVwZaB/NiBMIPwjM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=umVIovqBgzuoUBNfaPc79T3D6TUxBh3pv+bZFdtJPCRznSzZ2+DD3HY2Tn+pYRznUXu2eFA1MlUR4otE4BmsA/sFu1FL8sG5ItRe/gAZx6JNRGIZNsNpbBTB5pJ+nAyMW93VTnbFDTQjNWhUHSFu+C1ld9cnVrXQToE1wmhncHg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=PEBsDzw1; arc=fail smtp.client-ip=52.101.46.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xd2Dt2KjXY3QSEDDUXsRHQ3b7WhdFeAXe8tOFCL5Upf/xuJsDCVqQ+XPiM29bKVtF8erYwQCMbmwmMjFpQ4+sBc+YL6f7BTaGStd8yKlBTn2ft4ZzZiAKvSSqzkFO24ADjIX9FlWj8zwjU4coDvSvLihi6mdU/Dji9Sc1fJrlJ2wEg8GEodyk+D/biyJf39uLs6wd3zquOeUmhP1sXDz+W8jNJGypIbYpY5t3gvnBF0E2FuKlU/oJ6cnXlq5tmCaYW5gQB36/VF3NzEcvJbp8Yn36+e6IgIu1hacE95JVSYepoF46NHtWvaexnfgz5lmlkMwAj2N74cZYZykFeB29A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=24pI3qKbV3WL88dRWhSdy41SbmsFXOhDcGo3Sr5YOxg=;
 b=WVVVmpi2Lc2/UXwKZPTqwo2AgHBd0qOpOjoZg5+oNnif/1M+HJEtBNtuyWlSy8NaW99YS9sYxDXg5wvZml5/nxEDHf/XaRE3mjYamfBL2KU6VGWbA0qhr08kkYXyo1XrTs+kzeT/ODmC2ul0fisAAqIna6k9bWyGuCQ7eaiu9W/IWa4c9FzC0ScIqt0pikWOBYedZ6z0wxbxPt+qXFV7ITifcE/L07AzwKCckjI5e2B8DKaVj2ulZy6IsA8ffD7lWKyhl8tPkGVBuxL/LuTE73XUUGZDhHFlg+93xFt7iuO3KMX+62JprzoimcvJ03+tdWcEvIMVSWqUHHEoMkW9Rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=24pI3qKbV3WL88dRWhSdy41SbmsFXOhDcGo3Sr5YOxg=;
 b=PEBsDzw1vmvccv1wwfQL3fWv04ZXq1NAcOZuBxj6psaf3SBNqX0M2FF5a097U5+6rIX8grZg15vdulU3FR+tlQCR7LA4+0eyuvyagnOEgRBkRg7KhrgS/z8MKKkm+zQg0mGEO+I9o79El9aIsVZHkL9FT5ciU0qP2lC70pEPvus=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
Received: from DM8PR13MB5239.namprd13.prod.outlook.com (2603:10b6:5:314::5) by
 DM6PR13MB3740.namprd13.prod.outlook.com (2603:10b6:5:24a::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.18; Mon, 9 Feb 2026 18:52:12 +0000
Received: from DM8PR13MB5239.namprd13.prod.outlook.com
 ([fe80::fa6e:7b5:d1ec:92f3]) by DM8PR13MB5239.namprd13.prod.outlook.com
 ([fe80::fa6e:7b5:d1ec:92f3%4]) with mapi id 15.20.9587.016; Mon, 9 Feb 2026
 18:52:12 +0000
From: Benjamin Coddington <bcodding@hammerspace.com>
To: Steve Dickson <steved@redhat.com>,
	Benjamin Coddington <bcodding@hammerspace.com>
Cc: linux-nfs@vger.kernel.org,
	Chuck Lever <chuck.lever@oracle.com>,
	NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>
Subject: [PATCH v5 2/2] nfsdctl/rpc.nfsd: Add support for passing encrypted filehandle key
Date: Mon,  9 Feb 2026 13:52:09 -0500
Message-ID: <f97bfe8fcc93f0a2e64efc816acb7d8f665041b6.1770662817.git.bcodding@hammerspace.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1770662817.git.bcodding@hammerspace.com>
References: <cover.1770662817.git.bcodding@hammerspace.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN0P223CA0018.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:208:52b::35) To DM8PR13MB5239.namprd13.prod.outlook.com
 (2603:10b6:5:314::5)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR13MB5239:EE_|DM6PR13MB3740:EE_
X-MS-Office365-Filtering-Correlation-Id: b286f45b-a2b5-4e22-2a60-08de680c55ee
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7142099003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9dB8UwdonebrVhc4PFZ1OeallXypd72j2MaTVdKvbQmZMVpaSG5zxSWQYmsb?=
 =?us-ascii?Q?zJoybxzg241iW4YDTgph5Sz3AB3ZYKvEzFPpSabcRcEwxRhTo9pPVf/VgxbQ?=
 =?us-ascii?Q?+B5QHh7Cr6Fr4jR5oDo6784VUVad0cjoS1VbHydti1WiNP72XS+Wpv5AOq9f?=
 =?us-ascii?Q?6GB1DTU00dB4S2iZuhhp62bh1ZEyIu3wQz4p50l1NN0N4tDFl0+qN4pLY8KX?=
 =?us-ascii?Q?Fv4rAhWN8mxP61Tm1JWz/Deg2bkcK3rYwxZ5+JEYNJU5pzTQW0xIwp3HXoFx?=
 =?us-ascii?Q?FCba7zb4jc0JxQWvp27tDti5bP5NCeCg3deT5eyZCGXDPmYKJhprwkMhn0KL?=
 =?us-ascii?Q?8c9jZpDShMoiy5cOksm35ea599Qa+A5lDgjeQ8Dtms0seU5SYV/wOFVCRnqE?=
 =?us-ascii?Q?YZ/xFzPt9lWNjiNVjsBt0dnw0bedA7rD1qDr25lwqW7JIx3Zt0dJAKDBzWda?=
 =?us-ascii?Q?ABtZWBfNSAWS3Pyhz/MAFRfwRd5Kax2teB8Cm6tTp9+HQWOc+83KO9UXjZqu?=
 =?us-ascii?Q?JJ1NWUNBNsX3QsOPC2aqWaaKD+SJqe+B17lzp3OnJZumnb+b42+zWjXuKMym?=
 =?us-ascii?Q?rFjObCLEEd05KfVmzkOIu3+I0Ecn6AFC1jLc9bLTFkH/V92l8mbtEer8PThU?=
 =?us-ascii?Q?WM7ybgX99AhmnQ3ixLerbe5VpR6EhXsJXVpZB/IG+9gXD6rGJPBchoAIUuUp?=
 =?us-ascii?Q?kjcWLm/z7TjLx6IV6bxT2ely5SnVgArvxknRyIfbkXUavcLE7aL4w4ynErqf?=
 =?us-ascii?Q?yVRHa2b3JVlxqr/8Vf6KgvRs/DVSLqeJ9TC5zkNSUjNl2DLd6a4DxXPkMaUe?=
 =?us-ascii?Q?OvO7sJkvmql4hMPN5Zy7JZtikFBzedAr0ml6IFSZm5XWpwv09kNmOZ+Zvp7/?=
 =?us-ascii?Q?l5FKjrvjxIXZtoUHXkwh3+/SYNqxdGfNn+z51iuVI0rpqKKAgNY5QuIAnpXU?=
 =?us-ascii?Q?GFxPf/lZmi2Jp/+h5hrHo9Q8b8c8oVFcjFJFuRFrE64PBOLQlj1XLwx5E3t8?=
 =?us-ascii?Q?PiMSxk3lJN4LENs9G1g6BC+XTtOBccalAbn1m8yyRjJqVIDxeCFMaVwyXo1k?=
 =?us-ascii?Q?ATPChZuwiLLftRiNFILK60UGobkIz6cNy1Opkk7YbeIe5QWyupfYsKdqDuLf?=
 =?us-ascii?Q?UYJ28U2ydKT2elozlD3KO/CX+5ZZVKBkYHYz4vJERFqwRQUMph/eX06jrqrK?=
 =?us-ascii?Q?ifYLu42BfSbp9+DnHoMJkxv8r5IjQDV1Cq1AT0t+j62A8x4npb6QUwqzfDsa?=
 =?us-ascii?Q?5AYa9xJTp4fFeyY8AZd19Yj5pPhtlmwfBQWABBxWL8wYc3P7vXuhb5IS4mkK?=
 =?us-ascii?Q?IfiGdYQEq58sDRMbfmc8AhoJdgh6ylJs5+/2I48t4GHf7Mr4BZqNzvuE6G57?=
 =?us-ascii?Q?HOqZgYuA/rYDDG3ZLfZTibMM4l9QIbMQzZ394p++kM8m2XR08LoPqg58uQWq?=
 =?us-ascii?Q?PfaVyXUEn7LtPDs4fIaOODZubm7XKTC6H1DyvJHgX11+ohT766UfY0pb3lhk?=
 =?us-ascii?Q?+5FldyjjDXxwkPVgwI95/E0y5uyx13cHd+hbry3nY6i++ZPq9u+jEcr2v55e?=
 =?us-ascii?Q?y/g/cmeAtXWRuR/dIJc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR13MB5239.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7142099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tBbekSqEECo4IT6M4Ys052TpXUzrNATyHrdFnj2/IC40GjOUYErZrfUyyNeY?=
 =?us-ascii?Q?YbLJhywgOR98cczRxzqQQegRn6+pdFw//xYOBw1Au8zJB0N633ng63teVyLU?=
 =?us-ascii?Q?0epihtyz76NSNqZrhl/LrpZL02/XKtTb+MtuKh9q3kxLhvQJTssAqj7dt5jM?=
 =?us-ascii?Q?8r+QrINkC7PfYt7usMNUvu6YcfKkFzoQJ1t5HL4cu211unzNC9rsrv8fmccc?=
 =?us-ascii?Q?XZYsUN9eQF9yEQDPMMVVTSqdC+joRHpEuJBH64ggeOMaykqpLpSTDNQWfihI?=
 =?us-ascii?Q?s/GWZjZmw+2nmtHOznvk0EDxXH96I/lc00AI40EUU/2V1tpOfW5xzbqG03Z2?=
 =?us-ascii?Q?eyA+4QVhhPKlB2bdxuPS9MceZx88DNUeKVNN5KB2RRuDzORW+RkvlurZbELk?=
 =?us-ascii?Q?gY8M7tW5Gyqg8XrbRs0a1MGv1sfTmht/wTZqMHY1hKPU1OMyhgtpAbcoQXVL?=
 =?us-ascii?Q?A6gY9uQ5BZSNKuzoXYchW0jH9m8mtolTmpBPrL/co8ccUHFnQ9iv40H1ARbr?=
 =?us-ascii?Q?rs9rp6lZlSGRYaQ8ipTsyWR8zOxFBIyWUQn3PHsp7AalAAubx+yJprjhGxMm?=
 =?us-ascii?Q?7Dcy1y8zl9k3CYMrFT1xCotb5v2PMvn9YXs1jQTYm9OmcLTVp61SDP6UWdBo?=
 =?us-ascii?Q?gpM9WZLEDu4GXszhtW721VokGUyqg314e0u1ZtsBfRxlLq0X3zKZSVKVWjNR?=
 =?us-ascii?Q?uY9/1Gw+avpCpsxKhvuPLPiHLQYOizYtVzDLwj5dBd9G5pfK6VAYK9G20Yyl?=
 =?us-ascii?Q?SQ7Ml9ieewt8NCj7o9nrvm4n9g8HUL06ZY2v9DAMMrZxY8zbMuhBtTBcyE4p?=
 =?us-ascii?Q?s/Ru1gI8NjJzy/YnQXzwawA144pXYks0/HlsAc1wgM/N/fXuOZuaaKGJ0QoZ?=
 =?us-ascii?Q?IDj7EPQ/+fDiQF7A856JBIb4uKbnyET7j0tXuIKxIUXQNVLlEmd7LmqbxxNi?=
 =?us-ascii?Q?oT5gSFQ8OkhUKrDQIvDsDuQH4Q5YBYMOAl7HHUkjzhSjPkDMLlpcSbtbrIq8?=
 =?us-ascii?Q?XUnCMzGA3JLUVcM34n5EK0YwFYH6KHwN39+yb0qGLj4TJ/9hsBVDHfu+hIxG?=
 =?us-ascii?Q?elh/oj6aIoaiKpE0lB9dGEW5IfCGNVzSw6mqO+k3eCsefCQi+Z7WHqbbg+ox?=
 =?us-ascii?Q?6i0xgWXKgzEILStR1C44Oh4n/F0i20kYQBhKMOIjvep/pBq6LKHQVdtfcPfE?=
 =?us-ascii?Q?wQcebvr3I2uqjiN7s6kK2NegxTo+ICwWEVFqWUpjKpIYFFHV3HuTgqrwbnwW?=
 =?us-ascii?Q?CN0dVF7RmX2dyRoaIKoIQodqWS5EUd5w8umQrzKTnUz4gB+IhRSU5lyjZfXP?=
 =?us-ascii?Q?PCiO8Sg99irqEvjhqfE5i1XyLhsgYLQNJ6wHTEh29lyOVruwpKSWnFuOYbfE?=
 =?us-ascii?Q?pU2NxC0AfVwDa0yajvbhj69IV4WM5pAPEdSOKHYHxlDa87cCaKR0PDBlddjP?=
 =?us-ascii?Q?cArqjCRIO4RaTw85WJRYeFyNkHdRHRC7SFHPnrK/ko7bTH9k+GR5EdOhllIE?=
 =?us-ascii?Q?AKIPo7+8tbt0QXZEAd/DpSbbGhFXJxAdxu0jPss+XgwLiFDY62HJYJLafVBG?=
 =?us-ascii?Q?0cV9a+3GXHsjOaGDsAXmagjQQygDWIKDhb5kMmB1vwmaW0S1yOPTIJh6T3Ne?=
 =?us-ascii?Q?bl8YnqwJN3PJUXpxb6r5v37Z7ZUVUAsKkpkgIWiREeEslFEF1mU7hR7a2Qzc?=
 =?us-ascii?Q?TGerxmGjc0ZlsyTVXQVv0DzA8mTc4WG8vCOsbxP7jHyUEVZtknlVz67ECDYI?=
 =?us-ascii?Q?nMI0AmDssIZhlh0MJuCmQ6HsYHioWEw=3D?=
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b286f45b-a2b5-4e22-2a60-08de680c55ee
X-MS-Exchange-CrossTenant-AuthSource: DM8PR13MB5239.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2026 18:52:12.5147
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: awK1eWXuQ+mJwEg60FtNu/uQQCh7bq/0vLiXmDs2K/69DAB2spKGmbjzLIrWB3vZD0M0yz62xLv5AL7v2xkDwJSWgEQQGZaZO0bEhbBk79M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR13MB3740
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
	TAGGED_FROM(0.00)[bounces-18820-lists,linux-nfs=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 54D0A113DA3
X-Rspamd-Action: no action

If fh-key-file=<path> is set in the nfsd section of nfs.conf, the "nfsdctl
autostart" command will hash the contents of the file with libuuid's
uuid_generate_sha1 and send the first 16 bytes into the kernel on
NFSD_A_SERVER_FH_KEY. A compatible kernel can use this key to sign
filehandles.

Also add -k, --fh-key-file=<path> option to the "nfsdctl threads" command
effecting the same result.

Signed-off-by: Benjamin Coddington <bcodding@hammerspace.com>
---
 nfs.conf                     |  1 +
 support/include/nfslib.h     |  2 +
 support/nfs/Makefile.am      |  4 +-
 support/nfs/fh_key_file.c    | 79 ++++++++++++++++++++++++++++++++++++
 systemd/nfs.conf.man         |  1 +
 utils/nfsd/nfssvc.h          |  1 +
 utils/nfsdctl/nfsd_netlink.h |  1 +
 utils/nfsdctl/nfsdctl.8      |  8 +++-
 utils/nfsdctl/nfsdctl.c      | 57 +++++++++++++++++++++++---
 9 files changed, 145 insertions(+), 9 deletions(-)
 create mode 100644 support/nfs/fh_key_file.c

diff --git a/nfs.conf b/nfs.conf
index 3cca68c3530d..39068c19d7df 100644
--- a/nfs.conf
+++ b/nfs.conf
@@ -76,6 +76,7 @@
 # vers4.2=y
 rdma=y
 rdma-port=20049
+# fh-key-file=/etc/nfs_fh.key
 
 [statd]
 # debug=0
diff --git a/support/include/nfslib.h b/support/include/nfslib.h
index eff2a486307f..c8601a156cba 100644
--- a/support/include/nfslib.h
+++ b/support/include/nfslib.h
@@ -22,6 +22,7 @@
 #include <paths.h>
 #include <rpcsvc/nfs_prot.h>
 #include <nfs/nfs.h>
+#include <uuid/uuid.h>
 #include "xlog.h"
 
 #ifndef _PATH_EXPORTS
@@ -132,6 +133,7 @@ struct rmtabent *	fgetrmtabent(FILE *fp, int log, long *pos);
 void			fputrmtabent(FILE *fp, struct rmtabent *xep, long *pos);
 void			fendrmtabent(FILE *fp);
 void			frewindrmtabent(FILE *fp);
+int				hash_fh_key_file(const char *fh_key_file, uuid_t hash);
 
 _Bool state_setup_basedir(const char *, const char *);
 int setup_state_path_names(const char *, const char *, const char *, const char *, struct state_paths *);
diff --git a/support/nfs/Makefile.am b/support/nfs/Makefile.am
index 2e1577cc12df..775bccc6c5ea 100644
--- a/support/nfs/Makefile.am
+++ b/support/nfs/Makefile.am
@@ -7,8 +7,8 @@ libnfs_la_SOURCES = exports.c rmtab.c xio.c rpcmisc.c rpcdispatch.c \
 		   xcommon.c wildmat.c mydaemon.c \
 		   rpc_socket.c getport.c \
 		   svc_socket.c cacheio.c closeall.c nfs_mntent.c \
-		   svc_create.c atomicio.c strlcat.c strlcpy.c
-libnfs_la_LIBADD = libnfsconf.la
+		   svc_create.c atomicio.c strlcat.c strlcpy.c fh_key_file.c
+libnfs_la_LIBADD = libnfsconf.la -luuid
 libnfs_la_CPPFLAGS = $(AM_CPPFLAGS) $(CPPFLAGS) -I$(top_srcdir)/support/reexport
 
 libnfsconf_la_SOURCES = conffile.c xlog.c
diff --git a/support/nfs/fh_key_file.c b/support/nfs/fh_key_file.c
new file mode 100644
index 000000000000..ee26df5b70bd
--- /dev/null
+++ b/support/nfs/fh_key_file.c
@@ -0,0 +1,79 @@
+/*
+ * Copyright (c) 2025 Benjamin Coddington <bcodding@hammerspace.com>
+ * All rights reserved.
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions
+ * are met:
+ * 1. Redistributions of source code must retain the above copyright
+ *    notice, this list of conditions and the following disclaimer.
+ * 2. Redistributions in binary form must reproduce the above copyright
+ *    notice, this list of conditions and the following disclaimer in the
+ *    documentation and/or other materials provided with the distribution.
+ *
+ * THIS SOFTWARE IS PROVIDED BY THE AUTHOR ``AS IS'' AND ANY EXPRESS OR
+ * IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
+ * OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
+ * IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT,
+ * INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
+ * NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
+ * DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
+ * THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
+ * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
+ * THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ */
+
+#include <sys/types.h>
+#include <unistd.h>
+#include <errno.h>
+#include <uuid/uuid.h>
+
+#include "nfslib.h"
+
+#define HASH_BLOCKSIZE  256
+int hash_fh_key_file(const char *fh_key_file, uuid_t uuid)
+{
+	const char seed_s[] = "8fc57f1b-1a6f-482f-af92-d2e007c1ae58";
+	FILE *sfile = NULL;
+	char buf[HASH_BLOCKSIZE];
+	size_t pos;
+	int ret = 0;
+
+	sfile = fopen(fh_key_file, "r");
+	if (!sfile) {
+		ret = errno;
+		xlog(L_ERROR, "Unable to read fh-key-file %s: %s", fh_key_file, strerror(errno));
+		goto out;
+	}
+
+	uuid_parse(seed_s, uuid);
+
+	while (1) {
+		size_t sread;
+		pos = 0;
+
+		if (feof(sfile))
+			goto finish_block;
+
+		sread = fread(buf + pos, 1, HASH_BLOCKSIZE - pos, sfile);
+		pos += sread;
+
+		if (pos == HASH_BLOCKSIZE)
+			break;
+
+		if (sread != HASH_BLOCKSIZE) {
+			ret = ferror(sfile);
+			if (ret)
+				goto out;
+			goto finish_block;
+		}
+		uuid_generate_sha1(uuid, uuid, buf, HASH_BLOCKSIZE);
+	}
+finish_block:
+	if (pos)
+		uuid_generate_sha1(uuid, uuid, buf, pos);
+out:
+	if (sfile)
+		fclose(sfile);
+	return ret;
+}
diff --git a/systemd/nfs.conf.man b/systemd/nfs.conf.man
index ecdc4fc90327..a6b5c907b457 100644
--- a/systemd/nfs.conf.man
+++ b/systemd/nfs.conf.man
@@ -176,6 +176,7 @@ Recognized values:
 .BR vers4.1 ,
 .BR vers4.2 ,
 .BR rdma ,
+.BR fh-key-file ,
 
 Version and protocol values are Boolean values as described above,
 and are also used by
diff --git a/utils/nfsd/nfssvc.h b/utils/nfsd/nfssvc.h
index 4d53af1a8bc3..463110cac804 100644
--- a/utils/nfsd/nfssvc.h
+++ b/utils/nfsd/nfssvc.h
@@ -30,3 +30,4 @@ void	nfssvc_setvers(unsigned int ctlbits, unsigned int minorvers4,
 		       unsigned int minorvers4set, int force4dot0);
 int	nfssvc_threads(int nrservs);
 void	nfssvc_get_minormask(unsigned int *mask);
+int nfssvc_setfh_key(const char *fh_key_file);
diff --git a/utils/nfsdctl/nfsd_netlink.h b/utils/nfsdctl/nfsd_netlink.h
index e9efbc9e63d8..97c7447f4d14 100644
--- a/utils/nfsdctl/nfsd_netlink.h
+++ b/utils/nfsdctl/nfsd_netlink.h
@@ -36,6 +36,7 @@ enum {
 	NFSD_A_SERVER_LEASETIME,
 	NFSD_A_SERVER_SCOPE,
 	NFSD_A_SERVER_MIN_THREADS,
+	NFSD_A_SERVER_FH_KEY,
 
 	__NFSD_A_SERVER_MAX,
 	NFSD_A_SERVER_MAX = (__NFSD_A_SERVER_MAX - 1)
diff --git a/utils/nfsdctl/nfsdctl.8 b/utils/nfsdctl/nfsdctl.8
index a86ffe8e1f4d..1f526e77bebf 100644
--- a/utils/nfsdctl/nfsdctl.8
+++ b/utils/nfsdctl/nfsdctl.8
@@ -159,6 +159,12 @@ These options are specific to the "threads" subcommand:
     kernel will start the minimum number and dynamically start and stop threads as
     needed. If the minimum is larger than the maximum, then dynamic threadis is
     disabled, and the maximum number is started.
+
+\-k, \-\-fh\-key\-file=
+    If set to the path of a file, use the first 128 bits of the sha1 hash
+    of the file's contents as the server's filehandle signing key.
+    Exports with the "sign_fh" export option will use this key to append an
+    a signature to guard against filehandle guessing attacks.
 .fam
 .fi
 .if n .RE
@@ -336,4 +342,4 @@ privileges.
 nfs.conf(5), rpc.nfsd(8), rpc.mountd(8), exports(5), exportfs(8), rpc.rquotad(8), nfsstat(8), netconfig(5)
 .SH "AUTHOR"
 .sp
-Jeff Layton
\ No newline at end of file
+Jeff Layton
diff --git a/utils/nfsdctl/nfsdctl.c b/utils/nfsdctl/nfsdctl.c
index 6a20d180a81e..ed0c4fded339 100644
--- a/utils/nfsdctl/nfsdctl.c
+++ b/utils/nfsdctl/nfsdctl.c
@@ -29,6 +29,7 @@
 
 #include <readline/readline.h>
 #include <readline/history.h>
+#include <uuid/uuid.h>
 
 #ifdef USE_SYSTEM_NFSD_NETLINK_H
 #include <linux/nfsd_netlink.h>
@@ -42,6 +43,7 @@
 #include "lockd_netlink.h"
 #endif
 
+#include "nfslib.h"
 #include "nfsdctl.h"
 #include "conffile.h"
 #include "xlog.h"
@@ -636,8 +638,10 @@ out:
 }
 
 static int threads_doit(struct nl_sock *sock, int cmd, int grace, int lease,
-			int pool_count, int *pool_threads, char *scope, int minthreads)
+			int pool_count, int *pool_threads, char *scope, int minthreads,
+			uuid_t fh_key)
 {
+	struct nl_data *fh_key_data = NULL;
 	struct genlmsghdr *ghdr;
 	struct nlmsghdr *nlh;
 	struct nl_msg *msg;
@@ -663,6 +667,19 @@ static int threads_doit(struct nl_sock *sock, int cmd, int grace, int lease,
 			nla_put_string(msg, NFSD_A_SERVER_SCOPE, scope);
 		if (minthreads >= 0)
 			nla_put_u32(msg, NFSD_A_SERVER_MIN_THREADS, minthreads);
+		if (!uuid_is_null(fh_key)) {
+			if (nfsd_threads_max_nlattr < NFSD_A_SERVER_FH_KEY) {
+				xlog(L_ERROR, "This kernel does not support signed filehandles.");
+			} else {
+				fh_key_data = nl_data_alloc(fh_key, sizeof(uuid_t));
+				if (!fh_key_data) {
+					xlog(L_ERROR, "failed to allocate netlink data");
+					ret = 1;
+					goto out;
+				}
+				nla_put_data(msg, NFSD_A_SERVER_FH_KEY, fh_key_data);
+			}
+		}
 		for (i = 0; i < pool_count; ++i)
 			nla_put_u32(msg, NFSD_A_SERVER_THREADS, pool_threads[i]);
 	}
@@ -697,14 +714,17 @@ static int threads_doit(struct nl_sock *sock, int cmd, int grace, int lease,
 out_cb:
 	nl_cb_put(cb);
 out:
+	if (fh_key_data)
+		nl_data_free(fh_key_data);
 	nlmsg_free(msg);
 	return ret;
 }
 
 static void threads_usage(void)
 {
-	printf("Usage: %s threads { --min-threads=X } [ pool0_count ] [ pool1_count ] ...\n", taskname);
+	printf("Usage: %s threads { --min-threads=X } { --fh-key-file=file } [ pool0_count ] [ pool1_count ] ...\n", taskname);
 	printf("    --min-threads= set the minimum thread count per pool to value\n");
+	printf("    --fh-key-file= path to a file to set the filehandle signing key\n");
 	printf("    pool0_count: thread count for pool0, etc...\n");
 	printf("Omit any arguments to show current thread counts.\n");
 }
@@ -712,6 +732,7 @@ static void threads_usage(void)
 static const struct option threads_options[] = {
 	{ "help", no_argument, NULL, 'h' },
 	{ "min-threads", required_argument, NULL, 'm' },
+	{ "fh-key-file", required_argument, NULL, 'k' },
 	{ },
 };
 
@@ -721,9 +742,11 @@ static int threads_func(struct nl_sock *sock, int argc, char **argv)
 	int *pool_threads = NULL;
 	int minthreads = -1;
 	int opt, pools = 0;
+	uuid_t fh_key;
 
+	uuid_clear(fh_key);
 	optind = 1;
-	while ((opt = getopt_long(argc, argv, "hm:", threads_options, NULL)) != -1) {
+	while ((opt = getopt_long(argc, argv, "hm:k:", threads_options, NULL)) != -1) {
 		switch (opt) {
 		case 'h':
 			threads_usage();
@@ -741,6 +764,18 @@ static int threads_func(struct nl_sock *sock, int argc, char **argv)
 				return 1;
 			}
 			break;
+		case 'k':
+			if (nfsd_threads_max_nlattr < NFSD_A_SERVER_FH_KEY) {
+				xlog(L_ERROR, "This kernel does not support signed filehandles.\n");
+				return 1;
+			}
+
+			errno = hash_fh_key_file(optarg, fh_key);
+			if (errno) {
+				fprintf(stderr, "Error hashing key file %s: %s.", optarg, strerror(errno));
+				return 1;
+			}
+			break;
 		}
 	}
 
@@ -768,7 +803,8 @@ static int threads_func(struct nl_sock *sock, int argc, char **argv)
 			}
 		}
 	}
-	return threads_doit(sock, cmd, 0, 0, pools, pool_threads, NULL, minthreads);
+	return threads_doit(sock, cmd, 0, 0, pools, pool_threads, NULL,
+				minthreads, fh_key);
 }
 
 /*
@@ -1760,8 +1796,9 @@ static int autostart_func(struct nl_sock *sock, int argc, char ** argv)
 	int *threads, grace, lease, idx, ret, opt, pools, minthreads;
 	struct conf_list *thread_str;
 	struct conf_list_node *n;
-	char *scope, *pool_mode;
+	char *scope, *pool_mode, *fh_key_file;
 	bool failed_listeners = false;
+	uuid_t fh_key;
 
 	optind = 1;
 	while ((opt = getopt_long(argc, argv, "h", help_only_options, NULL)) != -1) {
@@ -1836,6 +1873,14 @@ static int autostart_func(struct nl_sock *sock, int argc, char ** argv)
 		threads[0] = DEFAULT_AUTOSTART_THREADS;
 	}
 
+	uuid_clear(fh_key);
+	fh_key_file = conf_get_str("nfsd", "fh-key-file");
+	if (fh_key_file) {
+		ret = hash_fh_key_file(fh_key_file, fh_key);
+		if (ret)
+			return ret;
+	}
+
 	lease = conf_get_num("nfsd", "lease-time", 0);
 	scope = conf_get_str("nfsd", "scope");
 	minthreads = conf_get_num("nfsd", "min-threads", -1);
@@ -1846,7 +1891,7 @@ static int autostart_func(struct nl_sock *sock, int argc, char ** argv)
 	}
 
 	ret = threads_doit(sock, NFSD_CMD_THREADS_SET, grace, lease, pools,
-			   threads, scope, minthreads);
+			   threads, scope, minthreads, fh_key);
 out:
 	free(threads);
 	return ret;
-- 
2.50.1


