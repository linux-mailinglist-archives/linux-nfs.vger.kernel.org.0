Return-Path: <linux-nfs+bounces-2408-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7945A8806E7
	for <lists+linux-nfs@lfdr.de>; Tue, 19 Mar 2024 22:45:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B98621F22EE0
	for <lists+linux-nfs@lfdr.de>; Tue, 19 Mar 2024 21:45:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81CC14F881;
	Tue, 19 Mar 2024 21:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="C7/MtmFc";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="WQMASBr5"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 137214F889
	for <linux-nfs@vger.kernel.org>; Tue, 19 Mar 2024 21:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710884702; cv=fail; b=f7CoK0WntXab9nA0wSMVEdCznF/MZKvrShceMeJoAkdyyTtzWaGfRrvzN0y9PbEpmcLlnGKuTmUTbZ6bVJVRg3L9nvz6toMwBKS4nTPkaPOayTrd/EgFLHxNTzg80I5LDSWWZeNiXMhrOgSLmLt3+0klopgtUyS3uYXgdItmEiI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710884702; c=relaxed/simple;
	bh=miwsH08Wt6U8ijvADhKN0NoPou1Vxjf/HsRRAZSzSCE=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Ky+oBudrm3L4xFVtg4kJShc521cIauqhBMsKeSjyZkZVlqOU+YBi/Fo/GvvjTLlqxj9yzDqlbrJgeYMHWPx/fs98cB5ac4KWTCJICDR5QI/Ax7vYMC3YLMsccQBt5zm+sQO4NO90s2Etdd3uXD2MEDsxyBLrqUrGeMBoPxtkFDU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=C7/MtmFc; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=WQMASBr5; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42JLEoZO025833;
	Tue, 19 Mar 2024 21:42:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=mxf4DBJ4VhcmPnegIW31KswGRk1q3dpuK2DlymIhaYI=;
 b=C7/MtmFc8zVXbm2VpNfMut0vKFAHXy2LcLiB+DWUNjins9sm8zOWIbWbMEdiV9keLBsH
 xgnWFn0HkJvLbIuvW/OQ4/HXZ5d4k5gzY4NMY4Eo1wf30/agXFRURWjOZMZwg0vFeGsd
 YEt6mZiJyDdxgwZ39WzOlgn2c6jlwmLsVrhqmIpsafUISk+SqpXbvMwqUuHTtzBR2n3k
 bCqL3ii0QKQ9XpRRCzXl4uIawtaUORk1F4kVa16d9FMj87hwdZQBi/13sf0+OjvdBQB5
 yisCy59U/cTiI4z2udHiX9W9b2c+6up0RbJaPtQHZKaOJeKLC7TOmZ3CyHTQ7kYauEU6 hQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ww2bbpqkd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 Mar 2024 21:42:43 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 42JLNjrh028735;
	Tue, 19 Mar 2024 21:42:42 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ww1v6vsc3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 Mar 2024 21:42:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K0tL2n7e2DDLv6c5GrfL99l3kF3ezGk6cwK7LTpXyTim3sVuqZl56Is5mHVIs3Gy3WUriUQoZ0wLAnqEmx5XgVqVSMQLCl4eVhsk17grDHsZWPQJ+HfbfeEQzgy4NDUzMal9pRwh86dpkoTNlJ+/t+j+TMDtluzm2uFoALH57I2GjmgkJ35bjlJcQwc32rO2CVNAcq0ofliifv4nWymG0fY88NTGhPeT6PLx67LQYqdD0HcT9kvLcXtdpF5sRhbCBFlOSYDjVhcLiWOcSwtfM0U/3iIzdX/dUAMS8dGiJDTjLKlePiaWbRKW+ChICkhF56JSHF/3YfWhPXCsH9y81g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mxf4DBJ4VhcmPnegIW31KswGRk1q3dpuK2DlymIhaYI=;
 b=TiebCas5gHvDQnw7ppv/HTYQmF38aLqdBEOGEGtvH9+uiZNA7o2ndkUGG9agsHvu4StdN9VX66O7d/urPLHxmRbC7Bqsk7mpGt4NIXc6SjVYXU09puYR82Jmm5Mlse1nBoSmY92GWtWeEb0x/8kYWhAbH6I75UuxmV7BWgpbxEDiS44GDQvbhNEFMvg07kv4qEU3GoKJyUlpqOMNsFJXcHtTLsnB40EN2HSk0DIFtZOyzZ/D+HtffrZ8+mBWUwep/5p0WqRPIBNCNk5cyMlHxKGnPHIvEMOvIxOgwpLD8vMOD2qHe5yTfEsMNUIVerev4WTneKPlcL0i2PWVfM7hxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mxf4DBJ4VhcmPnegIW31KswGRk1q3dpuK2DlymIhaYI=;
 b=WQMASBr5EQjM1k2OxEgxxuDUxc8vfkD/oimwajo/lw0+T8nCNBRcQq1u8jJ3mxZLNc4n2DoG15cpbf7/7KDH2AgHkQS41KL/w/aTyp6VVSDH8lYycwwagvVRqsY8e3kLyvlzAAmZNABUpOhgdhOUVQ4zyzzg6W8lwTj8fNN/c14=
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by MN6PR10MB7421.namprd10.prod.outlook.com (2603:10b6:208:46e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.30; Tue, 19 Mar
 2024 21:42:38 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::b7ab:75e7:2cf9:efc3]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::b7ab:75e7:2cf9:efc3%3]) with mapi id 15.20.7386.025; Tue, 19 Mar 2024
 21:42:38 +0000
Message-ID: <819fec01-6689-4949-b996-6e36b0b0fb4e@oracle.com>
Date: Tue, 19 Mar 2024 14:42:36 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: nfsd hangs and nfsd_break_deleg_cb+0x170/0x190 warning
Content-Language: en-US
To: Rik Theys <Rik.Theys@esat.kuleuven.be>, Jeff Layton <jlayton@kernel.org>,
        Linux Nfs <linux-nfs@vger.kernel.org>
References: <66c98f4c-5e52-4fa3-8a2c-9379cfec2a9a@esat.kuleuven.be>
 <44c2101e756f7c3b876fb9c58da3ebd089dc14d5.camel@kernel.org>
 <e3ba6e04-ea06-4035-8546-639f11d6b79c@esat.kuleuven.be>
 <41325088-aa6d-4dcf-b105-8994350168c3@esat.kuleuven.be>
 <7d244882d769e377b06f39234bd5ee7dddb72a55.camel@kernel.org>
 <c7dbc796-7e7d-4041-ac71-eea02a701b12@esat.kuleuven.be>
 <50dd9475-b485-4b9b-bcbd-5f7dfabfbac5@oracle.com>
 <d90551d6-a48f-4c25-a2f0-8dbd2b5e5830@esat.kuleuven.be>
From: Dai Ngo <dai.ngo@oracle.com>
In-Reply-To: <d90551d6-a48f-4c25-a2f0-8dbd2b5e5830@esat.kuleuven.be>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR13CA0049.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::24) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4257:EE_|MN6PR10MB7421:EE_
X-MS-Office365-Filtering-Correlation-Id: 73d9c752-beb3-438c-bfa5-08dc485d7f60
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	AMiomDWUZk0sipZoMr28QJrfiY8/MIMUKKZlsc8cXzAznB7vzIfGLHTUwZTwVp915vqY5Sg/4iCO51unq4E+8R2xErXp3wAIuyDVkZqGScZXdukc8cuufUK34KNAGLkPRlmfqgKxLn8VzeRdU8H2oCyqezKC2NWXzhKngA3YyGkmhmUaT8gnW2HairOjdIEPgEMWml8JoBZMxzefaGHTkC6x+5braqjfNfHJx1pO0Yx6tpxAXCvffho3A1VOI5iHsxU30fzIAyYDPkob2+ezMP34rdms8/g9aZ/ypyYkdBuEJhBHcTes96bsrsIqRxGih+52ei6D2ilhydN5GwxYMBbF1e+0kFSlRmHiFoUoctCvCsYLdzKGPtLAl068i2m3uIKT0o+6k17wY4iQj09kwBMWqCblVXczfmxkzF+m5lTyv9oTNRCHevRTnJjCMQ6xL/PItH6R8218fjVsINvUC3w3Q84dqpaDvSHJepOv/eMVhOID9bH+23dGY6LXFGLWgC54E23sZWuY2LstgNZbnE8idb7UuAYSjeU2cZ8quWFqNnjpErDBGzZpVfONQ40Ekd5/juGAqU0zZKhURBB68xsP50az86764w0kUsDQCOuDf7qjRAja9xFSzk/1Sr6y
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?dzBLd3lTS242dlNucHcrUk5DTHdkODFtbzFsU1Q5Qno1TE5tSkpRYjZmcXBZ?=
 =?utf-8?B?T2FhREYrMXVTQjMxejNXM3BXUXBpVGNQZ3lHQ0paMms0SjJwdE9zeGJsRWx6?=
 =?utf-8?B?cll2dEF2d3F3K0tHSDlwSDIzSVFjaWM0OVJaS0hDUkl4VnRtY0M3UHo5elNF?=
 =?utf-8?B?cjY4eWNMcEQxREFCTk9IclcvL3hUbEFEZFM0dFdHWUF1Qytrdm1YVUlBVmlr?=
 =?utf-8?B?L3Q4M0VEV0lUUjNtMkExZFNXYXJ3Nm9zRGhIdkRaKy9RQURIN0I4bGtCWjlL?=
 =?utf-8?B?TlhxUXNlaUp2RUJ2U254ZHBXZmRDNG5MUFYxWmZHYmYrQjZhODA4WGtqNjZo?=
 =?utf-8?B?bEI4UmNMMUU5RjA3R0VxVEp6T2xhMzVpRVphczVJdmUwV1VhWnhnNnEyMVZh?=
 =?utf-8?B?bzQwODF4VGcwTFBFb1FlZnZaZ3d2VVpoYXZWRXU4aUxKT1k5RDRlTkkwSzYr?=
 =?utf-8?B?V1I0aDRzci9MZFBkV3h2cnNQL0ZGcHh2cmNORmxMSE0zbDVWWDJWaHFKK1hD?=
 =?utf-8?B?MWhBS09JNFJHb2NWUC9mT1ExTUhWckFMZ2VtbGhObnA5bnNud1RDelI1VUFl?=
 =?utf-8?B?VWQ2WFRYcjkxcEd2WHhVSmZmQWhnbFRFVEttQVZQTGVXK1FBTlo4czB6eVdM?=
 =?utf-8?B?SkFTbm05eTlwMTAvVmd5STJBb2FNbTBjVDl4eEtxeUd5dVdDcWFlZFphcWda?=
 =?utf-8?B?L3ppd3pUTXJsYjVyYjRBeGQwM1BScHlhRjgxeFlaZ05XNkR5bVQ2a3poNmls?=
 =?utf-8?B?QmErOXN3d2QwSEhxbEtuRk0wdFZxL0ZGNVI3YkNnNEVlVU5KWnJFOGVyYXQ0?=
 =?utf-8?B?WGNpSmZPUmFZOCt5RTFvTnJoNC9Nb2xaZmZNam0vZVpZZi9jaGdubUU5ZGl0?=
 =?utf-8?B?VWFLVzNxODN4K0Z2dWNGK2h2RmpCdnNiZG5meHBiU2d1UlhaemlzRUxPZFJt?=
 =?utf-8?B?UXpQR3I5QWVBNHQzeHl3a0JVb3dIRVpLL3hCbTAza2JDNmY1TkpodVVqaXR1?=
 =?utf-8?B?eEJlMmFBNml6UDBSam1IMXRMRWFsRFVkMFcraFMxb1cxSm45d1ZOemx6S05L?=
 =?utf-8?B?OWpWWEFkaTBseit3cVVCUFF2Y2VEOWJKeWZsdjlsZWlHN0xMQ0VzdER3b0xQ?=
 =?utf-8?B?bVJ3YmxQUzhrcE9JNW9acUhQMHFlRzhoWnBTdGlDR1dnWTBhbE5YaU9vNWYv?=
 =?utf-8?B?b2JqNmtJb3lrMkd1UUc5eDJUcG16Ym9qczRPV1RaMmlwYU9EK1hjcE9rY3JP?=
 =?utf-8?B?TlFFVjFPbFZzRjhWUkhZd2ErOVA2TkdrdEFZMmFPb1hIdGEvL2J0MFpRcGg2?=
 =?utf-8?B?ODREeW9kK1JzRFcxeStTNjZDS3dEUDFFN2wvdmV2R1VMRVVSR0orYW1Icklw?=
 =?utf-8?B?aFM4N1IvVmwxUGs3dkZicHZMRG8xZXdobmZ3TmJNcVZUeHROQkJSV3N6QVZr?=
 =?utf-8?B?bGRxL1F1ZHNCUno1cmY2UWhKcFhGWFg2Rkc5KzloYXBudWh4Y2E5M0JkQUJS?=
 =?utf-8?B?bnZsamZsYkNvYjFFQkliL0pHajJjUE1ENDM2UE1jM205S1BVMyttQ3lPUzla?=
 =?utf-8?B?K0V2VUZFMUswUG1ocXJDS0N1YkxGWHFQMGxScS85dEVXaFlFWXVCMndSRFhi?=
 =?utf-8?B?Yk9xNGtNVFZ0aWg0Q0hFV0txNEdlQ0FhRFhvMWM2cjR3REFGMGE4R3lMbGgv?=
 =?utf-8?B?S1dsNzZpaHVBKzVpbXBrT0VaYy94T2JzTlAwNnJ0VFpXZjBpcTgrUjRGdnNk?=
 =?utf-8?B?VU5BaXRXTUtrOVN4MUJuazM1dU1vZ2ZZNGJUM0N0bWgrMTYyTkJXbi9BdmRR?=
 =?utf-8?B?VjBSV0JiU0FJZ0ttZzc0VVJWZEFkdDJIalNOakZHV0tQVU5wdGpOL1FTYjUx?=
 =?utf-8?B?Z0hsakR5Q3dWbGtjK2RkVGlVVjRTQ0ptMTg0NXMyQkRzSHdjdnp1Rmx1NU96?=
 =?utf-8?B?WWdDN2xYbVI3aHFSMkMzb2Q0VlZ2eXZUa3hHR0dqWkt3SzlGTXFyYWE1ZVpV?=
 =?utf-8?B?LzJxYTlrMEpEZ1FyeEJSTFRkRFJPREdZdWp6WnkvVDBjdW9vRWZOM2F2alBv?=
 =?utf-8?B?QzNIV1cyb2J6N293dXRxL1NGQU1EbkdvT2RsK2l5dVRuNFRWWFlNaEc0QjlI?=
 =?utf-8?Q?qKQFTTYOsAyLMXZCo1RI0qZcy?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	Y/NWLZXE4R4z26Awhz9gvmPF4QYH/NwqN+9hSbYokva7KQUF+KBkz5Omt1BYO076pU0k02qznUm8oZ2/2V/2Bwz4Wdo4sligl7cgg1EOxOgkFuPmhQvVFuCOzn+nNn9lf4Xr4e7x3PW7fTyxDwt51UPlM48uvSaxEgpUmHaDY5hLmjMFzZtwsf0fMMu4dKFegKH/sE2yA3vEY97s6ejbSQvjsNxFM+sgh5Ib0UoVfBuEoqWP+CLP4XgQc/dbRDyV3A1JmebqSqh9n6Y2+ie1qe0UZN/PePnx1tSgKK1OjmAJzbsxziVncpFPkyBh2PfHHhlksMP2L9hvxdSyJfhB+4UPz6fNNNxPKRiOgHRtr9yEnVyY/uyfMgI7lfOHMQoftgtwkmIiEGtlGz6FZ2rt98zMwUoIzOcKDExY+wETkI/EChlOLfrBbPtsisxndgVpZdBNOWTQCCO3K2txl7u/8BCzXuKYYYvSjRVpQ9r2/x8tOHRaGzBIuGlzZZh3XdkhHtM16BytU1l7RRiX+wMK9VY+FY8fR6EtVkCXk2KARRmWtPWKDZ9+VArMP2bi2SS50fI1wYakguKYPJfTK8fRHoH2Zdg2+KmYpflHYgqQmDo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73d9c752-beb3-438c-bfa5-08dc485d7f60
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2024 21:42:38.7422
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Rox4lKFVSJPpQUNWQnHhEDw+evXTWamNMerxrUvf14cEcQB/cguXJ/tyUoQgyHG/M4943TlYjS3wwnIJ4aTYug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR10MB7421
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-19_08,2024-03-18_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 malwarescore=0 spamscore=0 mlxscore=0 phishscore=0 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403140000 definitions=main-2403190168
X-Proofpoint-ORIG-GUID: cyybbXUtboGS0tVNLJJYRK7wdDtQTpMW
X-Proofpoint-GUID: cyybbXUtboGS0tVNLJJYRK7wdDtQTpMW


On 3/19/24 12:41 PM, Rik Theys wrote:
> Hi,
>
> On 3/19/24 18:09, Dai Ngo wrote:
>>
>> On 3/19/24 12:58 AM, Rik Theys wrote:
>>> Hi,
>>>
>>> On 3/18/24 22:54, Jeff Layton wrote:
>>>> On Mon, 2024-03-18 at 22:15 +0100, Rik Theys wrote:
>>>>> Hi,
>>>>>
>>>>> On 3/18/24 21:21, Rik Theys wrote:
>>>>>> Hi Jeff,
>>>>>>
>>>>>> On 3/12/24 13:47, Jeff Layton wrote:
>>>>>>> On Tue, 2024-03-12 at 13:24 +0100, Rik Theys wrote:
>>>>>>>> Hi Jeff,
>>>>>>>>
>>>>>>>> On 3/12/24 12:22, Jeff Layton wrote:
>>>>>>>>> On Mon, 2024-03-11 at 19:43 +0100, Rik Theys wrote:
>>>>>>>>>> Since a few weeks our Rocky Linux 9 NFS server has periodically
>>>>>>>>>> logged hung nfsd tasks. The initial effect was that some clients
>>>>>>>>>> could no longer access the NFS server. This got worse and worse
>>>>>>>>>> (probably as more nfsd threads got blocked) and we had to 
>>>>>>>>>> restart
>>>>>>>>>> the server. Restarting the server also failed as the NFS server
>>>>>>>>>> service could no longer be stopped.
>>>>>>>>>>
>>>>>>>>>> The initial kernel we noticed this behavior on was
>>>>>>>>>> kernel-5.14.0-362.18.1.el9_3.x86_64. Since then we've installed
>>>>>>>>>> kernel-5.14.0-419.el9.x86_64 from CentOS Stream 9. The same 
>>>>>>>>>> issue
>>>>>>>>>> happened again on this newer kernel version:
>>>>>>> 419 is fairly up to date with nfsd changes. There are some known 
>>>>>>> bugs
>>>>>>> around callbacks, and there is a draft MR in flight to fix it.
>>>>>>>
>>>>>>> What kernel were you on prior to 5.14.0-362.18.1.el9_3.x86_64 ? 
>>>>>>> If we
>>>>>>> can bracket the changes around a particular version, then that 
>>>>>>> might
>>>>>>> help identify the problem.
>>>>>>>
>>>>>>>>>> [Mon Mar 11 14:10:08 2024]       Not tainted 
>>>>>>>>>> 5.14.0-419.el9.x86_64 #1
>>>>>>>>>>     [Mon Mar 11 14:10:08 2024] "echo 0 >
>>>>>>>>>> /proc/sys/kernel/hung_task_timeout_secs" disables this message.
>>>>>>>>>>     [Mon Mar 11 14:10:08 2024]task:nfsd            state:D 
>>>>>>>>>> stack:0
>>>>>>>>>>      pid:8865  ppid:2      flags:0x00004000
>>>>>>>>>>     [Mon Mar 11 14:10:08 2024] Call Trace:
>>>>>>>>>>     [Mon Mar 11 14:10:08 2024]  <TASK>
>>>>>>>>>>     [Mon Mar 11 14:10:08 2024]  __schedule+0x21b/0x550
>>>>>>>>>>     [Mon Mar 11 14:10:08 2024]  schedule+0x2d/0x70
>>>>>>>>>>     [Mon Mar 11 14:10:08 2024]  schedule_timeout+0x11f/0x160
>>>>>>>>>>     [Mon Mar 11 14:10:08 2024]  ? select_idle_sibling+0x28/0x430
>>>>>>>>>>     [Mon Mar 11 14:10:08 2024]  ? wake_affine+0x62/0x1f0
>>>>>>>>>>     [Mon Mar 11 14:10:08 2024]  __wait_for_common+0x90/0x1d0
>>>>>>>>>>     [Mon Mar 11 14:10:08 2024]  ? 
>>>>>>>>>> __pfx_schedule_timeout+0x10/0x10
>>>>>>>>>>     [Mon Mar 11 14:10:08 2024]  __flush_workqueue+0x13a/0x3f0
>>>>>>>>>>     [Mon Mar 11 14:10:08 2024] 
>>>>>>>>>>  nfsd4_shutdown_callback+0x49/0x120
>>>>>>>>>> [nfsd]
>>>>>>>>>>     [Mon Mar 11 14:10:08 2024]  ? nfsd4_cld_remove+0x54/0x1d0 
>>>>>>>>>> [nfsd]
>>>>>>>>>>     [Mon Mar 11 14:10:08 2024]  ?
>>>>>>>>>> nfsd4_return_all_client_layouts+0xc4/0xf0 [nfsd]
>>>>>>>>>>     [Mon Mar 11 14:10:08 2024]  ? 
>>>>>>>>>> nfsd4_shutdown_copy+0x68/0xc0 [nfsd]
>>>>>>>>>>     [Mon Mar 11 14:10:08 2024]  __destroy_client+0x1f3/0x290 
>>>>>>>>>> [nfsd]
>>>>>>>>>>     [Mon Mar 11 14:10:08 2024]  nfsd4_exchange_id+0x75f/0x770 
>>>>>>>>>> [nfsd]
>>>>>>>>>>     [Mon Mar 11 14:10:08 2024]  ? 
>>>>>>>>>> nfsd4_decode_opaque+0x3a/0x90 [nfsd]
>>>>>>>>>>     [Mon Mar 11 14:10:08 2024] 
>>>>>>>>>>  nfsd4_proc_compound+0x44b/0x700 [nfsd]
>>>>>>>>>>     [Mon Mar 11 14:10:08 2024]  nfsd_dispatch+0x94/0x1c0 [nfsd]
>>>>>>>>>>     [Mon Mar 11 14:10:08 2024]  svc_process_common+0x2ec/0x660
>>>>>>>>>> [sunrpc]
>>>>>>>>>>     [Mon Mar 11 14:10:08 2024]  ? 
>>>>>>>>>> __pfx_nfsd_dispatch+0x10/0x10 [nfsd]
>>>>>>>>>>     [Mon Mar 11 14:10:08 2024]  ? __pfx_nfsd+0x10/0x10 [nfsd]
>>>>>>>>>>     [Mon Mar 11 14:10:08 2024]  svc_process+0x12d/0x170 [sunrpc]
>>>>>>>>>>     [Mon Mar 11 14:10:08 2024]  nfsd+0x84/0xb0 [nfsd]
>>>>>>>>>>     [Mon Mar 11 14:10:08 2024]  kthread+0xdd/0x100
>>>>>>>>>>     [Mon Mar 11 14:10:08 2024]  ? __pfx_kthread+0x10/0x10
>>>>>>>>>>     [Mon Mar 11 14:10:08 2024]  ret_from_fork+0x29/0x50
>>>>>>>>>>     [Mon Mar 11 14:10:08 2024]  </TASK>
>>>>>>>>>>     [Mon Mar 11 14:10:08 2024] INFO: task nfsd:8866 blocked for
>>>>>>>>>> more than 122 seconds.
>>>>>>>>>>     [Mon Mar 11 14:10:08 2024]       Not tainted
>>>>>>>>>> 5.14.0-419.el9.x86_64 #1
>>>>>>>>>>     [Mon Mar 11 14:10:08 2024] "echo 0 >
>>>>>>>>>> /proc/sys/kernel/hung_task_timeout_secs" disables this message.
>>>>>>>>>>     [Mon Mar 11 14:10:08 2024]task:nfsd            state:D 
>>>>>>>>>> stack:0
>>>>>>>>>>      pid:8866  ppid:2      flags:0x00004000
>>>>>>>>>>     [Mon Mar 11 14:10:08 2024] Call Trace:
>>>>>>>>>>     [Mon Mar 11 14:10:08 2024]  <TASK>
>>>>>>>>>>     [Mon Mar 11 14:10:08 2024]  __schedule+0x21b/0x550
>>>>>>>>>>     [Mon Mar 11 14:10:08 2024]  schedule+0x2d/0x70
>>>>>>>>>>     [Mon Mar 11 14:10:08 2024]  schedule_timeout+0x11f/0x160
>>>>>>>>>>     [Mon Mar 11 14:10:08 2024]  ? select_idle_sibling+0x28/0x430
>>>>>>>>>>     [Mon Mar 11 14:10:08 2024]  ? tcp_recvmsg+0x196/0x210
>>>>>>>>>>     [Mon Mar 11 14:10:08 2024]  ? wake_affine+0x62/0x1f0
>>>>>>>>>>     [Mon Mar 11 14:10:08 2024]  __wait_for_common+0x90/0x1d0
>>>>>>>>>>     [Mon Mar 11 14:10:08 2024]  ? 
>>>>>>>>>> __pfx_schedule_timeout+0x10/0x10
>>>>>>>>>>     [Mon Mar 11 14:10:08 2024]  __flush_workqueue+0x13a/0x3f0
>>>>>>>>>>     [Mon Mar 11 14:10:08 2024] 
>>>>>>>>>>  nfsd4_destroy_session+0x1a4/0x240
>>>>>>>>>> [nfsd]
>>>>>>>>>>     [Mon Mar 11 14:10:08 2024] 
>>>>>>>>>>  nfsd4_proc_compound+0x44b/0x700 [nfsd]
>>>>>>>>>>     [Mon Mar 11 14:10:08 2024]  nfsd_dispatch+0x94/0x1c0 [nfsd]
>>>>>>>>>>     [Mon Mar 11 14:10:08 2024]  svc_process_common+0x2ec/0x660
>>>>>>>>>> [sunrpc]
>>>>>>>>>>     [Mon Mar 11 14:10:08 2024]  ? 
>>>>>>>>>> __pfx_nfsd_dispatch+0x10/0x10 [nfsd]
>>>>>>>>>>     [Mon Mar 11 14:10:08 2024]  ? __pfx_nfsd+0x10/0x10 [nfsd]
>>>>>>>>>>     [Mon Mar 11 14:10:08 2024]  svc_process+0x12d/0x170 [sunrpc]
>>>>>>>>>>     [Mon Mar 11 14:10:08 2024]  nfsd+0x84/0xb0 [nfsd]
>>>>>>>>>>     [Mon Mar 11 14:10:08 2024]  kthread+0xdd/0x100
>>>>>>>>>>     [Mon Mar 11 14:10:08 2024]  ? __pfx_kthread+0x10/0x10
>>>>>>>>>>     [Mon Mar 11 14:10:08 2024]  ret_from_fork+0x29/0x50
>>>>>>>>>>     [Mon Mar 11 14:10:08 2024]  </TASK>
>>>>>>>>>>
>>>>>>>>> The above threads are trying to flush the workqueue, so that 
>>>>>>>>> probably
>>>>>>>>> means that they are stuck waiting on a workqueue job to finish.
>>>>>>>>>>     The above is repeated a few times, and then this warning is
>>>>>>>>>> also logged:
>>>>>>>>>>     [Mon Mar 11 14:12:04 2024] ------------[ cut here 
>>>>>>>>>> ]------------
>>>>>>>>>>     [Mon Mar 11 14:12:04 2024] WARNING: CPU: 39 PID: 8844 at
>>>>>>>>>> fs/nfsd/nfs4state.c:4919 nfsd_break_deleg_cb+0x170/0x190 [nfsd]
>>>>>>>>>>     [Mon Mar 11 14:12:05 2024] Modules linked in: nfsv4
>>>>>>>>>> dns_resolver nfs fscache netfs rpcsec_gss_krb5 rpcrdma rdma_cm
>>>>>>>>>> iw_cm ib_cm ib_core binfmt_misc bonding tls rfkill 
>>>>>>>>>> nft_counter nft_ct
>>>>>>>>>>     nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 nft_reject_inet
>>>>>>>>>> nf_reject_ipv4 nf_reject_ipv6 nft_reject nf_tables nfnetlink 
>>>>>>>>>> vfat
>>>>>>>>>> fat dm_thin_pool dm_persistent_data dm_bio_prison dm_bufio l
>>>>>>>>>>     ibcrc32c dm_service_time dm_multipath intel_rapl_msr
>>>>>>>>>> intel_rapl_common intel_uncore_frequency
>>>>>>>>>> intel_uncore_frequency_common isst_if_common skx_edac nfit
>>>>>>>>>> libnvdimm ipmi_ssif x86_pkg_temp
>>>>>>>>>>     _thermal intel_powerclamp coretemp kvm_intel kvm irqbypass
>>>>>>>>>> dcdbas rapl intel_cstate mgag200 i2c_algo_bit drm_shmem_helper
>>>>>>>>>> dell_smbios drm_kms_helper dell_wmi_descriptor wmi_bmof intel_u
>>>>>>>>>>     ncore syscopyarea pcspkr sysfillrect mei_me sysimgblt 
>>>>>>>>>> acpi_ipmi
>>>>>>>>>> mei fb_sys_fops i2c_i801 ipmi_si intel_pch_thermal lpc_ich
>>>>>>>>>> ipmi_devintf i2c_smbus ipmi_msghandler joydev acpi_power_meter
>>>>>>>>>>     nfsd auth_rpcgss nfs_acl drm lockd grace fuse sunrpc ext4
>>>>>>>>>> mbcache jbd2 sd_mod sg lpfc
>>>>>>>>>>     [Mon Mar 11 14:12:05 2024]  nvmet_fc nvmet nvme_fc 
>>>>>>>>>> nvme_fabrics
>>>>>>>>>> crct10dif_pclmul ahci libahci crc32_pclmul nvme_core 
>>>>>>>>>> crc32c_intel
>>>>>>>>>> ixgbe megaraid_sas libata nvme_common ghash_clmulni_int
>>>>>>>>>>     el t10_pi wdat_wdt scsi_transport_fc mdio wmi dca dm_mirror
>>>>>>>>>> dm_region_hash dm_log dm_mod
>>>>>>>>>>     [Mon Mar 11 14:12:05 2024] CPU: 39 PID: 8844 Comm: nfsd Not
>>>>>>>>>> tainted 5.14.0-419.el9.x86_64 #1
>>>>>>>>>>     [Mon Mar 11 14:12:05 2024] Hardware name: Dell Inc. 
>>>>>>>>>> PowerEdge
>>>>>>>>>> R740/00WGD1, BIOS 2.20.1 09/13/2023
>>>>>>>>>>     [Mon Mar 11 14:12:05 2024] RIP:
>>>>>>>>>> 0010:nfsd_break_deleg_cb+0x170/0x190 [nfsd]
>>>>>>>>>>     [Mon Mar 11 14:12:05 2024] Code: a6 95 c5 f3 e9 ff fe ff 
>>>>>>>>>> ff 48
>>>>>>>>>> 89 df be 01 00 00 00 e8 34 b5 13 f4 48 8d bb 98 00 00 00 e8 
>>>>>>>>>> c8 f9
>>>>>>>>>> 00 00 84 c0 0f 85 2e ff ff ff <0f> 0b e9 27 ff ff ff be
>>>>>>>>>>     02 00 00 00 48 89 df e8 0c b5 13 f4 e9 01
>>>>>>>>>>     [Mon Mar 11 14:12:05 2024] RSP: 0018:ffff9929e0bb7b80 
>>>>>>>>>> EFLAGS:
>>>>>>>>>> 00010246
>>>>>>>>>>     [Mon Mar 11 14:12:05 2024] RAX: 0000000000000000 RBX:
>>>>>>>>>> ffff8ada51930900 RCX: 0000000000000024
>>>>>>>>>>     [Mon Mar 11 14:12:05 2024] RDX: ffff8ada519309c8 RSI:
>>>>>>>>>> ffff8ad582933c00 RDI: 0000000000002000
>>>>>>>>>>     [Mon Mar 11 14:12:05 2024] RBP: ffff8ad46bf21574 R08:
>>>>>>>>>> ffff9929e0bb7b48 R09: 0000000000000000
>>>>>>>>>>     [Mon Mar 11 14:12:05 2024] R10: ffff8aec859a2948 R11:
>>>>>>>>>> 0000000000000000 R12: ffff8ad6f497c360
>>>>>>>>>>     [Mon Mar 11 14:12:05 2024] R13: ffff8ad46bf21560 R14:
>>>>>>>>>> ffff8ae5942e0b10 R15: ffff8ad6f497c360
>>>>>>>>>>     [Mon Mar 11 14:12:05 2024] FS:  0000000000000000(0000)
>>>>>>>>>> GS:ffff8b031fcc0000(0000) knlGS:0000000000000000
>>>>>>>>>>     [Mon Mar 11 14:12:05 2024] CS:  0010 DS: 0000 ES: 0000 CR0:
>>>>>>>>>> 0000000080050033
>>>>>>>>>>     [Mon Mar 11 14:12:05 2024] CR2: 00007fafe2060744 CR3:
>>>>>>>>>> 00000018e58de006 CR4: 00000000007706e0
>>>>>>>>>>     [Mon Mar 11 14:12:05 2024] DR0: 0000000000000000 DR1:
>>>>>>>>>> 0000000000000000 DR2: 0000000000000000
>>>>>>>>>>     [Mon Mar 11 14:12:05 2024] DR3: 0000000000000000 DR6:
>>>>>>>>>> 00000000fffe0ff0 DR7: 0000000000000400
>>>>>>>>>>     [Mon Mar 11 14:12:05 2024] PKRU: 55555554
>>>>>>>>>>     [Mon Mar 11 14:12:05 2024] Call Trace:
>>>>>>>>>>     [Mon Mar 11 14:12:05 2024]  <TASK>
>>>>>>>>>>     [Mon Mar 11 14:12:05 2024]  ? show_trace_log_lvl+0x1c4/0x2df
>>>>>>>>>>     [Mon Mar 11 14:12:05 2024]  ? show_trace_log_lvl+0x1c4/0x2df
>>>>>>>>>>     [Mon Mar 11 14:12:05 2024]  ? __break_lease+0x16f/0x5f0
>>>>>>>>>>     [Mon Mar 11 14:12:05 2024]  ? 
>>>>>>>>>> nfsd_break_deleg_cb+0x170/0x190
>>>>>>>>>> [nfsd]
>>>>>>>>>>     [Mon Mar 11 14:12:05 2024]  ? __warn+0x81/0x110
>>>>>>>>>>     [Mon Mar 11 14:12:05 2024]  ? 
>>>>>>>>>> nfsd_break_deleg_cb+0x170/0x190
>>>>>>>>>> [nfsd]
>>>>>>>>>>     [Mon Mar 11 14:12:05 2024]  ? report_bug+0x10a/0x140
>>>>>>>>>>     [Mon Mar 11 14:12:05 2024]  ? handle_bug+0x3c/0x70
>>>>>>>>>>     [Mon Mar 11 14:12:05 2024]  ? exc_invalid_op+0x14/0x70
>>>>>>>>>>     [Mon Mar 11 14:12:05 2024]  ? asm_exc_invalid_op+0x16/0x20
>>>>>>>>>>     [Mon Mar 11 14:12:05 2024]  ? 
>>>>>>>>>> nfsd_break_deleg_cb+0x170/0x190
>>>>>>>>>> [nfsd]
>>>>>>>>>>     [Mon Mar 11 14:12:05 2024]  __break_lease+0x16f/0x5f0
>>>>>>>>>>     [Mon Mar 11 14:12:05 2024]  ?
>>>>>>>>>> nfsd_file_lookup_locked+0x117/0x160 [nfsd]
>>>>>>>>>>     [Mon Mar 11 14:12:05 2024]  ? list_lru_del+0x101/0x150
>>>>>>>>>>     [Mon Mar 11 14:12:05 2024]  nfsd_file_do_acquire+0x790/0x830
>>>>>>>>>> [nfsd]
>>>>>>>>>>     [Mon Mar 11 14:12:05 2024]  nfs4_get_vfs_file+0x315/0x3a0 
>>>>>>>>>> [nfsd]
>>>>>>>>>>     [Mon Mar 11 14:12:05 2024] 
>>>>>>>>>>  nfsd4_process_open2+0x430/0xa30 [nfsd]
>>>>>>>>>>     [Mon Mar 11 14:12:05 2024]  ? fh_verify+0x297/0x2f0 [nfsd]
>>>>>>>>>>     [Mon Mar 11 14:12:05 2024]  nfsd4_open+0x3ce/0x4b0 [nfsd]
>>>>>>>>>>     [Mon Mar 11 14:12:05 2024] 
>>>>>>>>>>  nfsd4_proc_compound+0x44b/0x700 [nfsd]
>>>>>>>>>>     [Mon Mar 11 14:12:05 2024]  nfsd_dispatch+0x94/0x1c0 [nfsd]
>>>>>>>>>>     [Mon Mar 11 14:12:05 2024]  svc_process_common+0x2ec/0x660
>>>>>>>>>> [sunrpc]
>>>>>>>>>>     [Mon Mar 11 14:12:05 2024]  ? 
>>>>>>>>>> __pfx_nfsd_dispatch+0x10/0x10 [nfsd]
>>>>>>>>>>     [Mon Mar 11 14:12:05 2024]  ? __pfx_nfsd+0x10/0x10 [nfsd]
>>>>>>>>>>     [Mon Mar 11 14:12:05 2024]  svc_process+0x12d/0x170 [sunrpc]
>>>>>>>>>>     [Mon Mar 11 14:12:05 2024]  nfsd+0x84/0xb0 [nfsd]
>>>>>>>>>>     [Mon Mar 11 14:12:05 2024]  kthread+0xdd/0x100
>>>>>>>>>>     [Mon Mar 11 14:12:05 2024]  ? __pfx_kthread+0x10/0x10
>>>>>>>>>>     [Mon Mar 11 14:12:05 2024]  ret_from_fork+0x29/0x50
>>>>>>>>>>     [Mon Mar 11 14:12:05 2024]  </TASK>
>>>>>>>>>>     [Mon Mar 11 14:12:05 2024] ---[ end trace 
>>>>>>>>>> 7a039e17443dc651 ]---
>>>>>>>>> This is probably this WARN in nfsd_break_one_deleg:
>>>>>>>>>
>>>>>>>>> WARN_ON_ONCE(!nfsd4_run_cb(&dp->dl_recall));
>>>>>>>>>
>>>>>>>>> It means that a delegation break callback to the client 
>>>>>>>>> couldn't be
>>>>>>>>> queued to the workqueue, and so it didn't run.
>>>>>>>>>
>>>>>>>>>> Could this be the same issue as described
>>>>>>>>>> here:https://urldefense.com/v3/__https://lore.kernel.org/linux-nfs/af0ec881-5ebf-4feb-98ae-3ed2a77f86f1@oracle.com/__;!!ACWV5N9M2RV99hQ!LV3yWeoSOhNAkRHkxFCH2tlm0iNFVD78mxnSLyP6lrX7yBVeA2TOJ4nv6oZsqLwP4kW56CMpDWhkjjwSkdBV9En7$ 
>>>>>>>>>> ?
>>>>>>>>> Yes, most likely the same problem.
>>>>>>>> If I read that thread correctly, this issue was introduced between
>>>>>>>> 6.1.63 and 6.6.3? Is it possible the EL9 5.14.0-362.18.1.el9_3
>>>>>>>> backported these changes, or were we hitting some other bug 
>>>>>>>> with that
>>>>>>>> version? It seems the 6.1.x kernel is not affected? If so, that
>>>>>>>> would be
>>>>>>>> the recommended kernel to run?
>>>>>>> Anything is possible. We have to identify the problem first.
>>>>>>>>>> As described in that thread, I've tried to obtain the requested
>>>>>>>>>> information.
>>>>>>>>>>
>>>>>>>>>> Is it possible this is the issue that was fixed by the patches
>>>>>>>>>> described
>>>>>>>>>> here?https://urldefense.com/v3/__https://lore.kernel.org/linux-nfs/2024022054-cause-suffering-eae8@gregkh/__;!!ACWV5N9M2RV99hQ!LV3yWeoSOhNAkRHkxFCH2tlm0iNFVD78mxnSLyP6lrX7yBVeA2TOJ4nv6oZsqLwP4kW56CMpDWhkjjwSkedtUP09$ 
>>>>>>>>>>
>>>>>>>>> Doubtful. Those are targeted toward a different set of issues.
>>>>>>>>>
>>>>>>>>> If you're willing, I do have some patches queued up for CentOS 
>>>>>>>>> here
>>>>>>>>> that
>>>>>>>>> fix some backchannel problems that could be related. I'm mainly
>>>>>>>>> waiting
>>>>>>>>> on Chuck to send these to Linus and then we'll likely merge 
>>>>>>>>> them into
>>>>>>>>> CentOS soon afterward:
>>>>>>>>>
>>>>>>>>> https://urldefense.com/v3/__https://gitlab.com/redhat/centos-stream/src/kernel/centos-stream-9/-/merge_requests/3689__;!!ACWV5N9M2RV99hQ!LV3yWeoSOhNAkRHkxFCH2tlm0iNFVD78mxnSLyP6lrX7yBVeA2TOJ4nv6oZsqLwP4kW56CMpDWhkjjwSkdvDn8y7$ 
>>>>>>>>>
>>>>>>>>>
>>>>>>>> If you can send me a patch file, I can rebuild the C9S kernel 
>>>>>>>> with that
>>>>>>>> patch and run it. It can take a while for the bug to trigger as I
>>>>>>>> believe it seems to be very workload dependent (we were running 
>>>>>>>> very
>>>>>>>> stable for months and now hit this bug every other week).
>>>>>>>>
>>>>>>>>
>>>>>>> It's probably simpler to just pull down the build artifacts for 
>>>>>>> that MR.
>>>>>>> You have to drill down through the CI for it, but they are here:
>>>>>>>
>>>>>>> https://urldefense.com/v3/__https://s3.amazonaws.com/arr-cki-prod-trusted-artifacts/index.html?prefix=trusted-artifacts*1194300175*publish_x86_64*6278921877*artifacts*__;Ly8vLy8!!ACWV5N9M2RV99hQ!LV3yWeoSOhNAkRHkxFCH2tlm0iNFVD78mxnSLyP6lrX7yBVeA2TOJ4nv6oZsqLwP4kW56CMpDWhkjjwSkaP5eW8V$ 
>>>>>>>
>>>>>>>
>>>>>>> There's even a repo file you can install on the box to pull them 
>>>>>>> down.
>>>>>> We installed this kernel on the server 3 days ago. Today, a user
>>>>>> informed us that their screen was black after logging in. Similar to
>>>>>> other occurrences of this issue, the mount command on the client was
>>>>>> hung. But in contrast to the other times, there were no messages in
>>>>>> the logs kernel logs on the server. Even restarting the client does
>>>>>> not resolve the issue.
>>>>
>>>> Ok, so you rebooted the client and it's still unable to mount? That
>>>> sounds like a server problem if so.
>>>>
>>>> Are both client and server running the same kernel?
>>> No, the server runs 5.14.0-427.3689_1194299994.el9 and the client 
>>> 5.14.0-362.18.1.el9_3.
>>>>
>>>>>> Something still seems to be wrong on the server though. When I 
>>>>>> look at
>>>>>> the directories under /proc/fs/nfsd/clients, there's still a 
>>>>>> directory
>>>>>> for the specific client, even though it's no longer running:
>>>>>>
>>>>>> # cat 155/info
>>>>>> clientid: 0xc8edb7f65f4a9ad
>>>>>> address: "10.87.31.152:819"
>>>>>> status: confirmed
>>>>>> seconds from last renew: 33163
>>>>>> name: "Linux NFSv4.2 bersalis.esat.kuleuven.be"
>>>>>> minor version: 2
>>>>>> Implementation domain: "kernel.org"
>>>>>> Implementation name: "Linux 5.14.0-362.18.1.el9_3.0.1.x86_64 #1 SMP
>>>>>> PREEMPT_DYNAMIC Sun Feb 11 13:49:23 UTC 2024 x86_64"
>>>>>> Implementation time: [0, 0]
>>>>>> callback state: DOWN
>>>>>> callback address: 10.87.31.152:0
>>>>>>
>>>> If you just shut down the client, the server won't immediately 
>>>> purge its
>>>> record. In fact, assuming you're running the same kernel on the 
>>>> server,
>>>> it won't purge the client record until there is a conflicting request
>>>> for its state.
>>> Is there a way to force such a conflicting request (to get the 
>>> client record to purge)?
>>
>> Try:
>>
>> # echo "expire" > /proc/fs/nfsd/clients/155/ctl
>
> I've tried that. The command hangs and can not be interrupted with 
> ctrl-c.
> I've now also noticed in the dmesg output that the kernel issued the 
> following WARNING a few hours ago. It wasn't directly triggered by the 
> echo command above, but seems to have been triggered a few hours ago 
> (probably when another client started to have the same problem as more 
> clients are experiencing issues now).

I think this warning message is harmless. However it indicates potential
problem with the workqueue which might be related to memory shortage.

What the output of 'cat /proc/meminfo' looks like?

Did you try 'echo 3 > /proc/sys/vm/drop_caches'?

>
> [Tue Mar 19 14:53:44 2024] ------------[ cut here ]------------
> [Tue Mar 19 14:53:44 2024] WARNING: CPU: 44 PID: 5843 at 
> fs/nfsd/nfs4state.c:4920 nfsd_break_deleg_cb+0x170/0x190 [nfsd]
> [Tue Mar 19 14:53:44 2024] Modules linked in: nf_conntrack_netlink 
> nfsv4 dns_resolver nfs fscache netfs binfmt_misc xsk_diag 
> rpcsec_gss_krb5 rpcrdma rdma_cm iw_cm ib_cm ib_core bonding tls rfkill 
> nft_counter nft_ct nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 
> nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_reject nf_tables 
> nfnetlink vfat fat dm_thin_pool dm_persistent_data dm_bio_prison 
> dm_bufio libcrc32c dm_service_time dm_multipath intel_rapl_msr 
> intel_rapl_common intel_uncore_frequency intel_uncore_frequency_common 
> isst_if_common skx_edac nfit libnvdimm x86_pkg_temp_thermal 
> intel_powerclamp coretemp kvm_intel kvm dcdbas irqbypass ipmi_ssif 
> rapl intel_cstate mgag200 i2c_algo_bit drm_shmem_helper drm_kms_helper 
> dell_smbios syscopyarea intel_uncore sysfillrect wmi_bmof 
> dell_wmi_descriptor pcspkr sysimgblt fb_sys_fops mei_me i2c_i801 mei 
> intel_pch_thermal acpi_ipmi i2c_smbus lpc_ich ipmi_si ipmi_devintf 
> ipmi_msghandler joydev acpi_power_meter nfsd nfs_acl lockd auth_rpcgss 
> grace drm fuse sunrpc ext4
> [Tue Mar 19 14:53:44 2024]  mbcache jbd2 sd_mod sg lpfc nvmet_fc nvmet 
> nvme_fc nvme_fabrics crct10dif_pclmul crc32_pclmul nvme_core ixgbe 
> crc32c_intel ahci libahci nvme_common megaraid_sas t10_pi 
> ghash_clmulni_intel wdat_wdt libata scsi_transport_fc mdio dca wmi 
> dm_mirror dm_region_hash dm_log dm_mod
> [Tue Mar 19 14:53:44 2024] CPU: 44 PID: 5843 Comm: nfsd Not tainted 
> 5.14.0-427.3689_1194299994.el9.x86_64 #1
> [Tue Mar 19 14:53:44 2024] Hardware name: Dell Inc. PowerEdge 
> R740/00WGD1, BIOS 2.20.1 09/13/2023
> [Tue Mar 19 14:53:44 2024] RIP: 0010:nfsd_break_deleg_cb+0x170/0x190 
> [nfsd]
> [Tue Mar 19 14:53:44 2024] Code: 76 76 cd de e9 ff fe ff ff 48 89 df 
> be 01 00 00 00 e8 34 a1 1b df 48 8d bb 98 00 00 00 e8 a8 fe 00 00 84 
> c0 0f 85 2e ff ff ff <0f> 0b e9 27 ff ff ff be 02 00 00 00 48 89 df e8 
> 0c a1 1b df e9 01
> [Tue Mar 19 14:53:44 2024] RSP: 0018:ffffb2878f2cfc38 EFLAGS: 00010246
> [Tue Mar 19 14:53:44 2024] RAX: 0000000000000000 RBX: ffff88d5171067b8 
> RCX: 0000000000000000
> [Tue Mar 19 14:53:44 2024] RDX: ffff88d517106880 RSI: ffff88bdceec8600 
> RDI: 0000000000002000
> [Tue Mar 19 14:53:44 2024] RBP: ffff88d68a38a284 R08: ffffb2878f2cfc00 
> R09: 0000000000000000
> [Tue Mar 19 14:53:44 2024] R10: ffff88bf57dd7878 R11: 0000000000000000 
> R12: ffff88d5b79c4798
> [Tue Mar 19 14:53:44 2024] R13: ffff88d68a38a270 R14: ffff88cab06ad0c8 
> R15: ffff88d5b79c4798
> [Tue Mar 19 14:53:44 2024] FS:  0000000000000000(0000) 
> GS:ffff88d4a1180000(0000) knlGS:0000000000000000
> [Tue Mar 19 14:53:44 2024] CS:  0010 DS: 0000 ES: 0000 CR0: 
> 0000000080050033
> [Tue Mar 19 14:53:44 2024] CR2: 00007fe46ef90000 CR3: 000000019d010004 
> CR4: 00000000007706e0
> [Tue Mar 19 14:53:44 2024] DR0: 0000000000000000 DR1: 0000000000000000 
> DR2: 0000000000000000
> [Tue Mar 19 14:53:44 2024] DR3: 0000000000000000 DR6: 00000000fffe0ff0 
> DR7: 0000000000000400
> [Tue Mar 19 14:53:44 2024] PKRU: 55555554
> [Tue Mar 19 14:53:44 2024] Call Trace:
> [Tue Mar 19 14:53:44 2024]  <TASK>
> [Tue Mar 19 14:53:44 2024]  ? show_trace_log_lvl+0x1c4/0x2df
> [Tue Mar 19 14:53:44 2024]  ? show_trace_log_lvl+0x1c4/0x2df
> [Tue Mar 19 14:53:44 2024]  ? __break_lease+0x16f/0x5f0
> [Tue Mar 19 14:53:44 2024]  ? nfsd_break_deleg_cb+0x170/0x190 [nfsd]
> [Tue Mar 19 14:53:44 2024]  ? __warn+0x81/0x110
> [Tue Mar 19 14:53:44 2024]  ? nfsd_break_deleg_cb+0x170/0x190 [nfsd]
> [Tue Mar 19 14:53:44 2024]  ? report_bug+0x10a/0x140
> [Tue Mar 19 14:53:44 2024]  ? handle_bug+0x3c/0x70
> [Tue Mar 19 14:53:44 2024]  ? exc_invalid_op+0x14/0x70
> [Tue Mar 19 14:53:44 2024]  ? asm_exc_invalid_op+0x16/0x20
> [Tue Mar 19 14:53:44 2024]  ? nfsd_break_deleg_cb+0x170/0x190 [nfsd]
> [Tue Mar 19 14:53:44 2024]  ? nfsd_break_deleg_cb+0x96/0x190 [nfsd]
> [Tue Mar 19 14:53:44 2024]  __break_lease+0x16f/0x5f0
> [Tue Mar 19 14:53:44 2024]  nfs4_get_vfs_file+0x164/0x3a0 [nfsd]
> [Tue Mar 19 14:53:44 2024]  nfsd4_process_open2+0x430/0xa30 [nfsd]
> [Tue Mar 19 14:53:44 2024]  ? fh_verify+0x297/0x2f0 [nfsd]
> [Tue Mar 19 14:53:44 2024]  nfsd4_open+0x3ce/0x4b0 [nfsd]
> [Tue Mar 19 14:53:44 2024]  nfsd4_proc_compound+0x44b/0x700 [nfsd]
> [Tue Mar 19 14:53:44 2024]  nfsd_dispatch+0x94/0x1c0 [nfsd]
> [Tue Mar 19 14:53:44 2024]  svc_process_common+0x2ec/0x660 [sunrpc]
> [Tue Mar 19 14:53:44 2024]  ? __pfx_nfsd_dispatch+0x10/0x10 [nfsd]
> [Tue Mar 19 14:53:44 2024]  ? __pfx_nfsd+0x10/0x10 [nfsd]
> [Tue Mar 19 14:53:44 2024]  svc_process+0x12d/0x170 [sunrpc]
> [Tue Mar 19 14:53:44 2024]  nfsd+0x84/0xb0 [nfsd]
> [Tue Mar 19 14:53:44 2024]  kthread+0xdd/0x100
> [Tue Mar 19 14:53:44 2024]  ? __pfx_kthread+0x10/0x10
> [Tue Mar 19 14:53:44 2024]  ret_from_fork+0x29/0x50
> [Tue Mar 19 14:53:44 2024]  </TASK>
> [Tue Mar 19 14:53:44 2024] ---[ end trace ed0b2b3f135c637d ]---
>
> It again seems to have been triggered in nfsd_break_deleg_cb?
>
> I also had the following perf command running a tmux on the server:
>
> perf trace -e nfsd:nfsd_cb_recall_any
>
> This has spewed a lot of messages. I'm including a short list here:
>
> ...
>
> 33464866.721 kworker/u98:5/1591466 nfsd:nfsd_cb_recall_any(cl_boot: 
> 1710533037, cl_id: 210688785, bmval0: 1, addr: 0x7f331bb116c8)
> 33464866.724 kworker/u98:5/1591466 nfsd:nfsd_cb_recall_any(cl_boot: 
> 1710533037, cl_id: 210688827, bmval0: 1, addr: 0x7f331bb11738)
> 33464866.729 kworker/u98:5/1591466 nfsd:nfsd_cb_recall_any(cl_boot: 
> 1710533037, cl_id: 210688767, bmval0: 1, addr: 0x7f331bb117a8)
> 33464866.732 kworker/u98:5/1591466 nfsd:nfsd_cb_recall_any(cl_boot: 
> 1710533037, cl_id: 210718132, bmval0: 1, addr: 0x7f331bb11818)
> 33464866.737 kworker/u98:5/1591466 nfsd:nfsd_cb_recall_any(cl_boot: 
> 1710533037, cl_id: 210688952, bmval0: 1, addr: 0x7f331bb11888)
> 33464866.741 kworker/u98:5/1591466 nfsd:nfsd_cb_recall_any(cl_boot: 
> 1710533037, cl_id: 210702355, bmval0: 1, addr: 0x7f331bb118f8)
> 33868414.001 kthreadd/1597068 nfsd:nfsd_cb_recall_any(cl_boot: 
> 1710533037, cl_id: 210688751, bmval0: 1, addr: 0x7f331be68620)
> 33868414.014 kthreadd/1597068 nfsd:nfsd_cb_recall_any(cl_boot: 
> 1710533037, cl_id: 210718536, bmval0: 1, addr: 0x7f331be68690)
> 33868414.018 kthreadd/1597068 nfsd:nfsd_cb_recall_any(cl_boot: 
> 1710533037, cl_id: 210719074, bmval0: 1, addr: 0x7f331be68700)
> 33868414.022 kthreadd/1597068 nfsd:nfsd_cb_recall_any(cl_boot: 
> 1710533037, cl_id: 210688916, bmval0: 1, addr: 0x7f331be68770)
> 33868414.026 kthreadd/1597068 nfsd:nfsd_cb_recall_any(cl_boot: 
> 1710533037, cl_id: 210688941, bmval0: 1, addr: 0x7f331be687e0)
> ...
>
> 33868414.924 kthreadd/1597068 nfsd:nfsd_cb_recall_any(cl_boot: 
> 1710533037, cl_id: 210688744, bmval0: 1, addr: 0x7f331be6d7f0)
> 33868414.929 kthreadd/1597068 nfsd:nfsd_cb_recall_any(cl_boot: 
> 1710533037, cl_id: 210717223, bmval0: 1, addr: 0x7f331be6d860)
> 33868414.934 kthreadd/1597068 nfsd:nfsd_cb_recall_any(cl_boot: 
> 1710533037, cl_id: 210716137, bmval0: 1, addr: 0x7f331be6d8d0)
> 34021240.903 kworker/u98:5/1591466 nfsd:nfsd_cb_recall_any(cl_boot: 
> 1710533037, cl_id: 210688941, bmval0: 1, addr: 0x7f331c207de8)
> 34021240.917 kworker/u98:5/1591466 nfsd:nfsd_cb_recall_any(cl_boot: 
> 1710533037, cl_id: 210718750, bmval0: 1, addr: 0x7f331c207e58)
> 34021240.922 kworker/u98:5/1591466 nfsd:nfsd_cb_recall_any(cl_boot: 
> 1710533037, cl_id: 210688955, bmval0: 1, addr: 0x7f331c207ec8)
> 34021240.925 kworker/u98:5/1591466 nfsd:nfsd_cb_recall_any(cl_boot: 
> 1710533037, cl_id: 210688975, bmval0: 1, addr: 0x7f331c207f38)
> ...
>
> I assume the cl_id is the client id? How can I map this to a client 
> from /proc/fs/nfsd/clients?

The hex value of 'clientid' printed from /proc/fs/nfsd/clients/XX/info
is a 64-bit value composed of:

typedef struct {
         u32             cl_boot;
         u32             cl_id;
} clientid_t

For example:

clientid: 0xc8edb7f65f4a9ad

cl_boot:  65f4a9add (1710533037)
cl_id:      c8edb7f (21068895)

This should match a trace event with:

nfsd:nfsd_cb_recall_any(cl_boot: 1710533037, cl_id: 21068895, bmval0: XX, addr: 0xYYYYY)

>
> If I understand it correctly, the recall_any should be called when 
> either the system starts to experience memory pressure,

yes.

> or it reaches the delegation limits?

No, this feature was added to nfsd very recently. I don't think your kernel has it.

> I doubt the system is actually running out of memory here as there are 
> no other indications.
> Shouldn't I get those "page allocation failure" messages if it does? 
> How can I check the number of delegations/leases currently issued,
> what the current maximum is and how to increase it?

Max delegations is 4 per 1MB of available memory. There is no
admin tool to adjust this value.

I do not recommend running a production system with delegation
disabled. But for this specific issue, it might help to temporarily
disable delegation to isolate problem areas.

-Dai

>
> Regarding the recall any call: from what I've read on kernelnewbies, 
> this feature was introduced in the 6.2 kernel? When I look at the tree 
> for 6.1.x, it was backported in 6.1.81? Is there a way to disable this 
> support somehow?
>
> Regards,
>
> Rik
>
>
>>
>> -Dai
>>
>>>>
>>>>
>>>>> The nfsdclnts command for this client shows the following 
>>>>> delegations:
>>>>>
>>>>> # nfsdclnts -f 155/states -t all
>>>>> Inode number | Type   | Access | Deny | ip address | Filename
>>>>> 169346743    | open   | r-     | --   | 10.87.31.152:819 |
>>>>> disconnected dentry
>>>>> 169346743    | deleg  | r      |      | 10.87.31.152:819 |
>>>>> disconnected dentry
>>>>> 169346746    | open   | r-     | --   | 10.87.31.152:819 |
>>>>> disconnected dentry
>>>>> 169346746    | deleg  | r      |      | 10.87.31.152:819 |
>>>>> disconnected dentry
>>>>>
>>>>> I see a lot of recent patches regarding directory delegations. Could
>>>>> this be related to this?
>>>>>
>>>>> Will a 5.14.0-362.18.1.el9_3.0.1 kernel try to use a directory 
>>>>> delegation?
>>>>>
>>>>>
>>>> No. Directory delegations are a new feature that's still under
>>>> development. They use some of the same machinery as file delegations,
>>>> but they wouldn't be a factor here.
>>>>
>>>>>> The system seems to have identified that the client is no longer
>>>>>> reachable, but the client entry does not go away. When a mount was
>>>>>> hanging on the client, there would be two directories in clients for
>>>>>> the same client. Killing the mount command clears up the second 
>>>>>> entry.
>>>>>>
>>>>>> Even after running conntrack -D on the server to remove the tcp
>>>>>> connection from the conntrack table, the entry doesn't go away 
>>>>>> and the
>>>>>> client still can not mount anything from the server.
>>>>>>
>>>>>> A tcpdump on the client while a mount was running logged the 
>>>>>> following
>>>>>> messages over and over again:
>>>>>>
>>>>>> request:
>>>>>>
>>>>>> Frame 1: 378 bytes on wire (3024 bits), 378 bytes captured (3024 
>>>>>> bits)
>>>>>> Ethernet II, Src: HP_19:7d:4b (e0:73:e7:19:7d:4b), Dst:
>>>>>> ArubaaHe_f9:8e:00 (88:3a:30:f9:8e:00)
>>>>>> Internet Protocol Version 4, Src: 10.87.31.152, Dst: 10.86.18.14
>>>>>> Transmission Control Protocol, Src Port: 932, Dst Port: 2049, 
>>>>>> Seq: 1,
>>>>>> Ack: 1, Len: 312
>>>>>> Remote Procedure Call, Type:Call XID:0x1d3220c4
>>>>>> Network File System
>>>>>>      [Program Version: 4]
>>>>>>      [V4 Procedure: COMPOUND (1)]
>>>>>>      GSS Data, Ops(1): CREATE_SESSION
>>>>>>          Length: 152
>>>>>>          GSS Sequence Number: 76
>>>>>>          Tag: <EMPTY>
>>>>>>          minorversion: 2
>>>>>>          Operations (count: 1): CREATE_SESSION
>>>>>>          [Main Opcode: CREATE_SESSION (43)]
>>>>>>      GSS Checksum:
>>>>>> 00000028040404ffffffffff000000002c19055f1f8d442d594c13849628affc2797cbb2… 
>>>>>>
>>>>>>          GSS Token Length: 40
>>>>>>          GSS-API Generic Security Service Application Program 
>>>>>> Interface
>>>>>>              krb5_blob:
>>>>>> 040404ffffffffff000000002c19055f1f8d442d594c13849628affc2797cbb23fa080b0… 
>>>>>>
>>>>>>
>>>>>> response:
>>>>>>
>>>>>> Frame 2: 206 bytes on wire (1648 bits), 206 bytes captured (1648 
>>>>>> bits)
>>>>>> Ethernet II, Src: ArubaaHe_f9:8e:00 (88:3a:30:f9:8e:00), Dst:
>>>>>> HP_19:7d:4b (e0:73:e7:19:7d:4b)
>>>>>> Internet Protocol Version 4, Src: 10.86.18.14, Dst: 10.87.31.152
>>>>>> Transmission Control Protocol, Src Port: 2049, Dst Port: 932, 
>>>>>> Seq: 1,
>>>>>> Ack: 313, Len: 140
>>>>>> Remote Procedure Call, Type:Reply XID:0x1d3220c4
>>>>>> Network File System
>>>>>>      [Program Version: 4]
>>>>>>      [V4 Procedure: COMPOUND (1)]
>>>>>>      GSS Data, Ops(1): CREATE_SESSION(NFS4ERR_DELAY)
>>>>>>          Length: 24
>>>>>>          GSS Sequence Number: 76
>>>>>>          Status: NFS4ERR_DELAY (10008)
>>>>>>          Tag: <EMPTY>
>>>>>>          Operations (count: 1)
>>>>>>          [Main Opcode: CREATE_SESSION (43)]
>>>>>>      GSS Checksum:
>>>>>> 00000028040405ffffffffff000000000aa742d0798deaad1a8aa2d7c3a91bf4f6274222… 
>>>>>>
>>>>>>          GSS Token Length: 40
>>>>>>          GSS-API Generic Security Service Application Program 
>>>>>> Interface
>>>>>>              krb5_blob:
>>>>>> 040405ffffffffff000000000aa742d0798deaad1a8aa2d7c3a91bf4f627422226d74923… 
>>>>>>
>>>>>>
>>>>>> I was hoping that giving the client a different IP address would
>>>>>> resolve the issue for this client, but it didn't. Even though the
>>>>>> client had a new IP address (hostname was kept the same), it 
>>>>>> failed to
>>>>>> mount anything from the server.
>>>>>>
>>>> Changing the IP address won't help. The client is probably using the
>>>> same long-form client id as before, so the server still identifies the
>>>> client even with the address change.
>>> How is the client id determined? Will changing the hostname of the 
>>> client trigger a change of the client id?
>>>>
>>>> Unfortunately, the cause of an NFS4ERR_DELAY error is tough to guess.
>>>> The client is expected to back off and retry, so if the server keeps
>>>> returning that repeatedly, then a hung mount command is expected.
>>>>
>>>> The question is why the server would keep returning DELAY. A lot of
>>>> different problems ranging from memory allocation issues to protocol
>>>> problems can result in that error. You may want to check the NFS 
>>>> server
>>>> and see if anything was logged there.
>>> There are no messages in the system logs that indicate any sort of 
>>> memory issue. We also increased the min_kbytes_free sysctl to 2G on 
>>> the server before we restarted it with the newer kernel.
>>>>
>>>> This is on a CREATE_SESSION call, so I wonder if the record held by 
>>>> the
>>>> (courteous) server is somehow blocking the attempt to reestablish the
>>>> session?
>>>>
>>>> Do you have a way to reproduce this? Since this is a centos kernel, 
>>>> you
>>>> could follow the page here to open a bug:
>>>
>>> Unfortunately we haven't found a reliable way to reproduce it. But 
>>> we do seem to trigger it more and more lately.
>>>
>>> Regards,
>>>
>>> Rik
>>>
>>>>
>>>> https://urldefense.com/v3/__https://wiki.centos.org/ReportBugs.html__;!!ACWV5N9M2RV99hQ!LV3yWeoSOhNAkRHkxFCH2tlm0iNFVD78mxnSLyP6lrX7yBVeA2TOJ4nv6oZsqLwP4kW56CMpDWhkjjwSkWIqsboq$ 
>>>>
>>>>
>>>>>> I created another dump of the workqueues and worker pools on the 
>>>>>> server:
>>>>>>
>>>>>> [Mon Mar 18 14:59:33 2024] Showing busy workqueues and worker pools:
>>>>>> [Mon Mar 18 14:59:33 2024] workqueue events: flags=0x0
>>>>>> [Mon Mar 18 14:59:33 2024]   pwq 54: cpus=27 node=1 flags=0x0 nice=0
>>>>>> active=1/256 refcnt=2
>>>>>> [Mon Mar 18 14:59:33 2024]     pending: drm_fb_helper_damage_work
>>>>>> [drm_kms_helper]
>>>>>> [Mon Mar 18 14:59:33 2024] workqueue events_power_efficient: 
>>>>>> flags=0x80
>>>>>> [Mon Mar 18 14:59:33 2024]   pwq 54: cpus=27 node=1 flags=0x0 nice=0
>>>>>> active=1/256 refcnt=2
>>>>>> [Mon Mar 18 14:59:33 2024]     pending: fb_flashcursor
>>>>>> [Mon Mar 18 14:59:33 2024] workqueue mm_percpu_wq: flags=0x8
>>>>>> [Mon Mar 18 14:59:33 2024]   pwq 54: cpus=27 node=1 flags=0x0 nice=0
>>>>>> active=1/256 refcnt=3
>>>>>> [Mon Mar 18 14:59:33 2024]     pending: lru_add_drain_per_cpu 
>>>>>> BAR(362)
>>>>>> [Mon Mar 18 14:59:33 2024] workqueue kblockd: flags=0x18
>>>>>> [Mon Mar 18 14:59:33 2024]   pwq 55: cpus=27 node=1 flags=0x0 
>>>>>> nice=-20
>>>>>> active=1/256 refcnt=2
>>>>>> [Mon Mar 18 14:59:33 2024]     pending: blk_mq_timeout_work
>>>>>>
>>>>>>
>>>>>> In contrast to last time, it doesn't show anything regarding nfs 
>>>>>> this
>>>>>> time.
>>>>>>
>>>>>> I also tried the suggestion from Dai Ngo (echo 3 >
>>>>>> /proc/sys/vm/drop_caches), but that didn't seem to make any 
>>>>>> difference.
>>>>>>
>>>>>> We haven't restarted the server yet as it seems the impact seems to
>>>>>> affect fewer clients that before. Is there anything we can run on 
>>>>>> the
>>>>>> server to further debug this?
>>>>>>
>>>>>> In the past, the issue seemed to deteriorate rapidly and resulted in
>>>>>> issues for almost all clients after about 20 minutes. This time the
>>>>>> impact seems to be less, but it's not gone.
>>>>>>
>>>>>> How can we force the NFS server to forget about a specific client? I
>>>>>> haven't tried to restart the nfs service yet as I'm afraid it will
>>>>>> fail to stop as before.
>>>>>>
>>>> Not with that kernel. There are some new administrative interfaces 
>>>> that
>>>> might allow that in the future, but they were just merged upstream and
>>>> aren't in that kernel.
>>>>
>>>> -- 
>>>> Jeff Layton <jlayton@kernel.org>
>>>

