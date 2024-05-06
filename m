Return-Path: <linux-nfs+bounces-3179-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B70E8BD60A
	for <lists+linux-nfs@lfdr.de>; Mon,  6 May 2024 22:09:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E28F1C216A1
	for <lists+linux-nfs@lfdr.de>; Mon,  6 May 2024 20:09:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E3DD745D9;
	Mon,  6 May 2024 20:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kGSFpUqn";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="bIx07gfp"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B4CB15AD95
	for <linux-nfs@vger.kernel.org>; Mon,  6 May 2024 20:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715026148; cv=fail; b=eYJmSQWO2PhzSzsPNmfxvZr8p8FVFyhn3gFELuD/BpjYqP5+OTVITfgypPVfNkeEjITTZVthcAq5MXZ7B+ox36TVJmd6/kqJnDat/RKawlQiaHd0qcvVOMwA0tq8Ri9ERLUv0RCwx590ks9+MkemAoSQC4cxzLTY0LOyk3gmDT4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715026148; c=relaxed/simple;
	bh=89j1n5AA8eHAR/0p/CKnCuWo3JebqmxW4jBY4z6oPu4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=FSAynlVS0iVqZA3DmIEGNAtbtClTZQc0arE64PFYKdD9hQ69CHejENPI50D7jb5Zcg6WKAFdhHAJX+Hy/pt3bTkFxtyI/GhusGBwcfGbO/605BfFK/MQVoYXYWIY5JYmLP8qfneH/bCVThPpVLoxqNmx8fNyOrFjALp/0/xo+E8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=kGSFpUqn; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=bIx07gfp; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 446IF7Je007305;
	Mon, 6 May 2024 20:09:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-11-20;
 bh=+RQEo79copITDzK1wh66G0ublqNG2AmH3zvfmmFKIdU=;
 b=kGSFpUqn8h0elICEr2fl3dTVtshQpRDUwrQzaZ6orwM47kYkUqsY/C95+klHR/kv2Ftk
 9VRljJSIZ1VJqgY1bFTDws9Us5sPfzwEgqembiGUYaYaKBqeX3Ei+mgPyx8zptCOx2ga
 GqtTjBTV3nnhgbbFCOBMLHjjKXdc95HWS4ga1cLNj4czn/ZvqeqCC9he2VdgdQh9tiLI
 dwvqXPyMg2qII9FQlnEGsYS+7CAGaxJ7qM72mf+WUoaQGqaQ9vyJQLU2eQ7yK+804KIn
 dRMyr9vCvUQ1opZzVftkrH97Ehb7p5ZOTpu1emMmj73dwhg1QlBhwNxuQdXGEB+gyi3K gQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xwcwbuemh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 06 May 2024 20:09:03 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 446JpBgG039363;
	Mon, 6 May 2024 20:09:03 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3xwbf63m30-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 06 May 2024 20:09:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aYdDGazK0ZUmIpDQfq/USDrx4mAc53aQg8VuRFkWPKYr2Prrz4GOq3AjEqStr4LRh+ala7T8UIFryNvg+fNGMDz4IF1ve3fh6SK5JY/+ZhiciZqgtpmONHwaFANZPArCn++nHixdbXIBYeIgW2hBLYWMqyMLQ72u+lVcRLev2+izKdC7lNaFQCFOfSCsWzwhtKDiwXPDyEONp10TUN9FJEL9nr2rIy/yQvonH47nbYWXZ5Ia1YjrwMCZOZjCRBwwRm6JUuFsYO+sN9IvK01nSUUOj9BwcaWxZNt6leHjMonzX76OsZso/SK/9xIbZgcZ6YA2zh8mMHfnKu/8csHMuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+RQEo79copITDzK1wh66G0ublqNG2AmH3zvfmmFKIdU=;
 b=EqlzLIjOxdlwDXsi8wNpxG1BnETwgVdqxwGTMy0d8NlW9S3I5e+nOMIcbFVYPUeY87e5W06mXPV708bXYXcI8q53gFTr62M6+wA1Kt7dq95IhrSfsBQh2DTAps55kj5hMLzkjGRJgOcH6CjngAeJ4BzpTYF2JHcgb6cuwp5iSauF47ioo5xN2xrwgkhul3Aua77ushSKG+9D9wOsZMkp3V+11xzgL/0D1jLGPDl7NfSF6sKCH6zTHVEc9Dax+vI6ShtAWEofMapVapKQJ03PBhFNeQQRFwvhvT/N4XbalDo8shOMO8WapJGMbgC5FUrVzL+x6xroZA+jo+dSdZDUWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+RQEo79copITDzK1wh66G0ublqNG2AmH3zvfmmFKIdU=;
 b=bIx07gfp0eh0uLXxvdHSxVHvEa560E0ZPYBFWY18Dc/UhfyPM7CvyLVHzU8vrTkK7qKjPvucLeiALmnORfpLr5lDV6vgMMWmgJuXl/BI6u5gkUlQ4clkXqzQc5cpwfRaRSxrbTakrjBbmgH8cYg53xf/rH21TraxylL4qsXfQgU=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CO1PR10MB4578.namprd10.prod.outlook.com (2603:10b6:303:9e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.42; Mon, 6 May
 2024 20:09:00 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.7544.041; Mon, 6 May 2024
 20:08:59 +0000
Date: Mon, 6 May 2024 16:08:57 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Dan Aloni <dan.aloni@vastdata.com>, linux-nfs@vger.kernel.org,
        Sagi Grimberg <sagi.grimberg@vastdata.com>
Subject: Re: [PATCH v3] rpcrdma: fix handling for RDMA_CM_EVENT_DEVICE_REMOVAL
Message-ID: <Zjk42a54FfH6jWMw@tissot.1015granger.net>
References: <20240506093759.2934591-1-dan.aloni@vastdata.com>
 <be4563e5-caa6-4085-98a9-a86e24c99186@grimberg.me>
 <Zjj9iOOJ0px+Lvin@tissot.1015granger.net>
 <bb1f1604-8b3f-4fc4-ac31-1f365c1fe257@grimberg.me>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bb1f1604-8b3f-4fc4-ac31-1f365c1fe257@grimberg.me>
X-ClientProxiedBy: CH0P221CA0042.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:610:11d::26) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|CO1PR10MB4578:EE_
X-MS-Office365-Filtering-Correlation-Id: a517b9f1-44f3-4d91-f4ba-08dc6e085e18
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?tYt17D0qW/F/xqAXl95yn+ouP+FNwL+eKwG7Pgs2dmKPuyIl7gtpwej1226i?=
 =?us-ascii?Q?g9XTHOsndoJr/1pPykuq/fdc8TEFAzcvkvroX3gCjOn88iVkhMp++t2nQ5qp?=
 =?us-ascii?Q?qb6+F3x3MlsOPFb3ScAD/6E3dXbLJSoqq1FcIECSa+yTg3zranDepTKEQjUn?=
 =?us-ascii?Q?850MusTPXiilLdwmAwPC3Y6PE1makRRupq0UpHp8yTh3cNliVsu8n732JuJh?=
 =?us-ascii?Q?tw8nk8CeWLXhE6pDidJ1fBRxY4J09LpSGxOrURsrC7PIAnBXT+B3skxQdgPT?=
 =?us-ascii?Q?4uPm8yDWLZDcrTLrYtuKx/DcQnfpQL82hMjb3KDSwUSt5GbwUUFo+QE4Ft9R?=
 =?us-ascii?Q?1edcn86f2eF6P6dJ3XgXQxXiRwImpFtIMGlTZx9/tx5LHpcgq4C6ubXq7o/X?=
 =?us-ascii?Q?lzs2ORhPatImHofqf/Az9bohS9g3ujXMM2pxUGY2MZA6YeRnG10SEPJNRlHV?=
 =?us-ascii?Q?tlUx9MliVz3dx2ir0RitjZ/d5H5YQD1GSUzoyrh1qOk+og+oAVw6W8rnIioz?=
 =?us-ascii?Q?Qpfld6o1WzM+Udfvc0j9em++M74Pq5SrOT+JbKpg5EW2+J4Z3jtkkfeCdsw0?=
 =?us-ascii?Q?0xYX6hw7LrFI/f9t94l+eWyGRuvfu2S31T9bxK7Q47NaUhPNfcn0GRfwLTe6?=
 =?us-ascii?Q?MPXZIjfswlChmjDhVM/M0JRvZDt/Pd6WQ3XdGhY8ab2Q1EzIPGhFTUYMj85F?=
 =?us-ascii?Q?PF+NN43k61D19OBoZD/BXaMXIEKE3znu7uJpEaXfXhf4w98quXIgSg57fpjQ?=
 =?us-ascii?Q?o5ec5zmzuiPYKqKfCRrHVJxuw5wkJkfCH1ADJJWzkpx74v08Z57MPtT1Jf9p?=
 =?us-ascii?Q?l+R9ZxxPuzU4RmYQs5nkjdO1h9bqXgYZmiW9wHBugEG6RwGkeMkYT1jfXCbO?=
 =?us-ascii?Q?vGLfcX23nkVuLL+7L1Rx7HWbJn+/pvmOKN5g1/1lUJrpSZN/718RzJhBhUyL?=
 =?us-ascii?Q?mFOqUk3owxxiVPTRIim7D/yEHVugGxyRGXboXYXwXq5Jo/ocQfDW+nKS6sjw?=
 =?us-ascii?Q?/p3wDgtZEYoM8Bp27PJB5zGDj9Vex2N+4vI+b1qQFPxM7uDQ9W8qurQxT/rX?=
 =?us-ascii?Q?TSpr4Z4s6EG4AakXD48RL1wfWGS8N2avG8Ml2T5jp4B2yv20GHWTvk3uYm9k?=
 =?us-ascii?Q?Bkg/5e2MVWEaF4Fvc9WlZZGHqYkaJdHR2T6FWgbkmIyaDXo+54R0yIytZcuq?=
 =?us-ascii?Q?XRxHLTk5MHmVct4aGdgqXg4jLCFFsjBMLxJe7XTUV4n/s7r2zXmpPKYJ8S4Z?=
 =?us-ascii?Q?UXu+lCuidGSCAlCtGPNtT2KF5rdyv7aRZeMwIFlQNA=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?BslpJpyEyyF3r1oJALyFRl4vNxbvH2UFjJXdJZ/Ov6PQKVnSls2OrO5pUywT?=
 =?us-ascii?Q?FxyFy3Lum6r1hIVtG1jrLst39LvCY29qAyi2VR74KRORIOho7TDDkLcStliN?=
 =?us-ascii?Q?0n4uZfYKLV5+AP6q1nOLIdTRd6FroC7dXwO+xC6O6e0+hUL9RpMxQA1ievjd?=
 =?us-ascii?Q?umdLidh2DI9R1T3osiL2DD+EljmlMUfFEjH8s+taj1oWJV+r5fZ7ZseyMA9j?=
 =?us-ascii?Q?RBZW4kajuIsxbMGpEgnxD+sjNSIeafx+LNlItvbL4HK6mdZSAnlg/xBggJXB?=
 =?us-ascii?Q?y4z5X0tA5w3hkUZtvHTGXDRN7xZEDY9DM9kjtx/JbXjRv+8xSNbzvC72hL1B?=
 =?us-ascii?Q?H7D2GazFVNgpbe6YTBM9hRjUXorsVW1SgbiF08btdQubIVQJh/kJIpwVOnyF?=
 =?us-ascii?Q?ow2G+0F7PYAvCgETeSF7BRUi6Xg/4y1vgN9rLuGb1t3FEAkrvM5tpVvF0cu/?=
 =?us-ascii?Q?NsMhaQlH0TI/vbIu0eQUsahnsLBITuipeUCqqIlRWX5TXIHRJlh4DQix97UK?=
 =?us-ascii?Q?M7WUPTEMHDRNvXFwdJ6ODlRNELTtOUmlbaUO8H1n0OOPfu6v2fePlYXrTTl1?=
 =?us-ascii?Q?itS/ImKmVFSqoKe9Jkn+9VrTp+Cn4jCyo05LzeYAHUVEFofq7F9pFXDaJv8S?=
 =?us-ascii?Q?lXPudLfKtK/8+M2iQy59gxyOd2aYMn1kw7WkozpfFqyheXrRkGjm14HhTGn5?=
 =?us-ascii?Q?C4O6qJJfmW2zjfqGZ9pGgadPakvlL6NRQXhHC2rktl50uWRfmPYNdSLnsO6z?=
 =?us-ascii?Q?NyOHcKib3Le24TgKm9vHG5cknrAbHlrjh0AZLOpG8iiibwAKJNtbvA+zIxL6?=
 =?us-ascii?Q?ob2IwPJu4SouHLOsOvlvOhyQN2yIjsS3uwuyayuCQEto4Ma7Nft/llr0ZwS4?=
 =?us-ascii?Q?eTqi0Y5ez12NY4C2CO2cx38z5dR0OD5N2Ryk+RYj5C+HNap/YKBwOENJaJHx?=
 =?us-ascii?Q?VPkLLX8vvWUjsurYV+LyFJfSYGidkIOLecLgwvkiG4WOADYvhVvnDeWz06nT?=
 =?us-ascii?Q?+2JSrFCzRMZqQE544Ua7TrFHdsfypKHYak8+RWQZHv7v0cYag8rhRkS7iGgn?=
 =?us-ascii?Q?pjr4whKTqKkgh5c8dDPyTr6/zDcZvkqmkD/QOwAebgszQSU7vPtQub8T4Bww?=
 =?us-ascii?Q?VIAMT5jHVmaHh/uHGQBVK7O2vp27zxi/goVpGwTEtyRhuxxzI88YNnsLsJ0i?=
 =?us-ascii?Q?7SFQzGUOfohctEoeXR9lzgIer/54ixr0vUc44gnLmIK4b6hnkkKueU6tp8QY?=
 =?us-ascii?Q?Gsmf4eZavo9MLaLn2GPN0owt4cyQzsp0q0SXTY521ggDRZR2DsSrNW7x0b3c?=
 =?us-ascii?Q?TmYu7FxKyihbvCI5/93JtH/PnTvWJfcyRTG5dmWQyYgvSO2PTIitqci64qpi?=
 =?us-ascii?Q?QYnLir1f/LGE7tQIAzc6os6fC9WOJfjQcao/ahLwEW1j6J4ndvowXbMdcQXw?=
 =?us-ascii?Q?XHC0tcdcUqMFbq8YpDDFP6DdPRKXCJ+lCfuDuVjhi7sYUtT0emBi++4ZvzQT?=
 =?us-ascii?Q?rDk8MRSugqKNsDfMLcO0ATRwcw6ovdPkoLDACNvNU5ZdHWTxQQrXj3tJQAvD?=
 =?us-ascii?Q?e/cUZnojfShGfw8U/bpKpow4BgCUFYwOctu3vkOU+kLbbnmIqRfpBtYdgGDw?=
 =?us-ascii?Q?+g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	DZAoL/g7OQug5q2mCDzb417GuIUApvR6UsFHtbZTFJP256uMoIwNEXAR8iZGLQUhL4kTX9EKCUcNavxY9mfS4bSzoMuXxyK0DlH03JPKpVjhpeO+5brNbxUeS/qZ/os96c97schjncWO7kXNq8Kgn17NRobfSjYcUuIyIJzkJUUCcvcnTEr0XCQmFaRNGIlT0I8HJb23wIDwnAKieHn3gttFZyMVAMFFosJ5VvBwqYsJDX/17dAT/cAyAMaXhV3yy3UHWLdP0eiZiMFUnsuQzFGX9ftS8pH9NvfSTGIcvUXNkGsatEfZ0UGOXWrIcVeMWNqwwWLU1e/7JW6FtNnaKl5rkq7j+g4+cYq2KErgEM25NdFnydlvAA1/miWZvceAgMLDKA7uqVwAOz9eGtAeSsS9eoKn83o9L3mbAvRCLRHQKIOD1t5ozjuKpHKwvMFQx5QPlUrTrLlT/OvhMyOdNPdsFVvoF/UR9R1yHIrKsaqHEuOE9vzOrf8BkwxDNS3NBgfBzxb1qm2XIUXndxRwQf5O2vXdmkridc3K0sNTDR9oowq6uLeJL8s0CRk4eMVO0Xir74pfpvKt9AmuhTkyAMjE0gmge8wNe6/UhYlFjsA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a517b9f1-44f3-4d91-f4ba-08dc6e085e18
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2024 20:08:59.8112
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q80PNVuRbY7GeCVtxNeibSxMSCsMIJgcQVQbShoy0dyoVzTGA4NVuA8ypOh+q90iezWF+Dcs1RjzIH/HMC2QGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4578
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-06_14,2024-05-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 bulkscore=0 suspectscore=0 spamscore=0 malwarescore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2405060146
X-Proofpoint-GUID: IbTpns43mjuE6ljRGWLL7UroTCNzdTP_
X-Proofpoint-ORIG-GUID: IbTpns43mjuE6ljRGWLL7UroTCNzdTP_

On Mon, May 06, 2024 at 10:10:12PM +0300, Sagi Grimberg wrote:
> 
> On 06/05/2024 18:55, Chuck Lever wrote:
> > On Mon, May 06, 2024 at 06:09:51PM +0300, Sagi Grimberg wrote:
> > > Question though, in DEVICE_REMOVAL the device is going away as soon as the
> > > cm handler callback returns. Shouldn't nfs release all the device resources
> > > (related to this
> > > cm_id)? afaict it was changed in:
> > > e28ce90083f0 ("xprtrdma: kmalloc rpcrdma_ep separate from rpcrdma_xprt")
> > In the case where a DEVICE_REMOVAL event fires and a connection
> > hasn't yet been established, my guess is the ep reference count will
> > go to zero when rpcrdma_ep_put() is called.
> 
> Yes, I was actually referring to the case where the connection was
> established.
> It looks like rpcrdma_force_disconnect -> xprt_force_disconnect schedules
> async
> work to tear things down no?

Yes because we can't rip out the hardware resources while the
RPC client is still using the transport. Converting to use an
ib_client might help by first triggering a disconnect, done
with proper serialization.


> > > FWIW in nvme we avoided the problem altogether by registering an ib_client
> > > that is
> > > called on .remove() and its a separate context that doesn't have all the
> > > intricacies with
> > > rdma_cm...
> > I looked at ib_client, years ago, and thought it would be a lot of
> > added complexity. With a code sample (NVMe host) maybe I can put
> > something together.
> 
> The plus is that there is no need to handle the DEVICE_REMOVAL cm event,
> which is always nice...

I'll have a look, thanks for the suggestion.


-- 
Chuck Lever

