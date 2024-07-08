Return-Path: <linux-nfs+bounces-4721-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CB86692A612
	for <lists+linux-nfs@lfdr.de>; Mon,  8 Jul 2024 17:49:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A55B1F21705
	for <lists+linux-nfs@lfdr.de>; Mon,  8 Jul 2024 15:49:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D874139568;
	Mon,  8 Jul 2024 15:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="eMhqALP4";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="h7Gi58Ia"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 382BE1EA6F
	for <linux-nfs@vger.kernel.org>; Mon,  8 Jul 2024 15:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720453757; cv=fail; b=E08prNt2sGI7rtc4lkPHUHwQDLeIZApAnCtIc0R99wNsYuDXBkPkuy+Of6EA3+PQ0FzL6OSkuCElQaeiEk0YTXCpTZz7wIdtgjtEVioWwZYoFHuDzoB6bGKw2R6g3g6MpngZ1E7jG1fDaENCtFbEWXhv+ixEK/VbcdUilp1PvR8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720453757; c=relaxed/simple;
	bh=GsY4JWSwo/v0VtOLVPTivbnvXQjup6PuN7JCPwHmBxI=;
	h=Date:From:To:Subject:Message-ID:Content-Type:Content-Disposition:
	 MIME-Version; b=rWF3YSYnWIDGHU9o0Tcx3y6WdkCGPaH6Bj0Xt7jEggJT8n/eXQrbLuD4LKoG0xzd2r8VM8jmslCQuoTPsE2tXGpjTnVbT4i9miUb4eLwUkiHBgrlIjx2fgV0n388EbFPtEPDnrsGcwduCwWJuQACZG4F7bEcN3zjKchM3bcSvDQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=eMhqALP4; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=h7Gi58Ia; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 468FXtRr004189
	for <linux-nfs@vger.kernel.org>; Mon, 8 Jul 2024 15:49:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:subject:message-id:content-type:mime-version; s=
	corp-2023-11-20; bh=JfSxNhc18J5DUhhY2WqxX+Z8dbRicOl9+0ZGseSZ8zc=; b=
	eMhqALP4Sj9lIxvnfPJFs2mHsJwugF6I/r/7vZRfJ0bBWFcGUHLiPQbMFW6qXHcd
	t7WvVpXmSKrrZbFLaPqVONrExgERTFhMmQzi4I0iDumffxnUZg0Upklpwbl/Ft3u
	G/qGU3diJ+KMNheGw0HS45LNdBmZSqBHv8nlUDFid6kMKtq6VfU3M1+3v9ZGDdxL
	5+tzVwAsPVfvIuhJbnH+c5zPvF5T4Cj2bOcgkAspgdOCb0exR0r/XHDfmL9aFRDq
	yEu+4CkGQXIAcngkiSnx14tF/9mvWzAy5bLycrwGYs8NIzxT3awB2LIqPNsU2LZw
	9urH6LiXXbplZz5OZQV5Cg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 406wt8ay5d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-nfs@vger.kernel.org>; Mon, 08 Jul 2024 15:49:14 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 468Evkfr014344
	for <linux-nfs@vger.kernel.org>; Mon, 8 Jul 2024 15:49:12 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 407txfkdgw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-nfs@vger.kernel.org>; Mon, 08 Jul 2024 15:49:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DH/9Z3a+S9TabdB2XumL6ur011Uu1sK3T4t9K0PnNIyyR6iNbz0HfTONsV+2A75DwdVH+Bf7ExckwX3ZV73nUzpZpL9jEgCeh53lv9JVgMl5P3zf3CZ29TPRMO8xRa5WbB2L9HhrKRP/pH5tD1oT/oqVhDxnNxdghs9rZoACI7ak7ADEFob/tQ2LwhezjxVFGFeXivCj8YNkMk8d8/6YhGbtar4XbaVlrPjOR8NL2rGj2PzDjxsuM/C6DSx0MdJxSWBM/cGhvq3zM0s2Qf/+Dt7MGq2Kvf32W0wYXYE2rK302usf+xbRAQc3vKCOVw47RXmxRdHXvn9Dk+tZtXN8Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JfSxNhc18J5DUhhY2WqxX+Z8dbRicOl9+0ZGseSZ8zc=;
 b=IjdtRMvZOj8NggXH9Mr+tGKyYjNwKW+BNmDayFLpLYHQA+SKOLUez4UifC27vWTvQpTsGhsOo/dDPBJcYdHj3r5ePURA1GQfoQs0ZQca9VaW622d1c2ARxpDA1oGvLPysD6bESLdvPLH8kAjDR7PJML+Kl2ICdA68yW361IrESauQhM1q83A/DyzpwRV0STRh1mFE3CdXkglWm4k2ffRbxQ2g39bvenquhh7Fv4y3Mklxn+8IIKkNNKkb5fGZAEafoqBHIws0hlBVP+4jjvPJinQecN5ljGH/Oz5eyid1+qAOEPS/TbBspL5i252vlKD9OSNtSwTiJdJXZjs+XbH+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JfSxNhc18J5DUhhY2WqxX+Z8dbRicOl9+0ZGseSZ8zc=;
 b=h7Gi58IazJWGpef+P1jTbpuNffOpQ4lZBxZBUwxCxNL8IMbZK/tu5uu5iLft4up4iyZIW3dIdqtNLuzUVbRTTYFW6CgDjPkvN4JJMYLmz8/MmiIPvwIg/AvQIP6gIQ0DVj0u6Fb4kqX7c4qTmk4Bp8nc2ywkF1+NzjNQbnZy914=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CO1PR10MB4738.namprd10.prod.outlook.com (2603:10b6:303:93::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Mon, 8 Jul
 2024 15:49:10 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%5]) with mapi id 15.20.7741.033; Mon, 8 Jul 2024
 15:49:10 +0000
Date: Mon, 8 Jul 2024 11:49:07 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: linux-nfs@vger.kernel.org
Subject: long-term stable backports of NFSD patches
Message-ID: <ZowKc26/N0vOjxr+@tissot.1015granger.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ClientProxiedBy: CH0PR13CA0044.namprd13.prod.outlook.com
 (2603:10b6:610:b2::19) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|CO1PR10MB4738:EE_
X-MS-Office365-Filtering-Correlation-Id: 3cc00130-63e9-42df-9a4d-08dc9f658207
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?1Z5rZcFheG2g/9Mk7AaCwW6qcxjfogeeRDPO5ovEySeQGWKrh84DlI/DdyEq?=
 =?us-ascii?Q?qfwUqyyzeX/X1KoWdSdZVL2RnWKoFMUeqUyLeuZSrxnpD3cnLQuLfmbpQY/S?=
 =?us-ascii?Q?YTuvqxsO+WTZqtcOkkG0iQ5aqKiSUWenzr48CJOuf0WpdeSsaj0dC2SRm7st?=
 =?us-ascii?Q?GPBAL0TxuXcJp4ERDW8SOimz7rvsQIVPHwC5yXZ42Eq66sfGr1JCmbfwYNE4?=
 =?us-ascii?Q?HWw2uCy2jQKGmB48XqF5AOYFxDTRHEej4k+SpJtsOll3c/JNIb+zovoYkcn3?=
 =?us-ascii?Q?14OCm6cn8YIe5ozC9Gus0GImQLLpCbhPIrZ15eV1s1McnbYXJvG9m8AHj/NL?=
 =?us-ascii?Q?BvjgiSfII6V7S/cyb7Lcue6K933yNSEH0mZEL/I/tzBjkITRRdmyuCZJeXW4?=
 =?us-ascii?Q?O0I+Aa0vlV4540KteWDcAG6bedANCVopyw22APXthOaO8oaaM723I7dVVpHB?=
 =?us-ascii?Q?BepcxLgCvR28koBmgAcuQFHeJP0LRfW3117YUmW9cwu0/3GawyJRoaZpXvfl?=
 =?us-ascii?Q?H5UoUNGtvnepmIvzlWN51haNqlfvCvApcUieBqphfotvysjd/jTypEz93Fis?=
 =?us-ascii?Q?akTbX2Cayo8eE5cuBNdKAh6G0kIIyj297U+FUg8elBJDtjRLGehLg/1KzdQB?=
 =?us-ascii?Q?U52tIkkjSo28Pd8l8prCscjQn9De3iJ0iELj3HGQoTdXCEXodCBpZmSzgB5N?=
 =?us-ascii?Q?iuGuaajXaL275l1q+sSTfk3PSCRCNPG4IEumDsEeboXjpJX1/NU5hGmtFtPz?=
 =?us-ascii?Q?2bkIUaMWfbztToogci0p8Do7mwnvEm9uBNvVY//eg8qQjJLRjm6AdrubZ48f?=
 =?us-ascii?Q?W901kvk1AxMFL1y2Fxz2jOEtzsiGm+tMbMvT9k2abvlBARQAWOKvsKBj7gQQ?=
 =?us-ascii?Q?iACe/+ITg7KNM7l/HH5C0rFTBOMTFkMc0aE12tWa1q301AFCjn0jHJNgQRtH?=
 =?us-ascii?Q?2F56QObNQmqMVuTBvHtH9fqFXC1g5ZAjXPilCCyRmrMzuXnd6QdVSKQydjpq?=
 =?us-ascii?Q?ImWs+i4Jt0cWIzDSAalGNCBv8x5Q7OVSC3sgXFmhDUTDDqexV2zREDFO7UiP?=
 =?us-ascii?Q?VInm+bFWfd+g+/NDmtt774k4daGefQjcOQt1/1SDbM0XXQrlC2HF1mksjR8C?=
 =?us-ascii?Q?c8zTnVYYNn2rcVPNAupsPYfSpZ37lE8HrB4Drgtw2hFCCRP8OMNoi6nU3nXg?=
 =?us-ascii?Q?yVfix6CBtfUO3+QYRcTobRbMt6xeJ3dOLDVeiwZiqFjPjEyiZorwZFjZ9lLF?=
 =?us-ascii?Q?p8QhTIgwP/3lTk9q8S+qlzfzm9YvuQQKZX9PdiKoJTIJMMpQZBiJc6UX1SJA?=
 =?us-ascii?Q?A1w=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?WhO9kQpr6lVs99w22K9G92ewMQo7NT7XRivnasyhDEJLDb0T3bHg7uUzxHKT?=
 =?us-ascii?Q?AucgVXkfVcPucL/0gGh9wqaVcDkzrWaek9VQljPc+vsBSBov21yPsOYhovYK?=
 =?us-ascii?Q?nNHvSpAoBuzeOtvVjbken5qkOfuOlfe/Q8lLEBLWXpUWjYc1MGpmPlo9TfJf?=
 =?us-ascii?Q?B7eAi1HShOnMqTY1e2aJcU1J0TfmwdTz+l02amaNexyTy+nCl0iDEvKT8Oop?=
 =?us-ascii?Q?iqJEAR86YYzzhSgUolQyChD/yJPqrBg3pcLK5sv9GfBxoQ4kyx/JVXuElzMN?=
 =?us-ascii?Q?gbKi6rlJX7avyxCqwnnblpAitGL6KoiRvJ3h9+zJLfVpTT681wypbpVvr5i2?=
 =?us-ascii?Q?RpBTU5YUET6SdBxKlzmt9SW96D0j0581l8zfdjCT+EF3+WAjGRqzTMhB9B6O?=
 =?us-ascii?Q?TeOYwIK3rRBsOcxf3nsEWGoFGg0r3Nf4v3BITFmnvYlwzU6H7DrhR+0rc7An?=
 =?us-ascii?Q?aidzauoWy3IufFEhgDI7gBLhrBZXVv7A6yribES5CU347AUUg4MBrMruVo6n?=
 =?us-ascii?Q?GaGj1t1x/2XU6zwx/ecDC/a35fqGshWaMnJ5crJDL+U8/Y1KbbAx9RZ6gdzc?=
 =?us-ascii?Q?/XkJ+T3FqAAVCG+Ar6woUmYkXK388VxCSfRVUCtXo3cCigi7lUsHhFEHlaNh?=
 =?us-ascii?Q?Gwjc877sgGumc2WAK95JS6PCEPutbbbfcjYVCBHShrFX3+ILoEQ8h/R+CgDR?=
 =?us-ascii?Q?/jyO9Y0Z5/0lESRKsG3dwzwOQCc4DUCu1JTM/vyoawrQKdStdfGmWESjNnJV?=
 =?us-ascii?Q?i5TGFtanPH4ioieE17iQI0RouvMDMgTXLK95RhZYnjARjl7dndL3paDu4GHR?=
 =?us-ascii?Q?KS6CIZgTGDneg4IMUMqIAoqeic1XIMzXKu7LA/KT52SbkQKGcBU5cUG5anbZ?=
 =?us-ascii?Q?UIwPZlvfTsZEQLg0Ek5t2l4Ro2EWHpkChj2XDcyW3mDaPQODHO7blhK6zpc7?=
 =?us-ascii?Q?Cm4zmgpRGvZCRmJxuvJHi1ISYLWCNK9scAv/NOZcq+gQtSNRQ8q6c/ruMwJA?=
 =?us-ascii?Q?qHDcbx3RhJERJGcxIpZNUx55fR+3lnyswuYkCJSeHZUyUYp51KTWHpitAN8z?=
 =?us-ascii?Q?jUgLfkLDeziFuMBVzwDB+A9oUUf9ilzOzppDD/KaG9BzzyBnsQ0+MIseDySG?=
 =?us-ascii?Q?stIJEBAryImRNCYR64c8YqMAMTMIHUmtYpjkEnUhSDyUKphl07i2rjJsRX6m?=
 =?us-ascii?Q?SSCzZUTzGDj+LEvrECGJzWfv+nvikzXxvIETPbWmKcfOvJH5Ko3sbZTiYAMe?=
 =?us-ascii?Q?j/p0ymN/PLH0paNE9NqrFJbEhlLsNOosWsRdc7qHky7iaaIda+s5uMtrTEbz?=
 =?us-ascii?Q?MTfYlgzsL1I56G89r/ijtRYHtoqZGHkwMcSYPVuBbvXZHSnRlVvkk3xxX513?=
 =?us-ascii?Q?qhMSMq3tmPvX7aKk0SBWSJWnUvtZQH/kt8JQ1T4PwtGDFzskrJPvCCv2WcYO?=
 =?us-ascii?Q?resP6B8UzuhUqrj49HbhUeg4Z7yXOjZr0WaBcXgrSyKmDdp40zQUNbvQZSfc?=
 =?us-ascii?Q?853Xs7Coo7cb0O6mpZNHYioHvOJq9tsnwXOvXzgbpGhalmboifhNgoKChMjE?=
 =?us-ascii?Q?VHEXGFmYvMA2Vbs/2rOPu/3l9geDnCkXYgmXjZf1Qizphf046nm3YySq1mM2?=
 =?us-ascii?Q?Lw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	Uw2gs1boYzpOoY/i+8yW5OEsAIsPh72pkPy3Cuz0rChPSYoScfMKjsiiJdLt1kFOYv32EuNwU/h7uEe9wU8APiXjyqtmz10S2nus+x36HdU3nc2jhCPiB/vVYjXXFZPIOby6acKQ/LJwiTZbfcMflvmeT1E2aNTlnvcu3vQUdyfmCJFHF34LzUf+zRdxE4nT8PfGAgphkLWcmktNi9U/7vDxdOMyrTtPejD85jPQxjnwo3r94YVC+NVG1e+0cJpJ80+khaRS2ck9q5WptkUZMAMM/GctEi18H/Kkxfd6iaek1irM4oVqDkZHiuQy2lZwahQ+NNMXuXzzn+7gTEAKOZ9JnmREGcGkqxh0IZjKVqJecmKzQ3JkJxkmqoRvnp2+oD0p2irqoPbIJm5TBz7EqJHXaZh/xggM19UmmALgJLh8vKsW6YbrKdfjH6Kav78u+I7Gg0e4ZhXyDdjLskERmQT0OFyMSH5PCA6BOSHAp7WxJMTqOQjqyIZNrSfVenleBqpmI7Lg2UZULd0QAgIED+Obs83yTK+7nrbCTdPOrAYAzUOmHBxLvnH6kRCIbmtLA0G3N5jpguayggRcKG6P12WC1bzb06jz+LY99xUNS40=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cc00130-63e9-42df-9a4d-08dc9f658207
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2024 15:49:10.3272
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d/fMGrfzynQiPgBk2uR9CNmfeA2ROCmFAr0FLx4J0ueMxrXzfb5WPsu7MysLynI22qMMlNh78pBx9kqHOAPPcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4738
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-08_09,2024-07-05_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 mlxscore=0 spamscore=0
 mlxlogscore=966 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2406180000 definitions=main-2407080118
X-Proofpoint-GUID: f1uE3jdJM0MmiM4KCtlW3d2xiBeDhyZR
X-Proofpoint-ORIG-GUID: f1uE3jdJM0MmiM4KCtlW3d2xiBeDhyZR

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

The entirety of the NFSD filecache backport series in now included
in v5.10.221.


Out-of-kernel follow-up work

Amir Goldstein made these review requests:

- Adjust the LTP test fanotify09 to update the comment with the
appropriate 5.15.y version
- Update fanotify_init(2) "FAN_REPORT_TARGET_FID (since Linux 5.17)"
- Update fanotify_mark(2) "FAN_MARK_EVICTABLE (since Linux 5.19)"
- Update fanotify_mark(2) "FAN_RENAME (since Linux 5.17)"
- Update fanotify_mark(2) "FAN_FS_ERROR (since Linux 5.16 and 5.15.???)"
- Update fanotify_mark(2) "FAN_MARK_IGNORE (since Linux 6.0)"


-- 
Chuck Lever

