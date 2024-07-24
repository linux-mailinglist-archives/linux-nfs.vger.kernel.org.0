Return-Path: <linux-nfs+bounces-5033-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2F5793B376
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Jul 2024 17:16:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E694F1C22A9B
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Jul 2024 15:16:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FAC5D29E;
	Wed, 24 Jul 2024 15:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="EXAtaxaH";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Qag13TD7"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FE9633FD
	for <linux-nfs@vger.kernel.org>; Wed, 24 Jul 2024 15:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721834166; cv=fail; b=Kzsv392alAbAxuDo2x0BSOQPhTaXbCF+i9yJz+U/nICIzpllpomI2d8S1jSirA2g3lXXq2FVOhYYh7YVQyqivm0qD7aEOrUsS3UE+kiIjoKoJp7RX2qE33xwAMsH1vXkdx2Mk1nAjBsHZZdlhJaFPwdEXuTSK+gAv4HgA1rCVco=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721834166; c=relaxed/simple;
	bh=+6vJdzgOVz3ECJR8ZX2pLo+HmBOctQttR7+/S7IdSBo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Sfj4kpS5yzINcZAwoi4ekJvKOlPdXe4IsEN2C1tp9kKG8JyQT23KompWAxJSWADZjTb4R2UVr5/BnpG89EwGHL542AhCsFxUddcWoHmL0GWujMAs131+gPDf+R4bBHHxumw3u+LV9LBRDM3RIgnBRDZ7jks/TRPsEIhoKgY2YaA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=EXAtaxaH; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Qag13TD7; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46ODDDrC015373;
	Wed, 24 Jul 2024 15:15:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-id:content-transfer-encoding:mime-version;
	 s=corp-2023-11-20; bh=+6vJdzgOVz3ECJR8ZX2pLo+HmBOctQttR7+/S7IdS
	Bo=; b=EXAtaxaHrlY2P2qiWr5ingEmbqWw8XPQJZ0HxOnN1FOW4VZa2p45qM8zZ
	WIwdIVxYWw8Qbu7uSiyzKoVkMwuimsYMYCNu95d+cd1mxNAt0l4CFUXmlLTuxiwv
	wtEEVoUolnmBhaTQMNXTyNXl6klqfK8UeKkpsJbuu0VG58Lfp7l7jtdvn71yNOS7
	hl/zGEKbVb/Wf3aIkmXX5s1g8khqKw4EjOSSmempbnl4cjAW2qVBjgLIA8PCYgB3
	nArbvUezEpGuHfYNQTiVPzn63mUgA+3G8lTLXKlI5y49dAPfemKcomDKLeHjWWEO
	2h20KB7d0M1Ykpy8iXPYarqt2wNaA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40hgkt97vb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Jul 2024 15:15:51 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46OEWfFR040045;
	Wed, 24 Jul 2024 15:15:49 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2048.outbound.protection.outlook.com [104.47.66.48])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 40h26p17vj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Jul 2024 15:15:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CT9S9eVIlvhX9eB+T2AuWMDCGOIufwcqK94CGjOxIo0zw1mkP8TOEneZ/2Z7K6MbOT77bmCdBqjh8vmG3I1GptbAvWvxTtQ3qXO4xjKCS93wqtee02kTf5qi97X8E1rlPF3N+1FYH2oUHn3ngYgz52SQO/l9mqBeO2vLWMlG9QZlQK2b936CuvRa570w86627xqpZ1FycQoS06g4XwJgC9SZQUoSC1IfdsR3PHcofAXZz+ofFS7d26FoRJOjr2FHElHTgJsunr4+NOEPtL2qmdvu4b9AXqXMs3cbkqCmaZC3q6RRu8OopmLpMmjA5Re7GbX+iFP6DGSP1rj2SHc8+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+6vJdzgOVz3ECJR8ZX2pLo+HmBOctQttR7+/S7IdSBo=;
 b=ZQE1FACk8P1tTrmfqfcVEF7KcdlFsvwQtVMZgFMidNfDQi9C5OzVeUp+d5+0dhLukE9fK0MX0nrNkR6hA+fLpbmQaMGrkIeXFYgAZXBZAu6Cyw4QdPLKXdTBF3B41u7agdiEIX+8Wg5jqCDTNDbxGuPto5P+XBE6YEXTkbcGfNcMPkGLtw/x80FkfwAnwT9OxkH9uX+6MPv/s47t+uOPUrnDt8oitEOp+M68TalhaofvRKiX6WFtdkCueqUqAVHIQW3n9/IKWYNdtLATwetUk+e3YnwvcAZq3UeC1bQ7VgH8RpPyYarpfdtqNfijheQnh98Cuo4KMyQqn5lzCJIV3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+6vJdzgOVz3ECJR8ZX2pLo+HmBOctQttR7+/S7IdSBo=;
 b=Qag13TD7pgaAH9+a/Nn2Ndhtkk/wKfBw9+iCCAHUA3XHxhaVnySWl8ax090mtL5wrNENQUkJZatLYkXrXj0kgZgQxCHKXVT5p8dKZJI4hIv7RZMMUGvdfYcv/JhxZo8poQQVTeFkvzzNj9JNFq6f9+75n4tP8T0VzbfVON2F/Sk=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CH3PR10MB6859.namprd10.prod.outlook.com (2603:10b6:610:14f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.32; Wed, 24 Jul
 2024 15:15:46 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.7784.017; Wed, 24 Jul 2024
 15:15:46 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: "gisburn@nrubsig.org" <gisburn@nrubsig.org>
CC: Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "ms-nfs41-client-devel@lists.sourceforge.net"
	<ms-nfs41-client-devel@lists.sourceforge.net>
Subject: Re: New NFSv4.2 attribute |FATTR4_TMPFILE| (sort of opposite of
 |FATTR4_OFFLINE|) ?
Thread-Topic: New NFSv4.2 attribute |FATTR4_TMPFILE| (sort of opposite of
 |FATTR4_OFFLINE|) ?
Thread-Index: AQHa3QKuWVeyibac00Wk/nvvcieDf7IF/qSA
Date: Wed, 24 Jul 2024 15:15:46 +0000
Message-ID: <C389BE98-7EEE-44D6-9B5E-CE9628C5BA8C@oracle.com>
References:
 <CAKAoaQmG+FRhQquBJzFkr+BHFDCxxKky706Za2+nC9CNf8i10w@mail.gmail.com>
In-Reply-To:
 <CAKAoaQmG+FRhQquBJzFkr+BHFDCxxKky706Za2+nC9CNf8i10w@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3774.600.62)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|CH3PR10MB6859:EE_
x-ms-office365-filtering-correlation-id: f605bc5d-2c8d-4373-690f-08dcabf37e36
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?b3FWZ21sNVR6UHlVbUNGRGgzWGpQaDIyNnFsbS9HTDFFTHg2Qy9pTXkzL1M1?=
 =?utf-8?B?ekRNcHJmY3ZCOEcyTzNUTm1QZk5sVDBzKzVhN1ZyY2h6RkdIbFg3YmlmU0R6?=
 =?utf-8?B?cjdxb0IybDNFL2xDT1JWdEs2YW1xaTV5dWxKU0VrREdLQTVSMTZYSDIxMnB5?=
 =?utf-8?B?S1JkSnd0Mm80MWlrdWlSbXZmUGVOS3lYYXhyWGZsQXVxc3ZjbG5ETDRlOWh3?=
 =?utf-8?B?YlBkRWRaL2tUUklFeGNHdTdWVVF6bEM4dkh5dnp2YW1FMTZreCtFdlBEeTRu?=
 =?utf-8?B?clVUUTJPam5PVUVsVXljcEw1bTl4dkR5ZjdNdmcvNS9CTE43YjNFUnpkb0NK?=
 =?utf-8?B?NzlubkRybzZDOG1kL3N0Q2E2THdZVHBjUndTYndjQ1Iydzh6ZHBLSGVBUGZ3?=
 =?utf-8?B?R3JZT3FGckw4dXhyMVRrbHVobWkzYW5RSnVFSCtqV05xenhuTWk5ZitjeE1Q?=
 =?utf-8?B?YkE3czRHNUpYRy9nK3AvMytsdTJqeGV1SzhZbjlQWmhGWVg5S0JhbGhNbmNH?=
 =?utf-8?B?S1dKTW5nMldBbFZMQjZIV05weFEvSCtpTUt6MllNWUVmV2JEcTh0eFdzZ0xU?=
 =?utf-8?B?QnRKcWdITnRsK2xEUmFldzBpdVNWMDh2azd4dVVUVEZRWjAxeEI4bFUyZitz?=
 =?utf-8?B?Nk5sd0RwZHBnNlBtZlpYdEhmSjhJZUwzYU5OV3NHZTJ3bmN1a1B3K3hNenc1?=
 =?utf-8?B?WjFnQVgyZmFRbWNLbXY3MXpUQnBCaDZYZmRTU3o1T2ZqdnpOVDJOQTB4bldu?=
 =?utf-8?B?MFErbWdaL0FDUXlpbCt4V21POXdqaGh2djdlZEdzbmVQQk8rVXRkZHhMTHVs?=
 =?utf-8?B?N21RanZTbGg3UWs2SkIzMFpBVEJPaWwwQ1J5NmhWeUFqeTRtdzJaUWtiNDh3?=
 =?utf-8?B?U0RaUTdETHI1YjVZMWFZRUtOcG03WW1wWjZTNDNlRWNlZ0M4K2thcURKUDFY?=
 =?utf-8?B?WS9qamYxZ0hneXNXZjNxS3A4SkovL201VWMrSStlL1hnY0VTUnVkLzBnclYy?=
 =?utf-8?B?SnpKaEhCc2N0dSt1S0NVY1BMOG9jUk1iTEdpaEN5Y1pwVzYxalcvd2x4OE0z?=
 =?utf-8?B?aTBIZWd6TWpnd2tKNWZ1M1lYZE9SWE0zU1Y3M0t5QWp2eUFxRU9Lc0VSNGZp?=
 =?utf-8?B?RzhYTmw1UENRSENaTzlRaU9USEV2bSsyeU9JNEpmRmwxaU5PSUZVL2xDZ0lC?=
 =?utf-8?B?T09ZN2J0RVcwQlloaVdaVFZsMWpTUDNRVGs2UWg5b1RsNlYyMjUxVXZNNnpz?=
 =?utf-8?B?REp0UzJ0WEViUWtodHQyZ1VZdkFZY2I3d0xSTFVJNU9pMkYxRXFzdTNoR0ww?=
 =?utf-8?B?YkRXV0FyL0lNN0RYZmRQTW9VRTNTejAyZlJTd0htcmhRaFhrNFVPcS9PbVFv?=
 =?utf-8?B?L3k1SkxyQW8zYVlTYllZRGpDdXgwR3pVWEJjeDFmeCtqK3ZsQ2RCNnEzbW5F?=
 =?utf-8?B?dlU5TlhXS016elJFSndZdDExUzVHaXFLRStIVUlLeEluRlZSVjl4aDBPT200?=
 =?utf-8?B?SjNiQmh4N3lTNmRIL1Y2R0xNVk5Nek5rQ0R0WEMxZ1hCWU55c3ZaMkl6VDFz?=
 =?utf-8?B?Z2tDQlU4dTBNaUdBbGN2ZDg1d2xHTjdMQ3QrS0ZtSlhaTzQ0MFFZb0ZLd2I5?=
 =?utf-8?B?cVBNby9rekFIbW5OZEFqNHBwOVRiSDk4UVNwbm9oV3MxWHVtZi9Gc1R2SFl2?=
 =?utf-8?B?K0VQNmtzekJOaXRxQ0Vwenh0ZlFjMlE4aEFCcnJrMkMzRENaa0hCRFBEUzg1?=
 =?utf-8?B?WCtPbWdkdTZDNVFyOTdaeitVQ2oyVk1IMUFKeVZka1NhTU95cmdSaFNkZ2dK?=
 =?utf-8?B?Vi9kRXQrTnF6eDZGMmZqZW9Dc2MxcHY1c3YxMWtuSTV4bTFsNlBjaGJGZjMr?=
 =?utf-8?B?QnVHOVZCbU1VWjRaalpIQ1ZFN0k1OGY4ZjBwVjNTR1lIYWc9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UjdFd1Y4RENaU0ZZRGFtaENMc0FNR3NNNXVPT2F0OUwvd04vN0RuWmxaWjI3?=
 =?utf-8?B?ZjkrejZabWtOZHJUUGNmY2sxQ0Z6RGFzMjdoT1RleG1pc0UvUWdBMDEzM2tP?=
 =?utf-8?B?cUFLWEFRdUpiN3U3RjNPMnFXUktQUHI5MTZuMGsvY09hSmpkZjZmdEExYWdy?=
 =?utf-8?B?QWJ1eTR3RmpOVGo0eFJQRURCRWhkUmtYcnpHUXZ3bmdYSlFteUNRVjlxTmlB?=
 =?utf-8?B?Y2VFNWRGNFB0MU5MOWxweE5NTzZTaWlaR3RFYXhaNklRS0FEWWorR1RJSXBu?=
 =?utf-8?B?dHlEWkdsMGlQallNK3Z5U0VINVM4SXpjOFJ2Um41WVA3cHZoN2gyajNEclNG?=
 =?utf-8?B?Y0E3UUZzejE2U0xzOXRUUGZDUWo0UFU5dWpNYTVjRFIvS0VKanJjeXVkRHZ3?=
 =?utf-8?B?ZWcvVDAxVERDYlREekJNRGM5bm9uWWFPaVJDdlpKaWRJRERDWStpdWVCa0wy?=
 =?utf-8?B?Vks0VkxVMmVLaVIyNUZ2dlc2VndYU2x2MUoxNE40ZytZa0lEL3hLbmxYcURr?=
 =?utf-8?B?OTlNNGVDVWdrTFhGNmJTRWttNWttdHJ2aEtudEJCRmQ1K0UrWnlIZnVvQ2wz?=
 =?utf-8?B?RktUUk9IMjNSWkkyaHlkWGZRMW0yYW01akY0RmJIQXNZelo3Zkt6OUtxOGxt?=
 =?utf-8?B?Y1phNGVDaTdsK3I1N0pZR0ZsRC8xeVIxMjY0YmFubGd2R0lGWVpPTWVjV2tX?=
 =?utf-8?B?aWJHRnJDOWRYdnZZckpWbnRtdTJnMVhRcTJBTE5WSWF0R0w3dVV1THZ1bER2?=
 =?utf-8?B?U0JnZFBOVlpEN2N1UTUvNCs1MnRnb21TMXgxN3YvV3pIOEptTkFLaCtpb0NY?=
 =?utf-8?B?RFBkeGZLRStLR3ZIV2dLcC9yaEs0UEo3ZGZnSkZucHBYR3dtZk5NVGR0NC9J?=
 =?utf-8?B?MjRDeTFYeTQwRklqRlpQamFBL0xaaHczZzhLSGNiYzM3L080MkdUZk9CSkVr?=
 =?utf-8?B?NVZCTFgyazR3QU5rNlZIQ05ZUnRVQjEydHVEYytnQlMyVTUzSTN1RkdTWUVD?=
 =?utf-8?B?Qkozdy9hM3hQMFpHTjlBaWZuRStqNE8wcmRtZzlsZGlNRlc0UEFwNnRYYWRX?=
 =?utf-8?B?eGxKS1llQ3RvVDNKN1R0Q25MY2NoK2RKY3p0eE9UaXNLV083SndpaHh6OFdT?=
 =?utf-8?B?MGRldUhKZ1JRU3BqWW02VVh4UXdBaklxdGRFUzJRUDlvV2hZTUVvelVrdzNS?=
 =?utf-8?B?ejY5aDh3R2RuYWVKNGgvMTBQdGNvTVRnVWdFV05vMW5Dd0M4MTcrNk9GdlBx?=
 =?utf-8?B?Rld3Rlo5UGc0WU5ZSE53UStleUF5L2dJV2RJdzJ5VzdQVENiS0JrbVVTZkNY?=
 =?utf-8?B?UzdQMXVkUGNuVlBHeFhRTFNpcURUQVU3SWlaMXFnWDJiMW9CcjQvMXJhMVRm?=
 =?utf-8?B?VjdMMEdFeVBoNytqYzRLRjlwTEFobG11U0s4bExaUk91S1FibU41SlZLZ05y?=
 =?utf-8?B?N1ByL2RrVXJBTitpM1J6TEMvcThXY3NoejA1TnFNZXd3TGg1cnlLUmsxeUd3?=
 =?utf-8?B?dEFOeTF6aXZMdnRwcVJHUFhxQTlieDAvUmpEOWVVTmpzRE5EbHJqS1dTWXZX?=
 =?utf-8?B?ZnB0eFBPSjJDWm1wVnRRaTVRb05FUGo2VlF6N2I3TVRqNWlRNzgvUk5mODFP?=
 =?utf-8?B?cm03OUlTR3dkVVNWWmZ0TXpmMjNwNlVLY0w5N09aNThXWVdDU3BWODcrR2Z6?=
 =?utf-8?B?R1dQamExaG43ZzRGbVFQaFlRY0xxS1krYUFoWVhMMVpmdTUxejRndmZQOGFr?=
 =?utf-8?B?ek5hN3A0ZXdKMU1YYjNKSjI3Y2x4VDdid2xnT1VYOXJ5SU9UTEZPdGJIaEVo?=
 =?utf-8?B?WUZtY0ZKcVJyYlVRaFB6Z25ydmR3dHhNOEFTUDVFdktjdDVEMjVDSGFIM29O?=
 =?utf-8?B?TUI3OVRNWTdxVmFWeFg1ZWVVMXhHOXpLdXcvSkRZdURwMTZ0dUVpVU9qRE1r?=
 =?utf-8?B?YTVwWnE5aXFCTjQ3a1VCQW1HNUN4THA1eEdFbnp5RDdudjRsOW0wUFk0YURx?=
 =?utf-8?B?QUVoWFpJblpleW9rYSt2N00yQVhrbjZKV3ZWT0JIQmRyTTRXS0NPb3RSWTZy?=
 =?utf-8?B?K1J0U1NhZTFMbTRHSVQzU0ZMY25YQmIwOVJ1bGM5cE1qditjKzVWTjVrVGU1?=
 =?utf-8?B?QWVJbWVsWk9uSDBjOXlaKzA2eE1wWVlpOG9qdFRRYmVSYlFxVEs3aytpbTgx?=
 =?utf-8?B?bGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9C18E13FF9CBCB46BC896C830D5779E3@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	V1FRtFZkTRkr0mzD9DcleSYI+7UU3a4tw7VfcNlTB4VkViVJ9VqRj/S/CVkqwILxC0AGI0hjMuGAUISj17aIuVS9u4D11YjYj4h+3eHK8fmuaexk4wdi/sL5bJJ/AA9lHWnLCWxVG8Em3/zK8wZt67TZsFK9UMhj5E8EmrAoaceUZ027Bwvse6pcNBD5Ha9OjVsmNQdM/2geK7wKrT1seyUwZtKVCWIsnlZgspBOdNePVS1RwU37C7j5YO/WMmL4vIY5SxkCeVZS/L5HdF1CfNCT4i0B2j1ipSNKn5SJt9Y4dz/88Xf3Cj0D43oXaX4SgfUpDa1/vcMBK24GXUBfBzyDO7BcljCxbzScK33zw2wgluitDgfgONcs1apDS+MdfKvEVSyB+EaL2JUECYawqQ5kRXZ5/fBamjrM5TZE+uwv+s8iUskdh94dsccSuQovoUo7lsIwqJta1/sveHz/33pqqiARPJEm/Mm6VTlreyFRaE+fHutlxwm/YcMxKmMozLsIkNPFeguNXbxoQIj42PdnU8rSjBoAirjeeZxMPia5lmMIjmXlPk9o8vUsHeJE79OODQP1NT+nmeoFylKbSRay1jSoLuOkxNa0k85jJAM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f605bc5d-2c8d-4373-690f-08dcabf37e36
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jul 2024 15:15:46.2338
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DbxGM+hRi4IbAtsCVFeTwIRASnatSzYP138Vwc1kgw+DbqghssKDNMKBHHxfTIxJt7OP0LXzywsdjRVZ0rv2Bg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB6859
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-24_13,2024-07-24_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 bulkscore=0
 suspectscore=0 malwarescore=0 adultscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2407240111
X-Proofpoint-GUID: GRxfV_7ugJK7jxpJufvZhV_CwxFoFJt0
X-Proofpoint-ORIG-GUID: GRxfV_7ugJK7jxpJufvZhV_CwxFoFJt0

DQoNCj4gT24gSnVsIDIzLCAyMDI0LCBhdCA5OjE24oCvQU0sIFJvbGFuZCBNYWlueiA8cm9sYW5k
Lm1haW56QG5ydWJzaWcub3JnPiB3cm90ZToNCj4gDQo+IFRoZSBXaW4zMiBBUEkgaGFzIHxGSUxF
X0FUVFJJQlVURV9URU1QT1JBUll8IChzZWUNCj4gaHR0cHM6Ly9sZWFybi5taWNyb3NvZnQuY29t
L2VuLXVzL3dpbmRvd3Mvd2luMzIvYXBpL2ZpbGVhcGkvbmYtZmlsZWFwaS1jcmVhdGVmaWxlYSkN
Cj4gdG8gb3B0aW1pc2UgZm9yIHNob3J0LWxpdmVkL3NtYWxsIHRlbXBvcmFyeSBmaWxlcyAtIHdv
dWxkIGl0IGJlIHVzZWZ1bA0KPiB0byByZWZsZWN0IHRoYXQgaW4gdGhlIE5GU3Y0LjIgcHJvdG9j
b2wgdmlhIGEgfEZBVFRSNF9UTVBGSUxFfA0KPiBhdHRyaWJ1dGUgKHNvcnQgb2YgdGhlIG9wcG9z
aXRlIG9mIHxGQVRUUjRfT0ZGTElORXwsIHN1Y2ggYQ0KPiB8RkFUVFI0X1RNUEZJTEV8IHNob3Vs
ZCBiZSBpZ25vcmVkIGJ5IEhTTSwgYW5kIGZsdXNoaW5nIHRvIHN0YWJsZQ0KPiBzdG9yYWdlIHNo
b3VsZCBiZSByZWxheGVkL2RlbGF5ZWQgYXMgbG9uZyBhcyBwb3NzaWJsZSkgPw0KDQpXZWxsLCBJ
IG1pZ2h0IHN0YXJ0IHdpdGggdGhlIGNsaWVudCBzaWRlLiBUaGUgY2xpZW50IGNvdWxkDQphdm9p
ZCBmbHVzaGluZyBkYXRhIGJhY2sgdG8gdGhlIHNlcnZlciBpbiB0aGlzIGNhc2UsIGFuZA0KdGhl
IHNlcnZlciAoYW5kIHByb3RvY29sKSB3b3VsZG4ndCBoYXZlIHRvIGtub3cgYWJvdXQgdGhlDQpm
aWxlJ3MgdGVtcG9yYXJ5IHN0YXR1cy4NCg0KSSdtIG5vdCBhd2FyZSBvZiBhIHN5c3RlbSBjYWxs
IEFQSSBvbiBQT1NJWCBORlMgY2xpZW50cw0KdGhhdCBtaWdodCBlbmFibGUgdGhlbSB0byB1c2Ug
c3VjaCBhIHByb3RvY29sIGZlYXR1cmUuDQpPbmUgaWRlYSBtaWdodCBiZSB0byB1c2UgZmFkdmlz
ZSgyKS4uLiA/IFNvIGJlY2F1c2UgdGhpcw0KbWlnaHQgYmUgYSBmZWF0dXJlIG9ubHkgZm9yIGNs
aWVudHMgdGhhdCBzdXBwb3J0IHRoZQ0KQ3JlYXRlRmlsZUEgQVBJLCBwcm90b3R5cGluZyBpdCBv
biBzdWNoIGNsaWVudHMgbWlnaHQgYmUNCmEgZ29vZCBwbGFjZSB0byBkZW1vbnN0cmF0ZSB2YWx1
ZS4NCg0KDQotLQ0KQ2h1Y2sgTGV2ZXINCg0KDQo=

