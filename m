Return-Path: <linux-nfs+bounces-1076-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1216382CDA8
	for <lists+linux-nfs@lfdr.de>; Sat, 13 Jan 2024 17:11:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CD067B228E9
	for <lists+linux-nfs@lfdr.de>; Sat, 13 Jan 2024 16:11:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78AB64414;
	Sat, 13 Jan 2024 16:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="V+38F6pa";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="yi64g62A"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A96094400
	for <linux-nfs@vger.kernel.org>; Sat, 13 Jan 2024 16:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40DDnIG7002107;
	Sat, 13 Jan 2024 16:11:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=EwUgWTKguGKt0J/CdjASZt8YyO0bZ/xvVTzgVl7pBqE=;
 b=V+38F6paIjM/8sY4r6G9jHJFTs1/Jwb+Q4mUW4tASP14f6eXYeAaKEPDTvIsrMhFB5Vz
 GA4QK5NjVgl4Zrnf7YwJz51d37z0UzC+Bkcz+1w1pnIedz1TaNrWPRl3M1LrxRnz0nRq
 xVkEK00htOlIWEglOygeGfoRQ6RP3nH7JPnq8q00lElnexjrPMMAJziKmVzbkuv6wvRu
 9L65UuZ5OwGL//Dg3hrKhMReeGvayO/yete4AaIp6TlM74c3rAzNlcRzh9TDksePkXWs
 jRlpCpX4ibD4SPWhydj0f5MqS1okbA13MveA1XT4A3lmgpnk8iYA8q5SB2If9nI7G2gQ 2w== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vknu9gau1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 13 Jan 2024 16:11:00 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40DDjIJ9023370;
	Sat, 13 Jan 2024 16:10:59 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3vkgy3rqyq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 13 Jan 2024 16:10:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WQ+Nrg/9pe9PDj4ZXhcWKrNbC5kstXWWrjmmELFKS9U4pAUjXARUFQzL/WARb/gjJuDQ1nYt7CzILjB4HETnP9YBkoosB04nCXehzuYCYnzNYGiCiW56ShOjFQ+Q1mu6KRkzpuxKFKBana1rnVy7ZUmOREYGJEOzhuBGUu8+xfcITTZvC8wSTq5OVQ2V0LNibp0a+tb6vPOOIWL+AQJoOOFtxnVWv8cSgE25Y7FvyjecqaAKxHe6PO1GniS/HHWEykH2jtBciDzG/dG2YkU85S53D1f24j010Z/2yxLZ87bHAz8QC7fQ8qyuHzhxYaSJLIuTu+SRCYedbe1/tGtzsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EwUgWTKguGKt0J/CdjASZt8YyO0bZ/xvVTzgVl7pBqE=;
 b=EFdjO6HsnUFf3OjXPDNhrsnopYd5BLEfmA8SiuWE/qagfZGllbMNqaTNlRB4fCT8P9WXu1UBeh2F0oaF3Untl5yBsoVCrnFouku/6E6f+iTcQJG7sFClxaPoUzl0bhiN9w7RNK9x1dxPj/d3mta3Bq56kVWZ7s+iH4o++QZ31fD75SGDZx33xIv/grXMtzrO2YGd1mhXnJy6gZnS83qUube07Yupg8WxkMrGdi5qiaNixlUfd+lb0VC76vgaHduoCy/gyM+CuTAIdIejFLRuYJAR8dpd4G/33mRFtJQ/+3V4UYHTzw7n4eWeCDcnTfJM5Reic6hJPTvM179ZUNbRWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EwUgWTKguGKt0J/CdjASZt8YyO0bZ/xvVTzgVl7pBqE=;
 b=yi64g62AiAY9k4cALR55jX3IXanLJlXn1GVUlWAgj/oD9tZGwYxx//YyNrQ1+6cnwa04uRG47ODECdyMJDPluTo1bbS7vpZ132Xa3G/bH5T7BcqkNr+A8urBmAYuCi2QecEH6EM4LOctn0uy3rVT99ftj3NmP6uZ3oi5AuCyHZM=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SJ0PR10MB4750.namprd10.prod.outlook.com (2603:10b6:a03:2d5::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.23; Sat, 13 Jan
 2024 16:10:56 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::4027:2de1:2be4:d12e]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::4027:2de1:2be4:d12e%3]) with mapi id 15.20.7181.020; Sat, 13 Jan 2024
 16:10:56 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Jeff Layton <jlayton@kernel.org>, Roland Mainz <roland.mainz@nrubsig.org>
CC: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: kernel.org list issues... / was: Fwd: Turn NFSD_MAX_* into
 tuneables ? / was: Re: Increasing NFSD_MAX_OPS_PER_COMPOUND to 96
Thread-Topic: kernel.org list issues... / was: Fwd: Turn NFSD_MAX_* into
 tuneables ? / was: Re: Increasing NFSD_MAX_OPS_PER_COMPOUND to 96
Thread-Index: AQHaRbZPBYb+SPTdz0iA03bgLbzGobDX06gggAAF7ACAABEfgA==
Date: Sat, 13 Jan 2024 16:10:56 +0000
Message-ID: <24ACA376-5239-4941-BE53-70BF5E5E4683@oracle.com>
References: 
 <CAAvCNcDtTNDRvUVjUy4BE7eBCgmkb6hfkq3P0jaGDC=OXg0=6g@mail.gmail.com>
 <CAKAoaQmmEv+HRjmBMrSMGZn9RQr8C=2W4yeX4vNnohXFJPCV5A@mail.gmail.com>
 <CAKAoaQmmEv+HRjmBMrSMGZn9RQr8C=2W4yeX4vNnohXFJPCV5A@mail.gmail.com>
 <65a29ca8.6b0a0220.ad415.d6d8.GMR@mx.google.com>
 <CAKAoaQkZ+b7NfrVi=gu1vCJBvv10=k85bG_kZV9G3jE45OOquw@mail.gmail.com>
 <0cd8fbfc707f86784dc7d88653b05cd355f89aad.camel@kernel.org>
In-Reply-To: <0cd8fbfc707f86784dc7d88653b05cd355f89aad.camel@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.300.61.1.2)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|SJ0PR10MB4750:EE_
x-ms-office365-filtering-correlation-id: 766f6f49-642b-4066-b300-08dc14523966
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 17xhIPyc1FJXU1OD88RlXkMYHVhiuii/B8HqAYfkcnfH/oMn/jngxMXlJ1SMHzm0ZJBnIOHzKWyHtxsgHkaK/coaen8c0iggrHool+5mjkurTSOD+DFqpAlV/MWF6UPR6eDwz+l1MkvNaeMthwIO8lN4HCijpAnyxDeW822N0gXoIDUuwq3MgQDKRbqyFqwUg3DN9mKNfHeWD1c+BVeDfbcievdL6mMbpnPbdFA387V6Qqe3JzeVX4++2ix7W46WBqISdirU6IQmO9c7wloZlQGdQ3fNMIUzJbBeW+ywixLMK+r5T3B9qdcEAxrYRIYyBuOCRtHeqU8AUlpu0yDL4M7y8VQ3C0RusGc0+ZOCi/NCNpSebHLCOsh7fQYPqk7YS1wXq93BC8gT8exPiVxdKo2mk6IRjcPkels1LMLYHI9F3slCPNYeZWAFpRhdWs2KPEi6MMOcbzoLdwUfoAS/TCStKcwRQVRI5nGGoTd3TFkDX+XOU/tC7oHq5/7DTpRyhW/hynbr+dOyeVtWFHpaURgm1STwwBBc04ShQpXpznfX7OWUMPI7rtukK8FJMCEkG4PirQj3+unKy+iyWIpvUS/EhNMh2txafdWfvAEN6e0w6b3ec97CwnTpeiPP4j1SXRl74pFq2LxZbpX0OOEppA==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(366004)(376002)(136003)(396003)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(66556008)(86362001)(122000001)(38100700002)(83380400001)(33656002)(26005)(2616005)(38070700009)(36756003)(6506007)(71200400001)(53546011)(6512007)(478600001)(6486002)(966005)(91956017)(316002)(66476007)(66446008)(66946007)(64756008)(110136005)(76116006)(2906002)(8676002)(8936002)(4326008)(5660300002)(41300700001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?dWUxRGlzaC9CK0tTbmk1WmpsckdmZDZQMTk1aEJZcm1pdWh4cVdiRmJiUGQr?=
 =?utf-8?B?bUhTUVZnOWlZRVV5ZG9pV1hmTyttUStxRDV5dkZQeGNvclhmQ3BmWC90QjVl?=
 =?utf-8?B?VTFyZENJRm9mSStOcDltWnZjTnYxN2UzbG1rOUNHUU02UDlCVk8rM0hDTm1s?=
 =?utf-8?B?dkY2N3B4YnlDenQrOWNxQ1VrM3hUVk5DSWoxRkRUR1hmZE9NZHRKc2ZHQkhn?=
 =?utf-8?B?YnorZkg5WnVuVlNTUmU1NTJGbXlpZ0xLTDFIazZwdVVUY1NCUUY0K2VFN2Iz?=
 =?utf-8?B?clprNTNya2xhUmhYcmhyZjNBbjlmeDNYMmZIYUUwOG03UmY3ZElkZGZYUDVu?=
 =?utf-8?B?SkFGYlpzdFRrNXY5MVpBUHFSUnpjQWRHTk9JOEVYSE4xd3QzSE0vWW1zb0hn?=
 =?utf-8?B?ZElqbHhjdlBzcVdtUGZjN0lmUGN0SFMwd1UyNzJTbkVWc2ZKbzY2UG5qaUFT?=
 =?utf-8?B?YUpFS0tNMVdsNTVVTFpFWU1wNlhVaFIwZHlEclpTZ04xQVBCb0lmUmdyS3pZ?=
 =?utf-8?B?YzNWeHVRbFBUWWdxbUgrTWNqQWZPMlRnYjB3WkJ3VHlHd25CNjZMN0VlUnh4?=
 =?utf-8?B?eEd6c3pmTEdabHpsL05TMVpBOGVXRnJLYmJvMStxUmVkZWZKUXJ6dEMzMm93?=
 =?utf-8?B?OFRaeDV2aFNoYytEenVWdW8vVFhEUEc2UXVTK2ZoVG9oOXNPWndUZFV4SUpr?=
 =?utf-8?B?ZVVHU0tYdmJZMDRmVGxlbGIxWnZMeCtZbTNVcUNXMFZYR1BQTXNidUJuTFB6?=
 =?utf-8?B?NUNaeGxjam9mUlM2QzRJMzdJc1o4N2xCV1lKY0RoTStxUWhLRjVkazJZa2gy?=
 =?utf-8?B?WnRLVDNadXo3NVdRWlMzbS9kWWFPSDBvNHJaUUVrNWRtQVErbFNkOVBKNC9Y?=
 =?utf-8?B?d0pERlllRk1RQnRJYTJoS0RLaVl4S1J2aGN4a2FqK2ZVZHBXVStaMU9RRDcz?=
 =?utf-8?B?VkxvWWZRaU9FR3VKd1plT3hkaHBybWxrZmVzdGErZ1paeUNOVTFOMHhHdVl4?=
 =?utf-8?B?Vk5yRlJBNmFDcGFJOGxCb3Y1b1h0aFRQRFdzYm45eHNVTC9mbStQMDBrUTBE?=
 =?utf-8?B?UlJnb2dGeWpJeTZkb1hLWWRrMFc4YTJsZEJ6NzVYbEJEcGN1aFdXTy9mMFpv?=
 =?utf-8?B?OTByZC9LMjdvYUNqejlOd1hqbTRhY1VzcjlEbVpVdllTQUZGc25VVlFWcENZ?=
 =?utf-8?B?MlIwb1ByaE0reXNkL0xPMWdpKzVlaWE4SVJYcnR6U2JISjlhOE55VE5haHFY?=
 =?utf-8?B?cGZHNjZpMFdFZXhBY2F0bzN1dGVjU3JjclZ5L0NYZTY4Nk05Y0xpd0kzNE9P?=
 =?utf-8?B?ZXJjSmdOMFhBUHRpbVpDQlUxdmtxZ1hrVURNbHdEQ2l6d2Y0UjJuMkhBWG9E?=
 =?utf-8?B?OEVrR3c0cTA5YUxjdVh1emRIZ0l2SE5IbjJESE40Rk5UVkxGNzFoZUNqekpK?=
 =?utf-8?B?YmxZZHQwV1RVSjNnVVJBWEN4NFAySlV2UmdxSktjVStNS1E4eFk0VWJuenMx?=
 =?utf-8?B?Y2tUTEN1TzZlVk9GcmZGeUt6T0E4OENEdnMvTHlYRHVvTEoxZG53R2tXUFRB?=
 =?utf-8?B?VmVWRktWa1MzTXpScmdIQ0RrSUNmb2JXZmIvTy9TR3lHV0JyUjZGaUQ4bVIz?=
 =?utf-8?B?cENXd1dUQkhWcmZMNHZDQ1EyQ0xVVy81YlpmTGRBQUcwNmd0UTJ1UFp2MjJt?=
 =?utf-8?B?dVNqUWlRdHlBTzFDYURURWpDaXJJNHZ5Uk1UTnNrVkZQOGRzbUJYVUhxSnBU?=
 =?utf-8?B?VWxNZVlDc0hqVDRXcUtrSHN1RmxoOS8vSHErVW5BN2RMcHI5RSsvTzYwbmZ5?=
 =?utf-8?B?ZjA1LzZoYTdZSlVXL2lPWUZ2NHBZeVpacnhTQmNtbmk1S3VTeEZaTS94VE9l?=
 =?utf-8?B?SEUydXN0aFliL3ZNbFRLcklBSzkxcmRWV0lJL3hFNlNKT1M3WkpKNVhtYlkv?=
 =?utf-8?B?UnVsaDBHZzM4eUM4MDZGNkwwS3dCb2ZaMnRnMEJrRCthcTJjUUsvRXB3K1h4?=
 =?utf-8?B?Z25lRjQwMjJGS0dvS2lLc2wrTXVUVU1FMWVIS3hhd0VsaWxHaVcrdTlEaHFm?=
 =?utf-8?B?N3VUemVTTitSaHN6cFBPR1hpZkswQkRJcGVSOTFBaUdNRkpxOXlKeEkvZXJP?=
 =?utf-8?B?ZTd2R2xoWk9mMEVxd1phdWF6MDhUd1ZFTXd0dDlFcWRTWmd0UGQyM0xhODU4?=
 =?utf-8?B?THc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CA99C7D56D4B154784F982F74C9C6ACA@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	JzJ4jI+gpq0jZruU2lQi0BG3Zxk4FAX+RJxihFxYYdclaj0ubCe+ucSroc/PeDnTuY84ZIKjUr1G5Q8DG0GjIOlapAZzUveAsejVE8SOzsl7ZRlucqE5Q6HBzSwbWGeJpdMFBJFMf5iImv2Ng1Nlxb8bda+WaI7Zr59M/KiJ/FDBrdihdcnyi78nb5VBa761B1MOPzIpDB6nk6jHDaIlhAr70ZBgjBIOs5zAZ88YjztTIXkq5XSR6feA5uW8zOLaI2rwiX1U/vJrFPcTBQC9Ep0HaqN8ZdSW69isDQBxE2M+XlUXRp3A8o7fpbjwFLR189DhrPai/nq2G/yAHllAOwDY0oguq47yJXDwHUsAM7vPFusaqfYOc2pqrIDum5P+kLOGIlnLlRmYRYN4po7ukrZ8PIyhClm0BH6HvgOiRQ6dRc7KaBDm+Fj4hYzexclImgltlI6cbzfGluwpb32rkgtgTiKFoxrQXRuSmxxPSr+1/rwVCyRjVoI2Hf7KxlHZ6/0RL0X+YYMszAi8hvLW4Q2zxHObN6s1aKyBVuRePIce9yAuynCDgDqrQl7XVZjDfQDAsy0qKo9sc/bhHzk8dnYnYD63vaJmOTma+h9hewg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 766f6f49-642b-4066-b300-08dc14523966
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jan 2024 16:10:56.2501
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: K93cMsdQaDD3ftpIAeGhMbeF0zXYAh+vlNuAA6zrJ8cr+IVM5fAuhUlGOrhNK/796VmHHAgviCdseStx+noazQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4750
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-13_07,2024-01-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 suspectscore=0
 phishscore=0 spamscore=0 adultscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401130136
X-Proofpoint-ORIG-GUID: 2Rq3-55LL2pri_YZZyRBm3jeeYF6Bu4z
X-Proofpoint-GUID: 2Rq3-55LL2pri_YZZyRBm3jeeYF6Bu4z

DQoNCj4gT24gSmFuIDEzLCAyMDI0LCBhdCAxMDowOeKAr0FNLCBKZWZmIExheXRvbiA8amxheXRv
bkBrZXJuZWwub3JnPiB3cm90ZToNCj4gDQo+IE9uIFNhdCwgMjAyNC0wMS0xMyBhdCAxNTo0NyAr
MDEwMCwgUm9sYW5kIE1haW56IHdyb3RlOg0KPj4gDQo+PiBPbiBTYXQsIEphbiAxMywgMjAyNCBh
dCAxOjE54oCvQU0gRGFuIFNoZWx0b24gPGRhbi5mLnNoZWx0b25AZ21haWwuY29tPiB3cm90ZToN
Cj4+PiBXZSd2ZSBiZWVuIGV4cGVyaWVuY2luZyBzaWduaWZpY2FudCBuZnNkIHBlcmZvcm1hbmNl
IHByb2JsZW1zIHdpdGggYQ0KPj4+IGN1c3RvbWVyIHdobyBoYXMgYSBkZWVwbHkgbmVzdGVkIGZp
bGVzeXN0ZW0gaGllcmFyY2h5LCBsb3RzIG9mDQo+Pj4gc3ViZGlycywgc29tZSBvZiB0aGVtIDYw
LTgwIGRpcnMgZGVlcCAoISEpLCB3aGljaCBsZWFkcyB0byBhbg0KPj4+IGV4cG9uZW50aWFsbHkg
c2xvd2Rvd24gd2l0aCBuZnNkIGFjY2Vzc2VzLg0KPj4+IA0KPj4+IFNvbWUgb2YgdGhlIGlzc3Vl
cyBoYXZlIGJlZW4gYWRkcmVzc2VkIGJ5IGltcGxlbWVudGluZyBhIGJldHRlcg0KPj4+IGRpcmVj
dG9yeSB3YWxrZXIgdmlhIG11bHRpcGxlIGRpciBmZHMgYW5kIG9wZW5hdCgpIChpbnN0ZWFkIG9m
IGp1c3QNCj4+PiBjd2Qrb3BlbigpKSwgYnV0IHRoZSBuZnNkIHNpZGUgc3RpbGwgd2FzIGEgcHJl
dHR5IGRyYW1hdGljIGlzc3VlLA0KPj4+IHVudGlsIHdlIGJ1bXBlZCAjZGVmaW5lIE5GU0RfTUFY
X09QU19QRVJfQ09NUE9VTkQgaW4NCj4+PiBsaW51eC02LjcvZnMvbmZzZC9uZnNkLmggZnJvbSA1
MCB0byA5Ni4gQWZ0ZXIgdGhhdCB0aGUgbmZzZCBzaWRlDQo+Pj4gYmVoYXZlZCBNVUNIIG1vcmUg
cGVyZm9ybWFudC4NCj4+IA0KPj4gTW9yZSBnZW5lcmFsIHF1ZXN0aW9uOg0KPj4gSXMgaXQgZmVh
c2libGUgdG8gdHVybiB0aGUgdmFsdWVzIGZvciBORlNEX01BWF8qIChtYXhfb3BzLA0KPj4gbWF4
X3JlcSBldGMuLCBlLmcuIGV2ZXJ5dGhpbmcgd2hpY2ggaXMgYmVpbmcgbmVnb3RpYXRlZCBpbiBh
IE5GU3Y0LjENCj4+IHNlc3Npb24pIGludG8gdHVuZWFibGVzLCB3aGljaCBhcmUgc2V0IGF0IG5m
c2Qgc3RhcnR1cCA/IEl0IG1pZ2h0IGhlbHANCj4+IHdpdGggRGFuJ3Mgc2NlbmFyaW8sIGJlbmNo
bWFya2luZywgY2xpZW50IHRlc3RpbmcgKGUuZy4gbXkgY2FzZSwgd2hlcmUNCj4+IEkgc3dpdGNo
ZWQgdG8gbmZzNGopIGFuZCB0dW5pbmcuLi4NCj4+IA0KPiANCj4gKHJlLWNjJ2luZyB0aGUgbWFp
bGluZyBsaXN0Li4uKQ0KPiANCj4gV2UgZ2VuZXJhbGx5IGRvbid0IGxpa2UgdG8gYWRkIGtub2Jz
IGxpa2UgdGhpcyB3aGVuIHdlIGNhbiBnZXQgYnkgd2l0aA0KPiBqdXN0IHR1bmluZyBhIHNhbmUg
dmFsdWUgZm9yIGV2ZXJ5b25lLiBUaGlzIHBhcnRpY3VsYXIgdmFsdWUgZ292ZXJucyB0aGUNCj4g
bWF4aW11bSBudW1iZXIgb2Ygb3BlcmF0aW9ucyBwZXIgY29tcG91bmQuIEkgZG9uJ3Qgc2VlIGFu
eSB2YWx1ZSBpbg0KPiBrZWVwaW5nIGl0IGFydGlmaWNpYWxseSBsb3cuDQo+IA0KPiBUaGUgb25s
eSByZWFsIGFyZ3VtZW50IGFnYWluc3QgaXQgdGhhdCBJIGNhbiBzZWUgaXMgdGhhdCBpdCBtaWdo
dCBtYWtlDQo+IGl0IGVhc2llciBmb3IgYSBtYWxpY2lvdXMgb3IgYmFkbHktZGVzaWduZWQgY2xp
ZW50IHRvIERvUyB0aGUgc2VydmVyLg0KPiBUaGF0J3MgY2VydGFpbmx5IHNvbWV0aGluZyB3ZSBz
aG91bGQgYmUgd2FyeSBvZiwgYnV0IEkgZG9uJ3QgZXhwZWN0IHRoYXQNCj4gaW5jcmVhc2luZyB0
aGUgbWF4IGZyb20gNTAgdG8gfjEwMCB3aWxsIG1ha2UgYSBiaWcgZGlmZmVyZW5jZSB0aGVyZS4N
Cg0KVGhlIHNlcnZlciBhbGxvY2F0ZXMgbWVtb3J5IGFuZCBvdGhlciByZXNvdXJjZXMgYmFzZWQg
b24gdGhlDQpsYXJnZXN0IENPTVBPVU5EIGl0IGV4cGVjdHMuDQoNCklmIHdlIGNyYW5rIHRoZSBt
YXhpbXVtIG51bWJlciwgaXQgaGFzIGFuIGltcGFjdCBvbiBzZXJ2ZXINCnJlc291cmNlIHV0aWxp
emF0aW9uLiBJbiBwYXJ0aWN1bGFyLCB0aG9zZSBleHRyYSBDT01QT1VORA0Kc2xvdHMgd2lsbCBh
bG1vc3QgbmV2ZXIgYmUgdXNlZCBleGNlcHQgaW4gYSBoYW5kZnVsIG9mIGNvcm5lcg0KY2FzZXMu
DQoNClBsdXMsIHRoaXMgYmVjb21lcyBhIHJhY2UgYWdhaW5zdCBhcHBsaWNhdGlvbnMgYW5kIHdv
cmtsb2Fkcw0KdGhhdCB0cnkgdG8gY29uc3VtZSBwYXN0IHRoYXQgbGltaXQuIFdlIGJ1bXAgaXQs
IHRoZXkgdXNlDQptb3JlIGFuZCBoaXQgdGhlIG5ldyBsaW1pdC4gV2UgYnVtcCBpdCwgbGF0aGVy
LCByaW5zZSwNCnJlcGVhdC4NCg0KSW5kZWVkLCBpZiB3ZSBpbmNyZWFzZSB0aGF0IHZhbHVlIGVu
b3VnaCwgaXQgZG9lcyBiZWNvbWUgYQ0Kc2VydmVyIERvUyB2ZWN0b3IgYnkgdHlpbmcgdXAgYWxs
IGF2YWlsYWJsZSBuZnNkIHRocmVhZHMNCnRyeWluZyB0byBleGVjdXRlIGVub3Jtb3VzIENPTVBP
VU5Ecy4NCg0KVXBzaG90IGlzIEknbSBub3QgaW4gZmF2b3Igb2YgaW5jcmVhc2luZyB0aGUgbWF4
LW9wcyBsaW1pdCBvcg0KbWFraW5nIGl0IHR1bmFibGUsIHVubGVzcyB3ZSBoYXZlIGdyb3NzbHkg
bWlzdW5kZXJzdG9vZCB0aGUNCmlzc3VlLg0KDQoNCj4+IFNvbGFyaXMgMTEgaXMga25vd24gdG8g
c2VuZCBDT01QT1VORHMgdGhhdCBhcmUgdG9vIGxhcmdlDQo+PiBkdXJpbmcgbW91bnQsIGJ1dCB0
aGUgcmVzdCBvZiB0aGUgdGltZSB0aGVzZSB0aHJlZSBjbGllbnQNCj4+IGltcGxlbWVudGF0aW9u
cyBhcmUgbm90IGtub3duIHRvIHNlbmQgbGFyZ2UgQ09NUE9VTkRzLg0KPiBBY3R1YWxseSB0aGUg
RnJlZUJTRCBjbGllbnQgaXMgdGhlIHNhbWUgYXMgU29sYXJpcywgaW4gdGhhdCBpdCBkb2VzIHRo
ZQ0KPiBlbnRpcmUgbW91bnQgcGF0aCBpbiBvbmUgY29tcG91bmQuIElmIHlvdSB3ZXJlIHRvIGF0
dGVtcHQgYSBtb3VudA0KPiB3aXRoIG1vcmUgdGhhbiA0OCBjb21wb25lbnRzLCBpdCB3b3VsZCBl
eGNlZWQgNTAgb3BzIGluIHRoZSBjb21wb3VuZC4NCj4gSSBkb24ndCB0aGluayBpdCBjYW4gZXhj
ZWVkIDUwIG9wcyBhbnkgb3RoZXIgd2F5Lg0KDQoNCkknZCBsaWtlIHRvIHNlZSB0aGUgcmF3IHBh
Y2tldCBjYXB0dXJlcyB0byBjb25maXJtIHRoYXQgb3VyDQpzcGVjdWxhdGlvbiBhYm91dCB0aGUg
cHJvYmxlbSBpcyBpbmRlZWQgY29ycmVjdC4gU2luY2UgdGhpcw0KbGltaXQgaXMgaGl0IG9ubHkg
d2hlbiBtb3VudGluZyAoYW5kIG5vdCBhdCBhbGwgYnkgTGludXgNCmNsaWVudHMpLCBJIGRvbid0
IHlldCBzZWUgaG93IHRoYXQgd291bGQgIm1ha2UgTkZTRCBzbG93Ii4NCg0KDQo+PiBJIGd1ZXNz
IHlvdXIgY2xpZW50cyBhcmUgdHJ5aW5nIHRvIGRvIGEgbG9uZyBwYXRod2FsayBpbiBhIHNpbmds
ZQ0KPj4gQ09NUE9VTkQ/DQo+IA0KPiBJcyB0aGVyZSBhIHByb2JsZW0gd2l0aCB0aGF0IChhc3N1
bWluZyBORlN2NC4xIHNlc3Npb24gbGltaXRzIGFyZSBob25vcmVkKSA/DQoNClllczogdmVyeSBj
bGVhcmx5IHRoZSBjbGllbnQgd2lsbCBoaXQgYSByYXRoZXIgYXJ0aWZpY2lhbA0KcGF0aCBsZW5n
dGggbGltaXQuIEFuZCB0aGUgbGltaXQgaXNuJ3QgYmFzZWQgb24gdGhlIGNoYXJhY3Rlcg0KbGVu
Z3RoIG9mIHRoZSBwYXRoOiB0aGUgbGltaXQgaXMgaGl0IG11Y2ggc29vbmVyIHdpdGggYSBwYXRo
DQp0aGF0IGlzIGNvbnN0cnVjdGVkIGZyb20gYSBzZXJpZXMgb2YgdmVyeSBzaG9ydCBjb21wb25l
bnQNCm5hbWVzLCBmb3IgaW5zdGFuY2UuDQoNCkdvb2QgY2xpZW50IGltcGxlbWVudGF0aW9ucyBr
ZWVwIHRoZSBudW1iZXIgb2Ygb3BlcmF0aW9ucyBwZXINCkNPTVBPVU5EIGxpbWl0ZWQgdG8gYSBz
bWFsbCBudW1iZXIsIGFuZCBicmVhayB1cCBvcGVyYXRpb25zDQpsaWtlIHBhdGggd2Fsa3MgdG8g
ZW5zdXJlIHRoYXQgdGhlIHByb3RvY29sIGFuZCBzZXJ2ZXINCmltcGxlbWVudGF0aW9uIGRvIG5v
dCBpbXBvc2UgYW55IGtpbmQgb2YgYXBwbGljYXRpb24tdmlzaWJsZQ0KY29uc3RyYWludC4NCg0K
DQo+PiBJcyB0aGlzIHRoZSB3aW5kb3dzIGNsaWVudD8NCj4gDQo+IE5vLCB0aGUgbXMtbmZzNDEt
Y2xpZW50IChzZWUNCj4gaHR0cHM6Ly9naXRodWIuY29tL2tvZmVtYW5uL21zLW5mczQxLWNsaWVu
dCkgdXNlcyBhIGxpbWl0IG9mIHwxNnwsIGJ1dA0KPiBpdCBpcyBvbiBvdXIgVG9EbyBsaXN0IHRv
IGJ1bXAgdGhhdCB0byB8MTI4fCAoYnV0IGhvbm9yaW5nIHRoZSBsaW1pdA0KPiBzZXQgYnkgdGhl
IE5GU3Y0LjEgc2VydmVyIGR1cmluZyBzZXNzaW9uIG5lZ290aWF0aW9uKSBzaW5jZSBpdCBub3cN
Cj4gc3VwcG9ydHMgdmVyeSBsb25nIHBhdGhzIChbMV0pIGFuZCB0aGlzIGlzc3VlIGlzIGEga25v
d24gcGVyZm9ybWFuY2UNCj4gYm90dGxlbmVjay4NCg0KDQpBIGJldHRlciB3YXkgdG8gb3B0aW1p
emUgdGhpcyBjYXNlIGlzIHRvIHdhbGsgdGhlIHBhdGggb25jZQ0KYW5kIGNhY2hlIHRoZSB0ZXJt
aW5hbCBjb21wb25lbnQncyBmaWxlIGhhbmRsZS4gVGhpcyBpcyB3aGF0DQpMaW51eCBkb2VzLCBh
bmQgaXQgc291bmRzIGxpa2UgRGFuJ3MgZGlyZWN0b3J5IHdhbGtlcg0Kb3B0aW1pemF0aW9ucyBk
byBlZmZlY3RpdmVseSB0aGUgc2FtZSB0aGluZy4NCg0KDQotLQ0KQ2h1Y2sgTGV2ZXINCg0KDQo=

