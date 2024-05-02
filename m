Return-Path: <linux-nfs+bounces-3130-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 267768B9E4D
	for <lists+linux-nfs@lfdr.de>; Thu,  2 May 2024 18:15:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D40F1F212A1
	for <lists+linux-nfs@lfdr.de>; Thu,  2 May 2024 16:15:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C04915CD72;
	Thu,  2 May 2024 16:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="cGT14Oqb";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="QS50SW3C"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9063B15CD78
	for <linux-nfs@vger.kernel.org>; Thu,  2 May 2024 16:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714666550; cv=fail; b=mh39A9se8PU7W8rfy/frDS/BigJfksUG97l5c9Nu9P2LZ2lDA+py+0VB1inm+t/NxKu1PCpi9Uql/Us/qqTQRFCocSLcIVjUjRN16HLc3hwwbLQFrVu22a74YTsdbh+nUqeouOTJ9EPpfGOVRUq7k2Qlhf02jAU24d0Fq1tMakY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714666550; c=relaxed/simple;
	bh=uuI9h/N3HzB4DZkQHOH6ko0d+s2FVbA0VnK7CEfor8I=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QzQzKDOMF32BgoTcOzuAcwbA8fZxuDMO9D39YRFv/Y2uJBkVe9jnxoMREsw+LJwDRVuzyBezCv8TRU8j1lRZV3dhjwtvCHtw9XM6RWRZ1VJnQ6zCydigCWj2LdWmkatvvefX83EiKyACISgmyYFB85VSUPScWsWwfFkXkPDYyf8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=cGT14Oqb; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=QS50SW3C; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 442FiUkk031946;
	Thu, 2 May 2024 16:15:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=uuI9h/N3HzB4DZkQHOH6ko0d+s2FVbA0VnK7CEfor8I=;
 b=cGT14Oqbt8Co03sN581shc7Uya9qTc9+p/w0v+9gHVBXzQhR7EiRzoitu+TcppbwjUaQ
 YdBRrfoqEQ1WK7zTTjU2oDlaZoglhMl+4ZDllWOurCIgvEjNJrWKwj6Wn3zl2Q4zQ085
 Z8JXuB4NfQ3D5CbzsU1Vu7WRX55Ni7kFcpMLTnwJhAtx1gEDx1uwp/tvoED+GeOk/vjL
 0W0/PIMGg/abAj2hPRRl4cE2s0rygGIkBD1ImB1QvtqhM5mcLWT8hydrIPybmyHJTJza
 vV4wNL6MiekMyTaifTKGRM1p3dxBK55giFjeInLVQSQ3TvSaANECHui0deXa2sURJhxZ FQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xrs8cx033-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 02 May 2024 16:15:40 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 442FjEjX019974;
	Thu, 2 May 2024 16:15:40 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3xrqtanh83-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 02 May 2024 16:15:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fD/VtbrZ1usc+fwLItc0Xt4jOyRFF3mjLQ1WkYwu22lqFji0jwva+lN5onBxU6RS1vSa4CQjv4N5UFiYnCnEQN7XIugpTYjyr+bZaD6eBOSWQ/VVrY8aMt8XXNd3gLCufBPcRI4L38TUXWEMNImmrWwqYEtcGUP2SIC/vcDKABU1fSa51nGALGeTVm5N8JOx0qZqLl58swfcqyuAlgdAkeIuZttbLISvUrF771v7HHgUaQfrwGqgggmP1ra/Pq3dCUwAB3qz0yuu+UpS5XiPzpmAVOeq8SlSCxakWtl/QfaplMpw7AoJPsg6SAzg++GH28QUOsnUkAaVVeY4ftFkYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uuI9h/N3HzB4DZkQHOH6ko0d+s2FVbA0VnK7CEfor8I=;
 b=MNZRFXsLoTRGuW0uOHUuK/pHSlr+gHUTRWGZpYZL0V5+MdyOqGVqEgKjmBh3P7YemPomRlPhfB/qjAZi0lUiQexjMt7LWj4TZyznUWkR99I4yVjv2Rmy3F719j193rBNEyiuHMGhB/dAAqV3ku7p1GQ0V0nbD3ZeaJ06XW2713GhhGBbmGjn8pgZKisYJrL7yrg2cJ2s2K5G/Ewth0lyeUVdp4tWcLyP2t1s8NQdqtx7SyDUNQquzAreUWo4DFbvl02HCtkVvIFOlx/UsSCH36C/PBMZCUdn03aMKSRhNHepTfC97Hzydm2zB03u5rAXP1cHkmbugsxbkIu/M8kDow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uuI9h/N3HzB4DZkQHOH6ko0d+s2FVbA0VnK7CEfor8I=;
 b=QS50SW3C3mHvt7j+YKbRf+8d6/p1n5go3MQC7Tqdd+Lcfb6v0AtUan4hSO5OehgHFiZjWwVFjEjwQcmEFk636VS+v2O343ZP468U7SJnLTpAXlu+IfTAbLf+OX3x7tM431HtnMyxNJShz0/f0pqKPuPVakJfGjt4kvFoNRnePhg=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SJ1PR10MB5932.namprd10.prod.outlook.com (2603:10b6:a03:489::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.32; Thu, 2 May
 2024 16:15:37 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.7544.029; Thu, 2 May 2024
 16:15:36 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Scott Mayhew <smayhew@redhat.com>
CC: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: NFSv3 and xprtsec policies
Thread-Topic: NFSv3 and xprtsec policies
Thread-Index: AQHanKkgYmL3FNy2y0KXK2o88GsYY7GEHpAA
Date: Thu, 2 May 2024 16:15:36 +0000
Message-ID: <100A1A35-2B53-46CA-A448-F82A95CA1EFA@oracle.com>
References: <ZjO3Qwf_G87yNXb2@aion>
In-Reply-To: <ZjO3Qwf_G87yNXb2@aion>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.500.171.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|SJ1PR10MB5932:EE_
x-ms-office365-filtering-correlation-id: 7bba53fc-ba4b-46cf-df9e-08dc6ac31a16
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|366007|1800799015|38070700009;
x-microsoft-antispam-message-info: 
 =?utf-8?B?WEVJTm5nemZ1dG1jc0pKdmRzV0xuNTR6dWFqQmk1UnltOVYxbEk1Nnh2ZUJa?=
 =?utf-8?B?Ty9MVjR0VFBPZWljR1J1TE5ZQU9XcUVnelJLSGFwaFFobjF1elVKWG13M0JX?=
 =?utf-8?B?cjBtMm0xQnZ4Q2E5bElPQndVZXdmVmtaRWEyYmkwOU9pd1dtVFZmVUtRbW9T?=
 =?utf-8?B?VEhNT0VUeis0N1RVSSs3aTU0bS9BT3l3eHFzSzZTYktGcGNNcVhqYkVyME1k?=
 =?utf-8?B?S2tOS2VrK2FGQ0hJV0YwazFzb3d6NTJrdEsxRUJ0aU50c05KQU1Ebkx1UFRZ?=
 =?utf-8?B?ZWEzbkJxTVBxbnNxOGNFUzZ6cTV2aFg4Z05qNDJ5YXZoUm1CS0NzZ2U5ZUJK?=
 =?utf-8?B?VUg5Z0J5NlRSWVlLMmNSWWVHaEl0dGc4a3hsN2NWemhSRmE5WWRtSmpweVJN?=
 =?utf-8?B?MEpJZHNoMG5DRkVyWlErQXpvSFZvSW00dk9sZG9KbEFjWEtpczdJUmdkdnhz?=
 =?utf-8?B?bVMxRk1wV2ZpYWVHaHd3NFU1VUErVFpYZkdJNXBDWis0QkdHMEp3elAvTDhF?=
 =?utf-8?B?SmdCNWphYndzMUxGRXZUZURTemQwQ1RrNzhEU2JHR1pkWUkvU2prV245R1Nj?=
 =?utf-8?B?clFYS01NeFJrTFY1YkdPbkZrSXdKcFFIcEdmRjNjK1pLNldXWHBWbmJQejl1?=
 =?utf-8?B?OTlZUUFnS080MXpDOWVEdkRpcER3MTVOZUZpaHU5VDRWTEFZbEhRSm9ERUl1?=
 =?utf-8?B?WnlTcW5nUDNnTmdLSlFLUTMxNXRHVWxQcXdqYVM4UnJmdVF6c3VSSEZDclJx?=
 =?utf-8?B?SHk4ZUE5cWp2SVdyckVLRFhOcFlhV1lCOHJ1UklTTG5HaGhUUWlhRkhoN09C?=
 =?utf-8?B?R3B0cmgxdUV5VnF2dnNHaDFXK2xYcDNnd2k0azhoenRwdUMvTXR1aUxiSGVE?=
 =?utf-8?B?amhuRVhxMExNSjZuMTJHSWZ0TTB3a2pLblJnc1dxSUJHZU45TVk5eEFoQUMz?=
 =?utf-8?B?djhSc09Ic0xBM2x5Q00yaEhoUDFuL2xMZzJmRUl4ZDd1ZkYrWjBuWVhpbkhG?=
 =?utf-8?B?M3NKUlozYjlHUXJ4QTBxTzVLaTRYdVdZSzNuR0QrcWRjZnZ4MW5tT1FSbmRJ?=
 =?utf-8?B?czhJOG5odi9sRi9yRzdid0RyQ0FEY3E5Qm5KbGltSFRsNjRISUx4ckppcGpC?=
 =?utf-8?B?TTFSckZQTENabFFjeHVQZ1dyK09zWTJPN2pVV2o3T2dRMWVuR3VYcXowMU9S?=
 =?utf-8?B?WGFsdGk5YTVQbU00eFRVN29KOWNhaTA4V2xjMy85WFhmRmZ0UFlrSmFkNStr?=
 =?utf-8?B?Z2UxNWV4VW1Sc21hbVJjNkJpMnJEVHMyYWtpZ05hU2JCaEZHUWFCQndCdU9y?=
 =?utf-8?B?Y3lnYjMzb0hCNFR3L0ZyNHVXY1ArTDhDL2thQ1J4Tlg3dXhsZGhmd1BHbHht?=
 =?utf-8?B?aFY3YWc5cURvTEUzWDdYbVB6bGRoKytvbkZtVi8xeXk2eUkrb1J6dFdKb2dN?=
 =?utf-8?B?WmVMYVc4azJzNXZrWHVzRHg0eXFBZW13TW9VSGlGLytHWFlpczRSRC9qblFZ?=
 =?utf-8?B?WGpRSkdPb0t3MWtQMDVmUjAzYyttNTZyVVc3Wk9nblFsZjBBZDVnL2FkWFl3?=
 =?utf-8?B?Q2lMbzR2Zjd0NW9tWXF2dTNvcjR5SGlqWk9IaGtYcXZvYmpmUS9yb3hEeHNY?=
 =?utf-8?B?RUV2cWVwZjB2NlRLTXFncU42VERJNEl0bm9PdzNMeVNGUlluRG9DaERHa1lR?=
 =?utf-8?B?WmtwaXBmQzltZTRmbENWM2FCbU9ZZWFma1JmTUFBOUFxU2s4TVRwSTdRPT0=?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?cUdwUXZrcjFQUUlLdzZmRkdUTkJubkswTGJDRTdFcGt4OGkzeXdRaVd2WjFj?=
 =?utf-8?B?RlV2RlRzazBJOExNanhmZHU0U2dnT1F3bkZ2S08vMzhqdDUwUk1UaXZFN3RN?=
 =?utf-8?B?c0tpNzRXeDg5ejVFTmVXYTBBcGlZeHVrR3B0NDE4cTMvRDJ6U3QyMGhhNXpQ?=
 =?utf-8?B?VFJQaGpQbmRiUWFhSU1taTZDSnFYaUxKQnFEYkNqN2t3Q2V6a3VSRkJHaVBQ?=
 =?utf-8?B?Z2JMQlBRWVhRMFNQNWRGT0MyeU43TFhGTzBsUkQ3Y21kNWFrK2lPb0FmY2kz?=
 =?utf-8?B?cm5TbWRMKzU3aldkeWIrR29IRXU4MGhwQndxeUFMaDZnQ3ZJMnMvZlNyY0VW?=
 =?utf-8?B?M2JYWHRsMCtFVldDTXh1VmUxMXFuTGl4LzdTVllpQWExakV5Q0FPaUk5Rmxm?=
 =?utf-8?B?T1Z5cnNDOWdiN0FzR3Z4a0tOb0l2WFNWdGJYWnRVQXFFUkpsc1pyMWdzVWlk?=
 =?utf-8?B?OWVxa2JlVUYrL1NDaFZMQmxIVVFyQ0ZQRkJpQXRsM0NvRjl1aThGNXc2Q1Bh?=
 =?utf-8?B?aDc3WjJQbWRLSEp5S3BoQ2ZSOVozM1BxSzZacGE3UmdWck1kRm12L3ZZZyt4?=
 =?utf-8?B?R2FhdjBjOENxWVNvbG1DbmZiYyt0VmR1SllTSVllbHQzNE5jR1Y1cElxZVJi?=
 =?utf-8?B?TlFBZEo1WG5FTlhUZURmaXUvSHIxNURWMVp5ZE1SMWRkMEF2ak9rU0tiVnJR?=
 =?utf-8?B?ekZrcE4rZkIyUXNGcm1wREoya21tYW9hb29iRCsyYjhBZTdrYkM5Uk4yUWJx?=
 =?utf-8?B?VitiQ0ZHNDQvQXhSdExDSDg2dERJVVlRcDhBaEV5ZGpnb2x4c2g3WW1oTkFl?=
 =?utf-8?B?anAzZnZlN3p1b1dGTlQ0ZmtIOTh0eFpHZmphZUpBTlBsSHlTRGpkQlNqOW1l?=
 =?utf-8?B?QUpFbFFCUHRHSllKU2xBcVpLVHV2bEowdW04QnFHZjlaUFNBVUxrL2x1Mmhy?=
 =?utf-8?B?cFV3RGwyQUtIOEM5VE4rbFpUNzBlcnB0RE9sVDZYSzJpMklHZWlla2l2Vzd5?=
 =?utf-8?B?aStBTXR1eWJEeW1KZDBEeHJkMGhDYkNNbmo3UHJTdTd2cVB5V0t4MU5RZ0xZ?=
 =?utf-8?B?Qkw1TzZQTXZIcGdTa0VRVExUakZCeTVIL2hNbkNOVlFFVElSRWlvSURNQ2p6?=
 =?utf-8?B?NlJhK0FrV2JSR2RXN3YvVlU0Z001S2F3RzM5NHZtWnMyS0R4NmpHT0FEaVJ0?=
 =?utf-8?B?Y0pFZjEvYXVQYTJGZDdVS2JrQ0VYZ0luM1lCYU5ZR2ZrczJBSVhhUldob1ly?=
 =?utf-8?B?dExhTGFyL2RJMFZFSmphRGM4NHR3WUdiZFZYakxtSkZYUEtKM0IwOUtkdzhq?=
 =?utf-8?B?d0JEbURkdS9KTGYvQURHb09VcHBEVUhmTWpESW84clZmTHlaSFA3UUNDYklo?=
 =?utf-8?B?Vy93dTA2M1R5VnZFNWI0akoxSFRqSytvRkNCQnR3aVVUZy9RSHFUUHJmcnJ4?=
 =?utf-8?B?Y1F2RVFQTnYwRDlOUm9OSHpaZUtMR3JIaWpWNS9KTGp6RlZXQlhPUmtUNHJm?=
 =?utf-8?B?L0dyWkN1VE5iZGF2ZG9lT05xS3hrYjZqaW9DTUtQbTdSTERhUUxSTHRCY0sx?=
 =?utf-8?B?ZkxZTVpPMU9tWXF2Y1dYTUN4MWdBZnZwYm1xc3R4M2JZV2FEN1Noc2pIK2xw?=
 =?utf-8?B?czhCVWltMFFnTXMvSFlvUTRIVThnVWJ2Z0VTNUtzUy9UbUYzUjRyQjJjT3lQ?=
 =?utf-8?B?R0lDaDQ5U2FRaVRSWStyekxQMEtyUnRRYTV6MGV6SzBVeWZSc29VMXVZeGY5?=
 =?utf-8?B?eGphRG1hcVBHdlRTSGdSRjcvbFBIT2owRHZBUG1XZFd5Wis1VzRyODk1WXQ1?=
 =?utf-8?B?SThtN054ZnNIL0lUMENPOU9jZ2VnMEhudlpHeDJKKzZwRHo3cE9zNllyVFdP?=
 =?utf-8?B?UmJDMDJYYTFzUno0c1FBNWZ3aDh0cWErUUE5UHhKMWh4WEJkS1FyMGNraU5E?=
 =?utf-8?B?bndwam01NllJeVFCN2x1Uk0vRS8vVENHZ1lIbFBnaHhXd3d4bmU5bFgreGMv?=
 =?utf-8?B?L1FWQk9iNzVwKzArUVdlZG1RR1M5dDdHZkQ2SGJpY0lNZWQxT1VFVkNITXlr?=
 =?utf-8?B?WlRlVFlreWQyZVZzdklMRlQ4eTkrWkUzazE1Z0RiS3BialRjQ1JTbEFtWms2?=
 =?utf-8?B?MGkwWDlDalladDVGdW9KNXQ3S0RYSVAyem5xUnIrUlJlUzdtYU0zYXdEYTdq?=
 =?utf-8?B?U2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <51C3D6528DD060438B43638CD36E0A74@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	6ZDIGCJEvQpHv2c5JTS6LkVFbBIXRIvaWEfZZFqjjMWNlQF/Uzl6oeV209rp7MnUevrAUrva8hIX12Cx+jw6bmstd3UWRRg1iIJgDd9kH+QVZXLtMxc40ghUeW4lgt95ZUSUKowlfpTzzbC5MqF/ecMajaOGy1xvK73HHHj7wt0cC2/oX/K46otpKJktGmUY8DlJNSF9/rg/ymP3HVJMLXXS5zITmgF1UiJzSQ9vg5Mo0fu1+RAAu34PcRPNvWwPWiC2od53IGqVb5pel/GpxYGSEwOHcNbWte+tBXbMZwX40WUlk3t1dcOBRr5WDir6Et0ECj9tSYvjFRY86osdD2CnWNuviaxmtQao9I16PjTA/FUDMxeHxEXhDmmxOnK0EutRYWpkcKzis7zTJXG5/nj6CYrmDanQ/qwDYf1Q4nq6KsZJwz14OPepJTTPlczCtCw4PCI74sMcyzH+WfSVawAj56wtF4YY5T3CA3WxcFk5Ykw7xIY1I5QxGvUi31GthGS6/QhPq/xs8QVYG9KWipuN9Z94Wg2z6uu0zh/IlvkH9lYV/SwZJ6omT61UkCSGi5fnJjlL36+Cjaxg9BcGoCkAFfC7Ok+lmL9cCSQkLLs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bba53fc-ba4b-46cf-df9e-08dc6ac31a16
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 May 2024 16:15:36.8130
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XNXTev8hUb9Ng1W6hXDHdtB5MAQUeURscLGk+uesODKX/MwJrxieZKtOaCEMsoYHFExWaLeZwOTpHDdlekXT3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR10MB5932
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-02_08,2024-05-02_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 adultscore=0
 phishscore=0 mlxscore=0 suspectscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2405020106
X-Proofpoint-GUID: yG0YjtyP3fWE1zFXUcHEN6CHNALRsi-Q
X-Proofpoint-ORIG-GUID: yG0YjtyP3fWE1zFXUcHEN6CHNALRsi-Q

DQoNCj4gT24gTWF5IDIsIDIwMjQsIGF0IDExOjU04oCvQU0sIFNjb3R0IE1heWhldyA8c21heWhl
d0ByZWRoYXQuY29tPiB3cm90ZToNCj4gDQo+IFJlZCBIYXQgUUUgaWRlbnRpZmllZCBhbiAiaW50
ZXJlc3RpbmciIGlzc3VlIHdpdGggTkZTdjMgYW5kIFRMUywgaW4gdGhhdCBhbg0KPiBORlN2MyBj
bGllbnQgY2FuIG1vdW50IHdpdGggInhwcnRzZWM9bm9uZSIgYSBmaWxlc3lzdGVtIGV4cG9ydGVk
IHdpdGgNCj4gInhwcnRzZWM9dGxzOm10bHMiIChpbiB0aGUgc2Vuc2UgdGhhdCB0aGUgY2xpZW50
IGdldHMgdGhlIGZpbGVoYW5kbGUgYW5kIGFkZHMgYQ0KPiBtb3VudCB0byBpdHMgbW91bnQgdGFi
bGUgLSBpdCBjYW4ndCBhY3R1YWxseSBhY2Nlc3MgdGhlIG1vdW50KS4NCj4gDQo+IEhlcmUncyBh
biBleGFtcGxlIHVzaW5nIG1hY2hpbmVzIGZyb20gdGhlIHJlY2VudCBCYWtlYXRob24uDQo+IA0K
PiBNb3VudGluZyBhIHNlcnZlciB3aXRoIFRMUyBlbmFibGVkOg0KPiANCj4gIyBtb3VudCAtbyB2
NC4yLHNlYz1zeXMseHBydHNlYz10bHMgb3JhY2xlLTEwMi5jaHVjay5sZXZlci5vcmFjbGUuY29t
Lm5mc3Y0LmRldjovZXhwb3J0L3RscyAvbW50DQo+ICMgdW1vdW50IC9tbnQNCj4gDQo+IFRyeWlu
ZyB0byBtb3VudCB3aXRob3V0ICJ4cHJ0c2VjPXRscyIgc2hvd3MgdGhhdCB0aGUgZmlsZXN5c3Rl
bSBpcyBub3QgZXhwb3J0ZWQgd2l0aCAieHBydHNlYz1ub25lIjoNCj4gDQo+ICMgbW91bnQgLW8g
djQuMixzZWM9c3lzIG9yYWNsZS0xMDIuY2h1Y2subGV2ZXIub3JhY2xlLmNvbS5uZnN2NC5kZXY6
L2V4cG9ydC90bHMgL21udA0KPiBtb3VudC5uZnM6IE9wZXJhdGlvbiBub3QgcGVybWl0dGVkIGZv
ciBvcmFjbGUtMTAyLmNodWNrLmxldmVyLm9yYWNsZS5jb20ubmZzdjQuZGV2Oi9leHBvcnQvdGxz
IG9uIC9tbnQNCj4gDQo+IFlldCBhIHYzIG1vdW50IHdpdGhvdXQgInhwcnRzZWM9dGxzIiB3b3Jr
czoNCj4gDQo+ICMgbW91bnQgLW8gdjMsc2VjPXN5cyBvcmFjbGUtMTAyLmNodWNrLmxldmVyLm9y
YWNsZS5jb20ubmZzdjQuZGV2Oi9leHBvcnQvdGxzIC9tbnQNCj4gIyB1bW91bnQgL21udA0KPiAN
Cj4gYW5kIGEgbW91bnQgd2l0aCBubyBleHBsaWNpdCB2ZXJzaW9uIGFuZCB3aXRob3V0ICJ4cHJ0
c2VjPXRscyIgZmFsbHMgYmFjayB0bw0KPiB2MyBhbmQgYWxzbyAid29ya3MiOg0KPiANCj4gIyBt
b3VudCAtbyBzZWM9c3lzIG9yYWNsZS0xMDIuY2h1Y2subGV2ZXIub3JhY2xlLmNvbS5uZnN2NC5k
ZXY6L2V4cG9ydC90bHMgL21udA0KPiAjIGdyZXAgb3JhIC9wcm9jL21vdW50cw0KPiBvcmFjbGUt
MTAyLmNodWNrLmxldmVyLm9yYWNsZS5jb20ubmZzdjQuZGV2Oi9leHBvcnQvdGxzIC9tbnQgbmZz
DQo+ICtydyxyZWxhdGltZSx2ZXJzPTMscnNpemU9NTI0Mjg4LHdzaXplPTUyNDI4OCxuYW1sZW49
MjU1LGhhcmQscHJvdG89dGNwLHRpbWVvPTYwMCxyZXRyYW5zPTIsc2VjPXN5cyxtb3VudGFkZHI9
MTAwLjY0LjAuNDksbW91bnR2ZXJzPTMsbW91bnRwb3J0PTIwMDQ4LG1vdW50cHJvdG89dWRwLGxv
Y2FsX2xvY2s9bm9uZSxhZGRyPTEwMC42NC4wLjQ5IDAgMA0KPiANCj4gRXZlbiB0aG91Z2ggdGhl
IGZpbGVzeXN0ZW0gaXMgbW91bnRlZCwgdGhlIGNsaWVudCBjYW4ndCBkbyBhbnl0aGluZyB3aXRo
IGl0Og0KPiANCj4gIyBscyAvbW50DQo+IGxzOiBjYW5ub3Qgb3BlbiBkaXJlY3RvcnkgJy9tbnQn
OiBQZXJtaXNzaW9uIGRlbmllZA0KPiANCj4gV2hlbiBrcmI1IGlzIHVzZWQgd2l0aCBORlN2Mywg
dGhlIHNlcnZlciByZXR1cm5zIGEgbGlzdCBvZiBwc2V1ZG9mbGF2b3JzIGluDQo+IG1vdW50cmVz
M19vayAoaHR0cHM6Ly9kYXRhdHJhY2tlci5pZXRmLm9yZy9kb2MvaHRtbC9yZmMxODEzI3NlY3Rp
b24tNS4yLjEpLg0KPiBUaGUgY2xpZW50IGNvbXBhcmVzIHRoYXQgbGlzdCB3aXRoIGl0cyBvd24g
bGlzdCBvZiBhdXRoIGZsYXZvcnMgcGFyc2VkIGZyb20gdGhlDQo+IG1vdW50IHJlcXVlc3QgYW5k
IHJldHVybnMgLUVBQ0NFUyBpZiBubyBtYXRjaCBpcyBmb3VuZCAoc2VlDQo+IG5mc192ZXJpZnlf
YXV0aGZsYXZvcnMoKSkuDQo+IA0KPiBQZXJoYXBzIHdlIHNob3VsZCBiZSBkb2luZyBzb21ldGhp
bmcgc2ltaWxhciB3aXRoIHhwcnRzZWMgcG9saWNpZXM/DQoNClRoZSBwcm9ibGVtIG1pZ2h0IGJl
IGluIGhvdyB5b3UndmUgc2V0IHVwIHRoZSBleHBvcnRzLiBXaXRoIE5GU3YzLA0KdGhlIHBhcmVu
dCBleHBvcnQgbmVlZHMgdGhlICJjcm9zc21udCIgZXhwb3J0IG9wdGlvbiBpbiBvcmRlciBmb3IN
Ck5GU3YzIHRvIGJlaGF2ZSBsaWtlIE5GU3Y0IGluIHRoaXMgcmVnYXJkLCBhbHRob3VnaCBJIGNv
dWxkIGhhdmUNCm1pc3NlZCBzb21ldGhpbmcuDQoNCg0KPiBTaG91bGQNCj4gdGhlcmUgYmUgYW4g
ZXJyYXRhIHRvIFJGQyA5Mjg5IGFuZCBhIHJlcXVlc3QgZnJvbSBJQU5BIGZvciBhc3NpZ25lZCBu
dW1iZXJzIGZvcg0KPiBwc2V1ZG8tZmxhdm9ycyBjb3JyZXNwb25kaW5nIHRvIHhwcnRzZWMgcG9s
aWNpZXM/DQoNCk5vLiBUcmFuc3BvcnQtbGF5ZXIgc2VjdXJpdHkgaXMgbm90IGFuIFJQQyBzZWN1
cml0eSBmbGF2b3Igb3INCnBzZXVkby1mbGF2b3IuIFRoZXNlIHR3byB0aGluZ3MgYXJlIG5vdCBy
ZWxhdGVkLg0KDQooQW5kIGluIGZhY3QsIEkgcHJvcG9zZWQgc29tZXRoaW5nIGxpa2UgdGhpcyBm
b3IgTkZTdjQgU0VDSU5GTywNCmJ1dCBpdCB3YXMgcmVqZWN0ZWQpLg0KDQoNCj4gSWYgbm90LCB0
aGlzIGJlaGF2aW9yIHNob3VsZCBhdCBsZWFzdCBiZSBkb2N1bWVudGVkIGluIHRoZSBtYW4gcGFn
ZXMuDQoNCiJjcm9zc21udCIsIGFuZCBpdCdzIGtpbiAibm9oaWRlIiwgYXJlIGV4cGxhaW5lZCBp
biBleHBvcnRzKDUpLg0KDQoNCi0tDQpDaHVjayBMZXZlcg0KDQoNCg==

