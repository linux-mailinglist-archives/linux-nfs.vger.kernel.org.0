Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E555434F8E
	for <lists+linux-nfs@lfdr.de>; Wed, 20 Oct 2021 18:00:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231143AbhJTQCu (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 20 Oct 2021 12:02:50 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:34486 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230372AbhJTQCt (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 20 Oct 2021 12:02:49 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19KExa2k000775;
        Wed, 20 Oct 2021 16:00:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=/h+CKcOtXl7Q/sjUdnZijf7e/DPxWPnKPmqAjjXrA4U=;
 b=RWOOOubn0KBLOYDm85V5uzJCxXTjB7ZjKR5zQeE2qWsBgmgyuitgoHVjvX19YJgOLi2b
 SF98RskBo91757y+VJk20cn0KEuLZ3z8TLVRgwFoKKqen9PPST7PjUTfMu3iw5ZZivi+
 eIEQS+NPYoB+09URjR72hXOO0HePxa3i3dvfoxrJDMzXBtzagH2SE3eK5a2wv0OWNZCL
 xWWX3simaADrClij5tAmsKfoZCiGD8qm1lSHBfPY0C0QsClzSzGeXec5OxL9o7CkOP54
 AURA8N3dIfpzdfcyYnVJVLN6ggPvkQkuLrnnmbi9G4t+MQhpMxPLC8Ujyeo9uTNPP+CR 3A== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3btkw4rydm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Oct 2021 16:00:31 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 19KFjZvS167785;
        Wed, 20 Oct 2021 16:00:30 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2102.outbound.protection.outlook.com [104.47.58.102])
        by userp3020.oracle.com with ESMTP id 3br8gucpuw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Oct 2021 16:00:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XcI+waSuJJqBjHz097sh4vYiSXF5/eOn5cPs8Omw+NwX0W66J3CifB3dP3mG0ur624yiUFjXOEpsM811mOxsRv4I/VzwFGaB2gMBIM1d9RxNO2ArbdZHfvqgwaUu2pCYhle/rkMBJDRifoWflugD8es04vSpCdpUIzyeGCEreDZDnaOwy54uyiTXLU7SJZQezCBxTdmX5yCRDPqIJGF+Ok4UhK6PlhlV8941ejqdC51xE5VV0dOmE0CjttF5B9Uw5mdkhaKPfdQUudXc75i+I3QEBC44hlylzc+xXslFcAD74jWy3dX7yL6Ffd4a5izICNo+bxlRXiglsjm37T3czA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/h+CKcOtXl7Q/sjUdnZijf7e/DPxWPnKPmqAjjXrA4U=;
 b=jNbbdF8W8vVzN24fJvIUX1/+raOKd6xGVUfnvfLJNN7LWwPaE6EIs8FFWZSiNMNaLAljnnK7eCYkiZEdNvVRu3BnOK0Ec9CvQvW0gq9FCuH3AFJ4OZyGXq9ayuC5h7pcSV8gTyex0RzFHlNgNLKK4DScXdL3NR3pQTgTCIfHuqRwwtaB+mauZygeLLJ55Yz4ZbL/ecHrh2oCTTd0MK55B1XW7lJxmYg+LklIdl98KK9QvyguflzBnvAXpB/cZxwLYgXwksXVoTtqYVnifv7W6Shxl4Kp+iM15jSPD8qNddKH+m7muMFioUPEGuiv5erjYHX6NDoIiEgICkcwwlXFvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/h+CKcOtXl7Q/sjUdnZijf7e/DPxWPnKPmqAjjXrA4U=;
 b=CZMSxzubCO/3mgymkYgrkMSrhoayIc9dW6kMrgMo4CEHIkvbE2N14FK1WtQUsZsJk5WKlYASIuW2OIlX7qGieNPzzO885GcT0UvfT2pFD5OQuYFS+tf4E2y7OddczlehpfjG0iemEGLmE5ffAvuuPJ3mK+u/6RmKudU3v5waqVk=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by SJ0PR10MB4687.namprd10.prod.outlook.com (2603:10b6:a03:2d8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.18; Wed, 20 Oct
 2021 16:00:28 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::f4fe:5b4:6bd9:4c5b]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::f4fe:5b4:6bd9:4c5b%6]) with mapi id 15.20.4608.019; Wed, 20 Oct 2021
 16:00:28 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Bruce Fields <bfields@fieldses.org>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Dai Ngo <dai.ngo@oracle.com>,
        Olga Kornievskaia <olga.kornievskaia@gmail.com>,
        Steve Dickson <steved@redhat.com>
Subject: Re: server-to-server copy by default
Thread-Topic: server-to-server copy by default
Thread-Index: AQHXxcrDI0R5Oq8J10KODCEElXm6xqvcC5sA
Date:   Wed, 20 Oct 2021 16:00:28 +0000
Message-ID: <18E32DF5-3F1D-4C23-8C2F-A7963103CF8C@oracle.com>
References: <20211020155421.GC597@fieldses.org>
In-Reply-To: <20211020155421.GC597@fieldses.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
authentication-results: fieldses.org; dkim=none (message not signed)
 header.d=none;fieldses.org; dmarc=none action=none header.from=oracle.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ca62c0c8-5ac0-4c35-af93-08d993e2bc4d
x-ms-traffictypediagnostic: SJ0PR10MB4687:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SJ0PR10MB468728AB4914A64412FB983593BE9@SJ0PR10MB4687.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kcPzIa+kzyV0GWUscnq141oUtS9vNsR33occ1p5dvDHi7VtZjmctvlCyn89EE/D5bUx/w3ivllz3ggt0ScLY+r8X83itlpWvsUR+Nnp+OBMWViJvZcaU1uExpD3l7gb1hyV0Sw3Q0KUpe9Limor61x12D726ZFDmc/HJtHZWVkoFssnYZYvG5uU2VfOStywmo0XfcGlO9NVtbXxNOFIkKeAFettXLseQq3c4CzC30q+rDU0+3Rte+4TM9U54eG3SQD5kPZes+fkI8c5bokLxFw9Dig+cMyD31wJIqm8Qz0uhtWNnHNYSzzhsxTXqCb3AhtWL7PEroMcM4QAVQ0nTuTF9DfwaY9HSKCyqpxYhl8QXC7aazNmNzfEstKVj1supyu733JNhqbb9dXnmdYkqxITmN/MVKaSh95JTfwwztpzk9/mzEq11eKSpgKDSY7UyGi6c3ozE41Xyali7i8A7E0tEbNDqGdOAXFWt00uy9mEFWTFSuCfpHZl4HBznSaOhfLyCoy6sg0fyeSs+vVtC5n2z0NX47rV//wv22immwlW9jAEtdjq4rCpVvGJA01fqXAv5wHClgwMPS6L4R0NqJLzPXhYJdw/V41Pqh5TW8RwOM6g7yo0oso4VdOITwekrkKn0b8SsshauJSyLlTbyJMOoUha+KqtPPALOighS+3V5hr3wXNXUtdSPaU5WaJ9jyMw2ii1RtMJkxzJXp6+Tvid5rIJmmfNna9xbgAfHmUTZQCOyt4VT2OftDfnrz2QG
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6486002)(508600001)(2616005)(8676002)(38070700005)(53546011)(6506007)(26005)(33656002)(4326008)(38100700002)(6916009)(186003)(122000001)(2906002)(36756003)(91956017)(76116006)(66476007)(66556008)(66946007)(5660300002)(71200400001)(64756008)(54906003)(86362001)(83380400001)(6512007)(8936002)(66446008)(316002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Kjuz80g66Sa3C4wdbLxR+yBbyZazb9Sk4VJs4L3WRwcge+ZhUUJW/xYpKyKr?=
 =?us-ascii?Q?S2WJNAbg/alMTn9ClanGyY9mj1gVfhCEZ0UrlBSRdfGbxLcUqg6xrsDVePPV?=
 =?us-ascii?Q?a5onkc3Zpc9coy4RWaU0qIF5S6jLykJ+f0EjDsPNVUfLZ+5KokK2c87j4nps?=
 =?us-ascii?Q?vOOGhGxwyuQ6WU7StD48dmLomXB445BIH3yZTvvb2hQLrBLoUh7PmYaksCJP?=
 =?us-ascii?Q?NdcW1stvDTIHjqrITxa1sjNZDLZZtoj9LzKqZ7I2taM4m85NocrIgY6Amy1f?=
 =?us-ascii?Q?axftumrD2QyfE04iz3tAJ6MYH5ytTnFBVAqT1L5nE8G2hocdOuuMCvtBsMyp?=
 =?us-ascii?Q?boiwQ4iGp+HdeeTVNhJR+6uf9LJAbfm1Ur6x13+Kx9WfVw3JWLsK1UoWfyYg?=
 =?us-ascii?Q?LLIJ36BE4UH83YS0ZSR5PWaHMNuJKp/jQxF4FCXmNElSQoQ4G0Wt3PfUYKz5?=
 =?us-ascii?Q?iS/f8FDg1gkrBLSKPkXWNMXq8k8MnFiQag3JhgT3YYhGXCDSoM84oyemWgtm?=
 =?us-ascii?Q?5muJmh76LIKHKJBDZR4njW2im1J23sWIpjIFHI4wKbTURKRu0J17fk2APJpv?=
 =?us-ascii?Q?M/82czfxMZm/x9b/GgCmREOrOSHsWWiR2E17ftqDnl4ZMWSe7Q4t+1cWDVVn?=
 =?us-ascii?Q?n9UV04aaOZqtgL0B67Vgsq0Wlp6OPFNNK53G4ZQMuWUvOl9vPk8IiGiGN3+r?=
 =?us-ascii?Q?9fgUtEzO0VPvqW/zdONhpiNjR40jindfn+YKYq/KQ4nrvc21VZ7OPDyTlk8d?=
 =?us-ascii?Q?N+mYh+vOY1yPEAKXDvmJvC9akI51ImjOTI+jkeCWLE5Qx4dF10qb4mD114rJ?=
 =?us-ascii?Q?rIKJpd6HszblivXvkwshR1cRE8eLqWKxqZJeLHB3OcrwIa4jR8aN5NU75tXc?=
 =?us-ascii?Q?jBQnC/t6w2fxQ+i+N+dwLT4MzIy0ad0GR4X8USc7zYYITJWR4NpI9Koi1yDN?=
 =?us-ascii?Q?UVO6pbmfYAfQYsOgwDn6xN+p73PqfJ7WsYqOmIoJDzQvm+l1anH7kax4MhRs?=
 =?us-ascii?Q?qpTCsVrXDuu7mvJ16U9PTp40kRcbvqkqd3KPxUY7ugqFwy8XDpICYdbkLRGz?=
 =?us-ascii?Q?+p4uUM0cqIsnPNJFyjRJ8l2QdBF8gVEG1O+NutltK9CxbD+4ZNz+6QI5nrwk?=
 =?us-ascii?Q?tWC6u+95QFYCb/+F0ZJHtYd8qAzj9dYdYTVUd8TCIhH/MPlK/6qPRcCtSkNd?=
 =?us-ascii?Q?PU9d9eUN7JHbJHMadAk9dpwbHC3zk3v4h3VyoYdb9/nibyCvl/StnYJeTwhy?=
 =?us-ascii?Q?UILee51rUgRNe+PNXdG5hDZFq1Iu+0C5oDBSeZrtSXr1t7JzpcYb31YxIs3v?=
 =?us-ascii?Q?6oTMNtabTYlSoQJugcgjDfW8?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <FD34C1DB79519945B761EEBECF189AA3@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca62c0c8-5ac0-4c35-af93-08d993e2bc4d
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Oct 2021 16:00:28.0068
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: G3mo6dzZdM3RoGVmjO6LI9F3tAjPS8w3X6YI7hMAhExTlnMZFgNxjHbm64sa/DExN3Jwd4UBuIHlCbmZ5gYjFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4687
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10143 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 adultscore=0
 spamscore=0 phishscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2110200090
X-Proofpoint-GUID: BjeIp8eArfwE-rptW67myr2T_6_6Ptn0
X-Proofpoint-ORIG-GUID: BjeIp8eArfwE-rptW67myr2T_6_6Ptn0
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Oct 20, 2021, at 11:54 AM, J. Bruce Fields <bfields@fieldses.org> wrot=
e:
>=20
> knfsd has supported server-to-server copy for a couple years (since
> 5.5).  You have set a module parameter to enable it.  I'm getting asked
> when we could turn that parameter on by default.
>=20
> I've got a couple vague criteria: one just general maturity, the other a
> security question:
>=20
> 1. General maturity: the only reports I recall seeing are from testers.
> Is anyone using this?  Does it work for them?  Do they find a benefit?
> Maybe we could turn it on by default in one distro (Fedora?) and promote
> it a little and see what that turns up?

I like the idea of enabling it in one of the technology
preview distributions.

But wrt the maturity question, is the work finished? Or,
perhaps a better question is do we have a minimum viable
product here that can be enabled, or is more work needed
to meet even that bar?

One thing that I recall is missing is support for Kerberos
in the server-to-server copy operation. Is that in plan,
or deemed unimportant?


> 2. Security question: with server-to-server copy enabled, you can send
> the server a COPY call with any random address, and the server will
> mount that address, open a file, and read from it.  Is that safe?
>=20
> Normally we only mount servers that were chosen by root.  Here we'll
> mount any random server that some client told us to.  What's the worst
> that random server can do?  Do we trust our xdr decoding?  Can it DOS us
> by throwing the client's state recovery code into some loop with weird
> error returns?  Etc.

A basic question is what is in distribution QE test suites
that could exercise this feature? Should upstream be tasked
with providing any missing pieces (as part of, say, pynfs,
or nfstests)?


> Maybe it's fine.  I'm OK with some level of risk.  I just want to make
> sure somebody's thought this through.
>=20
> There's also interest in allowing unprivileged NFS mounts, but I don't
> think we've turned that on yet, partly for similar reasons.  This is a
> subset of that problem.
>=20
> --b.

--
Chuck Lever



