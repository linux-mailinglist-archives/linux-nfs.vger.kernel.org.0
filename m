Return-Path: <linux-nfs+bounces-18784-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iHAhLEoGhmkRJQQAu9opvQ
	(envelope-from <linux-nfs+bounces-18784-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 06 Feb 2026 16:18:34 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 31414FFA12
	for <lists+linux-nfs@lfdr.de>; Fri, 06 Feb 2026 16:18:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D78733022911
	for <lists+linux-nfs@lfdr.de>; Fri,  6 Feb 2026 15:15:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D5AE33D6CA;
	Fri,  6 Feb 2026 15:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="AjeXuzpM"
X-Original-To: linux-nfs@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11021092.outbound.protection.outlook.com [40.93.194.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE18E2E541E
	for <linux-nfs@vger.kernel.org>; Fri,  6 Feb 2026 15:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.92
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770390910; cv=fail; b=tUxMQyGnlnuQexcdTzjKAH/2fk8jyMnc/iJMQBOtAG1m1HguPTIOr3FxAwsXiKuxWfvH7ZAfxP1Z6fI64VGq5ju+VSWyMPDbg86SntUJ4Z1BhG+MtwGwGsIZVbvEGfp0HWugpAjdjCIAuRZZD74cZ59NtVczUB4jlFeIneNasmA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770390910; c=relaxed/simple;
	bh=vYJczDu3hSTJ68zWxFh954OjTPm8Aq1QARbeUmZJA6Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kiasv20P+ZbVDIlPVwAk5+ane+Y4IpTeqycAm/XD6LrCU6rxSaxkjyr7vSY2kENX4m7DPxEshe63+m3Zu3qrUunzi4Vjr1ZjWxAYlBhg9KfMeUSQ3XhisqYMWH6vVNFPq3SSIRdPQ0mBoDI1Ciu1PRssW+wXt+PUu3KyoR66BRk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=AjeXuzpM; arc=fail smtp.client-ip=40.93.194.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=omq5dIMmwHuc00mUexCTfle6DXEYy3SUV78FyNPM8DA5/37zSn7dN6H6awx5k13WLReVaJlYNLJ6FxVLrT+sEJrbfKMlQU7UCDSWnND+9JQ2nk091G5vdhQXIB4+KlVBhLwKUGtjKihnygiGSWgGPYNUaqtJxHCko9vRY10TAuGnMZfP7XdVmWYIVneYgioj9+uoc9S/iV21HPBvW+Fy9xhUPqCANLVvdp/QaNDj/CVcC+zjqKrZNRHllqs+Cb1DV0VMhoEv1Y0GyrKulFFfxXeu42+w35HlgbeHbq+trkzYray1Ko5Xz80tNsvAD1TFPGob+QevFXoDNtORTlxM+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PA1uz/IefmzBtVP1E6nX3poEXFXJIX5Qq3adoOdxPOE=;
 b=IkTVMfo2TRGyDiRfC1668TZkmJZuy6IsbEiAiUfoaGrFtc8DsQQjvuZjVnxFdAEFq4IyEeevEO4bsOJQReVvgAH2kiNWtt7NUO7WFsFefxUYZu7obe63e4+QjB0Ono66o3beZahuqSCiwlyRiD4RYnH3UahnMgs77HxqxV5Z+oB55Ttr2xhwcil0pgFGTagMYM6IWJJKTJQG6eAZDsqn71EmLZcWeMkozID25U3SKPA8Ac+BHv4p+E2/JB+JGcNxIybkg7jOQsO0mnykRykC8J2hcX+9UhGgkLU0tLZSABjJ3ZxDrLbIb+S5mUDVOPL455bw6ysQZo9HXXiZ3y68YQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PA1uz/IefmzBtVP1E6nX3poEXFXJIX5Qq3adoOdxPOE=;
 b=AjeXuzpMsXq6qaZjf3jF25FK1HVpso6V9mYqOLSgO3iYFzz0w50vBhbxlQ3WmSxhSS+/waXoBUM2+6Yg4ygNH1oklb2gGNyC6mH2ff0baTjPLF0VtDN5XvhKlf0vzh5vkZG1ZLnDZazS42xy/0sb/Q2NDGicLcEAuI1JTgyP5/s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
Received: from DM8PR13MB5239.namprd13.prod.outlook.com (2603:10b6:5:314::5) by
 SA6PR13MB6879.namprd13.prod.outlook.com (2603:10b6:806:40e::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.16; Fri, 6 Feb 2026 15:15:08 +0000
Received: from DM8PR13MB5239.namprd13.prod.outlook.com
 ([fe80::fa6e:7b5:d1ec:92f3]) by DM8PR13MB5239.namprd13.prod.outlook.com
 ([fe80::fa6e:7b5:d1ec:92f3%4]) with mapi id 15.20.9564.016; Fri, 6 Feb 2026
 15:15:08 +0000
From: Benjamin Coddington <bcodding@hammerspace.com>
To: Steve Dickson <steved@redhat.com>,
	Benjamin Coddington <bcodding@hammerspace.com>
Cc: linux-nfs@vger.kernel.org,
	Chuck Lever <chuck.lever@oracle.com>,
	NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>
Subject: [PATCH v4 2/2] nfsdctl/rpc.nfsd: Add support for passing encrypted filehandle key
Date: Fri,  6 Feb 2026 10:15:01 -0500
Message-ID: <733f98f0464b882574cfb58a7b108e270b843372.1770390642.git.bcodding@hammerspace.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1770390642.git.bcodding@hammerspace.com>
References: <cover.1770390642.git.bcodding@hammerspace.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH8P220CA0051.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:2d9::34) To DM8PR13MB5239.namprd13.prod.outlook.com
 (2603:10b6:5:314::5)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR13MB5239:EE_|SA6PR13MB6879:EE_
X-MS-Office365-Filtering-Correlation-Id: faa3be79-8a3e-4edb-a98a-08de659283c3
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7142099003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+7q20Vr+HiX6iKKcAt9w7ncoNG9zD8uMjDfGBucrSm16mmS117eQ3RvWOB7g?=
 =?us-ascii?Q?/AG0k6WtldXGERD97HRyrUHhWTldYvs/pxWhDGK8fqkZRbsyzoAgTShxI01Y?=
 =?us-ascii?Q?/SeARBQ1URyQHwj8HGHTQlxrFRmh7F+rGRnTlm0Vd/tcTpGJ7ftvOL34YJ3V?=
 =?us-ascii?Q?TJ4FGkeYFfbARbJZjvjP0uLKyHclLpZ8rI+BUu/iS97T0M1z3U/yGdDDkAWK?=
 =?us-ascii?Q?kMA5iPNbqwv+1VoNJpIgo1+3XUzQCjW2zt79Ebb0lqs9DdQoDqhCmDOarXzm?=
 =?us-ascii?Q?p3W9wBHIzMsxgsDeC4PupnOYbqZxPX4aaBKDoDHzssBqihf9ertBlWM7iGVx?=
 =?us-ascii?Q?kXZS5TUxOXz/5IE/F8TDRS7eO3Brdc6OL04E6/JEN4Bc9tpJRyYDlhbuFbj5?=
 =?us-ascii?Q?xm3C/ugw37H9PitGvmLFmanksggm2w/C8MkiW39RPyoDKQUO24wBhe1+9QvZ?=
 =?us-ascii?Q?l/ecJju5K1ZIDfO35oCj0kltdLLffLKpq+s+4re7HeTnOGjXMLM/VdnbMeY5?=
 =?us-ascii?Q?maEmM1WcTp2OkZvk+HPI/g1fkpQCG49bQAZMjCWNWhgugdzFsD32BxXZYp02?=
 =?us-ascii?Q?ixyoKFKFRzn7LPz7RD9gQ909EWiY+J1FHUHnpHzdIa3oTVK6xT3F2BYs17bT?=
 =?us-ascii?Q?VR4vVrFjC0GnHQxmSMP57i3E+WzpmJbw9fxnmcGuWRGJH47FNv0QEvpPGSoZ?=
 =?us-ascii?Q?/u15fDPgzy1FtczZtKI0hf7JBZwJX9n58RZV5kYkMcF1z01+4Mji9iXYuaUE?=
 =?us-ascii?Q?w6lZ7ZBjbxDzsv3zfMNoCigkjrLliTAGTJoAIAG/6jbRyXKiUbpqZFxIRXwQ?=
 =?us-ascii?Q?rCt1cUXOcffLPXU7wiNbwktwDA2PgzN4OH6Toki3e6cDw0neTsUWzFiXAYP8?=
 =?us-ascii?Q?bDW0YkiBvFHNCl9QfCXSWbfOl2f2UtZ+p4KiVlCeseX/S7xPe2kqT+Hxo3aP?=
 =?us-ascii?Q?6ufMkB0hjUT1lm891wgavKNd/iaYwKyyep7JpIGCIj3q3NrR3GiSSB3XSq58?=
 =?us-ascii?Q?SGInEnSEN9IDZaqG4zA3NcVtqvKS3ogZXJBvlHK2pIVGdGlqYapbkH68WfAJ?=
 =?us-ascii?Q?AOc6Z+o3V3gzzxuRJ3IAmnPMJZ5tKXfe89lPR1DJCQUqJQr2eQLphpohtJS0?=
 =?us-ascii?Q?CvhocJLflXGYFGTm0DRJPWiAGAlGODdoFA/NQjk7KDry4twLEfpBCAdq9Q5i?=
 =?us-ascii?Q?o6qe7waKsm1BRiZHviArSLlGkb1PbZN3S+ceHPZy1kRygnfR7g+kXTGS8lED?=
 =?us-ascii?Q?+gAXkqdHkLvN0iVTaLcHE9z8wBtRwACh3lhlag+G34LZgFtdACU1Tw+/8buY?=
 =?us-ascii?Q?ePfRbt9f+m6mim48zgNFICn/XXYi76NwYt4UtFqSaJbq/uygOjpSv0oQX07M?=
 =?us-ascii?Q?JSdnAOSpMeOwtXMy3jVCJ6FRuXvdC8FgVvbF7sZ4xP4oNsyZWwsWKD/fbfSH?=
 =?us-ascii?Q?Q/C0cxh2Cts97Rv4hvZwVlmjC2EPDCR7pQSgdDS+ewy5fAxNYpOMgzgdTg9B?=
 =?us-ascii?Q?Y4rRnYNpnAXooy4VMaiaANJIcImZKCxByObMAHnmppsbvgpXvat5RhQ7oEo5?=
 =?us-ascii?Q?81zJPz43xabW4I0OxrE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR13MB5239.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7142099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8GbwWIK+b2S8vXTv7yTF0NYYqNmpa0pcRnVW2xUEYNbLLtenFVbVu3aP6xfv?=
 =?us-ascii?Q?38yDQdvbRNO14lHTqdGGWy38tlSUE44Yu64Yh7OTJ4m3lzi8cxM2tFr6W6xm?=
 =?us-ascii?Q?TAz59UKiPMo3hW2tuIGSGGTrdh9mR1GduvFo+gkbCArUTQvi/ooJhaZIMH6v?=
 =?us-ascii?Q?DBREb4k7+Lc86NRYkbclOgaF0/FRdSkzDBOcoCBdKFndxs8dJRwxQORpPrOJ?=
 =?us-ascii?Q?gQcDKq0qBc7ZyU+FxJkt30uXYay80C3JKDKDBTVlyfJ4QUaqvZN13SisVUDw?=
 =?us-ascii?Q?t/aZukjWJsRxn9jIhDpVjqGWqpLZmM8lg8ByoUVtEcnULS5RbaAbAHCrTBhv?=
 =?us-ascii?Q?DwOBGmCZamJDYOxxLPk5qPolDFUNTb+mMHhIkdOMxzGPyO0ieTL8+2caSAuv?=
 =?us-ascii?Q?iP4+LRFbYzKFkfhixC6frY9bTKTtX6TWAmj32kOVa5DtowBFE7kj7NmG+4+9?=
 =?us-ascii?Q?HLGI2rc0iBy5ixl1IPAaTH34AAsjX6HffOzVC9+pM3aumN31mb0fEymya/Z0?=
 =?us-ascii?Q?Cf3qrqy/ffgFaMIJr9IB89RqMEOA0OG+g1xCGIpFSBeZqxOH+uyx9ui+JZgj?=
 =?us-ascii?Q?08dpgLreAmsUaSN3qflOR15lN05Y8FvOs5VZEzG+GvZIxDK+FVBWslZkEqW2?=
 =?us-ascii?Q?CD6mGVEeGd9KW3SiZ59WwxeHK1qfXZrM3zGUwPRSxhCj9pVdzwCSjaqFLTxv?=
 =?us-ascii?Q?f4pY+tXIyhbyfNdneDIEA0ryUSadHc/+EvOz2tpaGXk+DRc53buWBIsd8lCz?=
 =?us-ascii?Q?MfVaclqvdE2qbhL0F87bhOCrEdpovDGjTx4xAX9kF8DF22l+D/4EkQApXWIX?=
 =?us-ascii?Q?9oXLjLpmB2hp7EAWA4UAMEBm8Jg+ljLTD/i+hw8KRa6bpvIEswSkMxo0ILK4?=
 =?us-ascii?Q?No2mSNCkNR89TvYpNVmaQFSizeZVPrcA8WNEVwN7NLj8FFFJdfXLCAbbHg75?=
 =?us-ascii?Q?k4NU6P89KT7Ubd8O/Ii1RGoJ5zUBm2/3mxZz8Vr9gYIH10GsOItg+BQHOiLB?=
 =?us-ascii?Q?f47MaAXVDbSNkd9SaachB+vERhLp+CYBbGtVJV27t77zgX+XHsA6mjyP6lcy?=
 =?us-ascii?Q?M3iWPWvul/FbYRdFM9cJhW4eCi9sY0SQzudSwIx/CveNowrIjaO62xNycLrJ?=
 =?us-ascii?Q?Yvc3m1/bloBN8bXD6S+suBe8vzALuMKz2brUuW+CadJOKdgsW8/cmT1mkeyn?=
 =?us-ascii?Q?YrTzfb1JftjQxct8TY5woNkYIzw8aWEAxXVCxJPokQb3ETnlzGiYph2gXUt2?=
 =?us-ascii?Q?D96aPULkuFLSlVFi3gkCqJoJCcWwQ0nrexbyQySpsNcVjD0eiaTC304eSeHY?=
 =?us-ascii?Q?iT4MUVJRCxd0vxj/RV8dO3ULS6scJAn3DrdqA/lMNuMVx8ASmLCvIMWO9QvJ?=
 =?us-ascii?Q?dPkz84d5UxuEjTQTyrRXWDMenLnLhRR8amT0yMkKcW0xiJObv7PUwhHM1MT6?=
 =?us-ascii?Q?EHvNKXvT6k8Q5nZqPsJJOykCLpR0xCGgDOvc4KAt/egqQlNTeK5wPw31UtPO?=
 =?us-ascii?Q?AsEf63XXRdf8yeqkJQQg7+NhBlY2NTGGOHe5rzOuqxjrqH+1/kxKjWkjQPsZ?=
 =?us-ascii?Q?A0Yc6TMCbLzVhpMLOk9WctGq2Ez5EueYQBkh30TiecDuda/z31NzBbAxnXVr?=
 =?us-ascii?Q?lqnKfJQNgd3Ap8VjfOjYF8RHd3UyYLJ5BAdJEjv7RdWdXrv3XHNVLMZEiSCH?=
 =?us-ascii?Q?WnYXQwNacQaYf6Xdylm5mFNZ9/9hAtXpbYiKXaDU5/Fc9Bm4wCoAGypneWUY?=
 =?us-ascii?Q?oNVdOA/RWcTFrpCvKPokyiY/jKModqE=3D?=
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: faa3be79-8a3e-4edb-a98a-08de659283c3
X-MS-Exchange-CrossTenant-AuthSource: DM8PR13MB5239.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2026 15:15:08.6062
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z5iBg0nKMQ/iDMCPOpoVXXTq6evFyGvj9y+oxC9hvju3ZOu5UXpQ13UxVPKFWZNkk3MzeGYMg1dpriE/9eF/ngor3vKNvEJDqJZt4r9Ed58=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR13MB6879
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[hammerspace.com,none];
	R_DKIM_ALLOW(-0.20)[hammerspace.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18784-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bcodding@hammerspace.com,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[hammerspace.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-nfs];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[hammerspace.com:email,hammerspace.com:dkim,hammerspace.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,libnfsconf.la:url]
X-Rspamd-Queue-Id: 31414FFA12
X-Rspamd-Action: no action

If fh-key-file=<path> is set in the nfsd section of nfs.conf, the "nfsdctl
autostart" command will hash the contents of the file with libuuid's
uuid_generate_sha1 and send the first 16 bytes into the kernel on
NFSD_A_SERVER_FH_KEY.

A compatible kernel can use this key to sign filehandles.

Signed-off-by: Benjamin Coddington <bcodding@hammerspace.com>
---
 nfs.conf                     |  1 +
 support/include/nfslib.h     |  2 +
 support/nfs/Makefile.am      |  4 +-
 support/nfs/fh_key_file.c    | 79 ++++++++++++++++++++++++++++++++++++
 systemd/nfs.conf.man         |  1 +
 utils/nfsd/nfssvc.h          |  1 +
 utils/nfsdctl/nfsd_netlink.h |  1 +
 utils/nfsdctl/nfsdctl.c      | 39 ++++++++++++++++--
 8 files changed, 122 insertions(+), 6 deletions(-)
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
diff --git a/utils/nfsdctl/nfsdctl.c b/utils/nfsdctl/nfsdctl.c
index 6a20d180a81e..2369a8495954 100644
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
@@ -697,6 +714,8 @@ static int threads_doit(struct nl_sock *sock, int cmd, int grace, int lease,
 out_cb:
 	nl_cb_put(cb);
 out:
+	if (fh_key_data)
+		nl_data_free(fh_key_data);
 	nlmsg_free(msg);
 	return ret;
 }
@@ -721,6 +740,7 @@ static int threads_func(struct nl_sock *sock, int argc, char **argv)
 	int *pool_threads = NULL;
 	int minthreads = -1;
 	int opt, pools = 0;
+	uuid_t fh_key;
 
 	optind = 1;
 	while ((opt = getopt_long(argc, argv, "hm:", threads_options, NULL)) != -1) {
@@ -768,7 +788,9 @@ static int threads_func(struct nl_sock *sock, int argc, char **argv)
 			}
 		}
 	}
-	return threads_doit(sock, cmd, 0, 0, pools, pool_threads, NULL, minthreads);
+	uuid_clear(fh_key);
+	return threads_doit(sock, cmd, 0, 0, pools, pool_threads, NULL,
+				minthreads, fh_key);
 }
 
 /*
@@ -1760,8 +1782,9 @@ static int autostart_func(struct nl_sock *sock, int argc, char ** argv)
 	int *threads, grace, lease, idx, ret, opt, pools, minthreads;
 	struct conf_list *thread_str;
 	struct conf_list_node *n;
-	char *scope, *pool_mode;
+	char *scope, *pool_mode, *fh_key_file;
 	bool failed_listeners = false;
+	uuid_t fh_key;
 
 	optind = 1;
 	while ((opt = getopt_long(argc, argv, "h", help_only_options, NULL)) != -1) {
@@ -1836,6 +1859,14 @@ static int autostart_func(struct nl_sock *sock, int argc, char ** argv)
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
@@ -1846,7 +1877,7 @@ static int autostart_func(struct nl_sock *sock, int argc, char ** argv)
 	}
 
 	ret = threads_doit(sock, NFSD_CMD_THREADS_SET, grace, lease, pools,
-			   threads, scope, minthreads);
+			   threads, scope, minthreads, fh_key);
 out:
 	free(threads);
 	return ret;
-- 
2.50.1


