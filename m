Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBF3D7AEEDF
	for <lists+linux-nfs@lfdr.de>; Tue, 26 Sep 2023 16:58:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234906AbjIZN5y (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 26 Sep 2023 09:57:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234828AbjIZN5x (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 26 Sep 2023 09:57:53 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B054C0
        for <linux-nfs@vger.kernel.org>; Tue, 26 Sep 2023 06:57:47 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38QDPAfs009124;
        Tue, 26 Sep 2023 13:57:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=do9EQLXwCXI6y4SOq+8N92S/egEfYg2qhUDBeOMkpSU=;
 b=bdnbemFZWRpbAKtL9bEguxk9JHHffbnSWsa0X3T7CHK+iYWOtYEoqzlTSn/67OwPPtmw
 RDjUsmh3iDnMZgrA8HzfGXDwwWZlfq3UcMx/qlw2eoXc2g+1Z5sNdAIExuHHtC6k1Qmi
 LD7tbxphp7uXX2ZL0MQniT+E1ybnl8v8D/EiKf2WogR51foUIWy1x7B0Oyz14RHmI3ew
 ZhUSY27OChsjC1GjVHi6/br9VA9UORiU2gWL7tLCIcBvJAAvV9sc+zYPWPyyCzDAtFSa
 LCEQjCj/0NRIiZPPFWqptgKD8eG+NS5VUMKoh9E7N9d9iKOaBf9+uy7nDjP262kH500h ZQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t9qwbek90-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Sep 2023 13:57:42 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38QDrKrd031031;
        Tue, 26 Sep 2023 13:57:41 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2045.outbound.protection.outlook.com [104.47.56.45])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3t9pfc65w6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Sep 2023 13:57:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PFQTOBtTiSdmyvwuFbwqG6gzb/wVBc2m9evNheWaZyXhGk4nKBMWz7L2jVrBMK5WWdP7PjhWLQxXjfd5I55DG37WZtE/fXZwq1Gn/jMmxQ0eWcyu9v2X0bRZj3uRjjLojdbmnza1qm8WfqJUMuuOS+jLQwmnn2ChFCk/aIWEvAoV2r/84INdO75rZh5VmkxpChwHCXeuU0O0fluUt9fG+BMSHMVYM9fR8dDkm+YONBOsI9ybOn7f1DM4TXyTHyKG/u9Vu1Xh68OTvG3mr6AVPaH+LtQZzcPaTMVDddCv38yM4rnA6Gn9aK4Ul37kaqZoF3a7D6rSV1xiwsyEKTnPyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=do9EQLXwCXI6y4SOq+8N92S/egEfYg2qhUDBeOMkpSU=;
 b=NZ9zVYVx+QtpQKIjIERJJZC5gspC/rGReOePSoS1s5dPgTQgN/Fsg4K55yc4GipHbM4RZtsCCqCxJojQbcbaPhp1lrzdFuxbnSDofNsKc+u/v0IiUEI2Aq1u+EMYAtJf6aW7nV3TXDVZtruOMZSN5r0wHT8G1wXmnGLWut6Lmn3kBEGuudCHQQmjfw2LAL/efdnutfq2Dkn89nkTTZdlIyrc1GIx+dVVqIth4Bc7xNAgvUVc/nUJri8ch6Dc29jjG7J1JzOxD9EqBPgXmp40IQsoMDn0rzu5tAxYoKiITeZ5VTWp02glIEIyKbeaBIVQYbIu9lHCS7KSHotkDz3QQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=do9EQLXwCXI6y4SOq+8N92S/egEfYg2qhUDBeOMkpSU=;
 b=fHjQSCfg+jwRQaLpxEye4aUIPEyYY5LfVTFfJljwxNQhrH+CVd0oo1HBEvD0i8gVVe8VSD07+mPkuEKilvw+EjfWV76PAdANetqRCaDlj+RRn1985Nm0x8b0NNx+E0mHjL9R+5TIcJTdHy9qaKG7iss68dsnJ+4co7e2DZkF7Zc=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SA1PR10MB6640.namprd10.prod.outlook.com (2603:10b6:806:2b6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Tue, 26 Sep
 2023 13:57:39 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::bffc:4f39:2aa8:6144]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::bffc:4f39:2aa8:6144%5]) with mapi id 15.20.6813.027; Tue, 26 Sep 2023
 13:57:39 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     =?utf-8?B?TWFudGFzIE1pa3VsxJduYXM=?= <grawity@gmail.com>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: Data corruption with 5.10.x client -> 6.5.x server
Thread-Topic: Data corruption with 5.10.x client -> 6.5.x server
Thread-Index: AQHZ7uglcAk7YvaB4kSAn1xCF15i5rAp+BsAgAAR7gCAAAN6gIAAI0qAgAAaJQCAAaJvAIAAnDyAgACbWYA=
Date:   Tue, 26 Sep 2023 13:57:39 +0000
Message-ID: <2660F09A-5823-4581-8977-4F41153724D6@oracle.com>
References: <f1d0b234-e650-0f6e-0f5d-126b3d51d1eb@gmail.com>
 <6E4B8EB9-FA7E-4ABD-81AB-6FB0EF07EA46@oracle.com>
 <f90866e3-8c54-8a9c-c100-f5550c31b664@gmail.com>
 <9691788F-2B62-4EB5-8879-CEDABD1B9D4B@oracle.com>
 <78c81a97-4324-c2df-27c0-917436ddee07@gmail.com>
 <6908E735-6912-4AEC-8AD7-995F2F8A144A@oracle.com>
 <CA1D7203-72FB-4681-AD60-F1D80A57C154@oracle.com>
 <8cb19861-7fd2-4d12-bd76-78bbb8fcee7c@gmail.com>
In-Reply-To: <8cb19861-7fd2-4d12-bd76-78bbb8fcee7c@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.700.6)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|SA1PR10MB6640:EE_
x-ms-office365-filtering-correlation-id: 2c20ee29-b730-4b74-73ba-08dbbe988c10
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OcpYjuyWw9R+JdI2LfN1Qt1mCUv0Y7MJHMQUw7jFWvWtCzW2nDsM/P0jum7tz8KiQUIMhQ13fVtUw9YS8WVyKCSEnfyJvxXDtNuGFVx7v+ls9rI1b9bxY8K2H0JGjHK63d/jCU5YDVHnJnFWqYBxzfxrAtsfgSa/iqdQVtS4+9V+//yD9gdawjEWz4odbceHHuHN1mU4qSfLwAeqNEUBbP0Nv4Y53mkFjc2y3mCMHgH0pXwNkRESB7+LDaWcL9OQQELBR7qJr9i4Gn0NlA4FI/JJEgfLRrzyzViZT4kO7IwZzEasM7tzbCWucKTym/xTGm64tZlgqhuQOlwNaRjiUkJDfmMR6S7MXMZBM37nsst94dAQWE4iYNz6zLsIlGejrQLvYwm9izplCnFhuUyyKZlqc+x9ufBSemayjFMWGF+mKKQblb7f7utuWHA/UBgIzd60cChcRwQaW21VoqIphbjRzltqc4WfTqUxsWA0DldKrQVbMsxTbe5CWAVU9m+t/FrLnm3YXOZmJnL+91s8rogjTQ1d2w+uXYTreL2VeAugHXn1tlYq0XH0vDt/pOoI3vbXR5f8Maa+aBPEMvUibwSXamyqzuGkslZcHBLgpcre7DQkkoNztzmbbDPODtM9lE0umrU1t8M0NSWfutM2Fg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(396003)(376002)(346002)(366004)(230922051799003)(1800799009)(186009)(451199024)(26005)(6506007)(6512007)(6486002)(66556008)(122000001)(2616005)(71200400001)(53546011)(66574015)(33656002)(86362001)(66476007)(66446008)(66946007)(64756008)(91956017)(478600001)(38070700005)(38100700002)(76116006)(83380400001)(2906002)(5660300002)(8936002)(8676002)(36756003)(4326008)(6916009)(316002)(41300700001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YUh0ck9CSkhiV3ZSbEZVbktwODlzbUtGOVgyK2tnckdCSk1YejE5Zm5lMjZm?=
 =?utf-8?B?U3A2TVRlYW83UGdhc3ZHN3k4b3BPYUdpejROdHJKMUtjRjJoTkFFckxBNWxw?=
 =?utf-8?B?Z1FTMWp6NVhVUGM5Q08zekk5YTFGdURxOWkvOU10OHVXUlBWOTVReGZhVUxT?=
 =?utf-8?B?U2ZDcjNqRnR4cGwyZ084VnJOd09CSEIzMHM4eldENzVKbFErMkErcTZUeDRU?=
 =?utf-8?B?TmpWRkJ6cXI1eUIzYkVOaHRuUmptNktGb0d2OFRjNkxldEU0My9EWkhONjA3?=
 =?utf-8?B?T0FaZTFIa3cvOVhpVWNqOUJ1RjVrNThpN0hCdlFNR3RWODNMZ0dVdmJPQkE2?=
 =?utf-8?B?Y3ZyOWZkMmU0SnJlb1VRNUxZMUZmZUtTYkJkR2p5cHN5eG5oWGdkQlBwSDBM?=
 =?utf-8?B?MlhTaTFYQU1Dc1BnQnppWGZSeXAyUklYSzk4YlZheUxlRzlPQ3BRa1BJeHBY?=
 =?utf-8?B?MGZ5WkVZemJBVWxMTEtETnUvd2swazZFMlpQc0JjSkY1dGV2NlQyNUEzZGxj?=
 =?utf-8?B?RTFFeGZsNFhWd1hrTms1MUdaYnVxcGw2eERIZnF2Z2cwMU8zZUJLaGZkN2tT?=
 =?utf-8?B?Sml3N2ZkdlE3K2Y5a055cnRFdTBtNWtyMUFENlpNMWZ1d1lYK25ucnhIOHBH?=
 =?utf-8?B?anpxTkFMZkdEN2FFbjdaSnhRMFIxTjZWWVZOdlBvcHByaGVUODdCSk5qMWh4?=
 =?utf-8?B?U1BHdlY2RE5vOElVeDh0dWFDUks4MktkcE9VWHJwMDlGZzBJdkg1MEpaVGVM?=
 =?utf-8?B?dXJkeTNhbFNlcHhobUdvVXB1QnlmaFZVQ1BJdzdwcWlZa2FvTDROMHM5Y1FM?=
 =?utf-8?B?V1p0U2oydXA3K2U1TFlPTVFjamxoUnRXU2pTSjdYNkhGbFIzUkUvZ05RU3FC?=
 =?utf-8?B?ejloZEl2dG8yb3RqbXM1RjdzVUo0L3NIZVFINWs5SHNia3N4RmYzWEg3T2l2?=
 =?utf-8?B?YXRJejFwRXpHQ2hEZ0pRaENzVm1UOVJZbWlBZ2xZdjdwMW9UdEVVSDA3SktB?=
 =?utf-8?B?UHRJMHozdlRSZHNnaFk5RGdhN0J5aExXRVM2cUFHSi9pdmZhTzBnWDJvOEwy?=
 =?utf-8?B?OEtYL243M2tNaUJhaERYeEVjei9pSGl2S2VkUWlzKzhreFhhTFVjWTl3NDVZ?=
 =?utf-8?B?MG1mWTFDenlpVWp5YmNzUEdNSlB1VE5EN0xlZ2NDRkQrSW5QMVJaTm5QVnRG?=
 =?utf-8?B?Y0RyemJ0MkNPM2lweU5wRnJDSTFNOEQ3bERhbDVVZ2JUMnVTZGZZWTZaVmxV?=
 =?utf-8?B?b3l5K3NlNGFHVll3elpIUFAzaDRiVWJsUUhhaStDcUszbVdHOHo1N2lwM0Ur?=
 =?utf-8?B?cFpIdGJVbDNmQzBVNDZkTy9WY1pEWGpSRXhxbFdwTWltaGd1OEptdU1LbW5F?=
 =?utf-8?B?Nktnc1BiUW9hQTlqQWUwamlkdTJzUEM0cERMNVg5ZEF2b1gyTmlqZkV1VDFH?=
 =?utf-8?B?eUdIVnlIZUVzMmhvaXhiYmI1QjhPbStGRU93MW5wSnBxbWRjY2FPV0pSMngv?=
 =?utf-8?B?Y1F0KzdCVk9kN05rSmVzZm9YUFV4SFpieFNpd05UcnJ2aDFudlVzb3FNR2hs?=
 =?utf-8?B?dXkzWERvSkNiNWdDMVNia1JqcCsrdzJrQlZ1N2tjck1rSkV6TUk4Zjl2NmNB?=
 =?utf-8?B?Lzc4YmVhWnl2SUF1RjJ4bGJNc2ZwcEVkQWtQQUMxUkZkR2RyOXlSNjBrY2Fp?=
 =?utf-8?B?QXVab0xFQUo3M053dm5ZN2d6RGRMdS91NDc1Q2hIK2N0RkxlVk4yZFVpS0o0?=
 =?utf-8?B?TGd1VUlVS2dqQXA4b3d6Z0M3TVh6dGZKbFpscUNnWmxEcUl5cldRbFZkN0Ja?=
 =?utf-8?B?eDcxYlExQmpKQTM2RjdEbEg4VTB0NzJRU09YWFNhYnJjeGJEVnAwaHFNQUh2?=
 =?utf-8?B?Tm9rVXl4dkF3WHVUQW91Q1hNUXc1MlBjZlo0WkJpSDRrTzVVTzJaRUZZV3py?=
 =?utf-8?B?YTZrOUlYaVBVM2JySjFoMjN0UUFhTkN5Q0pwTGpKbW5mbU80MEwzN09sVVda?=
 =?utf-8?B?b3ZreGxmVk5sWmVaSVVhL2F0T2VCN1hsWTNHdnBrNjdyQXJCbVpIQ3hCakFQ?=
 =?utf-8?B?UnFzT01WcWk2T01IaTlpamxYWlVUWHZUZ1Q5TFdMYURqK05JTkl4d3ZhbThq?=
 =?utf-8?B?alB5cmxqR2NQRmlPa2VsVW1ES2xFZ1FQZWVraEJpUHFpbXIrY0VFcWtIQS9F?=
 =?utf-8?B?MFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AAAE9AC9042E2F499DF0C5236AAF3C6B@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 067PYlL5WmzwxTseASpSY51BGYgkHcxik5lP3pMpRI1loWUfQOTtHAx+L8HDaMViqwYP0bdYFx7OXlphMR7Wg4nnfBTAxMFi/8KfAquQVjnkG9eKAN30KaXsPiO38PXCJSiM31wWsHQ8+Wnc/w8kCz6udgI/Nk/5byGRCVXKcmU+LwIxEyO6H9uFa6QmJRRJGQ0Z3bYPfw1x1Ap3LVuylvxO+5hHG7yYFbkqL0a/5KU0km3rmyHpXx1oncIFpf7tAyQy/5RahDWLyv9yXS0DRChMDFCOl1ZtXzQI95HRn2UA65lG4DuM+86FL7k2loFeQHTGdP/S82qyzbYkSTxoym4PVhLJOnLmT/4AtJuox6h2E0JreALhbfY65T81mAKw+wKunLTIzQ8bfokoKjqB0SMjmdLdasrARDBcFljRF9KPMv/uupyixQU/oW+jPvw+4y/fIlqNf2yzVBeLWS1vK78ewIXz81eKNp+naNxFn2XjMV+FxLOqKMEWFjxyZ0S2UVupKUvXZUGXS4W2LM6NWug1rsd66KCV9fPCAUDshAXulywzQxlK8C2gUm8S1I61J16f7b1bDc2oQlRUt4yomFpHRrP+3q4UskjLAzgJlrYgiWwUgaFheX+XKhKDPkndmYw1tRPy/CRFKiIsuDdtPC4dpz/+fCEs24aLndUPzSqJgMY35axWPZNE5C/DSeKmqe/8zg+iEDpnaGa8RbckKRj22lE3AldFLgMzO9vuTFon3/wJDcUyA7TfxLWKUxYcMO1EWZFcO4KYRS/CQQ9hrKPtyXSHC9V5Bi16sDKgRno=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c20ee29-b730-4b74-73ba-08dbbe988c10
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2023 13:57:39.7018
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1YD6rn5za/pZdyLXYhR/JLOMSBNdVH4HpPE48NgvzGdkDq3npgHQXGALwOOSFAr73jCLQuOjJMcV10b7XDVyOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6640
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-26_10,2023-09-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 mlxscore=0
 malwarescore=0 suspectscore=0 bulkscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2309260122
X-Proofpoint-GUID: irOQJTczc6I-w3D1i7Ewe4G9U5ThV462
X-Proofpoint-ORIG-GUID: irOQJTczc6I-w3D1i7Ewe4G9U5ThV462
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

DQoNCj4gT24gU2VwIDI2LCAyMDIzLCBhdCAxMjo0MSBBTSwgTWFudGFzIE1pa3VsxJduYXMgPGdy
YXdpdHlAZ21haWwuY29tPiB3cm90ZToNCj4gDQo+IE9uIDI1LzA5LzIwMjMgMjIuMjIsIENodWNr
IExldmVyIElJSSB3cm90ZToNCj4+PiBPbiBTZXAgMjQsIDIwMjMsIGF0IDI6MjQgUE0sIENodWNr
IExldmVyIElJSSA8Y2h1Y2subGV2ZXJAb3JhY2xlLmNvbT4gd3JvdGU6DQo+Pj4gDQo+Pj4+IE9u
IFNlcCAyNCwgMjAyMywgYXQgMTI6NTEgUE0sIE1hbnRhcyBNaWt1bMSXbmFzIDxncmF3aXR5QGdt
YWlsLmNvbT4gd3JvdGU6DQo+Pj4+IA0KPj4+PiBSaWdodCwgd2hlcmVhcyBvbiB0aGUgc2VydmVy
LCB0aGUgZmlyc3QgZmlsZSBpcyBmaWxsZWQgd2l0aCAiSGVsbG8gV29ybGQgKDQwOTIgYnl0ZXMp
IiBhcyBJIG9yaWdpbmFsbHkgdHJpZWQgdG8gbmFycm93IGRvd24gdGhlIGlzc3VlLg0KPj4+PiAN
Cj4+Pj4gTWVhbndoaWxlLCA2LjQueCAoQXJjaCkgY2xpZW50cyBkb24ndCBzZWVtIHRvIGJlIGhh
dmluZyBhbnkgcHJvYmxlbXMgd2l0aCB0aGUgc2FtZSBzZXJ2ZXIsIGFuZCB3aXRoIHNlZW1pbmds
eSB0aGUgc2FtZSBtb3VudCBvcHRpb25zLg0KPj4+PiANCj4+Pj4gVGhhbmtzIGZvciBsb29raW5n
IGludG8gaXQhPG5mc19rcmI1aV93b3JraW5nXzYuNGNsaWVudC5wY2FwPg0KPj4+IEkgZm91bmQg
L2EvIHByb2JsZW0gd2l0aCB0aGUgbmZzZC1maXhlcyBicmFuY2ggYW5kIGtyYjVpLCBidXQNCj4+
PiBtYXliZSBub3QgL3lvdXIvIHByb2JsZW0sIGFuZCBpdCdzIHdpdGggYSByZWNlbnQgY2xpZW50
LiBTY3JvdW5naW5nDQo+Pj4gYSB2NS4xMC12aW50YWdlIGNsaWVudCBpcyBhIGxpdHRsZSBtb3Jl
IHdvcmssIHdlJ2xsIHNlZSBpZiB0aGF0J3MNCj4+PiBuZWVkZWQgZm9yIGNvbmZpcm1pbmcgYW4g
ZXZlbnR1YWwgZml4Lg0KPj4gVGhlIGlzc3VlIEkgcmVwcm9kdWNlZCBhcHBlYXJzIHRvIGJlIHVu
cmVsYXRlZC4NCj4+IA0KPj4gSSdtIHdvbmRlcmluZyBpZiBJIGNhbiBnZXQgeW91IHRvIGJpc2Vj
dCB0aGUgc2VydmVyIGtlcm5lbCB1c2luZw0KPj4geW91ciB2NS4xMCBjbGllbnQgdG8gdGVzdD8g
Z29vZCA9IHY2LjQsIGJhZCA9IHY2LjUgc2hvdWxkIGRvIGl0Lg0KPiANCj4gWWVhaCwgSSB3aWxs
IHRyeSB0byBiaXNlY3QgYnV0IGl0J2xsIHByb2JhYmx5IHRha2UgYSBkYXkgb3IgdHdvLg0KDQpU
aGF0J3MgZ3JlYXQsIHRoYW5rIHlvdSENCg0KSSdtIGxvb2tpbmcgaW50byBzZXR0aW5nIHVwIGEg
dmlydHVhbCBndWVzdCB3aXRoIHY1LjEwIGp1c3QgaW4gY2FzZS4NClR1cm5zIG91dCB2NS4xMCBk
b2VzIG5vdCBidWlsZCBvbiBGZWRvcmEgbGF0ZXN0Lg0KDQoNCi0tDQpDaHVjayBMZXZlcg0KDQoN
Cg==
