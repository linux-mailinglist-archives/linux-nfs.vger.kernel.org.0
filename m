Return-Path: <linux-nfs+bounces-15931-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 02B6BC2D158
	for <lists+linux-nfs@lfdr.de>; Mon, 03 Nov 2025 17:22:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D83184273DF
	for <lists+linux-nfs@lfdr.de>; Mon,  3 Nov 2025 15:53:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3B90236435;
	Mon,  3 Nov 2025 15:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="Z79kfet9"
X-Original-To: linux-nfs@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11021074.outbound.protection.outlook.com [40.93.194.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9F84304969
	for <linux-nfs@vger.kernel.org>; Mon,  3 Nov 2025 15:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762185228; cv=fail; b=K6SU5HtoWz7jsS32oYgR1xasZ8+ShVw/XaoQT2ZP0SKQ0izxauWc2pcZrlIi5eLkQPT07szMZf8k3ImVTjzjPfYHQ7Gi1Q3mLGpakcg0hv0BK0F1s965mU+QRz7HB4ijeJIOch/+dbyvnQcOV2PeO5MWAjm0PuRwNz7e7uMgB7U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762185228; c=relaxed/simple;
	bh=cIia7yjBzBjJBr4Y1GjqNWx4/7yvEhL+N1T4H2CIprk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GmTHhZvIpIoQYC2n+4JvTsZ3GOjibPvywQBlVc6Jhg7OEcGlo2/YXMLSodqWstrKpkC3PoJ25QXZsE2spKdQLUJkGfxKrIu2xYOMZhbVUMu66uiBkYeQ1AXhJYohpOVmkN+YvsUJXH6rOwFVNM/X3tN1cKAqjcDvKfkpSHu7c+s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=Z79kfet9; arc=fail smtp.client-ip=40.93.194.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mhU76VKloYh1r59HhpqX03JdgE8Ww4XRXkO66ciqjG7XhQ7aX/1E8SvO8JQii/sW5SmYSx9/2svoJHPR+DpTmmYs9IrLiK9gKLT7dsbElD0wIRGsa/jwAqVwcZuk9/FLglFhvtgAcy0cxZVhfFeoNRSJNCaPDH5eHriLFkSjEkNdX4xjMu5+CoyP86gs42BPCf0uM7I1Um3TReKRftj/pwsJ7D10bvK+ABOAsnSUQhiVFSAvDjZemshpIR6/TrgT8CwjraK7U+iHLb1xx7LHR9Jy9mwzDg4SSoAMTpLSsZlxCRfrss7UMg2QqJdQiMDEz6dLc+r79D8ngqqnSwg1xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vNmLQB3aLbHBYxEw54g9+paXxkXsDpRX7uyhRk6kCsE=;
 b=QeVlXfdjfJ4Y5GnxLs9+x272X1zegNBpG0fLu5yYWb0Ni6vcSKNYwLdYtNQQV6kSohdDkQG8QiMe153Ey6I3daze2aGzHMb+1aBggv9icTMgLJpTQcUaOfYE6XKsLV3dgvWTFn5tPYwfd1qEdrsRZb/JLbRpqFJopyk8Hm16AUA32I+EPrupsOvvGMEh7Ynvv9U3hZoHHiDe3vxX/QWEDck6Sai9pz5wUGmW030lLGlhajv8FJwhbVJkhDhBfHL+4VS2hsq+4FtL8wo3jJNstqrSoY8TY9QcYVwNhd7cr4XexCh3/crWJuACqPaYqbFc0zt7JGpPPlih5uBTHSClqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vNmLQB3aLbHBYxEw54g9+paXxkXsDpRX7uyhRk6kCsE=;
 b=Z79kfet98WJ3fzo2kIY9OgeyqqA7ToD7UT+rQ4X4EiikeTaLPLJdeurscjgtpbNNuqCWnQaoMWhnZhjY10H1fhIMxWJmc+tKFGl9DgbBBNO55R14f/1aqHn+dg8i3d9djNdsDp1UznbSyfpZ7Q5kTRVYH+XZ6CMOiNu6KrRROfA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
Received: from PH7PR13MB6217.namprd13.prod.outlook.com (2603:10b6:510:249::12)
 by DM8PR13MB5158.namprd13.prod.outlook.com (2603:10b6:8:4::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.16; Mon, 3 Nov 2025 15:53:42 +0000
Received: from PH7PR13MB6217.namprd13.prod.outlook.com
 ([fe80::9a18:22fa:f07c:4eb3]) by PH7PR13MB6217.namprd13.prod.outlook.com
 ([fe80::9a18:22fa:f07c:4eb3%4]) with mapi id 15.20.9275.015; Mon, 3 Nov 2025
 15:53:42 +0000
From: Benjamin Coddington <bcodding@hammerspace.com>
To: Scott Mayhew <smayhew@redhat.com>
Cc: trondmy@kernel.org, anna@kernel.org, linux-nfs@vger.kernel.org
Subject: Re: [PATCH v2] NFSv4: ensure the open stateid seqid doesn't go
 backwards
Date: Mon, 03 Nov 2025 10:53:39 -0500
X-Mailer: MailMate (2.0r6272)
Message-ID: <9775727D-7BB6-4F2E-95D0-5F02033B8ABC@hammerspace.com>
In-Reply-To: <20251103154415.1776520-1-smayhew@redhat.com>
References: <20251103154415.1776520-1-smayhew@redhat.com>
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0173.namprd05.prod.outlook.com
 (2603:10b6:a03:339::28) To PH7PR13MB6217.namprd13.prod.outlook.com
 (2603:10b6:510:249::12)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR13MB6217:EE_|DM8PR13MB5158:EE_
X-MS-Office365-Filtering-Correlation-Id: f5eac64f-cdd9-4286-ca80-08de1af12989
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wAgDKnDKk6VykODJUpdWS7vqB3dXi9yeRvLJe6KhXVqJC3uxGAszz16f37C3?=
 =?us-ascii?Q?rVEle4vhQm8Ol5vDIyJtKKRiY1yc1297DfeUstkRtoTnubWpSBXVPCnd8HmU?=
 =?us-ascii?Q?uJU4HiViHLRh4MwQITKf4JoOfCNcX+06rGBNoapgnzRSLf6I4Z9Vx/ZiOlBc?=
 =?us-ascii?Q?76cIm01/MzAdu9RKxZHZYm7evHMp+yFVDugBhzA9tLNyBSYIGIswSR0m23ZW?=
 =?us-ascii?Q?DZXWdjsMxgjnYeDCxe16Nn+9w1dPbxhQ/JjUzuogVidBRSTSmme9fEem+2Ny?=
 =?us-ascii?Q?ZfaT8UrRPLpwfvkjpKMsigppVhkjO0ARM86nxRGrMu+odR1pLRRvrQaAWpmC?=
 =?us-ascii?Q?+HZ4ptBbDaQ5BBtqPQBVUgm83n8uBaUl9adduDHlnsVF7tYjeqCDAf9Tj76e?=
 =?us-ascii?Q?7V2N2ap2iB6KWvUjBDha+stVktnhSZo4Sq44sFPLhqvbGWQGNfEFMZNmaODy?=
 =?us-ascii?Q?ek6NKh1dFQ3wSueFyHRCttRqfm7Mir6r8bly5KqtJR9GxHROzTasT3wZB8gl?=
 =?us-ascii?Q?KiWzGR1FRSTXt56Uou9f01oatxUFkx1/Y3rwmM/Jf89TzA4al5agKzxOXhbI?=
 =?us-ascii?Q?jM+e+IV18YPlmMzgCfAVWAv8llliZEd35eiu4ysgHwdDplSQj0FiUN2OHVJN?=
 =?us-ascii?Q?S45a5jfhEoUQ4jg7MIC97xl4wzInc4KbPIBOn3R/u7pKyXVQ46pJgORpoqMY?=
 =?us-ascii?Q?AKI7SlPr+SGeRkokM5csP+TPWVmwo/9hRTZGyfmo8EihY/6ESq85VZ19SPJC?=
 =?us-ascii?Q?nw1jvwAxHEi4F8uTB6teIKwDGfmJ4Z72E5SF82aty7oor5oZawL4CoDLEkDV?=
 =?us-ascii?Q?KQNsDZQdupAD98sqNRRnWHzRwTZn1mndg6fJ08kwFDARHj1EbbDQvx8/vyrl?=
 =?us-ascii?Q?nTolTCHMVbZ5sWMAFDXhCJG5blWtKJUhgqtv232IH3//NYURfBxYAS2jgLj6?=
 =?us-ascii?Q?sRAW7oi3RHbNa4GyNVp2YJULWo/7dhjZQIQjwvlYMowH56Qdp0+QoUJlgJZb?=
 =?us-ascii?Q?Q2B7ToYI4KLDO5lby037nLfFNeJX2TWHQUrsPHx4epblflMNwYDNthPQaHzl?=
 =?us-ascii?Q?3Qj2MldgzuPu82eLiMV03VE7YWo7NSWYKaSmi+rzhZ7DhDUZMx1KG1kVsTQh?=
 =?us-ascii?Q?68PygEyhDbokYGK5VY2tO3KaxFFsQGx9c9Lm2ebMFSD8fmmNXsw49mKHGwru?=
 =?us-ascii?Q?+UuP+BOHihygKwRXYD2fk9tOXSCwrxZd8nuZmp3gV3GeJ+eHH7FqFtQc53Qh?=
 =?us-ascii?Q?QxzPRFmz963Gg73sW4UloQO37gLAo2H9Ocjjoi+uF5K+PhzeyGg2WDsq2ny8?=
 =?us-ascii?Q?QTTOrBIrMSbmV50NWKawZ9F1PrbL7au2DpRg4xKEJxOSUO/Y1qZsQzOI5C0f?=
 =?us-ascii?Q?QmkbGYY+rUOe1OEYf3ZCRzL1T9arINp2pOjqrBUm/tZ6FzRTGQ0F36uh05du?=
 =?us-ascii?Q?H3eW84+nyeNDeHbDcKibxfYUSiSkf++Q?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR13MB6217.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SoQ8i2/BW/4oT3rY+puqkH7l9pjmEzWfEH9w4ZItGSieI4NpZ8Ot/8F+X7Ee?=
 =?us-ascii?Q?zHYu35umdBBkyWkSwZuU/GESYqQjotQOSBQfFi/QBDRa6fIod3IHzENYN4qU?=
 =?us-ascii?Q?EvyO2y8HumoXfGLgrubJDZqqYaFPsrexuWxjoR2qyfkkQVCm+IwGe61rfYOW?=
 =?us-ascii?Q?vi3SD/Br58lyCJpv+Q8WKEljFpBtkyVNfoj7zGRa6AS9RBwweAedVOkP25Ok?=
 =?us-ascii?Q?VK7bMR3DwoStdgHsgv9wF/6py8ksFz9QrrLZMNxFHgzJbTnywgoLtxUUgSWN?=
 =?us-ascii?Q?2YIMGzYBdrrt8IZBgnv9pwQIsbWA1eIdzmAJhF1+Htif37UxYxE7iIqv3FnJ?=
 =?us-ascii?Q?K2oKIoNxOtnk2TDwM3fSLA3mnI2NBZ6pcjsf5qPKr2V7aVWdJT2ANaLAAO0h?=
 =?us-ascii?Q?D4BrzQRkV42K6DdwQnv7YkEpOthOIG1Bhu0MWNGjRfcpQGYB7j9EVc0PckFQ?=
 =?us-ascii?Q?6JjHAtK7x/hB0fEm/Ko8aSpMQdE05yekbvgWJpRJHHs3aeenNBC0ZGfBCYd+?=
 =?us-ascii?Q?vXkc7b/alHwv7glxoXTWfGw5DtuVMqv0jKRJJDmPOEH7qi0xvWO32gC7PPmX?=
 =?us-ascii?Q?aCgmn4NeGLV32Sn5+A6t67W5BFKxoHwQ6I+UCUyZ5tBLKbJedlqJzXzkAMZI?=
 =?us-ascii?Q?YYahZyy/GYKepFRLfSOmL2bEUu805uPLyLbeCdmZTxJi9l1gHSeP39ftBOMg?=
 =?us-ascii?Q?NgXlwmA+NbJO0k2ObQFveyocwNFvCw6zezYFYHoEAxL5v9Rm4R7vkS1zgnIS?=
 =?us-ascii?Q?RRXTXs5IV9jA2TF+3fx3ebNXZqsTOEf2/fJ+0i0VEXEywQOE05ok/z5i/9sM?=
 =?us-ascii?Q?mJyYfwP3AQ/DaDmEQTAG2YjPJN0RC39S28Qpf8fnruvcQI17jvNbjzu4ULmC?=
 =?us-ascii?Q?vEwjnDI06WZ6FDp8IRIFFOLDz9N0/S3QV8S3UWaRp2Fyq6obi5ab96fAYn3p?=
 =?us-ascii?Q?+8vMmskujHjEK0xmMW60nrhecgfC4aX4QWkw5PPviwru80D0qHI3klu2TOnX?=
 =?us-ascii?Q?ds9oFdvSvszhJzKcLqc57g1oXLCcBLUUQktPg9Hzo+X93zN3zraXIuwDC7XY?=
 =?us-ascii?Q?pF5kK/QoyRZ8mqvV5wN7umchay7bJni42P8oDCP8RJUTEL7rYleYL5atKHiC?=
 =?us-ascii?Q?E5kAy6vYpVDyzTR/k2dXNvWha1Kacqi/y/xt39V4AUH2EXpOIIC96ebPAb0r?=
 =?us-ascii?Q?/Swi798qi9ek0oBlxC1csX0C/pDjRH14r2NXJ3drDjq5uCdxJR13gA2Rxluy?=
 =?us-ascii?Q?ieTE2wNld2kYTrm9otYtXTDiqMMlOY0E6BdaLrZbUK7GyH2jwB/LGbxVOPnI?=
 =?us-ascii?Q?ELSM1wjkp3zhnJH7Z51w+g9aG1Db5sj/lZsml9kDNHj2TNCFJZbeLD6YY4n6?=
 =?us-ascii?Q?p1r3IE+yBYe9Bmni4L3ZapSs+NP4W1HdaJm9RfCi1n2w0ZDSBmpt5RoBrW4W?=
 =?us-ascii?Q?cDBn+tHk1v8PWvzCK8330YjODCoKVLNzt+xuhZ0jtwqluARgKHt2H07YyEti?=
 =?us-ascii?Q?Hjn1NbXQ1/1gxxjL4z05JIdzkbsxiyqBOpGbFFdultOzyQ2f/6YIqhugdgx9?=
 =?us-ascii?Q?uuVH8WerbDu0fLAQ/PzgrqW+nRVM3uzIZb8vUX9DDs6dRTUZrfBQrAWC4yof?=
 =?us-ascii?Q?2Q=3D=3D?=
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5eac64f-cdd9-4286-ca80-08de1af12989
X-MS-Exchange-CrossTenant-AuthSource: PH7PR13MB6217.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2025 15:53:42.1584
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IZXk9bGhTXYX17AIRdBA3r4v9s7cOWEYTkNOYssqNVInGYFS1nGeIH7WM1HXrqF9/cidtg7fUHzcNd+vM4Tzx4QcJLvWnr1T+Uu2gXqYnpU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR13MB5158

On 3 Nov 2025, at 10:44, Scott Mayhew wrote:

> We have observed an NFSv4 client receiving a LOCK reply with a status of
> NFS4ERR_OLD_STATEID and subsequently retrying the LOCK request with an
> earlier seqid value in the stateid.  As this was for a new lockowner,
> that would imply that nfs_set_open_stateid_locked() had updated the open
> stateid seqid with an earlier value.
>
> Looking at nfs_set_open_stateid_locked(), if the incoming seqid is out
> of sequence, the task will sleep on the state->waitq for up to 5
> seconds.  If the task waits for the full 5 seconds, then after finishing
> the wait it'll update the open stateid seqid with whatever value the
> incoming seqid has.  If there are multiple waiters in this scenario,
> then the last one to perform said update may not be the one with the
> highest seqid.
>
> Add a check to ensure that the seqid can only be incremented, and add a
> tracepoint to indicate when old seqids are skipped.
>
> Signed-off-by: Scott Mayhew <smayhew@redhat.com>
> ---
> v2: Move the new check so that it's only being done for tasks that have
>     waited the full 5 seconds.  That way the common case isn't calling
>     nfs4_stateid_match_other() twice.

Reviewed-by: Benjamin Coddington <bcodding@hammerspace.com>

Ben

