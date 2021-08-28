Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECD683FA723
	for <lists+linux-nfs@lfdr.de>; Sat, 28 Aug 2021 20:23:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230131AbhH1SYG (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 28 Aug 2021 14:24:06 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:63350 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229479AbhH1SYF (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 28 Aug 2021 14:24:05 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 17SCbpxw013818;
        Sat, 28 Aug 2021 18:23:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=zaPiukJ5tBe1vZnmCBNakXoQAEqSMQMIs3w3dslGtM4=;
 b=pMyIF/4ECrBUJexOvGSBiaQ/AiYxu13mozkWG9L5cJK0KoRtSnf6o4EDzKixgsmeNTlM
 wHV9AiCwpIZpzDjOsPV1OBhoc9nxZBm4gjaQFtTnYYmvPlpF+b1VlGxxE5IfizGRzDjZ
 2XFHp+rto6Hr2mpknbr4TYVnj0QfxGQLLuUstRjnA4ktocZOXNlRdPHzijBNP8Wftvhh
 vOxE6qw+MALlED5SgXDHpCwWIiKOaP90TKH9bPoYKFHdbwPrzLtjXjdqJwcPBaO3u1jz
 qQT7NCWFpc45O1AtJY7eSATXrAW8Q6RCpErh6837sG1yzSwIz/ovWfPtWFtlvuO9UYws Gg== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=zaPiukJ5tBe1vZnmCBNakXoQAEqSMQMIs3w3dslGtM4=;
 b=RxU3igLe49eMKrYWpCqk7pE9+wWalDmH4NjW9vjAYos/L8EMP2gP+OYAZrOIp8nbqOEn
 C7z4MOIntQze+KLObAwh1K2X6Xny+Ak0/A6P8Bv2CtY2r1JLdSB9jH/x2kp21xjcTMty
 +elSAWXRZmBXJW7Sbf1484uif9Z+enfys6GyQSIYMxNZ20qW3niLzwnhILvGTL0Z0mrA
 ZdWclYU15KYy/1KdBkl9eDflkVn9VggTB0egD3Ryl+txUHvrWgnpAG349c4jxsXbvohv
 Eve0BZTIRH3IhSowl65TZ4xQiKWI3y6zBOhPND/IiSTevbiCx1rDDYseNPRHWCLpL26G 8w== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3aqbjbrsxe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 28 Aug 2021 18:23:09 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17SIFadc125578;
        Sat, 28 Aug 2021 18:23:08 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2172.outbound.protection.outlook.com [104.47.58.172])
        by aserp3030.oracle.com with ESMTP id 3aqb69mph3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 28 Aug 2021 18:23:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zxx7c9KQqp/WSb3CqZQGjeFIDfe7YRLFX52u4d7Vl5dHKb3croQfoKdDwuApewgSOxbrgN76rYMuRAi4sdhr1Hy9hWeFeDLX6j3ErwQEYmtiyZ5MLyLt7sl+gtoFpvzPmGimlc/idiq5pcSSSpo7n7q3z9PW4bEt6zYp103vovooMx1mL38d1GV+7ctguPDoMa6ipM6DkvNdWfUY5+96QnhPrIdB8s3msXnmSGhIC7FK/vBAaiYeyg+uY3JJ55LhMG+9P0nqS6V0aHzZM8rVMbz/2zw+ecrB4rrMTPOLu5P8bbxIdzFZuwBADlUIfR5mlD5y9xNfvd4i7Cexb2hA/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zaPiukJ5tBe1vZnmCBNakXoQAEqSMQMIs3w3dslGtM4=;
 b=gUyRXbzPwGRowiwWKLZb5cDPZTz4hyU7ubpompbdVlyypQ/cxm4NkvgRzMuTTIN+dgNnpyiILMWfnM3DFlzvJLLpr7H+TlSXrrs54lTXE+WKCGxZE4zf2+Xag8EIexj2ZBnJuptUPOHb6PeubYLXk7j7ylTHczObMDu3FhAT5Q5RkhaJ/jAXWo9QTIhqdxmphVdp4lzbld56OGAdpyFJQX7K2AiSYOuvThJ/fJ6rLhZ0++S3CzKLSEtuzpDaygIGj/PI6fOFvHR07x36tHHbdP+J+S19L05yPFghVKsvcw+HOZhSNfOXd5m2AgFtGOVkZKtXzB3iDQDIlzpfhrUCZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zaPiukJ5tBe1vZnmCBNakXoQAEqSMQMIs3w3dslGtM4=;
 b=gfeisePGl3Nxvhqxt3MVwZIY4NJ1OB/qONRrfUTWLG34FDALi2toEM+NMgBg26k5BqfXfsvrp9CQKFoQ8aP7PgRwyE0y3Mlz72PTPiULy3mgPW15Tb7aulQ4xw3GcAndV1pxOM4QXBWaw+4R9YvBUryzHu0szHBSUtzjKbskdpY=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by SJ0PR10MB4608.namprd10.prod.outlook.com (2603:10b6:a03:2d4::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Sat, 28 Aug
 2021 18:23:05 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::f4fe:5b4:6bd9:4c5b]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::f4fe:5b4:6bd9:4c5b%5]) with mapi id 15.20.4457.021; Sat, 28 Aug 2021
 18:23:05 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Mike Javorski <mike.javorski@gmail.com>,
        Mel Gorman <mgorman@suse.com>
CC:     Neil Brown <neilb@suse.de>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: NFS server regression in kernel 5.13 (tested w/ 5.13.9)
Thread-Topic: NFS server regression in kernel 5.13 (tested w/ 5.13.9)
Thread-Index: AQHXjKYRxKTFwD0+C02+ZMVduTdsB6tqSi4AgAAHiwCAAZhPAIAACtMAgAS9YICAAA1rAIAAA7UAgAMLuwCAAZFegIAAyYQAgAAzUQCAAG7RAIAE0AAAgAAF0YCAAxscgIAAOP4AgAAGqYCAASxAgIAGIIuAgAAkXICAACgEAIAAWTeAgAAMTwCAABHBgIAAdRaAgAAwjgCAAFHqgIAAHnMAgAA7fACAAPuSAA==
Date:   Sat, 28 Aug 2021 18:23:05 +0000
Message-ID: <12B831AA-4A4E-4102-ADA3-97B6FA0B119E@oracle.com>
References: <CAOv1SKCmdtchm5Z2NU80o49tkrHpAkPFaHKj4-vLDN5bZNCz-Q@mail.gmail.com>
 <162846730406.22632.14734595494457390936@noble.neil.brown.name>
 <CAOv1SKBZ7sGBnvG9-M+De+s=CfU=H_GBs4hJah1E4ks+NSMyPw@mail.gmail.com>
 <CAOv1SKCUM5cGuXWAc7dsXtbmPMATqd245juC+S9gVXHWiZsvmQ@mail.gmail.com>
 <162855893202.12431.3423894387218130632@noble.neil.brown.name>
 <CAOv1SKAaSbfw53LWCCrvGCHESgdtCf5h275Zkzi9_uHkqnCrdg@mail.gmail.com>
 <162882238416.1695.4958036322575947783@noble.neil.brown.name>
 <CAOv1SKB_dsam7P9pzzh_SKCtA8uE9cyFdJ=qquEfhLT42-szPA@mail.gmail.com>
 <CAOv1SKDDOj5UeUwztrMSNJnLgSoEgD8OU55hqtLHffHvaCQzzA@mail.gmail.com>
 <162907681945.1695.10796003189432247877@noble.neil.brown.name>
 <87777C39-BDDA-4E1E-83FA-5B46918A66D3@oracle.com>
 <CAOv1SKA5ByO7PYQwvd6iBcPieWxEp=BfUZuigJ=7Hm4HAmTuMA@mail.gmail.com>
 <162915491276.9892.7049267765583701172@noble.neil.brown.name>
 <162941948235.9892.6790956894845282568@noble.neil.brown.name>
 <CAOv1SKAyr0Cixc8eQf8-Fdnf=9Db_xZGsweq9K2E5AkALFqavQ@mail.gmail.com>
 <CAOv1SKDDUFpgexZ_xYCe6c2-UCBK0+vicoG+LAtG2Zhispd_jg@mail.gmail.com>
 <162960371884.9892.13803244995043191094@noble.neil.brown.name>
 <CAOv1SKBePD6N-R0uETgcSPA-LZZ4895ZJDKTY7mYvhfu184OQQ@mail.gmail.com>
 <162966962721.9892.5962616727949224286@noble.neil.brown.name>
 <CAOv1SKB6xqyduf5L5hcXOe-xMN-UJOfFeE5eXVga3TviKuH0PA@mail.gmail.com>
 <163001427749.7591.7281634750945934559@noble.neil.brown.name>
 <CAOv1SKC+3LXhM+L9MwU2D03bpeof55-g+i=r3SWEjVWcPVCi8Q@mail.gmail.com>
 <163004202961.7591.12633163545286005205@noble.neil.brown.name>
 <CAOv1SKDTcg5WDp5zf3ZGL0enJ7K693W-9TMYKcrgweyzp6Qjhg@mail.gmail.com>
 <163004848514.7591.2757618782251492498@noble.neil.brown.name>
 <6CC9C852-CEE3-4657-86AD-9D5759E2BE1C@oracle.com>
 <CAOv1SKAiPB62sQcnDCKC5vYbbmakfbe80KRu3JEVZVO7Trk8cw@mail.gmail.com>
 <CAOv1SKATk1iP=J9r2x0CQzNuwq2VoRvN8Mkba3DsKq6W_tfrDQ@mail.gmail.com>
 <416268C9-BEAC-483C-9392-8139340BC849@oracle.com>
 <CAOv1SKCjvgSfUoFtufZ5-dB-quG=djnn-UHO286S410aVxrV0Q@mail.gmail.com>
In-Reply-To: <CAOv1SKCjvgSfUoFtufZ5-dB-quG=djnn-UHO286S410aVxrV0Q@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=oracle.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1f3db824-83c7-4935-8309-08d96a50e0f7
x-ms-traffictypediagnostic: SJ0PR10MB4608:
x-microsoft-antispam-prvs: <SJ0PR10MB46089C786A3A6ED54DEB334293C99@SJ0PR10MB4608.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CDChJydC4rwwWUGVkG2gGobqbCmg3kbfgGykWCMCBmTUb7jocqf2FtRUgpMD0EI2xZVJkyYX2DE5HZ6HGL2wszqUosCTbg1ihMI9vAqVUf4RJrJ/S3PgqpmPIEwXzerzDMUcRp0POGcA0jYqG3qR1Yl7WMW9p9MqlZZBGJFpEbKG/X/ehpFYNuO2+hyKLzPGYeDMu/aZ1ZEQlhmhW4J4a5rHnSf3ZH4AA4SRu8mfs2FYfWU16pHiLoz0pMTTi/TYG59sKQjp8h20Esz28VkQCfBM4K22oTvGcwn2FmUhXxvvx9OZElFaLv9dSEhxq6UltdEOXCecbkM/3lh1sZCpoU1vNWwUQfSmgkW7XB8u9VbaEUPyV1Q2z1wbpE62h/3gQcp00Y83ewXiXf34BDN/y2KI0EnhhabIa9hZVXYux//Ll+wQdlOU1sVMmbwFNtp2CBbHsPcVOs2KEyE4gkotCITXm/d/3FzNvApXG1AIicgeuMzNk4DNwACrxhaMOFU436TfUCElyNjteZUI/CoJB1t2S0YXMPNPByEmO4ZTfZMWluSvVY2V14UujUX0WJtK4/p7MzSInEC/qyKrfzulbItEQWleXqhvoXI0LF53RzmYG8ZjYB2kPu0Qo8LQwMBdl4qp0gVsJLCmUqGiEoPuFnSzXcfGMmInVYUHyuHCKSKjPrt0r6YppEMH8N9WbY7U6aKgmUBG8KRzZ8OfZfM2UIkepuoAtsCU+Zvme0BlCgSDLWfrS3xn0NUYFfnJjuKv
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(396003)(136003)(346002)(366004)(376002)(122000001)(186003)(36756003)(8676002)(66476007)(53546011)(8936002)(91956017)(64756008)(38070700005)(26005)(478600001)(316002)(6506007)(5660300002)(6486002)(71200400001)(76116006)(2906002)(38100700002)(83380400001)(33656002)(66446008)(66556008)(2616005)(54906003)(4326008)(66946007)(110136005)(86362001)(6512007)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?2WW9urO3YVHkvjXT7cxB+YUGC55osDKGNn0ZxuJrJKh0bn/G46dtLw68go0L?=
 =?us-ascii?Q?xeTV0z5CRReukdMNZrvD0L8nH6fCOtrw2hrOLMTISCRWAMbWHCQmzcYG3omf?=
 =?us-ascii?Q?JcncJH3OmryrYPv9s5Vwuk5ybKrEIq9+tDpt3pEx+iyeB5Nd6txLK48O9Jr3?=
 =?us-ascii?Q?BLIS74E6xmxSPTy8H2S7gmXtGnr7AxXiifug4zUTDJ2jurSf/CH1TiLv0eRW?=
 =?us-ascii?Q?75bNr2UrR32mTA419ybe88vzwUBqw1hZXVNAo+dvIHlty9TzJYuTxhfqWsOZ?=
 =?us-ascii?Q?0fDrDAKpJS4pRDZW3jJWvdbFsJ2TZBMMZyyQTu5WG6SWFikJVFYBfZUrbn0r?=
 =?us-ascii?Q?yxJXjbVU2mzFoFPSc6MuMiCaGuBJEJcZSC3IbwJlFtVnFG3xLcbZ9YfhFnZh?=
 =?us-ascii?Q?E0ZHpn0GO8+YnAFHq0C7aofsL1QAyS+rwXefynG6i0E25jDlt+4KAnnJUZWR?=
 =?us-ascii?Q?Gt/yyRxiWH8cAAb8oDbF88I+P6qsPc+6BddCtEkDMmFJ/DERod4HRvpBFebD?=
 =?us-ascii?Q?G/xWXP1TXgS0YbC/YmxN84lqQr0vjxv6vZOZWFRf6HB2Z0ves+7n23sGjr4x?=
 =?us-ascii?Q?Wyg4cKLT4rBqIQWE/6JlaekmmPJqsfYkGphCmRpD8hRjB9sbu2vJbf7UbJ5T?=
 =?us-ascii?Q?hc2K9P5aRsmwO5XDMPU4PoedbhtFkplX4pksZ/3lgKKC4Z9haMhmU76ka7wc?=
 =?us-ascii?Q?3W20MbqK88NtzMGkJZgdzPixfgqjeC0Mt6oG12fiq0+sHX9pY7q7XqhP7Kkp?=
 =?us-ascii?Q?RyYaXvs7kReCm8ozpn/4lEr5Zt62QkI74lSgPUZ3sIRhOLoS6Z1kFmt8H5i+?=
 =?us-ascii?Q?kRtsuglAQT0AYXCBj+rIYhVOMju+7j5S9ALRUeMlfqYtzLx5B+xfliajd0aO?=
 =?us-ascii?Q?WjILa7xSa5RnKbdIUkWZJGB9QlRmceiIs4FUTIno/tWZCuUOpYwozAXCBjRe?=
 =?us-ascii?Q?7qtD1+jccG4rkS7bc7knuq9U+3y9wW0SyTcAGCfOYPzeY7wg7d3jqZbQxd4T?=
 =?us-ascii?Q?LDMIOILVWdsTlerQIhEYl3kBpK4N12CScHY0r54+QuhmTZdHq1udUdHUrAqc?=
 =?us-ascii?Q?3Qc391KefCvgEZ10tm1uMIGsvzQeAT0GQVJqX7chutr/YaerT3EOMhmP7/GG?=
 =?us-ascii?Q?nZJfIXy1PT6CdCQKza9Ol17B54aqBK/sotHw6lyXtx82VE/kT1LrzVftIoik?=
 =?us-ascii?Q?vfdeAVIuwgMXItKuvsUUznCbF2Y6DWOFSZQXa1SSY5D3MrKahrGKLsM51NJG?=
 =?us-ascii?Q?Af9gi0i3qBMn3E58W9VeUSzEi9pZI1JXUjfnxVUUibX7eBoyYFiOKh4Jb3D/?=
 =?us-ascii?Q?sWZWprlyEj5v9w3eQmy3Kn33?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B708D6662AE8F542863198C493108BCC@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f3db824-83c7-4935-8309-08d96a50e0f7
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2021 18:23:05.1939
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jNFtxSK5iJeCXG1YgIv/7e9P14/JctyBPRIjZZWN9ZPbNCwbFKTvOc2v31j8wKYMsXaFWayBDvDwi8sd/xVcnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4608
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10090 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 suspectscore=0
 adultscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108280122
X-Proofpoint-ORIG-GUID: cfpIJT-G8095_6CqovwCP5S_EXMVyccd
X-Proofpoint-GUID: cfpIJT-G8095_6CqovwCP5S_EXMVyccd
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Aug 27, 2021, at 11:22 PM, Mike Javorski <mike.javorski@gmail.com> wro=
te:
>=20
> I had some time this evening (and the kernel finally compiled), and
> wanted to get this tested.
>=20
> The TL;DR:  Both patches are needed
>=20
> Below are the test results from my replication of Neil's test. It is
> readily apparent that both the 5.13.13 kernel AND the 5.13.13 kernel
> with the 82011c80b3ec fix exhibit the randomness in read times that
> were observed. The 5.13.13 kernel with both the 82011c80b3ec and
> f6e70aab9dfe fixes brings the performance back in line with the
> 5.12.15 kernel which I tested as a baseline.
>=20
> Please forgive the inconsistency in sample counts. This was running as
> a while loop, and I just let it go long enough that the behavior was
> consistent. Only change to the VM between tests was the different
> kernel + a reboot. The testing PC had a consistent workload during the
> entire set of tests.
>=20
> Test 0: 5.13.10 (base kernel in VM image, just for kicks)
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> Samples 30
> Min 6.839
> Max 19.998
> Median 9.638
> 75-P 10.898
> 95-P 12.939
> 99-P 18.005
>=20
> Test 1: 5.12.15 (known good)
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> Samples 152
> Min 1.997
> Max 2.333
> Median 2.171
> 75-P 2.230
> 95-P 2.286
> 99-P 2.312
>=20
> Test 2: 5.13.13 (known bad)
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> Samples 42
> Min 3.587
> Max 15.803
> Median 6.039
> 75-P 6.452
> 95-P 10.293
> 99-P 15.540
>=20
> Test 3: 5.13.13 + 82011c80b3ec fix
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> Samples 44
> Min 4.309
> Max 37.040
> Median 6.615
> 75-P 10.224
> 95-P 19.516
> 99-P 36.650
>=20
> Test 4: 5.13.13 + 82011c80b3ec fix + f6e70aab9dfe fix
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> Samples 131
> Min 2.013
> Max 2.397
> Median 2.169
> 75-P 2.211
> 95-P 2.283
> 99-P 2.348
>=20
> I am going to run the kernel w/ both fixes over the weekend, but
> things look good at this point.
>=20
> - mike

I've targeted Neil's fix for the first 5.15-rc NFSD pull request.
I'd like to have Mel's Reviewed-by or Acked-by, though.

I will add a Fixes: tag if Neil doesn't repost (no reason to at
this point) so the fix should get backported automatically to
recent stable kernels.


> On Fri, Aug 27, 2021 at 4:49 PM Chuck Lever III <chuck.lever@oracle.com> =
wrote:
>>=20
>>=20
>>> On Aug 27, 2021, at 6:00 PM, Mike Javorski <mike.javorski@gmail.com> wr=
ote:
>>>=20
>>> OK, an update. Several hours of spaced out testing sessions and the
>>> first patch seems to have resolved the issue. There may be a very tiny
>>> bit of lag that still occurs when opening/processing new files, but so
>>> far on this kernel I have not had any multi-second freezes. I am still
>>> waiting on the kernel with Neil's patch to compile (compiling on this
>>> underpowered server so it's taking several hours), but I think the
>>> testing there will just be to see if I can show it works still, and
>>> then to try and test in a memory constrained VM. To see if I can
>>> recreate Neil's experiment. Likely will have to do this over the
>>> weekend given the kernel compile delay + fiddling with a VM.
>>=20
>> Thanks for your testing!
>>=20
>>=20
>>> Chuck: I don't mean to overstep bounds, but is it possible to get that
>>> patch pulled into 5.13 stable? That may help things for several people
>>> while 5.14 goes through it's shakedown in archlinux prior to release.
>>=20
>> The patch had a Fixes: tag, so it should get automatically backported
>> to every kernel that has the broken commit. If you don't see it in
>> a subsequent 5.13 stable kernel, you are free to ask the stable
>> maintainers to consider it.
>>=20
>>=20
>>> - mike
>>>=20
>>> On Fri, Aug 27, 2021 at 10:07 AM Mike Javorski <mike.javorski@gmail.com=
> wrote:
>>>>=20
>>>> Chuck:
>>>> I just booted a 5.13.13 kernel with your suggested patch. No freezes
>>>> on the first test, but that sometimes happens so I will let the server
>>>> settle some and try it again later in the day (which also would align
>>>> with Neil's comment on memory fragmentation being a contributor).
>>>>=20
>>>> Neil:
>>>> I have started a compile with the above kernel + your patch to test
>>>> next unless you or Chuck determine that it isn't needed, or that I
>>>> should test both patches discreetly. As the above is already merged to
>>>> 5.14 it seemed logical to just add your patch on top.
>>>>=20
>>>> I will also try to set up a vm to test your md5sum scenario with the
>>>> various kernels since it's a much faster thing to test.
>>>>=20
>>>> - mike
>>>>=20
>>>> On Fri, Aug 27, 2021 at 7:13 AM Chuck Lever III <chuck.lever@oracle.co=
m> wrote:
>>>>>=20
>>>>>=20
>>>>>> On Aug 27, 2021, at 3:14 AM, NeilBrown <neilb@suse.de> wrote:
>>>>>>=20
>>>>>> Subject: [PATCH] SUNRPC: don't pause on incomplete allocation
>>>>>>=20
>>>>>> alloc_pages_bulk_array() attempts to allocate at least one page base=
d on
>>>>>> the provided pages, and then opportunistically allocates more if tha=
t
>>>>>> can be done without dropping the spinlock.
>>>>>>=20
>>>>>> So if it returns fewer than requested, that could just mean that it
>>>>>> needed to drop the lock.  In that case, try again immediately.
>>>>>>=20
>>>>>> Only pause for a time if no progress could be made.
>>>>>=20
>>>>> The case I was worried about was "no pages available on the
>>>>> pcplist", in which case, alloc_pages_bulk_array() resorts
>>>>> to calling __alloc_pages() and returns only one new page.
>>>>>=20
>>>>> "No progess" would mean even __alloc_pages() failed.
>>>>>=20
>>>>> So this patch would behave essentially like the
>>>>> pre-alloc_pages_bulk_array() code: call alloc_page() for
>>>>> each empty struct_page in the array without pausing. That
>>>>> seems correct to me.
>>>>>=20
>>>>>=20
>>>>> I would add
>>>>>=20
>>>>> Fixes: f6e70aab9dfe ("SUNRPC: refresh rq_pages using a bulk page allo=
cator")
>>>>>=20
>>>>>=20
>>>>>> Signed-off-by: NeilBrown <neilb@suse.de>
>>>>>> ---
>>>>>> net/sunrpc/svc_xprt.c | 7 +++++--
>>>>>> 1 file changed, 5 insertions(+), 2 deletions(-)
>>>>>>=20
>>>>>> diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
>>>>>> index d66a8e44a1ae..99268dd95519 100644
>>>>>> --- a/net/sunrpc/svc_xprt.c
>>>>>> +++ b/net/sunrpc/svc_xprt.c
>>>>>> @@ -662,7 +662,7 @@ static int svc_alloc_arg(struct svc_rqst *rqstp)
>>>>>> {
>>>>>>     struct svc_serv *serv =3D rqstp->rq_server;
>>>>>>     struct xdr_buf *arg =3D &rqstp->rq_arg;
>>>>>> -     unsigned long pages, filled;
>>>>>> +     unsigned long pages, filled, prev;
>>>>>>=20
>>>>>>     pages =3D (serv->sv_max_mesg + 2 * PAGE_SIZE) >> PAGE_SHIFT;
>>>>>>     if (pages > RPCSVC_MAXPAGES) {
>>>>>> @@ -672,11 +672,14 @@ static int svc_alloc_arg(struct svc_rqst *rqst=
p)
>>>>>>             pages =3D RPCSVC_MAXPAGES;
>>>>>>     }
>>>>>>=20
>>>>>> -     for (;;) {
>>>>>> +     for (prev =3D 0;; prev =3D filled) {
>>>>>>             filled =3D alloc_pages_bulk_array(GFP_KERNEL, pages,
>>>>>>                                             rqstp->rq_pages);
>>>>>>             if (filled =3D=3D pages)
>>>>>>                     break;
>>>>>> +             if (filled > prev)
>>>>>> +                     /* Made progress, don't sleep yet */
>>>>>> +                     continue;
>>>>>>=20
>>>>>>             set_current_state(TASK_INTERRUPTIBLE);
>>>>>>             if (signalled() || kthread_should_stop()) {
>>>>>=20
>>>>> --
>>>>> Chuck Lever
>>>>>=20
>>>>>=20
>>>>>=20
>>=20
>> --
>> Chuck Lever
>>=20
>>=20
>>=20

--
Chuck Lever



