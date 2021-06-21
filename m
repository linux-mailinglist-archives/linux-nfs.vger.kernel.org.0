Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5FE23AEEDA
	for <lists+linux-nfs@lfdr.de>; Mon, 21 Jun 2021 18:31:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231717AbhFUQdH (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 21 Jun 2021 12:33:07 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:22758 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231772AbhFUQbE (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 21 Jun 2021 12:31:04 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15LGPNYx023337;
        Mon, 21 Jun 2021 16:28:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=gnq5/HftzRP0UVnS034H7HYa0LIw3QXHEWwd/HLIMto=;
 b=IRI0WT7lDFnVQHo6OJIlfToWjy/hgu+Fhix52ptlG9WT97zKADT/HgQY8ggEFaQq4b1x
 ouc/Zs4zduwhY4y/27AUhVcOqK86z7QidYSr4St+1YKW5BZA6QK4qf15qomYBoujH9Kt
 Rd9GkRYvEVZ3SyuAreRcE2a+lWCoNWIULv0imeDrMXZm/lthbPrzdXij1QpwPJ0UoZNh
 usu5RblHcjK8TjQ2mqEqcabDSr2GRUVVCggOUn0nmWtd1uCbhUkZo/M1+62tnvF0cc02
 n419HYsMImzMlUGahGPlaB95HS3XE5+LZnLF/PsglzX/oamzxoiveYTR3DG7TAXuPrjr YQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 39ap66h6na-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Jun 2021 16:28:46 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 15LG9oG9129983;
        Mon, 21 Jun 2021 16:28:45 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2174.outbound.protection.outlook.com [104.47.56.174])
        by userp3020.oracle.com with ESMTP id 399tbr7saq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Jun 2021 16:28:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jJH7XkXmHpB2qQAmJVVxAsdXnfjuP7SCcfgfNY9Hc2C3KY2sN8GN0Nv3CfxuVeiIEJ75cHvxZGkgnv5hLVjDvtGsm2m8Or7iLQt11irzg6sOSTW0q1wGGcX2bU4enRxuLspYHr+15R8vzT90ccnGcLggIRtwRGFNPsoXDFunGNzGGKiVQwE17gh8ATUH1jtbYYYYjUqm6X0q/lv1gDLnv+1j18uJXOyxcjj8GWMgjZO8H2pKyNzrvnXB+sZtzQWbH0RA04APblrTQUiZ4iuMWjdbIOQUItNb5NlDs/wEGnX1h+oq5KUlJSuSwqqh4x+P3yP9G7IOmlZy+CJITf479g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gnq5/HftzRP0UVnS034H7HYa0LIw3QXHEWwd/HLIMto=;
 b=hYDgmm/8bqw/X66JYcZYqUiUEFTf9j20GKxEuce9bIUDkzpgxEPO78RXs83iAtGEULB32oKTpZ1Wkp50kDeqXYjGQD5GpwkJ7Mu+jmo837fenzKVj91R/Flcm4juIIlwcag18yI05I9YiRkcrW2kwli/L+spctFpyFFf+aWgVgzkk/tt27+yb4wF+08Kz/kj4DTcLd3nhTouSbl3XN9tn0MIbSJOKRLW66yqfRLRAIjHEKybLnhmFdvDFqT1xH1ORA5jWcky96l+28PMzByl7cjgE+vpiBZBe4xmfQXs76bF3E1Spk6+KlsrNfHA4oaeWhgh2GX2apf2vRvCA38kHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gnq5/HftzRP0UVnS034H7HYa0LIw3QXHEWwd/HLIMto=;
 b=OYAn3iqH03EXpWq8nxUMuq40cQ7NPjRpXqy6HE/uXh/yw2lb1HsLHcOu1oja6zE7Gr71vwhVNakq3/eGGnanpdUsJNDusELZijHZUliOnuxOEinpiN4GVMm3bVIT21u+ORaMOT0Q7XqtILfCxTVv3JjAO/TmlV3XMhDHsa/8j7Y=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by SJ0PR10MB4765.namprd10.prod.outlook.com (2603:10b6:a03:2af::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18; Mon, 21 Jun
 2021 16:28:43 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::18fc:cb94:ca3:1f94]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::18fc:cb94:ca3:1f94%8]) with mapi id 15.20.4242.023; Mon, 21 Jun 2021
 16:28:43 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Timo Rothenpieler <timo@rothenpieler.org>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        linux-rdma <linux-rdma@vger.kernel.org>
Subject: Re: Spurious instability with NFSoRDMA under moderate load
Thread-Topic: Spurious instability with NFSoRDMA under moderate load
Thread-Index: AQHXSnp8j8N6G2OhyUK9Nr2RtJxnoarn3hgAgAATb4CANuhZgIAABioA
Date:   Mon, 21 Jun 2021 16:28:43 +0000
Message-ID: <388908AD-FC71-4A4D-8314-B0C3F8EF127E@oracle.com>
References: <4da3b074-a6be-d83f-ccd4-b151557066aa@rothenpieler.org>
 <72ECF9E1-1F6E-44AF-850C-536BED898DDD@oracle.com>
 <e12c24fd-beaf-31ce-cb49-36ad32bd22b3@rothenpieler.org>
 <daae674a-84d4-de36-336d-693dc582e3ef@rothenpieler.org>
In-Reply-To: <daae674a-84d4-de36-336d-693dc582e3ef@rothenpieler.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: rothenpieler.org; dkim=none (message not signed)
 header.d=none;rothenpieler.org; dmarc=none action=none
 header.from=oracle.com;
x-originating-ip: [68.61.232.219]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dbd24a96-696e-4934-d4af-08d934d1a2bd
x-ms-traffictypediagnostic: SJ0PR10MB4765:
x-microsoft-antispam-prvs: <SJ0PR10MB476589F5615412DB6EDBD7A0930A9@SJ0PR10MB4765.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ppHHZ5RpZVHlfnht80mf8vBkkEz3RKBg3b3jVtd1oycRezkSTtD2y6y9t2ABR4rDBd80eBo8aqeFgIQgzo/cdocTYlwULIS/JLn3qjMCFsLg1B0xynYHl49Ef95VqFpvFgOmExUBPwpaAQ4HAL92IKxgvOWfpJqqoI75J8yXAgnsSonBPye9wEw3UlBRJgVuVJ9tuDGP4B1f9hF/Q61itT+I+Gy9jUUjwBXgYFhOAw9GpTmJFQPKc/8nHcvJAFMCQ24ISijI6hqA8xNY2adsj7K4oi1QsGp9GyilVjDjB+l0skjVZrZOCUx5rWgfZ9JLV37MwwX3i6t7irC73izeuG6x1v9TkjUsJyNqjQ9L0GRiXgnkOxcrYzQ04RvDWx1Mb1ZimzzhZK/ap9pP812iZHAMkN5MSvE7E0lotca8pgrifPQOE2o+v39qhY6CtoB6Q37BEDvc3ceDILJ0KFf819zJOBQzB7rajvw/gK5H2cXsPff7EBp+BBjBGQL5cHv0YLp7fRrPcbCHbNxEP19zzi3s6gTlaPNTTR2ydMg1w20tPUYTdrH/zRDlSSO0UgkotpGfvb7sV3/7AnMKuzbuqXjCI4MZU/WKpAEWeRIt/mHKhXwlKzdvrJfeQFsgwPT9atddoTJQJbFDIxejzgP7xotMkHI7zdw9NcgPJTSjVrw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(376002)(136003)(366004)(39860400002)(346002)(6486002)(316002)(26005)(478600001)(186003)(86362001)(4326008)(91956017)(76116006)(6512007)(54906003)(38100700002)(36756003)(8676002)(2616005)(66556008)(33656002)(53546011)(6506007)(6916009)(8936002)(83380400001)(64756008)(71200400001)(2906002)(4744005)(5660300002)(122000001)(66446008)(66476007)(66946007)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+vbrwbqWbgUbM5s8+QZx7BJPsz1KszvS/6xbz+DvE2y8HmjFEKE8iPdPo2r7?=
 =?us-ascii?Q?gfb6KeX3NsCapEQ5RswERV8KPCmWkEffm7r1d5Zq6e4DNYSze6EvJTXo9f75?=
 =?us-ascii?Q?4wuDY7G8b5//Sm+2hJz2tyo27/pH2SepGH3RL5gYJm5KdNm/10+JpX8pewBP?=
 =?us-ascii?Q?uT7A75zO8CQWNC9eykY1BQZSSzOjeLTW3TGB2h65CDq4wOvqagB6TU0Gk5IF?=
 =?us-ascii?Q?EEhd0i+FT7fsW7ZK1YrQUkLzoaRYjiW+4t/GbmuV00rk/MnNK2TsmsB1Al3F?=
 =?us-ascii?Q?8hNABPo8acRMmEGj9FEu+vgBjVPf6RVy2f1pCAi3HsEs5UCJeHehLofUbxj5?=
 =?us-ascii?Q?H+FPMNolgmZzWSkv/EnklbcSj/NUoMyEede431wtXkGOEx2GnW2ZJrJjNc/5?=
 =?us-ascii?Q?0omFh1bGIAHWD6CFUxcNhv4Mc5KCD8LvHGI2XQa5BTy9pmgJs4pmW03ILFO+?=
 =?us-ascii?Q?fAXUfGmU3Dz8dte07aYyPmyRV29uqNOq+epyYBzcvYrZbw0gifz5y6Fx07fg?=
 =?us-ascii?Q?FSPGoPdRSywmbzHLPSYV7KpO+GZoNdbHfR2S8M5cB7jVxozbC7M0D9Lwd5DJ?=
 =?us-ascii?Q?h47Ea3OPgW/absNX+MQb65hgpxHDQTOGSFJnqyaZoPP0Pb+zk+nmC5bXafUE?=
 =?us-ascii?Q?19nYA44vUjJzYFtXFAh6oWHe+NlUEvVfixqkroahydKwD/kS8AP7tMC1IWeL?=
 =?us-ascii?Q?+r052DO6250sn0/7xteCG0ImyuaDlZRpT0p13jqVDZCaGvYo06Z9H45NAJYn?=
 =?us-ascii?Q?XGIDlc5Dbu+zY84/mkYSWlAA7oQ44Nl91pJtqcfEdC7XHXp77XdVGZ1gVIsm?=
 =?us-ascii?Q?Dp7/7vFMtQvk7u/s+o4CjBFzn8382zGcG9/3QjoJNuHAx/6YA5R28kC1XQ8h?=
 =?us-ascii?Q?YgRn9VZ+ljUE4+6Ja51mfgCsCpLH1NJvo6x/kj2VR0dxiC4dC5GuDp5HGLSV?=
 =?us-ascii?Q?UmkkaoU2yifziGJ7Z3UOQEr8tbytp7OC7QUlO2asId0nVzOIlbknwUwrRibx?=
 =?us-ascii?Q?NIPYssVCxsRdhxgVPU2wdS2iEQcrpz7SncSKaY/e6eACwbB5jpEsbuGPeGp0?=
 =?us-ascii?Q?9tu2WWxCXBP904Eu1RNnowVL307FYnbWTj0Ism+7g8aeEfMWORR8pHrvDGWL?=
 =?us-ascii?Q?dhidr+WTCRwms+jpQngl0oVrnImxpSIQCJ20qn6tVVQf7FhHjBJSZwRsin0n?=
 =?us-ascii?Q?tehrXmQ3VZnFpRIswzB4wh8g7jpSmRxZxUup4adlFaPTi4EmJMYJICbbXRfp?=
 =?us-ascii?Q?ngtv+9O4BDX27f59GwTW46V8b7q886NXWQurMj9RpSPu1M0h5DblQUXJ5bOP?=
 =?us-ascii?Q?CbUrBaUuK0oIR1OirlyQOgKs?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B78E30D57F3B064A88A03166E521CE0A@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbd24a96-696e-4934-d4af-08d934d1a2bd
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2021 16:28:43.2436
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Eu68Zz21CgeQevL0NT0Lsrnla2I1Em4SI28EdsGyaI03yaRlsSFqUWYc7uR42EuxbVMLlKdme6IWfyFti2qwhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4765
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10022 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 mlxscore=0
 spamscore=0 mlxlogscore=999 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2106210096
X-Proofpoint-ORIG-GUID: lYzbxo0Z27jAvLoBhcSeJQhpdRYFsqWW
X-Proofpoint-GUID: lYzbxo0Z27jAvLoBhcSeJQhpdRYFsqWW
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jun 21, 2021, at 12:06 PM, Timo Rothenpieler <timo@rothenpieler.org> w=
rote:
>=20
> On 17.05.2021 19:37, Timo Rothenpieler wrote:
>> On 17.05.2021 18:27, Chuck Lever III wrote:
>>> Meanwhile, you could try 5.11 or 5.12 on your NFS server to see if
>>> the problem persists.
>> I updated the NFS server to 5.12.4 now and will observe and maybe try to=
 cause some mixed load.
>=20
> Had this running on 5.12 for a month now, and haven't observed any kind o=
f instability so far.
> So I'd carefully assume that something in after 5.10, that made it into 5=
.11 or 5.12 fixed or greatly improved the situation.
>=20
> Can't really sensibly bisect this sadly, given the extremely long and unc=
ertain turnaround times.

Thank you for the update!


--
Chuck Lever



