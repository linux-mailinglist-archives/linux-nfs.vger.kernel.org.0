Return-Path: <linux-nfs+bounces-3904-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AAFB490B4EC
	for <lists+linux-nfs@lfdr.de>; Mon, 17 Jun 2024 17:45:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CE2A4B33D59
	for <lists+linux-nfs@lfdr.de>; Mon, 17 Jun 2024 15:00:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72A3913B2B1;
	Mon, 17 Jun 2024 14:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="SN51gRqc";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="DpnAOF9a"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A25F13B286
	for <linux-nfs@vger.kernel.org>; Mon, 17 Jun 2024 14:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718633327; cv=fail; b=lzBBjmT4IlVCHmbiqRbnxa8dkegRYkBpdN2Ny1qnziW0KyMX9monPeo0QB7byeBH6qeIpdA6zA7pPp5ZR/we4PfUljbwSiK5a2lGWiQ260UsG7NiSlV4eHhYxN1iEdGvgoZC3t/usx5ojtuvZfoJl6h00fksPk0DGld2tvBYxaM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718633327; c=relaxed/simple;
	bh=iKx4geJgObWpIb7unyjjbpevB/a00rCA7GoXX9UHiog=;
	h=Date:From:To:Subject:Message-ID:Content-Type:Content-Disposition:
	 MIME-Version; b=d6SieP1/PCrhZvchKu5BhNBhd0Bervk/mX2SOgbjRgeuK71ArMReu/g0W7lima8g3MrJo+mMMCnJXXqoY+qFySxouCQHR/4rr6az+C9nDlSj22iu9V8/bdxACGc3jShEfUcCW2Ue53c7brVP/ybSeMytWSGL7ydn4BIvzOz3LWg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=SN51gRqc; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=DpnAOF9a; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45H7fptg026353
	for <linux-nfs@vger.kernel.org>; Mon, 17 Jun 2024 14:08:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:subject:message-id:content-type:mime-version; s=
	corp-2023-11-20; bh=Rnxm5dGiimX4w94Rz3bXAxceorqQRHp9o5RKffAE0CY=; b=
	SN51gRqcneOio4QYRQLKFEuNNGNr5G4rTj8RtsZIS08n8tuldSG7ZFmS5yI/cCOQ
	iT+BkTVPTwkZVXx/IWiQ9q0Rie02r2zEJZdu19H9mCCbrroiWMu4jBEmvu5w6PY1
	giiUByC0i6QxF4DbRoorFFMZIJR+i8sZuexA0CpT+IYVAjfS6YPD6v4o+HGqEjnu
	5iB0s+Te0MpQrDZET/tcRy69Wpi11Pu0JtfAqR/5iT4alSWB13S9XwYYGoknqBry
	CXM3U5cvuwnkl+0e3YvL1dU/YN0f95NzpAhkF2RvuscuuoQ9wCK9BMo9ZQi4XA/C
	6Hi1Yle5f2ch+OrojLsTVg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ys30bjrd3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-nfs@vger.kernel.org>; Mon, 17 Jun 2024 14:08:44 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45HE7tJp031332
	for <linux-nfs@vger.kernel.org>; Mon, 17 Jun 2024 14:08:43 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2041.outbound.protection.outlook.com [104.47.57.41])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ys1d6geex-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-nfs@vger.kernel.org>; Mon, 17 Jun 2024 14:08:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VhMGiFR7K4BwGHu4LAW+u8ZSecjZz4qNG27Xpex6gwJW6pFL0FG+CUcsM/16PR1LIDM45dTKFKp7Wwz4JK1FdvKUNL57nsCnehAho3GFrNzGJ0HSrolZ2Iy5pXYR7+/uzUwKuWzHc+D6xUgGqPTD7jHvPXeSZkSJV8Jdebahw/5S0i6dx02dUbKGzmdfqxtg7iID79R6nIGZ/57VfCjqJd2HrI9WQ0ZlKrrFM9KfmutiIqU1clEO2vqdl5JOUApzVETVVekWgZB3QzxPXz/s3D2zdkjMzdYB9uVH1BVKMmu4C8Tp6abccLRqo1+LwKFbdxC+2ltEqk1l+gsUE5yuhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rnxm5dGiimX4w94Rz3bXAxceorqQRHp9o5RKffAE0CY=;
 b=cx/q6l9Dq3DmQrKA1D3ttaUdV116k1CF6s6CfXBK+Yv6b8MwexQ49k7QkuaZH+W9BDVxokQnsSYPVIhbP0eJ5zqavhG5i55FQV2CP0TCLtpuLH+uEXBYmPAdh5Ve0bhfCek+UpK2OCd+sMc/LfeuGW/Mzmy10Y+9RuHonUAKXqO0CeLuImhe0vTR3+ehVYyxpTv/oe8BHRldssvi/LgFrps1ykZqgtoQXJ2mSsMaPbaauQnt30lmu9J5I3D0YJXZzBzzpCLwPi43gPtnqF4EfOokwU1Y+dJiJcCWo60QDCqk2KL8P2seW4jJRtkxHHr/3Y9LJSkki01jaR9bLehDyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rnxm5dGiimX4w94Rz3bXAxceorqQRHp9o5RKffAE0CY=;
 b=DpnAOF9a7wBYbZBYENiqsdIbYRCtaLl3sAuP+vAogHzbDlKuGuHb+UysUvTY2TmS58J1YzHQy+V2YIcHK/tzLOzZ42bb2/Gzm6+kFv4kEqBYJQsCKNjbJ9udzDXGPQMOpTLFIJxHlKUmLTNOj+ZTa+BrdE80Z2JpYsGJINoDpvg=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DM4PR10MB6038.namprd10.prod.outlook.com (2603:10b6:8:8f::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.30; Mon, 17 Jun 2024 14:08:28 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%5]) with mapi id 15.20.7677.030; Mon, 17 Jun 2024
 14:08:28 +0000
Date: Mon, 17 Jun 2024 10:08:25 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: linux-nfs@vger.kernel.org
Subject: long-term stable backports of NFSD patches
Message-ID: <ZnBDWf+30oSZydqp@tissot.1015granger.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ClientProxiedBy: CH2PR16CA0007.namprd16.prod.outlook.com
 (2603:10b6:610:50::17) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|DM4PR10MB6038:EE_
X-MS-Office365-Filtering-Correlation-Id: d387e2c7-b597-443b-fee0-08dc8ed6f604
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|366013|376011|1800799021;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?219R3Tbym65KMYXIXY5xkx93iprUQM+jPGuT4r8a2zcDrlzBg8kh8hpqQwAR?=
 =?us-ascii?Q?iLzmp3WXHbhJyMlwXCLskTiUUrSeYcCRdoiNpIMpn1AJ+/ir9Uc2gMRLCx/Z?=
 =?us-ascii?Q?Iw9Nd8E5G+h8W+s8woiN+h5ZSmzvuZ/iVdcZGACM9l06RDwWdWzwEO1bVTy0?=
 =?us-ascii?Q?p1R+Q2CMDH9uldcY0Vik7H9k6MH1yE+Ui56pa9nJYSq3CtvagSJlZS3R+Jyp?=
 =?us-ascii?Q?uPuxfjN+GAixolRzZ6SsUD56n7OR+i+b3pDjleNez1LKdtvAHE4Y1FpgxdUN?=
 =?us-ascii?Q?n6M+r55TmidRvHO1qZiBk5+X9xBFi42p1sUH4mYX+AW31BJrEMK/1WVF/YtC?=
 =?us-ascii?Q?MGfafY7/a5E/h3gcbVJ9WhQImXIVjBEE3vUugZbnAZRw8C8Sa3XKlXI/Qsv1?=
 =?us-ascii?Q?xWbXc/02vQ0gzuzdoxs5LWfGXF3yM67uLZ3Aot+p8bu/USWP2zHg5YhSaLVj?=
 =?us-ascii?Q?lh+Bsh3T502ZDE9gXbyki8eeQbbBCVb2Tn6SvPp6mByTK0wLinBvume69KMR?=
 =?us-ascii?Q?6c2HKX6+5qsnp+EPR8eyPQ34yqVKi2bSUGQT0vj3X2ivnlKPRrcznaE1ZKD9?=
 =?us-ascii?Q?3yWm/Rxlx12zTYOlMp0DM+BfxTe/N1zm4ZIfLwARgYTlUYoTDKNfy35Uht3U?=
 =?us-ascii?Q?IZiXezmPyj0zsvPlRRKW+Kbc02gAXaTc5sGELeH+5ZOasW7QDfTMm5GWUk2A?=
 =?us-ascii?Q?zfbSmM6dtD1sfYSXfaBG+6pJcBDqAxlXxRAOFmRdDIalA8Zm5XP+8saW0Eyi?=
 =?us-ascii?Q?1/WyFFUBZNVfo/dtRw49HTuNFnqQmR7spe+ii6rPsP2aFwt4vwWUZo/KWlmt?=
 =?us-ascii?Q?5DtVAw2lIzYtmWgw9pufWcuTi0iGIlJPWQe9mExZAbZFd5IkQcunhWvIkkvh?=
 =?us-ascii?Q?R0XE/RvrAJ7k6sKRDwMIihgyh+QaApuZ/yTyDTes2cfWudiTEKXnTEHQCgVh?=
 =?us-ascii?Q?QCQn0tDg2RJkEpTkMeq8d73Qnklp+Gy/p+JYn/hdd8IcF5tgeIg1DjIUxFp6?=
 =?us-ascii?Q?g/Cgmq8G7pkmCJweYs6oU9pCBFkYZiqtIisGPZu7g8ehoMEx1S5QMyB6YNgJ?=
 =?us-ascii?Q?Ya/gWVm3OyLNvxJB+kUzj3IDhRP76bTapauClBiXilbhSAkGJCL1FOH2unrI?=
 =?us-ascii?Q?/AaASvuPbh60ypGhrWF+jowlD/mEisctYwZKopYF634Ub5grFcYyZDTSSg2t?=
 =?us-ascii?Q?vKYK8okBmKaddeNuU04rMJ3R7S0Nn4Nl3cYN8oEk4jN6L/ked2I5e68blk2e?=
 =?us-ascii?Q?ozEIDgu9R8tqoAmHxihl?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(376011)(1800799021);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?mtZZDq5fcZUMbMoheqsifi+1jlzkwQEXnKAi2VE5qDhqNr4bTQ33tYgnz0Id?=
 =?us-ascii?Q?7+apQSnZLtfCbrpG9ulwsdn3G75f1KMKrVE6KEWDRek22f10IIvSCyu3XSdG?=
 =?us-ascii?Q?++Li3egssatxSOkD2hr4kMNlgHA07wTvdzpEdxSoIR309QariSckMkNpHrMg?=
 =?us-ascii?Q?QuGQrwvL0qDrdCAwdqA2BfeB2TDjXhV+kFHwSsfj+z6wQa+inUwck5eHipKL?=
 =?us-ascii?Q?cWA/szVM8lW7wxLoZAsJvb4H1bnfUHZQd+WQky+LHBIwaFE1UQyvhaJHKb4j?=
 =?us-ascii?Q?mPG3Rw0CaugriP8XT0QL/RCJklCszdFTGLwyjUHgHC9KULr3lCaMCyPedhWF?=
 =?us-ascii?Q?scxREgVr/Ay6StuFKM5kHzJOTB5oLyBMMm5AFFoirsfzUwcIm6npNLGsb7Ox?=
 =?us-ascii?Q?waKRx7hABYiv/U9vSLk0u1XOvH44h4xcFZQwLnDBzakujrRLSbIg50MDyJM7?=
 =?us-ascii?Q?17toSnfmfTQ6EnvYikAq3Yrg5FMplXfXfKJrPyAy947A1f3vB/IJSIF6J8/j?=
 =?us-ascii?Q?3+gx6ykoZrA9IxIUou5ljlcTdYoG51N2B1UCpnCxJ5maGi8/NyrLyuDJAnp8?=
 =?us-ascii?Q?5/a0dGKRbpg56q2ITGS5vZsfgiKHrVQ9U55yINugFUCnWxuoaDmqC3Wo69gG?=
 =?us-ascii?Q?Up/0P2ga+FMEMAelxg1pws2b7q2y5TIVHXHBR3RoznBgkFq8I6EhZ467LukR?=
 =?us-ascii?Q?V7I1kdnE0bNt6M1hKOBdhPq17v1SSe5Yot3NcnyNhHzJpYRwBZ6s3jYPsFnl?=
 =?us-ascii?Q?dxyiYMz7xhp7aVyL5vaZ6dxGMTqqUZv42ef+752Jxw3dUxd8UFlN/CQ+IhBV?=
 =?us-ascii?Q?pw55xlrDE2v4rwP4z797u2AjZ8AkDDV+Q/IJAwH6emEgTHY7+6tL5mk4WMIe?=
 =?us-ascii?Q?4W6tApGfNhABqHeeRbqHCDr9x9cal4jp7hVYKqdB3zc5pnHQ2ESnq1Y6nw6p?=
 =?us-ascii?Q?9PwIszI+OK3Qgnxi8J/SQICqeNY75R9rnLitCWjYBpjdgTiaZw1z373Mq6/1?=
 =?us-ascii?Q?x8IOqrX7LParwkPAOL22x1b0XjM3zpRm1RhxY6kpp4Vf7WZ1ItGhg+EbnT8q?=
 =?us-ascii?Q?lf2sldHlgxwGYztd76SpZCfVvXBhbJ78kuaoBa6gIXFxOugNhRGWDModjM0D?=
 =?us-ascii?Q?R54gpsn/KRaiTcRBnMKz+bjKN47ID66llzV1AUk59uL9aMS+b2/tg9jWDalr?=
 =?us-ascii?Q?6hzmrLxrsr42WcFyyMaD0NkqSsVVmRqmO7PDKEf0I2nNfGlZctBmE8dpM594?=
 =?us-ascii?Q?5CIUVYCaKi5UdZ7/S0CG3hNZx+QiEPJW6ysOSM3SYoB8TQb8INEgg4Hqf48V?=
 =?us-ascii?Q?WNyMCyFqJQ52yUZxQc+6rqsjXOEcuRFw6jq+dX51LR6W8Jj68Lk0y9pI+G2R?=
 =?us-ascii?Q?jNt/ZU+I6KV8G/QMlZZySqPV07198n74Y50nxt44eWT/lakdXQOz4ViOZi4D?=
 =?us-ascii?Q?1HJCFzL+o5D3KcbdD9sspZdFm/US9XLNcGcJ70a3MTdkyVyTeIrcnuVlUFrm?=
 =?us-ascii?Q?ttR1Wc9lghF07ix3BIeAm9Z75dw8Z3hwlaGEst0VK4ODuo9CqYu27bxkwvjR?=
 =?us-ascii?Q?J2dOPjxLS/NMNJKRHkjYksmTO1O7g7E75lkBBMwnGObwHQgl6X0ZCdfrzAu3?=
 =?us-ascii?Q?qQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	9vmlQYEb9HOsI/G1PFnp5PgU0tBNyIBjJQHOacMMZUXjWkg2684Inv0d9M/ezGwePGN7P7KJCc0Eb+6euOadd2JXhNuBH6o1fit6aYHPvclCQCeWteP97hvn5CFeniTWV5NT2aGHikXG4cMvzUDjYeu8zc8W8HgF24XrC0W5YOZM/p8jAK1Y1f6OqNiEGEyCUqcjri5vc3NwCxI43GlGzxNZS66TEOrJfj9gq81F/ZSLUXq2UydrTFr0knDZL1SnhCsPv3quixEDMZgQiU8qMhCKS9wDIZVrxovnYCtmM0frR9Tesvlxky1WGRhgBL83nuf/kT9BymGWq/DzSirC7FyLBb96+XmiOeZ3u57bMPpFLR3WQFIjcK32g89hc/eaXcZaQXG3IglpOsXcyQ+UtOkoLan2c178AOWSaCgC/5RakIlDtnZfljiZ/hlsTFYfhOCY6ZAzqEjTybzq3BWbXLGUlm+jh32iV18g5GJxuFE96U+2Zp0kLJ3Y0NNrxTCqjIzSP9ouvGll3ydNgBI1kBM5T/ZRCR1m5gVw3fAmqW/MdHDc7nNMiEFGV8zCIlH68V+iR+NEyPsdzxDIh79n9lnzbwlnYJIX1WCs1+7Hgo0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d387e2c7-b597-443b-fee0-08dc8ed6f604
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2024 14:08:28.2504
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: phIH+Mi0k1ZefTf6vZqFR3Ux9g5JcrVVN3lwGwbU+tJ+yS6lcE3kB2RXW/KX9GgOVpAznWA248Op1jgWRAhkFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6038
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-17_12,2024-06-17_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 spamscore=0
 mlxlogscore=962 mlxscore=0 phishscore=0 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2406170110
X-Proofpoint-GUID: HitZkrQQ4MStDVGGAN3Qk9YAaKOt5oIb
X-Proofpoint-ORIG-GUID: HitZkrQQ4MStDVGGAN3Qk9YAaKOt5oIb

It's apparent that a number of distributions and their customers
remain on long-term stable kernels. We are aware of the scalability
problems and other bugs in NFSD in kernels between v5.4 and v6.1.

To address the filecache and other scalability problems in those
kernels, I'm preparing backported patches of NFSD fixes for several
popular LTS kernels. These backports are destined for the official
LTS kernel branches so that distributions can easily integrate them
into their products.

Once this effort is complete, Greg and Sasha will continue to be
responsible for backporting NFSD-related fixes from upstream into
the LTS kernels.

---

I've pushed the NFSD backports to branches in this repo:

https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git

If you are able, I encourage you to pull these, review them or try
them out, and report any issues or successes. I'm currently using
the NFS workflows in kdevops as the testing platform, but am
planning to include other tests.


LTS v5.10.y

I've rebased this branch on v5.10.219 and plan to send a PR in
the next day or so.

You can find this series in the "nfsd-5.10.y" branch in the above
repo.


Out-of-kernel follow-up work

Amir Goldstein made these review requests:

- Adjust the LTP test fanotify09 to update the comment with the
  appropriate 5.15.y version
- Update fanotify_init(2) "FAN_REPORT_TARGET_FID (since Linux 5.17)"
- Update fanotify_mark(2) "FAN_MARK_EVICTABLE (since Linux 5.19)"
- Update fanotify_mark(2) "FAN_RENAME (since Linux 5.17)"
- Update fanotify_mark(2) "FAN_FS_ERROR (since Linux 5.16 and 5.15.???)"
- Update fanotify_mark(2) "FAN_MARK_IGNORE (since Linux 6.0)"

I plan to provide these updates once the NFSD filecache fixes have
been merged into the 5.10 LTS kernel.


-- 
Chuck Lever

