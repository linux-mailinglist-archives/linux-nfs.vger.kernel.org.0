Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BBAE703335
	for <lists+linux-nfs@lfdr.de>; Mon, 15 May 2023 18:34:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241784AbjEOQed (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 15 May 2023 12:34:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242750AbjEOQeZ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 15 May 2023 12:34:25 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1646A4
        for <linux-nfs@vger.kernel.org>; Mon, 15 May 2023 09:34:18 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34FDRlbW004377;
        Mon, 15 May 2023 16:34:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=W0QgobiyKRE1ETRTq6fQFird8apN0/2Oq67aP9FQQaA=;
 b=4SgTpSc973bqnAumYV3M1MwHsjnfx8lHB9ZjT8b23QKwINOtj9BTbtmbd+tyZbB/u8gC
 12wwAzUVd/u8CtZ0kG7NcoezbvppDNbLB+iuiWQb7tpaWks4S0VNVka56TGBGDrpoCkm
 Rn++yoKOzk3PYS/HArcZyCgKjIBvq79K463HYlZ4U4ClV/DEXBI+EnQ4wM5LiVkvfvqn
 21aVFEky3l/73ErPUy8qlbxGKmRnu89qq8cO5iTuHc0qVk6vry4Ms+Q7E89nAtLOwtTa
 aykWIhouqLMsTktKqrK4yVFV13s3DjKTt4wUDiZNWi+lNmliY3ZiXg7obhbzx8lbu9zB MQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qj1fc0gyx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 May 2023 16:34:15 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34FGKVr3022288;
        Mon, 15 May 2023 16:34:14 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2108.outbound.protection.outlook.com [104.47.55.108])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3qj1095f06-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 May 2023 16:34:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cr1JbwRlRzQzceQ89ZQO3FlgO++XtoFUHqjABA6A3F43YmpjwrbZSkHY2depiQRRtbpcpQrA6X5it9GrLI5WoRkLa9YIW2gxvFFFtplku4ts1BuhHxBjisJ3oZY4yoErpAHwUXsWq4wQWdl7sBBpUeYfkMFqFJnZqxtqprzPsKCtZq6Gwe8ZcB07hQBfUKISN6H/naRCY0QqW7N6Bbexf1OHXlVyoTwJIqBAijQX8zUnsto60dqBGadjYSEMZeJMirod4wtQxDYNLS9ahg99XxotdrhX6EO2Gc6LI+QIHBQ0H5YUf4YXgqTsaMxY4LVn0XTDCNm5Z3yXVLkzpkfXBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W0QgobiyKRE1ETRTq6fQFird8apN0/2Oq67aP9FQQaA=;
 b=eSSuuafqG2wNzRL0upA8z7CuUMJH6W/gLHQSQ3wnL8a+u1GqbiMRqIPVQs2yPQYGcJFDpK9cd0blsXrWLGebOuPl2+hl+/2BH9CboogXCraT1wsiVHPV2l6pJXWvhuEzgZRdenz0AbGBs2HF1P84Ug7X0okCQDRYW56CfXAv9v78oH7qW73ow+2n40lLT1mpJqAUZgoXQijQ1cVDvyKQHcuVTNL+WzSGJooh7oadfwtA2IBigBMpMzkJS1swdfo0jXp27tzoVzIZkYSmJc9duq9O43MfNyMsrUcLpCO5iRUYqmFIbVqbLwjvQU+iGOPKAQ2x6A4Y+kVwf4b3z37uZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W0QgobiyKRE1ETRTq6fQFird8apN0/2Oq67aP9FQQaA=;
 b=QJXgMEwDR9xWyiAByfKKshzPEuOSrYGVQdyZabz80VXLXJwM6YezRH1D8C6I1IgyjDfZkrZuWpqJRc/R+MFQHCdCne/tQ9f3rqS49k0iRFHJuqHkgFVlWPS3lR1Ox4qSv2f1Nf88ZRBUYOPsl0vmIcAwKHaZoGHmxXVDr2WzDtA=
Received: from SJ2PR10MB7082.namprd10.prod.outlook.com (2603:10b6:a03:4ca::6)
 by PH0PR10MB4725.namprd10.prod.outlook.com (2603:10b6:510:3e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30; Mon, 15 May
 2023 16:34:12 +0000
Received: from SJ2PR10MB7082.namprd10.prod.outlook.com
 ([fe80::7060:6db6:9d99:1157]) by SJ2PR10MB7082.namprd10.prod.outlook.com
 ([fe80::7060:6db6:9d99:1157%5]) with mapi id 15.20.6387.030; Mon, 15 May 2023
 16:34:11 +0000
From:   Sherry Yang <sherry.yang@oracle.com>
To:     Chuck Lever III <chuck.lever@oracle.com>
CC:     Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
        Christian Brauner <brauner@kernel.org>,
        Jeff Layton <jlayton@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Darren Kenny <darren.kenny@oracle.com>
Subject: Re: [PATCH] nfsd: use vfs setgid helper
Thread-Topic: [PATCH] nfsd: use vfs setgid helper
Thread-Index: AQHZfPsU+66RsbL0CkG44J2ImQct0K9G/8MAgAAykYCAABoygIAA01wAgABBLwCAADWxAIATBWOA
Date:   Mon, 15 May 2023 16:34:11 +0000
Message-ID: <C4EDE804-24D4-4BCD-B8C5-B29CCFF2F8A9@oracle.com>
References: <20230502-agenda-regeln-04d2573bd0fd@brauner>
 <77C7061E-2316-4C73-89E5-7C8CA0AEB6FD@oracle.com>
 <51805A56-F815-405F-8CDF-4CD04A17436C@oracle.com>
 <741D94D5-4058-452E-830B-49D3BEBD5D8E@oracle.com>
 <20230503-mehrverbrauch-spargel-258668d27f53@brauner>
 <ac5c9882-8cc7-8d64-5784-fd71b04dde3a@oracle.com>
 <A5A8DAD5-7FFD-4CE6-ADC9-FF9F5E509869@oracle.com>
In-Reply-To: <A5A8DAD5-7FFD-4CE6-ADC9-FF9F5E509869@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ2PR10MB7082:EE_|PH0PR10MB4725:EE_
x-ms-office365-filtering-correlation-id: 7b7c2d3b-0406-408d-8fe6-08db556236b8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: A8yL1I06BCBXN9vCrt6QunHKdTT+LJSTaiMhLGnAgk9A69jmgeTseHEi2DMo4R3lLeBf5Ky+qhXGUGBQmvnuu/1InpxAC7Ue4dQQha0Z8zHYOqcHI1f3wVum1ip6x6yEha0FHxe+DUmBds+5n8TBCPnu+g7DUDSOP7tGdEucGTVoJ+/GqF6BrlyqMuE/NkZeDzkit3/CK7wHAXPtJ+K7lqOdAzwBZ4O14jL4zFiy/AaHoOhmUfikIlc6IuQsuAO2e8jG/UKPRaV7f4VTxA4WsHtue0hg9CpPKYlI5LSRID9EqGE1Ony8M1s9sAysiK2vfMU9FK5eFwPhxBizixihXkFgQl69tF8S6RHMXucwKXdYKa1/GSD8y+gR4JHIuwQO4MXKYk6NJofWC+8KwnE8m8qPzo2Mfql6sgrvQ0ob2EAk6S47gC+S/5LPLDBaefIGRROSWN2NShQOWwpIicup/gjM7vQ9S9tAfoseq0AXOL041xG6Et1E73Tm9GEfGni3NDHnzqgkDfBXB08uC6tVpDctAWFHYL5+ObHXHpyGLQMUD+8r/VtBh60sjhRZh7qcw/1eAzpk8g/e00j62dIPpNyyOVzDgoavcIoRelYraTE+UwX6zIo3dMVpNuJv/dHKaGk0OGxClRIYBooaMZ4p5g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR10MB7082.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(346002)(376002)(396003)(366004)(39860400002)(451199021)(83380400001)(66476007)(66556008)(64756008)(66446008)(66946007)(91956017)(76116006)(2616005)(6486002)(26005)(6506007)(53546011)(6512007)(966005)(107886003)(478600001)(37006003)(54906003)(71200400001)(186003)(44832011)(86362001)(8676002)(6862004)(8936002)(5660300002)(2906002)(33656002)(36756003)(41300700001)(38070700005)(6636002)(4326008)(316002)(38100700002)(122000001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?okov834UQZu53zWTtlXP1NPSK0OWFMIzk2899aCnSQ39OvD0X5fb3oFVHGgC?=
 =?us-ascii?Q?43vAaY/DnKrA329EpHIp7whaxCrE7aDtfJFG3y1XuU3Ny/KPL5tmUWZDxswu?=
 =?us-ascii?Q?Ls1ao/UMNv52ca8ZvftkzeptsCcR0LtqX1SXI6HYw9g0OlQ/Zr3v4DLjSY03?=
 =?us-ascii?Q?WZh7nqlDzUhL1AghVU1X/ujGjqITKyszTXQvVdsl9d6okO0X/S0uiuPuNNpt?=
 =?us-ascii?Q?n2WwGm0Hii8HjIRQmR/3yFzPWUuamlbLDPqehlDKeGdKNhlLXX0YTlhlNezu?=
 =?us-ascii?Q?6UzOhp8QyclwzzndpVkNbmRUYxEumzG5Qr1bK91AUkfZ1E5408qNGFKOf3FF?=
 =?us-ascii?Q?3t7wg9MM6iDYekG4m6KXVtF8YGHPmDUj2WiCww+n5ZriSuBKmlaF+eG8F829?=
 =?us-ascii?Q?VyNqLFiEwioxdjPBqnlE9zmx/Wjwm6ccKjYPo4qJ0gmTysIZxQCorNZ0w+XP?=
 =?us-ascii?Q?g0jGblgMUe6HCYLDzXsDGAX+6pgDn/sOkd8QmPoMPee3fI4YmnbmDIazLgEY?=
 =?us-ascii?Q?SnjxZsYNHZRPnaKPj6A50EscuCyA4PAOHoMITdkBguqUy6IOne7EdFBWMaIx?=
 =?us-ascii?Q?sQQWt0lsV0vYU5QRcjxunZ/lzozKtuW+Ip6cPbFpMbeAuikuCCe/bOMz1/So?=
 =?us-ascii?Q?dEGVCsWeMPGcGE4Oypruw+e+NaJNX3caACKz29I6jCStQcEuyUqZDhK4Z7Sz?=
 =?us-ascii?Q?mFp4hDjLFZTdcNs5iHH+cCjNIVwyVLD4yX/e30JmxQ2if6zpi8Akx7JSuxQ0?=
 =?us-ascii?Q?zJzU08ODQkJ2SJY9zrwuLsU2vhPust20Gox8hIKIWuCkzMR+C8Fhz6ETB7P2?=
 =?us-ascii?Q?WcU+h7ddxQkzxf2/jhzYBeTWabJqEIADrX37kqUFexaprTjdcs2OPw/0QeMu?=
 =?us-ascii?Q?3SeDJikNg+amIb1/v9x2AUrCF8FSB3JFx/HL4eCyeob9e6VWEa0jjLAD4KPm?=
 =?us-ascii?Q?thBtRFFWQaUdM5trUfhsU0bc6/BS+di+rK9Om6o1rHTJkzVgES8b76UlNwkJ?=
 =?us-ascii?Q?rWyjBh2Ih1f4lAUTjpoz0WYRosZTL6B5xn9T1IWi0RleAUXm4P39Lnqzm3sz?=
 =?us-ascii?Q?z8w9LX5E4Vdr+TDdzugVX8DQ29aPDoIBLAbJvLP5mHqiDKu5RumsLepPR7EV?=
 =?us-ascii?Q?1B2+mQnUfnE2XNqTmVIVyAkBbzwxPvYcnFpz8x03RGNPAoVp7jqnb+9yz+E0?=
 =?us-ascii?Q?0KmP47Yh19Izh1a7BW4SpZmzGfktN4CeyST+3hh6KziZ6xihYygnRgoXtWN0?=
 =?us-ascii?Q?8N9cUU0+bYszny5I4cxK789y0milg4A7pfglzJU5sGqNei27EDwls/kIA/oF?=
 =?us-ascii?Q?GUgwXfUSXHcpe2JGa2rahglbWYY0eFP9ybd14wEgOmaka/WgUnSclVCpzW7g?=
 =?us-ascii?Q?KZaue4vz7pmGhuUtQUEax8KE2b8YhdLlLeGgfywxN+RLtVN+89v8fk7b/Mqm?=
 =?us-ascii?Q?nw+lLpEBkUJ4pAMmg2zYuu+vN6GO484qUBU9L7GvQ/F9c/BfMt6sgOqjI/cL?=
 =?us-ascii?Q?obOby7SyKS0iyv6zf7FzIiuCZ74Q7L4bDtZl+a2lHXAoscIZ1mc2XdMdtqDz?=
 =?us-ascii?Q?eCv7Ou6mGBNBORWNjZjd7KIHjjwrXdMxbtEmZSQDpEoV/YF6xAPBsUzlhVey?=
 =?us-ascii?Q?Gw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D896E6279A9C21498F9EB4988124B563@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Q+t8Ix30krqDt2z1/fdm/HBqK5TxgR6bEb0Jl2KFF1fG3iPqwscC9qzMNehpiNTsMYfg5rC3uplQYaGORlx1/xzh/UwNGOJ3V8Q+F+812pxtHOlC3bcjlkibN+46Pyht87/+iuz4mlc56oxrAjH+oSun33Pi4+d1lieelCexbT6BCpPI0WccCxZG+GLuHgV7K4PBJZ4nM5lrm+lXcKPRgqKJAQT0Ng0piZYSo2ISBHc6LKPgjqS6+VsfNw8JrNhlTYBhTpfMh3EUtSHCUKFok0mKxSEi0A0Ej9utj4usJp9cQm+C67hp6mORjLk6yqFqJF3zYrg1JvZZ1soD5g/DLKzKdzCZMNm3g31VXX4jLFhxgdfl9SQ8f3bpMvgJztMwVvTtXL+UsQBfDo6rTexuDARjwRUpz9vmAZNWx3o0pW1hbronn218q+23ejDBQ8ff08YZuN8YXocBGsn88sIZ79UTAhxvgXH1xtw/YdeRAdcwdxkWXmrZ404XthmahJ+CnSeTvyG/5DkgdH/LoCSQ7TJ5AUO7yuwgNtiO/iEVn294CneQqDdoKPF63lCqHo2OjFA2NqbcKdLRjZgOCX9GPKxLfsb2TgGiCAjnNm/XNCcxxCPu6nxTnWJ5ghMHJ9a8PIVPKdRJucoOlEWrmxO/fqN2hPriMXghNI/+XgScrPdJgVPn14aJKZFnBIbym+hsMKy8SlsoSUt+S0gqySvelGeXGVotRDBhmFKAJZkounGsUgX/OkXkiTik9Xl2asFym++wGiKjAibYAzov8nk37B/VUoU68Wc76IchjtV7pCE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR10MB7082.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b7c2d3b-0406-408d-8fe6-08db556236b8
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2023 16:34:11.6063
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BNCBQevCvE+lV6sFREig+qrPXf2lzEnvzthEqmRhtNmTY1sw/VXCnAzBMdg2qczEW8aozNWNQrg9WKInrPodjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4725
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-15_14,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 phishscore=0 bulkscore=0 adultscore=0 malwarescore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305150139
X-Proofpoint-ORIG-GUID: LOSqQEjDQReLNt5Mc2xb4k310qps8aBH
X-Proofpoint-GUID: LOSqQEjDQReLNt5Mc2xb4k310qps8aBH
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On May 3, 2023, at 7:05 AM, Chuck Lever III <chuck.lever@oracle.com> wrot=
e:
>=20
>=20
>=20
>> On May 3, 2023, at 6:53 AM, Harshit Mogalapalli <harshit.m.mogalapalli@o=
racle.com> wrote:
>>=20
>> Hi Christian,
>>=20
>> On 03/05/23 12:30 pm, Christian Brauner wrote:
>>> On Tue, May 02, 2023 at 06:23:51PM +0000, Chuck Lever III wrote:
>>>>=20
>>>>=20
>>>>> On May 2, 2023, at 12:50 PM, Chuck Lever III <chuck.lever@oracle.com>=
 wrote:
>>>>>=20
>>>>>=20
>>>>>=20
>>>>>> On May 2, 2023, at 9:49 AM, Chuck Lever III <chuck.lever@oracle.com>=
 wrote:
>>>>>>=20
>>>>>>>=20
>>>>>>> On May 2, 2023, at 9:36 AM, Christian Brauner <brauner@kernel.org> =
wrote:
>>>>>>>=20
>>>>>>> We've aligned setgid behavior over multiple kernel releases. The de=
tails
>>>>>>> can be found in commit cf619f891971 ("Merge tag 'fs.ovl.setgid.v6.2=
' of
>>>>>>> git://git.kernel.org/pub/scm/linux/kernel/git/vfs/idmapping") and
>>>>>>> commit 426b4ca2d6a5 ("Merge tag 'fs.setgid.v6.0' of
>>>>>>> git://git.kernel.org/pub/scm/linux/kernel/git/brauner/linux").
>>>>>>> Consistent setgid stripping behavior is now encapsulated in the
>>>>>>> setattr_should_drop_sgid() helper which is used by all filesystems =
that
>>>>>>> strip setgid bits outside of vfs proper. Usually ATTR_KILL_SGID is
>>>>>>> raised in e.g., chown_common() and is subject to the
>>>>>>> setattr_should_drop_sgid() check to determine whether the setgid bi=
t can
>>>>>>> be retained. Since nfsd is raising ATTR_KILL_SGID unconditionally i=
t
>>>>>>> will cause notify_change() to strip it even if the caller had the
>>>>>>> necessary privileges to retain it. Ensure that nfsd only raises
>>>>>>> ATR_KILL_SGID if the caller lacks the necessary privileges to retai=
n the
>>>>>>> setgid bit.
>>>>>>>=20
>>>>>>> Without this patch the setgid stripping tests in LTP will fail:
>>>>>>>=20
>>>>>>>> As you can see, the problem is S_ISGID (0002000) was dropped on a
>>>>>>>> non-group-executable file while chown was invoked by super-user, w=
hile
>>>>>>>=20
>>>>>>> [...]
>>>>>>>=20
>>>>>>>> fchown02.c:66: TFAIL: testfile2: wrong mode permissions 0100700, e=
xpected 0102700
>>>>>>>=20
>>>>>>> [...]
>>>>>>>=20
>>>>>>>> chown02.c:57: TFAIL: testfile2: wrong mode permissions 0100700, ex=
pected 0102700
>>>>>>>=20
>>>>>>> With this patch all tests pass.
>>>>>>>=20
>>>>>>> Reported-by: Sherry Yang <sherry.yang@oracle.com>
>>>>>>> Signed-off-by: Christian Brauner <brauner@kernel.org>
>>>>>>=20
>>=20
>> We had a very similar report from kernel-test-robot.
>>=20
>> https://lore.kernel.org/all/202210091600.dbe52cbf-yujie.liu@intel.com/
>>=20
>> Which points to commit: ed5a7047d201 ("attr: use consistent sgid strippi=
ng checks")
>>=20
>> And the above commit is backported to LTS kernels -- 5.10.y,5.15.y and 6=
.1.y
>>=20
>> So would it be better to tag it to stable by adding "Cc: <stable@vger.ke=
rnel.org>" ?
>>=20
>> Thanks,
>> Harshit
>>=20
>>>>>> There are some similar fstests failures this fix might address.
>>>>>>=20
>>>>>> I've applied this patch to the nfsd-fixes tree for broader
>>>>>> testing.
>>>>>=20
>>>>> ERROR: modpost: "setattr_should_drop_sgid" [fs/nfsd/nfsd.ko] undefine=
d!
>>>>>=20
>>>>> Did I apply this patch to the wrong kernel?
>>>>=20
>>>> setattr_should_drop_sgid() is not available to callers built as
>>>> modules. It needs an EXPORT_SYMBOL or _GPL.
>>> Hey Chuck,
>>> Thanks for taking a look!
>>> The required export is part of
>>> commit 4f704d9a835 ("nfs: use vfs setgid helper")
>>> which is in current mainline as of Monday this week which was part of m=
y
>>> v6.4/vfs.misc PR that was merged.
>>> So this should all work fine on mainline. Seems I didn't use --base
>>> which is why that info was missing.
>>> Thanks!
>>> Christian
>=20
> I'll apply this to nfsd-next (6.5) and add Jeff's Reviewed-by
> and a Cc: stable.

Hi Chuck,

Just following up to see if you know when this patch will go to linux mainl=
ine and linux-stable?

Thanks,
Sherry
>=20
>=20
> --
> Chuck Lever
>=20
>=20

