Return-Path: <linux-nfs+bounces-4167-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 61C94910E1B
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Jun 2024 19:09:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3FFE1F2224D
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Jun 2024 17:09:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 734381B3734;
	Thu, 20 Jun 2024 17:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="IcMSn4ZV";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="L1xvmyh2"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6B171B29CF
	for <linux-nfs@vger.kernel.org>; Thu, 20 Jun 2024 17:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718903346; cv=fail; b=rz90d2LuN5lN5sCQC5nM87AK2Q/If94EbqlV9BW9moaaeHTIhRT2AJNs43M/o5+aVYhGlsbYN+g22vibxDvyn7YB3QL24qBFHwGUwAYJd6MXcqb3+MqgAF7qKMJRBpZ3u41t4bHj2ZV3fn7hPTHFL8zpLGBdi147Qnkyoalxx8s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718903346; c=relaxed/simple;
	bh=R9UwKAJibWlilD5mCA1k96MndBDhwVZXn3Uy7hNJcX4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=V6PjRrgTJ+3mBhThIsfg1mxYLqZfuEZ84ZbadCdcAmoX1mLWNRX3kKJwT35x7wl3g4MZ+FIOjHBZ7FSszV38wlutPGsT23A/nrF654eaZvCZ3Fu0z/IJKEyvj2xIcKo1In9U1y+g4+CAr9T5AOUbv997tfywqYrinGVN+JHJ7xI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=IcMSn4ZV; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=L1xvmyh2; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45KEJ3nm001823;
	Thu, 20 Jun 2024 17:08:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=eqMzFSo/x9qCx8u
	gstVDKzavEGF9vCTb8sy5qLXmaIk=; b=IcMSn4ZV6RS5UCWbBYMPI1Vg2+t/4R8
	zpl+wOkpILR+SXpjweTs891ydmHDYUu8bLBQlXO1LfzaDQV8TQQOltMFZJiIY7/L
	Ql6hROTcB7Py+FCXjeeN2LiN+TFoXdFZV7bRMH2rP1O79bC1VuVoBk7MjcRzbNXS
	23Zh3z3EAU0Y3ZvSAdK5kG4uFfL+dPlwkm09nOV6fwYAmDD1JIyX/NfgFCSiLoYa
	b/YBiOf2CYHoQZ8aGWsN9ufzG3rH7RJOjj25oD9S7QcUA9x8dXVJfF4MRsPDpan9
	q6rALgi5GTpsq7+pYi00tzgA2O8JpNHqv+Kxyciqh69t6Y7CfJanKSw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yuj9r3rqp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Jun 2024 17:08:44 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45KGUeHB033150;
	Thu, 20 Jun 2024 17:08:44 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2043.outbound.protection.outlook.com [104.47.55.43])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ys1dasj9u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Jun 2024 17:08:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OaOUTKmrXsWQC+OKXmBfPwFx5H3FudijVWmsFIMJ5KUB7eY1CCG1vF4OolPOh5G9w5Fdt9PXFlTdufnVzQHRHwcIoRnCiWpIi/W8r5zCwmWCZqkVBcg3llQQrd07jGuU6C4+UtfGEmR+WfJvfwb5hiX9DoupWGw4uo1MWzThQmtvwfHyQ0UBuFDOmPsCP5LOpOAFMCcixBCw+M5XKzcEOCk6SAsQauShzuKPsmVFyX280xXdkm8iAlxCKiAua57OWbMMx5kdUbabgbSGTWA3CSmuarUg20OTBW1lOJ8Ug3J9A7mx/UdRjEYMwJhyF+vxI0HzOHR5sXXXa1/uQxvF0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eqMzFSo/x9qCx8ugstVDKzavEGF9vCTb8sy5qLXmaIk=;
 b=O8ZcMQnAJsaSK9FQbYKhC+OqRBs6JMfuFvJ6nsT7abJml2XohnyWosWPfOY21gfCTi3jds0r/kWaAdQ6Egwdwk0JiCNbJFMw+DbL7IKmXcc2vrjTiEG6ekTln2yOU8MH005ekVrHtBI2q33GiM6dyEr5uRBOh91/8mcnTvuPkOwlOq9wTlFYSK/SjvB0FRkm8Y+4KWozx+lLtbP+EjRYfKGVzfJDXpK9j+1rvv1qEhCTBR0f/eGLQOW8ggRF3epj4S81igcRos9x/O9FI76OnsE4CEWFOHnUriT/hWHDT0vn+UORqCCWlx6t4w3boAV/xYYGdO4TdZxgW+e58P9Oxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eqMzFSo/x9qCx8ugstVDKzavEGF9vCTb8sy5qLXmaIk=;
 b=L1xvmyh2VNJuod9xZKKmZOIDxDXUWiSkTfJREqetu6eEbwGJpooagWRydDOEvXFx02Z314mCg966f8H1g169bDvq0t39f+ayVuBVSNLZuxG63Ec1ZPHOAx9KGJJWSYCsnp6M1EipyjL3/ZFsZjhIm1qEdGOu/eQ4JONL/pZ0GtY=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by LV8PR10MB7919.namprd10.prod.outlook.com (2603:10b6:408:203::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Thu, 20 Jun
 2024 17:08:41 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%5]) with mapi id 15.20.7698.020; Thu, 20 Jun 2024
 17:08:41 +0000
Date: Thu, 20 Jun 2024 13:08:38 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: Benjamin Coddington <bcodding@redhat.com>
Cc: cel@kernel.org, linux-nfs@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: Re: [RFC PATCH 3/4] nfs/blocklayout: Fix premature PR key
 unregistration
Message-ID: <ZnRiFp7sSc1S2wp/@tissot.1015granger.net>
References: <20240619173929.177818-6-cel@kernel.org>
 <20240619173929.177818-9-cel@kernel.org>
 <D3359408-4D02-415A-9557-19A6EFE5DDCE@redhat.com>
 <ZnQ927sF7oRT+KmF@tissot.1015granger.net>
 <F421047C-FACF-46EF-9169-07C8FF5FCF3A@redhat.com>
 <ZnRO8BA/TlQjpCmg@tissot.1015granger.net>
 <762051B8-1265-42BA-8002-B4BD4E117488@redhat.com>
 <3590D3CB-E9C3-4C78-8077-7458F9E6C966@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3590D3CB-E9C3-4C78-8077-7458F9E6C966@redhat.com>
X-ClientProxiedBy: CH0PR13CA0010.namprd13.prod.outlook.com
 (2603:10b6:610:b1::15) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|LV8PR10MB7919:EE_
X-MS-Office365-Filtering-Correlation-Id: 28f4c431-6671-43ac-632f-08dc914ba282
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|1800799021|376011|366013;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?zm9FFkMZLdDL18nSDCS1E61WN2uhJMRX1yr/KIRrF7HFqjAqUWE5QFy7xvN1?=
 =?us-ascii?Q?LHmKiYxGVSySvScjwNv+sutjcSdBzKd2ONFCGXkOjpuOhe9SHIvLaHFG3FPb?=
 =?us-ascii?Q?muMOIv9Gx1hBMSFNeb0vagKM0KicMcaPk2KKQ1pwnqGAwMfy/iWuBEf7YlV4?=
 =?us-ascii?Q?1WqQdDL6ld2h90mXg9SNYsKcHCh71AhZpOevNDn/o2W49SbkC5+nnAcml9Mm?=
 =?us-ascii?Q?DIAXlJhjWou5nX9LPklB/uronR+01oWTO1vkKKk+ICJqdT3Or9+t1eE1SVd0?=
 =?us-ascii?Q?ENbtMbVtX/lWcFKyqfbn/AvRusFMmPmS7hLYlbx+IXrPIwilCCe5noXkiY8G?=
 =?us-ascii?Q?nd1qB6TCN9IoDxFoRusPPFlx5jXOWZI6Sxi+yAoMOVT/WQkWTHvKVyUld2R3?=
 =?us-ascii?Q?zZ3N5Bi5en6UbGkisL3/WYxdPJ/rmNwIw8igrU4Zb4sr+TjfWmmjLzodj3XM?=
 =?us-ascii?Q?PSV/X9op14sgmy0kY6M8E0wlYWJd+QmBHpbgUWpULyNQ8F3WIgWdEWw9JjK+?=
 =?us-ascii?Q?C0QJDRNiJzRV1T+wWmgk9mg7lYAo7jzSscCBgw+M6pKpE/gFxcYR9MRhXWUh?=
 =?us-ascii?Q?jcU/HK2IL7KYZ8EJINEgtO0UltZIo/cJChZwhFT+0TT30dmY9PW0xj4rAigm?=
 =?us-ascii?Q?9Dz1yvWbcAf00X/J3KLHnYXGystitQiTRN0+L5Vs9o2Z1IPXud4zmHSi697r?=
 =?us-ascii?Q?hAoWxGkL/X5RhNecIN++/AyrmJcD9LXL+OI85La/PCNEcvKAgWjUDMzSbgvg?=
 =?us-ascii?Q?WgXKxMduSOpWj23zIbzT9wwoPC4vS8KEbxvcRFjQSTVbVYCbckdoBhdxTVdv?=
 =?us-ascii?Q?aRLB/SwyZZcVFHLDKT/J3dGNiUJE/Ic8i4xqRbaRbzH2Jvud+tXl9VGgQXu8?=
 =?us-ascii?Q?auSrM0wqR3x/5JV372qhd4qauQsk75g4Z/Pxg2GbYxUIZGozICQhgOcIJ4Aq?=
 =?us-ascii?Q?Yb0R6RakT8bTnEOFvcPmoCF/CxYzXC82cRXYLo2RImop0v753OYpUjHcGY94?=
 =?us-ascii?Q?287VfIeCz9tPzn6Lm/fNd4w/gqbLk2GxgIrkV7QK4vh1PTLCL+pDhfdJYoI7?=
 =?us-ascii?Q?PLojzFKm0hdjafUfecy0k1D6SLgll6tpBXv+bvfoSkth5ogj/nMFntGI/Fvr?=
 =?us-ascii?Q?2dYUb68dyApc0tCmTzOGXbcXpXoOGUJN2vTXHmUWTWCMU6LMtgNp6v6P+B1N?=
 =?us-ascii?Q?efVSrP2TTXOGK6Ff7IB+ZFzvxXWwBoLXmlPKfi1B/spZSB7o9i/U32spbi8+?=
 =?us-ascii?Q?XCI9rdszVBT4uLqCuG5RlSapGzoSWYqCebUbcRbBJUyyC/lfw8wtzfAs9lb5?=
 =?us-ascii?Q?tYuHwSwi+Rj3sljqTLvZb2HZ?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(1800799021)(376011)(366013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?sVDkYNSgbJBpSKWYg1GefUdhO8fvLLoOMkGk1u0gx2nzvLw3V7A9jmXRlqmE?=
 =?us-ascii?Q?ZPof2ZffbAyjb9um8mN/v0T+M1Gy334w2cc5tWgmhaiPfeR31G37Ne68xkec?=
 =?us-ascii?Q?sLmXeKb3zEkWatePOart6OrfURN2WV1uQ0DJwQUFq479naxrEFsWCd3Z6TPm?=
 =?us-ascii?Q?9Ca+/J188ZZgsTCHntQMoSFbQrQpo6jJ4Go41n+ntFRULCZuu5Uh1qOJ6xKR?=
 =?us-ascii?Q?SsMAioJrAjSRqNDHL/CQKTK60DSTgMXB3t+3JPObyoAnHI9nzVvj6MuHqFyD?=
 =?us-ascii?Q?PapXc8Z11i7A4NFhvqkyFGGzNhpDlUw1bbY73TSS9XyAsa6ZyVx488dycxh4?=
 =?us-ascii?Q?m0zZbbjguh0Pd+CcighIDj7NcKFHVx9jVw4oMBNEOPTyXRTe0niPPlLEnwPu?=
 =?us-ascii?Q?sH2n3fVbiBJjfkn11XBpPxlyjs4W2Sn3Ip0Czpp4Iah18hCLysoQ6OuNQE2u?=
 =?us-ascii?Q?LgTWurwJCnE9C9EzNawC8622aeE5y4dCiMsXZ9eLczDBkhBcK1CRNaRu5w96?=
 =?us-ascii?Q?0fTpuiI2FsVehp1SYWEZFj7TFHeho280pZokBfPO67g3ZNkYZfmTvoB0PRHk?=
 =?us-ascii?Q?h6oMYrAuH8k873nE3nchCqCpdhlvlY4zy8iVgPoWt8TNci9ymWTu1JTrmA6y?=
 =?us-ascii?Q?2Isp9EGUjxnTqHwj6O9i8IUf/lvzvVdEGIOqVjRt6AP3kIIpG+482LhEKiDR?=
 =?us-ascii?Q?+bIF4KJpLxaLiisfRtZJn7tW5J5pxD5MISTsPP2wNsnmPOhIZYNVyOL5S7N/?=
 =?us-ascii?Q?ZYlow+MeqUqYpdsPEYNSG4D7wtLxcXDl3Yer9kw4W8xxmJqZtwKtERWdTsfW?=
 =?us-ascii?Q?im+LP+vHugBCZ7j1xyCk6IMD2DLD3FC6/E8ZDmcqOBGyxWAdTcOK8EbaOC3X?=
 =?us-ascii?Q?FS6dFUO+4wh5cI8towNMj5LmcC5efQj2AVdqHkybuJfgGSWTWgtGrDaSh9Qp?=
 =?us-ascii?Q?RV1jsKF34EcRhEKyzpLm2HAnzDinyxEdWTXf4dQdIpWX6/GROfm+itqVCCQz?=
 =?us-ascii?Q?jZsUpRPzT92MrbNT1yXFqSguYEogUhLrBInh4dNIOiBxHhckuL7c/owN9ese?=
 =?us-ascii?Q?ia46G8y4xGHpkek91bRTOLI5xqw8Ehh+Dq+ZaaS9sgh9NgGuHEGk6eL/g/Jy?=
 =?us-ascii?Q?Ha+B803WGQFpmHtsRMOg/FULh7NZggM3PgBb1HO2FQ5m35niZsU7uP631+q2?=
 =?us-ascii?Q?YB6KYa1gYMd9s3GzBT79Z6czAu41DEu/fAQAESEuUhvvk5UiScvI1p06w3LZ?=
 =?us-ascii?Q?9wfbZYAIsruUmgbq//y/O4CiAFDF+M6+6RwwLnKuZLvJWZZ26vjzzw93N+4n?=
 =?us-ascii?Q?nGAtMqLga3747xSiFD5PZHwhMAFJTdWlvp48NrAurv8gGRrOZqW6N9zFK/NW?=
 =?us-ascii?Q?G2NBdlo/Ki0eSL3f8RSK3/4UPppZpCU2HqadIpeuzairujaglRx3ISk2+ZTn?=
 =?us-ascii?Q?h/F3bslb2jARPHgbC5Fp4K2uTLKmVuvQBEUH6vC9vZ17OIo6DCyQcQNZKeEa?=
 =?us-ascii?Q?HvQA7WpLqY85olgV4ThbNxsaX9Uuq7BEa2qvHSo/QgseyJnmUHBSExRm87hi?=
 =?us-ascii?Q?SUlcls1po9Z6MBIhcI8EZYBY9Ezqugd4Pe7aqb1AHM2+OSUyEvUmS89UXQPh?=
 =?us-ascii?Q?rQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	LxBivQdE4r4/hHq1eMqkGOzYB3hFApwdZT+c8awHZJvVaJr0P+VDY/1hQwoqZrbtMo/bKU3ZLyuSuVcRhQm3djkUgdGJF/G0alOAQoYfeM/5UQcAZ09tPMKM/1Fh+h8O9Wr7EO0z0YV6ODwQ/yR1hJx0+ZrpMmgsQpfBBhpX+y4z7fkmZGqugcauIyYcvNuG2COZgBt470eaShgWjOr7Mm1rJwRqui0L6lZSnBgjbgklcSTTHkOghFHJ93q2q3nLJ1ra8ZZJ5ZEG8gvgkbj5lA69oj6MVfSmd/WgMKDGHE8b+yJaDKKUXWJb0tnvse980Mq56nkzeIw7a+z9sFBopw2PdykcFbAi4mYa5Q4dWaWyOY1ubkVUayQS5do75dZTkcPB40xgf/v1d0KLlqa9ts2yjXRy7iHEXvfIMISJEG1Qh1i8jqw1Zo9DxukRobKCHKJMoINB/6D7o3OBPiOtOqN6v1Zvq/mSYj2zfUHkZXnn7YcHsnVAVGRkQBQ41Bi1S3xjWacthn1JLlkoTLX+jK3K8G91z/LEljMYKmJQq5QLVCUSwUwnDigRQ88H/0QL8XZVjHZ6jmK1wFz69meyQBiTq+2HvxpWOXQ9PI+dEHg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28f4c431-6671-43ac-632f-08dc914ba282
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2024 17:08:41.6269
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ma9Py94R1HXJsSbsWG0UNl3kGSltApCf91K1JZMQqkP2QntGyEE2q0FLXbHDzRQXQMw9nCN2TBTTzsiXmbEvJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR10MB7919
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-20_08,2024-06-20_04,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 spamscore=0
 mlxlogscore=999 mlxscore=0 phishscore=0 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2406200124
X-Proofpoint-GUID: PJjCxJ7JVb5h16zwHAinUpAXXsSlkyx-
X-Proofpoint-ORIG-GUID: PJjCxJ7JVb5h16zwHAinUpAXXsSlkyx-

On Thu, Jun 20, 2024 at 12:45:56PM -0400, Benjamin Coddington wrote:
> On 20 Jun 2024, at 11:56, Benjamin Coddington wrote:
> 
> > On 20 Jun 2024, at 11:46, Chuck Lever wrote:
> >
> >> On Thu, Jun 20, 2024 at 11:30:54AM -0400, Benjamin Coddington wrote:
> >>> On 20 Jun 2024, at 10:34, Chuck Lever wrote:
> >>>
> >>>> On Thu, Jun 20, 2024 at 09:51:46AM -0400, Benjamin Coddington wrote:
> >>>>> On 19 Jun 2024, at 13:39, cel@kernel.org wrote:
> >>>>>
> >>>>>> From: Chuck Lever <chuck.lever@oracle.com>
> >>>>>>
> >>>>>> During generic/069 runs with pNFS SCSI layouts, the NFS client emits
> >>>>>> the following in the system journal:
> >>>>>>
> >>>>>> kernel: pNFS: failed to open device /dev/disk/by-id/dm-uuid-mpath-0x6001405e3366f045b7949eb8e4540b51 (-2)
> >>>>>> kernel: pNFS: using block device sdb (reservation key 0x666b60901e7b26b3)
> >>>>>> kernel: pNFS: failed to open device /dev/disk/by-id/dm-uuid-mpath-0x6001405e3366f045b7949eb8e4540b51 (-2)
> >>>>>> kernel: pNFS: using block device sdb (reservation key 0x666b60901e7b26b3)
> >>>>>> kernel: sd 6:0:0:1: reservation conflict
> >>>>>> kernel: sd 6:0:0:1: [sdb] tag#16 FAILED Result: hostbyte=DID_OK driverbyte=DRIVER_OK cmd_age=0s
> >>>>>> kernel: sd 6:0:0:1: [sdb] tag#16 CDB: Write(10) 2a 00 00 00 00 50 00 00 08 00
> >>>>>> kernel: reservation conflict error, dev sdb, sector 80 op 0x1:(WRITE) flags 0x0 phys_seg 1 prio class 2
> >>>>>> kernel: sd 6:0:0:1: reservation conflict
> >>>>>> kernel: sd 6:0:0:1: reservation conflict
> >>>>>> kernel: sd 6:0:0:1: [sdb] tag#18 FAILED Result: hostbyte=DID_OK driverbyte=DRIVER_OK cmd_age=0s
> >>>>>> kernel: sd 6:0:0:1: [sdb] tag#17 FAILED Result: hostbyte=DID_OK driverbyte=DRIVER_OK cmd_age=0s
> >>>>>> kernel: sd 6:0:0:1: [sdb] tag#18 CDB: Write(10) 2a 00 00 00 00 60 00 00 08 00
> >>>>>> kernel: sd 6:0:0:1: [sdb] tag#17 CDB: Write(10) 2a 00 00 00 00 58 00 00 08 00
> >>>>>> kernel: reservation conflict error, dev sdb, sector 96 op 0x1:(WRITE) flags 0x0 phys_seg 1 prio class 0
> >>>>>> kernel: reservation conflict error, dev sdb, sector 88 op 0x1:(WRITE) flags 0x0 phys_seg 1 prio class 0
> >>>>>> systemd[1]: fstests-generic-069.scope: Deactivated successfully.
> >>>>>> systemd[1]: fstests-generic-069.scope: Consumed 5.092s CPU time.
> >>>>>> systemd[1]: media-test.mount: Deactivated successfully.
> >>>>>> systemd[1]: media-scratch.mount: Deactivated successfully.
> >>>>>> kernel: sd 6:0:0:1: reservation conflict
> >>>>>> kernel: failed to unregister PR key.
> >>>>>>
> >>>>>> This appears to be due to a race. bl_alloc_lseg() calls this:
> >>>>>>
> >>>>>> 561 static struct nfs4_deviceid_node *
> >>>>>> 562 bl_find_get_deviceid(struct nfs_server *server,
> >>>>>> 563                 const struct nfs4_deviceid *id, const struct cred *cred,
> >>>>>> 564                 gfp_t gfp_mask)
> >>>>>> 565 {
> >>>>>> 566         struct nfs4_deviceid_node *node;
> >>>>>> 567         unsigned long start, end;
> >>>>>> 568
> >>>>>> 569 retry:
> >>>>>> 570         node = nfs4_find_get_deviceid(server, id, cred, gfp_mask);
> >>>>>> 571         if (!node)
> >>>>>> 572                 return ERR_PTR(-ENODEV);
> >>>>>>
> >>>>>> nfs4_find_get_deviceid() does a lookup without the spin lock first.
> >>>>>> If it can't find a matching deviceid, it creates a new device_info
> >>>>>> (which calls bl_alloc_deviceid_node, and that registers the device's
> >>>>>> PR key).
> >>>>>>
> >>>>>> Then it takes the nfs4_deviceid_lock and looks up the deviceid again.
> >>>>>> If it finds it this time, bl_find_get_deviceid() frees the spare
> >>>>>> (new) device_info, which unregisters the PR key for the same device.
> >>>>>>
> >>>>>> Any subsequent I/O from this client on that device gets EBADE.
> >>>>>>
> >>>>>> The umount later unregisters the device's PR key again.
> >>>>>>
> >>>>>> To prevent this problem, register the PR key after the deviceid_node
> >>>>>> lookup.
> >>>>>
> >>>>> Hi Chuck - nice catch, but I'm not seeing how we don't have the same problem
> >>>>> after this patch, instead it just seems like it moves the race.  What
> >>>>> prevents another process waiting to take the nfs4_deviceid_lock from
> >>>>> unregistering the same device?  I think we need another way to signal
> >>>>> bl_free_device that we don't want to unregister for the case where the new
> >>>>> device isn't added to nfs4_deviceid_cache.
> >>>>
> >>>> That's a (related but) somewhat different issue. I haven't seen
> >>>> that in practice so far.
> >>>>
> >>>>
> >>>>> No good ideas yet - maybe we can use a flag set within the
> >>>>> nfs4_deviceid_lock?
> >>>>
> >>>> Well this smells like a use for a reference count on the block
> >>>> device, but fs/nfs doesn't control the definition of that data
> >>>> structure.
> >>>
> >>> I think we need two things to fix this race:
> >>>  - a way to determine if the current thread is the one
> >>>    that added the device to the to the cache, if so do the register
> >>>  - a way to determine if we're freeing because we lost the race to the
> >>>    cache, if so don't un-register.
> >>
> >> My patch is supposed to deal with all of that already. Can you show
> >> me specifically what is not getting handled by my proposed change?
> >
> > Well - I may be missing something, but it looks like with this patch you can
> > still have:
> >
> > Thread
> > A                           B
> >
> > nfs4_find_get_deviceid
> > new{a} = nfs4_get_device_info
> > locks nfs4_deviceid_lock
> >                             nfs4_find_get_deviceid
> >                             new{b} = nfs4_get_device_info
> >                             spins on nfs4_deviceid_lock
> > adds new{a} to the cache
> > unlocks nfs4_deviceid_lock
> > pr_register
> >                             locks nfs4_deviceid_lock
> >                             finds new{a}
> >                             pr_UNregisters new{b}
> >
> > In this case, you end up with an unregistered device.
> 
> Oh jeez Chuck, nevermind - I am missing something, that we check the the
> new{b} pnfs_block_dev->pr_registred before unregistering it.
> 
> So, actually - I think this patch does solve the problem.  I apologize for
> the noise here.

Thanks! Was wondering, because I thought that was exactly the race
I was trying to fix!

-- 
Chuck Lever

