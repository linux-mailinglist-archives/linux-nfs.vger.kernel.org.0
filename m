Return-Path: <linux-nfs+bounces-6116-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 92DBF968363
	for <lists+linux-nfs@lfdr.de>; Mon,  2 Sep 2024 11:35:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D0E9280CDA
	for <lists+linux-nfs@lfdr.de>; Mon,  2 Sep 2024 09:34:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CDDF1D45F6;
	Mon,  2 Sep 2024 09:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="m4POugyv";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="wHpN0rtn"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 573931D27A9;
	Mon,  2 Sep 2024 09:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725269653; cv=fail; b=AjYzrPIpUbz5kOI4Uy7XBwDVIIAE15A8vHESOPBrZ0j99hbZc1zG4NyyLHj8gPyt7PKICRlN5i/HFd/vSYQpk0kbsq9dVKGb/novpxq1creDrcbAmD3evaIqHMcokbT4c8X9Pq3AqGpD+e8oAdg08jxO6TJPV4cZ2o9t/JEx+Ag=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725269653; c=relaxed/simple;
	bh=6+UUtiTCHKq9r7344T6lwRu/ncbmQqQc8aG5i9+ySMc=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=FjfUqyn+chRAlP9AKhG9OTTVB1ik/23TjHen1Y/RRraJoBKtkIeEi2NIISQ+jY0mgIWipZ+5CzoGYsfq7YrZ6bBs+cuNUsrrzeoAN61l6Gborfk/MH/yC5bzAO5dCvpOURh3ccuQDrquoxQ65lb9MyvFoDQ7kRcdeRPPqZv1yvw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=m4POugyv; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=wHpN0rtn; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4827RViR006528;
	Mon, 2 Sep 2024 09:34:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:content-transfer-encoding
	:content-type:mime-version; s=corp-2023-11-20; bh=bXMRYCpMDyVu24
	2Ln8C1YvhpAaUMPWUCfhfEKEav8+w=; b=m4POugyvOglfb8mmeSDmLxPHbwS6aA
	jrLwr5mPlDzJlmZkfISyCVJC+ko+ZnvNNKcpCJHupSdU6oyWdANSCJ6WLYsIyflM
	Khv9OlJqLgqaz5dodTxxiIHDZ3+PYgJ4VVtbF+7JZNUmwPO+loxf8aMG8Jj0uqg0
	L9vQmgTRe0URfmPWWewC2baxkBgmNMHM2VGnRBVqfDMNB/LXt2GFPiPH2WZ8/Ed5
	1Y/MbvMsOf7J2bTmuTIWcoLPZMZvhVpqib0MWjl2gpb5JuOiPsk0dlz+tDSOtnpJ
	ZYA7qUXml1EuZHWrZZ3cupFRngMEsNTMv2V+x3Wdvkjgp1RGbP+/Kv3A==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41d2858r88-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 02 Sep 2024 09:34:06 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4827IdGg035489;
	Mon, 2 Sep 2024 09:34:06 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2175.outbound.protection.outlook.com [104.47.56.175])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 41bsmdreja-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 02 Sep 2024 09:34:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K6McA9LLCVHjgyI0BjtCF8Fu18yFw5Wk+tYw/56qgZcYmx2/4gSzkdKhaR6cd7PJovQ8fbASIzII1Ib8koBTqr7ZarjKzTW/0sGSqQu4sMkTIsi+4QBD7PMBSMztYUDTrc/Duk8kbMwZILEvGpn52vtPd6lAHGil0Yem/Ru6CO3s55kabCk29DryuUJ9pXBKHlAYCi003tGtkASnSCNbb52L+eG+OeGtlI51ILQ8o6KGqsamUy0D+A8zrWNDYAbqg8pma9fUv0QcKVz3Cn1h3rs0Xb2FIEA96kowTekzXYmuqmvv/vIcO+BLqCvOGHHbQ+3sD1fh6Ja3g2IzAh/Gzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bXMRYCpMDyVu242Ln8C1YvhpAaUMPWUCfhfEKEav8+w=;
 b=f/mUslVfd7+NB5iR+skVPH6vvqGCdEcfdoDvItx5WinCsMUnEQUX+dlze2tBbJTP0SKAeKsN5l4dWvX97RNLLNIFGCUzWnbwqYPRzX3Voq+/p+WTAtZpZwAjoBmeDr9yXvsggOCFalng69bFkdhNHhFq8F6Mzjr2BKhsXAPZaPwpaAzELRJjSDlPQx+DLp4v3Oo/+VG9scVLlXGJT3Zi3lWLUEn6Wpi25jgO8sYx+tQsAQkX2YZwXbdJ7DkOEx3IKrxXnYU+Zz24geSHrvWjDXigSa3UbCavGAJc3a1Td733xDqpYrvyMg90+cf1i6UD5mSgiXrAaZXT2FPanoIkkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bXMRYCpMDyVu242Ln8C1YvhpAaUMPWUCfhfEKEav8+w=;
 b=wHpN0rtnKw4guk0FbiNYmK+9ZTuX7MLr1d5ruamm2z9XugUMo/mF51gJAgSC7tWG06E2qJNXxhnZh1PA/Z50G70NeusbiMWxnxvjxmrIxrIHi7OAI6DVIviURu8WuoDoKEauOwkbU2w4km8SRl8qH70UCWW3lPKOKjAEeHG+tnk=
Received: from PH0PR10MB5563.namprd10.prod.outlook.com (2603:10b6:510:f2::13)
 by CO1PR10MB4705.namprd10.prod.outlook.com (2603:10b6:303:96::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.23; Mon, 2 Sep
 2024 09:33:08 +0000
Received: from PH0PR10MB5563.namprd10.prod.outlook.com
 ([fe80::1917:9c45:4a41:240]) by PH0PR10MB5563.namprd10.prod.outlook.com
 ([fe80::1917:9c45:4a41:240%5]) with mapi id 15.20.7918.020; Mon, 2 Sep 2024
 09:33:08 +0000
From: Siddh Raman Pant <siddh.raman.pant@oracle.com>
To: Chuck Lever <chuck.lever@oracle.com>,
        Olga Kornievskaia <okorniev@redhat.com>,
        Trond Myklebust <trondmy@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: linux-nfs@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] SUNRPC: clnt.c: Remove misleading comment
Date: Mon,  2 Sep 2024 15:02:48 +0530
Message-ID: <20240902093248.64055-1-siddh.raman.pant@oracle.com>
X-Mailer: git-send-email 2.45.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0043.apcprd02.prod.outlook.com
 (2603:1096:3:18::31) To PH0PR10MB5563.namprd10.prod.outlook.com
 (2603:10b6:510:f2::13)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5563:EE_|CO1PR10MB4705:EE_
X-MS-Office365-Filtering-Correlation-Id: ab46d270-a67c-4eee-5c36-08dccb324129
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TEu9aK6T0pLr/hGABYmcgC5Tcfz7scLRlzi37nKhYUrkw3CgpY/LFTCA9mMK?=
 =?us-ascii?Q?kSYHlQjNkLh8KfEddXSuQOK6uC35WVafT2f8UmVW1tEAFFjglZLxh1zZsssH?=
 =?us-ascii?Q?Y0a+PLD6WvRwOs1JafLhND67JQ07ggs69izkLQP4iprnIkdq0lMLx7DmB0Pi?=
 =?us-ascii?Q?znD0kCY9EdKPJWekC+HjYAVBHIZT0nx3BXgoWp/iuZVFAPNY16l3LnCPJDGU?=
 =?us-ascii?Q?NXM+M+Le3fXdndYmCUrEG6dR2WcjmhEZ/TkBGTzBCZvJV5zs0J3as26azDnr?=
 =?us-ascii?Q?bpZmiuuFh1OnluxVNz4GohVSCYDRVQQD4H5afWyD929GKVwb72v5CenQ2DxZ?=
 =?us-ascii?Q?36YrHN2PQ9q4MVjvLSPsV+qVMtRSS8RMKfOG5UOp2DaANsLjPnDl94Z1irwe?=
 =?us-ascii?Q?aPYuwz2KY8gTaUpew+vbvHwQlBydap3So7ry5tZe9Bx4efWqdRTXp+NApvCZ?=
 =?us-ascii?Q?M8imR08JSw8k8m3qCkA8j6UJz3B6ZuU2HvmaVeO0BFhsJwr/2Xe11pejr0M/?=
 =?us-ascii?Q?PvHIjlieYXsRSZxeGyGBnKNkIgH+dIuSbLKI29pmB3xe7sVhFaeMyPc4EA71?=
 =?us-ascii?Q?JqXcjhSQ8VgWrzMe5Va4PdmUl+YXR6Bkyz0tVU9frfgW+cU2XXYL/AE4r/sG?=
 =?us-ascii?Q?IPPISKn7ndPBTPXS4Wtc4pmFxpxBdE2YaMFHE0A4KY8nBn97jESmHFTPaE9k?=
 =?us-ascii?Q?XJyoSmCMusQSBQg8ioa3s3Bv8MhQ9ld7vRoSc5ZgwMoHHM3bv2ah3N9AApvS?=
 =?us-ascii?Q?emUtnQLYys9OMbygMC2j28Mu9CbrJ5vlIW6FmckGNdhf1ec4zlnrNEunuUjh?=
 =?us-ascii?Q?/4ljlP+8jtYeFer99sfBn6qM9uYwM+ap3NM2cAQvCLFL62l8nekhnNzcat4v?=
 =?us-ascii?Q?K0mNjb6KIU5iwZtGFRjDleTY05vcpAqwDy7aedTmHEiPVdYuaGVDaihwjNx9?=
 =?us-ascii?Q?/H7IpfjFArOyVcn/A3Y31L0TnaOHnHbHwWV3m2IAO3zHJZ7JZBMGOqb3Opht?=
 =?us-ascii?Q?tkYIlAasOM/zM3lHX/IAPaQdbSSGf9+u+lWdSlS+s9qvXZiOaO64em94RTje?=
 =?us-ascii?Q?abnhShh49pQMqEGTZbtRGM4RAgqrb1mK0frC9kdPyXnOpcyG46n4D/vH0861?=
 =?us-ascii?Q?WX4kSmNaGcsNK/GKBqZ98nS/kRf1g89mIebm0ZYGmApjeIOmIaNvEO9R4xcv?=
 =?us-ascii?Q?hIXgFvYbdnFvioyECXwGkJ1mzGdP3q4hfQcNiQUlUOuVJzl5ivqyph4pGBgh?=
 =?us-ascii?Q?PV+EU53AwntFZTODq6GenqI2QEKUdgECd5n43USm7AVH6Lzu+I9UfHnIUGtk?=
 =?us-ascii?Q?Z9MD+Qp9JizQlY+zn9Dgmix1s8lxr9vTcTr//F6Q/66sOg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5563.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rPBZSJtTfGsOKSxt0e98a4ni+CCr7v+33VBuBKNhWF0tAmB3hlTlffFbqqyA?=
 =?us-ascii?Q?w4bq4+utFlIw2RCwKDVYpDXxxNTJCFXBc6sheU/dwTu1tI+UGaafaZlE5ftv?=
 =?us-ascii?Q?50NjK+UeRYp5rjdz3tRnNhZtP6FXhxdWc5wOrTKZIhZHCUqFgk+kDMrK0dDA?=
 =?us-ascii?Q?5YejAOhJSYVWb8a13e+jpwtIIDVl5m+y3duE+eTC/b82oC27kjmsdUCZj4n6?=
 =?us-ascii?Q?mMMdSmTnBqUEexmbdS0C55smP9qDfHnZeEYrJtFNJ3NRrdlBj5jQ3M3GtZEW?=
 =?us-ascii?Q?NvgWVpkOjXQr0DTDJ1QPiCUJGgmPndB/F4pjK2jbY6sJOokgazZKVpc3WYtD?=
 =?us-ascii?Q?NAF6ZfNWQbINslOP11qlFUy+MJuLtbeVd6SsM6IK2CaOrzD4FT/bqSW3tdjK?=
 =?us-ascii?Q?Aih5Pu/0Pkt1f+Yq8ZbiGZzQT2JujoHAhBi4YwwDfAWqdFXg6mPDgAWbeVBi?=
 =?us-ascii?Q?MYFHQKIIw+fzSUOYOgKf6u5FAVQLzy0tRWoMc3hXRyNEhmgTtYR5Kcs2Y41J?=
 =?us-ascii?Q?I+KEKyg0OQMzX1ag4pPSNkV7ALifiI+PPK1MFF7Dc21Fj/0G4M15ZVsviYKS?=
 =?us-ascii?Q?LdIDYTxl95yUOfYDFjmTWztP1rPAJfJ/jg5IjGjoRRsX6cxwgdlfapO8Sn5I?=
 =?us-ascii?Q?s83CFVKQEGMB4UEYw47gVS2scdSYxgBMW3J66wHShUNAvIX0Cuc7hM3iVNbf?=
 =?us-ascii?Q?rnsb4AlufYqu5ksDI+UcvuJZgfh6gjuSpTIWUhBg/upYFf8wNAe7+0ECaxXE?=
 =?us-ascii?Q?51uMQjr/ACBu+A4HrFSz3lajAzDkiHKHG3Hx/1yppnzJ8zW9xqEEasIFpXVy?=
 =?us-ascii?Q?fExK0Yrq4nxAIXyGzIAxQdhgxaQ0VLNvhLaEy9oAoEtU3BAWKMbTmF9LYMNx?=
 =?us-ascii?Q?aVjTdfoBPfZfh3JrHPLsx3+z4TtoACpjPOKwhzaqm1eZsntZ54fQcj08DNif?=
 =?us-ascii?Q?ePz6JRVbdCDXrcqDFOVy9G/8VztymrAlTxWzpT4wGAUB56nTQttXyKyyrF8g?=
 =?us-ascii?Q?FvvE97pvmRiPlqexbKGM6sHPrJrN/nSJdRTeO4SddxPsW5HM9vnhNXb7yFZg?=
 =?us-ascii?Q?OAF4B3ch3NMSgZWfCPAoysBqOLeSLH1C/K8KguN7B1k1x5Vr3iKAB0m8pzJQ?=
 =?us-ascii?Q?zNLvF7kv0qDEqLc5n+ixYhGGS/9dLvzY6fAwJlxD76s/4cn/S8gcJVg9c1k6?=
 =?us-ascii?Q?hJoGK3hf/BBXzso0x0cl4dstRwV4CTg9upW/nw45PxgOOcs4hggHDtP6PZby?=
 =?us-ascii?Q?3nrj0OHICIvYKbMrOq336gn6DxjCMztu2cU4nxJRlzWBbsO0srShVT61Oybe?=
 =?us-ascii?Q?HAw8pAY+azFaWBbxj3Qqs8s2QQ7vZ7Z5oxqQINTWhVfRhtGqOoml0/bsN2ya?=
 =?us-ascii?Q?uG7JLyXpB80PXsb25IqreKM13tMv6mNTDyGdxg+f/vrbojTgZqhE7BcA2jcK?=
 =?us-ascii?Q?iJrC0nyqpCWXdTcbOu7EcMd1P/TAAJZqjS7OWcMO4G1GZgtQKlWJ3q81cVS3?=
 =?us-ascii?Q?NXCHMCDctLysBJ6MH4zDqfdGbBXNxHhMniTQPfNL1N/UdeXXsQ8nR0+dzrKQ?=
 =?us-ascii?Q?WiSXTBHWRjAPMLNyQupxQtCSSWrL0rvocJMHREsiK4d9/cwFi5qTwHccWIIH?=
 =?us-ascii?Q?E8VmnMHP32RMsgk/XEKculU=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	zqNTHd+kZIUU4CkbRQR6YoWGvlbtQi4g0KzLnegQuEWKwReShlL1jr7/r0I5WDI4UjSUDTd9751MWcp5owGgkA6Vo7S0ZXMAMeg3mkzFgtYTjLEqli9JfnrQGAxCa0aTT+lMx9J/Cz2pRtlf9gP6lC6MS1LHTGglJvE5BvItzvpfcKzyXQXcTOJb/NQasC1yiRffNu5xPVux1COtUrfket0TdWvFiB0RUPC6pxD61mEh69bChtxKwJdvNEb8uRM17RXWzuVy02/8i5ucThQaGKf/qhfqyrF1Z0sv/7mqu7TE5+wcAe8BqIib0OWpYgrYoMKV8y7ehWUHyM4MNY/bOCxwYRMUyhs9aEN9JAcC260j7xVVA1L4uKWMdrsgeDZ034m9yUZ+OoQ0g/aduborKEKaU3TEiEYUSrU3ddi5gs2G6tW8D58L7TB2jaueDHfPP0ECva/UcSKEfuxhGnv7GK67+ZRE3eopuml8lnec5kPFAuL9BDo6HlZUO23umTO51GO+4kLtQHbxCaCVN6HnrxY7Z54QjL7+5FLgwlmY1sF4drYEx4d4czM1kEZvSrMyxbh13Ydi9sUEeHihIZBC2i61/X4Y1EoI1V+DVhoKoJU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab46d270-a67c-4eee-5c36-08dccb324129
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5563.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2024 09:33:08.2970
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t/Zy5qDq8+B168seru9IFfWogTIlB2B9H7baAmExmhpGPGyTmvZzlTq+4+pVY3qZQQN9UeO+JomNV5Na3p2rDHIPOgf0heTlSHslg2Fhpzg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4705
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-09-02_02,2024-08-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0
 mlxlogscore=999 suspectscore=0 phishscore=0 bulkscore=0 adultscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2409020078
X-Proofpoint-ORIG-GUID: 2Cj4jLnIVsmOtGtg8NAe3WMgbXm7Ezcd
X-Proofpoint-GUID: 2Cj4jLnIVsmOtGtg8NAe3WMgbXm7Ezcd

destroy_wait doesn't store all RPC clients. There was a list named
"all_clients" above it, which got moved to struct sunrpc_net in 2012,
but the comment was never removed.

Fixes: 70abc49b4f4a ("SUNRPC: make SUNPRC clients list per network namespace context")
Signed-off-by: Siddh Raman Pant <siddh.raman.pant@oracle.com>
---
 net/sunrpc/clnt.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
index 09f29a95f2bc..9b18c3ba1e58 100644
--- a/net/sunrpc/clnt.c
+++ b/net/sunrpc/clnt.c
@@ -48,13 +48,8 @@
 # define RPCDBG_FACILITY	RPCDBG_CALL
 #endif
 
-/*
- * All RPC clients are linked into this list
- */
-
 static DECLARE_WAIT_QUEUE_HEAD(destroy_wait);
 
-
 static void	call_start(struct rpc_task *task);
 static void	call_reserve(struct rpc_task *task);
 static void	call_reserveresult(struct rpc_task *task);
-- 
2.45.2


