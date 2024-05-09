Return-Path: <linux-nfs+bounces-3220-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F28178C1042
	for <lists+linux-nfs@lfdr.de>; Thu,  9 May 2024 15:24:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A991A2812B1
	for <lists+linux-nfs@lfdr.de>; Thu,  9 May 2024 13:24:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 334F815217F;
	Thu,  9 May 2024 13:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="X6qk5sLN";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="aiEBkQg2"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24D91152785;
	Thu,  9 May 2024 13:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715261061; cv=fail; b=s9BJ2CxuZXzhd1Da135Md7GQHnEglC+rxp/FLk5/SiFGjlbIH2MVAGt72OG5Ntpo35qkevdXb0bOrCGQYpasEZzz9xvpyfDM0bQ/lw2Je6uMa1KNJlLYo+x8jm/sFB+wDPiwFS/LHtxlPayUJpgGHvifMue+0kbo4kpjX02BmN4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715261061; c=relaxed/simple;
	bh=yOQxdVvn6RU6dLVNl/QrcWogDcz2j/AIHeD0+Yi1FsE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=VTqYybinPiIZccxh2oqYLU9FOaRmtXYWpnB6ZooZvcuNCF67O11Y3UReMYvc8az+wCE0h9LSlo5rKx6yXPvFi0EXQC2vXbwBvUQnWUI68TTN+VLDOzR9sCkAZSHFlAxEsuHmwIGp696F9mngJARmqSGfGCbsKYOyv90H1PqPZzc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=X6qk5sLN; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=aiEBkQg2; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 449DNtRT019481;
	Thu, 9 May 2024 13:23:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-11-20;
 bh=HdyszSnCGDHN2P/FX6X8EcWYi0a+jmcXgnWC7lQC2KY=;
 b=X6qk5sLNZ4kvW5PvOLvPQnLWHAGZRh3aP9b1X62bnCUkYxpvaXE0EcRCp4JCWYIkf+Pe
 ZPvH0xPR70HgUbIN+6G6x5u3kOeNLZJyJeL9orhYA9TrpUo1Gb4j1rw4J2wrkvzyq+2C
 FIApzWnVjoYLUV+fFtj3hC+5w5pp+t/tQPzSyepep9ASQ5lpQf6uqINpddeRJ+snekMF
 1rNRqYxwyILHzeLf6HssDxldxMSQiTddzcxcke7P2MHmEwAQNKQJNvOjoKCsmGLywA1O
 zNZCKdPtlllsbxGwcezmiQmVBs9xJhhvPexmSc1Xz0qA2GLVveQOzPdhQbjRftmaiacR 5A== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3y0t628kv6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 09 May 2024 13:23:57 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 449Cb0sv019119;
	Thu, 9 May 2024 13:19:54 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3xysfn4upd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 09 May 2024 13:19:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QnI5xI8Yesy8UlFcCRRW24JNyFQfSvodqnHsYHFC7lg9mg51YfGZUhIVUoMelh1pTG52YXSyxHiIjM5RHU4nk+2ZBmiL+SQciWxiAG9A4JfveJL8y9DjE69F41qrFMTjgOw3jpjZM8aC6wJxHHNLA1OfZYea0m3NVPry2eQHdeKDgtZV59pc1A4C1fMyDxJfFhE37Y7JAM162WVaZfwsftJ9xmZpze/d3KXGj+8j2SVWdawVOkr8rhEiE0IPvMcdhlarJw/S1kZanUr8QwrkjNnAGnNHyBcQPriH5pYekhLNpHcntCfOs8eJCt94cCx82YiwjkoLFxERAvlPIttLiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HdyszSnCGDHN2P/FX6X8EcWYi0a+jmcXgnWC7lQC2KY=;
 b=Use4BU22czZmq1Ptyrux5XgL1DmrE6yij3xVf4o3Zv76mRJtJsb6RdbH7zBYyALGpJikf9L+oifVWG9X1h7gFiYB5PwQqm37wXP2j91W/cgnuO/lqNGhzbls0Pz2aXRi7yPKv4Af+EORrlguNskFKrNr33oLdXBdMMiRYwFFGrfSd8R2dLY/7bb8DYcGOOyLTGthRHJVnYwJ9o3LThc8SiAijPeVqEoso/wtcOzrJC3Y3NVxSjMCjepcCPoCmypQtqRGxFJU46K7PHlScEi+G9BOZSU1rn8ktSCQVfOef1mqC8jJfolWfKaJOWQSY5YikATviYOlp4eTIDG5kFalUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HdyszSnCGDHN2P/FX6X8EcWYi0a+jmcXgnWC7lQC2KY=;
 b=aiEBkQg2h3uMSSKHzN7Ijf8woeSCvZHesiZONwIqd4Jw9idefPOGvl4Bl5oXITg8KBcTSXcEja6BsyoIKyOg85AQVXdTujhcv8lXahdnZuTycrZthINKwuigVibfbXeTeEd+Cx0nDSMKleWOI0qz22gtVqO3Q13/nkKQSSSo6dI=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CH3PR10MB7678.namprd10.prod.outlook.com (2603:10b6:610:17a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.41; Thu, 9 May
 2024 13:19:51 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.7544.047; Thu, 9 May 2024
 13:19:51 +0000
Date: Thu, 9 May 2024 09:19:48 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Jeff Layton <jlayton@kernel.org>, Neil Brown <neilb@suse.de>,
        Olga Kornievskaia <kolga@netapp.com>, Dai Ngo <Dai.Ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH 2/2] NFSD: harden svcxdr_dupstr() and svcxdr_tmpalloc()
 against integer overflows
Message-ID: <ZjzNdLynC7WxwLno@tissot.1015granger.net>
References: <332d1149-988e-4ece-8aef-1e3fb8bf8af4@moroto.mountain>
 <babdb32b-3f3a-4e46-8cbb-26f0ca49cc61@moroto.mountain>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <babdb32b-3f3a-4e46-8cbb-26f0ca49cc61@moroto.mountain>
X-ClientProxiedBy: CH2PR18CA0003.namprd18.prod.outlook.com
 (2603:10b6:610:4f::13) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|CH3PR10MB7678:EE_
X-MS-Office365-Filtering-Correlation-Id: 51cf4864-7ed5-4bfd-8c1d-08dc702ab566
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?MvtWubtFYHpwNCiTVyuuhmK9uSvtnFEj3DqA1yZq889OvT279EF/mYwPeEDk?=
 =?us-ascii?Q?fta4tocjTf6P4kkDHAIKAJPfpPSt+uYXV0ToTCOsgnMdX6SS2pCZ99qZv6Yq?=
 =?us-ascii?Q?xe/2Zikig5UXWhEPzEAME2Wscfrt1z1lFZnn7VJILQVPkGkFAo+Ud0bRlSdX?=
 =?us-ascii?Q?4shgdK53qzN1owrZ377CUga/InFYvzkdg8806V85pP7lrxvh918Bdv1ChQt5?=
 =?us-ascii?Q?BnebBzMaRjNfc/cTv+mZfCrn+SwEHKWEFLUXlH2BQt0/2XhMNKMYTyafKSp4?=
 =?us-ascii?Q?b+kXyZePeID1xbRQT+K6HrivYpTF3SysAQ67Pg1bcZ9vBeobNXCeGGw+3HyB?=
 =?us-ascii?Q?3Q+eii/c1uDeZ/bliZh+YIP2gZlHLkim+4uGVLBUgppnookyPZ22BDWpEF/X?=
 =?us-ascii?Q?CflYEMXscG5yD/Yeqmw3aUSJUEx0Jg75IFzIfcTXTNKCNZc+ldHggRx/6g53?=
 =?us-ascii?Q?sTGgTSiq3yc06Ol6cT5SZbWYmTotZmAZkB5UtGsedqOytRwo+FqkiG/8tqX8?=
 =?us-ascii?Q?h8nsvwfkGcVon+wlF2gzl/VPdJ/BM2FJoVNQOXZyzogPDPYQuQfuIGRx9uDe?=
 =?us-ascii?Q?aHvgE0jAN+u31zpc5TQWlC9u5YvfzOO3yw+AVWdpSd2QMtLEVTxCADoE6qtr?=
 =?us-ascii?Q?UVzbV3YDCCNzNNRtn+xAVyokCqLaMSIDtK/V3KFrqVBZw5q89utApmCe0Bev?=
 =?us-ascii?Q?bkLMIma0eXJZfTQFOiJHkTVskeMysnc/5ImzUSO02HiiT0qCQRBpLqmB6R2F?=
 =?us-ascii?Q?DgCEtFBuL6pl6XpVtzsl1k40BBkbHM/893XWWFa4VopxMaOKVhiOYQX2VMmh?=
 =?us-ascii?Q?uldxof7pXUrBIwXNH8xM+lAgkRN+OYclIHc6k9UA88a3ew60f+CQqx8eQWXt?=
 =?us-ascii?Q?B8uc7sOprOQ9rqeOw1yOJyZWgHcpJxP6ht2IbCgMIpIqfa3QUEhwnOozHSWb?=
 =?us-ascii?Q?2y+uh04O1+uM++nR0AasMj3TM8FVU4gjr3+Euvm6/aiqJP7jGwcx3I9y5/O9?=
 =?us-ascii?Q?CdFuqefiD0cKcKYU0RoO8WLZU9HyZbkOsqk8MHp3f1gSXr8x6Y2PFGQJkw0y?=
 =?us-ascii?Q?Wmv8FeJw0/2m/b/SOYIuM08kqS6unBs8z34GWF/xDfSqlAtYhCp/Fy0phu7d?=
 =?us-ascii?Q?slc9YjvSeTA4HNGWs32puTBFBBDmmIfGUJVanSaXmY9uVb75Rm+fYc6FXmFW?=
 =?us-ascii?Q?nFEX7JsJZzpYqs6eT+DlT+FhCEj8/qDloo8NEkAH5qFHGbgRkVG89vvuSZuz?=
 =?us-ascii?Q?2+YgR+wpZL/ZXRkLYRRuxMJZQIeJZ28b7H/nbWEa0Q=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?YaolOWEIgw3DJPxJ7eMRutEgQhTWEf+ykmpQ3hqe7TBM1DpfsWa8S3bcKeDB?=
 =?us-ascii?Q?ou74tvHfcVzSpXKC+Xh/39TvkiSxIs3sZIcqc3D1DozgzNP5glCRwrgpbGNT?=
 =?us-ascii?Q?lcRkxf/xjz3RTSGN2HAmPadi6lRanaYm3+mCWQ8t586SAUQXyV/r7AT3h+zE?=
 =?us-ascii?Q?xJ8sUjpTSUL0soIJ30thYD0J1JFAwDd2ZuCz7VxvL+kffh2y/f6+X1x+mZmm?=
 =?us-ascii?Q?qvKpd7E6OvQhyD3wRCWd0rhGDOsfBctvD4hBhRCk+pcyactB0j8AGbhQn3GP?=
 =?us-ascii?Q?aNzFrczm7ROynin9xxUVqPzryEdDBU+7sqeCQdqN0zy2BSOEYYVUWzq86Ifl?=
 =?us-ascii?Q?GM2MQ9eVVHIoAXeV5zo3m1rW5PXgJpgTd2gDIZkUDovP1777X2MkWmuaAvBk?=
 =?us-ascii?Q?N+Bk7guafI218qqXP2eiue6h453nAgqYAGxDEPbtz2zFzRG4gUSsdQi+Z2aX?=
 =?us-ascii?Q?U31J09WijmAB26d/0lggmhS3Wb/U+l2K7hcpOsHTv2vnLTEQ/IgcP6ecVr2c?=
 =?us-ascii?Q?HUOgfb4ctDF1uXOIx/ljONVmemihaMVSuuhC1IT7n/dme3CUqJyOu/kyXG2I?=
 =?us-ascii?Q?naC+hzvmxgjHbW72EgRc2vg/CXavpbvvc58bnkQTfZLNF2umxwY+ApIg7fih?=
 =?us-ascii?Q?U+hXfkO4ns+Gkaexp5hM1oLayoI2aoxduAHhhikQowBlwwqwRxINJShfhYyU?=
 =?us-ascii?Q?ihrs+XMsSuzvBpelhj9QEx9pgbGDNE4yOMnRG82gpPTk0S+d5nz86RhWKu6d?=
 =?us-ascii?Q?aAU7AxBCYvy0dYgfNYrTKdAB8ZJuOnTTWfg8rbKPn0z6Zu27NklzGgCj1nDy?=
 =?us-ascii?Q?h5kAlc/2HTVEbh6vUleTCeWRiwfcQVYxRwTNiqhRRg8Zw2Q04fWkSRDO1kPI?=
 =?us-ascii?Q?+0FUtaLRa2L6aYLR/j+hYP+6QeWtUyOnI+1gJz6xHnbjRTaZTXv4F4uO2jgE?=
 =?us-ascii?Q?SIHMblN9IjNJFuZXqCPK+YRpUlTLDyUwIKPhPdK5exD9oo7qZloHDrHAV7JO?=
 =?us-ascii?Q?ornWCUxCNPI9/BI7A7+DJ9wrn48mAow/S4ZC4kg5YR+SF8jYcKyoV3dmug5D?=
 =?us-ascii?Q?MPsq6HcZ8fxEtw5J6e01XFGJuBKVQ3uGENVJuAiDtiyY9m+lH776O5TCxRK7?=
 =?us-ascii?Q?3UhepH6txcNmnRpjY77IcY5bUHMyKXBA3BRXvUuh9BeulMtQNLDMH5CtcPqu?=
 =?us-ascii?Q?fPRjzD0ZkMZbJl3QnXqhMNDgeGba8YV4Ek+kACbWK0/dzUZeuMpPpI5SDXjO?=
 =?us-ascii?Q?uL2k/eAOk55a/LwJuyffVGXGeAZYcxD6HnrbGxjulBfB0fMv2lYi08zPOocr?=
 =?us-ascii?Q?/dWEBdn529Xj4mxOc8IIBApBizZ0hFsscV1/djBTtV0GXsng9DBFXWtC3AoV?=
 =?us-ascii?Q?MVSTtatIK5xPRrfQjSD8MVe7bZT7N0H5eOukjfMlBwPuo2OdWNRy5ozL/M1y?=
 =?us-ascii?Q?77K/X88KZ/QcC205cpdcCltlhtPf/jtu+ocaPQYcuZPzR1YyhxvBVRzaOOnN?=
 =?us-ascii?Q?toxA306P/N+gKbk73uviSXpva6fdULwd3sQFWGSb6i9oYrX8Z9Pl6us5Jnuz?=
 =?us-ascii?Q?lTmf0pyuYO1sl8tz+AutIOMazHaoGI60T+VPdlfVbe5KxqLdx/zYehPsxaxl?=
 =?us-ascii?Q?Gw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	KRz1B5iScJp9Q1EV0EDZBnhzzKkgwK+TEnPH+ECIt2V7if0UGDWTVz16khu7HKNgtYOjhxUZHJSavXCTf/q/zyWeIkih1EAMxfprQsbOo475qGkHsmgHEDwvrXeSnYzeczf930X+x4KTYl3xGQy0QULj7kyvPobe2C8gQ7gSucn3O7MVdZrEwajAJrusqGAfVNxiI6yETnrFN03qfR9QOMeTAfDujKyLfPuoY5P/Qeia6/x6de4njQCE3nK1byFzzJ/S9sQet9Ea8HLTz3njdNaCfFMRGh5u472ZJBFbZPuea5M6OT4afYly0KxlIoxWq7gB+9TR6DwDgFPKN36c5PzQtbVVrsueU9HYsCfgN+nri8MIY/87gNq/VLTRNODPlZbUga48BPfozclL5YLvhh9qY7uDn00HCrzPgwCF/U+s7e02YSHCjnqtc3QTYciknBIdkBBjc5wHI4vGa9st8LRM35CC1r20q6m3fzgHwVj3tvC+VxTO5EV0WKia+m6oWOtkMR42K5ra0txjjVhDGWEyGHQVPxRyK8eWCgqyBhCN/iD2o1FVK0iFim4jdIG5vt6xZriSoBSzwQcRncxNegx4Iw6WPOKPb6IbAcj/hug=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51cf4864-7ed5-4bfd-8c1d-08dc702ab566
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2024 13:19:51.6083
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eIJfpM072V1BzTfnn+ikpINlFKFupNDsQwOcLTXgm4RBQBDu7iw8aTeWkQ65lwc0cVMYAR1RWH36+HgrbADjTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7678
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-09_06,2024-05-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 mlxscore=0
 suspectscore=0 spamscore=0 malwarescore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2405090089
X-Proofpoint-GUID: 2qwr-H2iapIqsqmVZXe9U5cvhQoVP4jK
X-Proofpoint-ORIG-GUID: 2qwr-H2iapIqsqmVZXe9U5cvhQoVP4jK

On Thu, May 09, 2024 at 01:48:28PM +0300, Dan Carpenter wrote:
> These lengths come from xdr_stream_decode_u32() and so we should be a
> bit careful with them.  Use size_add() and struct_size() to avoid
> integer overflows.  Saving size_add()/struct_size() results to a u32 is
> unsafe because it truncates away the high bits.
> 
> Also generally storing sizes in longs is safer.  Most systems these days
> use 64 bit CPUs.  It's harder for an addition to overflow 64 bits than
> it is to overflow 32 bits.  Also functions like vmalloc() can
> successfully allocate UINT_MAX bytes, but nothing can allocate ULONG_MAX
> bytes.
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
> I think my patch 1 fixes any real issues.  It's hard to assign a Fixes
> tag to this.

I agree that this is a defensive change only. As it is late in the
cycle and this doesn't seem urgent, I would prefer to queue this
change for v6.11.


>  fs/nfsd/nfs4xdr.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
> index c7bfd2180e3f..42b41d55d4ed 100644
> --- a/fs/nfsd/nfs4xdr.c
> +++ b/fs/nfsd/nfs4xdr.c
> @@ -118,11 +118,11 @@ static int zero_clientid(clientid_t *clid)
>   * operation described in @argp finishes.
>   */
>  static void *
> -svcxdr_tmpalloc(struct nfsd4_compoundargs *argp, u32 len)
> +svcxdr_tmpalloc(struct nfsd4_compoundargs *argp, size_t len)
>  {
>  	struct svcxdr_tmpbuf *tb;
>  
> -	tb = kmalloc(sizeof(*tb) + len, GFP_KERNEL);
> +	tb = kmalloc(struct_size(tb, buf, len), GFP_KERNEL);
>  	if (!tb)
>  		return NULL;
>  	tb->next = argp->to_free;
> @@ -138,9 +138,9 @@ svcxdr_tmpalloc(struct nfsd4_compoundargs *argp, u32 len)
>   * buffer might end on a page boundary.
>   */
>  static char *
> -svcxdr_dupstr(struct nfsd4_compoundargs *argp, void *buf, u32 len)
> +svcxdr_dupstr(struct nfsd4_compoundargs *argp, void *buf, size_t len)
>  {
> -	char *p = svcxdr_tmpalloc(argp, len + 1);
> +	char *p = svcxdr_tmpalloc(argp, size_add(len, 1));
>  
>  	if (!p)
>  		return NULL;
> @@ -150,7 +150,7 @@ svcxdr_dupstr(struct nfsd4_compoundargs *argp, void *buf, u32 len)
>  }
>  
>  static void *
> -svcxdr_savemem(struct nfsd4_compoundargs *argp, __be32 *p, u32 len)
> +svcxdr_savemem(struct nfsd4_compoundargs *argp, __be32 *p, size_t len)
>  {
>  	__be32 *tmp;
>  
> @@ -2146,7 +2146,7 @@ nfsd4_decode_clone(struct nfsd4_compoundargs *argp, union nfsd4_op_u *u)
>   */
>  static __be32
>  nfsd4_vbuf_from_vector(struct nfsd4_compoundargs *argp, struct xdr_buf *xdr,
> -		       char **bufp, u32 buflen)
> +		       char **bufp, size_t buflen)
>  {
>  	struct page **pages = xdr->pages;
>  	struct kvec *head = xdr->head;
> -- 
> 2.43.0
> 

-- 
Chuck Lever

