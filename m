Return-Path: <linux-nfs+bounces-3069-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 195DC8B633C
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Apr 2024 22:10:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF66828114E
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Apr 2024 20:10:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D6F2140E50;
	Mon, 29 Apr 2024 20:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XSLt0azi";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="eY6BPFYw"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFEEB13DB9F;
	Mon, 29 Apr 2024 20:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714421412; cv=fail; b=IT3QH5dRBwMbAFZ8dN62cu7SytwxBqUQYtTUykkGbSEbbHDdOSfCVidbQBbHvq0dblqzb8K32jhWArKfMQg0orK8UZvreAw3tVGKNGxhPseFVDwUeZBBffEf3OAapaU5wogjzD/3zFcLJ/FFrVAEQNtYNBsjFhhVjWsSQPLEE8c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714421412; c=relaxed/simple;
	bh=ir1mZLHLkGz9HHJgtXukleN7HPYX6jByJ3ESbQ6ks+k=;
	h=Date:From:To:Cc:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=gRX4f1XdFmihuyTwfYMGJ67MrFSsGda8+rLmQW61cVSRbBZ7S9sDFQ/plt8vO+WUEMmKG8dwPPqDdWsfLY852uASX8XTZCKN/QrKHvh5QYbx/zXyhChSmFzLre8giY1t4bZFDbMkvEWXmi7VQ2ZhPZmd/87tKkovT3RA0HMb8w8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=XSLt0azi; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=eY6BPFYw; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43TJ3vnU016891;
	Mon, 29 Apr 2024 20:10:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2023-11-20;
 bh=1b/CTnS7Vmjw9Wl/jQ/7eLlRRisrsrvAcqj+8FRIn2I=;
 b=XSLt0azi6oABUoS6hx2S5/CwOThLL/w9kf+kMsPPWq9l10SUNwu0XYMWlpzy+FWAxbWI
 wXZVmK0IWwjSOo7jK5pPXKros6x8QDE/l5WpXTbjMaOkUCIQgBsxbej2Dds/vlY+t1mW
 cZVXC2zKDgFycMSpJwHspiDHVTD0I4OfH2CW67W924laLhq00rNZNCGH85QCV7gHifR5
 8NFOm4GRU0IKnpAppnPGn6ZFloHAmYZdvV6tLxOCaFNWL+YH5+W4N7LBA1t1FH4ejbkc
 3X1L8uef65B20ASzusNFPlubxQVHM127peIjW1g9cyHAz7mO490xZoOPXF5s1CPC1Hak gg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xrryv3fn1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Apr 2024 20:10:06 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43TIUS6C033276;
	Mon, 29 Apr 2024 20:10:06 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3xrqt6mywa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Apr 2024 20:10:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jq6bFSIGimv/HgBEw/HpS6T1GgPvweTQime32xcVqaSjlhZZpxvlJjC1zoZXP0qs+v5/jLLK57cspsWBzU3AGwVlO+bxBwo9MkNzszdGBOsWBd23pCosO0Vd5WZTzSuhOhtuwriLz/qLOxSoGtGy2XW+MLL9gwupDypF9MBRprS5P5nnslZrNF19orj1l1g4XRLGSOfZu4+3YOc8TQxvilYnYwBmSD3Na/RlNXy2G68Tpgsiqj3yf2unpbXeF7WNhAsg4wNbjBOh1Tu2Gw5C+pKickki3I43f9MSPM9oU6MX1ZVdRO/UkD0Vu+0AcndQnB90eUZ2uSH4EjiaqL18lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1b/CTnS7Vmjw9Wl/jQ/7eLlRRisrsrvAcqj+8FRIn2I=;
 b=SWNlW9q1JZ3Plmfna441aHDxj+0esH1ibvsyBuGxMACs82KH3cMlU5L+mjnFXuY8e57+PjiBaqmqB8qRvHHEdGx/FgF8d2VeBzME4RZzjadhWv/OlIK58nr60djJX6wqDY9mmWgNFUh5/LwLKoBQeI5s1rEWBAmqVQ6buBsRRKj2ZcUHH+QBvIfDRxyTvI4qvjJGkRnpQVB/C/t0feW751tp+MBh9yXQdU3BtwvotvjdEe/p6bG4UsfzgQrTzdJ2OIJg+3FNdIa+HgN7Qa9ZR9MeH0T4Vg4X7AVLkBXa+0jAPgzeFoFQym+ynvTolNjrdCFi1g+aQLTLYxgOe7jgrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1b/CTnS7Vmjw9Wl/jQ/7eLlRRisrsrvAcqj+8FRIn2I=;
 b=eY6BPFYw4OvyjzBJalx8h5zSEfpAE3X4TfmFLVK4pL2rdUD5s7320/b5noaoLM319iEqkvHcijdz9a8MXW2BMBpNhnW4odj60HE1u8UhnJtEKx8ZWXRi+Gx1ut3KMfLxM9BBLxKdpPB+fYHp9DqRxbZ42Vyyf3gHf80INkejM24=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DS0PR10MB6917.namprd10.prod.outlook.com (2603:10b6:8:134::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.35; Mon, 29 Apr
 2024 20:10:03 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.7519.031; Mon, 29 Apr 2024
 20:10:03 +0000
Date: Mon, 29 Apr 2024 16:10:01 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jeff Layton <jlayton@kernel.org>
Subject: [GIT PULL] 6th set of NFSD fixes for v6.9-rc
Message-ID: <Zi/+mXlrQ41AdK6G@tissot.1015granger.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ClientProxiedBy: CH0PR03CA0109.namprd03.prod.outlook.com
 (2603:10b6:610:cd::24) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|DS0PR10MB6917:EE_
X-MS-Office365-Filtering-Correlation-Id: 064fa27c-29b6-465f-088a-08dc68885b50
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?2NcNuUjS5V/27sZHDsp4AdTQv7kl+1wRoSpKwQTE6HypJBPTIkg0FkxE54iY?=
 =?us-ascii?Q?kQ/JBmj8e6Ti+dsY+VGUSI2BA7HKFHVClqLwbCQ3l0Mt6L3aAlTBwl6ca2Gy?=
 =?us-ascii?Q?Qcs1jVCD+ACn6eCBmPA+jyuSS/JMo1CYy2cAKhkwuqU7HwGVyIJMlIfgwSaV?=
 =?us-ascii?Q?acd0QpQzVytbgr7lst9UsZAcrYOBwgA0VZthVF+syYxsxInLmQqwHVRGdPD8?=
 =?us-ascii?Q?IqqGZHBWPFRr6mjMDsdxpjtL8LmZDcv5dVdkAPFpUTPmoYUSzPkLkMMAEgx1?=
 =?us-ascii?Q?jURBHj6+8y7+EbW04rNrAktDkIiQ2AntzszEZLkkQANT6LexlRTEP/vg7paX?=
 =?us-ascii?Q?3g70mRywuq8Dk1ltWNzCwbIQzUQEhpPGMdV8jQDp5FfNtzmcM0u9wsHlkojH?=
 =?us-ascii?Q?9aMf+fWBUh8X1VRFgHTu1rZlkfihdktuPAEdI0iXZNML89WLWoO7NEHc2ORQ?=
 =?us-ascii?Q?e8Q9NwoLEPoGCI0VQFE9axkh37oYyvwP0Adu10xPNh1qn6oB2KfPFxQFEIKY?=
 =?us-ascii?Q?xLIGaCL3zhu6rgRIIexhmaud2XlakuO8c2bqa5UtpSLelxVhvsRSakK7tfB2?=
 =?us-ascii?Q?wnjej2TUpcjQ064rKZqIikX9cm5WeGtrkYOgKNEwXxpa9rV1WBFZoLXk1MmV?=
 =?us-ascii?Q?5ADweYmK9PqNJ0pfyHf++x6Sx51O2uH34zpLZATUnz7PRsbBJ8bUX/oqxf7t?=
 =?us-ascii?Q?h3eFp0cVsYLU8oBPLiM6L0y0vAhqzF7JFvwB0KE1HW7CHr3u1LDzdSUiUQak?=
 =?us-ascii?Q?bobOIqlPYc+mF04fMAiQdJCpnoXtonEIDSMSsQcYQNs+45ladgaHJtT19gFu?=
 =?us-ascii?Q?A3bxEmOQs4/gOuVqta2SwjCz1mViK9Aj6VD9/uIENOCE2f+taF6WxZPTHFAc?=
 =?us-ascii?Q?eEDXCqt89zwebb/JKPiXYf+/fmzzHf24WK8mD+uq0Edo6qvE7Cyu6YKJZl/K?=
 =?us-ascii?Q?TXRr5yqDEaENYF/7qHd3Eel3FJgihV2sd2Zx18mqkobUQtNANKUUNWTkHdbH?=
 =?us-ascii?Q?19bOmhwI4vFUznJLdmDFMNbzV7hv9yezGzVlHRBreisCQJeRIYCDS9C82VGR?=
 =?us-ascii?Q?QiUKGnw+PT/fiw5f7egq9oefyHhZyv5P7xX78utPQ2Df7K2NAgkq7yHaBbjE?=
 =?us-ascii?Q?P6dKun4NucJ27FdFw+c4ECJLs7n4au0/uZUs9kJDOpOt+nJD92p8lIW0yEcm?=
 =?us-ascii?Q?86t51iuOQPjg1lsIltc83+CoEaUVVTE/tkvcHMUgvETtR+o6MHUZxgpIuICy?=
 =?us-ascii?Q?OYJN524FG22B+aXcZWIQ4WJIkRrmSH4qrU0EzcKm6A=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?QjC7U9mNxAh3jlVD/iMfu0U5QMe9/vS21HkrK8fXACnMC3WmrLrD2hR4xC4b?=
 =?us-ascii?Q?hz+4+gipQfBEgGzNZMCHcS2z6XBjCK/KOKSW6LGsCCAA3DYqmTN8Q0GHXdWU?=
 =?us-ascii?Q?EZMUki+ruOSXE3fb10GJuFYO5oRigp6iljfWaHH1aQotUVXq6PX7I2em7sHJ?=
 =?us-ascii?Q?ftLNIewVHG7dwq5aaDiVynQgyUOOLj6pCJZpWZVF5yU2QrpJQg/whoe+D5A0?=
 =?us-ascii?Q?AOeGeJX/1c1Gh9E/bfLdKuFslUxuu4UH9hiF3rBBQFEA31LhiBW3Rj2WkkVN?=
 =?us-ascii?Q?mP3lyKoUeFH18/Er7jxgSr4UZUa/V6kM9/3PmvdDstvF0MgEo0bmCNeyOAyk?=
 =?us-ascii?Q?fuLDKg3eR3eowNZZaIAtUVerK3t2AF+aPXCKDnYqxzWf/tWKYZ/vN/eHlQOg?=
 =?us-ascii?Q?AmybHP2TvQEorJRsi/aPVdAjJei71njhTvg8dC3w0cb7OTNjUNKrTCjqMoL1?=
 =?us-ascii?Q?Ikb7OsWTLuh7tkJSi6W8ynJQFU73dCfqiBvX7TGCKPr5gPgORzYD1+ovazxQ?=
 =?us-ascii?Q?UZpSjEEKHFkVslgD9ng6oTbmWVaTLz9nXl92fDG591mNg9ex3ovIdvUzzuOY?=
 =?us-ascii?Q?wzCjSpFAYpd/1bCF0TXkM7S/eCdVyBcHJn5Jvr+IXY1bOn/hunvpFJRI0JcI?=
 =?us-ascii?Q?Jwq7GmdnUUY5kCrfkNCWiZ0Pbgjina/FooS0DjmuKcm2Yj1WM59aF3gy6aTQ?=
 =?us-ascii?Q?q7lMSKJUYEw3m8zFYVqkxL8p/vGit/u9eQ13WzKJ+F1Qos5rK8ZYZbFUaq1O?=
 =?us-ascii?Q?svi2dtK3q1hC/VWXcXy8ok9uK5RiW1wf6B/2LDbMPXFZRwSbZsNezOTfri3/?=
 =?us-ascii?Q?tfY/duDvNoDVEptoSQoqGaylS/TJIhzxdu7e3s9cGPcJtQkNObqxzrto5dDK?=
 =?us-ascii?Q?+dYPIpbke9F4kitRdTT9A8M71AZ2u8OvmFtLF1dVIKaO6DxXGykld0uIhmDB?=
 =?us-ascii?Q?FlWEIY058uD4JgfDuaJn/OlcRsJlrXUXcgx/ZM+uB76sRu5wGTgORHxdNhk7?=
 =?us-ascii?Q?JfVhTlZiaOKGNhIzNfKaFk+88H0m9pemy77DU6PY5IDWBZs5W/1d4a5oYKbb?=
 =?us-ascii?Q?nrZ3ogSwDzhMuo3ezv7N4Wgr4nAcn2zQnu6vlGwCc12TdfbsehknoqujmM1g?=
 =?us-ascii?Q?XrVsTpOEcbcElhFmc70d9lQY32gdK3ZMMXzzQ848IiX8i9XJBZHSYYcm0+m6?=
 =?us-ascii?Q?7eYXZYi+Nxwdns57r0k4bxUNZpgY0yfxsZf+ik1AEiOZcevaFiybnL+auxfd?=
 =?us-ascii?Q?S2K4e2ulguUMTD6yN0PmYc8QeXOJ47J4SKMhmJ4BguGPTtMw0MvomiaY8/MD?=
 =?us-ascii?Q?SgxpUgbQBT1vV1I+fzQT2YrSz55ftwtZLnbFrExC+wH02Kmyhh8JUctqjolB?=
 =?us-ascii?Q?DdrTt4lVWpu6fmX2ekn+oENzOOu9tEtKt26dKnIPU0JN0/sFAHjek0/XtYjZ?=
 =?us-ascii?Q?FqEJjgECKP68uTp9pUaQ63bVBJFLuD/L7nT1RL1e+CeH5QrJDnO8AN9HH4Ci?=
 =?us-ascii?Q?dI9IuDh26dKP5XDB0Abrhv3l95707zXGdA/Lc9cbmG7511vqz0nhIu4ZlCct?=
 =?us-ascii?Q?qQ/yQDfRIefyoDD2bO/ffQIh5ZATi5Exu0ul2+1vdhNT8N0kYbq6F63oKIXB?=
 =?us-ascii?Q?cQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	y8Iv+RM4jpuqjwISTAQD0hY6vhqwpm2LH0zKBirK0440qIx/V/22Q0L+Ig/jCkq5oRd8wWMlLKd57SlvdFWQyftmVNKx0YLN6P/L4Izcksn8eEni4+4u9tT0ztej6eYg63lAvOCjj7lT7EQjly7pUMTCZZudQh9DlBvlwBPk6CoixbKSk00jIsSucy6hxWONQmpqRZXQSCSSXwUB8bLrO7L/49i1Km8ullhPzH52AgltU8ZmMtseWyJ1e0aEA+eGqsTouwKMohNpjm7kWP6t9/b7phQ9NvklYYDEkesFwTcgue+2RHYIXyNtciBWALK0D2SZd4eUqMziJqAiF7u1JIslGTjTgbzRuM4eskn5H6FWTAZQgJkkeyzCLVWCgAyh0A3ISCAOQcp5Azopz2DJck0wJfQmXf/Ex5g1xEvNPL5zuoR8kox461gUCEAspU1s/+688oQfXkW+XXPY6NfYRDNty+NzhX52PgMCJHA8HbtwKS2yHfzvWO+mz8Aem5nP6GK05L+8dgS1i2BZyb1H7K5mDl+4sBML1ha4y9tsA39JXlHyHkFKd1XL3Ac0ba1VSTtjQfHNMCQ6oS7mBvNwFgZc7czpizzQ2vJD2/Hdsss=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 064fa27c-29b6-465f-088a-08dc68885b50
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2024 20:10:03.7470
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BaykObiFMpzWNXk6EcEoCBuDYlRngftl+hydvWX0c35xYTqVRtwVecWixhHtPQbAMNsVU/XlZh82ZkexKSna9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6917
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-29_17,2024-04-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 bulkscore=0
 suspectscore=0 malwarescore=0 spamscore=0 adultscore=0 mlxlogscore=852
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2404290131
X-Proofpoint-GUID: rNkgDj7AjLFG1AgomXEazK5lUp3xSYp0
X-Proofpoint-ORIG-GUID: rNkgDj7AjLFG1AgomXEazK5lUp3xSYp0

Hi Linus-

The following changes since commit 8ddb7142c8ab37371c6fd167a8aded97922c6268:

  Revert "NFSD: Convert the callback workqueue to use delayed_work" (2024-04-23 20:12:41 -0400)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-6.9-6

for you to fetch changes up to 18180a4550d08be4eb0387fe83f02f703f92d4e7:

  NFSD: Fix nfsd4_encode_fattr4() crasher (2024-04-25 18:06:41 -0400)

----------------------------------------------------------------
nfsd-6.9 fixes:
- Avoid freeing unallocated memory (v6.7 regression)

----------------------------------------------------------------
Chuck Lever (1):
      NFSD: Fix nfsd4_encode_fattr4() crasher

 fs/nfsd/nfs4xdr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
Chuck Lever

