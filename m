Return-Path: <linux-nfs+bounces-5723-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F3B6695EFB5
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Aug 2024 13:28:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B19A32833A7
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Aug 2024 11:28:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 869021527BB;
	Mon, 26 Aug 2024 11:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="X9gmI8HY"
X-Original-To: linux-nfs@vger.kernel.org
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2071.outbound.protection.outlook.com [40.107.117.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADC19143C7D;
	Mon, 26 Aug 2024 11:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724671710; cv=fail; b=CFNCDVQbcSEcQcMUIBgJgeh1ppLkAFykAErJvF16OzC2vtF8i9u/F2vQ7PkbOb0RySYcbtaxye1WMxxKgEO8xtrzem5Fcc+2TLv4IA9zjyHxKttrvKOJVwQBi0Om4xTCFfex9YEFsb0XbmF0wtlhHY6S6T2WltB+NBmSIZlgp68=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724671710; c=relaxed/simple;
	bh=gKzsa6qzZiHgZu80ug8E4wtiQFcSxFQayHOiWoMiz5I=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=iWGs5YvCvssTTbGcIEzcKof5dDycbboMux5q9znBUWGcNcz5nAdG1um3jkBe5kWvmcESgfCbPE7Os9ouF+d4hNRzxHr1cIOHL2tC4nyXqUIF0ZLnMKGVRbFW2cQgzWNDmsvG6jytHJsqcOrkG65ixkzA4YKbQiKLzKNU2bK2pVA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=X9gmI8HY; arc=fail smtp.client-ip=40.107.117.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KP+hnXXAWrojkf1j2j+mjxEi7iohEOMsfR+95D9dXbVoE4SR+5FGSrbrcA9DclGCWQ3UlclHIPh84ktcr+/5lB3iNGAtw7M+crQ6G45zy/rnbzg4tdQQUfPJ/of+RqGg7YUp9JxyiYf/DEMAYCJHk/Agv1FqmGmQipbz0rZxQZVNW7eI17zxsSZQ69KLrJ0NHtvOO69v3nJY1nYP7l36jou6+OJnCz1T9PeeaWi/Xp+bBE/4SCPx2wcrKnfbwvY749ptqTLVz3J/Ec5evEffbBZdZinJTPC+C61rrhy5oFSTXaFlyZms+HaJvOLPSbV9llZWMOOyMRcdrp0WG+vQLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QipNcnJjIK6H2CVDD9TR4jc9Vi9tcfZU1v+HhT39eYU=;
 b=Uj7j0NzPJ9DpUhx37p9E5TWpVefcKPF6MQWbq6CCMDWjohBYxNLzAy769pQlQE3IwzOiFHpduBHCIQKSBdvwObrZyZrnouH/6YeO1OFnyfqSKfwH+ZXu8YijyuQK0mtVWkJjXG9DtREcWQUEG2Oj/V/BYZ6ZC65ts9YA5gDucsFoxzBdeSYTqNDyiJuTGUytBPLTlPgZQQPsz+UJv3aN7CRihvOtQTiQTtSjW7HqL1ZUl+hpR+cvpohOcQ4au4qkJ40ZcPc3r2PSRMXoXMX84oZB2pf3kME942fsfZwPK3HN0klt/pKQ3dwVkG3UCHK8aq/25F92oxDw0JtAqtP7EA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QipNcnJjIK6H2CVDD9TR4jc9Vi9tcfZU1v+HhT39eYU=;
 b=X9gmI8HYg89Uqr/mwDFrEFpKt6VK3KEEakfIAp+Xj6tHahONsZYfEWXBcC9XL11D2q+VgEdUAEdm7JUToJaIKltgitxaU2mCmh5BE8IHSeO0xJfepgFqTOjBreXTNoTIMeOX9RmfW7LOQRLZpOV9iNqCWBwbWRBLTGQfX6Py7rOKxcr0r8hOKy3DsiqqwKwGhnNQNb+rqNyabjv539FQ8hk0WP1yiqlmT1Vd3/VCk2XFp6+DQTvt1q+k7nntku3CCuVC4GYXDJU0zD6pW5nLAtl348aKtkbJsu/VJUIvQ9UwGfztBBgz2G79LONCnm3fr5RGJFKMGneEHzsrGxJ0uw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SI2PR06MB4122.apcprd06.prod.outlook.com (2603:1096:4:fc::8) by
 SEYPR06MB7041.apcprd06.prod.outlook.com (2603:1096:101:1d6::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7897.24; Mon, 26 Aug 2024 11:28:23 +0000
Received: from SI2PR06MB4122.apcprd06.prod.outlook.com
 ([fe80::b711:7858:9caf:bd78]) by SI2PR06MB4122.apcprd06.prod.outlook.com
 ([fe80::b711:7858:9caf:bd78%5]) with mapi id 15.20.7897.021; Mon, 26 Aug 2024
 11:28:23 +0000
From: Yan Zhen <yanzhen@vivo.com>
To: chuck.lever@oracle.com,
	jlayton@kernel.org,
	trondmy@kernel.org,
	anna@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: neilb@suse.de,
	okorniev@redhat.com,
	Dai.Ngo@oracle.com,
	tom@talpey.com,
	linux-nfs@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	opensource.kernel@vivo.com,
	Yan Zhen <yanzhen@vivo.com>
Subject: [PATCH v2] sunrpc: Fix error checking for d_hash_and_lookup()
Date: Mon, 26 Aug 2024 19:25:09 +0800
Message-Id: <20240826112509.2368945-1-yanzhen@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYWP286CA0019.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:262::6) To SI2PR06MB4122.apcprd06.prod.outlook.com
 (2603:1096:4:fc::8)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR06MB4122:EE_|SEYPR06MB7041:EE_
X-MS-Office365-Filtering-Correlation-Id: f477d8a3-257b-4f25-aa91-08dcc5c231d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|376014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?meecYWD/h1Z6j1gXdlu2JDoNmTA+NOYb8WijGXiSfpowuJUC4bO2oh/KQudh?=
 =?us-ascii?Q?zjYNLvORVF2h9imJze3BfkEHWoGKOEsgByL07+lq/c1MzVkHgJ6cz54jjAkr?=
 =?us-ascii?Q?jm9+P/h5RmVDOIEtC1nqKiQo1aTFL7gKWu0oo/atELHG/p6WCEOoxD0kCvPn?=
 =?us-ascii?Q?KTXX8OW+9fwpR2S11SKf39WrOqs2HkWCfE4VYyFZzI5ObLe3MWtG/kn5wVea?=
 =?us-ascii?Q?OcRl347HV36N4ArljD2b05Zyy4sDl4yR0ZftI6uND9qpEfMb9QciH5JlEANJ?=
 =?us-ascii?Q?DkDbm293qHxPGCOezHHHHFHdMPZFI4wshw8wdxgsv7zaPNqav7EiGAD66IjV?=
 =?us-ascii?Q?czgYIl3tsxckT9rU7lP9U73cI1XDwVMsrfhpzzSV5o0zFn8+0URnTSagO8h7?=
 =?us-ascii?Q?bDAvtMongpAQ7UA9gGs3k9NUtBAbQHEYaUMojV9Bze++dI2jv7ySw4M6NQuC?=
 =?us-ascii?Q?cUnoWISAANSxN/fTdqazZ9y4VYy2tFs4otsQS3KljEIgXDchjWPC4ID1cktC?=
 =?us-ascii?Q?KlPqSfB1ZP/KgWr2MK6XosLrd1tbmW6w41dtpNf8lXblSQw5ck+FVT1M6yf0?=
 =?us-ascii?Q?rYPSx3++WNQDc027RsjeUgGNRj7LqkHaBqs/Z2CUeZrh++ODxSbjrMlIsSCj?=
 =?us-ascii?Q?UwJZas6iQ68OnPjgq8syKXTLa0lo2JTMEsP0g/LKHM7BBaJ+dP0Kyf9o9xES?=
 =?us-ascii?Q?hoFX4zLowdc4SwPmVIhAdOxWXoabXYsK1G7UUmb4G7H+zpWaz/vItZsHs67B?=
 =?us-ascii?Q?fqPt9IvQbKcair8FEYv5GXrSaSf463LkDK09XJIjlSGKGO7Hjb7pTaQv+zJd?=
 =?us-ascii?Q?xG8z6v4jXQT5599E2hbMbdEWm8WGu7z9b8a4efjH6HmexAdycTFdvmMSGz4p?=
 =?us-ascii?Q?TP67QXv06k+C+UirIBmCcQq9WbPmBkYYrzBb9zZos1JyCTxqWjVtW4My0uk7?=
 =?us-ascii?Q?VAVXzN3hIp1MIE2uyPcDgW5mTp1KXt7Rinj6Wcn70HPmsYmpYDk5rvb6+uLA?=
 =?us-ascii?Q?Ty0eyOTV+8SK5DuPgetU5KcantD40DlTyGjEYq+RO0Z7f+mrBhG5FgETW1Ix?=
 =?us-ascii?Q?reh4fCK+qGeoVVaWLJ6pJBIrXwFC/Bm/P5S9t3Ma+Ise1eJJjYoj8C4uZMUq?=
 =?us-ascii?Q?y7+kImRhQoTpgCMTcVbhbHtZykAS4oAev5JmqmY0LlzXe8VAOwZjw2tgowY6?=
 =?us-ascii?Q?AamKtZ+QTtye6U5eHsgcMQ8HTjKLKM+hJ+B1hDqTdb3unPuZzIU9usLKJOVT?=
 =?us-ascii?Q?A0DrDZRNbwwr/ccEM57WDcBdrFp7+hyfD9j1m8PRrgWfIZuwEh7FzEyD89Qc?=
 =?us-ascii?Q?cxUg5EQsokF9ycEP3lpG2HNjHH4oNQzws4C+nhP20VejSyqCpBp596e2ve2W?=
 =?us-ascii?Q?MTLu09UGJeJrxTmbWU8js7WRo4AkayWrHoz3YGBwe34QXWefpw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR06MB4122.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(376014)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4nuWE8vzaM3mLymvRr8vYEsxjo6gVCJnJeZfGSVga1WIonmzJWDkoBM4bYRY?=
 =?us-ascii?Q?Wikl3P+PRwAgSZq83Sm3TFq/9ydnHWRGAWvk6c4QaGe4CEp86+zS8jfWw7Gu?=
 =?us-ascii?Q?2g6CoFYH3MSTSNXzzuP16vuN5E8szLitfZJBR4y3WRlYCtzQabmYT4t6wyfV?=
 =?us-ascii?Q?IH++33EWDkXoymejmdPNn3b0fX89MqvjhB5lGU67SDLQHOi1CPONs6SCfVFi?=
 =?us-ascii?Q?9mxBekfM68ATnwR6pp7jH/5BZNnIEdCdggFILOET+VsxURuGFcMkt3aZdN+c?=
 =?us-ascii?Q?NKtcpY6+TUiaSDFswEdKJQBbEKN5XFE/OTO2b1Whm3bK2aoTtw1NFvk0frxo?=
 =?us-ascii?Q?DCU8SRIr9zfgaasZxi3SENwjCOpTZp+sauJOjVF3g0h6N/GpxZ1BcqR7rD03?=
 =?us-ascii?Q?xWRwwAV2XSsDRp7yQBSAreoOOAen4hD7gMnMHKOQ+0lcwe4f1hkStEKCggSs?=
 =?us-ascii?Q?pzRCYoQ5+SKBn82sKnOTIK7USUYGg4Bk7/Dw4I5Y5+1JloY8TdIel+dHjfRU?=
 =?us-ascii?Q?fF86EMgLmhJjcvOiRC3TI2nI6hFLCHS0kdmYQnGFtG9A168FgeP4qoGexyQy?=
 =?us-ascii?Q?5IKBN3yDov7xpfkpt6rdoNys43sAmiaj5zQd7wWNMhc4gLjaQATWypG7Ef00?=
 =?us-ascii?Q?9bkczArwIxDvyV5++t43EyWV0ELn+lM1fg9P2+iZeSvGzqXofJJv9dmHCkhl?=
 =?us-ascii?Q?tYy7aZESNu0o+rj+JfiMgPJJC7uz9/pJaA6Vzgvy+sUWzLFoJO4ZBKWmbRwO?=
 =?us-ascii?Q?hTTQgNzmtjAEbam7BavBY3ZNs8ytyIZRcVenFkW80PUTax/4hHN9PCzuiBB/?=
 =?us-ascii?Q?+GhvZoOS9A1syzJZSdp8UEaDjGDrK0zTW5EZ9SxqAMvyhTtS+MtGLZgP8et5?=
 =?us-ascii?Q?WBgy1cAUEfKf7CbFFkRhI6BIEyJJgtReZskAvAB6jmVu60gjPSph/A0VrQUd?=
 =?us-ascii?Q?V2y+OSRIk116K4Mw73/hCRvC1kD/PoEZJfYG0Sbz3KYnO9Q5URKHGLtzdbc4?=
 =?us-ascii?Q?u5lub42opiUmwOna2mQ433YfneeH0USP4tTnOLbPnTM1cZb1XaaCwy9hxeR0?=
 =?us-ascii?Q?Hyp8Yqa0JInwWHAvGtWX8HbKy+HvjnZE2ScqTY3pPTk6hQdzgIaEKS8NKrNE?=
 =?us-ascii?Q?bp9rIJ+jPvEzefIomEogANBADoCoztn6MqSmsS54BWafm4PckaM3wXj50tyC?=
 =?us-ascii?Q?pT9e7orxc6EQrHQpQ4DiGbGFiV2BdvnViAD4qJ4vbym1LkdG5fJ6+vvM/i9V?=
 =?us-ascii?Q?Ym/SFuM1d/0wIOKhp2mvGnaj+5iFGkv4W85JlpeX1qCgHczhIDm7tcqRopxF?=
 =?us-ascii?Q?0I2fAVUOoCUjl12OyveHZagr99R59Gl5zYUKPj9Y+Zj6K8fqg24Pzx0w+6ah?=
 =?us-ascii?Q?bX+1qn7EQ4qGeGZp2WxetbChczvEAum9Mcer+m6m4cwU2bfGa9TvOAGenKAs?=
 =?us-ascii?Q?dZsIxi7hwM6/rGPwjsA6eZEQoCY0p2sjhV0FyxkGuvn61e/UXSYmxtIhxPoQ?=
 =?us-ascii?Q?aMAL3PsxEkdgCEhMcT9iEw/qedjhqEXyfaJBYEuNBme6D4ASyjWieIG3jtC0?=
 =?us-ascii?Q?BkZVHxXkvFsX03LxibyhB06xQeF8Z/Wk2oQyhZzR?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f477d8a3-257b-4f25-aa91-08dcc5c231d6
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB4122.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2024 11:28:23.2073
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jxjZTj5IU4NO1IDRUD8wwTFA0+d/uLw0+FUap+GTmR9OWJJs1ieZMo1ZDL+0wUgV3UPGz6RkrXQO6f9rd2T17A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB7041

The d_hash_and_lookup() function returns either an error pointer or NULL.

It might be more appropriate to check error using IS_ERR_OR_NULL().

Fixes: b7ade38165ca ("sunrpc: fixed rollback in rpc_gssd_dummy_populate()")
Signed-off-by: Yan Zhen <yanzhen@vivo.com>
---

Changes in v2:
- Providing a "fixes" tag blaming the commit.

 net/sunrpc/rpc_pipe.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/sunrpc/rpc_pipe.c b/net/sunrpc/rpc_pipe.c
index 910a5d850d04..fd03dd46b1f2 100644
--- a/net/sunrpc/rpc_pipe.c
+++ b/net/sunrpc/rpc_pipe.c
@@ -1306,7 +1306,7 @@ rpc_gssd_dummy_populate(struct dentry *root, struct rpc_pipe *pipe_data)
 
 	/* We should never get this far if "gssd" doesn't exist */
 	gssd_dentry = d_hash_and_lookup(root, &q);
-	if (!gssd_dentry)
+	if (IS_ERR_OR_NULL(gssd_dentry))
 		return ERR_PTR(-ENOENT);
 
 	ret = rpc_populate(gssd_dentry, gssd_dummy_clnt_dir, 0, 1, NULL);
@@ -1318,7 +1318,7 @@ rpc_gssd_dummy_populate(struct dentry *root, struct rpc_pipe *pipe_data)
 	q.name = gssd_dummy_clnt_dir[0].name;
 	q.len = strlen(gssd_dummy_clnt_dir[0].name);
 	clnt_dentry = d_hash_and_lookup(gssd_dentry, &q);
-	if (!clnt_dentry) {
+	if (IS_ERR_OR_NULL(clnt_dentry)) {
 		__rpc_depopulate(gssd_dentry, gssd_dummy_clnt_dir, 0, 1);
 		pipe_dentry = ERR_PTR(-ENOENT);
 		goto out;
-- 
2.34.1


