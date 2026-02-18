Return-Path: <linux-nfs+bounces-19028-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UKMFB/r9lWkDYAIAu9opvQ
	(envelope-from <linux-nfs+bounces-19028-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 18 Feb 2026 18:59:22 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 49AE915873C
	for <lists+linux-nfs@lfdr.de>; Wed, 18 Feb 2026 18:59:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 153E1300D61E
	for <lists+linux-nfs@lfdr.de>; Wed, 18 Feb 2026 17:59:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BE43345CB2;
	Wed, 18 Feb 2026 17:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="HI4XyjVw"
X-Original-To: linux-nfs@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11021140.outbound.protection.outlook.com [40.93.194.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 774E730B514
	for <linux-nfs@vger.kernel.org>; Wed, 18 Feb 2026 17:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771437558; cv=fail; b=ubZv7r/MFLQieH5g1WLmI8ZJxD1CscpPxPit65aUZ1HTpHXFU45QdobDPe/w+NvhEVI649Z/AotZyqwgxKGbjcOA3jDD268nDcJKMcLkErjq4Pu/w3S9+ANzN5ZTPQahOhLPh5WpBrKz5098jv9s88gnb0Abfih1y8Or5c8KfW4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771437558; c=relaxed/simple;
	bh=//r9ypATeVFUnTkb05XlzysAM8Sfgd8ub20ELm/gRgc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Pw75fK9XC+x2ny9dS5QFNYgji3y1qSNQ4QKvZGTMmqDJ7cZtlyYc1KA3Y6K80FAPGlQW+/mZaygx7RWTjwFsoArP31wS74ac+wBidkbxuoHH/ssyndtfktvCD3Z2SA1FDvFTpBZlImjjIPGIc+Dcpe3s5diojjRAq+KC8YCZWkI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=HI4XyjVw; arc=fail smtp.client-ip=40.93.194.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X1zE/O2FqECUO6jbeS6hdssyh1owDh420cikTB0jboCrbxZJhQ+zusEckARLfrNNMuAg/pg4QunsEwpU0B/sV5bw3p4tOAzVeF8cx8pNp+EGa41NZTcfdH5rGNQWiggjpPc0IKBtSk2c0g82N1u6tortLRJ2mveaZXCKdyHtVM1u1tBD0bxUg4nAiUKviGjmSjhqrr5Ke3NMU8PHJc/0B3FXlJihC2ccwf831F72SSTlq3/LsjeGbwfBbgGcPGzvxHMs7jncssh2rE/v4Qae467Q+UVHEnOv8BUrhYTZ2TAWY/N9m0OuoxBQPmKo4YRPweMsWlYa/fP6E+SJclU3aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=//r9ypATeVFUnTkb05XlzysAM8Sfgd8ub20ELm/gRgc=;
 b=XMGBjFJ2vJD2V0jdCx4pdBne/OfniEkBkMvzZAH9IU4y4ywUSGxN/Sw6d8qRtHpKuyF1oTcGcYLD62dYILkCfiHZBer6/eP6XhS+Nw5DyTgcfhaYSC9ZYcaQTxP9l37+gvWrinPWlmKKgDpyEeFRhFYtRmmHVzHlI+zNPxiY26Vivch8FRPCYVIZgmYM/Dc4vhGyc7k7fjydrH8eibd89C/BWgwzxvKKktNgouY7JemcFdg90pHHpIx3V9d6Udfie12yGiR2s6MVpascZSTdX0ge2BAPLkWuBgtBkEYozXBMQiMYMlBDFIP1Gii/Mh72MKx61UMMYDR9B2A92pnzlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=//r9ypATeVFUnTkb05XlzysAM8Sfgd8ub20ELm/gRgc=;
 b=HI4XyjVwp5k1X0zpYOjxqiB964n+fej76gO8wE5UX/JzyJe8ksMElKYaPfBSq0SxzPJ2MvSIl0YnHwz+asWkj6NdNeBlXuDYgzdDuN/9TkfiLwNe9fDGgXYY11t/aXr0gFgFVM7uwAd6U/12WRQaRn4fWUe1CKRquj6dqGvhw7g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
Received: from DM8PR13MB5239.namprd13.prod.outlook.com (2603:10b6:5:314::5) by
 MN2PR13MB3774.namprd13.prod.outlook.com (2603:10b6:208:1ed::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.13; Wed, 18 Feb
 2026 17:59:13 +0000
Received: from DM8PR13MB5239.namprd13.prod.outlook.com
 ([fe80::fa6e:7b5:d1ec:92f3]) by DM8PR13MB5239.namprd13.prod.outlook.com
 ([fe80::fa6e:7b5:d1ec:92f3%4]) with mapi id 15.20.9632.010; Wed, 18 Feb 2026
 17:59:13 +0000
From: Benjamin Coddington <bcodding@hammerspace.com>
To: Jeff Layton <jlayton@kernel.org>
Cc: Steve Dickson <steved@redhat.com>, Chuck Lever <chuck.lever@oracle.com>,
 linux-nfs@vger.kernel.org
Subject: Re: [PATCH nfs-utils v2 0/4] nfsdctl: properly handle older kernels
 that don't support min-threads
Date: Wed, 18 Feb 2026 12:59:10 -0500
X-Mailer: MailMate (2.0r6272)
Message-ID: <0F38DF8F-44CB-4F99-8764-17F60C314ADE@hammerspace.com>
In-Reply-To: <20260204-minthreads-v2-0-a7eba34201e9@kernel.org>
References: <20260204-minthreads-v2-0-a7eba34201e9@kernel.org>
Content-Type: text/plain
X-ClientProxiedBy: BYAPR11CA0043.namprd11.prod.outlook.com
 (2603:10b6:a03:80::20) To DM8PR13MB5239.namprd13.prod.outlook.com
 (2603:10b6:5:314::5)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR13MB5239:EE_|MN2PR13MB3774:EE_
X-MS-Office365-Filtering-Correlation-Id: 9cbd9b04-37eb-4edd-77f4-08de6f176ca7
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?AAKULmdX0ZHHZwxrumWugeEM3g9mrNDbShu145n4llPPTPyQayFt58XaR2f2?=
 =?us-ascii?Q?0/hRPmPglYj0q8ayhNXhyVi8pRzZX/u3sfGhunapYYkJnJHdTltk/4z+jrEz?=
 =?us-ascii?Q?bp4aW6pasjEMp/CJ5+bukvaN642aMJA1Eh5wV8zbkj7W+hFcMwAOVqELj1jU?=
 =?us-ascii?Q?YCL3CTarfrAxIdmX1DIGJW2jEBis1T4tdBPPMtS4sJzOxodGo7C0kc+uzdzH?=
 =?us-ascii?Q?sTqCx3eezWqFyBfU9Ta9ob4EaQDBRmm1ejP6fRm+xiva7sFJyVeQjwykORhn?=
 =?us-ascii?Q?JYIBHF7xsZ3GE+UsgclUqGal7UcLkSNY5tkJSnSZctrI8paJAMzizLBxrXNk?=
 =?us-ascii?Q?43kFZ9tkv5mGZmyuYRqZfnazwtgPU2KaA1gOyghqSUZ5xp1cSNUKnZu66T9C?=
 =?us-ascii?Q?hue/BO/0NblncMha4T4pjH3cEQRTo2glsViwRz+7Ntv6cBxh20W/YgQlG6rl?=
 =?us-ascii?Q?NM0MoKVsH+6zha1FYXwO5waxCUWhwkaEegYmxGCU67+zPCNcZVj4PCl6+NF4?=
 =?us-ascii?Q?W+VLd0PXUgayMjLL0VLkabXX0b23TlwWN3w8xj+TKHz9OgO7PukCABVYTWyx?=
 =?us-ascii?Q?aMPlqNiGM/tI9s3yFFiRy+OI840+LOITdiow7hvSuQQ2gqbZ7WCqPvoxZ7d5?=
 =?us-ascii?Q?V7V1/6/iy8e6kjvoPhKf0eiJyw1u2lEaISlc/1X2YxCnAOnXRZOmH+omeYvn?=
 =?us-ascii?Q?jLolgMse+t1r2yOGgdwesniFWfWWHT5J9gC1BAmFpAlypg2PMRWdTiHSsW/3?=
 =?us-ascii?Q?RYH3JKCPghJG40qCmROqkgodBTKqy0xMMj0Ak4ALnyB+x2Vuu4M37oc5dQAN?=
 =?us-ascii?Q?+lCipsEGjt63nyglYNcUF2b+Tgo/yNasajZZRHIpT8qvPXMVdWM5wOLuco+C?=
 =?us-ascii?Q?wevln3XCQrPXXEiPbprFXu0nP+gG3XZBaC7irPauYkVAEFMs5LZM+aLKnlhP?=
 =?us-ascii?Q?azILfZz8ln/83PYTgv/f/cPrp6gVXr0TP6mw1qJDei5VlByEjg0EJsb68SjA?=
 =?us-ascii?Q?bSa84xEeX3vFGoMs2WWOfpOSoZD7LWnMqxWMcflBaqhQ63hgR6sCrAmHzPnz?=
 =?us-ascii?Q?Kl7jZXQqg9ZM7Hym6mKx+kWZMpCMqaswzYpLret/bIWM5XmPSn0zr4nAULph?=
 =?us-ascii?Q?1h2/pPFf9Jek06fQAVRgIDk/2pwOBCGeu9ZATUJkEIGNH+h8UMns+ERiYaan?=
 =?us-ascii?Q?AoUB90wvBZ9h5dl66jkJsJIlwWECExodRAYE4/fuRYvjdUxVuiRCILHxDYEn?=
 =?us-ascii?Q?b1t10+gO/n1ttjlKX4mQO5Zdp3v0uJii+vnRUdvPjb6UtVFMbvQSBO2AIzvn?=
 =?us-ascii?Q?ZAVMhPORET/bjV5Qj3QFFJ+ou5Yfa7nNqzsHx7KeRAUj80bCXXffZ5Sow4XU?=
 =?us-ascii?Q?L6PqH9ZUVGU69I7QpBcydcUpIVzs1CrCelEfmx7iIwRxifOKvN0Wl6XiH7b5?=
 =?us-ascii?Q?2cO7DhloQBIpVFArEnZPx8S+lWG6XbUUMp7ZZQcSj52/fesEaDLzoV4G6GQV?=
 =?us-ascii?Q?bbzJ3H/KdL/fs2No7Uzhh5xWxPgiSMOMewfc2KKUJ/Xx1QIQnDcw5yhMaOoy?=
 =?us-ascii?Q?3MVHpURW5IooSJhRM1M=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR13MB5239.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LaKC8K/Nlmv3g+rTB7UXT1UBG9e2/hYBDOvv2y4UFpayCbQtQWz8v34H/S9H?=
 =?us-ascii?Q?VbeXwGOpayT1qdovBHZlhymLP2N7ngLBgAIkYUiOfNYqBlaQOYEbF7hoWIFs?=
 =?us-ascii?Q?F5xuNf5DMjAftXurVOoNkEaIqROyslXoeHIpyjhv2V7Q6yLgAaW88v+tEZxg?=
 =?us-ascii?Q?N8UVEh2Miv12BUPeB4N98P5ulk6s014bIl5R9ALh5o/A47NfGyCZk2qgihYE?=
 =?us-ascii?Q?NnFs+aTyGmUeLZdIijNOGUJo5G1Q/diBIZMB86roPop9Re9cSx0zurfO8hcm?=
 =?us-ascii?Q?aHDdQqC1lAf898w+sPBcuQuEvIpFwxMpFlsrVwT3W5hz1a8PDNP/GIHNlPfC?=
 =?us-ascii?Q?TFEKlfbQNMzfKBHDoa07qOOgEXJiVJRKz6xVIfeygIaILCgYgVIhfuRkpacV?=
 =?us-ascii?Q?gM0nBCcUvnROCisRFluorhgBxUPSaLPtegJrzMVHFGWUrnWrYxVa79WmLnrM?=
 =?us-ascii?Q?Gg4VZ/2jwTouN4Z0FZds8LjUg6wzjTYI2jk+mURPdQIUCk9h7MGCIYxcCy0h?=
 =?us-ascii?Q?1+1rWR5nZZe3m7Prn3ZPimV9QBRt4Ab5AcKbVFUuRP6tgjmIZ3Z8DVpiz/mL?=
 =?us-ascii?Q?xKVlGfp8BptBUYPsPP6+F4ExTthaleEfeipCrcwknvjH3HtZOz/PP9Agl29z?=
 =?us-ascii?Q?xARW4LPcsUkr6GulSd524S4RbtFRqN3At8olosxpTnMyeTbEGOoax7TXuMzs?=
 =?us-ascii?Q?ui1/xw9vXi8TQx/Y4rghvEThxrHFJuDGq3i9UAloJu/tToepf80m6T6/lDOw?=
 =?us-ascii?Q?xLD3mBRGz0ZKwwD7jYCQR7M9Esje7nN0/HP7uw7NSy7jZbywC3RrQjvIXBIt?=
 =?us-ascii?Q?QeddbZfnuf1Yr86yA1FWpuLgSppRgdAbZsaEL4wyyHkXAZJhx2Ic3hemcgza?=
 =?us-ascii?Q?GBvQ0+u4MpjoGObI//0E/b9+b4TI39IA5TtvHgS4PJw31/Z+LWjihZ0uvE8l?=
 =?us-ascii?Q?R9PbsPNWiU5MqAM4AczYQaBorr0yhbUOcPTk7yAGMc+Bfzf9QAzYEx6HgDDG?=
 =?us-ascii?Q?79uwuMXTyoykYvtLkz6iy5YJHr9ghGgS7hJxVXjdwhqDfgU2G8w8A2e9O5up?=
 =?us-ascii?Q?YVaLSb1FtQkRg19/QJDLptFcgvTuXYa1NUicU8matS6jU70L9ATHgqnv/nmo?=
 =?us-ascii?Q?ZRBKgzY34CZU9KbXYLCB8EdvyTmy3oBOK/zhNXbbhUS5X9axlGgXxsgsjii+?=
 =?us-ascii?Q?Al/3IMAFyicmeh05Hw57HpycwN5SnBqpgiz0yF5StVsckiX5xkAYh2gJkFGH?=
 =?us-ascii?Q?1/aB6u+xhTzhGQ4cM8opwkULF4bhAN7Cc8Kf7Oaz1sXxm3Jo+zWrBLTjdRRT?=
 =?us-ascii?Q?8bFnX/R8nThAv31Hd2ZWT2sRnbsmJiHDwsu1SlsIE/6ppTrbvbbgTDukFbpg?=
 =?us-ascii?Q?vkTOE8zF4j6s9Okbk9UjG2PWwBuhyQj/M4Fd8SIdPtTFGYRqmZeO73Dy+X7e?=
 =?us-ascii?Q?WWH+K7hNytsQ8SKF5YTF93h2raGgbqtK2cWvMlFjjOGIN1QFEqLlEsb8jmyA?=
 =?us-ascii?Q?ErekUudw8Ld2QSz2zJDhtIjnZYfhES60mbFK901xHotdddd2wFXTRPPZIBaj?=
 =?us-ascii?Q?P2fRbpcIpVNrHFnjVUYvbaSLEsnL+af8+I1tzKAsnS5rJAHmdbcnbGZaNevD?=
 =?us-ascii?Q?WVtsoIZsBtPspziD0A8RVRcvtT5sDjislY+O/8rOC9+bTrwlfs0K6maFE/dx?=
 =?us-ascii?Q?25HHybXG42FPPOz3PNw0xkwpmwkVq/B38wixAttB3vqmHspxjtW05p8K0pg6?=
 =?us-ascii?Q?0izg8dZ9mVbOnz5QjOVkoqzoZfyOLtE=3D?=
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cbd9b04-37eb-4edd-77f4-08de6f176ca7
X-MS-Exchange-CrossTenant-AuthSource: DM8PR13MB5239.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2026 17:59:13.2448
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2GHmH0iyYLVWtI+CoYkfqk7cqGFufArcwu6Y18aUJCMXMcP80kYlXIQu6E8pi2RkMIhs/NSJfPD5Hhhbwh9N7vB1pfhPuDXIG6Z1dX8UvPM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR13MB3774
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[hammerspace.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[hammerspace.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-19028-lists,linux-nfs=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[hammerspace.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bcodding@hammerspace.com,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-nfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,hammerspace.com:mid,hammerspace.com:dkim,hammerspace.com:email]
X-Rspamd-Queue-Id: 49AE915873C
X-Rspamd-Action: no action

On 4 Feb 2026, at 11:48, Jeff Layton wrote:

> Ben reported a problem with using new userland with old kernel. If he
> tried to send down a setting that the kernel doesn't support, it returns
> -EINVAL to the call.
>
> This patch series adds a mechanism for nfsdctl to tell what attributes
> are supported by the "threads" command. If can then use that to
> determine whether to pass down the min-threads attribute or report an
> error or warning.
>
> This also removes the dependency on the UAPI headers by properly
> maintaining the private nfsd_netlink.h file.
>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>


I mean to send R-b and T-b on these - because yes, both were done!

Reviewed-by: Benjamin Coddington <bcodding@hammerspace.com>
Tested-by: Benjamin Coddington <bcodding@hammerspace.com>

Ben

