Return-Path: <linux-nfs+bounces-8154-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F1BB09D3EBE
	for <lists+linux-nfs@lfdr.de>; Wed, 20 Nov 2024 16:15:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B218D281AB1
	for <lists+linux-nfs@lfdr.de>; Wed, 20 Nov 2024 15:15:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 057301C9EC6;
	Wed, 20 Nov 2024 15:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gouyX0qE";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Vckla7mI"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B7811B533F;
	Wed, 20 Nov 2024 15:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732115244; cv=fail; b=Sbk/M03zUpFetDIAl9gZFaJBxWesFKrvjklqiTi0tjCyyC4QTzUOQLAjSsoiLM0oR+Ka7SAdlVw2glPXrSemkaELV5xDYl6Y/ehHCjMDZTdLWtvm1YNWD/sceD9iYbi0KAtcWfT9TcMQxWyCDTtVRewu6Rqb6hgrBN6Lc8MlpH8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732115244; c=relaxed/simple;
	bh=95TiY7didSoDmZQiA7xIGsczbw6XF26Kd8KQgcO4RPE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=W2uaTWrSpDQJAgYUjWvm8Vt9qy0kiidOgihfApc9Oc5fX37RXiRa0J+5J0XBCOMeT757Lkem+L8eZ2p25VLo2opaS9m16gBTFNko6AjdD2neVCOgBebGWcRJe7Q9eIIviXyiyDCrIxuFuTpsB0hdARcoET4JonGCH0ajmIzMRb0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=gouyX0qE; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Vckla7mI; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AKBMd93027256;
	Wed, 20 Nov 2024 15:07:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=V9Cilt5IpEFyNrun1J
	L/021+zDP0UpemHaCvW3PJkQQ=; b=gouyX0qE33W4EpzHQJC56GtvWBNABRfOOJ
	PNbpynpl89YOWm1powE7tXNUHWrU6AHj6usARAD7oE2pmgWlOzaiOuBxj95hwaPF
	7hKT6/m0k5ZuP1JPrCLkqYce4BlTy6kPszt+Zb0GH8rZnabe8bja4FfRVku6l9ag
	LJCFYUNa2FlgHQLhr9W35yaPGS9P+n/G2kDT30Cy/T/zNTzPWHCIKR49/HBee5ZQ
	EeW9xAucWhRV6Hk2wMbkALfHwMQlWOHAmER1pcSt08/UbrXsQvZl96qpp3p5AmeQ
	ZTo61xy48HsaDEIkEZcrEAYZTu78CPdhNm9s7B2v7JTfiOJXVd1w==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42xkebyndp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 20 Nov 2024 15:07:14 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4AKEr21f009039;
	Wed, 20 Nov 2024 15:07:13 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2046.outbound.protection.outlook.com [104.47.70.46])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42xhuae4s0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 20 Nov 2024 15:07:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pg33xj8XUYHcNggPH1h5nfiygY4DV392YOrokmAJrjCyyWFby4/Rcu13JImh3wWR0HS7DmieUhVmU4XiQnde0G4WcQmGhRSsGTXGrt++Z1zNyyMnBGAagY6BPEkqRXB1GqX7J6oFf0XUfzelThz4Ry7SdruLo/sYM7nmKmUKnaBad7gBGTFTWBYr9Ahnm2P7A6wbd7LFqYwmGs6WLVBtXtFUngl8rmfs2d+yob8Sbzdh1x1r1gFuKrA4PQcR6w15s5QQnrigGqVDxrAlry8yh6QjGf6qk1y/uHf3GpuaWGYNLGYwfluf3ZleaZyV5Ip+9GSDtt5UocPAWMaZqhYEOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V9Cilt5IpEFyNrun1JL/021+zDP0UpemHaCvW3PJkQQ=;
 b=DSf5FqqUpM2oK7pCTcPT/1PnH+VsQIC/pLR5Gwb4R7D0+LI7CKLg8JFGocUGErQnc/CCrNxjZinInwyNdJ1YHHzv+ChJVBtL0kWhGInKELTLf/ikqcSulUMxLJR8i/SCZM2yM0bMoZFLU9tex8Fr6NnQG661CO6pgXR81bAZp1nE9AvQpymD0iWC3ClqvLchnml30Y2HBS3m05v7GgFhDb/PSYA12TGgXehVNoR0sm+RWQ3cKXKHFWew4Sb8/C4ifc4hVp3pHSDsYS9JaD4DRoHUHZsvs5KIQZhjKEUWcXovFbFgINg36CSaVqG38sv2Hosq+j31+Rql6j1tcjnt1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V9Cilt5IpEFyNrun1JL/021+zDP0UpemHaCvW3PJkQQ=;
 b=Vckla7mI0x1zv2iN4G+6DKw34yt2/mXslDxKvdyyyCeEnX0Sid8w9hw2njjUQ6CHcBYTu4WuZPYUIjYrkzKzj89f0dY40nAs4dKEpy3th2f1GX5hgZ7VRV4YKfy/jxTVgouRI77B6XvRQSZoOfh56LirivksvM0UTErzJB9Xreg=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH7PR10MB6228.namprd10.prod.outlook.com (2603:10b6:510:213::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.22; Wed, 20 Nov
 2024 15:07:09 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.8158.023; Wed, 20 Nov 2024
 15:07:09 +0000
Date: Wed, 20 Nov 2024 10:07:06 -0500
From: Chuck Lever <chuck.lever@oracle.com>
To: Benjamin Coddington <bcodding@redhat.com>
Cc: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>,
        linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 1/2] nfs/blocklayout: Don't attempt unregister for
 invalid block device
Message-ID: <Zz37GmKULmPYUlee@tissot.1015granger.net>
References: <cover.1732111502.git.bcodding@redhat.com>
 <4e9690bed3d95d1c4cf2a7b1cc76f7cd1b333847.1732111502.git.bcodding@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4e9690bed3d95d1c4cf2a7b1cc76f7cd1b333847.1732111502.git.bcodding@redhat.com>
X-ClientProxiedBy: CH3P221CA0016.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:610:1e7::8) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|PH7PR10MB6228:EE_
X-MS-Office365-Filtering-Correlation-Id: d80c0412-f86c-432a-6b29-08dd097500fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZHGCIfDBsoqRKcnD8cdl1wpQfO3EWdpqovJNkbeADOxU7YjvQ39n+mDKw9BT?=
 =?us-ascii?Q?Tl/Hag9dcCMPwC7FTUoGEgk2ZarkgUNlIe3DQgFv36AdB317/L9k9JYFLD0E?=
 =?us-ascii?Q?ER84H4Uu2/8v6iij9Jh6jkphicTtK8WnIXO+JrOsG3EMvnoGeNcClW4hnscl?=
 =?us-ascii?Q?ftF8PUvSbOtAy9M6XraGO9YFU7QWcpq2P2akXZifpPC/5TWrWTSMJcSzRddf?=
 =?us-ascii?Q?Vo2ZbWLzkgwXBAyK/iaUecSsQJoktMO76KlWjTZIc144SltaErCcFI4/W6yI?=
 =?us-ascii?Q?giktMz7wL8b3+BNEpCYlcdBBL/U9AB5iC/IPoCayO/sAaMGAevlcT8lifGv5?=
 =?us-ascii?Q?LTOHFLeVzW9oDjuFrarcBGZMwf+2ei1GI8B3Ot5ksU73NhnFKAjiAUQ/eYpF?=
 =?us-ascii?Q?d1i+Yg0Jzmd1zbQ4JLJ25f1Wt7C3Nvmu5VU37I+g5l8taFwGAa/JYu6CZ2Xb?=
 =?us-ascii?Q?4wvSD8n/CSWrbr9Ds3KZ04z/vR9FWPM9nogK36suJCNOj1t6hRxZd9cxJirK?=
 =?us-ascii?Q?LaTbGjzgM5RixXbw4BiDt4S2BTv4y0MQ+aBQUpV2cipPQLEGd40Lm8J0fDRu?=
 =?us-ascii?Q?Vsq5YM8dVeLcarEM1lWvfhucW6GZbC6vcwodUn00BsmFWMs9LbjyIswDOY0y?=
 =?us-ascii?Q?5Y18nhLGdGHsazI0SkI/v3h4tnyOZK6eH52uw1ajIFW+2t9sK+6SJoP77q8/?=
 =?us-ascii?Q?jv20XlncSfrCkbA7zlYcJ5XQy33qPpZ6LYc1fDU5VI1eQnnNum/dAJObPZGu?=
 =?us-ascii?Q?hezoyzBoIHagYXRciM7b1WJV0aWNgF8Vk55NLFhusc+acRPg0sYxC4rUK6Uo?=
 =?us-ascii?Q?j32fhd8FU2Pmr4Yk2XEvRxm8ZlD3wceyLEwIlOaBW4hM0G2R+XZNVAUmU7dL?=
 =?us-ascii?Q?DWGpgt7QIiTQ3cv0Q87E3HtnOunp4DeNrzCnGw2vVktBiHYN9FApHsV7/Yk8?=
 =?us-ascii?Q?yJlbrBi0uJx8FpggemItSPmJLGQker09nVMjbIOz/KNR/F+B+CeHryCRQN+/?=
 =?us-ascii?Q?/Uq/zEwj20xflSsDsok0H48oFpIBcR5c8R4WXuWzRTr3xaTcpSa4cdXS8OT5?=
 =?us-ascii?Q?Hsh+y+yf12A3ocOJ8Ie4tp/pg0k8FXqu+FBIOouNgm3Em2N2HPsV4MZgkRDM?=
 =?us-ascii?Q?4YdvV2dISvLF6GGvKd0ThobvCONv2KIUe0jL7GoWV4EHiM9TM6+iQM0s2fk1?=
 =?us-ascii?Q?gjFsNWUcLvArO/KotY9cxquUz9+pYIIYhEGXprZDvGspSawGMjAsmtUSlrM6?=
 =?us-ascii?Q?ot7nfT7QFpNOWizFysg70lE/iHKG53N0FCIbcwYvsfVphcKfJahBqoKdQOiS?=
 =?us-ascii?Q?ZVvoIYEOsHCygizrAeTPOU0G?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?T2QcCWrhCz5VFNbLUdoA2mBUUui01UpBA9zDNnEW9LUBX9zy5USUeRvlUcgj?=
 =?us-ascii?Q?N5/8ENjIMV0C4HLtex5DPzQoCWHV1YE0OPZPeD0JUQ/4BKeDv7DItOOvm5jX?=
 =?us-ascii?Q?XFqQn28ca8GHhIDlGxhtIVVbLYTF3Gd+PjBaM+E0PfayeSrOI9StnjqKXkZP?=
 =?us-ascii?Q?dlPucAKGgHdgpwzqlw99Eyc6ORp0uE0vH9J0wg/9sDTv173uXpZFYmkS/ONb?=
 =?us-ascii?Q?kZ+u6E7Y2p+rTDx1RYmkMiDopi8K3hAkr0wZCVuu8RaqF290FD5Ens5lOE7G?=
 =?us-ascii?Q?sCbpZIWS+lXh29aLdXusJIFVytM1R3oI3tK8mgQUteeso8S8qgd4BAVlszDC?=
 =?us-ascii?Q?o3kOZRFvkKDDmBD18ftbq2aBoQ+1fD5J2yoJ1WdAxEqT6IqDNQXlAGcPk1Zh?=
 =?us-ascii?Q?ZYF9/GUxgtIXnD+DSE6qCM1PHx1Hgmw+soPds0dan5t7TcrkepQK0efhOXX4?=
 =?us-ascii?Q?TY+jTTI9bqdzeANdM4nx4QqboUKNEIfzVRm7qx3AXhcnX2ad029z8HoenyJ/?=
 =?us-ascii?Q?wtHJmhV8Iq88DFfmVinszj7bFXT5RdC/SW9Wp+XzSPkkUPNCQXua8lBnwAaf?=
 =?us-ascii?Q?JatxqjtbyiH/3BoAWnAQPM7/5//FPfAyXJN7XtstuoeJ+gDbwzvI5obVI52J?=
 =?us-ascii?Q?OLGFYS1ZkTeyIVfbxx20fc45rGalLwrYq1WrPp4SHQKg7CFQJK8tffwoC68K?=
 =?us-ascii?Q?uSIc3PYM+zeY7rFzX+I2ZFqIXsz/q5sXUPkb2mp/mGa/1Str308fSTq4TbOn?=
 =?us-ascii?Q?I/DwhcTxpcVW8sP3p8J+Sz4mTNZBcQJ0yq8ZXseH8oZWXsJrCrGxvRknpD3f?=
 =?us-ascii?Q?2msH/C7kAP7+a1cyCSr+Xu5vfplsHEK4SzfpzkVBNw8oU4m8F/BYCPXMhwsA?=
 =?us-ascii?Q?FoVdectVVBC8oBYOLgOppavPAmPp7AzQQfQ4imperlTbt5zx0V28qhQnte+J?=
 =?us-ascii?Q?/m/ZgYvl9tLs83e/jJ0YlevjzN5t5j3cpq/VYEzkuk7A+zx8RHGNRtGKXMny?=
 =?us-ascii?Q?0HJ7ZqQVtj21B4PKr5Mj8dgQ2g0+YVupxrX+16z/XS3Xb0M4XrUHijf/DaNQ?=
 =?us-ascii?Q?SLemF8CISZFLsfevn2CVcSoRLHsJAvhDxGvjDffFQWyFNaArKUOFnUKRMzy3?=
 =?us-ascii?Q?kmVOY8vW67947WIoU6PglQ55gpvd/NnVzA0yBJRP4IFKzK+xiGsVaelw+CxL?=
 =?us-ascii?Q?Z12VL2OFU3felbpLDNTFe6VDDTwoP0XQqhNLUV6cHJG9P8aS6EvvGp0jbeIZ?=
 =?us-ascii?Q?oPKj/LkEMplYPQHBafbwkKjPW0Vi4bIrC/vCN8xp+6MvlUh9c9jg7LW9NpAG?=
 =?us-ascii?Q?Xfht3R+7vrl9mmZvdtxu26D5riVjoD24YB2PfTcjnTgMTy5Hjy9T2ireOlcG?=
 =?us-ascii?Q?nwHtJR5bFF+1dRA71VcX1S2jJellxMz1c2Xl74x0lfH/latBrIDq95bkU0K0?=
 =?us-ascii?Q?ulk2dJkqFn+WOgSwNevp3/eS1tRMm2QpTtmpQ6hPenISkKZmfAnFch3XpbHK?=
 =?us-ascii?Q?0se8fSdf4wJ7c3MLb8FGHLzOJfo7PFByVfKDps6TpTCAxJfciocSQt2xM8Jk?=
 =?us-ascii?Q?BuxkQkWcnUxS+ZxBoj5cuKNOPud7LBSQ7iXfWjiDNqnzs0FnG6Vxqk0eO694?=
 =?us-ascii?Q?rg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Wv2K/GS+SEUCviMSIgzWpla3v19rMs5Pm9hhvJm9TNYRLUZbmBE0U8GvcPmRzI26hooTAWW+jving1iEjUcIDST0Ay97196zyCDOVUL0RARJ0RySsM89xDhnhArc/b5W8lZEXxGgE8uHHGL3nsK7MlYDY8KTQcu/lCvBzaQQ/Rq9piF3nK3Qs97iX9cGXQj3Uvi3vkkBdAXx3WP6c8+c/SKmFE75plj1RVLOIVgMTh4bF9r5m75Lg/Z6/SMRFoV9nHX7ew4b8fJySHnaXON/xrORf/bMauXG5RN4bG2yxT15T72exzkQEc3FaAdMK6lo/kx3ZcR0HFE7ydrsButDZtAJJsqLHkwXWx75rW2YFR7Kln3r4uhoa2TjXP5NWTHl4Kcu9H+KzoQThryOALkQzXFxNQX4m/TpkZLd+nVFwl2WI/h/hiOTL4k3NoCdaKmQklFEur3sVYUVPR7pM7F9Hjq/9y7hFrZvtg/8GsbxIZ7u97yk+7AfPYrYrv0rHM+Jzv7J+FYGoNBcn+P7+5nVWtIkDVkfv4AJxontrMwGG0Ek5zH46eAptkoc8FWSMdHY8mKZnIVq6by9rHVlDEp/Qr0Y/gisyTKqsfL6mkDBDMI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d80c0412-f86c-432a-6b29-08dd097500fa
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2024 15:07:08.9998
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qy8VPuZxW2K2w2E8S/zvJeV3UL+Gc5agJtFjJhx80ripivz7f/iMzBKWv/jTU2XCkUYGNtYDSfbzYt7tAzvN0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6228
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-20_12,2024-11-20_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 suspectscore=0 adultscore=0 bulkscore=0 mlxscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2411200101
X-Proofpoint-GUID: PikvhK3iN3eg7K_GpU3ETkTmVgMT1jHk
X-Proofpoint-ORIG-GUID: PikvhK3iN3eg7K_GpU3ETkTmVgMT1jHk

On Wed, Nov 20, 2024 at 09:09:34AM -0500, Benjamin Coddington wrote:
> Since commit d869da91cccb ("nfs/blocklayout: Fix premature PR key
> unregistration") an unmount of a pNFS SCSI layout-enabled NFS may
> dereference a NULL block_device in:
> 
>   bl_unregister_scsi+0x16/0xe0 [blocklayoutdriver]
>   bl_free_device+0x70/0x80 [blocklayoutdriver]
>   bl_free_deviceid_node+0x12/0x30 [blocklayoutdriver]
>   nfs4_put_deviceid_node+0x60/0xc0 [nfsv4]
>   nfs4_deviceid_purge_client+0x132/0x190 [nfsv4]
>   unset_pnfs_layoutdriver+0x59/0x60 [nfsv4]
>   nfs4_destroy_server+0x36/0x70 [nfsv4]
>   nfs_free_server+0x23/0xe0 [nfs]
>   deactivate_locked_super+0x30/0xb0
>   cleanup_mnt+0xba/0x150
>   task_work_run+0x59/0x90
>   syscall_exit_to_user_mode+0x217/0x220
>   do_syscall_64+0x8e/0x160
> 
> This happens because even though we were able to create the
> nfs4_deviceid_node, the lookup for the device was unable to attach the
> block device to the pnfs_block_dev.
> 
> If we never found a block device to register, we can avoid this case with
> the PNFS_BDEV_REGISTERED flag.  Move the deref behind the test for the
> flag.
> 
> Fixes: d869da91cccb ("nfs/blocklayout: Fix premature PR key unregistration")
> Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/nfs/blocklayout/dev.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/nfs/blocklayout/dev.c b/fs/nfs/blocklayout/dev.c
> index 6252f4447945..cab8809f0e0f 100644
> --- a/fs/nfs/blocklayout/dev.c
> +++ b/fs/nfs/blocklayout/dev.c
> @@ -20,9 +20,6 @@ static void bl_unregister_scsi(struct pnfs_block_dev *dev)
>  	const struct pr_ops *ops = bdev->bd_disk->fops->pr_ops;
>  	int status;
>  
> -	if (!test_and_clear_bit(PNFS_BDEV_REGISTERED, &dev->flags))
> -		return;
> -
>  	status = ops->pr_register(bdev, dev->pr_key, 0, false);
>  	if (status)
>  		trace_bl_pr_key_unreg_err(bdev, dev->pr_key, status);
> @@ -58,7 +55,8 @@ static void bl_unregister_dev(struct pnfs_block_dev *dev)
>  		return;
>  	}
>  
> -	if (dev->type == PNFS_BLOCK_VOLUME_SCSI)
> +	if (dev->type == PNFS_BLOCK_VOLUME_SCSI &&
> +		test_and_clear_bit(PNFS_BDEV_REGISTERED, &dev->flags))
>  		bl_unregister_scsi(dev);
>  }
>  
> -- 
> 2.47.0
> 

Reviewed-by: Chuck Lever <chuck.lever@oracle.com>

-- 
Chuck Lever

