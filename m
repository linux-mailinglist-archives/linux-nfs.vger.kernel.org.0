Return-Path: <linux-nfs+bounces-3518-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 986668D7106
	for <lists+linux-nfs@lfdr.de>; Sat,  1 Jun 2024 18:00:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 056941F21626
	for <lists+linux-nfs@lfdr.de>; Sat,  1 Jun 2024 16:00:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FED11EA91;
	Sat,  1 Jun 2024 16:00:51 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E64F5849C;
	Sat,  1 Jun 2024 16:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717257651; cv=fail; b=eXxt6J2DEOzrxZMUkvXNZiDliwRa7pV8CT7Okp7uAMz6t/bVvx9NTNzLWRMdvbK5i0UJ+rSYFXq7IxtQlxRzDpfd751LXye5CPmPj7nO7YtRBKOtfRqDslPJeDdktntr1lLnIV6bKQ1WOxpoaeUoG72cQlMTAjEU+ZC10ClLDng=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717257651; c=relaxed/simple;
	bh=fKm1mrAntZffOMNsJj2Y1uBMbqQlWgLvcRtiJa5TlNM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=uqGvBi0kpT6jGSnBkNvXF2rYXFiND1D/VSgj51E5qAiKR8ymOSMxPu2R975nz/lXRCLeEmn+7tvdlYVp/P7qo9+EvYPViO/mXscxApxKs4SnJKaZMJDgvZuclFCkp1ylAAv2itkz5ZNsshx7IkgbYphNfnbxmNEGPylx8njtvy0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 451FjHRD029064;
	Sat, 1 Jun 2024 16:00:38 GMT
DKIM-Signature: =?UTF-8?Q?v=3D1;_a=3Drsa-sha256;_c=3Drelaxed/relaxed;_d=3Doracle.com;_h?=
 =?UTF-8?Q?=3Dcc:content-type:date:from:in-reply-to:message-id:mime-versio?=
 =?UTF-8?Q?n:references:subject:to;_s=3Dcorp-2023-11-20;_bh=3DqdzS5QnLlueO?=
 =?UTF-8?Q?JlaTVBOacsyYO0zk6LUPsz45zPcGiHc=3D;_b=3DCy/Mc1Pw9vJp8Qn24PfuG2U?=
 =?UTF-8?Q?ink5LXvl9oNazb++1FtaQ8C7L1v5F31W50gKM+sajWkA/_mBCYtsOc+VDw5jeAP?=
 =?UTF-8?Q?HeC5Pr4xm3alW81NUpDkv0qPFVVacydddKCnNMu5+S3cLhO2wGv_VqGaQZQqU+b?=
 =?UTF-8?Q?qRE1GTgc+RMAEvUh3tRnWsF1Lhi3NVcmw4HRkq2ysUIGv+6aSdYc/Od2e_nYZhA?=
 =?UTF-8?Q?Q6GkgtL99CdEJHz+anPxtC/KY4J9mQ5dC4ovNNkcxTPGAPPTO+SGs3Sokm/S1Ij?=
 =?UTF-8?Q?_DNGFn7zETzJ3KkvtrGCFxDiDf2UY921ECwHkySdnS4TFQeZevbJg6DsMrJpqJ3?=
 =?UTF-8?Q?OztnQE_vQ=3D=3D_?=
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yfv058g36-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 01 Jun 2024 16:00:37 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 451D1SMW025461;
	Sat, 1 Jun 2024 16:00:36 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2041.outbound.protection.outlook.com [104.47.51.41])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3yft3awpmc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 01 Jun 2024 16:00:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AcOmJCuyv094rIQZO1wcYFe2Bu/+nOrwEcqrGpm8LdOnqW8kMhcNSq9rNMt9RcyqULaBFYpqimeCBr4Lc2Bf027tN9dKemPp1uRKs+xlhdXBDdYwdQ6vB8ovLIcoS4RgLH75p7ZzTfSexjl2Jx0ii9TeRgn4hdduLiszyzKCmzk3ERdhX5lwBdAt9tjlLjIQSXJRvvsPkQSwqW8VyQ15Z2jST8jeeJUueg2EoDCPZ5y+3Ruf5wZsPQ57OuzcvJU+oP1of04lgOpnMSlA0UjhkfaBQU4nWHN/Wileh2oiqUhvr+UwknjGe7eRkBRix8PCtkpvpRNRKlvQaKwZ5IUmHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qdzS5QnLlueOJlaTVBOacsyYO0zk6LUPsz45zPcGiHc=;
 b=XL+AxL4IX0A42M+B5HjZjDyV5wNrxeDrU82G7CTFHxA6YxE3UmA/briaxqiWyN6S2egi89wrY+Qm/Mmd0h1V4d4+8s4tOoWexh4qF9lBCMldU4JzUVYLe/0yDVgaWiU1wqf/CdCYBkYekgR7GVd5+SF59CceyZ0ydoMPHhDA35b8JYE0fdWGnsJjWqXzN+uM8VjZVFMm5Bsih7EXM6N5sTaPG/54DMy0pIwf7/rpAwLq1esdIq/sigTKRV9nykruajFeh4HuzV+XdezFTHVJYYJDLbItaz46/WEkr0tpQ7cA/ixQPIpy0bV3WLGDj2wH04glfKBUmiHzfXtD1weL1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qdzS5QnLlueOJlaTVBOacsyYO0zk6LUPsz45zPcGiHc=;
 b=VrC+0mGAmaY0IDW+s/UFSf7d3TRclRGnJMud1R2yDStXVnc0MoBE62s+hnGsxnbAOhTa1OJK/M/la9+05WpzHTWLszP7iGmIcuJP3PAYf38OoyErwjTz4G22ZhfLdAH5HHTybPLn37FHvpA3/HNRW4ra2c7j6fY/C+F6W+oUVVU=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by MN6PR10MB8047.namprd10.prod.outlook.com (2603:10b6:208:4f2::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.17; Sat, 1 Jun
 2024 16:00:35 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.7611.025; Sat, 1 Jun 2024
 16:00:35 +0000
Date: Sat, 1 Jun 2024 12:00:32 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: Zhu Yanjun <zyjzyj2000@gmail.com>
Cc: cel@kernel.org, linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH 2/2] svcrdma: Handle ADDR_CHANGE CM event properly
Message-ID: <ZltFoA6L9eMgiITV@tissot.1015granger.net>
References: <20240531131550.64044-4-cel@kernel.org>
 <20240531131550.64044-6-cel@kernel.org>
 <2bc28d01-0345-4d30-870a-3c5506936401@linux.dev>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2bc28d01-0345-4d30-870a-3c5506936401@linux.dev>
X-ClientProxiedBy: CH0PR03CA0098.namprd03.prod.outlook.com
 (2603:10b6:610:cd::13) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|MN6PR10MB8047:EE_
X-MS-Office365-Filtering-Correlation-Id: 54007915-b066-49f4-1571-08dc8253f928
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?+MBIe7ytg/XWm5LrhBmo5mtfLst3xQfxIp2XV7SEcm+Lw92YbI5Hyu4oAqka?=
 =?us-ascii?Q?YrHGfqJR6ayesIfCfN2tzqgDlnorsQZU90LJRMwsR1UmA5pv+MFNd4Tx+LVR?=
 =?us-ascii?Q?wkYu6MQlqfxAALKpaUNUxPvONkBWtdqlCEgeiL+Y60CAnI+MfoDh+rYrO2/d?=
 =?us-ascii?Q?g4WiDt3YPlsJHgBXed6mF8momeqqCGOqTShaurxQTtPNl1Gud3LTox5mQ+Lb?=
 =?us-ascii?Q?ZSdT+2VMnq1GJR4fYXPs7ZSvdrOeVAOPBVsBbNH82+fFdivq+ye3gS3bZq5B?=
 =?us-ascii?Q?fn0On6u4MHP0cK8UJ0iwtVKTm5wNpZQoGcgnyjja//QwFWtqZzo4M/UhF/0h?=
 =?us-ascii?Q?O21US03ow3fgO6rbZXEGZbF+ZBw2IS1RROSaU9oFwrXE3K49xQtAompPAwzT?=
 =?us-ascii?Q?CxnaMYR++HuBYC+9Ak+luj2K97B+yCv5al+erWGUfk3C4ax/Psdfnj1gHZXA?=
 =?us-ascii?Q?klEiDCPUEc99waBDFilQt0BoDcXh1N/G3amt5XwGvDe5HA0XSskkw+CCcBsZ?=
 =?us-ascii?Q?C3oul8iJDHNPazNT8WN0PAKKFPzmqwqAT/4AJWecKWihxvTL9V/UJ7/okvPz?=
 =?us-ascii?Q?MlCyojVYPEXTTrYkinrK8GEYBhO4+T+H1F6SqkG/0+dcFm30pkyfaJ5cLO1Q?=
 =?us-ascii?Q?8J61mLUnSUp3UlcCFEkD3rE1hn6TcRS0vDyfwY7ZiCP6FGCvqGNb7OEdyWxx?=
 =?us-ascii?Q?m5K9TzbriqbAXnmTzmHid1hnH3xNemVPCBnxnKA3oFMTNAcbsSF/zzLNF9/l?=
 =?us-ascii?Q?G6Xdyw9WQt4AGd1J0kX2+PD59Wdt+2CWyUJ/ZCzjcHmdISLq7/MV/naSCp8E?=
 =?us-ascii?Q?jyN2uANLo/hiE4YGxxNQYUkUZ6kpnztdnvGbNSFgeHF3lgzT75SQ3f/zL4fS?=
 =?us-ascii?Q?RxoU9g5B1Galo3OqELpMpkvPeFCu3z0+bdg7yrL9W9nSWHr3gtkVxPa+rsSf?=
 =?us-ascii?Q?g7f7XjTvWUiRLBVA+MF6kNYStJ23/YheT5A6kM+ZUIw0cmTQQOZWWOdMYsDE?=
 =?us-ascii?Q?grdq0QYYnILoShgf7hccsZzOufRSvbYhXUuqsGHyEV5ZkstoVJOM+GUvPX7b?=
 =?us-ascii?Q?n0iP1EU7PV+k/YRz1PkgOLRYnUAfmWO20y+nnGkuQuswAXXuAjqRKobhPJcS?=
 =?us-ascii?Q?kiQwZs2ZxVu7MiDJx7+GcFE8KNBuqW4cg89aCDQQccbRIcj9oHKqathaehbV?=
 =?us-ascii?Q?KlQUh3jeiSlddjTere7PzaWYhDFBJqzviYtJrKWP51pZyKb4djBrxg7mnbhL?=
 =?us-ascii?Q?sVp7mHdLC6O5Xhvf2JIJeQIai01JcTwd8FAm2MVsqQ=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?UQJD3PHM9b16aUCqJzmPKnW26m1ndwPeI17L87SzYK9PYmngdELzcz6EoLwX?=
 =?us-ascii?Q?SHnBvzzaESqMjmdul2Bgkos8AjB4VJCJTJ5yZtd8lfBIGFz5WLzwwu8Ig/pI?=
 =?us-ascii?Q?ucLijb6zO3FD5MEULzrLQfWd/6FL/ODunmegFiDACfRMgzaFWIxKWoIgAaoN?=
 =?us-ascii?Q?JFP2CLAhi7blWCZzoFn+j/XKfwHx73Hy4UgBfNZMkqWrvuyg9ttgXUgdlp2c?=
 =?us-ascii?Q?EELweWSSpfPeGJnsmVmPbOAZCpCqjOhzQ0GSW5XlFzm5gdDBxXbN8R65PNf/?=
 =?us-ascii?Q?zQ0SZrxz7qx6pGtaEKOTDzmkPnpH1NtS5mDa8QpmzbP+osv9MhCiQ8pbQt5E?=
 =?us-ascii?Q?//xQF+D13SI/09uZaw7nu5OCBpl98h770feXR01ljRE8GWwylvtC4Wjr5s/V?=
 =?us-ascii?Q?s9nwsJLX5ScWWnYpaS0Mkllh9zXMw223Pqxo2Zeec/zqnhT51iENalmp59se?=
 =?us-ascii?Q?7YTpLfEd9n2mqUm/tdu0sNtGyGq+SFCEvss/Jt/GsJuRovIPCNVJOPW7zwZY?=
 =?us-ascii?Q?M9+hji6w6JmBMw/gqZEKGcjlvLM98hXira6LcnDV7t57OHCLZIJ8tFp9k45N?=
 =?us-ascii?Q?1WYqsuUMnVlLaP2welVrSXzr7JVKByNCEKnlZVAK+uyE3ZYHdU3hM9Of3TOy?=
 =?us-ascii?Q?l84g+srT+IH2GRZBR+9rUe8UjbBLC8TO8SuozhkHljB3vucsxLuypHzv/jAN?=
 =?us-ascii?Q?B8iRypritV7rhiy8f5HvI3BbBDe+jhBD1y3JBiPqn0oTlivYsZllFLkyeVr1?=
 =?us-ascii?Q?HNAM+Vsq9yf+JnvzNrkcfpnchfuGX8ImfZPubAKIP6k7YvOPUET3KKkeG4mK?=
 =?us-ascii?Q?QOKEJjgmI0vRirdGKIXSSpxBX3+rQZkd8BIizTwOxAgG86dLOi7YMpjYRpta?=
 =?us-ascii?Q?hNmq6z+JbzQV9RAgGomtM304yEZpl3SG4ilAN58WTaz6A55l3Ma35trxxQY9?=
 =?us-ascii?Q?icoMuXYoEL+pD/8kXsZUUsdvOh2BBMHKo++85GaQSSccQWXytzpkzG9rexDT?=
 =?us-ascii?Q?xE7YJd0bMflLSS6yRVpiQgfBaNS9XquQKsxMYwBbSKBYPr5+xWJAdf5AVmS3?=
 =?us-ascii?Q?uYj/Qw2fP0gPU/zYpdCv7+3Xq3VBoVXb3/H1ZkR5rcxabu7rLs5wdmnLolQk?=
 =?us-ascii?Q?vvapxArI8WzS7l4xMBvADLz9M+LzGuPre6pSF3xiKCShOW9ClAAUQjk/EpEc?=
 =?us-ascii?Q?8uT1ARbJzXop/f/X4tSxe58WizLvHeKpLMcURI9cI6CPR3wzwBCVbKE3hWLv?=
 =?us-ascii?Q?wifdwRg813YozLeXHKu10EhVKm3VN3qlpS93ZIB7NIp+G3Qk8neZUN5rDXpu?=
 =?us-ascii?Q?nlwSokzILFdyWs3z+RH5l5xqqDj1LnaP7DJWT0HoeGPoKoL8nkHlNP/oGUx1?=
 =?us-ascii?Q?46V/TozqBq0azsJJrzpnld/GRRckXDwPxiTHvHrqvR5hXqrT5Di28GTHMSgo?=
 =?us-ascii?Q?yQmqOgE7g3mm1q1M+R5PMfmhdFbVI8BBNZi3w5N5RrF6Iq/qKHRURif70hvl?=
 =?us-ascii?Q?26MEGMLyJL9VkSspuDvn8kX9fpbgfnfr44vdOKqq+qwCzcI3cLlz2oDQXFI1?=
 =?us-ascii?Q?gNytO60KIioEJfgKagRz6DwxCVE7hj3e3CVaic75Ch6EoezZMqH4+E7hVB0Z?=
 =?us-ascii?Q?Hg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	48G5HYY0nvkOCoJJONWTo33VrDpRHfv55wt7tIhFGPSxQD6Yoz68QY2057uMSdoruvEOLeO4iccfzTtidSDKdLkMECYJXSmYMWJhdMxHXhSHUFJreGTq9Ck3ED61msWphEfdAm9vDGAwEer7KDluZrTAxrQpnrTadfapUBnDw9c/8YX+jzOG2izFli2II90tGe8lZ0deItd8NHhwwKst/54z8vjnT/AAlcpqFOUBG2IZnq9oIetpFau2OdgcD812bmW13SEj6L788NgIxJ0IPIGO56+gYiaIzEvjx+dnNqgb8qZbNefcTCPavsH4XjgVvvwfRS+6l4dVoxhEs1d3GhBZDp6dkkg4KR04AbspxWP2SRicomJdLwveV80Cr13KKwdh2J1i785ePQzUg5kcfzzx1/1Jtkp0rLKpiZ70Oi9YE7YhQ/jOaCgckCZENL6kcmhatQmX2u7khbG08YZlmsUtYdS2pqaANsnFqk9BbRXM3oBcgpTuWXogsAvo54XdbFGTIg5mK4kE6PCoxkdDojXpU4DQGitIYTMuO/kLNYt64Fa9a0oifgjJN86jsc6AEE6lyhWOdt+G5L+nmvwjl1HX2hkAvUroU9plkVKRNY0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54007915-b066-49f4-1571-08dc8253f928
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2024 16:00:35.5687
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dvUmh6yxzx49y1hqZOP5nTdhdzHrFwfhtZUuIaQ33cpBCCEKV64jtWz6EhV1XuvQBU6zATABgf1rhYIB0ORYpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR10MB8047
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-06-01_11,2024-05-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 spamscore=0
 mlxscore=0 suspectscore=0 malwarescore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2406010126
X-Proofpoint-GUID: -xcdJxfPh2xmsKf3rZ5kG0lViH4dY8sH
X-Proofpoint-ORIG-GUID: -xcdJxfPh2xmsKf3rZ5kG0lViH4dY8sH

On Sat, Jun 01, 2024 at 12:48:40PM +0200, Zhu Yanjun wrote:
> On 31.05.24 15:15, cel@kernel.org wrote:
> > From: Chuck Lever <chuck.lever@oracle.com>
> > 
> > Sagi tells me that when a bonded device reports an address change,
> > the consumer must destroy its listener IDs and create new ones.
> > 
> > See commit a032e4f6d60d ("nvmet-rdma: fix bonding failover possible
> > NULL deref").
> > 
> > Suggested-by: Sagi Grimberg <sagi@grimberg.me>
> > Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> > ---
> >   net/sunrpc/xprtrdma/svc_rdma_transport.c | 16 +++++++++++++++-
> >   1 file changed, 15 insertions(+), 1 deletion(-)
> > 
> > diff --git a/net/sunrpc/xprtrdma/svc_rdma_transport.c b/net/sunrpc/xprtrdma/svc_rdma_transport.c
> > index fa50b7494a0a..a003b62fb7d5 100644
> > --- a/net/sunrpc/xprtrdma/svc_rdma_transport.c
> > +++ b/net/sunrpc/xprtrdma/svc_rdma_transport.c
> > @@ -284,17 +284,31 @@ static void handle_connect_req(struct rdma_cm_id *new_cma_id,
> >    *
> >    * Return values:
> >    *     %0: Do not destroy @cma_id
> > - *     %1: Destroy @cma_id (never returned here)
> > + *     %1: Destroy @cma_id
> >    *
> >    * NB: There is never a DEVICE_REMOVAL event for INADDR_ANY listeners.
> >    */
> >   static int svc_rdma_listen_handler(struct rdma_cm_id *cma_id,
> >   				   struct rdma_cm_event *event)
> >   {
> > +	struct svcxprt_rdma *cma_xprt = cma_id->context;
> > +	struct svc_xprt *cma_rdma = &cma_xprt->sc_xprt;
> > +	struct sockaddr *sap = (struct sockaddr *)&cma_id->route.addr.src_addr;
> > +	struct rdma_cm_id *listen_id;
> 
> I am not sure whether I need to suggest "Reverse Christmas Tree" or not.
> This is a trivial problem. ^_^
> You can ignore it. And it is not mandatory.

Oops, I missed that @sap can be declared first. It must have gotten
lost while I was trying out different solutions for this issue.

Fixed.


> But if we follow this rule, the source code will become more readable.
> 
> Zhu Yanjun
> 
> > +
> >   	switch (event->event) {
> >   	case RDMA_CM_EVENT_CONNECT_REQUEST:
> >   		handle_connect_req(cma_id, &event->param.conn);
> >   		break;
> > +	case RDMA_CM_EVENT_ADDR_CHANGE:
> > +		listen_id = svc_rdma_create_listen_id(cma_rdma->xpt_net,
> > +						      sap, cma_xprt);
> > +		if (IS_ERR(listen_id)) {
> > +			pr_err("Listener dead, address change failed for device %s\n",
> > +				cma_id->device->name);
> > +		} else
> > +			cma_xprt->sc_cm_id = listen_id;
> > +		return 1;
> >   	default:
> >   		break;
> >   	}
> 

-- 
Chuck Lever

