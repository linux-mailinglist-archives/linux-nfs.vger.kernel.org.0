Return-Path: <linux-nfs+bounces-4231-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06B76913522
	for <lists+linux-nfs@lfdr.de>; Sat, 22 Jun 2024 18:39:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8DF65B22BB9
	for <lists+linux-nfs@lfdr.de>; Sat, 22 Jun 2024 16:38:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F3EE16FF45;
	Sat, 22 Jun 2024 16:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gff0aEpM";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="CRXnERYo"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01AF5155310;
	Sat, 22 Jun 2024 16:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719074333; cv=fail; b=B53gooaQVE+Xd0tL8A6fXO3z0Erh0MoAtdvIXycoaty/mbZADFHx4jzScu4OxTK4Sz9dXWYcrrudmqShRthdDVGvxSDSNzS+sbw9El30BpFE8RDu4VrmWyHIodTC5lT4BJD5nSdquOHAZg7XvDv6fgNyiZke9nlaQfIv7af7ZQg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719074333; c=relaxed/simple;
	bh=62cLharR+jAKRb1gmMr75OMPjpMA3Bp5pCAKloCew0U=;
	h=Date:From:To:Cc:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=mdL4fd7xw67galEiGWe9M4gFaksWbvlRGTWHN+hdsudbOt70vP36mToXK7yBkqO8th32gN5g4UmzPaSCO0zedYLXfuOERQHjtSXQCS5bkaIo3qoxs+0Hx43GTQKbeUhWV1SJIhhZosyf5O1HZe0MYw3Tm+HQ9nSL/+ORe5E8m9Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=gff0aEpM; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=CRXnERYo; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45MFZZ6S031595;
	Sat, 22 Jun 2024 16:38:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:content-type:mime-version; s=
	corp-2023-11-20; bh=D2LT3ooA6qWawaFwV53BSF6k9e9ROIrlNmHjPSIXIjg=; b=
	gff0aEpMsIdVfUU/quPCElwKwWPcX3DhIT8nJKpfE8d8d7x/erHmysw28VPv+BrC
	X7l0jaOoRDM0dAAMn1TLbC67VPB0z3OijmwKhzrgAD2DNhQvlu6/UitxWDV11EH9
	aDjP1jMTGxaxYET7KDk8nYjmvACHUhxpf3Sv9WcWFNE+7VVO1LXrzRl1zSFeTUtz
	bZQObf6hwfQfPT+jgYqs+QNMcOYUsTemLmd0w+/Oom3W/gWZq3eC7QDdDg8Ya+hV
	ESPXbi0aor+rzjf31cL7neAkFxiKRJLnZ8p21iXCZoMfpMz4n9kTt663bwmxDxCM
	zQFgC6C/3J7PixERoG0skg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ywq5srebp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 22 Jun 2024 16:38:47 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45MFgcxY001288;
	Sat, 22 Jun 2024 16:38:46 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ywn25672q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 22 Jun 2024 16:38:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FNMxw2CmX3Gs5usW5mPJmKZNtb7QysO8HA6gbJ905tSfWZQoFTZy7aoo/uQLAy/FnFnHLqJwxPrity2TIuFyrlUixOQ0Sg5nbmWDMKqydQsuG7pEYZzoZPY2Q2isCKJQ8Vf1zECPjWkY/FR/rY1ksUfHoSnJ9piFN7DBHGJmmoqxc+jjRX8+x1Scep/vdqjZ0OSTG5wACsnwJ4cmk0IU+5taWSEfhJpavXekYSz4pGNFdgmAtaQhTf62vFwavu3FXKbKIqFXjjn7cbG0O/2pFeRqd8PTq6c/jHzg3Q2Tjzh70cuLu0O0PqwfU5K0+rXQm/jdOaAnRZwnBGPs20Bwbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D2LT3ooA6qWawaFwV53BSF6k9e9ROIrlNmHjPSIXIjg=;
 b=TQiwae5PFa2/eO3g7HO6ZCOua/8QJUPGowDzBJRpKF33c0RRDPCl/fg+ebygFfHLphcrfzBiAU6okdozKzGmwkJW5M9yvHruaWujyq/1CaBPsZQqmE8Wl0OAr3kBEWpU3cJDs+xS6vJiUaRueNZmQ0iN+Rwe9RmeQPiFws62D8TtLvokoydIWvVyD0MFOBsXIb0dOaRxm4ZQ9AHgeBBcFXJM6qBkwlLJEiU0+4vvkv1RcGK+d5dssJokwOf0hV165Ff4/7E5OS9Cv3Hie+bWX1Y02X9RpHWSwJ3bfMGQePLY3SUT33tZsOwFuzQ2ZJo0ljJ6Knw0VzNOtKTR5po0Lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D2LT3ooA6qWawaFwV53BSF6k9e9ROIrlNmHjPSIXIjg=;
 b=CRXnERYo0z81gw/H4briqVHOTXIuiDxXzoiEfvEkTQad9NmeLuTvyEaBw+oeTWSPjCubxo4pRC1UjqEC7o3snKIc28w3wsSyA1UpeHnnuhfUreA8iU6GW9ACYLHGDZ2I9CdCFu9679ODLX3ywGsTs21dcGiDGV8GEmXgHOGa/BY=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BLAPR10MB5171.namprd10.prod.outlook.com (2603:10b6:208:325::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.26; Sat, 22 Jun
 2024 16:38:44 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%5]) with mapi id 15.20.7698.024; Sat, 22 Jun 2024
 16:38:44 +0000
Date: Sat, 22 Jun 2024 12:38:40 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jeff Layton <jlayton@kernel.org>
Subject: [GIT PULL] NFSD fixes for v6.10-rc
Message-ID: <Znb+ELqzU3lqTUK+@tissot.1015granger.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ClientProxiedBy: CH0PR03CA0018.namprd03.prod.outlook.com
 (2603:10b6:610:b0::23) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|BLAPR10MB5171:EE_
X-MS-Office365-Filtering-Correlation-Id: 96cc3780-669a-4636-75a7-08dc92d9c7f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|376011|1800799021|366013;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?JibWI6LVJNwVoX7wcXyRi+oCqN8jB7ZTDL5UetZgJdZXGFSw2A5cvwyBl62H?=
 =?us-ascii?Q?VigltJ7PHd5xZBsOXYal7X/JhVs8FPdtVubLXXzCE9vgNuD92ueNd26NenXk?=
 =?us-ascii?Q?q8PjPUNfOgfjtZK/DnzS/vt/UtPNfjZKieTMROYDHjG79TDfm1TiteyN9gEj?=
 =?us-ascii?Q?Gc6LMU03T+mGNNr42Elxfb/bjroazvsn/WttC8N0FHq7b+ese89RXTY1ZYpp?=
 =?us-ascii?Q?XYdZa//RxDX1SRdgHzWPB/nByCVkKhTeT8kcs2kOTGTGwS0VqEju1ppeSVme?=
 =?us-ascii?Q?MuxJjNzSlt/vFf7lsMjP26dyTXwfa6foK64T4RVB8Vj9bGGGJZmwyE46c57d?=
 =?us-ascii?Q?0xlzh1DHz+l9OFa15HApSM+ca4bj7ajk9xE8gaghjHYZz9Pp9JHj202Y6gV8?=
 =?us-ascii?Q?vmq8+KkiYXBuMlyern3ak219wBL+jBE62r7ONfGjs62Rh7xjW6/1lhwYVAOJ?=
 =?us-ascii?Q?VpTc+7KuiO0iquNagkTAs4WirYWx0r+hS4CetkSzHO2UUmi2iKPnQ1DQKHs4?=
 =?us-ascii?Q?BU6x5i+Kttx80eLiQsiJPhbqbZl/ty3byLTZssxogzma+nd7YPV716/W7Brs?=
 =?us-ascii?Q?HZMuK+FPSk6p3rlR+deFm7w1HpmhlwEHCZnSf0Qg/PVBmnT7x+hP/4fkxYYX?=
 =?us-ascii?Q?LK+JguuX2Mts+cWkhhJ/c8CsXpjLdgp1dcl108FfLg5F/43pIjx4pkCOlfYI?=
 =?us-ascii?Q?h4CcsAvtQH3YvU4FCbXsNinyKQ0q9yTSIgF6ghPX0hDRO0IrfyKPyvw5gsh0?=
 =?us-ascii?Q?ctCDS3Y8BDGRi+UwBGv2upywzfRyNEbDrGUfe3zTaxEHjM3S9R9QtrdJwEgO?=
 =?us-ascii?Q?OROhIIOf+4jsLTjQqxmEEM7RqBjt8BJtE1vI6Vg8S0m0U9XOiSWW4pbbzck/?=
 =?us-ascii?Q?aOqo/v5qi6sQOTuWuyerMaU/wI9WAJcyOa47egkR17Q84R6Aiip2AL1pysZZ?=
 =?us-ascii?Q?zVjLdWd7IaRcFVIiA4afBeNUwXnbPRTQzwVbP6j2fb2x7tMazIRXRlVSUpZF?=
 =?us-ascii?Q?CSL/FZwvTvWcQxSrK6wmy2sJ24O3qqYXMlBw+A70NOEYJpqR/H2D4ZdblPTj?=
 =?us-ascii?Q?3e3Ts6ZoQ6El2MwPGf+l/56BOYCSyqiLzN2L2F+nEbBxNIvCovRV5YyCheD1?=
 =?us-ascii?Q?9RKq9zgtLJIEDQJQ61OPwrECw8Etggn+KfcNgOcsRH83f8YIkRV3gt0/L3sy?=
 =?us-ascii?Q?5hoFFgQvsr6GnlgCEekWKenzmFBA2iT+9js+4IBcpZwv0pHD9U5MK90IDdy0?=
 =?us-ascii?Q?14JkVcVoutUYxeCOln0Q?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(376011)(1800799021)(366013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?tX7H4g84TYynXPk5pz54dg8fqCHPIZOSEa6Q+VcWRoi94eT02ve1XxoTnbNp?=
 =?us-ascii?Q?cw7uYhZOCNvn3fknNxEaLbs8eQSxvcsUIO3UMD9WSqa6Hp7eghaHffRNT/7w?=
 =?us-ascii?Q?S23tooX+jEDCb05OqZnNC6YIEXCIfGf/DvH24qaU6Wx6FQwC1u83hvOEGK7f?=
 =?us-ascii?Q?QGCBUhAP7xQnU0pzosx1PBSNW+dm4WoJ64VcAn1Tg6+j0tWI5/rp8ipGaLAL?=
 =?us-ascii?Q?hLG095435FNWUZGbsqJ0wRoTVfqBq79KP27vqwUKPGVEK1ctTL0CUgTAelib?=
 =?us-ascii?Q?tU0nIRS/01su7NFFMs09MJDUSUVGyfc/ZhOG76BDeHawr04FM7me8SHPXXCk?=
 =?us-ascii?Q?rTUzI29TsloZy3p5JqOD+doH452ctqd0VOXrcpLwR6YOp21WRJsC5oe2YUkh?=
 =?us-ascii?Q?+r0pHa1tepju+OGvbjSZg+nYj06hJPkE1TUnhOlKnTaAJ9o3LWa4amjtWttw?=
 =?us-ascii?Q?NUCPvCL1kdD7qvn6rcC0SU42wRAD6pOlLIZ22r9HkGNIebFq3ZZqyAcb+Nsw?=
 =?us-ascii?Q?ZsxMxq2ZHFlwbRdtr69d0QgglkVBXCO8QHuPAPtPjE27334g4V2pKug4UuSL?=
 =?us-ascii?Q?D8sM4eojBoa80OT7NrsHzg4flm8ZZjWTEZOHvzzCzO3qdrWsuPvPaz+9TWw5?=
 =?us-ascii?Q?oDgOqII/sigCDovgXWZ5Me0k1/FgCksSHEwMEFwqB9Yehb1Xh1YeUM+s7yxz?=
 =?us-ascii?Q?BXiSkIP5EDiEJjo7jb44jTlzo3xS9LTdQfhhatqdq882dEirdrICaVmwU1wD?=
 =?us-ascii?Q?tCU9XcNvde/uk1+JWZ6ApOarhiuBxk+lQ+BhVYeuqIh8Xta3smQwsh+ie9OQ?=
 =?us-ascii?Q?4sfc3njKXPbLFM1V0XrCTQ3CC0KEuAGxfxgIm7qC1G5RMifHu0aQb0A25bFc?=
 =?us-ascii?Q?YiXZZ71pUldwzvli5dkaMZrBeVZ+9650pQXn9kgCMJyuKhU+twlUadiewEEx?=
 =?us-ascii?Q?istO1c13lIFLgIguoBIpSm8+ZapQRYl8fSxYZ0z2+SX4Ip5kIObHYIJCsI4S?=
 =?us-ascii?Q?bBZUJhskq6zFFHZvo8AxxqXrzv6Zj506rjyq8iS8BkWuraizNJvkbip+8o3s?=
 =?us-ascii?Q?jD4ROPJ6QMLGLpQ42y2he4wwIU18PPAjjnIqjiQw4BGl2wAhzigLoQE+4WwQ?=
 =?us-ascii?Q?lIfcoFVEfqPy5FcO90j3RtXgsqwv0hi2KQ4pVUpiz5X47DvHZ0Wu9YOlpBC8?=
 =?us-ascii?Q?MN6qnD5/ibMjz50Asw1oSaPO1FK4NIaIsMaKdf0XSUItSVZre4d0wL0EU3mT?=
 =?us-ascii?Q?RTG85L5PUKtMhgbppr+SvKiWQt7+vaJMu+RIHYQmxFsniJHDL+DAr+8hemLc?=
 =?us-ascii?Q?FlO72AD5JiSxpQNuqVi2QKG0nvwhkxUg2OBuYXCVKZITcSzAPqEBHJ2Hm1eW?=
 =?us-ascii?Q?IOYDGiOlKu4tvYq6NDddP2WUnCKSKTHG2kuULbaOdgEmwfUkbiRSiF8w7Yz2?=
 =?us-ascii?Q?1VCVrEGgUYm7Zp2NiqJXrPlxRIme60dH4nJ6zeMKujQCNXSL8wTJXhw2DYqC?=
 =?us-ascii?Q?XL99QUXjNM3sbKy1nBpsLXpwr/EPOxhTl8H1vuwQdj0g1GkPJaP7RFqQnwuf?=
 =?us-ascii?Q?YB8JDCOYYMmB45VB63Uk6+jWxe5Mu5FJxwp3Z4y8?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	4bXj1+AY540M6Si46SmiSaaBwbAXV/N+3BUTbMabissu4W2A+l3Vb9gf6ztJ84qNfZDV8n8gwpo2K9uleFxBOQrNn9pYGYTZavDE3wGMj3daYOf4/wAC43ZtqadQLvmywvlIHPo6tUNhcEMFnmVSlTB0cFegtOc4KpstvIwnU5LeJlckRE+qhW1e3sy7E5Z4cvFCFT5f0JNebrgFgA200Hm+lzov8Ua4Gtq8iVgqXw5qPSqEU/1ryQB4Oa+79bPhkwI6a+6wWYCWjgc8A5CKYVY/L1kEE99m+AbSUmzavX2THZSIkzW/IoAjIzsoYt//oMob+sresBrY+l9fMq9LOBUn+jEXoqwBreIGoipbpa5GVNEdFFe0MgPuk9MVLC2JYNCG9lZekckDkJMwic08GfGfW8YQxhj1z9FfHWPTLMeJZNVfpkErfpj+na2u+GRF/yf3DmvWDc8EnnXk+leDB66jk+mkVfqxfcR7v2jSz0KUjSzcTluXn9qn4P544IX5qF5OpOIPFoydqyurLrH66iVKMJ+7E8usfuXOKjsuBpywrTD2Ua4YLEpasr7hYIRerQoz/s8v2fYCn5ws8gGVoSP7L5ngM5XDffz4WQhfxFs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96cc3780-669a-4636-75a7-08dc92d9c7f9
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2024 16:38:44.1243
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nXPIHQObBpDE0op+1YMH38UHFYuliOgKG8QnC7V32JYvOu/MZrI+DLRq8yLW2EiKM7fLVgN7nWCM9mSTF+GG5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5171
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-22_11,2024-06-21_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=848
 phishscore=0 suspectscore=0 malwarescore=0 mlxscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2406180000 definitions=main-2406220122
X-Proofpoint-GUID: pftxbFUaUl-I1wxb6nte4zLFZIoYaPfa
X-Proofpoint-ORIG-GUID: pftxbFUaUl-I1wxb6nte4zLFZIoYaPfa

Hi Linus-

The following changes since commit 4a77c3dead97339478c7422eb07bf4bf63577008:

  SUNRPC: Fix loop termination condition in gss_free_in_token_pages() (2024-06-03 09:07:55 -0400)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-6.10-2

for you to fetch changes up to da2c8fef130ec7197e2f91c7ed70a8c5bede4bea:

  NFSD: grab nfsd_mutex in nfsd_nl_rpc_status_get_dumpit() (2024-06-17 13:16:49 -0400)

----------------------------------------------------------------
nfsd-6.10 fixes:
- Fix crashes triggered by administrative operations on the server

----------------------------------------------------------------
Jeff Layton (1):
      nfsd: fix oops when reading pool_stats before server is started

Lorenzo Bianconi (1):
      NFSD: grab nfsd_mutex in nfsd_nl_rpc_status_get_dumpit()

 Documentation/netlink/specs/nfsd.yaml |  2 --
 fs/nfsd/netlink.c                     |  2 --
 fs/nfsd/netlink.h                     |  3 ---
 fs/nfsd/nfsctl.c                      | 48 +++++++++++-------------------------------------
 net/sunrpc/svc_xprt.c                 |  8 +++++---
 5 files changed, 16 insertions(+), 47 deletions(-)

-- 
Chuck Lever

