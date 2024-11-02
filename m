Return-Path: <linux-nfs+bounces-7628-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A253F9BA138
	for <lists+linux-nfs@lfdr.de>; Sat,  2 Nov 2024 16:32:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33CA21F20FE5
	for <lists+linux-nfs@lfdr.de>; Sat,  2 Nov 2024 15:32:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08DB756446;
	Sat,  2 Nov 2024 15:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="je64s0QS";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="TqiRwD73"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9BE3174EDB
	for <linux-nfs@vger.kernel.org>; Sat,  2 Nov 2024 15:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730561550; cv=fail; b=ZJ5lMnWIWcsS5ujiduXvHhr8UALdWGjZWfzYyN/6jm8uec9XeSnWCKdUAPO8SPJKMeWwe4vp/47MA7vwmREIc4ZKQY84Ye6b9SBzXYMc4QtRhP2Nx3Bp9t7K4MKWGq62+DY5P/oN54/WRdZ6N0I3P77bR7y/TuJeOA9Q6etcaHk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730561550; c=relaxed/simple;
	bh=J/muqCF4F7TctXfxsv424v0fgB70NunJqgF6e2uVIts=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Hyl12a5IfYn5F/gCeTaesNuiUHZbl0JWt0HJeEkHDMReQ2A5wEt4JDSdSLzu48ssOn+Sy9GcetVeqd9BGltzHSbD679vx8h4inkSDAMHJ/BAj3bZhVLsUFXFlWrnNncaj0oluWN1GjYN667FA2eBV2UhWGRTh4OUWkVIPTx4EP4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=je64s0QS; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=TqiRwD73; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A25jvCM002336;
	Sat, 2 Nov 2024 15:32:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=corp-2023-11-20; bh=wQMOV
	uy97Wte2s67tbQRkaIQOeQsYB9ZqOJUzXkewdg=; b=je64s0QST8tBQgPDUEG2i
	TMcWzvNOq/GDqCXFm4th6XxTGRLKEUlClXC1y+BOsNgLDuB2k3FXxojHXyOdogWU
	4HESpQ3Mt/6cXMKDV1PaamtrTIMWbNN3ERwfQOG6EbV1oTHdYJpPHUAOkWsqTLwv
	Pff5E5VFkZESFoOP2B+X7CnOWucDA6GEc44H2AiWKu29e64he7hkmbMSQk19LnCP
	P5m4SMJa/bkSrYhvXa/Tn9arzBQTFiKwc3Pm8OoKrLZTqXmAb7xK4V4DSmUPMLeJ
	SzaIqq0bjMtADSGvI+RsT1dw5F0CkLHKIK1hvUxjhjyuKDIJgpzi96CnXpNHiSvr
	w==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42nanyrf97-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 02 Nov 2024 15:32:20 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4A2CRAsa009064;
	Sat, 2 Nov 2024 15:32:18 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42nahak7jx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 02 Nov 2024 15:32:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=enclG1VPr6GgL0EwDhmEbtlOJqOeWd9jaG8BvqUUv00BA8NP7T2w205obYVBL2/ilCu84XakLnIP9zlnxmE5bgQy4PYWxTkAjYLSE2d/DvqhMIiYIDGA7A8np8jq4L91cG/7/2GCtdBYjVzFj31Mw5o2EVr06GvuO0gFSme/SPYNTUdWjnWfd6VDw/dmsSDSRNcz3V4XBZRPXsz8oieEg+BymXJ27Nj8iRwCCn2cB5D+TR95vT1sLrq3B19cZPdfMhGiscwkfnHM1QWAnSmLq9E6nHeVivE4HrNZ3DEFR0NsOIPEmYIRlbuXjS0vOcnEaS3GVgEufrJreAhmiiWW7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wQMOVuy97Wte2s67tbQRkaIQOeQsYB9ZqOJUzXkewdg=;
 b=joWhYO/hgez06SY5gdMy8fhwOuAmv9FqIpzJxpchBUgROcDTa30ROn8K+QDsNDvnOW/8egOj5p0sjPNsvsoSun9FHXr30qH+46JhPzGFgHKQ42AYCbYrSFfeIaWCBghoZflQn5RzyKypeymzCrHsbbT7lNNsEuWG2aImU+OPbCDQEtRiPYOTCJIfx8/QVQd+MocNqB7Q+I69EgKmpybN/i4xX99v+ejB/BStiXq4v6ENps1vuTlfzgef4AnPQWCk2M3h29dSnpUfM8VchYrLuLUbntH32DMwj9r5LUcDkV7yOEMjo653ueMcp0CdriEFL22P6inIFYRxBA/oBTVUug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wQMOVuy97Wte2s67tbQRkaIQOeQsYB9ZqOJUzXkewdg=;
 b=TqiRwD73XJFoAlh9Eo3v15jv0awA1s4p5so8araoIQr7ST4JqRUnyY5PrQbBA5Nuw2HnzSPzfyWstp37wLdsUc56ic8JL4nBLXZMguUDiQppiQxHZzBtI5IF9HrGuAyXNmQS46uLXQmmMTIJP3tWD/bVSTblmwvvIsBq/ZsNVhI=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by MW4PR10MB6655.namprd10.prod.outlook.com (2603:10b6:303:22c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.18; Sat, 2 Nov
 2024 15:32:16 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.8114.028; Sat, 2 Nov 2024
 15:32:16 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Anna Schumaker <anna.schumaker@oracle.com>,
        Trond Myklebust
	<trondmy@hammerspace.com>
CC: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Soft lockup with fstests on NFSv3 and NFSv4.0
Thread-Topic: Soft lockup with fstests on NFSv3 and NFSv4.0
Thread-Index: AQHbLTxl3bBI7TBP4ESJCTJw2iuAfg==
Date: Sat, 2 Nov 2024 15:32:16 +0000
Message-ID: <9F6400FB-AF3C-4B56-B38F-E964B60B508D@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3776.700.51.11.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|MW4PR10MB6655:EE_
x-ms-office365-filtering-correlation-id: 8a0c6df9-5827-466c-d53c-08dcfb538818
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?RV7AE99nSfwA2YdhuqT/cqC1sp2KESJgKGDSCwCVugR3pbwfLBzm6hZPu4ts?=
 =?us-ascii?Q?f4Q/Z5zce0ewaaDTwo3dD7QW/P7olUMqZl2w+H2bthKlS2Ym+k8U7lf7aN6g?=
 =?us-ascii?Q?v4rCP/YF8A2Yla88CoRXYcqVkvBuR8ni6UZwIQHISQ2KKYjoWja5PnQJvEhq?=
 =?us-ascii?Q?BRnNWERIzPz9ise4KrpuGlwNPiVxUAA03/cRIF4U/9FRH6f41ex3vWcb5y0C?=
 =?us-ascii?Q?hHFEvSTxiEV6UfggR9jM/wBzb5Gm6S8/0hK+SP8qSCLHQJ2skJSF7CGdNxS/?=
 =?us-ascii?Q?htLnNlPaPozdtLi6WSajwuTd/5QqdYOxI+oAxaySXVViyTVGcUK+o+tscCoB?=
 =?us-ascii?Q?DsXzx653N52INco37RtSb+AlSmY9qfh3akDQDx4nHL7vQxuhWqYk36RvEfy5?=
 =?us-ascii?Q?Aerf0Td0NM3ilbqswtwXgXsxpRHBn9rwRAZf75p8xTmRG5qodt3X81zyj26r?=
 =?us-ascii?Q?u2EjbXpQ+nz8dGO90HORPS7lz/mtyxI3nE88l/XNtZnNx3+4RwmfX0a1T65Y?=
 =?us-ascii?Q?y6GY/zEgpeOuxZDQW4xUX72NSNTlMVUvSd84Mga9jDfRx0lmgjIzK6FzVwdg?=
 =?us-ascii?Q?QIkhB4z6KbunY3GPrjQ7VA88Cmr0z1sd/sd8sw67AdpTGsl3576xTagMv19z?=
 =?us-ascii?Q?rBcYsh5kh0bfp9dnxvX4W6JG709PW88nQE5/lBhsa1ANFFvbg+B73Jku25bj?=
 =?us-ascii?Q?jDpZhHdF3LXn5vBOzMBLwTH8fBIwOda5FKXFYc9RYAmy2UsbSW8zzK3aRqdh?=
 =?us-ascii?Q?7J8dBcPEFPvc4wDqYbk42sPBdHKZaX9WaHOCP0fzNbEDpCM3Gxz4/r0nenbi?=
 =?us-ascii?Q?NPpL8pToXvgTCfwe/xSrWk83ArWPXvTA3i3HIApS7rS9Fy26WszN1A+E4TkK?=
 =?us-ascii?Q?p8+Lkr7gLAHMpHIWljXXvteFsLT0xXWKFoz/cFDhXH89SDJcYvfuNSM07yF1?=
 =?us-ascii?Q?kWyi97iORl5sCOGAG1cG8gZ7MPAny+u+LcB8upNvXdDobWhjQ/DmwYizeWtJ?=
 =?us-ascii?Q?s7ViBq/zKNHqPD1loSb6y+ncd+FpMb215cS7O08fcmt1vStu71qvL3MM79FZ?=
 =?us-ascii?Q?aGKSncW2lhPdzIB2UzGHiMFcUtynS705rm/65Iin+rzfVFE9E7Rg5MRUzZsW?=
 =?us-ascii?Q?HoSJsAcrsWji2GCBx56OWQVECwPF/CNmjwJl7FEShA61hF6TyehpBZWjYIUe?=
 =?us-ascii?Q?f97A7ODWQw3xeJS3Tpz4lmI3cVy1FuYt8IdrA0txT03dNVlNsPG9UOYk4q9h?=
 =?us-ascii?Q?St7JseoHVa2Hs9JQpbN5H67vxW99eIR8+lzvGAbz5FBQqu0GKdc5EHiE6dd5?=
 =?us-ascii?Q?HilnjEOJmNT+WWaAC3sRF64hr9tihNphu/Bbn2byuFNQ+jr4Qe/wgB8/95gN?=
 =?us-ascii?Q?KTZn00M=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?EsLcJ7IRq3SFzFr+Xf09NLsCwTSmNGylCQbok7oSIE7RcSLKJCSDL5+FZ8OR?=
 =?us-ascii?Q?04kyoQL7gJex6Y/DVVHzjuxu/y1zJmi4EBJ0zEP/+1OKPjfCT3EtGPAPP95M?=
 =?us-ascii?Q?DGrtRb7h3RVOzW3ciu96vpyuD+dKNfYAeSBBogoxmrgDXUfmIVtJRUwrY3kU?=
 =?us-ascii?Q?MVRMZCNCgC9rz/fSN3a34PohrMI/P+a5FChjr02LcBQKSVSlVLSgQfUONw4N?=
 =?us-ascii?Q?cNxlGg4z3O4CKMD95Ckv+WuvRPgZeUe3c07NXnSR41yO+0tZLb5YYgvk6p4u?=
 =?us-ascii?Q?jHwGlZnqtnicY8HhaTcogbI+7P+7DpV7tdVq9v1qU37Ch0EWHXxvx8xnMBXn?=
 =?us-ascii?Q?VUZ8tqcE+YpOjSSqAOpjPT2Ua3m7tRc/9mMlwecH/EmHxLvJFHm6UyU7UBlx?=
 =?us-ascii?Q?LUTDcfX4SXpYqIMBs8wvd7KE93BuBt1/ulC2H2AlfrswywarmhSQ2hKG6/Wl?=
 =?us-ascii?Q?qHKXZXRkDddKgbJxilsbW3WqZ+BAvpNhy55WDtjUPWVtLD6b4grylEUncjMw?=
 =?us-ascii?Q?JH2KD7Fbr2yhr2d4gWTRZ3lkv1S9NqxkvHVElV2Wx7iKvF1+Nui988HnSVaN?=
 =?us-ascii?Q?jhnA4R4pXHMIY9bK5xPop8Z7FlOAxfKUE8+tg7n6kGI4doZyMOwoujrjjLVt?=
 =?us-ascii?Q?Pq084BJhjATBiIHtM25wKOxEomfDjtQ0bE9ADS4ep7yeTRxo6tjGFgr4u2WH?=
 =?us-ascii?Q?gZVe6wajmVfuynkkv8+tjCLGjCHuULDZi4wjThGbLIU/xH7EyfG8zU13aruP?=
 =?us-ascii?Q?0NhQWo95fJoCDBxvMOYRowTowIZFmlDFH4t5D7Y7MUZaOW/364eR22HtRLgp?=
 =?us-ascii?Q?5Bq6ngYzlcUjU9b2Qutqz/xIa39m2VP+w+piBigeaIv4zSOdKcFa8NbMGCVn?=
 =?us-ascii?Q?vij9fiT9O4wTAlfK8Bt9aiUMnUJZWszqPUHdm0NmC6/maSNCNfne+p7XoOaS?=
 =?us-ascii?Q?XfVtWILEADLtcr7/XEcI9ejPaiWkAyWYwCmsEFidadFNU0HovOMndq5u/m8p?=
 =?us-ascii?Q?o05D8ebPXAc5KdqW0+fMlKz1+okUvm3gJMM80LWLta7j1Xh38OxyFpWgTzdF?=
 =?us-ascii?Q?PGv5OWvVx0zmaOJYx2LYpOiGsFweuPDprgTB7lP5ujwqMvkIOfrm/zUyUqpX?=
 =?us-ascii?Q?gSx/qD38zGfY7ydsQTwQwoBc5qH1oDXet+fVE4J4/g2MyJI7g3OOypi//FLB?=
 =?us-ascii?Q?ncSQaCJXIMD68tB1cadkiNVwmhRj2ovghbUIN1PHpCd0jUvIctVNWzddNf2T?=
 =?us-ascii?Q?YbIFjuHsI2OKuZYZ6OA/6ckKs8u+yh908bTlVuEooOGDCcdd/NwDP0z9p5Zx?=
 =?us-ascii?Q?NklMjCVvgEXWqX5LRpyoVUOyteC5FEY7K34HwqfSSmDFo5910ZTDvLh9bWYI?=
 =?us-ascii?Q?OvYIFM2WXWj5T+z/YAnCfzDBEv1ZUaqmsSpyPximzRkxz8dPHEhcsO2cTPlX?=
 =?us-ascii?Q?c3vBQCQk0MLwXal/DC76r0tO5UaqvikEZELfZ711x7IbWfKxDEjTIf8vsKRv?=
 =?us-ascii?Q?QOvMC6Ak04+HbBn+/XrC6wF4ZZnd76ZCbzYstIrqY1xDTvcrsABy8uoZy2Cl?=
 =?us-ascii?Q?Cls+mmqOsF9fzFqbOmmcCcY6O3vkT1Kk9rsCZMd/mHpUoun5B54oj632ijYO?=
 =?us-ascii?Q?3g=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E0A8B23B5997194680B01A84BF781F34@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	UdCvDvAFqBuARnvS/FNcvXWHBJPiMCgHK5TtnclsTs2z77Y53gLxD3OFr8PzaUmxmRNm7XSUc/PGf3hpogjOrblalxrUW51UkzMaNGOH7TxXqwc+ZWZimulCa+4EWxlHLfxp5H7yAdlh6zWQi5TTAkJ8n73+K9vjVSnNWFReMM6sXur2iNXMu4F7eIbjA2CG/tYc88TWnnCtqexYL+PA6o0sYsFZy6qj7iKUygvfTZbOlWKmhI8LXb2J0ULQjTSfn3BwzQL3hKoXFWIgvZLLBjbfSCPfmTyRvOdKsrGPbWSIdRFmAW3vo0B8BH4zCJ/wfZgFQUoyHMF7Lh6oBNbbdzwj1Cn8QqF7yspCIRVe5nG78RewLdXSxBPOvDVav4tTPWWvygjgap6d0N9/wN6+dflOkQDhfqMC3LdcbIME6k3pSiq3TffhgbwC5yGh3WBZTM2bW1vFyScl0cKqM1doek/wKVauBH6A+dUastede2mmP4QcnooWXVxYy/EDGPozu+HhJPBeXskFPqiFjk2qxDfqlPqtcXlgxWJII0kUQva/HoyrcyUkUWVGu1xj9GQXtO5hrHl3NeYytT82pe1hNWONAq1v8Avpt75waPr1szM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a0c6df9-5827-466c-d53c-08dcfb538818
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2024 15:32:16.3742
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gMIG07+yWmlldQQImnaVt+gQtL3Kw/ZoSxXpeptbIEMWNwLcGAogwl+G4Kgf7rPBAdfBu8GSQo/OI/1P5a1quQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6655
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-02_13,2024-11-01_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 mlxlogscore=999 mlxscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2411020137
X-Proofpoint-ORIG-GUID: 3baUuvq6FzOgPGcUwAGDh2L5Dg6Bq0h6
X-Proofpoint-GUID: 3baUuvq6FzOgPGcUwAGDh2L5Dg6Bq0h6

Hi-

I've noticed that my nightly fstests runs have been hanging
for the past few days for the fs-current and fs-next and
linux-6.11.y kernels.

I checked in on one of the NFSv3 clients, and the console
had this, over and over (same with the NFSv4.0 client):


[23860.805728] watchdog: BUG: soft lockup - CPU#2 stuck for 17446s! [751:69=
1784]
[23860.806601] Modules linked in: nfsv3 nfs_acl nfs lockd grace nft_fib_ine=
t nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4 nf_rejec=
t_ipv6 nft_reject nft_ct nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 n=
f_defrag_ipv4 rfkill nf_tables nfnetlink siw intel_rapl_msr intel_rapl_comm=
on sunrpc ib_core kvm_intel iTCO_wdt intel_pmc_bxt iTCO_vendor_support snd_=
pcsp snd_pcm kvm snd_timer snd soundcore rapl i2c_i801 virtio_balloon lpc_i=
ch i2c_smbus virtio_net net_failover failover joydev loop fuse zram xfs crc=
t10dif_pclmul crc32_pclmul crc32c_intel polyval_clmulni polyval_generic gha=
sh_clmulni_intel virtio_console sha512_ssse3 virtio_blk serio_raw qemu_fw_c=
fg
[23860.812638] CPU: 2 UID: 0 PID: 691784 Comm: 751 Tainted: G             L=
     6.12.0-rc5-g8c4f6fa04f3d #1
[23860.813529] Tainted: [L]=3DSOFTLOCKUP
[23860.813926] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.1=
6.3-2.fc40 04/01/2014
[23860.814745] RIP: 0010:_raw_spin_lock+0x1b/0x30
[23860.815218] Code: 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e =
fa 0f 1f 44 00 00 65 ff 05 48 02 ee 61 31 c0 ba 01 00 00 00 f0 0f b1 17 <75=
> 05 c3 cc cc cc cc 89 c6 e8 77 04 00 00 90 c3 cc cc cc cc 90 90
[23860.817076] RSP: 0018:ff55e5e888aef550 EFLAGS: 00000246
[23860.817687] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00000000000=
00002
[23860.818459] RDX: 0000000000000001 RSI: 0000000000000000 RDI: ff29918f86f=
43ebc
[23860.819147] RBP: ff95ae8744fd8000 R08: 0000000000000000 R09: 00000000001=
00000
[23860.819984] R10: 0000000000000000 R11: 000000000003ed8c R12: ff29918f86f=
43ebc
[23860.820805] R13: ff95ae8744fd8000 R14: 0000000000000001 R15: 00000000000=
00000
[23860.821602] FS:  00007f591e707740(0000) GS:ff299192afb00000(0000) knlGS:=
0000000000000000
[23860.822464] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[23860.823030] CR2: 00007f6f6d2f1050 CR3: 0000000111ba0006 CR4: 00000000007=
73ef0
[23860.823708] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 00000000000=
00000
[23860.824389] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 00000000000=
00400
[23860.825107] PKRU: 55555554
[23860.825406] Call Trace:
[23860.825721]  <IRQ>
[23860.825996]  ? watchdog_timer_fn+0x1e0/0x260
[23860.826434]  ? __pfx_watchdog_timer_fn+0x10/0x10
[23860.826902]  ? __hrtimer_run_queues+0x113/0x280
[23860.827362]  ? ktime_get+0x3e/0xf0
[23860.827781]  ? hrtimer_interrupt+0xfa/0x230
[23860.828283]  ? __sysvec_apic_timer_interrupt+0x55/0x120
[23860.828861]  ? sysvec_apic_timer_interrupt+0x6c/0x90
[23860.829356]  </IRQ>
[23860.829591]  <TASK>
[23860.829827]  ? asm_sysvec_apic_timer_interrupt+0x1a/0x20
[23860.830428]  ? _raw_spin_lock+0x1b/0x30
[23860.830842]  nfs_folio_find_head_request+0x29/0x90 [nfs]
[23860.831398]  nfs_lock_and_join_requests+0x64/0x270 [nfs]
[23860.831953]  nfs_page_async_flush+0x1b/0x1f0 [nfs]
[23860.832447]  nfs_wb_folio+0x1a4/0x290 [nfs]
[23860.832903]  nfs_release_folio+0x62/0xb0 [nfs]
[23860.833376]  split_huge_page_to_list_to_order+0x453/0x1140
[23860.833930]  split_huge_pages_write+0x601/0xb30
[23860.834421]  ? syscall_exit_to_user_mode+0x10/0x210
[23860.835000]  ? do_syscall_64+0x8e/0x160
[23860.835399]  ? inode_security+0x22/0x60
[23860.835810]  full_proxy_write+0x54/0x80
[23860.836211]  vfs_write+0xf8/0x450
[23860.836560]  ? __x64_sys_fcntl+0x9b/0xe0
[23860.837023]  ? syscall_exit_to_user_mode+0x10/0x210
[23860.837589]  ksys_write+0x6f/0xf0
[23860.837950]  do_syscall_64+0x82/0x160
[23860.838396]  ? __x64_sys_fcntl+0x9b/0xe0
[23860.838871]  ? syscall_exit_to_user_mode+0x10/0x210
[23860.839433]  ? do_syscall_64+0x8e/0x160
[23860.839910]  ? syscall_exit_to_user_mode+0x10/0x210
[23860.840481]  ? do_syscall_64+0x8e/0x160
[23860.840950]  ? get_close_on_exec+0x34/0x40
[23860.841363]  ? do_fcntl+0x2d0/0x730
[23860.841727]  ? __x64_sys_fcntl+0x9b/0xe0
[23860.842168]  ? syscall_exit_to_user_mode+0x10/0x210
[23860.842684]  ? do_syscall_64+0x8e/0x160
[23860.843084]  ? clear_bhb_loop+0x25/0x80
[23860.843490]  ? clear_bhb_loop+0x25/0x80
[23860.843897]  ? clear_bhb_loop+0x25/0x80
[23860.844271]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[23860.844845] RIP: 0033:0x7f591e812f64
[23860.845242] Code: c7 00 16 00 00 00 b8 ff ff ff ff c3 66 2e 0f 1f 84 00 =
00 00 00 00 f3 0f 1e fa 80 3d 05 74 0d 00 00 74 13 b8 01 00 00 00 0f 05 <48=
> 3d 00 f0 ff ff 77 54 c3 0f 1f 00 55 48 89 e5 48 83 ec 20 48 89
[23860.847175] RSP: 002b:00007ffc19051998 EFLAGS: 00000202 ORIG_RAX: 000000=
0000000001
[23860.847923] RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 00007f591e8=
12f64
[23860.848702] RDX: 0000000000000002 RSI: 0000562caf357b00 RDI: 00000000000=
00001
[23860.849402] RBP: 00007ffc190519c0 R08: 0000000000000073 R09: 00000000000=
00001
[23860.850081] R10: 0000000000000000 R11: 0000000000000202 R12: 00000000000=
00002
[23860.850794] R13: 0000562caf357b00 R14: 00007f591e8e35c0 R15: 00007f591e8=
e0f00
[23860.851592]  </TASK>


--
Chuck Lever



