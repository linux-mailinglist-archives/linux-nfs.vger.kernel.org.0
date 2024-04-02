Return-Path: <linux-nfs+bounces-2600-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3901A8955F2
	for <lists+linux-nfs@lfdr.de>; Tue,  2 Apr 2024 15:59:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDE3D1F23473
	for <lists+linux-nfs@lfdr.de>; Tue,  2 Apr 2024 13:59:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D00098405D;
	Tue,  2 Apr 2024 13:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Pw3qD5xD";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ktS0ELku"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3271D84039
	for <linux-nfs@vger.kernel.org>; Tue,  2 Apr 2024 13:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712066324; cv=fail; b=LNpl2tRojfjzrdZas4CoVGcwNhyTC0U+hportmdxWuG2pEPkIk+wE3gbrXGJCnzCHu+Pp+2C/trs9XtNoUgtP+xClAoVAApqNHPZrS87l6WKk6zDzmlxraVTXFQOSiwCisIrkEvZFl3QJoX8JSKLAhe9jyTkIM9j7ZmXsvlPRg0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712066324; c=relaxed/simple;
	bh=MPlFw/P1UCCpcBtbIpryX+65urU0iO+MlG1GS+V+3Vo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=KardebGQw3iHN6R5uDeY6bu1YKxsIaaSK+mWmIR11+IEytcliEX5h7PSQFwqHUR6x1MIexZb2Ss3qlRvoH3YAjknl/CZqX+4QfOfEWTT7LiqEo7NjBef44o487dqrCky0VozPTlVAZ+enbzkfZ1kwvJzFQhf24tE6pSO6WWDW/M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Pw3qD5xD; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ktS0ELku; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4327ipRZ005940;
	Tue, 2 Apr 2024 13:58:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-11-20;
 bh=CKrXYk/Sm4L5bbQTdIokLgxZcIdw2afd2oP/7Nj3Izw=;
 b=Pw3qD5xDbZvihHvcvfAbJlALjBd27csMN3+qoEC0Zg7oOslVHZnTESqvFtwVa4YWlLG/
 ZrHTcKqwQefCMhOdc/duDOmTIXPldn/5Fb4HGLrTyPvahgLDuCXL9PKCtSt6oCozYmZi
 T4edxu6CoQ1JmglgkwIZsLuBozRuJDYw2WXhFK+getifFu4PdoKAaG6RxN/tJ+4IKZoR
 p9OlIs3S6yXJ36VLVJaAhE06v+06yMQesL+luJvrBj4Ce/Q3KNr83DVjGFKlndb2wQuB
 FLkD7BQVnN4AIX7leBL38fAg/gHY49ni5jcqA9qbRRP74SxMkRLrzM55lWPBV87GgUKD Pw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3x69ncmsda-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 02 Apr 2024 13:58:40 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 432CsOP1000839;
	Tue, 2 Apr 2024 13:58:38 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3x696d3ndw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 02 Apr 2024 13:58:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G2RFbaROK7buFZJ5szpGiLvLW+LfC1TcIASg9U1l6gCGdzYoT0GvVRZJD/zaKRwMYlT9tR0tS9YSozXAh0VYhQy0NZJOm+X4jIt+Qx6YaVJv6wgCgeDe/YqT/T2X/9gB68x0eJFxZvHbO0agSnFMzBt0KiTHuOIENQBdxDa1KgWdH79f++iXT6mhK3qD3c9E5lvBbjE0V5jPoMhSXUkSkmOhcEroLvCQ6Gpd7hR1cvUnVZdInF5R21Hi8aAT1RcrFIcFIj5+JfHrxN3DWLSGeKktiFfSnQ0Z15VDwRpeHT86G0LO2w/0as2St45mn7x9bBs2rjz+JeDezCcVFm1gJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CKrXYk/Sm4L5bbQTdIokLgxZcIdw2afd2oP/7Nj3Izw=;
 b=TQFu0t1uZTpOIkWBBmrKJHCW95qPnJvEksgnyFOLqrDDppae8k4+SKgNYZqZ2bBE+1EBETzox8H26wYSdRT7Wn4hqntSruHTyEsPAfNA2cd65+wp2JWP7inopnqls2sOvVhdekeIQUZTOnw+Kr5rwrUrCGLE07itJTTsl50wPOlKSuN93uqr0IfLppb/3ZQJdUvJrT3qiM4p46c2UPO//DIAnZ8Fq5cp8UJKaOUchapCNPT4+UfpIrAuQNOYf7V3s0EL8EmiA9ZHdx2LhrRnCg2QdN8pB9jxE73aeuEt0m8RFmivm8esC2gQvSAcr4KzYBZhOZQaEeYobbSpQWl+vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CKrXYk/Sm4L5bbQTdIokLgxZcIdw2afd2oP/7Nj3Izw=;
 b=ktS0ELkuQYu9ywhzlV7fMrp5Kg7mdmKbjbiw4mgRbRWayfs/Yw5meyzw9qsPHfEnX6mBaSxNYVvANoIsZI0DkqQ2MPepuGjrFgCA0BDb7kITKfAt1M/0+oDNi7PyW9x5PMrZTDVytu/Ppl3ejVJjeZnJmLnO0Xmv/+7nZ3ojHns=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SJ0PR10MB4543.namprd10.prod.outlook.com (2603:10b6:a03:2d9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.45; Tue, 2 Apr
 2024 13:58:18 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ad12:a809:d789:a25b]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ad12:a809:d789:a25b%4]) with mapi id 15.20.7409.042; Tue, 2 Apr 2024
 13:58:18 +0000
Date: Tue, 2 Apr 2024 09:58:15 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: Dai Ngo <dai.ngo@oracle.com>
Cc: Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH 1/1] NFSD: cancel CB_RECALL_ANY call when nfs4_client is
 about to be destroyed
Message-ID: <ZgwO9/3pwOoC/qIk@tissot.1015granger.net>
References: <ZgdR48dhdSoUj+VM@tissot.1015granger.net>
 <09da882f-4bad-4398-a2d0-ef8daefce374@oracle.com>
 <ZghZzfIi5RkWDh9K@tissot.1015granger.net>
 <84d6311e-a0a3-4fc6-a87e-e09857c765b3@oracle.com>
 <039c7e38b70287541849ab03d92818740fdf5d43.camel@kernel.org>
 <Zgq365RJ9M5qsgWY@tissot.1015granger.net>
 <5108ca5a-b626-4ae9-a809-ae3fffb50cab@oracle.com>
 <a30b343f-b6cf-4566-9565-28a5fd5ca851@oracle.com>
 <ZgrzwVp4GrbmZGWt@tissot.1015granger.net>
 <86dd7031-744d-4448-96ed-6d3d9c2e49b0@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86dd7031-744d-4448-96ed-6d3d9c2e49b0@oracle.com>
X-ClientProxiedBy: CH2PR10CA0024.namprd10.prod.outlook.com
 (2603:10b6:610:4c::34) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|SJ0PR10MB4543:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	MkoJ4xDZDbAONJH1b9qNwKAserzo7LTk7BXu9nq4ROuLuz6xNkcbSqP8NACQpKchTxCZG0WgmUWdqpDSWj98MJx2DngPVfcYRDf2/bnsQEaup+wN+agkiD9ssrC6oPVgLVQKSvW28OXxOdxDQyawS/sCllHABL58WS7wPWyDQxMXSuC7GoyfwH4tndHECxQw/FBSaDeV7NTqVqa/XI28R/jCxiy1qWdigQd1mnavGgKodxl1Q5ih5Yx5Atqg0V4dBn68fZ8X6bKmRTJKhuIYPCXw3j48zPQV4In1soJd9jNslgMJVTfSKN8HtQ8Dn+5RYrh4U0FbHq3zRmwh3MCMleVotlOGZZHdaZb+XKk2bLYuFCkOI74kUcC9OlfKkfFHhxkXalVihQmUJmgua/chDj3jGHPLnL5JuvZ98DbF1EaSOzgkxxdU0vtRSFZswxc79d05ytJvkQ/TtL78qL0zFBpIgvov8DC9fWgtf0V8ScoGGGcvUj0a57pXTo0UTjVld7UxG+k13DDjWNQDhp0a6E5FfmifyBT7epTH3ulJmH3yXOUoIg73PbhJQZcuBCInw82j4Xst++tp2Kfneva1nmcyUwkkDEgfpD/YG2KRjD7yBIcVXZhDA9kJBjErL4VXCPZ7g4lEYCHW1CT5dd7UgfRfjAmu/bJHBb6KRsHbI0M=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?hZcPLEvVPazdWvoXwoqWAxSAkBLuG5T6cFFQTJcSm2M04e02hmyGD6HOf2MB?=
 =?us-ascii?Q?rScrUigA3nZ2YRhAj4RuvlzApWdY2grKNRlK4XdUmONQyDEZuu7ZHvpf4Ely?=
 =?us-ascii?Q?4mxIOqXFWcOnSHnKeMBzFchCUvPbxj3xHAQM9mipy2r8gLlTNlypO6ku40GV?=
 =?us-ascii?Q?I9QzD/LWQ160xL2Y6pjJgpeOJZCx8lougHOxalRebjUHPwECt/n5XkfFCrK5?=
 =?us-ascii?Q?3hybUXajydm7dLz4dBxe1VbMNXYv2g2qS6v+hIpahxgEvycQgA2M8cyRsgPQ?=
 =?us-ascii?Q?WsVRgg6bg56thtWJDoyRAz7BMCS8mLFetyFQKNE7LiforgLJpAWP3fdePGm1?=
 =?us-ascii?Q?14eDzUrrQIZqjHPV/ZBi+KN6cAsPtiQCabnC8SIcBV8aPsQ9o8xo5IeTsXWy?=
 =?us-ascii?Q?8iidJ8PoJBcu41rcT8tSItLDmEWGH2/wPnGPc2l5VlD+wkvvOOEYPNLN8qcm?=
 =?us-ascii?Q?fDoO+XvLsnpQ0UJv6QkHWJEe37Uyn5UBqRxZf3oBAbUsw96iIsxqTMuDF/0s?=
 =?us-ascii?Q?Z0qvg9yUBjvsmm07rzfBS0bEEfEpVPut1x1Dmvl11Z2s14EpEcoEvMxat2vf?=
 =?us-ascii?Q?+yAq9/Rkdt5XQhnQt567ROtvSxbl1ERqR2Fcy8upbJN33L4ov8CrP7RhYPe8?=
 =?us-ascii?Q?VZo+upogExUjPnvM29vcZ1Uyxiyh9h82/tp7e/ijBCWf++ziMEjZdRu2jWj9?=
 =?us-ascii?Q?56WdB0GWC/b1GpFIo8R/yZF45SyES8QUovYMXT/+mG7Vs6rMMpwMjGOsymb9?=
 =?us-ascii?Q?8XnNM4OsX9r7ibUoQ4//ng/yOdXitWoWrXD+fgFglMAAVXGBvXQhO6YoBm3a?=
 =?us-ascii?Q?huiRKjI8yyGvkO+Lto+MElOn9z7O6Y6PjkzVFaSQQCuSA2sgKuU8nrCKrftf?=
 =?us-ascii?Q?LfESWNlIQtwAeK8975Tn21wXguB+iOUYPPnxfrpMDNqcRVFaQj1YkXsDv1Ne?=
 =?us-ascii?Q?zYMleM9DBrhsT4Dp4VyiSFZdt4GIJjR3uEYf7nowRqlkMsqFb9IrhU9xztOE?=
 =?us-ascii?Q?d0gNyNv1pwCtTA2rlia/RXFfFx98OLwGGTl+l0P1QC7kyKyLdz4Wq2E9Dzpq?=
 =?us-ascii?Q?6UzNv258PSiKePNb+Uw3mYO+d4B0rOHExqD1zOwtA0WYIZh3O8CcgaSiPRGs?=
 =?us-ascii?Q?5O0kBQqYBOJFe5wI7uIRku5ou+iBlaijedhlwWFGJugFNyXo+DT//bAgfcoj?=
 =?us-ascii?Q?FQbncIs1L/aCVhWjcpO2VFHOu2sjolAAgfCOGNI9qQ59os+YC6pZtD9oplIc?=
 =?us-ascii?Q?lpcaYfJfL04Sb/g45OjewOPesxKBfF1xhih3JrXL6LAcMTiBEUXHR2DH958I?=
 =?us-ascii?Q?2yInTKAzjM0zBq5ODDl8xAEk5R47ufo+HV5XYfXeYeFtdBEa8SYMkN+Do2Gl?=
 =?us-ascii?Q?3POqEysYgw7MycDkq0FAYVxkCdW/lniC/vKUIRyUGo7p/sqWh2Bg9xhRFJx6?=
 =?us-ascii?Q?m08lhZEoTBGLMMQpCMO7ujEk5/4mcWUtD5WcLU5jLizR5dgTNXucd6Xa3YgO?=
 =?us-ascii?Q?csIe1vWCq6SbdeZL5MC9jyvdm3mGwC2LQOFnsPa7+1c0G9boMVSYhS92yXoF?=
 =?us-ascii?Q?HBQBnXHE64hNwzzmb+PL0BrJSOeK38cY8vgMxt2ZSRWuzPtrKzO3D/5JHCCz?=
 =?us-ascii?Q?ZQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	I8+Y8NSlMtF0wvjzxUjd2TasH/ubSVfAg1PBpU5wDq1XGlOvjOvGDQ2nKSWwm6wThSfF/ey/o9Fr+HtNmxSDTnlDVh1MQjfehGfeeoIvTJduml1BbAs26UNfClZceji9keyRl6mDJrxcvu+gIKTh2zNwT2yIKImyu5HKB4GgzjPH4SQJnuO0YZG0kY0jAzC+zNCrC+Ag/eEaR9XjoC8F346Pj49Igtp8zS/HY778j5PyY8iLKjc9mysv8I0srvO4CNnW+vn61zjLI92t+1QNdKh1XEn52qYjUuq/0EJMlG6DHHf8/aqNwq/HIYfdm0NQaaxZAulhICYQGWlNU6M/r3XX0+jDNXLS09HqIdS6ZnDQMLTvQUZNCj1/9f9WYt95BjS+EXOln/3SbSuuF8AdGzk9oc9OFH0hizmCs0LzukxLAeXKmzR/aYU437gzDdxvOZwC8zj1sX0HaRfwvS+kRvtGIvRbf1YWtg/X0xlK7BgLy4Usbk0+5q5rt4jHHQpCCPCHqjXdf657cnw7EAxQaepRu84Fl3z58uG7UXyro6wj/YtB5fbkJAvA1PWujLnxZv2qDlc9mSg4Sem/MtQK46GbSnDG56Yy3SDifZRgOfs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8634515-bea8-4c69-32db-08dc531cf2ce
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2024 13:58:18.5541
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ust5Vu5vKvUPUoWP+QKP9mdfRmPvVEOA+72hY097TdRXx7ko9+4f/HEwhFZlaGq716FObpg1FdrpD/uYYLdTzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4543
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-02_07,2024-04-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 spamscore=0
 bulkscore=0 adultscore=0 mlxlogscore=850 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2403210000
 definitions=main-2404020103
X-Proofpoint-GUID: hCUKLKZzffpl3ggbfxu58eHqWhwmDBIw
X-Proofpoint-ORIG-GUID: hCUKLKZzffpl3ggbfxu58eHqWhwmDBIw

On Mon, Apr 01, 2024 at 12:55:16PM -0700, Dai Ngo wrote:
> 
> On 4/1/24 10:49 AM, Chuck Lever wrote:
> > The question I have is will this unresponsive client cause other
> > issues, such as:
> > 
> >   - a hang when the server tries to unexport
> 
> exportfs -u does not hang, but the share can not be un-exported.

What does "can not be un-exported" mean? Does "exportfs -u" fail?
Seems like this is a UX bug.


-- 
Chuck Lever

