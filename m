Return-Path: <linux-nfs+bounces-205-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A477B7FF11D
	for <lists+linux-nfs@lfdr.de>; Thu, 30 Nov 2023 15:04:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A3DC281FD9
	for <lists+linux-nfs@lfdr.de>; Thu, 30 Nov 2023 14:04:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70B7247A59;
	Thu, 30 Nov 2023 14:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="PdyUcbKk";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="jD7Zh+9U"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7CD710F0
	for <linux-nfs@vger.kernel.org>; Thu, 30 Nov 2023 06:03:57 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AUDnq6j002891;
	Thu, 30 Nov 2023 14:03:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=ACsU5GQEZpUiEMII2rvIZFqu6z7BBIGAVisC01bCuVI=;
 b=PdyUcbKk2C5rR2Y/py0BpUH+CS8AVxA3ttEi8wkYw0qdbQCMLZ1YfBX2tQ7i9tGV3TcH
 j33qZoFcuHM83xzMCT/MCLZq6Ww9Grl4hqi5La52aoRElpUR+oi0tqqJyKKzZevJLxjP
 /F4TEyTb+TpoSmDMn410OHFtvddL0lvB4YJANZgOTOOpa6z78a4ARCD8gUrwxBmnbTC3
 nQ9dWo3R4aqaqBPg/4A1QJAybfp/W36C+8RQCiwlIrUAKus0OLGcrtaaRJHbAx5ApWB7
 9BZPr2PPwCiosvSR7ZXMiNN/KcYbNyQOwyiJLMncmTNL0mv24b1Hz6ncRTVvtjufPMXt HQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3upu9kr2nr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Nov 2023 14:03:56 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3AUCPOBm026493;
	Thu, 30 Nov 2023 14:03:55 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3uk7ca4emm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Nov 2023 14:03:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RSoiL/w+gRkO4ctHpQi6Br14Xgt2Ux8/oODV5PB8KZSmDb9Jp7rxHKRodS0wqSBq50tFZK6C7zwuwV/lPzSHTB+lBGuRf4K3E32POjbabaamIaXbLI9qgYffVYxfPHtt9u/dOsO6Yc/+GL5aHuUuT3/+P8ZRshj+2IKRbb+lIeYFfrJJn7AElstlW018WKV75RccLgzRUGMapMAIhTM5iNgHy8LLq3LX1wZ36/3ZS53pswN6fVUI0bNMS+y4ajLumNgKJd13jp69URWAFNkN2TKecVNCaWU6/6lpqSDcpCjnYWWXj4e7ZQfJn/f7qYKrELpYl8SursiY2RZC69cEyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ACsU5GQEZpUiEMII2rvIZFqu6z7BBIGAVisC01bCuVI=;
 b=Nnz0d/ZwaEMJWQ+bIcWRqXygkXyhlh9+/4dQ3aaQ7Ui6qi6axhd0H3nviS2bsKVaoPIOZW1jftGvMe7h6nzZPIHfeJ2YrD3j0tBGvBy5MD+z3f30y2/dlGBHS0NnkPQIpP3jlNAIEOZ+ZoDVzwuLvG639vYf5YPoqaZdK5pCAfyN7EMz9Q+5oWPKcGT2TmY3qBFxmeoOR6GDT0zgKTM5cfcO2myIsEug/CFtTCtSlixxGyq0NKMCstLz/wB7uNsvY6cP7CQXwrL0DSi1jA70iywTjq+CWPiTJN1SW2D94qX5w8RthETqwQcPg2Xa1T19xfaZrKnfVPJLWJW0vkbvJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ACsU5GQEZpUiEMII2rvIZFqu6z7BBIGAVisC01bCuVI=;
 b=jD7Zh+9UGSkYU4kvHhQZS3EFB+VhCRP5kaFcuqOeG1ArhqpmgBoT1iNZ9vOszuZWDbBUiA3zuqMb57VH85dfXxXTbSD9CebmDPXrO31CBwBuSoOk9l3x68QSqKbmn6xnDghH+ZDgT5zVU87bBd0GMbFUfC1X0OIc6ZBkrydmXw4=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CY8PR10MB6610.namprd10.prod.outlook.com (2603:10b6:930:56::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.27; Thu, 30 Nov
 2023 14:03:50 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c%4]) with mapi id 15.20.7046.024; Thu, 30 Nov 2023
 14:03:50 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Martin Wege <martin.l.wege@gmail.com>
CC: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: NFSv4 alternate data streams?
Thread-Topic: NFSv4 alternate data streams?
Thread-Index: AQHaI0GeBpbKRni6mkOBsRTBE2M9rbCS5YcA
Date: Thu, 30 Nov 2023 14:03:50 +0000
Message-ID: <DBD9B468-6FF2-4806-8706-EE679BF69838@oracle.com>
References: 
 <CANH4o6PeiV+ba0uLVzAnbrA3WtG8VSkvjA1_epfLCVyH-r-pJw@mail.gmail.com>
In-Reply-To: 
 <CANH4o6PeiV+ba0uLVzAnbrA3WtG8VSkvjA1_epfLCVyH-r-pJw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.200.91.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|CY8PR10MB6610:EE_
x-ms-office365-filtering-correlation-id: b69010b2-8fa8-46d6-7d61-08dbf1ad2e02
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 ngOHQeaMZSxJFmjMDT3uNt7aORUL3hzzXOpE9ZH6c6UJ5ewrUt+IRQf1y+456+HvU1R3ijVAaAMzR/nnTGxQNpAte38w9bcT5JKs50SVAnvYadQbHLopBBgdbXfMD1I/DFS8/Jj7fAHjxDFKFWpf3VLC/M34RfbqLpRIwudDlauWf5Zo/G7HsIvuq+/ryNS7L3EaaLk4zqIGn65MfoLScsNK80VweUzRBANfuhBsSVaL0jIdE6v6DRFsL90anLKNWGVtywyn2hrG8wrqsblduf3+dAlU7L2bdUAM91KmTwktWXIr3DXDSzWGL2nBRbayJyu+v3q5tsf/yj3tI5ipYMAwAQcPjYUlhR4F8MYvaicnXtnXxPcqHZb0HTp00tcjQVzvZ5mkr0hZPISctFa1AtP7oTiNDTq2Vs6xcqHyd5mbzVU+x+5v5jf47qu3V5vppTpJ6vBB4bgV4fwTZ8d7heyrU21lzOm+tZcxQBnEWAQt0L/3cotZBiL1nusEu6vmFLv+gINoHBFSpnBR2XcbmuMLPxHvKRiGxUtnODUtXdoKPAXc57jsaMc0gizWHLL/2H+0yXMnXpXKeVRxYbPZCE+H6jug41kj/KJDDlPE4fY5n74qBq5geiVg02lddDeypD3RHD854xLB8K1Lt4/FfQ==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(396003)(39860400002)(346002)(376002)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(122000001)(38100700002)(86362001)(36756003)(38070700009)(33656002)(8676002)(66476007)(4326008)(66446008)(41300700001)(5660300002)(4744005)(76116006)(2906002)(26005)(66556008)(53546011)(91956017)(6512007)(66946007)(2616005)(6916009)(64756008)(8936002)(316002)(6486002)(71200400001)(6506007)(478600001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?SFV1WkNCTXRkek5sUkdtQXBIbGNVRjhKSGF6VUZZOTJua0ZYS2VibmI2cFMz?=
 =?utf-8?B?cko1dWRiVnRVVVd3R01GOEZ3QWVqQ1dhQTVONzF3K0NsaXFXS3RlY3JXZmpL?=
 =?utf-8?B?NU1oVS9sbmdDVUNTdldlbmdrNTkvS292U05SbnlaTUNwSVlQRnBwMWNJcW9C?=
 =?utf-8?B?cEZXUURVQkJpVm9VUFJqMVdJcHV4V014QTJNMndKL0NwZFBsQUs2Y3FOU2Rp?=
 =?utf-8?B?OUtTS2Z1NFZ1ZzBBY3FVR21jYmVxb20welFzNGhqUS9rY2ZkWEF6RFVVNUp4?=
 =?utf-8?B?Tkp2TWJ4ZCtRd3BmRFkzZUxFZDBMUldic2FUYnhzSmtHd2ErZ3lyRnRMbHN4?=
 =?utf-8?B?clVZY2pidkEzQ3UxUnhXTWVHbE12QzRwTjU2WTVQUnMrZmZRL0xadkxNTE80?=
 =?utf-8?B?QTJveTRHVm8zZmhjVU4vQ3Q0SEFpdTVDWms3Smwwa1NGL0NVUHdVUHVIZWcw?=
 =?utf-8?B?WVN3UTB3ZGx4dFloNzhQcDBLQWxPTXFlck8xVWovdDV3M2FlZWZYdmtjb2Yv?=
 =?utf-8?B?SDU0ditsWXBCTjR3dVVtMHFBRUp2bkoycHFmdE4xTDY1R3p2Qi9obzlSR2F4?=
 =?utf-8?B?Yjg3V1VWUi83YWZnakg3Tllzb3p2ZEl2cEE2bkVEQlBZc2d4WEtDMzZFZDlL?=
 =?utf-8?B?REFVNkI4ZHRoaFVzanFRZmhPWlhaRXJGQjJMMjM4aGpTL3ZFY0VxTHYrNzla?=
 =?utf-8?B?aDJ5amJJVDVHYnROTVpSWjdZTUxOV3ZrSkR5Mi9hTGUxclVoWVFQdDB5Tmhu?=
 =?utf-8?B?b3A5cFQzdmphaVFoak9CWWE4bjIxVVZ2VU5qU0lVdVhBcDB6eVByVlppNXJS?=
 =?utf-8?B?THRQL0VuOEtwV2JLWnRLZWhpaERCZE1ZVkxvZm9XaU9HK1V5Zm41NGg4U1Np?=
 =?utf-8?B?Q2VEajlMeGtCNFhGeUtNQW40aUZOeGw1VmtXVzk3QW9WYmw3cFNLdGM2YWdX?=
 =?utf-8?B?TXNHQ0hKdGlTbjlLQm45L3d5UTUvOHAzR0tQUXNKWHlQclNFRzIvbWlYM1Q2?=
 =?utf-8?B?YTFkeXd5VW5HSENTSVZqK0JvcXFRR0dqL2FkT3BhM25nTkhYMUpKYm8wYlBl?=
 =?utf-8?B?WnFUVSs2T0daQ05CQjZGQjNsbTNGajZLZVZYeGNjMWJhOXErMDlyYUxtdzZE?=
 =?utf-8?B?VzB0eG1lZSsyZU1jWE9nR0U1T2FHVXBtSXR5MFAzbGJ6OGYxRC93c20zVmw0?=
 =?utf-8?B?cjA0WXhYMEFmUlZablhHeXJNbnlvTGRNV1ZHbXRXeGovZHBVSWtZcHBJWjFa?=
 =?utf-8?B?NHRtWTRya2VqTG9veU1tVEJIb3FoZ1ErcVFXUFFBMmhEOU5zdEYza0tYVFdz?=
 =?utf-8?B?MDF5ZUtvODZTbzBtclNFTTMxVTRIYTJRQVF4TzRhVFVCV0RKa2FYVVJ1clVQ?=
 =?utf-8?B?c01Fb0UyWWlnczVodi9qSVIyZ0RvaGZtT0dJNDVGT1RqeEM5Yy8xeVlxOHll?=
 =?utf-8?B?c1hIR0JLN0JOcHRMcXpCT3JTR3ZaV2xnTXZRYVlXckVIdU85MHl6MkVOd0NF?=
 =?utf-8?B?Q2NMemhXZlMyU3d3SExaWUk4cnRmb0RTSS9iZDJGME1JVGgwUWxSSDFVY0cx?=
 =?utf-8?B?RyszeUM1MDZUVExUeHoyWk50UTRSanY4SmhnS0dpRElxVmJtc3FMWHVvb2Vm?=
 =?utf-8?B?eWY5dklDdVlDWTZZckhGak1lRlZqMWNZLzZ5VjF5bEdSSUZGWUxnSjFXMGFU?=
 =?utf-8?B?aE4waG5MbUtTRC81b1Q3WVVpOUdFTVBXNWpoMkNCWUlZWDF6SkJhbXVJbm5i?=
 =?utf-8?B?ZktQT1JZd3JFSE9tVGo1Z2FjNmVJbUxNckxtdncwamtMV3hSQ3dTbTduQTVW?=
 =?utf-8?B?aU8zTjU5OTkvazI3OVJKSjVKV0V3emFuRzhScStoRUFSbCtRYTRoOGVKdDBx?=
 =?utf-8?B?TUtnaEdNQkduN3Fpcjh4VnVmdXE3c1E4VW9ic2NwcnBueS9BZGNteHhrVEgv?=
 =?utf-8?B?SWpiVlZheHZCQm4rQ0VjZHN2WDY5OGFiSnJaaGU3eWVOWEJ4MFE4eUxUY2Ru?=
 =?utf-8?B?bjR4MEJuOFE5TE9CYkFRU2FkLzRTRWZYdGUyQmJ6VkhSekpBR2hUVnBkZW5Q?=
 =?utf-8?B?TGUwUEtVQ084WG9pampJVDRTTUxXdFBUQlI5enFIR1VSeDlCVWFQN0Q0SklQ?=
 =?utf-8?B?eVp1bCtMc2taTHdncGkxeTQ3Ym1JVzk0eWJVc1JBK2lKbTE5U1NQUFl2d09s?=
 =?utf-8?B?SVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AFFA1EA19128D54BB67C4D8B0BF51716@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	CKtbvF3Ac/RuYZPKgZG4JO/had/LHl88bDiaLIaskcn1mG7VHsddjNxvA5tdm/v5PTwwCyOY4X8xWEUR+jnexD8rHEpVOCrs9Qijwiz+sYSskSG2Xat7RvhVBacAZpZQS52Itu9J5ic2hA0Zxidg6NjyNbFK7k62Rp+pviKIgRuqculdSNkqGJmg0kWxU40VsnIZ3KxqlGa2V6ff/fhj4Dj/2NeDGxhi8vjL7bECw+IHMCg4nEYpUwpTtYmEO77FJngAjS6BUGUGO/DmL/y4H7IAIwlEbZ5IQexiaTOc5NV68lBlyK9X8T6U0qaltU8kriRIqg3HxQU24A2pNzefHIL3Fv+wdnx/KZGF/d2GTctx85r994I1eAunft9Aa3/36jfxOMCLiApBEQ6VCjRsChdF/EiIr1p9GnCxqMgSBsUUqXB37JWGq1EUlJYVDQRlqRGqYpH7rzr8kZJAb/ITb1PkrUm70cDPCdnfpFNWv02FWRT1Iw5QAaMVvcsa6dOcw0WMN9mFjQcsSTa0dG9bfKOWagByVdNqJgZWPiad8SpKUuEYI0cNunH0W00vtagaoZ7YSUQSwdhXPqbbwVZZ2vEGcjiazTgPx5LwepbHO+MLf+W8ijN2Vq1i5ggKh6NUcydNZs0BKXJfthkQ0BicKMHmS8GAbGcFqfuvWXe6KMm4yj4aPB/3Mwj3lL+1w1BokHvuCEaH7T99MZfulz+SHlnHFB0uObGT2VfOIXW57WiHu5R3CDs4CcriRxafOJP5757/ddBsquruHqby++P9Vxvu/+WeNG/3G4MnNbVxtDI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b69010b2-8fa8-46d6-7d61-08dbf1ad2e02
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Nov 2023 14:03:50.6206
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Vn6RMvaUHVkBOawa3JQbfAwQ794yE4byYJUCLxYRu8kbNJrsy3aWpry8GM+iZu4MfAE4aL0UCA6nyTiFPeT1NQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6610
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-30_12,2023-11-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 mlxlogscore=997
 bulkscore=0 adultscore=0 phishscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311300103
X-Proofpoint-GUID: 5dPXiBat_rKVr6gh0Uh52lQuPooTAmw3
X-Proofpoint-ORIG-GUID: 5dPXiBat_rKVr6gh0Uh52lQuPooTAmw3

DQoNCj4gT24gTm92IDI5LCAyMDIzLCBhdCAxMDo1OeKAr1BNLCBNYXJ0aW4gV2VnZSA8bWFydGlu
Lmwud2VnZUBnbWFpbC5jb20+IHdyb3RlOg0KPiANCj4gSGVsbG8sDQo+IA0KPiBkb2VzIHRoZSBM
aW51eCBORlN2NCBzZXJ2ZXIgaGFzIHN1cHBvcnQgZm9yIGFsdGVybmF0ZSBkYXRhIHN0cmVhbXM/
DQo+IFNvbGFyaXMgc3VyZWx5IGhhcywgYnV0IHdlIHdhbnQgdG8gcmVwbGFjZSBpdC4gQXMgb3Vy
IFdpbmRvd3MNCj4gYXBwbGljYXRpb25zIChEQikgcmVseSBvbiBhbHRlcm5hdGUgZGF0YSBzdHJl
YW1zIHRoZSBxdWVzdGlvbiBpcw0KPiB3aGV0aGVyIHRoZSBMaW51eCBORlN2NCBzZXJ2ZXIgY2Fu
IGZ1bGx5IHJlcGxhY2UgdGhlIFNvbGFyaXMgTkZTdjQNCj4gc2VydmVyIGluIHRoYXQgcmVzcGVj
dC4NCg0KSGkgTWFydGluIC0NCg0KTGludXggTkZTRCBkb2VzIG5vdCBzdXBwb3J0IGFsdGVybmF0
ZSBkYXRhIHN0cmVhbXMgYmVjYXVzZSBub25lIG9mDQp0aGUgdW5kZXJseWluZyBmaWxlIHN5c3Rl
bXMgb24gTGludXggaW1wbGVtZW50IHRoZW0uIFZlcnkgbXVjaCBsaWtlDQp0aGUgSElEREVOIGFu
ZCBBUkNISVZFIGF0dHJpYnV0ZXMuDQoNCkkgYmVsaWV2ZSBTb2xhcmlzIGFuZCB0aGVpciBzdG9y
YWdlIGFwcGxpYW5jZSBhcmUgdGhlIG9ubHkNCmltcGxlbWVudGF0aW9ucyBvZiBORlMgdGhhdCBk
byBzdXBwb3J0IHRoZW0sIHNpbmNlIHRoZXkgaGF2ZQ0KaW1wbGVtZW50ZWQgc3RyZWFtcyBpbiBa
RlMuDQoNCkluc3RlYWQsIExpbnV4IE5GU0QgaW1wbGVtZW50cyBleHRlbmRlZCBhdHRyaWJ1dGVz
ICh0aGF0J3Mgd2hhdA0Kb3VyIG5hdGl2ZSBmaWxlIHN5c3RlbXMgYW5kIHVzZXIgc3BhY2Ugc3Vw
cG9ydCkuIEkgcmVhbGl6ZSB0aGF0DQp0aGUgc2VtYW50aWNzIG9mIHRob3NlIGFyZSBub3QgdGhl
IHNhbWUgYXMgc3RyZWFtIHN1cHBvcnQuDQoNCi0tDQpDaHVjayBMZXZlcg0KDQoNCg==

