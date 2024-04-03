Return-Path: <linux-nfs+bounces-2627-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D567A8970BF
	for <lists+linux-nfs@lfdr.de>; Wed,  3 Apr 2024 15:25:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C5B81F2916F
	for <lists+linux-nfs@lfdr.de>; Wed,  3 Apr 2024 13:25:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C64D814901A;
	Wed,  3 Apr 2024 13:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mhtWR7DT";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="quTOp31z"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C672A1482F9;
	Wed,  3 Apr 2024 13:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712150448; cv=fail; b=HMAk8vzYeDe7BSoLK71fFUNG28jbqHUr5VcByzSkeJIU5fe8sSFsLHddQmCfthsoTruwbMG90xwa3YBT/evgekrF749JR3p8rAABNWYXqO9YoyN6GUJXZWZfaDf/5N2AS02w2Q4zq6E8F1T9VOFljcHT6k2uyMj8rVpggSn9TWM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712150448; c=relaxed/simple;
	bh=aqv99vHR+LOGrjSZurjmOwlEgoO0Hmzg7gMs3nVa7lM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mYu/it/4rshFlKq11f+pSw2A9YoGxP4fO/xlLo0/yg3JT3WtV7P+Qj6zmW+8+3GFUB94zfGY8cL1y266lCQNVKIx7b/q73esAifhC7/2HdZKKZ/y7V5QD8ffpZmkVZOT8YnAW/2mG+mtlIfsUiYFE+5N6njIUv/OkGTvIyhEqjg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=mhtWR7DT; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=quTOp31z; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4334n4XX032761;
	Wed, 3 Apr 2024 13:20:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-11-20;
 bh=LqJPQGf+trOwTBB9pi08/3r7rbt/2UCs8m57eQarLc0=;
 b=mhtWR7DTrrk23bGFU7XPPEfVoi6+vUnfDkv5v8cYMlQD0JN4can13ymL1kgzM/uO10S1
 ph4otwp/G30vLz704ktQ51n6gVwIxXkx+aWX7Cfhf7k2hyHo3TKhKynLOQFMpYJZCqAQ
 AxbLdxAWSbqUzCG4qRP5zPbzWdvsGurOTEh/8Z1GnvIyfeWSgiKN9plmTwdseuGDj7th
 8y85PAeCqOjTBPN5mXFMe6B3RFIHeF6ld3yXL1Z9cS1PKBDqQkq2NgI+IS4r5FEeMGm7
 e/izgw1dRa9LKupu+mpFqE0P53HiVm1XETQjdb36E/qlcesUoRKQ6sQRit7tqRjLShZW 5w== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3x695eq1cs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 03 Apr 2024 13:20:25 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 433CqSVQ011528;
	Wed, 3 Apr 2024 13:20:24 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2041.outbound.protection.outlook.com [104.47.57.41])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3x696etmpw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 03 Apr 2024 13:20:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AzO6vr8QtU+KJEHyl+ZCslfa+H92Ivd7fcZ/awuVdZa8uyRNxk40ZCBBiqVC6OxC+lipSU7yObM+yXZ2RYz1DdOKuoJEJ94fvszbCYxpqnQI5ZT8kWUP07xlmbYtOa5/mLOAmeRfMVXt7nPWO+WspnVTFK/Y/fvGjgRbuuC09wvFHJJBV620ZowqU4h0rLjhf1Tep0u3XUDBGwv65q/GeYzUJB2QYoAgQz+arwzAHjRiPDW/6ys9alVQnAHQSmrTrWjueZDEfexK+xrc5JgRBn1Msjgp7wgf8NRnf+/qhkKZ15nPTyT4PDxjEszr7JlvqXukMjMb900Kjs9VA85YAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LqJPQGf+trOwTBB9pi08/3r7rbt/2UCs8m57eQarLc0=;
 b=UB6yM0wRORWyUckQh0zJkxzeTP3OrzB4B/hrGG8MNkAKH/LlQGFKwpsegTFOBwcrOuvmdE9CawQR18R5czsEXx+wfTu9mt4bJh8bz7i7Lz/hW4Jn0cHhMsiYA5iZVAM5fXHhKCZLIHOCuCwh6Qs+ZhhvxIT78LYL5Igds1vS+6Qm7gnLZHYyyZadlx7uizDsxusnGjlhzb+jekZfjeppJcJcTIzG0kqH2gqbv4W2cAmLlHiKu4936NX3A6bfMGvwYnlgE7+Ds0F2wFkpty/64Zv+WpO4//zsg1bMzIzEU2AaIJghVEPoCWBB4wsul3UxfOrm74kESjNyvploFCmUbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LqJPQGf+trOwTBB9pi08/3r7rbt/2UCs8m57eQarLc0=;
 b=quTOp31z5/eHj7e6uC+oW1LXXeQQEjBroTjCnMAO4QnN7opuA46+29UiC8Tgr4iTtEC+m/gwAf6Lyvy/MlzCtBJ3M9oBP23cFcbwzFEYJrnpK2VevT18ARc5n2++pEa0jN4fQ8nf/TDESp598OiBMfbBPXooz8Bi9dGNm3SvVU8=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SA1PR10MB6294.namprd10.prod.outlook.com (2603:10b6:806:251::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Wed, 3 Apr
 2024 13:20:21 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ad12:a809:d789:a25b]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ad12:a809:d789:a25b%4]) with mapi id 15.20.7409.042; Wed, 3 Apr 2024
 13:20:21 +0000
Date: Wed, 3 Apr 2024 09:20:17 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: Arnd Bergmann <arnd@kernel.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>, Jeff Layton <jlayton@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, NeilBrown <neilb@suse.de>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Arnd Bergmann <arnd@arndb.de>, Olga Kornievskaia <kolga@netapp.com>,
        Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH 19/34] sunrpc: suppress warnings for unused procfs
 functions
Message-ID: <Zg1XkUMOjE0UmLYI@tissot.1015granger.net>
References: <20240403080702.3509288-1-arnd@kernel.org>
 <20240403080702.3509288-20-arnd@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240403080702.3509288-20-arnd@kernel.org>
X-ClientProxiedBy: CH0PR03CA0357.namprd03.prod.outlook.com
 (2603:10b6:610:11a::6) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|SA1PR10MB6294:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	hJYt6QyETyC3PDS2Hbxa7ijzhKl/5hh4yCf+8tZir620vYNW8mZi4APjSPMnnggJ59zPDLLHP9kpQjszgfGpbuFFBqGuFDVfkFgl7qaER7CpUtoZNbz9kiGdedEakXNHHgi5oK7aSs5UwtE2+5YXVV/2h9N2+bnVf6Jw4vlT6nau0xw+93WVKN4bKmanmP+ov1E+ih65d9EX5OlsQGTruTLMYAQ69W7nRN5BZkC2N25cgoQ3u29+GmGtuyDpdPU6Y/rqLZLSzNYTXsZgF8ryIF8GEw2kjbihEVu0e0lePOvy8d4sJle4GpYrQmHGMvdC+4HBgGNNQEZl/7h9RLrWEAVu2k2MGGo4iLtelU+O2fZ1eoaerAcYk8/agIkF+O9L2i2nCdHR5VJITympiHvLKBh2HhkvPVBdPpBoxHijqmdlNPGsgFMTe463lLFPfRQCOoDQyqTIH9X3eGsNrYKu2kTyXv+GXmew6zRWPW7Uj+4k/pmjbc7+qyTvT9HPjB4eURBKhGpIX6M7tIhmC6YVAbJJZSvnIbNVAM/9SF0e1mXNg4SBLlH2sNmkq1cRZn5a7dBdDmL1NpTt5kUhokdlANHkVW2YqYcbO0TMyrXB6bRIEAjQb1O1IGIsd1EfrmchIzEzpA+6y5EFvVx+Eq5knI0chjHHoa0Gcva9p98foiE=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(7416005)(1800799015);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?Hajgfo9A81p4xnpPdaXkgmN97eSf0xx2HAKhJDXwZB7yCgluwutYSLBTsgOE?=
 =?us-ascii?Q?vVJtSOZceWUzX3+BjlrrLetZhnO1XwtGsEeFqxLgsnEXcBNJ0ZpanArklyTO?=
 =?us-ascii?Q?WXkAbohO2oYO4uWvU4H3E5UeSNDDysb57kVODjKBWqr1SeJ7y9wh4umL2KzS?=
 =?us-ascii?Q?CZqs8Z9ldBw7pxQlJeGfxgHv3khNteAb3jx9ANCfURmjPq24Kgr7RcmD5fsj?=
 =?us-ascii?Q?KrL7pN6o70uwZrIHvNEU13UwZ0LJdEVr9kKp+AStZTGk8SdSjmyubESDV5bo?=
 =?us-ascii?Q?tMfjRkahmCmV4pARvf5bMEZjsarIttTaLT7Kzum6DL3wDBFTmnZicHf5uTw5?=
 =?us-ascii?Q?HRzgY+ag6dNAnyVDMtTOdlygvzkWZvgEB7JxECAkUnp/PpdonCcXCYKyeE2o?=
 =?us-ascii?Q?XkoOEG+0ip8Lzj4GABtYsLijDxLZZqwGnqYXC+ffwDmqJYFrjhFVtFtAHo9K?=
 =?us-ascii?Q?talmE25c+wRB11V/BzS/fUOMrJwm++kcOPb9srIWNgMZzGosWHSq107ikP57?=
 =?us-ascii?Q?asJZsAai4pP2hid0XDJrn1zefpsI0+ZJz2vwvUTJtIYWHSIgVOrsWCnFiGow?=
 =?us-ascii?Q?PDPPcdNpupk084/B9BQheU+u3hAzSb/8/yY5R1AIcQHOsjH4U8pwB708eb8C?=
 =?us-ascii?Q?pPlgqssOtvGooib3XZLlLbduk0K/imJyW+A91CoJnC5e7vdhybWarvn64eY4?=
 =?us-ascii?Q?aLeTX+jBtHZbZKd3xoEqlKVUom8X9M2GwUWtAj4XwMzcXcoPiQ8WetJyPIoh?=
 =?us-ascii?Q?vHaGX3YvT9thtEwqnZPcCn/oDdJMby4u+xB3nf93/iYGGTGFDljkOy0FIgiS?=
 =?us-ascii?Q?vyBLzEv0vdRGyb766zoCrgUXE2IFytiup6F/rM80tj29oelQlLG/x3ZbITiK?=
 =?us-ascii?Q?cBBzPB76tcRCdT7r7LPyiyy4RMVhUjFA2wLNOAOrXUrtOLw7zS4IVxpk33om?=
 =?us-ascii?Q?jzWkChbV3N/Uqu1oVMRwVI3wvp2rMBVKeip/Q7QI1/arhi2Jb3y7YPA+ZEqT?=
 =?us-ascii?Q?sRWpI6Xl17sZSAaTZwWsP77pybyW77XPPAWiByF5pD7YAHxh0NQN8uMmo4xD?=
 =?us-ascii?Q?AzAP8kVM1pH4BDNGniNG1iPmkL511XwL2Lt3srT+cRFNMJP3NtE63nVNPNM6?=
 =?us-ascii?Q?qHwr77UpUSxORyBn+W8CBOLBC8nXvkYSyvCaJtJ4Pi3UkAECZ9bJTqNPgS9Q?=
 =?us-ascii?Q?fhlUMwKLfo8NJu4B+B/Fj2VST+IaFkWTB4HGov49WPqHNeMm3pl4e3yTpgZY?=
 =?us-ascii?Q?EDw/QMMXXpK46g90RzIPv+msTissQdlug1yH/Z8sTXaRS0xndFXKToZAiVax?=
 =?us-ascii?Q?o9v4259A851a0iUxYgheUMEoVHcwQVnTV7mmAFBqzc2CplyamT9nKA+7wTrE?=
 =?us-ascii?Q?lzjRIOxKFa4hHi0/dmWru314O2GGGb+YrVZwt4cu0FTDzTAupEQLUNk1nB/4?=
 =?us-ascii?Q?F6y+2t+0c/T4RvFwJnly0GINOzJPAJO95RFSHMAq05hLpk3G01zuCDizkEko?=
 =?us-ascii?Q?40h3BZx9CZRK/q0dWd7EguhemdKvglPeSFKUMIzYYV5meTqqWesdzmf2m93m?=
 =?us-ascii?Q?5unrf0TwWJAOt+Iej5tnco0PWrIZeUAliOmIUN41eSuH2Ezt/e2Oy4scNIjD?=
 =?us-ascii?Q?1w=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	vTjiDDBfwwxv7tzWbh0t55bRzXjRLLfwfOIwe4zbv5vYRcDPLLsn91ThqIhQtqL3+Ivr3imr4r5PjqlhUbesLcHa5+pWRYzgpiJXR3h0uB2A3KF83AzjGBSYiN2SH9PZzAFxZB1g4ssdsh8RDrHtjkQ5Hv4GHJTzDNGhOM5yfAH6JWfunzatAHlVfM0Qd1bPPGUeXjPGjZO/XQRQoB1CC63jBBb8uVQEi+yFKKS74oB7nFxNNE2BO+BvtotbbpyPF5+4airh/TxzzQQ/+nd5L/ubiYGf0yUXmJukE5x42ZXic9ZW9yB+UY3WPyJfru04PrqgW3/MMDfmOEeyoxE9yc1uH6bRCtW8sQkfHJ2xSiTs3Gb+nmwZCYuyLuHDk/oeaecTG6/evCvR52ejw1yzl6PW27F1kuQzwIzOPpTY2iOFe+NK5oBZ4xDtXhOnxU2l16IYPMTkG+Marcgqm2yoW7g5q9G6x9DZcPdBnNM15sMeNQf4r7N8Nzl1mqfiD95pZLg70LNV9Fegc7JnuVjUXvE39OblsPISqbDDdaY9kd8g6D2aLj21L6I+C/WQSpLDXMLYZ6WjAvilXJuHzhmVTeQHmzlzDvnbOhXqviNM8u8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab55349b-8269-4e87-ea16-08dc53e0d061
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2024 13:20:21.5339
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4SCFf8L4XhrdoUmd8WZ64qK5r3Nr+cIj06qkWZVMEogCNYZRFchlKwlSuCs0zpeC0cIh0w84CTILvYci7eu0zw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6294
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-03_12,2024-04-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 phishscore=0 bulkscore=0 spamscore=0 adultscore=0 mlxlogscore=999
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403210000 definitions=main-2404030092
X-Proofpoint-GUID: I36AMHBrd2AJYSmB2RfCsmZkc85zqx0Z
X-Proofpoint-ORIG-GUID: I36AMHBrd2AJYSmB2RfCsmZkc85zqx0Z

On Wed, Apr 03, 2024 at 04:06:37AM -0400, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> There is a warning about unused variables when building with W=1 and no procfs:
> 
> net/sunrpc/cache.c:1660:30: error: 'cache_flush_proc_ops' defined but not used [-Werror=unused-const-variable=]
>  1660 | static const struct proc_ops cache_flush_proc_ops = {
>       |                              ^~~~~~~~~~~~~~~~~~~~
> net/sunrpc/cache.c:1622:30: error: 'content_proc_ops' defined but not used [-Werror=unused-const-variable=]
>  1622 | static const struct proc_ops content_proc_ops = {
>       |                              ^~~~~~~~~~~~~~~~
> net/sunrpc/cache.c:1598:30: error: 'cache_channel_proc_ops' defined but not used [-Werror=unused-const-variable=]
>  1598 | static const struct proc_ops cache_channel_proc_ops = {
>       |                              ^~~~~~~~~~~~~~~~~~~~~~
> 
> These are used inside of an #ifdef, so replacing that with an
> IS_ENABLED() check lets the compiler see how they are used while
> still dropping them during dead code elimination.
> 
> Fixes: dbf847ecb631 ("knfsd: allow cache_register to return error on failure")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Chuck Lever <chuck.lever@oracle.com>


> ---
>  net/sunrpc/cache.c | 10 +++-------
>  1 file changed, 3 insertions(+), 7 deletions(-)
> 
> diff --git a/net/sunrpc/cache.c b/net/sunrpc/cache.c
> index 95ff74706104..ab3a57965dc0 100644
> --- a/net/sunrpc/cache.c
> +++ b/net/sunrpc/cache.c
> @@ -1673,12 +1673,14 @@ static void remove_cache_proc_entries(struct cache_detail *cd)
>  	}
>  }
>  
> -#ifdef CONFIG_PROC_FS
>  static int create_cache_proc_entries(struct cache_detail *cd, struct net *net)
>  {
>  	struct proc_dir_entry *p;
>  	struct sunrpc_net *sn;
>  
> +	if (!IS_ENABLED(CONFIG_PROC_FS))
> +		return 0;
> +
>  	sn = net_generic(net, sunrpc_net_id);
>  	cd->procfs = proc_mkdir(cd->name, sn->proc_net_rpc);
>  	if (cd->procfs == NULL)
> @@ -1706,12 +1708,6 @@ static int create_cache_proc_entries(struct cache_detail *cd, struct net *net)
>  	remove_cache_proc_entries(cd);
>  	return -ENOMEM;
>  }
> -#else /* CONFIG_PROC_FS */
> -static int create_cache_proc_entries(struct cache_detail *cd, struct net *net)
> -{
> -	return 0;
> -}
> -#endif
>  
>  void __init cache_initialize(void)
>  {
> -- 
> 2.39.2
> 

-- 
Chuck Lever

