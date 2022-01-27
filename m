Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 870A649E7F5
	for <lists+linux-nfs@lfdr.de>; Thu, 27 Jan 2022 17:47:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238549AbiA0Qr0 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 27 Jan 2022 11:47:26 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:11252 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238546AbiA0QrZ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 27 Jan 2022 11:47:25 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20RFtuYV012353;
        Thu, 27 Jan 2022 16:47:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=azlDARYTjKbMMZ893B2kR7tkSXL2frljs9/jk3ogSGc=;
 b=tybFCxyG2LJ/7pecMMK9+Xr/Ylm2y+8QJPD0oCb6sKFIHOBm/gY7ZJU4iAGvN75NIUCm
 8auW3yJdgr5YvS6DW4MFHjodYO+aoLRnLfDaC6qq5aKo5SI0hw4bopPBEIqrXPXsEKZo
 QbAjntcdzDz1PFsleRDc/97gyVBPoJhC9Bbc/eTeNYj+Urhwv9h/uwmfbVZJVgKFo49c
 4DVPLhJndkWgzFYqHZ+Ca0FYcb9LFltDDkr+03Bb9IeGwat6bWA7FTOSq3FtliaOQ3Xa
 64p5OeOO2S4HYoscmDfaiLaSDVlOgEfRN2QgPEOONZvRDXFCURmh3gdE4FjRaNIYO5J3 1Q== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3duvnk8mty-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Jan 2022 16:47:12 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20RGUswl007664;
        Thu, 27 Jan 2022 16:47:11 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2174.outbound.protection.outlook.com [104.47.55.174])
        by aserp3020.oracle.com with ESMTP id 3dtaxau80g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Jan 2022 16:47:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VnRejFpdGBMJyNzMImMJM3pM64uxp3unnI6AkYfFIoKb9+brB72dMmiNNF00IiMgKmJHcBCTdf/s0ZKurtE6p9l87ZjjHuWmo+doXGc+oIG4z7KvkdI+YOvikRV+AQyMlyBj5z+jPRD1kzR27e6oum008IRpO6IjHSNjUO75ia/OCZSGzCevSmnhrhBVIUpiQeyRcKKzaO0WEoAVQJdeCQRY7CDuAGeqHpGnOdHugvgmUJF6J8gCkHXgbcHrk2SbYlDDBSUISKluS8HMDVREBCKSUW4+e3AhR/O6hehJ/h2TTRj/0/38Y7Pv3doArKJbk/UKl7XXk2Qlg7bfMlCFKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=azlDARYTjKbMMZ893B2kR7tkSXL2frljs9/jk3ogSGc=;
 b=D6Nn70rGet/ASI9qMXlIj86WCuRKp/TkGmnTdzLssXYFX7W9Vi1e7ZNhfXrSRGY7e+FkZwWquMJLLeiKo3glxepcxbsmOcKPF9kBiMxBGQOBWG82I77R6mmn/zIZybAJaEqXE7AvLD0rkzKzijw6wL6t5x/vwW0bqdX+hpOVeusrdst4UsS4TAYYmYmTZfYhNhgASwVvpDMmSSJ3xBM0Fyy4FJXQmjNJv3wDv75zOxt4cxiYJRuNCTbDnVOrpNIEwchyHaHAo6B8ztGifzWFmXB+djnxP68EwxFfeS/4CrEtZcNH88SHCYbk1n3l0RJxWD1AfdjivwIdYi3rPdymZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=azlDARYTjKbMMZ893B2kR7tkSXL2frljs9/jk3ogSGc=;
 b=fMpsoAHoaFlBwmFw35ofRkdHJkij3U68z/32PIisszsEy5j7MQIwTYPv0ZA3ISFrKObFxKGFlSnhLv93FpGK3A0k6EDTAADO6wiOlQreD23pKIynsnHnHLJVxZa5+0EnsmYbDwn2apncRywJjPOG3CQjlgr4x6Smk0F1kaonOOU=
Received: from DS7PR10MB4864.namprd10.prod.outlook.com (2603:10b6:5:3a2::5) by
 CH0PR10MB5148.namprd10.prod.outlook.com (2603:10b6:610:de::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4930.17; Thu, 27 Jan 2022 16:47:09 +0000
Received: from DS7PR10MB4864.namprd10.prod.outlook.com
 ([fe80::16d:ecf0:1ab6:7401]) by DS7PR10MB4864.namprd10.prod.outlook.com
 ([fe80::16d:ecf0:1ab6:7401%2]) with mapi id 15.20.4930.017; Thu, 27 Jan 2022
 16:47:09 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Bruce Fields <bfields@fieldses.org>
CC:     Richard Weinberger <richard@nod.at>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        david <david@sigma-star.at>,
        "luis.turcitu@appsbroker.com" <luis.turcitu@appsbroker.com>,
        "chris.chilvers@appsbroker.com" <chris.chilvers@appsbroker.com>,
        "david.young@appsbroker.com" <david.young@appsbroker.com>
Subject: Re: NFSD export parsing issue
Thread-Topic: NFSD export parsing issue
Thread-Index: tZUv125qQuwu7HR24zRIctOgjnMuiIXHiY+AgAACnwA=
Date:   Thu, 27 Jan 2022 16:47:09 +0000
Message-ID: <9A414DA4-1AE3-409C-A99E-033F0D8F7212@oracle.com>
References: <1986873600.300036.1643286151703.JavaMail.zimbra@nod.at>
 <20220127163745.GB1233@fieldses.org>
In-Reply-To: <20220127163745.GB1233@fieldses.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5d598042-b395-4eda-c6f4-08d9e1b4a8c3
x-ms-traffictypediagnostic: CH0PR10MB5148:EE_
x-microsoft-antispam-prvs: <CH0PR10MB5148AEE938CE322D0845DAC593219@CH0PR10MB5148.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7e/ainLiH2EEXW3Lc317fspeGySnJIrE/THXM3PO4yVHejvTdo3ZqLV019HMlZCfIeziXTn3j9oOuoDbyavXpNJscX9uFFjcbhnKnvnYoDpoJVRo9UBhfZ2M8dcLzRpcwOTBm/EQP41KuJrrui3DYWg5CDn6OCmaPTE6MCKdSqKrdf6TYRDvbk9hQauhAl0jv6zexBEGnaFVgChcB5kCVJSFL3ehpCVgi2UChq78OKkA2UPjlUbpM2QWoW10a6EjnKSz/SQ+ZuCLCWpI1YctI3lmaV6iC3vYutqeA1+F/z6fAPRmnINCG3nQwo2NgNk8bCmJw2i2gBOraoNttvuFP6FC8rh4RbIYWXHc2ZoodRZbxbVdlgBacdPKnmy264NokRSMgaOUYCU+WQ9kU3/1fne+HKkm7SoCFtRaT2Qc4BgwYOFKY3u9B2TKUKXoFNNskUk6GG3oI+KYcgYmsZbvvgCY+9XCYpJyDZOzaYCRUddeqSz3uuBZVbAQfL+n71JIkYBcK7aIG7pB7O+i6IqRbc2sNVJqF1lhlXFmkU2Cy2Xjm30CtgInVcE3TyPPnwf2OSTg5/a1I+Vhf12FeKXpcMOZ3oinVJLBB6vJnogLjNyGCdQYKUdSSrwDoJqQQEHDE/1p3FihzBztKOVFWUwH5uxZSk9BcM7BawN5VGkafR2unRcfEuve59k+uZzKaqFpeeEDLzaLx7htlDKUEstdPK3Y+UO6cMhp7L7ZncCuPT5DjqHsetwGe/S1NzlDcZab
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB4864.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(4744005)(3480700007)(26005)(186003)(6506007)(2616005)(6512007)(33656002)(36756003)(53546011)(71200400001)(5660300002)(38100700002)(6916009)(66556008)(508600001)(6486002)(122000001)(2906002)(66446008)(316002)(64756008)(8676002)(38070700005)(8936002)(76116006)(66946007)(91956017)(54906003)(86362001)(4326008)(66476007)(45980500001)(20210929001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Qdwrw/YOiQZ3LSrjwxTIK4aadoCTc9/zUeCUBtyyjb6wMcdK4mv2fHdHvWHT?=
 =?us-ascii?Q?ySZYmkZeDqsTtgGRB+TFI8Sab1UiawjghwHprNctDw4nnMYfd1dG/qv/gQIQ?=
 =?us-ascii?Q?LLxbXm8K5T4Lu2nKqmHym9XiIFW13uiB6JmWzZV8Ak32cqjgLk90PUivbe8W?=
 =?us-ascii?Q?XJXdityyqXmxV8m3I9vwZNljQKBSFSwTFiDtBOq6XD6C6rZR3Y7AdKX6yDlt?=
 =?us-ascii?Q?NKdul5hzG7dfxYnUIwg4lN2wkH52wnF/PPwQB25x/5R98oTscK2avtGzh5o1?=
 =?us-ascii?Q?MrKlX9U9/iuDbrjN9RvhOilb+fbA6a2ATcV9pVTUXzUB70XNjWVPtYAymZvy?=
 =?us-ascii?Q?satORgVbshQmm9LQv8nvKL1D/yYLeCnLBIdvUTOnEYRb7nyFQaxPOwvfTvGn?=
 =?us-ascii?Q?vvbuYNqVF+WCPsYig5P8CnzIt+ipxdQhbAhXFQkKbi8g0lQmS99ql4TMg556?=
 =?us-ascii?Q?iem40JzFZzHqY0l6D+U4VvTJlQs8WN6mTExNKezfKtBByqwSjRuiC39ndYKP?=
 =?us-ascii?Q?om7MssVyw8t+tPbnc8/cMVhFPYm45ZSInOqGp061P4YYopMezKAPW6Vwe8Vj?=
 =?us-ascii?Q?2s2f5r2KKu5gcB5NllzmMAbvDA0wndH3v+rCdDdMhh9cFmLyoBu+tS5A9Sf0?=
 =?us-ascii?Q?egCHfICRqfbRLv1Dm4izbqzg+j/UtUUsNAT4eJKTKehedQb5wPY1oi4+dSEy?=
 =?us-ascii?Q?PrEYysEIKgfsfIREbErBFLQ9zSMsEdn69yCBmivMtbvR4Vvdl1vSN3WcWLf8?=
 =?us-ascii?Q?L0JcCMWYQ8Gg5n7n/jSwlZSkQ8a/GFRvWdWjeX/g+remA19LH/fWTLoRJl4z?=
 =?us-ascii?Q?7SgZjk2aMtqpPFT72hHaBsE3xuc0VJZGsxjCb2FBO5L1a6JgPLiugCuUBbCD?=
 =?us-ascii?Q?Hmt4BodYGPnAXXc5XEznMI0qVVem/ShAWhU8N0UZ58f8Heo20F/bmkWefE1j?=
 =?us-ascii?Q?n7EbfDZ8KTCpGuimf4bYpbYeP+578/xPJZaKVE0vC6sct0UUQT8paiEtf2GX?=
 =?us-ascii?Q?6cWf5Ncdq5iHsbMypAXuMxYXgYydiSYxaZ+QRNE96ORpFYIeAKPiegtByPpd?=
 =?us-ascii?Q?dQv/xrUjYyfVQTnSEaN6YkfCOAs1pakGfpem7IGoUyKNLnNdzKGJRcrdckIP?=
 =?us-ascii?Q?BYkrPCxw+akfhVOfWgtcFvofYJpEAJIuV644xubqnmxytjt8MO6wHlS0qKdZ?=
 =?us-ascii?Q?a7gXSoN8/nWdjuDnwrZzI5oEzekp4NAwDDdyEqseZb7dKrvTDzVWFKW3bwch?=
 =?us-ascii?Q?vSLOaH3KkhqCFlGbhL5x5Qyn9E0KJeJ9BDvCKTl3u0YoFNKt+J34ENhmudzL?=
 =?us-ascii?Q?3FGd1kI6YbhLVtjWhT4dLFfmmDUq596leJGNGTXnhuRxCj5wWDiXgOWEZZa4?=
 =?us-ascii?Q?UhMMstQVS76Mnf9Vma1sg9Zd+oFp9riJ4Ppbw1PRBLnX5JW0mz877BLaqOP4?=
 =?us-ascii?Q?l5lupWQP+M3NOqyLcF6OkGOa5gt/32LUAwvk78VBv3BYTorM6hiPnYxOmaKw?=
 =?us-ascii?Q?QbthZI5OcM0ccC4eiEXVLYV6GfPa/NuwMrtX0ntYDkbBtM/PR+U837Ij4IU4?=
 =?us-ascii?Q?J3AZ6MOf4IgHTOba2aHU4drrw2AEmdi3tpxZnwobelVwuoN8UGx4fICI795x?=
 =?us-ascii?Q?5LJxqHxZyR/AAEBXNtq1wfk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <35DF983BD9EC8A40A3A7A4E6025C589E@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB4864.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d598042-b395-4eda-c6f4-08d9e1b4a8c3
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jan 2022 16:47:09.0307
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wBGtGNRbJnXFn+fzJwLrXhKyxE8avQJRI4hDHiz4mK1fau9NDC79uvM9ajDfWmrV0uzey3LpDuiQy0UgLZfbjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5148
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10239 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 mlxscore=0
 phishscore=0 suspectscore=0 spamscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2201270100
X-Proofpoint-GUID: 2RMqoZqBj5nIvbSkOPNJ06SbOJiaGLeU
X-Proofpoint-ORIG-GUID: 2RMqoZqBj5nIvbSkOPNJ06SbOJiaGLeU
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jan 27, 2022, at 11:37 AM, J. Bruce Fields <bfields@fieldses.org> wrot=
e:
>=20
> (Should we remove CONFIG_NFSD_V4?  I doubt v3-only kernels get much
> testing.)

I was just thinking that it might be time to consider removing
all the version specific CONFIG options... that would certainly
make it simpler to remove NFSv2 support when the time comes.


--
Chuck Lever



