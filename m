Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E34B47B39B
	for <lists+linux-nfs@lfdr.de>; Mon, 20 Dec 2021 20:22:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240655AbhLTTWR (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 20 Dec 2021 14:22:17 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:50368 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233001AbhLTTWR (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 20 Dec 2021 14:22:17 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BKIh5VP030860;
        Mon, 20 Dec 2021 19:22:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=e4cm5QXWSdZ2dVOSnOvjqOLonaDzvzwikPpw/gK1330=;
 b=qhZ4fncg/z57l88O+gSLgmZzIeUYHNKXGu5CunSTUEZUU1cr/3akQQiIrog97nIF6n7R
 yxUzcyNUyW6SwAh5m00LONf+3V/nNz33oRmcB/NUusRCUIO2hjnUUZUyvxbbD6OKuL4U
 Alr/6GgqntXSqGIc0TGWJMJcZMl+ASMOvZOyA/Ft7aD4CtfnxqXFeYn3BwFt1EAcCLEN
 1lu85r07i0He0D3JVZdQYeADA0tDH42PNXOClmCjgRA78cd8q5/9EtPTn+xOPUvqcixN
 /wWSa2Et42W744Cy17mYyftQLUKTU0F+VSjX2Nqc6g+7xu6TNmUdYX/DdE8DFgYc9O3e FA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3d2qbqsg2d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Dec 2021 19:22:13 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1BKJGMKV020435;
        Mon, 20 Dec 2021 19:22:12 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam08lp2041.outbound.protection.outlook.com [104.47.73.41])
        by userp3020.oracle.com with ESMTP id 3d193m35gt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Dec 2021 19:22:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VOam58/PROO7ZbWLXYDDhAz8nfwFRLFcay1ZOkLEaS1Qtuj1qpvi0LOpRyQHGLhwyiXWvrIZnEn8nn79PqJQMHYYiS1CM+DFM7QM5J1WIIwIkTMY+TiHzs6cFRqRU+Ec9R96Yft6alER9L7dv67z1FJUDTJI3ZZu4SR/wudwiRbRU2dICOa8+LRdY0+iiixldm5B/SCpS9wtVGL0NxMwCpqdU4IYU2tag19KRA9u7L/UpLEEr8PftSPduXcuuStlr7cH8s9RQvmIzwHBPvAxi5TfsxRCY0YybaWB1xF9Bzdy+5ZbuAExgBJOEvYnz4GuRrKle1Fw6aygLDrIOcvRlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e4cm5QXWSdZ2dVOSnOvjqOLonaDzvzwikPpw/gK1330=;
 b=BLh0SYItPhR8ZZBGnhYoRoS2fszUh92fihauvHcl5TAhQSS0dtPdvQ5102ccGvblnf8HitOwuzpjNreLkyqscae+uOFHpBi8PQQgFxxo53qColDa2Xa06YcZa8NqsoPZe0QqLqIYlpRhhLXp/YQmOxWECLAqRTDanj4QQvqKQFs0R79gOnX71TyU7SsknJa8KmseMorZH8+K3I3PWwX8a+Q4dH5oUqKQykTUVj9lSB1dHYRD09wjsiOWtwpohOJnAhhEErUowptHoG1w6Vf5eCau4fKAZjQR6AxdJC1GLhS6jcbHVo0/dVrSeFiagQy5Nbb9n6o5seRHH3flZvxFag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e4cm5QXWSdZ2dVOSnOvjqOLonaDzvzwikPpw/gK1330=;
 b=jgGCwcpcMwy1NcxccJ5Sw2BzIu0Pd32GMb2DHJy70KstYIt1FneCU5oDlWOKuCRRnJFw0oky/8MZDoAHarbU0DYviP5i5UvNW9WfClmP5AtgRokpWnRygEaEC9VqSVlXCfoJpF1VjtwrTdBTSH3mX4kUSUHnRsecN/y73BkMXZo=
Received: from CH0PR10MB4858.namprd10.prod.outlook.com (2603:10b6:610:cb::17)
 by CH2PR10MB3910.namprd10.prod.outlook.com (2603:10b6:610:11::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.18; Mon, 20 Dec
 2021 19:22:09 +0000
Received: from CH0PR10MB4858.namprd10.prod.outlook.com
 ([fe80::241e:15fa:e7d8:dea7]) by CH0PR10MB4858.namprd10.prod.outlook.com
 ([fe80::241e:15fa:e7d8:dea7%6]) with mapi id 15.20.4801.020; Mon, 20 Dec 2021
 19:22:09 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Trond Myklebust <trondmy@hammerspace.com>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Bruce Fields <bfields@redhat.com>
Subject: Re: [PATCH v2 04/10] nfsd: Distinguish between required and optional
 NFSv3 post-op attributes
Thread-Topic: [PATCH v2 04/10] nfsd: Distinguish between required and optional
 NFSv3 post-op attributes
Thread-Index: AQHX9HoHis+nI73XsEy3XV75+2rrG6w6QAKAgAAQW4CAATyGAIAAK8mAgAAMIgA=
Date:   Mon, 20 Dec 2021 19:22:09 +0000
Message-ID: <E51BB96B-62DC-4E6E-B7F0-57CE69BFCD56@oracle.com>
References: <20211219013803.324724-1-trondmy@kernel.org>
 <20211219013803.324724-2-trondmy@kernel.org>
 <20211219013803.324724-3-trondmy@kernel.org>
 <20211219013803.324724-4-trondmy@kernel.org>
 <20211219013803.324724-5-trondmy@kernel.org>
 <B6B9027D-D7EB-4324-9C26-9FDADCCCEFCC@oracle.com>
 <6adbcc44f48cdb0a6a96ed488d5a1959c09e13cd.camel@hammerspace.com>
 <D5FE6A62-DFE6-4C03-A9A0-E9E8A598C294@oracle.com>
 <7c11149ddfe853e2096b1d968c25c3ad95da03d9.camel@hammerspace.com>
In-Reply-To: <7c11149ddfe853e2096b1d968c25c3ad95da03d9.camel@hammerspace.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b7552220-205f-4a7e-0c47-08d9c3ee04ad
x-ms-traffictypediagnostic: CH2PR10MB3910:EE_
x-microsoft-antispam-prvs: <CH2PR10MB3910B76016E26B53B7E00365937B9@CH2PR10MB3910.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0KLlzuECwS735On5zozmGPil+zPbwS2GQChHIXqQzvCrQU05AEBUahcdQpLAFtzenMvGZc84bmT30gmrImbMJRBuBUZ6j0wV+1/fTZjSB7AsjOulDS9KRCQGAMk9TWZUcCHA7eld9Vtd+lLkH4Tv46AFC1PnZifr/zbS2eaMLE9huThFtFxKKHKC/PPgz24D7YhVcwzVzjL56sRVzDvNa2tQ3tPmuDeQer2y36aW7VvxerkE3wLeVvb0ABklvKICyStE2I6PzgmVwvKQ815qm0ePhmmCSRvE2Sx6lJjnv7fFwhJjiK5WirFUurPWZdllRHL++H/36RcA85onHkGZ5OwjXCDQWpM0cZmOhM+I1nm8lF9Z/tKVzPXlgUKjuCtSTNkVZxExZfrrLlLRJ2EJxHZH3GncBEBGFaWBtQk8El6OApy1L/fJWKGskfjdnyNO+hqczFDdmemUgBH1Pz7lZQkMxXNHblFKCS4x0+ZQ1UmUpmSY76E8XCuGYtE1sWK8DmJ44b4PS6btHwnJx6kvd0hen6K7HR8KeHxO4WHRtvDQpg8osDUC6pEa9BS30QSKg4K+z4B+y8Np2t+EeMhyAayDQKB3e+90jQvXmm3Km0WpjzsRWfLprVRXHD0kMo1idftsKZBj/6MIA+szXKEhSF107vRiio9mc7jO2tHDhEa1TYNUH+vbxcE79yyu6vnMYMkv9LBV+Vl0uH/Db4bRr5Cpt4aNzn3fvfCa0Alq5El/bP4inXPlvKkj/EqyRCIa
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB4858.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(66446008)(38100700002)(122000001)(8676002)(36756003)(4001150100001)(26005)(186003)(33656002)(76116006)(66946007)(6916009)(66476007)(64756008)(53546011)(66556008)(508600001)(5660300002)(6512007)(54906003)(8936002)(6506007)(71200400001)(86362001)(2616005)(2906002)(38070700005)(6486002)(316002)(4326008)(83380400001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?HZukQ/KmUvLeslx9RXpS2v6LbW3CriCBInSStFV3XJMPGL4J22eoTIXr3EZo?=
 =?us-ascii?Q?JCxE4cQQuKeNjZKAGe6dKdVwE61p/Fsm7ryJbXHysVyQgOvZTFwASpWGEobU?=
 =?us-ascii?Q?EE7LbNExJ3XQqPOyxwYYjwPe7woV5wbczhl7yGBujaQt3t+u4CIfXkJ0r5OW?=
 =?us-ascii?Q?mmfHP+sRRP9cdJZqZWHYCSpsdD3AhzLLJV5hCnDtgReTyFEZMGtkaUp+zyc8?=
 =?us-ascii?Q?74zufkqTakhEA/wJGJY/G1mpuEeAgPhFbfXlauK6dbJvPor/MxtSV0p6h59q?=
 =?us-ascii?Q?n5U66D4uuY7JE/KKp0OCXjlUKJ3pL1syprNvEY/+U+rYsAMDuvemLtwqD4Nk?=
 =?us-ascii?Q?5EqTqsBuM9LAqPOddH+z9GWaLNTjIelMe7wk0WePTtP2zPUsPcJrbooEDZXn?=
 =?us-ascii?Q?ORVFI1fAjG6GLmnppmSX8GolQeCwIHgrlS/GrvtoIe6r+25/WPQQqu6FBExn?=
 =?us-ascii?Q?iJ3EXbn+X2fRtCGHdphO/1WOA4BdAqYy9XQJMEzbT4P/Ik+VuTw5SsvNPTAx?=
 =?us-ascii?Q?eEJViKlMw6FYNcJt06Yhjwx4V5Cv5S+ZAUP5466OIAzEZYgdxkKQE37HDZVO?=
 =?us-ascii?Q?543Z+RVCLCg4pgWY/Ri6MgYvb5kiHSpcqw9FzOFv/wAzjJ9K8LXrb/zB/SN9?=
 =?us-ascii?Q?kSDWE7AHxvFx3U1aJmhym9bDGC0ax6Kw7wBZQiRMBnCjWw5FbM+Wk5YfrChz?=
 =?us-ascii?Q?CvC7vsr4KUAKmmmIrc+keMKj0MB03y1TSd+4j07bJg++Tcnl1fEfGIabs1hB?=
 =?us-ascii?Q?8lOkozfj2FbpBbKEFwtuDcpfypq9XCUJ8MFFtCOtuIyd0iHmN1aCSYJztP7C?=
 =?us-ascii?Q?lXoIMK7Jt7+3E7t0ZylnSfzVoEViBxBK45C0xWCbrTq8Ng8h7lXun1T5kLKY?=
 =?us-ascii?Q?FgwlAOwJjjR9S6OPjOfTaWOQxC7hLOKog0qfdeAH1euU5bX1d0nLuIXNF5wu?=
 =?us-ascii?Q?h2qnzn+4/yyP/uPNr33kDmif/Y/l5JkBSG05yRcezQSZIibR76lK8GyjVZs0?=
 =?us-ascii?Q?f9E25RqQB0MNP6VLiXCuXx2ePdmj2m6SR9IoR/ssVelaGtMsVW+BGt/EQ+3U?=
 =?us-ascii?Q?PccPBr8DOszGke81lZxjaADb4S22BEYz2rm+uoEcRCbO6rXehWGWjAfdpxQT?=
 =?us-ascii?Q?meUGYvWtj2nplRRcJOUleLJYWGQVBvmGfPIBYXIG2Q/D/zU1CdeGCgR2PIC0?=
 =?us-ascii?Q?FTbRbWej8xkSlWiwMsNxIa9DZJHj0/hnjgwgBf/DLhKqQ7Q0GVTVOPIsjL6a?=
 =?us-ascii?Q?wQvCw4EusnV0S2FHI8Pivn+WvMi/kkanQ28mi87XF5ZoESEBg10//243oTgX?=
 =?us-ascii?Q?PD98Nh10VYqIlmW1jabYw7h0gt0v8vLQvnMHD6UiDURknZEM7d1pDiUcSXHV?=
 =?us-ascii?Q?ouz2lrPvT9HtvvZxhBRWkwDB3Mgopo19YplMBE2W53ygJtyQlTR0nvkXJnuJ?=
 =?us-ascii?Q?WE4+djRtrg5ozPre/fYuiCJFxzvqfr9SfIJuctxc3v9hgIDV0meMnQ5XqAdM?=
 =?us-ascii?Q?vJaIosmM3O7SS3h7f0LpXFpRoPkRsnK+QzpH2rye35Ix4ibfRHWQSOpRH6Fn?=
 =?us-ascii?Q?Zaeqy2NxNQH6PHjTkS2mdS7onpB7Gob4+2NoR7sJF520N8bcFf5LJ2ocTNi3?=
 =?us-ascii?Q?NEkKy24IDuykZ22PE7DtN2I=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B7EFEFDE874F874B835A13CEAA258183@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB4858.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7552220-205f-4a7e-0c47-08d9c3ee04ad
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Dec 2021 19:22:09.6312
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NrrkOY8YxR7HVoenP2IFxobQhtzzs4idCVW343GlDTsPvY4qUBK4KUCDCJeH+avMkgJVPXF2qDv3V3+K2Nk+6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB3910
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10204 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 suspectscore=0 phishscore=0 bulkscore=0 adultscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112200108
X-Proofpoint-ORIG-GUID: qDS247KvveHLRXeEhL_dygrOq4X4iza0
X-Proofpoint-GUID: qDS247KvveHLRXeEhL_dygrOq4X4iza0
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Dec 20, 2021, at 1:38 PM, Trond Myklebust <trondmy@hammerspace.com> wr=
ote:
>=20
> On Mon, 2021-12-20 at 16:02 +0000, Chuck Lever III wrote:
>>=20
>>=20
>>> On Dec 19, 2021, at 4:09 PM, Trond Myklebust
>>> <trondmy@hammerspace.com> wrote:
>>>=20
>>> On Sun, 2021-12-19 at 20:10 +0000, Chuck Lever III wrote:
>>>>=20
>>>>=20
>>>>> On Dec 18, 2021, at 8:37 PM, trondmy@kernel.org wrote:
>>>>>=20
>>>>> From: Trond Myklebust <trond.myklebust@primarydata.com>
>>>>>=20
>>>>> The fhp->fh_no_wcc flag is automatically set in
>>>>> nfsd_set_fh_dentry()
>>>>> when the EXPORT_OP_NOWCC flag is set. In
>>>>> svcxdr_encode_post_op_attr(),
>>>>> this then causes nfsd to skip returning the post-op attributes.
>>>>>=20
>>>>> The problem is that some of these post-op attributes are not
>>>>> really
>>>>> optional. In particular, we do want LOOKUP to always return
>>>>> post-op
>>>>> attributes for the file that is being looked up.
>>>>>=20
>>>>> The solution is therefore to explicitly label the attributes
>>>>> that
>>>>> we can
>>>>> safely opt out from, and only apply the 'fhp->fh_no_wcc' test
>>>>> in
>>>>> that
>>>>> case.
>>>>>=20
>>>>> Signed-off-by: Trond Myklebust
>>>>> <trond.myklebust@primarydata.com>
>>>>> Signed-off-by: Lance Shelton <lance.shelton@hammerspace.com>
>>>>> Signed-off-by: Trond Myklebust
>>>>> <trond.myklebust@hammerspace.com>
>>>>> ---
>>>>> fs/nfsd/nfs3xdr.c | 77 +++++++++++++++++++++++++++++++---------
>>>>> ----
>>>>> ---
>>>>> 1 file changed, 51 insertions(+), 26 deletions(-)
>>>>>=20
>>>>> diff --git a/fs/nfsd/nfs3xdr.c b/fs/nfsd/nfs3xdr.c
>>>>> index c3ac1b6aa3aa..6adfc40722fa 100644
>>>>> --- a/fs/nfsd/nfs3xdr.c
>>>>> +++ b/fs/nfsd/nfs3xdr.c
>>>>> @@ -415,19 +415,9 @@ svcxdr_encode_pre_op_attr(struct
>>>>> xdr_stream
>>>>> *xdr, const struct svc_fh *fhp)
>>>>>         return svcxdr_encode_wcc_attr(xdr, fhp);
>>>>> }
>>>>>=20
>>>>> -/**
>>>>> - * svcxdr_encode_post_op_attr - Encode NFSv3 post-op
>>>>> attributes
>>>>> - * @rqstp: Context of a completed RPC transaction
>>>>> - * @xdr: XDR stream
>>>>> - * @fhp: File handle to encode
>>>>> - *
>>>>> - * Return values:
>>>>> - *   %false: Send buffer space was exhausted
>>>>> - *   %true: Success
>>>>> - */
>>>>> -bool
>>>>> -svcxdr_encode_post_op_attr(struct svc_rqst *rqstp, struct
>>>>> xdr_stream *xdr,
>>>>> -                          const struct svc_fh *fhp)
>>>>> +static bool
>>>>> +__svcxdr_encode_post_op_attr(struct svc_rqst *rqstp, struct
>>>>> xdr_stream *xdr,
>>>>> +                            const struct svc_fh *fhp, bool
>>>>> force)
>>>>> {
>>>>>         struct dentry *dentry =3D fhp->fh_dentry;
>>>>>         struct kstat stat;
>>>>> @@ -437,7 +427,7 @@ svcxdr_encode_post_op_attr(struct svc_rqst
>>>>> *rqstp, struct xdr_stream *xdr,
>>>>>          * stale file handle. In this case, no attributes are
>>>>>          * returned.
>>>>>          */
>>>>> -       if (fhp->fh_no_wcc || !dentry ||
>>>>> !d_really_is_positive(dentry))
>>>>> +       if (!force || !dentry || !d_really_is_positive(dentry))
>>>>>                 goto no_post_op_attrs;
>>>>>         if (fh_getattr(fhp, &stat) !=3D nfs_ok)
>>>>>                 goto no_post_op_attrs;
>>>>> @@ -454,6 +444,31 @@ svcxdr_encode_post_op_attr(struct svc_rqst
>>>>> *rqstp, struct xdr_stream *xdr,
>>>>>         return xdr_stream_encode_item_absent(xdr) > 0;
>>>>> }
>>>>>=20
>>>>> +/**
>>>>> + * svcxdr_encode_post_op_attr - Encode NFSv3 post-op
>>>>> attributes
>>>>> + * @rqstp: Context of a completed RPC transaction
>>>>> + * @xdr: XDR stream
>>>>> + * @fhp: File handle to encode
>>>>> + *
>>>>> + * Return values:
>>>>> + *   %false: Send buffer space was exhausted
>>>>> + *   %true: Success
>>>>> + */
>>>>> +bool
>>>>> +svcxdr_encode_post_op_attr(struct svc_rqst *rqstp, struct
>>>>> xdr_stream *xdr,
>>>>> +                          const struct svc_fh *fhp)
>>>>> +{
>>>>> +       return __svcxdr_encode_post_op_attr(rqstp, xdr, fhp,
>>>>> true);
>>>>> +}
>>>>> +
>>>>> +static bool
>>>>> +svcxdr_encode_post_op_attr_opportunistic(struct svc_rqst
>>>>> *rqstp,
>>>>> +                                        struct xdr_stream
>>>>> *xdr,
>>>>> +                                        const struct svc_fh
>>>>> *fhp)
>>>>> +{
>>>>> +       return __svcxdr_encode_post_op_attr(rqstp, xdr, fhp,
>>>>> !fhp-
>>>>>> fh_no_wcc);
>>>>> +}
>>>>> +
>>>>=20
>>>> Thanks for splitting this out: the "why" is much clearer.
>>>>=20
>>>> Wouldn't it be simpler to explicitly set fh_no_wcc to false
>>>> in each of the cases where you want to ensure the server
>>>> emits WCC? And perhaps that should be done in nfs3proc.c
>>>> instead of in nfs3xdr.c.
>>>>=20
>>>=20
>>> It can't be done in nfs3proc.c, and toggling the value of fh_no_wcc
>>> is
>>> a lot more cumbersome than this approach.
>>>=20
>>> The current code is broken for NFSv3 exports because it is unable
>>> to
>>> distinguish between what is and isn't mandatory to return for in
>>> the
>>> same NFS operation. That's the problem this patch fixes.
>>=20
>> That suggests that a Fixes: tag is appropriate. Can you recommend
>> one?
>>=20
>>=20
>>> LOOKUP has to return the attributes for the object being looked up
>>> in
>>> order to be useful. If the attributes are not up to date then we
>>> should
>>> ask the NFS client that is being re-exported to go to the server to
>>> revalidate its attributes.
>>> The same is not true of the directory post-op attributes. LOOKUP
>>> does
>>> not even change the contents of the directory, and so while it is
>>> beneficial to have the NFS client return those attributes if they
>>> are
>>> up to date, forcing it to go to the server to retrieve them is less
>>> than optimal for system performance.
>>=20
>> I get all that, but I don't see how this is cumbersome at all:
>>=20
>>  82 static __be32
>>  83 nfsd3_proc_lookup(struct svc_rqst *rqstp)
>>  84 {
>> ...
>>  96         resp->status =3D nfsd_lookup(rqstp, &resp->dirfh,
>>  97                                    argp->name, argp->len,
>>  98                                    &resp->fh);
>>     +       resp->fh.fh_no_wcc =3D false;
>>  99         return rpc_success;
>> 100 }
>>=20
>> Then in 5/10, pass !fhp->fh_no_wcc to nfsd_getattr().
>=20
> That's not equivalent. That will force the NFS client to retrieve the
> lookup object attributes AND the directory attributes.

Does it? Your patch does this:

 418 static bool
 419 __svcxdr_encode_post_op_attr(struct svc_rqst *rqstp, struct xdr_stream=
 *xdr,
 420                              const struct svc_fh *fhp, bool force)
 421 {
...
 436         if (nfsd_getattr(&path, &stat, force) !=3D nfs_ok)
 437                 goto no_post_op_attrs;

...

 461 bool
 462 svcxdr_encode_post_op_attr(struct svc_rqst *rqstp, struct xdr_stream *=
xdr,
 463                            const struct svc_fh *fhp)
 464 {
 465         return __svcxdr_encode_post_op_attr(rqstp, xdr, fhp, true);
 466 }
 467=20
 468 static bool
 469 svcxdr_encode_post_op_attr_opportunistic(struct svc_rqst *rqstp,
 470                                          struct xdr_stream *xdr,
 471                                          const struct svc_fh *fhp)
 472 {
 473         return __svcxdr_encode_post_op_attr(rqstp, xdr, fhp, !fhp->fh_=
no_wcc);
 474 }

...

 863 bool
 864 nfs3svc_encode_lookupres(struct svc_rqst *rqstp, struct xdr_stream *xd=
r)
 865 {
...
 871         case nfs_ok:
 872                 if (!svcxdr_encode_nfs_fh3(xdr, &resp->fh))
 873                         return false;
 874                 if (!svcxdr_encode_post_op_attr(rqstp, xdr, &resp->fh)=
)
 875                         return false;
 876                 if (!svcxdr_encode_post_op_attr_opportunistic(rqstp, x=
dr,
 877                                                               &resp->d=
irfh))
 878                         return false;
 879                 break;

So for resp->fh, this is equivalent to resp->fh.fh_no_wcc =3D false
and for resp->dirfh, this is equivalent to passing in
resp->dirfh.fh_no_wcc unchanged.

I don't see how that's different from what my suggestion does --
it forces WCC for the looked-up object, and leaves WCC for the
parent directory optional.


--
Chuck Lever



