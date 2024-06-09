Return-Path: <linux-nfs+bounces-3624-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BB9F901681
	for <lists+linux-nfs@lfdr.de>; Sun,  9 Jun 2024 17:44:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F17DB2816C8
	for <lists+linux-nfs@lfdr.de>; Sun,  9 Jun 2024 15:44:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9D5C45BF1;
	Sun,  9 Jun 2024 15:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="B681KNkz";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="YgPywMVQ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FA7742A91;
	Sun,  9 Jun 2024 15:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717947837; cv=fail; b=d6ti5Ce2Sa80EhwkZRzGyvqUMxAuktctJ7LpXijvSXz5HKoLxpeSNp/tiN5gp9PkbdzuMN2kpptNEW9WDNEunXRss3wYmxeaCCy3kCMHpDT7O5wxzA+WeLeDghWKCHowBKez6sJXbjbLbvzzJZiEqpTm8O19u10goRpinSVKl4s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717947837; c=relaxed/simple;
	bh=WuYCImMN8feQNo9hGEMgv0QiDEBxoU/oM2l2mQJ4UPw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=abNtisNxpssAsEB04mLYcbrrNVKuZPFwSatIQ73X1n9Alu+n8Or30szyUMGYzCoKRPy+m+l8TqnnjtFzHD6AybLKxecd65wK/BzDSu9VXFgtPxHtMb4GFPc0rODJoPFbxv9e8qKJM5fZUv5GFS0fe8d8ravpiUePahHXIHI5HqA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=B681KNkz; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=YgPywMVQ; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 459EkuaR011740;
	Sun, 9 Jun 2024 15:43:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=q1wAm1xs9VgVI0d
	bRbvHjW5Xwntp/Fv3oDwB+FZ0yeQ=; b=B681KNkz1a42ATjTUNj3QlQpvn9UpJI
	NKuUMEF6BXzyn2H06621aCvKkwPXuGo9APBz37CSMnasY0EL8Gv73vykIWqoSZUd
	4zfeVp1Fz1AEoDCMQgKk6fw185C98rZfI66+PTxvXyDd7IYWAR+V6o2uYvSZAGum
	N4PyfcreSprB/1XorBwS0LV9SybvC3m18iJlcUr29h5BX2h+B5Q3jv1/cr6YO1VK
	4iaLwsc9X8Hh4ESxiL2oJAL2ffQEp9HzEstRM6g1ftJ5g+3FmVYNGrdPEPtSalRL
	Jmn8kWQcbaHHeI2MRSY93YSD0Si2b3bHbT3cS54OsmqQ+EJdlq7whwg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ymh1919ug-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 09 Jun 2024 15:43:42 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 459CRXXr036656;
	Sun, 9 Jun 2024 15:43:41 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3yncdtu5rs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 09 Jun 2024 15:43:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UuUsWZNRk/0XK3KvyxiBVUHYPjQxRUxJS7sCb8Wky19MYRrl6EkoJiHimDKkdUrkudQ2U4jHZx6gwDkiXySWCb5KYt30T5D8RWq0QDCIGN1+xAnLYxwn6QCJtluLUBZlaj9FDwIO/jGX9uycQ93hCVidQHuXZbrtA5yr60pD8AS5kB5asipDz8Fi3Cqrv4SKq6KXgvLQMSKIaf3NyP4pV7Jr8Y8qMXOzz5ONyfsJApzW3qXDurzC6jIM9lJxpu7+0VwAJYG2Y2iMVIIiVw4MAtx/fK2/Viua1G1sgDYlli3eRGE9VqYc3Ci5r8Jek1rzl5lpv1xdEXMMI6LOdpC2Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q1wAm1xs9VgVI0dbRbvHjW5Xwntp/Fv3oDwB+FZ0yeQ=;
 b=iGv4C/t/Vd08+rTRkE64KzVGEsMk64qg5VOucerbJWghn3lgYyRrXFIwQ/nETxpv1U7NZJ+xiaKRQ1+JZ3V4ha02J4XaZwUB+Oc7c3NfbeqkSXsizDOJQ0WT9VUcaAg3y2ilAOWVkkEu/HD7leVdjxk8Qa6AoBC1/MKID2MYLZYh7UxwqJKahA6s6s1fCS8/wNA9b8EsodUqhPbw9o0RSMBPCFeQt4Bw2Zfwa/LcrNkmGUOJ5ezujgQwipxqNUP5IE3N+Kq1IGvyfO3EXLNwn1l2TsIKxknu6YQp/gPg8FKQe3tt/8hDKo5Ghgh6hipt0hqrPhBXIoL0vc2PVPgsoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q1wAm1xs9VgVI0dbRbvHjW5Xwntp/Fv3oDwB+FZ0yeQ=;
 b=YgPywMVQNv4ShKphtDcsxHAOeZ23kj69l8lp3aAYOUdxWy3eCgZ1/4Bzy6ATHxsVNCBxYNSMUK24zwucp+jPeWuO+ZqIT/UbbyXPXKvAM65ujdBc2jc8gWzilpFSCEgItVzZgjCoaJPTSVY8UlO+IOkEmd9bfV3G5jzyjOfBzbM=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DM4PR10MB6135.namprd10.prod.outlook.com (2603:10b6:8:b6::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7633.36; Sun, 9 Jun 2024 15:43:39 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.7633.036; Sun, 9 Jun 2024
 15:43:39 +0000
Date: Sun, 9 Jun 2024 11:43:36 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: Julia Lawall <Julia.Lawall@inria.fr>
Cc: kernel-janitors@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
        Neil Brown <neilb@suse.de>, Olga Kornievskaia <kolga@netapp.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
        linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH 08/14] nfsd: replace call_rcu by kfree_rcu for simple
 kmem_cache_free callback
Message-ID: <ZmXNqA/eM+j6gnWj@tissot.1015granger.net>
References: <20240609082726.32742-1-Julia.Lawall@inria.fr>
 <20240609082726.32742-9-Julia.Lawall@inria.fr>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240609082726.32742-9-Julia.Lawall@inria.fr>
X-ClientProxiedBy: CH2PR07CA0046.namprd07.prod.outlook.com
 (2603:10b6:610:5b::20) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|DM4PR10MB6135:EE_
X-MS-Office365-Filtering-Correlation-Id: f1714dec-5ece-4dff-63e5-08dc889aeecb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|7416005|1800799015|366007;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?fk910n2TTXIM9zCUUFpSN/zwOFoidJ3Of3SpH5QWKi6Xb7q9lrDka/VP+NNJ?=
 =?us-ascii?Q?Anl49AI1He7Ltt0K2I5Ub+xJLXfq4VxMhb+nMfknf6Zo0vMFPF/enxRnnrr6?=
 =?us-ascii?Q?JVQMn4jYFuIPFhL5G3d0zE2oNKsqiYkIoR3hP1XjwuF/u1/8l5cEK1mwmzXc?=
 =?us-ascii?Q?2HzOHORjqpHYtT1GwIw8yaw82+/BM1rLARgp18hM58yv6MYsVWr2FGaAZANY?=
 =?us-ascii?Q?pow7egHNytG4UTowWJ3vbSMBvh5T/0bjc8/ptGcSBpj7l008zqEBX8tKV0ft?=
 =?us-ascii?Q?IthxrZAj3GvYeJPZ6wsWonrQhqeR33OA9FOUTkYmtVo1/70sUTUD1veL4P0P?=
 =?us-ascii?Q?b273b5FA2BT+m/MWCfxXKuxTTgkPqdW/GyiFCHJCSlWOP1IToE39CV39hDJe?=
 =?us-ascii?Q?F8mDtN18HfcVMTEyO9aZn/Tio1+lR7jh4C3FtMj0ix9R9MGly4pz5fUxDA5E?=
 =?us-ascii?Q?G/7Cy5DmsOiq1Lm8XNwyCH7vXj1AH6T6jYg5SfXbbhog6c8yfZb7Ps5fuEEQ?=
 =?us-ascii?Q?jefkRFYNH1VxvsHXoNQDUC0xZn8LfNscfvwUEJ7jSlXp1f57w3UViW4prSc7?=
 =?us-ascii?Q?lVLd6z+cQn8U9uTZhyIHOqiqEPku9G54TxFuu/1DKzfowbgprcAnjKlbMQPf?=
 =?us-ascii?Q?sPk5onQutoAgRDMF8mU1T98AnmxZ8s3kN9glOQBofCd7YOVrUHB+M1M3Bs36?=
 =?us-ascii?Q?jnvBDn1v4blO2KICqNd0bv3LMAv4fW3W66H9mBtEMKSUIT3/Uwho+Fw0n+a4?=
 =?us-ascii?Q?FuJQZjykF0wZdRl7ZGvxCUPaO8UjP3pR50nwxRudUxoREo/O6XdcIzN9bR7U?=
 =?us-ascii?Q?0wLW5FE3IVu7W6sP1bP71egJV8MlOQ9dZDpTRnrj42YbqO1ZprcDhb9mkZ9e?=
 =?us-ascii?Q?uuZp4ZNpThsQASWc1fFsafDnyny0OsFu5oSlH+IBPBV9gXJBqFt4S1FjShxA?=
 =?us-ascii?Q?EuVmiwn0PXNEXdz9uanNvcz5bbVrWDjsO8xty/MYl0q/rM6bkZqYmu4AYEbf?=
 =?us-ascii?Q?5uNK0uxTBKplgHP6fG5n15/u6gmunoTeakrsmScVpmZU2DatLLH1sIqcw4N9?=
 =?us-ascii?Q?dt5dX0RNZJ45Tdx/XfstA6H6mdDshwEaOcV35Ug5jjGPpLmaQliVf/uTb9ac?=
 =?us-ascii?Q?8vxu7lKRWF92jUdN8RWRQw07Ni/pb6sHMwZ9F9JOWOxpR/d49PXggJVmJWlc?=
 =?us-ascii?Q?yq7zgiJCMl48N1VGsYc4vIZYESXMXVlrgrkCHEwCHep8oLyob93LW69WNR22?=
 =?us-ascii?Q?qEYUt1/Zxrhax3p5xKpKmEMa+bf8vKGDCZXz0rhaq1U+vstzf5YRSYkRQdH3?=
 =?us-ascii?Q?WIVrZAPMiWhiN8KDjMHupsTA?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?Q8I3ELmMj1n/3fiTYZP10MsMWwp6L9O4ODMAhsTlaKDPAyr4MJgy5CwZ92aJ?=
 =?us-ascii?Q?5iT8Djv09nui5Jcv/epVFyj09hpXnecejF3TpmmadG+UvZiRTQOuIDnMadZA?=
 =?us-ascii?Q?l2XOuF9tmp4ycaR6YX1hyt/DbTmMIIn4XBibffHq/BDusg7PfN6BwTkJau79?=
 =?us-ascii?Q?epakAA8dko0uBSBaVVmL/kXr15vZnqS1HVQXwy06r7BC9SnlxY9QKqmG8UAX?=
 =?us-ascii?Q?CVKSDnnhtKFfs+yP9vQ6a4hh/9mgjg4kuFPzhhnWjSjPhv6hgpC51MiuxAaD?=
 =?us-ascii?Q?nO1td4l6MYrr4Agod0QLQeOXmDy2VJKpH4g9L4mjH2QBFK7s5B9EfPNGaA51?=
 =?us-ascii?Q?TN74qvqHAwAp2Osbcht5jUvxoMsuEuCYEu0XMZbKYgYt1c+Mg3TNgnm80+/b?=
 =?us-ascii?Q?n5amnZq74fCF5mW7jARJ4/3b8jkh9E0tSTITNEOuwoN0bppHXOXCIxvUBsEC?=
 =?us-ascii?Q?Z75qhszs50XKFfLhY2RbbWGtndV8a7P58p1oIHC74mH0UhjhqQbpaLw9Qyrs?=
 =?us-ascii?Q?agjSgfw7GUNAnucnXgGG7ivgCLSb2XGzRU7CA+B3eV3Mt9bDHX55bw2F2zHG?=
 =?us-ascii?Q?PCb+e5sA6SOLneE3Klzub1x8ui0PYoximjPjZ8JU56/BgR1HD7lRQOJtjG1V?=
 =?us-ascii?Q?TMBlN9ig6dxqshXXRG4V8WfFLhDooL6JGjIDU3E0yFOvT5iMgM3aDpSA8nSn?=
 =?us-ascii?Q?USKxzyl/KkhETalQe5id+LIJV1m0yVk1/e7Eyv7eG9LuICnKGz5NNZSbXhHc?=
 =?us-ascii?Q?b9fFNQEQ17dCmi+5HDVRIqTLoglFwd/N+31HnLGixcxtTFZMcJFYJlVFzi7j?=
 =?us-ascii?Q?z2tL7CoqlmU/9LH3KpRavXJS+jrhTMPB0DGCtWHwmzyaowb6hHD2IDLjdSL8?=
 =?us-ascii?Q?YtNT0a5dqRehhmOYDl516KRbwuusxpsdRSSkXv1d4R3OOWa9RJqGFnjd4+pc?=
 =?us-ascii?Q?OgN+/NeNStlUwhNuIJFvgNjtvMEShimBGHclXSfiZb6KuHiKEe8oCNeRWmSF?=
 =?us-ascii?Q?JzbVnUh2PDRYTPEo+9PT8fkVdemUHGe9rvHXJYLEkYrwdBiH/tgTU2iBzTWU?=
 =?us-ascii?Q?FpMvT7QIdI9BaR4KIgeTRfGoKU79OIwJFWQ/Cin0W2zW3BcHK/ZxH3dc+a87?=
 =?us-ascii?Q?oYrVUgMVVfSKH2+IZ3nIjhIrI7G9TtFcSmrPW0HQBS42yh7JR7u8NX98Glrp?=
 =?us-ascii?Q?kMl45k5X/Y9pzRcGMd8j/UYfkxj7SaWrw62W1CE7lTaGdY6NBZqZLQn7MZAH?=
 =?us-ascii?Q?7LvbOb3kc3PA/2AyC6ypTuuruMvAG3NZo4wAl5U8+Yvt6oCppNpz0sfLJXZR?=
 =?us-ascii?Q?SM3u7DM2D0AF5/0uAwQnQZpF3/u1eDhHk21m/CVcqq+sKmUEAV2wES2XeTJt?=
 =?us-ascii?Q?QVvHSc23vb9zOj9W2U8Kh9zHlQzpee8HAHySD51jrRZcYVPfkRmunbDqe+ay?=
 =?us-ascii?Q?Eyh0ZC+/VVjrFjfBVKtHW/jox6y00ml6VVUDd2lPKX9HnRETnCu7TQdplyS3?=
 =?us-ascii?Q?J2T73xNTYXjpgEv7Pd9XGRysP8x+GGUta6ZM5Fy74FHKdj23xdKGmQjD5kvc?=
 =?us-ascii?Q?p+9rBQ9KR+iRTSjRCtEG8oQ3K0jPuE1pBMrNf5XaZlHp9J3vsnXKC2L15Ily?=
 =?us-ascii?Q?1w=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	uxXCfPoviiIUQ29oEaqpRL3kfZPYocoNZS8kNJFidYVAD9v+WRtcAAOMsJdJsvoyBFu5JKP9Bg3rRqFrzuoeh6/Enj0PgdNHo/ocomyKa3t19aykbXatisIbqt2ZNEF8ZZHaQwbinkweScQufClbMOT3ZqaFKXALpRfhMxkcbInminPX2Q+v+fWpq9vLLwXf5JuTtoGtKC7lq12d4OjoaBvoKopiJUWQtCOsSkwvSLhGe/7ViX9JwOqO9Y3xXwOXh7jJQcuv3WBoj5qV6q8I3sqxp3RfGFPbNlWvWyTIcb797qIEDg2ciDcS8nf2vPZWrDJud5wEQ8y2oiBUXO146I/tAlKif2lrPCjDqgUHrA7lAlL4EyO1iNYdjolVdjMlPhRJsZL45ZUcR7G8CBpb4osjctcbIlhatpE3XH4OWGBeHsXQ4fOQeAkBs4YGIEjZebZNoJFCMNlpmI3FkuPm6Fsf2q9NT8s4SZwUleLrlrI9B4Gz0kcd4it5jjrMkWoWCAjWuexPwUpEwaeX43KKOECdW5STrSCXfjBm2Q2dvV+VlCNOZTV+vfK3PK4+Z/csPgPLd3kMwCQOVxHiSYja6nDYHpXG9k20aFMAMFIsEUc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1714dec-5ece-4dff-63e5-08dc889aeecb
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2024 15:43:39.3774
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: agEE+2VCLUVaM76sg/bER+nrpjjlzva2nt/ssGppCHIh6uarcTM6UFkNOLvz3z/23FBOjEuxrdTimEfMSya3Rw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6135
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-09_11,2024-06-06_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 adultscore=0
 mlxscore=0 bulkscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2406090124
X-Proofpoint-GUID: kOLL6s-Q1gxt3S1Ljjh_KDhZ3B9B6PiD
X-Proofpoint-ORIG-GUID: kOLL6s-Q1gxt3S1Ljjh_KDhZ3B9B6PiD

On Sun, Jun 09, 2024 at 10:27:20AM +0200, Julia Lawall wrote:
> Since SLOB was removed, it is not necessary to use call_rcu
> when the callback only performs kmem_cache_free. Use
> kfree_rcu() directly.
> 
> The changes were done using the following Coccinelle semantic patch.
> This semantic patch is designed to ignore cases where the callback
> function is used in another way.
> 
> // <smpl>
> @r@
> expression e;
> local idexpression e2;
> identifier cb,f;
> position p;
> @@
> 
> (
> call_rcu(...,e2)
> |
> call_rcu(&e->f,cb@p)
> )
> 
> @r1@
> type T;
> identifier x,r.cb;
> @@
> 
>  cb(...) {
> (
>    kmem_cache_free(...);
> |
>    T x = ...;
>    kmem_cache_free(...,x);
> |
>    T x;
>    x = ...;
>    kmem_cache_free(...,x);
> )
>  }
> 
> @s depends on r1@
> position p != r.p;
> identifier r.cb;
> @@
> 
>  cb@p
> 
> @script:ocaml@
> cb << r.cb;
> p << s.p;
> @@
> 
> Printf.eprintf "Other use of %s at %s:%d\n"
>    cb (List.hd p).file (List.hd p).line
> 
> @depends on r1 && !s@
> expression e;
> identifier r.cb,f;
> position r.p;
> @@
> 
> - call_rcu(&e->f,cb@p)
> + kfree_rcu(e,f)
> 
> @r1a depends on !s@
> type T;
> identifier x,r.cb;
> @@
> 
> - cb(...) {
> (
> -  kmem_cache_free(...);
> |
> -  T x = ...;
> -  kmem_cache_free(...,x);
> |
> -  T x;
> -  x = ...;
> -  kmem_cache_free(...,x);
> )
> - }
> // </smpl>
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>
> Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
> Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
> 
> ---
>  fs/nfsd/nfs4state.c |    9 +--------
>  1 file changed, 1 insertion(+), 8 deletions(-)
> 
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index a20c2c9d7d45..eba5083504c7 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -571,13 +571,6 @@ opaque_hashval(const void *ptr, int nbytes)
>  	return x;
>  }
>  
> -static void nfsd4_free_file_rcu(struct rcu_head *rcu)
> -{
> -	struct nfs4_file *fp = container_of(rcu, struct nfs4_file, fi_rcu);
> -
> -	kmem_cache_free(file_slab, fp);
> -}
> -
>  void
>  put_nfs4_file(struct nfs4_file *fi)
>  {
> @@ -585,7 +578,7 @@ put_nfs4_file(struct nfs4_file *fi)
>  		nfsd4_file_hash_remove(fi);
>  		WARN_ON_ONCE(!list_empty(&fi->fi_clnt_odstate));
>  		WARN_ON_ONCE(!list_empty(&fi->fi_delegations));
> -		call_rcu(&fi->fi_rcu, nfsd4_free_file_rcu);
> +		kfree_rcu(fi, fi_rcu);
>  	}
>  }
>  
> 

Acked-by: Chuck Lever <chuck.lever@oracle.com>

-- 
Chuck Lever

