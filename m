Return-Path: <linux-nfs+bounces-6070-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7762F96728A
	for <lists+linux-nfs@lfdr.de>; Sat, 31 Aug 2024 17:55:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99B131C211A2
	for <lists+linux-nfs@lfdr.de>; Sat, 31 Aug 2024 15:55:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 857FC3AC01;
	Sat, 31 Aug 2024 15:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="TgtIkPqj";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ycZrH7Ua"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 160A215E81;
	Sat, 31 Aug 2024 15:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725119749; cv=fail; b=EA2kceop5TbELlh37kROlV1Yc9XIM/KHTV7qP7zPiR3hhD03lixpsyJuGPjMUbtNZe+zaU4mOFIPy5kQkXYvuMDFtwhWljKWyb2uaXfsNEP+ZIJHEIsvA4pEGyC4k+GAYw/WuH2bWYm4nK+o8DH1Af8EQf64exgqRw1bJ06SuvE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725119749; c=relaxed/simple;
	bh=5d1odI1o3dAq4QLu1eB5FHtAtet8CwcO8Pg/DjzrOUQ=;
	h=Date:From:To:Cc:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=Og3JDTo1UT/eOnsk9vgnhRN50oDxn0vqBj+MuBunaQvQliebHvB7gLmPVvgtPYCa9nXUGn2Dq84eyuZC0NfedFMTWxEec38Mw+0ZtXeDC6nxtKeKB7VrYkJvCggh2UprLk/TCWEUYDqUSCBfyuhZW15jKghWX9yeiIECz6VYQxw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=TgtIkPqj; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ycZrH7Ua; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47VC9reP004836;
	Sat, 31 Aug 2024 15:55:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:content-type:mime-version; s=
	corp-2023-11-20; bh=Z9jzRX5nfMKBNR9nYg7SS2NUZp+XwkfWYu3OFPukv+4=; b=
	TgtIkPqjAAHo/3Ju5iG5L7Yoh2QwLKmhRI8MK9e7LNH00FdiDa51M1z9sd6wvx61
	UcItSxo8Aw1DvIkuihDgkdta+2apmI+Bhah24apKNbnzbirS89MolbONRlu7HEtN
	donQqqRQqTVx5TxFb7cND43Z1Bx2iZfKkuDTlWgTt8Jw19hNSXe6zRG8KrQ+zZn9
	mmrJXfhNAGYlOVYSFkL8Xpet5mpKtQK/3ZUPL3Ik4DF5tyqZNV78tM3nojXQfGwF
	0tu9zb6KBw2gGlVoEDDSGEW4qlfbiAwM+WRVOAQ4cjDZDCIowHyWd59DuTxWHeGW
	II9LgEOx14EBBrEsbvi8+Q==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41bu7c8f4n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 31 Aug 2024 15:55:36 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47VEj0ME008919;
	Sat, 31 Aug 2024 15:55:36 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2049.outbound.protection.outlook.com [104.47.73.49])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 41bsm5unsh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 31 Aug 2024 15:55:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jgGFBtF27kNBL1YGEp/exdsMuKIVSqun8woguQD9HZfX9hKxUXKw9jqtqf6eOQJIQB+gUfoWSnC0dXZ11F8tZIkuddAgz32vwfsF9LmMlZOvAaYxhBxqxZnoIMgAYaUmQU26SfbjPzhKOh0JFXqT4HP9t77AoeFmFGEo4r36NN6fIv0HRep2fhNUw5KxJaaQTrZlvZqDJaOrR5dQglUG4d+CII5wopTgzJ1j+XA0RXNqxdjm9v+8n0N+bFC2L3C/fLvbTuLjvXnfNnOD5+JRUHQHP+Ob5V7O2/vOd3k16KJEsV3tsi6zF5q3a/unD9i6pU36+cjEylu/Dqwa2nhr6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z9jzRX5nfMKBNR9nYg7SS2NUZp+XwkfWYu3OFPukv+4=;
 b=chY5APuSz8i/amRRKfBTnAsx6QYL8zpGZyq270zrKBsl4P3PNOZbzash/df7F+MvvjC58gzFcOXKhTWfcVvB7BCPviqEVICiIiN6AsnGlpBBXYu6mSiqB2nsVD5jVLwDqIdSBgViNFKm7H+R7VIJcd+4FgxYEh7FtMs8UlUiNZ9wpm2Pi8gTWvQL1Xg0SfMn8K/fdPM462pKlNlXYTI3EG3P5MFw1pcG3hWJtXH/IWfycgW2AORE+j5MD2Eet1kD4a76edJXWsdqiROVVA/DHbsCIoyfqqMyHpNqKIpFVtoTAkQwgGzbwMOTopZo3iaiD4tJvVhS72JRa0G+HfJXbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z9jzRX5nfMKBNR9nYg7SS2NUZp+XwkfWYu3OFPukv+4=;
 b=ycZrH7UaVTY32Ak4ytlAJqBTAasg76HE8tDSAJfhFDDoqHgoxWBCj8u0LWMRA+OyROyjHZK2q3LAXCgP1b2RaOMTLOEGmUVslxL+n/R2LhBP6AuZnN1Tk96xeOhQ4qY4NhggHU7+iJFKUjiTieyzrSMJJEW1QY1iMtNpN51fWJw=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SN7PR10MB7045.namprd10.prod.outlook.com (2603:10b6:806:342::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.20; Sat, 31 Aug
 2024 15:55:33 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.7918.020; Sat, 31 Aug 2024
 15:55:33 +0000
Date: Sat, 31 Aug 2024 11:55:31 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jeff Layton <jlayton@kernel.org>
Subject: [GIT PULL] one more NFSD fix for v6.11-rc
Message-ID: <ZtM885jgMNOUddZH@tissot.1015granger.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ClientProxiedBy: CH5P221CA0003.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:610:1f2::22) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|SN7PR10MB7045:EE_
X-MS-Office365-Filtering-Correlation-Id: 16ce554f-b6c5-4614-b3d6-08dcc9d558ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pho67xYPKAFW+/+FX+Wa8bsfE3j07FOpRI59DNvVQnO93TT54/jzH42d85tY?=
 =?us-ascii?Q?RrEsGBT43Rb3CioCE66TTDHQH2Yxl3XWIcDnRSYDGn99Q++jP35mZuEe/UNh?=
 =?us-ascii?Q?uxdLmFVESTnAVajZYwNumDeKOvGvUSCxi9UmKbtepHWHka+BQ1HPih5jmZUO?=
 =?us-ascii?Q?fJNQTI9lswnXal9LlSO3Dnm8NpJjVjJUUXmM36Xn0nUvyDIbtdpn9Ed4SVq3?=
 =?us-ascii?Q?iv9zQb5DUapErnTW8E85NyMchIV3hHVvduXd5PZf0CtyGB+ykgyNAYzqWMcl?=
 =?us-ascii?Q?WGBQ/gDjCmXAa28TcwFCSLBrxcGt9nNSYg5ROoNku9TVjuscjCTZOSJlzLDF?=
 =?us-ascii?Q?0TEIW/+MnPYZmNnhNo6ZArBpzaPVZYZ10ZyMwHkiMCHX08OB50aLmEXwS0T/?=
 =?us-ascii?Q?Kh9x0jbAe25UBqpIyUXJ+2Qr94kutqRRb+ASyyy4kn85hpmVhshRSbQt80nb?=
 =?us-ascii?Q?2QpKZmsl4qsnZqUk+lrgNqGgXmHr650THxUJSbGFOrvA3ynHyCAp/GL42oFc?=
 =?us-ascii?Q?KFcXV7rBbGx6x0Gbb2mijAOmoTBhARcsdNOvyS0tMh2WRkbnbqI2dnzrrF98?=
 =?us-ascii?Q?zfGSq/rWymN46uEfeB1PgcnIkqWRyvqGH532p2WJLA4+E0F0OuXBJ4l9gqoU?=
 =?us-ascii?Q?SiNtK0eVFf5yM4jpqMxbi3/caCnW7aL81G5BpBkxlEhc9LTPe//DppLTJG8D?=
 =?us-ascii?Q?NAom3COlR9S7O9K5x8KBPPox2AebhzjcY3JU0h1yqS1TjxGDyxl/TYwL9lAA?=
 =?us-ascii?Q?xMRqg5+3Oa6C9fDpPdlBZNdm1uXe0sakraO8U4Bs4TDGtKn8zq3jyS/Ix8c6?=
 =?us-ascii?Q?3jueOHBY7uHdVOmrSTPLpucv4Z69YlpAruJpC6n8ugzT8EgFGjQfRE6QQ96t?=
 =?us-ascii?Q?wkMImGIp+gvsvDjJNEiixrtdBRtG3lgnHNoAYewmrORwm3qXDsLLg54rhEiI?=
 =?us-ascii?Q?EW9db6Azbv2Izkcx0xebi9NL3oWXrLvYxuyhEazmkhiBZKF6u1NqWk8ghPd7?=
 =?us-ascii?Q?P8ISJPMBRcX3zZ0AFgrZPBMv7p09ZsZUdCygwt6i7KoqYWJtfZ+JyL5V6fwG?=
 =?us-ascii?Q?sgjEB+0GOSkNoLJI75ZaerkesW4DcETIxM8Avl3iGi+sRqt63+OJZeSfifYu?=
 =?us-ascii?Q?oNgCfiJvyaEjEeY+t/JBzayIuw7UNEahJCVBWVVDRPiHFjPl2YPbXGirnZcU?=
 =?us-ascii?Q?rkRCa5Ux+9nzN2gE9+N6eXVg+P1ZvqPUq9nyJw004TW4k3mEiQpO0m/jANvD?=
 =?us-ascii?Q?UlihRfMX2z2WEMPxn4a+j8z8mJkHHmRwgLfr5P8WmcA/qh0VPbgq+rrD9N2K?=
 =?us-ascii?Q?mdGRY0adJ0WsfTfulyiSjEL/+HI0Q9+CfmlpbnCMW8Riw4QZUquK/ui5t5y8?=
 =?us-ascii?Q?9GUzMfM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4YbrZHJHqLWUAXyEJ0AzdLl1L5GiS6dupNt5QDWC/KiMWZt4D2sJNXR3JG8x?=
 =?us-ascii?Q?PwnWuiaIgD8wmcz8xG5S9QdwNMzAw1fBd+juiI2DH3CsjgTpBj34T/C6r7+Z?=
 =?us-ascii?Q?50lh6wVFtdlpVJVmkZfpAX92ks8pHpPy/Z2zqjYdgKuPPPkM76dNLWnlKg1x?=
 =?us-ascii?Q?oQxNu/wndNO+Sqth+rLnun18wHZSeVKZ3hUtkEssV0H6dt3dnDTscweldcih?=
 =?us-ascii?Q?keaaaSfmv5XwdWPj1bmVNpzd3aB/6qFJ+UZkvGyx4x6UusNO4WTsRmsSOzCC?=
 =?us-ascii?Q?qyAMjIzMn9CfBDCBTDlaaiRkESqhKF3Ocdp5UidsN6IQ5LLK+4gishYggGbI?=
 =?us-ascii?Q?FK4KvNRkL1cqTvBd28TK07hkrf1RzTNX0mJGbQug57zbYckx6/DXXJ/3r/6I?=
 =?us-ascii?Q?T5ohYTx2yT7wcBzDRAJ78uxuSyjvOlR9o5ccdIC998sk0cwnGisUykGDbRrK?=
 =?us-ascii?Q?yYbEajowoBWxSwsoxYh5JVHxxjUl55WvHuHnfz7ZiHyVjrBuIrGGx+/+0kMQ?=
 =?us-ascii?Q?g9Mixug/mjV8lB1DpzQUNhC1jTieqg1UqrqtIEXcyVGxvQm88eJiD4Jw9H+l?=
 =?us-ascii?Q?kASK00/bL/A51cOR4gMxBO8XdRbdjO/xrWxnkXmbg8HQQ5Wq56155xMm9DJK?=
 =?us-ascii?Q?nwH7i9mr+vUtqfE/MxRmdy2Tm2fV/gcSsEhPBgefgZWUuMEva5eTi4W2CROp?=
 =?us-ascii?Q?mgLisOfyII5xVMuweZwaMxz0NZkuJIfpbH1u9/cb8CoJeVD9VIYn/PlKN7T/?=
 =?us-ascii?Q?jDk3UzyAwbbxvjovSM3JTfdhAVT/9R/7ki3c+/bZO5K2nnNbD3Y1Z1uCiXAJ?=
 =?us-ascii?Q?EJyKkuD7zzrDLd4BTtRz0cXvQFehmk63pAc3Mgz/PcXpTRtlRVzDxxcHzjCR?=
 =?us-ascii?Q?leTAcNjX+IHUtsgXjuLYTVY8jaNRaQkoipJv2hp9BER7N6AZKy0jtM4NqLuN?=
 =?us-ascii?Q?hthQaN4MLBVPAdrTfSJnSqMIpQ3yfvc2gnVHyV+Awpwm3UrQcZT8RpDTP0j0?=
 =?us-ascii?Q?BLf0zuO5qCk5ACKa2Zw+XTYLKt8CkHY8fuRp8saawzGYdfTgK2S3hu+pGZac?=
 =?us-ascii?Q?YTFzTztUDHQfkKWRUE5dLDT9oWfjSXc24w0Ej0V/eBN3tGXLUoVbjs35aQXJ?=
 =?us-ascii?Q?/ae9w0LPPd29A2PLxITUotS0EYPQCQVxaxoqDH0TIP+i2uSHtaz3LdrZQoL5?=
 =?us-ascii?Q?lDi0dDrqJ8SBUKXzzrcgjmYg/a2UCWmn/qF/1x5Hd/as1l7FFxg6v1hZ5TUI?=
 =?us-ascii?Q?gc2Wbsrz8AhgwEo8eYkyKF/MBs6g1HVwT1bvlDWd+lPvcoiOEXY3lVZB9eBJ?=
 =?us-ascii?Q?8kr9RWpLzkW51itvYtKAmdRtf0W45HZ1N1MEbkrynY7qoO+rXGtWSvAZ/E3S?=
 =?us-ascii?Q?BAA9DETdYJDZcFhm4W4R9q3BjU++UthIG084JsbsESDc/t9PNNij9tRaeSkv?=
 =?us-ascii?Q?+WWZBupWQnvzxyXxpzwzQ4E6VWEtIsVLi/CaAXbshZsCiIq4pyedI3GZ9b7/?=
 =?us-ascii?Q?qMS9qIB9Y5YnxLu9iw4RfIaGLLR7m8xPBP4ylQUnL6atAfP6ELeJBPL6ZCK9?=
 =?us-ascii?Q?U/hT02RQiI0b5eLyzFTGKvzXX00WUPD3gColeejq?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Ayd9OHsfWsE3eCTGSyu/npkrDUtT2efXOpcEYMd8VDRoGpccoBJighJfVvT+VQe9FEAU4LvT5tb1g+FWimApgDI6QZ7d0b0HPai/RJGOwv/G9hTk4wAf5qPuURbvifp5zLrSAby9Zmu5WVEt96G65eJi6fw5kgMhE5eMf7kPiFGwOBQcwTua048i4ojRUPZ4hlE1Tc7dxExiLxxaxloHAkW5TPpimqOCSnSd1EEoUuf50o3MeCw4yzW1baf85wmSIslqmv0x7GmA1x5T3K7oezwufrvibARkjIcacZrfmmZN2F3PfXDbZkDiO6PtegboFDXfciKjH7XkeN/BSfdgaMT31i0ELe421gEx59phOPNl4FqlBCFRY9/PmF6TsADNUsZKUkU1dKsULVhhqviLvs7BiU+3uSFVF1vrvuGDabhujgMO1GXgdC3HggzH+iVKB7zj2ZhM+mTHFqXGA8q8+RTLapfy3LdJ5FURJ95XiZQ2iEd6BfKO9GsiBxd6n5IAdqV8SYl9hRJLoHKih4Z9ua47+wNJ0Y8kdp//2Q2V4W9jO7snjMp3BWAzYSlrUAfVVqmV4UOpqxClxMSh9P/KCdDlbsRG5rArt3ZK/OLQCZw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16ce554f-b6c5-4614-b3d6-08dcc9d558ed
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2024 15:55:33.7956
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ATPwilxOVvJHAK1VWMgQ1MY/jjQRXLayCPyXEhfXeWTboNsBJhVwTN1ow0vgFHLWMsznxDh5j4pMcZKbdog/EQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB7045
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-31_02,2024-08-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=713 suspectscore=0
 mlxscore=0 spamscore=0 adultscore=0 phishscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2408310131
X-Proofpoint-ORIG-GUID: K-Guau4hWkygcaYRi95rrV0eK3nWf1cc
X-Proofpoint-GUID: K-Guau4hWkygcaYRi95rrV0eK3nWf1cc

The following changes since commit 7e8ae8486e4471513e2111aba6ac29f2357bed2a:

  fs/nfsd: fix update of inode attrs in CB_GETATTR (2024-08-26 19:04:00 -0400)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-6.11-3

for you to fetch changes up to 40927f3d0972bf86357a32a5749be71a551241b6:

  nfsd: fix nfsd4_deleg_getattr_conflict in presence of third party lease (2024-08-30 10:48:29 -0400)

----------------------------------------------------------------
nfsd-6.11 fixes:
- One more write delegation fix

----------------------------------------------------------------
NeilBrown (1):
      nfsd: fix nfsd4_deleg_getattr_conflict in presence of third party lease

 fs/nfsd/nfs4state.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

-- 
Chuck Lever

