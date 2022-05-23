Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4941C5313ED
	for <lists+linux-nfs@lfdr.de>; Mon, 23 May 2022 18:24:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237126AbiEWO0Q (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 23 May 2022 10:26:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237123AbiEWO0O (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 23 May 2022 10:26:14 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E0E9959D
        for <linux-nfs@vger.kernel.org>; Mon, 23 May 2022 07:26:12 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24NCDVTE016403;
        Mon, 23 May 2022 14:25:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=U2vdv6WdjqH/DCtgoUSmoAz+sWOJ8qqT9QZO2UJsqnk=;
 b=0VH2ZenAErKEaQNiYxw76eSxZNRX5kC31CasrxEq9GBYQQz35G5ofExolsQJoohLRGJ/
 d7QwHw6TA1diuQlKk7OPp3lS7jXqVIbrOzlA2peTTi6E8Gte8suwb1mes4tPq3vuUcso
 kTTpnl8TKIwWxNjnZ2UoFzZSzA8xTy1jRHKSh6zUFT1AkiUEJiGjFMlOOroWA4kna2nN
 98qIxfn8AzVqKLeAAzH5HPkf9EtWQNHks3N00Lc74BdnAu4NfmO2VHWjUoJVIVk4S6iG
 HVUxoj+Cfe9p42udIllB9yA5D1cHACrhvKC6iDvDoWoEchnbvGlfHitUi65wqWh8ngg0 nA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3g6qya3ek7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 23 May 2022 14:25:44 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24NEFo0E015223;
        Mon, 23 May 2022 14:25:03 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3g6ph7umsb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 23 May 2022 14:25:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H8M5A/xSE9OhbfPsIizWyMD3NhZ34tfWPmebOyLl0Q59tP+QaJ3QQA/FzAPwIgsBgXotOBVsY3qMLUZWazgWeUbczfD+91RIO9CNUL/FElTawWwmbkLXCF8wDYUBoAonVpjOlKWTOkSpSAnQNfkP6+pfMC64hsqSE0+qPgy5mKcAdIfFqqQnv8rF8L28n1TeGq+AKqACcry46me+je4FZlwZcXroSeQqNn3NlKIpFuaJ+7FLCcjndIHBtxxbaF8Se9hgG0y6fciqprCOvZGrNHY/JP+uPhPzOcnusw15GxdmEjUZlF0jFiw3liUOy0sAJATfAvQ2lfkYv/wVB3fYjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U2vdv6WdjqH/DCtgoUSmoAz+sWOJ8qqT9QZO2UJsqnk=;
 b=YGuq57LuY7FisoNsfiPwpv9kcxQlSw/TRfOswxC/4KrLVrYE9nQKasVt8VggiHTR3H39HIlZCOMwn60Ir/ofOLKOjm2bGZkC7aVgUDx5vGRAAYNZ+YlQaofDi+w2L4rATtRDTmr+z02uBMYZluafCNa7sk3sMzDFJBUL42liiGDdop69uUt+oi/cKBEyRYozlp1Svn6csfOV6i8v1aGTXyip3w3NOjs5iXmwXbChLBfW0o6MyDfezxpvnJw3k1AxR1noU7PNx7itcuWegmIkqHI3UzkJAoCZmwQuf/fmg5PZBHFJHXx1CDaZUpVm9KTkkRlQl2H/4G3nGwgjtKtTRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U2vdv6WdjqH/DCtgoUSmoAz+sWOJ8qqT9QZO2UJsqnk=;
 b=dmnyhoV2QOgK6GOcTYwYL0Iqgh3IvS1EgusPvXhswu3tgN20hkH2yl254Qx5GzHs/1VF6SnDJAGmKV6TcdlHWEbzIxOqOMsvuPuTDOTTasmOyXMPJW5ewtIZkGM6VepYpcAsOODCSCz4/gXxQaeEWEw1oEray6E2qAm7pV2MBLg=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BL0PR10MB2835.namprd10.prod.outlook.com (2603:10b6:208:31::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.16; Mon, 23 May
 2022 14:25:01 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ed81:8458:5414:f59f]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ed81:8458:5414:f59f%9]) with mapi id 15.20.5273.023; Mon, 23 May 2022
 14:25:01 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Richard Weinberger <richard@nod.at>
CC:     Bruce Fields <bfields@fieldses.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        david <david@sigma-star.at>,
        luis turcitu <luis.turcitu@appsbroker.com>,
        david young <david.young@appsbroker.com>,
        david oberhollenzer <david.oberhollenzer@sigma-star.at>,
        trond myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve Dickson <steved@redhat.com>,
        chris chilvers <chris.chilvers@appsbroker.com>
Subject: Re: [PATCH 0/5] nfs-utils: Improving NFS re-exports
Thread-Topic: [PATCH 0/5] nfs-utils: Improving NFS re-exports
Thread-Index: AQHYXgHepSBKAjcbhkm6tcc78z/taq0LxCaAgCB0SoCAAG1RAA==
Date:   Mon, 23 May 2022 14:25:01 +0000
Message-ID: <85DF9014-6464-4661-9C90-36093CEA996C@oracle.com>
References: <20220502085045.13038-1-richard@nod.at>
 <20220502161713.GI30550@fieldses.org>
 <1149772405.87856.1653292425664.JavaMail.zimbra@nod.at>
In-Reply-To: <1149772405.87856.1653292425664.JavaMail.zimbra@nod.at>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f54f259f-0e55-4caa-99da-08da3cc805cf
x-ms-traffictypediagnostic: BL0PR10MB2835:EE_
x-microsoft-antispam-prvs: <BL0PR10MB283547DDB920C585D1D41C0893D49@BL0PR10MB2835.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uDGvx+HFUu/Ybkz9LAsaXzC1bkaFu8PJIY5uuSQMjYYdq/JcqpN1fG4wNtxFMwv9NUaFtOozo9zCeq+qH4941jSFpAg/uCixsMgrk3/JjhH8guFVz96xeXs3d+5H33iESDwwAHW9ytT8ypxTFvZNVjuFhz/89okUIP+JWLwrqB5JpcKCcdNxUoPiZ1V1bAM+It8lDOox9Ec+ZhZ/JpYit4VUIS1AQ1Ikoh4nYhfgCw1y+JWsNLiViITAyD3w5z5IMFf2VczzK39tCf247YB3DunFCT4LYXJpx/y+9u1YejUS9oje8KQQYgQFYE9+TljZB9NcpcA/XigrgvVIehG6O4lGrBZZpIGTSGT8R4hQ8hA0pCH0N4Wd0N0y5TGhgfeUZJ9bN8F2oTk+D3SZN1L6VTpbhCuc6pfx0Vn7c/HtwqBUkZRTUdzwSEVny9dkll8zTrj2tB9GouCpTCGQ53Eungk60tfQiqyTz4a+HhRtnp4zD8WYhAK7rQfYLw/sG/lYryhCxMyu2Dg70+Z+YAqqTtSEDIpwdcU1VTIiJAClD/BugdrEm8jGs9G7YgV/6Oc2Ky1OPH6Pv7ru998SM1Ggw1k/KwnTZVci6gA2+/SOW1BzHVdAZwqKS+piO/OSDxSSXoNIusYa+tYKUgudBVq0rnWJR/51Mn8QUARS/Wq3cTh2nFXYxh0e2tBWsK9QnPjYJkr/0uwWfVwOb19F2VbZS/hU7MPBA4NXCb2OrWzLj9iQkHjmC8m7HAXxrGNtFI8qeyVEivn8IiuuVRyE32qlb3Oa6faClflrfRSZeya1GWL0ciGHkbZgbzDFSz/7DKYCB4cgvTXZ5LFFpvplC+yt4hnOEb4pV+zYDIev+ciC3bY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(38070700005)(33656002)(71200400001)(122000001)(7416002)(5660300002)(8936002)(83380400001)(86362001)(26005)(53546011)(6512007)(6506007)(2616005)(966005)(508600001)(6486002)(66574015)(2906002)(186003)(316002)(54906003)(8676002)(6916009)(4326008)(91956017)(66946007)(36756003)(76116006)(66476007)(66556008)(66446008)(64756008)(38100700002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N0QxQVpxQm4vejJZN3o1eVJHay9HbVZDcnk5WGw1WllIclhheFova2ZoYi82?=
 =?utf-8?B?dHRpTDdvT0oraDRmWnFwU3FQbzByOUIzN0l1MjczcEpWTVZwYzJHR25hZGlh?=
 =?utf-8?B?RDBxQ2VFdStKazJnNXRRcXNlN0ZFREZGN3o4TUlzdG90dzhCOTM1ODFmNllq?=
 =?utf-8?B?VTdTU2dGZlBYU3owNUYxVEI5b2c3Zkw1NlBYcVhKWHRoNC9vdzIxTmpHelNr?=
 =?utf-8?B?OEhwK2V3Q0JGS3I1bXFTN01iVmtacHVPTDlmVnphSGFYN0FRK1dRWXBtUEU2?=
 =?utf-8?B?YURYTFdIYjRrT1BIcW1GdmpUdEZnSE1rYUJvd21jMmVQY0Q2c1lzdVlaMk9k?=
 =?utf-8?B?a1haZ0lmbU43UmFSMlBNN29TWEJsSVhRaytPSUFIYWdqRHp4cE5zTnBORUtY?=
 =?utf-8?B?RzV2TTQ2RCtiYmRYNVZsNlBPYmxVQ2tEcDZVT3dyUm41NGdmeXM0WTgrZ25O?=
 =?utf-8?B?bGtZNWlWYkltdlp6NXFqbll1V2xOcVpvKzhrQ0NjeGRvRDFDYks5eGNiM3U5?=
 =?utf-8?B?ck9GR3RLeUtOWnBzbE9lcTRqeEZsVzVSUS9jN1RuYllvLzUybm5rYkhtTG0v?=
 =?utf-8?B?bitBWWhMOXpJZGExNWR4TFFaMkY0Wk5Id2Zvdmgvd0NoeldNU29Tb2RabjRM?=
 =?utf-8?B?MExCMEdZRGVwdnJhcHA1OHlUbGdiOHFjNEs4a05UR0xLdFV1bEtDRVJtMEFK?=
 =?utf-8?B?TWs4azJQTzRCcVFBQUhSc1pkRHA0cG9ZWjhwNmxuemJ5MnNWWG1GYW1na1I3?=
 =?utf-8?B?U1NYUXErRDR4SGRTck1LNUduZ3Q2MUZjcWhZdjJDOEhHMDhFUUZXZXM3T1B3?=
 =?utf-8?B?RGxwYnNhVVZxeW9QbUpKZmxWK2pEK0hIeU1lallwMEk5YzJhTzhyUFprRCt5?=
 =?utf-8?B?aUIybFVaT2lsMmZoSHNqN1N0elo3NVdKOWhtYlQzQXkzNUpuZ1QvYUwweUMy?=
 =?utf-8?B?bWhDL0doY3RhN2UxR0IzMjFlMHRFNWt6Z3FVblpQbXovdTdlN3V3VEtncG5R?=
 =?utf-8?B?OTZaSUN1a0FKYTJlaEJyYjVLZHh2UU9ScEp3aHdJd1lwbTNvL0h1TkVZUUI0?=
 =?utf-8?B?VzNnaVNtU3gwa3d4TXNuMnI1VjVTc3pSYzNSVWF3T3dadWI5OEN4YTYwTS9n?=
 =?utf-8?B?dWxFVUVMdHhLWC8yS0hsbVJQQmlIa1I1eC93L0JIUW5oLzQ1cldWTHh0Tmox?=
 =?utf-8?B?Y20yNmJveUpKRDhzMU5IU3JnT0FDVWpMd2VTUGprWjJIakRLMGNMbFVKSjFj?=
 =?utf-8?B?QkNBelFlREdScmRIaHVtZ09LS3FpTERHd3MwQjZyb25nUHlOTTBWYmUwQkt3?=
 =?utf-8?B?WGZpZjdTczltR2ZuV0Nnc1BUdHVXK25heDRuajhkLzZlU0hXVDBLRmxIQnJm?=
 =?utf-8?B?YnMrVUVLSU1QUVcwRWpnRUdBK1ZlVVBQUURGaS9pMVhtR2poV3pGa1h5VXlr?=
 =?utf-8?B?bkwzZUt1S3pnUGJLSDBGTFIwV1JyZXVzQlFaUlNnb3FpL2RVeDE0T1RiTE4w?=
 =?utf-8?B?NVgvcTl0U1hLZlhoTk1oQjJ1RnVWZnhLcEM1QnhNYmdMNkwrdTRWR2lwdjJT?=
 =?utf-8?B?ZzgzWmNtRmhQK0FLMDBBeFR0RkhVVy8zTXBjWmt4MVFNbDdIVDlLY204SFNu?=
 =?utf-8?B?U3lBUEMyMXVPQjNjbm5Nc2NjT2xkdzQrQWxpWENVZXNURm1qVGc4ZW1ORlNQ?=
 =?utf-8?B?cGx0V2YwZGZpN3dFUEEyb2VuejdHc3ovbU85THJKZkZPM0FKalNCM1BiMjJp?=
 =?utf-8?B?czFyL0QreTJzN3dteDJ4WWltTVlhOVpyYm5qdVF3d2N2dGtuRk9mTEZ2dmo0?=
 =?utf-8?B?UGZ1RTNjRmVuWGR0YzJGclJQZTAyTmwvRytmZHEzZjdUMXk4NWQ1dDNNeEtG?=
 =?utf-8?B?b2JmL1pGVHhXOW4xZ0ZxZ3NYVTlvZkhDSTh5UkU5SnVWUkxlT1BHSlRJR2ZB?=
 =?utf-8?B?RHBZZHBrL00yT08xV1RUUUVnZnU3YjZzQW1hK2hSR0IrdFo1cGcwTWVHM25s?=
 =?utf-8?B?dDVYODhMTkpuTG93ZVhMQXo5RGFvNkw3d21sYXBRckRRSTFzVzV1S0F1TURD?=
 =?utf-8?B?ZW1YbXVyZTNuYzZIV2tHbXdtSldTakFuTHZhRjdObWloZkhWREJHeW9za1Bv?=
 =?utf-8?B?dWhEeDdhWmROZkZMbzgrWUhSMUFrRDhZamlpdTVHVnhDWGVRclhtUnZSMWRU?=
 =?utf-8?B?ZFllOHdkUVFBR254bVozd1JCeEFBYjlyQkE0a2ZvSWpYK0lOV3F5enRVUC9q?=
 =?utf-8?B?VlpFeVB5Z282eHNJK1VuRy9GZUIzeUx0bGVTd1RydkorY3BsREs0RU9kVVBL?=
 =?utf-8?B?RWU2UHJvMUdwSE9FS2UySk9iWEg2NXRQblFEMzhpQk13bUxKeVpzMTJRVkJq?=
 =?utf-8?Q?cLgRWo2v07RVu6TU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6C979ADCC8B8BD489B058A8889E4BFB1@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f54f259f-0e55-4caa-99da-08da3cc805cf
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 May 2022 14:25:01.4494
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cthF1WVtv8UD1sqgBGedAkP+qhYKjjo4+Jcdph+i3UaXHhkZ7yXTpgCe/zNn8xfS02WyHb5EfXIBhu+yoYLtXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR10MB2835
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.874
 definitions=2022-05-23_06:2022-05-23,2022-05-23 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 bulkscore=0 malwarescore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2205230081
X-Proofpoint-GUID: z763tMk4yh1EGTfyH7RqZ3nQiRWk_A2z
X-Proofpoint-ORIG-GUID: z763tMk4yh1EGTfyH7RqZ3nQiRWk_A2z
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

DQoNCj4gT24gTWF5IDIzLCAyMDIyLCBhdCAzOjUzIEFNLCBSaWNoYXJkIFdlaW5iZXJnZXIgPHJp
Y2hhcmRAbm9kLmF0PiB3cm90ZToNCj4gDQo+IEJydWNlLA0KPiANCj4gLS0tLS0gVXJzcHLDvG5n
bGljaGUgTWFpbCAtLS0tLQ0KPj4gVm9uOiAiYmZpZWxkcyIgPGJmaWVsZHNAZmllbGRzZXMub3Jn
Pg0KPj4+IFRoZSB3aG9sZSBzZXQgb2YgZmVhdHVyZXMgaXMgY3VycmVudGx5IG9wdC1pbiB2aWEg
LS1lbmFibGUtcmVleHBvcnQuDQo+PiANCj4+IENhbiB3ZSByZW1vdmUgdGhhdCBvcHRpb24gYmVm
b3JlIHVwc3RyZWFtaW5nPw0KPiANCj4gV2hhdCBpcyB0aGUgZmluYWwgcmVzb2x1dGlvbiByZWdh
cmRpbmcgdGhpcyBvcHRpb24/DQo+IEkgY2FuIHRoaW5rIG9mIGVtYmVkZGVkL21lbW9yeSBjb25z
dHJhaW50IHN5c3RlbXMgd2hlcmUgdGhlIGRlcGVuZGVuY3kgb24gU1FMaXRlDQo+IGlzIG5vdCB3
YW50ZWQuDQo+IA0KPiBPbiB0aGUgb3RoZXIgaGFuZCwgd2l0aCBteSBsYXRlc3QgcGF0Y2gsIHRo
ZSBwbHVnaW4gaW50ZXJmYWNlLCB0aGUgY291bGQgYmUgc29sdmVkDQo+IHRvby4NCj4gDQo+PiBG
b3IgdGVzdGluZyBwdXJwb3NlcyBpdCBtYXkgbWFrZXMgc2Vuc2UgdG8gYmUgYWJsZSB0byB0dXJu
IHRoZSBuZXcgY29kZQ0KPj4gb24gYW5kIG9mZiBxdWlja2x5LiAgQnV0IGZvciBzb21ldGhpbmcg
d2UncmUgcmVhbGx5IGdvaW5nIHRvIHN1cHBvcnQsDQo+PiBpdCdzIGp1c3QgYW5vdGhlciBodXJk
bGUgZm9yIHVzZXJzIHRvIGp1bXAgdGhyb3VnaCwgYW5kIGFub3RoZXIgY2FzZSB3ZQ0KPj4gcHJv
YmFibHkgd29uJ3QgcmVtZW1iZXIgdG8gdGVzdC4gIFRoZSBleHBvcnQgb3B0aW9ucyB0aGVtc2Vs
dmVzIHNob3VsZA0KPj4gYmUgZW5vdWdoIGNvbmZpZ3VyYXRpb24uDQo+PiANCj4+IEFueXdheSwg
YmFzaWNhbGx5IHNvdW5kcyByZWFzb25hYmxlIHRvIG1lLiAgSSdsbCB0cnkgdG8gZ2l2ZSBpdCBh
IHByb3Blcg0KPj4gcmV2aWV3IHNvbWV0aW1lLCBmZWVsIGZyZWUgdG8gYnVnIG1lIGlmIEkgZG9u
J3QgZ2V0IHRvIGl0IGluIGEgd2VlayBvcg0KPj4gc28uDQo+IA0KPiAqa2luZCBwaW5nKiA6LSkN
Cj4gDQo+IFBsZWFzZSBhbHNvIGRvbid0IGZvcmdldCB0aGUga2VybmVsIHNpZGUgb2YgdGhpcyB3
b3JrLiBJdCBpcyBzbWFsbCBidXQgc3RpbGwgbmVlZGVkLg0KPiBTZWU6IGh0dHBzOi8vbG9yZS5r
ZXJuZWwub3JnL2xpbnV4LW5mcy8yMDIyMDExMDE4NDQxOS4yNzY2NS0xLXJpY2hhcmRAbm9kLmF0
Lw0KPiBvcg0KPiBodHRwczovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dp
dC9ydy9taXNjLmdpdC9sb2cvP2g9bmZzX3JlZXhwb3J0X2NsZWFuDQoNCkluIGhpcyByZXZpZXcg
Y29tbWVudHMsIEJydWNlIGFza2VkIGlmIHRlc3Rpbmcgd2l0aCBORlN2NCBoYXMgYmVlbiBkb25l
Lg0KDQpBbHNvLCBjYW4gYW4gaWRsZSBjbGllbnQgYWxsb3cgdGhlIHJlLWV4cG9ydCBzZXJ2ZXIg
dG8gdW5tb3VudCBhbg0KYXV0b21vdW50ZWQgZXhwb3J0Pw0KDQpPbmNlIHlvdSBoYXZlIE5GU3Y0
IHJlc3VsdHMsIHRoZSBrZXJuZWwgcGF0Y2hlcyBuZWVkIHRvIGJlIHBvc3RlZCBhZ2Fpbg0Kd2l0
aCBDYzogbGludXgtZnNkZXZlbEB2Z2VyLmtlcm5lbC5vcmcgYW5kIGF1dG9mc0B2Z2VyLmtlcm5l
bC5vcmcNCg0KDQo+IFNpbmNlIHRoZSBrZXJuZWwgY2hhbmdlcyBkb24ndCBjaGFuZ2UgdGhlIEFC
SSwgaXQgc2hvdWxkIG5vdCByZWFsbHkgbWF0dGVyIHdoaWNoIHBhcnQNCj4gaXMgbWVyZ2VkIGZp
cnN0LiBLZXJuZWwgb3IgdXNlcnNwYWNlLiBUaGUgb25seSBpbXBvcnRhbnQgcGFydCBpcyBzdGF0
aW5nIHRoZSByaWdodA0KPiBrZXJuZWwgdmVyc2lvbiBpbiB0aGUgbmZzLXV0aWxzIG1hbnBhZ2Vz
Lg0KPiANCj4gVGhhbmtzLA0KPiAvL3JpY2hhcmQNCg0KLS0NCkNodWNrIExldmVyDQoNCg0KDQo=
