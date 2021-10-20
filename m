Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CC02435206
	for <lists+linux-nfs@lfdr.de>; Wed, 20 Oct 2021 19:51:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230288AbhJTRx3 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 20 Oct 2021 13:53:29 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:14818 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230073AbhJTRx2 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 20 Oct 2021 13:53:28 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19KHNd2s005531;
        Wed, 20 Oct 2021 17:51:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=tuyRN58UNsO6i4W+zssX+IKBPpx9FIih9ne47P2ON3c=;
 b=nqxbITB2X4uBcPR0m0c7jwUpPTtWiviFwY0AjqtRh7NzzLPSs8nYCNleUbpLvGzQQz1K
 Stj3fPO25IC3WQj+cyJMZheSwsIp9QHPp42XnD74uKhduq6PuhBlKmk7gAGK0xdM+AsJ
 YACEkSB4AF9WD99lI8I6lt5oiR8hUS8qMsJUYZIomBqs/GZNdMSgGgQxEpOk1AbzTJxC
 C87vgFrkh/oov1IfxKaFOin3VSvv95oZ43+WYtLxfFMN0Fs92f0ti/+jnhQrBhuuNjgo
 uxWLi/4vJwkZLTm/LKkr853HbxBohZp07LcODe61LXydXph52OGYp1mxPp35H4uN1JFV yg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bsrucavv8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Oct 2021 17:51:10 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 19KHjbRu170609;
        Wed, 20 Oct 2021 17:51:09 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam07lp2045.outbound.protection.outlook.com [104.47.56.45])
        by userp3030.oracle.com with ESMTP id 3bqkv0evbh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Oct 2021 17:51:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PI0RFchfnI5onTpSJZYn64kzT6EL8afHpEiwTtWvvRShFRj65DZFbZ/TEs575OeCuza4gXOp4u+oXbqf1p0FS20OYcgcJ7yu4dyjgDd3O6DIsxgOYuc7eNCZDWFVvVF97IDDL5pq8Z0odtggDSzaPYqL1RciH5p3J6A6jtX4wNX4IxWT44WqcUBlfiMSGP8vfoQArpABiL+mLWfdWbjQZpt/3kgVCTXdhQrEgDR+d5QcJPRn35n44lO7YWH45oAinnxoSqI5EqiU75yu3wVb+lW/v6tBn9aGmDFpw99Vp9Pq6foxoTbf6KCfJ/K+uLhbJDkLWJb5yl4MximtObnYMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tuyRN58UNsO6i4W+zssX+IKBPpx9FIih9ne47P2ON3c=;
 b=mTzPn3z+kkMD1kHW+8rHQoQ9KVLImFvge9PXGkPMwGykMD3TtWL8gfUSOZPyZ4zx1WI7FJjkH3hjn+yLhvqbVV33W1UhQwV29GmtSQAkEoHBBxcl5hDRjBzn4qo6j4TJe03IDTUFJsx+sZtitbD2B6XZIC0IK/qKfx2liIxepcR8L3UqCFSLYnYouCi2DbqPoqTCEOMNbSvDoCxoQwhcgV2yvUt5iKjwCoHk89C7nv+cv2/CG2T1J+m7mjwaRj9wN7j26GPsK6dxB2/qPUpTZq5lGhdrg7WlPj3h9+YB+PZGM/2EozS6busyT/c8RKPo0FO8DHc/qWMpH5SwL5SE0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tuyRN58UNsO6i4W+zssX+IKBPpx9FIih9ne47P2ON3c=;
 b=HYq9kTjmYnn+g8yM+cJ9EDvHSqOPE7DwF+ne6/KU++DOVrABrrWYU1O+aUqH4n7OlNT79pMawUAhLq8dqLHGbW8E4zyBY5udbpoh3kSYAdWpAaoL06CknCmEn3EmcWu1GRSRU5VjHl5hcEFY1AjwYvzGlN+Wy33h19awXm4jILI=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by BYAPR10MB2758.namprd10.prod.outlook.com (2603:10b6:a02:ba::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.18; Wed, 20 Oct
 2021 17:51:06 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::f4fe:5b4:6bd9:4c5b]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::f4fe:5b4:6bd9:4c5b%6]) with mapi id 15.20.4608.019; Wed, 20 Oct 2021
 17:51:06 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Steve Dickson <steved@redhat.com>
CC:     Bruce Fields <bfields@fieldses.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Dai Ngo <dai.ngo@oracle.com>,
        Olga Kornievskaia <olga.kornievskaia@gmail.com>
Subject: Re: server-to-server copy by default
Thread-Topic: server-to-server copy by default
Thread-Index: AQHXxcrDI0R5Oq8J10KODCEElXm6xqvcC5sAgAAXlwCAAAdTgA==
Date:   Wed, 20 Oct 2021 17:51:06 +0000
Message-ID: <26BB6AB0-DD56-4E3A-B9E1-2AB38FE1EB4D@oracle.com>
References: <20211020155421.GC597@fieldses.org>
 <18E32DF5-3F1D-4C23-8C2F-A7963103CF8C@oracle.com>
 <e2b1210d-5b06-72bb-59c5-6b8b712fd2ec@redhat.com>
In-Reply-To: <e2b1210d-5b06-72bb-59c5-6b8b712fd2ec@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=oracle.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9f50b3a5-06d4-44c2-0e70-08d993f23138
x-ms-traffictypediagnostic: BYAPR10MB2758:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR10MB2758BAAD945C2C5945B6F98893BE9@BYAPR10MB2758.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SCNk7dKuq4/SSZCpl4Klj15ixLsNFklRNzRrVzsU9EJR41vKGj3Ti4zyZTNWhvCIREreFCP+z2GBIGb5DRZ2sE506sJPQpry2WGeQD6bHkRdPgQCqWqh3n5yhM3enJa4X7OlRBC8qOfHDl4r0KqNfImqHRkl1rYl6+0CoBnzuYKW4u1qahrdmLW7BILXpnt/1QZv1m4U5tKnpedjZZghEqpopbPtZJYJMy8GAhehCro3ka0bJGY6p7soCUFMB79RB1U9zsUq1Eo+lEH1UY8ol0bw2Y7wYJ1+5+5ba6qJMB1i5VPKp9TPwkW/LN/2K/tx6nn4A5rgPbNGzMjQiNNnIs59PyRksQx1PzRq3lBytWxfH5y8mcGwopGOGhtk/MIvqN2VAMx2LBgcbNG3TIPNUfYBbLCr30qsutvc4agyN0PjU6ubAzYGbe4DH6qhYW7W54J8Kdqbj6Hq/GVxq3eFw15BMfkbDXNwJaWDXOjuwmpxDu7JKjMzfDdgczv8rOH8rLoK7hpUDIMh7s09x+PAMe6qbTvigKJrVTaBjUfB1fE6Xf2fAiqyAbepPk/mkV9YP+dbEYxt8oYzQQcsU7oEoV+0hg9BKMDoWopBNffrliFxC7qWlurpF8Rj5UrV5maXDqa090EUne0xxyhTrPkCdJc3DtDr+7VwAEzeBCHa2wdby3wE/OU6WxBWk+p3S35lSxzQzAICU046Jnazwv6BT09GBpGRjDITaJugon9aJjwvx9BRxrWdK/udF2Sxhxr/
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(122000001)(6916009)(66946007)(38100700002)(2616005)(54906003)(76116006)(5660300002)(91956017)(6486002)(86362001)(66556008)(66476007)(2906002)(6506007)(6512007)(316002)(83380400001)(64756008)(38070700005)(8676002)(71200400001)(33656002)(36756003)(186003)(8936002)(26005)(508600001)(53546011)(66446008)(4326008)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?K+fUpyfEJUEHr5hQ56HviH8wl9qW4CUC7z0xvE1euXzWNDnw4Rtn3Oauzzou?=
 =?us-ascii?Q?NOk/oB4QHh3kp1HPmMZxkBJPPvFhp9yuEe8vj03GhI/edJnKatYORuXSQCKA?=
 =?us-ascii?Q?Ji1S1kXR5vVomeF20rK+5T2CaydnEDvvkNDpe7QPsixJtQhuelDOTBhEhRT9?=
 =?us-ascii?Q?hkUX+ZWjqD1ZEWwx9eON1RTf4zOq/mf0rIX0AbaZzDfGgZdkyAWQIlSoDLb0?=
 =?us-ascii?Q?dIcx2TPlM2W6pR9oUdn56b6xAB0myT4PyyHCFAtnkEUYgWt9LserU2yOBxJv?=
 =?us-ascii?Q?sgaEZ33RjpC80hE0yzVDxjEVwF+cZkNd89jf7ch4a3z+SB3I3tB7YOIMf9YM?=
 =?us-ascii?Q?HsJj01xFjMyB8WPrbq7fx31zglqWlvnbKzg5jQCcEPBGfHW3tm1jUU/J92hn?=
 =?us-ascii?Q?38951Um3kJixrdcoKpNdouQwOIKneRkg/0qAdh1fZN9nKfBi9gCxQJxh/gNj?=
 =?us-ascii?Q?EjtTzLYJcCugQjta5bSyF8QcD5EPt2MQxW6UcMcD9qc8pCL5xnLbGwNVJyXm?=
 =?us-ascii?Q?dq3leFYA6oq6Ofsag46IvcerZDLdrTn9mNTycq0L71fXYmTyKu+5/1SL11dU?=
 =?us-ascii?Q?LfNq3VWof4nhI7+LnlpgY3u+bGzpnhHbIW3sCUI/psHJCrov72NOLMeHZqG6?=
 =?us-ascii?Q?a8Nqa8m2mPaxlApF5Ush0z89rcx3rQfS88gPgmZb6e6mClsjZWmE6jLuMY/x?=
 =?us-ascii?Q?TdaOZvWnRApqZyFo2UorOOBuz4KQXwozpxflFzXjcLQTxz1Nm0rZa5F9jDIA?=
 =?us-ascii?Q?DRykN8XGsfzGZefRIgwQoOAyhAauG79aIiA8XBVG6+ArtOBS6Wx8u5yF7oyJ?=
 =?us-ascii?Q?/S2YzeOz4FMYwyNcFBpANy3dNT6+nqYYMw0nH0nH/h8vc5gPvZnWzBC3i1F4?=
 =?us-ascii?Q?sjkRiv9f6ftCqYQ9ygshEHec5465jrGgSYeL8IoTZv3/W2SbJgQQkfq2FIDr?=
 =?us-ascii?Q?/DvH25sQeQonkenIbMFmJwJFTLyKt/Dl754UunkkHBIbOOmfuCYSFPtnXabE?=
 =?us-ascii?Q?UfcEKhjhoBgdvBBrLNeOKZAEQYl+N5xlRVwnsjEHhfV9OKZ3A/FZJfeBs/bi?=
 =?us-ascii?Q?cE1DTyjFlqspEXizd7pKx7+dTKzbIr+Mc9+nyeGWETvrXt1I+bSU5mNX90lT?=
 =?us-ascii?Q?3yx9AsDFtgGHiO3mQkEJLUe7Y7NWQRQoI09Dn9Xhifvs577EaBZ8q8foI6ad?=
 =?us-ascii?Q?GwAwBkAnOKarGl3pmZgUgjAvVk/a891T4rtMcmC7ckZiDev0j5O9T0EABoyY?=
 =?us-ascii?Q?TYGag0/XuY1xLkvCJqzyZv/dSCTKz2iJ0tN7sMlAVfJiFy2+Bi3FZMF0XCao?=
 =?us-ascii?Q?9e761tBlywb5BFa1yceoOrmC?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <EFBA3D18046E674699655B5AE50EE3FE@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f50b3a5-06d4-44c2-0e70-08d993f23138
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Oct 2021 17:51:06.5875
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eDUxO5n8wAtDYGBMefO8hvn0dO4BalOgfZC1mDI9F1yVgG7SjO42SjIEHswYtD4oVN7iK9PAjAVK1wFN+jk2AQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2758
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10143 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=869 suspectscore=0
 malwarescore=0 bulkscore=0 phishscore=0 adultscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110200100
X-Proofpoint-ORIG-GUID: XSnZmmRZu5lmH4z32Y_k0hEHKCK0Oz-s
X-Proofpoint-GUID: XSnZmmRZu5lmH4z32Y_k0hEHKCK0Oz-s
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


> On Oct 20, 2021, at 1:24 PM, Steve Dickson <steved@redhat.com> wrote:
>=20
> Hey!
>=20
> On 10/20/21 12:00, Chuck Lever III wrote:
>>> On Oct 20, 2021, at 11:54 AM, J. Bruce Fields <bfields@fieldses.org> wr=
ote:
>>>=20
>>> knfsd has supported server-to-server copy for a couple years (since
>>> 5.5).  You have set a module parameter to enable it.  I'm getting asked
>>> when we could turn that parameter on by default.
>>>=20
>>> I've got a couple vague criteria: one just general maturity, the other =
a
>>> security question:
>>>=20
>>> 1. General maturity: the only reports I recall seeing are from testers.
>>> Is anyone using this?  Does it work for them?  Do they find a benefit?
>>> Maybe we could turn it on by default in one distro (Fedora?) and promot=
e
>>> it a little and see what that turns up?
>=20
>> But wrt the maturity question, is the work finished? Or,
>> perhaps a better question is do we have a minimum viable
>> product here that can be enabled, or is more work needed
>> to meet even that bar?
> I've been testing it and it seems to be pretty solid.

Well I was more interested in knowing if the capability
is in a state where it is now useful to users rather
than just being a prototype for a new protocol element.

Along with having tests that QE teams can run, we probably
also need to know whether there is adequate documentation.


--
Chuck Lever



