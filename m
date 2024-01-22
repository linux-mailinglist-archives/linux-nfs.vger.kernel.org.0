Return-Path: <linux-nfs+bounces-1272-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42FCB837679
	for <lists+linux-nfs@lfdr.de>; Mon, 22 Jan 2024 23:45:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7B9F287474
	for <lists+linux-nfs@lfdr.de>; Mon, 22 Jan 2024 22:45:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 238D7111A7;
	Mon, 22 Jan 2024 22:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="caIIdQG/";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="amaz7jla"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE76911192
	for <linux-nfs@vger.kernel.org>; Mon, 22 Jan 2024 22:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705963499; cv=fail; b=oSKU3oBoGcLc/B4Hf0EHuVOsmETopsEhvdeMG+7ryXq3gB/yN9vODcJ6J5gOTyK1PUolSMvtdJhb18sslpVCOHylMYwwfyMylehRTzkTJ66ogMMCpdEZdlT+oM52jVDLsyBt7QRjdwdND9yUUoot2TU887wANU2bH9lMrzVxTg0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705963499; c=relaxed/simple;
	bh=dMsQH3QoHD0/2ikCQxdeGvmNqaAny7gEfd+3LCN+bgw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=W/qxmZ8aSKZoKMtbKhlmbW9R0B25Mgq/EPUo/5g3OXn+ViKAfWbWN6kC9NY3CvjA2qZTHBUopFMZErwZi10r0kA//gkr1sNOeEc/gMgQVrk40o51MjNPlpMK3nThZznL0ZcAeJ00rOqCq0+ySrqx8VXqywjkUPG4OhQ6nnDZKdI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=caIIdQG/; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=amaz7jla; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40MK4RD3011039;
	Mon, 22 Jan 2024 22:44:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=Pi+9EDTTLYMbkoTiiFSvnX/0bHU6mTosjh95BCe2A2c=;
 b=caIIdQG/GvTcFV2WQS+sGolsrnP8NrPjOS+IR9AdFBbGN5ypAYAu5J7n2dzo0AKpzTei
 Ww486a2lSaX9hRp9l126u8DSkSSDzXwNVzoa9wMmL9+HEKj8hc1vxWvDnn+1e5ADLYGx
 PUq5Py8MMMXi05sqHpmRH9ADVauf1H76Qgz9NAo//UPsTWTZaOhMZSssFsC2husKPs8p
 1iLI3UG7rJ+QUvxWyCg9AJsByLOJcI1T4BGU99tMVubg6vcwmq12e1+pAhXBfse7j+PY
 iCYbl+S6K3WozJ7cv1FAeMoQDT9Rn5ppp03F56jI2Qr1KmqwGlqNbRdSyVrt3fEmv8jH vQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vr7cumxjk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Jan 2024 22:44:54 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40ML8ZE9013218;
	Mon, 22 Jan 2024 22:44:52 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3vs36ywf2p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Jan 2024 22:44:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QtXoFbhiyzSe4r5LVrrX34GDMVm5mzh6szbb16VTGGjEcbWT/26K8p2n+m0Z98rdSaD8/Jhg/b/ee09GgNkSRfUqY6MeRDdzWFXfTvHuIDkwFbCfyCA1vqTMdZUi2j9kHenG/ZJ12CPq8PAt5B5gMG81hAIRO/TZuDT+VQ2wBbTRN0wjOB98QrdzjUE1YJgAxs++D2Zn/TkPrKk47UZE7gBidEpqNsEuFfLH+j5JGw2bQ9QV7OvIAmaZYwW40GVYq3YkCCQufB/VMEg5EC4Ah0Yq8lbyli6COJaytdHPIkdzoX5ktUSLey/FZqZeS8+XQd9UPPJzOK/5vBOJFrObIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pi+9EDTTLYMbkoTiiFSvnX/0bHU6mTosjh95BCe2A2c=;
 b=dEWmGt5QprPPBfA8Kd6jQVCayBHbhSil4CuTq7hjV4fOfZZIKCND7FuqQiadOc//focr+FT8rtF4sc51J1Pv9RIQ9Ba5RFcjLRRdOrYEhfxLbv4P/PBLXejbxJNPVWcC0x7ih3G7LjxJnFjOVbXJ8YkrkhawS8U2O7WCNUS08t04TdZ8nDctOedYaS79xPNNEPXiVaJAfxeI0wzSG7hftxIagZNN+zdRsgj5pdv+K7bJDzeeQ/JWFz0i5oH4Q/TbRxZt+7Q+5hHZrwny5Wg+m203zfQJtW7GZqMfYGtwJbenSSLF5RG5ZNW6Ux0Lm2GjjL1vroOHcjWcO2G/estqnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pi+9EDTTLYMbkoTiiFSvnX/0bHU6mTosjh95BCe2A2c=;
 b=amaz7jlaHo+fFC4+ZZze9jbnlSFVeXFjdo+IUWquLSG+njD8XEfpwqAgNXJXXucpXQSJ7yROZqgW2JzJbkivfSOhkEMtusnSr2P3iI/HhlYao44g8hEzVSJy5RkQWnZ/yVnNYEkdKA1ekXN3CQWpZ7e99EVewwJZVLe+xvbqM74=
Received: from DM6PR10MB3817.namprd10.prod.outlook.com (2603:10b6:5:1fd::22)
 by SA1PR10MB6471.namprd10.prod.outlook.com (2603:10b6:806:2b0::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.34; Mon, 22 Jan
 2024 22:44:51 +0000
Received: from DM6PR10MB3817.namprd10.prod.outlook.com
 ([fe80::ce3:f0f8:1003:30d5]) by DM6PR10MB3817.namprd10.prod.outlook.com
 ([fe80::ce3:f0f8:1003:30d5%3]) with mapi id 15.20.7202.034; Mon, 22 Jan 2024
 22:44:50 +0000
Message-ID: <bdd760d9-9900-43ef-8000-0e9ce0aa8b3e@oracle.com>
Date: Mon, 22 Jan 2024 14:44:44 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [External] : Re: [PATCH 1/1] NFSv4.1: Assign retries to
 timeout.to_retries instead of timeout.to_initval
Content-Language: en-US
To: Benjamin Coddington <bcodding@redhat.com>
Cc: chuck.lever@oracle.com, linux-nfs@vger.kernel.org
References: <20240122172353.2859254-1-samasth.norway.ananda@oracle.com>
 <995F0BB9-C709-4C3A-92F3-5EB9710A47F5@redhat.com>
From: samasth.norway.ananda@oracle.com
In-Reply-To: <995F0BB9-C709-4C3A-92F3-5EB9710A47F5@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO2P265CA0145.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9::13) To DM6PR10MB3817.namprd10.prod.outlook.com
 (2603:10b6:5:1fd::22)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB3817:EE_|SA1PR10MB6471:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ad292cc-2c83-4088-a54c-08dc1b9bbe1d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	rbDNYZcGHifhntS5Z8fFYbAj8NGb4vE7Xvd5xC3QSpXaBJmQWLtff8FQbQXGgtk145IAjpc/rX7KH1y3qXdikLHg6+gTwunaIF4f/vaFBV6FTLGTl8YPWaVHmecwDCErqQel3XJS8euNL2xifY/4xrd9MkBw4XdfennBro+v6TblrlTS2dL0vL8oEDa/N3rxcCH6eU7Zl+EeXKvZSyvJRQy3rwqkeZw5Bptobo4LPfW82BAOYOum8IYcufBqpG/+3Ac8v7clI4iymi/XBWaW+UVQE+zjMfhCZpGrwUecgxj8I3PcBxLLumLfzQjKDr0PDiErqV8RQ9vhX8Gx5VakGpWRinC/jre0Cd5sIEUgBWAaRcg6vGDiECW28CS9qJ/1zv0LuaD9L11RNDKR6K80c5eXbIPk5Iia4GAbiso77gkaLdlKm/8m3IikK+/Q3bogqn7RFkxFoaM+O8xPLqB07o3W6Hb4MiYgI53gBFftHkKSy+biSdfff4FpIBV/Em2xFzb4oD7HYlQVh6/CdFLRemyFOdqACyhszMdwYbX5osIvr4xXMhweukJoKoUDj4puU7pRrvdlaFpr/cj+Kav1NnLTZIUBLP5eSbGYGywX8SR+zmJS2oUsQUcTU06IWonj
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB3817.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(136003)(376002)(346002)(39860400002)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(8936002)(83380400001)(4326008)(8676002)(478600001)(86362001)(316002)(6916009)(6486002)(66476007)(66556008)(31696002)(66946007)(2616005)(26005)(5660300002)(6506007)(6666004)(2906002)(36756003)(6512007)(53546011)(9686003)(41300700001)(31686004)(38100700002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?SlZ5WnVLMkhaN1lqZE5ITlBndzMxdjBPb0lEUTZsRHVYOWFhY1dUVlB0VmRh?=
 =?utf-8?B?elcrSkxJS2s4ekZPejI0bVZsd3A2QWZkTHI1eUZ6amNONUZEU0NMVVg0azBG?=
 =?utf-8?B?dWdYM201RnVDcElZL3NKUk9qS1lqYklBVFFaWDNkTVRaNlVpMnVuYndqWW5y?=
 =?utf-8?B?eDNQVy90WTQ1WDQvaWJBWW9DcnpNR3FKTmdNNG1BSXJva0FCQWRxUXBkVDRX?=
 =?utf-8?B?SXJQaU11YVdMdEFXRkVVN1FPRC9pYTNwRmsvV0lZVnpHcG1Hb0VrTUVQSFVq?=
 =?utf-8?B?NmUzVUhBQlFJbUc0SGNZRmk5dis3YzNZaFpPaTJ2WTFXQ2VxTGovUGpOK3J2?=
 =?utf-8?B?Q2Q4ZGt2eE9uRHZzRFZtVHBEWFdsVFE0Q0U1cUpoNjhaaVZzb3JHTVhMaU1R?=
 =?utf-8?B?WitILzZndkpwQ3NBaGZGUEE1TTlYZ1ErSFFVRmJSc0ZSY05FMUdUakZyMkRN?=
 =?utf-8?B?eS9nRkp1TW9FTGJQOHRCVnQ0SU5VNCtkQ21IZkJCUGFUdUhMQ0RiTElQU0ZF?=
 =?utf-8?B?emxNcXhJWlloZXg1NEV6NFQzOGNwQ1d5bm5SNEdJUVkwNHQ2OHVOWkxzNTJ6?=
 =?utf-8?B?R1BpeTJPK3NUSExtNmxlYU1qUWN4aWQyVDJXZVVWWUhreWhpMGNsUGI1SkFH?=
 =?utf-8?B?aUFqNHdsMXVVRDgzQ05HUTg4ZUk0bTUzOWltZndJZUxURG9PS0JpR01CNkNB?=
 =?utf-8?B?VHlNRWREVHdkb1g4bGdsRFJVOUwxdndOdmNvUlFlN1JQcExFVHVaQXJDeWdh?=
 =?utf-8?B?dVlSaHFGbks4eHgzQ21ZNlVLWUVnQTc5SkF3U0NyZ2hUT0djSkVPcERxMDZo?=
 =?utf-8?B?UTVEOG85bHo3NXd1QXIwR3ptQ251V2NyNDczajBkd3hoalM1Z1I0aFQ4K0Np?=
 =?utf-8?B?dXFkaHRmWFovNjIxV3JGSEloMnAvTkY3VTZpVDRPcS9XY0NScTBpMG1pMHNR?=
 =?utf-8?B?SDJmQkpUbmNyZmlUZTNrMm0vajR4Y21nSm9MRXc4TGQ1aXRTaEtEVStZVG9D?=
 =?utf-8?B?MnNQTUxMR2VyZUxDeGU2NG9VWlloTzBqYytXU1hwakJpWjRtTjF2dE9pNW9h?=
 =?utf-8?B?VzgzTVA5Rk1NUUlMYUZNUVJDbi9PdjdTdW8rVWVaQlQ4Y05sNzIwRk85UVdw?=
 =?utf-8?B?bVZOWmJkUCtYTmlqRGwyUVdpalFOS0lnYjkvMmErSG1FK0xEY2JnbmR0QmRp?=
 =?utf-8?B?UExJYzZ0bjhabzFkazZxYnBTVHRybFZ6NWlnZmdXMHFKNEpTN1p3SGVoZXBJ?=
 =?utf-8?B?cWhqbXhZa2xOcldRbnZjRmt5ckIzbEpsUGUyb1k0N2lTVkJtNzZ6NjJ4U1Vz?=
 =?utf-8?B?MERDanlFNUo3bzRQSFdXRXlaUEFWaXFrM3pnV00zMnNzc3RCN2d1Y2hKNG5l?=
 =?utf-8?B?anJIejgxNk1LbXdVMEI1TzJJcEtxYUg1YnF6bUxkeHEvZlIxN3hhdjNNSk1I?=
 =?utf-8?B?SU9KbCtvYXdQcmZYNjRHazdETXg4Z20xQW5wVFRnNWNxS1NWMHpGb0ZQYjJz?=
 =?utf-8?B?WXN2blhBL1Baa1h5MDFUWkcrT1BJTGRZTmtIdkk2dFNSWXVvMCs4TVVVTWRY?=
 =?utf-8?B?cG1SOXJxVGg3VGREY3JIZXZUV2lOYkUxM1BUZzNqZVJKbXZteUhUVzNrQklG?=
 =?utf-8?B?UVdXdWU4MnRiY1NRVTJQeUJaYkVzYjJxcEh4WjhUNW85TUtGZGpxWjR2c054?=
 =?utf-8?B?TitlTVIvSzMrbWVvbkgwcVJWL2laaWNQNDNHU0pST29ibGJIVkpvZ3dURmx6?=
 =?utf-8?B?V0FCendmSWZWZWV3aFhaeDFSR01CMGFGemd1L3NTUlVWeml2UlMwd0pGQnZR?=
 =?utf-8?B?TFQ0ZURWc2U4STRQekhJMWFTNVZvVDMySm1qWVFJUHpWUTJWSGwrM21ZSThx?=
 =?utf-8?B?MkZyWEJzNEYrTFdrdDkvMjdRazdDS1hJZ2VjMkdTUlR3NVlpSTNpWDhza2tP?=
 =?utf-8?B?NENsNFNDdGgwZEZELzE5b25xMGhoUHNpK1JJL3huOFd2TUNFd3kvMkJRTTYx?=
 =?utf-8?B?NUJOd3hYZGFkN3FyaEpyNElxQUtkamR0K0picXhSOHRBZmJ4VzBPNjZURFZI?=
 =?utf-8?B?RDVmend1Ky9kREpqdnIxc1JIQkNvMjBGcGdYK2UycVdScThjWVBXZlBXdzRN?=
 =?utf-8?B?enNXci9qeE41VldTK3plUlBLaTZnbGdvclhodXhwOWZWUnFZUlFJK3F4cXg4?=
 =?utf-8?Q?OxwOcajYOigVxAKMl7sZQKA=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	VJe2yQ6kXlqhxy/Deb9rpk6nFUtUQO8GPJ7x004n8GvxTqKFOl5tbjYf8pNd5fziWt84BrXpSvGzqlVze51WRD9e+UP/X5OqArmDNP/xLOFgqCSjtSD47wVf16+juq3Zetll9G3YUJpQ6b+KO1UMjkV7mViBYVn4h81R+RpJQrCtKvaiFyt+TGZ7gaFh3/wEVa5s68M6akg5JwTHUmuHdyf+4DMpLaKS7KjvdKSh4+xOj0HGZ6572HpAKOUkRWM0C4WcaAz08uS5bjB4TmbLoM6DKQspJ+6b97sWV8Uz5OFs20TuY2zh5ZaHXcEjtfbogGzTeYkgEI1yliFi+t74yY+c0kj6iTnpPlUssJ1CB4esyrc7J0yP9U8+T7XLRgjedXs3z9FSgSQJ8XMvOXZF1MKhfMq8XaP+meNpaZrGUFIGbDGVBx/TWVFraqGBEurfycHn8tdSWfpBalFMcpOAWJUiPrSVKIOkmtZcFyRd0AdHc2egXNPIiknFYsjTfqExjEhmKyACVV+Kc6hTwn5JslQCJDTy9ZEwLmxFm1cEardEh+k+a+cgcNZ2tF6fFWQLXIxwcGJepI3gpfRIW6CA26QY6swsQPt/SlmPz2kHHTw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ad292cc-2c83-4088-a54c-08dc1b9bbe1d
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB3817.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2024 22:44:50.5506
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fNaAuzwNBJsXDi/457TKBZ6ydkuD7I9rWfnLdeiRf1jdHmN7P6odLUCyU5BE3ChydL5n0zWGsPDGxNMIRAVlUSWJRIVLXfsuJrsrSsr5NemLzQ8+k/qbS/rAGNSJKmYb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6471
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-22_12,2024-01-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0
 mlxlogscore=999 mlxscore=0 phishscore=0 adultscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401220162
X-Proofpoint-ORIG-GUID: zCvAFIHG-KAPazqyerUubWp8HLAuq5tI
X-Proofpoint-GUID: zCvAFIHG-KAPazqyerUubWp8HLAuq5tI



On 1/22/24 2:41 PM, Benjamin Coddington wrote:
> On 22 Jan 2024, at 12:23, Samasth Norway Ananda wrote:
> 
>> In the else block we are assigning the req->rq_xprt->timeout->to_retries
>> value to timeout.to_initval, whereas it should have been assigned to
>> timeout.to_retries instead.
>>
>> Fixes: 57331a59ac0d (“NFSv4.1: Use the nfs_client's rpc timeouts for backchannel")
>> Signed-off-by: Samasth Norway Ananda <samasth.norway.ananda@oracle.com>
>> ---
>> Hi,
>>
>> I came across the patch 57331a59ac0d (“NFSv4.1: Use the nfs_client's rpc
>> timeouts for backchannel") which assigns value to same variable in the
>> else block.  Can I please get your input on the patch?
> 
> Oh yes, this a good fix.  Usually the maintainers won't pick up a patch
> that's only sent to the list, rather the patch should be addressed to them
> directly and copied to the list.  Can you re-send this patch to:
> 
> Trond Myklebust <trond.myklebust@hammerspace.com>,Anna Schumaker <anna@kernel.org>
> 
> and copy linux-nfs@vger.kernel.org?  You can also add my:
> 
> Reviewed-by: Benjamin Coddington <bcodding@redhat.com>

Sure, I will do that. Thanks for the review.

Samasth.

> 
> Ben
> 

