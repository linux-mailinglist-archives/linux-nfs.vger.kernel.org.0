Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 831E43BEFDA
	for <lists+linux-nfs@lfdr.de>; Wed,  7 Jul 2021 20:51:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230141AbhGGSyG (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 7 Jul 2021 14:54:06 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:52248 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229993AbhGGSyF (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 7 Jul 2021 14:54:05 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 167ImJBC028474;
        Wed, 7 Jul 2021 18:51:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 to : from : subject : content-type : mime-version; s=corp-2020-01-29;
 bh=V7363S3Nqg2UOFlvypfxTC/E0kqp1p+oOUDKxE+WMLw=;
 b=Rnhcn600RJ8C6wZlHESEIvO4CtUU8tXqowpR3azhiHtw6e6d3O+7/w1qDZmzfTArAETj
 3YFkyz3ZNZzJoQ0g7F8gLy7gKUiCVcADzEsuL6UVdalactgA62A3Ovv6XPnjlmtiFvMH
 4nd87raJD+QOG7tJQ74DtdC16Ffog4nHNMny12V2JgjCcmFEA47Rw43YkjEObBVZcFqp
 VnTxWOt6cy5b39z0ve5iaRlGgcUJvm6IIBphaFGbpSw/IBPIyLmJ/pLs5naJd95Ne6Mr
 SCnC+90n3W/ybrdb31rSotqA9gxrCAWNBRH88ATr9KeXp/iQEBwCUgvah3CdSofA/FvY pw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 39m3mhctc7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 07 Jul 2021 18:51:23 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 167IkZ03068212;
        Wed, 7 Jul 2021 18:51:22 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2174.outbound.protection.outlook.com [104.47.57.174])
        by userp3020.oracle.com with ESMTP id 39k1nxq8wg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 07 Jul 2021 18:51:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HMd8KagsHknZzdxbNU7SUcG1MV9e1X9oZ2P8ZRxH6ClftUnBZswRttUed1IukhG8lfKXcyocqx1ddBxbAR5klBDpORqyINfk9bY825ROvV25DiGnPPDQ5mTY3hK94Y9ohL1gTrFI4AJ/+2wMkMyIp1OLYedZ+5Vyd9krup1z0ai72au6K/4elczmNs5Fj7JxIbu6mc/jk0DNwopQ4zCtHD6cCb+T+IBxXX1J7a34i52JoPt98GZcuaguL5Fo9aSP/skGy/zVyJ0kuiArxzNlnec5cIkTsHEW+jeIvrPVwEWQn1Y0+z28mUiPNFJ1iBLY4c1SGhU3Nsysdsi7Vz13Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V7363S3Nqg2UOFlvypfxTC/E0kqp1p+oOUDKxE+WMLw=;
 b=dG5n7Dop3Wt8J3ec89ej50JxSxyY6h6HQdaw+E7f3UewZ6eZPvmZPws66jAPSub3QRxYaO5AMRG47VPtdjh3LFXsAfoFTRu2yojT1FO1A6UdKoyT7H+9W0ozHaq/dA68cN6kcHtIpOwbcpafx2500dbxHHhEyfCftXCnSlBxyCa84QN1G7V+vRQmz1STEiRJslltcbXue802oUojMhDLSF+aGtMiMrJKVxoK2l7flMCCoR47LCCHCbBeKmHT46RXjKe2ac+jxpYp6DiC6HXViaTpI9cG1ZCfJ0NN10cyw7gJ3KhhvosX0j94bkd6Mk6uk/L/JIK56X3EqdVfNcw9ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V7363S3Nqg2UOFlvypfxTC/E0kqp1p+oOUDKxE+WMLw=;
 b=eyrNe3g8f/Moj9C78PXkFHgU6pr7f+fbKjrmFXMg5ha+mfOnr2waJ1QbpFo3XiiBV2fBaH3+e0rOF95WPRllT82Eb4A8VSTlSXnUaVGaKs6lhCDmWwR5lxoXP+nI5y4MSnxqiOOnxvEdwuKEQRmmLU6QrTwVtGS49sWSDX5nzoA=
Authentication-Results: hammerspace.com; dkim=none (message not signed)
 header.d=none;hammerspace.com; dmarc=none action=none header.from=oracle.com;
Received: from BN0PR10MB5143.namprd10.prod.outlook.com (2603:10b6:408:12c::7)
 by BN8PR10MB3234.namprd10.prod.outlook.com (2603:10b6:408:ca::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.20; Wed, 7 Jul
 2021 18:51:20 +0000
Received: from BN0PR10MB5143.namprd10.prod.outlook.com
 ([fe80::e9de:7386:9785:8f69]) by BN0PR10MB5143.namprd10.prod.outlook.com
 ([fe80::e9de:7386:9785:8f69%9]) with mapi id 15.20.4308.020; Wed, 7 Jul 2021
 18:51:20 +0000
Message-ID: <6cbd9cf8-49e9-868e-6452-1da2498c1358@oracle.com>
Date:   Wed, 7 Jul 2021 19:51:15 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.0a1
Content-Language: en-GB
To:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
From:   Calum Mackay <calum.mackay@oracle.com>
Organization: Oracle
Subject: nfs_page_async_flush returning 0 for fatal errors on writeback
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------GpE5vlbwBf0P1Jxil2OUQNcE"
X-ClientProxiedBy: LO4P123CA0376.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18e::21) To BN0PR10MB5143.namprd10.prod.outlook.com
 (2603:10b6:408:12c::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.254.15] (90.247.82.180) by LO4P123CA0376.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:18e::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.19 via Frontend Transport; Wed, 7 Jul 2021 18:51:19 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c04c39d6-2214-4eaf-656f-08d94178358c
X-MS-TrafficTypeDiagnostic: BN8PR10MB3234:
X-Microsoft-Antispam-PRVS: <BN8PR10MB3234B350E919020D349C801CE71A9@BN8PR10MB3234.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CS82w1B+iT6Bd6/H0Ck8TIMJ7HU//XxXReUKLvn9HckIxnxzIk5ohCWkskJWK+ChCscFM9LE3rU2hKIVO/D7CsKktC+d4mj726J9bA2wH+CpfYAUu2MmBq/2tPf80ziYkEgjn1X4aVEeJbMQ5CNVgRc1cWHQnSZo/eaghxQnPmiHHs2rNLzUAD+bVfjwaK8RnRJb8vR0L1J5KBTgN56p1V48ozBXr8zN3XGX1cy33iZdIopXln3sj99+ZnXrOgwRDUI4q9WoK3pIEQM2roPiV9X3BBQ+T4tOtIjYhE8L/YZNW3/GP851waHASe1ZEQyVKliEgA5rOfUqi8gsBThFQXl+AYbG/ttWkT9UMCdf2Lv/FBDhYI/H/uwK0DR+KCO5PjI+VY0u2qOEBTAYzpfgpDO8oGGoK5iuQsQljKs9WVTZIfryOS0js81dW3B8VWzzbtch45XE9GyX/8KRG7+DmAwsoCYM00eqp/Or7fFxvp34ECXzBaWXo0IxhxF+IBi15U2WpREKpEN/SW1DgqQML36uBwK+kfcsNP90F8lE8pzcRNrWtKsdRluYn+pqemXHy/XShLt9dcBd5qFZig0KWWsSuCFQzU6AzLr1ZDaXKfcVvQ3QOqsyWfNtrn5LCywrvbjqSKUcu8kyVuwk86pejMjqJAeBlK3cZtN5LUGTNCxu4VjBECqqkDhuyvSwLgcyVMuosA+rkb82AQ8nWLYW4GsVr2CBxHbQP48zissf5MNOn+kWydGnRCWSCEOclko4
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5143.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(39860400002)(136003)(396003)(346002)(376002)(31686004)(66556008)(66946007)(66476007)(8936002)(6666004)(5660300002)(235185007)(2616005)(956004)(44832011)(36756003)(478600001)(316002)(110136005)(186003)(26005)(8676002)(21480400003)(16576012)(86362001)(38100700002)(33964004)(2906002)(31696002)(6486002)(83380400001)(36916002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dFRURkFaUU5SWjVJcU5WWm5EQzIwb1NWSXpyYXFITk9QY0U3SStUR1Q0a3NH?=
 =?utf-8?B?Vm1JVGp2Nm1BbVllU1FoaGpvdUtMY053cUgvS0xwZlVyM2t4YXZjUUc3N1d0?=
 =?utf-8?B?YnFTK1N5enk1TS9LMDE3UVo4WFV4R01idHdiVlNUcG5PNGxpbkZFZ0JDYnhW?=
 =?utf-8?B?c21BSTExWTRkcm5tdUROVVNQNlptNzVlejcxSGV1OGRRMCtudnpmWXNwOTM5?=
 =?utf-8?B?UldoK1RiVFExaFk0TTZPZGNxOXM3Q2Q2alQrNXI5bVBwNnM2RmhpdU4wbmFz?=
 =?utf-8?B?S0pFdmdFUmRMR3BDcytoQis0TldUS2o1QXNBWTJuam8xcDArMUVET1FmRmlC?=
 =?utf-8?B?bkdaM2kvSHNZUFJPeGQwb09KM2lsYVBMU000S1pCcEdGZmtSMXJDSUN6aXky?=
 =?utf-8?B?Q2EyYVQ4SWljTVpOVlhOWlJRaUphZTdEQWptTDJvVEw5WTRZRElSbUtwSVhP?=
 =?utf-8?B?bEpOd0JjNitCZ1BGbHRSbHZjdkdkaW9qMGtHN0VDc25LT0Rpc1p6Z0xyNVBY?=
 =?utf-8?B?NUlhTGJwQVVXLzhGVHlWM0tlMTNXZ25GS2hyQkFTbUo1ZHIwSE1ONWI1NExk?=
 =?utf-8?B?VjQ0bUlXWGI1NGdqTXZkZjJ4WVkzaHE2SGtzTUtwK2tjTTdqajVQSEpQK09I?=
 =?utf-8?B?MWh4YmpMNkRHTjVDdzJRRkllanUxRVI2SVJraGRhN3FhZGZ2Ukpqa2hnMS9D?=
 =?utf-8?B?SVphR1ZOY2syb2phbmxFZHNadENuUGhEdTNEcUtFU3FpR0x3b0hZRUp4ZnNT?=
 =?utf-8?B?OFJZNGhWSk1wclh1Zk8rcm1rNVk4cTQwVTNJSkNScEJ3aEo1MEtwelJDZzZY?=
 =?utf-8?B?WmJ1SFRFeGIvMWZWM2JVNCtNVkcyVlNKM3o1ejBvY1poaUlheVY4U2x2aWZO?=
 =?utf-8?B?MVdGK0tabWNTOEFzT2pqQ3J4eGpUbkh2SGN3V3FnWVBNY01peW9wbEpNRTc4?=
 =?utf-8?B?VnB3NGd1MnJkcm5sci9DdzVtMUlNdnFBYjAxc2NZOWFsV2hLb3dFSUdoMGNh?=
 =?utf-8?B?OThLNmJ2M1dhWVZwRklDbjNYdk9tUmtqMURwRzFpMGVtSmNIRFN3NzlpM1lS?=
 =?utf-8?B?M3VsbkRUT0k1VEdiVTdTMGNMZXdEREZzTTZ2cTE1SlJ6YitRL3RIYWhwYk4v?=
 =?utf-8?B?WXRCSTJ6UHZVTVRVYjRNR0dlWDJHekp3TE1DY2Era3F2Q0dJUUhsekpTMUJo?=
 =?utf-8?B?MUM0eUVNN0g1aUtiWUJ1RDdUUVZJelV5MndScGhrNGVvVXdlVm9Yd3NUUGpJ?=
 =?utf-8?B?OGlJREsrRlVxODdEQWJ4em0wY1NGdW1XU2s3cGs2WGlvNHpQN1JlZE9EVlVs?=
 =?utf-8?B?UVczejZ0UndORnQ1S2hVaEpqMWN3TEZZamFPcVdaNHhxOEV5TElxUXk5Vi9p?=
 =?utf-8?B?Mkw4Ti80cUZVaHNPM09VN0ErdTVWeG54bVJ6d28wOXNXc2RPWW15eFJ1cHp5?=
 =?utf-8?B?SDdVRFBVWXp2cWZHS1hqQ0g1SXFEVTJTaUZteS8xK0ZHcUluaFNCc0cxT2pM?=
 =?utf-8?B?RHRWeUdSRFFsMjRFc3hvU3AyeUtTRzFKS2YvbWxTOElzYUs1NjZUTDNYL09M?=
 =?utf-8?B?NHRNQ1EyOTgxaENOZFppKzMzWklxa3QyaG00dWlUNE8yNE1IWUxreUx3M2hL?=
 =?utf-8?B?K0VNS292LzVhUVo5WS9nUmxxVEdEVHkyNjFQRWtpUWg0NVp4T2grb3FEL24x?=
 =?utf-8?B?L25RekZyc2pGdEZSZFpPV2k2RzYxbW5tOW1XL0IwQjVqOTBFcUNNcHBvZDRN?=
 =?utf-8?Q?XKO9TkTx9fHsfj4Yo8JNHKdMVjoImCz598cu+Bl?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c04c39d6-2214-4eaf-656f-08d94178358c
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5143.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2021 18:51:20.2165
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hQ2I8mEizw5ZzUxkjkP3Eq2OeBXO4SifIP3RWeJfRSEiujubrlnKimbzqxfp/MfkdS4gArP3DtgjycvgYHN86g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR10MB3234
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10037 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 phishscore=0
 adultscore=0 suspectscore=0 mlxscore=0 mlxlogscore=950 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2107070108
X-Proofpoint-GUID: dCj3Ji56tze7WN7OqNFfsVMqjcQ1zjbL
X-Proofpoint-ORIG-GUID: dCj3Ji56tze7WN7OqNFfsVMqjcQ1zjbL
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

--------------GpE5vlbwBf0P1Jxil2OUQNcE
Content-Type: multipart/mixed; boundary="------------me5VN7OgJnhvr1V2pM4gUVlR";
 protected-headers="v1"
From: Calum Mackay <calum.mackay@oracle.com>
To: Trond Myklebust <trond.myklebust@hammerspace.com>,
 Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Message-ID: <6cbd9cf8-49e9-868e-6452-1da2498c1358@oracle.com>
Subject: nfs_page_async_flush returning 0 for fatal errors on writeback

--------------me5VN7OgJnhvr1V2pM4gUVlR
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

aGkgVHJvbmQsDQoNCkkgaGFkIGEgcXVlc3Rpb24gYWJvdXQgdGhlc2UgdHdvIG9sZCBjb21t
aXRzIG9mIHlvdXJzLCBmcm9tIHY1LjAgJiB2NS4yOg0KDQoxNGJlYmUzYzkwYjMgTkZTOiBE
b24ndCBpbnRlcnJ1cHQgZmlsZSB3cml0ZW91dCBkdWUgdG8gZmF0YWwgZXJyb3JzICgyIA0K
eWVhcnMsIDIgbW9udGhzIGFnbykNCg0KOGZjNzViZWQ5NmJiIE5GUzogRml4IHVwIHJldHVy
biB2YWx1ZSBvbiBmYXRhbCBlcnJvcnMgaW4gDQpuZnNfcGFnZV9hc3luY19mbHVzaCgpICgy
IHllYXJzLCA1IG1vbnRocyBhZ28pDQoNCg0KSSBhbSBsb29raW5nIGF0IGEgY3Jhc2ggZHVt
cCwgd2l0aCBhIGtlcm5lbCBiYXNlZCBvbiBhbiBvbGRlci1zdGlsbCANCnY0LjE0IHN0YWJs
ZSB3aGljaCBkaWQgbm90IGhhdmUgZWl0aGVyIG9mIHRoZSBhYm92ZSBjb21taXRzLg0KDQog
ICAgICAgIFBBTklDOiAiQlVHOiB1bmFibGUgdG8gaGFuZGxlIGtlcm5lbCBOVUxMIHBvaW50
ZXIgZGVyZWZlcmVuY2UgYXQNCjAwMDAwMDAwMDAwMDAwODAiDQoNCiAgICAgW2V4Y2VwdGlv
biBSSVA6IF9yYXdfc3Bpbl9sb2NrKzIwXQ0KDQojMTAgW2ZmZmZiMTQ5M2Q3OGZjYjhdIG5m
c191cGRhdGVwYWdlIGF0IGZmZmZmZmZmYzA4ZjE3OTEgW25mc10NCiMxMSBbZmZmZmIxNDkz
ZDc4ZmQxMF0gbmZzX3dyaXRlX2VuZCBhdCBmZmZmZmZmZmMwOGUwOTRlIFtuZnNdDQojMTIg
W2ZmZmZiMTQ5M2Q3OGZkNThdIGdlbmVyaWNfcGVyZm9ybV93cml0ZSBhdCBmZmZmZmZmZmE3
MWQ0NThiDQojMTMgW2ZmZmZiMTQ5M2Q3OGZkZTBdIG5mc19maWxlX3dyaXRlIGF0IGZmZmZm
ZmZmYzA4ZGZkYjQgW25mc10NCiMxNCBbZmZmZmIxNDkzZDc4ZmUxOF0gX192ZnNfd3JpdGUg
YXQgZmZmZmZmZmZhNzI4NDhiYw0KIzE1IFtmZmZmYjE0OTNkNzhmZWEwXSB2ZnNfd3JpdGUg
YXQgZmZmZmZmZmZhNzI4NGFkMg0KIzE2IFtmZmZmYjE0OTNkNzhmZWUwXSBzeXNfd3JpdGUg
YXQgZmZmZmZmZmZhNzI4NGQzNQ0KIzE3IFtmZmZmYjE0OTNkNzhmZjI4XSBkb19zeXNjYWxs
XzY0IGF0IGZmZmZmZmZmYTcwMDM5NDkNCg0KdGhlIHJlYWwgc2VxdWVuY2UsIG9ic2N1cmVk
IGJ5IGNvbXBpbGVyIGlubGluaW5nLCBpczoNCg0KICAgIG5mc191cGRhdGVwYWdlDQogICAg
ICAgbmZzX3dyaXRlcGFnZV9zZXR1cA0KICAgICAgICAgIG5mc19zZXR1cF93cml0ZV9yZXF1
ZXN0DQogICAgICAgICAgICAgbmZzX2lub2RlX2FkZF9yZXF1ZXN0DQogICAgICAgICAgICAg
ICAgc3Bpbl9sb2NrKCZtYXBwaW5nLT5wcml2YXRlX2xvY2spOw0KDQphbmQgd2UgY3Jhc2gg
c2luY2UgdGhlIGFzIG1hcHBpbmcgcG9pbnRlciBpcyBOVUxMLg0KDQoNCkkgdGhvdWdodCBJ
IHdhcyBhYmxlIHRvIGNvbnN0cnVjdCBhIHBvc3NpYmxlIHNlcXVlbmNlIHRoYXQgd291bGQg
ZXhwbGFpbiANCnRoZSBhYm92ZSwgaWYgd2UgYXJlIGluIChmcm9tIGFib3ZlKToNCg0KICAg
IG5mc19zZXR1cF93cml0ZV9yZXF1ZXN0DQogICAgIG5mc190cnlfdG9fdXBkYXRlX3JlcXVl
c3QNCiAgICAgIG5mc193Yl9wYWdlDQogICAgICAgbmZzX3dyaXRlcGFnZV9sb2NrZWQNCiAg
ICAgICAgbmZzX2RvX3dyaXRlcGFnZQ0KDQphbmQgbmZzX3BhZ2VfYXN5bmNfZmx1c2ggZGV0
ZWN0cyBhIGZhdGFsIHNlcnZlciBlcnJvciwgYW5kIGNhbGxzIA0KbmZzX3dyaXRlX2Vycm9y
X3JlbW92ZV9wYWdlLCB3aGljaCByZXN1bHRzIGluIHRoZSBwYWdlLT5tYXBwaW5nIHNldCB0
byBOVUxMLg0KDQpJbiB0aGF0IHZlcnNpb24gb2YgdGhlIGNvZGUsIHdpdGhvdXQgeW91ciBj
b21taXRzIGFib3ZlLCANCm5mc19wYWdlX2FzeW5jX2ZsdXNoIHJldHVybnMgMCBpbiB0aGlz
IGNhc2UsIHdoaWNoIEkgdGhvdWdodCBtaWdodCANCnJlc3VsdCBpbiBuZnNfc2V0dXBfd3Jp
dGVfcmVxdWVzdCBnb2luZyBhaGVhZCBhbmQgY2FsbGluZyANCm5mc19pbm9kZV9hZGRfcmVx
dWVzdCB3aXRoIHRoYXQgcGFnZSwgcmVzdWx0aW5nIGluIHRoZSBjcmFzaCBzZWVuLg0KDQoN
CkkgdGhlbiBkaXNjb3ZlcmVkIHlvdXIgdjUuMCBjb21taXQ6DQoNCjhmYzc1YmVkOTZiYiBO
RlM6IEZpeCB1cCByZXR1cm4gdmFsdWUgb24gZmF0YWwgZXJyb3JzIGluIA0KbmZzX3BhZ2Vf
YXN5bmNfZmx1c2goKSAoMiB5ZWFycywgNSBtb250aHMgYWdvKQ0KDQp3aGljaCBhcHBlYXJl
ZCB0byBjb3JyZWN0IHRoYXQsIGhhdmluZyBuZnNfcGFnZV9hc3luY19mbHVzaCByZXR1cm4g
dGhlIA0KZXJyb3IgaW4gdGhpcyBjYXNlLCBzbyB3ZSB3b3VsZCBub3QgZW5kIHVwIGluIG5m
c19pbm9kZV9hZGRfcmVxdWVzdC4NCg0KDQpCdXQgSSB0aGVuIHNwb3R0ZWQgeW91ciBsYXRl
ciB2NS4yIGNvbW1pdDoNCg0KMTRiZWJlM2M5MGIzIE5GUzogRG9uJ3QgaW50ZXJydXB0IGZp
bGUgd3JpdGVvdXQgZHVlIHRvIGZhdGFsIGVycm9ycyAoMiANCnllYXJzLCAyIG1vbnRocyBh
Z28pDQoNCndoaWNoIGNoYW5nZXMgdGhpbmdzIGJhY2ssIHNvIHRoYXQgbmZzX3BhZ2VfYXN5
bmNfZmx1c2ggbm93IGFnYWluIA0KcmV0dXJucyAwLCBpbiB0aGUgImxhdW5kZXIiIGNhc2Us
IGFuZCB0aGF0J3MgaG93IHRoYXQgY29kZSByZW1haW5zIHRvZGF5Lg0KDQoNCklmIHNvLCBp
cyB0aGVyZSBhbnl0aGluZyB0byBzdG9wIHRoZSBwb3NzaWJsZSBjcmFzaCBwYXRoIHRoYXQg
SSBkZXNjcmliZSANCmFib3ZlPw0KDQoNCklzIG15IHRoZW9yeSBqdXN0IHdyb25nPyBJcyB0
aGVyZSBhbm90aGVyIG1lY2hhbmlzbSB0aGF0IHByZXZlbnRzIHRoZSANCnBhdGggSSBzdWdn
ZXN0IGFib3ZlPyBPciBwZXJoYXBzIEknbSBtaXNzaW5nIGFub3RoZXIgY29tbWl0IHRoYXQg
c3RvcHMgDQppdCBoYXBwZW5pbmcsIGV2ZW4gYWZ0ZXIgeW91ciBzZWNvbmQgY29tbWl0IGFi
b3ZlPw0KDQoNCnRoYW5rcyB2ZXJ5IG11Y2gsDQoNCmNoZWVycywNCmNhbHVtLg0KDQoNCg==


--------------me5VN7OgJnhvr1V2pM4gUVlR--

--------------GpE5vlbwBf0P1Jxil2OUQNcE
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEE1GBbrQYgx8o9Vdw+hSPvAG3BU+IFAmDl96MFAwAAAAAACgkQhSPvAG3BU+Jx
kxAAs3kpgf7JgR1goQ2pR0ArvsiOT5+jHfdNbTnlgE/iVSQauDNNHTBun79uxr9oKmSBIe5rU0tX
nTmolF3UVUu2Wm33/+QeGpxQIDtnhD64xtI9vJR0AM26+NydslfzU6hAnQkIWWhPk9g6It7eC8mn
7ifFJZT56mGUk7YlyEFKSQk3mqgBu1BPQ5vVIkvMqKKj0YKzkQ/f7ZMT1QNHKSw0wrNseDViZklr
LNOIRoBLQeowu1V+db01OG/cl4D2IxLTzfee16qzSOx+4abRNaSJdI+XBUCn/+GBjXLAu00o2j/E
+jJIXUlMCU1xaCzvCH9rjXI8G8oJ3Xad4nUoHAnBGMmBgAqoMPBss6Ahl0okjXYCA3L8fV4pxw7u
MWmn9b/PvmL2t5jlprReoDzM1iZVk1YhdXYFRYu5H9eV8j0G5fKw2jxboq3UVFiu1bMVY6UHbdvS
S84XleyZKjD4v2ykK6KQ9qVsbT1690tBD4vs/7BgBHFi3MPv1KhU5W7LfXOZ1VryBfBVneMkpYAq
QHX0sH8PcOxRAYC5v7anAUMbFV6sWOmZTmnfYkU1EtGI2OqGdhGYobdAIlMk722fsVV9Fkwq5FzJ
XIVlo8f0dD6VwKHtJRf+FaSA1HgO+dBYF/phRqH+iL8wUu8TGy0w8suO60TX0ufTIwAEOFAjfGIj
JA4=
=4Yuu
-----END PGP SIGNATURE-----

--------------GpE5vlbwBf0P1Jxil2OUQNcE--
