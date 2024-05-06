Return-Path: <linux-nfs+bounces-3167-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3578A8BCEE3
	for <lists+linux-nfs@lfdr.de>; Mon,  6 May 2024 15:24:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DDF46B257C1
	for <lists+linux-nfs@lfdr.de>; Mon,  6 May 2024 13:24:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 659861C6B9;
	Mon,  6 May 2024 13:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="UHBQJjGV";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="PaOWxjDK"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93754FBF0
	for <linux-nfs@vger.kernel.org>; Mon,  6 May 2024 13:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715001881; cv=fail; b=s0BB7kifUHdW65igmfDqfPfypnjJWX3q7VHsm5hfCj8uBlLS6Wql/zwHApW/O4JfdPlEoZVAPtqGUdaK6Y2UY9o804xwPDcVUwukfymCjAdkbF0l4oBfMmj3JWEJZfzmg3PDu8fQBJXP6sFCPkULInCKUj6qUKjXMr5PpXnsUs8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715001881; c=relaxed/simple;
	bh=U9Mzgw9iJZD/K0X2ZYbWSfK5chdxph6R+oUWmM9yEdM=;
	h=Date:From:To:Subject:Message-ID:Content-Type:Content-Disposition:
	 MIME-Version; b=h6UGVCrV5XQNTGcr7UujgeGPnwfF9RFE2n516fhWpu4EQG5ZASn1tB7do2YAjMrEwCVauPF4flLqk/6bHAbBgstV9TPdZPHuYMBZqJ46Mtcxijujiwq7i0dxR75Z/UI5qAR0GSF4JW8V1y7Sza09hYnyfPvG0j4Pdbsl2wDMwfk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=UHBQJjGV; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=PaOWxjDK; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 446AnA9f031879
	for <linux-nfs@vger.kernel.org>; Mon, 6 May 2024 13:24:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to :
 subject : message-id : content-type : mime-version; s=corp-2023-11-20;
 bh=cr2AwS9lq/X4NUePOsEHI4o568NwIN8SJjXVFKT7ybw=;
 b=UHBQJjGVZx/4wWcUUvnMSM1/99lyWI5QEqYZMT/PqAa20HCyLVFfQkFDEc4/H5WG2W3b
 yB9TvuJXI725wD559jrsLbSCAqOrgwVhM81NfNMyMCsSt7D4G9oLb9arNRQiLBYg1X+7
 uY2EnZNvdxu/ZLvNznxf/w605GUSdxymKr2FglVFSBxIQDbJznAtDoxpBrDBQ1M9Mc1Q
 G5IEbQ6pf+Obi1gpwneazZ0Tl8f9xIJDG6hGHBqJgdzVqfuvHZmD+2Jrq5Vo2mFOUxFh
 RtJrOrEF9Uv43gF3uY6vckZu6p6woQUhkjac9UxT23HT0GnJsqT47lPjmzOr99MKypsV bw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xwbt52ke7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-nfs@vger.kernel.org>; Mon, 06 May 2024 13:24:37 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 446CxkkI014068
	for <linux-nfs@vger.kernel.org>; Mon, 6 May 2024 13:24:36 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3xwbf5yubg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-nfs@vger.kernel.org>; Mon, 06 May 2024 13:24:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SeRdDeLqZrs+0jviqjSZL561z+ZuAJLK8gTy74BoXCjCTDgYJHHncpYCj69IFs+YV+4htFxpIDor/8/4lDTqH4Pl7teqnnLJekr9CWgQZai1gAhjMQObxRUvmBJuID69hktQHNUwkDenyB5/HP82WZHwaRj6N4QoI3wSPuOAtqlA95osm6Yb+S/P/PBiRqHh+UV+epkyvYsckhIGEJV13Htu6oKyHnmY4R1AMdCNN7K2KmKzw4Ai5iFYy2DARfzUfjQMMm2qq+ST9gdf6WZqsZYbIB4uvWnIPb4G1VtPEQTuCozo7X73eJmP+1Pws5FE7jY490MgvrvELqOatpApSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cr2AwS9lq/X4NUePOsEHI4o568NwIN8SJjXVFKT7ybw=;
 b=BuqGTurL72FwR5/fu+TjKdCTGbIF/3+HeWGDOq/AhS10gvzgYLieHycr7YFm3gHos8HG+qp53LfGEqm4QK3gamxYdR99C5gUwOIcqihtUeBG+yC9xuAGhpk43LY6J7RBHIhylrFnbzKppQm3d+N4DDXQqtTbtC63NTv+gUNJBCnIRRtsK2GgEwXamR2krvZXp4je4U0Wmyuo7DpyJIQWiBCaMOR/QcB31El0WfiEwqnSTSyE7NHsbLiNXTHamqdQqOTA6WHOVknjh6gAipNb71y/687RTAqKIfiIimqUnDvEsFH+nhlEoEX0J+/cu73gk9vhLc/ik6HUWooOHVclOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cr2AwS9lq/X4NUePOsEHI4o568NwIN8SJjXVFKT7ybw=;
 b=PaOWxjDK/s+On8lhQqEqyeoY/HQILdKdG0Xq1pqE6qoBcK3v4yIgew4Rz58JKMwhzVYZj3Mw42l8X4n7Bo/K5Lgwl8e8hBJrdVw/ASchliDN9/ok5IA2/Iyb0hMNwNii6Gcg593IC/zHJdQgkEDqmBUBkEKgA6V8w4CXKQE9eAw=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH7PR10MB5723.namprd10.prod.outlook.com (2603:10b6:510:127::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.41; Mon, 6 May
 2024 13:24:33 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.7544.041; Mon, 6 May 2024
 13:24:33 +0000
Date: Mon, 6 May 2024 09:24:31 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: linux-nfs@vger.kernel.org
Subject: long-term stable backports of NFSD patches
Message-ID: <ZjjaD4O6FYDrCz8o@tissot.1015granger.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ClientProxiedBy: CH2PR04CA0018.namprd04.prod.outlook.com
 (2603:10b6:610:52::28) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|PH7PR10MB5723:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e0d12de-a988-4232-6a53-08dc6dcfde7d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?Hz4hNDHb3qGVX/u2elAYzRb+KYfTOrzNRP9F42TF21mg3mENAxe0Tiq21YcI?=
 =?us-ascii?Q?71ZddZrxGwfkFgURO0D6FvnaspB3U2EXk00FClyE1LjoAS8702q1PIcmzdl2?=
 =?us-ascii?Q?7VfbhRWUxwMTMR158EAyXbe1P8kpRrAlEXwKAmQDEangUqpb2/l6Q+W9G2zg?=
 =?us-ascii?Q?SruxngZ8nNc6i0LmzKdkNYy0+sfMEqK+hLt90KmMTrKC9r1aJzp0piGMiYM3?=
 =?us-ascii?Q?1jFYIFcMjlSQcxD8cDAQ5hoxSSl0T7pNKzxjDdhvi2W7kO0dK97Vjt3cuPhy?=
 =?us-ascii?Q?38RYDpnEuCYXHfe82D5d227iSHw3lHuQUYSCcBR+rTwWXlbrMOK+cejgD5pM?=
 =?us-ascii?Q?xp2/MID8KfDDGevVCmUtCSODro0HEfKHIToYsrbBBDLBhOXhUV+6FMEsdXUV?=
 =?us-ascii?Q?HbcFFblgCuQBV70HrBvojoRHzBRUujAVCRNNPx/MDRCZXAjMAXb2+mO1GyhA?=
 =?us-ascii?Q?7pm535dSSEZxE/lIBo8KXL2BaQN/O2OhdSfkx6umwrvfDuuDVHLppkbLQx33?=
 =?us-ascii?Q?5Lw9mzUKtHUz2J8D541iGZ/MAc27x1Ia/H/TMxHcx3XMxOeLXSjVoQ7LUGbF?=
 =?us-ascii?Q?nlX6ZkjgvOD/aXt8hBpOae18v34vTIANrkas1cBuceMd1cR12t0zv7bCpyPC?=
 =?us-ascii?Q?ViZnz+06izp5XyXQpiqgDXQ9SnjNCZ78/Wt7hBfoFqzx6mh6MtfG/lCf/SzT?=
 =?us-ascii?Q?VYLVDZmGw3+hIBY+P+cKuXJ7go1mknjttb1SlFcX7RtY23kfWi38gDHgp+8/?=
 =?us-ascii?Q?CIkdlXucKxBgdTZDvpE83ES4vlIsek2ctPUdrsoP3pAxGo1+k92VpUxtkO86?=
 =?us-ascii?Q?Anfau/l92vNdY/p5DIv2tMxGWCG1nKZ7dwwdH94eygUKKn78UNUEGSqR6HvD?=
 =?us-ascii?Q?mhOEIISxOaq2qe3r5KrMkNiPGE68k33jyQVZM9egYxoE+Y0mn+yarH5VzgXc?=
 =?us-ascii?Q?fghpAKTLE0Bk/Ps27mDQeSDrx24xnPlDKDbN6cxOpacnQVcS2X0nXjrGUTx7?=
 =?us-ascii?Q?aVoc8Q1Jry1y7Omw7JQ22amHKXUO7/r9YOWF9C0kM/4LgqaUFTrUXEn3UiRx?=
 =?us-ascii?Q?x9hUCVrKle+Lx6kwMO3kIVKuceRQGisQ4zzouKG2NPtjmo3/ihQUYodG/282?=
 =?us-ascii?Q?5punLJfjq1kXDqB5rgaovocM3G7N35Xh4Bt/tRzQLail0eppU5ROHGovp9Y7?=
 =?us-ascii?Q?H/IA2x05QhwUmKDlzfykQ4buaKHVrj20o5HkH768S+ib6Xt0zQJ6EnBkzz0?=
 =?us-ascii?Q?=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?RGJS91R+dph0gTncsBMxcto5JA4xkCJpu2etkw/SJZ8E7L4q9EByVLb2Nbm5?=
 =?us-ascii?Q?1rugdRFl6o1J+R0IU+EC2gKKtFMKVBt7bqMaaGWrakTb/ftJqXM+fJlymrVq?=
 =?us-ascii?Q?KyfOYPFQS90Is0vqWS5okeSLB7oBe+98rSOMKms9xgYFpK/EiUn8enp42ZGq?=
 =?us-ascii?Q?f+BdobB5gdjwStoZUVysSzb23UlDQt+MMm6aaPdH/noIjSKW4gsAPrQ9t4r5?=
 =?us-ascii?Q?k3u9KAGTCfOoJ7T55pAU8E4ITkYJ9OwARTikycyWzI6RIDi6P89M/QHawnic?=
 =?us-ascii?Q?p/ncNPIQ7V3kOxEkNlY5sAIklVKjHsLRim1Vg86d2McGOMehyz4ck1a+3Cjn?=
 =?us-ascii?Q?W9u59h93cPYjNBfKdSP7mOxcF9c38K1mGF3siXuSNkGmFb0zkZS9AMQKaiqM?=
 =?us-ascii?Q?D4Ue08jGP5m9TfHu+8X50QEwyjv+obvQS9ndf9SrkoZBxqD0VhhqaT8HevB+?=
 =?us-ascii?Q?MNKx5E6IL1goUX3+eY6c9FytFoCHsuxurblHXlEgXIbaKdutgKLU+IyqnBkm?=
 =?us-ascii?Q?BBneM8RE11sqsqIrG5yMQ6yhcWkOfRTsWMvcbZdswlpI2oodsx0MSL6Io9/r?=
 =?us-ascii?Q?Z5Eo2caH02mx9PiHJHV9L0/6RNZ5itzBLJGqxLIlPP09rrcdsjhfLF/pnnIa?=
 =?us-ascii?Q?LhFlQqVtWfs/4U6f/ecZSbwuef+hJ6tJQ74DnYPzI4l/Zu+b08fiHfQ7KuTf?=
 =?us-ascii?Q?S/jb+XTah5vNVUqZaoT+PSmkOXy+m9CzKeNLOGvk9yf892b1hIlAIiWo6Vin?=
 =?us-ascii?Q?Y1zXIrT9It1ebT7LW5WJ+bFeGXDuuD+NdElLanehQ+y6yF717aDPDkXgAdqj?=
 =?us-ascii?Q?F3YmtaSx07Q2dYZFx85suTYjaCEAzZbdJGh/ZZv3kXqDuVDV4JnT5A5sFEsJ?=
 =?us-ascii?Q?W8R1lCJv7QxblAHWJe3VN7bRSWyFlU//nm/7BN4x7V6368MlgEOiQPqWdNvj?=
 =?us-ascii?Q?xct7XHilF3pHO7uwGWGU5ikFlz4P0matMIIM3zB71VXMA+AQ6P+6WVTTpFtS?=
 =?us-ascii?Q?ZAAMiUnPm3tE0hzx/brmNjM7HvLVhoMDAfw2fwKJW+/hCoqZhneSbdhry+K1?=
 =?us-ascii?Q?TKyYEQyqC+ygtsoLc4/Lg1bPePnJTCArUFYeF5T9LKjXiXXZ8q4Q/qQHKwHj?=
 =?us-ascii?Q?ks/wfV/+dMWbv7rydRExELVNhJ9/gi3OCTJXnpSUvzTWrG9gpEYFYmTC7equ?=
 =?us-ascii?Q?uoeWfkbt2dFld+/KzreSko2+OnZZZUP+hvjEtpmdcwH38qNlk21cdXEtB2eJ?=
 =?us-ascii?Q?JlsChyruq0vYfHtt6ROo+meudSW6FaDGIMXxD1mDEjPLxP6Nl0/Yu3G3qiKM?=
 =?us-ascii?Q?bOLWLofjXcv3sAabbr797C2KJDNfTFzvF/JfwV+BV7Sf4gk83cyMAk70p3DI?=
 =?us-ascii?Q?f23plUaEFMXrGqeGEFup4Ek49ViAKprhTIML8/wLmniV3/sm1B5/Zvka/qUh?=
 =?us-ascii?Q?AkWkIWopnvSkQBSTdKO8pMoTxtibnKCa2u+8Mgn6T2b6NCE8dxoGDdbjOO4f?=
 =?us-ascii?Q?LNx6inKSMNYk5JvgHhbPd+DST3Me+L1WhBQjkwNsVZT2yX/LYqFdD186JIc6?=
 =?us-ascii?Q?R5boYjNyBEYVTSxFvE6SrqkTScemj5/GXAubPD/llqAYo4waKEoZ7eLo5uPh?=
 =?us-ascii?Q?rA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	sD//uK7m8uKU154M0gVzfon5lDjC5yXl1RUyoF/1pRu0WWY3TzbS242P8UshcOV1nmAah9CP7JQsH98KX1UdqzdhjmJlWG6lGVzk+h7bTeu6Si+sWWt0vLfUSOPgMEB0lbeSaEY7wEZ/KGE0hmUwkMmWslosQFjx3iVqbY+cEc890LX2K7K0FiyqCbqwtV/IrJGNJUNJUODVmJrKSsfBED0IUvaXIzr/ohDoX/p+hf7vTrT/LMl9KWXfqqlrKCloVZIXDTt70lGOxT2qsj994BO0WLElugxr4VF/Ib5fcO0UasFs4rZZhODB/Semt8jcqeexraJJuSvZG0fQt+d3lv2+iml8xLUao2JaO1gsScAgL9UllDUlK/KPynFRU3yXXinPGXroJzHGKoqmnDCbo/eOJUl/cQhmrp3oFQZ67e7Z5wkEobCMsW0zkaDSAWsTORg3hISh5oB/eq2SNtwZvatCOUBiWY8gRaZJxZrWWGI6OIiMQPUIQvyPN6RezyuVcyr91kT1gbOTdI7dPz1lDZ/vdM0rN+Q/MUNHfx4eMBHr8/W24X2LXK3jlV5cLdWPdVZm0jUyOs3jbz2Y9GROD/u4zrGNed/O7wWZ0x/+8n0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e0d12de-a988-4232-6a53-08dc6dcfde7d
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2024 13:24:33.8858
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JkidoBumYcU71N/Xi5+os8Uxt8KqeYRTMSljbjlXMCJgOtmTqQx/ttvKNV2katZRSz3LPn9gIU3jS1A48HEalQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB5723
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-06_08,2024-05-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 mlxlogscore=995 bulkscore=0 mlxscore=0 adultscore=0 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2405060092
X-Proofpoint-GUID: jRyE8rmmPHuU1tGpL_cytTMj1-KQ8nS4
X-Proofpoint-ORIG-GUID: jRyE8rmmPHuU1tGpL_cytTMj1-KQ8nS4

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

Here's a status update.

---

I've pushed the NFSD backports to branches in this repo:

https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git

If you are able, I encourage you to pull these, review them or try
them out, and report any issues or successes. I'm currently using
the NFS workflows in kdevops as the testing platform, but am
planning to include other tests.


LTS v5.15.y

Work on backporting the NFSD file cache fixes to v5.15.y is now
complete. Subsequent fixes and changes will go through the usual
-> stable@ process.


LTS v5.10.y

I've updated nfsd-5.10.y to include the patches and fixes that
were included in nfsd-5.15.y. You can find these patches in the
"nfsd-5.10.y" branch in the above repo.

This week I intend to set up CI testing for this branch.


-- 
Chuck Lever

