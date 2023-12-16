Return-Path: <linux-nfs+bounces-674-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 544DB815A72
	for <lists+linux-nfs@lfdr.de>; Sat, 16 Dec 2023 17:41:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12196285B66
	for <lists+linux-nfs@lfdr.de>; Sat, 16 Dec 2023 16:41:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8B052E623;
	Sat, 16 Dec 2023 16:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="bTyeELno";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="AgaZ/n8I"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE0BD30F95
	for <linux-nfs@vger.kernel.org>; Sat, 16 Dec 2023 16:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BGDXuKY011371;
	Sat, 16 Dec 2023 16:39:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=CeTomH+nFTS8y80SJAJbNW3V2Bg0rAWHUm+0KyUHjlA=;
 b=bTyeELnojVXWcFXkuJ1boov4fVe3n1xanS2SfBqrWvTGOVaiUlujd+kqywWYLIdtc7OP
 7maYc5WOGv0PQDGN+wstalKjCkhT7sqCqjsFk53/js9rPeHBFY9luXmFTf1w2M2DMR+k
 Pw8CxXlcvG61Dz5nEUN+hBlWMb9sZ+RVhGlLTNWXg9WcfXmL/4ex3Y1VfqfioOo3Ub7O
 FVC9FeF0SjOsy09IQxy8dVx8dQgMilnVGHcrRjiSIq78EPXUaCmoTsOewUEhFlewi/qC
 /kjTtDHeiRyyRS5rSuKGnRkWSDql3MQ+FZnfvdKc8YCazEieB0zIf3FCj7xR7z4aR6lk JA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3v13gu8py9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 16 Dec 2023 16:39:04 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3BGCWRXl029159;
	Sat, 16 Dec 2023 16:39:03 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3v12b3be0d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 16 Dec 2023 16:39:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ze5NFWy0+o5JZjpiVDK5BmydjZQGvYVYYvIXz8eGL6A+7ITFWIN9l72KnGR262JYNoQzs+qhxn/84hTYgH+Rt1Y0x+rX9LFP18G8JKO0Od/SK7OGw/5PKc7CGdc/anTzs7MuM39PzOpMF62EuuF4ZmdZsX0E9bhbUEm5Xwj+PFDnmd9rYYYAb70annHcCutwwS3LCj/DpRM7PguIjhtixxvxR2t0+FonVwyUqqIRLERK+Ia/Rbsao2OkdI1gDJpVCG/L/eFaxjgbBFP4orM2OVSw3tqopJCj+qEaZgQk2s12eBOEdClt1+EdwQUuWmqa2RtEwgvKMK0ejEGtxOF+Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CeTomH+nFTS8y80SJAJbNW3V2Bg0rAWHUm+0KyUHjlA=;
 b=jK/GD+8/yaSokdDU/UjJsPMpKr1ZpvvSN2nT2Ts4jx4Rdf8McFbKbYhsOoVU361UJoIj2VQW4kBkIj9l2OKa/nxOi/r9vCun9trtfrjVXehcAiPcY+woP9AggFANlEc9PFJf0t5d5ov8soU5rTB+Fd+AbHjlzqALBT/Pl7iPEsqtnr89BeikQSFs02gwWSEaza70U3MoPGuJKkYi0lPpz7jgZvXj6rQpMinccV0BG9IGqX8vau2dIc7CzQhmpggT57fqKCj5nb+78VICFFJUjxgyBGseEbSfq60+oOORHlTjLeSbcJFE6ABWo2/MwzvPHL15hYypKrGjwOzGVG2UiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CeTomH+nFTS8y80SJAJbNW3V2Bg0rAWHUm+0KyUHjlA=;
 b=AgaZ/n8IBCJWI2TM/PpBIqKMjR9nYy+Bd1K5JmGxBQt1JIEGcwH60rRG4UJovI/t+d73pxCRcWUBjjuYzGS6VDaNRkgIqFGpDHZXWhy2Us+iPLx4WELwOU0aeS+RKh/k2W0q4ttgwUs3W+nDRzXKYfW4fbrup+DlLMD9GaHOkqw=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by IA1PR10MB7418.namprd10.prod.outlook.com (2603:10b6:208:445::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.36; Sat, 16 Dec
 2023 16:39:01 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c%4]) with mapi id 15.20.7091.034; Sat, 16 Dec 2023
 16:39:01 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Benjamin Coddington <bcodding@redhat.com>
CC: Dai Ngo <dai.ngo@oracle.com>, Jeff Layton <jlayton@kernel.org>,
        Linux NFS
 Mailing List <linux-nfs@vger.kernel.org>,
        "linux-nfs@stwm.de"
	<linux-nfs@stwm.de>
Subject: Re: [PATCH 1/3 v2] SUNRPC: remove printk when back channel request
 not found
Thread-Topic: [PATCH 1/3 v2] SUNRPC: remove printk when back channel request
 not found
Thread-Index: AQHaL6BODuJxHzRsvEmtdxXl8tg1rLCrwk6AgABbIwA=
Date: Sat, 16 Dec 2023 16:39:01 +0000
Message-ID: <A958C4F7-7DA4-4BA2-BAA5-9552388F5498@oracle.com>
References: <1702676837-31320-1-git-send-email-dai.ngo@oracle.com>
 <1702676837-31320-2-git-send-email-dai.ngo@oracle.com>
 <66BB600A-2C0D-457A-9A13-0F1D7F5E44B7@redhat.com>
In-Reply-To: <66BB600A-2C0D-457A-9A13-0F1D7F5E44B7@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.200.91.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|IA1PR10MB7418:EE_
x-ms-office365-filtering-correlation-id: 114ca5cd-a6fc-423f-6c61-08dbfe558241
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 AFg1Q6dgMgadqTL8RH9j5CB0lAfsjUkhdeaSJMVss29qDIIUuREDw2Czh8Yu9rECeHe6vGQEnyyA34a920LRDWzBmTOqquQL7edPS14H7RAL0EplbyplypqE7+keNMB3I1ITV3i7UH9Cor52BxuyrC5hau8otRu8olxFvjquGslx5Apa7uQ+v3Qvq/nK8gnwaSftU9g5/5krVVgCIvzaAnLE132mfYCuLPsfEX/FHu8qwn7kURsAPM7ezEBSSfUJA+aBsFEYSUldCLQ2LGXytprxVH6eCjPxkUgHqszo+6wK932WUBT2Z0LRdRLgiAni5Ii/JBFEJ+GPL6TJXU4yrcUazkU0wq5Usca7Ff6a8rWwb/L+CNGkMQJHleykjLvrmHT6Ag7rirNOLrIGY7SOs3SHKW71lqhohynxP86sWkQKfhIGlnwU7Cyfmi9TGvL5fmN4NtI02AlbGdYCH+PAMk9eDpLQnnja7yRRcWmRNbC/12mTmbIbUJIDOMuFMe7Uu4IFzL0uvmHknMuY+dhq8HbbIHZ+t/ybF9jhz657UcpdDM+RdoOCNDZ/FpIDLjGiumd3AhKbBFaA2Y7njR4FFHit/8WfDspX4BWRmODRSTJ12KMSwcmXJDojsJI18RaGaB9dZCrxos5ImKjGc0V1qZ1AKWcEeos7dhoADSAtHE5f8Tnedac2aQrdaDEalIhn
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(346002)(136003)(366004)(39860400002)(230922051799003)(230173577357003)(230273577357003)(186009)(1800799012)(451199024)(64100799003)(83380400001)(66946007)(66556008)(2616005)(66476007)(6916009)(66446008)(64756008)(91956017)(76116006)(478600001)(54906003)(316002)(38100700002)(26005)(6486002)(4326008)(8936002)(8676002)(6506007)(53546011)(71200400001)(6512007)(5660300002)(2906002)(33656002)(86362001)(122000001)(36756003)(41300700001)(38070700009)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?OUhLcmFEcXAxN1NaRUFRTGZSNUJobDVaS1plemFVYmVidDlmZ0E0NXE2YlV0?=
 =?utf-8?B?SWR2TWE2ZGdWdkowdEJ3em1TaVB0YS9kdng1bEZFWWRwVjd5cVltMFpDaVdU?=
 =?utf-8?B?NEtDVStvWlZYeERZMDZMMlpCamx3OThyeStZWGZOWUhFL1cvaXpkVG1JaHhW?=
 =?utf-8?B?WDBUMXgwWTRlUDhQUnd2M2FMR0VEZnBSVzBKa2ZTNlV1dk1ISms0YlByQ0xs?=
 =?utf-8?B?YVYvKzBSeGpWQThBOTRGSEpxSkp5TG5hSUlQSjU5R2IvR21JRGdtdUtHS2w4?=
 =?utf-8?B?VWpzUW9kMEs5VjVMcXlLZ2pjalZXVjZVbVJpbTkzdGgraW0xSzNtNE9pdVFI?=
 =?utf-8?B?bm9MRFZMTUxRY1NUUWR1QVV1WE95bkdGbmxqUi9rZVRoRmpVSnd5ZTN5cXhW?=
 =?utf-8?B?SS80UHE5N3hpK0ZhMWF0S3FHbmlyZUxlSFNZbUJTS3FRUlpYVUhJMWFPUzlo?=
 =?utf-8?B?djFZakgyRmcrYm0wUW1SZFJsc2Nza1FPUkcxUzhYb2psZzlDdDNTOWV1ZVhP?=
 =?utf-8?B?a1F5TzlPdUJCQW5hRGwveGs0OXVhWjZJUEVpY2pBei9SeE5BWEtmZE95QjEx?=
 =?utf-8?B?cHB4MmlWTWRvazFiVlppenQ2UkVnUzZlcmhPRGxPdjd5OUFqeGR6MFZjUitI?=
 =?utf-8?B?dXdMbVFQVHpPa2NMNjBZSnBQUEp1eW1xNDE3MmhMWC9FejNiV3FvK215bzM4?=
 =?utf-8?B?eXhuc1VENEY1V3FLajJVM29vNmdXcjdrOWtNMGRWdnhSaHk5YnVOcExUMFFV?=
 =?utf-8?B?N1VnK2hhSUxSM3p5OUZSUGdPODcwa29VeWtBS0crVE1GeFRRNmVqVmcwdmtF?=
 =?utf-8?B?WXdIM3h3cnp5eFEzZTZla0JKMi9EUE5talc5bE1sNUNUK25uc1FMQ3hCMVlv?=
 =?utf-8?B?WTVvb0dtR3h1ejE5cTAyYThDRFpqV2MzNjNXWmRGTTA2NHhMaVdMYndoZklu?=
 =?utf-8?B?eHFLb1d2emQ2RDVQcHExdTIxTERyaXpFbTdDMWM1QUVJSzBObXorTDFtSHBi?=
 =?utf-8?B?L0tSUFNzMjl2b0FtTjFGa213amdNZFpsSkszOU5xRnJ0Mlhta3ZITis1MWcr?=
 =?utf-8?B?SVloemlUSkhnK0VJdGYxcU00b2s2eTF2cm1tdCtlbU1VaGNucXBucEpHNmhX?=
 =?utf-8?B?WWxYRm5TbEs4RWZUZmtkNkQvcTg3cmRha1U4anRQODVxWDRlOThVcFRsdHYv?=
 =?utf-8?B?R01KSTJUT0xwWm1TbVZXWTE0UlVZZzJYYVVrYUtFK1BteVoyaEZ5bnpYdzdh?=
 =?utf-8?B?OFptekE4cFpKNEpGVTNwQXN4MnBJZS9qSElzMUwxZGhQc0hLdFV4UlA0cXBT?=
 =?utf-8?B?dDlYb3huYlBGWDZjUzM0b2NOZUxkZEE5d1o4YVJzd3BHYjRvZ0tlZy9HN2RI?=
 =?utf-8?B?ekpLMWFwWC94SG9KMnJWS3JpVndXTG5vMmFJdEZVN1JwTjB4L1k4SkllNEVF?=
 =?utf-8?B?KzYwQ3JtUG5RL1hlLzJra3VMdU1UOWdkNWNjZko2c2FWVkFvMlF0dUN6UjdI?=
 =?utf-8?B?TlZUNmhMVWJrd3JXVzhOS3hpbk5jYlhmaXJ6UDJZdjgxZ3puYVRROUJNOWNJ?=
 =?utf-8?B?RHJVQklQa2V0NzUyd21vTXYzYXpOUlRXbGRNd04rR2gwa2FOYTNDbVJIcjRl?=
 =?utf-8?B?dVFsOVpQZThhY25kanROZ3VPdTh5YXBybm4rZW5ENURZUHd0K1g2SkJuQ0pH?=
 =?utf-8?B?bG1OY251VmtFN282SDZQbkI2NnNoY28zZWdTdG9BWU1EY255UjhtTWZiRGJG?=
 =?utf-8?B?d3p4VnJSTC9uTTRVempldytlTFVjMEJZZnE3eVZSa1c4TDJDU1hWVFZFZnYy?=
 =?utf-8?B?aitsdGhKdkZTNGlZeGVUN1M4aGZ4Q2ZIK3NXQlZrSmdpaVBPWWFSSmQ1clZM?=
 =?utf-8?B?NTJHTkJiVmRWY2Q0VmNpNVA3MEh0NnUwWnZ1RjljdW5VaEZZeDNVUjZUT1VC?=
 =?utf-8?B?K0xsNU5UZGV3ZzRSdlBuOUlnb1YvaWRPMGxlbGdzSWtaMTYrNmo2TGtBcktY?=
 =?utf-8?B?SHZiVGkvYnRZbS9jMm9UQW1UdEZTV0NxSnNGeGhmMXdyc2dldmJ2TFIyM2JZ?=
 =?utf-8?B?cFE3Q0kvdVZZeFZPTW05UjBmekJqV0FDZTBpM1g0ZmtIN3NDUVBqUFhxUnJh?=
 =?utf-8?B?TDZxS1FQQVA3T25LSG9OOXBsUjQ4TnpOaFFlN0djQ2x6dG1Rci82czI0Ukx2?=
 =?utf-8?B?bVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C641C8AE6BCAD544970C533523005348@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	5Cy5qFpPeTBnV0kZzfYiBw81dfETfP/bhdqr3R/X4V2s7/t4NNG4jHmgdghTI9ZxgAuUjzkudZhZIgwGh8z89h2pp8gJp6I3duvC+LVMmlEHlNNoz0sG7aepKt8ZETe5E5p0bzvVTYT1tcbW6fSRbG2AwpTGGrT1lfnwY+H/ydsGGbe0/BpOe1VDUZ/wlLvvYHYuq0j7ce4s4LmwAfZNuuLr9EaT8WT7MDFTO5BDM3wMoLOXi9iUc7nApIK1DnGTq3rFdeNOEqvp6XOxbrhslMVTV1DYuzbHCTNdSoDLwEbPXxxZY02/8gCrj+vaCNmT9mo1xjd5h3P+fOHugP/PYRlHuDb/Y4MoqzMRIIpu8zkw8qVvzJZ+lGCy4JvNkiFh4+apwR++Cv3f+hqcXj1Hlh/dy8rEsQbsRA9nVotpYxPz451rRtNkrnF7FZuBKeI+hvIU65FC34KixGUY6eiCHjseVcaudDePSfbowlO9W3uzFcuwbDfYW4XKXUF2aYGVPQ6PrLIEEU5HTBbdsScZ2nQmtEhH4HfYkTRIvHNwUjuY7eggLFL+Dcin8Wf1p/HuU22pVyOURp2nivgbOL/WY4PJCdf1sYNJKIxRIXNrTYw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 114ca5cd-a6fc-423f-6c61-08dbfe558241
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Dec 2023 16:39:01.3474
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TTv+Amn7HGVAZSexCLaQqHeaKETcI4HCmRuO7M5VwWxTJwZo65ys6SKGhqUlIL0zEwtVCFrdIKSipnsQV6CJ9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7418
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-16_13,2023-12-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 malwarescore=0 phishscore=0 mlxscore=0 bulkscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2312160128
X-Proofpoint-ORIG-GUID: _QREadcekWJma1_CWQ5C2anZFwm23kQL
X-Proofpoint-GUID: _QREadcekWJma1_CWQ5C2anZFwm23kQL

DQoNCj4gT24gRGVjIDE2LCAyMDIzLCBhdCA2OjEy4oCvQU0sIEJlbmphbWluIENvZGRpbmd0b24g
PGJjb2RkaW5nQHJlZGhhdC5jb20+IHdyb3RlOg0KPiANCj4gT24gMTUgRGVjIDIwMjMsIGF0IDE2
OjQ3LCBEYWkgTmdvIHdyb3RlOg0KPiANCj4+IElmIHRoZSBjbGllbnQgaW50ZXJmYWNlIGlzIGRv
d24sIG9yIHRoZXJlIGlzIGEgbmV0d29yayBwYXJ0aXRpb24gYmV0d2Vlbg0KPj4gdGhlIGNsaWVu
dCBhbmQgc2VydmVyLCB0aGF0IHByZXZlbnRzIHRoZSBjYWxsYmFjayByZXF1ZXN0IHRvIHJlYWNo
IHRoZQ0KPj4gY2xpZW50IFRDUCBvbiB0aGUgc2VydmVyIHdpbGwga2VlcCByZS10cmFuc21pdHRp
bmcgdGhlIGNhbGxiYWNrIGZvciBhYm91dA0KPj4gfjkgbWludXRlcyBiZWZvcmUgZ2l2aW5nIHVw
IGFuZCBjbG9zZXMgdGhlIGNvbm5lY3Rpb24uDQo+PiANCj4+IElmIHRoZSBjb25uZWN0aW9uIGJl
dHdlZW4gdGhlIGNsaWVudCBhbmQgdGhlIHNlcnZlciBpcyByZS1lc3RhYmxpc2hlZA0KPj4gYmVm
b3JlIHRoZSBjb25uZWN0aW9uIGlzIGNsb3NlZCBhbmQgYWZ0ZXIgdGhlIGNhbGxiYWNrIHRpbWVk
IG91dCAoOSBzZWNzKQ0KPj4gdGhlbiB0aGUgcmUtdHJhbnNtaXR0ZWQgY2FsbGJhY2sgcmVxdWVz
dCB3aWxsIGFycml2ZSBhdCB0aGUgY2xpZW50LiBXaGVuDQo+PiB0aGUgc2VydmVyIHJlY2VpdmVz
IHRoZSByZXBseSBvZiB0aGUgY2FsbGJhY2ssIHJlY2VpdmVfY2JfcmVwbHkgcHJpbnRzIHRoZQ0K
Pj4gIkdvdCB1bnJlY29nbml6ZWQgcmVwbHkuLi4iIG1lc3NhZ2UgaW4gdGhlIHN5c3RlbSBsb2cg
c2luY2UgdGhlIGNhbGxiYWNrDQo+PiByZXF1ZXN0IHdhcyBhbHJlYWR5IHJlbW92ZWQgZnJvbSB0
aGUgc2VydmVyIHhwcnQncyByZWN2X3F1ZXVlLg0KPj4gDQo+PiBFdmVuIHRob3VnaCB0aGlzIHNj
ZW5hcmlvIGhhcyBubyBlZmZlY3Qgb24gdGhlIHNlcnZlciBvcGVyYXRpb24sIGENCj4+IG1hbGlj
aW91cyBjbGllbnQgY2FuIHRha2UgYWR2YW50YWdlIG9mIHRoaXMgYmVoYXZpb3IgYW5kIHNlbmQg
dGhvdXNhbmQNCj4+IG9mIGNhbGxiYWNrIHJlcGxpZXMgd2l0aCByYW5kb20gWElEcyB0byBmaWxs
IHVwIHRoZSBzZXJ2ZXIncyBzeXN0ZW0gbG9nLg0KPiANCj4gSSBkb24ndCB0aGluayB0aGlzIGlz
IGEgc2VyaW91cyByaXNrLiAgVGhlcmUncyBwbGVudHkgb2YgdGhpbmdzIGEgbWFsaWNpb3VzDQo+
IGNsaWVudCBjYW4gZG8gYmVzaWRlcyB0cnkgdG8gZmlsbCB1cCBhIHN5c3RlbSBsb2cuDQoNCkl0
J3MgYSBnZW5lcmFsIHBvbGljeSB0byByZW1vdmUgcHJpbnRrJ3MgdGhhdCBjYW4gYmUgdHJpZ2dl
cmVkIHZpYQ0KdGhlIG5ldHdvcmsuIE9uIHRoZSBjbGllbnQgc2lkZSAoeHBydF9sb29rdXBfcnFz
dCkgd2UgaGF2ZSBhIGRwcmludGsNCmFuZCBhIHRyYWNlIHBvaW50LiBUaGVyZSdzIG5vIHVuY29u
ZGl0aW9uYWwgbG9nIG1lc3NhZ2UgdGhlcmUuDQoNCg0KPiBUaGlzIHBhcnRpY3VsYXIgcHJpbnRr
IGhhcyBiZWVuIGFuIGV4Y2VsbGVudCBpbmRpY2F0b3Igb2YgdHJhbnNwb3J0IG9yDQo+IGNsaWVu
dCBpc3N1ZXMgb3ZlciB0aGUgeWVhcnMuDQoNClRoZSBwcm9ibGVtIGlzIGl0IGNhbiBhbHNvIGJl
IHRyaWdnZXJlZCBieSBtYWxpY2lvdXMgYmVoYXZpb3IgYXMgd2VsbA0KYXMgdW5yZWxhdGVkIGlz
c3VlcyAobGlrZSBhIG5ldHdvcmsgcGFydGl0aW9uKS4gSXQncyBnb3QgYSBwcmV0dHkgbG93DQpz
aWduYWwtdG8tbm9pc2UgcmF0aW8gSU1POyBpdCdzIHNvbWV3aGF0IGFsYXJtaW5nIGFuZCBub24t
YWN0aW9uYWJsZQ0KZm9yIHNlcnZlciBhZG1pbmlzdHJhdG9ycy4NCg0KDQo+IFNlZWluZyBpdCBp
biB0aGUgbG9nIG9uIGEgY3VzdG9tZXIgc3lzdGVtcw0KPiBzaGF2ZXMgYSBsb3Qgb2YgdGltZSBv
ZmYgYW4gaW5pdGlhbCB0cmlhZ2Ugb2YgYW4gaXNzdWUuICBTZWVpbmcgaXQgaW4gbXkNCj4gdGVz
dGluZyBlbnZpcm9ubWVudCBpbW1lZGlhdGVseSBub3RpZmllcyBtZSBvZiB3aGF0IG1pZ2h0IGJl
IGFuIG90aGVyd2lzZQ0KPiBoYXJkLXRvLW5vdGljZSBwcm9ibGVtLg0KDQpDYW4geW91IGdpdmUg
c29tZSBkZXRhaWxzPw0KDQpJdCB3b3VsZCBiZSBPSyB3aXRoIG1lIHRvIHJlcGxhY2UgdGhlIHVu
Y29uZGl0aW9uYWwgd2FybmluZyB3aXRoIGENCnRyYWNlIHBvaW50Lg0KDQoNCi0tDQpDaHVjayBM
ZXZlcg0KDQoNCg==

