Return-Path: <linux-nfs+bounces-1994-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 237A8858503
	for <lists+linux-nfs@lfdr.de>; Fri, 16 Feb 2024 19:19:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 416591C20C2C
	for <lists+linux-nfs@lfdr.de>; Fri, 16 Feb 2024 18:19:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 439FA1350C8;
	Fri, 16 Feb 2024 18:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="BNUm6kmj";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="voQgDbO/"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18C8E12F5BF
	for <linux-nfs@vger.kernel.org>; Fri, 16 Feb 2024 18:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708107590; cv=fail; b=G7KSqyqRj8ZuXMZAIAdQ4C0W53ar3GHjclc9b8gZKBC1Yq0Cr0A4R4hLyw+/EbyQhj5/XZgv5ZMQ6TupD7yBhH9m/Pr5zuu/1mja0b059X71+azS6jkIwirZHV1FgzTDpLwDnMklV6sHAR1TWjPRriPJfHlnqiDPym65fUnBIkQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708107590; c=relaxed/simple;
	bh=9ApefaFroR4g/r71dAF4VSqFy7pwVnMmcTLaajZPZus=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FrdobnA1m3l8EnP4MK2+LFYS0kwlte6CVFoRPJWhYyXyo86zCOJiNDAuywvKR1vZDxqJQoEWRLEUdAiVfYTy4d1pJL6cPmY9aBMcXkVPSu5geLy6/W+gg/SxUVmWDeU7WjxGI+C+mPzQyAVC4Y3sg9eActJtAs2yr6Q88cNmKTs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=BNUm6kmj; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=voQgDbO/; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41GCtb1L006566;
	Fri, 16 Feb 2024 18:19:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=9ApefaFroR4g/r71dAF4VSqFy7pwVnMmcTLaajZPZus=;
 b=BNUm6kmjoIWYjzae/zbrJZuQiG+IrFjOjvwpu/IyqFOkYnxXw/DyP3Rg0ziejTNJC2hT
 OgKTYoPqOl9f6ZGYsAAsixYQ1DCMxqDM0s6OgGnsyDJW/h4JBAbvxvU+fcAR0cSsoUcU
 pwDMJoWfquzVy5OIBIO2QxuSRjs1DYCeP2fgX8pnso1sMEd3co5VRrneR+QW/ZhnHC95
 glGkp2DSC2Trei26CGhsDLxUZX6PBVXw9XxKhwU9tR1yFsNiricexbth4c3ALy6LfD6i
 Pw5XiGPRW783G98/PwVEpXdtPuiIOGuIvziqDpHc3wY3IImqhz3Suftwy9gVFctxI17z xA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w91f062ra-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 16 Feb 2024 18:19:45 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41GHlpP8015104;
	Fri, 16 Feb 2024 18:19:44 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2041.outbound.protection.outlook.com [104.47.74.41])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3w5ykcgk99-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 16 Feb 2024 18:19:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oTjrhSNCtaadZNDqyGNmP2FxyUyBgLGEGju2SaUqW9QFWrZnj4pPOE8F1RD/gN7EzOTruSr75xxeNF9HQg5FNdbBLoMmB4I6dx9yOiBGTHzMHEQuyo3/lMCb0md+ArMAvO/hlU7U+Bo7sVD5YU1PeiybjVtTMuox/cLiKknBpA8WgCywRsA8eyY0YW5L0RwmQZ7Omck+nS3rzGdV+NCK3EACsfzSAf/y7v17FO0iuc32oTshTyFjeGOapebnSWI27Co9vXvq0nuBCWC518Ah+nRlTx0aq44NuFdYZfko4HVkd4gV/qrGqryF424yofkg1LVyMv9tYWAi2teDM6CZQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9ApefaFroR4g/r71dAF4VSqFy7pwVnMmcTLaajZPZus=;
 b=HXhUbeB7bJLP+QBP6lqLWZ3PQzTzC+Ge4tjCKlGRG7zzX0B9lVsaZC443h63eXGBrLb45pWNkG7BjDqBEywyz/k+/QnREdEqoE53507SzjrnMVsTq2fBheWhKTEHxa4rz0fQ99niq9maxsfzNa3UYoxUzgnhcF5b4spz+OH0I5+56MhM9GPpw63NGsrNq/IDfjg2DC5wKVv4N+Hwfl1mOpujnjHsxIdK2coxSv6IZDeVB6kK1X5Jzd+BYwcCF7PId6bsIXxAQUamyIm5a/rc+g44QlV7xxvfDvlfTM7oUMT3mOs+fpMrChSpZaXztQq6PDcH5lqgUmX2/8jYAkpYEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9ApefaFroR4g/r71dAF4VSqFy7pwVnMmcTLaajZPZus=;
 b=voQgDbO/Y33OXn89y092l4ZKzQwS0x4p8FTKAkEu5rB+mVDeY1MmDaAYki8+jrAj5gtiP6vdicCFTjWnhfxUyKDUg43Rseq8WqvAm3x9T7NILpFGcmqUYeQIhB9XBM5sIS8Dlcx1mNdxeHTSPcPsbUhB5t+yZbiz/ontxr3TEl4=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CH3PR10MB7120.namprd10.prod.outlook.com (2603:10b6:610:127::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.26; Fri, 16 Feb
 2024 18:19:41 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ad12:a809:d789:a25b]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ad12:a809:d789:a25b%4]) with mapi id 15.20.7292.029; Fri, 16 Feb 2024
 18:19:41 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Trond Myklebust <trondmy@hammerspace.com>
CC: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] nfsd: Fix a regression in nfsd_setattr()
Thread-Topic: [PATCH v2 1/2] nfsd: Fix a regression in nfsd_setattr()
Thread-Index: AQHaYHfSswkUzWMpZ0KuX+oqHXrlfbEM+KOAgABPawCAAABogA==
Date: Fri, 16 Feb 2024 18:19:41 +0000
Message-ID: <CFBE3BDF-E347-4273-8C7F-A57E0D353457@oracle.com>
References: <20240216012451.22725-1-trondmy@kernel.org>
 <20240216012451.22725-2-trondmy@kernel.org>
 <Zc9kQ1Autf6xdcii@tissot.1015granger.net>
 <ac1166ca466c343f18df45094c0130947bd21f5c.camel@hammerspace.com>
In-Reply-To: <ac1166ca466c343f18df45094c0130947bd21f5c.camel@hammerspace.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.400.31)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|CH3PR10MB7120:EE_
x-ms-office365-filtering-correlation-id: 00aaa6ee-2e82-4a29-15c5-08dc2f1bd7cf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 z7c7dvDrL5fyz02tIhBFUVcRmRaLkcnWKtTmkOpPqDv4nDXkEr+7oG7Kr3kRnzjXm5FuHglnmzrYdBFtGr+5imLbCa7P+1hg3x9vFNa9F7Zx9+20cvcBXFSwBEVOdj2NDgNF2kEt446YgSkvRjR8/TDVnQF+u23ZBlVai9Us+LPrgcoFqgpCTnQkXeyRDGx7cojn02jhh/4aFxeN7LAYElaiZitOhFQsWIfP9ohqKqXo1fFOGPDYwpNiP5ux+pj0CY/UGddZ3AGKqOUsDFIyBM4CKPxDH7RSQMgwaGCv8r4LwLtFYSqSCWaHS63xH8Qm2AUuXHJJleYUK8gyawUAh6oIfvAx+bS7AXEjR5xgFWBwK8TUAr/pKayWrLhQINu4kY5M9NXrYG0tMxFp6cpD6AlZLtFEQMQ/C9YvkX9b+WkkZaMHnyVDOxTWZpCps5dnCWShEdWCDLcKLdnArju/zCpDEBobTktRWaDmeKQjtl2XV4sH/sdGXjItxjC0087k7zKhh2vz994wP6lioZBTdR3MSSsC/Khed3kkByuMQmyAIYuNCKCTe8GPEppSSETPpol/0fQUunrGGjTQdeLvbuRxGT3YAHrkLJcEXBvq9zaTbQxJIglObDgoctuhKev/
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(39860400002)(366004)(396003)(376002)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(8676002)(8936002)(4326008)(5660300002)(2906002)(83380400001)(36756003)(86362001)(2616005)(38070700009)(26005)(38100700002)(122000001)(33656002)(66556008)(6506007)(316002)(53546011)(66446008)(76116006)(64756008)(66476007)(6916009)(66946007)(6486002)(478600001)(71200400001)(6512007)(41300700001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?U1N2N1RydFVaaXRtNVRFMVIwL0pFQklXSUlqTXJXRHdlWVlqc2F6Rm5tcjFU?=
 =?utf-8?B?OFNDUTBxN29NZmhTYVU2OWxqazZKUDNUN3h6dStqamVFK0hQNGFsTmpkRE9p?=
 =?utf-8?B?ZGlQc0pJVmJhY1lhbXhlRzVXRTVRdXIzeWdjTzUzNU85Q0dhMS91QlRBQ3FY?=
 =?utf-8?B?WjF5b2ZPZVc3TXJqMEJFckZxU3hVMEJGbUNaTTR1enpQWUtjWlZlM25lSHlV?=
 =?utf-8?B?eG9uN0hzbmhVSkh4Q1lXK2g4clY0WkVLRUFwRWN3a1hvMGJBbTRlQkV3RGhy?=
 =?utf-8?B?OVlWWk1nL2hRdXdFQXI2RTZVM3orbFV1Skk4VkdldTRqbWh4VzBKcHV5bVc2?=
 =?utf-8?B?MWR2S3U5L0hYZXhxRkU1SmtnMmhBeHZSR0lBNi91SVR4ZUNMZHhqYnZ3MTdD?=
 =?utf-8?B?SGZINklEaVZwZC9QQW1rNXp3L2NvVCt5czFwTVFkUDlWcmFOckY3VlBpTjBo?=
 =?utf-8?B?Mzd0cUUxbkg1RGZLYWZ1SzRONHlta2U0SUVaYmdMQm1vUnBxakkvRlY1Tm5R?=
 =?utf-8?B?aVZtek5oTm1jMzBVcXNPbGRxQzRFdUFhV3JuanVCWGJzK2FUbnkvRU9NRmhn?=
 =?utf-8?B?Ymk2SFpZRUgwcHVqS09kRlBnZEF1ZFdWUHlSdnBxOUl0TDdIVmUyNnY3SUd3?=
 =?utf-8?B?L25PRnNyZk1hMDVnK1FJVFhBNyt1dXRwd0NvT2QxbElLZkJyZG5pRGxRWEox?=
 =?utf-8?B?dXVaK1pzbGpFaStUNmJ1d0ZlbDZyOFI1ZVd0b1l6K3g4NGxCNnE1MW84c2NO?=
 =?utf-8?B?b0lTcVpiNENxR1FLL0lqRjRLNk4rV3FyWTZTelBQMU5YTnNuL3lHc0FIbm9k?=
 =?utf-8?B?YTdzeE5QNlEwRXlrZDJ6TDZmZDd0NE42OTVDK29vcGpnTFRiYWRTTkkydmh5?=
 =?utf-8?B?ZnZiNGtsdy83Nkx6ZGZJNmc4N3hOQlFKcmVmb1R2d2o4bk5UbjlLUkdpaE45?=
 =?utf-8?B?UmZPamNWbUZOVXVlejBMRmtIU1hpd0dWS0o4WHFnTTBTRjFKYXArd0h0RDE3?=
 =?utf-8?B?N0FwSEpHd3R5OFVOdE11VkFVOGppZmJDNXF4Y2NManZXWXpoK2o5ZXFNejB2?=
 =?utf-8?B?bDd5WkVKZ1dXTkxTVEtCeTZCb2ZUWDAraWNIQ042ZEpjL3NWVjdZNFBIdk9Q?=
 =?utf-8?B?MlpWY2dLVGFPSmRmQmhhYVoySCtQZVcwUHBacGh0TFhmbTIzUEoxZFRNZUVz?=
 =?utf-8?B?UzJKbEJMUHhRUlc4R2M5aE9sQVpXK3Jpczg1TEpieElNS1NuMXNSbGhETTJW?=
 =?utf-8?B?QXByMk5DVE9NTENzdkhIemo4S3B4ZXZVeitTOTVaSjF6N25TN0thMzVFNHhy?=
 =?utf-8?B?cnppRHJTRThQNGtsTlYyMVdiY0ZCRFZGTzc3S24zazFOMHdYRy80cWFEckFG?=
 =?utf-8?B?WnBjOFU5ZTN0ems5bUYwZWt2dkpVMUM5QWo0dy9OZ01vblpibEx1RU9oS05x?=
 =?utf-8?B?N093RFpsbkJZcGRXblBieStlc0NYS3czWFE2K2Q5U29EU2FPcXp0MEV5YzJr?=
 =?utf-8?B?Umdnc25hcS9VQW94OHExUUF0ekxoWEdRT2RxbHJGYVZ4bkpUSmNwWStXWkVE?=
 =?utf-8?B?S0RHOEI3V2FpRzN6YVpMS0xGNlY0ajk4Z0FWME03RHluN0h1TjRVbEU3emoy?=
 =?utf-8?B?VkdNekRraFZpaWpva1JaaTFqclVoWi90MzlvSXdlV0IraGE3WTE0cWNjSmJS?=
 =?utf-8?B?VnllbFNPNkhSZUxtZUZ6SnBMYnovZFp1NEcxSnRQQ2g2RDFpQmQ3TktJalIv?=
 =?utf-8?B?QjZ5NEljemhDalZWbzByT2xUZld5ZnMwcGNDZ09LZVhycFNxRkRPeW5xdXBl?=
 =?utf-8?B?c3ZFS1p6eUxjcmRsTnVUQzV1ck5UVHdDd1h5UWtzK3VTR2MyNlJSVUkwMVRh?=
 =?utf-8?B?QkwwdHZ6bW1oVDc4d3ZMOUY1dER5UzY0dkJoWEFvdlg3aGhNbXhUK2kzeGMv?=
 =?utf-8?B?UjRnanBJOEFXS0NkbDVPNHI3Z092Y2pmUjFYNitSWDQyRUxtVkZnU3ZKUFB2?=
 =?utf-8?B?SXV3bzJWM2o5VTlCOXdVcG1EaytSb2JSWHJQUnJPYUxPdHJjU24vSFIvY2p3?=
 =?utf-8?B?dkVENEhnN1h6WkdGNHVQMWp6YlpuOHJ3bDBHMVVsZ3BYYXBybUQwaDN3dnJW?=
 =?utf-8?B?cDBTOXRmVll4NWppME54SXZjYW0zeEwyQ0RsSWdxSTZRSW5YVnRHZ3dER1Nu?=
 =?utf-8?B?dFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E1BC78E23569DE449ECB3B25204F0D90@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	/nTVVv/+q3NWiLW/3k5is1GpTtje1D5WF1+7xtFZ/FxKxy/7IYH82c0i7mpQFuFk3gu7rVPIVdpFFtgmqhW620yTt5pT410Zz5RipnITuCiPGPDRF19zd2UEiUeWZ3xwbQ8LT8OUX77+Fwo/qm5OpDT7GuC4M2zi4FePzmAcfXmnDhO0N8GTtCFnGfPV1KWlGwrPt24nZm9I7mawOQI8YOG9FHesWTMI3FBYtGRCvUDnMMLJ8asHrvRX93ZjdGKtg4mVFPCgknMn3siszbIL6OQIw6v27OMRXOhGv1mqFYeaWS4WW6XBQjzlhTtdNYlPbasWnjPepqwoyLhKOotkjGVHNaEOTUF+ytOowHJfu7qWWyl7qk6yUFNWWmQmLOtjVnPwruIkRr+NUm7i+nc9bww/JvJVFIYKPq2cZjPn37VfFURU4vaoLsmr9g5gehNn7RxIRdcCdz5IlzwtJDd3hElu//jPvOwbS3s6yCbsI+L7/vx0wu8I0m3RC/sSdVQKFR9STmmZlvvF7JR5EscW/Ff9bxVTkHwIZbxSpRwVV76qhVZM0oVBbVE3hTjv3P2LiwCQpIs+XqJGKmFUgN+q2OenqnAJHT9rhsQDmQsYAak=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00aaa6ee-2e82-4a29-15c5-08dc2f1bd7cf
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Feb 2024 18:19:41.0597
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: B/SWmPigz9HVgd4DVn59KP0nQUrcUPUgOGcysCZXIoh74ixRH/5U1b9yqKOUs5dq+6po3EwEWw+C67ESRiMSNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7120
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-16_17,2024-02-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 suspectscore=0
 phishscore=0 adultscore=0 spamscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402160145
X-Proofpoint-ORIG-GUID: LTM4FcxpAiSwPCik3zwRo39pSl60Xd9p
X-Proofpoint-GUID: LTM4FcxpAiSwPCik3zwRo39pSl60Xd9p

DQoNCj4gT24gRmViIDE2LCAyMDI0LCBhdCAxOjE44oCvUE0sIFRyb25kIE15a2xlYnVzdCA8dHJv
bmRteUBoYW1tZXJzcGFjZS5jb20+IHdyb3RlOg0KPiANCj4gT24gRnJpLCAyMDI0LTAyLTE2IGF0
IDA4OjMzIC0wNTAwLCBDaHVjayBMZXZlciB3cm90ZToNCj4+IE9uIFRodSwgRmViIDE1LCAyMDI0
IGF0IDA4OjI0OjUwUE0gLTA1MDAsIHRyb25kbXlAa2VybmVsLm9yZyB3cm90ZToNCj4+PiBGcm9t
OiBUcm9uZCBNeWtsZWJ1c3QgPHRyb25kLm15a2xlYnVzdEBoYW1tZXJzcGFjZS5jb20+DQo+Pj4g
DQo+Pj4gQ29tbWl0IGJiNGQ1M2Q2NmU0YiBicm9rZSB0aGUgTkZTdjMgcHJlL3Bvc3Qgb3AgYXR0
cmlidXRlcw0KPj4+IGJlaGF2aW91cg0KPj4+IHdoZW4gZG9pbmcgYSBTRVRBVFRSIHJwYyBjYWxs
IGJ5IHN0cmlwcGluZyBvdXQgdGhlIGNhbGxzIHRvDQo+Pj4gZmhfZmlsbF9wcmVfYXR0cnMoKSBh
bmQgZmhfZmlsbF9wb3N0X2F0dHJzKCkuDQo+PiANCj4+IENhbiB5b3UgZ2l2ZSBtb3JlIGRldGFp
bCBhYm91dCB3aGF0IGJyb2tlPw0KPiANCj4gV2l0aG91dCB0aGUgY2FsbHMgdG8gZmhfZmlsbF9w
cmVfYXR0cnMoKSBhbmQgZmhfZmlsbF9wb3N0X2F0dHJzKCksIHdlDQo+IGRvbid0IHN0b3JlIGFu
eSBwcmUvcG9zdCBvcCBhdHRyaWJ1dGVzIGFuZCB3ZSBjYW4ndCByZXR1cm4gYW55IHN1Y2gNCj4g
YXR0cmlidXRlcyB0byB0aGUgTkZTdjMgY2xpZW50Lg0KDQpJIGdldCB0aGF0LiBXaHkgZG9lcyB0
aGF0IG1hdHRlcj8NCg0KDQo+Pj4gRml4ZXM6IGJiNGQ1M2Q2NmU0YiAoIk5GU0Q6IHVzZSAodW4p
bG9ja19pbm9kZSBpbnN0ZWFkIG9mDQo+Pj4gZmhfKHVuKWxvY2sgZm9yIGZpbGUgb3BlcmF0aW9u
cyIpDQo+Pj4gU2lnbmVkLW9mZi1ieTogVHJvbmQgTXlrbGVidXN0IDx0cm9uZC5teWtsZWJ1c3RA
aGFtbWVyc3BhY2UuY29tPg0KPj4+IC0tLQ0KPj4+ICBmcy9uZnNkL25mczRwcm9jLmMgfCA0ICsr
KysNCj4+PiAgZnMvbmZzZC92ZnMuYyAgICAgIHwgOSArKysrKysrLS0NCj4+PiAgMiBmaWxlcyBj
aGFuZ2VkLCAxMSBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPj4+IA0KPj4+IGRpZmYg
LS1naXQgYS9mcy9uZnNkL25mczRwcm9jLmMgYi9mcy9uZnNkL25mczRwcm9jLmMNCj4+PiBpbmRl
eCAxNDcxMmZhMDhmNzYuLmU2ZDg2MjRlZmM4MyAxMDA2NDQNCj4+PiAtLS0gYS9mcy9uZnNkL25m
czRwcm9jLmMNCj4+PiArKysgYi9mcy9uZnNkL25mczRwcm9jLmMNCj4+PiBAQCAtMTE0Myw2ICsx
MTQzLDcgQEAgbmZzZDRfc2V0YXR0cihzdHJ1Y3Qgc3ZjX3Jxc3QgKnJxc3RwLCBzdHJ1Y3QNCj4+
PiBuZnNkNF9jb21wb3VuZF9zdGF0ZSAqY3N0YXRlLA0KPj4+ICAgfTsNCj4+PiAgIHN0cnVjdCBp
bm9kZSAqaW5vZGU7DQo+Pj4gICBfX2JlMzIgc3RhdHVzID0gbmZzX29rOw0KPj4+ICsgYm9vbCBz
YXZlX25vX3djYzsNCj4+PiAgIGludCBlcnI7DQo+Pj4gIA0KPj4+ICAgaWYgKHNldGF0dHItPnNh
X2lhdHRyLmlhX3ZhbGlkICYgQVRUUl9TSVpFKSB7DQo+Pj4gQEAgLTExNjgsOCArMTE2OSwxMSBA
QCBuZnNkNF9zZXRhdHRyKHN0cnVjdCBzdmNfcnFzdCAqcnFzdHAsIHN0cnVjdA0KPj4+IG5mc2Q0
X2NvbXBvdW5kX3N0YXRlICpjc3RhdGUsDQo+Pj4gIA0KPj4+ICAgaWYgKHN0YXR1cykNCj4+PiAg
IGdvdG8gb3V0Ow0KPj4+ICsgc2F2ZV9ub193Y2MgPSBjc3RhdGUtPmN1cnJlbnRfZmguZmhfbm9f
d2NjOw0KPj4+ICsgY3N0YXRlLT5jdXJyZW50X2ZoLmZoX25vX3djYyA9IHRydWU7DQo+Pj4gICBz
dGF0dXMgPSBuZnNkX3NldGF0dHIocnFzdHAsICZjc3RhdGUtPmN1cnJlbnRfZmgsICZhdHRycywN
Cj4+PiAgIDAsICh0aW1lNjRfdCkwKTsNCj4+PiArIGNzdGF0ZS0+Y3VycmVudF9maC5maF9ub193
Y2MgPSBzYXZlX25vX3djYzsNCj4+PiAgIGlmICghc3RhdHVzKQ0KPj4+ICAgc3RhdHVzID0gbmZz
ZXJybm8oYXR0cnMubmFfbGFiZWxlcnIpOw0KPj4+ICAgaWYgKCFzdGF0dXMpDQo+Pj4gZGlmZiAt
LWdpdCBhL2ZzL25mc2QvdmZzLmMgYi9mcy9uZnNkL3Zmcy5jDQo+Pj4gaW5kZXggNmU3ZTM3MTky
NDYxLi41OGZhYjQ2MWJjMDAgMTAwNjQ0DQo+Pj4gLS0tIGEvZnMvbmZzZC92ZnMuYw0KPj4+ICsr
KyBiL2ZzL25mc2QvdmZzLmMNCj4+PiBAQCAtNDk3LDcgKzQ5Nyw3IEBAIG5mc2Rfc2V0YXR0cihz
dHJ1Y3Qgc3ZjX3Jxc3QgKnJxc3RwLCBzdHJ1Y3QNCj4+PiBzdmNfZmggKmZocCwNCj4+PiAgIGlu
dCBhY2Ntb2RlID0gTkZTRF9NQVlfU0FUVFI7DQo+Pj4gICB1bW9kZV90IGZ0eXBlID0gMDsNCj4+
PiAgIF9fYmUzMiBlcnI7DQo+Pj4gLSBpbnQgaG9zdF9lcnI7DQo+Pj4gKyBpbnQgaG9zdF9lcnIg
PSAwOw0KPj4+ICAgYm9vbCBnZXRfd3JpdGVfY291bnQ7DQo+Pj4gICBib29sIHNpemVfY2hhbmdl
ID0gKGlhcC0+aWFfdmFsaWQgJiBBVFRSX1NJWkUpOw0KPj4+ICAgaW50IHJldHJpZXM7DQo+Pj4g
QEAgLTU1NSw2ICs1NTUsOSBAQCBuZnNkX3NldGF0dHIoc3RydWN0IHN2Y19ycXN0ICpycXN0cCwg
c3RydWN0DQo+Pj4gc3ZjX2ZoICpmaHAsDQo+Pj4gICB9DQo+Pj4gIA0KPj4+ICAgaW5vZGVfbG9j
ayhpbm9kZSk7DQo+Pj4gKyBlcnIgPSBmaF9maWxsX3ByZV9hdHRycyhmaHApOw0KPj4+ICsgaWYg
KGVycikNCj4+PiArIGdvdG8gb3V0X3VubG9jazsNCj4+PiAgIGZvciAocmV0cmllcyA9IDE7Oykg
ew0KPj4+ICAgc3RydWN0IGlhdHRyIGF0dHJzOw0KPj4+ICANCj4+PiBAQCAtNTgyLDEzICs1ODUs
MTUgQEAgbmZzZF9zZXRhdHRyKHN0cnVjdCBzdmNfcnFzdCAqcnFzdHAsIHN0cnVjdA0KPj4+IHN2
Y19maCAqZmhwLA0KPj4+ICAgYXR0ci0+bmFfYWNsZXJyID0gc2V0X3Bvc2l4X2FjbCgmbm9wX21u
dF9pZG1hcCwNCj4+PiAgIGRlbnRyeSwNCj4+PiBBQ0xfVFlQRV9ERUZBVUxULA0KPj4+ICAgYXR0
ci0+bmFfZHBhY2wpOw0KPj4+ICsgZmhfZmlsbF9wb3N0X2F0dHJzKGZocCk7DQo+Pj4gK291dF91
bmxvY2s6DQo+Pj4gICBpbm9kZV91bmxvY2soaW5vZGUpOw0KPj4+ICAgaWYgKHNpemVfY2hhbmdl
KQ0KPj4+ICAgcHV0X3dyaXRlX2FjY2Vzcyhpbm9kZSk7DQo+Pj4gIG91dDoNCj4+PiAgIGlmICgh
aG9zdF9lcnIpDQo+Pj4gICBob3N0X2VyciA9IGNvbW1pdF9tZXRhZGF0YShmaHApOw0KPj4+IC0g
cmV0dXJuIG5mc2Vycm5vKGhvc3RfZXJyKTsNCj4+PiArIHJldHVybiBlcnIgIT0gMCA/IGVyciA6
IG5mc2Vycm5vKGhvc3RfZXJyKTsNCj4+PiAgfQ0KPj4+ICANCj4+PiAgI2lmIGRlZmluZWQoQ09O
RklHX05GU0RfVjQpDQo+Pj4gLS0gDQo+Pj4gMi40My4xDQo+Pj4gDQo+Pj4gDQo+PiANCj4gDQo+
IC0tIA0KPiBUcm9uZCBNeWtsZWJ1c3QNCj4gTGludXggTkZTIGNsaWVudCBtYWludGFpbmVyLCBI
YW1tZXJzcGFjZQ0KPiB0cm9uZC5teWtsZWJ1c3RAaGFtbWVyc3BhY2UuY29tDQoNCg0KLS0NCkNo
dWNrIExldmVyDQoNCg0K

