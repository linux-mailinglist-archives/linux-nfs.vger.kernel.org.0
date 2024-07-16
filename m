Return-Path: <linux-nfs+bounces-4949-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7622293278C
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Jul 2024 15:32:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C252285481
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Jul 2024 13:32:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96FB1199EA5;
	Tue, 16 Jul 2024 13:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jm0cNqEE";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="BgOhDflE"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A60E81990CF
	for <linux-nfs@vger.kernel.org>; Tue, 16 Jul 2024 13:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721136734; cv=fail; b=Ku7eV0KyTH1lOpP67EOYffAafwrjzRYi37xksQU3cQcO8HxbkdNd4k0VpnlSKdGgjn/obVfGiDfOskTOJLAWs+GiqA+Ceo8ht0p4uBF508FWauDV+IwGuNnC7pLQANQAZYQy+iWr4P2N51UUilFl1Kxqw0fsdJbyZO8bBwgKUAs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721136734; c=relaxed/simple;
	bh=ZcpUltdqQMD2KVGqqFZP4YfJ0TWafdjeMGx2aWX8s+U=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=odr6jp72JPubbqPt2BU43JyAWaUK9DullYXIY8Ct8onEG0P20e2QF3+Yv6h9Lye/MCm7rRibzNXhidBhervOX6PP6I9gSV/97Al+QfgWMS9pIbWjKNktdZkg5PN7iPaRZID8y2AE30+gTaz1wtIQ4FnroaempTWMByK0ZWPAYu0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=jm0cNqEE; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=BgOhDflE; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46GBtAm5025577;
	Tue, 16 Jul 2024 13:31:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-id:content-transfer-encoding:mime-version;
	 s=corp-2023-11-20; bh=ZcpUltdqQMD2KVGqqFZP4YfJ0TWafdjeMGx2aWX8s
	+U=; b=jm0cNqEEDSFlEf8m2dAqbC+LLzKiPUzs1zbA0Vf8+pZvGGYBD9Am62/fo
	zFcmKE1Xm89rvB1gYEGJK1jWCwUb+LrvNVjl9zvpirxQoxo3urrp0EV56wAbJoDT
	Cl1I6Soz+l2jRUvBbkKRATaYPAtMFSl2mcw1v3OA9Rz2gdGgOokqhtm3G3hGarQK
	xE2YTRlD7+TZUu1SV9zS506myCT00LenpnS5lehDVdNNCeoyikzOtbssWLiK7eVt
	sVh8HU8gKvhSz4zPe7fCDS0PO8muXahmCRGa7yqsJBDkY2CCqYDgEYkN5lb0HUyS
	SxLIKHxNCUqO2VSpec2sdLVjchKLw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40bhf9dhga-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Jul 2024 13:31:49 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46GCmr5m010560;
	Tue, 16 Jul 2024 13:31:48 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2045.outbound.protection.outlook.com [104.47.70.45])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 40bg19jwpe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Jul 2024 13:31:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kob0DBxBZ037FUIIagmb2GN3H0sPSSwV+idiNpkFw56wJnY+++9JgOdXcMeDu4r9g/doYAe5R5tETtIHo0kjLJ2gOX3XZBAuRUE7IkOCkMbB86NKYzKVIZhoYJCMEZH/h2+6TcZ+GmiVOlvlwpQ9g8NDELt6aIjil2+d5wgVTjl9f6Be0DEa0snR3fbg50xaixbDTazuul0fL3zIQ59D0oyvqpde50UximIk6hwrq7oX2YW/pvCo5aSOBLZ0UEapJTUZ/s3vKVs3QLJkeT3ZQJJHhDFc9IHsg8t7XDIko7k9lUo2IVA4ESlH302pkMdK1DYFpTS6crdP4c2hrfjUVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZcpUltdqQMD2KVGqqFZP4YfJ0TWafdjeMGx2aWX8s+U=;
 b=vHAJeCLJyGE08cAiysYdTaKiWB8FAdA73f1QHk81gEVKno2QI7Cr5p8wfTFDc5UxEEiHVrm/wQ4ELYvEdcPBOuLE+mF9RvdiRYfoyUTrkBe8VcZCoAkuSgtoR+F7Ex5Z3HIJvillMdFxBQT9juj1VJVPpiu+qrco/nonUOClMXT8mh3d/Jnz0C2O8HGDu+Yj881Zxtwexio7oQVAQrt8oNThqqyzvqnxiQWj4V3UtEIBLyQe7RMepCcXXpYnsLACr9hirw9hyXbtZQLxxLElePG6O0tJdRXlMI+iMbwNRR3EWnQrnsbY/KFkR8fwnpCzXpZwvax0S77R01xc4cJUeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZcpUltdqQMD2KVGqqFZP4YfJ0TWafdjeMGx2aWX8s+U=;
 b=BgOhDflEX23mlTWoXb6eMPhsABy3LkBkKVlbAnWEwXyoAj5Vyxg6Fhr3o+G8tHk6RCU3LrNMbx6fqIH/xv88GztuQVQE2/S+0Msm1XzNbaQMPE9l7XEJuVD4mukMibaXCl+4KL+yTF1+o/6ee+WYuIzlZ7gCaRo9D1xGbtZu+5w=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DS7PR10MB5088.namprd10.prod.outlook.com (2603:10b6:5:3a2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29; Tue, 16 Jul
 2024 13:31:46 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.7762.027; Tue, 16 Jul 2024
 13:31:45 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Jeff Layton <jlayton@kernel.org>, Neil Brown <neilb@suse.de>
CC: Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Olga Kornievskaia
	<kolga@netapp.com>, Dai Ngo <dai.ngo@oracle.com>,
        Tom Talpey
	<tom@talpey.com>, Steve Dickson <steved@redhat.com>
Subject: Re: [PATCH 13/14] nfsd: introduce concept of a maximum number of
 threads.
Thread-Topic: [PATCH 13/14] nfsd: introduce concept of a maximum number of
 threads.
Thread-Index: AQHa1ouEOet5cO0e10aYjf9C+rrX/rH4BZ+AgACrtYCAAIBxgIAAKhcA
Date: Tue, 16 Jul 2024 13:31:45 +0000
Message-ID: <B8450A75-EB10-4FED-A0AF-7EA7EA370055@oracle.com>
References: <f12bdd8dde21de4473d38fada67b60ef5883e8dc.camel@kernel.org>
 <172110007383.15471.14744199179662433209@noble.neil.brown.name>
 <27b282045253419857b67f3240ab8ec5f585cf40.camel@kernel.org>
In-Reply-To: <27b282045253419857b67f3240ab8ec5f585cf40.camel@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.600.62)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|DS7PR10MB5088:EE_
x-ms-office365-filtering-correlation-id: ede8d948-4a40-41be-b147-08dca59ba323
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: 
 =?utf-8?B?VUMrTytLVGRYdG1rSHd6U3dPOEVtWERieXpZODYyRnN6RUpzU1RHVlEwYThu?=
 =?utf-8?B?RjMydHFvNmk2S2VFNjVXUDR2RlNUQkZXQmtnbVczN2ZQYVg0Z3JvczNTSVcr?=
 =?utf-8?B?ZHdIeTgzVlJwSEJnYW8rYnRLZEJpK1lCVXMyS1Q2dVJ3VHVnb3NwTWJtZG1V?=
 =?utf-8?B?cForekV5NXVQd0RUd2xrZ0NxUFp0aU5Yd1AvUUVpajAvU2hoWDFXSGhoMElp?=
 =?utf-8?B?K01JRWRDZCs0RzZydkVIVXZWRWNLUjhtK3ZBTHV1czBrdTJJaUxPQzRMWGdk?=
 =?utf-8?B?UzM2QlJ0cmtrbzVsK3lZbm9YNXRIamhXS25qcTJ1ZUlWT0p4cTRheDhjeURl?=
 =?utf-8?B?QW5yWVhhWHJ2TTc1NnJYT3lURW1qbHZ2UGt4Z05INWZiZEoxS1AwNCtJanRY?=
 =?utf-8?B?N0w3MzRvZzI2cGdOUTRleVNsbFBHYjVhRjFDYnc2QjR1UzQybkRQdkplMlg3?=
 =?utf-8?B?a1dmM01oLzdIa1RmeEhTZUZnUlJmcmxqa2hEWDE5akJSS09yOFZId0kzYlRI?=
 =?utf-8?B?NE5uVW44Vlk2U2FaUVFqK3VPNUpSRHJmV05SVkQ5UGVISzYvZjRmaFNJNE1L?=
 =?utf-8?B?SHFwQ05wLzFVL2ZqNFV1blcwakZpdHRQbzFvenE3SmJQT0tmQ3dVcWZkb0Ri?=
 =?utf-8?B?b1pkYVRqU0VabG5kbWdOMDVXYXFlRFEwOUhCNEdNOFBYRytURGFIK0hPYklB?=
 =?utf-8?B?Q2FhMnNWWkIzMzVVQkswaThISyszbWlMdEd4dkhjYXlJMHltN3pCeGp0TkZz?=
 =?utf-8?B?OVF2eTR6ZHUrUlNTTjB1WFhkTm5wekQ5Z2JLc05CZlc5SVl0WTRDZFlRM1Fi?=
 =?utf-8?B?K1Nya0o5ajZsbW9SRUd1dk40TFFJUGlUakQwVGNFUEs4TmNJTzNJcFNxcElI?=
 =?utf-8?B?ZWs3R0FkNGt5OUg1SU9GVGlXR3RGdkpJSUxKSGsvYzQ4dzVFT0szNWV3a2xy?=
 =?utf-8?B?TWZtbXVkVFFJenZ1N3FtaTZDL0tBd0RhNjFrS1pBSjVMZ2hDdzZ3ampxc0FG?=
 =?utf-8?B?L2FZRUpCSmMrcHVTM213b1RXbzBSTDg5UHQwSjVpemxaYkowblFNMEJ0ejUx?=
 =?utf-8?B?cmdxOVpPVXFHVFllYWhvZC9Ba3YvRWtqK0V0NWNwenRjeVFyTkNLQjljYWp1?=
 =?utf-8?B?Qk5ackVPdkVaQXNpSXdLUG9TYXlNQkZ4UlRLS1lQV0w1UlJ4dVRzU3IwQktS?=
 =?utf-8?B?OXdCb09MS3l1eCticlpUbWg4a2pqcjI5NmZ6a0M1Q2hiZUQra2U5QmZUUjRY?=
 =?utf-8?B?SlVCZ0ZhdGZ6YUhEMG8vVjdXU2E4UW9UR3N5T1hZUEVlb1RISGZ2RnpTdEJy?=
 =?utf-8?B?aUxWd2l4bnZ1bWI0YzRUR3VoMytHZjlySWFtWHZHNDdGTXFiRE12TGVmSlM1?=
 =?utf-8?B?ZUU5Mk4rdjB0OWhUYjdSSXNUVHZEVWkranVhNFhpZlJBUmRwK1JiZjFRZDk4?=
 =?utf-8?B?VVRSYWtJdURaelN4MjdZU0FBeWZZSEpDRmNoRW1uTW5lMVc0NmE1N3UvcWlh?=
 =?utf-8?B?ZjB1WUw2cG1rNW9tbGxZQ1Bwb1RnY1YzckQxL1NFQU4zcHBydTF6V1ladlV3?=
 =?utf-8?B?Ulc0ejl6QU9pWitLV2pTcjZqVDZtR0tLaDdyZWY4MlIvT2xWMlhZMXB0b3Ur?=
 =?utf-8?B?RmpwZnRpZXIxV05WcGxQTzR1MTA2SjhnN0thcUpqMmllN3AzREFYcDdUMU53?=
 =?utf-8?B?NnNtUmpISWNVcVF1ck5SbHpIVC9NSWZwV0x0MjkzVDlDNWFubjBQd2x3TEF3?=
 =?utf-8?B?RG13SHdKWTRsc0xFR2V1eWg5N3BhK3B3ZER0VDFzbUxqNjY5U1VKUmdXSWt1?=
 =?utf-8?B?ZkR5eHhKdUkyUXZIWHNVbVJBSnNpNzB3alNQNEUybmtPbWVoWnVXeWF2K3hC?=
 =?utf-8?B?U05HVFhmcklMalhSWTlrQTluUkhHckpiQWJtTWxqTmFHUGc9PQ==?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?N2dJVlgzclpMblREOU9UbmFKR0pnaUNHL2xsUlY0WWRkbUtwMDRvYWdFclBJ?=
 =?utf-8?B?RERJUkJ3aEEyTnFacFRCRG1TQlF1cWhsZnc0R0VEclZ5cStlaFNEb0svTEsy?=
 =?utf-8?B?ZExpVGRwc0orNy84SDY0dzhsR21YMy85UnlGTW5KNGxGYzFtNlBJR0hOcTBi?=
 =?utf-8?B?U0huQlpVNnloTW1aSjUwQU51VXBoQlA0KzBSb3VUSXNoeG05TjBxT3M1WkYy?=
 =?utf-8?B?RU5Hd0IyQnNjeGtUUXF6MHdoN1FxNmlNS0tUWkUvWDJ6TjEyc2RzUmV2RG93?=
 =?utf-8?B?TXVSMU1GK3dva1JwY2NGSENRM25WSXdSc01wZ3R2MjFOOUQyejFxWE01NnVI?=
 =?utf-8?B?cnUydEZ4V3UwY0lkR0xIdEFVVS95OWY5aG53OFU1SmJORUJjOVZMNnlxeTFE?=
 =?utf-8?B?cU9nZjBSeFlrclZIVnpTaGlPeEUxalpzeFMycXB3bzhJNUIxMFFkY2IvZ1RI?=
 =?utf-8?B?aTRiQUcwQzhRZjJWd1J5aFZHdnpiU082WWhscU9zeHp3WTZza2hvOFBmYWdR?=
 =?utf-8?B?QkZmZTZxclp0QUdaWHBtZWpHWnI5QzNqOTkvMitEL2N0Z0tWQkVkYTNxQkpk?=
 =?utf-8?B?cnJYNEFMNms0Qk02Yk0yT2VRRUVaeForOWU1YlloNU1CWmpndi9zclhJVjF0?=
 =?utf-8?B?VVNyVGtRY0JERkN5N2pBd3JBQ01XazFPdTZ2L0p4Yzg4b1dNZ0lNTGZ0eEFM?=
 =?utf-8?B?WGdUemJabnBBSmxROWtpanBQVlhUSFI2Z3VjeHA1WTJBVlcvM0lHVDEzT2xT?=
 =?utf-8?B?bDZvdEQvQVR2S3VESmxZTVBicEhLbm85VkNhS3l1dENiVDBjQ0VhendCakJD?=
 =?utf-8?B?Qmx0c0pMMGltUHZpbHZFYzloVjRIc2VHY0Zzb2Q5QUpaMldZMHJXT0hrckMv?=
 =?utf-8?B?QlRFZTBnMDBaYlZCUEFCTHhmNkZpbUNjVXIwQ0tOandOeUlUVUFGOFBMeU5t?=
 =?utf-8?B?TzVubXp5YkdUOHZrNkNIaWFLSmE4SWQ1WXBYZ2hNMkR3Um5CUDBOOStXTml4?=
 =?utf-8?B?azRSdnVGaDhUdkkrbHBmMnJhV2tIN2dKYVdyc0NlSHo5d3BOVmRYN3RNcm1t?=
 =?utf-8?B?ZmxwKzZmUk9xZkpqM2ZJOUFOS0syWE51NWRXOXhVd3lxNHFxNmdtS05DMnNo?=
 =?utf-8?B?dzhWM0pPVCtjL1RNa3VYN04vNWl1dExGRVpxaStQMi9hN2FRb1l5TmJXOUww?=
 =?utf-8?B?aC9tb3h3NTBPSmhLRHA2dVBpNFpiSXFTRHVUQWo0cjN4U1dqRzc4TEppT2N0?=
 =?utf-8?B?WVpBL0Z6YytxS1hudEp1TUVCcmhjczJuNEo4VitTR1k3TXlGaW0xaUVhbHdj?=
 =?utf-8?B?S1I5eFpFYXRUcHlSUE1NUWY5NzFIVzZnREdzK3J3T2M4dWZNMHpxQTArVTZL?=
 =?utf-8?B?QnZXLy8zTWxzeFcwS2x6bHNoRi9OWU1yeEpabUFibWNLNDdud3hnU09kdjZF?=
 =?utf-8?B?M3p4cjJZalBHMURaNGUxZ3NGaDQzUzRXNjJaTFEwNDVEM3o1c3owMFRiTjV3?=
 =?utf-8?B?QnRzTEVRMjNjY1RkNnJROVUxdmQyb1pxejlJRGY2QkwxT0xNYzZEVGxNR0c5?=
 =?utf-8?B?L0hEVFVJLzhKbTFKU2dMVnAzcTNEVGd4UldEeWdoVWtyQ3hPM1k2TVJ1d2g3?=
 =?utf-8?B?aEZpVnJKTTgrRE42bVhLd29YR1Y2UHJ0Tzc5UnB3YTVrUjRLWndkRUVMc0xT?=
 =?utf-8?B?UllNUERGUkZyUFFWOFpXWGhmZjZtY2s2Z055MHNPdTdpUzBqUGh0NU5DQjc5?=
 =?utf-8?B?YjRySmtCbVEyZDFNSThqd0h0L285UnNiK3Y0SEpsN1g5eVpTK2xyNUZpNmxW?=
 =?utf-8?B?RkcwdExReVlhdllHY1RTcGhHc0hRbEc5QkYwT09qTlFMTnJ3bmdZb2Rwbk1E?=
 =?utf-8?B?VmF6ckFNYU5SQ3diT3JPd2FsRnU5L0hJbGIxdDBUODlVeFoxLzJmb0U3QmtM?=
 =?utf-8?B?dGZJcDVrNDlmUWZ2ME9jVVpKM3VYdWtyY0FVN3lvVHZVMS9XaE1YZUwzeXdH?=
 =?utf-8?B?MWN1bmI2NUNtb2J4Y1V4QnF2Z1MxMzB1dERrMHF2L0tlRlpFR3dad1RlcDV1?=
 =?utf-8?B?SFIzemFMbDhidjNEN01Xd0hNVDd5a3lncjJscFJkQ1JCRXpqM2c5T2RLbCtL?=
 =?utf-8?B?bXdDMGtUTGdOV3BNT201MzM4VE9yaTBxLzZwNUZEMUkxVW5JMDRmVFRDUHFv?=
 =?utf-8?B?ZWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B49883AB5A1F364D865FD1A20CA81BBE@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	yEjm3CXOXkTnXbbdjkHjuhsPmMsigRHao8UC6t562BLfHPNlwDfroJgU9LASge6o+ddzJ05En6LIQhgB90koV9fQnxZRDaAKOC+EjXVpE7KOVsnXc63I9YJXYW3KKgKKK9jInaQm4hKdJ3dYHLlVyIzoJUv+HD6fOjgq/oVN5++2cEl5prnI3DnSt+h7HAmSYBGki/NAj/4o2H4wvsHCadp+kvmdZJ+gyd4TZ+b5u/BxlM2XnBod8wxrraqk/PxW0JS8bWXUX7aX0SYSBaOYWmgB4Gd2f1Jc6z5/CoTxK8BBal9VUfnJQ+2ru/kOOdN+Q+zOxnSUrQkzQWzgOmWjAKlni2GhHpXbaDgDVyKQQPgFpKzC36aZB2b4kKlXih7eXGhOZH/ZcNjypxiSpIaVuMLIvCVYUYZlv0f7sFtqQfRkIZPBtioNzonMhXDkZL1SIpJW35C77QXds7gRS2MYJCvzi74zHBrANyL0hHA8NAbg4o7ahmBe/5LqCRfnCZeiOKcECGx/loqSZnH9QfUep9ItETfIDVh1H/wcTVLhRSRk3C8ivRM48ncHzcmmfcH7yrLdtBtPllXUlivLnWotZOdfhLl/CFk6aIhF9qyvyms=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ede8d948-4a40-41be-b147-08dca59ba323
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jul 2024 13:31:45.4899
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: v2ZC5KoDuTR136tpURq0WSfSfDrdlXu3Wbzf+uifgbkOlc/TsokOJZw3xDMzZtl2q+QcxQHb1TN6JVCF7UEI7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5088
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-15_19,2024-07-16_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 malwarescore=0 bulkscore=0 mlxscore=0 phishscore=0 suspectscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2406180000 definitions=main-2407160100
X-Proofpoint-ORIG-GUID: cErOjuCZEu22J5jkM0UVkwOjUgv0oRk4
X-Proofpoint-GUID: cErOjuCZEu22J5jkM0UVkwOjUgv0oRk4

DQoNCj4gT24gSnVsIDE2LCAyMDI0LCBhdCA3OjAw4oCvQU0sIEplZmYgTGF5dG9uIDxqbGF5dG9u
QGtlcm5lbC5vcmc+IHdyb3RlOg0KPiANCj4gT24gVHVlLCAyMDI0LTA3LTE2IGF0IDEzOjIxICsx
MDAwLCBOZWlsQnJvd24gd3JvdGU6DQo+PiBPbiBUdWUsIDE2IEp1bCAyMDI0LCBKZWZmIExheXRv
biB3cm90ZToNCj4+PiBPbiBNb24sIDIwMjQtMDctMTUgYXQgMTc6MTQgKzEwMDAsIE5laWxCcm93
biB3cm90ZToNCj4+Pj4gQSBmdXR1cmUgcGF0Y2ggd2lsbCBhbGxvdyB0aGUgbnVtYmVyIG9mIHRo
cmVhZHMgaW4gZWFjaCBuZnNkIHBvb2wgdG8NCj4+Pj4gdmFyeSBkeW5hbWljYWxseS4NCj4+Pj4g
VGhlIGxvd2VyIGJvdW5kIHdpbGwgYmUgdGhlIG51bWJlciBleHBsaWNpdCByZXF1ZXN0ZWQgdmlh
DQo+Pj4+IC9wcm9jL2ZzL25mc2QvdGhyZWFkcyBvciAvcHJvYy9mcy9uZnNkL3Bvb2xfdGhyZWFk
cw0KPj4+PiANCj4+Pj4gVGhlIHVwcGVyIGJvdW5kIGNhbiBiZSBzZXQgaW4gZWFjaCBuZXQtbmFt
ZXNwYWNlIGJ5IHdyaXRpbmcNCj4+Pj4gL3Byb2MvZnMvbmZzZC9tYXhfdGhyZWFkcy4gIFRoaXMg
dXBwZXIgYm91bmQgYXBwbGllcyBhY3Jvc3MgYWxsIHBvb2xzLA0KPj4+PiB0aGVyZSBpcyBubyBw
ZXItcG9vbCB1cHBlciBsaW1pdC4NCj4+Pj4gDQo+Pj4+IElmIG5vIHVwcGVyIGJvdW5kIGlzIHNl
dCwgdGhlbiBvbmUgaXMgY2FsY3VsYXRlZC4gIEEgZ2xvYmFsIHVwcGVyIGxpbWl0DQo+Pj4+IGlz
IGNob3NlbiBiYXNlZCBvbiBhbW91bnQgb2YgbWVtb3J5LiAgVGhpcyBsaW1pdCBvbmx5IGFmZmVj
dHMgZHluYW1pYw0KPj4+PiBjaGFuZ2VzLiBTdGF0aWMgY29uZmlndXJhdGlvbiBjYW4gYWx3YXlz
IG92ZXItcmlkZSBpdC4NCj4+Pj4gDQo+Pj4+IFdlIHRyYWNrIGhvdyBtYW55IHRocmVhZHMgYXJl
IGNvbmZpZ3VyZWQgaW4gZWFjaCBuZXQgbmFtZXNwYWNlLCB3aXRoIHRoZQ0KPj4+PiBtYXggb3Ig
dGhlIG1pbi4gIFdlIGFsc28gdHJhY2sgaG93IG1hbnkgbmV0IG5hbWVzcGFjZXMgaGF2ZSBuZnNk
DQo+Pj4+IGNvbmZpZ3VyZWQgd2l0aCBvbmx5IGEgbWluLCBub3QgYSBtYXguDQo+Pj4+IA0KPj4+
PiBUaGUgZGlmZmVyZW5jZSBiZXR3ZWVuIHRoZSBjYWxjdWxhdGVkIG1heCBhbmQgdGhlIHRvdGFs
IGFsbG9jYXRpb24gaXMNCj4+Pj4gYXZhaWxhYmxlIHRvIGJlIHNoYXJlZCBhbW9uZyB0aG9zZSBu
YW1lc3BhY2VzIHdoaWNoIGRvbid0IGhhdmUgYSBtYXhpbXVtDQo+Pj4+IGNvbmZpZ3VyZWQuICBX
aXRoaW4gYSBuYW1lc3BhY2UsIHRoZSBhdmFpbGFibGUgc2hhcmUgaXMgZGlzdHJpYnV0ZWQNCj4+
Pj4gZXF1YWxseSBhY3Jvc3MgYWxsIHBvb2xzLg0KPj4+PiANCj4+Pj4gSW4gdGhlIGNvbW1vbiBj
YXNlIHRoZXJlIGlzIG9uZSBuYW1lc3BhY2UgYW5kIG9uZSBwb29sLiAgQSBzbWFsbCBudW1iZXIN
Cj4+Pj4gb2YgdGhyZWFkcyBhcmUgY29uZmlndXJlZCBhcyBhIG1pbmltdW0gYW5kIG5vIG1heGlt
dW0gaXMgc2V0LiAgSW4gdGhpcw0KPj4+PiBjYXNlIHRoZSBlZmZlY3RpdmUgbWF4aW11bSB3aWxs
IGJlIGRpcmVjdGx5IGJhc2VkIG9uIHRvdGFsIG1lbW9yeS4NCj4+Pj4gQXBwcm94aW1hdGVseSA4
IHBlciBnaWdhYnl0ZS4NCj4+Pj4gDQo+Pj4gDQo+Pj4gDQo+Pj4gU29tZSBvZiB0aGlzIG1heSBj
b21lIGFjcm9zcyBhcyBiaWtlc2hlZGRpbmcsIGJ1dCBJJ2QgcHJvYmFibHkgcHJlZmVyDQo+Pj4g
dGhhdCB0aGlzIHdvcmsgYSBiaXQgZGlmZmVyZW50bHk6DQo+Pj4gDQo+Pj4gMS8gSSBkb24ndCB0
aGluayB3ZSBzaG91bGQgZW5hYmxlIHRoaXMgdW5pdmVyc2FsbHkgLS0gYXQgbGVhc3Qgbm90DQo+
Pj4gaW5pdGlhbGx5LiBXaGF0IEknZCBwcmVmZXIgdG8gc2VlIGlzIGEgbmV3IHBvb2xfbW9kZSBm
b3IgdGhlIGR5bmFtaWMNCj4+PiB0aHJlYWRwb29scyAobWF5YmUgY2FsbCBpdCAiZHluYW1pYyIp
LiBUaGF0IGdpdmVzIHVzIGEgY2xlYXIgb3B0LWluDQo+Pj4gbWVjaGFuaXNtLiBMYXRlciBvbmNl
IHdlJ3JlIGNvbnZpbmNlZCBpdCdzIHNhZmUsIHdlIGNhbiBtYWtlICJkeW5hbWljIg0KPj4+IHRo
ZSBkZWZhdWx0IGluc3RlYWQgb2YgImdsb2JhbCIuDQo+Pj4gDQo+Pj4gMi8gUmF0aGVyIHRoYW4g
c3BlY2lmeWluZyBhIG1heF90aHJlYWRzIHZhbHVlIHNlcGFyYXRlbHksIHdoeSBub3QgYWxsb3cN
Cj4+PiB0aGUgb2xkIHRocmVhZHMvcG9vbF90aHJlYWRzIGludGVyZmFjZSB0byBzZXQgdGhlIG1h
eCBhbmQganVzdCBoYXZlIGENCj4+PiByZWFzb25hYmxlIG1pbmltdW0gc2V0dGluZyAobGlrZSB0
aGUgY3VycmVudCBkZWZhdWx0IG9mIDgpLiBTaW5jZSB3ZSdyZQ0KPj4+IGdyb3dpbmcgdGhlIHRo
cmVhZHBvb2wgZHluYW1pY2FsbHksIEkgZG9uJ3Qgc2VlIHdoeSB3ZSBuZWVkIHRvIGhhdmUgYQ0K
Pj4+IHJlYWwgY29uZmlndXJhYmxlIG1pbmltdW0uDQo+Pj4gDQo+Pj4gMy8gdGhlIGR5bmFtaWMg
cG9vbC1tb2RlIHNob3VsZCBwcm9iYWJseSBiZSBsYXllcmVkIG9uIHRvcCBvZiB0aGUNCj4+PiBw
ZXJub2RlIHBvb2wgbW9kZS4gSU9XLCBpbiBhIE5VTUEgY29uZmlndXJhdGlvbiwgd2Ugc2hvdWxk
IHNwbGl0IHRoZQ0KPj4+IHRocmVhZHMgYWNyb3NzIE5VTUEgbm9kZXMuDQo+PiANCj4+IE1heWJl
IHdlIHNob3VsZCBzdGFydCBieSBkaXNjdXNzaW5nIHRoZSBnb2FsLiAgV2hhdCBkbyB3ZSB3YW50
DQo+PiBjb25maWd1cmF0aW9uIHRvIGxvb2sgbGlrZSB3aGVuIHdlIGZpbmlzaD8NCj4+IA0KPj4g
SSB0aGluayB3ZSB3YW50IGl0IHRvIGJlIHRyYW5zcGFyZW50LiAgU3lzYWRtaW4gZG9lcyBub3Ro
aW5nLCBhbmQgaXQgYWxsDQo+PiB3b3JrcyBwZXJmZWN0bHkuICBPciBhcyBjbG9zZSB0byB0aGF0
IGFzIHdlIGNhbiBnZXQuDQo+PiANCj4gDQo+IFRoYXQncyBhIG5pY2UgZXZlbnR1YWwgZ29hbCwg
YnV0IHdoYXQgZG8gd2UgZG8gaWYgd2UgbWFrZSB0aGlzIGNoYW5nZQ0KPiBhbmQgaXQncyBub3Qg
YmVoYXZpbmcgZm9yIHRoZW0/IFdlIG5lZWQgc29tZSB3YXkgZm9yIHRoZW0gdG8gcmV2ZXJ0IHRv
DQo+IHRyYWRpdGlvbmFsIGJlaGF2aW9yIGlmIHRoZSBuZXcgbW9kZSBpc24ndCB3b3JraW5nIHdl
bGwuDQoNCkFzIFN0ZXZlIHBvaW50ZWQgb3V0IChwcml2YXRlbHkpIHRoZXJlIGFyZSBsaWtlbHkg
dG8gYmUgY2FzZXMNCndoZXJlIHRoZSBkeW5hbWljIHRocmVhZCBjb3VudCBhZGp1c3RtZW50IGNy
ZWF0ZXMgdG9vIG1hbnkNCnRocmVhZHMgb3Igc29tZWhvdyB0cmlnZ2VycyBhIERvUy4gQWRtaW5z
IHdhbnQgdGhlIGFiaWxpdHkgdG8NCmRpc2FibGUgbmV3IGZlYXR1cmVzIHRoYXQgY2F1c2UgdHJv
dWJsZSwgYW5kIGl0IGlzIGltcG9zc2libGUNCmZvciB1cyB0byB0byBzYXkgdHJ1dGhmdWxseSB0
aGF0IHdlIGhhdmUgcHJlZGljdGVkIGV2ZXJ5DQptaXNiZWhhdmlvci4NCg0KU28gKzEgZm9yIGhh
dmluZyBhIG1lY2hhbmlzbSBmb3IgZ2V0dGluZyBiYWNrIHRoZSB0cmFkaXRpb25hbA0KYmVoYXZp
b3IsIGF0IGxlYXN0IHVudGlsIHdlIGhhdmUgY29uZmlkZW5jZSBpdCBpcyBub3QgZ29pbmcNCnRv
IGhhdmUgdHJvdWJsaW5nIHNpZGUtZWZmZWN0cy4NCg0KWWVzLCBpbiBhIHBlcmZlY3Qgd29ybGQs
IGZ1bGx5IGF1dG9ub21vdXMgdGhyZWFkIGNvdW50DQphZGp1c3RtZW50IHdvdWxkIGJlIGFtYXpp
bmcuIExldCdzIGFpbSBmb3IgdGhhdCwgYnV0IHRha2UNCmJhYnkgc3RlcHMgdG8gZ2V0IHRoZXJl
Lg0KDQotLQ0KQ2h1Y2sgTGV2ZXINCg0KDQo=

