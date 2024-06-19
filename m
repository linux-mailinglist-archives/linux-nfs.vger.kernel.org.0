Return-Path: <linux-nfs+bounces-4069-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADC3990EF48
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Jun 2024 15:44:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D4B7282AB8
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Jun 2024 13:44:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07C4913DDC0;
	Wed, 19 Jun 2024 13:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WRSN4bvs";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="jknEQaZB"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED3101E492
	for <linux-nfs@vger.kernel.org>; Wed, 19 Jun 2024 13:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718804661; cv=fail; b=R/CwNYdeKc6E1ZrUZwJsCt+B3gkDvLxGFNWVjArJspdwv4yrtsgON0/T8AILkCK0EQvnreOX7KM2fFw9LE8CcYqUiKml+28X0JH0P9aT71jnce3r3wRl3lT4hSHz6NBaC9MuVDL5eMtqDDTEbI4gb0X8zv/DFpbjIMkal6HG1IM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718804661; c=relaxed/simple;
	bh=Xm4Pvb1amsoryN1tBbS1rCcz42/bILFsXH8Y4G7Yo6Q=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=G+1/hDLEmliNgKR+wIVdKwzkmHEf6p0QWZrFzqkFRpl1qjt6DgLYXq6kV92HY6kNSow9ruuGSz8BCZ98WuuiA3Sqhnxjm4g6dfjcXQ+C27Q0QqRjOAggubNVjkgAYPO8VI+B51sy577RO6ajA+49Gb5KBx26/eqdBpKtMSLCYzo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=WRSN4bvs; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=jknEQaZB; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45JDFlt2028366;
	Wed, 19 Jun 2024 13:44:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-id:content-transfer-encoding:mime-version;
	 s=corp-2023-11-20; bh=Xm4Pvb1amsoryN1tBbS1rCcz42/bILFsXH8Y4G7Yo
	6Q=; b=WRSN4bvsiRoVGkqKfQQjHVrZ7XeSwsirm1nDG35Mb+1cLYpjSwfQqyE9B
	H/d5rl2XBZn792jrBsWcLavDY4T/Xonp2jjg19ZPPSfpA+S0JO2opV4GhQKEm27k
	DTsY6DnQh4pihKpDpOiDBgOZz1I+M8o4bdYY8ucHLAKKxKTQus1HEjhTNF33yytn
	RxY9k9D5sVO6slimbeMSyECXVI5EycH6TBFo4voVjuTLVxzT2rnueUVpgIKMQX3v
	vknaDyFr/7s+VE2KHux4V3pRbWJ2thL47ljigJkB8zkGUxDPVxGLWJHDwwQytHik
	LPIRDUJaHaujhXQI4VqlQ/2kjEgHg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yujc099mr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Jun 2024 13:44:10 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45JC5LXA029098;
	Wed, 19 Jun 2024 13:44:09 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ys1d9mbnu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Jun 2024 13:44:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dmrvKmWKiAyPstYf81YFeK4GAxZLPAPxFmXCX1U2yHoRrN24B2QOkCCzUXMyLTmHylWVeN22Qk/JqUCdAXa09gwNQPmz0Mk9Kw1ZWwETRwpQu3/RS8YhAokt2TqgygmOUNEdmS4zPvG3G0hsbhT3DEgjIYY43V11tvx/IE0CNORWSWIfJvwyxtToAg060OLvflHtFl/HJ2ututpr7Fd8/mJCL3uOuAapDNXxu/XNDrzjHwIkB5kT8TfRC8WwLscR8r9eFe0/gAqofnjsiYGOdqZxozb4cZfd9bu5cyRzVxn4zV7R+Sac3U0kdUDAJjQBJ0uTaLbbYbsrSHKurp4HRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xm4Pvb1amsoryN1tBbS1rCcz42/bILFsXH8Y4G7Yo6Q=;
 b=jQPEDN6XeKMfvXWjGz5Y8pR80r6gsg/yRKhiOGKQx0M/3kwblkcLM0q06yodlvlpVJU6FW46Sc2pn688GV65pLekaWeswWc4lCTZdAEBIm5JPnOII1cAL9p9AwFlg1Ehl5so87F3Sj7kEiKIbugpY9GL7UOOThjUzjkj+kpIbgTNLa9K0t+KBniXXi2d1XH2j5wIur/KmBwmTTbIz5QhPxCkBl8hve3Yxgp7kAQhur3EDSL5uUYu4E/3twUhcuQbYRUMgMC+nflhbJx8uG4QIky8kWrAQWrkfekoACjCcqGrHiqYFTLF9iEBacxljMJg3Ygt2vwcTZhRiIUfF/ycYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xm4Pvb1amsoryN1tBbS1rCcz42/bILFsXH8Y4G7Yo6Q=;
 b=jknEQaZBsrTN+1v3eyuIUuSgcl197Qia0N2U6uB4St+Tewk5etgj6ZirvNslKbYzrmZM8woQMFI3rv0ljdaA5KIFxH3tKVPi1ckatrguZxqQT05ijKZY/Z/DObKYntpLV2v+BrUwksEnDOAAZ2XXTTJ0YdSOxcDPGaZPOkBWz40=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH0PR10MB4614.namprd10.prod.outlook.com (2603:10b6:510:42::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.18; Wed, 19 Jun
 2024 13:44:07 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%5]) with mapi id 15.20.7698.017; Wed, 19 Jun 2024
 13:44:07 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Dave Chinner <david@fromorbit.com>
CC: Neil Brown <neilb@suse.de>, Jeff Layton <jlayton@kernel.org>,
        Trond
 Myklebust <trondmy@hammerspace.com>,
        Linux NFS Mailing List
	<linux-nfs@vger.kernel.org>
Subject: Re: knfsd performance
Thread-Topic: knfsd performance
Thread-Index: 
 AQHawa3dybcUo3ed40e1woBUDQls6LHN2rIAgAANu4CAAAKdAIAAAygAgAABH4CAAAY3gIAAMnyAgAACcACAADrSAIAAtNQA
Date: Wed, 19 Jun 2024 13:44:07 +0000
Message-ID: <6A2B69CF-B0C8-4638-984F-F0B227200B75@oracle.com>
References: <87354accc0d1166eb60827c0f8da545e0669915b.camel@kernel.org>
 <171875264902.14261.9558408320953444532@noble.neil.brown.name>
 <E14A0A67-71C7-4ED7-BE4E-525A186B876A@oracle.com>
 <ZnJI7Em5clnyWDU6@dread.disaster.area>
In-Reply-To: <ZnJI7Em5clnyWDU6@dread.disaster.area>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.600.62)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|PH0PR10MB4614:EE_
x-ms-office365-filtering-correlation-id: 55fa371a-a7b3-4df8-f30f-08dc9065e428
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230037|366013|376011|1800799021|38070700015;
x-microsoft-antispam-message-info: 
 =?utf-8?B?Qk1FVVhiRUxjU08wb3QyYnl0VHl4WkpDaUF0RmxoTS9aenlFS0hqNUYrUW0y?=
 =?utf-8?B?My83TkxCV3QwbmFFQ2ROMG5YS2R2MDQ2NTlqMjF0NlJuV1BBcUJHWnFhNU5W?=
 =?utf-8?B?K01wdGJGSExzNzMvV2wxMTFYdGJmQ3U2RG92Rzh1TVRxYW8ydWkzRk9PVXFL?=
 =?utf-8?B?K1VrYVl6eGpKN3pQVzdlNml2THZ6VzVGR1BFd09wZ3VVS215aGR0MXUvdGtn?=
 =?utf-8?B?N05rRXhyQ29CSXVqNzVNM3M5MXhmT2tDOExsUDdxaCtoOGpCc29idjVGL3U1?=
 =?utf-8?B?emExTktjbHh0cTMrRkZRVk1MZXU2ZU5hNEpoVkRnYnBIZ3BxMGN3b01uVzJC?=
 =?utf-8?B?SE9YT0o4QTlPL2tOaGZxQVN5RjB0OTZvRmF6Z0p6L2NoaHlKOXk3NWpWaC9C?=
 =?utf-8?B?clRvTTlkUGxzVUlFaWNIeUtzL1NDdmZEcDArZERtZmFKeFE0RjdoMXovd212?=
 =?utf-8?B?MFUrRkxvWm1OQXk2OW9WRWpUNldyYWJwbytYZUJ2eTFNYjR2cUcyWmhMRmpL?=
 =?utf-8?B?M1g5Y2dpYVhIM0IwVmtMc2NvVURIZnFjZFFaRHNZU2ZkbUhyNHhMaXRZR1Vu?=
 =?utf-8?B?a3V2bGlqaUVxeUVpdm9FTXZCY2ZKUUtzbzJLeDBzazZ4ZkRDM1Z3d085czVM?=
 =?utf-8?B?eGJpUG92bmhteUpWaTNyeGx6Rm51aGh0NkZpZE81RUpCSXVJQ3M5bVE5TnN5?=
 =?utf-8?B?OXAzL1kxM05zMXByQ1BzbTZGdHYwWVVuOUR5TTkwY1FpL241RWE2VzRHQjZu?=
 =?utf-8?B?RFdOdXpiR1IwbkUwSlFjWXVmOWxQT25PRU9PR2VpWlU2SVJzWThNZFAycTkv?=
 =?utf-8?B?czJjTEtUWmlaMllMR0VyVW9uQ2NndkhuK0ptUGo3eEVnUno1ZnMwdmxsZ0ly?=
 =?utf-8?B?VkptRzk0YmFWaGYzYnR6c1pCTTVWbjRtQXdLeFVGeUJheVdkbWZGM25hZS9Z?=
 =?utf-8?B?NDlwNXJ3clYvK1hDM2l5bFEzdUpnbHZXd3dNd0hOU2c3L2w3RnVQM0Y3VEw2?=
 =?utf-8?B?MHgxMUVtN1hoREFmQzgvNFZhN0NpMHl6QzdzeXFhWlRlMUowV05pRFVIVXVt?=
 =?utf-8?B?b0JRTHo2SDI2cU9DOGRhelJ2azdhcVMwQzdpdFZvQlRKUW1MZmx4dnZ1QzRv?=
 =?utf-8?B?RGZaL0dNay80QU5RUkxLblZUVlFvNUZCeGU2YVMyWWdLZkFBcDFoODhXVFlF?=
 =?utf-8?B?R3IyOFZvSmlqNitXcTZBVk1GS05zSjZVQ09qTWRxdlhTV254NXNzaEt1RkE4?=
 =?utf-8?B?RFpIUzJrd1lxcXo5Wi8vSnlqV2dQMjl6N1dZdHlVSHBTaExBQ1kzRm1KNHlp?=
 =?utf-8?B?eGNTUWVGdVNlZ2twOWhCUThWc1NTRDVLa0FHbEFLTUI1Lyt2V0Jnam1VbEdu?=
 =?utf-8?B?K0FaZi8xU29maXRSMndZeHpMdGdWdy9vemErOGd1M2F5S1BmVDhEU21KQzJD?=
 =?utf-8?B?dUpwcy9nUjB2RGU4WGIxRmxuRi91OFJxazlnMVJHVEFUbTV5TzB3NWdsS0Zz?=
 =?utf-8?B?UlVpYUs3anhEeEsrVnBVNmFqV2tmNGlNTHlLK0JjYkR3bFZvc1kySDdOcjlt?=
 =?utf-8?B?SWJtM3I3NnFqUzNTQ2gwdmQwUjMyVlhCL0dkN2cwTmxwb0pZdXFUeXZOUUUz?=
 =?utf-8?B?M0xLMzhuSTR5Z0E1ck9TWXhMblFUelpGNmFaUjkrVGFtV21ZSm1TRFJjamkx?=
 =?utf-8?B?dXU4K3Y4bVZiTGNzaU16TVFyKzhRSmJIOVZtdW9TQnhkcjY0TURycDlrZXY0?=
 =?utf-8?B?eFpQUHQ3b1Q5dmVHSmY3a2lCZjJvSXVGS3p3cHZLZy8wZ1NEY1lJRFFtclFN?=
 =?utf-8?Q?CgQHc6gmsPJCuE2inKAKkTDXFdW/+zfzDrhb4=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(376011)(1800799021)(38070700015);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?NmNQSHJRalBFdzlvNjBicUFPUXZVNFdPWnlVZ0RZVDNnUTByR202V2Yvb3oz?=
 =?utf-8?B?TFlQN3ZlTUViTWJ3NHJ3SnZGbTQvczg5TWd0emYwM1p2Ni9tVFh5cE11WTJq?=
 =?utf-8?B?MENTVWtiblVBZDluSERpUGpCN0dUbW1nQ1hCQmRsY3JwcHZVZVprSkJuSjFn?=
 =?utf-8?B?REwrenN1WHdYY1VWdXBDQU1lWW9yVHZNbFJUNWRDdjVyazVwODdSTEVhM1Uv?=
 =?utf-8?B?S2xIUXZyejhmQmhkZ3VwekpENk1sSm05emtIaEVPK3pkM1hiWW1FckFVcDZW?=
 =?utf-8?B?S3VXSHUyYmwvaSt3Qk5CUHhiRmZwUmE0eXozZHJBem9OZy9ZMmUwaHFiaG9z?=
 =?utf-8?B?Yno0cHNPTkg3Q1FLSXgvSUFxakJVMmd6UWRrZFZRc1Y1UnhnT2RVWlh2VHVS?=
 =?utf-8?B?ZlFhNnFRanlDc0ZJdzROZ3djOTV0ZDIrSmo1Z1laTXhvTnUwY1lrTUVDUzhC?=
 =?utf-8?B?SmdhQXJXRUY4Z2VaaDE1U1dvSWVsZEliK1ppbytmYTBTNG1nS1VNVjJXZlNX?=
 =?utf-8?B?bDZyUHp0T0F0UWRlS0p1bDlwY0hRSWJSMCsvOWFNU2R0MVEySDQ4WVJUKzdj?=
 =?utf-8?B?MEtVRHdiZ3NZYXJ2Sy9GY2kwY1ZkeC9aQUFYQWFVR0tkdE1NM0J4d0NXak53?=
 =?utf-8?B?WkJjQjRXR204UEk2RGE3UUppTEk4Q25oZEo3T2pqZEgzY0l1V1VmYU94R0tL?=
 =?utf-8?B?RVhkUml1by90MEQ2Y1puS0x6OEMyRHFPcVhoV0o2R1ltOGNJWUo4V1dYcGFM?=
 =?utf-8?B?OHNwM0FzblhjWmYwSVRNeFRJajFTa25rYzI4ZFpSMGNpOEdKcmpCdjlIZEVI?=
 =?utf-8?B?TUlDQ21ZNXZ4azAxWEJGVTQ1OFNLUjBiNUpGUklPaUxscXloUjczd01QU1hV?=
 =?utf-8?B?OStvdlFrTkgwY2NYdm0xbVZXOUtwSWVpdE1XK3V6eTh3S1l5OGMxODcvR292?=
 =?utf-8?B?K0RnMENId2tZcVp5STZoMTFjRGRvVXhtNlBCZis3SG9FWlV0N1hqNjZFOGhZ?=
 =?utf-8?B?clJ2WWlZQkdTVVZIaCtZUThiU2NCQnZBZSs0eWNIUjVxUjV6WmNsSTFaUlZT?=
 =?utf-8?B?K2NwMVdrZVZGWGdhZzlCMVdCdzZ5MlNJcElLREcrK2Zib2FnYm96QVFaWWx6?=
 =?utf-8?B?b2NOTjZGRmRTN09PUTc2WnNIeUwyUmhaMVh5aStRT2MvV0VTbDhnNmh3WUpD?=
 =?utf-8?B?WWxiR2tjUk93d1FJWDUxZU96M29FWFlKcnlxOC9ZSmFESktwK0lRbDl2citG?=
 =?utf-8?B?U3o0RExYOEIzWDVXMm9DM3Y1QXIwZFhpOHdkdHN3NWk1TmliYnJkK2Qxalc0?=
 =?utf-8?B?VUdOSDhscXNBeTNwam1EdmVwak1KNzNiQ2RDL1VRSnVXSW0wbUsxd1V5OHBJ?=
 =?utf-8?B?bWNjNUhKUEdGVXlUOU4vUTI2QkU3VHFhTWQ2bjVwVjBaQnRDTmNzeWorc3M2?=
 =?utf-8?B?VVF5K0NOdkpNNGpoY0xoYkFDUXRPeTh4WkRIamJXeFJzcXJ4RGhaVFROV29w?=
 =?utf-8?B?RWdtRnhINHY5YzNNVm0yQjlNck9nd0x1UjV1ejg4dXMxTHpuSk9kaHdZTm1x?=
 =?utf-8?B?ZEdiZ2plRWtHaTlOb0s3TzFHMXI0TDF4Vi9BeWJLa0I0TEJFUDZHdnhuOFBt?=
 =?utf-8?B?Zlc4dWVpT3J0bkY4UHhubk1sb21OMXFPcjdPbXlUbUs0UWQralVVS1JCOEpY?=
 =?utf-8?B?M295MEZacUJiU0RjbXJ4enhwWGx5Wk95N2lJbkEzeTUwTjRXYUdzY1Y4VDFk?=
 =?utf-8?B?VWFQOVpsZEtvWVZKOU1wVm9Ha280NDh0cVJzOFI1M2R4WTU5ZlRZb21RM0tF?=
 =?utf-8?B?d3NUZDA0T1hYd1p6NmJRbXNJa1QzQlJtcFRZdFZiRlRoRGM0Z2lTT0NLeVNj?=
 =?utf-8?B?aU5RSWFlNTVFME91RFJ4WVZSK0RVczhaMWlRQlVVU0wrNWlxVWtsWUNyc3g3?=
 =?utf-8?B?eXEzMFk4TDYzZXBWZy8xSjdQc2M1ZjIxMk5PMXhxS1l4R1Y3TG1VYWVMM2ti?=
 =?utf-8?B?UFk1M3pjdExpVkIxUTZSRnZKNTN2VmpOSXNZdzEyaG44OENYZlRGamR0bVFM?=
 =?utf-8?B?bE5CL3dQaEw1REd1VzdKSHNhUE1RRzIvL3BMTmNuUFJhTXlUV1F2aWFiaDRJ?=
 =?utf-8?B?bVpQTkUvcHhpSXNQVG1jY2JpWnRmbnNqdGZRVWhHcmE3ZmF6dmpTMTZzN096?=
 =?utf-8?B?Wnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8C704979D29F08499493146055312518@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	J8xHJdToQCnVEfn6wYdzhtzkETazRcC9Y5nDtxNsesbzT7pzN+8HSyHMrryHHsc+nWx90jFn3GYoBt4J7fNTWh4d5DAn1+k+DyGZdjyf8gPfIhxRRWi68jEpRM8CpR2ffASOrDewhyfEZXMsv0Mf1AgSjjw10i2cayj8ZVknA1Xq6DDJ4pWeWo4KUSwA7qrMu9ScAiZFtWRXcF1nNet6OhwY4j6/H3lrYlFLFNYuvSvZS5w8gXYdUNDUE0nSs4wFKoQZCecHFyPTKLncZjwHU4gOoROb0q8vTPUTCNx5Qqy3jwmmkXxwh0e/WjgXsM4KdWSEOWwnvGcV1D7FGObnB1TJJV8dZu2rsGx2LeKFPL/egX+s/q+5Vk5DPvQRjeYs6a8WYYVOdlBjxwNOKETInyZfUzTKZmUxlI8HqTMQ63fwvsqAcpVg+NcuFqqN6eWo2L6DDtBdZT05WGuZBqQLlCIVJDPyJTMhUdaloI7YszPBsCRirvtBMx3zMxyWRbef66ghLA+Uz36xP2wQygxtyeRwU3Vp48bExQ1vbVOk7yx6JlMNtjnvtyrATjLO2i9sznwIG632ZkdA7H5d7TNGYOP8UbKfQiTPiPLUrkD8fLI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55fa371a-a7b3-4df8-f30f-08dc9065e428
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jun 2024 13:44:07.2515
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JlY7XusDAyEXNj2zPsRdslc2Cecr0xYBk+jfxmQT9wKMsr6FRHoOEHi8TsvEus7VDFJAcePB7WSNPy1beWfAwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4614
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-19_02,2024-06-19_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 malwarescore=0
 mlxlogscore=999 phishscore=0 spamscore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2406190103
X-Proofpoint-ORIG-GUID: ob6oNFak4Mup3ZvVmJmLbp9e4fBT-1dd
X-Proofpoint-GUID: ob6oNFak4Mup3ZvVmJmLbp9e4fBT-1dd

DQoNCj4gT24gSnVuIDE4LCAyMDI0LCBhdCAxMDo1NuKAr1BNLCBEYXZlIENoaW5uZXIgPGRhdmlk
QGZyb21vcmJpdC5jb20+IHdyb3RlOg0KPiANCj4gT24gVHVlLCBKdW4gMTgsIDIwMjQgYXQgMTE6
MjY6MjJQTSArMDAwMCwgQ2h1Y2sgTGV2ZXIgSUlJIHdyb3RlOg0KPj4+IE9uIEp1biAxOCwgMjAy
NCwgYXQgNzoxN+KAr1BNLCBOZWlsQnJvd24gPG5laWxiQHN1c2UuZGU+IHdyb3RlOg0KPj4+PiBF
dmVudHVhbGx5IHdlJ2QgbGlrZSB0byBtYWtlIHRoZSB0aHJlYWQgcG9vcyBkeW5hbWljLCBhdCB3
aGljaCBwb2ludA0KPj4+PiBtYWtpbmcgdGhhdCB0aGUgZGVmYXVsdCBiZWNvbWVzIG11Y2ggc2lt
cGxlciBmcm9tIGFuIGFkbWluaXN0cmF0aXZlDQo+Pj4+IHN0YW5kcG9pbnQuDQo+Pj4gDQo+Pj4g
SSBhZ3JlZSB0aGF0IGR5bmFtaWMgdGhyZWFkIHBvb2xzIHdpbGwgbWFrZSBudW1hIG1hbmFnZW1l
bnQgc2ltcGxlci4NCj4+PiBHcmVnIEJhbmtzIGRpZCB0aGUgbnVtYSB3b3JrIGZvciBTR0kgLSBJ
IHdvbmRlciB3aGVyZSBoZSBpcyBub3cuICBIZSB3YXMNCj4+PiBhdCBmYXN0bWFpbCAxMCB5ZWFy
cyBhZ28uLg0KPj4gDQo+PiBEYXZlIChjYydkKSBkZXNpZ25lZCBpdCB3aXRoIEdyZWcsIEdyZWcg
aW1wbGVtZW50ZWQgaXQuDQo+IA0KPiBbIEknbGwgZHVtcCBhIGJpdCBvZiBoaXN0b3J5IGFib3V0
IHRoZSBOVU1BIG5mc2QgYXJjaGl0ZWN0dXJlIGF0IHRoZQ0KPiBlbmQuIF0NCj4gDQo+Pj4gVGhl
IGlkZWEgd2FzIHRvIGJpbmQgbmV0d29yayBpbnRlcmZhY2VzIHRvIG51bWEgbm9kZXMgd2l0aCBp
bnRlcnJ1cHQNCj4+PiByb3V0aW5nLiAgVGhlcmUgd2FzIG5vIGV4cGVjdGF0aW9uIHRoYXQgd29y
ayB3b3VsZCBiZSBkaXN0cmlidXRlZCBldmVubHkNCj4+PiBhY3Jvc3MgYWxsIG5vZGVzLiBTb21l
IG1pZ2h0IGJlIGRlZGljYXRlZCB0byBub24tbmZzIHdvcmsuICBTbyB0aGVyZSB3YXMNCj4+PiBl
eHBlY3RlZCB0byBiZSBub24tdHJpdmlhbCBjb25maWd1cmF0aW9uIGZvciBib3RoIElSUSByb3V0
aW5nIGFuZA0KPj4+IHRocmVhZHMtcGVyLW5vZGUuICBJZiB3ZSBjYW4gbWFrZSB0aHJlYWRzLXBl
ci1ub2RlIGRlbWFuZC1iYXNlZCwgdGhlbg0KPj4+IGhhbGYgdGhlIHByb2JsZW0gZ29lcyBhd2F5
Lg0KPiANCj4gUmlnaHQuDQo+IA0KPiBGb3IgdGhlIGR5bmFtaWMgdGhyZWFkIHBvb2wgc3R1ZmYs
IHRoZSBncm93IHNpZGUgd2FzIGEgc2ltcGxlDQo+IGhldXJpc3RpYzogd2hlbiB3ZSBkZXF1ZXVl
ZCBhIHJlcXVlc3QsIHdlIGNoZWNrZWQgaWYgdGhlIHJlcXVlc3QNCj4gcXVldWUgd2FzIGVtcHR5
LCBpZiB0aGVyZSB3ZXJlIGlkbGUgbmZzZCB0aHJlYWRzIGFuZCB3aGV0aGVyIHdlIHdlcmUNCj4g
dW5kZXIgdGhlIG1heCB0aHJlYWQgY291bnQuICBpLmUuIElmIHdlIGhhZCBtb3JlIHdvcmsgdG8g
ZG8gYW5kIG5vDQo+IGlkbGUgd29ya2VycyB0byBkbyBpdCwgd2UgZm9ya2VkIGFub3RoZXIgbmZz
ZCB0aHJlYWQgdG8gZG8gdGhlIHdvcmsuDQo+IA0KPiBJIGRvbid0IHJlY2FsbCBleGFjdGx5IHdo
YXQgR3JlZyBpbXBsZW1lbnRlZCBvbiBMaW51eCBmb3IgdGhlIHNocmluaw0KPiBzaWRlLiBPbiBJ
cml4LCB0aGUgbmZzZCB3b3VsZCByZWNvcmQgdGhlIHRpbWUgYXQgd2hpY2ggaXQgY29tcGxldGVk
DQo+IGl0J3MgbGFzdCByZXF1ZXN0IHByb2Nlc3NpbmcsIHdlIGZpcmVkIGEgdGltZXIgZXZlcnkg
MzBzIG9yDQo+IHNvIHRvIHdhbGsgdGhlIG5mc2Qgc3RhdHVzIGFycmF5LiBJZiB3ZSBmb3VuZCBh
biBuZnNkIHdpdGggYQ0KPiBjb21wbGV0aW9uIHRpbWUgb2xkZXIgdGhhbiAzMHMsIHRoZSBuZnNk
IGdvdCByZWFwZWQuIDMwcyB3YXMgbG9uZw0KPiBlbm91Z2ggdG8gaGFuZGxlIGJ1cnN0eSBsb2Fk
cywgYnV0IHNob3J0IGVub3VnaCB0aGF0IHBlb3BsZSBkaWRuJ3QNCj4gY29tcGxhaW4gYWJvdXQg
aGF2aW5nIGh1bmRyZWRzIG9mIG5mc2RzIHNpdHRpbmcgYXJvdW5kLi4uLg0KPiANCj4gVGhpcyBp
cyBiYXNpY2FsbHkgYSB2ZXJ5IHNpbXBsZSB2ZXJzaW9uIG9mIHdoYXQgd29ya3F1ZXVlcyBkbyBm
b3IgdXMNCj4gbm93Lg0KPiANCj4gVGhhdCBpcywgaWYgd2UganVzdCBtYWtlIHRoZSBuZnNkIHJl
cXVlc3Qgd29yayBiZSBiYXNlZCBvbiBwZXItbm9kZSwgbm9kZQ0KPiBhZmZpbmUsIHVuYm91bmQg
d29yayBxdWV1ZXMsIHRoZW4gdGhyZWFkIHNjYWxpbmcgY29tZXMgYWxvbmcgZm9yDQo+IGZyZWUu
IEkgdGhpbmsgdGhhdCB3b3JrcXVldWVzIHN1cHBvcnQgdGhpcyBwZXItbm9kZSB0aHJlYWQgcG9v
bA0KPiBhZmZpbml0eSBuYXRpdmVseSBub3c6DQo+IA0KPiBlbnVtIHdxX2FmZm5fc2NvcGUgew0K
PiAgICAgICAgV1FfQUZGTl9ERkwsICAgICAgICAgICAgICAgICAgICAvKiB1c2Ugc3lzdGVtIGRl
ZmF1bHQgKi8NCj4gICAgICAgIFdRX0FGRk5fQ1BVLCAgICAgICAgICAgICAgICAgICAgLyogb25l
IHBvZCBwZXIgQ1BVICovDQo+ICAgICAgICBXUV9BRkZOX1NNVCwgICAgICAgICAgICAgICAgICAg
IC8qIG9uZSBwb2QgcG9lciBTTVQgKi8NCj4gICAgICAgIFdRX0FGRk5fQ0FDSEUsICAgICAgICAg
ICAgICAgICAgLyogb25lIHBvZCBwZXIgTExDICovDQo+Pj4+Pj4gIFdRX0FGRk5fTlVNQSwgICAg
ICAgICAgICAgICAgICAgLyogb25lIHBvZCBwZXIgTlVNQSBub2RlICovDQo+ICAgICAgICBXUV9B
RkZOX1NZU1RFTSwgICAgICAgICAgICAgICAgIC8qIG9uZSBwb2QgYWNyb3NzIHRoZSB3aG9sZSBz
eXN0ZW0gKi8NCj4gDQo+ICAgICAgICBXUV9BRkZOX05SX1RZUEVTLA0KPiB9Ow0KDQpOb3RlIHRo
YXQgd3FfYWZmbl9zY29wZSBhcHBlYXJlZCBvbmx5IGluIHRoZSBsYXN0IG9uZQ0Kb3IgdHdvIGtl
cm5lbCByZWxlYXNlcy4gUHJldmlvdXNseSB0aGVyZSB3YXMgbm8gd2F5IHRvDQpjb250cm9sIHdv
cmtxdWV1ZSBjYWNoZSBhZmZpbml0eS4NCg0KSSBoYXZlIG9ic2VydmVkIHNpZ25pZmljYW50IGlt
cHJvdmVtZW50IGluIHRocm91Z2hwdXQNCnNjYWxhYmlsaXR5IG9uIHRoZSBMaW51eCBORlMgY2xp
ZW50IHdpdGggdGhlIG5ldyBkZWZhdWx0DQp3b3JrcXVldWUgY2FjaGUgYWZmaW5pdHkgYmVoYXZp
b3IgKHdpdGggTkZTL1JETUEsIG9mDQpjb3Vyc2UpLiBUaGUgaXNzdWUgaXMsIGludGVyZXN0aW5n
bHkgZW5vdWdoLCB0aGUgc2FtZQ0KYXMgaXQgd2FzIGZvciBsd3E6IHNwaW5sb2NrIGNvbnRlbnRp
b24gaXMgcmVkdWNlZCBvbmNlDQp0aGUgc2V0IG9mIHRocmVhZHMgYmVpbmcgc2NoZWR1bGVkIGFs
bCBiZWxvbmcgdG8gdGhlDQpzYW1lIGhhcmR3YXJlIGNhY2hlLg0KDQoNCj4gSSdtIG5vdCBzdXJl
IHRoYXQgdGhlIE5GUyBzZXJ2ZXIgbmVlZHMgdG8gcmVpbnZlbnQgdGhlIHdoZWVsIGhlcmUuLi4N
Cg0KSmVmZiBpbXBsZW1lbnRlZCBhIHdvcmtxdWV1ZS1iYXNlZCBzdmMgdGhyZWFkIHNjaGVkdWxl
cg0KYWJvdXQgMTAgeWVhcnMgYWdvLiBXZSBjb3VsZCBuZXZlciBtYWtlIGl0IHBlcmZvcm0gYXMN
CndlbGwgYXMgdGhlIGV4aXN0aW5nIGt0aHJlYWRzLWJhc2VkIHNjaGVkdWxlci4gSSdtIG5vdA0K
c3VyZSB3ZSBuZWVkIGEgd29yay1jb25zZXJ2aW5nIHRocmVhZCBzY2hlZHVsZXIgZm9yDQpORlNE
L1N1blJQQy4NCg0KVGhhdCdzIHdoeSB3ZSB0b29rIHRoZSByb3V0ZSBvZiBrZWVwaW5nIHRoZSBi
ZXNwb2tlDQp0aHJlYWQgc2NoZWR1bGVyIGluIFN1blJQQyB0aGlzIHRpbWUuDQoNCg0KPj4gTmV0
d29yayBkZXZpY2VzIChhbmQgc3RvcmFnZSBkZXZpY2VzKSBhcmUgYWZmaW5lZCB0byBvbmUNCj4+
IE5VTUEgbm9kZS4NCj4gDQo+IE5WTWUgc3RvcmFnZSBkZXZpY2VzIGRvbid0IG5lZWQgdG8gYmUg
YWZmaW5lIHRvIHRoZSBub2RlLiBUaGV5IGp1c3QNCj4gbmVlZCB0byBoYXZlIGEgaGFyZHdhcmUg
cXVldWUgYXNzaWduZWQgdG8gZWFjaCBub2RlIHNvIHRoYXQNCj4gbm9kZS1sb2NhbCBJTyBhbHdh
eXMgaGl0cyB0aGUgc2FtZSBoYXJkd2FyZSBxdWV1ZSBhbmQgZ2V0cw0KPiBjb21wbGV0aW9uIGlu
dGVycnVwdHMgcmV0dXJuZWQgdG8gdGhhdCBzYW1lIG5vZGUuDQo+IA0KPiBBbmQsIHllcywgdGhp
cyBpcyBzb21ldGhpbmcgdGhhdCBzdGlsbCBoYXMgdG8gYmUgY29uZmlndXJlZA0KPiBtYW51YWxs
eSwgdG9vLg0KPiANCj4+IElmIHRoZSBuZnNkIHRocmVhZHMgYXJlIG5vdCBvbiB0aGUgc2FtZSBu
b2RlDQo+PiBhcyB0aGUgbmV0d29yayBkZXZpY2UsIHRoZXJlIGlzIGEgc2lnbmlmaWNhbnQgcGVu
YWx0eS4NCj4+IA0KPj4gSSBoYXZlIGEgdHdvLW5vZGUgc3lzdGVtIGhlcmUsIGFuZCBpdCBwZXJm
b3JtcyBjb25zaXN0ZW50bHkNCj4+IHdlbGwgd2hlbiBJIHB1dCBpdCBpbiBwb29sLW1vZGU9bnVt
YSBhbmQgYWZmaW5lIHRoZSBuZXR3b3JrDQo+PiBkZXZpY2UncyBJUlFzIHRvIG9uZSBub2RlLg0K
Pj4gDQo+PiBJdCBldmVuIHdvcmtzIHdpdGggdHdvIG5ldHdvcmsgZGV2aWNlcyAob25lIHBlciBu
b2RlKSAtLQ0KPj4gZWFjaCBkZXZpY2UgZ2V0cyBpdHMgb3duIHNldCBvZiBuZnNkIHRocmVhZHMu
DQo+IA0KPiBSaWdodC4gQnV0IHRoaXMgaXMgYWxsIG9ydGhvZ29uYWwgdG8gc29sdmluZyB0aGUg
cHJvYmxlbSBvZiBkZW1hbmQNCj4gYmFzZWQgdGhyZWFkIHBvb2wgc2NhbGluZy4NCg0KVHJ1ZSwg
YnV0IGl0IC9pcy8gcmVsYXRlZCB0byBUcm9uZCdzIGluaXRpYWwgb2JzZXJ2YXRpb24uDQpUaGUg
bmV0d29yayBkZXZpY2VzIG5lZWQgdG8gYmUgYWZmaW5lZCBwcm9wZXJseSBiZWZvcmUNCnBvb2xf
bW9kZT1udW1hIGlzIGNvbXBsZXRlbHkgZWZmZWN0aXZlLg0KDQoNCj4+IEkgZG9uJ3QgdGhpbmsg
dGhlIHBvb2xfbW9kZSBuZWVkcyB0byBiZSBkZW1hbmQgYmFzZWQuIElmDQo+PiB0aGUgc3lzdGVt
IGlzIGEgTlVNQSBzeXN0ZW0sIGl0IG1ha2VzIHNlbnNlIHRvIHNwbGl0IHVwDQo+PiB0aGUgdGhy
ZWFkIHBvb2xzIGFuZCBwdXQgb3VyIHBlbmNpbHMgZG93bi4gVGhlIG9ubHkgb3RoZXINCj4+IHN0
ZXAgdGhhdCBpcyBuZWVkZWQgaXMgcHJvcGVyIElSUSBhZmZpbml0eSBzZXR0aW5ncyBmb3INCj4+
IHRoZSBuZXR3b3JrIGRldmljZXMuDQo+IA0KPiBJIHRoaW5rIGl0J3MgYmV0dGVyIGZvciBldmVy
eW9uZSBpZiB0aGUgc3lzdGVtIGF1dG9tYXRpY2FsbHkgc2NhbGVzDQo+IHdpdGggZGVtYW5kLCBy
ZWdhcmRsZXNzIG9mIHdoZXRoZXIgaXQncyBhIE5VTUEgc3lzdGVtIG9yIG5vdCwgYW5kDQo+IHJl
Z2FyZGxlc3Mgb2Ygd2hldGhlciB0aGUgcHJvcGVyIE5VTUEgYWZmaW5pdHkgaGFzIGJlZW4gY29u
ZmlndXJlZA0KPiBvciBub3QuDQoNClJlYWQgdGhlIG1pc3Rha2VzIHRoYXQgSSB3cm90ZSBoZXJl
IDstKSBJIHdhc24ndCByZWZlcnJpbmcNCnRvIHRocmVhZCBjb3VudC4gQXMgSSByZXNwb25kZWQg
bGF0ZXIsIEkgdGhpbmsgYXV0b21hdGljYWxseQ0KbWFuYWdpbmcgdGhlIHBvb2wgdGhyZWFkIGNv
dW50IHdvdWxkIGJlIGEgZ29vZCBpbXByb3ZlbWVudC4NCldlJ3ZlIGJlZW4gZGlzY3Vzc2luZyB0
aGlzIG9mZiBhbmQgb24gZm9yIGEgd2hpbGUuDQoNCg0KPj4+IFdlIGNvdWxkIGV2ZW4gZGVmYXVs
dCB0byBvbmUtdGhyZWFkLXBvb2wtcGVyLUNQVSBpZiB0aGVyZSBhcmUgbW9yZSB0aGFuDQo+Pj4g
WCBjcHVzLi4uLg0KPj4gDQo+PiBJJ3ZlIG5ldmVyIHNlZW4gYSBwZXJmb3JtYW5jZSBpbXByb3Zl
bWVudCBpbiB0aGUgcGVyLWNwdQ0KPj4gcG9vbCBtb2RlLCBmd2l3Lg0KPiANCj4gV2UncmUgbm90
IGRvaW5nIGFueXRoaW5nIGluaGVyZW50bHkgcGVyLWNwdSBpbiBwcm9jZXNzaW5nIGFuIE5GUw0K
PiByZXF1ZXN0LCBzbyBJIGNhbiBvbmx5IHNlZSBkb3duc2lkZXMgdG8gdHJ5aW5nIHRvIHJlc3Ry
aWN0IGluY29taW5nDQo+IHByb2Nlc3NpbmcgdG8gcGVyLWNwdSBxdWV1ZXMuIGkuZS4gaWYgdGhl
IENQVSBjYW4ndCBoYW5kbGUgYWxsIHRoZQ0KPiBpbmNvbWluZyByZXF1ZXN0cywgd2hhdCBwcm9j
ZXNzZXMgdGhlIHBlci1jcHUgcmVxdWVzdCBiYWNrbG9nPyBBdA0KPiBsZWFzdCB3aXRoIHBlci1u
b2RlIHF1ZXVlcywgd2UgaGF2ZSBtYW55IGNwdXMgdG8gdGhyb3VnaCBhdCB0aGUgb25lDQo+IGlu
Y29taW5nIHJlcXVlc3QgcXVldWUgYW5kIHdlIGFyZSBtdWNoIGxlc3MgbGlrZWx5IHRvIGdldCBi
YWNrbG9nZ2VkDQo+IGFuZCBzdGFydmUgdGhlIHJlcXVlc3QgcXVldWUgb2YgcHJvY2Vzc2luZyBy
ZXNvdXJjZXMuLi4NCg0KSSd2ZSBwcm9wb3NlZCBnZXR0aW5nIHJpZCBvZiBwb29sX21vZGU9Y3B1
LCBiZWNhdXNlIEkgY2FuJ3QNCmZpbmQgYSB3aW5uaW5nIHVzZSBjYXNlIGZvciBpdC4gV2UgZXJy
ZWQgb24gdGhlIGNvbnNlcnZhdGl2ZQ0Kc2lkZSBhbmQgbGVmdCBpdCBpbiBwbGFjZSBmb3Igbm93
Lg0KDQpJbiB0ZXJtcyBvZiBtYWtpbmcgcG9vbF9tb2RlPW51bWEgdGhlIGRlZmF1bHQgc2V0dGlu
ZywgdGhhdA0Kd2lsbCB3b3JrIGluIG1hbnkgY2FzZXMsIGJ1dCBpbiBzb21lIGNhc2VzIGl0IHdp
bGwgcmVzdWx0IGluDQp1bnBsZWFzYW50IHN1cnByaXNlcy4NCg0KVGhlIGRlZmF1bHQgb3V0LW9m
LXRoZS1zaHJpbmstd3JhcCB0aHJlYWQgY291bnQgaXMgY3VycmVudGx5DQpmaXhlZCBhdCA4Lg0K
DQpJbiBwb29sX21vZGU9Z2xvYmFsLCBhbGwgOCB0aHJlYWRzIGdldCB1c2VkLg0KDQpJbiBwb29s
X21vZGU9bnVtYSwgdGhlIHRvdGFsIHRocmVhZCBjb3VudCBpcyBzcGxpdCBhY3Jvc3MNCnRoZSBu
b2Rlcy4gT24gYSBzaW5nbGUgbm9kZSBzeXN0ZW0sIHRoZXJlIHdpbGwgYmUgbm8NCmNoYW5nZS4g
QWxsIGlzIHdlbGwuDQoNCk9uIGEgdHdvLW5vZGUgc3lzdGVtLCB0aG91Z2gsIGVhY2ggcG9vbCB3
aWxsIGdldCA0IHRocmVhZHMsDQpvciBvbmx5IDIgdGhyZWFkcyBlYWNoIG9uIGEgZm91ci1ub2Rl
IHN5c3RlbS4gVGhhdCBjYW4gaGF2ZQ0KYSBzdXJwcmlzaW5nIGFuZCB1bmRlc2lyYWJsZSBwZXJm
b3JtYW5jZSBpbXBhY3QuDQoNCkkgZG9uJ3Qga25vdyB3aGF0IHdpbGwgaGFwcGVuIG9uIGEgc3lz
dGVtIHdpdGggbW9yZSBub2Rlcw0KdGhhbiBuZnNkIHRocmVhZHMuDQoNClRodXMgSSB0aGluayB0
aGVyZSBuZWVkcyB0byBiZSBhIHNvbHV0aW9uIChsaWtlIGR5bmFtaWMNCnRocmVhZCBjb3VudCBh
ZGp1c3RtZW50KSBpbiBwbGFjZSB0byBhZGRyZXNzIHRocmVhZCBjb3VudA0Kc3BsaXR0aW5nIGJl
Zm9yZSB3ZSBjYW4gY2hhbmdlIHRoZSBkZWZhdWx0IHBvb2wgbW9kZS4NCg0KDQotLQ0KQ2h1Y2sg
TGV2ZXINCg0KDQo=

