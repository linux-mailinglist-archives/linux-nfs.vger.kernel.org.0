Return-Path: <linux-nfs+bounces-3936-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 286E690BAC5
	for <lists+linux-nfs@lfdr.de>; Mon, 17 Jun 2024 21:21:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98E4F282CC8
	for <lists+linux-nfs@lfdr.de>; Mon, 17 Jun 2024 19:21:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6141018A934;
	Mon, 17 Jun 2024 19:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="EHQTqnPr";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ti5uHsz1"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 549FF1991A9
	for <linux-nfs@vger.kernel.org>; Mon, 17 Jun 2024 19:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718652092; cv=fail; b=VftOzvZXZ7eEbESmBSepsCZxg8t/9buOeoTgmj2OJJjpnhYbbk2awa3J5d5i5TNOZV54hsYo4yRJHrOKiMG+o3pVt274AAuCJCdPm0i726Rf+RDblI0MAvRligyVa2ij949D03o392XSLbiJ2V2vZXtrSe8jhpt1GYXPWrPkE+w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718652092; c=relaxed/simple;
	bh=AThzc7NyN9VPbLEbjGig3JNxapYrDpS7Wtlgq6duntU=;
	h=Message-ID:Date:Cc:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LlgQepag1eQypcPNDwIeAzG3d3Ye5sGukh2P6muCKYb0/7J/Z4bC9g3SrscpaVKlQx/+N6/xlUaExoBu4pJfl9gn+4bwtoPW+o50/73y99PG+GMUfOG+nb+tbYmfWIRF6bNHga7VOPrvNrhpoBxAFaH4YoKAv/P6fnYHOvlvsro=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=EHQTqnPr; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ti5uHsz1; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45HItToY000926;
	Mon, 17 Jun 2024 19:21:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:cc:subject:to:references:from:in-reply-to
	:content-type:mime-version; s=corp-2023-11-20; bh=0A0L2OWPoE0UPA
	8TIBXxjOiwH4lNx5g+EcQiIM10ey0=; b=EHQTqnPr7NyBOv2BhrIkHD06c3rfl0
	qP/IrkG7hmwaQm2FhGo8mJPD3i+gQ94KZLD1vPhlnCqY7RLwCVnwfvf64H2PVhm2
	cDIMEvcP/frw2gSJtDhpwhmk+BpEvkjpBxDrrr9I/tTFAzFccfBj1Df3ZlFbHNhA
	aoNvle1FvdCE2wMgAMGH4udAQMP6dWxZ581cZfdVdYirUqYqU5xuLiWLkubavwKc
	aNgMfkJtwTInU+QrOTXLTmHGzJrpwWZxZApZWeFccTjMyCKddq//DksJ4sMrJdRX
	NagtWUMJ7dmKG5VLGllWJIB+XoWgwcQAXtyLCIvTx5YyIMQBLNoeI6yw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ys2u8kdcd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 17 Jun 2024 19:21:04 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45HImdwv034721;
	Mon, 17 Jun 2024 19:21:04 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2042.outbound.protection.outlook.com [104.47.66.42])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ys1d74q9d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 17 Jun 2024 19:21:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PNGUCaWi9Ugci1sqK55DspqzkYdtcsa0qYTLwtfibO8SHa9Z/vWWVTeBYG5/AiOYhSCNzP/TNE09As3PA49L5/XSMlmx86LlEpR2ZPxPFY0t2zT18MLFgYcNhZlHwGg0RtLs87y0DtTegnb4KDBgugDtU3yG7sWHGIUuGuu85p2Gz7A+smmFKKVSIJ+GrSQVbbIjlnUzojCPNE8xU5/RDcF/pTOi2hEeHPck9w9mT+BojgKjmj/9I4n2DFfpnohHE2fzt4pMGbRNCwbkdDRJCUt9SEC7BcBlah+U6n7Jp0otdzu+mW178gLPWoo/Tpgeh88r3XiWfhciitomu/I++A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0A0L2OWPoE0UPA8TIBXxjOiwH4lNx5g+EcQiIM10ey0=;
 b=mcLVrJCrpwOMfYqN5WaJ5z7dmFATSdYlN9V+gBIUXW0B2D06CFYFFEd7iVDa8Ox5b0ZlxySdEU8hcm16MqLeJNTPdtClW/JXDXU8yYui5ZgBm9sGeBC2/7zS3imHGJkJE8QdTJfJ5SKZjuI9GoVxF45AdV1+qcXBXcfmLYx2Ea09YYXGHxNPjLAVPDuYq17Btynk/jbjm6g+vndFIIKxxlKNJ3SP6HGBDnMGdZvmftfgoJkPzMzapQBf0tbGRtLlP3rgCX4Fp5Qmu5QZaeEQqW9bD2DZmh9ZLsy2Vt6dJhQnCtyofFtnbct0uLg9IyXiqcV67bw6eWRcoOFyLQFYhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0A0L2OWPoE0UPA8TIBXxjOiwH4lNx5g+EcQiIM10ey0=;
 b=ti5uHsz1ShpXrtO3S8vLxTOxFFq0of2sw3nIwD47Ru0i069R3uoiHTFMvBzOSmWvj1VbryxflZtiJoCIqm/Umfffd99pDl8yT3t+dZRCEUh14rSFpvH0NLCR3P8x7DfvOYT2qfLTknaaDF7sVTWvjRPqgJkFZ2Q4f2KP3uFS2sA=
Received: from BN0PR10MB5143.namprd10.prod.outlook.com (2603:10b6:408:12c::7)
 by MW4PR10MB5678.namprd10.prod.outlook.com (2603:10b6:303:18c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Mon, 17 Jun
 2024 19:21:01 +0000
Received: from BN0PR10MB5143.namprd10.prod.outlook.com
 ([fe80::783:503f:ea07:74c7]) by BN0PR10MB5143.namprd10.prod.outlook.com
 ([fe80::783:503f:ea07:74c7%4]) with mapi id 15.20.7677.030; Mon, 17 Jun 2024
 19:21:01 +0000
Message-ID: <4eeb2367-c869-4960-869b-c23ef824e044@oracle.com>
Date: Mon, 17 Jun 2024 20:20:54 +0100
User-Agent: Thunderbird Daily
Cc: Calum Mackay <calum.mackay@oracle.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: nfsd becomes a zombie
To: Chuck Lever III <chuck.lever@oracle.com>,
        Harald Dunkel <harald.dunkel@aixigo.com>
References: <4c3080af-eec7-4af5-8b0d-c35ac98ec074@aixigo.com>
 <C1CE3A96-599C-4D73-BCC0-3587EC68FCB0@oracle.com>
Content-Language: en-GB
From: Calum Mackay <calum.mackay@oracle.com>
Autocrypt: addr=calum.mackay@oracle.com; keydata=
 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
 smRifw1wGg==
Organization: Oracle
In-Reply-To: <C1CE3A96-599C-4D73-BCC0-3587EC68FCB0@oracle.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------dqDQXgOujKI8wX0mXwS3MR0p"
X-ClientProxiedBy: LO4P123CA0316.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:197::15) To BN0PR10MB5143.namprd10.prod.outlook.com
 (2603:10b6:408:12c::7)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5143:EE_|MW4PR10MB5678:EE_
X-MS-Office365-Filtering-Correlation-Id: 266c39fa-17d4-4af4-a700-08dc8f029f86
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|376011|1800799021|366013;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?M212Q2VQUmNCMlZnT283Qi82REY4UEY2eTVKWkdoRG4zT0F5QjFFQldWRCta?=
 =?utf-8?B?T3VZUW1vZXJEVXlzQWtta3B0QkxNYTVROGZRZExCemU0UmdjS3JZQWh4REo0?=
 =?utf-8?B?Vi8xSkJDNnZpSERCeTJZTFRlR3FvV0hYenJ0QlRha3BtdThZVmV6cGs5NWxx?=
 =?utf-8?B?WW1VaVJUa0dmb3JRbWR5ZEt6ZUNtd1ZhUExIVHc1VUw5WHlRK2lCYXd5VUVI?=
 =?utf-8?B?dXlGTVVVZVUrM2crdmE1c1JCU2FVUVdOSGdXTWM3WEphbTUyTTh4bE5xb0ta?=
 =?utf-8?B?ZWJWRnNsY0h3eUtobWwxdThvb1AyRCtwOXhobkxEK1ZtbHphc3R4aDFLTWs2?=
 =?utf-8?B?YkZtTUxvQnA3aGJNWEJ1YTVGblpNdXZkNXNuWjJCeTJSK3pxTVd2N21KU0lK?=
 =?utf-8?B?R2NCcHRJVDBrUlAvZGxHczlNMEZQUW84bkUwT001Wm9LVHV6eDVTTTBNbDVZ?=
 =?utf-8?B?eERlWHdiK280NHRGT09nM1lUaEIzSXZjaGd6aEtTZFAvSDNhc25WQ1lXbXZE?=
 =?utf-8?B?VU9RZkVWWWE1TFlkNUhRV0RzdFBRMUluN2RYb2haYUx0UEE3R3RqMkJhVmJU?=
 =?utf-8?B?TWRROHViWVYxaDNrdzVPSGkrbWpSV2RncUlOeFk5aDNTSXkxR3NFdUZVN0dX?=
 =?utf-8?B?bFBTSWE4NC9ndnB5TnZ5RG81dlZlRTlBWU42dnpkcSttbjhXbjFZQUlTc2Yz?=
 =?utf-8?B?UXFWNmRpLzdBS0N2Q1IvOHgybzhaK2VhdG5pMC9OTUtBbzdFOEtLU1BRMUhR?=
 =?utf-8?B?SmRmb2pnQk1TZFdVRDNPRVJvZlhseWpqcnVRWi9SQ2RYY3J6b0Nma2g1eitR?=
 =?utf-8?B?NElkK1RhNXIyRS9ZWkxYbUhaZjNOMUpKRmx5ZjNkaGJoajgvaXBDeThPMFlv?=
 =?utf-8?B?U1gwZFo3VDNOUnN6dkpKS0VkQ21NVnF1OEtoMk9pT2NCTzZkbkVHSUZsU2Yy?=
 =?utf-8?B?TytSWk9uOERvSFhzRFQyY3RMU0svUGdETUdkMldWRCtSRXVuV2JiU3JiTDhr?=
 =?utf-8?B?MFpVU0c5SEpBRVRpYnBTWWhwMUdKOEtxQXNyYW9KcXhtTGdRb0U1R0pJNmw0?=
 =?utf-8?B?QzFTTkVaTCtLckQ2TzJyeUZvUEk1aG53b3FHazZwZ3p5SE5tSUk0dnpyekR2?=
 =?utf-8?B?eHk5ZG15MDdKcTh1Q2I1Z2xpVmxHU0FYMTc2UGtCZFZndTJKNHQxdWVmRnlZ?=
 =?utf-8?B?QWJmMEY2R29NQTRFdzFDVFJKdEpGZDRncmhHUlZycVBXZCt1a2RVbDQ5RTN3?=
 =?utf-8?B?M3R3aE1qcUpsaW1GWUx6WTlTVUYvVXZvVTRSaWpiY1FZNmE4MkxFMFA0aGRS?=
 =?utf-8?B?ZDA3WVVNY1BoSzBXQW85ejhVRjgwSEtoQVRZaUlXMTRiV0cvWVF5S3VwUm5Y?=
 =?utf-8?B?c0kwd2kzNUpHVUpZRUhteUdlMUhZUXNXY1BjSUREbWtZMXJPdDJndTcrQVdl?=
 =?utf-8?B?WjRZY2lqa0RMVksyMktCdEorZHdJVVBudFFEam5jc3N6L1VmSlRYbFFSdDhj?=
 =?utf-8?B?TVZYT2s2N0tpTkVITG4weUE0eGFGbUFLc2UxbmxPaklWUHYraWVoS1lGNkd2?=
 =?utf-8?B?NmRUSGlQV09BY1lSb2lKZGpaUmZ4VkRHMytzZWFXckpCVHFDcVdMWjFIOUk1?=
 =?utf-8?B?ZlozTTJVOG9wWGFtaDMxc1ZLSGJ1RjQ4TkloeG4weHFkZERUU0NKaWlIMXFQ?=
 =?utf-8?Q?QMhnQjGpA0EakoLJYpL8?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5143.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(376011)(1800799021)(366013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?TU5XN1p4cG5zb21sZVluTld3OVp1dG1pdC9SMFpZZE92MHUvRENXL1JVdmNp?=
 =?utf-8?B?dFZMNFp4R1Nva3dUTmI4UVV3aWJnTWxkYXFMUWZTL3BjcWd6MmczbEFveTAx?=
 =?utf-8?B?Y1lpMmRCZU1vWHdRVW5tL2NsYXVDNG54NEF4VW9wTm1KYWtFVE12V3lRTTRr?=
 =?utf-8?B?dEV4ZmtWcERxMUtmeUd6WUo3MGRyK1o5N2grMktabU5hRFM5L2dHT0pNY2Fk?=
 =?utf-8?B?YmhIT3c3Z2p1VU4wUFloSmh5YkN0bE1tNEhSTnA3dlJSbm5OeGp5SkMwU1hQ?=
 =?utf-8?B?MTZ1MVhmM09NbG1Ga0ZPS2pBSTVFNHoyM0F6V1RRSXliTVRNUEh4T3VHb0g3?=
 =?utf-8?B?SkdESlVWaTQ1OEtUQktsRUdId09tVHZBWjNYbDQrSG9GMFR0ZDVkOFkyQ1Zl?=
 =?utf-8?B?VDkwbmpyTGJYUmhVZ1F6S2ZEL1greHRUWWI3ZVRVSy9kY05mWkUvdjdYREVu?=
 =?utf-8?B?TzY5Rng2S0xmaFJMWnBOcU40Z2kyQ0tWZFRxV2wzRXVnRVB0YlhaWTg2MEFF?=
 =?utf-8?B?L09LSHc2RGlwQlBDbXhPMUNWQlk0MXNRUDQvS1h0QndEZmpjZERXMWxiTzEv?=
 =?utf-8?B?d1VnZzZCZkdwTThtMmRQRDl6WHZRbXg5OEw5YURYYkVVVzUveCtBT2RsQzJl?=
 =?utf-8?B?aldvb3lVdUduU1FkRERwaEpxWjlaU0FURzNMQWZCYjJaTlB5NC92L2RnRFlQ?=
 =?utf-8?B?MGdhaUJtbG93RW1wUUNOYkZ6OGlDd0UvL2dsN2VmMWN6cVZXYnA4NStORWtC?=
 =?utf-8?B?OG9Za2FSQVJXUThtNHA4ZFpoN09mYWhlellYT1hnZDhsYW0wTFNnSzZ2ZzNw?=
 =?utf-8?B?ZStuWlZjT1BJVnNrSFJRTlJxUjJZMUZZSG5NbHZ4TnhnU3ZVYldkeTY4T3Yy?=
 =?utf-8?B?bUJjaDJxYmIwUGxNemU2VmpwMTBRZXAyR3R0SzhISGpXV3Nzc3ZzSFlZd3lZ?=
 =?utf-8?B?UDgyaWtUNldaUDVwVWhpdC9ndkhMSFVFZGM2dEhxOUZoN0dneFlCcGlqWWIw?=
 =?utf-8?B?UmVYL2U0ZDFvSUdxTjlYRG41RnV6ZnczTVl0aXZnbjZ0MkxLVFVyRVY2Zkpz?=
 =?utf-8?B?dHRPZC9Hcnl2N1BFbnY0V1VIWm8zTkZQN0Q5SmhiN1QxVDZOYVVRaDBFRi9F?=
 =?utf-8?B?QXFKbmhncnlHRXhCRTdkdS9OaFRjeTBFcjZZZytVR3hwU08rTUN4eGY2Umo4?=
 =?utf-8?B?TitJcHh5cnhTbmNrT1pObVVMSXhlTW81SXlCUnE0cnRpc1hRVU5sa2dUcTRm?=
 =?utf-8?B?NTRwYW1vcjlTNzF1bGQzdWQ1bTNUYXhIN2gxYTZmYmkrMkVVcDZPNG9UbUkz?=
 =?utf-8?B?K3dtb1IxYXR2Tk96UnBTVzRPcnQ2bDRpWEtFZU1Cak4wby9zMlpVZWxCK21o?=
 =?utf-8?B?SXg3Qkl4M1RLdmIybUM2dGpyTzRNeFRtYmFmeHZBeUJHUzFsWDhIeVN6Y3RJ?=
 =?utf-8?B?bXJkaGpvNFpiQ01ZWHpvb01RQ1h0U2txMWJvUzhDblhxZWRmMDByQjlGbjdL?=
 =?utf-8?B?UDNjZ2l0UlhMOFVMRFZ0aVYwZ0JGTWZmWjhKOFBHenN6UlJIb280WUVOa3BL?=
 =?utf-8?B?dDVhS291YVdmaW0yNjBlYWsvNnpQVE9OcHdzdnpXZk5vYndlN0cweVBrYUx5?=
 =?utf-8?B?WWdZdFBkdWNxT3ZIalN0VXBMUmhKTUFPWm5FRGJnK3FVb015bC9rWEVoaFRD?=
 =?utf-8?B?UFlxMEM1VktwdXVsRWRrMWZ3UjMzQ1BOSnRJaW9rY01MOCsxSjJNRVFVR2pY?=
 =?utf-8?B?K2JQblNHdnk3VVUyWlp2aFpFNE12eHpSUUMyOERRamc1U2h5RkNmUncrRTcx?=
 =?utf-8?B?ajMzRkU5MWxHK0c4TzFqazg2NUl2bHpoajQyall6WTJlMnh4Uzc0N0kwMzQ4?=
 =?utf-8?B?ZzhNdzhXbDJXVWVjSHRNMkF4MEUwY3dWa29rbU1yRUxRcDVWcjc0SEdqSUpa?=
 =?utf-8?B?OVhUM1pRc3dGRWNiajFYR3pBL2dITGpIRjZUMEZQdFBCcFR5OU51bFQ2VmRW?=
 =?utf-8?B?TVlZNnd6TnhmWEk0OGhxK0Zxd250V0tZWG05V2l4b3J2VWlPZWFTUVp1aHFs?=
 =?utf-8?B?emNZZTRYeHhEYWtxYjk2OFFiUmtnUmFmZjJoOEtHbk9FVk1KV1FSa0VUenRU?=
 =?utf-8?B?cGhIVEx2dXliQTgxNm9qVmZOZ0ZFa3BieFNpRlNpQjVuOTNWdExFYzR2ZUdn?=
 =?utf-8?B?T3c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	+5LI9fOZcN3Ip1QaL8N6bfEmHt+zw6xxHs4/IvVIvZgaAFXn5E2m4249zs5p2dEohEufhUKF6p0u6JB1YC8vtzOwPrRcXRIHZmDxRSgttBwpdtefEXwaWVF8ZLcpNXeXjLjUXIjLiYTIh6HD3GoSDh2mmRuQi+XEcvEPeGwLE31MNw5KvKupDfOLjs3oAG/I5TVRB1OG5vLY5xsdWY3Ui7n3REsNqk2BMDWfTaT8zUpD+W+YelUDt0XuPHoMLOzqHseD+4pRZ89kOylUZGXsa5/DKDFZ6zxbHl2lJbpB5SokPWwv7VqijCN37Ep8RSAxTaXoqORXK66QU+yHA4HHzA8YnKINDDgjpHgd4/iXoEZq/PZIFclw/8R+ShXs5xMGQp2M2cJ/xKv9kIlIjDdoZ+wz7Vfvmf+9o4zQVcb6IeOlQg4NpPyCuYSX/emRmMZ3oZfABUtee5tvVOHo7LFwcCyRJtt64omXuvMsGmch98pLPTm/5iUC+vOdXB6LvmmBAC2RoVYJbSOdWeThdOY6iZQEiiz8C1aCiXgWfWUlL8JvjI7NPM56YA0jf7ggpO0VsbmncbwSX5u2HSAob6E5lWKQDFHlXq4j4QU33AhJ8/w=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 266c39fa-17d4-4af4-a700-08dc8f029f86
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5143.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2024 19:21:01.0616
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q0LiXu/L0/sYy/Qgc/pAkFZd/WXwgOaGROlchzr1JgYvT+gI6d74we4KMzZ+JJK+6Pa1J56GkVUk5dDluyIEDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5678
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-17_14,2024-06-17_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 malwarescore=0 phishscore=0 spamscore=0 mlxscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2406170149
X-Proofpoint-GUID: RRJkj2EgGleyu_qTABc99L05zLzCZfXb
X-Proofpoint-ORIG-GUID: RRJkj2EgGleyu_qTABc99L05zLzCZfXb

--------------dqDQXgOujKI8wX0mXwS3MR0p
Content-Type: multipart/mixed; boundary="------------61mNurIjhnkHl9ukE0pN00oh";
 protected-headers="v1"
From: Calum Mackay <calum.mackay@oracle.com>
To: Chuck Lever III <chuck.lever@oracle.com>,
 Harald Dunkel <harald.dunkel@aixigo.com>
Cc: Calum Mackay <calum.mackay@oracle.com>,
 Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Message-ID: <4eeb2367-c869-4960-869b-c23ef824e044@oracle.com>
Subject: Re: nfsd becomes a zombie
References: <4c3080af-eec7-4af5-8b0d-c35ac98ec074@aixigo.com>
 <C1CE3A96-599C-4D73-BCC0-3587EC68FCB0@oracle.com>
In-Reply-To: <C1CE3A96-599C-4D73-BCC0-3587EC68FCB0@oracle.com>

--------------61mNurIjhnkHl9ukE0pN00oh
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 17/06/2024 3:31 pm, Chuck Lever III wrote:
> 
> 
>> On Jun 17, 2024, at 2:55 AM, Harald Dunkel <harald.dunkel@aixigo.com> wrote:
>>
>> Hi folks,
>>
>> what would be the reason for nfsd getting stuck somehow and becoming
>> an unkillable process? See
>>
>> - https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1071562
>> - https://bugs.launchpad.net/ubuntu/+source/nfs-utils/+bug/2062568
>>
>> Doesn't this mean that something inside the kernel gets stuck as
>> well? Seems odd to me.
> 
> I'm not familiar with the Debian or Ubuntu kernel packages. Can
> the kernel release numbers be translated to LTS kernel releases

The Debian NFS server's broken kernel corresponds to upstream stable 
6.1.90. There doesn't seem to be any note of a working version.

Decoding the Ubuntu pkg version is harder (but is obviously the 6.8.y 
series; the actual corresponding 'y' value is printed during boot, but 
other than downloading the pkg source, I'm not sure how to find it 
otherwise). The older Ubuntu mentioned in the bug as seeing the nfsd 
issue will be 6.5.y.


Harald: do you have a Debian/Ubuntu kernel version that doesn't see the 
issue, please? i.e. ideally from the same 6.1.y series…

cheers,
c.



> please? Need both "last known working" and "first broken" releases.
> 
> This:
> 
> [ 6596.911785] RPC: Could not send backchannel reply error: -110
> [ 6596.972490] RPC: Could not send backchannel reply error: -110
> [ 6837.281307] RPC: Could not send backchannel reply error: -110
> 
> is a known set of client backchannel bugs. Knowing the LTS kernel
> releases (see above) will help us figure out what needs to be
> backported to the LTS kernels kernels in question.
> 
> This:
> 
> [11183.290619] wait_for_completion+0x88/0x150
> [11183.290623] __flush_workqueue+0x140/0x3e0
> [11183.290629] nfsd4_probe_callback_sync+0x1a/0x30 [nfsd]
> [11183.290689] nfsd4_destroy_session+0x186/0x260 [nfsd]
> 
> is probably related to the backchannel errors on the client, but
> client bugs shouldn't cause the server to hang like this. We
> might be able to say more if you can provide the kernel release
> translations (see above).
> 
> 
> --
> Chuck Lever
> 
> 

-- 
Calum Mackay
Linux Kernel Engineering
Oracle Linux and Virtualisation


--------------61mNurIjhnkHl9ukE0pN00oh--

--------------dqDQXgOujKI8wX0mXwS3MR0p
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEE1GBbrQYgx8o9Vdw+hSPvAG3BU+IFAmZwjJcFAwAAAAAACgkQhSPvAG3BU+IA
vxAAuRPyFVX+cSIjkiGhPJmBZHQ3XkTnsINBypJ8/lxlOvH85fCAy26DsB3BXNuek/OIGc8xFnfk
+OtFUdc7AcWMng8n2z1FWpFnAhsb+jDHyYz/HkPba1OTxvewDoBdRE92RtZZiD2iYJdyY6NaNDkk
0g8gohvpEb3HD9TsqP8X450eAFNdeyJpqjFEByYnl23/3dIoi5NpRzNx3eSkqAgFajKKCe49P8cm
BG9dH2V+fFyrVBYW/LPcLeDgQVBs9pUz6ZHjW7NdrbfDrTieRBO5eprfmu0bV+jT6xLKDHjMcUj6
V4g4zYQJmYz4ZG1c8eyeHdRkPIZIf0ybc5o1rhw5qwW7SQHkVKc+/qCdjY6p5QR4/FzP0ZhPqdDY
av67MnAhRjqz+69fleuGnMH6GhjTA8oQ76vaSIbl5yGDhBsH9JNsEAJxB30hz7QqHgGvWheO4f/4
0M22xGY1Y8qU2+DXTmIv49vh6fc0JO3ZFaWDnN+CxihAv2wY7tKUrEWSGEaopRRXLMy5dvMpXjii
SZFAaL2yjh39SQMvAHbO9NHBk304Ku5bPO3FWbuX0W3ao1w2BXJOC/2ca2y6kQlG4vAlPldQcTv2
4GMBbwUxfKdzOwBfd6Kbl+nIOL7kqBbCk0/DRhotfAjyJsxfZ0yqnEWnp5x8db+u/rulheuas6eZ
OBI=
=LeSM
-----END PGP SIGNATURE-----

--------------dqDQXgOujKI8wX0mXwS3MR0p--

