Return-Path: <linux-nfs+bounces-4143-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F9939106D1
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Jun 2024 15:52:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 357F61C20DE0
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Jun 2024 13:52:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24F358175E;
	Thu, 20 Jun 2024 13:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="oZ8KAnDi";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Z9RXdN81"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCD571AD487
	for <linux-nfs@vger.kernel.org>; Thu, 20 Jun 2024 13:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718891566; cv=fail; b=SaPUWOgVK5TGLjDw0X8Lg4ayttKjFCwuhYME0XpGhJkB5hMQBWvsn971iPsFAV+92YK8jpBKoYrLiDGHOuLH3vKUrU6Af0XPdFSzF20eFD1M6dEWwvhutYyDzbAZwpl6sziaVYJbIZBA/VsgXdcmoCD5mNLJFude7Clpy2mgh9I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718891566; c=relaxed/simple;
	bh=8GStOREK8EPC5bzXRWAv/hPAIznb0opBOkj105Nwrzw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Q5F5tv7mIaYe/GJxba/cdOhLnqJ9jlTeQNeeiO0HYTIDGPrCgiLSRsYr7n+WiFbtm5bE8XTTaXtO3AIG0p3g2dlLYr44DNtgSNNZX+NPrJHnWg+M8PilNFx25Sa3DAjCwBT9f2pCyEmZeng+EiTW7tOH69deu1M34ncKyhJkbQ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=oZ8KAnDi; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Z9RXdN81; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45K5FGYc005920;
	Thu, 20 Jun 2024 13:52:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=ougiaWQHx9iXIwP
	O6Ex3GSsYb3DGE4i4XFkQs5OWfAk=; b=oZ8KAnDiymHn8obHs+EW9kAJ5/gv4gT
	3xOXjfdcoKE7KRLqhBiEdze5BZ74FLK82x5ymN9BsqAyDVM8SbTDD62XbqYduPNB
	1RXY6rb6cpbo/N1iilzeKHjRa0PdUi+Umy0FlE6ukNJ7PXq+Z25AAbGrEB2Tv0A1
	bLeO9E3SrK23ULvjhvqdsQS+tGkdUOgWZDktdQCpjLjzNpmdfsghbcTwPpnt1zUn
	xBkMOr5YGMpEQyRo1jCcoU8QP3iebscS7hYQMK2cEyHhV82RX8qrTIgewwnWPPJ7
	pEItY8KXFvFOJBl1Q16Wc0cw/KWQqEfY2OQIj0z2H5NsyBWXHyS7YIw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yuj9jb8n3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Jun 2024 13:52:28 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45KDUjdf032379;
	Thu, 20 Jun 2024 13:52:27 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2041.outbound.protection.outlook.com [104.47.57.41])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ys1dagkfb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Jun 2024 13:52:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RLReOBGauHWRtzwfSL/nAUO+smsYVGKNq545Ana4s5rNzqIXliWBhaYOPaVx9HFHkUTSHdLOGup0XZGzibeaTi9Ibeu7AukshE7GTzHYJRNbXAWitzKoAivgTDFIhQlOgfsTenimlUlFYXpnrlgj0j0ktkxyv/Ll6bK+aXimrAO5D3PJfOASICaJW4Hx7hJYOrLqdhQOtC4VPW2prrs5+lCCs6lfTuCLnSBrmd1kd0LTMg03qeYMrA7650kGLX/5DLRgJz4gI40tePM72NbUeq9niUOfn+wfVt5e1Wt9UNCHsMw8CMltPH+A6beVPeglS1VkQHBY/PTPYE0E4xXZDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ougiaWQHx9iXIwPO6Ex3GSsYb3DGE4i4XFkQs5OWfAk=;
 b=MJ5OKDNd/nTzWUg7MMTD9/P/RZoKm2cssj9qHTDiPTkwOjo6uiXw3ZT5NXybxJIdJU4GGGCJLM5xbCF6QeANhS5u1U7o+R3k7/3SscaewhxQFNjbh973ntpdRqdu797I3MmhxsCvnkOxKXkND9nX05ftZ6PHhhF8Xt5yvaCf/F3GAL36ruGT2lulk+jECHbVUXQQb05/FRL277Z3IZd+uEE/oUqvKjYwZjulf0hYDHChJSBbIfPh85xpAiJMhFmeBHPvkam+gINo9Q/jcdL2cTImTC4/e5M0e4PUtYOGwTdz1xOpG1N5Vv+IEgmUk9ypoKGEo6k+nJC9kALqttBeUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ougiaWQHx9iXIwPO6Ex3GSsYb3DGE4i4XFkQs5OWfAk=;
 b=Z9RXdN81VdL3f0fCKY+U07Lf3/ik0QgOyTY0y5B3cHzttDyKW+3q5mAWuE07ACw5ed2fRmwieyxNhAoFcW6O6Zr7VOBdZ7DKhDXXv6m1a67RdKrr66q23gyWJMxy1cDAisvqaWlckjxs8bIDgVU2o97OBkmxJ5VGrA6GqL83qOQ=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by IA1PR10MB7445.namprd10.prod.outlook.com (2603:10b6:208:449::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.22; Thu, 20 Jun
 2024 13:52:25 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%5]) with mapi id 15.20.7698.020; Thu, 20 Jun 2024
 13:52:24 +0000
Date: Thu, 20 Jun 2024 09:52:21 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: Mike Snitzer <snitzer@kernel.org>
Cc: linux-nfs@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
        Trond Myklebust <trondmy@hammerspace.com>, NeilBrown <neilb@suse.de>,
        snitzer@hammerspace.com
Subject: Re: [PATCH v6 17/18] nfs: add
 Documentation/filesystems/nfs/localio.rst
Message-ID: <ZnQ0FSQHJLPHxRsP@tissot.1015granger.net>
References: <20240619204032.93740-1-snitzer@kernel.org>
 <20240619204032.93740-18-snitzer@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240619204032.93740-18-snitzer@kernel.org>
X-ClientProxiedBy: CH0PR03CA0235.namprd03.prod.outlook.com
 (2603:10b6:610:e7::30) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|IA1PR10MB7445:EE_
X-MS-Office365-Filtering-Correlation-Id: b2a5d247-c78a-46ea-b7db-08dc913036ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|366013|376011|1800799021;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?LqXzfP+jn+vZ0pHf6pfC3i6m6Adx4aILRBv+i2xJsbIAb6LTfjNMiis2Oe6X?=
 =?us-ascii?Q?qHzaNIUEFxLdEK3WOfw+rT5eKMlcrKwJeZ94AxTBMT7CaQ+RpX2IRXxjI4Bg?=
 =?us-ascii?Q?e8NsVcfjlvr0fRktBOLZ+pLMbtFuPBXDov/4OpO2/N0GsG1uK9IA63teUdg4?=
 =?us-ascii?Q?Sr8aWmxQcjxpcgvuk+iCLudGQQl1IyJ6mfZCbEl3qC7Scz4e7pyjEPgwSOOi?=
 =?us-ascii?Q?bZ9BnfrZX7HPs88iEXw2k8qpzqpaxM0DSNKI8rIim1GLDOcJvVY9rPbzFAjl?=
 =?us-ascii?Q?qnmiOBu5v2H78GxPDrVOyBKZP/ty5Tb+uEBlT106dLAPVPIhGgqvgyL2nwBw?=
 =?us-ascii?Q?crQCM12OiEHAWaAiSwHK2EitcOeYMb5yO24gHzrwfjfca/mMbtzzv9dKZwoE?=
 =?us-ascii?Q?3+MUjn02/ElrRGSUioSfgnnx7dAX3V8MMC9My2+ASKseWDaFv7iWgd+hUMsx?=
 =?us-ascii?Q?3bBAAwpwHQii6SFKQRXWh+fF4j65sL7b+DX1PH+AJ/peUxL82SGBS71pXYgK?=
 =?us-ascii?Q?Hq+h7LUuGiW/Lb+jOSakMEwISztH0OseaI59IRAe42HAdahOxARYrkiDRzhK?=
 =?us-ascii?Q?CCheikiVfddKPongia17jciuDfgkHZgqnqw2k2RTbtnTPIUFM896WLvJF7HP?=
 =?us-ascii?Q?u4Z9J5sHpCmuJVEF0DdXL/DiAPFTa5HPS0j+pI/gnc+5o3AWtgn7HFa7lyNu?=
 =?us-ascii?Q?pFz3UMSMu+gNyCT6WaTWOjT5Hit3VrnXe4MuUmB8Zi4bDDHawTdLiqKcJFBI?=
 =?us-ascii?Q?nVmGoDgpF4Fwk0Xduo329s3nYSgiRuqSDkvZKNb478+cLq30j7MesC/gGwYr?=
 =?us-ascii?Q?bePw2AooHlretUEOFIY2C45Ena9/hOCS7qg2X+T2rGN/LwgI74CbWAJf57Rb?=
 =?us-ascii?Q?beNO3nVkLrpf3UXI0dhFDbiKBSxlhVaVv9f0l9zPMZ1wDyIpzsX8UV5/rrhC?=
 =?us-ascii?Q?v+cste7UrtkTP/f8QHW5b5msI6PiUQzBxZ+Wa7kCm6y4v8TCy4XSaK764KwI?=
 =?us-ascii?Q?r3UgZT9OGnv3x5TU/XFB+9LfBQtrVjg9I/8bAeNcZfbPaJDdj/D2cMJvRzaG?=
 =?us-ascii?Q?YuBW+VGI7dBNHBvXn5XWCKKGN13at/OsMlrc3GsNCSKPNcfzi28jv8LERXhF?=
 =?us-ascii?Q?RsMqqn/wWWxCodtj5LmX2IR6iaSAtN1ZKYnmkPBJRB6Jfjn/27guFU74+eK0?=
 =?us-ascii?Q?QLPLhVin1UhpFWeQOLRG5Zrcx5FlAcawxPwTNpRH5ay3jljnvVFLO0Qq31ML?=
 =?us-ascii?Q?NNoFP9Dz4HEw/E/d0b8/J8Z90Y95dqEde7SGw6Okeic2TyaxvxFnuqLId4DG?=
 =?us-ascii?Q?gS3o9seYBnR1/6GAhzeX6k2M?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(376011)(1800799021);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?PWOAsmhfu2eJuK5bxvNQvrgTLL/dF9GSvpBIJ6Lk0JmlCgFb6ttOvYODFAzW?=
 =?us-ascii?Q?44iw1sQQ/KmcJt6wrQYOqdQ9Ehs6T88qTk45GeNfF71GPyTqWbzUkpzveQL9?=
 =?us-ascii?Q?tVYOKCmvivf9FzBFe5oQYLaMwcd+fQVyslgE7JXb13/IvKCBZi9xQYywiHIR?=
 =?us-ascii?Q?b8FI7k0x7ChSMJ4bWEDsdRJfnd0xqN8R8r6j4w/1eGn9uml1GIENZVW5Kmke?=
 =?us-ascii?Q?3sDHJIeYIXiBiggqbJplgiQ2OZdrqnR9Z0K4x82DY64RCD+ltdphFp//SUNl?=
 =?us-ascii?Q?tqA2/0XNSdabL5fQ5NQRagyTKudB0KOR2doGJ1bBfjtZrZ2z+71i7oHeZH6w?=
 =?us-ascii?Q?Bguy7OhyrcgZ9UeIBbGQzwfarm/6cqhmMjPa5Q50BnjTt/HgpQyGm/z8D91t?=
 =?us-ascii?Q?1Vbf49pdDFYSmNQByXWhUCLrCD3/2+rqYTjVBmFwM0yBKvn+CfyDjjgDXvsP?=
 =?us-ascii?Q?Sjd3sHPiSWsjrv/fp42SGkC3aZNcvqMqHfEmGwywERbRWFxpQbJjuk9VkpyC?=
 =?us-ascii?Q?Y1YL7W+M7VfmZJcO+tetx26UL9otV8rDPNfKXzS5WBgnhkKslqm1dZhxLr+q?=
 =?us-ascii?Q?rZiJ7gN3pFVkzkCMEsmeHUpaCPrZVdjpz69OaC3T0fdt6f4JoEinwDf43TpH?=
 =?us-ascii?Q?rwLQxPqQZoC8DjU9p6yy25bVz2wcIupxqGYE37qb0GUAC1dIgcGxCsS3Jo2G?=
 =?us-ascii?Q?JallRv7ZwSGHsOuqU8KVDIXnD1w1/8BeqQkXfDCJ9tU7TrjmjO+7PoGL+old?=
 =?us-ascii?Q?DAv+kaOyX+rwkwFbKMTYazfBnyds2BN43/kCpg6RedG+FTli/NzwFyNuLlIL?=
 =?us-ascii?Q?Qh3snOym5xfr5knDCRXU0HzTJ+PTR/GQ9vMvf+pV2UELxc6JvNHUDOLoKc73?=
 =?us-ascii?Q?Gf8Z1AzsddbCzyjgW3mtfT3FzAsSAxbLiGcY806PSA1PdjUBF5yxxmsy2DAo?=
 =?us-ascii?Q?b69U32Iejym6xbL27Hn2T/KfPrOnGLEkyBzAmoIC9jeJ9OGFwGwnk5Llyv3U?=
 =?us-ascii?Q?Ek2ARjobF5hUJE3erBSDUc8nDwbCWvU14mGe9PN5w//O0O0fAXoVt7ZDgmXk?=
 =?us-ascii?Q?3fU0mgHuSKUQ2ggOxZl/pdYow0RpfYmHLz9xjqBTuhVT5au2PjXdzOf2aUXb?=
 =?us-ascii?Q?AyY/LeMetRsPqUdj1qxQkcZWyNtqSfdjn3RRinzjvaxGfADprZ+NFJ5BOAei?=
 =?us-ascii?Q?bZjsrVkTdHQpUSYA/QPc+mOSk0qilChqkK2vojKaPkazHhS9YBy8fzmgGmd9?=
 =?us-ascii?Q?0trWMeYUJUTKoLVqPGbjlY3J6aAwqjmqTv68ZIKDjb681xI6pwGZH1U44NPg?=
 =?us-ascii?Q?brNmxH2kOinEfiqr8cBSZVoMjkqdnxN8FIxRFuektwgxrH9u85sRYhBDKh64?=
 =?us-ascii?Q?yCPlfltBxrNydpoyjBtKM7pFU3PadD/qsGNQnTUkdL0K+n/ItkUE7NCgapcx?=
 =?us-ascii?Q?wgPD+3402rIsRTuG7kGOqgYf6KtbXwLQyOsSzmU70KQeOKpDSRrlg1n82Esz?=
 =?us-ascii?Q?xooPOvwC8UpoTojSXllOJ/po/VuQF/oluceSrLgGSc8wWVZnX0lQkU7YCTUx?=
 =?us-ascii?Q?iD0k+bVppZm/OAAlVgAqJyMejTxt0+qlZK1Z841S?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	1rsM7PxUiIZCjmTx7u+67E04o9dRDNO8ZJCWChEcumUYEOBo58JA6Zdz3fNEYiibvnTVBff8134F/2fRBt6XxyOiVEz4K2HxpUr+qhmZOL1092Mgmjy5A9g2nyHp97LOa2C/lKDhM6N82AGV0UTGYdrEQx/H/0xgMQBSPB9IUZAMwObGScCfJ2bcBfTSXjk5G+ySQfJWr2Jo2gkoBMNs5+V76qFrQ18ZSJGvnZTrQm2ijYZ9Eq6uAHg89oox2qEYGME5XIX076zqIYXCwdrBI3dEOg0I8TsHfGT8W+AI+r7XCvRW2jIfIkdPMfIEVrdCsmiztyOmpJEhRX+Nfmk7kpfqkPFYWl/YRaaoounI8b0Bk9JJOJg7oOGfPlL92Q0VHg2oVwbIzQhFp7b+PBCUyzxhl0RK8lkv7Ry3VBa+GhyNMQTLCHF6G60XbAkYwKpZX37SH9tZ+KS6JrNn7FfBPHquH1lShIgwH8jAXSj1mZlOeAwecGiuiGisdJ0aU1kRaSyHswMzWqanE3yq9SQdHZYXQD9pUhVMRHBu8ZpvbzthMgF5I8f2kLXLjfRHdrIbDIusuoZwu92OFk0yFFAwLwgZyM/jYSHc3OUKT7juLpA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2a5d247-c78a-46ea-b7db-08dc913036ff
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2024 13:52:24.8906
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bvt2r7YaIBsCnIwXkEzYZiVi2qxnEMX9QNQN6pj5GPhsuP90hbcUMIT8AfIJDaXx8LCmVDKiMXonLUgjNWoZ+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7445
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-20_07,2024-06-20_04,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 spamscore=0
 mlxlogscore=999 mlxscore=0 phishscore=0 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2406200099
X-Proofpoint-GUID: D6cwIYGnnQiy50gNowJl5MK6yw9iv8uZ
X-Proofpoint-ORIG-GUID: D6cwIYGnnQiy50gNowJl5MK6yw9iv8uZ

On Wed, Jun 19, 2024 at 04:40:31PM -0400, Mike Snitzer wrote:
> This document gives an overview of the LOCALIO auxiliary RPC protocol
> added to the Linux NFS client and server (both v3 and v4) to allow a
> client and server to reliably handshake to determine if they are on the
> same host.  The LOCALIO auxiliary protocol's implementation, which uses
> the same connection as NFS traffic, follows the pattern established by
> the NFS ACL protocol extension.
> 
> The robust handshake between local client and server is just the
> beginning, the ultimate usecase this locality makes possible is the
> client is able to issue reads, writes and commits directly to the server
> without having to go over the network.  This is particularly useful for
> container usecases (e.g. kubernetes) where it is possible to run an IO
> job local to the server.
> 
> Signed-off-by: Mike Snitzer <snitzer@kernel.org>
> ---
>  Documentation/filesystems/nfs/localio.rst | 148 ++++++++++++++++++++++
>  include/linux/nfslocalio.h                |   2 +
>  2 files changed, 150 insertions(+)
>  create mode 100644 Documentation/filesystems/nfs/localio.rst
> 
> diff --git a/Documentation/filesystems/nfs/localio.rst b/Documentation/filesystems/nfs/localio.rst
> new file mode 100644
> index 000000000000..a43c3dab2cab
> --- /dev/null
> +++ b/Documentation/filesystems/nfs/localio.rst
> @@ -0,0 +1,148 @@
> +===========
> +NFS localio
> +===========
> +
> +This document gives an overview of the LOCALIO auxiliary RPC protocol
> +added to the Linux NFS client and server (both v3 and v4) to allow a
> +client and server to reliably handshake to determine if they are on the
> +same host.  The LOCALIO auxiliary protocol's implementation, which uses
> +the same connection as NFS traffic, follows the pattern established by
> +the NFS ACL protocol extension.
> +
> +The LOCALIO auxiliary protocol is needed to allow robust discovery of
> +clients local to their servers.  Prior to this LOCALIO protocol a
> +fragile sockaddr network address based match against all local network
> +interfaces was attempted.  But unlike the LOCALIO protocol, the
> +sockaddr-based matching didn't handle use of iptables or containers.
> +
> +The robust handshake between local client and server is just the
> +beginning, the ultimate usecase this locality makes possible is the
> +client is able to issue reads, writes and commits directly to the server
> +without having to go over the network.  This is particularly useful for
> +container usecases (e.g. kubernetes) where it is possible to run an IO
> +job local to the server.
> +
> +The performance advantage realized from localio's ability to bypass
> +using XDR and RPC for reads, writes and commits can be extreme, e.g.:
> +fio for 20 secs with 24 libaio threads, 64k directio reads, qd of 8,
> +-  With localio:
> +  read: IOPS=691k, BW=42.2GiB/s (45.3GB/s)(843GiB/20002msec)
> +-  Without localio:
> +  read: IOPS=15.7k, BW=984MiB/s (1032MB/s)(19.2GiB/20013msec)
> +
> +RPC
> +---
> +
> +The LOCALIO auxiliary RPC protocol consists of a single "GETUUID" RPC
> +method that allows the Linux nfs client to retrieve a Linux nfs server's
> +uuid.  This protocol isn't part of an IETF standard, nor does it need to
> +be considering it is Linux-to-Linux auxiliary RPC protocol that amounts
> +to an implementation detail.
> +
> +The GETUUID method encodes the server's uuid_t in terms of the fixed
> +UUID_SIZE (16 bytes).  The fixed size opaque encode and decode XDR
> +methods are used instead of the less efficient variable sized methods.
> +
> +The RPC program number for the NFS_LOCALIO_PROGRAM is currently defined
> +as 0x20000002 (but a request for a unique RPC program number assignment
> +has been submitted to IANA.org).
> +
> +The following approximately describes the LOCALIO in a pseudo rpcgen .x
> +syntax:
> +
> +#define UUID_SIZE 16
> +typedef u8 uuid_t<UUID_SIZE>;
> +
> +program NFS_LOCALIO_PROGRAM {
> +     version NULLVERS {
> +        void NULL(void) = 0;
> +	} = 1;
> +     version GETUUIDVERS {
> +        uuid_t GETUUID(void) = 1;
> +	} = 1;
> +} = 0x20000002;
> +
> +The above is the skeleton for the LOCALIO protocol, it doesn't account
> +for NFS v3 and v4 RPC boilerplate (which also marshalls RPC status) that
> +is used to implement GETUUID.
> +
> +Here are the respective XDR results for nfsd and nfs:

Hi Mike!

A protocol spec describes the on-the-wire data formats, not the
in-memory structure layouts. The below C structures are not
relevant to this specification. This should be all you need here,
if I understand your protocol correctly:

/* raw RFC 9562 UUID */
#define UUID_SIZE 16
typedef u8 uuid_t<UUID_SIZE>;

union GETUUID1res switch (uint32 status) {
case 0:
    uuid_t  uuid;
default:
    void;
};

program NFS_LOCALIO_PROGRAM {
    version LOCALIO_V1 {
        void
            NULL(void) = 0;

        GETUUID1res
            GETUUID(void) = 1;
    } = 1;
} = 0x20000002;

Then you need to discuss transport considerations:

- Whether this protocol is registered with the server's rpcbind
  service,
- Which TCP/UDP port number does it use? Assuming 2049, and that
  it will appear on the same transport connection as NFS traffic
  (just like NFACL).

Should it be supported on port 20049 with RDMA as well?


> +
> +From fs/nfsd/xdr.h
> +
> +struct nfsd_getuuidres {
> +	__be32			status;
> +	uuid_t			uuid;
> +};
> +
> +From include/linux/nfs_xdr.h
> +
> +struct nfs_getuuidres {
> +	__u8 *			uuid;
> +};
> +
> +The client ultimately decodes this XDR using:
> +xdr_stream_decode_opaque_fixed(xdr, result->uuid, UUID_SIZE);
> +
> +NFS Common and Server
> +---------------------
> +
> +First use is in nfsd, to add access to a global nfsd_uuids list in
> +nfs_common that is used to register and then identify local nfsd
> +instances.
> +
> +nfsd_uuids is protected by the nfsd_mutex or RCU read lock and is
> +composed of nfsd_uuid_t instances that are managed as nfsd creates them
> +(per network namespace).
> +
> +nfsd_uuid_is_local() and nfsd_uuid_lookup() are used to search all local
> +nfsd for the client specified nfsd uuid.
> +
> +The nfsd_uuids list is the basis for localio enablement, as such it has
> +members that point to nfsd memory for direct use by the client
> +(e.g. 'net' is the server's network namespace, through it the client can
> +access nn->nfsd_serv with proper rcu read access).  It is this client
> +and server synchronization that enables advanced usage and lifetime of
> +objects to span from the host kernel's nfsd to per-container knfsd
> +instances that are connected to nfs client's running on the same local
> +host.
> +
> +NFS Client
> +----------
> +
> +fs/nfs/localio.c:nfs_local_probe() will retrieve a server's uuid via
> +LOCALIO protocol and check if the server with that uuid is known to be
> +local.  This ensures client and server 1: support localio 2: are local
> +to each other.
> +
> +See fs/nfs/localio.c:nfs_local_open_fh() and
> +fs/nfsd/localio.c:nfsd_open_local_fh() for the interface that makes
> +focused use of nfsd_uuid_t struct to allow a client local to a server to
> +open a file pointer without needing to go over the network.
> +
> +The client's fs/nfs/localio.c:nfs_local_open_fh() will call into the
> +server's fs/nfsd/localio.c:nfsd_open_local_fh() and carefully access
> +both the nfsd network namespace and the associated nn->nfsd_serv in
> +terms of RCU.  If nfsd_open_local_fh() finds that client no longer sees
> +valid nfsd objects (be it struct net or nn->nfsd_serv) it return ENXIO
> +to nfs_local_open_fh() and the client will try to reestablish the
> +LOCALIO resources needed by calling nfs_local_probe() again.  This
> +recovery is needed if/when an nfsd instance running in a container were
> +to reboot while a localio client is connected to it.
> +
> +Testing
> +-------
> +
> +The LOCALIO auxiliary protocol and associated NFS localio read, right
> +and commit access have proven stable against various test scenarios but
> +these have not yet been formalized in any testsuite:

Is there anywhere that describes what is needed to set up clients
and a server to do local I/O? Then running the usual suite of NFS
tests on that set up and comparing the nfsstat output on the local
and remote clients should be a basic "smoke test" kind of thing
that maintainers can use as a check-in test.


> +
> +-  Client and server both on localhost (for both v3 and v4.2).
> +
> +-  Various permutations of client and server support enablement for
> +   both local and remote client and server.  Testing against NFS storage
> +   products that don't support the LOCALIO protocol was also performed.
> +
> +-  Client on host, server within a container (for both v3 and v4.2)
> +   The container testing was in terms of podman managed containers and
> +   includes container stop/restart scenario.
> diff --git a/include/linux/nfslocalio.h b/include/linux/nfslocalio.h
> index c9592ad0afe2..a9722e18b527 100644
> --- a/include/linux/nfslocalio.h
> +++ b/include/linux/nfslocalio.h
> @@ -20,6 +20,8 @@ extern struct list_head nfsd_uuids;
>   * Each nfsd instance has an nfsd_uuid_t that is accessible through the
>   * global nfsd_uuids list. Useful to allow a client to negotiate if localio
>   * possible with its server.
> + *
> + * See Documentation/filesystems/nfs/localio.rst for more detail.
>   */
>  typedef struct {
>  	uuid_t uuid;
> -- 
> 2.44.0
> 

-- 
Chuck Lever

