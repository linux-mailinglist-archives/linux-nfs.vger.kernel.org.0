Return-Path: <linux-nfs+bounces-13493-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D436CB1E490
	for <lists+linux-nfs@lfdr.de>; Fri,  8 Aug 2025 10:41:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C76264E358A
	for <lists+linux-nfs@lfdr.de>; Fri,  8 Aug 2025 08:41:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9CAC2641CC;
	Fri,  8 Aug 2025 08:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="p1bDse6D"
X-Original-To: linux-nfs@vger.kernel.org
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11013058.outbound.protection.outlook.com [52.101.127.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC2DC253355;
	Fri,  8 Aug 2025 08:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754642489; cv=fail; b=fSy7xpdX9jWhAlxLtStUxSXh5LLAvz6qV7+4HshOPJDL0OZ5TUZ5nAqX9MOlI+3cPHD+Y8EqB9cRKtslpkd5NL9rzMHKnld3kuImDB2ULZnzedsLYTGXjn94e6oTcGlimE+ziOFkT3YyNxXPofTyiknHlShTb17WJ/mYn8PzPK4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754642489; c=relaxed/simple;
	bh=kUlCvdnJrpqZ96V5irAFdjXwYoRsaiz4Xeef5d75g6A=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=a+qCs6calqyit25uvhPs0Z5/UHdfbuOFbYDh9at74miMlSTRaXjQFWSvz18M4xIFp+nxiQEvwWPVFIio8iWloRhh3rH925U8FYbU1Mmk4nxSYR+ux2VQbB0WpA2VoyIrLpYDm5+EPkLVALXred7s9UdIkDR/uSnm/w+LhO53wBw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=p1bDse6D; arc=fail smtp.client-ip=52.101.127.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sd9x6PJsQUOq2xLIkpEksauJEPNKku1Zt06LIKgL1BhwKh4dP8O5qQ//tYs1AesEJk2lLMzlVPRx8j/GtJlWaQw0qCMFjsPqjWP8yxPGveHHSvVuKKSNTyHhO/YtUxXHpTfYpcHWLrA9rE0m4XN+FLlfRnHWqYV0h8+kkA3K1QfZ+8tLPt1ux/AP4zapySWfij3I7ooORevJTgGYrztohwen9U8/WVb5z/qJXxW1CtSuj6s0Q+dMGdTCyQRfkweYGbAEOZ8BesVglYMBncGh/9E++n18nVS9GxiYr5vjd6UbQU4aqQEEK42DxWVKF06S+yDVy6YjtcEJY2Pje+sgAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kI3RVV8K8KQwAUbCvks1J4HGTajn8fhZk//x49xX3lU=;
 b=rRsiFuLl4NjAmNtCoDCF6PhveD+DbezB7wWNwQ+PDnj5k7JqM5kJ5R2ppYeugvmx0LSIVj7DCeE9ZnsX/DQlhcj2FU8h0pxNIsTEY8jOIzXkyp1Fd24cKwGux3upWhqAjsEUm6pgnVB1kXtDqy2+8nmFbIIUywGiFxhtWU2QeYriF8nCLd/rycveXjEeQ9jRCEFNCf4uobNCxQwA3Ut0LedNw2BzD5CFRYRjUu+fraiQQUL+v2AKDV5shQNCjt8ZFYdLO2ZgOyPQHDHdBV06zN4x3RFYLrZ9R506tzK4y+Net96LOGDYbVQGP4X0oCgJnic4NYWICb6Vr7KqhYSq+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kI3RVV8K8KQwAUbCvks1J4HGTajn8fhZk//x49xX3lU=;
 b=p1bDse6DXZZXwG5EbliZ9nrVy4wCKcooavTe7DQZwfdp08/zbgenJuXThTy635PWjlIxk+xQlsTwY0CwcrarML3psIE5P0tBlY+Bwyh3jGPF5yiR806LSCFka/HhYGLsxTAZQj3vfjAqVRdARVPnLtVRLH3AIJTbcjzPgFpWJtS0ZnqYfg5CjeZsYqHbOjx7WdH5iJo/RFBt7java9VLvnkMlugXjkTdlBhPoTpFLoEZmBPXF4gcTSVLbgokX2XhY2+8Ih25BeGRnGJYt9L7asbRezCvYyO7h9VefJFcikny18D5XSD1Z/x1LnjhPerRfMg3rAhJVVNjbYdoiDbcbA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from KL1PR06MB6020.apcprd06.prod.outlook.com (2603:1096:820:d8::5)
 by SEZPR06MB5608.apcprd06.prod.outlook.com (2603:1096:101:c8::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.18; Fri, 8 Aug
 2025 08:41:22 +0000
Received: from KL1PR06MB6020.apcprd06.prod.outlook.com
 ([fe80::4ec9:a94d:c986:2ceb]) by KL1PR06MB6020.apcprd06.prod.outlook.com
 ([fe80::4ec9:a94d:c986:2ceb%5]) with mapi id 15.20.9009.017; Fri, 8 Aug 2025
 08:41:22 +0000
From: Xichao Zhao <zhao.xichao@vivo.com>
To: trondmy@kernel.org,
	anna@kernel.org
Cc: linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Xichao Zhao <zhao.xichao@vivo.com>
Subject: [PATCH v2] NFSv4: fix "prefered"->"preferred"
Date: Fri,  8 Aug 2025 16:41:03 +0800
Message-Id: <20250808084103.230483-1-zhao.xichao@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0105.apcprd03.prod.outlook.com
 (2603:1096:4:7c::33) To KL1PR06MB6020.apcprd06.prod.outlook.com
 (2603:1096:820:d8::5)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR06MB6020:EE_|SEZPR06MB5608:EE_
X-MS-Office365-Filtering-Correlation-Id: 19533d31-8c2e-4c26-d54b-08ddd6575a77
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YyDXsTluYp7IIgn94v7FZaULbcFvgcWbLQdDkVclzcfoLwIDbQiAjO+KIfI3?=
 =?us-ascii?Q?qCbn6yI68vQoRUGDvxXr28QqmPDHG5Z1M16CDW8w4nwTAoGYMbMSf+ha/9e0?=
 =?us-ascii?Q?otZFP80Sl0GTF88lirKNwhKUb7wMC3JICUgK83ONUveUuTcx4VZjIBstEAhU?=
 =?us-ascii?Q?TWPr4VLrLD8TPqq0/+UU8HW6gGkxliX8RQ1M1MvurFcR1nSeAW9DtIBDTA1D?=
 =?us-ascii?Q?D3TWO0C8Kp+4yPW03R79eTQwjjvYHHAYJWzG4A/xcu1MMupj6MQGHUtmNwm2?=
 =?us-ascii?Q?Ac/scvvcNGMdrhdFKV3cfyQyR1k7LxELHqHogRBnZV4+H54jlJ9Tm25ZOviG?=
 =?us-ascii?Q?6twNJyJRpbwJNwND4q7VpFtRJSNfMg+wnHERYJmOqGCKDU6FmuR5yTBaqHFj?=
 =?us-ascii?Q?S/gm4weMlCjymjPru7kfRK2an78ZiWxZvfjycBKuTUtp6bgToRS9GhAVtKlT?=
 =?us-ascii?Q?jZ2GK5hHxzv4Cu9KtpskZq6TXrZ3obQU4kfDrlD4hX322vT9/xfhn2p9errr?=
 =?us-ascii?Q?OmSuRoJYt2Jne8AegYAjXpRx54Z3+/sZ+3TtI7grsXkz41VxKp1o6bfCZ1//?=
 =?us-ascii?Q?ZPk1E8/GvG3E7G+kHVTqMxMoajtHIFw72E5Uxvpok51BcdXp9rElSwX3LzHq?=
 =?us-ascii?Q?xmWZrv8oSzamX/Paaq7IF41eNf2rgWM8wPNNT6R7BCWDZJNgGT/+JB5FiHrp?=
 =?us-ascii?Q?wmy/Bi7iQUcNvcZkk/J5LfKvzJdrpz5viFTfMyIabiOwXzBz4rA6PK/4n7G6?=
 =?us-ascii?Q?KimVrM9+5KXnqMZS0xVNpQIYyrsFeTAmjI+gJJO4G+EBFsjKT8fQQyPJPQrm?=
 =?us-ascii?Q?ZA08fn4iBCrm9z7fUjaHQ54ueFqLsGNBNLGM3bCu6Nq+ZdPxbr8zUQJDz1j0?=
 =?us-ascii?Q?7AuyPjN7btNRFkRWywP9XXbiz0/h1QuW1JOe1cPnhpABCFxSy88CZi27wMjz?=
 =?us-ascii?Q?+TY16NqNSxgOvl1YDxsPd/T8YZLXeWAoRD0HHBW7If3eesGP47XR3eltP5Jl?=
 =?us-ascii?Q?TCqr7O2zguakik+xDbGZduP3j0bSZPqd8rLIRUkTfrSz1G/ID/Dmhj6va7Mt?=
 =?us-ascii?Q?dHHklnMnkmXHv/w1cPdZOxePRRNMHvOp8qAJaV6ppSDsJfkDNOkR9NJ3nj30?=
 =?us-ascii?Q?m3/Mw7gIJ7ZOG+jm6M9h02hnugUSnIg0MXaBowJ6YAhSEzkl2k8eL9G5fi4u?=
 =?us-ascii?Q?y1p2P6WVF9E/G5DXnmHDVqRoBwWX/9lPUrZuyRhkve6cJwzNqzWg/TgpSk6X?=
 =?us-ascii?Q?DHsmlOh9kKH66yCYKwtNMAGHRImrv3y3Ac+rzltq2uwtuO1q9XaV9rnvyUcd?=
 =?us-ascii?Q?P54YAhf68QrzJxLM0ddpVFYWzoQrDWHi2KFQVwmgkVdNUUIJv/SMRRw9AjyN?=
 =?us-ascii?Q?z2gX/5YOFPOY9CQmAeHoyvOGOkCMt9Y1UEw99cXQvz4XYh/9Pw1ykBYcorRl?=
 =?us-ascii?Q?hvyx0ArUsAvrveTNzfxUh3AsxKzyIwv7mjHP/ceueYynNk3c17roFw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR06MB6020.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?e7+cv5E2chi2u9CuF4BSldz6CHziF6w8ukf8GuNJfKM9xqcOxhCriQIVfdF7?=
 =?us-ascii?Q?OPegvOdQKAovqeYGE/U8uH+3+2ahBY6N/jRuvoNjIH4hN2oyMo5KB7GPdlW1?=
 =?us-ascii?Q?1WFCbeAWdz6wKIlVEqBMiy9P57T+pPCeDqMKuhaNw9dYZ6n8Yku9Tc7TVsAd?=
 =?us-ascii?Q?BZWDwVCl/qa29KaJCnH6EXjHN5kkuYcyII8Afmg6PRpjWhupTbHoJQ/LIZs1?=
 =?us-ascii?Q?9PRY3ltHV7WFOjDQdllU7Jt4HK2ayIkuHMyDr9CB1/uY+HQAWumyvmO5W9id?=
 =?us-ascii?Q?Mu597uZTvxELfUCuuGTuo7NdFlCs44neW630kvdriAlGIFYTyAXmA3n/N3s0?=
 =?us-ascii?Q?jwvVwnchRUMRc6uQov26639jROE/dIGqlWV2GMWKSQFGiPF8sj6FvBVG6ZCf?=
 =?us-ascii?Q?/IeoZ/bDsXVTV0TqdLnB/f1B7GSelE8bSVj3QeS2+l42SGM8a5xqUQ5SwwTf?=
 =?us-ascii?Q?Ky3F6zxftO2omy4UVeKbZCOq5uPtbYRpWYeOi8TAmhleR5735ODpVTmIle+Q?=
 =?us-ascii?Q?xxIDjwpQ8EwSIkgwG/9dLqlycrhvejbUk57bm4rbJ9BPk0wO50mXtB9PXhDO?=
 =?us-ascii?Q?7CZjldflj46mV9Ilg4RW7lt8OauzjvUff5Gy/j+HzR7r+56hsrUnIRMrys6+?=
 =?us-ascii?Q?vzCIYn+qUINUrHkghGsH6V1K7nXZBEGQvz6T56BUil8luiDh6THoIsBB6jnq?=
 =?us-ascii?Q?LGHTfHW4kfSEV4GZ63y3lxyqIw/EzA91TfjnMY+BY+yAQ4QBZ1jZeF/XyQUj?=
 =?us-ascii?Q?87kYIrhas1Lb1FanLC7Ws+BYhFTIITF4ragX2YrIkTRaaslLnlGPzHw6/APR?=
 =?us-ascii?Q?3EGhKmXmhMui1zERfyLvrZaLIJw9W647nUXa9fstvVrYXXKi/wfCt1PMyg8u?=
 =?us-ascii?Q?yF2OJiwVtuwPoAXqPCp8+BPaboPqbcUACerZR4tvN+LsIs7GYGRFYL08W1SS?=
 =?us-ascii?Q?D+gLSFBHS7DwqQTwdsKeFQONWn03HBSN0O9seaP1YRHa0245EprS72b5qRfA?=
 =?us-ascii?Q?RIabAI9gJnJdL7KthRQgWh912NsVOeijK+zwNTyPVUp9Y7ZDT68awSSYfpQ/?=
 =?us-ascii?Q?ZYnpj7NgkzNM3iOsh+r+JulcibW+raEg43z9Oc9hEmxv5n//lv5koVVk5mf4?=
 =?us-ascii?Q?lcjtqHNzAlZIAs5DfX7LU185NbhCYT+AIwRI6QkjVXkMWFFidee1RkEq6HuH?=
 =?us-ascii?Q?mqAfDeUx5iPHGm7J8fjxC/1wEt2giDZoxKh0WkYBuPddb7Za8zjBQbQGl45V?=
 =?us-ascii?Q?TVzmdhJsqczxe/QkCGsRoUFaYNHbgBxx5TMbrPX1w0vAhhqHxq81OKaRq3WM?=
 =?us-ascii?Q?K6zugTpn8gDn8Ue4uyvpPZ1JwWXOGLTjkVFKD2HFn8y7Qk6F3P/eOz4wVI1m?=
 =?us-ascii?Q?W9HaZppVVZzyS0ODWuSAGe78I6CHCGeM6Jr9e7m8iRJqAp7aD+BpolUjxeF5?=
 =?us-ascii?Q?SBqKwkgbGsgZNX5z8+QkidwvJo5TKXvJzURrKc6aKuIFcptK0mEj1EiLaHsP?=
 =?us-ascii?Q?Rt9xMf8xBFNpoVRKKezHnNBeR1QzozTk0olmqaMD1slggSFmE9r6bqWAMGUs?=
 =?us-ascii?Q?9JEwGh0j8i4Q+8hEe703FIp6b4oXbnuQUtt5N4p0?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19533d31-8c2e-4c26-d54b-08ddd6575a77
X-MS-Exchange-CrossTenant-AuthSource: KL1PR06MB6020.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2025 08:41:22.7333
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z/mYYSr9U1fKAkdo5sOg4bI0isYdRSKOZQSxOX7r7ZXq58JTGYEnwya4FJ5PP0XgABFnwCk9sD9xwlRt0PQCeg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5608

Trivial fix to spelling mistake in comment text.

Signed-off-by: Xichao Zhao <zhao.xichao@vivo.com>
---
 fs/nfs/nfs4xdr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfs/nfs4xdr.c b/fs/nfs/nfs4xdr.c
index 49ff98571fa5..4ee88a4c1daa 100644
--- a/fs/nfs/nfs4xdr.c
+++ b/fs/nfs/nfs4xdr.c
@@ -4930,7 +4930,7 @@ static int decode_attr_pnfstype(struct xdr_stream *xdr, uint32_t *bitmap,
 }
 
 /*
- * The prefered block size for layout directed io
+ * The preferred block size for layout directed io
  */
 static int decode_attr_layout_blksize(struct xdr_stream *xdr, uint32_t *bitmap,
 				      uint32_t *res)
-- 
2.34.1


