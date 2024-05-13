Return-Path: <linux-nfs+bounces-3249-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DA148C41F3
	for <lists+linux-nfs@lfdr.de>; Mon, 13 May 2024 15:31:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DAEF1F23A41
	for <lists+linux-nfs@lfdr.de>; Mon, 13 May 2024 13:31:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A24711474BB;
	Mon, 13 May 2024 13:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fXePPVbt";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="L24j5c5n"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B4C5152DF7
	for <linux-nfs@vger.kernel.org>; Mon, 13 May 2024 13:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715607070; cv=fail; b=rVB0Hcj8Gk6Nw/kfjxY3lOH59fe14Kvi/F66qLQ3JJmUDfyg6uEnXk0i6FDewmoKitj7K6Fy+oMEstZV5n58y7IGcdPt59Ft1G2dHaepPy/E/IekXgfFidZOPQZ9og12TCygCVxqZKIXpWACuwViTbJoDbp3bD2W4C4Idf6Di7w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715607070; c=relaxed/simple;
	bh=xkhpbQCV6//uLyEcPsxAZslZyFnVPAA5f34L0KQgky8=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=IfP8hUHaqNfooUYy2AdHe/ebJxNzAm6mcf5BgPR2r+BzcJbrqAQRMtCGyX1ab8aEV04VUPm2B0LD9Hn2tuYkLM4gXBRoPZDKArUpk3kGjXcdvPjvMBMFAIBgUs8/bjbniqoQZSegU0HIRacT6spu+Npz63FfVg0/U1rRY+Yj+SE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=fXePPVbt; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=L24j5c5n; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44DD9MMF023357
	for <linux-nfs@vger.kernel.org>; Mon, 13 May 2024 13:31:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : content-type : content-id : content-transfer-encoding
 : mime-version; s=corp-2023-11-20;
 bh=xkhpbQCV6//uLyEcPsxAZslZyFnVPAA5f34L0KQgky8=;
 b=fXePPVbtGQ5+a2ytNlX6GeKAGCqkDQK6Mauh06bewqAMlRLMKZwTLBZfB/UzIYINjGXd
 M3Z4h/UO/L6RW0OY5kB+UQnD4nD1ajXJZhw2O+jmFkW8ASRZUcyy152LM/bJAYHquyWe
 25tSW+4xOHWugL4olsWDUZHB5h67gKqZDrtTK8QMDS0Au633uT5aDNUoDLx+RfW7vasd
 uKdRL8uha+uLOSIQpvlAbMGhv+SldGjKYM9sTyb9OZgVcPMxAQR9U4yYqRMryhvdMHVO
 A1Zq72jyBUhnAE/fLGK6qCjQQCDMz8sD+yBtmbPRaF5Cgc7WwGRzsoYL8f7X4ETJ4l8W pg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3y3ce28y8h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-nfs@vger.kernel.org>; Mon, 13 May 2024 13:31:06 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44DDUsLL018059
	for <linux-nfs@vger.kernel.org>; Mon, 13 May 2024 13:31:06 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3y1y4c2e6u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-nfs@vger.kernel.org>; Mon, 13 May 2024 13:31:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QtCyPfb891EfATZI1/Y7TfLMuemXhqT5FucQV+yUxpOlmo5SmHdSNp2PmEDQtdyo4dREiFena/bLt+Y4wYry9rN+e9CLspzWUTbh0SYXzW4igic+mOrHbNHc1tuUxI1cB6zRktvqJ2EXZXHRy8aXBHrzhn2gqs/gsrxZETU684bZBRZwbW0dWzqkSA59X3lTtGb70KMlim3j0rDTRcbmEaejMZnuENgrYZ2Q/xPVvyv0jTJ4rgxJ358JECpTeKnTCfPZ2OVcnaQoMwuy4DcQQjLP7j14HIKOB4IzPOa71mGC2Dq+6AoudPWbQNK50ECZ8j2QW0c4GD57p08QffdT7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xkhpbQCV6//uLyEcPsxAZslZyFnVPAA5f34L0KQgky8=;
 b=hPZ4xtV3ji4yMeMlC3IPE6ghEfRjK6jkGIZrHXMvxtuaotmy2dA2ERtRM4uxJuS8OCX1EaxA2YiZutH0gMUi/wZJ755ePA7DJcQxxJ0MhsZIJ7J156tvLav0SvQ27j8G0Qhu9w6fB4Fm5B4OWPt+/SRG1kRtKU5s9n7J27VILGeKvzqJ7Ku2OuX/GbM3WApqMIPH8n/71l+NE44NzyFQs8f7V3jM6W+FbSvGM87s5H+a96ZMdppOeu/mRIT92mkehZHMfw2Kj2nS+76MslM3N9/o/7gU2X3u0sitt6HmRnXpgrRBew4DigOruLsuw060nLDQ0k1Kn1woQNm0iYjPtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xkhpbQCV6//uLyEcPsxAZslZyFnVPAA5f34L0KQgky8=;
 b=L24j5c5nG3NeUEtfA8ONEKFErB2zt0urWy5DYYiZKL96o0suQ1p2P1KuFNzYxocuT4ZVH9ekzSAK3EZ+XAlhoOcJuUFyxWACILEyhligxEGsmH43weyy9KaCin8WS/XBQ25xdMUwIApIrS5XJvpcKgske25VmyLrjbN8gNVk8a4=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SA1PR10MB7585.namprd10.prod.outlook.com (2603:10b6:806:379::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Mon, 13 May
 2024 13:31:03 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.7544.052; Mon, 13 May 2024
 13:31:03 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: long-term stable backports of NFSD patches
Thread-Topic: long-term stable backports of NFSD patches
Thread-Index: AQHapTnNE7LzDVg7pk6Dh4KUO/Emig==
Date: Mon, 13 May 2024 13:31:03 +0000
Message-ID: <363B2539-04EE-4839-AE37-90152FF0D081@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.500.171.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|SA1PR10MB7585:EE_
x-ms-office365-filtering-correlation-id: d8a2dfa3-e5c1-4849-7c70-08dc7350efd5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|366007|376005|38070700009;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?NSItii8FL8lp/0oL5reRBc7cK9TVkf9m86D02GWqqLtNN4eCDrKk2vX1lObn?=
 =?us-ascii?Q?OdoZUtBOUo+4d20Qc6j/dWZf7W9jvlG5tYLttlraFZ4sFa0voMFGFj71P3ts?=
 =?us-ascii?Q?TSv3eG/IxcJxmPsZZOM3A2gJis2xRP9FBjKMXpBL5l9yQXjgDSI+QAD6fbGV?=
 =?us-ascii?Q?M2hqdGMo+bmyYAmzklHcIa8yeEUt7Iw0tUTm0KdmOt/kNM2sQ0HvpkbGPWIo?=
 =?us-ascii?Q?OSBnw61qimHQHzsq19pgw1FbaidMulNptrCK/UFjCNje4zP94C5ph70YgHyi?=
 =?us-ascii?Q?MnlCqmDr0pqQjOcGCrgwcmPSHLLyNJ87BzD7548QLGUNYun2SK6IJa7uzUYi?=
 =?us-ascii?Q?DAfnDr+rAWjHdiAy3gGXbdOmwD5vQVZg0qj4IbLvZyZs1cOeCg89eerQr7MU?=
 =?us-ascii?Q?OfMPsEzlYMDkssh7J59YkrbXYVxWMYnGRJ7/6QJWLX/RMYvj3XwE0HDtTefT?=
 =?us-ascii?Q?jDoB+gi9QdDT89R+wUonIXuTqKJ9PIneEeja7/R4DShe6Oz7R8q9Qb7htH4x?=
 =?us-ascii?Q?9Zw9ks7PFE1h2/yp7mB7eOkgPXl/r31QR1KpGDXab7sawrnjQXTTkAYrFdvs?=
 =?us-ascii?Q?97lRjjtVvodJWRYFoAxMnPcHOJujhmvwNSKcDKGoMMg+K1mRQc/Jny8cPhuw?=
 =?us-ascii?Q?agd8ukJF4FrS2Sq5yFrJbfbaubEtQHs6BLn/i5+bmsKsFnKBWaA9fkDkZMGm?=
 =?us-ascii?Q?n/wG8kEOf/E9q70U3HmYyvOVzkYXMp8IIPv5QALfKlvnTZA8g3NalxFk0sXu?=
 =?us-ascii?Q?dku2pOc2hBFFnAEhowB3LcC1FeVL8+GatqVP67Pp542YrJVsOxgBHcQnOc4U?=
 =?us-ascii?Q?GWpdIdbHcYtGT2NwcKcUGqsepXhhMNeA+cpnWz3ziJ8AFeeitjZXWkdfiqZe?=
 =?us-ascii?Q?GHHi4aQWYDdVFvN9o5I8y3Fy8c3Wh5BuHmOVLGaXbL02qJtRCbROwknX3XwM?=
 =?us-ascii?Q?LWVNQMrCyDar7GE2zwLXtMicrNGIJmRP0TM3lXZ/1XQPv0CZmWPfECPNq97c?=
 =?us-ascii?Q?EgQHR39nXMfjWWAVbAB5r0PBBv9u4SpvHI27huq3qxIGPHDRcZn1kCOpiS13?=
 =?us-ascii?Q?qcvo1qdzpma21VYYIZE8YX+4Fw+OhLg72nsmSshyXuOjK+bThq8o2hzlidsu?=
 =?us-ascii?Q?bRmBy0LjdeuUuK50diKsD9ssjRp7li3TBm4j18F2Rl4Rtgv/pmfWOM1y1JBw?=
 =?us-ascii?Q?EW+/ciAZ7SUyZZhXRc90rL5IR8l4XSUhLdJU/aoEITyBH66lBWnNekzEx756?=
 =?us-ascii?Q?N9n4jixGK+0E0iugtfD6V+3q+dHdfavKkbjBpD8gRA=3D=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?Co87nt732aJ7AiCufO/FymP5i5+FuiCmfZejI/9yDx7ANc2VqQhgU5tYyJZH?=
 =?us-ascii?Q?VXwE8LLYWdYUETQq4xMOsxtajmZqlur0Bmo7W96LN4AMwwX/oJczPBEML1Xi?=
 =?us-ascii?Q?jVmHCSR56vEq2MswJOj/vaDobKwmPThX8z/byXdpmCxeEI2ODd66ktzXJPkp?=
 =?us-ascii?Q?1s6a5h7cYe0MuDAMMR8dM1S+YRpfwQFjzyoi1EfkPKA6SVBK7afdyFFQ2luL?=
 =?us-ascii?Q?KSTHWF7pdyubC480d20mukjKFx8guBaSdPlTBB5rywP5WSKRla+qydZqUX+N?=
 =?us-ascii?Q?vi/pRqr3fdw+8ojbZBjs0aP1P7GqK+sS1qVFFt35uLJweKyTDUesrJPq3d4j?=
 =?us-ascii?Q?CD8o6IsKiLeW1WKKxzCuEhvdhkJ3gq64PtZd1mBg0BLRBq/xnPtQXpbC60oc?=
 =?us-ascii?Q?znCJ3gJizkjbE2j8JybIjbX2IBYXBOXM8JKQabU6MSz94xkXACfCWFVvkxaA?=
 =?us-ascii?Q?CMH9pu8e1ybZwJ5uuYm9hwBM9GNVc1ATr9u9haLmXxmGZ+Dvgi0qs1GuBh3l?=
 =?us-ascii?Q?eLWAzQ+qN+mXd52o9A2n/omKLf2FOzicEE6qTnau912QhSFwsv0qQmdJcjVb?=
 =?us-ascii?Q?uhryvax7cBFlfp4O1oRox1vFhIfIFESdMt6Q21q73PgNLxSG4vPIFke4ENyR?=
 =?us-ascii?Q?Jl0SuQbzDS0QegUV5Jafv/1l+EhoD8QHQao9E+apqQHonjaUCmsDF9wtlIv/?=
 =?us-ascii?Q?Otz9QeqARs17SwPi+qQ5tcgoqAX24pIC3k1gkHZVk/xhUCk7WP/oWqhlOESa?=
 =?us-ascii?Q?KqhQnN+W4cc07QypxutIQw0kzIr1DIximfg++H/xxigzvyo453D/ukZfUVg+?=
 =?us-ascii?Q?ni7IRIFwhOkD0rdyxn+BChtiRpHUWXDF2kmxGpwwfU5JZx/KVrHljPYUFnwj?=
 =?us-ascii?Q?X32z+rG1zo1X7DTHYdE7CVlmNl+MBAQ16kDEAd9COJ6vgKINFUrGN4pxEWOy?=
 =?us-ascii?Q?s3qQPZg+ckaHDe7WsRT7dAGCzwcbGulL9miAnDlb16PUfJGZX3VIDg9UWgUJ?=
 =?us-ascii?Q?2LN+NZ4wKzchi9nldGnONbjbEzsV+3MNkQIHDgricQxRVmeMXlZmOltmF42b?=
 =?us-ascii?Q?VVDwRVJ73r+PbbRpu32xcjDLmazhc10AigS+eIxcKHS78S41UIjmHOoBX8x4?=
 =?us-ascii?Q?rZsS2MjCWw6avyC8MjrzNwY+CqjdRuzHVUkV8qjgVqps2BsUmZqp9X6nSi60?=
 =?us-ascii?Q?ut7UQdyfGRbjbGIYszolXCbsYwveKFNjvAG7vF1KySXVfL7FewrIftK381a/?=
 =?us-ascii?Q?tPaV/I/uMG7MlmGlhMtiK/ObkZ4JlUfW8Wt/tV+9vrUbis4GLOwJ9ex//qlX?=
 =?us-ascii?Q?l4Vt81lPXkILHm/NOqWQPf4Ffy2e6tzYxJ1ziid8SV9ClLxWu+CsApEGkT/d?=
 =?us-ascii?Q?a98iVDmW3aFzlVxVKpXBCKPQ7QDm3yknMYc4UcEaeR4RsNmAlKAOLEnH50RQ?=
 =?us-ascii?Q?JHYuxghUqLr0rimYTZyipVubUdKE9pk3tQIVUG1xUZBQy47wWTR5z/hmcMDc?=
 =?us-ascii?Q?NYCh+XnmrE7q75Oj1N4QZrj41xaEriV23kQ+elwMfiv6jTIkxc3QtUhpFD06?=
 =?us-ascii?Q?psgdCFTfoME2djGtl2PnVaGdoHtNXbaOy41oLd/NcdJEW1cf1CFUaRFiNwqA?=
 =?us-ascii?Q?Nw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <5F59C984CA72424A9E74163E476EE430@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	SSGaCgn9mvqyQZcBW7/qS9GS8/1fNvuHZNPxvJBFrJIDdmf3iwU5Ycj2294EQiy3+aIePkxOQtn7ks+QGyM0DKYGO4+ghbzPo69sZ8KCHQIO5/nYau+EKZ4EsOABubz+fnnJL5KPbmL4SBlJSEsmB+N+8q7qJhEYpMuaSod6QPzrZUJgiUNTpyFatMyq5il6+9Ru2/TXEseM5IetH2lVT1xOasAAAyg1xgpHt9DOd/qr/9cM2Fd+8RCyVSvMhWgEhdbA5L8FDRgqPhOBonUrArs4PCc46Es2X5EXz7WCX7YfnjpKvk1n3UybmTbYP8Iw4m7UZf3ZotCr7CYUi8XshJrFMuxqsVoMTKrD0QRYzsE0gDHuJ9jtSqf2s6GyGeBDYV9CkHXrHAR2HiBhtv+g8HvjtKgTO33OOaM0nej86d3p7dcdXGc+vuREQGOGnZD81FK2Rky0agjREhEO8Z2pQf71b/AEMoPnfi/xUbw6gwykPGTSgyW4B3nyl/cS+9PS8odA0BKKWrvFGoUjUFpfr5r6bkp8iQ0DzlXjCm73vfiYbrL88PPVb8hyfF0+Ab135cFkKLgo9YuNShnUeDq9RUFd2fO35KLYxizfU9lsz8o=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8a2dfa3-e5c1-4849-7c70-08dc7350efd5
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2024 13:31:03.7838
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HQxb4R9EnRaPamWxbLd0naNPxzI+PIL7YMdQFVr2HBTe/6x+t56ruz60dBURchGVuViPlKjMcnzn3iXgZFeW2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB7585
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-13_09,2024-05-10_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=927
 adultscore=0 mlxscore=0 spamscore=0 suspectscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405130086
X-Proofpoint-GUID: Ga5_hDVB2K_DTGyWw89SYfb9OW9syVKe
X-Proofpoint-ORIG-GUID: Ga5_hDVB2K_DTGyWw89SYfb9OW9syVKe

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


LTS v5.10.y

Testing has found two issues that were both due to patches I
applied that are not appropriate for this kernel. The patches have
been removed. You can find this series in the "nfsd-5.10.y" branch
in the above repo. Testing will continue this week.


--
Chuck Lever



