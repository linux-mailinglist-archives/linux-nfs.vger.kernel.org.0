Return-Path: <linux-nfs+bounces-3648-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88CEE903E03
	for <lists+linux-nfs@lfdr.de>; Tue, 11 Jun 2024 15:55:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A37C1C21C01
	for <lists+linux-nfs@lfdr.de>; Tue, 11 Jun 2024 13:55:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB52D17D35F;
	Tue, 11 Jun 2024 13:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VDvl/3QI";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="KBIsWIAZ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C922E17C221
	for <linux-nfs@vger.kernel.org>; Tue, 11 Jun 2024 13:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718114100; cv=fail; b=gvnryBvhS9kpwWFOaRg1aP5OOo9K4sc0EaBEykGwIUG1VFy7tjpP5IFvkqDvbyegdVo81XIwnoewA1czNX/+okoIcDbqIGI4QWU7U7PmpIgx93GgGYb5b494cQ1UXwcNGtevS3N8Pyj7Rg48x/xTiZ285CdffA00p0rJIZnOzRM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718114100; c=relaxed/simple;
	bh=3Cn+WttPBid11FGCuPW2NaoYFGmuD0SXo0ctg2lLReo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=AuiC2rzm8RrpLl/iz6IuJbJBUlkPl0R8QwMaz9rX9PKgJgw47DRxhBoJtDtzSJIoECPUbcup5sYZdSU03DD+USM3MZEHncvXkTKPrU1UNgNVT9mBBQDx6oTTt004hR+VBAewEMbpxFyWK1/SZ3BGNEPaZAp1gEZh5hUtMW1DVqE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=VDvl/3QI; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=KBIsWIAZ; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45B7ffhc009134;
	Tue, 11 Jun 2024 13:54:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-id:content-transfer-encoding:mime-version;
	 s=corp-2023-11-20; bh=3Cn+WttPBid11FGCuPW2NaoYFGmuD0SXo0ctg2lLR
	eo=; b=VDvl/3QIuH4VIblxhgUqouHsCoiP8ixazHf0/t1679PN4HvZv6PE3OfoO
	zVLJxiVau2Zlgij0KQvBnVD6So8UgFdNgk6ygev4YLRQz+TV6ahywfIFXoHhCZrh
	Ur1WxOAnM5p7lLsdWq7p9ZH26eVrS5jHwI0tU+BtPzrTyNWeqqOqO3LKtydi91CV
	sDBUoOV/lbopLOk/ovnW3aODoQ1ougTU8P0lsjs4JABGKZS8UB6V8booMPVgZnWw
	iBoch5W+po4l+TiyfpEzT6MoPqJhGYoq38pmF1fMX2wiCLcBahRHCNfGd2es5Swh
	RQn4Me/p+67w61plI36alF61kBqOw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ymh194vt3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Jun 2024 13:54:34 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45BDSPwZ027082;
	Tue, 11 Jun 2024 13:54:33 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2175.outbound.protection.outlook.com [104.47.55.175])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3yncdt90j0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Jun 2024 13:54:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aBmQcdtrZVLOey0U9uoKBmU3AXzpwiuRLWKLTl9CSRgUm0kZjlwnK2e4tzync9C1SaCgMkXSKLMK0YcS/xWzT4Jhro5abeY+sFtewk4abiT9VOIWaMUMrfnJA656AyE4s54KKslTpSQKsoIjSQ1owvde06jU1vZZ5+IYuJifhhIom196zkPs+TRcqKrRrd7+n7ki9Sw4lQxn8lQ+a+tRytCtoD8gyJZ3eW03mRMDtzKHr0rnESsrLG4dIXuh27sYBMyCg4P0bdVCLqfMz3KRY7NIv+ACt52IMRizbDGtPIVzenyk0tcZoiE95fmw+9h9c10BKGarC2VlZeFlhd3GEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3Cn+WttPBid11FGCuPW2NaoYFGmuD0SXo0ctg2lLReo=;
 b=P87RpcLYCi1FcTeqISclV0zP0uWP3uboVcSqibRHs08SOWXVjhN3On7fNAusw7+c2r1kfQIh9CdUQMlXhF2N88MtmgaC7mfu+/vIpIt19tK1oDQWox+NQQ/wWOS8BMRYT184q/PvqW8R1oSkaRmG91x/+FGoXLypUfvjS8B7hP5LJ/kFH5olwPvMELLoNjaqKZQGUFnnXz+eBSGL5li2ETnXZfn8Pup54+m20oGG2UnlEGl548kQzoj430htbtF40yiJuq6cdYIyQ+aqogPHVy9hHOacPX6BvaTdsSJ42KGTD7msDkrDQQ96ljp+eU2JqHQwQY/nsI5mavkJXcackA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Cn+WttPBid11FGCuPW2NaoYFGmuD0SXo0ctg2lLReo=;
 b=KBIsWIAZ6CcAyzwhjh2aUkZIF7j5shnwf2+YA9E4gDUQlggSvw2+MvdJ60dd43iJnqYQu6kclmPfmJoh0ibJC2sazjzhVYBefTItd5lMR6nP/WKCgD84MEI8ZZJb95O6qSIPt9ZlvwsSuVce5wHsKKMyBuKsVkZLdagnu4SjAUI=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by IA0PR10MB7578.namprd10.prod.outlook.com (2603:10b6:208:491::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.37; Tue, 11 Jun
 2024 13:54:30 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.7633.036; Tue, 11 Jun 2024
 13:54:30 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@hammerspace.com>
CC: "hch@lst.de" <hch@lst.de>, Chuck Lever <cel@kernel.org>,
        Olga Kornievskaia
	<kolga@netapp.com>,
        "jlayton@kernel.org" <jlayton@kernel.org>,
        Linux NFS
 Mailing List <linux-nfs@vger.kernel.org>,
        Neil Brown <neilb@suse.de>, Dai Ngo
	<dai.ngo@oracle.com>
Subject: Re: [RFC PATCH] NFSD: Support write delegations for pNFS LAYOUT
 operations
Thread-Topic: [RFC PATCH] NFSD: Support write delegations for pNFS LAYOUT
 operations
Thread-Index: AQHau0eVxlpBviu150aNjUMTUsO/27HBLfSAgAAW9wCAAGeeAIAA5H+AgAAGHoA=
Date: Tue, 11 Jun 2024 13:54:30 +0000
Message-ID: <4E9C0D74-A06D-4DC3-A48A-73034DC40395@oracle.com>
References: <20240610150448.2377-2-cel@kernel.org>
 <30924327aaee17182a83e18bc86e6a27a19d88ab.camel@hammerspace.com>
 <Zmc7UOSMmeGcqkBa@tissot.1015granger.net>
 <0f25c54fde0089aa642de9e34fed0814dac8da17.camel@hammerspace.com>
 <8b882658-da3f-47ba-abd0-08656153fddd@talpey.com>
In-Reply-To: <8b882658-da3f-47ba-abd0-08656153fddd@talpey.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.600.62)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|IA0PR10MB7578:EE_
x-ms-office365-filtering-correlation-id: 3e67ff8f-29b5-464f-a7cf-08dc8a1e0476
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|1800799015|376005|38070700009;
x-microsoft-antispam-message-info: 
 =?utf-8?B?K1huTkRmVERBYjZwaDR4QnVBd2R6UVlkTE55aUxuZnQxOFNuTjNrMFZjcWow?=
 =?utf-8?B?WXljRWVVcjZPVDA2SzBwYXByZzdBOG43OVRRbmljN2VSRUVEbjRBaWtSZ2R6?=
 =?utf-8?B?cWNibFB0Sk8vVTVvTWRIQ2lRMFVDV0tObDBaSmFkU2lZNGFONEc4R3d0b1RJ?=
 =?utf-8?B?OWRDbk9weUtsVjlmUEI0bWY4emFobjM0ZlFSRENjSnJ1bWpWbWFlOGt4ODlI?=
 =?utf-8?B?OUY1aDJuQXNIbUlYWFpiWXNqWWttMzBobWNDaVR4RndWeDVBZFYxblpCdmdM?=
 =?utf-8?B?L0hJelpoU3NzR1BORWF3Ukt5Vk9rbkNwZDk3V1NwVUNrUWZYdjg4TjZCeFJm?=
 =?utf-8?B?UmIyQ0ZlbEFUNzJkTTFUNkVIdjA5SzAwMlNIRXo3dm5oZmJ6R1RmL1dqUGht?=
 =?utf-8?B?M3FpSGovcnNKUXJxbUkybi9OQ3haVGFkTFFrZENsd0JiTDNmZ1F5aXNzaXVD?=
 =?utf-8?B?WVRJb2pvRS9tZ05JRUNlYkdtS2lrZmo5YVNzbFJReCt0KzNzbXVYY1Q5SDJv?=
 =?utf-8?B?Uk80YmRnMmg4cXd0TUsxckFwNWZxZzljK0ZkR1hzY21DYkJuZnpGSG40TVY5?=
 =?utf-8?B?MVNwU2hwZURZSG5RejVPdUkyT0tGMzlFbldOa0hELzhZcnNOUWh1UE9LVFlF?=
 =?utf-8?B?YWxNbjR0WmRvRHh3a2xsSjZ6ZTl1ci9rZFVudjdlL0tmdGlIWVdrVjd3Z3ZX?=
 =?utf-8?B?d0pBWG5uNFg0cmw0b2VsZ1ovTmtvRStZRy9sUjgvRjhyWHcxenl1cVhldklP?=
 =?utf-8?B?YXlPdjdROVpKdkF4c0FoS21pbWZCL1dCWVB4QUpLWFRnK3hVL2V0Y0o4Sk1q?=
 =?utf-8?B?eUZ5dGQydjViUDMvS2ZPUWgxWFhmT1dhTE4rblFQYi81azcxalgxV2dkQUNY?=
 =?utf-8?B?NnJpYnp0UkRlU1dEcUhLbFJ2MmlwelZDR2FTSnhJOG1KRmdDa0NXWW1rOENv?=
 =?utf-8?B?VWxOZXBvVVF1eHovTmtVU09aZUU3RXNvd1VYT1hVRmgrNGdvaVpYcGJlWlJB?=
 =?utf-8?B?djVQZDZiUkJJamFQbzkydkxTbmRxcUxKSHZCd0tOVEV6VFMyRDBUODdKa0tp?=
 =?utf-8?B?aDQ1bVlEdTZ6TmdwYUtPQzJrZjlxOWs2djk5TitwcnI3RjBoam4zVHR1ZUU4?=
 =?utf-8?B?MU5EQzF3a2ZLc1QvaEpyMC9vR0N1bnFOVUFnd3plNlNIb1F4UEtIbEZmU1l5?=
 =?utf-8?B?RXJobW84YzdodUJNcU9ad0pDUjJiY1dvSTdmcndtTUFIYWxmVXk5eXZwdU5k?=
 =?utf-8?B?NTlzZnR0Mzh3Mi9yUXNBS1pCeUsvNnJiamMrUGExQVMzaGtZWitLT0RUS2tP?=
 =?utf-8?B?Ukl5S1JzNk5DaTNBWm5JQXZmOHVxbjE4cml6VG5yQXZLS2lJcExvb0FYVkgx?=
 =?utf-8?B?dlBwaWtmVXVhV3VsditkMXJjR3labTZZRjFCL3dVTTl0eG1xM0tZMndhSUVu?=
 =?utf-8?B?MTFSZE1tUXN2cXhEdTJXeG14c0lSOGpqdjV1RFd5Sk1mWmE0YU5pc3V3ZjNT?=
 =?utf-8?B?RG40d0llZy93Ym0vcmdZSlNuKytzdXVwTTM3TUhISlZhUnJUNE01WlRoUGJS?=
 =?utf-8?B?M1VBb1U4aUxrVjkrYlVaUE54a1pMZkdPOVJlTmJxSGYwMVNpUWFNZDdXN0hO?=
 =?utf-8?B?TmlBc0hCQ2dFYWF2UXZ1REo5dmRTMWhyZHh5WGNyUkpaWG9tUnY0MzI3OHJs?=
 =?utf-8?B?SmJYZzhSWFpYd0hBOVFzNDhxT1BTeURGZ25LTkQ1TFNTUmtISDAzTk9HQUlx?=
 =?utf-8?B?KzU1eTRTM3UzbDR1TkdUeWdwOWExcklpeDNxdGNZTUJiSGQ3N3NTekNSQ3ZG?=
 =?utf-8?Q?4R41s7JM9PlUBV03XPTQBozDn2wTcFUFX33yM=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?TC8yVDZsckQxMGhkbWczZ0Fqa2hBdnlsWHJHcGVmMUlsWWRsdjYrTXNuaTQz?=
 =?utf-8?B?dmtkZlVqR3AvZ1lpaXlHVmNSeFdaY0o4UWpLK1F4Ri9jb3d2azhYV1RRS1ZY?=
 =?utf-8?B?Q0RKOGgzZFRjSkNhc2JwRE9BSlFQMHQ5QnY2YUd2WmVFZ0VPVjRla05jT1M4?=
 =?utf-8?B?MkFZOFl4clFXUjRQOFA0S0o5U2xKSHNRUlJoNCtOcFpUcnl0UmpvTEpSVDhN?=
 =?utf-8?B?V1BZa0MzZE9BTndUWTFodlNROXJTQW1PR3NnbGxpQzg3UkZoeU9KUXgvOU5p?=
 =?utf-8?B?eXBQTGJuSXdTVGI3UW53em4vSVlYZ0pUYm01MzdMQ2tjWm5pdnQ1OTF3a3Bv?=
 =?utf-8?B?OUtDOUFIUGFheWRNRU9OZWRSTitkcmh4Y2tmcm0zOUFQdkVkZHFNdVh2RE12?=
 =?utf-8?B?bEdYNDNra1RrOThJTUZsTVFJTGpNb2VIOFJqZVpVQTVUeGJKemQ5a3hvSDh1?=
 =?utf-8?B?cWtlZVFwaUNyK2syM1pvV1Y4S2grZ1BoTFlzbEZvcUFibVRjSXdZbDNSUUZM?=
 =?utf-8?B?eW5tTUJOSmxiVHlWMERPSTNsYmhjUmRqQXZxVUF6M0hzRWdpUzJUV1NPcUp4?=
 =?utf-8?B?SWxZcXFaSStPNzRadnNZME9Ba09pcmpyUnoybExDRzQ1dGlBVEQ2MDVwTGt6?=
 =?utf-8?B?RnRhZmlUcVVqaVYxNWpCbTJBckI2cko1MnV4dHpjQVpFOTVLQWtpWjlTcVN0?=
 =?utf-8?B?ZE03ai92QVl0OVZsZDlacm9BRk1xVE1odWs3ZGtmSExLQVl2Zi9mS0xFbkFS?=
 =?utf-8?B?Z0t4cytHcmNLQWRzN0cwQlF1ZWFMYm1QbFhVWFZQOGVJSDdUVHRFbkpmVU1X?=
 =?utf-8?B?d3BhRDFpMzNlTmZ3bUZjaU5Rd2ZaTW1tWFpZVXk4UDJsd1FxQnRCWklJR0Er?=
 =?utf-8?B?b05NVTZ3WThwVDMzYjMvV2Z0Q1piZUF0MCs4NjZjdUsxc1BTWHVYaHBDZy9H?=
 =?utf-8?B?eWJtQ3hhdXpmMmlydzdQUEkzZkhNTWpEczZqWHV6dXc2N0xCK1QzYXNLRmlY?=
 =?utf-8?B?elJvMWoyODFqWCs3akN1QmZ0YjczSGNwZnBPWk5ncUNmUkdCc3BtcUx3WnY2?=
 =?utf-8?B?MkNFNDFVcXp4Yk1MejN6QXpqTXlIbjZtYjRCYkl3Y25uTlNJWEEwWE51OXNW?=
 =?utf-8?B?YllEZU9JV3hBQUVQaGZlNjZIalhMOXVxdGcwREdzd0R4Q2RqYTFnOER4TE9X?=
 =?utf-8?B?K1pwL0xGODhLajB5OFNoV0w3a0Q0VkpYUEtDSnlFbVM0RzJqWFhMYXErM29C?=
 =?utf-8?B?aGtLMS9FRjdXSHRSZjhoaU0razNNR2VuMFlzcWlndFRvQm9yaWxibllxdGdr?=
 =?utf-8?B?RlAveHNRSmFPWms4M0Jsak8wZWtLbkVQWDg1TXhwdVFsSFFNL2ZGYnJGOUlm?=
 =?utf-8?B?djRkL2JGOUJPVlRNY1ZYMi9iQUY4OTNqQ1IrZGhjVk9naEI2cjMxRHFNNHhQ?=
 =?utf-8?B?OUdrME1JeW9uK2dkSHBSWkVRZnVQWklNSHRtWnBJeHp6Rm16SWhYRlliOHZh?=
 =?utf-8?B?SWNIUyswZVZNV3ZiaGZRcUJudzR1UURZbTU0ajZOYmJYRUxHYlE0bjc0YlZm?=
 =?utf-8?B?MUJVVFpkbUxYbFdNWHFMSzVjVUd6MFUrNUV0SExScjExbEM5SFltUHkzZm1J?=
 =?utf-8?B?a1BQVndlazlwY1RGMzZjeGpTY250dS81VFdQVzdONERralpuTlRyMHd5aVAy?=
 =?utf-8?B?ZXY4RnBQWkx1eTRDd0VtbE01cGFXcHhDTXV4N1dXSWtGRXZxYjVrL2JUT2d1?=
 =?utf-8?B?NHVFZURHbmJ1UUdTWDJlZ2k2aEN6N0ZKdUQ5UjMxdXZMeDduVWQ2MXBnSTNK?=
 =?utf-8?B?UnpFM1FRZzFKakVydjB6d3NmaGtmMll1Q0lXNGZmQWNRZDBiVUJmQlY5ZUYw?=
 =?utf-8?B?dXRMQzdPOGJkTmQ1RzZSWi9qVE1NWTdacjQ5MXIzWktIUlk5SkJzc211VEpO?=
 =?utf-8?B?eWZDMElyV3RzV09xclYrcjZCblFHZjVHS0FLd0Jzem9YeEVrWW0yNUxqWTdx?=
 =?utf-8?B?UkpDeDlHbXlZbC84YUV5K1RCL2xlVFVQdmFiSm5ibXd0S3NNckkxSUlvQVFz?=
 =?utf-8?B?OERtNFRJdUorVHY2SEtpSEh5cmE3WmFmR3ZUZURyRjFxdzV5Nyt1UmN5WVNK?=
 =?utf-8?B?UVlUR2JlYU9tZGFWUlRVS0M5NW9LRkRYZDd4ZUJtNitCUFQzWkloRnBIOU1h?=
 =?utf-8?B?cFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <67FCF0139E1F424489F18C0381359717@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	4efIVwsw5V9fNMp7kWn6Dn4qOJ3c5veag3hKQ5tP2uD8RQ4QXFZmF+8YAvTAaAob4j10yGMrJoxvX/hZ7IDHJ8XDmGe23K7YViUHI+OcTxg4flkZu6JFn7i0/NHdRO1hFxu4iiKaSY/d5SYkJI+vWONm53jGxeJbp6Ng01QOpNzgtf9pySOShKzt30IfmvSUOx3UNRAOtZvyogHbBv7WLBWnE21vjYTQxoz4Tz9o+2/QP3BXY248xPSSiAnZPtbOy6WysiVdi4rq8R6/3cdIe/P6I0wNj0D6PltB0mov5Rr9wSFsVyX24SlBPpfm1LiXB7fIhAgKHu2rToMV4qWfBudcYo1csZRfQ9b7U+6RLEHGvFEdYMQnLzfmq3+Dhf951d82uvSr+OI0sNTZA2iEYLJRrlxs9ghq3NwqCBrBvxirUvcBsjJZErnX6MUWpgjZ7wu9iHGIU3goM7Ks70wFaTNUbvR/QQIvzB0TlHDZHE6rffFS1us11c+OcyNuHfQZ4Y3jSn6bD2RM6ZucYEf5mF433s+wGcRM8SZcAw540O5ul39Xsq7xqMMKJDW4ltQkMwAeTofJNU5wxIRMwJjAclyQlDil/VHId5wy/tjja+o=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e67ff8f-29b5-464f-a7cf-08dc8a1e0476
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jun 2024 13:54:30.7858
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CCA/aFxqeFZ6Yk3RLBds/YLkpojUer2oXSZ1DOSX50DEHqn3ZKwWgVEk4TCtiAEHQWVXGl1sK5pA+QPGt6hCJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7578
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-11_07,2024-06-11_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 mlxlogscore=999 bulkscore=0 suspectscore=0 spamscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2406110101
X-Proofpoint-GUID: nVutzhFNsve8BXmG5ZEWqOoPxcx2Tc3I
X-Proofpoint-ORIG-GUID: nVutzhFNsve8BXmG5ZEWqOoPxcx2Tc3I

DQoNCj4gT24gSnVuIDExLCAyMDI0LCBhdCA5OjMy4oCvQU0sIFRvbSBUYWxwZXkgPHRvbUB0YWxw
ZXkuY29tPiB3cm90ZToNCj4gDQo+IE9uIDYvMTAvMjAyNCA3OjU0IFBNLCBUcm9uZCBNeWtsZWJ1
c3Qgd3JvdGU6DQo+PiBPbiBNb24sIDIwMjQtMDYtMTAgYXQgMTM6NDMgLTA0MDAsIENodWNrIExl
dmVyIHdyb3RlOg0KPj4+IE9uIE1vbiwgSnVuIDEwLCAyMDI0IGF0IDA0OjIxOjMzUE0gKzAwMDAs
IFRyb25kIE15a2xlYnVzdCB3cm90ZToNCj4+Pj4gT24gTW9uLCAyMDI0LTA2LTEwIGF0IDExOjA0
IC0wNDAwLCBjZWxAa2VybmVsLm9yZyB3cm90ZToNCj4+Pj4+IEZyb206IENodWNrIExldmVyIDxj
aHVjay5sZXZlckBvcmFjbGUuY29tPg0KPj4+Pj4gDQo+Pj4+PiBJIG5vdGljZWQgTEFZT1VUR0VU
KExBWU9VVElPTU9ERTRfUlcpIHJldHVybmluZyBORlM0RVJSX0FDQ0VTUw0KPj4+Pj4gdW5leHBl
Y3RlZGx5LiBUaGUgTkZTIGNsaWVudCBoYWQgY3JlYXRlZCBhIGZpbGUgd2l0aCBtb2RlIDA0NDQs
DQo+Pj4+PiBhbmQNCj4+Pj4+IHRoZSBzZXJ2ZXIgaGFkIHJldHVybmVkIGEgd3JpdGUgZGVsZWdh
dGlvbiBvbiB0aGUgT1BFTihDUkVBVEUpLg0KPj4+Pj4gVGhlDQo+Pj4+PiBjbGllbnQgd2FzIHJl
cXVlc3RpbmcgYSBSVyBsYXlvdXQgdXNpbmcgdGhlIHdyaXRlIGRlbGVnYXRpb24NCj4+Pj4+IHN0
YXRlaWQNCj4+Pj4+IHNvIHRoYXQgaXQgY291bGQgZmx1c2ggZmlsZSBtb2RpZmljYXRpb25zLg0K
Pj4+Pj4gDQo+Pj4+PiBUaGlzIGNsaWVudCBiZWhhdmlvciB3YXMgcGVybWl0dGVkIGZvciBORlN2
NC4xIHdpdGhvdXQgcE5GUywgc28gSQ0KPj4+Pj4gYmVnYW4gbG9va2luZyBhdCBORlNEJ3MgaW1w
bGVtZW50YXRpb24gb2YgTEFZT1VUR0VULg0KPj4+Pj4gDQo+Pj4+PiBUaGUgZmFpbHVyZSB3YXMg
YmVjYXVzZSBmaF92ZXJpZnkoKSB3YXMgZG9pbmcgYSBwZXJtaXNzaW9uIGNoZWNrDQo+Pj4+PiBh
cw0KPj4+Pj4gcGFydCBvZiB2ZXJpZnlpbmcgdGhlIEZILiBJdCB1c2VzIHRoZSBsb2dhX2lvbW9k
ZSB2YWx1ZSB0bw0KPj4+Pj4gc3BlY2lmeQ0KPj4+Pj4gdGhlIEBhY2Ntb2RlIGFyZ3VtZW50LiBm
aF92ZXJpZnkoTUFZX1dSSVRFKSBvbiBhIGZpbGUgd2hvc2UgbW9kZQ0KPj4+Pj4gaXMNCj4+Pj4+
IDA0NDQgZmFpbHMgd2l0aCAtRUFDQ0VTLg0KPj4+Pj4gDQo+Pj4+PiBSRkMgODg4MSBTZWN0aW9u
IDE4LjQzLjMgc3RhdGVzOg0KPj4+Pj4+IFRoZSB1c2Ugb2YgdGhlIGxvZ2FfaW9tb2RlIGZpZWxk
IGRlcGVuZHMgdXBvbiB0aGUgbGF5b3V0IHR5cGUsDQo+Pj4+Pj4gYnV0DQo+Pj4+Pj4gc2hvdWxk
IHJlZmxlY3QgdGhlIGNsaWVudCdzIGRhdGEgYWNjZXNzIGludGVudC4NCj4+Pj4+IA0KPj4+Pj4g
RnVydGhlciBkaXNjdXNzaW9uIG9mIGlvbW9kZSB2YWx1ZXMgZm9jdXNlcyBvbiBob3cgdGhlIHNl
cnZlciBpcw0KPj4+Pj4gcGVybWl0dGVkIHRvIGNoYW5nZSByZXR1cm5lZCB0aGUgaW9tb2RlIHdo
ZW4gY29hbGVzY2luZyBsYXlvdXRzLg0KPj4+Pj4gSXQgc2F5cyBub3RoaW5nIGFib3V0IG1hbmRh
dGluZyB0aGUgZGVuaWFsIG9mIExBWU9VVEdFVCByZXF1ZXN0cw0KPj4+Pj4gZHVlIHRvIGZpbGUg
cGVybWlzc2lvbiBzZXR0aW5ncy4NCj4+Pj4+IA0KPj4+Pj4gQXBwcm9wcmlhdGUgcGVybWlzc2lv
biBjaGVja2luZyBpcyBkb25lIHdoZW4gdGhlIGNsaWVudCBhY3F1aXJlcw0KPj4+Pj4gdGhlDQo+
Pj4+PiBzdGF0ZWlkIHVzZWQgaW4gdGhlIExBWU9VVEdFVCBvcGVyYXRpb24sIHNvIHJlbW92ZSB0
aGUgcGVybWlzc2lvbg0KPj4+Pj4gY2hlY2sgZnJvbSBMQVlPVVRHRVQgYW5kIExBWU9VVENPTU1J
VCwgYW5kIHJlbHkgb24gbGF5b3V0IHN0YXRlaWQNCj4+Pj4+IGNoZWNraW5nIGluc3RlYWQuDQo+
Pj4+IA0KPj4+PiBIbW0uLi4gSSdtIG5vdCBzZWVpbmcgYW55IGNoZWNraW5nIG9yIGVuZm9yY2Vt
ZW50IG9mIHRoZQ0KPj4+PiBFWENIR0lENF9GTEFHX0JJTkRfUFJJTkNfU1RBVEVJRCBmbGFnIGlu
IGtuZnNkLg0KPj4+IA0KPj4+IEkgYXBwcmVjaWF0ZSB5b3VyIHJldmlldyENCj4+PiANCj4+PiBJ
IHNlZSB0aGF0IEJJTkRfUFJJTkNfU1RBVEVJRCBpcyBub3Qgc2V0IGJ5IE5GU0QuIFJGQyA4ODgx
IFNlY3Rpb24NCj4+PiAxOC4xNi40IHNheXM6DQo+Pj4+IE5vdGUgdGhhdCBpZiB0aGUgY2xpZW50
IElEIHdhcyBub3QgY3JlYXRlZCB3aXRoIHRoZQ0KPj4+PiBFWENIR0lENF9GTEFHX0JJTkRfUFJJ
TkNfU1RBVEVJRCBjYXBhYmlsaXR5IHNldCBpbiB0aGUgcmVwbHkgdG8NCj4+Pj4gRVhDSEFOR0Vf
SUQsIHRoZW4gdGhlIHNlcnZlciBNVVNUIE5PVCBpbXBvc2UgYW55IHJlcXVpcmVtZW50IHRoYXQN
Cj4+Pj4gUkVBRHMgYW5kIFdSSVRFcyBzZW50IGZvciBhbiBvcGVuIGZpbGUgaGF2ZSB0aGUgc2Ft
ZSBjcmVkZW50aWFscw0KPj4+PiBhcyB0aGUgT1BFTiBpdHNlbGYsIGFuZCB0aGUgc2VydmVyIGlz
IFJFUVVJUkVEIHRvIHBlcmZvcm0gYWNjZXNzDQo+Pj4+IGNoZWNraW5nIG9uIHRoZSBSRUFEcyBh
bmQgV1JJVEVzIHRoZW1zZWx2ZXMuDQo+Pj4gDQo+Pj4gDQo+Pj4gVHJvbmQ6DQo+Pj4+IERvZXNu
J3QgdGhhdCBtZWFuIHRoYXQNCj4+Pj4gUkVBRCBhbmQgV1JJVEUgYXJlIHJlcXVpcmVkIHRvIGNo
ZWNrIGFjY2VzcyBwZXJtaXNzaW9ucywgYXMgcGVyDQo+Pj4+IFJGQzg4ODEsIHNlY3Rpb24gMTMu
OS4yLjM/DQo+Pj4gDQo+Pj4gRXZlcnkgTkZTdjQgUkVBRCBhbmQgV1JJVEUgY2FsbHMgbmZzNF9w
cmVwcm9jZXNzX3N0YXRlaWRfb3AoKSwgYW5kDQo+Pj4gbmZzNF9wcmVwcm9jZXNzX3N0YXRlaWRf
b3AoKSBjYWxscyBuZnNkX3Blcm1pc3Npb24oKSAoaW4NCj4+PiBuZnM0X2NoZWNrX2ZpbGUoKSku
IFNlZW1zIGxpa2Ugd2UncmUgY292ZXJlZC4NCj4+PiANCj4+PiANCj4+PiBUcm9uZDoNCj4+Pj4g
SSdtIG5vdCBzYXlpbmcgdGhhdCB0aGUgcmV0dXJuIG9mIGFuIEFDQ0VTUyBlcnJvciBpcyBjb3Jy
ZWN0IGhlcmUsDQo+Pj4+IHNpbmNlIHRoZSBmaWxlIHdhcyBjcmVhdGVkIHVzaW5nIHRoaXMgY3Jl
ZGVudGlhbCwgYW5kIHNvIHRoZSBjYWxsZXINCj4+Pj4gc2hvdWxkIGJlbmVmaXQgZnJvbSBoYXZp
bmcgb3duZXIgcHJpdmlsZWdlcy4NCj4+PiANCj4+PiBUaGUgYWx0ZXJuYXRpdmUgaXMgdG8gcHJl
c2VydmUgdGhlIGFjY21vZGUgbG9naWMgYnV0IGluc3RlYWQgYWRkIHRoZQ0KPj4+IE5GU0RfTUFZ
X09XTkVSX09WRVJSSURFIGZsYWcsIG1lIHRoaW5rcywgd2hpY2ggaXMgbm90IG9iamVjdGlvbmFi
bGUuDQo+Pj4gDQo+Pj4gDQo+Pj4gVHJvbmQ6DQo+Pj4+IEhvd2V2ZXIgdGhlIGlzc3VlIGlzIHRo
YXQga25mc2Qgc2hvdWxkIGJlIGVpdGhlciBjaGVja2luZyB0aGF0IHRoZQ0KPj4+PiBjcmVkZW50
aWFsIGlzIGNvcnJlY3Qgdy5yLnQuIHRoZSBzdGF0ZWlkIChpZg0KPj4+PiBFWENIR0lENF9GTEFH
X0JJTkRfUFJJTkNfU1RBVEVJRCBpcyBzZXQgYW5kIHRoZSBzdGF0ZWlkIGlzIG5vdCBhDQo+Pj4+
IHNwZWNpYWwgc3RhdGVpZCkgb3IgdGhhdCBpdCBpcyBjb3JyZWN0IHcuci50LiB0aGUgZmlsZSBw
ZXJtaXNzaW9ucw0KPj4+PiAoaWYNCj4+Pj4gRVhDSEdJRDRfRkxBR19CSU5EX1BSSU5DX1NUQVRF
SUQgaXMgbm90IHNldCBvciB0aGUgc3RhdGVpZCBpcyBhDQo+Pj4+IHNwZWNpYWwNCj4+Pj4gc3Rh
dGVpZCkuDQo+Pj4gDQo+Pj4gQnV0IExBWU9VVEdFVCBpcyBub3QgYSBSRUFEIG9yIFdSSVRFLiBJ
IGRvbid0IHNlZSBsYW5ndWFnZSB0aGF0DQo+Pj4gcmVxdWlyZXMgc3RhdGVpZCAvIGNyZWRlbnRp
YWwgY2hlY2tpbmcgZm9yIGl0LCBidXQgaXQncyBhbHdheXMNCj4+PiBwb3NzaWJsZSBJIG1pZ2h0
IGhhdmUgbWlzc2VkIHNvbWV0aGluZy4NCj4+PiANCj4+PiBBbHNvLCBSRkMgNTY2MyBoYXMgbm90
aGluZyB0byBzYXkgYWJvdXQgQklORF9QUklOQ19TVEFURUlELiBGdXJ0aGVyLA0KPj4+IEknbSBu
b3Qgc3VyZSBob3cgYSBTQ1NJIFJFQUQgb3IgV1JJVEUgY2FuIGNoZWNrIGNyZWRlbnRpYWxzIGFz
IE5GUw0KPj4+IHN0YXRlaWRzIGFyZSBub3QgcHJlc2VudGVkIHRvIFNDU0kvaVNDU0kgdGFyZ2V0
cy4NCj4+PiANCj4+PiBMaWtld2lzZSwgaG93IHdvdWxkIHRoaXMgaW1wYWN0IGEgZmxleGZpbGUg
bGF5b3V0IHRoYXQgdGFyZ2V0cw0KPj4+IGFuIE5GU3YzIERTPw0KPj4+IA0KPj4+IEkgdGhpbmsg
TkZTRCBpcyBjaGVja2luZyBzdGF0ZWlkcyB1c2VkIGZvciBORlN2NCBSRUFEIGFuZCBXUklURSBh
cw0KPj4+IG5lZWRlZCwgYnV0IGhlbHAgbWUgdW5kZXJzdGFuZCBob3cgQklORF9QUklOQ19TVEFU
RUlEIGlzIGFwcGxpY2FibGUNCj4+PiB0byBwTkZTIGJsb2NrIGxheW91dHMuLi4/DQo+Pj4gDQo+
Pj4gDQo+PiBJZiB5b3UgbG9vayBhdCBTZWN0aW9uIDE1LjIsIHRoZW4gTkZTNEVSUl9BQ0NFU1Mg
aXMgZGVmaW5pdGVseSBsaXN0ZWQNCj4+IGFzIGEgdmFsaWQgZXJyb3IgZm9yIExBWU9VVEdFVCAo
aW4gZmFjdCwgdGhlIHZlcnkgZmlyc3QgaW4gdGhlIGxpc3QpLg0KPj4gRnVydGhlcm1vcmUsIHBs
ZWFzZSBzZWUgdGhlIGZvbGxvd2luZyBibGFua2V0IHN0YXRlbWVudCBpbiBSRkM4ODgxLA0KPj4g
c2VjdGlvbiAxMi41LjEuOg0KPj4gICAgIkxheW91dHMgYXJlIHByb3ZpZGVkIHRvIE5GU3Y0LjEg
Y2xpZW50cywgYW5kIHVzZXIgYWNjZXNzIHN0aWxsDQo+PiAgICBmb2xsb3dzIHRoZSBydWxlcyBv
ZiB0aGUgcHJvdG9jb2wgYXMgaWYgdGhleSBkaWQgbm90IGV4aXN0LiINCj4+IFdoaWxlIHlvdSBj
YW4gYXJndWUgdGhhdCB0aGUgYWJvdmUgbGFuZ3VhZ2UgaXMgbm90IG5vcm1hdGl2ZSwgYmVjYXVz
ZQ0KPj4gaXQgZG9lc24ndCB1c2UgdGhlIG9mZmljaWFsIElFVEYgIk1VU1QiIC8gIk1VU1QgTk9U
IiAvLi4uLCBpdCBjbGVhcmx5DQo+PiBkb2VzIGRlY2xhcmUgYW4gaW50ZW50aW9uIHRvIGVuc3Vy
ZSB0aGF0IHBORlMgbm90IGJlIGFsbG93ZWQgdG8gd2Vha2VuDQo+PiB0aGUgcHJvdG9jb2wuDQo+
PiBTbyBteSBwb2ludCB3b3VsZCBiZSB0aGF0IGlmIExBWU9VVEdFVCBpcyB0aGUgb25seSB0aW1l
IHdoZXJlIGEgcHJvcGVyDQo+PiBjcmVkZW50aWFsIGNoZWNrIGNhbiBvY2N1ciwgdGhlbiBpdCBu
ZWVkcyB0byBoYXBwZW4gdGhlcmUuIE90aGVyd2lzZSwNCj4+IHlvdXIgaW1wbGVtZW50YXRpb24g
aXMgcmVzcG9uc2libGUgZm9yIGVuc3VyaW5nIHRoYXQgaXQgaGFwcGVucyBhdCBzb21lDQo+PiBv
dGhlciB0aW1lLCBpbiBvcmRlciB0byBlbnN1cmUgdGhhdCB1c2VyIGFjY2VzcyBmb2xsb3dzIHRo
ZSBydWxlcyBvZg0KPj4gdGhlIHByb3RvY29sLg0KPiANCj4gQWJzb2x1dGVseSBhZ3JlZWQuIFRo
ZSBNRFMgbmVlZHMgdG8gdmVyaWZ5IGFjY2VzcyBiZWZvcmUgcmV0dXJuaW5nDQo+IHRoZSBsYXlv
dXQsIGZvciBubyBvdGhlciByZWFzb24gdGhhdCB0aGUgRFMgY2FuJ3QgcGVyZm9ybSB0aGUgc2Ft
ZQ0KPiB2ZXJpZmljYXRpb24uDQoNCkkgaGF2ZSB0cm91YmxlIGJlbGlldmluZyB0aGF0IHNvbWV0
aGluZyB0aGF0IGNyaXRpY2FsIGhhcyBiZWVuDQpsZWZ0IGJ5IHRoZSBzcGVjIGF1dGhvcnMgYXMg
YW4gaW1wbGllZCBpbXBsZW1lbnRhdGlvbiBxdWFsaXR5DQppc3N1ZS4NCg0KVGhlIGJ1bGsgb2Yg
U2VjdGlvbnMgMTIuNS4xIGFuZCAuMiBkaXNjdXNzIGhvdyBzdG9yYWdlIGRldmljZXMNCm5lZWQg
dG8gaGFuZGxlIHRoaW5ncyBsaWtlIHdyaXRlcyBvdXRzaWRlIG9mIGEgbGF5b3V0IGFuZA0Kb3Ro
ZXIgY29ybmVyIGNhc2VzLCBpbmNsdWRpbmcgcGVybWlzc2lvbiBjaGFuZ2VzIGR1cmluZyBJL08u
DQpDbGVhcmx5IHRoZSBzcGVjIGF1dGhvcnMgZXhwZWN0IHRoYXQgRFMgdGFyZ2V0cyB3aWxsIGRl
YWwNCnByb3Blcmx5IHdpdGggdGhlc2Ugc2l0dWF0aW9ucyB3aXRob3V0IHRoZSB1c2Ugb2Ygc3Rh
dGVpZHMuDQoNCkJJTkRfUFJJTkNfU1RBVEVJRCBpcyBuZXZlciBleHBsaWNpdGx5IG1lbnRpb25l
ZCBoZXJlLg0KSW5zdGVhZCwgdGhlIE9QRU4sIExPQ0ssIGFuZCBBQ0NFU1Mgb3BlcmF0aW9ucyBh
cmUgY2xlYXJseQ0KbWVudGlvbmVkIGFzIHRoZSBwb2ludHMgaW4gdGltZSB3aGVuIGZpbGUgcGVy
bWlzc2lvbiBpcw0KaW5zcGVjdGVkIGJ5IHRoZSBzZXJ2ZXIgKGllLCB0aGVzZSBvcGVyYXRpb25z
IHByb3ZpZGUgdGhlDQptYWluIGFjY2VzcyB2ZXJpZmljYXRpb24gY2hlY2sgdGhhdCBwcmVjZWRl
cyB0aGUgc3VjY2Vzc2Z1bA0KcmV0cmlldmFsIG9mIGEgbGF5b3V0KS4NCg0KQmxvY2sgbGF5b3V0
cyB0aGVuIHVzZSBTQ1NJIHBlcnNpc3RlbnQgcmVzZXJ2YXRpb24gYW5kIGxheW91dA0KcmVjYWxs
IHRvIGhhbmRsZSBJL08tdGltZSBhY2Nlc3MgY2hlY2tpbmcuDQoNClRoZXJlZm9yZSwgSU1PLCBC
SU5EX1BSSU5DX1NUQVRFSUQgYXBwbGllcyBvbmx5IHRvIE5GU3Y0DQpSRUFEIGFuZCBXUklURSwg
YmVjYXVzZSB0aGUgc3BlYyBhcyBpdCBzdGFuZHMgaXMgbm90IHNhbmUNCm90aGVyd2lzZS4NCg0K
SG93ZXZlciwgdGhlIG9iamVjdGlvbiBpcyBub3RlZC4gSSdtIHdvcmtpbmcgb24gYW4gYWx0ZXJu
YXRlDQptb3JlIGNvbnNlcnZhdGl2ZSBmaXggZm9yIHRoZSB3cml0ZSBkZWxlZ2F0aW9uIGlzc3Vl
IHRoYXQNCm1vdGl2YXRlZCB0aGlzIHBhdGNoLiBTdGF5IHR1bmVkIGZvciB2Mi4NCg0KDQotLQ0K
Q2h1Y2sgTGV2ZXINCg0KDQo=

