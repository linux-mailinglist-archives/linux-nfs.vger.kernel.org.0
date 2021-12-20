Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97D2947B35C
	for <lists+linux-nfs@lfdr.de>; Mon, 20 Dec 2021 20:02:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240642AbhLTTCb (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 20 Dec 2021 14:02:31 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:1512 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235151AbhLTTCa (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 20 Dec 2021 14:02:30 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BKGYrGc013036;
        Mon, 20 Dec 2021 19:02:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=ie1gvFnwa5kAyNCysd9dzxb2c1Oj8pbfnlxQd2JAMlg=;
 b=XMlX5BNRJHcXKAtN2qjlzQo1Tm+PygxPQtgSB9qfhSC2JpZzJzGtzGxBtFznqg//mAyX
 7yCTg4fUNJbc+3/LKj+RPzeQK7gCrBO2fdIiQzfx7o3LvMZ5VpJcjIOPSBeJMWG4Ee8R
 LJ98Do7KBuyArvqfMtkAnfq6nM//XFeaHVa1aAulW7gQ1FvNrclFlllkjokSWCOdL2vV
 25VXMTPFUCPgvhgzPFOnDtA2jImYQLxWQ9/AePsLxGOpMPZRqBOXwFKUjzfwLRwRkIma
 GRpv+AHaUvlVFpXMPedh/FcAQQI5+q6nXrQHr9qGZH4e4bHqrXAwx3u52cwtWBHMUZBl dA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3d2udc8v0c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Dec 2021 19:02:16 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1BKIuPgN119941;
        Mon, 20 Dec 2021 19:02:15 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2108.outbound.protection.outlook.com [104.47.55.108])
        by userp3020.oracle.com with ESMTP id 3d193m2j98-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Dec 2021 19:02:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TXJg1p1oKhOPeXWMzKP9BpicIpwQQusTOqwl+VlkwMcq5QtwX2PE2Rw7ww81DW3RI3KpYMdjud+jJqQXioypvIPvMIX1Nk4/NR5B8aBsp0rbC1C57sq1qiyqamT7Hiw0mZH0Om8kYwcKnEQB/0abiIQIwFe03xiFpUczyGFhu1fQ5DVL0Iz7vEly1eSnbnz9jbmONfXeK4Iyn7wf55qJFN9S6p52vN0VIA0DgZDwCdC7qXaxvyxaz0/Q33nj+gRFeR4OQXZ8Q7sYLAXRrmIRNVZKyvn0gaiT4UplZ4/d+1XeM8DW0JdpH3zasC8C0mzjTAExBbdTFZtFFAKFaQ4j0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ie1gvFnwa5kAyNCysd9dzxb2c1Oj8pbfnlxQd2JAMlg=;
 b=bRlzDVH3wSyWIZGH2aqCKOpn6HgxV/IudDBaZrpTSp68E0QlrJs6xJ+QExNf+Lc087yatCxw4Wi90ymVVdwqgMGtrh09IJ3g/kb6mAWDDApw3U0VuyUNuqLMnSVVqfkbG/DvQsgr5tySA0EjXGeo5vPm/UGcimYPeta7+Cc6UIvr8fic4wE6m/L8Lf+NVVPOxplGooPYlf13WhNX0RnZmFiUuAr/lzgv5J9oy2rez6Vafj17xro8+/9aI4/ERS/vp1Q+gmgvb4oycWXNMlievYqoTE7kHbA3JDf19YmkDQYUaxCNSvwiNbq3cXbmraYGABsszxL+Jrx5dF8jEuBmJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ie1gvFnwa5kAyNCysd9dzxb2c1Oj8pbfnlxQd2JAMlg=;
 b=Wi1Cohndq5VqwkrDavt71syojtPxVE67P1aJ8hJhY1mGQr7fPHsVCxfpaVP9WtpsgCACmLY9lnyaWwqTX5ugIrw5DBbfWC83jPhIpX5SVl1Ov8Z7HdzO0x/zDjwX4pNT4wxud5kERQUgAuO2p6C+25w5q8u2qKpNalqVK/Rr23A=
Received: from CH0PR10MB4858.namprd10.prod.outlook.com (2603:10b6:610:cb::17)
 by CH0PR10MB5290.namprd10.prod.outlook.com (2603:10b6:610:dc::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.17; Mon, 20 Dec
 2021 19:02:11 +0000
Received: from CH0PR10MB4858.namprd10.prod.outlook.com
 ([fe80::241e:15fa:e7d8:dea7]) by CH0PR10MB4858.namprd10.prod.outlook.com
 ([fe80::241e:15fa:e7d8:dea7%6]) with mapi id 15.20.4801.020; Mon, 20 Dec 2021
 19:02:11 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Trond Myklebust <trondmy@hammerspace.com>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Bruce Fields <bfields@redhat.com>,
        "trondmy@kernel.org" <trondmy@kernel.org>
Subject: Re: [PATCH v2 10/10] nfsd: Ignore rpcbind errors on nfsd startup
Thread-Topic: [PATCH v2 10/10] nfsd: Ignore rpcbind errors on nfsd startup
Thread-Index: AQHX9HoJf0UrhpbILEawWnDLCGoAp6w6H74AgAArPACAAT7dAIAALdSAgAAHjwA=
Date:   Mon, 20 Dec 2021 19:02:11 +0000
Message-ID: <753AE969-5C7E-4BA7-8CA4-003671710DAC@oracle.com>
References: <20211219013803.324724-1-trondmy@kernel.org>
 <20211219013803.324724-2-trondmy@kernel.org>
 <20211219013803.324724-3-trondmy@kernel.org>
 <20211219013803.324724-4-trondmy@kernel.org>
 <20211219013803.324724-5-trondmy@kernel.org>
 <20211219013803.324724-6-trondmy@kernel.org>
 <20211219013803.324724-7-trondmy@kernel.org>
 <20211219013803.324724-8-trondmy@kernel.org>
 <20211219013803.324724-9-trondmy@kernel.org>
 <20211219013803.324724-10-trondmy@kernel.org>
 <20211219013803.324724-11-trondmy@kernel.org>
 <831659F6-3005-459B-92ED-933BBCEE6FE9@oracle.com>
 <3167a9a815ac9c82700bd58d8c421de31eee8b91.camel@hammerspace.com>
 <316378A4-BCB1-4C8F-A16D-43F8F9DA8FBC@oracle.com>
 <9679c6f76f751c6c379bcfb889fd1dcba1671eac.camel@hammerspace.com>
In-Reply-To: <9679c6f76f751c6c379bcfb889fd1dcba1671eac.camel@hammerspace.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 13f834ea-c933-44c0-c010-08d9c3eb3a53
x-ms-traffictypediagnostic: CH0PR10MB5290:EE_
x-microsoft-antispam-prvs: <CH0PR10MB52907EE3C403327F58CB163D937B9@CH0PR10MB5290.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gJIb8x5czi9dDvxOqYaijmQ7A8vh4kP8M0QMbu0adks8bLsIUJUbKHc52H3M2/YPszdcDukejjZFQUJrXtXpUNnFvSOCKOEAcooC8LtNHZaozmQVGzLauE4c+bk8Q5HfZyBO6Lsi0QFADchN/5dHV0MvYzH0ESSa/0SbopQteOQ/r7KBEveW/N8u1WL3nfL4LWe9dgYemfXtgS4re7L28NMqFJmTmNR2OP03KxlDtHHIBge/SJVTmWujkvqq/UWP+uoPb5bXoREVgpcUPnAoHrj3odhmgwVf8ZpaEF5XFzaA5pR0ORgnhigSvxwqumIRfkAMX9sv14eeM/Psw1oM+o+pv59mWVBcdWri82UHCSzf2EQccaY2IDFC5y9mY8+9sFIaNc4W2e3C9y7IzQNNaj/fPqepHEuitRRE/FkQ65h+EW6tPtMnWGnvKHBEgypS0xlzrjmQPHOJo0QG+NFf0Lv9yhGlRkSViCP09TMSJ49beXcRe9u1+503mCEbdBf6XGijYBXnQtS2Tih8Gem9zB9H0HKk84cqtIomh0n+3pBaAGub7/p+OEWh/cwfnqagVPPsblGm+ZZ/cnC2zdncmyMZFrYSMn+dG6luZz1nt5mtJZzdSbKWnaub8aYQgPnK1ODnCsQU1Mpkeo9hO6PPMat8cIqflq0jtG6w8JU1KN/MyA0Q8gd+g2TZxZCpFAdLA/yNacY1DBt8H++cSKqYBx8kvQ52ikm6MDFHQ917nQtfeTC7NVOeoOAqy+mFZhw4
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB4858.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(66946007)(66476007)(66556008)(64756008)(66446008)(71200400001)(6916009)(122000001)(2616005)(38100700002)(76116006)(4326008)(36756003)(6486002)(6512007)(186003)(2906002)(5660300002)(33656002)(4001150100001)(83380400001)(38070700005)(54906003)(86362001)(316002)(8936002)(26005)(6506007)(53546011)(508600001)(8676002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Sfo/PTbWO2CCLQ78/a+kgXI9MkMEmOVkmEz8w3lQwwUKY4LuMC1G+HcoTX8B?=
 =?us-ascii?Q?VxtHVz89fTIlzaOlWruy1TEPqhNy4no83KmsamDkQ+PqlAZp/QS79E36Wjmf?=
 =?us-ascii?Q?qPW5O35DV4Tv8gRtkjqC127n0fVk1S4PEMvBXqns8xlCohDoJxIWUOq1Enrc?=
 =?us-ascii?Q?qfHQibO+9B8unrDFrYKCGVC6xmMtw4+NcLtLxtGxFt5yVMjqHN64CdCclwYW?=
 =?us-ascii?Q?ZyJ8RIQ1Pksir4UEpVqss37zKGfPeqfsoWa86lx1/cNNKdIdqYyZgT3QEaHn?=
 =?us-ascii?Q?q/JeDXIcXv4U/YCLj8juFHWGQLfuFCTMpd92m0mB5dUPKN/DkGSbf8NZJstS?=
 =?us-ascii?Q?Z1u1IDbq+l8lm51OQMfhn0TgAnNkAda6LY3xLiH5AwFmvOWPuh4bc6vcAwIo?=
 =?us-ascii?Q?dedcbqhwKi/L8tAAwqIpKDZkP1Ls+Po5ZWXw1jU2e6rIupb9HXeAjeTlztbS?=
 =?us-ascii?Q?ElJI5TpR30sJqwiYumDyWPFmvqF20ZNAo6i/Nfngni89JQKxDKte6fWfijkC?=
 =?us-ascii?Q?bHRLSG3cPrTx4gv7l7+hH7RHZvSvR/iiOx7Vb5v5sCZWnzh15xImpiPUBL+t?=
 =?us-ascii?Q?dGvxrsrnjA9CGmX2AOjp0qVln9z6qxkfxqp0mlLJN6SuggZOV1+jD85NKd6h?=
 =?us-ascii?Q?GCOAdhNOmVkj8RKlKnO8TOjfiGnC8JzRmgDVNE1lSGV2xHC6/7LRxNr7Lll6?=
 =?us-ascii?Q?fEcvshWKuHoQ/s5xI+rF5zUNNMz4BWlT9zk7Fb251Zfr9MHlezzATwTNQboK?=
 =?us-ascii?Q?DoN027k0uRJb6AFdpY3XSVgea8jZOr2+dWlMl+u/cUvUc6dRlCEkpselvjcS?=
 =?us-ascii?Q?1zeCY5NHahP2kz76u4eDvqYp2wo0ChsI5V0jVkG777uoMenf2WIC+IF5lFqk?=
 =?us-ascii?Q?S+TU1etaey0dhJMGnHqdO4FKszxRn8W9gl/+X6muHVWt7TD6jbnnc5dOTT4V?=
 =?us-ascii?Q?KG3ywO5lUtzyBLXZE5mz4Siso/QMVydQVpDbYhEBWyIz3JKy4gqXVH0+CZ2R?=
 =?us-ascii?Q?K/WZUiMHllrKBIWmPYVsv91GDLJI5MCZGCo34qGmgBotzNkDMDNRmkCL2opM?=
 =?us-ascii?Q?hdpqTevvKvrlVX/k6wUIT3ukqfdD/V+me1Mlz2IrL6k62wUqJfCquIyuk7fb?=
 =?us-ascii?Q?8/u8MQQ5vh6BHqtb53W2CpvatTXYnVOrj6ldZl4J/QdJkCsAUqBMAxg7CCPR?=
 =?us-ascii?Q?M7b9yvSCFmcYoKh6rVdlY5002fkTJpfRC42QtQknW0ta00pI8LYbKN97w0oo?=
 =?us-ascii?Q?S3WycW0xLaWUHkmo2B5Hi8g5C/JJMR6p0x3KpACvQKcaXvtb2vMiqp5g4wIG?=
 =?us-ascii?Q?l49gbgExTKp0HK1WwUg6TnaSOETBOk8szY6Xpn6j7xUV72vg+xvuNXm3izKG?=
 =?us-ascii?Q?JLDW2Q5tnEnc8IQCqj/MHP0QIzlUgJMIGvM25xD5ttWAd/NFDONM/TjUVIAw?=
 =?us-ascii?Q?8v1XS0Eex/XmW12rpkPC2fifC9uwckw66nIcTiXxKdMXaT44qmKgW7TfHhPL?=
 =?us-ascii?Q?d44GZqEftPTr5NJo3y4n7H7EGTMjQ+RGi9ZuUtYJfcQuE4a+7RcrWg3KvrG4?=
 =?us-ascii?Q?vZXVsq74ZvG4Ibyr+8VLAmn5hMpHwoRQ5DGrJ3wyol5h1aPz9mwhAJOxmCO3?=
 =?us-ascii?Q?HKh0YhcPzoYPuMrHmn+HKvg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <885839CC33BEEA4889120077332CAED8@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB4858.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13f834ea-c933-44c0-c010-08d9c3eb3a53
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Dec 2021 19:02:11.2309
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kG0b4yc08QvU3Ki8XQThYn2tznEcQ/G4hWrERFTp3DPs+fD44+IfRcYGJfxsvMNHte5ozRLgO3RVxG48+wq+rA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5290
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10204 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 suspectscore=0 phishscore=0 bulkscore=0 adultscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112200106
X-Proofpoint-ORIG-GUID: yiEa5I1dt68voLJKUcNNQhygjXV9rxGM
X-Proofpoint-GUID: yiEa5I1dt68voLJKUcNNQhygjXV9rxGM
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Dec 20, 2021, at 1:35 PM, Trond Myklebust <trondmy@hammerspace.com> wr=
ote:
>=20
> On Mon, 2021-12-20 at 15:51 +0000, Chuck Lever III wrote:
>>=20
>>=20
>>> On Dec 19, 2021, at 3:49 PM, Trond Myklebust
>>> <trondmy@hammerspace.com> wrote:
>>>=20
>>> On Sun, 2021-12-19 at 18:15 +0000, Chuck Lever III wrote:
>>>>=20
>>>>> On Dec 18, 2021, at 8:38 PM, trondmy@kernel.org wrote:
>>>>>=20
>>>>> From: Trond Myklebust <trond.myklebust@hammerspace.com>
>>>>>=20
>>>>> NFSv4 doesn't need rpcbind, so let's not refuse to start up
>>>>> just
>>>>> because
>>>>> the rpcbind registration failed.
>>>>=20
>>>> Commit 7e55b59b2f32 ("SUNRPC/NFSD: Support a new option for
>>>> ignoring
>>>> the result of svc_register") added vs_rpcb_optnl, which is
>>>> already
>>>> set for nfsd4_version4. Is that not adequate?
>>>>=20
>>>=20
>>> The other issue is that under certain circumstances, you may also
>>> want
>>> to run NFSv3 without rpcbind support. For instance, when you have a
>>> knfsd server instance running as a data server, there is typically
>>> no
>>> need to run rpcbind.
>>=20
>> So what you are saying is that you'd like this to be a run-time
>> setting
>> instead of a compile-time setting. Got it.
>>=20
>> Note that this patch adds a non-container-aware administrative API.
>> For
>> the same reasons I NAK'd 9/10, I'm going to NAK this one and ask that
>> you provide a version that is container-aware (ideally: not a module
>> parameter).
>>=20
>> The new implementation should remove vs_rpcb_optnl, as a clean up.
>>=20
>>=20
>=20
> This is not something that turns off the registration with rpcbind. It
> is something that turns off the decision to abort knfsd if that
> registration fails.

See below, that's just what vs_rpcb_optnl does. It it's true,
then the result of the rpcbind registration for that service
is ignored.

1039 int svc_generic_rpcbind_set(struct net *net,
1040                             const struct svc_program *progp,
1041                             u32 version, int family,
1042                             unsigned short proto,
1043                             unsigned short port)
1044 {
1045         const struct svc_version *vers =3D progp->pg_vers[version];
1046         int error;
1047=20
1048         if (vers =3D=3D NULL)
1049                 return 0;
1050=20
1051         if (vers->vs_hidden) {
1052                 trace_svc_noregister(progp->pg_name, version, proto,
1053                                      port, family, 0);
1054                 return 0;
1055         }
1056=20
1057         /*
1058          * Don't register a UDP port if we need congestion
1059          * control.
1060          */
1061         if (vers->vs_need_cong_ctrl && proto =3D=3D IPPROTO_UDP)
1062                 return 0;
1063=20
1064         error =3D svc_rpcbind_set_version(net, progp, version,
1065                                         family, proto, port);
1066=20
1067         return (vers->vs_rpcb_optnl) ? 0 : error;
1068 }
1069 EXPORT_SYMBOL_GPL(svc_generic_rpcbind_set);

And, it's already the case that vs_rpcb_optnl is true for our
NFSv4 server. So the issue is for NFSv3 only. It still looks
to me like the patch description for this patch, at the very
least, is not correct.


> That's not something that needs to be
> containerised: it's just common sense and really wants to be the
> default behaviour everywhere.

I'm not following this. I can imagine deployment cases where one
container might want to ensure rpcbind is running for NFSv3 while
another does not care. What am I missing?


> The only reason for the module parameter is to enable legacy behaviour.


--
Chuck Lever



