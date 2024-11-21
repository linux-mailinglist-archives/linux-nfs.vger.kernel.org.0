Return-Path: <linux-nfs+bounces-8183-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 99F189D4FC2
	for <lists+linux-nfs@lfdr.de>; Thu, 21 Nov 2024 16:33:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D86BEB223CF
	for <lists+linux-nfs@lfdr.de>; Thu, 21 Nov 2024 15:32:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD3B170817;
	Thu, 21 Nov 2024 15:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JEbFKtdd";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="hzNqIrnX"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE72328687;
	Thu, 21 Nov 2024 15:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732203168; cv=fail; b=PV5MYNTdDt/ip7PQx1XZYK/515vB8X4FjPJr0kmaZD3KWt5f4M2GaVx0nRwcLHtffnOJJm4BLqS1Sk80Cydlx9hVFNpsmne3s8gEuuzDOKrJ9or7jPy2iAxKMi5n/lu+TQaErqwUkg+0nOUVqTSKF4XjLllUYpGtRJ4O8RjnqL8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732203168; c=relaxed/simple;
	bh=Z9qEPfY5Nbmv45gVDOD8xhWCKVhfBrus/7suiTnlzMA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=drGMVOD7JKnWF7uf/DQEjjo3KikuamYt1ZhMtvyR+mtUHp/Id3fzb2QghJhrPc+ZByXGAG1mc8617g51UwuGBduA0M6Ve8fINFVYvMIgNr81jAE8PePCnOGzylf7WkmNjkW3DvingUOVTXrnCnzrpX3E0A5C0ltUINMxCMxZJgA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=JEbFKtdd; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=hzNqIrnX; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ALEtWCl003402;
	Thu, 21 Nov 2024 15:32:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=zGzKMGKFUC3I5eLuk9
	FY7SAr47NxcMzIILSYF/gT9ug=; b=JEbFKtddiVXRepKDsXbolaGFpSHOfwuZE1
	9YV4Yz4FZA5/9Ilse1vRbt5Edlhh59zG0/SRmQWNH55di9PvRjeGc9h/jrtGLySW
	RQMkRd29lyNnS2Vlj8/96ifkXjEjsqxGE0q/Z7Z7OopjCgulHL3zZj3tYHQGYyGc
	zeQ6SZ0yzlefaxgMLXcTkg9wW/opAlnGxGQoHbHeEho+TqlFEnBP+j8BsRqBUO27
	noCjnvfzJ2uwjEl5/5bl5klwoIKR/enywNVd6rW5QhyuAyOe1fwUVJ6WAKv+h7P3
	QvJ+xYxKXtK/R7Du9fNFZq5qnPskTgr1Bij6jaabjlaqifUhMH5Q==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42xhyyhvrd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 Nov 2024 15:32:32 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4ALFHMAg037093;
	Thu, 21 Nov 2024 15:32:31 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2174.outbound.protection.outlook.com [104.47.55.174])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42xhubvcv7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 Nov 2024 15:32:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zu+MZpdbBUPNRYzFtMmoW94+EnMJu2f1yabwq5dj9yZITLiClLzdXZuXtBUqQJlfpEOlCykF5mBBA+fqqpJzPOxR7J+NYB0Xo+ehQ8uFz9yWPAYo/B5JEt1cFwybK5i4fDH/6wPIlD89VzpDeuRXijahysW0I7srVS5KU4VJpID4CS4L6sb662Jj9Y7Vbi8Mo+WQ0YSNRpk9WP7POkbg51lhQOVjPZ/Jc66uywbbwsRNFIIMIyz5iqOsJFZHOJp4vBwCl4fUF5KX66x2O2hK0zzYyk3BDiarAoGTMI8+8lq21fE61XR90hiIuJNyq/5hu7/hvAtz80LoitmIfKHfUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zGzKMGKFUC3I5eLuk9FY7SAr47NxcMzIILSYF/gT9ug=;
 b=FWl7LETAxfUj/IWbOW280WdCwleW5kztHwL1QZmSCtkc+fLhPtPX7gob8ZZT10u9i0yXp3DHEUYGzhkrr58gucoZ2f3B/0YMb8L7deLW6dpY8lGluSzxu5MGt4Ql8x46fO2GIKlzfYM24vx+J7CRCqoJgB6J4vbOqiA20ROuM8Dm2Mi/LcusQMdC739BDuwja1q7c7sSzbEc6GYVKHZQeokBkZmwCm42McuUXCYrDcCC8+6gaur14kmiOcg50o8K1noBzFpoj5Cy+OB81V2LVNwmW/dM69mxGfiO0rElSddN9boeAwRR7J7/w9U5RuNPKZ+SFU/4st/M9ItiHWic8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zGzKMGKFUC3I5eLuk9FY7SAr47NxcMzIILSYF/gT9ug=;
 b=hzNqIrnX6X3Ue1fJ8c7DcsOWJxolaOFNFIkHCnNMcWzQ42y8gLxHqQZ2TkrxRWi7Z+7V9iTzIvvBovGOyuEN9CLTJ6/3viZdjnHp3PL1uD+PnVh40ZFzpOmVQ3wN88gfQCVoSs4bibLTzOiJ0mGZls3pJNPaEskHqJIi3Hz2whQ=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DM4PR10MB7449.namprd10.prod.outlook.com (2603:10b6:8:17e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.24; Thu, 21 Nov
 2024 15:32:28 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.8158.023; Thu, 21 Nov 2024
 15:32:28 +0000
Date: Thu, 21 Nov 2024 10:32:25 -0500
From: Chuck Lever <chuck.lever@oracle.com>
To: Benjamin Coddington <bcodding@redhat.com>
Cc: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>,
        linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 2/2] nfs/blocklayout: Limit repeat device registration on
 failure
Message-ID: <Zz9SiWqFBPL6RdJt@tissot.1015granger.net>
References: <cover.1732111502.git.bcodding@redhat.com>
 <d156fbaf743d5ec2de50a894170f3d9c7b7a146c.1732111502.git.bcodding@redhat.com>
 <Zz3+rNnvxE2TRT0v@tissot.1015granger.net>
 <B0CDB911-D9F2-4513-A4A0-403508BF4E0A@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <B0CDB911-D9F2-4513-A4A0-403508BF4E0A@redhat.com>
X-ClientProxiedBy: CH2PR07CA0059.namprd07.prod.outlook.com
 (2603:10b6:610:5b::33) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|DM4PR10MB7449:EE_
X-MS-Office365-Filtering-Correlation-Id: 12d878cb-50bc-403f-5c3c-08dd0a41b532
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IAz3WvpomTpH4cpFJ+ulnoZnBfXfKPKAWbDt8CCrcZJ4j6GkE9hic44yyB5p?=
 =?us-ascii?Q?qnse12KOLENkwAEXnwyPZYynVHV881uXP4ye2kZGNJ33ENhpXsprNN+NnwVB?=
 =?us-ascii?Q?PC2JOui8E+ryZpC2K4LOe9JWnxSZl1aLOAlmmhl0bSXp6UMpinapDZE1bdD0?=
 =?us-ascii?Q?4wPT1XNSZKw7bHnQxd5r0JKnydwommT8i6w+TcR4fBRwBZJkSdkLnTDpcc0G?=
 =?us-ascii?Q?Cutc8lFRzpH0d/T6z8CC4pcc0sYYZX5nwRsAXLASUD+d4ypYGpC+WiZSMVcN?=
 =?us-ascii?Q?2rYhHjIx2xtBCCW+hjCibUTeiHIjgwfVvXrYltF7Q+ml6Iy86F9wef162YlQ?=
 =?us-ascii?Q?uzqEuMHR6St9G9CiXZq4qKUnm/aOTf9yL+A0uBz5BxNu7tHBUFqXV38zmL8Y?=
 =?us-ascii?Q?Tw+8rGllRUFupYkNieWq3eUUqWKfKBgSuJKlUMhh605DRSZG1Pc8BHORpWhC?=
 =?us-ascii?Q?DAnokbBE09PGqWD8qKUXAZgM536TCNy4KEv1UET2pQQoAiT76o7WTg7GL+fL?=
 =?us-ascii?Q?Un45f3GEOSPCo9NcUwnAba4m16xkhkGeBqN/xegRy/PnRkT4k2s3Y3yM5skc?=
 =?us-ascii?Q?QWrCOT5B3h4UdZucKbQhnjqHiq75F2jJESgKb2OR7tOv/Dsnkq2f8pE78G5C?=
 =?us-ascii?Q?M0OLxiayKbKlK5jsyxfACEW2AE43Rn14yt8wVxntmaUcr9zmF4ngD1Za+Pgk?=
 =?us-ascii?Q?9PLX+4kn9UXOPrCarrGYRIAph4kmiigdaxgzNKc8D8ugwkRc/SQSfqEZiGPb?=
 =?us-ascii?Q?M0bB7VTPRHkPQSzcmP6yqNAqICogHLQNaqNNDtkrzl+mbjq7IS5IQhXPeHWY?=
 =?us-ascii?Q?gXm9KAqimruSotbakGV9wKNltcOCyutD3b0wBfvs0lt4+DJX8E/rQZ/O4AK+?=
 =?us-ascii?Q?nDj0bxVuBvaGILp03zu0D/KVo76Nl2OCbaXLisA7dCqmDiP6ZkanhN0doAnW?=
 =?us-ascii?Q?LOI/YQoLTi0eX44j3Sf87afK62Ezpz+sXQyREkhIE1gVVX+ApQGJ+Y9QOABv?=
 =?us-ascii?Q?J6qiePEcpPx9BqXAQpec1BAy21rHIPwaVod1vbbj9MX4IL/yDHh1Qs1FT+ux?=
 =?us-ascii?Q?U4s0C3x468Bx0Fuy6BIeXaAtETxLOxAafQWuecd4gdtxxjiqbTECaOmKYA+q?=
 =?us-ascii?Q?BZVinoGhbH3uq37D/5eLk7eeON5T8OoSmItg/4AoidGCQp9U7YoWw6tC7rbl?=
 =?us-ascii?Q?LFVj9A3DQGRgzNxETQ43ADrMVStlXfdX4lgMz2rvZouF0ent3y3iCg8Bdagm?=
 =?us-ascii?Q?e6lOhnWe5j14YhybznnuLdjods7cH1KoZYwu1YyunaznrUIbT+6dVL9LOSRy?=
 =?us-ascii?Q?ueYYTF0wN200omdQTU3ZpRPR?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gvmj8wKIOTQxTB2+myGM9gWgR9s95oz37fnUr49pTDXKMqrpwhk3jInHnHml?=
 =?us-ascii?Q?LXzRSFg+W8qi/FF8/3vMYy0D46trabko0P8i40Om37bl5tq7yZ3XvMZ/cixr?=
 =?us-ascii?Q?uMZoabhi3D89BMFFp42JvvvBqlOQNItX6qLAjEZGu4hWLdBl8+SLDwYlFGEX?=
 =?us-ascii?Q?99zN986P1LfIiploR3MuP4mqfMZSJLO5ByrIp7osl8d/9kfELtHUfTxldavy?=
 =?us-ascii?Q?wrjvg4mBdp0b+U8VnhrPUOjEoUMMeTVZzDCLwDDrIdnPHb0vydAz60EGSzfw?=
 =?us-ascii?Q?UCZDL9SpzdwMzYjiyLgsQnkH9phlfmJy/BVNwq3U4ntoevktb0ms5icQMp5i?=
 =?us-ascii?Q?LIGS9smjIGnsBKrG6gDhwrXrLbkxWMwmHb/KjxogKrnTE1GLGMsvB1N4lOvy?=
 =?us-ascii?Q?DmZD9W2B+e5EHUEgr8zSge6PuAA4nvy4Zjswmuhfy+Z15I1K2x0L/NWkRJA3?=
 =?us-ascii?Q?uAQU7qZ4AJtZrhfZRvO5motEL/z/lh6ATp8NRVUkAJth+8KFbaKy4LN31cZ8?=
 =?us-ascii?Q?/Oqv3mgHYte5Spr1H/eraROEXXGY0YXGHqRT2v4P+JVz8GotQGzJid8fZT16?=
 =?us-ascii?Q?JObtJ1FhOgBHToRzx/BYQ2rXe1tu1IQj5Ir+DCTGACYrBU5RhGbVG6ryU2aa?=
 =?us-ascii?Q?+mA622AkxwYaD1f6N33COyJr0pzWd9BDB0wfjcIeJTPUHBDwMmlkk2CTOtak?=
 =?us-ascii?Q?+0/0bQnuGtPDcQwCgQsFOYO3vl6JA3CIpMSW1VIzs4ulBHli7tBkJbFcrP/9?=
 =?us-ascii?Q?vTHajXvgta+CNyCR5bp7Ei5cgzNzvzQAMyTHzK4/BSDoGtRwFFNoP/mu98pi?=
 =?us-ascii?Q?9adcMV4cuS5c4pwOFtChdBMylWFURfQuQdMwicyDcMBA3NFTrKjIhpegEvmG?=
 =?us-ascii?Q?y9sO38vot3DjKDSIU1Rd+n0sADmswgqcQFTTEBVnmU1NlcRpIqX7DV2+VXId?=
 =?us-ascii?Q?HOts4nrm3NmCux0bwkh8zq4t+jlA/klF/1th5fSytJ8FlwiqsPvWjVzaN/sl?=
 =?us-ascii?Q?emFs1oi/R8y+NbhOQ5oMi8A82inQxcVMZ9X1R1RIEFuTMDFSR6NAHpa2oakc?=
 =?us-ascii?Q?nFoSKdOaza4ACpo6gEWZ+i/mT0zKpV9WIGmtnBNW/8C6mNRMWe7CH9Q5NDB1?=
 =?us-ascii?Q?1u2e/gw8Z6AWAScgGxkHgykZceh0omGHbBU/vgSt/q2SblhfDNoxxOhVYlU5?=
 =?us-ascii?Q?0GzHXLDeJhhFNRZ7qBlWutvHVj8rGgFwYmtP2uPepK9yq8MlAEtcmDWvGx+9?=
 =?us-ascii?Q?Xq3e8pU1cHBvmOU6EiRUV7LfSf41g3JN4QDYpGqX5LGlPuH7ooB1PiusOCo0?=
 =?us-ascii?Q?LcQbK+N+0bFSk4tbYIgaxe0JlIXHJklBEiEiBugMaxd+CaLozOuivwd/24RR?=
 =?us-ascii?Q?PafgFT0flar3u8Mz4V9Fhd27NidyhcWIJ6W/p0p1dYB8i2PlS2SY60yYXyTT?=
 =?us-ascii?Q?Y07Pxab4vCtvSg3WSw0Ovs21v/EB89k0/mV4KsfP9uqqDl1gmFjiXxzu44X3?=
 =?us-ascii?Q?lmbm1E5B+iScWHTZ2mHj8A5OXWbCIrgilf0y7Wl0WOPPqzeROHaGPoocuJnM?=
 =?us-ascii?Q?evreduAmfeq3CY37kIwsy2oXQySyGrvTAa8XAsAI?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	/jDtI1LT4rzJGf04Efa+RrAhdH7uC9NFlDdWWbcu8EHoItmytSNMRS1fFdA0Vk+X+CftiaTKNtqoG7Z8YfNP8/z2jsLNn+Aj4rhNkZzOO3jQT1Hq+FZYZ66o72+bXrh6iMyIvyw720bIzW5J8WZ625hmvJp8BqZjgoIF/Ij/4i3PJxNRGjuOy1AuCVCQkO89NYGPt1za5cXfpGfFkRewKbK6Mow1iwbfxcQnmMTcsH01qr+rDBJQqE22Dn/wGuIpFu0N1axWCklU+YO+u4kqE+ZRhPRQl4H1H1p60kF78mWqgUAJhDl8+7fvdhsA1P0zxkmsldOANQngHw+wgfKDN9iGCefoIqa3AAM8MYCKZYdXa5eTEQFVPd+Kk67XdlWrVRHQy6HzUO3AiB/vzZDrZGzh6sCmfHznuKoV6cHk7fo2eIRZlRkW54OPFU91CsQ16MLvM/B+4ywDowmNwElHmZVpKeT40dGOKpQ26K4X9R4xaR/B5q0HtRpF+l1H/MFh2FUiJeL35XRA8jNODqXcj8IX9z0D+f5QV+xuIBcgcGHbA3x/rDSqEDKJr+pvraYRl/yRi84y9m9mGGltVVsjAKFEDe9h4irJCQZepdv2rr0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12d878cb-50bc-403f-5c3c-08dd0a41b532
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2024 15:32:28.7587
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wUc5tSuJreTZ36UQodrhDAIeVf+hCL0+nx+CmD1292qEGgboZNrSStxO7ZZIXY4UqNTvsxR/RmYYGzYkl6r7gg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB7449
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-21_11,2024-11-21_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 mlxlogscore=999
 phishscore=0 spamscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411210119
X-Proofpoint-ORIG-GUID: xDu6clNFv1B5ViJi73INAcSyVQtaGb_I
X-Proofpoint-GUID: xDu6clNFv1B5ViJi73INAcSyVQtaGb_I

On Thu, Nov 21, 2024 at 10:11:33AM -0500, Benjamin Coddington wrote:
> On 20 Nov 2024, at 10:22, Chuck Lever wrote:
> 
> > On Wed, Nov 20, 2024 at 09:09:35AM -0500, Benjamin Coddington wrote:
> >> If we're unable to register a SCSI device, ensure we mark the device as
> >> unavailable so that it will timeout and be re-added via GETDEVINFO.  This
> >> avoids repeated doomed attempts to register a device in the IO path.
> >>
> >> Add some clarifying comments as well.
> >>
> >> Fixes: d869da91cccb ("nfs/blocklayout: Fix premature PR key unregistration")
> >> Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
> >> Reviewed-by: Christoph Hellwig <hch@lst.de>
> >> ---
> >>  fs/nfs/blocklayout/blocklayout.c | 12 +++++++++++-
> >>  1 file changed, 11 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/fs/nfs/blocklayout/blocklayout.c b/fs/nfs/blocklayout/blocklayout.c
> >> index 0becdec12970..b36bc2f4f7e2 100644
> >> --- a/fs/nfs/blocklayout/blocklayout.c
> >> +++ b/fs/nfs/blocklayout/blocklayout.c
> >> @@ -571,19 +571,29 @@ bl_find_get_deviceid(struct nfs_server *server,
> >>  	if (!node)
> >>  		return ERR_PTR(-ENODEV);
> >>
> >> +	/*
> >> +	 * Devices that are marked unavailable are left in the cache with a
> >> +	 * timeout to avoid sending GETDEVINFO after every LAYOUTGET, or
> >> +	 * constantly attempting to register the device.  Once marked as
> >> +	 * unavailable they must be deleted and never reused.
> >> +	 */
> >>  	if (test_bit(NFS_DEVICEID_UNAVAILABLE, &node->flags)) {
> >>  		unsigned long end = jiffies;
> >>  		unsigned long start = end - PNFS_DEVICE_RETRY_TIMEOUT;
> >>
> >>  		if (!time_in_range(node->timestamp_unavailable, start, end)) {
> >> +			/* Force a new GETDEVINFO for this LAYOUT */
> >
> > Or perhaps: "Uncork subsequent GETDEVINFO operations for this device"
> > <shrug>
> 
> Sure, ok!
> 
> >>  			nfs4_delete_deviceid(node->ld, node->nfs_client, id);
> >>  			goto retry;
> >>  		}
> >>  		goto out_put;
> >>  	}
> >>
> >> -	if (!bl_register_dev(container_of(node, struct pnfs_block_dev, node)))
> >> +	/* If we cannot register, treat this device as transient */
> >
> > How about "Make a negative cache entry for this device"
> 
> Hmm - that's closer to the dentry language rather than how we refer to
> temporary error cases in device land.  For me the "transient" has some
> hopeful meaning as in we expect this might work in the future - but I'm ok
> changing this comment.  There will be some NFS clients that might try to do
> pNFS SCSI but will never actually have the devices locally, and so that's
> not a "transient" situation.  This can only fixed today with export policy.

No big deal!


> >> +	if (!bl_register_dev(container_of(node, struct pnfs_block_dev, node))) {
> >> +		nfs4_mark_deviceid_unavailable(node);
> >>  		goto out_put;
> >> +	}
> >>
> >>  	return node;
> >>
> >> -- 
> >> 2.47.0
> >>
> >
> > It took me a bit to understand what this patch does. It is like
> > setting up a negative dentry so the local device cache absorbs
> > bursts of checks for the device. OK.
> 
> Yes, its like the layout error handling, but for devices.
> 
> Its not obvious at this layer, but every IO wants to do LAYOUTGET, then
> figure out which device GETDEVINFO, then here we need to prep the device
> with a reservation.  Its a lot of slow work that makes a mess of IO
> latencies if one of the later steps is going to fail for awhile.

Thanks! It would be nice to add this bit of context to the patch
description.


> > Just an observation: Negative caching has some consequences too.
> > For instance, there will now be a period where, if the device
> > happens to become available, the layout is still unusable. I wonder
> > if that's going to have some undesirable operational effects.
> 
> It sure does, but I don't think there's a simple way to get notified that a
> SCSI device has re-appeared or has started supporting persistent
> reservations.

Reviewed-by: Chuck Lever <chuck.lever@oracle.com>


-- 
Chuck Lever

